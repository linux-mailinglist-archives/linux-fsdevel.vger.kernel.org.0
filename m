Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9466B6B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 05:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjAPEp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Jan 2023 23:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjAPEoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:44:54 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB917903C;
        Sun, 15 Jan 2023 20:44:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZc75Er_1673844287;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZc75Er_1673844287)
          by smtp.aliyun-inc.com;
          Mon, 16 Jan 2023 12:44:49 +0800
Message-ID: <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
Date:   Mon, 16 Jan 2023 12:44:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com
References: <cover.1673623253.git.alexl@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <cover.1673623253.git.alexl@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexander and folks,

On 2023/1/13 23:33, Alexander Larsson wrote:
> Giuseppe Scrivano and I have recently been working on a new project we
> call composefs. This is the first time we propose this publically and
> we would like some feedback on it.
> 
> At its core, composefs is a way to construct and use read only images
> that are used similar to how you would use e.g. loop-back mounted
> squashfs images. On top of this composefs has two fundamental
> features. First it allows sharing of file data (both on disk and in
> page cache) between images, and secondly it has dm-verity like
> validation on read.
> 
> Let me first start with a minimal example of how this can be used,
> before going into the details:
> 
> Suppose we have this source for an image:
> 
> rootfs/
> ├── dir
> │   └── another_a
> ├── file_a
> └── file_b
> 
> We can then use this to generate an image file and a set of
> content-addressed backing files:
> 
> # mkcomposefs --digest-store=objects rootfs/ rootfs.img
> # ls -l rootfs.img objects/*/*
> -rw-------. 1 root root   10 Nov 18 13:20 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
> -rw-------. 1 root root   10 Nov 18 13:20 objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
> -rw-r--r--. 1 root root 4228 Nov 18 13:20 rootfs.img
> 
> The rootfs.img file contains all information about directory and file
> metadata plus references to the backing files by name. We can now
> mount this and look at the result:
> 
> # mount -t composefs rootfs.img -o basedir=objects /mnt
> # ls  /mnt/
> dir  file_a  file_b
> # cat /mnt/file_a
> content_a
> 
> When reading this file the kernel is actually reading the backing
> file, in a fashion similar to overlayfs. Since the backing file is
> content-addressed, the objects directory can be shared for multiple
> images, and any files that happen to have the same content are
> shared. I refer to this as opportunistic sharing, as it is different
> than the more course-grained explicit sharing used by e.g. container
> base images.
> 


I'd like to say sorry about comments in LWN.net article.  If it helps
to the community,  my own concern about this new overlay model was
(which is different from overlayfs since overlayfs doesn't have
  different permission of original files) somewhat a security issue (as
I told Giuseppe Scrivano before when he initially found me on slack):

As composefs on-disk shown:

struct cfs_inode_s {

         ...

	u32 st_mode; /* File type and mode.  */
	u32 st_nlink; /* Number of hard links, only for regular files.  */
	u32 st_uid; /* User ID of owner.  */
	u32 st_gid; /* Group ID of owner.  */

         ...
};

It seems Composefs can override uid / gid and mode bits of the
original file

    considering a rootfs image:
      ├── /bin
      │   └── su

/bin/su has SUID bit set in the Composefs inode metadata, but I didn't
find some clues if ostree "objects/abc" could be actually replaced
with data of /bin/sh if composefs fsverity feature is disabled (it
doesn't seem composefs enforcely enables fsverity according to
documentation).

I think that could cause _privilege escalation attack_ of these SUID
files is replaced with some root shell.  Administrators cannot keep
all the time of these SUID files because such files can also be
replaced at runtime.

Composefs may assume that ostree is always for such content-addressed
directory.  But if considering it could laterly be an upstream fs, I
think we cannot always tell people "no, don't use this way, it doesn't
work" if people use Composefs under an untrusted repo (maybe even
without ostree).

That was my own concern at that time when Giuseppe Scrivano told me
to enhance EROFS as this way, and I requested him to discuss this in
the fsdevel mailing list in order to resolve this, but it doesn't
happen.

Otherwise, EROFS could face such issue as well, that is why I think
it needs to be discussed first.


> The next step is the validation. Note how the object files have
> fs-verity enabled. In fact, they are named by their fs-verity digest:
> 
> # fsverity digest objects/*/*
> sha256:02927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
> sha256:cc3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
> 
> The generated filesystm image may contain the expected digest for the
> backing files. When the backing file digest is incorrect, the open
> will fail, and if the open succeeds, any other on-disk file-changes
> will be detected by fs-verity:
> 
> # cat objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
> content_a
> # rm -f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
> # echo modified > objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
> # cat /mnt/file_a
> WARNING: composefs backing file '3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f' unexpectedly had no fs-verity digest
> cat: /mnt/file_a: Input/output error
> 
> This re-uses the existing fs-verity functionallity to protect against
> changes in file contents, while adding on top of it protection against
> changes in filesystem metadata and structure. I.e. protecting against
> replacing a fs-verity enabled file or modifying file permissions or
> xattrs.
> 
> To be fully verified we need another step: we use fs-verity on the
> image itself. Then we pass the expected digest on the mount command
> line (which will be verified at mount time):
> 
> # fsverity enable rootfs.img
> # fsverity digest rootfs.img
> sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 rootfs.img
> # mount -t composefs rootfs.img -o basedir=objects,digest=da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 /mnt
> 


It seems that Composefs uses fsverity_get_digest() to do fsverity
check.  If Composefs uses symlink-like payload to redirect a file to
another underlayfs file, such underlayfs file can exist in any other
fses.

I can see Composefs could work with ext4, btrfs, f2fs, and later XFS
but I'm not sure how it could work with overlayfs, FUSE, or other
network fses.  That could limit the use cases as well.

Except for the above, I think EROFS could implement this in about
300~500 new lines of code as Giuseppe found me, or squashfs or
overlayfs.

I'm very happy to implement such model if it can be proved as safe
(I'd also like to say here by no means I dislike ostree) and I'm
also glad if folks feel like to introduce a new file system for
this as long as this overlay model is proved as safe.

Hopefully it helps.

Thanks,
Gao Xiang
