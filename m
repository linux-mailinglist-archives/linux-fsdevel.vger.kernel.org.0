Return-Path: <linux-fsdevel+bounces-21113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C690D8FF26A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3710828C1DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480B1991D4;
	Thu,  6 Jun 2024 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WM5Dbaow";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qdODIdn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26B1991C8;
	Thu,  6 Jun 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690989; cv=fail; b=dRCVoGw77d9zSDlZHOepHxVxl6FYe1ixb2BGaJ3qcY8QwcYhwxNId06ONnVnkErrfMmT1oC/NZpfMWKbFKKSiDL+1AI4tnk3MPUJrg5lJGPjM87wCabVmDi7ew3DGQ+MFD42dAWRT7LcgyhAq9oUGeW25CQfA9U6HoZMUuMp8eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690989; c=relaxed/simple;
	bh=AaEjTAb6knx9oOW6umGDTy139Vc/KDs1apWj/2M0su0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fypGiX5PhOh9AS5eulFwQLOhAyWMCGnZgzbM16x0iaZtFhEV+wePgrTIqG0nF6KO2P6LVNrOLHDRwlbZeNscNFiX+e6ALCOPLB921IBOBCMqm6/MTSWmAAFpmD9YLnrK39Sy4Q2CoCsgiiEBWuuHpH16zwxhwWOsbpNStR5e2Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WM5Dbaow; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qdODIdn2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568idnD021457;
	Thu, 6 Jun 2024 16:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=EhHl7WUTelNCE8kcdE37+9HKWfT+fyCSmbgpF6b4KJo=;
 b=WM5DbaowuBoG4aECB303V/J755BOac+sORt42595QBFNL3PyL3jWORGkCbK8OEPbJZHO
 Df2X135hwjIUNoRmiGuxngkCT9Rhq708titkmbQhkxtOPVqcCbwpj7sFEgDGyjLTIk6h
 Trwq7X3BYAF0PYkXhnwBctyzg59pofhJOaBQfrTPgRsvaPrRpC3GWbYsUJU1cbh0esdL
 2Qkg68skgM311yV3cGHRlGdvK+nSjrX8rH0xMyD6X/S9uo0ylLGkuUmNLE5ywmkKf3By
 40gGOHI7kyljvgjZR8SrOja+tyUGpq4B7MLZDG5LVg8NqMuZhQ6NXDg/YP3Hb9V0aiyL 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn3wpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 16:22:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456FENTj024049;
	Thu, 6 Jun 2024 16:22:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr12ujn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 16:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtxdODA2jvSLivs0/3koyMtEv8oOT7lfg+oW3thzpG+fE5aOhzbTUiLIs65Uj+LFUo2nxPnWtx37qBmZJtgmEQ+i2nVtg+lytf9n2is6lII6TFq4MTD24NPZmqLArzAoknNjSvavdWXi3kK8/UdY6/Sn5VRiEJpq7JgP2UIfaCCsmTWto1KjCet1KymQ1rS2QyWAZsbcmFFWxShRZGnHzpOuMjhiRYKbnkly75hdzCLp49Hz56aWCsDNiQRGJmAh450nV5YmIIrJmGQIGBv74RAyM55S92Arvpzi6FwVNZ+Pij1mixNL/K2BoE1Zvxh2GC1McsWua45ES3ub159lXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhHl7WUTelNCE8kcdE37+9HKWfT+fyCSmbgpF6b4KJo=;
 b=Q2F7iKGr6FZU24GgQ/UBConA7KxnsbUhVqorOYE9KziR2cQlNpg/6DO+Q551Y3zvMk/SlYu7+g1WCpTtQGln5GClPEbIA0rkdY9HFKekHfRfPmx/yyrzAbtkE47KUO99wPkPM1FwXbSQhGrwDkVjY7OvryiGNo1tJ4KLO1ly4Sr+iL62vazb6AxyXTt/VyBP9BmlYQ5vm7QgfuAeUNtMuWrbigpK7tElB81DCIacXRGB133Gcgko1mUeOIMN81RvdW2me8v0yYVwp3xg2tereNSaJpqZx8p2agWMfIiD+cnJzYjD22hyfrUFi+AnR/KWlY2vKPiID6uETFSJZzSSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhHl7WUTelNCE8kcdE37+9HKWfT+fyCSmbgpF6b4KJo=;
 b=qdODIdn2WMUGN7tCW361Lueri0mBvjuc+yxk1x2GsmeOekvFRB5b7YfwPBAX5fjkmRQVlMwmG7gXVUHejTeUvy9ur9ZuyGqswSMbyI36bvMclnTzlC83fngu3438JtzPSwCo+uCcqkmV6y8XtFUU+S78JyU6H3pZn3DW492EjEM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6100.namprd10.prod.outlook.com (2603:10b6:208:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Thu, 6 Jun
 2024 16:22:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.032; Thu, 6 Jun 2024
 16:22:25 +0000
Message-ID: <bcc35a78-9446-48e4-b1ce-0f11972bd19d@oracle.com>
Date: Thu, 6 Jun 2024 17:22:19 +0100
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 07/21] fs: xfs: align args->minlen for forced
 allocation alignment
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        Dave Chinner <dchinner@redhat.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-8-john.g.garry@oracle.com>
 <c9ac2f74-73f9-4eb5-819e-98a34dfb6b23@oracle.com>
 <ZmF3h2ObrJ5hNADp@dread.disaster.area>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZmF3h2ObrJ5hNADp@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0491.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: b024c6ae-7d12-4e46-6b0a-08dc8644d9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SFp1Kzd5SmEwVWJYT0ZlcE5YRGRxbmI4dmQ1SnVPTDJ2aGZua3p2b0VlWnpi?=
 =?utf-8?B?R2RwYnNMS2xMMEloSEFsWVBwZCtHWTI3dXF2cExza25IZGtIRW9nN0JwVm1n?=
 =?utf-8?B?dk1HNU9VQVJCUkdRamVHbzc0b1J6bmNmTHZNeVk5aEVURXZjNDlVNjJNSmlZ?=
 =?utf-8?B?MXByb3o2UldWbDJyVnBLd01hWHdBY0cvbXV6ODhrQXZ2dWp2Tno3UUlzVjZQ?=
 =?utf-8?B?OC9EbkhvZU9VZ1lib0V3ZHg0akdHZWJaNU1pdFovNzZ0SmtOQjJwc2lsOFFi?=
 =?utf-8?B?cGtPS3M2aE1jODRMd0FTWEZHWk5oMXB0c0FJcm13amtwQUVINUdCYjRBUjNi?=
 =?utf-8?B?RGlrY2hrb1I5Y0FMU1F2SFpaMDZ0NjdSUFc4TGpFSFgzMkxwSk1BakZwOW1l?=
 =?utf-8?B?RTJPMzJZQTNsajFSSktUL2xhaHg5WDBDUVVaTG1pQWFuVjRNOXJNRnM4WkZl?=
 =?utf-8?B?ck10TlFwbWs3MmdQeG1pbDNpazlMdEZ5S1pQcGw4MlFBUmNvcll1M212RmpO?=
 =?utf-8?B?SjRuM2RKQVZGY3JVNUNFZngvYkRGcXVCTDV4MjRqN0J0K2drbUhvOVVHeHp6?=
 =?utf-8?B?UGU2d01NeVJxZVFBRVhJelZmWi9CS2dnem1zMCtQdGxUYjhWNFRZUFFpUmxL?=
 =?utf-8?B?RmNOUmlyM3RwOWtnVERDN1NTOXRKc1BSYXIzcExpWUtaeXVlMENQM28va1NO?=
 =?utf-8?B?Wm9uOXI5TjFJMXVmdEhhY3lQL1hkWmNoazNPNVpJRG12RHg0UlZTUkRRbHB4?=
 =?utf-8?B?c1hPNFloeWF6bCtjRHkwL2R4SHFJYWxBODhaSzVGRUxTdTRoVDl5R0tlWENo?=
 =?utf-8?B?YlA2cFB1ZHFERWt6RHc1V3V6UDBkR3dDK1EwQ0VaOTF5R0YrRHlYVkdQR2Rv?=
 =?utf-8?B?WURjVjlLZk1DUmhFcmJ5cFpja3hmalJGMlQxbDZSaVJ4RENUTEs1RW9pYW9G?=
 =?utf-8?B?TkJ3aUduY3cyaHNISEdVd1B2Ymh3cVJPaHJkajEwQVZ3SSt2V2VZeUVISGRD?=
 =?utf-8?B?ZFNHRmh0SU5XRG1YbmpreEQzeE1pL2RLQUxTWlNqb0FMaGdNdGZkZENGTEhv?=
 =?utf-8?B?OUdrak5Ga0h6U2VveHB4UUcvdE1SUVhteDk3aHBiYzN2d1o0YXMxSnZtdmc1?=
 =?utf-8?B?bTR3V2tZM0pwdWVxcnVYVW9qazN5MEFUelNNeStHOEIrcXJmNFFXYkdaNG5I?=
 =?utf-8?B?SWtZd1hHYktKWVk1MWx1bzNtNXdqRU13cEVid2VxZGZCRU5ib0h0TzJod0FR?=
 =?utf-8?B?RWp2MFBLQU5aSGQrVFRZZzZlek8xVkZ5eDFPaE9xc3BrQVRoZ3lxdEFWQm9V?=
 =?utf-8?B?cFlMd0E1a0krQnFuRkF1RjdPTWwxYk81blZLdDJuTTZFRTFzVE9uSE5wamxI?=
 =?utf-8?B?cGdCQ2JXM3puMitvMXdwVm41dXRrcGRyTGZSajd4bDlEQUw2Mkp3Q2hwMk0x?=
 =?utf-8?B?VmIyYWZBWFNGajFXV3lBM1NuczlyR0N6MnZtSkR6aUp5MHRCdjlrZU5seFRP?=
 =?utf-8?B?ZGFNR0FPQXFQWDBvbVBhbFAzdVRsbUtnN0lzb0ZWWDA5WEpMTzdVMi9EZFJN?=
 =?utf-8?B?Y2RyR1pLNkc0emNROGhsTk1ST1ZKdUZocXVuUW12ZFJTeTNoTDQrbkFPVlY5?=
 =?utf-8?B?eWxWc3RpU0xZVUloaUEyVGY2TGc2SVlsaktlZ0RPZzFwSk5mckUweGlrMlJx?=
 =?utf-8?B?aVFFZUJ2ejRJNmUzNDloeE9oWis0a3QyVlZHYWRWUjRFTCtlQkJ1d1NSZXNt?=
 =?utf-8?Q?QDhpCL3CjX+chvoq5OyrqPDWdZCaKtTBqlvf+Pm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnlWWURocUJEQjVJVWNwdmRBK245b2I1ZjdkdXkwUURBOEtIYUtkS0lkVEYx?=
 =?utf-8?B?c2xCSWYwcmVXZHNmOUVKbTdjb0pDS0lycmhnZzN5bzZ4a3pwdk9kTTV2TVgw?=
 =?utf-8?B?Q3ltTVh2c1FJQ0VDc3AxcmZmZEVSblRZbUpoaXNWREJoQUZRUzYxdk5rSWpE?=
 =?utf-8?B?UXVTRGE5U1Y2VEQ4cFpEckEwTmhTYlpmMUwvbUhYV2duZXdob2haNmFzZlpy?=
 =?utf-8?B?bVdadGxreHBqZGJUVmpURmdidU1DSVk2cEFpblptTXhHbjVwVEZncldOTnNJ?=
 =?utf-8?B?d2ZTOUZZdnluYTNQYTZianQvRnFRaXJPODR4TVdDN01JdmxCdGNoVHh3TzVo?=
 =?utf-8?B?TkowcG92SmJnUGdmQWNUWHI5VXhzOVNHc1ZiVkRubUtKOWlqOEllSWd0MmNM?=
 =?utf-8?B?VzB5Z2RYbEJCS3hBMFAxRUIxMC83MitvV25GMUdjelNMbVA1cUxKbHBqelV0?=
 =?utf-8?B?dU1sRllScExxUUZMeTlPSnByTmI5NVFhcCs2TWlkWVo5VHBvYWFZRTF1ZlNQ?=
 =?utf-8?B?WVBwenU3blR1Ti9Yb1l4TmZ4b09rRXFWcVJmZ1RvSjN0STVtLzYzZHBGeVo0?=
 =?utf-8?B?dGlwbTZwUDNtNzFodFhheldKcGF4SVdLcEgrTHVGL2ZvSWRIN25OaW5hQ0lQ?=
 =?utf-8?B?K2RGUys2azA3SXp3RUxjeGIyWGt1cWV1eWw4b3FkUWowc0pNMDZmREwvRmVO?=
 =?utf-8?B?MndHaUYzYTBodkNLcWVMcWhzRTE0L0JzZVA2Um1USGpycitEWFVGcURHcWxJ?=
 =?utf-8?B?UURYRU5rYUlaSkdiZFVOSkpDMlN0L1YrMng0ZXA3aDVCck5kTlVhNExJSHdw?=
 =?utf-8?B?YlBEb0UvYitsaU91dTBIQjYwcFdOUmZUZUMzSmRiMWV0ZEJLTzR2MDNrRmh5?=
 =?utf-8?B?T001VW1QUTl4elV0QURkRTY0cTFWRHJtSm9tLzRpUWVPcHRXZ1RadmhBRVdp?=
 =?utf-8?B?dFlveG9la09jZEZKN3diYW5tUXgxNnVYeW5Pa3VpNjhycDBWSkJESUdiUElM?=
 =?utf-8?B?bGlReFFLQUNjR29uQ01VbEcrVmZQUU5ObUZJQ1VPYlN3RUpYdzhWVWNHMG9Q?=
 =?utf-8?B?RWVJTXluaTdXdWMvUTJzbUJ1TjFBMFZTV0prMU5hRlJQdkltR2ppeWtScjNv?=
 =?utf-8?B?RGx6MXZqTFBob0VBYXRyVjdWUHh0UlcycnN1SVhVWWFLbDhXaTZKazNqSW5i?=
 =?utf-8?B?NlhUWjltMHp0dDVIMFlQRi9YQW42TU1aYzd6MGh4ajdjVWI5TEFBYy9NU01E?=
 =?utf-8?B?a1lBNm40a1QvRVRoc08wZStzUHRaVjFLcnB3eDZMWWtwQTd4alhKTm1XWm1x?=
 =?utf-8?B?VUhCc3ZLWFZpZ0luU0lEM3FrYnlRZU13TVJEQ093MmtIN3UvL09xV1RhQTV2?=
 =?utf-8?B?WVVuRFVjK3JuRHFLZUxVOWMrZ2d5UWFXeU8yQW93Ti9QVUU4eFh5bnNvMnA3?=
 =?utf-8?B?cUE5TFR6VGJqQjRuMVZxMlhtbmJidm5obVFGSGlSOE1zeFp3T3JpU2RPSTNu?=
 =?utf-8?B?TDdTOGRkckdhU0VseWF6N2txSUtLb1JBS09FZDFaMlptQ2grQTlPOC9DdTZ0?=
 =?utf-8?B?UkEvRVc1QzI1S1B0dVhtVGFyWFQ0VXlWMVhZb1ErbTF1RHRJTlRtR2k0YWN0?=
 =?utf-8?B?Q1ovUURIQVh4VTVTVVdSaFpIaGdvSm1NY3ZEWXFKK0laaVhyc1F4eVpNZTlm?=
 =?utf-8?B?dnUrbkdSbk5tWlNUWTEveklaZkZuc2NyVFpZUHFBa0hJZHg1TjA2bmo0Tnhi?=
 =?utf-8?B?akxKTk5paFVpVVlGLzVBY0VBYTdSeFhVZkErMEMrWG5XQjJVK1g2ck5sQ1hX?=
 =?utf-8?B?MkF0VkxiSFc0WmYrUWpmN3p0WlRDMnd1MjJXcmRqTFRGZ2dsWXdsZlMxd3d4?=
 =?utf-8?B?K2ljZTVidGE3QXVFQ0l0TnpFZjllMEdrZmdEOW5WSW03M3pBZmZpeWNDZVgz?=
 =?utf-8?B?UlJveW52RURuSFgwdUhGWURLd3RNWlJUcmJFZDUyQjI5QVViT01tWGhVcWRu?=
 =?utf-8?B?Y00zVjdYNWc2MGY3ZGF3czNZTTFuMzVENGh3UUxWU3RNQ1l6akJwQzFOU1A2?=
 =?utf-8?B?dWFobDJqTlJKbjV3bzl3TzEvc2FiUWRTZkdld29zWlUvUFRIU0twK21sVThy?=
 =?utf-8?Q?9kEGZ+Y6hLh5Ic88VH7mPvTwq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZlJ/QdRdHz1PJMZNx2JULAVCdrjnzKbLSoS4SBOhw303jxBoNKcRsuswgmoIeaHMQJJJirq96oyThYhM+tCIKZqcHfKDfW/uNTtwNBbKwhPthykh9ZehmnK4zKUAV4vd4eCJL0SrlACm2e5sG0NyRwKI71lvYc708iIx6QSJ03QDpJHUMLrjLggWA8ARwLRTc+0pT0QAsRSIOEN+YiwzmiJtdSnvHpQkFyTR3g3rXIOF9HSQ+7njkXuvj1lr+m+D9MoKsGoJo/x7t2DlBL4ePx5ZIV7D3q1A2a8H7nGy//uXzgcAmfCZs7+QrzIj6sZ7E82K2U8ofB89mhVznxQ8OjiMufZ0xrANMGscpiRzJR3z41jAme5s1cp3W5/0o7W1/D1Ezv19yjtcjYIacesLwFY/52j5ofLqNLv959Zpl6XKEJrjtECbW0FyR1QJ3qewltw+e/Fl3mBVI8y5GpGmzEv+B0UrGcvakbz1wvdylZ8t9whMhFLkQc7OSsnt1kQdRXaey0ruV5Cs10saGAyzJX7h36vmMnSV82siI2+Z5vIl9PNYVdPirdFyBK87mFMbR0J9qaV61zqoOys9WbCxwNnRL11XeP3EKeAR7yMRT0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b024c6ae-7d12-4e46-6b0a-08dc8644d9d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:22:25.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oks/Rus/abovXUHfwXw8eV8g32mSLczVFnYXMq5eN1wbRHVmPylmvoY5Qdh4GZVk9dZDnuOVsIf7Mgt/K5L7RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_13,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060118
