Return-Path: <linux-fsdevel+bounces-49219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0099AB982C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B995C4E4838
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D522E402;
	Fri, 16 May 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2sc+Xe3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vK0I8TnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3422DA1B;
	Fri, 16 May 2025 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385731; cv=fail; b=XrNpWzSzzvTGWeL995gPxbfUMPiDYz+vp9NMCNktDZdgWJejBuKw//rUVro2rHwLpQ9uPHSnqcFutU2EWWpR8Nj7pk68/Qm51YWhqOjssf2hIVlNlCyGKELBo7BY9GqNIhFxuyTpw2rwL+LhVIlJ6upPvKzVXApcwL5QPn8j/e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385731; c=relaxed/simple;
	bh=siEEddlYFUCyBE/swyF7kSor+EV7+/lYjjmyCuODjmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AvEr8z+P+FTL+UShA95I2Yek60V/NR4UiuoQBP35bMopzjSn1/CtygxCXCv9IqjdKY1Hbp43a59XLSflYHasTlyiBcljxLPRh5fNgHr7sceOi6+PTLCfmfEpstltQ98ZyaMv3HZdKlXJOfZUweSxzW5cyyr+CBLobrjIs1rOYCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W2sc+Xe3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vK0I8TnT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G6tvfm011840;
	Fri, 16 May 2025 08:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/Qv+S9oG8PtEXM2roQX2nJcZWdqKAPr+bASRR3Yix1g=; b=
	W2sc+Xe3SjT6s13srQEyKzbbHUKMjZUkwtmPXTHnAO8Ta9c/mErzwIg6DZlfzfFf
	lFscG+tw8QXvakjzOU29aB7/a3WZdYnzSu6XKwFbFbK3sCvtxcBNVAINnWTZBK05
	+QVY3+FKxZVRyU8Kb7lijHVWvZrqK3NxI4FmXdrR2trGJkMlQYkS0SkLk7KU2LOH
	5Yy5o1HiGGXgnpMs20C9Gc1ctKnMU7bS54Acg7vWGnPYiBYK0XmWcwwdBGUxw9BS
	+Ka5oopgWtGNMG/G/rBtiWDc3W2uYeSd9PDUsd5UCuSJVAVviBj1sgn5IY6XGP49
	YVF40hPCqxk1YAnOqHk4Cw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nre00y8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 08:55:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54G7GajY004559;
	Fri, 16 May 2025 08:55:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mshmk1ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 08:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bnt6mfzLn6aOes9vhTfTzH7DWcYw1e/TgcrsLcOvcA0jcsnrQm2DrTZdV7bvHix8hhwiJh43oRgqhateE+392pyCPXnHhTFsl2NtaaXdej69Aa4fvMltO8MFZrrHQ05xODWEdX333vClbzEJD9npXBYzjnpFjtpXhuwkeICTuFxhkA25UYDv3WxqhoRd23v6KfIAOiLvIQMqEnXy8aM/AuqMxK5k79h/X4z6xgdP3A3ljIOCDFEUrxiJ+LnUNjRW8GhLD5Aeg13SJbQeh6NjYvv/OcYsV/uK+VwydKejmoOYeXdc5TdZf98U68yQvd8aWLi8YtJs0v6Hj5xQ2XbStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Qv+S9oG8PtEXM2roQX2nJcZWdqKAPr+bASRR3Yix1g=;
 b=H6adqIOk6bVuPopuJdgBkt73+M9TawIHitttVo1HU4UVOF2vJ2jJ+OsiEdLR4bwB+2SSaVjAOKRPr5nP6/UxZxGhtN/ELAQmFGzOE5TGbsXjNKzhK2Cw3Qdtjxf1vTixdNQuF+lML3JKjdY2LXW+dyqvTzK9qMZjbdSS+8Haxcifjad4d172d54aJ29EgWskiVObqCQGYeuWcnmwAocuIj/O7f7ZvCcchBnnUJm1NVI6bpoZsFQ1FqsomRdOpgkcU3R57uebNxE3rYaXeXeD7ZHD9wLj2A/iUwTPGZjLRfUrug5ZHZj5/WMGdgDfwrtyJKnbUVzX8JJjEG7TLCuBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Qv+S9oG8PtEXM2roQX2nJcZWdqKAPr+bASRR3Yix1g=;
 b=vK0I8TnTdz+pqJEZPqTmHhcxjcVkhAgB7NZlAbRvFztI2M48+ZrSKYYI1Xrj9eTR3twg27Nu+Msw4aSPt7i7I3x6W61GPyVGkfWbSBKnxdFDLpuhLpACc37aO+fxHk5wNlN0DekZXob8GyPrUx5dSVqaUEca3sqqsz83PYd3wrY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5137.namprd10.prod.outlook.com (2603:10b6:208:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 08:55:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 08:55:17 +0000
Message-ID: <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>
Date: Fri, 16 May 2025 09:55:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] ext4: Add atomic block write documentation
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, djwong@kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
References: <cover.1747337952.git.ritesh.list@gmail.com>
 <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 146bf3c5-86f7-400c-d1ef-08dd94576146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjdwMnFnZUNWN2xGN3BFOXlNNEtZZUV1Um1qdTJrZi9jNTZqUjJ0b1RWNVB6?=
 =?utf-8?B?MS83YVpjbHRHeTJlTHVGeldaa0FlemNQdGpwLzRqMGpDdXRCMnVrc2NvWGQ4?=
 =?utf-8?B?VUx2STY0VDNzekhkUW9oSHpDWk1nZS9Gc0FqT01HRkhZa1FXNmdYaG5lNjJR?=
 =?utf-8?B?M0UvVVhWM3hNT28yOUpQNHFzMTREbmQ2QWg3cDVyUlg2ZW5mRFJhbXkvdkV2?=
 =?utf-8?B?ZmRDcVZjVmlyUmpkSDk0Z29YQnUrQ3RzTTlvRVlOYUpXbTFmZHBzWmxFWllp?=
 =?utf-8?B?SmxrTmVsNEdMeE15bS9HNzVFcjhFL1RlQW96dnpGZVJwdWJncFp3WjdOV2ZL?=
 =?utf-8?B?THUrd3pzYnh2dHdRWXNReVJleDlScWk5aVN5emRNOEtwaDJ4SnZLZFcvZm1m?=
 =?utf-8?B?YXFyOFhvME1Vb0c4V1ZSWFpkSmxlSzZTWWhnc0FtY25WMDBOV25YeTlZUlpJ?=
 =?utf-8?B?bDN1UFVnaVM2VHRGNmJsbGtWRlBRKzdCelNSY1lBanJrM3pabE9ROXp6SHZI?=
 =?utf-8?B?NHBlaVA2WVhlZjFjUUtvK2xYM1FTMGJkaVhxRDZYaldXNE1kZWV3TmxFZUcr?=
 =?utf-8?B?Titmcys0K0hXTU5OUkpqVXlGclVqY1Z6aTU1UGZibExjUk1RWWxrdmR4L2F0?=
 =?utf-8?B?LzBEZE9NRmxzR0tRb2lVV2Z2M3ZrQ0VjWUlKZXlXNFE3ZzZiYWszOUJsdjh4?=
 =?utf-8?B?VTZaMVJCaS9ZcWMwZ2dDaVpsSWFMcWJKY2g4dUR4aWU3SitoQ2RmS2pxN2ZZ?=
 =?utf-8?B?ZVhTSTI5NlJQWXFSTkIzMlZHMUxrY3hLQnF4OC9tMEdkM0VkQ2I4U2pBRkgy?=
 =?utf-8?B?RUVCTEhlaTVwVVJaYmFyWlZuVGlkVExFNzZoUVRTY1NEWjAxMU5tZ3NmU2Rh?=
 =?utf-8?B?WGdYeWNXZk16SklJTEt6Uy9ncFlIVys1dmpuS0t2K21zRG5XZHdvTHlIU0Jy?=
 =?utf-8?B?a28xWngrWWdBVFQ5LzUra3JXWkZrZnhHaU9FU2lXOXRqQ3ZINlFRanNpSjhD?=
 =?utf-8?B?UkJzOFVPdTZhS3dHOGNsdStxVmxBNWsySUFKcjYwOGFhaG1PR1ZkZXN4WUhU?=
 =?utf-8?B?Wm9VMUVIOGJYbFR0bkxkNDg4NTJ2L2RpV3lPQ0FJRDNOcjE4eUx6anJXOVg2?=
 =?utf-8?B?ZVlGQlNEWkwyeWVtQmJMalBKMHZYc2l1NXBYTktCQ2dWM1JqMldKMEdrNWpZ?=
 =?utf-8?B?RyttRXh5OWtBTHpZaENhdVd4dElqc2V4RjFManZZODJ4RzdmN0JQeTZ5ZG5u?=
 =?utf-8?B?M3pvWEk3dmQxaEVlQzRqSFJqWms4WXNWSndLYXhScmtXTFRHMm9wMXozcURJ?=
 =?utf-8?B?OTVPU2FOY0ttQVhweWkrbFZJTmtMWmZrK0lrMVRhb05UTUVVZkhZOGdXS3Vi?=
 =?utf-8?B?MDJOTThXTXNVWGp2NjRieE5odTVMV0lBRXZoR2JlZG4yL2FqS1NZNWNBWFNt?=
 =?utf-8?B?ZHpGS3FIZ2lBWXNOL3pUaFJVUEo3Y3g3czFWQ3V3SzUwUTBBZUhZQVpsVURo?=
 =?utf-8?B?MWwrT3hmL2ZZSHk2NFRBbVA3UnU2QnM2TytuekJMZ2NQemNGTlA0dnJ0NmtW?=
 =?utf-8?B?NmZwM1E4SGZlY1plRWE0N0FKcXVxS3dMQ2xIdDV4MlhHY3hxYUwxSVgxd3dt?=
 =?utf-8?B?am0yek9PQ0RiWjRoUG5ZcGdrbXZydHR3VnNiUTEzOGN2TDkyVWo2amQxWFJl?=
 =?utf-8?B?bUx5UHhORkorZURhSWJIaVhlZm95bmZOZ29mS2NLRDdGOWxlL1lTZ09FeFZ6?=
 =?utf-8?B?YTdPVVhDYzZ1OTBsVVdFTndJTXpkb01kb1hTVHd1VjdDRmFleVp0RVdMeFRN?=
 =?utf-8?B?djNUaUlmOWtiS201NGVWSlo2M3VwaUk5MjBFb1dITDB4ZkF0bEdnaWZCV0dx?=
 =?utf-8?B?OGp4SlY4WTZjcWoyVzlDSVhzM3l4QnFRR211bkR1NVV2L2ZrcTd5SzJBT0Np?=
 =?utf-8?Q?nFm5ag1AENg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWlGTDR5VzByQ0NVMU96SG0zV2Y0dEVWZndQOUVLc2ZVd0JpektCc1NxQ0J2?=
 =?utf-8?B?R3BJczZydWJ0bVJ0RHQycUpYWlBwWTlKeFRISWtoVHRxcWtrcC9SVGVaQXJ6?=
 =?utf-8?B?cXpIUnBIdHR0YUp6OUE0djlkRHZxcVgyVFBmKzF3cUVuM0pjZzE1Wm1qVDhj?=
 =?utf-8?B?NGEvTWNYbHp5RU85TXZWRjNqelRzVGp6bzZDbkhHa3QzeFI0bnFHbVBYSHJK?=
 =?utf-8?B?TndjSlptS3R5UWl3WEZmbG44OUl4UkZsL1NuQWxRdWxLWklqcFMxZXFDbE1G?=
 =?utf-8?B?MkFXK0lMa3ZqQnRZYVhjY1lLSlpRUE5ic2o2NUFlcGZQUkZjLzlxamM4Q1Vx?=
 =?utf-8?B?cTI1aG9FSFQ3NEtla3B6eWhmaVBqZmo5amhHNkk2SEQ0RUhRd0IwRktzNDY4?=
 =?utf-8?B?bnVqU0p1eDQ0djVFczdQeFJCVlpHemZvYnNWSmNoeC9Xcm00TWRLemJqN01p?=
 =?utf-8?B?K2N4T293VDBOUzNGbkt6WmZtMWEwRDk1VTBoV2hRQnVrMjc0MmRrUzN0S0gx?=
 =?utf-8?B?dlhodUN6SFJBYXVMc2NjV2c3WE00VlAwbnVHTXJsWjI1Y1hEL3RMYWVYclEx?=
 =?utf-8?B?M2dYVWFkS0lIQmNTSytjellpY3Q4RWxGYzNRTkV5eXlTRDhDTkF6N24ranZI?=
 =?utf-8?B?YmwzZGVQcDRxdUtiZDhJVzFOZmhkN2FOT2VPL1YzQXFSeTVSb0hyQzJrQmVF?=
 =?utf-8?B?VTJ1QVZ2TzBOREp5a2ZxcWU1YUNYcGZrQmppRWVYeDUvRzJDeksybFo5MzZp?=
 =?utf-8?B?RHpDMHA4MjVoSXFHS2VRZ0ZPVDF5L3NUZ3N1RGg2Tml3bVB5UDQvWGJEUk4y?=
 =?utf-8?B?dDFXdGJQcERFSElJSUx3SzQ0dXhOc3FWTUgrajV4eVVHL2dQRUswOXNWTHp5?=
 =?utf-8?B?dEFBSWMrWnczOEZLck1MYit2QThXbUF1c2NLaGZOQkhuZ2VYZ3psM1g5aFcr?=
 =?utf-8?B?ckt2bmo4YVF1bEg4em1MNGhuWXQyS3JoQzdBblJzVWpCQXN5aENaRVZpWVRM?=
 =?utf-8?B?TnFlbGs3MnRqRWMyRDlwZlFVeWwvQmx6ZVFsS25EU0FNRkY2OXBTMDV2UEhD?=
 =?utf-8?B?d3RvNHpwalVEdDI3YnlRT3BWU1RPemlKSStYZTY5ZmJLQ0d5RTZySktoRllX?=
 =?utf-8?B?UWYzZ2dYMFlWNGhad0RacmZDTzdlTC92alVFUzJnOFpibWpGY2J2ejFmaGVX?=
 =?utf-8?B?KzdEYmpBMzBJZ200K1hIVTRDTHlrajkzQUFiOTFyck5zYlJ1R3owbXB4VXRP?=
 =?utf-8?B?L0JrcDFRa3d5MFA3ZFM0WFZHS25NOW9hNGFNYWZadHlVdWl5aXkvRlhsbkNB?=
 =?utf-8?B?b1Mwak5KeE9XRitIaEdxeGI3cjAwdkRvTzFUTVhmUlQzaWNRZW1mQ1prWDV0?=
 =?utf-8?B?eHk5OVhsOG9QZlF2QW1uQnpaS3FsSXg5MjRkNFJFaFdsYU92YVc5MVR5UmJ6?=
 =?utf-8?B?ZlUweGNqc3gzR2JkTkEwZGZsSTFsZEpaaUY2SnRCWm94Q1Y3OUo3bGZLZnhw?=
 =?utf-8?B?MDVyeFR6SXJxMG5mbGRCOVpFcXl6VFZSUHRMNFhyalQ1Z3ROcTMycHRlMzM4?=
 =?utf-8?B?K0VsYjBJVGlEcXJTSStJekNjVnAzQ2NRVXBhWmx2ZE5TOExWZkNJVXlrSlcy?=
 =?utf-8?B?TVQwSjgrVTE3QXVIR0FJWEYwNld2QUNJTDE3VjlKVGUyOW5hcGpidlM4dDZP?=
 =?utf-8?B?SGhWOVZxZThORjhUdC9NYW5uSXdoMXlJZE5MVTB1amVFZXd1Z3FQZ1ljUVNz?=
 =?utf-8?B?aENNeDlzdWVyKzQ0eDBqMEdjb0hjY2ZkUThkMVcrUldVUVJJVzFtUzlrTS8w?=
 =?utf-8?B?cWJlaUlTYTlMdWUyajJ6eElPcTFGUnpmZDBQOFNQYVB6STJUSkpTb1YwcVk5?=
 =?utf-8?B?bXFZSWhSdWV4RnZQS0NHYlFqVG1MdHBqNDE0VEVHNFB1TW0xNFFTWGc4Qk5P?=
 =?utf-8?B?bU1lb2hiekxOYmw2bmhYeVh5bUlVejYyenZMeVcvS2ttUkE3Sk50UnV3Rmxr?=
 =?utf-8?B?aStoR0Y5MGZXK0YxeWpjYVNoUkVJTkVqMjhCWGtwMU54eFVjZ0IxRTBGaTlP?=
 =?utf-8?B?NE51UENLT3lGQ0ZyUFlYTFZzR0x1eWcxMUJBbWtGWk1qRWhhNnBBczR4ckta?=
 =?utf-8?Q?vPW5BBwyL3Q1QZgLfiGm5JE+x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4/5Fju9qa99oDLg8/Zo9IX66Jh+oyBF6N6H93OZuN2f9Z5UmzNrsZx4cD66YHsUJUbRxsw2T58zKoixkN0HfD9VBtJwYmStbWArot5UvlRoSO4/7UTGuZiROc3lTPo3o5pCQijH3CDm8DEa6C4wgiMu35IONlMWfVSfg+V+zvIRiF/mgfhq1K1eSsk7c9x41qJy1S5c+WnAXOMGEN1ztqWroBN5rdebn2TeNokAGa0SA3h63Mrp+EcINbWhJSl2h45qDp5wcKlZi7RVJjZ8nC3frMuljBqxAuKrkX7hHsJY4ITa/PeoxPtCqh0t5A0kRiKoPcQ1gPUc/9z36auIa7Y5jbFf6o78kPdI1Fxd3HczrWt+tsbnbLGgcKgEePLI+T+w5iI6NQfAPCs0SEj5M4OhVprzzhr/Tcywolc6Cc3kvgZV/TfSRaPnC5CXDPkiDwnrtY8e6hMD+yURkg/T7uHosmRsHuIVjL87eSv8WMlSfkOELTGuA6srbEJU/3WxP3oqhDme/mSLktlbGu1qfBZ+Y+mhGRNSDZH2vE/TtlgTmJmEJtVarpJmwkPYfS4OgBfGHmWM3codC7mXogFQA7UDtfac84I/h2bK433t8ICw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146bf3c5-86f7-400c-d1ef-08dd94576146
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 08:55:17.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qq7LBA8jss+BS/m7dw+u0+W49K8AuUDrZat68eoCybN1y2OBVroa+MNaAN8NUgNY0ta2y3xcxJM4uJaFEzOC4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160082
X-Proofpoint-GUID: phDHl8KlfoGAAPURYejH95oOQ81VX02m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA4MyBTYWx0ZWRfX1Uj2gDdX9xna GEwwKPH/db+Wqf2wZnqprd94n/xVFhKJPRbcuwmCKz3tu3685WgbLh78f3gqGlIQn4OwXgNs2qh 0h4pp+y0A+WHpM3uELYO/EAoQBJLJiABjzShb11ILCwPJaunIWxPKuOf1qqHsX0WtF2C1DF9yln
 8rqyjURLbe7NgyL1MFnsndfDr3uqybiMv2nBoLWWVtQeMg7qC4LlQueHtleq9cPl/FPM8TyzCn7 aV4SQk2z5xK9qEumQk6il/ZjV/JO+fHgnXYIKh2l0084M2bKUjIah4Ic5fWqX9A674ZiCq9c7cg XDX7m2a3JEtRclzjph7Sv2qJtt5Gv8NYvdTZ05GJ9kCzj1hKn/jl7MUd+x83PgV4JKUigGCr30i
 sLNS8NyYCFiv56F1YPnT1G+2FsOJKs6H0lNuxKLMIuTdHw2OPD4dM/++gtzWff5OBBFst0zr
