Return-Path: <linux-fsdevel+bounces-67973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C78C4F155
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 17:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16B394EB575
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6243730CB;
	Tue, 11 Nov 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qWc0fBtt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142A26A0C7;
	Tue, 11 Nov 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879253; cv=fail; b=Klo3lxw8fzGxHx6gY9H+7xg/v6Vm3lWUJUQjUyjO+6w+IiRhd7HMTn1cm2VGHu1hg4TDN7HKOuv9dRnxoxEaQENDCelF8kRj2BTjHP9Koha9ziTVrVEA/3VD2O9sbauo+LDbngu67+q6yEr7Q2m8v3WW4XmqIFUXZ5+1TpD7+lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879253; c=relaxed/simple;
	bh=RdcZuq8Lw5CzF9632+UgD6g3KCSpA+ItlJ9wsbD6afQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ByfKJbOx4DYSLV+Rg6eOiiQXC1W92pE4m67oQj4TKMFhobkjdDJMgdUtV3qrEU8jx7eobdAvWLaIUUs0I8KVsLeWbTB/NhHs30O0duwhydg80ZiVzsjB3IuOZ2gdq5QBJOegQfMMh23n0+De9Q5Dz1Xd+crhD6DNGnHpyY0O50A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qWc0fBtt; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tqt/jf8iu9lKmAR5woTijcR1yf3l3gf+DtZFXTF7XBeYBQoJMrfZNY/Rzp1fJxjTivFHSMg5M1mswmc68iLOXy5mvKtpL+EG7mvUmpQvL9za8zD3HwcIplhdHnqhj40eGt9UpmYh6PtRzVzfDwSmkvbUIvNU26M9acuumqL4k1TWNE+VIZOhHSSDe8nkvqhpffVuWvt5U5+7jxoPMWGSAiO7w5QXDd2pzyt9QKEQZ/C8eDSUY5RFmsxEoSEG8XPbQwdNO6tgwmEC6SxXzMbpyQbXQazDIps3OOBWSx4/FrNLomID1yJtO7tWqg7WPZ2hY0haAXpI7xQ/RSu3LITHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz6lj4sx8kwRyakB1AbvR40IY58fTuucw0IvRsu6GQA=;
 b=gOchCTD0ZbRwj6igX/jPT9hU6zTPyYgaHYHUbdVcbuaofwhcL/iDV8nQjZlF2mmSQF4ZWK4soLJtZtUrN1dCt7MepDLxVY5cfIEnfHWyTK7pbLfRICcmDIQfi62oLvdDkmPV4i5hLsvertoYFQKbYNPjDjhu1GRzTgryTsX9j39A6WeHxDzvqZxI6PcvE7bCGWQLbWYDt2psfzTT/NEyr67qNx7PNujOaP4F3w89INgd+tRG6qWWIhgUj5gMLYQX/rMBy+4pSNPPea3uTcaJZiWmY8d15zJLZp5eKSrUafixOreWbhP3yv4bWa/VYyKLmGZdRdopkyTWkUuGPosEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz6lj4sx8kwRyakB1AbvR40IY58fTuucw0IvRsu6GQA=;
 b=qWc0fBtthgPWPw50CjJvhN3mWnOrWAxeeJt2o9F7n/xPjWMqUhgGrXiz8M/98lmN9yHonSQr8vxA8ko2hzxMduG3PVMKcYGx76jprXhZscW2XAKJjSO982pYvPY+lksgwr2TP/SpewcQfzjf8f6KfCW2otYrooyMqsl2pOquaQHxpFrfbTm9D0Dsh8w6ONwY1XExs/yzpej3CCC8fDmCADyOQbDOQpBTDs0JDLTKeC0yJRZQqiNP+Sjw6u+h1K2Q/LanCCkDcD46mYOO8GI3ibnHdrlFB5FvWiF8RWXYCp/+D1yyRyMuSJ3DojLQkl+rhBrI6jVnIFevF1WotP8LAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 16:40:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 16:40:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
