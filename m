Return-Path: <linux-fsdevel+bounces-18146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C118B6096
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8771F21DB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B24A12BF15;
	Mon, 29 Apr 2024 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wx4VxFBY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kEUqHOJe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859D6129A77;
	Mon, 29 Apr 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412987; cv=fail; b=c4NMgd+c1MN0zwDsdg7Xq3EIIeaX2OGEkiFMA+AyJJjfuofhVaiGlAuiPs6q304iNdIQKzHuOwjR+nkKYiRrjD5uG1Z07oO4Wr+xmle4LWRwlWWc1T24x8yjMogP6XxcIAUbi8RbHko5+KWnP3MoXSUZB2z5IMAAtD/pGvZnBgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412987; c=relaxed/simple;
	bh=nU8dBY6kIilE4oMPwLvHuXlZ7pC4Zvwi7GGZMGoHoy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkDM1bBG1mxRf4rypdr6esf34NAZzMPLyCh0ItnkjWQ3ylFyw9b3QVoj51iy0acRQZN3U3KAnBYK7h0fhX5ESMz4QDasTsfO+6DlDMIuVkrh5XxxV6kLaKVYawYB/9LfVzaskU5gL8RPZNyd0NWZo1PyjMFyKJTRJeWf4s9m56M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wx4VxFBY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kEUqHOJe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwmqb024649;
	Mon, 29 Apr 2024 17:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=MJ7X4gxgJu+VhcJHcXp6M87hdic7gkThROF2VmuVuyY=;
 b=Wx4VxFBYH/4S+kFtXxzCGmKQ/wsuiUHh4ZrKw/df6waEHLEFijjB+MXCE8bEqXdfvBQA
 mOdWBz9f/51BTB7iP6hYzkwoskEXSV0qcBGHIe0igZtakKE2ZSLHLeWIs9UPlEwECbB/
 MhBZWUCbha6hrQKAGpG+IHiFuAMsJ5K7x7acXdCRBbEjfl66Dhj4LuAPCrY+MfXyJJYV
 WPMeAY0TzRfQ9DXrEdLlDWFWktE+R/nhh4Zg16HXFFbZgh+WAbKbVBrtMDDApp6Do2FF
 YDi42QwDydNNfqBcWzl/Wp4n9ta8ef65d9FWJwWuXRdPQW3Xhs5gZVBKP6kXiL5Z1mzk Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54b7ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUW004324;
	Mon, 29 Apr 2024 17:48:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFNCFWwO+0G0qaFMPT/6byGrnMZPdNaygpfa+Bgl5uJYBHn9WbDz37phZylXeNKWZW3PAhzjoXL2bPKCh2It4t3NNSDXOS5VU7nNgaWWLGC1ge64mI9JQDA3NLFxBK91QZqWnBn25H7Mb69K0AOZ24jabbf7ik5sEg/JaHAfrCw+ZVAAbSY0uFInGoN+JjNNs1bHQfOGq7dcV8d/YuhCdOJBIOZAVBabZX603nt5xPnqvZGIvnkYadNkxLNHS8gU1rA6771picNJaHqDeOexYR3SoflgJjiTKjOl8pxJ8UKsaWGELQHroOEtya6YTlrfg89aLTcnqRzwZakPMjKzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ7X4gxgJu+VhcJHcXp6M87hdic7gkThROF2VmuVuyY=;
 b=MvYxnhHWQGRo7h11u6NHT63H8dIClO0VZQyKnZZzczCMZscrH/6sxOj2ScnmRF+JZB++aWt7PSED6gX5FfuuD+j1hEsHFYKTZ8V374g1h3n5VQkDrtLqxNfl/iMaWZVe4tcg65cO7O9ybQdrBHqfOx30bievwz7wglrO/yhiHbjZ2MSXS2l4fw6bAzAVLjI3BRg3fwiixkE6ZSWZz1AZoWA6/JE0fDFWRVES8lzHm1NDoTq/aRHxIsVdXESibOLXF3Rn9IYywO081bm7XwrTDSKEAf8wAD6IHd6+HU0WL2X5R74TXGvDHw4hKSomfxjZ31azVCDXCsytleYzR4vO7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJ7X4gxgJu+VhcJHcXp6M87hdic7gkThROF2VmuVuyY=;
 b=kEUqHOJekcyP8503j5NpIg6kTfWUzjqaUHcHWfT6+85sq+8f5IjZT35LVexdzher77JnKdJadBF1wyLgIz/giy76f1AV1aKWrjmeIyOkCHxKYHkoqWnJu6Soq8WBwLAT9i3frPDvcf4Ddeup0Q+rUTubFEe8zrNxgxIbH5+GkiE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:22 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 08/21] xfs: Introduce FORCEALIGN inode flag
