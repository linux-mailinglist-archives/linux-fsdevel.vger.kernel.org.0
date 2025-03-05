Return-Path: <linux-fsdevel+bounces-43211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFDA4F6CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 07:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B013AAE1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 06:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEE81DAC81;
	Wed,  5 Mar 2025 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LTiN0JFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF37083D;
	Wed,  5 Mar 2025 06:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154576; cv=fail; b=bkvSD/fYYwGoUr07jJ/UjcvSygTJ0Jmftk86+igxEfBA5kGc5ilfFG/K8vMaWvN7MWtlQgbDHlqIaWROjb6YSSYEI8EigTv5w4SXBEqoKQ/KklAzw7hYadcJF/wNhfTEHnJNhEbm4N5cee1Z7Ga2tS45MffpAUWW/mY90QvfUUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154576; c=relaxed/simple;
	bh=HdTruijo+1rFwNZ4V0p3gYDevZJFVgD/rZIOB3U2lXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/1BRDV8ypiLA6CyOAas41B+tNeqMRmLSLV9gYn4VecSR1sWj1BbKB3wP03IVGnKLh1OG1MWkhNDJNx70HiFuy69b0sLgckRn/DQ3aPWncHnSCGWC0yA/Ilo1nQff+yBpfWz+8/LnvHtxCp6JPWpoXOaUCXERqm3S/xdU72TUdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LTiN0JFZ; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjhdG0u/Z15+jT/xouOMPQ4i7gqWxbbdOn3SG5J+FqrFooSAJpd1AjXMrDsD/bBUpW40aE7CjsEwOXHRCMQTTsNjXq12+BwdfLAZt1UaUvQOtnH5NfPn9GFXhipEa40yLJddhAOltyfBhpwJaIbsgluyx/fjXR6vUVdB60gnlj9q5NG2aW8KTQmqUZw0VYTBOWHcZUfBwVQvxRou3PolrLp6CeemDnMVYxREDE50Nf+6qjQrSC420yRNp8bocwUCoeQyOJ2FEOaJ9AFBKQSWe9tvmbNGUw940dBfUCHnX6GZFG5sBXv2/pqB4j237Rjah/J1NEMdhMfJrP3XgXjSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmpCS2wXnuE28S1kHmm/Qwp0LdSpoI9uBh3K2vmhOYI=;
 b=Qq2X/ru1IPUARlAbf6/J9wFRp83H49GAefi8B4jEfJBFCBcaY3Q5LroQVzfMkEt6aM/Gykez0+JJXuycZOQm0MsNpzUmdQMdB+wNXjNBaAJ5otrMtBfH9KCnSVuN3cwnk5I79RSN0ECSucgYrshIh0RN8nnaCyKuoBQULIeV3Hir5YBO5Z9u0sr7akMLWEO+QahSVbn/oxYX1MgL9pyViAsgA6q4rYMlz4QxnFdzeuLpqkDOUPhu7KupPFztYjaNNKr8KJzNhhIHm/vtgxZxmd9hHS8JVLLhBJULIFP8ygDAgf+IeXC+il4TWAyFD9croKAQMwpvkUsT5BusJeNmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmpCS2wXnuE28S1kHmm/Qwp0LdSpoI9uBh3K2vmhOYI=;
 b=LTiN0JFZ4DAldtKr7tenrhd8NgH8/qctfjxb/2VGutkvCaLk4Uy7/i/mAdjKcH7+vx05KHMI/mZekrXPuDXJlTlH+lJJy1sjf6jbX/AIfjSddzrVD+SgdJklzUaEqdeopbh/F4tqD5fmaCMyqP6iXg9hrtDrXXFJL4NOlql5gkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 06:02:51 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 06:02:51 +0000
Message-ID: <b22ccda0-15b8-4cac-96f1-de6c9fad48b0@amd.com>
Date: Wed, 5 Mar 2025 11:32:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] KVM: guest_memfd: Enforce NUMA mempolicy using
 shared policy
