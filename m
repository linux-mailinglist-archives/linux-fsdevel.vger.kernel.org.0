Return-Path: <linux-fsdevel+bounces-13456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1570870209
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F611C21A10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC713D97F;
	Mon,  4 Mar 2024 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9HexoR/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dE/tMhJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57DA3D0D0;
	Mon,  4 Mar 2024 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557520; cv=fail; b=orgTNcRHLlvkmWoK5NS9vCJxys79HVgIG9LPfeQDBIQUroR41Q/ceqoj3FHZB0iGiLar7PxDk3cgKqWU3nzHMMl8Pj8oGz/pNoilTHbAlTdGepknp5+fwSzTDYFIEEkVosHLVhJpvy4loMSB7xMpoRM1UEhZIa9C4F99a1QJa38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557520; c=relaxed/simple;
	bh=kg6NRoqxNLVM6IMVaHZ5Llfi+kjJD4m8ovf/ZKVafO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sM/jaDm9gVYibrRfr5lJchXM5dRHCZZ3INuB4vfZOY4F5pcoyq2ll0vLnR6UnjnpQRCOv9IRuL/Al7zHo6JFgJcaI9kCUAHm9P3IxOBp83ZmOAf904h+DNs97RBTM58b2yWijCRVBiWwd0nVO3UEsOLkO6mMTwo7kJ1VyNI8vgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i9HexoR/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dE/tMhJB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BSwUm028411;
	Mon, 4 Mar 2024 13:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=/3dtfupMQiitSmriS3Cj0CEAIIiC9u1xWU9cMCtrYtg=;
 b=i9HexoR/fW8PwJ75VoqkUA2+RO4lk9UVb0OGLO1UAjoQa/fQLCePKr3lmak/uKFLYfqI
 WGm5JZwLTDZpNoncLQnUnX3NVUsXMAaYb8yH+ioCQx8ywOP8WyRn2fdP84fAOliXSIJH
 +Jfs12/s60LjbCsESLBeu92BpI/1dKMqa0Q0NJyZkloo9Adj46xpS5KaYPM7+z3ToFdU
 Nk1qhGWIHpoaVuX1Cw+HtJ0a1J2P/N4o1px0WofuA624JT2F5eDziC/+s2Of0sHAcdrZ
 szLy6fiqCC2OGdfukIfVfdAOP8nnz0OUvp4aJQPyt6sMu5vbRuybmKnL0vYlHGHxDXXG 4w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw43d3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424CwCFq017481;
	Mon, 4 Mar 2024 13:05:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj608ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgEWxucqCc8mxmPQctWVyB5y5RnHbHrYANr5zRmb4Cswm3GhbmjnxmJrvVKnHt5QdVFS0P6o9N+8Ne5mS8m/3ScgAxGkbKIiVi012CaAe7iUNuR3UJ932Df6S51R133vo1Ytns9OMh3I+z45azpuNC5c3rIHW+4DPkX/UI6ljo8oD4B6rLgdKsmRafjB5y58M1y0LAFelt92flKrqHDzaKtp8XBvsvVxGGhKk3zeGKi14CoCoW+u5orU6zSNoVXZt/QN55D3in2/V8hN4DL3W0SHavuZOO6OgK039aKvxJhGWK0MPdrxw7WxJkxXfoO+qQP/cZAFWfsjD2lLTOmheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3dtfupMQiitSmriS3Cj0CEAIIiC9u1xWU9cMCtrYtg=;
 b=I8pmw6lIH3RDe0JafYVsqOhSBVzqSOvZFqqiMUx94l1mQ/vwVoYhte/LydYXv7/lEpRcc0KqeV0g2imYEcF5vlcAXoh9FLCxM1wyVFn9/j34Kc8CqOGzAXxWvMAPUfPr4pdwTtly71z2bueMwri9bctHHw2anpIU9QZmqR1i5V49z4QtvK9xn0OsFn4ICaV4eXRbfVlJdnLcTcE9dHl4O0etRlhZVoWrs3DayFD73mA5z5YmVZXBUJ4gP7eWF5xyObaocGKiblysGILvab7rALPJB7+xj33pTCWW7gfg3PQJ2MYcVC/4VGrB/cu8MTlo4uY8xVFJznVwWsf+o1ICsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3dtfupMQiitSmriS3Cj0CEAIIiC9u1xWU9cMCtrYtg=;
 b=dE/tMhJBgbTBTZYEBlWV1yzUI1AOEjm7WKRjMqGaFHGKHIzWtaXbf/6daTorz8Wfvk48bYdSN3ml0EvmwsUAfAqqmi4S/q5poQEF29vPuB0+LQx7ShG4zUqzmMJlABQPf8hkpvVGHHZHYAZ5l74OaC3KMgKej7bzJewh3Op5m7k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:04:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:04:59 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 01/14] block: Add blk_validate_atomic_write_op_size()
