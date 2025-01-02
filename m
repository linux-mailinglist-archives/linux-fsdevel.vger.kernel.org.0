Return-Path: <linux-fsdevel+bounces-38348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 010ED9FFFFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019BA1883E01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A031B6CF3;
	Thu,  2 Jan 2025 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JifuB42v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F33D96A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849579; cv=fail; b=QBsTmF1A5jzhZaOQ/795CpG+tGks9X5qNEvx9kEZKK3zh0FiHyscX01QYBG2LtxNOIqnw0OFI5SGrk2QqE6rAZPLvL1rBmpNa5GPqij+C39XY86NAL/DgniCL2fcqJeeXf8dIPvwuMJxfTE6gnv4KvYUeMDwhHMantFA8guc5Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849579; c=relaxed/simple;
	bh=gZj1s/+R04PwYigrxTSKD2pwU3o8q+BYaImN6gpK9j4=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=ggCQd6h2+V+dPgZ/mg16hC2BKLqwP5HeAMAFDKHXev4P50u3gzx1NdWl7OGOoP5RV2m+nvn0rhhPsSlh9UL5JDLcEsiUNkxg6hgJ6ddPme3ABP5xIpwHKEHQ0YBFq91S9XaQMPeb6StMm2AnM0hjswTJMKQQWEpkSvNsH5TtLc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JifuB42v; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MU3KMK8UVC7PYjuLBoj6a0X+r6CsYxBARVUnfru/TeG8dA0Nkr+xcFvSAEOZmmaKZ+370aWhalRwIHfeBdS3GeJoACFPqT95rpcJAQflseITpzM8G4hewTslpmie9So3n6OfuWYbKWe59e03pTh7QK0pd3Brq2DXmYXo0pNcjOx+8Mub05iwjcVWNLuvQzmVZZm75ayu2n6y+GAsVRmK3vovYoAIKoJYASPVronASfPxukrQIWdtK5zHYwHz1oYcJdlt9PWRWovjhQmeYMKaafjxgW4Qeh45sAoWoqTgDfuKca0h/74hL3UCmszBPM9uvtc/IIuD0qTNz8Go6lTHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjzomMyGGYhX4360JlgcVpELUmRz+6VV2qm205znbjo=;
 b=d+zz0cMdDtjJR+2cpTYRiVBdE+VxsF6lOeyiPn8lUpvfsSyk2zwtVzTWnLb48Gg5n4YFWvKeZZsJH/J8Se6b1FSZ7iCe2jtUGE3u6lAcVI4MhsH7XEHCKBWAlKGlqJX9rHTl+bBiPt0LbKH9u6ufWvNoKeQ9ATTbjdz+BxbnmLoR/ce2amUFIvaCkLgUPjUBb/3mWAE7+aOz1Uf2FANxSwwTtlHw89Lcw5y2gJ5wghbUdPUzDlUQUCDnhwwA1JmXpq9qChMG+JNfPKhNvEZni2iXDA9Rt2b+RQPQi8p2Fq1CmTEHH1XbjH1ZAWFs/XLSigBKy4x9tI6mFMOEe+HmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjzomMyGGYhX4360JlgcVpELUmRz+6VV2qm205znbjo=;
 b=JifuB42vIspYPShZeuCXfVg4Nemc9GRKGhZGAa4Oz65IobCgDoX7aJyIU1V6VYuEqrwCcmEJCqFjoBS3A4IQsdrM5evHpGeMugW50DgSHViwotahqIUABR6pQlmOTyC4KvqVKBeCI6xKLlmYMVCIrfU069PmndPKVrnbcQK//HEF5cqAXXD6mU4Nw9yvPqyNiiex1vGbAefggh53ReJmTk8zjMamJEWwMQhfpta5Us5ulPP4ZEeMhiWputEQwQYcV8JCwuyWmHXl74Yffr6z7KwAuDRyof+GyNrI/g4TkdNWGt5mal4MFtV+vyaHvtJPgVzeP84VLS/VN6rM8fGoug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.12; Thu, 2 Jan 2025 20:26:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 20:26:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jan 2025 15:26:09 -0500
Message-Id: <D6RVBFDFZ177.2XJG7IX6PHJBS@nvidia.com>
Cc: "David Hildenbrand" <david@redhat.com>, "Bernd Schubert"
 <bernd.schubert@fastmail.fm>, <miklos@szeredi.hu>,
 <linux-fsdevel@vger.kernel.org>, <jefflexu@linux.alibaba.com>,
 <josef@toxicpanda.com>, <linux-mm@kvack.org>, <kernel-team@meta.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Oscar Salvador"
 <osalvador@suse.de>, "Michal Hocko" <mhocko@kernel.org>
