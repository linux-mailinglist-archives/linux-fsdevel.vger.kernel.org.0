Return-Path: <linux-fsdevel+bounces-41997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BF4A39E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 15:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3016166181
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31861269B10;
	Tue, 18 Feb 2025 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CV+RovXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F77243361;
	Tue, 18 Feb 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887767; cv=none; b=N9PhUqFWlHLSHhN3lXiRWvLs/CSB01jMLCuqaCoS3X4qivcb0J+9G+nBeVOTtMXUUwZSs808WN0x+L5IwXojCZMlAh51lhdQbB+A2SjHw2fENuY3s3kqBE6h/XdxE2wzXi9teIUKaceYcUMMTCo2uTAtEFqkhIe1bO9fvVjoUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887767; c=relaxed/simple;
	bh=I/RdCQPPn1wHaFmlp+tuRpK9XsLvtlVCcv5TFMGTqPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkDgHp/UYeGz4Ia1oAtvIswY4OqAgB3kfJaChDrYcL6rN6NIF2WnvsbXoSJp9vbNhPBrcIgH+tZx67uMvP9Duny4bH4Z4AflQhsbk9BY1aVyJj+bXzzVE8mOWRj4m3qzsRZX8oXqa50IUp3l6F6bO4sHKB2GPO0r5qXvodmCu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CV+RovXp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IBML7J020389;
	Tue, 18 Feb 2025 14:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9AF1om8Lrm/xLDRHOLxFEifeKpnaLe
	RhNPZT9gDLIQ0=; b=CV+RovXpmtr1HdW8oXhrmXR+yctXcF/BZ/igc+sObd4LmN
	Q+YeZ1Zlb43eyfvWfHnVonpvcozFlMyS7RwWrXmeeapi/bJc0Xqnd/qGeGwkkqYx
	zL1E7BNIE+kIXvk8qpAT60eq6qShVzwSUL2vNi2m4D6+XHL77xqXT+KRDpqxKNEw
	VFv8m1cHcw3z3cUALoCO9xSlCFCDjwS7GjlwK3XN5pEwSMMC+4YXKqAp4mzE8/XH
	/9saCZ8rgKGhg0d+fjm594PCQaoMsYHZqawndMZp+Wt2fIn9VzEBYa6q9a5OfePO
	UhtAvSK5l82To9C9ygf3TkZ3thakqLmrVwcHailg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vg99u7j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 14:08:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51IE7Lf0016617;
	Tue, 18 Feb 2025 14:08:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vg99u7j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 14:08:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IBaUc3013259;
	Tue, 18 Feb 2025 14:08:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7fkk9wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 14:08:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IE8NZ59306562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 14:08:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430722004E;
	Tue, 18 Feb 2025 14:08:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAD4620043;
	Tue, 18 Feb 2025 14:08:22 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Feb 2025 14:08:22 +0000 (GMT)
Date: Tue, 18 Feb 2025 15:08:21 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: joel granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 7/8] s390: mv s390 sysctls into their own file under
 arch/s390 dir
Message-ID: <20250218140821.7740Ab5-hca@linux.ibm.com>
References: <20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org>
 <20250218-jag-mv_ctltables-v1-7-cd3698ab8d29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-jag-mv_ctltables-v1-7-cd3698ab8d29@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C1vwg1h0Wd1-AF41KNeLrehTep7PLEGd
X-Proofpoint-ORIG-GUID: 6Qf1aZgnvDRrtDnExFplYp_kZP8KujkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_06,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1011 mlxlogscore=780
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180106

On Tue, Feb 18, 2025 at 10:56:23AM +0100, joel granados wrote:
> Move s390 sysctls (spin_retry and userprocess_debug) into their own
> files under arch/s390. We create two new sysctl tables
> (2390_{fault,spin}_sysctl_table) which will be initialized with
> arch_initcall placing them after their original place in proc_root_init.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kerenel/sysctl.c.
  ^^^^^^^
typo

> diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
> index a81a01c44927..4483fdc9d472 100644
> --- a/arch/s390/lib/spinlock.c
> +++ b/arch/s390/lib/spinlock.c
> @@ -17,6 +17,10 @@
>  #include <asm/alternative.h>
>  #include <asm/asm.h>
>  
> +#if defined(CONFIG_SMP)
> +#include <linux/sysctl.h>
> +#endif
> +
...
> +#if defined(CONFIG_SMP)
> +static const struct ctl_table s390_spin_sysctl_table[] = {
> +	{
> +		.procname	= "spin_retry",
> +		.data		= &spin_retry,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +};
> +
> +static int __init init_s390_spin_sysctls(void)
> +{
> +	register_sysctl_init("kernel", s390_spin_sysctl_table);
> +	return 0;
> +}
> +arch_initcall(init_s390_spin_sysctls);
> +#endif

I see that you want to keep the existing CONFIG_SMP behaviour, but since a
long time s390 enforces CONFIG_SMP=y (this was obviously never reflected in
kernel/sysctl.c).
Therefore the above ifdefs should be removed, and in addition the include
statement should be added to the other linux includes at the top of the file.

