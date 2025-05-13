Return-Path: <linux-fsdevel+bounces-48835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF037AB5139
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4B68670AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2B2245037;
	Tue, 13 May 2025 10:07:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26342242D7B;
	Tue, 13 May 2025 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130868; cv=none; b=Nut5jM5jf1E/FCR+w/lwqoBprR9wBk7coSBoLdKzFM+Mu5fH4lw3MbAxSBaF5k+z9lgUGJGFVpCllx+PLdjUGloE39cO2uM5dgq03XoXiFsP3GS4FS3UY+AndFUFiGLuX2zjyoV1OxhugKUotxgBFNOdWXGlzPIfpOPjo8tmTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130868; c=relaxed/simple;
	bh=tb6fnFpucKzItJPP15tgDT3weF1MGwlqqKLWWoBgkgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HamhEoDf2AJzk8CvJ1w8ivxTgcitpAi5znC4wFcXFWuLAMWjQORXnVfIrAmQl15S4yE09pOifJ7GNaydGnz1yQ3mdEJchvPdGWnie9OSN5p6b5DokMxGLPYvFkEl0/YfEU8BdfdKrN+qXT5J00lXjHjtWUlsczgmeCpq6eypD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-d8-682319edcf23
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
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v15 01/43] llist: move llist_{head,node} definition to types.h
Date: Tue, 13 May 2025 19:06:48 +0900
Message-Id: <20250513100730.12664-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG/b93qjWvHdFX0OBqjJlmKt5yCGLwFv/7sEWiUbO5bM14Y6tQ
	sQUUE02LxSBYREwBQbFWUggUwWIydNYhBASJiIAVFFGqorVUEqCNVby0GL+c/PI8z3nOl8OR
	sjt0BKdSp4oatSJJzkgoiXeG5Wfv3IXKFeUeOfgmsik4X2tjoOtKNQLbNT0B7pat8Mg/guDj
	vfskFJm6EFwaekrCtdZBBI7KTAZ6Xs6EXt8oA+2mXAaOX65l4IFnkoCBwgICqu2/wjPrMAUd
	+RYCitwMlBYdJ4LjDQEBaxULVt0icFWWsDA5FA3tg04aHI+XwrmyAQZuOtopaG1wEdBz4zwD
	g7YvNHS0tlHgz4uErjNGGmreWRjw+K0kWH2jLHQ3mgloNc+GOkOw8MT4ZxruGBsJOFF+lYDe
	/v8Q3Mp+ToDd5mSg2TdCQL3dRMKHihYErjwvC1mnAiyU6vMQ5GYVUmAYWAMf3wcvX5iIBv3F
	OgpqPjlRfBy2ldkQbh4ZJbGh/hD+4HvIYIffTOG7FgFfL3nKYsOtxyw229NwfeUSfPmmm8CX
	xnw0tledZLB9rIDFOd5eAr/r7GS3zftdsi5RTFKli5rl6/+WKCva9GxKseRwrc5C6dANLgdx
	nMCvFspf/ZKDwqbQ3d1Oh5jhFwt9fQEyxOH8AqHeOBzUJRzJO6cLjy70o5DxA/+b8KLbQYWY
	4hcJ92wmNsRSfo1QUFpHfiuNEqrrGqc4jF8rfKronMrLgpl8czUVKhX4s2FCS+Zd9tvCXOF2
	ZR+Vj6RmNK0KyVTq9GSFKmn1MmWGWnV42T8Hku0o+F7Wo5N/NKCxru1NiOeQfIa0zf2jUkYr
	0rUZyU1I4Eh5uFT/b1CSJioyjoiaA39p0pJEbROK5Cj5HOlK/6FEGb9XkSruF8UUUfPdJbiw
	CB3amzB69fXppSXj468uBp4TEc9m+beO57oC6ifNO/3FE8d29eQZd/Qe3Bijznatjd2X3PDl
	//7oPfOj5jtnp76tMJYlzNoUnmWYGRvTZooaHkrbTZnObZj+ZE9Gc4rsdqYkviPOe/pMzebr
	xdt+wgnxpi2FnrO0bqBAgx1/rtI2HqU9ckqrVEQvITVaxVfKGFVYWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzH+/6e+3H2k/DDPJ2ap3nIHB9j+Eu/eRqThRlu9Zu7qavdVZyN
	3amMKIlET66jK3eXztU8pLNWpNPk9CRJiJlTqXHXROKO+eez197v996ff94MHmQmpzJKVYKo
	VsljpBRLsFtXJy/qnzJHsdTlGQtezykC8sutFLhuWhBYK/UYuB+Fw4uhPgQ/nz7DISfbhaDo
	3WscKuu7EThKT1DQ8mEctHoHKHBmn6Eg+Vo5Bc97RzDoupSFgcW+Bd6YPhLQmGnEIMdNQV5O
	MuY7nzAYNplpMOlCoac0l4aRd2Hg7G4noa7ASYKjcyFcKeyioNrhJKD+bg8GLVX5FHRbf5PQ
	WN9AwFDGNHCdTyeh7IuRgt4hEw4m7wANzTUGDOoNk8CW4ms9+W2UhMfpNRicvH4Lg9aX9xE8
	OPUWA7u1nYI6bx8GFfZsHH6UPELQk9FPQ+rZYRry9BkIzqReIiClSwY/v/s+F3jCQH/VRkDZ
	r3a0fq1gLbQioa5vABdSKg4LP7xtlOAYMhDCEyMv3Mt9TQspDzppwWBPFCpKFwjXqt2YUPTV
	Swp282lKsH/NooW0/lZM+NLURG+bvoddEy3GKJNE9ZK1B1hFSYOejr/MHinXGQkdqmLSUCDD
	c8t5d7OT9DPFzeU7OoZxPwdzs/iK9I8+nWVwrn0M/6LgJfIbE7it/PtmB+Fnggvln1qzaT9L
	OBmflWfD/5XO5C22mr8cyK3gf5U0/c0H+TKZBguRiVgDCjCjYKUqKVaujJEt1hxSaFXKI4uj
	4mLtyLcg07GR83eRpyW8FnEMko6VNLhnK4JIeZJGG1uLeAaXBkv0d3ySJFquPSqq4/arE2NE
	TS2axhDSyZKNkeKBIO6gPEE8JIrxovq/izGBU3VI/up4efSyeQONUYMBi5bWGkNWy/ZJZs4N
	KWr9XHxxe8b4NXtD2Yljvn0/t/vCeodkU650tnMwYKUrf3TzKll1Q+fDyPm735jjDTuqbhco
	89PSl+i0VqNHVTQxorvjctmGQrYtIswyY11qf9SuSu3gWXHG1eLltnm5zybsC+94uNC584aU
	0CjkYQtwtUb+ByZCBgM9AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

llist_head and llist_node can be used by very primitives. For example,
dept for tracking dependencies uses llist in its header. To avoid header
dependency, move those to types.h.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/llist.h | 8 --------
 include/linux/types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 2c982ff7475a..3ac071857612 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -53,14 +53,6 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-struct llist_head {
-	struct llist_node *first;
-};
-
-struct llist_node {
-	struct llist_node *next;
-};
-
 #define LLIST_HEAD_INIT(name)	{ NULL }
 #define LLIST_HEAD(name)	struct llist_head name = LLIST_HEAD_INIT(name)
 
diff --git a/include/linux/types.h b/include/linux/types.h
index 49b79c8bb1a9..c727cc2249e8 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -204,6 +204,14 @@ struct hlist_node {
 	struct hlist_node *next, **pprev;
 };
 
+struct llist_head {
+	struct llist_node *first;
+};
+
+struct llist_node {
+	struct llist_node *next;
+};
+
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 #ifdef CONFIG_ARCH_32BIT_USTAT_F_TINODE
-- 
2.17.1


