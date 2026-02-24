Return-Path: <linux-fsdevel+bounces-78291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPADINDbnWmuSQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:11:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB52618A5B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D09130AE7A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901213A9624;
	Tue, 24 Feb 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PfGc9183";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PBjq0sNO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF03A9634
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953054; cv=fail; b=OuHoxaDtj0fc/Tet2Kqi5fzND8ihbBltljhy7nwDrGbm2ifKpCj/dldyooxPECVGmOrn+95Tr3K2d072mpUsQR08vaixN7aQDmxnVbWDdWcrF7r3JHkM2mDVe4Xj/YeXr9pAdFEFpSLtWEIa0X3UfhFOoOyJwBrJzaSgiWtvHbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953054; c=relaxed/simple;
	bh=b1bZFb3jI1Ysmp5Xp3X39WnUDm0y2bHX4juiJgmVBx8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ERjyG6FuW2J3qbGw0l0xt3HLRvgpMQaEAr6Kf61u1ABbIoEHwH+7gobMAwpbx8+gBhyp+HlTr6/UclOZnyKnigvMrbOvKFrLZ6lYY4hq75pIHhMkzTt6pw5unzob9L4+R5x4EzpANsNfYAOdtn/zjcRemXiV8GfhkZhRKr8GaaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PfGc9183; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PBjq0sNO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OEMlA7351755;
	Tue, 24 Feb 2026 17:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2025-04-25; bh=odPDyswV0BwJJJa8X1yi6II+j62heL9JGS7dcRErY14=; b=
	PfGc9183TEw71/M07e3NpvDEpuk9wLuPzAsivxJic4Rf/5qrCBWFad3afv52MA+r
	BPq48OUMsJwTLw4ycIlOBNY5mJHknTo3IheQLLzICLFzMBQ0wKylkhDjfre3VF9D
	4YDs6ZmskhFsiP9ZgzTLRmZXIvYCfazbL6rC3PyBtli3NvpW+yk63RnGKeRG+54l
	L32WsQty63n9IQxut1p60YMjs4zotaH9kCDHu0gB6LQ1EqpFHPDa68FQ70AZGg9Z
	XC99igJ6YXRcSx+Lb1xmM3B4KahkzV401W4GrVt0V0m1Fq6gG41z1cYr5Kb+4w0s
	z5dkfHYUjAWBTSQ2SL4L5g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arcn36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 17:10:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61OG8eQR006268;
	Tue, 24 Feb 2026 17:10:33 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35a7syu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 17:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Le5w0/3xF/rC7Awt+eEBOk6CWAITf+r2+A/daUgrIqW/g2J6LGXPB8GcMisOJBjOAiMvwr7PCWE9/ZA1d6C4YPvFNiPPjIu/ceQc9qWN2KYVuQpeJST7XfjNXOK5ADKEPABWotukqk4tecU/hDWUaGXVSjcg1T5ajkc3KNS/AaW/FmHRG6h1z1CSPue6LSc5LVvEOZ2KbtxDQ5CNsakNPdKtD2x6G5XfeLL/qmGhH42qyafKgNo+EvXmOtPLvs5zMyaW94/7q2vIMC6wbLjb99dHLUmaelANWtClhBC+7cVYvHB0d3RCj7/7/gNV/UkQQq7pgp4uHraTn4sZlXrG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odPDyswV0BwJJJa8X1yi6II+j62heL9JGS7dcRErY14=;
 b=X3sjb8/n3TVk92BVaqhMo/6+zyg/B01FIys6i5uhvVqz6aYbGVeHnrX42S+KhUov0mbnkUDa5ETbfGQCkEjIeuOMLbl/LNB2jw+lKnvwxYDGH3lMMpMdxPfGBA3EChw4hmHoGsL/p68ZBBnDSxtIcEev9S1uIUdDciD02gkcHb71ZWt7ATZBpAITOOQH5H0NzBKfZ4PJvL9O4TJ6R36DUdPBFgk0wiwNL2JMUkbT2BvbsSoEnOPWIJ1oKzSuR/tD3LQwAP3JJcWOVFv5BoVDBbV7brrNAXWVAGV6VvKijDgd6Uc1562WlxmZwazlQMG3oyvKZNq5T32kB/QZbNDUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odPDyswV0BwJJJa8X1yi6II+j62heL9JGS7dcRErY14=;
 b=PBjq0sNO2hqNZXMB/RASAaUO969t8RCDHb4wAg9sgUMUi5tPwpetiMVF8zz6VuXM9G5T8JCxZmO5HQLELNbGPj52VNr0TZYl9MXtKPBKvhnDje8bbtuW4I7aUO657Yl0VqTJJO89/ew/x5uqBZSPbBTwZt/H9Kn861KLqrOLQqw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 17:10:29 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 17:10:29 +0000
