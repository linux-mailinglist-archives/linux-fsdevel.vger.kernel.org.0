Return-Path: <linux-fsdevel+bounces-74710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM6VK0fUb2mgMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:15:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EC04A1D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63D1C54D8F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F554611E4;
	Tue, 20 Jan 2026 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NtSg3Wbb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZUZQXtQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420A4418CD;
	Tue, 20 Jan 2026 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935314; cv=fail; b=NkO7sXlvcKKfWGLfXeNZRw+/UjU9Pz9VUeppwgBuPK9Mlt/tTIMXDNF1nNWOn+nGaSrEZlDjJLws1xWTG3WXb+/niXsAedna2Ha0caVnR6Ss+ID5pc2bFPbLUXmroxcocjd3dfe635Soz6tiDT1BdwJUERQ3N/NZZhHOUplpZ7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935314; c=relaxed/simple;
	bh=ldrQ1ldOi8eYvBOv1x4hcN8+lwd3FvW6ZVGGKonHrWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/AA0npy+ro9BedJ/0SC5Tl1+VpgjNggxl/aSqGxNFdO4T1UOGt0lxcwlHQ8fqf7JEaFSTRMRmBA47hX3ICFHj4RuLSeMcVbZ+apk+rMWZl4Qs+c0H2vj6rj+9nIkBZ2sI0X5qMk5ya4VhFwV1TMHeWX48MSH2RWpZLEnf2zJ08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NtSg3Wbb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZUZQXtQ6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KIE0SS3523773;
	Tue, 20 Jan 2026 18:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=T9cSXRg/njU3QxusSKr68c8bORSwP0T1eW80JpvZbhY=; b=
	NtSg3Wbb347ELMy4dKQ6IFI16JxvY9jjWtkmYxppwDQg5Nc3cVB7vakgUxMKV2QP
	s3XVvlTLWj/ILGX8C5Bu/gm18p8TPqfcIRFUsJlqd++fx7hAxPvjxIgX9R5MngY8
	9mlOTjZcHVPRoDYqNTSHM3/tUQyuh48Y+yPX71Q6ZzLcQN33E36macLbqlELnwy+
	vO6tqDsZziw9c66afJ3XRGpQKD55nF64EtkMzvHcD6MOhmvggQ3fWpekZFQ9K3Ch
	QIFM2ge9+1g5wXQ6Do9BVIzBqf7q1qIbToncRZYjWEFXiOHYNZsjl2dlzvzJPgd5
	wGtrEKHDDxhWLXs47qxz7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qc9vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 18:54:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KIW3hE022107;
	Tue, 20 Jan 2026 18:54:45 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vdun5e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 18:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1FNf+NALgHemb5yWt/Cs/B25wi+IQL8fcF5W0hPWSE/xgzPKnqvJ7OhTWUas6dc4SMMt/LJhTC5ntbVIqW3xhESbpQmZmu4z6+h2E2WXyR71Pt3iTt5ZWlBAQPiJZCFVQ/YjGNJhwSOrkPe2juasgqZVyc9aacoScWnzYVl3ARIoRq+E/sGrYzHf3f4MvMHGQuDu8yiE7btwvqt1BwiZKIqAnQ4nKoqvmuOGIXO1k3Rswg2HeZhGuPueVS1iXWUZWQsXLrex4mpBFsrzLFAfdOGd9Z6DAdZ4kondZvqzot39TdW6qvnwLElnIQzd4RHADbs57arns5/kHjpnJFG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9cSXRg/njU3QxusSKr68c8bORSwP0T1eW80JpvZbhY=;
 b=nmZdIEotoIzaSCz46FTWq8iCDVmcHhgWU1pSgI7EWLbp/aKHTl3EAekgjoobA1GUZgtj4yj8CH3NUjXsMI7JkzdFUNkBM3E9iz+4HcsdYoJwj3hBIL5W44TGuotMMOD/VQOnH5Gi+NDsKPrtV3oLaMAaIp0TzG5KcEFSEr1GM0LVpdhkevlrTrqvEumgjwvqkLVvYpUZTK/ZzknXMcrUoOR8JT5LFfOEhvITlKz0zdFOm88cSfYyX1AugyTe22MgLK4werEB+X5K2vXUaJuC2cOUf6+zXJEhnvMvgDRx6YxMEQazr5DJSZFqKRISN0aJMWU5grV5G0K/dy0p/Yf7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9cSXRg/njU3QxusSKr68c8bORSwP0T1eW80JpvZbhY=;
 b=ZUZQXtQ63C3DAVuzixodnyodvZUJaUHueXs1H/s4rAC12FHw2t3jEz1LlwbX5JXGik3zKJwAYOsQ1OFoTq2pSpV11bSt1nItM8Idin6ifkP061Lq6xXZFlhYQ/7QdGUizY8JupwnhiIjNScHzojKYPo6AE05GR2QHfYbtzln/Eo=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH8PR10MB6359.namprd10.prod.outlook.com (2603:10b6:510:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 18:54:41 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 18:54:41 +0000
Message-ID: <0b0112f8-793c-42af-a2a7-ee662496a9e4@oracle.com>
Date: Tue, 20 Jan 2026 10:54:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
To: Christoph Hellwig <hch@lst.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, alex.aring@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260119174737.3619599-1-dai.ngo@oracle.com>
 <20260120072638.GA6380@lst.de>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20260120072638.GA6380@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:a03:338::19) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH8PR10MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: fb08aad1-f80a-4961-0a87-08de58555e38
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VmJ3VS93STVTM0tOcGNzT3pjMjlvMmRKdkcxU2pYUU9BWVV6YnNYYys0TnIy?=
 =?utf-8?B?elVmM0kzY3BJUjl2b1Y5TDhvTFpSTXp5VFpCQnRqcEZvcXVpdnQ0T05ZS0tV?=
 =?utf-8?B?SUhXcWM1TTRGblVVN1NYMzFCTEFKZ2NYNGJFTnNHMisyTU5BK1ZkTWo1ZVR0?=
 =?utf-8?B?ZVNsY25UdUE1RW9ObjkxWCsvamVCYVRtT3ZCdERvYmNiYUo5SGtoTStGck5Y?=
 =?utf-8?B?QmJybVpCS0E3WERNemZnV2k5UmlUbFNmN1FjQ1hKdUVEbmhONUlnSjZQTVFB?=
 =?utf-8?B?VldaMXB3aVhqeVRoZ0dkSUpwNTR2dUdlQm55N1FCR056L09vVFhibk5sVXlv?=
 =?utf-8?B?eUpVZDVUQ0tGamVBSXdkNFFYVHdsTkpacDlPTlUwbElpR0M1Y1RFbjl6Wnpy?=
 =?utf-8?B?NXBibVFuWHYvUjdhTmR0WnVrWXVUMmF1a1VLRE1CNE9HSmxNQ3p4c1hBZDlM?=
 =?utf-8?B?T01yMUMzMlpUdzN1WHFxcUV5Q3RYZFBWSHNDZDZOWnRBMm5LWWVCdE9BL29U?=
 =?utf-8?B?SURaOWdRR2RWbXFOd3cwR2RMczlUT1RING05Q3dSbHhlUDcxOGZVdVpNcjU4?=
 =?utf-8?B?S1F3N0lQOGZaaURmMU1oMlh5YnhOM2FiYTFoODlxRG80Tk9KaHEzM2J2VlVE?=
 =?utf-8?B?V3U0VWtwV3FCSUJRZ29hLzRLa25ZRWNpNE5leHlOdWl3UExIc20yVmJVN3Vn?=
 =?utf-8?B?amNvaTRGbC8vSGIvN1VhMVViaUZhQkhkaUtOSzhIdzFaM1hyTndtR1A0c21x?=
 =?utf-8?B?R1pTTG4vWDhCaXdrWlFDY01QeVJ6WTVXRFdPWExUclNEdi9KanFSa0RyNXBZ?=
 =?utf-8?B?b29mVVJNeTZIeVFnZklzdWVLWmg0d0FSVzhzd2tYVjRPQzZpSDRmRE9xY01v?=
 =?utf-8?B?eXpJaFNMSVpNQjM4RWt3YnE2ZWROTnFpeGlKTWc0WjB6UmlHOFg1T3NNZGRO?=
 =?utf-8?B?MGdtcmRKSTQ4NWd4Sno1WFhXZTNOcklVYjNUdDRIblVFdjRLTHlqNVF1N2Zq?=
 =?utf-8?B?aGRUaytlMzQ0cEZnZlNhQzRpZXNiYzFIQUMxMWZrVXlrbnNnN3JwN2lvTGJj?=
 =?utf-8?B?UE5WMUFyb09VNFgybWVaMnRUR3p3Y3kyTU9TVUx3WThFWFc0OFhrODE2Mm5s?=
 =?utf-8?B?aTNqZkwzeTdzQXNMVlJocGE4bCtJb2lmVHg1TjZKMjFxOG9ieGtoaE5HZzVR?=
 =?utf-8?B?RllRZ2E1aEVLMDdWMTRtYjR6ZGdxTCtNdldhbThXOWZUQmkrc3hrVzNKek54?=
 =?utf-8?B?cmN2Nnl4N2l3MVpnckhwWUI2dUN5YmNGaFl4SGozUnpnZ2taTVd1d1ltUXpy?=
 =?utf-8?B?b3hhQnk2UHlPMXhYQ0c1NmhSSWFoSU1aUWlXWDdzOWF1TXk0QTZBZkdvQ1lj?=
 =?utf-8?B?QlJiNTJPM2JDclZpVVkzSEpNaTBIVlJxRGdWM3N5SC9uVnFHYy9XK0wvMnhN?=
 =?utf-8?B?M1JoMTU0TS8zS2NHT1Q2c2FIQ29nTDZVYUU3WmxjRC83d2RDbndTN2pOZGpR?=
 =?utf-8?B?U09LN09ydVhzQTdCRWxKSUYxM00zWERjREFUajdaRkJNeDdkS2JZMHhTMkRq?=
 =?utf-8?B?eWJRUGlkMmRkd3hlbjVzUCtoRzNTeEJSSlg0NXhxTEd0SmVOUmNmSUltOEhF?=
 =?utf-8?B?M3NORzZydHBKS1RjZ2FEamlValErcTREcmxyYng5SjUrd3VnSE9LZkd2TmNO?=
 =?utf-8?B?Qk01M056UGIrenpvMDJqS0drS3FPT2gxY2ZKUld3cFYvZm1SMEZiMzJYVWJm?=
 =?utf-8?B?Ulp4aGtnWHR6WXo1N1A5MVZCMzlGZWNlRG9oMm5Bei9Uc2NpWlV3VnQwNDNZ?=
 =?utf-8?B?ZldRRDVJa2hNVHhvMDRvRkFBVzVycmplWVVvcWpOeTRkazNoYk5CeE5UVWcz?=
 =?utf-8?B?VjcvSkYrT0QxT1QvV0N4dHNvL0xRKy9SZjlWdFhhUlNZWWsvZGVlL1NaN09B?=
 =?utf-8?B?NmJ5WjdXWFJaUXhQaERscnI3YXo5VHhCbVkzSUZHMW9NbmQ2ZDFaQUJSWkJ5?=
 =?utf-8?B?VFRyMzRLYTQ3NzNYMFNXdTBSVThxYk9YVFBrNmEweGJpNko5Q2FXU1MrUERy?=
 =?utf-8?B?YkJ4VThUL0ZyU01qQVdFT0JZRXFsTDIyMk9Wa1h0dWxidnR6cDF6ZEh2T1J1?=
 =?utf-8?Q?+yos=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NE83cFJYeDVMQjlvdXRVZDNsbGtKSmpKQ25xSGtoZm1ma0owTWdKTXM3KzFq?=
 =?utf-8?B?MkVUVng4bzBBZUM1ZE9wV3RqVU11Z2ltdW5JM3JEZmhmT2NYeVRWME8xYnhR?=
 =?utf-8?B?MFdIT2hFYU1OK25FVTdBSVdNdktPZ1BJaGY3OEsxVjhjaStFZUhDdmlydG8w?=
 =?utf-8?B?UE02ckt4YjU5V1pyTFVkTGRaUEwxM1FaTmdia0pZcVFsbWlnb3ZsRHNRb0Za?=
 =?utf-8?B?RkZTbzlpQnF0dzErSXI0dW1vZGJVSm02WDQ1aUYrVGRNelE3MW5TNkc2OHhk?=
 =?utf-8?B?NEdlWUV4VmpyY3EzOXloRStFMUV3OTZxSEFNUHovOVVBd2RoaDRBbXdnNEVy?=
 =?utf-8?B?L3RxNjR5OWdOYkxLSGJ2N2lraGJZV3NPREd6WHM2WGk0Z21FcWxCcUx3VXBL?=
 =?utf-8?B?NVp2cW9FNlpVV3EzTE16NmY1UXp6WElPakY0OS9EVW9PM0dqd0xteHNNUEV3?=
 =?utf-8?B?V0lIc1dRQ2VQUUtXSkowdHk2Mnp0UHgwN0FxSnNlSlpqUTVEV1NaMUMwMWJK?=
 =?utf-8?B?dFc2Q3JsT1BFMXQwTkVlUUF0akJVbG9CZ2s1V25ibWc2MnJDWjhCbzdUYVhI?=
 =?utf-8?B?OXlGdi9NbEliRVF4MFBpd2xNY3djSm8vK09WVjAvWHU3UFEvZ29QREkza1pz?=
 =?utf-8?B?M2E2RFpJSzg2KzJxZk1tVTh3SUt2WDdsMnV6ZVdNdy9hSlhKUkd0TGkxNGdJ?=
 =?utf-8?B?ckxBSUU2ZVZyVVNrWHlpUG9UMWN5eWY5dUtVeTNMWE02MGkvZmozSVFZblRW?=
 =?utf-8?B?QUZaTitNSTZmMkRwZGhaOHdGNEM1SHF2UjkvSStQV0R3dkZJem44Si9LV2Rh?=
 =?utf-8?B?WVNtb3RqdzJLcTBacWJyeExxb3hSZ2F6T1FHWG9SS0c2YXN3RWJkeTF0Rmk2?=
 =?utf-8?B?dmcvVzVuanVSRnNrSVEzaHZ1NjV4ai8zOGRuTGE2aG5NZHpOdno1YnYvNnFl?=
 =?utf-8?B?TXV3V1dMeWpCdGloVGtWeitRUVUrbUpjZ3QwTWlBMnVEUittdDJMUm9jMmNR?=
 =?utf-8?B?K0FnaUVYNDByYmtWZ1RZUFhDWFlNSWFPdWd4VkVxb3BtTWVhcHltY09PUWlV?=
 =?utf-8?B?RVV1SEMrRThXQ3pUZVlQeWVsZFZCbm9mQ3ZxTjF3bDJ1UTRyODNGSTFsbUpm?=
 =?utf-8?B?a1RzdGJsdFpKUW1UaHdmQjJUTi83MWlMaHlBY1ZWbklreGZZMUdFR1ppcXJz?=
 =?utf-8?B?WnJMZmVVc1p4NkJ3Z3V3bHVQRnozYldsdkNpSkVZMlZtQ041NDhqejN4RUJG?=
 =?utf-8?B?OTZ5MGZuNzh5ZnhOMm9PRkRKUUdqZGoxMXh5eVM1WXZOVHRsdWpQdUtGSU5o?=
 =?utf-8?B?MXh3S0NwNmU2SnM4MTY4bWVSdFhkNWVpMWV1bWJBVnV3Zk1SbTBsMjlMWmp2?=
 =?utf-8?B?VTJNdXRqN3I1bXBXaHNzKzA5cGY5M1VHVjg1ZEljazk5anpSTU5CK2ViZHpO?=
 =?utf-8?B?bkl6aERZTk01aWgwdnFjU3ZLUmIrQzV0NzVrOE9SVVB0T1l0SEpLWGdKUzRJ?=
 =?utf-8?B?T1hqZm9qSWxOdmpROW5GSGZSb28wZjFaamVPSHBhNWM2cTdzZVM1RWQ3cUFL?=
 =?utf-8?B?VlY3alZaeWljb1JOVHNiUTE1V3BFcG0rR1FHLzFTMTY2TzBMNE9HaW5FemR2?=
 =?utf-8?B?VmNhUE1uaWRnTERLNWFMZVExYUJCNGw5VUx6UTRiaTR1WU5FMWl5a2hRN2sz?=
 =?utf-8?B?bG01UzYveFpCVnZVL2Zxb2l3RnRWWXlpZHFkdXRyeS9WRzVRTjdNZkVuam5F?=
 =?utf-8?B?T3JJYWhSQnBmemJRY3ZIaE53UXFISFpMbjNkb1pybnRTRHZIazRyQkpEeHNi?=
 =?utf-8?B?OCt5VlVzT1dOMEVFVUhmaElHRXFEZjlOeEE3YmRJOXZ1VmdKdHU5azRRWUFS?=
 =?utf-8?B?ZVZhRkhGNXVIWFFoZEdyL3lWZjF3eVc0MW1GSnFJUzAzUE9Tb2w4SXJ0K2cv?=
 =?utf-8?B?aSs5ejB4SmNhNHNhcllGUnlkZ2x6dWJVc0pqVVRkYk5BWDVnMUtCTEJSalhx?=
 =?utf-8?B?ZkpGU0h6QkpKdkdWampSVXZ1VU1aZkx5TXBSODhxem02OTRYMzJWT084Tzg0?=
 =?utf-8?B?cyt3NVZRN1ptS0FmeGppV3l5Mnp4TWVHZTNSeGJMWmhLSWFwVUE5R2hXajlH?=
 =?utf-8?B?TkxnSVk0ZkNpaDVIdU5KbUp6blplR1VId3JEaXpxdDFiSnp0Q0RkYlJrTmpE?=
 =?utf-8?B?djc4K3ZrbFdLOG1TY1J5b284OVNUYjlJb3g2S25DWUx3NWJVVE9xUzhTVWlD?=
 =?utf-8?B?eVNhWmhONEdFNmtWaUdodlRMNWY3dnFUZWhLSnBpUjIxUUZ0d3ppcHh6VTJh?=
 =?utf-8?B?ODNoMUoyY2R2eE9jSldMZFF3N1N3WUx1eVl1TjNNNWl0U1lCZmhYUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yixNwGWjr3R2Eb8O5tbKBh5rlM+7jqwL8HukBCZAvsM40Vv0kBwuyAZTCCvyAcNFR69He7kZuFdYac0vveKRDErnfOMToyKk/kacW0yh68hxo5A80BH5IAwQFT4UbqM78QsM5PE2DFGcyZKlRVyKxs9w4xztM1LMWW+9vd4KCGX0ekycjY+JDcQbORcorGA/Y5GA6+WoGczw3jT1RvttORiTLw7zmGHljK23g8vOYP3UWISkdKQsUTHF7nO0zpemfrIEvYLryrVtVsRC3hRzAijnDKaBO7/2wDZN6A20Z5NlPMg3kujwOA/7F+m7ojIq6LaZzScYB7uddpP1e5Y9ZWQFuhbEG+LG8HYN03I/zVhtQpRbO9IvY7ckJlLuBtouDZuCP5aob74eimEGPELtFtbJqlXbZKPLrB2OTZdx/VZTp6AK2CIpbEdxpdBhSJicmuHzdjR7z9OmvaiNOO+ca6AZ21V2a7RHF7IMFLGrkgw+M1Ks9IV/w7l13yXwgaxFQ+a7OQ5Uf5KT7lm+VgyL8/+7iiQGNWASceYXjqVicz1HZmNK+KBFxjyRvAKbEothkPW2/9tFYvfhm3nsrRoto/O5+TqSdIVGsGjCVWq85CI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb08aad1-f80a-4961-0a87-08de58555e38
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 18:54:41.1783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: En+kvM+L9yLYn4PFC3fHhkIOhm7+/CFl55MWG3qhVo6KPk86J+5CQwMSvaCcvjfll1qHhxnmt7nbkm6FltkJFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_05,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200158
X-Proofpoint-GUID: M1TjdVMKCV2IxIZ_ZOJZv0goqNd_EVJt
X-Proofpoint-ORIG-GUID: M1TjdVMKCV2IxIZ_ZOJZv0goqNd_EVJt
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696fcf76 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=cNemC27b1QFXb5zMM38A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE1OCBTYWx0ZWRfX1eR0Pa4WdRuC
 hC5ZuJEhQ9SDgkgmYk3YKj+xdrAHCL6gWC+KRE/fh0zwQpSDeNXzI7rk6ccNQziqFnRACRre7Bd
 887W41m5AEnE1rXBj7RMTsOzJNvfRQR5DIEF0vUEuYoXiod98WrBgUw7Wi6lukj5onNbZ4H6jzT
 GWILkgqo0kMvO+ndqq+jYh73JDQCAShQHfMy6mhOV8GFZtHF57+z3a2um3atND4s8vsURDSfDhn
 JJA5gPLzLKhMx0vp2W1MNxXJvchOFzH4pXC8Q+xu2Lo+Qb4SZIKBZzZpVyFmmoRwhpF3ftjgXlj
 OuB8M7eOJYVgt9McfkeIqKk5FQkoYgiSDyYbAD69L+iHyz9MQz3s4GEqIihdUKAkzbHb5ltuH52
 q7F+8TOHySo2ZOyInMX5NiBddIZwQuV07kRW6+eJBs/5EKOxkgi9U/CvDo0idKP69fRDP2TeCyC
 7XToLWaxMJXlf6xZGNnaZAVO4PrL9uxtrnX1SVgY=
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,gmail.com,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74710-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 22EC04A1D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 1/19/26 11:26 PM, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 09:47:24AM -0800, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout
>> is necessary to prevent excessive nfsd threads from being tied
>> up in __break_lease and ensure the server can continue servicing
>> incoming requests efficiently.
>>
>> This patch introduces two new functions in lease_manager_operations:
>>
>> 1. lm_breaker_timedout: Invoked when a lease recall times out,
>>     allowing the lease manager to take appropriate action.
>>
>>     The NFSD lease manager uses this to handle layout recall
>>     timeouts. If the layout type supports fencing, a fence
>>     operation is issued to prevent the client from accessing
>>     the block device.
>>
>> 2. lm_need_to_retry: Invoked when there is a lease conflict.
>>     This allows the lease manager to instruct __break_lease
>>     to return an error to the caller, prompting a retry of
>>     the conflicting operation.
>>
>>     The NFSD lease manager uses this to avoid excessive nfsd
>>     from being blocked in __break_lease, which could hinder
>>     the server's ability to service incoming requests.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> This looks reasonable to me, but I don't really feel confident
> enough about the locks.c code that you should consider this a
> review.

Thank you Christoph! I have a couple of questions regarding to
xfs_break_layouts and xfs_break_leased_layouts.

. Should we break out of the while loop in xfs_break_leased_layouts
if the 2nd call to break_layout, inside the while loop, returns error
other than -EWOULDBLOCK?

. In xfs_break_leased_layouts, the return value of the 2nd call to
break_layout was rightly ignored since the call was made without
holding the xfs_inode lock so there could be a race condition where
a new layout was handled out to another client.

So xfs_break_leased_layouts only breaks out of the while loop when
the return value of the 1st call to break_layout is either 0 or an
error that is not EWOULDBLOCK. And this call is done while holding
the the xfs_inode.

Since xfs_break_leased_layouts only returns the result while holding
the xfs_inode lock, then why does xfs_break_layouts still retries
xfs_break_leased_layouts when the retry flag is set, isn't this retry
redundant?

Thanks,
-Dai
  

>

