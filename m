Return-Path: <linux-fsdevel+bounces-79767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOkBMpa6rmmxIQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 13:18:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D019238A9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 13:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5926301BAB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 12:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9F938F941;
	Mon,  9 Mar 2026 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="moEuT2Ib";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nbw3QsR9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56B274641;
	Mon,  9 Mar 2026 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058707; cv=fail; b=Vy9HM70KU3KFa4aFVqTOZPIwl+5MTDPcUMw9Ne8hUjsENmUkogf9wZPILKIgQH6sTTrTUwQzwbF28tz7N98jOmZ5oW2IKlmveDe7SR7nz/HVblh45u90+qmbM27c1PHt6RQdF72iYDe8u9LTwLleEDoZgocdUJYtLP2elGFsa5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058707; c=relaxed/simple;
	bh=WGA8DLPFoG1uRuvbB4/pSUU0cngJ4FVrNkNu2YCmcGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qVHY2OZsT2GP9tUMiR5Y0gtdnx3LVEz/DqIZ6GYNDirLx9UVfM3RZlj3A9AJyzexNz1oPqCTau9qA6OOJG/mNkGajMpxgivKyLvUT+7wGrjXVxV6saro5TWpyZ1Zcv+Jt9PqtfqEZWpLWjCzn0fXqaUeZte0l+9zq70TQhh3V0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=moEuT2Ib; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nbw3QsR9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298vMDj1786981;
	Mon, 9 Mar 2026 12:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=R6Iapb0knibZSgDYMa
	zrfAJDMzxiiTuy1R/W+oiDhGQ=; b=moEuT2IbFpi+fGDuDvR+dqVSosNWw9uRKs
	DckAn2TcrIhXM9BjUGaIk9xPfVWeoCvIuWFKWCllQfAEH4tlNuHb5aHB3s1THAk6
	TA06E2CWZ0UiVt7TVKLWVXB8WnG54HkbwP8v0KjBd0yNEwuGDN1aAtpGl/SN84zr
	h6xL1JZIkWOPn8h9dVg/Py//K1ho7Wzk96xfwmB+YPmOGAALDGR3lamiTz1Ay8LW
	+W15gqNbp91GBXfHpDqe4e6fPx0exLmsh54iXeqjMtYJLDVCWj/rAU0szdMHTO14
	OEkIv3JvBRNFRkMwwX4Uihnma+iYmjA0hTYDsy/967QDqkBwcxTw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csjnugqrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 12:17:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 629AduWp020416;
	Mon, 9 Mar 2026 12:17:46 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafcm2e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 12:17:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQFbpV8cD+LO38ujAbMZiPfc16JmyjDeg1nb7brRGEUJs/NixqrSmFDRjK5V2xbo0arWeanf4aQOXgyHV1DAAM88VaDFBiD6gG9VV4iPLtM8PzJ4IRu2+iwLFplZSvhPjM/4MHoQ0uKyPSKOfZ20KxfJU1Z85NzDTGYO38UAl2lmp37kBVYlRXF5IiY2z8vBOdd1yZaRuT1JmQKCphOX6ai4YQ5FqRtQQPrFkhSpDaHYSRJ2quigrwx8oeu141YjlJ9ex9B7NJ1dd47y1d3KIEeTCSwXmf89jU7od5QQdNZ0VeXKqnXg/kZflKFsOEv/cM8KYzzvQvJLvJWDswWWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6Iapb0knibZSgDYMazrfAJDMzxiiTuy1R/W+oiDhGQ=;
 b=AudLhLkPfWRtJBZx3ktVliLS8jj0Neg62sLio1QQ7o0c8dv4YA3K7zP0jkXHCwt9XsSBBERLNA03egW6+1B6XbZ+kxE6stV+P3BGICwSJ7C1VkGG/MLcDQlPu7zF1PAOcThTEnz1+Xqwe55UMI7VhYAn3OhEBOpmlsmmftiEX8VHAYcXmgqJWqbtK2WN3VfzhFmBrVUpcag3glDKEn0axBrefv/hw0nskCewXc7ep6cqI0oboTcxPH+dKM0GYXfLabaWPypwEDIxSzw4qn64QfDyYJSpfk3sd2AjfrEmCv2BPqb2yzan2S4YKq+CYSWSSBfeHBR08GvTmV3BJgJKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6Iapb0knibZSgDYMazrfAJDMzxiiTuy1R/W+oiDhGQ=;
 b=nbw3QsR9HNY2VFd4FxXbE4PKV0424i52KjTWsddBXrRHPHOTuvvFUy8SSdRsalaOCzBuZoKsLulf5QY0Vo6oA7CcgWSjNZp9RTb79g3wydv3yX5++iHitTvGcUxAW7iqbHNSPfMFJj3v96/i6fT2MH6I3Yp1t5T4ttfjQ1vAZTQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8179.namprd10.prod.outlook.com (2603:10b6:408:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 12:17:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 12:17:43 +0000
Date: Mon, 9 Mar 2026 21:17:32 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        Qing Wang <wangqing7171@gmail.com>,
        syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org, chao@kernel.org,
        jaegeuk@kernel.org, jannh@google.com, linkinjeon@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, pfalcato@suse.de, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        Hao Li <hao.li@linux.dev>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
Message-ID: <aa66XJDX4QfmEbNA@hyeyoo>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
 <20260302034102.3145719-1-wangqing7171@gmail.com>
 <20df8dd1-a32c-489d-8345-085d424a2f12@kernel.org>
 <aaeLT8mnMMj_kPJc@hyeyoo>
 <925a916a-6dfb-48c0-985c-0bdfb96ebd26@kernel.org>
 <aassZV5PjgFx8dSI@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aassZV5PjgFx8dSI@arm.com>
X-ClientProxiedBy: SL2P216CA0141.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2c0b7a-2ccc-4bf5-f0e4-08de7dd5dd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	NrpUkkii6rCU+5PWz3WTwCGWsSbuyTPBMjYwoxMJKTosPKWIx0JslwcJ1QmDaHUjCAlsYJCF6tLp+GzDB06q5AtE0D7Uq+1yGoJTmpf9FHzUcb8SH/MoayhFpsK83BaDbTCZJ3ZDONkcyuMSKJTqAyR/120ajUY7bSLHSgyjH71MVVAN4tQm6YQ19py+GvQC8mXpqGXFv+GDK/qYz58+ieziEtrFsWxvp63EZEG9E3WqXQAIbFe+3OMcwWeSpP5fmXjAsgduLSrOiDiF5jZ2decRwdvlfKydoMdgm+F15G/qhNnM4dnWhqCDwr7VlX7IHbPfups4IpXgvBIBN3ABeqgcSuZtg6Uie8jfb49WHJDYaw42Nwd47a8L0RqKPkQfPFlkaBiMNOhMhJU7lzbh24Y1mBA+xPaQcRW2w+aJTSdO8uf3BU5fVcu2yvEwuWNiOZLdKi2LdAKZgKhCwxLkSsoR6C727fUjf08c+ZNgnPDDYbr5c88Ubv89BJ9rWFJhFCAMpMByF1ihfvfu7ZV7/Q1QRfvXbOAJBCq8dm4nNmLffADYpzTYTAI2kEZNZoBCT7o+rKXzzgLybkU719ayuR/NmmzDvYPuu5GFC9In7D6QAY95w/P2Q/R6CHQBUyiGkiGVQG0DufOhB0k1oj3cZ2K0L2VZGiJHHjsxhoKYTJllqQ4m8+vmCO6lX1F8dughxryfIewhl7VXrDs6L1nLcpv+3dkW73faHeJFZgmyOTibZt4mTHu1tvy3eiv/ZyNh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BpzOZVTk9UIfY4Ko5HqWNxh+hLzo5ExVCjSebovmb+ZLyHRqemD86vdqiexF?=
 =?us-ascii?Q?S2Bxo2xGL+rLj8hvKvfIAUNWBRFdAd1rSCBWi9ej/IDuZN0GGAUFT7yAWOAh?=
 =?us-ascii?Q?edTnZJ1pB3QN+oSis0aCd6PFaNz7XsYX8CrU6X52ThkLavwjjwwS5V9R3S7+?=
 =?us-ascii?Q?80/8AtqXqjgaZIbYIS4ZAGh/9z2XMEKYHdvaHUA2yWHestCCiK3ywxuDzAJK?=
 =?us-ascii?Q?T9fWjnlO3B5RkECIcHsWFzzuq/Vg72hU/bWpsgstW73m9oxxeZpUl10l7x+5?=
 =?us-ascii?Q?GTbs/987vblrUZLjRaWxe1gCD68nHngkfdwwVMMpZ2AP0X64Se2lPLyNSJf/?=
 =?us-ascii?Q?BFPn1Giog3qNDhbWJRt+iitBmmiJDunn6XzNdG5v7GnAb7ewGVJGcZxooUFe?=
 =?us-ascii?Q?Z3/a/+BSIDKLqo+mTrMCEkUyWRTDr/NmsKxyk78bcmIPLlpNm75mgQWayBlA?=
 =?us-ascii?Q?HkGYf9uziEpF3Ojx8NQL0oGYoaP14YbLXBlUxXa24yG9KDc9gwZU2BICJl/s?=
 =?us-ascii?Q?wDEK6Q1zFsgMgdX4yVjdYAabcLHIp7cqnhXtnspDkeg4eRnpraAxdIvFgvfJ?=
 =?us-ascii?Q?Xve9Xe8l8OHgHHZ57ffmeKTXzh3MFQ5x7hukTEk1H2oGh8EAek2gSfrP5a9L?=
 =?us-ascii?Q?bhin/cK5etGtsZXPZEaPpFDIIu65ARBudAR6GN3lZQ33MOni+95wrsGfFC9C?=
 =?us-ascii?Q?BbdvPKU4U76DkA1abv0WJX0MxdnbEU20diyAOGy95wW6oKVGet/JHiL9voqx?=
 =?us-ascii?Q?2uVQLONCREvIh0+VIfYr+lPOkSrpM8wRGdWQ2hwSNX67AkV4QtnUuxU5Arnh?=
 =?us-ascii?Q?t40rDZFAHZnzarISmdGZ2rwzoIu5CvXLHELr6oQW13AGIndtP+JGz7eU90fj?=
 =?us-ascii?Q?7dcMphaAu21qjpK1mMoyGiFergnMvUgYT0hPP23RE1l7nkX1Nlf3WdssBspm?=
 =?us-ascii?Q?YGc/Q+LV3dzFnsoBtaphG4qKDb8PUoZRrpOk4Jk3fGHU95YNlYmzEDbI6/g/?=
 =?us-ascii?Q?X9F10wOfJpQnoe2ouJPXTTj8047/7yXVsBHzKOyPqbUujOKjt8l53Jftrsx7?=
 =?us-ascii?Q?jv1jEg+Y+bKpUC2G+PDpEIfCtz7dpzTU0wHCU/GpwNdg47XAZCpgMbak7dLh?=
 =?us-ascii?Q?0CLAeDjVCVYmfwdlBNTEdssyClFI6xmkZUk6RoNwF3uxt7/+Dt5v4/e2bDfQ?=
 =?us-ascii?Q?JqiM4fz+zVyUP/oE6rHrQ7FglHELyInLY6CYTiPt/MXuIoC5RWFjijRIDRGK?=
 =?us-ascii?Q?LQ8pZhruIYm189tvcVQeVq1YO7m9O+ygBzW9nXzITVKPmL2WJOWhhNHxw89y?=
 =?us-ascii?Q?JN+64C2lxmTQ0mrM4Ujens69TVnSC3mxXUEoMHZt/U5vi6DtOsN7WxCYzhUi?=
 =?us-ascii?Q?QJ8bkO3eSmEOfM7jVpIuMh9xFAnf7jiKBtAB2Qa18vkiC+z9GYnW21Odxiek?=
 =?us-ascii?Q?eHqY3V/MYfFTllQve3iOUd7lNkn7HX7L6sCQJJDubT7ZPzD4DMolKovBXoB1?=
 =?us-ascii?Q?sEmMk9LOlUUmC1LlKrnBHiXW2H47sC5idJVqFDuGwU5vnTBDRML/zXvJUiIM?=
 =?us-ascii?Q?tT1bjk0W5qNda7L4NkpjLZ1170C4ByEr/ncBH+WFIe2CZiVBji7mwKRJmRZc?=
 =?us-ascii?Q?cn+9sxaVUH16wH7+/dMb2ogdVLFVcplp67YtdNkMKCT3wEALR0bcj+TfZDIE?=
 =?us-ascii?Q?Xaxg0fTsaenY0qxeFT8rW1t31FqzLU4y9354PdZ45CAW9Si1Di9hyQXEn6AU?=
 =?us-ascii?Q?fWOW/sztHw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	lLhFKlz5ZK6jC7BkbH/C7EdKasTj/kQGB4UgaODfiBH+2I+H/bmtqA9oLxaVuq1yxcCXbAarsUrBWN7Knv77I3KYjoj1zhFXXGvBm0I9HNOPRSvlwUluh+MCZtb4zAlgLPY3TjBP9xsZ9Ov12N7Q0SheojBP9eX2DGWkCECV1JqDt8EVD+mEJalkHiSbBhy4ohifDGji26xNxtrunDTC/zim4HUNUmFMCBgu9owOuPN1pvoQELRRg9bpvFNR0BPqWf/8pnfY5wxtqFVIT9fz5vvWKUcuZvdV4LmukUd9rUcZiHXwgstPAjN7IGQHjL7dVoNT0ZLUCcDlqWW7iOeoFQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2dR66/PQamIgdJL0hGKAfK73pQjOIiYMj4d4TGJr0qVOjtDk/3BRzHJnkMoqkU/iHyMUMAld9svTj8WCTxBfLrq/2fehD4S1ZhWnJ2QOsDhxv4opT38ADm6Ip+fQRXAMILAvPaGJIZbdyld/6JDtr6FZsVUc3RYonYfhFQLgh79ED8uzPtwVY/6eUIw0tpWsJvcRC74MxEoxbhMqUlxbEkGtJl3Eaw6EpnBtBLhO9U9qjP55Rm3kHQzyfwFZQZmLhauobmAkmh6mbOJyKTrSTTLOqzUbKGyT9tudg0VcNDwNabncK7bzAT20oVpg1K0iXcMmNGwJO/7zqnFS7klRkOu8KVpTqep42aTGtLCQ9dDYLKwunAIUxbjjzxM1ityWV+LMbEtDu8GFaAxEoL/BirfSimRjRDxdOoHMGEWDa4UrokSChKcLKnaR+PMynnZJiu/kubwDwVi51i6D+DEloOkJFndBxM1IufEkGkxucoMoOni/NidtQzNRVErHLbS64v7VVl+K7v3ksH5R8wjWjrxrXDiEdBn2ZubcoRb3OQCUDtnWJeFCxoxcEtaGuZWqgrf0NwyDQC+opRW3MVCTAC8Q9i2dbqUKZCoHejM/gr4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2c0b7a-2ccc-4bf5-f0e4-08de7dd5dd9b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 12:17:43.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AK/ZP0ZJ5TI69PdfPdhody11C29oy4lIfF1OfNaaXgpxC7Z7hnbs6YdcnBB+olntP1o4/avIjXgJAvSsfrATfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090112
X-Proofpoint-GUID: u9W1RsrY_p8XyxE3euG1m57G1L3x55Dy
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=69aeba6b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=jhvqN9yWlx8CHuFYmtIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12266
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExMiBTYWx0ZWRfX3d4jfqhYuSU9
 N98sZ2trCTasessTDWnzgAAkhkNqjd3HAX6mgVtapIyKe8ssQqNQV19DavugytyNSDxnOqrvwk1
 b0ST8/ipbED/lJBycyGRolrZIeT3ZFq9q/VkCBxIdhEdQBJMvLjQDJwtUdRbbMH1IUOP6/h2kYK
 YTaOGizLXbW7SNsLctKS0CF+CAj4NAariCam6WanMbFx1iJ5LkOMioJz/T+n1Nzz3xalP8E5afC
 REheOZQtgWdEB2jWnsbHbRqOAge/mFXzWUlDVArVHO/xmMPT4/OmFRACf0iAbyk1H7Kr0IJtwV7
 5ROJ0k4CdmWYaSct0jV553Kkq83RgZS0n1Q2IFUH46/3QwSHuQ7J0GPQSNulCKgywDuWCr+dIsY
 JOCpfbNX1gslQfORUe+IP0OhWsViUlH/BGMDjSn1vbM/Q2gNm+Ct/L2b8b5KL9xwNcmoFVjm7Pl
 gKw+3EKuYLOcQyPapn0wqJivzHdKhHO+1/ZgzmNg=
X-Proofpoint-ORIG-GUID: u9W1RsrY_p8XyxE3euG1m57G1L3x55Dy
X-Rspamd-Queue-Id: 6D019238A9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,syzkaller.appspotmail.com,oracle.com,linux-foundation.org,google.com,lists.sourceforge.net,vger.kernel.org,kvack.org,suse.de,samsung.com,googlegroups.com,suse.cz,linux.dev];
	TAGGED_FROM(0.00)[bounces-79767-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-fsdevel,cae7809e9dc1459e4e63];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 07:35:01PM +0000, Catalin Marinas wrote:

