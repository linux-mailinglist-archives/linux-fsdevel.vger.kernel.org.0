Return-Path: <linux-fsdevel+bounces-44699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2FEA6B8DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB693B4FB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 10:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B9921B9E3;
	Fri, 21 Mar 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jeFA3iC3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mIQ229Mm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7B215770;
	Fri, 21 Mar 2025 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553405; cv=fail; b=qkWNiqLKHJXM2J/B6sIAOkt6jKLD7IAbvcORGCPn00IAb1gcWoRUEbRYpGqoycy5L5EUEryfiu6xFvSYw/CTDjZKNnFa1ZCu1HvwqwTZkEOC9TPfFNcUzJuhBI5dXa+kTq4ozrOcjSD3yHxuOsj7+2U3QKcITdR629pRi9nA66o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553405; c=relaxed/simple;
	bh=4kcXgmh69YOEdDy9DBq1EaFjzfepgxf3+styvYXW6zw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KaSt1FOMvcpkC80/8zwrvYzXW98Ef17BP94OGkBPG2+BR08hfKpwxt+1mQTpkac55FhpNi5OY4SfZypsPm70ggRHSvCcX8+zbkGvrPc/l5RIwpvLIZKZJ3mTrbRXXMeIzw2Tc4SwKtNU6zPyJf7uswB+/a/TgVn+0DwO0ap6zvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jeFA3iC3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mIQ229Mm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4uCal031931;
	Fri, 21 Mar 2025 10:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=svu+y+T3fM1vb0HwASE1BRtFPrfWg1fotsbH3M+kYaQ=; b=
	jeFA3iC3k+Wdu1fl/J8GnWqAU3Iqm0CKmbQxwZu/4hVlTs4DPe3MZKO8sqE+unBJ
	kQ2HkAPiTFj8t763N8rDoGO1KoSRgBPepPc7oDLzArQle3m2o/BdujxUbUKHOLln
	mHBQsS8Gi9OARGuP+hBbAPhZZELCb1Vtt8thgTNVq8RgpAySWOy//GM/gJ2OSBL9
	WwWBg0Q2A8TrNT8fhMLGhKMj11hV6q7tjN/HI09FTJ3DqK5NlzEzeQFSBGeK9XHS
	XF8pfp0Ll1fnWsuBYPh+kCSwKnVll//jUZC5pmmkkF45UH+b/oOul21q58g6QpJa
	vte9tcn69Ek4WPNUssD4fA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hg855r-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 10:36:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7xUJd008851;
	Fri, 21 Mar 2025 10:20:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm3wgcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 10:20:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tN7e9NY0r6JEbRKqJ3qvr+wgLueGHxmEDDDzT3b9WvfVEcwOO3UhKC7XXqrgDR+Dlyd2qOYAsXh9gcrc5kadcUrARxI3AGU+QFGvIH2GwBOw2emifQfrP2mgWhtAXd54PFNx+QHEOSohVO1hB146PBAmxG8tv7jRETQ00/7QsKkPeRe6bORwHagMwCy0Oj4MUgGv0Ecfxs/IFRDVWHuu3kGce4O8iPgmX6b1w7BNPqUPcuYZoJiaojLMPWJOwy/WiqaVWnHcgAaonBSMIlletxWN/TiQzzREgr/5aYgeSFEmhtyXsmzrR4KqvBD/T9oIdLerq4obVgSLywvj0ggh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svu+y+T3fM1vb0HwASE1BRtFPrfWg1fotsbH3M+kYaQ=;
 b=fWjOewpc0ODAamkCxZAC1xE1BBzUKI9LyR3wxDh8K4iJwxppdWAV3xtbFVlcrzsYWkldL6KskuwXpKXNWrVOLoKpKXJw3ixnxe95T0Wu+66xQ4XI5Nk4T41H6wknC8nwSQoS3Z2MBXDDUwZYq/laOaEzYbOyYkqis2MVRvsYzsVMfi/WCE/sDwYaVc5lho4zbwtqHiI0hceLZt3gRradeQjwMRfbtsW4g8cqovW4nIGnzH8TdtBuApz4ZP+UZY2ThUJjL4qdNhpi7sIx0WFexiCuw8544Dg7SK3bgF3a2TF4ja6StL1i/IQed96qL7G52lsPm8EfnjGFaYV9W1MEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svu+y+T3fM1vb0HwASE1BRtFPrfWg1fotsbH3M+kYaQ=;
 b=mIQ229Mmu5WLr2+c9aJ7KCb5zR9emwPQAAj7dVj2VPuvMNTe67BsJsz251DoAxNXcQM8qMN4mPa+AcuDfOgm3iicD4jtPIi9Of30ZK74aYjVi0Ct6YqwufYEvmBzbPrDW3rKlHfmOXfKUXjFTbu1nEmMerJtstWpdEm3L6YsHnE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7989.namprd10.prod.outlook.com (2603:10b6:408:203::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 10:20:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 10:20:25 +0000
Message-ID: <7311545c-e169-4875-bc6c-97446eea2c45@oracle.com>
Date: Fri, 21 Mar 2025 10:20:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] statx.2: Add stx_atomic_write_unit_max_opt
To: Christoph Hellwig <hch@lst.de>
Cc: alx@kernel.org, brauner@kernel.org, djwong@kernel.org, dchinner@redhat.com,
        linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com
