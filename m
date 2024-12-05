Return-Path: <linux-fsdevel+bounces-36517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3159E4DF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 08:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844252816D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D331A8F72;
	Thu,  5 Dec 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O43+Cj5Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y6NB4nU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722E193419;
	Thu,  5 Dec 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382390; cv=fail; b=ldc/oFqd52DeGwcTVuDe3Zee2KArGTIBvC2e+NoGGE/7n4M3cn4mypCEpQ/DRn5vCeDvXd9h7vccr1PIVpyIVidGENuYYqmgluOZMYNzIg8TRpI1J1Ga4LMXLk/cAb8pKU+oATNoL3HuTzORbspc25BWc2RtySnHMx2NPxPtC2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382390; c=relaxed/simple;
	bh=BjUERLSjtWSYqTPiMMfgK9Hh761/wPL5zn/RzdqX3Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BS4D9nQ8MkElBNGYSZlV1vI+2f3eN4OJEcQzpZPxdCVlfVIadj3oLgVSBZzAGO2jgAaJY9F/aGI0J4x8/2VFkh+GAn2SihihGGt7Z8V2f32rhYdXEE86J9roNEkAdD+JS/sxbz0+q/q4VrppJ5y6Lr/Rt0xRcoUS03vhnFa61aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O43+Cj5Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y6NB4nU+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B52MxuE014882;
	Thu, 5 Dec 2024 07:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=A7knOvb1llEQkRtzYs
	aHttGTRpi2Dr697jBZ7qYkD0M=; b=O43+Cj5Y6qw/esHnBQvbnXsxJhqo5S8UkZ
	uIO3rWs5fkte5sVmZuZWt3FoyBWGjYsZAXw4IIJjA5GSW81oYllEG9VYhvSWg+5U
	5Ve3vyGgvAO3SwLhPPqaF2yHZVRYoKwROezA/s23L3KwXxncs+X0HCowj5ZJWccc
	cBXNWlAm5lK+pruZqf3uxZ2Bz+px88x+u+wzpk5prc+EtMiUw7iia1dSFj+j/r0a
	GiFQhMtMjGtXUA59a2H1jPZNNUbv9Td7ZiCeFa5fl+H50NUIqSA4Lm34SAWPrr9T
	4zmaRc3S9pknp6iA0nLV7TNa/Aam00+W6r1C2oiHMAJXT5isuq8Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk9246e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 07:06:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B55XtEc011704;
	Thu, 5 Dec 2024 07:06:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5afdwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 07:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UV0LSD8MWWg2wcYyZ5CBwhgEFZRXLXicm4QZlGU7XU3yVtifpvutALFgUyOtRvYIrCmDDsWPPu4q5s8rmf3j+gyBjXZCumOGmDgJK4Vpbui940VG8bs4Zr9YABiW7RC/fVs3qP5es8+yL9s17t/fthUyRkMseO8XZGe2hZ1iR6XtULgfIUGzTN8i6g8apTCD4xEDX+xltJloUzwCtxQq8iIIuQc2/4vfvR2uaFGc15huxS5y8nKz5IEMUNOeosyWjtZon2O0ybZxfBX9G9ynSih3cfak+aIbcYP73bFaVyT4hyjIEtR5aABhFyHQSRihMWzrrN/T5b8TDpM6p5NZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7knOvb1llEQkRtzYsaHttGTRpi2Dr697jBZ7qYkD0M=;
 b=RkdcA3KE2Jt0LK35DzsK14WCbPpz2Rvtj+y8tX25eFaaWYuxm8p7Tbm3RpEum5BGxe48rKSs/HSNGggKryACGz/blN5jSaZ+rzf+WFypAoJx9Qtv2jd/wbq5zzig7/Js2PObxf5CJx+M+oGkcXgio0AZkhH7/x1kt/QDjuBA5o/LFXqoL5pOL+klnmDvuraRCp/MUkDD8G7yRiF6jkMRjsVLX248uk1qkNBs7E2w2Xt36qeAma94c/qfUo7agHBvNFa9FRGFMntJzAaqVEywxXwwSlp7q2HWQEFIZDyrkw7imvnHblcyF4Skt+gnKFgSnKFbwfKl8L1FNp91AnxeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7knOvb1llEQkRtzYsaHttGTRpi2Dr697jBZ7qYkD0M=;
 b=Y6NB4nU+MmIIQTA7vd82wYGv0NsAQn8HJThFjahth6Jyoh/vH7c1pdcLzhC6K5YF+ZoXfAHMz+1HHwBHKQb+/e5KWZkpoC+h1htbVJDkbp3cEcNkfQ/6jtHMsyOAxNwdVsLWz8qyWztwjDKu7SuoR9Ra1i5zd9DS2gQv+AF9fGo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB7724.namprd10.prod.outlook.com (2603:10b6:408:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 07:06:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 07:06:10 +0000
Date: Thu, 5 Dec 2024 07:06:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: abstract get_arg_page() stack expansion and mmap
 read lock
Message-ID: <853b7230-1939-465c-ad78-88400765b424@lucifer.local>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
 <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>
 <20241205001819.derfguaft7oummr6@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205001819.derfguaft7oummr6@master>
X-ClientProxiedBy: LO2P265CA0343.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c2e8c8-3253-4848-92c2-08dd14fb4bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TXhu27/Pc7XKjuiWTzQCNk/cRG1jsLTccHmB6bRHjQIWyDwhFRo5x/Aqkaj5?=
 =?us-ascii?Q?7UhNWSyR324X+NIsM0fMZBxZFzknZKpwHP5YHrDjPJSghTVvWNWBsbm/P5Yh?=
 =?us-ascii?Q?QzW8qud3kS5PW2DuuvVKylsm+GEImUMKz24eh7UTf1xyoXZMPtePrb16KX8t?=
 =?us-ascii?Q?Nie7tLcKEZ3ua+RJXKhAJOVhGCASiaUI3+2e6I2fDbfXYfzDZreQDzJKyfYa?=
 =?us-ascii?Q?8kk4D4BZWuoC6IvU8dC+xrd25Hk8ef+G139eHvI0Z6eJTCv0IgERI7YjXX01?=
 =?us-ascii?Q?uQ4o3x0UVDOA9X2xQHuMbHBKRJEJN4d566mSg5vdElvQwA5IACgYHaZqMkNr?=
 =?us-ascii?Q?ejrOncPbcRDAwM+Y7EH1UPTEfyXyHd8xml81IPCbuHGD+Fl2wmfGwS/6+qK7?=
 =?us-ascii?Q?9Q2NjEfMzg1ybodt+RaZ59yKHKIR5QEiVg+SUQzGC2aUh5k6HtzdPXsW3Qbe?=
 =?us-ascii?Q?SSJWiRcwdhj2q0ehnUd0vUKhGKAoo2oYHfYvf2YImTuNslxWdBi7bH6cKWK/?=
 =?us-ascii?Q?7kEhPVogEclOSmjLkeB7KBONGCEhHN/reb2/tu57wwje/YMaebqPlwFjpM7P?=
 =?us-ascii?Q?cKsCYZ/WBlxjv1x1yYUl/Z8nvRxMmfkPRZUd5qV0oHfLMwBHtJ1hr+FpauGW?=
 =?us-ascii?Q?XO9Wu4O1znqCLrHjYxqnGZaLUlzjbNze9NM0cjpKc9qVRQLl1mkm6U+A54Ds?=
 =?us-ascii?Q?TgtsEpUhCI15+0lTQkDREUoHkqE1iB+Qb7GXQrC0SfhFi3ALtypOObnQ/5s1?=
 =?us-ascii?Q?3vwgkmiYXnkMuAAjZDzFUxFB9jiqQTlIHMcmOdpuHef6W7ppK2jjZQ29oz0j?=
 =?us-ascii?Q?kuJE+dLxVQhi/HQ84BeKRHRu8quNwPvUDNxMpFtt6PVfVKsEKWMyE+A1iLcK?=
 =?us-ascii?Q?PyDKoNDmNszqOPKFC81PI4zdQLvbjcU9rx0ScOPacZWbVA9rLKzPaRHsMs4B?=
 =?us-ascii?Q?sbPqIot4qFRF3vUxb06Gcobi6Lkd90911ob6ZJJ6UKLXQrURHrl1FkfBL8Qy?=
 =?us-ascii?Q?E3XYDbOVSpmca1Fn/rn4uT6QfxNzqSSnhmcvBl0qEMYUSyz52XPyHJjo8I1G?=
 =?us-ascii?Q?iFo/fOHM4WkeIQm2HxOIrW+InY/EniBp8Feh2uoo/zItCjEaDVJnNSWTw35D?=
 =?us-ascii?Q?moTW89NDzohrwftNCSyi0mgJ0cKrzHfePrrYH366znydxuJIkspV8TBWVNgG?=
 =?us-ascii?Q?MxORXpXAgECL4xXcAPJ1AbiIlAcdVZdqOc1WFSh2Zo/LBWzHW5/mvl7KvVdM?=
 =?us-ascii?Q?broSJhRqXnBhJCi63w+289jmHusfgT53cBrZZKlY4aLyX4FQzxGf+2zW9Wjg?=
 =?us-ascii?Q?n7b3gdAiIKUbOrVyVFCtv4iPj/wyquvfQC/27LGFp/uhEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rjpU1N7HyuZmVYPHWGHA2ISdRHei21RyOFmSkGEnY5sxWQRlxOtiQe2vq20W?=
 =?us-ascii?Q?NPTh9AZCswxB4oY+5SE1CpuYpGOrqEJJbx3K0WqWOGGd0snjQ5XMgK2hMeUb?=
 =?us-ascii?Q?ww+orM859QwwQ1bTrX+gLvHfFag49y5XthjyVnTAdbTq0bxG14vXbFHPRAzo?=
 =?us-ascii?Q?tZmjb9QdgyqTr3HpqJwDXKPpyesx0zSj3r6YN2RZgayL2xFXpoSIaQCRKe1P?=
 =?us-ascii?Q?d6FrLXbmX4r2n108x5MPSBGs0WBMr8pL6+2YalfAehoWxqUx5+QxqgRrMTtA?=
 =?us-ascii?Q?EYED2njSWJI+Ydp4FlE6ZLpu/TFPd9emMZD5yOlAut+PvcTauFWbS+9aOIbf?=
 =?us-ascii?Q?EExGW0ClwLdxtykGKTSCSI/Ad6pBXWsTDy6dnFc4asctjjlUdTnbBg5zdSyV?=
 =?us-ascii?Q?48FpJABxJdpOrlwIyFWKVkUOclR/EXB7DOaHS4lZkMJbQ2tdR9DQcRQxeYET?=
 =?us-ascii?Q?NTefXsUx48qZp1DmcSWpHDQ2sgGStVCbh0ahwH9jIYSwb5CCUuhh+VUDapYO?=
 =?us-ascii?Q?8bWu7XjNb0r4xixwH2+wBuA9GbpJWurRv/bWsJvDs0qxuIDV+PCtLOTXtebx?=
 =?us-ascii?Q?RX97VcKiknDq6iR03JgZTnkzo/k71pZzVwH2XFeWXwOtapHPD8IUkVFQBwMk?=
 =?us-ascii?Q?hs1s506wKD6rp4CPK69DQJY9llz0Be1jmKYXARqObq+oKSxDctatOMZ8Tc1O?=
 =?us-ascii?Q?Y4s1aLYD2PIKrR9UTCEZ3F1PqR4+/TM0wNtvPXqzVj8zzec0Ycl/T7V1OGNA?=
 =?us-ascii?Q?gw32etCM/UxZ0sFxr0wxpuXnKVjf/yR49u5TyqgT5fmgHRsnb1OnsDPGsY48?=
 =?us-ascii?Q?C6KuZgoLz0jhoesKjkq26VMDRb+LhaIgYO6vqLoyzo5gDUjSHgTpWp/qQoO/?=
 =?us-ascii?Q?3UhAffA4JvS2FZ7tRdtc23WJ+fTZt1TrzJfMONp4cTLKAJ7c9uEd2I3Cg+QD?=
 =?us-ascii?Q?G84i9DrohZtGNy8qwCTR5kL/Pvt02xa22TpqiYiYef9pVr+J++2e3tddm9VO?=
 =?us-ascii?Q?hFaJsGUu/doOVq1H5KhxJR2dhgKrr3eElSgc0gk+Nmqiie6ZKP8ahSmkljJU?=
 =?us-ascii?Q?5ptsGXdZkrEp2LZdcCUL7z1LpRKzX/1hke/pR1tKoQO1qDL+Sl23YpcVBWkc?=
 =?us-ascii?Q?yls6WdG2tfiNYg7md1v1h638RLm+DMgax6kYAowK2VxFCcy3TTSVDdbBprY7?=
 =?us-ascii?Q?ZDLnxgUhdWUVRBsf32zhgodpXqJ+Tq1eCYkeLTWkTqdEa8bZezTPElQ1ylwO?=
 =?us-ascii?Q?J8hMOcMS3AqRrh2ECAh1F7Alhdg/Sf7AxX4PwihZ5DSMoq91e9ZWbV0XyXCh?=
 =?us-ascii?Q?m9lQNBoO2RuQqM2Cci7LBTIiLpK2ORTs3sDKrprWFtYHQMzw8gZpi79utd9Y?=
 =?us-ascii?Q?nvdw5RDnogb5OIq0Q8V4mCRL01wz0o4/ZnhP1Pf1tC4S82P8pqrI6f2WScxW?=
 =?us-ascii?Q?1neT9xU1KLRc0kTyknjDKm1Q3+e4oAHLiDzt+PLBylt557zBg+scwzdC8Vru?=
 =?us-ascii?Q?s4QEwke3Dj5TZUUgiMRNQGAxNz34IxcVF+sQpbjhDDd+G8wEVzWKaKMbpQvc?=
 =?us-ascii?Q?U2E300qnWJGajvZonctimnnX8+BvF5KpNQwOetE7EOj8lFti0y6/QJXrr2JX?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LQGUn/Y8CON2HsF00M2NHEKByb3yw+VveR/qAwGlOBivJfXZdMZnR3soroFSjx4b9z07bwOhpUwzUkcDf3aw+dgGbT6pD9MnMkyTF9Tc5Pgl4vONMiCYj5rykwU5BP3oj+sx/IQnsc3yryShf11GDTC1E4tPL1KsPmu3PGB0+p6x6AJXeYKGSpTWiBJfQ1cURnX5ZrE7FKLqBTSIfu9nRldHao4/i2YUqgWAV+tGIiNOpSkD6Bnt9YnPyAGXOtfvHvX8UPATyzVFhaJoWI4LITjkze5fun2wQbNKlFaOnqlaKzLLS5aByO7BxWX5ocjV9gadjxt8KnYMfqAKQyK9K0rVxlpV9UqXu6h/D41PawfKFtlCnZRT5YXwxgayVn8LWai5XIB/AYQG0WUgc77UiI/1t2wFAxbHFIuQ2VP2DZIQvYs5DXoihJnNE235aK+5pS85rpGTmojJLPNsGluMLJDj6tq0yrg2eWWHEjwI+XBbZPPjeHQN36T7n7XwZsngKEV1cm78bJz8l9gtgNIp87s39odUaTwj4FxuecVe/V8TeqmUfCe7SyZt2x4W8C1KO5xrC5r9wCuc5Wlh0DImozt4H462kA6sJ9NpqypgXY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c2e8c8-3253-4848-92c2-08dd14fb4bc0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 07:06:09.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSR14DuVd6O3v/akjb5uqCRbsDVfnKhYLajf3iTZ91evZFA+DCKS49oTKCqtEIuGxNDCIK4IKjqXZ833PfuW5CG3+GTuR6enE2aWUnAp8lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_04,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050053
X-Proofpoint-ORIG-GUID: HoXOdDMiz3g45J9koD8O6zb4SgLk4JSZ
X-Proofpoint-GUID: HoXOdDMiz3g45J9koD8O6zb4SgLk4JSZ

On Thu, Dec 05, 2024 at 12:18:19AM +0000, Wei Yang wrote:
> On Tue, Dec 03, 2024 at 06:05:10PM +0000, Lorenzo Stoakes wrote:
> >Right now fs/exec.c invokes expand_downwards(), an otherwise internal
> >implementation detail of the VMA logic in order to ensure that an arg page
> >can be obtained by get_user_pages_remote().
> >
> >In order to be able to move the stack expansion logic into mm/vma.c in
> >order to make it available to userland testing we need to find an
>
> Looks the second "in order" is not necessary.
>
> Not a native speaker, just my personal feeling.
>
> >alternative approach here.

Sorry missed this one.

You're right this is clunky (non-native speakers often find this better
than native speakers to whom clunky turn of phrase can be more easily
overlooked I imagine).

