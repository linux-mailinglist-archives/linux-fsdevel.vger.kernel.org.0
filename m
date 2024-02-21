Return-Path: <linux-fsdevel+bounces-12243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF585D4BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB4328C4C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6815537FE;
	Wed, 21 Feb 2024 09:50:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C64CB35;
	Wed, 21 Feb 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509007; cv=none; b=FO5ofJiCCEMLMgUPV5k85QBiSJIx/z7pJG8cylceD4biEWz80exXPXttt3kzAUV/uOMB6+boVnMKz7Zlx9vUTMzhnOJbYzP5GV1HLNDbBuMO03TRxUG8fQp1LTW0DzufEMEyYm6wwosAUvHb+YFp2LqVSZsvJB++aBt4icZ9nLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509007; c=relaxed/simple;
	bh=RHlJ2GxVpEp+l17KtAmYPgKdeN+t8Sb6ly9lphI8Ui8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZhxWJ0v+XKYvXI4MI6UTz20A2fwGY476ktEpzTvONj9ToTXsbC7B51wMcZ/MYSs0Wczw80bTD1pqczlpUo+XcQctQPFJf9sN/bZk/NDVi05xKbe8VwtpheqhpSSfQNLhAHX33M7UMjer1cQxUjvF5OPzqMCAJRkso4NF019sf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-b8-65d5c73a0bd5
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
Subject: [PATCH v12 19/27] dept: Apply timeout consideration to waitqueue wait
Date: Wed, 21 Feb 2024 18:49:25 +0900
Message-Id: <20240221094933.36348-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRjAfb+/105nv87bz9mwM2OMYtjjdf5gvmaM+S+Mo9909MJdSjZz
	dEd6ISwnJV3aOXV6uWreql01decm4aJaHZKXVCIuUl6uzD/PPvs8ez5/PTyluMcoeU1UjKSN
	UkeoWBkt6w00z19R3ySFfMzAcD4lBHzfEmnIKrKx0FhYgMBWdgJD14P18GKgB8HQo8cUmNIb
	EZhft1NQVudFUGk9ycKzznHg8fWx4EpPZiHhehELT7qHMbRduoChwL4J3Gm5GByD72kwdbGQ
	aUrA/vEBw6AlnwOLfhZ0WK9wMPx6Ibi8zxmobJ0HGdltLFRUumiou9OB4dm9LBa8tj8MuOuc
	NDSeT2Xg1qdcFroHLBRYfH0cPHXkYCg2+EOnvv5moD7VgeFUXgkGT8t9BFWJrzDYbc9ZqPX1
	YCi1p1Pw88YDBB1nezkwpgxykHniLIJk4yUaHv+qZ8DQtgSGfmSxa5aT2p4+ihhK40jlQA5N
	HuaK5O6Vdo4Yqlo5kmM/TEqtc8n1ii5MzP0+htjzz7DE3n+BI0m9Hkw+NTRwxHl5iCadHhPe
	MjVUtjJMitDEStrg1btl4eYqJ3WwnDuSd7oV6ZGBTUIBvCgsFr9/cDP/+c3Lr6PMCrPF5uZB
	aoQnCDPE0tR3fi/jKeH0WNH6+dHo8Xhhs1j0tsnPPE8Ls0TTr3UjWi4sFZ0lD/G/5nSxoNgx
	2gnw+5uZPaN9hbBEbHpSTo00ReEPL+oTTNy/gylitbWZTkPyHDQmHyk0UbGRak3E4gXh8VGa
	Iwv2Rkfakf+jLMeGt99B/Y3bapDAI1WgPPy2R1Iw6lhdfGQNEnlKNUFOx/mVPEwdf1TSRu/S
	Ho6QdDVoKk+rJssXDcSFKYR96hjpgCQdlLT/t5gPUOrRxbagc/vOjduwzKm0G6+JrGlZstvg
	ciw9s7Glu3pGWcs0a0Ogd8fmjkPzV5EDQ6GWq8PHja4afmf52pj3l7vbbzdcrVAmBs/J+hIy
	Z1XoosKUPVLVRFvmzLxJ3s/XXhiLW9JmrmjO2K/fGr2tZH1ieXZtsDKy06zrp6bHSZ3upKBq
	Fa0LVy+cS2l16r85r5L0TQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRjAfb+/147j54Sfd45mmGQ6e4ZZZtZ3GbMxr39w9KObrrhLydhK
	l7yUFXKptCvtnIrLHfNWLUUvTEV3oeUor01vSxfpvFyZf5599nn2fP56eEqRzUzmNRFRki5C
	Ha5kZbRs/fKEhcuqnVJAZ48fpCUHgLvvJA3Z1iIWGm4UIii6FY+h/XEwvOzvQDD4rJ4CY3oD
	gtzWNxTcqnIhKLUcZ6Hxw2hwuLtZqE0/w0LCFSsLz796MLRcPIeh0LYOnqbmYSgf+EyDsZ2F
	LGMC9o4vGAbMBRyY4/ygzZLJgad1MdS6mhiovFzLQGnzAriU08JCSWktDVV32zA03s9mwVX0
	h4GnVTU0NKSlMHC9K4+Fr/1mCszubg5elJswFBu8tRPffjNQnVKO4UT+TQyO1w8QlJ18h8FW
	1MRCpbsDg92WTsHPq48RtJ3t5CAxeYCDrPizCM4kXqSh/lc1A4YWFQz+yGaDlpPKjm6KGOwx
	pLTfRJMneSK5l/mGI4ayZo6YbIeI3TKfXClpxyS3180QW8Eplth6z3HkdKcDk666Oo7UZAzS
	5IPDiDdM3S5bESqFa6Il3aKVu2RhuWU11IHb3OH8pGYUhwzsaeTDi0Kg+P7tN2aIWWGu+OrV
	ADXEvsJM0Z7yyetlPCUkjRQtPc+GD8YJ60XrR6eXeZ4W/ETjrzVDWi4sFWtuPsH/mjPEwuLy
	4Y6P11/L6hjuKwSV6Hx+m0pFMhMaUYB8NRHRWrUmXOWv3x8WG6E57L8nUmtD3p8xH/Ok3UV9
	jcEVSOCRcpQ87I5DUjDqaH2stgKJPKX0ldMxXiUPVccekXSRO3WHwiV9BZrC08qJ8pAt0i6F
	sE8dJe2XpAOS7v8W8z6T49DakaqkS9bpx8gnY2Br0/cxVyf5BPeiqNWeRinulLVvdlCqfS6x
	sDNRck6MSwxKfbi1alNSzjut6cK8+xaVc5zHUbIDF1ouhPY8cu4OqR8/dolys7jpfODB4kTP
	tFWzJuyt25gZsmZb61StoivfZdhwOaDpht+UlqM//U1zrkXGZyhpfZh68XxKp1f/BSZcKxYv
	AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to waitqueue wait, assuming an input 'ret' in
___wait_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index ebeb4678859f..e5e3fb2981f4 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -304,7 +304,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
-	sdt_might_sleep_start(NULL);						\
+	sdt_might_sleep_start_timeout(NULL, __ret);				\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
-- 
2.17.1