[...snip...]

> I wonder whether some early kmem_cache_node allocations like the ones in
> early_kmem_cache_node_alloc() are not tracked and then kmemleak cannot
> find n->barn. I got lost in the slub code, but something like this:

This sounds plausible. Before sheaves, kmem_cache_node just maintained
a list of slabs. Because struct page (and struct slab overlaying on it)
is not tracked by kmemleak (as Vlastimil pointed out off-list),
not calling kmemleak_alloc() for kmem_cache_node was not a problem.

But now it maintains barns and sheaves,
and they are tracked by kmemleak...

> -----------8<-----------------------------------
> diff --git a/mm/slub.c b/mm/slub.c
> index 0c906fefc31b..401557ff5487 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7513,6 +7513,7 @@ static void early_kmem_cache_node_alloc(int node)
>  	slab->freelist = get_freepointer(kmem_cache_node, n);
>  	slab->inuse = 1;
>  	kmem_cache_node->node[node] = n;
> +	kmemleak_alloc(n, sizeof(*n), 1, GFP_NOWAIT);
>  	init_kmem_cache_node(n, NULL);
>  	inc_slabs_node(kmem_cache_node, node, slab->objects);

But this function is called for kmem_cache_node cache
(in kmem_cache_init()), even before kmemleak_init()?

