Return-Path: <linux-fsdevel+bounces-12683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178CC862814
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 23:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BCA2820EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44AC4E1C1;
	Sat, 24 Feb 2024 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="W+JaYPYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F912B82
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708815528; cv=fail; b=K2JPSfYjFR73XYmiWMiodbcYHXzBKtHqQZa4J09XbbxQVnwda9wQ3kf8jD0R/AI2QhYRjwb1vHov3wdx/sPuRKbLuIJZCW1CUH+rcHC03QWOzeoaQNhX2N8bxyk7fvVWGcTRGNDqSuML5XaP52oSTLWp8+VD4bJq9iQlVpEOg0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708815528; c=relaxed/simple;
	bh=RmY9k1IuIbBRc11lsyfGOZ4dTNFJS5no+aFbZVIecW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CFQiIoskj+zQULdkZJu96s2CA2VIJfuC2AoPKBupvpdbuOdYQWmR1QPNe8eZFpmh8IxPcvjxpaLf116lCLtstTm3p3kINrxdEJ2M+WUN3qme9FVws/+acBI0l+cyG0ZCF/pdLdT/06JCNfY2WDIUa2lV5v9XqWowpPwki3z8e9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=W+JaYPYS; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OAe4Y1009271;
	Sat, 24 Feb 2024 14:58:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CRFaz/kje686HuSSS7jQ1JiJUWXxyTlnD1HGaWfNpSc=;
 b=W+JaYPYSF71pl8kw116zdBHLAdDrsGAgkWrQsU0gdFXNNhN61ARP/cvN1Ju7q1V4lsmM
 d6c909QZA4e3Ra/rFRaG9gLGcwoSKb6d01SGiyMCJKU1iCGv8o+ddzawlEEE0eRZgeo9
 rsoNQM1mkK6ny/zncWtIjADbEq6A/8tMNSn4DeUHO/7AeeUnePF7DfyVluOms0i/4Ixk
 9HceEpeNik4XLODYaXo1DI0XIQ7GURcfAMVm+s+DA/hQ8N66dthHE42lqL3TCmX4j2N3
 sHxzXAS6xxVgXkDVGMuUZpiZOTKf5N3MxDu4flSMaLax34RCgQWTxuswKFzmDFSU8xKy JA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wfevb9xs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 14:58:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU5WLTzEhrMWZzJ+kta9vEimeuO0v2dY9+LR0t4F7nHS1plllxR/E877gfcBdWmBZvdDTF3vzbrA/3/8DPoWzLjv3TSW+X21WQufFchgvHDKEQ9xpr1nYf7QphNvQAVzBYxsKdMzfNUZyBKtD7Eq9NOJQSJ3N0Ry0H773161REggHFjYGczcNrGjJUBBPA6nnO7ENTsMZJa0rNqNhcN0kl26u9X6hqLfbsNH0XbwJ/PthmkI1jscdf3/T+dVJ5laKJi8cqxueZaeFVw5ZIgoEB+rJOdB98evr91mhVzMYtKwtOR7+jGqqsFLYe8JorU9xHlp44VYY+174+DRyZ0N/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRFaz/kje686HuSSS7jQ1JiJUWXxyTlnD1HGaWfNpSc=;
 b=A7491ymconlJAu3IuNu54wb87xbbDWTfkjtAykHdb+IaWTfkaVnunRpBYxyOXUXA9sxk8X1TP/9afsK+gIXxkN9aBAJ6p+80WuI3icGhqlv2dNQH+NdQvhb7WPib7Om9vLN1oAbKH50lfxnk6BW+w/XaaQq/g9Xl5m8Oh6gDvhAm/WUuRp/0FJhRFR2FyvVu3aV4mrYOcIN+U/JJJG5z/2B0TlC8qxoQurI9zuq7lcQ17ogON+BQ7w4jabZeRPV1f4JkDKjb1NtGRwsIdNML5IAE2QR+pfbRcwaIswdZQH57wp5YLD4TCCLM9v6SuIrtcxXtSlzJ3VLMMCyEzEFEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by DS0PR15MB6186.namprd15.prod.outlook.com (2603:10b6:8:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Sat, 24 Feb
 2024 22:58:15 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::9c98:3298:e8d6:e8e0]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::9c98:3298:e8d6:e8e0%4]) with mapi id 15.20.7316.032; Sat, 24 Feb 2024
 22:58:15 +0000
