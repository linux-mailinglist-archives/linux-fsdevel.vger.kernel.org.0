Return-Path: <linux-fsdevel+bounces-12246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6825E85D4CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1502528C904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4C85D479;
	Wed, 21 Feb 2024 09:50:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC1B4E1C8;
	Wed, 21 Feb 2024 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509009; cv=none; b=kSrcsScbozJdeAOkh9F2Je2R8qNxJENbfwOGpEtx1HDvNHFBz+n/k4KwpA5gomBRDzACqHwYLllNVw8S6IqU8yD8NL73ESauQvL1ct4f5Q3rqUppftmEbo3J+LSdzSDfblwGkGk3q775UI+qC3A+ClpFbbBa+OuADxwgSUshjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509009; c=relaxed/simple;
	bh=rOOuSh+1eZIFPiRqy8Z4jjiN4PmFYfqaD61RmkKO4sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o9ZHXWOAeNjxdO3+4wbKsxhVhV4Pwmga0Od9JiM/0c4pY1mS5s9Fm0LXcHQu14gu4rOtp2UlFMe9GmJTjPv3dx7KLvk/Ku60A6j66BuWlELymDG1D+FSyIs8xfgBtn2Simul2+NLoawcirzp79XRSAM+z3/b083YZbxpFeqDi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-e8-65d5c73b25db
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v12 22/27] dept: Record the latest one out of consecutive waits of the same class
Date: Wed, 21 Feb 2024 18:49:28 +0900
Message-Id: <20240221094933.36348-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfZ732mqXNx3J3kGM0oTMYABxOE8sWfyg8zGL25TEJTiDVd6N
	KhfTKghqgliVi3RChDraKJfZVVoRWx1MqUOIIDilzMqYKUQbNiUWWcA2IqhrvXw5+eX/P+f3
	6fCU8goTzWtz90i6XE22ipXT8okFDQnq3nvSMpc9GqqOL4Pgs1IaLBccLHha7Agclw5hGL+x
	Dv4KBRDM3h6gwFTjQdDwcISCSz2jCNy2Ehbujn0A3uAkC301FSwcbrrAwuCTOQy+2moMducG
	uHWiEUPnzCMaTOMsmE2HcXg8xjBjbebAWhwHflsdB3MPk6FvdIgB9/2l8NNpHwsd7j4aetr9
	GO5esbAw6njNwK2emzR4qioZOP+0kYUnISsF1uAkB3921mNoNYRFR6dfMdBb2Ynh6M8XMXj/
	vorgWukDDE7HEAvdwQAGl7OGghe/3EDgN05wcOT4DAfmQ0YEFUdqaRh42cuAwbcCZp9b2NWr
	SHdgkiIGVwFxh+pp0t8okt/qRjhiuHafI/XOvcRliydNHeOYNEwFGeJsLmOJc6qaI+UTXkye
	3rnDkZunZmky5jXhb2LS5amZUrY2X9Ilfb5NnjVweZrZPT5/n9E/hopRr6wcyXhRSBGbjSH0
	ns84f3/DrPCJODw8Q0U4Slgsuir/ZcqRnKeEY/NF23+32XLE8x8KGjFwtiiyQwtxomNkCEdY
	IXwmNpjb3jkXifbWzjceWTg/Zw4wEVYKK8R7g5epiFMUKmTi4NBr6u3Bx+J12zB9Ainq0bxm
	pNTm5udotNkpiVmFudp9iTvycpwo/FHWg3Nb2tGUJ60LCTxSLVBktXklJaPJ1xfmdCGRp1RR
	CrogHCkyNYVFki4vQ7c3W9J3oRieVn2kWB4qyFQKP2j2SLskabeke99iXhZdjJKM/i3FS4s8
	nl0llrblhk1qxj791RLS2uSLMp/s//67nau3xaZ07f+n0FHn7mh/1r9upTv560BszGbLvG4u
	dYf3QNyac/qEL36NLT3V/e3CdF9VqvrLs56MT0c2LiQma17Z/nRL2VzS1rUrYzZO/RhIy9y+
	CF61qNe7bOjqH66SoFpF67M0yfGUTq/5H5Mq8HFNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUiTaxjGe57309nixSP4UkE1jgRGHYM83BwrooieoqKCqA6BveR73Giu
	2MxlVGgus5mmgdlRKz9qZ+n6moZW00TRZZ3mzGUZKrqkWk3ta9LSPraify5+XPfN76+Lp6LK
	mZm8Rpcm63WSVsUqaMXGxOyFic7HcnzgG4aik/EQ+JhLQ/k1Gwvuq7UIbPVZGHzta+DJhB/B
	5MMuCkqK3QgqhwcoqO8YRNBkPcpCz8gM8ATGWegszmMhu/oaC91vpjD0nzmNoda+AR4UVmFo
	Cb6kocTHQllJNg7FKwxBSw0HlsxY8FpLOZgaXgydg70MtJ3rZKDp2QL493w/C46mTho6Gr0Y
	em6XszBo+8bAg457NLiL8hm4MlbFwpsJCwWWwDgHj1oqMFw3hWw5H74y4MxvwZBz8QYGT98d
	BM25Qxjstl4W2gJ+DHX2Ygo+/9eOwFswysGxk0EOyrIKEOQdO0ND1xcnA6b+BJj8VM6uSCRt
	/nGKmOqMpGmigib3q0Ryq3SAI6bmZxypsO8nddY4Uu3wYVL5PsAQe80Jltjfn+aIedSDyZjL
	xZF7ZydpMuIpwZtm/61YmixrNemy/o/luxTqrpsfmH2+yAMF3hGUiZwRZhTBi8IS8YL9Lgoz
	K8wXnz4NUmGOFuaKdfkvGDNS8JRwPFK0vn3ImhHP/yZIov/SwfAPLcSKtoFeHGal8KdYWdaA
	fjrniLXXW354IkL95TI/E+YoIUF83H2TKkSKCjStBkVrdOmpkkabsMiwR52h0xxYtHtvqh2F
	NmM5PFXUiD72rGlFAo9U05XqBo8cxUjphozUViTylCpaSRtDlTJZyjgo6/cm6fdrZUMrmsXT
	qhjlum3yrighRUqT98jyPln/64r5iJmZyLG6oLA3dzxytI9O/itGfacnbv3LtdtnbZE7SoOH
	ko5rQXruu59jzLtr7F4V+zq+ynTKqTtrnFc/1Cgve/S61JlypH1z1j8ujU0zt775xjv3WNvv
	J9KWNVzY+r+LJLmPrI9ZUv1kk2soh10p7bD2OS66dn7a4RhOnN0sm7suextTVLRBLS2Oo/QG
	6TtCaSsnLwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The current code records all the waits for later use to track relation
