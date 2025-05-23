Return-Path: <linux-fsdevel+bounces-49754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED81BAC20B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8096D4E2F37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FEB227EB2;
	Fri, 23 May 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OtfpTxR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D96226CF8;
	Fri, 23 May 2025 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995303; cv=none; b=BgoXp8zsy1g1DIkV3wQCFW+TfsDTGdpEfyv78JYbDTfD0RY25WbcNhRmgSy01nb7h+Zh33pBufqWAmgDRnenLaGvTTBF99/AQD56s1lcB48j02tXdiVKD7dXlTbeTU9hIYqjljm0Muaaf9l4QBCJfKawQ694djCxaMAeFJ6h7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995303; c=relaxed/simple;
	bh=Mtt71jTZm+HlLNOkIpKqUpZ3L6JoS2woYWY7Cdl2HYQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=INWRpM5Im30QVZZTKiRvpp15aNKU1bfgw9YZniCwXO2LmjKh5Tfgg+SLWoSDfDnE4DwwctwBszv/v/nyX/9HT5ZpBjrQcO2QE268+HudPQWmQHQZvQFCeHMRLTFoJsMGr5BzUw6nin1eo9sx1I79AiVnJV8nqNG7sUgh+WhD780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OtfpTxR/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNWGtk004906;
	Fri, 23 May 2025 10:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zXHL2C
	q+aRXrEcEy64Su9IC7piz2/y4DTVPnU1CRfrc=; b=OtfpTxR/+M1m9QoMFOZaKH
	RActYnItKiQYOsfii4Gmmev9OQOU12QikegR5liYjMFtB9Ukq/QGoxH1S/HDh0R0
	dThbBxCDkZdbdwStKTPDpBLzOB9tZSjUhsXSmxqnxJ+McD3P4LWOHQxMR/k0dc7T
	2Wxsfuv1isWJdIWGUBkUv4SYZZvKAzo1pBRcc/hHVBI0cUtKUbXE7vVadxiKAhLy
	Fc+MRJH1Ef9ALUSPKCSULvmSSkh4VTqgpzYXRE84MDgtRz9tmP8GIbwjti/Q3M/y
	+hFc5B1nNEc40zCRalAFiD/q/ArUaOc1NvBHdS/UMCboF2uVxI+iW+TuzEyYOiDA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t14jp7v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 10:14:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54NAEidc010386;
	Fri, 23 May 2025 10:14:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t14jp7v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 10:14:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N6MpD2024698;
	Fri, 23 May 2025 10:14:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwkre2nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 10:14:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54NAEdqR6488688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 10:14:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B6D75804E;
	Fri, 23 May 2025 10:14:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E686E5803F;
	Fri, 23 May 2025 10:14:38 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com (unknown [9.109.215.55])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 May 2025 10:14:38 +0000 (GMT)
Message-ID: <ea0963e4b497efb46c2c8e62a30463747cd25bf9.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] mm: fix the inaccurate memory statistics issue for
 users
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
        david@redhat.com, shakeelb@google.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, aboorvad@linux.ibm.com
Date: Fri, 23 May 2025 15:44:37 +0530
In-Reply-To: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
References: 
	<3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kQ5NL5TDjSwS59MUQidPvcGmYplsemXy
X-Authority-Analysis: v=2.4 cv=XOkwSRhE c=1 sm=1 tr=0 ts=68304a96 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=bJgjvqlET6HPnKk_xIcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA4OCBTYWx0ZWRfX16m2iHnkczm5 iqWKf4LT5TGBLToXASQndjXxXQ6Ro8K0/reUukgZmcsqRcJ2JOYsY6DeKhUvitqSaOCdVG1wr63 xTbjzwAIYAOBKz71jcB/0sz1S88oOnf+Ma66i3jizUy+1b76dWDczWmuncNtB5i3dcvmmUWUI7x
 D6yBn44cUmW/90yBWRMj1THYJvMN21LqhoxTZ7YJzbVUL9HtOFglWi4HfgKvwwV6/JwUG6h8qWg XYImosgUg1Rvo0KtL782xVgOZAkWAAvszLepySJGdYM1lasj3juNJOnq8jc2jQrnqE/fLu6ExLq Zok0jJCiHEE7t6TgsOjyQNPiFcZo+9MvIY/okR6Gr9DXQZBFsNXVTisrfft75WiuCZQIOd/Mkwi
 kDugl0gozqeuAfRi5AC5oSfHOGmACe+hdxpripq5VTENh31GJBtjbtTeaPdNJrHaeqODwqo5
X-Proofpoint-GUID: AR63o-4QBzzE29T2gvaQpZWgN0ph5qqw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230088

