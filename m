Return-Path: <linux-fsdevel+bounces-32105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85719A0A0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549791F24702
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074A20C006;
	Wed, 16 Oct 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvRwxaON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F2209F22;
	Wed, 16 Oct 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082265; cv=none; b=kZI2yrUibrQ5+TyU7bGLaBImM2hspV0kevQUQwOu/ZdsXp72iLH3HKS6oUrgmI7PWOinGUPt4snK1EwzQD32g6M5XXc4Ee/7qTvVKBON4Zqb0KDuH+vRt1j2TN9qkuQ+YX+kpBheheGgBUTkmYWDizMUInnxCckpUmc6Xnxr2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082265; c=relaxed/simple;
	bh=reVC//lWLhQwWUwrlUTJAAChV8fJgYqeuRzlYrrW9v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5FlsnDOJtglNb55zd8gjoTgb0JfAdGaKkTfNrMMjzsMOFECnE29HUdIrHBdgjMerXt4ksemFRbF8irE2+72vGv0qQTappFf/Ls5SJjIpgN00OYMZvUVhAG2Yp2i+yAVYRlWCfRN9ECkS8wgR++Q9DOCp+vRjCuD6/eyZ83zVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvRwxaON; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431481433bdso13805245e9.3;
        Wed, 16 Oct 2024 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729082262; x=1729687062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EoZbzXysvZ3pWlGw93loQoLyyRrPBICxEmq8tAhWyF8=;
        b=HvRwxaONvqwaI9oWc1cKfEP9ms9iZMmRL3xX182FuIgFO4fy7mtum6x2zrY9nEwc+9
         7cHJowNcpVCZ/BrC4fpY3GXISp+v7/CjlA+4dHORAvpiicSUeQCfuIur0B/WqWokhrYv
         oYnGRF+dqhXMbcZ7v9MLfw+dtyaBdwAyn2S0Am4lcSZgtF/YxD7d7j6+OXpFmw577zDD
         AiPccuyShAFgGJET6el+Z7ndy8hcVN21Mdp576JDg+l3CRQd1KOPpPy6N4YljEjKyCVq
         x2XAPrs8C7SkFiYEh98xVTBKVIhZ6hJyZSwkUkqR9klqeUBzxHjgSITT5HrEL6shKzd/
         TLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082262; x=1729687062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoZbzXysvZ3pWlGw93loQoLyyRrPBICxEmq8tAhWyF8=;
        b=PcRKgWtt16UR39IPtpQXas4FqcikQv9l6r44wBihsOCA+vKjtnUyBQZ9neX1g5XS7f
         F8QMfPRINM4Uy7jukjtxJGsL5mmFCVvWddZSGaSp4eOStzMBk+i5o1hpO47sXcq2Y++J
         5npFoKNI8u37BOgVOYASkTEUJ94Tk3VIxrRZv4RXLBzRJId4EIXMgrfpyK5p4d/8ufSC
         Ted1pjM/Nrbv/ZkBUi6o39dAL2hP8q+buRss7tHsVRB1c1HJ0X1DO3aWqIF4occudD8C
         +qb9VmGfE0taHCtWVwC69NiVbSMMVneX899Pd0hCLw2B864wx5KLAfKRMOT0k0OuEMR5
         n3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHZ3S3WN+YksVwPCrEnO9XPLCIkFX1tD47+QkPGYRZiMscf2J/yjLLuYKMHsoijNSikrN3Y5GxXhlv7+Qx@vger.kernel.org, AJvYcCV7e1dri/6AEFnX/Gza3pvVAuXLDqr+mTDOGChA4UVZhizgqHyXTUH4YAcTTbf5mFeXp/uSVfN9zKt3apKm@vger.kernel.org
X-Gm-Message-State: AOJu0YxJWPvJcEgjzJ0gU/SNSajeDGY1kvKmHwNNTVpi6XgDQLHU6lvB
	dfyKy0B4RUyL6dzki/XkKyGuFZ/fetUo/xN4LJm1EtmUxzh//oYN
X-Google-Smtp-Source: AGHT+IFRq39zSOFiRwgoV1pgdDvgMyo/X5fY9oGDr5ekyAZFJdFXBIT/GF8reJJwyMEv2MZBpm3KfQ==
X-Received: by 2002:a05:600c:1ca4:b0:42c:de34:34c1 with SMTP id 5b1f17b1804b1-4311dea3b47mr155045765e9.2.1729082261655;
        Wed, 16 Oct 2024 05:37:41 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-97-22.cust.vodafonedsl.it. [2.44.97.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c53ddsm48835425e9.43.2024.10.16.05.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:37:40 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	alessandrozanni.dev@gmail.com,
	syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Subject: [PATCH] fs: Fix uninitialized value issue in from_kuid
Date: Wed, 16 Oct 2024 14:37:19 +0200
Message-ID: <20241016123723.171588-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix uninitialized value issue in from_kuid by initializing the newattrs
structure in do_truncate() method.

Fixes: uninit-value in from_kuid reported here
 https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
Reported-by: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index acaeb3e25c88..57c298b1db2c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -40,7 +40,7 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
 		loff_t length, unsigned int time_attrs, struct file *filp)
 {
 	int ret;
-	struct iattr newattrs;
+	struct iattr newattrs = {0};
 
 	/* Not pretty: "inode->i_size" shouldn't really be signed. But it is. */
 	if (length < 0)
-- 
2.43.0


