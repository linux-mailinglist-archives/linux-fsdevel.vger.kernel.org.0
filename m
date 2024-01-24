Return-Path: <linux-fsdevel+bounces-8729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC86883A8DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE75B27B72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D4A6350D;
	Wed, 24 Jan 2024 12:00:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E6A6169C;
	Wed, 24 Jan 2024 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097606; cv=none; b=CWVE7mIovmw3THGVvNDLrCbICKsg/JkmR/hTpIj1q97AWSHcboqYyrJVrH13BC27O3jxZSwkPqHOi2xTFAcuiVwAPXFuqYXibX6+XgRpReehQGmObghEsKA1wGv+1JloY3YI+gqZXtNFWWcFxKgoWWlxdp3hkuPmgTegyzd9JW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097606; c=relaxed/simple;
	bh=RIc5udGVOneBYojEExyl4QYDrUVZJa4Vo+L4Ic7nXzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ay9TKuzDvAlGjHcCdOK0PkrsYPJrIzI2uTjMH3BSCNrJt3TMTBTxLeI+iMGCOmTZHzboT8bpDQcxbuIvzQoq6069UH4g5+TwtGo2fO78Mne8vZzaL72LviEzdOP7oKsfdGfbF5E3g0Jw6oaoYvOYbsyxMB75GUdf4D68mvzhdkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-d5-65b0fbb5c9e5
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
Subject: [PATCH v11 09/26] dept: Apply sdt_might_sleep_{start,end}() to waitqueue wait
Date: Wed, 24 Jan 2024 20:59:20 +0900
Message-Id: <20240124115938.80132-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/Pd5z9HOpHRrtpNs8PsQ/Lw9D6arMxmz/4g5t+000d7ipi
	LDrFXVG2RFp64Dp3x+UKSdcSRVEdFed2hdbQlNpxcS4PFf757L3X5/15/fXhSHkVPZ1TqRNE
	jVoZp2CklLR/QtGCO4EycXGeFUF2xmLwfT1NQb7NyoDzpgWBteIEAb31UfBqqA9BoLmVhNwc
	J4Kid50kVDR0IXCYTjLQ1jMR2n0DDDTmGBhILbEx8PzTMAGeC+cJsNg3w9OsYgJq/R8oyO1l
	4HJuKjEyPhLgN5pZMKaEQbcpj4Xhd0ugseslDQ73PLhU4GGg2tFIQUNlNwFtVfkMdFl/0/C0
	4QkFzuxMGm58Lmbg05CRBKNvgIUXtYUElOlGRGlfftHwOLOWgLSrtwhof30fQc3ptwTYrS8Z
	eOjrI6DcnkPCj9J6BN1n+1k4leFn4fKJswgMpy5Q0PrzMQ06z3IIfM9n1q3CD/sGSKwrP4Qd
	Q4UUbioW8L28ThbratwsLrQn4nLTXFxS3UvgIq+PxnbzGQbbvedZrO9vJ/DnlhYWP7kYoHBP
	ey6xJWSHNCJGjFMliZpFa3ZLY5u+9dIHrksOD2alMymolNUjCSfw4cLzQQv6n29fuzvGGX6O
	4HL5ydE8hQ8VyjPf03ok5Ug+fbxgGmxm9IjjJvPbBVv/kdEOxYcJFb+LxvoyfoXQ05zyzzlL
	sJTVjnHJCL9xyU2NZjm/XHhrPseOOgU+VSIEvDX034NpwgOTi8pCskI0zozkKnVSvFIVF74w
	NlmtOrxwz/54Oxr5KOOx4Z2VyOvcVod4DikmyNaZbaKcViZpk+PrkMCRiiky17SbolwWo0w+
	Imr279IkxonaOhTCUYpg2dKhQzFyfq8yQdwnigdEzf8twUmmp6Bl3jubGx0J0VEa94OI4HjD
	lu2bBFlJYuSMyTgjP+LKpqCgZ3U7PEm6lYbW7h/Q4WZnZFZpU6nOqdkhEQdnzo+snr3WmVdg
	7kgzHvcssBi2aiKPbWhZ7QpVKydFha98ZDtaX7nCmhYarQsKLkisKNP9anI2bfRfT08o0K+n
	HmW9UVDaWOWSuaRGq/wDP4BQpk0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzH+/6e7zh+TubnYbTbqi0cNvHZMuMv3zWZvzz+oaMf3aord4na
	ylFcIu6anIfYVVznSl1XrcJR14qrpeiWtEStIUoNFz14qMw/7732fr/3/uvNkfI8eimn1iSK
	Wo0qVsFIKenOsPQ1VZMOcV3RmWAwXVwHvu+ZFOSVlTDQXlqMoKTyNAGDjdvh1dgQgsnWNhLM
	ue0I8vvekFDZ1IvAZTvDQMfAPPD6Rhjw5F5gIL2wjIEXn6cI6LmaQ0CxMwJajAUE1I1/oMA8
	yMBNczoxLR8JGLfaWbDqA6HfdoOFqb714OntpKHhlocGV/cquH67h4FHLg8FTTX9BHQ8yGOg
	t+QPDS1NzyhoN2XTcP9LAQOfx6wkWH0jLLyssxDgyJheO/ftNw1Ps+sIOHennADv64cIHme+
	I8BZ0slAg2+IgApnLgkTRY0I+i8Ns3D24jgLN09fQnDh7FUK2n49pSGjJxQmf+YxW8Nww9AI
	iTMqTmDXmIXCzQUCrr3xhsUZj7tZbHEexxW2EFz4aJDA+V99NHbazzPY+TWHxVnDXgJ/ef6c
	xc+uTVJ4wGsmdi3fL90cJcaqk0Tt2i2R0ujmH4N0wj3JyVGjgdGjIjYLSTiB3yBU3a2eZYYP
	Frq6xskZ9ucDhIrs93QWknIkb5gj2EZbmSzEcQv53ULZcMpMh+IDhco/+bN9Gb9RGGjVo3+b
	K4ViR92sL5n271/vpmZYzocK7+yXWSOSWpCfHfmrNUlxKnVsqFIXE52sUZ9UHo6Pc6Lpz1hT
	p0w16HvHdjfiOaSYK9tqLxPltCpJlxznRgJHKvxlXUtKRbksSpWcImrjD2qPx4o6N1rGUYrF
	svA9YqScP6pKFGNEMUHU/k8JTrJUj+IXWtIKjR7HsN/UarOpyb1v0amAzreZQfV7t3ziEkrD
	fxmC9POueHGva9sOidJYU2+N6I8IOLCgRag/5ppQSqgnfocu15bbX6fq0245gpXNt53UNzHu
	yO98X1uYzXWiOTpnLHK3JtySeM+0YiIoYP4m/5cG2adQg2du40C1u1tB6aJV60NIrU71F0/v
	DPAvAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes Dept able to track dependencies by waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3473b663176f..ebeb4678859f 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -7,6 +7,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/dept_sdt.h>
 
 #include <asm/current.h>
 #include <uapi/linux/wait.h>
@@ -303,6 +304,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
+	sdt_might_sleep_start(NULL);						\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
@@ -318,6 +320,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 		cmd;								\
 	}									\
 	finish_wait(&wq_head, &__wq_entry);					\
+	sdt_might_sleep_end();							\
 __out:	__ret;									\
 })
 
-- 
2.17.1


