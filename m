Return-Path: <linux-fsdevel+bounces-10314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D204F849B38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8838A2810D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B1B2D05A;
	Mon,  5 Feb 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DU5JBfDs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Df7+15UA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170B2D022;
	Mon,  5 Feb 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137793; cv=fail; b=uAPukRxVAymN3zTpNl7XLNUgb+rsqeSzxQ+vOSN1b682l7UnG6bprdAXAuHvQuZbroJ56pKOS1UiS8P9DwylKMob5Uk6UulQMyNazZxfjDWQheiMj+haXiTp50t8XBpN4bbDThcs76i7TfhAME53Z6L+tm6m1ckTTEVkb0/q3NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137793; c=relaxed/simple;
	bh=FOQuAYpzc6KfMZj0VI410ZgM8DHu3qPk2uDogvhQKu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j17+8+jsX3ElViD6mkdPYCgJ+ghR9UaxdjwarqU2aCdTsqlMOuQABvvSbvj/whpS8oxOPfatMJCQZQUW0ccqv5FGxAanMDEGMDWmWgWic2DJeoiY0FQ+94qG55OBSACuiKoH/OK79q/3HxeqiRNFodrEcnFnCaUoKMwYZ/IvUJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DU5JBfDs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Df7+15UA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4159Pbu0012712;
	Mon, 5 Feb 2024 12:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QxfMZ1mNrhtLhC5OthC3FpSYIzLXeXU8/i5IBbwVoEc=;
 b=DU5JBfDs/LbuzG6TgmkF22JYOVl/V7eknCMtu51JFylnWDkqGaFBD42gn+J40KxeqiYU
 U6ZwRYcqQ4gfDyPYLmQJ8Rb5dUlUZPU4A4CSsNwQrltNWjIoN1G36V0FmbOWNx26GOF9
 qY87Wcak4hKom5woAjwEumq9edZuN9eP9zN/UDxxpgp6Oo5PFFYizlNxCPhWVXZurJHF
 1cY76As7P38Mtww57exuIKpDcRXqLhd+JeGd7g9RQtcEyaTGWp9a7OUFR7Iy4OCMCxkM
 sCCSgsLaCfy1MUvvvU7Tz4+XWs7ozwFWWsLPtqhh2i3o7q3QxozLfteA8W6R5kaEcrA6 kA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1v3r9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 12:51:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415CQUVr036728;
	Mon, 5 Feb 2024 12:51:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5n378-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 12:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X09BvvaRle6MAZzHtyWmKEiIjDPbjRUn2BOobMbyl73E/DOo+6zVqufNIiQZeq4BxZ8hu4YEhUHnKllI6YavWR+L4vjVsMhx5RU4Il6U0sfcT9RsP3/NKdPRaBSwv2h3ncM9Byuu+lLW+FI/+CLnk+QlgYZCu6KetVPhnow76mcEBBRkysDjFogUoQYI5rSHsUBBxwaLWgk7FnnX48zE8braOg6LZSC785fBy2bHJFDx4AN1YcC5mS3D8UMVhoT69T4hsVc8pCLrM++LwwGDc0xYEkpPMlLfLK39ctlyTZ1u2NF8o0k3ngoy3z49A1cAJhCfRzZfYLaJYZs2266GSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxfMZ1mNrhtLhC5OthC3FpSYIzLXeXU8/i5IBbwVoEc=;
 b=adQeQuysCmv/Vu8tLRTaRwtEcFJViMeymzwT/2yvdlt7ZIdcZ6Xa3vVrIOY3RzilgU01Y6+0zqbyZdKyatjpSYRdjGaiz9pLaYtKMOVENcTbrOveVKcw70Rwr/sV56p7iuDcy7vdf7SbKhpFWDfyw5GCQqbJalZQ33cBOKwLdx4uGIIimk9eksEkt7Sh+/nVtWRMQsq2ZrN2fyewBxHFSM5rG47N/Sizeu1iOQ6kPsIdq6lsI3KdqiSTFsj3g/xC2AuE6thouD/EAnck1yf7MDpW27xlGUobzeKzWCGbWIb5yCpTJJRVpIHZD9xpbWTYus0u7XUn4kDeMFSPSoh+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxfMZ1mNrhtLhC5OthC3FpSYIzLXeXU8/i5IBbwVoEc=;
 b=Df7+15UAc5kASOFfnSWKNpKG3/7SNPoLl06HZZVrchNTfwEB2K7GAl7Ulgz/Qt2Cc9C2j58Xu2W3cD6g1qMFfy+UoTH5KPfYWxcLZIOGYRi3hdq6iEz1Z5+Ln5BXdbGCLVi4HpH9yNSNbmBpASvmwXcJxDehmdvRWDY5kti2pRc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6453.namprd10.prod.outlook.com (2603:10b6:510:22f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 12:51:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 12:51:11 +0000
Message-ID: <7330574a-edc5-4585-8f1a-367871271786@oracle.com>
Date: Mon, 5 Feb 2024 12:51:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] fs: xfs: Support FS_XFLAG_ATOMICWRITES for rtvol
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-4-john.g.garry@oracle.com>
 <20240202175225.GH6184@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240202175225.GH6184@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0198.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a6fc4b-b1bd-4b70-34f4-08dc26492128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	J7Xhx6kjb1/QXk3n62auFhQlhBbyOdX/O84sVbH7kW3qoeSMvMnVa8XHg86g0LkMNhIq+Iw77J6EV6//rCfFQEaCV6zdsW6jXIcb9eyOw3xT0d/unIotXTHceycdvLKWIgVI6YxG87L9nVu2wsKegiq8nKXnO25YjBhqNZHq5rO/NHKfnj7CS9a2lu1cHJFEr+lEpAAOIr6t5rogr6MuLy7EkYTm5tQf7C9JsZmwM4iVAJY/jVrdwCU1unhOL3U2241SnBjIlaGx7XITEDa4LeV/7raJ43MN3OMPnN+olBzGc7yHWM80l10z1QO8CEgI4OypH7l6bosj0Oy8S8vki1rbZr8QoqgbV9CqA61UNWa8ZY+r8QajqBcaix94niYrTvbLIcq0jObFj7ZrsBrDThd4GZN4XDIlKGg+ya43/PPoTXbH782uWUiG6vbkDiyBtgohBd5kaHVgrcqbTSEGxeoQOL0sMlhh0XFEbCD3CufZlu/DvWCfKNzZYVCFWeSv0p4TPo7c4ehzvHzR4QG3JwNECiKq8t+M8o7zBnvCRmvIAunpLhpyvoHPHpeGRhhIbjKNuj9VdXFE0XVCcTG+m3+2fBCONM9bC57QwXsqfD0XBDD3XSvfvK5ny8WU0hXq7vsiBf5pkKvPfUAvcQ7Byg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(7416002)(5660300002)(2906002)(31686004)(41300700001)(83380400001)(26005)(38100700002)(2616005)(86362001)(31696002)(6916009)(6506007)(6512007)(36916002)(53546011)(36756003)(8676002)(8936002)(478600001)(6666004)(966005)(6486002)(66476007)(66556008)(66946007)(316002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHZUVUZiTGJDVlp0SmRSOFV3ZzE5RjR2amoyMFR1RFRiMmYvQ3dvWFk5L2RE?=
 =?utf-8?B?ZXJybVJaZ2VJZXlqMnNteFA5SWxhcG1VMHNuM05KSHhaMFdUYWdzL2toYkVF?=
 =?utf-8?B?NldxYS9yeVJCL1dwWFRISEE0OGJJdWdhc0JpQm1TM3dCTHFPT2MvMjM0cUFT?=
 =?utf-8?B?YUxPNm5Dc3QxVnR4alNGbmJWRFRPWkdnbmlXZkt4Ymd1UFExTGtGc2RjYy9G?=
 =?utf-8?B?Z1RJRVR6amVTR2hPLzdpQTU0QnJyWG5qTWQzeURmMkdTZmIzZWc4Mnk4MGhm?=
 =?utf-8?B?akJIL21GU2VzR3BoMHFPTnArWjUyS09ud1FrS3lYOXQ4K2dyR1hEY2JqNkwy?=
 =?utf-8?B?eCtGTkJtSCtCM3VNUWZTNnZzY1ZXdjJkMDZzd2NQQ3gwaFFKQmdpQmRPTFFo?=
 =?utf-8?B?QytoNE05OG5iYnFTdTMvemhqVjYrQm5qb2t5TnZyaDE0ZjBsUHN1L2N2UkdY?=
 =?utf-8?B?U2VrdC9tdFBZTjg2RzZaNlFzQlJFcDc5eGpwclJsaFhrbWx1Y2JHK2YzTTF3?=
 =?utf-8?B?OWUydWcxTlJIYWVHU3gwYWUwNW5ib3hCTjZORVRVRjdXOFhVNlloSTBaTGVy?=
 =?utf-8?B?NWZRSjhEQ21rY2F3VE1DNDJvbG15Y3VlUU5pU3llKzhyRTdncFlIbTkvNVJG?=
 =?utf-8?B?QzRtYm9QdEovd2tEcnB0UVlCWFBKV2V3K2VsaFlZQk4wR29SSGpVYXNuK0lZ?=
 =?utf-8?B?L25ZZGVKaVd3Zm9lczZQVVBNMEpZL0ZNQVB5dnZMdnNzWTNrWXhyUW9ERVVJ?=
 =?utf-8?B?VnAra2hsOHVyTnJjYUFSeitoSlFaRWh2ZkE3Qm5YZGZjV0F2UXJGTGowdkZi?=
 =?utf-8?B?eFNydTFMR05iOGg1eVl2clk0Tk9ObDRrK0xLTnFKNS81M1VNSkFFU3Ftdkd0?=
 =?utf-8?B?UVZHdVFLREpkYTNKZGNSMUNYMWhWYWpnVk9wN3U4VlZLNDRjSmNOTHBPQU1q?=
 =?utf-8?B?bWdrS3Nocjh6Z2dLbmgwMjJzSEZMZDVyamJQbkgxK3RSMGg0eUd4ejkyTU9h?=
 =?utf-8?B?amNFaFl0MC9jNDJYc0c5NzR6YTYyb1JYS2ttV2VVT1dBTFBIN2M0dzVTUVNn?=
 =?utf-8?B?eFhKV0FDTU9XeTJkZkxlc212RnU5SStkTW9lZVcycVpBbDNwdmV2RkxqcEpn?=
 =?utf-8?B?NmwxLysrQkxha2VINWptQlZNbkhMMVgxVElYUEJwVzlxT1Nya0hCcVpiNVRW?=
 =?utf-8?B?UnB5NXVZeXZvU1Y4YmMrS2xJT1Y1dGxYaXJtdUVidmh4V0pCZWhHdUFqRU1t?=
 =?utf-8?B?RlR6WTRWK3BlNkFNZlloWFc3eG5jTzhVU0gyR1hVY05uUHFWUXp1SUpaUnZp?=
 =?utf-8?B?RCtmRGt6NyswUi9rNHdnSDMxSndIUjdJNlRMZVRSTm9WZjhSWnRSeGE2aHJq?=
 =?utf-8?B?Z0szQTM2MVhQVEg4NktqTTRhLzYraGFQVWJaMkJ3REtYa3FaQWhjUWdxS0l3?=
 =?utf-8?B?Z3JzcDVER01CK3RiVjkxdjMwYTBGTEVUTjBYdGZwaDAzZ2pJTkNqWmdaZG9h?=
 =?utf-8?B?dm9wOENJM29JaDl5SlprWUR2eW8vMVBvdmVNeDNJQTBEZEljN1RQK0JPQWhO?=
 =?utf-8?B?aXBnTVhIWEVJU0pjd0VZTXRGbk95T05pT1RuVlAyaVJvakU5ZVo0djUzTzNY?=
 =?utf-8?B?RHpKWXVFbWxrNUl6WnVuUENXeXhzME4yaXFiN3p6Q0plNkY0RGUwUVhOY2JH?=
 =?utf-8?B?M3RXb1U3UGgvRzRxUjBsM1ZIQ3IyYVk3MGgxcnZmUGNXQzZYVjZZaHU5cHVK?=
 =?utf-8?B?MkUzV1J4UXdjK0YwQ01xa3hBUDhNU1pYZHFKeVVkWnY5U3JYRlR3YzJKcVFj?=
 =?utf-8?B?bkpuWXNSWlRmSE9MZEJsbStmbXoyUlJCek9iOUFtMWgvNnExd0FBME1xWGlM?=
 =?utf-8?B?bXFOdFUyTGVpUW04OUJyQVBFWVU2bkxjODNoMVh2enNzOVlxVlRwekN2Q0dM?=
 =?utf-8?B?dUpwZkJpNWZTTGQ2YVNZS0xOa0p1SVd4SUtGNXJsbW1sSmx4Z3V1cEVTSGxX?=
 =?utf-8?B?a0h1MnJGZWQxcEx4ZXZXNUpYNTZQdDQwS1BnVUZaMy9oL2Q1U05vMHJkZ2sz?=
 =?utf-8?B?WXZBZk5ZY0E1Z2M0cXp6aVhRS3dGSXdHRk0yWWRpWEdtNE5BVVhNSTF6clZv?=
 =?utf-8?Q?kqZpgScCHptbuth5M5c9IanrX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mZeFUW5jwhmdzClW3agruHIS7Zq0m+TcjdaTOJ7Zrb9Bp1pbyPa3zZoTpbfXQWZRfPpWEPgiOgquuMnKX7HZK3hzuT46F7ve5w9IchR6jl171gKfiThd2qYbCO3jEkq2BERcs3fs50TqhEyKjAgkM9YZYMT2NW2c4zuMeKNMH0EeTjMugF0JIozt8D81J/haisyXXmT4+E78JEDoEwuJt7o1dwdr+b1CYuUewuaOr2/pPBTEgKGuy2D3rJJGoByRegdPuVs+cYmX5nZQt32ZZMso8nSWcJWlWrdS/8vRVL41po6Dr7ENazbsWH2SgBEJWV5V4mNbGqsyN8+j9Q9tAQ24jd1EoHRUFuitvGamWgI0/B5hkdHoFFzMR06NEWvvH4FdOO6ybFiXihgik6ZsPVuesxq3zcXxEfhGVu/0OLex9dGk/lXPw0iEBaZoh7zyHT2n3yYonuIjLAUEeEBzYpEr5Gz/1hp8AtaT64JZ0Iox9iDelg7XnSkM080vk+2/Iq9nuCHHInUDS879d46CUGpYurJzYoHA3pryxgktB9jnSK70SuMbJfIQMEf7iHz3QdWkilCNo7flDdAIcrSdUaonW6UUkn/Auv2Ez0w8gm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a6fc4b-b1bd-4b70-34f4-08dc26492128
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:51:11.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnQgsX7eofTiBVRtlM45msov2fgZNl4RGAdlDv8mCCKvSIYfJ06jZVJmhF4GhXnGSegFG+Jf0fLLdGZtJoflPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_07,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050097
X-Proofpoint-GUID: PBKn916vGCuhmsoiG80ZZ8X-fxfpUL8g
X-Proofpoint-ORIG-GUID: PBKn916vGCuhmsoiG80ZZ8X-fxfpUL8g

