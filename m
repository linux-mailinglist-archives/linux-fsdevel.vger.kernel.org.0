Return-Path: <linux-fsdevel+bounces-28109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A4967398
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5092C1C2109F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC139180A80;
	Sat, 31 Aug 2024 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KeV5xbq7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0315E81;
	Sat, 31 Aug 2024 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143747; cv=fail; b=qMgkIF0bFtsGavkPhwJYlpur1Az4KXWB7w6wpOsOvc4Xm/qL8+kbHPfSZUyFnrFyh5Oa8hYvrWp1zEfGHTZaVML/OFl276yHTUCJb3Hc++qARpM+gD73zOf74PYVlvDSQUeVNo8mgBUq5GBrQfBsEhmGMLt4ucH2ALtmNeIkncM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143747; c=relaxed/simple;
	bh=bSlesJpDAlKhEuF/PZFwOIEpJ2xs1rBDhau6gpdnZ5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZzWMqEIgEs/znTQTciFvUF5c1E+2j8KryLVOXhoUuAXvHamMxRHZVQQX+lVTkrib9dY9zXd7iPiH2eCgO2EMW+dKk69Zcp/9LTGb2AKXWnr0ZYC+xdXa2vNu3MYT51UJ8SJmmPsRdkjXKjVneoPQsDH8mA+c5N0uQf0F5oaJBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KeV5xbq7; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmERUPi++Zi2Ro21pID77kmZ6AMX3V6nw94dfTLbnBqAJ6eHUWnjWl9V++X/YwxUQpQA5F+S01qfnDDRXB4xKy9lDX2Hy8C5Nd1oUuLIaqy4dKDclx1MF9pDn8Wqr3BPuXtsLS4SO+xY3ApBHgozVlVOidgdjRxIWFTTAfeo4gju3eBg0pcPgzO34/Bk7AbNEkyRxRcnZV+fTKRjCA6oM7LFY8rTnj8iXXOVrV7xBgbbBGXUCnl/S/jrWGIVpFyI/XdlgQOShlVZWmllJ9t6D1yW8FPXHmj5kIu0/JPLnnCzHenS1SF6vR0AyuHHNH/4iYHkVVbNWM7vA9nUBwQESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZeCpM3RPA8Z2pYwOzEF3jRkilIsbN0t25iKn3Cw96c=;
 b=A/+EXBGrLf1cNHtklpqLCCe/9S9dghbP7p+WRWZ0t081uQa+9p52Lcu+q7o2jZUDJlFDsleaqfo06FBGS8dNBwUDYyVxLIGaWbUJ71lYEBcQsz1/ppDmaGEDlzY+m1994gIytyn9HadMeSu1/Zbc6xktO2mGaOoCH/2i8lLD+YGMnfqT2J3eYQ0LUWzIkV+WjQ4Qh9kEaLU/H5qU89ly1GmyJj3qEq8IGj+Z7+tXAdgTScjk3gEEI0/5fgXwXKM9Eg82MZr5IIefRkbHvamXHzQBkL71HyfiRGbZn46jVnxgSB20tNgpPEw1kQCrI/RiKJ4oCbWLPcaM2oz6wmSShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZeCpM3RPA8Z2pYwOzEF3jRkilIsbN0t25iKn3Cw96c=;
 b=KeV5xbq7mG1eVvtOFOMXdls6df/xpnDjqs4YwJZ5oB2L+GULqzanF91+rTmpvRnn6M4jXYJh0NvTBgNpf7yzBGMO2OD+awci7kiUB/1uPBYQKqF2pluCsNec+tQu/RywaljOEc2DPlbn+B8wxB74DwJD6H2EWLrGv0fQTi2mTTXHsahRmb9olao0JG1gvpW7DFgEOKwjvzvmpgycB4SxoDNN9NnoPCJLt073FVAziqApuPUYSEAwMQS5Zs6uvaMzHFGN5vadxphdDvsEiy+o7306A9/HhA1mIovAq/jijH0ZaDrJnTQP0x1ba4Ps6+X19HwqDqSnQaoSQvBVqnQU/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Sat, 31 Aug
 2024 22:35:42 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 22:35:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Sven Schnelle <svens@linux.ibm.com>,
 brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
 linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
 gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
 david@fromorbit.com, yang@os.amperecomputing.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, john.g.garry@oracle.com,
 cl@os.amperecomputing.com, p.raghav@samsung.com, ryan.roberts@arm.com,
 David Howells <dhowells@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Date: Sat, 31 Aug 2024 18:35:38 -0400
