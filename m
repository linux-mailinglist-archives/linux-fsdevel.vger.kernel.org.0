Return-Path: <linux-fsdevel+bounces-41291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D499A2D750
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 17:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A36167581
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 16:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8222DFF3;
	Sat,  8 Feb 2025 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuF2bONR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC71F30BF;
	Sat,  8 Feb 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031991; cv=none; b=fvQRGINbEPhCUGJ8b9LeJB4w8/Zr5vtqBBYtOEUUJ7p3qOuMMRELYNyXLI/NlKrVB9pE/xWIN53OEgN0pxL3/lMP+nMAtTamP062wP2/K2bhRvsN5gqnaSxTiYvK9RPs1JgXugXfjPKxSX1OKALgAJFQ4MImX/WsM/sGOW0K/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031991; c=relaxed/simple;
	bh=61udqkcEg9wcSq/halgc8JMmMFwwfrBUY4mtNHZNt8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOOcVugV9kFo5SKpBMmkw1zX86N4BqImxMVA+9PuWxhaG5cSsbEmADYLCcccE9Do8dSoPjLbIIVuvJoz+UrbNSxnw+kAkgJOuDVyDscXiEjVoPzOptbuXYObN97pSNw9Mk/zVsDR1LD6DcTvcwgFEWutisFuqeQQqYFtHknaqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuF2bONR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de56ff9851so2046650a12.2;
        Sat, 08 Feb 2025 08:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739031988; x=1739636788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8Wgr0+Th/eZItEiexHX2VH44yFxgC7CrIHewPAPMnk=;
        b=BuF2bONRSvuF+INxdoT1DUmP0j+iU4mV3V76hSATzPD5nQFWIx9kq0mULaCsCEZAX7
         evOH+1zw74ysqxTkc6MIpEVrZTV6+gtxsbp4j9AENBYYiq76wkldvSRCtRGf6nnp+rTD
         6bPMueYhncuFq4Kion6vhTRItdgT0ovEyCSZyMLxtJWXM0sSMXFml+zueB1NXtN2A3Wt
         FbKTTe4TZxto7gFLC/YERX0wG4Vue2UQE2J6oIqv7e9MGpEYiN3zZyjg9PU/boFg7lxK
         HY8QAtyxn/Z7dXF6ViQqskWukrIDbBbd6MkJ7yXUsnUgOFbb5SwVKTL4cIPrF8VX1/E/
         XV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739031988; x=1739636788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8Wgr0+Th/eZItEiexHX2VH44yFxgC7CrIHewPAPMnk=;
        b=OwGq/iRIisyxsigQgI197Ji3xNK+4qqCYttGTG+WszxnBFvUI5GvjXWEDwBxqeLzc0
         Lz0OPmIWcHv0GlGtAjstyYnvwusCBTN/kZLlb9+SpZlfLhdeimILqoNqptmW2Dh13BM+
         ZHRVudfvYzN/9XwgfqnLQPAjQYuEQrVRqXn7GEH1B5H+oyUMNy1RsD5rSckoWZWedPz6
         u06nlLGOYEESF6y1PjzUfPG+n1/brvC4Yp/fE/4Wb+f2cDUM3iHnfxjVvnTHlz1QAJz+
         w5OH1pJiTxq644YK2OIzKUrMit5jsaLGibURBOtPTSWm/EqwbzExZ/8kT6VguCDnysEZ
         r03g==
X-Forwarded-Encrypted: i=1; AJvYcCXMlLsI0rNLWxyJVJXlFPvPI0JBI60tiyTavJG4iDS/KAwMztyxrNFLwv0KwnDuDWRmbBI9jH0XJdpJq5S6@vger.kernel.org, AJvYcCXazqHWq+UtcyLSMenK3hM0+JONWcs+bQ6ayhxOrtdQHzhKA8Ub0iHmQsdt1x96lCZp+uNC/MqDDWAgYjUn@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfRmLjbvxdClcbUtbAQ5VQx7NMPMAREKSQx7huQYhuwuxeCTX
	sFVdm3kZvLS1gPGp6OgTFbPqyFQ7JE5OuC5Mv+q3jT95Vguk7rUeGoUE9g==
X-Gm-Gg: ASbGnctHCpOmEEnsD7+ss4qFR9Se4XubnoYf66ea8c8pd7nUBXEF0hhaR/KiaIaeWms
	Zn01Y6DitNyk90/oGzAQwNo5WdGEDeOb04ZgTghfPfKnkIQSIsr+9sfZegdFHE0coD3RP/BO7+V
	VRweZQbBFko/7UGKHAKh9cZg0mfha5c3rFPGJVVTylxmFPkSa/uCv8OPJlRAG3II56LFtC83XOm
	GwoqOPuHXmcp/nJKhYOqlQhk4oCx7ResJkmG6UKURLUfzrQKFJz0+mxfDnZadhvSBCnGi2nOi1c
	O/nWTwEiTlHSrry49f4NllZD3naZakHWxw==
X-Google-Smtp-Source: AGHT+IHLtrxuW6vMQwspp/peB2fehaaqv7Uak6pWLo2wK+10UbiEKjCqtzb5Rpc9aBb4XK95eSHZwA==
X-Received: by 2002:a05:6402:40c9:b0:5de:4acc:8a99 with SMTP id 4fb4d7f45d1cf-5de4acc8d50mr7741738a12.18.1739031986808;
        Sat, 08 Feb 2025 08:26:26 -0800 (PST)
Received: from f.. (cst-prg-84-201.cust.vodafone.cz. [46.135.84.201])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de47d6461asm3193943a12.74.2025.02.08.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 08:26:26 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 3/3] vfs: use the new debug macros in inode_set_cached_link()
Date: Sat,  8 Feb 2025 17:26:11 +0100
Message-ID: <20250208162611.628145-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208162611.628145-1-mjguzik@gmail.com>
References: <20250208162611.628145-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 034745af9702..e71d58c7f59c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -792,19 +792,8 @@ struct inode {
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
-	int testlen;
-
-	/*
-	 * TODO: patch it into a debug-only check if relevant macros show up.
-	 * In the meantime, since we are suffering strlen even on production kernels
-	 * to find the right length, do a fixup if the wrong value got passed.
-	 */
-	testlen = strlen(link);
-	if (testlen != linklen) {
-		WARN_ONCE(1, "bad length passed for symlink [%s] (got %d, expected %d)",
-			  link, linklen, testlen);
-		linklen = testlen;
-	}
+	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
+	VFS_WARN_ON_INODE(inode->i_opflags & IOP_CACHED_LINK, inode);
 	inode->i_link = link;
 	inode->i_linklen = linklen;
 	inode->i_opflags |= IOP_CACHED_LINK;
-- 
2.43.0


