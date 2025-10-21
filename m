Return-Path: <linux-fsdevel+bounces-64964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101F8BF7852
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C46C3A2657
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A12C3451B6;
	Tue, 21 Oct 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HLrGJPQY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD23446C2;
	Tue, 21 Oct 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062112; cv=fail; b=O94zqOya9ALF8CUM7qkNxzF9bDXaDe59Uz4mczEeLgorHMunhXcmUHKmt9Tdkc36E0q21YaJCJY/SECVQF/MFaHP0IT/SmgwGGoYacrXKMr1vYptV1XYCxWyq1fhsyEzsyQZGjzA8VW53Hw7wbF/qZ5Ozh43r8U8pzv5yA6DS/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062112; c=relaxed/simple;
	bh=yoLwRkcn08w9cIfQuxNTDQpG7RI/BOHfA/AAfJ/Apjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kxb6LS1Pmh887/FxGhumXlNjJrROSRLWAfajfdptkv0rhmwl+joIIWd+STlKGNMiZrfjrO4dZI5xuEFg3hzGKocsFTX8R0D4SOs/w9lvS+Ocb5cEDcvd0YZ1RlD0SH/pWHOXBxFJc3A3XmMUm1lRkZpL1GMYQj67tY38iykX4Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HLrGJPQY; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifeKZJX3nqSeS8686KYLK80DCInumFZLd6fWB8IiP3F7etpVHvT55F0xwpzf5J5v0YyjapCYe3t25osPo+B8YUt/fqlznnrKennJta00kuehH3F+8/hwgdugMepA//T/3P8qXws5AQLAN0LV//T9tYTSs9b84yix/8jKlysia6vmmuod4ZCWS2ImgpFJu+OEop5oGvm95yZU6ZwBfH/eg1+oYEI4oF15Rzi7vgrmhF3reZq7UrYuQrHtQ7XHd5xFpMIslMQ/jtsYLYmD5++rB4K1xjO0OzJ+lzRvS8sLsJXYRkOQ0ch6QTnjoUAd49DJ4hp9KClOcLRl6FtO3m7L/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOUGJDF12IrftMW+PGkG8RY8N4rphdsJ6WBt3QAkrnA=;
 b=Loamt1fMwp4+l6pRgesZS7ShQ4KeHwHbl64Zn3Xw1FXFYG6XA6n2tx+6/Qg7pvaC3U+ZOpFzGKl7KANdujYtyt06avsxRXrcUm7WUndPwDsroOF46MBFJVhmSfMBDjc+6NdagIbQTPPuytF8MMxNNaDjJ2ly1hZw0nv/tqivGDleO9q0tKtY0W7kNgkLOFDTLS9XZbh0KuKI7THWWP+fmhiK5K13msfdmtAcj+X890kgTmVuv6nvYGTHMFRzP9Z407doe5WrsE2SkUNKR29Pb2oiOQ826kTWbs5WW2jrKIJw59Swnk8zErKbS4sBgcAuUyDos4xojyupSawu6TuwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOUGJDF12IrftMW+PGkG8RY8N4rphdsJ6WBt3QAkrnA=;
 b=HLrGJPQYVGccRUECyxog6oZyL6S/jBNdKA0NqNsW1ffBQOuH3sa3b22kYeFyVHBE/3N5Gkgn84W5TMIca5jQFlUDxhEaAbVL9z6jXFoba3M88bqmIBmn/tD1S0Wn4j4ygITMgq9n1V7oBZyOMsRyWDjnihwfYtuG6qp/KnbYIGZI7Uq8zsu7YXRT7JzxExUqo8rHcASaXYfSxqyTX6rMuXx3CrWlWUIMF0bqmRSE+nNI/pTIAvou5dGl+j7Xg+L1SZfO7BG962ThcvEtfxy1sZdRGlv873uGyOKXWLaEHvHiX9SKYjl7VQ6hMSgeH1SdSBrN+52oLT76NKgLeGrAAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA5PPFC3F406448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 21 Oct
 2025 15:55:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 15:55:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, linmiaohe@huawei.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio
 handling.
