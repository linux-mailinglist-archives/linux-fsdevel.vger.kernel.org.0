Return-Path: <linux-fsdevel+bounces-52086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB4EADF56F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76668172611
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457B2EA74E;
	Wed, 18 Jun 2025 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NHCMhpKX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FE2EBBA5;
	Wed, 18 Jun 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269868; cv=fail; b=RJ480rjsf+l0LQXDbIiSs3Hr2OcZoRH9WobR3x9nldbMXhlbnKWRdiM1CT9aHirEQBytFiRN9Kbo6caEec4hw+hqmSnvXjbcCOTmp9Z3Ch2om9FUd38lUwrJMSYz6kRpmPU/vRfRiVOV1foYx1jREae3oi7p1gopoVEq3dSH1+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269868; c=relaxed/simple;
	bh=CNWSng/ev6bPYuDJ0BB9zKMX7atn1S8ESV/WUW+/H18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kh/7N+/EqFIQxYvDrL/Ky2hE/0wQ93rbqZ+Y0oHzOb/OIXZN850x2NRWiMKlXgZ4C7TcGXvnLdrSelsaDDFkMbvM8mxjOITh9FewkYXP+i6ycHitC50cyZRtPDRP3LHmRYOoDqqgVVt7ZJoW3LdJ1Rgxc51QVWwwv4cBrYrNgZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NHCMhpKX; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcmLLy/dfh+5ka2fS+KEswLXu6dFrF11UmsrStt4RnYVDAsBQWoSpillHgwU2Tnzg2TOWcmxShBuYXLKxhJ2Zdh0wm4ezn9EXcOd5yAx1kSobQ4MBaAj1Lq43bpOMmRtdbhgWze+XOYrzaVxxCcKIY46QXXzC0v0YCzTMm59ODnY3ScppKGtYtVW4BO3fWhXuJc5/CAImsdAJ0t26xDTMkHFIhvm+4Oe168i4qsuNttsFEyYdb2aXGd9wu4M0dYnAFTlaQ/7PA2fm288qQ6Zy/E/Vcn860Gf8QhdaKcGZvrgKIRHNldHWL1Nmq5/AHTRvvpNk9DbWBSbUUQjUUPcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybg2PwzdKvzJ2k3O67dBnQsXVbMdFwf+DFAoR1htTB8=;
 b=vJ/DMuoWdGg5gQ3bQCO4siHiri54enKygp0NxKuqL0c8NFWEjQFmt/OBd/QKgcOXMfAMkBTF53GDGf8OxhSW+qIgNIKkgL+xdc+DQCL0Cw8ZYi38J9lg1+R50yZ35/+yHzkbEkAEmmDtwE2JxrC4i3RXyo2iKALZ9sbz3ca6KXFIO7qQfU1pyTKIp/ha2oJ9wZ80aEDJZcrOalOuKbFO3yKm9BEP4eQfQm6Oa+B6xN7g4kuuf1Uxb4R/kzn8VsW77OPu8QgTcKuQMrNBWIXKM20CKkJe9GmrMAPuhqNofmTfBK9F33vaV5KQQp0UdqndsfoBrTP78srOITmMlnos7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybg2PwzdKvzJ2k3O67dBnQsXVbMdFwf+DFAoR1htTB8=;
 b=NHCMhpKXMtRZpT4R4q4SR0PMl7HL6XO9cnGrF07bYsXmZ7Qt6fFXFVUlRDoMYAbvmLOH3rm5+oZxRyxzinFSm7Qa0uKCwhtTJ9/cmLbYhx/Oj9NVpnB0ttV9PG+QwTMva/TkyXdavFLSyKkLkiDeyfK7k6DO+28VvjNdRzq1pNop7j6Q4Pua3RKEud6M9UBbNFqykS+I6PTESoSl/5Eq2p4aq7I78ERvPqSdRCCEp6aPi0ERiEtRntAnyUlGu9cqvB6/1hn4B3isgn8/TV0hCa0PHt24KdbtiGN/SYi3lPFvKCgwAmhdUu3tJ/NKVp1Jn96mCPeqCE4LghtZhasX0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 18:04:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:04:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 04/29] mm/page_alloc: allow for making page types
 sticky until freed
