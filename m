Return-Path: <linux-fsdevel+bounces-37481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565549F2DFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 11:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877DC1883BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BDE203D4A;
	Mon, 16 Dec 2024 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G/nnjO/A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M6kMJrcQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60A2036F3;
	Mon, 16 Dec 2024 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344055; cv=fail; b=AmE4gd46hYY7cEvobP9YGRWeU3ZZKElca1NBZ/rXeoA+ranwF2QC6Yunhq/bd3bU+XhdrmgsCMB7djK6ZM3ec5VGUuBXW5yUxXuhpeuzKMFBOYZy/Piw/ipn1SfcyGfAEx73VfXV4CxFt01i6IpOV+pM7yh8huym6Z5pRMJZugY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344055; c=relaxed/simple;
	bh=k1FCSzTxsMEbDrSUmthmdbHIJebgotb+IoDqiClKFII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j3yo+TPlAdFEqzIvWQR1dWXnCA5IYIDhKYw/vBJt3i7YtMqcBacsiXOFXVLjUHZQvWF5S2Su+uxqG/EKiPL5d8vOk05jljP1DfyohYK5D2OUrizxHUNU/NV8Lldr321hinYqzcATtZeY//bhuTxxb+KqI3x2Xq2INl1gChqsm6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G/nnjO/A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M6kMJrcQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MsTL027616;
	Mon, 16 Dec 2024 10:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4eqjJqB2ZYVprJP2XBn4HeVl/oRGNHXGl4Wfp/yUilo=; b=
	G/nnjO/AvXDYMgcAEOQsaRKjjwIG/axTU61bZzz+jztglhKZ/MVYpRKiHICvlyUg
	50UhI3iH1NGM6/ilaNsD3m9+Bvb7lpHIFts7omCV406pLthFLTaj8vhAJkEa9AfU
	UpQ3AFOZ9Drd15P0xq5Riq6hc/kM6xh+PUfZvNdNlLLpQntAcd97LS921xpTmhAU
	QnRr/uizZTPCKQQ7sPgI6MAHci4e3e8dOHibPP17CrgcUJlbZizcAE3+f8hVWUuF
	FRQ/7z4xc4/Rr1FnfHRF9uQZOjTAsOQXSYQrQqfuKe88i7AHHmAo5bBVRwPNs5N7
	3qvcz7rtkEOfpIJtQQHo+w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt2ujt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 10:13:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG8lfjq039261;
	Mon, 16 Dec 2024 10:13:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f735ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 10:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rt33pYLHYUULCsW+4lmGNcZtzKbYD7hnAh0T28LmaOIJSqmrU1USTJeM33Re1R0d3xtB9oZDNc6cuHiUUoePvfkN4+4s4H6z4Ilm2N9M/97LK4/UaYDDpulaVuq1Kn3jsnJq5K/xwBBm0OScAKWNki4iLFEMAvOJChzgT5ur6WwU0NI2KJeeQlLopM0JtVFtqgduRVewKLIybwnsi/2J6kTbhT6vRWAeAU+VIrgyZTip+mrtc1jjzbbTB8/WAwioFfqftwYEFx6d7M7tqc/zxH+rYam6PSkglZcJoIe/r78v39NEgUaTTEn34JB9hIMVPMp94ao5vt+1UjsPOlDMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eqjJqB2ZYVprJP2XBn4HeVl/oRGNHXGl4Wfp/yUilo=;
 b=B5WClGB3N0D31REFs5rc30BuIp+7stH7232ZHe2i4tyAiwngWkomOXmDkux/XFibMvc/eT+WHiUE8sgs/giyZDG3S7PJ+6VEP91ylqFmU+xIsMLG126PwZv5LMlP8ZEF9x7OxJB4dLkYqLRrlD6S87nYpEPMtkENtHiZq8+UMotdcNEGHJwBf+uYN+16wGqcnohjN1F1VzXdt0ycajlhQ/uQCBrra4w8f5CJJa3Oiip4CDw/XPKmsQADMiv4S3voiN4ZW9zw944nE4DcyE44+0q2lFqK+9edH5Ker741nnUHCqnJPfGRgDAaLFA4qp/fZ2kiVvIiPyzb1bPV9wNaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eqjJqB2ZYVprJP2XBn4HeVl/oRGNHXGl4Wfp/yUilo=;
 b=M6kMJrcQQRuWSvS8ziHFVlKPYstPMkiCI3sImrkMNNUhiXAMWpxfOk4Dao+sdMFRRmlVFJtFPkaqOlXStC5jpahfP/AhBQbzsKGN1jEhc/TiCCC6FkDjqwTDjlkltfpRb2Ksaf06xqAa2aViOJM3TDPboHRLcK8nn1dckYGXAig=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6396.namprd10.prod.outlook.com (2603:10b6:303:1e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 10:13:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 10:13:38 +0000
Message-ID: <f872429f-9c81-444b-a4ea-ecb5af495e51@oracle.com>
Date: Mon, 16 Dec 2024 10:13:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 09/11] block/bdev: lift block size restrictions and use
 common definition
