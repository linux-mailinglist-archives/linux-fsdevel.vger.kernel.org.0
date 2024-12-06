Return-Path: <linux-fsdevel+bounces-36680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2810E9E7A7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 22:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A032857BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 21:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4E204563;
	Fri,  6 Dec 2024 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h26yBtLQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sXYwFf4q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60054213E92;
	Fri,  6 Dec 2024 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519731; cv=fail; b=HN0UOlyNTXzoz4LHCsnm0m1bQ30i74Ked0s9kAflZfNXNcsgYgEavsq7ZDLod0tKspIJWLK25NGQ7gO9DGKE1cBo7lEeibmJKNt+VMtU7YtKSyLiiTzDUl3Zi1fcyu5a76KHYUIzLnH0d4V0sSI63Z9i/1xP/JA87McP/nt27Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519731; c=relaxed/simple;
	bh=OjfWbASPKAj9gOrDQ4W4N7E96ttrBhyfkjcmU1e8ViU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HGTLyj7rCA5g5GY2f7gCID+5nx6nt0IFaH1ceaKDb1cRUkit+fEDIyo2A1U4SsjS1z9WwHnU2TGHbwbf8E1j4zXz1rNuSLPuIBOOhHo75P7qaXA7n703OENsOGaNyMvS+gle2EM4c7Dckdhfv7aXmBFg3DQjF4Ud5jqRwb/jgHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h26yBtLQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sXYwFf4q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6JMgPD028274;
	Fri, 6 Dec 2024 21:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8J+txWtZ2d5uD1bMPv
	YA2LqbaZWEG938Hg3+hcEi5XI=; b=h26yBtLQRy96/ghvpiTqH9RQXkhcUDnop1
	LbfpmKgMharZcJZB3jeuBd5JxlX3LwygiUk22WRZV9XcKw9ONyxDofk+zP83xxJV
	jRoAXZrclbnel3dEthFR2/jn6mDiSq4+VIBaSsFXLWbbOJiBdC7EDgqVzg1GKyl8
	DNsf5fpGWA+jPI+KfPfPflFiKYVgCaKvDNJdUdW5WB2MWaewSrEofOaIvOdh7OXm
	oBPnCJlQtyhv4Xi4QR4MlGnkpLiBdsOkMLs45CyY29J5UtAFY0t1gUzMT0Dmxpco
	3uupSyk8Rdhj4OyVzTVwHn8GQW9IHsUX6h7fiI/LbJFYMUd39w1Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4ce6t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 21:15:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6JdWZg011669;
	Fri, 6 Dec 2024 21:15:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5csk84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 21:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjCRtLGzV4DChmyYeAhb8CpTbnfdrQKkCytD2QWcRXPEDqZsj+SFUmagKLoZ6iN4reKT9fEaZIEO9oyc9BdRXpZkQ/hfnP2ChrRs0ROf1Q9xQg7F1sTTyPmcBPSdYQoIEc5XcWTevLhEf5G8I8j4mQ7sUXDmY1vA9i5XupOsYlD/L0Vb+EWhALuZGFI38tq8oP3WgzsFN7ON2t58xXSPalDRQIPhM7fGnBv7QkywPeBQqqpd1zSfRsLuTQ1e1bUDu7eOw+L5oULp71sSyWBQI5Ephxtqhn1qUScKoQaGHKWrHQHnSDZEtONwNrxyPa60V7L4buKm6m3LyfUvvA0iUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J+txWtZ2d5uD1bMPvYA2LqbaZWEG938Hg3+hcEi5XI=;
 b=c6ahXKRwNkXn3neGu6uJwBpH1J6zvxw+hcGWg+Ns6074KwJIC1BLn6a5EO4qHlboQ8lU06y4zOrZSBkRCeYBWfDAt2qi+VJ0Sz01fKOxNGzlJJRwVDmlLGRNCI3Dm1r/ST4gEbuf4fvs4tjsgwwuhOBJSs/BbKiaE/Zy5NIw3U+teR4LQmplB9pMivsXxYdKY7d5GCw6PQshGTuUznzvqAmphiDvGF1us88jYJM0nXjsgF17zyiavpTPkTaSdJwbysHlrC/Inoe0Utt6BX9v1BlGza9TFiJiNeJ42E9WfiCCHcfyYWb3D779EcuuKFPwrwapp3W+JzDKDq6sAeEtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J+txWtZ2d5uD1bMPvYA2LqbaZWEG938Hg3+hcEi5XI=;
 b=sXYwFf4q8zRsWmNnPR1beDINTv4hvbtXmtywUu+t/c5CJ3RZ73t9kop7HvBGQ2SDJpJFApoQUIcvCXBqUMVc+UpN+lr/492RpVaBpC3hYjFLJy2v4f2etlfwJ9nAmZHnvOazJ9puBFxJyLaUCBqM8Ekj3dM8R9CHV92Ui8REXK8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 21:15:02 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 21:15:02 +0000
