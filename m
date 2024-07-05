Return-Path: <linux-fsdevel+bounces-23213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032DA928C2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAEF286A28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43416D31C;
	Fri,  5 Jul 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="db4lhmxf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RKyTLdZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24FE535C8;
	Fri,  5 Jul 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196724; cv=fail; b=M1xaEgrTQAwZRfw7MFFviRGKK8y64K/5y5pxCLpYONYHz2Njthffx6S3vBwERdSXmnrbre3rJ1hOqSNQ+gqRMEAu5YBf9yzUW35HYnmuC68L1yRHkQ0Wht7Mb1m+PxYkv1uVoNKBXDyKNvvmQHpmkVdp5iqRXPrlsRTvdKU9WRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196724; c=relaxed/simple;
	bh=BIhb1tlAXe3dGMNw2fb2g0+Bm6xfJhg+kgSzMouCfQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2W/1TCDuH1MfBkqNEtBtw0iGTZdopUVsMF9F2MZOi9H4YDRTk1qoIDzu1U4Uk1QyGg0FebChXw2B82vC0NToE7540FxaOHHDhx1C/YUdruMPJMpM7pUa8q0FGiIirai/UmRe24UhbhomkM+7lgvceu8n/73T19ROFohZKqMGhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=db4lhmxf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RKyTLdZQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMVpv008309;
	Fri, 5 Jul 2024 16:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=LUyyuu3eE74t0vP7mPsxmZ84L4y5F8i5c53pdB99H2U=; b=
	db4lhmxf1Pw7/F0Wbcq+aq1r473tPak4roT29doQmWyM0L+DoUOu5Mntzq/fd8Am
	FLHwMryjQJ8dCaG814n7jy3BecqV1YAEsyLhzlv6k0ao2Q9c5CLFYE5SNqKpEvrM
	0i6ubIzp5sw1VXnCMbzfbR9/xAad7RlmhGYA3v7bxIqAZNMjV9nzy58B/F/1BtVd
	yGYnIGazws+ssody/EvlM+9sAk4aps45uUn1rGY0MVWVFFT0uKS9EaN3ctoPAKZ6
	Zw+vyag842F/WJ65tsKFaFtgj8/W5rADZUPZT1q5VSqYUT+bFgw96mQnpvIyvTbB
	Ln/fU7bQK5ujyaxRFi+yKg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40292347kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465FUrPJ010327;
	Fri, 5 Jul 2024 16:25:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhwsmh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo8xfAuu+MaSsNwFuUhiVCqbGYwbCWZfiF9mFDJArD8nNeKewimp0CfXnu06KfdniYYhW1Oi+YCSQYUlSCa67hRChz6Ue3jvhXW2i3fjqASULY7DyOz6aybiavLpmfAWSUZYWzXGMdBOoQaCot08JzmeO1PeaG4UpIbpdjAXv9MP/yjW7ALTmgClSbbwx+Gx5bM7+cKRogL4iMrld8KKd8IF8gtgril48jCGLrmyDUS36y1n+L6oT8lkQLWpaTRvU5fPJYcLr/1AU85eLs0tCHGurYN9jii1cIlLHjsNNsHCl3Hvmxe/rRYjMiGo6eYKp7fBpaW402BwXuEk3is9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUyyuu3eE74t0vP7mPsxmZ84L4y5F8i5c53pdB99H2U=;
 b=VXSkrWou8esX7fweXk4tlkoJefaDJWz2N+D+iJ1+CcSvj9jyMy45B4bwcBUARkpEXVrjkA6yPP3DBBp1RdxOVR9+2lSBLvAP14PuROaQMT1e7YmmKgnEBMJVdU33F6goppIGewfFBGDemJF/4GVFMc/T6qEjT5ZcgbvLITrpD5HVvldZ6z0cmQTrCxKSiS0UmS0iG8XULP7j6ZcWun2YhBguga1jNcmGBmJN7M7jlUXbh/0WppthjJszQk/bEv86zw7c5rWfPHJ+v7b8NWVLpiYxR9Ezuyewjr4R0AM6SKnqdzMhY95CFQKEnC9TAzpP9VU048qKpZD6kFDKUVMutw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUyyuu3eE74t0vP7mPsxmZ84L4y5F8i5c53pdB99H2U=;
 b=RKyTLdZQfLbQzv0qR5YpoSpAIapk+9Ql0DaqGlS30v7w0XH5xGQiX4qan1AgPnDvAFuKOpJr0eBjgWsDSMNuAwwVmFiD3VfHonQWoCvF6vdM112UvVKTgiIxi75Gbhn45MxHVff3oN96Wr5NjHR76cNTwPEr9B2pbRUfTTjyO6A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 16:25:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 01/13] xfs: only allow minlen allocations when near ENOSPC