On 02/02/2024 17:52, Darrick J. Wong wrote:
> On Wed, Jan 24, 2024 at 02:26:42PM +0000, John Garry wrote:
>> Add initial support for FS_XFLAG_ATOMICWRITES in rtvol.
>>
>> Current kernel support for atomic writes is based on HW support (for atomic
>> writes). As such, it is required to ensure extent alignment with
>> atomic_write_unit_max so that an atomic write can result in a single
>> HW-compliant IO operation.
>>
>> rtvol already guarantees extent alignment, so initially add support there.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_format.h |  8 ++++++--
>>   fs/xfs/libxfs/xfs_sb.c     |  2 ++
>>   fs/xfs/xfs_inode.c         | 22 ++++++++++++++++++++++
>>   fs/xfs/xfs_inode.h         |  7 +++++++
>>   fs/xfs/xfs_ioctl.c         | 19 +++++++++++++++++--
>>   fs/xfs/xfs_mount.h         |  2 ++
>>   fs/xfs/xfs_super.c         |  4 ++++
>>   7 files changed, 60 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
>> index 382ab1e71c0b..79fb0d4adeda 100644
>> --- a/fs/xfs/libxfs/xfs_format.h
>> +++ b/fs/xfs/libxfs/xfs_format.h
>> @@ -353,11 +353,13 @@ xfs_sb_has_compat_feature(
>>   #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>>   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>>   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
>> +#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 29)	/* aligned file data extents */
> 
> I thought FORCEALIGN was going to signal aligned file data extent
> allocations being mandatory?

Right, I'll fix that comment

> 
> This flag (AFAICT) simply marks the inode as something that gets
> FMODE_CAN_ATOMIC_WRITES, right?

Correct

> 
>>   #define XFS_SB_FEAT_RO_COMPAT_ALL \
>>   		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>>   		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
>>   		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
>> -		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
>> +		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
>> +		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
>>   #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
>>   static inline bool
>>   xfs_sb_has_ro_compat_feature(
>> @@ -1085,16 +1087,18 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
>>   #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
>>   #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
>>   #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
>> +#define XFS_DIFLAG2_ATOMICWRITES_BIT 6
> 
> Needs a comment here ("files flagged for atomic writes"). 

ok

> Also not sure
> why you skipped bit 5, though I'm guessing it's because the forcealign
> series is/was using it?

Right, I'll fix that

> 
>>   #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
>>   #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
>>   #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
>>   #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
>>   #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
>> +#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
>>   
>>   #define XFS_DIFLAG2_ANY \
>>   	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
>> -	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
>> +	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_ATOMICWRITES)
>>   
>>   static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
>>   {
>> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
>> index 4a9e8588f4c9..28a98130a56d 100644
>> --- a/fs/xfs/libxfs/xfs_sb.c
>> +++ b/fs/xfs/libxfs/xfs_sb.c
>> @@ -163,6 +163,8 @@ xfs_sb_version_to_features(
>>   		features |= XFS_FEAT_REFLINK;
>>   	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
>>   		features |= XFS_FEAT_INOBTCNT;
>> +	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
>> +		features |= XFS_FEAT_ATOMICWRITES;
>>   	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
>>   		features |= XFS_FEAT_FTYPE;
>>   	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index 1fd94958aa97..0b0f525fd043 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -65,6 +65,26 @@ xfs_get_extsz_hint(
>>   	return 0;
>>   }
>>   
>> +/*
>> + * helper function to extract extent size
> 
> How does that differ from xfs_get_extsz_hint?

The idea of this function is to return the guaranteed extent alignment, 
and not just the hint

> 
>> + */
>> +xfs_extlen_t
>> +xfs_get_extsz(
>> +	struct xfs_inode	*ip)
>> +{
>> +	/*
>> +	 * No point in aligning allocations if we need to COW to actually
>> +	 * write to them.
> 
> What does alwayscow have to do with untorn writes?

Nothing at the moment, so I'll remove this.

> 
>> +	 */
>> +	if (xfs_is_always_cow_inode(ip))
>> +		return 0;
>> +
>> +	if (XFS_IS_REALTIME_INODE(ip))
>> +		return ip->i_mount->m_sb.sb_rextsize;
>> +
>> +	return 1;
>> +}
> 
> Does this function exist to return the allocation unit for a given file?
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=djwong-wtf&id=b8ddcef3df8da02ed2c4aacbed1d811e60372006
> 

Yes, something like xfs_inode_alloc_unitsize() there.

What's the upstream status for that change? I see it mentioned in 
linux-xfs lore and seems to be part of a mega patchset.

>> +
>>   /*
>>    * Helper function to extract CoW extent size hint from inode.
>>    * Between the extent size hint and the CoW extent size hint, we
>> @@ -629,6 +649,8 @@ xfs_ip2xflags(
>>   			flags |= FS_XFLAG_DAX;
>>   		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
>>   			flags |= FS_XFLAG_COWEXTSIZE;
>> +		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
>> +			flags |= FS_XFLAG_ATOMICWRITES;
>>   	}
>>   
>>   	if (xfs_inode_has_attr_fork(ip))
>> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
>> index 97f63bacd4c2..0e0a21d9d30f 100644
>> --- a/fs/xfs/xfs_inode.h
>> +++ b/fs/xfs/xfs_inode.h
>> @@ -305,6 +305,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
>>   	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
>>   }
>>   
>> +static inline bool xfs_inode_atomicwrites(struct xfs_inode *ip)
> 
> I think this predicate wants a verb in its name, the rest of them have
> "is" or "has" somewhere:
> 
> "xfs_inode_has_atomicwrites"

ok, fine.

Note that I was copying xfs_inode_forcealign() in terms of naming.

> 
>> +{
>> +	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
>> +}
>> +
>>   /*
>>    * Return the buftarg used for data allocations on a given inode.
>>    */
>> @@ -542,7 +547,9 @@ void		xfs_lock_two_inodes(struct xfs_inode *ip0, uint ip0_mode,
>>   				struct xfs_inode *ip1, uint ip1_mode);
>>   
>>   xfs_extlen_t	xfs_get_extsz_hint(struct xfs_inode *ip);
>> +xfs_extlen_t	xfs_get_extsz(struct xfs_inode *ip);
>>   xfs_extlen_t	xfs_get_cowextsz_hint(struct xfs_inode *ip);
>> +xfs_extlen_t	xfs_get_atomicwrites_size(struct xfs_inode *ip);
>>   
>>   int xfs_init_new_inode(struct mnt_idmap *idmap, struct xfs_trans *tp,
>>   		struct xfs_inode *pip, xfs_ino_t ino, umode_t mode,
>> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
>> index f02b6e558af5..c380a3055be7 100644
>> --- a/fs/xfs/xfs_ioctl.c
>> +++ b/fs/xfs/xfs_ioctl.c
>> @@ -1110,6 +1110,8 @@ xfs_flags2diflags2(
>>   		di_flags2 |= XFS_DIFLAG2_DAX;
>>   	if (xflags & FS_XFLAG_COWEXTSIZE)
>>   		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
>> +	if (xflags & FS_XFLAG_ATOMICWRITES)
>> +		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
>>   
>>   	return di_flags2;
>>   }
>> @@ -1122,10 +1124,12 @@ xfs_ioctl_setattr_xflags(
>>   {
>>   	struct xfs_mount	*mp = ip->i_mount;
>>   	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
>> +	bool			atomic_writes = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
>>   	uint64_t		i_flags2;
>>   
>> -	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
>> -		/* Can't change realtime flag if any extents are allocated. */
> 
> Please augment this comment ("Can't change realtime or atomicwrites
> flags if any extents are allocated") instead of deleting it.

I wasn't supposed to delete that - will remedy.

>  This is
> validation code, the requirements should be spelled out in English.
> 
>> +
>> +	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
>> +	    atomic_writes != xfs_inode_atomicwrites(ip)) {
>>   		if (ip->i_df.if_nextents || ip->i_delayed_blks)
>>   			return -EINVAL;
>>   	}
>> @@ -1146,6 +1150,17 @@ xfs_ioctl_setattr_xflags(
>>   	if (i_flags2 && !xfs_has_v3inodes(mp))
>>   		return -EINVAL;
>>   
>> +	if (atomic_writes) {
>> +		if (!xfs_has_atomicwrites(mp))
>> +			return -EINVAL;
>> +
>> +		if (!rtflag)
>> +			return -EINVAL;
>> +
>> +		if (!is_power_of_2(mp->m_sb.sb_rextsize))
>> +			return -EINVAL;
> 
> Shouldn't we check sb_rextsize w.r.t. the actual block device queue
> limits here?  I keep seeing similar validation logic open-coded
> throughout both atomic write patchsets:
> 
> 	if (l < queue_atomic_write_unit_min_bytes())
> 		/* fail */
> 	if (l > queue_atomic_write_unit_max_bytes())
> 		/* fail */
> 	if (!is_power_of_2(l))
> 		/* fail */
> 	/* ok */
> 
> which really should be a common helper somewhere.

I think that it is a reasonable comment about duplication the atomic 
writes checks for the bdev and iomap write paths - I can try to improve 
that.

But the is_power_of_2(mp->m_sb.sb_rextsize) check is to ensure that the 
extent size is suitable for enabling atomic writes. I don't see a point 
in checking the bdev queue limits here.

> 
> 		/*
> 		 * Don't set atomic write if the allocation unit doesn't
> 		 * align with the device requirements.
> 		 */
> 		if (!bdev_validate_atomic_write(<target blockdev>,
> 				XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize))
> 			return -EINVAL;
> 
> Too bad we have to figure out the target blockdev and file allocation
> unit based on the ioctl in-params and can't use the xfs_inode helpers
> here.

I am not sure what bdev_validate_atomic_write() would even do. If 
sb_rextsize exceeded the bdev atomic write unit max, then we just cap 
reported atomic write unit max in statx to that which the bdev reports 
and vice-versa.

And didn't we previously have a concern that it is possible to change 
the geometry of the device? If so, not much point in this check.

Thanks,
John


