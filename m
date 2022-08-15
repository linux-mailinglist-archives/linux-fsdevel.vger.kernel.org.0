Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD1595264
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 08:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiHPGKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 02:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiHPGKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:10:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3D6A98DD;
        Mon, 15 Aug 2022 16:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98A8DB8124E;
        Mon, 15 Aug 2022 23:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC64C433C1;
        Mon, 15 Aug 2022 23:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660607503;
        bh=BeW1orVomShlhYcBAjKKGjagqLCAQpws3J+NC4g2hME=;
        h=From:To:Cc:Subject:Date:From;
        b=TrivuLOkxHxPfwsnHACeReH/1VdknVQsfy5hmeruzqK4bWYGxj6ofnxdjdaPQoBk8
         Fyf0apfS6yA0Asj7sGShx3myy96y6e7HZuPXkUhj35RDznqskOGPGQ8hY78DZeoIba
         laxy1vqVXP/PzsJUVuub3utAcRA9N/LaDD34DXNCzt7dAF40H4GFcMD0sCOWrragdh
         QwtncR0MihrPf9P8QbT0tS+pYgHffg3glP/HarbZx4HYpR9rbwYqss7bIVZyDHhCsu
         ncYFUtKH6GSFhyZn5FarB2HsR2J7yqi9oHQxICIDZsahhnwMsLGbxb+MD97leIDOGM
         DpYOBENQusP9g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 0/2] ext4, f2fs: stop using PG_error for fscrypt and fsverity
Date:   Mon, 15 Aug 2022 16:50:50 -0700
Message-Id: <20220815235052.86545-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series changes ext4 and f2fs to stop using PG_error to track
decryption and verity errors.  This is a step towards freeing up
PG_error for other uses, as discussed at
https://lore.kernel.org/linux-fsdevel/Yn10Iz1mJX1Mu1rv@casper.infradead.org

Note: due to the interdependencies with fs/crypto/ and fs/verity/,
I couldn't split this up into separate patches for each filesystem.
I'd appreciate Acks from the ext4 and f2fs maintainers so that I can
take these patches.  Otherwise I'm not sure how to move them forward.

Changed v1 => v2:
   - Rebased onto v6.0-rc1 and resolved conflicts in f2fs.

Eric Biggers (2):
  fscrypt: stop using PG_error to track error status
  fsverity: stop using PG_error to track error status

 fs/crypto/bio.c         | 16 +++++++----
 fs/ext4/readpage.c      | 16 +++++------
 fs/f2fs/compress.c      | 64 ++++++++++++++++++++---------------------
 fs/f2fs/data.c          | 64 +++++++++++++++++++++++------------------
 fs/verity/verify.c      | 12 ++++----
 include/linux/fscrypt.h |  5 ++--
 6 files changed, 93 insertions(+), 84 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1

