Return-Path: <linux-fsdevel+bounces-51014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE9AD1CA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4154D3A7973
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7635E253F2A;
	Mon,  9 Jun 2025 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LwC84GqV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lO4/5K2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4213B58B;
	Mon,  9 Jun 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749469540; cv=fail; b=YUNshG5MeOlbh7mwVm/7dZDEZAIGZv9bDs0QcOcg3dto5Ys8tbaZDzGfccNF0a0hfmFSzlI78X1D+/F6VpH32G8mfwWZzx52Apg4W73iWrJ2kyBNQedstzdQK4JDSOo2GeN7Ql6iJGxw1mynLdGRU00m7/rPvtVfq8i+71NZHv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749469540; c=relaxed/simple;
	bh=gs8UE6agpmQLznW7PLnDBk2hJ/gs7NYfMBYQeMLhlW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WHheXroxUDSc08ztIkSdMxhU6e7A5ezBz01Y0TGbEUD0URH4JGFjWxF8D6w3nJyqJJ6RSUBOxqkgBWXAd+YfuDN3aSY3QKMI367R2Rq1ohp/8bXKWJ5lucUcf8e2cPuq3QmsV70ukKcBDkDJsz1ZUyUngIWDzb93tOwhEHNUMC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LwC84GqV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lO4/5K2k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5593jm7k013108;
	Mon, 9 Jun 2025 11:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IRDee1jX8RHjsK2qr8
	Y7TXAj6AjTBH42OXGthStWhoo=; b=LwC84GqVAybR9iJjPcywu6bo0pqHf3Pk4o
	HKGOsSIOd2CwK+AJrdKJASfDQKwwFfb3MokV8P6yJbUPPYCFHuE1nTRDCynWjDYY
	jzlAujAHBq05okkhFCleawvqv8P4ULfkjq/DHTXMpMIBjYxNStPhaJjEDdq3bopU
	FTD2qdov78TKa9GsRUf7uSi+qAHKTfD4nX1EuJFNKvy/DSpnqmeN4MjKGz9b16pa
	EUsWnGNT2XNfV6k4KiK/0jLwP+Xvx1oMMAT8YzNeQo5LG5tYd8f5T0E29qG8tj4B
	dI8uMj6sUaW2pqgwgGdqsuwN7lHwodFF0qrLr9C1wOrG9Fss9YNQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf2064-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 11:45:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5599SgHT007593;
	Mon, 9 Jun 2025 11:45:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv73qd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 11:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGJEWFb8nlThiRljqlAj2WBcaCy+urmuNBNwmK/Ro1rlLH0ndpZjUNdDQslf3wtb4LXFG/je5H9lG5Btr8mbaDBfHg8o0jpQAfJ7U3iNDZ7oEO638+a3hAk8AMUaR+7CXMsTgyKYsIzvZxgHRSZIwnoHUnnKIk0tP9Yl4wIykuHSJGIU9ti5xavO97LRU8wzc2n/nwspIPtefZXNmTXENG8TPp60G6N9BkHkjnCw7+dHYqKpDLcjX2AqeqpY+d02aaLJzcReyqCTByJWaS9WCRLxapgaiQC421J136JhhJWkWOCiQ3IjYFTW8QYz1+6ccUqtSaIqsbERQ+emUOlxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRDee1jX8RHjsK2qr8Y7TXAj6AjTBH42OXGthStWhoo=;
 b=e9/2BqIP9PSM2GqDM5JwdTdcOkK+fz9OvTjWrejJSiV5NjSToodWd4qIy690eAP/G6Znd+5DhDarKy7jPtj42za54NZnM2q2BaYlfrpXC1izH3R2EtDsB5W8ep+Yh0YoTIACRkul6GDGuld/kb1vG7MtdU6KB6AKjVWUpZLM5nS66JUtUn+tdDiawRqLhmiaKExPOoMqUBWV94/Vy7lkRBg/YsLBlVuF8LfTRJf625utSZrhwDQ2CW9Pp4BQT1wTeHe5z7sGoQXyZrfqg5M1WSYKpTexuWoCb7tMSNwDpeUuGsPg/Rmh8dhWphTPBljruM/SSNjmezn7z9T33qBvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRDee1jX8RHjsK2qr8Y7TXAj6AjTBH42OXGthStWhoo=;
 b=lO4/5K2k3IqhYB24PjwXQaHoQZn7bBh1GQM8fj2HZzJU4cqLxN7XDB74harTDycE/C82rqOAurhFo233kiZNeUzwS75H0omvohmP38boZ6JSgjIch83zdO9X2zrc3ilYqbHXbM2hFMYAC6EGtBDch4FviD9WBXuDRqPbyTlA9/w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8103.namprd10.prod.outlook.com (2603:10b6:8:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 11:45:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 11:45:21 +0000
Date: Mon, 9 Jun 2025 12:45:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <24f504b5-afa2-43db-9655-3a42fd46108f@lucifer.local>
References: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
 <lus7wfr2fcycylium7ljykdbywinsfmaow45xhiduiitajzclj@s5pzxkvyd6fd>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lus7wfr2fcycylium7ljykdbywinsfmaow45xhiduiitajzclj@s5pzxkvyd6fd>
X-ClientProxiedBy: LO4P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccbb9b8-2be8-4245-58d1-08dda74b1d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5aU/ogBa8uMNKG+9ZiTtZwSRWuulZlyS+xDMQRW7f2vcEmPCuwOd92j2E2Sx?=
 =?us-ascii?Q?vsWebLLKmrvK3S4wuAZStadnCn5JmMjBQovI7LihvG428aChzYSnFYeZwpXi?=
 =?us-ascii?Q?N3QOBe+mwj6FX9Pi/RDYrTZmBdVNbch6n0UcjJAV4GdhoUZK4M+brrtnLw2Z?=
 =?us-ascii?Q?FbGdle/Qx+4Yo5aLOPgOy6GAex1oe3KsAjGekxsEKl74OpG7asNtpqjzABUA?=
 =?us-ascii?Q?2A6leiYRqzSxqneuv5X6MT0znxTSVSk+wegoWLbNvxnF8nTiLkHWw7wn3hOW?=
 =?us-ascii?Q?Lul5yZ0jVWTCBp6WfUvgGLYEqUuLqGyUQCL7U0pZElAeeKNH5rqIKuAl15xW?=
 =?us-ascii?Q?XEEMeRKUTQeKk+bp2K7hsuLD7JYWke7ZRbzN74q8K4SLuwMhNW1cy5kUMv2o?=
 =?us-ascii?Q?CdMcBmMc2A9+SsvuN+nI0rrCDWMso36oP53WkOG9X4CjdglClNwh4LV8YJIb?=
 =?us-ascii?Q?wZtVg64EyuA4qLIM/kZSw1FVB8xTnmn0QGujMM1VHOfFQGtwDqUKzPRHlg7a?=
 =?us-ascii?Q?thRw4bxZyMMgKCL5gfnOhtxtjITib/0XPBB+kHVomNUKnZUs90sv8SdX8jIS?=
 =?us-ascii?Q?UB3FiB9sa1rcZGHfRaEbe1YmHbL0TZkogYAwxYqYDyd+1cdE2bdz7FolyBsW?=
 =?us-ascii?Q?fGtgENG5SyWhUreVupOXjoGQwIfA5mZAVuXuwrZ8iH5jyUI0EXfYeCjLNGuE?=
 =?us-ascii?Q?9f8COj29Poz0gHsXQ855bKGkNERNzgmmBmuYS33BuWaQLshrSL+ynHa5T40k?=
 =?us-ascii?Q?tlj1PM7SMm0O7vHIuFbNpiPIGQ7T2L3ymUbyNr+Oxs+d6TiSjY6bROwe6FB6?=
 =?us-ascii?Q?I0d6+KxkyInyueQB1iylI8Wk+O1haLuwrJtweN4eGRFt2Nt7d3iBeTqBPgkJ?=
 =?us-ascii?Q?KsOSXwABDXGYRjfY3f33UcTjWNY9m8awNi5+YHUA/AWTZcpI1CcBcWaw+fIo?=
 =?us-ascii?Q?Gcz6eeV2pR7kPne7p2RiB9ZIPpilZMpyrOfCw4xYRakfZ742Bz0yPPn79b47?=
 =?us-ascii?Q?sYuw6PLweVnXIwck4KSVsUTTxHTzxfNj879TKiGzL8afW8dfx1uPqbupMb5U?=
 =?us-ascii?Q?EyEjTimmpgPZNmb+iNuEgUARdvzmnnzgXGFsfC8PcjAQUVEGrbEomc1amYBl?=
 =?us-ascii?Q?1gvz4HuUtMt/i5/gZ8fT1c0OCUha4FExYRDxZ4/7iQ9HUM4irg0o+mfU4aAS?=
 =?us-ascii?Q?jFigMIBwUIvsXjh81FQGeiR0u0ViUCLoE6918IM/DXuv2m4OKEfsqSP2gVJN?=
 =?us-ascii?Q?7u3CqczCV4wOhytMnyR7XIC9U79kAksxvXJ7nrEVDsxSEYZAPd8wxioIV1SA?=
 =?us-ascii?Q?IXnNmmxUDzGF+6eM7eDxcIXET0zJEP5sG1KHKgABoYZa0890w2QGG28JhiBa?=
 =?us-ascii?Q?2axlCmslDbNgNGOdfrOUkUhQTpcuca3hukwcHarLYMvqDbzxcln/pktQaDur?=
 =?us-ascii?Q?spmBcn4M8ho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LmQv84Aj4WplPHYYjIf6pyiqBqAhTelJTcVuAE8yfu9BUAHe9EATM/U3Qk9R?=
 =?us-ascii?Q?NSH/c38mfCgOi1lKJlpyjlDTkGH7oQh64GtvzdIdPtj4NLBPhpKynFeph+S+?=
 =?us-ascii?Q?q//F4aHisLYV+ypYNpo8chpeQW7XrKz4Yik4Dc5zeQE/Wk8phgSFJipNM8Td?=
 =?us-ascii?Q?3VAwJ7zxjWOgPpUgLQcqO4To4NAKX3feUPOgXnWYKsPNAd1O6izpj4ZjNRMP?=
 =?us-ascii?Q?tZRq5yLTMYymKURr5bmkk3UVIvbDgS4j7WxvSolWplCyZrWFUqxN+crKujXf?=
 =?us-ascii?Q?x15WHb7M4iV5NFp1lvT+X6gdHYy0kdBQe8bgK6wUvnJgP4ngLvusbmnlSO7S?=
 =?us-ascii?Q?ri3Mtn0EZ6xCiBR6BLkkIjl4FYTa+aJVFjxHOQaLUfI4fS8Su26zminoB9VG?=
 =?us-ascii?Q?VK342T3/o+SSKO9R3eQVdYRBIiFkSRB6edofKDdC3c3rZf7uXOgv2pARzCJU?=
 =?us-ascii?Q?4fmfDQEVYmHws6BEStmWgcDb/fYE0EVJws7OJ4qKVtOKmrFJt1orhXae8jR3?=
 =?us-ascii?Q?+syPA/zVwvLICzqZWokVGvONFnH2PN2BfVv2H+jejf7GmTQUP52xuNreLMue?=
 =?us-ascii?Q?5EF4S8D//rmrzy9TMHLwV8vwzRIJKiYTLA1za92M6ar40sAHKRfykSYBuyTV?=
 =?us-ascii?Q?3o022FmpsdG3AkaHb9ndIzPrNcu1WnPbBwwWOdFtG6cihDd5efXwVgXF4YQf?=
 =?us-ascii?Q?zgfLMAa6PrwiWaraij4T3nfETR0YpuloBabzyBshx6WbK3QGGUdEeW0x6Yp6?=
 =?us-ascii?Q?fjn+X5qKrjS6IRjm4xYqdepdqQNMrlbGtgrORox7wi8MXwIU3sAdI/38GJgz?=
 =?us-ascii?Q?EWFqJyI2BPWCB0F/GtawNltJ6qaGEgYTcN7fkNd/XZKIYFRTvKiR75Jct2tQ?=
 =?us-ascii?Q?NEcZ90hr4MaZPw/snUmcV30xubt2P3h7XrRJtOYhZTjiv6RLSv6xb8Mhd7aV?=
 =?us-ascii?Q?tC5bwnk6y30HJdOfMfSDdbbj+aQ80T6ywQjp7iyPDAwaX49omLYoZRuUXc7J?=
 =?us-ascii?Q?8iCYxp7pT0t98cktielYYj3zJ7DmPmBx7znur6QR4Lh505u5/ALct6gMqqC5?=
 =?us-ascii?Q?JwKxynZmF1LUNLCrSaSp3LyXpAx/Db1X6mmHS8p6QQVYebfX1l2aXJ3iL7UY?=
 =?us-ascii?Q?RfnXFfIIfXZhXjXx0mNK8v3wpurAHvAZ0imaV0G5ObsPdO8wPF/v9SfKXfFQ?=
 =?us-ascii?Q?Fs4hIowzrhMBfGjml7UWW0bUejh1vC4sYtS3YzF+4d5vd1hlwstydgE5Q2lF?=
 =?us-ascii?Q?OqXFmA8G7mdellTfWKGHSxnhIXreH3mOMZEdUND6+RuUGPOiPUVKpjjGrv3H?=
 =?us-ascii?Q?lEMWu11Jx/lAt7gYLM99zp13v1npKupLzxBXz9gDkvWk9T1KBwYaALJ4LrOC?=
 =?us-ascii?Q?OIzZHPgcmldzwSnfJDJ7VMZ/3wrbdyX1rYCFOi+WTNEuKTtXjvQvljLadFef?=
 =?us-ascii?Q?eL/CtZdCoNpa9lgr2hCnr/iWCXwNrgANmuDn5qN6mcZ8GD8iHLWTrlAW6fBY?=
 =?us-ascii?Q?odCJDSNv1n7hyTmKPl1o0wO9dtzbMHkCEDpoHcxMgtlXLYQlM6VKKS4oKW8t?=
 =?us-ascii?Q?zP2yoqiygWuIgz09c7as28KsfAYhCduH6SG2Il5iY+P4CTXVVoEvfCk1l8hv?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rj5H6YChSipMPIZIhJfvjEoWXwXReoGCDJchCvPb76pm2gyb0LiAufzH0MhZfl3ZN5zJkcnuvHVyOa3Hv1un/qnCItqb8NDuUfQCpODT6ifhzCUSNIKeZPRpUSjOxZSHDmvTGnAPrdCPlntHv1W8YTttYToLwLLe+NbUzVPZKu84EOOcvAGBnOrAOwSMgGwxIKiRkwVO4wRkMhhZwt/Z/amcX/uXQUcvmWJSCKL3EAvviP9G+ZhkpTKfCTX4cViAX+HdxLvcZB/1q12VYNxSuUXsmAIpk4Yz6mu987rN46pin2iLoImqYUzrknA/U5GGIyUZga548LboKj3tfmlIQ7ECKxcvZBJDABTraIu3a36KMcsA93/y6DBXz5AjMbzpN1VTqLHeyBKB+JZeBzRCvCXdinS6UsooB7vYZXvtsYuP3EcfEtaYImTapZKUFpJsDhby0qsy5SnZfxhPX4jiGe9x/dcKAfs63WwSqM8j2KWBHxGS3bE8GniJdio6+ws3bEnkBi64iRwwVOBqJk1JYecLH46dBlDQ5OhHooY+Kybk1eeF3JG3vHnr6NT4sepZK1q2pm7NEJMDnQZD4PHxdoctd1NTvrD4E8jg5KAUXKg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccbb9b8-2be8-4245-58d1-08dda74b1d0d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 11:45:20.9470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRHcf1Yd0fUAIkGhJ9KMO/WgzkIex2LVT97FXL0BHl6QWtRyMkkTkhmD6cCdq+RGUSUxeJmCQXa6+K2fChciNuEAUp6dZD2oaA+yjkXMMWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506090089
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=6846c954 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=HNhzTM14WF-LhxQSznQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 5wmDwuMwZabGnWbdiYcNykDEkHbAMsPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4OSBTYWx0ZWRfX/6gYkK65grIZ 7Zu3pEwYms0Czg5MlZYwMBALEM0EpDPrus3fze9Nj/yMuJJRZIgzGCNs6mUV/Nj40mu7wweztzR hgpGDJuAJK+1H9AqugKMF7RI8w7BQCoaVdQUuTyoiT7GpWsHZpmnRkq0XRtRE+2U1CAxyOuFSUs
 MONu5/vG2EPQnha11PULW6BIC4bIWSSIHQsSnkbss5yUaRDRbS6qcAEsQC8zhl0Y5CIbfNElBG4 1E3F55ATxf3w3NWB0iyeD7A0cI2otHviXZAjrADMDVLODGQ4vrzToH2Hu6s8I2vPVHR92QqEgsz p3jzBYFTFhA49m7OpQbwRdy5bYSSW9YI728MHPK1V56aQL9R7NSEs7keZIe6CHLSGfT1w9HD6HX
 goK0O0m9b42pWxxi8pDGjeWqagisntXBFx5hND/oCO5TzKGPutu0/3+zDNIkcOm1W7iVpoul
X-Proofpoint-ORIG-GUID: 5wmDwuMwZabGnWbdiYcNykDEkHbAMsPk

On Mon, Jun 09, 2025 at 12:35:40PM +0100, Pedro Falcato wrote:
> On Mon, Jun 09, 2025 at 10:24:13AM +0100, Lorenzo Stoakes wrote:
> > Nested file systems, that is those which invoke call_mmap() within their
> > own f_op->mmap() handlers, may encounter underlying file systems which
> > provide the f_op->mmap_prepare() hook introduced by commit
> > c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> >
> > We have a chicken-and-egg scenario here - until all file systems are
> > converted to using .mmap_prepare(), we cannot convert these nested
> > handlers, as we can't call f_op->mmap from an .mmap_prepare() hook.
> >
> > So we have to do it the other way round - invoke the .mmap_prepare() hook
> > from an .mmap() one.
> >
> > in order to do so, we need to convert VMA state into a struct vm_area_desc
> > descriptor, invoking the underlying file system's f_op->mmap_prepare()
> > callback passing a pointer to this, and then setting VMA state accordingly
> > and safely.
> >
> > This patch achieves this via the compat_vma_mmap_prepare() function, which
> > we invoke from call_mmap() if f_op->mmap_prepare() is specified in the
> > passed in file pointer.
> >
> > We place the fundamental logic into mm/vma.c where VMA manipulation
> > belongs. We also update the VMA userland tests to accommodate the changes.
> >
> > The compat_vma_mmap_prepare() function and its associated machinery is
> > temporary, and will be removed once the conversion of file systems is
> > complete.
> >
>
> Thanks, this is annoying but looks mostly cromulent!

You do love that word :P I have to look it up every time... Maybe time to
up my vocabulary?? ;)

