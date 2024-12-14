Return-Path: <linux-fsdevel+bounces-37425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9959E9F2007
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 18:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017F81887E75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51B77B3E1;
	Sat, 14 Dec 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z0gFjshD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BU6dMTRC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408862940D
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734196440; cv=fail; b=QBRbrnIGodSupWEtZZZF5jgFdXi5Ug/xIRaKGjth/FB/AIg4zhBkoLAZHlXTLGxbn929vOPtPyNYnZ61x9KXQDQkb8aFXOeENzZIUpPk5YxfwFk73Ly9+bJBgXCBTr5XoYCe7s9p/XaE+RoXVGm9xiO6afuoSQ1HSRC0W9ruTA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734196440; c=relaxed/simple;
	bh=8k7IlrJYSsmltMf+a2o1YzJIVnPpMvObLb+cqvmn/vc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bTyXs2ZPal4wBV0I50VLt5ixpG1XJzf1tRjGWl7AKMbg7Cyq2xCta6+/9XZYvOJTtZ/d2B6EK366T5KMjzf2S8+25TwoZl321TX/Dt4wKCpDaydeypOBcZ+D1Zn3yyqlZ0J96DTgJYkYoJowvJRCbYdZqcu0g8jQJBvob2NDVps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z0gFjshD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BU6dMTRC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEBU3tg022539;
	Sat, 14 Dec 2024 17:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZvdKxih/8X3u8joXFJPqX3WLTTceds6+rPOfmihwuWE=; b=
	Z0gFjshDl2aY6LZ2yv67ad2C0YWEqsbgipwDP+sEAIwWUZGLLOBmANn7Q7W30ze7
	xY39nsSoJndA2s/bvmnw2y0DK5Kf5S9+07Wt2Wpx9rUTmDRBYx6ad3bFT05SP70I
	vM6JkcESHORzZUGCSOEGDthNJAQ+SgMc599IBpUOLYitEEowrPOyRxAAXmFJiRPt
	NWXUcWHJl1QaeTcMYwjMT2y2iZ5S0O+dwJ+y7qZwaPi4jTyH/fUzMhl6ZHYHmrFc
	uX+pENCnGcohuGG82ZAFsjzbRlXJ3uYYIqZvxTD6To73WoWl/Nx8b6hj0eIPwUbL
	R1virtrbElJLceiBzEq5MA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cghx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 17:13:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEEAAxQ000776;
	Sat, 14 Dec 2024 17:13:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f5wjy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 17:13:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPTCbxOSbQbEWPDP3q27s+HA6cf1BSRYTTR++UJYpgTXaO3fjLgoUUp/xS92gUJTzt6UWhOHD5gYKKzduWaJxzEEUbev+xPYhPJodPGZgCk8L9d7URKNEgsT/wfA3VLaYtzL9au967yInjQX4zDA7JZPfcKf+cE11zgvfGGR7LnvIBS40NiuIc+Otjr7Pz+3DlH6KZonOU5BQOyT+LWaAa8k/y4WeX698f/U26OC3ejwS56Z5ERsYSWJiqO8ENA/LJ9hIowHBE3p2rETzX4WVyAIzcYcaLX/gSfKv08QVn8sVlxO4I1uWojnRvjpdqof1UcYSpBhQYJidsZg1uAsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvdKxih/8X3u8joXFJPqX3WLTTceds6+rPOfmihwuWE=;
 b=yVIWXuSSqLnoQEn1CHmgCNV8RJzk+qguOdejIoPEY7vfE/YAPrp4KnAIiqI5LLp6L6nn9QiT8Z48XvsLOpBSw/f6e4VtUItETZ2goh9SZA6YZhf6Nu+ekYN7MLwjg6lrN3YgXG6X4zYtGLrdF4Q4J//NLpK34T5/f5gegh2FuckMzUfYeCuse36y0hHOWX2BQf0G1g956HrlnKTFh8RPBHaMqDANUANDCPVSXQz/z/QVPopiSRrk/IFLuqG5fg+NqIkVcBpaP2lcvpgHdkvsWnG9XcZeqEefcyxwOY/woNPaZXrJ0Ps14oXy3fjsE+1NKU4cjJu8RyTxo9nR1FoK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvdKxih/8X3u8joXFJPqX3WLTTceds6+rPOfmihwuWE=;
 b=BU6dMTRCDbCo7apePny6ch6VIYbNHi4tEj0BBrtgNiFfOkNnX72kxZfiUH7bo24JOJVmfL1vi/Yc930+ju6cAknCRVTD1PU4a8twN/TIgaAMzeBvrWXcCUNhVtaAUZysthQsAOxVZ/glgkSZhFXdojSuF3lCECh5ZKbJa+pzRdY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6438.namprd10.prod.outlook.com (2603:10b6:303:218::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Sat, 14 Dec
 2024 17:13:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.008; Sat, 14 Dec 2024
 17:13:32 +0000
Message-ID: <8c716ca1-84f9-4644-95cf-9965e8a30284@oracle.com>
Date: Sat, 14 Dec 2024 12:13:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] libfs: Use d_children list to iterate
 simple_offset directories
