Return-Path: <linux-fsdevel+bounces-13459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0206870217
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FD31F235E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717D23F9F4;
	Mon,  4 Mar 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vu7fOR60";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dllxCFHe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF23F8C2;
	Mon,  4 Mar 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557526; cv=fail; b=JIqFnRbOWhjnZA8R3BzVBxjPmv/SiXxyUzQOY1Ga/UuBOFPoqT6otCUv1Ksp6nunGdeZ4YjK7FRj6njnAWwfUss40YLnDiifOwpiRXVswP6Rt5itTDHHY6Ltle4lA1mnr0QRM4x7rs1OFVuJQgT4hZBNRh3mv0TBMVe4cULELZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557526; c=relaxed/simple;
	bh=e3IjOMW28UsyF9uyFHOK5GKgbk1jrJ/tuNVh5ARGYCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tainHZQq3KcxJMSFJoAQpPgiZ3pze+gUFBvS2zdX3p+z1QBpTMX1BNANDRFC1pT8ns7G3tw/+RWLVGpFt9ekFnjpfS0Uklsjne9m06IX/oPzr7LR9tE8XdLiXxPB1BO00AZdRl1qn3Bh04GibaVTKOPl8mkMr9pteQu1BvqoT3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vu7fOR60; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dllxCFHe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTmri027811;
	Mon, 4 Mar 2024 13:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=3YZGDt0LYatwH6pzKQoHiA1NOrwKq4u1DnTw9iQzDeI=;
 b=Vu7fOR60zK2Lur5SMTEfjDbwrMgbbXT4qZo1dn1W5YuHvDaot1e7jAPpEiLwBl/3a0HO
 bhEHFPWHZIoYvlDrdFwoq8MYwzIWEpaNKbyki/d7Es0ItiUdK7y+UTlqcAjbfNXR6DL9
 3VUcDEC/wCX+mbabKY5+TFClchz6v1MG+EdKgZDiT82Dja9CI1O32USI0/oW6Lx8nOoe
 noIQa3sJRZI2OhLIlhSB38hob+Wq2PYn1o25szPD7qoelAVSy8ZaLP51Jg9E8HOGeIWJ
 GFG94zcqGuCkSTZeqeYfWA4t7bDty4//QNVJgETRQ4OqWXB7+40JPVNPu3GjI4+ob499 YA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq23hm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424D4Bdi016956;
	Mon, 4 Mar 2024 13:05:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5qp0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0M0y8A88teFpNxdMxs1XXr3cKXj5QwGTvrLm0niVrkfFSgMoWsFjxZi0jUO8MjoymIgNF3LT21qYc1GD5slqvUc48Cmt4gmDM4VF8etDFv1C+d/rCotGU/elHziK5A06xu+gzKtaOuIkSswTbrwTJv2jg48XgXhsuhWLew05RvQeCZutFWmMm4obtjDUlIol9rh7bJi+Px0Ui/X6enOGuCVM7nN0V7o74HCj4uYJjhJlDSg1NI6FF58jQSRtjIIS9UbGJy3JfzaFWMKOGr5NoKlfhXO5k0cKvrgfYqJ6WXrGlUfKrn9fn4flLjnbN1s3w3yfDrt4IBfNR27CbEFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YZGDt0LYatwH6pzKQoHiA1NOrwKq4u1DnTw9iQzDeI=;
 b=PRsbOsjzUED2aajMKQl/KFiBpwLbq0A4LUNmP7c8jGZa5Vqqf5egqqob3JWy7VEbe4EpERrGCn5N/bdiK/U3XFTohD+oi4eZlYLu3z2sTc9l7ddOIwEq5oD5fZsl51nzN4Y4HRVNTccTJv11noIuFw9uCtz5kfze9Q3nPmOR5FspaoFiwf9yGsvVpcZ43UC324ItmLyPym15qWifTMOpTdCKp/CL0LGNImJ7ppZQDmXUndeciEme/I153dGlCbai8eZNSiEtl0fZxWOqOdPRsItFu77rJb2Izk4uonDNBL7SWAXfxFmglBOQyeov/3KAFBtX9CeLKskWgS1U+Y8dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YZGDt0LYatwH6pzKQoHiA1NOrwKq4u1DnTw9iQzDeI=;
 b=dllxCFHea/+FN4E8GybMPpVV/FNZ5ZtBAvvy6Uaoijr2aTIjbMtqaCF3Mdl3HGYKsJ2Fgggs0BCtSfuk3kKD4a+sZ39aEk9920xbEEjWnj9j8UOS3S8tv1/9WfRFTRSoc/0b3z+3+QDeWaevzrVYGk3b2XjMQDC7TunL5O6ZJO8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:05:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 03/14] fs: xfs: Introduce FORCEALIGN inode flag