kmem_cache and kmalloc caches should call kmemleak_alloc() when
allocating kmem_cache_node structures, but as they are also created
before kmemleak_init(), I doubt that's actually doing its job...

I think we should probably introduce a slab function that kmemleak_init()
calls, which iterates over all slab caches and calls kmemleak_alloc()
for their kmem_cache_node structures?

> -------------8<----------------------------------------
> 
> Another thing I noticed, not sure it's related but we should probably
> ignore an object once it has been passed to kvfree_call_rcu(), similar
> to what we do on the main path in this function. Also see commit
> 5f98fd034ca6 ("rcu: kmemleak: Ignore kmemleak false positives when
> RCU-freeing objects") when we added this kmemleak_ignore().
> 
> ---------8<-----------------------------------
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index d5a70a831a2a..73f4668d870d 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1954,8 +1954,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	if (!head)
>  		might_sleep();
>  
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr)) {
> +		/*
> +		 * The object is now queued for deferred freeing via an RCU
> +		 * sheaf. Tell kmemleak to ignore it.
> +		 */
> +		kmemleak_ignore(ptr);

As Vlastimil pointed out off-list, we need to let kmemleak ignore
sheaves when they are submitted to call_rcu() and ideally undo
kmemleak_ignore() in __kfree_rcu_sheaf() when they are going to be reused.

But looking at mm/kmemleak.c, undoing kmemleak_ignore() doesn't seem to
be a thing.

We could probably send it as a hotfix and fix potential false negatives
later?

I thought this was a more plausible theory and told syzbot to test it [1],
but it still complains :)

[1] https://lore.kernel.org/linux-mm/aa6lBQDAVnqjz_lk@hyeyoo

>  		return;
> +	}
>  
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(ptr)) {

-- 
Cheers,
Harry / Hyeonggon