Date: Wed, 18 Jun 2025 14:04:18 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <D80D504B-20FC-4C2B-98EB-7694E9BAD64C@nvidia.com>
In-Reply-To: <20250618174014.1168640-5-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-5-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:236::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ea7a65-fb8d-47c3-6c85-08ddae928ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnZhaEJzaXFPamtnSXEvY1VFS2cwQks2cDNETHFub2ttdnZCblhKa2hGcllY?=
 =?utf-8?B?Y2p5TlBjRVhYc2dsY2lpeFRWU0VLOTJ6djBRL3lNYjNtVFY0cWthS2JlWGZU?=
 =?utf-8?B?c2NpaEUxdEdpMk54S0o5Kzd0RVB2UzJOQk83TnpDTUFUbTdzd2c4WnRhVmI3?=
 =?utf-8?B?ZG1WNUtsN1ZVV1dqS0ZtR1YxaHJDaVAyV1VjbmNVV0dJdkZZZnBBV0wyR2Uv?=
 =?utf-8?B?MTVnOTdZeU0xbENSZkhvaXBuZy9SZnErTGNxY2s1RTdhTFZwM0V2czY5bm4x?=
 =?utf-8?B?TWtCb3FaV3UwcEZVcjZKWnBEVTNoTnpJQThTeG1TU2NOREsyY1ArRFFWZTZ2?=
 =?utf-8?B?TlJHY1gzSms0U0txTFF0TXJpeDZ3UTBoVHZJQXZwaXZ1ZEFnaXpBUHhIeExp?=
 =?utf-8?B?TkQvTHVjQUZJREF5aVZ3aTlvdm81M0tvcGdFck9lM0pQYU0rUml5TTM5b0Vr?=
 =?utf-8?B?MGJXNExnMTNFTlhlUy9CNWw3V1RhbmloUkU0MlY0VVI4ZjAxVmduOHU4bEN0?=
 =?utf-8?B?WjJLUGVLUEdkM1ZTU1o1OTFvL2RVV1FFdjlsLzRaUWRidm9UTmxsQ3dhcVhi?=
 =?utf-8?B?eDVWbmp1Z1NPdTJ6NnhzdHN3SVE4Mkx4aXo5MnR1VEtlTDRsOTdDdlgxU3hY?=
 =?utf-8?B?aGozMmZGbmF3byt1V2ZtM3JMTitvdnhuTjBsZkZQcVpNcTR2YnRlS3lhTURF?=
 =?utf-8?B?WVYrV0s0elUyZE1GSWpKTXBUeHlNUFZUdnhWVjVtL3IzSDB4ZFRNT0VZRDBR?=
 =?utf-8?B?d013VFRPeTFHQjhhRWwvY3ZFb2hYU1ZLM3czY0tlUjFsdnl1RjliSWJUdit0?=
 =?utf-8?B?WGZrUFRyeVR3cC8wVElBMzJvcGdGM3Y2UEI5Wmt3S3J0SmJQREM1ZEp2WFpS?=
 =?utf-8?B?THBxVzI3Y3B6Q0JQbTNmODVnZEhsM3JiU0RTc0ZlMmNjdmhSaG9iVTNJNHN5?=
 =?utf-8?B?N1lxOU54cHp1ZlhYemRCaTRWU3ZpTzBkMGVuQVMybkh0N2lkeTdMS0RIY0h5?=
 =?utf-8?B?ZHNQOXBvQ0dzRlpVcEt3TWkrTXd1dElxK2I5QkhrckFnWEJudGp4b2laWUpJ?=
 =?utf-8?B?cHFnYms3RTNSZHpEN0l2S2wyUCtPV3ZoR0hnTlpJRFVMWWsxZ2hEZ0krMUtn?=
 =?utf-8?B?R0lxQTZ2YXA3Q2dOYi95VllOZFFzeTVMbHlPUmo0ZEE1RDBzd1YyMWRvTkdr?=
 =?utf-8?B?eXIyNDRWdklnc2I3d24vRytLSkN4aGdONUlsN2RraktkNi9mQkFERFhFTTRL?=
 =?utf-8?B?bFdJSnpmUGhZVzU3WHFydmZyRC93cTRlMWhmd3ZXd0R6TURvNHl3NVg5V3Qz?=
 =?utf-8?B?aWpiY3VxcXUwM1hNUXVadm5aUWJrRm9RY2U1ejh4SXNpNFc2WEdvL3lKQU1i?=
 =?utf-8?B?QUdFRkxuZGNwMmxqYnFubG9vVjFpc1M0OXowc2xZTi9vZmZCN1p1bVUwWjN1?=
 =?utf-8?B?NWE0QlYvR0FnOXhZdC9NRWRnSTRKZjBPMjZENUUwL2F6UFZLcU83UWtraHBY?=
 =?utf-8?B?R3g1U1RvVVU1WHJVY1FGRUJ5RVpQRDNpZ2gvR2o3SkZOb3ZoYnRLbTNKNGZw?=
 =?utf-8?B?WFBSMzF1SENvYUJEVVZsOTM5OTZhUzlJRERTL0JXUVpIMFU0dWZrYmxtU0lK?=
 =?utf-8?B?M21VSEZlR1lJS29nOHM4S2J4ZlhvSVZuNjVXQ0FES1lIRG9PRFhBZythNUxN?=
 =?utf-8?B?bVg1ZHNseUVpL1R5UGNqUXBQT1VXUzVSUjRWN2N0OTR5SWNxVGxLYm45S1hP?=
 =?utf-8?B?bWt3RUUvang1Zndab244ZHNWWnhZZGFMa3dpUHFpNkJ3ejJqdnluUzlyL2pK?=
 =?utf-8?B?bmxiUWZERGtXZU85c2pzRERUOU5wSVhRMUk1MXFDMzV1dWJYSW5NRWRMY01Z?=
 =?utf-8?B?cndvMjdxZXZsVU1yN2xNdURkZkdoWGFRV09YOCtNZ2U4U25TT2ttZUxpN1pY?=
 =?utf-8?Q?aCKrgsNPTQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K01kcVBLMVh3UFkyUmhtSkFMcmY5WHEvUnB2UHpkL25rWUZPVGhiUk85SHBT?=
 =?utf-8?B?clVBNlhzYWxESWFiaVRwdGM0NE5Cb3dWSjZWMnZtdHk0YXNXNTBsaVZTaE1L?=
 =?utf-8?B?dERoUHM1TnNEYUVWbGptZDM1Q0NPazlRWityRExEWlFWUkJHdk9LMXJwNEZH?=
 =?utf-8?B?bmNiSjF5aExLc2xvSTVRSUV4MzVkMk5qZDFYNnVBNWh0Wm9lZXc3TFZkM0N5?=
 =?utf-8?B?WUdQMlRvcXNOMVdsSVQ4N2xnS3AwTEo4RXcwMVh5ZTU0dFdLRlRMdWk0L2hm?=
 =?utf-8?B?UVp1dWQzSnRxcTFsc3NQWFhrYjNSV3Rsd0V0Q2xkL1M3WFFzb2pWdWYvZVVn?=
 =?utf-8?B?TUpSTTZxMWVjSUIycjJmVHpaL0Q1MnJ2c0dWRW9VNDZaQjVYeXlCSm9seEdz?=
 =?utf-8?B?OXorQm5iWlFwWGpBU1dHZkFON29Eem9aZkN0RDJOSnl6cHhXS0VvaEVhMW0z?=
 =?utf-8?B?UU5aQlc4UDI1TGRGbnRNQmhvMFZZalFzVXA1d0lMbHdGaFhUeDdtTmhNeXpx?=
 =?utf-8?B?YnJiZTVRZ2RONVd5eEtYUENGZDA2YWloOVVsM2NSdDVWRG96UWNFeTBpUGpD?=
 =?utf-8?B?RTgxak9zVTlXTDlPc0pqRXNrODVMNUxIUDEwY3RreWhTUGJ0aWxSSzEzVDRC?=
 =?utf-8?B?ajVPNytVMTBFR3VxOWZUN3lyMU5pR2J1bjh5MVl5SlhpKzNxMm9yTm1sY3Qw?=
 =?utf-8?B?RFRpd0h0OE1VT2dwMFFwZkJVUTZ5cTlnUjdqUTUxNDYyYzhwU3ZHR3FVQlZs?=
 =?utf-8?B?bkFWSFBwQlh0OVo1K1ljdytwZUtZOVQ4ZGVPTzdsL3ZmNFR2c2xTL2hqNEJo?=
 =?utf-8?B?OGFmK09OUnJKZ29LcW5zbTZESTM2dVQybXZWeDhJdGhPQXIvem9zeW9Oa3ZP?=
 =?utf-8?B?czNnM0VYZ1JsOGRYU0drKzQ5NXJwUVkrSzV1RDZlQ0srbFpSSEMzWThnNVBI?=
 =?utf-8?B?b3poV3ptL0Uza1ZFQkNFQjFtbWFFYVV1Q3E0bGlRNGsyWkZZOVd6eFlNclk5?=
 =?utf-8?B?UGYvL1d6YVJ6RXVoSHVwK1dXak1qL25wTmw5ZmFZanVBaG1tVloxeFFWVFhY?=
 =?utf-8?B?cUNWZVdMTXM0dGRERlYyRzZ6RFl0OVBOWkJGeTl1QXhieWQrTFZrL2Z6OVRk?=
 =?utf-8?B?S0lUdzRkZkZHdXhJcnlTSGdydzg4aEpQTDZ0djFXTGdCdmR6azh2eStQYkhU?=
 =?utf-8?B?MGVkMmNKSklQL0duWEJBNi92VEIyVUQwa0c2S1pRNkhqOHdBK292bkFISGZF?=
 =?utf-8?B?TUpiYVpGQkxqYmZRcm80ZitKLzlpMHliZUVVMXFKTGREY1h4VDFmRWdxOTdT?=
 =?utf-8?B?ZDVzblRITjZheFpFbTdiY0U1N2tlRUdkdlJmRXBJQ2E0OGVVamREejR5cEFC?=
 =?utf-8?B?VEdBYndjOXk1Z2tBb1hzSnZsL2NwajZTTzVCNEI3T1pWUEZqQjR1ektrb21G?=
 =?utf-8?B?NkxxS1MwT2hyN1M5L0xVdmQrQ3Q2dktqSi90QW9BWnFZVXNOZnhXMDZQd1g5?=
 =?utf-8?B?eFdXbTFaOWFVdGRiQzlYMDZTMVNnczhUeC9JNXFDWGhRMkRKYTY1eEIzMERk?=
 =?utf-8?B?ZS83dEFrODcvbjc5bkVCbTMvSjE5U0d2bGhXSVNCS1dRYzdNM3ZjZlFTWlJt?=
 =?utf-8?B?UWl6aTQ2d1l3bktTU0xsVUEwQmhxM3FNUXRuMmN5QmpHNy9qa1YvZjIvRGZy?=
 =?utf-8?B?ZGozUHlzT0c5OS9wcU5YR0xEd0MveXR0RE9XbmMvV1ZMS2dBQWM0NjZZeHdX?=
 =?utf-8?B?bE9ENHIzdUNEVEt6Qm45RkJNSzEwVzlCTHkvYnZHZ0xON2VOQVNnUGxFYnhl?=
 =?utf-8?B?Qlp2V3FRVXBNVFFvN0ZCQjAxN2NaaDBKbDVaVmhiQXhSZkluQnFCa1prazI0?=
 =?utf-8?B?SVRMODNCQ3ZaWE9VbTZhVE1UR1c4UFpEVVVvN1o4aldLQjUyQzR0V0dVdDU3?=
 =?utf-8?B?Mm5XSWdzZm5OZGc2SVU5dWFnamxNcVlmR0tkbWhNSFlWbk1HWVlRZmZHdXBK?=
 =?utf-8?B?dVVTbExKMmtlZnArQlovR0hxaFkzNnBpRUlZRTZ0Z1JrTExPdS9rV1psanFR?=
 =?utf-8?B?cnFLWnBjTDBmK3BKNnVTRkdUT3gvWHpSVXgxRnpybzJwV0dsVVhFSnlvZDV0?=
 =?utf-8?Q?WVcW+Jk87uvGChHhU7Lf6cTRG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ea7a65-fb8d-47c3-6c85-08ddae928ea8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:04:24.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b01+JBm7ZjI2eabK0105mDoY9t9zWUzQyHV5fVuy/6txkcX4cUdlbdJ8Yo4X/YiQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900

On 18 Jun 2025, at 13:39, David Hildenbrand wrote:

> Let's allow for not clearing a page type before freeing a page to the
> buddy.
>
> We'll focus on having a type set on the first page of a larger
> allocation only.
>
> With this change, we can reliably identify typed folios even though
> they might be in the process of getting freed, which will come in handy
> in migration code (at least in the transition phase).
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 858bc17653af9..44e56d31cfeb1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
>  			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>  		page->mapping = NULL;
>  	}
> +	if (unlikely(page_has_type(page)))
> +		page->page_type = UINT_MAX;
> +
>  	if (is_check_pages_enabled()) {
>  		if (free_page_is_bad(page))
>  			bad++;
> -- 
> 2.49.0

How does this preserve page type? Isn’t page->page_type = UINT_MAX clearing
page_type?

Best Regards,
Yan, Zi

