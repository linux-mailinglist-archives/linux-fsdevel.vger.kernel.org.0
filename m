Return-Path: <linux-fsdevel+bounces-59940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6EB3F531
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5284C3AF48B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 06:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB4F2D7DCF;
	Tue,  2 Sep 2025 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YuQ8O/JE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gId0sEEA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FD21D3E6
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793861; cv=fail; b=ikKQOxiMPwTe9Nzu3EKu2XmCZo855B3pM1UjVFvFmArvl2ZkaXQVC6/cLDm5dSpu0hFlOaUX/legKYmrTX5oQXbcyAZrb0TjS4ILUD5Uwt+IEmh6XQTr17EmGExo4K88WmOyFuQGrvQbwZ2a3wtSS5UFfIgiQBaDAZcSXIlvas0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793861; c=relaxed/simple;
	bh=q74O7sEX5VnFmEO27oHl5RcVrQ8ISiJjuTo9PxoWF9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pb8MZZxzxa4LSXATtnZQb8QPMXlX6+SbgLZH/q9NnjfW/11XeTyUCV6hU0PUi96hJ5X6ZI9b/zq1nlcr0W9nF6GhI6fZihvxuk9Hck1NYNutgPKSIlBWiLirhRFarn5uBxvV6yrdi2S5k87/3whX/ihYT0PHcVy41E1j1AQLI+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YuQ8O/JE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gId0sEEA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5824fvvD013721;
	Tue, 2 Sep 2025 06:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7tQTsTAzf/NQiVvHcD
	JvmCJ53MlONkHx3co2dvgKM2M=; b=YuQ8O/JEvRwspIn+PjYsMBnFbbmCy7nRhu
	8wcdU5wzU0wEawznHHgq1kQRrlwbj95tKD7kFiobm225NONT8SzRX+EkoVoM8N8Y
	uk1k2QSeJZ6uudzlXhMVnuK1HL/NDMuhbED5wHJGeqMc9NC7A09NW4ZfznGAk0AC
	20fQSU5w5NxzI34lxwGEj6NVMDOShn2BP57an79ot1c10vqAThEZMyUM3Wb/woPq
	UsAxDeFf/6LKJxFzUgo4Hi7b0oGiarXz9XBEXxvx8TCgdLhn9L6LokQ1c9WacNAB
	oDv14WVyWCgPuDNy8K9UiZ2Wad4ynHb6DshaZLexVTGDcn+JUV1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgu9v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:17:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5825eWO7011651;
	Tue, 2 Sep 2025 06:17:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrerc1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:17:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCdP9F6PO/e8bd+qx2s0r3Qvxa18WIGeF+f3vFbljgkfD4HywuC6OKnk3uomeym6qH0Wx32VUqutkYrRuQUX98qVIE1mZhpFTSQg2xEgQygP6MAJZFej0LIvPgKDwEF5SRQ9iorOgSjmL4EXxzjAnkPC0F/HKnuailushFgQmE7qDmc/6xt6qsOhKd4PCdopxVh/Mnw6Kyp1dy6PK0crGCfFu00sWpN4dhj5ruYUz9GkpI3HMszZOq2TBkTwsnLR1D7IuqCH8RkfTxDTd27ZWV+8ePMcE6QI/D0EjJ4zIM/4k4FFJ4bomulFYKmbR1UADDHvLJerJNRTvcVmUJ4uuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tQTsTAzf/NQiVvHcDJvmCJ53MlONkHx3co2dvgKM2M=;
 b=xU7WAyKk/eMIMzNFtQXS6muNftdQz7zcIxl51mN/7xtKs4hzUwLXNylE8506TBYcSJSM2U0zPAl6K/kJ0njgJOTQKJwhmNtgIAniCjsxX0PGJbsPYiut8gyq5do3WziRRJehBp1UDlbj1snxImBgc6MIUoI+YY+p6YWpPRrW67RlwIgpxiCPkTmBkt5opUuTseIqWlYEXbAMFB1jVS9xwIal2CzZd2R86hYPZM2EScRpt/y6nPJ5MPmXWlcu7k9wuEuYVWBPv4pxVR1XxT8UI8xe7Gsu6tqVTK9aUXhaqH7TIOOZ9lHTR229eYk+U5OznxhniiRF/OSDHMAmDh98Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tQTsTAzf/NQiVvHcDJvmCJ53MlONkHx3co2dvgKM2M=;
 b=gId0sEEAPtEM14clNRUvcGuejz8onXE9g2gGF1f1zpfVR3Nm8A1HtRQhWJ1WZskjJxTkGxB8CDhUFKZXfSUClYiIBeqyT+ueTwjnW5YiNysOWznDCq/LzhV5OhrB0QOHRNdTMYTz297h17ZKiFmZRFITEoxeZ+RVEUSjIFeucGQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 06:17:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:17:31 +0000
