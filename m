Return-Path: <linux-fsdevel+bounces-24494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6165C93FBFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C385283273
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B43C15ECFD;
	Mon, 29 Jul 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RRbKlSeF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oxmejE+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D17603A;
	Mon, 29 Jul 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272577; cv=fail; b=ugGZsU3/V4UIqX6XoWN40YVoUqSBY8da3adpUq6Aav9Ve/mrfvqltHSOvDA7SuDbg3SlyWlaCeRrh5AjEzmxftI+ge2cJpB0rxBIEpx6vAvw0iVs6DDTD8FEy0XKcU1cqmOAUpaKvcfH2AtI5f6HowPd1uSUNBDCcRjUrWolg84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272577; c=relaxed/simple;
	bh=dhefZ1VTV8RPbHVSOwneL3iDPmL8t7m3KzGMxYIp/pQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dG1gTyMfs+49Kx7TxwU5lMPgZx5noScS9pFENlOGHYd4Vb8votf/uCXXJqLiDOj0pQVq+UpU581PIFKdjpNLxnXNraRadbV7DD5/1NbVPWJ4Fb9m2HI4T4uvrmNIFBVN5IcikfIKlwvfG8iQeW0++EakLlHLdVe/RLMZdmKCn9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RRbKlSeF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oxmejE+w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFMl2a011692;
	Mon, 29 Jul 2024 17:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=9qXkBfcZAf+tpXCLs9Rw1fs+vrMRuDZ12oTZDvXVQ/Q=; b=
	RRbKlSeF+R/7KQI9R5uElgs17SN1NpJmnuuA8S3EY7N6spFY7RjbPeWe/a/8aLFK
	imAnhjKkqbHx0cnxr1sukqG/rmz3aziFiMM9c30f5RWLnv6nRqh6aVSffIT2CTfx
	IwYCbmHvDbSe9dLGPw7jAUEqzi8mNOl8P+61Li8BMmmlEWVGosB8x1W451LOv0RD
	jemriqYuBFyWymWBSS3AA/8VdLnepn5xfXkAaws/OqquOejD6A37rCe7kRAr/day
	HaQ06rCHMMtWTuEyP0C+FqYAKkDIVVIPgAWZ9knG0wEkmLCLYCn/luDcom1BZpKU
	C+YzQhrk0nSAgR+BHn8bSw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msesk3tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 17:02:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TFjgHI037273;
	Mon, 29 Jul 2024 17:02:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvnv22wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 17:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8NHdiTl3S4oGMQaz/nIks2bfDiC5pLSwg/PavzR0V6Ej8VWzsSHgxWaxSbfb5vr1/u2QZ/6ZSTTU51YMWpVIkjhiRE/gAFo1snjCfgdkQqdc5ZeYvI0vBKdL85mC+InADO4hvmO3bQW55FEi/NeW/f40MmI2deVwg/UPGpti7Ri+c3pnSv6URQYxsPQQ79dZnWo88SjZ/26hIz6HmzneKLR6ugAkkJKJn+OzEuqFVGP7Tz/zqMLGUpBJxUoYVMYQ0NuW6AQ3rjNcCXtDiiLVLdn7anuyyYunllz+076lwSltt6KyHl4TTq0Lli/7oHXqdAzxHOlrlxF4/LQkqMxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qXkBfcZAf+tpXCLs9Rw1fs+vrMRuDZ12oTZDvXVQ/Q=;
 b=tTytoJuYGKVNUXMenaMkoWahxxExzg2nzM4lci2AumSR17JqZEuQHY+zh5un1Y0NKzieeMHeAupcgHsxOGAnW88ynbciornF8+vbJM/LPAzNfdtjsXdS3d0PMU7U3ptBuuMwWKDiDcD12flVswLr5/p6BNPZHnWmVQs311y71UcaXOptUlh8Z5csPALNTJT0+Ieug75ktdHcJx+ia1aXrrwkxkgESMp39/H2cJp8luKsePci5BoysG34RzmbioNr0DZvqlw+WyRuKptbYpYchuidgQ4h3icd1JRsLzwfX8pIKz05Bi8IgmTBRkbw7k7Ipw1IwqvF2vqlj00oTC8lSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qXkBfcZAf+tpXCLs9Rw1fs+vrMRuDZ12oTZDvXVQ/Q=;
 b=oxmejE+wuRJS8bjWIU+tzlk800GCVqd8RyaczS7bzuGn7CukeCoJKJXl6zYoprhjUiFkX6qpVj+N0hXGd5SpbH7G+yWTAjpoQfnv0bjH0XT5OolKTirjVSgYomv66nfgN3qBOH3vauyoIoqooRGy+kFGEpGegUJwC9sQCPrQ7Dk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6903.namprd10.prod.outlook.com (2603:10b6:610:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 17:02:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 17:02:43 +0000
Message-ID: <f740c31e-609a-443f-95d3-56fc92bb5d48@oracle.com>
Date: Mon, 29 Jul 2024 18:02:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/21] iomap: Sub-extent zeroing
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-15-john.g.garry@oracle.com>
 <ZjGVuBi6XeJYo4Ca@dread.disaster.area>
 <c8be257c-833f-4394-937d-eab515ad6996@oracle.com>
 <20240726171358.GA27612@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240726171358.GA27612@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bce41c-9f0f-449b-6511-08dcaff0432f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkhnRkRXUlhsbmtnOS9TVmNvaUphN1IvK2xNaTBDUlI0QzdFdUorakI4cFE3?=
 =?utf-8?B?UlpxQjlqTVoyTDlINEV1TCtGQ3ZWVHFwMVRZaXcySkV2eEdmdWJhVkRMRkRI?=
 =?utf-8?B?NEd3UkMvYWdRS0tNTlBnc1JXOWpFZWE0eUpNdDh1RFpNU3Z5S0EvQ3ArY29S?=
 =?utf-8?B?Unl6bktYVVBoMUxNTCt5TEROby84TEtIektyanNncXlDTkw0Um5KYVoxTFhO?=
 =?utf-8?B?YmRCdVpVcGpXZGNtYzdsdHJpQWVMYmlVZVAyTnFUWmJsUFNwTlJyT0VnOTNu?=
 =?utf-8?B?R3R4NVZxb3lsRks0TU5ObkpmbU1zKytrQkVJVG80YkhHRHZsdmlZalk3VDFN?=
 =?utf-8?B?bjBueTIvRHBBWFhha3Vhakg3Rk1WYzFwUXBaR2VWOXM1Y3ppM1JzMUZIYWFR?=
 =?utf-8?B?UHBqQXNMVUViTmt6YWovd3BYQUI1NkFRdkthNDNsbW9ZK2VUUDUwZHRLSDNt?=
 =?utf-8?B?K2E5M3RDMncrZHlhSG5vNWhvREVrWmFiZ3JLeVZ6VEpRSGR6cWhRVW5GU1l4?=
 =?utf-8?B?cVdnUXZWazZjUkE3blUvN1FXSmNOSlhQSjFmVS9pQkxRK2x3UTdoQU5abEk4?=
 =?utf-8?B?Ni9WN01qbUhXbTgvc0tTbkk0a0w3SG1EeWJtV3NsY3U3eTBINCtvWGdnUXpB?=
 =?utf-8?B?UlZQL2ZvazgvdUZGYnR6M3lydWliNkUya0NZaE9qemEwYnJ4MCtEb1JIQ1pv?=
 =?utf-8?B?VGhMb3U4ak85UXNoeUVleGNNczlJNnVvc3lZTERrT2JiRGU1Z01RRklvcmFp?=
 =?utf-8?B?NzN1SzVrVjR5US9BU1hLL0hETVJNZUhuWHpsTnVSV3VTQzhwWDIranYwbDNV?=
 =?utf-8?B?OUR4ZjFKQ2N2K2tuZk41SVlCUnkxRkdQb29ya2VmMWt4VVoxL0tDdVJFWW85?=
 =?utf-8?B?Ym03V3llTVlsT0pndisrdVR0aFlKbDQwWlIrSGxDSFhNNzd3UjJwc25wQStv?=
 =?utf-8?B?Z284RXNCbktUTGU4cWJHeHBhNmJLRlRUcGJOM3l2MmNBcE1kNnQ2ZVhxaHhv?=
 =?utf-8?B?cUxuSnYySCsxb0ZoVkZUWG44SjNsaHV4QTJFOEVjbjRwY2ZSZldOOUNhWVV4?=
 =?utf-8?B?OUhGc0dEWHJDUTVyVkFqaHlwZi9vRlVRaVoyMklIZlJlQkhFZTk5S3plQ0Mw?=
 =?utf-8?B?Q0ZORHFIVGcwNnZETlRnL2hJRVVmMjNxbUhiZkZ0aGdjK09xUWFrVjBXR25G?=
 =?utf-8?B?NEp1QnFyUlN2MFkwMlFDdmUyZG5UNHNoZ01IUCtVUFlSVkJBdUJtZVFwQ2dC?=
 =?utf-8?B?T2RBT0tYaUxkZE5rN0oyWTYxbVJFZmg3dVg2cFFvb2Yxaldqb1phQmxRQlVD?=
 =?utf-8?B?N3AzcHI3SWNGODh6RjVPQ25GSUE4Yjlpa2dFRWluclNUbXlGbm9tSnFZVjE0?=
 =?utf-8?B?TGtXbXpJK0JxMlM2a2x1bGtWZ1U0NXMwRzgxdmNzYVNCUjFrMVpEczU0Ui9Q?=
 =?utf-8?B?Nk85ZmRCVzFOZ3h6VUg5LzdPMEdMTGRSYWhyeWw2cjhFV0ZqOU5VaUhwNzQr?=
 =?utf-8?B?dVhBSTZaWlVHL0VhZ1RuOEgzRkFXNitLQU1BQmlMbUVDNG1rNTVuUnV3RWNE?=
 =?utf-8?B?R3VRMjloQ0pVUzJUbXFZKzFwUno4aDRiVm9pS3ZwaVJJL1dNV0UzdjdIbzZv?=
 =?utf-8?B?cTA4bkd0QmRyK0pTVkVUY0VTYmw5SGcwQm5WTS9FSDZPSmFOcWJpN0gyMldW?=
 =?utf-8?B?T2lTcXZ2VXZ3MG9NbWNLU2xXSmxaYngxUnQ1dVQwVlpYVG1IdkdKb1ZqZzNI?=
 =?utf-8?Q?qLBdT+WZSEG37ZFeD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1lDRkVBWm9oSkxETmxiUTU0d0gzbi9MYml1UFMvOVFUbVpNR1k3WXVlN0NR?=
 =?utf-8?B?U0lYY3VHQTc2a2JaaldtYUJpaDZSQkZFY3lScEZOb0VFNjY1aGZ5Y0RJa0hr?=
 =?utf-8?B?ZmhydGRGSXIxVzJoQitMZFE1S2JSbytUWlpEallNS2NTajBEZ1NpcEFjZXQw?=
 =?utf-8?B?ODcrUU5ZTlFydy9XTDlweVMvV3BHTWtBbmZON0V1QjF3TUZXN2FmbmxKcXJD?=
 =?utf-8?B?UHUwYSs2SG1rR2dibXoyR2szQnBiY0JaaHRNK1pHZk5aZzhGdHA4cGN5MXNV?=
 =?utf-8?B?WnQ2ZFlDMFNMRHRhaElrdk55TENLbXdzR00zVHFtY1pjcW5JSjErTnk3KzlN?=
 =?utf-8?B?WTFuRnd4aS93RkwrN2dWSzNpVk1kU2JnUEIwdGhyWGhJclpTSW03cFJJV1lM?=
 =?utf-8?B?MzR0aDVmM3R0ZitsdldGRHd3QkJRY0UvL2VXaHRvY2FOSldqNmZZcUEvQTNL?=
 =?utf-8?B?QnB5ZHNUS1d5ZG9Hb3BzTXRvSWVQdjVIMlVkbGV6a2dmWmFCbW5wN0RoMjFp?=
 =?utf-8?B?MDBLM2thbGtxUnd1TmVkNTdWMlhhWFZENzRXbDRyem5EbG1WQUs4WFRnTXor?=
 =?utf-8?B?MHd0TGYwTE9MM1gwWDU4ZXBSZnNkYWxya3UvNHp3QUtvbnR2UFRMcVQxWTY2?=
 =?utf-8?B?Umtqc3ZBaG1qaHpESTNVMGp4TXJ5N2UrdHc2eVhGNmZSYTFsSWNLaVM1STFZ?=
 =?utf-8?B?djdJcW50QXBPN0FJRGQrMDRPOVpYTy9GckdzcUpKSzBPRmQwTnR2WWpRdnVW?=
 =?utf-8?B?NlYrUHpRenhGYVVxNFNnc1pkMTRiYllyS2ZtQnEvdFV2RGFsY3A3SjgrUnRB?=
 =?utf-8?B?Qm5hMUlaZFU1RFBpc1poVEF3TzkxR201NVZCcWUzQ1V4QWY0ZXI1eVRCNHRW?=
 =?utf-8?B?Tmp6NkRTSWlKSEh1VURDN2tRNXBLdFhWM28zaG5MSGN5ejFQcElGQ3NiVVlr?=
 =?utf-8?B?ZTQwQ2N6VEtHNTI5MFBnVlVuc21aZDh1dTA5ckNsc1RzaHZiWnpSUTYra0dT?=
 =?utf-8?B?cjNnS1dzRVVlZUtQbFdnYklaQjJUaitFbVN0cG01WEpoRlZhWFJrUmtTNGo3?=
 =?utf-8?B?OUJFYlpqUkpxa1V2V1VieHp6bitVemVIK09IRGdaUjNaVHNuY0swS0o1bVFw?=
 =?utf-8?B?aFF0QWJzbDZVdTRpb3FOdW1oZTFmUVRTalVnKzFPa29xN3JCVis4UEJmcVE3?=
 =?utf-8?B?YnlvZWVldlpITVUwenNhODVpVFpEam9Db2xCNWpYUVJqend0ejhxQktYdnNz?=
 =?utf-8?B?TGNHYzZFZXdaWGkzSkhVVXhxaVJvaWFyUjdkaXl5aktUY3dOTGRYT1BUR1FW?=
 =?utf-8?B?RmkvUm1NR1B0bUpZZFYvbCsyeU5QZFFEYkdqK1dSVlczQWNab2w0NVI5U1hi?=
 =?utf-8?B?QlJWcDlHY2pIeGxjNlJaVnN5U3Rpc2orbXZURThBV3c2WkpPV3pWMlZ0SXJZ?=
 =?utf-8?B?S25wa0hjS29hTXZVaTZxbWNqWlBzK3dWOTJQeXFxbWdKRFBVTmV0UjhYVUI4?=
 =?utf-8?B?UTgvM0F4bVF3bkVZWGUxUVJGd0dOTFgzMWdBbHlwbCtpUGNFcys5SlBDOXpm?=
 =?utf-8?B?L3lhOHVENEhVRzN6YVk0WHZlK1lGSEhneFVQWUxwa1d5UW0vb09XbldqdlVV?=
 =?utf-8?B?eE1vb0FlR0dZT2dhMTBSUjl4aklxeTlMbGdWS21oRWxtY280R2VpcFAxdW5O?=
 =?utf-8?B?bTVBY2FoKzZ6UlhVa1VDV0dZZVZSYVZYUTR6MUpBRUFsMTVlSkg3eGFDbWFD?=
 =?utf-8?B?emVUMm5tSG1pcDArWlVmU2wwaExXa0pGeUJVNWJYRE5vWUFOTTVERkt2eW1P?=
 =?utf-8?B?TGlSRTJYc1pzQmI2ZGE2N2pXOEQvRlpuSXJPOHorZjJ2VGR5UEFUaEFjdWly?=
 =?utf-8?B?MHRZZ2RQSzNneXcrUW1mLzRzSTZZQmF4TVJrcVVTOUF2eEg4MTlROVI0VFU0?=
 =?utf-8?B?cUJBWmRWS2pTYzc5WjNYTm1CeUE4SjRTcHVBenVMWWUyTnlqQys3UGNZUi9Z?=
 =?utf-8?B?aG1FeXhYWDNyeCtWQ1prTnFPR3Rldi9iZmpSVVRaallEdmJDQTdhczhoNVpk?=
 =?utf-8?B?K1MrbVltVUMyaC9CZWx3N1NQQlVCdGNrcjNwRVdiQjNPRmg5MW1ROVlJaTFp?=
 =?utf-8?Q?gwb4pqNuQsrijEJ9cKJ+jq1dV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CtWJPE9ikasfRPkQXj7hEuaY0n7TnYNkPvlATNobFw/fRiZGDu5fcGB7ZZCrt9yC4z65Zttp011cNGhsFAyOhxhKcJaxu0n7+DLO9omwFPmkCZlh8Hk/iSsg8pNKn2BsgtUdp0y3WsKv2HfiTQnW40csYE36anZ4yLpLga5abAbai0B7VQlJUaE7V46gxUyMcC4yiXW0bof5SLVStBwqwkLlOJ7jIaJODNGaWwSG5V7DsbgeTnwoactV8JkBAZtEZCcgTTHGYYYr1rZLd6Pry4ekVvdikZQJkRKCYe5zH5r0G9qO70xSRErOz72umTNKZmK17YBxFTN7wEQvkU1mbbEbt831JgkHYLSN2Md0X8orUQ3867y3/1MnW5nEzgAz18vc3cf+ZZnMBGpi2ryfFKphZ6+N12KFZ3spryAZsnWO3OYsEXdh+YnPMEQQrljD3x1oRhnQz2TO42AXNs6Qj0E7tOK6/pcdw/N+ZfeU3tt8fwN79NP4AVKOaVdLW4d1AaPHFmYnvaYSTkC6bLNzJvWG8Xml7kNP11KF9C7bvOUCAyCuEdr51bbC6ptI1FMa11rmhaxv8j+WtentRQrlSxZd9ldrQ26a40nh7pDRHcg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bce41c-9f0f-449b-6511-08dcaff0432f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 17:02:43.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3fEP/snibR4KvedezGwM2mvDJBPqVZP839U81a5L106IFdwQZ56xxjDZOvu+scs2nsWP82ULIt1FFW361DLzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_15,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=951 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290114
