Return-Path: <linux-fsdevel+bounces-52618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A660AE489B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FB4171C98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799827A13D;
	Mon, 23 Jun 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HMWOGbX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDFE23AE7C;
	Mon, 23 Jun 2025 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692531; cv=fail; b=mI5EUelSvvq2zlhmrpaOvuXFhfpd59Cb2nhdbblZM6SGEn+ogaXKPTMgQEoZ8zBFKCNtJF6wyQuN0A9enBvsBF9pfp4M21pDUCg7z3iGsfrBEOwVjYezme0XfdFOWsVNzTVqjlZje9MSHz6y4SmmZuKLSGS0Hixp91eVbGGZWrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692531; c=relaxed/simple;
	bh=uEfw8Tq0vJvCW/kV5Zh4Rp+AmJsZsvc0koTJ5UQHUKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iacc4DFlrK0J/BO9bW1sGis+RT3QDn7cqwhmbjYjFOL/wGTUNtZge9D1JgmNWltbsEU8gh+Tu9XZfpMc29mMbDusNAW0mUMvmB+VsByT/Cxu2Sr2B6LNo5QtROSU+lJp/0KJ2I5rOUj074oZMEHn2FuhageaEPSwe9uAjFx1ZxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HMWOGbX6; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftq9zB2ak4pJPh3AIGNc4ej4Gca8Uqw50PpPwLhOmgQ5Jke9AuAZk9ru04vR8RimXuDALMS5R2R7jHkisdhU6a5SzeNWgZ+4CeS0Yiaw2ZSoWxf6rbSrAJn8NoROvA18NkA1FNUEuyzy+1M9E6ck5ZwVW2M2eO8qoGos+9MqbZjqPoNv/yznGpu34X2UcA0Fy/dcq5vQjgcaVFJW0YY4e2yP5jAUaPM5oWgsFWEutbSXMPWSbNX96x+5vlos+5UTZGQ9mJLjSs4zdKEk2uDyvJCw13MDI27EZddtBqltiFZt926woB4rgJ6IeGMw4JMNP8StiOWMf5NvHS7ccAIdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLC8yZIhWT/DsOh1w4OAQQvWviWot0/V99fI72FULwg=;
 b=hreoIoCW7Hadgmb3Ihw+3cg23sT9f+yXcVWLieK1UftN8cv1o+B7ZjrgUs1cGtrMnySjtNjfE/yrGUaOgGMN61VYjqRLnKVFUGAatURoYKjQ/pO76XS6NscDQknbTQ+gSwMnE0riWjrUDnDnlNUTwcNJG2RbJrUepPCgDMnpcvX2536eJRw4uyIzSGIMcBnGmH7xmTe6VtN1jnSsPinmPOd3sM388STwe2Dhz0a0pZ5X/eQmgh0JQcDIlqXijolTlnG9iId5h1Rwz4xaZ3ziVV7wI7dVWt8gjZOtCMH35CxKh5/cQqfwm2ZH32LVCwxr6RIwkTk7Dxfg8Ky6KkmfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLC8yZIhWT/DsOh1w4OAQQvWviWot0/V99fI72FULwg=;
 b=HMWOGbX67OZNpfKtH1ZZgfhfEjykXirjo4DJDZqz0I8sD67LdD0AkIUXgETQfNH1AhI7XG/IDEKPhqi2xqxNox5qyqyMZlH3xC7NnkLQpjSwhAkXB/ig9LzCfLTV5HBzdpeKgQHsJFjzaE24XPkq9v5r0TIqFDQTu88o9OIb2VC7+Wmw5ZfyOCK67FVpF/6eYA+7UpkdZkOSOiwFn1sN73XFJpF+WJSdEa09xlHdrfUkpm9/3e4iwdYi+xQrEqlylz4KbwhKoBNX8yYx53vfoGmHsAVIXvY/puJCEiKFyXYieS+Am3vJOFCeczhmwbSl6fH/97rLMycBpHRM5oo3eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 23 Jun
 2025 15:28:43 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 15:28:42 +0000
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
Date: Mon, 23 Jun 2025 11:28:38 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <9FD54B0C-FCC1-4657-8EBD-7EA81D8D2BC6@nvidia.com>
In-Reply-To: <18ef9192-168f-4d07-a29a-952f2ce3a4f0@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-5-david@redhat.com>
 <D80D504B-20FC-4C2B-98EB-7694E9BAD64C@nvidia.com>
 <D718A3EA-89E2-4AD8-A663-2DDA129600C4@nvidia.com>
 <18ef9192-168f-4d07-a29a-952f2ce3a4f0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:408:d4::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7d0373-8ca0-4bce-6fb3-08ddb26aa2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0Noc0Exdkxqb0dQeHFFMXZkRFVGTFgySnFScXZQd0pyYXY2Y09hN2NCc05K?=
 =?utf-8?B?azhDR2V6bExMa0UyaVVqS1pWSS9ockRucDY0RENtUUc4NElXb1AvM1Q1MGdU?=
 =?utf-8?B?WXZxZUVuTEY4NStCVnFDeEVzVS90NHFSWVQrbUZIZ0YxYjFOTnJlMlpKU3R0?=
 =?utf-8?B?VGRtUjBDcVQzS1diS3lNdmc1M2lCNzB6dkwwV0FiSTMxU0RMbHVLR1pQdkd5?=
 =?utf-8?B?VHY3N2xGaThrd3BCYk9qSm5DZW4reHpvcktLUUNnaEpFWklKeFc4ZlBPVDJk?=
 =?utf-8?B?bDJoaWIwVmZZNVlqTmp0OEJtUG1rTGJWbjNHR3BLbGdrWWlWV2k1T1FDclJK?=
 =?utf-8?B?Q1NTS2ZMN3BnQjEwRnBtR3ZXV2hBYnpnQjcrOTJpbWdCZVdycENJZUorWkhN?=
 =?utf-8?B?ZC9RZ3RrNmp2RHUwVDkyNHA2MmtibnJzbTYxNTFhRWMxV1F0cEhMN0cyMW1s?=
 =?utf-8?B?MmVNd1VneTlCVmd2dUJRVHh1SFdqYVRlcXgwcTdGc0liUm1rdWFPNThRU1U5?=
 =?utf-8?B?NHBucmdxWGdPRmZXNlAvQXdTZDRUTXZwbHdGWUI2STlROE1OaFNkeEhYV1VK?=
 =?utf-8?B?MFlSR3RSZWpUcXh1RXUvbUoxRnk5dHM4SW1BNVpkVlNmNEtGWW8xV1lJeWhj?=
 =?utf-8?B?ZXQ2Z3MzTlh0UFZTSnBDZy9hZE5WRlRGRXpmTDIySzZGTkZNaU9HTkJaNlRR?=
 =?utf-8?B?VnNzVVRsYUtveklMVlJpVDFYZGxLbzEveXl5QzdRbFprbERVUm5FMFZDQXVl?=
 =?utf-8?B?OTRpams1bjRnWXNkejJvSDdlaVUrMklxYlo5MVlUUTd4dzQya0NsMGxTVGZm?=
 =?utf-8?B?WlV5SElGdncxVDhtU2NaVGdVcEhJNjBmQi9qMXI5Qmh6L3h6T1RET2JTbjZH?=
 =?utf-8?B?WjZ4WHdSdzF4ZmRpR014azJpRmRiK2IxK0JMVjB5YW5vWTVQTk05RnVscUti?=
 =?utf-8?B?UUN4VXdESEpaZnRtRzIwaVIzMVp1dnBKUFJMZkIxY3RSRjlsZ2lyYjIrbmdY?=
 =?utf-8?B?bGhiTjJySVZxQlBYY2oxR3FoeU9BTDlYelYrMlFTV0pINERFSWNlVEhwRjVG?=
 =?utf-8?B?NXQ3RytDNW8yRGlmZzNaN0ZaTTlWUk1WWEJ3Rnp5b2ZxN3JwT1lXMEs4Qmp6?=
 =?utf-8?B?V3pYM2hNQ1RXYkY5K2MzekkzcEFQSmt2czlRcnJqdW0xSGhwbzZrakw1MGJu?=
 =?utf-8?B?cEVORTF2TnJBT09BNE5CRzRKS3VWZHEvREUwTUJlWEhhK1gxQnlSc2x4OWdU?=
 =?utf-8?B?ZVFLaUkvUlVpdGtUaHpzRkEvY3BMU25sSVlLcjFvQm1jTkpwak45RldtN2xM?=
 =?utf-8?B?R2pIaHVNS2pINlZlWml2aDdDVXVySzFXRFpINzhScHB4dDV5ZzRFcWRna2lG?=
 =?utf-8?B?MTg3Wk0wWlRobEkvd3psakNORW02QVFFVUx0dGJ2RGxZMUlpNWNzbEVzYU91?=
 =?utf-8?B?L0FiMFh6RTFucnB3Tnd0MURjeVR5L2FyVnovWStMSmN1SDVvQ1Q2SGhxdUZu?=
 =?utf-8?B?YTh0UWNiTmZwa0dFRlY3UkpJZHRKUGtESUVhMzJud25wd2dXZlQvd0xKaG9O?=
 =?utf-8?B?SnBaVG5qRlhWRWd4NE4yeVk4MTFJTmNyTTE5L1lZVlhFNmZod0c4Q1ZOcTVS?=
 =?utf-8?B?T2JBMitJT05JMlo5QzA5eTNINVl0Qzk4a0ZkdzRuOC81dTZtOU0yc0NiRlY3?=
 =?utf-8?B?Q3NhcDNmSnQ0cmVNaHM0eDgyaVNzbDU3U1BLT2EyUGFzeWlZYjVnUml0M29T?=
 =?utf-8?B?YWlMbmo3MkFtd1ZtWVVFTXJ2S0lQQVByMnp2eEJabzNiM2RldllhY2kxVmVt?=
 =?utf-8?B?OUhyQ0lhWFhEKzJUWExBL0xZTzUydGlXOUJsdGFDTVdrV05WVHVlQnNITEZr?=
 =?utf-8?B?NXN4NkI3TW1hMjNPSnovaEYycjJCUjhrYVRGbXhMUzdhc0psbkJ4a1N0c1Bn?=
 =?utf-8?Q?kN53V+vBkTk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2JnQXVGY3ljTkt5U1hUWFlLUEpzUDJ6VmFiVzR0VFBTYTJsY3RzYnF5YUk4?=
 =?utf-8?B?M21JWGJoZVlTbCtSdU5yZGlsZDNwdmRWWHZsMGZXOTdRUVZpQk0vTDFlMW9V?=
 =?utf-8?B?L0N3WjJObGwyWThtcGYzZUFiR3RhUWRzOWw3Wm9rSWQxVEhxR3RFeUdPeGFF?=
 =?utf-8?B?MFk5b2M3U2VMWHVOZkF4bE94Z2ZhMmZNWm14ZFpxR2w4OWg0OWJWZUxKREwr?=
 =?utf-8?B?eG1kZURnalVIYS9LMHpDaVBXN2xQNUV5eFdNVFVtVVlhb3hWK0t2dFA2UHY0?=
 =?utf-8?B?Qk1nOFR1NGJYNURzUS9BajlBenN5YUdlVDVuWlIyeldTVmswa083aXlGQU5Q?=
 =?utf-8?B?MkNnUU5EYTJ2V3JsNTI4Z2paSDRHYURIOHl5SERsMEtrQ2wzR0JrYlovcjRv?=
 =?utf-8?B?cTRGWW1WRU04SWUzVklsbzRyQzlBMGhXVUU2SHhnQUZ3bWhFVDVQZG53SHMx?=
 =?utf-8?B?MTJpaVdRZXJtZ0dDRGRvbmoxYkdzNHFUN2NyNVU3S3VUUUtTeGZyM0xxRU80?=
 =?utf-8?B?NmkxSGZoM1gzR1JYaVVtSFNScVdaQUxEcEN2VDh5UEFQbmR1MlFFRDAxa2dh?=
 =?utf-8?B?Wm1iRlN1SXJOSGlha1A1dkJMU1hvZDZ4VHNyd2JzVFdoaVB4NlBaemJSdy9O?=
 =?utf-8?B?SEpja1pkRTlDaFNKakZvRm1HTkthY3lnZkl5Ym1OTGZtcFRZazBZbWJHSSta?=
 =?utf-8?B?V1kzRy9nQ000TEpBcnFtZTlzR01tMlNNbVlaR0xTT0ZJT1RBSXlYOUJwbU5s?=
 =?utf-8?B?d2FSa1hUUWFuT3dyeUs5ZHdXU2JHTDRxLzFEZ1JKS0h5S2xlQzhqVFBZSkYv?=
 =?utf-8?B?a0xxZHBWWGpBSi9LemhGckpMdGIvTUY5Sm5MWS9RdVgrNDYwL0VvRXo0azhX?=
 =?utf-8?B?UFRSWUV2UTVRMUxxRnRMaUI1M3pqelJ3NXpqLytMNHFTQ21sTzBrN3E1NTJL?=
 =?utf-8?B?SmxiZi90MFRJQVRLbjJDNStJRWRGVGw1MWUyWllibmVqa3g1RUlwU0lza2V5?=
 =?utf-8?B?VTVIWTY4MHI0WGp1Z2VjOGxoa3NPUFZCakwycmRtMVJVZ2FwQ2VzTlRqRHJ0?=
 =?utf-8?B?cWU4Y2hwWjd5R0pWY2lVZU8xS3RmQnJWb1hTcmJJMEVzdlQ1TG5EWUVBV1Bs?=
 =?utf-8?B?RERKRmZxYncxcFdDL25qNUc4TlhHU0k4ak5DQ0RESU5VQ0Y3NTl4dWZrRHJB?=
 =?utf-8?B?RDBQUFdIS2F5clpYUHl5cDlkaVRDRkZZaHhZQ2lDQ0RXNFNTbzV2SkZ0ZmM3?=
 =?utf-8?B?bVF6YmlId2x3cEtDV3ByeUwxa1dkKzMvYWxadlZUU3RPeFFDLzA3ZFpIWVZL?=
 =?utf-8?B?cGRpeDVqOGtwWnMrRGNPRzBUWkk3NG1udFNFa3p3NndhaThIT2JqMnhzb1ls?=
 =?utf-8?B?QUlQVTJ5Uml3OTkyZmFKYjZIaFFYSUxlaFhsb2dmQjhxZ243NS90WjNlcno4?=
 =?utf-8?B?M0FwUjRvMjZwR3ZZOWpka3BpQ2QxVlRjRXpHemdtSGVZMVBBdGxDSmN0akpR?=
 =?utf-8?B?UmZoWnJwbGYwTlNsM09ESUpCMnIrQTVMYUhFSi9tVUw0WEtwUENNdzNjWlMx?=
 =?utf-8?B?ZTJ1YzQ1VURRb0JyTjIzQUdzSUVLYWNCb0xIVW4xOWtlQi9wb1I1NjFGaHZm?=
 =?utf-8?B?dzdLc0IvelFTQzA4UTgxaTNOR2pQa01jYS9TdGlmRlRuSEM1OUozbDBHaGpp?=
 =?utf-8?B?S0hWNzFpYTlRUzZHd01rakMrb2ZjVDhncnBSenErbVhDZnVPLzVqZVljaHZr?=
 =?utf-8?B?dTFhZ1p5WmVtc2VlZytQKzdxclJjZkZ4dCsxdkRCS2s0cTY0aG9oNVBoeWpp?=
 =?utf-8?B?cktSVkxDVUZuQitaakluTStGbTA1WVBEblpFd1B0QTZ5dHJUVTBvUHZsdFQz?=
 =?utf-8?B?bDFTWUFPY2MvYSs2V3gyVldWOUw4ck1qdXd3eEVDT24xSzZSVXNrZ1BFRW9V?=
 =?utf-8?B?NHJ4WmxiejlNaVlBR1RraFo4RW1LenVqdFFJY3Z4ZFF6TFE3L3pySlNvQzNm?=
 =?utf-8?B?UzB6WnREQnQ2TE9mZlhRY3ZpVHNnd1d1bU5ERS8xZDlFdEdXdkM2aEFzUS9k?=
 =?utf-8?B?TnFFNUhkUDJtMGtjc29USjJqWXpEY1FJUEZWSlNaL1l6MGVEcFdwNU1IR2R6?=
 =?utf-8?Q?q3xXtrhMZ/CYbpABTgRS53Su1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7d0373-8ca0-4bce-6fb3-08ddb26aa2c5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:28:42.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fh/lucU7bibvHaz88M4T8dBpyEYdKiBpXI0HX69JBFInjK+x/9h46zr6T5LXGMjK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

