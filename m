Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D12D5A3BE4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 07:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiH1FFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 01:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiH1FE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:04:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA9B1261B;
        Sat, 27 Aug 2022 22:04:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so350355pjj.4;
        Sat, 27 Aug 2022 22:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=UhUvuDSlQEiKNNHbLZUo+H8obATf/6M+rVlg3WlY7Lc=;
        b=ojfFa26Q4JMuGcqFZ494WB15iewRnw0u6RJUQLLttNqnNq91ESy43FqvUS+ZXPf10o
         Gcmay3MFsdg/rAcgD1E37SsjD4oGnIiBgSsREQ+1W04Jw9LMNkWti3U5jdayMFzmBvrz
         uyJXFl3AdoNWKzYMyppm0ISQeq57z17KlkG7xOjCdJB167Lug/NkNF9hudNGAm90z04Z
         KcQ2/By5wzdoYJ287+hLcUXb4Wjgu5rQQDZsoMVrEW7Da7lmRgVAFa9DqbxUxcfX8SPg
         CESOSPIyA9UdShdo7xDzyETJjilZO/1DSNd5UtpMPFd14IBhOqxn8ZS167bvdUmVXX5E
         doYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=UhUvuDSlQEiKNNHbLZUo+H8obATf/6M+rVlg3WlY7Lc=;
        b=wa/6005OUWK6tuexHswllYxFmz0RZYgo0jolusQtIJnE70lnxgOQwiCB5BWuqkhWOC
         8IJFjP2l1XJ5iBJXOIj2UQp5Vc/HxK/bj1qGQddKdSNlJ+9oqnZsn6VAUHeIzj1VPzMD
         5Mj+kWf3Uad6CcnuEbt+jYgQqn8/Dt1oeOJWQV/MqM30cTIb2cjgZ7TflIYhx63EGJZ3
         uPdWRXoF3na1+PhWufrzqAmq1kXZbLIBUs+dHv0xnAXDU50cKpc1TJFN1MfVQwM4RkBd
         LdMI+eJaNWMvW2gYNoynV4yuJhoXfLJgE1u3Egs+Aiugubj4E3uAqSvkemqaMcgvm3Fi
         rv5g==
X-Gm-Message-State: ACgBeo2ZhlyJv76Sp8chvDH46AizwTpgpFMXV8CK08al2sxNI7LvnhKH
        IEbboAidyQL2QX8JOfy6R9E=
X-Google-Smtp-Source: AA6agR4fz5Y8zxhQiMorQv5ZNOvinLmFUuMhxRcOolbYKebFiPk8JVP3jmKfIZVagi4jmhd+SZCXhA==
X-Received: by 2002:a17:90a:e58a:b0:1e2:fe75:dd5f with SMTP id g10-20020a17090ae58a00b001e2fe75dd5fmr12504395pjz.138.1661663094803;
        Sat, 27 Aug 2022 22:04:54 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902e88200b0016f1aa00abbsm4556922plg.195.2022.08.27.22.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:04:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/9] kernfs: Drop unnecessary "mutex" local variable initialization
Date:   Sat, 27 Aug 2022 19:04:33 -1000
Message-Id: <20220828050440.734579-3-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828050440.734579-1-tj@kernel.org>
References: <20220828050440.734579-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are unnecessary and unconventional. Remove them. Also move variable
declaration into the block that it's used. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Imran Khan <imran.f.khan@oracle.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/kernfs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 32b16fe00a9e..6437f7c7162d 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -555,7 +555,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
-	struct mutex *mutex = NULL;
+	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_locked(kn);
@@ -599,7 +599,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
-	struct mutex *mutex = NULL;
+	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 
@@ -776,9 +776,10 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
-	struct mutex *mutex = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
+		struct mutex *mutex;
+
 		mutex = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
 		mutex_unlock(mutex);
@@ -796,7 +797,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
-	struct mutex *mutex = NULL;
+	struct mutex *mutex;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
-- 
2.37.2

