Return-Path: <linux-fsdevel+bounces-42394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0748A41AB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 11:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C0718912A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 10:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D7624C692;
	Mon, 24 Feb 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EWISU7IO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AYkL6G0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50E24A04A;
	Mon, 24 Feb 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392358; cv=fail; b=DU4aMCoDJ/qxnabZYi165RXLW/x3es+6BBklK4ftIgk94g+8fZnispcikjmX1VMhNRFIh6EPkfneqOdyPg/AcATUEB/j2zBHef+9a6LXIg9Bf5e+eVWTu7kkpW6LJ4Ysk73PZqq4XoLLOoaD9noCe+MeK3QbCY5Msr/VmHjfF20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392358; c=relaxed/simple;
	bh=W5b0IpBSL0M/91lSkSeMQw5TXn9nFGQcGyCKEl9i+Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mcKCh46tvHXFbYMuJ4wJywZdtQHq+q/0tvfOztoG+Yz1/cU2yX3MxRwEr15WT1iakheurD+KKRdiJoWVdcVY63dzxpnrnrAI/scRS5oyvLOQaH8lUA1NEUH8tqs9AUGZLbM4bFBPAEY0ESIH/y1M83o51KAPq+pOirQJOxcHlGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EWISU7IO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AYkL6G0t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O7fp0B001037;
	Mon, 24 Feb 2025 10:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=LtATkBKn3P1SHUBEDH
	H8CT/AQzKER9exwEhlw75CDpQ=; b=EWISU7IOsU709wyzxivsoNweVSl/agrR6a
	94KAgcFhQzjCTd9Y+UroLvKgCsrcoLtaiRNFdfjUYZtpBswqurZ8IGVs9Y96cNQj
	Fs2PMQq3XPyMW9DV/FXb7mLThGyLrvpmb6y1H26b6e5x0WcdkNOw+6SJe//U7LQ6
	DyLYhNdamktsjIc1ZtfOH4U7YWcGu0bd/nD6FowTIiiCTUafb9YvMOMLowmS3m2h
	4t9S89y4u1HcCBH3DHoA+5S60PbyW2oL6IlpKPF34yDhGxBPMf79sWd0q8Z3m7by
	DqXu8fc6+2jhRjV+G9rsWxKfQ/WrKpmL3PiBt0wNIHbKzvH8n4Ig==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2a8ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 10:18:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OAGvQO007496;
	Mon, 24 Feb 2025 10:18:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dfcjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 10:18:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui4I5+fGJijCUoBHziZNgbFQ5Y4ryJlezemHhycqUlfe/xbojavCGRAjdJav4Y9x7QNRfCM/AwzIBoqfvSkm7PtObz2vcT/uoO4jdFj8cDvQBBpCKrECxh5Tj+Pudl2Z78v6C+kqtyTbzAkma1NaVEocChr0yXWUSzNuvXStGcsSuwXZHOxfiUYtzYYD9aXf4B4078z9K7nphu7jxWTiEZJlvPdb6NGf1tPfGANXHlLPeoVP6qyVMQXkb21kA8J0NS5UAGO7/V2mDww4klM9D2P6f67h8giDw3Jrj1obXYLD1CXBudDsmPoSQvs4ZYzDdSENSbOxlPrbb5nbB27ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtATkBKn3P1SHUBEDHH8CT/AQzKER9exwEhlw75CDpQ=;
 b=DtMSn500NtqSdCgGoH1wfdJlorcj3ulkgNYgUpYt+ZAXadGGK5nkxtLIiHPu5u9FL5g0kowVyif/2hZnMRtZs5KFyifKrds1ichp4nUlmADdWRYC98cV0WTMlkAFeKhUosVLa0EfoqQ2i2Y2FE9d407CHPCg23CQ/pnuDF40TAfa4mZdjKub3FZ8566JWDHhiYj0YWN9uQZ/Y3G7KkQwvqoOoqBsyo79ad24LsAEMw66/SbpITU+E8rU/5n+S1JK9GaOGep6totvlagOJTT8UlULEiMTLqroW8li0G39DMCI2Q20lwOOZe8EGVrKhZULWuzq/2obp8IBa0dDUS1Duw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtATkBKn3P1SHUBEDHH8CT/AQzKER9exwEhlw75CDpQ=;
 b=AYkL6G0tCBeVfp3Y6nctEf2kYc5pknd5F0kzIfT1SLVxzVM6bgm1VcnbzOVhov2o8EEO5f1tIX3ufylbP21WUG07utCbQJCeKbwIHbmJPA801JafS5cM30Qcd3TqMAdhr+pemJok0G2XQUHGniL5GBO7RYcTudwAHPZd0t0D18I=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CO1PR10MB4674.namprd10.prod.outlook.com (2603:10b6:303:9c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 10:18:49 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:18:49 +0000
Date: Mon, 24 Feb 2025 10:18:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
Message-ID: <cd57ed04-c6b1-4df3-a5cb-a33078a08e74@lucifer.local>
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
 <857b2c3f-7be7-44e8-a825-82a7353665fb@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857b2c3f-7be7-44e8-a825-82a7353665fb@redhat.com>
X-ClientProxiedBy: LO2P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::23) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CO1PR10MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: 3406026f-ad18-4732-1cab-08dd54bca12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3pzSi6bMOTsgFJIoC9JTit7PrDPb0xygdSk+CG4yb7vpEOkuP7CCVwHlCjHV?=
 =?us-ascii?Q?/gkXAUdgAR+WFPwS/5V86sFmVaHH6GqhGw9JbWMMRv7g33uErrFi8Z1nOVum?=
 =?us-ascii?Q?wgEk38k9CHFa6CXH/EcYT9fUZIPJg+LrZMJZ4WQTCGSCQ83qPV2pVpqOT5aJ?=
 =?us-ascii?Q?eKvLpyFP10c3CgEKAsYLISi/Y6FRTVK0MZz29EVE4TuOaj47wHgbesQtdt/A?=
 =?us-ascii?Q?+F7sjZtDRwieR3oiiJrW8vwj84uaTPwisCRNlOec+u8UajeZhNwPxKTJFmia?=
 =?us-ascii?Q?f3r1gH7gWskQpROfQY/ZVGnaXyuNegbVJdPaTyUaERuchJDtjoWMBqDjfiME?=
 =?us-ascii?Q?KgwygdIYK4ShrnwgTI6jAAjNJhfxyN9bd3bnlAQlbyWwk5NexbWJkvPBqrBV?=
 =?us-ascii?Q?gNq4qAfFO2O37pdgW0r1fhSJhCJZFvNzjaM3lA08em2iG4CC3AWUDOcjvaVZ?=
 =?us-ascii?Q?N2IHO+ms02d/HxcxxMAWqiDcp6o/B8KC5v1HgTiiaGeePqpKPBb3U/aQiIYJ?=
 =?us-ascii?Q?OwnToXm8fw03fmRfvyE4NI9nJYkjSaIkpSWFFIMaEV6AwbEm44n0FFOU7xmN?=
 =?us-ascii?Q?ZD5t6aroY0MAjDr78wgrUZ3zer3Ts/Oh6oGKa+1LdWRJtkh7uHCjOmmb/f3N?=
 =?us-ascii?Q?pPnxynT2fHxFY4c0cqrpjRkUOBQIjI82GXV3c/eBKwTwN8gUQ5coP0oaBCbN?=
 =?us-ascii?Q?aWsEN+dpTJglxRz+3E9iCp5WAvE2ujRDyAQJDrsS+6R4MzZ4VU/mts5O+0Fk?=
 =?us-ascii?Q?eVeFuvYfK3eYeO8uKBAcVsuIXZ6PSZfgnDP3tnGwRcTw97w5T7xivMFEZ5bz?=
 =?us-ascii?Q?NIvbEuSxWsgJgXanTX63xU0hkmSEpa2nhhJEq+CpIR15H18Pn3KO0j+H2iGW?=
 =?us-ascii?Q?ZgHDsCM3fD3Auxxt/qWR5hJV0836yB/RfGUAszIqfU1CmFmcjxp9fBdUe5+K?=
 =?us-ascii?Q?iaft7AbtwQBME7qrmQLXJbr3PVxClN+cZQM9aDPHBkuni+LzQb3HlC11/JoL?=
 =?us-ascii?Q?6XiY3inwljYfJcyPMWD8ImHwQHIwTTr5EfvdaWeh4X5DhTcGg6tR21eQ3ugC?=
 =?us-ascii?Q?3ixnAuDqqlQV/k5kb30kdyKPFgFs3gL3Fw8jjJI0uvWi/YcrLtmYG3U56Q49?=
 =?us-ascii?Q?nCtNbLKbwb6Xt8JZ4LJr8Sy8LCeDLH7P66yAQSfLsiJx9ntgxOYObVTOi4Ar?=
 =?us-ascii?Q?BkrketMaKLX9/SmD/zpKZ1bEpoYLpznsILmacc6FWzwNoUl636BEMfopcdLE?=
 =?us-ascii?Q?GSSpvUzeIGymCR6VZNULZX8M8ESvaaeXuIMNPRsjxk7P/FGKpvecWuOPvw5E?=
 =?us-ascii?Q?91qXG4P0008MWpCGvVAOSXlEDwIAOmD8Tgi0E9zrfOxyLPmeVyL6we1OjmXy?=
 =?us-ascii?Q?Fv0XKSDIyeFHzzroOcF8oy4l5d5m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NPluYuXM9ZRoCgfDVQnyyEbVWnuixIvJ3SVgc5Gob6Js30KlBy3REdn7r3fE?=
 =?us-ascii?Q?eW5xhs/Mz7tvK9CpSXe4rM7USwPjRAbnf5htrKO8ySPedRIQScXwiVHnC8KI?=
 =?us-ascii?Q?2tBS12+zoKfFnwIhVH2Ds0x5zeO1SjPpoZvGDEkBDP5uM2mBqfddMLv9xgME?=
 =?us-ascii?Q?KHVSxI6W3tf9MwH3uuczzqiVuVwIaFXHCxG6OV/wZMnvoGx1LopE0sbYr9Jg?=
 =?us-ascii?Q?Fin+XKWhlwEjsDijy3WF+CkEUwRrlAY6WRH3skxSARfVuRNhqCYHQ0VnPrLv?=
 =?us-ascii?Q?wZHTTGD20FjUneBvbcYOVWCpRk6RrsnjE4U69dMfsg//Cwws8OXc9ey43KaW?=
 =?us-ascii?Q?NBS6iP/r9PcWIjrCa53DzTv+7NAZqZsBkERd151SJvZsYeqmat5kY1TcdEwg?=
 =?us-ascii?Q?woD1XEaDC6b8yvMy1YOSiLAUejTnYzBxzFQK7fi6Olpz7x/BrqWh0NuSgC1F?=
 =?us-ascii?Q?EFimnlC+YyMY8NZ6Nf/bfcMjmMbx/sBu7XulWGVNi6hcwJjmI/clbithMWNm?=
 =?us-ascii?Q?f1n3hY3wVWR+be0mQjrYdAdMnUruWZaZGlAoKguxrRRaNzmWf2Xmg0jRGp36?=
 =?us-ascii?Q?Zegr8X2PFnNgyseasEoPa17YaaZs95fyqCkvHv1K6jyrUKweJS6NcV3iLeiK?=
 =?us-ascii?Q?cwUl6RW/J5cOyVhQGbTK3L/4XdbAOsSYT+ywsEcWS/7KKlAg5887Kr932V0v?=
 =?us-ascii?Q?yb32YTNDGfrO/P/2TI62rtNFvgZuUJAMb1bxTAUVwUyelNcOzpVMcDMFZfP7?=
 =?us-ascii?Q?Th4p6XKA8pQDn9YBAk1GvuKGDjkSjceBD3rTKCAimhrS87q5SNmi+WYc94ZU?=
 =?us-ascii?Q?VdnAOwKwCbdYN+9FxXXwYg8qbtIVvPPlfci+HIOazQhGD76MSnv+bSrUT7od?=
 =?us-ascii?Q?9tmec3Ap0gL5fJsBe+kYH2V4AfIKiGbDtNcAJtjR+TVRli/RYBfmZid/10o0?=
 =?us-ascii?Q?JHnvcIilL/mvObm3hAx/5wsrn+vryPtiuDXwu9scch+7hWXRKuehtC1hg9wG?=
 =?us-ascii?Q?a4ppgUWnfQoTr8R1BpoE4LgvfiqTWWTvGP4cTK3IqmJV7+uiOa2dgUe3OzlA?=
 =?us-ascii?Q?a7apqdz3ZUhO3TFWbzXegJlrzXNf4Jqu/syQeJF+sOQgHhoXeD9jZhxrpGAW?=
 =?us-ascii?Q?FSiZ5r4LmFUQ5TJatFtNRHwWNRAfq6GUOSuDlVAxcBwOpwRjPBGmtn9rqXGA?=
 =?us-ascii?Q?mL22hnap+Xy1GPdcZvGd1Qs5XbqlpXSGZjbmsPiP0VWXMEnON7Naky0noDRR?=
 =?us-ascii?Q?vVTlZrLmZAOhd9iBMiiw0J68eN2lT1Qj2KCAJdoteG16yiRhkcoWvR2tzIhG?=
 =?us-ascii?Q?tbtPmINoqsJ3MHd+NEur41Q4Vs81RCHQSInE2kA6d/G94LDynsWksvUVNXGD?=
 =?us-ascii?Q?nyRYl08GXY/m1Qxz7+0anBEQkimolxRKb4HTCw5P2o8DxyKTKUzDdsm1eO9b?=
 =?us-ascii?Q?r67PUKeZA6IeJD4t73PjuBXFdCDlr3ALRDIYt3DhvGl9mH1dT7QQTnHKrd7g?=
 =?us-ascii?Q?lOinDRoo9J0wrdGpOJ/6gA2RTYXGr7zCmg1YGIXksPuW5yU38vQdqP01N/g+?=
 =?us-ascii?Q?J3Mfeb6CrfNvVgGqm8Nu6hlcFU2V1XL8xuNAk4ti0qrGSBvXovZIfT7OgYjV?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2omcoRkXc7F3ea9QAQ4rRoBa9HjQj/679KpY44ysuyxhGdg2zWVRXSQXkxIxaKYdOLk4dnJX5xLde4o9Epe/krYJ53kMPhs+K9CerruDTFP9jVq0oJDVFJ+iyAYeXhgRGrHIp7GVJ2B7uEPw9zlBsEvyPr2VLcFf6SfB4UTQSGUpE3B44VHVNh7rrmMqd9z9Q1IyPls8gL5u715Rr8VIJjF66OFAWEKQ4BEpvWfG+4ustj92v1scELn6BdpTyvHpccP5IlBlPMHjCbks7ZQ4KCAuKJVJsF4WFzllbIzlLkA6kpTcLenoqhPNUs5Kafg1k3lz/Hei/XKEBwWE/0EaXMPB3t31k9tajz8SuKzuMArUm6FaVFyiA90tvpZqQQoaax/aTsK93OxZWfmToCz4z0XdlqW5w38ATrAU0RO8hk2jNYk8d7+VVYh069XltHfV3MpO45aoJqn1xcj/aLaz58I7r4qcKuBMs6zsh1aH2c+UCGkFpV7AEDNY4YCMkqrUW5ON9UNVlEvuOdhv9JgpBoiQ87VmXZpgsheljXWOm9PDwVIu4jxY4LraIrduxXHz9IUcHiWHoMfbpEp+Bt2bbuv7FCKBGbniBi2ckdbjK4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3406026f-ad18-4732-1cab-08dd54bca12f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 10:18:49.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bK0Zqrg9p6neatF2vALSDwaWQMX6+us7Xtf5EzHHJ5kTbEj3J1gzT7hYieh4e9bihHfwxVcfYzJJ8gIpCCZ5pMpkPJnAbaTOupTbSCSy9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240075
