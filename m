Return-Path: <linux-fsdevel+bounces-39797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B77A1875E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 22:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3444188B4DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 21:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C91F7912;
	Tue, 21 Jan 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QASuOhid"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9291B6D15
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495239; cv=none; b=fjNtojQks5iJgQ0osTFiq5+jPt5csoODnXK227YUn50AU+mzron4NNdihRbwKCX6Ytoq0c1XwMw3TgSTCfikc8gmBnvWGfwQxao9TLE3Az9z42VbcJPLskmuCRh/L3WZyQaGFQ1c7xEMm5PD0mLrqe0K8lmRgLMZYj7seP/QuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495239; c=relaxed/simple;
	bh=j9mfr5koioTby3/tUifc65Ljs53QQLJY14KEMb7PWJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aUcHDU6OmqVl3XVCtKkzAGPfkyywQrtyRxWxFyGuXMy+0LpfjicdE02N21YVdriFmMq3ASXyEzfFZ/m3ZWwsJ7KQ4fG6+vJHLC+bxVzuRbFXXdC/NSHRQKLCWpFgTK2oBTJqyiQFWIkHGt8M3N7LiHrwWui1zv2WCLYAogmfeic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QASuOhid; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166855029eso119666665ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 13:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737495237; x=1738100037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPdLhS8IQQK2j1DaMybmQ+gf3rSfK4h9TZPjXQjXUUU=;
        b=QASuOhidA1fAGAAEk1bucrNmsQYafUZDeT5U0AjZxmwcjdaZkXnzb6NdZz1cyGtbZ5
         Ivf2VALkFQ3WqSOW7QIwbl0tEGSCwR35g7SuVhKuKKDuHPaBoktS+kAXMlgu9xmDQQxg
         cQDEtIAgm4I7EW3pXqId0B4izb+LVhpzY/92V78ESz0wr0BFaaQaX7OrEp9NXMy+T5ny
         GbU5uOLV8HOMFzRhu5lKHyMIh7q6gzPOfGzkZJEXsP9/TLkGHgbvMTlMMiyDL1MKAzJq
         0/qSN13dMEL2ppeIjrBLLJV4b6d+vPKSeEE3aYSRZutOQeP5eJEN7ibe2YaCBSNPd/yS
         YIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737495237; x=1738100037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPdLhS8IQQK2j1DaMybmQ+gf3rSfK4h9TZPjXQjXUUU=;
        b=bl6sG4BJ5gqzVzg2v4IthmekVt+CCl11I4rgDoE0MqRDSukBRbOLlv3Lu+tpaMjPRx
         ZPMCEvyrrVs7KEnB2yjphk1pxrWshwIsmB/2U5uKPKwvTOhQOBp5uJlIzHL/8HdjELY+
         JtZvdwt0J93EVrAQXxKgn/lf1kWrB+MT/NGGxHl0G322Z0KEjRP/x/TlIGvOIz4jkrjL
         3speqOvHf4s7zERO2AUNNAk0RQIA6+5gOCt11022r5awH7HRx8N+N/OYJvUog1rkcE9E
         vDJCaw4cDze6fXKxCW6Qt3Il8znkot+A2V7LjBBewX7Cb0Of5pjVZksLmaKimxoWt6AC
         AlCw==
X-Forwarded-Encrypted: i=1; AJvYcCVKOx+P6A5HDeeg48HbRfY8tvuCZLmualvLObPGTwbktytz+FcLHawuWdxjoYQZudV1WZdFcTZ7+JsXIUDO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9HcXk8XkGusTY7jTqeA51eVPWin4A9XJWGUXxYEb5umCDfCnI
	vyfQJnKhwz1vW0ju6ntNskvp3Cok2+fF9PjerA+MSqg23P8a0xYdfkuPOqn6sjPamyedB9COQ77
	aI2vOFLLI8xbQ4w==
X-Google-Smtp-Source: AGHT+IFiDkxn5i7xWlFVIef6/ANncFLIl56Tu2eMWwJUdQJ5Mr/jz+g6Z6uver8vSDvXcLsAYVWBq+gb9G4g61M=
X-Received: from plblw11.prod.google.com ([2002:a17:903:2acb:b0:212:4557:e89b])
 (user=jsperbeck job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5ca:b0:215:b473:1dc9 with SMTP id d9443c01a7336-21c355fa313mr231478045ad.46.1737495236719;
 Tue, 21 Jan 2025 13:33:56 -0800 (PST)
Date: Tue, 21 Jan 2025 13:33:53 -0800
In-Reply-To: <202501182003.Gfi63jzH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202501182003.Gfi63jzH-lkp@intel.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250121213354.3775644-1-jsperbeck@google.com>
Subject: [PATCH v4] sysctl: expose sysctl_check_table for unit testing and use it
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

The Change from v3 to v4 is to make sure sysctl_check_table_test_helper_sz()
is defined in the unusual case that the sysctl kunit test is enabled, but 
CONFIG_SYSCTL is disabled.

 fs/proc/proc_sysctl.c  | 22 +++++++++++++++++-----
 include/linux/sysctl.h | 17 +++++++++++++++++
 kernel/sysctl-test.c   |  9 ++++++---
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 27a283d85a6e..2d3272826cc2 100644
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
 
+#if IS_ENABLED(CONFIG_KUNIT)
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
index 40a6ac6c9713..02acd3670bd2 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -288,4 +288,21 @@ static inline bool sysctl_is_alias(char *param)
 int sysctl_max_threads(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+#define sysctl_check_table_test_helper(path, table)	\
+	sysctl_check_table_test_helper_sz(path, table, ARRAY_SIZE(table))
+#ifdef CONFIG_SYSCTL
+int sysctl_check_table_test_helper_sz(const char *path,
+				      const struct ctl_table *table,
+				      size_t table_size);
+#else /* CONFIG_SYSCTL */
+static inline int sysctl_check_table_test_helper_sz(const char *path,
+				      const struct ctl_table *table,
+				      size_t table_size)
+{
+	return 0;
+}
+#endif /* CONFIG_SYSCTL */
+#endif /* CONFIG_KUNIT */
+
 #endif /* _LINUX_SYSCTL_H */
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
2.48.0.rc2.279.g1de40edade-goog


