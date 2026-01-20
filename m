Return-Path: <linux-fsdevel+bounces-74733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOETOAP1b2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:34:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 529BD4C584
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9EBFAEE287
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C213A7832;
	Tue, 20 Jan 2026 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TxG47XBV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wkl8p2vF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD936E465;
	Tue, 20 Jan 2026 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942526; cv=fail; b=AhwBbliJe9dVsvTbQsNxKoL1sAsGue9vXAPRUGXi9hQaz9C91MeMe2CqpfYcS8shKbXgX3JwfpT4QUBkUQdZxI3tkrYN7AMlUdwlRcGuwBEqpQ3yrb3rWuKD5TUhJruksLWU+2MjnNx0VIeHwBt+SjBb20+WTxiiyQ8W6p4C1xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942526; c=relaxed/simple;
	bh=4aHhm49qAwA1C4oR2o/UdiV+9raFiF6DeRnK5hd/P+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uG3mBiIb211EKGMoHtno+0SKC+hMIPiTJBVME10SfJezTP8DBMnc4z5X3g/ypElVpj+xjXEYR3Rlv6y97FkD4q39b2XJuxauu+FFE9YDy6eeEmIG4V5zY1aQsGdLylBmlPtcta+HEqH40Z5WiR+YRdzPveiiY9ra63vI8+GdHBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TxG47XBV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wkl8p2vF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KITLfA3031067;
	Tue, 20 Jan 2026 20:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/lVkqjtMPYPvU6iWd/IO/5LhsNGjGeO5VfN5230pqu0=; b=
	TxG47XBVpcQIM/CBVhU8yhMRB1La4MdwyLqoVGjzol+D1o7K9FS2DaDDIQhnTE71
	LB+zztssGdxWeveZwFDZWcEqCnjkm7mswS45heg6eFtqjx4zhjkU6qrE66a1+ZRe
	YMGRcl3Yw67/LpPfnJCMi+xDhqaFZ+7CCsTJdsQ6J5l58btNCWc2pfh87O0Nlxls
	29wQQrJ/NUkmNUcqSJ0j9wqN1mH65uM4WtWTYlQD3w9N9tdbB2IdjCCaugb5R+5r
	UR+4Tx3TKhIQvwvl+NO/3wsAhMPg7KWVoBcG/6Q+N3ZbnIsGofbslcvw9JW2RDgR
	63Oyqup7cvG0n6xXqdQ3kg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vvged-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 20:55:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KKDhsu008511;
	Tue, 20 Jan 2026 20:55:10 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0va88rv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 20:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkPr2QnTvPBMQVaidPoa3jqBOooWsqsjSyMuOVQI8fjahgK5rLSUnHOz6Kl4lH1RD1Yd13Cy4R7zqK9ysnHcZwY5Rctf6IkLY2ajLOd9TyHfcOvKDtiUWDSpRQye+OJhJBwS71//rsK585MtLNzxE7XEnfOGd9SUJ4y4Cqs/CRJi/W382kY4ViVpxXeAt4pcrZ4W30JYfRzVHbUO6qk115j4p0glxn9J+b6PwzZziZHsVBO71ivj05KiUNBuFnofTib0o8F1BkHgkoQ7E5mXnVuixzPBURKtOgl3BbwF8FuW+Rpwi1ydavsT1PPzhtPFBra0Nur9UsDmfF7fFFDz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lVkqjtMPYPvU6iWd/IO/5LhsNGjGeO5VfN5230pqu0=;
 b=uZat0pr3zmMRZq3/IkBCjASHT+/fqAUC8LWOUvI1QS+ZjW0MK4P0YsuA5usT93Y2Ec9BQoYZksOqNHIjKyNhSrXrHetDm6my//EVugk2jRiTWVcLcr98QklHuZqdqqp6P28z9PLum4/g2rK5BwfiEYuL8VSUkIWgDzSpQVo46HvPQmtyL9PKxWhJxOezYMkvYRMqeXc+rk000WT5ovuStTJIjGXgIdvo3uKXBvyuMFk1EifJkq6Pmzbb1UMRbHxzKvEQXfc8Vm8+qp953Pg81UoNhpgbNJ/DEjBDx67FGpJqPy9LoE8UPt+tYON2vHPhfa8H7RgW/h2aSfgDKBsTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lVkqjtMPYPvU6iWd/IO/5LhsNGjGeO5VfN5230pqu0=;
 b=wkl8p2vFAIgEVNC2IFejcXbuvT4WeXVpzqrRoP4q2vRJSBl1jhOJdVP//brUhAt+62jDQmruHuutK8lL9DmxV6tWAaPZHZquj+HROxnDc5b6s5BIl0UViyQccre0B3pCh6Hz9KuCfrCVJEE9551KrFlJp+MVE1c84Ec1BIaJ6tY=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA0PR10MB7351.namprd10.prod.outlook.com (2603:10b6:208:3dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 20:55:03 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 20:55:03 +0000
