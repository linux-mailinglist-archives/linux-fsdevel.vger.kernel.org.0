Return-Path: <linux-fsdevel+bounces-50744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F36ACF187
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 16:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A3716C0B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E22749C5;
	Thu,  5 Jun 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="gIBhKuMK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B922577E;
	Thu,  5 Jun 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132486; cv=none; b=JGGwuVyF2IY6eHSDCeWooEIJvVVqTdIlysioh2nb/L5PPKGqyxjKB6rRMhgKh7HZH3Ajcld51YeVNAdBadUVBoG1UJfPofr2rrURuu4YoHJhXTkMmo6ETcUaW9QpzrZ/QbmYXzqqxVHWupbQ8PooPXW1FskEvgVEC2SiztiRRk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132486; c=relaxed/simple;
	bh=SqrOYqITYMZZI/kmahCoVH9ae4tviOrktLCl3ctYGiA=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AWfXHC8/SzYGPYRPaDvH0JA+fdPfxYylzfw7ry/1TotNizFLkYerwipwd+8ZOyD+oA5m+9h62OOl2SSIXxDNTeTuv0pEqgEHZYo5E9LzZ2IZB6BJCu8K1ysCM2dXAdSb7pVkFevInxPh2gQHxVUUrPA1XRaN+WJaDdmhx5/eIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=gIBhKuMK; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1749132484; x=1780668484;
  h=from:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8THBWnQFHzJpQ1tlQVK78roTQ3W4ljKZbg41waP5QXw=;
  b=gIBhKuMKItaowFFpwumdr3gDThIQQYg+6736YC8B1hMXYif88dvei2N5
   dhu6XgmMQEE6kFou8tQodg/aqI5UQt06Ym9H/o9q6vFtoillBJWm1pm5H
   gdeqN1bvKbVbmirbsqVaTlj6YCM21+38QRk4RTjY9Jcp0TspkT+prGz7Y
   Ld+SxHEV8/BJJn60r7+46tiJ7UaOb5mbV2OZXoIAcKSl8Ej3LPOOF/bwk
   9zSKGPcdU5l7f9ZnuttzyrjR3MBhiyWqi0Br4l5agx6vQi1/1cWFY1Qn4
   SifhHA8AM0/jTcPjRfUqM3GgpYNVzA5R7IfLu7KYcEW8XMrTvSZGkdFRu
   A==;
X-IronPort-AV: E=Sophos;i="6.16,212,1744070400"; 
   d="scan'208";a="27580598"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 14:07:50 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:57714]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.98:2525] with esmtp (Farcaster)
 id 139dc641-52d8-49fc-bba2-474b9b992fcf; Thu, 5 Jun 2025 14:07:48 +0000 (UTC)
X-Farcaster-Flow-ID: 139dc641-52d8-49fc-bba2-474b9b992fcf
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 5 Jun 2025 14:07:48 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC001.ant.amazon.com (10.252.51.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 5 Jun 2025 14:07:47 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Thu, 5 Jun 2025 14:07:47 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Sauerwein, David" <dssauerw@amazon.de>, "Sasha
 Levin" <sashal@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: [PATCH 5.15] fs/proc: do_task_stat: use __for_each_thread()
Thread-Topic: [PATCH 5.15] fs/proc: do_task_stat: use __for_each_thread()
Thread-Index: AQHb1iM3JifjNSmvsUCnvULPq6BiSw==
Date: Thu, 5 Jun 2025 14:07:47 +0000
Message-ID: <20250605-monty-tee-7cec3e1e@mheyne-amazon>
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
gather the threads/children stats"). I'm assuming this is broken on 5.15
too.

---
 fs/proc/array.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2cb01aaa67187..2ff568dc58387 100644
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


