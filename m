Return-Path: <linux-fsdevel+bounces-13463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C0870229
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCD3286CCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6F846450;
	Mon,  4 Mar 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QIWmkrvK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="coDD+HQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5A40BFE;
	Mon,  4 Mar 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557534; cv=fail; b=ZblO+8KLZreXJVtIOM5H6d3WERfLRnDNsvaeJbaxUaJtKosuNQEzpQvk3RXshXYFPuvBuJiTssJsM53F5vCY5fqo5FHYChPNnkq5JkkqrDDD2OHuk25efsUakHdJGHUOeXOts2JQaN0mbYQy7iKIAAl2Lk3gYaoGkeo8ySihuqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557534; c=relaxed/simple;
	bh=Q9H3linQhy3Rd+qOnEJ8VqTkPGb6qyUDCEMjTJDy+xU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zg6MCizrmDcQ8ohapVvGzNosggGwivdexii3l4HJ0+dAycenjig2/uUr6AMTAjjDOrRGYXOMaise5Z+OQvCUBpy2sM8SFr1KWVbBm9lCHHFq4H31NkadhPkWXt9qt4AJm/hrIUfkigrN+G22Su3bA17Oglibm+SGFAttibrlKXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QIWmkrvK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=coDD+HQb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTci7013674;
	Mon, 4 Mar 2024 13:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=DFG5LRLYRA73VG4UeaLhU9Gze/vqNy3acuXPH7OaWNU=;
 b=QIWmkrvK5x+3gXk71IQ/3h1MAtRsT5IUZBkwH2ezlVrUo/kpemBOWNubTYnjZ4CKz1Yk
 O9LKUibV+95iDGy/JmN7Qcf+VAD4RiAwAiN3CwGyeKlyP1a6B1xPDmE6NVS+0hYO5X/r
 RlxbLRP7/Mdoa4gZo0LD4NeNJiL8dARA+7Mbx+AQyORTDMjdB0J99LsaUx8vYAo+kksL
 j/ucEYngHfH/Mq7+ErTX2/UxHLBrmszVa37a5VtLhWxugA7rD/xp+/EmA6krwBrlDvjO
 AmUJIgVlMaNtALuCLXW7D6NFUEtBPRWqlZGozHgvvzr4PEtiYbPHB8d0H9c3LG3EELd1 tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv0bbewq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424BBhWg015176;
	Mon, 4 Mar 2024 13:05:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj60777-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkYQqie7simRe3SRwJvgwUvisaCBRjaIRWT7nToqyMhTvRXFavba3lemX6zimsHZOyxki101F28WzU4piWlWydNkRjYkhQ5oZFyijAHeueDJWl4MpgWlAkQIvGiV6Zx9vkQPRRkno4QohhZVlEUFGRH48WP56nYcgSuRKXujpE4aa1gVNBu942Ijn982SYHVfaoZZ7FNLEvp5uNJmNE6CxSk3sjF66R26h+J4MGsXQ6snrFIv/GgvGvtLQzDGZPqpARiXxkOMtTSDdxwdSRIco8vrAswvAFkUq9wh15E2slx2V7FHR/Y2CLirXhs3sBIZbZVd+G95trvUpCO+cD8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFG5LRLYRA73VG4UeaLhU9Gze/vqNy3acuXPH7OaWNU=;
 b=Xs5gnHGpFZdO3/xrHenw95H2j8eKaVDd+HafUNvEC5w0sB0avt20Mq4DGvBOcL/W+tQdrmGw+eS9TxV3omE8MfUiF5Hs1XOA+WrPgWDHcT5rrtugW4I38Ss6iBDy6Ss6C0gBAVAL4SsjEk0Zd+gjApEo4+53iRIxihzT9aSd4iExuOO/W5NCJYVVKr4twLX9ZcgFjaSNUuaNDMfkYHyGURC0hmD7wpL9Uv00OzU9Tqh8gqYN9/XPcwXCAGbFjTCglI27aqWy4413nOVPR7qs2JwdrLTkOLstSXoCfjJ1wPdz67KkGZ1u9nSlh8JOyGD538vzCyNyBsxVmBHoDDQVLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFG5LRLYRA73VG4UeaLhU9Gze/vqNy3acuXPH7OaWNU=;
 b=coDD+HQb6Y5KPukYkkhCtSxcphI05cEUd8S0tojtu4uxW7XG/6qUXvoPLyLKjc/a+gTY10eaXdg46OQR9ELEcQPl8llPnMl8KzwiuqQV+wGoXqmuE2ST75T2+NuPydHMhQXq4fHTq9ckWZlf2a1yG27xYqvyvqljrCpdaTNzTX0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:05:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:12 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 07/14] fs: iomap: Sub-extent zeroing