To: "Joanne Koong" <joannelkoong@gmail.com>, "Shakeel Butt"
 <shakeel.butt@linux.dev>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under
 writeback with AS_WRITEBACK_INDETERMINATE mappings
X-Mailer: aerc 0.18.2
References: <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
 <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <xucuoi4ywape4ftgzgahqqgzk6xhvotzdu67crq37ccmyl53oa@oiq354b6sfu7>
 <CAJnrk1bmjd_yE0LO=Qdff==Zk5neunvUbnsEVYqNPPDsSJUudw@mail.gmail.com>
In-Reply-To: <CAJnrk1bmjd_yE0LO=Qdff==Zk5neunvUbnsEVYqNPPDsSJUudw@mail.gmail.com>
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: d238b9d3-3c24-4601-73d4-08dd2b6bb21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L29nVE5FNWoweEFkejluVjcwNmd6UW9mRTF5SE95YWVWNkYxSERWczhhQkhn?=
 =?utf-8?B?QkRRNExsaXVyTjV2QXc2MVhFMFRuNTBVRS9UcjhBVDdpOXhKZ3VzYXBQK25y?=
 =?utf-8?B?N1UvODkzanBMZXdieWRrY2ZsNmc3dHNGMzlOL1JoN2tONEcxZEJMd3RLQ00y?=
 =?utf-8?B?eWtQeUs3V215dkJkbzdrRFBYRFYzemxQVkhKV0l2ZUJhemZIY0hKdDEvU09m?=
 =?utf-8?B?SWJpcnNvdWcyVFlpRzBldkt3dUFCb0FIWTg1Mjhxbng1bjVRRDRKVUNqek04?=
 =?utf-8?B?UkMxNkRrV2ZTYzFPRXZEQ2RlaEZJaEhadHFBRkhwOEpmcEJxNjhZbEU1NHAx?=
 =?utf-8?B?UWxtN003bU9sWWVqYWM0amRSZmpBVGxRbTMxZHpCbU1DbzRIc01zZ0o4bytz?=
 =?utf-8?B?Y0ROV0dkL2taWHpmNTJIeEdkb0dmVDJIRHEzL2JWT1JDZm1OOURrMzlNZVpZ?=
 =?utf-8?B?ZHZVS2JOZU42U3BEbWhGVnZPRHRrTHMyMzQyTDZ1RXhGcmNqVDJyVm12aE0r?=
 =?utf-8?B?ZEhiZ3RLbityWmZERDJMTUtMMk5TdWpkQ2JIblhGQVhvQnhybTVQbnh1TTIy?=
 =?utf-8?B?b3g1VG5PSHhxcDhtV2VnUlBmNWlkNUk2L3JmdlZKTU53SENjbUJnZXk5dk14?=
 =?utf-8?B?ZWJXL0Q5U0RpU0xlQWFMM0piSlZTTVFCOHJjK1FRejdZRHdrVkFPdnEvdTAw?=
 =?utf-8?B?c3VEa1IzOVUzMGlvaUoxR1lrNkRPTGxELzVyWU15ajVkc2lKMHJpdlVidmF5?=
 =?utf-8?B?SnhvbTRoakVHajZQM3NQZXhTWjczaXB5RWtrc0U2VjhBaHpWUVpBWEVwMmg0?=
 =?utf-8?B?YkZpR1R0Y3dLejN1a2g1Qm0xVGFDUUhrUXZLL1R0WCtUb0hYRklQV2ozSXBv?=
 =?utf-8?B?anFmVGFoVXU4N0dCS1BnL3ZiVi9kQzJIRlYxcDY1V3FKazREWmpYZDVjL1dv?=
 =?utf-8?B?Z0FOMzErVGJkbVUxYUUzMlY3K0pmUVBpUXlVVk5EajV3aXJxM1ErV2xqRkNB?=
 =?utf-8?B?MnJER2VLcWZvQ2x4MWpUb1BLTlFqS1RUMWZaWHZjaTRXbXAxVzZHYmxpbnBn?=
 =?utf-8?B?cUNtUzh2THNwdUlFRFI2aGlJamJ1L1VobjlZY1drazY2MVk3WDhBTDhXczli?=
 =?utf-8?B?WHlDY2dVZnZFQUNUQnJnZmxKRkVIZmhuMnE1Zkp4dDVRRjI5R293WjF2Y3JG?=
 =?utf-8?B?U213WkxjWlBGSWszYlFFb1JJNS9peHB2ZXNYM29ILzJwVkNwb0NuSlEyUHVk?=
 =?utf-8?B?TFlIZWdlbURTUElLOWVHMHNTeVcrS2o4NVVhOGdHMmxrZXVSdTdrWGFPQ2lH?=
 =?utf-8?B?ZjZzNDVkbW4raXdWRkkyNlI4NmhjNG9SYUZrMEVTK1lNb3h4OFdMM1BtcWVt?=
 =?utf-8?B?WFBOajVEbnlLL29kcVVVNVZDY09FYmkzYmg0cXFSZGgrald2bHZBaVhaZ3A2?=
 =?utf-8?B?VlJPQnUvbmF2eWpiaG5ra2t2eVdHL1p5Uzlla21rLzdGQjVpekNFRzhkNE5R?=
 =?utf-8?B?ZG4ydGduWFgvUU9XZ2s4RGg1Y25ocXg3UmNFbVJMcndHYlJpK2NFR29FdFF5?=
 =?utf-8?B?eFp2bEdXOWl6VmVYcXduTHNWQm16aXVwbXplemtWQlQ5UUI1YllhU1JuVCtV?=
 =?utf-8?B?SkRoeU16NDVWS2cyRHNBTndVM29sbWwrYnBHZmtDQWNHSnlOWDhDTHNOTzRS?=
 =?utf-8?B?WkIrb09VYjlKem9qb0FOSUhrOUhEWURISkZDcU45bm5IYVFld3preFZYYnNx?=
 =?utf-8?B?Q3VpTDA1Tk9pOEZwQ3ovc2xWVWRXR2k1TXlRaVNlTHk4Z29YOGxpUkxxWm0v?=
 =?utf-8?B?MGMzUmxzendDQ1ZtM05VMUtlVlBoelFDd2V6RU4xVzYyMEJvdG1jcTJNdjc0?=
 =?utf-8?Q?xEs96EEKoy4m8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG40YkhaNnBiNmM2QzJBSG9iNzJDOWRRTGZjS0Excnh6SEtDQzZQOFplVFQ1?=
 =?utf-8?B?SGRqQVd3NWFraFE0MDdjSUZlVWZqM0NzQS9FazBzQlhTZ2k0N250YVYrcmVB?=
 =?utf-8?B?WlZoLzUyZXZJNnJnYVcwZTdQbHczeXllNFhqT29ENXo2QkVtUXlLOTF3VDZV?=
 =?utf-8?B?N21lQzZVNWJxeHk2VXNMRHJpM1UxMzhQQlM2UXV2a1BOZEtZaHBWdGpFc2hw?=
 =?utf-8?B?U3VNQXZwVTlMck1reEFVbkM2R3hYQStlMHI2TGlIRWpvWTdXRU56V0hqZWR3?=
 =?utf-8?B?TG9QY25QTGNGdTZxQnVtVUxYM2hUQ0pIMFRRMmhUVTZUZ09OZzVDTkwwOGox?=
 =?utf-8?B?R1pmVHplVmY4K0dPS0Y3QllBSTd5YWUwSnhic2EyZlV4MWRiNjZoQjk0dUtt?=
 =?utf-8?B?czAzdit3OU9GSlNHU09tVmwyZVV2akxYbDI1MUxSWW15dHExMVF2UGJNcTA2?=
 =?utf-8?B?L1JNMlBqdFhVWEJWR29OUEx6TzBwVTRpbHRjM05xNFpMQWhvNERFdGlOMTJN?=
 =?utf-8?B?dmE2Vmp0MnBwaEJKUnZFTnZNaDh2Z1llbzU3eDU3anhxa0hjaGlKTEZlN0x4?=
 =?utf-8?B?ZVpVYVpCUTNCd2NNaERPVVFMQmkwNXdSSG8xd3pZR0Z6MExiWjV5V20vTzhu?=
 =?utf-8?B?SWR3NG5HSW9tRzhwUWdxbEcvaGlTT2F4a3BPNXJET1VnWElJYmdkQm41V3VI?=
 =?utf-8?B?UE5HWVZzNE9zSnQ5MFhEbm5ZUzcrVVhZTlhGMDkyUGJDVlJmcUFCSEVQZndO?=
 =?utf-8?B?clRTU0crOVJXVHdvcys4L2xRNnh6SGhmMUxsWUI1NFFIMnU0U20wS0xtelFx?=
 =?utf-8?B?bTc3c2VNZll6dHRqSzdTQlkwOGxmYVFxSmZIeTMyMC9QUElvd0JQMC91WWl1?=
 =?utf-8?B?d3FmajBWU2MrYXpaK2F0Tk1tY0Q0a3RvNTYrTmpBcjgvUDZXUGhTNCtNUnEw?=
 =?utf-8?B?N0NvNUJNVXYwV0x2TFJUWXg1V0habmRLaUZhQnVwaWhtZGhQcnhzU1JFb3hm?=
 =?utf-8?B?QlRQZnhMcXVraTlpTzc3dnpYVkNpZG5XS2F0ZDZ2WVZQZ01EY3pDNDVhVkVZ?=
 =?utf-8?B?anNrR2I3VFRNN2R5b2NjNHhIcGhoaVFBTmxZVDc3bUk0U2IyaUdJODN1elV6?=
 =?utf-8?B?TlJOSkt4WUx0a3ZmME5iWGV5WFpEdndMS1FkZ1U0cHM5NVJBMXNFa1FjMVJC?=
 =?utf-8?B?UHgrL01lQWJZbWhEMXpvbmJwUW5UeHJYYisxUk9xNHFEQ3JsZDRnMlNVTGN1?=
 =?utf-8?B?bmdEcStvK2RPbzl3Z0pSYUtCSnQrUDVMaDkxc1N3OHlLTWxSNXQxUDRPOU9O?=
 =?utf-8?B?UHJlcHRXYkFqdkVFQmdvM1EyWVNHYlFzQjZiUnNDNTZyTjBjaGJEYTdXK3FP?=
 =?utf-8?B?bW5XUDc0bnVqTXh2Tmt0b2RrQ1Z5SjhNemN2N25WMnJ5STYrdTdoQmZBWG9o?=
 =?utf-8?B?OEtWU0lYdWhSZ3BwczlHWXRZc1ZoNEN5dHpTb21sT2ZYbkhicTFuQUducWto?=
 =?utf-8?B?UFk4L1dxQlVRaDBtSjYxemZWMTZyNGN5SU1Wd1FlMTZmNTdqV3JoZE9LaFh1?=
 =?utf-8?B?ei9Uai9iSWhGeWZjaGl1TnNESWR2MTRXeXFzZm5lbTZuNG9QZXQ3Zm5OVUli?=
 =?utf-8?B?UHdNSmdRRzlCQVUvWUdtaHBrQW4veGpGUkFUWCttcVBFNG1ralhhU2FzT3FC?=
 =?utf-8?B?TzBDWDczS3dKemt0MWZqVVlMaWNYS1E4NzdCNFZ1RG5OWmNsYlg0TE0wbU00?=
 =?utf-8?B?am1RZ2xsV2xLNlRKTmkyelp3TkVwd3JYZHVLNW5lcjc5MnF6aFJBbzBxbGc1?=
 =?utf-8?B?c1FmVEpWZm9FUWpLSlZlMHlQQkpiTXdRclQ5d3ZkMkxlcnpDbjBId3h6dnY5?=
 =?utf-8?B?d1FXaUI4Rzk4dW8wbmlHVk1qbThsUXBlVFA0ZURFT0V4a1hmRFVtQ1NDSU1G?=
 =?utf-8?B?Sk9KNmtYN1hJK0toanZ3NTRBWEIwcGVTMlFQeXltU2pSVVYzSmdnaXZETkNu?=
 =?utf-8?B?V1g2WVFNalZTMVc4S2hSaC9NM2EyRWpqMnpKRXY5alNrci94eE8rZ2I4anZL?=
 =?utf-8?B?RXlzd3IydDhrcktlbE54ZzB6Z1BiSnRvQXIySEk1dHFidlc1aHpnd3BOQlNu?=
 =?utf-8?Q?Hp9E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d238b9d3-3c24-4601-73d4-08dd2b6bb21f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 20:26:10.7448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4utPF+KRH5gk5zmDCCpi8qnq3NUE7o58BZwYfeK+YYBCi9T9KBIdz6wF4D2khEHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132

