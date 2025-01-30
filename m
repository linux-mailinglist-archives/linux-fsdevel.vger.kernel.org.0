Return-Path: <linux-fsdevel+bounces-40438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6EA2354B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2011A1888159
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978411F37D4;
	Thu, 30 Jan 2025 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XPvV2A+3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cd+lPFsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAF1F37B9;
	Thu, 30 Jan 2025 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269675; cv=fail; b=Y1l8bhrqnB9e2MQHgYyIBA4NNRG9X7/yNNUjC3Nh/QBnuxr5AJxZAAdei87TdXAudTQ/U1sUUG1poaUfbv7N2JHl7xNuMDwlr0pVpkd8PzUbmw0KaUTvcmGruLvVpz1uRqZBbeuGWF95lX0w3fDV/yX2XIOlyc/UU7EQrSQ8I18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269675; c=relaxed/simple;
	bh=yrNH0Po14UYz4y0L4buoTGHIv6nykIEG++ItXvLPkKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MizHWK0PKmEyt6J16/bwKhcrfYIXxJNsue575UVrb2SHc7xnRRfri0RBdfd+GeEVtnrFKUqQxB212Tb97kY7O94JEhGhX2kgzv+2LNIPuR7bgz9uUQnVCANmhSLpdGZg3n54PonmaevZrGG8bly0kqNaNJzei0FuWzoGJYumlHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XPvV2A+3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cd+lPFsl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJig0N010291;
	Thu, 30 Jan 2025 20:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hskeFoXwHdhQ92h/U+r/jHo6BZpLt2aINstNSYk42Cc=; b=
	XPvV2A+3ZDZ1hPZMFgb2+Tw3z//P9aLbx301LUO3PIDtLxzM4YLAA88pi4a66yVY
	enk2br3hTOFmfh16yshT5KqvGZG5hwKrzdquCHnP4w3tWj8UNy/dI6PSqJvFQl1Q
	VW/Ax7Jh69xDlcRiAMMswgt7Jeh7N/yDPifmUn4gwUKPROCXVELtC5lfaZA3yeU5
	EVkixSJKCQNgIm6YANY9hHyKsJzm5Tz7/piUDsGJXtI5SS4YCB2ITBUBFJk98HjA
	dCFD3+0xZe79cS3aoyfoY5ROE90l72h0287lfqtJ63xTMeS+cnz2l8i3AVkpqjl5
	Jl9b5tKNKA3hO30mK+h/mg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gf7kg6ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKene6032289;
	Thu, 30 Jan 2025 20:40:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44gf933ye1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/6M4rcKBj+GZ6JvBnBoGQGuJOCpKt31HXSt3J4mIu7oAieUrtE0ZTW9h/9rk6wY2n4e3VqRDorYe7JAoqMzUIJoFUyZ8jsOqUMSlA91Lx7NkniDxpfkV5+Eg79+9R0pq060vEsBM1xI5ccZwqEZinnWL2OG70roFe/RcDzPrOOSGI2/v46UqItml5VPO62w3+Am0WpUQSxIIEHtxIlkipsIMqi+CwPlZXLhebognzvEYzuWcdoS3eF0vKekNiyEZfUUlStd5u6OcxaUTstPha0LLktCx1lpcvFCQcVApZGr6Bg5/KFoVZtHMl29jWBPjB1C3dO4jr7P/jSANpp65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hskeFoXwHdhQ92h/U+r/jHo6BZpLt2aINstNSYk42Cc=;
 b=e1+0Y8pic0B2hdyunhjWC7OSEE0pe0y6A4z+zx15M1v4oqXdqEPt2x6yjcg72nSUtuoe8CvCc14Kcyb3xWJg7IzVWb6N5QuaBzG84A0mYWQSvogKcIm4djokiLkL2EgKVvrtWdvGJNAORpvIjetocMG8iU0J59ZmUk+u+goQD8gnooR48/Q156VxCo71+MXKozSH9cY0AMQy4/QyAK3Hvm3D0YqLuXnO7jaOISOiph9ASCmxtka0aDyCLYjG6y0C/4MjJihEyYrVi5eM72w/DY2nVwu/7jlzx0FPL0+kQt8n8spfyDBaYHU+g2HIJWT+SJU/Tw6xeUnfV42O18mszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hskeFoXwHdhQ92h/U+r/jHo6BZpLt2aINstNSYk42Cc=;
 b=Cd+lPFslo+Bfv/lbZzwH6UARWjnVCaFkugYJqSlMONXUqyp3F7NXs3L3cMMdqRGQ3xEXoDONxLJZ6wECZzuFY1TMNYZNhMQjrkz7/V0zxJt/Oorv6sCkL3c8klzneVHx90haQo/PUZvOaeV6SK60vEkT2UxN6ock5M29womhAsY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 20:40:51 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 20:40:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v7 6/6] selftests/mm: use PIDFD_SELF in guard pages test
