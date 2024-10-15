Return-Path: <linux-fsdevel+bounces-31972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE099E9B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1D71C21F5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171D1EF927;
	Tue, 15 Oct 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBSrNy/7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EjF8HPuB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D71EF0A1;
	Tue, 15 Oct 2024 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995134; cv=fail; b=nAu+LS2TehO/Gwj5KO2LhpW+Zj3Tf/HxMFg/SmscO5EOJ7SkKtdyFLreQOwy8YP0tLJ/Zz2JLkUHDKSKyWcxgZK47prIY1aDZZW5rUxsTCU6YmXQqNhRjJUgqiwj4460/Jvdeh5Wpt/zVHI4Ky/5+XJgGOxwV7u6evf2ErMexe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995134; c=relaxed/simple;
	bh=g0dd0Zp1TzCXg+YyuZK6r2cAn+3mtVIh9akW/t/KJz4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lW78WgxVrI+Yt9TLlqNM3AontwSR5NAd1GKcpgPAl0LOmfmN52hesClHUBx4hu8SUTyFWKnjZ5dJvb1QgDDetHe3p69YIXHpYMaySvWVC/+mCI7nVCaEE26dkMAEGrHCD7C7ajahyJMcemllRdKiq2rCPrsVZNVDY2i+zautzr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kBSrNy/7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EjF8HPuB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAFLBS029379;
	Tue, 15 Oct 2024 12:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZvSqYs6apzakphDIHw6G38f3wKT8g5MjYxtMNo72nGU=; b=
	kBSrNy/7AjzKoRs6TwbaDN1adtmHAbFZmKdyp1KVWfarKh5L2v2E0eL72epETUEj
	UGwbDDbxq1Tpa8VLY9RcsuqjoYEsdVbsFZVMiUqdaHSZbAcxZtNnhhV8DllaxJeK
	1W+Nl8YR/xSWLm8HnOrrlLwpnq8sW0dXVbk2Lpya4EHA0zoFwN7YczwAOVbVb8dw
	U5XOZl47K3ionV8wkFO0zNEqjIH4KYWh8Sm7oEHioWDQK/ddBITVWUDPD2wxg+CH
	SWdJvY7Dx3FtNaq5Bz+/gje804EHGmulrojiiTIA78VznDf5qmcswqfB07J7GKKQ
	G8Ri4yZh2tCZCeh0A+rqfQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnt90ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 12:25:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBHSLC027261;
	Tue, 15 Oct 2024 12:25:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjdw2gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 12:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK+/cV2l9Mr1DjIdTtC9l54T4wfjGgQ4HEDUiXWyP3cguvq6sMpn0aoTxzWhs/htu9ngiF6xRb85B7X4asE4oi6UKx5WybVNlG3thUSBK4CxsR2EIjaDz4DXWoddp36BumNaVTJkwhO9bXH8Kt2UrxPFlCEtbPT08mXkhvrY7SxkoBm7ok12XL+60k5ZNVb0gfKlt/aesVxCMnbt9KcL7EIrRrARU9tr5gH9aMTXQ2WsIDZkZMKcj6dKTLk4Q7nOJeNnVdHkgTsvyb+TauzndR+kBAWn94KFiCagI+AW3nK03Vgr2zc11yt3idge8zjqpzzKeMpbNDLC+83wCIE27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvSqYs6apzakphDIHw6G38f3wKT8g5MjYxtMNo72nGU=;
 b=B2zO7Gb/5PHqDx4Oktlp01yJps9ala6zif3grwtnGBVrYOe1o6apwWiMwlSzXTbC7gC0AtWMcoghYqD1NWd+uSEHgnEUuAyIGUz4Af0ptkPLsfi4bbJX0+/gpdBh4t/OjDVlZ9WgOMJdfbc1DGMiKTcs+312dWV9h6GsETOA56qefKyj+XZ1bwmTy8L+dUiY/W31UUh8Eca8vKeyd5ML5SwzD12EK8XAuQyZ1ZKc+3Y/rOKb8EA54Yu3EsbnRJmOGUkkIzqI22pqVwP/Y3Ret+JRIBEl9qcA+dy3wSCI76wbVtI/NfsGwuxd9QtRFfTZjbmFno57rNMl5NCB+MaBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvSqYs6apzakphDIHw6G38f3wKT8g5MjYxtMNo72nGU=;
 b=EjF8HPuB0vHmqTiWtjc/FrWFOKg2ovwdDe6CwkGu4YZnm/88jEBuNos18FYQXGbUQL5jYWtfXAo5FlUABdSGq5nxY2lcEFaAvsAumpElNlmq3Xy7ZCWAoa/kELvpkzT5nyGtRjVcv3ZX4UOgJxH3NXc/SiAER2WwM9YLis4yZTA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5095.namprd10.prod.outlook.com (2603:10b6:408:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 12:25:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 12:25:12 +0000
Message-ID: <426dae12-3f15-4097-bf83-fd50007a98bd@oracle.com>
Date: Tue, 15 Oct 2024 13:25:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/7] xfs: Validate atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
        cem@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241015090142.3189518-1-john.g.garry@oracle.com>
 <20241015090142.3189518-7-john.g.garry@oracle.com>
 <20241015121637.GC32583@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241015121637.GC32583@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d16c32-8a21-4129-17f2-08dced146ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWpscHZlOFRYMThWM1plMkg3dzdqaVV6aGlHZFVodTRtN1dDWi9zaXJwWCs0?=
 =?utf-8?B?SWwyY08zK0JPU21tK0RINWV5WThBL3VnQW81RS9PSU1wQ0JZL2ltb1FTeExl?=
 =?utf-8?B?b1hkdW5DL3EwRWpaeE9CNFBVaFFTNExLcXB0ZzJPRG9KNTc0R0Q0UGUzTXdJ?=
 =?utf-8?B?d25JZ2R4VE1LTGh1dzVodlNhM213d0pRL3BLK29HOXp1VWN1MXl3b3ZteExN?=
 =?utf-8?B?ZjRZR0Z2N1pYYSsyY2d1VkZNdUN5cTdLYkhGVkU3WHovZ0FNK0FSSUdmU2xE?=
 =?utf-8?B?ejVTdXNzVUV0aHBrNXErSzc1ZjlocUVUSS81UkNuQms3c0d2ZjNPNFZxZjVy?=
 =?utf-8?B?ZURCMlZaWjcwaXhyZ3FxWlV1R3d0NzkvS0tjR0J1TUJCaTIyaldsbVFxcE91?=
 =?utf-8?B?T0NIbGxFOGFKbGMyUVJGNHhQWThRQlVCRERoN3RodGJBR0s1THAwczQ0T3FP?=
 =?utf-8?B?aWFQYzlaOWNrcGtCVW1NMkZvMFBIeEtPMGZrOEtzbldVOHJLUzJEa3ZJbGhz?=
 =?utf-8?B?VW8rbm8zSSs3OTA3dUtRbVdZTitPRlIvVmg2N1BmRXU5Mkw2OFBuOGQ2U3NB?=
 =?utf-8?B?dGV6MjR1elR2TXhmV3A1Qlh1MFQzV0tSWGg3OVBnZjFLNW9QdlFxT3F0Yldm?=
 =?utf-8?B?QkcyUGRzZ3M5cmVQTm9NQlZkNlhxNnovZXh6Z1ppN3VNek1qNWVCTDByVG5G?=
 =?utf-8?B?cElLTCtlR1EyRnlQb1JRYXlTVG9RV0RwekRzQWdtN1FUd3NJakJGTi96aGxF?=
 =?utf-8?B?SzB0T1hSNTR2aUp6eGFGS04wZ1VFQjBJZ1ExOFhvWFhDZnJSaEE4bWZiVGsr?=
 =?utf-8?B?Sll5MFl4TGxWSTdXZ1dsZlFZVWJvZjVaaW5UOHFkSWdoZER0M2pUWEYxTzg5?=
 =?utf-8?B?YXFHWit6cm1nclNKRzVBMG1LalB0MzA0Uy9NVzdDa0w5eE9yRzNvZmlzTUxu?=
 =?utf-8?B?RVpHYWlURC8za2x6a3lkL3djaGlIMTk0Ymd5VWJ1aElQdHFpTGVGdjFIdkg1?=
 =?utf-8?B?V2FVYkM0RitRUnFETVQyZFVKM1pCbUdDMjB5ZzdxS2phL1hPTElia2JhSlZu?=
 =?utf-8?B?cTE2SzdMbVgxM0dLNlFCQTdEMVdlVGdDakw5NU5STVN0TDN5WGgyNWdIb1Fn?=
 =?utf-8?B?WGlmY0xxeVBQL1EzN25aRFZtUUJRSGhHeVpGRmNubG9XVkRCMDRZOXRHZWFJ?=
 =?utf-8?B?alNzbFRPb3pDd05EYXpUUS9rK1M0cHl1RkdIbTlmODAzNk9KMjlCUU4wU3FE?=
 =?utf-8?B?NGpqa1RsanRLa1pHckxyZ0ZRam9pNC9yeDltYkV1RllmQ3RaTlFUN3Z3MHN5?=
 =?utf-8?B?TWJ1TC9mbCtpdWIrWW5Hb0xVSFRkMURqeTF0K013S2xnSFoyZVVBejJ4R3gv?=
 =?utf-8?B?Z0tFZkVjOEVZbzJRb3hpWVlPbGNCVml5WnFiVy92MlNjNHdtbmR0V2Y2SElo?=
 =?utf-8?B?U2Vzc2JuN3NzMk45VkVIVHk0b1V0UDlDWWlXaytoajFvZmF3NEZuSDFsOVNB?=
 =?utf-8?B?ZVJiamQxZXZ5REdmYWtBTFZpSTZOSllmV0MzYlhnVXV3Y3lhSVZGbGVFMitE?=
 =?utf-8?B?a2RLd2FrMHQvMVRubFV1UnlpS2IvVDdqUlRsMjJzb0lRNkoxNFJJSjlZTndC?=
 =?utf-8?B?enB3QXdFd1ZXOTBuVUtNOTBYRy93VEcvTUJtYmxnekZCM0NPY082N050dlpH?=
 =?utf-8?B?VEs0RDhoYXkyZ28wUjZzM0dRYytQbEU0T1B5TFpvUStjblg3cnpweGJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alhNLzNHNlVma2JNbjkwbUlkN3Ywd3gyTitUcHFtTE9QVkNubjJ0SWJ4c2pF?=
 =?utf-8?B?c0pqYVJhTzhNdVRKYnN1dGpCeEh1K3ZxYnVQMmlXMGxPcm4xTTE4cHN2ZkZN?=
 =?utf-8?B?clBOQ3A0SFJSbW13TXdIdnhwYUZheklYMmRQK3hOZUFZWGxEM1QrUzdjM3Nz?=
 =?utf-8?B?YWl5a2s2YXdpYi9SUHZrWGNXR1dIQ01KeXd4TE9sOCt3cHBvbnN4V2ZZSWtS?=
 =?utf-8?B?SGNRc0tWc1lnSXVBdDgrWVN0UEw3Q3FNRzU0WittMW1pYkVKak1QN3ByTU9I?=
 =?utf-8?B?RGNVODBvNUc1Y2Z3alRhMkorMXQ0Y1JuUGlhTWsyMS8xOHNJdkxrRm0ybWd5?=
 =?utf-8?B?SU1vWTZlZzdPN0FVQU5XUzZiQzRhQllSUjA1dVRTOWF3V1UvQ3FJSEtETXpt?=
 =?utf-8?B?NmE2VEFsV3pJUE8xQm54QVJrc1VSdjAyZ2NkaUlLTWR6UEZCQ04rSjNEWGY3?=
 =?utf-8?B?MkxoeUFnSFZ0STRVQ1BGUmFuOTQ1ai9XaVhNZDM2dXkvMitLUmsrTUhzY0pD?=
 =?utf-8?B?R2V6ZE1ZS3ZheVVGWDI3a0ZMaVF1U2ZBS1B3REprRXpkbmNIWW5UclFrTTZx?=
 =?utf-8?B?YVFPOEhNWGhWa1hTSFBCbG0yMGJHOGpQclZMMWlRUzFSUTdNVmk5bnFtU3Vv?=
 =?utf-8?B?bGw1RHFxcENhYSs0WG02T05Hd0tqc2hnQ3VFSWhTSElteHFQeDNmTHNMdHIw?=
 =?utf-8?B?TThURTlSTXdTbXJ2Q0ZiRWxzbzVXcTBON1hoMG8yOTkrdnhjd0N3UUNFYUxW?=
 =?utf-8?B?SmNBQmVYWHAvQmNReVh0LytyMG9tMGV3WHFaZVJnUUNpYWRjeEo2TTA2Nkp3?=
 =?utf-8?B?ZTBwbm5Rekl5bnpxYk5oWHRIK0svcmZyM2dyTW15eDFoTjRSVkloTGRkc3NH?=
 =?utf-8?B?RjBSSFBMa1U2S3A3bC9PMVF6RlFBK1huQi9SUEFHaEIwcDhVd2hnbkNHRkts?=
 =?utf-8?B?SkVtRFVjbHFSU0d2MWJRc2tOVEh5b2IxLzE5M2RZWTVnaU4wb0RydVlsVWs5?=
 =?utf-8?B?VXdkZHYzSWd3bGhoUm80aWNrcTZjWnowbU52ZWRlYjlZRGV0cEF1ZkVHV3FT?=
 =?utf-8?B?Q0Z6SGUwUlhWS042c25QOExEVGtDaGh1Zm9BR0FRVU1yd3A1RC9kMndYZFJj?=
 =?utf-8?B?dVZwVUY2R2RXRkxUalJremk3OEVBblUxckIzLzVFNzA0MWI3UFJROWNyeWNJ?=
 =?utf-8?B?WkhhTEk1NVFXckF3SlRXbHZLSnYxdGVxazVOZWpvcUhTcWFjWjNnbDIrNkIw?=
 =?utf-8?B?aFRncE8ybnNNZ3BKU3Mwa2xDR2hsSWhSdm84a0grK1NVY2pMVXdiQ2lnMkpr?=
 =?utf-8?B?Mm1kQ0daNlVKdy9QTTBsUVhnQi9ocEtMZGcza2hXNDBWYmNOc0FLVy9yRHlG?=
 =?utf-8?B?blVIbHhWcnhMc1VjRVdsVzh0NXg3dnU5SUxnbHh1U01YSzVzNTYvZGVyNjBK?=
 =?utf-8?B?OFlVNzdtdmUyRFhBOENhSFd5OUxhWkNvdlZpYmtTSEQ4NnJoNmJzdDNUclR6?=
 =?utf-8?B?M0dyNWpnMHVHWEh2SzlLYUx4ckRDVVlSK2NYYXdsYVc3cUs5b2o5azdpbUtm?=
 =?utf-8?B?RjBFcEsyaExFY1ZERjh4bkg3eTBsbFFuc2ZkaG5XeEpLbGhRZThERWpoSU8r?=
 =?utf-8?B?T2EvU2J1TXdySUY5S0VlakNSS2xHdktFV3BTQVJGeThIVEk5bzBFZTlSWGtt?=
 =?utf-8?B?VmJKckIya3F3dkNWMHIwczZhWmc0UG9EWG5kYnhlb0FkN09GWW9mT0ZpTGRP?=
 =?utf-8?B?V3Y4M2s3TCtaOHNPM3ZxcXNiWHdrWDRlV1RwazVSbERlODJsR1grOThuZkpv?=
 =?utf-8?B?VkFZSkNYd1MxV3ZKeEw2TUk4aWV2T2hxUTlwQ1BLRUI5ajAzTE5hUHhIZ3gy?=
 =?utf-8?B?VmtJa3pWaGIxZTdGZmc5MkFQdWtjaEJBR0pzMHJ2anBCU3plTDllMVAyaXBJ?=
 =?utf-8?B?YjVyWmFFSHhHSzlLMTNmdDJvLzRvRTBPL0d1Wlg5cDVxWjhRR1NRWmI5c3M4?=
 =?utf-8?B?V29VeUEyejhydnFzeE1jbGV1TGR1M1ZndTRIaVNqNk1RSDJtUUhrR1QxZmRC?=
 =?utf-8?B?Yk5hWTlvalAyMDJ2ZVRMME1xbGphT0dQRytGeVdad1JndmFSZDlWVFNtT21N?=
 =?utf-8?B?VmNzOS9VRmxyZ2V1amJ2REVicTQybCs5OXFNNlNQRXhISzJ3Qk1lQWhnTm05?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l7NrsdMQsskZazivxEJpwhaP9betqLTdRGoJ1LaxYyz4GINsw3XEcIp8RG4EWz/1XKFaJLz6pG539My9sWOfoitjGrNofL7pU+h2IO4quEwNO3mFquT/Blbsn+Payj5+ItFXHR1Vs+hw0SolA6ZZm0rmbiEYRO7Mp9880VUoJs9pgK1DGYc7ghgCeUfuDYXXYFXloin6E0XqHI9zCRIuJDHmAbAranS6mgZ1PR3lQYC4KrFkssKLrd/+FAESvRm7oHTHx81bVHd0EbERvLL84g8cgxeRGrOBlJnYdpXBSEpge410iCLOeY4Rjrt3rqn2YE7m74ALr2zGieRp+DeP8OUduBx/lD8VLB2g19ykmaEC8dgkkiyDIiV8B+jVISkinjx5G6OofYGrNnmqhsyO9G8mRxcG9z3tRd/X9pnSDSFwntHWwWBMzZI+UczKoXy7IUOh5je7V2mnh/H2snKINa+QHVtx3+ldJXvuAHtKJShGvI0lngv+7hEHR6XUD4WgJkNjC84hFBkID4wEcOtx6fvLQTaVbxBYYS1VMPuNMbyL2fewrm6RYIhyXpvil+Wc6g+9MXhswvFnYVbK3Y8TyMTu6kEoPRJGKonJzzfRDDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d16c32-8a21-4129-17f2-08dced146ad1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 12:25:12.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDKd9ESGt8hKFdeWy9KX0mvsy+0roODOjBIKo6eQ3g+OVDemMYqxk4OthvOja2uzIEO2My/vTzVw9nYNKvHwpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=977 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150085
X-Proofpoint-ORIG-GUID: 1CO8eXLEJ806CUVjb3T4hfTKqf3nUi0s
X-Proofpoint-GUID: 1CO8eXLEJ806CUVjb3T4hfTKqf3nUi0s

On 15/10/2024 13:16, Christoph Hellwig wrote:
> On Tue, Oct 15, 2024 at 09:01:41AM +0000, John Garry wrote:
>> Validate that an atomic write adheres to length/offset rules. Currently
>> we can only write a single FS block.
>> +	if (iocb->ki_flags & IOCB_ATOMIC) {
>> +		if (ocount != ip->i_mount->m_sb.sb_blocksize)
>> +			return -EINVAL;
> Maybe throw in a comment here why we are currently limited to atomic
> writes of exactly the file system block size and don't allow smaller
> values.
> 

ok

> Otherwise this looks good to me.

cheers