References: <20250319114402.3757248-1-john.g.garry@oracle.com>
 <20250320070048.GA14099@lst.de>
 <c656fa4d-eb76-4caa-8a71-a8d8a2ba6206@oracle.com>
 <20250320141200.GC10939@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250320141200.GC10939@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: c4309628-9bbf-494f-74e6-08dd6861fed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0V2ZUMzbUhTSjFHVXAzeXB3c050eWo2WGczRThmYzVOOU1pdkZscFc2bkVK?=
 =?utf-8?B?Z01MK1FkdVhBVWFPbk80ckczWXRVaHhhbE90cXkwSXVKR2JTWlB6aTRsbHJH?=
 =?utf-8?B?T1NRVml3U0RzUHNVYitIOTJFQ0Q5SlRBR2ZBQzB6ZzZ2dW0xM3V2NVZveG42?=
 =?utf-8?B?emE5Q2l2cXBiOFVSdlpvQXJ6RXorRGt6UmZGTXBkWWxqY2JKRnMxbkFvL3F1?=
 =?utf-8?B?VXMxNnNCOHR2SU9QajNrU2Y2VFBzbFc3bzJNOC82NFgwbXNxYXpxdnFDMWRB?=
 =?utf-8?B?TzkyanJPa0JBbXVHempjWlZhaUpicHI0YzJYN2lIcmdqY2pDTUExcTNTS1lT?=
 =?utf-8?B?N2ZOd0o4L0tyRkVLUklUamxzVFhZY1BrSkJaQjJFTDZsa1BkbXNOM2h6SnhK?=
 =?utf-8?B?RXR2d3h2bENFZDJsVHNGcVF5Z2c1MDNyQjJMMXJ1UlZDU3B4Sm5YSUdCbTgr?=
 =?utf-8?B?MTNCVFdIS0x4N1BRZWtCZjlJN3UwbzNBRkRVOC9MSGhhYmlaSEVYTm80enJH?=
 =?utf-8?B?RlZISnROWEE0SlJpVjE4VStIajhaUzZ1L1dQcUhkS2lyaU82b0RiOHY2c092?=
 =?utf-8?B?NjUrcHpQVW9lb0FVVytKK243WU0xOWxYNGd6c3c1RlljdlZGVmd0VjNzUVhj?=
 =?utf-8?B?dnJWaU12RzVaOGlwd3Z4Rzl5TEthdlpiMVhZVW04eFJYZmNXUXgrTC92UkYz?=
 =?utf-8?B?bkpaR1Z2bGV6aVdBM0NOeFRjc1NGeWVhSGNwK2dGM1ZIdzg3QThIWDkydWo4?=
 =?utf-8?B?c0FpWUJWZytxVjNwYlZmRnBrUjcvZU9NeTdxcitXN214cnF5TGFvbm1ZdVVh?=
 =?utf-8?B?MlRpNzFYSEpONC8vSk5xdUU4ZnJuN3QyMmlSc3VGRmNpSUY4WU9EZ3dERTFh?=
 =?utf-8?B?Rm1iZWpTMjhSNEdvMDk5Zk5PY0IxMmo5UVVTdTJHbHpEWmNTOGtyNUJUVGNz?=
 =?utf-8?B?Sm1PSElrMTl4WmZoRlE5QkdyR0p4clNzdTYreGhxTURPV0U0cDFRQ0pxRXht?=
 =?utf-8?B?d2hIektTdXB1c3pyUklBV2k2eWI4Z3c5SXA4S2NLQjI0U0s1Ky9BNm5SZnMz?=
 =?utf-8?B?UnpoaW9XQmEvYkhrYmhiN3JyZlFuWStzQVBqQU9aZytSOFdxblNmUXErR0dW?=
 =?utf-8?B?c09YSVpCcEtsU3lSRGVkMWJNczlGU2IrTjBoeWFGVWNJK3IzcnExbHRMS3NC?=
 =?utf-8?B?REx5QVF4WTBZZ0d5TEtpbHZHT0pzUjF3N2FUZzVnQ052aG9CZVdMZFBYaUpN?=
 =?utf-8?B?MmJNU1dDZ2FyM0x2YWlIQUdXY21kaTdoQTNmbitXWHI3MEdFOG02U1g4REov?=
 =?utf-8?B?M3A3M0dGTWcrT2FSSkplbmh2RDlrWGQ0TjVWQ3ZsS2daR2VEOTZqaExVRU9G?=
 =?utf-8?B?R2dYM3BTeXlTQVUwbHFmZ3dvMXNIQXA5dVdsYVMvaTVCcDBiTTdDclRqeDJB?=
 =?utf-8?B?QlFuYWJvRmo4YUpVZmFDZFMxNm9vSkxMTmQvTEtHY1ErMTRhVThqNzNmUFJz?=
 =?utf-8?B?UkZUaTNNVWpLZ3hxcksrMFgyRytNNXNORUlhbGI4MzlmaGRJYng3ZUcreDAw?=
 =?utf-8?B?N0xaWGt4eGlhVW9leTQ3eG5vUlh4Q3lVR2pJalpkMG9oL1BycjFQOXVtTFlF?=
 =?utf-8?B?NUJtc2pVamIyaGs4R2R2aUVYRFdmL1prNFRaM1VxblR2OTBvRllEWUJILzZR?=
 =?utf-8?B?RHVhUWhKRXVkUld2NW1VdzIyb0NOTG1CemdDTWlTejF6WFNKcnpUNmJXbzFU?=
 =?utf-8?B?ajJoYXJnZVl5Yk9mNnFKcWVPaGc1WjhFNWxLT1BDM1RjZk9Dc2lSL0pkUjF4?=
 =?utf-8?B?REJLWFhSK2QrTDZIUlRxQjRteDE1cVJIcDBPTTFtL1dlU3dLbGhxVjJzVjY4?=
 =?utf-8?Q?cku+8fjWQWHts?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0NjNjk2UGRtcmIrRzVjNHNVTE9SckJhS1FuZmVoZUdacVZMRHRUMUpPOGxV?=
 =?utf-8?B?UXNvdHY3R2ozUDdrNy9nNkpKWTdncThiOFVIVFFWOXpNM1J5ZDRGYUg2QVBU?=
 =?utf-8?B?UkQrek5XcmdwN013K1FXTHZNK1N6Q3NFN3BDVlZtWm85ZEE3b2RUd1pFeGRJ?=
 =?utf-8?B?UTBvSi9EdTJKcTBac1FnQ0ErOEtUOXI1WmgrNkxaTUJPckhibmVJR3p1THg0?=
 =?utf-8?B?a3JkZ2tvNUNXblcrcnJNQmFQcXhsWGQ1d2s3Y3FCVEY0QTFJRHhyQ0prcWUx?=
 =?utf-8?B?RzBKOUdPYjI3VEJZbnVvbmhQTVgxZzBjcXVYU2IxRHpHeFlZRjFRdENyb2tQ?=
 =?utf-8?B?dnZOcEpDcWkrMmZtMmsybHFVdDRaK2ZDRk1hdWlXbW5OVGxIcWhqTDAzV3cz?=
 =?utf-8?B?RU9NS0lvZENPN1haVS9GRHlzdHdLS2JvMzYrL25aM0F2N1JJcUxRSXQ5S0Z6?=
 =?utf-8?B?WWF0aFpBS1V3YXNGUG0xTCtTMEhFUjhNUFJib3ZqRTNlTGwra2JGSFlZcjla?=
 =?utf-8?B?QzhhWXprNmhndnY5ZUY0SjZxVlNFK2RkTkYrclZPMUJqYUtVd1NFZkF0aXBQ?=
 =?utf-8?B?ODJVdnNYY3gxNElwWWpiY0g4aUladFRoME1XMm16aXFMUWdtT0FLa0x5RDNF?=
 =?utf-8?B?QTRKQTRicGZTbnpkY01NTTJEU2NoR1VIenNpdVllWHdYVGhiMUYyZXVzQ2d6?=
 =?utf-8?B?ZUltSlVBVW5TZDRDZ1k2MVFrZHN2cEIrQmhLTlNoL0E1SFZRRGRsT296WVNk?=
 =?utf-8?B?cUMxVU9RUHM5cVpQK2xZMzd1Y29CODkrZWxOTURNNFNMVjRPbFlTeDVPV0JY?=
 =?utf-8?B?M3RpMGhrNXk1c3YxTVBJVmdLYjFnY1JIVjYxdEZPelJ1ZVhLWUl6Z0tjNlFY?=
 =?utf-8?B?NUhyL1RmTU04Vm5ZWHRtdnAxU1d2aFJBQWN6THhwK2FxbXFVS2pyRlZDRzlX?=
 =?utf-8?B?Q2JxNFErdG9CWVVIcCt1TE4vUURVMmVtdlBSZmtIbEVxS2VqQkwyVndVUGIx?=
 =?utf-8?B?RCsvNlJNbzMzbnBhaGVlM05OZXViVkVPK0Q3SjhQV0psUHFZeUhHQXE3V2Nq?=
 =?utf-8?B?TkY3aG04elp3S3FIQXdDOWQ1SFJrQmgxRkpJcGdodE0zcUxCVTh2Z0RaOWxU?=
 =?utf-8?B?REZJY2VJSEZucnFEd3dtZlNDbG5vakNmYjloZ1NpSnZnWkhFdFU1aStUT0Fo?=
 =?utf-8?B?K3BFQTVxNjR0cW1kKzBsYWZLdlkwYUN2cU1TS0dubVJJZkxlWGhRajhSa0hD?=
 =?utf-8?B?aWdYWFdmQ1RMdHhtV1FCanA4QXk3OWVnbjVLSGtJWGZIK3BYeVE4emdUcUJS?=
 =?utf-8?B?TmZoYkNPZ09uSTJwQk1sLzFnL2R5akVSYUdFMEVwWFlza0hoT2lyTjdESzhl?=
 =?utf-8?B?a01xWWNSSFRlZy9KMWdGSEQrSFoxaEsrSndtNDZrSHkzb1JWWjRzRDU2a0VH?=
 =?utf-8?B?a1hBUmk5YzZDMjdwSS9zOW5Zejc5S09OOWJtWHVXVXdXczBGVnR0ak0xQ0xP?=
 =?utf-8?B?RmdlQXhHVFI1ZEViM2hZUUZ2eWcxSExzTmtCbmlrY2gwYkh4UTk2Zlh3NGhz?=
 =?utf-8?B?MmR2Njc2ZG1neXhtbHhrcXhOQUNTZVZDMkpmeStVR3hxd0RYVjF0Y2FSK1Zh?=
 =?utf-8?B?b2toYklKdW9vZ0dNVC9zM05vUENxMGtFVDlYYytRMnRGMmN1alFBRWJjZWpE?=
 =?utf-8?B?azhiOWNveW9SbzZaZm16VWtDK0hCd3JDQkZUY2xlTmI5VklNZm5qRE9CY1pX?=
 =?utf-8?B?ZEwyZmN4R25QcGVhMmVKdHNEYUlkQzgvb0JFL2Q2VDVkQ1dZSGFVZXo1N05x?=
 =?utf-8?B?RmxkWTJ0V3FLVmlUZFo1QUdGT0tUOUVlcmpUaEZpZnVQSGUxQjh2SFlnTGs4?=
 =?utf-8?B?VlpFV25vNkk1OU5pRStFMWFvcXRtV0ovc0V5ZzNWV0w2ZEM2aUQ5VWdOMGR4?=
 =?utf-8?B?M3diM3d3RWxnY0FqcEhOdExZSzJ4VXNRWTNlYlVDVFR3eWVxSjl0Yjc4NSsr?=
 =?utf-8?B?R282cFEyOWl2ZFZGYkR3ZUMwMGxHeXZia1J6a1FudTQ2MlNvNWtQdjJyaWRB?=
 =?utf-8?B?YnpiaXFPcFM1TjMzcWQ4aUpZUUlIWlpyaGUyMHFzVXhDeVBPUytTaEFZcXAr?=
 =?utf-8?B?UmNVTXl3MXNIQ01YNldNRktwWXNkeC9ObDhVYWl3Z3N3RElyRmtJVnlEZmlG?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+usqWIX+JJRKktT/j+4pbp9BA0r3XaegdKpLFGMlxXNc7fmCT7V8QKJehcqNCySpnGI4GHGo6Bwfgg20syIXrVm8OsQr5voOr0K+Seu4jvUhtpyRYyw87eFm+lFgC4pUIkfaFUb6GqX5gHriicUhKZkpQqkbMyWSZMmUud/d46Z36TAn+Id1xISwUHW6/X2zX0AKIoseMiIRYYw+CqCHcFJ67alrSf0ak8V31V5DkvYKVm3FpJA0h+u/mOPqBeQ+vIq1yyhCcikOf30cXigcn78qQ31yO/tv4QH7xFfpHuU2RJs9/S1mtSOvAMgy2nWWW4MB/QHwV9LHgvtC8v0xvLwhgwOujLZ0kSPIyIKtyNQ2c/QhwvBOMP9xdeXCxaMcr50V12dMy7UhFWQV+Vy75Pw4jZvQVAuvwnCtaqSdRKiR+zoOs7W1M4GbwNeIelU63cN1cBF+Y9rg33wG8hYYam3IHyNlknrH17VFGIHyRDn2Fpfz4oxJbaZA2nBB/Eh9tGmjjB4lZyg7DiLY3J60f7Z+cuUHApJpQ8o1bRKlNBcKajQHEDfy4qRX6xUJ2cmz55Hl+doNpCZzToyngKsVi0iH6dXC7GMrRUtZQNNb/KI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4309628-9bbf-494f-74e6-08dd6861fed2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:20:25.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhqPMHoLdFlE9LYbOuBlIfV9lGMKVaNIJMa05Eudtxfr3X3dzx6Z1SAi8AP5p+moF6X9pBmFVL8A3pwx/rV5wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210076