X-Proofpoint-ORIG-GUID: 0OyZvwsHh2xtM4oe8UvUuAMyrbW_ku5m
X-Proofpoint-GUID: 0OyZvwsHh2xtM4oe8UvUuAMyrbW_ku5m

On Mon, Feb 24, 2025 at 10:27:28AM +0100, David Hildenbrand wrote:
> On 21.02.25 13:05, Lorenzo Stoakes wrote:
> > Currently there is no means by which users can determine whether a given
> > page in memory is in fact a guard region, that is having had the
> > MADV_GUARD_INSTALL madvise() flag applied to it.
> >
> > This is intentional, as to provide this information in VMA metadata would
> > contradict the intent of the feature (providing a means to change fault
> > behaviour at a page table level rather than a VMA level), and would require
> > VMA metadata operations to scan page tables, which is unacceptable.
> >
> > In many cases, users have no need to reflect and determine what regions
> > have been designated guard regions, as it is the user who has established
> > them in the first place.
> >
> > But in some instances, such as monitoring software, or software that relies
> > upon being able to ascertain the nature of mappings within a remote process
> > for instance, it becomes useful to be able to determine which pages have
> > the guard region marker applied.
> >
> > This patch makes use of an unused pagemap bit (58) to provide this
> > information.
> >
> > This patch updates the documentation at the same time as making the change
> > such that the implementation of the feature and the documentation of it are
> > tied together.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
>
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks! :)
>
> Something that might be interesting is also extending the PAGEMAP_SCAN
> ioctl.

