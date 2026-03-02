Return-Path: <linux-fsdevel+bounces-78939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K7KFzm+pWn8FQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 17:43:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD931DD1E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 17:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545E430432F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3FA41C0DE;
	Mon,  2 Mar 2026 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjyof7Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695A41160F;
	Mon,  2 Mar 2026 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469430; cv=fail; b=tUy3xbm7qGdMjEWF99T3S5Vf1NRrOfq9oIrV+eqHP6XumTdikGjvYhLOfYhawGCNBAjNpZ5vSPVpxoFh+yXvZVjdR1wCFr+Jod8hH7WLJs0IXTqbm0eC8KHR3aOM7llfdDmN/DQwYKqolfcYTA56l3TIDTje+y0CT0DKg7ODIvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469430; c=relaxed/simple;
	bh=ZK5Cg668mpmbKEd8qH+eBUB8aMjoDwadNyxm2Rri8TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aLlDPwNO/pGx6afkqD0qXVnD3Dnd8lzoIammfysXV3DI+v2rC5VUqtIGxdlhGe6XnpuXqKS4ejHC5RPRtloEBhTTp6r8RSby2E76BkIyMxXdm/QChZ9CFA4IB295raeN4jsVcA8Pq15o9JxFAiagG648QjkFSqIs+0RnqLY8ifs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bjyof7Sw; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW6uSSjgxLbMOhlsGPokTXzk0nxMtlIe762IveR9l9tbC5vHP85af70DzT4vgbpxU8qiwyB/oczFyUXNWgFkeguA+9Iye7Em4GT0nVajmtefp4UzNR5OGv6yrRRu+YV6R/TnzrqIzG62Y4u9Nu7LZmxxSgaCCU/Kp/3t+dpe8vVKBW59OxaFYakzEX04LSUPaL4F1EVr4tXWB/dRwE7MVFGmX0gtEsv2QsTF8NXaK6Ke5IrhvT/sfVXudj2vDe3yB6uk3c7y/64IwkF5BGxC8fU38Q7hkbeI5K8SFkTsnAH7AIeyod9HOorlVl56PAWCV7NwJ90z7t5u+3rfi8bVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK5Cg668mpmbKEd8qH+eBUB8aMjoDwadNyxm2Rri8TE=;
 b=CX1mwGrUlveSRE0g903tq948zqY1ZdIWg8yzhHwtWZVgkKR1UNzACl/rUzKxBIcPNO5qrdKETq9m6pRe8xE8p2Ah4Dl509vU+HDPP+k39gmzDH+DzFWyJwdWFcg0MjojaToY2yMdVXB93JGkxAfEN2WOSoLFZ6C3Llvrh7XVZh+Yxka0CySXoH10uUiyhmkPhaN/K/sKrwNe5kiw1FLQtgnhkBg7n3ejgjM8EkvnktY0rH2w02uM3KwJOLXosMijBmZkvrDVVN+mDKFFNsXantvUBjVms1eMiSqVXS8PfkYWdcU0JPL2mFmLcSExb5+ZRjE2foHoQXEWMyHCWdfseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK5Cg668mpmbKEd8qH+eBUB8aMjoDwadNyxm2Rri8TE=;
 b=bjyof7Swp9g1KkWqgF4hb6cPU3GwWVysJovbF9voT++1o5la7HFxtHfCoPOiXDA8aPPmgJGXX8TKwzyaxJKXEGiKy0/sHdoa+Jqv3aCkgtWmK773n+nvvFeOQwXcTpgYPz8NJ6DllhqX4QCuD4b/46Qnff++/RDTi7/QXPBjc53Yh1qvIkLYQ9Lw8/h9pIJsleiyMVMx4ZaOXwNkNrfm3/98wDQUQts8l28QZmArTNYrS9fUqMx6HESRUdnXfgMwcxQyeec5eIdc25EP6w0oJkmrWLCuREUZYJnqlDiAYtUXC9I98EqjXgXYJ4V/xjXcQa53MOM7ymtaY3zMeIrWNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 16:36:55 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 16:36:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>, Bas van Dijk <bas@dfinity.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix a folio_split() race condition with
 folio_try_get()
