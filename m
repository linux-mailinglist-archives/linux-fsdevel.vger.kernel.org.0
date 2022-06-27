Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAFE55CCDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiF0Gv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 02:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiF0Gv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:51:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1262661;
        Sun, 26 Jun 2022 23:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C9F8B80ED9;
        Mon, 27 Jun 2022 06:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17B6C341C8;
        Mon, 27 Jun 2022 06:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656312713;
        bh=EMTvjrRTRYMQ8NvdZxMXcH2NZ3gwtUoi5uAa917YgYU=;
        h=From:To:Cc:Subject:Date:From;
        b=OdEhO/MAo3AFkdbctkb6BCcbEyvLcD4iwBI77ZyUX3ZvdU0F7DllZKYyE8gkP9WQK
         ZGDAJVOJyTuwvF2MbvzhsZgXBQij7rXRYn1v5P6TFggka6ut+B4Zw6Fx5HmirG16y7
         dNR3bAi/c+bMrQDQeCbGzDmA3eW2VCH+5wv9hyNjiI/25AXmxSSznadBvtfeWDqAm5
         GDaD639zJe0rDxwWEEnNvT5Il6LpwGCgDvL1eH8knm3S4IrGL/WbxEc+8BHoVWRR9/
         iz6Yv8bWPUxUtYKcaalGZHO52oCjg34LJIGiAKwQJSECgAohNEvxYHKe5gcS5MJHWY
         +s0S6Cw+PBbzQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/2] ext4, f2fs: stop using PG_error for fscrypt and fsverity
Date:   Sun, 26 Jun 2022 23:50:48 -0700
Message-Id: <20220627065050.274716-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Note: due to the interdependencies with fs/crypto/ and fs/verity/, I
couldn't split this up into separate patches for each filesystem.

Eric Biggers (2):
  fscrypt: stop using PG_error to track error status
  fsverity: stop using PG_error to track error status

 fs/crypto/bio.c         | 16 +++++++----
 fs/ext4/readpage.c      | 16 +++++------
 fs/f2fs/compress.c      | 61 ++++++++++++++++++++---------------------
 fs/f2fs/data.c          | 60 +++++++++++++++++++++-------------------
 fs/verity/verify.c      | 12 ++++----
 include/linux/fscrypt.h |  5 ++--
 6 files changed, 88 insertions(+), 82 deletions(-)


base-commit: 0840a7914caa14315a3191178a9f72c742477860
-- 
2.36.1

