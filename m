Return-Path: <linux-fsdevel+bounces-55008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2ABB0650E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 19:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB76F7AEE69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E322853E0;
	Tue, 15 Jul 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PtP2a4d+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UtVcGS3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27D188A3A;
	Tue, 15 Jul 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600097; cv=fail; b=ToOv4/Wz7vGky49eTC7EHNv+I4WNiQ/bEmps4IT9lMxQZPGa+t5DvnMktz5pcU8cxGBT/3ZX/10B/nsKcJrMEf74Be1H4ycuBFyp5Oo7iX2wxN/o3s5+tJwmT1bLeYcpnNAPVUC4O6a1hgAaeMIYjg40ugWUYm3Do+EgZktlqdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600097; c=relaxed/simple;
	bh=pUcOxsWY1+5otgZAvQ6kY7A1+oLpOJE6h6+O6dxGAnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CMHBkBY7cxsKCMMiSCdcYubNXdi9ii8hYMYKg6YjnHrndWG5oP21fngfKH2654+camKg2HlGHb/ehykEIKxX5d8jNlpu2btfZum3Zw/gazxN5VbdWD2Zo+a1/DuiLWIr8JxHc/3quZQhVJygdPR+ScXUeIOZJaOT+PaNw0iAvmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PtP2a4d+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UtVcGS3k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZGv9013555;
	Tue, 15 Jul 2025 17:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=waDk8uy19YVbDTvno+
	bl+geUJnfgMqNGFzK35tMGT6M=; b=PtP2a4d+YxNG5mcoUx8tfrwH1KL0Xyijn7
	WDlgotOXLlp3Z4icjJO6k05smBOt2K4ofGj3fyhlG0OD9DFiXPkLAkBogDa3fqGp
	lhiQx6sw6S/KC0DYYF0kpsiM2E4czN0ArrjBKOZPfQD+hUrA+DOj/PQgUh0kudk0
	mPLkHZEi1dOoaM7sUdHB3dnCJyuFlY+jLUP1gDT7mmCBQIl4MDGe50GQteyTwdTW
	ZoKEEr5POscDTYwBge72GpHJKfENY5KVaxWdMPC3tJX1PBAkJfRtYtt1eu7DDeJQ
	qKAxL/1e1hyBE5ecmZvEw6O+XtfzvGoSe5P5x3lXevwLVUWMrVYA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqqywh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 17:20:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FFxCNG040497;
	Tue, 15 Jul 2025 17:20:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a9y0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 17:20:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbUf+NvzU4Hwhs+50R5TBG7PLClqR10rSyyupF6csLalKUlEJSylO7IsV8t52OghLhy1yaG38y3vJuzjVv7stDUz7goI4xSiZR4ZFXMAIv2zHAifSWDLL4oWxrwn7sO93W9kvot6JBitJod+RCBCOCWS8KZsTCO0C/ufG5vA/dfD5Iswf2D+MGuTY/XmWCBFxCs1K4eKd3SvRCm7633MK8f+pt//kk47yLLqBUpyznUKDLd9jy8QCGtxUI0r6jyqY50IiwBLBbL8vvhVJnxN/ZN20jPjDvxsM3w0na/xNa3oCAMqIU8CqjucCHmFqKtQkU3Ge33Af6A+QZ+bLHbNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waDk8uy19YVbDTvno+bl+geUJnfgMqNGFzK35tMGT6M=;
 b=NewFEFkKtHIBR5Um6trY/CAnEkpP1CLkg8rXZoFVpsHYJd4ya3Lb8iv92CTYJekT7D4Rl/sYVaELEmtksQTwUah3fX5BWSlisAdQ+ACMkjOmad0Trq9tzcHGkrBLPJuyXyWmlUnHHqwYqu/CCgF0HfYQmLOS+Cica9qbmNx0Vv9blBvSBrr8zAi4wIaQ2M35xInE5p5pIj0rrtRAVwxuM+eEciUAc/jxBNF3vb3XtHwlt4uwL3b8U2Bmni0v5i//nTWLZlSgA2sQ93V+yTe/PCb3DEAXfp5lmcvgPqORXqgZt7xre+L3eNjficS6EEbHn7eWguY0htXXuK/NMvSrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waDk8uy19YVbDTvno+bl+geUJnfgMqNGFzK35tMGT6M=;
 b=UtVcGS3kZqUIhO323cjRjMB6FlqO/aJbqQlaBXGbPgtDXb1IHPHGfm2Scyp2vATmJmoy/1iTLBygW+qGGotEoBTvZJ25jXKwoKwtwX4JQIWYlRgm+del1Z9+gXh0vA544Mg6+IXXGQHSPRXLqxi6gOAoCceOnLxUQRxfZ+YC0CY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7782.namprd10.prod.outlook.com (2603:10b6:510:2fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 17:20:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 17:20:49 +0000
Date: Tue, 15 Jul 2025 18:20:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
        peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org,
        mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org,
        adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com,
        yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org,
        osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com,
        christophe.leroy@csgroup.eu, tjmercier@google.com,
        kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under
 per-vma lock
Message-ID: <7d878566-f445-4fc2-9d04-eb8b38024c9b@lucifer.local>
References: <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
 <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
 <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com>
 <8026c455-6237-47e3-98af-e3acb90dba25@suse.cz>
 <5f8d3100-a0dd-4da3-8797-f097e063ca97@lucifer.local>
 <CAEf4BzaEouFx8EuZF_PUKdc5wsq-5FYNyAE19VRxV7_YJkrfww@mail.gmail.com>
 <7568edfa-6992-452d-9eb2-2497221cb22a@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7568edfa-6992-452d-9eb2-2497221cb22a@lucifer.local>
X-ClientProxiedBy: LO4P123CA0436.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f41e54-2ddb-42c5-0496-08ddc3c3f193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xDpMSHtA5BhqaRnTu88RAAtO+CXQKIMHyK+onzKHYQJFW26A7HaDfOm8FzMj?=
 =?us-ascii?Q?DZvXehiNHFXD6RHAhNSh2rzCGTZwcCOMJYkjSik5Ta/irnA3FjJbCpGw9ReF?=
 =?us-ascii?Q?IOvT5BjNCs32inBzeCzLkW0bzkPHZDF5e3qWlMP6rJNkmNbRsGFcyjKhUr/9?=
 =?us-ascii?Q?01SVsNujx2pHSyhSMrxZef/uEEU9HxGRKXPVvoGTHhfqzgYb8PTjj6QTCAxc?=
 =?us-ascii?Q?AA07/FOMeuaYoYk36X2EHwOPeHseqyGMH8LOe3WMDh4JYu6+ZsFnB9moQ/qF?=
 =?us-ascii?Q?+m9ZJuzuOG2DKYLpA/5BfW25f3+Cz8dKKiVlYpF6KxD8+mRTl6H4UTJvBQZU?=
 =?us-ascii?Q?9YdF/faCdC8Msg5mpp5UJu/aEFlTmhGw/0XSPU6wmQKY1U4scok98iC49bB3?=
 =?us-ascii?Q?PX9vc7TzO/Eol13b/W3aS77XQoyFTAaeEokU0X8Uj0OW2rKq4ceeOkJ99ySW?=
 =?us-ascii?Q?+wHeLvOKsuo3ATd7CPdFuCximWxmdP4N+b6/aPkZP2S62NZayC6USN18PnLj?=
 =?us-ascii?Q?ivy0WgO86oyS8DO5shzGS4QQMJ77AYwIuNqIvVh66zivEtu4ld1wC50DSJeX?=
 =?us-ascii?Q?guC3biJbcS8c9kiyE1Mu6EYzZhBPeseGONQPDDW845O/h1D6HxllUz24rppF?=
 =?us-ascii?Q?0TnOQPfJ/qWQThLHSiatDP4/gaC7J2xsjpuMlLIAT7m3ayYHbd0COsO8Zery?=
 =?us-ascii?Q?JHOUpHygFgXChFIiyVNfKBdm8YGKy4yuo+795JweE3KsAV2xEvJVkCYDkZes?=
 =?us-ascii?Q?AYm9hdSYyXNkrYCo4EmtmiaE9CT1kvbEW/uf1zJ4AmFbDP7E4T1GwaGcKxWa?=
 =?us-ascii?Q?Mr+46t36sQ+m+n37Ejb6ncXnltbpbVVkIfYhG4Csa1YfD6qK/e4SEMvwoXae?=
 =?us-ascii?Q?Xq8vWQD0stwCLVvlFicd2cSpt889qkc8yrgr3Lpdf6PVBmLCtPkK9BHKosJY?=
 =?us-ascii?Q?tvA9ynDItZEMbXbYWC6MFBQmhuv71RvO/wIwRbZafEDxALdJVwJxaNv9dZC7?=
 =?us-ascii?Q?QV3ZDNFdfRFo/bAouY0RNvqQZS7yn+bF2oAMNuW4IH20MKioaunDIwTi0U9W?=
 =?us-ascii?Q?mvwHdzMPIpPLpuRtA96Ufy+q1teeMgsORJiUHkMtpdyv/SfAD9QdXQ8C7Tq+?=
 =?us-ascii?Q?Uj9vHX+heMxASbiy+rDUGQV5FLkJbGvO+Qwd5HT0Zy+XAXzNNLM+OR7trs6n?=
 =?us-ascii?Q?desxIsH22I4Va/0mnT2pdB0H8VHDiy2BJ2PcUjN7eEq32aKZvS9m/tClMczh?=
 =?us-ascii?Q?DA5f2lrztELtOtUMrIJBf27Um51E7vvavYuEK/GjRCc+eQ4mPzEfDKJmRpl4?=
 =?us-ascii?Q?A7ufdsdcw9OWTlFxZ45rVET8NosWZ2fXzNiA4/U2sK+DOKZ3IIVHRatc+Ct7?=
 =?us-ascii?Q?sl7gjZgQff1K5mo+OlQYwan7kZmcEJEri5bMb8buP3PTirv4rRgtxq4vwP9+?=
 =?us-ascii?Q?zAdaH0gZRoc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FPLTrqb2ScoOcSQ86x+83A4bPkEgUyu3DeqC6T+Qke2JwjusArMasWw0AzbR?=
 =?us-ascii?Q?n+iacAnKndkWPaflf999q1FKqEnA3t1nucyyErM/I3UtMFUC0PsZ+s6P7imT?=
 =?us-ascii?Q?DR1cWgEAs3xhsMwJBoTfCrWJ+1tfOO6TKdtWFNXgSBDD1mZWMVxdpoeBekCb?=
 =?us-ascii?Q?lrSEJKXS0WeCzQDG0c6BBNbzZboyRQIo1CPr26kZbwXq7TuM4Z+Pg7GTZozJ?=
 =?us-ascii?Q?DAO8Z4gERy3Tz/5gr2tVwe8hUoSh4vwfP2F6a7DftZGhSPng9xE2R/MOZnE/?=
 =?us-ascii?Q?N+41PlwSJnrkF3uwboEPIb0I7SbWydSz9Z+IqStWR+xLN0KJaPH/nUjbjAIs?=
 =?us-ascii?Q?WUqezodI3q6Bdtmw9ZmCBQqErB8QyC8KlCBT+5rgUFnrTU/9FOKJUZKS8PWo?=
 =?us-ascii?Q?Ev34Npk7CO9oRZV3rNukZPddIFWm3OOPikhI4DqXgpMt8SBRZ/8tqAvAFZso?=
 =?us-ascii?Q?MSSQ5HPbz3MkApnrUZUcXfMH4GcKT5iTzigK4xt9508oj2QC8KE3aZIvWSSi?=
 =?us-ascii?Q?FxFkK6Uiy+cecBxgNpOozbcac+ySxWZ8767QeSex2wGF2+xqjJyP7xVG80+M?=
 =?us-ascii?Q?NrpaayOFyLuQZwvCmWcojY1Pr2kCU502F+M+8jilqnlAdzjKa7Xyn9dnCS0F?=
 =?us-ascii?Q?NF3FySg0OYqkQ2DFXAceminc9E29ATw8b2zUwgli7aoRo0nlqVJnUTMfDNq8?=
 =?us-ascii?Q?tS7b6QeWUWh1yjPHRRnzFJyM3lVHBdn/pTp1CEiJaoMRUBm72ct9oQbeDwgT?=
 =?us-ascii?Q?n7KuiLnr7QJRxZ5FVaXdnZdqh3pGiizADDoYweJYtH39y87EjPQ+6O0VE3LH?=
 =?us-ascii?Q?qv4NJGJc0EVLghz3yPpkU+DJrrnr2V4eCUqzbH4VzXzeexRm3cuN+t+BlKb3?=
 =?us-ascii?Q?41lcLRmnWA2IoEpHrZ/Q4s61EVbMdGx9FTJnfrmQ8OP4vmSuqwX+p0ojcTLn?=
 =?us-ascii?Q?S2aKipKzYHO4niz9lpPNFhKcAVwQrZiAuHf8SZs4m6zRrA8fmHmRjrfBPdZn?=
 =?us-ascii?Q?B/zLZI18/QWPItvsbKtyYEQr7saUCL2gBNvj9nXgfItFs2Iyp3R8j/rf8LCk?=
 =?us-ascii?Q?G5llHxFk8eeDddilk4ffJ2T87ybWvLhwBEoBDMMrMEijjK9jvU9pRIsLY9i8?=
 =?us-ascii?Q?YWNOLOHMsto/qYTqoNCF0XCQpuRQojbS0Axxk4QcEycJvZvnrVEr+arz8eAR?=
 =?us-ascii?Q?Z2mM8N5ySEOun5OI08jRZ3BD0kB3GU5TkEwOpi338Ck7rMGyWWqft9W1SDSt?=
 =?us-ascii?Q?L5miuyFVeZgsmE+ZtHhIUgmEpJDAO/PG7q4zTP9Nn3aBzgEgxdBhfM1dgatT?=
 =?us-ascii?Q?HBtRphcBukp+Su4TLEqhQ3kr2khm2Lurj0dwrO6luFkXJbHRfd+28tqi/2Lx?=
 =?us-ascii?Q?PLUdYCR2BVRo8kiwX9+o76Gc2yB9dhe+6o70f2l/LxQO+lXnI0VmEnNZQhLC?=
 =?us-ascii?Q?BSfkFDbwHVj0JCoC2n9nrvv0x3yZIe2AwMaMMRmHkdd6gGrZN6EazQJKp5c/?=
 =?us-ascii?Q?ByntalGAzeeb/tBqw0D+np06XmlEhSx4dhtJomZAVKZ3y5kjMjltbw1KCc4X?=
 =?us-ascii?Q?+8U3wsP+0Kxsiv1Ex6Z9jkQsy1Y6lw4oRjuU5SPCmvZgaDDPtKVCtWl7TLEc?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UGHUCEvtdfbXKS15E8Ld/eyu3rzZxyCAz886EhS0qBPFsmhVgM5aNFZAoPonjXEIi4e34IZmQ14V1WTfwFyWhJDKyHhKzl8hPhZVYAaLdARzCfBhVB9XzrrS0FvNJiN1gSvufOPxW9so8E1kXgWr179cIClSvBbUaV7lX4biYDgJp0Fqz1CXt/wp6uLCO76yNUlsKqGRpKdljdc+cxmnPcsaZwgvLbZrLmhhrZ6e/CqZQ+DMbk2PLTgbOfHiE3zIwtsO+MLU3R1TxoMyPRPKamrZ9nNbiamHR1LmMzpM+8+pvBfKmMYXxr6jrR9cwsKKLiZ8l8WGK6hym4qkf9cc1XEBp/+qRsE4gd56xdLvlxVMY0tZKB+mw3l9MNHnsyuzRoU82cWnGfuAAOYjkv2LXl5LuF1x8vYb1614UX8NAnlJ78p9huIqPVjH7A2HF6wIfstXPQhb+uCcTfg6OEB8CMctOwoJCrLyLzlXaa4HTvZZ1JqY5JKwsEqsdQ5phtCxopLPrxI+Fqs7GUFMBYu7cNFpWwLwkEjT/2z7+v8UM3NbkbBeoqriwmSQRf3kyXYLsk4jeCrSHFFFQ8qgPE/Kwbl+KSLh53oKqr7/yprYcnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f41e54-2ddb-42c5-0496-08ddc3c3f193
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:20:49.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zntxEh5FJOq02EPp9pMhOoq57bthhiNucntE/PEoYW1fewIpGo/QYe6J4TH4hgPKumL5B+SrLYm74aToQBaDRhNTM9CvaxVWwxus4HKLPPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150159
X-Proofpoint-GUID: SIxl9ECtal5U9dTF_jWf_NQ_s8uGLnlp
X-Proofpoint-ORIG-GUID: SIxl9ECtal5U9dTF_jWf_NQ_s8uGLnlp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1OCBTYWx0ZWRfX+k4sIQLNx0gx znY3MSh8P+PdvbUnjhtdiPME0HHLnfJTxoSsiftt4ngMeQLMdvAdytr4+eqq1/tV/wdd9aGA8Tl AvO+F9Kqqx0PTUgz7FGDyj+jNxqzlIsUoqqSPej5JftWdF0qLMTW1QGLrgi3hRZ0954D5qUJ10I
 1nrbIJWtTxvVrPtO5LLBd9R73AkAEwP23wDKKAgEndTF1/fduJhU45QF/yMVZiWW8IZGwLtxKx2 AYgQG7+PY2G0xwZblUauu+mdBepXPI8gbG8ZRy5RxCoGnu8qooAzq5XjtEAiylvmqsAanNeUqNl DOhcB9ZcTNhSEfLaZEQXL7RlmpwOmp0h3uqOPZ9kAAmsx6LZdjZSmXvfdYtNk+qaD7TbC6NmFdR
 6Fsr47ZksJqag77h2CBGSgEuU9IQL+WeqpAcTJBjZbl/sEiNdI8nxNEyQi3D1ixSR5fYH0b2
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=68768df7 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=la8RXUJ5w2NH4SyecSUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

On Tue, Jul 15, 2025 at 06:10:16PM +0100, Lorenzo Stoakes wrote:
> > For PROCMAP_QUERY, we need priv->mm, but the newly added locked_vma
> > and locked_vma don't need to be persisted between ioctl calls. So we
> > can just add those two fields into a small struct, and for seq_file
> > case have it in priv, but for PROCMAP_QUERY just have it on the stack.
> > The code can be written to accept this struct to maintain the state,
> > which for PROCMAP_QUERY ioctl will be very short-lived on the stack
> > one.
> >
> > Would that work?
>
> Yeah that's a great idea actually, the stack would obviously give us the
> per-query invocation thing. Nice!
>
> I am kicking myself because I jokingly suggested (off-list) that a helper
> struct would be the answer to everything (I do love them) and of
> course... here we are :P

Hm but actually we'd have to invert things I think, what I mean is - since
these fields can be updated at any time by racing threads, we can't have
_anything_ in the priv struct that is mutable.

So instead we should do something like:

struct proc_maps_state {
	const struct proc_maps_private *priv;
	bool mmap_locked;
	struct vm_area_struct *locked_vma;
	struct vma_iterator iter;
	loff_t last_pos;
};

static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
	struct seq_file *seq = file->private_data;
	struct proc_maps_private *priv = seq->private;
	struct proc_maps_state state = {
		.priv = priv,
	};

	switch (cmd) {
	case PROCMAP_QUERY:
		return do_procmap_query(state, (void __user *)arg);
	default:
		return -ENOIOCTLCMD;
	}
}

And then we have a stack-based thing with the bits that change and a
read-only pointer to the bits that must remain static. And we can enforce
that with const...

We'd have to move the VMI and last_pos out too to make it const.

Anyway the general idea should work!

