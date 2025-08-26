Return-Path: <linux-fsdevel+bounces-59240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A17B36E20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D7D7C82A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD33568E5;
	Tue, 26 Aug 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xGobScvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C08350D75
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222862; cv=none; b=JHVH69DJfv/EqDbv1SE6NR7Ee3jVqfggBrLSpEKcKrRB1J6Oxj3fHqf1yUUtwPObkjVWCXiHZHgebGbliq/i4bzT5X8GruSEVv0B66uaDd1nEP4TvfK3BaD7j/BKJlnMwDV4BcrQJ8OV0CqwG10T/NwzTu/dLg0jDe8Tj9/xBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222862; c=relaxed/simple;
	bh=LR7CWXTHq8PxRLgtCmpwYh94UJBJq3AtMLa8nfpVhLw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtvoPc1H4/JEiW5U/9i/7pJ1Gky3hz7QHgSrEA7tVjiOxsDU8vud026ot61veGyMsxgbJ9ylgIcVRwJRGw06Dlww3ByrfDm2SWUarthWHde+6AOkd36Gwmbuvn+abExHvCG+JEBggdE8Svoh86FMyLgMR0vmPJU8OfYX5B+5lEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xGobScvO; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d6059f490so51931437b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222859; x=1756827659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/a4qa/ANgmJB/A00Ci0w/v1yDlD4/6YZQSFqLG2Lykw=;
        b=xGobScvOKjFNjNtKVJ0YWqAXe7M8eSOgx724pEAloiCi1mWxhUIIOC3Bl5UaHcG8Hs
         o5BghR8D7F0/QjZGTPfylyv5nNhYVtglMrwbgdW5fRWq78SLj4kiUc8Dyvu6K/9busW7
         3EuWM3z4+Kyqpao0qjGV69K1GI6tTVR9lXxo7ozCJPICP88baqyw+oN5uSvyD5vRQ82U
         orTQsqnS03EwprlaGHU0TDwqIKGCZ7FluJdpfk+jjsWNKArT9YtpOyv9R+DmoVGfRdKa
         nD0J9Ej5bEp9bnI+kS1RW8OD756lKLyh133p948mm3NZjFo0t/xTm8T9bM+Iq8VbOqnA
         7IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222859; x=1756827659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a4qa/ANgmJB/A00Ci0w/v1yDlD4/6YZQSFqLG2Lykw=;
        b=m0c7H/wdkuz43TgBaMYI0eGZd99Ez8HDApcBP7yQ5aUbqp8TFyT8BoGOOXXQfOazCk
         oQBLoVYeRU2Io5aKVGuPI2eVpwR7nJx/zXJVfHzMkUMjiIGJZS9caHLXa+p9l4dUIPw0
         vQN+TdJiahmkpmtyYoP06NOx9ENnZIdivG/YZRFxGhn9AwpLhlAdNsp3EZIwhrPw6t7F
         5XNoc1hLZXmLPozPMfK/7i5WwQhSnQIMA2/iXbCYX36vBEtyPToPepNHZ80eHgrz8SCf
         L0sCPIWr75x0NNJwkohEaMWsen4giQ1VVeGL5tmSqydHwPSxmyNmvsXccY5zOOMa90tn
         q46Q==
X-Gm-Message-State: AOJu0YwLtjVW0snxT1FEHh2mBnm7Z6PYEY6P4B13QKR94e0DjmybapOj
	7wnfmUttBa9/qwbBMJaaqZkyFN4enMdQ4cV/rezHp+oCIwxORbv5bviY4ohSCqBYgQx5Wk8d8qW
	QFSmZ
