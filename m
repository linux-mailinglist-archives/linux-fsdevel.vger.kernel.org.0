Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E3674448
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 22:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjASVYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 16:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjASVWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062D73A857
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674162933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMg8gNQDfp59Z8c/Laiz+GjWJb2Q7J01BdsOGckaZ2o=;
        b=J5ch0s0Jszo2GpQmbTafpTqVFY7TdX5aR8AcVxPgOhIZfXK94Ll+j9cAqv0CzSTZ3kxzBZ
        +oV/xQb4JoDFsqxnSMpBx+Cf2VWnD4CUwWMEz6iwRjoTJnRLKG/DM9ywJ4lXZqfI2iPh/v
        zNdQyy6j52ypyUf8Zo+sxp4Wxy2VIm4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-343-p86UwoEbOmGY6g_c73lJog-1; Thu, 19 Jan 2023 16:15:31 -0500
X-MC-Unique: p86UwoEbOmGY6g_c73lJog-1
Received: by mail-qt1-f197.google.com with SMTP id ga12-20020a05622a590c00b003b62b38e077so1533443qtb.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMg8gNQDfp59Z8c/Laiz+GjWJb2Q7J01BdsOGckaZ2o=;
        b=dCOSfBXan/SdVvDKRmHc/rWKBGn58yj3L22AU73pmZlYNQQa6g0n2A9wDONwZw++Vr
         3rvIwkWzOnHHLDO0jQTq7fpjJVkLGTDE8BBe+fMk+ZjsmHqkWJR2BSMAYkwFDI7CEXCZ
         xOYx5wCes+GV8SdeWN3b5ULdlVmniyIyqux8UHKkfvLm+W/of8Xte5Yk4QtW4tVrJcm0
         lf15qcOU0QJxPviu30Lj30VyS4+NzLEdCiHxF+t7gWBjCIZmcXCimY8Z166hSJkN95yy
         XNOBkwyVUYMdB2k/2cTRS1x+a/wOnVDRm0/kDW9WEYNN7MTZ7PgX22LHGZW/R3aP/+dS
         2uoQ==
X-Gm-Message-State: AFqh2kqxa3K7ds5INe8KaeyK+RM6ZqvTGXBVZZ2+8MAieRSceiUiEY+3
        USdNwMfP/LKSRBd+1P+7lXN1NojvxdujUZs4avKDwUzrJm8zYI0f/iil6v3MH/NQOCGxDpFR5mO
        0maeGx4D+a1z5sqnodGuwTUAFxw==
X-Received: by 2002:ac8:45ce:0:b0:3b6:2e75:c9bd with SMTP id e14-20020ac845ce000000b003b62e75c9bdmr14633631qto.1.1674162929633;
        Thu, 19 Jan 2023 13:15:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvg7Cqm+RqOllnoGepwIah3wOQ0QFEfc8gtV8SZaGb8UPTC0/BLnk7Faj89h/7LOb3Hkn2f0w==
X-Received: by 2002:ac8:45ce:0:b0:3b6:2e75:c9bd with SMTP id e14-20020ac845ce000000b003b62e75c9bdmr14633616qto.1.1674162929441;
        Thu, 19 Jan 2023 13:15:29 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86798000000b0039cc944ebdasm19443699qtp.54.2023.01.19.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:15:29 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>
Subject: [RFC PATCH RESEND 1/1] fs/namespace: defer free_mount from namespace_unlock
Date:   Thu, 19 Jan 2023 16:14:55 -0500
Message-Id: <20230119211455.498968-2-echanude@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211455.498968-1-echanude@redhat.com>
References: <20230119211455.498968-1-echanude@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alexander Larsson <alexl@redhat.com>

Use call_rcu to defer releasing the umount'ed or detached filesystem
when calling namepsace_unlock().

Calling synchronize_rcu_expedited() has a significant cost on RT kernel
that default to rcupdate.rcu_normal_after_boot=1.

For example, on a 6.2-rt1 kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
           0.07464 +- 0.00396 seconds time elapsed  ( +-  5.31% )

With this change applied:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
        0.00162604 +- 0.00000637 seconds time elapsed  ( +-  0.39% )

Waiting for the grace period before completing the syscall does not seem
mandatory. The struct mount umount'ed are queued up for release in a
separate list and no longer accessible to following syscalls.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 fs/namespace.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab467ee58341..11d219a6e83c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -44,6 +44,11 @@ static unsigned int m_hash_shift __read_mostly;
 static unsigned int mp_hash_mask __read_mostly;
 static unsigned int mp_hash_shift __read_mostly;
 
+struct mount_delayed_release {
+	struct rcu_head rcu;
+	struct hlist_head release_list;
+};
+
 static __initdata unsigned long mhash_entries;
 static int __init set_mhash_entries(char *str)
 {
@@ -1582,11 +1587,31 @@ int may_umount(struct vfsmount *mnt)
 
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
+	struct hlist_head head;
+	struct mount_delayed_release *drelease;
+
 	LIST_HEAD(list);
 
 	hlist_move_list(&unmounted, &head);
@@ -1599,12 +1624,15 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
 
-	synchronize_rcu_expedited();
-
-	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
-		hlist_del(&m->mnt_umount);
-		mntput(&m->mnt);
+	drelease = kmalloc(sizeof(*drelease), GFP_KERNEL);
+	if (unlikely(!drelease)) {
+		synchronize_rcu_expedited();
+		free_mounts(&head);
+		return;
 	}
+
+	hlist_move_list(&head, &drelease->release_list);
+	call_rcu(&drelease->rcu, delayed_mount_release);
 }
 
 static inline void namespace_lock(void)
-- 
2.39.0

