Return-Path: <linux-fsdevel+bounces-76411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMWbC52HhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:05:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA72F232C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1C9303A90E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90C23AA1BF;
	Thu,  5 Feb 2026 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pOu5y1pF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rcif8FUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D201CEAA3;
	Thu,  5 Feb 2026 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292971; cv=fail; b=j1HafzDnMv9hsNov6wU9dXLH8Q9E3VZ1k5BJOYPeyRxJC8u9ukOEtGVUJaSCOujP2wmLlpBCVugKRD7+252CRIWjrk4T+JOROJKC5h1NIscx9OazJw2OL7iUiR4VN6q+Jz4/RUhXz6cQXY7mt7aoiRaFeKGDaSU4RNZJJknP5+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292971; c=relaxed/simple;
	bh=lwP/NprVYYh7lE6NtebbtR49UKNHoEYlzNDGxd0BqgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tlSqOASiIzsT4Cy9IEanPmFFBLIbABqOE/9dO8strNXJZw3U8lPHJWFe3UFY+ppzgEhgQ3lSjQxiWIehaTd9gkmz6rlsMQIJC2x8M/2AfvMVGFnQ/RlStQvKJTBIgvvZ3mfQVvJF55FIdJpMV+610LMjT2Dyb/6KvJ0E16jGGh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pOu5y1pF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rcif8FUe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614NtWlD2399263;
	Thu, 5 Feb 2026 12:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=q9LKsjNYPcspGe8sKJ
	YFd7m8aY5wQAMqBW3T9pnLlmQ=; b=pOu5y1pFBV25TJqpw0UEuhzovExUNL2Quv
	F69vaD4UdqIHTIE8dGkfAW8LRoYIH5ktitxyHYJvuF2ugNj25qu7UmEy5/Ql2OFO
	Nm5+5alFeTr0RmDtqdjjqABZWzYWNCRyzR9xYvBZM8fo50993R6ms8YPBHh1Qxl3
	GXvsIj2qKg4NaXdbGesjptevNCw7rB6KLq1NOgfd65kFnIb9qZiZ5FDuANOYuxw7
	BEqsaBB1AX3P06s9FwQiF56ssXpGnS39yRB8Qp6nuC5sOHKFurB82g+LiN3UkXuw
	4BkEyp1ebV9vmlr1gb+1Jw41N4ZkgtOjdt8zPXvEo154dZYHAaBA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k5g3dj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 12:01:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615BdWxK034780;
	Thu, 5 Feb 2026 12:01:05 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d247t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 12:01:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2pPUOveJF1CU56FKTXX4aV0uWF8QMO91l289GLlS2iJLBY5vcwGHgpOemcwc1oOaIygKSIRs3mIlzP22izbEn7o/ywQ8J3e/I4EfNR9/F9JrQPRcv5A803U8J6Y8KBi68xhW9HAWjHHckG5d8gCDd2sHBwAXh3boFHMwKcT1Iz77rOZH69CVeLD3+F7SbH3bpW//qqQ8zcVG7DsGjBk+tjZXjk9OeA+QD2hQT/4EqSMvOJe+TXkuiSlZIgNXTQrVfHhO5S5zfFT9rChJRP2xXJTs3RG1ZxmP0+MfJ+DWTF61GYxnsOJIyoerIfUJNwj8m0CJ1Zso4LldkjbG+vnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9LKsjNYPcspGe8sKJYFd7m8aY5wQAMqBW3T9pnLlmQ=;
 b=e4rCWWEXCfB/g8R46Teg/KpnFfbWEJyDIwKRJ2KkU8HmlnjI3LGjDTizVUJFx0+SxfvcOv6g1EKHo8vFL5qJWTk3jLNmpDMOsUGGkMY69Ce3mZau6JOUUlKUH8c/VWHN6eL7BF0o1iGBwJd9RhIK0WCK2vY+Tf8P2TyDAKkSS8A1PFuplgYUxL3AHShoo0A4CllDi2xxAe4FjxJSwRiHS0ne8Bx+pVwb4urfUJgk/08JVCD1NmKLGqt7YqKGG7SOT44iKfloUV39WOvUNJez0ab1/uilbuPX69iFTmjnNeOqqAY4ZG3OdqM0k47q9SX6BhNcoaoNLIbNQRNq1Gpg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9LKsjNYPcspGe8sKJYFd7m8aY5wQAMqBW3T9pnLlmQ=;
 b=rcif8FUeKY3WfRwz7xX7zuDEOlB9bBjW1gj6UUm3a0xmDpM0XPb2jKoL2Qzl0SZfDs4GM709kPceGIY0tQqw7F6EgF63013VCW/M7V2BQfOXN9pMsNm/ZGlRD4N2qwCSweo6k+suLobOwgCAc23dF9EtUKcoZ7k0PN4qi534J2Q=
