Return-Path: <linux-fsdevel+bounces-44299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868A1A66F75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 10:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7FD3B880A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18DB2066F9;
	Tue, 18 Mar 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZO/F7+O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SfMwETng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35B205AD2;
	Tue, 18 Mar 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289221; cv=fail; b=RWqhuGPPAZvRarU7In2KzQNhh0s053hww5vKeEsymzNhQO+zNxclzAdE/LJfMAMbcKbzNlQ5vt7rGPNeAOU8C/+mTWtvR3MC64Pj8XyDFBCh46esOIo3jv0Ktg/mtROINOjIfknFbDJ2F9yNmwYK+a+UbK2MJLjwGpxSc1vwLpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289221; c=relaxed/simple;
	bh=wqtvlNf0x//fjzlhCDQ5O5DNnJHHxw+9k/ut/MGHkZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wv03RoTKU1ZIT++kDWYffQc3p4QiHKyT3+Zs45y7KsDOqVtki+s3z4X9AkDrivS5lRjxkGPzFYLNWs0mJla4AMXxU6jKB8YDr4bTkKGJdbGqaU3zFtmxEwKuWfQ+rub28nUYeIKQMhiJXyRB7/3NAPTeTgSnBZE65HeAeI6PgDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZO/F7+O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SfMwETng; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7twMP001670;
	Tue, 18 Mar 2025 09:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lyDRV60ErrFCVFU9I8BTQ/0kvSzh49Jqe+zfdo9tRNo=; b=
	BZO/F7+OejhYnejWJEWrxiLOQ16Wh3XkymeuZ2HYkmGNYjrh/GChBqer6WDwrMXJ
	AoRXr17FQBel6Mwjfbw++fXuJN9Sm5+qa4U6yD6Y2Ey0FPsIYFSFZTm7sfRDi7nf
	8ozcngrF59Ni/AGC2407hHKO2gw+cxfwnlneP4ajW5fq4Kr3dznPZUUD3eczklm6
	opcxnmNaUfXFm/6mVYh/tZ8W6hTTx04eB1/59s05031B3aBuH/+zuEwMIdbE+36p
	FyJpioXH5MC0VnEY/+lJN6yNyh26V16e03ql76U2IJ2ExnC4GjfwmeNFHQwKeJC6
	siZ7v9UJLXVJmVRVvjkgcg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s8mrh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 09:13:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7tJHB023558;
	Tue, 18 Mar 2025 09:13:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc5aex3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 09:13:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlMabQ/fg/fJH1Qgk+dCzGvwnRE4m6e1k/LRrYlrEBgpF/eS/HZ3sKZWwtEAmJwk5UCJaTYEMwoDBvHFJy3E+X2oSy2k59vNt+AP6HIXX4iWlsHoTsvn7u79T2zf+5VO2una9f6HfE1v4dp3dulVQ7jt711KEHJbWejbv1uS8oA6b4VO3DMP2l47G1asLyp+nHj+3X+sQJAayPxBKNYlzWu/8cJ339l3cv2ZjEEG/T8v4QZpmYnbTjr0u1ANQOh3dQzXrmNZFyBsN9uwP172Y+hEkencVcWnpN9OLD0bjhxbGZO8d//ZGnDkh5YyWUdAkzH1dDIx2RSgDsvEQ07fXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyDRV60ErrFCVFU9I8BTQ/0kvSzh49Jqe+zfdo9tRNo=;
 b=RfkyI2UJTZAjtVmxJKLaUTjaP4FaXT9vPn+pXWSkP1N5CIwquqxJTYMCDKwIkyW6pliEFQA+XqdZlmlp93wnDTArpNkPS71SeKv0qN6MakYJPkd6Uf11DjKtUBlCfFMAgccaZkGqKdT45mDNbnPjBwGzusDDtoBmde0VEUnx+vLWrcsvF6ytR6B9vUIC2EXp59zAvo5VTQBMGfHotq9xbNxAX/uQYValLKCt9QS4EXNIVR6lx6yYTSGo4b5gWBm73C6XGuL+HW+5vtePk4FMdI6IRsi+mXlpoBY1DoppD1/+3Zttz0M4j165erlxgp6NobJmtyCgwkch/c2KAFZF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyDRV60ErrFCVFU9I8BTQ/0kvSzh49Jqe+zfdo9tRNo=;
 b=SfMwETng9Bv+c2Heaf1Ql/onperQ7uKDOHxTpE12ytgaQJZmd+jgL9x11Qgg+xPggNdB7L0MQL5wE6r6JsCOIu8cnIut0Uo4mt6JK43RmCU0D7MZImaVRtZ3IKmAekRqw4S2AIV9wf2t5mfxwVtL8+m3Y9ijAdN4PKxS8b6YTpw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8200.namprd10.prod.outlook.com (2603:10b6:8:1fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:12:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:12:51 +0000
Message-ID: <986ad4f0-121b-4a12-878f-566a09c9a1e2@oracle.com>
Date: Tue, 18 Mar 2025 09:12:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/13] xfs: add xfs_file_dio_write_atomic()
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-12-john.g.garry@oracle.com>
 <20250317064109.GA27621@lst.de>
 <7d9585df-9a1c-42f7-99ca-084dd47ea3ae@oracle.com>
 <20250318054345.GE14470@lst.de>
 <08992e02-9ff4-416e-bd6c-e3e016356200@oracle.com>
 <20250318084641.GC19274@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250318084641.GC19274@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db7b53f-0d54-4248-660d-08dd65fd0f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnRkem1CdTBDOTNBNkNOci9sUFI1YUdRalAzcnhUUlhtUmpOVHJSZHZwaTJl?=
 =?utf-8?B?NktnVHFVTnpLUm9POVZ1OUdDdFVRUlVjbzdrbWZyWDFlKzBqT0I4MTk0R2lY?=
 =?utf-8?B?aW9jazl2SjRiMFkyMXJiMXN2MTlwbnVrc012QzNqTi9XeEJpdzRLV2wwL2gv?=
 =?utf-8?B?MTh1VkV1ZTU2dSt0TnBXazVIMnl2YXZmcDc5MGZPRmFxd2tGakNFVnVZVzdS?=
 =?utf-8?B?cEVPOUlFRGVCZEs4QTFSdUFJZmZKbXpGKyt2U0t1cmx0UjFIcHBUNHNkYTFE?=
 =?utf-8?B?azlOU0NRU1lJZUxHd2YxWWRpd0hWdjhCOTUwZDhmb1dRSTl3SWtZM2IrbzVU?=
 =?utf-8?B?LzliKyt4OG5IdDU0NTFVUnlpNGJJbmpxdUNvUXJGM3FjcHBLSUpDcnBvTGgx?=
 =?utf-8?B?VFFsWms3WGdQSkROdThJVEEyS3M2TVBjeE9FM09zZmpqSmI5WTREZm8xSlBs?=
 =?utf-8?B?ajIzLzBhMEdSUWplRWVROCtrMWpmMVBGZTRnb2F5emZyNlYzT0E3d2Fla1Z2?=
 =?utf-8?B?eStKYmtXeTJDYzQ0SGFxNzJLeWtVUzBoZ3cxSUs2SjZoU0VFTmJoTm9POXN1?=
 =?utf-8?B?dktQaTRvbWZKdmtibHZkSG94cktYdCtrUjBacEtVS2h2ekkyTnpiaUZ5SkpE?=
 =?utf-8?B?Wm54ZWFLMzJ3QXV6MnU4ZUVsVk1tdUFBblFnVGc5NXhsdTlwcUpYSlVubUh1?=
 =?utf-8?B?dndkOVhzMU5CczdoVjR4dHdYUXo1bE5XTlZrdDBDdHJRZ1pER1RaYlJ1Rm56?=
 =?utf-8?B?NXRkZHVDY1Ayc2lZOGNwSlhFbWMvVExHTnNoeTF3VHFoSlZvR2o3RW9RY3dj?=
 =?utf-8?B?NTZ5MHQxWXQvdmIwVE45dmxUcld4TjV0RlZYbnVaakJ3ekdyTFprVFFQcU8x?=
 =?utf-8?B?ZlJZTXYrSlpTUzlkalFhdHJxNlJJd3kwMURvdW1NaFBick9XdnA4OFdRNnZJ?=
 =?utf-8?B?UUt4RG10RFVhQjBUeU5uY0pQZ1F3Zy90UW9LcmM4VmRTM2pMN1VDN3dvOTU3?=
 =?utf-8?B?bzdaOFQxaGd0RU5NNjlQZXdMRHJOaERhNXVFM1JRVzdMNU1reTR2T1cxUEp6?=
 =?utf-8?B?TGxlSWhLMkdHQzRGY0JVcy9tTjJIZ3Q5Q0c0ZmJoaUt6RHVPOWFTaFFEdEpM?=
 =?utf-8?B?VU9MSUhnOW5LcVdXSHJTUFBNeEJFb3NLU01mRDQ0bk4ySUs4a1BSenAvaEdY?=
 =?utf-8?B?MVFDY1d5S2lLRThiVVl3N1BkakFRRFdFeDZaOWpqNElZQnFYYWtqdExrSVI5?=
 =?utf-8?B?SDRyYnlLajYyWCtweFc0bVFQeWZueHRDcnVOQm1PNE1QUk5raElpaTFjZ012?=
 =?utf-8?B?SFFFRGo0cG5abjJLQWVyUnFDdlhyWWx3eUtON2pqd3BRQURFMENhaE9yRGFV?=
 =?utf-8?B?K2s3K3BLakVQT1oxcEtpeVI4ZXVOdU5qUmNsUW0rWXliamY0Q1U1SXpoQ3p3?=
 =?utf-8?B?ZDhNNE44a1lxRUpXRWY0Z2tlVXpibXUxRlUzbDRTakl2RVllUHNmbUphMDdW?=
 =?utf-8?B?eUQ2Nnh1SElCd2ZZSThnS0VrSWVwdXNZYWE3MVUzMlNURmIvY3hFVlBjb1VU?=
 =?utf-8?B?Tlp6c2VVWWxqUDU4bHZvMVBwekF6SlAwN3ByTldUa29uZE1TUVFtamw4ZXJx?=
 =?utf-8?B?eENKa09tUkxzb1Zsb01mZnUvZWNRMnl5WCtjeU1Fc0MrQXdmZ0dqT2NVTFIx?=
 =?utf-8?B?YXoxTWVuMGhJYUFUQ2N0aWdUSXB6RkdraUFqemp1SGlEaEltWTI0ejBSZUpp?=
 =?utf-8?B?QU9yYVJlbjlWY3YrYkcxcExISEhoNVI0QmhzUjZ0UW53dDVPNVRTMytUb2pN?=
 =?utf-8?B?Yzh3dGVqZWVvbHlzNURMTkhXWFcxSlJMWkQ0b21zVWJGdCtHeHRhdmNiUElH?=
 =?utf-8?Q?Dwg8D4iSOPsXi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXRDWnhxZjhNYjlmNzFhTUd1N1hmTlYvRmVKYzUzcjJPZlAwT0RHUlFlRXhO?=
 =?utf-8?B?VDlvTnhJa3F3RW5ZOFRNR0gxbVJxRUtkaTg0ckFaR2UvTFZVakp4NzU4bzNO?=
 =?utf-8?B?aTIrUGRaR291SnNLQ2tJM1ZWdEZIbnZpKzVvWUtDV0ZuZDlGcWNleGU4YUs1?=
 =?utf-8?B?allIWm5lSEQydTM3T0dOZmhqMGYwTFhLclBhOWJYd2hnMWFKVGNRTGpFTjNM?=
 =?utf-8?B?bDh2bUJMa3NaUURKRXF3VmlLQ2pTWXZaSTljYlpsK2ZCYmc1QTBoT0hXczF1?=
 =?utf-8?B?eGVyNFFEVjJ6WFozYXA2OXFYcU9IZEpqWE5IZXF3c3lhYTVyU0ppKzJGZnl3?=
 =?utf-8?B?UWFTRFhuTHZIWG9STk1OVnIxaU0zakNkTmtLM0NTakE0UVJQY1QyZHJWM3hx?=
 =?utf-8?B?bDhud3R1YXFiZGtWQUNtaXQzOVRFZ3A2dGg2M3VJNmwxekJVYzMycTY3disw?=
 =?utf-8?B?YzRsNTFkckpDWVBNQjRLRnF1RVQvYU80L0lNdXVGTDlNd0dVeEpVV2V3UzNW?=
 =?utf-8?B?UTdPdmNJcG5tQmt4TzhjaEdLZHNYYUNGNCsvZGFkUVVHNGdTUnNQb3NsUHNz?=
 =?utf-8?B?VnpTeSs4R2djZTdYcGtxQ1I4ZGtURklxNkVnOUpLTW1MQ3QrTmRiQzRWeTZn?=
 =?utf-8?B?MWVDNTM2ekNwaTZGOW1wNmpoRys2N1FPU0gxSzNxNjMvZEdWcWdPRW1TU1NM?=
 =?utf-8?B?K3JERGd4b2sxQmp2SWQwQ1laSnFjckQxa3hQeWd1TXVSam5ML1JPdkJPUm5x?=
 =?utf-8?B?bCtoT2d1UjBscnlhTXM5SW9WSlA5dDI2UGIrd2NHVGFTbmhVQjdkSHlDK3RP?=
 =?utf-8?B?U2JZQ0U1MU40MVJvcnp3N2VqbEZDZ3hPOWg0UVF0QXdoMStnR29TdWtvc2wz?=
 =?utf-8?B?aGNxajBGUklNWU9aOWhUZWtuQmJjNk1TMk80TFp3dWI2U1h2S1B1dTBUdGZx?=
 =?utf-8?B?ZlEzWitSV3hvT2FoZERKb2FTSnllb0xLeHBsOVNDSVFqb2VydnhTRVJPMTJx?=
 =?utf-8?B?RjljaDQ3Z254STZ4VmRlMlBaaklQRnA4RnNOWnFRM1JTakMyUGZVY0d2MFZE?=
 =?utf-8?B?Q3JUTlEyeVNZRGx5aHRpblAyZWJMS1FxRHh6VXRKeE5ZUmlmVHlhQVpvdUQx?=
 =?utf-8?B?dmpnV0c4MkZKb1dMUVZQc0hjNFA4YXQrbWwyOUgza0ZEcVIycnJTSjBzOC9k?=
 =?utf-8?B?RGV5UFJ0VVVYd0NURStGdFpHLzlCNnQvMVh1TkRua0xpU09UY3NtYjlsTmE4?=
 =?utf-8?B?U0lVRExvUjZuQUtVU1BTVWcwdk1iYURxR2dISDVYaHFDU1dFWjBQNFRLUEgr?=
 =?utf-8?B?YXVqOGlLZFNGcHRoRUw2OGdlakNzSVFVVGprVG83bGZxT3p2bGIrUUtZMCty?=
 =?utf-8?B?MnQzN1hOWkQrQkZoQ1NOQkZtc25XbVJjUTlDVGlJSjlxZ0NFaDJ3RUZyY2d3?=
 =?utf-8?B?VTBNdGJVRTA1dlYwc1pFZTdHNFhsVlFQSEY4cFU0OGtLTmMxQy9MVWFtTnhH?=
 =?utf-8?B?djRTS2Q4a1BtRTN3ams3ak82bjI4czNpSXJjR3FVYXpqS3F0amdoZXFoV1RS?=
 =?utf-8?B?NkNZaEQ3VngzRnhZeElYcE0vZ1RDTmtQNFZkbndQMjgrVm54MzBOeVp1U3kv?=
 =?utf-8?B?b29mNGZ3WUwzQ3lxZXk4OGdqcEt0c3g3M093SjZ3OTd0bGtsMWxTYnJkMXVx?=
 =?utf-8?B?dWwxUGxKeFU0eU5wVERVeEE2QnNqZXpDRDRMTklRdURGczNiQnpYU0tab0Jw?=
 =?utf-8?B?M2VpSXMzMU9rMzRKUzBhdHhHQkdnRGFhUFdjQ09UMFY5dE1nWXNFOEhENTB5?=
 =?utf-8?B?YlljRkM0b1ZEOGxZM09DTjdBNUZlV1ZvQS9lN3RGck5naTY2TEJYM1N1ck16?=
 =?utf-8?B?MWFOS25RZzliUHRSUXNBYlduSE5pTkJjQ2ROeU1YWkFNYVA3UlVTem5ydjc4?=
 =?utf-8?B?VUFGNURpcWltZDNlTEN6OCtiMTFLN0g1S2pTckZEY2pUSW5JOVpta2dNWjI5?=
 =?utf-8?B?b2JjWXgrejhhcVhMeDJUdkgvRDc3dU9CT2RqR05tTWw5ZEl5dklMRkZiTDhq?=
 =?utf-8?B?bWhMeTJpem9xOGhUV3Bzamw3WUNjbE9LM2Q1bU5NVmFpVWVPN1JHNktLWHly?=
 =?utf-8?B?K3pHNG1MZzNDUVE0bVJjY0JTYVRMOG85SzhzY2hWVEpYNDRadlAxYTNyc0VL?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hYHVR/2YnqCRj9R3gGRwWmWdeb8VWJ/fRMnGYFtPgtjgIT9zbrydwE5sFjKu6qQHm6w3ClVYy49aOVo9S/3I0aKlmqmAq/XEYpVAj3UmIS8LhcK7C9n+gF1j31HiP49jn7GWqbdfk9fcak7yAME4ZCnXW0s8dDAXKvzJfedG80sGGHbORQQEBENNBNUQW4EdR3sic1EibmM3AcwkjeaXS0vI5ViQ5xBNJhzMxVVwsaY7RtcSh8mM2STKT7ytnqKoGaZzno0fjBJpwv2CCQv7LAM8L2eXIXkbKY1V5ZGO1FnnreVHyABhuou9t0QEYrg1HhwZczgywrq/5PR9DNPgFlIUs4UMrjAwMhQU+glLxlhgUpR6ZNV/IHp1PUpNUQw0LHN0oJxKWFC6SsiglaA5llk9NugP5I2ObZkAYzX2mHCJ6sFi4lQuNukN3TOfSLskxb3ezjJC4Ahh9PAFB8iCAbaMlwPGjMYxKYzf1eI9gQGHbHlYzdisvO9fnfTDi32RUtCiUq/6qGn41ouz6uTW5dalUa1nj12qNxMhoEXhfLaIlQ3THnHHRJ+2O+/pRPyPjqEB0WsSZIwpgOY5FTNaomFqlvzG1KHjhaUTahZeVZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db7b53f-0d54-4248-660d-08dd65fd0f3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:12:51.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dA0zJozqHHlQCMYmh0H2zqq8Si2wLsuAHKH+WaOOX5+55q3RBamy4qIXy1TUzOHyoxVJAyHQcmJNWEsYldF5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180066
