Return-Path: <linux-fsdevel+bounces-13227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C97586D717
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 23:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502EF1C2133C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 22:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488FC6D528;
	Thu, 29 Feb 2024 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Wcd9sWB6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CCD200CD;
	Thu, 29 Feb 2024 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247420; cv=fail; b=FPVw/PUmjiwoKzOiHozuNAn3NLoSqpUN1RaSNebOsWNxoe6Kk826H3xbrwsNqdtBfkWlUoU7FDmF3il7QmmP8FaIWXeek4f7Bd2XvvWExHmsvJTdPjPjHlg6XxAbnxpIVxtPR1COtbrhcNikBteOeb89kYLyYan7O7aat6ER8v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247420; c=relaxed/simple;
	bh=nMSWRaaz/HFQYLPWTr+1+xX1xbxfh9oQOziqH+PXaAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G+ls7Y1VAFc4FrNzOvBpjGVekLxbmBSdMIW/Xz9Tc3fmfs7uOqjM3Ic9O87foHKYn866UaD/6+ku2SY7M/CAlAdqS+xvkseoaDum4nCiihgJx0oaeLvBtMAsPtvWqh5LBKZ/+Nbz3TI7n9i87OCR1Xyp/ea86T6XU82NohsKj2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Wcd9sWB6; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101]) by mx-outbound45-215.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 29 Feb 2024 22:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAuxL8QIt3mbWHd0kh7ejHdlicELwBaxOc4jtmG42OUzyCm4yKEeyv1aqKAJWySIPkqiS224PcsvwKMD4dgN0mTSm/aJfVPrhkRVUf4JJ4SEYthiwlFbiEE5ZBMl2RrEYzn8ifkaRyx2No1OdAcVxrOGM+zc4Gx+4T5roOR3zQTq2EcMv2UAvbEISsdh4dQflNTHkUlZhduCJ6AtfyVZEcCWndr+4iI3dbZ8Se+Xhj0GPiP0oCh6/bxEAT7AFCnQVfbzAka7/5J9ta0RhUYcDhQrFgzIJXvNvd08B7ubW4CeMZw/DtWUk3LoVkS/colltmwrjgns+ofj1UkzCQSFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK+3cTMw5mbk7dwmWuxsD/Mgj0CoFLRo7TTBLh6zwEw=;
 b=F1CarhO6zVUTpHmdYbLDnrfcjjsIQAK5NsiY6rFftyURWfd42UHGkqKAiSQlrzxtlVduu/9TD9JlayalebrEzP4Ps1WTQMtS8pR3Hphm+i4j3byxsg9mxrK9p87jh2lxlkrkrbA2tsFeZlk4dcl+e2evhE0LGd8VXO+Uo4+YVt0JrbsgZ2tQlWEfX7nSAFx8cJFkpxvg7In1rykP+paEW645/lFqq3U27etbeMYFKk7Gzz58l0M9xCaYQaq5+6kSJILZdF6nfd+tdEA0yd7CVGuzYKxWYvmQIXUa+lYKGWfLq2nBJmoG6JRbnhYXR+jE0sy0zssFvzaTT+C4I/fU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NK+3cTMw5mbk7dwmWuxsD/Mgj0CoFLRo7TTBLh6zwEw=;
 b=Wcd9sWB6hdnDIEUDDgFuYZl1Idx3/67M2bLO5ahPxIlBcbwoaQjGGHosqaVsNuHAQxVjfQK28DzQDx9g/rbaP3VDoUx0/XRK2zjPpEqih2JxcMZlu36BfrvgpeAzOuR9kVE6JwJ/wnnA2xTtF4i4pXcpInibLKNu3GDD2m25tx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from PH7PR19MB8187.namprd19.prod.outlook.com (2603:10b6:510:2f3::18)
 by PH7PR19MB5704.namprd19.prod.outlook.com (2603:10b6:510:1d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 22:56:34 +0000
Received: from PH7PR19MB8187.namprd19.prod.outlook.com
 ([fe80::e517:bf4e:593b:7f43]) by PH7PR19MB8187.namprd19.prod.outlook.com
 ([fe80::e517:bf4e:593b:7f43%4]) with mapi id 15.20.7339.031; Thu, 29 Feb 2024
 22:56:34 +0000
Date: Thu, 29 Feb 2024 15:56:30 -0700
From: Greg Edwards <gedwards@ddn.com>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Hugh Dickins <hughd@google.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-mm <linux-mm@kvack.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
Message-ID: <20240229225630.GA460680@bobdog.home.arpa>
References: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
X-ClientProxiedBy: SA9PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:21::14) To PH7PR19MB8187.namprd19.prod.outlook.com
 (2603:10b6:510:2f3::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR19MB8187:EE_|PH7PR19MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cddc09-0e81-44cd-cd4d-08dc3979ad73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4lLzSIGHC1vsRsO+J8MPfJ+ODXGFiUoLjUfNVbD7V2pyqYIgahFD95vGY1EIbXZC4buHjmopz0ZYLas4bNq8pCRTaKVbcR+NdK0mI438TIVe3hgvvR7b7JSxu8teW6G/c66lTGZ7iz9JJRvhac98eMbyPCy5+xkK6KHcNDEzLHF+4uHUn5mRb+CVC3QyYpfEurjLLVl59sVihGo+QW7dPw98zK+/1sLiyLZNR35/XtF1DThvUgkNA4iBepGDDASygtkzK/z5ZGCvATyjGgVQTqav3YNRWGdt0CMaHeVX7L6qzjUlIKidM/TBhVnB3UGHO3wJECjQMMASqly7z3ZTFk36urObfFeO9+JxpGN/5yNBztFI0hPCzdwtUjR4HyNAniGS24AMU7Zu2cv1xJcEtq3SGTuz2XVUa+LKvxksZN2gmtgW0VXWlFH0FJZ1izFYyzL+y6DllsI3ofZ8olvtlgQmkrdFDO5WGDtI0EYTiEd7ttgXYdNDrIAcjTrj9yCOt+iufzmjxLbyWqngWqMBRhhN3xo6rOYyNtCCYxo8HRmcPcqFyouHAIvE+2HiMuFzHxkSPVUzjGLqJh5ddivfwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB8187.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+jDuXpn8OEwuR4wCceIefpngnHDn57XtcSP9rgEH096CWXJCyYaSS/y+Pl+?=
 =?us-ascii?Q?ktX3WZQuIFqmM0wZeoZm5Q+DeNSu8+5sw8qqPa4DmH+5q/xxdvXXYLLOc/hT?=
 =?us-ascii?Q?a5anzYYQj0JreGOARNquW3XK5F2Ok43LrZEF4N8jZmxp2jOEpEUpU6gMRF/d?=
 =?us-ascii?Q?Y14iiFC1/Q/GC8iCnG8i38qXLGfyKGtiCSnGIIECj4sf/SEIuD8OtI053jgO?=
 =?us-ascii?Q?9LMNarnqNwh+SNlgo++gnAVTV+94DLJSS82v+9prusUyPT9h/wgSKbskXvvA?=
 =?us-ascii?Q?P+nbVlePStCD1lZFTF1zPmi2QMKv8LBv7GTxxIi2VBYiG6JdFyxyQ0mezhKG?=
 =?us-ascii?Q?XlXWNSeDkp7r8/PuS1Xfa3d8xDr9gk9tv67r55EnXW+xYlFxIOqCBvxbJLZT?=
 =?us-ascii?Q?ATtzimQttgttuXebXPgqHRR1bqt5hoIPeFQlMBkRn41hdWrmCc9aQ7DBhdsp?=
 =?us-ascii?Q?PH0z9Juf0vcnbfefbhzJvXSSj5g5PsZK9sjwBYhc9pZSGl7WiKiM38EqJoHB?=
 =?us-ascii?Q?g80BgvmidiHRgcEMn+gnqCnldkbFBv7wyDyvU61Ya2NFLV2WJvkQCe32xhS+?=
 =?us-ascii?Q?NS1nZCIvV4BnUctGsUab3JThWvmvPjym49jg3EMqJlATAylrWrgBi3hZrBeC?=
 =?us-ascii?Q?EDwrYu4IHvDF7j4Va1ikCKSclv4ZMNTR2XNDzdB6rUGQehE3ZziYvy2pp/i1?=
 =?us-ascii?Q?PSMuAb2irFNdeoFqsSkvLOm5f3eW9HB1z9RrcwPbPEAgnjGTCW4MdDpUl5g/?=
 =?us-ascii?Q?u0COkY3hkV507uH+hhrVBnvIfDCsvkjHn0uT9NnkUZ7LtVsTW4nzADO3BUh8?=
 =?us-ascii?Q?Nqg8jkd4+HmL7mTW6il5HQ2EmuwI2XwTdavxv8ylTFMAYq56ObhOIpGgVpF+?=
 =?us-ascii?Q?AqLFvh9nC5DUXybBeaOgo3cqnc5yzuuiVg6JuMnRMi/zYnxPkYTO9aLuIii7?=
 =?us-ascii?Q?poz9tXerrZF7RF+zULRehWM4MpVtULaeWEdTBoV8A/XAUWfoidsEPnCFoPac?=
 =?us-ascii?Q?ucnyN67eiCmmKwLOcWQAjiTsdCQTfLAfoVOB0J7FRWDN00fLSyPSWPN8+5Rx?=
 =?us-ascii?Q?P+U/+uZBVUyD9Sw/1vytHky3M7PjXEyTNL6KKq401IX03y1fc7AmdKhNlj2m?=
 =?us-ascii?Q?eccvwKPtZwE9w/nFjr89FWE2WR9oT13MFa+8lleQNj+qgj+BHO3zcSj5Hdtd?=
 =?us-ascii?Q?YwDsB99G8iQm88YVEox8mHP2uLguDKHIfy0RUp8kue+x1EPDwmi+9gZQdgmO?=
 =?us-ascii?Q?ijdP7dxD9t3e3+NF3WMMvez4LrQpvr8THxQuJ2v8oNjfExFCoWUpH/CFigQc?=
 =?us-ascii?Q?Fy790J8/6xfwl1wYhUdXuPLVWN1p4NNSsQ8HFKCDkcVnJwkFmqyNlHLmUqzk?=
 =?us-ascii?Q?qP4bzkGtWLza8Mp3W+ee659bdMyGNVlayx5/+Q/XQ1DJvkZfJehtv92GAEyi?=
 =?us-ascii?Q?Uj4W3tyi1OSkBshii9Denmy1hN+kchWQ3M+M1gosvY8HaJ1jlAzaoIwQzx+e?=
 =?us-ascii?Q?dxnS1u4oJWkEwbxrctY21VSNIHIkk1IhZXT0Sexc96aStskkTZipE2fJYLva?=
 =?us-ascii?Q?u1BbKG3udbDq/imVZfat3jrSH865lGK4CSo6BhHo3BrzxolBI2/NmEteUQoL?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KS3zk2lQm4+KKSWN7jl5Re8wZt1KZKR5/yv7I4VH+mgZWZoeKkpwvk6HAMFVs6lRDhrwIiQd9Rsyo+E/sq1hGCxxMdb7gWl4apa0tZ2FuPy6KiUwhKOWAMvKDitWFfzkrHKltTs1Fmt3a/J9SrP41Pf4+Q/BMmsxt9mbiG2qWiXevdRHIPIsYFpuMPru+fWAfZYLdN8UYaERa0LrhtFQHeACGJUMPV++lbqsf1rgzrWjU4Cna9y9PmbGNxTUrXQYrq0UTvjGbfgRoLWSiNMEfzJoqFp3jUgvAxbTs158vW87EikGaoKqhhp+lMbn8yuzYB/4Zdyi0n9NXZi5K2LJ9NobsqKVxRNqFFCrZpQCoBN7oznLgUSQbuABN9qUZbBuEd+cqgxj7vE5U5ExEY7dHBl82c4zZ/oDr2/xRWVwYpk6rPPEezxNoqTfQ+gRj5l7WtBKgfdi4/IAS6D889jckWnxUB/CcIGHgxFwtaoKOo0rYD14aziW48NZxmQ0n3AWiWC2Iaz35RhC8lBNW3StpgQo82Jcjk7uiq+7JLG9eUIhSaSBXY2RzDX0Ljvh4BOIZ66SGdoH/MyqqYpDV0fZka3K/kB4BlbR954sLHft78SJ8nhyjrO5+kwwrlPidHox/Py1bgbkuqFg7Sk6qqrB0A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cddc09-0e81-44cd-cd4d-08dc3979ad73
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB8187.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 22:56:34.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7C85DpNcfUnWb7yXU6rIkR6vAzlD+KzTxTsMizwj6nmfnkdW8wzNZvfNSdb82kgVc9MiOGTSVhvqMs7kqwiEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5704
X-BESS-ID: 1709247399-111735-7444-3003-1
X-BESS-VER: 2019.1_20240229.2154
X-BESS-Apparent-Source-IP: 104.47.58.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmZGpkBGBlDMzNTSyCLJ1DA1zc
	DQ0DjJyMTM1MLc0DjNwtDYKNnC0lKpNhYACwxRaEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254560 [from 
	cloudscan19-59.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

On Thu, Feb 29, 2024 at 01:08:09PM -0500, Tony Battersby wrote:
> Fix an incorrect number of pages being released for buffers that do not
> start at the beginning of a page.
>
> Fixes: 1b151e2435fc ("block: Remove special-casing of compound pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> ---

This resolves the QEMU hugetlb issue I noted earlier today here [1].
I tested it on 6.1.79, 6.8-rc6 and linux-next-20240229.  Thank you!

Feel free to add a:

Tested-by: Greg Edwards <gedwards@ddn.com>

[1] https://lore.kernel.org/linux-block/20240229182513.GA17355@bobdog.home.arpa/

