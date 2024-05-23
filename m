Return-Path: <linux-fsdevel+bounces-20048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E348CD1A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 14:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A907D1C21C12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3D13BAE9;
	Thu, 23 May 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D+vMliz5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dByWitFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C2208A1;
	Thu, 23 May 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465638; cv=fail; b=oNW2EbCFxdSXExBvhy9gLZt/fzNncJbl4zJndfa5+d4QZj7idEEFQdivak6KvtN7F+a1yb8MlbfTFwhLK3mnojP3oIeJoJ6tE+d2bsYA7buLVqpF1S4F0bjsfqMV3FBpxytmp8N+OD3P8wIEync24WRc5ZKRR3kAfczvbewO+VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465638; c=relaxed/simple;
	bh=xFmwJJPiuV+nk6ar0gmVYYYx4T9P6pnPcKJOel/Tm6U=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n5gzyHyk+9aKlxOIHtctYXpzTauH+O91cnbRoV3bgIfMXopkX1Nt/BhEdL5fL0adu0e8wzoJcf8gvV+C1QWMmD1N8lLnhPcSmH8vuuVTiAgFBU3v8YfsxTCZsU4RdzqNcWFBPf/YWRmwvf9Gq+A0uKZHQFbBDK0KoZzJuLFsss4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D+vMliz5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dByWitFv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44N4xAZr032338;
	Thu, 23 May 2024 12:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fK470Q03MdkDV93mxMGNYN0JGu2gaS4C95F5DysO0RY=;
 b=D+vMliz5PClzZDQf+ejVpFebpLz1JCXW4owYWKuyUPy3zPgQLUFDIUPj2GWml1qf6dAG
 1K8kqcafj+P/2sU1B5f9j5JMQrAojxnLKHzV6L+wFbAXZZ1EuK7psmPa9URfCR2WlsdT
 TcJ2ycTJGpJkj6Q35/vtu/xHAvX2WwnkITnqvML+dpnu48QLzRl8/GwnbCgeX5bH2jSW
 ox2M1uyUO8qaxUX7267NhhL/KZ2o7hlY8+nFu8wP/x2q3UHifdnQCldLxHXEzBh2khDt
 t3npbNnh5jTTI8nJVFDCxZwGz/bBw9qvoyWUcz09HqdkT71ap4VHxqB+JSiiOwoXOxEQ tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv9ym1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 12:00:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NAcZwT013757;
	Thu, 23 May 2024 12:00:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js9w78p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 12:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3NFrS2NuviwsnnViaP3QPr92ZlotamlYe2qGRf64QlobIreN1Lo7Yj6J+ofSUyAHX8ryt8L7Ow3fdNmrkx9nsYfd0Il+jCw87odEt+txTgSRqzgzh8fzs+11YB7Xyaspo6pswdXO1dijqx5Z/n7k1kFi4+n2orumMJai3uxpfg1KmYn5bq8rdYTmv8/dE6qxQdUNoHSrfXUY8eMWxv9nIDa+bpyKUQGdJ5M7mCgqME6hrCsEPJ6+8GhYki2GCQDW69R1RE1BN/Gic8EHViD8aTWisaWtI1rc2jF4LK8QICbyHgJmgiXEUoWVFdg/fx6Ss6u8+o4iq0gEEEcLukd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fK470Q03MdkDV93mxMGNYN0JGu2gaS4C95F5DysO0RY=;
 b=gYrv6Yg2J6mcnwrHZHfRNyC4hOQEx3/9VfBSlCZlj8E6xpN0sNgEWb1sNiDW8ognONEDfxJyhcR/reOYF5wd8Vg5/FAOlJDVLCHIbfBDrWPOp5Th2uDfKTNktFISfcxmdKc9DYpodrArtfoz/vt6Mqx/Rsu3BQm3qIKtUPBVV+/+D4Q6iDcYiTHO+gudgrcUbLQjFAHBGRW2nDpgHCnbY0V4wvqipzOVghea6S9L6MwoLkfePJWdu1cgOoutMAueWJcPPnvDGuNh4cwsh1eYwU+DeoKzb8jKO8+pvKniud5r4yGnfVSAgs5gdEeTAdaa/Yr7DXPKMg/lAJKDXduLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK470Q03MdkDV93mxMGNYN0JGu2gaS4C95F5DysO0RY=;
 b=dByWitFvOLUiw0oh3KanJTQyxzg/eNcqsJzJzW/0LpixHjV6coqO4NdWh6JNSkbHmPhy4dOaJVNXdJy0Zx99w/IYuG6rfp2CmZKcBmwH3xYulBHNUUge5APF/JRSpk1Yx1i4CvjRPxwQQGzkO06K0388j2AXczLWGwFLeoEF284=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 12:00:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 12:00:04 +0000
