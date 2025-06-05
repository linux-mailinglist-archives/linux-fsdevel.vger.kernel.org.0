Return-Path: <linux-fsdevel+bounces-50742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB1ACF137
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877983ABB19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D448272E67;
	Thu,  5 Jun 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="QhH4sLSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A6225405;
	Thu,  5 Jun 2025 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131291; cv=none; b=ggS/Df+vN4tIvKxNtlKsVDXz7ulu1M3N4nvYFbxhaEXEwB3GECwDNJ2K9c+oEwJh1snnPUwudco55YMCm7+BKk0hg3cPoaBCIS36DCRbn3qDCvkxfMNVZAwfGod0XHmBSFvXkegG8tdWEupiCFkhjJuoKx7NqtzzdbetK9LBlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131291; c=relaxed/simple;
	bh=UBcvPdguHV4fsFDepdmLyKP32n6yzbqE/cbwdYXIwE4=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EstPuNjOfeB2j8pGXtcmtKxJr6kyT9Gl1bH1jQUL+tf2mxvpqHIvWUZtsgYLoCsoWnpKTgPIghbN/lDfmIZUMMfscsrvDFWYT9qTnDg60vIy2tE8vYRUAMr2b0qAQ3xdmzp8Y2gqilZHQzUrPMdCSOK3bMqP3PQgOj3uGl7OIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=QhH4sLSb; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1749131289; x=1780667289;
  h=from:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IUSfxUyqmgfivEu5EZMCkF/RyBzwPvDiznC0GbBHiKk=;
  b=QhH4sLSbNIs+MgcWX0HFMM/Obwd5DKxaL0uAdhe/tPJmuAnmKKu4qlK2
   Trp1LoYXgRAougtg+YFmE7ZTx1/3k0x/oTa/B36W94pUZuM5xf7jOrlf8
   a5RnOTKc01Us/XTI8lj4WKjD03MKbCl+PZZGA8lzaIPqDl/ZvVaGRxNaI
   xfxyINe6opduq0HSQAfh1U4W9XmMqxlx77CHHB4ezQm+SEye22MUtlzHW
   ce6ssIEHREqXzQ/AAM4Na2d038GomO2TCCGVpiPKKZKgI27xnHM4L1+8x
   57InNIUK9CamIpZ9XSsbXEHdMw2gNijPjEKRnl0dMyFGriJj3dyHkYMGF
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,212,1744070400"; 
   d="scan'208";a="101103021"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 13:48:06 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:40566]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.81:2525] with esmtp (Farcaster)
 id f8dc8fdf-8393-456d-8a76-62e5f1c245a7; Thu, 5 Jun 2025 13:48:04 +0000 (UTC)
X-Farcaster-Flow-ID: f8dc8fdf-8393-456d-8a76-62e5f1c245a7
Received: from EX19D008EUC003.ant.amazon.com (10.252.51.205) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 5 Jun 2025 13:48:03 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC003.ant.amazon.com (10.252.51.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 5 Jun 2025 13:48:03 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Thu, 5 Jun 2025 13:48:03 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton
	<akpm@linux-foundation.org>, Alexey Dobriyan <adobriyan@gmail.com>,
	"Sauerwein, David" <dssauerw@amazon.de>, Sasha Levin <sashal@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 5.10] fs/proc: do_task_stat: use __for_each_thread()
Thread-Topic: [PATCH 5.10] fs/proc: do_task_stat: use __for_each_thread()
Thread-Index: AQHb1iB1gJ8UYFGzREqCdxVMNVkwmA==
Date: Thu, 5 Jun 2025 13:48:03 +0000
Message-ID: <20250605-zulu-clomp-65defe17@mheyne-amazon>
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
index 8fba6d39e776f..77b94c04e4aff 100644
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


