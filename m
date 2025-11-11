Return-Path: <linux-fsdevel+bounces-67791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C89CEC4B5FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 04:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D10D34D75B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 03:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F293336EEB;
	Tue, 11 Nov 2025 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s9X+SP2s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4E30F54C;
	Tue, 11 Nov 2025 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833411; cv=fail; b=JEnsaXr/ZJfrpYEA11vXZp7CNqG4PCY3ndAent2X5EmQcnb4FxPh6NtjRr8b8Klh72bfPl789bSLt4MS5AjEmd2Eu1zbW1vDIwRqFAT0cVh/FV2Hqi92RfWJCDUxOZ8jIDW9NQeByawhqy575qpIvJ4oMTnj34j4eRTbaSBPsN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833411; c=relaxed/simple;
	bh=gSgQ+UFORcZjfvGXyicyIJCxEIdy4vaCI0JlQJCraQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzznwyjHwrSiQTyfyLsEBaZIWrou8NQLCSrohSRQFiYUu+Py0cZJOtI/1Q/Ec/8TAJfMkdFQfkKncfPzQhP0xoePL4GEdJpbU0HJeQdaigikC4tNWX77+Oid6aKgPxS3uwT/YcSe0rQwzXIDgIv35MGzmWZc/N7YELVd13mmjkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s9X+SP2s; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kx5/wixIbMUqR5O+Bzih/vKH7lh7Pq1mM8PeX9a3MSjPkMt7fVx7WxUeRPkLDRfigI4MPL++LYu90IrSJ6/HLFNMymyHaNzdel6JQmlFgu69skvDDJrIa565g7ClouHKNQ0l571SElY3zUzPMntBnaz2OMLTADlOEOv/yUNwaxMD7+dYYcSNHAlI5P60P/9FBgEirgRhuB/QxVghW9dL5Bp5tm0ZIgrBOOTf2f9tIFwZM5/0Hp0vSg7l2dBqe3np8goSQNW1pt46qe6J6/48nAfvua2fJSiL0CRfGQT98dWDvObvrIgZJxvbNxqciy1mwXfedZBlA4Wz40JyLZANLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+kyRgL6SdEgv6d9QfuL5eg5M5ia9nKXLFxqvecF2zs=;
 b=WiXphH/nud5C8Nczqk4ozhf0+0ZJzy7pbrbC9iX4vUlUhpwFXTRlbjbgHHfAJ02T3MRyj7feYicaCyTclEHyU3M+APpStTdm2lqSEUku0mFW0WOoXvE32Wn7SEXoOqV+srWwKfy7kF9gutQXEegVVnmIaWcQQOm37mdLSPigSktWFXlAj0E25EY5jtjNbmaqZugOGtwIx8ucr8qiWWCDTcsvMx3YbaoCuYEUvLh6P/VCDsQbIBLXp38H6evoK+rTBS4ainnPkNwUzWa4xBiNpvy96gnumaeZBtP/gIroRDUBl5l56KlnllXoEKb1Urj4w6eR62WhxLmHHe+vA2hxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+kyRgL6SdEgv6d9QfuL5eg5M5ia9nKXLFxqvecF2zs=;
 b=s9X+SP2seyp1TkLMdd/DySnJTC6oCXqQCg7sJ0uCGYgf1b80wjarzieo/h8NTJMWXqcoD+9m/QMGfrr+sKmO4ZrgELmPk6DwQvvq9XNe5MljlXuWN5vFeup8vptqOG9OmsGdqEicSbkRX/nCia4jr+S6sYiwhItK6aO6/lgkhgCyWgc3VOO826ZnhjbvhCA16fmEsXBKca+18a9rILwIUR4GrE7czNft0OF4PH4TtksQ9uGKJ+wwLlzk6d4zn/8T9FOMcMmQLXEmUpohyN5cDZNsmkw4hfFenfyH+xNCxp4z75FfCxJxn2ELaEZnpER9BBB8bUUdWwug5u2wz0JAcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 03:56:45 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 03:56:45 +0000
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
Date: Mon, 10 Nov 2025 22:56:33 -0500
X-Mailer: MailMate (2.0r6283)
Message-ID: <3E8190A4-5B17-4A36-9025-F7E4FF1127AB@nvidia.com>
In-Reply-To: <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0425.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: decdf91d-506f-44c4-0772-08de20d654ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlRxYnN0a1E3MHdid1lKbUoraFZjRkZobXVHMTF5V05OTXdSVnVMUk82YnJK?=
 =?utf-8?B?RHJhYnNweUtXQ2RrTWdzak12b2liUzhpY2Z6YmQ1RWFDQnRrc2ZvTDFIeERk?=
 =?utf-8?B?aGswdGdzQ0krOFgvRWdYMnF0VVNaTm1Ib1NzVzBFNTQ1T3NTRjdzb21QcTh0?=
 =?utf-8?B?LzBKSVN6VUFtbXdUTGhPU0hPY0lZY2FUdlRiTnVoU1VhWGtNTWlDN1Bkb2FZ?=
 =?utf-8?B?eHlwNXM2SW9xS2oxQ3BFNmcyOHdnKzF6Y3VKRTdxaFFocXFudXpCeDVBNytU?=
 =?utf-8?B?aURhaHZQekhQSWovcGNwYTZOdEhXYXlVcVpIcjEvd2xkSm5EM3dFb0psUkhp?=
 =?utf-8?B?ZjFaMEYwRjFEbEF3bVkvQlNnRWRaNDBPTzhZeTFFK3M0T0RuSGF4UlpTRUNQ?=
 =?utf-8?B?ZFNxRWlmY0xSUXBuZDY4OGIrWlB4djNKM0lWb21oQVJMb1JPOFZZeVljY1BV?=
 =?utf-8?B?NkwrdnNFUlc4bXRSNmE0M2NUNjJiVjNrU1hHWHl6Z3N2OURjaDR6Z3RBOTNh?=
 =?utf-8?B?bU5SRzd4TXJjZHVaQ3EyWENmUFlyNjZLVG80c2JVakJvZTY3OUFEclpBQ1hL?=
 =?utf-8?B?Z1ZMQ3BYZW01NTYvMDlNVzcyajRsQkN0ZHJmb3JHdkMrWGlCazRIcEF1UmJn?=
 =?utf-8?B?bmNMV3ovZks1OTM1Nnc5dmFqSm83UUttQVFEclZvTUFPN1VxbWJLVE5jV3Bo?=
 =?utf-8?B?bjVhZ08xb2hZZDhOOFQzUENjeElzaXRSa0wzeSt5OWhnZG14eExSb1lURjhK?=
 =?utf-8?B?dzFnejZTVitqVWtXZDMrbTlaVlNyWk1zS1hRU0VnUEV3blcvV0p6aE80R1ZR?=
 =?utf-8?B?cHN2OEpWN0N0aVJWS3V4aW0vUkQ2T3hDeTVKRmQ1Nk1nQWNYUDNEZ2FneE1D?=
 =?utf-8?B?dFdZMzZ3NlNvbVBUQ3Z2eXZ1T0E3U1ovakxJMStqOGgvRXBMSFVQSXJybXYr?=
 =?utf-8?B?NkMvTGJPcElHRkNua3ZhK056TmhPUkF0WWFSQnZMb3dVaFFZVFBYcEcrakoy?=
 =?utf-8?B?UFdEelNYN2ZwL2YyYTN3WnU5d2N5YkdFaEM2TUFUbVpmdjFBYW9UYS9MUXkw?=
 =?utf-8?B?OHROR0R2SnhQZW50YzByUTlYZEtOdCtwR1dKTi9wcG85UWZ4cHhnSlY4N2xX?=
 =?utf-8?B?dmxpR0k0YXM0UXREY3BhdXpQMjdhSjRXeUw2VGFpT29hbmg5Q1R0SlI4ZU04?=
 =?utf-8?B?aFlham1PRTRuWVVXRFBwRzJIY0dYcXFWekZqWk1Wd1pDbWJIR2ZiT3hzQjZE?=
 =?utf-8?B?K0JzZ3k5aXJXbnowUFpxbWViR2JJWFg3cXFKN1VyNGdxZStIVWovTlFZeThS?=
 =?utf-8?B?UVVSRU11bE1WbE9rbXllWmRIRXpxdlhZenB5dlEySTViRURDNTBmRGZnd0g3?=
 =?utf-8?B?dGZMOVNOWXdGMlBzdUdjQ0tPRFdlQkRXMzM0SE5aeEZlY3Y4NjlmTUo5MVpG?=
 =?utf-8?B?RGhVYVZpVjhnbitKZUs0VkRWdC9BVllEbnJ5MG0rTTN5N0IvL01KUTVhYklW?=
 =?utf-8?B?R2FLb3ByNlRRazh6azRQNGFmM0JaUlEwSk5xS3M4OElzSkE0Y09JWnlCYkFW?=
 =?utf-8?B?d0NMTUw0Q2ZaTTQ3c0poeTU2VHM4Y1UvQUxoSkI3ZDNpOVI2aUtpMk9qTkI2?=
 =?utf-8?B?U2JRVWwwcVpiS3NqWUNvV3krSFozN2JvK0VYMys2UjdqaENVbDBUMTNEWTdV?=
 =?utf-8?B?NUtXTXNoUEZyVjVEQnlDc1l2Ri9URnFNUWE2WXhETnBFOGhkcStBcVVYTnNP?=
 =?utf-8?B?bFROaTBMdGcySzVNWnRJTXZ6RUR5SEV4TVhNR0E2VXdSTi9uR0ZwRmV1dTFw?=
 =?utf-8?B?WFVabnlhYW8wOGpPZUh4TFpUSXFGMk4zQWtFR1dwdU1jdFZzZ2t4MndOaHRT?=
 =?utf-8?B?M0Y5eXQwZ1o2Z1dIWG9uem1EN1p1VHVxVC92dGg2YzJZTnZ5c1h3cUhmNTNV?=
 =?utf-8?Q?NTr7JN/nUY4qTP2Y8o7uZ3D8KFZaMAo0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkZoUWhaNnV1TEpVZzRRTnFKZDZtRHRHQ0VRNyt3aElyUmFvalRGampuVzJj?=
 =?utf-8?B?Ym93WTJOQUhWdGEzY2VldXJBb3dnMDk5V21nSllLMVduTlF2R3h3Z2xrTlVv?=
 =?utf-8?B?RWZDYURFOFlIaW1sSU5BdDNSZ0I5bTFYWjdUbGd5YWxJTXVRWXFSMThqNkRT?=
 =?utf-8?B?OHl4eHNPeTBYU2JSdXhhQWJrS3Z6L1NVWnp3RGs0L0k5ZjdqalB0TWtPSkVL?=
 =?utf-8?B?ZU5EWlc2cysxTWJLazVvMCs1WlZSVnpvZTJIQWJYM2RXZ1gvTzl3b0wwTlVF?=
 =?utf-8?B?TityUkZWaWh1OEh2YlU0czR3dFVjelhxTFUzcDVkbU9NRmZLZmgrcXRTUW5L?=
 =?utf-8?B?R25QMVpVQjE4MWF2L2ppUmN1N1FwcUxiTHd3WEZKUE5aZHBpaWEzZHNra3c2?=
 =?utf-8?B?SWxSUWN4Nm1xSW45c05pRzU1ZVFLa3pvaHQ3WFRPS0ZyTjQ0UnpZMUNDVzFK?=
 =?utf-8?B?Ky93OUFnL2Q3Rk5NNHFsRFErSVZJSk13QjVubDhrbVcxRktNRjl4V3BjWmRn?=
 =?utf-8?B?aDZGWXlwL1Z0K1ZlOHRWV0tnam9saTlYWjE1SG9uRGc4K2tvSzllV1YvOTF5?=
 =?utf-8?B?dlhFU0lUSSt5OXhZM0RHckgxeE5aSTB6QkVXKzBVWVJxWGJhNC9mUnJMTFdz?=
 =?utf-8?B?akY3a0V5L2Z3T1hQejg5UkIyb3VxY096QUQ3a2hrR2JKTE9GQlU2eTJrV3NS?=
 =?utf-8?B?UGF0Mzh5azdNQXV1UkJDK1lWOUJxUWJvTTZxMzVMWEJDV0dMYlFHaERIcnpx?=
 =?utf-8?B?aHBwMnpHV0tmN2kzclY0UnJmdUpxSXlmUkFQT2hQM2N3cTMzZnlXTVdaSVN1?=
 =?utf-8?B?NkVsaVNNY1Jjam9iOWxwcVh4QitpbFM0T3V2QVJBS0Q2YmgyWjN0d0JHbUtD?=
 =?utf-8?B?ak5RQ3czYkcybkNtNkZuZnMyVkVhWUZIOS9JV2tPTGhCMmdLTDRrUVBsZjda?=
 =?utf-8?B?NWpzVldJM3RaU3FCUjhDTVl0NkQ4RzZOTzRZRHUyTzIzc2NVdm1sY1djM1Ix?=
 =?utf-8?B?SEc5bmU0TXlOcEJZOU0zeDkzSVpXQVdkWkM2Ry8xeHlKNkpaa2dEdG1taDRH?=
 =?utf-8?B?aEhubFBXR1VkWC9RbEs0S0JXaU9yaGYwMTAralIyQ1lWTjJFOTRVUXh6UG5o?=
 =?utf-8?B?bmZxemU3dVJBYU5OQ1g2VkdrRnJUZEFiOTRIQnBkVU1EZGtlQ0FKZGJZVGpp?=
 =?utf-8?B?VTNzSmpzdUU4NUNGbXJtaC9lbnNLUjBpRDJENVBXd0Z2Qm1DQ3JwQUJ5clo5?=
 =?utf-8?B?VW9YRnZUR24yZW9BNHh4Q3RuLzBDbjNQVjVDeHRJK0ZTb2NPRjMvZXZmbzFU?=
 =?utf-8?B?dXZpZ1hOSTY2Rkswd2tTQldlL21TZTBkOFBSTHV6K05oQUNKMjlmN3dzb1dt?=
 =?utf-8?B?bmc5ZkM1b0kreTZyZFBjQ2x4NWR1dWxRbksrMUNpQ08zalZPQVNFNExvOXgv?=
 =?utf-8?B?dTlLRVlxTEluQU04dXFQSHdPQ3RRVjNwUW5YSkN3djRJb2c0RXBvaW9mbmlZ?=
 =?utf-8?B?Qk1yUm1QZGNEMU9zWFBGZGZvem1EU05ldTZ0c2xBbVhnY0dxQlcyQTNBdGF4?=
 =?utf-8?B?eUw4WFRXb2x2Qk9ZazNVVnFyWW1iaTJ3TzN2S2lqRURpMkc2Wlg2YjNZYnpO?=
 =?utf-8?B?TFJvUGVqeUdCUmFKVXlQTmh0R1VPN0ZxRG92SlpTc1g4RjVVcUh3TVF2MXpO?=
 =?utf-8?B?Y2VVcS9URGlpdFp3RXVjZGdKZmdFbW0ycmwwYlNOY2lPSW9abTVuOXh4czZ6?=
 =?utf-8?B?ZkZyN0NiT0RXa1hDUFVXTWFCcTNiMWhBdENTUi9RWWxPZDZiSjJsRitWMkIv?=
 =?utf-8?B?ZHI2aDJxWENMWVVNcTZkNEcyMzJFck5FSk5UVXo3QTdmUWFkMTY3UFc2cWFD?=
 =?utf-8?B?WFhVVS8vYmtCVVlmWHJ0cGJZcHM0S0Y4cktZelVZQnBkdE1xNDBUQ2tITU5C?=
 =?utf-8?B?bUdwOEtHTE5qd0ZEanlFd3pzM3ppWHNZcS9RTkd6Ri9MVmJhejQxNUF5WEV0?=
 =?utf-8?B?Y0UwRXVuNWErWVNRTyttcm45TklZNHVacVRBeUxuUWg3b1RsT056MGNCbDRq?=
 =?utf-8?B?WHgvMXIwMHBhblNiZmxOUlNNb1lkNUJqU2VWMjZCZlhMSWRBdVI3Z3haQURo?=
 =?utf-8?Q?XIO4NbywNGKobze/9cvUP0rJL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decdf91d-506f-44c4-0772-08de20d654ef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 03:56:45.4417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2kc5bO6WnlpNOwwitXXvNoVCWWX2f6kgKFUmkllRdWItokqGtxMQf03J68hppgz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971