X-Mailer: MailMate (1.14r6064)
Message-ID: <BFB9B02E-0D50-44DA-BF7A-4FD396669787@nvidia.com>
In-Reply-To: <2477a817-b482-43ed-9fd3-a7f8f948495f@pankajraghav.com>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <yt9dttf3r49e.fsf@linux.ibm.com> <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
 <ZtDSJuI2hYniMAzv@casper.infradead.org>
 <221FAE59-097C-4D31-A500-B09EDB07C285@nvidia.com>
 <ZtEHPAsIHKxUHBZX@bombadil.infradead.org>
 <2477a817-b482-43ed-9fd3-a7f8f948495f@pankajraghav.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_275FD986-9397-4830-B7B8-10AE3C33B8DC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0243.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::8) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e6fdc9-e8bc-4a2d-c30f-08dcca0d3ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmpTN21lNVpJa0xRMVl0Mllmd21uSXovR0FRTEpJcmZyUTM2dFE1SkN3M0lG?=
 =?utf-8?B?R0NEbmxHNUg0OW9RUVFqYTMvY0xzREkrcXFBV2hVV0t2Z2hZaDQvc2FJeHhN?=
 =?utf-8?B?UzlEZlgwSGV0T0d3WUcyUGRSWUpkSkZJdng5STNUc1VVR0tWMmFOTTJiNUo3?=
 =?utf-8?B?OFoxdFJtSzVQb2pUQWM3cDZ5NGhhRHFwNC85Rm8xaGFrS1B6M0t2eFhMY2FM?=
 =?utf-8?B?Unl0TVI1NExGbjFpZjlwU0RWYlVHK1JKcVpXWENEZ0gxSE82dThGZGNHUDl3?=
 =?utf-8?B?U1lSK3FqTE5UVTJmaWJTU1dYNUlnRDEybVdJdEJpUmM0bUZTSkJzVmdpdElt?=
 =?utf-8?B?WWdQYisvRjhZTnMxMFJjbEk0S21BMWlTdVZZWHhGZkl0K0VvVnJ4YjMvaENR?=
 =?utf-8?B?amtRdEZDTFAxSDZGdlc3OXhqdTFHVnNUOW0vSDhJalhzczFOMnppSzFFTHRh?=
 =?utf-8?B?bnE5eUVLTnhtQWtESTBqbEZsQkJVV0oyQ0NuSytWNU5weS9LYThBWUZFdGIv?=
 =?utf-8?B?RWhCWHcvMkNWMHkwa3ZQQUNwb1dJNDUxREFQckt0QVlvU095ZkFicTc1aWlZ?=
 =?utf-8?B?VWhKUVhIak9EOExEMk14c01WcWdpbTdmNHFtdnN2SzRhVjVkUTFpMkFzdkJB?=
 =?utf-8?B?WUhZUkxFK1oyUE9ZYU9Cd3IxUFBjRHBkOURCN29nSDBXbXJkN1N3Y1oycmhE?=
 =?utf-8?B?VzRkV1p2cnZwc0tUTGdnUkJHY2tYUnVZalVRUDQ4ekJUWXYycUR3TzFuNTNV?=
 =?utf-8?B?bFRCbnVWU1ZLSW9ERkhWUEIxWkpsU2NNZW5oemdtc2ZEQ2gyU3owV096UGZJ?=
 =?utf-8?B?MFU5dHZHSUNQQmpMaGl3VUplcUVLallseHhwbkh0bndEN21tYnZCN0dQRVhz?=
 =?utf-8?B?c0VHRVhkV3ZwdGNoSFR6aGlHTGZrQWg1cVBjaW5ib1FZS0RuTStYVjV3MlFO?=
 =?utf-8?B?MjlhOFRTWkRsWUl1NHVCcXpaNmY5NE1lMG9aQ3FaTGZwVkVwS0Z5RmhMZDhl?=
 =?utf-8?B?NWxYMDhFdDVBRnRZSDFIdWRaOVl5UFRySkNUMVd3ZDZQSU81MURieTk4dUgx?=
 =?utf-8?B?Y0hEa1NpYWFDcDdZMnoyK25jWUZ6blNNaitETW14ckpDaGlLT0ZRYUwxRWg2?=
 =?utf-8?B?cmplTFBXeDMySjdNOVRJUiszejlRY0NrQjJYUXdKWFVmWDFyZWRBYjVpZmYr?=
 =?utf-8?B?K2VtcjB1bFdMUndQZVBRTERiRkZUeWw3dm1PcVZQT3YzdFR3Q2wyeEhHM3Bi?=
 =?utf-8?B?UFp3VDZuT3lTOWRHbkZZa2grSXFDc2dtdW5BUXZtYUVVZmRUcEJ5Qk50NlZt?=
 =?utf-8?B?Q2g3aG1CTkRHdk4xMy9VZlJ1TzRVd2NnZnFSV2NzS3VnUFpzOVRuaUtJQ0Y3?=
 =?utf-8?B?VFJzUXMzR1FBT3NOVDJhRE5NQ3ZyOTl1cVVKa3ZacGpZTVF2R1VGV0ZwMEdF?=
 =?utf-8?B?RFdCVEZ4b2MxSGZtQjFiTlZpVU5YLzNFVEJsSnl5aUlDSzRhRUdEZkFndDBO?=
 =?utf-8?B?WGl0NjQzcklZMmpvSHZDaVVic2xTWm5mY2tmTzErei9QWnhhKzYrZHBneEtV?=
 =?utf-8?B?V2pwclBIcyszaGlrcHZ5UGdDa1BKNVM1aEUxaUJmY1lXbUxsMWRMSHNhZjFo?=
 =?utf-8?B?Q2VIdXFYYStSMmh6RkRMeGIrNDBnRHFpZkRIcFFwNE9uMklYTW8yaGZQQ3pk?=
 =?utf-8?B?L2J6YmdjTkxtUmlqMzdWWXRCT1g5bDM3b2xZS0NSK21ETDZoV0l6cmdBV1Rn?=
 =?utf-8?B?dUV6TVVmYjhOYldZa213T212WDJGNDNPcUYyUTNadFpUeWNLQWtWRCtMYWx4?=
 =?utf-8?B?Tk04cktiN0JwRXV1QTB0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0tueENtaHNNM1RYVnBMVHEvVU1iZFpPS0ZOZUs2STlteUptTFlmNjk2WVZI?=
 =?utf-8?B?U3hScE5Wd284NktZTHozYTJ5ZWt0UWp6WkhrbWVCam1LaHdYYk9tYzQxb2Rk?=
 =?utf-8?B?ZncwK0pKNjNaRTAray9oMkk5YjJWMWROeDg0UGJCeHhpZEFwekE5bFRoUStm?=
 =?utf-8?B?ZHZ5bDJaWnR3ejQwVnRBZ3h5aGZCQTB4dXNUcDJXb0RkQUl1b2FhOXEzU05i?=
 =?utf-8?B?RkZhQ25JR0lvQm9JZ2J6ZmJYTHNSSSt3ZDZHOElMUDFtWkFVQ1kzK05Dei9G?=
 =?utf-8?B?Y2hPSUdXN2hDYzI0M2dZOVV0MlVUczVzTnFKbTdXVWFkczVnZW56MFpwQWJT?=
 =?utf-8?B?dUw5ekR3QXlDcEdNZjhZOWhDM3YrcjJSMVEvLyt0SG9lS3UyRWhQamFHK2Vp?=
 =?utf-8?B?N0pZOFBrbVlTNXVwY0llSmJwakM0WmJvT201MVVRYlRRdm1LdkFjQjZrbFkr?=
 =?utf-8?B?QUVSWGtncFdwWGxjMEFYbklCbVlRNys2OTBzNFVXOE1Db01HbXp6VmFUbjg2?=
 =?utf-8?B?YTI4THQySGFUeVBYNUVzNllqMlNYNDh4UktONjRWc0dBbkVlYmpKL003WG5W?=
 =?utf-8?B?cFdkc3VCeFV3di9xbWJTcFprRzZCT0lqelNtMmx1UzRMakVWT3FWODlIeW8y?=
 =?utf-8?B?b2syZGhxZ01FVWNBMzB4c0VsZGlhK1lvZUtZVnlUdW9iQUNVRnozWjJQUUZ5?=
 =?utf-8?B?TmVrbys4VTdUdzFxbzVVeU15cWM2OHUrSjdWMjdHWVRqZWI4dFk4ZWdlcDRK?=
 =?utf-8?B?YnFaQzNPWDVyNWwydVBqa01iNEhyazZjZEtmUTNQdzVLRzBBRHZEa1JYWWFT?=
 =?utf-8?B?NzJlNzFDYnREU0FMMTFueFNSRG5kRVVYc2c4S1hqWnhHRXVCY2lwakNpeHRy?=
 =?utf-8?B?bFhic3hKWE1CeFJCblJGTFRma1kvcEZIS3ozSDh5N2YyNDFmVHBYNjFSQkhq?=
 =?utf-8?B?anJldWJwRFdvOXFZOTFVQkwxdFJaQ2wxdE9KaVlJazV0eHVJVWlQbG9ZUWdu?=
 =?utf-8?B?dkNaOWV3ZUdoSkVEaVlDZEErVnEyUlNpUGltcW9UTEhyWDJRQU1sUWlKSmxW?=
 =?utf-8?B?NDIzbmNla2pqTDQ5T01XZityc2FOZ1pCTWdrWVN1RGdCOE92SVFmNldRYnht?=
 =?utf-8?B?VXFRL3gwNFhSVWwrTGwxb2RZM2liZ2tVdE5zcUc1Z2V4MmhtMEZoeXhrMzdD?=
 =?utf-8?B?djNHTklXTDhyQXE3bkFvd3F5RlB6ckJnZEVSNXlNZ0FuM0RkRW9OU0d4TldK?=
 =?utf-8?B?T29CVjU0WGVJUDdMNURRdmVaVE40REZ5b21ZcHhJWVo2MExXRFJjZitVQkVD?=
 =?utf-8?B?cXdycWhEcnlIcWMzNDcvaXJVSDlSamdEaktRUjU5eDN1ZjhZZTZ6VEh4RWgz?=
 =?utf-8?B?R21LZUhZZGtZMCtSRVIweE9QK2R6VURXU1FkaUM2ZitERzd2OG5nRmhnZExm?=
 =?utf-8?B?NDZtSVB4VTNIL2ZuOGwzUk1SdStuaVMybjJWSnB2VzB0UG5XQVk0dU9WSDZB?=
 =?utf-8?B?d05IdG5WT25lRU5vQkhqUm1xMWpDYUpSR0IwMWRpcS9UbEVsV29MbCtoQWtO?=
 =?utf-8?B?SzIrYUtDUEdvM2lET0JLY2VWSGVDVDE0Y2lsYU04cEQxc3BRbjJxbTV2NHJr?=
 =?utf-8?B?aFg5SCtUa0pWMFhwT3dqdUwvWE15d09KZ2t5TllWMFRlMUVJd2E4S0dHa2dU?=
 =?utf-8?B?bWJ3UWFWcXROcFZoM2tLdE5GbXV3RWlpSTIxb0VVWE1OcUN3d2lZdTdOMHFY?=
 =?utf-8?B?bDhsUTh0dXJBNWN1RmRSb0hRTVZyVTZjNzcwMWczdUhNM0YvV1d6UllzdCtW?=
 =?utf-8?B?UTJ6WVBjcTlUeTFDbVU3aFptM1pPOXhJVytYMWUwcGVReUh0QSt6OTVkMHpJ?=
 =?utf-8?B?SUlzSThyNTdZN2pJaTIvNGNVQkNSUFB1VVdEMTZjTVNaeHhhb0ROaXE3Zk9K?=
 =?utf-8?B?Z21nTVZmb2lhUGk1NFAvaGI0OXlobyttYTFuREVwblYrZzJDcURQRWdTcEJx?=
 =?utf-8?B?V1lMTUE4SGJhdEtRaHhodXo3NTVvK3BVelZsUnI1OUFEWUFPT0gvb2txeXhv?=
 =?utf-8?B?NWtCRXhKOVhkRzJBUmhvVWpiU2VNZWhkZHhqZDdWMnhEcmpFeTdlMzBRcUZv?=
 =?utf-8?Q?PuLc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e6fdc9-e8bc-4a2d-c30f-08dcca0d3ec4
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 22:35:41.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wspzTxGbCLYZaaT0BDnpRFqTM1h04UzvEuccJ9MeXaRhr5M3exRrir0kDdg0Ig/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422

