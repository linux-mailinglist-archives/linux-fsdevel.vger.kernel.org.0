Return-Path: <linux-fsdevel+bounces-64326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C5BE0FC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 00:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D5818885AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0359B316194;
	Wed, 15 Oct 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWZizGYt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630F26C3A7;
	Wed, 15 Oct 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569066; cv=fail; b=ccBWXRf296FXlYJ4J9P3PvIaX8ZOAVBQfYWUvMwYB7iRZvihbc5zwgQZDA1Jvaf5SXXuoAM+iH/ok9WTJ+8e9K8JOm4Bk9T35IEHe6usyyHIRu7ND1oadPF0uQGrtadGKbcPwbSXDYHEDpWP4i4B2+JX/HTKrxzV6oYVCpL4I1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569066; c=relaxed/simple;
	bh=VCH3wTLvS6QmqsrZoe14YWD9i1CSufq9uccaRj+O9Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EkMVbtbQeGWq1G/o0iGlov1QhkVSr8+6vwrJtmvzlCouc5P3YOHZAtEX00kL6Ene0N/nsh4V8S3skIxVTprYZ/l6iSHK51TJINBG7tSNsgdF2gYC1h3kX1cI6CaPNpBz8RcrruRkp3UJjE4u5I9ODSHytDGAt8D5Hvsfdk+HzHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWZizGYt; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8CnavQaCGLhF1WI71tAOPhQ2wmH+C+zkZDxNBvY/bXA4aILWtvPfncKvUIpFIJinAUad+tbo3pcJCl4NqOlj1JzAbGTcL/O8u6YXWAxSSMlO1T+hhza12Xcz9AUK4t9HND0bUa0f2pod2LZ8TkP7V0dx+LXRYxr7qjuvUjwZ79H1pqvMxqfeJArSOPBYuhiY2TkR9GfhxhxlWa1dbFXkHGId6xJaTODay1OpKqDdcOZkXDXMwdAoDa2ymcDirAxheM3JHZ5MOoi5vzYQaxNpj4DHx3NVj62JVpKxGyTX7TJRfqqb6Ffk4ZBR5SWrQ31GN+10bJtUcsFEp7oasNvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XynaZMV39hrve8ZoxNNDmYWxgsKiG3KL+V4dsJg/USA=;
 b=VwyaBMwbeftvcd4q/WO8PAkNmG+jVBJm4Qd3s6lCfB+AS/XVjwVFt6z6c6bk+PEio9Es5BaPdpDXl5neSPoQrlzf3u+PDQ9e2W9UiHDA34WVbJYU7cTgFxSlIvVcxppJQ8+B7+mmGV9mCIbQsypTluQlNaZT6MhrFx6m9mK5W/UcGJYr7zvNa9Frxrrap3633/S4A6CV/4O+1klgkBVFG9r/lh+gW40mAObs3mHTkmIzDyxtwdR7rCq7lBOCOMFgjg2/qrgyahG2blKrQXmvk/UdYPKf+30K46bwqFpD114P0mQGT2A+Wdxa1NCG6fE16NglClXFtGKD5r9EcUyAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XynaZMV39hrve8ZoxNNDmYWxgsKiG3KL+V4dsJg/USA=;
 b=GWZizGYttRJjrcTDJidmm6pr7qV5LkiIaUDeap08rH/45ps+Je+0L3kOODC13IU/eG+YxKelZq5w/G2nt8FIyoSaIFVkseAGcz8/UQq5S9w0ue4X1k+xebUhKr5I46tBNir3dmCBoCq1BafomLd8tQN/gXtfd83gzR72LXgSGe+IxMX2xs1/T1umg4n8REamG74QeWI98fhbHKi08NopwtHVwDNeN9EOhxaijGBrJVgNPSxw2PgbvE0yVRc026WratXdV/e3+4Va6mGL5DWARl9mlLRGFNW/1QhKD2mW/MQqZHgBpLkvCuFMB+5S0dlbcZTw8QWfn8B41sISyzRIGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 22:57:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 22:57:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Date: Wed, 15 Oct 2025 18:57:37 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <9F4FC13E-E353-4A4F-BEB7-767CF4164854@nvidia.com>