Date: Tue, 11 Nov 2025 11:40:32 -0500
X-Mailer: MailMate (2.0r6283)
Message-ID: <3A90DCF0-88BF-4117-8349-82141C7357FB@nvidia.com>
In-Reply-To: <a2063bd3-8030-4c80-a361-c84274b5db99@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
 <3E8190A4-5B17-4A36-9025-F7E4FF1127AB@nvidia.com>
 <a2063bd3-8030-4c80-a361-c84274b5db99@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:408:ea::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb86e7c-900e-4348-db9d-08de21410b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXlJMmhoYmYyZ1NXdlhteFZ3R2p2YkNhakpaMDBQSkxybHBtcHptblIzb04y?=
 =?utf-8?B?K1JjaUVYTkVPZm40OG1mN0xFZUU4dTRXdEluaWRSZmQweXA2d2Q1d05kUllC?=
 =?utf-8?B?T2tUUktWV0h6ZC9OZHg4Y1FBUzA3NFBQUGRKeDIxMGZqNzJHRDdEL1JGWEdO?=
 =?utf-8?B?Rm1DQlJHU1ozZk5UTGlCMC9rTlN6NDJYby91TGdwMVdQVzlTTXljdktkWDhz?=
 =?utf-8?B?QW1DRTdPYjJsSmtCU2JRZW02cFZDcW40ME5HMHh1OUk2UzZwNlpkbEpvcXZH?=
 =?utf-8?B?MGIwbTkwQk5NYXdOVG44S0ZhTEw3TjhqL084QjhEb2U1K09kVEphZ3lVajlj?=
 =?utf-8?B?OW14b2gyQmJIY3UveTZMU1k3OWllVzNIVnpIVnFmbjZkN0NQL0N0WHZGZzdl?=
 =?utf-8?B?RisvU0haRzZHWG5Na285bk9RTGkvN2k2dlBhQjIydDg2ZzViQlROQnk3UTNl?=
 =?utf-8?B?OXdwcnFhWDBwUzIrbUhGL2lVS3R1Yy9jQVZvTkpDanNQTkRKWHdIUk42UmUz?=
 =?utf-8?B?UXpFNlF5NFBUQU8rbFRkeFQrNHRPOWhrUDByQmZ0UElKWWZ4cStxNXZMYkRU?=
 =?utf-8?B?RjBoUlJET21EV0ZNWVdkUGdlR2tTY1Bjc1NZSkZoYzc1UkZkRVY0aHRVdkRV?=
 =?utf-8?B?L3hzMmVEelVTdlBFWjhEY2tLWitkSlNxbzFpZ3l0MTNBeldSZjQ3Y1FVaG5i?=
 =?utf-8?B?R1VIbkE2K0ZVUktvSnFpRjg0Y1NFb3lMckhKTDRRK3BBR2pIQmhidnVYTG1O?=
 =?utf-8?B?L2JibnJGZ2R0MWhyTSsrT2lJd3d5ejJaYkF5NVhHWTJrOVR1NkZtcHJ3QXZM?=
 =?utf-8?B?OEtwMTBBVGJxRTZJY3VLZXEwTDIzdFVZNCsrYVgrRlJCWDVGOC9XaFRPNFNi?=
 =?utf-8?B?dUlJb1V1SDVYMzlhZDBjWjJENm54NE8yWGJaSzF3Qkx6cWVnNWI0NzdkZS9C?=
 =?utf-8?B?MllMOE9qaXdLK3BqNVlDZVQzcEJxU005alpIZ1M4djl5eTd2clhPRjFPTjRL?=
 =?utf-8?B?MURXaHl1NGkzR0dWL25DcTJQbGx0N1YranIwdnJ6dmQ4K1M4VDFGeEZWZlBy?=
 =?utf-8?B?YW5XWDc2L2JrdUFUMGVmMkFXN1VKK3VRZW1CbnlzUTE1RnpoVDF4a2VKQjJW?=
 =?utf-8?B?VXlpbzNkT1VrU2JmUFBhU2cwRDcrVFlqMk9BNkFscDAybDdPZE9XTUZRMEsy?=
 =?utf-8?B?Tk9TL05BSHhQdnE0a2NJVUxrL1dqMlJQVllaZXh2WW1PRlFkOVloNElucWcx?=
 =?utf-8?B?TWpnT2oyTmRVUnEveVVhcVorSi9jRjBCWVEwUlhCQjRRMWROKysvWThyc0lY?=
 =?utf-8?B?dHN3OUY1ZzJZNkNZL2VXTzAyV2NPR3BoWWRUUGVJalBvWTFxdWVvbnFOaDN4?=
 =?utf-8?B?NU9ScVNKdi91bTRTL0lRL1RWN2VlL2Y3WHFrU24wTGFSRWlhT1d5eFJGbHVi?=
 =?utf-8?B?OVYxZGNQYnQ0bThMcXgvRzhwUk56Ymh4Yi9BdkxGMFdEb3ZLMGxwbHplVTFu?=
 =?utf-8?B?R1NvRHhjaWU1TEhtSmdIM3FYY3FnSVJ4V3FWTWZBTGpuVHdiU1lJcVcrWHZU?=
 =?utf-8?B?bktiVThtcHg3SHZiN3pkQWZVTEpqendLTnVVbXNxSTdwakhBaHVmYW5ld1RP?=
 =?utf-8?B?UWtqczNSYW12bXl0TXRpRnIyM21ZUmlsQkRyZ1cvaGNFWU02WG1YYnFnZUMw?=
 =?utf-8?B?aGtYZzRrMU5hZ05HTlNKQ21OUlM0bVlJYnBYb25IanlTZnZSbitCWk13WjlT?=
 =?utf-8?B?NXFxUmd1RWx3Qm1KNmZ3b1pkNmRIeEhKcUdta085WWhmRTI5ZDViSTF2Wk12?=
 =?utf-8?B?SlkyQS90VklvL0QzYzdwMXdMRlZhc0tZZ3NaQk1iWXUrR2Y2aEkvUDFMNGJ5?=
 =?utf-8?B?aFhrOWZQN1QwVlpGa05sdlhLd1BqUCtGWVovWHRlNDUzNHd5TEFYaGhSRVJs?=
 =?utf-8?Q?kNw73ikKRvllinjmsCMUaUuad8xky/tt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUFsend5N1ovTHIwcytBWlZYdXZBUE4vSUREVm0zbmJ4QzEyemg5cVZpNzU3?=
 =?utf-8?B?Q2JObzBsQ0YvTFRnR09mTHgzZ2FMQ3ZJZ2ZocHY5dzkyUEhRT2tOZHh2WVp3?=
 =?utf-8?B?UnBZejByWlRMMndBTzNsSTZlSTFrKzFzMXlGQ3drc1M0cHZYODMxVXdLOWd6?=
 =?utf-8?B?d3BnU1hUYjJocmE2Y1p1b0JBYnNNdGZ5eW5rMWhDRW92L3dHT3dFeEgxTytF?=
 =?utf-8?B?ckZDaTRxKzJQL3gveWpONzQxS2xhU29tTkl6dENWNnpNa1dUNHR4dmpEc3p4?=
 =?utf-8?B?RGRMS3crSVpsRUMxWGxzUldCOVM1SUJlT0xiSi9vSnE0cGtWU2JsYTN4M3NV?=
 =?utf-8?B?R1hSUjZSdW1TbkxCbU0xN2ttc0RZQVM3aExBSlA1cmdCY3pLSUdwVU9hbUxk?=
 =?utf-8?B?c09aYkpBSXE4eHJPTzhTN2pUSCtXTy9vVGhWejNPZWpFMW9oZUhnSCtXQVlD?=
 =?utf-8?B?YnBIN0w0UFNMRGlnOXJHWlFjWDN1b1VZWHIvN29qOGZYZ2FpTWpVeGpxVzdy?=
 =?utf-8?B?TUNqNHhLM09kUUNjTGlOV2wrTmxRWXlJSnN3dXhrbGxDVkdSNmM0Z2JadDZp?=
 =?utf-8?B?aDRLWm10US9xbFFtdGVrUkdURTRkSEJhWThSWkVnd0Uza1RWT1J4NURmOFJh?=
 =?utf-8?B?aU5heVdaVElMK2ExdGdoN21qVWZoMGxoOE9DOS9rczBnQ1Q5Z1pyNXFnekJs?=
 =?utf-8?B?cjRWSitVY1AydlcvemJKdGduMTRGMFRoMmRnVVJPbkM3NUJOa2hQVGhZaUZL?=
 =?utf-8?B?NHY5RVFtb1dPRnluRFd6TFBqamZPK0dNeGhaajh0UDNOeXFmVnBQZ3Fwa0lj?=
 =?utf-8?B?TWZRMVNyQ0VSU2xuYjlGcEtXaThvVWVJRzhJU0VpQk5lRTNIdDFkLzZUWWda?=
 =?utf-8?B?MkxvSnBVdHBYdlpMNlVDK2RJdG5vc3JmL3pvRUlFNytxbm5kNTJoeVUvaWRj?=
 =?utf-8?B?QkY4YVFqYUVWQlhIczF2VnBqNWM4TlNRWGM0ZWJ5aitxQnNZb2RRRTRzekpp?=
 =?utf-8?B?UllFSGZ3MTRTM2hxRnYwZVMzL3Y1K2RLdFRIalRaQlgvdk9WVWUxbUpoQkxV?=
 =?utf-8?B?cndSSzJ3UlAxQ0V5dDU5eHRIdW9VOWtDem10bnpsU0JDaUdVTnIxZDF3T3dZ?=
 =?utf-8?B?aUdHN2lvVXlBNFcrK0Jwb2hQTm5EZURSWUZIbWFib2tGaSsrMnd0Z0twVWJq?=
 =?utf-8?B?T1pNdFNqVklXYTRHemdJNmtUMklwSy93aXIwbU1SVDE3cWxOL3M0SVZJZ01o?=
 =?utf-8?B?NW91S3QzQTdmb3pxd1JRZ0NKSDNzN0NvdUE2MEpLam5jeFJoUzluVE9sb2JO?=
 =?utf-8?B?WnY1b2FlM3BNbGRhZjhyaWhVbmwwbkVoVUE4WDd6WUZEL0Nzem9OeWw5SXM0?=
 =?utf-8?B?a0tyVGQxNnhOcS92ZVZ6WU04RlphNmgzcWF5OUc3SHBQUlQxQ3FObEJNbzVR?=
 =?utf-8?B?elphYlNjUDl2NEV4SnczY0p1TDFvZ2R1U2l3bnBQdmNnMm9rMXpxNjJJSnBr?=
 =?utf-8?B?STlMRlVBdDJBOE0rRE0wWUFOWG9nR2NaUVZFQWpnb2Y4NFdXVmtBKzk5UDRO?=
 =?utf-8?B?aVFuenZ5ZEx0ZnlQMXVNeFFudzBQaG5NOXZsRXBtNWtyNW5zY3VNTTNwUE51?=
 =?utf-8?B?RUNaVVhVb0VYb2ZSZTQ3RVBJM0JIN25UU2U2b0gzZy9ZOGJYZmpEd3dVdTZk?=
 =?utf-8?B?UHFPTTFDd1lZYTUrck41aUFhcDN5QUFvVVNzRkxqUmQwTnJnQ2M5YlBHVERE?=
 =?utf-8?B?Q1hYL0VnTkZIaTYybXo5WTZ5VmQwcUN3b05tV3FHUE92QVFUNnIzM1MvVHRQ?=
 =?utf-8?B?VW5kZ2NKbC9oQUNsZGxsYzZLdGV0NVJ2dVdzRjJxRk5RTDIvWjhVMU9BaVpN?=
 =?utf-8?B?SGpBaDNxMmIxL0h5OTdYbUFTZ1NjT0FiazQwQ0NiT3JDNjlpSG1HTysrSDhX?=
 =?utf-8?B?eXN0QXJOM244YmxHOGt0ckpMK0gyR21peThoQWNoM05abXA5WHl3SXBOQVZ6?=
 =?utf-8?B?UFJlSlVBc3huc0RWWUZmMWVTd1pESlZNV0gxUE93SUlEREFNU0MwNCtya1dX?=
 =?utf-8?B?ZENqV253YlNiWjIrMGFjSFlVVTdjL2hqb2lpd3J3QkkvemNSZUM5aDJldm03?=
 =?utf-8?Q?Vk8tCo6fa/aK/dNnWhcSjyQRo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb86e7c-900e-4348-db9d-08de21410b81
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:40:38.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhvG0+xiDPARdlz9jCAeaS7X2+FvdpX1HVE34Gb4ISj5XqJzZ6LZqdqqBUWODrgn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