Date: Mon,  4 Mar 2024 13:04:21 +0000
Message-Id: <20240304130428.13026-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1aa76a-7a4b-41b8-91f8-08dc3c4bba5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z+GZwwPBaI4iFt0Jh3rY9xMD4EA302mn0j/JfpcS3HlvleMGBe4BdzaCwD/ae05cXAmnv/Zs6CcIQcL3Agc/GDJ/ldH/nXTS2ty2+EN0UoKzkYRVq0kCHQZjsDCiqK5GC6vF48oryPb86ISXYSQ3ZZJlrKo1yC4zPgac+h6fWBQWdds1kUXeI2S9i23psDRFxyFveMAvOj5ndXuRb6BXivJ/hzvdSo3GCbkjis5585PIcGBjDQ+ztTdDnUxG3nCo7oT3wOcXs64ATsUEAkDGIIy93UteoRvdFOT6aPVdpmNTt0thWvzoI8gVr/6/K+rYuGV2I1zGXasFf5PhDwV8tqoYQP3uD92eqOJ3D1ron0UfFVsnhqMYy9D9jkxf7En/iQxg3fjJTJdydK9AIESb0Ii/pHB/APiqg1geTdfAhCaGuA2XOH/5jVNjE4k8+1yuf0cRHdjNX/38Piq+FOyLTwLWg2whYCfW2/K8tkscjlg0XKRU2jBtL+QMjWUhUR3ZK6u21x9Yzvzelk6/uzK+btSMCo1wM2NHjTQyAWNTYR7aBCtyYhspIUW4IrR4hjnlZhlxdE4HmDbFTMwhVcREwOR1L9FwkhI3wjDel8ElRNkQjx7XhyY8MBdnQXLGETzZar4AlY2Nt2QmsdKVgVKbg0ZffNM5Z4NF3ndgzfyYCb0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SDHLpNqgrdASdA8wZgHSn8hPbWSP9+0OMQVmN66+rHkcuUQrYRJpz8LqKtqk?=
 =?us-ascii?Q?+vfxg0/itJw69I9m2Xd+JYJ7uIocLP4SCPgngAg5mp9IDwquq6VpM5hTWCDI?=
 =?us-ascii?Q?JsqZHMKsdSDNoBhJsXebK1J8pZOP+WNEO8muGLjhDOdZUnttRt1oXGT/O3gt?=
 =?us-ascii?Q?Hbdx/QXNgapx8X0zyMHSAZuiACS017V4ZXtzLKXrnxh8c3Hkl3utMS372I5C?=
 =?us-ascii?Q?KwMOQUPeEzAmAk+Vsd7FTXEZk0VWYhdenmdjZKMQ+cD5kv4ZSomLhu2fPWdl?=
 =?us-ascii?Q?ihMKpfFmBCe9zbOouLBT8wXg4LuTD/VaxkOaG3YqLp1HbnOjXWCtxZPiMbAk?=
 =?us-ascii?Q?FgZqsAHqX/SSndiK4E9eYtiz3JI6vZ5DUPvmsJqg4mUh0CJSH2T0NamyGls2?=
 =?us-ascii?Q?H+VoH116wwXjlQdsCPmo9/WOPzmSzAFSOq5WA7D3NeTkXd/61E/en+/ais/i?=
 =?us-ascii?Q?nRCGJPcJg1dsRdAMGbqMFPRVsM/ny9Hrr7PLPZL+gr8kI8v126TsOP6IhYs+?=
 =?us-ascii?Q?sdi8oFPFWpZGGqNqpu7H70+oULCFPtNFisXwoJ3FM5ZV31MuFltmH0+hZxG9?=
 =?us-ascii?Q?L/u5/AurncD/A5noAh3QW/irFwIgC81AhTM04cXbFBs8EmiXRtPp+fFPP1lP?=
 =?us-ascii?Q?2HyQCgrVZQgzwF0xBvxjRlS2clqcim2aC4j+0zstu1GJSyeWnTtphCJmSkiT?=
 =?us-ascii?Q?cvAv19o/fxg3gz2Acrx9JxAfHrFR9tzYyW4xIUh4wq2A5OrnHu64P6jqsQjp?=
 =?us-ascii?Q?QGElZ9K2Pncon0lnE3mWbKhMR8i8zV3M2nNKjCSjQKx7x6oLbsDxaXkr8SQW?=
 =?us-ascii?Q?XQky4oDUAIpIqZMREi2cLHxd1z1xzLTFN4tme4kNfCNprh9AAJiuVsBqLkKm?=
 =?us-ascii?Q?+Tb8eoU5KosivxGFw1acY4gE6VK0NPs+9Lk5rlFjVTMOmdeI7PdtqxKKNHU1?=
 =?us-ascii?Q?t/iPW7PgWY8xYqCM81k1qyJH1QH8bwlLbzAYiqLPb0yvrNfvZJ3qMp4AzCuj?=
 =?us-ascii?Q?0QqUI8fukuvJR4dgNXHABOrpWVNtQEVTxlAH6qT8rRiQVsXpm2RgIbmAu9nW?=
 =?us-ascii?Q?scMwWCfgnb1J5taABn37+L/rlJsJCqAr1tExTgRPL35vpjtwvSEpaHV1TMp/?=
 =?us-ascii?Q?ptoh+lAUALvKGsv8n+2oY7LsymIz/gNU9YAWzIEgHF5FqIabF69H6Jr1/wnr?=
 =?us-ascii?Q?ns+t/yKRABUJ/MxJn+zNDwJy90yt45XOoMEfyk4Tz+SD8/JKxgbpWJRHQx2l?=
 =?us-ascii?Q?OD1EdCiVr3tA6DCVMnYtbaNqjd2yy/vU9mu9Nk5RD4F7FWIHSR4HAq2q9i+j?=
 =?us-ascii?Q?xZSZ1Q1iTvsVoi/3WoW5e1ZEWVjWZaLvLAhCXsxocd/9M5cclsIc3puMdLRS?=
 =?us-ascii?Q?7dE1IADif1+s3tEqYAx11JrZaIIUZnB5Fa6L9koXFD2jHcshfwrMLCBWTV5X?=
 =?us-ascii?Q?2p6Z+SRpfhB7c1Bq6i1v5wbWxy0RSm0e3LtQIDpVivSQuQld3G1aGm45WVQu?=
 =?us-ascii?Q?ZBj46MaqW9l45mqFpHsg7qGV+KfbzVuShz0g5s5eM4IiU7RWEZPhriimVpBa?=
 =?us-ascii?Q?DfNP3a961L3X0Re0FGLD7mwsfSaJG0fMzoArCHUAYMq0NlKuIlRfz7ZTvISe?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F8eTPCnWkJiN2ENiaeuk4bXfth6Sb2Xkq9rj76DZbbg1zn8yC3/hrPNE0MdNDc3Nx5Hc1xY8hDHhqL45n2ryZY30CtuCrvvBsq9Z79WCmTlJgWnZyYfpBbcO1bjIgHlRe/uPqOgTzXweY2Ix/XQUChUyGYa0CdvzmuP1Nu9PKrn6HruL6i/O4U/+7dZEt6tQswjPpObWC0Vk5AhB2yn5MzMArUWc4W41MX+BJQwUXa2ITnWVwA2B0E5zrCrx3gKSrzcVZhSziNuJGGlSPfemj+c5X68CraE39ECsArrnb4w3zNaZPIIuiz3yaINrooIp0V7iRGxh+T/oSW3uboUDmtNZwClRpgRKjlTxYv3G3NyGBJVgPjP4qulz/NE8FFvi7LyfPg7dAUxCGjkbtjQ5u/xTo+BLr9EbxKfzRPf7nJM1I4lZDeCqySe5yQgptZbVCju1u5ZVMgW+0lAzAr8sMNB35gdbJ/eRc8Ncdvtri68NNbjbg8Gla7Rh3WMeBY27c4HMoKWDwv37JLkfTIBWO5lWTpmVUmMuJjibEdyXFg4GAKr0byVPE1u2nvOsmQydjzZ+jWWJQFv87m8zXnDoWG/R7i3oNSkkfBA1SVBOcFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1aa76a-7a4b-41b8-91f8-08dc3c4bba5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:12.7744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRVpNkI1iQlHVBG/TSFjeV8ns/3p1cCuMPkAnxOcL+46c4DaV1EHqGhNoEj2kvjkUVGKEww7NIJKm8LpQpAfwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: EB1d-KFg5WCeZYecP-Rt73wVovmx94f4
