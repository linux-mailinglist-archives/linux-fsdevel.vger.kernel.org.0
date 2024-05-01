Return-Path: <linux-fsdevel+bounces-18422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CC68B88C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 12:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C249B2165C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B150055E5C;
	Wed,  1 May 2024 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LQkSxb1y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PVJpGju2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6034F881;
	Wed,  1 May 2024 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560574; cv=fail; b=lHytWHT59kkjLl4rBuyEPa4zOOoYemOdVMZtBsDZU+rZh/0pA0nVopXTSQIK8zpyX2lXaD5TaVArtLwjbvo4aPY1bn3e/bPfmm0QqzYl3BF1wqTVizgq3hwEXidXP8IwD69+7fJok8WvBB3ZrZZvrESaLMnEEnGHMfbeTd+N0do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560574; c=relaxed/simple;
	bh=sBmFsjgXyN5k55da/Hg78X1F1mrPhKT4QRjDeosAjcg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=unblW/seyOdydJuKW9UUh70TV79UPP4ifTTxq5kikQxLtAYIKfGo5NmF6PXmm4Ljh8WMTNkfjbtE/VpZr9DJT4z74ifJjzmVG9ByqUG+aIGaE+ZbOM7R6lk+0p2OK+NTMcP7ItCD+4EG2KiEs7yySehAHPAiH5Yc4OYa/M6840E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LQkSxb1y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PVJpGju2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441AT1aO007070;
	Wed, 1 May 2024 10:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=FopK+8Z1R7rG8o+mSadT4JybiZiqMogCUbyNSZorCH4=;
 b=LQkSxb1ydiCg9j/b9ec6VhD9y4Tn1/MHQWt6xWXajvrH+NNek3/jqM1pIZ1628+oYu99
 SZN6GLptvTYIOxCZmzEa0+b2tmgWjR316vlMGnvBCOuHHWaTdr0+W/ZBZtP9tjZV//uG
 NnSGQBMqR6h8uo48NpT4RRKd8hus0AIwTLODEAm4NkX0MA/kiXyzIkzyKJgu87kPoT8U
 UzFiueDtLRufyjLGgAkz4B9NbYHNf1qrF3NfBoUKDOSyd4jcFGAT8h/vpd8RiY5u8W9P
 aLp05CEy6qLPit53pqcjPbnNdh70X6bQogncQ9NNfGoI7n0iBVo9JZAZYQYvXC5GktJZ Mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdepykx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 10:49:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441A4IIG016709;
	Wed, 1 May 2024 10:49:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtf6bsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 10:49:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+6DO5a/DgyGt6KPhADZALOYSG9VsC3WGflvLXa9/vaEbtJBbeYEdrGl0Vc6a2Z+AelflMABNSsVEopqvq6zo9AN83nIySy9QSU8vUCIGl51SxixiIQ40uKk97s0OZasoTxGt8GPt5gPMVg/7b2Og68bnray/wO9OzUFXzHN8Q43Q1Ly/Y6Rz6xPAwccstaCAGcUWfZD+HzUvTa5DVldopqzU28TTX0t1148y09XZ2sbhfYdzK5LPbU7rKEfYIredpXf+nDwbS4Ah84GPJhub182M7ZnoLPpyPKp6kLhg4AmqHdDaqejJXTJSyV85RZijOdQFdxbBuWzJjpJP+Uz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FopK+8Z1R7rG8o+mSadT4JybiZiqMogCUbyNSZorCH4=;
 b=Vnb9D71aVsJotvKvXj4KzGdRvgqt7p9D9pnkoBdyE8DdNujvApmYSYUs6UI+eHZ5BBupw4bwp0qsPr3Yqoe4eckuWXgXJ3Sb/6xf4LCBZI4zW7a6NE6iYz32ROO4DwMurHe0t/zDdnJ7yGap7qy5w7eIKu5wC/e3WGBSlkERCdBMzM8u7ZRzhMVmH4viQy0Er4fcwD/YaMpKI9gCwD7lA2+PxBVO1NCzOvxPfM3FDQyKPCLPPgCnkpw+IrUa/PcTL/YletEU3IsLv98hUbokleQhhzxq3Nh3o1J/OB+hKh7y150RhatljF2YqrnAKebHwdSigRJrPZFg18QisyXLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FopK+8Z1R7rG8o+mSadT4JybiZiqMogCUbyNSZorCH4=;
 b=PVJpGju2PjzevRHENYse+Uqaa0dHIcgW1WA8wXaSTqzZVDMoqa+Wyo+qUAKyJaztf5htOXoz/n3VP1xS2dec7M8hgS7jLIHjVuPF0nIUVl22wYipByUErW5pcyFRwtz9Ou8D7qcMzs2HcYWkrfdobrlhwR+lh+faoHGtLaDerFQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6836.namprd10.prod.outlook.com (2603:10b6:610:14f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 10:49:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 10:49:06 +0000
Message-ID: <33700d9d-08d3-4fad-8ca4-e6beb3529bcb@oracle.com>
Date: Wed, 1 May 2024 11:48:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/21] xfs: Update xfs_is_falloc_aligned() mask for
 forcealign
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-11-john.g.garry@oracle.com>
 <ZjGAN8g3yqH01g1w@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjGAN8g3yqH01g1w@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0073.eurprd02.prod.outlook.com
 (2603:10a6:208:154::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b2f7c2-6a39-46a0-69b8-08dc69cc52cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RWY3Zk40Y3ZoaVA3SXR3eStvdyt1T0tkdVgzTDRVTnkxakVQNktVQ21vKzVH?=
 =?utf-8?B?RTBwaXlNTVNNemZteks2K09Gc29WUWs3S0wyZmdhdXdxeCtRQS83dGxLcnB2?=
 =?utf-8?B?R2tQR2pPQys2bzZjZFRYRjZUSURXWWtkU1JPWTVuMzhabGhqSGxvZGJmeE1k?=
 =?utf-8?B?ZU82UVJySGtodWJkbE8yNENpd2s0OWF4bW4vUlREYXh2ZUV0WXp5SmRld0Jt?=
 =?utf-8?B?TE9VakFadEdHZmUyQjBkOEwrY2xRbWxuVXJqT1hhNnl3Wk15MzNidmtOK0Ir?=
 =?utf-8?B?K2Z2OGgxdkEvSnE2YlpuZzJ1RGVRV0l3ajdaUDRob2NqTkxTSW9NcXBSMmpK?=
 =?utf-8?B?Q2FvdWJTL09IeGdtMU42czZCcElwSHFicGNPUVQ3TzM2NWNFclAvTzNIM3p4?=
 =?utf-8?B?VTVueEx4WXRMUVBOYjJhbGp4SGFrSk1pMlRNUmRlcWloeE1HK1NoQkx1U216?=
 =?utf-8?B?cUp4a1Y4YkVVZ3ZkVkNZTnVlVG1GZUhXWGkwM3RycWIvaVNRbWg3NVRTZkQy?=
 =?utf-8?B?SHpRbi90K0xCaUFHYk9kZU5vTjczR05tcy9EOUdmdDM0QlNCQ1B5YXJpdkxi?=
 =?utf-8?B?d1U5eUhPSUZmQ1dSY2ZzVklTbHBuRWN0bHRjUHROUTdXZXEvQ2h4Q24vWkNF?=
 =?utf-8?B?TE53enovcW1BNU91YUhDQlgzVjVsalVzeTc2K0NWQzM3L21xd3g5UEJlaFE3?=
 =?utf-8?B?TmlGTVVEd1MwekRZcGNhRElxSWhadkZGQURYaTBsR0pNZmMrTTFpNmpCYUps?=
 =?utf-8?B?dWYyRWpmVXBmYmRKYmpvdzZBRjFuWTJ2bHNabVBNaXIveXBKSjhSc0RFdzds?=
 =?utf-8?B?UGN5amU1aExoTUM2S2w3eUxBY0dZb2F3REl1UkVZUzhuaVZCQmlmUlBrcE1Z?=
 =?utf-8?B?NzhmUHNPZGZBYmc4Q3NUTDlUY2xrZC80Y2pYb3ZEVlJZZUUxQWpHd2hnOG80?=
 =?utf-8?B?d2JST2pXM2VNcStONmd5eVZWRW9Belp2ZkxvTjE0SkQrSUpTL0k3YW5pWEE0?=
 =?utf-8?B?WElaK0I3cWczS3FEVjBmS2tRdEdmNzloSjNBQmQzbnplSG9pRC94VURxc0g5?=
 =?utf-8?B?NDhMMG05Z3BkVkJSR3VsR2JWek9Ic0tsQXhhdzF2VlFnVVFoZytGSHA0TWht?=
 =?utf-8?B?YmNzODJBMVdWamxGRDMvTlhSVmdmWFlyVHlSMFg2UE9zMW9jRVQwZUl0aWJ3?=
 =?utf-8?B?ZktDT0xOWFppTE54R2t6Zi9TMWZEa3B3WUY3SndNeTZTQUVINzVYcXhpUGlr?=
 =?utf-8?B?bG9XZm5mN3lmeHBPb1JZUnMzMGJGaVF6aXBNYnFWaEw1SlRIbk5XelVWOU13?=
 =?utf-8?B?VlhqTTMwOWJBQk5EekJpa1ZBaVBiRVRISkx2aXJtWnlGQzk3d3ZGdXpBMk9j?=
 =?utf-8?B?Y2pTSk9ndjNZS3JMY1dLbUlhWStFQWtZVDR5V1kwcWNMcnVUOUVQTmVLVmJG?=
 =?utf-8?B?Y241TjR6amhrSEZDWUhFL0pvYVdBUE41UmtPTnlaTU55YVM1a2hZM252RXpo?=
 =?utf-8?B?emFyd1ZtVDBsUFZRd1BYWXhpSXVlaEprcjBBMGVPUHNaVS9ucUM1SHBhdUxx?=
 =?utf-8?B?bytLMVo1R3lXa1N1L21za0pFM3E3WG9uUGdPdlh1d1lXUEZVb3hkOHlhdkVw?=
 =?utf-8?B?SjUycXM1UHZjODVVNElvWDhKTVFpaHdESFVWUTRXamtOU1Z2TGxTRmErR1lx?=
 =?utf-8?B?djlLWnB0cjRBa0U1TjdZMUZIQkNlN1REYlhCS0g5OHRYSytMUUVRNGJ3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVVGdEExaU1PajBlZU8xUzZySk1JWGFjaGo5bEJlN0VuR1FMTnp0OXg5VXlT?=
 =?utf-8?B?YWdYdTJudFdEMGt5UVpGd0M5LzJ1WXN0dTNXQVpHdTliRzVSbzhFalFEUms0?=
 =?utf-8?B?a0FBM3BYSXAxTU1WZkV0bG1JbFpUWlFSNHFqQ1hWSmRJSC92WEMyTUlzNlRV?=
 =?utf-8?B?bzg2T3FvMUdwZU5uK1ZaaGYwSzZvTFV4SE9WWFJzOFMrVm9aU2gwZUlWcExF?=
 =?utf-8?B?S0ZXN0YyY2NPaG9JQ3NIelZ5dnYya2w0alBYUjVTZVZaSEZGVFgzRGNQVXNC?=
 =?utf-8?B?UFZsWFpoVEtxemtjSEVmZmxiMW0yUUNCY3R2amZ2TnBlQnM5c0pIYWMxSG9N?=
 =?utf-8?B?bmNmYkFCK1M3YytGaTBGT0FmK08wcmJqaWI3U05pQ1kzUzdwMHNWTktxdCsv?=
 =?utf-8?B?YVF3VEZFRi9nK003Z3JMa1FnMFpsWWlobThrdFFRcDU3VzhVOUJXSmtrYUlR?=
 =?utf-8?B?MkIyNVBJUUpDaHlXVkcrc3pCSFA0ZUNGb3NUdFFyV1ZtOXF5czNGQUt1emdK?=
 =?utf-8?B?L1BXZEk2cVpyQVNVWGFVTXFjeWNkZUxvSGpUSWdhTVRuck5iRFl4T0NBZm1S?=
 =?utf-8?B?ZFVWeGhoUERqcWdTQUVxaWVwWllFaUJSMEtQQWhuVEpDbzc5K2tkb1UrNW1M?=
 =?utf-8?B?Z1NDMDJqakVJVUpTVkVlSytjdjNwYk10TWM2R2NySG1zbStkNkt1Y3VFUDN0?=
 =?utf-8?B?MWZLWXUzaUMvdmxaUGFCOXpuaHBYY3JaWDFCN1krY2EvYU9hWWttTExyNUxT?=
 =?utf-8?B?K0hYUkY5WEdBS2U2d3ZaUTVqV3ZzVDhUdzZhQmRZanV2aXpFYW9HbWR1VkdB?=
 =?utf-8?B?WlJaZDZXYnVvWjlHQUlKdWhZckVKWnBESFErZ2xyd1NvZ1hLck52MldzdjRJ?=
 =?utf-8?B?Z3RGZ1B4V0I1ckdVVHNTbEJDL2VlRG1vUjlMZDVMN1g1ZytXQS9ZSmtsRUZM?=
 =?utf-8?B?dlZsL0FWODZOdUpxTjBpUmc5am1sUXhqS0ViWm1DMWZDM2FYSVNoc3hyZEJz?=
 =?utf-8?B?eWVWZEFkcy9rVXFSRFJ4dHVVbi9uQ21QZDZ3dVFQMDhPeXQ3WHd3bG1LWHNS?=
 =?utf-8?B?MTEzOG42b1h4Mk15d0VaTEd5ODBzTHpabE1na0Jvd1d4Z1hKYm52VjVRR0ty?=
 =?utf-8?B?aHlzTTF2K1NVaE8zaFl2Y3l3amhrT0hJTzhnMkpyTDdvZHgyZ05ZMDNuTnlC?=
 =?utf-8?B?ckFFWG9COXdEd1RMZlBENkx0RHhrVzNJZGV6NWMvLzVpUnJ6aVVBVUN1aGJr?=
 =?utf-8?B?ZllaQ0NzQ1BjeEp2ZHE1QnNEVzdhMW9TaDJwUkJrUThZNFZQM3BXdjFLM3Ez?=
 =?utf-8?B?RFQ4ODErUlptZ0RJZ21ZVzJIdUxZVXJDcUhEdjdlSFRVaEU1eTU2aEs2V0Fu?=
 =?utf-8?B?eWZhMG94L1l2NnZEZHY2dlVMRGhxcnBCWEVYcGdod2tpUVlFcTdsemV6SHY0?=
 =?utf-8?B?YnJhSDAyMnFVazFxRHBHQy9LNklEUGhtYU84VzVJMTJsU2RtWTFSUE5sNG9m?=
 =?utf-8?B?aE9uVGFrV25qeHhqODRhclFQVk1UKzNJSDRENmgya1RLcm5DWGU5dmtIeHVC?=
 =?utf-8?B?amljUlc2NVFEcW5HMmdWeVIyL2JwNlhyejFvYndBN01Ba2diWTZWNDhVOGZR?=
 =?utf-8?B?M3J5MVJZcndXbVRodzdmN2xPQ1lRaGpORG5VYUN0bzlleGZyS1hoQ2lBQitn?=
 =?utf-8?B?N0lCamUyMDNJb3pObm5CSGtUTGpxSjVYbHh3OVJiUG1MQ3NaNFdNWTg5ZnNL?=
 =?utf-8?B?b2xPWDJCaEtxMjE0TkhXWHlqU3pQbVBuY1NKS3l3RExYdVdRQUY1NDMyMkp5?=
 =?utf-8?B?RWliMXRUQnpaY0c2OGxiQXFMNE5GMkMvV1pHcEMreXZqWW4xYkovdnFjalA3?=
 =?utf-8?B?TmhLZ0FQZVRuRFVRZmowdk45ME9KeDNQUzBPQW9RNmpvNW5lRGRMeHo4bHEy?=
 =?utf-8?B?S3FvNjBpRG1JNnlLZTZjZ25Bd1VuSmlVdlA5anFJdWtLQmVhRlQrU3FDQXFF?=
 =?utf-8?B?Sy8xTko5S0pqbjJZRGJnZmtQckpDUlcrVWRVaE41aktIU1N5N2tLSWNhVGZy?=
 =?utf-8?B?WVhBZi9VdmtDV2krM1ltSjh4OGdSN1dzSUltUzVnSUc5MElLdVRyWUY4WVM0?=
 =?utf-8?B?Vi9MUjdyVjZPMitjMWlGb2RPcjNqOUdtRmxoVnA2Ynp0NExiMGM1YXJEQ1lI?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1cJSl3UIWEiFf2HebMjQ3zVs/OoN0R6Q4Y078G8r+CQju0c/mVkK/oZkDYnlz2Ygt3qyiJw6nBRw8914SHU3DsSxtAey1mW1lZ+wMLoBDVISSP3knFUQ7ByMtBA/1ZXrs+omfR0Fv/zt4ZFQndYCE+j82VLSPniZgm0gUmea7JDBEScVrI1wV0s9n0kg3zM76uSYYAbLretLrWuNEBXX+j7bL6BkvgD0ZSf++hyaqJ7JfwQI2wIH9rzFqcC8cEmTT/iFpb5wYcDpOwmfvoSkt/a0qPLYao64xl852WvGHi+s1kqtANtt4wFcw+q9kXnNB5TYsNkR3Wyklwx3UItb6pYfJxMkRacU0hbDRwUILAAUYJQ0b5nM1wY0lMAKdYsdi9rNFgCj8h6x1K353XFrdyq2A8JhIrosSV+Kii440p4ln/VTNkgTWgFtAghAM+qyXsSclpoPZFczIYxTIcuRz+cCBlnN9NyyXuVcYJ23pL12dAoCuwAFI10GUM5trykirgYTNn0fP1vdyOhfbUaBWKgZWXKL6krx3oNE9mIxLpte9o9dfOWOiD+IZEWlKd2ilEFCD67dramukVatgskzFMWmFEKYPlT6eiX9YOnvvvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b2f7c2-6a39-46a0-69b8-08dc69cc52cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 10:49:06.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuN5nQU/xiOr2SL1PmtrxIJImljG/cTo2XXhMsnjXl6uXb0shE5xDwVnYFNoFGqUZIW7zyGRXxF9CJ2ndoRCVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010076
X-Proofpoint-GUID: jZIMQilDrOGMUVTS6TFK0jYrmKe-hTAw
X-Proofpoint-ORIG-GUID: jZIMQilDrOGMUVTS6TFK0jYrmKe-hTAw

On 01/05/2024 00:35, Dave Chinner wrote:
>>   	return !((pos | len) & mask);
> I think this whole function needs to be rewritten so that
> non-power-of-2 extent sizes are supported on both devices properly.
> 
> 	xfs_extlen_t	fsbs = 1;
> 	u64		bytes;
> 	u32		mod;
> 
> 	if (xfs_inode_has_forcealign(ip))
> 		fsbs = ip->i_extsize;
> 	else if (XFS_IS_REALTIME_INODE(ip))
> 		fsbs = mp->m_sb.sb_rextsize;
> 
> 	bytes = XFS_FSB_TO_B(mp, fsbs);
> 	if (is_power_of_2(fsbs))
> 		return !((pos | len) & (bytes - 1));
> 
> 	div_u64_rem(pos, bytes, &mod);
> 	if (mod)
> 		return false;
> 	div_u64_rem(len, bytes, &mod);
> 	return mod == 0;

ok, but I still have a doubt about non-power-of-2 forcealign extsize 
support.

Thanks,
John