Message-ID: <bb2e87d7-a706-4dc8-9c09-9257b69ebd5c@meta.com>
Date: Sat, 24 Feb 2024 17:57:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Daniel Gomez <da.gomez@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <CAHk-=wj0_eGczsoTJska24Lf9Sk6VXUGrfHymcDZF_Q5ExQdxQ@mail.gmail.com>
 <CAHk-=wintzU7i5NCVAUY_es6_eo8Zpt=mD0PAyhFd0aCu65WfA@mail.gmail.com>
From: Chris Mason <clm@meta.com>
In-Reply-To: <CAHk-=wintzU7i5NCVAUY_es6_eo8Zpt=mD0PAyhFd0aCu65WfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BLAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:208:335::17) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|DS0PR15MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: a04dade2-4b83-4367-a44b-08dc358c15a6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lbOiCFPCDlCAHUCVsX4t0ixOZ+78nu5wVeOmu5xFPFCSgAQLpwVq4QzrJzm0hDZvayO0F76BMtf4noE1tHdnXBlzNt5vk5HUs/DsksZUXtCKXIIzhJwMwQ+HyRg2vJ5rUdNAkih4Pi4iy62wb5fEMjJW5d/MFMWds0h9D+tTs/ZiODw3ZN6J75uiTSvkygB12pSOMhgCe+tJAecnqORcGpnDy9xmDjrUNgYL9alrroW4KNCR5CW24G3DX6+TAfpwkWGASjxg4KuwNRoBsbJa7qbMVJSODs+cbTJcmO5kuPvWS/FU1Qinffl29quqjwaKTldRw+jGhkYbrQ6aGq+R94ScZCMXtQuUH199/v05UpA0S+ageuQZU9V6qc3k75+3zfBtmfaQ+K0EbMnKUyFLqz5kk1I2KJCFD5udM+78IpRbyc5O2CKxRmjxXp0DcKXDb/LgvGaA95wys+KPBV29sRvQVey1MCY3eDSGSdMs+WtCWSc/9YpQxnH1/V/c9FCC9Ou3c+CZhTBcR2uCX/kElA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGNKeEF4MWw1bjRjeTdtWXVOMThyemtXZlhxSkhaRXB0Vmg0WEZFMlh0QnMv?=
 =?utf-8?B?WmV6elV1SFYwSktCWC9EVEZWZHJ6VzBVR3RIZC9vZjdHQ1NoQVMyTGw3NHBC?=
 =?utf-8?B?NWlGNnpxZHFPVEEzbGM5NWVBVlEvL3ZxZ3Z5WG5tcGNic0RJaG92KzdlRVVK?=
 =?utf-8?B?RDU1ZjFwS2QySzI2cnMrdFRHVHg0M2hiYzJJTzR5UXR5d28wQXB4ZEVidmZl?=
 =?utf-8?B?ZnNRWGd5dWlTbUVUZ1pzUWw4UXdvSDJyYko3TUpJdUc5VUwyd0hNbnEwZE1F?=
 =?utf-8?B?TWVINnVrRWZzNHlodkEwRFkrSzU0cEV2Z3BkTlYvTXlZdVFVeXl6Tis1bm1n?=
 =?utf-8?B?YnRQY3pOeXB0Sm1xbGsyYUhjYzNJb2QvQmhHTEpyWmczWWVnUkw0bUFDY2FG?=
 =?utf-8?B?SVp6b1dwaEpkQktTMzZONFZZYXIwN20rNnROWHczT0JOVmdMWEpUZXNGMlRw?=
 =?utf-8?B?N1hUaXBBeTZJekZMc05HL2pQdnR5WS9lbHR4QUE5eDBRR0lZQTNuNWZpZlln?=
 =?utf-8?B?R3VxZ3VLVFIyN3lzdGJBdWd0bXAwY0o0MWJhNFdlUnN5cUt6MEtSK3VxMGpU?=
 =?utf-8?B?KzlsaytWU1g1ZytrQzZLWmdkM0lPWmJiU3I4S0pIWFhremFneGNNWmRKU1ZN?=
 =?utf-8?B?ZDczcEJ0SWVGK001U1Vvb2V5c3M5dU5xQVlITVdRWGlTZDBJWTd3MWN4Q2Zm?=
 =?utf-8?B?aTFoUXc1NVFBYWNySHpiU1R3dE5Zc0VMQW5kSURqRGIvMk1RYkJoQXpIYkJX?=
 =?utf-8?B?cldVbFl2bUlOZ3Q2MmFrZjZpWXFUWnJkSEFFbE05K0Y3QVNWaVJQL0hQdDZP?=
 =?utf-8?B?NnBUMXk5dWk4QWM4QU9SMnRhK2w3eWNCVDBlbXRONDlLR3pMREVQdy9aR2xY?=
 =?utf-8?B?N0VwQVVKdWpnck1kUmFoVTZheE8yRk1EcVplK3F2QkVQSkRHOTQyUG5ZamNM?=
 =?utf-8?B?SVQ0VnpIUlBPeDZYUDNYZnR5R01VekRmZXhtRHhhL2JJUVZDd1JjdnhCU2xI?=
 =?utf-8?B?U3krdnV6OVZJOUl4Y2xCTTR2T3ZPanUxQWJJcGQrVUFTbm5HbS8wbjdOcDBM?=
 =?utf-8?B?Ukdtelp1NXU2VXRSMVlKaUhuSExsR1Q5QnVXWjhpTXFGWEY4ayt1aDVudmdi?=
 =?utf-8?B?UXFqaTRFSVkxcVpWcU8yY2xoMWN2TWljdzhyUzYrd1lxQVRON2tWaWxqWW1U?=
 =?utf-8?B?UTJpbW9jdXd6VHcxR1VvMGpORG12RVZHNlB5Z0VVTmFTMUdiWEI4TmpUekVx?=
 =?utf-8?B?TTAxanZkd3pNYUVxOHoreHRWZ1FKcVFYOVZGRnd0eTl0QlVvZjV1WFFxMzlN?=
 =?utf-8?B?Q3ZXRlVyc2dTV1NwMUh2MHdqMS9FcUUwWmIrQmFRWC96eFVnMjdKMmxrTElu?=
 =?utf-8?B?Sm1DUlRwR28vNFhHVjdqTkUvbEVTNlBmNEZyNmJiM1VUUUF6NW1QdnFDNlJH?=
 =?utf-8?B?OVFBUklQTHFrYkZYUGpBaUJtYlZPaUVYalByM0gxNmZHMVY1NVlXWVZkTzJC?=
 =?utf-8?B?aWc1ZDZudHBpclo1d2hvS0hEQkkvcGZwMzZZbjFncmdyZDRta3l4dHBYcHFZ?=
 =?utf-8?B?Z1hCVUl1QzhyMTVZRGhqTzJlVER4cXhVSWVPR3ZEU2JDcnJyeE5ackJ0KzlE?=
 =?utf-8?B?bEtsZFBjRW82S0U0NVZDV1NmM0tVSkxnMThzUTV3SDYrZ0RaeGdNTk9vZ2I0?=
 =?utf-8?B?M1llSTF0MXNMYWZxMkxxOG14SG9EUS9NQ1d2allvSnQzekRhMSt6UldmS3dq?=
 =?utf-8?B?L3BPMzZLcTRNcSsvQVVJbmQzRGtuMzBaOERxekZoZXlEbG9BaGhXSFJGeHRn?=
 =?utf-8?B?ZVZxanFwNldiRzZXT3pEQTBXVTRNM0JJY1R2TzNhemJDWXZGUnhtYm9lTWdO?=
 =?utf-8?B?dlQzUTYxMGZCaCtpWkJ5MXd4dmtBNU02NU9kcHFyRmZaT3B2c2tOTnBuSnNU?=
 =?utf-8?B?NnhMV05MZlk2cW40WGNITUFxbjNja0Z2aWRGbGYraUtyTmJVb1NGMmhpKzNu?=
 =?utf-8?B?T2NHR093Tk5ycFQ1MEM2N2Rsc21YRmFvdTBNd0paR1dLRWVxMDdlaUgxQnhE?=
 =?utf-8?B?cFVSNWhTTlZQNy9HTUI5dWR4NFlOMVRlOE1PSzR6a3ZzMVV3RmcvdVk1ZWdj?=
 =?utf-8?Q?YveM=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04dade2-4b83-4367-a44b-08dc358c15a6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 22:58:15.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2m+1IWQ/mViVnwAEAHl32XFvtsH6dcLN+sIN/f6ZL8M4C3FM199zecXNG/3siHyF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6186
