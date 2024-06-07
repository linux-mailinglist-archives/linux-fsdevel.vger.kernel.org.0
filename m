Return-Path: <linux-fsdevel+bounces-21217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53675900723
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F1D1C212C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2E419DF5E;
	Fri,  7 Jun 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQIl9E0F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QObWQ5Qo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF519CCFD;
	Fri,  7 Jun 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771250; cv=fail; b=ssfaA1SYRHoUdduM7AAgp4cyHZjtCDJqleKKVc9hC6kOuT2oKahq3gmL+sgsgamSbtNCmMpWksApPBKs89C0I9+/Rvq/VOtFdC+IO+JkX0C/sY7vBuHKaCgunij1vaa4aRkGwBvh/UnIy3/XENmXNMkPt7NNEg9/Lm8VlSg+3bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771250; c=relaxed/simple;
	bh=m0Pu/o6HECWK0/bEFx8HaREpyge4j3F+Y30F/rOuJjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/aaisu1anGZQAMBXPoAEpUjQEgt5v2xtv8CQMWCmMekmdIpwe592pWPBUc8dr+jJ5aWP5/f9miPsUoRgmRS2SntxbkhU0lqfc7LOtrtmLNBHR3xhire8KlxJC9xL+BeMyRzNhq1M5zSRntAaS0LY2+iIBMbroWinM/JhFsC9eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AQIl9E0F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QObWQ5Qo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuVga025459;
	Fri, 7 Jun 2024 14:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=zjAolXoeDvQncTK+o6XqnPEpMhqpgTy94IuzWeexJRk=;
 b=AQIl9E0Fc1r8ArIwb/ZCUwu+J6+zw4OZ4qwEjhkc27UXJp4QBIN0tk6hRrKOT2naCrgy
 TDYHOHUO4iKzdm2ZyL0j/d+2CoUpsQD3y5t+VeUTDSguN9K7TpV03QxYJn+J2sR8OZ6y
 IcrREmo87MLHz3TO6i3Xikkce/l/2g0bgerb/kxkKmp57yOtL2wHvKNNTQMPcUKDKek0
 KllVkgH52m+xlNPiuJVqPIYlKXvuyvXDymvaBxcQ3sHydSzA45M4MJbMxuQnLnNZowP/
 IKq2AHyZIqRV3KRF9OsqH+CqpnHkn4VxO+eiCR/CibfTyXXOX+0d4F0Bsll5Zj9MrMYG PA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ykrtb13dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457EAl4x015605;
	Fri, 7 Jun 2024 14:40:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjgqme8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf2IEXAyOgli8xPPVYxqGxW5nA7+SNTog5JXN+v3pbGzyI3QcB/bcZCbx8XudkOYfpxl0HvmZBVeckG/zFhuk7nyO8BFlT3P5NBNq4ZW+FdvjODECAZW3T9UI9JYKy3AryXg029A04kFYSM/piXAfYevZZA4pZJ5aIO+y8Ta+0UZNT3pXkyOFvpEJJkZSPx30t+t1mQWw4DD3JqsSOH9NE+jtYE45S9q39DKj4jvRhIZ0PANFX3XmhhP8s0iwK8CV/+piFtjDt/PRO9kIEU0PP4QvQL4QshGFb71EUDWE/8Fojpjxiv3sVm2basxkzxQwaj5OG6UD22v1EiY+szAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjAolXoeDvQncTK+o6XqnPEpMhqpgTy94IuzWeexJRk=;
 b=MrVJWv7CpdH1tbTkUZTaa4f7iAXg4+7OXm8Z9KA/pG6qq5Gql2v51QDLqqN3zjlyH9uIa1tEH91YladUyqmZKv8SRfJmeX849Uu9desWI2V9mHAMDwNYmKn4JaMvb+xGE65vnwV+B/VmkD1F7rWNo/EM7TYhhn5TPpS9IrwaFifc9oG5imaWBQQ4uuJIGzGROucXRAZQoYZkNYSU8Mjq6WVBcwJrmNh3f2edVP0TWIjwbQJLXMXJIW6WWXWW5FSZflVD4qWT+Y8y4qq7eP5QojvcxMAbXXMSDzz7bjaJPND6jAtnqFRQZP+72Y103ZFVZy6+aqKCoHzYDevLpM1zwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjAolXoeDvQncTK+o6XqnPEpMhqpgTy94IuzWeexJRk=;
 b=QObWQ5Qolu/VWu2PsoLjUicEGxlz3SWi9009kRsTx7ngZDFlyE/94zB4hfKqkVG6QjahxvzVNuXjloTeM0P798t3CDaNRFadPYG5PR3eoF9j5HxcKTN73XGG+gZz//o2uKDTI7PgqR43JDgEZ+/faIFk4AWTtt0XWLVgoTPpAqg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 14:40:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:18 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 10/22] xfs: Introduce FORCEALIGN inode flag