Date: Thu, 30 Jan 2025 20:40:31 +0000
Message-ID: <69fbbe088d3424de9983e145228459cb05a8f13d.1738268370.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0208.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ddfab8-81f5-4ff3-f324-08dd416e62cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kKmaK60y+D5hTsPEbtUctQNxmGQT/jv+P95cLtdY5w1D9fqRs2S28h08XEHy?=
 =?us-ascii?Q?B/OPsfPQ79Ud3Bbio+00S9GFuXQaGXYfulgkitiHXd9R+3lsJrgwj1UtPTne?=
 =?us-ascii?Q?MECVR/G3RrJWGFyKZ49jshgSHBKhfCFIkgWmbQUas1rxnoihSEhm57ZW4RnH?=
 =?us-ascii?Q?cTGHubmRHzRjYNjGf1SbR0M6MrZNzUgowcEHDNIda4Fp+89M70zm1LhZxVPg?=
 =?us-ascii?Q?ErNk3LpuL33cKyeluanISJAMAfshF3shrkQAXozmAr5NNapxVK7kzn60tIgR?=
 =?us-ascii?Q?3fXZotvzXMjE1lo6rTg6Hx1NftjSAbBiLOvXn5JxUV2P9vUPLhH2cB1INX7+?=
 =?us-ascii?Q?IjJqYDdqxWxPx6we/M/YCaPuRPxkzktrZLOIuPIygnDWz1An3fVvkI6ALXUG?=
 =?us-ascii?Q?i4He/CMce4qtd912UWC0yNzNijIS9Lzs0B5VBDPPV1GF9Fi2J8biU2Z6oNPH?=
 =?us-ascii?Q?goMaedSlUieuZcjqSHgx6l4ynb8pRANdjahmiYgoFLBkYFhKKf5qFTSVxQfL?=
 =?us-ascii?Q?wbtYgCoqNWygD35yL+e7kotTI2ZhnUbTf0IulKIxxjA2nqhyByhO794ryOyF?=
 =?us-ascii?Q?Ait1rFqiXubKpk4U03wp+2RosgnmsGUcz+5vD/q50YOiXkB1FGceWbmgUh4R?=
 =?us-ascii?Q?AnfggOxVysUkUoRp2AIsBoUkP4p6OXgQBLU9NlpUIQ2Pya/7fM4bJOQ6RF72?=
 =?us-ascii?Q?gctPQpPzDvGGGPWcYtkyttKZmHRIwTZ2SmltbPZoZ9QvjLiC5uSOBinK2ehb?=
 =?us-ascii?Q?td0OLjTYKe6rZrKp8AdihItAL4eRZ/64H5elLlg015M1iF4RQc577TMHHEoD?=
 =?us-ascii?Q?veT+1R8i5vPHPk+HZMgGHyO4MlxhCId50Z55V1RjlUy2KGkIRabG1PL7qoPi?=
 =?us-ascii?Q?OyH4yBWXcwV5UjMj5FpIWHqWfA+sMG6lQXygaFZas9K3uy47uwtHSSW2V1r1?=
 =?us-ascii?Q?rklJQ7feIk6ZubuX8b5vby630EeVDpC49jPZI1/TYL2BFaIYDUQ5LmRe2KUQ?=
 =?us-ascii?Q?HQp5y5+6sSJt7hllghcVdqcmcvMs10hUM9+ZT++Rzu16TgvheTyUUwUV6wd8?=
 =?us-ascii?Q?3IC8LAsOWq1MAqMeAeN2pnyijIVw/5hV3eAdFNM9zr/DUA4k90ObVPRjcB0Y?=
 =?us-ascii?Q?hu4FeEz7KOlhjBaFVW12b3NsPl7jcNslSnKHNUPFL1Ub+q/tENV7YNwKQeAv?=
 =?us-ascii?Q?WMfiwYPO1vHV199VEqWb+eIzrZ0c3GhSCczWzWtn/0yxtGtxJN9scbDjlOZC?=
 =?us-ascii?Q?zNJqywUQlsmjQG5jK9kMXs16n/Jv9GDsbG23av1jrBeO0GFmZoB/ZY5OZfmx?=
 =?us-ascii?Q?2iDzdMMgkZGIMhuoM1JtlO85+3M0/L0XpFzw9cXICO+QsNiaH+z7cdWhjkhk?=
 =?us-ascii?Q?3nusSpySeRZb4T73B/RwDJsUdtvY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3FZ6B40OoZyyVohdkQylI8gOzszcp2grOl7GGlcilIMiz2NNpzZb4kAU4s03?=
 =?us-ascii?Q?Jypt2SW80ct5VkiRSZ9aJ+t+o/DH0IYW4PxqsciHpKrITOSq4cz7t+rMOPKi?=
 =?us-ascii?Q?/igy97gg/H7a9WEDN+CUVrmw6moKRd83f9ic45/ZxGFgwtMC4dPONIDKrChO?=
 =?us-ascii?Q?cFC2TEnot1zI9ljRhoTyf/DdlaQM1F067SIPVaQx4bAMRCc8aR3wTHDaFVTx?=
 =?us-ascii?Q?VkDtai/fNdhC/0o/gcJNNxPf+vrZ9zISF1Fxjx53Gvpb3n5SkZCEL3TKnyat?=
 =?us-ascii?Q?MtmylLHgjiir+y+9fv33DXU4fSx7x2Y7BgjeKrd88FKI5HiMCPT9+zYZTJ3e?=
 =?us-ascii?Q?5S6pFjH63LeR7wK1kjd1GyAYu9KVYisW4Wjpoac4fvngSAM5oHTlbRMXMNCj?=
 =?us-ascii?Q?8ymzN8f5fJZ4dO1V+n6Qt418N/PvhEm9XfdScSlzgsFNzEZrOsF/OUojEnhj?=
 =?us-ascii?Q?ULw2vZkx05RILx91qjATk6MbkVBlClRrXKO+h0eVRhJevdn4CKMidGGLBsHg?=
 =?us-ascii?Q?z3uXQbJtxDoPJ5m3wyzXtEgo0xwTnRvGVk5XTZC+++u+CdTbEF39AAdXQ7oo?=
 =?us-ascii?Q?eU6QLucfdu/AvRA3c7ghoJi+0zgHjN3aAFWhMrfrqQBixsk+s+vR6cFxPA0H?=
 =?us-ascii?Q?widFNA1PU+yDatg4rrB26Y3wRSttPNk5AroyF0ZSSZgyF/Xf2MfQ/cxsdim+?=
 =?us-ascii?Q?iaGVvBv8WBi3ppE443RtUK1G9rwLpa7RP1J/9T9hkDOR0bMcs/Vva3v8TqyR?=
 =?us-ascii?Q?YCc5uYj0PADOZhhCfuZRXUBS0nP6F5x8STWhn3RWZkjuuesZin89Oiyecb0n?=
 =?us-ascii?Q?u8IhepqTIDidh5uFCmPtQq74ASBUeoCoJdffRTo8p6RFgrr0yIdt0B5MDc8s?=
 =?us-ascii?Q?/ombKPcKx2Z/+C7eQ98Xdak9htodpEB5UFyVjwIYPb16ml2BREvVw2vW1C7A?=
 =?us-ascii?Q?3+fG0kxCpMIxXy9Ycrl2sKdZI04VKCTwc5J37SYGrSa5hrWMpVSw+ivl+NRE?=
 =?us-ascii?Q?JQO4w60+e+GfyL6z5lEcVRi0uaJebjs0fNY9G1X8DoCHUKzCn1pCAWYex4er?=
 =?us-ascii?Q?yNdvzZB4I1A/c9oaZQd7V983lnFWuw+qeIbvc4bx/RLjVOL7hIrWZQSaiUw/?=
 =?us-ascii?Q?fhkvB9LrnMuPdecHTb4KGjj6a81XE6iHXjn3axYD26Y1ODeBaunOTmpJ3+vC?=
 =?us-ascii?Q?b81TvoXk5u3pfBjwJA2FbXZPYd/jLSWA10dqz7jESJUHG+nXWNR16aM0gqHh?=
 =?us-ascii?Q?r63LwR1EBth7ZUrY9rmXKpg0h6S4RYUE5kQEChuZeR9VUvp0NdWIWx92r6lT?=
 =?us-ascii?Q?Neu7Lqifh9kEWxYo5TDqq34PtsP+d1W92i3X/DJAVG8AH1vvDGVg+reXZwX7?=
 =?us-ascii?Q?Gr9fzg/4GKutaWHlNrPUXR4iEE3IYTlnuDym2ebqm55+oqVAfLzausxGXVPr?=
 =?us-ascii?Q?0G8m0dU1myhqIQ5dwNrkFSwj+15u7duvBeDXdRoe2nS/CdwZFACrUHS+JS9L?=
 =?us-ascii?Q?YLWbXkqhqFyheiBfweFSmKX4ykYti40+s6x8ONk4qamtXdXPswFDUHtHPvfY?=
 =?us-ascii?Q?IXGfQjyl+BRmDoBQdmpBuiWxXogzcqenXYv2HzBWubQmSqDgQIxFTZx2Y/WJ?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bhH/A3HwpaBlINvPWLrAE4nThkji6K//oUDnMNmfFujf00+/5BXJqjy/cae9qVrnufJVvyCHPIbhXo6sOrXerGkV1td86TJCThdPIPqjKcVK8M987uPImS4qYV7VqrokR23jRmyOQPOdxoNaRsyVvBRZGQjkZpypMU6hFJTg0oGWkyFyQLW/E/7yswypkUkL90djgRmU1Qy19k3nF+1VxxcLX5LMELbSZsG9FB63LxNflih0wb3atQw8fRadzai9cmCmkbLeO1ap6I9XSFjlMOhDvHY3WaVxWm3DdXAptLvEbLXprEvwHR5QYFM5O2kjvmrzRYzzrNW09dhErwUrqV19uhBiMh6PHbD5/53vJnN3jaODH9ceBni+9yqQ9mpqg0AaK2i5fD061axgEEMwaPienyDVxziTVB8ioamPuTi9rAlhGz1UGrrflwjl86+H1DqUTdEM9R359tRRlnP97YSaYt4A3EBqcfHm8Q735NytRi6cINU9SiAEJhMAfqFhS1z3gAN6O3BzayNmeTF128n1jpIu9ZuwdCTlYSejKnaoxaWzGl73CfBc4/dGDuulQcefN9ocw6UH22BduteFGLD8uHyNKlo0e7DHWicXa8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ddfab8-81f5-4ff3-f324-08dd416e62cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:40:51.7686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0bpBzxpbTKkZO9Ckcz2H351KVjds8fqB3+RkVvL5VJURRI6MxUtiNG92XyDs1Qlltl3ERfrPmUtH/Ogr1H/8XZTItC/qfVMIigZ7MuJ4rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501300158
