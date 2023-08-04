Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F9B7704AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjHDP3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 11:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjHDP23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C85649F2;
        Fri,  4 Aug 2023 08:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E50E362078;
        Fri,  4 Aug 2023 15:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500CCC433CD;
        Fri,  4 Aug 2023 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691162892;
        bh=DVXwT5tCREZmgRPlMgRs+TLlvZ3cdiOfgy0MWcFC0bI=;
        h=Date:From:To:Cc:Subject:From;
        b=ccG1+r8awqW6X+EpTu1pTaMPLVg8kpLC5j0c2JsIKCMTarhBo5CCASIDLAysEkomL
         Z2jIfQRCzn8e99TF0hGqhAs+BuL0JtL/vTEIPEQvjZ08XpAhqwwXPT2WpeZV8rU7ri
         OBVBJmIeaaFPUpOAYtWxB6SY0vDMK5punO7hNswdifgmr1UBN3e1wjhqKhytIos1v5
         2b010L/xAXKFaetlCEe4CmaF3VBN/2BkXbrjoU4bbpfBd2sFJB7D7vdZRqpTFhy9kz
         3eRN1IP+E3iwGrIc4o8P+E249lJPlpy7SInTQThC3ndlGgKvJaQ/W7zV51ku3uX95L
         yfouofYWzCiyg==
Date:   Fri, 4 Aug 2023 08:28:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     dchinner@redhat.com, hch@infradead.org, hch@lst.de, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        mcgrof@kernel.org, ruansy.fnst@fujitsu.com
Subject: [ANNOUNCE] xfs-linux: vfs-6.6-merge updated to ce85a1e04645
Message-ID: <169116275623.3187159.16862410128731457358.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The vfs-for-next branch of the xfs-linux repository at:

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.  This is the long-promised patchset to allow the
kernel to freeze the fs while guaranteeing that userspace cannot
unfreeze the fs; and the first user of that functionality (online fsck).
This will enable Luis' auto-freeze-on-suspend patches, and Shiyang's
pmem pre-removal hook.

The new head of the vfs-for-next branch is commit:

ce85a1e04645 xfs: stabilize fs summary counters for online fsck

3 new commits:

Darrick J. Wong (3):
[880b9577855e] fs: distinguish between user initiated freeze and kernel initiated freeze
[59ba4fdd2d1f] fs: wait for partially frozen filesystems
[ce85a1e04645] xfs: stabilize fs summary counters for online fsck

Code Diffstat:

Documentation/filesystems/vfs.rst |   6 +-
block/bdev.c                      |   8 +-
fs/f2fs/gc.c                      |   8 +-
fs/gfs2/super.c                   |  12 ++-
fs/gfs2/sys.c                     |   4 +-
fs/ioctl.c                        |   8 +-
fs/super.c                        | 113 ++++++++++++++++++++---
fs/xfs/scrub/fscounters.c         | 188 ++++++++++++++++++++++++++++++--------
fs/xfs/scrub/scrub.c              |   6 +-
fs/xfs/scrub/scrub.h              |   1 +
fs/xfs/scrub/trace.h              |  26 ++++++
include/linux/fs.h                |  15 ++-
12 files changed, 321 insertions(+), 74 deletions(-)
