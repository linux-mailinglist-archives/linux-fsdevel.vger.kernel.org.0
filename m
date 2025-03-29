Return-Path: <linux-fsdevel+bounces-45281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C193EA757B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C863AE0CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 19:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DFE1E0DB0;
	Sat, 29 Mar 2025 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/3GKIIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF471DF972;
	Sat, 29 Mar 2025 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743276521; cv=none; b=Kq656UL1Mj7yoB+outM5WikNdJ4mULrbaXgpQmZYE/6FAv2p4RxdMQra2yS++T7lomGP760R9N3vxLphsmWku2lyO3tXhM/pOFI1AlAx/HyV2jAOV9CP1KiJJ2kva0dxR1v+wbj84/IBAW86j0Nb5xqcTjcmmPj/xext1VJ5ZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743276521; c=relaxed/simple;
	bh=HMlu614l9vrUJR8sMZ9GS+Go9ildwpuzJT02rcw6AyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbtgLKt08TPJqaZ4opYT0p6dqLY0Esq/OqNl0jD40XFd21M7mmXJ+4e9Ug/oszhzsmN9hH3ybNKAJtcnd6WWiawCjTtZYeNnn1zjnKea9loX/D+0P8klRC6mFPvVStIhCbiidVPGuTrEHBir7XeaNtxBKqJtQvGNr3LGCDCXjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/3GKIIx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso23316345e9.1;
        Sat, 29 Mar 2025 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743276518; x=1743881318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMIrv1kqIoRpOCqYRw9tO7+mhVPULEt+KT/icWfjEqw=;
        b=h/3GKIIxyjvuGqQjv1/aYbPntX7vVMWoU5ibOQK6rMVRAHCjsp5Bd0uhLTRhrZ/QP4
         kLkXWRtxqArr5HqGbwL/7jPoJEPdxW28qt46LYCaStDjKEDBt2xJNZaaOjYx5bLFDd0w
         JS4xO4MjwJdDVY35KBkjSvNILnIXkkgS5RJgvYLBEm6CbRADl0UAtG2F3rtAyu64ppKS
         RQKRSPncH+JmVf5keZCL7WpmfO990KlhbBbGGyMtpyuIMa2/T1+VW6KXTw3X74x+80qZ
         qQOmDN1Y4aBtDfa2jdLIC4wfORbYuR2ftzTIuTwV5ZJ/0qG6Wt3za3IgsWRgeamcb4ID
         IeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743276518; x=1743881318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMIrv1kqIoRpOCqYRw9tO7+mhVPULEt+KT/icWfjEqw=;
        b=HTpM27P2JHwscl9bHiJYgZkF3mkKdOEIcP5O9nnZWdw+wLzQ9xZ+F3LUjVx0q9N+7E
         iN55psLzrrOtkCelWA7cmepSPoZXXh3SWcM5Anaj70E43cJaQdL3GCJ3dqE8iCBnqMAG
         j1cN/CAXjoRfkbwohX7nJK2tkkC+zXHUtDqtv9dtcSDB3zXXDN2mnuJOiFJrAMGnq1FQ
         zIPpdu+5LgYk5yLIV5IFvhZCJZiWXBte3xUW09TB4Hn1nywFGSPlY3rKBU6jXaXJCg4H
         g0uRBhh0Izc5qXs3NBvw8BPo5YTxNO7pp6YgSPUecbRM2Aic//+sW7xOO0GQ8vxswJGj
         vFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4JUKxLvSbsfyED4LmLwE+VeT7IhaA5OA8cDtwKH1GnEka9fBhdY/vrUUZKHqoo6746danjxKviLCMi+IP@vger.kernel.org, AJvYcCWHTAB09pM549PafM6JTAUns4ILdkDK4fdr6rbMKbVrMMLbTPZ8sQg1bn1wFETH2yZwhf1J0LvfIVJNkkjs@vger.kernel.org
X-Gm-Message-State: AOJu0YzSqfq/U3gfuAfFprPefK6TCeotd/9yqQ+LaO29Cpi7ArVSRMNG
	4AytuzfMygwko/eBuPCD73/+9m4sEIRTBilW4aLfZ50pN3VcIFid
