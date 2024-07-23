Return-Path: <linux-fsdevel+bounces-24150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B74C93A4E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 19:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE46E1C21857
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B397D158211;
	Tue, 23 Jul 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FkUwrS+M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rJsXsQZR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955BA14C5A1;
	Tue, 23 Jul 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755252; cv=fail; b=DSnPlkjk1ea87sVaFg/dncOIumXeit1qqeq0U4m8E7+JWsO+Jy8JOcX3ixNM6OjLnzGP/RMr7BDjC9JXoGpDwK0PakG1PLMlH+EqPWjzMfnrB7/tvFx+q5+lR3+27PeH1kVO82uQi91m2KOhCtg2tFRcq2blAztxKIlRYqKt2ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755252; c=relaxed/simple;
	bh=8kPMXtsmiN3+sTmh099wcvgnMRxcaYNxzecjJ2zWu/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSZH2XBwV0hE8i+APQuDPFAHSgiXUWxknfb+jOkgaKi8wvwgCz4xJOLBjluSjPJxhtE6qip1iXKTtPXl/hW/G9f4tEBA+nWd2wuDFv7xkSlZdj4srUpv+mlM+9FeP9qlOOA/P2NCtFzD+1zzj9UM5FBiOoX2u9feQWsS5nSsMOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FkUwrS+M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rJsXsQZR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NGQV4i023110;
	Tue, 23 Jul 2024 17:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8kPMXtsmiN3+sTm
	h099wcvgnMRxcaYNxzecjJ2zWu/I=; b=FkUwrS+MvgRWZTus7ZkYUWXwr5s+qak
	r5Gv2gK+LuNJobK6rgBO8/c9sKbOJtWnj8q3f1ry9z4LYHuCJ1IGrzS1sTUIbGFu
	OdaVdHfktdgzWr7sLlLYILsWS2tAOanAypk9iCI3SmFFzNtub11vZAAO4g+JmeU5
	92oC0llyMWg77Cw0QZKOY1U0JheKIIJJZXFH/oeS3QlKkD3kklaMtNJVXQ93+ktA
	YfQauAW3lsA4QvMyKogLpJb89C8GxKMWDFsw4ShfEwm5FeUUbC4/Y+pUWsgnV1xw
	5ZkEioC0tTK/L6jF+/zOzYN1y8aGb9fpY31Mk80zJxebnjtKljJWDVA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0f64c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 17:20:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NHIdV2040079;
	Tue, 23 Jul 2024 17:20:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26mrhvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 17:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2YgPL94TjBHxxlDv5sWHOVffPwnlKR+y/mHEr3OBwAJnc2lSweBakIfnImhYusA6SIL5wdcuOZ4SaDSNK7wATpEsag1VT/WailN++5siymCc3HOx9Akw3wUYiUHgcCFrsAmTQUoEk+T4WI2kKuo3v188Ta0xUh3T+rhkIsBGYt8i/m3NRg1wMHi3IJADAt9jGw8geBlUftmKlXtJAoRq5HUsdTI1ZfTDW+B5iMHDqvE9H7Nb60BsRHC2bqAOR+gMuew1oAZe7W5UC1BeHdW3QTs/HwVeSQ3bZF44OTFTbiYMG8/6kf3QwWyd1rp13Uin7XuRHJ7JBjEHxhAOdXuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kPMXtsmiN3+sTmh099wcvgnMRxcaYNxzecjJ2zWu/I=;
 b=YKhMxu6DHbnx+IS2+makRjPwGclLgZuLe1ea7qj66JfdEEQVfmMGiTzHSpVP158201ZkLzwlyjGpqLt24AlbKPJqBovkb9XG8sqIde8i9rfXyikH1AVNxL1b10pdCIB7nixuQxKeM/LpDxJGljTJJXL3Ss2LCxjf2iU4YBmopTU3OzodlI754XY6KR22rYtlpnqjryBhoYPeO5FTp2Hx6CpYT5b5OJPIfsqHiD8gEO3AUdfwRI+A2BlZIbwF87b5ed4kMoFgKF/X5JE+bRec2oYjTrY9Ha2Sy/XQeZPz6qFUe7yLtXk4TA9cXOGFUDgsHx4Epke/6o0VjATqItCKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kPMXtsmiN3+sTmh099wcvgnMRxcaYNxzecjJ2zWu/I=;
 b=rJsXsQZRbJs2TT82yDz5uoXqLuDATKl0vH2KtxRIk2yltQl0qtdB2vO9MAy0p/A1TBV4XwlCfDfk8r6c5w87JFb2OOZ9lwxBQTvHYIRv4SWRTGxt4d//l6Te8WTSBXuQePw/IRAdDF+jjF/MOzOLv8zRrI5nYH6qtxrElTXdvr0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM3PR10MB7911.namprd10.prod.outlook.com (2603:10b6:0:1e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 17:20:19 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 17:20:19 +0000
