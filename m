Return-Path: <linux-fsdevel+bounces-36480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBD89E3EDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA091B3D63D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB320C479;
	Wed,  4 Dec 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F0/oY3sX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i/3/y9Ba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB320C03E;
	Wed,  4 Dec 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327190; cv=fail; b=narRhpyOXc8cGPdwDXXSIhvyom3cTorZtfb9BhC7wqiZj6ulef8VEwg17TaUJ3cg+stvQo4S0gTPqdc7HgDJJtykHZsM2RxPHH1ukYIbqo0OkTe+BLKIT6KD3LHDPX27V70yHiLPcxek1SODRZf/7hoYZFjcFv1cTWF5xJyv7m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327190; c=relaxed/simple;
	bh=T/H0MQl6+6wQP89dXD/1cxALDZ5syofyLVpY8AZVQvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOUsmuzXk5Q/+3yz/LAWCaT2dFelBHOHC+cuHy80dUrZiCUSdoN+llCqcDAsCFZjA0ZX6ssBRN2Mmbd3v+ouwF+czpH+uJNXecNaFSQRx5u5o2z1rg1oBPqS+Iu0/RGxP+2W5hHHiMSpGW1XVORuV0ItEF5/iKsXCzsNCeTFwhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F0/oY3sX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i/3/y9Ba; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4D0j9i028121;
	Wed, 4 Dec 2024 15:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FJa2FYn+l3JgVXkyj+HzJHLUFWBrqtA+vCZJkGiC1zk=; b=
	F0/oY3sX5hWYqWUrlj7Fn2wyxfLaOjrgiT3Jktn4Lyw3vjZArirwXITR8CLCGz9l
	MGao/8CjWykxj+SKcQFsSAIJtvTmjAkfWAf5NAuxFRQYpo5m+JradrXtqF8RqZo/
	dEphaBFszHe+x9OGu+kLGgGSj/Z4VZwAZ8B0KthKTUa8+tYhn5LDwqIuKsrVqb6u
	dAB24kICtLHzXXm3YEpA7s0WAeR1snUfyiz8ZuDWirsZx/XX+HcdMi3hJleip+FU
	K/eSlp31io/0mI81epPeLL528C5isQ+Wi1rxka5da1a74d311OPQrn0uV1kcT1Nh
	c45sCogz2D8vt2QZX1zCKg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbrv4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 15:44:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4EgUcb020166;
	Wed, 4 Dec 2024 15:44:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wje6u82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 15:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5PRz1UYqLXZ9lEtl7+u2KXaWTeBagWB0oclURCXYe3he1K9PtYmDO2z1s74BXQlnffR/3ARPhLtUzYWKNOXGLpfIACCDv2P1IKC16/yUlQ2/mogXOb234t6stKcwqleJqYbV0I4leHiUJhpoiuPMn5W54rYKscCFFbch3ifEWi8lmpKgeWq3wrlBW/C/LJXI9NnG/aeQu+4jzTecAl6kzfj5i+FSRArLPTiAkHqlfar7v/ojghC8g0gGnsAR/np1iqIFaxwuOul4xVmdylQen4Hndpr1935rD8NIIZ2oHc6zxvYFYHkEtzOUplsrr21TUBmV7Gf95vHGzpUr44mAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJa2FYn+l3JgVXkyj+HzJHLUFWBrqtA+vCZJkGiC1zk=;
 b=uFNjJNgucaFdhTx0nMRpUtSCiwD/kpAgyxULZSs02tTAytSqUC31N8rme2Udb4ckA2rIpxhdC1T72aUYYofgSaT1UkZXIsl5Ts6OipmrjpKxXxjulKqNkUzvbdqF7PZfPhNlGQWHVf1tfo76qlALoI87DycZ3uHKzH9HvfMqWyI5JkBqYOlwJ7h5y3lK7CdA837ra39TYdWq9HDZPfzrJEM+qSqnlCx57qd6pnAdYfa5qXDXg9S3inwJL/QVqDCgRXfwj+lzk+xTlYH5hT7VrF+p+fOXb16GUdrazBv+RM+EHaci+tL+DDVjiu7/kdlSB8NBBRkvRFwqVMNetq2QCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJa2FYn+l3JgVXkyj+HzJHLUFWBrqtA+vCZJkGiC1zk=;
 b=i/3/y9BaNOF5hlEZJKndRcYAJcCPiyY7uDeqOMmQqhPjDd4ZAN9C2nJWGYvNC35vHvrNdXBU6AFHOHjwEjF5d24warZ3I9G3ojH5D6C8c+sNgWBwNSs047RYOJVvPUcjDhyCRvoHKtw4zixO1GbBZnxbKI9pjJN0oawEzqCGryE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB7995.namprd10.prod.outlook.com (2603:10b6:208:50d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 15:43:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 15:43:59 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 4/4] xfs: Update xfs_get_atomic_write_attr() for large atomic writes