>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reported-by: Jann Horn <jannh@google.com>
> > Closes: https://lore.kernel.org/linux-mm/CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com/
> > Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> > ---
> >  include/linux/fs.h               |  6 +++--
> >  mm/mmap.c                        | 39 +++++++++++++++++++++++++++
> >  mm/vma.c                         | 46 +++++++++++++++++++++++++++++++-
> >  mm/vma.h                         |  4 +++
> >  tools/testing/vma/vma_internal.h | 16 +++++++++++
> >  5 files changed, 108 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 05abdabe9db7..8fe41a2b7527 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2274,10 +2274,12 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
> >  	return true;
> >  }
> >
> > +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
> > +
> >  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> > -	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> > -		return -EINVAL;
> > +	if (file->f_op->mmap_prepare)
> > +		return compat_vma_mmap_prepare(file, vma);
> >
> >  	return file->f_op->mmap(file, vma);
> >  }
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 09c563c95112..0755cb5d89d1 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1891,3 +1891,42 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
> >  	vm_unacct_memory(charge);
> >  	goto loop_out;
> >  }
> > +
> > +/**
> > + * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
> > + * existing VMA
> > + * @file: The file which possesss an f_op->mmap_prepare() hook
> > + * @vma; The VMA to apply the .mmap_prepare() hook to.
> > + *
> > + * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However, certain
> > + * 'wrapper' file systems invoke a nested mmap hook of an underlying file.
> > + *
> > + * Until all filesystems are converted to use .mmap_prepare(), we must be
> > + * conservative and continue to invoke these 'wrapper' filesystems using the
> > + * deprecated .mmap() hook.
> > + *
> > + * However we have a problem if the underlying file system possesses an
> > + * .mmap_prepare() hook, as we are in a different context when we invoke the
> > + * .mmap() hook, already having a VMA to deal with.
> > + *
> > + * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
> > + * establishes a struct vm_area_desc descriptor, passes to the underlying
> > + * .mmap_prepare() hook and applies any changes performed by it.
> > + *
> > + * Once the conversion of filesystems is complete this function will no longer
> > + * be required and will be removed.
> > + *
> > + * Returns: 0 on success or error.
> > + */
> > +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
> > +{
> > +	struct vm_area_desc desc;
> > +	int err;
> > +
> > +	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> > +	if (err)
> > +		return err;
> > +	set_vma_from_desc(vma, &desc);
> > +
> > +	return 0;
> > +}
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 01b1d26d87b4..d771750f8f76 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -3153,7 +3153,6 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
> >  	return ret;
> >  }
> >
> > -
> >  /* Insert vm structure into process list sorted by address
> >   * and into the inode's i_mmap tree.  If vm_file is non-NULL
> >   * then i_mmap_rwsem is taken here.
> > @@ -3195,3 +3194,48 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
> >
> >  	return 0;
> >  }
> > +
> > +/*
> > + * Temporary helper functions for file systems which wrap an invocation of
> > + * f_op->mmap() but which might have an underlying file system which implements
> > + * f_op->mmap_prepare().
> > + */
> > +
> > +struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> > +		struct vm_area_desc *desc)
> > +{
> > +	desc->mm = vma->vm_mm;
> > +	desc->start = vma->vm_start;
> > +	desc->end = vma->vm_end;
> > +
> > +	desc->pgoff = vma->vm_pgoff;
> > +	desc->file = vma->vm_file;
> > +	desc->vm_flags = vma->vm_flags;
> > +	desc->page_prot = vma->vm_page_prot;
> > +
> > +	desc->vm_ops = NULL;
> > +	desc->private_data = NULL;
> > +
> > +	return desc;
> > +}
> > +
> > +void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc)
> > +{
> > +	/*
> > +	 * Since we're invoking .mmap_prepare() despite having a partially
> > +	 * established VMA, we must take care to handle setting fields
> > +	 * correctly.
> > +	 */
> > +
> > +	/* Mutable fields. Populated with initial state. */
> > +	vma->vm_pgoff = desc->pgoff;
> > +	if (vma->vm_file != desc->file)
> > +		vma_set_file(vma, desc->file);
> > +	if (vma->vm_flags != desc->vm_flags)
> > +		vm_flags_set(vma, desc->vm_flags);
>
> I think we don't need vm_flags_set in this case, since the VMA isn't exposed yet.
> __vm_flags_mod should work just fine. Of course this isn't a big deal, but I would
> like it if we reduced vm_flags_set to core mm and conceptually attached things.

Yeah I considered doing something like this, but I really want to keep this as
close to how .mmap() handlers do this ordinarily, even though it's a bit
unnecessary here.

This will (genuinely!) be temporary either way, and we can address the
unnecesary use of vm_flags_set() as a whole elsewhere.

>
> In any case, with or without that addressed:
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

>
> --
> Pedro

