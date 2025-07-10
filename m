Return-Path: <linux-fsdevel+bounces-54492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E83B0023E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 14:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CB77AA0E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869F6268C55;
	Thu, 10 Jul 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="scdYbRe1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCB255F22;
	Thu, 10 Jul 2025 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151403; cv=none; b=XSkSnmsQrf0idz9IVQedSqYqktODNg86hrxCAASqlXuTr/+bw7y1/0uNm+3bVGrGqof6EkmWpQ9EySKZcK7SyGBQwJBgnoycWhlx3oCMYNnL3DPVqr7/kVhKG54ujBfg7plahQLXwFj+FktvrcdaTatGFPxoL1855TqReBIAsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151403; c=relaxed/simple;
	bh=YAlRdTBtbltqIObG/wS2N/TUks/eUA85AP5/ETkC2Ao=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fasMCNOBGAH/xkLhwdL4CHMXdWmS3HUMlzAWGFUKqrYt4y4wBJ8OcP7yPv+CXPED9H2SUiZ2VCHV4jF1Ux8hvxzco5iqte3tgntIpTP27axyZpAXuCYyJlcUZk/SQIZS+Eq4/BBjYKlcXi4KVhyhMUcZ7/eFtmllwezmeW2BdFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=scdYbRe1; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1752151402; x=1783687402;
  h=from:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TcL90y9yyUrQNV6wzTUzXovTLknFtEhr31RpPeHLwCo=;
  b=scdYbRe1DBGGqZtpyHWStknKdtLzrB89Epdct++CuC3XyAJg3E+Dgtuq
   mb19Nz9JwGm3scKMZbw1oTf8zbZafwNnCmKeigg2oP8cKtEVwk/kai5En
   GUarli8zwiXurTbOkUzDR0/pDLAftgky8ZY0VqXT0CKBBoQQg+/WOpMLw
   gXa1t72FEdVr0yL8LdnhEmFDLKypu2g2kLUh5Rla3a8AlAUL54p8iNVG5
   oVGlo0swdXG6+ZfS1GePuTdPyC3S0xXcKdQ8S9Jf7zWq7YhP7q5Lm+m3T
   hJC/o4v3thyypFw9ZoUyvTNKFrdskx4N53WLIfzdGYJY3lYvRWDoSDZPV
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,300,1744070400"; 
   d="scan'208";a="213811787"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 12:43:19 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:33526]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.180:2525] with esmtp (Farcaster)
 id 8ccd098b-9821-4a92-b3a0-d3d116f3a7ae; Thu, 10 Jul 2025 12:43:18 +0000 (UTC)
X-Farcaster-Flow-ID: 8ccd098b-9821-4a92-b3a0-d3d116f3a7ae
Received: from EX19D008EUC002.ant.amazon.com (10.252.51.146) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Jul 2025 12:43:18 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC002.ant.amazon.com (10.252.51.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Jul 2025 12:43:18 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Thu, 10 Jul 2025 12:43:18 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Harshit Mogalapalli
	<harshit.m.mogalapalli@oracle.com>, Oleg Nesterov <oleg@redhat.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Andrew Morton
	<akpm@linux-foundation.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Sauerwein, David" <dssauerw@amazon.de>, "Sasha
 Levin" <sashal@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: [RESEND PATCH 5.15] fs/proc: do_task_stat: use __for_each_thread()
Thread-Topic: [RESEND PATCH 5.15] fs/proc: do_task_stat: use
 __for_each_thread()
Thread-Index: AQHb8Zg2fZamDUZRE0iXs8i1qPy6QA==
Date: Thu, 10 Jul 2025 12:43:18 +0000
Message-ID: <20250710-yams-adolf-9eb7e4b2@mheyne-amazon>
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
gather the threads/children stats"). I'm assuming this is broken on 5.15
too.

---
 fs/proc/array.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2cb01aaa6718..2ff568dc5838 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -530,18 +530,18 @@ static int do_task_stat(struct seq_file *m, struct pi=
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
 		}
 	} while (need_seqretry(&sig->stats_lock, seq));
-- =

2.47.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


