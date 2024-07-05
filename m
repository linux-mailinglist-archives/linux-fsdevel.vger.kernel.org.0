Return-Path: <linux-fsdevel+bounces-23218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B076A928C3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32511C236DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360A16C6B3;
	Fri,  5 Jul 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aOLx7nuI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PPFB+Z7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B216F29B;
	Fri,  5 Jul 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196732; cv=fail; b=jNWyr2noQzVt/qS7Q8zErgJN6A9NafF8nLKHoU1gF+aq3zw0MWvc6/CFxx/6D4aAMoHylN7e6oVTMqu2AmtLcMnU8e2B5/BYlRcS7qrlw0WyNWblMUNBHFF8cSYAmzm9IfaCEW1iNNrVUI0VilMRVadvijUXEQ9yxZOR1s/S7JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196732; c=relaxed/simple;
	bh=72X7PTRWy3+kbA/NNyG09WcUguUnjny8DqhDvZIspGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WnlS4XYJhYOQIcAATFgR5hf91cxh2FGOEV/WPBEnk0sXV5fLqXfzqM2tbajKZ3Hc3ggFaHSy5QG8PFQ9u430z2PekdTL64ww++25Nm85yhUMqyZP2Nsg17ZaqwiRKNr5CrNGTTXFOu60+Q/2ipjrgY4vTuge0ag1AUWToDcrPw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aOLx7nuI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PPFB+Z7X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GNOeY001547;
	Fri, 5 Jul 2024 16:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=BNHVy9AS7vwwOInjOaqv29r2lsO1f2kEuSCbpguTGvI=; b=
	aOLx7nuI1OCl5wuR95FVme96+h9PtJVA9/W8tfF6iFKM0HM05JhKX7on09r/l1Sz
	bmMEAOa+qGzk/FlQPlYdI3aZqLSmeBpO2f+aRqEH3Kyaipr1akRzkHdFL690Ie28
	E69GH4JjiwmTsDsSGZ13QDQg4mWxUzNjO0vSMUZvESDzuKy0+h/a6z8nqRR8JkL9
	L+/q5wfq9MdTIiY9nyIFW9wWdM4TsO9j3lC20pH/DIlC7BWaJyH14jcfffEZKhi2
	IOyD3O0O6T8A5KeejChBkq/VEy1CzmCyl+rG2AjqrqIQc1MypnlitqFOsbLBfYVr
	D5wWaLx/a9PSppdOFLjKYQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacmbcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465EUFw2010894;
	Fri, 5 Jul 2024 16:25:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbjk29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7AEzn/FdIP5p8m/ahPU2k9ZTUESl05AbjToKEwGsAYYWzbV9yXnIx++u/ucv1qJIXsCwTFmqUztrFAf585eOpxPZKnufDKccfK+BqvLa3npUl21SvjuGpYlfLEVgWhfUhBrEPanV87eJDVBGX9X3bKvKBoPctf5nMuyb7sPClhmqt8005yq7jgqFdL4MUCd4wa932owuDmtyz5Z6EJr4ziIEQXJmXhvdOJX0JnDjkCw6fZydjnQ9LARZdYMtUVtKMkMlnCIlzUaScgmKLxANhqdQUnB4WPcCf/SL+7B+3wWdMdxeZ4Gxll4wxYTfcRsl5CGFJ+p9IEgqy4286tVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNHVy9AS7vwwOInjOaqv29r2lsO1f2kEuSCbpguTGvI=;
 b=NfGZjDbF3Fd6AGjA27T1YGgOENkthpik+wEyWlTOocz+c+yuV798GBFrXp7613MUpjRj79lXW31z42caAY6RjSyoZsCjUFymzC/9tarixpVuHqpqF/4Zh42qb8Xrs7h7G3swsz6H89b1hivEgHwadSavEXDDh9UpD9BUNqXSjy6VTOFeF2wC7yHJkhmKw9acrqAEoUErA8+Li3YCDzuaZvUpHmjM+C8UmEjKTQkEbCVTWTX7bQHwbk4yD3Fad1Y9Fa/+AUsRbth+V74VBwImu/kiERkwQZmKDDGoDsSeCS8C7HUjSERZ72QX4bw0oqvxiKwqxoRpCnmuZoDZ9i2sYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNHVy9AS7vwwOInjOaqv29r2lsO1f2kEuSCbpguTGvI=;
 b=PPFB+Z7XB0B23AYWSK6Ah1gUG7z92CbSGAKrqufflQ5Cz9fGSUNFWSgKPKQoh3SARO+y4XRmnnL6/tKcg1X64h1DTyC7CvE/AbFNUH/dIrbghST9QyciAoqIv3fOTDfBfoO4Po3v/jNbJL2tRZNOsbi1rskuUrpWtJxLLkWrQAg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 16:25:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:18 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
