Return-Path: <linux-fsdevel+bounces-23212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C929928C2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1521F23959
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D416D310;
	Fri,  5 Jul 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QL4BG4QW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oi0VHNND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C9225AE;
	Fri,  5 Jul 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196724; cv=fail; b=JDkEfZCk769nOoZ6q+DGdOB0HGeZ0rJ5rRh3UqXtkMl5AEjKxT7p7nE3wheFavWuo88lKclkCW6BjNs4n6t1zr4xcQxpKTOnBW3RVK0cFArFcoUMwmxKi9Ep+/BbKNj9F958VOpClXhJJnkHITic0Nhtd1VERFVfYCRBJRIE6co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196724; c=relaxed/simple;
	bh=bDIhO7cn3QNHi4OV3H+bBhu6VpbcNqgujdsIUIm7cVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V2RxgloOaYEbfi9sb466qHROzljoc+Nm9seBHNFvq1L4SQ0h/L91SS6lEfiarw3wdTLg3P2m9eWwZPiiMSqYPL7yvNt15xHxcHFOCnoNDhDinhduNTs4uABbd2t6/SnUOOw87ELQe7XybpFms0GmYPjSHpyIw5Wc9nQdSydaP/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QL4BG4QW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oi0VHNND; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMURg008277;
	Fri, 5 Jul 2024 16:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=N/VNfmzzzpq9WiOvw8jG5FmH9pc5+ps66GdlNYpQkjE=; b=
	QL4BG4QWv0Ojpt9rvwSYN1IZRl4j6KGQ/uH3QNjSy4Xr9yr7nXGuynCj3eemzpj9
	C1rahphYu2qQ/DIw6yezsoHoyboUzOr8qyLpVkVE1vRS3DDCu5sVCjqfuRMsTWDf
	5BL6JNIjmUmy2Ww0/ka5O55/loiNdV4enTQI9X67YllJ7PigJIQGl1GiIeCbthtH
	5L4am0xOoQrhQmOQ4RQAQqI7twfgCP0d9Tz4wqrhCVY9fVhh4KlcmmAjVwYp11TH
	0PLGkHXme+9zfGlOIsM1E5+uAEL63PKDgjrmRlrFoQn8nmpsM7WvCaIC3ioBZsLJ
	CTTkFave9wTWgmg8P6ZfKA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40292347ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465GITIn010337;
	Fri, 5 Jul 2024 16:25:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhwsnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcdBoF8P/D9HaV0ss6nG4nvJAUB6O6qBPcJC5o2jVnRv/LJEb7yJnrYOnF6vzvxIaKLSLo/Cc0e4boLDu5R00hsX/wEPFxNFi6QxoEN/MiouHCkn6Dni8ZwiotBzPZR2yClkLePZnP8SpzIF0VGGWH/QzgQptsxeIkPe5LI7ql9rFl/rtkd6Gt9k7BpNRkV+KJF6koCXOgqwt1MUySVYIBTyDKhOAtRxiDE4w3wMS3gd0qfmp+5bvCYKvorPZRtvEaNmW5Zi8lynQbUc5SbaJRC6nrBMkmWEZz77VlQrOOnU++4gywd+fYm0RFQmlP33j/4ScJ5n4Qzw15X+Ecw2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/VNfmzzzpq9WiOvw8jG5FmH9pc5+ps66GdlNYpQkjE=;
 b=E0/ukTSSAyOVxv/LzY/hmXBhXMQGf5RRAfYN650G0zAJAJbqtuU+0lJiGrMa96qhdedlJX90OvJPScWfX7ca5E9WQ0NK6Md0tJrnSnk1Ju9W61nvATBOVrfgtidWED8JGM4+89r125JbNSiLrxhXVvzLcEJwy1TUDQyyeARRiohhHznp61mIZadZVXI6HCFjUdGw541sKTS9Vdo2g0boBRa915sWMPJ2XYZgNT8Rk907o47jDGfBWzp3beiDrXhTO4YzapeJeFXdu0rTRpqKBqx36MoUTU2qXtdX1R7AsaeJloS9N2WtOFgy+BEEnXq3SdoE1vKJq+OnwCYhWUVL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/VNfmzzzpq9WiOvw8jG5FmH9pc5+ps66GdlNYpQkjE=;
 b=Oi0VHNNDRo3k81Cu4lalxzkxpgI65FNMy8IeJBUqKo0NaX0PQW8GjkLvktmTCdFRUZooMTwa4yMlNEqXDRUx0xyJZTXj+m2wSqE2kD1cU9Vdx3ostTrfpQMikSeaiHRyQvfT07d2I5Vn377pWkmcC9Ec3Bw6CHRvgccSpyQoFZw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 16:25:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 02/13] xfs: always tail align maxlen allocations
