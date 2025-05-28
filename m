Return-Path: <linux-fsdevel+bounces-49941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A5AC5ED8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 03:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B963E9E5548
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 01:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872E14E2F2;
	Wed, 28 May 2025 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="foibHXmY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C772628
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 01:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748396269; cv=fail; b=jQWO4WLEvGgZx45AerXH6+/Cnc50n76wAKk1+PdXo7UXqFawXApaGIyG91pQMKo5gGs5PNIjgbs7fokOv7GjxZ+/Is+cHMH6fMP0T5CGLhtl6c3dU9R00CsEPMgCxuGL28iqxW1g60UJ1YaPvWsh4cVXvJIzdEi7VaAnQZLswHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748396269; c=relaxed/simple;
	bh=XPktNCuAD8IgLUVuyRA8e80nBuQ3RHxEyx3af1PZFL0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=WpaJp3ZGrt0qudVF03ImYSctYKHKZO8AUSTF9tJD6IZprQXEmO6PenmUEkYjcedwrFiB3sQfyIrpb6khFA5Ve4hUJkMzLrJeDjlbWQ59IqycTB4YiuoeGQ7iJON4FXo+uny46lWR/k6s2tJ/CIz7kc2c+ykJSICCuVtccXJcjUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=foibHXmY; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RGHTDW012407
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 01:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=MRxx6lcN1Tv21Oxov7i3rHB1Gu/LJN0oNq34HMoYDvc=; b=foibHXmY
	6aawCr000TJ5kzAZQx3GFL1E5TYvmsbD2D6QXQuMlN2jJEN5WIT71HF0STy6y+zx
	fz1ItNAQlgOvTGpWXNeQ+5ji/rYYyscTEuzdjx1jsHluyvD1EK7G+uGeOzLZb4qX
	tqFK1vhjfmFbjHQiu+aMmAqESjNv+HzkqELbcdsxEyCTXODjMp2vMBOvZLqvYEqU
	IIu/exZDj0tA7nEQX3G3WSpYK8uJH0L6VfncHfCVzIVH8zhFDzPEcsfkOkHGu1hf
	v0SdHp0Bxi6YGKwD5MI/MIF5n62aNfXaXpzZtv/b4GCy+5/32WxvlLpfySC+9MD0
	D8uP3xEnGGcR0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wgsga646-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 01:37:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54S1VwWw025896
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 01:37:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wgsga643-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 01:37:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gl8QpE8NfosZtYCCTv/nUqkl9uUfS3iFAMY/5KGySp61ja5OV+6N+fdLcubluDgw52vbt76INwheKIGwtw0lswZ+Gl0I9NfebybaaLe2Pc4t3eh7S7ud/lr5z/HHT1q7yZ9T5aIG6LsVcbLwi0v250mxKX2UCeUrun5IERYr2mF+IRcTY612wuF94vDXECRVRKyCA9n2nQcuVbPyHe3O4k/+3b6BiSz0q8y4PXjeo8iH/5rO7m7ysls8pnMulnx38GvPFtfWyKgqxMGR5GIuvuGctqQH6PX/LJux/rTUoYAIy6Lk7mmsirUKy1D9n/oseFBQVDjeVG6bqYVWb9DHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZ9nCbYYA9RnHJ3YLsKoCIqlBLSjhDGSXuKuSe246sI=;
 b=uK2uZYE5ZMMttRozH+f3k03qnfItbwClaEEC6lJbQA5xEAIgTDtvuCvWPwQyGKf74OHmlKSBZoxtX2sQ52XJGeyHFBP+0GhvCXPudEUQ5eUgcEplKtE44hCV1k1Nutd428vnCpC7Yz6Zm6jFrPclB8TyP0fSt6rUdQXc7EOjj/wQNiXh1SgAdiZN8jgUQCsvV88xcQK5FwjKb0UYM0NIona2+JkjaR71tnB8smUzEoYrzb0ZJq18zUP4OmyPJFv/v+lAtJKWKuYGJWBFuDZZP775N0pjFyWb0SjjFoL0bY92KGIokWhbQ9UPnClZxLNNuWuFf0L+oh0TYUUACnLf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB4346.namprd15.prod.outlook.com (2603:10b6:303:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 01:37:44 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 01:37:43 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 3/3] hfs: fix to update ctime after
 rename