between waits and events in each context. However, since the same class
is handled the same way, it'd be okay to record only one on behalf of
the others if they all have the same class.

Even though it's the ideal to search the whole history buffer for that,
since it'd cost too high, alternatively, let's keep the latest one at
least when the same class'ed waits consecutively appear.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/dept.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 1b8fa9f69d73..5c996f11abd5 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1521,9 +1521,28 @@ static struct dept_wait_hist *new_hist(void)
 	return wh;
 }
 
+static struct dept_wait_hist *last_hist(void)
+{
+	int pos_n = hist_pos_next();
+	struct dept_wait_hist *wh_n = hist(pos_n);
+
+	/*
+	 * This is the first try.
+	 */
+	if (!pos_n && !wh_n->wait)
+		return NULL;
+
+	return hist(pos_n + DEPT_MAX_WAIT_HIST - 1);
+}
+
 static void add_hist(struct dept_wait *w, unsigned int wg, unsigned int ctxt_id)
 {
-	struct dept_wait_hist *wh = new_hist();
+	struct dept_wait_hist *wh;
+
+	wh = last_hist();
+
+	if (!wh || wh->wait->class != w->class || wh->ctxt_id != ctxt_id)
+		wh = new_hist();
 
 	if (likely(wh->wait))
 		put_wait(wh->wait);
-- 
2.17.1


