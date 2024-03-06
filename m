Return-Path: <linux-fsdevel+bounces-13717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E12F8731E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3AA1F21986
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F2664A7;
	Wed,  6 Mar 2024 08:55:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411B62A17;
	Wed,  6 Mar 2024 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715348; cv=none; b=r+gMe/vm0zuoYOHbQl9KgiynPpunWPQWiPWekvpHku7vLbCh/KiAyjM07lyF0VzkEgZea/ytJte5o5Ron0pYa+Y2JCvwTSwE2Th1q4SU+MZQPofFqOuMCWxv5wO41S3/kZb6KbgJ1CICnKvDQiUh9e3/cXOYY50zCLoq+MjyOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715348; c=relaxed/simple;
	bh=oVu1M/z+Be6zJoonqEicwRg8jn1j0IbzUk3u5AE/er0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fH9fASKNYv+lxHAmtKJaou/E7xXbGpoxTbzkDEA2oPLGDDMijgS3y7ianruMWnIulu5n12QXXmb9igflf76/47CG0Vgy0tq5WSuCuaI3REB4cVZm8iQyFovi1KTmxVO+F2+xjMIJ4Tk5yMuSwi8w5c6skp5klr5XX//gnfoHsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-69-65e82f7ebc4d
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
Subject: [PATCH v13 20/27] dept: Apply timeout consideration to hashed-waitqueue wait
Date: Wed,  6 Mar 2024 17:55:06 +0900
Message-Id: <20240306085513.41482-21-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2SeUiTcRjH+/3ec6PV2xR6M+hYRGF3dDxClFHUW1BIxx8lVCNfcqQmM68o
	UqcdHrNLV7pCp62hlrat25UZWrO05cQspqXZIc1p1kzTjmnUPw8fvs/3+fz1sITcSgWwqqiD
	ojpKGaGgpaS0e6xh3tEFn8SFmu8T4HTmQvB+O0GCvryMBse1UgRl1mQMXTXr4WW/G8FQ/XMC
	dDkOBIXtrQRYa9sQ2EwpNDg7x0GTt4cGe04GDZqichpefB7G4Mo9g6HUvAmenjJgqBr8SIKu
	i4Z8nQb7xicMg8YSBoxJM6HDlMfAcPsisLc1U2B7PQcuXHLRUGmzk1B7uwOD866ehray3xQ8
	rX1CguN0FgVXPQYaPvcbCTB6exhorCrAUJHqEx37+ouCx1lVGI4VX8fQ9Ooegvsn3mIwlzXT
	8MjrxmAx5xDw40oNgg5tNwNpmYMM5CdrEWSk5ZKQ6loKQwN6OjhIeOTuIYRUS7xg6y8ghToD
	L9zJa2WE1PuvGaHAHCtYTIFCUWUXFgr7vJRgLjlJC+a+M4yQ3t2EBU9DAyM8OT9ECp1NOhwS
	sFO6IkyMUMWJ6gUr90jDn2nKUbSWSeh1ZeEk1E6lIwnLc0t4Q/Od/1xa10uMMM3N4ltaBkfZ
	n5vGW7I+jHYIzi3lixvWjbAft53PSNOjdMSyJDeTH3o8ZSSWccv4uq9J+K9yKl9aUTWqkfjy
	bE82PcJybilfryn0sdTXyZbw+T8/EH8PJvEPTS3kKSQrQGNKkFwVFRepVEUsmR+eGKVKmL/3
	QKQZ+X7JeGQ49Dbqc2ytRhyLFGNlwZKPopxSxsUkRlYjniUU/rLDPzpFuSxMmXhIVB/YrY6N
	EGOq0WSWVEyULe6PD5Nz+5QHxf2iGC2q/20xKwlIQhtKFL155AbP/rPUKueX2Mp3zRdm33pR
	k9A4N3TX2pUbx8w43n419Nz53XFpHvP0gUi7ljeluHIz7TNayx07rCHPjix/ExQ8UdeqL7Ks
	sfm9z413RrfEr65/ZeskZVu03iC/8bEDdONOd7Jl847LKTem3zS8u8UVdznnLW/z32a9+EBB
	xoQrFwUS6hjlH/DytTJHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0wTWRiGPWdmzkybrY5dohMNaipo1Cjqin663mP0xFuMuqvRTbTKuHQt
	1bTKysYLbgsKCIKmVBENVFMJRdFCTL0UCRW0uCC7VERTiSARUC7eSkSILmD88+bJ+315fr0C
	o87kRgk6wz7ZaNDqNUTJKtf+bJ56OKJVnv7ONhcyTkyH4MfjLGQXFhCouepEUFB8FENb+Qp4
	0t2OoLfqEQM2aw2C3MbnDBRXNCDw5P1NoLZ5KPiDXQR81hQC5ouFBP5904chkHkKg9O1Bh6m
	2zGU9rSwYGsjcM5mxv3RiqHHkc+DIz4cmvKyeOhrnAG+hjoOvOd9HHieTYGzFwIE7nh8LFS4
	mzDU3som0FDwlYOHFQ9YqMlI5eBKp53Am24HA45gFw//leZguGbptyV++MLB/dRSDImXrmPw
	P72NoOT4CwyugjoC3mA7hiKXlYHPl8sRNKV18JBwooeHc0fTEKQkZLJgCURC76dssnge9bZ3
	MdRS9Cf1dOewtNIu0ZtZz3lqKXnG0xzXflqUN5levNOGae77IEdd+UmEut6f4mlyhx/Tzupq
	nj4408vSZr8Nrxu9RTk/StbrYmVjxMLtyuh/zIVobxp/4G0gFcejRi4ZKQRJnCU5K98yA0zE
	iVJ9fc8gh4jjpKLUV4M/jNiulC5VLx/gH8VfpJSEbJSMBIEVw6Xe+2MGapU4W6r8EI+/KcdK
	zmulgxpFf3+y8yQZYLUYKVWZc0k6UuagIfkoRGeIjdHq9JHTTLuj4wy6A9N27olxof61OA71
	ZbjRx9oVZUgUkOYH1WJFi6zmtLGmuJgyJAmMJkR18HOzrFZFaeP+ko17thn362VTGRotsJqR
	qpWb5O1q8XftPnm3LO+Vjd+vWFCMikdbzky9d8xTFTAtm1XSOvOP1g23siISwyxJ51/Pnnhh
	0t05bl/SzmHFx6La1phvOG/8dnUV2bhLT1PGj/daF6QpRiztOG1tKQ9df3pu88w6mzqM3VFv
	DxUMw8M1P2UsWbI6/Uj1Uu8j97bHX1/u4BaNsLt/HRcaXD7SX7f19QRb2ObYObs0rClaO2My
	YzRp/wfZerU2KQMAAA==
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


