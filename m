Return-Path: <linux-fsdevel+bounces-42571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 827AFA43CFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 12:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18871189EBA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D584267B0B;
	Tue, 25 Feb 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LL/Xgr0H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mWJcL77+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F2267B82;
	Tue, 25 Feb 2025 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481632; cv=fail; b=J9c7wl+LcMGri8kr0DsMtEB35l/B2nA8lWgnM5JC+/IMJu6Vs7fE0lWqGX1wIafx2YJ6FtMG8jP+MbKmLnmLzI9CLjhrLIM9hbt95EK4/KED+wO3GcASQPNogO4Xnu5nu/lPSsIybE7nNppfwpFesU2LwH/uy/x9DyZMXaPTAnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481632; c=relaxed/simple;
	bh=RScy5tLi/mvcBgXppKTdHTE776YMyNPVVokGu30WWHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QAV1AxY1iYKBpdF57e+Dhjrw59tn52WeUdkRI2dz1WgX1OcG24A8CS10Lluizjvp1ye/5j9fL2NToA5ioVPiZEw04Ix+gvGgguRmqvgjsHPFEsUP6BF21bZc1aud4wh64Z7WEarLAqeLXKul4Zzwx2cvCfCGyUlIGT+mzYNNy7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LL/Xgr0H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mWJcL77+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PABh9g013334;
	Tue, 25 Feb 2025 11:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pyOCBqJ1vWU2sa3ClP6uHylr6FhRld7vkgtvPMAKQOQ=; b=
	LL/Xgr0H1TyJ5Eus6v+9X/uAargOrDr2XZiCSdMvDVasyvWyi8GDGGzIYofo4pqo
	SJo4Br/IOFBVGBw2S2TLzSyP7oTBRj25ULkg5bPtTs5pWr7J7/YukXysX37KWKFf
	ZtI8Kyx6qknbtJ0zgVDnV1nKce2V50jDoPDHz6FM5AEcyv7edalmF8Q3CogGifKJ
	dUhYA40vcT5NstYjvcdX7B4ZeptIujd08cOASZ48lh4+skVSE7AUuJy17pYfjvM9
	bZal51Ns+7QZFteSJVQbbSqZUldDWB3rCLjrOB80KXL3rQeYNSfY2pmzQ0gESuiw
	NNF/miTDAXVSBL5bW3IgNg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5604v61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 11:06:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PAQBdY012594;
	Tue, 25 Feb 2025 11:06:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51a8c7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 11:06:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpUDfFJbwdb4mgl8i8cPJbCxBBGJLFQ7591UunIc/RLG4GjCfxgmqTLkC5w7jWkevLxCfwG4Vo5WKaOH+mdHTQENdOcE06GWMMl7Z3W5nvJ2BYzImFDg6H8qZKLx7/hSCTnDplG/z1O8BR4p3IagwyBqKITH9DWamSlpr1Sr1dtYoEpqQm8fYaLruCjJMwRKmShTPQzXfkIxFEbJeJc0+nkervampNlYfX2ZU9aoTuEA12CBmU7WAPT76s25SbpUH7WLazm2nyUEolENS/4pk2ZcOK62JqN8ZmmibClUoYGfEYSqHTOIoxWbf1NZknwovWSHeDa5Qqr+lw6ASgSS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyOCBqJ1vWU2sa3ClP6uHylr6FhRld7vkgtvPMAKQOQ=;
 b=FnDTz7UAQC4QsbfxAst+eDezpQU8pnzDij9cRbGeLEZS19vLpjpqu7pWcOuDafTJx4SjQl16eyOy/Qn07i73yQBuI3+ryBiNvKePHBYI5NaDn3WY083khgh+a5pSMg+2RQN6oQnzt1H/vB8DE8drVySlcBTsolWJp5XQPv/5XQrMiJzdXN7jZ52p+pHN8QKHZ8RT9KRElSUNj4oLlseGAzzcyNqJQ2SRHxbs7VrzBYEn2R+1nn/Oqjy1RcCzlKJLSVvXZj7pPpbkQvBMsY4Tr0PA587l3s63vbBPkPGgI55fu+S7gFGwYNJfPIpLJjCEo3on4O9R8ELBgL5NVCTbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyOCBqJ1vWU2sa3ClP6uHylr6FhRld7vkgtvPMAKQOQ=;
 b=mWJcL77+96q14U4XLyO0Mzu5VhYh6CItRmQQu0dFCl7x78ya5wH/HDYLZnYoyW0VhGwI7JbDdbYROEhyC2m0XYhjk1d4KqgqA2bKZRHhdgcZaUDQ3+eSeSixcjJec/acU5qxfrrhQwi6hw6+S6yARyS0C8WZi+tXBFY28tu5uM8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6321.namprd10.prod.outlook.com (2603:10b6:303:1e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Tue, 25 Feb
 2025 11:06:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 11:06:54 +0000
Message-ID: <4e78abd2-4f84-4002-b84c-6f90e2f869a8@oracle.com>
Date: Tue, 25 Feb 2025 11:06:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] xfs: iomap CoW-based atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-8-john.g.garry@oracle.com>
 <20250224201333.GD21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250224201333.GD21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0489.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbc4834-9869-4c4e-07d6-08dd558c8325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3k0WnhqcjdPcXc5QkV5dXowOXVPeUQreG5Ld1ZNbUh6cE1uV1c0WmN2bllX?=
 =?utf-8?B?cUEvOXRNNDhtUzV2NWQ2cUdsaHBjUjBRVE9nM3VTbTJvK2RtSlkzSUpJczI1?=
 =?utf-8?B?VnVUMHhlbjNqZ2FRTzRPMmJsK1plTFVtU0gwei9JTGFUQ1puRVJDZDlTSm0r?=
 =?utf-8?B?NFRvRkI5MlNuc1RCaGJuRjBhZUZtaEMxdUtNZjNaSkFSM2lxS3lqMlRRcTEw?=
 =?utf-8?B?dnNlUTBQbE9GdnE3QnV2TFFydnd0dVN2OTl3WUtQa1pjY2p2bXRFam9GWDdV?=
 =?utf-8?B?U0Q5SzRNWnU5OGsrSFZFVHB5SGt0dFBBNWUzZ1VYenpmWHZmRjR3UUJieUFX?=
 =?utf-8?B?Z0taNzdZclBWQ25CN0k5L0FDOFhFSmtNTURCTU92eWp4bXhxZjNsNmVjNG0y?=
 =?utf-8?B?VGhsUTBQZUlaVjlCRzBHWmdzL29CbzgxYTgzekFpaThqUDFlNHZHRGRDYjU0?=
 =?utf-8?B?THJOM2NOcEVZMGNwU2VocWg3ZVUrYmJaaFd6OVVQcXZLeit6QmJ0V01rWVYz?=
 =?utf-8?B?UEVRdUlNcHpOVW9XUlg2WlV6dm43aWQ3RWFHSUN2Ly9pYTMvcUlWdEFEZTZy?=
 =?utf-8?B?NWQ4cnVJbmZNKzRuc29oaU5HWU9yMkNIM2hXTFBmeWo1eE9CZ3pWbU5Pakdu?=
 =?utf-8?B?REVVUmFGM3EzM0dmWkpZWitjdlRpNndVaS9zMzVueFZtbjd3YldEd0gwKzN1?=
 =?utf-8?B?QkNTVmtCcUpmNm5ET2VoVFNtSWxpN3NnT0F2eG40SlZpMS9KUDJ1S3RUWHpt?=
 =?utf-8?B?YXFGeUJDcCt3Q0RrUWwyUGUzMjFEWjN3Ulp0TEFPNUNKdERzdkIrRXNnL3JD?=
 =?utf-8?B?UXFpTndXd0JsZGwwSWpSQTJWWUVsMVZlKzl1ODEvTlZSN3VMcStuM1JlR1JF?=
 =?utf-8?B?OG54NWdWZHZEK0MwbXhTbWtVVEM1NDBLWXJmZVpxNGxVeFgvUk4zNHRkT2xj?=
 =?utf-8?B?VUl4Tm92eThHOXBXZ3lpdmo3Mk52Y3lzZ0RDS3RlZm5WZDZ4dTRmREh3blI3?=
 =?utf-8?B?OHRvZllTTkJNWDl1UFN2ZndTN3A4VTNlMitBaGNSZUdHNk5NQkRFR2t1ZFRH?=
 =?utf-8?B?UWZVNXZxQ0lPMi9BUmhaVUhDRW1kREU0eUZ6bjlTN2hPWTg5Rjl2YTlDQThE?=
 =?utf-8?B?cXJaSXpjeUdhdjJ5ZlYxa05CQWtZbyszYzNzTGM2L2JxZE5EUjRObUR4bnUx?=
 =?utf-8?B?bUlSUEcrdnpnWjBFallYd2o0cUR4dFNvY3l4Mmsra3JRQlFLcVppWGVVM09a?=
 =?utf-8?B?a3JsQVNiSlBMMFdCaFdTRWNrRzhHcDFIYmU2MkpvejNncWZCblBvUGVqYlZC?=
 =?utf-8?B?dWxvMFlGdnlxbkVYSHZlZndmd1l5K21CMWxVMnhKU2d0ZzNVSXl1VlBUNWRQ?=
 =?utf-8?B?VHBESHBkaWFPdDFmS2FMcERna2lyaGFqSkhZeWZHSWZFRC9RRktqazZrTnZJ?=
 =?utf-8?B?MFFFcWN2SVZGUE5COWJFLyt4VWxLMzIweDJZZUFoRi9qZWFpOUwrRU9nY3da?=
 =?utf-8?B?Y3hlTUhkdnJiTXY0akcvTWZFbVlDRENqWEtXaEY2azRHTndqdEpOVXVjaDUy?=
 =?utf-8?B?dkd2WmRTL3cyVFhKZXZGWlgyRi94QngwZkVmakQ1LytXalJNQkFDZFQ0WFh2?=
 =?utf-8?B?eHRnaXp6ZUpXQWRCbDhHbmFWTVFmQUhMSDE2QTNZSGV3Wmtac0dZN3ZKdWE3?=
 =?utf-8?B?RGhCWTJIMWRwZ3FlS3lhdnNibmNhMkJPMVlGQVlSc0NGc0ZVL3UwTkpnN0Fx?=
 =?utf-8?B?SnJrVkt4aW9ZYWgreDhmMW1INXlCZUZGOUttbWRNNHArcnRZL1J4SGZ0YURq?=
 =?utf-8?B?bFdaVTJCa2gzVEFYeTllWFF4NWVlamZYNlhSanAvbG1DRkFSRVZ6UTFSWWVO?=
 =?utf-8?Q?ZtT/x1PQe57A7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czhCUUhtQ05BMmdpTE56REFxWUg2RE1NRVY3K3lJM0YzakNTTWNNYjBvTmtn?=
 =?utf-8?B?S21RellML2Q0NmM5S0d5ZTNxL01vQVpIQjJ3SHVRYUE5cERFZFZEbHJ2MHRt?=
 =?utf-8?B?eWVQSDBOQlllT29VUHhtL1dBR3BUNWVUZ0p2SXplWWdWa0hVYktlbnJZZ3dJ?=
 =?utf-8?B?WW02UmVrV1o2YmxoSGxCR3MvdGJNUnUva05oTWdkWG5qWGZTSDBLbzdUcVll?=
 =?utf-8?B?d0xMRTVRS3ZibFJZRVlDYkd5SjZBVzFiRXRWb05TekQyUHh5OGJ2NUIwVWIw?=
 =?utf-8?B?aU1aWEtBYzFNeC82ZHF4TE5tTVpBeTFObi93VTRONVF5NVhRSDBTb0xJaFJo?=
 =?utf-8?B?YnlqUXYyZ1RoMXBPaEJvd1FIODRqeFJZOXpnRFV1UG1QdTJHSERXQnppT0Jk?=
 =?utf-8?B?cFd0ellacXVjaXZQdURKc3NSZEk2RGtUY0VhUkFHaTRnNzl1K2xrMEl2TGNH?=
 =?utf-8?B?RnNtbHBpT2dkQjZlV2kxQkZsa09xdHNYRUhxYUVZeXFGYWltV3lNZ1JFSVdS?=
 =?utf-8?B?anh4c2hBMk5Md1hhdDFCL1NyaklkNStTV2xSNFp1OC9TM0lFMlZHMExndjdv?=
 =?utf-8?B?UHl2SjZnUHZLdmVGNmpDazN0VDlYM0gwSGVZWTEyeit5ZHo2OVMvS0VZQ1NO?=
 =?utf-8?B?ZzdpSFJiL2s5cmU0OFIvSDYzSk42K2d4cDZnSnNId1NuUzRXNWUreWVPZzRN?=
 =?utf-8?B?MXdTV2Q3YVZMamFFbEltUWQvZnVhTmZTUGFYNDhwVkZvM25ISDJSMEtVcXFi?=
 =?utf-8?B?V3RHQ1dibWFWcmxhc1g3SUorcVVDcjdmbjQ4Sy9SOFk2aS9pMEl0RGpMV0Zl?=
 =?utf-8?B?ZlRJRHpWZVJEVnY2TVVhbTFpLzFHdFVteWx0QVArcFNNbnhsdVFDU0hEVkxl?=
 =?utf-8?B?UDJmZ1haY1ZmK2dnQ0JSTVc5cFRRc1RaSlNYUk5FQ1VCUHRPc0krZGhXK2xH?=
 =?utf-8?B?dnA1bTJLTll6REFtVVU4ZXJVYmU5VVpNTy9VZGtDcU5MYU92RmVCaHIrU3Bn?=
 =?utf-8?B?T0JkbkpKTGFQSHk0ZWsvU2E0ZitBZzROMTZEZVdsVEk0K3ByOTFSYmNkNDdY?=
 =?utf-8?B?TDd5azBWR1E2ZmhCV3ZIOXV4K2lESnNDcmpaR2tQRDBTTlVwdFRtcklobmd0?=
 =?utf-8?B?ZG5wajRjaTd0MU81L1J5TTAyT2szLzM4SW1uMElGUEFuTlB6Q0JtOHdjb3p1?=
 =?utf-8?B?dFZsazNKYitobGxDWHEzMHh3Z3JVR3FoSjZXaDVBQm9Wa2pkVWtndGExcjk2?=
 =?utf-8?B?NUVkRVVWcEhJdkJFdkhURlo3T0QyMkZVM1VPOXBpN1hYQjV5NGwwaXFFanRq?=
 =?utf-8?B?alFodEJ5dXZ4Z2VFVXp2T0Z0UzFpbHo0eWJxUXRFbzkvN1k0WUxYTk5DMXR1?=
 =?utf-8?B?VTc3Wm9rc3pDak83bE9VeUNidGI5R1JLNHFoNEZaQ2x0T000NWhWRVg0K0J2?=
 =?utf-8?B?anFtRmxBOURjUW0zUy9RbUVkdXRidlRLTUswRWJ6SmtYd2Z5QnFqMlFWeHpD?=
 =?utf-8?B?KzdZNUVlNGFWREpOdUpuV1NrWTJJYTV3czVJMWszTUpaMG5BbGYySzZCRmk1?=
 =?utf-8?B?L3NHNytJVzVuOHFqVnNpOVkxMEZRVGlxWXNaV2p5NnRZY1N2Rlo0S2xIZ1Zt?=
 =?utf-8?B?aEhucCtHZ3p5RG50Skt4OEpybkFuL2xLKzFNTWFCVzQxMktjUFZhSW5NOVdQ?=
 =?utf-8?B?WmZkV28vdHJkcStaMFZKTktnSnhQL0x2ejgvbDg4b3I0cnJvTnJTcExXSGts?=
 =?utf-8?B?QVBFcDlTZTd1OGlnZmh5V3ZqOXVxR0xDK05IZ2tmUlZqK0xhdjRNMlZSTTdk?=
 =?utf-8?B?S3NoU3Uyc1JiN1Fta1hMK3BSN1FXMTBlbWttZjBNdUlPOERDa285NFZkVFNP?=
 =?utf-8?B?MlR4WXJ6YlZoMEtqbFdGbzZYT2dXbytMWGloQWlrYnBrcXMrbWdoY1JYODZh?=
 =?utf-8?B?OHBhK3JvOGlEdWY3dDZWbjljWmVPUmZiaUR6dVFINk9ZSXplQWVoL1hJMnJK?=
 =?utf-8?B?RVY5V0xtYmNXTUN3bVl5c0w4bGdJeEMrbTBwYlR0cnFYUS9Zck1iUWx3NEx2?=
 =?utf-8?B?NnIwVUpCYkpBSWpIN3NFcERrc1FDdDJSNXBGa3N5aWViY0hTZVk4aHNQeFZO?=
 =?utf-8?B?bGZCTXBpOHJFVXU2NnpoN1BneHVjUElyR0g3bUVXcDZ0aDdzVDQyMmxxNlMx?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Du90jO2b9dNGhlIOirjokyDUPGJtY5nCzVW0X/vaIQqmfd3/jMpwAO6W1OeH2pN6iUWv3g9Tn9PTiNJwuhWJ3D+rKYgVKKQeTyRQ+w/CDAC5yO2UmHJ3L1WzBm3X8wreZfVodUNvRmi7eVOxd1EUIfamcqLGwyk92/YRRoBfP9hwbAAiAkPOu7fYvjoFt4U1DcsXccWtJnzxH55PGHC7cQwEWBdFur39g8zhRUs4sX9yajnyS5SWuwDVx4voC35H4qy0PVkNZytbQ6v2XJdQ8/glHvqr3zTmqf2pbtnhgJtBYW+TS1/ehZEn4/LY0fJJRfdtFc7XdrvFUQvHkk57rE2angnxsReV8VhgjCtv9RFhFwAQjh2kQKPFfd+qWhAMPy/Zf2lglIzd/XbIOHarRDSLIWsSbtB1kANbITrSBUPeUEsMjXJlEZtYw5Ci63bHgSxG/Y99a8lQPUtf6ZRHH9pB8jB/iCZMH9LP0VXyhntT5iStTt74/8zh0LBfeGXMxy8AlWoOFz+6wklIs02jwXVkD3GaFXEP7RbkGpcdJSfQn8XjdxoySp8jMK8G/XyzadD1ytX+J35/12y0ipT9sVGQYaJPZUBITdY3vwxSNCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbc4834-9869-4c4e-07d6-08dd558c8325
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:06:54.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rc6KG6zJMQ9lew25H8jGk9guq5Q9SHIgsYakI/91xCzCjD3L9kal8pjKpCQqAfjpoKGSrwqj21Nab6MaZU0UDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250078
X-Proofpoint-GUID: R0XPGtTXBssiqBOjWHATpD_hubx_OmU0
X-Proofpoint-ORIG-GUID: R0XPGtTXBssiqBOjWHATpD_hubx_OmU0

