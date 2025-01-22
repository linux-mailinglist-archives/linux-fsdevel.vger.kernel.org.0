Return-Path: <linux-fsdevel+bounces-39850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296BFA196AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 17:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC21188DA4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C4215057;
	Wed, 22 Jan 2025 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qUTu4w0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C41F78E8;
	Wed, 22 Jan 2025 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564092; cv=fail; b=Vi9Pf+Lf/GpHYi/BXTdkNfiE/RKGbwko3IONryUke+GU+9ej5jF02m2hY5bbGdTxgsf/euMDfhGXYyiOsGoxgjNpCjOVEsgzfrj/v3rfLWmvqjfqOP+2SLN5eaiQQfMwAOsq1a8dl5UI1Ez/n2oXa5k1zAB8+ijOP+hMbDy0wow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564092; c=relaxed/simple;
	bh=So+hfqzO+OMeQ/wqouzGmBASw0RTTcLtxdgXDAQoG9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Buub+uMj5OjyoT+ZibuarQZMxXB8xdHOG9mybBAn2FzZ0GQrwPgX2A+m5CKMC5WIOK66vhHDckgGBX7IQIxFPPGtf3FRlGBv0Ya+xtCQ/YpUR6WAGJntOUdTVClZT0QhQ/Zntu+K3JQE/1ypxfWV21K4xeQ8VZXgRuRSAz59w5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qUTu4w0W; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQXAr/BAYff7/d2ZxmXBL5GHzs92wzsK1FWp2x0t9CsO+IT2ycIp7LIR4/KGaS1SEoI8BhgfstDBMVl0mNAoaW4snvAfnsw8d0BCCPNwKDuN9q9OKK5wBjMd6reSEIei3brtnQxYNLqZi4Ts5TfeF+jf6wb4Atqs8OVi80V25cxB3YOod7lZrRjMli2rpnEpV0c2pBWZlgo81TSU30x4kDdgHHW6x0FI8auOkDJ9urcnf/aCruNmTgMPfo4d1mIYqyQKCzr0XPiKk8ZsWvzjbhnkAx0lp1LaPzZXCBWsPfni9WB1QMan8WEPgf8Os6/4UzOI7DRrebK4y1E8kwWtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So+hfqzO+OMeQ/wqouzGmBASw0RTTcLtxdgXDAQoG9U=;
 b=YgjdeqnmBdqGeGqA2sUeByC7JiXLVrHcypyx83Oil1OoLOQNfxr/D3C14dIhUl+Lv9Qv4MmqovH2jESEbl+uwyj6fpFpiyx50b1KsTTk9CuDqrcCBtG8Y/S/JRWgzalOuw/yUcGyZBo8KCUg7jSOSr8gMUWTScUa9FFroYJAurcToOHhFSm+BZXDqF1VG0J5QySSSMWvg5p5jSKy073Jj6w6zygHowNB6cPsKf52srYusvzyRexlirN/4mIvFinmahpuiBMgdc99DI9w3FxHSjVf7U/+E4Iw9bB3xtHW5y755cA8kLxFvcK1Qt9JiBIvvb9pUET1yWi6DbMMQ6WpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So+hfqzO+OMeQ/wqouzGmBASw0RTTcLtxdgXDAQoG9U=;
 b=qUTu4w0Wz2+knxsR2f3LuWtXllMagPHn5YoDH2tVyEh16+l2IAqBbbeTIjy3Sbrtvcc+rt8F7fpGkR1JGbm5Rgl16EiRLyu9riWovIdlIrSdzuzQo5JuKL9XNO9Wa9TUPm4kd68cpZ277jZ6/b12JNbOzNOlXawRXMHb0UWZfEDKEpN+fuewnMpjuBwaY/ZI+EzAzKuH6IZtRHrmBzekCyiv5p+TxAcrGo7DUV6w+ynK7DUMkFqMQbXsDWxczau2yB2ZP4C8HnkQC9vIPZsADhIH0tEAEXTvfF7tg50BpzVbaQ8csgFcC72zB/W8MChpeEaA+/ms0ULW2QtwjNilfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 16:41:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 16:41:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, tony.luck@intel.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, jane.chu@oracle.com,
 akpm@linux-foundation.org, osalvador@suse.de, rientjes@google.com,
 duenwen@google.com, jthoughton@google.com, jgg@nvidia.com, ankita@nvidia.com,
 peterx@redhat.com, sidhartha.kumar@oracle.com, david@redhat.com,
 dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
