Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7771AFDB6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 21:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgDSTpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 15:45:47 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38204 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgDSTpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:45:45 -0400
Received: by mail-pj1-f67.google.com with SMTP id t40so3482889pjb.3;
        Sun, 19 Apr 2020 12:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lw6CMKkQMFMHq+JcbcXT4Wlc0L0GLPdzzdwm/oxZzJU=;
        b=UINH5tFzNaYbytIVwIEd7daO7qPinwxDMDt4fbmxezvJjg/fxHHnDuUDhEnir2hNAz
         +sLT47iycwrBacAeyug2YjsYM1foG1peLFxeBhLZsYRim+WwMslw+QnFJJRtwKW1XbrW
         TnIJ/ZRvTN9ZXwZuCQozyiPUSgdWYhO9SkH5dM0/HOrWQht7IQxd9vk/q6oZJLAh7OD3
         WCYxrsQZZ5/s+prZ4nntTEJPhreHd46i6EGaEKHhCvr1u+gUR9rN7LiaY27aSHEXbG1i
         jRTFxqDwXPMxU1xsBdK2ZM0DMnBFX1dwzLJ79DyEn14gC4eRmUD+UrRfPi4/NlpvLLaY
         0iaQ==
X-Gm-Message-State: AGi0PubVu5/nIMRrsfPgt72eLVabXsICncb4SKFSbYN3KCL/g4jXUGvf
        AfbHYn+1UWlOOSOVLObagcg=
X-Google-Smtp-Source: APiQypJN2vwqTccXzDsvJU7EvUNJe2PNem8YoTGnDKMmXr8pElEwHxwiT3otlRDKvstViTgiEvw3Lw==
X-Received: by 2002:a17:90a:d3ce:: with SMTP id d14mr2807740pjw.46.1587325544475;
        Sun, 19 Apr 2020 12:45:44 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s63sm11869114pfb.44.2020.04.19.12.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:45:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D737641EDA; Sun, 19 Apr 2020 19:45:38 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 05/10] blktrace: upgrade warns to BUG_ON() on unexpected circmunstances
Date:   Sun, 19 Apr 2020 19:45:24 +0000
Message-Id: <20200419194529.4872-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200419194529.4872-1-mcgrof@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the request_queue removal is scheduled synchronously again,
we have certain expectations on when debugfs directories used for
blktrace are used. Any violation of these expecations should reflect
core bugs we want to hear about.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/blktrace.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8f87979d0971..909db597b551 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -498,10 +498,7 @@ static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
 	struct dentry *dir = NULL;
 
 	/* This can only happen if we have a bug on our lower layers */
-	if (!q->kobj.parent) {
-		pr_warn("%s: request_queue parent is gone\n", buts->name);
-		return NULL;
-	}
+	BUG_ON(!q->kobj.parent);
 
 	/*
 	 * From a sysfs kobject perspective, the request_queue sits on top of
@@ -510,32 +507,19 @@ static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
 	 * that if blktrace is going to be done for it.
 	 */
 	if (blk_trace_target_disk(buts->name, kobject_name(q->kobj.parent))) {
-		if (!q->debugfs_dir) {
-			pr_warn("%s: expected request_queue debugfs_dir is not set\n",
-				buts->name);
-			return NULL;
-		}
+		BUG_ON(!q->debugfs_dir);
+
 		/*
 		 * debugfs_lookup() is used to ensure the directory is not
 		 * taken from underneath us. We must dput() it later once
 		 * done with it within blktrace.
+		 *
+		 * This is also a reaffirmation that debugfs_lookup() shall
+		 * always return the same dentry if it was already set.
 		 */
 		dir = debugfs_lookup(buts->name, blk_debugfs_root);
-		if (!dir) {
-			pr_warn("%s: expected request_queue debugfs_dir dentry is gone\n",
-				buts->name);
-			return NULL;
-		}
-		 /*
-		 * This is a reaffirmation that debugfs_lookup() shall always
-		 * return the same dentry if it was already set.
-		 */
-		if (dir != q->debugfs_dir) {
-			dput(dir);
-			pr_warn("%s: expected dentry dir != q->debugfs_dir\n",
-				buts->name);
-			return NULL;
-		}
+		BUG_ON(!dir || dir != q->debugfs_dir);
+
 		bt->backing_dir = q->debugfs_dir;
 		return bt->backing_dir;
 	}
-- 
2.25.1