On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:

> The kernel maintains leaf page table entries which contain either:
>
> - Nothing ('none' entries)
> - Present entries (that is stuff the hardware can navigate without fault)
> - Everything else that will cause a fault which the kernel handles
>
> In the 'everything else' group we include swap entries, but we also inclu=
de
> a number of other things such as migration entries, device private entrie=
s
> and marker entries.
>
> Unfortunately this 'everything else' group expresses everything through
> a swp_entry_t type, and these entries are referred to swap entries even
> though they may well not contain a... swap entry.
>
> This is compounded by the rather mind-boggling concept of a non-swap swap
> entry (checked via non_swap_entry()) and the means by which we twist and
> turn to satisfy this.
>
> This patch lays the foundation for reducing this confusion.
>
> We refer to 'everything else' as a 'software-define leaf entry' or
> 'softleaf'. for short And in fact we scoop up the 'none' entries into thi=
s
> concept also so we are left with:
>
> - Present entries.
> - Softleaf entries (which may be empty).
>
> This allows for radical simplification across the board - one can simply
> convert any leaf page table entry to a leaf entry via softleaf_from_pte()=
.
>
> If the entry is present, we return an empty leaf entry, so it is assumed
> the caller is aware that they must differentiate between the two categori=
es
> of page table entries, checking for the former via pte_present().
>
> As a result, we can eliminate a number of places where we would otherwise
> need to use predicates to see if we can proceed with leaf page table entr=
y
> conversion and instead just go ahead and do it unconditionally.
>
> We do so where we can, adjusting surrounding logic as necessary to
> integrate the new softleaf_t logic as far as seems reasonable at this
> stage.
>
> We typedef swp_entry_t to softleaf_t for the time being until the
> conversion can be complete, meaning everything remains compatible
> regardless of which type is used. We will eventually remove swp_entry_t
> when the conversion is complete.
>
> We introduce a new header file to keep things clear - leafops.h - this
> imports swapops.h so can direct replace swapops imports without issue, an=
d
> we do so in all the files that require it.
>
> Additionally, add new leafops.h file to core mm maintainers entry.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS                   |   1 +
>  fs/proc/task_mmu.c            |  26 +--
>  fs/userfaultfd.c              |   6 +-
>  include/linux/leafops.h       | 387 ++++++++++++++++++++++++++++++++++
>  include/linux/mm_inline.h     |   6 +-
>  include/linux/mm_types.h      |  25 +++
>  include/linux/swapops.h       |  28 ---
>  include/linux/userfaultfd_k.h |  51 +----
>  mm/hmm.c                      |   2 +-
>  mm/hugetlb.c                  |  37 ++--
>  mm/madvise.c                  |  16 +-
>  mm/memory.c                   |  41 ++--
>  mm/mincore.c                  |   6 +-
>  mm/mprotect.c                 |   6 +-
>  mm/mremap.c                   |   4 +-
>  mm/page_vma_mapped.c          |  11 +-
>  mm/shmem.c                    |   7 +-
>  mm/userfaultfd.c              |   6 +-
>  18 files changed, 502 insertions(+), 164 deletions(-)
>  create mode 100644 include/linux/leafops.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2628431dcdfe..314910a70bbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16257,6 +16257,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/=
git/akpm/mm
>  F:	include/linux/gfp.h
>  F:	include/linux/gfp_types.h
>  F:	include/linux/highmem.h
> +F:	include/linux/leafops.h
>  F:	include/linux/memory.h
>  F:	include/linux/mm.h
>  F:	include/linux/mm_*.h
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index fc35a0543f01..24d26b49d870 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -14,7 +14,7 @@
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
>  #include <linux/sched/mm.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/page_idle.h>
>  #include <linux/shmem_fs.h>
> @@ -1230,11 +1230,11 @@ static int smaps_hugetlb_range(pte_t *pte, unsign=
ed long hmask,
>  	if (pte_present(ptent)) {
>  		folio =3D page_folio(pte_page(ptent));
>  		present =3D true;
> -	} else if (is_swap_pte(ptent)) {
> -		swp_entry_t swpent =3D pte_to_swp_entry(ptent);
> +	} else {
> +		const softleaf_t entry =3D softleaf_from_pte(ptent);
>
> -		if (is_pfn_swap_entry(swpent))
> -			folio =3D pfn_swap_entry_folio(swpent);
> +		if (softleaf_has_pfn(entry))
> +			folio =3D softleaf_to_folio(entry);
>  	}
>
>  	if (folio) {

<snip>

>
> @@ -2330,18 +2330,18 @@ static unsigned long pagemap_page_category(struct=
 pagemap_scan_private *p,
>  		if (pte_soft_dirty(pte))
>  			categories |=3D PAGE_IS_SOFT_DIRTY;
>  	} else if (is_swap_pte(pte)) {

This should be just =E2=80=9Celse=E2=80=9D like smaps_hugetlb_range()=E2=80=
=99s change, right?

> -		swp_entry_t swp;
> +		softleaf_t entry;
>
>  		categories |=3D PAGE_IS_SWAPPED;
>  		if (!pte_swp_uffd_wp_any(pte))
>  			categories |=3D PAGE_IS_WRITTEN;
>
> -		swp =3D pte_to_swp_entry(pte);
> -		if (is_guard_swp_entry(swp))
> +		entry =3D softleaf_from_pte(pte);
> +		if (softleaf_is_guard_marker(entry))
>  			categories |=3D PAGE_IS_GUARD;
>  		else if ((p->masks_of_interest & PAGE_IS_FILE) &&
> -			 is_pfn_swap_entry(swp) &&
> -			 !folio_test_anon(pfn_swap_entry_folio(swp)))
> +			 softleaf_has_pfn(entry) &&
> +			 !folio_test_anon(softleaf_to_folio(entry)))
>  			categories |=3D PAGE_IS_FILE;
>
>  		if (pte_swp_soft_dirty(pte))

<snip>

> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 137ce27ff68c..be20468fb5a9 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -3,7 +3,7 @@
>  #include <linux/rmap.h>
>  #include <linux/hugetlb.h>
>  #include <linux/swap.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>
>  #include "internal.h"
>
> @@ -107,15 +107,12 @@ static bool check_pte(struct page_vma_mapped_walk *=
pvmw, unsigned long pte_nr)
>  	pte_t ptent =3D ptep_get(pvmw->pte);
>
>  	if (pvmw->flags & PVMW_MIGRATION) {
> -		swp_entry_t entry;
> -		if (!is_swap_pte(ptent))
> -			return false;
> -		entry =3D pte_to_swp_entry(ptent);
> +		const softleaf_t entry =3D softleaf_from_pte(ptent);

We do not need is_swap_pte() check here because softleaf_from_pte()
does the check. Just trying to reason the code with myself here.

>
> -		if (!is_migration_entry(entry))
> +		if (!softleaf_is_migration(entry))
>  			return false;
>
> -		pfn =3D swp_offset_pfn(entry);
> +		pfn =3D softleaf_to_pfn(entry);
>  	} else if (is_swap_pte(ptent)) {
>  		swp_entry_t entry;
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 6580f3cd24bb..395ca58ac4a5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -66,7 +66,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
>  #include <linux/falloc.h>
>  #include <linux/splice.h>
>  #include <linux/security.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>  #include <linux/mempolicy.h>
>  #include <linux/namei.h>
>  #include <linux/ctype.h>
> @@ -2286,7 +2286,8 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>  	struct address_space *mapping =3D inode->i_mapping;
>  	struct mm_struct *fault_mm =3D vma ? vma->vm_mm : NULL;
>  	struct shmem_inode_info *info =3D SHMEM_I(inode);
> -	swp_entry_t swap, index_entry;
> +	swp_entry_t swap;
> +	softleaf_t index_entry;
>  	struct swap_info_struct *si;
>  	struct folio *folio =3D NULL;
>  	bool skip_swapcache =3D false;
> @@ -2298,7 +2299,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>  	swap =3D index_entry;
>  	*foliop =3D NULL;
>
> -	if (is_poisoned_swp_entry(index_entry))
> +	if (softleaf_is_poison_marker(index_entry))
>  		return -EIO;
>
>  	si =3D get_swap_device(index_entry);
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index cc4ce205bbec..055ec1050776 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -10,7 +10,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/hugetlb.h>
> @@ -208,7 +208,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
>  	 * MISSING|WP registered, we firstly wr-protect a none pte which has no
>  	 * page cache page backing it, then access the page.
>  	 */
> -	if (!pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
> +	if (!pte_none(dst_ptep) && !pte_is_uffd_marker(dst_ptep))
>  		goto out_unlock;
>
>  	if (page_in_cache) {
> @@ -590,7 +590,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
>  			const pte_t ptep =3D huge_ptep_get(dst_mm, dst_addr, dst_pte);
>
> -			if (!huge_pte_none(ptep) && !is_uffd_pte_marker(ptep)) {
> +			if (!huge_pte_none(ptep) && !pte_is_uffd_marker(ptep)) {
>  				err =3D -EEXIST;
>  				hugetlb_vma_unlock_read(dst_vma);
>  				mutex_unlock(&hugetlb_fault_mutex_table[hash]);

The rest of the code looks good to me. I will check it again once
you fix the commit log and comments. Thank you for working on this.

Best Regards,
Yan, Zi