Date: Wed, 22 Jan 2025 11:41:24 -0500
X-Mailer: MailMate (2.0r6203)
Message-ID: <0D144AAE-706F-4674-AB20-1FD3A3537E33@nvidia.com>
In-Reply-To: <20250118231549.1652825-1-jiaqiyan@google.com>
References: <20250118231549.1652825-1-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00016413.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:b) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: c373edd0-1507-4285-49ae-08dd3b039d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTV5b2ZyVHJYemFaNmJqTGVRcUlHLzgrTXU0akVEbFo0M25PK3FTQmFPdC9j?=
 =?utf-8?B?YUZYOTZPU0FGNkwzWG53MEhrN1ZMSHFFcFBtTndFcFBaV09sNmFDNXpXZjNM?=
 =?utf-8?B?ZnptMUNvVGxzN0lEbzZDa1pMc2hxbzMrRWkzR1IyOHEybGtCUkx3Qy8xREd2?=
 =?utf-8?B?cUdLYUViUFZKSkVTb3dNcVJ3bFJPbEtTZmh3SXhBYTVSbHpVY3g5U0xDNVlk?=
 =?utf-8?B?ekxRVzlpaC96OVpWMGxmeE9pV3JRbEpGTVBIemtPOWtRcVJrR3lIemVSeUlj?=
 =?utf-8?B?NlZJWG53MlNyZ3FJSTFxbnVteDFmQ2ZCbXBRREp3M0haTEprVEdMWFYrSGNK?=
 =?utf-8?B?QWhuaXloSzIyL2diNit0WjBPN2k2VEdKbXRuWDRib0ltNjZkK3hFUmwvRkc2?=
 =?utf-8?B?N2R4T2Ezc2R3K0ZDUmlCMDdJZktiWndiTWJQVVg4cTJhZWhnaVNyVlVCV1Yy?=
 =?utf-8?B?UER4SjVFN3BNNTkxQzRJM1h1cXlUNmdHUkV5dFNJR2hLU1kxZmhpNXJ4dXNL?=
 =?utf-8?B?YkdnOWNWNXZ6L1p3N3Q5S0hmU1hZV29lZXJhTUpZWUFzWmtmaG9zck53ako3?=
 =?utf-8?B?UVBaWENRR21HbVI4YkFFOVlJeFlsZ242ZWpRK3RLVHdGTUthbmRHZXFCMmtZ?=
 =?utf-8?B?eEVxRWh3QzlKL3IwZ1NNUmZPK1Q3S1Q3azRzR0NobUZaSWJuZzNXNVhMUkkr?=
 =?utf-8?B?SWxmZWVXVC8xTm5mZS9TZE8zcnV1V1Q4SFQ3MThGaGF6RjdZVUNIajl4SzJ2?=
 =?utf-8?B?THpCZ0pzU0tVQTd1TXoxNmR6Y0dSQzYrK2V2TU8vdlFqUlVYNDVaUHprZFNB?=
 =?utf-8?B?RUxhRUk3M0JjeDNOeFdCVXBrUUhUaitIWXpEVGl2azBBcWRKK24zb1ZjTFBu?=
 =?utf-8?B?RUFrKzhWRjR3eDU0dWlLYTBRelQ2NUdLY0kxL0JZK3dKbjl0NkxnQllWbFdU?=
 =?utf-8?B?UlV5WnJkSmtGY0x3SVFoSG9HUXgvWE1Bb2xTRERPNjdkb0cyVTFtd2JHSVM0?=
 =?utf-8?B?VDFldWFyTTFYOHRCaWplQnpORWtGN01pM29BbXMwVE5qZVA3U3RDQXRSWjBD?=
 =?utf-8?B?anh1elhxUEs2YTFmSTVGU0lBTXNPZ2R6QUVQNXpjMkNwUmlFRnVBRGlRMzdu?=
 =?utf-8?B?WEpxN2VzdTMrK3o1T01OSjV1QW9uZHpiTTdyR2t4TzVHR3V5WE5UZXVZOW84?=
 =?utf-8?B?c1J1ZjhUVXR6dWE5aHFVN3VEbW1YcjZXK0NzRWFWZnpGUUZVbFhLQjlSdWV6?=
 =?utf-8?B?NGxGOWRJemwwZTg1azlIRHkzVnAxc2pqZVg4ckNLaXI5U1dXbFV2SE1HUXlk?=
 =?utf-8?B?NUlNb3FTSlBvY1FpM1UvZDlnazkvNWQ0NzEvcFlyaWtMZ2s3V0FRM25MQ3Z4?=
 =?utf-8?B?RnFkc1BmcFVLYUtMNDZ2cjMyTXJDcWJlQTNMNE9FMUNRM1FvZGg0Q3NCdFlk?=
 =?utf-8?B?dGRhYUxQV0ZwSGlSU3lXTXFMOERIc0lMdjFsQ0Y4SkRWcTIwRUJmZkVrdzVz?=
 =?utf-8?B?UFNXaVp3T0tXdHhuYkNRN2FONVdxWG5Zb1JoMWprSzRxOVBEbHV0QmJTUno2?=
 =?utf-8?B?V3FXTjBZUFZKU3gveVhyb2FDSlJURHQ4d1ZMS2xFbFgvV0lSbURnYmRRczU0?=
 =?utf-8?B?ais0d29URU5zYVZ1UFVIS2owYkhlM2JUR0sxUGE1NitrUGM0MjhtYVZFbm1B?=
 =?utf-8?B?ZnIyMUJ6cG92SGhDR0lTMTRiY21vNjQ3RU5uSklYL0tOWTB1ZnVHc3lQSkpQ?=
 =?utf-8?B?R1dXQUVCSjBjejYxNUpKWTE2VnlHTmZNS3M5YmVJQWQxcDBpcGI3dk1QcEhQ?=
 =?utf-8?B?VXdxdjFXdHkyVkZvUVdhVkhxZWhyUnBnWDg3Rk93cWw5OThRRm91RTFlTHl0?=
 =?utf-8?Q?quGfKTOVVErbK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enVwenAzQTQ3MWF0QVNweFZjM3MwRDBOOTA4UmFmVHEvcHJNKzBUWVBWOFhv?=
 =?utf-8?B?ZHhUeE9CQ01GZlBtb3F3RzJaem1lOVJsaEVUTHpqcW0zYmhqcG91YmVFSGV1?=
 =?utf-8?B?SENyU3EyNmpJbnZWc3VpeS9UL0JBUVhDbGtoZjVFUVlJcXFnMUkzMjJOMndT?=
 =?utf-8?B?a3piQ3h4dzdRRDdqQUVtWmNQcmovN01KYTB4M0Q1bS9lUlp3V3hTczVYajhF?=
 =?utf-8?B?bnp5WCt1di9LUFBQT0hJTFc3b3VTTGFRYVBxWUt0ZHpLbE13aHR5TUR0cVNr?=
 =?utf-8?B?R1hFd21NK1hheGt4ekdTN3V6UElEVFZTRk1GZ1BaV3o5cWNGaVh1R3VDYyty?=
 =?utf-8?B?TmMwS21oRVk0VnFJV0FDMDI0cWsyOThpK1hvOVhFMHBiSmtwdld0aXFDUGU3?=
 =?utf-8?B?d0ZLeE9kUFIrWlpnTVcrTHlZbm1aQnhNNFlnSkhzS1RGeEVRUWFIMFZ2L1Vi?=
 =?utf-8?B?b0o5Umh5OERMcE1QbnY2TDI3WTF0c1hOeEgwK1ovVGgzK0J6a0c4c0paSzRs?=
 =?utf-8?B?SmJMaTY3RVlaa2o0WnVNOExPTkdDQlpkM0l2L2djZHBFY0xBYVJmc3BBMmxS?=
 =?utf-8?B?blI3dlN3ZGd3RjAzSTVicEZQTUpoZzRFYmczUk9oOWtCbXVpVlZISVpIRDUv?=
 =?utf-8?B?aE5Sa1FxK2JNTlZsQTNab1lVR05PYjlKWlVqZzh5NzZ0ckJnNk1TYzZ6MDlN?=
 =?utf-8?B?R1dCcHJ6YjhZNk5Qa05lLyt1U3R1NlQ5SDZzRElQOGtYN0Q0VzdrRmxpMm9n?=
 =?utf-8?B?Q2czU21EYlB2azlPcVA0UktkcjRtYUh1TWVqZTZzLytMMVpzSW5QeFo2TFZV?=
 =?utf-8?B?dDhLV2J5aFJKczkzV2lZYnVTcFYwMlhpU2NkQ1psZE1ITXlQNXBIR3hHb0Rp?=
 =?utf-8?B?QjFpODRLWG5rbjljQUh3UGVabHc1REVEb3FvM1FDdk5xZnNFRmdGcG9sVVI5?=
 =?utf-8?B?Zk5DaE1IcUdzSXVCaEJ2dU0zbFEyMUtXN0JRMHVWZVN2UCtiOFJuVmlkakNh?=
 =?utf-8?B?LzNLSnZpSS91cDZLN0o3cTZJY2xybXZNekkxaE00a0FQb2tVKzZGd0IvRWlk?=
 =?utf-8?B?bDV4MmRPV2J3Z2VoZzNOWDUyZHdHQlQrNjdTYWZjOGVHZ2gybGEzSFpBSWg0?=
 =?utf-8?B?SFZ1cG1qM2pyNEduR0VtbUFzdVFEUDUxT0o3b0ZHUFcvcTNUb3U2aHd0aXll?=
 =?utf-8?B?Ty9FWUpRRU12MXRGb3VCd3lTVnZRYVpOaEdjT2JJNlhzanI5V1A2eFRqSzg1?=
 =?utf-8?B?dUkxbGcrd20raUk3RVRoVnU5TXAwdVlMdWJnSnVIVUxCVE9vQzdXYm01U3FU?=
 =?utf-8?B?eUZqaklYT1hVbEdaS3hxcjdQQ1czQ1p6c3g2MXA5MXN3MUZpekxUdkd3dW8z?=
 =?utf-8?B?ZzQwTWhKOXFib0ZwSXVTMW0rQkMxelVpaGZjKzZBTy8rSWI2ZmtKZ1d5Q1RO?=
 =?utf-8?B?ZlBMSFk4bW9TTWhpUENpQzUxUXRjdjZ0bEIveXozQ2w1THBwSE9Tc2FWMWVB?=
 =?utf-8?B?aWJkWTVIcW1YdjNCdUdGVVViclNTOG5FTEw5ZnZSRDBtSUJ5MStzSElIbmJG?=
 =?utf-8?B?NHpselN4clgrK3JyM2VwUHFzcVR2dS94ZGFqZzdjYnM2eVY3OXhjZVFCUUlj?=
 =?utf-8?B?bEEvSDMrK3o5SVBTejNCNDU4Z2pJclZJZ2Y1cGRWRTVOUzMyRFo2WGVPcW5o?=
 =?utf-8?B?OHEvUDNaWU0yVUVuRG91OXpobGFVV3lQbWU5VFk1QjdRNFp3YjU2endpMERQ?=
 =?utf-8?B?ckFJZ3I1VytvWGZaNm1nTys4ZEczVWdVL1dNV1hsVCtMUDR5cHgrYWF4TGhp?=
 =?utf-8?B?R3NwTlJkWlZ1bCsrWVhDSU5iWGp3ckFSdlN0ZGozdXErTUpRV2g2UHVzeXhl?=
 =?utf-8?B?L0ZBL1VVNVlDVXM2Mys4RnE1Rm9kSjlKV2dFMUMzemw0NjFKZk9LYkhrWm55?=
 =?utf-8?B?eXgrRzByZGRxZlJzbUlmZFplQ3l2WVZ1RDJQOEZSTitqUHV2aWVOVUhDTGJi?=
 =?utf-8?B?R2lNZExzVlRrdjNBdGNxUit6aUl1dWE3b2Uxc3Yyb1NXNFhMTFYxZHoxaVNH?=
 =?utf-8?B?WXN3N0Z6RjV3RXZtQ05UL0lQbXhoYlpjS2YrUm1pTzdhRTR1UXJHeG1sMzl6?=
 =?utf-8?Q?4yhfa1NZwPqEiETUOVJHtAZZf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c373edd0-1507-4285-49ae-08dd3b039d9d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 16:41:27.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvDWNDZaw3UR+ijvcso06ThFYzvtlKZStpK0uKwnVebf5+x7u+TNgEzgYr2kIutx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