Date: Mon, 02 Mar 2026 11:36:49 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <A120B74B-D8E0-4810-B0AD-CC34ED7BFC9A@nvidia.com>
In-Reply-To: <6a568d3c-daf3-46ba-a3ce-0a0deca824c2@linux.dev>
References: <20260228010614.2536430-1-ziy@nvidia.com>
 <d9e30bef-621f-444a-a1b0-510c50927d9b@linux.dev>
 <64fa6a73-8952-4ee1-b7c3-8b0ebef3ea78@kernel.org>
 <6a568d3c-daf3-46ba-a3ce-0a0deca824c2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 58182013-49d9-4d78-82e8-08de7879ea0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	enIJtFfFbH/VfdO8HndBSQqua0zN2K4+F94KMczdblGDtXC1IUhm+F+DTNHxsX91M2wZ+2cepqnXqlD4FMPD+BhQsoHRKzIBWhq7fQnOiyM7oFM1DxGzVgEcTSgaE/2EJhm8K2UncudlaBpacIHGTYORpDkSmxUdDvxGCYISD1gR+tyUzgPUz1tlHIF0BpHWNTyDYNs2WlZG4J44e1DHw3Tu/ZL/bRFTqslcPsHM/TCupLZ8NT+6bYYiYKsLZFoyA/aZfJjlqkSWRORy8uXvpWyH6ftlrY2e+uKuu1Bv6HwFmp6LmIEcm291oCO3wZdkPI22AqYqYrvfFzXvw/vo7dAc6FmAY7vwcL4Hne9ZTEnHuBkR+o1cK676DdVGtv39f4IZl3xIRVe6GAcC7VnL3IVlwiIlX1ljj9mvAs/0p0ONq+YB6cRFwgXrjIY8b6lVcG5iNT7svmzSfmecV8KE1WNEYyrJ8bwq5Gv/Ty7tJcs57rfHb0qENXAzytSLgDqmCF5utFT4kxqveZd1u4pZgG17N7mH0K2/s/ur4Bqfzz5ILX8L56KzbQdtPcit9iByD46ws2k2z48mBN9lEoQ7WnVtNGiTj7dxw9Ox5eB0yS0gzCPA1cvVi44uK7+z3wrcLEMqPWq0l9zIl5nivtTSpw50dfUPTSiNmiER5k0jwcYQo5URk8dN5Nn7YTm+MogqAxr0dxYuQf+BAQk+y3b58dWHzbkAYIB/NScZYRbPnKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXVraEQ0KytzRWU0bXEvTnlyS2l3NTFCMXRFL3RhNlQ4MytoSmJ0UkFMTFJQ?=
 =?utf-8?B?WDdoVTExaE16NVdvZkRtczFTNmx0MDdncmdJMVZneS9Sd08yMnhKbDNXV2RW?=
 =?utf-8?B?RUsxZG9wK1M4N1lnOWZvbTI2ckVCRTBMMysyQlgyei9VMzNKNkhiSzZXNWh4?=
 =?utf-8?B?WmQ3dVhXenRRZGF6ZUJUR1ZXanBsZzFvR1B2enZKSVdTR29qbHJjM20vQjQz?=
 =?utf-8?B?RnMrSU5UemlkRHNyWGFuZGFHSE5Fd2VTcmVvVWtIVitsemc5VTJTdnM5Z25S?=
 =?utf-8?B?YkdKcStRZzJqdUVHQTZoNGNob1hpUHR1Y0JqbGtxT1dGQTVCTitZelkzMGxV?=
 =?utf-8?B?V2NYcVdqeWcwWVBqKzYxUVJIL3VXMDZXQzVKSWxtRUx6aWVZbUI2eVhzRmdn?=
 =?utf-8?B?MWNpNWU3a0h3OXBLRmxybThhUG1jbVI5a2FFRWd1V0J0RHRTcUxwMlNqY2lx?=
 =?utf-8?B?d3AxSWxZNjduQmVCVG5NQVNSTU16OEhXNzExNmhqT0w5R2h4cmVPMy9TMEVC?=
 =?utf-8?B?Qk9aUFptcXp0S1dxMGtLVXBrSzRadytXYWRkZUxOZDFFMktVSjdUeDVNUXJN?=
 =?utf-8?B?NEZBV3N6NWVtKzdkMFJ0ekdZK245OGRXUkVhNUxyLzBNOU1NOEpDeXlVbEw4?=
 =?utf-8?B?NU9vQzBUdzlsWUVqbkt4WEtqR29hcVVDSHd1ZFJtYXBOZkY2UkQvMzdHQXJK?=
 =?utf-8?B?RUxnRlJialJHYjJRSy9UTjhYYXNtNkp5RFlESDNPbjFueUtBTnhQWXN4aWVX?=
 =?utf-8?B?cFRmUVN5akV3MHFYQVoxM0NkR1ZuNUI0dnlGQlRINTQ5WFM1cWFrN2MrTTMr?=
 =?utf-8?B?VFM3OG1XS2d0NE8zd2diSG5zcHFtbEpaKzFqTis1R0RsUVVLMzFYSU5DTW1q?=
 =?utf-8?B?elJnSWZUVzhVVW8zWnpWNkExV2UyaGFEN0dzUUlrTlA4OHE4NEZXbXJuUzJx?=
 =?utf-8?B?MnlDQnk1aWdGb0UwNGRaempWdEVhUENTRU1RSENkeE1ZNzAvL28vTGh1ajFj?=
 =?utf-8?B?NXpCK1FybnNTaWNCYVA3WXN2KzVoWVgyN0RwNldwNGhGT3krRVNnWWVKVFMz?=
 =?utf-8?B?ZFdHT0pvTWJEeWYra0FicTVrTW81VkJuZFhncFBBTUh0WkZBclU1OUZqbEVO?=
 =?utf-8?B?Zk9acy83Z1FacGVTa0hjTzl6M2ZoTEVkQm9TUG1HYXhYZmJrV01peGxraFZR?=
 =?utf-8?B?MjNIdFlDWjVCTXZaQVBMMWp0eHUvalFHdFc0S1VLV29tUHo1Um0rbit4T0wr?=
 =?utf-8?B?TlQrbndhYlUxU011VDVwUCtVZWc2WE9VblV6Q2EzaTJScjNOUERWb1Q1ZUtq?=
 =?utf-8?B?Tmk4a0NReGlOalZsRVVNU2djSGhSL1hVcmhiVm9KZTVZaDJ3RVFPcytZcWkr?=
 =?utf-8?B?b3V1bnMxQkZjTTlhTVJSc2lNZkxGUGdpbjIwZXRDUE9henhYVlhWdEs1NmtT?=
 =?utf-8?B?ZSt6UHhRbmJuNnA3dHRMRXBmc0V4d1FybmJwTnh6S2o5ejEvY3JFNkFJREE1?=
 =?utf-8?B?WDM5ZjR3NGl5U082Wmx3cGJLVDJVcDhzdyswOUJxK1AyOU1lQm9IN2x0czM3?=
 =?utf-8?B?eGFsOHJiSXltd2FGeGFJWWhWK2xnd09adnFEMUVVZUFMdmh5ODc4YjJKa1o2?=
 =?utf-8?B?M0dqNXlab256MDlrTCt2TDJxbUxDMHRZUjNjbU5ERmxIaS8xYVhMZUt6Q1VI?=
 =?utf-8?B?VUpnOEtXaFUzRllFbnhTVkk0TllEdFdQWXdhWWxQL2NodTJ3bFdrOWZCdTB3?=
 =?utf-8?B?ODR2YTExMmk2N3ZLTE1nUElYSTJQL3o3VGZsUGU4SjM0UktvT2FHbUlKSk41?=
 =?utf-8?B?U2doM2lLMWpYU3prdkJVdW5STVp3MDMrWllMVGJlcEpDb2Z6TXZQWlFha3Rr?=
 =?utf-8?B?ZDZBR1ZMV0RMdGpRSXUxYkdUTFVJamRPMWpKSitqbzgyTEwrWXRDZVEyY0lK?=
 =?utf-8?B?TjdTK3I3S0x1VEJqTlVRODBsSElEYkdwdGZvZW5nOHZCSUpwcTJlQWtJTjFh?=
 =?utf-8?B?R0prb2JHRmZ1a0VoaSt5V1FiUFRCOVRsaFNZUnIwcUlka1hqRlhwQzQrbDJU?=
 =?utf-8?B?SWZyaCtPRHg3bGFMb0lGeWVmNzJEdG5BVnhPOWJQVzAvVklxcU5iZkU4ZGhX?=
 =?utf-8?B?anpNTVJPc0EyMExOUnpqK3R5UjE5eVlEdStPNnlnT1J6alh1RkJ6MDRWNFZT?=
 =?utf-8?B?Q0tadktuOVFTaThwQW1Ec1N2bE5vNFpqZjRIQk1YdGV3Y2k3MFhLQmtHYmFi?=
 =?utf-8?B?RzI2aERTUDNxb0c5RXcrY2V5MWZudFc2dnJZYXBrYlNyck5uakpQM3NoL1N6?=
 =?utf-8?Q?guDeqYsr5Wzk+mOZ3M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58182013-49d9-4d78-82e8-08de7879ea0c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:36:54.7698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+DiMobMXELmGQkJX0f3CdVcW7ubLkIpQgVdGkylEagA7Q3tUChSNxR7k/h+4f8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