Date: Tue, 2 Sep 2025 07:17:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 12/12] mm: constify highmem related functions for
 improved const-correctness
Message-ID: <c86c44c8-4d9b-4d16-8b99-8c007952ab5f@lucifer.local>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-13-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-13-max.kellermann@ionos.com>
X-ClientProxiedBy: LO4P123CA0188.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: f99983b1-23ae-4463-fd2c-08dde9e86674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w0cug8MhRXenhV1H91bRoEa+9Nwn73A9+vu2CLuYTa6+L5/XjEcS7Ttk5GUV?=
 =?us-ascii?Q?eKaMnoTUzC3SO1jp0QN7kjXm1hxsi0+nveza5T6B4oCQy+NhVLv426WGZDLK?=
 =?us-ascii?Q?3cnPwtRW/kLFoajW3vBvdDu5PNUlyDlNbOs1XUN/EZO02oTkzQuWYhUQMX6H?=
 =?us-ascii?Q?uW51LfzUicmXB+Cp/xZI7vS5+66YoxLf1JOjx0cmTuIhCYYM+qLT7vgjmUlN?=
 =?us-ascii?Q?aWSn5nLluKs40vLyBvT0M3jrgc/8C3LtE9lOL3/+AavCMqaNJfUf6QiJXuV4?=
 =?us-ascii?Q?vkhl759bOl8JooahHNKagryEJrYVwKJcFaqwXO7Jc/Zu1hYXuQXhMw1M2gBT?=
 =?us-ascii?Q?B+vKtY7nOFwqyWn1PqedxQ1zPhTpzaOpf0+fWUnjaTAYjYbsc3C1scawnrGi?=
 =?us-ascii?Q?/6mh9YqZ7pv3zKFluGzLSduUBYFxzDT1IUg6ths7P9J54PnUeUm4nOKwqiFq?=
 =?us-ascii?Q?A+m9X/CVkHkoNfWc8wPxPmYIsN3dWoJVkiDWpGqQPB+oC2LFrkTyFss2kdTz?=
 =?us-ascii?Q?YFpE0+cqrMUCdrasKkpHXj4s2BHnflRbT2cUYt4uaqiD/89kVYgZcPNigvoU?=
 =?us-ascii?Q?pkr1NQnQRM11IT0ocqY8WQzcogSiVjatG5h0fdzgDPfRoIEZiSH9jqBSljGF?=
 =?us-ascii?Q?Cp8/mjWy5+I42BpCvW0Nm1u+Iv9eCRARHg+RsUzju39JftB1sVU/61R55Qqs?=
 =?us-ascii?Q?P5VelA8W9Do5lObbJZeta6k6dQ3ZtREx9G76RU3oZSnhNTY4wCfmYuIs7bUV?=
 =?us-ascii?Q?kcdbZEzcOxSC20jrfICGFVEG+GNb6jIb7jY0jAGvOPKETcc5v72Eo6bLgj1D?=
 =?us-ascii?Q?9H+oqacWETux1SDx0x44J2vHR7w7UNGiM5+C4jsvw6xJZCLaa2w3KYPFe7zl?=
 =?us-ascii?Q?F9C0ZZ/VgD4GBxAj1I0aOsosIXz1qyJFfP/MbwZBDO9ecWSbNtFxXlLNmXG9?=
 =?us-ascii?Q?V+559LQX4gfdJalKj++EE+Yh+jz1P3RQSoxWYCXmHsQZmnrgDDJjp2hw86+M?=
 =?us-ascii?Q?qBIhlwOA2OC/wgnBDIMs+UEvhhdfVwlFmQ1ptXCpvhDnS3w+Qq5orbK0vX6m?=
 =?us-ascii?Q?P2AO2sCBWZWgEeFR6is3RX1unyhNM225rG8pFwFImYI5E9Z0b/bo+BUgzLAC?=
 =?us-ascii?Q?lYhDat08lqNyTA1ebURp/EG7tmX+7nBaafxnpvUlh+BzEvYhlat177X9aUdz?=
 =?us-ascii?Q?ZExcgugBpJn7U+ii23ZMJc+De7RyhiY4DjO/DyV0CnHlanzUYxDIPjvF6JYl?=
 =?us-ascii?Q?CQVfzWW21JN3iKoml0P2HSQpxFwt3xiOKPJS/Zj4SEb7dBX750imWfoLWwh+?=
 =?us-ascii?Q?D8wW76i7S9DjOAs1gYTHNz/FliCnf8gUbtNBApKujO8j9nQoQE07JPH8/kG5?=
 =?us-ascii?Q?w3FZejAzgIc/uavIDVENe05Lg2yRbKT4lcF2r7tS1mSFC503ke9YEVn9Rhq6?=
 =?us-ascii?Q?LKAYXiTRIDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrGuUVxohk1YYKvWbR2C1suro0ZXLgpGCwfqL006yS8EECCLwSXUBpO4tRpi?=
 =?us-ascii?Q?0sDGDoZlT062C1PenTGWutmyrUuvyQMJ1K/K199JilOeHn+WiAeUsyr2aYOC?=
 =?us-ascii?Q?ubqLyvLpmAgdsEjptvITn8mMLsApQbpqmlCzXFgLi1JuTR+0yUxLLttB0pj6?=
 =?us-ascii?Q?TI7ulPLUJ4tmEwM17s82eBqGWa3ELbM0DOjnddoKm0G7MyJl3P6eBZHbdzg5?=
 =?us-ascii?Q?whxqN4pEseTP1wrU9QH/TrnDRpjajr3R8G3BrIdH01426qZbHTKErCYQfYXe?=
 =?us-ascii?Q?pZECOx4dIVisfPLKkrEloEcZdnmPrPot2+mZQYz/ZecCD8Xa2T4GtGlKjKWS?=
 =?us-ascii?Q?lSjlfEp6fSUWcQ80j8z+fV/1I1oAxFXxiJyU7ncmgUbM0ZR9zCLIkwAXq6FA?=
 =?us-ascii?Q?OBmkd3e820IwFi1x8VCjhmDMqE1Uxw7uwYVZmwz88fw3DSYeeFlmrrAwHH8J?=
 =?us-ascii?Q?0wFwVblR/jgQcvQ71YNsgsdUmkAzaJL6j6oWBHIvLrTD/6FGoG4LJwzBH3TY?=
 =?us-ascii?Q?1NFpMMBMThRvlUfdJqIIg8DDw5LW5hBJineGIbk98Okvy+sdhwB3+Mgt0Cwk?=
 =?us-ascii?Q?OEqfzmlxpJZjE2IyGTPs38GpFL3OZlKN6C5LiAi5aTUqFwOmXtcHIyfXv/Vm?=
 =?us-ascii?Q?qzjSM1LKjOrCYPrm6D4ocINAty7G1WRvhUjNpCttJ3aB8mnRVbGOTkKlqJ1K?=
 =?us-ascii?Q?QXSqR7pQgVkAgPPgZcnVW11/JJYYarzUu390GhxR43nxX7Rkg1mEZwEhvOaJ?=
 =?us-ascii?Q?LsjUkhGTkfX7ExHaW6jM66CEQ7QbnXF9KRRSkQpA53GMM30bnlfpVztK0ujY?=
 =?us-ascii?Q?HM4CDpDnTx7kM9k2jyFjBX0Q8jc7VnZephv/o+Js9GiSwcwgDq6pOjiODK7P?=
 =?us-ascii?Q?9bwzZjntJuefVyB+FAfO6k5nrV/LZ2oaemPUOaFVMpTy+BvQ7dC1wZJEe8kv?=
 =?us-ascii?Q?R3Y9WypSjmGK88WZJcVgQFqXo7p12devYfMuFEhz4PU+GFkwJH0io1CCF2Me?=
 =?us-ascii?Q?uNx2vxellzNcrxzYzIj2FdhvlFl/h2PAHfuP9ljOCIg11Q6Ux/DfTKXDG40i?=
 =?us-ascii?Q?nsQ0MwhdNfLbYzzH9WDna9YOsBC3h/n/2aObTSlILzusTQIejLiJCbdoe6vB?=
 =?us-ascii?Q?CwzA2uuefDaOL5OWecPCa1jF+sEYtSNVFt3mCZo8/UzfukuWATgtUIs2D2Wu?=
 =?us-ascii?Q?Mr0/AZNCbFRD/X6pAdrdaB5y3GudWzqU72mKC/GvaLz/g8zazjqgLQJ+rmdF?=
 =?us-ascii?Q?HFivPOvWqqChlidxA6ZkzOL6u85nLfmLcfNCwHNoytIdBNzE6Dk7AiDw6v+J?=
 =?us-ascii?Q?dX1CKs5y66eAsS0FFZ4VLPuwMhizm6J7d36umltPMD4mf0EReyFAC4nFn/ZI?=
 =?us-ascii?Q?SfsX+C+uzXMRY7UcD20cXvgu3QZSgH6hXKfrFOghlbs59ut9EKEm30yt0zUM?=
 =?us-ascii?Q?wvm1AdpZ0eUjyvggHa55zo20x1ktXdCKVCNRsug+xB6+bS3gyi6Oq698Thnb?=
 =?us-ascii?Q?VlASsWgnlKuCk5CdyVinCphekdJKtjHr3ZLFWW3FsuIqzJdUdkzPwSfAbOwz?=
 =?us-ascii?Q?b5LGu0xHAP5PzvsSo8nmppCVLvsLUpMTgggfUhFrleGkonVy3wcmiYdy8sEg?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pvrabymSP6NGYua/RvBMN+reNaaeZweBNdVbfI/Dj03jfh4mX6wIRvpPBss8pj95jdmO/L4SKiVb8oQztncPY7uN1T1vgKREuRjquHcLH5nukARvhUzAmSHwA61sy05QXmKP7Vuinf0x3t9gymfPJZG+8FBOWAuiiqhnhVaQXGte/kuRCUHO3ETIU4ORxlX6OgJ+cF7tFN8mL2edVCMiTv4CrjW3+8HcMlqWkYLFyoD3qZD2cU2vwnXubMkroJ1kmMCU+miuu8luqJuPlHqO5ICwHSpfuHLblcxGPXq9tP9sd7uFIVrGZiQbGVHucCdfQoK8C1T5hdnN/TDgx3LO8rCG9jqNavjtWjsljFATuwjOT0gq/fuh7Gx+6uf7tc1nycxh3IqMrUDw8kLx3tjX7pDwRSKsSdpfbmBjt/SomFIQwwpILvB35B7dQXt5mRuUFyfeSS3Mi4Yl3UGAgqcOrjIrCnfIahGr8c7GARoEhfXlAKaLe+OYftmh7BlCGCZX1GQFpIl+2+TTo8MVvLaLns6lSTEGhwu3iSEfr5DWKJiiwpu4Z6h37GaJjON5l1wHZk8vdIfAkC80xeWIytlLFoISpqYMaE9acK1La+iPk78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99983b1-23ae-4463-fd2c-08dde9e86674
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:17:31.8834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imhm78tcPYwXOUz58JBwbKQNHMuizAB4gSqht75X4ynPINlL7lOpBaUGDME1c9OyjMo6pFRX17U++tKWWpjL4PMMHRvyO+b6TTynu/FngeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020060
X-Proofpoint-ORIG-GUID: X9BBKp_2cqCZdk_bYKuG2Zt9xYMLOENU
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b68bff b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=yPCof4ZbAAAA:8
 a=c1qRhdn-lT5j9CpT88IA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22 cc=ntf
 awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX62iZvOtlWart
 DWsoAK9fmx6b7+4EGCKcNMv71pte89erM/SuNgG160UEf++anlhWH7obsqI6Ji1FDXF9o/C5Afu
 ren/Az9WeU+KZeU9z+RDwKJfNI08U13UE02V11auJHLDpehM68mdnODetw+B7l5K6EVMP3Odmjf
 piZpfCLdYSazbxXcKNSTFTiyjlqc+oYMhxkEHreCUwvzVYBgOEGIWnvQEBYBiR5dG+Z9KfOHV+4
 ozP6PQuYQUG18eB2M3N/NlVQmce0P4fnfcYhPIfvswu7sYehqt6PT3hv6EESP07xUXVrL8FGutm
 8QV4g1LIw5jciDhMoxwzy2YEG/APGs8xSzW6jq4QrDs10Z58WeETdG4Oatsuau0AwTR86t3P1kG
 yYpu1DNm1myRTGXE2pfMov1sexzQHg==
