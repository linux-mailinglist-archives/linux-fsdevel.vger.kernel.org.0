Return-Path: <linux-fsdevel+bounces-38062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC849FB2EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED13C161816
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB661C1F29;
	Mon, 23 Dec 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OgI8LAPJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ywy8tu2r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B71BC085;
	Mon, 23 Dec 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971370; cv=fail; b=PLcDQInp0DHrep3022uYksq7hFC0A/5M36DkgkRAI/A0L8FaPnqxubqIj47DL8uIupYspQq/o5EcR36nFg+x5Klz2jWpIoiWPNn+pyCV+ehuWBYwHEyIyoWFN2vVweSXtWTwnbIdDUFWki36W0YB1Irp6Ztj20wxkV1IOzF6V3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971370; c=relaxed/simple;
	bh=5E/ST3m9kLOjuw8d5D+EeIUhpzesJ3PzqYN4ashbEAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6gWAhcMsq4jK4pqwRXOhZfNm9kQ2/cTnWfpbOl/rlLOCISonsotFZXQxxpohSk45vpn+0KdH0Gn29xOrv2thSBpEzs2dPoniyBODcZXUeUmyTM+zdVhrjiH6+gSmWq3bREzXx3+6tsqfCmKg4pC35qLs8gC8Rm06vF6sj7nWYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OgI8LAPJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ywy8tu2r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGBq3o025359;
	Mon, 23 Dec 2024 16:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ZEQVR0mXdFQ3BA9Luh
	5Uiy26q1s1v+8IANMX1BY72Ds=; b=OgI8LAPJgJvC7WS+blWGodiA3g5Iamb1uJ
	2Si5lDeVSlj8A4+GbTqEVq+K06NQHHPfvc28BG7Up8eZ5seqny+CH9qFKS0GUnWl
	90rMLiW3zsHb7/OmNUwHUsu/1dd8LVhGgm42PElz+BYf9EGthbRA+5tmhUKJdsOw
	Wra71GPNmZNIBWxAcWWzoZGoIriiW8z1VWT4NTwTVgXQA4xurZijmZWmZ9TiKnxR
	efgwVH7HnF86p/2EIPpXhsPwCFu45XV0td/XERuelGODo2/3e0Q4WrOWcUEaE4W5
	ASNUKUNBBZJdSG84uF+nXe946PnB/f15B+zCf1TNj4SxNqCOyNPg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq9yatny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 16:29:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNF65dd016651;
	Mon, 23 Dec 2024 16:29:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4dcn4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 16:29:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7RcjykrD/qCCYljOwSZY5FWYutTrYLOj2av5ztEkX0iJrEeUyfY8ij3YGYIgyJTOfK2EdRp1Jmpn2PjuXPXmt3JiWR2ATJ4hexHdX4SGNJ7OXk0A7FlpqtVcuSJjYSXRmuFGRJjrEfv0JXw5p097Kpq5atzZV3eZLO9EMU7paJ//Z4FEAs5eihmZUjKkuq5H3S4cCMT8sScC6BzYgO9k47CAwb9Fkaip9C/yjUmUCxM1vrY2jqu3JswEXEnbf07MA/BJOq2sHUkXkv+uQHs4AVKSskPN+RO1wC4TG8jC394ImnF/gQFE45uY0kToXef1SV5dldhiwOD70j5Sj9xAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEQVR0mXdFQ3BA9Luh5Uiy26q1s1v+8IANMX1BY72Ds=;
 b=d1hM7uGI50IvcMRkVYJsvMl39WFf6t0nylP/13sWvJe042BzNSc35iiFixa88wr63ucZok9q/+WcuFyWWXqZz09QCEdjx1Qch1B/1sdcCBaBr8tudp7sno4jF62heAtCoizf+uoCzs0maqhUuiNvnJ4onD2OkLtLzaKWAg2xlEniBt5vyVYEQoqeG2GXwJqnbanvVjqqExESHc3vM/Y1wbJU1pJjMhQca1uEezolZBg0LbAOpM3gvb0c4HeQe4pl9wcQanylFD6TB8zQf43F8v14pI1VSz4A8Z6yCPmku9+dynUtNcpL4OzX07/YRzgFvVgx0ln9RH4tRXXekY6jsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEQVR0mXdFQ3BA9Luh5Uiy26q1s1v+8IANMX1BY72Ds=;
 b=ywy8tu2rqBZ1E71Bq3Fe1vl/QDRDtPP9/ihXf/UfS0qp026lSmD/3NAFFYrN63YJ6ks9VRzPqrlDipIVHvi6VMGRxIyagi4cqndsH1wt9PzpRmF28ShGJJdXZXsD8FrUCy5kI26bpTIDIq9Rh39ub2Qc7ipnSEuUn94/3CFimcM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Mon, 23 Dec
 2024 16:28:56 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 16:28:56 +0000