Date: Mon, 29 Apr 2024 17:47:33 +0000
Message-Id: <20240429174746.2132161-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a161dd-53d4-48ba-b6d7-08dc68748ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2RFmEsVA6Jj9OXdicvXh0ww/Swfqjh6W7g//ikrV3x9W10GRU1HfxLzEQIg4?=
 =?us-ascii?Q?yvCRVJct9lzoKxrsvYVSja1mr9aPuNUClurmFv5pQsHN5I2A+qvAuWRBeaWS?=
 =?us-ascii?Q?PVbVo6owZgUTCJGXfwSz9YuiO+ZfxBQyopQ+1VFJguAuK1aIeP8827U0hTwU?=
 =?us-ascii?Q?AVYIZ3/ymv/1BwCR99W/WIhJ/FoJcCjAnk2oN/bkIBAIfPFEp4vQ+fN43etA?=
 =?us-ascii?Q?ZhvbDkQZYHoqlgfV/UIv7qK68jmcr/IoLlQoV3GV1DhKE/Oi90DqJswSznce?=
 =?us-ascii?Q?tptGZH/omdVMZlFKIyFKXgTJFPXmsfVmsGtBgg8Jzw/owBzAgBAB/JWgV9IP?=
 =?us-ascii?Q?hepPO0uLZBkWWT0G6sqv3T2Gr3uRF10YjdzFDt3PvyAVYVnjv5/6ugxvKdqk?=
 =?us-ascii?Q?Te8mOUh/XSBhGMZcUJL8L4NUgdB7yb78kj+K3zSTyH+E6QGzGEixSjzJ0ioe?=
 =?us-ascii?Q?GVsLPUZS2w/TYU7sWq05V7og/1iEh/NIv7G3vXp/FoOpj+B+Hv4wYUYhqjRL?=
 =?us-ascii?Q?WT1T6Gu/T+bbMtCGpRvXsU+W5nOLILQdH32BfMoO6yJdKLT5OUpzmQxbz7U+?=
 =?us-ascii?Q?UlsVFtv6te8XaBERHEwZC3whANfHYmkabSQByryXOHOe/8HSI4ka5mzCysho?=
 =?us-ascii?Q?pSgipLjQmTkIbV0FggdsIaBRrZXkrjkiAZ2zL+RJDbxdbsnK2sBEkHSm7jsK?=
 =?us-ascii?Q?uQwi1tS+rpfCcoACH3l6umLK/oYUDkrMVj3U2E5WUfFp3CJeNLJjzKP27xtm?=
 =?us-ascii?Q?b1I2fXcKcTxwTNYp3nyXWQ9Jr64RZrizSgpU3MKc++9dI58S/EAl/BAIqYpo?=
 =?us-ascii?Q?UioRgE0i4epjgvtKOwIDXFkJwseVYRVrCUwnQfzr7nDxHYtTfUV7ZY0rq28I?=
 =?us-ascii?Q?Je0Sx4qctUw+Dq8A69nD2/xNjcJq+oSLKXz7kWguqJdxnAf1IGkNarDuCrGd?=
 =?us-ascii?Q?SQkAfKQhZbBTc6t2ZyEl6uHup+QTf/w+ZgKcUXuRZZFy2bzT43+teOTfyNEy?=
 =?us-ascii?Q?HXKTu66PM++bP5+WDgVfr5eHPRHbv/cnvcuTT2opFGGwjpiD3NVQvabES5Bf?=
 =?us-ascii?Q?EnQ93dje9TWsB9Drk5badldvS0kdPKeuxd0g7e87ObFK9mu3SvEjYdc8rXBv?=
 =?us-ascii?Q?YNOaOg0SzV30drwCQVitsr0+kNIUQy7vS5Hfuw+aUkyRIwOITrYX3rs5fdT/?=
 =?us-ascii?Q?qL4DKxKXKJFgqJyJodt7J1JtI9lTHKL+/NqSEC+/hNSlWosPtQcibzudh3WE?=
 =?us-ascii?Q?RiePuKvdTbLq2oHeJf/qhGVyV6pasdamyRvJJPV8Hg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y1YqPsI0vPC+GeN8xkoyqpauLSVXgyXcwUxzubfxt5fY1zX6dsFwgoS2KdWa?=
 =?us-ascii?Q?8SU6ZTZB9l/YDyLZbpUZ4JCInVwG5HqTtt/0VjletlqvPd7aNhp1V3mpGDG+?=
 =?us-ascii?Q?eWC0AGsQ7dTUNmAr2qliQcgnuFX+EPv2yQpRYGD7Sh8RPZHU2pSdUJVA2kPQ?=
 =?us-ascii?Q?G2aJZlpyAX9AveK8KbigWvHz4ONCFc6fYah3DNb6yPLhyAoE8dK2w7rEtp4G?=
 =?us-ascii?Q?QnMrDiamxmhYI1Fq8RpSp7p/5Hfnb7B9TukqMr/BMFkeYslQBVz7MDT7cjIe?=
 =?us-ascii?Q?L0mzcUwgLjPVzXf9rvH0geH1Zbs92HSznh0bobdB1zqBmgBeUSpU+QS6gObJ?=
 =?us-ascii?Q?CxPsOuQb7n3zQE/UTfK7wp9VV0ooIrC0R11oqUrwDbglKDck+Kn34FnOJwp2?=
 =?us-ascii?Q?4fZR89/Ga1yEt3B55sh1PNzcBCErVOmHboc/MKFDdrrfiAq5aOn9bTSBrQzB?=
 =?us-ascii?Q?bw72V+cUdA2G4FibeEkBEf0e3rYCZh6VNYFFTO7zHL2BtHWbG+d+hL8XcIPB?=
 =?us-ascii?Q?hMjBxPatVn/YxnfBwJr/ebp4/K01D4LFXgp7W6ilLfOrbpX3ZoKbWRy9PNQ7?=
 =?us-ascii?Q?3HwaWWZPkJ23qGotAdVKLg5CMPB8aKy2GaXQng8YeN4h4ZCSB+tkTBCsAEbt?=
 =?us-ascii?Q?fgN/1BL3rw1CJv/tbYQ8J+hS0vS2fSv4+IFiXiskVIcFTlJogYeZqqAN1xzF?=
 =?us-ascii?Q?NhvYV3sXhIpjXtScbb09BbVIH+7FlM3PR90MVn0zOEFVUrYgYHuYHmrX0QBU?=
 =?us-ascii?Q?BonM1f00fZewoBYAlmhO42AsSEAu5RqLLNgcxeKbdd3ELX38SsNYljS86OCd?=
 =?us-ascii?Q?GkM0CXR5kEeCpTI2g48G5nWC78ndBmTJISUFLHKKU0jk49OzG55OhVE+Q+0T?=
 =?us-ascii?Q?PjLdPDVAagbeh/qCcW3uruSs5rPy6lPgrfVjlkC2yAqX1AjEXzrqJuOa1sHj?=
 =?us-ascii?Q?hreWfZvhioc1TDMusw+59EsMB/YePx1AHy2VkFejLmWjAJhFKU7j+lVJ+C6M?=
 =?us-ascii?Q?pi/rXxRLchiufBBI8t3x35BGQuTswoZ3GFNmYLe/WzNKSZtEo3480V3Nleox?=
 =?us-ascii?Q?iq5xXReVpV308e0Sq/89OlSHXz4NRv8xOWMMI3m9D5P5W7YZYQtoGX6AZjBK?=
 =?us-ascii?Q?hOIyh7C/uOvkuc315+305H0dEzbTX1aU2oorVwYVYlVNeSAZ3PhmaMoOGDBA?=
 =?us-ascii?Q?AZasWUuXwiPridULOWoqr53xSh9JXYmBjxSTWe+/Q2WfyHbX+jgRWxWqSnhc?=
 =?us-ascii?Q?952x8CcwpqHHJm/vn0OaKJexQtKYUUDeVrJ6E8tA5I8Vm8zsn2848s0kemyI?=
 =?us-ascii?Q?fuuIWlArDFduXbBs0ibn8aS651jVenzC61+6J5wJ4HSfVkRZcEE45o1p4z+q?=
 =?us-ascii?Q?NLYFzFSr3z6nUg+Y/KImnq7Au+lFlCYjQ2dIMoSiMLAwWs2JUUEKCc544BNP?=
 =?us-ascii?Q?sd7ME5/pjx5Er3NAifM4cv1GlGoxDJifXIYHvbU47oHWZ4u1ezUiP+PniD6u?=
 =?us-ascii?Q?tBmQvV463xoSDE/1y8N6YGx7kwX2sMcHAkAXgphZzM1mFnZNY2V39qh7tqQh?=
 =?us-ascii?Q?jvX2s4hrn0obQW4BXfuxy7lkeRzvII+1VFV4jrsT+TaDlzgYbTB5TuWA3n2O?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7/ASL1alRuw9E8NHcyQMK1gZg6ZuBJC+YHexSa4vkak8wdJUCUAPkBN+M+ocz1OChoiOcWSZnlbDFN43sHt7nMAIaaWGptbjYmHCbuRe9Dm2ib3JMKcF2S3X5F85gaIFW1K1CXdkWULs/w1kvBUMLRQU8hjK6VUo6OMimepY5SLSjVS0l9R5nomy/c8e+0I7BqKyNuQL/OGKoJnuVGGK1JXMd7nBHQ6IrJJMa0zPYudkMoRUNZIPmks/9rWcspRr4TPMbFH1Tgef8kgZoVlBw4AmSNQdy35ZJG8NBmgEfeBgMd4iY1Eayq+mzhlZuthDnw2VDg/L54LCdSzUEvVYqPiqHeN15HnOQjt7sXqvD9i2oXTGp0YextvtOd5USl+tSu4njy6AH/gFcbPhhmJwR5bDeterMEsuQUbctHS1A/OOK+Eyua2KKHQoAygYdZEjrknDrMRXywpmnAf2yAWsKc324yawGvJv5oL2KPxwlp00Abx0H4UzP/zLJJK7Ce964umHv6h7n/QC6MlH5nboSTlr/7tm8JORblpD/1Ntfe553zTNYsoeH9kIxrLcR1YMBEIn3Ppm7LoRblx8HEv0990l6CBIaWOhNcvzbDlp1cg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a161dd-53d4-48ba-b6d7-08dc68748ff7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:22.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77xg6vemzGkkHxBfsEWWHbN3WK1SuoVWcTdeVYLUbnTx1QzbAzSH/oIbjxSbqP/5JdWsorhg0G3naTR3jTicrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-ORIG-GUID: iFW-5L8-POjprmXgruo-v1_u5IIcSaN7
