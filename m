Return-Path: <linux-fsdevel+bounces-61213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F74B563A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 00:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6186189EEFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 22:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644802C0F69;
	Sat, 13 Sep 2025 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Gql53gkd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07C281358;
	Sat, 13 Sep 2025 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757804064; cv=fail; b=IzkEfrhk7z0u8a46p56+M7tI9tp68/bDJoBRBH3MZNGXl6n0e7SPlq2h9EvXOx0wbXGcD8XaOHwAWKiRN4u0URdmAVDzuAYEJ/u/M4U9lyINX1vLtZMqcvdZkqABB7UGOEghf8dEoSWQJntypZ5DHp8JJj2Ah4TLF8+2xefPajc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757804064; c=relaxed/simple;
	bh=YMMJjsyEJGSSIUfJNieWtptCinDcCkY3GCVu9fuGeCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QU1Khmh6BTVjf79gJqR9nZWI7OoILXBuKpPD2Dtn1ymjxrLrggeNuDoyps4/D+vzOwFX0hhl+e0r53rC0PNIHWTyGuH+TD9uVedaZNe1QHXT6j8ReubCDEnc7Sh2Zyy/U7RCgpW7OykcIXMJ0LkkaBa6lbE/A5EOc1yTR32OFAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Gql53gkd; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58DBcQh3594061;
	Sat, 13 Sep 2025 15:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=WBXh5K7MfqSSFZpHwUDTB7Snp/Nh2sXuERH1P9AOVGQ=; b=Gql53gkd/pJE
	7y/U/Mn1oB4gNPdQaw/17k+PBbxg1m5kdeWIRiAf6ak7c8jPK2Sdm2SAEsx4tupt
	gXmbS4X1pEdZONhkauB4O5f0rn7gyFl9dDbfbrEzkYEy5FJME+xm7g9e55jMdAUT
	X9137MDHZRwGdp07pogXObO1ePbvUcH/Zypd7zWAuN6Mdo9Wk4VbldJYagRO+SeO
	IRrUDNuYrstIlj0Z0sUICFFW+dfjHxlA6ZPEhp235FtieYZVcj0cd4veFUSPD2a2
	5mc6i2LWZhV7FAPPQJKwb78mkcr9qETYu0VYf0KjzijXL5XnKTxzArCF122It8mU
	RaWurjyu9g==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4957wphx0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Sep 2025 15:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYkIRdjKmijSl7/J5yhBW+Bsq/lUG7vinKUXqUBPkE61SL7hKKOFf1X0Sp8Ed/B/wSernpGknnSJq4OwhK1ctH/FCqsrU+uRlfZ9I7eO9Y8nzgeLj6S5kYNcXz9lMnI1VvCAt+siXIPgixMtqxx/RcYAVkJ7xxwfpAI1lEV9Jxr4OU6OX19IDc8sLfbUWn+59jnvEBrgMtUgU3w7VTTGJqI/uSjfs3rr0CG/KNq3+m4s9XktUmIOux3+P+fCzcWVkHWq0/N6hXjsDKV6VAuxVpDA+RE10vsQSLsxJw93pa1oMuv18g4SinaOfdq7jOJ3vUEMSVXbQv8tjxb3CmJROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBXh5K7MfqSSFZpHwUDTB7Snp/Nh2sXuERH1P9AOVGQ=;
 b=cAM/MNjEXuJnBgHB3oPIn1bx0PqoCHck8M2L45puUvfcPHA4gKeO7o60lfLejOxQ9U6LANNRyCVJZMfEaOQGD8L9GlQwbhb8VCiOKhk7V/81JzQOvIjUsueK8RfFAKFlsuVjQVAwBUJGd3HeARGu5vTN9hOTHgrRLXBewMJMKriH6RLszyodvpINxLLP9mbNVY6Q4qlTam20ODE8JJCoNsVoOOCFYDVbulLrllVPPpgdjINN85Mrf4vaZ4Lb9j9rK0X4llMAa3L13ylW0oycfnaU0XLhH3PxA0Op3J4IyUkbb2T3J7+11dSn7lqI4Otw73irSY3BjnICseNdOchBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by PH0PR15MB4479.namprd15.prod.outlook.com (2603:10b6:510:85::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 22:54:19 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9115.018; Sat, 13 Sep 2025
 22:54:18 +0000
Message-ID: <829e914a-5413-4377-aeda-fe56a56dad0a@meta.com>
Date: Sat, 13 Sep 2025 18:54:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:236::17) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|PH0PR15MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: d608a243-fcd5-49af-814c-08ddf31878ab
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE5NR1JjSkt3bmNYMjgxZmpQamZtdjZNRjFoR1FxN0ZHcTNPTlRGb3MzM2Vs?=
 =?utf-8?B?Y3dBWnc5NXNPcVh5YmlaaUxxT3V4Q0NSU1lyRWxKYXZsemRwOGdrbG5TSEs1?=
 =?utf-8?B?ZFp5WGp3d2Y4eGVMd2lxY1pPall4YVY1azkwa05qYjRPMy8vRGJUYVJTYmZz?=
 =?utf-8?B?Q0NTWklyT1V4TG40bWgvOHJJSzVybnlrTWJITXU3VUJ5dC9VVjRtWXFEbmQ0?=
 =?utf-8?B?TUxsSXJONXFSdnpFUDdNZng1ZFRkOFlyaFl6aXVJUXllRFJqY1B2Q1NlRXlS?=
 =?utf-8?B?TXU2R2EyQm9jT3VtM1g3YjNhZERMaGgvODREOW9SeXpYc2lkUk9JeTRndmZD?=
 =?utf-8?B?dm9jcGo2bjBsWVoyeUJwdDFvdGVaSVpwbCt1SkQ5VG11dExKak1ZbjlQU1lG?=
 =?utf-8?B?TUlxTFJFMXZudStGVW9tUndzM041M0VrOFV5YzYwY0xGclphc002VEgvMGdv?=
 =?utf-8?B?V3grQU5jZXRpSG5nSk5lTGNTOUxnM2NNRkRJdHRMU0djMmpXUVpPMzlScXdy?=
 =?utf-8?B?ejhOMytKTnpSbC84YjVhRHBFWTMxZzVKMENUVUVGaHFnd2FHWHJ0ellWUkZp?=
 =?utf-8?B?ZEErMmorNld5ZnIwb3MyU21Lb2xrTUNqOVlrU2J3dVoxdTZ6RnNYZEdsdUJp?=
 =?utf-8?B?WjN3Y3A4emtnSlhLejlsNVM3ZE1qSC9tZkdQcysySG5YaHA4WkI4NThueW45?=
 =?utf-8?B?cjhOTkhza2VNQjRlZi9DazhMdGRaYjR2RndrbGsyenQ5bmVxZVc5alFVVW1Q?=
 =?utf-8?B?Zlc0a3dZYnhuRGxvcWppMnRnOVpwNGhhSzNvdlhQKzdkbGlVQjF0MlA4OWly?=
 =?utf-8?B?N2hvYjFoVGVSQUFGM0hibEpKeHFuNnZkM3F3YUpNMENkMit5Y21ORE1PQUNE?=
 =?utf-8?B?VFY5WnVOUERWbkdLRzBzT0cycFg1Zkhydmg1ZDN4ZHpyYjhwOGJzSlE2RUE3?=
 =?utf-8?B?ekx6N1ZMZWVkcTJLZEdkdzFRWVNjSW9yMjZhNENGWFlQL1YwODVKaHV3ZVRj?=
 =?utf-8?B?WVZDL3BvV1VGL0VDdWdSMDgzc2ZTVzY4a2FLOXRNVnUyNlBVZnhCb3BtaDU5?=
 =?utf-8?B?Y3E0QzhaYkdMT0FIMGo1cis3eFlWOHdSQkFRSldHQzdOT3ZiallhMmJ0UnMy?=
 =?utf-8?B?L1hBeFVTOU1va0J4UEVNNldGUFg0VC9ZVkhEZjlOamhubjZoelQwQlFzdUVU?=
 =?utf-8?B?bU02QjNDdTBZR29DR3l4WlA1bThaNTE2QmszY1M2eldHa0tZdXphWEIvK3BE?=
 =?utf-8?B?NVJJajV3bEVBU1B2MmZLbzZleEZtNlJjVTlVSHZ4M0tPNDJUOVhlTHZXR01N?=
 =?utf-8?B?aHMxL1BBdkRZVEFEczZya1liYk8xbFRtZ2pSSGlJb05yc0lUN3NzeUkwNU4r?=
 =?utf-8?B?TU1VNnJxaVNlbnpjWGZVRlFYdzZKMFcwOVYvQThtOWp5d2RaWW11ZXIzZDhF?=
 =?utf-8?B?WStGQklYSmk4MlF5UHZLZDQ2N1ZTY3hreDZvc3hpWm5EVGw4MmF4dzFxeUtG?=
 =?utf-8?B?ZlFpeDFyUjFrR2ZwRStoYjBSdzh3azdoejg3RnlCcXptTnlLQ0t3OXVaMFli?=
 =?utf-8?B?V0h4R3BNTHdDZTF5dENZY2JXTnJ4WWhsTjBVZmt4V1J4dDVTWS9aZllhUlpu?=
 =?utf-8?B?SWRSK0JiRy91NDBjamY0UHVEUVRRdVQrejdGb2xGS1FZaEM0eTd2WDRRODFF?=
 =?utf-8?B?ZHFkUG1aeTYrUS9VcUFqSEdYRlVpMENRSDQrMnZhTFArRG9BU1RPRVk0SFBF?=
 =?utf-8?B?ellYZHVIMWtkdEpRQTRVQW5Dc1N2WWtrQUdWdXpaOUxvYmdjeFZIOWdiSjlm?=
 =?utf-8?B?TVNvUkR2ZEEweUJLSkxuMGtpZ0ZaRkgvcFN2RHo4Y1BwS1hmY2xFckQwQTlq?=
 =?utf-8?B?Q0FaSWM1U0R4ZWZQRWNGWDZoajV2YTJOM2pybHZQYUVWUVFsMWtJOStZY3Nr?=
 =?utf-8?Q?8K0lIKVE1q8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVpiRG11cytKWStLSUVaVm05S3o5TEhNSUhBaHV6bzNRT1Z5SW9uR2Zab05m?=
 =?utf-8?B?ZlI4TnphMFVPV2tzajlIZjJsTWZVUWN0OS8zSlZYSTVZOUYzcE9vZUZUZVd3?=
 =?utf-8?B?L0FZeXRaZTc5MmRGYUVNK2NWZEMrbkNwYVFXOUQyVmZlSG9DMk5wMndmbmZK?=
 =?utf-8?B?bVRHNFpEcnNMTHdETEF1cXY3ZExHTG1qa2hwQ3FqM2dydVdDbmlaYWltY2Zj?=
 =?utf-8?B?Ky9kbjlFUThOQ2c2amJkenV3UUFJd050YlV2L2EydldjRDF6d0w1SWVWbUFn?=
 =?utf-8?B?R3NSOWM0R1hYajY3YXpoR3kycU9aS1JOOG94WWZ2TEFybkNyWXRXek13YTBC?=
 =?utf-8?B?Q3RVZFIwK2NUSnZBVVdKQnZ4ZU12ZDQvLzhwbmhxdStxZ0k5dmdlS2lBMGlk?=
 =?utf-8?B?UFVWR1EzYXUyZkRZZ0hSVXRkMHVuemJkM00wVzVmcGhQYi9CRzdqbkNocGlh?=
 =?utf-8?B?REpEU1RXS2NjamM1Y0xkOVJ6M2R2MWdzVWZjSUlEa1N6Z2d0REJkL2FXcVdu?=
 =?utf-8?B?MmRmU3VFYVNhQUE4Y2taRStMMXdJd3BlbkZLL01xN1ZQOFlyczczNms5ZEg5?=
 =?utf-8?B?b3kyaTFxMHVNU2wxcjIrTFB4azhhU3F3dUpLMTF2M21vWDJSRU4rL0k5bVBr?=
 =?utf-8?B?SHhIK29LRCt4eHcvOW1Hd3V3eWFhdnZsam1Cc1daU0U2M2ozTkQzbXdzTjNv?=
 =?utf-8?B?VjhORHdRRkE5c21DM3Rlc2NYL2dnaTFlNVY3YTBPblBHOXQvVWdFMEZCcjdU?=
 =?utf-8?B?VHlkRFNEVkI2eEVLcTBDSWc5SUYxS2diTFVMenZMQVd4dnMwYUxvNlcwNnZq?=
 =?utf-8?B?dm9mN3I3aVBGYzUvTW1jVzh5QTdHUmQyY1NtNnZMZGRhQlI5cEVyem90SmNr?=
 =?utf-8?B?YWp3QWpJVEI1amh3TTlFZUdEMVpGOE5GRDExY0EvYmZaTlM0ZVJBQ210U1pa?=
 =?utf-8?B?MHRPNlFrQ2Z4b2tKR29jbHBXZURLUFdRVjQwTkR6ZEUrUUhwTkl1TUE5WHhu?=
 =?utf-8?B?K0FUcHYyUTJYdEVEek9PRHh5aVBheng5Z0NXL0Zpdk5sZmI5THNNVUFleGpi?=
 =?utf-8?B?a0pOQzlzaXJqa0FMYVRQMFhXQ0h3b2pWbmk4ZHVFUGtsVFJ1V0ZsbkRzWEd6?=
 =?utf-8?B?cUdYNmthVmFWNGp0dklJc1FMSUhuWWJIcHRRODhyOFcxYWlIbHpnUGd3SDBq?=
 =?utf-8?B?QnI1VlU2NVR0dGRVeUowODA1WFRHU0FxcmtaU3U0TE0xQTFINCtFVmhFT0ZV?=
 =?utf-8?B?Sms0QzM1N0l5c0d4cEo0dERxODE2UmFZd2RPZzM1SVVTcjFXclBLNXdhOHF6?=
 =?utf-8?B?MU9wT3A3Q2FtRTN5bXY4cmtxNXh4MVVHRFNnNDR2Nzd5dEFKQnpKbHR2enB1?=
 =?utf-8?B?dGFHWDlwazF0cFFqUFRQZXROSTQzanl3Vkg3M051MmJUV3l4VGt0Z2l1a0Va?=
 =?utf-8?B?STZrU0VaanFmWDY3YzhjVjA2ZDhBczJtOCtrSnlDUHRkSkFYTEVGZE53Vzha?=
 =?utf-8?B?Ty9NME1BeXFaazVCSXlEdjJpUmJFTFpwa3J1VnY5MnZwWHMrVy84VnBMYnV3?=
 =?utf-8?B?dUgrOEY4dUN1LzMrbHI1cTE4cVVQcUQyZDRDdUJoWWVLWlpGajNPUE0rS1Vv?=
 =?utf-8?B?V0NkdDR4VzBSUk95dy9iQzN6Y2hrYWtVekVKdnAzQkhrSGtKTnJRMWd3eE9Q?=
 =?utf-8?B?UFJXbW1hSGwxZlJkeWFQSS83clNnZi8yWHlrL2ZMUzZoUW94NjI5N1Zrb1dr?=
 =?utf-8?B?ZS9aZ2ZiZ0V3Q2NmZGJTOTY3SDhFOVdWdytUTWlRb2V3ajlwSjJRUERpNzlt?=
 =?utf-8?B?cUpiV1N5Unc1dWdpVWw1RzI1bWtIaDV5ZzJiSmZtVEFEWnp2RTJZM1pTTEVu?=
 =?utf-8?B?WlZVN0tTUzZ0SUJWcHYrRFpGcWZabHo1ZThYcTN6amljOFVFZWN0OUN6WFZy?=
 =?utf-8?B?QVJVVUpNajZ5RlppamZiTVA2ZEFlbGcvS0o0czlQMGhMT3ZaUU1NQWpIYklx?=
 =?utf-8?B?b01jTFdvczJjUVk2OTlMVGFtVmIrUnE1R1BpNHRnb2J3blA0QU1hQ1AydnBw?=
 =?utf-8?B?dEtlbjZRRGRFbHB1Syt2aDFBMDYrSEFuNm1vdHdjYVoxK3BIc0FMbjlENGtp?=
 =?utf-8?Q?So2TJy+nKY/D39JwBL7ShELxF?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d608a243-fcd5-49af-814c-08ddf31878ab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 22:54:18.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjPn0AodRZ012+o+lVeO09cA9ahccG/ymVPXdzpDrhx0E7lmofdcMBy4LeZqBCIc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4479