Message-ID: <bf638db9-c4d3-44bd-a92c-d36e3d95adb6@oracle.com>
Date: Thu, 23 May 2024 12:59:57 +0100
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
To: Luis Chamberlain <mcgrof@kernel.org>, David Bueso <dave@stgolabs.net>
Cc: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        catherine.hoang@oracle.com
References: <20240228061257.GA106651@mit.edu>
 <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
 <Zk5qKUJUOjGXEWus@bombadil.infradead.org>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <Zk5qKUJUOjGXEWus@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3560c3-9477-4751-1f11-08dc7b1fe214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a0ErRFBrNTkxUlF4a2FxcW1ML0R5TlZVa0RvOUR0WWhDQmRyQ0dlUkIzbHFv?=
 =?utf-8?B?bHRMMDRJQm11eWJZc0p6NjhBVzUwcEQxTStHTjlJeG9zWVh6a2hrSXBoQzVw?=
 =?utf-8?B?N2hnb3Z2ajlkUmw0SkxRSHUwenFGTnRMaVUxNzNINHRrZzhkcVpydUVwdTh1?=
 =?utf-8?B?ZVBZVU1DYk1aQkMvRVpPVGMzbDNoaWs5ZDloZ0RMN0w2ZllyNzJmSHJnY0xM?=
 =?utf-8?B?OHZlNmhNTVVpU3Q2VjZIY1VLbHpWZ25uNEdHMHhFUFNMSmY2VGQ2WTlkNzA2?=
 =?utf-8?B?UFBQMi8zcnlBZTVZRmhOVVk4RGpOUHNnU2I2dGQ3WE1sL2toV21qNlpRTGRz?=
 =?utf-8?B?QUMwcStiVWs2RnZpTWpNNEpQaTlkSHN4cmJSQ3ZNK2xSRFJrL3Bobi9xNjBk?=
 =?utf-8?B?S1c0cytBSnhqVkF4cUkwTFNlSVdiZXZ2T0FoeTVLbXhPTmIxYU8rS2lncE55?=
 =?utf-8?B?ZjA1SjZOM0NLb3F4WTZ2VlNxSWtPN2FNa2QrbUNoMmxRdE5ncU05dUtuS0dY?=
 =?utf-8?B?NjBJKzNPN3pkYWdWa2ZuK3RBTVRpRm5xTWVyU0lQK3NjSzUvQW03d2M2YjJH?=
 =?utf-8?B?dGhzYWp1NWdWeW5IQng0OW56RGtuUGpmOE56c3hqdkZOWHhrekpiaGpxb1Rw?=
 =?utf-8?B?UWZoTVU3NzRSc254SWJ2bmdLNGlTNEsrTU9DSWtGK043ajQ0Wll1ZkJpVC85?=
 =?utf-8?B?YXNtdjNOV254SDEyTGMxUWZHejEva3psYWd6ODllcGxKR1dQSUZ6SG9tbnhm?=
 =?utf-8?B?dFVkVXZwYWdWZktvdm91bXNmK05ZZ3lUM2VHSlNwUDdoMTczQjhKVHl5djZW?=
 =?utf-8?B?alQ4YjNYelFQeHFYd1dMbUpvcUtoZkxBUDBKZDhsNzlsTDh4THAvc2R6NWRJ?=
 =?utf-8?B?ZkttSDFxRnFEamc2UjJXRDhlVytqTHdoT0FKcGUrS2dadFRLT3pvWTVaZ2x3?=
 =?utf-8?B?WHZBMU1lOTVsS2xEVHpCNFhJb2VrbVI5cklFMm1GS1cvclZFRWp0ZzBVbGZI?=
 =?utf-8?B?MHl4cGNodExvQmVZK1UrVzY1Y3VqT1ZGMGovL0FRMUFqdVVpR0QzK1FNS0ls?=
 =?utf-8?B?UmJIcEdvSVdmWFRMalVWYktkN1hPQnR5L1I1eloxTGN5M3dFRXpBaHdFU25T?=
 =?utf-8?B?RkYyLzl4OEs1bzRNbU9iVUJabTh4NUh5ZW1NeTFpTWFDREhSVzVoVE96NGJS?=
 =?utf-8?B?cllBV0hMNTVOVjljMU1oQmZjRGowSnBMSnB3VDh5WURITVJyVEN6Q1oxdURi?=
 =?utf-8?B?VFQ3OFpHUm1jOEhxOUJSTDIvT2kzZUtzYndYZC8xOVFDbjhweHpBMjlrUEtV?=
 =?utf-8?B?b3NrM3lGN0QrM3ZhMDRHZmVQb1BUWVNSOTNUVWduc3pVb1Y5a3dwSDduTjJQ?=
 =?utf-8?B?QlUrNVQzS3ZPN2pGQisxWFQ3emwwUVJUc0E4WG5QM1dzRnhydVNkUGpmKzJF?=
 =?utf-8?B?Ykg1U3NqQUlPSkM2MllDN0dld3ZqZThEckNaUXduaDdibmZxd2tXN1k3UzNG?=
 =?utf-8?B?aU0vdC80TXBJWGYxT05iRitBQm5hQWgyY00yRnU1NGJ6WXc0VDc2aXV1NXR2?=
 =?utf-8?B?SW04THpXZ0VHTmZtRmZJek92ZFJPZW03MHRKQXNsVVQ4VjJTK1hpREVwNit4?=
 =?utf-8?Q?Gn7HEOBNIkjw3OrNvqV3gkC71sb/OoV+dO/MdI2TvCuo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHA1M25FOEJaVTlYc1N4Z3hPT1lWQkR6OFJyNFUxRTk0WnFCczdydDJudXB4?=
 =?utf-8?B?NWgvWkJqc0JNVVIwUDViWmtsdDc5QkJyU3R5cVQyYUlXWVZpUnZpbU5ZMEI0?=
 =?utf-8?B?aWF3b2VaRHFFQ0FrQ0NyQVBmTWRUaVhocHFlSFFmZVlyNjU4NUdwM24xaGU2?=
 =?utf-8?B?U3BVTmROeVo0SFNxMzBmc2Nxa3lHMDNOMGQ4b3JFalBZam14OTYyTDJYTkJo?=
 =?utf-8?B?NlJkQlZ0dmwrelI4SjFHSUJsT3RlWFl6V1lURWVuNGkwRmJNSm5JZzBQTWpN?=
 =?utf-8?B?bVJnRXJsUFZOQVpVeXo4bzFNWDJBc2s1V0tnajJSVnNlcXE5Q2xyR0tyNlZJ?=
 =?utf-8?B?Z2w2elBteGo5eDNJU1c1dFlyS2loT0E0a1JYOEJoL1VQek92VkZxb1N0d3U1?=
 =?utf-8?B?YWFrWWxnaU0wMVNGd2V6NTkycjV0NmhmZXNyUmh0UEUraW1Qc2Y3OGs0WnYz?=
 =?utf-8?B?dGRUT1ZoeHV6bE1SRktyWUZGZENwSTdXeXVhYjBYUEExelkxK0s1RHpGRXpo?=
 =?utf-8?B?Wkt5SkJEelFGY2dHUE13MnRIVTM0YXRpdTVSRVdRVmJFQmFHVEI0S3RFWXVM?=
 =?utf-8?B?Y2hBeGpJaVBnSmVTNmNxYyt3SU5xMXJ1NWZKS1MxeDdHQVo0WE1LcGl0N0pN?=
 =?utf-8?B?M3FnQmtLdndWRHZCTGYvY3ZJb2dlNkpNZGptSWdyVm5ySGliSlNzS2UvV3NX?=
 =?utf-8?B?eVJlenBwRkh6ODFscnpDQTI5VWZhSlFyeGJmNithKytrN3NYUHhZWDI2Ny9Z?=
 =?utf-8?B?MjY0ZDZkeWpHRFExNDRHaEJQNlNXWTU2Y2NCLzNablNWM09PYndtOVVYRDNU?=
 =?utf-8?B?OFV3WE1acFhCdTZYZ3Z2RTlhTC92UVlIWmZiclNuZGJKOXRNVzV4eUJTaWVR?=
 =?utf-8?B?N21Pd3NVWDI2cVI0Um82OEo1bWVJdUxLMVpKQTlEU0o4ajBtM2hXbmc5QnRk?=
 =?utf-8?B?djl1eE1VeXFkM0dpYjFaVWxKRmtEY3RKSWdWSkdsZ09CN1IvbzE5dXdYRlc1?=
 =?utf-8?B?aXhRUU1WVFZuaDAzYmJIQXY3KzRubStOTTdwTjd5Tmkzd2t1UTFlQWdLczYz?=
 =?utf-8?B?bmwvOEVNaERBdktUSWFPNjlXdTR0aWRCaTgxM3J1STdxR3FLYlg0UnNnSTN1?=
 =?utf-8?B?bUd6dHE4Q0dXSVZ3Q0dlZ0tyV3NFbXk5WUxSR29NcEpCZHhkeVQ5VWxmbHZz?=
 =?utf-8?B?S0tlVlFtbkl2Ry96N3RjVWRCRW42VTVkZ2grSFllREUrejQ0Z1YxS20zZkt2?=
 =?utf-8?B?elUyY0NsVjZZSis5SzUyYy9oOFNZWlczbUp3bWxvVVdkMi9penc4MmdiRGNo?=
 =?utf-8?B?M2hNblRrMmZCbG9EUXdubUROZlRiWFVidTAwcWx1T25Gd2lJcWV2RVl3a3Jr?=
 =?utf-8?B?ZUsyQ3lWR0FJWFJBOCt1eXZLS2VVNVVhZkExWmFNcHZqc2MrN1EwTlI1YjBM?=
 =?utf-8?B?RFU2YXpQb0Rzc0VaWWJNMzByNHNTSmhBbjdoZlpMbHQwbXNrdGNRVytYaUcz?=
 =?utf-8?B?eG1UcW1ETlBtamMrOVRIRDAwSVpJMHVsV2duTXhBZ3FoK2kzdnRHbm8xMFUx?=
 =?utf-8?B?alNpQnVHVVJMNHQ1ZmJuTllENTJGbjh6U3dlVjZ0MHdqOTUwcXZiK1hicU16?=
 =?utf-8?B?Y3F3UVlqbXpscEF1WHJJcDBCWjV4Zk4xWkJCWnpvZjgzaEtpUDg3K05CaGlq?=
 =?utf-8?B?YzhLU3VjWmlKUDhUZE1INTVXcGthaGMxZWxzbmdTVm0yQVArUmxyOVhZVFYv?=
 =?utf-8?B?UXNFK2FObWk4UkhVTEdYU1RkQm42WDdrdXFTcFhLNDlQTE55aEFtR3cvSnFW?=
 =?utf-8?B?NkVpR0thdVlvaDEzcGx0cW51ZGxvQmVOUmhXSTlEd0wvcER2OGZsbFdsdU9K?=
 =?utf-8?B?Y2N5bWNPOHpUNVJLelRNa2luNFVXSmQ4S1pSNVl3ZG9rZTlOZTdDUnQ3anRC?=
 =?utf-8?B?SkFmL3kzSFNNL3FFb0ExeVhWUTkrM0d5T1ZJaTRBMG9sbE1ENWtDTzdEMkRk?=
 =?utf-8?B?eHlNMzErT3F2UGpuWURDZnZ4bDZFRGh0TEFnaEc5ZzFxQTZVZldqS1dUTW0x?=
 =?utf-8?B?SUVVTCs5ZVVCR1VaZ1lWanhvaGd1WXViZzN3Z20xQVd4eEdybFkrK0lnYWth?=
 =?utf-8?B?eTJTMUtCZS9uU29EM3Bzc25yTldiWnhlMlRacjFwUUVob1c3bGlVVUpiekQy?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ud407wSQm9Mczg0UjiTJU9zJ+YQr8YlC5zjBH5v8C1XkSpXPINiwjDjqOSwLnKdonQVrdpm5Vdb3Y0Q1lZwk3vYN9d5SUiX0kZoKObUz0jGZTMuaalBtJjb7gfOVfxZPl3NJTmjNoRWrDSMra1UUiQCf95GRVk9bZqMUbaD+uJgQTn/tswHPfkFRw4VxOH221R6Hl5UgjC111lIkin7YUW8baAbl7/km8wP95oXo8m3LxbQN2poG3/BWAKxuAmRMnvY4CS66bXNsXbyjsEX8xfPyi1qTc4VNRO3oM0oUAu6KFM/MbTNxHhHUQHRS2CpxnXF42nTEeovtPW/Ms61oOLst8KEWSAUNgcbGxP1A7JhYekJ6/T/16SdTMezuhYCIyQLN6dm/r+drUOmqrSRBYHnwQcYWKywb71uZ7pNzOLcmxkDFZvzy9E0fGJ6F8T39yvL4zeNLw+6E9lNayOveGTgqB84DC63dJCQfZHtMWtpZLQDedCvCxb9Ovgz7uSy1vkvwm3XYphllwLnYgSXWncOyF1S//uOPUO58NT+wSJw2vpFq8U68hPCLahC6oNYOLdsT3a5O6g1LJuq155TrPCsCsIGfT16K1vy9z87rhDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3560c3-9477-4751-1f11-08dc7b1fe214
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 12:00:04.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rqi4jT0eoq4ufugSm4dyfI/m3Wjeiq6jSdUlMZHhqO9hPtlRNhOjOwDE/mi3K11s0ubh6O0vUwCDPsvyjJeFTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_07,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405230082
X-Proofpoint-GUID: z_ln-uMl9LNkrv_DwzFzNmLDZIJurCfT
X-Proofpoint-ORIG-GUID: z_ln-uMl9LNkrv_DwzFzNmLDZIJurCfT

