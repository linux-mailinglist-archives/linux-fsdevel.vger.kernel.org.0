Return-Path: <linux-fsdevel+bounces-43134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D464AA4E812
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FB219C5117
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF5293B7F;
	Tue,  4 Mar 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cnq4UFzi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W9+kGxRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12AA293B6B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106744; cv=fail; b=nFD7ANmYP7EViodceI7oZvLreychVUMRb8Tgm550A68F6/jyoit0YfwPKzZs8YvSdcw5O+ub5rou7Av3jUM+J88bpUDyt5eIDNzmbNkQCGew5zQFp4H3Qjw8Q3JVrv0au21ahdG29VZYstyGlN7S+wKrq3/r2MeOnMsrd/iDWLQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106744; c=relaxed/simple;
	bh=0CjiEg6aIAJKXfsG2Cts6kPApEyK9ACNlBaFpWHWQFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rhHmxLVWt5tzox8LGIiRf7IgAI63Jv9R4tZVRIOvLZj444jEQQ9zWoLFL0Ns/5dfHDYpJyydjRXyc3YRiwbKnRSU1wk51Qs7pqbHm/0euEe/TnXKKHufUqsk9X43JuRCIs2jUCc4kVe4ZvyueYrf80RK2uEEhjhNFNkcaCsTYAs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cnq4UFzi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W9+kGxRE; arc=fail smtp.client-ip=205.220.165.32; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 20048408B5EE
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 19:45:41 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=temperror header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=cnq4UFzi;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=W9+kGxRE
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6hMt25tFzG40W
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 19:43:54 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 73D5A4272F; Tue,  4 Mar 2025 19:43:53 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cnq4UFzi;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W9+kGxRE
X-Envelope-From: <linux-kernel+bounces-541844-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cnq4UFzi;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W9+kGxRE
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id EC99041AE7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:46:34 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 5715F305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:46:34 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422DB3A8178
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684F1EEA39;
	Mon,  3 Mar 2025 13:46:13 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67E23F396;
	Mon,  3 Mar 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009568; cv=fail; b=ZfjCcexx4f9bMdxoS/8WdPK2UsUkwkXyvlbjOTIqHOXU6SVTrjRrHeTHi63jUwx3SuXbku88xBZ8C9eC3sOu5WBXDrxJpeUhDWvzRn5WTm8NG7BiERvt4fe+hcaEov8plqx3R2miKk/18gdyUYBScnOnQZTKfzDlm8V/UhJ1+Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009568; c=relaxed/simple;
	bh=0CjiEg6aIAJKXfsG2Cts6kPApEyK9ACNlBaFpWHWQFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KvLrgairMCDwCBpMu//v6dKqSbJs+qrJFE2usoiCa80+ypcAHVT7O5tpYvS+jyVjHjybqPkBl/fAwlooXADasNCesuwSBkqnh2NEAnJBk4iuDRFzJIGQsRvwI0VxkYIGEdn0EBeqs2rfmQhzrFwCgcWlDt0Xssvbs6G3H/7dwlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cnq4UFzi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W9+kGxRE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tkVS015585;
	Mon, 3 Mar 2025 13:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9/BxNWflJwuzXIsHXyXY9ZCMRUkz4vmRfkR4rPiS7no=; b=
	cnq4UFzicxEHczjS7nWipiwr8itA18sZVf68E9z70yub/M5+wdkOeSau0qaRPrlU
	ZuNz8+Hk+acxXvOUZxhvZykBCtfN8DSkzuOgb06AokdxfrKWVe4BpQ/U9t81x6zg
	RoOhN7i6NIMs2jtnGxeHOTC+V5o+6G3ZnlHyr7YI57aKvp9LesbMMHWugUeTP6Vg
	8pBCPZ4cIFBshUCkD8JqgMOmS/tIPQjb/iT+sf42tGo5uFY+8rrQu/zKEvBmvoR/
	kwpF6fUEeeGeUXZAUDVqOjW5zt8MOQ6YM/RX6gNuKYJHTU9WpBbHXKFPqcWzlCsm
	CeolwZeOh0r70/ry4vpkHQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavtmm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 13:45:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523Bv7sf015741;
	Mon, 3 Mar 2025 13:45:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8r28r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 13:45:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqOUHZNg2qb4Dq+UuyWrxgplA2J5u6uYmQU4rOFz5IgnasddNPmpqgr25qvqIYSTBDYyz1R5XJ8+3+s6vs+3xrK0/880CTs8JysgUsu9lN0g5MkYuXViL0Xo+TWIqLxH4OA/21ohQy7bk8ijoNo3qini5NiDDhxdGtQe3eD6gNP+8ZS6p4e47Q0lKq7CDzbJ4mJ/2y0x7lwMwmH5QHZbw8GezaE9t7colNGIbm4pMD9KGTltckRo8nY3ow8qp35KyKBXZlJcXhj3PWq3ePMJePn3k9gt6WkJjqfeT0CLNNohGj617LRP+q6MYCk2CbdiB2XKfdKQf4kajF1aGM+W9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/BxNWflJwuzXIsHXyXY9ZCMRUkz4vmRfkR4rPiS7no=;
 b=wuqj68C6PGFKYhHCgkhv5qGuax/mzIcb4/TP/Lr0zwfssOV5VsI384b9e6hmeBmRampYta5y8wwl768MM+aDoflAt7/8RfQsk87J0d+wgT+GfR6ZO3TWJI95PP2INUtlOskSe0qWStqb+9eQ3LynPuxEeahT+qVU2ksqZXmQ/yJ7dEhjeJGm/FQxt9h8wQz8taCH14/FEaUcg01cYntwiv9NE9jlwcghpLWqkUxL5XaTfcCGcKZ3ZqZFcTBcqO2qeAlbgk41uU0kDYHFgd5IsZ+ISla1AeZELKU8cBEaNC5YUwE9Ghxfja03G19ooP+d2o7NNZi7qgaaMmhrOjcCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/BxNWflJwuzXIsHXyXY9ZCMRUkz4vmRfkR4rPiS7no=;
 b=W9+kGxREN5g2V65TH1QGGNJmNzQ1mSLaZpVX+dQDkDuaCJvVgli5YWx44pH5+vxAPNrv+z1rHVN/PzpUizw5tlIHQjmrXzp12JrZSweAeJvBKLH6alAgraLWsxQe62HQJYqDcnSdWEsR52gKZ5tq6jWlpRjEhTyksyL1xpN21Y4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7189.namprd10.prod.outlook.com (2603:10b6:8:ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 13:45:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 13:45:41 +0000
Message-ID: <73f18b2a-6716-417f-a12a-8c6ea81f344f@oracle.com>
Date: Mon, 3 Mar 2025 13:45:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] xfs: Add xfs_file_dio_write_atomic()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
 <20250227180813.1553404-10-john.g.garry@oracle.com>
 <20250228011913.GD1124788@frogsfrogsfrogs>
 <903c3d2d-8f31-457c-b29d-45cc14a2b851@oracle.com>
 <20250228153922.GY6242@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250228153922.GY6242@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0693.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e110808-0293-45d2-ad53-08dd5a59b084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWg0aUxzb0p6M281UWtiRnhrcVJrRS9IeDlESU0ydXB0czZKWlR2c0EvNkJk?=
 =?utf-8?B?N1NzK05QMkJOV3NpaWhtdjh4SWZhKzNDRUFtQnQ2SEFKSVR1UkRnVjZJN0Zu?=
 =?utf-8?B?aTlMRkI5TFRiRnBOSTVsYUZNS2hvRlp6UHpsa3BHb2NkYzVCT2RxejdLcDVo?=
 =?utf-8?B?OTN5Z3NwdkVIdWZJcGlndjFvOW52R3AybEFOMTFSMXNaYzJrQWtXcW5LVTJ3?=
 =?utf-8?B?NnJNL3ZlU3VrM2pCK2JOdVJ6cnI5WE96WmtTRXRtL3dab0tJSVF2TXg1Vyt3?=
 =?utf-8?B?dlJVWEJ1Qnp3ejFPMlBiOTFtYWZZSXZIbzh0VTVnZ2hhUXR4cFZ3L0M4UDdo?=
 =?utf-8?B?SjFveWhEM3Z5UU1WUHYrKzU3QkpHQ1ArbHFNbXZHa0h3REJuTm5WV25VblRH?=
 =?utf-8?B?b09HdzFKT0Q4MkxDSGVDTTJzMGdpQnQ3bTNPNzZoNmRhK0lTM0NBK2RnOTIz?=
 =?utf-8?B?QzBRNmh4U2lyUklpc1pybm5seXZVOWx6R3dCSGJWTHVMNWdWa3NsUEhYVU5B?=
 =?utf-8?B?NHhrelpIYzhsNC9hTmRRK0NqMXczQVIvNDBEaVdubEg4ZGd6Wm9DaVJHZWhn?=
 =?utf-8?B?WEZ5L0F0a3I4Zzh3ZEhJQlhZNTFHUVhJclBHTzdwOFNpSTZ6bGJaanNES2Vi?=
 =?utf-8?B?QWg4cXhqU2s2SkgxaThvN3d5OFNrUExNb1lYUDRvY1lsUUFyY1FscCt3d0x4?=
 =?utf-8?B?aDJHdTNBdVVuZlhYK1ZHN096S3UrR0VOOFZMc0VPbVN0Y1dEMWJUbFhEbHlz?=
 =?utf-8?B?UzF6Z2ZKcnc5ZmFzS3VHaE5UL2ZPeDRUbm9hakxleWxYc0hjQVZOUGoyaHBx?=
 =?utf-8?B?RnVLRWxDY2R5eTluV2c2ZEtRSlZnUzRlWGtLYzBnblN1alExVjNnb2dFQ3Ex?=
 =?utf-8?B?VE1lbmdJa3ZPNVQ0aFFSOVgxbW5mUFhLcnJVQnpIN3JPczJFd2pwMDM3OXRL?=
 =?utf-8?B?Sk9MSGhROFg4QlZGai94TGlUMTJYQkdCUnRaYlNMbnJFU2ZDWW82MnhtLzh1?=
 =?utf-8?B?UnZObUVyMmx1THB4SkJscGNteXI0UHJxWDVWbXZvMXZoRU1RL0JRVFJYSERv?=
 =?utf-8?B?MS9WMmllTkRIeU9Ib09mbFRUN3Ura3k3a3J0MVpqSnlnSE1raFlVUms2TzE2?=
 =?utf-8?B?bXJ2UFRINGlZeDI2bmhFM1g2bkxPMzRyNXFud0FRUy9nZkJQcG1SUWhmM3Iv?=
 =?utf-8?B?Z3FjdVd0aFV3Ylp4bElXT1kwak1jVS9McWJYMVQ4TjBOL1BuWjM0eVFCaGsr?=
 =?utf-8?B?Nk9GYmloR0lsS1RybXB6dHVWTVZiSzd1MnhNYjZPNUd6bEkvZEFCa2VhMXFR?=
 =?utf-8?B?NWVQZVE1NU9PV0ZjY2hvVmd5Z2hDUXRHS29hR2RqYmJ5dUdESm50ajlQUGlS?=
 =?utf-8?B?Sjd0c0NsRlUwdWh3dDE1TVQ4eEJTdTI3Yjh3ZnZEdGcrRmQvZk9DaFNCWmxQ?=
 =?utf-8?B?V3NobkdWL2g0LzM0bkZ6M01PSHhvVEJRanAzdTRmRjVNOTIxMmZSOHNFb2o0?=
 =?utf-8?B?dFRZaE1aTm9QQk5TTUxxOU02ekdmaUhGOEY1MFdSdHk2MHFQZFhRMDlPVlhh?=
 =?utf-8?B?dmVHU09yVHMzYkZ1THk4aldiVUpFV0E4cGx0NzVZaFV6ckM3VXYvZ0ptaXA0?=
 =?utf-8?B?emNpMHIzUlBKSTM3Q2lzSzMzNUREZUZvL2FDOW5zRW55R1FBbytlczNWT1V5?=
 =?utf-8?B?Y1RzaUlnWDNZakduUXF6c2Q5QXBsaGRFZkRja3M1WDBOMXZsQ1k3M20wSUNt?=
 =?utf-8?B?UC9kSktJaW0yd0dtdk8rMFVoTzhnYVdyN1UwV0VUTERBL1ljK2NGWFdDcGlW?=
 =?utf-8?B?YW9Oc05Tbjh4SkdtNFp1dkN0NFhjb0ZzUWNLV21sUnZjVFBWc0MvYXNWTTNx?=
 =?utf-8?Q?X3ye7hwl5RbXe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzFMejJLYUJEMndDTitSUHdVcVkrMUJuRmR0M29vWFR1WXhPWklzREVtcGMz?=
 =?utf-8?B?M3VRTDRxSjI1UUVEUENmaWY5NUZ3OXZoa1YxRWpKaFd0TmQwemxoRUFSTHQ1?=
 =?utf-8?B?UU4rOWNGMjVGTGE3bUlJaW8yMUQ1RkZvZmNEQWUrYkdHSElDRVZrOFBJV2k4?=
 =?utf-8?B?WjJGaFVSMmpWWnNzUmNYSWdLb2h4K2JxWER4U3ZDK3JSL0p3RFc5a2tJbnV3?=
 =?utf-8?B?emhOVzZhdjkwNGs0ZkpSRlNHZ2VNVy9jOFIxdHlhL21ac1pNVlpwcmhvd0Jz?=
 =?utf-8?B?NXRvQTluRkVPUlduUDZqaWwzaUNJY0g2bjZDM2hQTGsya01SclkvUVQwUGRR?=
 =?utf-8?B?TXhEdEo5OE05UVBJSFBaNVFBSVVmSDAwbFhENFlhaTR4NzRxbHFHVnNFQWlN?=
 =?utf-8?B?cVZPUUg3bDdGenR1MnNVbVRUblNVN2RSRm1uMjFoTytUbGRPVTIrR1JsVTE1?=
 =?utf-8?B?UG9UUUp2UzJ0eXBhbjAvS2NTVkFGMFgvMEt3cFo2QnptY1pRN0RqRVhYQk5j?=
 =?utf-8?B?SUNtYzRHVlpsdS9zM0l6Sk1oaEJGSHkwL2czRVhoay90bFdpV2N6SnF0MXc0?=
 =?utf-8?B?ZDgrNGVyemk3UC9FdENtOWNhYjY3L1l2SEM5TCtjd0FVN3hnZnlOWHV4WmRP?=
 =?utf-8?B?Q0ZvU3cycWRWVmllSjhsd3QzTjN3MmdubnBIVWVrUXpnREhhaVVnNHVSMlpM?=
 =?utf-8?B?SWNSU0FSM2gxa2s0aVo5M2VnQ0hwUHhUVWxlM3B5K1pCZUFSRnViWW83eGJY?=
 =?utf-8?B?Qi9IM3pCT3BDTjRZQjJvL2p2dEsvbTRHaXh3ZVNaSkdUdlZuMjJubm9DdUFu?=
 =?utf-8?B?NDBqWDdRYzFYYkNWUndlV1BQV01KbStRaGtLcFIyWWlpT3B2a3dESjdwL2FH?=
 =?utf-8?B?NkZYL041YTd0VmtrRmQyWFdNRGtCdERTdEk3eExKUjRiTk96QSt6S0lBSXAv?=
 =?utf-8?B?eG9yYW1sdmEvbTF1QzAwemJjVXlWSGpQVEYwbnI5UEc2d2h6RDhGTFZlOWd1?=
 =?utf-8?B?OThlc1pUeExURGRxSzFQRW5rQUg3elE0YUl2YXFkbGtUeTZhK2JnRE5XdHdv?=
 =?utf-8?B?a0tEakRLQnZSbGZPYWMvVTFJcGdPTzIyV1Z4OFRqRnJRSFArOURUY3lOWjhQ?=
 =?utf-8?B?bWtrWlQyZ0lwNEJUVlRtaE1Ec0tGL1lOOTdsYXUxOFRjczh6NDJYZmdkZ0lk?=
 =?utf-8?B?T1piTUpnZUZUUSs1bEV3M1NLQXJpbjRubEp6a0lRWEVIWWg3NUtXa1pXY3lV?=
 =?utf-8?B?MlMxMDRsMDFlTkxFeUk1T0VvendRNm5IbVhwNlprZUxWVVNOL2JtM0lqQTll?=
 =?utf-8?B?Z0ZoS004NEpiSnlWZERvbjdjcHdsS3dUL0t2ZnRYbkdxWEQ4U3Jia2l2TmMr?=
 =?utf-8?B?S002aG5oUGVMRjc3Y3pBdDFrTHlPY2RuODhjWWxYT3ZCUmFRWnl1K3ZZRHpp?=
 =?utf-8?B?SmJ2TlJ4Vk9lUnkwVWc2VExBNVJHbGNKV3VsbHFpYThOVzdEb09EWGFwaWhW?=
 =?utf-8?B?S1JRWGhQRHRYc2ZMMkI2TGQreHo5QW1POWxqbFA2MEJQMDVzL3dhSlVhazUx?=
 =?utf-8?B?VGVML0d3bExUWDZDUDZ2VTNIQlRPZGxHNUY1Q0szd1pzcGNpNTRQUmdSNjll?=
 =?utf-8?B?b281ekh1WEhWbGduRFVNVlJDbzRGdkFFbm9nU2xtQzQ4bjM2SGZFeVRmZzEz?=
 =?utf-8?B?Znk1M0F6WkxSckdnYXRTNGNDTE5qSWRQVmRpWTJJdWIyaEJjLytlVEdyZlZX?=
 =?utf-8?B?MTlieTdyUDJLalJ2MDNFOEF0eDU2RU1KNmYzODF2by83VkVsN01TdVQvNHFk?=
 =?utf-8?B?NXVHUWl0K3VVczVRUm1NZGFvUzRvSkpubUUyRGRaVTJMNXkzNUlSaFpBWkxo?=
 =?utf-8?B?MXc5T1FVeXVtUFJNUVR4MWNJbkNBTGpGRWh5aXplNG5FaDNnQ2VwUkp3enlI?=
 =?utf-8?B?NzhPb0kzNUt6SWhkaTRUMVplODhSOVlQUkpsN1Flc2F3c2pWTStyNHhDOXZY?=
 =?utf-8?B?cWt2OTBxMnNrVjVBRVd6UWdJeHJOZWoxWlpjeFhDVGNVZkN3ZXBJWSsxVnpj?=
 =?utf-8?B?NVN3TTJncC9oOEYwS0hiTVFIU1p2em5OTGFnSW4reko1amJOa21FdSsxdVBN?=
 =?utf-8?Q?ggRME0f6fc7JDViZZv/DENHqT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pbHowaRMC2C159E3enIOhRbAjlYnSAuiNcCd54EDbZK6lP/7ulkLipZLtW359hBqCmhW0fdkCPJ+qkJeYwP11BKsAFOnFfxCTMe1FgR7TCJP4ROTGz6bOz2Q8llnjFa2DDS4f4bmOZewzF2yuOnCNGOJR7IvW8KOIAjzpAVNlpI9Bb1/t02pnMZZ6pWg1ucusE4m0DBeoIOrvv93zHyqI+Wol9LfybfXfwMP6e3swGMmi8dzfi4RLNPjeR2wrOp2vesb/L7fb8AbSe+4zlVoWSjLfx3aiOtgkPF912YG1VmQn7tUVjmGtD5LAXLrDGYYYvA+ttrGwE0uf2FsWSbRAv2LmiClXWSaWl9+JlixL5T641idPkgcytWA19ic0Jg3ZvpiqrKaK3UnLebZn6pyAF5VueM8egSNaFu13Xk4x97ko9LpMrVtd3iw9htNBOpaahW04LMFMg7SxSOadEDMTwMOIqau3Oo0NHz/emARrLkv4iXZS9AkDvmY25SmsM6r8XCsD2Ro5OAmOIqsR+HEUUoORtoHZ4+Ryhu+CSXysloM+vfDRbl1tW2CHVvuxIverRCmROl+8f+9odHzuDLdIiM9whcpgM60iFfhAm8MT9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e110808-0293-45d2-ad53-08dd5a59b084
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:45:41.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbJwUPYvP1AfCIz2/JVr3QMX7YKzY1niK/J2+tO4CRGll1KfDIJzTV9imPBZ4R0ZHy/PbcOOBXAVds/Z5dEr5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=809 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030105
X-Proofpoint-GUID: f7C3l9Pq4CTEvxpV19FpEUj-uD5_W_9m
X-Proofpoint-ORIG-GUID: f7C3l9Pq4CTEvxpV19FpEUj-uD5_W_9m
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6hMt25tFzG40W
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711450.5306@xWzmGB25uMgDaxn69vRKFw
X-ITU-MailScanner-SpamCheck: not spam

