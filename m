Return-Path: <linux-fsdevel+bounces-52632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E104FAE4B60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 18:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD7178404
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0973B27C84F;
	Mon, 23 Jun 2025 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NnUjKCce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E226D4D9;
	Mon, 23 Jun 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697369; cv=none; b=uBVXIUnW1fw5MEy8iH1lWeg5fyvFX+fEAJ9scJvi1CMGSsp27mkS8NeDcQzd3Rtygdcdaua69flzm9yuDEY7rMT6MoHDnfTzn3yfeMM8XqRqqAqO4ZppqxBMK/0bK78pYs7WlF90YAh7M/H3MKoJaOZMi9qCKl75/gi+tIlSWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697369; c=relaxed/simple;
	bh=19TGEDkPtBHA6xMI1N35uuGXsx0EAc9X3vRohN6+VIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOiuJFgi6BhfAxkiwVvqS3x8J23HOJzm5h8O5I9560b3NzwdzyoTj6/oBKEfoUy6J9BKdFjUm/hVsuSUYXMggYicmPT8GUBFWckRZd2gPYfUxY9bmaFL2h/eZON3Wfj+UgnNeFULiYQ8JbiGeg1qFF6P9nhBUKjvm4ZRdYkhQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NnUjKCce; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBLaXg026028;
	Mon, 23 Jun 2025 16:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A5qzRO
	8i3Vtpiel6eduiPaggiL9Ye4GOB/0RenZg+8E=; b=NnUjKCcedku/cyckm7fEeo
	zX9X7zJcdk0xosy8qE1zvAPwN3ngvagIt+H2FmQhNnE/tAdJoh1lDDyQ1f48PTUw
	D//3P8AASUw7uC6Em0oQnC3XE+NtBO+MKJOS9YhHK1VwL/A6ydSJgQS/FyPjEb8Q
	dlK9DTeSlMMcvAIUEIBnyrGPQJecpcMd9aXx4vvWQ0CwtzQ55PTE+YRxYjC+uYQP
	zBPXLUVFqF9oayPb5VGiKHcoG1Aput3InCh+TW4BQ3OiOQGrTpj5M+JZDm6+O8TH
	CnMR4I1/3PUcAjqHMK67tSx+mlPXBqh++8vgTJu4e38NLA/ZPHeAipkbhcQ7ZR+w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme13gkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 16:49:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NGWkqw030506;
	Mon, 23 Jun 2025 16:49:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eyqxsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 16:49:19 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NGnIsN25821768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 16:49:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EE1358045;
	Mon, 23 Jun 2025 16:49:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5084958052;
	Mon, 23 Jun 2025 16:49:16 +0000 (GMT)
Received: from [9.61.251.177] (unknown [9.61.251.177])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jun 2025 16:49:16 +0000 (GMT)
Message-ID: <fa879d91-878d-41c4-bf7c-67bef4e376f1@linux.ibm.com>
Date: Mon, 23 Jun 2025 22:19:14 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250620] Fails to boot to IBM Power Server
Content-Language: en-GB
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
References: <aafeb4a9-31ea-43ad-b807-fd082cc0c9ad@linux.ibm.com>
 <20250623135602.GA1880847@ZenIV>
 <72342657-f579-4c4a-bcda-534e28c40304@linux.ibm.com>
 <20250623150253.GC1880847@ZenIV>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250623150253.GC1880847@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=68598591 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=jgwLNZEmTTdDHIAjbjMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: N4C_tmmLlfG0BDOkFkghQ3AXvbQQuB5f
X-Proofpoint-ORIG-GUID: N4C_tmmLlfG0BDOkFkghQ3AXvbQQuB5f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEwMiBTYWx0ZWRfXwNppBP8zVeDd mxsZs9r879ktP7F93VLkBHyXGOnVIYV7G1fKPge7SMbqzWUoQaHOdS4J+MStAM2+n891e+KgsZF QwIMOe8grLksqUwAazns19qtg/wCiqnYRExffBl617FV65OjZYVv4mNGMKMjlBzAi8BuALS56Qe
 LmbHIdszbihxBYDnEXbey/qjYfzpEqWNHwHHInLPrvWNg2KZ/dEmr/1lo6RVYt1Yar95/1CLNP6 y/OerrVJBNOPqTlY68ID4hhg4MdO6CX9Hrj/LFn64mXphlAuMdEHhT2W5nwGL+OohsJ667tz87h MEa523c3YuGRlOGQVA5LRdWpXdtx/6i71NKlXwr5regf9kNvXPX2zsUxHisK8oyDs5jo18BpYqR
 pLalmxK/ccI6M5Kyaqe/OQKbe06vtt5wTOi3icN9BfxFNWp4IyutPwMsAdGKhUJ2Qq4mNsj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230102


On 23/06/25 8:32 pm, Al Viro wrote:
> On Mon, Jun 23, 2025 at 08:22:28PM +0530, Venkat Rao Bagalkote wrote:
>> On 23/06/25 7:26 pm, Al Viro wrote:
>>> On Mon, Jun 23, 2025 at 07:20:03PM +0530, Venkat Rao Bagalkote wrote:
>>>
>>> [NULL pointer dereference somewhere in collect_paths()]
>>>
>>> Could you put objdump -d of the function in question somewhere?
>>> Or just fs/namespace.o from your build...
>>>
>> Attached is the namespace.o file.
> Huh...
>
> That looks like NULL first argument (path), which blows up on
>          struct mount *root = real_mount(path->mnt);
> just prior to grabbing namespace_sem...
>
> *blinks*
> <obscenities>
>
> Could you check if the delta below fixes it?
>
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 68e042ae93c7..b0eae2a3c895 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -832,7 +832,7 @@ int audit_add_tree_rule(struct audit_krule *rule)
>   	err = kern_path(tree->pathname, 0, &path);
>   	if (err)
>   		goto Err;
> -	paths = collect_paths(paths, array, 16);
> +	paths = collect_paths(&path, array, 16);
>   	path_put(&path);
>   	if (IS_ERR(paths)) {
>   		err = PTR_ERR(paths);


Tested the above patch and fixes the reported issue. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.