On 22/05/2024 22:56, Luis Chamberlain wrote:
> On Wed, May 15, 2024 at 01:54:39PM -0600, John Garry wrote:
>> On 27/02/2024 23:12, Theodore Ts'o wrote:
>>> Last year, I talked about an interest to provide database such as
>>> MySQL with the ability to issue writes that would not be torn as they
>>> write 16k database pages[1].
>>>
>>> [1] https://urldefense.com/v3/__https://lwn.net/Articles/932900/__;!!ACWV5N9M2RV99hQ!Ij_ZeSZrJ4uPL94Im73udLMjqpkcZwHmuNnznogL68ehu6TDTXqbMsC4xLUqh18hq2Ib77p1D8_4mV5Q$
>>>
>>
>> After discussing this topic earlier this week, I would like to know if there
>> are still objections or concerns with the untorn-writes userspace API
>> proposed in https://lore.kernel.org/linux-block/20240326133813.3224593-1-john.g.garry@oracle.com/
>>
>> I feel that the series for supporting direct-IO only, above, is stuck
>> because of this topic of buffered IO.
> 
> I think it was good we had the discussions at LSFMM over it, however
> I personally don't percieve it as stuck, however without any consensus
> being obviated or written down anywhere it would not be clear to anyone
> that we did reach any consensus at all.

