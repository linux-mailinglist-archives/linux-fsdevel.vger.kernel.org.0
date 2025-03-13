Return-Path: <linux-fsdevel+bounces-43869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01C7A5ED5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4563A3D0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 07:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02B26036A;
	Thu, 13 Mar 2025 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bszd+LRF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GgQlj+yz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40993A8D2;
	Thu, 13 Mar 2025 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852418; cv=fail; b=MQo6a07MKUSoUYCjpA4vz+4nCJDD00sBKELnIUEmd//4Gjah8KPANwAiVLbmxsQT1GPLU9Ku07cdIqbx3jarXNBwJn8LmWt0iEXARr1oEBEhxkir1VyzK30ZLvnA0qCM23T0OshemNEFZ8LQ768BZRLDKBFYgCvmkJoPVZN/Vtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852418; c=relaxed/simple;
	bh=JlNcM5AlmJ0wN1HRCVD7YlTNBB4PiR5OfjDMDYK4vXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fUCN4mlZ+BbnCZpH4qH+bPyct4ZjcnOOoT6yBjxQ2WzbX1AYdZSRUzSQbD/bv0uzp8Ha/YV0oz05WfGdwmsNXZ1oL4W0gxB0HoM8t5GYwpwPKtB40WsxAL9MRRurJaHBGNXhypEXC8j0frM3tMBZzLRcr0XFKSPD2c7VDDDAnBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bszd+LRF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GgQlj+yz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D7YJTt026756;
	Thu, 13 Mar 2025 07:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+KmDZEVBKB3oOt5F1WlokD3bufLcPWdwcLbUOhSsOJc=; b=
	Bszd+LRFC76px7JR6EIfYrb6YiFjyA2giwlksy8B5EAo3S1tdJtdW+047KoR1xCJ
	41SfOSMuQxZKkvOD95YkxnaeEUT3Hohvcq/xy7qKrzC6gG177qVaQawwlZoYgpuZ
	6xrTJBjxxTZ6yoHov3/Vo4s+vWmjIBcRoZjhJS5EY8juLKzDP04wkW9mM+FNjuiI
	ixWCBqhwO8hPKZwLmCaINmynbw877id4B+RN2qcC37uZtCvqSxyv03zQOOyjAP4A
	vgFrfhp3wPpD9E6gU0p+c7qU6PIVheBAuMpADuHlNGsayxFfnPjEhcQVyBK9t6lm
	bcEKlPsuVPQkzpCNJV6NFw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vkn65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:53:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52D74WPQ019797;
	Thu, 13 Mar 2025 07:53:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn1jp57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:53:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqUeKPoV5NM5EnFPdFeO1FFmRTtqHch7J4My8LxnqTJbN36PC/rhtQ4lX73bC7f52vgkEzRQt7zJ46VHBHw3AM8gyjqHj/aVskFjsse57rT13Ni9lmDEioPc3musk8npK+uMeNwwTEbATUbEFVSKNtdCSPI64dngMnF0wqDjQ8408ezZ+86Yg16r8BeCRCirrgNqIXD12j7AmrM341neW7StAegrRIETBGdgSgG96VjBgxXYGbbjWLLWilr5Az+rGGvA7e53UIU2pvIaCuOYnvO7ZApWiWF9njztGqhpIYxLZY3+ZUUsNv+2jmA6dRzD15HGfCg800GWkeDVGysvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KmDZEVBKB3oOt5F1WlokD3bufLcPWdwcLbUOhSsOJc=;
 b=o2DW7evZkdRfjdWBgXZ5Mtit6ePGE1OSntjAwW6DJOwaTKd82W70qLf2dlEc8q34e+DW63MoM+s0uqslrNDqj0kt0UZdwALw7T2A/iSfjEGFFBztZRvWTgqqh4I2Wmb/i1qxuLU3kUAREFNRfDoDVOElr/1fwFMVQ7kuqXzU0sU+vU7nM9m48vLnV2Ow/g7tiUxL53C2hpmzEdoUiEHp9R54qMS5Ph3+SFCdV5RF4jkhlftx8DyHhVnAnTS/yv0JzhZhecMXHkjEij8TcEOyoiL8tDTpp/lK8gR86VfrHsL4QzAEGDGRaL3E0oBWz/nOUcgQPCH1zTiuIFefn9QpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KmDZEVBKB3oOt5F1WlokD3bufLcPWdwcLbUOhSsOJc=;
 b=GgQlj+yzwoYVb3lqW746kmtMhOqy0dxBd1M1S3AD1dwdP0kwnfJnV4Vi2G0UAvGCvAqHhWJZmJsCDHFb/5WHVUPGTmNxHUpjyIT1czDTTZtX9aBjyiVL7weCvFpGjd7e7mbV3HhRIq+ZVy5F7Vm5xW3QQKYvmnNJEP3KY9RdiI8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 07:53:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 07:53:26 +0000
