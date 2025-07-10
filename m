Return-Path: <linux-fsdevel+bounces-54491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7FCB00221
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 14:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171775C278D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343222566FC;
	Thu, 10 Jul 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="V5815LAH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C0223DF1;
	Thu, 10 Jul 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150965; cv=none; b=Dg3dM4iZOqqR0VoUKpU8HREstceJ64Kk9oS3rueseTEkHOy2F7m5bw+0HVvI25LIUBHj3ToY4/FpoHO9LzMvU+E8mb47mZ6KudUhdNe13q8lXgbmn5STsW4TuiszFn6t1Inw7HF6wXuVhGlKdAyGRsqhFgL1RzkPwc3BXOorIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150965; c=relaxed/simple;
	bh=RlDznsmnAeYJXA6vYnadPPJMeICEpomZbm5EaGSrE4Q=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=or5Xs8HKHzD0/3GEOHb3KTyVhPomXfqbpDi/dGMRD2uoFNJ0cA9dUJFRC+eUN8JiNrarmDpm8iVA1MV5NwSOGOroo98TorZ33nBs0SZAejxznJKHRqOGQeGRFlgcUQIFPFKOIr2FWqrMbAqvq0PsndyFXlLKDmE0D1h//z8ikTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=V5815LAH; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1752150963; x=1783686963;
  h=from:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eHk9yP7lBXu9adZ2ir5aZJJ1OXqvEejhLpZ90zVWF34=;
  b=V5815LAHOKuaApnMV8vIq8K17pLv7TCPHKXQslc0J+o7a3j5JCAhP5oP
   LxGuFZ0m8rfTUdzZOVRj2+/TU8/k3LjvOH4pE8msfPPs4D31+r7cNzr1U
   z/5Zky0MLBskbM2vKCOpd4w7lChW7ZaToC9WT+YIB11lRv2l1m5Co+9WP
   NrGLwD1XWj1s8+1t1M4a6bOiW5GOYvFnGxxZyB9uEyA6Z5zkVmMxzdQ0w
   Ae6ZEcQpSJLojjwwjbKb4i4r1TdoY24ccTXFNIKA8BlJuEFxKdVhnfEJw
   GfB1nLHz3R63VA5NxWZ8gAvyz9vnPNbRKWiqU32sj/EVeUdaAlYPGv7xW
   w==;
X-IronPort-AV: E=Sophos;i="6.16,300,1744070400"; 
   d="scan'208";a="537432544"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 12:35:46 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:8628]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.180:2525] with esmtp (Farcaster)
 id f707ad75-fcab-456a-a336-ed9fa25163e1; Thu, 10 Jul 2025 12:35:44 +0000 (UTC)
X-Farcaster-Flow-ID: f707ad75-fcab-456a-a336-ed9fa25163e1
Received: from EX19D008EUC002.ant.amazon.com (10.252.51.146) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Jul 2025 12:35:43 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC002.ant.amazon.com (10.252.51.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Jul 2025 12:35:43 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Thu, 10 Jul 2025 12:35:43 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Harshit Mogalapalli
	<harshit.m.mogalapalli@oracle.com>, Oleg Nesterov <oleg@redhat.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Andrew Morton
	<akpm@linux-foundation.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, "Sauerwein,
 David" <dssauerw@amazon.de>, Sasha Levin <sashal@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [RESEND PATCH 5.10] fs/proc: do_task_stat: use __for_each_thread()
Thread-Topic: [RESEND PATCH 5.10] fs/proc: do_task_stat: use
 __for_each_thread()
Thread-Index: AQHb8ZcntzXxOD03lUCK2AakuHm5cw==
Date: Thu, 10 Jul 2025 12:35:43 +0000
Message-ID: <20250710-dyne-quaff-a6577749@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 7904e53ed5a20fc678c01d5d1b07ec486425bb6a ]

do/while_each_thread should be avoided when possible.

Link: https://lkml.kernel.org/r/20230909164501.GA11581@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 7601df8031fd ("fs/proc: do_task_stat: use sig->stats_lock to=
 gather the threads/children stats")
Cc: stable@vger.kernel.org
[mheyne: adjusted context]
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---

Compile-tested only.
We're seeing soft lock-ups with 5.10.237 because of the backport of
commit 4fe85bdaabd6 ("fs/proc: do_task_stat: use sig->stats_lock to
gather the threads/children stats").

---
 fs/proc/array.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 8fba6d39e776..77b94c04e4af 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -512,18 +512,18 @@ static int do_task_stat(struct seq_file *m, struct pi=
d_namespace *ns,
 		cgtime =3D sig->cgtime;
 =

 		if (whole) {
-			struct task_struct *t =3D task;
+			struct task_struct *t;
 =

 			min_flt =3D sig->min_flt;
 			maj_flt =3D sig->maj_flt;
 			gtime =3D sig->gtime;
 =

 			rcu_read_lock();
-			do {
+			__for_each_thread(sig, t) {
 				min_flt +=3D t->min_flt;
 				maj_flt +=3D t->maj_flt;
 				gtime +=3D task_gtime(t);
-			} while_each_thread(task, t);
+			}
 			rcu_read_unlock();
 =

 			thread_group_cputime_adjusted(task, &utime, &stime);
-- =

2.47.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