X-Proofpoint-ORIG-GUID: V164JP-caM2VMhG128iuigwYhkHGIIO6
X-Proofpoint-GUID: V164JP-caM2VMhG128iuigwYhkHGIIO6

On 26/07/2024 18:13, Christoph Hellwig wrote:
> On Fri, Jul 26, 2024 at 03:29:48PM +0100, John Garry wrote:
>> I have been considering another approach to solve this problem.
>>
>> In this patch - as you know - we zero unwritten parts of a newly allocated
>> extent. This is so that when we later issue an atomic write, we would not
>> have the problem of unwritten extents and how the iomap iterator will
>> create multiple BIOs (which is not permitted).
>>
>> How about an alternate approach like this:
>> - no sub-extent zeroing
>> - iomap iter is changed to allocate a single BIO for an atomic write in
>> first iteration
>> - each iomap extent iteration appends data to that same BIO
>> - when finished iterating, we submit the BIO
>>
>> Obviously that will mean many changes to the iomap bio iterator, but is
>> quite self-contained.
> 
> Yes, I also suggested that during the zeroing fix discussion. 

Maybe missed that. I did notice 
https://lore.kernel.org/linux-xfs/ZmwJuiMHQ8qgkJDS@infradead.org, but 
got a different impression of your idea there (to this one).

> There
> is generally no good reason to start a new direct I/O bio if the
> write is contiguous on disk and only the state of the srcmap is different.

Sure, so we don't need to worry about partially-completed writes, if 
that was a concern; and it would also mean dropping that unpleasant code 
change in xfs_iomap_write_unwritten() where the start/count fsb were 
being rounded out to the extent granule boundary.

> This will also be a big win for COW / out of place overwrites.
> 