X-Proofpoint-ORIG-GUID: pCqnmOnRsNand8Lvls2NeTIRpxngNk5X
X-Proofpoint-GUID: pCqnmOnRsNand8Lvls2NeTIRpxngNk5X

On 06/06/2024 09:47, Dave Chinner wrote:
> On Wed, Jun 05, 2024 at 03:26:11PM +0100, John Garry wrote:
>> Hi Dave,
>>
>> I still think that there is a problem with this code or some other allocator
>> code which gives rise to unexpected -ENOSPC. I just highlight this code,
>> above, as I get an unexpected -ENOSPC failure here when the fs does have
>> many free (big enough) extents. I think that the problem may be elsewhere,
>> though.
>>
>> Initially we have a file like this:
>>
>>   EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>>     0: [0..127]:        62592..62719      0 (62592..62719)     128
>>     1: [128..895]:      hole                                   768
>>     2: [896..1023]:     63616..63743      0 (63616..63743)     128
>>     3: [1024..1151]:    64896..65023      0 (64896..65023)     128
>>     4: [1152..1279]:    65664..65791      0 (65664..65791)     128
>>     5: [1280..1407]:    68224..68351      0 (68224..68351)     128
>>     6: [1408..1535]:    76416..76543      0 (76416..76543)     128
>>     7: [1536..1791]:    62720..62975      0 (62720..62975)     256
>>     8: [1792..1919]:    60032..60159      0 (60032..60159)     128
>>     9: [1920..2047]:    63488..63615      0 (63488..63615)     128
>>    10: [2048..2303]:    63744..63999      0 (63744..63999)     256
>>
>> forcealign extsize is 16 4k fsb, so the layout looks ok.
>>
>> Then we truncate the file to 454 sectors (or 56.75 fsb). This gives:
>>
>> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>>     0: [0..127]:        62592..62719      0 (62592..62719)     128
>>     1: [128..455]:      hole                                   328
>>
>> We have 57 fsb.
>>
>> Then I attempt to write from byte offset 232448 (454 sector) and a get a
>> write failure in xfs_bmap_select_minlen() returning -ENOSPC; at that point
>> the file looks like this:
> 
> So you are doing an unaligned write of some size at EOF and EOF is
> not aligned to the extsize?

