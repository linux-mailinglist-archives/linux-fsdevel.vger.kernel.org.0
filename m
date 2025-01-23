Return-Path: <linux-fsdevel+bounces-39926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45290A1A0CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 10:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F81C16D4DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29C20C49F;
	Thu, 23 Jan 2025 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EYzxi25B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s45QFGaG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504371537D4;
	Thu, 23 Jan 2025 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737624526; cv=fail; b=GPRtYiPV8SgE+aevFJUOriGqOVw4zQUKP7oXbyVmPI0nhZFArjRRuoi+OznFHD4KQGuIFbeeP9JsOMvsqHUJXaXyWKopCgYx5RuPFZqi39nNHBFHZwQ2F1BpIUdP5uhuQGXKRlGbun+FE9SZFh9DuKZOX0XhZ2cuc3r00YcRwYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737624526; c=relaxed/simple;
	bh=A3HhWxFog0MDN/0Rnen5R4/hBnRuzHqBWk6Wimfg4b4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g6kB93fHHNm1kwmu8uOjfgdvFK8D5WwS6GzewRDkg1Xml6R+mgKCGIJk+yQWU77bqGxs8Aye/HWP3xU98NEjbnBCTFwA4VB4ZV36OqSOPK55U/T8LaVPYwAfp4kDlm33WX58OLQcNUyNsZtNspAJZV20wlYYooyCx6kEcfBHh5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EYzxi25B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s45QFGaG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N9Bwem023469;
	Thu, 23 Jan 2025 09:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4oIukZe1T4y0Pc0xQxpwh+kxmKXfkriFI08VN8s8zsM=; b=
	EYzxi25BSY7g25hxIIlqRYxhF80XLZidOx24HWP5gQcejD9ddZgwh1eAbpr6c/gi
	oQAJBeCVoqgVHB+tUOM3UO80wnRjdpV2mMPmBdHjHVaziaZFfUywQ2ipMM1H3qAq
	pYcimrGnVZCo7WfHW+HJtDd8EjjIJ2DfS3MbjmWusNdP94XGLMllJ3fVz34yL9xD
	95QX+v28hRdZleTyOWudFmSbxkZpwFxcgTDPIiCNsR7vKWgsuZIKgcCwQGXHb1TO
	MRuJh1k2MlFuHZkMdFqfZZtYQ6xk4EOLRC0uxr9aUuN55Nh05CXhME1jc9r9X1uH
	85kIr6fidVZl5WjtmQYwHw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awuftash-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 09:28:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50N8OHoU030428;
	Thu, 23 Jan 2025 09:28:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 449194ws8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 09:28:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Exn9I/So7s7M0E/Rrv8W0ghYoJVhcUVgS/vBBxtKNY9pNv6n0QkkBERHZz9jHcAwxon5BFPc/ib2XF6MRQp9EIEHT/NHGNFyaIToGCO3RWJN34F46c+O9jBNbyNgQPjVdtn6M7UIiuZmgvUy1vQoubBHzmMyKw3zZHM4fBXEAerciv9RUEndN+fLMlJ3bxeGSQQuVtzgzfAghtCiCEljlek9ICHit+7am/JRGC9P00wFoXTRFnv6sWzL1qSo6izc7/7lxv6NrHGrbFq2gnez/bflsk6E6y5xc9SyXkE0p/sXXEpqMNBztIbieGfZLYZFGBy5/DG+CvUkn6DlqrUTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oIukZe1T4y0Pc0xQxpwh+kxmKXfkriFI08VN8s8zsM=;
 b=kDpOaYB5Nl7DpL2ipAKcBkarlzjWog4AqXLqYgpBab0bK3yOFxVfbhk+UhkL3ULC1Oj+koWnN9xyY/35h1/paFXlmRwvWLUranCrQoh60SZjh80MRgLX6TAt+IlfoyA+nsKy+PCyY7k9AgZ4DP7+TPvuwamzmRwCvHS7/RNna8ULyFBibS+xnZhLJuEFbqC+ba7YdR08dcB3qE28XV0Wb78pDOtxarlFk0C1pdgK+1gPey5MDxWWB63SSOqsE3TgwaZrwK5JRrb4pOZ6fdUlA5XyuLcPNlW8+X3F3TDRw/Akj9CBUnICOW8cA7QX3mTgUxKNEWDDfbzO6IuxyIckZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oIukZe1T4y0Pc0xQxpwh+kxmKXfkriFI08VN8s8zsM=;
 b=s45QFGaGJkmV2kFPlGm7FcHyJZegXAX5zsCH8A+gSRG+AJGM5wBRXhQwPZMtqOXFtESie2EBk98Y1IJNeC8J6Qxu4BjOe8Wn3hM/5a1z7Mn+Oxew0nPOtEUbuIwQrUsFSD2fK7fFM8dHIraTS5JOIhg8GDuVATbs9XxYIj1XE44=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5152.namprd10.prod.outlook.com (2603:10b6:5:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 09:28:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 09:28:16 +0000
Message-ID: <ca18ef93-2db5-4958-abf1-65d94f1c71a4@oracle.com>
Date: Thu, 23 Jan 2025 09:28:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
        brauner@kernel.org, cem@kernel.org, dchinner@redhat.com,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <20241212013433.GC6678@frogsfrogsfrogs>
 <Z4Xq6WuQpVOU7BmS@dread.disaster.area>
 <20250114235726.GA3566461@frogsfrogsfrogs> <20250116065225.GA25695@lst.de>
 <20250117184934.GI1611770@frogsfrogsfrogs> <20250122064247.GA31374@lst.de>
 <0c0753fb-8a35-42a6-8698-b141b1e561ca@oracle.com>
 <Z5GEh0XA3Nt_4K2f@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z5GEh0XA3Nt_4K2f@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0205.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b8dffc-b46b-4bcb-b92d-08dd3b904429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDJ4cW5YL0F1d2FXVkU1akdxZ3QwSGxybWx1MXFkaDZVU0dLdmp2bnoxWW9z?=
 =?utf-8?B?MlUwWTJmQXNpSjl0U1hwY2xzSk9wMzIxbnVhelJOdVl6cDRNR2ZFZEdDUy9s?=
 =?utf-8?B?SUZQZjhEaDVvQW5tZndlVEpoalJNVmw2K2R6bk1ITWtMSDRNcTZJT1ZtMnVK?=
 =?utf-8?B?RjlWM0ZkTkhneFdadzJWNkNRUnNuRFJJT2llaThzSTQvQmFydDVtOGU4Nzhk?=
 =?utf-8?B?bEtmUGJhOFdyaGtNQis2QUJ5ZmdWQkhaQjhlOS8zSUh3U0doY0daZ3lNUXRz?=
 =?utf-8?B?UGp5YzlaYWYyR0dFWTBCR2NKUkRrVVFuMVhUM2l2NDJFOFdpb3FlczNIRlUr?=
 =?utf-8?B?QVpqZU5KZW1VTnlBeU5hQ3VxbHJValRFSTFZc1FlTENUdUVRNjZBSVVEWDUz?=
 =?utf-8?B?L1pJdG5panh6L1pZeWxwK09PTm5tSUY1b0NLcUcwNHMyeXkzeDZlb3YxMlAw?=
 =?utf-8?B?bEVGMllhOUVTVkRFLzhLRkYxK3hmUkRRWXVGQ1JLWHlYZDZYZUh6YXE2d01n?=
 =?utf-8?B?RXJ0MEZMSzc3ZlVqMFMyNVJxcUUvQ2o0ZE9nbVdIY1RaYmMvRkdzaVcvb29r?=
 =?utf-8?B?TTlPWk54V2dyU3F6UWlVVmJzMHFtZm9VdEhGUHR5d2wwWXZWejNBdVNDblpV?=
 =?utf-8?B?NGlDMnI3YzFYYUJWSWxCdjZLd0NPSlU2czdrdUVlT2VES2Z3KzRlSmwvMGtN?=
 =?utf-8?B?dnNDbVJOUFUrVnZBcUYxbEFPZHRuSFlEN0poRGhDa0FLd25vLzVBbnc4ZmEx?=
 =?utf-8?B?U1FibU1Rbis4UDU4T1ovbUtOb0syUmJ5MjROSXQwZU8yTzQ3azZ6UisyNTh3?=
 =?utf-8?B?cytVKzlEeHBzd0hsN21EZnZhRjBJa2tKdTBFbmFnSUtBNkNJYnB3bDRsYTY2?=
 =?utf-8?B?bVR2WTM2QTlFaUlJVW9lNnBxeEJ2REVIeVB2cnJPOTJiSjdxTXczcVcyYzFC?=
 =?utf-8?B?NE92bThEWTg1OVVtKy8wZCsyN2VNbm5KZ2x3dzVWVDhhVzdBVXhJY0NHZEp1?=
 =?utf-8?B?SzZ1ZzFBVW9aSjVTK0F4ZzdHVjRKbHJ0RWhPdVlyd2pJVUtDdHZNcE5RSXZu?=
 =?utf-8?B?ZlZwcG1hNTAzTk55andQVFp5a2FVWUJqWEF4Sk1DWjBKcXhibjlXUVdBZEhF?=
 =?utf-8?B?SmxLVlcwQVg2U1NmS1BkclBNREVGdURxT0lPem5xOXJMeklLcTQwN2JmNTB3?=
 =?utf-8?B?OFBua3dzRmgwcWYyU1BqdUVNVkpKRTZBZFdlNWZzKzltS0NsTG1QVitMejQ4?=
 =?utf-8?B?dWxwYllIeGc4QkFidWlqRDhZblJBVW92WEhuK3VsaGFzcXVnOTFBRFo4WlVW?=
 =?utf-8?B?cit5UjYxYjFVT1JMKzVzemhYUVlpaGlvNDcrY09JRnJUQUNaQXZWWmZaNjZK?=
 =?utf-8?B?N09OQzUxQmRwclhCdldFMGorQk5PdXpGdFhYc20wb2k1Mm0zMEpMbHIxeUJT?=
 =?utf-8?B?VXp6SEdEQTlCaUFNc2pvdEUxNk9hZ1lURE1vWUxkODJhWjRHUmhPUEJTMFlR?=
 =?utf-8?B?QXdSNU9SUjNNNzhUZU83UkptQU05RjlFUU1DMUl5d3ZjL3RCd2YwbjU0YUta?=
 =?utf-8?B?M1Y2cnAycDFhMmZObjBSODE5U0hIOUJhbUZ1ZlV0WmU1U0FKNU12NjlvVzVk?=
 =?utf-8?B?NmNReFR2dkIwdmVrMHBoa2V1c3dXT2psc1pLaHJHQkl2UzlJMS9jVkgyYWZo?=
 =?utf-8?B?b05DWW5vWHpJaWFJY1RnSEVQcjhnWmd5UDh5bFU3S1lnNGlhYTJDRzNuMmJU?=
 =?utf-8?B?UmVJaUVPY2ZONHkyV2l5bUJ1UWdxRWdwM0lmZHBvdm04NFZ6WitCZFFCaFFL?=
 =?utf-8?B?VDNOMlJuRTBoNnZtWXpudkVqcHlHanEwcXBlSS9weXdmT0Urakc0Yjl2Q0dr?=
 =?utf-8?Q?+YXExRVzzOANj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG5SM09vdU5NNVFSek5sYTVCamVnbTZsZ21kaFZKS2xrNE5ISU1SVExBMEJr?=
 =?utf-8?B?bWRNenNUMGFYbzV0SDdTd0NzMk8zdGpEbWo0dndTdnNsaERDTTBETU1Tck14?=
 =?utf-8?B?dnFZYTV0RXhKWktRUjJhNUlzSDBPNkZORnBjbEQzRzU2dGVoUXBaRlY5dVBm?=
 =?utf-8?B?Qkg2aWZBV010TWk4RlQ1NHJNMFRBQXhQQmZQditqQU5DOHZ5WVVPU1hNZFZP?=
 =?utf-8?B?VkwrV2Y3ZDU2VU53RnpQL2ZhQW10UFhONkJpMGJZWUE1Vy84OWMxdUNPUFM5?=
 =?utf-8?B?Q29MMEtCR2JhcEJaU0ZGZC9LZVJ3WlhhUDhmS1dzM0RGbWJ2L0hpZjFURk5r?=
 =?utf-8?B?TEo5dDl1UGxiV3V3d0ZRMU9hOWZhQkJXQVNHVEZrZG4yYWxrajk0dWRwYzFk?=
 =?utf-8?B?Tm8xY2tnSjJrWFdEeDNGaTIyakp1RTYvckhVclB0ZzZVVVA4NnBnWnN5dEh3?=
 =?utf-8?B?VDI4aUE0bG5XdkJjRWFkcXV4bTBTMDNtQkVJWk90WDhSYWhYVXRnb3hybUxS?=
 =?utf-8?B?YnBpRDZJcURPbWRPMDBhNkRGZS9rRlRIcW5MMVZNKzByRnExZWEzandsa2pz?=
 =?utf-8?B?WXRQWXBEYVIwTXdEY2tOU2RjaVhRUVpxWmE5OUVOeVpUaDN4eFNnTzRBb0pm?=
 =?utf-8?B?UHQwT3k4WGh6Q1Z0ODZOS3Nnc1RRSXRYNXZPQXJPY1NydWZ1ZWNnUlJLVWU4?=
 =?utf-8?B?S29uMUI4Z1ZHT0FEaDdxOENHTVpwOEc5U28zaTRZTUY1ZzQ0OStNNWloY3dQ?=
 =?utf-8?B?OFM5dGtzQ2IvZEJNekJQanZDTXZ4QnowSWlPb2gvajNYdW1jN28zYXN0emQ3?=
 =?utf-8?B?NVlqQ1hHUGZZSWJzOGNrU1lNdVIwYWkwKzE2dmxGUzkvdW5nb0lSenhxNG1Q?=
 =?utf-8?B?NWZyczlta0IyYXUrSFBtNytVQmxDaVpmNGFnZEd0N0p2RnJKbmtscno0ODNO?=
 =?utf-8?B?OG5VVEFDRndMZ1ZCT1Z2QnZKR0pPby9jYUg5WDl6dTNYKytUaDY3NGE2NTZh?=
 =?utf-8?B?bS9IeWJwNHBLTHVSMWt1dlE5SHJLZW9PNE1SQ0tINWUzQnpjY2dJSE5tb2JQ?=
 =?utf-8?B?K0RuWlVCZithejdOUlBSNVdtQk1yY2ZqMnh1MmVLc01pUldHMXFvM3c3ZkIz?=
 =?utf-8?B?T0lFVnVtOGkzNnVMOTBxZGVYUzZkK2pBdEJFeko2eEJFbS9zaWxXQVJLR0xN?=
 =?utf-8?B?ODdKdzVJcEdjV1ZtVDk5eEF2L3ZjN1NheEhlVUR3aThmNHlBZ2ErV3p1dEZr?=
 =?utf-8?B?RW9abXhCem85NjczRW9YcUZmb3VCOVM1RWpDK1BRVmxicStEK3JhSWJkM2hS?=
 =?utf-8?B?R1h5R2pma0Z5ZkZjbm9JM3RubU9sODFXWktmb1RpWjRFUkp2NGhzYUJERXlq?=
 =?utf-8?B?OHJFdlRybVdkZTEvYUw2V0U5OVhXRGpYTmNqbnh1QzZXYU5pZ0pQUXlETDM1?=
 =?utf-8?B?UDhqUUY5cUJkdFFrTjl1UkUyYkd1ZzFXZzVoci82OWZLTWJKMnlPQW4zai9v?=
 =?utf-8?B?SHZvWENrQXpCbUxTRHl5cGJWaWZjV2w0aWtmaHRyK3dXN0RnYUJEQUZnNS9T?=
 =?utf-8?B?ZDNpMUU1V3pFaFpwR2VJbzE0cVppWkU5d0VNRkhsTGFSNXBLbkptcUFla3FF?=
 =?utf-8?B?TkVtNXdYK2lEQ2VDdE5iK29GaHlJWk5sQ0tXOUdNOGYvbzl6UjhRcysxQmxM?=
 =?utf-8?B?VVo3UFAva0xBQSt6TGkwbDQ1NTFqeE9tWXhuNnNwR1phVlB5QzlQZHhqQjNy?=
 =?utf-8?B?bXRSVGd1dEdLdW9laHZ6YWVpMFB2c2VGdGM4cFI1bVMweUhtOEZmbFkyZy83?=
 =?utf-8?B?eUtiZUtwNlNoWmx5bU4zNDVvZlBkQVpLd3Q1c2UvemtBUGlla1lTckZkY1ZL?=
 =?utf-8?B?NWRYTm1UUDF3eFJCdVBBSTBMeGJ4RU9tVjZjZkwvSG9td05lWWZNaC9yeWRj?=
 =?utf-8?B?WTN3ZmhBR0FNS3phN0ZvS3RyRHZjNGN3ZW02UUtXOVRacStrRkJoNDhsbHNG?=
 =?utf-8?B?UUNEVzQvYVE5THNwQUIzcFhweVBXd241U0ZucHJLTVZ4eWZRSzJ4UXl6MFZL?=
 =?utf-8?B?VkcySzBvR00rU205V2o1WThlMW1NcHhZbFlLbmtPUGw3azFBNzJtQVRrcXMy?=
 =?utf-8?Q?dgRUX1dbAN447XLzBHxCqDaxp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bLk2q1l2t3kIPPU4rwcp+xv9c4CodhJjXNCDvwS+xJ9y6PYvq9KYLlkTeGf9Lyydt+EnnxKEyIh50sWvk5ietomDaovDMwa+LQQVm9UezgmpdlytCo/r3s3MhEU+gGMRck0f/wuxA2zMp3Tc5xi9J6RE7ZvTaIY6i0Kx5aZP52olsqtOxVUdzQQL6sKHLIJSyiosRfomnglyFvpLIEEZQq+goTBKmV7rYjULIeZiX0DYHWbhrrOnyMQkAveysk8AU45GmKMuL+DYXVw+Ne3J5uL8iQtttQmdoyFKzMmMme9rwoYrSiEjCZangFS6HJ0vzNhtcVeHGMXP0SzKnRYwWrs34XehbwzXjFisv3WNLi5g+G5NijaFdpTnfhDa5bNsgqOQMF3I17cznK9IzEMZntgpQqk0PT+u5S4QBHneNoBKMr+CU2Db55IPyOE4qwpHr/xBQLuAv8NbsXWQtID//EvsXmRTiAhHwWCRuR0a/AI0OOpHihEvAP5lsrpDpuzkxrtHYyMzxsZGHhMPMlS86UgYYGQuS+Dz8ERDULkMecJ8gUD+n30jTXRiUjvVl3yscnGEXQelmYF0T4oyMLT7wyT22Dh+Y9cJdswgnHcy1+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b8dffc-b46b-4bcb-b92d-08dd3b904429
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 09:28:16.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CYo/y5eAZ1XdU29RQJc6oxs4sTjx3RSuBG5+sNiwSirDZzuYey2n1QUWLcNdfI438SORmN9MLwDhm1upPgULA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501230072
X-Proofpoint-ORIG-GUID: Ktr7KZPNlXFljKqXuBUC71sCUMGD1Wh3
X-Proofpoint-GUID: Ktr7KZPNlXFljKqXuBUC71sCUMGD1Wh3

On 22/01/2025 23:51, Dave Chinner wrote:
>> I did my own quick PoC to use CoW for misaligned blocks atomic writes
>> fallback.
>>
>> I am finding that the block allocator is often giving misaligned blocks wrt
>> atomic write length, like this:
> Of course - I'm pretty sure this needs force-align to ensure that
> the large allocated extent is aligned to file offset and hardware
> atomic write alignment constraints....
> 
>> Since we are not considering forcealign ATM, can we still consider some
>> other alignment hint to the block allocator? It could be similar to how
>> stripe alignment is handled.
> Perhaps we should finish off the the remaining bits needed to make
> force-align work everywhere before going any further?

forcealign implementation is just about finished from my PoV, but needs 
more review.

However, there has been push back on that feature - 
https://lore.kernel.org/linux-xfs/20240923120715.GA13585@lst.de/

So we will try this PoC for the unaligned software-emulated fallback, 
see how it looks - especially in terms of performance - and go from there.

> 
>> Some other thoughts:
>> - I am not sure what atomic write unit max we would now use.
> What statx exposes should be the size/alignment for hardware offload
> to take place (i.e. no change)

The user could get that from statx on the block device on which we are 
mounted, if that is not too inconvenient.

>, regardless of what the filesystem
> can do software offloads for. i.e. like statx->stx_blksize is the
> "preferred block size for efficient IO", the atomic write unit
> information is the "preferred atomic write size and alignment for
> efficient IO", not the maximum sizes supported...

It's already documented that an atomic write which exceeds the unit max 
will be rejected. I don't like the idea of relaxing the API to "an 
atomic which exceeds unit max may be rejected". Indeed, in that case, 
the user may still want to know the non-optimal unit max.

> 
>> - Anything written back with CoW/exchange range will need FUA to ensure that
>> the write is fully persisted.
> I don't think so. The journal commit for the exchange range
> operation will issue a cache flush before the journal IO is
> submitted. that will make the new data stable before the first
> xchgrange transaction becomes stable.
> 
> Hence we get the correct data/metadata ordering on stable storage
> simply by doing the exchange-range operation at data IO completion.
> This the same data/metadata ordering semantics that unwritten extent
> conversion is based on....

I am not sure if we will use exchange range, but we need such behavior 
(in terms of persistence) described for whatever we do.

Thanks,
John