Message-ID: <0f7c99a3-0768-40e7-8a0e-2b1ceadd5694@oracle.com>
Date: Tue, 20 Jan 2026 12:55:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260119174737.3619599-1-dai.ngo@oracle.com>
 <627f9faa-74b0-4028-9e52-0c1021e3500f@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <627f9faa-74b0-4028-9e52-0c1021e3500f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA0PR10MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: bac839f4-fb38-4d8e-848c-08de58662f21
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?c09rRkpTWUZBbTZ2VGphb0tMbnZ1NVptU1l1WFdIald3cllLd1AxUVN2THpr?=
 =?utf-8?B?TzdUZzFlUHJMQmFtOVRtcnB0eWE4cWErdXoxbDAzUk9QZlp4YW0zbmc2c2Ew?=
 =?utf-8?B?aERKSkQxcWFKUFBWYkZrQTAwSUZna1BiNUtiVzNUd0FQbE1Rckprd3J1RlNV?=
 =?utf-8?B?UFc4cFZLQ3BBQmhIVS9yTThxaGxVZjhnaXJKMlFFQXBza2pCTG5vcnlOalg2?=
 =?utf-8?B?MTVjc21GeVlEYVEvTFF1cndVbXRZb2dEa2htTllzcTF2MnJjWGp2ODRkZ2g3?=
 =?utf-8?B?VjI0VkJUY2w4VkVJRE5NVUJyTFppRURrYmp1cG5vQXk5Ty9GNnV0QWtGK1ZK?=
 =?utf-8?B?ZFRCdVhvOFhiZnA2U3BhT2I3bzlQSytHVHdIcVpweHk2QU55TEtrdW4yaHli?=
 =?utf-8?B?QXNWbzNlYUVkSVJCcG9jSmRjZHp3SXlxTzEzWFRMdElxSTZlc3UzYXM3UXhs?=
 =?utf-8?B?dDliWEJpaXRFZ0xvYTVPdTRNL0c4cmxLVHpVOEhhWnlQY2kyUHFoQ3Q0cTl3?=
 =?utf-8?B?ejE2eExIN1BMSkt0a1A0YzVuZ0luLzdRNXpFNzRWZEQ2ZktXVFdrNXp3WDMv?=
 =?utf-8?B?OURJeXhXbWZZeDVYRDJPQ3c4bDFyMjV4dmRleDBmNVVqL3NOM3lxTGdudWox?=
 =?utf-8?B?eTZ4dzZqelEvSzF0bXFTVWVqZEI0ZnE0UVg0QjVkQ0VGNndDaHUzeGhSZ3B0?=
 =?utf-8?B?UCt1ZFVKZjBMSnNiM2hiRUtlVFRzeWxpcHN5YUtxVjdRSUFmclh2TUU2ZXhi?=
 =?utf-8?B?U000WGNEbUoxNmYzU1N6emFXMDFyaitxM3B0Z1l2Z3NEYnRLaFBXcC8raUlD?=
 =?utf-8?B?V0NxR0lLaXVVcURBMzJCYmpKSlZ3ZSsxU1l2KzJHQUV3UlozS2VsVlhSc1Zo?=
 =?utf-8?B?MUVxRUk2RTdzdGUycHIwcjZxcDFtblVZVS9VSklrTWR4OFg5R1FKZlNOOEkr?=
 =?utf-8?B?ZlppZEZRdkt3RFNXRnhaYXl0TTFaTXlrai81Z2lVVEo1RzRUMlcrUEJMMkNB?=
 =?utf-8?B?NGNBTzNtVGpSY1JmbGo2YlFBRlJMSWgzRUZWUkNaT3JHK1ZyaGx3SkxvcGRz?=
 =?utf-8?B?bTRqRlA0R2FXc3J5dm1xQzNJM2hXUkc4UWsvbnZDQi95Y1dRNDN2SkZSNEg1?=
 =?utf-8?B?VkNRWk0xZ0lBNFgwd1EySm5seWZWanRSQlVKNVZzS2dpeE1pK3V3SnNlUGJ6?=
 =?utf-8?B?SDl0S2tsMVk1YmNGa0I2YTBZcThLclNWY3F6TnhWcGxjMGlWaW1LZVI3NXg5?=
 =?utf-8?B?WTNZSERwb1ZvbDdsblNJQmVWT0lvOWhDbGZwZEIrZzdNdnJScWNDVGxVckVQ?=
 =?utf-8?B?b0E1cDdLWFFpdkFhUmFaQmxSNm1vVWtUODdFT3ZhWllRRVJpRFhjd2tjR0ZJ?=
 =?utf-8?B?OVdGSmdXVW04djR3VTA0UDkzcjlXUk1hYmpOV3NQaTR0VlMwOUxkWmN0NmtW?=
 =?utf-8?B?RFE1d2J1bnRUZWRhcmdZSnJ0ZDNscXludHp4ZXEvUVo2clg5aTNJdmFoYkZN?=
 =?utf-8?B?a2wrc3NFOG85ZkxCeUY1RjdhSDloVXVHT0g1Z3lFS0k5dGl1MGxzbG5EUjRl?=
 =?utf-8?B?MTZxa1lvSFhmdjNuSmpoWjdNWXUwN0lWNDNqSENWQXVsdlpCbkFNNU9tK050?=
 =?utf-8?B?MTBlcjNoenhDQmF3YlZlcDVmOEhPVHQ3TmtQa2NOeWF1MDlYSG51MnJQZEJo?=
 =?utf-8?B?ZGhHRGpPV1FkekU0ZlJKbm83RGJ4YjNWa0JVMTQ3VGtsOHJLQ0JiMTVaZkky?=
 =?utf-8?B?YTNici9SRk8ySnJUbUpoMGNLdW9PV0pJd0dIZGsrN3VKTUxSZjRUNDBQdy9F?=
 =?utf-8?B?d3ZnQWxrSUZFZTcxS0x3M3FvVXVCcXlQTm5rRk03YWFVc1hUQjhneEJTdkxB?=
 =?utf-8?B?eElQRUN5bVlUUDdOWmpyL3dkYmtha0ppQzZ1enFTeDQ2S0x5R2lPN0gwUXhu?=
 =?utf-8?B?VythM1J5ejMyTDBWenZhaUVtNTVTSFlqSVhNMW9rOGhuSW9IK1VGc1NDaFRt?=
 =?utf-8?B?SkRNQ3FJYjZxbUkxSEx0Mk0vQTRFbXRVL2g5UCsrVXBReVU4T0V1d3JndnR6?=
 =?utf-8?B?Tm1YM0JVclA4dEREUTNIZUhvYTZCN3A2UmV1YXhtajU1UnY4cEdiQkh5NXJF?=
 =?utf-8?Q?cC10=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Unc5dU9yNklhRml6Tm9RUUZ1N1Z5MFN1V3ZJRnBybTlDbnZEQjNiRXhnK1Ex?=
 =?utf-8?B?RGVCM1YrbGZhajVldnRWWGljQjA5UUFwK1IyQWY2VlZUZWhKUTJ6a0U0a25Z?=
 =?utf-8?B?UUpHdS91YnB1VXlkN0lSZ0RvcWNnRlRFc2YwTjRGNVlFR29IRXMrdkdxRFBC?=
 =?utf-8?B?cUxCbCs0dUpWSkExT2tKdmZPb091R2ZYRFgxYU5nYURrU3RicjBFTXUzVWpu?=
 =?utf-8?B?KzhVQ24vWGtjZlNHSFpyaE9ieUhpcHkvWUkySEJOeEl3b0hSNHB4RXFpWU9y?=
 =?utf-8?B?T1BzWHhROWcvODBTamQ3WURUbW1zSmNnMnhuNnhIVWJ4ZnM5YWlQYm5iU1Rv?=
 =?utf-8?B?WTZyZ01DTWFlTSs3UWZmM2o4Zll0MnloY1N1dHBsM0I0aFNHSzcra0RkeC9q?=
 =?utf-8?B?dzQ1N0pMbDVSWU5xdmhnb3VnQ2swUkZhNzN4S1h2d0FoSExSaEhWL1M5M2Fm?=
 =?utf-8?B?b2NIc0RxVVpBclhNaDVmaDVOelczMWRCcTRUaVBoOWo4SjlvbXpzZmhjb1Nz?=
 =?utf-8?B?dTVLdkhxYkN5KzBIaVFWQU9aK21pYm9SQ0t2UWVFSWZwelBZa2w2QW9HUHNi?=
 =?utf-8?B?ZWV1WmVINENoOXgzVi9MblhUbzlaeGJzUFJuMjBTdU9ETmlIYWY0VWp3UlBD?=
 =?utf-8?B?RllXeHZkUUJRMWF6WGxjZlh2L2RZalorVHlTbXMySXJJQ1ljVDVXRzgvMlln?=
 =?utf-8?B?Y3RhazVOWUx3WHV5R3RGcXRNMVQ1RHk5NUQwcTA0TFpUWDV6QXdXeGlLaEtR?=
 =?utf-8?B?Z05YQ1oza0RPM3dnekFRRTVVZ3BlbkZvQVNaQWkrNG9lV0IyR1VuN2RRajU0?=
 =?utf-8?B?Ulo1NTFEejhnWElIL1IwSFFLckN2SVhpbkdLQlFDZE0wb2NZeEszOTQvcWdY?=
 =?utf-8?B?VVBNWWtKQW5aSDlTdC95MVQzTTVMZHVZdzlrY0lGdHR5NW9LRjkxYW9jcGVQ?=
 =?utf-8?B?Z0M4VWltVHNVTkdsNWQvN3F3WGo5c1BiSndhT0VGVlQzemRWd3N5ZEh0VTZM?=
 =?utf-8?B?c2lKMVowd0VGOUswalh3L015MTJ3WWJnM2E5WDhXR0lOVW5JMkwvcFdwTXZy?=
 =?utf-8?B?S1JlSEtDWVpUdEdBU0wyV3lJSzQ1b2ZWNVVhSGF4eFhSdHZZS3h3QW95SmFs?=
 =?utf-8?B?QUVYdE9LV0RnTWZMcFVIeGtHNHFRcFlUM0FyRTdaK1ExOFBJTmkwV0U1S01S?=
 =?utf-8?B?SFNPWnJQdnlLMnlyanNySlZzN2pyQ2EzQVZOSE56dGRmeWZ6bW1ER2hqemkx?=
 =?utf-8?B?RitHRjJKYXZHZU94OWI1ekhCcEtJS1VPWXYwblByUk5JaEtlSU9velJLYmJo?=
 =?utf-8?B?Y3dadUxlcTlBTzZyVXZueUdqaXJmOC9SK2tGTWFLZUpXakE2Yng0MlBZZmlG?=
 =?utf-8?B?UFhVM3ZQVjdkVTBnVHRhZ0QrMXFuQ2hDVkxjL2RxMFo2U2JFMTA0REhwcG83?=
 =?utf-8?B?TVNwZjdJQkRXK3FoZzFlaFN2U202Y29DL3MrWjEvQjJBY3RmUks0NEdOR2xM?=
 =?utf-8?B?NmJkK2ZIcXd0ZWp4ajdJTGIvTmU4ZVl6SXdpaVlvdEhWS3B3SlhVcHpOUVZz?=
 =?utf-8?B?WkUvV1V1cVdJY0dkYjJZZExldCthNTdoSE5ORnpMaDhRR29qaHBFT2t2ZTdS?=
 =?utf-8?B?YUVJOXJtYjZLUEc1eE1LVis5MEdlMjh0NmJ4a1pzVFV0UzFmR0txckpBdlA5?=
 =?utf-8?B?cVpJZ0F2OW0rZTBCQlI2ZGZzWExjSWpHclZBRjFrSWg2S0dpMWU0a0FDR0tG?=
 =?utf-8?B?T1ZKcmE3ZUpNS0huNW9keVVseXhWVzNtMnhVOEhsZW8rcEV5cnZFdXd5eTV6?=
 =?utf-8?B?RklNa0Z3by9lN2R3TkFha2duT1p0WGhlbCtGeEE2dk9NQlhhYnJUbXNzNVBs?=
 =?utf-8?B?aC9WT3ZTdFZMbUNOcm0rQitUTlhoRVZmVzFEWXlONWdvdXNrZVJxUGZ3M0lp?=
 =?utf-8?B?RmtGalUwMHVmcFByOTc5VUhJeU1CMHYzNG5xcFZvY2R5dmloWFhsR0xCOGhQ?=
 =?utf-8?B?TGdHR1N2MWwvSndaWEJ2ZFoyeE0wUVgyODFjb1NXWFFaYkcyVFBwdFo2UmVD?=
 =?utf-8?B?a2NBWjJJN2VvYW5xelRVaEIyZ0tSSWoxaFlyaEJ0MFhySlVPZDB1bm9MUkZ3?=
 =?utf-8?B?WjJTR3drc3ZFMG4wMUdRNGRUNy9kdlVTUXlXRkh0TTJVWHVCUDBxVkJjcXV5?=
 =?utf-8?B?RGlHUTBJSG5KZW1SQUtmY3hMNk9MZEhrRE5FV05Md1ZPQzFHTHJXOVpVUXJT?=
 =?utf-8?B?TmJTSjlOR1RUOEthMkppVmtBbXhGbHhZcm1ySkZSYlBlWkw2RnR2dFUwVld5?=
 =?utf-8?B?YWU3cGU5RFI5bFpoZ3lpdFA4OXFkd2JmazhMY3V4bzlteVBYVnUyUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QzjI7YF6pMi198Ot/dFh7trQNkJbU4LxsWBt0OTdAaZYhrJVlH4qZS2efX1LYSO6AM7S9MIHJxn3OG+1BKwCG0/KI8E1FVeX78EzZBfqMChFZMz7dwhIz0rH7RHv32ol1CcWcrLiQgOnfljFJTY/uZMRord4u+BMTKE1it0rJaHfTagalLeWFHrKGeN+k4IznK4lMWDo9nkFRIdzSOjlrpDHnW1rBw+mbahCxXOrZlevhteHrS+dkWwkY8PnZjxgFPG/Ymp19nTGAxRzkBq56W24ROjk2Y09tf8qUv5jmPqBZVK6q3A6IASmJWDKvOS0D8k7ruMWJr5SJPvbZFGehCF5u/udQjmQFXmPyT4AXfPy+iKyavUZLKgkA3VHfOd6fWhicBf1sSrRNpGVYCFLSTtLUeoc6hE5FNapZnh2fpHV3VADhAUSBjV0w9TEhI6VS8J4Asc3/NZjxsvcDa3u8XYUwAvJ3BGn95vyI6+rJxccGisTX2lkCwT4qdHCaP8DHZaim03w5DUwYH1nL6zXBHJ6sf3y9fIFSqGaqo2/m2Pk+8ASKSOTopKJ23eFRYOmDgVDJWyMGYOPQP68ks+IKINHQ986HfXqTJd6pzJGM4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac839f4-fb38-4d8e-848c-08de58662f21
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 20:55:03.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JDivEg8LVHbK2ggvOZO6dWAT4eM8BLKwjEubtY8Vmiu1vZsjujJ71J/Dq8bPLEtoNDKikj0phOTd+d5DZYJew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_05,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200176
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=696febaf cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=UtJrIc-ZVEozPGJJcHkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kot3SBmIGVdqxh8xMhnVnf-34NtY_2QL
X-Proofpoint-ORIG-GUID: kot3SBmIGVdqxh8xMhnVnf-34NtY_2QL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE3NSBTYWx0ZWRfXx8gotH28X68e
 gbMGSZGeVBdGikZl32HQYTvMDFMmx9CcKxBM8HZTlWFC6TWHJfpQpFardAHAE1V9Ndi+y8ESpsm
 Nsvi0WLYtbmjOzoizboa0bDLHXdeouZhAi9v3Px47V7DbXOI1ICBptxmdyXVO4cLURf/9b6aSM9
 V+GdbBR/LcVZC5rbEO4AZZrObcpa49XbLCNCGK4wJfGKmxASlPAiqSQna20BroQf3bshiouA6F6
 ICWs4lXbS5FBQbv0YZTXIlpbJ8KMHnB7RsJD8l3e8oW8IQIwwR95JmuhAX9Co98lR91x5SSp+Jc
 JbZxIRVbzPF5Xf57toZsVzNdV/kJMB9cugduORzn7m/sTcvwi2Hh+VSFGf22On9Mi32xYnlHfUw
 n58MPZQkyOwES17d7qOE2B4jMX/OteSgNuFFW/Armq6y+fIJ3h7JrhGyIWfEhGkLntyUcBiTiXx
 IrsQ+Jn8XKRDQSzJyrw==
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	TAGGED_FROM(0.00)[bounces-74733-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 529BD4C584
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[resend, I'm not sure why the first reply did not get to
  to the list after 3+ hrs]

On 1/20/26 7:19 AM, Chuck Lever wrote:
>
> On Mon, Jan 19, 2026, at 12:47 PM, Dai Ngo wrote:
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
>> ---
>>   Documentation/filesystems/locking.rst |  4 ++
>>   fs/locks.c                            | 29 +++++++++++-
>>   fs/nfsd/nfs4layouts.c                 | 65 +++++++++++++++++++++++++--
>>   include/linux/filelock.h              |  7 +++
>>   4 files changed, 100 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst
>> b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..ae9a1b207b95 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,8 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        void (*lm_breaker_timedout)(struct file_lease *);
>> +        bool (*lm_need_to_retry)(struct file_lease *, struct
>> file_lock_context *);
>>
>>   locking rules:
>>
>> @@ -417,6 +419,8 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     no              no                      yes
>> +lm_need_to_retry        yes             no                      no
>>   ======================	=============	=================	=========
>>
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..cd08642ab8bb 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -381,6 +381,14 @@ lease_dispose_list(struct list_head *dispose)
>>   	while (!list_empty(dispose)) {
>>   		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>   		list_del_init(&flc->flc_list);
>> +		if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
>> +			struct file_lease *fl;
>> +
>> +			fl = file_lease(flc);
>> +			if (fl->fl_lmops &&
>> +					fl->fl_lmops->lm_breaker_timedout)
>> +				fl->fl_lmops->lm_breaker_timedout(fl);
>> +		}
>>   		locks_free_lease(file_lease(flc));
>>   	}
>>   }
>> @@ -1531,8 +1539,10 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> +		if (past_time(fl->fl_break_time)) {
>>   			lease_modify(fl, F_UNLCK, dispose);
>> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>> +		}
>>   	}
>>   }
>>
>> @@ -1633,6 +1643,8 @@ int __break_lease(struct inode *inode, unsigned
>> int flags)
>>   	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
>>   		if (!leases_conflict(&fl->c, &new_fl->c))
>>   			continue;
>> +		if (new_fl->fl_lmops != fl->fl_lmops)
>> +			new_fl->fl_lmops = fl->fl_lmops;
>>   		if (want_write) {
>>   			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
>>   				continue;
>> @@ -1657,6 +1669,18 @@ int __break_lease(struct inode *inode, unsigned
>> int flags)
>>   		goto out;
>>   	}
>>
>> +	/*
>> +	 * Check whether the lease manager wants the operation
>> +	 * causing the conflict to be retried.
>> +	 */
>> +	if (new_fl->fl_lmops && new_fl->fl_lmops->lm_need_to_retry &&
>> +			new_fl->fl_lmops->lm_need_to_retry(new_fl, ctx)) {
>> +		trace_break_lease_noblock(inode, new_fl);
>> +		error = -ERESTARTSYS;
> -ERESTARTSYS is for syscall restart after signal delivery, which
> doesn't match up well with the semantics here. A better choice
> might be -EAGAIN or -EBUSY?

What we want here is for NFSD to return NFS4ERR_DELAY to the client.
Since EAGAIN is the same as EWOULDBLOCK, returning -EAGAIN would not
break out of the while loop in xfs_break_leased_layouts. Returning
-EBUSY is mapped to NFS4ERR_IO.

I don't like -ERESTARTSYS either but as how xfs_break_leased_layouts
currently is, there is no other choice.

>
>
>> +		goto out;
>> +	}
>> +	ctx->flc_in_conflict = true;
>> +
>>   restart:
>>   	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
>>   	break_time = fl->fl_break_time;
>> @@ -1693,6 +1717,9 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>   	spin_unlock(&ctx->flc_lock);
>>   	percpu_up_read(&file_rwsem);
>>   	lease_dispose_list(&dispose);
>> +	spin_lock(&ctx->flc_lock);
>> +	ctx->flc_in_conflict = false;
>> +	spin_unlock(&ctx->flc_lock);
> Unconditionally clearing flc_in_conflict here even though
> another thread, racing with this one, might have set it.

