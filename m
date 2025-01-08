Return-Path: <linux-fsdevel+bounces-38675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C787A066A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 21:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802023A29BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 20:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D82040B6;
	Wed,  8 Jan 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BUOzSCsd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hFsSw2gi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53681FA15F;
	Wed,  8 Jan 2025 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369692; cv=fail; b=GCkFWC50OiyR7h2CTFzWDOG67UgMm2Du0w3a+E2x8v8uqvZfyIj3gXutCivWJg+CyYD3eMP4/urtJS55UjlDlbWo15tjkqwVZhxYF2MPNzTQJiKi6go7aXvaWGI1+lHGt7UKebBJT+UJkcYXqpnGtLZUIwKVGyS07a0oB/c2JZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369692; c=relaxed/simple;
	bh=OmUTbbN8c6ITg0pYT/SySBS6ZHcOFJIXCudJF3y7S8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TTd96CNzQCyj37bpsJe30SwXCsOEslJryUzOjWM2D7X3/ijHiHWZWq6XgsqXzBHhSlH2XNOwASAXyaH0Vz2Dp2asyAuZUWWDVi4f/zv/+jBwV20b3I3Ov6a1nRqvujUxKLFaNqyOuAkoWJpbxlkv5/hbmWFTneqkFrbARyc8FRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BUOzSCsd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hFsSw2gi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508INEVc029693;
	Wed, 8 Jan 2025 20:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=vTf9nz2+UmYFR7bd62
	Tz/vb1/rZTIifnKN9rsIUHWVg=; b=BUOzSCsdmSqmOrqlwxxj7mErnZ8+6k9XAm
	jnUwuCVKOmupiKLSvGQG1E4oi2XUpo6RUWPHA4oNJAdSGWJHebEUKeGW8IcHGeuP
	jJHZGtAACzgaHH6mG8EdwS/3+H4uVUCll96tU0S1vTRpEJ+ZaX8vH08i/K53da9R
	eBVMRe16D41sHeoudFYnVL3lUklCG4+8kR02UvaPHVO3yjr0Jv2l2KFv3SEN1IVj
	DFAax927NyHaSC6FV6uVyZeOPs4uaI/3TlG7r1/gk1adVop0UAFYbh82PoMfVk1V
	veXhBMWbylqxxn3zUxBk73DFQ+4bxEwthkcPtg/WK0ld4McVz8kQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk08096-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 20:54:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508K9HrT022602;
	Wed, 8 Jan 2025 20:54:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea8cg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 20:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV6Ex+mQs5Phf9cWpk92RYftBVm06EKhxQUs3E9Fb30DyJfMZY2EKcCIEoTl4GdjbysmBxWb1dZClOVX8hS+orTCDhahwF4fIk3f6LbqvbAcQeiVHiRtjXAgC95rX3p2Jhxo57gFXf1Pa+Oh1PbUTCgDt7P+1jG7oXyRNHt9RtShVD0+bbNRfvuYqfPPQOjYG7PvuJeiQ2uLiR/07KWECb+juJcygRPNGB4OObIaJumPehTjEbkob9R0PoiiF8GfWVX627foSYU851KCM69SdmK6Gj+NCIgeeO6PS/d7VBNd5W15PPqoRp+tnuTlPB3XyP+6yowyDXe/5bJUyje/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTf9nz2+UmYFR7bd62Tz/vb1/rZTIifnKN9rsIUHWVg=;
 b=HjfJDba7AhWJkva8Kv3hMotYhFWG2JiSPennnWLXYkzMvlQd+hknoQQMq58G1CBJdZZyurVMf/8CG3ai9133ZLHdqZUruTe+nXALXyxZPN3Yd5fL8GiPbnO6+dng4GSmZDbPuiJkEDaNbromfHtN8dUK/VErt3XWzVuXHZ643GrDTfBSq/yC0C9/KTKEn4jHHqWYKqqhLwuPRmviTFYc4ijPmgNSHFZg1YXJh7Z8wv/bZwGUqjvOKNGInRqvzuM7CL6fI6x9jkQGx9lqWHVPfZR2i1//tFGV2acCBIBwX58zVejfVzYFSGbe10OTGKLlIslt69w5bZa82QtRcaffkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTf9nz2+UmYFR7bd62Tz/vb1/rZTIifnKN9rsIUHWVg=;
 b=hFsSw2giaif3JykIQHdWIkqp/8YvDRqQ0t2tXWKRTm7jWiD5+0/BR9mwTIHXTMPAtMBiWPGO0z3vtp+3uqZWI2IaE/7FdF2URNQ+ypmwJ6MaiaSC0fWjIu/d0OpNHYcqFBdWx1xouhy9Y5LGrHD+Wh4JnknEDs01PPVhj0FLt4c=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB6423.namprd10.prod.outlook.com (2603:10b6:a03:44d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 20:54:32 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 20:54:32 +0000
Date: Wed, 8 Jan 2025 20:54:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, surenb@google.com,
        kaleshsingh@google.com, jstultz@google.com, aliceryhl@google.com,
        jeffxu@google.com, kees@kernel.org, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
Message-ID: <0d76351b-8b0d-4383-b188-c4c63d85733b@lucifer.local>
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-2-isaacmanjarres@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102233255.1180524-2-isaacmanjarres@google.com>
X-ClientProxiedBy: LO4P123CA0651.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: e62c9c94-29aa-4b8f-e8e7-08dd3026a706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uyyvK+TSOHnuNNAG7ALuuSdxluRxJzaMyykhFeolf95LQkX/ff6KSeXSW6mS?=
 =?us-ascii?Q?BgICu2WYUWIII6VIu6EXjoH4E1ZJv8D9tOxVYgs4xXyq4aGH9+jQmp9oDwRO?=
 =?us-ascii?Q?AulZewHxOzZsn8sBA8atBl3+5It8D0rB4N//3G14a0nGrpHUIN0LJ4nBuCuu?=
 =?us-ascii?Q?nM6vP8DjWi7J4INaX/l1I6Zv4xsQqr89wvg317cUc0FiTn19jYK7MzU8/3+4?=
 =?us-ascii?Q?EA27C5ihzaiB5oycICdnX/hLFGbnI3iyCige4zLMwtS+U+tkj8DHXgd/DrKY?=
 =?us-ascii?Q?Ru77ectfGIIv2el5KSXTWBSPeldQyzrlsSNeN7ElslH40C+bBHHqvF1WexBw?=
 =?us-ascii?Q?KJVQnqCJpeSPsg/uEfzkmB9gWLkOS+aMNpVtCUEgSztUyQZVKJ4i7MkPqTIw?=
 =?us-ascii?Q?TsS9boQYnUn1CBv7pYnOw49WOnGfwC2Co0ZyNWf5GpSoGbnIsjA7t4xu8xCm?=
 =?us-ascii?Q?GI2+5MOU9vcTq0cj41fVgcx6bidwLNJgZf2rhqldghZpTgP7WxKurbO1X58I?=
 =?us-ascii?Q?Z2BE6qnQ2uYcJUged6frzbWxmNzN44X+acvxtPQH1qcHaQbU6dRraPxbar9M?=
 =?us-ascii?Q?/MZ5FGsOGo2FoOEvs4NRb754hPcY5sNRHqFm9hH9OdQmHZ7tdqchcEu41bT2?=
 =?us-ascii?Q?I/4uUMd9xo88TG/QfFe3681/HNLwsjFIwJ5H7qtrKI/JwpKo2j4N/g3ffHKa?=
 =?us-ascii?Q?3d89jaGhHgRl3W6mCeZaAiFTetrb9uzz6rCKHZNFOmh6FTPxe1pgAtCQzvrT?=
 =?us-ascii?Q?mISx8A7OYGy7ZdAPbjTglXmZdAksJa7L1cRTw/6cBiXqdrqZYwbotGNnDOvf?=
 =?us-ascii?Q?fodGaHjilorz2S5wNhGvVBxJdWbmEUSCTA4iqYwcVVMh5vr1km0/GdrGyvF+?=
 =?us-ascii?Q?U0sY43KjYExVZMUrzsc1YCKZsUvyXXTsMtoXVHKa5uH2X8Iv6TRwvNtQ5KV5?=
 =?us-ascii?Q?KImAnjrF/Xq61C5Hacgq8K7NfpHCGqd/0OBydBRuGEiq6QYAQWClib0sCGqf?=
 =?us-ascii?Q?25cqEdWDX1QTkqNzJPLk77n0LPKXtU6Tv7qGX02lYpuo1AUHCNn9YkHpIhyI?=
 =?us-ascii?Q?hvA0paMoAH2CrQrWkOil0AFISgzFgv0ldnwarcTdhfS8R1mzE/U6mi4rizl3?=
 =?us-ascii?Q?LiI0xlo8HI0Sow7SK1Nfce9SUpkuZyHS/Qjui+87OFF3qhYI/R7WYvvcSqJw?=
 =?us-ascii?Q?k15zKX4ZEz8nf3lUgavTVKTGjPXsP7zi/6ypAGCeP+PIrR3UzBo9u2pfgf5R?=
 =?us-ascii?Q?MuGNjyVtYoRZsrZcUeaYc5lCopZAuhR2uyyZ5n7tKqyQ68NmNqh/GWF8o8zm?=
 =?us-ascii?Q?tFwuJ0EvoniGTfFiwKmlk8u+UUCbMTuJvXoduWUiaT82xIxw1l5EpWd5obLO?=
 =?us-ascii?Q?qRq4xX6AcIXMtlaTzjPhH/0T7dJA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yx2i0E7lN+H9q21TNN7a7yHCTZzTyO7/VdoOvskHHkzG+gwTgjMFWAoAzsl+?=
 =?us-ascii?Q?cswhBYDUSGe+hN/Jl/oY1VZFcjTq+u9Cqgv9JcRzz6X9ZMINmr40GCZytEOt?=
 =?us-ascii?Q?JS4jykEJ/Ik7PK0cHD2M8V4+YhBq2+NFjeD0qopwaWQRW+1Mua+HKi2IYC0h?=
 =?us-ascii?Q?NAvq7AgW1yglDFBBUMWMshWz1eFCQXZTFetsOnqRFfX4YsdBOEMSpU9uLoU1?=
 =?us-ascii?Q?/PyioQUHl/g/AGq+vynij7QJMQAZzga0ZE93RdfWnr0aEsDolJo8Msyu3RVd?=
 =?us-ascii?Q?ojvCbp3hVB57TcRJqjFG7rTEqPzEcCNWXxJdmxqnjfQr2MH5gd2qQkA0nyaf?=
 =?us-ascii?Q?wt5WaKr3oXtXf2tAWGlqRau3nGF7zXLC/QoWrrOaFwIb2gm9WNSdYhSqXvsC?=
 =?us-ascii?Q?rN9xV5CJKEgcli/lZY5EKuFrIFMlsN6+wyC6/w4tpxH5lWtWUOmN9PSkyBru?=
 =?us-ascii?Q?daFZKjbLNMYzrwwZ5vRfcYxgFu8DDckGunIf9X4RKFxVkMr3ncIMd5l/ds/F?=
 =?us-ascii?Q?/cuVPQbfVhHVEVdzx13aiYJSrNBvF6ovHtkDDQ4PrqG76yKHUqHkexxxDmkl?=
 =?us-ascii?Q?UItuU3oxysRhw/oUgz5HdpILmU254YrwGB2NICAzUCBwaiK+k5gqFpj2HJpu?=
 =?us-ascii?Q?tvQOkFCgucBHyYRIL5XdrxTw6SjBsk2SI4z4fkvOPU+Wv18+dFYRPoC3vIUC?=
 =?us-ascii?Q?BCkfWMcfo+ox1V8udt98lz0pfMrlNMsta/OomfScsFcKiyvMpCnwdVnCwmMl?=
 =?us-ascii?Q?myUSq3tqLmjXCkWuC3/gQemnL9hwWSqnwg09JEniaY/jlW9cLSS4PdAURNFX?=
 =?us-ascii?Q?V+4G/TUY6qGJRRoPL+YtcnHhtRCnNggm0n5kMron4ejg7Jr/uq21MqBafg2q?=
 =?us-ascii?Q?JJwkcqKd7IMV/ea37fACsvqERSqSTpX1BhFfPAZsh/h99NCJ/JO6+6zg8Tlc?=
 =?us-ascii?Q?h3RmiQi3St+H+GpAdbJEA02bTGUKR7wQtwm2jPC9JLiT7ZCvBgwKdH+LDEpZ?=
 =?us-ascii?Q?+ZqhIGTV4pAp9RhHgEoalF/GpBiwsQ2EgZvlFuBfq2dfjeFz6xO6S5aQHwFu?=
 =?us-ascii?Q?Q9Ou34KQOO1OEuUiCIgAdjyaNPhpGcqscevtw0b1KClY3hVVqf4Rdz4fHkms?=
 =?us-ascii?Q?fRRSZ5cTrg+vz9BpjrbcYdS/hI8mktkEKfaYOE7mR38r1jdiEPmuiO+ZiK7w?=
 =?us-ascii?Q?Bt3j6o2fv2VjSOC8OKZvrX68EDh1W1/nPQq5VLXE/Vc39LFpNks05kbrF8RN?=
 =?us-ascii?Q?lqc0xw1RlqnZ0pvnhzPzEFMMsbSn6OWftKfn2sIjw1+c9R+ur1l9fNeEpbVR?=
 =?us-ascii?Q?RqEu9StHTOtGVisy8GBsoSTfT5Qr8zjuHNgSdGFztXxNE56Gwp+nj+apn7yu?=
 =?us-ascii?Q?a94HBiBOSw7lgL6XhAbhHmp1KIRd7Fd+XeE0BolS0Hr/BRBOj1NX6s6ZuzeR?=
 =?us-ascii?Q?BSlRBz5pcVgAq5v5cY6q7gaw1GNIGcotIQ8V5AhXx8gsOwSS0JkFk9KWDR7k?=
 =?us-ascii?Q?UgeoxgnYvwvDuDOHAuPVC1RpeJUkiFbzkFA7ritjjEspLzdHs1DgDowrH1Lp?=
 =?us-ascii?Q?9WnoJFBSCuyIHHMmyyovuOnVLevXWBHfDBD1xNy4cyK4JSaVEZ9Tyr/3Jlgh?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P6rvqp6fl2hi+OZhzKmVEq7RQucmRArY0OlQBuqpow3p67PZwXifhYOfSOQPyaSrtnwnLQHaVCOaIroMbAvzjHchYOCRDtmySY7Rnk0sVIpJC+bbbrtgrin2LjvY3IR+Eb9M8+WjdvyZAbQsNvTqJ+5EFE+i8y0++ON+ac19tH9Tu8vgQB7VZU7ilnj8wzMv87jjYEmTtSZzjqa0gYHpqA5DpMsJsvacI/qSWrga6C3H0x1Wi4YRiKkl8DZxHel0crjm3TeWaJYn8ABd7HxRyqdrZOHcCA3q7S0+fK3Taw/QHxX4x2VkzEwsza4PpZCJWFxGP+LFs1nu6Yrt/PiSY2n13CUXRIJV7BBwdfVVDTnqaAXEVidMmQNbiil50pUuQ4GbS0TWZV/M4K9Aw3PXApbYyrQvL/yr9WtYl1XzSjy7ctdraCU3nzuB85gn6kiw+EKcmVh9ILI5xH6NzdFlFj8T/Gg1xC3sNww935QdYfKdq5YzNpoWh3FZorbv0T0cd/dcBe88wYwMEuBjy63f0pUtWdRjdqPz1feMapY/dBIK/D8LHNBMWcESsOjycHHkyzDiAtPm8Bklv4q+0wTYPoj+Lr9thWkwTQyzPFoqCZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62c9c94-29aa-4b8f-e8e7-08dd3026a706
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 20:54:32.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+Uc9XWch1CsZGtqYLqsrJn3KJ2jSiEV07iBt4WwLH1QIURXpibUWVTb+cw34hOuzfZwzgNLxE/AeJDICKr/nbz4iPZv+Ki0AW5MN198IPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080170
X-Proofpoint-ORIG-GUID: K2BtN7jOSWdvOFUrylhtv1sKsZvjlow8
X-Proofpoint-GUID: K2BtN7jOSWdvOFUrylhtv1sKsZvjlow8

On Thu, Jan 02, 2025 at 03:32:50PM -0800, Isaac J. Manjarres wrote:
> Android currently uses the ashmem driver [1] for creating shared memory
> regions between processes. Ashmem buffers can initially be mapped with
> PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
> ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
> permissions that the buffer can be mapped with.
>
> Processes can remove the ability to map ashmem buffers as executable to
> ensure that those buffers cannot be exploited to run unintended code.
>
> For instance, suppose process A allocates a memfd that is meant to be
> read and written by itself and another process, call it B.
>
> Process A shares the buffer with process B, but process B injects code
> into the buffer, and compromises process A, such that it makes A map
> the buffer with PROT_EXEC. This provides an opportunity for process A
> to run the code that process B injected into the buffer.
>
> If process A had the ability to seal the buffer against future
> executable mappings before sharing the buffer with process B, this
> attack would not be possible.
>
> Android is currently trying to replace ashmem with memfd. However, memfd
> does not have a provision to permanently remove the ability to map a
> buffer as executable, and leaves itself open to the type of attack
> described earlier. However, this should be something that can be
> achieved via a new file seal.
>
> There are known usecases (e.g. CursorWindow [2]) where a process
> maps a buffer with read/write permissions before restricting the buffer
> to being mapped as read-only for future mappings.
>
> The resulting VMA from the writable mapping has VM_MAYEXEC set, meaning
> that mprotect() can change the mapping to be executable. Therefore,
> implementing the seal similar to F_SEAL_WRITE would not be appropriate,
> since it would not work with the CursorWindow usecase. This is because
> the CursorWindow process restricts the mapping permissions to read-only
> after the writable mapping is created. So, adding a file seal for
> executable mappings that operates like F_SEAL_WRITE would fail.
>
> Therefore, add support for F_SEAL_FUTURE_EXEC, which is handled
> similarly to F_SEAL_FUTURE_WRITE. This ensures that CursorWindow can
> continue to create a writable mapping initially, and then restrict the
> permissions on the buffer to be mappable as read-only by using both
> F_SEAL_FUTURE_WRITE and F_SEAL_FUTURE_EXEC. After the seal is
> applied, any calls to mmap() with PROT_EXEC will fail.
>
> [1] https://cs.android.com/android/kernel/superproject/+/common-android-mainline:common/drivers/staging/android/ashmem.c
> [2] https://developer.android.com/reference/android/database/CursorWindow
>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  include/uapi/linux/fcntl.h |  1 +
>  mm/memfd.c                 | 39 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 6e6907e63bfc..ef066e524777 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -49,6 +49,7 @@
>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
>  #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
>  #define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */

Hmm ok I just noticed this... F_SEAL_EXEC is weird then.

It doesn't prevent execution in the same way F_SEAL_WRITE does, nor does it seem
to check or care about VM_MAYEXEC...

It just 'prevents chmod from modifying exec bits'.

I mean lord above haha.

And of course the code for it is in shmem_setattr()...

I have not enough faces to palm or palms to face.

So yes I suppose for any sane exec semantics you'll need something new...

> +#define F_SEAL_FUTURE_EXEC	0x0040 /* prevent future executable mappings */
>  /* (1U << 31) is reserved for signed error codes */
>
>  /*
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 5f5a23c9051d..cfd62454df5e 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -184,6 +184,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
>  }
>
>  #define F_ALL_SEALS (F_SEAL_SEAL | \
> +		     F_SEAL_FUTURE_EXEC |\
>  		     F_SEAL_EXEC | \
>  		     F_SEAL_SHRINK | \
>  		     F_SEAL_GROW | \
> @@ -357,14 +358,50 @@ static int check_write_seal(unsigned long *vm_flags_ptr)
>  	return 0;
>  }
>
> +static inline bool is_exec_sealed(unsigned int seals)

This should say 'future', otherwise this is very confusing vs. F_SEAL_EXEC.

Also no need for inline outside of a header.

> +{
> +	return seals & F_SEAL_FUTURE_EXEC;
> +}
> +
> +static int check_exec_seal(unsigned long *vm_flags_ptr)
> +{
> +	unsigned long vm_flags = *vm_flags_ptr;
> +	unsigned long mask = vm_flags & (VM_SHARED | VM_EXEC);
> +
> +	/* Executability is not a concern for private mappings. */
> +	if (!(mask & VM_SHARED))
> +		return 0;
> +
> +	/*
> +	 * New PROT_EXEC and MAP_SHARED mmaps are not allowed when exec seal
> +	 * is active.
> +	 */
> +	if (mask & VM_EXEC)
> +		return -EPERM;
> +
> +	/*
> +	 * Prevent mprotect() from making an exec-sealed mapping executable in
> +	 * the future.
> +	 */
> +	*vm_flags_ptr &= ~VM_MAYEXEC;
> +
> +	return 0;
> +}
> +
>  int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr)
>  {
>  	int err = 0;
>  	unsigned int *seals_ptr = memfd_file_seals_ptr(file);
>  	unsigned int seals = seals_ptr ? *seals_ptr : 0;
>
> -	if (is_write_sealed(seals))
> +	if (is_write_sealed(seals)) {
>  		err = check_write_seal(vm_flags_ptr);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (is_exec_sealed(seals))
> +		err = check_exec_seal(vm_flags_ptr);
>
>  	return err;
>  }

OK this is actually quite neat now we have everything set up in do_mmap().

I think we probably want some comments to very clearly point out that
F_SEAL_EXEC is a bit crazy and weird and meaningless and this is actually
vaguely sane...

> --
> 2.47.1.613.gc27f4b7a9f-goog
>

