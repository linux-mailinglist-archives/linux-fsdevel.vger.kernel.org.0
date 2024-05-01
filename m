Return-Path: <linux-fsdevel+bounces-18423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D668B88D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 12:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3BF1C234CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8136655E75;
	Wed,  1 May 2024 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HQDzRP03";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KEqSrMa7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D974F881;
	Wed,  1 May 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560917; cv=fail; b=RUEDAw4Pzgaq5oDdTp/5DwxbvdLJqyzdsh0d70zrjz0pwP/8K+Xegoi96qaHf5OWGEbhXyfzO6Azfpcv0JYLzOie+neN2YBTcY0r8DzicVQbg9dBBL1bpx6cOIONY2cYjcpTRtYwu6Tnt3qlyGBxCtg/dMK5sdGyu9Jn6r2/yyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560917; c=relaxed/simple;
	bh=DDGt5H60xox97iKb4jsMhSc5pDN90WhesPIjYIloxzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=abIQgXlj1XOHGxMOsxF9zUNg/kF2kwRTPFzIiNNKQcPTrZNoaXycRgl/pwhWxMiYp9p1gjmT1H3L4Vt4yyMV2CSaxnnb+wCNyfxZAdA7eD1ser64Y2ifAh3LX+6merAr76xmWp141B7h6Tcumrv6LwJI02HtxQh9XMlLErT/LZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HQDzRP03; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KEqSrMa7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441ARxjL032762;
	Wed, 1 May 2024 10:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jgsqlBpQVyyC70+Hy13IxD6kVnZ2QAl+61NL5JEWOeQ=;
 b=HQDzRP03CIaXHvH+D9BJeSxz8nV2qwW5+oyB9nwSHB3ZntlSchqXb+exF8TxOjq85LSJ
 hyDbcGnBMY6/Cts5f/nR5vq6pbE8A1Hrw1q+gBfnhWySPkr71gE8eBPmXFEC9Mc24MSC
 WOW0Juwpq6oh3thuTNKnfeRiEXmip+PlM94hzQUccoDvUFL0MCi7o/tr3/RoGtzJRb+f
 G8hS3NX/6BbsrBDZuv3lnERGJ0rYJXcAzOeO2mKltYzF/O5hgi0lHZcA1iz0RifV2KQh
 fhX7o5+fO7X8oKVSAC1hGhRVUl8gbAgaUF3fmYCXb2YUioVj4hMEKh2zLGVbBsMYc+RQ hA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsexww1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 10:54:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4419oKSa005149;
	Wed, 1 May 2024 10:54:51 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt8paar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 10:54:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq6lOeFhpBf4yLF3cNARAhQ12wiicd901ChdOiQztTbgPIf9XzuZHLRN3EBvBZIRNV5NhY/Hn0k+6svNW3ZGuwlofNXY4WgbMcye7+IEEBRSo4S80HQlBF9MOrN4e1jx2aX5iNUAilKF6khnD3LBrKGCDxXoBcm8wAhPMMGMfJYInlSfM4vUt2niJR+C+Qt23yHjVhiS0CLiAb+Xidnfp6Fs0E2lo/9ttZCT5m7XX+z4ApURCpDEikUbjp8DYcsPwhhHWD0TP0iCMxFLWPWK+k0H8FFdfHs8BuK7XpIDNJxo+E1ZxBF3izm5gzGT33g+1XCZnn5MRuupaaHB+t2qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgsqlBpQVyyC70+Hy13IxD6kVnZ2QAl+61NL5JEWOeQ=;
 b=S3Zx6RmPzuVLFfZKI6R1fNZc/FJNcnfNm80L4WUkmkhgNJn+yVto/fTe5g4pXmeXSjo5LjcR1yoYYRYP3/UYiMf39D3ZZxfQ9LEYU1qu7k45D1Gtk1IG0J7ko0DyB7Sh2VPji/W2gAA31fwyA5ucvaZbtAw3cB63Ur3dtAuXjREQMAJM3Igvy2rrcwDMud56Cp0MRsUs2FX4fGOy0ITr0oHDQ47pk+HsdmttxpnLEt0uIOtprVFNSDWUTJZZfs9WB4dsFlnj6p00BCF5vqaD26hyf4bZpqqTProcCU7mJx3u0jOLoZVtWVq1wA9q4l+CnUv3RVzEQALgcqWwCGDGYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgsqlBpQVyyC70+Hy13IxD6kVnZ2QAl+61NL5JEWOeQ=;
 b=KEqSrMa71gakyAJDWU3ZLiZS60EP07cCoMEVyRFfJ8dsEeYgRPXsXENcabdkpc8LCMHLR3Z9s4he+H759Qiw5rXj74Yoos0Vh/VvEl1nn1SyZ9UPCzdldf//zRbyDzgP2KEEF9Lf4eLtfh/G/oeKIrir5GZgwvaK+g5OvuV6Joc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6836.namprd10.prod.outlook.com (2603:10b6:610:14f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 10:54:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 10:54:49 +0000
