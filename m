Return-Path: <linux-fsdevel+bounces-43899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F6A5F63D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 14:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107FB163A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F288267AED;
	Thu, 13 Mar 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A8nXLouC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="riH8lxxH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79F26773B
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873571; cv=fail; b=MIZVnN8dFj/rjmQJlhZqXgUR1hRKBGX2wJJ7XlzQdTETtV31u7QoFahxYNbyMPrPnJJoNlZi4f8MXCrN9dkLqx+TjPG60/b6IFbXG0lR8xNGIjlk7p6DTPl4dU180XtF5ZxtHXAIumKQeCiDxVp+SBx/cspzmpAhI8R5lDoZj3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873571; c=relaxed/simple;
	bh=aUFbSm96AiIcQbwZ5BsFVAfMK5nTza/e3GwFMbCnjc0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cIdf2pONVJlLYQ3ur8SpWVpgs/Vo+dlUgzZ+jNJ7fXh4/IaCct1RKMDFHViJ11iE6FODyvn88IhgScQeimiCbKVyPPqY2Ha663IPb9Ve6PIJ/2as/vyR5HjZE7UhF2eqglzEL6OO/zO1+V+Z4V8kDZOIyKO+atj20WVNlh9npx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A8nXLouC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=riH8lxxH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D80npr004482;
	Thu, 13 Mar 2025 13:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VlcPXrsG6XuQhF1d81Bvcg5JeedKw5bINvA8r/GHEUg=; b=
	A8nXLouCyuu75aWfW0dZo2A+WFJHuIhmnh8jbANQJmFItVsvr3Smzujd+Uh/cfMz
	xG9ywqZPb2jS2SFIsAtosZdEoyd8uevwKG/SXNYRdg+UV/iJxnHR06gyCcSRuEVQ
	COMXBtYa4wKh+EY+rY5MCAEPLeR4+Vy6u+4rmFjbE4bnb7dCuyzYeJh5xVvPWrvW
	0rFR1e4MCCImjhpjfZ8OlSYhQV4a1Q5qIY9DQnLkMIDoyaJsI/WTjlizwOSqsH0X
	r4rntm0bwV4ITs8cUhgGLCWbt5OFUPEuFMqnIApjUDNN7m8i1E/FDpukz2SXAOot
	sl5Q0aCYBK8OraCOlLjGNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vm8t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 13:45:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DDcRAC002391;
	Thu, 13 Mar 2025 13:45:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn8qjbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 13:45:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nn1BOypFIqgHc4DmeEq/B6i/871fp4ZMPio2ZEmSVp2gtJlqt3iU2H2Go17KEBV3T9WecTRsk0VYXVeDxIz3FTgnKwtBRJOr8w8ZFEgc2ahQSzC4f+odU9ViGHzuEhFi5BhqCeQ6i/QcZj7KlbMuw3H+rr4vv+v8m5EBZ1tKFyHqYJ9TDF9EUQrdFALu2C3DOYrXbMGmidVPs3uBqCjHzMlXCvW0k1ruWo5tgZDWXa/cjw7lubAOoxaC67uB+mGMDIC6lJkqId0jZHyc5AFPQtXY2FP63tJengG9w0sL9n1jgePCE/in91p5KvqSW9symtdMk1k2Afmdyp4j9/JePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlcPXrsG6XuQhF1d81Bvcg5JeedKw5bINvA8r/GHEUg=;
 b=HLe16Wep935+nhFE4US9GEj7gF1Sm2BsLcpDxRMgxblNSj3+IHF7y+Z7nXt4mSpA59clray//WOE5F5hUBYY7AOpK0pgjol6uwv5srSxC2M4O3qgBo3GdNp9kwRBRfXTCkbMB++yaCOZtsKb0imhghC2QFWFmGxZVOs0qd5+gEUSkHA0Y9TBhogQvcXo6wh0RmotcaBtM0il/1Vt338COUEEBFxsxjYDCphqjv/eYca5nLUOfYDP+VeZPicPG+VueHHJ8QrsWppOcsBnPc4bUzbOyu2k1fJ+aPeBdciNDzdVmlNgPLff57iGfygoxVXUmhcShI4FqFxeUPbR3n7zmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlcPXrsG6XuQhF1d81Bvcg5JeedKw5bINvA8r/GHEUg=;
 b=riH8lxxHQYAQX5JeUMOfPu42OAdh6kRDRQ6VuA+oE+Cx4yrPjfUUfpHUojjnw/1zKMpPgj6NynMpfR1REsRia2cRk72whGnbM4tshMKhnRKDMTWq69Xgj9Xy2caPnHnoFLphCf75SUqllpfALOVnyo2exaQDB7b9tdsKdJFHMFQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPF5EEF2B425.namprd10.prod.outlook.com (2603:10b6:518:1::7a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Thu, 13 Mar
 2025 13:45:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 13:45:52 +0000
Message-ID: <82c42c05-8b25-46fe-b855-09043cf4f702@oracle.com>
Date: Thu, 13 Mar 2025 09:45:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
From: Chuck Lever <chuck.lever@oracle.com>
To: Sun Yongjian <sunyongjian1@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, yangerkun@huawei.com
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
 <2025022621-worshiper-turtle-6eb1@gregkh>
 <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
 <2025022612-stratus-theology-de3c@gregkh>
 <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
 <2025031039-gander-stamina-4bb6@gregkh>
 <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
 <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
 <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>
Content-Language: en-US
In-Reply-To: <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:610:20::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPF5EEF2B425:EE_
X-MS-Office365-Filtering-Correlation-Id: a636e2e1-7602-4ea0-8dd3-08dd62355eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWM2NEd0eit0R054U3kyQ3dadzNiWUtra0xJV2ZFa3pkRVM4Q3ZtTHNoSlFi?=
 =?utf-8?B?Q1ZLb0xNdXRJTEd6b3hnaFdtbmd3WXlpb0crdG9HbWpqK25jN3Qwbk1iaWxP?=
 =?utf-8?B?WFFSaEpEQkdiOVJoRUU3T25ORjNQRklWM1prUHkxM0JCMjQxWWhqcnRDYjNx?=
 =?utf-8?B?Y0Z3OWZ6L2kvdkFHL0oyTGJ2dzBQa1BpWnNiZG9ZMUJ5dlNmQUZ2M1FqSVpK?=
 =?utf-8?B?Mnc0bE9WSThYak5pd253eEtJWmFzc3ZuVDh1d0JXYVBGL1hFMFJ1QVVXV29v?=
 =?utf-8?B?V3ZzbXhlZUdrSkJWdllFS0ZVbkhuSDJBdUNNdFN5ajdvN2wvc0FpcEpOVUUz?=
 =?utf-8?B?UTFhbVh3Z21zQnNDWDdBQTN2NDJQQnRRQWI5RjZKQlZ5dXd0dFdhWXpIN1dW?=
 =?utf-8?B?WThkNmYrcndoWm1PaTErT0lscHRCVTZDR01iT3hpSDFrWEFiQnR3c2FDZ1Er?=
 =?utf-8?B?YlNpY0oyK045S0luRkRqYi9wSnRHUDg5eDBSbnlCR3NjR0FWV3l2aVVZMEk1?=
 =?utf-8?B?UHp1R01rSzFJbFd4YjZ3NURWTUIrWm9PdUZTL1E2cUlXNzM2aEdPWXpXQ3dy?=
 =?utf-8?B?MEFSMGNMM2IwUUhiVFkweVU1MXFkdk5SMWh2MXRzbDBFdlBzY3FoM3FuR2lF?=
 =?utf-8?B?M2c5S0s0K0JnYzBTMWVDWHVPOUJSMmR5YjhrQ2ZCVno1VUQwOC93SE5id0tJ?=
 =?utf-8?B?cEFhSForQ3ByczgzTGtqcWdLKzdZZlJQeG54OStaQ2J6QVVqY1NYSzgyN1Vi?=
 =?utf-8?B?blVIVXFod1JxR2xuQ2x4dEFYODR4c1NWQmVqRzFzaE9qZVc1KytERDVnVEJK?=
 =?utf-8?B?TTdJZnFyOVNyeTIxUFJJQk1BbUQxbWppNlc2TlF3ZXhtOFgvWnJCNUxVU0JV?=
 =?utf-8?B?eU51ZFBPZEpqcWlLVUVEQnA5LzVabGJGV21PWmJiZlBhaUJjaXhwRnQwbStm?=
 =?utf-8?B?SDhGamg1OTgwQVV6UUwrL3o2bDYrS2hidzBJTEVwSEViNzhmS0Nhd1FmT1Bn?=
 =?utf-8?B?Q2ZEb0I5cmVHYitLdVF5d0Rkb0g2TGVMd3NOTk9YQjZyNUlhN042UCt1Unln?=
 =?utf-8?B?eW1ONlpsWHovbHBGRFl5UzBWbW1OYkFiR0hOZmd0NUNNNXZwOEVyV1NYWEI3?=
 =?utf-8?B?VEFRc1gvZkFEVXUwSDFJMFZNYjJMbGZnalc0Yk11TjdZSGxjcUIrdGl4SjZE?=
 =?utf-8?B?SERYRWRzZHY1V3FBdlFncjltYkFpMWhZVlpYaGg5MkdwblFjb01ZelcvZlNN?=
 =?utf-8?B?dmlNK2VtVUI2czlQemxibkw4ZkFzaER1dEM3VTRoOElKWjJFREFsT2c2Zkc4?=
 =?utf-8?B?UDhhV2RDZzZIZzVMZFpzalp3YWhHYm50QzBkdUZIS0dFZUs2aDNJaEhwTWJX?=
 =?utf-8?B?SkIwUnRvRHBBa0wydlBCS1kwZ1NCZEIvMXJxeEpNenc2RUlJblFoTjN3MkNO?=
 =?utf-8?B?bjU5YktkMGNtOVl3N3RjdUxrMnhxTlhnS29zaGpzR2UreTBkWEk3NUlzT21Y?=
 =?utf-8?B?WTdwdEhvU2I3SDRMK1dFNW55SlI1TEY4L3pWYklSNmwxb1VZZ3Z5RVZhKy94?=
 =?utf-8?B?YzdhcDZ2VzcvUkhwcnVTZEoxVkhEZlEreXRKWDlVcnhzMlVJc2w1S0xzZ0ZR?=
 =?utf-8?B?OEpleko2RmoyQ2FxT2xuMDZ4dWdHcEdoandkempOQ2tpOVROUC82aXlSczRw?=
 =?utf-8?B?MTV5UkFGbGdLRHFWV2EvVEVmSUVvMzBpaGIra2lIVkc2Ukp5aXo3LzVXcHMz?=
 =?utf-8?B?VVVmQUFSblZKUHloTEcza1pKYk82UXJDcHp4enhoblZGN0lRVjl6MVR3d2Qx?=
 =?utf-8?B?dmlSMENxMWpVU1VDMzRlYmtvWDY5WTBSWVErLzg3YmlSVmtYRGU3SFdqNmVu?=
 =?utf-8?B?VFZwWlVoUEJBcVJQdUZSdTFQY1JNTklza3MrQ05MQ3VYWkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmxSQWNBMXl3a0FtanExTlFabW5TV2lmanVQVnlDUjdiTmZMNmNzcjBmQVhF?=
 =?utf-8?B?b3NkK2NQQXR6NG9DZ3c0VHZqMFV4VjNySFczVEQzY2t0VWFzNWNtc0s3eTZX?=
 =?utf-8?B?bGpCM1JvRDZyRWc0WDlmZnRMUFR0aCtTa1g1VGU2UDJLcHUrZFFrOVUwRkVX?=
 =?utf-8?B?bUZlVWxGZUd1T3ZGbFRUeHVGR1VqaHFadXhIeEpuUTNnYld4aTNYbjZoL1dE?=
 =?utf-8?B?T0ViQXdRVnJ2N21kU3Fmb2F6Q2tsMkYxZXpJemYwc1ZKWmYxR01qTlJYLzRy?=
 =?utf-8?B?VGpqRFV5M3lQREVXcVVkSHhnSkhmMzk0b0ZoanU5alI5dyt0ZGx3UE90dmRx?=
 =?utf-8?B?RTBXQUhQekdxTnBnSVE2d2wvTjVDV0F6RWdSZ3hYTzA2U2U1L0ZKb1JoNTJn?=
 =?utf-8?B?ejNsanVqMkFNeDN5dDJEdHZaa0gyYm82OEx0aE1DR3k4SDJzRVZERE1Pb3ZI?=
 =?utf-8?B?Zlk4Uk5VQWdneVZBbEVKbGZRMzhQdWFIYU5zVHM1SnU2UXBkTXVvM3gwMmJB?=
 =?utf-8?B?bW9Kd3FOa0lMMUNSRU9wWkFzSXZpaUwrei8wdTNzYVJrb3pHVklMVi91dTEx?=
 =?utf-8?B?M1JXc1loWGZ0VTdvYmxLL1NCY1NhSUdFQ0ZZUm9rc2tyQkdhQ0pmM3JRbTlN?=
 =?utf-8?B?QzR6V0dFUUdxVENRQ2dTVEpsdWlZNkJ6S3RZdno2OHZycWlVVWtoWFdwbVhB?=
 =?utf-8?B?TEN3dHNTTTZhUHBOK21ESW1NZHJtdlpoUjgraXBqeXZEWGJqQVV4MTUrZDFF?=
 =?utf-8?B?a0xZYUpBa2l0ZGVjdnFIcGMybmp3U2pEVk03aEp3cVhHb1FaNTREZHplSUpI?=
 =?utf-8?B?bk1aeXphYnRrMURVQytQNnBHR3VjTFFhWmhmYlB3U2tOSFhQWnNiTGMzY3BP?=
 =?utf-8?B?R1lJSTNycndlODREazg5cmM4UVVYa0tGcGs4Qk90MG96TXY0T3hwcWVYRHE5?=
 =?utf-8?B?dkZRUUpPZzMyTzdUV1JFUjFHVXVLazFqeG5XMHBlZVE4TVJZSTcxNUJCRSt6?=
 =?utf-8?B?N0JzNUxKRHl1MWo3clN4SmFLKzN3Qmk1QktVV3hmWXBpNFJ0ZmxOeGdDSng1?=
 =?utf-8?B?Y1VYM2dOS3RqSEM3TDlpNUtDL2NVeStqYkZFVnhHNHRxMUt6K1Naa0pmK0Nz?=
 =?utf-8?B?V3dPT3lyZmR5dXRUeHJpY3l1QkRtUHlOWDJZSUY3U2lvK1hKVjRoWlUrb21j?=
 =?utf-8?B?NmZaY0hLRnFNdGZ4bDhWekt3SS92MDFBOGdEcm1iZHdiOVhhYVkydm9tbUM4?=
 =?utf-8?B?UzZxd3VvZ2pFbFpvNkRRMG9lWlpJU01yWmVuekVNWHpaalR2Ulg4Z0MreFNn?=
 =?utf-8?B?TjlaM2R3NWE2b0xoUnkvcjlOT0tSRGhyM0RPcEdPSFQ3b2dzRDJ6YVJhajl0?=
 =?utf-8?B?aFhuc21Md3ZxTGcwbUVKRlR5UkJtWFpQRjYvczh0a2JCSUVZSFRiK2lzQk1m?=
 =?utf-8?B?MUZtMUNENnlnOWFCcGh6cTRGRFdzdWdTUjJPRlJJSlNOdktCUktRZmV3b1Q4?=
 =?utf-8?B?K2R0Z3RsUW1sMDNTWUxWNEpwNUhUbjVUaW9aT09lcFMzTlFremFXb2FKSmln?=
 =?utf-8?B?WmExOG9VS2hwVHlVT3hHUldpRnJOdGFENGs2Y3JPdHFMY3haY1d1M0o5YVpK?=
 =?utf-8?B?Yk9ueDVIZTd4V3hLQXA5dVJRZG80QkY5ZzdJcUdMT3JBbUUxaGhJbnlhRHpw?=
 =?utf-8?B?ZHIvcnpRd3ZLMzdYVVhTUEV5YzVkWWd6QVBTb0h4UFNoZk5LU1hwZytjYUNl?=
 =?utf-8?B?WkNCaUNwVHd0R0dGbklNQm1jOThMTHJ4cUxUeEFSZDM0dFNZaUFKeGNLbEI5?=
 =?utf-8?B?Nk1mSWJUS1plUlg3Y3JpRzU1ZlVNTGVDZVZvQ0FuZG5sWGxEUjlDR0xFZUpo?=
 =?utf-8?B?bmFqRW4rZ0ZpeDQ0UjREQVZlWTVEK29ybURiTnlEUnIranNTdVZndll3bDZk?=
 =?utf-8?B?djl3R2lTZFZKU0ZZS3ZUYkxUVVlPTHZJblgweXdhWU9FWkJMalhnYzdIWXE3?=
 =?utf-8?B?Z0Y4elE3ODZBSDdrVXZaMmVhT21XVDd3b1dNQmpXQ2ZyeTM3dmJzdEdYaTdU?=
 =?utf-8?B?Ti96UDFGTlVMWHBFN3Q2THlTbEpkNUtqb3FUTGlQcElCVDFkaW15WFRiVUFq?=
 =?utf-8?Q?csL4Qonetz6eF/E6g4i8ytt77?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wx36jwUCzg/TIWLSV2/oBCHt4MI/A/azexPynep2cAjcykWMiCxBIDpnC2NDb+XITFhIecKHuMNtWb7MvhE22iRecUoxiz+fwOBPXWeCX+ocXvnAngsgp74AbSe4FJosuhLM+56VImhXrOSbvQPpveyqSYkpBsp/z+gnFc/q8d7WlDybwxQe9g34NMkt/fjWLBytQGUJy9K3Pu1JcxsyR1T6eMSxtNWBJ7ajAjlRvWRfPNUlgr6ZrV/rnJj1NZtnD10eP/qP4m8TTPNuRstm01ApsBtgGLzVegd5TcxAry7qvuxaFnc9NTsoY3G+3YqMr1UlHap+EE77TPAQA/nkYqmTDU0ORIO5nDNR9tv/l6bmlZHTfpuzYxrsrZJcnd/Ym0CtHdu2T6qJyVal2Vktl9Q3SVb40YlC9wR+frcfoJPtxWer1O8zrSadHFO2nBSbJ6oKI9IKFh42BUTXGyxYZN0KnGk59NVImQyjV89cOx9FpEjjuvkqCZZHsmYC834oMf+noJ1b5W4/d39u2euljrdIHAqAzMPywWcx8L2JVmuB6I4/CLIqLgT/mgvU5P8IxmlDyxFUnAyHmHWGIy41lWY2Rdhty0+p3r96Sv69dVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a636e2e1-7602-4ea0-8dd3-08dd62355eb4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:45:52.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6kuez97Mc9UAAPtGv9qgIlYfGscbv3Ssgf+rCNFgFlaxH5vKQa89jK7SL48bNwAEeq5C9fSeoRbIWVBAArh6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5EEF2B425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130108
X-Proofpoint-GUID: Cvt9wbJ7iDVSsCST1trD04k6r9H69A2K
X-Proofpoint-ORIG-GUID: Cvt9wbJ7iDVSsCST1trD04k6r9H69A2K

On 3/11/25 11:23 AM, Chuck Lever wrote:
> On 3/11/25 9:55 AM, Sun Yongjian wrote:
>>
>>
>> 在 2025/3/11 1:30, Chuck Lever 写道:
>>> On 3/10/25 12:29 PM, Greg Kroah-Hartman wrote:
>>>> On Wed, Feb 26, 2025 at 03:33:56PM -0500, Chuck Lever wrote:
>>>>> On 2/26/25 2:13 PM, Greg Kroah-Hartman wrote:
>>>>>> On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
>>>>>>> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
>>>>>>>> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
>>>>>>>>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
>>>>>>>>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
>>>>>>>>>>
>>>>>>>>>> There are reports of this commit breaking Chrome's rendering
>>>>>>>>>> mode.  As
>>>>>>>>>> no one seems to want to do a root-cause, let's just revert it
>>>>>>>>>> for now as
>>>>>>>>>> it is affecting people using the latest release as well as the
>>>>>>>>>> stable
>>>>>>>>>> kernels that it has been backported to.
>>>>>>>>>
>>>>>>>>> NACK. This re-introduces a CVE.
>>>>>>>>
>>>>>>>> As I said elsewhere, when a commit that is assigned a CVE is
>>>>>>>> reverted,
>>>>>>>> then the CVE gets revoked.  But I don't see this commit being
>>>>>>>> assigned
>>>>>>>> to a CVE, so what CVE specifically are you referring to?
>>>>>>>
>>>>>>> https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>>>>
>>>>>> That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory
>>>>>> reads
>>>>>> for offset dir"), which showed up in 6.11 (and only backported to
>>>>>> 6.10.7
>>>>>> (which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
>>>>>> d_children list to iterate simple_offset directories") is in 6.14-rc1
>>>>>> and has been backported to 6.6.75, 6.12.12, and 6.13.1.
>>>>>>
>>>>>> I don't understand the interaction here, sorry.
>>>>>
>>>>> Commit 64a7ce76fb90 is an attempt to fix the infinite loop, but can
>>>>> not be applied to kernels before 0e4a862174f2 ("libfs: Convert simple
>>>>> directory offsets to use a Maple Tree"), even though those kernels also
>>>>> suffer from the looping symptoms described in the CVE.
>>>>>
>>>>> There was significant controversy (which you responded to) when Yu Kuai
>>>>> <yukuai3@huawei.com> attempted a backport of 64a7ce76fb90 to address
>>>>> this CVE in v6.6 by first applying all upstream mtree patches to v6.6.
>>>>> That backport was roundly rejected by Liam and Lorenzo.
>>>>>
>>>>> Commit b9b588f22a0c is a second attempt to fix the infinite loop
>>>>> problem
>>>>> that does not depend on having a working Maple tree implementation.
>>>>> b9b588f22a0c is a fix that can work properly with the older xarray
>>>>> mechanism that 0e4a862174f2 replaced, so it can be backported (with
>>>>> certain adjustments) to kernels before 0e4a862174f2.
>>>>>
>>>>> Note that as part of the series where b9b588f22a0c was applied,
>>>>> 64a7ce76fb90 is reverted (v6.10 and forward). Reverting b9b588f22a0c
>>>>> leaves LTS kernels from v6.6 forward with the infinite loop problem
>>>>> unfixed entirely because 64a7ce76fb90 has also now been reverted.
>>>>>
>>>>>
>>>>>>> The guideline that "regressions are more important than CVEs" is
>>>>>>> interesting. I hadn't heard that before.
>>>>>>
>>>>>> CVEs should not be relevant for development given that we create 10-11
>>>>>> of them a day.  Treat them like any other public bug list please.
>>>>>>
>>>>>> But again, I don't understand how reverting this commit relates to the
>>>>>> CVE id you pointed at, what am I missing?
>>>>>>
>>>>>>> Still, it seems like we haven't had a chance to actually work on this
>>>>>>> issue yet. It could be corrected by a simple fix. Reverting seems
>>>>>>> premature to me.
>>>>>>
>>>>>> I'll let that be up to the vfs maintainers, but I'd push for reverting
>>>>>> first to fix the regression and then taking the time to find the real
>>>>>> change going forward to make our user's lives easier.  Especially as I
>>>>>> don't know who is working on that "simple fix" :)
>>>>>
>>>>> The issue is that we need the Chrome team to tell us what new system
>>>>> behavior is causing Chrome to malfunction. None of us have expertise to
>>>>> examine as complex an application as Chrome to nail the one small
>>>>> change
>>>>> that is causing the problem. This could even be a latent bug in Chrome.
>>>>>
>>>>> As soon as they have reviewed the bug and provided a simple reproducer,
>>>>> I will start active triage.
>>>>
>>>> What ever happened with all of this?
>>>
>>> https://issuetracker.google.com/issues/396434686?pli=1
>>>
>>> The Chrome engineer chased this into the Mesa library, but since then
>>> progress has slowed. We still don't know why GPU acceleration is not
>>> being detected on certain devices.
>>>
>>>
>> Hello,
>>
>>
>> I recently conducted an experiment after applying the patch "libfs: Use
>> d_children
>>
>> list to iterate simple_offset directories."  In a directory under tmpfs,
>> I created 1026
>>
>> files using the following commands:
>> for i in {1..1026}; do
>>     echo "This is file $i" > /tmp/dir/file$i
>> done
>>
>> When I use the ls to read the contents of the dir, I find that glibc
>> performs two
>>
>> rounds of readdir calls due to the large number of files. The first
>> readdir populates
>>
>> dirent with file1026 through file5, and the second readdir populates it
>> with file4
>>
>> through file1, which are then returned to user space.
>>
>> If an unlink file4 operation is inserted between these two readdir
>> calls, the second
>>
>> readdir will return file5, file3, file2, and file1, causing ls to
>> display two instances of
>>
>> file5. However, if we replace mas_find with mas_find_rev in the
>> offset_dir_lookup
>>
>> function, the results become normal.
>>
>> I'm not sure whether this experiment could shed light on a potential
>> fix.
> 
> Thanks for the report. Directory contents cached in glibc make this
> stack more brittle than it needs to be, certainly. Your issue does
> look like a bug that is related to the commit.
> 
> We believe the GPU acceleration bug is related to directory order,
> but I don't think libdrm is removing an entry from /dev/dri, so I
> am a little skeptical this is the cause of the GPU acceleration issue
> (could be wrong though).
> 
> What I recommend you do is:
> 
>  a. Create a full patch (with S-o-b) that replaces mas_find() with
>     mas_find_rev() in offset_dir_lookup()
> 
>  b. Construct a new fstests test that looks for this problem (and
>     it would be good to investigate fstests to see if it already
>     looks for this issue, but I bet it does not)
> 
>  c. Run the full fstests suite against a kernel before and after you
>     apply a. and confirm that the problem goes away and does not
>     introduce new test failures when a. is applied
> 
>  d. If all goes to plan, post a. to linux-fsdevel and linux-mm.

Hi -

As an experiment, I applied the following diff to v6.14-rc6:

diff --git a/fs/libfs.c b/fs/libfs.c
index 8444f5cc4064..dc042a975a56 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -496,7 +496,7 @@ offset_dir_lookup(struct dentry *parent, loff_t offset)
                found = find_positive_dentry(parent, NULL, false);
        else {
                rcu_read_lock();
-               child = mas_find(&mas, DIR_OFFSET_MAX);
+               child = mas_find_rev(&mas, DIR_OFFSET_MIN);
                found = find_positive_dentry(parent, child, false);
                rcu_read_unlock();
        }

I seem to recall we considered using mas_find_rev() at one point,
but I've forgotten why I stuck with mas_find().

I've done some testing, and so far it has not introduced any new
regressions. I can't comment on whether it addresses the misbehavior
you found, or whether it addresses the GPU acceleration bug.


-- 
Chuck Lever