Date: Fri,  7 Jun 2024 14:39:07 +0000
Message-Id: <20240607143919.2622319-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: baaf9f01-69f9-4881-8a72-08dc86ffc080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vd1Sj5xV63jsLaG5Zne0Ant/HrlQQmdb2Bve3dWyCpYCr31LJgwpQ7GbR/Rx?=
 =?us-ascii?Q?W2u+OxJQ22SvkaOauom+3We4UhGtyvLqr7ecnUuG2Lfqu1ClJqIAXSws9jPZ?=
 =?us-ascii?Q?FbCJGmUzFnwWqwCogqdovBevp8aNfWvtzU0D7y4CGeh4sB9VCrdi9M2sTeHa?=
 =?us-ascii?Q?hqaJMsy/0EK/MV935t5vmWQE9DhmZ+5mE2QmyctHy8hVQWA+3xlixkZ5qOPl?=
 =?us-ascii?Q?SCxnKuOv3VsayRxsV8vA6aIN+rlkd+eGIogXqCIDV0fmpbFhUxig3ngTSN8R?=
 =?us-ascii?Q?92qiwz0Rx2LCmpUiugBFwbC7BbcAsgZNspjO++fg6jYzM8Jv78M8Wv1dehcv?=
 =?us-ascii?Q?LzP9xtrj4K487Uv4NVLW5PZhE+R5HRP9mVPv313TuoiuNmcJ6Im1z0tjTm9y?=
 =?us-ascii?Q?F8BeJqwka75M248mPdjNJFT/P5Tz6EvLMclV843x6N1YXIh1rnFbPtPeVqya?=
 =?us-ascii?Q?6rfhUkw98ZFDb1Ve32W9EP/y7yMaSU1Egu/L7SSqyDAUZEDQ7kzVNARuncuj?=
 =?us-ascii?Q?GIqjLAd92PqjIgDitlE48U+lSR/I0J5aG1UrcCB+IxYrKt6q36TRKFOi9P8k?=
 =?us-ascii?Q?2SJblXigZpRs1ks9wXvUEzNmySZH/3H/1YoB3Mis/RMnBHkiOztPFt8RuN2K?=
 =?us-ascii?Q?ZLJ5qcO2oy5j6SHMYrU4LW1qB1P4uONGd+5W561kW4/vcbh29KtCODpufKzy?=
 =?us-ascii?Q?Jj/7pzKu64rZTa4QSs1hGYPxDusvN124OsoiGfCZCttFmKw5ub/K0CQOg5o+?=
 =?us-ascii?Q?fhqBavt6RCSwh2F5huW8o5sfSU0rrauoNYP194C3P+w58jt+QIROeFTu1HN8?=
 =?us-ascii?Q?Jv00BCvJf2JhDzQ6ejlcz57NEJ8HaA8VTY8QL1cioy1560mOEk3LiKouiRgK?=
 =?us-ascii?Q?agJVyWlr7sRffvjvfQIexZ4BUBbpHjb1Af3Np1il+m8t/gnw+eewoeWciat8?=
 =?us-ascii?Q?MgDbG2PFXO/lbgINX1X/90F3ZuNIG17sf+aDa0aj5VFdw+o85pfhRUrJzq6e?=
 =?us-ascii?Q?9lTXi9k5NCgiTvJJ0e5AJMEgn/GFo9q7lpNMh3uZKYVGWyW3yFwtOTrrq8gD?=
 =?us-ascii?Q?xW3RMO0D789CSBCXGhpXULI3WdgOTdOh+O429fws/TM9mZri/DLbzrrKBt5A?=
 =?us-ascii?Q?te/8PF5zGRIcxxDa6Cw0U+zVN4zLSJb2KBDd4Or8Jpce3rzMg2cRIAlaVUL1?=
 =?us-ascii?Q?+l5sKaHfj2BMwHej5m4rcjODc0gBhAGk1kOqjIWnhnZwYwbkERku8oeem2li?=
 =?us-ascii?Q?yTah2ESfjop2ahYu0Q640ZCYRBoRZC1N+yFxHHR6kUcqiLGDxVxfWwgVSylg?=
 =?us-ascii?Q?c7jn0ylN3De/o29hDMTKrHU4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?M1Qm4ZHYpx8Mx9M3sClvthM1sziefZn2dxREohPU3ZtFPlzjHMcnQ1CYj61g?=
 =?us-ascii?Q?MqXHedk2qU0nQazYTXwDQonLORnUYYJIkD1NuAwISEg8oDYH/lC5BDyjq7Av?=
 =?us-ascii?Q?6PeMpDSN+b6dqcEb73Mq1eYj9I5x8GM/9u23yQ49IzWZgE7UCdbkjQQQaUNK?=
 =?us-ascii?Q?dy4AHEReH9lkwB6BS8OI9vrA/XIefWCNatJAWHpnTWpA8MapC6Ucg9NbQYfI?=
 =?us-ascii?Q?ekfziYZwRMrhSTTHL27kumWNpJ04TaDWcL8m9xm8S1txcj4fdGKUtEsLRi3I?=
 =?us-ascii?Q?pwLF0Fo2pHC7UOrMlIAMEOsjK1YbMFffgdqxhNV6Zq3n+K1ZUwNQ3QSvo1Xh?=
 =?us-ascii?Q?AbPZruzrS6TCThKrwNXaCMLs8c/PHZ+WtgjLfoaWn5DVicp30z6QdXFf2AUr?=
 =?us-ascii?Q?bJ16069LLqyqS+jWoPAsyi/z6rjcEDXridI1CrdnyzNwV9K+HR1ugtEykpOa?=
 =?us-ascii?Q?I5TNedW1BeGRwyIf41ah9lZ3yohCYN+rnLlwCXR9QdyyV1lUTjgKvY1eq2D+?=
 =?us-ascii?Q?VtAHZi5p984aTwpblyDglew25uPz89CcNcUMcicV1CgBwwhv2nJGEJbGQvJZ?=
 =?us-ascii?Q?KNQ8BNN1UZzNzLToLjfbVYOAJ14DCdi4QHq9ZaoV4O5h+u9RYQC2Tn4N5KRI?=
 =?us-ascii?Q?h8Nti3mgIfw3UI3OeL2pmu0T+lqfBAwB8U30yfKXnSYFDSSfoMnNZaRleEzT?=
 =?us-ascii?Q?A2YFTt40mPs0wIdUUoFmrKRoCvY3/dOzS5qJEDLYVk5j5n9TIE44J5axhGlE?=
 =?us-ascii?Q?mmAtD1n1EWDjZCpoHju2Ph6u8yaQdoMSR1zvDVeOuD4/FCs75GekgwA1ujrA?=
 =?us-ascii?Q?EUamZQnD+B/NI4WYCDLfI+b19Ul4gfZledcDKpGDY4hhwcRTPDofZyPzS181?=
 =?us-ascii?Q?oSRPdWvCy1BfOu73LYbCioDfOqAWhMIMYqTGDE1QvvXOwW+p1Rz0v9HHUiRi?=
 =?us-ascii?Q?TD4K/q53gdP/Gbj2eXZQdniWrxvmrORdOqydYK0ta1+autdFcqd4WviKMaic?=
 =?us-ascii?Q?bw5zkBwghH+aYHtOv7ARGD18kDx+ogbf+ij8ShKMyRSV6CHTLdvFDUC9NWXk?=
 =?us-ascii?Q?NRuPlRehA1/hSy5mW16UNdzC8J9P+bISd1GnuwhKjjfnK2htiaiAw1T7+ni7?=
 =?us-ascii?Q?sF2CXRb7iY+9o4wUp+HnmPu6mjd/+MGEbVa7HXdcishHK54UKAM3tit0paKQ?=
 =?us-ascii?Q?UXbMEZtR9Q2wynk/qDNoWhEtWdoJNSs8sjjCnXRryJEfKKhmjS+2QDxuIPW3?=
 =?us-ascii?Q?ayA/HvUtJOrC9N0cUyvPZkqBD3QSlJWs1qAlMeGA+f/ZVorf6UE8iW4pF6vE?=
 =?us-ascii?Q?VwtMoTgk3++xdz4tHd41lI6F0LoxBZ/V9KWAVySlzf+Gnc3rnoh2IDcAmJGs?=
 =?us-ascii?Q?K9Ru81CFuNeDNcOSViC2N25PFwJ8L01Ta5TlVcvpXLdrQuGCRw6zk66ZqWi8?=
 =?us-ascii?Q?s6wIgSomL2vrCDZanDzLIkqf8zKOJu+1sMsxFSkWTK6P2PpWt1090Lpxy8h6?=
 =?us-ascii?Q?rI2+DtdGWHxnkdznN9tsNi6u9WEhc1lKzy598a7SzY5BR/k85bSS3tK9jXDg?=
 =?us-ascii?Q?4GmDeuz7YRDJOjV+rq/wlySMYJEGlrT0yHHBlC01ckSr45Nsjsa98efIX63v?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p64vZHk2qVyBpGNikHPCL6TVr8DYtg7dCifD0fLP6ElhYZja827j3VlNA3dCv+NnFwz+bAI2wLnYdihSPPeDthz4VCTHdv0RjrBYBchY5r+CigEHnYrVxfzphQDKEXabd8isMvzBvocJpFzuI1PHpP1V58VX87M376GJ43F9OyBZmq5QewgBk5eRW/kuw+U7Y0W1qrUN9h2I+QejwIkwDJ1DK5ZGzwXCAuTaZ+l12vO9lgfzxLYOPUVSrDMTTJCvVVyyYUNBQcQ5U1SDLlFg4vsTWIhSRJjQnpHWEi95jIZtBnuCXZMkdQpZEs9L0uDHZ7KJJ6/wTgKNexYncqF2D6hew4FgxnRKq9L9uHqYEc7y2p9pMvNn2Jgh/vV9u3cRLG7BeNP25v6w/TsLPrgqVek/Yh8fFXF/oLjgBg7rV1FiGE636PpVoN2aTnYxfZbPRG5GUsS/CosuMiBnTRYxFgXTTUA+iSnbZU/o+eEt/pIEBs0mkQXAcHYniQfu9i9qfD/jODeb5OPyWT1s6R6JVOf1NL2iwFooPP6mi/WuVYq71K+ls6B+DozQyN2kvJm6ObABJwlkg+ZtNJe2L26tRuzCYQ+7np52PAAFtjK94Rk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baaf9f01-69f9-4881-8a72-08dc86ffc080
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:18.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URbpdT6RX/ZCP7mM7GlmS8gy2Z2+pJb7ichkGzcg6q5uAmiyjduY4dY5o80Vxhn3oo10bYkLy8TM3HXItkmkfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070108
X-Proofpoint-ORIG-GUID: 1Qdl5SKtTmgUzxCOvP3gzWn4YPmAmawl
X-Proofpoint-GUID: 1Qdl5SKtTmgUzxCOvP3gzWn4YPmAmawl

