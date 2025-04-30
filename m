Return-Path: <linux-fsdevel+bounces-47752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E7EAA5516
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FE217B29D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA27627933A;
	Wed, 30 Apr 2025 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xlgfj1+i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NFbaPj2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D8277035;
	Wed, 30 Apr 2025 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042891; cv=fail; b=bXIq0sSbi5+cBp1cxsVnIJBD1Rn0v+3k7+eSuAMrgL4y3A8frypGNIpvSyShZYV0szkN0izQdVAgPlaR+PoQAnaqnDUYowjnEf68JH5BERlTguX/B8kNdrCUCoKz6Lq2JpmXJ0VfZ78sqBx6UjOaB1k6tLJ2+zW2uMCn/p9ttmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042891; c=relaxed/simple;
	bh=ag840OWJ74pDTOnxviG1+PHbJZvJTBNbBMFdFvvOTFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f1H4ClnCpEwssneTTSHlZ5tTW0imBmj1DUcZCJE2r8KU9M5rSPJA30xHHc/Rl0k5jHxG1bMiI1ph5moa5KDYwcECcOk+cIt/6DGcSK/QxcU1oJQK3TWtSxOUAjUtl3L2tXYJgPrZ1JQto2WMU5L4JAPymeuOCqyB7fNorgIPbcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xlgfj1+i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NFbaPj2D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHu5rl017293;
	Wed, 30 Apr 2025 19:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gfV7rSXUTNGqd5Is+eYqmCiCyC2f1SwBgKzwZfgphZ4=; b=
	Xlgfj1+izl0GLeV4baUg0EADwDlGhggI59SW8B0Xqsn7LCzHJvyhaRHDzhf9IyyT
	/R4GTycFEStLV/eFJMr4H4YTqLryYINvezaR/XDXJYX6Fy5ooQ7viA6ziHxIldsx
	Ye8HlStXh+xk9N01oCp+aX5WpilgKDPCKqsdyHgw41HDfJVeGuU0qYtwJAPCtkra
	jPdvD3BVG4l9gr25vAFgMzYyfYm7IfztwUKs+W5ORQHDtxg7v3xgl8jcRTBrfiUS
	W7bQhKGdCPuEPVFsbuD0jFvrUDgKqVNUO0SdY3v13CXN8mvUoUMvvcLGLicDNcJh
	WkLJh0pkogvF0s5UAgaRXA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uma01d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:54:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJOXFQ035359;
	Wed, 30 Apr 2025 19:54:36 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbhxpb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:54:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYdjciXPRJ0vEExzoNWimb8jONHQlUQkBsDd9UKoHMw+COrAqjgLrmgfH28okbUsGWTOAdooqyqhck151p3YND9oNMeK05bouicJkT15bY1LuzYrxNVR0pEzgLt1YmhOhL4OkgKnMKIGssNN6nS3ESfl1Zj0uFsJKA3mX7y+Ts4d4C2yxWx/fyMMTRS42Qt3WcAN/Ew6+CYaWfDQalIFAO+lz0G+BiVfNvo2sBZpztMLZtbSupqAYiYcVo+cscTToozcbNCdprNbwggjaAbsHpYuDJOU6HouiR/doL/OXnj4bfjxfru9BkWC+5sjOIdGxHHlftieCokC5idVyNHXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfV7rSXUTNGqd5Is+eYqmCiCyC2f1SwBgKzwZfgphZ4=;
 b=Z3dZB7WiNqbHIEI2pmjv8bK+kG0h/4rr75N6cV/MXZS8A6B1EF2w8QH2Ddn8md08mSIgt4XGm6haFlN3gmmlzXUxO/wZsr/hUK6RM6kYcuWPJaZOHgfjVigEoes1U9BO0RIihcbLuKDtUAAqOIKsHfRvzEOZxIRhlN2naxEqbjb+WB5nKz19exnWXSr+LMfTp135Y1+rJ7eNQ9DfbPuanXtSZB6j+aqN/lGbTIXdFGgR678mneT/pDaMmBIErPWxFhBU0kTYFZFJsyY0G/doZlASi5BykAAIHm1jhHobwLA4DPS/CI9SnWqg6bHnxuJtCiwB5iL16RYWKap2vb0Z7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfV7rSXUTNGqd5Is+eYqmCiCyC2f1SwBgKzwZfgphZ4=;
 b=NFbaPj2Do3WRiK4EQHNCsqIRrWos32eiBa/IFCT8p4CDEA3xASMn8pcHhAek7H3+JwpoyaZV5xm+jVrCVrX2M0fjShtPYMpj2ASlHAYfAYgkqjDmiXH4q0COpPq0/AOu8O4zStRM5DaCqpiMgN168BgCCYDoo6zinXbFozeIu8o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFFE8543B68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 19:54:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:54:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan --cc=Michal Hocko <"surenb@google.commhocko"@suse.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 2/3] mm: secretmem: convert to .mmap_proto() hook
