Return-Path: <linux-fsdevel+bounces-8742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE81F83A91D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22871C20A7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF06A32D;
	Wed, 24 Jan 2024 12:00:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C40960DC0;
	Wed, 24 Jan 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097615; cv=none; b=jCQaHL5ECk41QhJhR7DsesLD1x+qqj3QPATApc/qokZaFypUPpK3OhanOmexb/58lAXJzq7nENOs0K620VGeJo2rkv2s5+9x5imvipHs0ut2pr3hlcqMj/UubiStvRDb2iVdkv3fzdC9K0hdNrgF3EkvB97LxvEXu9Z+SOiMWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097615; c=relaxed/simple;
	bh=rOOuSh+1eZIFPiRqy8Z4jjiN4PmFYfqaD61RmkKO4sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SnTc9+v727RnY8ds6ZxSI+r2ibDZSr2SA8waKJx71JSehByx0nsSmag7nl0oWgHdW0sbbvHZaYaLdEFQ+esEOI6B/HxO/S+DVvdy4mZ13M844msNm50r5jsfsKNreN8Ok2n1D5ddP4SDixK3ThqwzA3rFj49U0k0QmBAnvtmHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-a5-65b0fbb74714
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
Subject: [PATCH v11 22/26] dept: Record the latest one out of consecutive waits of the same class
Date: Wed, 24 Jan 2024 20:59:33 +0900
Message-Id: <20240124115938.80132-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxSHfd/v2mrdl47oK25xaUK2weSyiR51UWN0fiY6tkwTcTHawReo
	FDAFQUxIEIoybgKxFhQJoqm1oGDBiBYYg3DTcNkgiqwwrERt5JZi0QKyAcZ/Tp6c3/k9fx2e
	UtoYb14TEy/pYtRaFSun5WMrytbfm62SAsdTgyE/OxDcbzJoKK6sYKHndjmCipozGJwte+DJ
	9CiC2c5uCoyGHgRXnw1SUNM6hKDenMpC78hK6HNPsNBhyGIh7VolC3+9nsNgv1iAody6Hx7l
	lWFo9Lykwehk4bIxDS+MVxg8JgsHphQfcJgvcTD3LAg6hh4zUD/gB0Uldhbq6jtoaK11YOh9
	UMzCUMV/DDxqbaehJz+HgVvjZSy8njZRYHJPcPB3YymGKv2C6OzUPANtOY0Yzl6/g6HvqQ1B
	Q8YwBmvFYxaa3aMYqq0GCmZutCBw5I5xkJ7t4eDymVwEWekXaeh+38aA3h4Ms++K2R1bxObR
	CUrUVyeK9dOltPiwjIj3Lw1yor5hgBNLrSfFarOveK3OicWrLjcjWi2/s6LVVcCJmWN9WBzv
	6uLE9sJZWhzpM+Kf1h6Wfx8uaTUJki5g2zF5ZPfdKeaEc/mpXMcISkFtskwk44mwgXT9e5P9
	yPeuz9OLzApfkv5+D7XIXsIXpDrnBZOJ5DwlnFtOzJOdS4VPBTV5M1zCLDIt+BDH1NOlskLY
	SK4YUpkP0nWkvKpxSSRb2N8qGli6UQrBZNhynluUEiFNRv6ZNHIfCmvIn+Z+Og8pStEyC1Jq
	YhKi1RrtBv/IpBjNKf+w2GgrWngpU/Lcr7XI1fNLExJ4pFqh2GGplJSMOiEuKboJEZ5SeSn6
	19yWlIpwddJpSRd7VHdSK8U1obU8rVqt+HY6MVwpRKjjpShJOiHpPqaYl3mnoBsNEau6zh8J
	m3Gl231tmrf5b/WfJWY/4I9+TiZKDF+l2WO3H4ja+mPoN93J856ve5exXj5/JDe3bw4IOX3h
	t+PeXiGuSkxmMlKKn/+AVlI+Bbnu2kN5u507d9mOfWLYmmBM33c8KvS7wqwQbeveEm9nZJNt
	MsrY+XOhX802+6aD71+o6LhIdZAvpYtT/w/5RYusTgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRSH+793Z5OXKfRqYTWQQMmUNA4Y0YfAl6AIiaL6UCtfcl5rS51F
	5GVqaWpac13UvLFsWurmrXJiWtqKnOYok3kbUg5NI51oXkqNvhwezu+c59OPwSXFpBcjj70i
	KGJl0VJKRIiOhqTtbl6qEwK+rXpC/u0AcM7dJKCotoaC3ufVCGoaUjBwvA2FL/NTCJY+WnDQ
	anoRlI0N4dDQNYzAVJVKQf+4G1idMxSYNdkUpFXUUtA3uYyBrbAAg2rDEfhwpxyD9sXvBGgd
	FDzSpmFrYwKDRZ2eBl2yD9irHtKwPBYI5uHPJHQWm0kwDfrBgxIbBa0mMwFdLXYM+l8WUTBc
	84eED13vCOjNzyHh2XQ5BZPzOhx0zhkaPrWXYlCnXrNlzK6S0J3TjkFGZT0G1q+vELTdHMXA
	UPOZgk7nFAZGgwaH30/eIrDn/qAh/fYiDY9SchFkpxcSYFnpJkFtC4alhSLqYAjfOTWD82pj
	Im+aLyX49+Uc/+LhEM2r2wZpvtQQzxurfPmKVgfGl/1ykrxBf4viDb8KaD7rhxXjp3t6aP7d
	/SWCH7dqsWPbTov2hwvR8gRBsefAOVGEpXGWvORwVeXax1Ey6nbJQi4MxwZxzZWrxDpT7C5u
	YGARX2cPdgdnzPlGZiERg7OZrlzVz4/UeuDOyri50RJynQnWh7PPft14FrP7uGJNKvlPup2r
	rmvfELms7Z89GNy4kbDB3Kg+j76DRKVokx55yGMTYmTy6GB/ZVREUqxc5X8hLsaA1kqju76c
	34Lm+kM7EMsg6WbxQX2tICFlCcqkmA7EMbjUQzzg+VyQiMNlSVcFRdxZRXy0oOxAWxlCukV8
	+KRwTsJelF0RogThkqD4n2KMi1cyKgr0Nt9LpiMuj72/H7WZubHz+ONDJZGWEXpB0xDmmsoO
	iNRu9VbjqdBrm+J8t9i8A0Ysx576z7gPZTZVWE6f+PLkza3itsjvBY0TvvGOkTRpXWPf3iB5
	il/6PpuyMKQir0cv3J3Xvm4ISjjjSYU1qVTh51ULOMuZwqKycxJXzFJCGSEL9MUVStlfR33r
	vzADAAA=
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


