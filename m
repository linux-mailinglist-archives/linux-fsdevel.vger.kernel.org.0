Return-Path: <linux-fsdevel+bounces-50129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F12AC864C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 04:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E70C4A3E20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 02:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4FD15B0EC;
	Fri, 30 May 2025 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T0ySgGO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013041.outbound.protection.outlook.com [52.101.127.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BB4A1D;
	Fri, 30 May 2025 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748572934; cv=fail; b=QuIh/vtNtVygqHASCOifPW/SvPLu8JNv4Buq+EJZfwsmN75qDBpxHs+qi76qvMxwX+cZJjkCx8BGouRJcewofPjQup2rQn+MUJVWKAWLUs/VeAYPF/xHf5uf1qT8h94PDwYS0cM3reX/suWv3P4QdlKSzIqA0QRmPpQc0KHbkEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748572934; c=relaxed/simple;
	bh=PY9j124YmnfR5k79ufQwSUlGfiDbITPSU5FSdAY6sCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mdBcf5jn6MgJTSptGmKZ/0WUn7G0p5CIAVMLkFWQN7hpRyOipVY9oh4rgCFgVaK4MfWKWIuP6niGqz7vwwgUJS+O9zd28wmSaecoyaVZDQjcMTsiVLhryTfrLPycT3HA4YU6yebwGwC6xKymsNStXQwItvAfHT1wy0w7WOO2SJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=T0ySgGO/; arc=fail smtp.client-ip=52.101.127.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ5DHRk/0OotAZT9JFxBudLYt/QlTGAlbUUraPsNYoHh9nann6ACq5i/XDHJ5Hli9xyjCu1HPIhlkIPW5zOge7KCF6SNCc3IMLsjzykUXT4PdS2O6Y2pcA9nrphg2rgG7Vmg6fXAAsFBeDge+KCeznNSsfmI0g3Ch+PZ00l0Zd7Cf9I7VUzwx1IEzgr+cPCuPsmqkfv9FUzcEh4Js6JbBDwRlBvR1wWBj27IgC/pXK9bacFY+SGdPKNaluXd3saOW6rcARMTJZHRuYgvHufRNonTamB0yN7+gWaLd4xyVBiDzTfNZbL/oeuhKFjSycOAxaIBrApqipgS4X+P6bI5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btAmoaFX5bBSIOzgGTh1NeLLCrJ3z+jPLSjM2ltXWMc=;
 b=mperxQTyo0bXrrcVzVDrJ5FgMCG7t4wZ7zvY+XA6JRhuGV402WKIa3hjOI0/0XLr+ASP2oMJ2ZNvhCJva+58HWFoz1tMqOLn1Wr0Twf0OGoXDgCaknoAO9Yh17H+UZBcAGg59rC4T+owPWlSnzyoMFUF2TKcZABr/S0P6y2oh2QoMszte1LAtUvSnd39THUtcGdEBJTdJJsK31sgVKpX8XisEBc0maGqlc7EwfOCFO6xPE9wJDOHrYqvbBZYM106O4T6/MPu1vlJX5NaAiA2zx1wu28JzBp9SGjRHAIV1/Pwa2fDAXRxN3qOzeRMzoNvfQOyj/U9Sgqkttwg+3iylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btAmoaFX5bBSIOzgGTh1NeLLCrJ3z+jPLSjM2ltXWMc=;
 b=T0ySgGO/+NL33imH7lfjIm/kOXVY6oeOdxP2C6irU1ch58eU0Mq2jqTCf1rqYERgmplVZ+TYzNteLUeI+wkax7Vdkv6ocbdFXdpk3f2DLH6CoEIqNCQnioBqhtDP9+6uGHnVWl6Zg9hfP57cMsaarFvrAyD0KcwCrOBUrZG8fYRapd4aGihznIE3B/0X9/UyIHw7cpPwgFcxzmQf1+VtY9aPLXnDU7wVwrbz6v3roIpQUwJ3VvAgmVcMBrma8/ObJCPjdyy8bZeL46pB0z2GrKTFewKPtp/PfcWn0iyNSCItVCaGsU0rZZh++uqoDgOxJH3BNrmW227vzCck4ghlgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5546.apcprd06.prod.outlook.com (2603:1096:400:329::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 02:42:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 02:42:03 +0000
Message-ID: <be06df1d-3633-4d94-95bf-61889aacc6ac@vivo.com>
Date: Fri, 30 May 2025 10:41:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hfsplus: remove mutex_lock check in
 hfsplus_free_extents
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "ernesto.mnd.fernandez@gmail.com" <ernesto.mnd.fernandez@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com"
 <syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>
References: <20250529061807.2213498-1-frank.li@vivo.com>
 <2f17f8d98232dec938bc9e7085a73921444cdb33.camel@ibm.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <2f17f8d98232dec938bc9e7085a73921444cdb33.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: 52832780-fb30-420f-fc1c-08dd9f238f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjFabWM3aGZrUHhQb01IWGYyTXFjeDR6QVFBWVRjMGxZSlExZ3FVbDQzNEVP?=
 =?utf-8?B?cWV2S3ZJRWp4R1NpbjArNlc5YnZkSHlmZ2VSdmk3M0M4TGFpNU04OW51enZr?=
 =?utf-8?B?bmRyRVI4VzI0VWVKVHo4MDRVVCs5YVR3REVEZkNGSnNNU2VjaUtSc1gxZERJ?=
 =?utf-8?B?em9uU2ZZb1VFZkpieGhxSWZmb0x1eUo4ZTlYRWlWRDN4QmhuZ1pwZTBoSURy?=
 =?utf-8?B?ZVRSMmRjcURjMnZienJCazA3YUFIWDlhdVloZU9CYW5jZkVGLzR4ZUkzQkhE?=
 =?utf-8?B?QVppS1hINFZzNnp0aDJob0d2SjZTQUlKTzVxZE43U241d2dpdkx3SzRjMTJn?=
 =?utf-8?B?ODYyc1pHWHVybU5MSGdiM1pJdjZucVhBS01YcEhvUUdPTUtDMUt0ZUZpeUlV?=
 =?utf-8?B?MjVaYXRVRHdhdkRwLzJGTFlvaFZISUlUNW05N2xJZjRiMWpIVy9qeUpzdXNo?=
 =?utf-8?B?dlBubTM1QUZoelUwc2xMSlM3bHdwczlQUFdYUExFTUlmdU9OOGRBV3RaRGRD?=
 =?utf-8?B?a0JDYjhrK2tGQUR5VmxjZytTd1dXTFBHQW1nekx2azNmdXFKT0xCU2ZqdTh1?=
 =?utf-8?B?ME10YlNoRlAxN09QbWR4TmhldXdUNWZvdmtENXp6OWxLNm5sQVpDbThlWis3?=
 =?utf-8?B?V05oWWpFeHdSTFpTU0lXWlVjbTVEVnNhRXJyR2FsZFVkT0NJaTROTklZZlZO?=
 =?utf-8?B?aWpwRkU3aGNseWJxNFBJbFN2QklaNW00R0JFdGVDSGhJWUY5ZXJlek1ucnhV?=
 =?utf-8?B?SU9nRUtnWTFISmQ3SEYvVDQrQ0hTbHNobHFpSVQ4TC9GaTVVMm1DUm0zUEd4?=
 =?utf-8?B?UUNOS2gzMGRxVGpiZXIxdWlVdjBWQ0R3emJoMXJqY2pSVnpUQy9tRnNxNTU3?=
 =?utf-8?B?V3FucFpjOC9WZjZhV0g5UGgxY2MwUlJBUHVrOHBSYkpkdGozalBNR2Z6RHNo?=
 =?utf-8?B?S0YyT0tid2ppNkZidWE1ZHhHV1NVZHU5NHdzR0RLTVNKZnF2Z1hXVWJXRGhI?=
 =?utf-8?B?aFovMGpXVVY3bElPYWpuMXRPVHdIMDZMVWdHTVB0d2VXaFpaVFdvV2xRKzVh?=
 =?utf-8?B?R0Y5ZTNUc2FaRWpxVnVrK1Z6M3BrQnVublBaYk5qQ043a0lES0p6a09kSFZG?=
 =?utf-8?B?QUtUY3NNZ09mOVlnUWdqSEdvRWkybzYwYTNNRWtGNk9FN25YUy9xOUpURUVk?=
 =?utf-8?B?WnMxbi9jSDhYVXdYWDJ4ckJjaEptYXYyY2VUU0tydkJjdjl0Y3d0L2hNMW05?=
 =?utf-8?B?VU4za0tqYXZtRFVlVit1dkdoUkl3R1YrWmc2NElLc2IxUEJQUXpOM0FING0r?=
 =?utf-8?B?WS93UHQ1TnFpczRGOGpHSkxBN3REamNNTzlPelRXc0Uvb3ZneTNyYXI3RE9K?=
 =?utf-8?B?R1JCNCt4WXBaUlQ4YjJhOUMvYjRSNDlVa1FsZjIyRXE5OFBzcTV0K2gvVWRv?=
 =?utf-8?B?S2RQb09jRjhoT3JpK1NEL0VMNyticmk5WlJvVzlXWUkwUnF4bGVTTFFWRkdu?=
 =?utf-8?B?SmJOU3ZLTmY3eSt4UWFjK0lKa0U0ZWhJV2xTYTNsTzEyWkF4eXJ5NXU3QVpk?=
 =?utf-8?B?Y3JCdFBOSWk2c2FvdEJYUUlacDRBYU5qWUhlenNDS3FsOG1IbEw1Uy9BUzJH?=
 =?utf-8?B?cU5qVDkya3FQOTZzUUtaK2dNdHJEcU5XK3E4ZW5veEovSkMrMzdQL3lyWHV4?=
 =?utf-8?B?bVZTZitEL1psbndlZFFkQ3o4NjZYcDYvcnVWN2VaYWdCOUFBeVllV0lSYTBt?=
 =?utf-8?B?cHVOcTN6WndUTi9IRjZLeDFpYXdiU0hvcEx4dmVpM3JicHhmUzYwWk1vcU1x?=
 =?utf-8?B?M3ZzRW42V1BNdmN5QWdabzc2THFwWDRZM3hRVWdxamJWYUFuK1ZqSGJzM2ly?=
 =?utf-8?B?NDFHdE9xK1dGbERtaXdrM0pOaEdEWWJoZU05cU9rVDZUeFR1Mmt6LzZCQ21E?=
 =?utf-8?Q?nx4QrBawsfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkpiZWcxQkxxZSs1SmIycGR0eGk2aTdQZHhVemNPUHJ3dWdjU3hpR2VHejla?=
 =?utf-8?B?S1pVMVNYNFh1QUI1NEFxaDVmUjRaeTBzamJGOHdSQWY0eFAzUTlKOGdqc3o3?=
 =?utf-8?B?SVJDTURHYWUzV2wyZjdQdmM4R0JuczVQSmlpYmxET0hwSXdzcWhtcE5URHlt?=
 =?utf-8?B?L094ZTh0UG5tQzh3MnhnUGprNlZnZWlvUnQ1T0VYSGR3SmhFZWRtbldEWWVa?=
 =?utf-8?B?cW1yMzBOSmFKVG02NkxlZFZOUUw2U2laMDRUYWN4cW4rR2pvK1gyQXdNSGNr?=
 =?utf-8?B?U29PQndzOXBvMlAwbGNUSVE2bnJHdDArekNsc09pWDE1anpMMVFWUWNrOHdX?=
 =?utf-8?B?QlBHREFjUCtTeW44MDZKTTdlejlNbWoyVmRaYmFYTzJqUnFycmFIbWtMLzRy?=
 =?utf-8?B?VnZKVWNZZFg3eXlYUGtPQ2lxZTZXS3ZpcGxRL0dpTUtHQmpGMEdXdkh3alV0?=
 =?utf-8?B?SnZXSEFQN2l2UHdrTVhhZDJwYlEyUTRnSHMzNlRDNURteXBRcDFFK2N2YkZw?=
 =?utf-8?B?RjZDclFFVXNHeVBmZ3JNeDZ1VUoxUjErS0NRNkFKYTNlR3RIbDQ4d002VkZq?=
 =?utf-8?B?YjlKVVFTYWJKZEloZEVuUEJkZS9BZnVXQkUrQ2pIb2RVaWk4K29OWGVJZ1Nz?=
 =?utf-8?B?R09zR09pbkNHUEhPY3hMdnN2S1NvNTNiL2x5ekc4c2JqWXFVYzBqbldtRkwx?=
 =?utf-8?B?cy9SRElqd0IrNDdRaUpPcXBnb2orQ0hIR2lML2kvS3ZyOGNzSWJFeU1ZRVI2?=
 =?utf-8?B?TzZUQkQ4ZVR3NUx2RmVkRksvMFFVTWZuMG5RU3lNL0xzZWpxaVI5M1FDN3E2?=
 =?utf-8?B?dWZNMFREQndHMC9uWUpsWFV3WUQ2Y2Z1SURoVGpxaFlPMUVENm1tb2F3bWs1?=
 =?utf-8?B?bkVEaVZJTFM5Z0FiMEk0YjBtdkMwNTdXc2IyKzd0M3ErQXBYSVpXU2FSa2dE?=
 =?utf-8?B?c1JoWjVwQ2YvWUF1UHEzWWdIQy9wMjlKcEoxZ1JNVStiUjJKc1ZHS3hFT3FQ?=
 =?utf-8?B?ZVZ5TDFaZFp2d0R1SHFNVFN0ZUppK3RtVXVjUUtKSkhlQk5RdldLbGQ1UlZv?=
 =?utf-8?B?WUpsZjRWeVdXTXFOVUFwR3pHU2JqeTBBRUp0M29IaDE5OER5R0NoVFlyTUs5?=
 =?utf-8?B?RmNVbXVMUXpZU0ZRUVZEZ2tTa3JIUlZZbHlobDNjTlZ4TjdGZzF1MmgzcjNu?=
 =?utf-8?B?anJvYUhQYVVrdDRoc3dsWXA1bjNQZTIvQ25IaVVFanY1eG45clRNOTNPWWVG?=
 =?utf-8?B?M25WRjFpcHFrTThpQ2Z6ZVRzME5VdHRzd3RRWWdiWVROMFJiaFFsNDFDTDE1?=
 =?utf-8?B?TUZocTdDejB1OUxBT2hOaDRJakgyOUg3VUlsdkVRVDNaV1g0cXVtT1huM0RK?=
 =?utf-8?B?Y1I1NTI5VTBKekFTUS9TM3dqcDlqN0NiNllOeDRDNzc2NFdnRTJCZ2pwZjk2?=
 =?utf-8?B?cjVYckRMQ0NrUDltUTVsOXI1bHdSY1V5dmNLd0wwdG9MaGx0T0diY2YzU2N6?=
 =?utf-8?B?dkNCMG9iM24xbnNYQmZCTWpjcW5jUi95MzM3akI4N3pzV0V6MGo1cG5GU0J3?=
 =?utf-8?B?NGZOclczVlhFNHpQd2x4MlJHU0hiemRGdFE2MU5udVgrNXBRZ0F3cjAvNWc1?=
 =?utf-8?B?ZGdIaHdoNTlWaXhxL2RkOVpXTzUreHVNeG9tRTljZ2FJWXVrOTZWQ0FSN1pa?=
 =?utf-8?B?RUhrTlZPcjZIQW5MRkV1Q2dQOXAzM2FVZmFiRTJ0TERuZnlBMk92OVNnaERG?=
 =?utf-8?B?bFhwSHZNWm96Z00rYVZwMFQ2WWR6UzNWZ0ViRFdyWVZlUUowNFlvQ08xZk80?=
 =?utf-8?B?clpNZytEb3ZWODBtQmtIMFVHUENNSHhBdjJBYVEvVDFQMkhFNHF1MzRuRWNz?=
 =?utf-8?B?L0U5SEZrUmtra3JkVDNnUmltRTZZZXArTmNqdmRtSDZMOW1GQi9jRHVtTHJG?=
 =?utf-8?B?N2hienJXQ0VaQXNFQmtDcTBNK2M3R1JlUDU2ODUySlVSdGRid21tSEtXUyt2?=
 =?utf-8?B?UzhBWk1SczJUSFZmNndmMUhlSFJRaUxKT0svbTc3a1VVWDNvT2ZQczZGOEZo?=
 =?utf-8?B?OTBKWEpwd05ZUTB2U3hSY1pTNE00eDIrMnBINHdlVVFDcngxMEFHb0grdEJZ?=
 =?utf-8?Q?+49qFrhp4EgsAYK/yQY21kJlS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52832780-fb30-420f-fc1c-08dd9f238f42
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 02:42:03.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjCkAsjhqnWLPiEgnlLGv1uAs8xmZ+dlK/N+IGGimctbrpJJjJxmoLKiJePd69jSFBTLKASaO1FtlyliKmPBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5546

Hi Slava，

在 2025/5/30 02:34, Viacheslav Dubeyko 写道:
> On Thu, 2025-05-29 at 00:18 -0600, Yangtao Li wrote:
>> Syzbot reported an issue in hfsplus filesystem:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 4400 at fs/hfsplus/extents.c:346
>> 	hfsplus_free_extents+0x700/0xad0
>> Call Trace:
>> <TASK>
>> hfsplus_file_truncate+0x768/0xbb0 fs/hfsplus/extents.c:606
>> hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
>> cont_expand_zero fs/buffer.c:2383 [inline]
>> cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
>> hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
>> generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
>> hfsplus_setattr+0x168/0x280 fs/hfsplus/inode.c:263
>> notify_change+0xe38/0x10f0 fs/attr.c:420
>> do_truncate+0x1fb/0x2e0 fs/open.c:65
>> do_sys_ftruncate+0x2eb/0x380 fs/open.c:193
>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> To avoid deadlock, Commit 31651c607151 ("hfsplus: avoid deadlock
>> on file truncation") unlock extree before hfsplus_free_extents(),
>> and add check wheather extree is locked in hfsplus_free_extents().
>>
>> However, when operations such as hfsplus_file_release,
>> hfsplus_setattr, hfsplus_unlink, and hfsplus_get_block are executed
>> concurrently in different files, it is very likely to trigger the
>> WARN_ON, which will lead syzbot and xfstest to consider it as an
>> abnormality.
>>
>> The comment above this warning also describes one of the easy
>> triggering situations, which can easily trigger and cause
>> xfstest&syzbot to report errors.
>>
>> [task A]			[task B]
>> ->hfsplus_file_release
>>    ->hfsplus_file_truncate
>>      ->hfs_find_init
>>        ->mutex_lock
>>      ->mutex_unlock
>> 				->hfsplus_write_begin
>> 				  ->hfsplus_get_block
>> 				    ->hfsplus_file_extend
>> 				      ->hfsplus_ext_read_extent
>> 				        ->hfs_find_init
>> 					  ->mutex_lock
>>      ->hfsplus_free_extents
>>        WARN_ON(mutex_is_locked) !!!
>>
>> Several threads could try to lock the shared extents tree.
>> And warning can be triggered in one thread when another thread
>> has locked the tree. This is the wrong behavior of the code and
>> we need to remove the warning.
>>
>> Fixes: 31651c607151f ("hfsplus: avoid deadlock on file truncation")
>> Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/00000000000057fa4605ef101c4c@google.com/
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   fs/hfsplus/extents.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
>> index a6d61685ae79..b1699b3c246a 100644
>> --- a/fs/hfsplus/extents.c
>> +++ b/fs/hfsplus/extents.c
>> @@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct super_block *sb,
>>   	int i;
>>   	int err = 0;
>>   
>> -	/* Mapping the allocation file may lock the extent tree */
>> -	WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree->tree_lock));
>> -
> 
> Makes sense to me. Looks good.
> 
> But I really like your mentioning of reproducing the issue in generic/013 and
> really nice analysis of the issue there. Sadly, we haven't it in the comment. :)

Oh, so this is what you mean, but the description is already very long. 
I think this may be enough...

> 
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> 
> Thanks,
> Slava.
> 
>>   	hfsplus_dump_extent(extent);
>>   	for (i = 0; i < 8; extent++, i++) {
>>   		count = be32_to_cpu(extent->block_count);
> 

Thx，
Yangtao