Date: Wed, 30 Apr 2025 20:54:12 +0100
Message-ID: <7bd9f0abd33677faa7d9aaeabede8d310f361a16.1746040540.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0391.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFFE8543B68:EE_
X-MS-Office365-Filtering-Correlation-Id: c97dc715-c609-4b77-91cf-08dd8820d42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MQj+6v7GN+WVCVjYSww1CC/0eMLFEiZOmdvGNYOsbkAqGpSsMaa0TlP0mP8k?=
 =?us-ascii?Q?5PmF0jYM3AHN0xCnMX64y6UZYzq2PvMOrkhzkIAiTK4GAlRqobKevrKXyxYi?=
 =?us-ascii?Q?boYsdITNYQ9hvxZuN5Sd2/W5KupXSipQdYwKGde67HzGz/hWEpr7HMZzo/7q?=
 =?us-ascii?Q?+OycPfIL9xBaczyeor3EnlNB/sCdp+cTPpRIwjjXij2iDvy1iUbFefnn2vzl?=
 =?us-ascii?Q?XxDUPEfLtJ6U05jRITabP9xjVhJDXbvaxhAj2mG92f9tI/0JVIHeTsORG74i?=
 =?us-ascii?Q?PtNs732IDKbza2G1G6danmCcDTxP1/4MreKWwpo/tyvT4jaYUXXHu8aGPQZb?=
 =?us-ascii?Q?cnqfS5LpOxWzcnNoCnOB40SNwJgHFCDOd0SHGM27JLkXAHgKi42J0e7H2R3Y?=
 =?us-ascii?Q?2w1Tv0a/Y6VU06iXrfz45X3mdi+MoXevNDjetY6vGDe011TnK+ptm+cjGjPH?=
 =?us-ascii?Q?UrhBq+xnQkzKAyN7g6BBbm3uhiB+dEUR8VOrVo/JGBq6Q6kszAX73WKvgzV1?=
 =?us-ascii?Q?NWtu8Dd1mNDBuW/ll4oBZ+VyanKB5ZsODBfPPPLH/BpC0kql19HVZ/lTox95?=
 =?us-ascii?Q?y01q71j2MKBNgILYRBEh9W+dyBYVlvc7MUwUlSE1UiVDEW6i1OvwAjY3gQHX?=
 =?us-ascii?Q?82I9gfyfizmMRtqwLigl197yDD5JwAahAXe/FmZvoAy/aShpN6iaLJ9vj93W?=
 =?us-ascii?Q?w68TFHrEFivFJxga1BweSxio03ptNMR/CwoBZq4GRcUe1VKgdF57zGv9QWd2?=
 =?us-ascii?Q?q+EXs+Zi/4aZGL+xaJAWB2cIpWoLsQYPY5GLs+qSv/mzA/APzmMsfTnEDqKz?=
 =?us-ascii?Q?uJx8ApIEOCrJW0tNLkwzV+v0ksEXOih5ZKHP96+sIqs6YP++rUM/3SxVKDY0?=
 =?us-ascii?Q?sKGFviD/wca4ZYf4MqKA4FSaZfQN95Pod0/DZKPTfKf9Ikmhjcqf1582JqRg?=
 =?us-ascii?Q?+PC7VSVqrYZGjLb0nGKT5eGUJq5mJcgzKRdNCMsb6UXvya2E7kj18PG8Hon5?=
 =?us-ascii?Q?T1XXbXOBhY+ANths5pGkQqbZk648THisCzKCjravG5rq1pj6yh1Xq6AnEGKC?=
 =?us-ascii?Q?ai0s/hJgnPF1how3lIS0hT3sBtWFdQh24M6gvFSP2ccVxNTTsH/RbyByOyJN?=
 =?us-ascii?Q?l5Y9OofdjZAnrj60Aq/VWiIGzyHtCXozf2FurQf+k/n5Zqvhu/xeYzILfdR6?=
 =?us-ascii?Q?OCfJZHNuSSgrRPYO5vx5keML6Gbzmsm+aHJcX/626xaPEC2tv5iuosmam65w?=
 =?us-ascii?Q?20UfCoqEXfEc13yx4JSUeXuMQvZH1wo4QNKFHSxqCSmZoEIcdJulVKGLA652?=
 =?us-ascii?Q?uJrjvDLcMwejyjg6lZRugiWM28PvYwhg+IKjgAGV8i20f6hSfLPJubbzd9lg?=
 =?us-ascii?Q?fGqT6wR2xhqESthyWbBKP+x8/upS/jxVns2wVAJEKJVzWHsMGdefwg4irEgy?=
 =?us-ascii?Q?1VgggbvNgT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j94afhlZLGgkrXCMe//ZR0CFyzqFEzVx5S+3Z+t40S2t2rtRkzSl9TPlxkyo?=
 =?us-ascii?Q?rzS5OD1R6Oszln3AAM/Zu1/lJ6Fifz4A43ziRhZbM+nhk6OTK94016nfQmgG?=
 =?us-ascii?Q?S2NK7eVDY3PHKIFcnEEuWuZgsBDmfnp5gtW3lEzW9BVfSEi5FkEnJSSS8dTD?=
 =?us-ascii?Q?V5iEzrMUhzAbmZo1iBHSzm5FcJ02q1UmPDhMt4NElWUhZfDhH4r8XZdaeTej?=
 =?us-ascii?Q?8wH22XXiPzuNAOBV+qSs6fQHeBV54KpA0+lbThabSHIV+LIkDbr1/a3M95WR?=
 =?us-ascii?Q?eQWP5cWK6AcwOXEDP/DvNGeSrIC8QKT45Wx2BFkVHgf+5lpTqnvQ+4sFarbo?=
 =?us-ascii?Q?Ot+s60jUpBW3mUhdp1bNAwzA0efqIf6O3kASAUIixuB+oDIwx0Wmk//6cyLv?=
 =?us-ascii?Q?gHLdcD/H7FfIUlNfaiUNT2Iq+o3rfQ5EIz703kHwye751uloj/J6hCvCOJq7?=
 =?us-ascii?Q?cL9D5KBr1iIIBbiQpRpUK8wGJb3jyOfJPSFsgIPAYZNQMOzHRDDjFmznP6Tn?=
 =?us-ascii?Q?W7amJXOrLFk244fWySsLb3Qt31Rjg5dv7aot8aaJ85Ixx3BUtS93/twJN7yI?=
 =?us-ascii?Q?Q5dKLsS4tgmR/RAA/J+3WPH+w+euFjMcBIlBrkb7IAzJ357L5de6pmgrsGGq?=
 =?us-ascii?Q?QhKgUsfza2MqlcKWEXkWHVW9oKR91VXVlLpBpiQJV8kYIZxUQxxr2p2s1VB0?=
 =?us-ascii?Q?iWmy3F5hDLcm4VuTYFz3xzlRBIK3U4dbn74WTwbN8yGU6oil84ZCFikN1jdf?=
 =?us-ascii?Q?ZnCALJIBKa/bvOIO6FCPZOYHKTqoactTCPBZDjRya1BCts4ecyPLwY08jJ8D?=
 =?us-ascii?Q?2EUzYnNZMP6+5s6hIpXti399IkY4vv92QXn4UrmgeqiQE8okxPAcCiX42pKI?=
 =?us-ascii?Q?40X6/rhxtzhRjnWXC9sqi3ILJHsvXvrGLo5xzWVjx6H2IiRLhEpCtWGo5+M+?=
 =?us-ascii?Q?Ye52r915zFX0HDmaZveHIEfUtYEd0CmYn21Lg88UxtvzdGY26CcOYZ9vhocj?=
 =?us-ascii?Q?G2SaVMqA8COsEgmQdm39XASAv/w8+zirCwAvmdpfAx5owEBcktRLs7x5+2YP?=
 =?us-ascii?Q?TtnjBs51tAcRHBrppgQ44nCPYqvdc3TK8x0xH7YIxFkqDpt9kizW3j0VA6gX?=
 =?us-ascii?Q?PpSwp9S37sv3y37a49c8Ms5nZ8qgdLjykeuyM/fybs7hmGb2ul++AmC9Vu/P?=
 =?us-ascii?Q?vgf5vTc7CvKYrhc563yWozYmaqCvoQgPuG7yxwvI0WQPpHI/ykH6d8x/JSqR?=
 =?us-ascii?Q?X/71daPQNqdPlb8zQ/F5EKZyx9IkFP2l9Vpa2n/r29rtz6wNdWITsooteZ+4?=
 =?us-ascii?Q?Im9irtithztaJoue+LS5tm9N6Pd2cVQg7ua7kM7f5CDq2M3omcRnMfvX4la+?=
 =?us-ascii?Q?dzY/EueJsOofFIOikIlehNzmCfgM5CeoBiirVo5yoCuvxNYtSi7lKWTZ+gDO?=
 =?us-ascii?Q?rD6Jl4pkoPeGlsKqao25GcTpdc5tsXcVK61YPUJfRUX3vMasKoKWwwompA44?=
 =?us-ascii?Q?k3vaTGQBsg5bSpxYb2wctCWk8+cxKdZOyuoi5QpNz920sqGq2R6nimjRxyD9?=
 =?us-ascii?Q?6X1w9Svqdmkzg4gZcITDzB8sikvz6nGDnPdXwuDuSng+BnTgOij2hgWosMkF?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	omZJbWY8qZ1YCWJQDiqheKjioBONyRCMSTBAsSUozY2rRi4DBahAWBAX7aBEqTq+VTFOA1AGR4MqWrPNqBw0Ws5OHZTMVnYgsfXe8LzO92/iBG1mjw1FsFpJ0HulW5/VTqAxCppjBqMqCwNunw+mfxemqPxgZiEdFG7XPBRfWBnGNk2lfqrShFGOzqfwMOjA4qca9cYWm8IGkioh6uKH/G7Nj36i9f2o3qyYjykKor1Juk5EMg8WPDbiCKWQdjCUaGqiRz5GlrSw5yZrAsuwKmjn6LxVY0BCADY7pg1loGu3R0K7Q9w5+ajFVpgFTMQ44FszX6QVH4Jdh9TBreZyKjdYiigUNRZFOTa5SJ4tUez+OkbCrp+DF/+nIEkgQi6/edfuEfwvoAt3xTJ2YU1+hAj6jxdweDbMu35D30CPq/w/PZyGHq9dtbv5rBUdD6QxZ4FcjxvS209O34LXBiqWAwICuUyXLSjx7L1orlHmugLSg9F2/4Jbv1bip2uqe26kyKsTsWNn6beEZQ/ywUxgKvJNKLbAbyDAX7h4PorN7NkZb7hwDN/5fSp1p4l1nIbrM43hv0hSelYniIRsjTmEOwBsENDFQ8j6T/VaZ1ukfS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97dc715-c609-4b77-91cf-08dd8820d42c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:54:33.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2VPuGmDVVa6JdDgtCt4AgjjRD3QafzSCzK21hLXvT0OBAU2WOhePRs8hRTSuRc9gc14iadEdWrNSsGfjG3uqKzjCzwd/RYo4C4rI9KAdJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFE8543B68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300145
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=68127ffc b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=eMrKcSYToJjtSuUrl74A:9 cc=ntf awl=host:14638
X-Proofpoint-GUID: zuekBlM6S7SkGXU1nZHK-rETgp7ErFz-
X-Proofpoint-ORIG-GUID: zuekBlM6S7SkGXU1nZHK-rETgp7ErFz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NSBTYWx0ZWRfXyad6qBrmFA2L HxAe9Cf9CB0M9sB2mGZwI6ZYYAK/ZZ+nZp1/r/p6de82srsy6SSR+s4CyznoXUHuyJFHEIimdEk zNk5S2FrO1A7GSqmfgzu0yv7lyz9Zg4Naygh1o2qanMPd70+wYgepGYzmpS9LReMVT/2hMtZyHw
 ZY4UASZdUzTVw+yRsH17JIn7Bhdmy3PkGjUOFS9Nw6L1hCyrqSFTSIW43Pw9fQc53tjjgf3odhd uLkHPXVHHHNK0MqDQkSvdNiZejwD50TWBpz7u8RQQTkiHtzHlevDsiQaE7zyn6+nR1qaYcPTy4s 37/sXB6sMEa+3XYSvY9Awhq/bfTbuud874YQiyoHcQ8/NQMSKKapLSij1HYP4Myg3lcFGOSy44f
 8aTUgRp5fV3mtBhVlCaRkiqN9XfFfXFBjsSs3Zl4+wZtOXTnX2x8VxBUBshiTjx2Imh5eT6d

