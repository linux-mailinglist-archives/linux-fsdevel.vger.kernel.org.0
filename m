Return-Path: <linux-fsdevel+bounces-14989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E41885E07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069FA1C21E5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468F136992;
	Thu, 21 Mar 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KY4oPKzi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90372135A7D
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039056; cv=none; b=fgHrHxFBKHykuvk6aA6NGPDFZ77lyjwOzxgySCYY55LI95OGc3QBpLopMz2pr6jgaUGa+s8mdP0HaVBu4MCSzDnvutLjmDBDqh55dQPTBBAogSGlwuoo4pxr4/Wd9v5qI9Br0ShajDIa1fPSd4/Y3YDpBLrDflDmQJ66LzSucmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039056; c=relaxed/simple;
	bh=H5FMq26r5gKxhbJi5oj8J3ekKHRYJKOHnNGIH4x7NWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g0qSiEKtypO+UkkQlRaZzYMOZDqupHnIDwatAK9V/TE3fb3ldhZD1lwg2iVY420UzrGs3+ligdwgmMJB7GaDNlYowAnf8X/1Vwy9XsTu9UB2nx6AHP1McHsD9NlIk2zR+i5YlpFJX9zITkOWptZ0JvvRQF+uaWvJidz/hhyYOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KY4oPKzi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so2164004276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039054; x=1711643854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BO7qlg8CrJrpGAZLx2tB5/z68XAeLcOjL+jbqSm1NrE=;
        b=KY4oPKziE3ocIh8vV/qPMJ5CW1xF5u+hUTiszf19Y/W1u6rwJAljC7RJhNIo1Wkcbt
         XWVmAGNpy9JF4KK6xgaKqwKMwHzIqWzg6yhPzpQx2+PkOtYvNHKAnLRvqp42p2UUbALg
         Tg8pJp7eeUWiVjwG3pHyOWhQ9hHInEi4Cj1dB2tJXvNOOkE0xylvpzDZ6911h2in62Tq
         yqhQPylmo4IVTVDoMO+/BQrsYcfZrrVQM51vzF9LwdZSwuBKKrPic/osJoHn99pje8z9
         Z953B24pSurrw9bBRHZFVLkYxUSBGYSm3lAjYFaJvNKyo/O+gICBet6KSOirQkLVbpzk
         2P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039054; x=1711643854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO7qlg8CrJrpGAZLx2tB5/z68XAeLcOjL+jbqSm1NrE=;
        b=ZvJvXfo7llHKhPaTO19guyrA/LQCPLeIOWcdKXRHKpM5y7cJN8qYEj/anmUZCPunXR
         wO5+XMUwsP2w9nt9KBwadbWzw92fobXHmlhzjz1qsUZ4D1VoKUJDYDPoksuIHMWRKEMW
         UyH5Xm5n2BOnmWWETZV0w1K+bwDVAX2Lz3VjehLhE2+rcwpWxpIzQmkMT+nWaNGquJxp
         uGCefsaTHnD20UJ1o9zi4113MPqB5obhAAIU2fl5hMEh8OmHw8uv9MbK+mvwZ0Rxnx14
         3jwZxnKOVSLkk9BBSN+CuQcbtQI7p/MN8umlAbPgScpgF0rcXMQJnpYWVMTt6HAMrboW
         saug==
X-Forwarded-Encrypted: i=1; AJvYcCU4WRuh6en1QOHTW+AbWVQ4klsrOc7w/SGwKi3SdlaDcTmi+zTMKwgErYeQn7IKTguHDoGSB/PNyuTWAHdkLI9FdyoLNVpW1Gf7tTFDOQ==
X-Gm-Message-State: AOJu0YxocldlEbPxJZR7KPAZRbJl+vUNXUl8zqKa6mi2hoppGzrIjR6f
	Zvagt/xINFzegLmB+DzxJC/Sd9isEmgYXRbep3vN67f3/AOavLeGiBMv3MRnbCUBtNCePXw2nLC
	aFQ==
X-Google-Smtp-Source: AGHT+IFS8l6862ma7ZQ5nEeHVOl9wKPYzuGCINkU9A5+oHuouEfxTwfUntJ3DBz0B7w6WbE929F2a5bqsSQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:2681:b0:dcb:bc80:8333 with SMTP id
 dx1-20020a056902268100b00dcbbc808333mr5470245ybb.13.1711039053606; Thu, 21
 Mar 2024 09:37:33 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:33 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-12-surenb@google.com>