Message-ID: <157f42f1-1bad-4320-b708-2397ab773e34@oracle.com>
Date: Thu, 13 Mar 2025 07:53:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org, djwong@kernel.org,
        cem@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-11-john.g.garry@oracle.com>
 <Z9E0JqQfdL4nPBH-@infradead.org> <Z9If-X3Iach3o_l3@dread.disaster.area>
 <85074165-4e56-421d-970b-0963da8de0e2@oracle.com>
 <Z9KC7UHOutY61C5K@infradead.org>
 <3aeb1d0e-6c74-4bfe-914d-22ba4152bc7f@oracle.com>
 <Z9KOItsOJykGzI-F@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9KOItsOJykGzI-F@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d9d5e0-57ed-4e80-63a6-08dd620422b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkhXY2dGdGhDYmtQR1JOQW90SlVmSmtaRXQ5NUZURDg2TVlyZkpFcENSdWZs?=
 =?utf-8?B?dkRHblAvQ0pGL29hdnpLeEFxVWlIL0hrVzZOYjIyanVDeHZqcm9iZjMzVnpp?=
 =?utf-8?B?THMzcjVteHhtWnZzN1hnbTRuWnY4SzMrOUhPNWg5Y21CRVRaY21NWWIrbVdw?=
 =?utf-8?B?LzZnVHlVdXM5ci9VVHZ4Z3hsaThQR0d0dWpwMjIyckpDVWNHNnNCWjJFOVp0?=
 =?utf-8?B?aHJYUm9WUCs4eWpNbUpTbDhPTGNObzcvbnkzVTBKZzUyVHVTMlNoRUMraEhs?=
 =?utf-8?B?V0hUTnMyenl4UTkyeUltZ05PVkwyZDhaL3pVSXpqUWJKLzZ4amVDa095QTZO?=
 =?utf-8?B?UWdWMENnYUFzcENjKzdQbG5ydmNSVENOVzhTVmQyY25TQ2h0UjloUWJ0dXZp?=
 =?utf-8?B?eVlsVWNKbmhOZFUvNzNjR1JVaUE4YzEzWkx6UTNtOGhISHFjWnVkdEJWUDAv?=
 =?utf-8?B?c0dEaldEVjVIY0JzbFk5eUMyNWdaZ3MycExoc0tRclZKRFpRUUdHSWtUUm9p?=
 =?utf-8?B?ZlBrR05XQU96VjFwOVUxUEdkbEdiK25zUENteHBaaWVOSFZCVzFrRzBHOXRv?=
 =?utf-8?B?QUxkNTdpeUZoVjIzajc3NndmSW1rb3ppWStEVmRWSWZ3ckNJSUc2MC9peGtW?=
 =?utf-8?B?SE9SMVdpVUhaTUFjbHlFM2hpSENHdEMxQmVCVkxMNGhmV3IyWmxkeVFOcDJH?=
 =?utf-8?B?cTAwajYzamk1TUgxcmxaWU5xZkhOUzJidjZuOElhWkt1VXBaenNQL0hOSm5l?=
 =?utf-8?B?MGQ3SW9XYTRURjBPMzNSeEM1V1hYNGF0aGZRZlVSN09uWlRzaXpFcXQ3Vnh5?=
 =?utf-8?B?TkMvb2U0SXBTVTU0RnNRVzFUM3BzWEU3eU5SZFFESVIyWkFwcUN5WUhQV2p5?=
 =?utf-8?B?SlU1L2RSWkJWRjFOVFhKT0Evem1QY0l4SE5rMXNyMU1JMHhpOVBESzhxRHR2?=
 =?utf-8?B?M3kzd21LMTc0Rkh0QUxQQ3ZCU0xWOVd3L29FbmswcVhWTWhweVFZbHlRTHRV?=
 =?utf-8?B?SHRSTldmTklkU3g3UkRrNGU0bkZsa0UvTGVLUGVLRTJVbWFHUHNlb0gvWU1U?=
 =?utf-8?B?emk3SlF5M3l3NzUrSVErUWE1SFRnTFNndlBHaWUxZ2c2YkxJZjd0SWh5R2ZU?=
 =?utf-8?B?NktNdGlQZTNtNUJlV0g1OStqaTlXZGx6SktEbE5oOERvTG5RZDJGWmdsdVgr?=
 =?utf-8?B?a0lidHBvSGxoTnZ1Q2ZxellKWXVVT1A0Q2JVTGhCY1VTcjZqZjVMZkFMTENZ?=
 =?utf-8?B?azVOb3dBTXM2WFJZeGFZTFhkbzZRNVh6VXIvQjlVNSsxY3NiVEVWWWJkcnFJ?=
 =?utf-8?B?ZlRRZWpCeWk4SlBza3JIbnhqQlIzRHR5Z1NxbWZMSUFGNDM3S3o2eVN1RGxs?=
 =?utf-8?B?V1ZKS0x1eThqT2JQQ3BEM0NWcHFJelMzK0Zhd3g1M2FnQWc2MTNOVGIzNDJx?=
 =?utf-8?B?dnZ0ODVYYWNVcGUvcWdUMjlwS1ovQ0FDb3dpblJwVFlJQ3k0S0w3Q1ZLeFB6?=
 =?utf-8?B?amVGS3hFQk9wcTF4UDRadWRHNXlkQXFoOWljYnpJc2pVK2RMQ0hXTTZhM2gw?=
 =?utf-8?B?V1NtRnlnSVJGR1ltbmVpK0twMW9wa1d0dVlhV1NIb200Y08zdHpsNkNjU3Vl?=
 =?utf-8?B?VTJLeENRdVhpT1pXU09yVVBqckhqMDBLQWdJNmpiOGg3ZCtwVzdFMnlPWEZ0?=
 =?utf-8?B?VERpK2RrTUJsKzllUFE4L2hrd250SGdadDZuOURBTVRDL0xxSXNRbVI3amdw?=
 =?utf-8?B?L3RHd1c4bzN2REduZC85TXpXanpMeEtDY1lQOE1tQzRTZnhJKytqNVdlWEs2?=
 =?utf-8?B?akNFM1o5UDQwMSsyZlRmZWFodGlOcW4wUmxOTm5LUVNqMHZBR2FJdldqaFA2?=
 =?utf-8?Q?v1mZaxgepMosI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlNtaEJTREhJS1BxRXBpSzVCaS9Ed1V3aHQweEJXUGFNQ2kvSVZuZ3FhS2dz?=
 =?utf-8?B?akROOXN2NklveFZKdDJpdjhyM3hGeFdKa1pabDdvMnVlc3hxTDJCR0NkNFJX?=
 =?utf-8?B?VlI2b2UzT3pxYVRMUm4yb0Q0QWVOR2hFMzFFNWovZG9tZGdLTmE0VHg0M3VM?=
 =?utf-8?B?UWpnTnBtVnBBRERqZ3c3RjNNeUtKbld2ekhjV1YyeGRtelhxTGdzRmtkT0x3?=
 =?utf-8?B?T3ZZQWJJTE9hOEh4Tk1HTVdpSG4vWEZPVVB4UllCNTVkck05VW9Fa3VLTXl2?=
 =?utf-8?B?Q2RGWmJTRjFDR0FpTUJpc1hrbTJ6c3A0bDVqUEdMREpmVkxpdENFeFgrRHd0?=
 =?utf-8?B?cTBNZ2ZncFYwT3UwU29JSW5qMzQvVGJkcnZYN3VpQzMxWlgxTW02UmliTjhu?=
 =?utf-8?B?K29sczcvdW9iYzdjZGdtejNVTjVxWkVWczlFK1NCdVhDRUE2Mk5ONWtmRFgw?=
 =?utf-8?B?KzZHZDUyT09FQmp0ZGtBZkQ3NzJnQkozMHVaSFlOeEpEL2x6ZDZuQVN4cS96?=
 =?utf-8?B?QmR5a1lMRUhTbjE2MW16Q2VDRUptNGlyaVBFWmNjeEh3TXdyS3oyWGk1VjVM?=
 =?utf-8?B?ang5cENVRk42SVFyMG5qTmVkWm5yeVdvYU1HN2xrMkFNTXNHUmhqcmF0ak84?=
 =?utf-8?B?UDhUQ0hCejhIVUdJajU0bVRMM3psT21RNHg0Q1d0REJsZFFBejg1SklDUk9x?=
 =?utf-8?B?MEM4RUNNUjM4ZFdGcTBhQS9FTmRqZXVXTmtrQ1BHOFZJSmQ5cCtQTloxbk02?=
 =?utf-8?B?Z1BxN0RYL0diS3gwVW5aaDJZU2crTWNDMG1OTmN1T1YvTUJ3SjlNcUtxaTd0?=
 =?utf-8?B?SlJobHIwd3FrengzVFJSd3BPNit1cVNBckFaaENNb05rcEhWUGs4KzQwT2tQ?=
 =?utf-8?B?ZDFENjQvLzdxTU5pZ0NwcGs2Smo0Wlh4d3EwKzJsc3VCblFGeVEyeWNKalZR?=
 =?utf-8?B?YXZUL1YrMUdmOU1FUHFJdVQ3N1RLc3NrRHBLaWF0ditoeC9xM2x0N0hLa0I4?=
 =?utf-8?B?c05rL2lVZkVCaytiaVJuSlVaclJ1MmVPS1NmZnBERlVrOFBtMmxYcnNDSlNV?=
 =?utf-8?B?ME0zK2VaNEpwMVRlT0p6ckZpWlBUeUxZcVJEeWlUQjhVSzlIQWlwZkZVMkFE?=
 =?utf-8?B?TUZaVFpHbDQ3eXpXTnd1VllSdkh0ZHBEZjlIR1NaN0NyTkFoOGFQdGRLSU51?=
 =?utf-8?B?ZDI2U01aTkY1MVJzMkppbEk0WW1XQ0xLUVVaVkJ3UmlLcG1wWVdmL2VWWmJ3?=
 =?utf-8?B?aUFhQk5yT29DZWNKaTlxQjFDNmxxQUI0aDdvTW5UVmMySlp1bFk5eitFblRX?=
 =?utf-8?B?bkRBKzhTc0hvM3pCaFFyTVUybWpFUkZXRHl2c3N3VmEwdEVnbS9UaUYvZzcw?=
 =?utf-8?B?bG9NOWpRSlQrWCt6RVphbmZPSytiRk0xQVVqU1Y4eGdkM0xKUm9WbUg1MVBy?=
 =?utf-8?B?djR6b1VsTGZ0NXo2ckJ3UzdOQURhYm0vTXlPWGYzTkh5cHg3b3NLY2MwVng0?=
 =?utf-8?B?K2ZmRk01U1BUa3VvM3ljZ3lOWWxZUUtNV2VUVG1NdkFFdFRNNnE5VDJOQ3ly?=
 =?utf-8?B?SUJwOW0yQWFuUk13aEdqd2R6VUNPZnFoQ1FTM2VxQWxMR1NTMnJ6aUEzczZx?=
 =?utf-8?B?M3BnWE95MUNVeGhhczJ0RWRjUkNkdzBLUWt4SGsyM1FSY2VnZURNMVpQRTBL?=
 =?utf-8?B?WHRLVFlJOUJ6MEVVa3hEdm43RFN6M3JHYytIOERzeFlISWd6VVdjL05aZVFE?=
 =?utf-8?B?MnJISWxmRjhtVzhORXZCVmxuVE1LZVBteXQ3M1NHNUN1YjcrYVoxcmowTUpE?=
 =?utf-8?B?ZkNWc0hRRzlpQ3FzS2NrSTB6Y1NoVk1tWHArMlBqcE5yRmdFZ3NLVnQ3SWdh?=
 =?utf-8?B?T3dwUk5HSllIVzMxVTdEdXlPd013SnUvZkZOMmJjMHlxOCtQZ0ZWVmNFaE1v?=
 =?utf-8?B?ZGkzRmFzRThhY2QxMTlYV1NxRDhFL2Y5LzFlV3B4WHRFWktGZUtNalhyZU16?=
 =?utf-8?B?L2E4ZEtnTDhTdVpCWkpXaExJSmN6ZGxHYlpEeFBEVk1FY3Z2eThRUk55UzB0?=
 =?utf-8?B?RmRBWjRqM1J5eW9qWUZBVERyakkxc3lob0N2TnI3MUpTUThUUlhNdUw3RGpJ?=
 =?utf-8?B?K0h5ZDh5V1NCanU1b0swVHJHYk8rdjNuZG1WSVpBanZsK1BVbWJHZVVOZ0ts?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	udr9Zs22zuBCiegWOvkGmxey7QpmwR1/cD4oixLcJsXVvMcNyha2Lfk/JkmbfRxIJtD2oaYJdQjx7eHRtO7Y80TSBwl0jR4eb66RbhFHdBqxgYSCE0Sm3mEP4h3SXD1t+mT2LwfW/PvfT6oQeNPaVMWfh7WSCTv0eIT3aan1zw/I40/jGW0s8W5wFnVqyK6En2cSl0nHqL2lfXE9Lzdy+OoEoT12zao8OMqFoB0iCHrcd8ulxVkJPUtlB5aD0gZlULr1HN29GTZmXKebKdPs4SomnG3InA/gOxRtG8vKZ1ZJcDrmGZcZZy+2iBccHXP/dxY6/fy6a+gAYVMtX+BuQ1uXaNwMiqaQ6acB10cn89B6xbMY5WuIzBY5sp4DN465d2oAUHAq6iiQAVe7gttwKt/u8hgNCTntlsjPhsBumbpcJhyxVwpymsGeP3jo/6GfxRA3Ub2fQsXCYbo1UnJI971yAxqnDwPCc1+UcXdDxKOKmOPTMB7YYar6seB3znVRqEnxuHzEW4tjXr82ZYf7E7MMZJitEtw5dpkqIJ3L0NhdFWGq6DUAgvh4Spi3ktSuDztykM5+gY4VAbnvxxocrK7X06jTY306G0fMzveDcaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d9d5e0-57ed-4e80-63a6-08dd620422b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 07:53:26.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxaOUu8VHxudb9H/YbKhymZyutdHiGNgG+hG+7fjCyXaSQ1MPbmUfJc+BmboeZYQOY/oaFzgrk0JsxJeibv21g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130061
X-Proofpoint-GUID: WW0B8K23UepXvTrTpf_yBoyvEa2gvMRb
X-Proofpoint-ORIG-GUID: WW0B8K23UepXvTrTpf_yBoyvEa2gvMRb

On 13/03/2025 07:49, Christoph Hellwig wrote:
> On Thu, Mar 13, 2025 at 07:41:11AM +0000, John Garry wrote:
>> So how about this (I would re-add the write through comment):
> 
> This looks roughly sane.  You'd probably want to turn the
> iomap_dio_bio_opflags removal into a prep path, though.

Sure

> 
>> -     blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
> 
> This good lost and should move to the bio_opf declaration now.

ok

> 
>> +		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev))) {
>> +			bio_opf |= REQ_FUA; //reads as well?
> 
> REQ_FUA is not defined for reads in Linux  Some of the storage standards
> define it for reads, but the semantics are pretty nonsensical.
> 

ok, so I will need to check for writes when setting that (as it was 
previously)