Date: Tue, 24 Feb 2026 12:10:26 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [LSF/MM/BPF TOPIC] Page cache tracking with the Maple Tree
Message-ID: <biynsvpcamct5fva5nxxdvc3q43dqi72jotpyasvrk3pumdz2w@7okprmuwznlo>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0485.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e951484-6a56-45eb-19b1-08de73c79c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z327lOSuOFYagJMJdaKHsT0cfDcFLrTmCapper8pkVWirhvCPdfzHi6pCM9T?=
 =?us-ascii?Q?lptSjTRGlQLfyEUQgcrC5ZqZTJd45ItcQM+JC650bLCVlCBzv+gxodiPCy11?=
 =?us-ascii?Q?rq4zZzP5+/5SK5EKz4gXu82jQMgs9yBmiFcI2gcGBFCDBiffOrKWBO5jPVbQ?=
 =?us-ascii?Q?M0UeygQnAt/D+5uPWBIty5hnuiem3YdvMVbvUiLr+VQLZw8R68jj7JmqU+w/?=
 =?us-ascii?Q?RTKfSNkW+RaB5+zJM7awISj7Jg4dAgwhbRKd2+RJ9IgVka2Ktx2E/pMiF3lF?=
 =?us-ascii?Q?gfcaq7KxATZwFRucTjnIcBeuJUrCVcvayAcVRI1La9laaGZn+lIx/fqc4sfj?=
 =?us-ascii?Q?S++ixwfn5K4VkhCZfDq9Y6IWDwbkX47wrtycvId/aV7siSJFQIDbFxH7yYdp?=
 =?us-ascii?Q?Z4uEUM6dXJa/igYxhF++pzhmoCzuqmqFwjhXrsxf/5hndHk1hjLgGqwFCQu3?=
 =?us-ascii?Q?0byzQZ0LEJSiq2Z4k29XDV6YXCpQmfcss+QenvsifN4W79H/uspdDh2xy2uf?=
 =?us-ascii?Q?HKn0LmeTH+aTEhJZJS15uqH2BCV360xoji4ve56nX9up6LJIDr4uVQABPtoD?=
 =?us-ascii?Q?RY6UfXVLn+myo1Zq+wrihIgYRxu5pvth6XLt7quN/O+Ue3zgEXVf9FXgr/70?=
 =?us-ascii?Q?Xq/2GpdrZikBnz8U6VlYio1HQokMyhqmFWjbzMfD1o0wrFKHJ19A9WuYRQ5x?=
 =?us-ascii?Q?orHjGw1/wo08uJ6lSp7UCxgd8aL1ZfTTQhU/QFAZ6RbvLMXX7rztYdTnICHn?=
 =?us-ascii?Q?0du1G2lF2bC//Ci1S0CXM8MdujbYHd0CVwI/zv72slk3NXFXmHlYwdUap2b7?=
 =?us-ascii?Q?waFYEGSTVtDWyPsgIfZ3ubcUev7sHhvQ3kXEhbsSyxT1mkPxKbTqqK5bVjCB?=
 =?us-ascii?Q?gRRranzPjJ7QY9O8vBugiQ2xQpGvlb26CC+DFvdmUYPBl4+z5H0qNWcx70/5?=
 =?us-ascii?Q?xC+CxRSSlCLl2Kz5DJYeYmD01OuX/mscY//3I3/Ui0yuyZB2JpZW2PhZUyu7?=
 =?us-ascii?Q?xlQuQ43HyBq4TD5Vy9oq/kT/nP9gA6vMWWkl71QaDOU+qdarTzxMVTGn/DBU?=
 =?us-ascii?Q?5ZjpR/9M2j5YVudf6om7Eu4ojO+zlbnuXOAFhr6ehTHh2cnMZPKGSTSrdqBo?=
 =?us-ascii?Q?pl0hKf+70wk50RoPjgqfMOFoHA98OlirCEbtCaU+JBZh9qKpP2we+3oLL2Td?=
 =?us-ascii?Q?9qlvFY7n0/Ya7LZCTwOMhe3qWrjN7iSv5FJGEyVN/PPRDMNwqeRIh+RmMUkt?=
 =?us-ascii?Q?FCv08MokynZcfQvaqIWpJizo7tEsZxMvb92GXstQa/CM7XdJPRHr+u+Lxa3G?=
 =?us-ascii?Q?y/T8X5d9NE7gAWv/pQBq1rEvjgFl8Z+AqoxA0AcTfVlE80EjhZYmdLKkV9mh?=
 =?us-ascii?Q?JfBz4/dZ67Gy43JNgKacoPvR7ZGLc4wLQyDDHrC+ypdVqDC2natNQdr3vhq/?=
 =?us-ascii?Q?DluQ2oTPN/5/3wVVvSjGCAApz13TrRzq6xJSs7G1rTzu1Q1QpvNjcBlV6/lR?=
 =?us-ascii?Q?B2YCAaUHSV6+NItThzYQptQ2irvnvhP3m9cl2sTyHk5TH7UFomm+FvPz31pE?=
 =?us-ascii?Q?meKpya7LPyTJVdF2s3c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wi9o9DROVpHO9wiTdzJLBVQ3/jwXTNBk5nTMFm+vm+lskb/1Mjj6h9lGZz6l?=
 =?us-ascii?Q?5e9OT0vFY7j06WhWHCnObzZLNdyU0vo0ksMRsmp2PTaLFdeqVLqfhaVqg/Po?=
 =?us-ascii?Q?2+2IpfUBicoKsARBMCbbeyoZtPvNgLmyoVhXUG3ydMd8lCh8NHRO1v2iNmMO?=
 =?us-ascii?Q?hzFGALDRYtI28v45IFQ9KM8ayvWQKrZzAt8eQ96eKT1uGtBeoFJdGDH+I+zj?=
 =?us-ascii?Q?CgwRevLVSgYnNADIveYBaSacYOf0PeQAhWolY2xv5Di9AKrOSSQnpa95SSQj?=
 =?us-ascii?Q?w5YlOfYG5SvcG8vLZLt/+M+takszFeji2Ps7jXYIY/jwfbeOOJ9UHkoEEZpF?=
 =?us-ascii?Q?8jRNNVhqz8WOrb38Rfr0je/njOxp3pGGMjRU28yb+Q06Ku3BrvykEqsx+uez?=
 =?us-ascii?Q?RMMYIqmAxu2SSTQViDvuSCRDTPyc9Y+RUI89Nfn7rrQZIKJwNq5Z7xBcyc7V?=
 =?us-ascii?Q?jFEoUSQcw2TtYQfUVcgeYiEAr12+M2BNJC6irpzxBmckKJcSxALEeZtIzHPW?=
 =?us-ascii?Q?aZytJ8QxfTMNl/xy4sY7zHnsfnZZCIAUrZjjG2RnQ/i4by0XELPcu1um035+?=
 =?us-ascii?Q?eiyALiTjmR1SMHwOSnk7AAymYrRdeSIv20XDb9dqj0z6qaA1/SCkya+/26eT?=
 =?us-ascii?Q?VZPLQuNsHd7qhcrCwMNIY9Tl9uXZA0TNx9DqhtBj3icE3D7FaeQZkRqy24u8?=
 =?us-ascii?Q?6uHROmNc/Xb8+6hivY7ypj3B2szyi6PLv4M9GuOquBDpZfXNgIgc4akh7Hff?=
 =?us-ascii?Q?v9DjqW6ZFxe58bwsppCqToODefocYCRQNXrpLYmpH2Eca8i44rez49xxX/Sc?=
 =?us-ascii?Q?uyhkfr/JcZPSTtKfCNVKfk8wxrNcoYAhHaHnpM03FIC0Fx8e6wWi8JnPGY/k?=
 =?us-ascii?Q?UprQ8LeKn46DBHQ3RVgVvpTYSIbG3+6ZlHguilCKnv0JO1wlxfthmhwRblEb?=
 =?us-ascii?Q?Xe8CuCo0dN2LmJdaNBXeH6cCrt66CIvEWAWjjINAF5/HbpbLfr+NT6SBcWlL?=
 =?us-ascii?Q?8fzYQIBAClfR2pjJMA4oALSFsuwk6hqkXYEIVE+eTOOYw5xzkZUKtOjILnpm?=
 =?us-ascii?Q?juhzCkVKfZ/6felR79Jm0GpS/hVp3XAezPlRVOJl5dbKvlb6WCQOWzhxE18M?=
 =?us-ascii?Q?O2YuQSbEtHWBtXov6C9WGVB5gQmlz5q3sfyJHDD2ffZJG0VH4FhnQbZ0EyDF?=
 =?us-ascii?Q?QcZ/3+NP9OruKdUUXumKYjqBLKKQlhxoPs2vwYeh83t97kqVOp5U2gJoavRr?=
 =?us-ascii?Q?RfT6GTfrwCL+JUTgIx8Y7Omg4MrGOKbsHOP7atTdlGr4crK98TzZr9RNieVt?=
 =?us-ascii?Q?S2qlQUFCSz+LZQ9SWrRHLOpHNHJlScMSM6CNHG/DMaGCIZrhGn8h28SSYEiW?=
 =?us-ascii?Q?Wv9nSyivfyvLlMwykd+ypw4jCvoEIW8nUlT0IJ2BTnnlAX0N0sjmsvt0+Pfd?=
 =?us-ascii?Q?HVJm4hHxVSzWUChU9VBFE4wrhbpgFgVAdEZU6RLQoPX7qxgHSls6Mb/NJgrR?=
 =?us-ascii?Q?MOENnozJsyooUmz/QQFG+lHt1m/z7JWpt48te0TgHngdAgctgm0b6QHEn53n?=
 =?us-ascii?Q?BMD16esfacix8nel0lezKc0A2EnYK7TUgPV7Coa3HH34TGXBojAU/d57Y283?=
 =?us-ascii?Q?q9yib2F4tYbv1U5R6/8T8uka85MStTm0EBu29ri3gKtunwf0Dwj7zVc03/nb?=
 =?us-ascii?Q?2mLaaxqP+nZ6jFjPA1HKaKAggiBiLqEclSH8izBom8tcidon0B2x9tNWtmkD?=
 =?us-ascii?Q?dn/HPBO0zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t92105ZdVVqRm6w9sDSDz/iFe/ZbE9ZRNzCAR+9wGDSLZgisKmoTai3zHrXoKIjxAsdtV6aIweWwnEYRs+4ZkT3lW1pAFEGnmclaDQ7ZpF2O3P+Zx5HGpDTbUC3m3Xm0lKZ14/6H1s4XjKbnWa3vAgP/XyoYuLj4QDlRVZ/QmM+uXu098MDaDgc3FKQKeseImj2atqJp1gfZavUAWujm+qsna5HbeFzttkBjiaL89z57d7CLhhEGAfn8VSQKetBKfmVGRGT2KZE7znMbn1SrnfKwAv1jpVQv2xH2sWlR7KFWRS1BvAkHgRkUH/mXvgt88x86l+dow8FC3SyTav6nw9C8yK8/m4w6D1w9ki0c9EnB/VdTMTuiVvTvEEUVIRPjgYrwxUCla0QDU+YE8O5BIau7wMWXTFuPCjylRO1tq8m9YPdFvtMRgs8fUDFmPFA7A/nL0/RL08MOoLcDBTeUTdhEAaHizQyyIc5KJfQH+Wweq94mMZgKjWS2B2kROwCBV666SNVM+0j9aNajpeIFJxEj+Ufh5EX4x3HmIEn2fPAFXHphmTsINBgvqc+MLRPHtuSLqKiUmusPmZg9dbIYzxOGfv4Evqid+ln7hRtWfok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e951484-6a56-45eb-19b1-08de73c79c1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 17:10:28.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvQZMgNNIW2RhqiDGwYxw47eoZ10Dl2/Swk0ZGCzq6KYRSeSED3XULDtc4SEDSxaL9CGfrpc2m6ieLX3u4VabA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=961 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240144
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=699ddb8a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=2PjZT2aeU3qLgVbkA2EA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: jHd2wlG12CB-zoXVp7X0hCVzOoMcHnH-
X-Proofpoint-GUID: jHd2wlG12CB-zoXVp7X0hCVzOoMcHnH-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE0NCBTYWx0ZWRfX3YZJd47GAPkw
 0ZsX/SFt/5GMGcNoZuuxwiYqpwO2mL/sADt0dtsqLXoS29iWrf/LlmP5uh92GTWuOFcl2QR2f12
 brinV3/axjldsDdICK07q15g/gt6sQ5wD8JWI54Bq69wYstDXEoP1mlKDTmiCnQM45s5KBdSXe1
 7CX++K2yRKqWNXiEge9YaeVCzVEUVfwiWlYogDGdw1U8c8s+1vUQ+/ydAnzlMtmRJNn8Gz6NBNP
 PIKw7DOsR7uSeO8CNpeuYe0+QDF+4CjAko78DTef/rZVfT7DRx/JX7VMQGGU6O4sIaJsTYmlhkW
 DeSFfHAuo7jaPdRQp5+pTwElo1AM+D2+enG4Xx9pm7wZ5wTjuUbcZn3FUebDJ2jtU1Vjwcvz3oi
 UUIZKWMx9XrjjC0GVOrf05SJvU8jpLvEiXKCon7e2AU+Ukk9dc9AmLUJQHiGDANeWziU+Q5Svkl
 iFD+CWHAfYM2MUoWkeQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78291-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Liam.Howlett@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EB52618A5B4
X-Rspamd-Action: no action

Hi,

The page cache currently uses a radix tree to store folios.  There are several
well-known deficiencies to this approach:
 - Inefficient representation of large folios
 - Inefficient representation of sparsely accessed files
 - Poor cache locality
 - Supports 3 search marks

The Maple Tree solves these problems more efficiently than the XArray.  In this
session, I'd like to discuss what needs to happen to change from using the
XArray to the Maple Tree for the page cache.

The Maple Tree needs some enhancements:
 - New node type to efficiently support entries of length of 1
 - New node type to support marks
 - Searching and iterating over marks
 - Support for purging shadow entries from the page cache

The motivation, beyond potential performance gains and memory footprint,
is to support more features natively in the data structure.

Thanks,
Liam

