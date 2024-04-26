Return-Path: <linux-fsdevel+bounces-17941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B58B408C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 21:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F1428B4EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A072C1A2;
	Fri, 26 Apr 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBPg3qq5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F8282E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161357; cv=none; b=WZ6PF9IedCRbuMpfOdhAAoo0L6oVOsaSZtYoqLxdlViYolAEY7FqaRWfCowFVafKuQ4gcLUJgI6WYUK+YvfDgFwnVEf5FstHEHqy67mc13B5iq9hMsoLq5nk7KP8y0h+E/vLRHKcVs+VHcx7dIiLkGu9XNJJS5BD8QBGaeKfbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161357; c=relaxed/simple;
	bh=6AK1a+YGlSdrMLec/1Sholu7r5pO4ZP20qs3Z/D68a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoPERRm6yv4XCUpPeV6ioNDaxMeiqBfKHPM9DgtcufKCmyYbHrkRqebHcE9pxraET8cBB2dJxH+VHpeCc8VBuYXk+ehk2CrxqmnUVN0YjzrClJXTxkzDpSZ/EL05FLAZ2M/pWs7XJCR65/2G9LXQn3erbokWplD11tooyg22ing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBPg3qq5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714161354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYTN7Rkmmp1WWVEQ1FtYo1Y7cK63p7rGfuFTRkrq4H4=;
	b=iBPg3qq516eagFj/68eSIQ7GDDll1pcQvrspODynR7XOMWl8QTA2pN0qBsNftrK0WCV/7W
	G5H/QJSPgiEyum9nU/D7vcAOGJpGCzV5FRF6b2dWSLfc/qkcEkfOwkGWjO+JvEJYvo7vJJ
	LQ7UkhOpYZwtsHobGTOK1bMhGy6zdto=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-wCtE_vtnNfqE5aZw3P-pSA-1; Fri, 26 Apr 2024 15:55:52 -0400
X-MC-Unique: wCtE_vtnNfqE5aZw3P-pSA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69b7deb5c75so27653226d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 12:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714161351; x=1714766151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYTN7Rkmmp1WWVEQ1FtYo1Y7cK63p7rGfuFTRkrq4H4=;
        b=l+lsG2hMMuPRkVgUvVsdWBtHUpioB2abZi7MDfRjkCDj9GfE4eMWoEKwr8z2gzc0Xf
         owoRJ5oixU7W2TjUrwWMcunBVOn/Xt0sXAvSC3/sYIuxDIAEaJezqsbK6ny5op6eSsWd
         H3D+weFJSwFNoU1vpFxAIrYR6U4RuSHAm4EssyoS5OAXEg74uB8KdVOzTv/uvciKXa1r
         0Ozr7ezZRnzNBxoJHCPty3aO5OjZXVb/b9fvf+AnT5Arh4vgtePHgstZE9d96b47sGTp
         7OBOyUapixvfUNalU1KnVjiJ7bxQRFDXbcNtlPpAGezsWHnkN7j4HliTiSxHl2bsDGYW
         w3BQ==
X-Gm-Message-State: AOJu0YzXaFfj+TXVRPc/lkbanO1IN5qRXloETd6KuFju8eNVhiI9NMD3
	lHtVkMnxPbCktaBUDgA2Ldc7X/U1lhr+ikNGFc86exNMd7q3QCWaXEP63neScTOiWYYsL0tXoRW
	ZHbk/n8GoPHHN528PUNStnDbatyMiFC+vnqrGe48X85jMG6b7RrLrLmj2TkpMxr0=
X-Received: by 2002:ad4:5ca3:0:b0:6a0:7e34:b70d with SMTP id q3-20020ad45ca3000000b006a07e34b70dmr794259qvh.39.1714161351057;
        Fri, 26 Apr 2024 12:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmzcCv0w9vmIOTyVKZqwKRolLaIQkIYXO1xIFSQqQQoX9JIOBYX5RY7O8hZ+Fcf1u0NlO4Ng==
X-Received: by 2002:ad4:5ca3:0:b0:6a0:7e34:b70d with SMTP id q3-20020ad45ca3000000b006a07e34b70dmr794243qvh.39.1714161350746;
        Fri, 26 Apr 2024 12:55:50 -0700 (PDT)