X-Proofpoint-ORIG-GUID: N87YLdD2q2kkpPDupR3FVPmF2kw4U8Wq
X-Proofpoint-GUID: N87YLdD2q2kkpPDupR3FVPmF2kw4U8Wq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_18,2024-02-23_01,2023-05-22_02

On 2/24/24 2:11 PM, Linus Torvalds wrote:
> On Sat, 24 Feb 2024 at 10:20, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> If somebody really cares about this kind of load, and cannot use
>> O_DIRECT for some reason ("I actually do want caches 99% of the
>> time"), I suspect the solution is to have some slightly gentler way to
>> say "instead of the throttling logic, I want you to start my writeouts
>> much more synchronously".
>>
>> IOW, we could have a writer flag that still uses the page cache, but
>> that instead of that
>>
>>                 balance_dirty_pages_ratelimited(mapping);
> 
> I was *sure* we had had some work in this area, and yup, there's a
> series from 2019 by Konstantin Khlebnikov to implement write-behind.
> 
> Some digging in the lore archives found this
> 
>     https://lore.kernel.org/lkml/156896493723.4334.13340481207144634918.stgit@buzz/
> 
> but I don't remember what then happened to it.  It clearly never went
> anywhere, although I think something _like_ that is quite possibly the
> right thing to do (and I was fairly positive about the patch at the
> time).
> 
> I have this feeling that there's been other attempts of write-behind
> in this area, but that thread was the only one I found from my quick
> search.
> 
> I'm not saying Konstanti's patch is the thing to do, and I suspect we
> might want to actually have some way for people to say at open-time
> that "I want write-behind", but it looks like at least a starting
> point.
> 
> But it is possible that this work never went anywhere exactly because
> this is such a rare case. That kind of "write so much that you want to
> do something special" is often such a special thing that using
> O_DIRECT is generally the trivial solution.

For teams that really more control over dirty pages with existing APIs,
I've suggested using sync_file_range periodically.  It seems to work
pretty well, and they can adjust the sizes and frequency as needed.

Managing clean pages has been a problem with workloads that really care
about p99 allocation latency.  We've had issues where kswapd saturates a
core throwing away all the clean pages from either streaming readers or
writers.

To reproduce on 6.8-rc5, I did buffered IO onto a 6 drive raid0 via MD.
Max possible tput seems to be 8GB/s writes, and the box has 256GB of ram
across two sockets.  For buffered IO onto md0, we're hitting about
1.2GB/s, and have a core saturated by a kworker doing writepages.

From time to time, our random crud that maintains the system will need a
lot of memory and kswapd will saturate a core, but this tends to resolve
itself after 10-20 seconds.  Our ultra sensitive workloads would
complain, but they manage the page cache more explicitly to avoid these
situations.

The raid0 is fast enough that we never hit the synchronous dirty page
limit.  fio is just 100% CPU bound, and when kswapd saturates a core,
it's just freeing clean pages.

With filesystems in use, kswapd and the writepages kworkers are better
behaved, which just makes me think writepages on blockdevices have seen
less optimization, not really a huge surprise.  Filesystems can push the
full 8GB/s tput either buffered or O_DIRECT.

With streaming writes to a small number of large files, total free
memory might get down to 1.5GB on the 256GB machine, with most of the
rest being clean page cache.

If I instead write to millions of 1MB files, free memory refuses to go
below 12GB, and kswapd doesn't misbehave at all.  We're still pushing
7GB/s writes.

Not a lot of conclusions, other than it's not that hard to use clean
page cache to make the system slower than some workloads are willing to
tolerate.

Ignoring widly slow devices, the dirty limits seem to work well enough
on both big and small systems that I haven't needed to investigate
issues there as often.

Going back to Luis's original email, I'd echo Willy's suggestion for
profiles.  Unless we're saturating memory bandwidth, buffered should be
able to get much closer to O_DIRECT, just at a much higher overall cost.

-chris