X-Proofpoint-ORIG-GUID: phDHl8KlfoGAAPURYejH95oOQ81VX02m
X-Authority-Analysis: v=2.4 cv=O9s5vA9W c=1 sm=1 tr=0 ts=6826fd78 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=RrudPxF6bNC1gOmmSdIA:9 a=QEXdDO2ut3YA:10

On 15/05/2025 20:50, Ritesh Harjani (IBM) wrote:

thanks for adding this info

> Application Interface

Should we put this into a common file, as it is just not relevant to ext4?

Or move this file to a common location, and have separate sections for 
ext4 and xfs? This would save having scattered files for instructions.

> +~~~~~~~~~~~~~~~~~~~~~
> +
> +Applications can use the ``pwritev2()`` system call with the ``RWF_ATOMIC`` flag
> +to perform atomic writes:
> +
> +.. code-block:: c
> +
> +    pwritev2(fd, iov, iovcnt, offset, RWF_ATOMIC);
> +
> +The write must be aligned to the filesystem's block size and not exceed the
> +filesystem's maximum atomic write unit size.
> +See ``generic_atomic_write_valid()`` for more details.
> +
> +``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provides following
> +details:
> +
> + * ``stx_atomic_write_unit_min``: Minimum size of an atomic write request.
> + * ``stx_atomic_write_unit_max``: Maximum size of an atomic write request.
> + * ``stx_atomic_write_segments_max``: Upper limit for segments. The number of
> +   separate memory buffers that can be gathered into a write operation

there will also be stx_atomic_write_unit_max_opt, as queued for 6.16

For HW-only support, I think that it is ok to just return same as 
stx_atomic_write_unit_max when we can atomic write > 1 filesystem block

> +   (e.g., the iovcnt parameter for IOV_ITER).


> Currently, this is always set to one.

JFYI, for xfs supporting filesystem-based atomic writes only, i.e. no HW 
support, we could set this to a higher value

> +
> +The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
> +writes are supported.
> +
> +.. _atomic_write_bdev_support:
> +
> +Hardware Support
> +----------------
> +
> +The underlying storage device must support atomic write operations.
> +Modern NVMe and SCSI devices often provide this capability.
> +The Linux kernel exposes this information through sysfs:
> +
> +* ``/sys/block/<device>/queue/atomic_write_unit_min`` - Minimum atomic write size
> +* ``/sys/block/<device>/queue/atomic_write_unit_max`` - Maximum atomic write size

there is also the max bytes and boundary files. I am not sure if it was 
intentional to omit them.

> +
> +Nonzero values for these attributes indicate that the device supports
> +atomic writes.
> +
> +See Also

thanks,
John

