Return-Path: <linux-fsdevel+bounces-22545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0BE9198D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 22:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0A9B21460
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B134192B8B;
	Wed, 26 Jun 2024 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAuwkc8F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893A18E743
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432974; cv=none; b=BIn/KFZkTXe5rK33vAbIy5ixmQszXiWfZy7xu3AukGFx/vxxuWZXkhZs9QiuqpThhMRc+9uKLOgJUqaYd9eIf0qnm6m2zcFt6olDaKU/In9JBVJlJkQw3wZ664n6X8IA8v8cKBB/T37hvw3f47CncG27uxhgMJ3IkTps1t2z0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432974; c=relaxed/simple;
	bh=57yp1JvK39fo402WoHd9B0/azjUglczC0SomYnvtUlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS0gKzTQ3swOxCe2jgsoDz7go/Homc2drVzSPeQsBCsFdKV7OTCI7xpEp5MGEgLTle0396nw/e28TXCtdT/RUbMzTelIrnkUPJiP0J/LEMxcST0s+ZgxOqjffPnYfnuDd8sdMj6+dDIi/4TkCm8XgR3gCAXy5mmm/vGrl7AAc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAuwkc8F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719432972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAtyJo3C+DNzKsKiEowHQNwEpk0Vo0c/tZ83GDjcvuc=;
	b=UAuwkc8FIiC8jv+yVOrqKQCT9ymjUFHyqqNjlxhxWVCvCson2piwjil3/Z/UbXvhB9RZcl
	r4XT7hcvZjT35zZNpK5SxzSj0RzPuESkSe62yYRK6uIO5HAPuLacxZ2+dS7/Hyd81q0Fu7
	ObBYWpndmwHeptpzmV1zEhzMioP8D0I=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-p_5XoxQCOeWy2uUPAumVSQ-1; Wed, 26 Jun 2024 16:16:08 -0400
X-MC-Unique: p_5XoxQCOeWy2uUPAumVSQ-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4ee6b623fcbso3835479e0c.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 13:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719432968; x=1720037768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAtyJo3C+DNzKsKiEowHQNwEpk0Vo0c/tZ83GDjcvuc=;
        b=hzHd4qhLYgZWp+kcX29uVdgNLr0FssyXB/v4gtm/rJk3MwVABvCf9Ll8RvNP9FmR5D
         BypxWm69I9ti0ctAa/62pYK/SkgPAzE4tizukUJYPik7zh4I82XihPRHVZgNKqc0trMY
         EX1ZVlLPQSFaP20L5UDk3HyPQNkTAkuh6Lj5TIpGSyX1IofQRYpuj6Wz4fDil4PS1jeg
         bgJgqMXjpcl3Zplg1vo0lJ6bPp0gR2LJSzs7mp4x8lrVxvnWeqPVbRqCJhSvW86+2oU8
         Nb6l5WDR7gx56ulqV7JWMlbcWLeeJ/WdtcZpg+S8PmtnuC9DdMze7P+FMNHr62Wg4KfB
         j1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWxD4tCQYGAZq5wpsdrKmh1otoSSPS/FvKcv/mabuOsG/ojNKXC9Rlb4s5NUC+aAYSOFitusAsMbzqb/Xf0iAFI2PENJyXddOZTzEXmg==
X-Gm-Message-State: AOJu0YwZWyBsSU0tYY0oqZugLqqYwUEjbo8vnZbGYzJcohKf+LjeW8m7
	UPk3+A2VJr8BokNW7pfqFlWO72Dp4KKM9I3vHE7Ue5hG4ECLNUkNvFYrAlq52GOtwGkCPWA1sZP
	XJW1D5epbieeQSsid3zzzWHfe263G+srRrqm8Yjn4PALDgZvw6itiKnttrmCAF0A=
X-Received: by 2002:a05:6122:1ad0:b0:4ef:678e:8a90 with SMTP id 71dfb90a1353d-4ef6d7d7e4dmr10392696e0c.3.1719432968270;
        Wed, 26 Jun 2024 13:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+AVBumMcz1NhI8kTVR8vo0K9s+4+KliqaUtgF9wvd56bUA6NFigpFBYlBIceQ9rC2Wxb1nw==
X-Received: by 2002:a05:6122:1ad0:b0:4ef:678e:8a90 with SMTP id 71dfb90a1353d-4ef6d7d7e4dmr10392685e0c.3.1719432967980;
        Wed, 26 Jun 2024 13:16:07 -0700 (PDT)
Received: from localhost.localdomain ([174.91.39.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfef30sm57710316d6.17.2024.06.26.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:16:07 -0700 (PDT)
From: Lucas Karpinski <lkarpins@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: raven@themaw.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Karpinski <lkarpins@redhat.com>,
	Alexander Larsson <alexl@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ian Kent <ikent@redhat.com>
Subject: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Date: Wed, 26 Jun 2024 16:07:49 -0400
Message-ID: <20240626201129.272750-3-lkarpins@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626201129.272750-2-lkarpins@redhat.com>
References: <20240626201129.272750-2-lkarpins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When detaching (MNT_DETACH) a filesystem, it should not be necessary to
wait for the grace period before completing the syscall. The
expectation that the filesystem is shut down by the time the syscall
returns does not apply in this case. The synchronize_expedited() is not
needed in the lazy umount case, so don't use it.

Without patch, on 6.10-rc2-rt kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
        0.07333 +- 0.00615 seconds time elapsed  ( +-  8.38% )
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
	0.07229 +- 0.00672 seconds time elapsed  ( +-  9.29% )

With patch, on 6.10-rc2-rt kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
        0.02834 +- 0.00419 seconds time elapsed  ( +- 14.78% )
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
        0.0029830 +- 0.0000767 seconds time elapsed  ( +-  2.57% )

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
Suggested-by: Ian Kent <ikent@redhat.com>
---
 fs/namespace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315c6678..5d889e05dd14 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+static bool lazy_unlock = false; /* protected by namespace_sem */
 
 struct mount_kattr {
 	unsigned int attr_set;
@@ -1555,6 +1556,7 @@ EXPORT_SYMBOL(may_umount);
 
 static void namespace_unlock(void)
 {
+	bool lazy;
 	struct hlist_head head;
 	struct hlist_node *p;
 	struct mount *m;
@@ -1563,6 +1565,9 @@ static void namespace_unlock(void)
 	hlist_move_list(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
 
+	lazy = lazy_unlock;
+	lazy_unlock = false;
+
 	up_write(&namespace_sem);
 
 	shrink_dentry_list(&list);
@@ -1570,7 +1575,8 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
 
-	synchronize_rcu_expedited();
+	if (!lazy)
+		synchronize_rcu_expedited();
 
 	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
 		hlist_del(&m->mnt_umount);
@@ -1798,6 +1804,7 @@ static int do_umount(struct mount *mnt, int flags)
 	}
 out:
 	unlock_mount_hash();
+	lazy_unlock = flags & MNT_DETACH ? true : false;
 	namespace_unlock();
 	return retval;
 }
-- 
2.45.2