Date: Fri, 6 Dec 2024 21:14:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, kernel-team@android.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <3a53b154-1e46-45fb-a559-65afa7a8a788@lucifer.local>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <Z1NjCQgwHo5dwol6@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1NjCQgwHo5dwol6@google.com>
X-ClientProxiedBy: LO2P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::28) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f3bd0c-059a-4978-f188-08dd163b0c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dWW6bNCc8TdLfPMYJ2rr5vBS3SrgnH1/Pqlo786SHM87gFKFVs+GXjXYo0KY?=
 =?us-ascii?Q?gXGX2sWpvubrQGwVn1NuR53Vxx4tQ6IS/UwNpNjlNw+m8eurE4rly76118Fc?=
 =?us-ascii?Q?s4x4C6ZzEdH3wrlsNeTqb1IXDxdTTymJJUyScGc5sMpVB7cUOE84sXwDxMxl?=
 =?us-ascii?Q?EKHqLIXyoUZvFaWkdvqoAXpT0itASXrAVIyp+utd/8D8eqkVwjV/Q9b02UGM?=
 =?us-ascii?Q?ecekQe0w98HEY6/g4HjXCpzcb21wov0/V6lDDqKdrC83dnJqxp35QzX7ATzu?=
 =?us-ascii?Q?U4ovu8+jc819VMTi0DWmW7nYI4n9l/5maoR6s9Mn0LmCiHPrvpRVIcj75uNz?=
 =?us-ascii?Q?nayd2A9x2fAP5pZKPACTHHJAKjZUol5HYphIgGLqtUGs8AmvCZD/KdWlvEio?=
 =?us-ascii?Q?GZE66uba2KpLRQ5XLWKbsSBhlLlGyX8tmq8KO5W2De9K2FV8wp7VxXw5rF1H?=
 =?us-ascii?Q?NRuY1ZD6MBghZOWkPKwvUA4LnMuGL9WpiYvJeEq6bfMjuPR1U8AUQx3oddDv?=
 =?us-ascii?Q?y2CYENqAO3YoMn5gBnqAI25/urNO2O4h/Aw7UDUJtKcEkCYHBQnWR96E7r1x?=
 =?us-ascii?Q?HsAbROdadGjxU5ag3TsR11n7hfjc8lp5u0/mnMtFnoW0B+56r3kdFKHmaL2R?=
 =?us-ascii?Q?P7zYwtA78SqB98Vw2B0XmasBzOckSlxjjVdqBjppgmbtWgIVFCUEnsp1D1mA?=
 =?us-ascii?Q?L704jgYS8QmAMj0eyl3J10N0glk1c58Ce5BGrEdAZo4yx+t+DuH+h5eura0J?=
 =?us-ascii?Q?w5jqPiU7dqfRtfmp4QyzRaVxmJ8mpvT9SdrSZaYjmjxD5ejcANOffQt03gta?=
 =?us-ascii?Q?w5hwlePszTRBoWSI7Fb//3L7TGe7WMQIhEQYsf5u4sIBqlcck2CTbLGdTk6x?=
 =?us-ascii?Q?xFd/2y2NxOYGR/PMzP3Q/3DGgjLlvcsbCDvA/Dn4oZvuLaFTOYbk6jCPD7kk?=
 =?us-ascii?Q?v3pKMVRPMhvPa0g9newfv4MY7SniOEmbQxMPQm7JtueIf9wjyaXtDhxsTlj7?=
 =?us-ascii?Q?nIGobpPytcqpFH/+McV4GvmpP9A6DZO2h/T63iU/3qZ+/6iQi1vPSpTC9pe9?=
 =?us-ascii?Q?ZOBoUesG0CiAeTf0dM8zmASHHhIilJSN+Xuaxp1Zhuo4orU87J0N75e8XNwo?=
 =?us-ascii?Q?UYq4bpYFM8gjyuWJX19r/AdA4+0eNR2aJmROnZ+0h3a9NNopvCX4WM9OlPCf?=
 =?us-ascii?Q?U9QF1yWM9IIur7hBam/AI+A4O4zv2N+/U/0jdxzTnBm9ZiZlQQGIkMqLtZXA?=
 =?us-ascii?Q?N/xFSJztnI33PZDh/FWAL1v8v25ZXmgc0vVvAsDoUtmuhfPR/+jIecO8wqy5?=
 =?us-ascii?Q?P4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OBQVVDQnLHUwhzYCA6mnxmG/7skqvESOkKiV18iKRZ5VRZKsg47l45fOmRcU?=
 =?us-ascii?Q?2XdXftLLq46opNATjollgrUW7B0GFD30PGjGjPRD6i5pmvTeR7C4Evi5FCtj?=
 =?us-ascii?Q?+MjDsBC02oe8qTmSEpCkbdmXKIFuQNQsO3/q3+Je9mKCzyx8OktNxIFpI5M3?=
 =?us-ascii?Q?QaJmt+XY6UxFzdqzOsvQZvttZitNyEofregFiJbJf1NQxCKfZG4xK+Et62aX?=
 =?us-ascii?Q?i6wP7fRf0pkg6kyeKYBUNZM32kQFMNLGwZI4578T3uLZgu9sjhJn2b6HaxZS?=
 =?us-ascii?Q?KiM0zif257TXELp+EkDMG2vZ6GHjjQvEZ0+WkBzpm2929X6JZ0KDg+g9stEA?=
 =?us-ascii?Q?IxEtqNj5HdwiSAtfBcvn+jbb8F0FoB3+15nZtgPcDnXIZ2wm7d64WtLsgSMT?=
 =?us-ascii?Q?qlP8XkIMobMVxmc+a8gJoOhlq7WR8zH2it/O1JWVYBjOWQ061w53Va1QKC0W?=
 =?us-ascii?Q?zorhzLlL4t8Y98LysKWF1UDtBlu3HTVpXdLNxtLwjQFP3XFvW5K9TjY0aRQc?=
 =?us-ascii?Q?OcbwpZqwtIfOzW8pi3Nsuiap3eoZZi8FReLA+VRtfBYprmhuPTw4PG4M0CDl?=
 =?us-ascii?Q?aXBv742m6jbQfT32oxOGD2PZsC+bfgZUQFUA6VcRvHyZXlx02H9qK1+Ys9eY?=
 =?us-ascii?Q?WQTukAEJcV8eOd30V931pJnbEaSJzM/Ofv5HZFx3lfNuaD14VVCHzUeGtpQH?=
 =?us-ascii?Q?87U3hLuHjEp7YTwQo8trGHn7LO1+I6hLPhy94RmakR6NwYtGQ2hwFKcPAkKM?=
 =?us-ascii?Q?zA/+DiGCBdFvaRDIJc//U+OG+hxg0Fjy+5eZESBoaG2dM2TEpj3sRhRkX0br?=
 =?us-ascii?Q?Ub1qsYdjKeA7346gsp48K+eZDteGVl7MpYsZT8T7hPGU06HDzXLP6JktoHZw?=
 =?us-ascii?Q?L4tsk0TPEAfjBvOb6my8rKo1SfD07iIY8rU+OR4c5YA0BpyAvyvM3b4quSD2?=
 =?us-ascii?Q?RWg3taJFrCLpRB1MSjQL4WVbwlovHtzlnAMfvy4COqICIpKZ4NOvvDvcHaDP?=
 =?us-ascii?Q?fAjpVA4U+iaxYyYplh/39YllI2bNYqFf1ZWnRoKeosEy0HlQAtWwAsCgVvWO?=
 =?us-ascii?Q?DRXtRyYkS2vRD9iujIw4h3aDWKn39jo2C2KMlP5LbuPl46gl68G3uWzgznHy?=
 =?us-ascii?Q?RNahrzRBaq/eAdw4LjCY+W3sjKMA9EzYKY9+sB9SlgJ9UAo8VNJDix8B86Wj?=
 =?us-ascii?Q?krk4YFsOsLhunWcHDHtcvMBSAjC4WN26W2MxV/BLUwhQ43DyN0DVjaNv6lfK?=
 =?us-ascii?Q?74Cx3tKyxPTNRfBaxTNBtBXy+R2WULjXXZaVqN4CVfY+sjWdlFIcafW9dcoG?=
 =?us-ascii?Q?geIgny30lQk16yy1NzjedZOTYIBlTHo7AH1oFHgLxUSLdJmylY6XQdDF5EMq?=
 =?us-ascii?Q?wU11fYFD1xBZt7kod3brrPXUtfQJN9BLIU1xU0btFw4+f3XkbqutwFloBK98?=
 =?us-ascii?Q?AttKOVwopV+BmtMd5PQ84c7zqlcdjOgAj90KUJPTlJhHXjKrDC/6G0PnIbcu?=
 =?us-ascii?Q?EgK8rOfQpyQLkxF+t7Uw/gaIBIXl+QzxYymkj5uZmXqlI2b7hTbsb8l7l+8d?=
 =?us-ascii?Q?gQFJ3VXW8mFnwOFpAiJ4Y+heSSa9rUyk/6S8H5iDc5UoYo8CN6U8XuQrRKHI?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZF6vPVXi0/tSHGB8jp7w33ubPUwYOjWYBKBxc1EHkMjnRhbKFw8npQxQ/Qw0IkiNDlDvSlv7EuIZDbUIeoQQPovUmQuL5VXgL7/g68SybD/PBL+B8/KpxjNokOTnE06LWAwKqvUhh/CtAdwPQufBxEZJw5AZ5yqLxOyD7kN0DiX9flX2JAccgj5OG1FMxa4NcL3z7foPIXEBdVhNHpbDoKgkcDH9oNw0/TfMzNzW6T0xQcgFPL8FIczh2bLPmVpfp7yPR7jaSU7QyNArd9fOyZzuS8OBp7GYaj6jHkmbI8pvDDqA0WmAOzgReyOhZ6V4PINOwyAA7VrOYBcf7mVpRHmufGGI2qdW1h2MgYBEugNZIiMP7nyt+isoP3Z8gjyFzGjw7nT4lH96K/+RKz7m7DwGoq+b6xh8af6cARhjg7r9StwG+h+XCQeDRzCv6ncdhEPees9Uw0XU9Z6EqZG4xxluUnAsnRWuN++T/aUrAxk2qe8bgym/XBN4mvybrnpF0Vn9vl9TXYwRHyes3ONNazCZ1IlGZ41DpjZ/Jvjl4LRlv9Q8Rwr2PPaPECthRk5lIrALgarc/0PeKnabwybQ5U2YUqC+awp0Kz+VAeiQBaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f3bd0c-059a-4978-f188-08dd163b0c32
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 21:15:02.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVoux3SI35ELYu4Ce4zPAU3bD13k9SHtL23xKscofCHrC/J4ebmq2w88dVtXPU3lskZxMteq1tNRMOFGz81HufnHxgREssBpTfe9ApHEM2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_14,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412060160
X-Proofpoint-ORIG-GUID: 0AQBRm0E5-fkSUSIYlTMkbFjrcZR7dng
X-Proofpoint-GUID: 0AQBRm0E5-fkSUSIYlTMkbFjrcZR7dng

