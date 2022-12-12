Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B891649872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 05:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiLLEqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 23:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiLLEp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 23:45:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA6E64E9;
        Sun, 11 Dec 2022 20:45:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A9D560EAB;
        Mon, 12 Dec 2022 04:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4021DC433D2;
        Mon, 12 Dec 2022 04:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670820356;
        bh=ZiPqywrfVYJKyTMOBz5ADrSOCtd+XOKFfeu5S1nMah4=;
        h=Date:From:To:Cc:Subject:From;
        b=HHl82Mya2ZR0wKm/58rpz/ANETzs4T9/LlUcAtG6Jj/kdDcSPMy3nUSluiVp8JwXG
         5Zx/BL/ckxlDkCXUPLL9ML9luXQVYAs6fZ+ytcqXBYsADAqzIE7i3GKmkbTrSW/Kw2
         3XWKMbBePAmK7rN4+xXQ8ZaI0tsddiJh0pnmP8PZueq0XoVAbGF6TIgTBuagMf3cb6
         Lct0ctXRuaxw6z9+1GJaxO70Dsudj2HbinzikLEoff2C/Ux+gZAKDKEfXZsivs/eKS
         MgwgMj5QowZcxObgBI0FlnIbym4sDn6ocMgkng+dpntHP+WBUO09whZTmB+UJ6+foK
         l2I392lOG5/3w==
Date:   Sun, 11 Dec 2022 20:45:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 6.2
Message-ID: <Y5ayAsXkTF3jK13s@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 41952551acb405080726aa38a8a7ce317d9de4bb:

  fscrypt: add additional documentation for SM4 support (2022-12-02 10:43:00 -0800)

----------------------------------------------------------------

This release adds SM4 encryption support, contributed by Tianjia Zhang.
SM4 is a Chinese block cipher that is an alternative to AES.

I recommend against using SM4, but (according to Tianjia) some people
are being required to use it.  Since SM4 has been turning up in many
other places (crypto API, wireless, TLS, OpenSSL, ARMv8 CPUs, etc.), it
hasn't been very controversial, and some people have to use it, I don't
think it would be fair for me to reject this optional feature.

Besides the above, there are a couple cleanups.

----------------------------------------------------------------
Eric Biggers (4):
      fscrypt: pass super_block to fscrypt_put_master_key_activeref()
      fscrypt: add comment for fscrypt_valid_enc_modes_v1()
      fscrypt: remove unused Speck definitions
      fscrypt: add additional documentation for SM4 support

Tianjia Zhang (2):
      blk-crypto: Add support for SM4-XTS blk crypto mode
      fscrypt: Add SM4 XTS/CTS symmetric algorithm support

 Documentation/filesystems/fscrypt.rst |  7 +++++++
 block/blk-crypto.c                    |  6 ++++++
 fs/crypto/fscrypt_private.h           | 13 ++++---------
 fs/crypto/keyring.c                   | 14 ++++++--------
 fs/crypto/keysetup.c                  | 17 ++++++++++++++++-
 fs/crypto/policy.c                    | 12 ++++++++++++
 include/linux/blk-crypto.h            |  1 +
 include/uapi/linux/fscrypt.h          |  4 ++--
 8 files changed, 54 insertions(+), 20 deletions(-)
