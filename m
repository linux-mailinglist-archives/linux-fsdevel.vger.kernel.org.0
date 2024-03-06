Return-Path: <linux-fsdevel+bounces-13729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4CA8732C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421B81F253CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDCA5EE63;
	Wed,  6 Mar 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KI2v4MMU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AoSynode"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B05DF05;
	Wed,  6 Mar 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718102; cv=fail; b=NrITV1e6HrXXxFYT+OfM8i9SOydsu3TWY4FISUY6bLv/y3hrb6kzbRcyFPi/nYmOVS+0RA8wDGsd9ArIGwn3zTWXHjJrsO9+n7C4VA4bhZ8Cgd3lp2f+X83pOI6akZHT2tpoNeXLuNgqgUMhYCcCK1HCo9dn6I3Du58Gptn7sBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718102; c=relaxed/simple;
	bh=9GaSeg+AS9OD/1M6UgAM0qL7omZrfJZzFIgb8btp7iQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IQ4ZAOw6fW6tDzLOMoSJ8MSWVwlc1ZI+iGGodbLMThDl6+EhSf/jBEPU/mNqYXVmz9diIEe2SgjI5h+qRV+CUsYyWrlV4UgBDK6Ovbrpr5r+q6+9LPp74jby9cr51GRwRwk6hVBgQAxO8NPcQnB6faS7r/1xUTaXuzvF0NQQdQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KI2v4MMU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AoSynode; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4261FN2M010021;
	Wed, 6 Mar 2024 09:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=sQhonQJ7gVbsxSHGDjtQdLh4K+K6eHcncvJuSxDw/L4=;
 b=KI2v4MMUl9rqZbaPjiHvVr3BQVtz6zIijFSNaXAPtdowpy24cs5gi0krqlUF2zyu9urH
 pdvvZ1tuIDFiDTRmFoerfL1uMY7T5BMWSOsY5SNn5rzL0msRXwUT0989mHNF4v43Jp1B
 gp2Q05RW9ME2uu3WNFnpbU8e1VBMvL+Ipjo4R/Iwb2LtdWVovYLFpGoyPi9Hmtv/xXSH
 yrYpDaxk+xCrdLmBE7nLCGSwoAQzSIcSe1bW47FDAwIZ9E3GcASZ2HbB+xRo5G0PaxCL
 YWAdmUJv/1A1dA/Jc5rrIGJSVtPfefrdJwzltEX9BrdEtN+k2xbU9BhtUChjvMPRNItT BA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cgj6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 09:41:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4267weBh013711;
	Wed, 6 Mar 2024 09:41:23 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj90ste-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 09:41:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUndb508nj01vne5QMmYqJk7xeHT3cruxsRCqFl2bZKsuYH+HrpNGNyHeWVMbl/Run2FBb9vDcWY9NkI+YiGlK/UgODVbH5BmzUtCiB4AnKES94BNqNMQQGBuQ3h+2zVqVqP+mXSCGNC8/Ohp/0zHj3rdnFIzxCxmbFnYNN0Ghx73qQ0Ghys7pQF3XpCxv/SvKaLuPonLKuDh/DF4QkS69s/OQF7LYvYVchkJNl9hlBFg0p+jkgqvstYgT+5ABnScoMK2I/Qa2XGnuw6bDdxmQRBxsGoD82Y4HK96Q+aP7Qkx7nvf1y3Jjq5INWmTM+cPQp4l7C0GwAJgh0emiYCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQhonQJ7gVbsxSHGDjtQdLh4K+K6eHcncvJuSxDw/L4=;
 b=dOUENifx3NLdxPkjekr2RLCQJ9j51CaZSKrluTvJPl9XmBtWmgHlC6Igrz0D5pYxZPhIO3r/I7nmmbcAe5yWik4RQBcPb9IterpdSSsGn8nPcsMHFj5OOG+LdiiLRsEEM+7Xjgkg68MX9TCyJVAN1G1XQif/ZNYY6FPl4kUOO9MYBP2Elg45b2UxzlMdsOROgg0vISSYVfGv134uHe/K8yMC51pXGK9zV+VBDNo6pTMNG/FJECxqXLg8Vp1HB36XMCzxF/jfDdYDkgVdYrKyR6l/PxFPXFexo95beLiF9jtlL7KHIFfV/qsPen2CFGfInNw2RFA9FmiMEp1YzpKA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQhonQJ7gVbsxSHGDjtQdLh4K+K6eHcncvJuSxDw/L4=;
 b=AoSynodeLEqNqOT82rqeUlaZRX2ybLm1iDKMHFG4NP2tOYt+J32lwrPEnwcj20r0lEXL8S62O/PDYFwoiqITTddsIda5J3Gm5SSiW9jQltuML+O4pfMXulU7t4EaRVlNPxPo3A4npBteeRdvqVJMDg8Mt0lsU9Y1juYHirCvdho=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6811.namprd10.prod.outlook.com (2603:10b6:610:14c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 09:41:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 09:41:21 +0000
Message-ID: <add78cb6-1fa6-4a1f-b846-899a21fc1308@oracle.com>
Date: Wed, 6 Mar 2024 09:41:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] fs: xfs: Make file data allocations observe the
 'forcealign' flag
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-5-john.g.garry@oracle.com>
 <ZeZq0hRLeEV0PNd6@dread.disaster.area>
 <f569d971-222a-4824-b5fe-2e0d8dc400cc@oracle.com>
 <ZeeaKrmVEkcXYjbK@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZeeaKrmVEkcXYjbK@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0103.eurprd03.prod.outlook.com
 (2603:10a6:208:69::44) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bd2122-b460-412b-642d-08dc3dc194be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5SRy7LSS/FDEjY1dZRt4OaglFRug7X/k4YJp+bRtOBj1LuexJ1VHu2uQe0sepm3VJlwYUx6rDTC92w1oj2060LRk40twj2tp5ma5oPRfSN3OdnXkBl784MFiZhr1VxC9XxaqDlbtCkxjejPOFgUAU783LxpGxnh2vPc5iYLUfWQTzPjHhtJWCyeP+AdSZy+lp+61/1T7f/0NKuBEpIzzswq76trSWrnAsP1zh+r0Z0le+onHPwqBGqs1WNYaq0ndLPp+bJ/fz7LP/dZHCzSoIPlXLvg+0sH1XHcEbnWmN07wdENuR+TjoCPRuA5h4gyXd7tMzk8L2lbHFLyLV06dvmfWyUQKIOlXz/TEQtr962dNtnO/zWs/enQnV4BT9+fGZutfrxqGGWe56bL5R3bx1H/6cONwmcw2rqG8+lVtfpg5ikkZfYEsWuJHbTKcQTGKWcsusjzP16QZk7bhBdTyyTw+4XIbSso0qTBwWTnsJKIxucj9zwsJKkDqoz6CQhLT60KHVJ5et5p7kHJ83X/7JZR3m2jXHDaOkNzjSVrjMyEC3dqA03Opl30o2HwRe7rqXC/DZOR/SSPJiqKxWzVWxXo2OMynUiAFoT41GgO3ImVI3QTtL8j5UAVHFacpSyfF0TxNglP0mzTVUtQszEL6yNjJp4mlMlNQZEqZU/UfaGQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHNVWW13cVJ3Z0F1QlZVM2ZPZE5hZU5sVEEwbWcwalVwU3B5Vnk2b3VQK2ll?=
 =?utf-8?B?TThhUk1ZNWNQVFVWSkJCM2x0OXhuSjNpSkNGNGRwS3lNSmMxYUJsUmFYOTFY?=
 =?utf-8?B?RFd4UXFFWC9HcytucFZWeDduUGg4NG8zelVFaGlIZXcrT3lCL1I1ajFua2hQ?=
 =?utf-8?B?Y1Z0Z2tLM05QZ2hIUTFUWjVsM2h3YWZsUXZ3V1QzZzdtdjlBSWdBK2FPbzFl?=
 =?utf-8?B?UWxpREI3V0Z6ZXZNL0ZSUEJtVFhBdnp3dnNGdjhka0tmZ3M1VzlCWlBpL0NG?=
 =?utf-8?B?TUdsWlJ1SEZPVWpOMzIzTEpuSXhUQVBkUzdOcWtUVmhIV2ZId3cyQWRJRnZJ?=
 =?utf-8?B?YjcxbFl4eWhSWWZocUFCRlR1S0Z3MEl6TzZUbGhGNnpFSGo0MG5TTmxDdzlY?=
 =?utf-8?B?QlE2UEpPdGZOSk9SSUU5SStkQWdCSCtZYU5lb1ZvOWptWXpPd1FGTXpIUHFN?=
 =?utf-8?B?aWlEZEtTSUtmanF0T0pNRENXRDQ5S0hsTHRVRWw5OWV0WFBXMTBIK0kvUFI5?=
 =?utf-8?B?MmVSN3Q3S3hwcDdUUWwwb0pVVWt4blpCTXhRSGF5TnpicyttWWh5UUV0UUhu?=
 =?utf-8?B?bW5rcmhYWGo4T1pVa2RIbWk1bzBFMStML1h3MnRjUlg0VDZxYUFaM0Rrd2JF?=
 =?utf-8?B?dVRObG41cm5CRW1PZEgrekhMZ0pVK1ViNlVGNVRIV0NCS1h1SHhsQ3FLY1BG?=
 =?utf-8?B?ZWtUTC9tT1ZPTHpUa0VCdXJoV3hWZXpDVG9ZdkhUaUJVY1dRd24rMStpeVBC?=
 =?utf-8?B?Q2RVVDdtL2QvWGQxU2RCSVZEdG1Jd0JtbVY1OUVjUkZNMW9tbGp1SzFPTkxt?=
 =?utf-8?B?OVJPRDluZTBpQUtjU3JJUHRLWml5ZlNmS3ZqSWZnMUpnOVllQ1hHQWtrT01S?=
 =?utf-8?B?UzVoVGpSWXo1QjIxb3Y5VzFPTFA0RHdqOXYyelQzOGFCd0VyWm1LK3lFN05Z?=
 =?utf-8?B?YkluS09kdjg4aFBIU1lsYU16bENKMnV1ZG1LNEo0QUFNaWxIdjBsd1Y2a1ls?=
 =?utf-8?B?c3VjNTRxMlNoRCtISzNYOUZHalFDNXJvWk9SeUxPQWFDemRXaW9DV250T2I0?=
 =?utf-8?B?WGtvVXdtbHJ6aXZOMnJMZG1RN3I1N0RlUmJSVnJPZnFxTzJqMnpuMitMdkVo?=
 =?utf-8?B?bVlvQVdXR3RUV2F6ckl6Qy9DYkFqVFRVN2xVc3RWdDl3K0gxL1pUMjNVV2ho?=
 =?utf-8?B?Y0JmMFVwQU14WjBqMHhTRDk1OFdiSlIzRUEwRHFKalNuaExiUTFCOEptbVQ1?=
 =?utf-8?B?SStTdTFEVCt0d21UaVl6UmxMSDVLNm1DVWxicmMrOUFvSmd2d252TzM1QjIv?=
 =?utf-8?B?YW5vdGk4d0RjQUIwU3VDVmRHa1pqa0h5TUszS2pHWEI3a2RyS2laT0JOcDNB?=
 =?utf-8?B?dEtMQ1QrRTNOaGZjSXhldjllRW0rSFZzWUdxOHVzTm9wbDZad1NQZEtBK28v?=
 =?utf-8?B?V2haYUtkeGFjWWlYQytGZmJXemxQTUxlRWxHQkpQcG5RazZLRU00R2g5NUlR?=
 =?utf-8?B?b3Zjc0hBNE52YXZCRThrK0RoZ3pFRDB5QlpxWGRiYmtvait5Sm5pb1ZKSUp1?=
 =?utf-8?B?R08wemhScTFUMVQwdDYxU0RVQ3ptUEVmTnFMOWM3c0JLNStFREtGQm1ZdXhM?=
 =?utf-8?B?aVhkei9UUHFDMSt3RE9iUktMT3I0ZUpwZnFCbmFmWGIvYXNhc0lJM213VU9O?=
 =?utf-8?B?anN5NHdVLzRpemtYUmk5ek1rbUNCU09jMmFYQmd0c0lHMU00aUo0WThtOVVN?=
 =?utf-8?B?WVlwVmhwbmZobkhlWllDeXJIUGhCUERWVzlKL20vMkhiRWhxL0Q0NzExcldE?=
 =?utf-8?B?QzlpYkpjWHFGZ3NqZnJJaHZHdWZSZko5QUxxNEF1eUpCeGNVeUwweWJpMjRE?=
 =?utf-8?B?NkZ1NkZGMGNrUzd3cHFqS0d3MThBTFB5aFRXM3M1VHNHalFtZkJrbnpJV0FE?=
 =?utf-8?B?V2xaRnRhOW5mNXBFTGRNNVBiOXY1cGNGdnc5SWpReXJzcDJOQ2dKM3FLUmhn?=
 =?utf-8?B?RXdpejJKQnU5NGJsTU5RcWJrNzBYY1RENTU3R3Fpc0RERmZjb1FoWGVSM2Rp?=
 =?utf-8?B?TWRzWnBKa25nTEROU2RsZVFlSjlhS1AzZkpXcWt6MllrcUMrb1JsVzg4blpM?=
 =?utf-8?B?bVVoUFc2Qm5QbXp0eStvRERaWnVwSXI1RTNEWkNWQyt3NWpiZVZlL0pzdnFN?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	C8oyzya0gqEgzJx5YzKp3eoYc6o2X503MqstHWkbdButEbWTnVHjGKdv7xvk+HIeLGDtcNGVVuEHg22gEH6QyK1UaqZEphaUB7QCqiPmk/b3/Z2Hm1Ey4VjZh4yDPrkWZ8clc6fyYq+jU1QaGSQH0ft6ChcT6Nc++GWLWp/PfIAVHynz78Muf+aRs0cfwYpxA8R20hEBgwMmEAhm5JPNiRUHuKWcTNSab2y7Nc80h22dnwOww0YhkdYbheB56dN9u0fuD0D4EDnimMeNkd/3gnCZimGGmodgLNgYqPS9jnr9ncf48jMrThYoSPul3NzeeKZZxSC+sQ1z7MG3d0mm82tkV5Msm819/lB3FJ31hGLHC1eZU5Yccydnm5huXRncLAas0CXwf3FH00Ou4AP7sXaGIXr/Gw4C6lhlhXOmAXhCnF8auAKgcWYHS1WWyelZcrs5dgw7p6BFxQT8ec7ONDwy1Ts4KGM6F17GJdMSjMNlzo0rflCXiq7fNcLTxYhX569+xXQJsnVzZhFXsvoFCiUMkOo4E7ywW+VxRlIoWOQ2o8wWnwkweKAV/TBeTfaZepdjT4tUp7gzhHeqCA589BK6vDHOHR6pG34LnGKbH88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bd2122-b460-412b-642d-08dc3dc194be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:41:21.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0loEBKkTWNY+7rHZQ+HHmZNIMhEnbdBLFPgjFC7370kP2+HnRujky/JoVZE+RpWq5C37HW2NepUO45ArOIz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060076