Date: Mon, 23 Dec 2024 11:28:52 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: cel@kernel.org
Cc: Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huaweicloud.com,
        Chuck Lever <chuck.lever@oracle.com>, stable@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH v6 1/5] libfs: Return ENOSPC when the directory offset
 range is exhausted
Message-ID: <4kwscifcoyb6sp47hkcr67mzobthvgnf5dnqnu66bonsplhw5s@edczkt76er2x>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	cel@kernel.org, Hugh Dickins <hughd@google.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huaweicloud.com, 
	Chuck Lever <chuck.lever@oracle.com>, stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Yang Erkun <yangerkun@huawei.com>
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-2-cel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220153314.5237-2-cel@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa44573-aeed-44b5-d5d2-08dd236ee56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hm/5ZgBDJn1BdfSSBJBtri7E4rhLbrt+VOZlh+9L/9/doCwIAzZLo6vip00x?=
 =?us-ascii?Q?KUMnwfDLCQq47FnkAzGRgZfOjPw7dkwa2Q+byia6GqRq8FTXse8iWQ14YETN?=
 =?us-ascii?Q?YmpeUPFUSfz/P6LSNuYqPOi1KK6vP5CgZ2hmTymjhivA4ZkxLcyotygfN+fA?=
 =?us-ascii?Q?Zl5R0gIbVPtLks61/RTV0ilXmGUD93Z6GFI6SpUoD4Av3KFxTtYTRnuHkhJA?=
 =?us-ascii?Q?FWDhHYzreCImQKd9JFVyRf+7XncXtVMag2IxFGAJwNJgUE6zJDid0ChrdRdO?=
 =?us-ascii?Q?OBXr2uMqP0uUnIp43alZH2LKyiDSf4c+wvWUuPq0mx7X28pjrAr4ATa0dXr2?=
 =?us-ascii?Q?bL2Andvi/XRHc81oex6lwHI9cle8l8s9nvOB+Gkp6ohClUDgsoUlJvIa2dXG?=
 =?us-ascii?Q?mGNr1kn2dijobhZoZ8wALwAsc0i+vA50KMNgItYZcttUORiyGnUZ1y5e7Yh3?=
 =?us-ascii?Q?cRngLsOPPceFcigQHZREgiXfS0fCQ8+4HQxN/SVi3I5mIY4xnYrC1jizUsgA?=
 =?us-ascii?Q?EKJi7f/ZUGbDd408d2k5fN06O7592MYOoB7ljSSBIL9padCNafBvxoJdmqdO?=
 =?us-ascii?Q?oiybrxKKQDd2tx4/KCwx1XQ9OI/Ebjd9p+n9U+3HoVoPtYImG9NqQYZpDZD9?=
 =?us-ascii?Q?/Q/6HJ/AjgJEKjWaaMOEfGrJNypNRKoalkcXPF2SMjJKvr9vmR6eS+cgZ9SK?=
 =?us-ascii?Q?ov74j1Fd9ckvTx/eS7swZHWzx7a2u00aC3L6+0QxpwWGXjKNTOJ1YfKSCqQo?=
 =?us-ascii?Q?LkRkWlQbPXZAdtgNtKPgzvv6g5tQg7AJ38kZJ29rBc7Im6qjBBdIIhrhaz7w?=
 =?us-ascii?Q?pmbVHXMh8Jd9KxwcLohQF+bwZwU+zw5Ed+7hY2aUNiFis9+RW3f/7Fo+wbA4?=
 =?us-ascii?Q?GmwOdsu+q1yo0ryx7RBkDGOLR5wo13ZkxUTN1Ve8cHGYCXnbDgu0ZH0Tt60e?=
 =?us-ascii?Q?Mpzl2Wbj5izgwGvDiWIg8OmlqpfzT1/RwdGCsQXpCFB1gdw2/UYPu6bdcJi2?=
 =?us-ascii?Q?x0glFRCCtRprxyg8EwWY8KwTx8xFABZIxKRMyxOej+1uPwYO2S9i8CvfBH1Z?=
 =?us-ascii?Q?5qoxMKID/I2ulNilXoPY7e4FeuF0aUQG9PqkyPyyb8RzkjJKP/v+ppFsK7oy?=
 =?us-ascii?Q?lquoImeNh21OXKSWAlATkL/YyDCxOte873uC+hd5+OH6qU+sWpiQ7j25ySQ1?=
 =?us-ascii?Q?V3ar0sswL4vbfrqKwvPPsymiTYbz77LRAGvuyMnKkhedKtXOJDkg7Rv3WzEb?=
 =?us-ascii?Q?C2mU0ZQz1R8nK2395RU07YAcsxwRuDNstS1OwswxUXt5KA087DMWv6YvNxCO?=
 =?us-ascii?Q?jeQQ3gCm581ca27QprixXIwM6L8zMVs+V6Sv4AFhzKx3Am9zZJNiE8huyqth?=
 =?us-ascii?Q?ziR/cXUjfHZJBaQBpKtNfO+/0skn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8TOETVcYF11k8JZRcziINjvrYXA84wMNsCv1ipo7M8rwL4UkT7auSS961CPy?=
 =?us-ascii?Q?5F6G2VyGkIMJO+iZVVE2xqEbr8F8WR4QZPEq1RAllBlYvmi61tleRGXttZ2o?=
 =?us-ascii?Q?4N8fo6DzDulgcIRPngn2v1KW+0MSMiFEjFoET992Ni0ipRZpEw5iY2iJCAIv?=
 =?us-ascii?Q?Nh8vt7NWiPIFV9zuW6+ba4s0zaCkw3KAS+rfG1SimSwlU46gSMmH87iu526G?=
 =?us-ascii?Q?IbFmM5qNBITdOrISx5eWRxBmlffNgyB/MW9dGz5A5lbmBKlfpO9gnEdW4gDh?=
 =?us-ascii?Q?D36Bo+So0nROznV4czAita5tilDGiRYYrL9QHn7PDQNWMb+jTuqw/lHGI4Yd?=
 =?us-ascii?Q?DkXuZbUdJC+pk3F7h5NGns1+t2f6ahcui22u8CRgGfpbylOLlNgmkjpqlUpa?=
 =?us-ascii?Q?aWPFEmYrkT7nKK/iUmlUrOMRpzs6e7ZuZ6f8iMv+G4rX1ci3YfDXPSxYqwNy?=
 =?us-ascii?Q?iMNWmSwNW3Odz7AtaMME+64D7jQReeOV0zv9Bxtn+Zi1YZSSEqPMp544lSOC?=
 =?us-ascii?Q?hod4Ylnei9C10zcINzClGheBgPCjxoyj7gFphfJpMKKzIO3jgeRfvLepfkFK?=
 =?us-ascii?Q?Q3Laf6iOaIoVAjTjrgn1LxT280lnbtZuUtUi/s8YVfGKFwCmQgRysVX+tJ++?=
 =?us-ascii?Q?LR3ncjjWjJQJMOweepW2UtrEUq8J2sVyWyf5Lj1OO6d2rVghoCzjFeDj7nAi?=
 =?us-ascii?Q?PyHBsVtpz854+qgUjEe9EhGt7TkmOcO2uD6QxwJi3BAbKpqkeGhCQzQKaHj6?=
 =?us-ascii?Q?SuY69ble86bPw0oB1vt7qZSnQhde8BsiaBcgZM6LJ9tO/iD6OugpHdTuV5ys?=
 =?us-ascii?Q?0I9IeYCvy0TcfwrSN1WT29SixzjFWda03dp0C4ElyXrbaqUpFKZ7ixyeW74i?=
 =?us-ascii?Q?BrVjyECgUL6ocMOiPE286qGpGviSdyymH+wbNF41ab4lEf4WER1dJrjV6gLl?=
 =?us-ascii?Q?b3OxAiMauUtdM99xK1G/OUXtn+C048pUm0a18hdJrw7O1C2AjQOG/cbwIT+Y?=
 =?us-ascii?Q?88iZAMQSHcrU+ldU6Fwj8PPoDgGDPdx2QlIbP+JqiHLKpkQEY0sqrpgKNMBn?=
 =?us-ascii?Q?gg/a8jOBVbJ092nGlmP/QagLPWOu8FwC3P1PtSB5bVfoQus5hKnbM1mtrL6Q?=
 =?us-ascii?Q?BUn6e0y+O1AgEK9cteRrOfXS7le4AzphJfQv/Kp7C2TDQWyGIo3Xt/7RCYBF?=
 =?us-ascii?Q?kmXPWKKL5QoXLbORlRVVBZVeF8ukY+OUlz958Uk0DRmabxsmUVajjNkDRbgh?=
 =?us-ascii?Q?dmN4Y0hVl0IJsBU4pyVM7QGljeObOSP7N4kjSepTNBLPtHse2HIaHESqRxBp?=
 =?us-ascii?Q?HH2AswQ8WxS2SBPXcgbKzl1TEU4Jj3U06VqU4Ol1Q9hSVM8nJ+3ucA09T1zK?=
 =?us-ascii?Q?KDqKgZQF2hJMadjlx9VZ00cXRPIvpHsfZmmgV8bfrJOEfKp2K/o5CTMOVxzK?=
 =?us-ascii?Q?U+lfAgjE3OI+3wNSLZ9X9X2kH8t7fsCPulhDmK2M9Nr3TS3P9r/jko+mhww5?=
 =?us-ascii?Q?mh3zaEFBeGSQy155mAlbSqdGB4WvbLG+/O5y/dnO2R7YZ+QrHTucWxK/PK8L?=
 =?us-ascii?Q?mb6BHlScf2ttw6Lqs95ldDe6BAhB69I+rCodXNsb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mLUCHtJMn58tgA/0PeP8SV6wcPbSoKItxde5v/jkdCheF330j6WzoJKnkms5JhHV/+nIeE/P0Bo+MLRMMONMxZGKDa2biHjfLln4SptScAQT+3sSbt9yvyB5LAqOskF3w4xCTkdU4Sq6XhYVHBg522y7Xi+DC+kmvW42c0McXE4rj8OTR99aUvqNWYAGbiGbdEWavHf+3JWfS5g56AXBwSZQgWz7Q3GgAKJwsRx47lF7xsxHZFO7zNC6jLyLvsqxG6DQeOzzOYL3RjCsCp9kkJ+s91W2kRnyYO1sNd8Ld48z/mOnuAtYOud3JkfQx40l3ZKhgraLq2B96iPHuSXz8oSaxEoRZZpU1DxQp188MyFS1kFmRh+3Ct7gJSmY/qloxuK9Xo4XcN47rC8fIOEHpq2cn73+SLi+NG3/7g5f4zF64UjzOZmhTZLviYTqTPF6h4P7svnxUXTgGugccrgwsa/diposBVeXn/L8U+vIX2UKtn6nUUPuPCFoqcgEqty+e4it3gm2kpyNKKfnEGKFNHfH0GcMCojpFT8ps6BFEgCBVQYgqNObBuRN2VY6d+lvx2RKYPoGjbinsl+zMTmC1Mdn1GH0QFg2/T7nJA9HpQc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa44573-aeed-44b5-d5d2-08dd236ee56d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 16:28:56.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyKKSjPKgePfbx0Aw+7es2Wb+Qaf40MUpPxKKQ9kA18PTulPmYa8F65A3oPg7PujqNgK8UDmC/tgg2KWIjiMFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_07,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412230146