Correct

> 
>>   EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>>     0: [0..127]:        62592..62719      0 (62592..62719)     128
>>     1: [128..447]:      hole                                   320
>>     2: [448..575]:      62720..62847      0 (62720..62847)     128
>>
>> That hole in ext #1 is 40 fsb, and not aligned with forcealign granularity.
>> This means that ext #2 is misaligned wrt forcealign granularity.
> 
> OK, so the command to produce this would be something like this?
> 
> # xfs_io -fd -c "truncate 0" \
> 	-c "chattr +<forcealign>" -c "extsize 64k" \
> 	-c "pwrite 0 64k -b 64k" -c "pwrite 448k 64k -b 64k" \
> 	-c "bmap -vvp" \
> 	-c "truncate 227k" \
> 	-c "bmap -vvp" \
> 	-c "pwrite 227k 64k -b 64k" \
> 	-c "bmap -vvp" \
> 	/mnt/scratch/testfile

No, unfortunately not. Well maybe not on a clean filesystem. In my 
stress test, something else is causing this. Probably heavy fragmentation.

> 
>> This is strange.
>>
>> I notice that we when allocate ext #2, xfs_bmap_btalloc() returns
>> ap->blkno=7840, length=16, offset=56. I would expect offset % 16 == 0, which
>> it is not.
> 
> IOWs, the allocation was not correctly rounded down to an aligned
> start offset.  What were the initial parameters passed to this
> allocation?

