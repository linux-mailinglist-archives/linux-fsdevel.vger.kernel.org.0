Return-Path: <linux-fsdevel+bounces-32873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 797109AFEB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0059B24F40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CB61D90A2;
	Fri, 25 Oct 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gE1i17wH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pVTaakZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1731C173C;
	Fri, 25 Oct 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849518; cv=fail; b=tFM1P7+MeNHbsd2xyh+Z2Dm85MVV/T8Tva5pVhqGbKZGdTdY+5oq4uE3Dmg33EgbHhC+QqgJ2TUB5UuFBz15lXhSV/7MreHziyo+qfrwNSIS8srRgw0wcNVk3WYEniRz6CkZ14sjRIyQFUouCnZAwyurauZKiOUP6ku0gq0bPCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849518; c=relaxed/simple;
	bh=iR10pR3+unuYnTkaau6DQBTOlVPYooDIxxWn5vO/whQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tVPjNoMI37ZE+kbrl4TzDsGbWA9sJPbM+qY+uzlhLlK7vWh/xHp7KSijoododY/QP64p95DY9iPSNvPG1LZ1mqzyCpkG8zCH6ZETfK/Yu7JkKtYjvb6xvKLBSvQKf+4t4v2U2SQ46kotlE0OsveUB2qfXLDqJDASVCAiXbrtC+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gE1i17wH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pVTaakZj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BakU005853;
	Fri, 25 Oct 2024 09:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=srqn9KEB5gF66rX6myXK+/uMdGrqNo+ejxilMwG/OBk=; b=
	gE1i17wHBAAjtcA/gWjBcRma9K9DBiGtpNVV+IN4zhtUtNA0+PxffcQgP9Vmvr+W
	m5yfhf2PSLFASEIJj3sKCKVQv+Nk+qMF3tDNjz60cwYZ0xddsR9r7PTcrksx1GFv
	Z1aiqAY7K35/dKzq1NHZHsnnPedMCRgr93cjXtHhHSLfUmKFOUYc9CdmWd8tfjJs
	A92QtaTpF6AiToSnRWHnLsdZo7MDcWxbreXnw2xIFpoNUa50Y+IwMexWORnVyNRd
	WVmEt00sx5lXbBa3gYDsH3bxyZsiwLUg3kJBrRZKowu7Ebz9PwS1ovpdNOXl3nHx
	Dwe8SlYY/rb6h0/SKJO12Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvk5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:45:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P7QS6I018812;
	Fri, 25 Oct 2024 09:45:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhn5vde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:45:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ug112Dwjbh7lA8A1PMTG2LeRmK0vazjoARSgCs8MjMGT81G1fCpAQwBm51KD57HjQf9bgmAfefjgW/0ID1VSQbcopyaVPmVDZSRXBkf6dYUh5+1jdvsyHOJ3subya1s+wDL12OYHLWJUQzwY0wKOsLEHpV5RGob/+rCKWHc6fZXTv61t0BY0rklXa7+fSRqVo505W1qWcMlQmcyBim1b+aVt81/FEPhKluQ+zcGCI43XDOMQJkeO8MQTxOIlGyHR+vatJzT5g6eFUMJV+ofg4s5dXS7hD1/G5bhNZxas+FtDqs3SVk826U990qmWZhiE4848ZB+QHzgxbj63yjHW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srqn9KEB5gF66rX6myXK+/uMdGrqNo+ejxilMwG/OBk=;
 b=dpZ4c5VDfv0B3qzwHoimC0PV0w2QYY8osZvwYJUSiNam4WB+f3sT/GYfGUkMZKy1mmx5P3tCM5N8ASDU4QBxLA4WvkXb+YmoM+91j5jc3WLNoeiKph/Ous0rf4sALl+UU993vFKKmaQoYvnTjhTnBazcjHvAJU2OZ20SNfbc7wqaH2VkqfGRKqMRANLxeO0aJAtaPZIP5t/8Kzt2uXkx8pTQ0L2OKrEeO4t3gSDcoYHVdV36rX5N5QwMxwvsxL7OdDOW5N+PiIklMIXbu/1BNAsAF6qPC6En33yAcKc0jbFewqe0EpQggZsAHzJHTyPgQnWh5dp6z0WBppAEyuwNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srqn9KEB5gF66rX6myXK+/uMdGrqNo+ejxilMwG/OBk=;
 b=pVTaakZj9BBZ48Q/Ot/DHIUzRu6EWiskIDeZrH/FLwAgIdU0bhqL1bjucbcukf6VKNntn9R2K/gR+ZPAjays1wsjm7CL0O5xE+V6JdBqkEhy/fBQlh07xNx6rD39gaBkFFFwn4l8ok+0knWXnUu95kmwu64H7fdpPCWLRHeWh6Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4742.namprd10.prod.outlook.com (2603:10b6:510:3f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30; Fri, 25 Oct
 2024 09:45:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:45:00 +0000
Message-ID: <b6f456bb-9998-4789-830d-45767dbbfdea@oracle.com>
Date: Fri, 25 Oct 2024 10:44:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] ext4: Check for atomic writes support in write iter
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <319766d2fd03bd47f773d320577f263f68ba67a1.1729825985.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <319766d2fd03bd47f773d320577f263f68ba67a1.1729825985.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ff5077-54c3-45eb-4834-08dcf4d9b13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVdIUHZKc3Y5VGFiUDhFZzM2UEE4OEgwaU1MVmFuVHBFQlk0aDZaKzJ0LzhN?=
 =?utf-8?B?c2s1U1Q5WDBpZFBsdTZUYk9rdzYyeUpuRldvdXZ4Q0tGUTVSOUVlbklYTGtx?=
 =?utf-8?B?bnlwVTJjRHlROS91MGZMMXJxUzd5WitvM1c2MDBtWGZHRWF1cG5zVjBVaEsv?=
 =?utf-8?B?N01DK2FsVE4xWC8zK1g5djU5RjRHUlZISDlPZC8wbHFaQWozMks2RXVYMDdJ?=
 =?utf-8?B?TXhqL2ZwcHVNU1hlT1g5eXhqTmcwNnVrbDBIdkZmY2pueEJoYnhUT0JUcC9x?=
 =?utf-8?B?cXlIRWUvYkJvZjNjZFZhZ0k2K054RDFYNy9JQVpGTHp5QkVKMjZnNHl4U3VT?=
 =?utf-8?B?Q21ERGJBNGUxS1d1dndyWFMvMk9GTVhiejF1ZElCU0NOTG5XUmhYRzRhbnBG?=
 =?utf-8?B?SllEWWh3OGhIVmxISkxSK1cxNkNrVEgreHJubGhMRkt5NGplM0tPVjRTWEJX?=
 =?utf-8?B?SEIyVHQzcDJ4bDVGcWZwaFp6Y2FpWE9FV1ZPYUx0NWQ1c3dMUjRjZnRHM3dI?=
 =?utf-8?B?TmwzOU9xcEdpajY3VGZDaFdFb1V0aXE4UWR2Y0NWQWJySDIxejBYT3pibi85?=
 =?utf-8?B?THRZekdJbEpvZnlIMGRmY3hoeVVhV3V0ZXZKUnBKWVBqOVJEcEYwd3ZZSmlk?=
 =?utf-8?B?NTdRMUVIZEJ5MjRuQ2hORHRTZG0xOEhjZC9CQ3Rlank1LzhsOVR5ck0wMC93?=
 =?utf-8?B?MmNOTFREdXg3NjJQOG1KeEpJZDMxODBTSlg4WEtlTjJ3c1I3eElnRG5jeFJy?=
 =?utf-8?B?WXVhb0FGV203U0ZrSnY5dU1VS3U0VjhiRm11bUFnSnA5QlNvV1dFZWlGcFIr?=
 =?utf-8?B?NFp5dVlLZGZWM1BITVJSYytQZS9BWEdMNlZQelBkMXNKUlVJZlh4YVJENXkw?=
 =?utf-8?B?bXNINjBZd0FHb0xHcGxaR3hYUUNwMXVQbU44anI5QXNlbkZQRkZCVHBNN1RH?=
 =?utf-8?B?K2tPblF2c2VWQlNCQWpnN0FKTHVRcytPTUZlZGxlRGVZNmp3SUp1ZFlUVlNk?=
 =?utf-8?B?V2NrVzdMdFdJdFh6Q3JDVHVJanZ3VTJvMUxGMWg5aXdxVkhabE13cnFBd0tC?=
 =?utf-8?B?MXlZOUxwWUUyWGtLYTlwQzZwS3ZKZjIreVVjeWZaeHNDMlMrSFF0R1ZtZnIv?=
 =?utf-8?B?dVFDUHlSNVZreDg4Q2Z3Ym9DdTBQT3VZTlB4U3ZtTWlnY0RvUWtabVNHR0Zi?=
 =?utf-8?B?UGtjWDcrQTJvNHZ1TWYzY0lBWlRmNGYwNE5kWTNPQU9LazlvVlorZkhlaVpI?=
 =?utf-8?B?NFJGQklnY2dmWjVWRHIyYUIySURUcUV6WnlxdTB4d25xc0VRQzhkRHYvMGVh?=
 =?utf-8?B?a3FPWFpFVGsxN2hOaCtIUXpvV3NQZlFsSU5BUyt0VC9VWGpFblpZNXFJYmdT?=
 =?utf-8?B?K2R0M2U5SnhSUFpSWVRGTGdRVmRGMXRyUHNrWUdveWl5YVRidFBkdTBNTXFv?=
 =?utf-8?B?L0tscnMxUTdIdHhsYkRmNUVyVktrVU9jOUp5empxVDhwQStPREdzaGNUTjk2?=
 =?utf-8?B?NGJuL0tmd0NzZFk0ZDRudzIzK3N3MVh3eVRBaUgxdExUbHRGK0MxZEJrQnNS?=
 =?utf-8?B?RllLSDNFRWQrcm9ZUGJqNy9tbEhsODRZVzAxeGlsUFdITHg5OThrVWhaMmVi?=
 =?utf-8?B?b1I0T3lBd0tvcGplN0NxSXVXZFZuaUZyM01RcUJpeHlZRTU2RVFUOXdoYy80?=
 =?utf-8?B?OGFRVktKYXR5NWZEemI4RkdxSnlyQjF2Yy9XWUorZXFCU2M5VktiSlJNUFpj?=
 =?utf-8?Q?UK8PEBcEtYZ2RNlGBgWPzObcyW/7m9V+m3cpnWs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXpXeHRWS09nN1RFM080cjBQSkNYQkNKT1I3RUVOSlI2MUZsdUJVbmZCWTlO?=
 =?utf-8?B?N3RZejNYaWgxRENrRmRZWlJPNVhPTnNyaWdnRSs2eXVGakp3eEFNT0YvSmZC?=
 =?utf-8?B?STlxR2tkQjMxcWx6R3QxZTdkZ1FGVVF1Ukg1alhVeEZvM1lHbFdOTC9LMkwv?=
 =?utf-8?B?UVFQZkQrSWZ2bElVeE9rZ0ZCTHFXQlJCenJwM1FScXhETEpKODltQmV2dHJV?=
 =?utf-8?B?cWRkZmo3THRXSjF6VVlob0pLYjRQc1VxeStWQVhBN2FyVEFTNmNqaW1XbjZQ?=
 =?utf-8?B?VmR3enV0K1hpQWFYUmZ2STRkZVEycmFoTFZjQTUxMzlPVDQxZm4zbzZKWlF0?=
 =?utf-8?B?bkFENzQ5MXd0dGQzSkt0aWFnWU1iWGpXR3JWTDdVUzF4dTRyS1NUenFUbDhj?=
 =?utf-8?B?eFJ6STYzR2NiY0hUdlN6dCs4ckVTelg4NjF0V1dLbnNSSUlmRkNHa3J6UURO?=
 =?utf-8?B?Y0o0RTh2NVZ0Y0YzNFRPVDNvSjA5bDJnNjRlMmFGSVg4bGE2bStLcll4WW9u?=
 =?utf-8?B?NjdHK3FUSGhvY1YxU3J0eGFSZEY3RFpJUkdWc1VoL2d0SDFyT3RJbTNXQlJs?=
 =?utf-8?B?VW9DVXRLUnhjUUkzOCtRWmowamw5bXI4WFBSNU1JUU4zYUZ6WjM1dFU5bXNV?=
 =?utf-8?B?UUszVzl4ZkNZcGlKK2pwRlBZTS9VeVA1eHB0UnBtVGtpZmtxeDY1dk1SRlNI?=
 =?utf-8?B?dzNMVy9ySGZOSVNmamJqWWFnVlBRejRKNUE2YTd0UzhiRGpzU2lSUStER2tO?=
 =?utf-8?B?cUVuNWphRGlKWXhIODAzcDN5SGZIS29TWHI2MG5JUmN5VFY5UkMxRStaZGJs?=
 =?utf-8?B?WFRleTFYY0p6eWwwSG5PMncxUGtweXlxUlp1SkM5Wk42WnJnd0RqT1FqTUZu?=
 =?utf-8?B?NGUyWGxTTWJGK1dTdFNPWHlzV0NNNjc0bFBKWmhPZUdwZm1rWldRNVl0ZnN4?=
 =?utf-8?B?N3ZWSjBiRWFZZjFheWNvdTBnOUdrcmxiNnR6bDNwUlNtWklzb25CU1hmYkQ3?=
 =?utf-8?B?Ty83aEdoK3hIS1czbGRjRHdCTk5RclNYR3pWa0l0V3ViN1M1M3c5TjZVaXJq?=
 =?utf-8?B?UkNOUmNqMHlyZ3lrS3ZwUjNkSk5PRWF0OHFIUWpsWGoydU44Y2l5Sk9wY2Nn?=
 =?utf-8?B?bnBDK0lsbDgzMEQ5UEtFTENEUDVURnpNOVhXQ1g0QzVrOE5sVnpjaGZBSmlk?=
 =?utf-8?B?U3pXemg1NCtNNVdFd2RHcWQyV0Y4RGlSZkJubmlTNW5mSXdGUk9zRklyL2Y5?=
 =?utf-8?B?b2hGSzU3K1JFcmxmK014S3kyL0cwVkp6cWt3TWZZbi9iZmZzN0UyMS8rN1B6?=
 =?utf-8?B?TlRBdUlnZTBIQS9POFdhNU5VMGVDbjFJaDZwcGV1Qy9uU3AyUkFEd1ZwT01U?=
 =?utf-8?B?YVdRbjdKaDB5UjM3QkFISVNkTTNZUHovNFc0VVREQ0ROa01TaC9IVEtwbGxV?=
 =?utf-8?B?cXFwOEQyYVpHUWRITE44Qy9xZTJPVEVTR3dXRXc1c0FxVWlCdm1MK1FGclYz?=
 =?utf-8?B?Smxvc1JQV1psUVVPamNJa2pFb0ZDaHB1VXo1RGVTMHhLRHQzTnpSTzVvNWpM?=
 =?utf-8?B?SURUZ2pidTAvaExuZ3EzbHAvODN5dExKdlFOdEk2ZTg0aE8xVUpySjdQTTJL?=
 =?utf-8?B?czA5ZTJHT0taeDBzQW9LTXV2U3BqY2wyMEFtLzkzb01FU2xsdkgrZnhjSDlr?=
 =?utf-8?B?RXZjSktuNjFJdGlpUXhhNEpJU3VPaERZKzl4UnRGN2VyRGJPOFZvVjlRL2F5?=
 =?utf-8?B?UmRaOXlRelV5b1Z3bXBzcXpWQ29razlwS3BQM0RmcTVDQmV3ZHIxbUlYVldJ?=
 =?utf-8?B?SXVxOFhRcXNWTFkrU3g4NnpmQXcwa2RqVG90ckxrVkZkdzVYektaZHBGbW1T?=
 =?utf-8?B?WDhnSHpYWEh6VDZQOTdPNy84bFBuR0g0bEF5UUwxTTZjS0x3RWJaU1lWOUhH?=
 =?utf-8?B?Z2V3Qnp5MDVhdHJ1MHFZd29oVjJSR2hySHJXY0FzcWlvcDhPZWpqZk15eWlu?=
 =?utf-8?B?VmFCOEFSTEdiUXpKVjlVR1NEN1EwakFwcWlzNEdHajRmbWNaK3p2bVVKTnJW?=
 =?utf-8?B?aEVqVEI3MkNSOGoySTl6NUROVEtXb29xUnAxUjFXc0ZlTm54aDdrODRNb2Qz?=
 =?utf-8?Q?5EvJ6il0K2V1Ak+G7AogKuhA6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aQqsYVxlp+p5wd9J0hKGxtOSxTP7/fFoF7EPkUX66bSyoBUpRMjMvc2PD+4bjCeXS3vuMLSAO6F0tAcpvNKyeuSWHcemShAXd5SdeaB1e1ybVo3RYLunXzvUyBlPbawXF4B6xDI/ExtLlaJO9aWtoPi7BZfqLHDOhrzF0nKGDfOU9d4tQydoK1JWli+Dj8BJPkkKc2yrQyxrR8kYSIenctG0K0keU29ZD+twFDULizyMyZmAowfCn4wEI9QyQ0C0PeNTizEzlEyGbjqXiy4n8VLML686Wnncu95E3N/KlG6AhZhKH2pV/v9fxC+b2iNh3iqPHGvc9/FAnf8uAgfh34jLpI0Mc8kBvqM3hANpFrhR+iZ5KQB5TkZCAHhTxoI0h4irJy925z69BA6rTmy4VFufR3/wjxf7nyA7TpXqSoHte1LXWQRA+XYccLvf7caoK/Ga6Gkr2Z8MrPIBV4UsYVrvJHJxW6B5XxZmN2lrC/6KvtgmT+Hla/WNvARbVFLW8rS5EvCuMv6TNiI/0j+FxHUdBILCIGDaFvhqHVsHy9y18rf4mgCa7Qa4mmlWfvYUmBBp1dZ/bONKLOuhYL2allbF86TgZbrYDb+kXJGuvsU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ff5077-54c3-45eb-4834-08dcf4d9b13a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:45:00.0332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqyQ+WsrYVV7BKCNb4INjj7LcTL05zkrzrBMsL2CgD77jlFD4qLPp5RYQtM2TduxBNFBcFbYyq7MOBQHgCyyjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250074
