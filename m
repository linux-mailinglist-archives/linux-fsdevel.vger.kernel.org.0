Return-Path: <linux-fsdevel+bounces-28366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F1969E01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C821C20AA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B31C9851;
	Tue,  3 Sep 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gN2Lvwb3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uVkZk96U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C61D1F65;
	Tue,  3 Sep 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367426; cv=fail; b=XqAkCfNmKVghW1ovo7lx4H77FLfI4zDazvJ8hqa9YnO4+QJIvEeNRZXA/55WliiwwnX8d6/a2F6aKY9FyQnRkSp0g1JINEA+bkS/CuOpPrVfRcM4L0j4pZ74TCsdw2UP+et7uwbgk9+hY62pQoosg2aKE8Kp+DBMGZO8LYp8Tog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367426; c=relaxed/simple;
	bh=mchVbuFWUnM74u2Ta58JzaGzzilCx/NYfuT2H4GwREk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HbIQx2gsprGCUMMa8R01g3EUEn2Ah1Eq0hLhIDxxEqT0BPSNDVI9cKF7vPpwscfW1bcNddfW7MTyrfEG4C3SJNvp79NlS8mjCw666xgyS3YXUa2PBDOAijpyzoFUb/5lkthQDk6vyfSxz1JUf21qx1U2dPXR79SjZx7/e8bea+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gN2Lvwb3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uVkZk96U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4837fUIY007567;
	Tue, 3 Sep 2024 12:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=0NoHwK5I/UxA6aM+D37q+kqyUX8j+JqliGKRAZjsMYI=; b=
	gN2Lvwb3/E6/iKKSvJ7GMLtlQ3OwRor1+JTcECv8AkIJUsxkB6VlVv3RxA1SkTmv
	bxj8d7+Kgxluf5FAkdTLE9TY5+FognDHqFVzZMFUO6cGBTJmErrCvwCtt0tCzksF
	Jnl/BJN9Dxh1vNgqDZ4FFLVJpX5Kxb6TS8gMHpbHKQEl8lx5sT1r+CevVJdqb44S
	f4NPoeGo7HT4JKFgOGFsuBYSk11fu7zeMkBE7U7bssY3Uds6wRXbKdhPr+ruzODz
	b+V7JIWNq+2hMgp4OrpI5GLKwP3GNleX/ijtSzoE6qiFYkzQSDNAcUI2LwEu5lwS
	0fHclbzQaW5tjd59AiBXRA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dw51rpku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 12:43:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483CU23v018569;
	Tue, 3 Sep 2024 12:43:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmencvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 12:43:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dREUDwaGzWt8avOhOYI9+uWy6W9n5mdr5uMbvmR4XLbjlyZAlDn6l4/8oOl4tiNgmuHg8sNF6ymtIg8aM/mb4sVbozLaI+IEoLe66trvMT243qUPKmwASoQhOYrdSSYjAi75JMoXhdrljbr2+DOC8YFOtjorA8spKprSu7LqxTnnmcrPdK85JLi44ZZAbviZ0tbrLdjVnc4kjvQmzNuYxFNv5wC+zAGbQiC4+kOmH+RFLqEuY94obqxIHkwwkEeO0DggS8pgQZhvvYWai5Nt5jh5tNn0wXPg+/uGI/xBoVwYPG1zXbfcmCDEpDBVF7lqgzJNLTn6QxD06Ua/gh18lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NoHwK5I/UxA6aM+D37q+kqyUX8j+JqliGKRAZjsMYI=;
 b=teiIghR6FrW0N5CA8UIYQAzoCIcHei/Ynu5dyEG5bMDFaMOCSUmo6Pj9MaGb7xIMRKFTlemvlovvO3MpsdNN2BW4T+R+kd+uvqjwxrEokWd24OzHWl2sEMiaGEyz1Hyr20TTAtRHma++9Y2+Hov3/QQizuS/x9gFRwCM30vLd8eF3KYdzr3G3xVaFeFcMB/NIdKMW4LPIAFs38WbPwKzHGEgNn8OidE2I8amyHc8otb15d3bPAoTWgvOhRUTeaQxNWiU5nSf/MVLrHVIuIb2HXJOiPPG4Ch2F8clp/s8fcioTf5NxGe2voYhbBrvXy7TiqdEnzMolIdUsGOzxEbSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NoHwK5I/UxA6aM+D37q+kqyUX8j+JqliGKRAZjsMYI=;
 b=uVkZk96U0PiyC1ZQyH0hhMqt7BAWfGcAaSLFiJfx21qEajuEPKS+6u34q/xpoh6XxFTj1nFv2FJxDJ/LspQt4pBACzpkwLnY+bipr4rfHEoLnO4DTvJnBmXCHaF+ypwwVbDEvGWnU41/KeqtVWgWkPmSZFSmEebLI0mHyox/wd8=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA1PR10MB6829.namprd10.prod.outlook.com (2603:10b6:208:427::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 12:43:11 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.7918.012; Tue, 3 Sep 2024
 12:43:10 +0000
Message-ID: <fb2a9544-a799-49be-8a8f-207c7374fcee@oracle.com>
Date: Tue, 3 Sep 2024 13:43:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] fs: iomap: Atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-4-john.g.garry@oracle.com>
 <20240821165803.GI865349@frogsfrogsfrogs>
 <a91557d2-95d4-4e73-9936-72fc1fbe100f@oracle.com>
 <20240822203058.GR865349@frogsfrogsfrogs>
 <112ec3a6-48b3-4596-9c20-e23288581ffd@oracle.com>
 <20240830235621.GS6216@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240830235621.GS6216@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::20) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA1PR10MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 3310da9d-793a-4b8f-a1f9-08dccc15f776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0RLKytMWTBEVXdRbDM2eWw0TXorUEs4WWc3d3M0UGdjdVhJU051c2RhV1l5?=
 =?utf-8?B?REduMy9LeUxzRUZXekEwSFlZSWcwaFlGWWE5VjVNcnR1bzRNcXk2M1FpQllL?=
 =?utf-8?B?Y2pPUGlid0QzN0MxdFAwWDhvaWplR3pDenZQMG1TZmtyRkpwb21tTE5jdDFt?=
 =?utf-8?B?MWpBeHM3OFhyZ3R0cUJueXpnMHdiMUxjQWxIWEQ4MzNJUkowOVpoTXJCSk5C?=
 =?utf-8?B?SG9kemlTbjh2bjVHMTZ6aHB0b2ZHZ0V3MUpNR2RUWDZWR0FzWDhHV25tTWVD?=
 =?utf-8?B?TE9NK1k3d0R6eHlVdzl2Yk91Zi9oVytXOEFnRXk3aFFQdURBL2pkenF4dnJ2?=
 =?utf-8?B?dng4RkNTNXFIb1dyK3pJRm01ak1MNDB2eVROSFVlOENOampUQzJqNzJ5NW5k?=
 =?utf-8?B?M0VYLzNrWGJOWHJ4NW9FWndWOGtqQm1nZ1NlVXdIaW1QTC9KUnU0dGFIVUw1?=
 =?utf-8?B?YU16d0hFcFRrSjVHbEdjalFzb2pMUU9EVVNyUkFxbnVZellUaFd4T25sc0cy?=
 =?utf-8?B?Ym9tRkxacWtCVi81UjlwUlJpSHNkeUQ3RHVoYVdGZXB2NUY0eTJqSitvL1Jh?=
 =?utf-8?B?Sjd5QzhvK2FteSs2WVNXc3hwUmRGMm1CT1dmS0pnMHMraGZYMExlcWtJeTlB?=
 =?utf-8?B?MDBLZ2h0UXlVL2NPR1VVbDFWN3N4aSs5bzlENFBaWkdzcXE4WWp5VHNOdDRs?=
 =?utf-8?B?dk9ZRlJqV1Y3NFFnVFl2UjYvTlE3elYvNDBlYVBoMEdzempJUFRONityNXR3?=
 =?utf-8?B?YjN2MmVQeXJzZzNrTjFmNloxb2RXWGJyUE9tSXNzTmpvTGMrZlUzL3pFclZu?=
 =?utf-8?B?Zm5mOHJMQ05YdXdIckxYeFJtTzRwR0Z3NjhHSVV4ak5rODQvSHV3RHJvS2cr?=
 =?utf-8?B?K21WaDZGcW1hZmw5ZEVPaHpLV3ZIUmJNbng5cXorZU5UWUxjZktHVkZmQzVy?=
 =?utf-8?B?Zjl5ZDlxam8vY2lxU0o3a1NiOWNUYkJYOXhpL3JTa01Na2szWW9SUG1VQ1Nk?=
 =?utf-8?B?T0tCRnc3Kzh2NlFYbnV5M01iOWNzUk9VY0dSYXNoVVJtY1lKdUVqRDdQYTRC?=
 =?utf-8?B?UDV0Z1gwait0VGJqWTBqOUxhbXU5dnF3bEh3V0tJYTljSzdtYWdyMDdjeW9l?=
 =?utf-8?B?K2hmb0lLcm1JU1l3NmYyQVJsOXBSb0RnRDFOamtpU2ZHb0Z0Y1lkd3VVR3h2?=
 =?utf-8?B?N1BoWGRMcjd0RXZ5cXlLQVUzK1EwdTBGbU1OaDd5ZXpzaHBDNzA1b0Juancw?=
 =?utf-8?B?bWRSaWZoWFM4Mys0YmxVMWs2Zjc0UzhUZlpwa0lLK3BIaFJyQ0p5NllQMEFL?=
 =?utf-8?B?MVQyTTBBd3IwOHNxOEgvUHVIUjF4YXZUaTBIUnlTWHUwWW5jY3lTbFNYRk9s?=
 =?utf-8?B?V0srWEp0ZW5WYVp1ek9FYms2czFkV1h4bWtuREQxNTQrSXl6b0FOMDB2R2VR?=
 =?utf-8?B?UjA4SDlZZ2hzT0Nwd3BBZnNYOVRtMStrMWxHdEg0eWtXV3QzV0Z5WGxKSU04?=
 =?utf-8?B?dmExbkZvVmtsMDJqci9Tc2lnWXZ4blBqQjZDZ3pOWll6RHNraFBTSC8rUm1I?=
 =?utf-8?B?NFdpUkVzYWtYaDhjdkE0TWI1cGk5b1Bid1BoaytxR2EvRzlSWUREcFRyWkNq?=
 =?utf-8?B?TGtDZVhtTmNZU2FvcjkwSnRLR25MdGlIVjV6YzR4aXJWbTVMeklwTTVnT0E5?=
 =?utf-8?B?ckZDcFV3RFh4TUd6ejJBcjF5R2xtK09oU1dPVkxpWTNVQUJPWnZIOE5HZlV2?=
 =?utf-8?Q?xxmOzstI6PYqd9A4Nw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2dKNGJqZU56MlBWYVg3SmtGQnkxYnFyREhZQ0orN3U4SkV6RThsd1I4ZWhr?=
 =?utf-8?B?eDZUWERZR1lKNTh5UjAxRTZxcFJVeGY4MnFxTkdLRTRPdHg0VDltd1VoTTBN?=
 =?utf-8?B?enYxYzN4Y2xhWXBrZFhDdGhiZmtYTk5Ga0Myd2J6MCtSSnhScThnS3BLTzRJ?=
 =?utf-8?B?WXVpTnVLM2pGelJqZk9BRnpQdHdzUUxLcWlYWGdnem8va3FhdmpNZlJNR3J3?=
 =?utf-8?B?d1hBVGEvajljN0ZKc1hlYnRoTGpMS3JMazhBUkJORW5XZ3lvY1VJZDRCSHZF?=
 =?utf-8?B?cnY3dVRRQjVkQWtmeDl3WEZGRFZjcXl4S08rL1NTdEhFU1hMSUthaEZzZjFk?=
 =?utf-8?B?QVJteThoODhqcDVlTmFmdmd0L0VRTlBSRDdpWWIzdlVLSHNqV1JCRWlHanh0?=
 =?utf-8?B?eXVaSi9oWUdwN1RYZlZQaVFRc0pBcEx4dEhoNHNpQ3JCRTNwWHBSRjBvL3c0?=
 =?utf-8?B?OUlPTnEyOE1VbUZiaG1VOUZPRzVzTjBsWG0rc0dnd3V0TjkvT2I5M2F5WTRU?=
 =?utf-8?B?TytCS2Q5Q3FQdnVUOUtZYXVZejd4d2UyU1EwYmdYU1pxUE5CTDZoTTFLejJB?=
 =?utf-8?B?QjB6ckIzS3NpTnl0WUVRQUNuM0ZyaTFOY0NNYmZKemNPQmNFcGo3cXdPSG1S?=
 =?utf-8?B?VWZnT21Zd3QxTUFGKytOVVdkSEl5Q04zakNBRTdsYmYzVWpQVGhIR0pCT3RC?=
 =?utf-8?B?ODhweTBQZXlRTWFYeWJMcjlxUkdLYk9mZTArWWxoYzBpL2ZGM1h2V0U3eVMx?=
 =?utf-8?B?R1JoUmhnUkVRalY0RkliOTZCUWdyekxTdktEZlJINnk4UjF5eGRoR0J0MFRo?=
 =?utf-8?B?dHExUzc5YStBbWFBZ1c1eWFCWmFVNTJ2RHQ4SmRud3ptSkswbElTTUtscStI?=
 =?utf-8?B?S21oUTQwZlZqL29MK1F0NFhRdmRCR2tYTlgrME15Zlh1L01aOHRJUTBJNnBk?=
 =?utf-8?B?SE1XcU54bFdHRzk0bGNsNzRQTGswd3Y2VThvYU9Ucml2aWZWN25KcFJYTGph?=
 =?utf-8?B?dm5CREpNcXFFTkRVYzZSdkhuRy9GYmZrQk9VWTdPMnpXYS9Ed3UxQ3JlNWNC?=
 =?utf-8?B?RnA0Qkd5ZzNlS1hyZnVlZmJhWkd3dkQ3cmhrdml1YlJtWG5SZEx1bG5MMHV2?=
 =?utf-8?B?MXpyYkFLQXNkTDJGRkYvM0M5ZXh3L013Sm1paUJKUFg0dGFlYkdYcURqZ3dj?=
 =?utf-8?B?NWJmTEd3UkFyKzZ4eU5IazlidzNpUThJamxzOGsxR2FNUGc2ZXdOSTUySHhK?=
 =?utf-8?B?eDQ4b29uaFYwcGFTZ2NhUWdteCtGUEpYZnpiaXNoYWd5MVJSb1JlSHdGZnNU?=
 =?utf-8?B?bUsvSmJKamRMbHA1NHZseitZTllvbjRQQm91cmx5aEJvNHd2UVdTbHZaMFox?=
 =?utf-8?B?bGhCdDVweDhLWkxncGlYeUdleGRPM3lpd2lNL0JvL0hiOTVzZlk3em9VM1FC?=
 =?utf-8?B?ZGlrc082Q3kwSTdkbVdncFVDUGt2R1ZwaXVEWjRXazg5UUdGaUtKak1oWkJq?=
 =?utf-8?B?SmpzMWFRRFpPSDNtU2h6azZoZWdDZlJLcVFQVFhiVTlMVVkwcUNlamhreWVH?=
 =?utf-8?B?MVVnVk5PVGVzSnEzZTU0L21YQzdEUS92Q3plakxidDVCejJ6anZ6OGdjY1cx?=
 =?utf-8?B?NFA5Lzg3aW41c1Y2T2crcUd0VTZONGw2NnVyeTNXZmU0bHFyczNtckNKNGF0?=
 =?utf-8?B?dkFlWTcyd2hXK3FUWHA5Wm54eTkvUHVvY2o2WDE1S2dMeVphTHZENFZ0cVVr?=
 =?utf-8?B?Y0R2anlnSWE5c2R6ays4SGJYazZHbm1kamxNdmhROFVIZ1p1Nm5VaEZmc3dO?=
 =?utf-8?B?M1FaeGJ2SlUvVXAwVjhUK0dQRGxFZjlzKys3YkE2eEp2L3FuMmNGa2V5akJZ?=
 =?utf-8?B?TlF5Y0I0ZmRQQk05bFZMSkJHc2ZZQnZwOG5ranJWamI3OW82enpGVDBBVDNS?=
 =?utf-8?B?Umw2OXNUMDlwbXRncnlkcnl4R0EwbEJaYUE1Yk8xTGpoNkFjekFDdzdlNG42?=
 =?utf-8?B?SnhPYXV5YzBJRzJGWUIwMGFTaXF4OGdFYkZQZjQ3WWNRdE0rVHBuSXRDbmMr?=
 =?utf-8?B?QW8rcVplTUNkQmFWTnYwY1VTQThxUWJIZU1hcVR1WFdES3h1U1FJdm0vN05v?=
 =?utf-8?Q?9LBZRb7dYffnWy3fVRM10/SXa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uM6sH/Idd+Q0vYg+2PU6xowO/2HjijwTzakoAAZHEnmLNRfNhYZJD/pC6wdWZpwAOwin7wloVm/Jrxe2PlqkYiM2gtdX0tKq9MCVBdxrEJlsGq1I5Np0cQ3PHjX62IkY9MDzbg4J9jBOd32wusLt1d0Pp9RnnRZDe2u14dGtoohpzjuEWq3Qci84q/vIKaxRGCtJ18pD7wbRRB8uca4ji0jH63dEizJTLLz8Kcio+226/wcWIxFEIcVd0vtIYvkoTE6SZhfu/IbtnW7TMObWnmaST8oUsU2ic+DlE7wUBHD6Y2NnDY+I7TqVtY12sCcG+QYW4C+U3fDNIJdjJ9Reh3iuM7WR/HJ/8qLS0+UtzmJBi4PaDQSFV9dGqfQY2lw4W4Za+u47BCoRM9ErQWAaJas1t8ncUJaGgYxG+qd1uKTu8XCNm6DJ9pz453LFTCor1HTE3xYaYCLVlUeOBcQBAaUrgluHRA8UWXhQB8SlNZwhf8k9K5Jkg5+py6uJ0JykAutv7dKuKti7MxGOia3X4xYKSoqc0dSPHVqTXPp6fQhlV4VNrEbTVYScMWK5yQeKYO8nesbDCEh9fPsJskFVIhIhvkgHjsn5Ld87X2lwqTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3310da9d-793a-4b8f-a1f9-08dccc15f776
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 12:43:10.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9N8QCQj3KyCv2LAsmfgGfZPyS8eTvqW+xf+BmNA8ECo630yZY4yQ3LjL78dEjJiS3nFKbMQNvrC0jihvWT/GBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409030103
X-Proofpoint-ORIG-GUID: TSuFnNSMXWqvUCTfwOvZ4hi4cL71QMf5
X-Proofpoint-GUID: TSuFnNSMXWqvUCTfwOvZ4hi4cL71QMf5