On 18 Jan 2025, at 18:15, Jiaqi Yan wrote:

<snip>

> MemCycler Benchmarking
> ======================
>
> To follow up the question by Dave Hansen, “If one motivation for this is
> guest performance, then it would be great to have some data to back that
> up, even if it is worst-case data”, we run MemCycler in guest and
> compare its performance when there are an extremely large number of
> memory errors.
>
> The MemCycler benchmark cycles through memory with multiple threads. On
> each iteration, the thread reads the current value, validates it, and
> writes a counter value. The benchmark continuously outputs rates
> indicating the speed at which it is reading and writing 64-bit integers,
> and aggregates the reads and writes of the multiple threads across
> multiple iterations into a single rate (unit: 64-bit per microsecond).
>
> MemCycler is running inside a VM with 80 vCPUs and 640 GB guest memory.
> The hardware platform hosting the VM is using Intel Emerald Rapids CPUs
> (in total 120 physical cores) and 1.5 T DDR5 memory. MemCycler allocates
> memory with 2M transparent hugepage in the guest. Our in-house VMM backs
> the guest memory with 2M transparent hugepage on the host. The final
> aggregate rate after 60 runtime is 17,204.69 and referred to as the
> baseline case.
>
> In the experimental case, all the setups are identical to the baseline
> case, however 25% of the guest memory is split from THP to 4K pages due
> to the memory failure recovery triggered by MADV_HWPOISON. I made some
> minor changes in the kernel so that the MADV_HWPOISON-ed pages are
> unpoisoned, and afterwards the in-guest MemCycle is still able to read
> and write its data. The final aggregate rate is 16,355.11, which is
> decreased by 5.06% compared to the baseline case. When 5% of the guest
> memory is split after MADV_HWPOISON, the final aggregate rate is
> 16,999.14, a drop of 1.20% compared to the baseline case.
>
<snip>
>
> Extensibility: THP SHMEM/TMPFS
> ==============================
>
> The current MFR behavior for THP SHMEM/TMPFS is to split the hugepage
> into raw page and only offline the raw HWPoison-ed page. In most cases
> THP is 2M and raw page size is 4K, so userspace loses the “huge”
> property of a 2M huge memory, but the actual data loss is only 4K.

I wonder if the buddy allocator like split[1] could help here by splitting
the THP to 1MB, 512KB, 256KB, ..., two 4KB, so you still have some mTHPs
at the end.

[1] https://lore.kernel.org/linux-mm/20250116211042.741543-1-ziy@nvidia.com/

Best Regards,
Yan, Zi

