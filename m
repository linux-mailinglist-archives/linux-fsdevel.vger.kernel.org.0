Return-Path: <linux-fsdevel+bounces-48831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF64AB4FDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F773A26C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BEF2367B8;
	Tue, 13 May 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cJoS4s+q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x86aRCwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BB2206A7;
	Tue, 13 May 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128777; cv=fail; b=irpRErioCY8QFFAwG/2NOu5jJJaelDHceN3ezOmAuf2IURs9VOTZPYvb9q+vTxPxYZqBZocLmM51MyCKtqyKe+F8vJfZvSiJHuxE5jeJXaC4ZSu6rLX4+mpwkaRZ0x63b8pzBt94hiQI+B+lySJw4tJWCorl1IMXSFU95hgotI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128777; c=relaxed/simple;
	bh=bDRE0jhKvSgRZQSUMQAHJumbwO1aQR669M4Cl6tpsSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dqIgDPMuMr0VR2dCa7RQL3JfGHdPa8Nk8NyN/XnlJBqE4sn1Cw3TfTyZfxcOAkRzAyJ450omnZLRSMWYiARz2hAl+drfeDz/pI+uAlPDZT9VaHuuS+6gQyLCW2b16i5TyNDCiOXqBM++ldU9pWIlriFxMChS+dZ9rdFzzKH0EA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cJoS4s+q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x86aRCwp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D1CY2P002277;
	Tue, 13 May 2025 09:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xWjDG5qvux8VY6K/1/
	7XezUvlETSX23uFotVBUoX70U=; b=cJoS4s+qVa/+brRuZahxLrQqu9lUksnBU1
	R7zSOuNXkGnTNxRadh+UlARBTpFC/B/lx8IT8tO3EVQWKry2OhX3gHXPRmlTW/Yc
	KRfW5TugDWwRvySJfQ2vTs32lqiSRJkNCJ117UpTYIzFueNFYjGYojZnHwmFqlnH
	dWbcOIyfNTD43N76xb6olhZpf0IJaaHl47t1gjQVL43sxORZ0dj9WiHSdto30K5i
	pgLjKg4+VtpxUmUaax0VuEAG55BKMtn7FKV1w45ljua/qpdGf4dHcolyD84J/tIV
	m9cF9sBczcvBH+u4MQYOAvG4I0rsOSs3iN038o7jboqoAZ24/X1g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0epma4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 09:32:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9UffY015487;
	Tue, 13 May 2025 09:32:32 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011028.outbound.protection.outlook.com [40.93.12.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88dsrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 09:32:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKt8ZTOW13DJHTj6ND1SzcA9OClsgcMDOXfx3FJhiSKnR7JN1RB8zD4FV3R7woQ/Nr3UIudeOyDyBZVAjLvyRgw2avf8c3kBo2jAushu/S5x3YlKUoO/PxROZt4EFD+d6mPCzR9bJyi0Qi9Gj1P1/lz+dWCetZIjiBCLRir9AEGrRVU3NPRcSv2vefKQZKDz+20ty6ZK5+fx9KhmNsnE4iMXq1pXaclpkQ0dnNvj+YJeP3BAnXlIe76HYw+joZfgSBKcJsQqImRsTcwYjncb3kpIAdb3AdtaEUD92E1xj/pFIc3SFnk0Mmw+ax09irpC13LgICt2lwCodeeL9S8rtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWjDG5qvux8VY6K/1/7XezUvlETSX23uFotVBUoX70U=;
 b=pw3a7s2xoVQU4toyDVKb9XLD0jRWl2HwtS3QTpc6Ly5j+1sajdnQ4C2kWKPoRRAep+i7hY+L8GiLCSFWC6cwIEs4nqH2ikwrFUnue+GiufqsTWPEijbtfMEE9QCXXovIt3mwrm6/ffowsIQF1Xwu25Z6Xb3M3cppzN8qe6tt7t7GEPCDz/IvnNeCcBtvqxAztDRbvbSjteOgiX/JP2ST0zBYdsBgK1iRVJ5+SyTc1NmDNjZ5CacEoMt6CZGbOIMlXadjzqiGZJMxDzaVK9W9Pv1xDz6CLKiCh8tnLLJkXBkBmASqpHLo0OB/CAJyhfGTYZ2cMdNiaa+LvazVUkt26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWjDG5qvux8VY6K/1/7XezUvlETSX23uFotVBUoX70U=;
 b=x86aRCwpkBt1cfnv2BWUCf1x2I+7RDRFD2fiLwMi77z9YvB4jv3YgEuqBykpeCTnLS+XvrPpP3xH4oN+prSA13wBl8UoaKcpL6IzsBt0mRMhcnrHEPgRH3xKsiACpba3whEy2jpKGZf/SrfJ2IkZHoBqn6EKKadLf0kx9RaWO44=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5204.namprd10.prod.outlook.com (2603:10b6:208:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 09:32:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Tue, 13 May 2025
 09:32:29 +0000
Date: Tue, 13 May 2025 10:32:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <c3da96c2-c9b5-40a7-b3ef-a8887fbb3f20@lucifer.local>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
 <cd003271-73fd-47f4-9c32-713e3c5a05fc@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd003271-73fd-47f4-9c32-713e3c5a05fc@redhat.com>
X-ClientProxiedBy: LO4P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: 342d6741-1301-418c-2ef8-08dd92011455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJ+iUwxTdbnEwz6VIH+FfKLJfUW4JHpUBERModfcLcQ3KKJJ6XzjhLuYSB9D?=
 =?us-ascii?Q?g62+MJrhOWHlPCHT6s+k9ZTfkDhfHoQzEhB7p/USbmScTsnLC2Az5LiRbOD5?=
 =?us-ascii?Q?0BLGN9ZrrdTwSKRb+U0W9EDzmUWBF4/lSdbtWpzz80wv8YvGaJqt8V1V1Vbg?=
 =?us-ascii?Q?6REMe/ZofFfk9WcEkVXYKupCxkg4aRgEWpKzkCt92KUHsWhy6Kovnra5JRzc?=
 =?us-ascii?Q?Jk4bWhTKyuvMaQl9lJ+reOAiTBbPaG9/Nlnu4cmdW0cp0pO3GQPOSGz9lrlQ?=
 =?us-ascii?Q?Stl/c/iKjF+13L8ISmtchUn1Aw24UVhblbJiCsr/+BUidXJWSZ1RpgfVtech?=
 =?us-ascii?Q?C2xL2gnI4/FKKk+SclvJPbhUsdtx+7vXygXt+GGG2vXM78jdtNwgnRvctU6V?=
 =?us-ascii?Q?NmVIrpuzZndVa9SGdI1on+DCNHzA1UX4QRVNL2F590PvRz/ozVIoWWiuyEbt?=
 =?us-ascii?Q?Mwup4l8Ha5NGM/0mT1mrNnzmbv6b4wmjMEqFBxi0UK0oa1K9WPBjeCVZQv5Z?=
 =?us-ascii?Q?QwVvbWkm38pqYutorL/LMGwe8mUIL6YL5vgBxKV2wqezUpbJWPnO/j5hRbWG?=
 =?us-ascii?Q?8vBurmqCi+nNZvj2hYhQcyc0QkAw+rXQOBDqvOOb+filFoP2Q9kUVVYC+oag?=
 =?us-ascii?Q?damQRF6DC+Z+uC9iPulQSfUiRRqnDnqPAfYtc8k8uQlZufmcMO/Xz0g9tdux?=
 =?us-ascii?Q?uBZnYDpCfLqmaXUOG3lIJ0y7jAxzeukLmk4nDWt3FN3q8v8sRH9rzX29rQfY?=
 =?us-ascii?Q?D5izlUy97AeeNoeDICaPwSS/9tnQwIsDbeLkhc5fSHa21VDXnAMQ5iP7E0i6?=
 =?us-ascii?Q?PCq/yNHQF8DbpDENnJ+2WaMIa5lDXhu3ZK7lAiv2Kr2M++yKhd2JI88E9RAT?=
 =?us-ascii?Q?fDprQPaI00W58Cq7PmCW2MA4V7rDOpXZfOz7ytoOYnpgk6WRzBp9jjUoBDdh?=
 =?us-ascii?Q?Qu1mVIFrxOC8bZPXSF/EJ/9iFVm2LcDpH4HW6wMA4+jOXLnpFYdgrOeYBRDK?=
 =?us-ascii?Q?Em38SCtZhj+5Y6UIrsMnLVfbr56NUhjqWqq9RsvWWTKsL80SSISLZ+QWexZu?=
 =?us-ascii?Q?YVkQfi23c2XDmKTvLdCOrXEWuKdTNTkwjDOZkKuctO8s7siviW37Y+qcyQtH?=
 =?us-ascii?Q?35MovPS+8UCzI6dUw4MxsIaTcfVKy51wAhV/yjJtP6GC2KxSCHmhJobJMAhE?=
 =?us-ascii?Q?QqkPfyqNCCHjhTEdKB/thKjUzVJ8O8AlqX8/bMoSfG2jAo60tLVoadbBx8sI?=
 =?us-ascii?Q?AOO7w1RAcNlyu5I0Q30tvp+iIEmGFVqnDbuMEmsJrFT9oYMaJmjvxXVA9/GQ?=
 =?us-ascii?Q?jMcZ+LcBFlI6wgLxb86h3C2FgdJmGTbmupSLW52Y3aBzrMMI1vIzRnm5uM9A?=
 =?us-ascii?Q?QxS1hVpUSCC4udq3qw0BjB8Xd6lon5atmd8Dqj8SWVlt15Np2V2xwOLCiNOT?=
 =?us-ascii?Q?CkBvgUqXTRI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fVs2kqdVUDtZy6ok2s5kzdrOINApBnP1MGnK0x7UJ/uX/G5hvruXHI0CZir4?=
 =?us-ascii?Q?+Y9+czZVboPzVG/YCe6CYCc+Gdt3YdWH87YqrC4yKHy7dBA93YNNuyD5Vfs3?=
 =?us-ascii?Q?Yz2URC4fu8l0fU5fmurnMIdzj96sIPmYPDzBr0p0cXdPDoGXks8SJT0zWrjU?=
 =?us-ascii?Q?6zOSW6/Z4vUl6k0YTg932TIS2tAko1JgNV1wr16MBwgIQWPZ8Wj872K2HtlN?=
 =?us-ascii?Q?qXcGn2ZEB0M2WmF1JINHxjhuu3xn1pMU6pm6eGlrBmAUEkpaZLJFaEV9bzos?=
 =?us-ascii?Q?J/SkVA24Fm0vybIQP2zK6/xpB1NkzSuhIVF0Mw04rcN80CCq6jPo+dpGP3HB?=
 =?us-ascii?Q?uBT0hRMl3x1TXRc6IuUoWgKNDlg/EYo1apRrTpXElsrLAxxQ+mit9SyYwDIf?=
 =?us-ascii?Q?ydOkmWBF3+xRarsAQyHmTLvcR9+YiZkQQJ6nK/7+15M563nMN2oD5t94Vrjy?=
 =?us-ascii?Q?Gs4AxQZ8vfVwiaCRTPyV/UzWC6MMlNkDoSb/gQDcNj9q3+bp5mFnf5RdVM3e?=
 =?us-ascii?Q?qDXKry7wckp7uhiVSz6mGzvRkee7GQnAWtLWeczQ/nclvszV2nz4rtH3q9bD?=
 =?us-ascii?Q?V7fi784zCDN2I23dHqOnzUuOSONEXEhMI7QxG/STRlIfkRZ7CeoVbGVW9tV8?=
 =?us-ascii?Q?QxFWwegLJcBjrZrS+CD8B+VKs2CbQk84H66x9sZmUNRV1IzDadY6rebHGuYc?=
 =?us-ascii?Q?s8oTuhiC+k3Ou+m2I8nw93i8x9RKp9I+bxSw10/NePgsFP4S/QpAKBKp+my1?=
 =?us-ascii?Q?J/mlSMSkvWV9eUdFA+B2HJzS3+utYYm8756q0m5ug/f0LaogVYvkkdRVbDRw?=
 =?us-ascii?Q?2c9LiLIdfbCf2zxRZ8yWdWKXLmEQiGPDOBCX+nP5N8IGWxRDMtZSPaUpAs1L?=
 =?us-ascii?Q?IsPYGqyukc2/8xi9UwySkidrwpzHjcmrBa6PXBUfzCCq4BnvmWHKo+6/lN0M?=
 =?us-ascii?Q?5FlCWfoHXyPCKmvcBA8BwAg8ncnl9qELTUBmrtaZVG7diD9emM2OwrVMrmzE?=
 =?us-ascii?Q?fRGrn/Pm1tK5mUet9IATM9OvHcGNXHd9NrGJJMLhUNeJzaWqYtyHMySuQUZP?=
 =?us-ascii?Q?VGTxCp1UBI12O5Hh5DuOlkvjpXYrhHYGY5mBKDPAEPYnzeH+iSwgF58Szo/h?=
 =?us-ascii?Q?+7/iFKfjWa2gFBUm7Aj/DXTS6g+/v+6Cv6RCqRvCngNj/30V0++UvQRV1Gju?=
 =?us-ascii?Q?Fp6ASQXSU83SxNANSp4q4aZw6z5LH4hAaSw0dMrP1fsTh294Ma+77SpSQ0Za?=
 =?us-ascii?Q?I/z8NDZKibPc2Azg6vsjMKx/NgtmgZykXkxmcamuXrCmmQvz0AsxcQp38ycR?=
 =?us-ascii?Q?tHQRuWnjXgoVA8YSir/KF+bnPSoOXIrj0m1uzNgR3+J3srHy53UBsqejqgij?=
 =?us-ascii?Q?ulGDMaxMRn/bkuWeJOaBPsHDVNUj3ZFhQ60czHZcEJc1Ihu3UFBKv4jbZHVU?=
 =?us-ascii?Q?MqsgrshZV8n1PSwXe99v7YqBL19q83EwyUVMw188mJ+T0FQ4B6Ff6CdCx39H?=
 =?us-ascii?Q?pCsV+AyTDb5dTrcly6CUxW2OjioJKQz1Y+GLgjYAf3uIzehtD5IbIjc9q0LR?=
 =?us-ascii?Q?WzJFNu8vLvuEGXtuGe59PQ3Rub+CnRZXqFjBcKpXwyFi0xuMZM7OcRun2Ibo?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q44uWfqofyam2dUfbAkv+TXJVe91GqM2bUbt9kVR6gPt7xnXHZrExAinjuRhFaNOeE1nE2fK567Pwpj3nMcuj2Ou8C4WyHDT7bDFFbLtYLnotzAxB8dgLdqAso8PRpo2hhSvtW4vTt7t7b1QGFHIVjB9ZRsp2imwt4Ku++opxGD+Sq5Z/x8q1lSA3NxjRlZjC1osTgA6V38GNjP1mj1cD8i28WUwzU6xZ2tMHFs6PnlNx/iYosiqhY18aKz7HUMwhK30vakLr6hrpan/e+VaZvuDmUhCHHojCD+I7uaPtdFcjl+XUO39dc0flrR0UzCR5Ekncz/thvtBsDsd8CoAtPdQRWZCbKVVuOGvRpOiQSExbNd1XwTfBTK3U5PbuSk0GXL326ZIsno//JTVXp+s/ZWfqMyRIl8pOeEONd8xwu5Y3IwsEe7a5cLQT2EMeIh03dpejQBJ1M4WOb8rO63gwf/Kpl44vpsP50qGlgHIT+qlUqWEJVjAa4IU/0q8AwSTOdUyz7pBCcVCxfEK6JzLcfQorHnDsbdVSlwTkvbQVdPSppPJgFRzmvYyl8ewwaNb0kLiIKOij03LcgmgIcCbUNmgdBPqwNfRb1rtKjZ7d0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342d6741-1301-418c-2ef8-08dd92011455
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 09:32:29.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzU+m3QKriEucN0JiSOQCRwH0WZfS3B15tvfAq3GFll2gWqDRAnv+FdilsPiUZx6FTwszi+Yr5qci2tGO5hsQhyrdKXSkwm7Ppsjddj2Lpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505130089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA5MCBTYWx0ZWRfX1CwPPxxH7Xry jn3tfCeyLHCIFCHQxrxRQtZP2uQgUa5FMYiWi6NHNcjBjUAQ2ZkPx9Mbk3IBw9rV3yHopvNGNg9 c+UsNTTIaNYMQQKsQtL5V7INcabGRo++7MFT0cIo719aCnxvPxcfSmjHZNwQ/TKMLQRi4wP5dTy
 4rEOPxcSERHXXK2L/QZxeYOL3iL2xOFp5ogdRjaW0l3ZVKBR0rQZZv8V+nA8dvQJvOgArwAQgf+ sdI4A4ti9Y6xKX6yUGGBEXM+4hT/sbP1DcZzQSQLxStnS/Gk/rtZZ998qenEgBe1XKP7OqoCIi3 15Gma0bGHmATFUpzT39vmSMe4Plmw1hiZtDw02yTuBvTtZ4jPTEXeM3nFnQVB3oqS6l1/LFcOwq
 D5fatNnvJGMII60NjsxlAGgS5/VENjE4U4Nn8svh2Rsqop3tAiIM+ir+hv6B0nrSkR0wnRXK
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=682311b0 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iap-qV7jxApwZ7o55zkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Ts5gNyQPqnNY5qs_Riwv8u6EGW-expSw
X-Proofpoint-GUID: Ts5gNyQPqnNY5qs_Riwv8u6EGW-expSw

On Tue, May 13, 2025 at 11:01:41AM +0200, David Hildenbrand wrote:
> On 09.05.25 14:13, Lorenzo Stoakes wrote:
> > Provide a means by which drivers can specify which fields of those
> > permitted to be changed should be altered to prior to mmap()'ing a
> > range (which may either result from a merge or from mapping an entirely new
> > VMA).
> >
> > Doing so is substantially safer than the existing .mmap() calback which
> > provides unrestricted access to the part-constructed VMA and permits
> > drivers and file systems to do 'creative' things which makes it hard to
> > reason about the state of the VMA after the function returns.
> >
> > The existing .mmap() callback's freedom has caused a great deal of issues,
> > especially in error handling, as unwinding the mmap() state has proven to
> > be non-trivial and caused significant issues in the past, for instance
> > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > error path behaviour").
> >
> > It also necessitates a second attempt at merge once the .mmap() callback
> > has completed, which has caused issues in the past, is awkward, adds
> > overhead and is difficult to reason about.
> >
> > The .mmap_prepare() callback eliminates this requirement, as we can update
> > fields prior to even attempting the first merge. It is safer, as we heavily
> > restrict what can actually be modified, and being invoked very early in the
> > mmap() process, error handling can be performed safely with very little
> > unwinding of state required.
> >
> > The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> > exclusive, so we permit only one to be invoked at a time.
> >
> > Update vma userland test stubs to account for changes.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   include/linux/fs.h               | 25 ++++++++++++
> >   include/linux/mm_types.h         | 24 +++++++++++
> >   mm/memory.c                      |  3 +-
> >   mm/mmap.c                        |  2 +-
> >   mm/vma.c                         | 68 +++++++++++++++++++++++++++++++-
> >   tools/testing/vma/vma_internal.h | 66 ++++++++++++++++++++++++++++---
> >   6 files changed, 180 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 016b0fe1536e..e2721a1ff13d 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2169,6 +2169,7 @@ struct file_operations {
> >   	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
> >   	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
> >   				unsigned int poll_flags);
> > +	int (*mmap_prepare)(struct vm_area_desc *);
> >   } __randomize_layout;
> >   /* Supports async buffered reads */
> > @@ -2238,11 +2239,35 @@ struct inode_operations {
> >   	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
> >   } ____cacheline_aligned;
> > +/* Did the driver provide valid mmap hook configuration? */
> > +static inline bool file_has_valid_mmap_hooks(struct file *file)
> > +{
> > +	bool has_mmap = file->f_op->mmap;
> > +	bool has_mmap_prepare = file->f_op->mmap_prepare;
> > +
> > +	/* Hooks are mutually exclusive. */
> > +	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
> > +		return false;
> > +	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
> > +		return false;
> > +
> > +	return true;
> > +}
>
> So, if neither is set, it's also an invalid setting, understood.
>
> So we want XOR.
>
>
>
> const bool has_mmap = file->f_op->mmap;
> const bool has_mmap_prepare = file->f_op->mmap_prepare;
> const bool mutual_exclusive = has_mmap ^ has_mmap_prepare;
>
> WARN_ON_ONCE(!mutual_exclusive)
> return mutual_exclusive;

Yeah I did consider xor like this but I've always found it quite confusing
in this kind of context, honestly.

In a way I think it's a bit easier spelt out as it is now. But happy to
change if you feel strongly about it? :)
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks!

