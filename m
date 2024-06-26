Return-Path: <linux-fsdevel+bounces-22518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EC09184D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E46B2B274
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7528188CBC;
	Wed, 26 Jun 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y/U5kWrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FD187569;
	Wed, 26 Jun 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412845; cv=fail; b=KbLQapMY4lHyN5d+I6I/E1ptG0724+5tVwKxq+6fO73wUMJUo7D1NQbZWjg7gwyhxmrTiCZsgjRRW52kmHDDwafmySZ/LpnRQYsSJG/rBkc3LUr2sTIXYkXA8Jj/bJddU6yIqqgd5R0P58kKPmrBF50najf0HkVgmgDGyXgFbfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412845; c=relaxed/simple;
	bh=jSgcGBmK+ItPHukcxOjrg/g3IqMlgK6x+KFC5nemjWs=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=KmCjYV5Hz/IPZKFxHCa/XYRzCISjtQUWKahCBkIfaq9XOVMEtPp2qQLVfOXmVniXrL0KxLOpcWHQelEnCm9Vodb6IOpTmALoAuwdLLzrRTAlu8gFM5NcvJB+OUU33qB28xK3WGXbpVIi+WIBu4vjbAR7B6RIf2oEo9NWVi1Z8oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y/U5kWrZ; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBLrJi9gsAAsgzgpIGoRaAL2dZkl3dWlGhj7Cf0B8EydiTXX1+sc/k76LpHtHSq67Ur+65ActXyiuatw8Cmzm2OUnI2oYOcsXtT+212sNNqFqPFqfvP6bs3HVlRwDn/vrewoQt+2xs2HjxA1c9mStQZ+tnh8FzWiuuzbRsSX2kSiNyE/OCdSo/6f6WPbh0QFa/zvwmiQKq148Hc6YCHNz54errMcxU/GJxfm/JeoOWw62eit2erjuWN/dQgUrLKbw0mKE37kKjDM+t5MRLesQYdmfy3twFhuWhwAKyjJgNBlZnv7XWYECZzaojx1Bjwr5xIVOvor9ViA+WTNxy0nBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSgcGBmK+ItPHukcxOjrg/g3IqMlgK6x+KFC5nemjWs=;
 b=UxZHiTPzJKjTLVK6SXDjkR1HjpeF7GsbGRGe6TSk4MX1h1eQuLavf/JVRe7vLB5ZAe6hnMxxQX8CEluM8ZmoNt8BvVl5baqMkAb1oHlUIKupHmR6luIot9yP5POGpw8sWCJlYKSInUAyd/9KuPwiVEh6RzXtwUptnxk6Vdl1OkX3yTFJP4urwK6WxZz1FiGY/Gj+kKZDnUb6H0zHBBLzNXbsBdN7J46Wiysbfplu9bN6SrLb9tbX6JnyFmJ2JNg9+NApWoGAGSbYeyklN66N1gIJSGAQnKPecJJDRJ5aZJY2eqzr2soIIQlM0OG/mWvuFrJ8fYT+jZ8VwbJ4JNKAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSgcGBmK+ItPHukcxOjrg/g3IqMlgK6x+KFC5nemjWs=;
 b=Y/U5kWrZHEQnlXh2GD+t2Rw9KMYUipZMa6VD8191XtFLJVb1kG7lEWGii5X+a7VlgsUcsSI7FD5uTudwcqVGsXSSUOjQnHz0Sc0vTCzuXhboPViAOq0sCP2t2lQstAvMjARwdJ4AMHVfrRdYyWDr0IwulWpsf1gN1Z6tgLTIMXDRP7Zv6zdjPDkt2H2psv8EBt/W6cCXUrdNQz4c63ati+8JwEXy5Pd2XDjC1qvox+D8rv8GudB+bDXeDne/+KtqeiDbsUouIQA2C134GrEEjHTvdGf+wgHnW+dkMujdubha19auB7CpzNjPDW7S0Itef4lLWeZoKOF8IYrZVaS5LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 14:40:39 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 14:40:39 +0000
Content-Type: multipart/signed;
 boundary=eb0c40cb31ba370eebe74f13d25eb3c948ae94a49ee4a77a58418b08c1e7;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 26 Jun 2024 10:40:37 -0400