Date: Mon,  4 Mar 2024 13:04:17 +0000
Message-Id: <20240304130428.13026-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b37dbc-3fde-493a-e5b7-08dc3c4bb4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6msHmaJtJH5ss47wL6j5FnP7LZZyr0B01Mzo55F9pSYp6kpENK2Fq5BmPeWgHiaXdz6B/M4nzre26cHuOh3krjSULLUEOLAIcHx2F7unLnh0PCusaylRuSgSDCFg+8mlLkWLfm8wjUI8NmQzh1GcIBi2WLPuRNkK+UvREGfoZbFZKrUDHAAOjJlpoJzv/DKn0kF82O41xmShmQT2vqcTxbdCly9e/DGAAQ/R0ywwnObiiXv3o9NeaJVUlp3odme9llPgG9Z910++bd2EF/6NDWKFVIRqfSmohA2zzGy+403ng6RT7Oqw6otOfcomdJTegfPHmcggozqMPrtQgQbRe97CSNpIotaYMEM4s34tu7PpLcl2Wiwojf8KLoI7nXYt0wozPIn1M4Zf2D9akigjJvzJ1/1DvhFku6h+T1aftXH7Oog86nlS2YNdSNDSVK6TQqiHWSKZi4YgzGpGHyMhwMDkRpnSZEd1TrvezGtT/qpdh5jHCqtPArc+jX+xUfDSdTZRncWTlCrzpww9WtG7nH/SAdn/7nrRjCUBCuWw+YAbRMiV73ZB+4tQUKo/D6g/LTHwJQfYy6y9zOaOPTlPOHR+x6vrHyROm0bp1E9x/guSiWfRqIMLq+t4Z9voyxQYXmIH+KQfpEvsTVsPgfL4e0uBe+RrdXw5bbGC2NIrKuM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IFHMPZIx/Uzb8oK65BooqouppkFKURWT9T6wO3ypKGzcQwhFA8fu4e3sVZOU?=
 =?us-ascii?Q?XmYBe8Sc5FT0WjP32cN3vhxFPNBlW1ZxbVYbd+2oHA3ngT0EWsxBQOjehRrU?=
 =?us-ascii?Q?o3YDOx2pkvKRasp3pxBcFq4TBwnEYMQckEboeDy/jxUCdW2fsE57E9+CUaL0?=
 =?us-ascii?Q?QoPy2oiLrB0MkxSN+EEtTTHKvm5szzZ0tD3KNUvklA9UqexM5S9Kv/SyKaGm?=
 =?us-ascii?Q?vyEDkdjfP26HhRrZoxh+4A3oue+F5ag4BNLJV/CAfBSWRZzZG/Y9Z1TtK1bE?=
 =?us-ascii?Q?W/hSQA37kxo7TDSeubQhOQXbK3OBphISY50j71f8Qd2t2VwMXtXz1HOrDGUu?=
 =?us-ascii?Q?R3ls/6vlfNvqgMMCfAaTDq7oQ4B1yYTzdEoLbqqLxwi7S4fFnZ/yhuZer6FE?=
 =?us-ascii?Q?xfZJZvyaor38rV3vYCPn04p/1WF/+fwxs/a0Dd0mG8Jtl5xs5RuP/idTC1l6?=
 =?us-ascii?Q?JhQE42oVDvA+hMeL368jNIXfDsXS1VbdFNJGhDJaZo2WOQsBiVkppsBLD7bq?=
 =?us-ascii?Q?ft0F8tDjunLhGvucJl2blLqMv0jM1npuvusUpu9ze5Cd8+Hv2dQMCskuSrsS?=
 =?us-ascii?Q?xSKmiFFEbKOSNhopxgAttzl7TSeHiIEde9fPUV1v+wXvZLyIl6U9CeeFfTfK?=
 =?us-ascii?Q?+6TogX9U/D1cYoNCg3+oI+Ffg0htKlw7nJwxdQZKS23h+oRyF/oq1a31RbtM?=
 =?us-ascii?Q?pRba4fkvN2/hU0hCIcTWqoUmGbpA8p+04puo0IAXl/NOLHTUYSkHPjIvNJ+Q?=
 =?us-ascii?Q?Bum1orJDcU5M9a1EH8RPugbkL50VrpuTI2y8TkmVgKRjHB+5wzOsNjbL9o5O?=
 =?us-ascii?Q?G0BpUvzh9375jbyj2a01eQuqlt9OgdBJkbqh+5i19IFdVO7Dhk0XweJXU2Jq?=
 =?us-ascii?Q?VZ9bowG8jWYd8yYDVXlWYudC8xJcxcmLzFeXZheNGPqRHl5I60snv9E+1Zy6?=
 =?us-ascii?Q?kfg1ijLo/Cuj+8zSL60jeYhcalr+UcND/pSAoCVu0weB20n6iv/zbuJChKve?=
 =?us-ascii?Q?ef5dymA6Kx9iu4WfvmLKSlSas538vRVqE+ohK7gbI52jW8wHGC4ZxW/9ZpIv?=
 =?us-ascii?Q?xDWWt7WNnjgZoPeWb1LdCyQTseXvgnOdPKqdWMjTwkYLcQrr0Rx3gagLknz1?=
 =?us-ascii?Q?DlD9V64/jtleYNzseiyNS/UOmgpqm3/hHRP03ACvUQI6s5KKapUZ2MTqCnvK?=
 =?us-ascii?Q?ElctCaSRFQzeV7MOi+yg/+HD4c1mDFSRGbRwmte/fz1RoWKp5jnR4Ke3HffS?=
 =?us-ascii?Q?Ok5GGXlsOXX5gjkDL5bQgvJezdxPe9NgKOUEuPCo4n91XJnheSgwvYqD+vqu?=
 =?us-ascii?Q?9kO5kIc3TD6czcgO+EThBc1+aNj9ZuRnQa427cHCAEwtVHbZVl3Oq4viPbpd?=
 =?us-ascii?Q?6kp1t188QeJLMn3ko0zZqoabfGgrEYlQptInSn3miLAzpWE6m8jwyUQSL+ow?=
 =?us-ascii?Q?mIN0bFeJVSf7GYkHEp9uYBiQzdbLud2vHWAd8U7ldsz0VdsZtK3ScCMhhw8L?=
 =?us-ascii?Q?PIGWmnA6stulfBrNuJaAZigVPmlZmw3YmRQg1oLB0omunUCx2AqfdrhWe9Rs?=
 =?us-ascii?Q?lmD+++v79x/bshESs7uvHbx1lg54d1+FSMGiyQduzJY74u/ac/ogUTgqf4ah?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kS/eGcUyiOFUPcnfxjw23ppS8tTF4PW+yt+jQz0V9krrqkOKvAEFre5r1ujclLwep/jUWb2RPKZ3uXs/zqqaxZi6t5hMxjVEqvB8Mdfu28WAjzLoENdiCOjBmUShKmy5iRGg682b4zO3fN8Fg4SsGIvnehKpwo7rqpYk99N6JsFLcT1tw6HQzXkRzCd+mQLU3Y6jT1mZIg/nLxQdlia6p9YVafq2g5X9zwbVBX5dCfyAH6EcR5NFm7taBT4xcr4ND4UOUcW59ic7akX4uHtoQdxUupRGRlqYlbt2wDZYEe3NawZf43BvpW6ppq23IsRa/Vvu72pIXP2cm9gZvl+kI0ZNaX7g6HCrhyE6CL56sdjj5WnCkvHkeiHGLqO8nbowBmq3icyN4vOTHLIkW7O3xgaG6WPDbsuG/lursLS1Z22rQHV856Fa0gWod6aN+PWOOeR0Nfmgxai/7MkIRuieCXbrLkU0MCLjxPkNukn2LsI0VtbScJJ9nu1720MyB2mJm2s5zASObNvi7Mjd16M/8xyq1HNz4GHsnJqIiXJ6lmZcRjveKXW3yFTCoqIgKCRdrNLljvtHAnCXZthvbRnQnPVZSIZxMW1Qyn6IvpEmDtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b37dbc-3fde-493a-e5b7-08dc3c4bb4e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:03.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjRa9A3vdlQMoLnL4gRWLqCubEgYR9Gfd9oH4x4S4+3RveXshgJzWkWB8+RncjnBybHF40WzAzoNXXENm33rdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403040098
