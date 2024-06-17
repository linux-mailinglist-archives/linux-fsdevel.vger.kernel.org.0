Return-Path: <linux-fsdevel+bounces-21851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7FF90BB6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 21:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D11284A4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 19:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D47188CD9;
	Mon, 17 Jun 2024 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ozhsg845";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kT7VI6ht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC0187542;
	Mon, 17 Jun 2024 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653992; cv=fail; b=SkykCVQeGjPnCeIM8g0mWhF/AxIFiH4bpI52uC0Rp51xLYNTgdLuSjxZXbRUPxGDdbDHZdyJ40+gP4NfmEdw406LUXfjWZOqiOXCZnp4y2wQJ0Vzqjf5m2iat2bRZesm9AhDwrwoCgCqNp7hqwX7vf3vCF+RLZFI8cWz3ijQtJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653992; c=relaxed/simple;
	bh=DY+dMNyGp1ACMtNGMWiXj6dEU4XY5J0eXp5UTRdlgJw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X0mSEXF33J5KH6GgRED24GGjq7HGrLZTSory5wUt4azNQW+Qv2FiacilPfc6coxWcZuYIqa4WMvP/OgmWFlu/RCirGn35pRflU7/+2Bj2/sUkvbF7yDWowVrHMZVCcMv6lVIuhF8C9EvxuD46h9BNxyG7EvlHu0N1EmBeFuTQgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ozhsg845; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kT7VI6ht; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HItSuf011207;
	Mon, 17 Jun 2024 19:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=j3C2A6t4JKcOCB
	fc9wQd1xQPbuoYVZEreLpniX1xcLY=; b=ozhsg845mP1MbkCYnW+6UuR3cgmJWQ
	BqcvmXHmXeheciF3JIbH5GR2zCnmkAphjGDcCAESu3Ruakec5mlcMsWijhsK0iaL
	joy5usu8KUyFtvnq1PQI8RZ1cMecD1NxmwPBNUUal8Cnxv3LJR4RqZGRokhBnnOL
	WsYsFa2rlnNKJ411dWs57nktflpRFTaVVojFIFVE9w5OouE/YRP8uvyekmmBLD8D
	ClllEzWvvNqN/voxeJ88btgADbarPLis+GZ1VjHnoFlJVwMFwT3YuidjhguN3QNp
	IAUWI/ruq3Jb2prDHSdPawXRU6HdhY+oh4kyug4+lomQoquG3wghy2IA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1vebjjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 19:52:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HJWKc2034855;
	Mon, 17 Jun 2024 19:52:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d75s75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 19:52:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5/MNFPZADIDe06JsMuQFuhHlihjxsESJwOIl1I3W5Y1LK1CcidmtkT/aZCqkNOISvS8lwmPEMV/D09HWHcNVOsz6YN/iTrOvJm4NFNP7C/dR3+v2nlO8G7Qi4PZVqsps0pobqpoXIppv+95T6seiUFoR7bIZnqiFwg2RQba/1wOAk9WmSH4oCfhUEVneUdnoG5FiYxhIBb5/4Wu1uJMkdFAAZhpfiMDaxdIEPTxbC8B94o5LFt9UKd+UBgdYc754su7gY0+sXcpqLlQXVQ52qDxfadGwDfEeNyfsXoh9HfeIYaxysOliSSZJQHQAMQOUFIFT62nXTh4i65pJx2Jug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3C2A6t4JKcOCBfc9wQd1xQPbuoYVZEreLpniX1xcLY=;
 b=Y+x8nvzyFLT5lkfmB2KzDQo5N2c+Poa6hAe7tH4Ooa0hcAw6d2KJXdytaAwcVL6TjXsAiP5mWzJEzPYTpA3k4LenmtoBPYxKKhLMqeMoEkJDRqyjETkdx5aYUdH7joRxZ3vkJkGinurCIiFn9bWkA27MQG9d/QgShoAQWJa+ym0EmXXYeJ8ydfVwVvHBQviNOQ6RbcsKOE5LoEB7RHlLBWiniMqaCU+Kq0VRN8PKXZ7VC41oTXGvsgre/x9iCnGaWFv0jBD0HzILd9WbGDVUOUQl6S4n55pK1iYk9BcT3fndL2ntgskxzkSD0j3X5syvjnR8dB1yca1lyPMvjpLyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3C2A6t4JKcOCBfc9wQd1xQPbuoYVZEreLpniX1xcLY=;
 b=kT7VI6htEUW24gpQb0ivI2WJNsZU733NjpU93R3KjkgCnuaIbg9GlF1qUq3YA+qvz6k7kTnA3+nZSOV98s1mPlYc4b1NmZMwkBWOn/nI5aiEUaWwzhkrcxNwvApH9dJzG/uDWp7rk6QVDDAlYRfcd1qgSMTcrii+cbHwd6K/IYQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB4818.namprd10.prod.outlook.com (2603:10b6:208:30e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 19:52:30 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 19:52:30 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, quic_jjohnson@quicinc.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] tools/testing/radix-tree: add missing MODULE_DESCRIPTION definition