Date: Fri,  5 Jul 2024 16:24:38 +0000
Message-Id: <20240705162450.3481169-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0009.namprd15.prod.outlook.com
 (2603:10b6:207:17::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbe74f1-9d21-48e9-efc8-08dc9d0f0a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?G9syCrLOgxMd5GoJCG2MrEXaUWjaw65Px3blHS3kHJmYVhHagGwlEkKDOYET?=
 =?us-ascii?Q?uNNCgw2zi1UZC5XG5JhCliDvUi12Kw7qP7sKYUhN+/TVf6zYi4tkOfaQ5dTl?=
 =?us-ascii?Q?AXZ5JytWxforJD/Vkk3UxcChi4BaEaUU6KrHZQc6nElQSnuk8eWTbQCC+Gl9?=
 =?us-ascii?Q?CT3B5UoCuZ6oHgzZ5Mx/IK7cJNAHiDtL1G0/6WWNNhviH1jZPL2/YaSSKQCU?=
 =?us-ascii?Q?pNtkXiDsc2TFxYgGN1HlPJVxzOyUdfVYzWGXFFa0bkV6fGZlZNCz3t+CllMt?=
 =?us-ascii?Q?t6mYn4d0a40HCDZ7quFQbl3z9q2j+mesjVZ1xPUvQLwMu9W4Et94x4pUktWi?=
 =?us-ascii?Q?n8Q+qo6vIb3Giag19jJO3yEjWEhOBZbZ/FuCeA2fvwXkLIN7YwvnrJ05BzVU?=
 =?us-ascii?Q?d7e5aP3vy1iWSPlKiIsjTMfBj5mG4g1X4Oik5PsmaeTApIWM7IBudsCmyAX/?=
 =?us-ascii?Q?CmEnigI9q7atjtAmNNyBPzuomhcykTgRP5y/Qdu3iZXR5u5M666cxaRURxDc?=
 =?us-ascii?Q?hRiuGQu7iLpJyUioMAQlBBL2Ap7a6VoAACNcQCw63hiIN/NfRltavuA4fwba?=
 =?us-ascii?Q?txmkF/PNkF09OzFVn1+cbsQPW6kBHJYsrOGI8w0u4KNIwGcsPYUYitGAI3Mx?=
 =?us-ascii?Q?0QxAV6OLin5qxkLjCGFDAZCZQ9kC9aYUoqrC92m6l5/X8B1mEMLg/xPhWboC?=
 =?us-ascii?Q?nFLF80MdXvwG0XX11CBUk13QH8tg9BYnJNv9QLIs/jqPgyRra9ukl1eJDcSO?=
 =?us-ascii?Q?j6HFC7+kqsZE8vxmO/bi7EM41H6XZQLmNORK0vrJ1BLbLYqWfxTlDdU/H5sm?=
 =?us-ascii?Q?EK4VEyjcemtXrGsqdbBHjVGGHRhfWsy5WFRByl8jACBAJTrouoXWBlqAxAIm?=
 =?us-ascii?Q?xQvMTSEvhwPFe0pIJ8PYDK/Op4UjM5j0Io82CYnVm7XQjaAqLdBQIh7F6DXo?=
 =?us-ascii?Q?vjyZ1mwJn/G2ge7T2JgHAQmpA0zcPpR/gd32WRQU0SdZ+CgDcHCI4nOFddvD?=
 =?us-ascii?Q?pvZDk1ubBM77jWQwZd//nt5Z29No7axMBEb0JBWckOE7Lm+vMnw8jQH6lLHw?=
 =?us-ascii?Q?2zKyHQjKOB4tz6ONsqFUaL/ScXAUI7rFGlVn7JnG6PMlh4AVMT+6mBXchOH3?=
 =?us-ascii?Q?m7em2LkHewyrHeSUBY2ovjntV5Q8o1jExd/LFVFKm9WwiJcA3oJ7uYNBkCa/?=
 =?us-ascii?Q?LDlBX57xEapivANxPZVtsMamRuqkYG3mzWxQmAqTAmu22w3E4kjMSfw4syUh?=
 =?us-ascii?Q?zaZ62r1SFCpnhqgW+7ne1h+RlgHQUGbloPIgcVmyBAEQnelYAz/00S3nmWV2?=
 =?us-ascii?Q?sbwLix3RZ7bx/jsKAmrmPI6BXBOPFldXyhI/I1RkWhAViw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tPYjjobDayw56KEUWgHVfd7WLAtW4prQNpeT5zItcgWE2QHoiLgMqXbz0t47?=
 =?us-ascii?Q?majsF579ZLHcHGc9kN6KJQOvJr18CSdJmWw1SAdFke8oX2aJc+YJcwwWO23s?=
 =?us-ascii?Q?aTFcBTM12GXOvATDJv3fG+jC0oEOlLUlhEYWoXuO0JeS222PZe9GQcEr/uWK?=
 =?us-ascii?Q?vRt/kONS6pfKeArD/1e+XZavKxWic7PiEwovdi+xA+N98Rgb/zQVcwmaVKGH?=
 =?us-ascii?Q?ezSOix6Qujl1dOynK8Ol4TmfNZnDW2pyepA+wP1GfhWdMxV0K7kli6HtA5d6?=
 =?us-ascii?Q?EUnH1zPaMAo0+Bqg4ffDJMiIhA87aUBpgkCsKJrYIKN1MUPUOxuYn4AUrmAp?=
 =?us-ascii?Q?Rkky8z/R+YEQ+vImAOGvIRuXUxcadkH6VvYGHdQEbSYuV8feo8uKxrjdpEEK?=
 =?us-ascii?Q?cLY6VF8Zhc/VrFEBi4hg7XW6jmbevvrQcOuwLdvAfqd6LSRRgUivwBdmz3n3?=
 =?us-ascii?Q?ZgzAl0nhpLy6ashNhfb2t8mmX3ZaPzulLwrLbltXxFA7rZ7jn2KaNWe9iXmb?=
 =?us-ascii?Q?oHgGn9KfqxPNwRON/KBd+ggtdpfrJBq01DrFSFZ33i1zIPr/e0qNLawxogh7?=
 =?us-ascii?Q?9AutBba9BdPV6I/lpyj7gWZp2EvwnQGh2JbAiWauDXEiMQbd/RfG5dX5+iGr?=
 =?us-ascii?Q?RbynZqETe0oU4X//FpLvxmVpTo7QslxNSNRAw/UdQpuYqn1Fmvu2Re2B2/W2?=
 =?us-ascii?Q?5HwANeMkPGjpoB4Eo9neJzI0DTyO/ZUywHWXE9fiQ8fMCH/qil5FbACZJYeF?=
 =?us-ascii?Q?CfHKrUKsYT0wcpn3kdD96NjU2pndDj0h8+gKg0hz1Af+DcSX7CD6uJqMqcsT?=
 =?us-ascii?Q?eYPWq0UDyCjxVwsUDpkSfwo2ivi4VeiWkfxD6MMCaSgL+rg7Sx0pAJBsc+rj?=
 =?us-ascii?Q?at2V4vSfwcuiX6qSgJKn9S3mpQFm8bpYhHe3LOjp56v7euS8w3gsoWr9SEOj?=
 =?us-ascii?Q?Sbm1QXp2R8+M2VOSFs7fUfTWMIqwjKJ1Edr+OCNWmeYQsZA9ulciht2tBqPV?=
 =?us-ascii?Q?R++2qoydeM3RHRaqQJjLbjIx0lcNjo0qz0pCgvlskzWZWqxYQ/MDwfQdqrKb?=
 =?us-ascii?Q?mQvd1IfUf2ii2AwxwZhDuAY73ivQuYJ7YY/+m0RDDLEao5ZRujcU3omB+csN?=
 =?us-ascii?Q?TleLlVb4Dc2KPGXTRsH081n9XgYjARxG73BBMWG+ZxXNWY7xg2r17ZTH0/3z?=
 =?us-ascii?Q?D2+Ty/YgT5xN2coyRknp5MzswKKRqWNQdgURvVvKQDVRvb4QNtyd0tYp7qQc?=
 =?us-ascii?Q?rpmWDQQs3hFxCoHVjjZbteXvp8VsOeDsiGgBT1uzXf5UfQYTuLFfgdhnNV5n?=
 =?us-ascii?Q?mi8BW55WputCV7ZVYDCQl/NTCnOK8+5Ess22CfrODS6Hnub9vMJ3usfLYb/m?=
 =?us-ascii?Q?5ancnRoNrLwMv4n2mN4nSkPA454gNEyJN4DTMHdaLKIEMlmd/VOPxIrSZB+A?=
 =?us-ascii?Q?R7ua1S4YbAyRWwNIuw3lA4N9HSgdQsYS7x8LD8SSPkPXXpL/KjYLpb7swzWJ?=
 =?us-ascii?Q?UKiJdQnqwOGC7/fjaCJ+QuE+W9a0DoZhxEjbG4bQQtv/iQj7L/aG2NgzwbYB?=
 =?us-ascii?Q?rkzD0pWbcxAzz2Z1ecyYRxCfDRDvbUEwe3wNInsjQS8yrL5sOGU/c9C3opwG?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zKw9Q08BcBvHHd0CLbxtRzH3Fag+a94+FH8ID3M9C/JsZanO7te8mXql9k9zXI8PiFMvqbnOU84jWu4kKAdfrbCVyDoOsJulQEFeNJ4YVPpnESuf8AHncGcYK/Nl8fsY4f5fIY5sZFfAS/bR7PKU8pvKQGfOkiE/ho8cyat9qpvWn+ZtjoCHxFKA8xJ6sgLgP9vhFimmx1F+4ciayEhwmeYbUK0e286T8O0OZm9Q4EPeppfvUGjaRioNhNaKOLAI1e3Px6igpNTi4RkMFT7BmS6LKa5w4qilI1mgC3snK5izx67/nWH2rlaQNh7xl8h2tRcLe1KuMJ4l/0vqIqOiWKLLJUgc10zk8g9cN/T0DespIVJYgblFwTmInPc0f4oY6H/wp/x8jFTMu6DChceA5SBjPxnkCGLRD5RKiQTSo4XuEbZATrGSrsGdItTNoY4YOnGJdM1DXdqL+hi78+n7b2Johy9iSf4sLDIUSGjmPqUxeRljA/pspr0+KMNyOrUeFOmyXVoWTZqe2IEFch7VCBw3XxX+shz7EsRdcQDlYz5Qeno+/TnXOkfGl/ZfX5I9ayV18MeKQ1Mw6YjYICMLRVBswotwjxObkBNELshtyk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbe74f1-9d21-48e9-efc8-08dc9d0f0a36
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:10.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re/x9jVT8qBfDyMuCtardUIes8vl8lituep/+F5ADzIUCpZGh8NlCDlJDyXXQXf8p9vyT2jgvV6XnI5BY9FaCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050119
X-Proofpoint-GUID: aMCqidP7umkMoZwc2KOgZ8omK0-TOx7P
X-Proofpoint-ORIG-GUID: aMCqidP7umkMoZwc2KOgZ8omK0-TOx7P

From: Dave Chinner <dchinner@redhat.com>

When we are near ENOSPC and don't have enough free
space for an args->maxlen allocation, xfs_alloc_space_available()
will trim args->maxlen to equal the available space. However, this
function has only checked that there is enough contiguous free space
for an aligned args->minlen allocation to succeed. Hence there is no
guarantee that an args->maxlen allocation will succeed, nor that the
available space will allow for correct alignment of an args->maxlen
allocation.

Further, by trimming args->maxlen arbitrarily, it breaks an
assumption made in xfs_alloc_fix_len() that if the caller wants
aligned allocation, then args->maxlen will be set to an aligned
value. It then skips the tail alignment and so we end up with
extents that aren't aligned to extent size hint boundaries as we
approach ENOSPC.

To avoid this problem, don't reduce args->maxlen by some random,
arbitrary amount. If args->maxlen is too large for the available
space, reduce the allocation to a minlen allocation as we know we
have contiguous free space available for this to succeed and always
be correctly aligned.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 63315ddc46c6..74f0a3656458 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2409,14 +2409,23 @@ xfs_alloc_space_available(
 	if (available < (int)max(args->total, alloc_len))
 		return false;
 
+	if (flags & XFS_ALLOC_FLAG_CHECK)
+		return true;
+
 	/*
-	 * Clamp maxlen to the amount of free space available for the actual
-	 * extent allocation.
+	 * If we can't do a maxlen allocation, then we must reduce the size of
+	 * the allocation to match the available free space. We know how big
+	 * the largest contiguous free space we can allocate is, so that's our
+	 * upper bound. However, we don't exaclty know what alignment/size
+	 * constraints have been placed on the allocation, so we can't
+	 * arbitrarily select some new max size. Hence make this a minlen
+	 * allocation as we know that will definitely succeed and match the
+	 * callers alignment constraints.
 	 */
-	if (available < (int)args->maxlen && !(flags & XFS_ALLOC_FLAG_CHECK)) {
-		args->maxlen = available;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	if (longest < alloc_len) {
+		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
-		ASSERT(args->maxlen >= args->minlen);
 	}
 
 	return true;
-- 
2.31.1