To: Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Ackerley Tng <ackerleytng@google.com>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, willy@infradead.org, pbonzini@redhat.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, bharata@amd.com,
 nikunj@amd.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, tabba@google.com
References: <b494af0e-3441-48d4-abc8-df3d5c006935@suse.cz>
 <diqz8qplabre.fsf@ackerleytng-ctop.c.googlers.com>
 <Z8cci0nNtwja8gyR@google.com>
 <9d04c204-cb9a-4109-977b-3d39b992c521@redhat.com>
 <Z8cxaGGoQ2163-R6@google.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <Z8cxaGGoQ2163-R6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 840f51cb-42f1-46b0-18ce-08dd5bab5cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eERPR3ZpSGV6UGV5RG4ySndkZUtGakM0UmJ2d2pXOUZSTEJnUFdIUkxsQjBi?=
 =?utf-8?B?RVkyRHBpSzVvRzExUCtZUVliUklaWVFsT2U0SGJKU3gxeWpVR3lOTFgzODJ3?=
 =?utf-8?B?dlJmbXA0a3RwWFUwQmpQQ0lqQS90QW0xeEozVDFKU2V4QVRQUFNpSXA4N0tP?=
 =?utf-8?B?MUw0Qi8rVDNrcVFGYlA2ZFpsQTNxQ1VXZkNUL1k0Zzh6L3VzT0JzbExvL2hh?=
 =?utf-8?B?bHRaOGVQQXNFeXhDbjlXOGxscWJkUDVNeE8xNVhXdGNVZHRZV2tkeDBZWWN2?=
 =?utf-8?B?ZkdGa3NGUGJWb3FVZS9lT2pWTWZHUWpzT1lKVDBVR3BacHNtY0g2bFF2TENI?=
 =?utf-8?B?aWcwdXNUS0pIaFBGZUJWWXN0WmpWUmEwZXpRdDFZU3kra0h2M2JYOUxtMDZu?=
 =?utf-8?B?VGl5OWg4YVFsc1dMZFBRZVNuMXpLSW9mM3FNcWlLQitMQnBRVGxDVlNrWWZ5?=
 =?utf-8?B?Z094K2wxeXczL0JKSEFtU1NuUmpzWHJHSklidEIrdEIycTU3VlBEcXZVbEJU?=
 =?utf-8?B?YVlEZFlzSFViS3VmZzV0ektVSG1OWFUwcEQxd2IzRXI3TEhPV0ZxN1lXVm5B?=
 =?utf-8?B?U2NBMDJQcFRiYW80SEwrRkxnQ1poL0V5enpsTklOeEVHMWpHSGVlZkhHT2VV?=
 =?utf-8?B?VWJCS1JHUFovNkNNS1hIdG5iWW9wcUY5b0gwYWRaWGcrWUFKUDRYVGY4V2FK?=
 =?utf-8?B?WEMxaHl4SE1QK2M4U3d4WTQ5bVdBZWJyOXVUVUFreUhxeGZTUTlQVGt6UkZQ?=
 =?utf-8?B?bDJONFl2Rk5RT3BCaU05ZGs5czc3cSs3ZU1iclZKc3M0R2ZOQzNIL0lCeXVJ?=
 =?utf-8?B?NVNxTjRBOGlwUUI3WlhOM3dBM2RSL1hLcCt3Ym4yTUJDR2poVEZKYXBBR2k5?=
 =?utf-8?B?NWhnalg4TXQ0RHlYQUdsMnVaczFFK3BIYS9QZGFWU1Z0cFlCczRIRUdvdEda?=
 =?utf-8?B?d3oxQnVQZHE5WkhDbzU0cG8ya1dhQldEK3czUit3a0pOSlpvRWUrTndab001?=
 =?utf-8?B?MFM0cHdEcTE2R2VyODNFeG1kbjdReUdxU09BcjBESFhMS0E3Yy9UdWJBeklJ?=
 =?utf-8?B?NndJa1hvQzNPZm51bDF3c20yc1NtdnUweVJVQW5RK3ZhMy9reEVlSjJCdHFS?=
 =?utf-8?B?dW9xK2dKVmhXdkhjUlc5SHhGSUJIV2hpZE11QTZHNll1N095cWc1UEd5ZUZB?=
 =?utf-8?B?S250TmFrN1h4WWErK0JIWEFwVHp5Z1VkbDZYcERIUW1FS3o4bTh4WVQ1MElL?=
 =?utf-8?B?SlZ6MXVKZ09ZcVhhSElWaUl5cmJUK2NlTE8yZ0dtVHhiYzRweE52YytUVkto?=
 =?utf-8?B?Q3M1WmxueGxISFZhWFduK01WK29NK1ZBVXYwK1BHTjNkKzMyTnpLdGNjTGcz?=
 =?utf-8?B?MExXMHovT3kwT3YwRUZiTzZDUjUyTnlWS3hlKzZTNHQxOXFJUkhaL2RpTjlZ?=
 =?utf-8?B?OEJ3S1VYWks4Tk9BNW0rUEtEcTQ5aVd3T2ZNNTFPMEUySVREODBHbmVaZzIw?=
 =?utf-8?B?UFI4cjk1SHF5aEI5RTBXbDRDRWdQKzA2NlgzRzRzeGpqODI2WktGUk8veVFh?=
 =?utf-8?B?N2JZdE43Skt5R2ZEYWF3RnF5aDUyNlo5RjF4NEFlQ3VzTkdieVFoZmswMHor?=
 =?utf-8?B?MnRuTElnRStXZGp3WHA1T3pCU29QdGVsaDNxcG94YUxsaWNxdlVoZThQMDF6?=
 =?utf-8?B?a3FYQ3VNZ2tZeWFrb1Z1K1ZadXNBV2Z5M2ZMenRFcytFK2UyeFZnNkFrQWFY?=
 =?utf-8?B?OWU3Uk1YcmN4K2Z0Nmk5bXRGdEhCYWVLUlpMWGtiQWpucU1XV1dMaGc5QmM0?=
 =?utf-8?B?VmpQZzB6ODZ2K1kxMWxmUGJFbzgyeEZLU2d3UmlOemhDN3RKMFZTS1VISGZx?=
 =?utf-8?Q?tlXQxDNqaBzhq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTg3dTFvMGRQNWozVFgrM0ZsSURvYXR5ZkdRa3EzUUc2V1g5WlFNNjVoWGhz?=
 =?utf-8?B?Q3RDZkZEdmVDNUFrWmlnL3RyRWV3VEpKdGhDcDNlYXJUdjJRZWRwS3JEbERV?=
 =?utf-8?B?TXNraTV6MXQ2RmxKNHM3a1cyMnJXakV4b2d0OWszN05yQVdFTTR5S2Z4cyt4?=
 =?utf-8?B?VEZyVFNoVkYwWXJQeUtCeHZ1Y1FZcUhGS3AzVEhnajgzbjJaNVhGWWxvOFBa?=
 =?utf-8?B?NFFPdE0zUldmb1M0NGxmNlZhSmlnT1o0Njg5QXZMZjlmQUp6QUxuSjRlR2Iw?=
 =?utf-8?B?OXdNSGNMV1U5SlRnakRyYlB2U3JhaEgvSjJabktBQWFVV3NpaFhzbEZJUFY3?=
 =?utf-8?B?VThRRHZiWkU2aWQzTkVpUGQrbTZpc3ozYnlHMFVtTGxFK2taNTN5cTR4U1Rt?=
 =?utf-8?B?cGFkcnNnOHpRWnFvdnQ3SjNuSnhHWjVwRllodHB4RFdMdTFHTThBYWZOcDJU?=
 =?utf-8?B?MmE4WHJqY0RtcmllNFNqVS9PSU1GUkZLcjZrTTV5cHoxK3ZtZTFFUi82ZUhl?=
 =?utf-8?B?LzZMenZlWHozZTJJOCt6Nk5YZitEK2duRnB6Vzh0QklvRmMwSmVMYWJVVVI3?=
 =?utf-8?B?VUtocWpYYmtvdGVMaUtMYTZlbjFaMkh1RDdxci9YazR5QXlIV3VscWZDSUxE?=
 =?utf-8?B?c25ZNEVySHVKZ21lTDdSandKOU5NVmQvTzBTM2dnRFVyYjZWbEZNZUJRYVh1?=
 =?utf-8?B?TzFjWlJvRUlUWE9FaGduQVBoSVViTlEyS0luY2NmNWdzRDB0R0FRV3JtRFhM?=
 =?utf-8?B?eTE2WkZFVDhPUStaL3c3ZTZDL05Kc2FsZzJRYXl2d3ZkaW4wQjBOaDRoeTJD?=
 =?utf-8?B?SU1KYzZvYUhzUFUxN2t1YktMK3NCT0R0c2NEVkNxYWI1QWFqRjdyWGJ0QXFs?=
 =?utf-8?B?TkRNRTN5d29pRlFKckM0cmozMmZJQ1JIeCs5MHNlTDhsU3IzQmh4M3RybHh5?=
 =?utf-8?B?R3liVGxuWWtVbmVZTTNBTmNnTkw0VkowWkkvYnpNWlBqMG9yVUtTUUNEdHRZ?=
 =?utf-8?B?R2JrR3QxcXJSSlQ1U1RzVTZoZktrZmI5cnlkc0hONldIbEpDR3NBNzN5SjY0?=
 =?utf-8?B?YnNJcmFyOUFTUnVvcEFmME5JTmk4dlNDNG9ySXFGMzFHd1lBekZTL2NDR0pl?=
 =?utf-8?B?dXh6VGdUSDNVYjkreUkvZkg2Zm8xckpRYTczcDdtQ3N5a1UvdUc0d05BZVhr?=
 =?utf-8?B?QUJFcUpNY2NETzhFcU1iaU1VZ1czdEZ5ZXZnTkRpc2ZNb1RoclBlUWNtZzh5?=
 =?utf-8?B?Q2orNUpOQlo3eXRhSmdEZE1jc1QxTkJuK0RZcERHeEFyb3Z5UGY0ME8wWFE0?=
 =?utf-8?B?S1N2OWttdG84dkRVWmFTV1VxUStzMEIzaGp1Ti95dUlaeStaZmdyTEVNd1Jp?=
 =?utf-8?B?bnNuSWhoK0tCU2F5eHFOVFZIRFBwOGc1MWxyaG5OWDB6Z05Xa003d3ZCM1Rj?=
 =?utf-8?B?SHl5RG9kejRSTzJaVGZJNnBtNk5mTUVXbFIrdUt2YmtzUlhzSDZneXI0YURx?=
 =?utf-8?B?cFhCcmZ4TjNrOEowVk5TbmJRS3hGK3ZIdGR5am1XK3d2NDByNk9HTU9tcEJl?=
 =?utf-8?B?NDRFMG1SLzFNSlgyanNCZjRJMXFhUHlEUHlVcTI3QXJUUVBtaUpTdVE1bExu?=
 =?utf-8?B?dHhqVVQybnhtdjlGV1NKellYd3ZLWDVXZXpQVTlFb0xaTjNCUmV4Z2I3ZzZ6?=
 =?utf-8?B?VGEwSlJ6WU1jbDlPRzYyT2xCK3p1Sit3TnZVU2J3Q1Exc1FBN2lISHlLTndt?=
 =?utf-8?B?ME1Fa3loUHhxZnNPdlZCcTFsU0x0cElONlR0TSt4V1hTdFR2UVpCUlZoUUdh?=
 =?utf-8?B?Y2IzT2M3RHlZRVFtUWxwajltUjJpSFJsdnQwYUlxcWR6dXdldGJCZDVSR1NG?=
 =?utf-8?B?bHlzaUplMXQ3U3Z0Y1YwZm8yalAxY1dKcnUzZVBxVVl3eHUrclhEeDlQS0pE?=
 =?utf-8?B?c1QrNUtjR0tINWQ0c0JjRkF0bndGNXV4cE80UHVqak9Xa3FaRGtjVlpRRE5n?=
 =?utf-8?B?aGMvYnQzSEk2MWFFN3kwQjh2a0JrenljaEIzcUhFc2RGOENKK2VSRlJqQThG?=
 =?utf-8?B?WkxpZkJqWEtVdWQ0VGgyVng2RGthOE1vQlJVNDMzZHA1c21FR2wrVmJXWnZK?=
 =?utf-8?Q?sK1rwxQ0SCdCheQF7DJKl7DUC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840f51cb-42f1-46b0-18ce-08dd5bab5cd6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 06:02:51.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbx/caJEskBTOOelNMejZ1VC6iDJerEgSdcp8GQkAeT2DP7FJuHxuEHtLZzIliHnDEmQWar7SvhNZKEtAzKtew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591