X-Proofpoint-ORIG-GUID: jcPJ971ekbqVOW9Oqfc9BoSBdQixAVCa
X-Proofpoint-GUID: jcPJ971ekbqVOW9Oqfc9BoSBdQixAVCa


>> Please note in case missed, I am mandating extsize hint for forcealign needs
>> to be a power-of-2. It just makes life easier for all the sub-extent
>> zero'ing later on.
> 
> That's fine - that will need to be documented in the xfsctl man
> page...
> 
>> Also we need to enforce that the AG count to be compliant with the extsize
>                                        ^^^^^ size?

Yes

> 
>> hint for forcealign; but since the extsize hint for forcealign needs to be
>> compliant with stripe unit, above, and stripe unit would be compliant wth AG
>> count (right?), then this would be a given.
> 
> We already align AG size to stripe unit when a stripe unit is set,
> and ensure that we don't place all the AG headers on the same stripe
> unit.
> 
> However, if there is no stripe unit we don't align the AG to
> anything. 


> So, yes, AG sizing by mkfs will need to ensure that all
> AGs are correctly aligned to the underlying storage (integer
> multiple of the max atomic write size, right?)...

right, this is really important

> 
>>> More below....
>>>
>>>> +	} else {
>>>> +		args->alignment = 1;
>>>> +	}
>>>
>>> Just initialise the allocation args structure with a value of 1 like
>>> we already do?
>>
>> It was being done in this way to have just a single place where the value is
>> initialised. It can easily be kept as is.
> 
> I'd prefer it as is, because then the value is always initialised
> correctly and we only override in the special cases....

ok

>>
>> are you saying that low-space allocator can set args->alignment = 1 to be
>> explicit?
> 
> Yes.

ok

Thanks,
John