From: "Darrick J. Wong" <djwong@kernel.org>

Add a new inode flag to require that all file data extent mappings must
be aligned (both the file offset range and the allocated space itself)
to the extent size hint.  Having a separate COW extent size hint is no
longer allowed.

The goal here is to enable sysadmins and users to mandate that all space
mappings in a file must have a startoff/blockcount that are aligned to
(say) a 2MB alignment and that the startblock/blockcount will follow the
same alignment.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Co-developed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h    |  6 +++-
 fs/xfs/libxfs/xfs_inode_buf.c | 53 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h |  3 ++
 fs/xfs/libxfs/xfs_sb.c        |  2 ++
 fs/xfs/xfs_inode.c            | 13 +++++++++
 fs/xfs/xfs_inode.h            | 20 ++++++++++++-
 fs/xfs/xfs_ioctl.c            | 47 +++++++++++++++++++++++++++++--
 fs/xfs/xfs_mount.h            |  2 ++
 fs/xfs/xfs_reflink.h          | 10 -------
 fs/xfs/xfs_super.c            |  4 +++
 include/uapi/linux/fs.h       |  2 ++
 11 files changed, 148 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 61f51becff4f..b48cd75d34a6 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
@@ -1094,16 +1095,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define XFS_DIFLAG2_FORCEALIGN_BIT 5
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index e7a7bfbe75b4..b2c5f466c1a9 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -644,6 +644,15 @@ xfs_dinode_verify(
 	    !xfs_has_bigtime(mp))
 		return __this_address;
 