On 3/4/2025 10:29 PM, Sean Christopherson wrote:
> On Tue, Mar 04, 2025, David Hildenbrand wrote:
>> On 04.03.25 16:30, Sean Christopherson wrote:
>>> On Tue, Mar 04, 2025, Ackerley Tng wrote:
>>>> Vlastimil Babka <vbabka@suse.cz> writes:
>>>>>> struct shared_policy should be stored on the inode rather than the file,
>>>>>> since the memory policy is a property of the memory (struct inode),
>>>>>> rather than a property of how the memory is used for a given VM (struct
>>>>>> file).
>>>>>
>>>>> That makes sense. AFAICS shmem also uses inodes to store policy.
>>>>>
>>>>>> When the shared_policy is stored on the inode, intra-host migration [1]
>>>>>> will work correctly, since the while the inode will be transferred from
>>>>>> one VM (struct kvm) to another, the file (a VM's view/bindings of the
>>>>>> memory) will be recreated for the new VM.
>>>>>>
>>>>>> I'm thinking of having a patch like this [2] to introduce inodes.
>>>>>
>>>>> shmem has it easier by already having inodes
>>>>>
>>>>>> With this, we shouldn't need to pass file pointers instead of inode
>>>>>> pointers.
>>>>>
>>>>> Any downsides, besides more work needed? Or is it feasible to do it using
>>>>> files now and convert to inodes later?
>>>>>
>>>>> Feels like something that must have been discussed already, but I don't
>>>>> recall specifics.
>>>>
>>>> Here's where Sean described file vs inode: "The inode is effectively the
>>>> raw underlying physical storage, while the file is the VM's view of that
>>>> storage." [1].
>>>>
>>>> I guess you're right that for now there is little distinction between
>>>> file and inode and using file should be feasible, but I feel that this
>>>> dilutes the original intent.
>>>
>>> Hmm, and using the file would be actively problematic at some point.  One could
>>> argue that NUMA policy is property of the VM accessing the memory, i.e. that two
>>> VMs mapping the same guest_memfd could want different policies.  But in practice,
>>> that would allow for conflicting requirements, e.g. different policies in each
>>> VM for the same chunk of memory, and would likely lead to surprising behavior due
>>> to having to manually do mbind() for every VM/file view.
>>
>> I think that's the same behavior with shmem? I mean, if you have two people
>> asking for different things for the same MAP_SHARE file range, surprises are
>> unavoidable.
> 
> Yeah, I was specifically thinking of the case where a secondary mapping doesn't
> do mbind() at all, e.g. could end up effectively polluting guest_memfd with "bad"
> allocations.

Thank you for the feedback.
I agree that storing the policy in the inode is the correct approach, as it aligns
with shmem's behavior. I now understand that keeping the policy in file-private data
could lead to surprising behavior, especially with multiple VMs mapping the same
guest_memfd.

The inode-based approach also makes sense from a long-term perspective, especially
with upcoming restricted mapping support. I'll pick the Ackerley's patch[1] to add
support for gmem inodes. With this patch, it does not seem overly complex to
implement to policy storage in inodes.

I'll test this approach and submit a revised patch shortly.

[1] https://lore.kernel.org/all/d1940d466fc69472c8b6dda95df2e0522b2d8744.1726009989.git.ackerleytng@google.com/

Thanks,
Shivank