Date: Fri,  5 Jul 2024 16:24:39 +0000
Message-Id: <20240705162450.3481169-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0010.namprd15.prod.outlook.com
 (2603:10b6:207:17::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: f27ba29e-4b1b-4635-d71f-08dc9d0f0aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tyeB3mnlZAYDmoNKwhj6VBQNP54yCN2D/ZEobIx2wW36iKc9sj5BSbppBg8G?=
 =?us-ascii?Q?JdSZMHUnC4xUQxwoWA7TuzgwkEvegAK8HjaPwU1o3pd9M3dkWvTUvXtdjbZG?=
 =?us-ascii?Q?uHei8iYVBitURuadGjRg9tGTGVBqb52Tis03hKnf2ho0VitIL1MTRa2NLjIO?=
 =?us-ascii?Q?YocKGHtMJRpnle915nVfSc4HSwD5MprjhChc9nBoHVHGUxzWAHhOEJGHwOC2?=
 =?us-ascii?Q?13R4TLLoe7kFAxYsuueyBmMX6TDYudv6kAtucKwBTv9ErOOQmOkt7RniKMG7?=
 =?us-ascii?Q?MSA6VdAwvAbJHNBDB4s33z73T1J833trYmszrX3YkVd0CVly1xXmluzzxlQJ?=
 =?us-ascii?Q?j1sQtfOYRRUDUxbkzWSr3OSotILs6+5b/gYenPfy/Wi7s3u7IMtj6zGgiYkS?=
 =?us-ascii?Q?gBMWYhGJwePZagmTHjo4MBqNd9BBowRSpjg9NJ5hPnJADT+oTEO7ASjGudeb?=
 =?us-ascii?Q?9z3bWSSa3DZUKV80GdO8y8lAOgidlKmW8oMIIyLNJ6PeQSz+QhlJv1/R2Ltg?=
 =?us-ascii?Q?7F427LFogFMT84Nly9MIvTVnx6jDWvcTHqz8RjIDRhjQLvsvL0ktAAdQoIqN?=
 =?us-ascii?Q?IxMndi5G2zNTubb0bp8KJddsd/hKTs0YssNjjhMFI28epFJmD2no77Mh8/vc?=
 =?us-ascii?Q?SB90TueuISe1zryV5QWTu/d457kHmo1NJpHHHgaYVAdSvSo+6ray0EPRnRIx?=
 =?us-ascii?Q?DDx4TYHYKoQol3D3PCgYDAQjaXTEpZYBcyBjEP8ZFKjN9jcnt5lErbRY9pXR?=
 =?us-ascii?Q?7kPMjq1WLQPUL745V9ftKLZV2bJQmyVQ3+t0tPnZ2+kjFrh+v+nZOx9UYSEo?=
 =?us-ascii?Q?rgf6n0cUlGZrMYTCFt2aDEAmMqrIuh3mLdxg6S/wnEWKo4cz1UA96fqrNYfu?=
 =?us-ascii?Q?FufaQmN6DiT8h+GA7MyNIEslN4M8t8/d9b5mkZbdM9ThG9CTijCMN0HmDXHy?=
 =?us-ascii?Q?4PG8tZ4s7JN9j3IylqFzyzsGeGecNu8niR2woQnSjCq0ujJp/gBaiWIV+uBd?=
 =?us-ascii?Q?mNAmOdVpy02T6jmQV0bSPEzfCkhP8HfhULLyNxFh+ynEG/N31pXpMdvYYFgS?=
 =?us-ascii?Q?MWOJIaKmSkpmkuWE3uqM+opAm20yNH8fY23WqtTpcFMEXYv7wf/lqrOF7Im/?=
 =?us-ascii?Q?4QJo92SesWK1wPZjC5mkUC6fTasHSeepIwVvLH/PkLvXBDQ2LxKhrGNMqQ1V?=
 =?us-ascii?Q?zlRSATuRsguojuDXJViZDLDcGnNYfrp/qx2he3W7LTmzBq+O4SA2eeiAoqN6?=
 =?us-ascii?Q?1Qkhl8XsxuwlNv54O0F3b4lrFSnEV+2Nil5HAVdPZ3ssAe83EgiVVjWmEcHl?=
 =?us-ascii?Q?I6Ifczn8FOUHnxS/GLbHWmFgLHpj93LVjS1B+pjKcWv+dA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4+r2vEQLD8puxyWQ+mJ+KXgHalBhxV9+twldLvwmNtHPMSa76yLZCpuQgozV?=
 =?us-ascii?Q?yjFrCfek8S/2xt5pKPphzYn8YHdA2Mt1RD5khBqn4XCNfETSbEpTqDSm0kGo?=
 =?us-ascii?Q?vBwWjm+9UZMCeLs0zv0MjPxU/ytoctSpdniL5WVbfloXOwbzUBoPozuKPNHd?=
 =?us-ascii?Q?y6fYKQeP6t2Xjlh4fNPnFljlQ65yJVzFTLEyKiuAHx8dG0fYnItZdvsaqcQb?=
 =?us-ascii?Q?tT9UM+x//OyWPQyvGEm9+BAznJdO+YLzK2GjSikcPau27zRY7VRSAtmUqtn0?=
 =?us-ascii?Q?uLEVe6R/Gsq9b/jLvLb3O869rJtEX8PXcOhJdPgxM9+BSHJ9DnRrMGka29tx?=
 =?us-ascii?Q?fdXkJCtAmGqG+ReqS34qMb4luXELH8Cj05Gw9WBrxJYJrcZNw2yeUrQWxrmm?=
 =?us-ascii?Q?uAqy6EN0HHQMCupb+VE7pjV+kadY12GwJnKXdzV1tB5Ac9a/EMl3vOThZYdP?=
 =?us-ascii?Q?PSzp2kTLwFqLYeaB8UJRQDgwd4X+KOuPxHKm28LTgizFwSvO3QtFo/cpTE2t?=
 =?us-ascii?Q?717M1RIXt6R9W/6IcP/ugeiYSLDoTeTV3GcGYrQrqBXCzT+x8PHMmhKC8BDx?=
 =?us-ascii?Q?TsQOUTmHFCwDB9UN4scssF5cZx0riMbxz6lP5AP3180dkyNwfzBVR0W+W9R0?=
 =?us-ascii?Q?X3kM1CS3OZtLWxWRWtZlE1JDB1moBFt4igt2nY+PSyyi2+FRXOVYUCuESQTo?=
 =?us-ascii?Q?r9yo51uYQVt7o5Lg0TTrBve4+5IemnerpS1nsffVGQZ8QmtUNdpiK8lzxkIt?=
 =?us-ascii?Q?YDXSmGJwbybTqmo3LJBEIAxmecXJrG/Qjhe6/UAb2+EQyzIv5LJpjjwonCzm?=
 =?us-ascii?Q?epFyV32NtiJboKAKlIuHvOIRDOfw8VRGLNbLOxeBBPhWE24Rg65UvOSA5OFg?=
 =?us-ascii?Q?qpD4gq0oqxPMaVZmFdFHNEBP01Ljnp/6cxs63dhT4o7z41yfSTwRArumDvhl?=
 =?us-ascii?Q?ZYMzenapcJ+MC+hef3e0/c1r1aOfPWLHopfbpUQz0lsxlXM4EZo1Yl+ivY6h?=
 =?us-ascii?Q?OR073JooN5GrENETh9/+nQlT+9Yj3bmpLNbLiqv91I9ElhIljt0/oruRXusM?=
 =?us-ascii?Q?8uAfc8e0IcVfMImIcBjfA50O1QfdrG8X3rQV/1ps9yG3IWcFue60Dr2g9p8W?=
 =?us-ascii?Q?3Y0nfZWlgs418yC6mlhsiI6dv8hbIn7/klqSmAFiFoR7ybsSwU5LZ6X+FnKS?=
 =?us-ascii?Q?miQReV9p+71YK1W+8/NP0PH8EnVK7eB9J2PJ3CaZyWTVnvMVi7sszRNOVwTf?=
 =?us-ascii?Q?Eei8DzzOk5B0OMykXlSj1HKm9okBQds9SzxLxfuqYePy6tJz1xwZgcym5ALj?=
 =?us-ascii?Q?nYYIXD7NSIsBMRj6nZUdlRx6BVaFGckVMAuBVtiFKXjkG8TxB5UV8nuCN5Wl?=
 =?us-ascii?Q?IyU9GCsV1ex86aO9sQb0HtUos3b1mcMc2DehEd4lD55KeIEhLltApkifykhA?=
 =?us-ascii?Q?aQhPndUJqfkMBKIWdN1K849883EIqrd/wAL0lp+UUP499US0wafOXbg3PQQv?=
 =?us-ascii?Q?e7afplmXTuvpiC/ewh6q0UbJt1SKHXoiZKbYixgXCMZEKRi/pdBPsJGh1gMR?=
 =?us-ascii?Q?7183ARhzxzz6GNX8XekRsPMiP2h4cpLRkArev8lo/n0Srhkx7BXnJpupAFYx?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z5dWv1nh7ivfkGIDAl3logMRpCwYf56Xo2aZk30dMcePzank/gSgguSzpmHWJLh/pXyystOMCF9cnFt6TAON0qXLtWYeoQqgO++zGsScXnBuX8Y8QNm3X6afEDsrNwTXEhsJmcg6N1yomfneLHQ5QG6/28cdgH45Gtg80OgsaIOHmJkYy5bIRCzEEE5suXRaeMgOYWqfOMZ4FyZ7S2zl2OWWklszulc2VIUsnjwhyHgsVDgzEGpPIGEq0iPuRiA9x/ICK6kRIe+OIKQMB4d21/D4k2QQpsYGKS4tyid7XBG6S1IE0oEiGBZatR1Gk9PGDrGrYD3y7rHIGbqHJCU0zLBDLUnJ3VtKdh/MjYoh/RZHGN8bxVSVXhwyaAlK8u51MSwareuK0VPAJn1lFh6MhCtsABhkibIRTY4AHj/0w3hdRFA6anCHO4d9ixJafWzQWZNuZ2/15NVg5d52ZVn2EUYD89FJz/EV1ijJeCW8wD9zpeuRZL5XkqIUn7asmVvdDoXnwvHs+uR/UdWLb4ySs+78+mTHrAAPPcVbyK46XALskQh7SQyG+GiMPnLo4wW2SEzkSWf9RMEqbJqtJWPe//vNyJjy6T/VeGlfa/U6dss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27ba29e-4b1b-4635-d71f-08dc9d0f0aed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:11.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgG0vYmvFKNuX/52vTnxpO69TQmHwSTwkhc+gI6VI120eExgbYZTSzpIMKRB+pInvpXRjbs90M6hFqSCXZJbQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050119
X-Proofpoint-GUID: YcV5rCAk8JOL0SLA26KsXeJaj-oYmDoL
X-Proofpoint-ORIG-GUID: YcV5rCAk8JOL0SLA26KsXeJaj-oYmDoL

From: Dave Chinner <dchinner@redhat.com>

When we do a large allocation, the core free space allocation code
assumes that args->maxlen is aligned to args->prod/args->mod. hence
if we get a maximum sized extent allocated, it does not do tail
alignment of the extent.

However, this assumes that nothing modifies args->maxlen between the
original allocation context setup and trimming the selected free
space extent to size. This assumption has recently been found to be
invalid - xfs_alloc_space_available() modifies args->maxlen in low
space situations - and there may be more situations we haven't yet
found like this.

Force aligned allocation introduces the requirement that extents are
correctly tail aligned, resulting in this occasional latent
alignment failure to be reclassified from an unimportant curiousity
to a must-fix bug.

Removing the assumption about args->maxlen allocations always being
tail aligned is trivial, and should not impact anything because
args->maxlen for inodes with extent size hints configured are
already aligned. Hence all this change does it avoid weird corner
cases that would have resulted in unaligned extent sizes by always
trimming the extent down to an aligned size.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> [provisional on v1 series comment]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 74f0a3656458..2864520c3902 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -432,20 +432,18 @@ xfs_alloc_compute_diff(
  * Fix up the length, based on mod and prod.
  * len should be k * prod + mod for some k.
  * If len is too small it is returned unchanged.
- * If len hits maxlen it is left alone.
  */
-STATIC void
+static void
 xfs_alloc_fix_len(
-	xfs_alloc_arg_t	*args)		/* allocation argument structure */
+	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t	k;
-	xfs_extlen_t	rlen;
+	xfs_extlen_t		k;
+	xfs_extlen_t		rlen = args->len;
 
 	ASSERT(args->mod < args->prod);
-	rlen = args->len;
 	ASSERT(rlen >= args->minlen);
 	ASSERT(rlen <= args->maxlen);
-	if (args->prod <= 1 || rlen < args->mod || rlen == args->maxlen ||
+	if (args->prod <= 1 || rlen < args->mod ||
 	    (args->mod == 0 && rlen < args->prod))
 		return;
 	k = rlen % args->prod;
-- 
2.31.1