X-Proofpoint-ORIG-GUID: h5PrjUulLVyzOGdQptjMNKLObgZan4aG
X-Authority-Analysis: v=2.4 cv=S9vZwJsP c=1 sm=1 tr=0 ts=68c5f61d cx=c_pps
 a=o1VJN3YqdCgxIxsX0dn2eg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8
 a=O-fpaxy3vYAAr3kZirUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: h5PrjUulLVyzOGdQptjMNKLObgZan4aG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDIyMSBTYWx0ZWRfX+F1Ow+NmoWIv
 ToafIM2B4OuGykmLlPeGlK0KkLZIbN/Lilx7EtYfhEFJW1rJSXg8I3s+YK+DJrVIFE2YRtagKUm
 Gi7lVatmd0Zp56fyk0FF6vPwxbBrCpjGehyw93ne0eVFlEa5MQcxIZiF8677LNTeveCGptM5PUF
 8/whPYJcMzhQMYyYEuLaZ9UAgrK7UWUxUzvInA5FIxUGNa4KQbL98Sts3+8cTtk3xrq86bMcsgr
 0rq4/6FJwTOyuJwadGJ33bwRheo95dco95KnKKA87pkXE7cZNRMTAJf5ajjTgVxKFRBjFSCS3ZT
 jWgv+u/jwUWj4SNmKHUiwHwPGx+zHbqTOauFY9Djne6IffhyuYy2fqOGQx4G0c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-13_07,2025-09-12_01,2025-03-28_01