--=_MailMate_275FD986-9397-4830-B7B8-10AE3C33B8DC_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30 Aug 2024, at 10:59, Pankaj Raghav wrote:

> On 30/08/2024 01:41, Luis Chamberlain wrote:
>> On Thu, Aug 29, 2024 at 06:12:26PM -0400, Zi Yan wrote:
>>> The issue is that the change to split_huge_page() makes split_huge_pa=
ge_to_list_to_order()
>>> unlocks the wrong subpage. split_huge_page() used to pass the =E2=80=9C=
page=E2=80=9D pointer
>>> to split_huge_page_to_list_to_order(), which keeps that =E2=80=9Cpage=
=E2=80=9D still locked.
>>> But this patch changes the =E2=80=9Cpage=E2=80=9D passed into split_h=
uge_page_to_list_to_order()
>>> always to the head page.
>>>
>>> This fixes the crash on my x86 VM, but it can be improved:
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 7c50aeed0522..eff5d2fb5d4e 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -320,10 +320,7 @@ bool can_split_folio(struct folio *folio, int *p=
extra_pins);
>>>  int split_huge_page_to_list_to_order(struct page *page, struct list_=
head *list,
>>>                 unsigned int new_order);
>>>  int split_folio_to_list(struct folio *folio, struct list_head *list)=
;
>>> -static inline int split_huge_page(struct page *page)
>>> -{
>>> -       return split_folio(page_folio(page));
>>> -}
>>> +int split_huge_page(struct page *page);
>>>  void deferred_split_folio(struct folio *folio);
>>>
>>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index c29af9451d92..4d723dab4336 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3297,6 +3297,25 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
>>>         return ret;
>>>  }
>>>
>>> +int split_huge_page(struct page *page)
>>> +{
>>> +       unsigned int min_order =3D 0;
>>> +       struct folio *folio =3D page_folio(page);
>>> +
>>> +       if (folio_test_anon(folio))
>>> +               goto out;
>>> +
>>> +       if (!folio->mapping) {
>>> +               if (folio_test_pmd_mappable(folio))
>>> +                       count_vm_event(THP_SPLIT_PAGE_FAILED);
>>> +               return -EBUSY;
>>> +       }
>>> +
>>> +       min_order =3D mapping_min_folio_order(folio->mapping);
>>> +out:
>>> +       return split_huge_page_to_list_to_order(page, NULL, min_order=
);
>>> +}
>>> +
>>>  int split_folio_to_list(struct folio *folio, struct list_head *list)=

