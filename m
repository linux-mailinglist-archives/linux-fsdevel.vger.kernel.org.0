Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF57447C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 09:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGAHgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 03:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjGAHfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:35:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13E8E50;
        Sat,  1 Jul 2023 00:35:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a1ebb79579so1965836b6e.3;
        Sat, 01 Jul 2023 00:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688196937; x=1690788937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D04xZI5Sg1R/L1W0hLA/ZrQjdqsnxoz6I76PCXx+fj8=;
        b=eAGcNFGRySshnEzsaFrsJ9i7dY4MXF/kQcwEBGiOfjQN22gFj6udkXtxrk/qjHEwfJ
         tZRvZeEBk1ntC4NLg9o165Ff8c2qHeleaHItIsvmE1h2qLrsA47amsFqzZbAQfmStHkW
         D6wTys2uJVNES5t+4beTV2NpxTc9wnOyxSQuZwJ0PA7aqONaqdWJHlhlaX9TioWDvIPt
         vELhEl5FSeHoyyFZkXhBeR1E6Z1aytQTAVs8ufM0+F55UxVPal6274ejL2JJkocjYTNO
         nfq/OTZ13tonSDrnTBrv7rbEXQPmrNu3L0GEOjmMepyduHCNvF/RD+6d3LnbKVUm4JVQ
         vCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688196937; x=1690788937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D04xZI5Sg1R/L1W0hLA/ZrQjdqsnxoz6I76PCXx+fj8=;
        b=ggvmxeAIHQi/w/b/EerTtU2gTHZqKb0Fl+dAXsWKpu9WZAzHkj20+od0BlhfAie7R3
         8tt3VSCiVHNZYAOIYW2a+o34vbipWE572ZZ5atUw/ug/eG7q/A5sQF23pcnusbgGBx5M
         fnOXEmlATvwuenG0GOPMaauv/T7hv9+ts+TkCU4EREdpFNfH7mzxKwRebwvQ/ACQ/mkA
         f89AbSM+rV60J1yMmkRbUGujTCcMxUmZEpgN2R8gI+GpKzN/Xr2+hLPZ7u6JHrStDL26
         V4+XDNwCtUuA59Vzn73n18r/ZDe8tEV5SCWYmAsF7yJ1Y+kiLH6fK/8p/mxSnFLaVrZD
         cSZA==
X-Gm-Message-State: AC+VfDwPNS08G2IcboUvqfTbG3YOJ2w4FYriTV0I2nGoRk+WshR9CDop
        PwQKiOQL4qc6mF0po3wp0rsKCWlg1a0=
X-Google-Smtp-Source: ACHHUZ6nwBScw18iAZO6nvvtXop/fFa891zJjctsilB495dnmmca0IgUPLv11nAA8UPiKcIXr1WEQw==
X-Received: by 2002:a05:6808:191c:b0:3a3:6e43:e681 with SMTP id bf28-20020a056808191c00b003a36e43e681mr5980844oib.58.1688196937422;
        Sat, 01 Jul 2023 00:35:37 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id h14-20020aa786ce000000b0063aa1763146sm8603414pfo.17.2023.07.01.00.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 00:35:36 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv11 5/8] iomap: Use iomap_punch_t typedef
Date:   Sat,  1 Jul 2023 13:04:38 +0530
Message-Id: <b41412dae42389fc1db9d6cb37810cae5d943c0f.1688188958.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1688188958.git.ritesh.list@gmail.com>
References: <cover.1688188958.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It makes it much easier if we have iomap_punch_t typedef for "punch"
function pointer in all delalloc related punch, scan and release
functions. It will be useful in later patches when we will factor out
iomap_write_delalloc_punch() function.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cddf01b96d8a..33fc5ed0049f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -23,6 +23,7 @@
 
 #define IOEND_BATCH_SIZE	4096
 
+typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
 /*
  * Structure allocated for each folio to track per-block uptodate state
  * and I/O completions.
@@ -900,7 +901,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
  */
 static int iomap_write_delalloc_scan(struct inode *inode,
 		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
-		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
+		iomap_punch_t punch)
 {
 	while (start_byte < end_byte) {
 		struct folio	*folio;
@@ -978,8 +979,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
  * the code to subtle off-by-one bugs....
  */
 static int iomap_write_delalloc_release(struct inode *inode,
-		loff_t start_byte, loff_t end_byte,
-		int (*punch)(struct inode *inode, loff_t pos, loff_t length))
+		loff_t start_byte, loff_t end_byte, iomap_punch_t punch)
 {
 	loff_t punch_start_byte = start_byte;
 	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
@@ -1072,8 +1072,7 @@ static int iomap_write_delalloc_release(struct inode *inode,
  */
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length,
-		ssize_t written,
-		int (*punch)(struct inode *inode, loff_t pos, loff_t length))
+		ssize_t written, iomap_punch_t punch)
 {
 	loff_t			start_byte;
 	loff_t			end_byte;
-- 
2.40.1

