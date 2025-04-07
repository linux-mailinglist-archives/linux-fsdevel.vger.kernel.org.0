Return-Path: <linux-fsdevel+bounces-45869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED03A7DFCE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 15:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDFA16FC2B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669971A3149;
	Mon,  7 Apr 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bB3m+bEm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HFrkEPZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077318BBA8;
	Mon,  7 Apr 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033286; cv=fail; b=tzEVA0GIvAXHChDedABNlzmUgHbET7wR2ahvLM3DL/gqMvh6MTaNImvYZvnLQFKh5MsvbUUOX78slR12lzfApkvqMXNzJvEGqF1gnenHEFcIKod3GOfVWh3Tw2gC45K0Ko2ytIG1d75LvUnooWfklYuXp3W4MGgReFMkdd1lWqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033286; c=relaxed/simple;
	bh=N26JwSPyRo3exnvGkAnP5eORxXZWR3yd6vH5iC5XU5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rWxvE24IVrZtgGFMD4x1Y1Up7BZqxhRZyoDR1BxxDVbuRxK+xSKitvJYcfiziHlpJbrFqDeW8JTCja9CUjOQz5naJ/9Z9IzVreKZwf4yEOjvomf4eN/+MU4cKXdyZy3u+BeL2YpkK4PczXXuBv3K4uUfHP0pGpoFItWiCQSh+mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bB3m+bEm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HFrkEPZQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537DGwFh017921;
	Mon, 7 Apr 2025 13:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=NYxbchvmXcCWsYfxm0
	0aB1se7WL5XVV2SahuG+t+O7o=; b=bB3m+bEms0NIlbq4LQrOYa4W/oPF+V+xJ6
	eINUBjEK6sV4fsk7l5qN80Wvb0Q+OBqVWn/qGIDqBhYs04/Qiv/683mJBiMGYj5J
	IduK5xYCtpSN+iUEZkDqz83nE3EsmJdsCdiw2ztCuJD2poKntTIrS84ux0xojSBF
	65hA4LuPjHKTEvmNQN7+oHbhGc0/H/R48Zf24Gb6iEdnzyItAsg8t2TtjQmRL5Kt
	5IDQiwXORc2ZVfNQF6VcB8qg1CyJ0Pq03or97ce/NX5vp6dqL7yiHIwPqT+F/k7h
	axEIStSP+mniaHUd148sQ+nkqTQisjB40xwuITV/ypaiYBiVI+LQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ttxctmkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 13:40:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 537DWuBo023777;
	Mon, 7 Apr 2025 13:40:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttye27h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 13:40:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6Qh/bU/dsfIpPdgxMmf+Z6mzoYc0I9eCx/2ud5hQkFuItOA1CUugJNn3ndnTJpQxaS0MaiB7tgQINHNV435z/5ZahAfCEM0MUSjFB8dFkELicMor22wS0akiCXyV5cq1ib6ZZ6U2Bh/s/o5fdgTYDaVovgI6dtVpauXoNW+uy2jqyhcXd44kenG9t+0/GfIJNrakRTJShNB5n3A3omXfUqhNdrx4ps6wihazMH7KAYqUVz6gTFk6CPg0hJ0XETT0t/Tzvs1TH1kXoEn58qYOUiU4YQQPgmQXKaBbqqba1W7Yg8ukMxRg9CNc3s90dBFZqNEuV4z30JK1gCoBkVTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYxbchvmXcCWsYfxm00aB1se7WL5XVV2SahuG+t+O7o=;
 b=hZ0zCPUFducT+LJwEM4PWBvXcLb//k/HwxEvkGnnJmMGCY3heKJ2ERzG5wyDw/jz+GzWem5LPFLVi5J5nI/IIEjwps7UwXHet/7Bu6Y6iAbszqf+pNuYQKt1XI+fjQh2uyo2EbbToUxKJFUAHtM3g0K2t7WqfZN6sFnBVr/b3AWeIDVS2v0NSrcDVILtU2xwCGnTzKVodXL2UyEdaSb0WHvekLn3hYXfajTVUH+xWeR2ki/Xs3QmnHxp+5fJxBGnuCfjqp2taHrqxVHWOXfur29NCN1ruMNojFKljwiTDUhCQ5cndF1dWCjhNc+SQZWk6TiO/q6jfsAb0zGLmE04ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYxbchvmXcCWsYfxm00aB1se7WL5XVV2SahuG+t+O7o=;
 b=HFrkEPZQMbBR/t6Iczt29FY+7tBU4AbgaZuus8+fMrShFWt6HOWEfFiXU/ujDdPy1k6Ujm1VuNHtsOgkI3yXV7L9RI+LFBBhR3ICSsxCv/KSQXQ+33JP6SpgyMrepVr7YDb08GuyPOn2EKw4jP8XDFbDHR+ycDyUwey+dYnP0pw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA4PR10MB8567.namprd10.prod.outlook.com (2603:10b6:208:566::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 13:40:56 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:40:56 +0000
Date: Mon, 7 Apr 2025 09:40:51 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Fuad Tabba <tabba@google.com>, akpm@linux-foundation.org,
        pbonzini@redhat.com, shuah@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, muchun.song@linux.dev, hughd@google.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz,
        lorenzo.stoakes@oracle.com, jannh@google.com, ryan.roberts@arm.com,
        david@redhat.com, jthoughton@google.com, peterx@redhat.com,
        graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk,
        derekmn@amazon.com, nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
Message-ID: <63j2cdjh6oxzb5ehtetiaolobp6zzev7emgqvvfkf5tuwlnspx@7h5u4nrqwvsc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Ackerley Tng <ackerleytng@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Fuad Tabba <tabba@google.com>, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	muchun.song@linux.dev, hughd@google.com, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, lorenzo.stoakes@oracle.com, jannh@google.com, 
	ryan.roberts@arm.com, david@redhat.com, jthoughton@google.com, peterx@redhat.com, 
	graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com, 
	nsaenz@amazon.es, xmarcalx@amazon.com
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <2iggdfimgfke5saxs74zmfrswgrxmmsyxzphq4mdfpj54wu4pl@5uiia4pzkxem>
 <e8abe599-f48f-4203-8c60-9ee776aa4a24@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8abe599-f48f-4203-8c60-9ee776aa4a24@amazon.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA4PR10MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ee2f25-88a4-4565-7514-08dd75d9d2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0xNlX1495MQK+JwLU2C5y+05g9SxJG3vyxi07Np4Co60GRAp5zOTGRtmUeY?=
 =?us-ascii?Q?Vi8B4YqAoQ9eIu5Q8+8ufy2VSwtI/a204xI8Ob8guJpwap4T60YY39iWxuT7?=
 =?us-ascii?Q?ytC50U1JpEgahxsCMmibEh0v4Is5sPkJlJQMMJI95W0n1JYhDibXSvldZUcA?=
 =?us-ascii?Q?aLvebx8JA4LWKB4N5JfgisiE9PXdL5Ns4dRkEUYa06O+uRb8Z3O+8+9fR776?=
 =?us-ascii?Q?taRxvqXZySfv0rFK3u2F7cC0VhMWGng00hM/Dlmy6SipDgcxwYdHubSmqIbS?=
 =?us-ascii?Q?ewArkLCH/F1AHPWjdXgHyK1hPgCcU2XWB9fNSGk9gLTZlnv69aSZWmTZcdY4?=
 =?us-ascii?Q?pJ/ZTMjM0+a45PHcQNb+n83vwkXdwf5T3IJjiesbup8QPRqIE2dg18f5SDRL?=
 =?us-ascii?Q?raxY0ncM6xbHAfrcgXKEtq/ZXmHvbfFBFt6NO/JzUjrJRlcBvn/2xraMQuz8?=
 =?us-ascii?Q?RppvPw991F6fSCaE/LarLT5n+7aeB5KY/kdo2OoZhbknkpvdlduNL4IxWojt?=
 =?us-ascii?Q?3gywobNLbmlU8MqYAp00oO5UWgsjTmOcPHQJEu3ezHztsFoHWNW1w6ZuDqgl?=
 =?us-ascii?Q?CcFv7sM6HOEbssoqfTQApW0LVvBDvAof/IFYJbfMrHWi/IiLYzC0Zm05xykc?=
 =?us-ascii?Q?t2AUAOfLqEsG9OBEZmKm0OAuEohZpYfSmsHH16QqH5xxXJKqGEU9/LPQINjn?=
 =?us-ascii?Q?0MH9TYxyXsMVFpFRcmmy/m7B9JGXtCcLRzTwjZQnrzoceLUCSp2qQtDEKs00?=
 =?us-ascii?Q?pb/dDAIGhnf/x/Evj7tT56zh331K7pGhyvfz2AGvWaBYwZhWzjuFVOgeWFy1?=
 =?us-ascii?Q?agbK5LGOkRQGiD7MZAAaF5Mg2QGdaX+0+4JHy8LhvHeiOQHKEA3ZADhlKPNa?=
 =?us-ascii?Q?5istO2NIzSdvHBvRS7puex+1lzA86eDUHZ65i3pZ/PqCBVts4lX08UvVBq3E?=
 =?us-ascii?Q?RdSewpQBJ9qEScXdxfP4ktXtyXeDh6b0gaHBNO1FUW406oYjmxQK9V6PyWU8?=
 =?us-ascii?Q?tT58Pjt3alZJL0du7jgtTdNu+FfwgUSDcpyx+yJDR/iiQthdVnRMzwhzznSM?=
 =?us-ascii?Q?hnd7Q5HC/r6IB9xnXELAaUzLgLyWZXV6FxK68/QOo5tmpCcW04ZyN9drk3wS?=
 =?us-ascii?Q?Ef9PY8iGarGnjPHLFdYimHlW8sVI7YPktc009PEpS3KGiwaBl0QMFyYy1HuK?=
 =?us-ascii?Q?k83QvqAV0P3/yKY1FhlGKK/MdGzhqnvFZZGhgvkMZd0puWX8zJdoL+j/ones?=
 =?us-ascii?Q?YGQUhnmhMfAy13EoYj9QZxPwefyEPXRrqtlHycXZWXTdkxFpHBOYNryN9kE1?=
 =?us-ascii?Q?6nurgEqv9KWcVKsMWq/1JolohH6NiSV8lyiy/Qrt9o+YUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gi/apUE3QahVq0octWq0rO8ShLrrDanmtj/amKb6MLVZG5ck0IS9vxIsU9kF?=
 =?us-ascii?Q?DWY8xtSpBKIYLOsSjV7D6Pu/HxJo9+Fne18lVpjWFyvjbdifoIt3ELuDiCXW?=
 =?us-ascii?Q?qsy6GmbkGb4unRlAASySovugSAMZyhaMZHxW300EHN/vJPb2derGeg381zi9?=
 =?us-ascii?Q?S0dceXJ18uTOEfEftjrj7yqbEqJbD3tJWaSQfWGJ5x5vcSc7w2YpB/eEtCNs?=
 =?us-ascii?Q?BzxMJvLad36GUUsxypijK+NdgbR5HpvA6auT6MyQZ6rwMKhse5ZbPPSjxGsl?=
 =?us-ascii?Q?0d5S/5OFHJmFAaH3Y/DtmuuJRXvocIXMQ3iDUlFrET4luQjaPrObu8PjbG5b?=
 =?us-ascii?Q?icCDRRu21TxkIwJnQpfMBm21VTAq4KSamuFDV4Q8e2EPXa5WjphMHxzUzyv0?=
 =?us-ascii?Q?oTSro9jAGnjTepboHN9n98IiLlolW2I9r5VQGcNiOOcYFpWQN3Zda8q7TPiB?=
 =?us-ascii?Q?sMgZmOvgRlBWnhGZgkeq0CzTSWZWTgVYfQh4Ng0KrqFPLwj+ibSYb5ESb2Qr?=
 =?us-ascii?Q?wBNic1/nw86Q/qTVSkLn5e/XyRQUxeP6xwm8lq3yebagYWTt0bLf2rmDpevC?=
 =?us-ascii?Q?MxkYU4jZSx+kr5U9sHDx7hLO70Wubbo41zhnIh+t8bCYpm2P8Usmz8hGtwiv?=
 =?us-ascii?Q?7BrG+7yAWQ4M81eKERjYKw6GHLJczBQjdQ9tiS6Hed8bp6LKP7Cpf29OVyA8?=
 =?us-ascii?Q?ms20uahpA9j1OYpXnXKt64gtn4kHnoCCFILvwG19H4ExnuG6bsnjsjiUBoAu?=
 =?us-ascii?Q?DQn5VE5zUTOSRkHSV+BCQccU5BEzMv9k64XrNGSttD/33YxKZaxQD5Xmle0T?=
 =?us-ascii?Q?+tMGiPIFL7qU5BDTkh28AgXbvh2XO4wUoGlZmiVSXSllGPd+aU55uhBrIssl?=
 =?us-ascii?Q?yoNKmxAnVZDk5VIL86oB/eHjZDAMcWHanAKhYDb9Hb0qw8cW7ym4HS5K7+u/?=
 =?us-ascii?Q?UQ0JSwZENc38jHZSSAG1WiRltDiA2QiLtj178HjgpQo1Ftnuf0Of9LTnGloG?=
 =?us-ascii?Q?TqvU/cJWNqRAxUFvOKSniJtXxWkpN/8o7mfmgkpr/CqWyxQAsmY8+Ph0zoNv?=
 =?us-ascii?Q?ByUZ6Z/INGhCkGPf3cTxnslFtIpPMSU24JSs1yKPrrWH9d9Tatb2+WCW01Al?=
 =?us-ascii?Q?fkNFcxI49SxRtWZvEVCfmMh9j4vT4RvHJXcxYmaq6xlmlI5JIoTKZWBsDOzL?=
 =?us-ascii?Q?BULN9Wdp4yYU4hbW1lA8mPwZAVcrEIXq/l1w/yu1Q//djcW3/tTieKFjlCul?=
 =?us-ascii?Q?FNPvXeJhqeULz+VwCWjSahRlxgBS5x1G7N3ufgGZxQaSD9ljcWsLuO317nD7?=
 =?us-ascii?Q?Ne1eqX9Gkh6yFr0wgLTBSkLFIM7dWXwP2gl0IKpU16dXUp1c2KNw5j3LmyVv?=
 =?us-ascii?Q?bf/ofwb+6W8L4ObkN5et6zn9tH1aFQzxxgVLj8mfT4712of1ouQsA/cUFEbH?=
 =?us-ascii?Q?gd0sCPEDc4IMviTSqPpmIoFCdNzGIsI1b5uU2VEJDFld4J/Qi+SIIclB5by4?=
 =?us-ascii?Q?FAIXc1CDqhvqqz3mPjostcs9wLYEYuVgYdOaxHhEhISCcKyHC7ZB6g0wmBI1?=
 =?us-ascii?Q?CI3TV8/cwV0SGd7eo16VySiyeM/IB7IaLm4SufiT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zdf40WLelaB+a9L3W6ii5vPbXWeW5B200yDptsCGRaa0ARJmfDG6setvB2zhvRSJNPqwiaEy6AYVSorxE5QeJ9VehfRDwqXY1rWKxlxBSX3HmQwFGBk/rdNNd0Dy3WtfwcHJgAtQUREkCF9rRcAbHV+SXLBgpaxfCBK9fRhPlyQoLk/okm+SwXolbHL/1OESQZreEhWUsfMrnsBWInmEu4xF7mFqMvZyNUW1eRNbMfR57DPPE2NKudmTPF+Qv87fMOm9/YHV/wbuFlINWPjQfx3yU4LNoI/59CwhIsnfKPy5xaYszJm+mb33yyDZN2OlfRqfgYhjcWz5QtZ1IoggaKbPNePANa9NPcS0RWB/kEDaDFAiRM3Q0adWthF5JX/eDYhruX/G53bbhTtC3ZMHJ/CxaunSh84i529ayiWdBW1TrPa39am/tEy0879ToiEdR2YEongGCBw/K+glXfCZFD07qpGvUfjtwtOpJHrRyx7avTSL09A2I3t0n91Q/HlRC3nZApfxQxfF2RRDUaQo3BDY8H2PHptO/bAPUiGXY7Zyy7MJziICjQJ+d4qj59A8QPfivAvSv3nrXka2fdJmhfFTcvflNrW9dRJ9xO7fE+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ee2f25-88a4-4565-7514-08dd75d9d2d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:40:56.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YEzlx/eHqdUm0nMTSS+OYrKTGhgjRQqasls2Nq2GneqhzabnBQbLbV2M+EXNPTyGxDQ77qEHQall0pcT+OOVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504070096
X-Proofpoint-GUID: 5f6Qd0kkScLmZK1wjL087jElsCItVJN6
X-Proofpoint-ORIG-GUID: 5f6Qd0kkScLmZK1wjL087jElsCItVJN6

* Nikita Kalyazin <kalyazin@amazon.com> [250407 07:04]:
> 
> 
> On 04/04/2025 18:12, Liam R. Howlett wrote:
> > +To authors of v7 series referenced in [1]
> > 
> > * Nikita Kalyazin <kalyazin@amazon.com> [250404 11:44]:
> > > This series is built on top of the Fuad's v7 "mapping guest_memfd backed
> > > memory at the host" [1].
> > 
> > I didn't see their addresses in the to/cc, so I added them to my
> > response as I reference the v7 patch set below.
> 
> Hi Liam,
> 
> Thanks for the feedback and for extending the list.
> 
> > 
> > > 
> > > With James's KVM userfault [2], it is possible to handle stage-2 faults
> > > in guest_memfd in userspace.  However, KVM itself also triggers faults
> > > in guest_memfd in some cases, for example: PV interfaces like kvmclock,
> > > PV EOI and page table walking code when fetching the MMIO instruction on
> > > x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
> > > that KVM would be accessing those pages via userspace page tables.
> > 
> > Thanks for being open about the technical call, but it would be better
> > to capture the reasons and not the call date.  I explain why in the
> > linking section as well.
> 
> Thanks for bringing that up.  The document mostly contains the decision
> itself.  The main alternative considered previously was a temporary
> reintroduction of the pages to the direct map whenever a KVM-internal access
> is required.  It was coming with a significant complexity of guaranteeing
> correctness in all cases [1].  Since the memslot structure already contains
> a guest memory pointer supplied by the userspace, KVM can use it directly
> when in the VMM or vCPU context.  I will add this in the cover for the next
> version.

Thank you.

> 
> [1] https://lore.kernel.org/kvm/20240709132041.3625501-1-roypat@amazon.co.uk/T/#m4f367c52bbad0f0ba7fb07ca347c7b37258a73e5
> 
> > 
> > > In
> > > order for such faults to be handled in userspace, guest_memfd needs to
> > > support userfaultfd.
> > > 
> > > Changes since v2 [4]:
> > >   - James: Fix sgp type when calling shmem_get_folio_gfp
> > >   - James: Improved vm_ops->fault() error handling
> > >   - James: Add and make use of the can_userfault() VMA operation
> > >   - James: Add UFFD_FEATURE_MINOR_GUEST_MEMFD feature flag
> > >   - James: Fix typos and add more checks in the test
> > > 
> > > Nikita
> > 
> > Please slow down...
> > 
> > This patch is at v3, the v7 patch that you are building off has lockdep
> > issues [1] reported by one of the authors, and (sorry for sounding harsh
> > about the v7 of that patch) the cover letter reads a bit more like an
> > RFC than a set ready to go into linux-mm.
> 
> AFAIK the lockdep issue was reported on a v7 of a different change.
> I'm basing my series on [2] ("KVM: Mapping guest_memfd backed memory at the
> host for software protected VMs"), while the issue was reported on [2]
> ("KVM: Restricted mapping of guest_memfd at the host and arm64 support"),
> which is also built on top of [2].  Please correct me if I'm missing
> something.

I think you messed up the numbering in your statement above.

I believe you are making the point that I messed up which patches depend
on what and your code does not depend on faulty locking, which appears
to be the case.

There are a few issues with the required patch set?

> 
> The key feature that is required by my series is the ability to mmap
> guest_memfd when the VM type allows.  My understanding is no-one is opposed
> to that as of now, that's why I assumed it's safe to build on top of that.
> 
> [2] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/
> [3] https://lore.kernel.org/all/diqz1puanquh.fsf@ackerleytng-ctop.c.googlers.com/T/

All of this is extremely confusing because the onus of figuring out what
the final code will look like is put on the reviewer.  As it is, we have
issues with people not doing enough review of the code (due to limited
time).  One way to get reviews is to make the barrier of entry as low as
possible.

I spent Friday going down a rabbit hole of patches referring to each
other as dependencies and I gave up.  It looks like I mistook one set of
patches as required vs them requiring the same in-flight ones as your
patches.

I am struggling to see how we can adequately support all of you given
the way the patches are sent out in batches with dependencies - it is
just too time consuming to sort out.

Thank you,
Liam


