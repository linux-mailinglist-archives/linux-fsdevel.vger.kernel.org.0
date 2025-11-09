Return-Path: <linux-fsdevel+bounces-67573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3963C439C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 08:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EC0188B230
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 07:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63811EB1AA;
	Sun,  9 Nov 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvuxixPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDB22B5AC
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762672413; cv=none; b=L8TkF4d9n8yJiqQXqRiFYYy7R1KZjwyULdGBUHCbLwr9VgEy0Bvrnp45oCL19EMwvGNCxDsWikcyozZ0aR1mPiolNwfgSvOqDJNOJfpHA82CnOiZq/M4HDFptDbpSggOZxMFQujyz9qRJF7zMTJh6G97WcN5NCoNX10AEhGGI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762672413; c=relaxed/simple;
	bh=7K+eAw4I0x35tUGWi2MDACS8ckhhjNcr5P94y70Esvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QV2yyTm9z0RT8Mwfy7p+zBnEpo8pm2ya02p06R4Vd18lJ4L9IF0eGWGhASsy86SHz76bbS5GDcU8dDS8JF0VH8SpRJZ7EdZdVB0j4GLTiukPZCuFwbcUxeXFiwbtRkzoKsF2Wtm+RViXRaRE8EHhzPenjhZV3VrhS7SpvA5gBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvuxixPS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297f2c718a8so377315ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 23:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762672411; x=1763277211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Sr2F9MQzqFTYcs+5dw/LNJ/aMd5A19XEE7/9ksFfHo=;
        b=UvuxixPSYkgoc048RxtHdniPIjlV3tjsCMnUUD971Q8pXMwXwaC3obepiCOvDv6zsm
         o+B9IVaKOK/RJWXHBE7ck7cP86Ny2zsDoCE9Ixom9kxerF765WhUzwdj0UL7/WiQ+Rbh
         sG/qCMKyv3Giggn8fG31uYoJGhzFATqR+fiFexk/i1o3GtkKKWYbstkFd3FQIstKguJv
         fegUvMOzqi02XxAj28JTRUch0KOQDtIbnaNom9vDvnzutKY3l48b7UFj9gANG1caPa06
         9V9XrEsUAdcI77K4gY5+w/etYkCa8zzDOUDfmfvR4+WKJANGjBGlBMq9otJP5iHWA+DJ
         E5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762672411; x=1763277211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Sr2F9MQzqFTYcs+5dw/LNJ/aMd5A19XEE7/9ksFfHo=;
        b=k1h7PWRaxaq08ZJ5j+qS6YJEPeYC7dLaTE9h6U3J/vG15WbRyY9f546L+ynY/YIcl5
         n2quLCyA8/hyBFyhvv0H81OShLv3NmhAvaWjdJ0KuFFwmq5WMYMTbUKWGwhn5x8OHtbh
         +Vp1nG3B/iq6NOKoXHMgO5d/f39ZyHw02oSMVxO9V4ymZee6Z8gNXw9YGarRC0angDtK
         otEU5gxJRapGTE3chuM6hBxhzcb4fhk4kBRq6q8DuvWdYJMnTO/yaT9C5Jbf4px8hQEF
         XI2jNeZYlwqGQm7V9PxAkmFsZ87w3V3BHskGso52biwAZKV9N8ADBUY6RAPac4AjsKm0
         ut8g==
X-Forwarded-Encrypted: i=1; AJvYcCXZPea27j0rMIZdzC9nPqkdDjW0+Eji7MPvkXW0zbLKR+KTQyfJ6yRDYhVGSfP2ruEcU+XXz3q7mfXE4JuD@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJicOxIW1yzi4phiQwzf88ALSAwfdLWZ6dBw8fKUqEsMkrmnF
	3HQQbBeHhS+vpupspznyn+CUAnvYdTj4RQpy+y61Ii6Ukxh+m+PZ1skIyL3J2VcS
X-Gm-Gg: ASbGncuvo5KAgGtR0UOwX4K3V/ujE6ONwJVFPR8PM6gCFiEDuPZzKRYADJnuZq9UZkh
	QNtwnuilN36OazjHpB9fKcqimB/zoxiRPyic9gMuNfINKKwyzelPvJ0l9J3Yuz/WDJAiePDnVi2
	PVcl27vaHUJN1ks2+HRnuO9untt259RWKTtguMi+ullALiYSzVQNsVlU0E4xu+5Qb9tbuos0cQx
	tSx62gJmqmUkZ/jvUVvK81NcBEJKr3z+sQnyfAiDYC1hS6zKRaiCgYYAhJknHuBgZaigYgQ40TE
	loWjZ+TTJlOgdhpIvvusad/lHGQp9bMWIvdbbnGHY+odIpk+cIcnoHAO/SFXoCqiEBB+bXAofC+
	iUWcw2ZyoReCdGKNocXYcZ83oIJyZyI3Ppv2mCbABWVSWOAH3i/OAa9JGVsCfTfxiPD4/uAj+Yj
	uFVo6vyrMwRiPDQ3FavwX7fkOUjsa6
X-Google-Smtp-Source: AGHT+IGbXs/m0KZgHZ/BEGvXV3TvyIMHnmN5bbAbrdte8kwOk8/1idc/hq0bNfXupt204mptBEpzrg==
X-Received: by 2002:a17:902:ea0c:b0:298:f0c:6d36 with SMTP id d9443c01a7336-2980f0c6f48mr3180915ad.5.1762672411223;
        Sat, 08 Nov 2025 23:13:31 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d6859a92sm57287495ad.88.2025.11.08.23.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 23:13:30 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: jesperjuhl76@gmail.com,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH 1/2] uapi: fcntl: guard AT_RENAME_* aliases
Date: Sun,  9 Nov 2025 16:13:03 +0900
Message-ID: <20251109071304.2415982-2-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109071304.2415982-1-nogunix@gmail.com>
References: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
 <20251109071304.2415982-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 include/uapi/linux/fcntl.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 3741ea1b73d8..e3026381fbe7 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -157,9 +157,15 @@
  */
 
 /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
+#ifndef AT_RENAME_NOREPLACE
 #define AT_RENAME_NOREPLACE	0x0001
+#endif
+#ifndef AT_RENAME_EXCHANGE
 #define AT_RENAME_EXCHANGE	0x0002
+#endif
+#ifndef AT_RENAME_WHITEOUT
 #define AT_RENAME_WHITEOUT	0x0004
+#endif
 
 /* Flag for faccessat(2). */
 #define AT_EACCESS		0x200	/* Test access permitted for
-- 
2.51.1


