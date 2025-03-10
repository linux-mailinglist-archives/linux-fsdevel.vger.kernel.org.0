Return-Path: <linux-fsdevel+bounces-43638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22013A599EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AA83A87B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101322D7A6;
	Mon, 10 Mar 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="izeXKr08";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mU0Vbig3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DC1B3927;
	Mon, 10 Mar 2025 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620282; cv=fail; b=P950PAXPbb/f+6ed7jD0/wjPcECk4MI11alqP+LivZrevIHC6jKfKWvGvECOxcqFGj1uNP52uVfyVtCFgUQjHrOE6aeGczE9DK8DwNOyxvu5DQmP2fCpH6gFhJKuI/AMZSeI2ZRxHJuJP4vu6UwqBgkTEyiQ9/iAagvxMBGu0cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620282; c=relaxed/simple;
	bh=9SsO+3J7Boo1S0h4uG3EjtDKkv0ufZXcXVFqoEddQhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j3heteIhAH/dG6qjqwLSCYwHnEubXkRZlbeJw/TllZ6jUWmaFQik0JYF1fY4RPXFb0TRyJrcPyYpk3RF/4nQ5NrYltjQTvTD4kUuC81xdaOXQafqchUnfcP+FsWnoVor+PXCo7hNf6jCkAszcDPGK8YcdgsIgVnzkgqgKuficnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=izeXKr08; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mU0Vbig3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AEtg7e031300;
	Mon, 10 Mar 2025 15:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CW8iETKiUEDltei7EsJrf4m62+dxo7scP6mqSrVoH6w=; b=
	izeXKr08KIB8eDuzndamg57n9lFukofnbbJrfq8s1X195z6p/yP8rGX64saC814W
	3mnMchXGcWGDs/iOWB94xE5sKHgFOp7ScTGCeBo0mfMnflTIsDaE1g6aRViXb38T
	yzktj2o9qR1jmkZFjhhGKj7X/s+HNTc3VPECflNi7XCycO81PAqKRktXK/89wNCk
	T1zKjqGuWR1wLGt3ML3eK7sc0ZBKnPjVREpwoBj2uIpt80Rdv6JxzwE+H/DWha8L
	8XaEc06euZ4WYmp/tEqqQH+VmlD/Q/po9/KRmE0QY1Xu0nKTqdPPNRL+jB1gCd8m
	uW7I6Mm1wvRoITq9/18X+g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cacav2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 15:24:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AF3rHa030546;
	Mon, 10 Mar 2025 15:24:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcm3s6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 15:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4/8iTr/q3o912nrLYaRLb5z0fBCpCb824y+KObw124RKstY9uzXG1t6HJLfc+twGE8c1Frv7h1IU0pWLdlCkkCLxFoJvkDlfKrvcexbC41pH+mlq9JppGkPm7hvEl31P2UYXpkl7oJKyqj1qzTaCG0eidlpc/gVrDRKcGl2SDeH8VSkTG1RG2mUMoX0gmuJugF0z6O7sqaF3yoBMSpVA+Yg99VDaMMq8isPXWG6kWfYp4w9oyBGeeXJdh9BOvttWEH+/hu9W9SgHm27VEykw01LGHvtDwika50eHdCXNRCW7rPuephvfzkSLr3I0lJ5lgYK29Pya+2nkAYBouaEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW8iETKiUEDltei7EsJrf4m62+dxo7scP6mqSrVoH6w=;
 b=xkzZ7LoCM9UppmNmg6Lp2bCCOSf6uHhKA/VeVpFOHMeDFAE5PIvB7/u8eHTftiVgRnYB4DEBP+1mGz+4+Wx/ELrE5Hj1D3fdCfxTBBcZ+LAsd4GlsuiqIOUj92UvYeNIoZzoEqU6B2Pdw6ArvWpgPdZPCKm5WZEMq5mj8lowj1xARYsyym2gn2foI1J7Q7ob/aUDZmzJDbaacwzyfHS+IsAnF+4dKns4T6n9YXjhfguZXsu4Qlx9qz17AJdsReIyIGg1wd8FL2xM9beKIHRSLFoQvN/2z9/8rStngpwbfcwV6TUsyOn+HE3M1snGqjgtEg6uhhRBZaMiCvn+PwkixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW8iETKiUEDltei7EsJrf4m62+dxo7scP6mqSrVoH6w=;
 b=mU0Vbig35TSSJuzdTYqthbQy4J0pee/x+sGMxqF9PDVr01JYijH2OC76mcr6Vo0mf93ePe2Ejbvo6BSXkAPFIWcZnKhAmsCImnLWHxSymjJBMm4Eqvjk9Wka7bNnpDsb+twE21ugGHfWOMXygAoh/TzDKPZtJ2zChvdC0M+jbxc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7094.namprd10.prod.outlook.com (2603:10b6:806:31b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 15:24:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:24:26 +0000
Message-ID: <5e6795b1-305c-40a0-84d0-43dfb4ee6cd7@oracle.com>
Date: Mon, 10 Mar 2025 15:24:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] xfs: Add xfs_file_dio_write_atomic()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, brauner@kernel.org,
        djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-10-john.g.garry@oracle.com>
 <877c4x57j8.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <877c4x57j8.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 559ff7b0-7d88-4c0e-0317-08dd5fe7a4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGdBekFkWnlyajhWL3hHTmhLVE4rRkpkaUJHRHFFOExma2hGb0RBOWlOOVd1?=
 =?utf-8?B?ZWEvemY5U2IrSklDZ3hDdlByNzBMQ05LclQ5OHJTeThxaGRkMlF2NllUQkdP?=
 =?utf-8?B?N2xBM284ZEhrRnhJYU0xQm9ETVRlSHNpR3ptM212ZWpCZFUrOUZFaXRicUh0?=
 =?utf-8?B?YXFLYnk0V250NVVXOFR6dVBJbng3OFNYUDBtWURqQS9WeXFKQWg0K1B3UGlM?=
 =?utf-8?B?K3o0a0tNYWwycGZnQ0ErQVlUWnNSVjh5Y3J5OFVpYlBTamVxNDlXUVk0TE5X?=
 =?utf-8?B?czhGOWZwUFo3K1BtZGF5S29EWGx6aFptVkZRa3ZtL0RrT0VPQzhJcTR5bXgx?=
 =?utf-8?B?T3NiZ09tNlJ0OEx3L0xRUWd4dGdBcmszQnI0N1hXdjdFYndWcXJJTk1uQlN3?=
 =?utf-8?B?SmRkWnNTRDZydk9QT0tuVzI1eEpFTzJFMk9XZWUzNkdLVG9KRGdnejlRQWsv?=
 =?utf-8?B?SjRXVjc3ek5EakwrS2QzL1VzL2M3T25yQW1wbTQxZmZ4RFpmTGFJeFBNNytk?=
 =?utf-8?B?ZUhybnpqOE1wSzRvVUtNdWU2M0MwVmZaeEVuZnNHeWxnK0NhMVJxV3B2S3N3?=
 =?utf-8?B?RVk5TTAxakw4SER5emZUOEVWNW1CeXNRNUxGc0pydjdaWDloSXlXNFdNRkVN?=
 =?utf-8?B?VWtGMVdqeWk0NklZVGVnWURUeTFKdXc3Umt2WHltSWNINm5kNm5jZnRBWUFN?=
 =?utf-8?B?dUFNS1JjeENwdFI0TGtaODFXUVBSVDB2eHdaWk15YzNZdjdpQXlRajdqcWgw?=
 =?utf-8?B?eS94L3MyNmxEWnlxVjFqb0Z0MlcyMjBKTm1BSktPNVpsQVZFdmk0Rlk0QnV4?=
 =?utf-8?B?Y1ovR2VxaWxVY1NXblk0cCtiL0g0bGhjUXk2WmVxcnZPempDVmZacFN2T05D?=
 =?utf-8?B?Y0xiOWdBdXd5Z1RldVU3Y1F1bC9TUVZFRVlqTElGRWpITHMzbXcyKzhaUkd4?=
 =?utf-8?B?Z0hLVmNmdk5QM3dpWS9hZ0JnSXdDZnkvdnRrTjRDV3NrcloyRnBkMytxSmo5?=
 =?utf-8?B?UFhDTTU5emFBR0JYSFhobDZtQ1pUK2dpZUsxWUdJN3lKZGFxSyttcThiTWY1?=
 =?utf-8?B?dXd4M0tBT1FmYXBCaHhJbFZ4OTgxOE1KYXVmYm5qQXZyUlV5Z2JYUEpOTk1i?=
 =?utf-8?B?RkxucjBjNTMvK3FSeS9rTTN0RmNiMVQzWHh5Q0FOK0VOV3dYRWVYQjdCRkJt?=
 =?utf-8?B?WEpuM2xMNmZGQmVxZmt2ZFpLT1BlU3dtM3dXbHY2SDNPKzFOYVJlUXZVS2g1?=
 =?utf-8?B?WXFpb0pRNG1DVG91NkdwNWxkUkxUemcydlhwZXMvakFjWElwVnBTaU41blhK?=
 =?utf-8?B?ZTUrTkFTUkZGRDNlZVZZVVdYVG9Ud1liTW83MWtNK0hEeDBBVm9lelBoeVJQ?=
 =?utf-8?B?eW93SDZGMkNmK0l6ZjBjRXJaY1E3QUJVSXllSFluT1BqOW9tS2RrMG1jY0VT?=
 =?utf-8?B?YWlseC9obWRxRnl2emtXTFR4djIwbTVoY210Y1I1a3BqeVR6aFJ6ME12QWJN?=
 =?utf-8?B?Z2t5ZENSUEZUd1hzL0Y5UkZYMGh2SUJXN2xRVm9zN1JiNVlaOW1LYjlkVzd3?=
 =?utf-8?B?enArVXYyTm5WZG00bnA4Qk0zSDdIaDd6NGJNRGdUbFR3bmFIVDN6WHpBZUFB?=
 =?utf-8?B?ZXVsSjI2RnIwSHhtOFRkWVBUQkhScndsQjBKbzZqdVJCQmM5QWk2bTc4NEhu?=
 =?utf-8?B?eUQ0UjBCTEpvSWZwWjNtZW8yNE45Z3NsZDBCcUJ6b1lBd1Zvb0xWMmdWQ2Ey?=
 =?utf-8?B?QVE3VmthMWFaR1BFN0wyNURqVmdrd0ZjV3JQZHJucFYzS3N0MUYxckxwZ0VT?=
 =?utf-8?B?NGZTZ0hGeEVkMHQvOGhoa2RoMXVDZGFDbk5HOXRPcG8vNUVwc1J3eHRHRmFo?=
 =?utf-8?Q?uFRAReO7XNkCx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NitpSktMRmE0WU1VZ2NHNUNhOGZ3Y1VTWkxDRHRPYkFRYXMwWXV0TDhtTE5k?=
 =?utf-8?B?Ymt2N0U2ck9ISk8zRWd2aHY2K3ZPQnV2USs3N0xKazJ5enJobGpNZ2VDWnNk?=
 =?utf-8?B?MFVTMXB5bnUvYVpEeGVYQlJxYlZxeG9HTGQ3ZkwzY0hlYjIydmZUajVFYWls?=
 =?utf-8?B?R2ViYUJSQWZwRWxOSDdBd0JLTmp0bDE1M0ZQR0hKNk1ieEc4cURVdE5pWXox?=
 =?utf-8?B?UzRueFozUnVRQmpldGhKdFBUZHg3cmg4LzRvQWMvNGhFcmpROEJhQlZUMm9y?=
 =?utf-8?B?OFlzeWgyL01xREpZdTNkN0NtU1EvZURWaTRhc3NDQ0lwWDBaclA3N2Y2RG5p?=
 =?utf-8?B?RTQrYWRCYzQzeURTb29Xcll6d0tqT0JoV0pueUJNQjZSL0xCbDNxc2MzcGlm?=
 =?utf-8?B?QUF3MjFyMlRGcnkyNTUrZWMzWUQxRnJ4Q3VrcDBTbXkyYXdqTUduUXFUTml1?=
 =?utf-8?B?YjBveGl4UE5HVnBISG41cjh3K05LbzBRSWszWk45aldmOTZObWd4N1F3eGlt?=
 =?utf-8?B?K29SNHZDMkp6aWtVT0JRTXZ6amVPY2VvSnRvUC85VzA2UVVyOTlSZ3VhTTFZ?=
 =?utf-8?B?Yk9iVWN1RlBlTFc5c0Q2S1VvVUg1TGdjdW9naWZoTDFtUzl3MXRpaDVVeVBk?=
 =?utf-8?B?Wld3T25JdFVqMFFRMW4wUEVRL0hXbFdkRHhobVNqQWtZdkpzcjVjR3JVR1dG?=
 =?utf-8?B?VG9UdFR5a3EraW9URUhkVjNKeWhUZW8rc2lyRW0zMmNSeUZVYUtoRmsvakxi?=
 =?utf-8?B?cHdYaFhoM3NERkU0bHl6OGkxTTVYbE5EeUZJK0h4MHBZUWtZamtGWk9qbjJP?=
 =?utf-8?B?WlY2eHlFcGlCbjk3L3E0KzlGZUE3UVdaNGhQYUhwVGJJR0NYYkMzd0lpVkdU?=
 =?utf-8?B?ellQS28wejk4V2ludDR0bktPeUU3cUxsT1ZqbG1vMHkxK2tuL0JseUhaeEhG?=
 =?utf-8?B?ZHl0dmJ4S0lKVGdFR3h0dUVJT3FsQVlBMVZzV25jbXZPQy9ZL1cxSjgvYnZW?=
 =?utf-8?B?dVRWNE93akptaE9vNWs0Z09PQ0h3WjZMWmJSSGt5T3pGdlFDNGNhYW4zMjNI?=
 =?utf-8?B?bEloNFYraWpvaWZlNnV0OVYzR1poVnFremxERFpTWlo5NW1NU3h6cTByVnFS?=
 =?utf-8?B?ZmQvdWJkajJhbDFJUTFLbktENDVBOHZVNWVqS2hCcVcvYUJkelpEN2Y0aklR?=
 =?utf-8?B?cU9zVWJ4RXpuMjZWZ2cvWHh4czVqdkZ0c0hUeXUyNklnK2owVnhjVzZ2K1Ju?=
 =?utf-8?B?SHlhSFErNW01NHNuVFozeGZnUlZmdnRvYTZ0ZHlkQmF3TXZIakdVcFg1YVht?=
 =?utf-8?B?ZmszM05Hb3dSNEh2KzFvZUVCN0l3Y2prRC8yRHc0c0J5S1hQWmRJa2ZSWVBt?=
 =?utf-8?B?WmxxRWZWMG5IZjJvZjgvSXNjc0pXQnVOWVRhVk5WcDRkZ2kySnVGNWMxNEtQ?=
 =?utf-8?B?Z3ljdVRiWlQ5LzdKdjVJLzltY015YnBwaXdEbkxMOGFMbCtkR0ErWTNmdHRv?=
 =?utf-8?B?SW1IQ1llYVJ1REVtM2JTbnBucitBTmxrcmpWVlNtOVpsc3dLcTNDLzYwbG0v?=
 =?utf-8?B?Rm9sdFcxb28rS05ZKzV2RkZDSFRvUGlnUlZFclpUVVdhRDdrMkNyVkRBOEpT?=
 =?utf-8?B?UzZYNUhLZmh5c08vZ1hJVmVRQTlvdFdvM2p1SS93ZHZ6QkhJcC9sTjJtUEl1?=
 =?utf-8?B?WDlWTUdFYlRWZEdwOUNraEVFSy9DM3RUVXZqbmZudStWWjlmZUs4aGFYUXlZ?=
 =?utf-8?B?cm9HK1IxZkFjQXhFSkdLeHJ4a1V6U1BMK2tPZHMwVHViaTVJNnp4Y054dGZ2?=
 =?utf-8?B?SzF4OXgweDBMZnFGZXBsTE5JZktKTHNOK3ZyMFMzRXlSSHZ0YkMxcWU5T2Ny?=
 =?utf-8?B?a1dxWkRrNG1RM2cvMExxMGxIcDZwUXpwMWpFUHVnUnFHbWY0OWdySEtCbDg3?=
 =?utf-8?B?N0JUaEd2c0prTzdua0hNdFRvTDRlclphQjlyeFkrWUIwSWRHdUMxT1FKb0lF?=
 =?utf-8?B?My9RdG12dUVma1JjdkpqcEFlVTYyd3VRRXZJT2s4a1NRKzJOTHA3bjc4d0tu?=
 =?utf-8?B?RGFHWnEvbHBtTVY0dExDdzc4cTREb2JNQnRpYWFLWU9ZZE5UeFhqWTFmcjd5?=
 =?utf-8?B?dG5RM0ZuclZlSERHcFN4QUhBSWJRa3oyWjRaWUxReEo2cHNCUTd3eWJVc1dB?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	miSWcGlE+JbgD33jFvLfdqOl2PwGJACQ42sNu8+YW03rdYqnXtGvMlfoRd1RV/q7r8u2db4sEwfmF4exnj+52CRkA3olvUp40q1LLUEujzNHHd+m5MjH5Grct5rfDQP3H2PDmvHUOk4fcPvC66k91cIPK05rFRsSSRKAwqnNdVGGRZEUNLGuS8uoGWkY6BcaLbIbeZjTc7NpCqF5IGEbk/uXHcjxlYRATH2iZGhqFJcIxMfuqKgmGniCCcEn2vuf2bzncn6ZNp494bmdbeVuH+5v2Sx3lIA5uTXwrgZCDM4+RSqbnfy6VDnINnSku6NBFzCPHGPeA5oP3sUptNX9YsDRSG96cJLtmkfarHfoxiVzRBM7RJCHFUbCNuYBr/cM09Fw4cZkITKOaduss1iILI0+W83xEy9RDbE3NgwjajdE5poZ3w1tt1TY26n+pdeGDUO9sENlGw4TFet4e4azQd5V15SpGuUcOY/46F3zdnIlhOiifUGPGirPgOJcBv+7f3k6RNQ5mpn6f5irGgjh/AmFmBa7wRnEvOVi0KsS3/Uaw6P7d5NHmesOkMOzcMEiuhFJhk8yI2yruOLUR5pbbP4AH8xljn4MQFhR+5v0wOE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559ff7b0-7d88-4c0e-0317-08dd5fe7a4ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:24:26.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cx+StkcvJqbK9l6K4wNtDmzx2uLt36ekGQeInm1ADmLRRfAIAtd/H4sihuxBCb5eQjEuGvzU/eW+b737n83MUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100121
