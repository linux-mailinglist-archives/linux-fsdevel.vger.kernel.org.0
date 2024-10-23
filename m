Return-Path: <linux-fsdevel+bounces-32675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6C9AD2CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 19:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70A7284F5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4C51D14E8;
	Wed, 23 Oct 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GYhoFJfH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DXuIEo5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027281CF7A8;
	Wed, 23 Oct 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704277; cv=fail; b=bR3kdPEXA2S2BxYeXvwdZ1x1PMwnwwYVNVvfJD8dY/FTG5Y/8Be49P+ey5f8KHqwTDy3qA90XATCHwEZQw+6TLJ2LMEI/1dIcpmJStiIv7pP+wTNKgRgKfAfr33LreO6+1pwiAYhZA/ZQHPTCYZpmml58caH/JBcKHqxngelC0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704277; c=relaxed/simple;
	bh=4ZAmIYoRfsW3x9c0jeriNt8ut+SB9XK7MTaUoItxG5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a8PK7lvHcN6aWcgMwU4Q0Dc2Qp9hjarnQ0Lx5jZyx3VJXlmtJiDUcX8GTCSGcFdVQa3HuNeDjgxIBfSrivOdatyoSIMw7AJlnoaTxeMtVPVHVBBDVYe+dFr9+KkRRZFPeGBnVFNP8Mp7WV/Ku7Vf2vUb7oh7bI+H+LLmnT1OaMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GYhoFJfH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DXuIEo5z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfcm0013895;
	Wed, 23 Oct 2024 17:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Eu7GjHl/MZ/qw4Nsyb
	06YSO8BgpSEJjqoi6WTEYbEas=; b=GYhoFJfHuu3jzDr07d6wZu8avlD9KhtVzk
	TBcm+EP4IupyZoeIXLt8U2JXAnYghiYOFDsDXEf+j8BHnsuqK3HJKrF65atYtEy5
	ewAOArG9lYOtAyxb9OzzmxCy+oBniNJ1Qb+JU1XDcE0u6wkgL9MKmwh6+nVUPFTM
	w9szVg8xUuFMgysGMxrUh+nzoWxPBCyKa0JCj1XdmawF+dbtLREyEZxlzgU7QD/Y
	9gkn6fCwqBAF8aE6G8aB5gZPKYgelREcPOr2FJ3/p9q4zfexnjbKSEFB75nq77/p
	yyPxMaubQoykmn3J5aKmrY5zENdy6sS6+To2hrFm0rFfbJ9MBDUQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v0p44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:24:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NHKx5C039476;
	Wed, 23 Oct 2024 17:24:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhbb8mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:24:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aw8WTG+RxaiASt6BiDeo7QsDRd9AcAkv5spkYGOwXrjAmxdC0DmDW0N4Ro63JgulA99nflVQNuuZO9DxUHtQJQfmFl7x1EP2UQk50vKZhA6HtZUVgnL6EZ7Nwqr12qKhU5TMnmzyViQUOMyqPFDSr+41VNpQG+DEBrbDmqQ5ZOFrS5FKjEQKrud9mfADGRYomQwpm6auB6UXJ1zw5jGd9z8ZUZmRsGFHLUMjiZyUIV4vD6WnYEugaKeipJ9W+rRpGYMCaS0g3P8hORH/9IQFU/XDz7xhqo8/yfLaMG0mLifga93M3DkW2IpqiTJGpl9+Jbh1krHzNqqhv0QQbC4uTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu7GjHl/MZ/qw4Nsyb06YSO8BgpSEJjqoi6WTEYbEas=;
 b=FGtygrbjki0/abWbv2X8VzEhNlrFtMjkSksJwl6g3QUAw+Qn+qcv8dOVwWyj9Nam2y1wrsLxo4k28XNgcmc3AxiQXS3COXsSrP6Cv5bdFWxViTlmvQ7EtB7WM2g/9pNjTUTrEIRciTtYvSY43WjTXSkIJjXzPJG5jFSX5BGX3I4pH+BSApIvAoMllaJ1Z2nrutR5+WnaolFpPh1p3gvmkia+6A/FSe1m1ZlsN8e8IBnVW/wperOkLzbUxtZ+MTArwPJJHlxfySk8hYwU6oL+ZG0x6g70XvymBnKgiBXY81ZxI/evAvtVakBA0Qm4MLFD8KTZKZbaWMh/9PaEd+SGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu7GjHl/MZ/qw4Nsyb06YSO8BgpSEJjqoi6WTEYbEas=;
 b=DXuIEo5zo9xRKTvThXGsdbhpEh2yhPxrtkGIb1+65FPIkGg20oK2v9vS+jUdL+cwWWo3AH73Gh6TPry4QYz+NZm5KpR6mHPVM44PtLlTI9yPfPcUNEzuWQcpbuXBy1SBoXWS9t855p3KQv4C3v3J8DIhc5wGcqHGigjV0lJZ4Vs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6569.namprd10.prod.outlook.com (2603:10b6:806:2a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 17:24:12 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 17:24:08 +0000
Date: Wed, 23 Oct 2024 18:24:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 2/4] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <4ce07818-1adf-42eb-9c0a-85f231a5648b@lucifer.local>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <3bf7f2d8efc768007b5de8122275405afc9942d4.1729198898.git.lorenzo.stoakes@oracle.com>
 <fhy36lhgeedrdwoubuuxarownhji2k4avcherjnedtid35yael@jokjnyb6i66b>
 <f6114921-d3c7-4092-b503-09f99d98ad83@lucifer.local>
 <35ipnq7dik6skpgrsywtje734iam65h2zjsv7fv5ayzfwnjlph@odu2szclos5y>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ipnq7dik6skpgrsywtje734iam65h2zjsv7fv5ayzfwnjlph@odu2szclos5y>