X-Proofpoint-GUID: X9BBKp_2cqCZdk_bYKuG2Zt9xYMLOENU

On Mon, Sep 01, 2025 at 10:50:21PM +0200, Max Kellermann wrote:
> Lots of functions in mm/highmem.c do not write to the given pointers
> and do not call functions that take non-const pointers and can
> therefore be constified.
>
> This includes functions like kunmap() which might be implemented in a
> way that writes to the pointer (e.g. to update reference counters or
> mapping fields), but currently are not.
>
> kmap() on the other hand cannot be made const because it calls
> set_page_address() which is non-const in some
> architectures/configurations.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/arm/include/asm/highmem.h    |  6 +++---
>  arch/xtensa/include/asm/highmem.h |  2 +-
>  include/linux/highmem-internal.h  | 36 +++++++++++++++----------------
>  include/linux/highmem.h           |  8 +++----
>  mm/highmem.c                      | 10 ++++-----
>  5 files changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
> index b4b66220952d..bdb209e002a4 100644
> --- a/arch/arm/include/asm/highmem.h
> +++ b/arch/arm/include/asm/highmem.h
> @@ -46,9 +46,9 @@ extern pte_t *pkmap_page_table;
>  #endif
>
>  #ifdef ARCH_NEEDS_KMAP_HIGH_GET
> -extern void *kmap_high_get(struct page *page);
> +extern void *kmap_high_get(const struct page *page);
>
> -static inline void *arch_kmap_local_high_get(struct page *page)
> +static inline void *arch_kmap_local_high_get(const struct page *page)
>  {
>  	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !cache_is_vivt())
>  		return NULL;
> @@ -57,7 +57,7 @@ static inline void *arch_kmap_local_high_get(struct page *page)
>  #define arch_kmap_local_high_get arch_kmap_local_high_get
>
>  #else /* ARCH_NEEDS_KMAP_HIGH_GET */
> -static inline void *kmap_high_get(struct page *page)
> +static inline void *kmap_high_get(const struct page *page)
>  {
>  	return NULL;
>  }
> diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
> index 34b8b620e7f1..b55235f4adac 100644
> --- a/arch/xtensa/include/asm/highmem.h
> +++ b/arch/xtensa/include/asm/highmem.h
> @@ -29,7 +29,7 @@
>
>  #if DCACHE_WAY_SIZE > PAGE_SIZE
>  #define get_pkmap_color get_pkmap_color
> -static inline int get_pkmap_color(struct page *page)
> +static inline int get_pkmap_color(const struct page *page)
>  {
>  	return DCACHE_ALIAS(page_to_phys(page));
>  }
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index 36053c3d6d64..0574c21ca45d 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -7,7 +7,7 @@
>   */
>  #ifdef CONFIG_KMAP_LOCAL
>  void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
> -void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
> +void *__kmap_local_page_prot(const struct page *page, pgprot_t prot);
>  void kunmap_local_indexed(const void *vaddr);
>  void kmap_local_fork(struct task_struct *tsk);
>  void __kmap_local_sched_out(void);
> @@ -33,7 +33,7 @@ static inline void kmap_flush_tlb(unsigned long addr) { }
>  #endif
>
>  void *kmap_high(struct page *page);
> -void kunmap_high(struct page *page);
> +void kunmap_high(const struct page *page);
>  void __kmap_flush_unused(void);
>  struct page *__kmap_to_page(void *addr);
>
> @@ -50,7 +50,7 @@ static inline void *kmap(struct page *page)
>  	return addr;
>  }
>
> -static inline void kunmap(struct page *page)
> +static inline void kunmap(const struct page *page)
>  {
>  	might_sleep();
>  	if (!PageHighMem(page))
> @@ -68,12 +68,12 @@ static inline void kmap_flush_unused(void)
>  	__kmap_flush_unused();
>  }
>
> -static inline void *kmap_local_page(struct page *page)
> +static inline void *kmap_local_page(const struct page *page)
>  {
>  	return __kmap_local_page_prot(page, kmap_prot);
>  }
>
> -static inline void *kmap_local_page_try_from_panic(struct page *page)
> +static inline void *kmap_local_page_try_from_panic(const struct page *page)
>  {
>  	if (!PageHighMem(page))
>  		return page_address(page);
> @@ -81,13 +81,13 @@ static inline void *kmap_local_page_try_from_panic(struct page *page)
>  	return NULL;
>  }
>
> -static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> +static inline void *kmap_local_folio(const struct folio *folio, size_t offset)
>  {
> -	struct page *page = folio_page(folio, offset / PAGE_SIZE);
> +	const struct page *page = folio_page(folio, offset / PAGE_SIZE);
>  	return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
>  }
>
> -static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
> +static inline void *kmap_local_page_prot(const struct page *page, pgprot_t prot)
>  {
>  	return __kmap_local_page_prot(page, prot);
>  }
> @@ -102,7 +102,7 @@ static inline void __kunmap_local(const void *vaddr)
>  	kunmap_local_indexed(vaddr);
>  }
>
> -static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
> +static inline void *kmap_atomic_prot(const struct page *page, pgprot_t prot)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		migrate_disable();
> @@ -113,7 +113,7 @@ static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
>  	return __kmap_local_page_prot(page, prot);
>  }
>
> -static inline void *kmap_atomic(struct page *page)
> +static inline void *kmap_atomic(const struct page *page)
>  {
>  	return kmap_atomic_prot(page, kmap_prot);
>  }
> @@ -173,32 +173,32 @@ static inline void *kmap(struct page *page)
>  	return page_address(page);
>  }
>
> -static inline void kunmap_high(struct page *page) { }
> +static inline void kunmap_high(const struct page *page) { }
>  static inline void kmap_flush_unused(void) { }
>
> -static inline void kunmap(struct page *page)
> +static inline void kunmap(const struct page *page)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>  	kunmap_flush_on_unmap(page_address(page));
>  #endif
>  }
>
> -static inline void *kmap_local_page(struct page *page)
> +static inline void *kmap_local_page(const struct page *page)
>  {
>  	return page_address(page);
>  }
>
> -static inline void *kmap_local_page_try_from_panic(struct page *page)
> +static inline void *kmap_local_page_try_from_panic(const struct page *page)
>  {
>  	return page_address(page);
>  }
>
> -static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> +static inline void *kmap_local_folio(const struct folio *folio, size_t offset)
>  {
>  	return folio_address(folio) + offset;
>  }
>
> -static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
> +static inline void *kmap_local_page_prot(const struct page *page, pgprot_t prot)
>  {
>  	return kmap_local_page(page);
>  }
> @@ -215,7 +215,7 @@ static inline void __kunmap_local(const void *addr)
>  #endif
>  }
>
> -static inline void *kmap_atomic(struct page *page)
> +static inline void *kmap_atomic(const struct page *page)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		migrate_disable();
> @@ -225,7 +225,7 @@ static inline void *kmap_atomic(struct page *page)
>  	return page_address(page);
>  }
>
> -static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
> +static inline void *kmap_atomic_prot(const struct page *page, pgprot_t prot)
>  {
>  	return kmap_atomic(page);
>  }
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 6234f316468c..105cc4c00cc3 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -43,7 +43,7 @@ static inline void *kmap(struct page *page);
>   * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
>   * pages in the low memory area.
>   */
> -static inline void kunmap(struct page *page);
> +static inline void kunmap(const struct page *page);
>
>  /**
>   * kmap_to_page - Get the page for a kmap'ed address
> @@ -93,7 +93,7 @@ static inline void kmap_flush_unused(void);
>   * disabling migration in order to keep the virtual address stable across
>   * preemption. No caller of kmap_local_page() can rely on this side effect.
>   */
> -static inline void *kmap_local_page(struct page *page);
> +static inline void *kmap_local_page(const struct page *page);
>
>  /**
>   * kmap_local_folio - Map a page in this folio for temporary usage
> @@ -129,7 +129,7 @@ static inline void *kmap_local_page(struct page *page);
>   * Context: Can be invoked from any context.
>   * Return: The virtual address of @offset.
>   */
> -static inline void *kmap_local_folio(struct folio *folio, size_t offset);
> +static inline void *kmap_local_folio(const struct folio *folio, size_t offset);
>
>  /**
>   * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
> @@ -176,7 +176,7 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
>   * kunmap_atomic(vaddr2);
>   * kunmap_atomic(vaddr1);
>   */
> -static inline void *kmap_atomic(struct page *page);
> +static inline void *kmap_atomic(const struct page *page);
>
>  /* Highmem related interfaces for management code */
>  static inline unsigned long nr_free_highpages(void);
> diff --git a/mm/highmem.c b/mm/highmem.c
> index ef3189b36cad..b5c8e4c2d5d4 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -61,7 +61,7 @@ static inline int kmap_local_calc_idx(int idx)
>  /*
>   * Determine color of virtual address where the page should be mapped.
>   */
> -static inline unsigned int get_pkmap_color(struct page *page)
> +static inline unsigned int get_pkmap_color(const struct page *page)
>  {
>  	return 0;
>  }
> @@ -334,7 +334,7 @@ EXPORT_SYMBOL(kmap_high);
>   *
>   * This can be called from any context.
>   */
> -void *kmap_high_get(struct page *page)
> +void *kmap_high_get(const struct page *page)
>  {
>  	unsigned long vaddr, flags;
>
> @@ -356,7 +356,7 @@ void *kmap_high_get(struct page *page)
>   * If ARCH_NEEDS_KMAP_HIGH_GET is not defined then this may be called
>   * only from user context.
>   */
> -void kunmap_high(struct page *page)
> +void kunmap_high(const struct page *page)
>  {
>  	unsigned long vaddr;
>  	unsigned long nr;
> @@ -508,7 +508,7 @@ static inline void kmap_local_idx_pop(void)
>  #endif
>
>  #ifndef arch_kmap_local_high_get
> -static inline void *arch_kmap_local_high_get(struct page *page)
> +static inline void *arch_kmap_local_high_get(const struct page *page)
>  {
>  	return NULL;
>  }
> @@ -572,7 +572,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
>  }
>  EXPORT_SYMBOL_GPL(__kmap_local_pfn_prot);
>
> -void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
> +void *__kmap_local_page_prot(const struct page *page, pgprot_t prot)
>  {
>  	void *kmap;
>
> --
> 2.47.2
>

