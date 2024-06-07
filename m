Return-Path: <linux-fsdevel+bounces-21164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0CA8FFBD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 08:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E7BB24755
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 06:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A714F137;
	Fri,  7 Jun 2024 06:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iA+SLFLL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="otqoT5bf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779B1BC2F;
	Fri,  7 Jun 2024 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717740321; cv=fail; b=o7Y+vVQBy5zlcqUftSkZBeZappU2tasER020w2Slpfrh69kQtob0NnIgnH4blVaSvEmB7nM4EVMQNuyqL5v5ZRuCW7dUbwsRItCxVHBg6vy52XYY/fu/N5DhBQcgIKe9lz2bZonbBDUZ+JLllSM6C1E3/npWgRCYutOK69koVzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717740321; c=relaxed/simple;
	bh=NF8Jmj190NCcWPHq8FBmCFh9TptalBobL306GBuHN+w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFhvgPuEbUhMT1neP+18NwLQ/La3Od93fUOU4Fsf52qOTkMP8nNf3OkxWpMoPUHEcFWgcALenrV6TXIx76aBkv3+6MaFt4GgVcVPi4djhxb0AxGHFs0XSt4wsr+9R0jnBgG2CE4Ahd2qIF+iaFVLCeklXmiqh2OXfqWnV2dUBSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iA+SLFLL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=otqoT5bf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45739b5F014978;
	Fri, 7 Jun 2024 06:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=eFKepE1yKUOKvbeElfXhnXFBdRK/fyvKjMuSE8ZLEEg=;
 b=iA+SLFLLfn4OznzUpI2+dUIdOQCENz5PCFnRqhU5EAwx6+uicMTTCE/czhWGg6uCRUXX
 UCQmHIMXKzt4VwNgB5DDir+2gdzyl6rkGiHNhdr8MOFqpyO8g7mCOxxlJesNvOVV/r0r
 ZsAWZjt+YVx3s8mgDORbov8ggMF/BhJuOwZoZfwetz49RmR/S73fct+1wDrSODmmUWON
 SXRjJ+nqNv7UjReSzWEctxRy5ea/WypMWCbJhq3JZHAuYSH7ynOEKEIXOshsbZc5nP4D
 swpudX1aBQfTJr+tQNGbexkVV8EBQb9zgstd9kgLAH25il/IBuRDCR50mypJQqTm3tu+ Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhcyd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 06:04:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4574TL2M020564;
	Fri, 7 Jun 2024 06:04:55 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj64cvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 06:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld4y/G2OnivwKs6I3fwc2aV5kDuBWktlsK7JaeHUqa1iLW4iDpYcE1q68qJ3tH4q3zxuT4i/ukabUnrRMdwX274/4qHnbQK1TrlYE11zhUyi8LweViDuBe0c69yp7Ih3qLr+LmEaMMtyiHs2GInp40zqnp+1v/bLouBy1zmNknRjpmOPYtaskoHTMuIpB5rUTRqxINpaZHWqH7w24TR7ZovtfmSeqHpqRY0hXPqHo47gfrhUEF+ooplSb1nEV8eubfPxYM9myo3PGmZ/Z1UhzeeTvwB9hfuINJmyfz2oXP5m6Bajrjjp/HVQS7Lgn64zwpb1FxVQ8odoCvvyCbeoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFKepE1yKUOKvbeElfXhnXFBdRK/fyvKjMuSE8ZLEEg=;
 b=JJh/X0jD5lYCpKONWgh92noqMREZNyNeEgttoKaWGlM5owzy51l5iwCLcrQa1raZhbHW42qdceo9pmYWZ3BPFH3yAttzzHSGfDwJnKLvFvpjjq5uNq87BG34zyLxErFbUuMTo9OzaGzvDzHlycgxRQ7o5CK/ZygTHpNHze4SIoUoq9Mz5O06jhyOkIms56zuzssvRfKgaZNhU5rnNcavVr0YEA3msRDQ2EnCqT4728hhKlOcHt7EvL7xh1TBonwsvWLwg7MlQbBqFpTuWxQZOnI8XyaNVs6q3NOkSdLL9pCKYDZtQf+QWOwk074R7FpguS01MobTuryv9UXDUaZfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFKepE1yKUOKvbeElfXhnXFBdRK/fyvKjMuSE8ZLEEg=;
 b=otqoT5bfG6BcQ5Kx8JXb7V+kR1S1VyFhWOXCTKGqDsr/Ful4CIho0b8ILwdSwbCDDGLo89JFAomY4d3TOqGcGAE6oq4IMchVxe1Uq7lzgfPp2Ngdbw18Ds1Gi9OEAC4zR+NUeuoGefFTvgDneJpO1xaJ7RBrZzQMv44jwDYOJ44=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB6423.namprd10.prod.outlook.com (2603:10b6:a03:44d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 06:04:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 06:04:47 +0000
Message-ID: <98828510-8eab-4a82-872c-6643bef06da3@oracle.com>
Date: Fri, 7 Jun 2024 07:04:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/21] fs: xfs: align args->minlen for forced
 allocation alignment