X-ClientProxiedBy: LO4P123CA0636.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 642ba6e0-655c-411c-062f-08dcf38780c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KJknYYYlWPKcspBdexfvkBXKgDEKx3XUjDhrPZQfFKbPIf7ocDV6EsBUy4SC?=
 =?us-ascii?Q?+yqUsAkYrQsyhDHNSpQzlY3Wnerv4+ElewPBgS3DLQS/wvb71Dp+gCMbFvT1?=
 =?us-ascii?Q?a8lM6Sq6ThTG3Sot7T+DAfmYtKCfEmDc3LxZQdN9Fynvg32s/4YO54tY5n59?=
 =?us-ascii?Q?VuQHDZNCtyP2mPC9YgWBVHdZl77QeWTBat6X6Ixz4h5ntFXIACfp9JYThL+I?=
 =?us-ascii?Q?8AuHui8aJ8INe13ulgvjBrxtXuKzn62ibUTrHWLsl5oCRERd7keE8ot9XrCs?=
 =?us-ascii?Q?0ll8PdtIHpZSHBNOTJ/Yj7lu2G00xPbHjlFhRYXYkHylZbuetHT5+DSA39QA?=
 =?us-ascii?Q?NYgPmCMJULiJ+mHfcCowzifOd+I8Ynog5geIqUb/bXEaFfqW5w+3Gw4JxceU?=
 =?us-ascii?Q?BsnYDaonDWRtmVkT4yEKVuUJW51UGWcT7JZduVxHyIhlPilbjCfLtLZas4UC?=
 =?us-ascii?Q?Hi24YowzM8n+brxOZmBZaiyjR8LPrj6TtPZK/ZenbR0OGnhFMOokLOnN6sCm?=
 =?us-ascii?Q?gySXXE105qAP1+LkJs3Vn6dGjdd0AA1vIdMQI14Pe9cD2JTASuotEsLNiMyq?=
 =?us-ascii?Q?uaLISWaXrXLKUPmWfe9uwrKR5g26EBEQZaDQBJXXwKlQuwx9HEvXKO9wbGBM?=
 =?us-ascii?Q?GWLXINy/AGjTJqWFqYy7elgzFirwzqvzrkFppB8kHFAWnOdT5U+xaAgIe2Us?=
 =?us-ascii?Q?935d1gefn/Fej76Y83KH4FZ1XIVIlHE60evRUcvba6nh02K+WT6AALDdGOwu?=
 =?us-ascii?Q?6Vjcen9GM0eLbsGYexKLn6KOsVmCRoqKsOZYlsCz0AZ6X/RvWpsDHdp7xJkz?=
 =?us-ascii?Q?B2k0sOTF+aC032GOWSeMVTqOra6I5g94EsVVWQGKnURVs0kM8uv3Ix+EKpsl?=
 =?us-ascii?Q?aDdmluxKfDWpbzmfCaVmtoOZZluEXtIBaLS63ytmjQumOJhTeMe6rf0hsQD8?=
 =?us-ascii?Q?bPBNCy2W+mRnmVx4B76OiDItMG0Ezq/cf93rC/qZUZF9KvMV1SwilYo3WbWn?=
 =?us-ascii?Q?4yHmxEoLj+bG9z5Q/xPZ9278tC3ywcffn6tcO3NyBqIcy5H1gme49VJU1Vi0?=
 =?us-ascii?Q?1Mxhjpw61Wk00JDgPumBaulDG88nCmQ/j9M0aHnHNnR7cXaggH99ZGPIGBVd?=
 =?us-ascii?Q?6mUc1W6bNO6choiVrPFAMh73Rg6abFmIp9fuDiV51jIx2qgnQ9RfJkY4hxKf?=
 =?us-ascii?Q?KiLOyBiyrdClh4pRUlfXvnbeKyaXGpDyhGafczSWWm/vWjRnuxXZywI6V665?=
 =?us-ascii?Q?iTSN+2jQ6wo05x3viIAQv3zfucgludEAoBgMIh6OePW7zHBK7Bsq8f1GcJVN?=
 =?us-ascii?Q?2Q7rb54rPk8K8K97tI3rhp5R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U65ByZMFtRfim6BvDUSTTz2JyZ2fn9e9fSee+zVFt7BExIguwd86OiWgv650?=
 =?us-ascii?Q?Nv9MDxbqa6CIFWvdmVOHwc5vyj8E0vq3dWnTA8AfnRYk2agt8ZeJrAscJYQW?=
 =?us-ascii?Q?asrHX22gZmY8AjJjpO6+JdVGYbiNvappLvi+21n4lwFHa+JRZ3ggGLyHYTbz?=
 =?us-ascii?Q?ssbTYO8eGCkXwQ7oHyHe0UdFaumg+wNtnK8pT3pkc+6pzmUiuGcoaX+nnRWa?=
 =?us-ascii?Q?aORhmUp2We/YUefxiEqCEFUgL3fb8cc95/FKbxm+DKXJmrWG2N0BHv3U+ikH?=
 =?us-ascii?Q?9/X04yA5yeBeoBlj869WrVy1PDuX7Z0hgbU9berGIFKOeS6J37z0yWgahZhr?=
 =?us-ascii?Q?q0QprJ0JKAacQP5OyAN+SzwRgmkkjdxik2j2FoqPou2H/xQqHxLgu37lGmhD?=
 =?us-ascii?Q?56IbAXO3iLZOydnHn3JKR0k2Hix/ukmNJIGmiTlTlgJXTAM0eUNUN/3muYTZ?=
 =?us-ascii?Q?eG5mtjhNvV0Ws0tRY4cUF2HPmKGd6iURvG3WCPwynoj9RFFGUPNCd7QBxpBl?=
 =?us-ascii?Q?5r+TcWEryRLidU2EmG+yzP+IncgUOI0C4/O58cUCopNhi9PcFJYP9AyRkGBk?=
 =?us-ascii?Q?wBMgZLBJzFT/cVWg3Zcvaujb6W+5e8Ybh9Fp/7RliaooNiDssCWsgj5tzCDq?=
 =?us-ascii?Q?MzB+wdAUtLWQpDsiibUjYSM4VCkQ30Jx8ZraHjWlUEnlz9g9q4sePhWg3xoj?=
 =?us-ascii?Q?b1cZd6SQRnsZROxJtdrOcCVJzZMJjphdI5XomGIKfPt44VfDDmm19UiaxTCG?=
 =?us-ascii?Q?8fD4BWeCUo9w0+peXxn5Uj+jfr123/0jy/jaXJ5EMAdWAExy1ZPK0kdMub2q?=
 =?us-ascii?Q?2qk3lP/2q5XmHYEJRZdxW5wcsNMQGltEop4HIJt2DfVtuS2png76/gzf8HbA?=
 =?us-ascii?Q?uDPS6KJtKlByKORMZmr3LG+NDVVrMZFIrH1OBPsJdQ3gru0dPnrJGJZfatdI?=
 =?us-ascii?Q?XlPIpphNqlPZvT+0wFOa4OKdKlAbYGZzkPxtmHB3JVwMNqausfzlc7A1h72f?=
 =?us-ascii?Q?VjAACq7ccRwxa27Cjija+KgQTlwoOc9+xgtNbX8oE5Am42ZFygWvoQcBG/Xb?=
 =?us-ascii?Q?WTGEeokZYH6P2UhzVnybfZIRKY0AdKKurDCYszeEvIohQePPSrBLHLQej2wZ?=
 =?us-ascii?Q?IITDnsxGHnc19SLBvzp75b3rb10v+dLrBT/3WbJgFXImc+D2QUm6eIBXGOGQ?=
 =?us-ascii?Q?JRlPGvE79KLeT8Lhe4LGm/DoKd+eZuT3MGmDEfpC1ukIh2BZRfKKRQ/cvLdi?=
 =?us-ascii?Q?NIO2EeQMVdwF9a37cZQ/c7QZHV2/mlzNcauF9d/8cokh83tngf+ROrglTSc4?=
 =?us-ascii?Q?canKEWXsiEa39oW7CoHjUoeb3gFoQlW2gsuGnDoGQnwNywmDTUvmUxldfywW?=
 =?us-ascii?Q?IScZXuSZ5CwZpOEtTQE6H/4YEza7Q2FULrbAyNew1hvYiGSsATMiqwGuzi+o?=
 =?us-ascii?Q?KaGQDouzoxd1n5IkOPlA7X3vpHfrZXwPJYs65ffZR0Y3qUfbLH+YZN1oGNFp?=
 =?us-ascii?Q?gyt1f2SdFrBTNHLfMkxYR0Ia9ix0gCrX1fTbT9hplasgvSm+KfRBnS4BGvc+?=
 =?us-ascii?Q?p+RdLYfxaSmVHfgQP8ZCfulusVcUDIQ0gZLiPp4axlloNAdWd+axD1XJnM0F?=
 =?us-ascii?Q?FqMlK5E+4k/cGqtbsfQX+mabLvCOIduu1xFcs0cMKtBQqRsnFN0MSMTkmpnD?=
 =?us-ascii?Q?Uofw6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e5ZCy40jCOXsbk9WOsuKo6UlsRe/JhBq1E2//NkjVmtAq0oUfmwZc2d1ywCRTXSv58mPDxnOaDOIx7urYZba1m5pSyMWcI5suNAfzxKrJ0Hz/O7c+zMzfN+ip5M9HYYjKDaynSGwkLNunOy93kQQEtgjUJAfmhIOMpWPrJJGg57SqNtl2p5Bcjh2SI6J4CninL62wnHexrJAkYQjKLRQy8rvcXA7jfXTbC4zA/0MziX90IWqA8EDHA5HQPEhnBlTxpynU7QNicrBAU7O22TtYwmR+am6452AZoaCzf0gyIs7XB/6ZODLdGMKkK8VdabU54I6AP6wpPiR0VIkj5a8lQ//QUQzH4F8kbpJpk2JhQcmAo9UlfEq+w0aTtu0o3j1yKgPSoN9YfTkzcpZkbUoPCiQFmdzOzKSPej4b8shyqVOAw1vYDTWQFMQ5xx0GkAToss4+kRMbNKfgkahLVrzNn9/kV3wlA0pEKRAUP0crL+6MeDC6Nhi1JHeVcvQqz03AZLce6C22baPTdFQp47LyZMVkLCyt2qskXljufuvStl8XyI+wlSh3hpIcUK/Y375FC91C2Nja15pHKls8osr0neLMcgVGqMUjhTJOzqe0Os=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642ba6e0-655c-411c-062f-08dcf38780c6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:24:08.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8r5KPQOBquoDST5kG6JLR9FfSnYLb66PusmDCTchvYhbYGr9g33nYtP3B/iHYjSMcVgry4/8ILinzQqIi+0MBYiMULUcfpUR/PCpVdCwbOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230110
