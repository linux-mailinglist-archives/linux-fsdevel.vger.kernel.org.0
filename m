Return-Path: <linux-fsdevel+bounces-32190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF689A21D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 14:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583A8284861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 12:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B21DD0DB;
	Thu, 17 Oct 2024 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1XoBub6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFCC1D88D7;
	Thu, 17 Oct 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166771; cv=none; b=YhcEiwgQ/NWbMR2b9UpCI1P/EOAnyJ+4F9o/KabC7LUdE8hEjGWYZPByAfELWPjVOpd23KUxq5yL2o1sPwmirK1qe0lKqZn1a9q9fVOAxDICzTQfkYvMnu2Y41PxgnjfsZyPBUDS2VT31Rifycjmahx1iDbYw22Nk29wNQT4ufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166771; c=relaxed/simple;
	bh=0IC/symArmV4VOVENJAqxehgnIuHmdP1CpcoZrgM0Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvGM9+JGXY8Uqvn9YzDSNBQVCGG5jpT2FTgYN7dEPVW0GxZl8d33eEnK72NOMg0y6hL6TCkeFp67Z2JRxijzOAlmLYQVT0l3tFpxmUv5JPSL+UO9CTgv5dM+ryEwsqpCMKQzJM9IjxJWpiMPpeG8zcdG5N9O9Loe7hLt7RDGfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1XoBub6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso1367238a12.1;
        Thu, 17 Oct 2024 05:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729166767; x=1729771567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKq97N5zRC4Lxz0F+vgOE8YvVRBXTV9HFyV59txoqGI=;
        b=U1XoBub6MdzN6jj1C7dPZ3J1Sms3Bo7Xw0uLT+cHqVTx0LQjq9cdCOzZFYoVIZg/fq
         O59vHlR9hcSBSiy/W35qV+qIvL2x6egvn0MZFTF9KdIxZ9tU4OYdX1uQVqdrjXeFDu7s
         E3wdfFchHcVxfUr1i8zH8M9mf+8X5EzNj901I87IWxGxi6V6LT+uSNETxJHQ/25bcFMV
         amRM9LB1t/tJwT6+eTslMWQKwf7eMXh0nlYgiDFFXnTcW8ykcuGP7Ax0hVRtOdYqrNqM
         SYrJb0+Qm6ISweiolg/j5K5PpZUaE/6qVyouka0kkur8FdyeucuuwoTLnhc81NRyjOI0
         Swpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729166767; x=1729771567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKq97N5zRC4Lxz0F+vgOE8YvVRBXTV9HFyV59txoqGI=;
        b=BmoU+kA3lt0cTfiaqJ6ER2xHQFGg8Nvrq+iyunnD0x5UM/XqvkO7wEHgOdu4G5pN6u
         muVvLiPccXUAjnJA2HZx1u3sIJK7698ZFJjE++DYHvmGCzUi7zme9KAv4gwyG60bEjbm
         WkJ+Eylw+C/vsMomTvobzLplFjqW9NwXvLwx4G/Ig92xmqWoZWJt5qaXZKIh1B2VSbaB
         UtfMIvT9CH+8rgcSfUCTV01C7BlRTLL4Vmq2rE4fDAbsvLJGU8EMxJzkT0X6iu1TwSqy
         AW0yjyHzRX33Ymp7gQe8FZgV32c8Cxc0VsU0+MLX9yWNRYlPLjITdZHQleTQEVquJ5D9
         AEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCURG0hf15/BMabpPyfK06Ggi3iLuB0bTfX1o5rvZ4mxhrHfQbTN+r74UDht3IItOdpqcrsNmsS8Fa9mAyg1@vger.kernel.org, AJvYcCW8wMbU8LtbueX8moGg4hlC5SDiU2BMtrptFofyvoRrmQTpSWrKtwr5FTrbDMmeLjty5/6mElCy9OylcEAG@vger.kernel.org
X-Gm-Message-State: AOJu0YxULdDJSXSd1vszZY7k0rKp+IKmnIZjbePfhrQtT30BfcW+rgcz
	TP3rdTTAISu5SmQH/U1LNplflVhhuIunM+y3Qte+BwSTxuJr6l6c
X-Google-Smtp-Source: AGHT+IEPXdFW7Lf3zyMozgP0+9CKqdI+BYZX1J+Cuy0DoOhSn6rg3Qb4Jv3wGy4d3JyACgTIs6oVDA==
X-Received: by 2002:a05:6402:4410:b0:5c8:8844:9942 with SMTP id 4fb4d7f45d1cf-5c9a5a1a179mr3732691a12.2.1729166766529;
        Thu, 17 Oct 2024 05:06:06 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-97-22.cust.vodafonedsl.it. [2.44.97.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d7b4a63sm2712275a12.79.2024.10.17.05.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:06:06 -0700 (PDT)
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
Subject: [PATCH v2] fs: Fix uninitialized value issue in from_kuid and from_kgid
Date: Thu, 17 Oct 2024 14:05:51 +0200
Message-ID: <20241017120553.55331-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocfs2_setattr() uses attr->ia_mode, attr->ia_uid and attr->ia_gid in
a trace point even though ATTR_MODE, ATTR_UID and ATTR_GID aren't set.

Initialize all fields of newattrs to avoid uninitialized variables, by
checking if ATTR_MODE, ATTR_UID, ATTR_GID are initialized, otherwise 0.

Reported-by: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2: fix ocfs2_setattr to avoid similar issues; improved commit description

 fs/ocfs2/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ad131a2fc58e..58887456e3c5 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1129,9 +1129,12 @@ int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	trace_ocfs2_setattr(inode, dentry,
 			    (unsigned long long)OCFS2_I(inode)->ip_blkno,
 			    dentry->d_name.len, dentry->d_name.name,
-			    attr->ia_valid, attr->ia_mode,
-			    from_kuid(&init_user_ns, attr->ia_uid),
-			    from_kgid(&init_user_ns, attr->ia_gid));
+			    attr->ia_valid,
+				attr->ia_valid & ATTR_MODE ? attr->ia_mode : 0,
+				attr->ia_valid & ATTR_UID ?
+					from_kuid(&init_user_ns, attr->ia_uid) : 0,
+				attr->ia_valid & ATTR_GID ?
+					from_kgid(&init_user_ns, attr->ia_gid) : 0);
 
 	/* ensuring we don't even attempt to truncate a symlink */
 	if (S_ISLNK(inode->i_mode))
-- 
2.43.0