X-Proofpoint-GUID: PEzxQ-nTMSLNURM0U0S_mNH0cLTeOgIm
X-Proofpoint-ORIG-GUID: PEzxQ-nTMSLNURM0U0S_mNH0cLTeOgIm

Now we have PIDFD_SELF available for process_madvise(), make use of it in
the guard pages test.

This is both more convenient and asserts that PIDFD_SELF works as expected.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/Makefile      |  4 ++++
 tools/testing/selftests/mm/guard-pages.c | 15 +++------------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 63ce39d024bb..ecc4252fa3fe 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -225,6 +225,10 @@ $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
 
 $(OUTPUT)/migration: LDLIBS += -lnuma
 
+# We need uapi/pdifd.h but need to work around broken linux/fcntl.h, so
+# explicitly import
+$(OUTPUT)/guard-pages: CFLAGS += -I $(top_srcdir)/tools/include
+
 local_config.mk local_config.h: check_config.sh
 	/bin/sh ./check_config.sh $(CC)
 
diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
index ece37212a8a2..549653724661 100644
--- a/tools/testing/selftests/mm/guard-pages.c
+++ b/tools/testing/selftests/mm/guard-pages.c
@@ -18,6 +18,7 @@
 #include <sys/syscall.h>
 #include <sys/uio.h>
 #include <unistd.h>