Date: Fri,  5 Jul 2024 16:24:44 +0000
Message-Id: <20240705162450.3481169-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:23a::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c4c72e-3653-4d79-9ee2-08dc9d0f0f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TwBQj/r4S0TEb5wr4mzhrsbbr6gv5yXNMQ+1k3+2qgYFSlkQtmTBf6xDnJr9?=
 =?us-ascii?Q?qwG7+c5PkyVvwaueNF7Wlqqvn9tXgJkggP65TqYfxWctgjvJ37MMCG+cINHE?=
 =?us-ascii?Q?DqXET/PL1sJCWhqVv8Kx0Zv7kklMIy4nR04y+gEFM+WLy5bzfajDPlEy90Se?=
 =?us-ascii?Q?a5iiAd+N+KnwsKKLNgRbG/NT7rnuO4j6/MeCWcCtG1tByrvpl1mmzdBGbU4r?=
 =?us-ascii?Q?U9FddMm+8ZSfVJSY19xDxy5avWwBR80X/sYuS2AkeVNJeUbja+9y9yZsc1Kv?=
 =?us-ascii?Q?8SfqQFV30h57Mrtx9LbauNyQ8MDNxwa7BkDLfWXVcY1cWz/9Fyoh74BDhXPP?=
 =?us-ascii?Q?pfdvLpIfnm/RiVmLRDvVKj0iqhZc89+F2jAg4CKEYmbrDVyHxG4iDaJQlRi/?=
 =?us-ascii?Q?fFLvQm0Ni8NKhtuGqk/PgEybjwFiEpZfxIGysX8BdniDUWQb4Z5KKL+Eu/xk?=
 =?us-ascii?Q?C7ZVnv9lECHA8saGw24vr3TCkYtEawdqDqh2lZJP9U82MV+QiNp9hTvnlFzm?=
 =?us-ascii?Q?Tsmj0heh+xC3Xzxj2/3G7giX5igD9mD06h7MAHrH2MPuH0rdCZVpIi6P4BFg?=
 =?us-ascii?Q?oK8j5JDFTNc4MmnxfkWoWe5qTydl6Nexvs8OD8xtNhjIseSEcumyUxqFIfKx?=
 =?us-ascii?Q?cOvz+/WwLG7exgTn6ZR7jzr6tqQpqoAfh2/AMJTpBjO0Kgh4WgkHo4SW/CAw?=
 =?us-ascii?Q?O2wmwhbjmi+Nz9XvAASIVwZKH34IEqLIlXYHsN0hy6KEzJZBGhC9v2Xr/JpT?=
 =?us-ascii?Q?Rzf64F12eWNvFRboC1jVWUOoEifkoMbdSw0+QTPFu/0mj4bcS9OApk9Dp0Wu?=
 =?us-ascii?Q?wsH3s44yoikOaLZqeRBPvTq2OVf9qIdXXtqgDYW7wBtVtWMYI6TeTV+fN7T0?=
 =?us-ascii?Q?Ji8Rf5BU/RnYWg0J11TjJsA17Uj851e0H6A+/ZtcuC955NchMLmkU/cOSzig?=
 =?us-ascii?Q?b8Yj54bSuH2iUipi0iLPSLcsnUHRZqClU6Nrvxnpnfla6xYonviuvGMWsJtE?=
 =?us-ascii?Q?QWO64F8+UDVbskbi2opMAW+brvaUZ4Bvukm17EEdtfnM8Vh/0D9D3WAZxORG?=
 =?us-ascii?Q?A3KnFkaV7vRhxmAMsPo0UuXWlM31vNWt32SA4bhUp1MsYNEMMe2fAloK1Ds1?=
 =?us-ascii?Q?NGjxRePJiMbGzbkCUvaotelkRl3xIyVfE5Hg524Nt6Vhc99rz0MrJsX/XCgi?=
 =?us-ascii?Q?/zMKTwjUchlSY7B9PqkhzlSgrGGTGd58nB29q/4UoMTNQbdfDRvQEMRs3Mp8?=
 =?us-ascii?Q?NHMSPOPDJy8gNx8d27gFPU2L5LMHjIB5mO4I6g4yEh/ewLQW3R7COqtULyXC?=
 =?us-ascii?Q?qqoQo+J+jJt0F6vdDJ+OevBDyVPN7KQANF/hxexZFULHkQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6SNuoMo1WzWgzGp67JmvVgvQJCZiYCF/7jK5CiCEPIh2PFWkK6mE8Lh73kNq?=
 =?us-ascii?Q?v5JLrbHTuk7NQG+seuC0tL7Kl7h7pmOkNgy71RhTFyiwBJxT3t2IlI894juI?=
 =?us-ascii?Q?RHxCfneHXOjjgvzhItOtnBo1O8X+xhWN4MUmVF8L5KiLhxIzw6RslA9q0Bqk?=
 =?us-ascii?Q?7efsDHZC/GfqFaCTlx6nzc+GHHsFnIOV//tRbhPZs/LbSYeEhktaxMLD+p6L?=
 =?us-ascii?Q?c90svI3zMHzM14vQiEjUtA4GPqkc/IZ+FMEWZ/jALQQfp7ymIUBVADyi0Ioa?=
 =?us-ascii?Q?/WLUNQe9dJ137KbZm8LhPkgVTEtgmDtQkJqYoQEYkKJFz/kKr2R1ob7/MH8N?=
 =?us-ascii?Q?TfOtLCw5icrQqru90Qm66lQywnAItqE27rAATgPYi7eKA7bu688zSfAOJPHH?=
 =?us-ascii?Q?laJ4ZfQIZH8+YODQjHg6IDewoL03ZrlIuEOZnIZz2EAZ/273V/wm95gLA3Lm?=
 =?us-ascii?Q?xC5hmKQh/Uccj08VTNiI7u0l738JWoVM+Q39v6iMdfI4e9uroGwOr/FoUE2H?=
 =?us-ascii?Q?S4U2uVAL3NVZqOniB4My11djVxvHgs3iFa6BMOT1hukyRZns5C0G3PwAFqtz?=
 =?us-ascii?Q?Uq8Z0bVwj6XxOiZzszI2hYKP1AXYuXBrjIDPRt33gJ2+brIPZOhAKSi+gqDw?=
 =?us-ascii?Q?8Q2qJCHcsIYy8YWNnNMnI1n6VMciWj0bvOkq42aFGVT11cA9r0wzWd0SE3yP?=
 =?us-ascii?Q?BWK8aLbzKqFQhMTHMtXjRWm3DbGnJdIFnqBGvz+W0yzIJc5Af4uoGGIy8fbY?=
 =?us-ascii?Q?3UzD0k738AQxENJw+R1xw1SEe3+udoDr+g1ffJQ0UFtoCqLRWB7D2aNXipiZ?=
 =?us-ascii?Q?/tREnF2n9Qyk5XLK+8LxDP9ttN85XrDr2MBKlRsfWyCmyNuyuKZaCLNOXNi8?=
 =?us-ascii?Q?zjcRpFnYZITF6G5Vwo3Q7+fJGO+WYEZBXjaFHjmv7ipgdpl1aDzF0B97SJ9q?=
 =?us-ascii?Q?ySADb+vbv7AN7OSayX2DJw0cGmmjqs94dxo+ogBFVEWmm1qf971dcR0fBeoQ?=
 =?us-ascii?Q?R86Y6XW867X3OiApwYcbUGzQEqEkPx0bVw0tSdaHy0dvsIIOi5lydJSNbq1U?=
 =?us-ascii?Q?YpCjqZ17L+qiD/r6razLPiQ3d2YM/ciFAIyO8NLdqm1xB47UyGl3izGOcwdq?=
 =?us-ascii?Q?/s+zyi3djWIrlbZQZry2NSbrJ1fiMXkS6tTGSFU40BrjOuKBbAhCwFythVb9?=
 =?us-ascii?Q?YCGfN4jBOAyoYPyk5C4ToACLpEUte6+VAIRqjM2EegxKVGdGP/B+ffvn1V7V?=
 =?us-ascii?Q?JPeGFNANjivxLtWIOjcpD6HRN/VhJsDwV7/xplOIa9x/vC3/n+s8jQfSzjU9?=
 =?us-ascii?Q?yRRLFkz08tcs0Wo6C22Werd65LfH9k5ELBNtS+76FXptLp5O3uITphnI4usT?=
 =?us-ascii?Q?t8r73Rxk/H+v82kNYoOhQWvYjhmFzImvNX1TYeCn3hlfifBioxMJM6DzkRAC?=
 =?us-ascii?Q?5zZitV2rwAu+DydoJ7nLQnngetuh7Dj9KCh17LnD3hPb81dHJzcVqrU1lM7o?=
 =?us-ascii?Q?c4HlgTmbeswTkQ4ApM1O7D7+Y/pDr6hjM05NPil+P1YKt/uzvvQM89aHTNVw?=
 =?us-ascii?Q?CD+NcqRNMxTlBnQ9SYhfW66f4Pu9LvtJZMo3t/dYG2bgjZAod1DsEZkGqbMZ?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kC5z/Y6cAAHBpApuuXiU3E+UrmhJZ1JlBZPpJgqTRa7RjyGpqqjxAKNrmKcMu9A+gzo2C/amWST9vVEQ8oPo/OX5a+/rpVyn32/2yUPx2rGjYtH7nXMakkQobOvCXQSH8ov6XevrXjHijbhzyagkh0YI0Vvbh4PikACoFFzKiHRajjAC9S9Rt//WQ0xAGqXxOrjxtPfJa2noxS1vnGqw705Dg1nBQbbPDb2E+Yq+ZFEpOmb0EHP1cjtHsVz1RbDR+ygGlbpMnwAwADDuRLRboidEO4ysNhjt9L1xQNAfbZM0vl7W5hZD2uA8KWOqqnLcYTpWgtgg3jjZ9RDEQSE2gMMCv6FU3pI2MJQAsoiqzKyp8jKCkdyJH3n8dbixnysFE3aNp6EnRLHo+2WAo/XFx9R4d0QajxPWSmIdIuMxh8+t+9UtENSco0XE8mapuxhPFG8UEd1AL54t7t0AFCaTyddUkc+5eQmKLnKVC1g8lsC/bXhkm2RMneUq5NdR7PvmXpR1cX2dT8zJv/JZvCzO8m3j6QovGGichByGokwa3TOvs1TzTCKnXE5OSjORzCM8+R3AiOz9cGvFn2g9yHV5AopQiE3ewOEN7lA1C6qoSBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c4c72e-3653-4d79-9ee2-08dc9d0f0f00
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:18.2681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgKYgZd/4hPBeHmI1qszfqwV8+ulFujmgNZ3b7eLFxdYLEw2K3NGAma1NxaBSTm6XCdkI0lYgrwKflXgR4TQeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050119
X-Proofpoint-GUID: t7vc8yu7igjGDYBx3H-bLu2_CXziki1w
X-Proofpoint-ORIG-GUID: t7vc8yu7igjGDYBx3H-bLu2_CXziki1w

