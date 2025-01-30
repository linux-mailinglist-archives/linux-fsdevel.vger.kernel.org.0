Return-Path: <linux-fsdevel+bounces-40431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A314A2352C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785E73A5E41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EA31F1525;
	Thu, 30 Jan 2025 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kno1W/kX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PGT6hfds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A11F0E51;
	Thu, 30 Jan 2025 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269577; cv=fail; b=cODcCQH0evlrFHAM7WmDmWMYIGuf425sqYcFk4D4nusMIqZwzXYRx3eqQMBBVOjMUGUfp6twe3+QtQ/cabJllsS63QAts5orXfC5DAGEheVzVwa39Dxu4RyPrOviJBCPVECLRHNOxbPXaqu9//Y+nZOzWB4Le7J33tc3ygLs8hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269577; c=relaxed/simple;
	bh=VoBcjImK56VNV9hLar+Oko9Gb0xfGp15UbAdNT4r3pA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ZggL9ssglqKvgkj4Us9bUMdOmovMhM5dp7xfGPt0ZGGvbaG25D8j7nMs5vHzqobaAfmYZLlOQqEjz0DdrTJalTW1uzjxsGrYdTdsf00RHrZ0c4Dqf+04YgPHvil4bCU0+hKKZsDQniLHum0DPyLokSJqLOMPX9Q9KCxhdm5//fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kno1W/kX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PGT6hfds; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJsCv0025001;
	Thu, 30 Jan 2025 20:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ov9AQM9fsFOTPjyDel
	VuWtUdRC2WcQXrHwJjUeGqEIE=; b=Kno1W/kXKvkUg+fxjw+Z2h/k2vqrVLkW5E
	9pTal4v7NBXwqdQkGkWv6paSLmKcA0EsmIHNdut5QxpPZrjvGcAXTrBZWeythQdV
	QN/78eJAylevTCZHZ8aPhj1gR1Rxbdea4zgvWlXkFT8fisFYbK/UTawDPe+H5mgA
	e919P/oG6gMSuMopjas/Lhzu2AIzgeGVGV02k6gHfzgb+VbOuGJJT3cJUuoJbswl
	y/yJon32t/pyzBKFrfPXCH59gCjPz/pPNQIe0H7KgiRUlNC4NkErGLK8CZATovtq
	CRs2JMsJwUfUq1Pgr/9nkiL2S5RvwWuAcCZUopGWTbzYYbKCQ4sA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gg0382nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:39:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJFZt1004173;
	Thu, 30 Jan 2025 20:39:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44gfe43gp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxrQBXMmyObANBNZ64mCW7bJk68+LF0ymplAymWrE9VFFJyP/g62PvvRpBTFNUpLWTeSl7kL/TTZYNoAOo7g858zQpVeqBwlGB+R0oEHaoNuL6vAFO13+8bu8fhgOOzNk8F7lyY2/cQzFN7dHV7by0nW2hxx7FR5GSqgmNmPKSBxZGYgRhjpSlCwC5/KleIgC6GwP1DFkGaz1Ft8AKVnbnw2bOvdqH4bRh+ML91tdvowftobtoinoIPq1T9oBGykjLuDjfq0WwYY5JZNI+jSScIkpEYfC8Cmkjt6XsDqBS1QuwEkZ8iMrinIaNMmpAiJFwDOgrDQNqOclWxlj+dRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov9AQM9fsFOTPjyDelVuWtUdRC2WcQXrHwJjUeGqEIE=;
 b=TS+GFd9sedwOMgVy8sNKSL54L/YoYW5+WV1LSNz6knEz3e3YE//PBl9Tt163nSqsUblcBjoyBIA7WHKGB/Etz9IYq6SuKW8vz3R4zCkCUvSv4UZBdspGMa+UyKvgalxyUdWldE93WFGxLetCtTYDHq/l6Da0esRJe6FAnOC84rTRv5gRMIa+K2Gj9BmZt9zHzmMPqatL5ARTuA8IBOjDz1btoSv0bsvBHXapog7sBKwcUv9yDKn99AkJ+Z5U5VQL3iUXubiZf1um4sYfgzAeQ0Vix6ChScwhZ7fsjmoUOB+pEYWEo8b+hpXrmF7ZdUZgEF95x/TA2fGXi6b85f/LtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov9AQM9fsFOTPjyDelVuWtUdRC2WcQXrHwJjUeGqEIE=;
 b=PGT6hfdsZVb93vSOVGsZj9n4lnJiAdLqz0y3Y+E/uvQ88YNnnwd6FMh0BDCm/c69TIDVk5FKRASc5JdJrSuWlq0Lm+E0Fyd/BzlLde/+yPWDh5a+AsIJaN03J545tXS9OA8XgTNVh3WKuWMmlJFjx/kFLMnmUCyanyYFMcYWvWU=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS0PR10MB7397.namprd10.prod.outlook.com (2603:10b6:8:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 20:39:21 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.020; Thu, 30 Jan 2025
 20:39:21 +0000
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] File system checksum offload
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250130142857.GB401886@mit.edu> (Theodore Ts'o's message of
	"Thu, 30 Jan 2025 06:28:57 -0800")