X-Proofpoint-GUID: Lh6yVKuiZeNPjUoYalmKbw7wk_HruAY8
X-Proofpoint-ORIG-GUID: Lh6yVKuiZeNPjUoYalmKbw7wk_HruAY8

On Wed, Oct 23, 2024 at 10:18:28AM -0700, Shakeel Butt wrote:
> On Wed, Oct 23, 2024 at 08:18:35AM GMT, Lorenzo Stoakes wrote:
> > On Tue, Oct 22, 2024 at 05:53:00PM -0700, Shakeel Butt wrote:
> > > On Thu, Oct 17, 2024 at 10:05:50PM GMT, Lorenzo Stoakes wrote:
> > > > It is useful to be able to utilise the pidfd mechanism to reference the
> > > > current thread or process (from a userland point of view - thread group
> > > > leader from the kernel's point of view).
> > > >
> > > > Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
> > > > PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.
> > > >
> > > > For convenience and to avoid confusion from userland's perspective we alias
> > > > these:
> > > >
> > > > * PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
> > > >   the user will want to use, as they would find it surprising if for
> > > >   instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
> > > >   and that failed.
> > > >
> > > > * PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
> > > >   have no concept of thread groups or what a thread group leader is, and
> > > >   from userland's perspective and nomenclature this is what userland
> > > >   considers to be a process.
> > >
> > > Should users use PIDFD_SELF_PROCESS in process_madvise() for self
> > > madvise() (once the support is added)?
> >
> > You can use either it will make no difference as both will get you to
> > current->mm which has to be shared. So I'd go with PIDFD_SELF for brevity
> > :)
> >
> > This series and the prerequisites I already added to process_madvise()
> > already provide support so with this in you can just use this for that.
>
> Thanks a lot, this is awesome. Is the plan for this series to go through
> mm-tree or through Christian?
>

Thanks!

I am assuming this will go through Christian's tree as entirely within the
pidfd realm :)

Christian - I am assuming this is your expectation too right?

I cc'd linux-mm more for convenience as obviously am hoping to use this for
an mm thing myself.