For xfs_bmap_btalloc() entry,

ap->offset=48, length=32, blkno=0, total=0, minlen=1, minleft=1, eof=1, 
wasdel=0, aeof=0, conv=0, datatype=5, flags=0x8

> i.e. why didn't it round the start offset down to 48?
> Answering that question will tell you where the bug is.

After xfs_bmap_compute_alignments() -> xfs_bmap_extsize_align(), 
ap->offset=48 - that seems ok.

Maybe the problem is in xfs_bmap_process_allocated_extent(). For the 
problematic case when calling that function:

args->fsbno=7840 args->len=16 ap->offset=48 orig_offset=56 orig_length=24

So, as the comment reads there, we could not satisfy the original length 
request, so we move up the position of the extent.

I assume that we just don't want to do that for forcealign, correct?

> 
> Of course, if the allocation start is rounded down to 48, then
> the length should be rounded up to 32 to cover the entire range we
> are writing new data to.
> 
>> In the following sub-io block zeroing, I note that we zero the front padding
>> from pos=196608 (or fsb 48 or sector 384) for len=35840, and back padding
>> from pos=263680 for len=64000 (upto sector 640 or fsb 80). That seems wrong,
>> as we are zeroing data in the ext #1 hole, right?
> 
> The sub block zeroing is doing exactly the right thing - it is
> demonstrating the exact range that the force aligned allocation
> should have covered.

Agreed

> 
>> Now the actual -ENOSPC comes from xfs_bmap_btalloc() -> ... ->
>> xfs_bmap_select_minlen() with initially blen=32 args->alignment=16
>> ap->minlen=1 args->maxlen=8. There xfs_bmap_btalloc() has ap->length=8
>> initially. This may be just a symptom.
> 
> Yeah, now the allocator is trying to fix up the mess that the first unaligned
> allocation created, and it's tripping over ENOSPC because it's not
> allowed to do sub-extent size hint allocations when forced alignment
> is enabled....
> 
>> I guess that there is something wrong in the block allocator for ext #2. Any
>> idea where to check?
> 
> Start with tracing exactly what range iomap is requesting be
> allocated, and then follow that through into the allocator to work
> out why the offset being passed to the allocation never gets rounded
> down to be aligned. There's a mistake in the logic somewhere that is
> failing to apply the start alignment to the allocation request (i.e.
> the bug will be in the allocation setup code path. i.e. somewhere
> in the xfs_bmapi_write -> xfs_bmap_btalloc path *before* we get to
> the xfs_alloc_vextent...() calls.
> 
As above, the problem seems in the processing fix-up.

Thanks,
John