To: Ming Lei <ming.lei@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
        hare@suse.de, dave@stgolabs.net, david@fromorbit.com,
        djwong@kernel.org, ritesh.list@gmail.com, kbusch@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-10-mcgrof@kernel.org>
 <9fadee49-b545-440e-b0c9-e552bec1f079@oracle.com>
 <CAFj5m9J0Lkr9hYx_3Vm2krC9Ja5+-xjmqkqjVjY0jvimjWbmTw@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAFj5m9J0Lkr9hYx_3Vm2krC9Ja5+-xjmqkqjVjY0jvimjWbmTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0351.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 3313cc8a-6655-4d2e-90d2-08dd1dba4f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3Vrc2MvN3Z3Zmk5ZTFtSlVEa0xBRXdYU1FxdFR0NjZkUHorbVNoZUVnUkly?=
 =?utf-8?B?UHNTQVp0S1c5WjUwVHNnTEluR1JOSWcyS1dJYzdydlhveVZnVTlicnM1bk1Y?=
 =?utf-8?B?bFJNbDlGV3N0OGI4YURLeGl6SmN5c0RBaW5EcUVsY0FOTzRzc0pUSktOWFM5?=
 =?utf-8?B?OEdWL25FZi9yOHdNbWE1TGhHaFpmSHFEakhrOUh6OXM2aTdoOENnY2JEZHMv?=
 =?utf-8?B?eWpick5jb1hPR3VPT040TUtnSzA5TlRqN3lud2xlZjRmeUdNdFhJamYvazlY?=
 =?utf-8?B?eFlZMjYyV0d0cXZNS0JrYXVLSnFvKzBzR3hsL1RrWHpFRjlxbTVIOHFLb3NH?=
 =?utf-8?B?M1ZpT0ZXdW9MaXVLdUVMZksySk5aNmNiOXoxQkVISWcvcmJGY3pHeXJmUkRT?=
 =?utf-8?B?TXJvTWs3bDExdy96aE51UmRQSXljTUhVNDFCTnZuZGJsVUNsUEFiV2h6T1JM?=
 =?utf-8?B?UUIrVlY4RlNrV0hnbXdabXQvNnBtaFBFSUk2TDdmQnN6ZC83bnVLT2NPV2tV?=
 =?utf-8?B?MEdQcndINFc2SFFwQzJxRDhQajUvWml2djJ3SUw0RWxIb1pGN3M0TFpxMEpi?=
 =?utf-8?B?Wk42Zm1iTnRjMkxaZEo2VGNPMEVRTW5sQzNVRjk2a3NsU2lQc0lvK05odGNi?=
 =?utf-8?B?dngxeWkwNzgzekUzQWloNzREanhUSi9RSUpPbG40YzI4NE5CNzFRT1hnNFhJ?=
 =?utf-8?B?b0s3L3hzWTd4TFptaWMwL1ptUTFaNmdWWHZpUGhYbTJkeFFFOUFia2FQYmYw?=
 =?utf-8?B?aDJ3U3BYc1ZaczcrTis2VFp6V01vaUFsWUVJZitzWkFMSG9KRCtXZ2E5VTdt?=
 =?utf-8?B?dUt1bDVqVjFYUkgvN1J4SnFMMHpZT3dvSVU2UzBoMFp1Wit2R25Eb3NDT0tU?=
 =?utf-8?B?L3dmeEdQYnlsUzBuZmM4R05WVkZFWjVDOE5WNUdSa3E3VDQzWjVPSDdZdVo1?=
 =?utf-8?B?WHovMTJxeWl3MHg0dkhrMlNteU9hN0tpU0NyNGxscXRRMkF6ZSt3a1daVlZS?=
 =?utf-8?B?MlZ5TmREalQ4Uko3U2RVcHlGaUkxZW1relArYi9teGd1Y0FaWFlCMHBwZFNv?=
 =?utf-8?B?d0pid1gxU0xPSXduSjJTZ0FBWlpwcHBOVUM2TzhucWdSQkoyQk51cExsU3Vi?=
 =?utf-8?B?Qk91ODhNVC93ajQxQUpXeVhyeHkzRjd6bmg0OHNzbG9oNHdXY1FQKzBoMER0?=
 =?utf-8?B?anVjQTJ3SVZ6VkV5c3dnL0Z5RWtSNEU3dzY4YU14RzZqUk10elNDeTl5QnNw?=
 =?utf-8?B?REx4UjdxTWQ3dnVsMjFIMnpCRVdqblJnTTc5Mi9WSE4xelkxeENuSndaajBi?=
 =?utf-8?B?U2RuS0ZIZEZjaDNxaTNJR1FDcmNadHB0SHdBb1Nqc0NJNVJQam0ramFmZEk5?=
 =?utf-8?B?QnhVZ0dkU2tHSmJqNUFvaGc4TWM0azkyNGpLRWZrRkpyNWNic1NTekdHT0NL?=
 =?utf-8?B?blhWRmF2cFZLS3E3dkdranNTSFo0MGZVNUkrcHRiNjVRKzBjdmN1MEpjdTZP?=
 =?utf-8?B?bHlVVktqSW1lQUVBU0hhRkkvRmFtNUFMMDZRTjRWVmtkeHAvT3JVNVV2aVhY?=
 =?utf-8?B?VXh1SFAvMUhYMGQ2T0JEN1dXd1VMWUlySnBSaC93QjhsZCtVdklPNU12Y2FM?=
 =?utf-8?B?SUtqWjFCWFlqVW42YzNrV0hEdUdNMkkwUWx2RmJVeTFRYm80eEhiSTk3dmF2?=
 =?utf-8?B?ZkpOdks4Z25MbFR6WXU0WDRNRkFGZmFvNWNzMEZBNkhzZ0Ewd0dRU3JHQ0FO?=
 =?utf-8?B?aG5hcUJ3Szc3cVpJaDJ0SFcyaDZVdFRyd21hSzZTVlBFQnJmK0VkWlZBOEFQ?=
 =?utf-8?B?WWVpeEIrQVFxT0I3enJsR2gxZTlvUDRHdFViT2hyN1JxWXcxQnVwMTgyampl?=
 =?utf-8?Q?bsXUE/bR6o8ng?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnNnNnd0dXgrNVZURk5leUNacVFXdEdFNW5YS21FNHlqa2N1SHZkeTE4dWtQ?=
 =?utf-8?B?UDlraVZlb0RoR3BrNjZTNlp4UzRKemNYZzFmNGJ0OUlKR3Fid0lTdUpaMlRr?=
 =?utf-8?B?d3N3TjNuUWM1NGNBc1JpNGp6SHR3Kzl6d05hZDFJWFlPcmRESkpoMC9SUUtG?=
 =?utf-8?B?eXIyeUZvVElIcmdkY1IyeWduVUxJaDRLZGFOMTdvSm5RTkxPcEJkWkllOU1K?=
 =?utf-8?B?ZUdjYXovcEdncTdVTFlYNks5UStrd0E3ZFM2THc5NTJpa01uV3YycGQ5bGln?=
 =?utf-8?B?d05kcjBqcElJVXlnMGtBU0xGMXVsVG5RcS9IS3c2SFppRk91WVc4c0xLbGZY?=
 =?utf-8?B?cHptWk9hNFFQb2I3RTg0T21DeEF1RmdqSUNrK1RNZkwyb1dFY1FUeEVRd1BW?=
 =?utf-8?B?Q2l6SFptTUwwQnMwNENLVkRMekJILy83bEFNWkpudWd6S3o3TjlWME5UZWFX?=
 =?utf-8?B?SU1vcUwzQW02cy9DWmpRd1M3dEMxQW9sOXYvVExuYk5adWY5SVNhUkdYbmds?=
 =?utf-8?B?WFhDVGY3aVVkczYvaHlrT1VHbUpuVVNHZHFEcXZkR0dFb0pJZ0czWk1JOEIx?=
 =?utf-8?B?ZWUvU3F3aElYTkFEeXhva0UvSWIwUkE2RjNSWXZFWHRJejZuYTZoY0MxNkQv?=
 =?utf-8?B?R29BSU1EWjJtZnVoODN6ZzltbEZVRWRhVFRZQnpucUxnVEliZVhkYWlDTlFB?=
 =?utf-8?B?c2R2VmRlVlVHMUwzM3VwckdWQ2tzWG01OGJaM0gzVDZjbCtUWG9NZ0ZBNEtz?=
 =?utf-8?B?eEc3d2ZpTHh5cm5LejNpanlMYlVoWW12eC9MWnZsanJOellGWlp4bVo2bDRm?=
 =?utf-8?B?OUpFL3RMY2hVRGE1VFBTaE4wZDVWSW9teU9CQUZLV2xwL09ZdHpyYUEzYlhl?=
 =?utf-8?B?ZE1IMHhxVTJWaEdiMG16M0FMSWhwajBhWm5ZS05IQ2tzYk1CV1dKemhkTHNk?=
 =?utf-8?B?SHdrTEZSVmZ6UUJkZnZXc1FXNUZWUGo4ZUtGZXpueDF6ajI2Y0IzTXh5Mnp3?=
 =?utf-8?B?aDZWenNpTW1RTlR2ZUNpelhteGZyU0lkOGxkUnd0N2l2Q2EwOU9IU1VRRnIr?=
 =?utf-8?B?aEdzSWgzT3BwTlhXL3Q0OGFqWU1BRXhuQ0J0Qm5yYnNXMGRKZk8xK3U2WEIz?=
 =?utf-8?B?azRNZ0dwdjRBaWVoaEg5Ym9TVWZXM3JJa21QRmovTFRKbmV4UlVSOVZtRFRi?=
 =?utf-8?B?U25wQ1FHMEtyeDErQm5FQ0NLSjlYV0VxcjdRY3FrZ3lka0lEQ0thQ1VSRU5x?=
 =?utf-8?B?VnpmSUJuNWl0dTBpUDV2WTFVam5LUHppT3d5QWhaelRmVWZjWWNOb1NJV0Jj?=
 =?utf-8?B?R0JLSzEyUU11RW5Sa0VYOGxReUptSXp0eXZhRnpxejVGY0JFYytUaXh6V3Rx?=
 =?utf-8?B?YUsvTVJvbVNrTGRVSURjdmFSZ1JOUXdQcmVOMTNuaE5UaldZQjlCSjhZUHdj?=
 =?utf-8?B?bHptUEYrZmd5N0d0NGduTUY3aDd3V1U2Yy9VbFg5eVhVc1VyVDgrMkVCTGhK?=
 =?utf-8?B?bUtqTGJqWm5SeWFJRnpjc2dSMWtrWk1LdXBoaFdHRWlKY1BydXkxbVZ0Q1d5?=
 =?utf-8?B?d2JVU0xZYXhZNnF6ZGF3M29ORWV3MWFKY1NpRFU5cFcySGY2cHJ5cXRCUlND?=
 =?utf-8?B?TkJVSmVPanhGYmhDbjJUdEppS0Q0eHhWZ3JBOG5ZMlg4ZHlyL1p0N2NLWkVa?=
 =?utf-8?B?VWhLV29vcWg1VTJhOEYzZGFydzBxaEYzc21MWUN0TllKNkQ5VWlSN1lQTGJl?=
 =?utf-8?B?NVhEVlNaNmtpVWZMeUI5TkMrb0hQNXp3NUV6eFpWQ1p2NUNlSE5rdVMxbVFU?=
 =?utf-8?B?dFlYOFY2OHB0bGF0b1NvdE1jbnhtU0hDdU9qS3Q3bUpnamkxNDhRcmtZcFRz?=
 =?utf-8?B?M1VUY0JsSGxabm9QbWd5RjNFaWdXakY2bEFhZGllSzRVbFpEdGQzUVU5NGVq?=
 =?utf-8?B?UFlLb05SQlpaWE1Ta3NVc29iQ2J0dmExYi85U1Y2dXI4cTR5TyttV2d0ZnND?=
 =?utf-8?B?MDhxZmp2T25DS1N6bTZPN3dnbDNNUGx0bUx4ZFg5cko4SzAwTEpZRnJuM0xO?=
 =?utf-8?B?THdUZmc2R0dMdVFZNU5UZmxYaWkzK2V6SlNtOHJ4Mzh6dUF1Y2h1TUZyMkw5?=
 =?utf-8?B?L1BvUTU3UDlZTjJQV2pBM1lSRFAyMElzazY1T0lrcnFqR2toUmJ2NnpDSDMr?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qRASh29BpPdbE/Ips+gDiy4BGEEOCOuhtaWAx9uqX31kXpVuwKGGxdj/syOO7F0xYVgDr/oRlihBnNw0T+BS4Y08474owGQgeocRF6lIAWDKT0QEz/1DXUniMcNepgyjivGVO/wmQLZ8Aq0yM5hq1PLuh4ZRzkLsYVM+qZhHSJlB4CY3VyRl6g9ww3tPBtOOH/Erg3RHyMf34sM8REvBpEaiY8P6UDwkiazuHulqdPihrj5rS45splyv5//w7uc15fyLrEd+iITY+DxpsJvrzf4kLRcXbSeBSkM9+r0syBKpOEaPGPRg90GBusHLQrChs4TEZTnSG621vq8kclDfyu1O4/0DGgwoTZ00tDrePSdhxKJ22Skpwe6kE0D70jVGI/oKw83YfiXf6P/zsQiSRAybHHrwS2gKApmoFul70nUmi0x6GPVo6rsT4vFhyxLeQkhEpDBD/sMDf+TGol0ZcjLeDxsF0Cc+IeNpBFM/Pvfxh8rYx+hhzDQhAwrRylXWRY1XGTbdRU5V7reV7siCrRg14CrIDnk29A2QE/T+6jUXs3GnImBZnBD3yXDYlTWEN7HWvwwScwPFyYeSxFgT/i+i+mCM1D8E64/aYT48yVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3313cc8a-6655-4d2e-90d2-08dd1dba4f05
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 10:13:38.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ciNbkXadWdKTZBmChUEhW6Oga8XGp/WmHAoOVDgfgdK/uP7yogf5V57mqtNJ7lrKOrPs8+VCiuWTuOnFnOjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160085
X-Proofpoint-GUID: vQZtcBSgKMZj5rTwpoH6dJ-elRTtixNv
X-Proofpoint-ORIG-GUID: vQZtcBSgKMZj5rTwpoH6dJ-elRTtixNv