Second 'in order to' should be 'to' really, but I'm not sure this is
important enough to take pains to address, will fix if a respin is
otherwise needed.

> >
> >We do so by providing the mmap_read_lock_maybe_expand() function which also
> >helpfully documents what get_arg_page() is doing here and adds an
> >additional check against VM_GROWSDOWN to make explicit that the stack
> >expansion logic is only invoked when the VMA is indeed a downward-growing
> >stack.
> >
> >This allows expand_downwards() to become a static function.
> >
> >Importantly, the VMA referenced by mmap_read_maybe_expand() must NOT be
> >currently user-visible in any way, that is place within an rmap or VMA
> >tree. It must be a newly allocated VMA.
> >
> >This is the case when exec invokes this function.
> >
> >Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >---
> > fs/exec.c          | 14 +++---------
> > include/linux/mm.h |  5 ++---
> > mm/mmap.c          | 54 +++++++++++++++++++++++++++++++++++++++++++++-
> > 3 files changed, 58 insertions(+), 15 deletions(-)
> >
> >diff --git a/fs/exec.c b/fs/exec.c
> >index 98cb7ba9983c..1e1f79c514de 100644
> >--- a/fs/exec.c
> >+++ b/fs/exec.c
> >@@ -205,18 +205,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
> > 	/*
> > 	 * Avoid relying on expanding the stack down in GUP (which
> > 	 * does not work for STACK_GROWSUP anyway), and just do it
> >-	 * by hand ahead of time.
> >+	 * ahead of time.
> > 	 */
> >-	if (write && pos < vma->vm_start) {
> >-		mmap_write_lock(mm);
> >-		ret = expand_downwards(vma, pos);
> >-		if (unlikely(ret < 0)) {
> >-			mmap_write_unlock(mm);
> >-			return NULL;
> >-		}
> >-		mmap_write_downgrade(mm);
> >-	} else
> >-		mmap_read_lock(mm);
> >+	if (!mmap_read_lock_maybe_expand(mm, vma, pos, write))
> >+		return NULL;
> >
> > 	/*
> > 	 * We are doing an exec().  'current' is the process
> >diff --git a/include/linux/mm.h b/include/linux/mm.h
> >index 4eb8e62d5c67..48312a934454 100644
> >--- a/include/linux/mm.h
> >+++ b/include/linux/mm.h
> >@@ -3313,6 +3313,8 @@ extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admi
> > extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
> > extern void exit_mmap(struct mm_struct *);
> > int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
> >+bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
> >+				 unsigned long addr, bool write);
> >
> > static inline int check_data_rlimit(unsigned long rlim,
> > 				    unsigned long new,
> >@@ -3426,9 +3428,6 @@ extern unsigned long stack_guard_gap;
> > int expand_stack_locked(struct vm_area_struct *vma, unsigned long address);
> > struct vm_area_struct *expand_stack(struct mm_struct * mm, unsigned long addr);
> >
> >-/* CONFIG_STACK_GROWSUP still needs to grow downwards at some places */
> >-int expand_downwards(struct vm_area_struct *vma, unsigned long address);
> >-
> > /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> > extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
> > extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
> >diff --git a/mm/mmap.c b/mm/mmap.c
> >index f053de1d6fae..4df38d3717ff 100644
> >--- a/mm/mmap.c
> >+++ b/mm/mmap.c
> >@@ -1009,7 +1009,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
> >  * vma is the first one with address < vma->vm_start.  Have to extend vma.
> >  * mmap_lock held for writing.
> >  */
> >-int expand_downwards(struct vm_area_struct *vma, unsigned long address)
> >+static int expand_downwards(struct vm_area_struct *vma, unsigned long address)
> > {
> > 	struct mm_struct *mm = vma->vm_mm;
> > 	struct vm_area_struct *prev;
> >@@ -1940,3 +1940,55 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > 	/* Shrink the vma to just the new range */
> > 	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > }
> >+
> >+#ifdef CONFIG_MMU
> >+/*
> >+ * Obtain a read lock on mm->mmap_lock, if the specified address is below the
> >+ * start of the VMA, the intent is to perform a write, and it is a
> >+ * downward-growing stack, then attempt to expand the stack to contain it.
> >+ *
> >+ * This function is intended only for obtaining an argument page from an ELF
> >+ * image, and is almost certainly NOT what you want to use for any other
> >+ * purpose.
> >+ *
> >+ * IMPORTANT - VMA fields are accessed without an mmap lock being held, so the
> >+ * VMA referenced must not be linked in any user-visible tree, i.e. it must be a
> >+ * new VMA being mapped.
> >+ *
> >+ * The function assumes that addr is either contained within the VMA or below
> >+ * it, and makes no attempt to validate this value beyond that.
> >+ *
> >+ * Returns true if the read lock was obtained and a stack was perhaps expanded,
> >+ * false if the stack expansion failed.
> >+ *
> >+ * On stack expansion the function temporarily acquires an mmap write lock
> >+ * before downgrading it.
> >+ */
> >+bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
> >+				 struct vm_area_struct *new_vma,
> >+				 unsigned long addr, bool write)
> >+{
> >+	if (!write || addr >= new_vma->vm_start) {
> >+		mmap_read_lock(mm);
> >+		return true;
> >+	}
> >+
> >+	if (!(new_vma->vm_flags & VM_GROWSDOWN))
> >+		return false;
> >+
>
> In expand_downwards() we have this checked.
>
> Maybe we just leave this done in one place is enough?
>
> >+	mmap_write_lock(mm);
> >+	if (expand_downwards(new_vma, addr)) {
> >+		mmap_write_unlock(mm);
> >+		return false;
> >+	}
> >+
> >+	mmap_write_downgrade(mm);
> >+	return true;
> >+}
> >+#else
> >+bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
> >+				 unsigned long addr, bool write)
> >+{
> >+	return false;
> >+}
> >+#endif
> >--
> >2.47.1
> >
>
> --
> Wei Yang
> Help you, Help me