X-Proofpoint-GUID: tDut_4mDIWwcWb_bGguVuzstPeylxUDW
X-Proofpoint-ORIG-GUID: tDut_4mDIWwcWb_bGguVuzstPeylxUDW

From: "Darrick J. Wong" <djwong@kernel.org>

Add a new inode flag to require that all file data extent mappings must
be aligned (both the file offset range and the allocated space itself)
to the extent size hint.  Having a separate COW extent size hint is no
longer allowed.

The goal here is to enable sysadmins and users to mandate that all space
mappings in a file must have a startoff/blockcount that are aligned to
(say) a 2MB alignment and that the startblock/blockcount will follow the
same alignment.

jpg: Enforce extsize is a power-of-2 for forcealign
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Co-developed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h    |  6 +++++-
 fs/xfs/libxfs/xfs_inode_buf.c | 40 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h |  3 +++
 fs/xfs/libxfs/xfs_sb.c        |  2 ++
 fs/xfs/xfs_inode.c            | 12 +++++++++++
 fs/xfs/xfs_inode.h            |  5 +++++
 fs/xfs/xfs_ioctl.c            | 34 ++++++++++++++++++++++++++++-
 fs/xfs/xfs_mount.h            |  2 ++
 fs/xfs/xfs_super.c            |  4 ++++
 include/uapi/linux/fs.h       |  2 ++
 10 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 382ab1e71c0b..db2113cf6e47 100644
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
@@ -1085,16 +1086,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
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
index 137a65bda95d..61cc12cd54db 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -610,6 +610,14 @@ xfs_dinode_verify(
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
 
@@ -777,3 +785,35 @@ xfs_inode_validate_cowextsize(
 
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
+	if (extsize == 0 || !is_power_of_2(extsize))
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
index 5bb6e2bd6dee..f2c16a028fae 100644
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
index 1fd94958aa97..2c439df8c47f 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -629,6 +629,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+			flags |= FS_XFLAG_FORCEALIGN;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
@@ -758,6 +760,8 @@ xfs_inode_inherit_flags2(
 	}
 	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
 		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
+	if (pip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+		ip->i_diflags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	/* Don't let invalid cowextsize hints propagate. */
 	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
@@ -766,6 +770,14 @@ xfs_inode_inherit_flags2(
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
index 97f63bacd4c2..82e2838f6d64 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -305,6 +305,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
 }
 
+static inline bool xfs_inode_forcealign(struct xfs_inode *ip)
+{
+	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
+}
+
 /*
  * Return the buftarg used for data allocations on a given inode.
  */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index f02b6e558af5..867d8d51a3d0 100644
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
index 503fe3c7edbf..e1ef31675db3 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -289,6 +289,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
+#define XFS_FEAT_FORCEALIGN	(1ULL << 27)	/* aligned file data extents */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -352,6 +353,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
 __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
+__XFS_HAS_FEAT(forcealign, FORCEALIGN)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5a2512d20bd0..74dcafddf6a9 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1708,6 +1708,10 @@ xfs_fs_fill_super(
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
index a0975ae81e64..8828822331bf 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -140,6 +140,8 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define FS_XFLAG_FORCEALIGN	0x00020000
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1


