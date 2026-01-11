Return-Path: <linux-fsdevel+bounces-73149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F82D0E681
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 09:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8656C300F9D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 08:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10E42D0C64;
	Sun, 11 Jan 2026 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJItWBTn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB7239E9D
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768120736; cv=none; b=Z0fvSplNUEd0bTZNo5GYNu5YlSambIRPKcmwduTZqwHmTexKHKw9otHndL5qQohl/wi1PU0ze7lL9brF7mlZ7m9FJgYNgHa67/LyARYqWQ6ASHH25i9AUml5Qlq7ROqfXQQHGo5Bzghm8x9wJOrOan7ZzNPmg6zydwBLI2Luzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768120736; c=relaxed/simple;
	bh=jE9/CgoTlUgc2lv2zb/ctgAkQ+7hnK5bGyYGmGDMyS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3r7q8LAUnzCo3v7d6AcWHxbqNFwnc7ZiXF2qGNJV/39KstbVhdHRq2NS1xlFYEQcF2EmZUlWNDOPNiPbYrrKzBd82ZlSEHV50sKCLRY4k7XZ60royKupcNAtae6sKvp3UtkzkJNIUJcXWds8fsRvkU8d/PZPOF6stuPnVhXSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJItWBTn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7eff205947so786323466b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 00:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768120733; x=1768725533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Hqfr4217uXPrOb4EkX5rARQEf/pV9M4LN/KyODRFok=;
        b=MJItWBTnO2YI2s48Hq63NrndDSrb0ggkSwmnPlHPbJ3+QT3x/iM6eZk52UExvAAl7C
         jsfkve0fg0Zxvo1WzsGJFQTIa+B5c43sLzusS1a5gvmQgoVsH0VGxM821f6DgOKNvGGL
         HtWyc1hYUd9Is4o6HkM7RqEZJ4DNdy7/hlaRlRISp6sTR+N9Lbo38f0NTORaYA6enaDU
         Kukg5fMk3lOVGmoqPECEY1G2lDUuURzlFpS9Ar+VIasOo4dvueBTw33FPbPA2bT3siaA
         KIa8dX+SiHbiy8wFm7MU0PulycBoBp72HHdl2dSKLeQfHCjk9RDS2vAcbgb5ynZQuz4v
         7VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768120733; x=1768725533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hqfr4217uXPrOb4EkX5rARQEf/pV9M4LN/KyODRFok=;
        b=FFonfkL5CtSivlszUXZG7LVBjn7U64pN2iCN0zmeffdDNQHZMAOlb5SHvix8c+hPhu
         fBCxKWuZq6snix4VUA3Zsk9E3fEqY3k1AYhipwrt0Fa8LwfJkgLXGqgeDh84V4gzwqk1
         174EolyJDjwmD4R7m+RA1W0c/b37a2tI2waJQuCat/msfsrorvoiSYuZFYhCUysK5jil
         V4V2933Y9dYGal9mvh6KPsghquDrB646PzKcg4yq0p9fBc2B4lyzcFF7/Q2SzRZhaQKB
         plA0eSkZgrzXQPo9OCBHyeZvZPRhkce41l4+YR0YCIloq0Zy7RUZeqIKJNrSRB1lhLJi
         yhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW28Rf6hrcoytT0Tz0xNq63yOP2AChLLVa51Imw+bxK4VKXEyGwlt+4TPNR7cJ6v8ibiwryCqHUBhahZTo6@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0QwADcF3GUgBoVnHpWx/JSwKoDRKn8+xtBXIPoj6G/bqw3OT
	dCDUVWwenBX3Brlw9bENIjG41uawpwvD/OHcsQH5QlwSGXuJwsPHu62jN0Sj9w==
X-Gm-Gg: AY/fxX6GRLjTUe1nZ2XUphF9SGJbRotJKFs/58gTW4PNFuMe/MbmeX3XdvQh9N4dlV4
	+xpIHbW7egcJZHFLj1IB3UntI0kiGArAQuvrgjcZLd5cFP7Qf6lcZee10JiarZJbxOxLMZbOvgo
	jN78OTAghCVCNwI6jP50dIuZBunRjNdcbjw7EuQRSGwyIOBGfwwyQtsPsUZo58EyLBXfh8cqNj3
	8UekFmi0Hz1IwHt9NnyBbcjRpEBC8722U7KG8PZU79ThEHYtpvTLDRLHDRj3cVrmlP6l0fTxt+W
	ewvS+gTjJqQrMwPasE19B6mSh/bTKoWpcqQcGn5w6fC6T+buLOPKvhX6JjQq6lS2fYbpZoQ5Ggd
	g5pmtT/f1Nr+Z+gZ9va9wexbhtwWqa1H2g7ZEkJHDWlAkLS7D3RlEoNoBKnExGhpRTdVZcUVNKG
	O8R3wHbSMMuMJEpkto8TDNZe35Ja+bssYSfIdQYe6eHluiUOpBoZOgbgT1t40=
X-Google-Smtp-Source: AGHT+IEspf3qIohQNkUkRrdzofIMxm51ocQHUoALfJS3sFw+KNqAYJt28Z24+rws7/pAKA50BUtYHA==
X-Received: by 2002:a17:907:1909:b0:b86:f0b4:4996 with SMTP id a640c23a62f3a-b86f0b44c84mr298334566b.25.1768120732949;
        Sun, 11 Jan 2026 00:38:52 -0800 (PST)
Received: from f.. (cst-prg-93-36.cust.vodafone.cz. [46.135.93.36])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm14304272a12.29.2026.01.11.00.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 00:38:52 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: make insert_inode_locked() wait for inode destruction
Date: Sun, 11 Jan 2026 09:38:42 +0100
Message-ID: <20260111083843.651167-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the only routine which instead skipped instead of waiting.

The current behavior is arguably a bug as it results in a corner case
where the inode hash can have *two* matching inodes, one of which is on
its way out.

Ironing out this difference is an incremental step towards sanitizing
the API.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f8904f813372..3b838f07cb40 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1832,16 +1832,13 @@ int insert_inode_locked(struct inode *inode)
 	while (1) {
 		struct inode *old = NULL;
 		spin_lock(&inode_hash_lock);
+repeat:
 		hlist_for_each_entry(old, head, i_hash) {
 			if (old->i_ino != ino)
 				continue;
 			if (old->i_sb != sb)
 				continue;
 			spin_lock(&old->i_lock);
-			if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
-				spin_unlock(&old->i_lock);
-				continue;
-			}
 			break;
 		}
 		if (likely(!old)) {
@@ -1852,6 +1849,11 @@ int insert_inode_locked(struct inode *inode)
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
+		if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
+			__wait_on_freeing_inode(old, true);
+			old = NULL;
+			goto repeat;
+		}
 		if (unlikely(inode_state_read(old) & I_CREATING)) {
 			spin_unlock(&old->i_lock);
 			spin_unlock(&inode_hash_lock);
-- 
2.48.1