X-Gm-Gg: ASbGncsAQjhb5+T7xcoUuFIf5hZnNYPqcGvNvJiZgKGHSkHv0m25J4Weu+FH3KD4D0Z
	iwKhb1vzEnOiIlsV2RzGrNyI2UufBXtgyvt8D1/mP3DL6WdvQpFuyoKOrYD5vGMSHOzmODCh2kW
	ihtOXG+nMtbZuVtfc2zAGuMhY18rS+g/i6xzyftcuDs8LLpNGSbYHAnI2wGS3O6zZdPJmcF61kl
	pEcS7sREkLM3Ubte2g2OWxRzpLqxB3Fo6MITF2QBkpHwA590Vydfp3r8ZHWMPPjYvoYXP9LFnVg
	qK83T7RG9XLd8FNqoV6psXpg2gJoWOGC4ODZ8xmvH44tIeI9Ud/DvNiLAPX9klyTIOFv1wrNCVN
	SouJK94rqeV/KUlYqz4ePdtO+SApsVo2X2MBQ2QwzQWz+ScNPGxBxp4rwtzJGauWI4mvMAQ==
X-Google-Smtp-Source: AGHT+IEFN3CKkE+Hnj7Gi8IBgNUKfldwmoPTHprUzkt1izn6bJ+Tpqgf5eBYIsK3AJ5tcpghHEF8Yg==
X-Received: by 2002:a05:690c:8691:20b0:71f:f195:808d with SMTP id 00721157ae682-71ff19587d2mr100321947b3.5.1756222858629;
        Tue, 26 Aug 2025 08:40:58 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b1b7dsm24961717b3.62.2025.08.26.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 07/54] fs: hold an i_obj_count reference for the i_io_list
Date: Tue, 26 Aug 2025 11:39:07 -0400
Message-ID: <e9c6b9533098baca9f7967bcb15de23e12b84134.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the inode is attached to a list with its i_io_list member we need
to hold a reference on the object.

The put is under the i_lock in some cases which could potentially be
unsafe. It isn't currently because we're holding the i_obj_count
throughout the entire lifetime of the inode, so it won't be the last
currently. Subsequent patches will make sure we're holding an
i_obj_count reference while we're manipulating this list to ensure this
continues to be safe.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cb5e22169808..cf7fab59e4d5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -72,6 +72,14 @@ static inline struct inode *wb_inode(struct list_head *head)
 	return list_entry(head, struct inode, i_io_list);
 }
 
+static inline void inode_delete_from_io_list(struct inode *inode)
+{
+	if (!list_empty(&inode->i_io_list)) {
+		list_del_init(&inode->i_io_list);
+		iobj_put(inode);
+	}
+}
+
 /*
  * Include the creation of the trace points after defining the
  * wb_writeback_work structure and inline functions so that the definition
@@ -123,6 +131,8 @@ static bool inode_io_list_move_locked(struct inode *inode,
 	assert_spin_locked(&inode->i_lock);
 	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
+	if (list_empty(&inode->i_io_list))
+		iobj_get(inode);
 	list_move(&inode->i_io_list, head);
 
 	/* dirty_time doesn't count as dirty_io until expiration */
@@ -310,7 +320,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 	if (wb != &wb->bdi->wb)
 		list_move(&inode->i_io_list, &wb->b_attached);
 	else
-		list_del_init(&inode->i_io_list);
+		inode_delete_from_io_list(inode);
 	wb_io_lists_depopulated(wb);
 }
 
@@ -1200,7 +1210,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
-	list_del_init(&inode->i_io_list);
+	inode_delete_from_io_list(inode);
 	wb_io_lists_depopulated(wb);
 }
 
@@ -1308,16 +1318,23 @@ void wb_start_background_writeback(struct bdi_writeback *wb)
 void inode_io_list_del(struct inode *inode)
 {
 	struct bdi_writeback *wb;
+	bool drop = false;
 
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
-	list_del_init(&inode->i_io_list);
+	if (!list_empty(&inode->i_io_list)) {
+		drop = true;
+		list_del_init(&inode->i_io_list);
+	}
 	wb_io_lists_depopulated(wb);
 
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&wb->list_lock);
+
+	if (drop)
+		iobj_put(inode);
 }
 EXPORT_SYMBOL(inode_io_list_del);
 
@@ -1389,7 +1406,7 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 	 * trigger assertions in inode_io_list_move_locked().
 	 */
 	if (inode->i_state & I_FREEING) {
-		list_del_init(&inode->i_io_list);
+		inode_delete_from_io_list(inode);
 		wb_io_lists_depopulated(wb);
 		return;
 	}
-- 
2.49.0


