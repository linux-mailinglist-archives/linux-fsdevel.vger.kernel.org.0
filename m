Return-Path: <linux-fsdevel+bounces-10873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FAD84EF2F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 04:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD9B24D28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 03:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D04B4A29;
	Fri,  9 Feb 2024 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BFkr0PZO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XmxC9faM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A64A2D;
	Fri,  9 Feb 2024 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448052; cv=fail; b=dHKNnx4IQy2tKH14N1M6YxrlwlukjGPiQL/qoz0x876lrF5dVyHmAL5+YK4epg6PEE2NFKMQ8NR7T02wP1hTll2pHlx4wj70FIDEHkKG8QiFbYGOZipmquMZJxQ2zfVa0PvtXF/rNYPeowSPzip0MBv3i+V9pLwTctLC0nKUby0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448052; c=relaxed/simple;
	bh=3q5/jmFodOKmK/O+CDbHNwKgiU1lgwQaghir9SSjk2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Foivvfa2qc4fUiOCl53rXI9O6w91q4bZeG6/F01xeCE6l4S0QnHqMQFVd9EbQyTPCGrNeCAYmwL9gLU/u7hm98cKAajbbFOpJWkTwQRgjXyoW6HgwukvlXzcy5I3jU9qdbcpBntDYNHHnmQ4anBe84OvodqejjbOLJ2LwJgGM6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BFkr0PZO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XmxC9faM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LSxMd019775;
	Fri, 9 Feb 2024 03:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=eCfPDW+z7jXgLLDYNM7WK1KEHF9Yrv5WhU/ffeVVPrc=;
 b=BFkr0PZOPARa5EZnsCsJRjEi/xJw/nhsQ+J2ULCCaVLAOq7HU+mFH0Cw76hxzlkrBLM3
 pjhimQHSZnWRbwwROqlu7XAGvPDb1v5TYVW5J3aWzM3Z0k1GwA7NiPpCdiGZSqLbKTDN
 ZDh8eycnSPXt6V6fJO3Bt7qRnLbHq1Wx8lxSDs88VTJ099PEMDClq+IW8k818ROG+FWa
 zFjQhAUpPWy7raf15GtUAUseVicXP3vdAynB/x4yJxHin0pljva/6DDf1/nHL9QUe1LQ
 n/MbyI/uxKjHoDelgiyNVQZ4NNggVa7TICm/RGQltis+lczxvqx7uSYXlOt/ZXySqFx0 mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwex619-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 03:07:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41910IS4038354;
	Fri, 9 Feb 2024 03:06:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxbcxwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 03:06:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMlWOl02O8vw/uuguIL8+OnFcWIx6Fba9YSwKmxtuyJjjyhQAoFvl0NeZNwIVyfql0qA38d5FZZvLKM+X0iCwCAHgWKFxpky9pwXLBBBXUlKEGN0jiZoVSRgVm+DkUSJoMYXcJn3QkpdbiH5LWBkBrN2LtH6uxa0sn0A7mEhsELqGcXCIFX8FVUiEqU/hQUJf/waFAjHecuKnszquVyicuDUoQeVIs8GfePOPa2c73/W4oZUcGPoVfFHvvVOhLM9/ijAR/lDqSC81h/8TxhaK+7JfNrw+MzyatkeIHcTlhfXoIeL1irlQpZqVgpkRkb0WeREEjmpXwR36pMaflMesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCfPDW+z7jXgLLDYNM7WK1KEHF9Yrv5WhU/ffeVVPrc=;
 b=XUA7R9zF+gPMOu+sOnov1wJpHDUAZ7J0H8zkK7Qap0dt/04gj03VVkZ3YSR1pxGTolHjrAfAJ51vc0E93IdkwYiF+bHsoXsa8i4s73bKR6dpoCnODqyf3sXvk5QMGxmQqYCJeDSdpJYogwRLvCCUUAZB+P9G4lZ2Zu5Qu3ooJIpSwByeSVP/iW0XQAhcwOWspE+VUWB8xb2CCeq1n3/Dva3S0NlUOqFDxC9Z7pwWB93HpR2PC8McsyjkyrL77RSYyZOAA3fvanRCA9ClUhfvp8VRobaV2UhxJLqDv3VPyY00FpD/dUA/W2ZhNc0OWmmeHxd3Ph0+DWo7c84lqKuntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCfPDW+z7jXgLLDYNM7WK1KEHF9Yrv5WhU/ffeVVPrc=;
 b=XmxC9faMLUF+Cg5SmJ+dThejCFOYIxQl8Yp275z5K/9VS1OVU3dUo3wYsCg6NZZ/uGwHuVFGKGXC5nGAEXmVr5ghi/OV6NcZgqzGZKaMnN0EuXA/JhQEBcYVd0lgHX8NjrkntHcMTiion1Ps10oHmOTH9Z9EyNIJXYUi4736q1Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH8PR10MB6359.namprd10.prod.outlook.com (2603:10b6:510:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 03:06:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.038; Fri, 9 Feb 2024
 03:06:57 +0000
Date: Thu, 8 Feb 2024 22:06:54 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v4 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240209030654.lxh4krmxmiuszhab@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240208212204.2043140-1-lokeshgidra@google.com>
 <20240208212204.2043140-4-lokeshgidra@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208212204.2043140-4-lokeshgidra@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0276.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH8PR10MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: aa65d27e-cf1e-4407-99e4-08dc291c2cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hnVe35Vpgqrlw9BFmtDg3pb3VykzN5rgAQPWhDhxdcFLA0XID0MRg0LJ/iLpbz23LtiS7h7yLRqMfriMq75j3RxIIpM3AW63g4aQvgCT6Aa3BaOj7wV4+CSyXjKKmS3VrWkHnrv0M/vuUjp9b3DrZUIlqM7qGKk79aA+8y/VaO6lZzt1ytxh2slzcMjuOrXDaDWKf5zd/oSWitDUUefaOjqALX+bxHVBicXg0m8DearPklZ19Vx8VuglXT5tvIzoRkf6d5d+FBv3Bj7g4tlSC0jof0PJPRsgnh4RURbcQaRAPFOGumTkNOkEIgiO5d4Ohl4HRkiLzAsGA5V1P+rilwnl1YfUvMXcbGbtwyB57LKdruAXDyyXbYFPE72vJoEuCUHcTpmbj4Lm5rlh63ikipWYtLRWtjz0C1AClYzYBcDrZeo/BZEU4PdsbmCk/DlGD96LQ9hbKH33yT1rl3tuLbTcQEah+6Xq2xMhjvH40CGMvBLkR4xmRcehdG9w5s7sEfHmtiGFHwU0mpleAyq198mdyvUEh9yWjz2QXs+YF/9hg/uK7Oh6I101FE0DDeCt
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(1076003)(83380400001)(478600001)(41300700001)(7416002)(316002)(30864003)(9686003)(6512007)(6506007)(6486002)(5660300002)(6666004)(8676002)(4326008)(6916009)(8936002)(66556008)(66946007)(66476007)(86362001)(38100700002)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?18RvfWBP5PdhqDow+gPs4cf8ZglZMiRLAb3bEcO03wDbYTnJK0AQzv5OwL2M?=
 =?us-ascii?Q?UPpHesBqZeFdjEKqQNE2NroRWuMlBbI7TK8aqJXbSNbWoucuxkf+ctlA39Yv?=
 =?us-ascii?Q?HGLNIUqValY/nwCJ8e8iHslBl7lIpuEsGig06JyXP6WUIE6jQMoCM7TGAYsZ?=
 =?us-ascii?Q?gmIuIhDGft5wPvdVpljvibLinUNl1c77jAFo6SzMmtclPgXN1ZreIviJ4NTd?=
 =?us-ascii?Q?Sf8GQHMLFhQGO/b4Ywh55nc0L20k8dMILQFx1gP5+gNwA4e6HM/Ri+UxqqAf?=
 =?us-ascii?Q?E6R6Q7X8YsCUSIrAYTry8H3u8zkgDLpxJiIMsAKIWcwdTEJjd9UKG5137YhA?=
 =?us-ascii?Q?rAki8bqzV+5LfzPmpVRns6MNZR5YxPKuw0W/FQGrkoE9eglJPSeJ4wfBlvg4?=
 =?us-ascii?Q?nw63HBkAr/mFmV3MDlJO2G5RU4XXaO4VEFHSjia11Cga4Reb6MCrzQm6vg3h?=
 =?us-ascii?Q?LRx5rZ3d5EAaizY3noVjCk25Wk3meiXhffWpgufldspHNxwT9zHLggOSoPPC?=
 =?us-ascii?Q?5xE74eDtnv8MHOPKqWD3DU+fJHW6M4Elsw3ZGaVsaIpz4w7VO1OPwnYyFjPw?=
 =?us-ascii?Q?cNWyJsG9sspD+Vba1BwOlorF76M7N+PYcJ/0qOwECeAy+ZxMi5f6F9SkuF/E?=
 =?us-ascii?Q?zP2OvKXqj6ZrKGhpjrFXTea74C/vo2TUJreW7Y/y9dgr2izvgnBqhP9nPVxH?=
 =?us-ascii?Q?HfVZrlum2YNMzJmrQQpME5n1OzWJcsTkUd9ApTBpimRkPfWSz34cSu0BUAyM?=
 =?us-ascii?Q?A7xWMSYYfEavv4shcjaobIwpxorywPZ1pyURJCvzHpKJHTJegWeFptwL/HNJ?=
 =?us-ascii?Q?oQPY2koujvsQPsR1l/xf0o0vsM/0M7kgT763zp/pij2rQevVIfO2Uhh8XxXm?=
 =?us-ascii?Q?Ni/ioqYt9tJ3uN8YQUEYzBarPGxSh76RYmdgnXI8Ppe5vPxY9TgWpU+NNW1T?=
 =?us-ascii?Q?PhtP7CbrEqoh58YSuaHI2KtBhEj8R8dSy8WnfMlApHJNwMMrQvtib80lJV3L?=
 =?us-ascii?Q?2Rj/KqS/lbxvf65YOETFE4yFfanQFlfXxJyh4K3emOSayn0ES/KRXMJDB0uN?=
 =?us-ascii?Q?iQl58ggDMG9X7KB2vGUfapD1tT5jSQOlUQMSqjrzzeuTNCta3viK6DspzQj8?=
 =?us-ascii?Q?L0oD9em24dFL+Ybln8n6WHP8FFTXYyi8b9Afsj05rqJz88xaHHB0GCTV4nB/?=
 =?us-ascii?Q?fQ1ymEuZbTldHE5q56qKcAwiD3cb2NXRBo1PVgvKADtAkYVqBk9GBmZ1M7o4?=
 =?us-ascii?Q?BeWlhM6Uc5TBrYwzVIYIs79/IrHeegh6bt95ztLEGGGZGphpYU3GXDKBXIhp?=
 =?us-ascii?Q?8ioPG/tkXXpdVnl9Vg4Dsg5ho9l1inxVVk4cfwRAO5HPpFJuf3osr+++WPB0?=
 =?us-ascii?Q?2XzBfhYN3CIGYVSagObHKurpwx9fL4XpfgpMZOTSCdZ2NJOjy7ooV2o1Wyqs?=
 =?us-ascii?Q?e0viN2Pz3ytgMwAnjJ3KD7cnYBKvPkdcO38DC+vN5mrkNCaHdyYx2voz0DHP?=
 =?us-ascii?Q?IQgQULBRtFxtg13sgiyK8xN455W2jv8iv+GE5e7rKlkcBKLno2TLsZ0l2gdt?=
 =?us-ascii?Q?6kDMpDTWWJjI9qkWCxkgACmowKayVPuRQNgqVgKC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ex713wvePMZWO1Ylyqyxg+2RmM8U9vsTtyY4Br+D+I+7vKeHTObpYni0CapUxtWLP0zA5aXXDvKA/7HXeNyviFMjrzo5BdfqsWN7QSbe90ZQnzUPxk1Rp9jp9YI6Wa/EMWwCptRQHr+cPK424MQmlkwO9s5gY9KqcpNqz9l+fdB6bne+/okkAaWufWSxeT4XT4aCRJD0EgT3BUALLRPtZzt4sn+dxMvHwmCu4rXEquVuq/pCgL/ftNNZH40QUdMZlHEyqIKcp6HiOjHQuPR8Aed6u3RLqQEO2wgOz1CDLdfYDPwgvEOHDD8atFfXXl7Oji6Y6nvh7bkjjjfWEwLoK5dN0IUFPyJQGC9UmGL9gih/PXV/eLQTC9mmMq9T2pjOYgKAZwMyz4OeY0f3JDVmfwxSWgsUeI/c4Lg4jCjbJXb+fvPVBGLNPG0HwGCeMtyOxhhDLvtVjObqichPmblfUyGTXFi1gB+1gtyYgKAMQjutOCXfiZ43EfkaiUiRXkoL0F7AxSOM6G5pzHmsPXMc4OSbAHqfc3VKYWStWiGa04S3TMNoxXdhXE1b3nS0HppvdctoI5QvAeIn5fkqVHkC0YdWB4KGb4FpJT3EoGFYK50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa65d27e-cf1e-4407-99e4-08dc291c2cee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 03:06:57.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SweGamdvdfoQf7OdMWY1ltol33f737TkyjWGg5jAfN0e+XlMrhI7KgFETynYE7oqp3g5c3z6ufBDoP1htM7vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_13,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=899 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090021
X-Proofpoint-ORIG-GUID: krpWXxoWRwZtZYfYqzeJyFsjteX7Ah_d
X-Proofpoint-GUID: krpWXxoWRwZtZYfYqzeJyFsjteX7Ah_d

* Lokesh Gidra <lokeshgidra@google.com> [240208 16:22]:
> All userfaultfd operations, except write-protect, opportunistically use
> per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> critical section.
> 
> Write-protect operation requires mmap_lock as it iterates over multiple
> vmas.
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  fs/userfaultfd.c              |  13 +-
>  include/linux/userfaultfd_k.h |   5 +-
>  mm/userfaultfd.c              | 356 ++++++++++++++++++++++++++--------
>  3 files changed, 275 insertions(+), 99 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index c00a021bcce4..60dcfafdc11a 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
>  		return -EINVAL;
>  
>  	if (mmget_not_zero(mm)) {
> -		mmap_read_lock(mm);
> -
> -		/* Re-check after taking map_changing_lock */
> -		down_read(&ctx->map_changing_lock);
> -		if (likely(!atomic_read(&ctx->mmap_changing)))
> -			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
> -					 uffdio_move.len, uffdio_move.mode);
> -		else
> -			ret = -EAGAIN;
> -		up_read(&ctx->map_changing_lock);
> -		mmap_read_unlock(mm);
> +		ret = move_pages(ctx, uffdio_move.dst, uffdio_move.src,
> +				 uffdio_move.len, uffdio_move.mode);
>  		mmput(mm);
>  	} else {
>  		return -ESRCH;
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 3210c3552976..05d59f74fc88 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_struct *vma,
>  /* move_pages */
>  void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
>  void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
> -		   unsigned long dst_start, unsigned long src_start,
> -		   unsigned long len, __u64 flags);
> +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> +		   unsigned long src_start, unsigned long len, __u64 flags);
>  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
>  			struct vm_area_struct *dst_vma,
>  			struct vm_area_struct *src_vma,
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 74aad0831e40..1e25768b2136 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -19,20 +19,12 @@
>  #include <asm/tlb.h>
>  #include "internal.h"
>  
> -static __always_inline
> -struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> -				    unsigned long dst_start,
> -				    unsigned long len)