X-Proofpoint-GUID: iFW-5L8-POjprmXgruo-v1_u5IIcSaN7

From: "Darrick J. Wong" <djwong@kernel.org>

Add a new inode flag to require that all file data extent mappings must
be aligned (both the file offset range and the allocated space itself)
to the extent size hint.  Having a separate COW extent size hint is no
longer allowed.

The goal here is to enable sysadmins and users to mandate that all space
mappings in a file must have a startoff/blockcount that are aligned to
(say) a 2MB alignment and that the startblock/blockcount will follow the
same alignment.

jpg: Enforce extsize is a power-of-2 and aligned with afgsize + stripe
     alignment for forcealign
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Co-developed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h    |  6 ++++-
 fs/xfs/libxfs/xfs_inode_buf.c | 50 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h |  3 +++
 fs/xfs/libxfs/xfs_sb.c        |  2 ++
 fs/xfs/xfs_inode.c            | 12 +++++++++
 fs/xfs/xfs_inode.h            |  2 +-
 fs/xfs/xfs_ioctl.c            | 34 +++++++++++++++++++++++-
 fs/xfs/xfs_mount.h            |  2 ++
 fs/xfs/xfs_super.c            |  4 +++
 include/uapi/linux/fs.h       |  2 ++
 10 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 2b2f9050fbfb..4dd295b047f8 100644
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
@@ -1084,16 +1085,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
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
index d0dcce462bf4..12f128f12824 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -616,6 +616,14 @@ xfs_dinode_verify(
 	    !xfs_has_bigtime(mp))
 		return __this_address;
 
