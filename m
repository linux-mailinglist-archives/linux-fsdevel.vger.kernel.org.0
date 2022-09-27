Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949095EC405
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiI0NQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiI0NQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9515A01;
        Tue, 27 Sep 2022 06:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ED3261990;
        Tue, 27 Sep 2022 13:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE48C43470;
        Tue, 27 Sep 2022 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284564;
        bh=8r0zoTSImOZrA/8nQ8Zb1n00YNiHWkghR7s9YBs524E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1l+RHpDsq40AJXmFQDAzSjf/c7vCPVCWla9h5TbsJw/dQV3rdbZ6niSsYDWDG+ik
         GkNrgmcs5Ax/JfxLSsvO551NSZUjxvto4dxJpc25hmwKXR0L6weD8gCe9z98Oy/neZ
         S7nfTpMajsm4VVNBsTR7XZz4UcXQKZGogtwyV4LSNa+Ch2NpJChg547ckmhAWUfXak
         mmP2EIYTlkz4u6r3HaNPYQT2n/pkEoHPv8ROiElmdyA9Q0bsecJs3RTMAB8eiy0ZGw
         uH9cH2jwmEn/CfYC4mRzhNShlcul/pKQD8xfOFyTrvE2jcNiA8wFTeNoD36SnJaUWX
         nTdgoCbognrzQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v10 04/27] kallsyms: support "big" kernel symbols
Date:   Tue, 27 Sep 2022 15:14:35 +0200
Message-Id: <20220927131518.30000-5-ojeda@kernel.org>
In-Reply-To: <20220927131518.30000-1-ojeda@kernel.org>
References: <20220927131518.30000-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rust symbols can become quite long due to namespacing introduced
by modules, types, traits, generics, etc.

Increasing to 255 is not enough in some cases, therefore
introduce longer lengths to the symbol table.

In order to avoid increasing all lengths to 2 bytes (since most
of them are small, including many Rust ones), use ULEB128 to
keep smaller symbols in 1 byte, with the rest in 2 bytes.

Reviewed-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 kernel/kallsyms.c  | 26 ++++++++++++++++++++++----
 scripts/kallsyms.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 3e7e2c2ad2f7..fc5e26348d25 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -50,12 +50,20 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
 	data = &kallsyms_names[off];
 	len = *data;
 	data++;
+	off++;
+
+	/* If MSB is 1, it is a "big" symbol, so needs an additional byte. */
+	if ((len & 0x80) != 0) {
+		len = (len & 0x7F) | (*data << 7);
+		data++;
+		off++;
+	}
 
 	/*
 	 * Update the offset to return the offset for the next symbol on
 	 * the compressed stream.
 	 */
-	off += len + 1;
+	off += len;
 
 	/*
 	 * For every byte on the compressed symbol data, copy the table
@@ -108,7 +116,7 @@ static char kallsyms_get_symbol_type(unsigned int off)
 static unsigned int get_symbol_offset(unsigned long pos)
 {
 	const u8 *name;
-	int i;
+	int i, len;
 
 	/*
 	 * Use the closest marker we have. We have markers every 256 positions,
@@ -122,8 +130,18 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	 * so we just need to add the len to the current pointer for every
 	 * symbol we wish to skip.
 	 */
-	for (i = 0; i < (pos & 0xFF); i++)
-		name = name + (*name) + 1;
+	for (i = 0; i < (pos & 0xFF); i++) {
+		len = *name;
+
+		/*
+		 * If MSB is 1, it is a "big" symbol, so we need to look into
+		 * the next byte (and skip it, too).
+		 */
+		if ((len & 0x80) != 0)
+			len = ((len & 0x7F) | (name[1] << 7)) + 1;
+
+		name = name + len + 1;
+	}
 
 	return name - kallsyms_names;
 }
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 411ff5058b51..6502c4001f01 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -487,12 +487,35 @@ static void write_src(void)
 		if ((i & 0xFF) == 0)
 			markers[i >> 8] = off;
 
-		printf("\t.byte 0x%02x", table[i]->len);
+		/* There cannot be any symbol of length zero. */
+		if (table[i]->len == 0) {
+			fprintf(stderr, "kallsyms failure: "
+				"unexpected zero symbol length\n");
+			exit(EXIT_FAILURE);
+		}
+
+		/* Only lengths that fit in up-to-two-byte ULEB128 are supported. */
+		if (table[i]->len > 0x3FFF) {
+			fprintf(stderr, "kallsyms failure: "
+				"unexpected huge symbol length\n");
+			exit(EXIT_FAILURE);
+		}
+
+		/* Encode length with ULEB128. */
+		if (table[i]->len <= 0x7F) {
+			/* Most symbols use a single byte for the length. */
+			printf("\t.byte 0x%02x", table[i]->len);
+			off += table[i]->len + 1;
+		} else {
+			/* "Big" symbols use two bytes. */
+			printf("\t.byte 0x%02x, 0x%02x",
+				(table[i]->len & 0x7F) | 0x80,
+				(table[i]->len >> 7) & 0x7F);
+			off += table[i]->len + 2;
+		}
 		for (k = 0; k < table[i]->len; k++)
 			printf(", 0x%02x", table[i]->sym[k]);
 		printf("\n");
-
-		off += table[i]->len + 1;
 	}
 	printf("\n");
 
-- 
2.37.3