X-Proofpoint-ORIG-GUID: jngG5AAYFCHOG3M-MzxvvO0-nhDf-Omi
X-Proofpoint-GUID: jngG5AAYFCHOG3M-MzxvvO0-nhDf-Omi

On 10/03/2025 13:39, Ritesh Harjani (IBM) wrote:
> John Garry <john.g.garry@oracle.com> writes:
> 
>> Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.
>>
>> In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
>> in CoW-based atomic write mode.
>>
>> For CoW-based mode, ensure that we have no outstanding IOs which we
>> may trample on.
>>
>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index 51b4a43d15f3..70eb6928cf63 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -619,6 +619,46 @@ xfs_file_dio_write_aligned(
>>   	return ret;
>>   }
>>   
>> +static noinline ssize_t
>> +xfs_file_dio_write_atomic(
>> +	struct xfs_inode	*ip,
>> +	struct kiocb		*iocb,
>> +	struct iov_iter		*from)
>> +{
>> +	unsigned int		iolock = XFS_IOLOCK_SHARED;
>> +	unsigned int		dio_flags = 0;
>> +	ssize_t			ret;
>> +
>> +retry:
>> +	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = xfs_file_write_checks(iocb, from, &iolock);
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
>> +		inode_dio_wait(VFS_I(ip));
>> +
>> +	trace_xfs_file_direct_write(iocb, from);
>> +	ret = iomap_dio_rw(iocb, from, &xfs_atomic_write_iomap_ops,
>> +			&xfs_dio_write_ops, dio_flags, NULL, 0);
>> +
>> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
>> +	    !(dio_flags & IOMAP_DIO_ATOMIC_SW)) {
>> +		xfs_iunlock(ip, iolock);
>> +		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
>> +		iolock = XFS_IOLOCK_EXCL;
>> +		goto retry;
>> +	}
> 
> IIUC typically filesystems can now implement support for IOMAP_ATOMIC_SW
> as a fallback mechanism, by returning -EAGAIN error during
> IOMAP_ATOMIC_HW handling from their ->iomap_begin() routine.  They can
> then retry the entire DIO operation of iomap_dio_rw() by passing
> IOMAP_DIO_ATOMIC_SW flag in their dio_flags argument and handle
> IOMAP_ATOMIC_SW fallback differently in their ->iomap_begin() routine.
> 
> However, -EAGAIN can also be returned when there is a race with mmap
> writes for the same range. We return the same -EAGAIN error during page
> cache invalidation failure for IOCB_ATOMIC writes too.  However, current
> code does not differentiate between these two types of failures. Therefore,
> we always retry by falling back to SW CoW based atomic write even for
> page cache invalidation failures.
> 
> __iomap_dio_rw()
> {
> <...>
> 		/*
> 		 * Try to invalidate cache pages for the range we are writing.
> 		 * If this invalidation fails, let the caller fall back to
> 		 * buffered I/O.
> 		 */
> 		ret = kiocb_invalidate_pages(iocb, iomi.len);
> 		if (ret) {
> 			if (ret != -EAGAIN) {
> 				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
> 								iomi.len);
> 				if (iocb->ki_flags & IOCB_ATOMIC) {
> 					/*
> 					 * folio invalidation failed, maybe
> 					 * this is transient, unlock and see if
> 					 * the caller tries again.
> 					 */
> 					ret = -EAGAIN;
> 				} else {
> 					/* fall back to buffered write */
> 					ret = -ENOTBLK;
> 				}
> 			}
> 			goto out_free_dio;
> 		}
> <...>
> }
> 
> It's easy to miss such error handling conditions. If this is something
> which was already discussed earlier, then perhaps it is better if
> document this.  BTW - Is this something that we already know of and has
> been kept as such intentionally?
> 

On mainline, for kiocb_invalidate_pages() error for IOCB_ATOMIC, we 
always return -EAGAIN to userspace.

Now if we have any kiocb_invalidate_pages() error for IOCB_ATOMIC, we 
retry with SW CoW mode - and if it fails again, we return -EAGAIN to 
userspace.

If we choose some other error code to trigger the SW-based COW retry (so 
that we don't always retry for kiocb_invalidate_pages() error when 
!IOMAP_DIO_ATOMIC_HW), then kiocb_invalidate_pages() could still return 
that same error code and we still retry in SW-based COW mode - is that 
better? Or do we need to choose some error code which 
kiocb_invalidate_pages() would never return?

Note that -EAGAIN is used by xfs_file_dio_unwrite_unaligned(), so would 
be nice to use the same error code.

Thanks,
John

