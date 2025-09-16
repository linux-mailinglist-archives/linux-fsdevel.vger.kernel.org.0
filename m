Return-Path: <linux-fsdevel+bounces-61691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F693B58D7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B6317776D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BD62798E5;
	Tue, 16 Sep 2025 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEJwboRo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC62ECD1D
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998177; cv=none; b=ne73H++2jBvzklOa+yd+2ufiYjo9vZ1Q4CR/4UmRLyr1r1AvKSOPBmjRIcncN6X5TxE6+QDOOvA0Hpob+lxQ2vlnVs7hcpYTk7rr0V/k7t6TOD/AmOXYkU3jrqOiM+2Izcg8MgPY3cv8t7FIMAncNBBjcnbvM+GuMQDsM+6hB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998177; c=relaxed/simple;
	bh=dy9spvLipBJ0oxpRy6D3U8JeqM1cA+2DUbEARoiEIho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXd9KQ6yVxNQPOZs9OBHXISEemHeFpgK5W4Ka8MM4CAIL+lW9r/eatNds5Uv1M7LwpU1DsiNLxcvTzRSv0CZsyKNYLV1QOPI8zdh/xNCsK9nKPypzDcY9Jhct3M5FTU9sGR6XnZaAENFtscOZZ6MOTFpRFxg1Is8hff7HJVhLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEJwboRo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-261682fdfceso22360475ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998174; x=1758602974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kee/jWM05xMj5MjToYK8a9EUY/mguZ7xPQQnB3cJ53E=;
        b=WEJwboRoA+7Q/dtbpjLY1iSOzyDv2c7nLD5tzESh/xoo13VNtR/TuEemvpBow5vvEn
         H7ry4eNsUi4IQV8DjKDpbV4r0L5NEiNdbzxgZ9uF1g6TLnrD4vmU5xiiUDdvRUp82yHX
         5XmgyQKs33tjnmDUjMrqxpFjpFB6RPqKiIYNPBfImWxQHKjvIJQIuhSjg3OwcMtI6Sfo
         i4HnREvhWsFyA7lO140ZMwL9JUpp5QX2ZSunJSuv006RmJnQTtQVVYSSc8waQPaTuRg6
         2dO06Xyt+iuxUmp3SRacsW6eS/lXTsOf7kwLF/UWzELlusoGLpEM/leXstF1sKj4podi
         n90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998174; x=1758602974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kee/jWM05xMj5MjToYK8a9EUY/mguZ7xPQQnB3cJ53E=;
        b=Nu9XPptxqoISpJfOS0VEmZ0rXcSrlYZUGEEGF12JRIvGrnnc9PIibq5JGcuG3jYnD6
         OnROFTCWHJkdkJ5StppDEEoZn5k+y1CHoBFoNlfFi0mjuIHDHh+Uueyr8yKKXK22jt8a
         b1zYi18rvtPdn+MOTrklVNr05byKFLbzFNlS6/dCKpuO5bdDx96JshRn0/wGeLHw/i5t
         0OmTlt4Qzn0QoIHDQgB79miuZ3j1Ubwc7fgIc19MMfX8gdAPa/CKTIusP5PZ737PPGn2
         fy4FsVlZYvdq2TG6bdqsrkTYOOrjfjkeOsfl2nkDDWYGFdBeJEPkIj454hQXHoLcIsHG
         706g==
X-Forwarded-Encrypted: i=1; AJvYcCVYEg/P+bq34YgTHl8eDQ7fkL+uHOfDswOkEqTjTj5m62bXuYVpDDy2/KAM1Tu2lPR+h3ezb4Tnygjge5sE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6rgWaBe4/iWexRPmr16EYmm3s7R+g8q0YaGdsu40d5WwVTdU
	09zDpFbqDL03tmoKdBJopRzPxI25ZBO45lCA5qhewQT5+Vq+nxk5CICd
X-Gm-Gg: ASbGncueJ8pvBKwUiDoED7045xYV5KB1D/hJp5NMX6sOvXiCjvPzyBOjFaX7U1RtqOm
	DAcpZ2sDlTz/Q2ahKgTNcS1FY7tlvWwyWyIRcxBRbm5CWZL41wIbQYEGSxY3UXyXwzyOCglC5aG
	b/724beouhdRKCBKxt7RN5Y/AF/TTmq56tbcmAJtYr0JgTduVBF/Ila11mlUyfRjFTb61fdN7NQ
	gdnEeZ3VvCjsMASNh6BuGMZesVvhf7ViL/NS9vbNRNfhdKW5p33n8IXJicEsYk5VPNgEZqS1DkA
	EgZXtyVyPq1ufHMDF5q8yPSG0V5K2wjnhCfCPIvObQO44jj4Q7MEV6Cr9HqsKiSNaNVktJ0TlsY
	JOqJVbs0bRvrJunjhq0jeC2jiZ0ZnV7q8S/Bs4xc=
X-Google-Smtp-Source: AGHT+IHQsp/jp2h5qh/u2y0fwJLYw3kUJFgybrRxf3n883LnUrw88kxlxQMidQOFwo4KtZaOVgbKQg==
X-Received: by 2002:a17:902:cecc:b0:267:a1d5:7372 with SMTP id d9443c01a7336-267d151fba1mr14211985ad.4.1757998173983;
        Mon, 15 Sep 2025 21:49:33 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:33 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 12/14] net: amt: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:33 +0800
Message-Id: <20250916044735.2316171-13-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/amt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index ed86537b2f61..aaed9fbc7526 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -295,7 +295,6 @@ static void amt_source_work(struct work_struct *work)
 
 	tunnel = gnode->tunnel_list;
 	spin_lock_bh(&tunnel->lock);
-	rcu_read_lock();
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		amt_destroy_source(snode);
 		if (!gnode->nr_sources)
@@ -306,7 +305,6 @@ static void amt_source_work(struct work_struct *work)
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 }
 
@@ -426,7 +424,6 @@ static void amt_group_work(struct work_struct *work)
 		goto out;
 	}
 
-	rcu_read_lock();
 	for (i = 0; i < buckets; i++) {
 		hlist_for_each_entry_safe(snode, t,
 					  &gnode->sources[i], node) {
@@ -443,7 +440,6 @@ static void amt_group_work(struct work_struct *work)
 		amt_del_group(amt, gnode);
 	else
 		gnode->filter_mode = MCAST_INCLUDE;
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 out:
 	dev_put(amt->dev);
@@ -1327,11 +1323,9 @@ static void amt_clear_groups(struct amt_tunnel_list *tunnel)
 	int i;
 
 	spin_lock_bh(&tunnel->lock);
-	rcu_read_lock();
 	for (i = 0; i < amt->hash_buckets; i++)
 		hlist_for_each_entry_safe(gnode, t, &tunnel->groups[i], node)
 			amt_del_group(amt, gnode);
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 }
 
@@ -1343,11 +1337,9 @@ static void amt_tunnel_expire(struct work_struct *work)
 	struct amt_dev *amt = tunnel->amt;
 
 	spin_lock_bh(&amt->lock);
-	rcu_read_lock();
 	list_del_rcu(&tunnel->list);
 	amt->nr_tunnels--;
 	amt_clear_groups(tunnel);
-	rcu_read_unlock();
 	spin_unlock_bh(&amt->lock);
 	kfree_rcu(tunnel, rcu);
 }
-- 
2.34.1