X-Rspamd-Queue-Id: BDD931DD1E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-78939-lists,linux-fsdevel=lfdr.de];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Action: no action

On 2 Mar 2026, at 10:11, Lance Yang wrote:

> On 2026/3/2 22:28, David Hildenbrand (Arm) wrote:
>> On 2/28/26 04:10, Lance Yang wrote:
>>>
>>>
>>> On 2026/2/28 09:06, Zi Yan wrote:
>>>> During a pagecache folio split, the values in the related xarray
>>>> should not
>>>> be changed from the original folio at xarray split time until all
>>>> after-split folios are well formed and stored in the xarray. Current use
>>>> of xas_try_split() in __split_unmapped_folio() lets some after-split
>>>> folios
>>>> show up at wrong indices in the xarray. When these misplaced after-split
>>>> folios are unfrozen, before correct folios are stored via
>>>> __xa_store(), and
>>>> grabbed by folio_try_get(), they are returned to userspace at wrong file
>>>> indices, causing data corruption.
>>>>
>>>> Fix it by using the original folio in xas_try_split() calls, so that
>>>> folio_try_get() can get the right after-split folios after the original
>>>> folio is unfrozen.
>>>>
>>>> Uniform split, split_huge_page*(), is not affected, since it uses
>>>> xas_split_alloc() and xas_split() only once and stores the original folio
>>>> in the xarray.
>>>>
>>>> Fixes below points to the commit introduces the code, but
>>>> folio_split() is
>>>> used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
>>>> truncate operation").
>>>>
>>>> Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used)
>>>> functions for folio_split()")
>>>> Reported-by: Bas van Dijk <bas@dfinity.org>
>>>> Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-
>>>> sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> Cc: <stable@vger.kernel.org>
>>>> ---
>>>
>>> Thanks for the fix!
>>>
>>> I also made a C reproducer and tested this patch - the corruption
>>> disappeared.
>>
>> Should we link that reproducer somehow from the patch description?
>
> Yes, the original reproducer provided by Bas is available here[1].
>
> Regarding the C reproducer, Zi plans to add it to selftests in a
> follow-up patch (as we discussed off-list).
>
> [1] https://github.com/dfinity/thp-madv-remove-test

Sure. I will add the reproducer link to the commit log.


Hi Bas,

I used Cursor to convert your rust-based thp-madv-remove-test to C.
Do you have any concern if I add it to kernel’s selftests to check
this race condition?

Thanks.


Best Regards,
Yan, Zi

