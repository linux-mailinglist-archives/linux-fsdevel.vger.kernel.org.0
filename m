Return-Path: <linux-fsdevel+bounces-44297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E19A66ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32E1188CB01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6DC2063C5;
	Tue, 18 Mar 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fVrUfsyx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="prWx/qe7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FBF20297C;
	Tue, 18 Mar 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287489; cv=fail; b=N9lL3iBDhuC88viZ+uC+AIK1P6YZsDj1wzh3njJ/ow9AtxnZw8eFOjYA8SrXSQ3gUsi7vWqZ87KJqUK5839L1Bedp6Lsr+baCIpc/aEAfk28j80AMg2wR8DhN5GRlcs+FhsHhffDTI+CBCMxOY7zf9J7qVJS0P3U1+7phG9faug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287489; c=relaxed/simple;
	bh=LtC0pP0Juy6wkhEsnKAPBOEg3NLzYRf6rlFMoTCY71U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=grkT5BPMLOWR2AK4J9UdzUrlMecm+ld62q0Fe2cq6ISQRFAAFKABtPnZkEcbfw82uucHhoJcFPhWYUUxkl0GB3M0Y6eT3wdoz/IKkJBiP67+JkSfY3kt2hoB8e2Pz9b2Y2T6ykqac+dL0wTzJp/Sw0tP6oNtELRs+XUuq1b8iBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fVrUfsyx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=prWx/qe7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7tkdR025098;
	Tue, 18 Mar 2025 08:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=J74RH7Lsf/IMxOEyVqmkEuAp8HCQYqMiBcZqfmhRqrc=; b=
	fVrUfsyxFbo3DVC5WXTUXyZFual7ZGfF7XHU/lZZPZvutZ8M6gpc2AhH9sbqIHsQ
	Xe7tWp8SB/gDn8I/9Z0MBL/HVHUgEP+M+SsN4aFcVVHxyfHQATpEZJMtuZBvjUJK
	3a9UkE0Wy9bjJahpVHxIudBKG2oKr8HIYJE6a3NO9zl5YAcw4ZjkZVZnMhqkeefR
	fHBwFKtZ2FM9FJtacqGwtgLNYlyH98gsTpHTSi8e3a3ISZQ4I8c+BxbwonfAy87B
	tB8XIxwhP/szGAvLLFKC18QGSBaKCJGHAkYHpFt44mBUwFIKLl7mCIyvkEZeI+kB
	ha9AvMClDEgoDZApLtVo1Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hfvp30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:44:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I8eMnh019469;
	Tue, 18 Mar 2025 08:44:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdjsjtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYDWczYfJVBVRaA2iQElF4APTF6AmhYA5cyw+TbAQbNM3AMTB0Maejyth98yiNJYaSY0p+WxTHqQJ1hTmBS2Ho8PZfkbT45ynFv1HeZKDZvoqUprv/I4uvopQXa/yNdfG9L++i/8bHs+t66IFEVpTYNBchPBv/tQLtig1JjLf8RBT5zOY3nCEEmT/1Y1N4tEQGkfDSQEN6/RmvOxLoYU37mRTdIGc0/u4HBFAUErhl2t0N1+gz+1l4w9JDpXxppzYLs4TCrMpuhTMCHK63Kzt0ZNd2TQHH2EHMHXhLhycjOnQPDyA7HKNVGptl9zPYJk1Vq8wd6vQRChXAYLL/+sIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J74RH7Lsf/IMxOEyVqmkEuAp8HCQYqMiBcZqfmhRqrc=;
 b=vc8YBsIiwf70AIZmLLEHBVmELDwR8b2B1UQc9Hy5TSMF7PsB+z8NBNNUwxR+kEBHAhzo3uaPVGd63NeRdNQeo4OmuXh8maufb+sfG49otIS8lSCGKtQgdlia79iTOF25TMJmBW3nQmsEvlROecEBVrgoHKS9jMikreIRTn6Xu9Yu2nq/zPyMoLOqFvDFO1WNKJXD7CZRUvTcd2JVtsGvgwZYPJgWU5D1KhaIQ79eZ6yTQ7imE+KIQOEam866gFTv2j+Su0oNj3wLeDdqPkd4Gh7Xx6ikF9MrTJpqoRYIQaD22nFtPPkgioFFMJ/MuHwgtfsy6WdurL0++rLo0trtew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J74RH7Lsf/IMxOEyVqmkEuAp8HCQYqMiBcZqfmhRqrc=;
 b=prWx/qe7xjcjzvAFlw4cpk9m9uLmulZCKPCy9yUnXwR/V2H3vBRa9EtlG3Rl8AaiNQ52kGEIJtM3hY34Q3BeXr+usjy61YyaJoyggRuq+xmM7R7g32Sac6Jwg5DaFDv+4nCkf+vSTpdKyKH4yj4G7fmxuvxocngUOh3q5hot95g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7191.namprd10.prod.outlook.com (2603:10b6:8:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:44:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:44:30 +0000
Message-ID: <86a64256-497a-453b-bbba-a5ac6b4cb056@oracle.com>
Date: Tue, 18 Mar 2025 08:44:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] large atomic writes for xfs with CoW
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250318054810.GA14955@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250318054810.GA14955@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: ae45c410-bee9-4547-4c20-08dd65f91974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnZ1dW12WUhKSmpCbU9uMm90NjZHRnM4djFHNDZXams3YzEvbDRKZGg1TFlP?=
 =?utf-8?B?QWR3N0h4eHFlcnVRU3pFLzRpcEx5V2V3bFAzcVViMWVjUGdWQ1pOR282R1Fv?=
 =?utf-8?B?ZzdjUDhtanZLVFQzVjdsNVF6OWUvSXlxb3k1T0N4dW5uUFJwY3drK1VwR29X?=
 =?utf-8?B?YUNDQ3Z6SDNJN1hXSkFTTWZyWGI2cnVzZk9DVUZ1ZU9aNHNPQjh5SUJaMURI?=
 =?utf-8?B?T08xQnZTbUlGUG8wbXNDRGFuTmJ3ejQrQVJzcnQvZUFsUEdsYnZQbk9vN2hY?=
 =?utf-8?B?dVAwYnNsOWxURUh0ZEl0dnhOa0NzbFFqRm5kTXpGZ3BxaWE0VHRxY2V4RmI4?=
 =?utf-8?B?Mit0MlJSaXU2NUhKOVhZYkl3dFN5RE9CQTNRZDNlTTZFS2ZyZS84bFY2QUZ1?=
 =?utf-8?B?TVc5clBsNmJJUWdxSjVFOWZyQkQ0alhLKzlPK25ySEdvcVo3ZjhKdmlmckVN?=
 =?utf-8?B?NjVzckdiSnA4Y0FDZzRHQ2JvbEh0dHZMeFNvZm5vcUl4My9FYWJhWFkrcC9E?=
 =?utf-8?B?ZHBzb0taeVRkSGxqdW5yWFFGN0E3SFE1Zjl3ZnN6d3ZOTUFVbHlYRFBDVFFy?=
 =?utf-8?B?d05oSmY2T1JFTUkwd1c2YkhwNWJCZHJlcVBzMTZ5Ym1RTkdrZjdvQ0V0dU9x?=
 =?utf-8?B?c1JhbmlsdnlVV3pWRlFya3lTU1VXODFESkh1Uld3dGNFMXNOTEtXdWY5OVU4?=
 =?utf-8?B?YzI5WXc3bzBsQmxQUGswV1Z1Ky9XNHdCcnBxN2ZwQmprbmZhdnRBQmVrQ1Yx?=
 =?utf-8?B?ZFduNE4vYUdlZENqSzgxZURzOG9aWDFkd1NKTTlGeURPZ1NSdUhKMFlYaTdx?=
 =?utf-8?B?VTZkWVBGQlE2U3MxUHJ3RDFPeDJMZXhXc2F2M2JvOFphM085K2ovVVRFVTNV?=
 =?utf-8?B?eUkvK2lSWWxOVzRUSFBYZVUwQTRxeXFTY3g4MThyRHI3ZmhsOUh4V1Ixd0lu?=
 =?utf-8?B?akh4RUZ4eE5oRHk1MDJmcWRyWjkvUVFPNHZkM201SG9QWldrQm4vK3BlbVpB?=
 =?utf-8?B?ZWJ2dGhJN2dvVzhqMjNDV3k2NWZhWGo3ak9jN2M1YW10THpYM09DTUFwM3Fx?=
 =?utf-8?B?aGpDTmJHQzV0UU91YXNzVGxFTWhvbnRLT1o2S0srZDdYZk1jNENwdHorMWhT?=
 =?utf-8?B?czh6SVNUM09UYzRUYjdBYVo2cng0K0Vna3NicEtqelhTa24zck0vRWY4OHNZ?=
 =?utf-8?B?cnJVMnE0cXJueUVhQ0YzYzltaHUzcEpNb21KTm9pK2RvRGYwTDlBcDJhWWFN?=
 =?utf-8?B?YWFySTRHQlFUMVd6cFh5dFJRR05RMDNFZTdQN2lFZnVSajRwbFVPWXp6R1Y5?=
 =?utf-8?B?MEwraWUvc1RVRVJjTzZibjVNWXE2di9tRW1TSUJQTEdSTGY1d3E5NFlxTXNx?=
 =?utf-8?B?Ni9OMkEzWXJpN1dYMGU0UXFhWDZobVQyN1UrYVdHQlU0a3JTSWQwcEtLTzZn?=
 =?utf-8?B?bjJEWFQ1bmYvYTdqdDFGV3JYUnJpYThKVDU0dDk0c1JnOHNQdnZxVVJKZlUr?=
 =?utf-8?B?bFdyUXRRaFZpTW14Z3ZpKzgzQlcvQWJyTkx6MVNsQlo5SU5xTzdMM3FEaTdJ?=
 =?utf-8?B?OFFzaTh0YTFQcUlnbmsrTmtuKzdTS24vVWxUU2Mzay8ycEtyRXpWYUl3Qi9k?=
 =?utf-8?B?QWdwMHVxK2Rhd2dGRnVBZkdib0R4Nys5bno3dWNZQnp3NmZTVStiblJwV2Fz?=
 =?utf-8?B?Si9OR1hDNnRRRThSVmZEbWRDam9nbThKNTg0WHRoMEJoMFl3c0tTZmI1NDZH?=
 =?utf-8?B?WnBTVHlic0ttRklzQ1IrNi9FRkhvTDZSL0tRY2x3Qnlvd1Bscm1SNm1veTFE?=
 =?utf-8?B?YlFuTkU5NjJTd0NjWWpDRk1OdG9PdmlSQXBadmh1eGhSQnNJTENreUlQUE9w?=
 =?utf-8?Q?K9zIsYtonZq3t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3g5RjJEMmJvNzdRaDZGK1ZwVmxiZnpjL3ZZRFRYSTgyL0YxNldyR2VVaVFW?=
 =?utf-8?B?bmQ2V2FlSzFraVFOd1JuYXNrTGVNdnByd3hTRGIwaXRaMGtvVHNVVWYrdkli?=
 =?utf-8?B?UzFPQzNjZnJwL2pUcjdDUHVNbWxobE1hTEJQcTVTcm9SR1k4bVpaZzNUd2VZ?=
 =?utf-8?B?clJQaXZXOENqN0t2byttVm1EUFFPQUpPdnY1U0oxRHZONTF4SElYOW9XbXZ6?=
 =?utf-8?B?VVpjRGdDUDEwamJkSVZUVm5abzdlajJNdEhrcUE1YmJMZEFTMVpjMkpsN2JR?=
 =?utf-8?B?eVhqSGpUUFpleHZDd3ZEN2tldlE0V2JuR2ROOU5GeVNKRWZkck9XTjkyY0VQ?=
 =?utf-8?B?akFRdTk0MjVnNXc2SExCenY4V25hT1Qra2tOVWpab1E2K2ZobDhFM1ZUWGtZ?=
 =?utf-8?B?M0VWZU5KeGlucE9RdWYrSXFnMGVNSUVPMWhjdko5VnZJcFVUZkF0ZXNQWCta?=
 =?utf-8?B?U1oyRXNTSW04bUJxSFpPN0psNE1FMWZic24wcll3SkhDdGQyZEh1ditLVXlr?=
 =?utf-8?B?ZnIrWkxtWU9nOGRYZmM4TFIwY0haMEFDdnl2RjF6MnlscURWVUpXdE9lY1d5?=
 =?utf-8?B?S3l4Y1VOMUNrQjJFOUF6aGZ5LzZ4VXVpdlNadlBOaGZkQVRmeklSa013QVpC?=
 =?utf-8?B?cnliVzVEQ1NuaEIyaVppRzJJblB3SzhqaTJZNDhwS2lEeXdaZ241NUp2d3lo?=
 =?utf-8?B?ek53cU1IRnJiWEdCbFhMbFg0azk2MXQzRHR5MWt4QWtPWWg3VE9PeHlXM0Fx?=
 =?utf-8?B?WTRyRjFyMWt6VmlTdG5qZFRpb3NpRGpWZUl4NXR1SnVhMXJsSWxjTFpJRkVK?=
 =?utf-8?B?OEFNTFFqL25qbHpsMmtWMndSY2l2clBseXJxUWZNamlOYWtaQ0pveWZjd050?=
 =?utf-8?B?K0dWaTBVVFNSWXVpSk9uN0RFK1hvWWVJRW5MaDRwNmZ0TXptSVdtMVlJN2hL?=
 =?utf-8?B?dnJ5QjJXS1BSRk5JT0R3WmpyM0l6NXdBODQ5SmlKZngxY3JNRVhmbUVzNUFQ?=
 =?utf-8?B?TDBUNFVhLzFyaXZ6YXlKNHVSOVpsUFQ5ZysvclpXYklKUGtHRks3L2hzM0w1?=
 =?utf-8?B?QVZEckJHRHQxbThWNGhYSjNTaEZ1cWc2TTA5ZXQyK3RDQWNzVERJTmh4ZFpx?=
 =?utf-8?B?RytSR1J5OEhrRUFuQmxKOVhNS1RZY0VKWk1RYlFveVlqMHJMNXJaYVdlaDRs?=
 =?utf-8?B?QW9MWStpWWRjbmxKb2Y3cno5dHpXeElzV2RFQXMyYTZ1QTNPNTdUQmFwazBt?=
 =?utf-8?B?ZXZYbmQ3dGFzMTQrdGtvM25lM2tTWWVqTG0yeUxIMlgva3ZHdE1sZWZ6bHhJ?=
 =?utf-8?B?Q1hBZHJIc0lRVktTQno3Zlh4WGl1cnVnVzRqaFhQRkNaYkZxa1Z6ZmZzbFN3?=
 =?utf-8?B?anpPOFVpcXpVY0xDczlDQ0RsSW5SQlBDZmk1UldaY2Rna0UzaS9lczg0UGda?=
 =?utf-8?B?VXF1dDVheDN2Z1g3VmtBNnRwK0JwS0dralVFQ21zeWl6QlVNUmMycE9UTmNs?=
 =?utf-8?B?RzcwN2EvSTAzZzRaaEhBTTJRWDhLbnFpcVB6OGlxWTVITUhqRlozUHh4cGNp?=
 =?utf-8?B?Y2M5Uko4enpWUGlMMnUvTjhGV1A4RnVvdG1NdlQ2S3Nza3ZGaXBRWFhjczRP?=
 =?utf-8?B?QUpRMGRlVnEwenNTTW1UR0gyWloyZWFEYjIyRHcraDZuQ0FKU0xEbUlRME00?=
 =?utf-8?B?WjhHZzhaNklpVUQxYkN3RWQ3ZzF3RFJWR0tHdGNjT2VhdlhscnJDNUZ4ZEZq?=
 =?utf-8?B?c1pEV0VxcGJNNEZzbm4vV1A4cnFxbE4wM1hQcGE0R3QvQ1hBQTNQbjIremlI?=
 =?utf-8?B?eVVybFN0MWZWYnlLMUNGOEthZ2x1QWFCcEk2RnFBYVhybXBqKzE2TjVOQ2x2?=
 =?utf-8?B?bGlzZDNYem9CeHpLWjJqMVYyOWM2UTVlYnVMaDk1WXc3QmYwandsb2dyZm9D?=
 =?utf-8?B?Z3pTbzVONVdmcmxlSkF0MnF2ZHdTbEJkeEhiMllVd1VqZVJTeGpJc0l6UjJP?=
 =?utf-8?B?ZlRRUHloM0lOL0F3Vjl5UWcrMjJRbjlZcm9ZVDlDajVGNGpTY2RLSkRqWUo1?=
 =?utf-8?B?WXFPS0M5RUx2RXhDTU1wTmxXc0ROSG5pNFM3VVNtaTE3T096Tm9tMURpbkpl?=
 =?utf-8?B?eUFMZ29zZUpYUmgyWFVndDIxTzRPRExzOFJ4NjRXU3hLTjlja241MkVxTmVN?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dQ/qgcs/XYlfP1hUyARY4A46HiJbzFB05wsBa9mFyUOG9Z6GC7rxPLKwGP0M2aWehZpqOfDVMqkXJ1pxJIXFdOxm0mOP4wRvlnXKaiiqflD46KFtk6EOZYFLt/+l6W6nd3r4VVKdqVE2bj4YwNd/Lt7/6rFlH9aU+kfVFlsCh+QoaHYA2VIAC39fc8tC7Ff8n521ZEK5ic6oR0UfaFyD8P1ta5l5umHElZTpdU1N/MTz0O/5e69p6YM1pKqx1ARKGB252BCFhYBGcUw+XPbWp1zVtw+APy8FzmgHdxCgH08Ah/m1ctThNDb8ixana8PtWpXdrPYf3RWxpTQBJOOeLY2M/KZ4ZeIlPS4YJ3gywzG07dEE5ZH40815sLKq4TjIawnHrUyk7dSD/IKK+upK2e3617Q+7s5dHdlMJ1cPXykNP+F+je0CeM5ELgn+AYoQ9q3F5HpokJGgyY3rfs7sb1aYZtA7zL5NV6Kb1ocoQx1f7B+ebmAyaVmMjqE29eLuL3L2BLa/1J+Xa3Sz4X1+AtZ/njCkhcCRS9aTijsXfBQD8bVk2+Rn/gnK39rh1pv6Z5AeGWTNIpi57lJoagiPc6NONw8xHt3XVMi8KAzQIe8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae45c410-bee9-4547-4c20-08dd65f91974
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:44:30.7256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Wp8ykMbg+35yjCWOpdjC7mMhJ5AvPLheA4cS2gXz+lvv0/MZ5qwml8GqDwdKOoWqIn1kXQIig1yhh6qz+I2Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=974 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503180062
X-Proofpoint-GUID: cQPT6sa55Y4I3HGxUUf436zoERulDM2G
X-Proofpoint-ORIG-GUID: cQPT6sa55Y4I3HGxUUf436zoERulDM2G

On 18/03/2025 05:48, Christoph Hellwig wrote:
> As said before what I'd really like to see going along with this is
> a good set of test for xfstests, including exercising the worst case
> of the atomic always COW writes.
> 

ok, fine. We already had something for the forcealign stuff, so can 
rework that.

Thanks