>>>  {
>>>         unsigned int min_order =3D 0;
>>
>>
>> Confirmed, and also although you suggest it can be improved, I thought=

>> that we could do that by sharing more code and putting things in the
>> headers, the below also fixes this but tries to share more code, but
>> I think it is perhaps less easier to understand than your patch.
>>
> It feels a bit weird to pass both folio and the page in `split_page_fol=
io_to_list()`.
>
> How about we extract the code that returns the min order so that we don=
't repeat.
>
> Something like this:
>
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c275aa9cc105..d27febd5c639 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -331,10 +331,24 @@ unsigned long thp_get_unmapped_area_vmflags(struc=
t file *filp, unsigned long add
>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra=
_pins);
>  int split_huge_page_to_list_to_order(struct page *page, struct list_he=
ad *list,
>                 unsigned int new_order);
> +int min_order_for_split(struct folio *folio);
>  int split_folio_to_list(struct folio *folio, struct list_head *list);

Since split_folio() is no longer used below, this line can be removed.

>  static inline int split_huge_page(struct page *page)
>  {
> -       return split_folio(page_folio(page));
> +       struct folio *folio =3D page_folio(page);
> +       int ret =3D min_order_for_split(folio);
> +
> +       if (ret)
> +               return ret;

min_order_for_split() returns -EBUSY, 0, and a positive min_order. This i=
f
statement should be "if (ret < 0)"?

> +
> +       /*
> +        * split_huge_page() locks the page before splitting and
> +        * expects the same page that has been split to be locked when
> +        * returned. split_folio_to_list() cannot be used here because
> +        * it converts the page to folio and passes the head page to be=

> +        * split.
> +        */
> +       return split_huge_page_to_list_to_order(page, NULL, ret);
>  }
>  void deferred_split_folio(struct folio *folio);
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 169f1a71c95d..b167e036d01b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3529,12 +3529,10 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
>         return ret;
>  }
>
> -int split_folio_to_list(struct folio *folio, struct list_head *list)
> +int min_order_for_split(struct folio *folio)
>  {
> -       unsigned int min_order =3D 0;
> -
>         if (folio_test_anon(folio))
> -               goto out;
> +               return 0;
>
>         if (!folio->mapping) {
>                 if (folio_test_pmd_mappable(folio))
> @@ -3542,10 +3540,17 @@ int split_folio_to_list(struct folio *folio, st=
ruct list_head *list)
>                 return -EBUSY;
>         }
>
> -       min_order =3D mapping_min_folio_order(folio->mapping);
> -out:
> -       return split_huge_page_to_list_to_order(&folio->page, list,
> -                                                       min_order);
> +       return mapping_min_folio_order(folio->mapping);
> +}
> +
> +int split_folio_to_list(struct folio *folio, struct list_head *list)
> +{
> +       int ret =3D min_order_for_split(folio);
> +
> +       if (ret)
> +               return ret;

Ditto.

> +
> +       return split_huge_page_to_list_to_order(&folio->page, list, ret=
);
>  }
>
>  void __folio_undo_large_rmappable(struct folio *folio)
>


