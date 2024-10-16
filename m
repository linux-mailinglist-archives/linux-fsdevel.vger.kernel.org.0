Return-Path: <linux-fsdevel+bounces-32155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB09A15CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 00:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C3F1F23303
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 22:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFCE1D4352;
	Wed, 16 Oct 2024 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eTHtfRlG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qnPxuHRo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23621E3A4;
	Wed, 16 Oct 2024 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729117857; cv=fail; b=kwVpmKg+KoQQH7c1Vn2BRiKtiP1VEBp/WB83V2AqT8uBUitLA8zokTPIMn2wIXVnAnSsJ3HUUAjyAnatWsfYNYYlAChE9FGm/EJ8owNs56XlupcJsEp1h6nfrMkPVoyoZQe/EwJeX8PbG2m4RHooxep7TWvqUng3pjfkQBW5wRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729117857; c=relaxed/simple;
	bh=Otegg4sP5WSHqqmzXwqf567m+mxi5pjzXvppuaL11EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBvxpn2gUSypfe0af0S0uSlHcm1MShmReBci6wzzdO/S6wMeH7KU5e/AvvDjT+4JiqsfXqDWGc9IX0xmVz7pSI0SxNOqMQI8CaxOKM8nFsGmDHhyO49U+hMTzQsHppFUj21zlR1t3Y9DqQ8/0//9iW7B7i2i/eWkzMlJLv6D/uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eTHtfRlG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qnPxuHRo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GKtgI7001601;
	Wed, 16 Oct 2024 22:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sWU0QFi5C+x+QrmXu3Af48fUPRo482vD0gFEn7egaqE=; b=
	eTHtfRlG8kY3IZQgNKnhYz3gQdmMUssJIGS+Rjj6asXovzhHqA0jJCtf5CD51Xzd
	KUORzUG+pHzDLsbFP6o9Uuw5fDA6gsASzPYEh4uoxM1VmukFE3NRz8U79XxmNB5X
	a93WEWx4NSUEFEOEvBty4j+3E8MTS9umCPhvmX8QG3DhV3RNL7VKBqOr+5Oenx6F
	/GWG7xte2bMnJBnCn9xWVcLSZr92F1L8eMHOonIWtrE9SMgkaxvFKVzkWmN+7RZj
	eJHHWc0bz1LAEiZDxImauorAUh/FFvzOYDnFPS9A2khV4U+F2C9Ux3ZpJTJscPaj
	zYaclbI8Ob08ra3Q5tehSA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntd1sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 22:30:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GLg6vs014817;
	Wed, 16 Oct 2024 22:30:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9ejjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 22:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymhKSR0eGeEQJHhA+grupwQt19e9+5rlhZ4WAXBi6r4z0Jw0dKKPP9vGdnq9QeojeLdxdGTNWkyByCn2n1F2YykcJVyg/lghRO/Vp/YyCaJHI9mT/tyOcjPoZtQflLjqSsLpNzOsHxorZsxsJs1qm0/Y7ys4dVWP0AbcbYFv+VWpYsS5Um/lEjAjuvEGwPfjo9ldBIrnCBF7l+RsldqeiN5B1V4cbf4BcgWJ7TOFDbYVxSFeMIHYa1liu3kmi84AfuCQOYITuSjX5eYefOiw4n918IL0bvXEYpwTSAsr1anRIgJtvHnAFK1xbtJsxAsGhndwMcYyuq8SIzjsikhrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWU0QFi5C+x+QrmXu3Af48fUPRo482vD0gFEn7egaqE=;
 b=wlRJWV2j9hb0DI3BNQqOJ5eRD1FGkZju0GF7cB4kHE4G5kJZNaMRPHbATGjIZqNVc6LsTsgSLb0BA0RrX1do45GVVnOccthJX4xY0m50hWgy8QLL4jvk6tAdPWPufKoNrE4D4+EucNAPg+xH4vIGFWgo3e7ygNLHRcw3kHwBDQrY0FprVhughx8E/E6oMyrQoF4NPRBEUwOGOxdmmeytUSWZs3Z2K2C73ZGAmAH61BvK+nzALAPd0NgVLX7NTJ2ytFMM/nUMFQWdzjlSNGIN1Ie4KDm+vy6byV7uBdS5t6Ox4SE7fgM7/XmNbcIZVqQJQ1XnuKcTCSR57ugZenK2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWU0QFi5C+x+QrmXu3Af48fUPRo482vD0gFEn7egaqE=;
 b=qnPxuHRom1iBbikqaH5KemUEVAPuhXu7xJ4nh7yYJFFfmj/q5m5l1AKf30ruJ57dTj/o2AjtyTB2x4uATGGJInnzMx5P6dEr03I6UtD6K5o8MNQoF1L7K6+jepjTDZzjsf1b0df8e8M2+4p4BPfhYnW6/85avYbugggsj+UJMuw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7493.namprd10.prod.outlook.com (2603:10b6:610:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 22:30:36 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 22:30:36 +0000
Date: Wed, 16 Oct 2024 23:30:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <97fbdb19-fe46-45e2-883c-2ec0e0e6416c@lucifer.local>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
X-ClientProxiedBy: LO0P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 43895c86-7be8-484a-ba43-08dcee322796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHZlaTJOVnA5YTU5QjlmMC8zRGlFM0dMeHR3Sy8rR3RwWEFNQm90L0ZkQ1lv?=
 =?utf-8?B?ZWZYSFVKZ0hGcnNxKy9ES3c1ZDRwK0gzdW8rdkZvR1Q0T0svYi9LVzdxejNm?=
 =?utf-8?B?bWUyUXlXZ1labHlHK0s1UWtpaFRML2RKZjZsMXlWSFdRajNXaUNIZ1hKRkZr?=
 =?utf-8?B?ZkhDYmRPRlpKeFJSYUZIZ0hiQ1BCdDRzalJIc0tmY3pKZHVTWTJLN2UrdjU0?=
 =?utf-8?B?NmRsSnFUVXJ5Nys0ZHNUUHRiSk1tZFY3RWFPc0FsM3cralR0THVrdVdyRkE1?=
 =?utf-8?B?NWFyZzZISWh0dGNBalVmVWtXS09yTzJpRHl0YzFjSlBoVzBjS01xTnA4NzV6?=
 =?utf-8?B?RVQ1RUZ3NENXQStWb2l6L3d3UXhrNG9paWp6WGJLZ0Fhc0FBZVdzbDBHVXky?=
 =?utf-8?B?RXYzeXdLazdieUZOUHZGUnRtaUlrUDd4MWtuSm02SVZBQkhaY2EvcUxQZFBK?=
 =?utf-8?B?Vkd2dEJsdDd4Mk04WTVZTDdRSSsyV2U2YTBSeEtzR0xTbko2S1BackVrNVli?=
 =?utf-8?B?SzQxSzlkc3VkNDJTR0dOaUd0eXNiNm1qM3RMdklUSXQ2OUs2Tml4K0hhbytJ?=
 =?utf-8?B?NzYydXNVOFVETjU4OVdSNm44TVYvT3ZVUGxrczBJK2FjWkRyQ3lmSURxZ05l?=
 =?utf-8?B?eWkzWXRQMTZSZzVoZzdoQ1BuQTN4cWRJb0ovcmNLUmhtZGR3bW1WTmhLOTU5?=
 =?utf-8?B?Umpvd2NRbHIvdmVyM1lybHk4U0ZiOU16VVNodUZleXJRb25FVzg1b3lrNEpL?=
 =?utf-8?B?N05qUnJiRytSenFZUFFHa3liYjVoZzZXV2ZseGY1YjFPMmFCRnc2S1QzU2VF?=
 =?utf-8?B?M1ZVVjJPV1FzNTM1czVzWjVkakNGT2JSVGdPNnBHTE1qTENwK1FzT0tLUDFX?=
 =?utf-8?B?SFRpR2wyWDVkOXl4bWdyZ2NxTnE3eEUwU3NBUGpjcWJZNURVZm50MDRPWGlH?=
 =?utf-8?B?dTl5aEdJUlZYWFo4OENKOHBIWngrcTB3TFR6M0psazQ5TFlPTVlWNUJYTVNs?=
 =?utf-8?B?Q2VDL0p5cHpYNHFuR0ZOU2Nhc1N0NmtYTEEreUtHOURtTmdlS2c5YXFnYlpp?=
 =?utf-8?B?ZWMzYWxoVXZsSVB2MENlN2U2Q0xoQ2tqV252VW9yajE4cENQK0E3ODNhb3la?=
 =?utf-8?B?OVM3RHR4YkRPZVJ3TUgxT0tuSi92WFdtcWtQTS9QNWRBenZPdEV3RnJEd1hV?=
 =?utf-8?B?YlE3a3kybDRucXRKdThPNzQ5MmRPVEptc3BTbTE4Zm9nRVVjeVE1a3UvVlhG?=
 =?utf-8?B?blQ2SnV0UlFKYmltbFlpTVluZTZ4SXVDby9aTmlIWkRLRUFjOVJCMVR1V2xk?=
 =?utf-8?B?ZjZySHIrWnlMZFMwY2xFa0tyRE54bVBvT2d5NGp4bERIZTl6TTJxS3packlD?=
 =?utf-8?B?WTFNUGlLaVRaY3VORG1xSElncDdGTXhKaXVvSFhkOVA0NWh4enl3OEdNa0Uz?=
 =?utf-8?B?SHMxS2lwSXZ1aG9VU1R6a2s5LzBwb1UxclJJdU1uOEdndURwNTZsRTNUczE5?=
 =?utf-8?B?Y1ZmN1JoRUhVMnhpRThPYi91VG1mVEhBbmg1Wko0V3JSMW03ZTVYbm8zeG9j?=
 =?utf-8?B?WThFcUV4bGtwU0U4bEkzdHU1Z1BjRkptVUsxSzZNTkpKcGh0MXhkMjJKSVVM?=
 =?utf-8?B?by9xbU9SN09QRHNCUkwrOG5CR1RkVU9TNkV0dkJ5U2d1ZWcwdDRLZVdiYUJm?=
 =?utf-8?B?WFFkNHE3R0xhVGl6aDQyZFVEYTd2L0p5a3M5TFVPK2tKVGFpMkcyWWovbVZY?=
 =?utf-8?Q?kQqxTXuO5kR1hfmZgtOoLp4NLgS3MH6Yrgj6rgO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTExa1g0NWpjZG9HeWxHbDhlNkNxV2ZLd1JEZ2tRd1lWdGNtZHR6bkJDQzRT?=
 =?utf-8?B?SGxaQTJEYWNndStSLzVIZ1lHZzB2U2tEM1ZHSkFQanYvYmtYenlZSFozOHRR?=
 =?utf-8?B?eWNweDhjaHdmZWhXcmdoVkI3SFhPT2phRFMrbWkvTHlIUEsrcVRwejJrQUJH?=
 =?utf-8?B?SjZtOEhrR0dWOVVYQTc5YXlpeWdhcXlkQ0VsUjlyZjBTa25pUWxyeEhITG1I?=
 =?utf-8?B?bFZqQ2tqd09raDRhbGNoSmdGOXBCMFVUSDVURXU0VVVKNG4xM2VjQ1ZjMi9x?=
 =?utf-8?B?d0t4L0MzRDhYNTRYUGhQZGdlcXF4Z0lEQlVHY0x5NGQxelhTNlpWRXNmb1Jr?=
 =?utf-8?B?OTFnbVV3WGF4dHJ2ZzVBVnpsdytIa2dQRE0vUGduQWl2c29Qb1ZJVStnWkxn?=
 =?utf-8?B?UkozNDViZXF6M01Nckc1NGNJVU5NRCtraTJCTzBzaFQzMWFWOHZ1VC92amZE?=
 =?utf-8?B?TUdFN2RIb1E2aFQyYUxUa2QzczRzTHcxWE5PTUIyeml0a3hBZVlzU2ljcHVx?=
 =?utf-8?B?UllodEtYWGxlaW8vVlVKN08zQXB1MmpsbVJjS1VWd09JTEJEMzNjNUNadjZy?=
 =?utf-8?B?akpMRFF3YUwzK21pQmpFcHlnQnV4eTZmWGxnQmluOGNhUitGVnY1SUEwTDlh?=
 =?utf-8?B?MnpSRVkxcTM3cjJtbEhYVG1NejU5Vmx1SjRUMEJFazQzZGd3QlZNZXd2M0or?=
 =?utf-8?B?S2J3SXhIMDJ5WXZuOGFjd1FUZ05ERy9vR0d3QXZwUmt4NXpDN2crbFE1L3FZ?=
 =?utf-8?B?T0MyZ2djZy9JMnlSTUNTWjNHUThWK09KT05TYXo2WUhKb3FkR2p4bEtGN3hV?=
 =?utf-8?B?Y2xXQWQvYnMwQUYwb01JUTVUVUhNdkFZNVptVTgwbFRVblNEdVZ2dVZ0cHRw?=
 =?utf-8?B?ZVo2VnJYUm80R2RoOHc2eG9lYmF0SWNwZ1dGMzV1dnBLeUZLTjhUWFJlSXFw?=
 =?utf-8?B?RXRGYXhnTmhHTVdEeDdBeHlJdDNaRFV6V0FKYlp2S2lqallaclBwd2Z2ZlFQ?=
 =?utf-8?B?NGVHTGJrU2tvdm96RWNkYy81U0crS05oSHZMWHJoN2g2Z1NSYXhzYXF4aFpQ?=
 =?utf-8?B?YTl1Z1ZUbFN1b1NEanErY1BtN1R3VHBmQWdoK3NzL2hvcFQva2JWcmRZajdN?=
 =?utf-8?B?WG5jRW15RnNCZU9NUXNxNEY2WGIxWllxOElKZ1hvcXE2RXQ2N25OcFJCbFN2?=
 =?utf-8?B?YWUvQTJtTFlTQmZPTWdsMVk2aGxlMjVkaTIwNjZiK1dVdUhSWU5tL3hoODZX?=
 =?utf-8?B?WWljYlhtWUlwRXpOV256YnI1VG1YclU2YWtKdkNYQ0t4MFhBNGxibkVlNk5P?=
 =?utf-8?B?akNQa21nVnpJQ2RvS0tUNkw0NU91QnR6dERnKzhacVorVENjdDZWanFhRGRJ?=
 =?utf-8?B?RUVZTWQ5TjlhQUdhRkN1dS9qVGd2SzMrTUdvWkNhSE1PYUpRVHVtbXZDOFZB?=
 =?utf-8?B?VDZsT3BZN0RtRkFZaG9FN3JPRnlxOHFLbFRUOTRVSmUrcE5xYUZjRzJWQlFH?=
 =?utf-8?B?Y2N4WjNXc3dQR3JmMGJBendzdVZ5WkpaVWpyK2EybmhwemxyRzlFd0pqRXgx?=
 =?utf-8?B?MGxmY1F0MFdqMUptS0lMeCtYaVQvRWp2N011UlJFZ3poZU5EVG51eFlsTlgv?=
 =?utf-8?B?M3MvYWVyVEh4MWZUWlZMbU4vQjBsRklkbGVOQWN6RUJZeE1kbUlqTnhGdXUw?=
 =?utf-8?B?TTU3Rlc5RXZvWFdmL0xUUk5NMDhWWHhBd0NqR2h2N25YVDYzd2s1R1FqWjk2?=
 =?utf-8?B?ZGhCKzQ1TEFuMXg3QXEvSHVoaDd1SU05Szd3aVp6ZGZMVGh6ME1oKzdsQVBm?=
 =?utf-8?B?bHVxZHpmMWRHcFk2K2R5RGpLRmNVMEZIVVhNaEtGMEI1cGl4MUhQRTROdmk2?=
 =?utf-8?B?VkJaTFV1RlhaMkdkZExaUy9TamVnNmRuaXdZNythZnRvVzJacVdVRmhJZC9H?=
 =?utf-8?B?cXR1UmRBK3FmeVdITmlXM2tGZHNCYnhndkkrbE1mZHQwd2xWZWVOaUdDaEtY?=
 =?utf-8?B?bHh5YlhnWWpHWEI4dWFlUGJtMUU5L0VSVElhZGk1RUZ5a3laVTdxSE1kZGxO?=
 =?utf-8?B?RE5GY1FsTDE2QnUrUlc4LzFlQ3RBcnlrWEN1RHNEM1UwdXZ4WkVKTkJRR0Ey?=
 =?utf-8?B?eVBhOURrUVBqcXRDbWVlOFhhaVkrOWFwdWw4cCtnN3hiWWIyYWQrcDBMZ3F3?=
 =?utf-8?B?Tm52N0JocXlaM0hUbEJxMGxZWTdQeTgwODAxL1ZiN1lTREUxVEd6QjdRQno5?=
 =?utf-8?B?YmlNUnVNYlhwaEdIQzdPeFE5OUpBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m48H5z4iCgFTWcA8fTYdxDK8vNLE9DjAQ4ds0MNbZVVHGvgQjQzfl04BkYLvs4A9dy0iJDZVkf3Nvtw4xCVt+53QZeNxFT85o6vP3aLvtrngO400TVMY14aKq5MdSudaDCKoPnTvroKIQAx4i4KLXi4hGyvfPVZ51zQ0XZnmw+PRWHg/tbX155JU70GTMOX2Bnlb7WKXed/fj5lrEFNw4I7+ZrrrjUpOjkZq+LUtF2hrjaTe5V1u/TuxnGGT8X82d8DyRZK0qdV/cDMKt7gu3Zb3lESarswGgGT2bEt75msra1RVjwQgo+/QtD+S2XjBLxP3EijujYjY0mvcLHmj+CzDWah3qDmrv/qxTXUyqrKCGQCSGgkzi29WMBf9Y+BHydfTNEJrdmlU37eLS/ALoC+9yjfkX6UtX7xEiEmmaTTbWjTmbiU0RO4ul4ijVX0jqzv84ud3RjSELPCYYBzNnfbGAS1JTDb2vK71jC3QISir5dCnz4e1JNUDbSBAViuv06EzutBxe2FTKCZ8YonKlpSpF7XP1D28xMe6Q9d7mLOpfzLnNlYl7jIyAFWSZsXCLlVUMx22tCDQ+OfFKCpNGBRTC4/z8Y/pLEaJpz460qY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43895c86-7be8-484a-ba43-08dcee322796
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 22:30:36.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+PMw80fFfH7V2po7bUFpE7JDdJbeENVtFxcJcP57II+i8HGKGFCd8yfoM59gJOEko4m1Xr4dayYd1BZQbrgw7hQNEQI9V8iaGaFknpbQIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_17,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160143
X-Proofpoint-ORIG-GUID: 1BDbttrMSazcUtn626PEDTQ-u8N8WJV6
X-Proofpoint-GUID: 1BDbttrMSazcUtn626PEDTQ-u8N8WJV6

On Wed, Oct 16, 2024 at 11:06:34PM +0100, Lorenzo Stoakes wrote:
[sniip]
> >
> > The import will be fine and you can control that with -I flag in
> > the makefile. Remove these and try to get including linux/pidfd.h
> > working.
>
> I just tried this and it's not fine :) it immediately broke the build as
> pidfd.h imports linux/fcntl.h which conflicts horribly with system headers
> on my machine.
>
> For instance f_owner_ex gets redefined among others and fails the build e..g:
>
> /usr/include/asm-generic/fcntl.h:155:8: error: redefinition of ‘struct f_owner_ex’
>   155 | struct f_owner_ex {
>       |        ^~~~~~~~~~
> In file included from /usr/include/bits/fcntl.h:61,
>                  from /usr/include/fcntl.h:35,
>                  from pidfd_test.c:6:
> /usr/include/bits/fcntl-linux.h:274:8: note: originally defined here
>   274 | struct f_owner_ex
>       |        ^~~~~~~~~~
>
> It seems only one other test tries to do this as far as I can tell (I only
> did a quick grep), so it's not at all standard it seems.
>
> This issue occurred even when I used make headers_install to create
> sanitised user headers and added them to the include path.
>
> A quick google suggests linux/fcntl.h (imported by this pidfd.h uapi
> header) and system fcntl.h is a known thing. Slightly bizarre...
>
> I tried removing the <fcntl.h> include and that resulted in <sys/mount.h>
> conflicting:
>
> In file included from /usr/include/fcntl.h:35,
>                  from /usr/include/sys/mount.h:24,
>                  from pidfd.h:17,
>                  from pidfd_test.c:22:
> /usr/include/bits/fcntl.h:35:8: error: redefinition of ‘struct flock’
>    35 | struct flock
>       |        ^~~~~
> In file included from /tmp/hdr/include/asm/fcntl.h:1,
>                  from /tmp/hdr/include/linux/fcntl.h:5,
>                  from /tmp/hdr/include/linux/pidfd.h:7,
>                  from pidfd.h:6:
> /usr/include/asm-generic/fcntl.h:195:8: note: originally defined here
>   195 | struct flock {
>       |        ^~~~~
>
> So I don't think I can actually work around this, at least on my system,
> and I can't really sensibly submit a patch that I can't run on my own
> machine :)
>
> I may be missing something here.
>

[snip]

Some added data:

OK so I asked people on fedi to compile the following locally (also a
variant with _GNU_SOURCE being defined):

	#include <linux/pidfd.h>
	#include <fcntl.h>

	int main(void) {}

And they are all encountering the same issue as I am on a number of
different distros (ordering of includes doesn't seem to matter either).

So this seems like a known-broken thing.

And we can't really isolate inclusion of this file since all the tests
interact directly with defines from it.

So it seems the only solution is the workaround I suggested previously I
think with the header guard define hack.

[snip]