From: Chuck Lever <chuck.lever@oracle.com>
To: Hugh Dickens <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
        yangerkun@huaweicloud.com
References: <20241204155257.1110338-1-cel@kernel.org>
 <20241204155257.1110338-6-cel@kernel.org>
 <5eb7bbdb-0928-4c80-bf03-9de27d6f3f89@oracle.com>
Content-Language: en-US
In-Reply-To: <5eb7bbdb-0928-4c80-bf03-9de27d6f3f89@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dba09f4-1f47-435c-bbab-08dd1c62a336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejR6dDJXUHVidkRWU2FwQ3pvUE1XbEtWbkRLbDVOT3MwZ2ZpdlFRWmpYZDRR?=
 =?utf-8?B?TVk1RXFCWFZWam40T0FRejVHS21hTzR2TTl4bnJBMlZLQ24vUTlmbmk3RHJX?=
 =?utf-8?B?RmROTWU1Y25OclZTQ3JmcEh1bXUvRUZ2eU1NTHE5T0xzdmtkbUV6VExLTGRS?=
 =?utf-8?B?NHE2NU1TL3JEbVdDQ1h1VThKQS9LS3ZJdFYxZVRNbEpVNlVhWEZFQW9GMFlW?=
 =?utf-8?B?cnFGRTluUHNEbTA5emxhWnh4akw4L2pVcXZOUFVkUExvdnRzN2RhTzBLdnVr?=
 =?utf-8?B?N3J1ZWNHZUh2dGpaemtydXNieEdON1VqVHYrY0JRakRxRUVlVmMwcFZuaVhs?=
 =?utf-8?B?TFN4VWRvcHhOVFNkSjRzaDloVWtZcE9YWW45N3pYc0ZXa0hJOFR3K0g5MXZL?=
 =?utf-8?B?eCtxYVNDRGdJVHc3OU1vaDJ1dGcwWTg0YjFQd1Q2anF3aWIyZ2cybVcya1cz?=
 =?utf-8?B?WGxocGJDL3E0UXo4V1M1THBNUHJ2ZWp2NHd2N0J1QmU1UWVhMWNscU12ZnBx?=
 =?utf-8?B?OEd4SUo1VUUwTFh0V1hlcHc4ZVpaTE1MMmVjbjd1R0drWE1ycTZkN0VCclQ0?=
 =?utf-8?B?dW04TUpBd0hLOG56T2ZzaTN6WUd5SG5qTzJkaUNlZTh6eGovcDc1ZWFjUXJv?=
 =?utf-8?B?OWwrMENUUHhVemlTRzhCQ1ZDU2loeTVLMkwxbW05V0tPVFA2dkQ4STJlK1Nv?=
 =?utf-8?B?Y2ZPTGF0SnR0aVZOejF2TFhQVWQ4TkNpdWVkRmxTME9yZ1FKZFUxcE50SUUw?=
 =?utf-8?B?VXhyNllneHRaSUNBTUhmanh5cFFLR3B6ZHpKUnhxTURUTjhsRzQzOHRHTHQr?=
 =?utf-8?B?UHUyY0ZlQlltUlg1cHliVnpkbGJjNVZLQjYxcjFzdXpNZ1ZrRHJLOXFlU09Z?=
 =?utf-8?B?YWhaaEY4SW9yYVR5ZWpQaUpUdEJhQ1hxb3RWOXpIaXhDUkVCWnJscDRxQ2Ri?=
 =?utf-8?B?N3hrcmVQNmpRYnpZVmd0U25zM3VWd2pUTFZXWm1wQmQ5SG1jcG5wem5TRFJz?=
 =?utf-8?B?UFZnYVlCVHlyU1RSOVR0SVdrUHFRNXVLanJieE0zZnVPa1huR2lnSjFmbEh0?=
 =?utf-8?B?NXVwZ0xGSytFNGNHRTZqMU52SkJhUGVYalhXRGE2L0F1U2tMVW85Wng1SWlC?=
 =?utf-8?B?UmM5YzV5eGxKMStDejQ4Zk1qbGgrVFUrK09SRFY0VTNTZmltZFlMM1VDemRE?=
 =?utf-8?B?Tkkwb0ltRDBMcFJNOTlmanBqaDVOVEp2OEkrOUp6SkNFT3ovYURpVjNIbytt?=
 =?utf-8?B?cGRHelc1TmVJalBEWmZNcGY4UnVoeVNGdDAzd25TSXl6V2htWVFLK0REOE9D?=
 =?utf-8?B?djd5VTNPeWhLZjRSdTZuQTNZN0tML1UyQ0wyOTYxTTRpTHZiRktzaG1wQVpW?=
 =?utf-8?B?R2N1R0hZQXlka0JZc2hTMXBTTTVLbkxZN1FiWHAxZU5YckVtazVCaWlmUTRs?=
 =?utf-8?B?OEdBV1RxUWhYcy9Kdkt3M0w1OEFzU1Vka2ZQdFEyVFlvWXdIU0lvMTEwbUw4?=
 =?utf-8?B?SWVNZmh0OVNtUFRhdjJSQmFxamYxNVlKTE9QN3hBc3drZWQyNFd6MjF1Tmpy?=
 =?utf-8?B?OUtWaDMzRnQ3eitDTW5kMlJ0aTdqV3hVWXBhOGVINDE2a21FcGZuQWJ2aTVZ?=
 =?utf-8?B?ME9vWUxQMTA5TDkvRm5nRklGZjFQQlZ4L0NsOE1xT2tvRHdwellZMCs0YUZ1?=
 =?utf-8?B?S3B1TG4zWFU3QlhWZHB5OVJhTHptRTJoRU9ocFI5c2JxK0pjS2c2SzU1WkY4?=
 =?utf-8?B?WWZsQmt3S3M2ZWdydkFFaGJDZW5TbklCVmJYcVdUa0xRV1pobDJ3QTU4ejdh?=
 =?utf-8?B?T080c2NBYlZYU1dtNlhvQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm5UcFZ4MzVKWEVqMGxqSkJsc0kwUXh3Y2xVaHN5M2UxK21qNXJndXhuMTJX?=
 =?utf-8?B?Y1ZSUEdzbmUyOXJZSXFQRWVkYVh3VXVnQkVWUERMUGNaZ1dkYW0xdVNkYXdh?=
 =?utf-8?B?aHJGT1hyOWJLamF6cXRGMTdRWm00TEtWc3NvaDNTTHVWTm9RYlh4cDBXN25K?=
 =?utf-8?B?MVdMaTRYaUorLzFoVm8xZW9sQStwK0c2Rmx3Q3hlemk4VTV0L3dyR1VIejV6?=
 =?utf-8?B?RzFjcUFkSXdRbGR2UmxHbTdVVngzdWgzUnFwMmtrY0lmRjlVMFJTK3RCU1Ux?=
 =?utf-8?B?eFdhU1JGa3VLdUt3aktDcXByRFVRbXBIY0YveG8vemFvalBuVmhvQzVIVjhX?=
 =?utf-8?B?UGxDbmtJS0dzb294TWhUZzZ5M3JyMzVMMjdNSzJYYlhGYjNaNDZ4a2NuVDlh?=
 =?utf-8?B?KzkrY0phZUdhUjlXaHVVR1JKY3M4VlB0bmFlMlN1TzQzcjU5Q1NmNFhid2to?=
 =?utf-8?B?NWtVc0grRWhMakdMTnJVSDRPc1VNRHZ4OUl2dm5LeVFuS0xpQkJnL0RqVkFB?=
 =?utf-8?B?aVVzSmZtQm0zc3hmRkZ1dGdIMGFPYjB1QlZxYVgyanBnRjVycFdkRzlDV1Jn?=
 =?utf-8?B?SXhSNGpvd0VKYzZQSktIVDAvUWZFdndaaHhUOXVncFBJMmlIaFdYbVlFTUli?=
 =?utf-8?B?ZW95anhGcWlLcVh2Q2Rka01OWXNZbWxnZERqQWxneDZNRmphY1NkUkVwZ1Ir?=
 =?utf-8?B?bkx1LzlhQWRnWDR1NDZIQTFjdWN5ZWU3SjBOSmdLWG8wYlZEa3c2R2ErV2J6?=
 =?utf-8?B?QlpiMHhQWG0rRW42d1hsMkdNQ2hBOVZJSGpoQitZSDRxREQ4K2ZkcnkycVN2?=
 =?utf-8?B?R1h6NWVTbEc2empMb2VxU3ArTFI3a3Bkd3F3bjArZFRYTFc4cW13Q3lUUG5o?=
 =?utf-8?B?TEg2dHRVKzBVZDlFLzY3YkQ2MXhmUEpUUGVETjVJazR4WnFaYkh0S0xlbnFF?=
 =?utf-8?B?UmxEblJKZnYvUlVzSjltcW5FZGFwYnpyK3hvSi92dWhkK2g3bjl4UDdDS2pJ?=
 =?utf-8?B?TFc3bjdqK0lNYlhyY09FWE9iN2Z5VU9FSUFreEdTWlVxbHpiZVQ5empJODM2?=
 =?utf-8?B?Qk1FMjg5Q0xZY014RjhXeHdRMUkvWmI2WllsQjBzYzBxdnlyQ2dGNG1JMlJZ?=
 =?utf-8?B?bXZ4eXEyYnRSVitzeDdzYWMzdHlTR0d4ZVhaZGxZMk1kaDJWVkI1R0FSMkZw?=
 =?utf-8?B?YnFyMjFrcVZZTGp0NWhTWFpVVXVkQzl0U3pLYWx2RTZicDJBR2pabUlpMi9I?=
 =?utf-8?B?akV2QnVBWndTZTZLYmNSQnM0ZE84RkJiRm5HQW94emRoRlMxb2gzMndrMjhx?=
 =?utf-8?B?dEN0dk1KRVBZZXp6a1pMV1ptd0JQK29MZnF2MjBRQUdlZHl6WWZDQ0FrRGNs?=
 =?utf-8?B?S0k5dWRkVkxFSndzOXJ0Skd4Z0Z5cFlLZDJ0UWlEdmNMWFlIb0RoRTFmU2oz?=
 =?utf-8?B?NDVnVzcxSUlDYmNDUVZYNWNmQTNQL3grak9xbG4rQnBZQUsrVGpGUnBBNlhz?=
 =?utf-8?B?ZFpQRlJxMnZMMGFLU2FHSFFXckQybDhvR1pRRnh5bGRXdnYyRk1IWGZvVmxl?=
 =?utf-8?B?U21OdGdjZUowVUZ3b2R3NUdrcnRYV1JpaGpBdlRvanlkNU5oUnBnWStCTk5p?=
 =?utf-8?B?TThmaHYzZkJ2MDNnampIMzl6eS8xTks3YW0wbkJqQ0hJcTdua0p4L3pSTUtu?=
 =?utf-8?B?QithS3RJMjhCdnpBS3MwVlZ2S1kvTCtoQ0o1cGE0SS9mSVhwMUo0czA4Rmpx?=
 =?utf-8?B?c0Rab01NdmNSMUZRL2Q4Zno5SEs0RjVSQnUvdjNpcWdHVm5YREZ0Z0xmNkY4?=
 =?utf-8?B?amlpMnd5TW5WbkpHeDg1MXBoV3Rqd1JkbW9SQU9VRXM4SWNvdDM0YXR0cERN?=
 =?utf-8?B?ZWorbzFiUG9YRWR1UzhEV1cvVEVDazE5b0hzN3MvVWxPK1NqWTVtTko1TkZM?=
 =?utf-8?B?SUVFZ2dzV3dtUmZRelNQbzJKTVJxdEJzOU9IVWtCNFJyV2w2bzZtalU4Yk9H?=
 =?utf-8?B?UDdPL0hhbEdqNitlcXBmemNLcmN1ZnpDeUtKT2RidUxLbytWZExsMXhEQk1a?=
 =?utf-8?B?eG9Fa2NwblJGZzhHeDFBZXEvNjZ0czV3Z2M3Wjd0WUcrOEVsV1VLYVpQcnVT?=
 =?utf-8?B?RnhxRy9Wcmp3VGpiMGRoOFd1aDRKblNjZFJBTlFVV0RyYW9mMkUyL0dKNkky?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wZZyPPeZFsG4WpL8Sz+uFoKda82hevFISO4n26D73Tt0wu00XfqOGjTsinHGNSRjV07a+fZ3vbht5FEXSXEErzg7jcS+byjbjT7swmaKdKs+N8dRhNYLSrybzbCkokngsv6j5QMVUhfnn/K6TUIXc5Ym9v3n7UbHHPpvDJKkuOXff4wmRJe9o8mXCpJDBZ5YslIaVeG1PSNZsiYZJLd7QApMg5oRr7Go3IQY7twwF/Z5smW4dbOcP9G/p5/rxU+aegI7E1+GqQv20ulT8w6JykXLsD1mnpG87mQPI6wwB7ZpqiUiUZG1jlftd1DBpzRJb7T8bwQpsqhs6kshUiqQRqTfyg6sW/oUpU3RYYT9Iva6M6pb/JcfLEO3OtAIbgKNrWvf425JQX6q7IanSLuyln+VY9+jiYuSVXxhu0nLpBkBf/EkcYi8pyyU/1W9kqLp0CrU5vea+nkGNXtzX8JI/UxdN2DiNIe0/oYpS6Zw6NVn3aYm8dwnCI88+mhEV38mJyMZLJ9kLkgGIBrqCL8p0WWf4gQuAL6T/Ihg4TkIacitAph1f2Xilh81hBX5SFbAWAhnH7R9Tqw8XbFrCkyQ4xUKu5xK6xvNLW84xLXFMoU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dba09f4-1f47-435c-bbab-08dd1c62a336
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 17:13:32.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5gDLM507RfuVnXa1UptByuJxJYsxbXBZfkxTboEYzCPtfChUpRCq9oz3mXVy3ECqZT28eYQvfbz3NPOVQ/KSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_07,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412140142
X-Proofpoint-GUID: haesIuJyBc_w8Wdn3fFUHEJDkVNhSkfO
X-Proofpoint-ORIG-GUID: haesIuJyBc_w8Wdn3fFUHEJDkVNhSkfO

