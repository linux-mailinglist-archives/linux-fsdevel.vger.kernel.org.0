Return-Path: <linux-fsdevel+bounces-38990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82865A0AC03
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 22:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8263C165D65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF551B0F0A;
	Sun, 12 Jan 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSn39utw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A1183CBB
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736718617; cv=none; b=RXmmls4GnABvTqrr3RASX/139tFNUUxCXnnKGmsu2P0wvpnXkVR+PolY9tVHyy3obbn0VOuVMHr0NvNOx9wYfIi7XEms5+FsKEG0XUCntAyD76/zDB37FTyTCSn/P+WIBH01YnxtTQ7RLtNjLHWV9JTGrK96y5liNF/y1vVMvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736718617; c=relaxed/simple;
	bh=dUPZvkd26rp5nnxx2nnC+RDJVUuCgxxfynGiCaVDLQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJ2TRC+Dyoyyk9qBpE4D/cru2ZdLKGDQhyWuO+UwYZ6Ecg3BgOiwfen1RBIOteQP+bBGnpbP5jlOdTn+Ffp0pOqCebfv3/qVPAFw4Z6bHV6eN1rSOxNMxakiCo/AEVD/muwePKjj59rPZcHTfh/dSBLCw6tAepwEvyQldgqwfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSn39utw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so6277363a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 13:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736718615; x=1737323415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2IH0ik4yzm9DiMEtBgML907miOMMnCwRLSjV+4R7sEQ=;
        b=MSn39utwVR52469e+dAo0HhBP5i7eBslCHxUnGmZbwiGExd8Z1W9jv+P1JyLpMIbqP
         IRTgd+ionOX+UJk9Ub0aWsPIeg7SFGyEGVBLx+db1iaAcLJSd+YrdAqN1P5mPFGO4JbS
         bBmnYxTz1d1EA9jJIPUndLQbLQxnpUKpNgefpuL7xAHztNdcxmGoS8E5/bfNTu4NmSlz
         Ao0nGPlwgIeefpRMRsEI5H+TLbT5JQMwgTJHg7wpLjBBWX4HZuprWhRNhp5qrK4ahyQ3
         Na0iK8TospuhvbUKiC10QJXdrUWzXS+2ig0ya0zLa8dkEELgI7ggUu70tcuO90KCgSx7
         AF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736718615; x=1737323415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IH0ik4yzm9DiMEtBgML907miOMMnCwRLSjV+4R7sEQ=;
        b=f3aXtqIbGbo5frtYHGNG3z2kGsP6hmYe4VgY665ruEBop9jIfkxNZJp0R8MnT9i+gG
         mcc5vWy1q3F3g1XZc2br/Xa2cvlzVbtEBXwaUYOwGqEU0xPS7Hajwb76E2228N5mfhWv
         skSrTIkFUCVnch3im7B4BgTw7wqd3hqNQID43dEjklocle5I1y5IYMurfEiAkQoRdN3i
         HXHJwe4PoCIqXoXyNOe7I33Bx51G0pUFh2CgcXPoQPTqyX5Cy54MvZzRq8WrFO3mRfvh
         uG9nmdCVRASePLwtLrsN3ZyOUYMjcjAtdKYDrhBbxMa1jmohDblAvPrVuz7mBoveihhb
         oWLw==
X-Forwarded-Encrypted: i=1; AJvYcCWZgyg5tjD6Pa2LBB90+Iesmcy1/JYzb5eEt3B5Btv8q1RR1sV6SMunp6eY8uePCD96nIRPzJiThpnbHSuh@vger.kernel.org
X-Gm-Message-State: AOJu0YxlO451ra2m06eC/FCgjpwsiiP940MVGtuG4qMf+oL1AEqcH6Tl
	DGxN+UJzT7h8YYdZdv7ssX91uUpeMxdJk/jGrn5ssbgbL/rLRFfZI1doiKRJTpWq2NDElw84+d2
	DReukM4jwj9PC7A==