I don't see the race condition here, flc_in_conflict can only
be set after flc_in_conflict is cleared since while it is set,
other threads will return to caller with -ERESTARTSYS. All of
these are done under the flc_lock spin_lock.

>   So
> maybe this error flow should clear flc_in_conflict only
> if the current thread set it.

I think that what the current code does, unless I'm missing
something.

>
>
>>   free_lock:
>>   	locks_free_lease(new_fl);
>>   	return error;
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..e7777d6ee8d0 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -747,11 +747,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -782,10 +780,69 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>
>> +/**
>> + * nfsd_layout_breaker_timedout - The layout recall has timed out.
>> + * If the layout type supports fence operation then do it to stop
>> + * the client from accessing the block device.
>> + *
>> + * @fl: file to check
>> + *
>> + * Return value: None.
> "Return value: None" is unnecessary for a function returning void.

Remove in v2.

>
>
>> + */
>> +static void
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
> LAYOUTRETURN races with this timeout. Something needs to
> guarantee that @ls will remain valid for both racing
> threads, so this stateid probably needs an extra reference
> count bump somewhere.

The timeout value for layout recall is currently at 45 secs
so the chance for race condition between LAYOUTRETURN and
nfsd4_layout_lm_breaker_timedout is pretty slim. But I'll
look into this.