On 12/8/24 12:11 PM, Chuck Lever wrote:
> On 12/4/24 10:52 AM, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The mtree mechanism has been effective at creating directory offsets
>> that are stable over multiple opendir instances. However, it has not
>> been able to handle the subtleties of renames that are concurrent
>> with readdir.
>>
>> Instead of using the mtree to emit entries in the order of their
>> offset values, use it only to map incoming ctx->pos to a starting
>> entry. Then use the directory's d_children list, which is already
>> maintained properly by the dcache, to find the next child to emit.
>>
>> One of the sneaky things about this is that when the mtree-allocated
>> offset value wraps (which is very rare), looking up ctx->pos++ is
>> not going to find the next entry; it will return NULL. Instead, by
>> following the d_children list, the offset values can appear in any
>> order but all of the entries in the directory will be visited
>> eventually.
>>
>> Note also that the readdir() is guaranteed to reach the tail of this
>> list. Entries are added only at the head of d_children, and readdir
>> walks from its current position in that list towards its tail.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/libfs.c | 77 ++++++++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 57 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index fcb2cdf6e3f3..398eac385094 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -243,12 +243,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
>>   /* simple_offset_add() allocation range */
>>   enum {
>> -    DIR_OFFSET_MIN        = 2,
>> +    DIR_OFFSET_MIN        = 3,
>>       DIR_OFFSET_MAX        = LONG_MAX - 1,
>>   };
>>   /* simple_offset_add() never assigns these to a dentry */
>>   enum {
>> +    DIR_OFFSET_FIRST    = 2,        /* Find first real entry */
>>       DIR_OFFSET_EOD        = LONG_MAX,    /* Marks EOD */
>>   };
>> @@ -456,19 +457,43 @@ static loff_t offset_dir_llseek(struct file 
>> *file, loff_t offset, int whence)
>>       return vfs_setpos(file, offset, LONG_MAX);
>>   }
>> -static struct dentry *offset_find_next(struct offset_ctx *octx, 
>> loff_t offset)
>> +/* Cf. find_next_child() */
>> +static struct dentry *find_next_sibling_locked(struct dentry *parent,
>> +                           struct dentry *dentry)
> 
> There might be a better name for this function.
> 
> It looks a lot like find_next_child(), but it acts more like
> scan_positives(). It starts looking for positive dentries starting
> at @dentry, thus it can return the dentry that was passed in @dentry.
> 
> find_positive_from_locked()  ??
> 
> 
>>   {
>> -    MA_STATE(mas, &octx->mt, offset, offset);
>> +    struct dentry *found = NULL;
>> +
>> +    hlist_for_each_entry_from(dentry, d_sib) {
>> +        if (!simple_positive(dentry))
>> +            continue;
>> +        spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
>> +        if (simple_positive(dentry))
>> +            found = dget_dlock(dentry);
>> +        spin_unlock(&dentry->d_lock);
>> +        if (likely(found))
>> +            break;
>> +    }
>> +    return found;
>> +}
>> +
>> +static noinline_for_stack struct dentry *
>> +offset_dir_lookup(struct file *file, loff_t offset)
>> +{
>> +    struct dentry *parent = file->f_path.dentry;
>>       struct dentry *child, *found = NULL;
>> +    struct inode *inode = d_inode(parent);
>> +    struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>> +
>> +    MA_STATE(mas, &octx->mt, offset, offset);
>>       rcu_read_lock();
>>       child = mas_find(&mas, DIR_OFFSET_MAX);
>>       if (!child)
>>           goto out;
>> -    spin_lock(&child->d_lock);
>> -    if (simple_positive(child))
>> -        found = dget_dlock(child);
>> -    spin_unlock(&child->d_lock);
>> +
>> +    spin_lock(&parent->d_lock);
>> +    found = find_next_sibling_locked(parent, child);
>> +    spin_unlock(&parent->d_lock);
>>   out:
>>       rcu_read_unlock();
>>       return found;
>> @@ -477,30 +502,42 @@ static struct dentry *offset_find_next(struct 
>> offset_ctx *octx, loff_t offset)
>>   static bool offset_dir_emit(struct dir_context *ctx, struct dentry 
>> *dentry)
>>   {
>>       struct inode *inode = d_inode(dentry);
>> -    long offset = dentry2offset(dentry);
>> -    return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, 
>> offset,
>> -              inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>> +    return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
>> +            inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>   }
>> -static void offset_iterate_dir(struct inode *inode, struct 
>> dir_context *ctx)
>> +static void offset_iterate_dir(struct file *file, struct dir_context 
>> *ctx)
>>   {
>> -    struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>> +    struct dentry *dir = file->f_path.dentry;
>>       struct dentry *dentry;
>> +    if (ctx->pos == DIR_OFFSET_FIRST) {
>> +        spin_lock(&dir->d_lock);
>> +        dentry = find_next_sibling_locked(dir, d_first_child(dir));
>> +        spin_unlock(&dir->d_lock);
>> +    } else
>> +        dentry = offset_dir_lookup(file, ctx->pos);
>> +    if (!dentry)
>> +        goto out_eod;
>> +
>>       while (true) {
>> -        dentry = offset_find_next(octx, ctx->pos);
>> -        if (!dentry)
>> -            goto out_eod;
>> +        struct dentry *next;
>> -        if (!offset_dir_emit(ctx, dentry)) {
>> -            dput(dentry);
>> +        ctx->pos = dentry2offset(dentry);
>> +        if (!offset_dir_emit(ctx, dentry))
>>               break;
>> -        }
>> -        ctx->pos = dentry2offset(dentry) + 1;
>> +        spin_lock(&dir->d_lock);
>> +        next = find_next_sibling_locked(dir, d_next_sibling(dentry));
>> +        spin_unlock(&dir->d_lock);

Recent coverity report:

*** CID 1602474:  Concurrent data access violations  (ATOMICITY)
/fs/libfs.c: 536 in offset_iterate_dir()
530
531     		ctx->pos = dentry2offset(dentry);
532     		if (!offset_dir_emit(ctx, dentry))
533     			break;
534
535     		spin_lock(&dir->d_lock);
 >>>     CID 1602474:  Concurrent data access violations  (ATOMICITY)
 >>>     Using an unreliable value of "dentry" inside the second locked 
section. If the data that "dentry" depends on was changed by another 
thread, this use might be incorrect.
536     		next = find_next_sibling_locked(dir, d_next_sibling(dentry));
537     		spin_unlock(&dir->d_lock);
538     		dput(dentry);
539
540     		if (!next)
541     			goto out_eod;

As far as I can tell, @dentry's list fields, which are the only fields
accessed in find_next_sibling_locked(), are protected by dir->d_lock. We
don't care about the other fields.

Not sure if this is a false positive. Is there an annotation that will
help clarify this situation?


>>           dput(dentry);
>> +
>> +        if (!next)
>> +            goto out_eod;
>> +        dentry = next;
>>       }
>> +    dput(dentry);
>>       return;
>>   out_eod:
>> @@ -539,7 +576,7 @@ static int offset_readdir(struct file *file, 
>> struct dir_context *ctx)
>>       if (!dir_emit_dots(file, ctx))
>>           return 0;
>>       if (ctx->pos != DIR_OFFSET_EOD)
>> -        offset_iterate_dir(d_inode(dir), ctx);
>> +        offset_iterate_dir(file, ctx);
>>       return 0;
>>   }
> 
> 


-- 
Chuck Lever

