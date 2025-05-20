Return-Path: <linux-fsdevel+bounces-49481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C8ABCE94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 07:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121597AA90C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4906625B68D;
	Tue, 20 May 2025 05:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pM0GUTh+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b/m5If5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC925B671;
	Tue, 20 May 2025 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718673; cv=fail; b=K9Wtz+t/4Dq3t3C0LBuCtyoMC/oCn/KkI2cdEfddeinatnOh0YJNe2IEalDgqp2z9pll71IYda8ZqxWq8itDaOUaMHtpqKZlkX5cEEWfznULyCnLYz1OmMoVuoSZm9nvBDPC5TL37gXIqR6ZiPhrwJxfwu+K5mYKzaoNYYo7Rco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718673; c=relaxed/simple;
	bh=2mmDs0gsAL4iJophooDHzttQvG/o6ZdViLck7PaR9Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T2/oTkkYWDoJrS/v1IUBDWMFc7ZgrQ75IcH0GbPnkbZBtdGhUazUOCPqQIiYl9a4mNIz5bPkOM4gMZYgR02kLpxf8RGI8Um/8UF/2oAnKhnLV7O0fMgoLpsM9nWhHVI211pucl5OAsiMlUUEVwPzPfuOo+Drbg5fi2dk9w5T47k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pM0GUTh+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b/m5If5H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K1NCwS014431;
	Tue, 20 May 2025 05:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=X3zrqIVPGC6S+Jibyw
	yPQGXQdbJCiTgsrxfMK5bI3vc=; b=pM0GUTh+SC8j5ZAVKzId0Jd6mBkXYCHzbV
	lceUM0pdqVfOObQDjTunMDMvIUFxYYZcDqXEFg2BBlYTKd4ntN03Y7Jc8CPI3gFM
	XL5xz5l6pdKWpRbd2DbBpydPT/gcfBTgY3WUJb/5os4+bd+8+bHuS5akfPW5X3rr
	i1USwbn4dyR4jbvicn+0L/49pgpErp3nJ+ClVQkgjXt4bxi6YMLtQUke+hneKoAp
	rYH214/GU7UK2USfmMjHHwQyS0OhX/WIvottTx81GmIgFBY3aRv2TbUV3o2oTGi+
	Pa1/6xGKn8tQEFZvXXP+2IYuZqiAQ8FDvD/BGFAUf+Hyj04N8cBg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pk0vvfdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 05:24:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54K3LL85000889;
	Tue, 20 May 2025 05:24:13 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013076.outbound.protection.outlook.com [40.93.6.76])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7hv1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 05:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXTKqgO6xC1F+olhTvG0bW+HWOY4AY1itDcR3GBXB4TL7h1G9B4sHfc7hNnpCXcC6Wt1wCZ0ATykUaMhXeBnCfoi+MTLE1y4CN/1FgCs/nNAiar4j6ohKoV+WKGo1D6oRJLP27g332eeWhWwEnOvCUtUXJYzKJ4/z88814EEbaeANquOMI9m6a4nOocJZTvHueNyU/av0tI1HMea/DsF6V+XFuPcnzRlRfjEh+U5+kq4qDMxHKejC/q4z+7x12QJZrRT8fmVh6EkoAGx8oJTNfPxJMI5XiN8rs7/R7nFldNIQolmcgdqFAKFfQ+19UsxmkJmQ3OiXeinzw1azj/TRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3zrqIVPGC6S+JibywyPQGXQdbJCiTgsrxfMK5bI3vc=;
 b=Pi7aZpcc8TPkYzCTP32NzTbqtTrrYhj1ZVGLBy7K/svrAU+lQQWw7FaTpxr2zvXxlnRq8hF+iVqHhWK2MSUbVXuJ7YOaAawQObzvgfYLERLawuE+3T7yz4usIr+xNyZwsFwWnsbNiMo+rvxtyIcRGGcspsS4GA0fYsVlvxuP1sqCuB9lqE6aSuI3pmgyCqgpfQ2nJrtUiBws80Gp/LLS5pjCuVU9ZT/FgC/9IrjmHCkpL3asaXr2Ws327KX7NXUjSY4KUak9EWgLXSSKInmAWZvpH5k1H5ngSFTVtMWzVYSpkBE53KTPNjm8t59VPzydrZSSWA15uFL+OFZsSQL+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3zrqIVPGC6S+JibywyPQGXQdbJCiTgsrxfMK5bI3vc=;
 b=b/m5If5H80voJTr2hjJ2lk45t1QNZyYqZMUelFVXAUF4VkJOqJTW0NiNdz7iH0lmVlbHxffsUwxb0wsUiC8KoKvGmrtlJUJi2yIdLUzq+k6azQG9/zT9Vc1xbnrpx+rFVLnJsuB1OmNDEaRnU4Z04sWIba3wSoVA65A63ABcWF0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6796.namprd10.prod.outlook.com (2603:10b6:208:438::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 05:24:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:24:10 +0000
Date: Tue, 20 May 2025 06:24:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
Message-ID: <0227853c-859f-47de-89ee-09594dee9172@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <ac4301b5-6f82-49f2-9c71-7c4c015d48f7@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4301b5-6f82-49f2-9c71-7c4c015d48f7@linux.dev>
X-ClientProxiedBy: LO4P123CA0536.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: f9580ac6-90f1-4474-01b8-08dd975e8cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+HUcljWElNYqShQSXdwQfabMe2o6XAHf030puf6z+YfxKzPXYyQjebLqmYy?=
 =?us-ascii?Q?kN3Gt0qew1kzKkU9cpyeUyMQPimiltm8KQuUMYIBo2aJFRjwWD2LpYI6OMar?=
 =?us-ascii?Q?huAd8HkDcblXJG6FxJItwaHm8h3KZEHun9msBBKHtOWmTMr4Lr3EyvNORIOT?=
 =?us-ascii?Q?Vq4Pa8QaaGycg6PYNYq5xJRZ/DDL4gdt+jp0b2GKEv3c+N8aaJLjBVN2N7HM?=
 =?us-ascii?Q?njiV8cOX+JWQJIsNnDLwIoMcyN2KzJZ3yEZup4w1TJTS5w55EX8QQ37Oxgtl?=
 =?us-ascii?Q?p5bWK8KMfUTxOFCGZPVanLVsoTBENJqSvkhBRQfFm5Z8lUsrdyLlVzwP/dta?=
 =?us-ascii?Q?Khmcri0uwsBRTHmxbWK31oWDwcr6Gm80RjblWGXbfKBsH9rhtUw1Zt7WyFLN?=
 =?us-ascii?Q?Gyb68rbFsknCAAUWecsdd8PfoCztGqBJGoUpD8HhoqAgdH5FegS8IWZlsIN9?=
 =?us-ascii?Q?6EsrIHD5JRhLxU/t6JHYFAkFMiPgA4lMaUll4fcSADeB291nWwFK/FI3E6rf?=
 =?us-ascii?Q?AhBwiGwBRMRyJo/WN1PK+GI3vRfVjBzNKlet1Lxo/oBE7A5+/V9aZlBRaf3F?=
 =?us-ascii?Q?izlcBwTgKvjjtOmobzWkrvI+4cSJShulMh4ulCIuspQohvkSPU//OwMTxloG?=
 =?us-ascii?Q?wsyNYz7YpSTT1B58RSepsnKbaJ+r+O8VyvX/koYsdVNIvtGvPUJmzkeeaGJB?=
 =?us-ascii?Q?nRiGYSFh8nX7sKut06H6JtrfuhlGNgJMlTTjroH//W2DgRfVs1I7aifYJvOY?=
 =?us-ascii?Q?Ui4Nqu9D9rxMWMQrwb+YR5xDPUqQ48kOw/8iO+KJxkrLkSBDxslyNLjVaTLh?=
 =?us-ascii?Q?1RrMF8DmLdSvENHmEjJRi6+j4LM4eQSk/Zr5k0t+kYQaeLs73WBwdaUNAtIc?=
 =?us-ascii?Q?73QE4YEn2XBRb/vihz5zuLx4evdZKNivWhNs4QJILpgcNYcaj48oF9E7vASu?=
 =?us-ascii?Q?YLIIse/oKfBjLfCYHjvbpvEt1FdoyipeOV4xOookzgRPVTBbPONXo5u9n8ZB?=
 =?us-ascii?Q?JYMTRVzSr5rZiRYpzRgr6yXz7yXEefedwaUiE8Mw8qs3qEsLFeeIu3Stuey2?=
 =?us-ascii?Q?kjyZfOpyYDU+nNPoPJUMqfCZ1DYlNOScnV1l7/fE0KFAsD5QL+9lTMzepz5F?=
 =?us-ascii?Q?2vmiPsPyIvLLDBYJ4sjWYgpKjxSq1G7sGbqaD5wvps0c4HdP3uS159afbKg9?=
 =?us-ascii?Q?njJMmfcbk9KMHskZh3Iw7T+EY0mdC0VHa8UC1YBHcS5NnszH3TWZ8ZG+rITJ?=
 =?us-ascii?Q?tqBgXgM7WlelXwi79bgbP/hDfaH9GUNnQQyHBbIrHhLn7Ki4enrwF9ceBkiN?=
 =?us-ascii?Q?UlenLAA1xaNbYe6+9yVyiv7uV8UcH1TvtfwK02Jm09tfvt0n3ACDAGJt78n0?=
 =?us-ascii?Q?IN2h4+ieLTQfKnjdQYxWeLAfl26oiRf2BswrEH3gbTNSOAR4YNHPsK+HWZzM?=
 =?us-ascii?Q?WJgshL7Vv9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K6/2zGkLyUjCQEry+dW4P/8So/voFHdqzzc+S2iKLDOXiXAmZNMfDaLk/vGX?=
 =?us-ascii?Q?bbO9K5upwq6mAE/Nv51kk++Po0SAppMbRGRqxPWDecWJuqwy05VC6pI5VUNU?=
 =?us-ascii?Q?EBpYEP3HigyPjGLAGDTq2jEcDxhHzEEg6Qs+nsJrsva+y2f+hFFKicgPm98R?=
 =?us-ascii?Q?PAbXBBHlQ29O6wK2sR3Mnz2GWAMKBX28wLGPboz/TfJMc3hsDKZX9fwd1eRF?=
 =?us-ascii?Q?2YegZdj8LenGg6xqExwsm8nbRJnmZ0QUqm0W95ePzlfYS7QA3W2ETp1j7PJ0?=
 =?us-ascii?Q?tkPmYpkts34wxHBFu6k07AYW22/4jl+gJ3RnW6csRzeTl+t8ZkkLa5leKVkh?=
 =?us-ascii?Q?IQOfax2ssP/LQFpDS6zJHF6Dbgpnlnz7T709TA5Z9Qz6OOSFkRBi243nfn2E?=
 =?us-ascii?Q?Wkm+if6uzFfjkTeMykywRzDZvgX0kyz3VLIv56MewLfy+JWjCmb7b9DUeNeU?=
 =?us-ascii?Q?bH4KFaGZmbCkajSHc8KKG+kPBKg4Sef2o8Ai/gGBmZBuNAJZMsrL4lUzrMQ3?=
 =?us-ascii?Q?mlDJ1quqZCGphIo5IVt1/m42TNXVkOLzyce/wXIfq0irZdaDUeUGtGW4iZJy?=
 =?us-ascii?Q?cFhciamrtxSNt8qfgSCmI0SKU7lL3tbX83O0tESosnrIgtpMqY9u+QEir9FJ?=
 =?us-ascii?Q?4k/Ti6zBYiJFDWt8EEYcDlMilEdv6YnbuYUCQtTRHfgGqMd6kH7Ym3YEOKay?=
 =?us-ascii?Q?yD6M76n/tC9qEbaMtLvH/bc5DU3WDrpNVAfzONYvjkApkEPHDvuGjjBTJjNM?=
 =?us-ascii?Q?IdtiJvZ2/IA4rhBVUjCxaPwN3iZBJZU+bmohaTFSGAOo2IqUdASa6bX9+GO9?=
 =?us-ascii?Q?3KmYN6HUfSHztCwZoutYD+KPQER/oBUyOPLF3doSM7aRFZMmqQ8FYxHwEVFh?=
 =?us-ascii?Q?piPb3wPbz1F/z4ar48t9TOXQOGERukuHfQB2v1dIyA1QcjeUdTB0xoshxh4P?=
 =?us-ascii?Q?nbVWNZOI5ghoRiLOMIOZ4TczvrnvwVbB60rRC0Z9V3BSmiV/R5uQCdFRT/9x?=
 =?us-ascii?Q?KyBmLeDKUcCybu9Cnt7pXrH6UD9u3oCMNLg86jkAR4RJmPrLJ/OOdafWQt+M?=
 =?us-ascii?Q?xZFGXrgs8G7rgiLTJbu5wq7DOcsQutCkkdrimvXbTTQYvVHz5ACGTCLYn+nM?=
 =?us-ascii?Q?gsNpOVvaH5GM76eMIGJ4NO9WDvYQens1q2vOUeEnEbeNnLYa6lUqhCroGSoI?=
 =?us-ascii?Q?OdBxYUl0Y1L/Fa0EyQkjjRI7PTND/832NACf1KuCGTLiMHbVBWyHeOE9pa+0?=
 =?us-ascii?Q?RE9DOnaTl8wUPLc7E5b6QLdjMroyxAxIHhcWJs7FhmSg23QetZnyUHl82DLt?=
 =?us-ascii?Q?SC/yBfklD3p6OZ5CxHF/59dBvW4ZBwSNQrtNh2GXWk9Kn8rzLxvCy9bhpmCk?=
 =?us-ascii?Q?zTChP1a4TSlnPWBYQGCfTPGJuOI8bmNwqNEOpQ5zfVyFf3GahsMDR5RjiS1k?=
 =?us-ascii?Q?ZEKwau0v8z+DuHJWVr68QdWWq5zBaoXgw6ht/sKOcu1EjZWuVIY/nQfIIAPh?=
 =?us-ascii?Q?NptPYflYPVckthE0nFqaa67MToD+9wA2Tan5Bm+J/VZp0TudLdj3yiGGbcuV?=
 =?us-ascii?Q?s7lM0qgzmMxXzZCyXvfseUED78d0DH4bShicNIqf85i2Jy8m8svH/Wc8QLn1?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3cQ5R/uzZfWjUkXhrtHAOQX6+NAnhll0EU3s5wbamVRVDzxo+jZzfzjXQo1q6UAKfwSuWcT+VNjaMbqi9ngn6YSiKCjHkAVST3aNSQAssUk3gqbkWtzx1JMc6CuUtX/3r/sjdANQdrkk7xmmfap6dZmpxY+fuRPdFaiz8mPK+wEHYvEBrbRgpq8nOuJkGWMpNCOdMmV4MJDUBnXRPozUn5Zo7xiBpl3YrDqth2mMq6eyZZJwoHPeeB1McSCzkm8aIbMbF/0foDIChFVkh3e9WX0P/vNwhDOnYX1BnpAqBs+YvDJ6YPzwDoeC1bNXiW5M3gIxxD3PX6INx4WfdD/0IhxqVUY2ae3G9FpfshEeKxRV2Ntb8S4oevUBd8QXWyyQ/02Czob+Z+4o7gU1Roi82kifJiNzmS3rzRfFpVQf5wTrMntgJNEHlX1kKfZArbLf/tpRpnB+fd0eJPDmNTgS2rdvlynPjzmPyB5ZspyOkgkBMzp+bQGm+YxQghVzDTGQR3UUnEavojOuLHF+JF+7Z2hAM3/UtsVT/gZElohIubH3Yx00J19KJeMaS813mSSx+vv61UAYNyiTe4WQmdvonXdU+7p8d/7olIP2z1MuDAs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9580ac6-90f1-4474-01b8-08dd975e8cef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:24:10.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEuOrrhCX0DmGItj/3jCRbMjoOY3pP8QEwEJXV62ZNfwH46PwegKzYPfhcsX/mtrIn+x72WKzWSa7vPPFfPRgX5AX/ENmyN2w12aUNaaASs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200042
X-Proofpoint-ORIG-GUID: pZ2VpKe6va7HKCRwEvxIWKReLnxZHSbP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA0MiBTYWx0ZWRfXwuKSqkYBRALa 5Yf2WGMz5hD1Rkj21l9U3/TmWrrZdk3y9Zq5taaL445JB6eWxaVwlpPo+ufcqLbk+jQBUWXHnfR zrhCmhkUVF8/mrp+Df3MhRvFvP5HifwBF/6OftkPfxYWevKLZQRJUOGy2DsK40UXD5/7xCBL/O3
 MWF3BKfPul+XwrBOnIk5QTZHkJDYVZqv2BHaUJ/TZ17mOxkZcNtsrTPfL6DiibsUGb+B3Zvxh8w wMOH3d0pA6liw1D5Gf9+iutx1z9xqSy6aY9l9sdiwc8sxIGbIlZcbse2Jabh9XiXKdrSjTZ+BfH DHdDUfUiuKBYA/oHeFxvl1n0sG3VoLDYqnWyWz+SMlH2qgfUX+o4FMcTwiL30nLtYn3YMaoLXMu
 PaaPrAB9+5M9HqabtNhBYTafSvNYcmxUxJFe6GAMXGf44z2LdsWSTi9/ssLzMGzXl/3zXfDU
X-Authority-Analysis: v=2.4 cv=CMIqXQrD c=1 sm=1 tr=0 ts=682c11fe b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=oIcOFfcJpFyQZoOofmMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: pZ2VpKe6va7HKCRwEvxIWKReLnxZHSbP

On Tue, May 20, 2025 at 11:55:20AM +0800, Chengming Zhou wrote:
> On 2025/5/19 16:51, Lorenzo Stoakes wrote:
> > If a user wishes to enable KSM mergeability for an entire process and all
> > fork/exec'd processes that come after it, they use the prctl()
> > PR_SET_MEMORY_MERGE operation.
> >
> > This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
> > (in order to indicate they are KSM mergeable), as well as setting this flag
> > for all existing VMAs.
> >
> > However it also entirely and completely breaks VMA merging for the process
> > and all forked (and fork/exec'd) processes.
> >
> > This is because when a new mapping is proposed, the flags specified will
> > never have VM_MERGEABLE set. However all adjacent VMAs will already have
> > VM_MERGEABLE set, rendering VMAs unmergeable by default.
> >
> > To work around this, we try to set the VM_MERGEABLE flag prior to
> > attempting a merge. In the case of brk() this can always be done.
> >
> > However on mmap() things are more complicated - while KSM is not supported
> > for file-backed mappings, it is supported for MAP_PRIVATE file-backed
> > mappings.
> >
> > And these mappings may have deprecated .mmap() callbacks specified which
> > could, in theory, adjust flags and thus KSM merge eligiblity.
> >
> > So we check to determine whether this at all possible. If not, we set
> > VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
> > previous behaviour.
> >
> > When .mmap_prepare() is more widely used, we can remove this precaution.
> >
> > While this doesn't quite cover all cases, it covers a great many (all
> > anonymous memory, for instance), meaning we should already see a
> > significant improvement in VMA mergeability.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Looks good to me with the build fix. And it seems that ksm_add_vma()
> is not used anymore..
>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>
> Thanks!

Thanks! Yeah in the fix I also drop that, will obviously send a v2 to clear
things up and address comments :)