On 24/02/2025 20:13, Darrick J. Wong wrote:
> On Thu, Feb 13, 2025 at 01:56:15PM +0000, John Garry wrote:
>> In cases of an atomic write occurs for misaligned or discontiguous disk
>> blocks, we will use a CoW-based method to issue the atomic write.
>>
>> So, for that case, return -EAGAIN to request that the write be issued in
>> CoW atomic write mode. The dio write path should detect this, similar to
>> how misaligned regalar DIO writes are handled.
>>
>> For normal HW-based mode, when the range which we are atomic writing to
>> covers a shared data extent, try to allocate a new CoW fork. However, if
>> we find that what we allocated does not meet atomic write requirements
>> in terms of length and alignment, then fallback on the CoW-based mode
>> for the atomic write.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_iomap.c | 72 ++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 69 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index ab79f0080288..c5ecfafbba60 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -795,6 +795,23 @@ imap_spans_range(
>>   	return true;
>>   }
>>   
>> +static bool
>> +imap_range_valid_for_atomic_write(
> 
> xfs_bmap_valid_for_atomic_write()

I'm ok with this.

But we do have other private functions without "xfs" prefix - like 
imap_needs_cow(), so a bit inconsistent to begin with.

> 
>> +	struct xfs_bmbt_irec	*imap,
>> +	xfs_fileoff_t		offset_fsb,
>> +	xfs_fileoff_t		end_fsb)
>> +{
>> +	/* Misaligned start block wrt size */
>> +	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
>> +		return false;
>> +
>> +	/* Discontiguous or mixed extents */
>> +	if (!imap_spans_range(imap, offset_fsb, end_fsb))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   static int
>>   xfs_direct_write_iomap_begin(
>>   	struct inode		*inode,
>> @@ -809,12 +826,20 @@ xfs_direct_write_iomap_begin(
>>   	struct xfs_bmbt_irec	imap, cmap;
>>   	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>>   	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
>> +	bool			atomic_cow = flags & IOMAP_ATOMIC_COW;
>> +	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;
>>   	int			nimaps = 1, error = 0;
>>   	bool			shared = false;
>>   	u16			iomap_flags = 0;
>> +	xfs_fileoff_t		orig_offset_fsb;
>> +	xfs_fileoff_t		orig_end_fsb;
>> +	bool			needs_alloc;
>>   	unsigned int		lockmode;
>>   	u64			seq;
>>   
>> +	orig_offset_fsb = offset_fsb;
> 
> When does offset_fsb change?

It doesn't, so this is not really required.

> 
>> +	orig_end_fsb = end_fsb;
> 
> Set this in the variable declaration?

ok

> 
>> +
>>   	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
>>   
>>   	if (xfs_is_shutdown(mp))
>> @@ -832,7 +857,7 @@ xfs_direct_write_iomap_begin(
>>   	 * COW writes may allocate delalloc space or convert unwritten COW
>>   	 * extents, so we need to make sure to take the lock exclusively here.
>>   	 */
>> -	if (xfs_is_cow_inode(ip))
>> +	if (xfs_is_cow_inode(ip) || atomic_cow)
>>   		lockmode = XFS_ILOCK_EXCL;
>>   	else
>>   		lockmode = XFS_ILOCK_SHARED;
>> @@ -857,6 +882,22 @@ xfs_direct_write_iomap_begin(
>>   	if (error)
>>   		goto out_unlock;
>>   
>> +	if (flags & IOMAP_ATOMIC_COW) {
> 
> 	if (atomic_cow) ?
> 
> Or really, atomic_sw?

Yes, will change.

> 
>> +		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
>> +				&lockmode,
>> +				(flags & IOMAP_DIRECT) || IS_DAX(inode), true);
>> +		/*
>> +		 * Don't check @shared. For atomic writes, we should error when
>> +		 * we don't get a CoW fork.
> 
> "Get a CoW fork"?  What does that mean?  The cow fork should be
> automatically allocated when needed, right?  Or should this really read
> "...when we don't get a COW mapping"?

ok, I can change as you suggest

> 
>> +		 */
>> +		if (error)
>> +			goto out_unlock;
>> +
>> +		end_fsb = imap.br_startoff + imap.br_blockcount;
>> +		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>> +		goto out_found_cow;
>> +	}
> 
> Can this be a separate ->iomap_begin (and hence iomap ops)?  I am trying
> to avoid the incohesion (still) plaguing most of the other iomap users.

I can try, and would then need to try to factor out what would be much 
duplicated code.

> 
>> +
>>   	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
>>   		error = -EAGAIN;
>>   		if (flags & IOMAP_NOWAIT)
>> @@ -868,13 +909,38 @@ xfs_direct_write_iomap_begin(
>>   				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
>>   		if (error)
>>   			goto out_unlock;
>> -		if (shared)
>> +		if (shared) {
>> +			if (atomic_hw &&
>> +			    !imap_range_valid_for_atomic_write(&cmap,
>> +					orig_offset_fsb, orig_end_fsb)) {
>> +				error = -EAGAIN;
>> +				goto out_unlock;
>> +			}
>>   			goto out_found_cow;
>> +		}
>>   		end_fsb = imap.br_startoff + imap.br_blockcount;
>>   		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>>   	}
>>   
>> -	if (imap_needs_alloc(inode, flags, &imap, nimaps))
>> +	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
>> +
>> +	if (atomic_hw) {
>> +		error = -EAGAIN;
>> +		/*
>> +		 * Use CoW method for when we need to alloc > 1 block,
>> +		 * otherwise we might allocate less than what we need here and
>> +		 * have multiple mappings.
>> +		*/
>> +		if (needs_alloc && orig_end_fsb - orig_offset_fsb > 1)
>> +			goto out_unlock;
>> +
>> +		if (!imap_range_valid_for_atomic_write(&imap, orig_offset_fsb,
>> +						orig_end_fsb)) {
> 
> You only need to indent by two more tabs for a continuation line.

ok

Thanks,
John