On 28/02/2025 15:39, Darrick J. Wong wrote:
>>> One last little nit here: if the filesystem doesn't have reflink, you
>>> can't use copy on write as a fallback.
>>>
>>> 		/*
>>> 		 * The atomic write fallback uses out of place writes
>>> 		 * implemented with the COW code, so we must fail the
>>> 		 * atomic write if that is not supported.
>>> 		 */
>>> 		if (!xfs_has_reflink(ip->i_mount))
>>> 			return -EOPNOTSUPP;
>>> 		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
>>>
>> Currently the awu max is limited to 1x FS block if no reflink, and then we
>> check the write length against awu max in xfs_file_write_iter() for
>> IOCB_ATOMIC. And the xfs iomap would not request a SW-based atomic write for
>> 1x FS block. So in a around-about way we are checking it.
>>
>> So let me know if you would still like that additional check - it seems
>> sensible to add it.
> Yes, please.  The more guardrails the better, particularly when someone
> gets around to enabling software-only RWF_ATOMIC.

ok, but I think that adding it at the start of 
xfs_atomic_write_sw_iomap_begin() is a better place (to add it).

It seems a bit neater (than adding it here) with the retry handling and 
locking/unlocking, and would save adding it in another possible future 
callsite for xfs_atomic_write_sw_iomap_begin().

Cheers,
John


