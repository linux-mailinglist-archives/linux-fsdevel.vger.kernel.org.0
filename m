Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C616449DF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 22:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbhKHVW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 16:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbhKHVWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:22:54 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C94C061570
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Nov 2021 13:20:09 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u10-20020a170902e80a00b001421d86afc4so6761436plg.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Nov 2021 13:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=ZMz9mAglfr0087cpLEYUjV++mI1ePPikWKx3K/Mi3/g=;
        b=eQWejA7DFPbb3XHQdQsO1O81F5j5nVRtuzAWVptvU8ipbvidXvGHeRvBEGV3TQkuZF
         N3LeJhdmJgoOx/k2uvb5EIouPRu3C7cFY65zSv0oTcZDXNgPzd9eSIlizIPrInInwDtL
         5wXMuiLX4K8Rno4G9cb4cN98D3aUBpOCjdLKD7ujQGYDACFdBqyO7WYQ8GMQND9QCR1b
         PT/05SKYcgXAKhwmuBt6ectzJBGyMkfPIcH5RzlDAwmZhGPxX78FC3ZWaoJFPUNPmRdk
         oYfNA+dmEwc22B5Pd6dhT5v9UApeCz8JPwyof+w2wq84JtHlW6pTHqan783jaEiRQAA9
         bi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=ZMz9mAglfr0087cpLEYUjV++mI1ePPikWKx3K/Mi3/g=;
        b=omPDG5X+u9pbSAX217Czw0sHJjv3FXO5aK1/2v1G5NnBvpVEsteinim6trD0kJ/45M
         8pp7QyVmpte0LIwao7azPOROZ5c7dyH0zD6cfUHB/Dv71kmJT2SPobOGcx+x21q6YqGW
         G9LAoaokuu1Txv8WqM3Zb24yhrXMZ2scjpfqxT5Lq3pKZiXniuzpoNXxiYj8kp3vZRlW
         Km3oItvMWmwq2WW8g11wXRFppijxefyiynQcH/Xl737+t5Qt7Kibf5PSwUGxEaghF/q/
         keHZ9yPDHb5ESHqCwXo0Hk4GUDlVDMz/Ad5q+ayl3/vl+ng2VXgZ+yBsHFdpoacV5kXq
         Yz3g==
X-Gm-Message-State: AOAM531XISDuWI77glYOompAd2hi8CV3F36nTiz0xgOvh23ibep0pEph
        6ccLOcpMeoEIrmnTv6etW7LdI79BYvNJtMs2AA==
X-Google-Smtp-Source: ABdhPJyqUdcqHHS5ZEYdqfLkpdwzUGFGnjlm/Fxt/QXzAUvg/F+LJxhmAcpzJ6AmbPdNMFtj9kgXoLfmK/WLh9sHaQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:8717:7707:fb59:664e])
 (user=almasrymina job=sendgmr) by 2002:a17:902:bb96:b0:13f:b181:58ef with
 SMTP id m22-20020a170902bb9600b0013fb18158efmr2368937pls.2.1636406409232;
 Mon, 08 Nov 2021 13:20:09 -0800 (PST)
Date:   Mon,  8 Nov 2021 13:19:56 -0800
In-Reply-To: <20211108211959.1750915-1-almasrymina@google.com>
Message-Id: <20211108211959.1750915-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20211108211959.1750915-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v1 2/5] mm: add tmpfs memcg= permissions check
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Restricts the mounting of tmpfs:

mount -t tmpfs -o memcg=<cgroup>

Only if the mounting task is allowed to open <cgroup>/cgroup.procs file
and allowed to enter the cgroup. Thus, processes are allowed to direct
tmpfs changes to a cgroup that they themselves can enter and allocate
memory in.

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: Michal Hocko <mhocko@suse.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Thelen <gthelen@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Roman Gushchin <songmuchun@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: riel@surriel.com
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: cgroups@vger.kernel.org

---
 mm/memcontrol.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 389d2f2be9674..2e4c20d09f959 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -62,6 +62,7 @@
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/string.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -2585,9 +2586,32 @@ void mem_cgroup_handle_over_high(void)
  */
 struct mem_cgroup *mem_cgroup_get_from_path(const char *path)
 {
-	struct file *file;
+	static const char procs_filename[] = "/cgroup.procs";
+	struct file *file, *procs;
 	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg;
+	char *procs_path =
+		kmalloc(strlen(path) + sizeof(procs_filename), GFP_KERNEL);
+
+	if (procs_path == NULL)
+		return ERR_PTR(-ENOMEM);
+	strcpy(procs_path, path);
+	strcat(procs_path, procs_filename);
+
+	procs = filp_open(procs_path, O_WRONLY, 0);
+	kfree(procs_path);
+
+	/*
+	 * Restrict the capability for tasks to mount with memcg charging to the
+	 * cgroup they could not join. For example, disallow:
+	 *
+	 * mount -t tmpfs -o memcg=root-cgroup nodev <MOUNT_DIR>
+	 *
+	 * if it is a non-root task.
+	 */
+	if (IS_ERR(procs))
+		return (struct mem_cgroup *)procs;
+	fput(procs);

 	file = filp_open(path, O_DIRECTORY | O_RDONLY, 0);
 	if (IS_ERR(file))
--
2.34.0.rc0.344.g81b53c2807-goog
