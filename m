Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF659A9E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 02:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbiHTAGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 20:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244540AbiHTAGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:06:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D76D0776;
        Fri, 19 Aug 2022 17:06:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso6235770pjj.4;
        Fri, 19 Aug 2022 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=nxQnXGbWeUUPNIxY2ClrZdjRX1n4kVW97+B7G71Nyxk=;
        b=FiDAaYsGz7hLZHUr5TRe1+hLNY8sXUKqKeF9NTidO1I7sMJe6U3lOw7rZGDkXmaBmI
         NKNrP0b+wENNk2FPiBQ+/1hLgk6FUcfGiFPeT57+EpvFUtvS1Ji++1wzsifEQTLaOWZt
         oBM+IRmUF54ltTcJ2AvN+unAgvMvpfntWMMYFQ+7CZ9Il96jsHiDCMiKN7BHlAJEajTb
         p2IHdK10JW6s+igtPYguZyhfqIPprvo01sIN8CpK1kOP8cBasARD4lDopEIK5tzt7CCF
         kn5TZYkniYBzcets2kibnRmpZHs20WnVbp+ipD5gJtWMaDOLjZvGs/johB3VO9pAyYj7
         qixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=nxQnXGbWeUUPNIxY2ClrZdjRX1n4kVW97+B7G71Nyxk=;
        b=0hMkHL459I8wV+B1BanAtvgt6x2Wb9wKTEKooCFADRs2mhyHeAksqsp+xmulfaCNoE
         SseNk41D7zAR30L5PQbeNlq7EXv1oqYwy2c+ZKQ7XAmmhDRP9czZNrpUwOjBtNsMPHaY
         UjpozA4HvF+2lu4iQD6s10qWdNK1BRmRI7NHM26c4Zaw3J4Lv2QJ3uJ4zBcEBu0LZbht
         FiqQJJ33zAjhEAX2DDz6dUNl34Kc2pPqJ3hCHCoSzoQ3k1pLrNvMhOxeXBLPDNEVxCE5
         MOsyXiqfRQe+CGgGz4EH9oSzaZgMS8gThGG2ezsaPKbz/nYY6H6F4uA54vW0bP5f9iFn
         +v2Q==
X-Gm-Message-State: ACgBeo1Ce0ACx17yA6F7f4H4+6oJgndfFwlQHD6AEU7UuFIp3r+ghxMd
        +3+mvEZfEriKZb6rN3QbbBaOMcJjv6Q=
X-Google-Smtp-Source: AA6agR6UYK3tExe1k4Rt1ZteumhmQog7XZZSZVte13IWVs74Gptbb7b3VJgdwz3eqOfizDP99iNakQ==
X-Received: by 2002:a17:902:a70e:b0:172:c859:dcc1 with SMTP id w14-20020a170902a70e00b00172c859dcc1mr3335960plq.121.1660953975827;
        Fri, 19 Aug 2022 17:06:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a2f5])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b0016d2d0ce376sm3672716plx.215.2022.08.19.17.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 17:06:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/7] cgroup: Implement cgroup_file_show()
Date:   Fri, 19 Aug 2022 14:05:51 -1000
Message-Id: <20220820000550.367085-8-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820000550.367085-1-tj@kernel.org>
References: <20220820000550.367085-1-tj@kernel.org>
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

Add cgroup_file_show() which allows toggling visibility of a cgroup file
using the new kernfs_deactivate(). This will be used to hide psi interface
files on cgroups where it's disabled.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index ed53bfe7c46c..f61dd135efbe 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -114,6 +114,7 @@ int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_rm_cftypes(struct cftype *cfts);
 void cgroup_file_notify(struct cgroup_file *cfile);
+void cgroup_file_show(struct cgroup_file *cfile, bool show);
 
 int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen);
 int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ffaccd6373f1..eb096499c72b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4339,6 +4339,29 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
 }
 
+/**
+ * cgroup_file_show - show or hide a hidden cgroup file
+ * @cfile: target cgroup_file obtained by setting cftype->file_offset
+ * @show: whether to show or hide
+ */
+void cgroup_file_show(struct cgroup_file *cfile, bool show)
+{
+	struct kernfs_node *kn;
+
+	spin_lock_irq(&cgroup_file_kn_lock);
+	kn = cfile->kn;
+	kernfs_get(kn);
+	spin_unlock_irq(&cgroup_file_kn_lock);
+
+	if (show)
+		kernfs_activate(kn);
+	else
+		kernfs_deactivate(kn);
+
+	kernfs_put(kn);
+}
+
+
 /**
  * css_next_child - find the next child of a given css
  * @pos: the current position (%NULL to initiate traversal)
-- 
2.37.2