X-Proofpoint-GUID: EB1d-KFg5WCeZYecP-Rt73wVovmx94f4

For FS_XFLAG_FORCEALIGN support, we want to treat any sub-extent IO like
sub-fsblock DIO, in that we will zero the sub-extent when the mapping is
unwritten.

This will be important for atomic writes support, in that atomically
writing over a partially written extent would mean that we would need to
do the unwritten extent conversion write separately, and the write could
no longer be atomic.

It is the task of the FS to set iomap.extent_shift per iter to indicate
sub-extent zeroing required.

Maybe a macro like i_blocksize() should be introduced for extent sizes,
instead of using extent_shift. It would also eliminate excessive use
of xfs_get_extss() for XFS in future.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c  | 14 ++++++++------
 include/linux/iomap.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..733f83f839b6 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -277,7 +277,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 {
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
-	unsigned int fs_block_size = i_blocksize(inode), pad;
+	unsigned int zeroing_size, pad;
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
@@ -288,6 +288,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
+	zeroing_size = i_blocksize(inode) << iomap->extent_shift;
+
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
@@ -354,8 +356,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		dio->iocb->ki_flags &= ~IOCB_HIPRI;
 
 	if (need_zeroout) {
-		/* zero out from the start of the block to the write offset */
-		pad = pos & (fs_block_size - 1);
+		/* zero out from the start of the region to the write offset */
+		pad = pos & (zeroing_size - 1);
 		if (pad)
 			iomap_dio_zero(iter, dio, pos - pad, pad);
 	}
@@ -427,10 +429,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 zero_tail:
 	if (need_zeroout ||
 	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
-		/* zero out from the end of the write to the end of the block */
-		pad = pos & (fs_block_size - 1);
+		/* zero out from the end of the write to the end of the region */
+		pad = pos & (zeroing_size - 1);
 		if (pad)
-			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
+			iomap_dio_zero(iter, dio, pos, zeroing_size - pad);
 	}
 out:
 	/* Undo iter limitation to current extent */
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 96dd0acbba44..89cd3dcbb8ec 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -97,6 +97,7 @@ struct iomap {
 	u64			length;	/* length of mapping, bytes */
 	u16			type;	/* type of mapping */
 	u16			flags;	/* flags for mapping */
+	unsigned int		extent_shift;
 	struct block_device	*bdev;	/* block device for I/O */
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
-- 
2.31.1