Date: Mon,  4 Mar 2024 13:04:15 +0000
Message-Id: <20240304130428.13026-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: d0336fd0-8520-42c8-abfc-08dc3c4bb23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CEAi9rC2Wg0pDfqAYq99Am4B6QLQ7QGZYYyBbK7B5ElHFMENvjp7GG2CVEFziKbTgWR5QVUBibJjaQ5XVGId12/94gXJJxgEHfxJ7PBu9CzdYh71Nmdqon9BFHsSSvl2Dx8zGjC3I4IQToy5erwKPbaBboMzSVU8VkPPaZ9YNef3Qz3lKoejt70UgBzWGn3D8RdstRiqAjqjTXhxUN25+TACxCxQfycR7fBL12F9bcsLqQIzdKV/mltiR6CNvuysF7N6zo2+UXKY4AFNYgJpQXmc3fpJReWYTCxdpm4YgW3oy+RlLECFFf8QpBmyg8koc8ob18AZ+hIEu2b7DJXkFz0sDo9WakooEgZVDVB/7CIgULeRs1RA/e09buwyjReKfYp2TMp5hplYryyOIi/AreLo7tKE1NHGKlX6fIc1Kdvw8/fpC793MrJMn0jzGxg95UAqFZRTFM7HdkZTT+O+V+K0/S4PRqtJVlM6E6Zo6N+HnF+oX3JD836ZL9V5QPGICoFAiJKqvuo576AR6Z440/I5GT5CuW5RjE6mFiv35+sBSBq1ZGo2Lw6BZbBsWNN4PLC77fttzbTzAaOrig5WDxb1x+N+RJHB8Imu5n59+PdGZgtPwke47OAG/KBztxgYT787ewwTlj3y39h1T3aN429oV4ymLd870kSz7aiNIQo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qmRdVzB5+GTiuwQAbu1kl7iQcBP6yTryBKebuWRt5RgJ0p3RqHDcrSeoaA1P?=
 =?us-ascii?Q?riwaPVM3GvrkOp07QA2d34qNvEcLPJsGJUW85gbvY2Ej89N1unZ7Im4kvKNJ?=
 =?us-ascii?Q?suXKrmk2UXXyVCFHLgJLFzATuVvJpEn4sVStRoUtopEIBhkcNrz6V/J8cA+E?=
 =?us-ascii?Q?F7WnH9LVpf8P1Z8nvcR9oGI0cKIXu9pHR0sObsQiYSP/Urwp1OxNnv8f4+nx?=
 =?us-ascii?Q?PtisGVasrMm1G6Cqc+eVh9VmRvJLMqbH1Jl8/xD7oEBDcWVy1KvpqydMn4nn?=
 =?us-ascii?Q?elWLwnt+qw3UCXNjwy/u4VpfyEB1MrVHsmUaX5UcMZwhHs0XvV2XXKUH/p6F?=
 =?us-ascii?Q?qCV8iJvSLhAv6feGK1qKJado4pB013SuxphvCElmxMN0t1gBSey3fLLXoCMp?=
 =?us-ascii?Q?YGBSANP7YVHFnLtbplWvYa0PtPFXpgymiUF3Yxcz1KJtMbhKtVaqiNxB9ArQ?=
 =?us-ascii?Q?M5ohMWgDqWD8jHgJRhPrK3v+YG/H08rZu2bYUc+Hdr0bk9DzpXoxG4gCe7m3?=
 =?us-ascii?Q?PlWY7fM1GElW7E+qL0O45JeMSNE9pUgsNSEsbOVEwvZgNIp+mz6R+3B84M1H?=
 =?us-ascii?Q?HPc7SjOnTL7tW6i8Mb16aL6C8E09pnKG1MmhpknhLUWi7FRWHfgCkx9a7uCH?=
 =?us-ascii?Q?SapA4S5muMMVCIpxvAgs5901MHdEsQQXwKldSEjVWKnfTKNciBj8tB9OGgZh?=
 =?us-ascii?Q?pXOm4bfetI0MauiXvnU7S7nwvmy7hmHkqkG1W0ZuxkfYl6mqpJONisP2ai2e?=
 =?us-ascii?Q?9keV0uATsPun30TafupPenNPQcK7Nb56Ee2VwDaI5VmaN9w6Bod9jCNyMc3n?=
 =?us-ascii?Q?3ouFTDgfRHDgfSnIfBfZcB4SG/JvRxPo8V6Kc0AxiF/sZYhiL0z+PhPUvZBd?=
 =?us-ascii?Q?18Yq0uG6LznSYv3weOnSIBvVoiTjkQOkj5SdKgl/o5CGHN6WDS3Ww63EXZSi?=
 =?us-ascii?Q?6uslzGm1LdDtCDIyodh7ivvyGQdjuZxyxNLl+Yr1Kmgbh1JTJGIADD1gwFYi?=
 =?us-ascii?Q?a3CW7I0vP2l0s4w2b1Vm9gTNk+eBWBtsMyVhv9TisNIe8U8h9/4iQEUzsW+h?=
 =?us-ascii?Q?nCFFBNLyYlwBQjyB6xG/8uvoPWLKJtPl2E6u93IzocoC1LUzr3mFbL/u0Pnf?=
 =?us-ascii?Q?j77zVABmnRiwG6GUBUcqPVVNyNMw4RdhQssck5lJQq6gsNv6mAWwUMs6Gh+r?=
 =?us-ascii?Q?KhrTndWKzfew/2+JQoneE6SyTFlcWt8LwDiYO8TgcTeVr1RRNo748+2nr5Qc?=
 =?us-ascii?Q?S3kalLhEv4ghyFrfz2iIscQLI/f51GWHe/uem8+ZJJsuzjcgN6KY0jyQ0+L4?=
 =?us-ascii?Q?l8aHNGr7V5E20Jrj9vdf2du/zMqxzXYF0RBMoPT+r5daOu/WzPvwor5czEI3?=
 =?us-ascii?Q?tKb6CEH3iqctxlqdWi9ziCsDNSeYV3f+JMsBjCu7mRAeZmMcKaE7++LbQDh0?=
 =?us-ascii?Q?DO3qgXL7CLJnbKzsEsPgwA7dE6Ucjk6VJ0wrJmwfFOlEu5P1sL/jZS9lLMrt?=
 =?us-ascii?Q?OzIT8vF8Py7sBPShhpEtOqSMksxrXE9lfwQJv0fjHCloh6qPZikpBBIqKzfb?=
 =?us-ascii?Q?XoXyy6Y1CTtHfqY2/IJ3CoSbIdVbdd6O3aiP9tuAWuzhyx+GpaV/scL4jIGj?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1KsM/pfoMMQ1YAU5HrIgJEgXWgZvySZahXpYR/5eFA4htoSkskrFhW8x6LdIX4YgVg7DIv04NW3QSAD557TxZ6tFy0szcJihsv1HuSnbD7bsuZxq4L3k8YtfLGEIua721oZmDVY8JwRxBmayeRbOhc914SCje19kX10hHUs18ES9eQ6C0ouTwzFeR5XuIFDQ0WDG4iSKJTyPiIN+MitAkyPPSp4RyBpk6MoPjlSp6457rI6SctCGeP3SSCeF3jYR3TOEEDeubKA5n9dbNxCidwp9DAguYEZ6JczQvjucrnQyCt6DaW17vlR6qRuWnKr83HyK2rMAyRbZaK11/rgMEb9oxEZ6BUEyEZ2YCz8WLvv/bqzKBFXsDspb/WL5ao1ne8Ff1rHeFXlyP4kun/iMVFtX9PDH/sfL6g4VsxHhyvFliPQ3DAT6ToUab2Z/WNCAuuz0/MHXIXb/v61dFPR94hsw4K7yviyBskiPM+cH7bbJX35vpUCpox/UPh3sPuc2x/tA5hUjQBdjnDmkTIP3ZuSgOa8YQsdh/lcI2xsTmGhykSMyOv7hcn8ykZkTYEYQyvJOFeeaqdyDKvpDlG918kH/yZJb3ZFBkIZrj8Jb0Ac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0336fd0-8520-42c8-abfc-08dc3c4bb23b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:04:59.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWRKpbeK4miKi8zBCzSe8nI0bM3qXune/iB8rVnVFN3dzuCHSy3ZfSgyzytWBlR2c/oCkIbFqi2zQihTzxuLOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: uTh6u7jxwOYZ-1FznCV6dr2E4lXq1BD1
X-Proofpoint-GUID: uTh6u7jxwOYZ-1FznCV6dr2E4lXq1BD1

FSes will not check if the BIO submitted for an atomic write adheres to the
request_queue limits, so check in the BIO submission path.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
We really should return -EINVAL to userspce, so can be have BLK_STS_INVAL
or similar?
 block/blk-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index de771093b526..a1b095a68498 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -718,6 +718,18 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 		__submit_bio_noacct(bio);
 }
 
+static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
+						 struct bio *bio)
+{
+	if (bio->bi_iter.bi_size > queue_atomic_write_unit_max_bytes(q))
+		return BLK_STS_IOERR;
+
+	if (bio->bi_iter.bi_size % queue_atomic_write_unit_min_bytes(q))
+		return BLK_STS_IOERR;
+
+	return BLK_STS_OK;
+}
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -775,6 +787,11 @@ void submit_bio_noacct(struct bio *bio)
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
+		if (bio->bi_opf & REQ_ATOMIC) {
+			status = blk_validate_atomic_write_op_size(q, bio);
+			if (status != BLK_STS_OK)
+				goto end_io;
+		}
 		break;
 	case REQ_OP_FLUSH:
 		/*
-- 
2.31.1


