Return-Path: <linux-fsdevel+bounces-69093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C159CC6F025
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF74E500E7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1318735C191;
	Wed, 19 Nov 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J3xC+ZHs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rs+XP0Lu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31C352FB5;
	Wed, 19 Nov 2025 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559555; cv=fail; b=ViPyZfzreijhBk9O2i7UOl3MyhQdmoiBM+YpiH5vRK/rKIftMGWUnrRYMayre5+nV54njpX5dga0pm+fC9eSmqvFfvWsx4v6RpE4z6x6n+Lh8MxmicZLkGzPcIdRQVxA85b+t9FtYtz+EjRFxg71FiNc6X/Sk1R4LXfAeMdoQvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559555; c=relaxed/simple;
	bh=jnE4yFLGTedVbIOBb01BA+rho0//6P/lxzj8T4yQ/iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jr22rRRdtPGjTNx71Mw2gLSdxvFI+pcaSBeMYYtp9fi0X5Fc54NMARPX51Bn0DLj4cVEll7o5kc5zCVxFRZUEFw+oxknYxHFKu4xrHd/CJ5AJlb0o03Z5lZpARqouiwUC6AF0nVGbNXxHiemLSZMgY2r6uHpH6vaQU5LqFM592I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J3xC+ZHs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rs+XP0Lu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJDZvM7025708;
	Wed, 19 Nov 2025 13:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K1qPLBbFY/XHo56+q6MoC8h+1kkI6v3rdtfrvOfklJA=; b=
	J3xC+ZHsMSOfWjNxWmQIUqdwjzvAvGqWfsmYc0cMr0XNHw75KhI9qZdEYJhYAViO
	PRm6tpYZoqh9ubcFNQZEAbxx3ngvR7KIRjKJmQQxuq4dNw7up5tHyzejvAzxbwk9
	eCwyds07kE6ONb5OPvhX9Ga1aQjw4tkXIHf2jgEzWEsaU2JprqPV3ybxa+Xdho9Z
	JRV0JJhIi2Cu7bDpiolR44ErNpsUM7Z6HF++FJtnozY9GcAjvPyLcFKyunObN2/J
	/xqgkOSKyW8/WOqoTp1FKKgC/86tVPa5WJfmG2HADMWGD3Kb51B+5cJJY/o0hmjq
	nk/rzbtk93AWNK3wsnm3fQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j71ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 13:37:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJBYiVq009433;
	Wed, 19 Nov 2025 13:37:35 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyemw6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 13:37:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1MMxVl5Jo/AJg8S/q7mvK5Kz2NPIWd/A5VSKLsTklF7VRW6//uJH67FJ3ICCgN6NvNl9CcZwBXljOaxm5hzg+2FjA8wPsF+MrVGFhFkoeFhX/YxPbS/C/puoUk4OtoIdLONYf7ZIKxlXj08ilZE+Q+prD1GcFsKyN2xuBLBv5i01UYP970t6+TCOvbf0TvoNDhWstfaEapMTp5zZh1XmfFi61ayAI7v6scIPfR5TiO1k22ZEHlQse6eph7JadnPt8qJcz7vCRTiLG+GGEXAqlWyBIJAbD0D8g7vuDQ3NQiSyHh8mnEYAB3XmA90gvQwu/4PWQ1qJQwt4Nmmijqfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1qPLBbFY/XHo56+q6MoC8h+1kkI6v3rdtfrvOfklJA=;
 b=SXVQOpfEVYsKsN912SO0Kx6/tqgM8F0oRgirj4Y9kUzwqjidby6igu6+m1IGAb+rNodionrOChtSeqCWzi/CE9rePUJU74MwhQbvrXnIqpqsxYkBnFSpHVWy+5g+Msa5ygWz2IqyHCVGFgx4qBIdaEHNONLbwWsGrDuPNupQgMYF8CE2CmFff0KGUE39gAvBDgog7AzyXWUDzjQo4ACSDuDeC43s0N2RheT+DJniwkO+w2sHNoTcGs2rb3+qpRXHL/ZBFUr9ukfCGBmhEVeAtIWZE7ULVaEKMoKkegB20a4ZfpCkmB8em89rv83SxY7dXQGbg5/BYSarDtzVkfgENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1qPLBbFY/XHo56+q6MoC8h+1kkI6v3rdtfrvOfklJA=;
 b=Rs+XP0Lu4eeLWBYP5F522aqHqZL0bObOX5+FHPUCOvJV9gyCbW7FmLNQKE7xn57biIltx/QtXaI3HqUSpsIoXxFOcdLhj3Wx4xiSsPJijd4oZqJOoaxXyyIwu0OqKQOXJh7LU4S1ZQTVQ5zLkgYeAcY64L7XNPRMBXBvIiqBoQ0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB7428.namprd10.prod.outlook.com (2603:10b6:8:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 13:37:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:37:30 +0000
Date: Wed, 19 Nov 2025 13:37:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Aishwarya.TCV@arm.com
Subject: Re: [PATCH v3 3/8] mm: implement sticky VMA flags
Message-ID: <026dac5d-a478-4e3d-a492-5d9bfcef818c@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
 <2ab7be71-716a-40c0-adb7-01e7474546d0@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2ab7be71-716a-40c0-adb7-01e7474546d0@sirena.org.uk>
X-ClientProxiedBy: LO4P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9702bdf6-0db9-4925-4017-08de2770c968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?54o4FP+a8Qa6xeXNMJmBahLzySSciTAkNaJgQiPK+1SCgXaacS9jQ3IN9K1x?=
 =?us-ascii?Q?UIvWbUoNRHHcLfue+Rt2FZUJWJkuPa9IfDK7Uejf0CSRmOgXNxp/ujYs2pUh?=
 =?us-ascii?Q?neOEF6Nt5Y91KyjiiztoTKQa+BM0VayHCTPcvzLkbCw94g5EG16PzIA/Aunv?=
 =?us-ascii?Q?2Rg0rA4Frjo2KbzVJ5yifQWsWC85XFPpppBdribc4A610BfJG9jD76/P4mMg?=
 =?us-ascii?Q?WAbkiIonm2nmK05Ms1fnNyJWd9sGcp4kGC/7vy9Ugrd1AMaW9Wn2ifQgy7F+?=
 =?us-ascii?Q?fX/6MXY6qyXRC+RetON3NJStQgvN+lc+p8xNghdNIVyhBsBGJ3Sk36uKoXK0?=
 =?us-ascii?Q?nF+0uY8w7Au6CotlRjuQwGgiJyP4ihTf9AmMX1nb2MNHGgPTa1T6oCyvgh1B?=
 =?us-ascii?Q?VitmaoWVXIkoHN/f5z8z/sAviriq5w9W7vcSzQpZRqU07tfmIW5razMbq0x5?=
 =?us-ascii?Q?dkLnNSvkyB0h3ycpwAwKsgncdqBhGD4gVU/LAGV47JYVrZNR4mMi3z2McSKu?=
 =?us-ascii?Q?rGL1N/Fcd6w8o1nzevTyXe/yZsfGqy6gZEJ8oJqjNpU9EHeoGgO1OiLBrVal?=
 =?us-ascii?Q?nh5g3sd60i0/LQA9kwu/M9uW9MJNBq5lTQWJwwiziRIlDOFjMxO9ccYB4g9k?=
 =?us-ascii?Q?0TtKbIGGuFSak28mYIv/UJ+lwpHyVQqSYE9TJ2stXuEd8NBnWmcUlKmtAn1L?=
 =?us-ascii?Q?fzE00OzrTl8diEzX7W122VGq8ykxwQrp4uZ9EPrsjQj6J4gs5TVebRJYqoQP?=
 =?us-ascii?Q?GnoRDp90yraB4/UGUw0scSa6Fg6KO10/60xu4W0f67Jlsh8rew3k9J7WSq3K?=
 =?us-ascii?Q?kXzt68ixPBNp89jd2sZfmB6bd+T8sEG+rb6ZtzeZm8t7yZyoQQWzUpQIv8/F?=
 =?us-ascii?Q?x17nZcNgUAqTKmm73gZgbRn9SnIy518KThyqmqf+Waem0cw+jGh+y5LuqCuD?=
 =?us-ascii?Q?mw3O+l20PRpGy1z2lm9xuNb8xhn72S7WUuEuUb858/waDKxK3Lb/uAN9iaLd?=
 =?us-ascii?Q?xCdQHyPmrXDwKl81nQAPXtdINomQnFUw9vPT3QaiaheHFCdI+9R5L2IczQNL?=
 =?us-ascii?Q?xD9US0wwIHef+Vu0cSkd4y7UFIJYMdND3ibl/qfRLb/ZGQFbBmB4NlOkSg7d?=
 =?us-ascii?Q?2jN8UoeUW4rV+dGfMwnm0HSsOrhTkTgy1KzoHqNVQMXBpDyMNdKTCDLnIVQT?=
 =?us-ascii?Q?IVPqSVsrfEe8Y+ArAcSDsvD7uOtUp3hApv6vwWKcpgdUPqpDHSaUAZb6WfFu?=
 =?us-ascii?Q?W2vfovtTLVKTjeefyCyG1CMRtejyTxODDT52lJjoYavVIN6WPhywxZxdj8hD?=
 =?us-ascii?Q?nHaFlXkmWFNtTEJfpNHZXqdNjnWEIv1ru+bknq2K3Xi3dspKBPcH6VfqJwuv?=
 =?us-ascii?Q?em2qRmWYeCuA+Rg7Ix+w4fDpHVWZ7dfDRHrleBuoh80Qae0H8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fnLBhxLfZH4DKo7bJzkvx1AW2DDnJCjQUizDypXlEzw4IzoNIXCsk8E9ROw8?=
 =?us-ascii?Q?RX8PQZ86XN9WG1XdGOLKAUO4nNr2yGZVVjWRvZr/crBIDOMRTJSD6U/EuART?=
 =?us-ascii?Q?yqD4WE1/HyCUNKe1UbBXIkMewXF9K2SFhlzSrZhUFRyB3AVRIkQXPf50YAM/?=
 =?us-ascii?Q?/LiJPzlq0nH0AdqaduER9PrxUK1QZnvDjbXDHY1KpxpsNbo7cw1DNBjJI+eB?=
 =?us-ascii?Q?D9ES1D58QXUTjLm+3PnUWl98sCvbqMFw5B39RLEm+nPl68AEiad5RVvFKHjX?=
 =?us-ascii?Q?gpI6LSuDjcBv3jv73yibpow7fRBjwy9ITCXGtHyutHOw+Gl0GTRIPnW1dNoF?=
 =?us-ascii?Q?I+dSHHJCAckNUY6f5kMDFWdOJQLkLzZAZB0pTVauLj3+uc2rWAWCiByzrPxv?=
 =?us-ascii?Q?05GNAMoBE6kKPYroTwHx72JrZpDSj1N091dCGOW43Kf1+5pQHUrvB5Swj+Q+?=
 =?us-ascii?Q?yzUqBjk6m85prna3dHVkf21AOSMw0UCmyJ3WAcqyIoWpvMi2aiTc2hZWI45q?=
 =?us-ascii?Q?7pzgYTupWfKELrMc7mY2BG+4l0I74DnOb0osMjcMVjc0ds4Nf9Ioh8qRTi0r?=
 =?us-ascii?Q?H+G1i2VNepZrP7kVkTVDbFBr6qBpBNC3fu2Clk6pS4Y3tM9MUSBYY84/eJeT?=
 =?us-ascii?Q?kLi0xXGSknctZQFLWch5IlRgTUCEu2hVOguq1ui6RBXfTLvRg93Q3Q6e6ZXB?=
 =?us-ascii?Q?pIkjTND8HpLj5rkjRGra1PnleMKAE0gcPEFZbtTwjQihnPQ1voLDrSQ/nmd5?=
 =?us-ascii?Q?pm9Z9Ig3O4Xe1moTKd22xRwnhLdnISowyBNfAGKBh0Y0dFQ9S8+hDmsA7RNH?=
 =?us-ascii?Q?XxYUI6UGhL/GfYGMD2EiVN/4aXOcX/Ovohppzxr8nkUhKjuYr0Tv44NrWn5a?=
 =?us-ascii?Q?5/xaHIhYlfHS0cnXTzor879PNZCt5xb9DCS/Wl4FEDdwrZAMl2zVsq/6ARxz?=
 =?us-ascii?Q?4X8KRyNMdAfqS+AJw/EHm/48MD7pCM0Mw8aIhkTP/mdw3XV7A1AJ/K/Ummdc?=
 =?us-ascii?Q?mEIpfuuLzlQvmtjysl3QZeqlH9Zx+Xz2P3RYoetSfTdhi2ybn7+jgQRv5tUP?=
 =?us-ascii?Q?WNfWwcGQP+4TBlLlD9G9jxrBhpcekgkNtvHZEAMMUy8nhpS6Vd945csjTyj9?=
 =?us-ascii?Q?oLuu5oILjnXg+shWkjisQiY6mb3aJLC0D0hvt4L/c5WrAamSu6GI7pNp9T1s?=
 =?us-ascii?Q?b4yDSOuXeP7Pw7i2KrLXl6aD6vA2eWNIiM4LCcVGSi7xsADkm0OI9vSWDVtO?=
 =?us-ascii?Q?x6CfEY63D4u2UYdznCWhq6p61xZG8B2ZKnPK2ZxjuxNVwwZLrMtwBpkvADsq?=
 =?us-ascii?Q?QRaarzaJ6iSHSmEckekSWAw9bKo0AR1qGaY/ioU9XCyJrtUQ9+xv+qDCs3Em?=
 =?us-ascii?Q?LjEb+OXV2VaMbOqq1S+gOgQ4yfxp2VtlVUXzem/dy5uy4F1wWQ1C/Ip1iQrd?=
 =?us-ascii?Q?MDSoaLSz+OKahGsIRF/blgpKijOKj/t9O5PVhcuIIEnMKWhx2MA4YmyeMAt6?=
 =?us-ascii?Q?2kNeRTkyVgVYuYTn8XgJkh1PFaMvQDnT54IpR8pnbIY1reqnu7QA6IUOSEDZ?=
 =?us-ascii?Q?cfdPHLoMZkAkubYY6aQ9oz5V6bnkfTqEmtKWy+tGxB1sYvZFPLfKQdrUbapg?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QKJUMhbqPi0FBm9bb2LjUqJ7EO8Osud7H1WEFkwqX7x8OPOTuzeZyBxh0z9DgqkcSkY9SWJuaodrUhTn/6+YJvGj+ZVK4kYlDhZJAClP2Litjm2K5uJSAB928X1POYfaYxa+S81zfIreZi9fUJvckPgJTYlbzKdqe0xAozbNCu3C6sLix14T9JiNbBQQ9c1BezmtDXXgwvfoZ7bCNcuHg+a56v9+BNnqLyuwvNDxDRTGJgU9dBJYyU/piwh7B8UfPh00mec5EdHwc26fsaXVrtEQ55O0sy62v68+RJHL8UHdbwaBjF0dIQWKxt1Czs5qmxF31DfiloH11RbRJLRdVDo8A2ZUC3Lu0MSBubCppEepBCJCUrYf7a+pDpWkt1hdYRw4WSr+ynW95juKWc2xhyQeaas57XaUSgiacXVGwppxW8+E61Fe/E/D+lTG2xvzbr1PeAoZ+s7BUyzcGXy6/BvhijXzjVVVP3s7BoxMzG+dV0snrFTBzyeNMmt/ZIP3C/ei19Q8TdFlWyjaygIhOL1wmbUWk2XdLWSuCpZoV/BFVpuu9mcJTwZ3+XSdk+h2V+0+UsnzPPorRKiL0MNlkM1AqW3nlYvvRtTRiFeeGCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9702bdf6-0db9-4925-4017-08de2770c968
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:37:30.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMIOEumA0oD6XOWjRol+JiAGxNIlBn9FXPSQ3mPRj3vB2iMtbYPRGdZv+8ueqh07+NRI9uiSDl139SLhVktu497mO9IlNDiCknHE9Z8YpR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190108
X-Proofpoint-ORIG-GUID: COqWzhO3Hcupe72pj9yylDqkXT3vzjju
X-Proofpoint-GUID: COqWzhO3Hcupe72pj9yylDqkXT3vzjju
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691dc820 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=qNABUOcEAAAA:8 a=e5mUnYsNAAAA:8
 a=qc9fstMJ-4irVD1d6vQA:9 a=CjuIK1q_8ugA:10 a=Ytm653ucTKQjCvbzLygB:22
 a=Vxmtnl_E_bksehYqCbjh:22 cc=ntf awl=host:13643
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX8q+BgF1/Zvvb
 hdKDiml+ucAgjcgnKZeuAKKQ60XerqfC+dGE0TRooQTdLzxcahcYa7GZe4wO13jJNj11fbeks1x
 f9ImbNAgWGE+bhn75MdRdvgbuMnBbIYHbsU80qk9jlz7Ir4cFh1st4FxPEnw1i26MN1SNd9qaQY
 VysnNyqxBbk1PF73A2j7pY2FH55e4w4+29vvp2RUkQvG15kg1QOVINKQSon0ikoyImBLMmslIjl
 Vhfc01aLdFw1GD9l5Q07Hqxbs0WM+N06IG7vGZ09g35Q73Hn0UDcu9O98jyzui3IKMt0iVducRR
 JyrFZUr+pOQtsKXFPRM812WoKsWKr/fyv3TGwTwWUKHGn8modaUIGYr2hAptHEaCbvl0UQ+sjQw
 Y01OqmKBVfX5DPZhQJYcTFgKnwBJk//aHIwZTvyxiB1cJc2Juq0=

On Wed, Nov 19, 2025 at 12:55:29PM +0000, Mark Brown wrote:
> On Fri, Nov 07, 2025 at 04:11:48PM +0000, Lorenzo Stoakes wrote:
> > It is useful to be able to designate that certain flags are 'sticky', t=
hat
> > is, if two VMAs are merged one with a flag of this nature and one witho=
ut,
> > the merged VMA sets this flag.
>
> I'm seeing a regression in the futex selftests on arm64:
>
> # TAP version 13
> # 1..1
> # # Starting 1 tests from 1 test cases.
> # #  RUN           global.futex_numa_mpol ...
> # # Regular test
> # # Mis-aligned futex
> # # Memory out of range
> # Bail out! futex2_wake(64, 0x86) should fail, but didn't
> # # Planned tests !=3D run tests (1 !=3D 0)
> # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> # # futex_numa_mpol: Test failed
> # #          FAIL  global.futex_numa_mpol
> # not ok 1 global.futex_numa_mpol
> # # FAILED: 0 / 1 tests passed.
>
> which bisect to one of the fixup commits on top of this.  I've not done
> any real analysis on this but it's a test that's generally very stable
> so I'd be surprised if it's not a real failure.

Yeah the fixups are known-buggy, apologies (non-fixups are buggy also but i=
n a
way that'll be less visible from tests :). I sent a v4 which resolves
everything, see [0].

[0]: https://lore.kernel.org/all/cover.1763460113.git.lorenzo.stoakes@oracl=
e.com/

This should land in linux-next relatively soon if not already there.

Cheers, Lorenzo

>
> Full log:
>
>    https://lava.sirena.org.uk/scheduler/job/2106243#L11474
>
> There is also a bisection for the mm mkdirty selftest which runs into
> the same patch on at least Raspberry Pi 4:
>
> # # -----------------
> # # running ./mkdirty
> # # -----------------
> # # # [INFO] detected THP size: 2048 KiB
> # # TAP version 13
> # # 1..6
> # # # [INFO] PTRACE write access
> # # ok 1 SIGSEGV generated, page not modified
> # # # [INFO] PTRACE write access to THP
> # # ok 2 SIGSEGV generated, page not modified
> # # # [INFO] Page migration
> # # not ok 3 SIGSEGV generated, page not modified
> # # # [INFO] Page migration of THP
> # # not ok 4 SIGSEGV generated, page not modified
> # # # [INFO] PTE-mapping a THP
> # # not ok 5 SIGSEGV generated, page not modified
> # # # [INFO] UFFDIO_COPY
> # # ok 6 # SKIP __NR_userfaultfd failed
> # # Bail out! 3 out of 6 tests failed
> # # # 1 skipped test(s) detected. Consider enabling relevant config optio=
ns to improve coverage.
> # # # Totals: pass:2 fail:3 xfail:0 xpass:0 skip:1 error:0
> # # [FAIL]
> # not ok 61 mkdirty # exit=3D1
>
> Full log for that:
>
>    https://lava.sirena.org.uk/scheduler/job/2106236#L6939
>
> and I'm also seeing some LTP failures going into these commits that I'll
> report separately.
>
> bisect log for the futex test:
>
> # bad: [fe4d0dea039f2befb93f27569593ec209843b0f5] Add linux-next specific=
 files for 20251119
> # good: [ef96b7dd050abd62905588c41ffb397e0c9598c7] Merge branch 'for-linu=
x-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
> # good: [bd79452b39c21599e2cff42e9fbeb182656b6f6a] MAINTAINERS: adjust fi=
le entry in RISC-V MICROCHIP SUPPORT
> # good: [21e68bcb1b0c688c2d9ca0d457922febac650ac1] regulator: renesas-usb=
-vbus-regulator: Remove unused headers
> # good: [96498e804cb6629e02747336a0a33e4955449732] spi: davinci: remove p=
latform data header
> # good: [4422df6782eb7aa9725a3c09d9ba3c38ecc85df4] ASoC: ux500: mop500_ab=
8500: convert to snd_soc_dapm_xxx()
> # good: [9e510e677090bb794b46348b10e1c8038286e00a] spi: aspeed: Add suppo=
rt for the AST2700 SPI controller
> # good: [118eb2cb97b8fc0d515bb0449495959247db58f0] spi: bcm63xx: drop wro=
ng casts in probe()
> # good: [d5c8b7902a41625ea328b52c78ebe750fbf6fef7] ASoC: Intel: avs: Hono=
r NHLT override when setting up a path
> # good: [6402ddf3027d8975f135cf2b2014d6bbeb2d3436] MAINTAINERS: refer to =
trivial-codec.yaml in relevant sections
> # good: [059f545832be85d29ac9ccc416a16f647aa78485] spi: add support for m=
icrochip "soft" spi controller
> # good: [4e00135b2dd1d7924a58bffa551b6ceb3bd836f2] spi: spi-cadence: supp=
orts transmission with bits_per_word of 16 and 32
> # good: [e65b871c9b5af9265aefc5b8cd34993586d93aab] ASoC: codecs: pm4125: =
Remove irq_chip on component unbind
> # good: [8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860] firmware: cs_dsp: fix =
kernel-doc warnings in a header file
> # good: [8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10] ASoC: codecs: lpass-rx=
-macro: add SM6115 compatible
> # good: [123cd174a3782307787268adf45f22de4d290128] ASoC: Intel: atom: Rep=
lace strcpy() with strscpy()
> # good: [1d562ba0aa7df81335bf96c02be77efe8d5bab87] spi: dt-bindings: nuvo=
ton,npcm-pspi: Convert to DT schema
> # good: [4d6e2211aeb932e096f673c88475016b1cc0f8ab] ASoC: Intel: boards: f=
ix HDMI playback lookup when HDMI-In capture used
> # good: [32172cf3cb543a04c41a1677c97a38e60cad05b6] ASoC: cs35l56: Allow r=
estoring factory calibration through ALSA control
> # good: [b3a5302484033331af37569f7277d00131694b57] ASoC: Intel: sof_rt568=
2: Add quirk override support
> # good: [873bc94689d832878befbcadc10b6ad5bb4e0027] ASoC: Intel: sof_sdw: =
add codec speaker support for the SKU
> # good: [772ada50282b0c80343c8989147db816961f571d] ASoC: cs35l56: Alter e=
rror codes for calibration routine
> # good: [6985defd1d832f1dd9d1977a6a2cc2cef7632704] regmap: sdw-mbq: Reord=
er regmap_mbq_context struct for better packing
> # good: [fb1ebb10468da414d57153ddebaab29c38ef1a78] regulator: core: disab=
le supply if enabling main regulator fails
> # good: [2089f086303b773e181567fd8d5df3038bd85937] regulator: mt6363: Rem=
ove unneeded semicolon
> # good: [6951be397ca8b8b167c9f99b5a11c541148c38cb] ASoC: codecs: pm4125: =
remove duplicate code
> # good: [4e92abd0a11b91af3742197a9ca962c3c00d0948] spi: imx: add i.MX51 E=
CSPI target mode support
> # good: [abc9a349b87ac0fd3ba8787ca00971b59c2e1257] spi: fsl-qspi: support=
 the SpacemiT K1 SoC
> # good: [55d03b5b5bdd04daf9a35ce49db18d8bb488dffb] spi: imx: remove CLK c=
alculation and check for target mode
> # good: [6bd1ad97eb790570c167d4de4ca59fbc9c33722a] regulator: pf9453: Fix=
 kernel doc for mux_poll()
> # good: [1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69] ASoC: SDCA: support Q7=
.8 volume format
> # good: [3c36965df80801344850388592e95033eceea05b] regulator: Add support=
 for MediaTek MT6363 SPMI PMIC Regulators
> # good: [2f538ef9f6f7c3d700c68536f21447dfc598f8c8] spi: aspeed: Use devm_=
iounmap() to unmap devm_ioremap() memory
> # good: [aa897ffc396b48cc39eee133b6b43175d0df9eb5] ASoC: dt-bindings: ti,=
pcm1862: convert to dtschema
> # good: [655079ac8a7721ac215a0596e3f33b740e01144a] ASoC: qcom: q6asm: Use=
 guard() for spin locks
> # good: [c4e68959af66df525d71db619ffe44af9178bb22] ASoC: dt-bindings: ti,=
tas2781: Add TAS5822 support
> # good: [380fd29d57abe6679d87ec56babe65ddc5873a37] spi: tegra210-quad: Ch=
eck hardware status on timeout
> # good: [af9c8092d84244ca54ffb590435735f788e7a170] regmap: i3c: Use ARRAY=
_SIZE()
> # good: [84194c66aaf78fed150edb217b9f341518b1cba2] ASoC: codecs: aw88261:=
 pass pointer directly instead of passing the address
> # good: [252abf2d07d33b1c70a59ba1c9395ba42bbd793e] regulator: Small clean=
up in of_get_regulation_constraints()
> # good: [2ecc8c089802e033d2e5204d21a9f467e2517df9] regulator: pf9453: rem=
ove unused I2C_LT register
> # good: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] regcache: maple: Split=
 ->populate() from ->init()
> # good: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] ASoC: soc-core: check =
ops & auto_selectable_formats in snd_soc_dai_get_fmt() to prevent dereferen=
ce error
> # good: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] ASoC: max98090/91: fix=
ing the stream index
> # good: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] spi: tle62x0: Add newl=
ine to sysfs attribute output
> # good: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] ASoC: codec: wm8400: r=
eplace printk() calls with dev_*() device aware logging
> # good: [20bcda681f8597e86070a4b3b12d1e4f541865d3] ASoC: codecs: va-macro=
: fix revision checking
> # good: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] ASoC: cs4271: Add supp=
ort for the external mclk
> # good: [28039efa4d8e8bbf98b066133a906bd4e307d496] MAINTAINERS: remove ob=
solete file entry in DIALOG SEMICONDUCTOR DRIVERS
> # good: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] regmap: warn users abo=
ut uninitialized flat cache
> # good: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] ASoC: qcom: sc7280: ma=
ke use of common helpers
> # good: [66fecfa91deb536a12ddf3d878a99590d7900277] ASoC: spacemit: use `d=
epends on` instead of `select`
> # good: [f034c16a4663eaf3198dc18b201ba50533fb5b81] ASoC: spacemit: add fa=
ilure check for spacemit_i2s_init_dai()
> # good: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] ASoC: sun4i-spdif: Sup=
port SPDIF output on A523 family
> # good: [ef042df96d0e1089764f39ede61bc8f140a4be00] ASoC: SDCA: Add HID bu=
tton IRQ
> # good: [4c33cef58965eb655a0ac8e243aa323581ec025f] regulator: pca9450: li=
nk regulator inputs to supply groups
> # good: [01313661b248c5ba586acae09bff57077dbec0a5] regulator: Let raspber=
rypi drivers depend on ARM
> # good: [e7434adf0c53a84d548226304cdb41c8818da1cb] ASoC: cs530x: Add SPI =
bus support for cs530x parts
> # good: [77a58ba7c64ccca20616aa03599766ccb0d1a330] spi: spi-mem: Trace ex=
ec_op
> # good: [4795375d8aa072e9aacb0b278e6203c6ca41816a] ASoC: cs-amp-lib-test:=
 Add test cases for cs_amp_set_efi_calibration_data()
> # good: [d29479abaded34b2b1dab2e17efe96a65eba3d61] ASoC: renesas: fsi: Co=
nstify struct fsi_stream_handler
> # good: [e973dfe9259095fb509ab12658c68d46f0e439d7] ASoC: qcom: sm8250: ad=
d qrb2210-sndcard compatible string
> # good: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] ASoC: sdw_utils: add n=
ame_prefix for rt1321 part id
> # good: [2528c15f314ece50218d1273654f630d74109583] ASoC: max98090/91: add=
ing DAPM routing for digital output for max98091
> # good: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] regulator: rpmh-regula=
tor: Add RPMH regulator support for PMR735D
> # good: [310bf433c01f78e0756fd5056a43118a2f77318c] ASoC: max98090/91: fix=
ing a space
> # good: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] spi: spi-qpic-snand: m=
ake qcom_spi_ecc_engine_ops_pipelined const
> # good: [638bae3fb225a708dc67db613af62f6d14c4eff4] ASoC: max98090/91: add=
ed DAPM widget for digital output for max98091
> # good: [ecba655bf54a661ffe078856cd8dbc898270e4b5] ASoC: fsl_aud2htx: add=
 IEC958_SUBFRAME_LE format in supported list
> # good: [7e1906643a7374529af74b013bba35e4fa4e6ffc] ASoC: codecs: va-macro=
: Clean up on error path in probe()
> # good: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] ASoC: soc.h: remove sn=
d_soc_kcontrol_component()
> # good: [6658472a3e2de08197acfe099ba71ee0e2505ecf] ASoC: amd: amd_sdw: Pr=
opagate the PCI subsystem Vendor and Device IDs
> # good: [fce217449075d59b29052b8cdac567f0f3e22641] ASoC: spacemit: add i2=
s support for K1 SoC
> # good: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] spi: aspeed: Fix an IS=
_ERR() vs NULL bug in probe()
> # good: [0743acf746a81e0460a56fd5ff847d97fa7eb370] spi: airoha: buffer mu=
st be 0xff-ed before writing
> # good: [d77daa49085b067137d0adbe3263f75a7ee13a1b] spi: aspeed: fix spell=
ing mistake "triming" -> "trimming"
> # good: [15afe57a874eaf104bfbb61ec598fa31627f7b19] ASoC: dt-bindings: qco=
m: Add Kaanapali LPASS macro codecs
> # good: [1e570e77392f43a3cdab2849d1f81535f8a033e2] ASoC: mxs-saif: suppor=
t usage with simple-audio-card
> # good: [fb25114cd760c13cf177d9ac37837fafcc9657b5] regulator: sy7636a: ad=
d gpios and input regulator
> # good: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] ASoC: codecs: rt5670: =
use SOC_VALUE_ENUM_SINGLE_DECL for DAC2 L/R MX-1B
> # good: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] regulator: rpmh-regula=
tor: Add RPMH regulator support for Glymur
> # good: [433e294c3c5b5d2020085a0e36c1cb47b694690a] regulator: core: forwa=
rd undervoltage events downstream by default
> # good: [0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4] ASoC: replace use of s=
ystem_wq with system_dfl_wq
> # good: [bf770d6d2097a52d87f4d9c88d0b05bd3998d7de] x86/module: Improve re=
location error messages
> # good: [c2d420796a427dda71a2400909864e7f8e037fd4] elfnote: Change ELFNOT=
E() to use __UNIQUE_ID()
> # good: [7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd] ASoC: sof-function-top=
ology-lib: escalate the log when missing function topoplogy
> # good: [64d87ccfae3326a9561fe41dc6073064a083e0df] spi: aspeed: Only map =
necessary address window region
> # good: [4d410ba9aa275e7990a270f63ce436990ace1bea] dt-bindings: sound: Up=
date ADMAIF bindings for tegra264
> # good: [5e537031f322d55315cd384398b726a9a0748d47] ASoC: codecs: Fix the =
error of excessive semicolons
> # good: [4412ab501677606436e5c49e41151a1e6eac7ac0] spi: dt-bindings: spi-=
qpic-snand: Add IPQ5332 compatible
> # good: [9797329220a2c6622411eb9ecf6a35b24ce09d04] ASoC: sof-function-top=
ology-lib: escalate the log when missing function topoplogy
> # good: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] spi: dw: add target mo=
de support
> # good: [6277a486a7faaa6c87f4bf1d59a2de233a093248] regulator: dt-bindings=
: Convert Dialog DA9211 Regulators to DT schema
> # good: [b83fb1b14c06bdd765903ac852ba20a14e24f227] spi: offload: Add offs=
et parameter
> git bisect start 'fe4d0dea039f2befb93f27569593ec209843b0f5' 'ef96b7dd050a=
bd62905588c41ffb397e0c9598c7' 'bd79452b39c21599e2cff42e9fbeb182656b6f6a' '2=
1e68bcb1b0c688c2d9ca0d457922febac650ac1' '96498e804cb6629e02747336a0a33e495=
5449732' '4422df6782eb7aa9725a3c09d9ba3c38ecc85df4' '9e510e677090bb794b4634=
8b10e1c8038286e00a' '118eb2cb97b8fc0d515bb0449495959247db58f0' 'd5c8b7902a4=
1625ea328b52c78ebe750fbf6fef7' '6402ddf3027d8975f135cf2b2014d6bbeb2d3436' '=
059f545832be85d29ac9ccc416a16f647aa78485' '4e00135b2dd1d7924a58bffa551b6ceb=
3bd836f2' 'e65b871c9b5af9265aefc5b8cd34993586d93aab' '8d63e85c5b50f1dbfa0cc=
b214bd91fe5d7e2e860' '8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10' '123cd174a3=
782307787268adf45f22de4d290128' '1d562ba0aa7df81335bf96c02be77efe8d5bab87' =
'4d6e2211aeb932e096f673c88475016b1cc0f8ab' '32172cf3cb543a04c41a1677c97a38e=
60cad05b6' 'b3a5302484033331af37569f7277d00131694b57' '873bc94689d832878bef=
bcadc10b6ad5bb4e0027' '772ada50282b0c80343c8989147db816961f571d' '6985defd1=
d832f1dd9d1977a6a2cc2cef7632704' 'fb1ebb10468da414d57153ddebaab29c38ef1a78'=
 '2089f086303b773e181567fd8d5df3038bd85937' '6951be397ca8b8b167c9f99b5a11c5=
41148c38cb' '4e92abd0a11b91af3742197a9ca962c3c00d0948' 'abc9a349b87ac0fd3ba=
8787ca00971b59c2e1257' '55d03b5b5bdd04daf9a35ce49db18d8bb488dffb' '6bd1ad97=
eb790570c167d4de4ca59fbc9c33722a' '1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69=
' '3c36965df80801344850388592e95033eceea05b' '2f538ef9f6f7c3d700c68536f2144=
7dfc598f8c8' 'aa897ffc396b48cc39eee133b6b43175d0df9eb5' '655079ac8a7721ac21=
5a0596e3f33b740e01144a' 'c4e68959af66df525d71db619ffe44af9178bb22' '380fd29=
d57abe6679d87ec56babe65ddc5873a37' 'af9c8092d84244ca54ffb590435735f788e7a17=
0' '84194c66aaf78fed150edb217b9f341518b1cba2' '252abf2d07d33b1c70a59ba1c939=
5ba42bbd793e' '2ecc8c089802e033d2e5204d21a9f467e2517df9' 'ed5d499b5c9cc11dd=
3edae1a7a55db7dfa4f1bdc' 'e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0' 'f1dfbc=
1b5cf8650ae9a0d543e5f5335fc0f478ce' 'ecd0de438c1f0ee86cf8f6d5047965a2a18144=
4b' '6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3' '20bcda681f8597e86070a4b3b12=
d1e4f541865d3' 'cf6bf51b53252284bafc7377a4d8dbf10f048b4d' '28039efa4d8e8bbf=
98b066133a906bd4e307d496' 'e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8' '8fdb0=
30fe283c84fd8d378c97ad0f32d6cdec6ce' '66fecfa91deb536a12ddf3d878a99590d7900=
277' 'f034c16a4663eaf3198dc18b201ba50533fb5b81' '4a5ac6cd05a7e54f1585d77794=
64d6ed6272c134' 'ef042df96d0e1089764f39ede61bc8f140a4be00' '4c33cef58965eb6=
55a0ac8e243aa323581ec025f' '01313661b248c5ba586acae09bff57077dbec0a5' 'e743=
4adf0c53a84d548226304cdb41c8818da1cb' '77a58ba7c64ccca20616aa03599766ccb0d1=
a330' '4795375d8aa072e9aacb0b278e6203c6ca41816a' 'd29479abaded34b2b1dab2e17=
efe96a65eba3d61' 'e973dfe9259095fb509ab12658c68d46f0e439d7' 'c17fa4cbc546c4=
31ccf13e9354d5d9c1cd247b7c' '2528c15f314ece50218d1273654f630d74109583' 'd05=
4cc3a2ccfb19484f3b54d69b6e416832dc8f4' '310bf433c01f78e0756fd5056a43118a2f7=
7318c' 'fd5ef3d69f8975bad16c437a337b5cb04c8217a2' '638bae3fb225a708dc67db61=
3af62f6d14c4eff4' 'ecba655bf54a661ffe078856cd8dbc898270e4b5' '7e1906643a737=
4529af74b013bba35e4fa4e6ffc' 'd742ebcfe524dc54023f7c520d2ed2e4b7203c19' '66=
58472a3e2de08197acfe099ba71ee0e2505ecf' 'fce217449075d59b29052b8cdac567f0f3=
e22641' '0cc08c8130ac8f74419f99fe707dc193b7f79d86' '0743acf746a81e0460a56fd=
5ff847d97fa7eb370' 'd77daa49085b067137d0adbe3263f75a7ee13a1b' '15afe57a874e=
af104bfbb61ec598fa31627f7b19' '1e570e77392f43a3cdab2849d1f81535f8a033e2' 'f=
b25114cd760c13cf177d9ac37837fafcc9657b5' '6621b0f118d500092f5f3d72ddddb22ae=
eb3c3a0' '65efe5404d151767653c7b7dd39bd2e7ad532c2d' '433e294c3c5b5d2020085a=
0e36c1cb47b694690a' '0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4' 'bf770d6d209=
7a52d87f4d9c88d0b05bd3998d7de' 'c2d420796a427dda71a2400909864e7f8e037fd4' '=
7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd' '64d87ccfae3326a9561fe41dc6073064=
a083e0df' '4d410ba9aa275e7990a270f63ce436990ace1bea' '5e537031f322d55315cd3=
84398b726a9a0748d47' '4412ab501677606436e5c49e41151a1e6eac7ac0' '9797329220=
a2c6622411eb9ecf6a35b24ce09d04' 'fe8cc44dd173cde5788ab4e3730ac61f3d316d9c' =
'6277a486a7faaa6c87f4bf1d59a2de233a093248' 'b83fb1b14c06bdd765903ac852ba20a=
14e24f227'
> # test job: [bd79452b39c21599e2cff42e9fbeb182656b6f6a] https://lava.siren=
a.org.uk/scheduler/job/2104091
> # test job: [21e68bcb1b0c688c2d9ca0d457922febac650ac1] https://lava.siren=
a.org.uk/scheduler/job/2104499
> # test job: [96498e804cb6629e02747336a0a33e4955449732] https://lava.siren=
a.org.uk/scheduler/job/2099744
> # test job: [4422df6782eb7aa9725a3c09d9ba3c38ecc85df4] https://lava.siren=
a.org.uk/scheduler/job/2097747
> # test job: [9e510e677090bb794b46348b10e1c8038286e00a] https://lava.siren=
a.org.uk/scheduler/job/2095684
> # test job: [118eb2cb97b8fc0d515bb0449495959247db58f0] https://lava.siren=
a.org.uk/scheduler/job/2092525
> # test job: [d5c8b7902a41625ea328b52c78ebe750fbf6fef7] https://lava.siren=
a.org.uk/scheduler/job/2092722
> # test job: [6402ddf3027d8975f135cf2b2014d6bbeb2d3436] https://lava.siren=
a.org.uk/scheduler/job/2086597
> # test job: [059f545832be85d29ac9ccc416a16f647aa78485] https://lava.siren=
a.org.uk/scheduler/job/2086754
> # test job: [4e00135b2dd1d7924a58bffa551b6ceb3bd836f2] https://lava.siren=
a.org.uk/scheduler/job/2082525
> # test job: [e65b871c9b5af9265aefc5b8cd34993586d93aab] https://lava.siren=
a.org.uk/scheduler/job/2083134
> # test job: [8d63e85c5b50f1dbfa0ccb214bd91fe5d7e2e860] https://lava.siren=
a.org.uk/scheduler/job/2082576
> # test job: [8ff3dcb0e8a8bf6c41f23ed4aa62d066d3948a10] https://lava.siren=
a.org.uk/scheduler/job/2083116
> # test job: [123cd174a3782307787268adf45f22de4d290128] https://lava.siren=
a.org.uk/scheduler/job/2078967
> # test job: [1d562ba0aa7df81335bf96c02be77efe8d5bab87] https://lava.siren=
a.org.uk/scheduler/job/2078346
> # test job: [4d6e2211aeb932e096f673c88475016b1cc0f8ab] https://lava.siren=
a.org.uk/scheduler/job/2078001
> # test job: [32172cf3cb543a04c41a1677c97a38e60cad05b6] https://lava.siren=
a.org.uk/scheduler/job/2075073
> # test job: [b3a5302484033331af37569f7277d00131694b57] https://lava.siren=
a.org.uk/scheduler/job/2074546
> # test job: [873bc94689d832878befbcadc10b6ad5bb4e0027] https://lava.siren=
a.org.uk/scheduler/job/2074833
> # test job: [772ada50282b0c80343c8989147db816961f571d] https://lava.siren=
a.org.uk/scheduler/job/2069152
> # test job: [6985defd1d832f1dd9d1977a6a2cc2cef7632704] https://lava.siren=
a.org.uk/scheduler/job/2059121
> # test job: [fb1ebb10468da414d57153ddebaab29c38ef1a78] https://lava.siren=
a.org.uk/scheduler/job/2059787
> # test job: [2089f086303b773e181567fd8d5df3038bd85937] https://lava.siren=
a.org.uk/scheduler/job/2058104
> # test job: [6951be397ca8b8b167c9f99b5a11c541148c38cb] https://lava.siren=
a.org.uk/scheduler/job/2055777
> # test job: [4e92abd0a11b91af3742197a9ca962c3c00d0948] https://lava.siren=
a.org.uk/scheduler/job/2055848
> # test job: [abc9a349b87ac0fd3ba8787ca00971b59c2e1257] https://lava.siren=
a.org.uk/scheduler/job/2054637
> # test job: [55d03b5b5bdd04daf9a35ce49db18d8bb488dffb] https://lava.siren=
a.org.uk/scheduler/job/2053889
> # test job: [6bd1ad97eb790570c167d4de4ca59fbc9c33722a] https://lava.siren=
a.org.uk/scheduler/job/2053541
> # test job: [1b0f3f9ee41ee2bdd206667f85ea2aa36dfe6e69] https://lava.siren=
a.org.uk/scheduler/job/2053565
> # test job: [3c36965df80801344850388592e95033eceea05b] https://lava.siren=
a.org.uk/scheduler/job/2049494
> # test job: [2f538ef9f6f7c3d700c68536f21447dfc598f8c8] https://lava.siren=
a.org.uk/scheduler/job/2048656
> # test job: [aa897ffc396b48cc39eee133b6b43175d0df9eb5] https://lava.siren=
a.org.uk/scheduler/job/2048772
> # test job: [655079ac8a7721ac215a0596e3f33b740e01144a] https://lava.siren=
a.org.uk/scheduler/job/2049697
> # test job: [c4e68959af66df525d71db619ffe44af9178bb22] https://lava.siren=
a.org.uk/scheduler/job/2044037
> # test job: [380fd29d57abe6679d87ec56babe65ddc5873a37] https://lava.siren=
a.org.uk/scheduler/job/2044746
> # test job: [af9c8092d84244ca54ffb590435735f788e7a170] https://lava.siren=
a.org.uk/scheduler/job/2043671
> # test job: [84194c66aaf78fed150edb217b9f341518b1cba2] https://lava.siren=
a.org.uk/scheduler/job/2038356
> # test job: [252abf2d07d33b1c70a59ba1c9395ba42bbd793e] https://lava.siren=
a.org.uk/scheduler/job/2038551
> # test job: [2ecc8c089802e033d2e5204d21a9f467e2517df9] https://lava.siren=
a.org.uk/scheduler/job/2038657
> # test job: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] https://lava.siren=
a.org.uk/scheduler/job/2029002
> # test job: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] https://lava.siren=
a.org.uk/scheduler/job/2026439
> # test job: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] https://lava.siren=
a.org.uk/scheduler/job/2025521
> # test job: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] https://lava.siren=
a.org.uk/scheduler/job/2026118
> # test job: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] https://lava.siren=
a.org.uk/scheduler/job/2025847
> # test job: [20bcda681f8597e86070a4b3b12d1e4f541865d3] https://lava.siren=
a.org.uk/scheduler/job/2022995
> # test job: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] https://lava.siren=
a.org.uk/scheduler/job/2023023
> # test job: [28039efa4d8e8bbf98b066133a906bd4e307d496] https://lava.siren=
a.org.uk/scheduler/job/2020299
> # test job: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] https://lava.siren=
a.org.uk/scheduler/job/2020172
> # test job: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] https://lava.siren=
a.org.uk/scheduler/job/2021459
> # test job: [66fecfa91deb536a12ddf3d878a99590d7900277] https://lava.siren=
a.org.uk/scheduler/job/2015314
> # test job: [f034c16a4663eaf3198dc18b201ba50533fb5b81] https://lava.siren=
a.org.uk/scheduler/job/2015467
> # test job: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] https://lava.siren=
a.org.uk/scheduler/job/2011273
> # test job: [ef042df96d0e1089764f39ede61bc8f140a4be00] https://lava.siren=
a.org.uk/scheduler/job/2010164
> # test job: [4c33cef58965eb655a0ac8e243aa323581ec025f] https://lava.siren=
a.org.uk/scheduler/job/2009454
> # test job: [01313661b248c5ba586acae09bff57077dbec0a5] https://lava.siren=
a.org.uk/scheduler/job/2008766
> # test job: [e7434adf0c53a84d548226304cdb41c8818da1cb] https://lava.siren=
a.org.uk/scheduler/job/2007795
> # test job: [77a58ba7c64ccca20616aa03599766ccb0d1a330] https://lava.siren=
a.org.uk/scheduler/job/2007309
> # test job: [4795375d8aa072e9aacb0b278e6203c6ca41816a] https://lava.siren=
a.org.uk/scheduler/job/2009693
> # test job: [d29479abaded34b2b1dab2e17efe96a65eba3d61] https://lava.siren=
a.org.uk/scheduler/job/2008426
> # test job: [e973dfe9259095fb509ab12658c68d46f0e439d7] https://lava.siren=
a.org.uk/scheduler/job/2008132
> # test job: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] https://lava.siren=
a.org.uk/scheduler/job/2000029
> # test job: [2528c15f314ece50218d1273654f630d74109583] https://lava.siren=
a.org.uk/scheduler/job/1997624
> # test job: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] https://lava.siren=
a.org.uk/scheduler/job/1995769
> # test job: [310bf433c01f78e0756fd5056a43118a2f77318c] https://lava.siren=
a.org.uk/scheduler/job/1996063
> # test job: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] https://lava.siren=
a.org.uk/scheduler/job/1996144
> # test job: [638bae3fb225a708dc67db613af62f6d14c4eff4] https://lava.siren=
a.org.uk/scheduler/job/1991895
> # test job: [ecba655bf54a661ffe078856cd8dbc898270e4b5] https://lava.siren=
a.org.uk/scheduler/job/1985163
> # test job: [7e1906643a7374529af74b013bba35e4fa4e6ffc] https://lava.siren=
a.org.uk/scheduler/job/1978631
> # test job: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] https://lava.siren=
a.org.uk/scheduler/job/1975980
> # test job: [6658472a3e2de08197acfe099ba71ee0e2505ecf] https://lava.siren=
a.org.uk/scheduler/job/1975543
> # test job: [fce217449075d59b29052b8cdac567f0f3e22641] https://lava.siren=
a.org.uk/scheduler/job/1975685
> # test job: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] https://lava.siren=
a.org.uk/scheduler/job/1965718
> # test job: [0743acf746a81e0460a56fd5ff847d97fa7eb370] https://lava.siren=
a.org.uk/scheduler/job/1964864
> # test job: [d77daa49085b067137d0adbe3263f75a7ee13a1b] https://lava.siren=
a.org.uk/scheduler/job/1962775
> # test job: [15afe57a874eaf104bfbb61ec598fa31627f7b19] https://lava.siren=
a.org.uk/scheduler/job/1962957
> # test job: [1e570e77392f43a3cdab2849d1f81535f8a033e2] https://lava.siren=
a.org.uk/scheduler/job/1962291
> # test job: [fb25114cd760c13cf177d9ac37837fafcc9657b5] https://lava.siren=
a.org.uk/scheduler/job/1960165
> # test job: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] https://lava.siren=
a.org.uk/scheduler/job/1959743
> # test job: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] https://lava.siren=
a.org.uk/scheduler/job/1959980
> # test job: [433e294c3c5b5d2020085a0e36c1cb47b694690a] https://lava.siren=
a.org.uk/scheduler/job/1957437
> # test job: [0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4] https://lava.siren=
a.org.uk/scheduler/job/1957381
> # test job: [bf770d6d2097a52d87f4d9c88d0b05bd3998d7de] https://lava.siren=
a.org.uk/scheduler/job/1986562
> # test job: [c2d420796a427dda71a2400909864e7f8e037fd4] https://lava.siren=
a.org.uk/scheduler/job/1986677
> # test job: [7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd] https://lava.siren=
a.org.uk/scheduler/job/1954262
> # test job: [64d87ccfae3326a9561fe41dc6073064a083e0df] https://lava.siren=
a.org.uk/scheduler/job/1947255
> # test job: [4d410ba9aa275e7990a270f63ce436990ace1bea] https://lava.siren=
a.org.uk/scheduler/job/1947749
> # test job: [5e537031f322d55315cd384398b726a9a0748d47] https://lava.siren=
a.org.uk/scheduler/job/1946642
> # test job: [4412ab501677606436e5c49e41151a1e6eac7ac0] https://lava.siren=
a.org.uk/scheduler/job/1946288
> # test job: [9797329220a2c6622411eb9ecf6a35b24ce09d04] https://lava.siren=
a.org.uk/scheduler/job/1947398
> # test job: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] https://lava.siren=
a.org.uk/scheduler/job/1946085
> # test job: [6277a486a7faaa6c87f4bf1d59a2de233a093248] https://lava.siren=
a.org.uk/scheduler/job/1947023
> # test job: [b83fb1b14c06bdd765903ac852ba20a14e24f227] https://lava.siren=
a.org.uk/scheduler/job/1946841
> # test job: [fe4d0dea039f2befb93f27569593ec209843b0f5] https://lava.siren=
a.org.uk/scheduler/job/2106243
> # bad: [fe4d0dea039f2befb93f27569593ec209843b0f5] Add linux-next specific=
 files for 20251119
> git bisect bad fe4d0dea039f2befb93f27569593ec209843b0f5
> # test job: [c8e2262ce3e7658f7689975d66bbdecaf2cf95f9] https://lava.siren=
a.org.uk/scheduler/job/2106516
> # bad: [c8e2262ce3e7658f7689975d66bbdecaf2cf95f9] Merge branch 'master' o=
f https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git
> git bisect bad c8e2262ce3e7658f7689975d66bbdecaf2cf95f9
> # test job: [2d48532d7f2e7d165f29ca9f2cdd589d9a8c2554] https://lava.siren=
a.org.uk/scheduler/job/2106588
> # bad: [2d48532d7f2e7d165f29ca9f2cdd589d9a8c2554] Merge branch 'fs-next' =
of linux-next
> git bisect bad 2d48532d7f2e7d165f29ca9f2cdd589d9a8c2554
> # test job: [f80c4f29e62d88f612101dc7addb0cc7a3bc628d] https://lava.siren=
a.org.uk/scheduler/job/2106622
> # bad: [f80c4f29e62d88f612101dc7addb0cc7a3bc628d] Merge branch 'next' of =
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git
> git bisect bad f80c4f29e62d88f612101dc7addb0cc7a3bc628d
> # test job: [b7ea3276cbe7ea3cb272c4f7fc0f38db6ea7f1ed] https://lava.siren=
a.org.uk/scheduler/job/2106673
> # bad: [b7ea3276cbe7ea3cb272c4f7fc0f38db6ea7f1ed] Merge branch 'at91-next=
' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
> git bisect bad b7ea3276cbe7ea3cb272c4f7fc0f38db6ea7f1ed
> # test job: [e92c9e71a82b75ce8297b60db4693af85ef4593b] https://lava.siren=
a.org.uk/scheduler/job/2106728
> # bad: [e92c9e71a82b75ce8297b60db4693af85ef4593b] Merge branch 'mm-unstab=
le' of https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad e92c9e71a82b75ce8297b60db4693af85ef4593b
> # test job: [7d808bf13943f4c6a6142400bffe14267f6dc997] https://lava.siren=
a.org.uk/scheduler/job/2106774
> # good: [7d808bf13943f4c6a6142400bffe14267f6dc997] mm/damon/tests/sysfs-k=
unit: handle alloc failures on damon_sysfs_test_add_targets()
> git bisect good 7d808bf13943f4c6a6142400bffe14267f6dc997
> # test job: [93f3c3ac6e9a0695dec5ca8c5aa0fdc7ada3293e] https://lava.siren=
a.org.uk/scheduler/job/2106827
> # bad: [93f3c3ac6e9a0695dec5ca8c5aa0fdc7ada3293e] mm: vmstat: correct the=
 comment above preempt_disable_nested()
> git bisect bad 93f3c3ac6e9a0695dec5ca8c5aa0fdc7ada3293e
> # test job: [16cdd4e5a52b421b27b598b9eee3cd18212944a1] https://lava.siren=
a.org.uk/scheduler/job/2106960
> # good: [16cdd4e5a52b421b27b598b9eee3cd18212944a1] migrate: optimise allo=
c_migration_target()
> git bisect good 16cdd4e5a52b421b27b598b9eee3cd18212944a1
> # test job: [3da23b1058cde436f5ab711f4597dbe75865ea38] https://lava.siren=
a.org.uk/scheduler/job/2107042
> # bad: [3da23b1058cde436f5ab711f4597dbe75865ea38] tools/testing/selftests=
/mm: add smaps visibility guard region test
> git bisect bad 3da23b1058cde436f5ab711f4597dbe75865ea38
> # test job: [6b82275fdba27802ad7ec6910b86d83bea2dda8d] https://lava.siren=
a.org.uk/scheduler/job/2107095
> # good: [6b82275fdba27802ad7ec6910b86d83bea2dda8d] mm: add atomic VMA fla=
gs and set VM_MAYBE_GUARD as such
> git bisect good 6b82275fdba27802ad7ec6910b86d83bea2dda8d
> # test job: [b331f7745489548c5a020301f6f3b4aad20c7b77] https://lava.siren=
a.org.uk/scheduler/job/2107146
> # bad: [b331f7745489548c5a020301f6f3b4aad20c7b77] mm: introduce copy-on-f=
ork VMAs and make VM_MAYBE_GUARD one
> git bisect bad b331f7745489548c5a020301f6f3b4aad20c7b77
> # test job: [f24f3801039f9a2033e3a2390fccc5adc00a8df7] https://lava.siren=
a.org.uk/scheduler/job/2107157
> # good: [f24f3801039f9a2033e3a2390fccc5adc00a8df7] mm: implement sticky V=
MA flags
> git bisect good f24f3801039f9a2033e3a2390fccc5adc00a8df7
> # test job: [2c91ae77d8fbafb153c13e554f50b7bbeef59d76] https://lava.siren=
a.org.uk/scheduler/job/2107231
> # bad: [2c91ae77d8fbafb153c13e554f50b7bbeef59d76] mm-implement-sticky-vma=
-flags-fix-2
> git bisect bad 2c91ae77d8fbafb153c13e554f50b7bbeef59d76
> # test job: [79ee48c12ef8fe9a3daf0dbeda74f038a3f557be] https://lava.siren=
a.org.uk/scheduler/job/2107257
> # bad: [79ee48c12ef8fe9a3daf0dbeda74f038a3f557be] mm-implement-sticky-vma=
-flags-fix
> git bisect bad 79ee48c12ef8fe9a3daf0dbeda74f038a3f557be
> # first bad commit: [79ee48c12ef8fe9a3daf0dbeda74f038a3f557be] mm-impleme=
nt-sticky-vma-flags-fix