+	if (flags2 & XFS_DIFLAG2_FORCEALIGN) {
+		fa = xfs_inode_validate_forcealign(mp,
+			be32_to_cpu(dip->di_extsize),
+			be32_to_cpu(dip->di_cowextsize),
+			mode, flags, flags2);
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
@@ -811,3 +820,47 @@ xfs_inode_validate_cowextsize(
 
 	return NULL;
 }
+
+/* Validate the forcealign inode flag */
+xfs_failaddr_t
+xfs_inode_validate_forcealign(
+	struct xfs_mount	*mp,
+	uint32_t		extsize,
+	uint32_t		cowextsize,
+	uint16_t		mode,
+	uint16_t		flags,
+	uint64_t		flags2)
+{
+	/* superblock rocompat feature flag */
+	if (!xfs_has_forcealign(mp))
+		return __this_address;
+
+	/* Only regular files and directories */
+	if (!S_ISDIR(mode) && !S_ISREG(mode))
+		return __this_address;
+
+	/* We require EXTSIZE or EXTSZINHERIT */
+	if (!(flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT)))
+		return __this_address;
+
+	/* We require a non-zero extsize */
+	if (!extsize)
+		return __this_address;
+
+	/* Reflink'ed disallowed */
+	if (flags2 & XFS_DIFLAG2_REFLINK)
+		return __this_address;
+
+	/* COW extsize disallowed */
+	if (flags2 & XFS_DIFLAG2_COWEXTSIZE)
+		return __this_address;
+
+	if (cowextsize)
+		return __this_address;
+
+	/* A RT device with sb_rextsize=1 could make use of forcealign */
+	if (flags & XFS_DIFLAG_REALTIME && mp->m_sb.sb_rextsize != 1)
+		return __this_address;
+
+	return NULL;
+}
diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
index 585ed5a110af..b8b65287b037 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.h
+++ b/fs/xfs/libxfs/xfs_inode_buf.h
@@ -33,6 +33,9 @@ xfs_failaddr_t xfs_inode_validate_extsize(struct xfs_mount *mp,
 xfs_failaddr_t xfs_inode_validate_cowextsize(struct xfs_mount *mp,
 		uint32_t cowextsize, uint16_t mode, uint16_t flags,
 		uint64_t flags2);
+xfs_failaddr_t xfs_inode_validate_forcealign(struct xfs_mount *mp,
+		uint32_t extsize, uint32_t cowextsize, uint16_t mode,
+		uint16_t flags, uint64_t flags2);
 
 static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
 {
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 09e4bf949bf8..515f5dd23b6d 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -164,6 +164,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
+		features |= XFS_FEAT_FORCEALIGN;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 93ad442f399b..a6cd5f1f2680 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -608,6 +608,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+			flags |= FS_XFLAG_FORCEALIGN;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
@@ -737,6 +739,8 @@ xfs_inode_inherit_flags2(
 	}
 	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
 		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
+	if (pip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+		ip->i_diflags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	/* Don't let invalid cowextsize hints propagate. */
 	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
@@ -745,6 +749,15 @@ xfs_inode_inherit_flags2(
 		ip->i_diflags2 &= ~XFS_DIFLAG2_COWEXTSIZE;
 		ip->i_cowextsize = 0;
 	}
+
+	if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
+		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
+				ip->i_extsize, ip->i_cowextsize,
+				VFS_I(ip)->i_mode, ip->i_diflags,
+				ip->i_diflags2);
+		if (failaddr)
+			ip->i_diflags2 &= ~XFS_DIFLAG2_FORCEALIGN;
+	}
 }
 
 /*
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 805a8cf522c6..7005ea29bf11 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -301,6 +301,16 @@ static inline bool xfs_inode_has_cow_data(struct xfs_inode *ip)
 	return ip->i_cowfp && ip->i_cowfp->if_bytes;
 }
 
+static inline bool xfs_is_always_cow_inode(struct xfs_inode *ip)
+{
+	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
+}
+
+static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
+{
+	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
+}
+
 static inline bool xfs_inode_has_bigtime(struct xfs_inode *ip)
 {
 	return ip->i_diflags2 & XFS_DIFLAG2_BIGTIME;
@@ -313,7 +323,15 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 
 static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
 {
-	return false;
+	if (!(ip->i_diflags & XFS_DIFLAG_EXTSIZE))
+		return false;
+	if (ip->i_extsize <= 1)
+		return false;
+	if (xfs_is_cow_inode(ip))
+		return false;
+	if (ip->i_diflags & XFS_DIFLAG_REALTIME)
+		return false;
+	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
 }
 
 /*
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index f0117188f302..5eff8fd9fa3e 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -525,10 +525,48 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_DAX;
 	if (xflags & FS_XFLAG_COWEXTSIZE)
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
+	if (xflags & FS_XFLAG_FORCEALIGN)
+		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	return di_flags2;
 }
 
+/*
+ * Forcealign requires a non-zero extent size hint and a zero cow
+ * extent size hint.  Don't allow set for RT files yet.
+ */
+static int
+xfs_ioctl_setattr_forcealign(
+	struct xfs_inode	*ip,
+	struct fileattr		*fa)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (!xfs_has_forcealign(mp))
+		return -EINVAL;
+
+	if (xfs_is_reflink_inode(ip))
+		return -EINVAL;
+
+	if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
+				FS_XFLAG_EXTSZINHERIT)))
+		return -EINVAL;
+
+	if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
+		return -EINVAL;
+
+	if (!fa->fsx_extsize)
+		return -EINVAL;
+
+	if (fa->fsx_cowextsize)
+		return -EINVAL;
+
+	if (fa->fsx_xflags & FS_XFLAG_REALTIME)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
@@ -537,10 +575,12 @@ xfs_ioctl_setattr_xflags(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
+	bool			forcealign = fa->fsx_xflags & FS_XFLAG_FORCEALIGN;
 	uint64_t		i_flags2;
 
-	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
-		/* Can't change realtime flag if any extents are allocated. */
+	/* Can't change RT or forcealign flags if any extents are allocated. */
+	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
+	    forcealign != xfs_inode_has_forcealign(ip)) {
 		if (ip->i_df.if_nextents || ip->i_delayed_blks)
 			return -EINVAL;
 	}