Message-ID: <05016d8f-cc25-4148-bf78-6567cc2dfbc4@oracle.com>
Date: Wed, 1 May 2024 11:54:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 11/21] xfs: Unmap blocks according to forcealign
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-12-john.g.garry@oracle.com>
 <ZjGIktQV12qas14f@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjGIktQV12qas14f@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0069.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: dcabe19d-4d1b-436d-cc5c-08dc69cd1f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cW1NUFVuTzJmMm1mSXplSmRZd2ZmYmlDeldFdm1sQjZGSEJ3ZFJDdE9SVTZk?=
 =?utf-8?B?bExYM3NqbC85WlAvc3B2UDlPK2ZCK2F2cVU3MWJzSkQrY1ovV3ZCL0hHOVVN?=
 =?utf-8?B?ZXBiTjNXZ200OHFDRU0wZkNCRTN4djJzL0VSclk4ck1aVlZNUTFYUEZjamxB?=
 =?utf-8?B?aG5zRjF6cDZ2OXB5N3FCQXJkRW50WmNZVGY3RUpkTDRaVXcvL295Q09NNFY5?=
 =?utf-8?B?ZmVCemZGaXdpRkZ2a21XOG4yV3lyOHNxWjdmZmx6VkxYbzRyQytEVlFhYzZH?=
 =?utf-8?B?Y0RzUmdndzA1OXkyK3hxTk55N0hETWh3ZlNHR1NtbUhnT2F5OEFxTkRITnhj?=
 =?utf-8?B?d0M1NGFFOG9CSDl6YUNnUFozVC85SjliWnRzcDRneXlSeFN2V1orN2dmNFJi?=
 =?utf-8?B?TzRSdHcydFFEcnZudGZGZmlGWHB4NGR2VW5LaE9kTFBjLzRKMEtKaENjNTd5?=
 =?utf-8?B?aVErOWZBUWJ5NVpSYmZsNk1aSGl0NXBFN2c5UU01Z1ZRcUJkRTY0MDJ2dERm?=
 =?utf-8?B?NU94eWFGOVVreHFWdkIrdGZ5OTZKTWxIN01NaDlRUXNsRVcvSnQ3SWw0MDdw?=
 =?utf-8?B?Q1ZJVUZPVjF6QldFaXNEWHA4dGZHcXY4eVA0cUJSQUd3Q2ZGVjBReDliSzdm?=
 =?utf-8?B?R2gxYlRnK0RMWkR1ZHhNMDZHdjlycld4WWs5OU03SlZ0dnFFOThWdm9CZGdO?=
 =?utf-8?B?STd1RkdVSjlpanRvRmxsTkxmcWlkV1pYd2ovQUY1T3FDZWgrRFRWTEVHZ05n?=
 =?utf-8?B?VHRDaGduRjVQdTRsMWQvbVFDSkpNTjNkNytHUlZsbitIenFhUnBxS29zWjVh?=
 =?utf-8?B?aWZ2eklIV1BBSStpZUhSeFVaaEUvZFhoK3piVUZTRHA4aGtSdS9hY2xmVVV2?=
 =?utf-8?B?R3R6UjVtRSt1T1NIZkM1Q1ZZQlNpY0hGSTNQbG12V0JNR1Y2OUJuQlFYcnJq?=
 =?utf-8?B?eCs4SklrQm16dGg4SDZ4U2p6N2lvK3pXVml1eTB6MGExeWVyUU13ZU5tdHl5?=
 =?utf-8?B?YXVWTG1JKzZmVXAyZXo2Yk80enl0YlJiczZGMXVhdFgxRC9KTWNWai9CeE9E?=
 =?utf-8?B?cjlOb0Q0S0ZsVWY1NHdWbGJFVTZNdkJtUGFYZjFhRFI0TmEvVFZ5aWl1VG1k?=
 =?utf-8?B?VEs1SlJOTFFDQjdOcWcybUo0Ky9zN0srZEJPRlhPcVI3Z0VCZDBrL2RuejE1?=
 =?utf-8?B?YTYvc0RVTXE5cjIxNVlCZFQvZW9ZMkkxTXBsUUk3c2dsNEpyZTJDbTlVczdZ?=
 =?utf-8?B?MC9KWmxsWmI5NENxT1ZISVh5aDYydDVleVN3eWZHR2dzQ2lHNmlOZEQ5M1ZP?=
 =?utf-8?B?ZnQvalZxN2lHbkdHTFNJNk8zd1JDSm5TdCtDaW4vZmVSbXpHbHRwWGpUKyt6?=
 =?utf-8?B?MW1LUHdlQitnNzZ1UTczNXVGYlY0dlZnT3h5OFRyTWhFVFgvZEd2N1dvTFVw?=
 =?utf-8?B?S2NpRndrUDJCYlhxK2p1K3p5aVBNbEtsMzZmQWlNeEdaYWJaVFhzWkFPb1BB?=
 =?utf-8?B?V2xNc1RFZTdubXZqVzJrTGtCSU1DdXowcEFWTUFURjZMTGhuYlpGUGVpTjU3?=
 =?utf-8?B?Qk1Id0kwbVc1OGx6K1dzbUkxMStOYmdDbld5ZmJKRUpjUnRsV0V6Y1lLYWdD?=
 =?utf-8?B?REgveEgxVEhzbTNIUzBjanJ2czdRWHZ5bHhUcmtxL1J0UUp4UFZxdmROSUE5?=
 =?utf-8?B?SWhGN2tmKzcrSlhCUjZIa2NUZWtFU3FNdkd3M29nSHRYOE1PY29Kay9RPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bERqVzQ5Si91OWZWdDJaUHNqWk9jTTJ1TGlYSHVGcVlRSnBQT0ZqOFFPdi8w?=
 =?utf-8?B?Q2pYWU5Xc0Q3UmJndTFXTXhuVEVpcTJSeGZ4K0xTY3hmbVFoRk9ka1p2Z1oy?=
 =?utf-8?B?U2sxYjNra1FrTmJYMlFYVkxDYXl1cHU5OWFJR012bDVSZ2lPZ2tacXpBam9t?=
 =?utf-8?B?emtwaWpNN2lJMEo0VmYzUitBM3NZejF2azhraHNTZkxvZHBkKytDTTcyU0Iy?=
 =?utf-8?B?a0dlNUdsdlRPV3ltK21rUmpDTjJKOHdpWnRKZ3JXRUhBOEhkZ3N2cGtHOHdp?=
 =?utf-8?B?ZlFpNVFYM2czV1FLOHVDcVY3ZTJMMHE0K3h1UTJ0c3BUTklkMC90dHhKOFdN?=
 =?utf-8?B?Slg0R3hzTGFGMkpXNG14eDJpQkF4Y01VeFN4WHNnYWRBQUtoMnNUcEpsa0Nz?=
 =?utf-8?B?NXQyY0RESE4rNkZ6NnBlc1k4c0ovY1UzZ3NDS25pVFpBSm0xUnNLeTJVWWpQ?=
 =?utf-8?B?RjROSXIxTHNXOXpyVktudE00WWlaa21nM3JZck9VTWpqRHRXeHhHckcyK2dS?=
 =?utf-8?B?YzcrNEwyQjNLc3NIZG11U2FKaytUYW1abzlrUGI0VGhYOGZpR2k2TEYzUHY5?=
 =?utf-8?B?bVlKZEhpODdOZGpXR1lJTVNHWlJ1YXlOemFrdTgzcHdnSU5LWFRVY0pXOFJE?=
 =?utf-8?B?Y21QRHZvZk1UWDN0RHV1WnpNanVCaHBZbm9nWGg0OXJaWG1BWm1uMGx2aW1H?=
 =?utf-8?B?M09DSnkycFlDbUZQWk1yMml0Z2NFa29BWHF6clBtQnE0UWhQUFEvRUpCdndD?=
 =?utf-8?B?RXhrajZpTnNqSEZQRUlsUWtvempiZi9uRnh6eE5PR2dGeWk0b0F0Vms3elZ4?=
 =?utf-8?B?MjNycVBOUEcwSXRjWHJ2M2liZm5ZbUpYRmhtN1lLTXJ2SEp2RGRuY1BaQ0My?=
 =?utf-8?B?cUpZNGxwMWY0OTR1WnZnZGZSYU85aERVN3lzQzVFcjZZckJ6bVF0N0xQYnZl?=
 =?utf-8?B?dUxSWk1xQlRKRDU1LzdhTXgrZlpMSEhJVURZMUFqaDAwNzRmTm5TRDkveGFG?=
 =?utf-8?B?cDFQL1Jycy8rejBuMXVYSHVuVDlsT2loZ2FvczJKa2MrN2l2aGZyTkFDNkFl?=
 =?utf-8?B?bTNWR3IwUlYwRnBjU0NSQ3hFUEhaam43dFlRVWRZYlpTRExrNG1jcUxsZFFV?=
 =?utf-8?B?aXM3QzhlTWJkSzNXRW9WZ01SQmNRblRacWp2VUZNSGtaTzRsbTRucjU5L1lJ?=
 =?utf-8?B?OGFGc1NJcSt1WW1DcTU4QXdkUWFmeG9yU3cxRnNLUG02S09iZ0gyb2NhcHlx?=
 =?utf-8?B?YkUwVitKMDB0bmt1NUszUjF1Z3BBSjhURHFhTEtIcDJ2TkNNMjI1WlRlbnU3?=
 =?utf-8?B?Rjl5dDh2SWEvYnU0alJ5b0xpbWhuS3dkRnNrK0p2V1lya3ErbVc0enU4cmtD?=
 =?utf-8?B?d29qNS9BL3ZaSXdDZmtvUGk4N2YvYzJac3ppVmlKRnZHZ2FOcVFWMmJ1QU9E?=
 =?utf-8?B?Q2tjaTZNVmYvNnJ3ZFRCbDJHSmljcGZ2enY2d1VMcHMzdE9IYWhGczZSRkJl?=
 =?utf-8?B?ODMrVHBsRTlZK3FrTEJRWHV5ZStpNUp4NjU5SzNnMjFnVXVoM2ZEWWVZZ3Rs?=
 =?utf-8?B?RlVWZWJsb2dWS2huQ0d1L2gycFZSaEhIdWRtLzVOUVFITnhDRXNUTjJYM3Mw?=
 =?utf-8?B?TjdXdHBPMFllNkVTTGV6U09vSy83aElsV3EvMFRtc3AzTlMyVmRrWUNaT3BQ?=
 =?utf-8?B?Y0FXejlWM0dSeWF2MWdydnh3ZS81cUY4NitraStNQTRVQ0pLSDZ3OWxpSldY?=
 =?utf-8?B?UU80MnE1RnlQaGlPbDRHRWVIR0FpUmhFR09NQXcvREh1ajdVbFJtQ1ZESzNX?=
 =?utf-8?B?Z2pvTHVFbngzWnZuTFBqdFNDUGhCNmp0Sk53THJWS2hhK294cGlWbE9ZOWJW?=
 =?utf-8?B?Z04zRHRTTW9XN1hiTGF4VDljdmR1UHZMTG13bFl1cmNjVWFzWG1sdmhMSlRU?=
 =?utf-8?B?azZ6MXFNUVNTUDFFYnA5d055Ymppc2k3WmRBU0Z3bzY3KzZiaGN1UmRPYm1o?=
 =?utf-8?B?ZjVXV2owUUlURk1KL25rUmtFbDZmODQ3WGgrYjM0WE1XREtFNVd4Y0MyeDgx?=
 =?utf-8?B?dEZ0V1o3WU5BanE5SU1kdUpsUTF4b0oxU2RYYytvU3Rndy8yNFNlUzY1OWtT?=
 =?utf-8?B?aThMeE1IQXk2MC92NFpWRmtYdExBdzgydHdpTnFGMDI1ZjFDenNVVm1OWTV0?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NJaF6ZcVN1j38/oOzVfEb4o2qkHfWCLMajw7r5N+E0KfUhUVIuwfAZERWcA+UsKby/skeBYCziRMZjGLRKt/OVFoKVNywmSQu1h9MGZax1NlLskSjgOjGrwX07A60Y4IlsLKJsj4N5/yn7W7eM0192/x5o6NBAJj5c6ycNw7zENxCx56EEAnRG0cR+Z6YB7wPlR2czkk2L+ZqkhmQ7tYuhmoA3WatvUCaSf30uv+YMPP5ApIORHhklnh5c3jw/bmHO28diHLOB7wphcMcToT66q1MuCO3ElVkzhaVBY4XL3hnQrYtxkOP+Wbgb2F6CgONsdJSE0n9c+gvcYNOt1ZQXhbsAa38NyJhANuXr57+UbqHGssO8z/Y86v+fxqGM0wYhh5156RQ2MeWf5i6h0Kr7VObbj907L1fmVQmIRO85ksFmhma1eKln7dBfiaClZB0WNcZ8J6aXCSwkLQDNCXma4uzuN+Zvl8StESrhHgxD3Hl2sEHa3QulOMS//3T8fGXctMoFO1eJLTGrWDiPYYVr8ObqoMeuRL3WaQIJuMwvmfDjx653mLnF5D1ywSGz9nUbPQFqPOWpyqyOpcQqkS3avCcIL/Lug/EydQXOym5eI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcabe19d-4d1b-436d-cc5c-08dc69cd1f19
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 10:54:49.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kh0Ke8thfVfjx/r6adRwkraRBAnin1ABLBrYYiWzjlEgOteVjbGztNGHgXhfZs0vABk7wkqt4nOySjKhXBAxSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010077
X-Proofpoint-ORIG-GUID: MO895rLumaoCCS7RboV3R-5emnzm9mAq
X-Proofpoint-GUID: MO895rLumaoCCS7RboV3R-5emnzm9mAq