Organization: Oracle Corporation
Message-ID: <yq1r04knj7a.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
	<20250130091545.66573-1-joshi.k@samsung.com>
	<20250130142857.GB401886@mit.edu>
Date: Thu, 30 Jan 2025 15:39:20 -0500
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0063.namprd20.prod.outlook.com
 (2603:10b6:208:235::32) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS0PR10MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: ea86959b-02b6-4e1e-3191-08dd416e2d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VohSG2UaJUm2Q+3hOqAQzbKxW6wV3hi8nkZBmOU9pmf8NV7d+aZQ8BcC9oaa?=
 =?us-ascii?Q?vsFscH5TtqH/IkY61B5rHDGdiln8gcoutGVOOP5mf4F5qdNJ3S8InygDmzEI?=
 =?us-ascii?Q?xlT+9CBpvbDL1RfHXZEecpx5MYy2GssXgh1G3PY+P4WgnJzreKzZpDFIDZdA?=
 =?us-ascii?Q?feGHq26ugZL9CLanURlRc1PMf90xs7M3LYc0RYUJCqZ9WYFZ2op/RBwrde3R?=
 =?us-ascii?Q?TuDYxgYHqSDPHj2JDf7LsjuHyAc1ZI1XNBELH0Meh5niGYI59SKRyVYxs4Ry?=
 =?us-ascii?Q?sXEmyJVfEi6PJAZLwXMjqJ25CVtroOBrBOVdPsjjkEAy24BxoJ9hP1ijgk5t?=
 =?us-ascii?Q?3ddczvo7tTqmsDF2qxDnUcFATH6ot7YcKYrzqGd9nnL47X4LwiL2tPTsW+Eb?=
 =?us-ascii?Q?seEUeMbC3lbJ9xLqgmWvK+hziSdAA1B5+amvvpoeh6aHsPbk79eXzslkvcmE?=
 =?us-ascii?Q?TsKzlkGOd4mAd6yL5PPK7PfHK1D0CmidOR5LGODV1/gEdofr5ib3un9+9cx+?=
 =?us-ascii?Q?UIWVjdXF47LuWT+nXAZiWBrIrjBOKo0fgJYGJ5WTusuGi0liNoBZkzNNDXY9?=
 =?us-ascii?Q?HgGuPbaOe+VMravpYm3EvOMk4ClJXqY/4I6vO157QKRBF6m7i1nA8KtxZJG/?=
 =?us-ascii?Q?ghCPGnTKbF0/1qHBLTukQs09Kf6W7zII9VbtMB+fZEco2blqWWyK6RsdlJAA?=
 =?us-ascii?Q?AvhxHijBjMzlMl3MEGuzsOgJVoe0M47KngEJlgB9pNdvFXcRbRXkF5iJ0pU2?=
 =?us-ascii?Q?nctDDzxlpu7Ivk2VDW1MCPspQ8NolvE7EbtLSbatUkWVabqbgJ/C49BF/1D2?=
 =?us-ascii?Q?zbgVlnTTP/fygjF9OPAtrBHE8ESuaW+BGf9v2IDoNjXBRaQnz562NpTodvRL?=
 =?us-ascii?Q?JqQqoJfP5tOpy4uwbbl32WfTB7u3hwNF12okFYoPOD2YPtFyweTmaDyZu8NA?=
 =?us-ascii?Q?4gbaMb1osP3S2kGiuxNMK1PL6K2QLOfletOVujQXU+1r0VS+xOA5Wu/7DyFy?=
 =?us-ascii?Q?aF6ZjiR00TlTmrHdnzePY5rWKbPW59JJNPeQaIWYs3QpoybVL+K1MD1EN2l8?=
 =?us-ascii?Q?cE/EiwDl9mINN7xPphj86q9tWaPJ/i2ZuNthTtpoRitxfvE2FAMzq82QGtCL?=
 =?us-ascii?Q?FFvYcIy6xmRF44h4u/Dpht+xoaH3336SQ8JRQEn8D6is7VPJ0gZWAT2LkEOW?=
 =?us-ascii?Q?TFNs79IuzkVce3KOi/uTfygVm1C45TKk5RKsQq3m04B4W0gEWV7WOnwtHTKg?=
 =?us-ascii?Q?j/isXZyHH5SxFBOYlbuIRT+0ja9Z1temzapA3+8TmV7evtI4niNmAja7xRFG?=
 =?us-ascii?Q?F1GECDmOIsoTKRX3I9AzIA3AeMQELJVpk5HpZmO0nTlNsD3Kr5oHElTDNowg?=
 =?us-ascii?Q?mgon4QGxazGSqyxwaqZqLcPD+dxe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VO6DairVHRXTfZ3B5Newq9zoE/IUrqJmflgaI6ys4BE2B1eqxxisH02jnyP1?=
 =?us-ascii?Q?c5AEYUj8EDdwkZN9gNzjn8ewlAvkG4QR77yDPLlB200B+erTcMOcWk54/jqD?=
 =?us-ascii?Q?oduGKSYYgXe2P2EBf8y9DKyH+TG9lIunuaG7fFk1Z3z+pXB3SMzIIzYW5IBP?=
 =?us-ascii?Q?89hb9r1ZZvpvMZ4yinF2N6+0Nr2CuArISkwL3zlKTSOCynqxMCead//Q0+6/?=
 =?us-ascii?Q?dc8/SxCNQV7Eey3U3OZUU3H77uaIeprh/sAiPnWuqvCR/IHReB1SO4ODolcm?=
 =?us-ascii?Q?c2nHWPJILTpPuWxh3W8EnvaA92CtaajXAOiOhmrPtG315EafrwXpTmrkZVkP?=
 =?us-ascii?Q?mIsf/qRlc1jIMhpjMvKAipOrn3HB/RRyIcr+Jt8xQkEYD3aB5TXNKC27Gtao?=
 =?us-ascii?Q?SjDeMg9A/1z6gMv37pC4V/uM/25rWzVXGuRS/Muz935yImMFNmc/AqLVLYrp?=
 =?us-ascii?Q?bvg7KnWrhSbz3RHrzmptvkoRN/j6M2DeIqW1WceHZeEerkjXO8mcIJ/pWqG+?=
 =?us-ascii?Q?/XzNQCANNweAMlR2Szc6qMJTYuntm0VDQtv4YDJnO7t4HKGopmAC/GYywyeX?=
 =?us-ascii?Q?QfwXsNCWQLdRhPXBN/doaNyhWrurdmucHHb8B89Bme1pctMNq3F1PBVewGt3?=
 =?us-ascii?Q?YCOovNNZscH6+wSm7YvTkmfxOXEUyhA1sCOP18+1mZa8mxIm0FGNb0qXSmB0?=
 =?us-ascii?Q?zw1JooQ1V0Z7I3b/cXC87QjOnC/V6LkrEIoD6lxN/qJ8951xSN2RGod9gG7k?=
 =?us-ascii?Q?mE+alem9cPrFUzCBoHPxaMT7Cb9RazqxEO9FQd6rRLZfo/MSxyVFbyNfy4lx?=
 =?us-ascii?Q?Yv0jauALDhrFgBeZrQgulsmRDJRmV0zTDiL1WSXJS+01NdEnP9rO0L0ULogO?=
 =?us-ascii?Q?gQOHHPOeOSvCpKt1n/H1NBHXZbtgNYs7J/ojxLWjhD7LbyVQcbjAodbfX3SG?=
 =?us-ascii?Q?CyGD3GoTWXHUwyVXVYIU9JFf0PCCh3E7qO+vI3kNijl7wNaUedEExyKfehtz?=
 =?us-ascii?Q?EH+U6BPYKNdn6XBUbaRKOTRWj4nELTGRjK4lSa+v1uPhXt6m/L8otBQxPMhP?=
 =?us-ascii?Q?aMsAXA17vH3dz11YgXGPcmttmOvF24X05JUymeeVExfNSgIAy4JAdnUZJiMf?=
 =?us-ascii?Q?t2hZLB+0uXzB83683S82ac1bwgPai5tLp6pP47YZKp92513IiPByap481a9m?=
 =?us-ascii?Q?ql2tfgzeVOphCXBb5BpOiIG7YzGLixoFDpkj5crUK++KOeh5BXTibQVU/lNR?=
 =?us-ascii?Q?7OK6ANcKrAAynn5LPV5p+9i9GwnjcY57NnksqgT+qPdy4r8PrYbVGe3Texd9?=
 =?us-ascii?Q?JeMRar2lRmDETKyePbvplA1W4rE7Sx3+siIAGsBZ+4UmYfhC4hy0gCzBEQNE?=
 =?us-ascii?Q?XinpG+uKrsIY/hkalh//PKNfcgmcegApeWjDIvi+dPZAAUW/V5ZciwbMpeRT?=
 =?us-ascii?Q?w4Yhwe7TUy1y3ajcwQBHtbWQ7X3AREjHMYXtdX0+DeJHpXlKQsUTsRGw+r5f?=
 =?us-ascii?Q?vOBwA7rT0XG3BTBcc5Dxz1Ewyh0s/0QG7JM1pKpCunqDfgpTEEEveB051JIy?=
 =?us-ascii?Q?aDQbQ11bM8KQNmBwyPyOFc+XMwsrrFlX3oZx+b9l6BFM2R81Q454UmW8G5R7?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JIZXfPqfghs0nPCwa//iB7Wl84mFc0jtuc144J5X8hM2fPv/Vt8rkAAyq23jPw9y7KRvE8E4sXckZvirrKWl2T2uc5/f1WvF+n+pKRTfWp5CeTJdZVvjqRusIusR1cltxxb5Jc9XgAZJbrtBHpsYNgb0AARnPFe3XcXeIMQ0jwxjJqBA+STn1l6MR1u/KoWaxejyxRPf/8/MZI/jETIFZ3/t0XQxMYui/d++TWyonteK0kPq6KBoTYMPs6zZBr7X0yx6yyfQ8u26RuDG0WtNIotWluuP9t7E9mZ13qvAZMFaHCqvkgeDOkN7irYYTFg7lnu6UPUM6F+JWTSSwlJ4CMC0PAOX2Lnpjcp0tuj4XzAnp2TkXbQWKQNsBaXNS5/uHx5fUgjZeRwKvRSTIYk7rgrjJ09Gt6WzMFbPIlBpBLEKUaEKAxR5ZndbUAdbnPvBwFgRP8/cUqKCJ+0lvItulv/J7KgGxFYMAQ8xrlSXsEegS/3X1pfT1EoC0TWasJM7/zjj66BJaAVxTcCesmn2z54uv1cIJP6AXK3gTlOJgRq9OhHns3oCUuvnYHhlRTQ5dctOXJvk3LhPYY7PG+sz8pGclU4/hmLdLZ6AQoM3fLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea86959b-02b6-4e1e-3191-08dd416e2d26
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:39:21.7330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8YVTkYlWR6z3ZV5zAz1RWVTkXX/z8ljf8/hH/rDVnsKG5GbThQFfoXZt2QdJk2ph3w6Eh/IbbTRR4USNvKN6FbZ0Vg2TP6GfdfyKdKWxgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=792 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501300158
X-Proofpoint-ORIG-GUID: h9oYH8ehFryDNTDcW5lq0VyeBay7VmTA
X-Proofpoint-GUID: h9oYH8ehFryDNTDcW5lq0VyeBay7VmTA


Ted,

> It's true that relative to not doing checksumming at all, it it's not
> "free". The CPU has to calculate the checksum, so there are power,
> CPU, and memory bandwidth costs. I'd still tend to lean towards
> defaulting it to on, so that the user doesn't need do anything special
> if they have hardware is capable of supporting the data integrity
> feature.

It already works that way. If a device advertises being
integrity-capable, the block layer will automatically generate
protection information on write and verify received protection
information on read. Leveraging hardware-accelerated CRC calculation if
the CPU is capable (PCLMULQDQ, etc.).

-- 
Martin K. Petersen	Oracle Linux Engineering