+	if (flags2 & XFS_DIFLAG2_FORCEALIGN) {
+		fa = xfs_inode_validate_forcealign(mp, mode, flags,
+				be32_to_cpu(dip->di_extsize),
+				be32_to_cpu(dip->di_cowextsize));
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
@@ -783,3 +791,45 @@ xfs_inode_validate_cowextsize(
 
 	return NULL;
 }
+
+/* Validate the forcealign inode flag */
+xfs_failaddr_t
+xfs_inode_validate_forcealign(
+	struct xfs_mount	*mp,
+	uint16_t		mode,
+	uint16_t		flags,
+	uint32_t		extsize,
+	uint32_t		cowextsize)
+{
+	/* superblock rocompat feature flag */
+	if (!xfs_has_forcealign(mp))
+		return __this_address;
+
+	/* Only regular files and directories */
+	if (!S_ISDIR(mode) && !S_ISREG(mode))
+		return __this_address;
+
+	/* Doesn't apply to realtime files */
+	if (flags & XFS_DIFLAG_REALTIME)
+		return __this_address;
+
+	/* Requires a non-zero power-of-2 extent size hint */
+	if (extsize == 0 || !is_power_of_2(extsize) ||
+	    (mp->m_sb.sb_agblocks % extsize))
+		return __this_address;
+
+	/* Requires agsize be a multiple of extsize */
+	if (mp->m_sb.sb_agblocks % extsize)
+		return __this_address;
+
+	/* Requires stripe unit+width (if set) be a multiple of extsize */
+	if ((mp->m_dalign && (mp->m_dalign % extsize)) ||
+	    (mp->m_swidth && (mp->m_swidth % extsize)))
+		return __this_address;
+
+	/* Requires no cow extent size hint */
+	if (cowextsize != 0)
+		return __this_address;
+
+	return NULL;
+}
diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
index 585ed5a110af..50db17d22b68 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.h
+++ b/fs/xfs/libxfs/xfs_inode_buf.h
@@ -33,6 +33,9 @@ xfs_failaddr_t xfs_inode_validate_extsize(struct xfs_mount *mp,
 xfs_failaddr_t xfs_inode_validate_cowextsize(struct xfs_mount *mp,
 		uint32_t cowextsize, uint16_t mode, uint16_t flags,
 		uint64_t flags2);
+xfs_failaddr_t xfs_inode_validate_forcealign(struct xfs_mount *mp,
+		uint16_t mode, uint16_t flags, uint32_t extsize,
+		uint32_t cowextsize);
 
 static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
 {
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index d991eec05436..e746c57c4cc4 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -163,6 +163,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
+		features |= XFS_FEAT_FORCEALIGN;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index ea48774f6b76..db5a0f66a121 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -607,6 +607,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+			flags |= FS_XFLAG_FORCEALIGN;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
@@ -736,6 +738,8 @@ xfs_inode_inherit_flags2(
 	}
 	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
 		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
+	if (pip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+		ip->i_diflags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	/* Don't let invalid cowextsize hints propagate. */
 	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
@@ -744,6 +748,14 @@ xfs_inode_inherit_flags2(
 		ip->i_diflags2 &= ~XFS_DIFLAG2_COWEXTSIZE;
 		ip->i_cowextsize = 0;
 	}
+
+	if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
+		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
+				VFS_I(ip)->i_mode, ip->i_diflags, ip->i_extsize,
+				ip->i_cowextsize);
+		if (failaddr)
+			ip->i_diflags2 &= ~XFS_DIFLAG2_FORCEALIGN;
+	}
 }
 
 /*
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 67f10349a6ed..065028789473 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -313,7 +313,7 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 
 static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
 {
-	return false;
+	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
 }
 
 /*
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d0e2cec6210d..d1126509ceb9 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1110,6 +1110,8 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_DAX;
 	if (xflags & FS_XFLAG_COWEXTSIZE)
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
+	if (xflags & FS_XFLAG_FORCEALIGN)
+		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	return di_flags2;
 }
@@ -1146,6 +1148,22 @@ xfs_ioctl_setattr_xflags(
 	if (i_flags2 && !xfs_has_v3inodes(mp))
 		return -EINVAL;
 
+	/*
+	 * Force-align requires a nonzero extent size hint and a zero cow
+	 * extent size hint.  It doesn't apply to realtime files.
+	 */
+	if (fa->fsx_xflags & FS_XFLAG_FORCEALIGN) {
+		if (!xfs_has_forcealign(mp))
+			return -EINVAL;
+		if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
+			return -EINVAL;
+		if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
+					FS_XFLAG_EXTSZINHERIT)))
+			return -EINVAL;
+		if (fa->fsx_xflags & FS_XFLAG_REALTIME)
+			return -EINVAL;
+	}
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
@@ -1232,6 +1250,7 @@ xfs_ioctl_setattr_check_extsize(
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_failaddr_t		failaddr;
 	uint16_t		new_diflags;
+	uint16_t		new_diflags2;
 
 	if (!fa->fsx_valid)
 		return 0;
@@ -1244,6 +1263,7 @@ xfs_ioctl_setattr_check_extsize(
 		return -EINVAL;
 
 	new_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
+	new_diflags2 = xfs_flags2diflags2(ip, fa->fsx_xflags);
 
 	/*
 	 * Inode verifiers do not check that the extent size hint is an integer
@@ -1263,7 +1283,19 @@ xfs_ioctl_setattr_check_extsize(
 	failaddr = xfs_inode_validate_extsize(ip->i_mount,
 			XFS_B_TO_FSB(mp, fa->fsx_extsize),
 			VFS_I(ip)->i_mode, new_diflags);
-	return failaddr != NULL ? -EINVAL : 0;
+	if (failaddr)
+		return -EINVAL;
+
+	if (new_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
+		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
+				VFS_I(ip)->i_mode, new_diflags,
+				XFS_B_TO_FSB(mp, fa->fsx_extsize),
+				XFS_B_TO_FSB(mp, fa->fsx_cowextsize));
+		if (failaddr)
+			return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e880aa48de68..a8266cf654c4 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -292,6 +292,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
+#define XFS_FEAT_FORCEALIGN	(1ULL << 27)	/* aligned file data extents */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -355,6 +356,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
 __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
+__XFS_HAS_FEAT(forcealign, FORCEALIGN)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index c21f10ab0f5d..63d4312785ef 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1706,6 +1706,10 @@ xfs_fs_fill_super(
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


