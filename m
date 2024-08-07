Return-Path: <linux-fsdevel+bounces-25300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C351294A84B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 15:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2462813AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD81E6751;
	Wed,  7 Aug 2024 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l6oo/O7c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hEHr8rL8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DC155C83;
	Wed,  7 Aug 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035999; cv=fail; b=HxmewKwnulOX4aycbTF86gDINQIms4iLFgCTVJO/625FTxrhj3wg1DnGYLy7ejyjNMa1SndZJXanrNO4CIXEQvzsj5JE36tOcGF7RzwDRSf+Y5Z7Wtb1LNLqFRNf1iXr8vzBbI6sMjRSoSdScWHk2Fjz57uo3XrSCulZ2NqjWEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035999; c=relaxed/simple;
	bh=SjyfPUzBMwRunAa6XWXb9SX2vVye7WI0S4J00T3DcXk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O5fR4XguLrqies3gIRIFe71lMcpPODW++MwEQDYN6b6nbZ3m1n4PS94w4C1pmoBGzbWZm3L4ksFWzfI8MlQ458hNHlvLvgv4QvRWZdWNV8KpwnVSTsEz4pmG5WFL02lHPB2vJ2aPqRHNmNtNts+MpRu8PPCDJ2FBCvCsnpEfUH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l6oo/O7c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hEHr8rL8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477AT9lI018603;
	Wed, 7 Aug 2024 13:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=jIH168iKTxfKNS3e9IQbhe8uVGlyRs37ktGeaRNf0ug=; b=
	l6oo/O7cZdf/1cPsFaRQDX1kYhWTz/3ZFk5VbykVjA2JaGlV8ixXTyoNjacEJGOT
	RgkVp3yTDqPorbfCP2mmhQOWK67TVIwiqSof2vJs8aw1GZTEgzplRZbUxjYeCnvv
	9JQzx6OBD3iZvA+c/TbsRL6E0N/y5iCWEkyTUR8iJBvDN7YC+XB9CBUcXrQteVcN
	mlsV5E0ues/AWA7f6kW7gv/UuLSD0FP+zUIMg6Wf89iXFP2imq+uSaZ+nibpQAmy
	LzLOcgRsnPkc3FgAQMYjca/Oe63qIE0Gr3I44ZsjFPktMXRcioDAmwdvK/cwJDgD
	gW9mk5WNRAoYvEzufXyS/w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40saye7fnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 13:06:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477Bo1Jw017929;
	Wed, 7 Aug 2024 13:06:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb09yesn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 13:06:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D13aFzp1GVlcmfCzbK9LKcEhZaZKGBqwgdULeVrdjPDKXTu8jpBN36OkTJj7ihN5EzqveyMEnYGQeANEvF+wWHBNjQZMcPKF+GOcwoWgWFvQ4rIf3WsAxI3Of7ImDHfY+rvLxPjw4BxmENkWdJtPpcogODrgNWBuwipiNGYmINwAbwsA7Mdk56QTX7H/yTzw3pGmkfP0tcwiiuI7rPMmzbDUXKkWKEntlKwKBbYyc98bAqzyN9P8pIq19L6r9RTjHWzE99rES6OQaTcNfvKRHG098CxPDg8N8uYlvdC9uPD2QW/Gp7PoyIH31sYcXtSkwxbKv0ju0wn7dZZOG2Rz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIH168iKTxfKNS3e9IQbhe8uVGlyRs37ktGeaRNf0ug=;
 b=g4hMKD0N4nc6z5kXtw/JXLfhFnggaZH0MPCSNxmPiSngXJ8kTSaUUqngsVLBLxz36/Rq6uybJxfd2wvUwn5hLNxg/os5QDdtMJ149H9rm5mm4oTQrl8LniI9UKae6hhzT92KDNkWjb/U6FajxYhCjHcQ0TjUoDMyRDfWs6q5EI5mmvaQ3tbUVnmvWQ98fwdQHsWY1gZKS6S9tcok3BlpHoqgJUmqGwVrfBM2wZSVHh76HFqNZsaRdFysCOtB5c6eQmdqo8PRsViQzLtJ1ljhBlPSoRDOQ6B8fdb1w//CQGlNpMhsT+4XpqEjdR01zQcQ5QnBEVi/X4I3DvNm8GGayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIH168iKTxfKNS3e9IQbhe8uVGlyRs37ktGeaRNf0ug=;
 b=hEHr8rL8V6xYTAdie1ki3F+QqT/mhJ7ltU0iXvnmQ2uS8xDT+J1zbPoqTf5p3xlE53VwekjZ3eVg+7KWgNLpwrKu+jNFG+ST84S/0SGxgoxUNyZAKmWPiD5IiTzwMx3WUwYWS8pv2NfoNq5iTgKB8g+02LUPwfXm5MR0DQw8xNI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4521.namprd10.prod.outlook.com (2603:10b6:806:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Wed, 7 Aug
 2024 13:06:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 13:06:18 +0000
Message-ID: <d1b21f69-8590-4909-87a6-8cd050caaa28@oracle.com>
Date: Wed, 7 Aug 2024 14:06:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] xfs: Only free full extents for forcealign
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-12-john.g.garry@oracle.com>
 <20240806192738.GN623936@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240806192738.GN623936@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0053.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b95c7b0-f423-4147-f681-08dcb6e1b99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THNxYVcvSHcwNDhqMklxM00xUWtsUXpyWSsyNWxTMXlFQWpHZTdxZVFxRTFB?=
 =?utf-8?B?R0w2SWpsQXk1SDdSdjFOS21GM3hqcVJ5aFR3c00zeVF4RmhhN2ZpQkx0cGw4?=
 =?utf-8?B?K2RlTmpRc3JCR0hkNVNBTVA4U0VscVFtZGtSUko2TzRuUFhaMUQwaUs1N1Nh?=
 =?utf-8?B?R3ptNk90aDhJN1hNU1E4Uk9ybkRIdUtZOWZYUEh1SllkSDFkWko2VUxMMjM0?=
 =?utf-8?B?dENiVnRWOW53OVFrM215MU9sQUQ1WGxCd0U4bEFYQXJDbXhtUUZTZ2lVTjBx?=
 =?utf-8?B?bjB4QitvcEFtNmpuUXBmUE0wWXJlQjhacEkvVlBiTWlEbXAzQ0RlNzloVFRB?=
 =?utf-8?B?RW9aVzdsU05ua2kvc1ROWVd4bCtCNkpHWGJDaXB4NXlaMDBsRXdHNWtsbHZq?=
 =?utf-8?B?SjdUWThlVDJuSTVSTVp6NVY4anUwTTBxS0J2V0pjSnBXSFBRMkl3aDF4Mmh2?=
 =?utf-8?B?VEJrTy9xUHFCaUdtUEZjY1ZEUkxSODkxQmFUYWFmYkd5V1NFM3Y2V0NhZTFK?=
 =?utf-8?B?Z20vV2JjZ3pUY3JPY293TzdhWkdOQ1pWcFdsY251NzVkdHYrRE1zOUc3UVhI?=
 =?utf-8?B?Q2d4WEZ2SHN1d21rSFAvVkpEVFYvUmthZjRNaVpMZjNUU1EraVFjUUtKMnMv?=
 =?utf-8?B?endwVlQyOWV4cnZnQS9ZRzl4dXJoTXFmYWFhRmFQT3RicXdLQzBXVU4xWUdQ?=
 =?utf-8?B?V1VpR3JVdis2KzZXcTRyQTQ0K0llME9aMW1NSkRmSGpzWklzWU1MRnF2TzNO?=
 =?utf-8?B?NWFKYnpKTGFEdnJuTGx4OE9EWU9IOUQ1ZThnUHJBUWlEekNQWncraEVyZHZC?=
 =?utf-8?B?Uno4cXZFOHhKZlVhVExCUnEvOGVnajU2d08rbkNybnU5N1RIM09nMVd4TFNY?=
 =?utf-8?B?dFFGN013RkJJbFJsQ0RvU2QvUDBUeHhmKzZHdmw4VVFLNEZYOFdReFR4UERO?=
 =?utf-8?B?SHVDdmVkeHpaVW9YK3RiSXV4S2cwYUtUNStJejg3K2FsbFNielRWeVBmMllj?=
 =?utf-8?B?MHBUdzNzS0l2aXNIOXBra2R5MHVuU2kzVkJGQTFGc2tZZlN1K2hwMFd6bnpW?=
 =?utf-8?B?c3BWTW5JWXR6VEVzcFd4cXR6V2NBZ0t3eklNd2N3Rk85ZXhlTWNibHI2NzRp?=
 =?utf-8?B?UEIrTVA1TTF4clBtams4VEVwSDFOQUNCb1FmQnFjRzBSOEdIaWorN1ZvcVYy?=
 =?utf-8?B?bTE0My8yZjJVNisxY29TaFdkVmp5bUVPWmhkSmVqMHMrb1hTYU5rVlRzYXFz?=
 =?utf-8?B?U2t3OWZlemJuZFdmdEkySzdCMUp2K24yZCtMRHlhSnhCRTlXbmFob0R1N2Z0?=
 =?utf-8?B?OU80SnRVV2ZzekNTd0VQTEw4bUt6Sm5uTDNualpNNk80NnQ2K3dKK29wK3hr?=
 =?utf-8?B?Ymc1VUp3a1NQQ3UxN3FoRUg4Y3NTRUlub3Q5YUVnT0d6NmpOYm02L25qREVp?=
 =?utf-8?B?WmNWREw3OFJGbGpZNWtjVTh5Y2tIc2FQZGEralB1cjJjMFV6OXJzeFBrNTd2?=
 =?utf-8?B?VmFrSHJSbkovRWZPalF3bS9EVVFNWnlQMXpUdm13YnZCSXBYRldSMlZyOEpJ?=
 =?utf-8?B?b2o3YmxCd3VrbGZ6amJjUDl4MUZ1Zi9LY3VRaFFTZVA3MmtFZ04yMmVYNGVi?=
 =?utf-8?B?OGwycEFUUXRKWGpKZUtSRDdYVlZkNVN5UnlsRXJCRk9vbjFqK0o4ZjJKZWpF?=
 =?utf-8?B?VW9WZTM1NVhSVzZqbVhzV2VlVk9XSnBDSkhjMlRmeUNQNWMvOUJldGFST1lI?=
 =?utf-8?B?Mzl2b3ozQ3BiY0tTcmhZaWZCNnpqb01ZS05HSTlHMEpvTGVsTWo2UFc1dHVP?=
 =?utf-8?B?dE9TYnJuVlo1MDZKMDhqQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTJoZ1dDWXF2b2VQWjJHckc4aUd0U0M4cVN1ZEpTVkZYRFB4c0lvTWxiNFRT?=
 =?utf-8?B?OFdaWVA4Y2VURk9kcmNuZXlhbnUva0gxVXQzWlJtRlhWQjZXZ1N3SzY2S1Zh?=
 =?utf-8?B?TERZRy9CNkkvTUpkK2hTOVlZZFMzZEJ1OTBzY1VXWXhhRDIySnJ0SUhGY1ll?=
 =?utf-8?B?SUNwWmdFbzVRclc4NkMram8wTE9ZbElidmtJVytleFBiYldCK2tvWXZCcHN3?=
 =?utf-8?B?RXNRb3FvOFhHU1Z1ZjRFOUV0ZnlWdnFNOFVXVmZBSXVpWnEraVg5d1lDZHNz?=
 =?utf-8?B?a3J5NldLY3pzUUdDd1hPRGRqcHVCTFNjaklFUm1KczErVTJTQUlPQjNJRytB?=
 =?utf-8?B?YS9KVks5VDlwanFSRG10KzZSOXJxKzV4QmFYOGtybjQ0cUFpZ051YU1TeHhP?=
 =?utf-8?B?UlkvekJDMFV5NWRvNEtUU0gwNk43SjZTMXByTWpweTNNckN3U0lMSHZhMkFv?=
 =?utf-8?B?b0pEa2tMeldqcVVhZzdUNkhGZTdsUm9EbXExU05ESSswVkpjbTNrbmNGYUkv?=
 =?utf-8?B?NHdrN1lKdCs4K0JWRWR3c2hyOFpRQkhwTXNhVllGcjBOZXlnUk1jSlVDc2hR?=
 =?utf-8?B?Q0d1aFlqd1l3SDZsY3JqcnNMRU0xUWpGUWRRRHVyQldXaDZ0bDFicFpRSXVp?=
 =?utf-8?B?MXdvbDF0cEc4U1lNVDFLQ3dXbGZqaGtST2VERmVtN0ErZzJ5T1YvbWZxQW5y?=
 =?utf-8?B?cy80K3JrbFZubHJTNVhuMkdJZmovMHE2STkzZnFpMCt3Rm5QRXkxWVV4QmNq?=
 =?utf-8?B?UWI4bVZKTG5UWXFOU2dTajZvU0UzdjFGUlZRU3J5TVpiQnFlcnNDSE04Y1hn?=
 =?utf-8?B?cWFwSkF1MVJXditkdmFXeWl2RGxpRzY1Q3M2Y3drREhqNDVtVkhhaUhRNlYw?=
 =?utf-8?B?dFVPRTlNT0RwUi9FZkRGMS94QWRrNG9Md0hjZzZLckNBOHZrN1ljTTdLcVVH?=
 =?utf-8?B?ZURudUliNitWTytwb0FSc0VPYlhEc0tleE5SUnp0Ukl3UmhFV0xXS1JycUgy?=
 =?utf-8?B?OGo1VHNaK1dwVUxwNVcyMGVnSkE0anQ0anAyTm83UGxsVkt3L3g3aGQ1dFE1?=
 =?utf-8?B?MmViSGJ2RzZ6bXp2SllJeSttYmZvOVlRdCtqdmlDM3ZZKzlERXNMeklxRFZW?=
 =?utf-8?B?dzRNOFlLVEVSbEhMcmNwcUZMaGdDcVkvc1JuSjZucGlMMDhVM3NWNVdBVFZj?=
 =?utf-8?B?dzFodnU4SFlSODUzS0YxT2hxQkw2OEk5djRkcURVcDQ0ZE1SRU5kdm4yL2x0?=
 =?utf-8?B?MXBFOENraWdDWEw3d25FRzBYd2NBL1FRcXMwb3FaTW5zdFhUOVYwZTJScmNj?=
 =?utf-8?B?MWFHKy82U2JGbEZkQVNGTDl3MFVNb2w1eERRTHM1SG9RaHJTekxmY0NJdHcy?=
 =?utf-8?B?NU4yRG1seTlyUmMvUUVlTXlzWmhxM2dlOE9raWFwVGxuT0RxRUd0K21xM01i?=
 =?utf-8?B?dmhRdFZ3NGZxRE1TeHpKWTFJdVVwVUFNRW1rU1MrVThIU2ZLeFBzRnI1bWpw?=
 =?utf-8?B?Smg3OU9YZE9mNkpTcHkrUVVXNzl4MU4yRDhSZlRPZFpLRlVTNkU0UjVyTVAr?=
 =?utf-8?B?am9KSG1YcFZlWW1FK05LNzZvampDWFdoQzRUT2hFSVp5NTVRS2wvSnZiSXF1?=
 =?utf-8?B?cUlXTXlXS3M3Z1lQdGd4ck9XMndpL2cxTWJ6UTlyU0lIb09ERzNScHFsNXJ1?=
 =?utf-8?B?VDdocFMzK3BQdUxMY201a1FJcDdwa2E4UXFnSVhrSXQxbkUvOWFTK3pqRnFM?=
 =?utf-8?B?VGNSaTdyY1MrbTlYaFZVUU1SRElveE5TcFdKaWxoeDVNOHRaMGV3bVRhQXRo?=
 =?utf-8?B?dUpGUldNZXRmTnAzZkdJWXJsTkxQRUc2VTZuZkpVdEdzN1ZMYzN6VjZTZGVi?=
 =?utf-8?B?ckpKeVpRVnZ3QklBWmRwVzNzM0U3Qjk4dWs3MFhicHIyNTdDY1YzT0FkUnBt?=
 =?utf-8?B?SE5PWlZMWUJYdEhycnA5R2Mzdk52Z2p6eXp5dFpnS0w4b3dKSjRrTDJqTmdo?=
 =?utf-8?B?M0tQejhJMnUzMjBzR3RyV0VTRFdnd053QzVDSHMyRjE4ZHR4K1pFaTJRMUdC?=
 =?utf-8?B?dzFBNzNJWnFzRkg2TThld3RwRnVTTDErcEM3Ymkra1RvSnhmUTM0dXdoQVk1?=
 =?utf-8?B?L1hQb0RMUGI0RXpqYzhXRDd5L1V5ZWY2c1Q2NHVUbVhjMWRsUVBKVENoaVh5?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EEA4dSEbLOXopMvkOOPFaNZhaDShGORB0PFX+lWjNR8dWANlmqnITgde+1b4kESAArbMq+J0oH5qIf3JqyXTYSEXk1J6TxZK473y/n1VFzBaw1UbJdeSYd/opkcHG0mti1hLTW44U7+wS1S6WliWePivGfEUt+JvzqB7gyS8S/ZAEVX5A95DRhmwO3pPddel1Qyoq3byQrGBE3GyrYGJDdUQw9oEW8NyWL2O/higdcGZAE0fqoN7j6WAvjiWhRENM0bTey0/dYF5Su6yLD4Qj7BDate2RbzRG0ijFmLTZ6ABihQI7cg1vPnWTyhxCY09RmOwX0Wv33oRMyOFXEycOPyX+4iwYDMmtSb1p7lJPMomhA0+dPppwS3GTsaDqMc+sC1ITgWTzBDmbY1IkSa4XhrVH9TxYFYjcE0qQRLsuEz18ujhU8Qwl3ymWv+xlZ3fns5ibsMH6+A4U4+ivQjNCUTw14HnKEO3Y3XxhDAXpoPt9rwuad8uPyK79y6CXsQAuUtD7sZ3zAZs75oqZoKYfapBxiejFyXg0F5ehV9kgPOefUvt2EwITxQCz8xwjAiOU8Zz+QJNIsYh53wpTc/Gf43Il8ZAWFNUzdN+lq7RIeo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b95c7b0-f423-4147-f681-08dcb6e1b99b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 13:06:18.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GBD/dfaj4vf51V6w2ea7OyDDqG0Hnmhlk0nmoox+q6g/k62QIMv187Wuipxnt1accXPJ4yA8/9jm0ni2ags4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_09,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=970 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408070091
X-Proofpoint-ORIG-GUID: YSY2lxvQLSKXteZYnB5w7VnwfvqThxFy
X-Proofpoint-GUID: YSY2lxvQLSKXteZYnB5w7VnwfvqThxFy

On 06/08/2024 20:27, Darrick J. Wong wrote:
> I guess "roundout" means "extend start and end to fit allocation unit"
> whereas "roundin" means "shrink start and end to fit allocation unit"?

Yes, I was inspired by wording "inwards" and "outwards" used in a 
discussion in the previous series. Anyway, I can change it as suggested.