--
Best Regards,
Yan, Zi

--=_MailMate_275FD986-9397-4830-B7B8-10AE3C33B8DC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmbTmroPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUro8P+gOXJXb4UkTZQTWNHdC25l8gpEgJp7AyYyuY
pIbPzk1tAimzcdemI9g5FvvDQrUTL5WiTvcg14II3KZ5FkgS2u1+Vu4aNu2z5T1m
MkoRCkzjrkT1yiVLoBebrq2hdie2bk7Aoc1l2Lt/GnZmwXq2Zjotq6kZ0l+8/g20
h0N5ASsFf39eC+v5jJf8OyvMmGwCusqQMVuxmYotnL/ha1VFVMFaQIyvwtuFUfk6
2QAHH9DsT8IPMsCYf9p9hUHAw5O743Zf17h2/Y7jNCX/Fp6rYT4qQVvNfKwxmI2Y
a7cj/naEflgXDde9i6tCeeBftL0ivIN0K56H+JR/SZq9GVQvmDV5eXkdN+f69LHi
1RYY6PgjT/ERR2enJ6dX6WYBjZnuSWCKAA5+7REFQUduaNpR/3PkUeA9ZXAtOC7A
O3tm7LereDww1baoemUlKrlHF/51s2GAFh6S6utOxfzW9BVCezCi+JJjh9di1X3x
7u1k2leb9eQvpJtOsdSFK33uH0ok6BT8XBT5CR+1gK165HO9M8H6VJ0J4/YWu2eY
9ORMuSLWIxCg5b0Emh04s2XcpPCWwO2stq7idPavnGFiwEgto3Ryr0ZuI4so1bhc
z85Tom852Dt06Os4Y1VU8Dokv/9Lfd5hk3dhF/E0mMfTwcSS1Cz8nFn1Ts2woywV
KkxUNX6Z
=2aOf
-----END PGP SIGNATURE-----

--=_MailMate_275FD986-9397-4830-B7B8-10AE3C33B8DC_=--