From: John Garry <john.g.garry@oracle.com>
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        Dave Chinner <dchinner@redhat.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-8-john.g.garry@oracle.com>
 <c9ac2f74-73f9-4eb5-819e-98a34dfb6b23@oracle.com>
 <ZmF3h2ObrJ5hNADp@dread.disaster.area>
 <bcc35a78-9446-48e4-b1ce-0f11972bd19d@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <bcc35a78-9446-48e4-b1ce-0f11972bd19d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0299.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 839d032c-44d0-4670-14db-08dc86b7bc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NmJiMWpuMExDMVdPbFVsZlU5SWQ1ZzBEMXRFc2tQYTJrOUtHVXhPcll3YjFa?=
 =?utf-8?B?dTZYYzAxQyt6RzZDUmlrOUxydWV3VUVjMURWQytubGdoNjFQNTlQcHEzRlZN?=
 =?utf-8?B?RVRqY2RtcVdzOS9KVEgvanVwTEN0OWhpTWcveXpzSERmSVN0eVVscytVOXlx?=
 =?utf-8?B?OGo2M0EvUmF5eUROOW4rT2VVYlBsNTMvZjR4Zm9STmNvcno1UTN4QVJVamxp?=
 =?utf-8?B?Ym9pNFRSV0xpVkxQbFBFNUUyR09tL2xOMWlwZEhYbkJob3JQdUNvdDl3QTZQ?=
 =?utf-8?B?WUxTWTVZTElHeFBYeUJSVjd4RmR2QitWNDhLYUMzVm5zaUNSWk5pUGdyTmdF?=
 =?utf-8?B?UHIwUkhWWTNUTnhDZ1R3Z2hrMkVrdWNFZUhtbkM4NlJKSUV5VUJPcGVuK0lu?=
 =?utf-8?B?cDFVVEZkRXIyeXBQdCtNWnJsRmdKOHlkeFFWWXE2MlBCYXdiQWtNcmN0c2F5?=
 =?utf-8?B?MXBkUzZqeC9URCtRUXBYQVhWLzRHVmFybUdQa1FWWlFLMmRYeW43Mi91Tkpx?=
 =?utf-8?B?MGVkM1JIc0p4TjRBT0R1SmxFeVZDemN3VUlxTGhnTFg0T2VaZ0ZWTVowdHJE?=
 =?utf-8?B?aW9yWHBwdExrek1lR0xmOEdRUHMzTWJtcjA5dk1IcGZ1OWlUQXcxRHBVODVL?=
 =?utf-8?B?WFl5VlpidkpybkJNQXJreDMvVjRHOFJjWm9MaDlxV0dtaU1LWGhoTHJMbFlL?=
 =?utf-8?B?Wk84WFNYNkFWcC9ZSFlOOWtHU0NvbE0yaGZMbWtMNmZZQnFOT3N3bkJ1ZGU1?=
 =?utf-8?B?S0Y3NzdRSDQyOFczaE52U3N6cWszS0FYZ0ZpN1BwdGJXMzAvVmw2MGtPaFVQ?=
 =?utf-8?B?RXNmV3cwVldwdTYxQzVoVU9GUURzR25PQVV1Rlc4MWx3dnBBZWFQblpZK3Vx?=
 =?utf-8?B?bEhSREwrRTRGU0xSMEJkRW91MzJwYzcxbG9xblg0ZjJJelFnc0paenIwSXRp?=
 =?utf-8?B?OGxFbzZ2bzNyT2d5RGNsa1JGdDdWTndQVUdkQTBWdVJHNmh0cktQQUxCYVZy?=
 =?utf-8?B?OFM2ajROQ3kyV1JJQm1BaDk1ZElOdjRpZytVWUtGK2pTSnNOaVZYYmd3ZkhR?=
 =?utf-8?B?UDdSRVh0Qi82NGdDZXVwT3EyVDFZWXRMTXZPMHNHcVIzNFZxb0JtbTJpTHJU?=
 =?utf-8?B?S09JMlRvcDF5YlVsSEV2MittOXYwL0VxUUJGZ1FiVy8vUDRPOUZ3ZVdCdmRx?=
 =?utf-8?B?T0NGNUkzbmhDRmdpa2RmY1lCeGMrM0lBZm84MFlxK1Y0MnNwNzI2WmNENlh3?=
 =?utf-8?B?NCtpdDFSZ3AvMFNjbnBrUkVUWDVzNW90MnJURUhOOVBDalBXUFNSdHJHajhB?=
 =?utf-8?B?d3JuR0VONXFLRGMyUWRyYS9SSWlzNHRWRGR1aWlyVHFXS1R2K0NlWGY4SCs1?=
 =?utf-8?B?TGRqQUZpT2JGTjJZd1RHN1ZhKzdHNnY1RHRHVjlDQk94QTdHZXgzQmFya0Nz?=
 =?utf-8?B?YTFpV1JQYTF2SFdaM2JQQ0NkUGQvQ2lEUEFFOWpqSWU3SzZHV010WVRTeWNT?=
 =?utf-8?B?aXlUNWY5ODhKbjNYTGVUOXNFcGhGQTFyV3d5eURxcUlyY3BLc2tGS2N0L0p5?=
 =?utf-8?B?cVlZQ3N2bmpTRSs4ZXFWcVNLc1dabDl6aEJyNXlCZXR5aVFUR285TnMzaVIw?=
 =?utf-8?B?OHdGQ1ZQaFRxV2RRNmV0bjRuazZFbWYvOFVqOXc0UVhabUhsQ2VWSlQ4MWZp?=
 =?utf-8?B?c1I2Nm53T2tXS3FEQWhHSzkzRVhuQlp2K0RXUXB0cVEzRzYvVzFiQUlOV1hZ?=
 =?utf-8?Q?6+KL5vQAZVYEn+pYX3ANu/DcUKB0ee/cU5brEBF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzRVZGNacW5vN1ZSd25YRy9lZWNPNGErK3pnR3gwbDRtUjNtNjVEQXl3SEVP?=
 =?utf-8?B?ZGtLdjlQRU1FSEpzaThEcFRzTFdCcElBUDEvZ1ZCNmxHdG1NVjJjcDdGaWFS?=
 =?utf-8?B?TUNxd1VKYkd1a01pMmEvUDhuaWdiQ2ZlY1pHd1JYcVA0dzNHQVNmZzNNVkRh?=
 =?utf-8?B?R0NhNWdSMFpFVmlBMS9PNk9oV0h2WmJ4VDNPNzRIY2VLbHNST1NhdnpTYmJN?=
 =?utf-8?B?amwvYUIyV3lMK1ZmcUFPMVFGNE1lYzBuRlJwRFlKY0Z3Vm83ZTN6cW14NjZu?=
 =?utf-8?B?Ty8xYUFRUEpDbTE5ME8wd2R5YnJvWUdQenZyeTBVUXRKemxIbUo1eGZGdjRV?=
 =?utf-8?B?TEF4RFQxYUZndjRHTllMS0l4R3gyeVY0NDVqSU83REFLYmoxQ2VhbnFqY0k2?=
 =?utf-8?B?ekhKd2w3QlhVT0ppTTV0b3hoUTA3WW9sb1lLS2NDZ3duYkpNSFRxQ0phb0Rr?=
 =?utf-8?B?bmhBU3FmL3ZWUXlPNDB2TDQyL1hUQmdwYmpSS3BEdncyb280WWhoQndONmZv?=
 =?utf-8?B?Y2ZsbTRhQmxmSjl2Ty8vMnBGbitTUVRWRTdOclJhR08rUCtwSVJTVFhjeXVn?=
 =?utf-8?B?akx4ckQ5MlpsaVJSQWZES291S0JORy8xQklVd0JLTXV0d1hyZS9UUnFxKy8v?=
 =?utf-8?B?ZHBvYzlqQVhjY3plWnVmWTNXeGxMYUM3bVhqUkFLTGFLZ1NqUlBEM280ends?=
 =?utf-8?B?VGhWYXpYOVhqVkNxRFZoOVQ1UmtXTEhoUXZnNEhiNWlQQmpUdFZZYjl5UkZu?=
 =?utf-8?B?M2JFZUVySm5Cb0diWWdaV3ZoV0VnaXhibVMwUUFtUVVROGRNNVd0b2ZjR2JE?=
 =?utf-8?B?MlpZS21CelJ2eUNXTEFORS9zRGJjVUx3cm40bWRueUUxNVVocjlPcE9JUTgv?=
 =?utf-8?B?bFFKT0FucHA5aW5idTc1SkhVTzE0R0xnbDY3N05kbUd0cXoxNFdRUzM5ZFBZ?=
 =?utf-8?B?N1BKSnZnMklpYldSZXdnNkpJcXVMeGRXeU8xWHhKLzNpQzNPY1dEdmh5U1ky?=
 =?utf-8?B?YytzcjdldFhSK1hSdUN5V1dTUnN5WmZXQ3V0QkJjNk11MjV2Ui9DT3FqMFBn?=
 =?utf-8?B?TGZwdXR4M3dRdmpMMkVFdmFmMkt1dmZlZmxaQ2NPVy9seE1ra0RWc29FK0ZO?=
 =?utf-8?B?azlxT1FKU0pFcVhNS0lUbmdjR1F2ZjJMYk10Y1VZRjB0UVdUNDBXZy9DbFU4?=
 =?utf-8?B?VkFhY2hTM3JwdmRrNzNhK3hFd2JVc09ZTU9wVVFUWlB6aTBsOG5EVEQrWkg5?=
 =?utf-8?B?bTBnemV5NTRNUXNiUmhvNzZNRDBsWEZMSFg2dkFzbHpwa3lRU0xtdTFONEY0?=
 =?utf-8?B?bE1LZnZaY3NydUhFMzEwUWx1aENCQ3U2b0Uvd3dPMnhKdVVHMTdrVHNhMkxq?=
 =?utf-8?B?b3RMcGs0Z0dOMmd0cExHVzJ3UU5KSU5vWEV6V2xBWHgrWFJJUk1VeEw0T1ZY?=
 =?utf-8?B?OFdvYkRWR3k4NUdOaDZxUnFkWm9tYXRpSm5YRnlHVU9NMUVOWXVhSXAzb3J2?=
 =?utf-8?B?dUFvUXVmdUhGaXhOQmozNWNyY3hwdlplelVOWllveldHQ21yZXZOQzNOUFQ5?=
 =?utf-8?B?VVBzMkxZQzBwYS9SOEFqQ0Y0TitQbGF4SSttMWdyamVTMWNiL1BXT2lmOGxW?=
 =?utf-8?B?ejF3RWlwOGRzbG82THZwUlRZZEVZbUNUVEF1SE5XdjVObHVZa01iZVYxbm5V?=
 =?utf-8?B?YUNsSXFUb09rYytZQUZVZHlsSW9qRVlLTG1OazNNbmRQcXY0TFdYdHU3YU1P?=
 =?utf-8?B?L0RFRHlKM3VRc1NkUVV1RllYQXJ0S3dMNlNTdUNIWFN4aVdYRDVVV1VWTSs0?=
 =?utf-8?B?Y1VBR2UvL0h3ci9ZWUVNaFUxNGlWd3dsMFUxMlpVeUhjcnE5QjVOUWc3cUdi?=
 =?utf-8?B?WHNuM0xuZmlkMXMyQzgzeEljdVhCa2RJcHJIRmw1NlhsalpGaCtjaVQvK2Zq?=
 =?utf-8?B?Q3cvc2QraEdmTnhzbjNFckh1Y2REWTI0eXFHcFJMWWpwUVA5K0l0dmt3RUVJ?=
 =?utf-8?B?YXZBdmVhamxNN3VjVExsaThaYjNyZSs1N0grWjNTaDcrem1ROGp1WlNaa1I5?=
 =?utf-8?B?QmxhT0ZSb0lNY1hQcWtPNkl2QzdZMnBGRTF5MnY0UmtIdUpqb2FRZllpNmNG?=
 =?utf-8?Q?XXTG+kbh1GEaL8fgnui5wYRbS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F1SXnLxJqZUcGtHAshyIzCmwsrmXyHOOFzkrSZdzi5NS+skU7f7ruQNV6OMlVoZgCYn2fsAa5fKTZs9S05q8W4FjZlw4mWDgJ2a5AyS5RSaL78o/JsunRSOU+r9k5vsePfrBOY9XOVUCCyyPnFgyuiqsQKt2gk8cLOfLRwM5se03s//gMANPSTRghGaTN4ZBWsrL1Mk0GGCXZc1JnOBSBAEZVPwRRjRD7jY6M5h2MtYRFGda9E2qtIzc26cWLcKdXz2gor0ICU9yT8xP5KD5ePBUyJdIQ97oX0L4+TC64zQWZb0lsd29aGhq+TYBI1PN4ZO/Pa8UuIskIXEnEE0YMjjM9J1Yl1yILy4OlkYAKvlvwCKpXGpjYBTwLbSAHzKZH+yevlNchw1klgeIvKUYpYuTO+ZX5DgjC/hyu/eqn01sSKlPsHgfnhQsrP+ktIQ4XkCPdjZvc0FtvCqpeiHcju2pIoMtI4NJBtl3MfZ7Nfnr6nWLptVfSgvd8KwPgcnDtC3DsB0Qc23fVzHVls8yzOnxL5n5V/3IgRMxa1/l7R7Jjf4n8L/3pE+/9FtPh3liq3AdaL6TiuP1MJcPAkBp7PaPh/SL4+5MpsYYl1DGM5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839d032c-44d0-4670-14db-08dc86b7bc23
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 06:04:47.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyP0l53iccTCigll6ma8P2FE4IaBDTH09xgYoGV/z+Sn2BRRXLXTMsFafcbSSmHii/LBj9Qy8wOvC8zEEG9WMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070041
X-Proofpoint-GUID: 9gER1G0bbJLBtEX6W96Y5BKguC6oupY9
X-Proofpoint-ORIG-GUID: 9gER1G0bbJLBtEX6W96Y5BKguC6oupY9