From: "Darrick J. Wong" <djwong@kernel.org>

Add a new inode flag to require that all file data extent mappings must
be aligned (both the file offset range and the allocated space itself)
to the extent size hint.  Having a separate COW extent size hint is no
longer allowed.

The goal here is to enable sysadmins and users to mandate that all space
mappings in a file must have a startoff/blockcount that are aligned to
(say) a 2MB alignment and that the startblock/blockcount will follow the
same alignment.

Allocated space will be aligned to start of the AG, and not necessarily
aligned with disk blocks. The upcoming atomic writes feature will rely and
forcealign and will also require allocated space will also be aligned to
disk blocks.

Currently RT is not be supported for forcealign, so reject a mount under
that condition. In future, it should be possible to support forcealign for
RT. In this case, the extent size hint will need to be aligned with
rtextsize, so add inode verification for that now.

reflink link will not be supported for forcealign. This is because we have
the limitation of pageache writeback not knowing how to writeback an
entire allocation unut, so reject a mount with relink.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Co-developed-by: John Garry <john.g.garry@oracle.com>
[jpg: many changes from orig, including forcealign inode verification
 rework, disallow RT and forcealign mount, ioctl setattr rework,
 disallow reflink a forcealign inode]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h    |  6 +++-
 fs/xfs/libxfs/xfs_inode_buf.c | 55 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h |  3 ++
 fs/xfs/libxfs/xfs_sb.c        |  2 ++
 fs/xfs/xfs_inode.c            | 13 +++++++++
 fs/xfs/xfs_inode.h            | 20 ++++++++++++-
 fs/xfs/xfs_ioctl.c            | 51 ++++++++++++++++++++++++++++++--
 fs/xfs/xfs_mount.h            |  2 ++
 fs/xfs/xfs_reflink.c          |  5 ++--
 fs/xfs/xfs_reflink.h          | 10 -------
 fs/xfs/xfs_super.c            | 11 +++++++
 include/uapi/linux/fs.h       |  2 ++
 12 files changed, 164 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 61f51becff4f..b48cd75d34a6 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
