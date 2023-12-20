Return-Path: <linux-fsdevel+bounces-6589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6CE81A10B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 15:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6AC1C2307C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA738DEA;
	Wed, 20 Dec 2023 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ft7nst+k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I4uzALpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3839865;
	Wed, 20 Dec 2023 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BK9RaRY006862;
	Wed, 20 Dec 2023 14:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=1P3EA4YnzaioakQ2xzjQZrZ3qjYKvFXIbAbofPorQSQ=;
 b=ft7nst+ka1UCxq8wDgjcNX4kvg2yc96leDDoOV/a/fvlbECwFqifusSP9aXAxH7X8YQZ
 y+p7ZRHrDxIy6rWuktD4zf0HCGW4h3ZNqB9O5ARbfarWZgL2dNC4/Yr9gyMuGXnrAATn
 WaH0rWDy9y9FqLzS2lyWtSss2tiyIhobDx4kNxcdComh3GkRhwY0dgp4mY5zFJmNxQej
 4kE/dcKGcYtyVqsxwXpItJTHfP9320x+o+agbizc6NoGKQQWs30SU9lOxOL72hxbEh3Z
 luG/1jkAV2GaKH4OcqNnZzWKiVkoFfOAb+lZ+WWlPf7ofFaMdpRXDIX8QSkzz8sGZqKw Lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12g2ghk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 14:23:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKDX1F1000592;
	Wed, 20 Dec 2023 14:23:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bephxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 14:23:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBvJfp5oBc5rfFzLtE8WdCQ5PPLCqjZBNd2DEgghek53DpU0PaPAUsnZBjfBqo+jZ/PGVmaYmRW3UOdLn2GocnCQQp8QMq7WNT6sjq+s8BZXMqSazBgtWevtFbsojlhyumg/zWtoC7I0V2Tg8V5rkTd6rV6hNtvj8AHiV6K8PiMEAyNW8+Pky++TYswDO7OieexDnTEdlVcqztNftUgo9MGX2lKNhiSi6JjeCcs6YrJrNnD9I+mdtSF+RUm8o8IdPUE//ZxNWgsx69FF63ZaIDMKCuWWnRBOdoo0QZqrXxS8+GEs9g6DYz4/SrWD0nxTkubf/4R/Lp5FQoZF3yOBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P3EA4YnzaioakQ2xzjQZrZ3qjYKvFXIbAbofPorQSQ=;
 b=GCMa75ini9YRMpSjgiUumtgMMjgRgZVmZinqqiLkMqtw60MZbkrUr4cwN7MBaXPS0HuLKqFmwun5X5UjwR4bGE+76AttKoykQMJWAit2vd/OKm0S/kNzSaXPd2v4c6Zc0I5fCbDnskg+4Dxaog2VNs9zyi5tsZT4JodshJLmSb6idzj/SDEaKgzUa49yDQ8H501q2o6e5US8G3/+OUtKxX7Aam0pz1EfjIx9XW2nH9kD9HhJeFZTMBFiuPPkjTilR45rmQ2nPJJAFG8OAWUJEOVaFAesoILDk8/LCaM25gvpJa+Hzxl6iUowd0lFASwJCQZLQyeCmion2zyaoSL93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P3EA4YnzaioakQ2xzjQZrZ3qjYKvFXIbAbofPorQSQ=;
 b=I4uzALpMKduNfSEaKp11MhUC/L7BCly5ZDrthBX8X1GZwhK+aIHhDJYCCkPATOMsB2viZME90sM2h2tH3O1R2BJpymtmDykz//UnLSdNMeqAribWLbNQn+eVvDUJGYANmdZyd9XmSdRqLCB9Vsc11p8aDBXiRryyJfwmCx2NbL0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 14:23:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 14:23:02 +0000
Date: Wed, 20 Dec 2023 09:22:59 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 18/22] nfsd: kill stale comment about simple_fill_super()
 requirements
Message-ID: <ZYL4w7Mk3ahkK8eI@tissot.1015granger.net>
References: <20231220051348.GY1674809@ZenIV>
 <20231220053013.GQ1674809@ZenIV>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220053013.GQ1674809@ZenIV>