On 11 Nov 2025, at 2:31, Lorenzo Stoakes wrote:

> On Mon, Nov 10, 2025 at 10:56:33PM -0500, Zi Yan wrote:
>> On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:
>>
>>> The kernel maintains leaf page table entries which contain either:
>>>
>>> - Nothing ('none' entries)
>>> - Present entries (that is stuff the hardware can navigate without faul=
t)
>>> - Everything else that will cause a fault which the kernel handles
>>>
>>> In the 'everything else' group we include swap entries, but we also inc=
lude
>>> a number of other things such as migration entries, device private entr=
ies
>>> and marker entries.
>>>
>>> Unfortunately this 'everything else' group expresses everything through
>>> a swp_entry_t type, and these entries are referred to swap entries even
>>> though they may well not contain a... swap entry.
>>>
>>> This is compounded by the rather mind-boggling concept of a non-swap sw=
ap
>>> entry (checked via non_swap_entry()) and the means by which we twist an=
d
>>> turn to satisfy this.
>>>
>>> This patch lays the foundation for reducing this confusion.
>>>
>>> We refer to 'everything else' as a 'software-define leaf entry' or
>>> 'softleaf'. for short And in fact we scoop up the 'none' entries into t=
his
>>> concept also so we are left with:
>>>
>>> - Present entries.
>>> - Softleaf entries (which may be empty).
>>>
>>> This allows for radical simplification across the board - one can simpl=
y
>>> convert any leaf page table entry to a leaf entry via softleaf_from_pte=
().
>>>
>>> If the entry is present, we return an empty leaf entry, so it is assume=
d
>>> the caller is aware that they must differentiate between the two catego=
ries
>>> of page table entries, checking for the former via pte_present().
>>>
>>> As a result, we can eliminate a number of places where we would otherwi=
se
>>> need to use predicates to see if we can proceed with leaf page table en=
try
>>> conversion and instead just go ahead and do it unconditionally.
>>>
>>> We do so where we can, adjusting surrounding logic as necessary to
>>> integrate the new softleaf_t logic as far as seems reasonable at this
>>> stage.
>>>
>>> We typedef swp_entry_t to softleaf_t for the time being until the
>>> conversion can be complete, meaning everything remains compatible
>>> regardless of which type is used. We will eventually remove swp_entry_t
>>> when the conversion is complete.
>>>
>>> We introduce a new header file to keep things clear - leafops.h - this
>>> imports swapops.h so can direct replace swapops imports without issue, =
and
>>> we do so in all the files that require it.
>>>
>>> Additionally, add new leafops.h file to core mm maintainers entry.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>  MAINTAINERS                   |   1 +
>>>  fs/proc/task_mmu.c            |  26 +--
>>>  fs/userfaultfd.c              |   6 +-
>>>  include/linux/leafops.h       | 387 ++++++++++++++++++++++++++++++++++
>>>  include/linux/mm_inline.h     |   6 +-
>>>  include/linux/mm_types.h      |  25 +++
>>>  include/linux/swapops.h       |  28 ---
>>>  include/linux/userfaultfd_k.h |  51 +----
>>>  mm/hmm.c                      |   2 +-
>>>  mm/hugetlb.c                  |  37 ++--
>>>  mm/madvise.c                  |  16 +-
>>>  mm/memory.c                   |  41 ++--
>>>  mm/mincore.c                  |   6 +-
>>>  mm/mprotect.c                 |   6 +-
>>>  mm/mremap.c                   |   4 +-
>>>  mm/page_vma_mapped.c          |  11 +-
>>>  mm/shmem.c                    |   7 +-
>>>  mm/userfaultfd.c              |   6 +-
>>>  18 files changed, 502 insertions(+), 164 deletions(-)
>>>  create mode 100644 include/linux/leafops.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 2628431dcdfe..314910a70bbf 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -16257,6 +16257,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kerne=
l/git/akpm/mm
>>>  F:	include/linux/gfp.h
>>>  F:	include/linux/gfp_types.h
>>>  F:	include/linux/highmem.h
>>> +F:	include/linux/leafops.h
>>>  F:	include/linux/memory.h
>>>  F:	include/linux/mm.h
>>>  F:	include/linux/mm_*.h
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index fc35a0543f01..24d26b49d870 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -14,7 +14,7 @@
>>>  #include <linux/rmap.h>
>>>  #include <linux/swap.h>
>>>  #include <linux/sched/mm.h>
>>> -#include <linux/swapops.h>
>>> +#include <linux/leafops.h>
>>>  #include <linux/mmu_notifier.h>
>>>  #include <linux/page_idle.h>
>>>  #include <linux/shmem_fs.h>
>>> @@ -1230,11 +1230,11 @@ static int smaps_hugetlb_range(pte_t *pte, unsi=
gned long hmask,
>>>  	if (pte_present(ptent)) {
>>>  		folio =3D page_folio(pte_page(ptent));
>>>  		present =3D true;
>>> -	} else if (is_swap_pte(ptent)) {
>>> -		swp_entry_t swpent =3D pte_to_swp_entry(ptent);
>>> +	} else {
>>> +		const softleaf_t entry =3D softleaf_from_pte(ptent);
>>>
>>> -		if (is_pfn_swap_entry(swpent))
>>> -			folio =3D pfn_swap_entry_folio(swpent);
>>> +		if (softleaf_has_pfn(entry))
>>> +			folio =3D softleaf_to_folio(entry);
>>>  	}
>>>
>>>  	if (folio) {
>>
>> <snip>
>>
>>>
>>> @@ -2330,18 +2330,18 @@ static unsigned long pagemap_page_category(stru=
ct pagemap_scan_private *p,
>>>  		if (pte_soft_dirty(pte))
>>>  			categories |=3D PAGE_IS_SOFT_DIRTY;
>>>  	} else if (is_swap_pte(pte)) {
>>
>> This should be just =E2=80=9Celse=E2=80=9D like smaps_hugetlb_range()=E2=
=80=99s change, right?
>
> This is code this patch doesn't touch? :) It's not my fault...
>
> Actually in a follow-up patch I do exactly this, taking advantage of the =
fact
> that we handle none entries automatically in softleaf_from_pte().
>
> But it's onne step at a time here to make it easier to review/life easier=
 on
> bisect in case there's any mistakes.

OK.

>
>>
>>> -		swp_entry_t swp;
>>> +		softleaf_t entry;
>>>
>>>  		categories |=3D PAGE_IS_SWAPPED;
>>>  		if (!pte_swp_uffd_wp_any(pte))
>>>  			categories |=3D PAGE_IS_WRITTEN;
>>>
>>> -		swp =3D pte_to_swp_entry(pte);
>>> -		if (is_guard_swp_entry(swp))
>>> +		entry =3D softleaf_from_pte(pte);
>>> +		if (softleaf_is_guard_marker(entry))
>>>  			categories |=3D PAGE_IS_GUARD;
>>>  		else if ((p->masks_of_interest & PAGE_IS_FILE) &&
>>> -			 is_pfn_swap_entry(swp) &&
>>> -			 !folio_test_anon(pfn_swap_entry_folio(swp)))
>>> +			 softleaf_has_pfn(entry) &&
>>> +			 !folio_test_anon(softleaf_to_folio(entry)))
>>>  			categories |=3D PAGE_IS_FILE;
>>>
>>>  		if (pte_swp_soft_dirty(pte))
>>
>> <snip>
>>
>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>> index 137ce27ff68c..be20468fb5a9 100644
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -3,7 +3,7 @@
>>>  #include <linux/rmap.h>
>>>  #include <linux/hugetlb.h>
>>>  #include <linux/swap.h>
>>> -#include <linux/swapops.h>
>>> +#include <linux/leafops.h>
>>>
>>>  #include "internal.h"
>>>
>>> @@ -107,15 +107,12 @@ static bool check_pte(struct page_vma_mapped_walk=
 *pvmw, unsigned long pte_nr)
>>>  	pte_t ptent =3D ptep_get(pvmw->pte);
>>>
>>>  	if (pvmw->flags & PVMW_MIGRATION) {
>>> -		swp_entry_t entry;
>>> -		if (!is_swap_pte(ptent))
>>> -			return false;
>>> -		entry =3D pte_to_swp_entry(ptent);
>>> +		const softleaf_t entry =3D softleaf_from_pte(ptent);
>>
>> We do not need is_swap_pte() check here because softleaf_from_pte()
>> does the check. Just trying to reason the code with myself here.
>
> Right, see the next patch :) I'm laying the groundwork for us to be able =
to do
> that.
>
>>
>>>
>>> -		if (!is_migration_entry(entry))
>>> +		if (!softleaf_is_migration(entry))
>>>  			return false;
>>>
>>> -		pfn =3D swp_offset_pfn(entry);
>>> +		pfn =3D softleaf_to_pfn(entry);
>>>  	} else if (is_swap_pte(ptent)) {
>>>  		swp_entry_t entry;
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 6580f3cd24bb..395ca58ac4a5 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -66,7 +66,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
>>>  #include <linux/falloc.h>
>>>  #include <linux/splice.h>
>>>  #include <linux/security.h>
>>> -#include <linux/swapops.h>
>>> +#include <linux/leafops.h>
>>>  #include <linux/mempolicy.h>
>>>  #include <linux/namei.h>
>>>  #include <linux/ctype.h>
>>> @@ -2286,7 +2286,8 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
>>>  	struct address_space *mapping =3D inode->i_mapping;
>>>  	struct mm_struct *fault_mm =3D vma ? vma->vm_mm : NULL;
>>>  	struct shmem_inode_info *info =3D SHMEM_I(inode);
>>> -	swp_entry_t swap, index_entry;
>>> +	swp_entry_t swap;
>>> +	softleaf_t index_entry;
>>>  	struct swap_info_struct *si;
>>>  	struct folio *folio =3D NULL;
>>>  	bool skip_swapcache =3D false;
>>> @@ -2298,7 +2299,7 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
>>>  	swap =3D index_entry;
>>>  	*foliop =3D NULL;
>>>
>>> -	if (is_poisoned_swp_entry(index_entry))
>>> +	if (softleaf_is_poison_marker(index_entry))
>>>  		return -EIO;
>>>
>>>  	si =3D get_swap_device(index_entry);
>>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>>> index cc4ce205bbec..055ec1050776 100644
>>> --- a/mm/userfaultfd.c
>>> +++ b/mm/userfaultfd.c
>>> @@ -10,7 +10,7 @@
>>>  #include <linux/pagemap.h>
>>>  #include <linux/rmap.h>
>>>  #include <linux/swap.h>
>>> -#include <linux/swapops.h>
>>> +#include <linux/leafops.h>
>>>  #include <linux/userfaultfd_k.h>
>>>  #include <linux/mmu_notifier.h>
>>>  #include <linux/hugetlb.h>
>>> @@ -208,7 +208,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
>>>  	 * MISSING|WP registered, we firstly wr-protect a none pte which has =
no
>>>  	 * page cache page backing it, then access the page.
>>>  	 */
>>> -	if (!pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
>>> +	if (!pte_none(dst_ptep) && !pte_is_uffd_marker(dst_ptep))
>>>  		goto out_unlock;
>>>
>>>  	if (page_in_cache) {
>>> @@ -590,7 +590,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb=
(
>>>  		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
>>>  			const pte_t ptep =3D huge_ptep_get(dst_mm, dst_addr, dst_pte);
>>>
>>> -			if (!huge_pte_none(ptep) && !is_uffd_pte_marker(ptep)) {
>>> +			if (!huge_pte_none(ptep) && !pte_is_uffd_marker(ptep)) {
>>>  				err =3D -EEXIST;
>>>  				hugetlb_vma_unlock_read(dst_vma);
>>>  				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>>
>> The rest of the code looks good to me. I will check it again once
>> you fix the commit log and comments. Thank you for working on this.
>
> As I said before I'm not respinning this entire series to change every si=
ngle
> reference to present/none to include one or several paragraphs about how =
we
> hacked in protnone and other such things.

No, I do not want you to do that.

>
> If I have to respin the series, I'll add a reference in the commit log.
>
> I beleive the only pertinent comment is:
>
> + * If referencing another page table or a data page then the page table =
entry is
> + * pertinent to hardware - that is it tells the hardware how to decode t=
he page
> + * table entry.

I would just remove =E2=80=9C(that is stuff the hardware can navigate witho=
ut fault)=E2=80=9D.
People can look at the definition of present entries to get the categorizat=
ion.
Basically, you just need to only talk about present entries without mention=
ing
whether it is HW accessible or not, since that is another can of worms.

>
> From the softleaf_t kdoc.
>
> I think this is fine as-is - protnone entries or _PAGE_PSE-only PMD entri=
es
> _are_ pertinent to the hardware fault handler, literally every bit except=
 for
> the present bit are set ready for the hardware to decode, telling it how =
to
> decode the leaf entry.

After reading it again, I agree the kdoc looks good.

>
> Rather than adding additional confusion by citing this stuff and probably
> whatever awful architecture-specific stuff lurks in the arch/ directory I=
 think
> we are fine as-is.
>
> Again we decided as a community to hack this stuff in so we as a communit=
y have
> to live with it like a guy who puts a chimney on his car :)
>
> (mm has many such chimneys on a car that only Homer Simpson would be prou=
d of)

Yeah, it is not pretty, but that is how people get their work done. ;)

Anyway, feel free to add Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