On Thu Jan 2, 2025 at 2:59 PM EST, Joanne Koong wrote:
> On Mon, Dec 30, 2024 at 12:04=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> >
> > On Mon, Dec 30, 2024 at 10:38:16AM -0800, Joanne Koong wrote:
> > > On Mon, Dec 30, 2024 at 2:16=E2=80=AFAM David Hildenbrand <david@redh=
at.com> wrote:
> >
> > Thanks David for the response.
> >
> > > >
> > > > >> BTW, I just looked at NFS out of interest, in particular
> > > > >> nfs_page_async_flush(), and I spot some logic about re-dirtying =
pages +
> > > > >> canceling writeback. IIUC, there are default timeouts for UDP an=
d TCP,
> > > > >> whereby the TCP default one seems to be around 60s (* retrans?),=
 and the
> > > > >> privileged user that mounts it can set higher ones. I guess one =
could run
> > > > >> into similar writeback issues?
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > sorry for the late reply.
> > > >
> > > > > Yes, I think so.
> > > > >
> > > > >>
> > > > >> So I wonder why we never required AS_WRITEBACK_INDETERMINATE for=
 nfs?
> > > > >
> > > > > I feel like INDETERMINATE in the name is the main cause of confus=
ion.
> > > >
> > > > We are adding logic that says "unconditionally, never wait on write=
back
> > > > for these folios, not even any sync migration". That's the main pro=
blem
> > > > I have.
> > > >
> > > > Your explanation below is helpful. Because ...
> > > >
> > > > > So, let me explain why it is required (but later I will tell you =
how it
> > > > > can be avoided). The FUSE thread which is actively handling write=
back of
> > > > > a given folio can cause memory allocation either through syscall =
or page
> > > > > fault. That memory allocation can trigger global reclaim synchron=
ously
> > > > > and in cgroup-v1, that FUSE thread can wait on the writeback on t=
he same
> > > > > folio whose writeback it is supposed to end and cauing a deadlock=
. So,
> > > > > AS_WRITEBACK_INDETERMINATE is used to just avoid this deadlock.
> > > >  > > The in-kernel fs avoid this situation through the use of GFP_N=
OFS
> > > > > allocations. The userspace fs can also use a similar approach whi=
ch is
> > > > > prctl(PR_SET_IO_FLUSHER, 1) to avoid this situation. However I ha=
ve been
> > > > > told that it is hard to use as it is per-thread flag and has to b=
e set
> > > > > for all the threads handling writeback which can be error prone i=
f the
> > > > > threadpool is dynamic. Second it is very coarse such that all the
> > > > > allocations from those threads (e.g. page faults) become NOFS whi=
ch
> > > > > makes userspace very unreliable on highly utilized machine as NOF=
S can
> > > > > not reclaim potentially a lot of memory and can not trigger oom-k=
ill.
> > > > >
> > > >
> > > > ... now I understand that we want to prevent a deadlock in one spec=
ific
> > > > scenario only?
> > > >
> > > > What sounds plausible for me is:
> > > >
> > > > a) Make this only affect the actual deadlock path: sync migration
> > > >     during compaction. Communicate it either using some "context"
> > > >     information or with a new MIGRATE_SYNC_COMPACTION.
> > > > b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to expr=
ess
> > > >      that very deadlock problem.
> > > > c) Leave all others sync migration users alone for now
> > >
> > > The deadlock path is separate from sync migration. The deadlock arise=
s
> > > from a corner case where cgroupv1 reclaim waits on a folio under
> > > writeback where that writeback itself is blocked on reclaim.
> > >
> >
> > Joanne, let's drop the patch to migrate.c completely and let's rename
> > the flag to something like what David is suggesting and only handle in
> > the reclaim path.
> >
> > > >
> > > > Would that prevent the deadlock? Even *better* would be to to be ab=
le to
> > > > ask the fs if starting writeback on a specific folio could deadlock=
.
> > > > Because in most cases, as I understand, we'll  not actually run int=
o the
> > > > deadlock and would just want to wait for writeback to just complete
> > > > (esp. compaction).
> > > >
> > > > (I still think having folios under writeback for a long time might =
be a
> > > > problem, but that's indeed something to sort out separately in the
> > > > future, because I suspect NFS has similar issues. We'd want to "wai=
t
> > > > with timeout" and e.g., cancel writeback during memory
> > > > offlining/alloc_cma ...)
> >
> > Thanks David and yes let's handle the folios under writeback issue
> > separately.
> >
> > >
> > > I'm looking back at some of the discussions in v2 [1] and I'm still
> > > not clear on how memory fragmentation for non-movable pages differs
> > > from memory fragmentation from movable pages and whether one is worse
> > > than the other.
> >
> > I think the fragmentation due to movable pages becoming unmovable is
> > worse as that situation is unexpected and the kernel can waste a lot of
> > CPU to defrag the block containing those folios. For non-movable blocks=
,
> > the kernel will not even try to defrag. Now we can have a situation
> > where almost all memory is backed by non-movable blocks and higher orde=
r
> > allocations start failing even when there is enough free memory. For
> > such situations either system needs to be restarted (or workloads
> > restarted if they are cause of high non-movable memory) or the admin
> > needs to setup ZONE_MOVABLE where non-movable allocations don't go.
>
> Thanks for the explanations.
>
> The reason I ask is because I'm trying to figure out if having a time
> interval wait or retry mechanism instead of skipping migration would
> be a viable solution. Where when attempting the migration for folios
> with the as_writeback_indeterminate flag that are under writeback,
> it'll wait on folio writeback for a certain amount of time and then
> skip the migration if no progress has been made and the folio is still
> under writeback.
>
> there are two cases for fuse folios under writeback (for folios not
> under writeback, migration will work as is):
> a) normal case: server is not malicious or buggy, writeback is
> completed in a timely manner.
> For this case, migration would be successful and there'd be no
> difference for this between having no temp pages vs temp pages
>
>
> b) server is malicious or buggy:
> eg the server never completes writeback
>
> With no temp pages:
> The folio under writeback prevents a memory block (not sure how big
> this usually is?) from being compacted, leading to memory
> fragmentation