>
> > ---
> >   include/linux/ksm.h |  4 ++--
> >   mm/ksm.c            | 20 ++++++++++++------
> >   mm/vma.c            | 49 +++++++++++++++++++++++++++++++++++++++++++--
> >   3 files changed, 63 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> > index d73095b5cd96..ba5664daca6e 100644
> > --- a/include/linux/ksm.h
> > +++ b/include/linux/ksm.h
> > @@ -17,8 +17,8 @@
> >   #ifdef CONFIG_KSM
> >   int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
> >   		unsigned long end, int advice, unsigned long *vm_flags);
> > -
> > -void ksm_add_vma(struct vm_area_struct *vma);
> > +vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
> > +			 vm_flags_t vm_flags);
> >   int ksm_enable_merge_any(struct mm_struct *mm);
> >   int ksm_disable_merge_any(struct mm_struct *mm);
> >   int ksm_disable(struct mm_struct *mm);
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index d0c763abd499..022af14a95ea 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -2731,16 +2731,24 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
> >   	return 0;
> >   }
> >   /**
> > - * ksm_add_vma - Mark vma as mergeable if compatible
> > + * ksm_vma_flags - Update VMA flags to mark as mergeable if compatible
> >    *
> > - * @vma:  Pointer to vma
> > + * @mm:       Proposed VMA's mm_struct
> > + * @file:     Proposed VMA's file-backed mapping, if any.
> > + * @vm_flags: Proposed VMA"s flags.
> > + *
> > + * Returns: @vm_flags possibly updated to mark mergeable.
> >    */
> > -void ksm_add_vma(struct vm_area_struct *vma)
> > +vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
> > +			 vm_flags_t vm_flags)
> >   {
> > -	struct mm_struct *mm = vma->vm_mm;
> > +	vm_flags_t ret = vm_flags;
> > -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> > -		__ksm_add_vma(vma);
> > +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
> > +	    __ksm_should_add_vma(file, vm_flags))
> > +		ret |= VM_MERGEABLE;
> > +
> > +	return ret;
> >   }
> >   static void ksm_add_vmas(struct mm_struct *mm)
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 3ff6cfbe3338..5bebe55ea737 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -2482,7 +2482,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> >   	 */
> >   	if (!vma_is_anonymous(vma))
> >   		khugepaged_enter_vma(vma, map->flags);
> > -	ksm_add_vma(vma);
> >   	*vmap = vma;
> >   	return 0;
> > @@ -2585,6 +2584,45 @@ static void set_vma_user_defined_fields(struct vm_area_struct *vma,
> >   	vma->vm_private_data = map->vm_private_data;
> >   }
> > +static void update_ksm_flags(struct mmap_state *map)
> > +{
> > +	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
> > +}
> > +
> > +/*
> > + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> > + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> > + *
> > + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> > + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> > + *
> > + * If this is not the case, then we set the flag after considering mergeability,
> > + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
> > + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> > + * preventing any merge.
> > + */
> > +static bool can_set_ksm_flags_early(struct mmap_state *map)
> > +{
> > +	struct file *file = map->file;
> > +
> > +	/* Anonymous mappings have no driver which can change them. */
> > +	if (!file)
> > +		return true;
> > +
> > +	/* shmem is safe. */
> > +	if (shmem_file(file))
> > +		return true;
> > +
> > +	/*
> > +	 * If .mmap_prepare() is specified, then the driver will have already
> > +	 * manipulated state prior to updating KSM flags.
> > +	 */
> > +	if (file->f_op->mmap_prepare)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >   static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >   		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> >   		struct list_head *uf)
> > @@ -2595,6 +2633,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >   	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
> >   	VMA_ITERATOR(vmi, mm, addr);
> >   	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
> > +	bool check_ksm_early = can_set_ksm_flags_early(&map);
> >   	error = __mmap_prepare(&map, uf);
> >   	if (!error && have_mmap_prepare)
> > @@ -2602,6 +2641,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >   	if (error)
> >   		goto abort_munmap;
> > +	if (check_ksm_early)
> > +		update_ksm_flags(&map);
> > +
> >   	/* Attempt to merge with adjacent VMAs... */
> >   	if (map.prev || map.next) {
> >   		VMG_MMAP_STATE(vmg, &map, /* vma = */ NULL);
> > @@ -2611,6 +2653,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >   	/* ...but if we can't, allocate a new VMA. */
> >   	if (!vma) {
> > +		if (!check_ksm_early)
> > +			update_ksm_flags(&map);
> > +
> >   		error = __mmap_new_vma(&map, &vma);
> >   		if (error)
> >   			goto unacct_error;
> > @@ -2713,6 +2758,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >   	 * Note: This happens *after* clearing old mappings in some code paths.
> >   	 */
> >   	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> > +	flags = ksm_vma_flags(mm, NULL, flags);
> >   	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
> >   		return -ENOMEM;
> > @@ -2756,7 +2802,6 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >   	mm->map_count++;
> >   	validate_mm(mm);
> > -	ksm_add_vma(vma);
> >   out:
> >   	perf_event_mmap(vma);
> >   	mm->total_vm += len >> PAGE_SHIFT;

