Return-Path: <linux-fsdevel+bounces-59975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6760B3FD9C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 13:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6340E4E2F02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0350A2F7465;
	Tue,  2 Sep 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="W9SGAOTZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013035.outbound.protection.outlook.com [52.101.127.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F5274FCB;
	Tue,  2 Sep 2025 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811974; cv=fail; b=GewiBAHfonhbE7wIhYfydkde6xZxoX0IGPzIZTEn+4Hofh9j4LDCrD6R/6pLR/HEOt2c5wlAW/JF24p2T4GjDm3oNb0q6rQHsqyIefHnBHxxiQagaqKrorzLpbqWbxB8N+sIXpqwwzZIC9pmQ/flvtR39CmPT1LT8vFS45XJKlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811974; c=relaxed/simple;
	bh=YlYg36Ei4z5nsOHbt6QGNFtBb4IwYFJA2xqdF1nOlcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bKaWRL+ST2UXx7+NWiIFCclu+YjXEuFw0GUm0QCtxs+JuB9p+uAKiYVfROJ2Fh7KyjDKrHbljrh7u7x6h+KQ/XhOcwklznVdP7ez/4K0CGYG0GY4iA/5xTCkRzoB+sCFDbYIMZnKXYWtaGixvpAiVJIXOPSMuyrPhm+GYjK9kpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=W9SGAOTZ; arc=fail smtp.client-ip=52.101.127.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZMVkY3otbARFWydeWlDxuPJ/RcTOrAIPXkzjezxYNit1whzLPIsodxenmMUXLjaIXV54Asnzx7/bIp307cc3jh2kInnTNJrGiLbCbslVQgPJ3dGeXNhB6F/ai9jxuTcGTzwujq3btEtwSM4Ua5kLBZmu6epMF8JxZQ8pfDB+5yBgSxGyrWD/IdkY0KIStv+c6aChwGFnPTpNWOeoJXtxJyhJrnS0ga2HwLmlVqAPiBdIRn5bVWUtWU8LgxoOvw4Td6Xt11Islk49oaSUOzqZ6E/GECqymimVxZe12rxdYFp3S2r/qD0GzG/867Rcy/YczUZUbukrN6mIRe0P/IJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZtxj5bUZg7WerKs5BrVIMvoRWBEWXvF8WL4ZmhkJJc=;
 b=tOtEVczUYOaFU3KvWo8nPlD+eGDTxqKJjg0CMU7ttZGbvn1dt+aIjQF71tFvP4vzb8/tiKHl20TEm+CdxjSpKsXFkzvbLzj6miRD0Pbzys81+ZjmxvAZpnRmGlZ4fdLUEkaeFqzFI7V0CcpIylmWZgdY/p3aBX4vUKuPxbGP66pFyRskzk7J8cWudAdWgtdTrPGV2Qfkwe8QS3QObhhf9z2abgsiHTk6wnOKKp9gDty4LI2L8TprssAtUIJaFyyw43hymc9Ri+a1LNZ3JUEB6LZnFpzyFkpsvvIYxOzq5d+uBgvtCH81cnahMTOIh4AJtiO+zbSnR2Rydg+PJ2iEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZtxj5bUZg7WerKs5BrVIMvoRWBEWXvF8WL4ZmhkJJc=;
 b=W9SGAOTZyt5P9/VQGU1nfZS5MsrViypJNgZ+irfXqts1/KR8sQpSQvYW0mVyQoNipEKicLDmuCzlbnnz+lSx0tvGdLzDFeHuyJcM/0eSLDqmPdCLZ7TzJZeNWNEK7FaJl01rbxT9p8obz3dhyAif+9Jt05gJzqJ00akwS7BI0bsd6DL/qebD5q8YVZ6Am0G8fVEJl7g62iD/ofnJItBKrr+20GR5JL5EOe+9zBk39yv6AW/kmHipWwgWNolNZIzEvhGCCe0s8cWNqpkKblDEf3w+QBNbWNz/qpJIaHHXD/LM3gi5dMFBsnfoyRpArwsKeaydBpG5XJYJTvtH2I3e5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SE3PR06MB7957.apcprd06.prod.outlook.com (2603:1096:101:2e4::9)
 by SEZPR06MB6611.apcprd06.prod.outlook.com (2603:1096:101:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 11:19:28 +0000
Received: from SE3PR06MB7957.apcprd06.prod.outlook.com
 ([fe80::388b:158a:e14b:79c4]) by SE3PR06MB7957.apcprd06.prod.outlook.com
 ([fe80::388b:158a:e14b:79c4%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:19:28 +0000
Message-ID: <275322fe-b8d7-4081-80cf-926874286ea9@vivo.com>
Date: Tue, 2 Sep 2025 19:19:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] writeback: add sysfs to config the number of writeback
 contexts
To: Kundan Kumar <kundan.kumar@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT - MISC" <linux-mm@kvack.org>,
 "open list:PAGE CACHE" <linux-fsdevel@vger.kernel.org>
Cc: anuj20.g@samsung.com, hch@lst.de, bernd@bsbernd.com, djwong@kernel.org,
 jack@suse.cz, opensource.kernel@vivo.com
References: <CGME20250825123009epcas5p1573496e2cad2f58d22036493e5af03be@epcas5p1.samsung.com>
 <20250825122931.13037-1-wangyufei@vivo.com>
 <77291508-cd85-4889-8502-73eb834e543c@samsung.com>
From: wangyufei <wangyufei@vivo.com>
In-Reply-To: <77291508-cd85-4889-8502-73eb834e543c@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::30) To SE3PR06MB7957.apcprd06.prod.outlook.com
 (2603:1096:101:2e4::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR06MB7957:EE_|SEZPR06MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 495cd07d-a23a-44c7-671b-08ddea129450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2krM0NLSkFsTU1GUmlvUnV0YmljeHV1RWRJaFBtRDFPL1htZVhFYjVuMjVT?=
 =?utf-8?B?Y3FSVTVQOStmMm44VUsvK01GYVoxZnJWK2cxNDNxUS83Si9NT0ZNVW9LSHIy?=
 =?utf-8?B?eDJ4SC9xN2l3bnVqcnhBMjlkMVlBRGUwQjNJOG43Z3lQdUpWcVhuS3I2b1Bv?=
 =?utf-8?B?VGhLai9vV0VMTjJHVXZiK2dPZ0ZPdklPbDc3aFBLSWc4WlhBY0lWL3paQ3RW?=
 =?utf-8?B?aDZ3MTgwTXc2RldrZ1BmbkNrVFgramNXS2JHbTVsb1RMZTM2THE0akhicE4w?=
 =?utf-8?B?RlRGMWZ5eW9qaEZ0a1hBRHJOM2sxSGd3aVVua2pVSGFWd2s2RTdFQzBkeGFw?=
 =?utf-8?B?dW83bGdDazUzblBNdnRNVm9DZXEyL3k3eEJlM0liVUdoYlhXc3Q3YkNtL2c4?=
 =?utf-8?B?YWgyYjFsS1FGODJKdzI1UTRJY3NzaFpZK2l5YklBemE2SFEzSHFQelhZL1I2?=
 =?utf-8?B?d3ptQUFweExiZGwvbGhWRmlLM0J2R1N6V3RUaElUZ0h3blYwOWp5S2dXMlN1?=
 =?utf-8?B?YUhETWMxdG5JbTNoaVgvc2dmZmQ1bWwydFo1NWJKYXVONkxpWVg3MGRtWDVx?=
 =?utf-8?B?S1psM3ZwRmE3Rk1IZWZHd29xQzdPaVpYdW42dlROazVKQTJTeTVMNy9GeG9q?=
 =?utf-8?B?V3BvaWdIWFo5WWVlMUhxdHRKNGVwa2prT2N1azI4QWhsY2ZkMU5YS1llUElv?=
 =?utf-8?B?MWJRcUd3clpZdC94b1V3Q2VUVy9USThtUFRqVWdrNVF0c1IxWTI0bElUT1hO?=
 =?utf-8?B?ekxoMkRENVpyNXlyRldwU2w0NmJWV3dETWtRaWk0ZUMzakVFbTlVcG45RjdU?=
 =?utf-8?B?dkdTeC9POUdTbVFVbWxibDRqNXJiYmRVQUNWZGpVNHl1RTBMZURWRXpUbVJr?=
 =?utf-8?B?bndMdVU3bWI0ejUrdmw0TE5HVGpMRHB3eksvTE1TcnZUTmNDcTlWTkprZnlk?=
 =?utf-8?B?M20zT0FhUXMzK0ZqN256Z3BOd0JKWmRXSkZRNEhrZEFTNjJ4UnorSEdyQ2R1?=
 =?utf-8?B?cUg3bHk1ejhBc3JzSXZzbHRPRHdpOHdlU2duanVsdS9KUERjNkxRYlFUalVs?=
 =?utf-8?B?d3E0TUU4ejlSM0hJcnRQVWtKZmVvbk4zODBEa2hhaGdNMzBNRGdoOUZpWlhu?=
 =?utf-8?B?ek0yVncyS1cvZDB5NEpvWHhUM3NYNll5WS94SkJVS0YzVUZ0TXpYbXZyQVFC?=
 =?utf-8?B?SEVLY09pbVJvWnRrcE85clV1Wld1U1lJMnFqSHRFY3RINDJnTTBCOWhaZE4x?=
 =?utf-8?B?QmRod1ozdUQxc3J4TzlyMEw4NC9RQjFUOGs0UU02dGdsS2VwR3F3VS9Dd2ov?=
 =?utf-8?B?OUpVcnZaajM2QjB2emRrd2VSUFRVMG1aV01ySXhHTmUvTnA3bVZZcjNDYmtP?=
 =?utf-8?B?dGoxYjhMQlN0akhJUDRSZ1FzUkpHY1NqQnRaeTFreVBuTnRVY3FNZTJxdzFu?=
 =?utf-8?B?VGNqWmtac1R4em1wMEM4ODA5OTVWMGJ3VnBLNzBuajROK1M0RFY4ajFnMWVr?=
 =?utf-8?B?Mi9Kb1ZSeFZyTEkyM0JlU040OVhhRXR5bXBtZkNUQk5abnZQdUdFL3NWc01B?=
 =?utf-8?B?c3V4WUpUaDduUmxXVVk4Ni80d3RNdzk4TEg0QWF0UVNpS3YyL2oxeHMzbzIr?=
 =?utf-8?B?U0Z2dCtMTDNONjFvNjE5a21uYURhWTIyRk9GRlV2K0NlaWNOY2o4SWRNWW1p?=
 =?utf-8?B?WGF4RFBxZWp4cy9vQkxTVERtU2pURUplSVNLbkE0bnFBL0ljc1ZpeXhPd3U1?=
 =?utf-8?B?U243M2JJVmJ2VEhpdnoxd2lkQU5sSjRUTUdDVVZydTM3OGpYRGtNZjR2emg1?=
 =?utf-8?B?MnAyOUR1UnE4NkNCZ0wwS3Z5bXVBREZRdDd4cUV1ZU93bkJwNzBkOEVZYzNL?=
 =?utf-8?B?NzhIVVo2cnh5SEhvTUYyaE55c21PQ3k3ZW5VTEx6RDl0MDBhQXdsV2ZCamh4?=
 =?utf-8?B?WGRLZEpsNDlCbENaSUQ2cnhlZkRHQzd1bTJlZFJiMWNOQmdUcVZld1lERFVn?=
 =?utf-8?B?di93YTFJeFlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR06MB7957.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnBuNnNwUjZGbVBWMDFld0t4bFFrVmxrRXJFbUFJV0ZubG1ITWQ1SitIeVpl?=
 =?utf-8?B?dzlvTXJGNGZqbERwa0c1Q1d3b2xkaHlQS21jaFhNbTZ3dU4yNFl1cW9KSnR2?=
 =?utf-8?B?VEtzTEhPdnVaVHFpUUMyQWxpQldMOUpNck1JSmVwZWowbDRFUzRocmpGRFNE?=
 =?utf-8?B?YUJ2T1BQMjU2Qmt0NCtWam82TGZoRE5SaW5HTzlPZUFKNEJqQTN0SVAwQzd5?=
 =?utf-8?B?YWttU3locE9SdVNJRUhGM3BCUkk4T1M1b3lwZW1HcldNUFNma2JZbElXRFFp?=
 =?utf-8?B?TmZqL1FGbFdaeHk5K21vMllhR3o2ZnRrNmJBMFdUMzFzdVFjTTQvSU0ySU1u?=
 =?utf-8?B?U0liRU5Ibm5oRExkNDBDaEovZ1lUQzZBdXZCbW9Mc3F4eUQxOHRhUnRSTmxl?=
 =?utf-8?B?bW8xWXo4VERZV0ltdDBYZ1k2T2g0dWl5UWdqSkRGUkdGU0FLMGJ5T0tLVkdU?=
 =?utf-8?B?T2RCOWdCQ0oxV3ptcGg1T1lQTUQzeGpoU085QjVrZ3FMdGUvK05ZczNjRHpJ?=
 =?utf-8?B?RWMwdnZvRHhnZzRydzZIK1gzdHNLSkRVL3V3WklUSGhFYjFkeTJSR1V0TjJz?=
 =?utf-8?B?Ulp0L2VoZytXeHlZUDQrUmlTZGFENlhNdSttdHpiYmdHMHVsVER6UkpPZ0dx?=
 =?utf-8?B?NE1hMFA0bXlTUDJEVkx2cXgzVTNYeEo3WGR2aUtucXIwN0F6cCtOS3QwU2Jr?=
 =?utf-8?B?Vld4dVQzQUV1Y0ZzQndXcVpkL3NMNGtOSExxUFFoUitwWlJMUldxdk8vYklj?=
 =?utf-8?B?OVVBcTJHUE0rRkg2aGJIY21rVExzZEhOaXRJVWY3RHByU3ozSERpWGxod29R?=
 =?utf-8?B?VUFjdWJmNXRoN0Y1aW1OS05FYVpCSGc2MFdVbXdYNXZGNDNHQUcrQ2xoMmFH?=
 =?utf-8?B?TUMvZjJHUU16bjRrYlZra01HTFo2alFuMUxsNENmNGVBakk1VlJQbFM3QUp0?=
 =?utf-8?B?UHI0QTJTL3R4M3lNOHNVOTdkWUFzdlJncXJzT3U2ZWpndERBVGU1L2YvSU9l?=
 =?utf-8?B?cFNZc2xkeklNTzNMOVA2UUZ3VmxQN0xpSFEwTW9NZ2VGWHV5S1Q5SzY2OUZV?=
 =?utf-8?B?dkZnV3dIbjdHRVJMUUI4TGJWR0xraDBFdit6Z29pT3dIaTl4WS9PamhBWTR0?=
 =?utf-8?B?K0tMSUVveks1RXBzMzF3b3FwUUZLVURLb2FPbEcvMkhtV0x0ZlhBVDIzZjFT?=
 =?utf-8?B?QVdFS0ZnTm00TWlMTTVKUmI1cXc3M21DU1VldVlNdDk0RDFwV3JQblhtL1M1?=
 =?utf-8?B?a01LRnZkU1ZVYnNZYStlU0RUekpiZlRyVkJZSDJMWFFrTWs0WEdpang1MkJZ?=
 =?utf-8?B?R0JFOVpuNEdDVWxoRHJqZ1NTdE1kNXJFRTlwS0lrQ1k1SlFkR3BpN25CWGtI?=
 =?utf-8?B?bUlrRDRjOXFPQjJCalp4WE9TdmdhOG02SVZwN1VSUXJDQnBhcG9Ib1JKTDc5?=
 =?utf-8?B?WWNzNEZIYjJCZVY0dGJDMG5BVzNNQkdWTXhyb0swbHhJRkwyQzJmbjYydWxG?=
 =?utf-8?B?UU01SDhLN2NXUTJOckE3OWVjeUJCRXVEUDUrMjVCYkdCbzJJTjJJK1hmYm9i?=
 =?utf-8?B?RGFHM0VJUVo1cEJBZjNDOEIzVEN3U2JweUJVUEpsQmxRNWppTjd3VE92V04r?=
 =?utf-8?B?VlRZazBXUHB5NXBqR1lyK1dsSm0veThQcmdJRklNbG1WcFF3bVQ5OVBLUy9N?=
 =?utf-8?B?ZmY3NGdSVU5na0RvRGtURjdra0ZZMVJjUU90MVYvMmk0UUk1OHpiSG02OEpZ?=
 =?utf-8?B?TjkyWTJvSGxhRnIycHVTSVcvR25iNG9qSmRwbGlINlJVd0RVajhnOTE2NWxD?=
 =?utf-8?B?TlpIb3VpT1ZQY3Q3bFdwdlFkdUJ6VnNDZXZKcDVVSU16YzVOU3k2V3d3dTZ1?=
 =?utf-8?B?L2QwRnBHT0FlMHZYaVZKelA2ZEhVbk1PZmN1RTVvaHpwWXhqSkNaYmhPdEF3?=
 =?utf-8?B?anJqQnl1VW5yaWFjY3dRUHltb2dQK2FDZDcvUzdDdnQxa3VscDVxdGV6STli?=
 =?utf-8?B?bEd2SnczaGtNOVJHWER6OHdGc3hKQmNza0t1b1NFR2NITlRYR0VTZ0JnOW5L?=
 =?utf-8?B?VnNOQy93eHcxVGt1RGwzSkY1YythdXpXM01paDYxTVBXcTUyM0J0eWRlOElo?=
 =?utf-8?Q?qRHANSdsB5QTBKOaPoB5t9LLU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495cd07d-a23a-44c7-671b-08ddea129450
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB7957.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:19:28.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i49M281qp/0onNqF8jqI/5T5J58UWCTzNSgtg5/EEo2xdyCjGx+F88dZgPcdaH8smq4znDSrMq/4fTha3Rc/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6611


On 8/29/2025 4:59 PM, Kundan Kumar wrote:
> On 8/25/2025 5:59 PM, wangyufei wrote:
>> Hi everyone,
>>
>> We've been interested in this patch about parallelizing writeback [1]
>> and have been following its discussion and development. Our testing in
>> several application scenarios on mobile devices has shown significant
>> performance improvements.
>>
> Hi,
>
> Thanks for sharing this work.
>
> Could you clarify a few details about your test setup?
>
> - Which filesystem did you run these experiments on?
> - What were the specifics of the workload (number of threads, block size,
>     I/O size)?
> - If you are using fio, can you please share the fio command.
> - How much RAM was available on the test system?
> - Can you share the performance improvement numbers you observed?
>
> That would help in understanding the impact of parallel writeback?
Hi Kundan，

Most of the time we tested this patch on mobile devices. The test 
platform setup is shown as below:

- filesystem：F2FS

- system config：
Number of CPUs = 8
System RAM = 11G

- workload & fio：We used the same fio command as mentioned in your patch
fio command line：
fio --directory=/mnt --name=test --bs=4k --iodepth=1024 --rw=randwrite
--ioengine=io_uring --time_based=1 -runtime=60 --numjobs=8 --size=450M
--direct=0  --eta-interval=1 --eta-newline=1 --group_reporting

- Performance gains：
Base F2FS                         ：973 MiB/s
Parallel Writeback F2FS   ：1237 MiB/s (+27%)
>
> I made similar modifications to dynamically configure the number of
> writeback threads in this experimental patch. Refer to patches 14 and 15:
> https://lore.kernel.org/all/20250807045706.2848-1-kundan.kumar@samsung.com/
> The key difference is that this change also enables a reduction in the
> number of writeback threads.
Thanks for sharing the patch. I have a few questions:
- The current approach freezes the filesystem and reallocates all 
writeback_ctx structures. Could this introduce latency? In some cases, I 
think the existing bdi_writeback_ctx structures could be reused instead.
- Are there other use cases for dynamic thread tuning besides 
initialization and testing?
- What methods are used to test the stability of this function?

Finally, I would like to ask if there are any problems to be solved or 
optimization directions worth discussing for the parallelizing 
filesystem writeback?


Thanks，

yufei