In-Reply-To: <d7243ce2-2e32-4bc9-8a00-9e69d839d240@lucifer.local>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-2-ziy@nvidia.com>
 <d7243ce2-2e32-4bc9-8a00-9e69d839d240@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:408:ed::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: f162f6b9-f631-44a4-3682-08de0c3e3e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTFMWUxXQjhValNaTzFVQjQzdWp5aGFReW9NU2czcTl6eHRGQ2EwQWxSUW80?=
 =?utf-8?B?eFRtR1hBQWdyaS9zWHA5Zk9aZTlFc3Vab2FvV1lZTWdzMlRXa3lhaXRmUUVt?=
 =?utf-8?B?VmlQRDhtZ2JrRTBRUmVGQnhjMkFoazVsbG1tbk9xMjZkWTY4ZkgrMkhqTVFB?=
 =?utf-8?B?Z2RZQjdJcDAwbUlUMUpPQllrMHFncDhEVHVGRUgzbjhFd2Nrd1JJbmtkOVA0?=
 =?utf-8?B?cHZXTkJPUDBJd3pCMGdOcDRqZ29HbVZQb1NSVVY1dWhpbU1MNlJhR0lpQURL?=
 =?utf-8?B?UXV6OVZMMDFrb0xIYW0zekZWRWRwUGo0Wkw3WjlQN0Y2MDV4b2FWbmQzSlBL?=
 =?utf-8?B?Vlk3L0lIVUhKYmYwZnlUN3lKOTNHTzFJSFJCU0V1Q1hjSjBURW9TU0lpQ3I1?=
 =?utf-8?B?Z0p4Vk9vRmtRdUNMWFRMZVFKRmZiNW9ESTAwRTF5ZmxlSGtPRlN6dndKamYx?=
 =?utf-8?B?bG1vTk53UFBnZ0t2Nko1dGFIQ2o2cHA2aWJJSUxRbmtJRjVQOGNnN0VaQW0r?=
 =?utf-8?B?a1ZPYVhiYnVTWXQvcmJYdnRyQVE5aDBEeXN1b3plUndkaC9qU3Y0cTN1bXF0?=
 =?utf-8?B?TXpIV3ZoVW5TdjdDbUR2em9KamxVcDhaQWdlMFlNc0U1MGJObjdqQmlRTFBY?=
 =?utf-8?B?YWpzaVFyc3RndXN1OS9uTGgxWmcycURxVWFjK2tTNHo4SVNtd1BObmozUWFI?=
 =?utf-8?B?b0dPSUdVSnZBcXhYYnNRcFZaczl4ZllmNmhZS3kwVS80SlhOYmZjWVYzZ2li?=
 =?utf-8?B?L1pvUWIxMnowL0NjVVBGUi9Rb1JRUWZRaTFOZWI5MWhxbFVMbXdRWjlPbnQr?=
 =?utf-8?B?UlVIWVRoWnRLMUs3V1lXT0xUaDRBd0ZROUZoZlU3S3BpMi9ERlBRU2pqMGpW?=
 =?utf-8?B?eEhQb0wrREovcU5pRGxxWEFleFlydjJ2RU1ML3NVT2pIdlhKekREazJ2anR1?=
 =?utf-8?B?Sk5iTDFDd0pqRnNydzdoVUhUT3pGbVpOU3V6N1F3N3lwd1hYNEZCMm41ZmVi?=
 =?utf-8?B?blk0QktyWTk2MDZJdkJvMlhQNEgzMUdKak4rQTdzVFJZYXlBU3J1d0VlNXBv?=
 =?utf-8?B?ZlBjOXVTK3hZK091YTU4ZXk4RDNlbW9va0dFVVlNUVZ5VmpiampucUdqa1VT?=
 =?utf-8?B?NDFOaHAxTzdRdGQzUGZHeDdBTmtUSmJGT2d5TlZkb09XWWxxZmFkbDRiY09G?=
 =?utf-8?B?TmZSWWVmOU8vOW9nQmpUK2N1bjhUMll5akd1VllOYUhaTHcyV1JrT25JcnV6?=
 =?utf-8?B?Vy9sRkZGeUliTWxRVGljZGpvRE9ldEpzRmtSdm9QdDdvVGE2UTB5NUNzNHpq?=
 =?utf-8?B?M0oyaGpVRVFXNHNPTnE1V3lZdUY4UnhBbnV2MWJyTlVNaXIzcTN2dCtmakxu?=
 =?utf-8?B?QVdpN1NhUERjVkY4VTRhSzU0cHJhQzJpT1JKaTM2ZkF2aWlmQ1pvaTJwcjlu?=
 =?utf-8?B?K2tzRnllNE5WYTZoaWpGa0Z1NVRVUC8yU3RhY1dHZnQ0cUQ5Ly9QZVlSMStp?=
 =?utf-8?B?ZTJ0bWR6QTM5SS9VY2ppdlZQb1pCR3VRM3daOFIvUTFpMEl5d1UwZXFLWDNP?=
 =?utf-8?B?L0NBNG5hSDZua2JCdllVVC85aW9raGVrNG5WRzhtWS9ncVBWckhuT20xTURM?=
 =?utf-8?B?NFk0SkdFZU44a2krb3RPRGQ3cHBDRmJzME45L0hrSnBmanJEU0IwUzlaM3pZ?=
 =?utf-8?B?U3ZJalZGazV6WUdSQVhlYWR1ckdUWXJJZERTNkwxZS8wYURMSWdDRi9wQXRO?=
 =?utf-8?B?Wk9MQ2FqT0xYUmRkWHo3cmJoa1JLdjF3d2M3Nk5TUUhBdThzVExRSnJzVkxB?=
 =?utf-8?B?Vk52L3FKbWMwN0FPbVRRY1dGbzhta2lNeXBzUThzbFNzaENobVJZS21MZDdv?=
 =?utf-8?B?ZHZ5RzE0bUxMbHF5NzV2NE5QbzU0ekZZSGp4eTIrRTJOVGwrbHozWVNBMTRy?=
 =?utf-8?B?QmxkZVFyWnc2MVVwMFZSemI3ampCdmRzSHR5VzNlanZob3ZRN1JYdnEvWXNu?=
 =?utf-8?B?K2JTL2gxb0tRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnRIRjNmWWpTZXNIWngzNFpRUVNjcXQrVmRYTXpuTkRUVmpjQ2V3ZW9vNTFW?=
 =?utf-8?B?WTR0aTJ3elBJb1VhUUNGbFRwaGE4cHQxT1AzaDNleEczZDUxciswSWtBdDhw?=
 =?utf-8?B?YUEvQUQwRktMdWhhdW9WUC95MlFwNDEyd0o1RHhHS01MKzdQTHdlWnJJbzNZ?=
 =?utf-8?B?Z3JrNVZBWHlGTWMzWmt0cDVILzFOelRaQ2h6dUVUTjl6RXc0eHlnUHdqNy9x?=
 =?utf-8?B?ZS9hV1FBa3Q2d1NPRlZSSUxNSlRiRCtOaFZJRElhOGh4WnFzUUU5TjE4VGFr?=
 =?utf-8?B?Ung4WTFCQXZBNVFESDRpMG12QkRRN3ZCWWsvU2pkTzU1cWJabGx4UnNJMC8w?=
 =?utf-8?B?WUtrcFFsN1J3MVFNSTR0YnVJaC81UHluSUtpTWdhRFI3aUdsb0pGbkZObmRP?=
 =?utf-8?B?N04vUGxUaW9hcnBWb1cvdXgxYjBWL3RmbkhtaTFwK2VrV3lRN1NvSnEvZWdy?=
 =?utf-8?B?a0cvY2lOZUx2ckl5cDBxbVF4SllvRmRLUUJNNGZmWjhMWVAvU1ZDL1JpQUxO?=
 =?utf-8?B?ay9PdEQzaTFIVGNweEg5TGhYQWZiemNaTUdIbUJEanlhUk1TVmRRaFhRSDdQ?=
 =?utf-8?B?K3BQbnh1ampSZWdSWURJdVNodkRMbURmdktoTHhXekRkbVV0b3p5L0x2aXhF?=
 =?utf-8?B?R2RpMklsck4yOHJEV3dpMnREeFgzVHBDZU1MSXdhQXY2WlMzWm5QZ000eEVo?=
 =?utf-8?B?THlISTBaT3ErdTd6Q0JjRHJLSXlodUFPNGJTVitQV2s5djR1b0RGVm11REEv?=
 =?utf-8?B?d0dpWUI1V3hmVUQ1bHJZNnB1WFZQUmhlZmRjMis2UzU0dmxBN3ZQRmM3K2RY?=
 =?utf-8?B?WllveTU1RVl4TVYwOXpmYThUUndwOHBxTnM0THJreUlkcGMxUjVVdzYwc3Rr?=
 =?utf-8?B?NlBWWHBiNzJLZDl4bnExZlFrcUZDV016WnVrRmVaM1N6eXBQdEhOb3JmbUNK?=
 =?utf-8?B?WW1jRnpEVm8vSFpZYkNiVDNnanVqQ1lCVDFDYjNsL2dTMGZqU3Z1U1NaUlhW?=
 =?utf-8?B?WUFSUWRPQmdBcEhMTUUyL2xCYm5FTC9ydUJ5aFhvcnhxZENTZ0FEUnREemVC?=
 =?utf-8?B?akxMR0lQVW0vemVnSjNzK0hBT0hnS21IL0ZFKzQvYTBoZ3p2RzBmaWJPdGVN?=
 =?utf-8?B?M3ZLUmNsQVZURUIxdHdqZGNuZlgxNHpjT3hpT2tUTEFlVDFVWHR4bGRNQXBN?=
 =?utf-8?B?UU5kQzNvVHFwWTNFakxaWFVyMlJmWnI0YVFsa1Q1VGsxa2Q4M3pmSnd3Mjl3?=
 =?utf-8?B?N1liTFVROVJzNXg4SktMVFQ4c1dBS0dwU0FBMHdnc25NUkoxQ0FRL1hOQVky?=
 =?utf-8?B?cE14WVo4VmZ3RjFrbTRKTGw3aFhhLzJDSG1KRENad1dMaStoWjBLRHBCeWdS?=
 =?utf-8?B?dDVZRmtKTExWZkxyaWtrUnl6WU5JWk8rR3pzcy9sMkI3enlSRktqOTdIRFg0?=
 =?utf-8?B?SDdOeG1SYmp6YlB2dzdZY0FHcng5cWwyT0ZhY0pZSUxMZHdEcS93RWhPQnRK?=
 =?utf-8?B?YXU3MjVPQk1BdnVEeVZ1MDVLdWVlYjJIM2NxdWY1THBhKzNVNzRkZkd5Ylc5?=
 =?utf-8?B?VFlJc2dPSnN1dVBlWFRzT1N1SUpYNXZFc0swOG1TczVlODN6b243Qk5IRU1U?=
 =?utf-8?B?NFViV0o0SElRN1BKMVNFdjh3RkhsdnhndXp4aWRXdGhSbU1EVzF6S0dEMExW?=
 =?utf-8?B?V3gxZC9EMUJVSVN1R2FlQ3V3ZHh1ZllnVkVReWVQR1g0VkxMeURzd2E1Ulg2?=
 =?utf-8?B?QmlrQmVLdHFiNjhVVkFDR2JJekVJUWFPM25YWGZRcnhETTNoYzh1cWRmS0Ja?=
 =?utf-8?B?VnhkVndNVUhXZE05bUFMQVB5WWt3L3hDWUdsT2xocjJBazRCbFU4TGtCdjBm?=
 =?utf-8?B?djFOZ2tFNEtsWjhFT2VUMmY0N1ppNHlXbzdFSmlGeTJkNmpMN2s5aFhGVUZK?=
 =?utf-8?B?OXMzMEkyNm14R0JRb1RNN3AxdXRlQk8zVVAvRnAwSU44Y29sYlNRSEp5SFhr?=
 =?utf-8?B?T3NjYzJlSE5SdTB0YXpUU0orclowZ3NJT0NBYjhMNkdVcm5weGdTN3VqejRo?=
 =?utf-8?B?MSswTFp0ZkZVQ1VFV095czdVWUlSNHpPUmYzK1ZQNTI1VlBNTVNKdkxRVzFy?=
 =?utf-8?Q?KOobQLh14IpHGkwHn49CDG/X9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f162f6b9-f631-44a4-3682-08de0c3e3e8d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 22:57:41.1905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuNQbKTGWey2Ua5OhJ86Gb9zKnnQDn8BA02piUgw6B8mrMLp5dzBGFxOCLRp7Hkv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