On Fri, 2025-05-23 at 11:16 +0800, Baolin Wang wrote:
> On some large machines with a high number of CPUs running a 64K kernel,
> we found that the 'RES' field is always 0 displayed by the top command
> for some processes, which will cause a lot of confusion for users.
>=20
> =C2=A0=C2=A0=C2=A0 PID USER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PR=C2=A0 NI=C2=
=A0=C2=A0=C2=A0 VIRT=C2=A0=C2=A0=C2=A0 RES=C2=A0=C2=A0=C2=A0 SHR S=C2=A0 %C=
PU=C2=A0 %MEM=C2=A0=C2=A0=C2=A0=C2=A0 TIME+ COMMAND
> =C2=A0875525 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0 0=C2=A0=C2=
=A0 12480=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 R=
=C2=A0=C2=A0 0.3=C2=A0=C2=A0 0.0=C2=A0=C2=A0 0:00.08 top
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=
=A0=C2=A0 0=C2=A0 172800=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0 S=C2=A0=C2=A0 0.0=C2=A0=C2=A0 0.0=C2=A0=C2=A0 0:04.52 system=
d
>=20
> The main reason is that the batch size of the percpu counter is quite lar=
ge
> on these machines, caching a significant percpu value, since converting m=
m's
> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's r=
ss
> stats into percpu_counter"). Intuitively, the batch number should be opti=
mized,
> but on some paths, performance may take precedence over statistical accur=
acy.
> Therefore, introducing a new interface to add the percpu statistical coun=
t
> and display it to users, which can remove the confusion. In addition, thi=
s
> change is not expected to be on a performance-critical path, so the modif=
ication
> should be acceptable.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> =C2=A0fs/proc/task_mmu.c | 14 +++++++-------
> =C2=A0include/linux/mm.h |=C2=A0 5 +++++
> =C2=A02 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index b9e4fbbdf6e6..f629e6526935 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -36,9 +36,9 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
> =C2=A0	unsigned long text, lib, swap, anon, file, shmem;
> =C2=A0	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
> =C2=A0
> -	anon =3D get_mm_counter(mm, MM_ANONPAGES);
> -	file =3D get_mm_counter(mm, MM_FILEPAGES);
> -	shmem =3D get_mm_counter(mm, MM_SHMEMPAGES);
> +	anon =3D get_mm_counter_sum(mm, MM_ANONPAGES);
> +	file =3D get_mm_counter_sum(mm, MM_FILEPAGES);
> +	shmem =3D get_mm_counter_sum(mm, MM_SHMEMPAGES);
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Note: to minimize their overhead, mm maintains hiwater_vm and
> @@ -59,7 +59,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
> =C2=A0	text =3D min(text, mm->exec_vm << PAGE_SHIFT);
> =C2=A0	lib =3D (mm->exec_vm << PAGE_SHIFT) - text;
> =C2=A0
> -	swap =3D get_mm_counter(mm, MM_SWAPENTS);
> +	swap =3D get_mm_counter_sum(mm, MM_SWAPENTS);
> =C2=A0	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
> =C2=A0	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
> =C2=A0	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
> @@ -92,12 +92,12 @@ unsigned long task_statm(struct mm_struct *mm,
> =C2=A0			 unsigned long *shared, unsigned long *text,
> =C2=A0			 unsigned long *data, unsigned long *resident)
> =C2=A0{
> -	*shared =3D get_mm_counter(mm, MM_FILEPAGES) +
> -			get_mm_counter(mm, MM_SHMEMPAGES);
> +	*shared =3D get_mm_counter_sum(mm, MM_FILEPAGES) +
> +			get_mm_counter_sum(mm, MM_SHMEMPAGES);
> =C2=A0	*text =3D (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK)=
)
> =C2=A0								>> PAGE_SHIFT;
> =C2=A0	*data =3D mm->data_vm + mm->stack_vm;
> -	*resident =3D *shared + get_mm_counter(mm, MM_ANONPAGES);
> +	*resident =3D *shared + get_mm_counter_sum(mm, MM_ANONPAGES);
> =C2=A0	return mm->total_vm;
> =C2=A0}
> =C2=A0
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 185424858f23..15ec5cfe9515 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2568,6 +2568,11 @@ static inline unsigned long get_mm_counter(struct =
mm_struct *mm, int member)
> =C2=A0	return percpu_counter_read_positive(&mm->rss_stat[member]);
> =C2=A0}
> =C2=A0
> +static inline unsigned long get_mm_counter_sum(struct mm_struct *mm, int=
 member)
> +{
> +	return percpu_counter_sum_positive(&mm->rss_stat[member]);
> +}
> +
> =C2=A0void mm_trace_rss_stat(struct mm_struct *mm, int member);
> =C2=A0
> =C2=A0static inline void add_mm_counter(struct mm_struct *mm, int member,=
 long value)

Hi Baolin,

This patch looks good to me. We observed a similar issue where the
generic mm selftest split_huge_page_test failed due to outdated RssAnon
values reported in /proc/[pid]/status.

...

Without Patch:

# ./split_huge_page_test=20
TAP version 13
1..34
Bail out! No RssAnon is allocated before split
# Planned tests !=3D run tests (34 !=3D 0)
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0

...

With Patch:

# ./split_huge_page_test
# ./split_huge_page_test=20
TAP version 13
1..34
...
# Totals: pass:11 fail:0 xfail:0 xpass:0 skip:23 error:0

...

While this change may introduce some lock contention, it only affects
the task_mem function which is invoked only when reading
/proc/[pid]/status. Since this is not on a performance critical path,
it will be good to have this change in order to get accurate memory
stats.

This fix resolves the issue we've seen with split_huge_page_test.

Thanks!


Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>