@@ -1094,16 +1095,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define XFS_DIFLAG2_FORCEALIGN_BIT 5
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 513b50da6215..5c61a1d1bb2b 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -657,6 +657,15 @@ xfs_dinode_verify(
 	    !xfs_has_bigtime(mp))
 		return __this_address;
 
+	if (flags2 & XFS_DIFLAG2_FORCEALIGN) {
+		fa = xfs_inode_validate_forcealign(mp,
+				be32_to_cpu(dip->di_extsize),
+				be32_to_cpu(dip->di_cowextsize),
+				mode, flags, flags2);
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
@@ -824,3 +833,49 @@ xfs_inode_validate_cowextsize(
 
 	return NULL;
 }
+
+/* Validate the forcealign inode flag */
+xfs_failaddr_t
+xfs_inode_validate_forcealign(
+	struct xfs_mount	*mp,
+	uint32_t		extsize,
+	uint32_t		cowextsize,
+	uint16_t		mode,
+	uint16_t		flags,
+	uint64_t		flags2)
+{
+	bool			rt =  flags & XFS_DIFLAG_REALTIME;
+
+	/* superblock rocompat feature flag */
+	if (!xfs_has_forcealign(mp))
+		return __this_address;
+
+	/* Only regular files and directories */
+	if (!S_ISDIR(mode) && !S_ISREG(mode))
+		return __this_address;
+
+	/* We require EXTSIZE or EXTSZINHERIT */
+	if (!(flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT)))
+		return __this_address;
+
+	/* We require a non-zero extsize */
+	if (!extsize)
+		return __this_address;
+
+	/* Reflink'ed disallowed */
+	if (flags2 & XFS_DIFLAG2_REFLINK)
+		return __this_address;
+
+	/* COW extsize disallowed */
+	if (flags2 & XFS_DIFLAG2_COWEXTSIZE)
+		return __this_address;
+
+	if (cowextsize)
+		return __this_address;
+
+	/* extsize must be a multiple of sb_rextsize for RT */
+	if (rt && mp->m_sb.sb_rextsize && extsize % mp->m_sb.sb_rextsize)
+		return __this_address;
+
+	return NULL;
+}
diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
index 585ed5a110af..b8b65287b037 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.h
+++ b/fs/xfs/libxfs/xfs_inode_buf.h
@@ -33,6 +33,9 @@ xfs_failaddr_t xfs_inode_validate_extsize(struct xfs_mount *mp,
 xfs_failaddr_t xfs_inode_validate_cowextsize(struct xfs_mount *mp,
 		uint32_t cowextsize, uint16_t mode, uint16_t flags,
 		uint64_t flags2);
+xfs_failaddr_t xfs_inode_validate_forcealign(struct xfs_mount *mp,
+		uint32_t extsize, uint32_t cowextsize, uint16_t mode,
+		uint16_t flags, uint64_t flags2);
 
 static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
 {
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 6b56f0f6d4c1..e56911553edd 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -164,6 +164,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
+		features |= XFS_FEAT_FORCEALIGN;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index a4e3cd8971fc..caffd4c75179 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -609,6 +609,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+			flags |= FS_XFLAG_FORCEALIGN;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
@@ -738,6 +740,8 @@ xfs_inode_inherit_flags2(
 	}
 	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
 		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
+	if (pip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+		ip->i_diflags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	/* Don't let invalid cowextsize hints propagate. */
 	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
@@ -746,6 +750,15 @@ xfs_inode_inherit_flags2(
 		ip->i_diflags2 &= ~XFS_DIFLAG2_COWEXTSIZE;
 		ip->i_cowextsize = 0;
 	}
+
+	if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
+		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
+				ip->i_extsize, ip->i_cowextsize,
+				VFS_I(ip)->i_mode, ip->i_diflags,
+				ip->i_diflags2);
+		if (failaddr)
+			ip->i_diflags2 &= ~XFS_DIFLAG2_FORCEALIGN;
+	}
 }
 
 /*
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 42f999c1106c..536e646dd055 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -301,6 +301,16 @@ static inline bool xfs_inode_has_cow_data(struct xfs_inode *ip)
 	return ip->i_cowfp && ip->i_cowfp->if_bytes;
 }
 
+static inline bool xfs_is_always_cow_inode(struct xfs_inode *ip)
+{
+	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
+}
+
+static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
+{
+	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
+}
+
 static inline bool xfs_inode_has_bigtime(struct xfs_inode *ip)
 {
 	return ip->i_diflags2 & XFS_DIFLAG2_BIGTIME;
@@ -313,7 +323,15 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 
 static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
 {
-	return false;
+	if (!(ip->i_diflags & XFS_DIFLAG_EXTSIZE))
+		return false;
+	if (ip->i_extsize <= 1)
+		return false;
+	if (xfs_is_cow_inode(ip))
+		return false;
+	if (ip->i_diflags & XFS_DIFLAG_REALTIME)
+		return false;
+	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
 }
 
 /*
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index f0117188f302..771ef3954f4e 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -525,10 +525,48 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_DAX;
 	if (xflags & FS_XFLAG_COWEXTSIZE)
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
+	if (xflags & FS_XFLAG_FORCEALIGN)
+		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	return di_flags2;
 }
 
+/*
+ * Forcealign requires a non-zero extent size hint and a zero cow
+ * extent size hint.  Don't allow set for RT files yet.
+ */
+static int
+xfs_ioctl_setattr_forcealign(
+	struct xfs_inode	*ip,
+	struct fileattr		*fa)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (!xfs_has_forcealign(mp))
+		return -EINVAL;
+
+	if (xfs_is_reflink_inode(ip))
+		return -EINVAL;
+
+	if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
+				FS_XFLAG_EXTSZINHERIT)))
+		return -EINVAL;
+
+	if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
+		return -EINVAL;
+
+	if (!fa->fsx_extsize)
+		return -EINVAL;
+
+	if (fa->fsx_cowextsize)
+		return -EINVAL;
+
+	if (fa->fsx_xflags & FS_XFLAG_REALTIME)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
@@ -537,10 +575,13 @@ xfs_ioctl_setattr_xflags(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
+	bool			forcealign = fa->fsx_xflags & FS_XFLAG_FORCEALIGN;
 	uint64_t		i_flags2;
+	int			error;
 
-	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
-		/* Can't change realtime flag if any extents are allocated. */
+	/* Can't change RT or forcealign flags if any extents are allocated. */
+	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
+	    forcealign != xfs_inode_has_forcealign(ip)) {
 		if (ip->i_df.if_nextents || ip->i_delayed_blks)
 			return -EINVAL;
 	}
