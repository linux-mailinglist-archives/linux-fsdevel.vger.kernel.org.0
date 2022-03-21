Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E34E1F9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 05:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbiCUEv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 00:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiCUEv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:51:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B58E5714D;
        Sun, 20 Mar 2022 21:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3B64B80F02;
        Mon, 21 Mar 2022 04:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB4DC340E8;
        Mon, 21 Mar 2022 04:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647838230;
        bh=wAeBu2wVEWNd56Ntd/skPbNlVoTIPyziMX0Vn/MA9BE=;
        h=Date:From:To:Cc:Subject:From;
        b=PO07ElUgyX0HLnjM792j3I+Uw0JgvpqFcopDw0zvhkuC3iEtN6NYedGVXsJmrOJGL
         GlY+u5zmAtw9ZOFXPU7JcCzFPsg4bo7yjJXHfaSTbbHxp94tjGWx3KSbgDS7UJC69H
         GGOd+ez+2utQX8K6bSmoqOxjcBDqhzl8ldgmmjCM2/KWfUN3I1WCUQ7n4uI/o7OvzC
         oloms+pm4cJHKP5fohcQIhjZIEJp+M1lSD0s3wjieppaehu1R+UMdmXsoc9Q2b7OZM
         UUUn2i+j2+J6toQPzD/HJnCeMsyDelDjJBffo/oQv1SI6TXqgiTh40xtlWqR7eWEGv
         zl/XViTJPIcHQ==
Date:   Sun, 20 Mar 2022 21:50:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 5.18
Message-ID: <YjgEC8Nw9PDmdY0O@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to cdaa1b1941f667814300799ddb74f3079517cd5a:

  fscrypt: update documentation for direct I/O support (2022-02-08 11:02:18 -0800)

----------------------------------------------------------------

Add support for direct I/O on encrypted files when blk-crypto (inline
encryption) is being used for file contents encryption.

There will be a merge conflict with the block pull request in
fs/iomap/direct-io.c, due to some bio interface cleanups.  The merge
resolution is straightforward and can be found in linux-next.

----------------------------------------------------------------
Eric Biggers (5):
      fscrypt: add functions for direct I/O support
      iomap: support direct I/O with fscrypt using blk-crypto
      ext4: support direct I/O with fscrypt using blk-crypto
      f2fs: support direct I/O with fscrypt using blk-crypto
      fscrypt: update documentation for direct I/O support

 Documentation/filesystems/fscrypt.rst | 25 +++++++++-
 fs/crypto/crypto.c                    |  8 +++
 fs/crypto/inline_crypt.c              | 93 +++++++++++++++++++++++++++++++++++
 fs/ext4/file.c                        | 10 ++--
 fs/ext4/inode.c                       |  7 +++
 fs/f2fs/data.c                        |  7 +++
 fs/f2fs/f2fs.h                        |  6 ++-
 fs/iomap/direct-io.c                  |  6 +++
 include/linux/fscrypt.h               | 18 +++++++
 9 files changed, 173 insertions(+), 7 deletions(-)