You could probably leave the __always_inline for this.

> +static bool validate_dst_vma(struct vm_area_struct *dst_vma,
> +			     unsigned long dst_end)
>  {
> -	/*
> -	 * Make sure that the dst range is both valid and fully within a
> -	 * single existing vma.
> -	 */
> -	struct vm_area_struct *dst_vma;
> -
> -	dst_vma = find_vma(dst_mm, dst_start);
> -	if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> -		return NULL;
> +	/* Make sure that the dst range is fully within dst_vma. */
> +	if (dst_end > dst_vma->vm_end)
> +		return false;
>  
>  	/*
>  	 * Check the vma is registered in uffd, this is required to
> @@ -40,11 +32,125 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
>  	 * time.
>  	 */
>  	if (!dst_vma->vm_userfaultfd_ctx.ctx)
> -		return NULL;
> +		return false;
> +
> +	return true;
> +}
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +/*
> + * lock_vma() - Lookup and lock vma corresponding to @address.
> + * @mm: mm to search vma in.
> + * @address: address that the vma should contain.
> + * @prepare_anon: If true, then prepare the vma (if private) with anon_vma.
> + *
> + * Should be called without holding mmap_lock. vma should be unlocked after use
> + * with unlock_vma().
> + *
> + * Return: A locked vma containing @address, NULL if no vma is found, or
> + * -ENOMEM if anon_vma couldn't be allocated.
> + */
> +static struct vm_area_struct *lock_vma(struct mm_struct *mm,
> +				       unsigned long address,
> +				       bool prepare_anon)
> +{
> +	struct vm_area_struct *vma;
> +
> +	vma = lock_vma_under_rcu(mm, address);
> +	if (vma) {
> +		/*
> +		 * lock_vma_under_rcu() only checks anon_vma for private
> +		 * anonymous mappings. But we need to ensure it is assigned in
> +		 * private file-backed vmas as well.
> +		 */
> +		if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
> +		    !vma->anon_vma)
> +			vma_end_read(vma);
> +		else
> +			return vma;
> +	}
> +
> +	mmap_read_lock(mm);
> +	vma = vma_lookup(mm, address);
> +	if (vma) {
> +		if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
> +		    anon_vma_prepare(vma)) {
> +			vma = ERR_PTR(-ENOMEM);
> +		} else {
> +			/*
> +			 * We cannot use vma_start_read() as it may fail due to
> +			 * false locked (see comment in vma_start_read()). We
> +			 * can avoid that by directly locking vm_lock under
> +			 * mmap_lock, which guarantees that nobody can lock the
> +			 * vma for write (vma_start_write()) under us.
> +			 */
> +			down_read(&vma->vm_lock->lock);
> +		}
> +	}
> +
> +	mmap_read_unlock(mm);
> +	return vma;
> +}
> +
> +static void unlock_vma(struct vm_area_struct *vma)
> +{
> +	vma_end_read(vma);
> +}
> +
> +static struct vm_area_struct *find_and_lock_dst_vma(struct mm_struct *dst_mm,
> +						    unsigned long dst_start,
> +						    unsigned long len)
> +{
> +	struct vm_area_struct *dst_vma;
> +
> +	/* Ensure anon_vma is assigned for private vmas */
> +	dst_vma = lock_vma(dst_mm, dst_start, true);
> +
> +	if (!dst_vma)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (PTR_ERR(dst_vma) == -ENOMEM)
> +		return dst_vma;
> +
> +	if (!validate_dst_vma(dst_vma, dst_start + len))
> +		goto out_unlock;
>  
>  	return dst_vma;
> +out_unlock:
> +	unlock_vma(dst_vma);
> +	return ERR_PTR(-ENOENT);
>  }
>  
> +#else
> +
> +static struct vm_area_struct *lock_mm_and_find_dst_vma(struct mm_struct *dst_mm,
> +						       unsigned long dst_start,
> +						       unsigned long len)
> +{
> +	struct vm_area_struct *dst_vma;
> +	int err = -ENOENT;
> +
> +	mmap_read_lock(dst_mm);
> +	dst_vma = vma_lookup(dst_mm, dst_start);
> +	if (!dst_vma)
> +		goto out_unlock;
> +
> +	/* Ensure anon_vma is assigned for private vmas */
> +	if (!(dst_vma->vm_flags & VM_SHARED) && anon_vma_prepare(dst_vma)) {
> +		err = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	if (!validate_dst_vma(dst_vma, dst_start + len))
> +		goto out_unlock;
> +
> +	return dst_vma;
> +out_unlock:
> +	mmap_read_unlock(dst_mm);
> +	return ERR_PTR(err);
> +}
> +#endif
> +
>  /* Check if dst_addr is outside of file's size. Must be called with ptl held. */
>  static bool mfill_file_over_size(struct vm_area_struct *dst_vma,
>  				 unsigned long dst_addr)
> @@ -350,7 +456,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
>  #ifdef CONFIG_HUGETLB_PAGE
>  /*
>   * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
> - * called with mmap_lock held, it will release mmap_lock before returning.
> + * called with either vma-lock or mmap_lock held, it will release the lock
> + * before returning.
>   */
>  static __always_inline ssize_t mfill_atomic_hugetlb(
>  					      struct userfaultfd_ctx *ctx,
> @@ -361,7 +468,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  					      uffd_flags_t flags)
>  {
>  	struct mm_struct *dst_mm = dst_vma->vm_mm;
> -	int vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	ssize_t err;
>  	pte_t *dst_pte;
>  	unsigned long src_addr, dst_addr;
> @@ -380,7 +486,11 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	 */
>  	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
>  		up_read(&ctx->map_changing_lock);
> +#ifdef CONFIG_PER_VMA_LOCK
> +		unlock_vma(dst_vma);
> +#else
>  		mmap_read_unlock(dst_mm);
> +#endif
>  		return -EINVAL;
>  	}
>  
> @@ -403,24 +513,32 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	 * retry, dst_vma will be set to NULL and we must lookup again.
>  	 */
>  	if (!dst_vma) {
> +#ifdef CONFIG_PER_VMA_LOCK
> +		dst_vma = find_and_lock_dst_vma(dst_mm, dst_start, len);
> +#else
> +		dst_vma = lock_mm_and_find_dst_vma(dst_mm, dst_start, len);
> +#endif
> +		if (IS_ERR(dst_vma)) {
> +			err = PTR_ERR(dst_vma);
> +			goto out;
> +		}
> +
>  		err = -ENOENT;
> -		dst_vma = find_dst_vma(dst_mm, dst_start, len);
> -		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
> -			goto out_unlock;
> +		if (!is_vm_hugetlb_page(dst_vma))
> +			goto out_unlock_vma;
>  
>  		err = -EINVAL;
>  		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
> -			goto out_unlock;
> -
> -		vm_shared = dst_vma->vm_flags & VM_SHARED;
> -	}
> +			goto out_unlock_vma;
>  
> -	/*
> -	 * If not shared, ensure the dst_vma has a anon_vma.
> -	 */
> -	err = -ENOMEM;
> -	if (!vm_shared) {
> -		if (unlikely(anon_vma_prepare(dst_vma)))
> +		/*
> +		 * If memory mappings are changing because of non-cooperative
> +		 * operation (e.g. mremap) running in parallel, bail out and
> +		 * request the user to retry later
> +		 */
> +		down_read(&ctx->map_changing_lock);
> +		err = -EAGAIN;
> +		if (atomic_read(&ctx->mmap_changing))
>  			goto out_unlock;
>  	}
>  
> @@ -465,7 +583,11 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  
>  		if (unlikely(err == -ENOENT)) {
>  			up_read(&ctx->map_changing_lock);
> +#ifdef CONFIG_PER_VMA_LOCK
> +			unlock_vma(dst_vma);
> +#else
>  			mmap_read_unlock(dst_mm);
> +#endif
>  			BUG_ON(!folio);
>  
>  			err = copy_folio_from_user(folio,
> @@ -474,17 +596,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  				err = -EFAULT;
>  				goto out;
>  			}
> -			mmap_read_lock(dst_mm);
> -			down_read(&ctx->map_changing_lock);
> -			/*
> -			 * If memory mappings are changing because of non-cooperative
> -			 * operation (e.g. mremap) running in parallel, bail out and
> -			 * request the user to retry later
> -			 */
> -			if (atomic_read(&ctx->mmap_changing)) {
> -				err = -EAGAIN;
> -				break;
> -			}
>  
>  			dst_vma = NULL;
>  			goto retry;
> @@ -505,7 +616,12 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  
>  out_unlock:
>  	up_read(&ctx->map_changing_lock);
> +out_unlock_vma:
> +#ifdef CONFIG_PER_VMA_LOCK
> +	unlock_vma(dst_vma);
> +#else
>  	mmap_read_unlock(dst_mm);
> +#endif
>  out:
>  	if (folio)
>  		folio_put(folio);
> @@ -597,7 +713,19 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  	copied = 0;
>  	folio = NULL;
>  retry:
> -	mmap_read_lock(dst_mm);
> +	/*
> +	 * Make sure the vma is not shared, that the dst range is
> +	 * both valid and fully within a single existing vma.
> +	 */
> +#ifdef CONFIG_PER_VMA_LOCK
> +	dst_vma = find_and_lock_dst_vma(dst_mm, dst_start, len);
> +#else
> +	dst_vma = lock_mm_and_find_dst_vma(dst_mm, dst_start, len);
> +#endif
> +	if (IS_ERR(dst_vma)) {
> +		err = PTR_ERR(dst_vma);
> +		goto out;
> +	}
>  
>  	/*
>  	 * If memory mappings are changing because of non-cooperative
> @@ -609,15 +737,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  	if (atomic_read(&ctx->mmap_changing))
>  		goto out_unlock;
>  
> -	/*
> -	 * Make sure the vma is not shared, that the dst range is
> -	 * both valid and fully within a single existing vma.
> -	 */
> -	err = -ENOENT;
> -	dst_vma = find_dst_vma(dst_mm, dst_start, len);
> -	if (!dst_vma)
> -		goto out_unlock;
> -
>  	err = -EINVAL;
>  	/*
>  	 * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHARED but
> @@ -647,16 +766,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
>  		goto out_unlock;
>  
> -	/*
> -	 * Ensure the dst_vma has a anon_vma or this page
> -	 * would get a NULL anon_vma when moved in the
> -	 * dst_vma.
> -	 */
> -	err = -ENOMEM;
> -	if (!(dst_vma->vm_flags & VM_SHARED) &&
> -	    unlikely(anon_vma_prepare(dst_vma)))
> -		goto out_unlock;
> -
>  	while (src_addr < src_start + len) {
>  		pmd_t dst_pmdval;
>  
> @@ -699,7 +808,11 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  			void *kaddr;
>  
>  			up_read(&ctx->map_changing_lock);
> +#ifdef CONFIG_PER_VMA_LOCK
> +			unlock_vma(dst_vma);
> +#else
>  			mmap_read_unlock(dst_mm);
> +#endif
>  			BUG_ON(!folio);
>  
>  			kaddr = kmap_local_folio(folio, 0);
> @@ -730,7 +843,11 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  
>  out_unlock:
>  	up_read(&ctx->map_changing_lock);
> +#ifdef CONFIG_PER_VMA_LOCK
> +	unlock_vma(dst_vma);
> +#else
>  	mmap_read_unlock(dst_mm);
> +#endif
>  out:
>  	if (folio)
>  		folio_put(folio);
> @@ -1267,16 +1384,67 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
>  	if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
>  		return -EINVAL;
>  
> -	/*
> -	 * Ensure the dst_vma has a anon_vma or this page
> -	 * would get a NULL anon_vma when moved in the
> -	 * dst_vma.
> -	 */
> -	if (unlikely(anon_vma_prepare(dst_vma)))
> -		return -ENOMEM;
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +static int find_and_lock_vmas(struct mm_struct *mm,
> +			      unsigned long dst_start,
> +			      unsigned long src_start,
> +			      struct vm_area_struct **dst_vmap,
> +			      struct vm_area_struct **src_vmap)
> +{
> +	int err;
> +
> +	/* There is no need to prepare anon_vma for src_vma */
> +	*src_vmap = lock_vma(mm, src_start, false);
> +	if (!*src_vmap)
> +		return -ENOENT;
> +
> +	/* Ensure anon_vma is assigned for anonymous vma */
> +	*dst_vmap = lock_vma(mm, dst_start, true);
> +	err = -ENOENT;
> +	if (!*dst_vmap)
> +		goto out_unlock;
> +
> +	err = -ENOMEM;
> +	if (PTR_ERR(*dst_vmap) == -ENOMEM)
> +		goto out_unlock;

If you change lock_vma() to return the vma or ERR_PTR(-ENOENT) /
ERR_PTR(-ENOMEM), then you could change this to check IS_ERR() and
return the PTR_ERR().

You could also use IS_ERR_OR_NULL here, but the first suggestion will
simplify your life for find_and_lock_dst_vma() and the error type to
return.

What you have here will work though.

>  
>  	return 0;
> +out_unlock:
> +	unlock_vma(*src_vmap);
> +	return err;
>  }
> +#else
> +static int lock_mm_and_find_vmas(struct mm_struct *mm,
> +				 unsigned long dst_start,
> +				 unsigned long src_start,
> +				 struct vm_area_struct **dst_vmap,
> +				 struct vm_area_struct **src_vmap)
> +{
> +	int err = -ENOENT;

Nit: new line after declarations.

> +	mmap_read_lock(mm);
> +
> +	*src_vmap = vma_lookup(mm, src_start);
> +	if (!*src_vmap)
> +		goto out_unlock;
> +
> +	*dst_vmap = vma_lookup(mm, dst_start);
> +	if (!*dst_vmap)
> +		goto out_unlock;
> +
> +	/* Ensure anon_vma is assigned */
> +	err = -ENOMEM;
> +	if (vma_is_anonymous(*dst_vmap) && anon_vma_prepare(*dst_vmap))
> +		goto out_unlock;
> +
> +	return 0;
> +out_unlock:
> +	mmap_read_unlock(mm);
> +	return err;
> +}
> +#endif
>  
>  /**
>   * move_pages - move arbitrary anonymous pages of an existing vma
> @@ -1287,8 +1455,6 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
>   * @len: length of the virtual memory range
>   * @mode: flags from uffdio_move.mode
>   *
> - * Must be called with mmap_lock held for read.
> - *

Will either use the mmap_lock in read mode or per-vma locking ?

>   * move_pages() remaps arbitrary anonymous pages atomically in zero
>   * copy. It only works on non shared anonymous pages because those can
>   * be relocated without generating non linear anon_vmas in the rmap
> @@ -1355,10 +1521,10 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
>   * could be obtained. This is the only additional complexity added to
>   * the rmap code to provide this anonymous page remapping functionality.
>   */
> -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
> -		   unsigned long dst_start, unsigned long src_start,
> -		   unsigned long len, __u64 mode)
> +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> +		   unsigned long src_start, unsigned long len, __u64 mode)
>  {
> +	struct mm_struct *mm = ctx->mm;

You dropped the argument, but left the comment for the argument.

>  	struct vm_area_struct *src_vma, *dst_vma;
>  	unsigned long src_addr, dst_addr;
>  	pmd_t *src_pmd, *dst_pmd;
> @@ -1376,28 +1542,40 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
>  	    WARN_ON_ONCE(dst_start + len <= dst_start))
>  		goto out;
>  
> +#ifdef CONFIG_PER_VMA_LOCK
> +	err = find_and_lock_vmas(mm, dst_start, src_start,
> +				 &dst_vma, &src_vma);
> +#else
> +	err = lock_mm_and_find_vmas(mm, dst_start, src_start,
> +				    &dst_vma, &src_vma);
> +#endif

I was hoping you could hide this completely, but it's probably better to
show what's going on and the function names document it well.

> +	if (err)
> +		goto out;
> +
> +	/* Re-check after taking map_changing_lock */
> +	down_read(&ctx->map_changing_lock);
> +	if (likely(atomic_read(&ctx->mmap_changing))) {
> +		err = -EAGAIN;
> +		goto out_unlock;
> +	}
>  	/*
>  	 * Make sure the vma is not shared, that the src and dst remap
>  	 * ranges are both valid and fully within a single existing
>  	 * vma.
>  	 */
> -	src_vma = find_vma(mm, src_start);
> -	if (!src_vma || (src_vma->vm_flags & VM_SHARED))
> -		goto out;
> -	if (src_start < src_vma->vm_start ||
> -	    src_start + len > src_vma->vm_end)
> -		goto out;
> +	if (src_vma->vm_flags & VM_SHARED)
> +		goto out_unlock;
> +	if (src_start + len > src_vma->vm_end)
> +		goto out_unlock;
>  
> -	dst_vma = find_vma(mm, dst_start);
> -	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> -		goto out;
> -	if (dst_start < dst_vma->vm_start ||
> -	    dst_start + len > dst_vma->vm_end)
> -		goto out;
> +	if (dst_vma->vm_flags & VM_SHARED)
> +		goto out_unlock;
> +	if (dst_start + len > dst_vma->vm_end)
> +		goto out_unlock;
>  
>  	err = validate_move_areas(ctx, src_vma, dst_vma);
>  	if (err)
> -		goto out;
> +		goto out_unlock;
>  
>  	for (src_addr = src_start, dst_addr = dst_start;
>  	     src_addr < src_start + len;) {
> @@ -1514,6 +1692,14 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
>  		moved += step_size;
>  	}
>  
> +out_unlock:
> +	up_read(&ctx->map_changing_lock);
> +#ifdef CONFIG_PER_VMA_LOCK
> +	unlock_vma(dst_vma);
> +	unlock_vma(src_vma);
> +#else
> +	mmap_read_unlock(mm);
> +#endif
>  out:
>  	VM_WARN_ON(moved < 0);
>  	VM_WARN_ON(err > 0);
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

