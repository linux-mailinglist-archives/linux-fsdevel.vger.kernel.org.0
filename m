Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04504525853
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 01:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359495AbiELXaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 19:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359483AbiELX36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 19:29:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC79266E23
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 16:29:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7dbceab08so57258387b3.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 16:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ll/7XSf/H3qu4hV/tAquY/NfSRFNg8NkKW4o64RepQ0=;
        b=Q++eRMtfjcI9Weo+kStkfr2hsfPcC9L4GFNLEm94yFV/g1ZBzPR6G83a/UtRlDixkw
         1Mot0a2ot9E4Ej2LdOq1Ytks78WCqTbHZx0yVJnvsos7xdhlaK+WsGzunh0TSnLeNOXK
         Rmhft858TNrWZxHb1vIXyDzJqV51Ui4zlKeutD2qw2Wh05j4bkzG3cBakYQkipB/1d+c
         2VLSAB4vN3c+D0lTWLcznHNfsa97Zo6a/KCZMcr6AA59RHowXzghwDrpb9IVJ4bWK5I5
         Ip/NJBKvapOsic3bceuoopIlLuIsz3ifSY+XZAaN8ZSrIkbXWxoNb6mVy2d0WqiuUZPN
         0pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ll/7XSf/H3qu4hV/tAquY/NfSRFNg8NkKW4o64RepQ0=;
        b=JR+ouI1Bi587cui8DZGtkDlMx9c7f1pObihIx2cHWyZfWy2BeYxhGhDHBBzNX6Z9Fg
         Jcboa8EFwYQUgoE0ZWkncnWauEp7sdNrxL4waPG1CqDlF9Gb8WN2WgW6Odv65wxxOHrQ
         jQmV6RuVgYdilECMzZjT+vBfF9ZU4Cb7bKoOKFuWNPwlJZnpYMYUnLcCdKbhhO4DdV5P
         X5u9NH5AhTD5x5TtzUBN7JlQisKvILlp1JXiRtJ83HVcjBRZLiC1jwhtQNprhoeyCRkO
         wBzDqlVWm071UKkaESRaI1WqxeaXfJLu80WyFI+TN8tMn+jN2pOvfBa8eRwMWK+yW1Ic
         V0Kg==
X-Gm-Message-State: AOAM531XxNnCuMXyvB8f0xrVllTfpDP+voVlpHx/0Y1KIl06JKJ0rzzr
        W+Cl1bLC5ymG5CiMikd5vtsq0H1PrgE=
X-Google-Smtp-Source: ABdhPJzwLo+8YO8Slpp9TJgLo1ENvJJUmE+JpdNMGnIkuOH30USGHB2TLD4cdG1YNKXX7zXUg53tmsP4rkQ=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:a792:e3ab:48df:f42e])
 (user=khazhy job=sendgmr) by 2002:a81:a016:0:b0:2f7:cfa3:4dc3 with SMTP id
 x22-20020a81a016000000b002f7cfa34dc3mr2638289ywg.467.1652398194037; Thu, 12
 May 2022 16:29:54 -0700 (PDT)
Date:   Thu, 12 May 2022 16:29:07 -0700
In-Reply-To: <CACGdZYLMW2KHVebfyJZVn9G=15N+Jt4+8oF5gq3wdDTOcXbk9A@mail.gmail.com>
Message-Id: <20220512232907.312855-1-khazhy@google.com>
Mime-Version: 1.0
References: <CACGdZYLMW2KHVebfyJZVn9G=15N+Jt4+8oF5gq3wdDTOcXbk9A@mail.gmail.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH] blkcg: rewind seq_file if no stats
From:   Khazhismel Kumykov <khazhy@google.com>
To:     tj@kernel.org, axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In lieu of get_seq_buf + seq_commit, provide a way to "undo" writes if
we use seq_printf

Fixes: 252c651a4c85 ("blk-cgroup: stop using seq_get_buf")

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/blk-cgroup.c       |  5 +++++
 fs/seq_file.c            | 14 ++++++++++++++
 include/linux/seq_file.h |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8dfe62786cd5..50043a742c48 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -909,6 +909,7 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 	const char *dname;
 	unsigned seq;
 	int i;
+	int scookie;
 
 	if (!blkg->online)
 		return;
@@ -917,6 +918,8 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 	if (!dname)
 		return;
 
+	scookie = seq_checkpoint(s);
+
 	seq_printf(s, "%s ", dname);
 
 	do {
@@ -956,6 +959,8 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 
 	if (has_stats)
 		seq_printf(s, "\n");
+	else
+		seq_restore(s, scookie);
 }
 
 static int blkcg_print_stat(struct seq_file *sf, void *v)
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 7ab8a58c29b6..c3ec6b57334e 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -408,6 +408,20 @@ void seq_printf(struct seq_file *m, const char *f, ...)
 }
 EXPORT_SYMBOL(seq_printf);
 
+int seq_checkpoint(struct seq_file *m)
+{
+	return m->count;
+}
+EXPORT_SYMBOL(seq_checkpoint);
+
+void seq_restore(struct seq_file *m, int count)
+{
+	if (WARN_ON_ONCE(count > m->count || count > m->size))
+		return;
+	m->count = count;
+}
+EXPORT_SYMBOL(seq_restore);
+
 #ifdef CONFIG_BINARY_PRINTF
 void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary)
 {
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 60820ab511d2..d3a05f7c2750 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -117,6 +117,8 @@ __printf(2, 0)
 void seq_vprintf(struct seq_file *m, const char *fmt, va_list args);
 __printf(2, 3)
 void seq_printf(struct seq_file *m, const char *fmt, ...);
+int seq_checkpoint(struct seq_file *m);
+void seq_restore(struct seq_file *m, int count);
 void seq_putc(struct seq_file *m, char c);
 void seq_puts(struct seq_file *m, const char *s);
 void seq_put_decimal_ull_width(struct seq_file *m, const char *delimiter,
-- 
2.36.0.550.gb090851708-goog