Yeah, funny you should mention that, I did see that, but on reading the man
page it struck me that it requires the region to be uffd afaict? All the
tests seem to establish uffd, and the man page implies it:

       To start tracking the written state (flag) of a page or range of
       memory, the UFFD_FEATURE_WP_ASYNC must be enabled by UFFDIO_API
       ioctl(2) on userfaultfd and memory range must be registered with
       UFFDIO_REGISTER ioctl(2) in UFFDIO_REGISTER_MODE_WP mode.

It would be a bit of a weird edge case to add support there. I was excited
when I first saw this ioctl, then disappointed afterwards... but maybe I
got it wrong?

>
>
> See do_pagemap_scan().
>
> The benefit here might be that one could effectively search/filter for guard
> regions without copying 64bit per base-page to user space.
>
> But the idea would be to indicate something like PAGE_IS_GUARD_REGION as a
> category when we hit a guard region entry in pagemap_page_category().
>
> (the code is a bit complicated, and I am not sure why we indicate
> PAGE_IS_SWAPPED for non-swap entries, likely wrong ...)

Yeah, I could go on here about how much I hate how uffd does a 'parallel
implementation' of a ton of stuff and then chucks in if (uffd) { go do
something weird + wonderful } but I'll resist the urge :P :))

Do you think, if it were uffd-specific, this would be useful?

At any rate, I'm not sure it's _hugely_ beneficial in this form as pagemap
is binary in any case so you're not having to deal with overhead of parsing
a text file at least!

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks!