X-Proofpoint-GUID: vYsrYvKPGTXTwDuv8hGcZGgXmA-EUeRj
X-Proofpoint-ORIG-GUID: vYsrYvKPGTXTwDuv8hGcZGgXmA-EUeRj

On 20/03/2025 14:12, Christoph Hellwig wrote:
> On Thu, Mar 20, 2025 at 09:19:40AM +0000, John Garry wrote:
>> But is there value in reporting this limit? I am not sure. I am not sure
>> what the user would do with this info.
> 
> Align their data structures to it, e.g. size the log buffers to it.
> 

Sure, there may be a usecase there.

So far I am just considering the DB usecase, and they know the atomic 
write size which they want to do, i.e. their internal page size, and 
align to that. If that internal page size <= this opt limit, then good.

>> Maybe, for example, they want to write 1K consecutive 16K pages, each
>> atomically, and decide to do a big 16M atomic write but find that it is
>> slow as bdev atomic limit is < 16M.
>>
>> Maybe I should just update the documentation to mention that for XFS they
>> should check the mounted bdev atomic limits.
> 
> For something working on files having to figure out the underlying
> block device (which is non-trivial given the various methods of
> multi-device support) and then looking into block sysfs is a no-go.
> 
> So if we have any sort of use case for it we should expose the limit.
> 

Coming back to what was discussed about not adding a new flag to fetch 
this limit:

 > Does that actually work?  Can userspace assume all unknown statx
 > fields are padded to zero?

In cp_statx, we do pre-zero the statx structure. As such, the rule "if 
zero, just use hard limit unit max" seems to hold.

 > If so my dio read align change could have
 > done away with the extra flag.

Sounds like it. Maybe this practice is not preferred, i.e. changing what 
the request/result mask returns.

