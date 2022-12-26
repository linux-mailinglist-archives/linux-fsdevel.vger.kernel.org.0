Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111A8656391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiLZOtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiLZOs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:48:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045472671;
        Mon, 26 Dec 2022 06:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9108760EB5;
        Mon, 26 Dec 2022 14:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A156AC433EF;
        Mon, 26 Dec 2022 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672066138;
        bh=t42rzSF63UtJbC+INg7CeJ566q6MXleMtnlAOPACee0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rEDNYzc25u8cnFiyPzUgYJVm85NpLpYz46Ddn691UNowXbzBiSahtHHodt48CTK22
         YaGgsg0BD9c7f4FqNcY2l+jtzVEl3g41rnmMFFbA85R9tTX4ER12Gg04UnerI8oVZV
         Gqb6EC87E54d0jrb/3IsXJcsKz1LJxLAkT6iDUmYuQqcQoxBevCXNT/LHbzcHdo3iv
         PhvFJC29dveLRJdkEx1pR40dBossRibygPBmzlm+ThSnzhk2ufarW2Mq3MCTdWF5fd
         HKb9hP2MzKo2wbzC6DrOPZgApAwpQQk0DfjWMMUo6WjUkG+gOJLLiGS6llAv8vbay1
         7cJthUq9z5z+A==
Received: by pali.im (Postfix)
        id 3D2F89E4; Mon, 26 Dec 2022 15:48:55 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 1/3] nls: Simplify ASCII implementation
Date:   Mon, 26 Dec 2022 15:42:59 +0100
Message-Id: <20221226144301.16382-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226144301.16382-1-pali@kernel.org>
References: <20221226144301.16382-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Conversion between 7bit ASCII and UNICODE code point is simple because all
7bit ASCII values has 1:1 mapping in UNICODE code points. 7bit ASCII is
just subset of UNICODE code points.

So define conversion between 7bit ASCII and UNICODE code point in
straightforward way.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/nls/nls_ascii.c | 85 +++++-----------------------------------------
 1 file changed, 9 insertions(+), 76 deletions(-)

diff --git a/fs/nls/nls_ascii.c b/fs/nls/nls_ascii.c
index a2620650d5e4..b6ad260b8c02 100644
--- a/fs/nls/nls_ascii.c
+++ b/fs/nls/nls_ascii.c
@@ -13,72 +13,6 @@
 #include <linux/nls.h>
 #include <linux/errno.h>
 
-static const wchar_t charset2uni[256] = {
-	/* 0x00*/
-	0x0000, 0x0001, 0x0002, 0x0003,
-	0x0004, 0x0005, 0x0006, 0x0007,
-	0x0008, 0x0009, 0x000a, 0x000b,
-	0x000c, 0x000d, 0x000e, 0x000f,
-	/* 0x10*/
-	0x0010, 0x0011, 0x0012, 0x0013,
-	0x0014, 0x0015, 0x0016, 0x0017,
-	0x0018, 0x0019, 0x001a, 0x001b,
-	0x001c, 0x001d, 0x001e, 0x001f,
-	/* 0x20*/
-	0x0020, 0x0021, 0x0022, 0x0023,
-	0x0024, 0x0025, 0x0026, 0x0027,
-	0x0028, 0x0029, 0x002a, 0x002b,
-	0x002c, 0x002d, 0x002e, 0x002f,
-	/* 0x30*/
-	0x0030, 0x0031, 0x0032, 0x0033,
-	0x0034, 0x0035, 0x0036, 0x0037,
-	0x0038, 0x0039, 0x003a, 0x003b,
-	0x003c, 0x003d, 0x003e, 0x003f,
-	/* 0x40*/
-	0x0040, 0x0041, 0x0042, 0x0043,
-	0x0044, 0x0045, 0x0046, 0x0047,
-	0x0048, 0x0049, 0x004a, 0x004b,
-	0x004c, 0x004d, 0x004e, 0x004f,
-	/* 0x50*/
-	0x0050, 0x0051, 0x0052, 0x0053,
-	0x0054, 0x0055, 0x0056, 0x0057,
-	0x0058, 0x0059, 0x005a, 0x005b,
-	0x005c, 0x005d, 0x005e, 0x005f,
-	/* 0x60*/
-	0x0060, 0x0061, 0x0062, 0x0063,
-	0x0064, 0x0065, 0x0066, 0x0067,
-	0x0068, 0x0069, 0x006a, 0x006b,
-	0x006c, 0x006d, 0x006e, 0x006f,
-	/* 0x70*/
-	0x0070, 0x0071, 0x0072, 0x0073,
-	0x0074, 0x0075, 0x0076, 0x0077,
-	0x0078, 0x0079, 0x007a, 0x007b,
-	0x007c, 0x007d, 0x007e, 0x007f,
-};
-
-static const unsigned char page00[256] = {
-	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
-	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, /* 0x10-0x17 */
-	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, /* 0x18-0x1f */
-	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, /* 0x20-0x27 */
-	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 0x28-0x2f */
-	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, /* 0x30-0x37 */
-	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, /* 0x38-0x3f */
-	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x40-0x47 */
-	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, /* 0x48-0x4f */
-	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x50-0x57 */
-	0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, /* 0x58-0x5f */
-	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, /* 0x60-0x67 */
-	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, /* 0x68-0x6f */
-	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, /* 0x70-0x77 */
-	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, /* 0x78-0x7f */
-};
-
-static const unsigned char *const page_uni2charset[256] = {
-	page00,
-};
-
 static const unsigned char charset2lower[256] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
 	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
@@ -119,26 +53,25 @@ static const unsigned char charset2upper[256] = {
 
 static int uni2char(wchar_t uni, unsigned char *out, int boundlen)
 {
-	const unsigned char *uni2charset;
-	unsigned char cl = uni & 0x00ff;
-	unsigned char ch = (uni & 0xff00) >> 8;
-
 	if (boundlen <= 0)
 		return -ENAMETOOLONG;
 
-	uni2charset = page_uni2charset[ch];
-	if (uni2charset && uni2charset[cl])
-		out[0] = uni2charset[cl];
-	else
+	if (!uni || uni > 127)
 		return -EINVAL;
+
+	out[0] = uni;
 	return 1;
 }
 
 static int char2uni(const unsigned char *rawstring, int boundlen, wchar_t *uni)
 {
-	*uni = charset2uni[*rawstring];
-	if (*uni == 0x0000)
+	if (boundlen <= 0)
+		return -ENAMETOOLONG;
+
+	if (!*rawstring || *rawstring > 127)
 		return -EINVAL;
+
+	*uni = *rawstring;
 	return 1;
 }
 
-- 
2.20.1