Date: Mon, 17 Jun 2024 12:52:21 -0700
Message-ID: <20240617195221.106565-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: 88697b64-b005-4193-35a7-08dc8f070558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zw2DKU5+Gx+G+pjpnbGRmBD0zvH477zBf8SKr43mjtRcGn4agQlBGL4Sjj2a?=
 =?us-ascii?Q?3aODw0vLekaFOcIcDWQXI5b4261NaBHB0Hz3kQTHU9ENaBO2SnEX5sO9/9kA?=
 =?us-ascii?Q?Hr+WwdQlwY1i8X2qFc/YVhJrVpTaWlqTBZiaOqo2urmr7byKNjGfOmEEXN3H?=
 =?us-ascii?Q?yzrgcTyCyMlFp1SEMYLF5GjI5vs75r3fGeJHvCamiTJXwoqoyFIfRAYlg0oP?=
 =?us-ascii?Q?4z5DZfKGGIDtrKjVQZnw5ueRHOM95okuuUjmGi0q1L9w1Yp9WfdECVapfT/9?=
 =?us-ascii?Q?DwARN8iIEpU5vCBU8YN6/lAOBU9n+7/6SgPfzIwkcqlTe/ZTfVZfCUM/evmm?=
 =?us-ascii?Q?K+uWj9ASLj1iigSbliwQnBZUBcsnPx+RdxO8wo0Ozg/PT0G60NRSlNjSpjND?=
 =?us-ascii?Q?+qHBaGJH8Bl5DKIW+DOlbllWMkQk7Piqn7JVhYltUK9qAsqqrw+ibGxy/t/i?=
 =?us-ascii?Q?1BQV0AZVqhJB2AP1rfmVHny9V5Kqobor5B+Y87O1vFstJXzLhgEJE6PnVh1v?=
 =?us-ascii?Q?oA9rR+fkKBCFmg1XO5hBghfcD9vWYxsvHetTZW5wrG2wOh3IwZsXYmNyf9F5?=
 =?us-ascii?Q?7W5dmEO4oqDm1bX0dDHGx9KRMmdGkDYzAyWO0qtXXDaMGjVHXL9NEbMB0eZf?=
 =?us-ascii?Q?ne7C3RgIxLtqJZdZiO/r+/lbYL5XnrcmWHh2Sdv3+AN9H1KhN6Zr2gGnCIQ8?=
 =?us-ascii?Q?Bf8qZ7ReVXqocgHtuFwhMNr9e55UezqI1c0V9xMGcb1zN8eXPSlGNzfqiHpC?=
 =?us-ascii?Q?SpEtbxLlwuCKgQZlvAX9AaODGa1oneR22UnB4+lG8HY9lspeTGvwlzNV0YLz?=
 =?us-ascii?Q?Chl/YwMST/OI9AQOFcmKmkIDrOC+TNITinDo3DVJ5ztSEdDNhruLgaM5yk/d?=
 =?us-ascii?Q?pgGSVw551RyXQLSoMPLfXt9PsJR+QmcpIidU66OokjpedRKId7ji+fWmepCx?=
 =?us-ascii?Q?HSlYH4RptLNEla98hO1aDTTRMAXEIY3F0hpr26vmSEVYh2lKq0zbfPoPnHhT?=
 =?us-ascii?Q?+WNLvJmOub6qjqjPU1ggJvpeHTBZLPaLWoHNsUlMVWR2betIF6Gz0TGkhdr/?=
 =?us-ascii?Q?ltJMokO/vHtYxQt9CkKF8r0HJ2K4MwaeOHPcvlvyow4polSXZZZVfViubtH1?=
 =?us-ascii?Q?bLgYQR0NxeY3b/K8s9oOD8gxqEDNSTWKCDoX8J7G8w+fxAebjq/OSZDchCbO?=
 =?us-ascii?Q?27AzCB1949CMhGBDktUEiLJFrxJLpBVv6xVd+n31yeO1fRv34JBI8GWEjmxI?=
 =?us-ascii?Q?k77IlnQbuZWLnNqD/xTtdBqd0GRkrdBA1QsivefcaVIqWkZ+ahMYATkzVrPn?=
 =?us-ascii?Q?2nNS0gEt3NN5b6RT42TBnacM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Pxjf+4FbrNq9R93PVkP54hJuJS7d9pK9vc8aA+0At1z7zLPSWrVuvHnUyMBS?=
 =?us-ascii?Q?0/m/NNjGsifO/BNvGDCRmAaLnPJk58QiRP2Gk/VvQcykZX3DBJo9/FYP3Ltw?=
 =?us-ascii?Q?78tmQNSIGG2gKsIB+CsL21YV3yrvd5bwzJzyuiMYIzqnWv2KfrkZKVAA7b38?=
 =?us-ascii?Q?En2leKCbOuTGB/Kl3k7OwCLGg1JgxPbilRv4q1e8fZqWDY4G7PhfNjNgahyJ?=
 =?us-ascii?Q?tLRVHRwXqH7lvr9OeV6q/FKmzRjL10XpM0mI7gr1hCXuzndYBWT3a6DtqUzL?=
 =?us-ascii?Q?cZuhDe4qc4l1yH45j3yb0OXv0F6UKnllps6w7gln9GPO82z8r3q7tsu3q7sX?=
 =?us-ascii?Q?F3am7cZfnoEB4OWKtmPjxtXIXCIhf2nzcSxRd3RW+Dh/XinW669ygNzO7Bgg?=
 =?us-ascii?Q?IDis83PQX6DuqALixGMWQYSmp0mj3dWbvq3QU08lLSHKcjn6fCSMtGSp+pwu?=
 =?us-ascii?Q?2zadxY4Ixfa9ZV7B9rjNoq1nddBzY91CXOrwpt3Xdp/kNsXK+wIlq0JpNxjv?=
 =?us-ascii?Q?pONRNWZUcYgKSLiDdXqIkOd9JBl32dRFDwpROFbd3pjVO9s0d4MowDAY6KMI?=
 =?us-ascii?Q?WJIX9tzGhP6tfqanDTw7UzukNjKhLGTMhUDGRxu2nPfS3Jd7aM10sn+bhvqQ?=
 =?us-ascii?Q?g7vwTy+l1goJkqqi27Jzyr5fDzxbBSw3gOOakA8t/yD0rinAI6vGF+9qjALB?=
 =?us-ascii?Q?AoxDPAczCUbZCri05hzMNFky30qD/AJNK3MYH+jOuG58i4x3d20sLQ5nE2Th?=
 =?us-ascii?Q?9ZHVVsV0RJc7kVWZUb6LbfgMAe85baEKMtJ9mWjLOitHzUkHImeUegYEggyo?=
 =?us-ascii?Q?cu6S3w4ETlxHeiq6yZuZbLqIdwlo0dDTcxfPym09Tr8mILnzUczLM+Y4S7v8?=
 =?us-ascii?Q?tq/Wey+4of3Jkou3qGMIdCdjrZieHHWHJwPSW28SRr2ribN37215hVzJ+hZw?=
 =?us-ascii?Q?PvEV3RyEVjTb7LUjMCcuk1EKYJ8noCwQyZLVfMC8tGdupxFFJ7QZH9QKjxTt?=
 =?us-ascii?Q?JlEkzO5pCUsg8EMolsoIRhC0Ukdwg/wNQjT8QdeZAxmrfZAikj8mYRqeq9od?=
 =?us-ascii?Q?1quzL7+9Rum4fBk83wGdyOeIKHKpv0tMj/fJTY215uumqX7Z24eDRSTM4Xw3?=
 =?us-ascii?Q?9qXgrTq0Cc1XPH682Bk18nmDj1WFOFjpJRHgJ/maHYcMgENoHYDO3M2LhZhz?=
 =?us-ascii?Q?VuYuBJezDKC2dMH8q210kQzUrX4LsYmCxJmFyU8vR2u6pS1OYFJ2M+d8or12?=
 =?us-ascii?Q?TR8WQf0UiES6HqaN8Z9ysOAQ+TNi9W326DfDt0DbQ26GXiMGpR/1m93ylhzK?=
 =?us-ascii?Q?RH3alKGGWm8gle83zVUUN9FqRfdXvKV8uHL1iitB54cq6Il3+NUoWWj709W2?=
 =?us-ascii?Q?VHOzPssWaDjXb+x3MxfEC0dciAuFy0tMayuKxolbmp8fFKLS/jnmt+o27p/s?=
 =?us-ascii?Q?zo1z/aujiXrduexiBl0hpQ2nUZlqQ4PWpwieKMvaPSWIYvN4Xp7UbgUzn4Gy?=
 =?us-ascii?Q?yn+5JGQ/3+u5lzyTWwBtGG81hzyLGW+AMh6m2bQ6pzlC56rEOn+UnpLQo9Tv?=
 =?us-ascii?Q?7LYv0ygTgEIDWGExEaB+0np87w7pP625qC1gLQbdwdIMdGYiBtUDmzFFLCCI?=
 =?us-ascii?Q?zp/9k7Mt9s0YJmXho3MMvgU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	N64P6gqShYsPLeALp/DpDRZcECroQZhDoyBr65zM6YrZS8yOYJ005ESnfrA3MA5e7MOmrWnm2WhcDZGm/FQxyv5LX7jSabrPqBQb87coFP7PYqZwW0MvScfFo6G1agFzLuhCvF0bPm4HcQUN8fTvHVynYvViK2arqCGzF6k+Rgda5SF9/u9W1hkXbQmQwGjoyBrgkC9AgYwKXyIyfCmxcYDUa/zvGjaSiEkdCf/kQVFWp/zK6dve/tgrszrdSTiEuSNmxU8x1jmR8AZTIITaOnu/u+1toXYwMBjmRmR1cj/82wyCTuT21KUd6Ev4qSdoxRaGFoyNWuGaO9loxl3TepzRv1Cn+71dTmrEjXus88JBmvA4l08ZgVAIErVVh8UE7X6pZab6deyWHM7POPjH6uZDF79HmcYsaPLQHPJmpfzdUGV2g/Dj0qBrrEQEAPF5VBqEO5ZyPaK9uDNt/ltdLztwCHlXBO7fm9IY/m8wIQojPQRLVGKWFcZDtdlYFRkYOfbt10b143BkFKg98/Bg49FUwD5axzLLBllmFjMnxGqDLxehO3ygNX2PHo/1ef3dwv0V64VwOoPbR/HiT4aCeGOXkik99DCg9EAgrhOhFK4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88697b64-b005-4193-35a7-08dc8f070558
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 19:52:29.9193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1de5GQ+lf4+6ZBZG7qjv860KT9ZelsaF/B4MOHZKQk9NKDSoFs5xPXDOdchlcz0S3DhMhLPP4KcZ9J9NZknSTcqW1BRVvF3B5kpvjKWNMT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406170153
X-Proofpoint-ORIG-GUID: ySfq7zID-LMdFmUjQYqFJEDSVUCSFLFQ
X-Proofpoint-GUID: ySfq7zID-LMdFmUjQYqFJEDSVUCSFLFQ