X-Google-Smtp-Source: AGHT+IFwFREJ+qX2LscO1D8raNq4nlV5ZdcigUfzpR+1lXhg9uQ+wUmsnMHqWSEsW+qiA6L/gVGxAsY2vLQ3Ays=
X-Received: from pjbqi14.prod.google.com ([2002:a17:90b:274e:b0:2ef:d283:5089])
 (user=jsperbeck job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2748:b0:2f1:30c8:6e75 with SMTP id 98e67ed59e1d1-2f5490e89e0mr22796888a91.32.1736718615426;
 Sun, 12 Jan 2025 13:50:15 -0800 (PST)
Date: Sun, 12 Jan 2025 13:50:13 -0800
In-Reply-To: <jedmwyiggspxnr76ugyax73zwotbnrwpccy7gafdeq6vyweb6z@4c3ivqegpgkd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <jedmwyiggspxnr76ugyax73zwotbnrwpccy7gafdeq6vyweb6z@4c3ivqegpgkd>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250112215013.2386009-1-jsperbeck@google.com>
Subject: [PATCH v2] sysctl: expose sysctl_check_table for unit testing and use it
From: John Sperbeck <jsperbeck@google.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: John Sperbeck <jsperbeck@google.com>, Kees Cook <kees@kernel.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In commit b5ffbd139688 ("sysctl: move the extra1/2 boundary check
of u8 to sysctl_check_table_array"), a kunit test was added that
registers a sysctl table.  If the test is run as a module, then a
lingering reference to the module is left behind, and a 'sysctl -a'
leads to a panic.

This can be reproduced with these kernel config settings:

    CONFIG_KUNIT=y
    CONFIG_SYSCTL_KUNIT_TEST=m

Then run these commands:

    modprobe sysctl-test
    rmmod sysctl-test
    sysctl -a

The panic varies but generally looks something like this:

    BUG: unable to handle page fault for address: ffffa4571c0c7db4
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 100000067 P4D 100000067 PUD 100351067 PMD 114f5e067 PTE 0
    Oops: Oops: 0000 [#1] SMP NOPTI
    ... ... ...
    RIP: 0010:proc_sys_readdir+0x166/0x2c0
    ... ... ...
    Call Trace:
     <TASK>
     iterate_dir+0x6e/0x140
     __se_sys_getdents+0x6e/0x100
     do_syscall_64+0x70/0x150
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

Instead of fully registering a sysctl table, expose the underlying
checking function and use it in the unit test.

Fixes: b5ffbd139688 ("sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 fs/proc/proc_sysctl.c  | 22 +++++++++++++++++-----
 include/linux/sysctl.h |  8 ++++++++
 kernel/sysctl-test.c   |  9 ++++++---
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 27a283d85a6e..1de946176d74 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1137,11 +1137,12 @@ static int sysctl_check_table_array(const char *path, const struct ctl_table *ta
 	return err;
 }
 
-static int sysctl_check_table(const char *path, struct ctl_table_header *header)
+static int sysctl_check_table(const char *path, const struct ctl_table *table,
+			      size_t table_size)
 {
-	const struct ctl_table *entry;
+	const struct ctl_table *entry = table;
 	int err = 0;
-	list_for_each_table_entry(entry, header) {
+	for (size_t i = 0 ; i < table_size; ++i, entry++) {
 		if (!entry->procname)
 			err |= sysctl_err(path, entry, "procname is null");
 		if ((entry->proc_handler == proc_dostring) ||
@@ -1173,6 +1174,16 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 	return err;
 }
 
+#ifdef CONFIG_KUNIT
+int sysctl_check_table_test_helper_sz(const char *path,
+				      const struct ctl_table *table,
+				      size_t table_size)
+{
+	return sysctl_check_table(path, table, table_size);
+}
+EXPORT_SYMBOL(sysctl_check_table_test_helper_sz);
+#endif /* CONFIG_KUNIT */
+
 static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_header *head)
 {
 	struct ctl_table *link_table, *link;
@@ -1372,6 +1383,9 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_dir *dir;
 	struct ctl_node *node;
 
+	if (sysctl_check_table(path, table, table_size))
+		return NULL;
+
 	header = kzalloc(sizeof(struct ctl_table_header) +
 			 sizeof(struct ctl_node)*table_size, GFP_KERNEL_ACCOUNT);
 	if (!header)
@@ -1379,8 +1393,6 @@ struct ctl_table_header *__register_sysctl_table(
 
 	node = (struct ctl_node *)(header + 1);
 	init_header(header, root, set, node, table, table_size);
-	if (sysctl_check_table(path, header))
-		goto fail;
 
 	spin_lock(&sysctl_lock);
 	dir = &set->dir;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 40a6ac6c9713..0f1d3a626f4f 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -247,6 +247,14 @@ extern int unaligned_enabled;
 extern int unaligned_dump_stack;
 extern int no_unaligned_warning;
 
+#ifdef CONFIG_KUNIT
+int sysctl_check_table_test_helper_sz(const char *path,
+				      const struct ctl_table *table,
+				      size_t table_size);
+#define sysctl_check_table_test_helper(path, table)	\
+	sysctl_check_table_test_helper_sz(path, table, ARRAY_SIZE(table))
+#endif /* CONFIG_KUNIT */
+
 #else /* CONFIG_SYSCTL */
 
 static inline void register_sysctl_init(const char *path, const struct ctl_table *table)
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 3ac98bb7fb82..247dd8536fc7 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -410,9 +410,12 @@ static void sysctl_test_register_sysctl_sz_invalid_extra_value(
 		},
 	};
 
-	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
-	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
-	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			sysctl_check_table_test_helper("foo", table_foo));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			sysctl_check_table_test_helper("foo", table_bar));
+	KUNIT_EXPECT_EQ(test, 0,
+			sysctl_check_table_test_helper("foo", table_qux));
 }
 
 static struct kunit_case sysctl_test_cases[] = {
-- 
2.47.1.613.gc27f4b7a9f-goog