On 01/05/2024 01:10, Dave Chinner wrote:
> On Mon, Apr 29, 2024 at 05:47:36PM +0000, John Garry wrote:
>> For when forcealign is enabled, blocks in an inode need to be unmapped
>> according to extent alignment, like what is already done for rtvol.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_bmap.c | 39 +++++++++++++++++++++++++++++++++------
>>   fs/xfs/xfs_inode.h       |  5 +++++
>>   2 files changed, 38 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
>> index 4f39a43d78a7..4a78ab193753 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.c
>> +++ b/fs/xfs/libxfs/xfs_bmap.c
>> @@ -5339,6 +5339,15 @@ xfs_bmap_del_extent_real(
>>   	return 0;
>>   }
>>   
>> +/* Return the offset of an block number within an extent for forcealign. */
>> +static xfs_extlen_t
>> +xfs_forcealign_extent_offset(
>> +	struct xfs_inode	*ip,
>> +	xfs_fsblock_t		bno)
>> +{
>> +	return bno & (ip->i_extsize - 1);
>> +}
>> +
>>   /*
>>    * Unmap (remove) blocks from a file.
>>    * If nexts is nonzero then the number of extents to remove is limited to
>> @@ -5361,6 +5370,7 @@ __xfs_bunmapi(
>>   	struct xfs_bmbt_irec	got;		/* current extent record */
>>   	struct xfs_ifork	*ifp;		/* inode fork pointer */
>>   	int			isrt;		/* freeing in rt area */
>> +	int			isforcealign;	/* freeing for file inode with forcealign */
>>   	int			logflags;	/* transaction logging flags */
>>   	xfs_extlen_t		mod;		/* rt extent offset */
>>   	struct xfs_mount	*mp = ip->i_mount;
>> @@ -5397,7 +5407,10 @@ __xfs_bunmapi(
>>   		return 0;
>>   	}
>>   	XFS_STATS_INC(mp, xs_blk_unmap);
>> -	isrt = xfs_ifork_is_realtime(ip, whichfork);
>> +	isrt = (whichfork == XFS_DATA_FORK) && XFS_IS_REALTIME_INODE(ip);
> 
> Why did you change this check? What's wrong with
> xfs_ifork_is_realtime(), and if there is something wrong, why
> shouldn't xfs_ifork_is_relatime() get fixed?