Date: Tue, 21 Oct 2025 11:55:01 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <893332F4-7FE8-4027-8FCC-0972C208E928@nvidia.com>
In-Reply-To: <b353587b-ef50-41ab-8dd2-93330098053e@redhat.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-3-ziy@nvidia.com>
 <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com>
 <5EE26793-2CD4-4776-B13C-AA5984D53C04@nvidia.com>
 <CAHbLzkp8ob1_pxczeQnwinSL=DS=kByyL+yuTRFuQ0O=Eio0oA@mail.gmail.com>
 <A4D35134-A031-4B15-B7A0-1592B3AE6D78@nvidia.com>
 <b353587b-ef50-41ab-8dd2-93330098053e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: 43dcb1d2-b0a6-4064-160c-08de10ba34f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjRqYTByWXpGZ2RnR3dhcTJUQzlQdWdtNlpWSUtZanZxM2ppV2hjNHU5ZGFY?=
 =?utf-8?B?TG1UTHVjMm45QUltL21GUW9JRzFqSFlFNnhIU3lRSEVzS3ZnREFVb0p4bExn?=
 =?utf-8?B?VmxPZlQzUC9NMkNyYzhmbnZFNkxwSkNKelJUSmpJbThaK3EzUXRoK1NNVGpm?=
 =?utf-8?B?TWd4MmxReVRpeHZreGJyMnVUZUFuOGFyQ012UTBYT1RiQ1NJbGZLMWN6cUcv?=
 =?utf-8?B?cDU4K05tcklPL1ZPUHZIeG5TRERLWlRuY0ZKaGU5RlNjazJ5QlZFK0YraytW?=
 =?utf-8?B?eVl5NnFHdEVZOWlaME0vcTBjV3dybkszcHFhRmd5THRKOXMzSjlrM1daNUxL?=
 =?utf-8?B?N0pidmhKTXlXU3J0ZkY1dGYzMis5ZVo0RTJiY2F3Rmt0ZDlkOFIxVDR3Q3dN?=
 =?utf-8?B?dER2ZXRDNElnV0QyK05sUENCZUpESFlIR2FOWVZKazlDckpKV2w3MUF4VVFW?=
 =?utf-8?B?Q0kzVldGTUFaN05LSGx5S096bStERmNicUNod0JNdEJoSmRpWG1tVWJJTm4r?=
 =?utf-8?B?U2h6U0VLNjRLaEI5ODAwQ0ZTalYxREtHUmdlRGg5MkJKNFRiTjBoTk5YRlZC?=
 =?utf-8?B?MlJTbjZkdEhyaWdRZWRQZDZUN1U3K2V2WWt2aHFNTVNRQTlnU1RORDBoWDhu?=
 =?utf-8?B?dTgxellzNGt2K2huSmZ5d3l4MDdHQjdRRWM0YUhhQkxjajBVVXZpbGRjUFdV?=
 =?utf-8?B?V1A3TWhoVnN0SDBkVXhOYlExbHRGNEVpem1EZ3ZOa3EwUDVLN0FwNjd5WXVo?=
 =?utf-8?B?UHZ3THhFb2lPU1Uva0phOUJUeVBOdGhwbkpGd2F0eGhkd2lpTWw4azMrbWZC?=
 =?utf-8?B?K2RMaUptUmtZS1lLSXJ6YXU5UFltdFo0ZzlRZGR3ZDZTVTZrOEpCL2JrRFVL?=
 =?utf-8?B?MXZhaXpCNEsrM1JUbHNpbXZqMWxYdGJKWk9GSGtIL3FUNmtCcnY0QmdZaS8v?=
 =?utf-8?B?WFllZnR2elBMZnFpRmUxSXRkY050V0FkcHg0WDhGSTE4UzB3c0hOR0swRGY4?=
 =?utf-8?B?NmlrWmtLV3V6Nm9zNjRMVlNxSEJrNmdqc1BVVjd4MU5hQzZINFRCZlRMekV5?=
 =?utf-8?B?akxGcklZRFhxOHA4Zm5lMlUxMC9QQ3l4bWNsRUhtMDRwdVRBaGxWQ0xObjd4?=
 =?utf-8?B?SFBoSzNhNVo5aGt0S0VJMkg2Y0RnUWVTQ3d2Ry96YXVFVGlON3FQeW8rendG?=
 =?utf-8?B?MlFRTytUM2YzVDZwUnNSYzluNDZlalFLYmNTcmFvWExyWHJFdUtvdTc5WUpZ?=
 =?utf-8?B?dkhEa0NMdWFhZk92YnM5VTBIQU1Yaks2UzJWUEtoQjhCL1A5Zzl6Vm0rN2FD?=
 =?utf-8?B?T3ZhTUtaL2J4Qk4vYnVxZDFxS2x4UTJLMWhNdDFwaUEwWE9lZnN4N0h3Y2Nq?=
 =?utf-8?B?d2dqLzFJRGM1eHRmaUtXaHZWMmxHdjc0RlIxQ2JoV0VyVXJuckhUeGtqbDJR?=
 =?utf-8?B?S3JJTTBpOENoOHVRK3VkN3V4VDRMTm93bTFGbnRjcVVxQk5vUWNOa3dhK3dk?=
 =?utf-8?B?WUhxalJldGdTSXBqdUJ2Yllkem8vV0V1V2xsTEJVVlBaSWRjZEd2MmYwWnMv?=
 =?utf-8?B?Wi9pUGNnNllmbk1wSFNxUGZFNFJTNjRTY1FjWlI0aDk1dDdqN0tTODB4NXZR?=
 =?utf-8?B?MngvdXNockp4ZndEU3pzWmMvcFhTdWdUWHMzaUdzTlZ5QlZnNC9tL3g2by9z?=
 =?utf-8?B?Y2c4bDJyTi93VXZHTDl3ZUJtdHFieURuUW5LbTlqMWVIczhqanlmeUVIa2tt?=
 =?utf-8?B?L3N1YnNSNUpMcGVHdnVxUlRQTTB4UUFpUXZLYjhqQkRnbzNoTThodUkrVVNZ?=
 =?utf-8?B?bG9HY3hCczErUkhOSnFITUxMZTJTQTNYQ2NJSURsVXdNZzhWak1FUVFsdmVD?=
 =?utf-8?B?cEoxVHFwZDlESVpMY0MrNktIeld5SWVpZXRVOG12MnhMTmg4UkZ0b3RhemdL?=
 =?utf-8?Q?WP7M2gJGBU/ifPe+LFyWGjTJfz5h5/TB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk92dWkvbnEwOWg3MXVoTFNTWHA1b3BJMlRqVy9HTk94c1RpOUpFWGJ3enFJ?=
 =?utf-8?B?dHZSQTdjNlJLRGJHdHhibjl1REloNnpMUVR5ZmtsRzFSVFkzTElTL2QraUpv?=
 =?utf-8?B?dlkvN3FmcGdSK012b2V6bmx0b0pJaERPaWlTbHJNNU8vMEJIUk4yTTVlNm1S?=
 =?utf-8?B?eU9BVnoySUhrYnlVQkFyT3U1dlN4VmloT0c4eE4yZ0F6L3ZKUGdERnNFQ3Z6?=
 =?utf-8?B?bVVZaDFXNFlEUjRpQ01EeTRTMWVRMTcwM0tkMUJoeGpXQnpHTW1xelN4WjJs?=
 =?utf-8?B?ZnQ4S3hXb0tJSm1UUmlvOFZ1V2hnNkRVWmV0MjkrdnhQbGxKelczbkNZSVR2?=
 =?utf-8?B?SHpDQTEraXNEc1dOVk1PMnVvTldBenRKTTZicGNINkhzNGRkVkpkRm5WeXZm?=
 =?utf-8?B?a21FOWs5ZGVKSnpoaWJTdXpNakFjVDdQckd6WXZnam5aRHRpNVhCL0p0eUhG?=
 =?utf-8?B?ckVtMWpSL29GbEE4UzVXTHpOM0VoeWVaVEpIWjN5dVVLa3pCNkZHQ3drd0pH?=
 =?utf-8?B?NGRjVlV5aXpEUWJhakdRRGFOTTRvcitKeEdiQVNCd2VqeEdYcmlEeU9kTmVW?=
 =?utf-8?B?ek5kczdYUWE2akt4cHBDam1wUlgwN3NlWVMrUjNpYjZnelREZXhHMldzelFm?=
 =?utf-8?B?MFJDZmhHWlIwaGY1aTF0Zm1aTi9TUkROSlpjaXlZSjVaRG44RDQvZm1xWnVy?=
 =?utf-8?B?ZEhTcTU4L2dLVXRJRXIvdk1FbjRTcHQ0K0dZTkoza1IrcEJDcmRYRXhNeGg5?=
 =?utf-8?B?alRyaERvYnpqVDZubng2bHhGZEVKNkRBc1A2YllndDZYZUxYUDAwdDdxWUls?=
 =?utf-8?B?aGNkMWZ3cklIY09tM3lQdThsVm4rS2N2UUlpenVYVVIvamJsUEdXaE5sMUxL?=
 =?utf-8?B?MXAwV01UaWozbGs4eHBaUUsvN0ZjQjNJMGJNRnMwS1hkdElORHFpcjlJV1J6?=
 =?utf-8?B?QnhQMDcydkdyZU5ya0tWL1FKcmhQMlB3WGhEd3FTM2dmdXUxSkhESjZUUTNo?=
 =?utf-8?B?VHpSVm5WSlFBT0dHbHpRVzU0cDNEQmNNWk5zOFJFWTFLOFo3VGlpWkxBRmF2?=
 =?utf-8?B?bGFlNUYySjRFeTZJVW1PaGtBbjdablY3WVhyTUpNQUk5b2lsOW9rZFNydGpx?=
 =?utf-8?B?TkZoRWowUndRL0ZqZE1Jak1yTjRPN0w3ME9UM1Bpb0VRYWRrREdseGZuaFR3?=
 =?utf-8?B?ckI0VitnakxBdlMzenhUdjBOVVRYcmZwUEEvQzRYaWxVdTVIbFl2VHAwN3hh?=
 =?utf-8?B?WU1TWkM5ZjJsWnVQVFY1Ukx3b3lyOGNSK3g2OUllaGM3emY3aUtvOWRHcmxx?=
 =?utf-8?B?eTQvNW1Rc0EvejVwMWlqekFwanF6Yy9CODFRbnZnNXhhRlF5MHFCTDl2MlFK?=
 =?utf-8?B?N0VwWmdwNXVwUFVDa1Z1bnlVNmlYYVRPZEI2RVhOSGc2aG41QW9lemtVZjdS?=
 =?utf-8?B?clRTVWtPSitDY3hxZHlwdHNrQ0p0YloyQ0UyUWR5NkdiSzhPNFc1ZlRaelJv?=
 =?utf-8?B?ckZ1dzJQM3hkUW1MV214bndEanBkSjhsOUNyRCtTN2k2V1gxWDFOSHEvUGJ2?=
 =?utf-8?B?MXRkSzJHbnN3WEt6T1h6NUJSbk8rcHR4WHhhVG1NcGxaYWtnTTJMejdEcHdP?=
 =?utf-8?B?NU5YQm5LUTRGb2RnNThESlpmWlF4RFMvS1MwNGFUYkZiS3B4S29iQWw5ZzVC?=
 =?utf-8?B?ckwvcTBhNzBzOGJQTnlqVWVVd3hkRFFqNzdXYkpVL3RVdGRrRzdSSms2VXVY?=
 =?utf-8?B?OEJnNmNQNk9xeGZZQW5SSG4zNm1xRWNoWmZMWUkxdFhYMW9wZ05ienRYVHk3?=
 =?utf-8?B?SkxpVllXZGFVejduVjI1NHdZQVpyS0lsRTNHektVMlVOU0s5TUFSVlhRSDdp?=
 =?utf-8?B?ZVRHT09UbE9weElNdVdzdHBtTW4xM1hKYkt6QmZ0akZ1bUpVM2g5eUJEVU5Y?=
 =?utf-8?B?ZkhBbStWSnlrMlVCcUJvdldvcnVhME1hd0NWUG40dGpPR3d5SG9rR1RadHJ3?=
 =?utf-8?B?bmVXSDl6cWlaM2VEOGM4M2gzU2NmM3RhbEhMNEhXODBIV2Y3ZGxTREN3Q25n?=
 =?utf-8?B?ZWhYOW93cWxYdXpCMFMyM09UcnhFM0E3T0lYZ0x1N2x2d2ZIOTB0Q0FxM3Vt?=
 =?utf-8?Q?gszfPBL8IOQfRZp3d+NPekGCD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dcb1d2-b0a6-4064-160c-08de10ba34f2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 15:55:07.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zc4qQDfgmoZlm7TmtSGRshjdlvjSWTD1GgiuQUHyXWXccnfLpvnh84/FxAkLbJrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448

