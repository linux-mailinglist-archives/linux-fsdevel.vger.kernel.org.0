Return-Path: <linux-fsdevel+bounces-49383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4894ABB99E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127687A0441
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45EB28983E;
	Mon, 19 May 2025 09:19:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E1283FE2;
	Mon, 19 May 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646350; cv=none; b=fAdIGfATeOvniTfOlcnqd45UO25wlXivXoR++aDCdgKyqV8xNc0FnSJVBJTW/eF4nLsqhsxE4jYbnGMCUQtIuodatYZZHg2CqmCqCAYFy1O2f6HP47VhSv02/SpZ8RFGpYqCO7zG2RLxjgPqKCxdQYeuEvgBzsP3fnGDY7NuUoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646350; c=relaxed/simple;
	bh=Kn0pCpXycQGzli+Ttb42Y8sONcxizenmqlKSwqT8CyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YQVBEYzKp8LqHn0sKp7LWY7gYIFqutW+dsSXhBi3fEjas/6P+rS1C9RAA/t52pfK3d+KeqP7X3NM3aXWTRcAbR/fgVOy0OLs58rVl8rmtGllUo8KBA4YOOiDEyPo7Kp1hS/3097N12wYcEK/NI6LZbEOvO+P1iZhQ4dl95QPJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-63-682af77127a4
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
Subject: [PATCH v16 42/42] dept: call dept_hardirqs_off() in local_irq_*() regardless of irq state
Date: Mon, 19 May 2025 18:18:26 +0900
Message-Id: <20250519091826.19752-43-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0wTaRTH/b6Zzkwr1bG67iyQaEqIiiuK0fVEXWNi1HnxkgCJSoLWZbJt
	BNRWUVZNQJBFsIgYqIBgKVorFMWWB29VFgTFC1ZlEQhWwA3YcGmstNqCu9t6eTn55X/O+Z2X
	wxCyB6JQRpV6QFCnKpLllISUjIZULdr/MUq5xOdfAZ7xXBLOXzNTYL9ai8DckInB2bIRXnlH
	EEw8fUaArtiOoKr/NQENrQ4ENtNxCl7+Mw06PC4K2orzKciqvkbB8+FJDL0lRRhqLZvgjXGQ
	hMeFBgw6JwXluiwcKO8w+Iw1NBgzImHAVEbDZH8MtDk6RWDrWQillb0U3LG1kdB6YwDDy1vn
	KXCY/xPB49aHJHgLwsB+RiuCujEDBcNeIwFGj4uGF416DK362VCfHRDmfPhXBA+0jRhyLl7H
	0NF9G8Hd3D4MFnMnBc2eEQxWSzEB/sstCAYKRmk4ccpHQ3lmAYL8EyUkZPcuh4lPgcsV4zGQ
	eaGehLrPnWjtr7y50oz45hEXwWdbD/F+z98Ub/PqSf6RgeNvlr2m+ey7PTSvtxzkraYovvqO
	E/NVbo+It9ScpHiLu4jm80Y7MD/W3k5vDd8hWZ0kJKvSBPXiNbskyhKTidyXOf3wk3N+IgON
	Ts1DYoZjl3E2w1vyO/eNnRYFmWLncV1dPiLIs9i5nFU7GMglDMF2TuVeVXSjPMQwM9nd3MjH
	kOAMyUZyxWeHcZCl7C9cnc6JvzrncLX1jV884kDek9+Mgixjl3MdtZVk0Mmx1WLu+FD7t4Wf
	uL9MXWQhkurRlBokU6WmpShUycuilempqsPRv+1NsaDAexmPTSbcQG57bBNiGSQPkdbbFihl
	IkWaJj2lCXEMIZ8lrbHOV8qkSYr0PwT13p3qg8mCpgmFMaT8R+lS76EkGfu74oCwRxD2Cerv
	XcyIQzMQCk0wZ5g+RazbEL8ozB1R5vJuW53f122vII64Lzkd85aEDzY44iY8fzpaok9eiU6c
	ErdfdyVn08Ltimloj2HleP9Qaaxjy9HNjUU+bXjDinjXQ5P+3tz1mzXhC3Z5435IvL9FW5gr
	fxt7Nt5/b+YbSdbQ+xmrLtE/f4bCCHF7ORMpJzVKRUwUodYo/geZXTjvWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxSH977flUr1W0f0i8zgmhARohOyuuNlTJMlviPRuEgwMfFS9Iv9
	YkFplcniBUZ1CMLQpSAorKKplRZlrZtaqSEQwKoTFKyKgEIWlbSURCkO7C6ty/45efL7nTzn
	n8NTqovMXF7O3SsZcrV6NaugFetWFC/Ke5usW/K07WMITZTQcOayg4WeS3YEjitFGEY71sCj
	yQCCd793U1Bt7kFwdniQgiudQwg8tu9Z6P1jJvSFxlnwmstYKD53mYX7/jCGgaqTGOzOtfDM
	+oKGO5UNGKpHWThdXYwj4xWGKWsjB9bCRBix1XIQHk4F75CPgfY6LwOe/hSoqR9gocXjpaHz
	2giGXvcZFoYc/zBwp/MWDZMV8dBzopyBpmADC/5JKwXW0DgHD1otGDots6HZFLEeffM3A13l
	rRiOnv8FQ9+TGwhuljzH4HT4WGgPBTC4nGYKpi90IBipGOPgyPEpDk4XVSAoO1JFg2lAA+/+
	jFyum0iFop+baWj6y4dWpRNHvQOR9sA4RUyub8l06CFLPJMWmtxuEMn12kGOmG72c8Ti3Edc
	tmRyrmUUk7OvQwxxNh5jifP1SY6UjvVhErx3j1s/b5Ni5Q5JL+dLhk/Ttyl0VTYbvado1v67
	p6apQjQ2oxTF8KLwmfg8+CMTZVZYID5+PEVFOU6YL7rKX0RyBU8Jvhnio7onqBTx/EdCthh4
	GxvdoYVE0fyTH0dZKSwVm6pH8X/OBNHe3PreExPJ+8vaUZRVgkbss9fTlUhhQR80ojg5Nz9H
	K+s1i427dAW58v7F23fnOFHkgawHwyeuoYneNW1I4JE6VtnsWahTMdp8Y0FOGxJ5Sh2nbHQl
	6VTKHdqC7yTD7q2GfXrJ2IbieVo9R5mxUdqmEnZq90q7JGmPZPi/xXzM3ELkMGd0pSVmvjke
	JgFfxup4r7nQLidkqot/SNfZ85b7tZVfsocr3N1Z5o5u/EnivJSFL7eslE3fpCjkQ5qu0tjP
	Sw6Xx141rqvxa1Zl/5ow/Nug3j2z9sHBvGx3zX2rvCAtb8j2dVowM3wg6YvNWV+1XOpyBq3T
	hxwvD3y4gVnGuNW0UadNTaYMRu2/Yfj0JDwDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

