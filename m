Return-Path: <linux-fsdevel+bounces-43598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360AA593D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 13:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1573A46DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20CB1CB51B;
	Mon, 10 Mar 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qqr9YNdB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mdPq4H6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7022758F;
	Mon, 10 Mar 2025 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608672; cv=fail; b=Gczl8rSzGIAFZoYoDB7vKnSXDtpK1wL69ZBHV9k6QUwd+h6bMlm1mgtKeUFBCyYcj3PRjYlezyQLUxr/hh7eJbpSPkcGsTe+A+4WJlRQJOnlbS9oNOKH9Q+a2rWlLCRqecm/nib74M5HGrblwkSkdTJSNM9qAPpYgc19EbTOLdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608672; c=relaxed/simple;
	bh=rsYOCREq0B16Q7iSiuE4j5JGftH3ui2OB5tRfnO2Oqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NcYcoTa52DhU8TmKtPSyeuBu6gZG1kTrs88YjgbtrbIZKLxacUY2Bb4nvV63YgQm6j6QIBe87J63E2wtEZ+f5toh+Gpy1JhrGhnLhBuxr/Uq1/OnZtk+4o3v3kCAtxeaVGkMNSA44WTw3yjUJV6DVwLfURaOUdB6dlhO8bOGjxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qqr9YNdB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mdPq4H6Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9BfNA012570;
	Mon, 10 Mar 2025 12:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TGIcAdXvlngIj25g+969UPrPmMk2hQbfw9skI02kS60=; b=
	Qqr9YNdBW01kaOAMEP3c4hkLTzlH4dNULuclDp7Z1DhlaB3hwswYGwkkiMiE5u2/
	ncS2IRxaIdygd+FUfydVqQwsNuvI9xoqAXKG7FkhqbUnBhNDEjYq0GfJyrxq28PI
	mkRoGs/qayoKWXU3CZBJePkTNZzYqvwkL+YIvVVprmYiOD61iyKRzLUVqDdGpAim
	Ta65aTpxjyW0oUgBoCGfmxtDEvG82CGXAPKYCQPswl6WxBiQXZP/7DJXd7n/zk29
	47NYkbX4tHAnwAXUuf1iolmcqXljHIHxYHjXE5UeTzZp69u3KV1UhoiZL1e0Lg5S
	pykGbgxFmMdER5XIzTPnww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458eeu2crd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 12:10:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52ABUEuB021717;
	Mon, 10 Mar 2025 12:10:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458wmmxqfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 12:10:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQDsko7Sl05w6F2Tw8VT4k5uPFvDueEdswVZKgtG3vBsVgIVhSR3QcCRAWDj63fcNRLkOkPvxFgLNQNHwJ6ewuDjGrPlVV4ohMHc+DqXSgexwhG1gBoqXlop3P9EOLAK89SZaq7wXpzn+K4HGo/MMGp7xgXxGGSqu00bgms7mZWH6zIpJkEHmgtKgNlDciyJKXgvBMy3z4fL+Sn7YLbHEmsuh0BJyE7FwLCeI7BUz6Q8z1g6HKJc6LmvDdgJ/C8OCObglHEYSiXoSxsc2TFLGrZKLHXQFA5DwRfubZEa/8a5onTEVzJTIaeGFxPu6mwMDubZxZ/7ocrDzwkENz8w9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGIcAdXvlngIj25g+969UPrPmMk2hQbfw9skI02kS60=;
 b=fqJaUU/EmNi5/Zx3yrAIPv41AZNoEbSiqTdQgHkpv4AzQcKIu/ysu5GtEjgceAmfBd9g9p+cq7Hq9XUo71U39ycY3IeT1jl7lpH6TZU3o1cmNP2/2PzgQmFDtyBlp4Cik+xgpyreeEzoEKYdxabbaXNKCNtzxIKiruPet0JX8mlS8vGJX2WZgM7NLp/h2MnA53O+D4WY3RjIqx7KPzxWnIOI3Ow7minsRC/Tl3/2Z8ysxXg8w06SQsyMIaPFJXGKXreysrNf5m5Idcxlz78wJeJwI/pFSBat5dp97EG0mWUZBC2Ofy+b0xUikwSxTVLPIBaklN2hi3jtGnfH5HVvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGIcAdXvlngIj25g+969UPrPmMk2hQbfw9skI02kS60=;
 b=mdPq4H6Z/lhITviQhHHio7W2GEADh905zgfVhQXL2jr3gSY2Q8pO8yyRB8b+k+rzFTFfHvfRInzbRqa9tlVtiD0vjlDDMBDPwBE/nGD5lFKf32eR8a13XrfHzdcj+WNDJYfzIdY3/Y3otFvv8Wzs8mZ4lGvpP0M2hZvN0+C8SSU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6876.namprd10.prod.outlook.com (2603:10b6:930:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 12:10:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 12:10:48 +0000
Message-ID: <ad152fa0-0767-45cb-921e-c3e9f5eac110@oracle.com>
Date: Mon, 10 Mar 2025 12:10:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] xfs: Allow block allocator to take an alignment
 hint
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-13-john.g.garry@oracle.com>
 <Z84QRx_yEDEDUxr5@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z84QRx_yEDEDUxr5@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2d99f3-266a-4e29-b5fb-08dd5fcc97ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2NNNzk5UHBaUTJIZmJwY0cxQjNpSlpZMTB3WjNNVmNESWpOS0QydGNoZ0th?=
 =?utf-8?B?SDBJbCtEMEpSQjh4UlRhN0xpNFNmVzNndmlmRzFHcDJnZzhMa0lQWW5FZXZ5?=
 =?utf-8?B?RUt4aS94S203dUZ6bG81V0piQkF2ZHJnZ0N1MzcxTnkwTXA1Y3RPSkdLbUNY?=
 =?utf-8?B?QXZoK0E2dTQzYXlwWmNRb1l3WE8wdy94ekRJNi96Z2NDTGRiOWx3T2pCZXJm?=
 =?utf-8?B?Y3I0dzV5L0VzL0YxSWdmWUhZakFPUXFDN2RMSVNlK3NQOWF6cld3em1waVhD?=
 =?utf-8?B?ZkJ2WmdrRngvRkk4OGpHWW5jWEpZaGJ1K29BVk94SitWVHdvY0xqcmhUdEFG?=
 =?utf-8?B?QTNGa2ozU05xd3JVakFYdEVsSVRWL0xpSytZOVdleFk3UE1SblZQNjlibXpL?=
 =?utf-8?B?SWEvemNiQnlNTXhhVFMyMWxLNHNaU0xla2EwOHc4UkxHRUxCSCtzOTkzclV6?=
 =?utf-8?B?a1dML0tRaDRUbkZJTHYyRjhZOHNZaWwvNXlCcFFsSXdTRTBRbzgvMUU2OUM0?=
 =?utf-8?B?SVBwczJRcGlVTmRzU0V3TTF5eWZHOWpnWUJ2UTlJamJHeXp4ZlNtTlVJdkNJ?=
 =?utf-8?B?MHVIUVYyNlh5dlgxNkNDVTVWVVZRKytibFpUZW9aQW9sL0tOanhVM2dWclNL?=
 =?utf-8?B?NTdqdXY5ZXN3MkxtSUI3QTh3TU1KeS9UL0cxVlpJQUFhZ1hpTjU3STcxV0RR?=
 =?utf-8?B?TEt4eWFDZ1VJVEpsdUtOS2dOU24yam5tV0FEUkgrejdRVForMjNGKzJnM2tj?=
 =?utf-8?B?R1RHTWdnbjM1VlNrZDZsSkluVk5QVHRsSjZ2Q3RWUitGbDdHNEZnT3ppWVVI?=
 =?utf-8?B?L2gvZjVyQUU3Yytock9YSTRoUVBxdWd1dUhtdTQ0QUkzYi9TRkxHYS9lUTZn?=
 =?utf-8?B?ZHhZekdTakpSbXQyL1p0KzlIL2N4Ly9FYTQzeVFWUTQ4V05WTXNIYnZxSG9O?=
 =?utf-8?B?WmU2REpsaU5nWCt1VytibkxqZi9VejJPbEMvOTZLNDdjalhqSGRMbkEzT3kv?=
 =?utf-8?B?bm5yNkNpeE9iWkJjcVlxWlJrZWFPcU82SFBuTTM2WjhHZFQ3L21mM1kxdkdq?=
 =?utf-8?B?UVVxZ2UydXRjMC9OdldCeDI3ZTBZZGN2R3hsenVjSnQ3UUw5TDl3SlVOYldJ?=
 =?utf-8?B?N1dVemJFc1U2cUJqOCtEbTJIYUpiOFVCOVJudWFNRDV2QThRQWtTWnNVamhP?=
 =?utf-8?B?RjRIWlNLbmNGdEd3enFLNVN4SEhUbFZqOVkvTXlrUjM2VUFKWUhRTTdCVU5s?=
 =?utf-8?B?d3RYL2R1TkkwM0FQYVYwUHdobmZCU3hXRm1zNGNsdDczYVZuZ29iZFpZR0Zu?=
 =?utf-8?B?VllvY1AydXNkTkxkeGYzUTdpcWFaSndxWEZtaGNrMTNvZlBEWC90VjZCU2Jn?=
 =?utf-8?B?dXNXSlZnd1dJQU5wWFpIV3BGVVpxUlZCaVFHM3RTOHlJNmZ5SFN2SnhaRzFK?=
 =?utf-8?B?eDdzbiswL0EzR2F0dTl4QWJTY0tYWHZEQm5xSUFGU3RJU2M2aTRTdVdidlp3?=
 =?utf-8?B?N1VPV2NmQVdvT0IySTdWcnVsTitVbkpQdEJNZlB5WUVxWFZXS3hCczFVbWRh?=
 =?utf-8?B?RVJJUWR0S3QzaThoT2UyWFQySnFGL1FzS3NtUTdpdC9renlEYlBuQ3FmaEdq?=
 =?utf-8?B?c0FmUXBhVld2MlphWHBrYUhNMXFTNDhYeGlzbW1IcG93eWdkRk1BSVFhdERS?=
 =?utf-8?B?dDRCcHd6N3ZoRVFpcjBuRDZlYTJTZXJjYWxkYk5odUpBS01kdkQxYklRMm5U?=
 =?utf-8?B?b0RxOTFBNDVEV25yQVdYejBUNy9EaWtKYldwdkhKVVFrYmNBK01LQmo2K2Qv?=
 =?utf-8?B?SWh2NXd2ZC85VGs0b3BSWG9sTjVvR3lOVUFIazBQTXZNVTdjSkFLcytKa2py?=
 =?utf-8?Q?KlWmghCv1Enm8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEdISEZXRzZqUWhnbkt3cVBHT3YrbkgwR0Nid081czk3aUdXdFR3cFZUYWNr?=
 =?utf-8?B?V0YrVmFXazA3S0ZybkhxOGJaMWVWK1d6aHdEZ3NYQkljOGJneTBaelR4eDRK?=
 =?utf-8?B?M0JXd05CcmV2Y2tWSE5xQmwyRnI5K2xxckRjZzFxRlJXSTU5MzhNSGdPZW5q?=
 =?utf-8?B?djNtVlNYMEx5cm1YRnYvOU9GNDZNeGVBS2MzdXVhc0oyVVlIV3EySTM2Z3la?=
 =?utf-8?B?MDBkMTlFRnlQLzV3OC9RMzAxL3Juc3ZTTGRMZFY0WVBSWGtpSzNWMzNYTi9I?=
 =?utf-8?B?V082NFRRYWRUelVuL0UvTjFObzlyNnRQcWlhemczblhINzhYbnZQemwzK0cr?=
 =?utf-8?B?Q2NCU3FkYU9kMGVWL3NvbWQ1dHVZbVZPcGsra0J3RmxsZHZsYkY2S084em53?=
 =?utf-8?B?dXdnVnRYa3pybXpoYld6ckpzSDNQQVVCdlEzcENwVUtpZzl6TVh2a1hmRmI5?=
 =?utf-8?B?QXlQcnRyVDhCc2tLZUdyaE80eTVxZFcxUTRvUmdiL2hPTGFad0FncTNNZTdh?=
 =?utf-8?B?OU5vOFBsSEgyZDZaS1FMZHJWNTJKa2ZTUzk1bE1jbll2L292cmRNR016RWtY?=
 =?utf-8?B?cFczUjBabTVEZDA1TkZqU3pMakk0ZElnTXFBb3NBR05aQUtMRU5vZi9DUGt5?=
 =?utf-8?B?UUtNTGtFNnlMSDBiSGdXUVBsVk5tYkJ2RFFoOHBvc0lSQUxmRG9EdlFMVnc1?=
 =?utf-8?B?NDA4b1pkUW05Z1NhZ2FWTlpDZWNJd1RiMDBNaVZKTksybUphQWlJVGdINHRX?=
 =?utf-8?B?T2x2a0w2b2tZbEhDYm81alRMRU5nb01UUm8vc25SVXU3VG5LeU8wOFc1TSsw?=
 =?utf-8?B?dkEvK1F5NDN0L0JpcUY0U1NjZ2dUeWhIUmticXpRMStqMGZYUG9BUGowRUdC?=
 =?utf-8?B?TXZqK1hPS1VFcGV4aEdKK3hWWlhOd0pHWkV3MXRtSnNQQVBWcFIvT3NJb0U3?=
 =?utf-8?B?M1dsT2dSQlZzM1A0bUc5L29mblJaVmZNbVp6TDJjQ1kxTVY3cDVFeUVsa2xY?=
 =?utf-8?B?S3Voa1F5V0tPQmE2Z1ZTREk0QUI4WTV3Vk9WUUpYOTh0UWxra3drSEMvcm5k?=
 =?utf-8?B?SEJ6VzZBN3p1VDFiUTIybC9NaXQ0QzBpWFp2cGtoNUtVeXhjbFBPRzIwVkZz?=
 =?utf-8?B?MU0yK21kak5reUhlSUErb0hDQ0FUVlZaZmZXa3dHcVNqNk5vYTB1bGZ5SXBi?=
 =?utf-8?B?bkRGYzF5RnZwcXVBNkxRaVcvT2YveWs4NEtQaHZpcUxDSFdpUVIxcEZRajFt?=
 =?utf-8?B?U3BCT2VSRjdyWkExa3VvSHN3SjV0WitucFVhQ1VtaENFWllONDFtckV5NS9C?=
 =?utf-8?B?dlpvUFBJV0Z3Q3hGSnJnbUl5aHE4cXZDWk91WTFBVGZSSUN1NVg5N3JsRGRR?=
 =?utf-8?B?STJyRmlPVkxtN2l2UGVhTlhoTEZTUDFPbTZTeDdPeVV1QVp0dEMrcHphSy9V?=
 =?utf-8?B?TWoyK3BhcDBoVFQ4d0RNbVF1R1NmWGdySmVReDRvWEVudlJLQTZIVnVDaW0r?=
 =?utf-8?B?T3BFMnhnM1JIWk4zbERRZUNucjFjTVlzNjlOMVlYN1VNcjlyd1ltQlU1VGZ3?=
 =?utf-8?B?U0JtN1VQV1lyUHVLVjQ4ZDFEVGYwdGc3S3V6OCtvNDRDWitTQkFZYXR4dnpa?=
 =?utf-8?B?WjVtcnZkbG5MV3MxRlBqcThKK0NNTW96cFZocXU5N2dKZ1VIYTJiZ0tHcDJ0?=
 =?utf-8?B?bkxiSjVmZTRDM01ucHFrZ3RNbE5vNXdTeG5BRWdxRGZvWlE3NEIvNzlLRUdp?=
 =?utf-8?B?TWtZbWdWVFNZSTh3cGtTUFN5cXBCcW5xS0l6QmxDT0JleCs4enJCRHpqVVZR?=
 =?utf-8?B?R21Jd1lzdFZXR2FNUWZGNlk2UXZsbk40UjlsdFpnNFlQSi9Hakw1UFdVUGJw?=
 =?utf-8?B?azFhcWtSL2lkRHJ3c2kyNFlPTm1sU05DaTJqVVBjUWgyakFiMlFhM2xmekND?=
 =?utf-8?B?WW9aZy9HUlI3M0ZXYjdJYUxlVlZrU1oxUWhvS2V1Q2E3c1ZrTTF1QXNKUWY3?=
 =?utf-8?B?MURVbGVISUxUL0diN083ZVkxaWFvUlhtSm1jUExJa1BoSWhGRWU0aUdHMjNV?=
 =?utf-8?B?emdjWnNWRE51NHc0VHJJSWdxb2lpQUx4Ym1hNzhQeUgwNGFrbWk2RFY5eTJn?=
 =?utf-8?B?UXZLNlArdFpWSDZ5bE5kQlo0Q0R5L1RJMzVGNkl2bS9NSm1ieUJCdTVmUmc5?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VU98pMvgz9vS1TVIY9KX5XvVKtXTkCX78ywExozhwHD63ZLaNpodrnxqssbvNXIck0s9M0FPePHtLLuckQMSyrXPwalYZShWZc2Nc2FCIgfZjzpOJnwAyyUVqn8eR1Q4MCWnitkocLB2ivk4PC416ArdLp24wEw9Fev13JA6pu2mTshT2cT6V1CTptA9ct36PTyWjpLg+hk2CpQienOs4teYHZRYtUDdovP4uJ63lWeC61w+3ADSB4EA4rfgILmFrF8LwexG6Gnx1LQCHmJ8KJrpgymvVYthoh5fPKjYOqSE2T/IFavh5IlHrGxTwlXTkUUotRGWo/4o1hIQo4Z0P0Lf+IN8bN8j+UqUYnTsAxVNkHs90ITw/JdKsg8zfHeBDvflGury6Doy/EGuzO251hwotyC79yIzS6nv3NimqPRG5KbDFdscMElOBiVwCKRa8My4BncsxkhGI864z05vpCW8vPcKdjNAjV8lXKLbvmzCcW70hkFD4djydKtuZimQn488G8zn8Rz9bztgIoTX5ezDu4DOSwFVPMocdhREnPJtNLm827Nh13umObZClMd1LvB7DGc/Ky9xz39koA8TWZUZqeje+O7bZNtM7SyxXuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2d99f3-266a-4e29-b5fb-08dd5fcc97ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 12:10:48.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49FJXsUugderKmJZ8h7JWFMSoucSUBbwz3moQbXWlH41y8QZoFb7xBvLi28qRHuJs/Bt/BdrTOLggXXfrDNJ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100096
