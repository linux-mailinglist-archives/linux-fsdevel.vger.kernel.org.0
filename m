Return-Path: <linux-fsdevel+bounces-77491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LH0NrQwlWmeMwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:23:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC3E152D53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B20A03055E58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 03:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B8E2EC090;
	Wed, 18 Feb 2026 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrPqB6VR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F22DB780
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771384973; cv=none; b=hi98ZIHi12S9PoOvq3h6kRTt2KJs+/f7hYknu0pJAhggYSIX+mMV4OrZXQlJL4j65ccUCNaIivdJh7O45E1HxNOH70uOGj+55z7RmnljOj96n/Y+VQXccO/vEsMDmKCkRDclpL3v8mULkatFypPrawAmEEiCsvPbqyRiZySWF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771384973; c=relaxed/simple;
	bh=eJq/+XMB6svi9x0AYQBnKDSKHm/BAthL5E4dV59waz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CNfVicZd0t2rkvuygAkpTxQQe9jQfd8m7hdNJkXRjC4QTq67sQpNuRpzhhnU69Ny6adefIciTh9s5F5aUzz3CN/pcaVDJ9W9IaNuZavGUqBmK0hYhREgr+owGLXmo33RqDTS3CFoVon+6oyDuOEdimH+DBjSNGYQApM5q/ArpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrPqB6VR; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso4116428a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 19:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771384971; x=1771989771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIqN0vs9eY+KC/olxzGPUhC+4vShBUNYIEvhGLetjOc=;
        b=CrPqB6VRjy9s9BTsODgdfyZcG4t9vTioT9RzS8smM/SxCtfy1JM8584ZJ6bIhadpSI
         IHOzbJVNXtlowFPYiE5pILX2MH6B3Fq8ua5Un1ktmxXYm96cFSMav6QWbeIvwVjWnd6p
         N56tXqMyGO5Mx3Z1IwDGF9fxMrGiHsccr6KUeMce+y9+p00+Y2EkCt8Fj0VycRM995i1
         EtB3Ip7wYhSp6xFlGVHJvVGNjA3m4nTYIj4MTNfA9TW8boOXas42PnVxTrIVtCd797Hp
         v3Bm0dDYXkOyC7WJItPZLObHSPCV4d7Q0HeWPHc7pQzkOeV19XxpUhZPYE/Hyr8jw7IQ
         GtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771384971; x=1771989771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIqN0vs9eY+KC/olxzGPUhC+4vShBUNYIEvhGLetjOc=;
        b=BCZUKuzEkhMzYZDx0B6Mz4Qw2ubUcmk4kt7xTNL+McN3nA3gE6cmKKaFjviSZuYaFy
         XFeiDIDtjitcTrMfJJtLAfd7JV50gcXzVzuN/1AMRIWv6wZJCoCL4xg36lLC5ryr82Lh
         VuEkxVLX+qf4YsPpExaTAKkVNs5NRzvSWkSBjkfascMuezdW3Qx7LElmyJJ8Ge+bPaHj
         AVqfpovzN0LcsEoZPRzDkoMFfUzNPhoHSbFV7azWCNHt/16ZftDMvHFdZmCmEzl3w29J
         72+dxpRYKuevPw9QOfcl1eIsFo4dpoN13iTAAKYZ53P2RrWe/P0AdOqxvHJ/YjqPjaIS
         oDIA==
X-Forwarded-Encrypted: i=1; AJvYcCWWMLBwsdfzsJ151qYqdJP5aYwhh1F8aANaYLKWohPdIDv2lTHFN1iHD8dotqrPJ5CemKZLc7MnW1rzuHJm@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTzRSJegJaAhb160/dQWeNXTUUoTx4WKTdFKV5CbcqIaLkazk
	FzgGbfv+RGGTHxI8EAgJRc2jwvEOIP+o4Mu+gVGPOZbBoiXeVwlwnaIS5NWVjmsB+9AGy52ihKY
	mlzc1QymiHsF13BSvug==
X-Received: from pgbda14.prod.google.com ([2002:a05:6a02:238e:b0:c65:c5fc:1707])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9d4c:b0:38d:fad1:cf2a with SMTP id adf61e73a8af0-394837816admr11609765637.13.1771384971359;
 Tue, 17 Feb 2026 19:22:51 -0800 (PST)
Date: Tue, 17 Feb 2026 19:22:30 -0800
In-Reply-To: <20260218032232.4049467-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260218032232.4049467-2-tjmercier@google.com>
Subject: [PATCH v3 1/3] kernfs: allow passing fsnotify event types
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77491-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FC3E152D53
X-Rspamd-Action: no action

The kernfs_notify function is hardcoded to only issue FS_MODIFY events
since that is the only current use case. Allow for supporting other
events by adding a notify_event field to kernfs_elem_attr. The
limitation of only one queued event per kernfs_node continues to exist
as a consequence of the design of the kernfs_notify_list. The new
notify_event field is protected by the same kernfs_notify_lock as the
existing notify_next field.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/kernfs/file.c       | 8 ++++++--
 include/linux/kernfs.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9adf36e6364b..e978284ff983 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -914,6 +914,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
+	u32 notify_event;
 repeat:
 	/* pop one off the notify_list */
 	spin_lock_irq(&kernfs_notify_lock);
@@ -924,6 +925,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	}
 	kernfs_notify_list = kn->attr.notify_next;
 	kn->attr.notify_next = NULL;
+	notify_event = kn->attr.notify_event;
+	kn->attr.notify_event = 0;
 	spin_unlock_irq(&kernfs_notify_lock);
 
 	root = kernfs_root(kn);
@@ -954,7 +957,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (parent) {
 			p_inode = ilookup(info->sb, kernfs_ino(parent));
 			if (p_inode) {
-				fsnotify(FS_MODIFY | FS_EVENT_ON_CHILD,
+				fsnotify(notify_event | FS_EVENT_ON_CHILD,
 					 inode, FSNOTIFY_EVENT_INODE,
 					 p_inode, &name, inode, 0);
 				iput(p_inode);
@@ -964,7 +967,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		}
 
 		if (!p_inode)
-			fsnotify_inode(inode, FS_MODIFY);
+			fsnotify_inode(inode, notify_event);
 
 		iput(inode);
 	}
@@ -1005,6 +1008,7 @@ void kernfs_notify(struct kernfs_node *kn)
 	if (!kn->attr.notify_next) {
 		kernfs_get(kn);
 		kn->attr.notify_next = kernfs_notify_list;
+		kn->attr.notify_event = FS_MODIFY;
 		kernfs_notify_list = kn;
 		schedule_work(&kernfs_notify_work);
 	}
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index b5a5f32fdfd1..1762b32c1a8e 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -181,6 +181,7 @@ struct kernfs_elem_attr {
 	struct kernfs_open_node __rcu	*open;
 	loff_t			size;
 	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
+	u32			notify_event;   /* for kernfs_notify() */
 };
 
 /*
-- 
2.53.0.310.g728cabbaf7-goog


