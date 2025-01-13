Return-Path: <linux-fsdevel+bounces-39007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4BCA0AF8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 08:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C480F3A676E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 07:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0339232377;
	Mon, 13 Jan 2025 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s94NM5yH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FC231C8D
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736751609; cv=none; b=ijKOIcPzaLtuQoD21gJkgzKddyiOIMu+7QcMjRpPhO5cgmhRdjnNdhpsJhdRM5CbT3uCYf67m+sek8MLltIRQ1UahsV3MkyypqCaNpj56f5TUPRmOPMCnagmtPPS/9IoGLml+gzrprMk53ZzJgN9BMAV9WnkSK6CTULKgr3Huow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736751609; c=relaxed/simple;
	bh=9v5dhRtXnQw2JXpoJ9DscznFJ2UocWakQXuGzdOWjbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZO8a5ZZ73T6DZCNrMqw43GSZZSdyW+ocLri/OsWmyirBTaPMLLOnuXI74V02ktgK1E0xoJVaMg2lIOrq+QJnffgwxwwFSDkWh+m1KdF77YJqWaJFITiGLo8dHuA8JyKCfOK9Mf6DbJZOtwCKMmsUv18iT9BcPaDX3P2vTOkNd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s94NM5yH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21661949f23so119966295ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 23:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736751604; x=1737356404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TP/ucVZSWteYqzVjsDWkTor+9/zYE6YW+n99atYzaCk=;
        b=s94NM5yHjiU2iHemDBJwrfImWi5S+jpb0+JQSCqwOY6e0Xvpm4iMPymoWyAJQHyOpV
         mR3CIaL9v4a/Pi+O1T1P9hvGnAuArjwqw0uWf4wj+TM4qQ+my9DEhg6RpaQVpsSBx0NJ
         cIP/52NAcvxP+6zpI+yEOQXgzH8rC5J1rjTfpB8zZZK1/Wat4eITyU9LolTatDauYZvy
         bzshWPuhllcbq97GtfucAHUUiQZBOjabfHUaC9Oj2OlhDpL6WjistUDEmooJ4dDnayEb
         Ot9hl/imacx3SgFaWAtCfHbhiHRexhunLIWIm1vQd1Sb1LGrWDkp8Zbjzz/+CzfqRKTt
         8AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736751604; x=1737356404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP/ucVZSWteYqzVjsDWkTor+9/zYE6YW+n99atYzaCk=;
        b=vDTC87byeEHPIOoMLSvcHNaMxoiUbnLnYBmR0HJ3k17At5QmyzEbtbr/a9PoHuS2MW
         cl9oiDK0bjdL6vSbIk40UjWBFUgdggWvdCnS3KhfYvWm/iIOgrbTAs9SL/4JnfpxCifa
         sikBi3eFr7Kdn/QJR0icD+D4Olo+xNmv9ZcnKyz/t9Ywokq4SLwWJHrYpLXkq4Po9+YD
         CKD5rK0XKTK3lnr1hnfUOodidzJSL2MHWT/XUSX8fqLXnlDDkZZOF5zYvHvy9NgDU585
         Io+8VUF7G9V7Qz3FNRGuKQb2CxUaSJBcY2AbFnhmWe+ltI5jZcHQmbQjxTHujmY/oJVF
         iJdg==
X-Forwarded-Encrypted: i=1; AJvYcCX3BWI2DqVmdoXREnrU1LlvGxijYv37c1HeopnXzdSE6BsOY5zsiRTFH/FzUJxqot2UdsR0soEiw12Tbg9M@vger.kernel.org
X-Gm-Message-State: AOJu0YzObsiF4ajdI7jzRyppWtX2ONestn6V5wetcmb7YZ1qR47LsKjv
	ax9bopzOFWX8fTTOSFRk/d11TxUNvUZdgkqIw5IcAtOgF0ctadYVHgmbnh6A2KVjEZ8KEaFgI6Z
	oWM7Q1mty9wtP4w==
X-Google-Smtp-Source: AGHT+IExZwmgzmbJmcsADwtv6VrMi4BhNyEiSbVezdZMbCSAAXLixdDTayystEP6mZG8libCSS8Bv82gWTsI2Is=
X-Received: from pgnq16.prod.google.com ([2002:a63:8c50:0:b0:7fd:57ef:61e])
 (user=jsperbeck job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c408:b0:21a:8839:4f4d with SMTP id d9443c01a7336-21a88395835mr219013965ad.6.1736751604269;
 Sun, 12 Jan 2025 23:00:04 -0800 (PST)
Date: Sun, 12 Jan 2025 23:00:01 -0800
In-Reply-To: <20250112215013.2386009-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250112215013.2386009-1-jsperbeck@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250113070001.143690-1-jsperbeck@google.com>
Subject: [PATCH v3] sysctl: expose sysctl_check_table for unit testing and use it
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
index 40a6ac6c9713..09caac302333 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -247,6 +247,14 @@ extern int unaligned_enabled;
 extern int unaligned_dump_stack;
 extern int no_unaligned_warning;
 
+#if IS_ENABLED(CONFIG_KUNIT)
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