Message-Id: <D2A0ZD1AOJDA.3OLNZCHJAXRK8@nvidia.com>
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
Cc: <vbabka@suse.cz>, <svetly.todorov@memverge.com>,
 <ran.xiaokai@zte.com.cn>, <baohua@kernel.org>, <peterx@redhat.com>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, "David Hildenbrand" <david@redhat.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Kefeng Wang"
 <wangkefeng.wang@huawei.com>, "Lance Yang" <ioworker0@gmail.com>, "Barry
 Song" <21cnbao@gmail.com>
To: "Ryan Roberts" <ryan.roberts@arm.com>, "ran xiaokai"
 <ranxiaokai627@163.com>, <akpm@linux-foundation.org>, <willy@infradead.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.17.0
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com>
 <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
 <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com>
In-Reply-To: <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com>
X-ClientProxiedBy: MN2PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:208:160::45) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fa7efb-c588-4da3-6343-08dc95edf2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|7416012|376012|1800799022|366014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXZzRFJkWUFTVFN1RzZJdk0wakdiVWxocCtEUHRRVU5oeURCNG92WGtvOTQx?=
 =?utf-8?B?MXRVWkNoWEhTYXM4eFo4WjZVZTdBMUlsTDVrYlAySW5NOWFaclVxbjFwa0d1?=
 =?utf-8?B?QTFaNmxiY2JsT2pTS25pN2ZEU3llR244NHZaTWcwMm92WjJZeXJXRlp1aGow?=
 =?utf-8?B?eWFwNDdxaXZtWlBuTWh1dXBwdU1neDEzOUd1RTdabmJ5ZTIrM0V4RDhRczVG?=
 =?utf-8?B?QTc4d3VOc0JLVXN1RzNuSFllcWZkSVZBdVNXYU9XMWZqbTdGdGRJSG1qWDEx?=
 =?utf-8?B?ZDVITXpLajNoMk5ZUHNwY1FKdUJibnpLaWMraEpjaFNlR1dXVlpiQktBNXRR?=
 =?utf-8?B?aVl6TlVKMzRRSGE2QS9RM2VCaGVRN1NKRWcwaVhIcUtRVTNlR1VNYmFrSlZM?=
 =?utf-8?B?eXZ2cDRsZWtVR20rU0JHNGxhL3lUT3AwalJvV1BBS3lPQW40ajMyNkEyWUd6?=
 =?utf-8?B?RUo5TVNNRGp1aU1tS3ViZG9tZGRML2cvZUlPdjEyRTdRWStzVElkdmNSaVhh?=
 =?utf-8?B?R20xSHlPeXR2TlA0VHFDTERING9sQkRDbTIxV0RwakVUUFNSeUorS0dpR1VE?=
 =?utf-8?B?Sk0wdDFqT0diZHVXcWE2akRkV3RsejRsQmZCTVZEMjJUNHMzOW5rQmZQNXZl?=
 =?utf-8?B?K2EreHRWN2ZmMHlLQkE0UE51T0UrbDIvclkyMWNDV0Q2bVVSRW9qRDkxZ0Fi?=
 =?utf-8?B?NWRueHExbjdOZjIvVDNsY3V2RFlrNlJ3ZnRZWmRMczZYQ1Z5Z2VLVnE1ZDZs?=
 =?utf-8?B?VWRVTithK2J0M2R3ckFXUE5YVm1GSU85UmJqaHd5Wjg1Z3gyKy8reHhTclNI?=
 =?utf-8?B?b1dEdlVMdzczSzIzOWk3SjNrRlNVaWZyc3BxYjVKMDdDUEJkejdrRXhXVHps?=
 =?utf-8?B?RlJ4UXlNTXNTbkQ2ZGZWRzVCdXhhcTJ1bW5rWUs4dTZBWENFazI3Wm5DckpY?=
 =?utf-8?B?cXNzMHZvb2lCWlM1YmgvS09FNEcxa2hWejJ3TDc3ZmgvV3ZVL05jQ2hzYVZr?=
 =?utf-8?B?VlVqYWxZWjN2QzFwQzJyeDFxQXQzcWh5NU9neHZnc2tYNTRzUUNKWTBWb09L?=
 =?utf-8?B?bjRBWERsNXlqd0EvVGJuc0hKV0doRWh0cFd1ZXZmejlxM0lTYVgyUzgxNUM1?=
 =?utf-8?B?R2x4cTE0Z0l3bkxiTER2WW1hSEhXSHMwRGhGRUVNK3NNY1l2M2E4aDdNTFRS?=
 =?utf-8?B?b0FHamtrT0pnU3JNUUp1TFZvSVFDenpPNUlkKzJUZFJXRmJLd1ZoWnU2WGN5?=
 =?utf-8?B?akMwbGxxQ3pmbDZEMW5hZnN6S1p2N21oaUVUelV1VHdQZ3p2bWd3TlNDc0M5?=
 =?utf-8?B?UXNINVVDV1dVY0pOLzhJMmZLWXdnWHBvVThkUGR2S0t4QVNLS2pLV3VGMVlU?=
 =?utf-8?B?Qmx2OHp2eXVSeE9iRzQ0Y1ZBd2R4UnZ1cTVsbnNVWG5aaWhlY3ZzcVVtazhy?=
 =?utf-8?B?VVArL05OU2o4aC9kb2lNNi9ZTnF5OENZZ0tBRzM1bktTTldoSjN3aHpIODZ6?=
 =?utf-8?B?YnE5REpSeWxFRnhQeVo0d25OWXVMTzRWUnhpTDdvT1ZQcFptRnhTdEtOWG5K?=
 =?utf-8?B?L2J6UGozNzFQL3VEZmk1TnFYbWRoR3NOR25hbnFnRzd4ZnJBNWdyamtVbU1R?=
 =?utf-8?B?VWFzZUxXL2dnM2FIKzIrMUoyem82UUVNV0llWG5razlFcG5EQXhUWlVteTFu?=
 =?utf-8?B?akZlWjQzQldtZzd0UTJhamFhREk4c3FiNW83azJjOEN4NDlGNWlhRkwrbSs3?=
 =?utf-8?B?dXNMWXVjSlVhTkhpMnlwYVRRWExWeU5zMlBCRnJWTHBsaU1WSlN5RVNtT0tP?=
 =?utf-8?B?VFo4TWtLSjI3YjhzcEl6Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(7416012)(376012)(1800799022)(366014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHc1cFVtVDZUN1FkdjFJNTlSYlRJVWJBbFNLSG1VTFlYWUZ0VERlVGpFVzhW?=
 =?utf-8?B?NTd0R1RDVFNodlRKY1M1bnNXa1k0bkdxYkJpWFoxUWNtcys3eGhqZkJqU2tD?=
 =?utf-8?B?VFQvaDNKWUVPaFd0OVcra0NiUS9BbHFrUFZ5akRTek1IdzA0TCtFd2oreUxz?=
 =?utf-8?B?Vzc5aGZRbHFSY3l0Z1BjMHo1WG5NODRjMU1ZNVRrUU8wa2k2RWdFMEEycE1R?=
 =?utf-8?B?WDNhU2c3V3RDSWQvTEgrcDRramErOVQva2k3ZDFrTXpHRjYxMXBCK3hqQkhv?=
 =?utf-8?B?WUNXOXdqY2J2VEdBMWQ3dnFyQ3V6bXc3RUM1dThsZkxqcm0yakdPL0N4Sml2?=
 =?utf-8?B?bCtKWCtrVjFnQ21wTWdXK1NhUnltekZYU3dRY3pvaVV2NW9TSGZNZ01QUkxt?=
 =?utf-8?B?L2JuYjY2Tm9zUTVBb1dKVzNlWGVtOXczRVV3ZGFCM3NjcVMyYWxuZXBXTVBu?=
 =?utf-8?B?VGN5QzQxTWtWSFhLTnBqMVhQckRKU2hyNDNyN0ZaN1drMHdQL2VsKzFVckxy?=
 =?utf-8?B?TU1qVU8wOHpwUStIT1RHY0JXR2FheU5NUUU3b3k5dTk2cThDV0lTenl3L2NQ?=
 =?utf-8?B?andkSFhoRDRyWmNmQTFxeEtiNWwzdGIzNTgrSnFwVEVzei9zWDNqajVSTjh5?=
 =?utf-8?B?OW1uSGxFZ3c0czBNS29lWXhCUDNsN1JpRkFjbzVhYURpSmpOSTh1RHM1MTRZ?=
 =?utf-8?B?UHFLRGVSL20xT1dVRUZxSld2bm5XVjFHWXcrY0pjWEFFTk0xcmZqb1VkZ21H?=
 =?utf-8?B?Qi9qVzd4MVh1UWxqbllWNUpXNVFQRTNuei94ejdWaFB1RnVxNEVYd0VTMEtR?=
 =?utf-8?B?bEcwdGlIN29nYW5sY0Qwc2RaMmZCTE1PMDlidDMwMmM4eVZqZm9wQ0d1SFE3?=
 =?utf-8?B?SDVoeFdGeDRsQm01K3BKUmsrZjZYYWhtb2pKY3A4Z1ZTNGlkbTYvZ0dkeUZ0?=
 =?utf-8?B?VGNnekwwOUpvMmpBNkJRenF3Mlk0TVkzZzVjRW43TVFnRnB0UEsva25hZVh1?=
 =?utf-8?B?dnRYdVZ0RkRlWS95VGdNSzdyeEI1ckxXcmhJdDB6eEFINHNJMzliTmVEU01T?=
 =?utf-8?B?THFtU1ZqbWUra2ROekJhZXFKVUprMGlLVi83VHE5NzdkMXZiSTFmc3BzNFc0?=
 =?utf-8?B?S2NvQ3BORU9KbEdMSSt2VkZhYjB1WFJpY2c5Z2JXS2Z5YzhXV1BJQjZwa2pn?=
 =?utf-8?B?dXpaazVUcWRTQ3VrVjlRTS8yNXR2Ty9QOVphNlc4ekRYTmd5RGN1ZEFMVTly?=
 =?utf-8?B?aTFsTnVjdjUzYnZDVCtveUVYYW9HdnhhckNnZkVsa0lwQXNVZW1WUWNLbHRK?=
 =?utf-8?B?UFJYVHRtTWJOa2Z1QXVOcXo2OHgzRnlXa3RoMDBDbzk4WmJNNGdCT1N6ZFZi?=
 =?utf-8?B?VTVDMFlWUDJTRENpUkZVMnBPMWVFYlhvVEkwT3o3ZlU2VFRoM0hocmVDNmlw?=
 =?utf-8?B?TTNLOFlYbHRaVzZ1ZlgrUnhZcjdHcUZFZ1o4aC9EeThGbDQ4SzA1a1haWlpO?=
 =?utf-8?B?ZmpaZFhHN1hTVjMwMXVSaHBmWjRQdGFjbStBbVJSZ0J4WEE4bitXSlJYTVZ3?=
 =?utf-8?B?RHhka3l4SVVQSTZsdklQdGdjdHd2bDNjTTFlVGZrQk92OFdkWmF4K21LSThJ?=
 =?utf-8?B?UFhCdEZNdmg2eC9jRnE2bHZpVHI0T2R5Y2RDMGxWdktnUnpjSTFCOWxrdExQ?=
 =?utf-8?B?UnN2cUFLQUloOHUwZzdlVkNIbUEyS3dINDlxTXZiMUdyZWRSTTZlRUFraXlk?=
 =?utf-8?B?aFZrZExHMGdqanNOY1Q1Q2NlN0NSSEwyT0JjNm5rUzNKeUMzM3ZsSW5sMUY3?=
 =?utf-8?B?VElKQUhoazQ4TUJSZmZTUHJRUWZWanRFc0hrVzRlVjgzY1R3OUdENkd0U05R?=
 =?utf-8?B?UHExellQZFM3aEVld2FrRzlXVmhmdzhPeFVWSXBaTTMzTi83b2lZZGZYU2Fw?=
 =?utf-8?B?ZEF4S0EvWS9iekczRVAvSGZQRktTdThVdEp5RmRuK2JKUlNkZzE5Z3VoM0hv?=
 =?utf-8?B?VWhMMzNuRmhTR1Rtand3Q1loV2dBQnBEMk9sUmNjNWFNRWdIOGdUbDdEV3hM?=
 =?utf-8?B?TjdhajNqMlVkRFVrVTQ0eXdiSllHQWx1enRXRlR0WnN0NzFlSG9ycEFWdG5l?=
 =?utf-8?Q?u82E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fa7efb-c588-4da3-6343-08dc95edf2fe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 14:40:39.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRGALghflvpKvmmHIiZfu3+yPrK4nvItYlMZMvOC+WFv798EfzMtcMukMgNftKRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

--eb0c40cb31ba370eebe74f13d25eb3c948ae94a49ee4a77a58418b08c1e7
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Jun 26, 2024 at 7:07 AM EDT, Ryan Roberts wrote:
> On 26/06/2024 04:06, Zi Yan wrote:
> > On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> >> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>
> >> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
> >> pages, which means of any order, but KPF_THP should only be set
> >> when the folio is a 2M pmd mappable THP.=20
>
> Why should KPF_THP only be set on 2M THP? What problem does it cause as i=
t is
> currently configured?
>
> I would argue that mTHP is still THP so should still have the flag. And s=
ince
> these smaller mTHP sizes are disabled by default, only mTHP-aware user sp=
ace
> will be enabling them, so I'll naively state that it should not cause com=
pat
> issues as is.
>
> Also, the script at tools/mm/thpmaps relies on KPF_THP being set for all =
mTHP
> sizes to function correctly. So that would need to be reworked if making =
this
> change.

+ more folks working on mTHP

I agree that mTHP is still THP, but we might want different
stats/counters for it, since people might want to keep the old THP counters
consistent. See recent commits on adding mTHP counters:
ec33687c6749 ("mm: add per-order mTHP anon_fault_alloc and anon_fault_fallb=
ack
counters"), 1f97fd042f38 ("mm: shmem: add mTHP counters for anonymous shmem=
")

and changes to make THP counter to only count PMD THP:
835c3a25aa37 ("mm: huge_memory: add the missing folio_test_pmd_mappable() f=
or
THP split statistics")

In this case, I wonder if we want a new KPF_MTHP bit for mTHP and some
adjustment on tools/mm/thpmaps.


--=20
Best Regards,
Yan, Zi


--eb0c40cb31ba370eebe74f13d25eb3c948ae94a49ee4a77a58418b08c1e7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ8KGcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUMM4P/jziEZ/zIFyVP988J51uXPqYgM30Qtsl3jti
Vpdz/q2CXKxhqV3fkJqdUYttLaDbbys8++wh3+5pXAwGYtcArv1A9j2u8CFWoFTb
tQmC8+jKCrYdAh8TkEVvAUeA1u7LUPctVEHJmOzS0NZxUJZzf7976zjnmBAkDL3/
tKjAUJGs0uXMbaJR2cAqmMVFVstYmimyL4Mb1tnAKCgJ0cc+blqQdKRV2SH8KCPa
ZV8BqPhUZFRM1x4jODmbcSv0vz6opr8XA03lW0gi6KdjScbOYMpZI35Ex47JJbkR
EyTOG9POaFPDqhoVthIABfMEK2QoU8vhEo5D0/voIaxHI2i06/LArE5d07U+oeOX
pQdr6irJ1F2AWq4th4n/gkgCdkm9RzbxxPqPMfWCi/osKbS+T0HVoAB35u9ArH1m
Dyy2hSIGJ3rPPWk5HLw9AwghOHj1xlkQ1BCFJVSaSReS+vdOh3HhumEhfxyL/oyb
vePhdEdBk57DftWL2YUCXm5VjC0koiB1qO3mBWb4z9hKlOs9bIdfAzl1XknGG8gD
j+n5GEJrt482yQnUrRAEwKl5u3znyDe6aXIktckT5AIljpLmAsUqKeJCTl4NKpQ4
hrIDo6J3M0L2W/pfMGmQzvcH/tI/pqzzL9w9rlVQHDXSU8fJBgEAVio30GdgqYfz
rRWJn+iC
=u+BD
-----END PGP SIGNATURE-----

--eb0c40cb31ba370eebe74f13d25eb3c948ae94a49ee4a77a58418b08c1e7--

