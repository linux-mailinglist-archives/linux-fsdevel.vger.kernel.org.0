Return-Path: <linux-fsdevel+bounces-27182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3D95F3AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BA81C21D34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD77E18BC01;
	Mon, 26 Aug 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X2UcLl1K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZHa2UGT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF418BB9D;
	Mon, 26 Aug 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681807; cv=fail; b=UwbOFQLVXBQvKMv0DAgJAj891N/QP9qbICrSj68t7RAZnwAbK0tpRZJkNCL6TSgyFPo1xL313IWNFxMjLA9L1Q6mCDmtROWwV4f4l1qEE9L3XklFdYhB3wLvjPuwBFFpkCPJqAojjuCrRv1hFUXHFatq1FL2FoAiu6lFMelXNUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681807; c=relaxed/simple;
	bh=rH2IG62ql9zAHMv/NHHY9NKlNovBXFYm8/BN2kRndfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QgAYFsJwYUuT+EwRh2jrab96LjJ4i4EHbK0V+24r83YZasr55oVGDFN3wPUbe843UF9QcnSVJ7Qe8T1XSZhzpui1FxsqsuBARmQsILt/2bdYvA5yP7mEPD3sxIASCfBfsUQDGSdvlJ0BZokYH371svWaj82DX8v0mu1vPURDdUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X2UcLl1K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZHa2UGT9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QE2Yuw016139;
	Mon, 26 Aug 2024 14:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=rH2IG62ql9zAHMv/NHHY9NKlNovBXFYm8/BN2kRnd
	fo=; b=X2UcLl1KEGEQGofEheTjGrtTgOsIUpjb6qiS5b+0SK1Rtma2ZpR1dEFLl
	477ubtoVOcUx2ztXfRXvIK6DpzhXCU8SYurYqxiWyVJJuDU8k/GSgbf1WqaTDifH
	M+xTjYC654XS5HhMs8nCIc7FWrfOCiybogHWQGpMygCL2Z/D1CwtZ87i6wj5pbw5
	erYNWdEqF7q0f2c+SXUrGD7HloPeNXuErBTDrElEAj8TjYswm74bsRvixu4NacJV
	02BhAxTf89rIrbBRmHmrU50PlqafKoADi/avlXehqebujbYOjPPCv1aFnJkV3N9q
	t2aB6ne7S1mYweMQel8RwOlmWvQCQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177u6k95k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 14:16:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QCkuOg020342;
	Mon, 26 Aug 2024 14:16:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8ka6y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 14:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu6lrRmtZli42UGeOTTAAgmOwB+O/LR0antzuF3txEOp0dyhchem13j35mZ/yRIcfb/kGGq23G1MgSwUPf1KeOoOPO02ZrWBX8Kjc9PmbnHluz535hWO0tdY2u1OrkZk5OhY25jXqYqn4GT7P7HcQNqL4H9fprPDWm2Om5n7WO6cy9TohO7f7HBI6mA/I4Kx2R+DZArRU7Kbis8k/wPgVmv4vVAAg1nOsEltUZ1Xcdv+TfoVMC+r7tNRf/Zl8CfRRzyur1ZbOHfNYV7pZgzFM0qrxsbxeInqSsxHn+HEqEC7ludZMFmqx08DHJZcxk490iKTukITdcKnUN4aHE0MHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH2IG62ql9zAHMv/NHHY9NKlNovBXFYm8/BN2kRndfo=;
 b=JtZLn8xzGCKR0GvrX54YmxYXqdZ9ZzPetd4PvdqNVA6g8qBN+9EJ6+QkEWEqrk3a6EvLxNjMWuP2qIn9hkor5+top7s7OU9HupJ+JXS5hEGMyXE1NmG4IxNg/pQlEHSXTHv4RvOAm3UIhgw38uqYF2m2Kn8DegINs224V14JM9fo7JH57Ekefaiyq/creZSdDBhG+AscGartYMZbdKOcUVRbbI9AjN84Qokl/LPXrRbyDTgOVy4P+u7lc8FE7tfaTeB0DOdGo1zH+D1v2+aoFrKjsTviUljn3BRtmBEZJ2OjdwdMJ9X6Qk6TE/9zYHMBaPEWEHOdnQSVnQ8qQ49K1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH2IG62ql9zAHMv/NHHY9NKlNovBXFYm8/BN2kRndfo=;
 b=ZHa2UGT9GC0N9GJ9h/6jFign+IIrd4cnRzeXBrH0tTKw0u/iV/YKhnnNAtsjPe/WGjsqEsmRBoJCI8LmC8djFwKApEQ+sBXBEyKkPuOuu3iV/Z+1jn1tnMYQGdOfpnCJwBNVYVyVve9RiP2BUl9WTmVP2KkihYQJlmnpdJg60FU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6557.namprd10.prod.outlook.com (2603:10b6:303:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Mon, 26 Aug
 2024 14:16:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 14:16:32 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Mike Snitzer <snitzer@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker
	<anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Thread-Topic: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Thread-Index: AQHa9YhbNvtCvIGuMUWwsijEA0QsyLI4y2iAgADOk4A=
Date: Mon, 26 Aug 2024 14:16:32 +0000
Message-ID: <CC1D59C1-DFF3-4608-B2FA-29D4D9297D19@oracle.com>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-20-snitzer@kernel.org>
 <172463741946.6062.16725179742232522344@noble.neil.brown.name>
In-Reply-To: <172463741946.6062.16725179742232522344@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6557:EE_
x-ms-office365-filtering-correlation-id: cbd2ed3b-f59f-4448-52bb-08dcc5d9af83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEFLNForSFVNZUdtY0V5MEtqK0swR1BIMjJpd0FQMCswS0x6Tmh2aGhoWmJL?=
 =?utf-8?B?ZWFJREtyYitvWE1zV2VMS0dnMTVHdVduQ2FsRFpLakFzZmhaZWNxTTZveHZP?=
 =?utf-8?B?ci9ZdWI3Z1VLa1pPdXd1TmxlRHVwYy9UZ1FOYkppakRpVExXYUF5d0MvT0dl?=
 =?utf-8?B?bGlROGZVcC8yZlc5VTJqSktqN2JWMEdmK1BHeEtIZUFQMlBhd0MvVzJDNnlo?=
 =?utf-8?B?d2F5ZE9uOU9MNXBnK0pGNWY3Vk9MSXViWUpEOEZnQkFGM2gzeU1wM3VoT2Vo?=
 =?utf-8?B?bXpiWTN4ZzloQWhqYU4vUkN0ekFaUGtMLzhpUndWZDRvdkd1anY4WitZVTR0?=
 =?utf-8?B?ZXdlM2Z6SjhWUVVuOWo5QmFsdW81STNDRnBGL3AwVjJFbytRbXgyYUVtTkRB?=
 =?utf-8?B?a3NjUXQzMnlIeHdYZHBZT2pmd01EK3FMRWlySHdyc3FtT3R2Z0JydjlHQUxY?=
 =?utf-8?B?S3lma3d3YzRYUUY4WlFUTytwVTc5R3JFb3hHaTZseUpzNFYxdFR0Z2ZVbkxt?=
 =?utf-8?B?RlNjYzZ4SkRjRnJPTnJaTXFBZkJoZERNY3lMNUxMRjEzc0FXZW5BbE1ETTVh?=
 =?utf-8?B?Q3hJbEhRWnFKa2x1TnVLVWlwZFMzeGMyQmlkUS9FK3IrZFJaNWs3ZUVkZ29N?=
 =?utf-8?B?ajByTGR1dWlxRVVSa3oxM0N0c2hIeWRLZkh4NEFhbDBmQTZ0TjZlVHZsTFgz?=
 =?utf-8?B?NEdOQ2N1K0s1S0szU211K2xxWWZYOGdlZVpSdGdnYUZvV3BNelRVV1ArTENZ?=
 =?utf-8?B?UlhnY1hjZWJDVXFBTzhQQ2JQQm1ZL3B4K0pDNkM5NkRackhyTkJPNytSUmNT?=
 =?utf-8?B?djZScWtJTStBQUZLRkFxMmNaaDAzZFhsUUlNQkQ0WDhZYVEyTmJJM2dZakNi?=
 =?utf-8?B?WGJqbGRrVmxaVTFtUUx2VXVVNGhWeFVCRHpISGFhNDZxWFpsejdaKzZRNG1T?=
 =?utf-8?B?TEpsMXVuUnRIRzllWUJmZTh5d0s5VEEzd2xOdnhFbURvSXprQTFHdndJdzAz?=
 =?utf-8?B?bEExUUtGeE1FQ0wwL0VReW5RWkdYcjR1Ui84cDRsWXFSYkI0MitPT2VUYnRs?=
 =?utf-8?B?eXQyWnlHMlI3TWlYMnlrNEFCdzlRd29FczFLajl0L01acW5TRFYwcW5ubWo3?=
 =?utf-8?B?QkJjMGpMczdYR09FcmJGeDcxZlZzQ1QyKzMwMHFtZ25vUVNPWUVJQzQzRXg2?=
 =?utf-8?B?WFYxRFNCTmhZbDdOMXhDWUhQajc1TGc3azhGTGFQVHU3YmdVNURQTTQvOVli?=
 =?utf-8?B?Ri92SFd6YTh3dGNSWkFUR0d2Vmpibm1ETTBkdWdvNU1XNHBQb2V5bU4zeHNQ?=
 =?utf-8?B?YWxiSEx0eXlGSHpBdVE2Zkd5MmxzNjEyQ2w4VUVwamZyZ0s4S1ExNGR5THVs?=
 =?utf-8?B?WWF3NGtkT1F2dzNVS0pVTXl6SisrZFVYRHpnT0F0K0xmbnRSUS9NOXhqOUJI?=
 =?utf-8?B?ZHQ3WFp4VEJ6dzMzSlRpY0xEa2tMUGM3WWJweWlNN2lHZVNDU1lKdkZTeTlC?=
 =?utf-8?B?MTdTR00yREd1VUV5cWhWRzRqRWdNZjBtSUR5R052UDhPYUJnUGwvbmxNMlRv?=
 =?utf-8?B?UTAxZ0lMeFhXV0o3b2hkUFJ2THpwMjk1U21qVHZyek95QmRCK0M1bFVpeHI5?=
 =?utf-8?B?am4rN29OMi9rclNvZk53ZVZUbkpXTXVQL2VaMFR6RmVHSksxRkRIdGl6ZFhu?=
 =?utf-8?B?cTl1TTBiNW1mY0htNUh6YU9pZXpva2JEZGEyVnl2aXRqZVMwSStZTmlhSCtH?=
 =?utf-8?B?bUhwNElKTjNEWDBoR0YyVm5sTHJ5c2E3NExFNzdLZmViVFNSam5yb0hOWEx5?=
 =?utf-8?B?dlgrTEZzdEtkUTNhK3pkUGFIaCt2VnB0dHVrZ2JocWdDM04xNGZDdXlOc2k1?=
 =?utf-8?B?aU5sRjVaWTN1YjNicmYrZHB2RXRpQWNXMmluaGFmYm90a0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWdZZEFkaFBPd3hEdUhscTVXQ1pXeXA0YWo0VllUczlXRkc5ajdzWmV5ZjV0?=
 =?utf-8?B?MVhHTFo1ZDdEVTR4MU1UdXNITHBEQ0dtYTM0SjNLaW9PQUJGeVk2aDc5QXJJ?=
 =?utf-8?B?bC9LY0dSd3B3b2hIZnBWK0E3N0t6VVNweEd4aGNQVGNlRnlYOVc5eTBkVDVM?=
 =?utf-8?B?SGNMOWVna0FReUxBcVB2T2UxSXYwS0R0N0N3VXoyZWNTbGJEeUlaNWc3MWR5?=
 =?utf-8?B?d1UzRm1yZTdJOUdDODFXRURqMTg5WGNRT2xJWnA4NlhHMkxqQ0huYlJMWEgz?=
 =?utf-8?B?bVhRWFgxWUpvaDdjaThLOWUrajBUb0Q2NHlNMjdRdm1qTGhURVBMK1c1SlBQ?=
 =?utf-8?B?Y01KK0FsL0s2Q29zT3lHZyt4VjZ6bjg1NWcyd0o3VndhUFZDRHhyR1o4dlhS?=
 =?utf-8?B?eU83RkREUVY0aEx4ekFjb0pmMXE0b3dIZk12SmttaGJGMW1RM2R2MGxVdE96?=
 =?utf-8?B?QVB2OXpraHpaT0g4V0FvbFNRQTFueUI2Tkd0OFlHOWZhRXdHRExoOW4wek9Q?=
 =?utf-8?B?cG9QYUQ5bG5PclpaZVpRTXNrMjAwN2lWYWVMdHJvSEIrbFJmRE15L0VROEpG?=
 =?utf-8?B?NXgwby96aWIvNm9YZVROMXNRRkVTcXBZZWpnMnRDbFh6ZW5mcjdGb1V3Kzl5?=
 =?utf-8?B?MytvZVp2TjBaYmlEMEZ3Skp3b0NUSVc0NWFObmt0UzluaEM1SUw3OFE5R2JQ?=
 =?utf-8?B?U29WWDhMSkpiZHVTbWFvelJPNUlZOXBaRG1taWdIVGRCaU1sZ1g0Ri9OK0dJ?=
 =?utf-8?B?Y2VGeXRhZFRmU2hVc1pvVHNDN1pldzVpckZrOUVnb1pwVkl1bjZWQk9zWEhN?=
 =?utf-8?B?aGR1WThkTUtiZUZXSm55WVZNbVlJNTUyRVVBM3hNL2xOdU9pNjVYckg3UHJr?=
 =?utf-8?B?dEVzWWpreTgwamJ5TGtzQmlqcVRvM2FEWlFOWjFhNVFzdkV5RzVqUUpLRjhk?=
 =?utf-8?B?b2tMU2hOZDUzZ1Z1MlpVcXRIcVQ5eEttMTkwV0FzaFB5Z0VLYWpRLzI3OS9j?=
 =?utf-8?B?UUVoRHZqZmEvakJqOFYzV3Mxdmp6am42UUNGeEtlNlhWVWJ3cW1nQWZ4cU12?=
 =?utf-8?B?cXNSeG5MNk8rV0grcFlZYmJvR2FUUWVhVUEraXlYOFZNOUJCOUlManFvd3Ev?=
 =?utf-8?B?MjdtRjUrVG8xZGY1MkI1V0o4RGxyNThCME5rRDNXL3FhMm83WGc3Rld1L2NH?=
 =?utf-8?B?ZmpkcHRlclBlWHFkQ1AwZXFUTWMxUTVCMllGbTlzM2x0VmdReW1YSFdZMlNj?=
 =?utf-8?B?NzNZN0N4YjVvemZIdEswemdpNERsYVZuZUx1anpJeWZKb1psWXhSa3NpU3ZS?=
 =?utf-8?B?UjQ0MUJzM2M1QTRkK0t5a0Z4WXNxN1RSaHovWURYUjRIU1NXMEQrTEJXUFd4?=
 =?utf-8?B?L0JVUXgzUUVFT1dnbUxxTVJUYWNVenhMa2Y2aE91NDVmczhpa3llVXJwVlR2?=
 =?utf-8?B?akNvY0RqUlJpNnB4eUF6NXBGUDBLOTRjeW9PWHh2SmpwQWJlcDZYRW5taTdm?=
 =?utf-8?B?dHZWV2hhTzBsbWFkNTY0ZmtvZ0NDczZxbm1JeVIrRG9BaXV6UUVtdXJXZWtk?=
 =?utf-8?B?dERkNnNPQ0QxL0pESGtkdFFiRDJMOXRCYWh3MTg3UitoVjRBeEZyYXgxWTg5?=
 =?utf-8?B?L1p0NnpDU3VFZ3Nmc2JmY0Nqa25XU3FMa1FMRzBwMTJvdnFjZ1NPYklobHpX?=
 =?utf-8?B?TmRuc0pTTis2aFBFL0JDcG9KcjAwaTdIR3lTSkpLaVdSYU11b3JuWWN4SG5Y?=
 =?utf-8?B?dUZpSGttS0NnZHdTYzZXQ1Znb0MxSVFrSEk2RTFicmVnUEE4NlBSNWFObFp4?=
 =?utf-8?B?bHN1YlRyUlBsbUgySE54b1lEM1NHdHNWM3ZnblIxMUJNci9US2FEaFFXVGR2?=
 =?utf-8?B?d0xiVG42eWFPbG4vRkxvMGIyZ2xkbWx5RWRCMWovY1lUZU5vZktqd2cybGFU?=
 =?utf-8?B?WkxaQnp5SjIxZGVyVUxZdHBvTC9zN3dCamxQQW9KMWFLZEFJbkRWNmRIR3JZ?=
 =?utf-8?B?MTBhc2dTMWt0V09JY1pHTWRKNkhmOXhnN3NTVnR2eEs3NDkzbkxibDZqYml5?=
 =?utf-8?B?Q04zd2J0bVhxSWpkcDBDTWorY3QyM3NqQWJDS1VWMGQ2Y0pDeC9uRHhYOFhJ?=
 =?utf-8?B?Y3dFQ2tIVlMraUtYM2VQWmhSQ01lQ09meitleVkyV0I5SXd1cjlKbGZkYU5l?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <153A585B12CB5641BB897EE0AFD8A008@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JrNaAgPoYtNlGN+Kkm6GLEb8VaeVaBS3oDbxMplxVD9mD0XGttou/N7lqA8GMHoHyUXIAdNYdPT+Qy2GdIfwn00jQPILicDqBpLwzQZLOdQVGJCsuaAVZO+5yGep5ENUvwwgTJSKI/rBA21UlmYb1LUDwHL+qtOzArQptGTMP6ih5fuVrEK7q4CmKi3XRprzQGZATbVBgfdtnj2ZKi80mAdX9MDLqOc2WmJuut373yaoX/PFaIblfrlp3JfYEeTepGnIsMMSEafnFTEYzlwnEW5Y5IBsWDbJBePsFIeOrAll/sfvdrqnyWbFrvrLMmidh1twkqSzI/coCr+Bift+2kl2MFKQH4Snu+w9w/aWBZ7V3fcWvztxf65SbWOzWaReBF61tszYmHWIOqYMUsJXrh8Tl15vIFMvdFCdK6S7ZvAsxFzMhnFIAUIhHcLF42Q+5Uv/stumWUI+Xch5ENCFMURCvaGIPlVKw0tYg/mQtWjR9epMAMqRKdhCHXnaCft9oF7MQAeVGD6EOT1clSvt1YpnYmLcC7004RerixZTlQZbRFBat3TAEa8lnPWG1ZJ8VHIPryYc7+Z7JXvmo3MpgW38M5iXlbEvAdqSrlmfSGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd2ed3b-f59f-4448-52bb-08dcc5d9af83
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 14:16:32.2839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcCmkaDLPn3XTFEHXS0hf9MsYeeHho57ew1tm4QR07gmMjXD7Fh8MDRP9gNz7d2jters/MCJf8VQvjQmAWX5Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_11,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=976
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408260110
X-Proofpoint-ORIG-GUID: 3htoY8rcYGnigtMHnN27_GKibj-CBbHe
X-Proofpoint-GUID: 3htoY8rcYGnigtMHnN27_GKibj-CBbHe

DQoNCj4gT24gQXVnIDI1LCAyMDI0LCBhdCA5OjU24oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIDI0IEF1ZyAyMDI0LCBNaWtlIFNuaXR6ZXIgd3Jv
dGU6DQo+PiArDQo+PiArNi4gV2h5IGlzIGhhdmluZyB0aGUgY2xpZW50IHBlcmZvcm0gYSBzZXJ2
ZXItc2lkZSBmaWxlIE9QRU4sIHdpdGhvdXQNCj4+ICsgICB1c2luZyBSUEMsIGJlbmVmaWNpYWw/
ICBJcyB0aGUgYmVuZWZpdCBwTkZTIHNwZWNpZmljPw0KPj4gKw0KPj4gKyAgIEF2b2lkaW5nIHRo
ZSB1c2Ugb2YgWERSIGFuZCBSUEMgZm9yIGZpbGUgb3BlbnMgaXMgYmVuZWZpY2lhbCB0bw0KPj4g
KyAgIHBlcmZvcm1hbmNlIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBwTkZTIGlzIHVzZWQuIEhvd2V2
ZXIgYWRkaW5nIGENCj4+ICsgICByZXF1aXJlbWVudCB0byBnbyBvdmVyIHRoZSB3aXJlIHRvIGRv
IGFuIG9wZW4gYW5kL29yIGNsb3NlIGVuZHMgdXANCj4+ICsgICBuZWdhdGluZyBhbnkgYmVuZWZp
dCBvZiBhdm9pZGluZyB0aGUgd2lyZSBmb3IgZG9pbmcgdGhlIEkvTyBpdHNlbGYNCj4+ICsgICB3
aGVuIHdl4oCZcmUgZGVhbGluZyB3aXRoIHNtYWxsIGZpbGVzLiBUaGVyZSBpcyBubyBiZW5lZml0
IHRvIHJlcGxhY2luZw0KPj4gKyAgIHRoZSBSRUFEIG9yIFdSSVRFIHdpdGggYSBuZXcgb3BlbiBh
bmQvb3IgY2xvc2Ugb3BlcmF0aW9uIHRoYXQgc3RpbGwNCj4+ICsgICBuZWVkcyB0byBnbyBvdmVy
IHRoZSB3aXJlLg0KPiANCj4gSSBkb24ndCB0aGluayB0aGUgYWJvdmUgaXMgY29ycmVjdC4NCg0K
SSBzdHJ1Z2dsZWQgd2l0aCB0aGlzIHRleHQgdG9vLg0KDQpJIHRob3VnaHQgdGhlIHJlYXNvbiB3
ZSB3YW50IGEgc2VydmVyLXNpZGUgZmlsZSBPUEVOIGlzIHNvIHRoYXQNCnByb3BlciBhY2Nlc3Mg
YXV0aG9yaXphdGlvbiwgc2FtZSBhcyB3b3VsZCBiZSBkb25lIG9uIGEgcmVtb3RlDQphY2Nlc3Ms
IGNhbiBiZSBkb25lLg0KDQoNCj4gVGhlIGN1cnJlbnQgY29kZSBzdGlsbCBkb2VzIGEgbm9ybWFs
IE5GU3Y0IE9QRU4gb3IgTkZTdjMgR0VUQVRUUiB3aGVuDQo+IHRoZW4gY2xpZW50IG9wZW5zIGEg
ZmlsZS4gIE9ubHkgdGhlIFJFQUQvV1JJVEUvQ09NTUlUIG9wZXJhdGlvbnMgYXJlDQo+IGF2b2lk
ZWQuDQo+IA0KPiBXaGlsZSBJJ20gbm90IGFkdm9jYXRpbmcgZm9yIGFuIG92ZXItdGhlLXdpcmUg
cmVxdWVzdCB0byBtYXAgYQ0KPiBmaWxlaGFuZGxlIHRvIGEgc3RydWN0IG5mc2RfZmlsZSosIEkg
ZG9uJ3QgdGhpbmsgeW91IGNhbiBjb252aW5jaW5nbHkNCj4gYXJndWUgYWdhaW5zdCBpdCB3aXRo
b3V0IGNvbmNyZXRlIHBlcmZvcm1hbmNlIG1lYXN1cmVtZW50cy4NCj4gDQo+IE5laWxCcm93bg0K
DQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