>
>
>> +	struct nfsd_file *nf;
>> +	u32 type;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf)
>> +		return;
>> +	type = ls->ls_layout_type;
>> +	if (nfsd4_layout_ops[type]->fence_client)
>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
>> +	nfsd_file_put(nf);
>> +}
>> +
>> +/**
>> + * nfsd4_layout_lm_conflict - Handle multiple conflicts in the same file.
>> + *
>> + * This function is called from __break_lease when a conflict occurs.
>> + * For layout conflicts on the same file, each conflict triggers a
>> + * layout  recall. Only the thread handling the first conflict needs
>> + * to remain in __break_lease to manage the timeout for these recalls;
>> + * subsequent threads should not wait in __break_lease.
>> + *
>> + * This is done to prevent excessive nfsd threads from becoming tied up
>> + * in __break_lease, which could hinder the server's ability to service
>> + * incoming requests.
>> + *
>> + * Return true if thread should not wait in __break_lease else return
>> + * false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_retry(struct file_lease *fl,
>> +				struct file_lock_context *ctx)
>> +{
>> +	struct svc_rqst *rqstp;
>> +
>> +	rqstp = nfsd_current_rqst();
>> +	if (!rqstp)
>> +		return false;
>> +	if ((fl->c.flc_flags & FL_LAYOUT) && ctx->flc_in_conflict)
>> +		return true;
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>> +	.lm_need_to_retry	= nfsd4_layout_lm_retry,
>>   };
>>
>>   int
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..6967af8b7fd2 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -17,6 +17,7 @@
>>   #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>>   #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>>   #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
>> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
>>
>>   #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>>
>> @@ -50,6 +51,9 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	void (*lm_breaker_timedout)(struct file_lease *fl);
>> +	bool (*lm_need_to_retry)(struct file_lease *fl,
>> +			struct file_lock_context *ctx);
> Instead of passing an "internal" structure out of the VFS
> locking layer, pass only what is needed, expressed as
> common C types (eg, "bool in_conflict").

Fix in v2.

>
>
>>   };
>>
>>   struct lock_manager {
>> @@ -145,6 +149,9 @@ struct file_lock_context {
>>   	struct list_head	flc_flock;
>>   	struct list_head	flc_posix;
>>   	struct list_head	flc_lease;
>> +
>> +	/* for FL_LAYOUT */
>> +	bool			flc_in_conflict;
> I'm not certain this is an appropriate spot for this
> new boolean. The comment needs more detail, too.

I will improve the comment in v2

> Maybe Jeff has some thoughts.I

I just saw Jeff's review.

Thanks,
-Dai


>
>
>>   };
>>
>>   #ifdef CONFIG_FILE_LOCKING
>> -- 
>> 2.47.3

