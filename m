Return-Path: <linux-fsdevel+bounces-36431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCA69E3991
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBFF169500
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025881B6D10;
	Wed,  4 Dec 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Msk5YKcF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xx859JF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9F1B87D4;
	Wed,  4 Dec 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314256; cv=fail; b=R6xhczT8zMi4c3dGMm4JNhf7PLw16KKRdGmlmY7Hfl3pDWGU4LNNXykZ1em33jCLTbOhl6DoVUwcXf4ao0BT3zSSNdHsFAC2Y+rau2ldtOzLITxclghWN+xWYWqsHCGZogZS5pdi5JszE80mtmHO8uB2TyL7gQDGlJqZsMS6JVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314256; c=relaxed/simple;
	bh=DRB0D8mV32wYIjS8HVtCcqwNKvBoN9MZNSYbTkqOU6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LgvqmXpPh+boMt1UIhivYqxTLvTuYJsxia5pCiKpFtyOC6vdehJmYTrtreMtAW5MvcfxJEpgfp1ReNNIYTFbxeNQraWDDlbkXQMVADsOaiIIDGQhXg98kW5nUG/xNH+VS8AV4P7aPshEBxhj7ixXo26zPnsYD2mDmE0zaQQyiYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Msk5YKcF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xx859JF0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4AfqBm029756;
	Wed, 4 Dec 2024 12:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zuXWXLvMGDVfW4RZoX
	cYEp4PMyU8AvClabSfWNkRbvY=; b=Msk5YKcFvB8QWiunmxxKMIcNf00882nBFr
	BQFeqtKuiw/4uroIJTHO49tekbUfF3elGbqm0PTWipQ1B6gjo0MeEORFotza1ssb
	3q8e1QWzPy3BfLOOMeY9CpB1VkMdTJUB5uXpy3qjRgtyfgSf7KLy92Z/5e2ZYRHv
	Vj4iLST+lto3+/SxsImfWJZdXFg1IjlvvV2qYeeQQjD2Wu9mF70Rr/1O9sNOjxEG
	RIhydlKNldanGfqRP6ST2Vy60+b5J8WxiDRqu1z6EEgpfBgiFNbL/TIWbGocn1H2
	uwsfYzdS9R+Ymg2dWxU1Yrb/S8DOL74BnKsh2XSRtEZ15kRzsZ8A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437u8t8btg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 12:10:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4A04Fp031369;
	Wed, 4 Dec 2024 12:10:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836vbb44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 12:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GekN2pFjkedQi4Sgecu8j6vUTz4guwxWy5q0LA12l8DWVRCSSXB7pg3qAsRfbpR01j4hA0Y3LDwGYm1FRkQa0fI0htCCczNojFgycQxb4rhhK5KZzCCaWOsw/qcKL+XooCLr/3/2GU5V5kTI5cecIBNSE/WwiRj521YI05D8aQxehSNwUx9n7+ZDGjLBUF0LTmz/3276MajIvWOODNnUHhd/1QSDddVv9rARLeYPur9VKBdEEoMrmD3JMyXY0Z4rIj6imwBPUPx3M4Yw+OwfpGvsG09j8DTVgFcmsp8j/Y70jLAiWBFMe/uxuzOTe3qF31+AA7tnh2xS0Bc87FUL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuXWXLvMGDVfW4RZoXcYEp4PMyU8AvClabSfWNkRbvY=;
 b=nNJMjTR8B6aBAXflw++UFDWzGYxC1/papNRmhUbtV0Ele9xaUvBiAdtMyA+PnD1ScnUxagTFRGrDgwJmLIZgUAj9aU6GG2J1gS76lE6apguwkC2Et7wywSHyv1VGOvV+ntanbSIg6dBBdGJWALJ92V7+umN6VVEe9OHLMdasXDUryxtOdPuoGpX9M0Vk+5/YPh4wPiSV/aAzHiAc3LUUiFutUehw2wskGJE+8xJ+E8972sgrsc5GkMUfvy7ubquuuX3mf9ryjlcVvYJS05HlduzZLzSaTegr0q7R16vsqbk6uBR6sHNMb70xnUdZCmkMMts4lP+E9QRNzvSN6wfizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuXWXLvMGDVfW4RZoXcYEp4PMyU8AvClabSfWNkRbvY=;
 b=xx859JF0cUvkSx9kyhByJvkOEvtivLVyLkjpPL3QvKndsEUZHW2/VLxMN9TQ+DOV0btZJCcoc6nq03pxn2OURhFfTDGnoIKlCTihG47LqtYjIonPPFl+MlfaxObB+AxUuIxXzU2FOzcrvDKUeVR63Qf3oNICWDfWFU0j0SBRILA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5720.namprd10.prod.outlook.com (2603:10b6:a03:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 12:10:35 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 12:10:35 +0000
Date: Wed, 4 Dec 2024 12:10:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm/vma: move brk() internals to mm/vma.c
Message-ID: <0ec57d7f-c6b9-469e-973b-95389b131376@lucifer.local>
References: <3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes@oracle.com>
 <202412041907.3DXYQrz6-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412041907.3DXYQrz6-lkp@intel.com>
X-ClientProxiedBy: LO2P265CA0371.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f4e84b-b895-48fa-8e6e-08dd145ca825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ltDo6LDrhblMDDiUfStxvLWtNlVZKsbBS+UGf2DFgtBiWq1vzAZ+hJq+2TWM?=
 =?us-ascii?Q?4caX7kG0jHCnAL56fcZ+yhf3VgNxFObJL3F+cyk6dnzyw6w5jwCN/upZrTdT?=
 =?us-ascii?Q?1rAzvSyehBVqkYDN6OiCPKTQTdJrSOaVwpFvKC3YRRH+qYCtAtazt6Ux0NEf?=
 =?us-ascii?Q?RLy8kZMLQis1U6M3crBKRBOLGxq7/prNL8NpdNrg0955ghnsdjdecgu7vvNL?=
 =?us-ascii?Q?sy8VHx0G5a6mIJzBJ0lntrGs1EfDRlTc/h7T7cKUWbuHMwNLp0Q1C718oX1n?=
 =?us-ascii?Q?6LfO8D4hRDXn6udJquUk1BLrDG3Qig8zwyHMV3Wgd1nnGlwvWovoZjZQhrXg?=
 =?us-ascii?Q?haOQBMWxBod8MjYd9+z4jBTSI2o0jBZi5pju/nvT4V229UGFjJPz652u669m?=
 =?us-ascii?Q?/abjBdTT2OqF1WheXL5UqSof9cgy0its4tYKVj4Vuzhq6gsS52NHY+1p7vwv?=
 =?us-ascii?Q?ASHEhzRYZ+TE4M6Jgyx+kKAgg1yVBNNPYZVu0lq/4itVRfGrJRoA62KxUO9h?=
 =?us-ascii?Q?xW9GCJdwrrL5kOU+6AkCtoA8f0xMqokKu/50uX1QevROGfGVmaqSwZU+fkQ/?=
 =?us-ascii?Q?hiLlwsPSX1FU1c3fvsTgBjGCFMlDp8/6Cs6Clwv/FHn8LB+Nj6F5dkLvDD66?=
 =?us-ascii?Q?YulRE+m0nd5lVQn2n+NyJVuu9aKTs7o+as+6a2AsdC2ZjN/LATJMEPT1aND5?=
 =?us-ascii?Q?cNIIaL2b5E3vMuu/nR9Ha601y+6Bu6zmcNsGYXwx6BFOZd37R5dqEJxCVwo3?=
 =?us-ascii?Q?cymZEUeT75wJ+nHhDN0ooazRpit7ZLoxdRIPB5jF0K6VP7XXsKx3AFfqy3Oz?=
 =?us-ascii?Q?DUpdbH8aHSDkoKsHXZv19CT8dHHwOssF8ABpA1kSOEXyt+HlpJGE2WLtNZ5Z?=
 =?us-ascii?Q?hmHnyU3JSqjbeUlfkiVW3tmGAZL2aoJGCIDB65vV58zVEPLbxcA8gaE3zKa5?=
 =?us-ascii?Q?DBo1dcjVyuwq89RzJ2mj/OsMPXzruxR9MbZGh4sKf6ivTuAgb4T8uW8N6L92?=
 =?us-ascii?Q?Jh0/EzMDtbNZlDWpCtVh5/rStkLiDqUyZ6EGdaBciSCrTIXdUnC3w04Ro8ji?=
 =?us-ascii?Q?A8p0aQ78/l8WBcHVNHUw1m8R3gh/z6QnV22GtgpQYH1yXvSftYQyx5MxFUuZ?=
 =?us-ascii?Q?4nl9HhVIlND5YapKkPw0YpyjYwkWCMWwFBcZORhiUXiFAeCLkLcwff04wNEH?=
 =?us-ascii?Q?Tswo1XUwd05WyRTyseY9e0kEQ9spIYB4HJKHHPf/CvlvEnT4xYpGSPRNlzDe?=
 =?us-ascii?Q?IJaxr0llFfwmZyHB7pAH3FcO5WN8TyGTNcpd4pizYQ2tb22F+MyHpo7+UTXC?=
 =?us-ascii?Q?p23z5HfHyI+4OT3PfiHUNmWZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvZ9SeBJe9wekbQpKdK3tSHxCNDG05+RYli8nbR7RKJ95S9Xdo9WJHfdyrHs?=
 =?us-ascii?Q?9cLqFjqlEjK8ny0yiwMnszD7qu4J9PISnQYUiGuq/mIfLsJHjXS1Kn1CD7va?=
 =?us-ascii?Q?i6Ay4StnYAzBcBu3WhtRHakScYTsdlE0EKDnxUJW43lEmVa9GVNdqvvLQ8IO?=
 =?us-ascii?Q?0iT/uLPLfpt3THkNoPOiGRrSK7saN69vLsqWO/ew4myMseQ1m9O7w45aTiUY?=
 =?us-ascii?Q?/tlG9IugDzopIP/ohUFPr1U92tmmqcgo2qPv/o8VGjpJtmV0Pqed+kcT6PJV?=
 =?us-ascii?Q?8n0ThVCTXS2B2ffNDDHPJEnaOc8MpTbL42Yz9vqwDpOf55yAR/efj3DbBzAG?=
 =?us-ascii?Q?ogPc1ZSlCS1h47ilpG5vNHsROTdUW13e+w5zaEiN2vKrVqzAX8037F7wuY83?=
 =?us-ascii?Q?MYZueUc29Dx6oyJrwYUXeQ3HAx6ZaQ+fcXuBd64vJSzVaA7p7/DT8dSQw+pg?=
 =?us-ascii?Q?N/QphTyi82YjsFz7VYa0UtXg6y8K5Mahv+3cYxxAl4xpZ5yJ6LnEwFtvZjZ2?=
 =?us-ascii?Q?9/i6uDa56tVb3ZIFIMlXGwBsoSXjPtTrWDuGtlF2tpPQOxPijib27+PsXaCK?=
 =?us-ascii?Q?4DAYPPs/yw4CAI+FDfqW2/TKGJLPuPMRfm6LhWY6bKGJbyEMRGhb2z88rM4M?=
 =?us-ascii?Q?J3FyJRkFSKUdexCEDCRgeUb5FQEEho0r6IOb0/+DV9mFkHeshwdE9Z1vtC+B?=
 =?us-ascii?Q?G41ilMAjYYhFMh6M8InXwjXOXnkTl2jB1uQR4HWPABzo6lzl6k47xsLCE4Tr?=
 =?us-ascii?Q?ttBPBHXXOX/5xt1ewHI/yxKRNk+Nc7R5rB4//QYyap84Win233auw7qFcngO?=
 =?us-ascii?Q?DJpT5Ti9AUXS/moicbcFUVL9VDlGZVrbz+Oageb6Y7JYghslCLaGKjpIIqsV?=
 =?us-ascii?Q?Zu0+zFvzuOlUrtbsj4cwG/4KZqwaoFfScdC6by7hPtx3XVZISFJBBpAGwXFb?=
 =?us-ascii?Q?QpVV+BaI3nzd7lY8D9WBG9NksvEOes7RsyCjVwCPpw8M45La7MrOzt8KClab?=
 =?us-ascii?Q?+3MsGn/FHFOOKuYb9/+Y9RS51q8IA1i+mUm+StXS0vGfF/gqaCEDsmnGoGXk?=
 =?us-ascii?Q?dx2x2P4lJ/bYiJA3+otF+5zYnzfmaVaPhyy7cz6jRU7/8YBIy0Yl2W6UrEzY?=
 =?us-ascii?Q?ALbYxnlUpk5yyZTsRIasmtq3c8QEBv+aUagW0WQGQy5eYP7TJOOTw/yTCNRI?=
 =?us-ascii?Q?/FrOytLSgKstre7OC0KP6USPljBccL9/xpImJoo3Jcq0ZTOMRXQ/uErOtxB9?=
 =?us-ascii?Q?SLK0daZLj5IFyZNUviHoGWUekCGpy8FovzFJIZh/5vbN0JiUOg4RZ8ZWozvW?=
 =?us-ascii?Q?7tG+C3Jw0J61QrH6dzFHoSR5YNNC4DeM+Gw1CXfsKxjUfgGOItdqYih4mHFw?=
 =?us-ascii?Q?3evpUoXdu4dP2RLpOHlYfzKIv6tuQ79cnwiN6+cygXMBQ4k/A73Hmy4invSy?=
 =?us-ascii?Q?i3xYcs0REneEkR1Piue5W6rA5PYAf9l70sGgm3H8kT2KGa5FSBcmFt/sgMKB?=
 =?us-ascii?Q?qBCt03/V03bfSF5Fds0fk7p6/ZO0b4jIc1MX46F1rqGibpTyGoDG7ExVlBVd?=
 =?us-ascii?Q?guUhjTsEV2K5GZURvxlhxOBiqD19jS7hCAaaFAK1W97c1qZbF1Nr4Nd90Yli?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q4j0HyPZub3USexPKqJ0FbNbpvNFbBcjd+U4iB/YBj7dUAOG3o8EMLuSgNxI3noppLkHEE9hcx07PQRIC1tV0sqK34IrvZvmC3eWq5ez3xunRIP8v9g4BMGtgJFRiq+/RX642e7HCn/XV13IuP1y301nU/zwhN68YLq8wG52MRG1w8rLCKDHV6gdtF+sRXB3kY1Vxj7FuwMww4B6sK+wrVIs369VhCXqB9elRmaSg9aMHF33787u3i1Kde+FTdpMb6b5BczwNSpyFadqxAqu5d0tew+hn1teNWmUjuprfXf4tq5tBbyvkB2dLGdmXb9b23JckJPNy/R/3t6ur+FnhkgIbMDp813fpN0FqB3hSpaqDRg6LEHaexZKaIN5nsXUugHpvXBCg5rwnN0pzSvXT5pZWvWugBxTuZtZdl8kcIyiYeWqj0mHfpPgI7t0OSdWAP5YF/h+F8MymbUQrPOw08mFIFC6E8twTpPLug/9EFyIwU9zwFV2uHK6s+wmH/au/s/yR4uxF2jWrRrL/161vvgZ/OykPGDIqLWEeIgAHLk0Gz2gUVqs8j7lGbwyTsm1W0wPP4IK2m90iEEnotP+RCWAf+VRMBOgsOxvyU2CkcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f4e84b-b895-48fa-8e6e-08dd145ca825
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 12:10:35.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/O0KIjkpY4LF7nqP34iB7I/czulMmb4HEhUfWHD5faxA4V59Cu4ejkx+N+1X3W2hl1I8UCwjZqO/OICQK/3QEtNBbZSolUUaR2ghLF+8eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_09,2024-12-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412040095
X-Proofpoint-ORIG-GUID: ilqs0GMteOnQJ0NZh0hH5QbxOnrIgwD6
X-Proofpoint-GUID: ilqs0GMteOnQJ0NZh0hH5QbxOnrIgwD6

On Wed, Dec 04, 2024 at 07:55:16PM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-vma-move-brk-internals-to-mm-vma-c/20241204-115150
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes%40oracle.com
> patch subject: [PATCH 1/5] mm/vma: move brk() internals to mm/vma.c
> config: mips-allnoconfig (https://download.01.org/0day-ci/archive/20241204/202412041907.3DXYQrz6-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041907.3DXYQrz6-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412041907.3DXYQrz6-lkp@intel.com/

Thanks for the report!

Seems to be missing a header to include/uapi/linux/personality.h which declares
READ_IMPLES_EXEC, however the standard means of including this appears to be
including linux/personality.h which also imports this header.

I have sent a fixpatch separately.

>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/mips/include/asm/cacheflush.h:13,
>                     from include/linux/cacheflush.h:5,
>                     from include/linux/highmem.h:8,
>                     from include/linux/bvec.h:10,
>                     from include/linux/blk_types.h:10,
>                     from include/linux/writeback.h:13,
>                     from include/linux/backing-dev.h:16,
>                     from mm/vma_internal.h:12,
>                     from mm/vma.c:7:
>    mm/vma.c: In function 'do_brk_flags':
> >> include/linux/mm.h:450:44: error: 'READ_IMPLIES_EXEC' undeclared (first use in this function)
>      450 | #define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
>          |                                            ^~~~~~~~~~~~~~~~~
>    include/linux/mm.h:453:55: note: in expansion of macro 'TASK_EXEC'
>      453 | #define VM_DATA_FLAGS_TSK_EXEC  (VM_READ | VM_WRITE | TASK_EXEC | \
>          |                                                       ^~~~~~~~~
>    arch/mips/include/asm/page.h:215:33: note: in expansion of macro 'VM_DATA_FLAGS_TSK_EXEC'
>      215 | #define VM_DATA_DEFAULT_FLAGS   VM_DATA_FLAGS_TSK_EXEC
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~
>    mm/vma.c:2503:18: note: in expansion of macro 'VM_DATA_DEFAULT_FLAGS'
>     2503 |         flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
>          |                  ^~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm.h:450:44: note: each undeclared identifier is reported only once for each function it appears in
>      450 | #define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
>          |                                            ^~~~~~~~~~~~~~~~~
>    include/linux/mm.h:453:55: note: in expansion of macro 'TASK_EXEC'
>      453 | #define VM_DATA_FLAGS_TSK_EXEC  (VM_READ | VM_WRITE | TASK_EXEC | \
>          |                                                       ^~~~~~~~~
>    arch/mips/include/asm/page.h:215:33: note: in expansion of macro 'VM_DATA_FLAGS_TSK_EXEC'
>      215 | #define VM_DATA_DEFAULT_FLAGS   VM_DATA_FLAGS_TSK_EXEC
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~
>    mm/vma.c:2503:18: note: in expansion of macro 'VM_DATA_DEFAULT_FLAGS'
>     2503 |         flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
>          |                  ^~~~~~~~~~~~~~~~~~~~~
>
>
> vim +/READ_IMPLIES_EXEC +450 include/linux/mm.h
>
> a8bef8ff6ea15fa Mel Gorman        2010-05-24  449
> c62da0c35d58518 Anshuman Khandual 2020-04-10 @450  #define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
> c62da0c35d58518 Anshuman Khandual 2020-04-10  451
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

