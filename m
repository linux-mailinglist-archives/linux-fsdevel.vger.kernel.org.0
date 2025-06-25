Return-Path: <linux-fsdevel+bounces-52965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B02AE8D03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD54017E3E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5162D540A;
	Wed, 25 Jun 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="DYTM3xmr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DD1CAA7B;
	Wed, 25 Jun 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877524; cv=fail; b=u5jUZTBLtSjOaI6G+Wpsu3w7TkvpAiIdUeRsJjRan+nMndHWJj3vL2Et9oXvb576DDjjXDJf+aTQkKsDC3BB+OhgG/+9rQzmvtMKmEWW1wMZJCDnQjxlH9XGaW+bsGkA8XsvRAZ25XuDsb20D80oARgiWfgE+CqlunC494DAllM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877524; c=relaxed/simple;
	bh=Kt4tUNPijni+RgS00+EFQOE3CLaAZ7AnCuo6YRK8prc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kh3xfHpCBnwOMHt90JnHyF+0C6BpgIqMalKaGZF3pvNZCCIJ9vW7nFXSvenuR4zv0c8iFwsTyQXjSDbBBW12q2weISUx6UorpmyclKeSydkBVXnblHF+BnYeQuWAVhcjc0qFqiMIyxgPYE/LNs1IpQnhT937v57B3tjnzoCN3vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=DYTM3xmr; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Received: from pps.filterd (m0316039.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PAPkc9000775;
	Wed, 25 Jun 2025 13:51:37 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 47eeu8npay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 13:51:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+GPddJor9YVsuFkHshnR6ZVVd15gEslRgLTUgPgtmUdmC8QyowfanYKJO3ekCrTJ2fzYArI6SVf47F5yrc8/PnokqZeSeQpxhLl6F0QU7F61GFLlw8MZuwAMOo3vX5Ll0oqOxG1DNqQ2c6dpgtg65cAcBD9JMgxZSydDbeQ+ZZ4rYp3iCo9TkFM169mZvp6tA907RIS5tX22mdCgKCXF/39HcVMrA5Yx3IEre6nGnk1C8o+VLwKksU3W2P7P/SgZakAXNGI+9PU7JkjIODNvuBJa/H5/fMPHBFYQSZe4dcsse7Hx0ZqAAKP/wYgfiymTGl/663/1qchbVkLnWlvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caaod2XwH4TuimNaj8B2TlKSv6Q7DGRW9AQnCFqiYlg=;
 b=clfAKAAR+Cu5YU01acysX7K4IjpUv1udRF8JLA2P4YyQYKa10Z2f7ylxCYTKpBWi6xjfdWl1uppJHEzAdqk5DXvz35KWRuHtRp1SYwdrtUuDZLqzHm3SDLocPG1zBK8Sf9BI/h66dH8uJNcghmBMgQs6e+6ni//rqjnbj4AOgwlD+cF5oYR7JsTl0QPGT7KQDYyLZiswoU4xqCvIRurbwPWokbwo6jQqsfEY1rCIiZJxQbTdrkyou00sBcjnZLWGXGsJ/8QzvAS7MH8QhxVQA7ODdNdCkIIYAUZW5NdIvvgkF0UG0yMwhHnqRnFj2Gv0SZNMeR98Cfl4U9cK98Iogw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caaod2XwH4TuimNaj8B2TlKSv6Q7DGRW9AQnCFqiYlg=;
 b=DYTM3xmr1fO+tLHA0qB8gCTlpYjnXlwBQbEp/zCBcBzDq99xJ37qxMsq7ANXDPCz1H+5cyj3rlMcrEIyg8KOGrFMwgUV+qbyyQ6sNWvYQF4fjf0WwIOZvCtFu5g8CgSF98nuTAD0X3iXkgZ9l8irWdEXrVBFij9zrDFRoaGWz4lphm5MDZdXDBNzc47zfmAOq8sEA0r1xdq7RNl5WkfzNjOY0p+UbyD+5RNfNqr0ZLtayohuqYsaztOmGPBdQ8sR/sEt7YndJQG9KORJIsp9KJTue4+EL910m1XeOCb4K+JGrLR/dyJWcY5gEpC1ogDg0rgQJLx/HhAEC432oJNGCw==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by CH2PPF90098843C.namprd06.prod.outlook.com (2603:10b6:61f:fc00::4ed) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 18:51:35 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 18:51:35 +0000
Message-ID: <bc25ec40-bda3-44d6-b9c0-d27f7b35b7cb@cs.wisc.edu>
Date: Wed, 25 Jun 2025 13:51:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/vfs: update references to i_mutex to i_rwsem
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <72223729-5471-474a-af3c-f366691fba82@cs.wisc.edu>
 <bi5e6qyg6htcmuocfahgvwxx2djxyeorhlc425y72pggmvw4hi@dzfheotxoz7j>
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
In-Reply-To: <bi5e6qyg6htcmuocfahgvwxx2djxyeorhlc425y72pggmvw4hi@dzfheotxoz7j>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::9) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|CH2PPF90098843C:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f7f2f5-72f4-4e11-f0cf-08ddb4194f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|41320700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzhJZTI5R3Bpb1VVMk9uR2Q3ZWdvT284YXVjQ1pJc2dJck4xcUdjNXBLbHh4?=
 =?utf-8?B?SlZGUWdzdnhvZkZmRTlraXp3WExITFM2UHBPVUg2MHFINHYyZEVEcUpVdmFj?=
 =?utf-8?B?Nkh1aUFZSTJteW5CbWxHMnozc3hVcVdpdUZYRXNkNVdSN1VXRzFvckVNbmlw?=
 =?utf-8?B?N0FDNnBZQng4WWo5eHFjazlydk9WNi8yTUhURCtkT0ZrUzhhckQwVFAyWlJ5?=
 =?utf-8?B?VXYyUGdQdk0xR0Z0SFkzZUUxamtGdlJxVzF0NkNqU201Nmd3cXRzVjI5REty?=
 =?utf-8?B?a2EwLzlhR0cyUXNLWUx2OXE2d2dDRVd2UnNGenhUYVJ0c2Jva21yRWNPa1ky?=
 =?utf-8?B?SkJtRWp6NnNXY1RZTnV2d0d2L3VZdmYxaVNCKzFXZ1k2RVhCR3QvdzhwOGd2?=
 =?utf-8?B?SzIzZEhjcEtqc1QyWUhaUzhBVG1xeW9XSVQrSysyTmljMXBGRnlDRzA3MkU4?=
 =?utf-8?B?TFdVRUNxNittcnFUUGk1MEFvR0F2aDBXekhOdWt4SVc5UStjQ1p3Z3lBcVhS?=
 =?utf-8?B?TERSOXFMRFQ4N2VWazFlMGhSUmlQbXEyVkd4bWxpL2NQNkdvWGpYYmRDZUhX?=
 =?utf-8?B?Qkk4M0NMYXBrNUlCVUlqMk9mbTdza1RyRVc1TDRVVGI1eWM4UFBEV29VS1hz?=
 =?utf-8?B?TC9pLzJibzVvNmJLN1ZHbFlwY3ljem1SdDVON0tNeVFHLzJmcDZjYXBBVVBW?=
 =?utf-8?B?NmZNMWg3cmpJVXFGbFpqMzlxcHcweURCYTFiQWU4U2prZGJFRUVyNXFWMGw3?=
 =?utf-8?B?ZHZkbnFVVkN1MnFhZzA1bENSK09ia0IxSTFobTZQWFpZdjl3cDVnZ3hyOHVS?=
 =?utf-8?B?a0RTZHJ2aWFxNnZqUUlBTGhxM21lTEFXb3hGaTlaMzlCTXB5djE3aStIZFBv?=
 =?utf-8?B?QUxKTThyQWpzRUhYck1EVVN3d0JORVVmZUdyTzRxNDRSalcrYWtra010ZHd5?=
 =?utf-8?B?WmhlWmwwT3JUQUE1U0N2SW9Bb0RyL2JDNWNZM29Kd3lKUy9vK0F3TWRSZFNB?=
 =?utf-8?B?bS8vYVBIcUMwNktCU0dZWTRnd29IdjNvbkZONWNlVStYYm5meFg2Mmp2VEF3?=
 =?utf-8?B?SXhCYWRFdThtdWRscVNRd0ZtdlpGZFpUbjJmbHlqdHNVMktQS1k0VmxpSytV?=
 =?utf-8?B?RmFMRkZGMlNCbnEzYlVpTXpCR0luSXd3MTVJenAvdGZqMlFrMDNzSER1RFBP?=
 =?utf-8?B?Rk5FdTBPdDVyQ21xSDBBUVVrTHhQQ0xETFNkelpMcUpTZ29ZY0N4L0NsU0ZI?=
 =?utf-8?B?dXpPb3k2QjBBR0MweFk4S0tLcUc4VlBqZnJZREZzNjJZOXplWTA2cDdjaStH?=
 =?utf-8?B?TVNYQXM4OVA2ZUQwTm02bStZQVVyNWhUNUp0QXNEMVZtMHI4aGNyVCsrQWsy?=
 =?utf-8?B?OE4wQkl2YVAxTlhORnRqeXFGdXI1UmdGSm9oN01rWE9nWVkvdnhaN1FCekw2?=
 =?utf-8?B?YS91eTFwU21md09KZHhvUEVOdjdrVnhad2Mzc3h0SDRialBTUGNBa0ZqNjdD?=
 =?utf-8?B?Q0NpUnpRUThtbEZQUUd5OXFqeVF5ckp0QW8wZFVrRk5vQVBSY3lCcHFtNWpx?=
 =?utf-8?B?OGxBQjVWNitrcWhIcGQ4T2xnVDhrRzdkcjlpMVdYakFOMGdiYmhCOHhSaFpD?=
 =?utf-8?B?L1RtZVRIbHh4M1QxOFhtSU9rMW50Q3VJVkRuTWt3T29TU1YxL1Y2UWpmUTZK?=
 =?utf-8?B?OTJmK0Z4LzU5cXVoRElzcDUvdDJjdjdXWXMveXZjVUVsRjBwalFzVzZvSita?=
 =?utf-8?B?NGgzODlsVkV6dEMyai9ObWY1dEpScS9GQnk3dGwrclphRUFRaFJzTXdWQ3gy?=
 =?utf-8?B?ZjQvaVlXbmx0L2lXUEJFd0V2eFZJd0Q5MXZFTDJDd3JkdVdGTW1ORGc1VnFU?=
 =?utf-8?B?NU9lamJuVW5YSndRTHJ0WkE5bTV3UDhOUEhvN0xKaFI3NjkzZCtzdWhlZXor?=
 =?utf-8?Q?t+q8pU2z544=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(41320700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG51MzkrU0pFWFRMeS9CWWpremN2ei9oZTBvNCs3VGt5R1JpRkpmeG5abnZ6?=
 =?utf-8?B?bEQrMzBKQnhsZjhNS21ZWGRMNXRzaXEwTnQzakloaTJFNHhTck1nYUt4UVB6?=
 =?utf-8?B?L2xJK2JGKzJTYnNPcDRIODR3NHZWTy81MFd6TWU0VUZjZEt5cS94UUUwR0ln?=
 =?utf-8?B?SjYxRVpneXNMblVnd3JnTm9SUzVoVENvbkpLbStQcE9acVhtSlBra3Fna0lY?=
 =?utf-8?B?QXovN3MxWFdEdlhITnFqTExWajA1d3dEUS8rQzZXVWs4L0s5Y3lvMUQzdllU?=
 =?utf-8?B?eTFHRWlNNHVwSXRDQlVWejNNSkwrSGFtR1VvNXgzOUtRbU1TcU1UWFpVOW5p?=
 =?utf-8?B?OElUMCs0NHhyNGk0OFJHL1pDeFlJWHVsWFZXZnZQUTlIUi93c0tiRTU2LzFn?=
 =?utf-8?B?MkZhejl3Q0xYVEtRQlhEM3ZkTmJUd3lqK2ZYOE5ndmhLUUlVSC9jMlZPN0JQ?=
 =?utf-8?B?ckl4MGh2a0w4d1B6dDVrMmUzdHVKbU52RjYrQ2FzL3JyVGpNQUM2aTJDWk1X?=
 =?utf-8?B?aWx6dFo0VU4veUlVYUtYY1lFLytwbjhpUHVPN1FUVVpFZmxnVU1Da2hmamxW?=
 =?utf-8?B?ZUZQTGJ3SGdLVzhSUlg5Tk5TOGNHc0x0aXFIUW5ZU2F0YXdFUHZjZ1ZJUTRk?=
 =?utf-8?B?YTdJZkZ5cldRUjNDOHIwZDI2cXdxeFBiTzFab0hCQUptY1RseTVtWGJkdmhI?=
 =?utf-8?B?aDRmY2FrVERKTitMMkJMZmluYlVNMklLNUdDaE10M2VLM1p3dTFMa3Q3Zmk1?=
 =?utf-8?B?RGxHSDJEOTdkZmNOdkxYc0E3WVVnT0xUcU8yNG1VSkpVTFBRRE1sVHBQV0Vq?=
 =?utf-8?B?MnBCMWpvQVFxZ01rMmpiMFJzcGgzR3ltMkRGaSt4dzZpNVY4aSttUlNSeFZv?=
 =?utf-8?B?bUNORkd2ZFpHZGl3NDBESnlvRnhZejMycG9EdjYyL3FFNEFxckdBb1pSNjlW?=
 =?utf-8?B?MUl2WXpIRzZzUWFQcGx3M0o1ZEpOekNFUXl5OW1Ob1NFeGlKNmpDZG5Nb3RS?=
 =?utf-8?B?WDRIc0NkMFRySjdyWW5EQU5uOWd4UWd2ZUY1ZElqOENLbWoxM0F1RXpVVDhX?=
 =?utf-8?B?N2VQMktwekdGY1laeEFXcGx2c3ZsQ0F5T1F3YmJ2OGNqRHU4M0JqdCtVMW1S?=
 =?utf-8?B?K0NoOFhXVHZnWkV1QnhBNHowdUdGcXNwNGU4NGgwb0FGYWdYTVRVMC9wajNY?=
 =?utf-8?B?cUdQSktISzFvWDcrSHNDbDg5VGg1NUQreTcrak9XM0RuL3dVMmlkOWRHS3Bh?=
 =?utf-8?B?Yk5LRXFsRkRHVkJ1YVFtT1ZxWUZIcnh6VWd0MG1mUXBHcndoUENBOFB5WkdB?=
 =?utf-8?B?KzlWa1NTQWJZcWttMjJCWG9ETm5xb3VWSTZubm55SVpjR0pMUC9nQW9hVzVZ?=
 =?utf-8?B?RFQvbWhpNmVmWFNqM1RWdXh3SzByQ2ZhMzVTNU5sL2ExbTdUQ1lyamxEUGRm?=
 =?utf-8?B?aVRSQWpPcEtHb2R6am43Sk1rTm1lRlpYU1RyR3oxYWFVc1JkOW9zZWlqT0wr?=
 =?utf-8?B?TVpUOEhST0tLQzVyekhhZVlWL0R4dnAvMnljVW9mSDB3b2d2NXpZclY0ZElv?=
 =?utf-8?B?MWJEWVkzV2x0aTg1b2JGNG1ob2JscWdCUnJZRzRlZGllVDY5SkNFLytXbW92?=
 =?utf-8?B?Zm84Mml5L2hUMVhPWWM4MGdRSnk5a2xPWnNZZXNlcStYY0NMUnFzVWpEZDVr?=
 =?utf-8?B?RHBIK1lrb2Z2c2Fmak1lMW9jMGlmcktkQTY3UFg4cmVFM3hVZHNjYy81MENi?=
 =?utf-8?B?ZEhyUkphR0JTNFZNYWhwSU00NmJidW5nZFRxWXdGY01LVjJtd1BPblpneE5a?=
 =?utf-8?B?bmk3YmFyRkxSTk9yYVFPQjRUWjFMbFMyMzFnRllmWmVNdms2Q3o3clpMWm51?=
 =?utf-8?B?SDVDOXVjYi9xZUpRVVFyV2lzbXVhckhFZFFRd1BvU2JyQjJ3aVFCbnY4TmtX?=
 =?utf-8?B?c0VJSXkveFJqR1pNTnRMb0xqK3hvUzRyakNTOUtjMU4weDROWVYwdlpXNWNv?=
 =?utf-8?B?MGUxRlBrck5UV3dKc2IzbkNRYWlaQThGV1NBZkkwemVqWlptMGhtRzdnTUtw?=
 =?utf-8?B?M0xnY0tvc0hXREZnYnRaRE9PK2pCQzVjZXNWVERPaFJ0SFhnNDVrOGZINUJI?=
 =?utf-8?Q?cQdo=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f7f2f5-72f4-4e11-f0cf-08ddb4194f16
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:51:35.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezH3Qdy8sHDCzdOheDTNs0sRWHechHtC3n7PiXZVEh5n6Wti9HNJ0j2ZVslpz2N+Q1el+iIDMWHdnVYlyBG9Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PPF90098843C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0MiBTYWx0ZWRfX0P2iP2LJ1Jtj pEnhccmR5xEVKU+1fufdOEK8suLgxQTYG72ZnMgvyDHJR4HPnfLbge6V7f/2kpYFvsBj1pJxIFS reFfIYAL/LmZH1A6Dl7rlnoSkyr1Kp2PxuXUTr3/Apt+PnEi7PdMrJHaXiccBEgomONSzKgNK5o
 YA+qVOudNXhJEsUrrBrn/kdWahby857iABcYNaXBPwwDXf6WsBGQOaRoUIieNTUbfEC7ziz/UJ2 YWV1w//zitpsqhloDmKsW9ysE93iChY8dDIGgYDjUcdSPMXSVaLMUD3dUYefzVsqMs2ZUpsTmKx Sgfm+b3UCL92AlpQ2EvCxPAYluUIPna9sczMsDiMGr42fD/a4UF2+5deA+k/e+qEDS5k9LEKf9J
 GFTb/yYVw6L6zwYHX52Hk/vN8C8Yblm8PS0BTGIy2fJn/Mke92xrCohkWNyj+i+uzf0o5/1g
X-Authority-Analysis: v=2.4 cv=VJfdn8PX c=1 sm=1 tr=0 ts=685c4538 cx=c_pps a=RytzCX+8eATlvKXUbdY7Zw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=3-xYBkHg-QkA:10 a=Ka1H86641UT6p9SQxuEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GH1YR9pv-GvDsoiThfd49xR6hZWdL8HY
X-Proofpoint-ORIG-GUID: GH1YR9pv-GvDsoiThfd49xR6hZWdL8HY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250142

Hi Christian and Jan,

On 6/23/25 6:09 AM, Jan Kara wrote:
> One comment below. Christian, can you please fix it up? Otherwise feel free
> to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
>> index fd32a9a17bfb..dd9da7e04a99 100644
>> --- a/Documentation/filesystems/vfs.rst
>> +++ b/Documentation/filesystems/vfs.rst
>> @@ -758,8 +758,9 @@ process is more complicated and uses write_begin/write_end or
>>  dirty_folio to write data into the address_space, and
>>  writepages to writeback data to storage.
>>  
>> -Adding and removing pages to/from an address_space is protected by the
>> -inode's i_mutex.
>> +Removing pages from an address_space requires holding the inode's i_rwsem
>> +exclusively, while adding pages to the address_space requires holding the
>> +inode's i_mapping->invalidate_lock exclusively.
> 
> I wasn't probably precise enough in my previous comment. This paragraph
> should be:
> 
> Removing pages from an address_space requires holding the inode's i_rwsem
> exclusively and i_mapping->invalidate_lock exclusively. Adding pages to the
> address_space requires either holding inode's i_rwsem exclusively or
> i_mapping->invalidate_lock in shared mode.

Sorry I missed that part. Could you please fix this in the commit?

-- 
Thanks,
Junxuan

