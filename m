Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C296E66561D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 09:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjAKIcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 03:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjAKIcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:32:06 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2022A1A7;
        Wed, 11 Jan 2023 00:32:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZMeLoV_1673425918;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZMeLoV_1673425918)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 16:31:59 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/7] erofs: support page cache sharing between EROFS images in fscache mode
Date:   Wed, 11 Jan 2023 16:31:51 +0800
Message-Id: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

changes since RFC:
- patch 2: allocate an anonymous file (realfile) when file is opened,
  rather than allocate a single anonymous file for each blob at mount
  time
- patch 7: add 'sharecache' mount option to control if page cache
  sharing shall be enabled

RFC: https://lore.kernel.org/all/20230106125330.55529-1-jefflexu@linux.alibaba.com/


[Background]
=============
Erofs already supports chunk deduplication across different images to
minimize disk usage since v6.1.  Furthermore, we can make inodes among
different images share page cache for these deduplicated chunks to
reduce the memory usage.  This shall be much usable in container
scenarios as deduplication is requisite for container images.


[Implementation]
================
This is achieved by managing page cache of deduplicated chunks in
blob's address space.  In this way, all inodes sharing the deduplicated
chunk will refer to and share the page cache in the blob's address
space.


[Restriction]
==============
The page cache sharing feature also supports .mmap().  The reverse
mapping requires that one vma can not be shared among inodes and can
be linked to only one inode.  As the vma will be finally linked to the
blob's address space when page cache sharing enabled, the restriction of
the reverse mapping actually requires that the mapped file area can not
be mapped to multiple blobs.  Thus page cache sharing can only be
enabled for those files mapped to one blob.

The chunk based data layout guarantees that a chunk will not cross the
device (blob) boundary.  Thus in chunk based data layout, those files
smaller than the chunk size shall be guaranteed to be mapped to one
blob.  As chunk size is tunable at a per-file basis, this restriction
can be relaxed at image building phase.  As long as we ensure that the
file can not be deduplicated, the file's chunk size can be set to a
reasonable value larger than the file size, so that the file contains
only one chunk, in which case page cache sharing feature can be enabled
on this file later.


[Effect]
========
The final optimization result of this feature depends on the following
factors:

1. The number of deduplicated (shared) chunks.  Images sharing most of
the layers (e.g. a base image and v1 image based on the base image) will
achieve better optimization.

2. As the restriction mentioned above, the number of files for which
page cache sharing can ben enabled among the files accessed.


I test the workload of starting up Tensorflow, which will access quite
many (~5K) files among the startup phase.  I get the base image of
Tensorflow from [1] and build a new image (e.g. v1 image) on top of this
base image.

Since the image got from [1] is in OCI format, I have to convert it to
erofs format with buildkit[2], with default chunk size of 1MB.

I run containers from these two images with containerd (base image first,
v2 image secondly).  The (page cache) memory usage of the rootfs
(container image) is shown as below:

			| page cache sharing	| page cache sharing
			| disabled		| enabled
------------------------|-----------------------|-------------------
First container       	|      			|
page cache usage (MB) 	| 150      		| 150
------------------------+-----------------------|-------------------
Second container      	|      			|
page cache usage (MB) 	| 150			| 7

It can be seen that most (~95%, 143MB/150MB) memory usage reduced under
this workload (when starting following containers sharing container image
layers).

The remained 7MB memory usage is consumed by directories, since page
cache sharing is enabled only for regular files in this RFC
implementation.


[1] docker.io/tensorflow/tensorflow:2.10.0
[2] https://github.com/moby/buildkit


Jingbo Xu (7):
  erofs: remove unused device mapping in the meta routine
  erofs: unify anonymous inodes for blob
  erofs: allocate anonymous file of blob for page cache sharing
  erofs: implement .read_iter for page cache sharing
  erofs: implement .mmap for page cache sharing
  erofs: add helper checking if page cache sharing shall be enabled
  erofs: introduce 'sharecache' mount option

 Documentation/filesystems/erofs.rst |   2 +
 fs/erofs/fscache.c                  | 271 +++++++++++++++++++++-------
 fs/erofs/inode.c                    |   4 +
 fs/erofs/internal.h                 |  34 +++-
 fs/erofs/super.c                    |  15 ++
 5 files changed, 254 insertions(+), 72 deletions(-)

-- 
2.19.1.6.gb485710b