On 21 Oct 2025, at 11:44, David Hildenbrand wrote:

> On 21.10.25 03:23, Zi Yan wrote:
>> On 20 Oct 2025, at 19:41, Yang Shi wrote:
>>
>>> On Mon, Oct 20, 2025 at 12:46=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>>>
>>>> On 17 Oct 2025, at 15:11, Yang Shi wrote:
>>>>
>>>>> On Wed, Oct 15, 2025 at 8:38=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote=
:
>>>>>>
>>>>>> Large block size (LBS) folios cannot be split to order-0 folios but
>>>>>> min_order_for_folio(). Current split fails directly, but that is not
>>>>>> optimal. Split the folio to min_order_for_folio(), so that, after sp=
lit,
>>>>>> only the folio containing the poisoned page becomes unusable instead=
.
>>>>>>
>>>>>> For soft offline, do not split the large folio if it cannot be split=
 to
>>>>>> order-0. Since the folio is still accessible from userspace and prem=
ature
>>>>>> split might lead to potential performance loss.
>>>>>>
>>>>>> Suggested-by: Jane Chu <jane.chu@oracle.com>
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>>>>>> ---
>>>>>>   mm/memory-failure.c | 25 +++++++++++++++++++++----
>>>>>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>>> index f698df156bf8..443df9581c24 100644
>>>>>> --- a/mm/memory-failure.c
>>>>>> +++ b/mm/memory-failure.c
>>>>>> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long=
 pfn, struct page *p,