On 31/08/2024 00:56, Darrick J. Wong wrote:
>>> IOWs, although the*disk write* was completed successfully, the mapping
>>> updates were torn, and the user program sees a torn write.
>>>> The most performant/painful way to fix this would be to make the whole
>>> ioend completion a logged operation so that we could commit to updating
>>> all the unwritten mappings and restart it after a crash.
>> could we make it logged for those special cases which we are interested in
>> only?
> Yes, though this is the long route -- you get to define a new ondisk log
> item, build all the incore structures to process them, and then define a
> new high level operation that uses the state encoded in that new log
> item to run all the ioend completion transactions within that framework.
> Also you get to add a new log incompat feature bit for this.
> 
> Perhaps we should analyze the cost of writing and QA'ing all that vs.
> the amount of time saved in the handling of this corner case using one
> of the less exciting options.

 From the sound of all the changes required, I am not too keen on that 
option...

> 
>>> The least performant of course is to write zeroes at allocation time,
>>> like we do for fsdax.
>> That idea was already proposed:
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/ 
>> ZcGIPlNCkL6EDx3Z@dread.disaster.area/__;!!ACWV5N9M2RV99hQ! 
>> Kmx2Rrrot3GTqBS3kwhTi1nxIrpiPDyiy3TEfowsRKonvY90W7o4xUv9r9seOfDAMa2gT- 
>> TCNVlpH-CGXA$ 
> Yes, I'm aware.
> 
>>> A possible middle ground would be to detect IOMAP_ATOMIC in the
>>> ->iomap_begin method, notice that there are mixed mappings under the
>>> proposed untorn IO, and pre-convert the unwritten blocks by writing
>>> zeroes to disk and updating the mappings
>> Won't that have the same issue as using XFS_BMAPI_ZERO, above i.e. zeroing
>> during allocation?
> Only if you set the forcealign size to > 1fsb and fail to write new
> file data in forcealign units, even for non-untorn writes.  If all
> writes to the file are aligned to the forcealign size then there's only
> one extent conversion to be done, and that cannot be torn.
 > >>> before handing the one single