Thread-Index: AQHbz1kyx1besQ9XoUy2gK662nPxeLPnQ4IA
Date: Wed, 28 May 2025 01:37:43 +0000
Message-ID: <ca759782695a9e2195d39730edf939cadbe7016d.camel@ibm.com>
References: <20250519165214.1181931-1-frank.li@vivo.com>
		 <20250519165214.1181931-3-frank.li@vivo.com>
	 <3bbf9fe0b5e4b2fa26e472533e16a31c9d480903.camel@dubeyko.com>
In-Reply-To: <3bbf9fe0b5e4b2fa26e472533e16a31c9d480903.camel@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB4346:EE_
x-ms-office365-filtering-correlation-id: 47293fb7-1b63-47ae-e291-08dd9d883db5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDl0VDNhTEVjL2FBWFZTUnIvc3k3VEZ6b2ZLLzc0akJGUmhoc3VveTg5eWdi?=
 =?utf-8?B?Mm9FOTNMVURTQWhsSGpzREU4WDVBMUpMOXFNVFdZYlhnTHlQamRiemNsUmgw?=
 =?utf-8?B?R1dNUUVnTnM5ZzBwLzdJS0YySVdDVENLT1ZnaFJ0cmdIVW93UUtXVGU0aURJ?=
 =?utf-8?B?KzJxUmh3dGJIRUcyaEZLampNZDg1OGtOekdzL3hqSlhlTm95K003c2ZlSW8w?=
 =?utf-8?B?RWhoeU9iM2VBeVpZTEJOcWs1cHFvMlRnbGx6d0F3cENJVUtXU3RNaDAxL0xo?=
 =?utf-8?B?bkZ1dUdsMVBhRXFrTHpwM2RKaUNXaWJpRTFXdmNIYjViQ25QQnQyQmdsMXd5?=
 =?utf-8?B?VzNzWjE3MnJjbXV6bVBzR3ZyQ0VWanFLNmV3UTBta1RTUjVmemtqY3UwWTFK?=
 =?utf-8?B?d25VaTVDUjhpL1RUemFyemcvekhTMUc4VXAzc0NpbEhvd0M4cklpTEZkUVN0?=
 =?utf-8?B?WDRzUUxmSlhFaXpTcVA4akhEQlg1OCsyeWRxYkJibGR1ZWZ1dFVWcUtDSFNJ?=
 =?utf-8?B?Y1NSSHhHd2RweVIvZXJScjZLT0pqRzVjWDZuVEplMW9lekU0MDVFNE1nQjE4?=
 =?utf-8?B?MGI3M2hwdHpCUExPM1RQL0gzdVF3WVc0UTYzYXlDRGNReU1wdlQwMlQ4d1BY?=
 =?utf-8?B?WkxhcG1lOXp6bERwRjlxTnNYaUJFajdpM25HdzlUMEFlRGpqa3JNN0lmdGUv?=
 =?utf-8?B?ZldIdEM2Wkc3SFJ0RmZQK2Q2aWxMRSt5ZUhOc3FLYWlHekNTTFkwTW55Ui90?=
 =?utf-8?B?Rk9NZHRDM2VPbU9OYWdlZXhhSHp4OGtMVEx2ZG4wNzdQQ2RKbEhHaklsVVZh?=
 =?utf-8?B?bGFqUTAwNFBmc0l0a01pWDN3K3BFUGwzWjBiSG81K1pFeDRaT3dCY1lUczZi?=
 =?utf-8?B?ODFRUkFNK0FKR3NKMk5jcHljUzNBR3BDek4wWjNnWHlZcW9mZXBuK1Npc3FH?=
 =?utf-8?B?SDBic2lzQk1UVkcyVDZ0MmUyVmM5Z3Z2aDAvbGVlRHQ3MXdvZTU3RzdBQjI3?=
 =?utf-8?B?MkxsZThOdUxnQzZwem5Va0xFRzNEYnBDRnNreFhHaVFvcFFLWFQvYVZTRW5Q?=
 =?utf-8?B?VlFwNmhvYlJhZVk3REVqOTVjUHhsdWFBbXpNOEFGVjlUOTdlU2F6UVo1ZDE4?=
 =?utf-8?B?b0QvcTVUb2hjUlMvQ1lYM0JUaFhDZ0JXWDIrQm5IMnNDRjlIaUpFK1diamNk?=
 =?utf-8?B?TllINDVoYnBRMHJDV1BMS3Z5VTQ3V2prWTRCcm9STDd0Y1BoL25zQnZBRGxM?=
 =?utf-8?B?M0tLTk40QlREWXVIcy84RnlaOWdER1JoMTExY0VlMGM4UHJIWnlLRy9Wem1n?=
 =?utf-8?B?L3V6NkxrVnNPaHBrZ1dQN1RWeEdxOHRiMmVZYzA5WjdPRHNQdUJJc1owRTJG?=
 =?utf-8?B?UElLMXhUeGRsc1RvbHVKdksxN0JLdFZOMFhHdlJsdFVQQzdjSll4Z1QvamRo?=
 =?utf-8?B?K3dJbUtibERYbEFYTXpNYTVpdlFKb3ZZNXpRVExrN2RUYk9DbWx0YlpMWEZw?=
 =?utf-8?B?Yy8rSkNTNWFoUjh4SmYrdkR3citPdGl6UHFGOUFhS2xYVlFBRWpPZGh2eWxo?=
 =?utf-8?B?V2NBNWM3bGw0a3UzaUdYa1k0Y0c3cUdjeXBISWt6RTIxZi8yekRqdVdDMTls?=
 =?utf-8?B?Q1NBUy9sZnZSTldidW9tUENFNVJ3cC8xdFpyZ1N6UThqRG1Ta3dJTjNka1ZH?=
 =?utf-8?B?b3paSlI2VGVzSUY2ZXlNcXhhcGFnbUZJRTNMTGwwanBtZ1B4aW5qK1BwREth?=
 =?utf-8?B?MEJqWE94S2JhMVdVN1MrdXMyMngvMW0rN3NDZlpPUzNIV2ZLNXM0cEVTVzR0?=
 =?utf-8?B?TkFGU2YvWDc4VlZYMjhVQnVQTUtTU2Uyc3pQY2ZQREpCVUhqZGsvSU9ocHBD?=
 =?utf-8?B?N09lL3ZkRUNuSms5VEpGTTB1RkM4V2pLQ0VPRVpkT2tNVUUrT3FBa3JLTXgr?=
 =?utf-8?Q?/gwPLcnTYP0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHE5aCtKM0s1azdoMk9vS3M0Z09QMCtOeTVsL2s1bnhlWDl3c0ZaQUNjelVu?=
 =?utf-8?B?dlRkckZlSkNvbFN2d1pyd0J4anprYXFkT0x1ZU90SnBYbzRDZEgzc1NCS2hS?=
 =?utf-8?B?bVp5MVFldEwvczNnY3lqU3A3TVdnQk1XZFlPWFVPTGZrZ25XSE5BbGF1VjFt?=
 =?utf-8?B?SUk4SUhFWVBmVkV6bThlVVBReDdEcmpnU3k5cys2andpdU0xWmFzL0xtQmk2?=
 =?utf-8?B?MmR3WFk0aVFaeXZmZms0VjlldFd1VG5mbWtJUW5XL1FkODY3aWxaalVPMkkz?=
 =?utf-8?B?SHpYQkhFYkNiNWZUT1dUalN2UHE0VDU4WjE2cFNMTkR6dXZpVm9jb1FnWUtC?=
 =?utf-8?B?OS9KbHRCd1htQ256ZUxvc1lzMUljTERRa1k3S2hhVWlUTmMyVDhvdEllcGJZ?=
 =?utf-8?B?T0VOTC9YMnowMXA4cU9vbkFVamFTNXpENFZwU2tEWWxPZTJBcFNXOWNDakdT?=
 =?utf-8?B?Y2E2K3NQY2F1UUNLSGFsWE9FdUVJMUlZZW9KdHdZNkxsZitwN2JRUUtCMXpV?=
 =?utf-8?B?dHVPS0VLVk40WWQzUnlyVm56RDlyQk5XbUpuRGN1S3ZPdFdMSkJhanBWTFhW?=
 =?utf-8?B?bzFMLzVTTG90UDFwYWZJSWcxcThsUmpUZ2RLdk9ZdTVDb1lhTFhUOVBBc1Er?=
 =?utf-8?B?UTdkcTFROCtrTFlyT0dYTWJCNXREbys1Y3dqWHhqY1FWOGJCMit3QnZYSjBQ?=
 =?utf-8?B?VHVONHlBQkNIR0ZyT0hCMFlPNUNBaGVoYVhnamFYR2kwQmovU0ZCSTRqbzZK?=
 =?utf-8?B?endSbFZVSys5ekRSYlRiSVYrZCt2MUNOa0ZWWVRsK1dvRHppSUZEUlRERlFy?=
 =?utf-8?B?V3d2MGd3UVRIbjd4ekoxUjFzWVltRDQ4bDVQUm9DUU9vV2wwRmdXc25DeGxU?=
 =?utf-8?B?Q1FLSmxiVXcwZHNodWd4Y25seHNDYnJ6L3NPbld1YjQvR1kzWGk5QnFKTXpT?=
 =?utf-8?B?YVUvTDh2ZHptc1laWkxKN0VqUlJkQXM0OUJHVFdJU3A4RWlJMUw3OFVielNm?=
 =?utf-8?B?dlUzRTZGenI0ZVZYR1ZqRjhDbDgzRlk3aG56ckZkNVAxRTQ5TlJ0RngyaWtT?=
 =?utf-8?B?a2dlRnFNMzA0a3JFUUhZOUlVdXZQNkovM0JPSGNMNnlkWUROdTdzL2NsbFpJ?=
 =?utf-8?B?djQ1bDhMMmpOVWhDaE1JVW16QlBaNTNwTzlyNTBjNFlQQzZxZ00yRUR1aXlU?=
 =?utf-8?B?b0RITGkrWXoyaHBlNVdPcUdaMm9meEVtTWk2bWRKYkZrd2hVQVQvVmdtc0dp?=
 =?utf-8?B?SnJCZy9OSFF3bHdvSCsyZzk2Rld5REdsOXA2b2trWlQ2MC80WGlKamprYlo5?=
 =?utf-8?B?YjBLMVhlSGxQU0w1ejR1Vjh5WlYxanZML2ZwTXJadnRkR0lrTHJlSm5kem9m?=
 =?utf-8?B?OFhIUkVUcTZIQzA5OFk4bkIxYmt0VWhPUStWblExR3dWdmxZOUdlWCtaa3hB?=
 =?utf-8?B?cGZSSW9EeUtUWEtFOVFuWm9OQTg5aHcvUXZhcGJuN0tXYm1Yako3Z1U3OUJQ?=
 =?utf-8?B?QURTSUdCR3g3dW1IZ0ZaeDZIQlJHQTBIUElaQy80OG9yemt4c1IvS0dZVmh2?=
 =?utf-8?B?SkFRSS8xNmVQUU9YaHNNNzQ5bXBXYk5iaE44SFNMT1VmMlV2NGZZTFdXVElS?=
 =?utf-8?B?OW5zbWo3RVVpVlRQOFpjQVVZdk83eGJVbk9YbUFsVVRNU0xrNGU3eTRZWkZF?=
 =?utf-8?B?by81bTVmUEM3YklTUmlHSVh4TnZGRVk1eUVsUGtCRmEyS2Z3em03YjZnNnB1?=
 =?utf-8?B?RlJGSlFma1NpVkFpZi9EMkVXbi81cnVDcjd2MENQczZURlJETWJic0gyekh6?=
 =?utf-8?B?Ty8rLzk3WUJBdzBUYkd2QmxIcmdnaUtLb1A5ZWpqL2drWTlYQ0RBUWVGam9l?=
 =?utf-8?B?KzhYUzhjTU5CZjNrN0xxK2ZUMEN2VlM4NkhaYllFbWVSY00waWFxMnlTNEMz?=
 =?utf-8?B?ZWpkd3BSMXh2SjJ4MmFsUkxjdUtMTHNIVUNraWpqaTJDV1E1M1ZJTFlEeVda?=
 =?utf-8?B?bEt6OG1tVG9TemhsZE5RYkFqMU5pVms1YmpPN010bWdRLzh2OGRsQWpkRzll?=
 =?utf-8?B?OXo1OHEzUTFseUF0cUswcFppeVQvSVljN0ttc3FXejhlcFg4dUhROUNWNVI3?=
 =?utf-8?B?cm1jZU9uNDFYTzBpU1g1WFQ0dkJtR3BIQjhrYjVEMTNSUlJNb0g4TUVKaWtF?=
 =?utf-8?Q?X261hfbqL1vw4URSZ3jJB6k=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47293fb7-1b63-47ae-e291-08dd9d883db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 01:37:43.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8H1ddVVkXOA74x9qlIf1+bRz8P/x5OKXn3qzJXy/NXpOwVaQwSkvOkGQTUi27Q6C3Q2jSX7h0tRjk5W+I5EQmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4346
