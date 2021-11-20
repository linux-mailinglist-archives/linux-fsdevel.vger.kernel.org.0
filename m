Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF02457B59
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 05:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhKTEx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 23:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbhKTExZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:53:25 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458E0C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:22 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x18-20020a17090a789200b001a7317f995cso7788864pjk.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=79UaOzjGTX1bdBbuOK6OGZYuNHbD+Y6LGP3VMZPWWfo=;
        b=n+LvozaE5Q8BNCS3fqbqo3irax1e6z+BA7Db8d98bRsEGw60v1DGmfPfVE+O44XNGV
         rVwVHQDGp+B/FpyiQCK2k19VRTVEyntKdNaWzv+HFUGu+xeemoywhDpiO46vsBL0LzyO
         CLjU7WusWss/FqNR7Jr324wGgsFJOXNE8X8a8Lh8VTxzYuMgRpH4zYgvIkemxnyBE7ah
         NCcaiY38b6Fdlu7p1vAPSX4GJAx6ugjvXDdTq25+LSYxa3OkEDzLDT11bfizQZ0Et8vR
         417XJRFAOrmVlqwhi/X0zItDeqXEYQ7OMZ7T68e+zwx+iTSa3ex4R3LL8lq/UYh4GWF3
         r/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=79UaOzjGTX1bdBbuOK6OGZYuNHbD+Y6LGP3VMZPWWfo=;
        b=HHSm2tQGBkA0r3ziqRuJGCLRT63NDU+RCzWFC7oYWN2z4J0vlduv/3XnT8/Q7Wl3NI
         R0Ya3Gcm7KjTdOiaDF1MGwrYQdgAyDuVZqLTueYSszEFxrqFMl2iKGz4iGiABo9nBcTB
         osU5BO8+cy4vhL0FgTeqrTLF7ZIQ/UBdDC/78/ZZRAdqH72axb+K5RQMqg7A4fR75j5C
         7gcpCajH0ecA6/DT8M6B8L4xCyceaAb73NLKUR7DFJdcv33U3Y9mQPxBetdIX33LfI4l
         UydtaaPVqt8n1tUnHSTC34sH5/VZ3JvmTS3z0LovsqnWu3SFmb2DF/e7NZi46R6OTOQQ
         WUcg==
X-Gm-Message-State: AOAM5305rS40aYZFFUewnRrTf4/saZKnBkdRKnEDVarbAah9N53QUAkT
        yEmphLh+USkx+DrUESFdcuN0vHb6PSDR5mSXow==
X-Google-Smtp-Source: ABdhPJzXoftBTXQvnJs8EFAoaTwcP0Br6rSCWqmYFOoLP3v+C0fEMkZmUYYmYcCbMQC53bT7Z87J4j5MwXLcZk2+VQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:fa91:560a:d7b4:93])
 (user=almasrymina job=sendgmr) by 2002:a17:902:7005:b0:142:4452:25de with
 SMTP id y5-20020a170902700500b00142445225demr84357056plk.3.1637383821734;
 Fri, 19 Nov 2021 20:50:21 -0800 (PST)
Date:   Fri, 19 Nov 2021 20:50:08 -0800
In-Reply-To: <20211120045011.3074840-1-almasrymina@google.com>
Message-Id: <20211120045011.3074840-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v4 2/4] mm/oom: handle remote ooms
From:   Mina Almasry <almasrymina@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On remote ooms (OOMs due to remote charging), the oom-killer will attempt
to find a task to kill in the memcg under oom. The oom-killer may be
unable to find a process to kill if there are no killable processes in
the remote memcg. In this case, the oom-killer (out_of_memory()) will return
false, and depending on the gfp, that will generally get bubbled up to
mem_cgroup_charge_mapping() as an ENOMEM.

A few considerations on how to handle this edge case:

1. memcg= is an opt-in feature, so we have some flexibility with the
   behavior that we export to userspace using this feature to carry
   out remote charges that may result in remote ooms. The critical thing
   is to document this behavior so the userspace knows what to expect
   and handle the edge cases.

2. It is generally not desirable to kill the allocating process, because it's
   not a member of the remote memcg which is under oom, and so killing it
   will almost certainly not free any memory in the memcg under oom.

3. There are allocations that happen in pagefault paths, as well as
   those that happen in non-pagefault paths, and the error returned from
   mem_cgroup_charge_mapping() will be handled by the caller resulting
   in different behavior seen by the userspace in the pagefault and
   non-pagefault paths. For example, currently if mem_cgroup_charge_mapping()
   returns ENOMEM, the caller will generally get an ENOMEM on non-pagefault
   paths, and the caller will be stuck looping the pagefault forever in the
   pagefault path.

4. In general, it's desirable to give userspace the option to gracefully
   handle and recover from a failed remote charge rather than kill the
   process or put it into a situation that's hard to recover from.

