Return-Path: <linux-fsdevel+bounces-68774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00BC65ECF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id AFCA8293BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A21F335570;
	Mon, 17 Nov 2025 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rqzVMbP/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hJPqAlwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA825A354;
	Mon, 17 Nov 2025 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407080; cv=fail; b=fmXYVAdid5qj0u8Ml1QZDMao7l3E/8R9o6V9GmzD8ZJZl9r7f+LO8RiiMQyOoIELk3wJTIKfzsrbCuRUFTcgmmvl7w+UVjB3mDLq9AOtbYkNLT2Z7HSD1k3sxP7PoN9L7UwOfJWJPgpkFixfRz6lrdxzcGHv6Nc2c3WVny+swy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407080; c=relaxed/simple;
	bh=A5UWMhFtSNlgwF8LwdjZAIvukHBSxIqybuMUgyDkEGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K0+PbSga6uy7Cp8cojo50ZSAnQ+oKrsiPyozKP2DUiczjGs6Ge90op8G4dIjkfoJO3EO1CMz15jQnwR+5K5Z/Tdlq6wq/5ePFcePWkqlMIt73wcZtWeVIUScWwDNjjiACLxR3oGYMU+CU+cLsExkW5lHZXxddLeN/bKmBI8VMug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rqzVMbP/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hJPqAlwq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8MWU024561;
	Mon, 17 Nov 2025 19:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HWc7PT1DguwU5ACP3wNcurzbNTfsn9qHlqEFYOvMMiA=; b=
	rqzVMbP/WvsM30tjMwYlIHCpcMWuzi3uRl4eSlSQ0s6a3VwmNUMq8KayOfdWXXnG
	Brdrszc8H82gnPGUIaYkV+pMMqAR1TW4gdk8uagfvpRXE+g0Yq9Chy5GkeoqaXZa
	+wxTu8Q5ibFzRzLJ9rYRaTe+CwUJlyqdTJJvoDOJhJ72x+DsOUX2nA3v7yHKTZDD
	wPRHIYDlIIzGCqQDR8KjVbS9bADQQDHuYaHYxXHD2x8cubqfMtI2IwAeBOdHHPQJ
	LP2qa3iMAf5c5j8RXZ1fiqUDDxnN3tgh8BcB+zbSMrXgIALHZYpzjCLBokRmZlm6
	hk4q/aINyT2+7P1w6nvbfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbb8nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 19:17:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHHfenf007971;
	Mon, 17 Nov 2025 19:17:35 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy83s4k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 19:17:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7IR/i7y3Y/7EjzdDfIb3Ir0RXP1pzoVcQEI1p95i/P+JKbYE70Fxdwx6L613JJhjqX3Tea/auJGFjW2BLc+IbwmNz5GDLR/1mnHpR35J7DBbs9IK7w79jJOychJ9A0jIVFFYaABWeFXh4UAVhU9HB9xJCFjzA1XcrdI9+MJgA/SMIBYAjkw0GARagxHzobo/okVlxnYcUPKEL+Rtjqs4oOQ6HItCPuY66Chs6wfr8EHdmtj/N7jbhMV/rcy1BrY0zhzA7bWKcL4+w6bGsioHMbuYTGDWmfgQ3ptFjwG3PkdWdICDceMZnl7JgPWH1Xx55OxwGiuidljtkLE3sX3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWc7PT1DguwU5ACP3wNcurzbNTfsn9qHlqEFYOvMMiA=;
 b=Y2FxsjlEuOQf9Oe6MTgmv/dm4xeBWc02mDkxV1Yxv4Y8VAis6/f/ITc/Mrz3stQFGqAxRZkUdr87KJVk9g8TpsyGXR1NIZsvlJ/8pXzXUjEWtjG+wyfj+o8vM/JCL1dYCLRvyvnnLWHDzHh6XU1WUmahl47Eg1UKv0mTKmtVxQ9cm0TfYYLO82b0/1wsPGvXtLeB2NzqcPyCcSK3sUFnizqlZZTC8JDhMoqQduLIdTZPcLNpUEBnIte4XXL3ksyRX2NuoD1NcY/Berg53Tk+Av4hB1FpgQcz0QIuaaBqQB6eTuZw/sDntZtD5gvaSNHZL62bttD7zpY+MFfpwARjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWc7PT1DguwU5ACP3wNcurzbNTfsn9qHlqEFYOvMMiA=;
 b=hJPqAlwqQtTFCaXZ0vp2bDje4QKhj7BwayQQsIRQd1xZ+zZxlfeJTAEqg9alG4Z72BlgGwxUTJ7jb0iLY47fxxwuUbk0PklliGw2ixc6F2LNZS6DgWM2qHo1YBT5oUyX5iUgN571ov4g4TakUJeZbUFWnyz0eU9bpO8en//2y5U=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SA2PR10MB4713.namprd10.prod.outlook.com (2603:10b6:806:11d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 19:17:31 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 19:17:29 +0000