On 15 Oct 2025, at 10:25, Lorenzo Stoakes wrote:

> On Fri, Oct 10, 2025 at 01:39:05PM -0400, Zi Yan wrote:
>> Page cache folios from a file system that support large block size (LBS)
>> can have minimal folio order greater than 0, thus a high order folio mig=
ht
>> not be able to be split down to order-0. Commit e220917fa507 ("mm: split=
 a
>> folio in minimum folio order chunks") bumps the target order of
>> split_huge_page*() to the minimum allowed order when splitting a LBS fol=
io.
>> This causes confusion for some split_huge_page*() callers like memory
>> failure handling code, since they expect after-split folios all have
>> order-0 when split succeeds but in really get min_order_for_split() orde=
r
>> folios.
>>
>> Fix it by failing a split if the folio cannot be split to the target ord=
er.
>>
>> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
>> [The test poisons LBS folios, which cannot be split to order-0 folios, a=
nd
>> also tries to poison all memory. The non split LBS folios take more memo=
ry
>> than the test anticipated, leading to OOM. The patch fixed the kernel
>> warning and the test needs some change to avoid OOM.]
>> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@goo=
gle.com/
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Generally ok with the patch in general but a bunch of comments below!
>
>> ---
>>  include/linux/huge_mm.h | 28 +++++-----------------------
>>  mm/huge_memory.c        |  9 +--------
>>  mm/truncate.c           |  6 ++++--
>>  3 files changed, 10 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 8eec7a2a977b..9950cda1526a 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -394,34 +394,16 @@ static inline int split_huge_page_to_list_to_order=
(struct page *page, struct lis
>>   * Return: 0: split is successful, otherwise split failed.
>>   */
>
> You need to update the kdoc too.

Done it locally.

>
> Also can you mention there this is the function you should use if you wan=
t
> to specify an order?

You mean min_order_for_split()? Sure.

>
> Maybe we should rename this function to try_folio_split_to_order() to mak=
e
> that completely explicit now that we're making other splitting logic alwa=
ys
> split to order-0?

Sure.
>
>>  static inline int try_folio_split(struct folio *folio, struct page *pag=
e,
>> -		struct list_head *list)
>> +		struct list_head *list, unsigned int order)
>
> Is this target order? I see non_uniform_split_supported() calls this
> new_order so maybe let's use the same naming so as not to confuse it with
> the current folio order?

Sure, will rename it to new_order.

>
> Also - nitty one, but should we put the order as 3rd arg rather than 4th?
>
> As it seems it's normal to pass NULL list, and it's a bit weird to see a
> NULL in the middle of the args.

OK, will reorder the args.

>
>>  {
>> -	int ret =3D min_order_for_split(folio);
>> -
>> -	if (ret < 0)
>> -		return ret;
>
> OK so the point of removing this is that we assume in truncate (the only
> user) that we already have this information (i.e. from
> mapping_min_folio_order()) right?

Right.

>
>> -
>> -	if (!non_uniform_split_supported(folio, 0, false))
>> +	if (!non_uniform_split_supported(folio, order, false))
>
> While we're here can we make the mystery meat last param commented like:
>
> 	if (!non_uniform_split_supported(folio, order, /* warns=3D */false))

Sure.

>
>>  		return split_huge_page_to_list_to_order(&folio->page, list,
>> -				ret);
>> -	return folio_split(folio, ret, page, list);
>> +				order);
>> +	return folio_split(folio, order, page, list);
>>  }
>>  static inline int split_huge_page(struct page *page)
>>  {
>> -	struct folio *folio =3D page_folio(page);
>> -	int ret =3D min_order_for_split(folio);
>> -
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	/*
>> -	 * split_huge_page() locks the page before splitting and
>> -	 * expects the same page that has been split to be locked when
>> -	 * returned. split_folio(page_folio(page)) cannot be used here
>> -	 * because it converts the page to folio and passes the head
>> -	 * page to be split.
>> -	 */
>> -	return split_huge_page_to_list_to_order(page, NULL, ret);
>> +	return split_huge_page_to_list_to_order(page, NULL, 0);
>
> OK so the idea here is that callers would expect to split to 0 and the
> specific instance where we would actually want this behaviour of splittni=
g
> to a minimum order is now limited only to try_folio_split() (or
> try_folio_split_to_order() if you rename)?
>

Before commit e220917fa507 (the one to be fixed), split_huge_page() always
splits @page to order 0. It is just restoring the original behavior.
If caller wants to split a different order, they should use
split_huge_page_to_list_to_order() (current no such user except debugfs tes=
t
code).

>>  }
>>  void deferred_split_folio(struct folio *folio, bool partially_mapped);
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0fb4af604657..af06ee6d2206 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3829,8 +3829,6 @@ static int __folio_split(struct folio *folio, unsi=
gned int new_order,
>>
>>  		min_order =3D mapping_min_folio_order(folio->mapping);
>>  		if (new_order < min_order) {
>> -			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
>> -				     min_order);
>
> Why are we dropping this?

This is used to catch =E2=80=9Cmisuse=E2=80=9D of split_huge_page_to_list_t=
o_order(), when
caller wants to split a LBS folio to an order smaller than
mapping_min_folio_order(). It is based on the assumption that split code
should never fail on a LBS folio. But that assumption is causing problems
like the reported memory failure one. So it is removed to allow split code
to fail without a warning if a LBS folio cannot be split to the new_order.

>
>>  			ret =3D -EINVAL;
>>  			goto out;
>>  		}
>
>> @@ -4173,12 +4171,7 @@ int min_order_for_split(struct folio *folio)
>>
>>  int split_folio_to_list(struct folio *folio, struct list_head *list)
>>  {
>> -	int ret =3D min_order_for_split(folio);
>> -
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	return split_huge_page_to_list_to_order(&folio->page, list, ret);
>> +	return split_huge_page_to_list_to_order(&folio->page, list, 0);
>>  }
>>
>>  /*
>> diff --git a/mm/truncate.c b/mm/truncate.c
>> index 91eb92a5ce4f..1c15149ae8e9 100644
>> --- a/mm/truncate.c
>> +++ b/mm/truncate.c
>> @@ -194,6 +194,7 @@ bool truncate_inode_partial_folio(struct folio *foli=
o, loff_t start, loff_t end)
>>  	size_t size =3D folio_size(folio);
>>  	unsigned int offset, length;
>>  	struct page *split_at, *split_at2;
>> +	unsigned int min_order;
>>
>>  	if (pos < start)
>>  		offset =3D start - pos;
>> @@ -223,8 +224,9 @@ bool truncate_inode_partial_folio(struct folio *foli=
o, loff_t start, loff_t end)
>>  	if (!folio_test_large(folio))
>>  		return true;
>>
>> +	min_order =3D mapping_min_folio_order(folio->mapping);
>>  	split_at =3D folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
>> -	if (!try_folio_split(folio, split_at, NULL)) {
>> +	if (!try_folio_split(folio, split_at, NULL, min_order)) {
>>  		/*
>>  		 * try to split at offset + length to make sure folios within
>>  		 * the range can be dropped, especially to avoid memory waste
>> @@ -254,7 +256,7 @@ bool truncate_inode_partial_folio(struct folio *foli=
o, loff_t start, loff_t end)
>>  		 */
>>  		if (folio_test_large(folio2) &&
>>  		    folio2->mapping =3D=3D folio->mapping)
>> -			try_folio_split(folio2, split_at2, NULL);
>> +			try_folio_split(folio2, split_at2, NULL, min_order);
>>
>>  		folio_unlock(folio2);
>>  out:
>> --
>> 2.51.0
>>


Best Regards,
Yan, Zi

