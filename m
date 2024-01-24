Return-Path: <linux-fsdevel+bounces-8740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2924483A916
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9101C20B97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322316A00A;
	Wed, 24 Jan 2024 12:00:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D513657DC;
	Wed, 24 Jan 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097614; cv=none; b=I4p5mvKjRzkXZk89N+Oe5J1jSmx1g1lfBb9HBTEQOcd7Haq96WkVpLK9WQ4d/wnYIK1oVwq0QROESsTrv/7Nctk+/gsLe6534Vfi50d6dFTouv9V3y+9lFne4x5JLm9bqNyfEGFjdUECQqNaZFr3qpoe5E37felDr6R3yBI7Z8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097614; c=relaxed/simple;
	bh=oVu1M/z+Be6zJoonqEicwRg8jn1j0IbzUk3u5AE/er0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jIA7ZM+mXFXOGsLXQxdWEGtXusxDqnLY6pPze3NirweKx//ndNoU+DtvZTdGfPuCE27YI6B4rcVfR/vaQLIBlV/fmWJ+/97fMofmliv+iEzxmPEtUSfBhzgth/WUzP2T+o6GrgpZN0Kho9i97dAhiecnHm8p+hzvqxC293/wUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-85-65b0fbb7a24d
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
Subject: [PATCH v11 20/26] dept: Apply timeout consideration to hashed-waitqueue wait
Date: Wed, 24 Jan 2024 20:59:31 +0900
Message-Id: <20240124115938.80132-21-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2SW0xTWRSG3ftc26HmTNXMEWM0NUanRgcVzZoZo/hgPF5DML7ogzbDybQZ
	qKZFBJPBKsULUlSSggiaFrQ2BSm0GhltlYHIRQVRqhamkILEkQBC0CK1eCkYfVn5sta/vqef
	JeS3qVhWo00TdVpVioKWktLhGOvyW5FqMc4TWA3n8+Ig9O4UCaXOShraqyoQVN44hmHg/mZ4
	MT6EINL6mIAiczsCa283ATcaexB47cdp6OifCb7QCA0t5jM0ZJc7aXgyOIkhUFiAocK1Ax6e
	K8NQF/6fhKIBGkqKsnF0vMYQtjkYsBkWQ5/9IgOTvSuhpec5Bd6uZVB8OUCDx9tCQmNtH4aO
	26U09FR+puBhYzMJ7edNFFx/U0bD4LiNAFtohIGndRYM1cao6MTbTxQ0meownLhSg8HXeQfB
	3VNBDK7K5zQ0hIYwuF1mAj5cu4+gL3+YgZy8MAMlx/IRnMkpJOHxxyYKjIE1EJkopRN+ExqG
	RgjB6D4seMctpPCgjBf+udjNCMa7XYxgcR0S3HalUO4ZwIJ1LEQJLsdpWnCNFTBC7rAPC2/a
	2hih+UKEFPp9RThx3h7pumQxRZMu6n5Zv1+qfpTtRAfzmYzRgAkbUC+ViyQsz8XzZkvkO78c
	u0lMMc0t4f3+8DTP5hbybtOraEbKEtzJH3j7aCudi1h2Frebfx9WTmVIbjH/6n0xOcUybi3/
	YfIS89W5gK+orpv2SKL768Vd0xk5t4YPOs4yU06ey5bwDQED8fVhLv+v3U+eQzILmuFAco02
	PVWlSYlfoc7UajJW/HEg1YWijbL9Pbm3Fo2176pHHIsUMbIEh1OUU6p0fWZqPeJZQjFb5p9b
	JcplyarMI6LuwD7doRRRX4/msaTiJ9mq8cPJcu5PVZr4lygeFHXfrpiVxBpQgu6/R+qZknVZ
	2nJRaeNHg5uumRKzjm696r4cszPfqdqfNkPZXLPdKnMGkzr8Cb5yZXDk9x3mz9bWm53LjHHJ
	/fPvSCc8hZ7RpLzurC07Z71UFjTlWDa602t/vhcfm6r+tXPbHL2rZNCb+SzDkLQkbfuPx9sW
	SiY2LDItYhOXmrCC1KtVK5WETq/6Ajv6e5lNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUyMcRzA/X7Pa4+OZ6fm8W63GcvkZeI7Gf1hPGNizJgxPePhbip2RznG
	okNdLmpLSuiFq11XlyvvrqV2KXkphbSTiiFSLa6cOy9X5p/vPvt+P/v89WUJZQ41kdXEHpC1
	sVK0iuZILjI8cc4tb5k8r26Ag7Qz88D9PYmEHJuVhsbSYgTWiuMYup2r4NVgDwLvk2cEZGY0
	IsjrfENARW07AkfRCRqa34+BFncfDfUZKTQkFthoaPriw+A6n46h2L4WGs7lY6jyfCQhs5uG
	i5mJ2D8+YfCYLQyYE2ZAV1E2A77O+VDf/pKCmkv1FDjaZkPWZRcN9x31JNTe7sLQfDeHhnbr
	HwoaautIaEwzUVDSm0/Dl0EzAWZ3HwPPq3IxlBn8tVPfflPw0FSF4dTV6xhaXt9DUJnUgcFu
	fUlDjbsHQ7k9g4CfhU4EXalfGTh5xsPAxeOpCFJOnifh2a+HFBhcYeD9kUNHhIs1PX2EaCiP
	Fx2DuaT4KF8Q72S/YURDZRsj5toPiuVFIWLB/W4s5g24KdFuSaZF+0A6Ixq/tmCx9+lTRqy7
	4CXF9y2ZeP3krdzSXXK0Jk7Wzl0WxakfJ9rQ/lTmUL/LhBNQJ2VEAazALxTeDdwghpnmZwqt
	rZ4RDuKnC+WmD36HYwn+9GihqP8JbUQsO47fJAx5QoYdkp8hfBjKIodZwS8SfvouMf+a04Ti
	sqqRToB/X5LVNuIo+TChw3KWOYe4XDTKgoI0sXExkiY6LFS3V62P1RwK3bkvxo78P2M+6ku7
	jb43r6pGPItUgYoIi01WUlKcTh9TjQSWUAUpWieUykrFLkl/WNbu26E9GC3rqtEkllSNV6ze
	LEcp+T3SAXmvLO+Xtf+vmA2YmICcHflT2/vzSusWOHxJ8ZW9Vo0+eEXkixIwLj+WfGT9NdPN
	wikfietqi5p7UBgpeTca1J2h4VuTUUTK88B1Y7dJcVxD3prAWWN2f9Z5fhd03HMkbTCmpx7O
	2tMU/DY7Unkl+NsWve3T0Fnf0CLL3MUPrPHbXYuXLHBuHuectGRa00oVqVNL80MIrU76C1s9
	GEgvAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to hashed-waitqueue wait, assuming an input 'ret' in
___wait_var_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index fe89282c3e96..3ef450d9a7c5 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -247,7 +247,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
-- 
2.17.1