It is called pageblock. Its size is usually the same as a PMD THP
(e.g., 2MB on x86_64).

With no temp pages, folios can spread across multiple pageblocks,
fragmenting all of them.

>
> With temp pages:
> fuse allocates a non-movable page for every page it needs to write
> back, which worsens memory usage, these pages will never get freed
> since the server never finishes writeback on them. The non-movable
> pages could also fragment memory blocks like in the scenario with no
> temp pages.

Since the temp pages are all coming from MIGRATE_UNMOVABLE pageblocks,
which are much fewer, the fragmentation is much limited.

>
>
> Is the b) case with no temp pages worse for memory health than the
> scenario with temp pages? For the cpu usage issue (eg kernel keeps
> trying to defrag blocks containing these problematic folios), it seems
> like this could be potentially mitigated by marking these blocks as
> uncompactable?

With no temp pages, folios under writeback can potentially fragment more,
if not all, pageblocks, compared to with temp pages, because
MIGRATE_UNMOVABLE pageblocks are used for unmovable page allocations,
like kernel data allocations, and are supposed to be much fewer than
MIGRATE_MOVABLE pageblocks in the system.

>
>
> Thanks,
> Joanne
>
> >
> > > Currently fuse uses movable temp pages (allocated with
> > > gfp flags GFP_NOFS | __GFP_HIGHMEM), and these can run into the same
> > > issue where a buggy/malicious server may never complete writeback.
> >
> > So, these temp pages are not an issue for fragmenting the movable block=
s
> > but if there is no limit on temp pages, the whole system can become
> > non-movable (there is a case where movable blocks on non-ZONE_MOVABLE
> > can be converted into non-movable blocks under low memory). ZONE_MOVABL=
E
> > will avoid such scenario but tuning the right size of ZONE_MOVABLE is
> > not easy.
> >
> > > This has the same effect of fragmenting memory and has a worse memory
> > > cost to the system in terms of memory used. With not having temp page=
s
> > > though, now in this scenario, pages allocated in a movable page block
> > > can't be compacted and that memory is fragmented. My (basic and maybe
> > > incorrect) understanding is that memory gets allocated through a budd=
y
> > > allocator and moveable vs nonmovable pages get allocated to
> > > corresponding blocks that match their type, but there's no other
> > > difference otherwise. Is this understanding correct? Or is there some
> > > substantial difference between fragmentation for movable vs nonmovabl=
e
> > > blocks?
> >
> > The main difference is the fallback of high order allocation which can
> > trigger compaction or background compaction through kcompactd. The
> > kernel will only try to defrag the movable blocks.
> >




--=20
Best Regards,
Yan, Zi