Received: from DS0PR10MB8223.namprd10.prod.outlook.com (2603:10b6:8:1ce::20)
 by DS4PR10MB997669.namprd10.prod.outlook.com (2603:10b6:8:31c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 12:01:01 +0000
Received: from DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9]) by DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9%5]) with mapi id 15.20.9520.006; Thu, 5 Feb 2026
 12:01:01 +0000
Date: Thu, 5 Feb 2026 12:01:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        kernel-team@android.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
Message-ID: <4a36c1e7-e51a-4c06-8f7c-728b278af972@lucifer.local>
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com>
 <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
 <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org>
 <d122f9be-48d6-40b1-9da8-cec445bd8daf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d122f9be-48d6-40b1-9da8-cec445bd8daf@kernel.org>
X-ClientProxiedBy: LO2P265CA0175.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::19) To DS0PR10MB8223.namprd10.prod.outlook.com
 (2603:10b6:8:1ce::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB8223:EE_|DS4PR10MB997669:EE_
X-MS-Office365-Filtering-Correlation-Id: 3409a181-51f2-4d1f-4972-08de64ae3b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?54sRmei7UNemfwsrQ5L9a5uUCackVyFUYeTdHAzRlyL7+Ytk2pffoD7G4DzY?=
 =?us-ascii?Q?QCmZ8nykLfNDZ/3Q7jxO7O9/RiTST5hS3nlggAYXKWVL0U9yZEp+/871WUMj?=
 =?us-ascii?Q?owtko6JwSfQpjN6arGNeKoq0Pc3kmfT0jsizTGYwiJl1FqwYvM6t8MJGGgw6?=
 =?us-ascii?Q?ugL2L/RaKWdJ7Ib2JqCN8t9FbizbzhBW/84mk8/y6CSi8n+IQGQxyQxX93hn?=
 =?us-ascii?Q?/3H+M8JLbChq88KZs5AdBe+VVyAKSM7EF6+AHLXqasE7I0lUOOosO00YzGCL?=
 =?us-ascii?Q?imk4rY4rlPedAYyi5S1ns/YeFDP1TLlrP8e6QVC9x+u986Ux24FEJweK6oPy?=
 =?us-ascii?Q?c/vRX5fIBbLT0a1z841uat02Wz3vWMaULMkdg20IiquuFl1DP+/ovtLuYAnu?=
 =?us-ascii?Q?SJlEPt/UpGHqiaQE+n6F/qCUQup2spY7SRYdMo6aLfhgBckzhTghpquuB0pp?=
 =?us-ascii?Q?UEmbpObWcgCl027QJSb1+nEXdEtfzpJgtefWDLN7E7Typlt9agPjsv1R32Ld?=
 =?us-ascii?Q?bmAkHghbVHTWEdsXhGxNUrLqSvTPcA6vWfBjuHMvsMtMZyB2rkg67baGYCul?=
 =?us-ascii?Q?nOa8iaPF1USdYklxNsFXcUmxNSBC2qWJvLylAeBFY9a5a9+btpCK04+bm19T?=
 =?us-ascii?Q?Jb9nidftgQ0gfRB51mXxgx5agv+xQppvC4HDGGF+5JrCw3D1T8zbwwHWpuzT?=
 =?us-ascii?Q?8m3rCU9xGO2R6fO4mkmgiZBT/jGl80tiQodKXu2XPBmLBFEkiU7Jn8Kj2CAM?=
 =?us-ascii?Q?yoTs1R21DmV52ylxTq8oLKXoOqvIyVmZcsgFDk8DeuFoamU2EowYJAY7oxUn?=
 =?us-ascii?Q?Utkj7sasyri67AaCxYXEK3ahguHK+lPtYG143CEwwRLRfg03F7DTKw8zM3DE?=
 =?us-ascii?Q?UVf7szHuihqc12j3/MqK/fmLytN/8bcqgkSbLSuD7neKUQGQBJwTvEv7u7ye?=
 =?us-ascii?Q?fh3QR8istwLnz3RzWqYBFAE1l0hv2/eltlXc/ctKQL43EFqoN7de+btgk7i9?=
 =?us-ascii?Q?J6FLVe05JnLsqHWF28XvFZxc46MbRoSXtpum7crL0p4aOBwmvQha1KT9oMsq?=
 =?us-ascii?Q?03hBZqTha1peiEezJE2iy/aaqjkl15XzyFpVslRdAyXeVa3TbTTIV+fXtv1h?=
 =?us-ascii?Q?b2wQPZQitOM7ED/p86uiH8YyX5sDagrg3+vUtn0P8mYTLciFILL7SjCj/HZH?=
 =?us-ascii?Q?53zVV8l28BqRmeCgqGMHy1w+yvSv86pi27gb5MC6J7tzB1V9PIl6txa462ZK?=
 =?us-ascii?Q?Z/mKPzw+XteTxYt++SQzZyUu2Qwfju6iYsJHYin0MGx8YCDYp7d1X4X8rZW3?=
 =?us-ascii?Q?iph693ac166WH/pAJcIqYmvSAvIQGp+Ty1qTTQ9wTL1j7j5lPxJUxxK6vE0B?=
 =?us-ascii?Q?+6otXS7YVRFErOUCLPzsijYhgj57QUqibaNhKMoCiEBdO7Sm2YH5Br4J1+QN?=
 =?us-ascii?Q?lC8FuQkn04YAxeMWvj/ZCf8dSx8aDU70RScwXOQ2m0CDuUml+QbNE3LNrPSH?=
 =?us-ascii?Q?BwOCijLMmi6aGpWI25rPtwjsYZJp1lXvWqA8run/Q16TXR5TXbYWC1hgAuoL?=
 =?us-ascii?Q?5JOjPkTHyYtdO5H62Bo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB8223.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+8+w1F08EeLayMXKWHKzlTo4/KbBH2z0JVgPUMJiLiwHFfIdk0S7le79EYqS?=
 =?us-ascii?Q?3/fi10gzi0yCVwirYI1+x3uXVxxs/MnIxrfzb9RwV8SvZJLzJTS6T3oJa0T5?=
 =?us-ascii?Q?vuWQB+cWE7ebBm2ApFbDyWDKSHZE4PDY4BXVucpzX9KbsdcFZ1KeQJWqnSL0?=
 =?us-ascii?Q?ue+DelIa4xE9atHdlTWff9BeniLfQTYn2q1IsYEn5+MBEO9e4DwxsEtH3swV?=
 =?us-ascii?Q?cDxIwUUiEPwkjUWMuPwtecsUU9kCxERZ+w7v+SqWqN2LphS2DSmj9USJCq5d?=
 =?us-ascii?Q?CTSmf5g44EVOSf1fxiyEMIzXMvv2UG3iZoWFdA1nrCllCMhCQj6Mp7HGfeKf?=
 =?us-ascii?Q?H0oYhewbullAW/pAV9JndMlQrNtFepoAsHmbgGyoZQxMeNrLNDnlVaIQcSAr?=
 =?us-ascii?Q?YAC5T3za6FJwrFCmNzvmI/k8AX8tqwXdeQ2+jHR88jN3Rytk+NUDLkPeopIK?=
 =?us-ascii?Q?POnC+L0OBhalltnre+tKOUyP0X80JdqC1zePqAg5rwRzWXEoLZGQ+fA/Yrsd?=
 =?us-ascii?Q?eGHUzGjL4sEc3XOYDU3LaGKDsm/AJnF4DmxQUVdPjxAzxRHbZY7V8PHh8KJL?=
 =?us-ascii?Q?lrHsF2tLcbtgCVl7DcIwpSpzVKYQWW/h1Tq7f7YfLPrXiWOV5R7t9J3+n3ST?=
 =?us-ascii?Q?c7Lxv6yJDcKzR8/1wKFMCbD2cqydPwa44JsBFjkALZhqWUWq8TqfU6jJNtj1?=
 =?us-ascii?Q?CwjP3XgV88UM0oFl4NlOjGt1PBfqZjI1bJEEU7R44QS/CCi9k+PhyUTn1Lb1?=
 =?us-ascii?Q?XrzNmKIWthorx5dQUvlwS9VDBskddNDewRyGuR7dOKSLvNJHrJxl3dyOme0d?=
 =?us-ascii?Q?DHCoJ2ytHHQmVvaw9l/VNg15HUkh7/3fIhHg5SFLGb1bd9nVbA2tipHZcdpD?=
 =?us-ascii?Q?u66j3Lj283tKM++q2hcftTyOEMSkbvnFcI/bVeyyrEaX6bRKXMfyuJ185mTg?=
 =?us-ascii?Q?wxJ8rS7nSXWvgpW+pXKaborKGPThaMuxev1ebMMQKHEvMmr4UowS25al4XIH?=
 =?us-ascii?Q?XwM9pIj39MU19tDMG9H7CW7xbJXNDGtq/D1xGjjn+NR6dnU/VbYs+bGjXvh4?=
 =?us-ascii?Q?jvJYj7haMLo2OKFVa4kOSfO5O+G+zIEzvLzCRsNz5uroBvE3qEqEwCWuUE/V?=
 =?us-ascii?Q?tM+tOMldEHpMNzFwvyrAs+rqe+XmUszLiM3HarJ6rlAvw5meDTuEVa6YzGgP?=
 =?us-ascii?Q?h2WAxpqU/m27z+AUXsvjLct0GI84vQ3TF8F5KLQczCGeOx6Y9GvOvnj731sF?=
 =?us-ascii?Q?t/Ne7BQJxpKgvatL4csTdGGKyWiwhJeDcXI0yy7orjf2Kp8sUadIMtXDhgYC?=
 =?us-ascii?Q?7h9dZfwVh7WVks92qtFnX1rf9hWPy+twWPJUk+mq3fZPKWEY3pioplR7HPfP?=
 =?us-ascii?Q?XKPInWZCegJ4bCSJBXXtSWEiOre7oJw6Ttq70VErBMIFKX2HqHrXeCaGhNxC?=
 =?us-ascii?Q?v5bFzfejfKdCtfnvH/402VfgKjenFSqm4K7i16QM1dZoF1S2ot1CMNv9ZsnF?=
 =?us-ascii?Q?2d/AvamUnAgIo4DIQZLXkdORX9qnT3d8BJJq9DrwW0hSc37sdZ0QcuATf0ja?=
 =?us-ascii?Q?e949yEr9sNAeZ5LbYjbWPmoi56iezs70/nArs9qXYk0xnTBbUqwDLJ6nMBcr?=
 =?us-ascii?Q?MZONFTE0gTv8aHftUOp5zn1bS9sf2unZrTHMKmtqwrqW0/Q+VB9kemRQzJWn?=
 =?us-ascii?Q?dJUBB0Xm7lmHTSQZam++Y+vM1eQfV3OUxMVFo0AkHaSpbIz1bzaOZBghHtVf?=
 =?us-ascii?Q?N18vyGG9iVd/Qn1f12Zyjax8x/RYWZk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	krMdPbEjr6QV0yrYLHgy/Fr1K9JItk9gRrZZAkZsW9tCQXM7K10ZtXkU0c8dJEkTa+8CAaxRnhkZN00mBYMY+aa5+SITnr11QJyOkNm/XqKFMGXuz/X2DTtGKAieBK+fZOhbhQbno8EVzkXRab7qxWTdbSyE++NKQNdZPLz9DmDeCxNwbDOWXxVRxcZ7ffPTQuRuBPuK4RrMUBmxSk3gIa261apFGRlcTEVfG8oVPXc5F9dW77AKFaf3YvDV0M05XHsLZLwa57crALVcpUs3r5eKpaq3JcBmZwhwMAV7RaH0lBNPTyZaTh3IlX5QT21r+oJpNc8vtZ6LedkHMf1oPal3i2UQrycbLM22M+3G+QeGGrfrCGtF841lFEH3il8UZN27bOTf6z57Al0TX9dwB5P863TS2/OdywEFKYjZxw5vp83dTsNbkgA8SLEMl6OQsbNOyIVH0FN6NFufDO29tIbSs8SRe8+GFHm6BGJ9tdZMkL3/QyJ53Fz0bSg2px7T6AItIb2W30x5o5p31j+0rZzZsbgL4CxA/eLzp3Umj7MEpS7AMuHb/6IWBfCXi2DGw9zF4MgLehqFfssTv0MThKobBYnU2Gjcq0ClO2oWV2I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3409a181-51f2-4d1f-4972-08de64ae3b59
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB8223.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:01:01.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPwINoTPTMoNDQBB6FqglCPDSMwKsHFBNgwCea6zwA7BkXDZXxwxz9FDeaiuvYIvbMV8NDcgZQVj8/xPizywO990p16xCva2D3GkQgGvTT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050088
X-Authority-Analysis: v=2.4 cv=Jor8bc4C c=1 sm=1 tr=0 ts=69848682 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=_m2LY8w2hJ6ZPsdBCRcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Zjj1e1I07j4EjLH-wwLSt4w-Re2a4UyI
X-Proofpoint-GUID: Zjj1e1I07j4EjLH-wwLSt4w-Re2a4UyI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4OSBTYWx0ZWRfX2xcHWEbBovMr
 +7BVpOP0WzCGXzA8Fizvku0Y9NqNOeVwLt6xHxxux6UXVzYSLrjKWBBrn2HUo1kRgOAdGgURxxs
 NRyAvYoMm+G5RjXqGRwzhaKDXQCReqAZdLqxPXYBmG8+u8MYcY+pIDb9R+pV3nmtEekFHGJefD0
 0389BmFu02TQPCpmHFpWUvdbt0C2BAhTBTp5TeHbKxXMR/XSIa2S8wyZ+GgUqGwj+EIsHisxZyY
 4A8Oiy1mwviEOuipaYsJrLoZ8M0gv8jFl1wwMiOtrDxNTX1AjaXkIaMm+DSpc3sPyxKHICuz/Um
 3E+UFi6R498miiQ68cKURyFoocw+0Wuwu1VZ7rOPbIWjq4S08BN0+3zwd0WBbeo8Rkhjqnnh3/W
 IDbjFEFcEZJvTv//r46rhflLKI9IooUJqTw1caNKZV4TKB7R237YM0+g0B582IogHMa6hKuLNs8
 3EPNQYTbiXE1ij6xGqA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-76411-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer.local:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7BA72F232C
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:57:04PM +0100, David Hildenbrand (arm) wrote:

Dude you have to capitalise that 'a' in Arm it's driving me crazy ;)

Then again should it be ARM? OK this is tricky

[snip]

>
> The following should compile :)