>>>>>>    * there is still more to do, hence the page refcount we took earl=
ier
>>>>>>    * is still needed.
>>>>>>    */
>>>>>> -static int try_to_split_thp_page(struct page *page, bool release)
>>>>>> +static int try_to_split_thp_page(struct page *page, unsigned int ne=
w_order,
>>>>>> +               bool release)
>>>>>>   {
>>>>>>          int ret;
>>>>>>
>>>>>>          lock_page(page);
>>>>>> -       ret =3D split_huge_page(page);
>>>>>> +       ret =3D split_huge_page_to_list_to_order(page, NULL, new_ord=
er);
>>>>>>          unlock_page(page);
>>>>>>
>>>>>>          if (ret && release)
>>>>>> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int flag=
s)
>>>>>>          folio_unlock(folio);
>>>>>>
>>>>>>          if (folio_test_large(folio)) {
>>>>>> +               int new_order =3D min_order_for_split(folio);
>>>>>>                  /*
>>>>>>                   * The flag must be set after the refcount is bumpe=
d
>>>>>>                   * otherwise it may race with THP split.
>>>>>> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int fla=
gs)
>>>>>>                   * page is a valid handlable page.
>>>>>>                   */
>>>>>>                  folio_set_has_hwpoisoned(folio);
>>>>>> -               if (try_to_split_thp_page(p, false) < 0) {
>>>>>> +               /*
>>>>>> +                * If the folio cannot be split to order-0, kill the=
 process,
>>>>>> +                * but split the folio anyway to minimize the amount=
 of unusable
>>>>>> +                * pages.
>>>>>> +                */
>>>>>> +               if (try_to_split_thp_page(p, new_order, false) || ne=
w_order) {
>>>>>
>>>>> folio split will clear PG_has_hwpoisoned flag. It is ok for splitting
>>>>> to order-0 folios because the PG_hwpoisoned flag is set on the
>>>>> poisoned page. But if you split the folio to some smaller order large
>>>>> folios, it seems you need to keep PG_has_hwpoisoned flag on the
>>>>> poisoned folio.
>>>>
>>>> OK, this means all pages in a folio with folio_test_has_hwpoisoned() s=
hould be
>>>> checked to be able to set after-split folio's flag properly. Current f=
olio
>>>> split code does not do that. I am thinking about whether that causes a=
ny
>>>> issue. Probably not, because:
>>>>
>>>> 1. before Patch 1 is applied, large after-split folios are already cau=
sing
>>>> a warning in memory_failure(). That kinda masks this issue.
>>>> 2. after Patch 1 is applied, no large after-split folios will appear,
>>>> since the split will fail.
>>>
>>> I'm a little bit confused. Didn't this patch split large folio to
>>> new-order-large-folio (new order is min order)? So this patch had
>>> code:
>>> if (try_to_split_thp_page(p, new_order, false) || new_order) {
>>
>> Yes, but this is Patch 2 in this series. Patch 1 is
>> "mm/huge_memory: do not change split_huge_page*() target order silently.=
"
>> and sent separately as a hotfix[1].
>
> I'm confused now as well. I'd like to review, will there be a v3 that onl=
y contains patch #2+#3?

Yes. The new V3 will have 3 patches:
1. a new patch addresses Yang=E2=80=99s concern on setting has_hwpoisoned o=
n after-split
large folios.
2. patch#2,
3. patch#3.

The plan is to send them out once patch 1 is upstreamed. Let me know if you=
 think
it is OK to send them out earlier as Andrew already picked up patch 1.

I also would like to get some feedback on my approach to setting has_hwpois=
oned:

folio's has_hwpoisoned flag needs to be preserved
like what Yang described above. My current plan is to move
folio_clear_has_hwpoisoned(folio) into __split_folio_to_order() and
scan every page in the folio if the folio's has_hwpoisoned is set.
There will be redundant scans in non uniform split case, since a has_hwpois=
oned
folio can be split multiple times (leading to multiple page scans), unless
the scan result is stored.

Best Regards,
Yan, Zi