On 16/12/2024 09:19, Ming Lei wrote:
> On Mon, Dec 16, 2024 at 4:58 PM John Garry <john.g.garry@oracle.com> wrote:
>>
>> On 14/12/2024 03:10, Luis Chamberlain wrote:
>>> index 167d82b46781..b57dc4bff81b 100644
>>> --- a/block/bdev.c
>>> +++ b/block/bdev.c
>>> @@ -157,8 +157,7 @@ int set_blocksize(struct file *file, int size)
>>>        struct inode *inode = file->f_mapping->host;
>>>        struct block_device *bdev = I_BDEV(inode);
>>>
>>> -     /* Size must be a power of two, and between 512 and PAGE_SIZE */
>>> -     if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
>>> +     if (blk_validate_block_size(size))
>>>                return -EINVAL;
>>
>> I suppose that this can be sent as a separate patch to be merged now.
> 
> There have been some bugs found in case that PAGE_SIZE == 64K, and I
> think it is bad to use PAGE_SIZE for validating many hw/queue limits, we might
> have to fix them first.

I am just suggesting to remove duplicated code, as these checks are same 
as blk_validate_block_size()

> 
> Such as:

Aren't the below list just enforcing block layer requirements? And so 
only block drivers need fixing for PAGE_SIZE > 4K (or cannot be used for 
PAGE_SIZE > 4K), right?

> 
> 1) blk_validate_limits()
> 
> - failure if max_segment_size is less than 64K
 > > - max_user_sectors
> 
> if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
>         return -EINVAL;
> 
> 2) bio_may_need_split()
> 
> - max_segment_size may be less than 64K
> 
> Thanks,



> 