Hi Lorzeno,

On 9/10/25 4:22 PM, Lorenzo Stoakes wrote:
> Some drivers/filesystems need to perform additional tasks after the VMA is
> set up. This is typically in the form of pre-population.
> 
> The forms of pre-population most likely to be performed are a PFN remap or
> insertion of a mixed map, so we provide this functionality, ensuring that
> we perform the appropriate actions at the appropriate time - that is
> setting flags at the point of .mmap_prepare, and performing the actual
> remap at the point at which the VMA is fully established.
> 
> This prevents the driver from doing anything too crazy with a VMA at any
> stage, and we retain complete control over how the mm functionality is
> applied.
> 
> Unfortunately callers still do often require some kind of custom action, so
> we add an optional success/error _hook to allow the caller to do something
> after the action has succeeded or failed.
> 
> This is done at the point when the VMA has already been established, so the
> harm that can be done is limited.
> 
> The error hook can be used to filter errors if necessary.
> 
> We implement actions as abstracted from the vm_area_desc, so we provide the
> ability for custom hooks to invoke actions distinct from the vma
> descriptor.
> 
> If any error arises on these final actions, we simply unmap the VMA
> altogether.
> 
> Also update the stacked filesystem compatibility layer to utilise the
> action behaviour, and update the VMA tests accordingly.
> 
> For drivers which perform truly custom logic, we provide a custom action
> hook which is invoked at the point of action execution.
> 
> This can then, in turn, update the desc object and perform other actions,
> such as partially remapping ranges for instance. We export
> vma_desc_action_prepare() and vma_desc_action_complete() for drivers to do
> this.
> 
> This is performed at a stage where the VMA is already established,
> immediately prior to mapping completion, so it is considerably less
> problematic than a general mmap hook.
> 
> Note that at the point of the action being taken, the VMA is visible via
> the rmap, only the VMA write lock is held, so if anything needs to access
> the VMA, it is able to.
> 
> Essentially the action is taken as if it were performed after the mapping,
> but is kept atomic with VMA state.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm.h               |  30 ++++++
>  include/linux/mm_types.h         |  61 ++++++++++++
>  mm/util.c                        | 150 +++++++++++++++++++++++++++-
>  mm/vma.c                         |  70 ++++++++-----
>  tools/testing/vma/vma_internal.h | 164 ++++++++++++++++++++++++++++++-
>  5 files changed, 447 insertions(+), 28 deletions(-)
> 