@@ -561,6 +601,9 @@ xfs_ioctl_setattr_xflags(
 	if (i_flags2 && !xfs_has_v3inodes(mp))
 		return -EINVAL;
 
+	if (forcealign && (xfs_ioctl_setattr_forcealign(ip, fa) < 0))
+		return -EINVAL;
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index d0567dfbc036..30228fea908d 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -299,6 +299,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
+#define XFS_FEAT_FORCEALIGN	(1ULL << 28)	/* aligned file data extents */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -385,6 +386,7 @@ __XFS_ADD_V4_FEAT(projid32, PROJID32)
 __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
 __XFS_HAS_V4_FEAT(crc, CRC)
 __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
+__XFS_HAS_FEAT(forcealign, FORCEALIGN)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 65c5dfe17ecf..fb55e4ce49fa 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -6,16 +6,6 @@
 #ifndef __XFS_REFLINK_H
 #define __XFS_REFLINK_H 1
 
-static inline bool xfs_is_always_cow_inode(struct xfs_inode *ip)
-{
-	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
-}
-
-static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
-{
-	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
-}
-
 extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
 		struct xfs_bmbt_irec *irec, bool *shared);
 int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7..852bbfb21506 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1721,6 +1721,10 @@ xfs_fs_fill_super(
 		mp->m_features &= ~XFS_FEAT_DISCARD;
 	}
 
+	if (xfs_has_forcealign(mp))
+		xfs_warn(mp,
+"EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 191a7e88a8ab..6a6bcb53594a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -158,6 +158,8 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define FS_XFLAG_FORCEALIGN	0x00020000
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1