Secretmem has a simple .mmap() hook which is easily converted to the new
.mmap_proto() callback.

In addition, importantly, it's a rare instance of a mergeable VMA mapping
which adjusts parameters which affect merge compatibility. By using the
.mmap_proto() callback there's no longer any need to retry the merge later
as we can simply set the correct flags from the start.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/secretmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1b0a214ee558..64fc0890a28b 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -120,18 +120,18 @@ static int secretmem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int secretmem_mmap_proto(struct vma_proto *proto)
 {
-	unsigned long len = vma->vm_end - vma->vm_start;
+	unsigned long len = proto->end - proto->start;
 
-	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+	if ((proto->flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
-	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+	if (!mlock_future_ok(proto->mm, proto->flags | VM_LOCKED, len))
 		return -EAGAIN;
 
-	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
-	vma->vm_ops = &secretmem_vm_ops;
+	proto->flags |= VM_LOCKED | VM_DONTDUMP;
+	proto->vm_ops = &secretmem_vm_ops;
 
 	return 0;
 }
@@ -143,7 +143,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
 
 static const struct file_operations secretmem_fops = {
 	.release	= secretmem_release,
-	.mmap		= secretmem_mmap,
+	.mmap_proto	= secretmem_mmap_proto,
 };
 
 static int secretmem_migrate_folio(struct address_space *mapping,
-- 
2.49.0