X-Gm-Gg: ASbGncuhU09/wbYpaAcIR/hb5EGMQN4yXGrec8kh03N7TnSkLbcu9bOylaqBiCLI+Xn
	J/Vucr8w6TtjEHd18eO8HqR3znYu7sw7VGYAIRHfiLvrDeXmfb7s79J0SgPvlMQlodUHP0KElvV
	Ec33BaxbIDR4/MoOqH19gg5dKZ5EImcxK+KgQbuudZD9pQcDUmNhoEM31xJ3K36nt7Azs1iF240
	qQppnsrwZxQTmXxIAPnbpV79KRY0pkNEemVAALPS/PmEB0pGJLYtkzF1arpbuzeu99RWirHdhcG
	278PKO091IdCOPq2Sz6kiDWYU4hUSUh51krvPmRNjUhg2gl1IpgUzAjFXrLi
X-Google-Smtp-Source: AGHT+IG30aTTmjX0hsXkFfMYZnhRziWNzSZ+dgNEk4q0tnxeCpZEmJHXMCFDLxnfwtdvSv/NFK61hw==
X-Received: by 2002:a5d:64ec:0:b0:39a:ca05:5232 with SMTP id ffacd0b85a97d-39c120c7ccemr2761702f8f.5.1743276517757;
        Sat, 29 Mar 2025 12:28:37 -0700 (PDT)
