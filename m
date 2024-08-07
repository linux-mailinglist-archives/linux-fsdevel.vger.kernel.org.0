Return-Path: <linux-fsdevel+bounces-25303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2DA94A8C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5631F212A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153191EA0DC;
	Wed,  7 Aug 2024 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cRac/HtE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sm9ZxP7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE61E4EF5;
	Wed,  7 Aug 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038055; cv=fail; b=N7pke75O4doxKCU6eVOj0XReCNhblk7UE/b9WqmrKZUW0SlgnmJ0qNm724f8HjhyFwUorFZRxnFJA6dLlfzo7SUbRmHbtGc/C/9Zx0WgWPD9BmroA/zYWjRlVxS3d8eI5rk2FuL1emXhhD8U0ZHV1kThNn/oqRRpdwgW9kXCEiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038055; c=relaxed/simple;
	bh=t9Wjs7sD414tuq79zT1WLfAAb1iAUVSmjr4tFO6mE+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eqzJP7AIafpusAx10xAKa1dTLYlraXNTL3VLFsf2d4qRncs/xvzKDhwK7oDh4NHHfQ6rPvXSqd1SskRLZO499VYTQi1oRnauiH3axiX/0GXEwdmUPgiifH/wNrvzJZ0fkT2vrQ8F9L0REkGQ02XF5b9WGXuHeSRImlC4ljC2/V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cRac/HtE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sm9ZxP7n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477ASUGP009979;
	Wed, 7 Aug 2024 13:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=lTgqVWP9fRVXj5N6OxMjDaGtUm6ruiv0xp96FL3W0Js=; b=
	cRac/HtEAQTbTyKV2S0NDQeYwE2bV7pMah5bX5f0cjuIo3vqyLLCPL8MjL9vuyr5
	zM0AKZt/gBS7smmyqD8UhGLSjfJ47fzCUFamxffjAPhDiGExMusTewZmfu9vN+dT
	6D3caV04MYD4nmzgECyXxP4G2O1LCDmnVRDCgNVDltIeevnlnNLXlnHuSczrFHtB
	0bzy6Y3UO8HsQEuI0XX+eS51auSkGH/cesW2wKJB1u2/mc5M6eJtGi9LrSHtw1Xx
	ei80H+zuSVvL37EwtIti8QbPFhjdwEmCoSunoXGZYDz6PBnFgqAjfEpA9/6z7rNR
	IPbDAT/2Rkz5PPtOABgKUw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sckcfkqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 13:40:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477DCVfa018261;
	Wed, 7 Aug 2024 13:40:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0a0xk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 13:40:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhSENAElS8JPrACN60705iiB+Bz5PwBig2EMibmRfuSEZm90fpDL+IALMyk1X51Ge4+WGsvD+TaDt/nIbZdWCocg2zmcLOse2sWzLec+Ig9ZHesZcGjBR9wMQMGnnNrW73CTxK3rq0kqFJByVDyUGhC6cF85e4D4/quhqKBdqaa5/klmAoBWxLhrltSr17FcA0f1QZcEinf3oq1GzTEBp1mmQ1uKVHuVDQ/El5LMVKhFY/ESNEsGYPuTxFsNG7M0BDNvJesgC0hUTiKPaqUzFYWRR+X13ABbf8xf4Ju/dmHq+hZIy/u4yJpb3IUERLmJgn2E+pJVF/AF9iyT5sj20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTgqVWP9fRVXj5N6OxMjDaGtUm6ruiv0xp96FL3W0Js=;
 b=JG4al5vDv5Bwm1NuYuc2GBA/NnLJQfF+tQpjFOVv/asdLBIQvWlP60GUtIO1bgDQsuXdejthbYa/Czs8j9WP9IJwhbSFzwLSHyxBeRPIbjfh7cLXbD3xh1bn93k6+31gEUznB9AbWGs1hMJKIvqSGWHH6XOQQBaFCbTdfUTZvjO4G7LDtlda90IbqbC2XaPhG46zNnwX0DFkPNkWuQZvV1OzT/mBNTvxsuslaSKfOh/DIPHoSpVkgu3vgqgcBjJM7cgfj6wrI1EoppzFF2l/6j19ogXRVf365vf9udzIWPR49P9xDDSUuSSSgd17EyFM1BAGsGigXvsR+JXIMQTMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTgqVWP9fRVXj5N6OxMjDaGtUm6ruiv0xp96FL3W0Js=;
 b=sm9ZxP7nhFlPUrsLqJA4EANwPBDJv5gNTWOClREFfa7twCL5tFgcWD78bBXrTmEa5sVDtaBcZ+HEpfajQLQEtohutNMafYAJJ/KQqcC6FlDpoqyR9+qBIRnnao03h8YXGgZUNXrgzCzZkcoxRDTgH4Q2SvXGd5YSevUy/qg0NnU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB7291.namprd10.prod.outlook.com (2603:10b6:930:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 13:40:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 13:40:40 +0000
Message-ID: <5e4e6fdb-03fe-4541-8f09-8300665551a2@oracle.com>
Date: Wed, 7 Aug 2024 14:40:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] xfs: Unmap blocks according to forcealign
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-13-john.g.garry@oracle.com>
 <20240806201438.GP623936@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240806201438.GP623936@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 3200b4fd-1b1a-42e8-f6f5-08dcb6e686cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjUvNDZSTUxKQWpTb3o3Lzl5TDZ5N2l0bGE0M2hiNE5aMnEwa3QzTlJFMmk0?=
 =?utf-8?B?RWlITkxZeDljWnpIR1M0WEdJMENndFJDeWxJK01kTzl6anVtZHNMUlNhMDh3?=
 =?utf-8?B?OEl2Skd3UldEeVovZDlRSGxaakdKMVF2MzMreklOaUtJOXF0c3B0SlhZVE5R?=
 =?utf-8?B?cFE5MldiL01ESmpyNGY3UmlnaXIrZXhlVlZ6MjdMNlBuUFkzQ3JrOUlMOFBP?=
 =?utf-8?B?TEVPR0dXcjdKbm11RXZoSEtNRUFrUHNtUVlCQmhYMGJ5aUU0Q0c3Ykp0NFUr?=
 =?utf-8?B?ZURZNnFSSlhvV2lXU29lVE0wL0JMQ2QwejYyY1pwM0V1b0U3UjdJMnJkZHpa?=
 =?utf-8?B?ZC96azBZNk1WRWdoWnZlY1VDS2J6bjl0UUFhWFpKKzNJc2R2Q0F0R2lFY2Zm?=
 =?utf-8?B?V3BKSkNtSDg0UkE1azQ4S1pEZmxod3pTZ0VveXp3ZWJEVGtWaGNSbms4Njdh?=
 =?utf-8?B?L0tPR0l0NlJvTjR0QVNkZU1XUEc1L3lyb1ZqaTViZW9hbjl3MVNGemNPUTNY?=
 =?utf-8?B?SVMxRzFMeFF0eUZ3ZFNMRW4rZFlDSERoU3BmZjRLTUFjVWdmc3V6NU14VURG?=
 =?utf-8?B?YU9ERXpqUHdxNkQzV0hGZXkvQWNQVjdtaEg0TWIxdjFRYXF0N2x3cTFxZHVl?=
 =?utf-8?B?Yzl2QnZoU0tpcVlCdjRYNm9NSUZRRDlHQVNtZkc0dk5MTGFmc2VqVytsclR4?=
 =?utf-8?B?Q2hXZUJSNEd1Ky9USnQ3V2NXbzUvbnRzWWhwdnNuZ09tZEZyS25YRnc0Sk5O?=
 =?utf-8?B?UGs2TFRUNENEbjVXcDRNbUlUWkhraEx2V3FicWFyVmNWL29qeWgrWEp6bGpm?=
 =?utf-8?B?bjN0VkJlL1JKbk5FSUlma0RNSWNxT01TZ05Xb3NiaWZ3TEFmbGFhbkw1TG5j?=
 =?utf-8?B?TG55dWdzN1ptVVJHZ3ltaEsrSjVod1VIc0RlWnZXQnZCK2tnZURTb3FLeUJj?=
 =?utf-8?B?WCtDeHZvMEVTSFNsS2l2TmNKbnFMVWEyYTB5MnR1cVlTUmpUUG9KZW83REJO?=
 =?utf-8?B?VFY0ZjRyY3JCa0lLdHdZTTd1VUhuR014ZUI4ZnUxQm1xUytYWlVoZ2NJNUNq?=
 =?utf-8?B?OVhEbVV5TTJmMVFZYnB0Z0toR3lpTElwbzNlc2pFZ3V2ZHM2Ylh3cDNjRldT?=
 =?utf-8?B?VnZIK2VyYy9XUEg2M0RGL0ZzSWU1WE1VdUw5SmxKcHY1V0ZnUStHODNOTms2?=
 =?utf-8?B?d2JtaG1qZ3MyTll4Ry9aQWdBNEVGbGJwZTFJcTV6aUltbDR1djNsTlhLRGp1?=
 =?utf-8?B?WHhKcmwrNGlQb1JLQnFWZGJGR0RteTBMVitJQ3RWendHR0pNU0NrL2Zvc2Uv?=
 =?utf-8?B?NmYzYVRLcTZKMGNRWkpTWGhVZXRoWmJpaWlTbVVwd0pocjlpNDN1aGV5NUxm?=
 =?utf-8?B?SDZQSkR5TXZqd3dTYktBZXhBY1hOaDJWTXJoM2MzQ3dLWWhvTFRibkhaOU1w?=
 =?utf-8?B?U0EvZCtCZ3F3Q2wxS21UUXpNUXJtcHA0ZE5uajN0a2JCL3BwaEYzVWhtRHBP?=
 =?utf-8?B?dzNhT1lvWktCTzRnMXFsOG1UbktWeDFhYWVoSkhzK0VtckkvM3p0NDlGSnlp?=
 =?utf-8?B?dHdpUDNURUlLN0cvcm94KzhOUFVuUEFZaFZQTEladnFCRlNqa0ZHeEtXSnBj?=
 =?utf-8?B?Vzc5NWo1SitPcitIL2c0bWMyU214Q3cyWE5qQURvVUFIZGFMOUUrN2dzV2Z5?=
 =?utf-8?B?ZjUydXBIWmJ6NlcyaWJ5L1h0SUZFdW9wWUU3aVA1ZFlSMmFuZVZZYi9PL1oz?=
 =?utf-8?B?YlYwQncxN2JJVVNvK3YwMllQL0UyZ0V1M0tlSkNqZ1lPSVpiNDIrenBhd2tt?=
 =?utf-8?B?YldsRG95aitKRWUrL0U0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjNDSFFuVWhnQlk4YStMc2xPVGlxdWVmWTkvOUhQaDYrTUFSZVZSMnJ6ckFl?=
 =?utf-8?B?bXZZZUxzNkJiOE1yZDRVSTByb2ZTbGZnb1JTMlFMb1JPNnhSVVJGWUVXZ2E1?=
 =?utf-8?B?TUQwQThia1cwOFpZSzc1M1RXYk5tM2haOElVRlNrQ0NLM2NVNHNFZnJ1UFNI?=
 =?utf-8?B?L1RvRjk5ekVFSlVtbDc1ZVB4Y2dYMjZPNTgvRWxQUWw2Ui84cGJKa0RrK0la?=
 =?utf-8?B?R0o1OGcwNVNxNG1jeUw5VHNzRjVUTTByeDVMVUJrd3NITkhZU3pzMVMzMWNR?=
 =?utf-8?B?N0x6RVdjSjdpSWthSkxPMTRRZzdhNmR6dG43WkRGbm5BRGg4S2EybEkzNlR5?=
 =?utf-8?B?NXlhRERTS3RmME8vSWttb0R5YmZPWWVJSmhEZ3kzWGlSSTM3SktzT1lDdldm?=
 =?utf-8?B?RkJEM1NISW9XaFpRWTlGMHBpUFRtODlBYVNXTVFmRlEzQWFoWkQ3cXJHL2h0?=
 =?utf-8?B?anlveEdHRTBNdUVzb3MxZ3J0WjJPTmxsV3pDTTlsbk11QmRkTVlQTEttSlRC?=
 =?utf-8?B?N003V3QrWWtYTXV0Vk5XY2dFbFRXc1dHV3cwWGhBYVdHZkRhTFhkK3VDN08x?=
 =?utf-8?B?WWV5SnNnL0pseW43dUkwOWhoZXVGamQrZzUzZUYwZzR2ckJWVjFSVG8xZTBZ?=
 =?utf-8?B?SEVpdGorWDdkUDZYUmp3WHF4eWZDM2syWlFWOGo0VlU3Ym50eXVVTXRyQ3k0?=
 =?utf-8?B?TGtaZXRwTy9qa1hHYllMakV2aTd2eDVsQmRidkFTS3hlS2F1YWVMY21VUk1z?=
 =?utf-8?B?VTRYa2FVUEg2NHV3aU5POEI4RHc5bTVqa1U2YUpSbWxiUjg2VW9ucWtYMzBy?=
 =?utf-8?B?bDlsYkZDQUtjdks2WW5QWXdrRHFBNUdxenVPSVhhMnVac0xZY0I1M3MwTEpG?=
 =?utf-8?B?MHptTm5ndDJGdDdKWGxpT1EvMDVGbXdXY1AzK1dKMHpwUmZOQ0VNTjFBWU9x?=
 =?utf-8?B?dFJqWUs0ODhwNi9vbUhUSVJIa0JOdXFkR1E5ZEI5bEVCTmhLWWZJSDJGSy9W?=
 =?utf-8?B?U0s4R09iUUtXLzVlZnByNC9zMVQ2bnQwaUg3TmNQTzNwbVU1bHZPQW9iVFIv?=
 =?utf-8?B?MXZXaFJzY3JaY2s2R0F2WXBvaThUVTJoQUZ4V2VHNDB2ZEkvTjU5VTh6VmRh?=
 =?utf-8?B?TUZKeUU2ZHJYWkMvWktUa2N4N21pTWo0VFBSUFFzMWpJalp5M2RCQWowS0hD?=
 =?utf-8?B?N3FNZUl4WlZSVUtNMUtTOHF2TjEwQnN1NFZRWGd5ejQvaUJyNThUZ25ZSE1J?=
 =?utf-8?B?c1J2RzAwaGIyNFVZSlVPV080TUtOLzRFZ0lKWU9wUkZ0M3U4czNpNHoxdVVP?=
 =?utf-8?B?OGJlVm1udTlWalh3SWVsMDZOeXJkNmVmd1laVkQ4Z05rdWV6L2g0T1NPelB3?=
 =?utf-8?B?MXNuQkZnOWdaSTIyTDBaZXk4K2s5YVlUTjJ2cXVhc1F3Y1EwdWVyMDRtbEVo?=
 =?utf-8?B?L2Y0K1o3VGozQXk2MGtkUSs4MWg3WkpKUENSdTVLN0lsenM4SWNxQVBObVlD?=
 =?utf-8?B?aytFeHZlcUdoLzFDN0xXZXRObU5oQjRRaGt0WTAxS2JqQkNlVGlMM1BOblNi?=
 =?utf-8?B?bHVvbUNld21MUGNOUlRzZFN3VGRSaExjaG9RRmpRckplZkFFbzVCbWVyU0dl?=
 =?utf-8?B?Z2dKQTFtTHFtazNqNDMwdldVTk9LT3dpZm1xRm5PbEhrSGpndnFZaU92UHl3?=
 =?utf-8?B?TzBHcG5wZDBGNnJMU2srSmFIR0pzb0ZRY2ozNzFMWEIzcXlrNTZuNGt3ZE1h?=
 =?utf-8?B?Ulh5K2lOUlJ3OGFnTStUdFdCTXorbnQ0U2Z6ZU8rcHRoWHM0QWhNdXFRSUdX?=
 =?utf-8?B?NW9SWUQxWldrU3dUdThrSnZrMTJyR00vMGxxVlkwTTFjSEZWNTBQR3h4VEhw?=
 =?utf-8?B?N1ZpeWhUWC9lbjYwYUlFUHRoL2JiOUZCNSt3a0hZL09VMEZUT240Ny9WbjBl?=
 =?utf-8?B?dWdmZnNzdDhxMUQ0a0QzM2ppK1FIYmhvWU9NK1Y3VmFRM1laUzN0RVJsQk51?=
 =?utf-8?B?Y3pSUXJ3M2xzVStja0E4NFkxUGFMZGtCY3hpZ3daVExiZkVDU2dSRC9tSS9m?=
 =?utf-8?B?YUJBZEZWYWk4cW4ySVVicFRVVUZHUFkxUmxvc000cXBHYnJPNUNzRzlxL25B?=
 =?utf-8?B?MDZQdGJHaTlScjVYTXdpcVpLajlLOVkrMitRRTFFK25IbTllYTVOa3FsOTky?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pxNl+TfUVkce5vglSuFj9+4VVMYZ6fhd9Ie9ucyh3BfxMWkz+cqf+JmudeJEw0tJfbxQIOEdga5tn2UkBFLI6gkv15dJWO9UOPxnhY+NOcIOhmxHZGNMWp78ljgptMvujD5GzusybfeUrO3DcszS3/zFZLx7YDwQisOP/aTjVDDCbC/g6QGfQPVzTGtLIKshPC6+7ha/yWDRO89keuEjxuVAjt/4fVhr1t2j2tQU1CWQGIZvofmDdJZylT7Fw8R/cokm2h13g8FhhAWK34Esk+4z5Jt5H7irmUati3wqTCEUvlIJ2whdbbRZut0DBiVHSrjrP3LMU5X2qSq4x8jqS1MKuWbhOc+bbJFDtB4ct0HzMM4ghuEFuFul39vyF3vgpwkszcgX81wz9Q0x1l1yE9+pqU7YxCA8Z+Zn0VmjNsSkLJaMopwo4U1J6r1CqYlTo/0cQs9f+X/yIdlaka2f6pA5fjxmE8HlZ/WRG+QCCsjI+HhShGB7nCVRqw/twIb2WD9RlCLjKJ/0Ef6yJ6E55aLVZX64kM3qOHp22re7pfOD3gjlcOjU5knmfEVyvKlvz6OU4ASzsbe4Rcxif8qxkwtjG/CkVtyczXxKumyr36w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3200b4fd-1b1a-42e8-f6f5-08dcb6e686cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 13:40:40.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUJGNShhO2NQIyDcMGHGgzc18Q1fxCYsujvUXyqWYZRyaZw4esjdLXRqmVypc4yJkTE+rAZEFtRhwOXVv3z+zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_09,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070095
