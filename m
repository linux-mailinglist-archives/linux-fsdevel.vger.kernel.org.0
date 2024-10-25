Return-Path: <linux-fsdevel+bounces-32889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E50F9B04FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF4BB238A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 14:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2501F757E;
	Fri, 25 Oct 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gZBA5DOE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TH/55m8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CDC212189;
	Fri, 25 Oct 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865078; cv=fail; b=tl2scPAJHVq1EIV6mfpqDwu7cSy/nczV06myr2XY1k+yAvtZGlp1YH/xoTF9y5zv7MO4MB0AOCAitnzxPi5O33iKpNCUSqdjsCD2zUvVocVYR1FXR7RKAiUTSW5H4lpKxyHW1zyGpiQLzT4mIQ5CibnEq9NV/4E7IChDk6nNKkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865078; c=relaxed/simple;
	bh=Fad3QK1UgtgpJhIpz2XWYlajLfLs86yJf2Jq7i1VTGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GUbGG2Q1pNdZcuHSNoLc/j0vKCNy1ofj5hWVVGnwCwntDw0GPI8mppy/EyXx7ZGaU1T5jmqXaq9yQXaY/ETFYkjcwPBNUw+PY3b4haIuMVG2HgQzMkygtwZi95LQJKke7eMgUhKBpNmsa+P1fjp6TQAG5WZbgIWPQdyT5Vt9BMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gZBA5DOE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TH/55m8B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PDhYwh008578;
	Fri, 25 Oct 2024 14:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GZZEAPd7siL6cpP3PgvpnB5Ami3v60NUwe7e9cGbePs=; b=
	gZBA5DOEkU4b3JTT8ESajexVRlL/5Rj5mV1c68CY8tOrMLoC+JZG1w0otHLoaKgt
	7ys0zDRFaryDG+2bcfDqeH9ty+/FtDe0HGUDMN4Q71V+3CwVRJ6PqCuWmYasPNvq
	CHbmkbh7P+4WFNBRDKRrPHHC74qWmnzTfTjEBvlJXzf6/wpfjfeuxoPIZEf8TWwS
	/NojIREePYVUKuONM9aeHPuQlbY4iCoFuUpMcJgKOQoWnbAkppLTDHg2hLIldPgO
	mMhomRFn7ZKltHCyz6gBOcXdF8UveQA/Trb28hSBeO0CQ1trv1S0cXeoGuutpMS1
	XYPHZEodSRgTXmHZpkbiLg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c545d4wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 14:04:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PC7VGR015872;
	Fri, 25 Oct 2024 14:04:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emhcaxmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 14:04:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLZXCKTDxYHXzx7APRqOxWOW/qtEjXNZNWyDXf3re1yo/v3w+fr99vCLSAZYHSNQSDgE9pvcYxXoMMb5b46Sb7oh2Rv943a3EaV5PdHiMykT/CMs5dj/2aiuErHgUAoWTGQOFRggo66cU6rnVKxQWUWWzlTAKS5CNKL5DBm8Io7rwOjxduob3uag+iKU5XDU2abhab6QVhW5AIo9w0803ync1D7r9sXwGt4md64dn7638n2dhBKM5WIzGy2l/arysD94saSCPE98547FVsl3/AEQpctmZWXA3jHRdtJtWdAbc/edL5MFqrn0BTwbKvfGATjTmpQDBp1jpzvQh3oYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZZEAPd7siL6cpP3PgvpnB5Ami3v60NUwe7e9cGbePs=;
 b=f3ZZ1Jo8YOO3SrjF63DXJ13lqK5Zxgyzg910ZI2ynAJ2h8PcVaYf3LiDslhhSXGlVBdsCKHlCWgCJpkgZ6znjRnt+E/ySpDN5wESW7wuCpghoro1vYlxTAnubXpB5iDabY3Yo+5FIHLFWfHGg2ebSoBP0yuGnYt6jKhrql5inFDoHRna5mQuycA6aRJshfboZxd9m38z+hcn96sGSVa+tznq6pDrX7BL/2J+QyiKki6CkbRf7Rcd8rjTc+wWxagiBQWlm2Pj+Pa1Fx20ipZCk2Ifuchju3o1QCyLdP26vualVPlx7NLJuOJ+vQu+9vZWJFWFdhTuMAYEDm4BkyH8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZZEAPd7siL6cpP3PgvpnB5Ami3v60NUwe7e9cGbePs=;
 b=TH/55m8B60ZReejWflwShpZmPg9V3c4LUt50BbdpbmanFzzzwYJl1lLbl5SMwogYh9FIxy2Ce5JqmH9lb0MuXmx67PK/RPth7axAqyHP/Xo2x+InK9TLgMVkLYMvEsuPIpikvABHfEacTFtS2zRZ4Y+RbwFTy/x9Ww0kUjbmfsk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6740.namprd10.prod.outlook.com (2603:10b6:610:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 14:04:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 14:04:18 +0000
Message-ID: <509180f3-4cc1-4cc2-9d43-5a1e728fb718@oracle.com>
Date: Fri, 25 Oct 2024 15:04:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com>
 <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com> <87zfmsmsvc.fsf@gmail.com>
 <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com> <87v7xgmpwo.fsf@gmail.com>
 <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com> <87ttd0mnuo.fsf@gmail.com>
 <7aea00d4-3914-414d-a18f-586a303868c1@oracle.com> <87r084mkat.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87r084mkat.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0036.eurprd03.prod.outlook.com
 (2603:10a6:208:14::49) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa1532e-685e-4057-93f6-08dcf4fdea8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHVqL3Q3bHhjbDd6TEtmc2ZYY29QakRtTGEwTzR2MXFiUGJVa1MvejBuY2VV?=
 =?utf-8?B?Z1NaODdQZnowUjJUQjgyWURwVDZ2OGM5RkRjazlrcnBjczc5ZEIyTXM5UXhR?=
 =?utf-8?B?TU5ra2dpem1VeGJCQmJRZkFoU1c0OTJYckwwVjlPa0xNOVpmVEt0NnIxSHkz?=
 =?utf-8?B?NUgzc1NzWGJRSWU4QU9EQkI4KzIyNzBQblhBRFcvYktFU25zNkFKcGdmKzAx?=
 =?utf-8?B?SW5NVExrN3hLY0JZNWJWOWN0OG9IK0FOalo1d1QrZjk5ZklWazM2WUpqRldh?=
 =?utf-8?B?aXpweE5yNlMzUEVoQTA1bDFmQTd1WHcvem1yV2NyR0JzdEJhRWJHWHJpY1dy?=
 =?utf-8?B?THNKT2FhSlFmU1VUU1p4YTdYTDgrTkVPTEY4c1RKU2J4UDYrdExpSnpsbEZy?=
 =?utf-8?B?MVJHd0J5Mk5vdHFESUhCa3FnR2lxeXBTdzF2cThBUnEvd0MxKzV6cmpOWjdN?=
 =?utf-8?B?NVB5RStQdjhmMzRtVFRhNDdmVUhvUkNydFQwOEtsbDBXbmJUVVlNQ25NbU4z?=
 =?utf-8?B?SHl2dm9hY2tFTjNLUGtDSENPbCtUdmNoakNQdGNEMFVXTGtCRVNWWUlZc3Vl?=
 =?utf-8?B?dWIzMEt1TDRxenRPL2VuREV4bWltN0h5VS9pNUJ4dDNTNndHdjlyeFRnVWI3?=
 =?utf-8?B?UFVtZVYrM3NXYTd4YUZVeUs2VTA0V2xUeENpMlRhN3VkVXdVWDNEaHBVbnhj?=
 =?utf-8?B?MkZyQUY5VjVnZ3NadkFCQVc5ODRHMlJKS0Z4ak1HSVNwdGdSdUQzMGVWZmhl?=
 =?utf-8?B?QWlFOElnZjU2VHN1c3k5VDVTTjFjZjBpbVR1bFNRakkwQlZVZXYvSHdDVDh3?=
 =?utf-8?B?SVY4Z1g1WUJMbXlVeXRYVFBCQzBWcWc0ZHhPcmVKT0tEWHY0NXNwdkhJbmJG?=
 =?utf-8?B?TVJCMGtmUEx5d1ZNeGZCNVJocUhoSFdXYklwNEFmckZYWmVPRHlzQnlPZDRM?=
 =?utf-8?B?aEFxZnJWeFVOblplM1p6L1U2NmVkNnNXaEdjbmNQVWYrS0VnbDBtbjYwQlph?=
 =?utf-8?B?ZktLVnRzYlh4aFZ5WXJtVjdjeWJQOEpERzlWdkR6ckNxbFdDUnFRamhFZXM2?=
 =?utf-8?B?dUJHWTNiRldPQ0tVckF3alNOd1BQSVJoS3BBRGYwUkhGZHpPOUtnc0hXQ25X?=
 =?utf-8?B?TmIwWmUxaThBcTgxOWFjWDMzeitIV1dBemFpMXBTNmppQmQ4ckNabDhPTnYv?=
 =?utf-8?B?ajMzeUxxdjlpTyt6elpBd0NJVkNmK0pHNS9iRUUwR2hqUzBDaXdWVjZQdXh5?=
 =?utf-8?B?dUpXSE1YelViSHRIMmZIcWI5NDJaOTFjL0o5WXNRSUs5SHlQYS9kVVJ6SGNP?=
 =?utf-8?B?cTRsTnRqZEEwc1JmbWF4SkZDQm5DOGJISm9lbGRIdWxSa2tyVnI4LzBtdnVF?=
 =?utf-8?B?ejVBVVJLMStySkgvemtxeXJnd2FQUFZvWklLaUw0bDFIWUpKTUxhazFoditK?=
 =?utf-8?B?SjdUTFEwWHUzVGZiZXQzNFVLeG5VVWsrSkFqN2dQM1MxNndZZHhXdHVIZ1hD?=
 =?utf-8?B?TkhQR1lkN0RCWjhhMzRIamNNVnBna3RndXZ2MkFQb0VZSW13cDN5U2hEb0Jt?=
 =?utf-8?B?Rk5HLzFQaXRxbXp3QmszcXl5czU3YThTem1Sa2owempjSWNrTVVoc282NDJ5?=
 =?utf-8?B?RHJYWUt5MWhZMkJkQitBajhrUSt0Ni8xQVNQMXJYN0h0S0hBeGoyV3BPVXhk?=
 =?utf-8?B?ZjVIQzh6cTJxZEhTR28wLzMvL2hLTjZLK2JyK2ozNFB2blN2TmwwazJEbXNZ?=
 =?utf-8?Q?l+WaUPprPrjfPnq/UjQvc7q01TdGhHRylUa2f7u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkpvbG0rUTJFRDE5dkE4Y0srd1VZOFdkdkFqTkI3SlRJQnZtL2dwdHZZU0JN?=
 =?utf-8?B?RTFrdWFlOWtSY1BiTGFseWNaOGRGeTd1KzJRUzUzczM2UGFTNnNQRGJuWEtE?=
 =?utf-8?B?SXUvaHJzMll4dHlrWU44UVNnSWl0STEwbjFsTEJMWVlUQ01UQllodWFxQzZ0?=
 =?utf-8?B?dUFCOG84Rm1MKzIxTjIzN21DTU01Tjh1L0gvT1hQRUwyanVBaFpDN2MybkRX?=
 =?utf-8?B?OHZYc0xLbEVHdlJNQ3lZaDRwV3lmR3FaUjhPZXdzdmY0Q2RwTHI0L1VmNHRi?=
 =?utf-8?B?NlNQaUU5ZHB4TVZSZ1pDMDBDYU85d25zYXd3ZTdKNmhBY05iNTVKSHFPVjV3?=
 =?utf-8?B?dE1HQ1N2Vy9WOWhiSFhLUVVJaHdwNXFGaGZaYjZYRVMyM0tDV1hhbFRyQVQz?=
 =?utf-8?B?LzA4SE9yRGl2M2hTQjdTZDBTL2EwdmZmSXdwWnA5SEpIeXhwZEVjUkppSUM2?=
 =?utf-8?B?NVpKNVZidUttYnpVNCtaQmpPZUNkcEZBcU5vbEt5Y084amJmR1dmVUl6czFo?=
 =?utf-8?B?ckhMcmhEV3pyWjN2VzZTY0lnSEpLZlpPSWNINGhZMWVVRmZZbXZCbW9vUSs4?=
 =?utf-8?B?V0dab0dkTDlHVHlHVkI5cHNTdnhXczFsTUwrcExiNFZJUkdOSjhBaFIxcG5N?=
 =?utf-8?B?SGxPdWZvREE1VXVxZEFVVlVPRDBLUGhDRzV1ZUtTSTZXa1BCb29DOVl6RTcx?=
 =?utf-8?B?Rk9oNms3SUQrQUFrYnJNdVpBYmFKY3NWOUZxak1OWTIwUFNRN3p1UlNpTUtl?=
 =?utf-8?B?RDlhOFozMjZZZXRKNEY5SzByU2dvd2JPR3NlRnJoODIwODVNTjZKdWZrOFQ1?=
 =?utf-8?B?aUtkNm9FcEs0eFUrU01jY0FscWI3aTNkeTZ2aUZsbG9PUWgwaC9ydFl1ODNK?=
 =?utf-8?B?TFB6bTF4RWpWTVN6aHRVU01ZTHdPRmZza0ZFdjA4WEpaZW1PbUVGQXhLNVEx?=
 =?utf-8?B?aVJ2cjA4REw4bGNxcnIvWFdDTDNGY2lUWjdzSGVWUGd3Zm04NGpuOWU0UU8y?=
 =?utf-8?B?SCt2MkJFOXN0TW8rWC8rd1RXRGhQa0hETHVVd09XdTU4UHV5aDh4VEM2V01X?=
 =?utf-8?B?UWxDZ1JiWEdzazlOQ215UjEvby9uK0l5bEJhK2JONkdFZFRvZTl6a2xsN3p6?=
 =?utf-8?B?VTBjUWpSUlNsQnlBUC9rVzhtMktzblI3bnhuMU1MV0QyVWxNODgvN2lzc0xV?=
 =?utf-8?B?VWRzell3U2p1ZEpjRGxXd1dEZnlsNVI3enYvMktoTVd6Nmt5NVpITVRLdHpq?=
 =?utf-8?B?T25aMWhnT1h0WTdEM3NDbDlnQWlXQVZndFRBZUFuYkt5NUVzUis5RXhSOExR?=
 =?utf-8?B?Sk9HcnVybnZKdTBGMUh0WUloVnlucTlzSFF6b2NLVExUY0dEZW0zSU13R2Jy?=
 =?utf-8?B?QVd6RDIxL0YvcVZTRU9kQWplaUhaTmt4Um96aTd4QVc1bWdhNExBQ21qSGhO?=
 =?utf-8?B?SjRyd0RUSDB3ejBkU3BkaWx1TDV2Slo4T3c2SmxwSko0SGhlcStxNWFiL2Rq?=
 =?utf-8?B?SGJHb2ZMRCtVcDd2Y3FYbC9zTHIvVlVnbFd0Z0wxc1BlYm5KeGVpQnlZSlFh?=
 =?utf-8?B?cFdzQ1hqTlQrSlJLRTVwWCtCZlRiM2lTKzR1OUNWQStDZjkydFBReGJHY3BY?=
 =?utf-8?B?MlZsTjNzR2JjRjQ0d1gvdzRXa0x1UWs0MXJuSnQrME5EVU11Wld5TWxZZUpm?=
 =?utf-8?B?b2lBWXkxdjdVMlpFYW8rcHpMUGlHeGdjbHozekZVMVBwZmZqM1ZzVkJxYVoy?=
 =?utf-8?B?QXBDY3U4MFB1cGFPOCtwbFc2OHJQVmR0VjlVeXUyQnZvcktrNlAyS1B4eDBq?=
 =?utf-8?B?eFZBVzcvVi9mdkR3US95V0psVEpCMFhENGxvQkthVWdQZmNiMUQ0ZFNtS0dQ?=
 =?utf-8?B?emF2Rzd0aHNjUjgrdlNiRHZ2ZGlvYTJSeXlidmhYZjIwUUlzd1JhcndsTVJp?=
 =?utf-8?B?UzlNZjJSMW1IT21rczUzWStZY0pFZUN0eU15QzVLNGQzNU84MUpobFp3aW1i?=
 =?utf-8?B?cUoxMUZaQVFzS1hRd1lDZmkrcEhtUDFJWHQ1WjNOOUh1VEtWbUk3eXNGQWhC?=
 =?utf-8?B?bmZoanFZY1RKUi9PL0JJMGZ2bTdwZFMzNlNpYXJ6dlh5ZGFYYml0U003bkNl?=
 =?utf-8?B?bTFhSEhCOHpZdktPOHg4Ylp5a1A2T0YwV1JXSE1va2xuaUR0VFlkK2ZBRW0r?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P44OCm9I0O/xaFTx7fIqAqCGSGn85ElpPyP785p7p6nBuE1rbt46Y4r5QGTaTJxw9zKESdA52xwRkjPbiEMnX/hysZhthc4uKzNiPOG3ml60Pe1vVMNt1dHpgJvAhIh3MrBxB30LaUOAGToAVcnKNKfU66/8uSRdCrbFMnLFF0mrAA8TYRdoW8ixDn5K6GqYVEj5c397UGV9lLX2BSaRVvTox1kaV/TzJm67b5RumwVs+EJjOUL632B/ouvxOgHQ+d/Pz8z8tquFlDoy6GmduTeq9AdiJMx9i4Viy19H4h4fjr90rediOK0Akgbzxe62bzUGfj3/TZOmSql6Jhtml5Gwl0c2GjrCzmryHQ5Y4J1AWM41K0iaz1bWesV/e0GXLW4EJ1QsmkzA0PwFJPtwKESrvzT3nmouSj9A4JACrjiOPSyRZIoclW12VPyC9IyB7Y+ozYKgmXyckxWaCYuiecQF//AGiYLeEszkcNQOKfUJcQGqhEcSCEb7Tj8d7sbypRCeGQva/9WugCFv7qkmj0txLp3Iwo+aORBJOyIZF5la7D2CvMfHWrPrFWZsQgsEt7VizqxdzUP2QeQIjH6kcP5h1SmaKQf6RxT09SwIUBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa1532e-685e-4057-93f6-08dcf4fdea8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:04:18.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Me0aiyWBhHJp+6enc7vlp7CiwTBfeM48359IKoLvMoTQbebE5CMEOaihkf/v8NOuOef6w9sYOoavxhYnnQs1zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250109
X-Proofpoint-ORIG-GUID: Ae8PCnIHZ6JI8Q5SFAwXprFajgBaATAf
X-Proofpoint-GUID: Ae8PCnIHZ6JI8Q5SFAwXprFajgBaATAf

On 25/10/2024 13:36, Ritesh Harjani (IBM) wrote:
>>> So user will anyway will have to be made aware of not to
>>> attempt writes of fashion which can cause them such penalties.
>>>
>>> As patch-6 mentions this is a base support for bs = ps systems for
>>> enabling atomic writes using bigalloc. For now we return -EINVAL when we
>>> can't allocate a continuous user requested mapping which means it won't
>>> support operations of types 8k followed by 16k.
>>>
>> That's my least-preferred option.
>>
>> I think better would be reject atomic writes that cover unwritten
>> extents always - but that boat is about to sail...
> That's what this patch does.

Not really.

Currently we have 2x iomap restrictions:
a. mapping length must equal fs block size
b. bio created must equal total write size

This patch just says that the mapping length must equal total write size 
(instead of a.). So quite similar to b.

> For whatever reason if we couldn't allocate
> a single contiguous region of requested size for atomic write, then we
> reject the request always, isn't it. Or maybe I didn't understand your comment.

As the simplest example, for an atomic write to an empty file, there 
should only be a single mapping returned to iomap_dio_bio_iter() and 
that would be of IOMAP_UNWRITTEN type. And we don't reject that.

> 
> If others prefer - we can maybe add such a check (e.g. ext4_dio_atomic_write_checks())
> for atomic writes in ext4_dio_write_checks(), similar to how we detect
> overwrites case to decide whether we need a read v/s write semaphore.
> So this can check if the user has a partially allocated extent for the
> user requested region and if yes, we can return -EINVAL from
> ext4_dio_write_iter() itself.
 > > I think this maybe better option than waiting until ->iomap_begin().
> This might also bring all atomic write constraints to be checked in one
> place i.e. during ext4_file_write_iter() itself.

Something like this can be done once we decide how atomic writing to 
regions which cover mixed unwritten and written extents is to be handled.

Thanks,
John