X-Proofpoint-GUID: 3-Qby1yF4hekHD42F0t6nvx9XBwgzSZH
X-Authority-Analysis: v=2.4 cv=OIIn3TaB c=1 sm=1 tr=0 ts=683668ea cx=c_pps a=SDtrzPd57OWl6OO8yvgHug==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=P-IC7800AAAA:8 a=1WtWmnkvAAAA:8 a=n0vYuVPCH6nC3NohQoUA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDAxMiBTYWx0ZWRfX0RErnStXV3XK hgI5aOnk6kTMFVHDTIMknVXslXlFqdYddHtKs+pJMR7tqsNJimU61pqQ4XfUgdrmpnwQ5+CuxSO WAQQ3dqZ1z0/FW0VUMiiHDJb5ygJzcEhy9CJ2N6nNrOQGJd0GH+B2n1OBAyDBHAIbDhsyLV/Gw6
 bgRd09nufNnhkMmJcx7H06ptd37HUr9dHbkdyUteNtzxuhbKAFdviAJ7GM2kKXBghVP4mZeowu3 dWjwKaRFGghYuKcPgiBo2+9v4qYjBQox0My7C7RY0F9d7Yy8Fyr9s+Cn+WaXI2GBGarOzTBoMmn NzfoT6E751dsItO6w7mO86jGg79WGJ7xBstmvwXA9bc6TjSNbMPX5qtIFg+I0p+6wu5yLnF5B4+
 YZwNg+JmSz/CIJbqWeDo+0sD+dOhOToKCdudJ+63lPWlE7mFWV7ZCuZadHJl2+bm61yOZJMI