On 23 Jun 2025, at 11:26, David Hildenbrand wrote:

> On 18.06.25 20:08, Zi Yan wrote:
>> On 18 Jun 2025, at 14:04, Zi Yan wrote:
>>
>>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>>>
>>>> Let's allow for not clearing a page type before freeing a page to the
>>>> buddy.
>>>>
>>>> We'll focus on having a type set on the first page of a larger
>>>> allocation only.
>>>>
>>>> With this change, we can reliably identify typed folios even though
>>>> they might be in the process of getting freed, which will come in handy
>>>> in migration code (at least in the transition phase).
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>   mm/page_alloc.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 858bc17653af9..44e56d31cfeb1 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
>>>>   			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>>>   		page->mapping = NULL;
>>>>   	}
>>>> +	if (unlikely(page_has_type(page)))
>>>> +		page->page_type = UINT_MAX;
>>>> +
>>>>   	if (is_check_pages_enabled()) {
>>>>   		if (free_page_is_bad(page))
>>>>   			bad++;
>>>> -- 
>>>> 2.49.0
>>>
>>> How does this preserve page type? Isn’t page->page_type = UINT_MAX clearing
>>> page_type?
>>
>> OK, next patch explains it. free_pages_prepare() clears page_type,
>> so that caller does not need to.
>>
>> I think the message is better to be
>>
>> mm/page_alloc: clear page_type at page free time
>>
>> page_type is no longer needed to be cleared before a page is freed, as
>> page free code does that.
>>
>> With this change, we can reliably identify typed folios even though
>> they might be in the process of getting freed, which will come in handy
>> in migration code (at least in the transition phase).
>
>
> I'll change it to
>
>     mm/page_alloc: let page freeing clear any set page type
>         Currently, any user of page types must clear that type before freeing
>     a page back to the buddy, otherwise we'll run into mapcount related
>     sanity checks (because the page type currently overlays the page
>     mapcount).
>         Let's allow for not clearing the page type by page type users by letting
>     the buddy handle it instead.
>         We'll focus on having a page type set on the first page of a larger
>     allocation only.
>         With this change, we can reliably identify typed folios even though
>     they might be in the process of getting freed, which will come in handy
>     in migration code (at least in the transition phase).

Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

