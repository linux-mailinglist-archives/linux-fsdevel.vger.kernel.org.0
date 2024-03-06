Return-Path: <linux-fsdevel+bounces-13741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C823873570
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464B11F24FD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE5A77656;
	Wed,  6 Mar 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c7qmCkEJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oxsZnHPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9BA605CF;
	Wed,  6 Mar 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723692; cv=fail; b=czCxIPEEjELi7n7tZLLc8XFsdwwx51EjIg03h8mBTkyzBTx8GckHnsZLvY0LCi/MOtbtTZchK96SIWfXt7jP8cXEU6W/Zj1v65I9gbYRCZ62f/k8fCEQw0EKoN6eOL17Ae8A4yfTMrpfEST6XMyYC5kyX1UAVQVGyZmkLNWMJtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723692; c=relaxed/simple;
	bh=kw20SlyZTX6FAfy8+hfu5qBxwI+8hgtDiam3hVrlZ1c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NsRFSM7dg/2Lor62ncPRrCfpK/2/eJT6PxX607EK0qPz3HPmhDVUgulnpgPyoQUciUhN6H6nVB8gPRaUK/TpKmRfx3RVna+QpUJ+dVuo+nsNM4tLYyKfTpM6K02fz/s335haae1Gk0sfNDPOct+78wxrtmTidfv6KQ8hvJbB1JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c7qmCkEJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oxsZnHPX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426AGeXU017859;
	Wed, 6 Mar 2024 11:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pBZkVnU7pmWxk6Yq26usY1ZQWQ9MBHGQpyXojB/zlo4=;
 b=c7qmCkEJOqWOWYT31pmkKSzh4DP47RtwS3mwNZ68SihngousC9v2gBKOUBzuRh1PBOGW
 6zPGviYRRoxD8bFopZByng6W94coEaFufOviRh8Tp+gopYhLS3jd5SWYGLMN6GpVbnCe
 PbrOkoImNX1I6zoKyue3OdjLKusgunXBVzlAwO4KJkQoFodXOkc2MWsJXQTdgVASlyyC
 WoERWkAnrlSKVXqxcZM6ss+OBn54mcI6IKZxDCQ50LUOQl3DsDzISbyC8xWo99EVrg9j
 SvCiWQMqzPc45E6T6cAyvAMu/PshOck5+G9M4VGY7XZ3lb/DQeJNdprTTq7pDieJiOVk 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq28s9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 11:14:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 426AnLHg005273;
	Wed, 6 Mar 2024 11:14:22 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7nrwnfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 11:14:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS/BPuh7w4/t2D54ZlqhMyeohaNFbh0BhuvWLVxYWZTg1EsuMQke3o8+AeZqfYO9+d7+f4Y2SpuAVs0DRbgbW7CtL8LXCgLJheSLjyp1Y/8CKhcCXsJqQEkM6zVc4irAdSysC6DJuJ1SvIa13IW12CySVGaLagDICzXAIKrm71OEwY0R8Lav07/esC1l3+x5t9ks6DZdNp9S20xGzR3I6ALuAUyMX6hGydOUXEfm2t9GEKTXCnPxbkx6P+jMJRRErNNJ7TFEQMOWGo4Oj5kcZvxB34SbQyzzylRF3bfoAW4/+1nCl0n37665CKbdV/w2j5EecAiofYNORWw4I3vkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBZkVnU7pmWxk6Yq26usY1ZQWQ9MBHGQpyXojB/zlo4=;
 b=kLhnn/ImUIwUY1FADxB1LvWfzptwOwNnuDpqxl087iEBHLD2cfN9ws5jgmTUUNWV6KZuoeTmlOiD65CbfIsCd5vhJkMP8z1V5yzuqpo4AFG0y9wTqDtWE+XVQNFPHSwBwt3euMR114Jre30zbBFh3IkCKGvlYH+aJ5Sv8vwEGvWy1NmwwFAX3CQOjMkl8kkmzYNKah/xOgS+MXPhnKY+U35+HyYjrgsEHNLLOJDH1zVGvZc2hPwYLlyecCwppiXxD/fsKv+QmHLc73e0NPa2WJ1/jAR3GqZAwRIxPzTWgZTuJsyLBH6HTX/3FpKkm+Ty6UcXEnaLtUoDx3FmFOsDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBZkVnU7pmWxk6Yq26usY1ZQWQ9MBHGQpyXojB/zlo4=;
 b=oxsZnHPXJpw8GUN3sxI2s1oMLMvE/tfkGgJKP4n2XJVfzwHi7j/nsrUOwrxAWkh7EbIVNWrQTAefrnFfOtl5DHeFM5EVnQKBi9W07jbsqNe/qaEPm1Sk8PZU9Wz07d5l9dhm6f5V0YQ+pRm2bwR9ZdRTBRvoVqKspLbMX4OJTJM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6124.namprd10.prod.outlook.com (2603:10b6:208:3a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 11:14:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 11:14:21 +0000
Message-ID: <e06621b2-8b33-41ec-a049-1befe83cdb5c@oracle.com>
Date: Wed, 6 Mar 2024 11:14:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/8] ext4: Add statx and other atomic write helper routines
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Luis Chamberlain
 <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
 <9def15d6ffb88f7352713c65292513fab532112a.1709361537.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <9def15d6ffb88f7352713c65292513fab532112a.1709361537.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0494.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 745fdfc1-1cf1-4526-ff1b-08dc3dce925f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4dsQyhUW38ivnPKOXA96d6TeTXHF43HY3qHrjDrl2U+pdEQCCRdK1xs6ZTyC1b7XeuMV/bpCHpuMYoOjyTdjTIqWNZGp8x9uwoPfPEKZG9R6jI2bMLTm/tNsGauSbQfxIDqqR7HQchtCE/RRcl81h47zWIEC9HFmQLLAV5cU0WS+o1Nh2qacVAnPCp4IRdXwjwe/6BEXD+sMnCeY+81scHz6D2TDoisaKVibP8cbtf04f1+Wk0M5AZrxq8PF175d/HszC4MoRhV84NeDt8b1Ew8kv//hWuElzzt0MqFK9iSnTFKABH+2VBXfekiT21KnRi4t0+ER/DEbiGnokNGiy3sRhrFeISKWdMYdZouYIOsBVAcxsZCjwMS0W44N/qWSHj/IBTwGPn4Pm7+jrMgG6E0P+nnAkRHiU3Bwj/XoceKh/ZJ6b2fm2YzH0IyPtBfOSMEnccbYx9FhxsJ9GupXoT/LjDPfHwSfQ+jRxFF/QFFt68ERyzGmC2XRSCxP/4scFJLwQfSz7FFU4etUjHmwcQjdE01nbt8VsEkURq67XCLyNz/e4rrtV14vVaM6/v6p9e5DJ1d9ZxoTcR/C3KRgkyGIKzM7SvzF2U+QfmsWgtlwZYbukO4+c50aPs1vN/qgIKkxl4IhJ5VZ0FzbhJfsOXr+w/I+d/1vHRrUdYvMYi0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aytmUVpxbFFlSVJkMXdMVVIwc2JMdHVQYWFySWNUTnQzaFJNRG5aeTJIeGNB?=
 =?utf-8?B?b0ZUYXIvWWRTektKQTRKcXd6a3NPNW5VNU5TS3hyWTliUGdTNUZnaU12aHli?=
 =?utf-8?B?NHE3S3FDdzZYL1A2cTh0c3dtdGI2aElXTDkxNkR3cmhRN29DbjB3aVY0Slpw?=
 =?utf-8?B?dlgxWWRvRUhVMEd5cXJJQnI2R0E4TThQcEpBQ3dBaGZYc0h2b2NvRVd0M2s5?=
 =?utf-8?B?YjI3cWdDUEdXaG1TZE1mSHdHclJnazducHZRQWdJelFlMCthR01pS3FyWjg5?=
 =?utf-8?B?MnVxa3A1NlFmRFk3MDN0Tzh2bG1URXpXN3lxbzZ4UGp6MlVTZ3l5MDZHemVQ?=
 =?utf-8?B?QlNCS25hRzNXOWZMNWVZSTR6alRGOEVrc2VMZUFvcUhXSUFRRXhWRWxGQjV6?=
 =?utf-8?B?V09selg5NHV1c2xxR0NGRlhQWm50bE9GVng0NWJpMHl0dXZQVVlCakpTc011?=
 =?utf-8?B?T2hkOFUrOVZEQUM5Zm02MWFvMFRNU3F6U3dTMkNXRHl1RWZZQm1HUlloMmJY?=
 =?utf-8?B?RWNFY2NhS0s0N21ualVvdFNJS05oeTJjaUNXdUpyd2ZJQ283YmhKQ2xLTHVl?=
 =?utf-8?B?NHZidUt1WUpZV2NsR0p4TVNYWEpSbXNKOVdUSGp2VExBTFA5a1J4Vko1bmlC?=
 =?utf-8?B?alB2dGtyM3ZZUXNkbGhHaEozRllRTkxCSlM2SEFpbDdvSmtTM3k4QkF6NFl5?=
 =?utf-8?B?TTdvVkxJREdvYTcxdC81ay9VaEVPd3MvRC9mZzFrN2xhK2pRN2dIVzRsSzZX?=
 =?utf-8?B?VGo3MjBoQzI1cEg0a3VJeVJjQkh4YVdZSXRHQ2F5bEc1YTd4Y1hmb2Z3Y0hv?=
 =?utf-8?B?bit3NXlBR0FmczlINmdCMk5ZQUNrLzZDUGNTLzdBMFA3Nk0yWXRTZUNsUHJQ?=
 =?utf-8?B?VzNjSkZaa0JQU01ORm10eUhFRUpWMDNWdGlTSG9XUHMxS0dEdGkvcE9aQWRv?=
 =?utf-8?B?L214ZnNWbUkrV0drSFBiUnNjNjZxemVMTzFlQVBicllyczhJY1dhYTJhS3R2?=
 =?utf-8?B?MmtJR1laREpPZGM3UDIwUkFUTXkzcVozL21SbTlhV2ZHL1RTeXB3bmVTUHps?=
 =?utf-8?B?YzM2eTNLaHVndmtXMk93TDFoR2NQb3JGUEJFak5BYnVlb2thOFRldXl5OGNs?=
 =?utf-8?B?cUhYdW1xNDlLekpjUm9Jb29uT2EvVGJ0Y0NKMFJBbmRKMkxicjJoOWhRSitL?=
 =?utf-8?B?Snc0L0JqbVBzNlF1dXdDRkpLekFRa0xHSlp1cTV1K3VWZFo0MzJjZmZyKzRL?=
 =?utf-8?B?UjQ2UXlRNVFNUkVCY1pFd0ZzVXNJQTZqTU1iYVZ2ejlzdis1RVNkT25MNW1k?=
 =?utf-8?B?NDMwdjJicmNxbExuUlZQaHFieHMrdkk5LzFNb1BRRlJpZWY5ckFJSU9lUHlU?=
 =?utf-8?B?bTBBNXA0NnorWDRIdDNkRzk4WXlkcXlTZmFvNGtqRmMvQlpFRDJ0NCtYa0c5?=
 =?utf-8?B?ZkR0U3NkRUE1YnlmVUZQbU1IbW5ZaXZWYTVKSGRaUDNOSldLTTlGK3BZSWdv?=
 =?utf-8?B?RTdDZ3F0dGx2VjFXeEFwVi9wdXRyU2ExS1BubWNjSjJVbjJoMzZBTVMzbWR6?=
 =?utf-8?B?WFpnOUdIZzFUcFFaS3M2SUZkVFh5QThabmtHRUlvNFJuR0F4MExwWHRSazVq?=
 =?utf-8?B?NmVYRGFTdWxrTmxMeVFZNENTUDRHOVNkbWhGUmVkUjJUSkJZNW5tb2JQdE1N?=
 =?utf-8?B?Q2QzVmVPNTNCWmcxMkJOaGtVYk1TNVpobUQyVE5sS0Q2czhsYnhlaXlkUTh4?=
 =?utf-8?B?ckxsQUYzdFVLNURSNG5KWHJaVkJibGR6ZXJreW5WN21idzhoNkYraWlabkFv?=
 =?utf-8?B?eUEvQlZNSUpzUDQ1WDhUeG9BVEZWVFp5U3pqb0NwR2U5ZjRBTWp0dUcvU3V3?=
 =?utf-8?B?Y1lkcW9JNkVueG9OZzhSMmh4M3NTMmdPeFV6dkhIWDEzU3VKa29reFRBL2lY?=
 =?utf-8?B?WkZHRnRZSTkyZWQ4clMzSDEwMmRTa2EvTG1DUjlOUjkxT0ZyU0RsaXBYU0Q0?=
 =?utf-8?B?bVo5dGpMSjdtY3hRSDBleXNtb0src2Z6cXc2N1pBMFVXcmlVeVpOV1JKSVJI?=
 =?utf-8?B?MGtqZWN0OFVSQjAxRmJNVUVpWmQ0YXFJekhGdk5FN0xLZkdjY2RkdWVXckZw?=
 =?utf-8?B?UExCWTY1Z0xQVkp5THVHTmRNRzhld3J2U1RiQzJRaEJnSkNnU3QzUUhYR0R2?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EPLaDIuQ0seLgMx0C9qSts+1yyt28OHd+OLkeAQFhqE18U4bSktlLzhV+TGi/IQ6b/3vI7VqxNBuXbi5Y44MU4pU6MaqEqxFnxP5vy75ixmKEBmoIjJ0L1oaF8crSVwp+Z6ZLgsaRr2w5vx39ymW3eFWOfcmqXT1kc6a8gZ5Jypr5ACo+32s5kFTwyXqx6rFyyPb6B9V4HpQnofwPTx2gJuiFbAYu8ZYa+GVaJ4o0HFNiRzYI7v832uz7L501UgvO8l52zclzt5/a+N+URJUNrfABiueV+fsueJBTCbBX34GkQkJF49PB4+xkiTeRsu9Bgc7VBIqWO97cXoDZfFGpUbARjAur6ES5qU3LkmfkF3WGvjPg64Qvn/1RvyzPO+gNOnsBnXi0883gQ/8h8f1gCQPx6Jdza/biFuokBBPei1ArQOF6cEoufiKQw2+oRJm7PLNg5Br33ak1zs1J1xSa/06ECOcGlAFgH/yLuKpOpCZX/oBRl7yDOoG/435ypsm9NTYSDN1fQU+NZghYbPHNPZertbwuDtniC6xnhsNrnaaj9czgTxbaqvLNXoxqvSenrCt1owNItKSKyncCSf6Uv1iQBYTAzT6MGHR36wgtAc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745fdfc1-1cf1-4526-ff1b-08dc3dce925f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 11:14:21.0647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IFLR9rDlatVfBFVAhcvv4DYHVrZO7114G3dwrWnqKy9tRzSdiXr0tTBxrcfD6QHAeaAaP+DPRyiDNapPral6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060089
X-Proofpoint-GUID: 0uKmRsjGUxYZhDkI966gGHxjNqT9yX4s
X-Proofpoint-ORIG-GUID: 0uKmRsjGUxYZhDkI966gGHxjNqT9yX4s

On 02/03/2024 07:42, Ritesh Harjani (IBM) wrote:
>   	}
>   
> +	if (request_mask & STATX_WRITE_ATOMIC) {
> +		unsigned int fsawu_min = 0, fsawu_max = 0;
> +
> +		/*
> +		 * Get fsawu_[min|max] value which we can advertise to userspace
> +		 * in statx call, if we support atomic writes using
> +		 * EXT4_MF_ATOMIC_WRITE_FSAWU.
> +		 */
> +		if (ext4_can_atomic_write_fsawu(inode->i_sb)) {

To me, it does not make sense to fill this in unless 
EXT4_INODE_ATOMIC_WRITE is also set for the inode.

> +			ext4_atomic_write_fsawu(inode->i_sb, &fsawu_min,
> +						&fsawu_max);
> +		}
> +
> +		generic_fill_statx_atomic_writes(stat, fsawu_min, fsawu_max);
> +	}
> +
>   	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;