+#include <linux/pidfd.h>
 
 /*
  * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
@@ -50,11 +51,6 @@ static void handle_fatal(int c)
 	siglongjmp(signal_jmp_buf, c);
 }
 
-static int pidfd_open(pid_t pid, unsigned int flags)
-{
-	return syscall(SYS_pidfd_open, pid, flags);
-}
-
 static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
 				   size_t n, int advice, unsigned int flags)
 {
@@ -370,14 +366,10 @@ TEST_F(guard_pages, multi_vma)
 TEST_F(guard_pages, process_madvise)
 {
 	const unsigned long page_size = self->page_size;
-	pid_t pid = getpid();
-	int pidfd = pidfd_open(pid, 0);
 	char *ptr_region, *ptr1, *ptr2, *ptr3;
 	ssize_t count;
 	struct iovec vec[6];
 
-	ASSERT_NE(pidfd, -1);
-
 	/* Reserve region to map over. */
 	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
 			  MAP_ANON | MAP_PRIVATE, -1, 0);
@@ -425,7 +417,7 @@ TEST_F(guard_pages, process_madvise)
 	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
 
 	/* Now guard in one step. */
-	count = sys_process_madvise(pidfd, vec, 6, MADV_GUARD_INSTALL, 0);
+	count = sys_process_madvise(PIDFD_SELF, vec, 6, MADV_GUARD_INSTALL, 0);
 
 	/* OK we don't have permission to do this, skip. */
 	if (count == -1 && errno == EPERM)
@@ -446,7 +438,7 @@ TEST_F(guard_pages, process_madvise)
 	ASSERT_FALSE(try_read_write_buf(&ptr3[19 * page_size]));
 
 	/* Now do the same with unguard... */
-	count = sys_process_madvise(pidfd, vec, 6, MADV_GUARD_REMOVE, 0);
+	count = sys_process_madvise(PIDFD_SELF, vec, 6, MADV_GUARD_REMOVE, 0);
 
 	/* ...and everything should now succeed. */
 
@@ -463,7 +455,6 @@ TEST_F(guard_pages, process_madvise)
 	ASSERT_EQ(munmap(ptr1, 10 * page_size), 0);
 	ASSERT_EQ(munmap(ptr2, 5 * page_size), 0);
 	ASSERT_EQ(munmap(ptr3, 20 * page_size), 0);
-	close(pidfd);
 }
 
 /* Assert that unmapping ranges does not leave guard markers behind. */
-- 
2.48.1


