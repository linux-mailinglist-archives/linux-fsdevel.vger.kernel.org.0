Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6206F4531
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjEBNju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 09:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjEBNjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 09:39:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FCF6A5E;
        Tue,  2 May 2023 06:38:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3FC7722124;
        Tue,  2 May 2023 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683034730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpw1/CS8jewUjSsdmSx7N0a/briOC9eP8uaWobg+SbE=;
        b=fE3Cff0u2uDDZoTwPGZOiCHhWMWW2sCmMD5CFUkuzcVoLi2vh0pm8Rwr/uTuKzp8yUeamE
        ny+LtbLzNp+7qONlp+LrgnBakxzmXydMKFc3U8iqdaukFUOm4Q7DmwqXXxGO0WxmdDOEX8
        ka0xGI08HvsuJRFVAK3WDLeiAiUHjZA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10904139D2;
        Tue,  2 May 2023 13:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oDU7A2oSUWTOYQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 02 May 2023 13:38:50 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: [RFC PATCH 3/3] cgroup: Do not take css_set_lock in cgroup_show_path
Date:   Tue,  2 May 2023 15:38:47 +0200
Message-Id: <20230502133847.14570-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502133847.14570-1-mkoutny@suse.com>
References: <20230502133847.14570-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

/proc/$pid/mountinfo may accumulate lots of entries (causing frequent
re-reads of whole file) or lots cgroupfs entries alone.
The cgroupfs entries rendered with cgroup_show_path() may increase/be
subject of css_set_lock contention causing further slowdown -- not only
mountinfo rendering but any other css_set_lock user.

We leverage the fact that mountinfo reading happens with namespace_sem
taken and hierarchy roots thus cannot be freed concurrently.

There are three relevant nodes for each cgroupfs entry:

        R ... cgroup hierarchy root
        M ... mount root
        C ... reader's cgroup NS root

mountinfo is supposed to show path from C to M.

Current's css_set (and linked root cgroups) are stable under
namespace_sem, therefore current_cgns_cgroup_from_root() doesn't need
css_set_lock.

When the path is assembled in kernfs_path_from_node(), we know that:
- C kernfs_node is (transitively) pinned via current->nsproxy,
- M kernfs_node is pinned thanks to namespace_sem,
- path C to M is pinned via child->parent references (this holds also
  when C and M are in distinct subtrees).

Streamline mountinfo rendering a bit by relieving css_set_lock and add
careful notes about that.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 32d693a797b9..e2ec6f0028be 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1407,12 +1407,18 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 	struct cgroup *res_cgroup = NULL;
 
 	if (cset == &init_css_set) {
+		/* callers must ensure root stability */
 		res_cgroup = &root->cgrp;
 	} else if (root == &cgrp_dfl_root) {
 		res_cgroup = cset->dfl_cgrp;
 	} else {
 		struct cgrp_cset_link *link;
-		lockdep_assert_held(&css_set_lock);
+		/* cset's cgroups are pinned unless they are root cgroups that
+		 * were unmounted.  We look at links to !cgrp_dfl_root
+		 * cgroup_root, either lock ensures the list is not mutated
+		 */
+		lockdep_assert(lockdep_is_held(&css_set_lock) ||
+			       lockdep_is_held_type(&namespace_sem, -1));
 
 		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
 			struct cgroup *c = link->cgrp;
@@ -1438,8 +1444,6 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
 	struct cgroup *res = NULL;
 	struct css_set *cset;
 
-	lockdep_assert_held(&css_set_lock);
-
 	/* namespace_sem ensures `root` stability on unmount */
 	lockdep_assert(lockdep_is_held_type(&namespace_sem, -1));
 
@@ -1905,10 +1909,8 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 	if (!buf)
 		return -ENOMEM;
 
-	spin_lock_irq(&css_set_lock);
 	ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
 	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
-	spin_unlock_irq(&css_set_lock);
 
 	if (len >= PATH_MAX)
 		len = -ERANGE;
-- 
2.40.1

