Return-Path: <linux-fsdevel+bounces-42504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0155A42E20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9CD189DCC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2026157F;
	Mon, 24 Feb 2025 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p43etXNO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E3245005;
	Mon, 24 Feb 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429616; cv=fail; b=uMvnLgEeChJ1+1+wRzXNlMjuJY0kq6OcktXeE9/DqrfWhQ2qsYUjhmuVwoKBp2522w2LHai+w9adN4shbY/XH8ODnmVchggFkDWGi+T+rRrpVsSBaU3LrX52u1bl666KlPilH3QyLmLHWWwHJVbXvcHY9+sDexhY0k/ic24qOOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429616; c=relaxed/simple;
	bh=kZvQbpZbEu2ywKExKNuC/5q5eoQbkJeWnnIDw+SdSpQ=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=fE6qdj0/c9cdQtbGz29OPBet3vqULIYdcR/nGdqkbAu7mYI9DHZmXeFEBhjqY9I1VupGE02A0Y+dv3tBmT5zV0605Sz92P9PReuSSQR77e4V0NORRpPAZHwaUnifpFsgL7RTd/SPAIEGQB2qRPcm43qpZcwo1Bsr/6N5V0Z52t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p43etXNO; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBdFiDemyY2xA+39C/7NfbpSsZKcIXVy1gDhaKjAzSIcqj+8mPjJPr5fP+lr4v0lH9H68829l+0eOehxK5vcNfWdML6eivZnOkSE/TXbXlprsDYFzvGN4tcm02Y57zOmLEGaN7EgMSE8H2td3S0ycmwVcwTN9smbjz8sEdKF8Lt7mYBrB4Eyb7DQqlJl+P/d6v/OPR1uQydkPUni1JjCK5VrzCPrzc79UtiSMoXgoeYPYH1Jk3B/6zAbR/XkaLlrEXooT6daT2CSsvdFxll5h6D4feuhr22RnoJB2z/gDFK0FszCZcNqqxM/dDVptw4D5h2Km3PTnTjCU+TWavPT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bllpSOnu9PHss4sfWXdE5kg5uj9pt3CckVx2ztn/y50=;
 b=qWpe+AFraxdUuB1D4lt33GeJtkZ8BffPE3g7hap074uk+RTktaIjCw4vT+zTjeBl4+CFTZNW64Y7DIZHbC2nasXEWFJJI9Iv94IfjnI0tt3W0l1Hoj5y9BL2qUtPNqu06U8FiBGc36kla4wBCiO7w+JrX3pW0uEZ/54d2hLdN5IAxRqkT1kL4n/YlD3LnlCYiHYwN7dxlwspwnEYp0uC5A+GpLGdmZ8QuDYh8yqk/fcCNp1dTytxCRxk62Bl/1piGzf9kJZ6/jUtECm2OWMC97M5ZUyHzl4jeKjMnc/7khCSqpKmcnHNSiPbcPJZJ9vr2qB10JIEjFQz+OWu7Zdm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bllpSOnu9PHss4sfWXdE5kg5uj9pt3CckVx2ztn/y50=;
 b=p43etXNOIzivrrLRb0hnXBWcMVA+FslXO0t08ZafP+hSaKXv5GazDzgGOcawvSclfC+VPBh3//ucgK9ta6gxYsO+z5Awh1GMVQEVYr23oCqj16pCjkWeViHUcZYfZNgXsfzxXZW+gOh/hsSZfLvqhyiumpLjmgN+zmJPDFlUMf+kzNw4CT0EjJ9MP0myue8VmD/HLnKHwac8i0gZpFFkrlZz5qWTyfgITQ2TeRlrxZkeA45jkcuPJMXsi5TW/64oOQn3As+fQOkX6N4aJkFiO0ZYWeuzSRKcrKg+hBy02pfYWGCmF67vcHh/zYUBGtYAiXaiN8j5LrY55ydutzvcag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 20:40:05 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:40:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 15:40:02 -0500
Message-Id: <D80YSXJPTL7M.2GZLUFXVP2ZCC@nvidia.com>
Subject: Re: [PATCH v2 16/20] fs/proc/page: remove per-page mapcount
 dependency for /proc/kpagecount (CONFIG_NO_PAGE_MAPCOUNT)