[ ... ]

> +/**
> + * mmap_action_complete - Execute VMA descriptor action.
> + * @action: The action to perform.
> + * @vma: The VMA to perform the action upon.
> + *
> + * Similar to mmap_action_prepare(), other than internal mm usage this is
> + * intended for mmap_prepare users who implement a custom hook - with this
> + * function being called from the custom hook itself.
> + *
> + * Return: 0 on success, or error, at which point the VMA will be unmapped.
> + */
> +int mmap_action_complete(struct mmap_action *action,
> +			     struct vm_area_struct *vma)
> +{
> +	int err = 0;
> +
> +	switch (action->type) {
> +	case MMAP_NOTHING:
> +		break;
> +	case MMAP_REMAP_PFN:
> +		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) !=
> +				VM_REMAP_FLAGS);
> +
> +		err = remap_pfn_range_complete(vma, action->remap.addr,
> +				action->remap.pfn, action->remap.size,
> +				action->remap.pgprot);
> +
> +		break;
> +	case MMAP_INSERT_MIXED:
> +	{
> +		unsigned long pgnum = 0;
> +		unsigned long pfn = action->mixedmap.pfn;
> +		unsigned long addr = action->mixedmap.addr;
> +		unsigned long vaddr = vma->vm_start;
> +
> +		VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MIXEDMAP));
> +
> +		for (; pgnum < action->mixedmap.num_pages;
> +		     pgnum++, pfn++, addr += PAGE_SIZE, vaddr += PAGE_SIZE) {
> +			vm_fault_t vmf;
> +
> +			vmf = vmf_insert_mixed(vma, vaddr, addr);
                                                          ^^^^^
Should this be pfn instead of addr?

-chris

