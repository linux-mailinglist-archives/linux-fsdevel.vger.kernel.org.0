Return-Path: <linux-fsdevel+bounces-13715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDFD8731DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803F91F21686
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603B5657D0;
	Wed,  6 Mar 2024 08:55:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EFD62814;
	Wed,  6 Mar 2024 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715347; cv=none; b=PwUDtci8aZdvL6k7YzbjifEEEvrbdZTelpDkiLPawXTuxlNMLCyG2/wPFQMDO2yJHfkTeQ2LfxCedJBEkx4M80gLX3dQdeAHPF/yzazCPuHVrg0z8xka5XaNjgj5c8ZGP4FVxGdR7RBDl/QNDQeXNapJH6e0oaledOjAcj8P+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715347; c=relaxed/simple;
	bh=9o9SI0ONdb1WbiIWXrCSb5nX53qir4UGX5Gt0IQgpYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DKoe08a0o9UJECfKJb1Fqnh5s7lsAtGm7hXXKVzGKhkne8WZtmXb6X3RTJmPbyNEmku/WiowoZWQil+lq1+11omjHNEEWLBvm1vlLdLWgdQJDHZluejk5LC+S6xJk17Yqd3CDtX+gkku3h/KbKoyQ80UTv9pjP6FzFu/kLOBp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-48-65e82f7e60ef
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
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v13 18/27] dept: Apply timeout consideration to swait
Date: Wed,  6 Mar 2024 17:55:04 +0900
Message-Id: <20240306085513.41482-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSXUyTZxTHfZ73sw01b4qJ7/BCU4Mk6hAUl7OEEEycPBeaGIk3aNROXqWx
	gCmCQtwEKYQVEMXQqiCBipVAJ9AyFbGmtqGCRMYGccwgmaQROvlQoMUCbhbUm5Nf/uefX87F
	4SllOxPBazLOSLoMtVbFymn5ZJj52wvbxqWYm/couFIWA/65EhpqWqws9N9tRmBtL8Dg60qC
	vwITCBaf/06BqaofQf3rVxS0e0YQOBovsjDgXQ2D/mkWeqpKWSi81cLCH2+XMAwbKzE02/ZB
	72UzBmdwjAaTj4VqUyEOjXEMQUsTB5b8SBhtvMHB0utY6Bl5wYDj5Ra4XjvMwiNHDw2eB6MY
	Bh7WsDBi/Z+BXk83Df1Xyhn4dcrMwtuAhQKLf5qDP511GFr1IVHx7H8MPC13YihuaMMw+Hcn
	gscl/2CwWV+w4PZPYLDbqihYuNOFYPTSJAdFZUEOqgsuISgtMtKgH94Jix9q2MTviXtimiJ6
	+1niCNTR5JlZJB03XnFE//glR+ps2cTeuJnceuTDpH7GzxBb0y8ssc1UcsQwOYjJVF8fR7qv
	LdLEO2jC+yNS5PGpklaTI+m2JRyTp7V4C9DpWfacqauByUfPGAOS8aIQJ5ZWWqiv3NvawS4z
	K0SJQ0PBlXyNsEG0l79Z6VPChFxs6NtjQDwfLvwg+qoPLse0ECmW2bvxMiuE78RAWxX9Wble
	bG51rmhkobxiqmJFrxR2is8L60MsD3VKZeIdr/PLPd+ITxqH6MtIUYdWNSGlJiMnXa3RxkWn
	5WZozkUfz0y3odAvWX5aOvQAzfQnu5DAI1WYIlE2JikZdU5WbroLiTylWqM4v+CVlIpUdW6e
	pMs8qsvWSlkutI6nVWsV2wNnU5XCSfUZ6ZQknZZ0X7eYl0Xko/W1xYnBBMOJ4w1U+Km1W5Pn
	o2TvxiPCXTMfYzNv+lJ+PnA4LjzTEG/f9O/Vk8rftOvcbndUpKdkr6Qn4kFPgbbsSHLemx2J
	smu1eSey62+39Z6Pqdgt3R83Homs/XF+ZM/ed9HGOavPtUudZDZ2bgwY7toTtiTdV3UOODpS
	ht7nqeisNHXsZkqXpf4EpmvrJEcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0wTWRiGPWdmzgzVmtnS7I41Rm1EsqIg0Zovq1Fjgh41GhOjRv5AtROp
	XNMqwkZ3QaphkaqYQFXQcGkqgWqh5YfuCkEQ5KKA28YLQbKwiFQQjFqyFaICZv+8efJ+X55f
	r8CoijiNYEw5IZtS9ElaomAVezfmrPktakReO/jvz1CQvxYCn3JZKHE5CfTcqUbgrMvG4G/Z
	Ac8nxxBMPelmwFbYg6Bs4BUDda39COorzxLwDi0EX2CCQHvhBQI5FS4CT0enMfQVXcFQ7d4D
	nZfLMTQG37Bg8xMotuXgmRjBEHRU8eDICoPByus8TA9EQ3v/Mw6ab7RzUN8bAddu9hG4X9/O
	QuvdQQzeP0sI9Du/ctDZ2sZCT4GVg9vj5QRGJx0MOAITPPzdWIqhxjJjO//xCwePrI0Yzttr
	Mfhe/oWgIfcfDG7nMwLNgTEMHnchA59vtSAYvPiOh3P5QR6Ksy8iuHCuiAVLnw6m/ishW3+h
	zWMTDLV4TtH6yVKWdpRL9N71Vzy1NPTytNR9knoqV9GK+35Myz4EOOqu+oNQ94crPM1758N0
	vKuLp21Xp1g65LPhfYtjFZsMcpIxXTZFbY5XJLiGslHaR5Jha7FzWaiDy0MhgiSulzpr7pFZ
	JmK49OJFkJlltbhM8liH534YcUwh2bu25yFBCBVjJH/xgdmaFcOkfE8bnmWluEGarC1kvyuX
	StU1jXOakJn+0vilOb1K1ElPcsrIZaQoRfOqkNqYkp6sNybpIs2JCZkpxozIo6nJbjSzFseZ
	6YK76JN3RxMSBaRdoNwa8kZWcfp0c2ZyE5IERqtWnv48JKuUBn3mr7IpNc50Mkk2N6HFAqv9
	SbnrkByvEo/pT8iJspwmm/6/YiFEk4Uipm+kRf2o686N9/deW7Ypltv2uPuI8/VrO7v+97r5
	4fk7UfOG7AxvqE/9dngle9b1Rb2iJ/Vg4vCSmNVShWzYrNn9MKxo+fO4mB+O26fiLYtMh2n3
	A+vB1dvzNO/3rtjo2m+IvGU9FO3tiH77ONgyMjDCb3GH6radWjd/XDN6zFCgZc0J+uhVjMms
	/wZTd+HgKQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to swait, assuming an input 'ret' in ___swait_event()
macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/swait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 277ac74f61c3..233acdf55e9b 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -162,7 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
-- 
2.17.1


