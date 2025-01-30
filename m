Return-Path: <linux-fsdevel+bounces-40388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F349A22EB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C651C188651A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 14:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1491E9B00;
	Thu, 30 Jan 2025 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="omCn0eq+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UTKG6JL6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2B1E885C;
	Thu, 30 Jan 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246196; cv=fail; b=JGbqWHw90laJhg4JLvaTj+fUs4+Lbwild6iP4n5LWyQ8sr6pcqvUETdqmTSTXPQhUVnfUUOxiN6d8p7Kt/Yn2OXZJwaCPjq/Oq3QYCht+XhaeZM4IjGwVU9zlPjsxk10kZsZekpW+yE2a9QP2Rtc4q7wju8ZhEap1wX0kSircxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246196; c=relaxed/simple;
	bh=lFhhWQQwXGWUKprCT2cRV09459y7NbAG37CAC9nLTA0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9uI0dtxUv8jmPHafTixwhTZ5eVdA36EpGcyofp0TKdhYGTr13Q+F2qdknugCt9vvkWweboWjqBwaxHO28cFb6EXBNHsAb1Kxeb1tV6VF95mT7Zo9yD9Ge7PRUwMwvpkdr4PAne4jqMOkNuwnY3vFoTZi0su8y/dUpuFnpXpqzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=omCn0eq+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UTKG6JL6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UDgXHX028104;
	Thu, 30 Jan 2025 14:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bgkFfYHyQmHZvfc3fVkQdxB0x3Q/Azg0DLVg2s9IGP4=; b=
	omCn0eq+SJRQaFW2z+P80HKT08pxOSYwYS8+CghVYfOCifFWuBwVlTOPlQiYSm8V
	btseqEGKwq6wnO9oJK55J0y1DhkYbzFYPIVo4drvfx+NeKIiat5q4WQ8SUrnHD6s
	inz9x34U2vXf38QZPJrfNSOg5ZreAZ87H63ERtI3dBAtwVjVACQeRrnNikEDKJEq
	/F1xC7Oyg71xEjMnMcM5bW7JsZnIOwYRo9v1BO3QR6teimBDek2PZCZ6aqzXGX40
	/4wHwceQCHz9IUQXLE5nZG3fn7r/Iw+XM/CgB9ntiJzXOVFwtezZa4j8jD6gqPxM
	3tYZ0tqePv9wyFe0eLMR+g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gahn02sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 14:08:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UDLpdv011727;
	Thu, 30 Jan 2025 14:08:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdav5gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 14:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulcDERd1fojBrB0XoUmaatguMog1p07qgINr6tRoXSTy740T+7pmdS0FSHY23yl/IOuJ6ZV/3qebIVm05p9odicpXNpMklIW/ZWFfwo7/045CrCgrH9zdw5z7QD6yO4tgj1MQ9opxoJUuaYulSTYziEbdG8eks+oiQRY0J00uVn8pQ07UL/sM5dysKYHvgWfWS2Tdiyv6u5aWZgke6HrmwGcj+tq5H2YZbdbSYzDwPdsQc4nzFfWft41S1gJnmXHZp1kgm1j3yHJUaC/aeri5rsMX0BLETB8aLUMZubcWB6qkAVLUGouUvlnd3HOvegeZYYGxYIVwxG14uDyYz6DUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgkFfYHyQmHZvfc3fVkQdxB0x3Q/Azg0DLVg2s9IGP4=;
 b=TBQysfbUsKtTgE1+wUUBQ8bovAI8bW3HMB8BPw36bJ45JcTLKoLS1EUYxNFEXP4MXFxyCy5KJRpZdXWyBleZjxWnvx5nquve9t38D9PwL6BHLgLqZLStEKO8snQU6cb1hJhl3yVUp9hFqNzOcLb8vIllxuHaF0XWjUp9U2Hu0CKiLVm1uig1WMYxy0198BzSbsMEnnsywmOd+X6HFfZNC/4Vd7fDuvNpbOWXz+XfUdeME+/PH7qj1rzIiWxwZRrH/UbyCg6pWbjpTmTKa1IFSJNobrF7NR6dOGN6kAb4/+g1LAwPwgkkMn3mlyN20JKG7KwPBdkY7zeWMK6EOb7jTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgkFfYHyQmHZvfc3fVkQdxB0x3Q/Azg0DLVg2s9IGP4=;
 b=UTKG6JL6dNXmUBGTRtbm2yutGdSwXEWqU73D/4Op9aP502TUA7xATpm0az/NREZdtgLQWZrL6FVDs+hPNZCOx5IgZmiA4sQ+eQAUemU1x0KH9yjOmb5LF8rpO7WBJgiT7GZcccUdxFfbFnKFSz9LpaRcF3XxkFBnuVPDzjJhDlA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7546.namprd10.prod.outlook.com (2603:10b6:208:483::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 14:08:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 14:08:34 +0000
Message-ID: <e00bac5d-5b6c-4763-8a76-e128f34dee12@oracle.com>
Date: Thu, 30 Jan 2025 14:08:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems
 for atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
 <Z5pRzML2jkjL01F5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z5pRzML2jkjL01F5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0123.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f22b05-176e-4c00-5c4c-08dd41379533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXVYaGNpL0x6aEZwajJ6UEdJRGxUbG0vRUxCOUR3dW1Bak5TTk1MUHB1MmR5?=
 =?utf-8?B?Sm16czFZYUF6OUs5RTlwU1Rzc3g5QXlWS1ZaejNPM1FodkgxRUpFNm5GeXFV?=
 =?utf-8?B?bDBVdURUYkh5SGdpMTNaVlBPT0U0bGZ1YlQyNjlPWldhYTd1YzhoZ2NKTzVV?=
 =?utf-8?B?V3pQZWkrZW9QWnk2SXNibkZsNkE4Q0JRV0RESmE3UW44MTZVL0J3TG1qNDl5?=
 =?utf-8?B?WWNLVWFRdkM4UWFMY3pucXc5cG5Ob2Y2SWpzNzBqMFNQMGxFQUgwZk9Lb256?=
 =?utf-8?B?MEMxT2x3Y1JTQW0vSHVKZTh0ZWlsamYrcnNjRjllTDNiT0hLSXZGY2VvbkpW?=
 =?utf-8?B?VWhSNDVrVnBwelNSTEtGSENnSmNUR296ZjlhYnp6R244N0UxSUh6NDNZbkNa?=
 =?utf-8?B?MnlZOUNBeGV1d2tkWlladW5Vemo5bXV5Tm1vT09RNXFtM2d5L1Z6NFg1Q05a?=
 =?utf-8?B?Zmp1ZHY2TjFpRGtXVVZhTTRBd1ZHYzB5dkVvUGc4MVlHYkJjVysxdzVsQUZ4?=
 =?utf-8?B?OXc1dE9sTE9HYncyeHR5YkhTZmoyWWJRR29ja0RGQ09LYVV6VEFHc2d3VHdC?=
 =?utf-8?B?bFlPb0RESlBIbzliYXNVaTlaRVg2UWFJd3FNdDcxdDZ2UUxhWEZUT1FMMlVR?=
 =?utf-8?B?Rkd4L1FhWWhTSkNkdWxsVEFrY25sVFQ5ZDNrUmNZN1RCbDk4K1R4cEx1SUhk?=
 =?utf-8?B?Rm80dDVzZlRTM1BYYThLY1ZWWjN2VkpmMThtNzEzeUI2TFluYkhVMVBqY0dU?=
 =?utf-8?B?RzFzb3YwNzBkcUFYUkVlaExYdkF3V3B5MENUN2dBVHBnOHVzZG9ZK2M2a2Nm?=
 =?utf-8?B?V21pdDQ0VmpwRURqSU51SDJmT3VEMnB4V0JtV0crNDM3YWhJS2NVZVhKK3dq?=
 =?utf-8?B?a0ovSGdOd290dzJ2WFgxSGpyL3hNcnM3VWpDM1p2dGE2akFHVzEzTUVzQmJF?=
 =?utf-8?B?MzM3eTVaVS9TTTY5VEVhZk1STDN2QW5Hc1R1UUwxdWV2TGtGR21vc2I2cDZY?=
 =?utf-8?B?Wkk2ZTJzM1ZXcGtxR0YvS3l1RWY4L3VVWjdGeFlydlVJNXN1V0ZzQ2V1ck9k?=
 =?utf-8?B?YWNDZ2xDblRxNGx6NEpMeWJsSGxVbVBEbFU2cjJLSXp5LzU1aVFzQlp5SXpU?=
 =?utf-8?B?amFRLzI0cUJ3aHFqM21iMGI4clpkSmhpdmh5OGdHamxwTk0rSktqQ3BNQ0oy?=
 =?utf-8?B?b3g4dE1DajRIMHpQeHJSZ3JmOXZuQjFiOWxYTUEvdERZVWovSFJBcDlDYkl2?=
 =?utf-8?B?ZW1LZm1zeDB6N0pKcDlHRFlaZFkxZjVKdVczbitXcGsweWx4UE53ZFdvRUNP?=
 =?utf-8?B?M2JBc05FVnlpYUY0ZzgwbXlHK3J2WmMwSVRnNE80YnVTZmxDSG96alN5b1Yr?=
 =?utf-8?B?YmZJSVdpM3lkQldEOW1Ic25OcWtZWk81TjZZNjUwbVJrbDQwMGlwei8rcVlo?=
 =?utf-8?B?UGlhcTZ1R0dVNmVCWUpqblZBSDBHMzZrbVl6NkZaQUdQNmY1ZzhZQlUxby9P?=
 =?utf-8?B?Zis3MEpaNC9pSzdMbm5tek1WN095dGxNbmF5cmNMbytTVXc1WnU1dDlwa00x?=
 =?utf-8?B?WmkxVkRWaVNUQU51UWJHbFdSK2NYaFZQY1RFYmpwYTBSUmo5QU1TSEhMbTRB?=
 =?utf-8?B?NHQ2b3o5Q3VzQnNqeFdYb0Q2NU5QTm9ia0tBYXZRdEcrc0NSU3ZzYWkxODlk?=
 =?utf-8?B?MXZkTGplTUgvR2VZcnJwSFUyTFByZEYyUEpXa1ROUDJ6OTlqUlVFelc2TmlS?=
 =?utf-8?B?eXM1KzJoWnFVb2Jhc1BCK1ZHU29LZnpjN2JnYTZzV3dKVll4R2dlYnZ3MGxp?=
 =?utf-8?B?ZXluc2t4YU5xV3BhcHVXNjgyMVdzaWpFWFZKdFJGdzY0UlFERFZORDFDSzNP?=
 =?utf-8?B?Z2lDTnlaNVNqclR0VDZYTnRjakVqVG1zOUNPWEdaemxWSVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3dCQnp2M0YvNTlUNU1makVjK3I4YjRMMGF6ZnhGTVZ4Y2k0QkJiUnBwaUUr?=
 =?utf-8?B?TmJmN0JvNWRkcWdHSjB2WER4NUpQUko4bkUwclFhS0E2aUVYSENteVJ4VHdo?=
 =?utf-8?B?TkdhbVZRbXcra0tqK2VNOW83OFBmU2xxTHp1TXM1bWhPOHUyK2U5T3VRcWtv?=
 =?utf-8?B?MnovNVF6R0dXdW05OHQ0ZXdqY0hDbHRGTm9vMXM2clhBaDBjaW1za1NCZldp?=
 =?utf-8?B?YnFFdjFVWDlhZVM3cktaOWtYa016ZldOYXRibXZqMjhsOTYweEU3VnF1UGFR?=
 =?utf-8?B?NG1sbDc2N1hFVENlRFRhKzNnNDdxMEpLbnUySklUS3FZVFpBWExURHhvaXQx?=
 =?utf-8?B?dk9qSFAyQ2ZNZ05KMlZ5MGFxTEhUelYwNnkxdGhReGJTS1NVR25BUnM1S3R6?=
 =?utf-8?B?WlNvTU9WelpscjBWaTBvTGl6RDV0MDd4TEdZdlhhWTdEWmF5WHlsQWR6aVZz?=
 =?utf-8?B?V1VaVUs3RWtPV3krTWVIbmJaa1cxTm56emN6SXN2V2NaS05Rc0pyV2ZiczVB?=
 =?utf-8?B?VGd6RTN1VkIxVDJLS2VTNHVvdkFhaWl3bGkweXh2ZTNjQXNhaWRETnp1VUJO?=
 =?utf-8?B?MU9xcXFoY1p3TWdHZjEvTFZOSFFBeksvWmh0NS85OWJqenN6aVFJY2J6MEwz?=
 =?utf-8?B?c1JXYXAxTXh2QzcrMmdXMXJMNnBNVFpMZ3NaQnBRWSs5VktvWFlLeEFnYUps?=
 =?utf-8?B?dm9Ubk0xN1ZyQ2pDaG52R0FZMERVbDJDSS93eVJCb3kvZitqbHpneURTNisw?=
 =?utf-8?B?ZklrTFA5aFBDakgrTG5Pa2llWlBMelp3aHQ4UzBsc1oxaFFYaFNqZ3RpMTFI?=
 =?utf-8?B?dFFQdndnd2xFR1NyRG82NzYzamtyRzJZTnRUejJBYWprZlVMbEhYd25LOFhm?=
 =?utf-8?B?VmtoNUNQUTc3bkVKUU1ZSmpTOFo0eE1YM1BIVDdqRUpTY2NCVDdEWEZvTnMx?=
 =?utf-8?B?Rys5MUxvUzRqckxrektucHl3ZzdybDRHQ0RqUVd1aCtXdGJzeHdGSitFK2xo?=
 =?utf-8?B?WGgwVHpvTWd6dVVHNUxiS21mZ0xhaWZhNE8rM1g0a3pSZ1BQajhYOEVjcXdL?=
 =?utf-8?B?MENpVVExdGorYWk4Sm9yc29iNTV6K2Rvd3owVnpHK3ZQTGRML2NZL1Y3VzQ1?=
 =?utf-8?B?cmlMd1hISXdQQ1dMSlVLVGZIVnN5dkV5ZjVEMkUwcHE5MXArWktzc3c1N2Nh?=
 =?utf-8?B?U2haY014RkRoM2QzTnVNR3JvOC9HV2hNOGt0cW5ndXQ5REZIN0ZLMXIzMG9w?=
 =?utf-8?B?M294LzJteml2ZnlDaHRDa2tHNG9sZ3d2eldVS0FTcTZhTG9HMVJLUmRTcWpx?=
 =?utf-8?B?ODR5ZWc0UkRvMlBKM0xsa0U3TGRuNVZ3bnNUbEx2RGN4eldXM01HaENQQnBX?=
 =?utf-8?B?Z1V2elFodWJSaWtzWXRVMkllNjd4NjFRL3hqd1hTNDljN1FDNGZuSVFFTUFR?=
 =?utf-8?B?a0VXTWxPQ2xjK1hvQjl3bTkwdTN2MmJ3N2IvUm5zdDNqOUZ2dTVpZmhCOE1H?=
 =?utf-8?B?Y3F2Qmh5dE9XZWZyN1lsN2hTaFBRVm9JYVBSbUxGNTczeHVsNnUvZWNrbDV4?=
 =?utf-8?B?ZzhUN2R4RmkyQ1pkWGh2WnJzeHZMbFlRSDNsRDNBWXN3bVpDN3I3WndsNTVE?=
 =?utf-8?B?SlplWW83UHdrd295RW5DRnBTRU1zdDF5dTJaQjREOG9yc2s4UUY3MGhsd3Vo?=
 =?utf-8?B?M2UwaVRzRkxQVDQySkZsRDNPSG96U2UvQlVMZzBuUU9qZzkzb0tRQXE1MWY3?=
 =?utf-8?B?bmR2OXEyTVdnc0lWOTFMVUdyOCs1WnE3YVFsOTlEK3lIUEVYME5ndVZFa1gw?=
 =?utf-8?B?eE9kSWxBU1E1L0FrcEw5dXZJZ3ZXNkNQOW1ySEZqZVgxS25vWVFhbjM2M05S?=
 =?utf-8?B?YTIxY0R6djg0S2ZNamV1UHJzZUY4SHFhRVdDSjdEcVVNajVBMGdqZmFSY3dv?=
 =?utf-8?B?QmFzVFMrTjVLOUEzNUU5dnVHT0ZyMFU5Y2RXNmVlSTBLYzE5OUxaRENpdGNW?=
 =?utf-8?B?blhJZEJRVmlYL3JwTTl1Y3UvUWtyak5WRFg3WDREQktWa3NrU1pzMWZhYUVR?=
 =?utf-8?B?R3lKZGk4UDN3bkVaWW54YjFlaU9STTFFUnJxR282cGRDUHJ5RjNrbkQ4YXVH?=
 =?utf-8?B?Y3IvTnFjVThGMkptSXlkTk80SklWcy9ML0R1MFJPVHJiUVdJMVRsQTBCNXpD?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PqpLMLvGDTA86DO5tRFDmgu8omXD65Sl6PfQVFcqYT4T3S9bWBhL9Q5MTMgNeDwGhqZDBTFyUaSzmR2APjC5+KjzupoXxgcNz8bk61It2sWjc9Cr9uQO+eO3Tn9lV7Bk+EdvkB4w1RxKkNr6kxVJ/bXXBFq51li6CUk2IAEPR5SHdfpoItNtvwHBaTpD87RKzRhBaW5CV6gl0/7z0sfeJWC5ie9dhwyPrZc5J42kv79mHNkaty6VcbxHvcVQYZvkntKwCWxjjD/jDBqpj/ut3HJpOnHjR9UvRvzM1iCv2uB5OMaLQyQXd15cDtOp5uhEQ91z/o0ldatjTe1EFNmdVaYBM8a0yxGl+VqbNx+YCxuLKSxOaqhZz0+8MKQ3Hpe1ThTklt8LL2KvHehN5f1GFyMTwgnIn1U62LyuRfQA66ML7zPyjXKLaqpSeDUu0hgSNQ2U+4qKuhSeU80bnMluwcf1xNmzQN/KO5ZxCEEzVecTFOvvvsyctp5TaO7QD7Tpu6nIyCK8QB4qj7Aln3VgOENEeSaNJMBIgicLPadbnDYg6sOl270XR5E7Hjw7Is7FXXbJ1KqeSnikFe5PxiCBJgVY2DtMS7Jo8S9tAHmJxhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f22b05-176e-4c00-5c4c-08dd41379533
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 14:08:34.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2V6dzgB6swpywFROGbL6lsIJhqYEBj+/4p4dlvsjlit/U9xqCrRWNG3y5oufbUBw6kaY+nKmPxSOnKdEa3xh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501300109
X-Proofpoint-ORIG-GUID: I2_CP-w26RksdwSJp6j-mPkAAVH2VQKr
X-Proofpoint-GUID: I2_CP-w26RksdwSJp6j-mPkAAVH2VQKr

On 29/01/2025 16:06, Ojaswin Mujoo wrote:
> On Wed, Jan 29, 2025 at 08:59:15AM +0000, John Garry wrote:
>> On 29/01/2025 07:06, Ojaswin Mujoo wrote:
>>
>> Hi Ojaswin,
>>
>>>
>>> I would like to submit a proposal to discuss the design of extsize and
>>> forcealign and various open questions around it.
>>>
>>>    ** Background **
>>>
>>> Modern NVMe/SCSI disks with atomic write capabilities can allow writes to a
>>> multi-KB range on disk to go atomically. This feature has a wide variety of use
>>> cases especially for databases like mysql and postgres that can leverage atomic
>>> writes to gain significant performance. However, in order to enable atomic
>>> writes on Linux, the underlying disk may have some size and alignment
>>> constraints that the upper layers like filesystems should follow. extsize with
>>> forcealign is one of the ways filesystems can make sure the IO submitted to the
>>> disk adheres to the atomic writes constraints.
>>>
>>> extsize is a hint to the FS to allocate extents at a certian logical alignment
>>> and size. forcealign builds on this by forcing the allocator to enforce the
>>> alignment guarantees for physical blocks as well, which is essential for atomic
>>> writes.
>>>
>>>    ** Points of discussion **
>>>
>>> Extsize hints feature is already supported by XFS [1] with forcealign still
>>> under development and discussion [2].
>>
>> From
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20241212013433.GC6678@frogsfrogsfrogs/__;!!ACWV5N9M2RV99hQ!IuMiPMbR5L3B8f31W8tbRlB7d0dMLg2nxW8k7KOGF3t031T99wahnbwnIeDn6N3AdveQJvmbL4V_FBwB0T9U9Q$
>> thread, the alternate solution to forcealign for XFS is to use a
>> software-emulated fallback for unaligned atomic writes. I am looking at a
>> PoC implementation now. Note that this does rely on CoW.
>>
>> There has been push back on forcealign for XFS, so we need to prove/disprove
>> that this software-emulated fallback can work, see
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240924061719.GA11211@lst.de/__;!!ACWV5N9M2RV99hQ!IuMiPMbR5L3B8f31W8tbRlB7d0dMLg2nxW8k7KOGF3t031T99wahnbwnIeDn6N3AdveQJvmbL4V_FBwv-uf6Ig$
>>
> 
> Hey John,
> 
> Thanks for taking a look. I did go through the 2 series sometime back.
> I agree that there are some open challenges in getting the multi block
> atomic write interface correct especially for mixed mappings and this is
> one of the main reasons we want to explore the exchange_range fallback
> in case blocks are not aligned.

Right, so for XFS I am looking at a CoW-based fallback for 
unaligned/mixed mapping atomic writes. I have no idea on how this could 
work for ext4.

> 
> That being said, I believe forcealign as a feature still holds a lot
> of relevance as:
> 
> 1. Right now, it is the only way to guarantee aligned blocks and hence
>     gurantee that our atomic writes can always benefit from hardware atomic
>     write support. IIUC DBs are not very keen on losing out on performance
>     due to some writes going via the software fallback path.

Sure, we need performance figures for this first.

> 
> 2. Not all FSes support COW (major example being ext4) and hence it will
>     be very difficult to have a software fallback incase the blocks are
> 	 not aligned.

Understood

> 
> 3. As pointed out in [1], even with exchange_range there is still value
>     in having forcealign to find the new blocks to be exchanged.

Yeah, again, we need performance figures.

For my test case, I am trying 16K atomic writes with 4K FS block size, 
so I expect the software fallback to not kick in often after running the 
system for a while (as eventually we will get an aligned allocations). I 
am concerned of prospect of heavily fragmented files, though.

> 
> I agree that forcealign is not the only way we can have atomic writes
> work but I do feel there is value in having forcealign for FSes and
> hence we should have a discussion around it so we can get the interface
> right.
> 

I thought that the interface for forcealign according to the candidate 
xfs implementation was quite straightforward. no?

What was not clear was the age-old issue of how to issue an atomic write 
of mixed extents, which is really an atomic write issue.

> Just to be clear, the intention of this proposal is to mainly discuss
> forcealign as a feature. I am hoping there would be another different
> proposal to discuss atomic writes and the plethora of other open
> challenges there ;)

Thanks,
John