X-Proofpoint-GUID: 29FEt8JoawWAGpQyXHM6juCtjF06LM4t
X-Proofpoint-ORIG-GUID: 29FEt8JoawWAGpQyXHM6juCtjF06LM4t

On 25/10/2024 04:45, Ritesh Harjani (IBM) wrote:
> Let's validate using generic_atomic_write_valid() in
> ext4_file_write_iter() if the write request has IOCB_ATOMIC set.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   fs/ext4/file.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index f14aed14b9cf..b06c5d34bbd2 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -692,6 +692,20 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (IS_DAX(inode))
>   		return ext4_dax_write_iter(iocb, from);
>   #endif
> +
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		size_t len = iov_iter_count(from);
> +		int ret;
> +
> +		if (!IS_ALIGNED(len, EXT4_SB(inode->i_sb)->fs_awu_min) ||
> +			len > EXT4_SB(inode->i_sb)->fs_awu_max)
> +			return -EINVAL;

this looks ok, but the IS_ALIGNED() check looks odd. I am not sure why 
you don't just check that fs_awu_max >= len >= fs_awu_min

> +
> +		ret = generic_atomic_write_valid(iocb, from);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	if (iocb->ki_flags & IOCB_DIRECT)
>   		return ext4_dio_write_iter(iocb, from);
>   	else