X-Proofpoint-ORIG-GUID: guJQXvuvf8kuPNVYeyxoKNeIEFPPT2hP
X-Proofpoint-GUID: guJQXvuvf8kuPNVYeyxoKNeIEFPPT2hP

On 18/03/2025 08:46, Christoph Hellwig wrote:
> On Tue, Mar 18, 2025 at 08:42:36AM +0000, John Garry wrote:
>>> I see that this is what's done in the current series now.  But that feels
>>> very wrong.  Why do you want to deprive the user of this nice and useful
>>> code if they don't have the right hardware?
>>
>> I don't think it's fair to say that we deprive the user - so far we just
>> don't and nobody has asked for atomics without HW support.
> 
> You're still keeping this nice functionality from the users..
> 
>>
>>> Why do we limit us to the
>>> hardware supported size when we support more in software?
>>
>> As I see, HW offload gives fast and predictable performance.
>>
>> The COW method is just a (slow) fallback is when HW offload is not possible.
>>
>> If we want to allow the user to avail of atomics greater than the mounted
>> bdev, then we should have a method to tell the user of the optimised
>> threshold. They could read the bdev atomic limits and infer this, but that
>> is not a good user experience.
> 
> Yes, there should be an interface to expose that. 

So we could add to statx.atomic_write_unit_max_opt, which is the 
optimised/fast limit, i.e. bdev limit. Is that sane?

Note that we already have STATX_ATTR_WRITE_ATOMIC to get the atomic 
limits. I wouldn't want to add a new flag just to get this new member. 
So I suppose that if we added statx.atomic_write_unit_max_opt, the API 
would be: if statx.atomic_write_unit_max_opt is zero, then 
statx.atomic_write_unit_max is optimised limit also.

> But even without
> the hardware acceleration a guaranteed untorn write is a really nice
> feature to have.
> 


