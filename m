Return-Path: <linux-fsdevel+bounces-77871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD61HPTsmmm4nQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 12:48:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC3416EFDB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 12:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89EC030117B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 11:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145ED2566E9;
	Sun, 22 Feb 2026 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SBK0qN4i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WGOv8d80"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C014AD0D;
	Sun, 22 Feb 2026 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771760872; cv=fail; b=f2V6wpnPu8TuYafaNxoGG04mQRPmYJsz8VXZzDnTChFUgS0LrR5WvQEndwvpzSGSR2bD02OsCa3Q1J9lmA2+Sk+iAgoICXHnyk0W3m+ZjTfLBcVtJlQ+0XTxNT2tm1r0BAv3WCJSQ4iN0fi/fO1F+GLKa1E9FrCJgxBMJW3MZ2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771760872; c=relaxed/simple;
	bh=y1/DyPYTW7Fv3kGJNGlUb3u+FwNEh+n+SmnC4DgKc0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b1vaw94hPTzoVeF/I7c747KtEOt1ELLn7mGlcpESFBT9olVHqUfzzJkWWJRszVYBpySpjnsNEzIm3qcV58z3tiArGHXihzwb7EDKewLl7e8KaSqzRfJ/D7nNRq3Ifq6qG3kwE+HMRoROdJkDxIyQU8fkqTf2+JtKtdDUjW8snjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SBK0qN4i; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WGOv8d80 reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MBfTAr3537500;
	Sun, 22 Feb 2026 11:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wiCVo3nHVPuCmU40Aw+apER6XeAMMqaS689qnbMeAZU=; b=
	SBK0qN4ifx3bOfV31zPkSSxB95wCVRyi5aNR9prFNUXjOrJg/K8od9ero/uGe3q8
	DTlot6t/yHHJMcuopwi3JpEEAiaB9zpEcqNNCbNgdEqaWx/9X1fai5gCjmEPKjS1
	JcF9cmSvmZsRJGGDF8FwUzF8AzpzkT5ZMKfR8T7oeOFAZPHMLTKYBZ890vPTqLts
	tKfj89pY/pSoDZSUPZYzFyKd1yVf9iOeIzNu4SXhH0PmUZEGboGP9nLmjAVL9/88
	Uf4EBLS1P26QMVwlvxlvDz9f3aI96MC6jJaRiVFvVLBzGpvSgz94uj3swpUwMaub
	l1YdUzdoFoCAZP2+gzcL+w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3g3h3qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 11:47:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61M99JtC012522;
	Sun, 22 Feb 2026 11:47:15 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35bnaau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 11:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7lVHUQFDX6EF7MSryTFKCTFZvW4p2pByYdWVGEiKpW3rKx7dzraCyf2kFo1QmBJSlYYwKueuNUD1JF8kp6PNYWO6Y24JacGlYo0JEZUpZKtE3RkASpFD8yGUvhDTfThNX6nVI3jBVmmgGqBr5yI56AQe1rkCFmMusHIDyTaVuJ5+qHtgNt0XtIApA0q9MZoTIBDOgCkjaqzmkpyy9y8P3FRjgbPXEn5b932vUnXp8YNSNKLzhhH2lVuTF/Q0SgAbREoswH1ZyoCcnVnJt6JBXDM2cfzkMB2S0hG6jNPCxcMjjp0ZuapMPo30SS5HX+WSCUI5qMfKEXXUx9xzLGfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptx3avVNp4XpXcdg+tsH0ha60CtQ901I1HgIHtxOAmk=;
 b=GnUamMKzp7GP1Ykd3039TMBxgwRjPnoyhh5MSRs3fK/Ex7le7dWsZRR4ZsJN49jUOMNwPK0E9tcDt9Czf3zt+A6qLR28F5btTiXNOvfEi6cjoVSf20XLv+IG5uItq/llhBKvMrBXh3xSvvnUi1EdowGlLOssBa/AgGK4NUJglg34S5QsEF3Vp2qj6zBxU1GJ+OlDgLiZhZUY4hMK7RONw6TSuoyYQzm8QhDNvzXMFiXawRZdOCIVvqAPQYj7EUswsnjP/LVm3P/SYgqvn64Gc7pK4tPK5E989zwE9rFdiM6rIMnCexZ2Ql4Q6EPDIMrLiTeDDIH5JoxijPwn1OWjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptx3avVNp4XpXcdg+tsH0ha60CtQ901I1HgIHtxOAmk=;
 b=WGOv8d80dfaCpQcF7YAxolp2N4imgjv4rq7wYzql9kB0KHVSnc84pJJL8drj1ItBguEOYAZF6Kb0WHqnjsZd7lxu0G+BOZvr9I/ClZKMp6wKGWf2Ul/nSbt8qtWPCirlE9bhuY37/FdveWqka9HYbRYlEacBiKmcOM/fowIPKoU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB7279.namprd10.prod.outlook.com (2603:10b6:8:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Sun, 22 Feb
 2026 11:47:12 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.019; Sun, 22 Feb 2026
 11:47:12 +0000
Date: Sun, 22 Feb 2026 20:47:03 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Carlos Maiolino <cem@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, ojaswin@linux.ibm.com,
        Muchun Song <muchun.song@linux.dev>, Cgroups <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, Hao Li <hao.li@linux.dev>
Subject: Re: [next-20260216]NULL pointer dereference in drain_obj_stock()
 (RCU free path)
Message-ID: <aZrstwhqX6bSpjtz@hyeyoo>
References: <ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com>
 <aZReMzl-S9KM_snh@nidhogg.toxiclabs.cc>
 <b4288fae-f805-42ff-a823-f6b66748ecfe@suse.cz>
 <ccdcd672-b5e1-45bc-86f3-791af553f0d8@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccdcd672-b5e1-45bc-86f3-791af553f0d8@linux.ibm.com>
X-ClientProxiedBy: SE2P216CA0203.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb39344-a12b-497b-4349-08de72081df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?0VVwip/+5cheJqo4eob5Bd+njOkMqlRjtrnivZRjdLugqWThCLNy9EBKCR?=
 =?iso-8859-1?Q?nIkwHNEByMmBR9eKwDiHTsPt6Aa6gqUX/ASaBZ84FBcnXSyDZ3bIX9/xEO?=
 =?iso-8859-1?Q?1YuMslo6wFKu2fLEh5rtNmOZXYX1JEkJPaPI5QRTN6Kjzzx8+72RU/WNwA?=
 =?iso-8859-1?Q?W1FRjUFUKsDmPG4wwIvhjbDS/H6HyleB7NvIOdofziE+6ZT+LW4jW/fTbg?=
 =?iso-8859-1?Q?jD4dnk1KCyFH2CfDpKPC9IUSlZ9elbbbxzkLZRnlb2lIk/fKKvJlfHmV3X?=
 =?iso-8859-1?Q?sOwmhqEmSbTw9PQKZcsGIaRPCihY6V8Y18dyOIk/bs/sYBjYcaY4I16NX8?=
 =?iso-8859-1?Q?EFYlIVjFICV6FN9z55PhQ3g+UCMN8jDCUZHfrXVgeP9vuJGXbwB4moSfWS?=
 =?iso-8859-1?Q?WRIQo//IJsNT+/34sdulnQJPIAIDQWmwJyGrI4L0XdRwy107+3OtX64N8o?=
 =?iso-8859-1?Q?NL1cO+2CD2+7wrjOoTk/0V6ognEe5+Ua6shcN9RlhAvE7RkYi3eHFxYg3p?=
 =?iso-8859-1?Q?Gt1QWFSuR3vgpJ5KImpLZdpOOArEgAoaaW8QxWgK/dAIcyIIkgDgtiQuU4?=
 =?iso-8859-1?Q?cELuGEIKoeX0Ya7KeWv+yIbdnIXWkAJJup4PF0nDJY/UucVYaL8vBQWOWy?=
 =?iso-8859-1?Q?jO+xfZIOT7QWo91eb28AyDDBRULeEWU/dhFUm8lX+3qRSW1RoDESxxpF89?=
 =?iso-8859-1?Q?P+GVXB1Dr4kjLxq2fb51DTS9aIiaRSJ3HkIJ+bHJt4Pe5WXkJ0ULtC3deF?=
 =?iso-8859-1?Q?qu78UDXQWffCJm/jZlUFtQoaa+rRE3MgzoY7e1jm4momriFRDSZ3gw//zg?=
 =?iso-8859-1?Q?91eJwH0ZSKGYrfJv1SBjpY5WCVWwp1BaG3U9rvcfATYz/qOT2uFO8xjfl3?=
 =?iso-8859-1?Q?x8BPFPovN81m2jHBM/exQMITe//uznR1vOkRRY9u/XSmcuMdyrff3R0tmb?=
 =?iso-8859-1?Q?dRC2estDx+4X/f8hEXKEe/LG227NfB8LC/cAPjpcGL4x36q6IafE4QRxOa?=
 =?iso-8859-1?Q?k91AQar5ZQx7ORSUYdGYCFQ4LmtrMvAQWO7Zzs3jyqafZDxLuj/Jo7p/EN?=
 =?iso-8859-1?Q?YGnInxHyWjuU0UyYfTvmQrWqOWlALtJgf/mdwLA1UlHyerpk574Hl1a/ZA?=
 =?iso-8859-1?Q?z6yQjx9YePaUAkUe38jlVADAD6KQqVRzKathMLelRSWCzyP/oWlvya+RrE?=
 =?iso-8859-1?Q?5K2EeoZR+rcGA6IzBOz9RY4zB4IsuvcMZ3tpXP2G9snjOjktG/cmR9I+xd?=
 =?iso-8859-1?Q?0+m+mWdtMl55mXX4rC3lZcuhl9GCUT7nesr2SP30iqbZyILb5AsAlyxNa1?=
 =?iso-8859-1?Q?tp+kJuCqVEXX/AhltJH+WzPBgThiisxvzvHcJ9URgLrdnCras+zKNk09P3?=
 =?iso-8859-1?Q?rZey3wRs1WPkcy5U2YtAvVtuzLhDQJL2KeKs+T2PbuzCKMsQSxE7JDdbo1?=
 =?iso-8859-1?Q?bw8iilxxHZqPQDDQiffVyVyg+nAEwPZzJ+c48bWwWAXbUGiV4Yqg0m8JYW?=
 =?iso-8859-1?Q?SrOuaU7XgMbyK5L47hryMVxVsckh5kfwi+zBOCr+QSIaAlyrWFsygpm27O?=
 =?iso-8859-1?Q?JbIfu6Nlc4Tb48KEtG3rDL5QTx9h1/TQCB5CsOsSYxGyFZ0VNXhmqC8QID?=
 =?iso-8859-1?Q?YWnYb6PtVUKNo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?27mqK7MaW1W85M8NU6QziRZoKAV9D76hLvr1Fv3/GyfI5Cu4RsmSq2V1nE?=
 =?iso-8859-1?Q?rhpZ0ZMgxsb9Hh6yLkTsJdglzkPX66N4k7rX5FaCUSf/ihVokab9+Ay75P?=
 =?iso-8859-1?Q?ANn7YY2+KozMN1WAYH1Sgcdoh3uCjaasyclzgh+17NFm6A6S5dilZ945ZV?=
 =?iso-8859-1?Q?2DHbaXOOlkhFwp6nYbrrFGAKHpw70MSpXorzi2rVr8JWkGw8cIjvODA4ad?=
 =?iso-8859-1?Q?Nc9I/hJXbH0MO+9GeTZOovwtCzwOu3EC+QVU1Itoo3nh7Dy0bKDUwe/YWH?=
 =?iso-8859-1?Q?PE3t17nkDNkRvt0U/U9jDhUiIJTqJdGY8yHGl0QvUPQXUkxbSdFqXO0CSG?=
 =?iso-8859-1?Q?dd3F5FqxG8j8aHNBITxrfUORgoPeL7rLfshyJG5Jj/fPaXYAB/43R8f2RK?=
 =?iso-8859-1?Q?QFyoWC0B76maXXl+YdqF9gybOgkjSKZxmkdOT2eapeOZQL6rFB1k947oqC?=
 =?iso-8859-1?Q?gy9sl5TwS4i2S/dNCn85wIcMnb1KlKgEdEFexeM73qgthDJusqPP4z2aFa?=
 =?iso-8859-1?Q?17SGIye7qEHLHJsyCRxXj9OLnGT4+/1IVEiwHHU/yiSGqapmVjHe/rwvHo?=
 =?iso-8859-1?Q?+lbMabaxSAaOVljiSzGXNglECArCGcn8w/BnvqvEFRE4AM/BCFiAZeGyAI?=
 =?iso-8859-1?Q?V4MWdWBpHGzHB8qvQHRZf5Gde5UDDdKRMJMUcwV7pMrQKd7OnBY9BnqdWZ?=
 =?iso-8859-1?Q?EpsyCqFUxNBa2zrTIU1EXWqyDoYx98ElGGunAWSemY1OfoRooMTwMnoR3d?=
 =?iso-8859-1?Q?/OqtXVACn187//25smAk7hJzEFSbMiJnrWhqlAnoYAmAmEqxha7mtltIVq?=
 =?iso-8859-1?Q?c2lNEBwet/ocLMv4LK6Zi+j7gIP6jzyOGjAOdt9Aq2KzSJarNP/DPWl/D6?=
 =?iso-8859-1?Q?8Xcl0t4kiQxnZUo80vHSg4WPtqKWFtixBC18kthr9ItZnJY0GXvY6lEV0X?=
 =?iso-8859-1?Q?La7EfGOf4Ztp7O/EXReSDG5HOv7y1yt1v6L+kpUJzYrllrcZX1QRaqB/DO?=
 =?iso-8859-1?Q?u8pS7IFJbOlPnccdDmfyfp1TBm6wINfGxQ84uyTJXrP6l5TcjV5awJsB7I?=
 =?iso-8859-1?Q?2gU5GtLyaIV4qi76Gag4iF5SJDgvH397JKrRxP0C5WigqBqb1PesXrdCmC?=
 =?iso-8859-1?Q?SaXuAqsL1Ah7Y5AXNrpdPvPL4hCbgOfbbb7JmanzXaoVesDWUoMs/CTs/+?=
 =?iso-8859-1?Q?t17C1j/UEIW23uzbzbX8saj6dFE18bg7GO5/en7tUcxrQZwdHiZf2CUI69?=
 =?iso-8859-1?Q?jK0LqxaFoyFho0r3x/+QPwI7S3KZblVuiWXmjuJW8rCMVkEaT7FCdeiktt?=
 =?iso-8859-1?Q?0dGCBXL96RsWTb3db25nAjkYWPeJgbqtUli+SJ1O6SIJTgSLAlV6QMJKm8?=
 =?iso-8859-1?Q?sEVFBO6GzqwYL+qYYoZIosaBqzEN19NVbsrywlKV/KfuEXG5XFHIRJ1TLR?=
 =?iso-8859-1?Q?EZR6/6oZ4/2fWocQvz60kuoqaa5gOhXSDengonlA8TPhfFjWb6q7WJmrJ9?=
 =?iso-8859-1?Q?MtU1q3G7XYVs1UiNginhRF63uDNuvpy2qtWVreK9gq9eETovLiSAeV5OZo?=
 =?iso-8859-1?Q?YWxO93c4DkC89whZYJslTPQ3XIRgJHSnNODIcxGlA7dAXVsLapmpmr6Ncv?=
 =?iso-8859-1?Q?eBbCykStMHpqHLKGpMy8LndHeHzL3yG++gA87Rp4df4Z+9Q2l6XlPiCBz0?=
 =?iso-8859-1?Q?3QQ1mjfa+Yvfktao92Ru4GTL11XdSIMYfWWiFaERAg7crg6fJdc5Dnt7BR?=
 =?iso-8859-1?Q?7t5MDfnFdo3dsI/rWxXmjrUJdpWz1roWnqB9KPG/5j7MjV5XG2RyukVGvA?=
 =?iso-8859-1?Q?Izluvfi96A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zEnqt9j/ydR7e/cZduFoys5KjUp12QtH4k/MjzAdwCifCL043judGZRIoKxQYpkU3cqYbIj4BQAPV0bqqK/NzCEWKC8V9lD11eWSqUF8neogyeg71/q7YNWQPz6dHbPdLWvyicAfLxbXklg3nVP+w/bgvQGX+CEpESncOrfBefOCwK3jNnxQqlGu/NZsf95L6ZWllRtQc0QdPkn1uA7w9tL0HdQAcUAw4WZdGlBbBehXYM7MRPB4l1lA9WZxcnfybeh7xhvnAirhQP0BLx90fd08fLvaIUFxNE5E+7VyVX9OPAM+x084IHDvU3SQ8YwjRLTecYrAhUOfTJmukQKsJnVrV4ovM3Dk+YFVGRNWo2dRAmvue1t8mzF5bRDFerJYu8dUS9GvDED251Dfm0wGzUNJP5FcA3dGbBTMErT6eZ06pzkQw3HsHF9dz+OWTxtUiisohZCZc9eNOzjnsGCfaYKFO83rKUUKZ4uUBMYcdGrcWs0U3h3Rrv3aaY3MPY+Oj5W2oQJasZYiPa/LywcCY7v9JI5N+xgoNCjx0z5wbRNzltkpFxbmwKalIo+yajNFz69LbO9ac61q469qxud8Tov06fZ7xlpUkWPDjnJ9WH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb39344-a12b-497b-4349-08de72081df0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 11:47:12.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05iv1BQT9KjK2LpEP8GcisvVgR/QE23BGYe+eX8gWdEhurkvfDe0fa2Rc4/aOw8bbHchS1+30v5mPM2Ablvkpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602220112
X-Authority-Analysis: v=2.4 cv=Y6r1cxeN c=1 sm=1 tr=0 ts=699aecc4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iD3yB16Oh28nB8ZgULkA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 cc=ntf awl=host:13810
X-Proofpoint-ORIG-GUID: g3WWvlM_Lnfmj87opSc26Y038VWMT8-Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDExMiBTYWx0ZWRfX5qhQn7yc9YkT
 /V+3lkLRMW0qYH0I1hzCWjU1cgXwwrNeCuVeoxxv4kjBNNSWMkTiT8wLL0sV1KkBtwYkCr/5cMX
 RBW/im4LJ4o7v2muHr65eUo9Nk3lbeilS8ClrLqZmx/fxyVgtwP2ibHpPB5/lL+X4AtWq0LD7Ep
 bX6gtgW0ZY3TKI8ziqsBTw4wettsq/i3kVkxRuy2JjUOGFZPIvmdtHNvPzyQR8JU3cWTYmotrgS
 rTQsbDmhU2a8IQoaGW6PKhR7w3O7qmKaS1MDeiRzcuQYH49mw7no8SCX19dgM40gKIeCnc8W3K3
 +SJfHPToI0OetTvpspB9gHkvQowVUdnfT2S9/Q3aM7iP6lwGCaxNv0uzyzVzusaqkTLtTmz0+S8
 CgDRtIUDZMQ7Cf3tVVW3aS8n/VLbXD4f93w7dghuGnWdIZK86Bdi/6vOXc/aIY/Ik9j1mV/5qen
 puhjA049uMKi5YvGOYoD7zVWCI/4YSjgWCTFvvpo=
X-Proofpoint-GUID: g3WWvlM_Lnfmj87opSc26Y038VWMT8-Q
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_REJECT(0.00)[oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	TAGGED_FROM(0.00)[bounces-77871-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:dkim];
	DKIM_MIXED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2DC3416EFDB
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 03:38:57PM +0530, Venkat Rao Bagalkote wrote:
> 
> On 18/02/26 5:06 pm, Vlastimil Babka wrote:
> > On 2/17/26 13:40, Carlos Maiolino wrote:
> > > On Tue, Feb 17, 2026 at 04:59:12PM +0530, Venkat Rao Bagalkote wrote:
> > > > Greetings!!!
> > > > 
> > > > I am observing below OOPs, while running xfstests generic/428 test case. But
> > > > I am not able to reproduce this consistently.
> > > > 
> > > > 
> > > > Platform: IBM Power11 (pSeries LPAR), Radix MMU, LE, 64K pages
> > > > Kernel: 6.19.0-next-20260216
> > > > Tests: generic/428
> > > > 
> > > > local.config >>>
> > > > [xfs_4k]
> > > > export RECREATE_TEST_DEV=true
> > > > export TEST_DEV=/dev/loop0
> > > > export TEST_DIR=/mnt/test
> > > > export SCRATCH_DEV=/dev/loop1
> > > > export SCRATCH_MNT=/mnt/scratch
> > > > export MKFS_OPTIONS="-b size=4096"
> > > > export FSTYP=xfs
> > > > export MOUNT_OPTIONS=""-
> > > > 
> > > > 
> > > > 
> > > > Attached is .config file used.
> > > > 
> > > > Traces:
> > > > 
> > > /me fixing trace's indentation
> > CCing memcg and slab folks.
> > Would be nice to figure out where in drain_obj_stock things got wrong. Any
> > change for e.g. ./scripts/faddr2line ?
> > 
> > I wonder if we have either some bogus objext pointer, or maybe the
> > rcu_free_sheaf() context is new (or previously rare) for memcg and we have
> > some locking issues being exposed in refill/drain.
> 
> 
> This issue also got reproduced on mainline repo.
> 
> Traces:
> 
> [ 8058.036083] Kernel attempted to read user page (0) - exploit attempt?
> (uid: 0)
> [ 8058.036116] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [ 8058.036127] Faulting instruction address: 0xc0000000008b018c
> [ 8058.036137] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 8058.036147] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [ 8058.036159] Modules linked in: overlay dm_zero dm_thin_pool
> dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_flakey xfs loop
> dm_mod nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set bonding nf_tables tls
> rfkill sunrpc nfnetlink pseries_rng vmx_crypto dax_pmem fuse ext4 crc16
> mbcache jbd2 nd_pmem papr_scm sd_mod libnvdimm sg ibmvscsi ibmveth
> scsi_transport_srp pseries_wdt [last unloaded: scsi_debug]
> [ 8058.036339] CPU: 19 UID: 0 PID: 115 Comm: ksoftirqd/19 Kdump: loaded Not
> tainted 6.19.0+ #1 PREEMPTLAZY
> [ 8058.036361] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200
> 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [ 8058.036379] NIP:  c0000000008b018c LR: c0000000008b0180 CTR:
> c00000000036d680
> [ 8058.036395] REGS: c00000000b5976c0 TRAP: 0300   Not tainted (6.19.0+)
> [ 8058.036411] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR:
> 84042002  XER: 20040000
> [ 8058.036482] CFAR: c000000000862cf4 DAR: 0000000000000000 DSISR: 40000000
> IRQMASK: 0
> [ 8058.036482] GPR00: c0000000008b0180 c00000000b597960 c00000000243a500
> 0000000000000001
> [ 8058.036482] GPR04: 0000000000000008 0000000000000001 c0000000008b0180
> 0000000000000001
> [ 8058.036482] GPR08: a80e000000000000 0000000000000001 0000000000000007
> a80e000000000000
> [ 8058.036482] GPR12: c00e00000120f8d5 c000000d0ddf0b00 c000000073567780
> 0000000000000006
> [ 8058.036482] GPR16: c000000007012fa0 c000000007012fa4 c000000005160980
> c000000007012f88
> [ 8058.036482] GPR20: c00c000001c3daac c000000d0d10f008 0000000000000001
> ffffffffffffff78
> [ 8058.036482] GPR24: 0000000000000005 c000000d0d58f180 c00000000cd6f580
> c000000d0d10f01c
> [ 8058.036482] GPR28: c000000d0d10f008 c000000d0d10f010 c00000000cd6f588
> 0000000000000000
> [ 8058.036628] NIP [c0000000008b018c] drain_obj_stock+0x620/0xa48
> [ 8058.036646] LR [c0000000008b0180] drain_obj_stock+0x614/0xa48
> [ 8058.036659] Call Trace:
> [ 8058.036665] [c00000000b597960] [c0000000008b0180]
> drain_obj_stock+0x614/0xa48 (unreliable)
> [ 8058.036688] [c00000000b597a10] [c0000000008b2a64]
> refill_obj_stock+0x104/0x680
> [ 8058.036715] [c00000000b597a90] [c0000000008b94b8]
> __memcg_slab_free_hook+0x238/0x3ec
> [ 8058.036738] [c00000000b597b60] [c0000000007f3c10]
> __rcu_free_sheaf_prepare+0x314/0x3e8
> [ 8058.036763] [c00000000b597c10] [c0000000007fbf70]
> rcu_free_sheaf_nobarn+0x38/0x78
> [ 8058.036788] [c00000000b597c40] [c000000000334550]
> rcu_do_batch+0x2ec/0xfa8
> [ 8058.036812] [c00000000b597d40] [c0000000003399e8] rcu_core+0x22c/0x48c
> [ 8058.036835] [c00000000b597db0] [c0000000001cfe6c]
> handle_softirqs+0x1f4/0x74c
> [ 8058.036862] [c00000000b597ed0] [c0000000001d0458] run_ksoftirqd+0x94/0xb8
> [ 8058.036885] [c00000000b597f00] [c00000000022a130]
> smpboot_thread_fn+0x450/0x648
> [ 8058.036912] [c00000000b597f80] [c000000000218408] kthread+0x244/0x28c
> [ 8058.036927] [c00000000b597fe0] [c00000000000ded8]
> start_kernel_thread+0x14/0x18
> [ 8058.036943] Code: 60000000 3bda0008 7fc3f378 4bfb148d 60000000 ebfa0008
> 38800008 7fe3fb78 4bfb2b51 60000000 7c0004ac 39200001 <7d40f8a8> 7d495050
> 7d40f9ad 40c2fff4
> [ 8058.037000] ---[ end trace 0000000000000000 ]---
> 
> 
> And below is the corresponding o/p from faddr2line.

Thanks!

> drain_obj_stock+0x620/0xa48:
> arch_atomic64_sub_return_relaxed at arch/powerpc/include/asm/atomic.h:272
> (inlined by) raw_atomic64_sub_return at
> include/linux/atomic/atomic-arch-fallback.h:2917
> (inlined by) raw_atomic64_sub_and_test at
> include/linux/atomic/atomic-arch-fallback.h:4386
> (inlined by) raw_atomic_long_sub_and_test at
> include/linux/atomic/atomic-long.h:1551
> (inlined by) atomic_long_sub_and_test at
> include/linux/atomic/atomic-instrumented.h:4522
> (inlined by) percpu_ref_put_many at include/linux/percpu-refcount.h:334
> (inlined by) percpu_ref_put at include/linux/percpu-refcount.h:351
> (inlined by) obj_cgroup_put at include/linux/memcontrol.h:794
> (inlined by) drain_obj_stock at mm/memcontrol.c:3059

It seems it crashed while dereferencing objcg->ref->data->count.
I think that implies that obj_cgroup_release()->percpu_ref_exit()
is already called due to the refcount reaching zero and set
ref->data = NULL.

Wait, was the stock->objcg ever a valid objcg?
I think it should be valid when refilling the obj stock, otherwise
it should have crashed in refill_obj_stock() -> obj_cgroup_get() path
in the first place, rather than crashing when draining.

And that sounds like we're somehow calling obj_cgroup_put() more times
than obj_cgroup_get().

Anyway, this is my theory that it may be due to mis-refcounting of objcgs.

> drain_obj_stock+0x614/0xa48:
> instrument_atomic_read_write at include/linux/instrumented.h:112
> (inlined by) atomic_long_sub_and_test at
> include/linux/atomic/atomic-instrumented.h:4521
> (inlined by) percpu_ref_put_many at include/linux/percpu-refcount.h:334
> (inlined by) percpu_ref_put at include/linux/percpu-refcount.h:351
> (inlined by) obj_cgroup_put at include/linux/memcontrol.h:794
> (inlined by) drain_obj_stock at mm/memcontrol.c:3059
> refill_obj_stock+0x104/0x680:

-- 
Cheers,
Harry / Hyeonggon

