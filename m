Return-Path: <linux-fsdevel+bounces-61825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FC7B5A1CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 22:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A56F1BC6992
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1670A2E173B;
	Tue, 16 Sep 2025 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kYRYZKEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56C27AC37
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053130; cv=none; b=EefGQaKnXtccNS6xdwxAi41/5pOO45k9hldKt5DrXN8Z+o7p72FoUHR4E1yr3qZSCSHzze2bYY0ICiSyBXk/ShCsBagEwKZ62mh3D5Klu46aneckTmoFpn9CRdyoiApzN91hlVsjDW3F1NwZY8PCWzCZkR0bkpAbCmhqw+a1QYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053130; c=relaxed/simple;
	bh=vnrE+dyl2rRA5eCeOVgPqXiQqDXSo5McHniq6JuTE/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj/Q/c9EQKH4KLgk2wfNsz977USURcVfe2rcwk4locSop73bf0zjnMwADcKhcHzMBAn3MF71ooFtbsPU4zsKp9p+RfkXtUKpD34VDTnhsH+1ppP38puR18A/8E4BqLwSOGZtDZBikmaXYFzS8rro3ovydMKMiLXzdD9RKtEP0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kYRYZKEw; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 58GHqm5Z1902738
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 13:05:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Mgv3SwgS0ByeocJhd6u/6Ox324l7E+OKhpc3GP5WOVQ=; b=kYRYZKEwT4HS
	NI6wh3gLIzJ9lkkRNhKBpS85NtlXzayZeIlyGis75vourUzy5ifF7+RizBV+BiIC
	TFHNMnBdPmYnPPz6boje2SkqAMGXCc52U9Xp+BD+h0KB124EKZz5BPtBNIKOHxtO
	0AdGztM1BqESxZAhOiO+22I7jCFgw6HqWofi2r78XTb46STAvoyOxyMuAYtzGrab
	PlSJfvbVKm7No98nn2GD9GIMb/+/ZRhId33sbvnf+w71cWaVU7GfsZo57moaAvTN
	yGgQDR8GV1Bn1ay9PBcKm7J2dwUeWO+e6rwEFD6Ixq3a6bWzrJaCJhaBucnZiSBV
	k5MHK6yr8w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 497avej73u-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 13:05:27 -0700 (PDT)
Received: from twshared45213.02.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 16 Sep 2025 20:05:25 +0000
Received: by devbig091.ldc1.facebook.com (Postfix, from userid 8731)
	id E654526805CD; Tue, 16 Sep 2025 12:49:18 -0700 (PDT)
From: Chris Mason <clm@meta.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger
	<borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S .
 Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Dave
 Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter
 Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook
	<kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        Zi Yan
	<ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R .
 Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou
	<chengming.zhou@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
	<rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko
	<mhocko@suse.com>, David Rientjes <rientjes@google.com>,
        Shakeel Butt
	<shakeel.butt@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami
 Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman
	<mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu
	<peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato
	<pfalcato@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Mateusz Guzik
	<mjguzik@gmail.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
Date: Tue, 16 Sep 2025 12:49:13 -0700
Message-ID: <20250916194915.1395712-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
References:
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: CegqZ0FIJGWGClgQdsiVr-Y9NEU6FXnA
X-Proofpoint-ORIG-GUID: CegqZ0FIJGWGClgQdsiVr-Y9NEU6FXnA
X-Authority-Analysis: v=2.4 cv=aNjwqa9m c=1 sm=1 tr=0 ts=68c9c307 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=aLg_dGqrtwJZ8BkNSCAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDE4NyBTYWx0ZWRfX6pvArvtH1d3z
 Uu881LBTYJcexjA2c0J5l4tsX2lbPWY+bWxZEXasZfB+XvS5duOAIbkoolYaJTlUjSgC7guGJod
 MiJ8Xre9yzejYsxdpQaQLn6whGGGOjVM5t4mCoND2cwLP2vgMuLG4Hd/3JHn/cBqwJDouOtAbRZ
 3TwldLUUbBrb6bpu4lrvAN0n5YDZUc7l/K2TTRW9i0zGjh6yfhyg8JACA/rq2aCGDZT2tfH+rAP
 BgFXm8sTi0nzlzpYIZuLZWrONRMNgpUMEm4Nwcr38OmunKTAqrqpGM8KId3UKl6tc2w+ZLBHj3z
 lGMmK1o28CXmAvSG4+5M1ZGfTJ7/UgXZyGo24ch8SsRNM0kV0wRvDWjEOqRRoY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01

On Tue, 12 Aug 2025 16:44:11 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracl=
e.com> wrote:

> As part of the effort to move to mm->flags becoming a bitmap field, con=
vert
> existing users to making use of the mm_flags_*() accessors which will, =
when
> the conversion is complete, be the only means of accessing mm_struct fl=
ags.
>=20
> This will result in the debug output being that of a bitmap output, whi=
ch
> will result in a minor change here, but since this is for debug only, t=
his
> should have no bearing.
>=20
> Otherwise, no functional changes intended.
>=20
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ ... ]

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..17650f0b516e 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c

[ ... ]

> @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, uns=
igned int, flags)
>  	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
>  	 * possible change in exit_mmap is seen
>  	 */
> -	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
> +	if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
>  		ret =3D -EAGAIN;
>  	mmap_read_unlock(mm);
> =20

Hi Lorzeno, I think we lost a ! here.

claude found enough inverted logic in moved code that I did a new run wit=
h
a more explicit prompt for it, but this was the only new hit.

-chris