Userspace builds of the radix-tree testing suite fails because of commit
test_maple_tree: add the missing MODULE_DESCRIPTION() macro. Add the
proper defines to tools/testing/radix-tree/maple.c and
tools/testing/radix-tree/xarray.c so MODULE_DESCRIPTION has a definition.
This allows the build to succeed.

Fixes: 9f8090e8c4d1 ("test_maple_tree: add the missing MODULE_DESCRIPTION() macro")
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 tools/testing/radix-tree/maple.c  | 1 +
 tools/testing/radix-tree/xarray.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 175bb3346181..11f1efdf83f9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -19,6 +19,7 @@
 #define module_init(x)
 #define module_exit(x)
 #define MODULE_AUTHOR(x)
+#define MODULE_DESCRIPTION(X)
 #define MODULE_LICENSE(x)
 #define dump_stack()	assert(0)
 
diff --git a/tools/testing/radix-tree/xarray.c b/tools/testing/radix-tree/xarray.c
index f20e12cbbfd4..d0e53bff1eb6 100644
--- a/tools/testing/radix-tree/xarray.c
+++ b/tools/testing/radix-tree/xarray.c
@@ -10,6 +10,7 @@
 #define module_init(x)
 #define module_exit(x)
 #define MODULE_AUTHOR(x)
+#define MODULE_DESCRIPTION(X)
 #define MODULE_LICENSE(x)
 #define dump_stack()	assert(0)
 
-- 
2.45.2