Received: from fedora.redhat.com ([142.189.203.61])
        by smtp.gmail.com with ESMTPSA id v3-20020ad45343000000b006a0404ce6afsm1882268qvs.140.2024.04.26.12.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 12:55:50 -0700 (PDT)
From: Lucas Karpinski <lkarpins@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexl@redhat.com,
	echanude@redhat.com,
	ikent@redhat.com,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: [RFC v2 1/1] fs/namespace: defer RCU sync for MNT_DETACH umount
Date: Fri, 26 Apr 2024 15:53:48 -0400
Message-ID: <20240426195429.28547-2-lkarpins@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426195429.28547-1-lkarpins@redhat.com>
References: <20240426195429.28547-1-lkarpins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use call_rcu to defer releasing the detached filesystem when calling
namespace_unlock() during a lazy umount.

When detaching (MNT_DETACH) a filesystem, it should not be necessary to
wait for the grace period before completing the syscall. The
expectation that the filesystem is shut down by the time the syscall
returns does not apply in this case.

Calling synchronize_rcu_expedited() has a significant cost on RT kernel
that default to rcupdate.rcu_normal_after_boot=1. The struct mount
umount'ed are queued up for release in a separate list
once the grace period completes while no longer accessible to following
syscalls.

Without patch, on 6.9.0-rc2-rt kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
        0.02756 +- 0.00299 seconds time elapsed  ( +- 10.84% )
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
        0.04422 +- 0.00521 seconds time elapsed  ( +- 11.79% )

With patch, on 6.9.0-rc2-rt kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
	0.02852 +- 0.00377 seconds time elapsed  ( +- 13.20% )
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
        0.0030812 +- 0.0000524 seconds time elapsed  ( +-  1.70% )

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
 fs/namespace.c | 51 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315c6678..df03fc0d1990 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -45,6 +45,11 @@ static unsigned int m_hash_shift __ro_after_init;
 static unsigned int mp_hash_mask __ro_after_init;
 static unsigned int mp_hash_shift __ro_after_init;
 
+struct mount_delayed_release {
+	struct rcu_head rcu;
+	struct hlist_head release_list;
+};
+
 static __initdata unsigned long mhash_entries;
 static int __init set_mhash_entries(char *str)
 {
@@ -78,6 +83,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+static bool lazy_unlock = false; /* protected by namespace_sem */
 
 struct mount_kattr {
 	unsigned int attr_set;
@@ -1553,16 +1559,39 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
-static void namespace_unlock(void)
+static void free_mounts(struct hlist_head *mount_list)
 {
-	struct hlist_head head;
 	struct hlist_node *p;
 	struct mount *m;
+
+	hlist_for_each_entry_safe(m, p, mount_list, mnt_umount) {
+		hlist_del(&m->mnt_umount);
+		mntput(&m->mnt);
+	}
+}
+
+static void delayed_mount_release(struct rcu_head *head)
+{
+	struct mount_delayed_release *drelease =
+		container_of(head, struct mount_delayed_release, rcu);
+
+	free_mounts(&drelease->release_list);
+	kfree(drelease);
+}
+
+static void namespace_unlock(void)
+{
+	HLIST_HEAD(head);
 	LIST_HEAD(list);
+	bool lazy;
+
 
 	hlist_move_list(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
 
+	lazy = lazy_unlock;
+	lazy_unlock = false;
+
 	up_write(&namespace_sem);
 
 	shrink_dentry_list(&list);
@@ -1570,12 +1599,21 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
 
-	synchronize_rcu_expedited();
+	if (lazy) {
+		struct mount_delayed_release *drelease =
+			kmalloc(sizeof(*drelease), GFP_KERNEL);
 
-	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
-		hlist_del(&m->mnt_umount);
-		mntput(&m->mnt);
+		if (unlikely(!drelease))
+			goto out;
+
+		hlist_move_list(&head, &drelease->release_list);
+		call_rcu(&drelease->rcu, delayed_mount_release);
+		return;
 	}
+
+out:
+	synchronize_rcu_expedited();
+	free_mounts(&head);
 }
 
 static inline void namespace_lock(void)
@@ -1798,6 +1836,7 @@ static int do_umount(struct mount *mnt, int flags)
 	}
 out:
 	unlock_mount_hash();
+	lazy_unlock = flags & MNT_DETACH ? true : false;
 	namespace_unlock();
 	return retval;
 }
-- 
2.44.0


