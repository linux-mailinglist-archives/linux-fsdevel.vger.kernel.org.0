Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE084B1E4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 07:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbiBKGN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 01:13:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiBKGN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:13:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D2225CC;
        Thu, 10 Feb 2022 22:13:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ECC561888;
        Fri, 11 Feb 2022 06:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787EFC340E9;
        Fri, 11 Feb 2022 06:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644560006;
        bh=BKA5jTy6pTvT/2eTBFcXj02nmCgqitj7KJJ1UiB3EpU=;
        h=From:To:Cc:Subject:Date:From;
        b=Iu5/Sa4pfkEpR9o0eBTJ1V30YT6bCxpLasszI/CU4T8A42NiY45wXgX3h3GybGgiB
         NAzGvdsxlLAolhxEa7IsbAiY3JjF3ewzNeuqCqsWmfxz6wc3ZOL7JKTGom90zAEl8N
         02IlrBVB6LknF2DDc4ILNOZuXFcduDCnLKPlC5KocAJzuYaaARaxYBTpvdGwinClME
         LQ3TYwsVH/k3NmkATxDZxPMWHcbSMYINM2CkMcygXTpniHEZDxOiqq093qz2s0tLNr
         sAvQyo3kbKf/HAmxOt+ukiAviUgVZjakrR0xmE5nlVlNkDjZ4k2/fqvceH/ietEPU7
         N7xrtFLmVK1Jw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/7] make statx() return I/O alignment information
Date:   Thu, 10 Feb 2022 22:11:51 -0800
Message-Id: <20220211061158.227688-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset makes the statx() system call return I/O alignment
information, roughly following the design that was suggested at
https://lore.kernel.org/linux-fsdevel/20220120071215.123274-1-ebiggers@kernel.org/T/#u

This feature solves two problems: (a) it allows userspace to determine
when a file supports direct I/O, and with what alignment restrictions;
and (b) it allows userspace to determine the optimum I/O alignment for a
file.  For more details, see patch 1.

This is an RFC.  I'd greatly appreciate any feedback on the UAPI, as
that obviously needs to be gotten right from the beginning.  E.g., does
the proposed set of fields make sense?  Am I including the right
information in stx_offset_align_optimal?

Patch 1 adds the VFS support for STATX_IOALIGN.  The remaining patches
wire it up to ext4 and f2fs.  Support for other filesystems can be added
later.  We could also support this on block device files; however, since
block device nodes have different inodes from the block devices
themselves, it wouldn't apply to statx("/dev/$foo") but rather just to
'fd = open("/dev/foo"); statx(fd)'.  I'm unsure how useful that would be.

Note, f2fs has one corner case where DIO reads are allowed but not DIO
writes.  The proposed statx fields can't represent this.  My proposal
(patch 5) is to just eliminate this case, as it seems much too weird.
But I'd appreciate any feedback on that part.

This patchset applies on top of my other patchset
"[PATCH v11 0/5] add support for direct I/O with fscrypt using blk-crypto"
(https://lore.kernel.org/linux-fsdevel/20220128233940.79464-1-ebiggers@kernel.org/T/#u),
which can be retrieved from branch "master" of
https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git.  The statx()
patchset could be a standalone patchset; however, I wanted to show that
it will work properly on encrypted files, and the statx() patchset
probably will take longer due to the new UAPI.

Eric Biggers (7):
  statx: add I/O alignment information
  fscrypt: change fscrypt_dio_supported() to prepare for STATX_IOALIGN
  ext4: support STATX_IOALIGN
  f2fs: move f2fs_force_buffered_io() into file.c
  f2fs: don't allow DIO reads but not DIO writes
  f2fs: simplify f2fs_force_buffered_io()
  f2fs: support STATX_IOALIGN

 fs/crypto/inline_crypt.c  | 48 +++++++++++++++---------------
 fs/ext4/ext4.h            |  1 +
 fs/ext4/file.c            | 10 +++----
 fs/ext4/inode.c           | 31 ++++++++++++++++++++
 fs/f2fs/f2fs.h            | 45 -----------------------------
 fs/f2fs/file.c            | 61 ++++++++++++++++++++++++++++++++++++++-
 fs/stat.c                 |  3 ++
 include/linux/fscrypt.h   |  7 ++---
 include/linux/stat.h      |  3 ++
 include/uapi/linux/stat.h |  9 ++++--
 10 files changed, 136 insertions(+), 82 deletions(-)


base-commit: cdaa1b1941f667814300799ddb74f3079517cd5a
-- 
2.35.1

