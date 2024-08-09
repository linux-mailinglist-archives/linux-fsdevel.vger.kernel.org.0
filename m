Return-Path: <linux-fsdevel+bounces-25543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDC394D3C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 17:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0473E1F20616
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C932198E78;
	Fri,  9 Aug 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SK4W6xrk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED8198A2F;
	Fri,  9 Aug 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217951; cv=none; b=Hr+wHji7YhpOn2K6D/eaGQ1GHlGYXyl6Jbh48OyyRBvs0/jpyS07S5OSkZB6IcJJi2USWmGe9ciN5QtfGjrTF42V5IHdYLba3qH0niQ0IQePxInSd6BH47eXuPznLCr+676Wib0/1hrolwtMHmefKXoCy/PdTcmMAXsQuHe16xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217951; c=relaxed/simple;
	bh=6j82V0+H0NTxc31P8JscPmTgjrKBCKmSwDsYbDXsLpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d5+FdVhPt2qhcdTivYyLYd4OySu+FcCiJG6pjvhZDvk+69pGZRxeLLRDH77BwDRkPiGA1VozyRzCgBpS7hRlxe2Um8mYt2Rbn/57bEI0oRtExtcszZdXnNv3y7y1UkmhHlTVwciy9b5/CVVVPJX6SFoy7rHbdSLEiqjgnJxaoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SK4W6xrk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723217936;
	bh=6j82V0+H0NTxc31P8JscPmTgjrKBCKmSwDsYbDXsLpw=;
	h=From:Date:Subject:To:Cc:From;
	b=SK4W6xrkod35MgbYnBmUrWdfsm85xUH+/OmabHpcrIZy2sFVk1jkpxi8myZMxWJde
	 71bOc/pCtDQdoQH8IC9Tq+UfNNulLWVi+LoyEJJvlkQze0m36kr/+/dRX4P0BYD57k
	 qvDDY6zMdLV0wJiIZaonul/5sqf1mPOkDGlBSogk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 09 Aug 2024 17:38:53 +0200
Subject: [PATCH] unicode: constify utf8 data table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240809-unicode-const-v1-1-69968a258092@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAA04tmYC/x3MMQqAMAxA0auUzBZqVFCvIg7SRM3SSqMiSO9uc
 XzD/y8oJ2GF0byQ+BaVGArqyoDfl7CxFSoGdNi63g32CuIjsfUx6GnRE+LQUUNrA6U5Eq/y/L9
 pzvkDRo6oL18AAAA=
To: Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723217936; l=1992;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6j82V0+H0NTxc31P8JscPmTgjrKBCKmSwDsYbDXsLpw=;
 b=aplz7Z9wZkAApOYb0SecwwfSjDr/36NkOYt4WQYctYaPKTUH9u8ovJWtEjW17eO39t/YPxtpc
 GNpqI0/IbPhCjLc1Rt5o6app6DGreyCvT3GI9O51q0nDN+w6yA9tnqf
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All users already handle the table as const data.
Move the table itself into .rodata to guard against accidental or
malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/unicode/mkutf8data.c       | 2 +-
 fs/unicode/utf8data.c_shipped | 2 +-
 fs/unicode/utf8n.h            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index 77b685db8275..57e0e290ce6f 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -3338,7 +3338,7 @@ static void write_file(void)
 	}
 	fprintf(file, "};\n");
 	fprintf(file, "\n");
-	fprintf(file, "struct utf8data_table utf8_data_table = {\n");
+	fprintf(file, "const struct utf8data_table utf8_data_table = {\n");
 	fprintf(file, "\t.utf8agetab = utf8agetab,\n");
 	fprintf(file, "\t.utf8agetab_size = ARRAY_SIZE(utf8agetab),\n");
 	fprintf(file, "\n");
diff --git a/fs/unicode/utf8data.c_shipped b/fs/unicode/utf8data.c_shipped
index dafa5fed761d..73a93d49b3ba 100644
--- a/fs/unicode/utf8data.c_shipped
+++ b/fs/unicode/utf8data.c_shipped
@@ -4107,7 +4107,7 @@ static const unsigned char utf8data[64256] = {
 	0x81,0x80,0xcf,0x86,0x85,0x84,0xcf,0x86,0xcf,0x06,0x02,0x00,0x00,0x00,0x00,0x00
 };
 
-struct utf8data_table utf8_data_table = {
+const struct utf8data_table utf8_data_table = {
 	.utf8agetab = utf8agetab,
 	.utf8agetab_size = ARRAY_SIZE(utf8agetab),
 
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index bd00d587747a..fc703aa4b28e 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -78,6 +78,6 @@ struct utf8data_table {
 	const unsigned char *utf8data;
 };
 
-extern struct utf8data_table utf8_data_table;
+extern const struct utf8data_table utf8_data_table;
 
 #endif /* UTF8NORM_H */

---
base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
change-id: 20240809-unicode-const-2cd2295d3df3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