With these considerations, the thing that makes most sense here is to
handle this edge case similarly to how we handle ENOSPC error, and to return
ENOSPC from mem_cgroup_charge_mapping() when the remote charge
fails. This has the desirable properties:

1. On pagefault allocations, the userspace will get a SIGBUS if the remote
   charge fails, and the userspace is able to catch this signal and handle it
   to recover gracefully as desired.

2. On non-pagefault paths, the userspace will get an ENOSPC error which
   it can also handle gracefully, if desired.

3. We would not leave the remote charging process in a looping
   pagetfault (a state somewhat hard to recover from) or kill it.

Implementation notes:

1. To get the ENOSPC behavior we alegedly want, in
   mem_cgroup_charge_mapping() we detect whether charge_memcg() has
   failed, and we return ENOSPC here.

2. If the oom-killer is invoked and finds nothing to kill, it prints out
   the "Out of memory and no killable processes..." message, which can
   be spammy if the system is executing many remote charges and
   generally will cause worry as it will likely be seen as a scary
   looking kernel warning, even though this is somewhat of an expected edge
   case to run into and we handle it adequately. Therefore, in out_of_memory()
   we return early to not print this warning. This is not necessary for the
   functionality of the remote charges.

Signed-off-by: Mina Almasry <almasrymina@google.com>


---

Changes in v4:
- Greatly expanded on the commit message to include all my current
thinking.
- Converted the patch to handle remote ooms similarly to ENOSPC, rather
than ENOMEM.

Changes in v3:
- Fixed build failures/warnings Reported-by: kernel test robot <lkp@intel.com>

Changes in v2:
- Moved the remote oom handling as Roman requested.
- Used mem_cgroup_from_task(current) instead of grabbing the memcg from
current->mm

---
 include/linux/memcontrol.h |  6 ++++++
 mm/memcontrol.c            | 31 ++++++++++++++++++++++++++++++-
 mm/oom_kill.c              |  9 +++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0a9b0bba5f3c8..451feebabf160 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -932,6 +932,7 @@ int mem_cgroup_charge_mapping(struct folio *folio, struct mm_struct *mm,

 struct mem_cgroup *mem_cgroup_get_from_path(const char *path);
 void mem_cgroup_put_name_in_seq(struct seq_file *seq, struct super_block *sb);
+bool is_remote_oom(struct mem_cgroup *memcg_under_oom);

 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 		int zid, int nr_pages);
@@ -1255,6 +1256,11 @@ static inline void mem_cgroup_put_name_in_seq(struct seq_file *seq,
 {
 }

+static inline bool is_remote_oom(struct mem_cgroup *memcg_under_oom)
+{
+	return false;
+}
+
 static inline int mem_cgroup_swapin_charge_page(struct page *page,
 			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c4ba7f364c214..3e5bc2c32c9b7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2668,6 +2668,35 @@ void mem_cgroup_put_name_in_seq(struct seq_file *m, struct super_block *sb)
 	__putname(buf);
 }

+/*
+ * Returns true if current's mm is a descendant of the memcg_under_oom (or
+ * equal to it). False otherwise. This is used by the oom-killer to detect
+ * ooms due to remote charging.
+ */
+bool is_remote_oom(struct mem_cgroup *memcg_under_oom)
+{
+	struct mem_cgroup *current_memcg;
+	bool is_remote_oom;
+
+	if (!memcg_under_oom)
+		return false;
+
+	rcu_read_lock();
+	current_memcg = mem_cgroup_from_task(current);
+	if (current_memcg && !css_tryget_online(&current_memcg->css))
+		current_memcg = NULL;
+	rcu_read_unlock();
+
+	if (!current_memcg)
+		return false;
+
+	is_remote_oom =
+		!mem_cgroup_is_descendant(current_memcg, memcg_under_oom);
+	css_put(&current_memcg->css);
+
+	return is_remote_oom;
+}
+
 /*
  * Set or clear (if @memcg is NULL) charge association from file system to
  * memcg.  If @memcg != NULL, then a css reference must be held by the caller to
@@ -6814,7 +6843,7 @@ int mem_cgroup_charge_mapping(struct folio *folio, struct mm_struct *mm,
 	if (mapping_memcg) {
 		ret = charge_memcg(folio, mapping_memcg, gfp);
 		css_put(&mapping_memcg->css);
-		return ret;
+		return ret == -ENOMEM ? -ENOSPC : ret;
 	}

 	return mem_cgroup_charge(folio, mm, gfp);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 0a7e16b16b8c3..8db500b337415 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1108,6 +1108,15 @@ bool out_of_memory(struct oom_control *oc)
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
+		if (is_remote_oom(oc->memcg)) {
+			/*
+			 * For remote ooms with no killable processes, return
+			 * false here without logging the warning below as we
+			 * expect the caller to handle this as they please.
+			 */
+			return false;
+		}
+
 		dump_header(oc, NULL);
 		pr_warn("Out of memory and no killable processes...\n");
 		/*
--
2.34.0.rc2.393.gf8c9666880-goog