X-Proofpoint-ORIG-GUID: yX_aN0oZpNV-aIL2yGpVEcWUiIU7lH47
X-Proofpoint-GUID: yX_aN0oZpNV-aIL2yGpVEcWUiIU7lH47

On 09/03/2025 22:03, Dave Chinner wrote:
> On Mon, Mar 03, 2025 at 05:11:20PM +0000, John Garry wrote:
>> When issuing an atomic write by the CoW method, give the block allocator a
>> hint to align to the extszhint.
>>
>> This means that we have a better chance to issuing the atomic write via
>> HW offload next time.
>>
>> It does mean that the inode extszhint should be set appropriately for the
>> expected atomic write size.
>>
>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_bmap.c | 7 ++++++-
>>   fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
>>   fs/xfs/xfs_reflink.c     | 8 ++++++--
>>   3 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
>> index 0ef19f1469ec..9bfdfb7cdcae 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.c
>> +++ b/fs/xfs/libxfs/xfs_bmap.c
>> @@ -3454,6 +3454,12 @@ xfs_bmap_compute_alignments(
>>   		align = xfs_get_cowextsz_hint(ap->ip);
>>   	else if (ap->datatype & XFS_ALLOC_USERDATA)
>>   		align = xfs_get_extsz_hint(ap->ip);
>> +
>> +	if (align > 1 && ap->flags & XFS_BMAPI_EXTSZALIGN)
> 
> needs () around the & logic.

ok

> 
> 	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
> 
>> +		args->alignment = align;
>> +	else
>> +		args->alignment = 1;
> 
> When is  args->alignment not already initialised to 1?
> 
>> +
>>   	if (align) {
>>   		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>>   					ap->eof, 0, ap->conv, &ap->offset,
>> @@ -3782,7 +3788,6 @@ xfs_bmap_btalloc(
>>   		.wasdel		= ap->wasdel,
>>   		.resv		= XFS_AG_RESV_NONE,
>>   		.datatype	= ap->datatype,
>> -		.alignment	= 1,
>>   		.minalignslop	= 0,
>>   	};
> 
> Oh, you removed the initialisation to 1, so now we have the
> possibility of getting args->alignment = 0 anywhere in the
> allocation stack?
> 
> FWIW, we've been trying to get rid of that case - args->alignment should
> always be 1 if no alignment is necessary so we don't ahve to special
> case alignment of 0  (meaning no alignemnt) anywhere. This seems
> like a step backwards from that perspective...

As I recall, doing this was a suggestion when developing the forcealign 
support (as it had similar logic).

Anyway, I can leave the init to 1 in xfs_bmap_btalloc()

> 
> 
> 
>>   	xfs_fileoff_t		orig_offset;
>> diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
>> index 4b721d935994..e6baa81e20d8 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.h
>> +++ b/fs/xfs/libxfs/xfs_bmap.h
>> @@ -87,6 +87,9 @@ struct xfs_bmalloca {
>>   /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
>>   #define XFS_BMAPI_NORMAP	(1u << 10)
>>   
>> +/* Try to align allocations to the extent size hint */
>> +#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
> 
> Don't we already do that?
> 
> Or is this doing something subtle and non-obvious like overriding
> stripe width alignment for large atomic writes?
>

stripe alignment only comes into play for eof allocation.

args->alignment is used in xfs_alloc_compute_aligned() to actually align 
the start bno.

If I don't have this, then we can get this ping-pong affect when 
overwriting atomically the same region:

# dd if=/dev/zero of=mnt/file bs=1M count=10 conv=fsync
# xfs_bmap -vp mnt/file
mnt/file:
EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
# /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0525 sec (1.190 MiB/sec and 19.0425 ops/sec)
# xfs_bmap -vp mnt/file
mnt/file:
EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..127]:        20672..20799      0 (20672..20799)     128 000000
   1: [128..20479]:    320..20671        0 (320..20671)     20352 000000
# /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0524 sec (1.191 MiB/sec and 19.0581 ops/sec)
# xfs_bmap -vp mnt/file
mnt/file:
EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
# /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0524 sec (1.191 MiB/sec and 19.0611 ops/sec)
# xfs_bmap -vp mnt/file
mnt/file:
EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..127]:        20672..20799      0 (20672..20799)     128 000000
   1: [128..20479]:    320..20671        0 (320..20671)     20352 000000

We are never getting aligned extents wrt write length, and so have to 
fall back to the SW-based atomic write always. That is not what we want.

Thanks,
John


