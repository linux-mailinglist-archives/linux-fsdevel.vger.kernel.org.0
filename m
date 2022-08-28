Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9015A3BF2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 07:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiH1FFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 01:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiH1FFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:05:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA622BD1;
        Sat, 27 Aug 2022 22:05:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c16-20020a17090aa61000b001fb3286d9f7so10193080pjq.1;
        Sat, 27 Aug 2022 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=B3vo1ERHcB4zq3BeH92B14/O9uQqF/BKTHSf1xE1Enc=;
        b=S0EVI4k7ynhZt0aAXiLq873oNhgtJVoqN10Xy5Xuzkv+5c4rA/oqJec9Wy7QmF/EwI
         S9lHn+FinHDm1Yj3VkeHYetRTMMHo/IuD7/M78sa31sB9C1wjQRuTkdZcLIPNnPH2B7B
         PSJFSjbUUO0aIWRNuNvILuntXcwlun2hdc7CSKBcLzAQqAcex7WXpZZSU5lvxuiwn4Gp
         7acVcLbWmZApILuqh5da12jbxz3ySqoNmq/tRl1yx3UWDpiVSmtTtgavTvHMDYrU7hIr
         m95zxj+JLYOWvt3dEH16WhXP51jkc8Qtr9lMfjhKuP3el4M/rLrcobz7K7x+fKY5IfHk
         jj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=B3vo1ERHcB4zq3BeH92B14/O9uQqF/BKTHSf1xE1Enc=;
        b=a40X7B7fzr+VM3cAIL3GkzGaL5s2TMOqSuin+nCwpDSWujx+RchTtZOkWMcJjDuy9A
         TOfpBxdEcVTQTkjyUshmoDrmbVDsxPXZWdyuaslkgHgpl6C/eHDjnXSAybUP2ufQJ4s0
         o5+7Y4uN93zLFTfh+quXjg8GKCTr8eXFwi2grD2j+a4+jrQId6yDhu3eY+jn99PpQ790
         PdmCieuTxRcheNGB+cNkSqjn8vJ8zE05ynrc7CYcmSUFIhWx4IE+rNbW0nnvj4avGNNf
         nJ8aUpoR/pqQXcSc08QhLCY6AkNOj8iixUmibztyR7sD+g5vcR2DklKyz8OkxEmc8Ij3
         +oaA==
X-Gm-Message-State: ACgBeo1QNJRHYqVrjvehu5TRoEOxeDzXmxgs4CJz9LP9f0Q/BlQXU9YS
        Ry6HDrTqoV7KFExA+qXfpSM=
X-Google-Smtp-Source: AA6agR4b8/MDgCe/zpx0U3Tml7OGFw6R1/0M0oWQd8Y0ejtAM8ACzptlnC2biGnPO+wjP1f3IEZXnQ==
X-Received: by 2002:a17:902:f711:b0:170:9e3c:1540 with SMTP id h17-20020a170902f71100b001709e3c1540mr10678679plo.22.1661663107603;
        Sat, 27 Aug 2022 22:05:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id mi6-20020a17090b4b4600b001f1acb6c3ebsm4191395pjb.34.2022.08.27.22.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:05:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 9/9] cgroup: Implement cgroup_file_show()
Date:   Sat, 27 Aug 2022 19:04:40 -1000
Message-Id: <20220828050440.734579-10-tj@kernel.org>
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

Add cgroup_file_show() which allows toggling visibility of a cgroup file
using the new kernfs_show(). This will be used to hide psi interface files
on cgroups where it's disabled.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index ffaccd6373f1..217469a1ea29 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4339,6 +4339,26 @@ void cgroup_file_notify(struct cgroup_file *cfile)
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
+	if (kn)
+		kernfs_show(kn, show);
+
+	kernfs_put(kn);
+}
+
 /**
  * css_next_child - find the next child of a given css
  * @pos: the current position (%NULL to initiate traversal)
-- 
2.37.2