Subject: [PATCH v6 11/37] lib: code tagging module support
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for code tagging from dynamically loaded modules.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/codetag.h | 12 +++++++++
 kernel/module/main.c    |  4 +++
 lib/codetag.c           | 58 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index 7734269cdb63..c44f5b83f24d 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -33,6 +33,10 @@ union codetag_ref {
 struct codetag_type_desc {
 	const char *section;
 	size_t tag_size;
+	void (*module_load)(struct codetag_type *cttype,
+			    struct codetag_module *cmod);
+	void (*module_unload)(struct codetag_type *cttype,
+			      struct codetag_module *cmod);
 };
 
 struct codetag_iterator {
@@ -65,4 +69,12 @@ void codetag_to_text(struct seq_buf *out, struct codetag *ct);
 struct codetag_type *
 codetag_register_type(const struct codetag_type_desc *desc);
 
+#if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
+void codetag_load_module(struct module *mod);
+void codetag_unload_module(struct module *mod);
+#else
+static inline void codetag_load_module(struct module *mod) {}
+static inline void codetag_unload_module(struct module *mod) {}
+#endif
+
 #endif /* _LINUX_CODETAG_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index e1e8a7a9d6c1..ffa6b3e9cb43 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -56,6 +56,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
 #include <linux/cfi.h>
+#include <linux/codetag.h>
 #include <linux/debugfs.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
@@ -1242,6 +1243,7 @@ static void free_module(struct module *mod)
 {
 	trace_module_free(mod);
 
+	codetag_unload_module(mod);
 	mod_sysfs_teardown(mod);
 
 	/*
@@ -2995,6 +2997,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Get rid of temporary copy. */
 	free_copy(info, flags);
 
+	codetag_load_module(mod);
+
 	/* Done! */
 	trace_module_load(mod);
 
diff --git a/lib/codetag.c b/lib/codetag.c
index 8b5b89ad508d..54d2828eba25 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -124,15 +124,20 @@ static void *get_symbol(struct module *mod, const char *prefix, const char *name
 {
 	DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
 	const char *buf;
+	void *ret;
 
 	seq_buf_printf(&sb, "%s%s", prefix, name);
 	if (seq_buf_has_overflowed(&sb))
 		return NULL;
 
 	buf = seq_buf_str(&sb);
-	return mod ?
+	preempt_disable();
+	ret = mod ?
 		(void *)find_kallsyms_symbol_value(mod, buf) :
 		(void *)kallsyms_lookup_name(buf);
+	preempt_enable();
+
+	return ret;
 }
 
 static struct codetag_range get_section_range(struct module *mod,
@@ -173,8 +178,11 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 
 	down_write(&cttype->mod_lock);
 	err = idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
-	if (err >= 0)
+	if (err >= 0) {
 		cttype->count += range_size(cttype, &range);
+		if (cttype->desc.module_load)
+			cttype->desc.module_load(cttype, cmod);
+	}
 	up_write(&cttype->mod_lock);
 
 	if (err < 0) {
@@ -185,6 +193,52 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 	return 0;
 }
 
+void codetag_load_module(struct module *mod)
+{
+	struct codetag_type *cttype;
+
+	if (!mod)
+		return;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link)
+		codetag_module_init(cttype, mod);
+	mutex_unlock(&codetag_lock);
+}
+
+void codetag_unload_module(struct module *mod)
+{
+	struct codetag_type *cttype;
+
+	if (!mod)
+		return;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link) {
+		struct codetag_module *found = NULL;
+		struct codetag_module *cmod;
+		unsigned long mod_id, tmp;
+
+		down_write(&cttype->mod_lock);
+		idr_for_each_entry_ul(&cttype->mod_idr, cmod, tmp, mod_id) {
+			if (cmod->mod && cmod->mod == mod) {
+				found = cmod;
+				break;
+			}
+		}
+		if (found) {
+			if (cttype->desc.module_unload)
+				cttype->desc.module_unload(cttype, cmod);
+
+			cttype->count -= range_size(cttype, &cmod->range);
+			idr_remove(&cttype->mod_idr, mod_id);
+			kfree(cmod);
+		}
+		up_write(&cttype->mod_lock);
+	}
+	mutex_unlock(&codetag_lock);
+}
+
 #else /* CONFIG_MODULES */
 static int codetag_module_init(struct codetag_type *cttype, struct module *mod) { return 0; }
 #endif /* CONFIG_MODULES */
-- 
2.44.0.291.gc1ea87d7ee-goog