Cc: <linux-doc@vger.kernel.org>, <cgroups@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-api@vger.kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Tejun Heo"
 <tj@kernel.org>, "Zefan Li" <lizefan.x@bytedance.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Muchun Song" <muchun.song@linux.dev>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Jann
 Horn" <jannh@google.com>, <owner-linux-mm@kvack.org>
To: "David Hildenbrand" <david@redhat.com>, <linux-kernel@vger.kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.20.0
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-17-david@redhat.com>
In-Reply-To: <20250224165603.1434404-17-david@redhat.com>
X-ClientProxiedBy: MN2PR20CA0045.namprd20.prod.outlook.com
 (2603:10b6:208:235::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 70193184-c8a4-420b-906e-08dd55136b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXZWR1ZMWnFLVVdxUTZVQVNlQmY2MjhsRXI2Z2NIOUMzRVNJWEljN2JzVVRL?=
 =?utf-8?B?aStuQytUUTM2ZXZKZjM3U1IyMG5TcHpIb0xaYmhtVUp6QllnNlZseTErVGpQ?=
 =?utf-8?B?eEczekwxeG94aitxaEVkY040Z2p4QlA3QWZkbzI3bWZpSnJQRDVJWTlRZWlo?=
 =?utf-8?B?RmxYL3V3UVdqS0tXMGc0Z3luOWdoWVo3WFB0S1I2bEdGMUNjU0c2QzNmQW5Z?=
 =?utf-8?B?aVNJYmpiK1ZUd1M5MkhtWnVTdzl5MWNvL3lIK3lLdVJzOGJ2VEhqVVJtRzdM?=
 =?utf-8?B?ZEFjNkZXbk9FcUg5d3UxME1EWDk2ZzNhQkpxdHhtODlHMVAzN1dKRnFQVjB3?=
 =?utf-8?B?aGtSRkFtWWVVYXgvMVZDSzc0cGF6NU5pUDJDNWZIemlJK0ZxUGNqMFZ6Yjg2?=
 =?utf-8?B?Z0NNUXQ2Z05FWDZUQStHUDVRamkyTkVsbkt5T2ZBblN3SFdFT0tEOGE1MzAr?=
 =?utf-8?B?WnpDT251ei9uZytXdk1RYWZONTJXMzBhUVN5UC8xcVFCbnY0eUtqQ2xTbkNz?=
 =?utf-8?B?NFBTWDN3azdrZ2J4MFFieFMyeTdtMXFTVi9xdkJpUXo1OXlkNnI0aExQSXA5?=
 =?utf-8?B?bnY1MVpWanA3WStyNkpHcmtMOUJzNHFoT1dzK2Zsc1dkcWxacmM0YkVXeU1Y?=
 =?utf-8?B?NDhNcWFpTTU3cFh1V3ZwQ0NrZllEaWpCNTlwVFZWQVlUcktTME44SUZJTEZH?=
 =?utf-8?B?T2pQVHZoZW5RMW1EaUxGQjMxVGNjVlNBWEF2M1M2YVMvMEpIaEVoNGZBWjc3?=
 =?utf-8?B?eC92NGRaejRNQk9kSVZNOFVJbnJEb01PMnNnSzJjMnlrMGRQTXZ0c3VoS3lh?=
 =?utf-8?B?dTJrSDhiQTZDQ3Ixa2tkS3JKSnJiTUtXMVZ1eXpZdEtOcktvYkhocU5NMjVt?=
 =?utf-8?B?dHRmQVk1NnJZeXUxQ2lRTW5lWU9mYmxaVFEyM1VJaWlUNTV3ZkR6bFZydTBo?=
 =?utf-8?B?cFRLbk1vQTZIbkVuWTdzZ1NDVDZyY0JhMllzdi9FWGI0a205SWFiYi83MDNZ?=
 =?utf-8?B?VXplVk1nSXh0eXNrUXpUSmNld0F5aG9pelk5VEJHdk8ra2ZTTkJFek5wb0ZO?=
 =?utf-8?B?N1NEemNkdE1XcE1ETE5nb1BJMnFaN3F2VWovd0VTbzlMa1UxZ3VrNHUwRlJV?=
 =?utf-8?B?elFIQyt5OUlLSnRMemtNRmhRWk83S2I2TDZmbVJ1ZThUdWZKQ0U4cUwxQXBG?=
 =?utf-8?B?dE9lSnlqanhYZnZ4aFYxWGs3RVZ1SjRuSVdWUWhJVlg2eFRUUlFxUWZlN0h1?=
 =?utf-8?B?bXZQa2ptKzhHOUlLWXZRVDNVdHQwSm82b2tMVnQwTGZsbEg0T3FiU3BBanlR?=
 =?utf-8?B?M3E0RkdSWmRpNmZDYnVleGtlRmJ6cXhsODdDNHV1c1IxTXZPSFZFbGpUMGg1?=
 =?utf-8?B?Z09ydXJRK1NnV0dFL1pheU9lVnlOcVJDQUlrQVA5S3pKV1ozc052UUZtSGJN?=
 =?utf-8?B?d0pFTUVDd1NlVTRocTBOUU02a3BPQlh5NitIOEdUQlg4WXNSNVY4Wm05aTda?=
 =?utf-8?B?RWw0WGhxUUlYVUFyS04ya0JiaG10OFo0Qnl0L3Rtc3VCdUZ0N1dBR0NvZ2Ro?=
 =?utf-8?B?VUwyZTdRbDRteFJQdm9nQ3JkVDZFY1kzTU1GVkZsYkJ0YVhZazQ5UlNhYnY0?=
 =?utf-8?B?aVp6WFRBdTZGb3k0OHhobUdXU1pQYnRNbTJFQ1dzdXdRUlM5UEFLbTV4cXRW?=
 =?utf-8?B?amozY1paM3hBWnFIN0pNUGRXNmliOTVpZnd0TEtJUzVLL3VYNWdrNTNKMTEz?=
 =?utf-8?B?ZGVTd2xuQkJhTFIyYmRXejBMZ1JUcDl1WXhMZ0p1REU2SXd5djk0YThpQ2Ji?=
 =?utf-8?B?YnUrV2ljWkRNQnRjbjR4Sy9XVVpXN1NoRHFwbVFwUHNKRXhabHVuNXk1WG1T?=
 =?utf-8?Q?PlEN7cC5iqw/5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlR6SHMzOHg4MG85UnhvclBMU2VEd2I3bmUyOEhLbEdxaERPRjlQMEUwTHdh?=
 =?utf-8?B?N0JyRzhFVitOOURVSmNmdTZ6dTkwNjIydzdDRkMxZnpMMFZ6MWdvekN2dWFG?=
 =?utf-8?B?bEIrbWtBQVd6OXQ4NWQ2MmJFRVZGTlpHOXhTZklQL3ZtaWUyRytjYm1sU1ZW?=
 =?utf-8?B?SGdZYk90WnlSbEhFZlIwdGZtRjFRZk1jTzdUTENUMzVQK0s1d0g4Q3hmM0dp?=
 =?utf-8?B?TmQwdDVaS1Frb3lwTTlOY0JodHduZnR0NG0rZml1UEZiWEVUVE83djAySGxo?=
 =?utf-8?B?cHoyZ0NwMkFFbXFMTlZlSU11Y3Q5MDlrdG00VjVVaGRlZnlIbVRkcHNMMDVD?=
 =?utf-8?B?L1pMbUJTSlNIc2JYTzRSS1Y5cnI4a2FFcnVvZlBIcW1kaThONlRWL3dWT1BQ?=
 =?utf-8?B?VytOS3VSUEpwWmZnQnN2b1NRQ0lKZUJJYktPem4rQWpmKzFqTEorVFRBN0dO?=
 =?utf-8?B?TjZRLytlQW9DWVNSY2lxK3dOZXJrQ3NqaUlCVi8rMmJITUFGM0N5UGZEMnNr?=
 =?utf-8?B?U253VVkxQWRTbWJZVng1NEhWTG83SEwyc3c2dm1pUTBHSzNzUUFzemFpazZG?=
 =?utf-8?B?MHZlTnB2THZVV2RCeXE2QklPTHpJVzJ5aVI1aUU3RVBkRThQaWF5K1NWQWFJ?=
 =?utf-8?B?czJHZm9DVlFlNHBndXU0aXFiMzV5ejJLNURROXphUEpZQjRFbGgvck1lc3Vu?=
 =?utf-8?B?UDFWd09vSitKSGF4WE9RQi9zY0hBc3NlSVh4eFUxSlVaMGN0L3Q3Q2VNTzVM?=
 =?utf-8?B?OTVDbkZpaTB0VElyUlpnd1FOZWx3MmtzQkF5NFg2K0s4OHY4emRBS0ROUUdv?=
 =?utf-8?B?ODhKR1Rub2JnWVl5THhSYnhYaUl5b1FuanNBS3RicHZZNU44b3JTWTBMRGxt?=
 =?utf-8?B?TFZrK0hNeHl2RGZ3QlUwOXFvM1lJRXVqTmw4eUp6Tm94bkp0QWlPQW0zeFBG?=
 =?utf-8?B?dERHcWFQSjZkcXJJRjF1RDBQeHJSS3dNb2dkaE14ZkdxbjJQb2l1L3RuS0dK?=
 =?utf-8?B?dnJ0TWpNRUo4aEFIODFEVVpPUE05NFdjMVFIb0RPNitBMjQ3bTZkeEx2ZWJ4?=
 =?utf-8?B?REpCNVFHMlZKeG95czN3ZVU2SUJOMHJJTHhuV1RWbFoyUnVQbU8wdEM2Ymlk?=
 =?utf-8?B?UTRrYmpSWnZWazYwR24yeURCWERmZHM4bC9xeGxBdEcxYnZFY1pKSEN4WGJP?=
 =?utf-8?B?MjRjQTVLY3lyOFNxNHRKUy8yYmtPZUhjOUxXT1l5OFJ6YUUrajBSeWNhdDNv?=
 =?utf-8?B?bWJPQXE5anNwQjQ4ekJDY3k5ZHcxQ1ltNWhpN1ZDblVhU3ZnOVZiRGNIWmZ0?=
 =?utf-8?B?cHdlT2daemN5MHE5bGphSnBaU0R4bjRuWEZBWEdrWmJHRnl5bnpNa09jVzJT?=
 =?utf-8?B?UWdVd0NlaFR1WG1nRU9YM3lYZkZsRjVMQ0tLazlFcjlxS0xLZWNvVmVZNGc2?=
 =?utf-8?B?blJZYS85OHd5YS83YWwrNmNmUml1bzQxd0FXZ3RrZHV3c0RNNzhlMjBIR0ZY?=
 =?utf-8?B?RHMyYWt0U2hocnM5SmowT3hLNzFDcS83bFpGYW94OHNSejROUkFzeCtUR0Zj?=
 =?utf-8?B?eERnWk92ZkNmSXRNREFhWkRsdVlmYkViRnByL0UzVllUNkFaQVZ0eGtOZ1hY?=
 =?utf-8?B?N3FYcE4zS1EraXF6eGFlT0Y0SjRhV2RHditwZkJzSWgzMTFTZEpxSVVvSnV4?=
 =?utf-8?B?cHR4Q2d3aXZFc2pLUTJZMUIwbDFRSGRmWHB4WGRZVnpSS3Q3djhNNnNtaTBD?=
 =?utf-8?B?bjJCM3pLUFFGYldBNUQ4VDFSY1FoMkZYMUZjMGczNHVyNDh3MzltcGJqZjhX?=
 =?utf-8?B?VEJIMmFLSlErak80WE9vSWw5TzZCenFpQmpXc1M1bnJqQUdtb1hMNmhxN1lD?=
 =?utf-8?B?TWtEZVFOd3ZBcFBlaFRXTWV5OFowNG1FalJySGlMTEcwbUJlY20rUmRJa1F6?=
 =?utf-8?B?WFJKcWs3YVc4UWQ1RkpjbjJtU01EUUZjazE2bzB4Nk96THpRZEpnMXNGUDdz?=
 =?utf-8?B?eVovMmhNd1hDT1ZSTTZDNDVrNW1JWVBBMklHN29SWE5pTjBVMjhTbHFxcWFN?=
 =?utf-8?B?eUNUWE4zaWtUNG1Vb0NaN0FPT0RLZkJvRFd2TzVlZHZBTlFZOS9zOU9Fa2J1?=
 =?utf-8?Q?1OFY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70193184-c8a4-420b-906e-08dd55136b1d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:40:04.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4oDlfyWX4AGc5qqMgd91c/DQOzSG/PaTmWCtSzCNJxgP6uZ+w0AOMvq0EShkKWQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818

On Mon Feb 24, 2025 at 11:55 AM EST, David Hildenbrand wrote:
> Let's implement an alternative when per-page mapcounts in large folios
> are no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>
> For large folios, we'll return the per-page average mapcount within the
> folio, except when the average is 0 but the folio is mapped: then we
> return 1.
>
> For hugetlb folios and for large folios that are fully mapped
> into all address spaces, there is no change.
>
> As an alternative, we could simply return 0 for non-hugetlb large folios,
> or disable this legacy interface with CONFIG_NO_PAGE_MAPCOUNT.
>
> But the information exposed by this interface can still be valuable, and
> frequently we deal with fully-mapped large folios where the average
> corresponds to the actual page mapcount. So we'll leave it like this for
> now and document the new behavior.
>
> Note: this interface is likely not very relevant for performance. If
> ever required, we could try doing a rather expensive rmap walk to collect
> precisely how often this folio page is mapped.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/admin-guide/mm/pagemap.rst |  7 +++++-
>  fs/proc/internal.h                       | 31 ++++++++++++++++++++++++
>  fs/proc/page.c                           | 19 ++++++++++++---
>  3 files changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/adm=
in-guide/mm/pagemap.rst
> index caba0f52dd36c..49590306c61a0 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -42,7 +42,12 @@ There are four components to pagemap:
>     skip over unmapped regions.
> =20
>   * ``/proc/kpagecount``.  This file contains a 64-bit count of the numbe=
r of
> -   times each page is mapped, indexed by PFN.
> +   times each page is mapped, indexed by PFN. Some kernel configurations=
 do
> +   not track the precise number of times a page part of a larger allocat=
ion
> +   (e.g., THP) is mapped. In these configurations, the average number of
> +   mappings per page in this larger allocation is returned instead. Howe=
ver,
> +   if any page of the large allocation is mapped, the returned value wil=
l
> +   be at least 1.
> =20
>  The page-types tool in the tools/mm directory can be used to query the
>  number of times a page is mapped.
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 1695509370b88..16aa1fd260771 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -174,6 +174,37 @@ static inline int folio_precise_page_mapcount(struct=
 folio *folio,
>  	return mapcount;
>  }
> =20
> +/**
> + * folio_average_page_mapcount() - Average number of mappings per page i=
n this
> + *				   folio
> + * @folio: The folio.
> + *
> + * The average number of present user page table entries that reference =
each
> + * page in this folio as tracked via the RMAP: either referenced directl=
y
> + * (PTE) or as part of a larger area that covers this page (e.g., PMD).
> + *
> + * Returns: The average number of mappings per page in this folio. 0 for
> + * folios that are not mapped to user space or are not tracked via the R=
MAP
> + * (e.g., shared zeropage).
> + */
> +static inline int folio_average_page_mapcount(struct folio *folio)
> +{
> +	int mapcount, entire_mapcount;
> +	unsigned int adjust;
> +
> +	if (!folio_test_large(folio))
> +		return atomic_read(&folio->_mapcount) + 1;
> +
> +	mapcount =3D folio_large_mapcount(folio);
> +	entire_mapcount =3D folio_entire_mapcount(folio);
> +	if (mapcount <=3D entire_mapcount)
> +		return entire_mapcount;
> +	mapcount -=3D entire_mapcount;
> +
> +	adjust =3D folio_large_nr_pages(folio) / 2;

Is there any reason for choosing this adjust number? A comment might be
helpful in case people want to change it later, either with some reasoning
or just saying it is chosen empirically.

> +	return ((mapcount + adjust) >> folio_large_order(folio)) +
> +		entire_mapcount;
> +}
>  /*
>   * array.c
>   */
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index a55f5acefa974..4d3290cc69667 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -67,9 +67,22 @@ static ssize_t kpagecount_read(struct file *file, char=
 __user *buf,
>  		 * memmaps that were actually initialized.
>  		 */
>  		page =3D pfn_to_online_page(pfn);
> -		if (page)
> -			mapcount =3D folio_precise_page_mapcount(page_folio(page),
> -							       page);
> +		if (page) {
> +			struct folio *folio =3D page_folio(page);
> +
> +			if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
> +				mapcount =3D folio_precise_page_mapcount(folio, page);
> +			} else {
> +				/*
> +				 * Indicate the per-page average, but at least "1" for
> +				 * mapped folios.
> +				 */
> +				mapcount =3D folio_average_page_mapcount(folio);
> +				if (!mapcount && folio_test_large(folio) &&
> +				    folio_mapped(folio))
> +					mapcount =3D 1;

This should be part of folio_average_page_mapcount() right?
Otherwise, the comment on folio_average_page_mapcount() is not correct,
since it can return 0 when a folio is mapped to user space.

> +			}
> +		}
> =20
>  		if (put_user(mapcount, out)) {
>  			ret =3D -EFAULT;




--=20
Best Regards,
Yan, Zi


