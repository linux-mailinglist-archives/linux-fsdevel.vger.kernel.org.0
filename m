Return-Path: <linux-fsdevel+bounces-52088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFDADF587
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E15217564A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB702F0028;
	Wed, 18 Jun 2025 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qLXL1/09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF83085A0;
	Wed, 18 Jun 2025 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270097; cv=fail; b=fK5J0tRzwgmvCymeI34DjloNcgrBxPYo4Z851vVUsz1x5bUY+5nbSJ62JxqbTID9fuhf9w8dH2fCGI+6rzTXAfIZvh+DMj/IZJbw8Dz+6XawiXI1nVkoJpYZfReseq73GN519giWn9W+BG/Dx+HwTvdgs7rkIDa9i8zOvMOHr4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270097; c=relaxed/simple;
	bh=iUmLelfRR2i9Np9MEu1Qx8JqeC6Kq9R/H2jNcQXc7us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cs4Ro4rQJ0P5/wIEY9m3su+cPBh4TOqFMyfSPOfbhg8kbzXkuuIuhIN23AFriEOrRtVkI3iiatZJVTW9EkcromTxnnvv3KFOXLVF8ltVEo7EMEAZkqVElGE190VpZN4nYQTFI5rwTDNXG5XJlPHQ/hm7KAwr8EIfQf1vjpG1f/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qLXL1/09; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoXL+enpGPQJU4LB4t76KZlTaBV8RouBJQZ25ONEz0proE1o/E3nCgzQaq49mLc59duz7JRIKgADa6/IYjcOo5QvNKIhkMriM+LvOlnwDePSArV238H9CRNlkmuHaYckLuwR+8o5OTWwPit/dud0IfMmLMNFtOl6pO5G2npMUJwuw/Lc1B++Oewmq0Cdy0dAn/A6Drwm1Uf8Tff4QUl7hFlz3mwB3wyIviHUSaViFR9rzi5EOqQ1yAnoQguJZSJaKcMX3A1/RQyUSvWzSPfA9rC53pQ3yPNi0ZYTAy/DR/aYv8zAPu6BTDzX/otua7bzFGVgEZt3l0pnnttlZceccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2HX2ADVf7W1+IF0f5kFmW7ID/AGR0GqPRRXlXRaJ5Q=;
 b=BsksJ3Bzkgw0NWjUG0WJRjVdDF1n9ylorj+F2x9rlch6Ef7DvNnjPrX3hF5WabXxyrO/HFp2x9pfe2yzb+f7rVxqhF5MsyYAh1g3JBhAzm2BKehH0wZCG8AQf03zrc5rcMiDe1xbqxKfx8z8iuvwvLe+OKz8G8c3NBNZ2+4iZGVl3dzd+nMN97+/Mu6dXD5s5R2w8t7Waf94TZT5k3igppZuJW4jb/dxqWN/vBVbh2L1lZho3toNHoTMSRxTbWtIPJggpZqjCgkEr799GyJxweDbIASIyfCkGIR1SmKTeYd6FE4mcs1iucFH1rClcqxqJENrZS+t1DGWoTRsWpMVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2HX2ADVf7W1+IF0f5kFmW7ID/AGR0GqPRRXlXRaJ5Q=;
 b=qLXL1/095WZAMQAFdVQgXRZh+N6uwcn0SSNnGI2EepihH1XRtcWd6pS32BBayL3efxEOUzb9PUCYhCOZK3+D5YEjpYRD55j6HH/UnR/MJG8H5Ivxzu4KJA7xcdkFCNwEejIxEqkK7FqeNagR1xSi9cnIIX1SstG0PSl9v4ZL2a50p9Mhz459kNS5L5a35seA5aISSLfuOMTqg90xOqJt2Fq+3byFXJhjEc9576S0FxwHktJauAG65NoEtoNHSHcVqOgqO5YEK9NaWHNFojIi8t0AfBAw+4e6mpBp9f9G4K6RUeTi6WpJvlpZFV60jKSAsdFz8+/86YTiUkV1Z+dFRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.20; Wed, 18 Jun 2025 18:08:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:08:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-doc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <virtualization@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
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
Date: Wed, 18 Jun 2025 14:08:08 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <D718A3EA-89E2-4AD8-A663-2DDA129600C4@nvidia.com>
In-Reply-To: <D80D504B-20FC-4C2B-98EB-7694E9BAD64C@nvidia.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-5-david@redhat.com>
 <D80D504B-20FC-4C2B-98EB-7694E9BAD64C@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0030.prod.exchangelabs.com
 (2603:10b6:207:18::43) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f9b9ec-a76d-42e3-857a-08ddae9316f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG1JNE51RnFnZmdhOFlHK1k0UzY0QnBOajFQWmM3cUVuODlNUkxOSXBqYzlJ?=
 =?utf-8?B?M0RlSXBYQm1UMGdyd3ByTEE0NUROaG1QTVFrMEd5T1krRUxLQTRHWU9SeGN5?=
 =?utf-8?B?TUNaWStJRXlUUjZlSlBuTCtmbG9ldmZ2cTFiQ01zWXd0MHp5a1YveHN0RXJl?=
 =?utf-8?B?VE1uNkJTSTRKUUdXVDJVMTNnczh6bTVzTFR6ZE1idHBMdWljQlloZmFEd04y?=
 =?utf-8?B?eVU3WjVXMDUzb2FSNzBFZlpXd0s1Y1VSVVF6YW1mK01IUmc4V0lWSnNMTWwv?=
 =?utf-8?B?M0FhSEI3UitPUTc4VHJBNVFKSWNpVUlWMHNrSGduQzZrcnlsTldxTEJ6ckVj?=
 =?utf-8?B?aVh0YUZLb01yS1gxL1JGRDFIdUV4WnVJYVUvd1RsWHVOQ3l0QmxrU0VWZkp1?=
 =?utf-8?B?OXNqLzJXek9GTEp4MkE2NCtKVldXYTFMT2h3UE16WkR6K3pIaUVQWXc5YytX?=
 =?utf-8?B?Z1o2eUhUMFBNa1p0Ri9iNGFKeFExR0gzMldZdFZMYkwxeldCQytRMzVOTVk3?=
 =?utf-8?B?NEFnZ2pTcDJuTVpHQjBHUHV1T2ZNaCtCYU8wenJrZ2xMM1hzaFl2UWRvcUJX?=
 =?utf-8?B?UDdSdnhVMVhyN1NFTisyYXRnTi9GS0QycGg5cFJyYU9LZytSbDFkcTVkSXBi?=
 =?utf-8?B?Y2dIaGNDd2tZRTJRUjlaVGdlem82eEZyaEY2QnFLQ3c0SDdJUE9zL0prNTZB?=
 =?utf-8?B?aSsrV0pmM0NxR3JJMCtVNW42akZoWjFyL0swS3NyM25QUmxXSWVLc25HSDZx?=
 =?utf-8?B?SW5scWxQaXlwbGgyanZBSTFlM3hONFVmdDFKVHdCSXROOGw2Z09FRUEwSGp5?=
 =?utf-8?B?QThJQVYxRVh6ZXR6Ym10YWd5a1U3cG5OVnlBY2Jsb0t6WHc3NnRzckVVY0Rw?=
 =?utf-8?B?eWZxWEJtc2hCaFJEaTh4TXRrTTdBOWJ2STgxS3hmRnhjWnQyVWE0WFREUDFx?=
 =?utf-8?B?cndYbWUzcUNKREM3SXNjaVI2bWtVUDZsTmc2Ym12eXdQZllRYlMxekE1MEpp?=
 =?utf-8?B?d1JCdDBoZU5KUUFHbUw4OWRMQWVNYi9keEwrNDhVR1ZBdndoVmpWRWNtcFpp?=
 =?utf-8?B?LytyLzJDTkpiMC9Scm9zVDAzS1ROMWlTQzRENmVKa3pQRUJYUHUxbzl1WG00?=
 =?utf-8?B?M0Y0VTNQWWZzZGV2T3FKN2wxNm0yazlpV21CTlJrUUZTSmEzbG42d1pLa2RI?=
 =?utf-8?B?c0xXQm9xQmFEVXZuR0p1WFgzUmltZmVlaFpCaHU2VGVrR0JMWGIzRFNRTzJk?=
 =?utf-8?B?MmIvRGplcnVlVzJTNW54Z1lDcHc5bW5aRkI4b1ZsVEFTc1h1cllzL0Y2Y1RX?=
 =?utf-8?B?RWVjc0tEcjJoRzBmQW5Tbnhlc3dzVjF6ZElNNkxPdkxjZk84SXYrUHFURnNQ?=
 =?utf-8?B?cjk4ZC9Cbnc1NWpSaEpWU1JkY0Rzak90TE51bVBGMEhLei9nUjlzWTZ0dyty?=
 =?utf-8?B?L2NzRmRyWmpYRjUzbi9Qa1JJQXROR2dNb0JSYndJeUpuTXRWR0RlM1h3dENO?=
 =?utf-8?B?dWpQZWlmZHRLZ1FyYU9JRk4wa1RkTFdlSUtZRVlmQ1c0SXNhdlVwclpFa1J0?=
 =?utf-8?B?ZjJML1F3V3FxL29yUHFkTlQzQm5PN3VhaUtKa2NCZm1WOVpoZ2VXa2dGWStX?=
 =?utf-8?B?SzVMVzVBUlJHd2RMNXNId0dZL1pTRCtEdjIxazQ3aThnQkJmSkVpeEpVQzAw?=
 =?utf-8?B?czliL012Y1RGa0U0Y1VWUmgrbDlzOEhCazFaME1OVUNvNHE1RXloQnNyZnpE?=
 =?utf-8?B?N20xb05JOXpWTVVFMDFvV0JxMW1tSGY3bGxkNHJkcUQ4Ky9WRzhhREdPalli?=
 =?utf-8?B?WU82WExmdTBQTU8ySHJlb0xEdlNVUzgyKy8vK216UFJIZFBXU2xDVVdGa3Iv?=
 =?utf-8?B?U3JUTjFDdk1oeElETUM1VTdPV1FDQTZ2eWd0VTZwdCswSkdldVU5WStVSzlC?=
 =?utf-8?Q?R3zaZQikg3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VERvby95QXZJZnhXbDhPQTJxSmlWSGwrK2JURVM0YWtHQ3VSWHZSRkNSdXo0?=
 =?utf-8?B?Z2NwRVQzQlBBSSt6ZGRNeURGdVAwWXEyY2R3RHBYbE1tanVoaHY1UnZIcC9a?=
 =?utf-8?B?QTBpMHhkMEdrNURSUFgweXVsVDRqL0F3UVphaXpLalZ3SW4wYWZKbU9mOVd5?=
 =?utf-8?B?MitaLy9rZkZjaVdQeGViM21FUHBSYzdSR0MyNmtPQmduSklpalFRYW1Ebklt?=
 =?utf-8?B?eXR2VTA5TWx0L0tGQXZlYytaNDhmZ3BKQVQvVEY1eFlBZ05KT2RUTjlxK2xp?=
 =?utf-8?B?dUZ5MnIxcU1jOXorazkwTWRZZlg1Z1pCN0hwdkkyQlRjbUQ4eVhjTlJjcHhv?=
 =?utf-8?B?S1FYTUtCY3Y0MVM2dnFlRFNYOHk3MDRva1VRYlRyd2Z0MWF2Wk1uMEtSaURF?=
 =?utf-8?B?S09aRTdORnMxWjlKYURFL1hBbnQwc2dPWFRUUXU4V3ZkYWVubjJyVk9JMTZC?=
 =?utf-8?B?NFVqNEFscy8rL2pLK0dEQndWUUlsVk96c01hbkxJaFR0Mk1RS3FWaVdGbWdR?=
 =?utf-8?B?OTZnZTlpQkpoYW1VZDFDSExTWlgwQ1hBMWdoc0sxbVdKekhSbnkvaVo1Zytn?=
 =?utf-8?B?ek5jSVhMM0dueXROaUJYam9EbkxvOSsrNkZSSHNzbEVYSU5JZGJDOHVVZVk5?=
 =?utf-8?B?cEhTWHhDT1VaTndvL0lYNlFOV0Q4TTZJWlZ4bm1wS3NFZlB2czJxRmZ2bzE1?=
 =?utf-8?B?L3Z0RWU3RS9rbURPeGlBTWlhVXJ3bWp4NUFjcFFXWGpldlpwOVRmb3FJaVl6?=
 =?utf-8?B?SlZtbjlqRzBVN1ppMi85d0ZLZTFyeG5UZzJhcG1NS29BSVN3Qkh0VmN4aGJD?=
 =?utf-8?B?aURic0IyakFCcVcwVHZkYXREVEcvYWJzUUgzRGV6VGhjM0ZQbUcwSm9wNVAy?=
 =?utf-8?B?Q2ZUSzg4T2NnbVUzb2FyRnFsYlhSdGRONXpSWjNValVGd1pGVWhHeDBLcExJ?=
 =?utf-8?B?djkzalV6U1F2SWZOMk92ek1mVTF0N08xWUVzd0Vnd1V0eUhUQ0xXWFBoWVd6?=
 =?utf-8?B?VmEwVi80UmhjMWpxSVB6Tk1ZYmdhQVIxMlhmTko0Uk5MSVozYzRHVDBCbERk?=
 =?utf-8?B?OFRPaUh6R3N2d2NhMlczQ2d3eWpiMTFkamw0bnJGLytXbzlETnNBc29vVDFJ?=
 =?utf-8?B?d1M2UmJHbEFPR0tQbjdHYi9KMjQrWWdXNnh6cEFCL3h1THlCak5tNTFnVzFt?=
 =?utf-8?B?a0JveHRmbXV2WHlFbUt3dm1QekUzVlErYUoxL1JYbERnUGdycEYrckZQVVFJ?=
 =?utf-8?B?WHVDcmpodzdHdFhTazV0ek9CZVFwK011alY3M01RWmRCYzM5VDR2SFhXRlVS?=
 =?utf-8?B?cXlicXdGc3NSVFowVE96eDBsQ2F1ZVRYYWxNam0ra0kzQ1YvOGFaZWZ6eTYw?=
 =?utf-8?B?em4wNk9Lek9DNTc4U2o0L2QzR3lvNkw4L2lUc0FrSzJnMDV6V240dVpOMExU?=
 =?utf-8?B?bXVXbHhWZFdST29QSmpQbi8yV0FPZHpNcXY1eUhaVTM0K1VoZ0l1clVyU1Nn?=
 =?utf-8?B?U3NTRm0wME45QW9JOFBzdHAzOTYrMTVMWkx5ajQvUGtXem10TUJmRmdtcE1W?=
 =?utf-8?B?dXpXQktUTXc3c0Q3SWJRblBaWTRNdUFyYkpOaCtuUHVTdFBRQ3pQYWZrNGVB?=
 =?utf-8?B?OXJpeHVSaVJoQ05oaHpUdWt2eU4rWFF6YlZuQVc3dWYrMmJpcU9ZM1hVSXBE?=
 =?utf-8?B?Z3lxTWgvWlVhQzFWTHZLOVBUWEdKdlpmWEo4c2xKZnNucko0L0dSQllpNmdB?=
 =?utf-8?B?MlZwbFVaeHlGZjNoVHMzYTRZazVXRkV4MC9MVEQzQnhqWmVWRXpYZ3RyRGxw?=
 =?utf-8?B?Q1RrdkZzeFJuYlhqb2J1Y1BhMTFOSC8zVmRhT2RKU2lYQVdCYTk0VTB2WDNH?=
 =?utf-8?B?S2dIYVA1Rm9vQ0VpVnBwc3YyS0p3RnY5RGVvbTBKc1VneEF1WkFoQ1FpNUg3?=
 =?utf-8?B?UDJhN2kvSUdueWpZdm9ka2Rzd0doZzZqVkhwS3BRZjVnRmhhY1RuaHdIZ3M0?=
 =?utf-8?B?K0tGUk05SUJ1NVBNSXpDTFgrYllScUpjWE1jeWtWVTVQTFZ0LzNYc28rbm53?=
 =?utf-8?B?RGdURkNOMWl0VmZVd1JjajRyMUM4Mm1ZeU5xM21URnhoRkNmMXhVaXhBWnhT?=
 =?utf-8?Q?NSkZvvA0YRcrerf+V1z4/NN0+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f9b9ec-a76d-42e3-857a-08ddae9316f5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:08:12.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phnzapDP832jRIBfM/9PV/fP87B7iivTAWZdk9iHAQwaN1s2borQ1XXMF6giW91u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101