On Fri, Dec 06, 2024 at 12:48:09PM -0800, Isaac Manjarres wrote:
> On Fri, Dec 06, 2024 at 06:19:49PM +0000, Lorenzo Stoakes wrote:
> > On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index b1b2a24ef82e..c7b96b057fda 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -375,6 +375,17 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> > >  		if (!file_mmap_ok(file, inode, pgoff, len))
> > >  			return -EOVERFLOW;
> > >
> >
> > Not maybe in favour of _where_ in the logic we check this and definitely
> > not in expanding this do_mmap() stuff much further.
> >
> > See comment at bottom though... I have a cunning plan :)
> >
> > > +		if (is_exec_sealed(seals)) {
> >
> > Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execution?
> > I've not tested this scenario so don't know if we somehow disallow this in
> > another way but note on write checks we only care about shared mappings.
> >
> > I mean one could argue that a MAP_PRIVATE situation is the same as copying
> > the data into an anon buffer and doing what you want with it, here you
> > could argue the same...
> >
> > So probably we should only care about VM_SHARED?
>
> Thanks for taking a look at this!
>
> I'd originally implemented it for just the VM_SHARED case, but after
> discussing it with Kalesh, I changed it to disallow executable
> mappings for both MAP_SHARED and MAP_PRIVATE.
>
> Our thought was that write sealing didn't apply in the MAP_PRIVATE case
> to support COW with MAP_PRIVATE. There's nothing similar to COW with
> execution, so I decided to prevent it for both cases; it also retains
> the same behavior as the ashmem driver.

Hm, yeah I'm not sure that's really justified, I mean what's to stop a
caller from just mapping their own memory mapping executable, copying the
data and executing?

There's also further concerns around execution restriction for instance in
memfd_add_seals():

	/*
	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
	 */
	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;

So you probably want to change this to include F_SEAL_FUTURE_EXEC, and note
your proposal interacts negatively with the whole
MFD_NOEXEC_SCOPE_NOEXEC_ENFORCED mode set in vm.memfd_noeec - any system
with this set to '2' will literally not allow you to do what you want if
set to 2.

See https://origin.kernel.org/doc/html/latest/userspace-api/mfd_noexec.html

>
> > > +			/* No new executable mappings if the file is exec sealed. */
> > > +			if (prot & PROT_EXEC)
> >
> > Seems strange to reference a prot flag rather than vma flag, we should have
> > that set up by now.
>
> That makes sense. I can change this to check for VM_EXEC in v2 of this
> series.
> > > +				return -EACCES;
> > > +			/*
> > > +			 * Prevent an initially non-executable mapping from
> > > +			 * later becoming executable via mprotect().
> > > +			 */
> > > +			vm_flags &= ~VM_MAYEXEC;
> > > +		}
> > > +
> >
> > You know, I'm in two minds about this... I explicitly moved logic to
> > do_mmap() in [0] to workaround a chicken-and-egg scenario with having
> > accidentally undone the ability to mmap() read-only F_WRITE_SEALed
> > mappings, which meant I 'may as well' move the 'future proofing' clearing
> > of VM_MAYWRITE for F_SEAL_FUTURE_WRITE too.
> >
> > But now I feel that the use of shmem_mmap() and hugetlbfs_file_mmap() to do
> > _any_ of this is pretty odious in general, we may as well do it all
> > upfront.
> >
> > [0]:https://lore.kernel.org/all/cover.1732804776.git.lorenzo.stoakes@oracle.com/
>
> I agree. I really like the idea of handling the future proofing and
> error checking in one place. It makes understanding how these seals
> work a lot easier, and has the added benefit of only worrying about
> the check once rather than having to duplicate it in both shmem_mmap() and
> hugetlbfs_file_mmap().
>
> > >  		flags_mask = LEGACY_MAP_MASK;
> > >  		if (file->f_op->fop_flags & FOP_MMAP_SYNC)
> > >  			flags_mask |= MAP_SYNC;
> > > --
> > > 2.47.0.338.g60cca15819-goog
> > >
> >
> > So actually - overall - could you hold off a bit on this until I've had a
> > think and can perhaps send a patch that refactors this?
> >
> > Then your patch can build on top of that one and we can handle this all in
> > one place and sanely :)
> >
> > Sorry you've kicked off thought processes here and that's often a dangerous
> > thing :P
> Thanks again for reviewing these patches! Happy that I was able to get
> the gears turning :)
>
> I'm really interested in helping with this, so is there any forum you'd
> like to use for collaborating on this or any way I can help?
>
> I'm also more than happy to test out any patches that you'd like!

Thanks, I'm just going to post to the mailing list, this is the discussion
forum I'm making use of for this :)

I will cc- you on my patch and definitely I'd appreciate testing thanks!

But yeah, to be clear I'm not done with reviewing this, I need more time to
digest what you're trying to do here, but you definitely need to think
about the exec limitations.

>
> Thanks,
> Isaac