X-Proofpoint-GUID: gdg_YsB_o8bRcIRKwgaa7diaheaIy378
X-Proofpoint-ORIG-GUID: gdg_YsB_o8bRcIRKwgaa7diaheaIy378

On 06/08/2024 21:14, Darrick J. Wong wrote:
> On Thu, Aug 01, 2024 at 04:30:55PM +0000, John Garry wrote:
>> For when forcealign is enabled, blocks in an inode need to be unmapped
>> according to extent alignment, like what is already done for rtvol.
>>
>> Change variable isrt in __xfs_bunmapi() to a bool, as that is really what
>> it is.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_bmap.c | 48 +++++++++++++++++++++++++++++-----------
>>   fs/xfs/xfs_inode.c       | 16 ++++++++++++++
>>   fs/xfs/xfs_inode.h       |  2 ++
>>   3 files changed, 53 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
>> index 0c3df8c71c6d..d6ae344a17fc 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.c
>> +++ b/fs/xfs/libxfs/xfs_bmap.c
>> @@ -5409,6 +5409,25 @@ xfs_bmap_del_extent_real(
>>   	return 0;
>>   }
>>   
>> +static xfs_extlen_t
>> +xfs_bunmapi_align(
>> +	struct xfs_inode	*ip,
>> +	xfs_fsblock_t		fsbno,
>> +	xfs_extlen_t *off)
>> +{
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +
>> +	if (XFS_IS_REALTIME_INODE(ip))
>> +		return xfs_inode_alloc_fsbsize_align(ip, fsbno, off);
>> +	/*
>> +	 * The agbno for the fsbno is aligned to extsize, but the fsbno itself
>> +	 * is not necessarily aligned (to extsize), so use agbno to determine
>> +	 * mod+offset to the alloc unit boundary.
>> +	 */
>> +	return xfs_inode_alloc_fsbsize_align(ip, XFS_FSB_TO_AGBNO(mp, fsbno),
>> +					off);
>> +}
>> +
>>   /*
>>    * Unmap (remove) blocks from a file.
>>    * If nexts is nonzero then the number of extents to remove is limited to
>> @@ -5430,7 +5449,8 @@ __xfs_bunmapi(
>>   	xfs_extnum_t		extno;		/* extent number in list */
>>   	struct xfs_bmbt_irec	got;		/* current extent record */
>>   	struct xfs_ifork	*ifp;		/* inode fork pointer */
>> -	int			isrt;		/* freeing in rt area */
>> +	bool			isrt;		/* freeing in rt area */
>> +	bool			isforcealign;	/* forcealign inode */
>>   	int			logflags;	/* transaction logging flags */
>>   	xfs_extlen_t		mod;		/* rt extent offset */
>>   	struct xfs_mount	*mp = ip->i_mount;
>> @@ -5468,6 +5488,8 @@ __xfs_bunmapi(
>>   	}
>>   	XFS_STATS_INC(mp, xs_blk_unmap);
>>   	isrt = xfs_ifork_is_realtime(ip, whichfork);
>> +	isforcealign = (whichfork != XFS_ATTR_FORK) &&
>> +			xfs_inode_has_forcealign(ip);
>>   	end = start + len;
>>   
>>   	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
>> @@ -5486,6 +5508,8 @@ __xfs_bunmapi(
>>   	extno = 0;
>>   	while (end != (xfs_fileoff_t)-1 && end >= start &&
>>   	       (nexts == 0 || extno < nexts)) {
>> +		xfs_extlen_t off;
> 
> I got really confused because I thought this was a file block offset and
> only after more digging realized that this is a sometimes dummy
> adjustment variable.

yeah, I put it here to use the common helper in both callsites

> 
>> +
>>   		/*
>>   		 * Is the found extent after a hole in which end lives?
>>   		 * Just back up to the previous extent, if so.
>> @@ -5519,18 +5543,18 @@ __xfs_bunmapi(
>>   		if (del.br_startoff + del.br_blockcount > end + 1)
>>   			del.br_blockcount = end + 1 - del.br_startoff;
>>   
>> -		if (!isrt || (flags & XFS_BMAPI_REMAP))
>> +		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
>>   			goto delete;
>>   
>> -		mod = xfs_rtb_to_rtxoff(mp,
>> -				del.br_startblock + del.br_blockcount);
>> +		mod = xfs_bunmapi_align(ip,
>> +				del.br_startblock + del.br_blockcount, &off);
>>   		if (mod) {
> 
> Oof.  I don't like how this loop body has the rtx adjustment code
> inlined into it.  We only use the isrt flag for the one test above.
> I tried hoisting this into something less gross involving separate
> adjustment functions but then you have to pass in so many outer
> variables that it becomes a mess.
> 
> The best I can come up with for now is:
> 
> 	unsigned int		alloc_fsb = xfs_inode_alloc_fsbsize(ip);
> 	/* no more isrt/isforcealign bools */
> 
> ...
> 
> 		if (alloc_fsb == 1 || (flags & XFS_BMAPI_REMAP))
> 			goto delete;

ok, good

> 
> 		mod = do_div(del.br_startblock + del.br_blockcount,
> 				alloc_fsb);

Note that xfs_bunmapi_align() uses agbno for !rt

> 		if (mod) {
> 
>>   			/*
>> -			 * Realtime extent not lined up at the end.
>> +			 * Not aligned to allocation unit on the end.
>>   			 * The extent could have been split into written
>>   			 * and unwritten pieces, or we could just be
>>   			 * unmapping part of it.  But we can't really
>> -			 * get rid of part of a realtime extent.
>> +			 * get rid of part of an extent.
>>   			 */
>>   			if (del.br_state == XFS_EXT_UNWRITTEN) {
>>   				/*
>> @@ -5554,7 +5578,7 @@ __xfs_bunmapi(
>>   			ASSERT(del.br_state == XFS_EXT_NORM);
>>   			ASSERT(tp->t_blk_res > 0);
>>   			/*
>> -			 * If this spans a realtime extent boundary,
>> +			 * If this spans an extent boundary,
>>   			 * chop it back to the start of the one we end at.
>>   			 */
>>   			if (del.br_blockcount > mod) {
>> @@ -5571,14 +5595,12 @@ __xfs_bunmapi(
>>   			goto nodelete;
>>   		}
>>   
>> -		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
>> +		mod = xfs_bunmapi_align(ip, del.br_startblock, &off);
>>   		if (mod) {
>> -			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
> 
> 		mod = do_div(del.br_startblock, alloc_fsb);
> 		if (mod) {
> 			xfs_extlen_t off = alloc_fsb - mod;
> 
> At least then you don't need this weird xfs_inode_alloc_fsbsize_align
> that passes back two xfs_extlen_t arguments.

Sure, but same point about xfs_bunmapi_align() using agbno. I suppose I 
can just make the change to not have xfs_bunmapi_align() be passed the 
off address pointer, and do the calcation here for off here (as you 
suggest).

Thanks,
John

