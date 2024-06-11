Return-Path: <linux-fsdevel+bounces-21433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE47903B7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4C12855D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A14B1791FC;
	Tue, 11 Jun 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqE0ga4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B317C22E;
	Tue, 11 Jun 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107603; cv=none; b=bAeaQfsQNfflPBvpulgkgnJ/AKtpOTkAURQnZg/frEZGBLemJNRyDrwokViDRzxAQj4kiHYFIlSaIZoZG+fGj8jp2w2TgaoJXi4ZB+IEr1pCWW0ZMeFMMwKGlbY/oRaNcJ4C6KKGdFzmU4wo5A0kIEXF4IncFHBwszNYd4R2VC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107603; c=relaxed/simple;
	bh=yY88myOuUdNm6Mk0iu+lQY+4gOScmkEdZ717BfjS0QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdPoeDVB6lrMMSMSA+D8lYjGIIXyZUkLu7VvG0tySbYWwsCW66ORlH3/qCo4ii8J+NiPhoe/YREHtQzpUgeiw/qhKm7P5TnJOHCTOD9pV5PpQgvJ58s/dtF4ZByEEG+5ZWIFD1pV0eSVOFWKo2d1J00rjjxOtuT/a1b/KAfX/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqE0ga4y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-421b9068274so18988235e9.1;
        Tue, 11 Jun 2024 05:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718107600; x=1718712400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7XhUrCYdhIUl0WvQgOZqj6KAG+JMrYKEpk/f8XC47Y=;
        b=kqE0ga4yVpriWhZ9a+oGHw6JnAsBesXjtzjmRmacUyqm5c+bqFiTtU2u8yyeKw/cVC
         dYRjMsCOiDPPskS6AwbjZqGmOW4ch+SHE89N9ypIFpsDzOVIV53d+UORBjGCNDCsA7SB
         1OiliJRMeULNtGmNYXlmtArwtjvtHmo9Fnf8DJAvp7jG2Z4C05JpX5grB9mr3j2xlkHO
         AgxjArUnEOICQhD4Sex1N7jEsMwPoTPqox82/UyKDlId/hzHXIIKqZch1cfN06bfJjYh
         It520F6xVqsgN2YivrxobvxnALU+ReuOH4Ma6+q4NXJvf4nex+NJq8VLcC3zS4beYKve
         +jCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107600; x=1718712400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7XhUrCYdhIUl0WvQgOZqj6KAG+JMrYKEpk/f8XC47Y=;
        b=SxcY+MC9DztMaKwzGgrqNQsZNcFAD2lcwyRxCPhCWX5EtI39iiBMZVd3FaR5PwKXJB
         BX343T269KPlFQwR4mAk+D4PPdpp18wuEY/L6osACN2V0mx9vp/nzyrA1on1kka3tqgA
         SoazmKC7CJRo4dxDA0aO1UHwKuVaGfXMriWfAt6y7rF7MP3Qx6QJamIvs+H/g993uNpH
         TDnSVnYrEisDy6NH14GS5ZaN/G0/6U2rjGo8eLf4qipeIR3ruVDBvKlX8fljSpdnz4kB
         WnsirOFSO1TwHTHsV2Mc3/oF/WyIWmPlBmZn/bv6tPebf0q+FqE2qceESRlHQpv2Lb3D
         j3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX+ARbG9FuNXiYWNTfS0+QItazUBm4xcblx8V/Sfa4DWTzdiKydigtFdmXrD6B543LpWg7Ydm06oramJvp2oz7dTuC+QOUaQLwiCUa72TG+CnL/2T+KQhHHmHeM5rQdRpjN2AZ7+i6yCX+X3PEUl5tyUjYOjeCN2YZziTlgJna2xOjwy/CnC5AIapwd7ty5Z1Ow5U9dXuEQDxft2SaGY1JK/H60GQHb
X-Gm-Message-State: AOJu0YyCs2blax3QIVLarMYh45o70RFmfPLp+VFTFev/iwWhksFTkIYV
	In0P4jvcx1/nzOnOdR69GuEC0/KKtaCGpS9GaWMWQUYX7tI/EJMV
X-Google-Smtp-Source: AGHT+IHEUn68efWOHcu/b0fFpPapvjoKrnJm47h6BB5MorjLO0UAerbcgyICO9Pba6YeHwffcwKVwQ==
X-Received: by 2002:a05:600c:3150:b0:421:791c:4bfd with SMTP id 5b1f17b1804b1-421791c4e5fmr76002655e9.17.1718107600516;
        Tue, 11 Jun 2024 05:06:40 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f141sm209315785e9.42.2024.06.11.05.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:06:39 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev,
	linux-xfs@vger.kernel.org,
	david@fromorbit.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/4] vfs: partially sanitize i_state zeroing on inode creation
Date: Tue, 11 Jun 2024 14:06:24 +0200
Message-ID: <20240611120626.513952-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611120626.513952-1-mjguzik@gmail.com>
References: <20240611120626.513952-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

new_inode used to have the following:
	spin_lock(&inode_lock);
	inodes_stat.nr_inodes++;
	list_add(&inode->i_list, &inode_in_use);
	list_add(&inode->i_sb_list, &sb->s_inodes);
	inode->i_ino = ++last_ino;
	inode->i_state = 0;
	spin_unlock(&inode_lock);

over time things disappeared, got moved around or got replaced (global
inode lock with a per-inode lock), eventually this got reduced to:
	spin_lock(&inode->i_lock);
	inode->i_state = 0;
	spin_unlock(&inode->i_lock);

But the lock acquire here does not synchronize against anyone.

Additionally iget5_locked performs i_state = 0 assignment without any
locks to begin with, the two combined look confusing at best.

It looks like the current state is a leftover which was not cleaned up.

Ideally it would be an invariant that i_state == 0 to begin with, but
achieving that would require dealing with all filesystem alloc handlers
one by one.

In the meantime drop the misleading locking and move i_state zeroing to
inode_init_always so that others don't need to deal with it by hand.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 3a4c67bfe085..8f05d79de01d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -231,6 +231,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 
 	if (unlikely(security_inode_alloc(inode)))
 		return -ENOMEM;
+
+	inode->i_state = 0;
 	this_cpu_inc(nr_inodes);
 
 	return 0;
@@ -1023,14 +1025,7 @@ EXPORT_SYMBOL(get_next_ino);
  */
 struct inode *new_inode_pseudo(struct super_block *sb)
 {
-	struct inode *inode = alloc_inode(sb);
-
-	if (inode) {
-		spin_lock(&inode->i_lock);
-		inode->i_state = 0;
-		spin_unlock(&inode->i_lock);
-	}
-	return inode;
+	return alloc_inode(sb);
 }
 
 /**
@@ -1254,7 +1249,6 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 		struct inode *new = alloc_inode(sb);
 
 		if (new) {
-			new->i_state = 0;
 			inode = inode_insert5(new, hashval, test, set, data);
 			if (unlikely(inode != new))
 				destroy_inode(new);
@@ -1285,7 +1279,6 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
 		struct inode *new = alloc_inode(sb);
 
 		if (new) {
-			new->i_state = 0;
 			inode = inode_insert5(new, hashval, test, set, data);
 			if (unlikely(inode != new))
 				destroy_inode(new);
-- 
2.43.0