On 18 Jun 2025, at 14:04, Zi Yan wrote:

> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>
>> Let's allow for not clearing a page type before freeing a page to the
>> buddy.
>>
>> We'll focus on having a type set on the first page of a larger
>> allocation only.
>>
>> With this change, we can reliably identify typed folios even though
>> they might be in the process of getting freed, which will come in handy
>> in migration code (at least in the transition phase).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/page_alloc.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 858bc17653af9..44e56d31cfeb1 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
>>  			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>  		page->mapping = NULL;
>>  	}
>> +	if (unlikely(page_has_type(page)))
>> +		page->page_type = UINT_MAX;
>> +
>>  	if (is_check_pages_enabled()) {
>>  		if (free_page_is_bad(page))
>>  			bad++;
>> -- 
>> 2.49.0
>
> How does this preserve page type? Isn’t page->page_type = UINT_MAX clearing
> page_type?

OK, next patch explains it. free_pages_prepare() clears page_type,
so that caller does not need to.

I think the message is better to be

mm/page_alloc: clear page_type at page free time

page_type is no longer needed to be cleared before a page is freed, as
page free code does that.

With this change, we can reliably identify typed folios even though
they might be in the process of getting freed, which will come in handy
in migration code (at least in the transition phase).

Best Regards,
Yan, Zi