@@ -561,6 +602,12 @@ xfs_ioctl_setattr_xflags(
 	if (i_flags2 && !xfs_has_v3inodes(mp))
 		return -EINVAL;
 
+	if (forcealign) {
+		error = xfs_ioctl_setattr_forcealign(ip, fa);
+		if (error)
+			return error;
+	}
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index d0567dfbc036..30228fea908d 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -299,6 +299,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
+#define XFS_FEAT_FORCEALIGN	(1ULL << 28)	/* aligned file data extents */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -385,6 +386,7 @@ __XFS_ADD_V4_FEAT(projid32, PROJID32)
 __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
 __XFS_HAS_V4_FEAT(crc, CRC)
 __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
+__XFS_HAS_FEAT(forcealign, FORCEALIGN)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 265a2a418bc7..8da293e8bfa2 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1467,8 +1467,9 @@ xfs_reflink_remap_prep(
 
 	/* Check file eligibility and prepare for block sharing. */
 	ret = -EINVAL;
-	/* Don't reflink realtime inodes */
-	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
+	/* Don't reflink realtime or forcealign inodes */
+	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest) ||
+	    xfs_inode_has_forcealign(src) || xfs_inode_has_forcealign(dest))
 		goto out_unlock;
 
 	/* Don't share DAX file data with non-DAX file. */
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 65c5dfe17ecf..fb55e4ce49fa 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -6,16 +6,6 @@
 #ifndef __XFS_REFLINK_H
 #define __XFS_REFLINK_H 1
 
-static inline bool xfs_is_always_cow_inode(struct xfs_inode *ip)
-{
-	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
-}
-
-static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
-{
-	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
-}
-
 extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
 		struct xfs_bmbt_irec *irec, bool *shared);
 int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7..4f0c77f38de1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1721,6 +1721,17 @@ xfs_fs_fill_super(
 		mp->m_features &= ~XFS_FEAT_DISCARD;
 	}
 
+	if (xfs_has_forcealign(mp)) {
+		if (xfs_has_realtime(mp)) {
+			xfs_alert(mp,
+	"forcealign not compatible with realtime device!");
+			error = -EINVAL;
+			goto out_filestream_unmount;
+		}
+		xfs_warn(mp,
+"EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
+	}
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 45e4e64fd664..8af304c0e29a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -158,6 +158,8 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define FS_XFLAG_FORCEALIGN	0x00020000
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1