Received: from f.. (cst-prg-15-56.cust.vodafone.cz. [46.135.15.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e141sm6553400f8f.77.2025.03.29.12.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 12:28:37 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] fs: cache the string generated by reading /proc/filesystems
Date: Sat, 29 Mar 2025 20:28:21 +0100
Message-ID: <20250329192821.822253-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329192821.822253-1-mjguzik@gmail.com>
References: <20250329192821.822253-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is being read surprisingly often (e.g., by mkdir, ls and even sed!).

This is lock-protected pointer chasing over a linked list to pay for
sprintf for every fs (32 on my boxen).

Instead cache the result.

While here mark the file as permanent to avoid atomic refs on each op
(which can also degrade to taking a spinlock).

open+read+close cycle single-threaded (ops/s):
before:	450929
after:	982308 (+117%)

Here the main bottleneck is memcg.

open+read+close cycle with 20 processes (ops/s):
before:	578654
after:	3163961 (+446%)

The main bottleneck *before* is spinlock acquire in procfs eliminated by
marking the file as permanent. The main bottleneck *after* is the
spurious lockref trip on open.

The file looks like a sterotypical C from the 90s, right down to an
open-code and slightly obfuscated linked list. I intentionally did not
clean up any of it -- I think the file will be best served by a Rust
rewrite when the time comes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/filesystems.c | 148 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 140 insertions(+), 8 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 58b9067b2391..5d4649fd8788 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -34,6 +34,23 @@
 static struct file_system_type *file_systems;
 static DEFINE_RWLOCK(file_systems_lock);
 
+#ifdef CONFIG_PROC_FS
+static unsigned long file_systems_gen;
+
+struct file_systems_string {
+	struct rcu_head rcufree;
+	unsigned long gen;
+	size_t len;
+	char string[];
+};
+static struct file_systems_string *file_systems_string;
+static void invalidate_filesystems_string(void);
+#else
+static void invalidate_filesystems_string(void)
+{
+}
+#endif
+
 /* WARNING: This can be used only if we _already_ own a reference */
 struct file_system_type *get_filesystem(struct file_system_type *fs)
 {
@@ -83,10 +100,12 @@ int register_filesystem(struct file_system_type * fs)
 		return -EBUSY;
 	write_lock(&file_systems_lock);
 	p = find_filesystem(fs->name, strlen(fs->name));
-	if (*p)
+	if (*p) {
 		res = -EBUSY;
-	else
+	} else {
 		*p = fs;
+		invalidate_filesystems_string();
+	}
 	write_unlock(&file_systems_lock);
 	return res;
 }
@@ -115,6 +134,7 @@ int unregister_filesystem(struct file_system_type * fs)
 		if (fs == *tmp) {
 			*tmp = fs->next;
 			fs->next = NULL;
+			invalidate_filesystems_string();
 			write_unlock(&file_systems_lock);
 			synchronize_rcu();
 			return 0;
@@ -234,25 +254,137 @@ int __init list_bdev_fs_names(char *buf, size_t size)
 }
 
 #ifdef CONFIG_PROC_FS
-static int filesystems_proc_show(struct seq_file *m, void *v)
+/*
+ * The fs list gets queried a lot by userspace, including rather surprising
+ * programs (would you guess *sed* is on the list?). In order to reduce the
+ * overhead we cache the resulting string, which normally hangs around below
+ * 512 bytes in size.
+ *
+ * As the list almost never changes, its creation is not particularly optimized
+ * for simplicity.
+ *
+ * We sort it out on read in order to not introduce a failure point for fs
+ * registration (in principle we may be unable to alloc memory for the list).
+ */
+static void invalidate_filesystems_string(void)
 {
-	struct file_system_type * tmp;
+	struct file_systems_string *fss;
 
-	read_lock(&file_systems_lock);
+	lockdep_assert_held_write(&file_systems_lock);
+	file_systems_gen++;
+	fss = file_systems_string;
+	WRITE_ONCE(file_systems_string, NULL);
+	kfree_rcu(fss, rcufree);
+}
+
+static noinline int regen_filesystems_string(void)
+{
+	struct file_system_type *tmp;
+	struct file_systems_string *old, *new;
+	size_t newlen, usedlen;
+	unsigned long gen;
+
+retry:
+	lockdep_assert_not_held(&file_systems_lock);
+
+	newlen = 0;
+	write_lock(&file_systems_lock);
+	gen = file_systems_gen;
+	tmp = file_systems;
+	/* pre-calc space for "%s\t%s\n" for each fs */
+	while (tmp) {
+		if (!(tmp->fs_flags & FS_REQUIRES_DEV))
+			newlen += strlen("nodev");
+		newlen += strlen("\t");
+		newlen += strlen(tmp->name);
+		newlen += strlen("\n");
+		tmp = tmp->next;
+	}
+	write_unlock(&file_systems_lock);
+
+	new = kmalloc(offsetof(struct file_systems_string, string) + newlen + 1,
+		      GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	new->gen = gen;
+	new->len = newlen;
+	new->string[newlen] = '\0';
+	write_lock(&file_systems_lock);
+	old = file_systems_string;
+
+	/*
+	 * Did someone beat us to it?
+	 */
+	if (old && old->gen == file_systems_gen) {
+		write_unlock(&file_systems_lock);
+		kfree(new);
+		return 0;
+	}
+
+	/*
+	 * Did the list change in the meantime?
+	 */
+	if (gen != file_systems_gen) {
+		write_unlock(&file_systems_lock);
+		kfree(new);
+		goto retry;
+	}
+
+	/*
+	 * Populated the string.
+	 *
+	 * We know we have just enough space because we calculated the right
+	 * size the previous time we had the lock and confirmed the list has
+	 * not changed after reacquiring it.
+	 */
+	usedlen = 0;
 	tmp = file_systems;
 	while (tmp) {
-		seq_printf(m, "%s\t%s\n",
+		usedlen += sprintf(&new->string[usedlen], "%s\t%s\n",
 			(tmp->fs_flags & FS_REQUIRES_DEV) ? "" : "nodev",
 			tmp->name);
 		tmp = tmp->next;
 	}
-	read_unlock(&file_systems_lock);
+	BUG_ON(new->len != strlen(new->string));
+
+	/*
+	 * Pairs with consume fence in READ_ONCE() in filesystems_proc_show().
+	 */
+	smp_store_release(&file_systems_string, new);
+	write_unlock(&file_systems_lock);
+	kfree_rcu(old, rcufree);
 	return 0;
 }
 
+static int filesystems_proc_show(struct seq_file *m, void *v)
+{
+	struct file_systems_string *fss;
+
+	for (;;) {
+		scoped_guard(rcu) {
+			/*
+			 * Pairs with smp_store_release() in regen_filesystems_string().
+			 */
+			fss = READ_ONCE(file_systems_string);
+			if (likely(fss)) {
+				seq_write(m, fss->string, fss->len);
+				return 0;
+			}
+		}
+
+		int err = regen_filesystems_string();
+		if (unlikely(err))
+			return err;
+	}
+}
+
 static int __init proc_filesystems_init(void)
 {
-	proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
+	proc_make_permanent(pde);
 	return 0;
 }
 module_init(proc_filesystems_init);
-- 
2.43.0


