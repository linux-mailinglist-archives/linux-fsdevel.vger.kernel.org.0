Return-Path: <linux-fsdevel+bounces-70421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C3C99F24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 04:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D355345823
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 03:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9646273D9A;
	Tue,  2 Dec 2025 03:12:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056A125A0;
	Tue,  2 Dec 2025 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764645170; cv=none; b=kYCYNj4piOrPVnl7LznTLmf0cuHIOcdcOov9x+5w8Fkt9b8jgIN4EJwkKUAa3LLcEFk5N006br4UbwiRuMdXWDiUqHcOjQc7puNHZkh4YpVfMjQCcrpuXuftW8shkm8ss2S1RMHrshE1og55w0XPETAgOLVhgqVhqTCX/86c724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764645170; c=relaxed/simple;
	bh=AYOyZ6uKezjZhhQ85ozMAudJUekf+JOOxvH3SLg7DsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N4xh9kM350r2hHmp+7uwL8bs1Cj+mQX3Tapa9hVwIPBKXQ6WaTPCzTZ69yKy6dERXGc3r9NfPYPW2tLNQ+6YO07+oaFthM61MKpAuBvYieJeneiVoeJhBG1lGgi6mBZR3blwv2sCB7pjI+7u16abeBrfOedTyMaLkCxybd4TP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dL5Rv5gG9zYQtjP;
	Tue,  2 Dec 2025 11:12:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF1DD1A13C5;
	Tue,  2 Dec 2025 11:12:44 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBHb5wgWS5pxEM0AQ--.41565S2;
	Tue, 02 Dec 2025 11:12:44 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	jackmanb@google.com,
	ziy@nvidia.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next] cgroup: switch to css_is_online() helper
Date: Tue,  2 Dec 2025 02:57:47 +0000
Message-Id: <20251202025747.1658159-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHb5wgWS5pxEM0AQ--.41565S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kKw1DXr4rJry7ZF1xGrg_yoW5ZryxpF
	s7Ga47Ka1UAF13GFZ5Ka4q934Svan3GayYk3y8X347Zr13t34Yq3y093W5tFy8tF1akryS
	qFs0yry8Cw4jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Use the new css_is_online() helper that has been introduced to check css
online state, instead of testing the CSS_ONLINE flag directly. This
improves readability and centralizes the state check logic.

No functional changes intended.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 fs/fs-writeback.c          | 2 +-
 include/linux/memcontrol.h | 2 +-
 kernel/cgroup/cgroup.c     | 4 ++--
 mm/memcontrol.c            | 2 +-
 mm/page_owner.c            | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6800886c4d10..5dd6e89a6d29 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -981,7 +981,7 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct folio *folio
 
 	css = mem_cgroup_css_from_folio(folio);
 	/* dead cgroups shouldn't contribute to inode ownership arbitration */
-	if (!(css->flags & CSS_ONLINE))
+	if (!css_is_online(css))
 		return;
 
 	id = css->id;
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0651865a4564..6a48398a1f4e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -893,7 +893,7 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
 {
 	if (mem_cgroup_disabled())
 		return true;
-	return !!(memcg->css.flags & CSS_ONLINE);
+	return css_is_online(&memcg->css);
 }
 
 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1e4033d05c29..ad0a35721dff 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4939,7 +4939,7 @@ bool css_has_online_children(struct cgroup_subsys_state *css)
 
 	rcu_read_lock();
 	css_for_each_child(child, css) {
-		if (child->flags & CSS_ONLINE) {
+		if (css_is_online(child)) {
 			ret = true;
 			break;
 		}
@@ -5744,7 +5744,7 @@ static void offline_css(struct cgroup_subsys_state *css)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	if (!(css->flags & CSS_ONLINE))
+	if (!css_is_online(css))
 		return;
 
 	if (ss->css_offline)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be810c1fbfc3..e2e49f4ec9e0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -281,7 +281,7 @@ ino_t page_cgroup_ino(struct page *page)
 	/* page_folio() is racy here, but the entire function is racy anyway */
 	memcg = folio_memcg_check(page_folio(page));
 
-	while (memcg && !(memcg->css.flags & CSS_ONLINE))
+	while (memcg && !css_is_online(&memcg->css))
 		memcg = parent_mem_cgroup(memcg);
 	if (memcg)
 		ino = cgroup_ino(memcg->css.cgroup);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index a70245684206..27d19f01009c 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -530,7 +530,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 	if (!memcg)
 		goto out_unlock;
 
-	online = (memcg->css.flags & CSS_ONLINE);
+	online = css_is_online(&memcg->css);
 	cgroup_name(memcg->css.cgroup, name, sizeof(name));
 	ret += scnprintf(kbuf + ret, count - ret,
 			"Charged %sto %smemcg %s\n",
-- 
2.34.1