oops, I should have not made that change. I must have changed it when 
debugging and not reverted it.

> 
>> +	isforcealign = (whichfork == XFS_DATA_FORK) &&
>> +			xfs_inode_has_forcealign(ip) &&
>> +			xfs_inode_has_extsize(ip) && ip->i_extsize > 1;
> 
> This is one of the reasons why I said xfs_inode_has_forcealign()
> should be checking that extent size hints should be checked in that
> helper....

Right. In this particular case, I found that directories may be 
considered as well if we don't check for xfs_inode_has_extsize() (which 
we don't want).

> 
>>   	end = start + len;
>>   
>>   	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
>> @@ -5459,11 +5472,15 @@ __xfs_bunmapi(
>>   		if (del.br_startoff + del.br_blockcount > end + 1)
>>   			del.br_blockcount = end + 1 - del.br_startoff;
>>   
>> -		if (!isrt || (flags & XFS_BMAPI_REMAP))
>> +		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
>>   			goto delete;
>>   
>> -		mod = xfs_rtb_to_rtxoff(mp,
>> -				del.br_startblock + del.br_blockcount);
>> +		if (isrt)
>> +			mod = xfs_rtb_to_rtxoff(mp,
>> +					del.br_startblock + del.br_blockcount);
>> +		else if (isforcealign)
>> +			mod = xfs_forcealign_extent_offset(ip,
>> +					del.br_startblock + del.br_blockcount);
> 
> There's got to be a cleaner way to do this.
> 
> We already know that either isrt or isforcealign must be set here,
> so there's no need for the "else if" construct.

right

> 
> Also, forcealign should take precedence over realtime, so that
> forcealign will work on realtime devices as well. I'd change this
> code to call a wrapper like:
> 
> 		mod = xfs_bunmapi_align(ip, del.br_startblock + del.br_blockcount);
> 
> static xfs_extlen_t
> xfs_bunmapi_align(
> 	struct xfs_inode	*ip,
> 	xfs_fsblock_t		bno)
> {
> 	if (!XFS_INODE_IS_REALTIME(ip)) {
> 		ASSERT(xfs_inode_has_forcealign(ip))
> 		if (is_power_of_2(ip->i_extsize))
> 			return bno & (ip->i_extsize - 1);
> 		return do_div(bno, ip->i_extsize);
> 	}
> 	return xfs_rtb_to_rtxoff(ip->i_mount, bno);
> }

ok, that's neater

Thanks,
John