X-Proofpoint-ORIG-GUID: 3-Qby1yF4hekHD42F0t6nvx9XBwgzSZH
Content-Type: text/plain; charset="utf-8"
Content-ID: <757117E24640B74885C1C0FDD8F46675@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2 3/3] hfs: fix to update ctime after rename
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_01,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505160000
 definitions=main-2505280012

On Tue, 2025-05-27 at 15:46 -0700, Viacheslav Dubeyko wrote:
> On Mon, 2025-05-19 at 10:52 -0600, Yangtao Li wrote:
> > Similar to hfsplus, let's update file ctime after the rename
> > operation
> > in hfs_rename().
> >=20
>=20
> Frankly speaking, I don't quite follow why should we update ctime
> during the rename operation. Why do we need to do this? What is the
> justification of this?
>=20
> And we still continue to operate by atime [1-4]. Should we do something
> with it?
>=20
> Thanks,
> Slava.
>=20
> [1]
> https://elixir.bootlin.com/linux/v6.15/source/fs/hfsplus/inode.c#L519 =20
> [2]
> https://elixir.bootlin.com/linux/v6.15/source/fs/hfsplus/inode.c#L562 =20
> [3]
> https://elixir.bootlin.com/linux/v6.15/source/fs/hfsplus/inode.c#L609 =20
> [4]
> https://elixir.bootlin.com/linux/v6.15/source/fs/hfsplus/inode.c#L644 =20
>=20

