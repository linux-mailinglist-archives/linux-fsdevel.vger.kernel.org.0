Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3059652C7FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 01:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiERXxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 19:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiERXxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 19:53:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4860A96;
        Wed, 18 May 2022 16:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26E76B81C03;
        Wed, 18 May 2022 23:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76052C385A9;
        Wed, 18 May 2022 23:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652918008;
        bh=urChUY7g9muzenao6Op/35xCF3MRcXpVDil5q1s0Oy4=;
        h=From:To:Cc:Subject:Date:From;
        b=OV61lWEayn3LYEHqqYjdbT4rDnSYkojA/uBcYiviKrLQosTqoljlBxdyQuag4D38t
         QD3252d92imOW+XVDTj0qjrOJ+PoJ1FHyjBnZPYlsp6uvQj29AfMW/W9l/rAHYKyz1
         EIhGcaMmM0JN4aG/HcXCFiYrX6jbcm36zLqiheYnoEV/n8g93nWWuHGTHlbljGZIyW
         DwtikEg30uOxeLh6dEvCADQkuEKd5jCOvDNzz3suRYVpoI0hAgf8LBxjbIdG8fLEMv
         52a1BO/Ce+DjZrrYEzZcYdQZR3Zhx1bno/f/yNbVWXKZAiVyJNYG5rA6eoaqmksXog
         K4HSm1NvPH8FA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [RFC PATCH v2 0/7] make statx() return I/O alignment information
Date:   Wed, 18 May 2022 16:50:04 -0700
Message-Id: <20220518235011.153058-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This patchset applies to v5.18-rc7.

No changes since v1, which I sent a few months ago; I'm resending this
because people seem interested in it again
(https://lore.kernel.org/r/20220518171131.3525293-1-kbusch@fb.com).

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


base-commit: 42226c989789d8da4af1de0c31070c96726d990c
-- 
2.36.1