Err... yeah. OK my R-b obviously depends on the code being compiling + working
:P But still feel free to add when you break it out + _test_ it ;)

Cheers, Lorenzo

>
> From b1c35afb1b819a42f4ec1119564b3b37cceb9968 Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (arm)" <david@kernel.org>
> Date: Thu, 5 Feb 2026 12:42:09 +0100
> Subject: [PATCH] mm/memory: remove "zap_details" parameter from
>  zap_page_range_single()
>
> Nobody except memory.c should really set that parameter to non-NULL. So
> let's just drop it and make unmap_mapping_range_vma() use
> zap_page_range_single_batched() instead.
>
> Signed-off-by: David Hildenbrand (arm) <david@kernel.org>
> ---
>  arch/s390/mm/gmap_helpers.c    |  2 +-
>  drivers/android/binder_alloc.c |  2 +-
>  include/linux/mm.h             |  5 ++---
>  kernel/bpf/arena.c             |  3 +--
>  kernel/events/core.c           |  2 +-
>  mm/madvise.c                   |  3 +--
>  mm/memory.c                    | 16 ++++++++++------
>  net/ipv4/tcp.c                 |  5 ++---
>  rust/kernel/mm/virt.rs         |  2 +-
>  9 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
> index d41b19925a5a..859f5570c3dc 100644
> --- a/arch/s390/mm/gmap_helpers.c
> +++ b/arch/s390/mm/gmap_helpers.c
> @@ -102,7 +102,7 @@ void gmap_helper_discard(struct mm_struct *mm, unsigned long vmaddr, unsigned lo
>  		if (!vma)
>  			return;
>  		if (!is_vm_hugetlb_page(vma))
> -			zap_page_range_single(vma, vmaddr, min(end, vma->vm_end) - vmaddr, NULL);
> +			zap_page_range_single(vma, vmaddr, min(end, vma->vm_end) - vmaddr);
>  		vmaddr = vma->vm_end;
>  	}
>  }
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 979c96b74cad..b0201bc6893a 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1186,7 +1186,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  	if (vma) {
>  		trace_binder_unmap_user_start(alloc, index);
> -		zap_page_range_single(vma, page_addr, PAGE_SIZE, NULL);
> +		zap_page_range_single(vma, page_addr, PAGE_SIZE);
>  		trace_binder_unmap_user_end(alloc, index);
>  	}
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f0d5be9dc736..5764991546bb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2621,11 +2621,10 @@ struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
>  void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
>  		  unsigned long size);
>  void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> -			   unsigned long size, struct zap_details *details);
> +			   unsigned long size);
>  static inline void zap_vma_pages(struct vm_area_struct *vma)
>  {
> -	zap_page_range_single(vma, vma->vm_start,
> -			      vma->vm_end - vma->vm_start, NULL);
> +	zap_page_range_single(vma, vma->vm_start, vma->vm_end - vma->vm_start);
>  }
>  void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>  		struct vm_area_struct *start_vma, unsigned long start,
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 872dc0e41c65..242c931d3740 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -503,8 +503,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
>  	struct vma_list *vml;
>  	list_for_each_entry(vml, &arena->vma_list, head)
> -		zap_page_range_single(vml->vma, uaddr,
> -				      PAGE_SIZE * page_cnt, NULL);
> +		zap_page_range_single(vml->vma, uaddr, PAGE_SIZE * page_cnt);
>  }
>  static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8cca80094624..1dfb33c39c2f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6926,7 +6926,7 @@ static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
>  #ifdef CONFIG_MMU
>  	/* Clear any partial mappings on error. */
>  	if (err)
> -		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE, NULL);
> +		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE);
>  #endif
>  	return err;
> diff --git a/mm/madvise.c b/mm/madvise.c
> index b617b1be0f53..abcbfd1f0662 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1200,8 +1200,7 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>  		 * OK some of the range have non-guard pages mapped, zap
>  		 * them. This leaves existing guard pages in place.
>  		 */
> -		zap_page_range_single(vma, range->start,
> -				range->end - range->start, NULL);
> +		zap_page_range_single(vma, range->start, range->end - range->start);
>  	}
>  	/*
> diff --git a/mm/memory.c b/mm/memory.c
> index da360a6eb8a4..82985da5f7e6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2155,17 +2155,16 @@ void zap_page_range_single_batched(struct mmu_gather *tlb,
>   * @vma: vm_area_struct holding the applicable pages
>   * @address: starting address of pages to zap
>   * @size: number of bytes to zap
> - * @details: details of shared cache invalidation
>   *
>   * The range must fit into one VMA.
>   */
>  void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> -		unsigned long size, struct zap_details *details)
> +		unsigned long size)
>  {
>  	struct mmu_gather tlb;
>  	tlb_gather_mmu(&tlb, vma->vm_mm);
> -	zap_page_range_single_batched(&tlb, vma, address, size, details);
> +	zap_page_range_single_batched(&tlb, vma, address, size, NULL);
>  	tlb_finish_mmu(&tlb);
>  }
> @@ -2187,7 +2186,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
>  	    		!(vma->vm_flags & VM_PFNMAP))
>  		return;
> -	zap_page_range_single(vma, address, size, NULL);
> +	zap_page_range_single(vma, address, size);
>  }
>  EXPORT_SYMBOL_GPL(zap_vma_ptes);
> @@ -2963,7 +2962,7 @@ static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long add
>  	 * maintain page reference counts, and callers may free
>  	 * pages due to the error. So zap it early.
>  	 */
> -	zap_page_range_single(vma, addr, size, NULL);
> +	zap_page_range_single(vma, addr, size);
>  	return error;
>  }
> @@ -4187,7 +4186,12 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
>  		unsigned long start_addr, unsigned long end_addr,
>  		struct zap_details *details)
>  {
> -	zap_page_range_single(vma, start_addr, end_addr - start_addr, details);
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm);
> +	zap_page_range_single_batched(&tlb, vma, start_addr,
> +				      end_addr - start_addr, details);
> +	tlb_finish_mmu(&tlb);
>  }
>  static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index d5319ebe2452..9e92c71389f3 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2052,7 +2052,7 @@ static int tcp_zerocopy_vm_insert_batch_error(struct vm_area_struct *vma,
>  		maybe_zap_len = total_bytes_to_map -  /* All bytes to map */
>  				*length + /* Mapped or pending */
>  				(pages_remaining * PAGE_SIZE); /* Failed map. */
> -		zap_page_range_single(vma, *address, maybe_zap_len, NULL);
> +		zap_page_range_single(vma, *address, maybe_zap_len);
>  		err = 0;
>  	}
> @@ -2217,8 +2217,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  	total_bytes_to_map = avail_len & ~(PAGE_SIZE - 1);
>  	if (total_bytes_to_map) {
>  		if (!(zc->flags & TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT))
> -			zap_page_range_single(vma, address, total_bytes_to_map,
> -					      NULL);
> +			zap_page_range_single(vma, address, total_bytes_to_map);
>  		zc->length = total_bytes_to_map;
>  		zc->recv_skip_hint = 0;
>  	} else {
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index da21d65ccd20..b8e59e4420f3 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -124,7 +124,7 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
>          // sufficient for this method call. This method has no requirements on the vma flags. The
>          // address range is checked to be within the vma.
>          unsafe {
> -            bindings::zap_page_range_single(self.as_ptr(), address, size, core::ptr::null_mut())
> +            bindings::zap_page_range_single(self.as_ptr(), address, size)
>          };
>      }
> --
> 2.43.0
>
>
> --
> Cheers,
>
> David

