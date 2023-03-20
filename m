Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93686C2337
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 21:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCTU4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 16:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCTU41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:56:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF7846A2;
        Mon, 20 Mar 2023 13:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E685161812;
        Mon, 20 Mar 2023 20:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15DCC4339B;
        Mon, 20 Mar 2023 20:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679345779;
        bh=TIisIt10fTBip8aXju7/P4H6FODyu04/HbhhX49wO9c=;
        h=Date:From:To:Cc:Subject:From;
        b=U5f18BUkAyOeemq+22V7ydwhU6CkvKYt0o8epjIrF0czmcfDjiO6l/qH1Dyj1kzrG
         QUAI3mZzKD1ahZyJY/KWPlbSVe81sqXAgnCpIfAz7MtASKADACYryCU8cSEgZecc9j
         zlehdT5gmVpt7G0PLyEOhsCKfSvds1PuNphhyQR+qmiQ7CLu2Sr4pjgROgcYXoVIs3
         j7wG3QUllgK7yn6mDxn7RRzvw4shjIilMNewkePzbuVLGayq9mmz8FotoZES+8VJBZ
         prpx8rnFWGiQOwqVeiOBeP6SSJ8xPJJ0C48++C7IVdHdUPzetM8UTP6LNoz6iPVulj
         CkKA5jzVtGvrQ==
Date:   Mon, 20 Mar 2023 13:56:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt fix for v6.3-rc4
Message-ID: <20230320205617.GA1434@sol.localdomain>
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

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 4bcf6f827a79c59806c695dc280e763c5b6a6813:

  fscrypt: check for NULL keyring in fscrypt_put_master_key_activeref() (2023-03-18 21:08:03 -0700)

----------------------------------------------------------------

Fix a bug where when a filesystem was being unmounted, the fscrypt
keyring was destroyed before inodes have been released by the Landlock
LSM.  This bug was found by syzbot.

----------------------------------------------------------------
Eric Biggers (3):
      fscrypt: destroy keyring after security_sb_delete()
      fscrypt: improve fscrypt_destroy_keyring() documentation
      fscrypt: check for NULL keyring in fscrypt_put_master_key_activeref()

 fs/crypto/keyring.c | 23 +++++++++++++----------
 fs/super.c          | 15 ++++++++++++---
 2 files changed, 25 insertions(+), 13 deletions(-)