>>> mapping back to iomap_dio_rw to stage the untorn writes bio.  At least
>>> you'd only be suffering that penalty for the (probable) corner case of
>>> someone creating mixed mappings.
>> BTW, one issue I have with the sub-extent(or -alloc unit) zeroing from v4
>> series is how the unwritten conversion has changed, like:
>>
>> xfs_iomap_write_unwritten()
>> {
>> 	unsigned int rounding;
>>
>> 	/* when converting anything unwritten, we must be spanning an alloc unit,
>> so round up/down */
>> 	if (rounding > 1) {
>> 		offset_fsb = rounddown(rounding);
>> 		count_fsb = roundup(rounding);
>> 	}
>>
>> 	...
>> 	do {
>> 		xfs_bmapi_write();
>> 		...
>> 		xfs_trans_commit();
>> 	} while ();
>> }
>>
>> I'm not too happy with it and it seems a bit of a bodge, as I would rather
>> we report the complete size written (user data and zeroes); then
>> xfs_iomap_write_unwritten() would do proper individual block conversion.
>> However, we do something similar for zeroing for sub-FSB writes. I am not
>> sure if that is the same thing really, as we only round up to FSB size.
>> Opinion?
> xfs_iomap_write_unwritten is in the ioend path; that's not what I was
> talking about.

Sure, it's not the same as what you are talking about, but I am just 
mentioning it as it was included in my sub-FS extent zeroing solution 
and I am not too happy about it. It's just a concern there.

> 
> I'm talking about a separate change to the xfs_direct_write_iomap_begin
> function that would detect the case where the bmapi_read returns an
> @imap that doesn't span the whole forcealign region, then repeatedly
> calls bmapi_write(BMAPI_ZERO | BMAPI_CONVERT) on any unwritten mappings
> within that file range until the original bmapi_read would return a
> single written mapping.

Right, I get the idea. I'll check it further.

Cheers,
John