Sorry, I mean these links:

[1] https://elixir.bootlin.com/linux/v6.15/source/fs/hfs/sysdep.c#L35
[2] https://elixir.bootlin.com/linux/v6.15/source/fs/hfs/sysdep.c#L36
[3] https://elixir.bootlin.com/linux/v6.15/source/fs/hfs/inode.c#L357
[4] https://elixir.bootlin.com/linux/v6.15/source/fs/hfs/inode.c#L368

Thanks,
Slava.

> > W/O patch(xfstest generic/003):
> >=20
> > =C2=A0+ERROR: access time has not been updated after accessing file1 fi=
rst
> > time
> > =C2=A0+ERROR: access time has not been updated after accessing file2
> > =C2=A0+ERROR: access time has changed after modifying file1
> > =C2=A0+ERROR: change time has not been updated after changing file1
> > =C2=A0+ERROR: access time has not been updated after accessing file3
> > second time
> > =C2=A0+ERROR: access time has not been updated after accessing file3 th=
ird
> > time
> >=20
> > W/ patch(xfstest generic/003):
> >=20
> > =C2=A0+ERROR: access time has not been updated after accessing file1 fi=
rst
> > time
> > =C2=A0+ERROR: access time has not been updated after accessing file2
> > =C2=A0+ERROR: access time has changed after modifying file1
> > =C2=A0+ERROR: access time has not been updated after accessing file3
> > second time
> > =C2=A0+ERROR: access time has not been updated after accessing file3 th=
ird
> > time
> >=20
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> > =C2=A0fs/hfs/dir.c | 17 ++++++++++-------
> > =C2=A01 file changed, 10 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> > index 86a6b317b474..756ea7b895e2 100644
> > --- a/fs/hfs/dir.c
> > +++ b/fs/hfs/dir.c
> > @@ -284,6 +284,7 @@ static int hfs_rename(struct mnt_idmap *idmap,
> > struct inode *old_dir,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *old_dentry, struc=
t inode
> > *new_dir,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *new_dentry, unsig=
ned int flags)
> > =C2=A0{
> > +	struct inode *inode =3D d_inode(old_dentry);
> > =C2=A0	int res;
> > =C2=A0
> > =C2=A0	if (flags & ~RENAME_NOREPLACE)
> > @@ -296,14 +297,16 @@ static int hfs_rename(struct mnt_idmap *idmap,
> > struct inode *old_dir,
> > =C2=A0			return res;
> > =C2=A0	}
> > =C2=A0
> > -	res =3D hfs_cat_move(d_inode(old_dentry)->i_ino,
> > -			=C2=A0=C2=A0 old_dir, &old_dentry->d_name,
> > +	res =3D hfs_cat_move(inode->i_ino, old_dir, &old_dentry-
> > > d_name,
> > =C2=A0			=C2=A0=C2=A0 new_dir, &new_dentry->d_name);
> > -	if (!res)
> > -		hfs_cat_build_key(old_dir->i_sb,
> > -				=C2=A0 (btree_key
> > *)&HFS_I(d_inode(old_dentry))->cat_key,
> > -				=C2=A0 new_dir->i_ino, &new_dentry-
> > > d_name);
> > -	return res;
> > +	if (res)
> > +		return res;
> > +
> > +	hfs_cat_build_key(old_dir->i_sb, (btree_key *)&HFS_I(inode)-
> > > cat_key,
> > +			=C2=A0 new_dir->i_ino, &new_dentry->d_name);
> > +	inode_set_ctime_current(inode);
> > +	mark_inode_dirty(inode);
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0const struct file_operations hfs_dir_operations =3D {