On 06/06/2024 17:22, John Garry wrote:
> 
>> i.e. why didn't it round the start offset down to 48?
>> Answering that question will tell you where the bug is.
> 
> After xfs_bmap_compute_alignments() -> xfs_bmap_extsize_align(), 
> ap->offset=48 - that seems ok.
> 
> Maybe the problem is in xfs_bmap_process_allocated_extent(). For the 
> problematic case when calling that function:
> 
> args->fsbno=7840 args->len=16 ap->offset=48 orig_offset=56 orig_length=24
> 
> So, as the comment reads there, we could not satisfy the original length 
> request, so we move up the position of the extent.
> 
> I assume that we just don't want to do that for forcealign, correct?
> 

JFYI, after making this following change, my stress test ran overnight:

@@ -3506,13 +3513,15 @@ xfs_bmap_process_allocated_extent(
          * very fragmented so we're unlikely to be able to satisfy the
          * hints anyway.
          */
+       if (!xfs_inode_has_forcealign(ap->ip)) {
         if (ap->length <= orig_length)
                 ap->offset = orig_offset;
         else if (ap->offset + ap->length < orig_offset + orig_length)
                 ap->offset = orig_offset + orig_length - ap->length;
-
+       }
+


>>
>> Of course, if the allocation start is rounded down to 48, then
>> the length should be rounded up to 32 to cover the entire range we
>> are writing new data to. 