X-ClientProxiedBy: CH0PR03CA0440.namprd03.prod.outlook.com
 (2603:10b6:610:10e::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6c4502-ee9a-45a5-f675-08dc01672cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E4q4B4Nv/V1A10VN/iwv9eejGV1dUuIOwbPTFGT9yxMRZmsAOSgaEJMK9Ji1Mlnsu/V/CUeKrHXEASrSUez196510Roc2bML8JT0IrMPZX8IhlxWxHaJ4U1CjjPVIGCvJ6R6P7AT6fhev39VTL35FEIV74SF85A81qST/SRkelFM3xS8UJ8E+e9PSRAujj1a/IrcRsCGkDrRRI5CKkLzL0WmPRtQlFCGRuilcfLv5WaM/oStm5KuR7V5te+MNmfD5QZBkbnV+00DnmVoAhdw6tM9rHypkh25tTKQNwWIT7HVNv9/Aob+azVXs8E1B+nHb+QWKXHOjm3dluB8co6z/1Q7xv12B9ht7xr4smRGz5jbDN0LYQwf77wGY1P6Mi0I7yvTzg3lDCQltzbQ6ZKnzfE5h4TFp01FgGYkYWvxgGAkuzWwNEUkqE8h7dOSldwwj5wOhWuCnQsyG2XBjnA1gpUqbMyTicQxQ/gJmnd6HLVqSkDCVQYuNF4OSAXCwayVpHkXjkF8HGZ7SYx2V+RjJgzuWZqdfszs3yjPEiY6ISTU1X7QWibveM8JFn/Gv3J+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(41300700001)(86362001)(38100700002)(6666004)(6916009)(66476007)(6506007)(6512007)(8936002)(6486002)(8676002)(66946007)(66556008)(4326008)(9686003)(5660300002)(26005)(83380400001)(44832011)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5nJ2ToPFk1Q00NALCrhDytgKwcZwfJad2hIO2CtgXgdyRR8mqDDZKAq3BkMv?=
 =?us-ascii?Q?UDIiiMUKWWrP9BR+BsraPbmSlNAK2/PABaH1BQSifXE7DNtFEN99MAWBCjF4?=
 =?us-ascii?Q?CftirjdLEgb57/symU0Duxfp1pHtHyJFTDGrMYlzfNxaZK89lfsVhPp1JWne?=
 =?us-ascii?Q?nw8Uv5jFYA73Qh4p2m2CZ04CY5p9YpoXXiKS6QUKZIMbPRTQByNLaXEL97wK?=
 =?us-ascii?Q?Jo7IQLaQMhqwp4+KZMd8ThPs4KJSvrRtYXyGphjRsSqkGiktNl+mui/yDyyR?=
 =?us-ascii?Q?jbxctTPhoez19O/thnKZubGSnZmknPf5tN74vlnhquLea9OyLqm9gvd1MSrT?=
 =?us-ascii?Q?yy9CZkhTktGhf/mEpZhLsFQFkyIaLG08SmK/f8kYbsHVKtuuy/feuc5S7Tig?=
 =?us-ascii?Q?9j3vvk0SCWtJA3P0hNIjvIR6vZcAnu6KhBTOPKCOKnOPFG3JrQOPbCnsAnuL?=
 =?us-ascii?Q?BFCHpLJyKwHe71LbRD+uSo2rmXKR2wQidF8dcv6FqzjR2/TW7LpAZPiefjVT?=
 =?us-ascii?Q?eEH9h8YIjxKvZ8ECnVc1n5q8QPMfmu0I8MRBa2XJKdkC3VgTGs5mdhM7naoD?=
 =?us-ascii?Q?WFQRlTWh6Bl6uriifhwoqyEf6Pu7CPkQaUqLwWb1l50aiwX09Tm8i4mIRXL4?=
 =?us-ascii?Q?8vVZycahP8sF8uMBEw6bGn1+UqK94NKur+oB4grBi16XiSAFyEHswwMNIPjt?=
 =?us-ascii?Q?Xjj0H7lOlblxk+ALSqrmeNArU2+Ue5eVB0ceAOXrnMAcpVMN3RHlHj7vvqI2?=
 =?us-ascii?Q?N3YSjG5Vh9rw5gD98bsrN7Qz5Yua9LSI5t4J7EFX+9j7k3nQvT10HuUHnSKS?=
 =?us-ascii?Q?Zyvbg2UuTD5uXOWYpcxzdEfpT2YbrFnLa6oTl26+kjoxpQt6ctfWA1oVZDmv?=
 =?us-ascii?Q?GRwH+XHNm6ZGNR1NzDASZI8tfIltC0LoCmyo9+OrjVqybDhr8tgP+O2I8xIh?=
 =?us-ascii?Q?USHekisYjFw2dvISTg5COlRqFWPrB1Pw23xdt4tSZaqE4EIh2+wW0v6Ykwi3?=
 =?us-ascii?Q?voIuHUXWKnuej0OtqBrZ9goe76+Jw+L5vkcWAQNeLzfCFtUfQue3F4+shWeg?=
 =?us-ascii?Q?1RwPvNaovIChmoj/YX8j7ea74z3gTuvWMrSL8CT3vGCeT1eojUAW3PL+twLa?=
 =?us-ascii?Q?cV65ytjVry/1bvH5/SHNSqHpgTYQ2esVVq3CBc3CQbbpE5UvnHXZw7Jsymu2?=
 =?us-ascii?Q?R2y7zHSUR72i5XwgWrk24tg4bkdMwzAeT18A7oSnsd8hJZcGuFNe1w3+raYK?=
 =?us-ascii?Q?NCgibyQnLnsaHAkPWRjGgH48qSLjCpFeKDuZAfMkaJsNkuZdnau19dEZVuG3?=
 =?us-ascii?Q?hZooq1Zt6P/ER0mpybzh7NqC9zSXpycDVZ0Xkeg0yEwqxFls4V4dS6kozTrN?=
 =?us-ascii?Q?Gx6Ts6n6nfq4Rb1GMwk4t8+3SvqXMEEBtZSAAhZX8JFB6hrE+/ni/lLkRVH9?=
 =?us-ascii?Q?2bQt6VEwOu0yOTk9/A1viMYMIwQmh2S55AOnIXjLka+hzfljdMnDs3nW5Eq8?=
 =?us-ascii?Q?j80/ueyPS6UM/i00z9Li3w9hG1WTBV/is4ayD8PQqp/VBOG/8/LFgeNCU1uO?=
 =?us-ascii?Q?hfVU+sdZ/sThWise32ixJqFRpMWoZxy3We6JzQZomTc3oVo+PueCy5FJz2jm?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Eyub28a8VaBTtsY2/r4D8wScE4mbiEdgVkN3kKTdCZyQ/pS4AyqtTKEKNrPLN6Bo4zmRefKtW5TA6yVOZyLiYUUAN9PAUmcWb3rEG5qjLR8y7Wi8DPuel4+J5/INMF7xZp0tCJXirRrqOHywElNK7R21zDCfoRUbqLVcS5ITwJ/uNbIbPqKoHH9vbFtRFlJGWQNmf7acbrGrzRuLxLHJG1EuYZVvE50D851iqzDOXgsVnuG3US0zFy/knllz+15zqzzBGgeiUlXV4XjOKn3lLXut0LxBwXAOYK8EvSmlISQOPJj6vSddVt6u5hZp8i40/JuEDViXb8wqKdRrwjVUkKMbY1N6V33ZqWSGGNhXIEVTqP5NWhdqLnexD4XYIAw2oogjpuyq5iH839njwtNCxnQnz7cR/uwH6HhHrOECQ8baWUwPy5TqmtCVdFbT3YFHIvmtR05zVRGXfRHg2yrekMJM5VvOzPG5Vcu3OdYqIQc8TV/9nQosyjq7HqRXQqqKHSUl/XfLz1BmFHBn1C90I0vLX7bhkBGmx9g2PWyzWpV8QH8jxL1vg003jS+Zn/QPVPGoOUgwwJJ69/a2GZlo/sujqI/ebpIZNZYOxMjj1LM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6c4502-ee9a-45a5-f675-08dc01672cb9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:23:02.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsmVyBh8SROp+mn4FljdWgF0+O0bmoCMytX1e/lzMwPqtd7DijKAF0P2td65IyTH2fk1aejRJxKa3neA9E6h5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_07,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=794 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312200102
X-Proofpoint-GUID: d-nt_7Io5uIqzLEQTKy1SR35fG-CcT33
X-Proofpoint-ORIG-GUID: d-nt_7Io5uIqzLEQTKy1SR35fG-CcT33

On Wed, Dec 20, 2023 at 05:30:13AM +0000, Al Viro wrote:
> That went into the tree back in 2005; the comment used to be true for
> predecessor of simple_fill_super() that happened to live in nfsd; that one
> didn't take care to skip the array entries with NULL ->name, so it could
> not tolerate any gaps.  That had been fixed in 2003 when nfsd_fill_super()
> had been abstracted into simple_fill_super(); if Neil's patch lived out
> of tree during that time, he probably replaced the name of function when
> rebasing it and didn't notice that restriction in question was no longer
> there.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  fs/nfsd/nfsctl.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3e15b72f421d..26a25e40c451 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -48,10 +48,6 @@ enum {
>  	NFSD_MaxBlkSize,
>  	NFSD_MaxConnections,
>  	NFSD_Filecache,
> -	/*
> -	 * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
> -	 * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
> -	 */
>  #ifdef CONFIG_NFSD_V4
>  	NFSD_Leasetime,
>  	NFSD_Gracetime,
> -- 
> 2.39.2
> 
> 

-- 
Chuck Lever