X-Proofpoint-GUID: D7BZ4yy-07jt2kEiOXc1yYTzJhlKgXQW
X-Proofpoint-ORIG-GUID: D7BZ4yy-07jt2kEiOXc1yYTzJhlKgXQW

* cel@kernel.org <cel@kernel.org> [241220 10:33]:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Testing shows that the EBUSY error return from mtree_alloc_cyclic()
> leaks into user space. The ERRORS section of "man creat(2)" says:
> 
> >	EBUSY	O_EXCL was specified in flags and pathname refers
> >		to a block device that is in use by the system
> >		(e.g., it is mounted).
> 
> ENOSPC is closer to what applications expect in this situation.

Should the tree be returning ENOSPC in this case as apposed to
translating it here?

> 
> Note that the normal range of simple directory offset values is
> 2..2^63, so hitting this error is going to be rare to impossible.
> 
> Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
> Cc: <stable@vger.kernel.org> # v6.9+
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Yang Erkun <yangerkun@huawei.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/libfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 748ac5923154..3da58a92f48f 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -292,8 +292,8 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>  
>  	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
>  				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
> -	if (ret < 0)
> -		return ret;
> +	if (unlikely(ret < 0))
> +		return ret == -EBUSY ? -ENOSPC : ret;
>  
>  	offset_set(dentry, offset);
>  	return 0;
> -- 
> 2.47.0
> 
> 

