Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6A6743E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 22:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjASVDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 16:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjASVBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149FA1018
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 12:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674161848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMg8gNQDfp59Z8c/Laiz+GjWJb2Q7J01BdsOGckaZ2o=;
        b=B9LMim7hpI/xfFEpfdJDvNneIWI4w0oKspN66P352BZ0nyNQLcIj6OiqDQHD9sKzHYcLWZ
        Deg4RlXGBn1S4RuAnyMBmdM8QJ0/I358TyWhBIJxnczge2r4pO5nNrGLHcLngc8flbrxua
        MKG3AE/+flT5yUy+EAE70abWiYILgDw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-_nTRfe7sOReC7EB70kw2Zw-1; Thu, 19 Jan 2023 15:57:26 -0500
X-MC-Unique: _nTRfe7sOReC7EB70kw2Zw-1
Received: by mail-qk1-f199.google.com with SMTP id de37-20020a05620a372500b00707391077b4so2078074qkb.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 12:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMg8gNQDfp59Z8c/Laiz+GjWJb2Q7J01BdsOGckaZ2o=;
        b=UJPKYGlFZOjkTvHYg3Gf8rY8VtMUDCee84Lyr/g3RX5uM/VI5RGYfHxZiJVY+0kJEj
         HuAJ6LRwMvyu1WpgN4pJYVduYEq7oLIoREcjIcGKEA530ZLUxSHCT0kh6t3kCmZ098xL
         GH6B76sxBOHyxSSXnAy7EWWzEw8vnpmYfdzkQyg1vKLj94yIjh/PJ2gIy+4DzYC2xchV
         rSTgzjLf/w/+cSq2Et545zvpQsjvUD+CTeTaG0M/BaAu3eNWJGiNPbyIyejgcvpocYf6
         iiCffTXwQzIkyJXCmQ2NKdcS/8cCWBp6UFnJM7Odgq2ZUVqL8348PGoiRRNsa3OYAEeJ
         gF/w==
X-Gm-Message-State: AFqh2koTzc6KCdWDmjG6ZlC7Qf1+rfPzmpCukcjHUt5XJpt2uo9IcEjO
        abNOW763iADN8RqNnAaO32AOnC7dBfXKOixk1QYDvChRFEGGmnybxV25ttiZbTyGfHcbRK1GhXv
        fEGWVe17Fpz77TpV6gETask3G/g==
X-Received: by 2002:a05:6214:438a:b0:531:aafe:70f7 with SMTP id oh10-20020a056214438a00b00531aafe70f7mr16998215qvb.22.1674161846313;
        Thu, 19 Jan 2023 12:57:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtYPZCnIgBeqLdl4vH1qzPFlZffk5UJAq4hcYj5DWPviNBk6qtyOLBT2l2ZcUCaKsOvFWjXTg==
X-Received: by 2002:a05:6214:438a:b0:531:aafe:70f7 with SMTP id oh10-20020a056214438a00b00531aafe70f7mr16998202qvb.22.1674161846092;
        Thu, 19 Jan 2023 12:57:26 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a034b00b006fa31bf2f3dsm24317491qkm.47.2023.01.19.12.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 12:57:25 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>
Subject: [RFC PATCH 1/1] fs/namespace: defer free_mount from namespace_unlock
Date:   Thu, 19 Jan 2023 15:55:21 -0500
Message-Id: <20230119205521.497401-2-echanude@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119205521.497401-1-echanude@redhat.com>
References: <20230119205521.497401-1-echanude@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

