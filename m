Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026FC1B17B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgDTU6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDTU6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5B6C061A0F;
        Mon, 20 Apr 2020 13:58:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so1181366wml.2;
        Mon, 20 Apr 2020 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SsuRVc7WTA4pLMVtIiQn6oWkigGZPsfqlgm8M8dg+ho=;
        b=ie7iO/NkFyJGUgjcsdWwwyszVMhXJsAogoj2zqA7KrvZk6uyKVBrsbnQq+VYSGyMfv
         yQ0dM7qHFmreoahikBU9aEBj8LMrN9gtvLJUtfs8N3oVU82MVLAOR4Odw1gqPA/RrLIs
         EwxCDey8fSIZpfTPXyLfJfJtOZ6oNXbXsS1oaf2YEmVhQElfonVqJi3n3UQoFC7jkyYt
         SlznkveGlnxiW7mwOTmYnBm0uRBMMgLNRfonHN5yPXq26nFE60zGUVFB4J8Zv3vDHCSY
         pF79esxxc3KQfoDATF7jn8vk6ueIig0HOV6djdXurb5VrNhE6CqovgYMMccgoq5Lfknj
         L6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsuRVc7WTA4pLMVtIiQn6oWkigGZPsfqlgm8M8dg+ho=;
        b=ai/T4iLUXCmABbBbpDMi1SlnvOZ/f49/c+VIVmjqkxkQWLZYBBu0pEkDiH62sfDHFY
         CIDqz8zHYWb9Ag52H5hDbLt71ppnoEkhZ/FRgsDsa+S3dEYKCoQ0gHbFlsh8kkpohju5
         2i27NJcZ0Jx3xUp0WFVuv6UeSo96ncmZuEF9L/rqz0OUNBF5VDa8k1FwJXZJ9p4uyl8K
         KRLRiyCGzkebgTRZtAm+3SG5JCKcEy3A4juWEObO3k0gGbhuC26ZzyhX4HRf3/IYgvaR
         4visqKV8Z7uXmKy+EkzC5RV1Ke0XRA95JX+5qpWX+6qaaMGco1nH9TeNYjpEtDovrZRT
         3nSw==
X-Gm-Message-State: AGi0PuYbueyr6MC2DgYLHRPZQogouJDeqeWzAEZSTC1eZ8TT8LGWnxbn
        6v06zPkMYaUgVuWuLQWA1Q==
X-Google-Smtp-Source: APiQypJbbaXXGGiKAFfI4QOGAaX0CdLbjLLTpj9mAxGJedypq4aoF3DmP+nKIPEeEPTEZPMqvo77MQ==
X-Received: by 2002:a1c:96c6:: with SMTP id y189mr1364396wmd.106.1587416290978;
        Mon, 20 Apr 2020 13:58:10 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:10 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 04/15] print_integer, proc: rewrite /proc/self via print_integer()
Date:   Mon, 20 Apr 2020 23:57:32 +0300
Message-Id: <20200420205743.19964-4-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/internal.h | 1 +
 fs/proc/self.c     | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 917cc85e3466..8abfd2fa0963 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -13,6 +13,7 @@
 #include <linux/binfmts.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
+#include "../../lib/print-integer.h"
 
 struct ctl_table_header;
 struct mempolicy;
diff --git a/fs/proc/self.c b/fs/proc/self.c
index 57c0a1047250..c8a1662e2cfd 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -14,15 +14,19 @@ static const char *proc_self_get_link(struct dentry *dentry,
 {
 	struct pid_namespace *ns = proc_pid_ns(inode);
 	pid_t tgid = task_tgid_nr_ns(current, ns);
+	char buf[10 + 1];
+	char *p = buf + sizeof(buf);
 	char *name;
 
 	if (!tgid)
 		return ERR_PTR(-ENOENT);
 	/* max length of unsigned int in decimal + NULL term */
-	name = kmalloc(10 + 1, dentry ? GFP_KERNEL : GFP_ATOMIC);
+	name = kmalloc(sizeof(buf), dentry ? GFP_KERNEL : GFP_ATOMIC);
 	if (unlikely(!name))
 		return dentry ? ERR_PTR(-ENOMEM) : ERR_PTR(-ECHILD);
-	sprintf(name, "%u", tgid);
+	*--p = '\0';
+	p = _print_integer_u32(p, tgid);
+	memcpy(name, p, buf + sizeof(buf) - p);
 	set_delayed_call(done, kfree_link, name);
 	return name;
 }
-- 
2.24.1