Date: Wed,  4 Dec 2024 15:43:44 +0000
Message-Id: <20241204154344.3034362-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241204154344.3034362-1-john.g.garry@oracle.com>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF0001641A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: c7204be3-cd4d-4fd7-207c-08dd147a7811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cZNDAYkwdFXJr2F/r92k363L6YIkVvj3znHgYo8vd7G2eQwR62auAS3XfPEq?=
 =?us-ascii?Q?cyokJhzLizhzvyhdSVwmyDxt5nvunFri3fIlKHW/vEo0Fu80w4D/FkCljy94?=
 =?us-ascii?Q?XShR6G/APXaYITaJ/bTQEZVPeu4t2Bbyl3h8/xSlbzbqCClB7eOscgHIAr5z?=
 =?us-ascii?Q?FriE1S8i/t8+Ao3Tq0KB2Rr7lKJjy7QVal4PT8LF/icW0PTrxjNxqGqupjtd?=
 =?us-ascii?Q?MfkL45xXZsedwvYEBMnMc2L9CXFlb3p4D+RKunC8HEk2hEihl/+1vC2W+qBM?=
 =?us-ascii?Q?jeRsMbnsQ+RBg7/fEaiIBNOJN2jBGhwjIgPIW2fB+tESYwUb+Rq1ndq/WwkP?=
 =?us-ascii?Q?++Wt2UZw+a13hi9FAk5QI0zHjGqeLWEya63K6xULoTixY67xqz1l3Iupp3tW?=
 =?us-ascii?Q?YkwEuINzkvHeGlor8kFIvschaXOZkwEHKEl0kXJtFdsElL8I/jg3tg05JnuQ?=
 =?us-ascii?Q?8QN9kjcNR6klo49oH2ISyVk3etiWv3YTNp8VnlAOgCAWUhBWeigcWMvhpuFA?=
 =?us-ascii?Q?HDzJOYZe6YODA7DiksI6LWgb0TfsrahfocO2ZCwC/Zd8tustlIdBjMhjTM6G?=
 =?us-ascii?Q?yCb9oBLIqu05lG2aOWtBV0hXtrkDd+kJp+ASwlu2GePnmuCeAK1FeC80/RLX?=
 =?us-ascii?Q?BGagTZQ5pgfK/5yDK0YE00lP8OfmuYmDVEPwxL+QY3vAIWZwozZN6z1CZ5Bu?=
 =?us-ascii?Q?7P3rxl4RQqM0+4fdOABO+kvkGDBBTWeYSl5C+qtKsJ4hVo4CP1i+qzknQibP?=
 =?us-ascii?Q?BIljZZeDcBKCIl8WI4ETCjbHWQgVbVds84vPNt9uJqGZxFfYyJ3gk1HPhXgK?=
 =?us-ascii?Q?un0O6/47vnAKSYF920pO8RogT3JEtgwMfZ3TKtOAZLiQ3Fr1yy5IlavGuGp7?=
 =?us-ascii?Q?bLq2XFDd3+8boJkLLj5xrmLVkBTt5bg89FognF3/XgK7AdfCyB2K4dmjJxDW?=
 =?us-ascii?Q?Qj7rwOzluEyezVNR/mDM2y/xExc0PWqlUIGJNBinhjbi4jmtU+8WSbrPaitz?=
 =?us-ascii?Q?YRH0r9Vcr8kywmWyoOqGE3W3hfdc3J3UZM8Uf71BtNuHqdpH0zL0rs9vsGaN?=
 =?us-ascii?Q?lnglWqqPc1ppN5UDzv81h/j7YYELFcFhN004gwOwvu1U1gPxUBRoXVb2o1tw?=
 =?us-ascii?Q?TEG+lrCb5mzVyOFX2q/QZhYhXWWElPoLs3ZaMcKCS6vEZ/qy9XyWQUlFc1dF?=
 =?us-ascii?Q?Bc2zEszvk9z8d3uq4Tujptwn6KTYTEtNgqSDmTUiWUz98HlNrnfnEUyLclPA?=
 =?us-ascii?Q?wXckxTWQcJV0DPBZgUaqQKwGGRcxTO1XLcDw63zxr1oMozEVI3GBLLZu6p6/?=
 =?us-ascii?Q?q2JnmL0I/rScl2VU9uNBesyb1boPn4/UGtSmOvojuS9nOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GkSExHr/iaYP5HxCtEOGREDRRFf8aR6yHAJRzukFCqoYVqBd7+sKJMVTVV80?=
 =?us-ascii?Q?eEgYU3dB2Hzk3CbwA8FQwkk0V9Kmkz5DlqvkAw0D8OCV+pPeknGcmdQkdDQh?=
 =?us-ascii?Q?bixbHsn/enuLHi3ibakmp2/UxyiQEvalfEcuEkV26ylo20ZvDPc+0UfhdApb?=
 =?us-ascii?Q?4mAyABNNskugG7GnUogtHjt8JjvnkkoOfgopZljJ33ObNP/yURKtYqFDnvJY?=
 =?us-ascii?Q?Vc+cVEqQspGpEYDppJBWPGPrGVPBJ2B8c9aMtdbRbLixGg5BvowsZoonlXmk?=
 =?us-ascii?Q?Ypr1tZQbU9KJSazdOtPvdUtDeW1G4t1+A88LlMMdPOUD+MAtgpsKSKIaPsqU?=
 =?us-ascii?Q?2LR+pMAiYsdNzvW6Lj2Bc/bESQrftHzVex2XEkoIwuQ8SL9t4P0vHHwLDtv+?=
 =?us-ascii?Q?7HMsrF4yl+XN5xj772DSYHljB3j5P782mFrbbDzz4ZfAN7kf9/oNuZ8uX2IW?=
 =?us-ascii?Q?YBx0gXpX5kdHdJJsFx8PWYvxxkVT0LO+o+eAMzQB3z7UHbaEdYVQo8rN+MUD?=
 =?us-ascii?Q?t3OEC3lmEbEY8eFfQ5wMFzinCX4wH0Dxz7C1ZQxR8bmiijXAPIAIMZFazlnO?=
 =?us-ascii?Q?KzDV8zBHxyPDsMw5ePUQyOhsXSTtiirByZPWwroc7phueeduxDtUk4oVmEjf?=
 =?us-ascii?Q?EZrA+VEn+XLfZTVK1LFa+dU5Mi3lNQ54AxzE5ncHk4uHiXbtLv5B7SCuRYdV?=
 =?us-ascii?Q?TtLIQQMkUA98r8nYe0QdekK/Boq2u8suG24mB2gJYJfMrfsiQGKpvR9ZUAYR?=
 =?us-ascii?Q?QUY4dvsqzF098lKUdiU5frA8VWpE1kJJGOeAE9kEzYLeJE+dfHCKvH+vOO/m?=
 =?us-ascii?Q?gQzeXuf9HZ9eCc5FhvNEuyQ8ABdZE4w3Gr9NkRQkqDxLh4aGrgLpKu5V+wzr?=
 =?us-ascii?Q?JHCqmh0QgU1jZCTsJP8r1hogZY2xgqDU4RrwMM1BEFMnmpiV5kOKEqeuuRpG?=
 =?us-ascii?Q?G/EKdrV7N90tW7ONI47tHUB6oPffjJOQKSgthfuMPm7dyhqKGpM37UilBPjr?=
 =?us-ascii?Q?Puw3VmWyfdneVoekeN9YHW9eaqm798WZNy+qAhDzNcfx2CebPhvCyDlR8zoL?=
 =?us-ascii?Q?dPmEfvYiEb5EIM3LWgNPCw4aPbrLNcJky5jzp0hvcnb7YiNwV7mWXYX/lcBE?=
 =?us-ascii?Q?RDgypSRhad4TvoVHwR+aCo0u7wh55bOLnTpULmv8nSOMx+IhB86iMr6sPob3?=
 =?us-ascii?Q?NJBSxz0pDv+F5TB+P3rSRxrhXqINrx9GstNl1ES4tLlBYGmmbDK0MelSSWyC?=
 =?us-ascii?Q?7tTrRISxdA5iq3iJ7aUm8ghrgC/iIjgkN4u5Vx7xBrUNJiMBH+CFokLADVD1?=
 =?us-ascii?Q?KvzUiUXpmpS5WuZi2zyKfeVNVLoiy4Ab1AVgRFZKuGWcydN0r8i/e7/9PEUQ?=
 =?us-ascii?Q?2TRkfyiRFTbuA5jHsnG213WmIxBYejRLW9M7kHZfuj5KABy0kexISD7n9WBY?=
 =?us-ascii?Q?AX4DwX3PM0hR/bQ9FiqroV6cIAevtdCpDObeHsscci3nstcf5i0Iz/oYfkvJ?=
 =?us-ascii?Q?C7dwuTtRF1Z3RxI8IAF9doj9G0MzxKXrT1Dr9xm++XUmdCuOYIkhx1iT1Wg+?=
 =?us-ascii?Q?qpqpC+crjskHQ9kALWAUf/aAFQlx1QeadSzUbDmNWGglC7pMJRj7nneK5baD?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	svCR47h+PFsWVKzUrfnj925zebZMIpuRDtMbNmb4Ogc/xodBHfMhVOS5+49Q1GwU6Cr6w2yU3s/+UXU+pZ2Lb1Snr/XJ7jIX1rPiHfo1khpMAVNMPVqjuU63qoFaSnVYT7ocedvId3nYy2JnvvSZggi6DkXBPoY/LdbJAAF7Qx9AA2jA13Tn5miTfF48z+Ezn91a29IKguPNDVz9kbwpiJRITWibEtZ3Huak7dXnqqzO6AQL8fjQVRSKJugsxdXcryzTbeBQpsFCQ28E6C3i4ymjXMvknK1iJDDSSZdJ1Xum58e6gVSX1O4D0sN0k5A45pkWZepZ+0sODIf91ZCp2xJyWxKnHaBuxhHHX5EMT4Ra9X8hLlFHCXsm7GAvBQiHcfMiGAKdXI5BiyR8a3mgBB752TIk3xILiqTidyfYot3FD1kKjuvkh8fkRu7jIndPQGwwzO7O6F79i28xlp16d3VqVdQ59+zVyban0Tew1PuAvVfU33JfxSrB3UhWyQExwi4ARMXPAEZWvtpOYZA/L3rl5VH0P3V0adiVoC9xweP/46p6a8fVJuqcT0hJ/UYC6MWGwhDfGmO0yRaXvyZOcLFlX0BQrJdZLs7e8Rs0iVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7204be3-cd4d-4fd7-207c-08dd147a7811
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:43:59.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiRb5zq2yfAPvaEOmoZrruDAsEsKo0l6YrtHDWwqf8ZzIhDWYrDt4iV9plspVnKBQminJkh5FqtGqM2cgPsrcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_12,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412040120
X-Proofpoint-GUID: G9SlntbuIxrtUYQYTSlqnXQSKO92lXtf
X-Proofpoint-ORIG-GUID: G9SlntbuIxrtUYQYTSlqnXQSKO92lXtf

Update xfs_get_atomic_write_attr() to take into account that rtvol can
support atomic writes spanning multiple FS blocks.

For non-rtvol, we are still limited in min and max by the blocksize.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 883ec45ae708..75fb3738cb76 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -572,18 +572,35 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
+/* Returns max atomic write unit for a file, in bytes. */
+static unsigned int
+xfs_inode_atomicwrite_max(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		return mp->m_rt_awu_max;
+
+	return mp->m_sb.sb_blocksize;
+}
+
 void
 xfs_get_atomic_write_attr(
 	struct xfs_inode	*ip,
 	unsigned int		*unit_min,
 	unsigned int		*unit_max)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	unsigned int		awu_max = xfs_inode_atomicwrite_max(ip);
+
 	if (!xfs_inode_can_atomicwrite(ip)) {
 		*unit_min = *unit_max = 0;
 		return;
 	}
 
-	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+	*unit_min = ip->i_mount->m_sb.sb_blocksize;
+	*unit_max =  min(target->bt_bdev_awu_max, awu_max);
 }
 
 STATIC int
-- 
2.31.1