> Hope is that lwn captures any
> consensus if any was indeed reached as you're not making it clear any
> was.

That's my point really. There were some positive discussion. I put 
across the idea of implementing buffered atomic writes, and now I want 
to ensure that everyone is satisfied with that going forward. I think 
that a LWN report is now being written.

> 
> In case it helps, as we did with the LBS effort it may also be useful to
> put together bi-monthly cabals to follow up progress, and divide and
> conquer any pending work items.

ok, we can consider that.

> 
>> So I sent an RFC for buffered untorn-writes last month in https://lore.kernel.org/linux-fsdevel/20240422143923.3927601-1-john.g.garry@oracle.com/,
>> which did leverage the bs > ps effort. Maybe it did not get noticed due to
>> being an RFC. It works on the following principles:
>>
>> - A buffered atomic write requires RWF_ATOMIC flag be set, same as
>>    direct IO. The same other atomic writes rules apply.
>> - For an inode, only a single size of buffered write is allowed. So for
>>    statx, atomic_write_unit_min = atomic_write_unit_max always for
>>    buffered atomic writes.
>> - A single folio maps to an atomic write in the pagecache. So inode
>>    address_space folio min order = max order = atomic_write_unit_min/max
>> - A folio is tagged as "atomic" when atomically written and written back
>>    to storage "atomically", same as direct-IO method would do for an
>>    atomic write.
>> - If userspace wants to guarantee a buffered atomic write is written to
>>    storage atomically after the write syscall returns, it must use
>>    RWF_SYNC or similar (along with RWF_ATOMIC).
> 
>  From my perspective the above just needs the IOCB atomic support, and
> the pending long term work item there is the near-write-through buffered
> IO support. We could just wait for buffered-IO support until we have
> support for that. I can't think of anying blocking DIO support though,
> now that we at least have a mental model of how buffered IO *should*
> work.

Yes, these are my thoughts as well.

> 
> What about testing? Are you extending fstests, blktests?

Yes, so 3 things to mention here:

- We have been looking at adding full test coverage in xfstests. 
Catherine Hoang recently starting working on this. Most tests will 
actually cover the forcealign feature. Indeed, just atomic writes 
support testing would be quite limited when compared to forcealign 
testing. Furthermore we are also looking at forcealign and atomic writes 
testing in fsx.c, as finding forcealign corner cases would be quite 
limited on the formalized tests

- for blktests, we were going to add some basic atomic writes test 
there, like ensuring that misaligned or mis-sized writes are rejected. 
This would be the same really for xfstests, above. I don't think that 
there are so many tests which we can cover. scsi_debug will support 
atomic writes, which can be used for blktests.

- I have done some limited power-fail testing for my NVMe card.

I have 2x challenges here:
- My host does not allow the card port to be manually powered down, so I 
need to physically plug out the power cable to test :(
- My NVMe card only supports 4KB power-fail atomic writes, which is 
quite small.

The actual power-fail testing involves using fio in verify mode. In 
that, each data block has a CRC written per test loop. I just verify 
that the CRCs are valid after the power cycle (which they are when block 
size is 4KB and lower :)).

Thanks,
John