Message-ID: <b8b8a47c-90ee-4044-9b73-4d3c3f84d39f@oracle.com>
Date: Mon, 17 Nov 2025 11:17:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] locks: Introduce lm_breaker_timedout operation to
 lease_manager_operations
To: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-2-dai.ngo@oracle.com>
 <15c4b1c4-ac3b-4aa3-9561-129394f26a58@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <15c4b1c4-ac3b-4aa3-9561-129394f26a58@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:510:2da::23) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SA2PR10MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: 1914efd5-3a77-4444-cce2-08de260df37f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SGxWWC9vcnVUSS9PdVV2blIwYmxuSEtkM050NjVsNjV6dlVhVXNQNkhVUmd1?=
 =?utf-8?B?eG8xcXp3am1EVFVnU3FXU095WTFGUWdWelZtd2xmOTl1eE8weUFQdFlGWStw?=
 =?utf-8?B?bnE5QythOTNLRUVEVWtmcXNEUGNLSWJmWno4cVNkSWw5OGpxTHFvSndQZXYv?=
 =?utf-8?B?UmJDU3hTeGZQZXptOEZ1OWJUSnoxYXh4Q1ZXaURxa0lJUisyb3o0d3REcUFz?=
 =?utf-8?B?MHBUWDFMNG9Vb2d3c1VFWEFqUEVlOWpVVjJOZDAxUURWNkVFLytHdGFYNWd5?=
 =?utf-8?B?bU16OTJCeVBxQStVQnJGQlBqNFdFc3pYRzZVWUpXQWRzTktIOXZka2VKN0Ez?=
 =?utf-8?B?ZGpPNlllcTFJR2k3K09TRzR5N0oweklrdm5HbUlVcG5hYXFvUEppVFNpM0Ja?=
 =?utf-8?B?Zll1R0ZNSkw4WjFrYms5OFFjSnRsZ2ZRQ0lUTDM3YUl0dXNUZkp0Z2VyVUgr?=
 =?utf-8?B?ejBtNzh1QXhTK3NkcFZWZWtmbEphWENIZjNXRU5BNzF5REJUL3FxMCtNV2dl?=
 =?utf-8?B?eHcyQ0xZY1pUK0g4UGVOaFY4TnBUdFFMV2RjOTI2a2pkdE94WEFzZ3FXNWFU?=
 =?utf-8?B?U3ZSWDdxL3E4QzFWM0hZRkxNYktMVUNwanBQWDB3RWZOb1VFYkVWSkI3N3VJ?=
 =?utf-8?B?MEo4ODhjbnBDMTJ1aEdKb1N6VC9IYmZqTFJQc3FEWCtmeFd3b3RyUWtBVG5K?=
 =?utf-8?B?ejF2UnFoYThKK0FoWGdla095MnZFajg1SUJvd3RudGdxZVNPK2xMNVhBbVdI?=
 =?utf-8?B?b21USmFQdmFaWVhCNkhvWEdHVUJPMWRMcUtMaE1vVXdCenhOelU3aklzemZT?=
 =?utf-8?B?ak9McEV3N0xFbTR1ZS9mS2VheTJsdEpOY2pxdnJ5SGVjYko3ZFl2THBHbnRD?=
 =?utf-8?B?V1ZSbnBRaUZSTHI1T2Zsbk10eE5nNVd3Y1VKaXhhKzNndS8zY0cyWHczUUlr?=
 =?utf-8?B?OGVHbVkxaE01U2l0aHdWLzViNmJMbUR2alJyVjFtOHRyKzJkcUZIVm95UTdh?=
 =?utf-8?B?MDFsU2g0elMva3YwMndVMmhVNkoraVRmVzROSHRjdWhvR29BYythOHRHVENn?=
 =?utf-8?B?ajgxNlhXenZraTFnbWZ4UFFINU5ycXdib0Y0OFQ4M1cvRW1CWTBMWlBNY2hq?=
 =?utf-8?B?U0pNUFpTdml2cm5hWUVmeU5BRUJOWG5LVlNHVEdxdUxBekQrOFNRZU9zWm1m?=
 =?utf-8?B?SmF5VnZzQlNIWXJjdlUyREcxckhySEFZNVZyb1FxTWZ0SCt6YVBCSk81eS90?=
 =?utf-8?B?MktpdmRGY3FHUWY0Q0JQK2Z6RDNKM3ZvWFp1V2J0WHRsbFUxb3J0TWgyTXRl?=
 =?utf-8?B?UnlMZWhuQVpuVXNzVURQTlhJa2puTG9rM0N6VnIyZ1ZPdW5NNGZ6VW1IbExW?=
 =?utf-8?B?aThMVWVNQmR0MGJzUXFCYk52aE1YU3BrWFQvSUFrQThRd1RodGhJdld4RUlH?=
 =?utf-8?B?MjZIZ3NwWFVBMDhtSzJSZjI2M2ZBNlhVeGJIVXFnckVmaXg2cHBCK01SM0M0?=
 =?utf-8?B?MWhmNnNYT1JNRWVPRW1LWVB2Vk9XMXByTjlGcHlYbGliSEJjN0tCQi9LckJH?=
 =?utf-8?B?Y0Z6YWtBZ2Q5QkpCYk5BaWNNTi9KRXo5bjBDVEczZ0pDRDdDclNWY3FTcFNj?=
 =?utf-8?B?QW5lQ0ljdm9HSkluR3BxTEVoakVYdG4wN0RaMzIxb1BvL0tFc2xjNWJxcU5K?=
 =?utf-8?B?cS9jd2w3WmhyM21pbUxXRWI2eHJNV2J1Qlhod3NQOXhrTDdxUmhOaW8rNVZ0?=
 =?utf-8?B?VFNnRmJzREhjWjBqL2l2WDdSWDY3SDdEUFh3dHhSS3REcWJ6Q2dsZDdTNEdj?=
 =?utf-8?B?ajZKQXh0ZFpPcG9xK0JhbnFEQjlSdDQ4ODZwaVJzbFlyWjM2Z0pRbnNsVUJ0?=
 =?utf-8?B?eStoMU5xUFVqVjhYUmw0akxVejQ0bjF2cERsMjhxYjE4d3BIY3NONko0ZDFF?=
 =?utf-8?B?d3dLdERCZU9MWnJ6bndXWXN5WW00V0lacTllTk85MmE5NXRmMmNFZzVKaWJS?=
 =?utf-8?Q?nrpY1PGnSsvuCJe6ReYd28zNSGIAYY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bmNDZy9meWRXQWpwbHplcXZaSGFTZG94RExtdjhDcXJQTUtsSXhwMHl1dG9v?=
 =?utf-8?B?NlNyTVFyM1htUlJaTWdnZXJEdjRkUUxJN00zNGxIN3JORUNLSXNKRFBrOUFm?=
 =?utf-8?B?SW13NkVKVldBUGp6eEFvOGdKczZCN0VzNHpJSi9BWGJjekt6ZmdJQmEzQUxj?=
 =?utf-8?B?bFFqU1B6bHZkTkQySkNnSEwrRytuclJoaFdOZlZXbGh5TENFMDNvZjlIZnU1?=
 =?utf-8?B?dkczV0VKYXB6eUpab0dxM2dxYnNKcC9rNndaVjh4Rkx4ZnZVV1hLeWMvOWhU?=
 =?utf-8?B?Q2UrN212eWl0c1M1eVFtdjVMcXBBZlY4WVN6cElQcVc5cXdPcXgzUWxWYjBM?=
 =?utf-8?B?cWVYNXMvcHlOMzNjNEJOUld1N2tMNStWQVIvSmFzQk02OGVlSng3RFg3cGt2?=
 =?utf-8?B?Wkc1Z2N3UFJFSU9acEFtN3ZuaVYzYTA3bytsYVNKU25XSXR3cDhiTFI1WjFD?=
 =?utf-8?B?cTN0cFpIS1VxbFpueGJ2bHFrdWZIZTVsSUV6eW5oUlNDSFdrUHIwdUg2cm9h?=
 =?utf-8?B?OTA2WmVTc3FEdHdZaittdEhWSSs1OTlyV3JGb1VVRmhsRGpwaGZNbFNkTDVa?=
 =?utf-8?B?L05abVY5REtHVWVyZ2NyVUVzaVBZQ0ZTZlFLTC9OZGREOHlVZ21EbXdJbmY3?=
 =?utf-8?B?Z0NaQUpRT1JBSU5ESXQvNG1rOVJmR3ZtMEhqc3UxdGNheEJMUUE2R016SnI0?=
 =?utf-8?B?QWpWbndsUGE3VkdBRWZYZlF0dDZlWDI2eVFZSTZSY1ZXYmMxYnppRzRvYzB5?=
 =?utf-8?B?ems4QWpub2xZSEI3SkJXZ0JXZEdselpSODJudXhlSUhPM3UwOXh5cUM4V0Ev?=
 =?utf-8?B?Qm93dFlTM0tkbWZoSU9jUVFCSGx1TGg2MGd5dDZyQkdxbEdLRVUyZzFSUnpm?=
 =?utf-8?B?Ry9CTURiUDdUTmw1V2JUTXZJMk9tMTJWcEN1KzRHSzk2NnRkRW9ETHhvRzRz?=
 =?utf-8?B?Y3hsUmNkazhEMG1BMTZ1UHlTeFljWEJCdHpUMWFab2JJVEZrbHdOLzZPN1Vu?=
 =?utf-8?B?TzVmR3dqYzQvbmJ2YXRzdnpEbVowTnV6ekNHSm4ycG0vZFhIOUF3aldJK2o1?=
 =?utf-8?B?THF3N0FyNjBLWDBCNHRmc3VwMWZPbWpnUUlCQk5SSFZ4TzM1MGFSZ2hTR1E4?=
 =?utf-8?B?dnpteHNxN01OMGxtS2g0QWNRRzFYeG8xYWdlVTJvMUFabjhGOW9PbjErUDM3?=
 =?utf-8?B?ZmVQY1RHZ25tSlY3akNYcVpudHZDMllxUnlRUjRuSkRMUTdUTEFweUxHWitK?=
 =?utf-8?B?bzRCSndWUkdya0JRZCtsRGxXVytVKys5OGRSSU9LOGZXNGVvRG9pZHppRkk2?=
 =?utf-8?B?bXNzWWpEdURrMFlHcmY2Ty82OWZnUGRaQk1naUNuT251M2FaUlN2Y2wza2VW?=
 =?utf-8?B?aUhYVDhaWXV6cWUveTV0c3FuRE1BWlIrL2x2ZG5JU0p6SUdPZ3NobmNiVklK?=
 =?utf-8?B?SC90YU1CcGRBSEwwejRRTkZKSDAzOFZ1cWVkUHE4WWhGeXFTRm85TXBWNElo?=
 =?utf-8?B?ZHgrM2VuZTg0b3ozNUY0RTk0UXZ2NHB1MzFReXAvdWlLWlJXUGhjczJhVWFi?=
 =?utf-8?B?UHB3ZmtXVzZVRWJLV1owck9sUzh5eFBxbmZYQVhMZ3I3dU51NTdpdUIzeHF5?=
 =?utf-8?B?Z0hMVEs0bkUxYjhWZmt1OGk4V2c2S2xEOFpCSWtvMTJKaDFoQlNZL3RWb3Qv?=
 =?utf-8?B?dms3cExER25zODJIcTB0QzNyRTBwZmpDMUg1RjJzTGtVQk8zcjNpeE5oMlFl?=
 =?utf-8?B?MitYQUxGaXc1RWF6QXBUSjRrL0xpdTBoK3l6b0dzMGVOdURwWEtUTW82K0pw?=
 =?utf-8?B?THRGT216V2dmQ3VOdWtoMWkrRk01d3VSSmVFNG9KdG9HOSt2UWc4SlVVaXVk?=
 =?utf-8?B?MXF2UGZuWE5vM3F1WVRQTkF4R3BtVFdteDlmTjVaTjdwYm00TUw2QlBCZ1Fz?=
 =?utf-8?B?RE82bE1kcmZWQi9RNGdTdXJBU2lpREZBUDZxcDVKZXFPU2xabmFTREh6Z1Bw?=
 =?utf-8?B?aHJ3S0Z5NWljb0ttdFZPeGM4YUZHeTU1TGtMenlWZDkxTHZTaCtjci82aHZ5?=
 =?utf-8?B?b0xvN0NleUVWKzVGSTJpZGtqbmxYR1REN2lQUnhrQ2R5eExDb1pRNGVSRzh6?=
 =?utf-8?Q?GYxtYK4aS2UAGD9qXCnF6414Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wrm8ObZGryKZR+XexEbIlHSK0yY8/Dd4JZ/ZHuik0XdD6o7Lv/mxEUaCMgQXw/CAbT4eZk4SwScSwvhzkHIQ0cqdpFncLkxCM2RcSmSENRHX2KCYRnr4GhbVLbWY+zGY8S4hTGg+cbad3KDc2Rm0fyZEu/o6w8qCCoLROCwMFm6VeAiN029Km8qm63toQzNmB60mz9ZMBjeSaxHjmBDpphOdHGv1tNiFBUfyBifXiw6LC4MAqkYcdeN6nS7RXXqaxYTLfqZGN+aIzxQl1NG9zALhLFv5na2rMLWIwKQiyMj8hhSXLVCXNg9O3ASWGa/HthvKThy4fZY3MqyCFXhHzGwa7sfJAZssOKNiDbKdCmtxn6ofH7CaMI8lsGt7Ul2iPh9ka9bLyJNSJw8toor4A+N+T2hQubySGbn3veXr1OLfOOIOCWtoFVy5brsYVZqj5UWSvnjyYXO2NjTBRXGsXhJqTnIYm0NcZLspEnjKUkPvhFUUyWOAbm9z8r7FWtPqUaMZLz7Q4fQev/D38KWfGX7+aAdeNEMlHxMuTM0kNJ/EZ8ZvCSFIIFcHSOWP4/ZGzLLEgh7CO8qLImAlDaR+zj5o0P0q/131f+xiBh632Tw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1914efd5-3a77-4444-cce2-08de260df37f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 19:17:29.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn1wOFY8/3Xw+c3bCNxP1/D6xFraL6f3n+JxLJOmJHp1P6ymzjxhR5qQgF7woYVxOcGujQHWUpPvNT7RpeUxKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170163
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691b74d0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=grT7DhH8jXld3jkzG9EA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 9pwKSWnxnFEwYgvC-x_QFJGylRfaITkV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXzxv7xLx/HwKv
 0et7gYFuxQ/KpNythk9vMP/OP+5AKOvtKxIJ1qgjMYdcjMx0TY+TXAMmdUONTTXXHRWdZjQo3Sk
 J3zeKZK0VhowKS1Jy4j0H1udcwuxLYSWJuR/TUEwKID/2Wqm/qaUdtAYBoRQFLJlO4WR5ARAvYR
 LOkFqBkdsfOKIbwI8/xFcDw4AITzZNGvEL+TsekqJv4UMm6r1OuVIivLv03aYdYo7a1uvestz9R
 ey3MF07RowifSYekI6mxSSFJkAkvy4rltKRicxZCriIcPE19YYEDzFYmiBLVSzqY/HU1K2iikfO
 dc+srgIHn7TQ4+Lc9T7ue+0r/WgL3e3jrpTDyGEn20EaHRUxBBTe7DKbDI80hRxdlIJVTsWyZLM
 3jpBAB/an84YvXc39J5pq6Su9uODHQ==
X-Proofpoint-GUID: 9pwKSWnxnFEwYgvC-x_QFJGylRfaITkV


On 11/17/25 7:39 AM, Chuck Lever wrote:
> On 11/15/25 2:16 PM, Dai Ngo wrote:
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 04a3f0e20724..1f254e0cd398 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -369,9 +369,15 @@ locks_dispose_list(struct list_head *dispose)
>>   	while (!list_empty(dispose)) {
>>   		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>   		list_del_init(&flc->flc_list);
>> -		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
>> +		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
> Nit: scripts/checkpatch.pl wants to see spaces around the pipe
> characters.

will fix in v5.

>
>
>> +			if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
>> +				struct file_lease *fl = file_lease(flc);
>> +
>> +				if (fl->fl_lmops->lm_breaker_timedout)
>
> Let's make this:
>
> 			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)

will fix in v5.

>
>
>> +					fl->fl_lmops->lm_breaker_timedout(fl);
>> +			}
>>   			locks_free_lease(file_lease(flc));
>> -		else
>> +		} else
>>   			locks_free_lock(file_lock(flc));
>>   	}
>>   }
>