Date: Tue, 23 Jul 2024 18:20:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v3 0/7] Make core VMA operations internal and testable
Message-ID: <c1c009dd-1ee3-4615-a8d1-b1971f22a814@lucifer.local>
References: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::28) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM3PR10MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 01543917-4a6f-41cc-1e33-08dcab3bba20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d76ngoDScQxlyDJD9lSfd0fZ7JN9LnL5v2L7BIUqFUPEOAfNaJY47Hw0EEiH?=
 =?us-ascii?Q?cXF5jCAqIkiNuP7RqsHIsFCVmlOEruEPjGrbLm5KMNwTvkLfcJG6L9v8JaV6?=
 =?us-ascii?Q?EEpTG7rJBuu+5GV3ItVfoHdIuX0E0qyjs+B4LgHfOVcksYkcP7Y6l34YAeLz?=
 =?us-ascii?Q?Gs8li1bFe/eTV9f0BKeTK9dQUZkGTEFbPo2hlb7ZwcRNT6kwWQTEF4YmOl2T?=
 =?us-ascii?Q?8xSX4k+yHRMcAtB5yqW0bFEX0XeTyl63M9s7e2+pYPv32/SnONPEBTxdLEbA?=
 =?us-ascii?Q?1QXswyzRSDQBINL0Ale1ypiVLZx/2RAf3WT3wdZSGV4FtfAgsSf2doKIl2rR?=
 =?us-ascii?Q?KOR/2Jr6tjJsIcfHyFDB0cTob8Idr7c6MK51eZST45cX+CISsAdZs0bmbHHy?=
 =?us-ascii?Q?SqNj8s93F3oHcLMZi5k134CryXIXYArKx/UtEkMEwj/wxAqTg0o8ctO+2jTN?=
 =?us-ascii?Q?4jgce6mTAg86SRyg50huYfdDSmym78NfhIOYTRPRD4jAjCps/5zxlVSIVnt6?=
 =?us-ascii?Q?NrnC6qWO5Cx0TWHWLZBIETUAyPYekImhJWI9Vr/6zgzl7xjoth5I9axEkaoP?=
 =?us-ascii?Q?EXsQr7U4U6Mx3ef11C2azASOdmsqesORTh/Gkm+Szd0IgJcwjDwisF2KTfQU?=
 =?us-ascii?Q?KYwTeL5uzW/UMLorNngHrVdyDcB4ziAQ6BagYa080YmFr/C7bikee4Fon+IJ?=
 =?us-ascii?Q?frdVdEbYvRPRy3cfzzLpLo01dOq0hNKpP3/AiuCn9T8PRE/6JmLJ00WlcmB2?=
 =?us-ascii?Q?Wjrzg2w15KGUNpvEJo9F1j6Gfm1e6NIJ/I8dYK5YgSYhxDWKEGf52fYKAHq9?=
 =?us-ascii?Q?vPpaNRgZDJ5Dap0YZILcBopR0mHwV3qMRz3qPjBV/EIWQF/ZOrttJW+ri1dY?=
 =?us-ascii?Q?dHIvf2/pfQJwGNC2gFrfKJeNQBfcOdWW22guFt7ZRfc7oTUxZSj0sevHOE4g?=
 =?us-ascii?Q?lGrvZzshWjHPKP3j2HwK6jRE1cAqZPzmErGZOYotwS7rj6HgaEX63LSQmZn9?=
 =?us-ascii?Q?FjmbSP8gxDf3aOZKA+GSR2Ux2eN9XClLxAAUzyONYldn1IeHUz/b2jFtdOeQ?=
 =?us-ascii?Q?l6JtDV8oRPa+H2mTLM8eEebP/Qg3xk7QXUBzUMtRXmAi6X6vZrzzlBBfAQg1?=
 =?us-ascii?Q?H75nARmPBVDn6x19lKVV9/1moClgMvGhZBjl9AAxfsfYGuE060o2KFBrAJ/6?=
 =?us-ascii?Q?ZC/ptfqg+sjORuE3v/u9ULVNP61jV2mnq+1/uXO60zRZH+7ziyaQml6/2hYa?=
 =?us-ascii?Q?JENPDlKx5HtmRQjQMmi9ApK6FGHkKv8Y7iVQ/2fZ+NYFKopHq4sYIzjzpnX6?=
 =?us-ascii?Q?CWdcxEIYgjicj0Cp58Vci0HhwGDPw6GezHeTcVpxgssArw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FxjQo6BhEGMuPOotcbmhUV5welsFl7K2Dm3e2lkcVdBEv9DBIAAZFySOrFRe?=
 =?us-ascii?Q?xxdN7sWkPc8o25wU7yrNRpprcTxT1jPCueoCWzn6nfqMre8UdE08Ya031nNz?=
 =?us-ascii?Q?rHrIjXebLqVsyeNj8hNeDJotcQCMhsF1itHnhq8B8EBhSOqRJyuwHvVZy+N6?=
 =?us-ascii?Q?DafhijhmDD8m1aoMicAqrGQgMBPISzyprfJX9GDLgIuyzCAMTjA99el0lhp7?=
 =?us-ascii?Q?CNetLCXUmATeGhxQMUzIvIyC6tg8NKhTOsSQ4ZEll2x5HyDAQ0UcOqaqrzia?=
 =?us-ascii?Q?jvzVFb2/jFyvrGCywHYNaA76FigrfJITgbLH2pp44YxU6bClV1l+k/NLarqv?=
 =?us-ascii?Q?Xo1+1/CADDskHcGHdN52U0MblizCCQGAqIZOMCzS6FZ5G+q4SNvZTYdq6LYT?=
 =?us-ascii?Q?tJNSoZH6xvD+IkDNkRoe4u3wQXoyM5D7qXHytLW2hr3T5n4JQZYltSdijsBW?=
 =?us-ascii?Q?2uMA5uZN3/KJfKYbrpwls99iOBXAnMvozidMbgx5IbDLJoxtgGcSJC5oPP7J?=
 =?us-ascii?Q?cEa2ceGQeSJNCcw3kFFEonVCbBG6Rizyj7puo2nYQwjjZ6YCoupnFznwFls0?=
 =?us-ascii?Q?Wj81f/SiRR7jP183eOjpew17aGPXDx/hlQu6r89Gs00E3gOqVdbJA2QdpLZG?=
 =?us-ascii?Q?INh11l5uRQ6WNXjVy1vjY4bfQxTMi03TC1/sxMVrjvLxoQqZxJz5zlbtjYNm?=
 =?us-ascii?Q?RLRJq2MXL3SfCiJ3l9mVsZ5uftz2Mbos47oX5//R21BR7xFk1xX2Owm7uwco?=
 =?us-ascii?Q?q+Zhsdt6Kgp2tWbsAIR6M+RmMiuldbHgG1DQItDiKbx6z919NkZubtJk+NXm?=
 =?us-ascii?Q?NvIhqdESwiiLTR0YJv/kVHLYes2j/4W5F5WLJgl3KGSisMNqCq/UzXbtLQ2u?=
 =?us-ascii?Q?VVTJCICTdhfaRkNv0OeTpQ32vWp6ucVf7wbv+vT4dbdGrX9zUOM8ASRkHfQd?=
 =?us-ascii?Q?vbY3Cn1WW/SPwsMX8jl5dHj4RsIAI4I9oTmRKSt/QaTPiwBosdLi16Nu0M16?=
 =?us-ascii?Q?6KiZFjyXLJnvLndskJkjkWYYPaBnyn+jFbtQd1ld0GuCw6ve8sYX88YzhB0y?=
 =?us-ascii?Q?gloP1Ziv+APBlUURpptHxZuzs89aHkzXg4P5YUP/fY0UHNfTo/csGnmZfhGc?=
 =?us-ascii?Q?KUS8zlQNoPAazHytZ3CF/JU0bFaW5MAah+wguqq1NgiZ+WXqOi4htWUgUiPc?=
 =?us-ascii?Q?GgjEm6y+tp06bvWUWm9I0hrsGJohTeHLZ+rixtirAirQUOma0XwBVxsxR5M+?=
 =?us-ascii?Q?EQ2pXY4oyqYPoWBOBZlusXH3RSNKs88rOJidmkL3KZsgYtMYexLNhPv8JEaA?=
 =?us-ascii?Q?7MM3Rqiy9hBe77tJZ+Ftu/K7+G0wzN6+K+9JHEsi1ow1uj0aKyAxzgh212OE?=
 =?us-ascii?Q?P0kHfhhj2Y8oqor5lXvpZ3Rmvl/OGETepjGRrlYxFRCAVR9heEl84XDTvkBh?=
 =?us-ascii?Q?CW2oD4VaUpFDm9lH8Xg3O8elalpWgvuAf8zFwb2lkwikmEUZOqWcqwgYjetH?=
 =?us-ascii?Q?IJRGXNqrCSZmtDeua68JtT25uaAoh4EE5p3sAEEThv27Wa2A+mjNvIJHViBJ?=
 =?us-ascii?Q?xQvVbIN5a7Gtyt7049JB3LspcOoqLgr+N9vm/BYVm/kd1z5kANLkwz9p8T8F?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D36ku2yKMNq9GFN5rAV0AycxOX0kSvjmAk7dBRIac0D6b5FrW9kiuimfLX7TPKy/QvRWXsZcRoddWuUfdbq0b+BWs20GaDgmNTGCCR3V0xjuWAGmxaD4lRhEZN2cmkweFYCnTsYwVmEDIOqG8J8Ztxy27vjk7ehBPjnREEOQ9icYEBVcX6c0oCZAfO+RkO6snl3m6U2GIjTSugu+iV1NawK5cNnVHAnDl1iTlMZxG+kbhT9eqBehBGrrj6497WDrW2mXrX/eX5EGUhtb79D9U9hCrwPnZNwjIrOhmF/+v3sLQXgQ/8GOSE4S377zXQRYFMBf6sC/rOzLMqRLy1c/ab5GZrxoOepLYA3g/Tfdb9eyMbpSOyjbd01FVewT5yduXXNaHjMW9n+y+chUvuTUfuarXx6ek4Vj7lI4NIuW+tGojQ8rEGjQ8wjQ5vOqTgCXD8kwJ1/zLCl4erIgsgQbFH4MKYkPbtqvlITZCW6ERb4bU2niRZWD6/GTIyTMK/uQm0smJ1ExNOvSM0rroewxiAdkb/26NDVNUGCyioTXClaXCCi8zqLScdVBkw5J8mFcT+nKG3d8LjFyh/1FU9X6pQQ8CSnmYakcKSX/K26rrjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01543917-4a6f-41cc-1e33-08dcab3bba20
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 17:20:19.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2wafG+b2bgWjc4mTDlgSv/FGLpchH/jqsvXLEUuUW8AyyrbSHfCAOzsYfQ/hvxcL2Q27WJ86gWIaztR10eHHshZBKWg8YvF2Ujv+zBQmos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_07,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=967 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230120
X-Proofpoint-GUID: S2krt7OlaYjZCwo-cYTlGWm8z9zyhcww
X-Proofpoint-ORIG-GUID: S2krt7OlaYjZCwo-cYTlGWm8z9zyhcww

Hi Andrew,

SeongJae find a minor issue with some dud includes for non-x86
architectures, could you apply the following fix-patch?

Thanks, Lorenzo

----8<----
From 9a8e60c479a06201f00bce020798ae37158b862d Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 23 Jul 2024 18:11:48 +0100
Subject: [PATCH] mm: drop inappropriate includes

As pointed out by SeongJae Park, these includes are not always available to
all architectures and in actual fact are not required to be included here.

Drop them.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma_internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index e13e5950df78..14c24d5cb582 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -43,8 +43,6 @@
 #include <linux/userfaultfd_k.h>

 #include <asm/current.h>
-#include <asm/page_types.h>
-#include <asm/pgtable_types.h>
 #include <asm/tlb.h>

 #include "internal.h"
--
2.45.2