For dept to function properly, dept_task()->hardirqs_enabled must be set
correctly.  If it fails to set this value to false, for example, dept
may mistakenly think irq is still enabled even when it's not.

Do dept_hardirqs_off() regardless of irq state not to miss any
unexpected cases by any chance e.g. changes of the state by asm code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/irqflags.h | 14 ++++++++++++++
 kernel/dependency/dept.c |  1 +
 2 files changed, 15 insertions(+)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index d8b9cf093f83..586f5bad4da7 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -214,6 +214,13 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_disable();		\
 		if (!was_disabled)			\
 			trace_hardirqs_off();		\
+		/*					\
+		 * Just in case that C code has missed	\
+		 * trace_hardirqs_off() at the first	\
+		 * place e.g. disabling irq at asm code.\
+		 */					\
+		else					\
+			dept_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_save(flags)				\
@@ -221,6 +228,13 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_save(flags);		\
 		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_off();		\
+		/*					\
+		 * Just in case that C code has missed	\
+		 * trace_hardirqs_off() at the first	\
+		 * place e.g. disabling irq at asm code.\
+		 */					\
+		else					\
+			dept_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_restore(flags)			\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index a08d0e16978b..4ca1cc04293c 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2248,6 +2248,7 @@ void noinstr dept_hardirqs_off(void)
 	 */
 	dept_task()->hardirqs_enabled = false;
 }
+EXPORT_SYMBOL_GPL(dept_hardirqs_off);
 
 void noinstr dept_update_cxt(void)
 {
-- 
2.17.1


