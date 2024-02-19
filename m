Return-Path: <linux-fsdevel+bounces-12021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0CC85A526
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 14:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3208D283968
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521436B1D;
	Mon, 19 Feb 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="deBX1Ggf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="myiUNUOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C99364C4;
	Mon, 19 Feb 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350772; cv=fail; b=sIcDGdtd+/iM8oAlyu4aLHE5eI3MOaXAJZgaWQD3QsroVUFRD8gAOI+wqkjMDwupyO5qTFYpk7qj9dmAbtGe2S//SmpO+JKdnPrRCdzqjbba/u3qWL9WYRkdfsOflaudt4BYs0WyPnSCrGkcyWYS4sh/ZRVoPgz8LNBri5HPb0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350772; c=relaxed/simple;
	bh=25AJhc2e8oMEN+cQ2Pxr2d91ldfBjsd01t1jd+gV1mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mp3vdQVg1Fst2vWnWvM/lAUibSgLXXXbNl/o8pOxm2L3IZOxPYt9sGRVs7TsNXbEZRzbo3ZCAtUKo7rBo1/Qvx43eZe8DJ6RwVoALuI6xX/sUliwbCUc55AGKeCYp7PH8K9jjStXudNogvu7+MoDN6uaNxQHqh1XE1ujyZGa/dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=deBX1Ggf; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=myiUNUOk reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8OBcK022538;
	Mon, 19 Feb 2024 13:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=Tud/Khmz5dm/5CEIpZ0iWbq7SjYui6qV66AyvxM2buo=;
 b=deBX1Ggf6DBKD731djoScOM0CkB9kSVrfsShmY2i2zRwiPs8OOmCXRbZzbXqqkVbAMkX
 tWhPFvsIdGxZdRwHM+bkK8SSZOVpieWQcaLDYnMoQUS76y6mq042uFy28w1Ix7zIMxY7
 AEAWDTXjAcoupeMK9FP0vPSQPVZw2DfQm5SNrljCflN2EYkDVBnE2YIwwE6a8kmxA2ou
 oA4WENNuaswU+qW+/6pp5F+E6/6whFpgKNkNOHPI36nshigIEdejfuAmA7Q9ETNntx9M
 kA/sH2qPv+0qL6hTqpgXdK+cuhP4WkvV5Y5IQPgv/sqK2iZzR3VBrI4N84m5id43MEbf mA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdtv6t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:52:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JCPETc006622;
	Mon, 19 Feb 2024 13:52:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak866d7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhXuLj59HYHWlDuf1tcQlhYu9YbA1avvFdZ/P0uZPQ41NRiI909V5US/H7oTmAJRsnbfZQcJtc8HypiS0CCclxhBN8QsgFjm2esvmG22ObdWLVzyNVOh/mDGKAbFbHCvIjtp7560ihhHuWQkY22ecGZ3HNu5drIgwd6eigUVOIAJvOq6EoJLbXQ4PEkC1wtwQ/A2sFbU+PqExLI8iEYVC3akBSzk+9QMBYh25JDlWJHEQ09dLOXsME941G+WrOHAKG/T1wKa9LLMzt+DuvuCX5AS6lp0uXBpRMmeSnATezmZR9FQOXdLogY3QeUFAgLst3kfiPCz1kJeMQp38IsOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucsSXAAyVKXwcP4BzAsTGks/vE1G+qi9kvGDXiZC1Go=;
 b=UEw8imuMGyhYHnVkFvesRcOcGJ5GiEFH0k6gsexQpd564uwSY00or0/xCbmi1AJJzrYZ7LrZhbnz5XEr2Ry61LcpayFQkMo3KqytX7ff4LjGMn53HwVipH7otQAo7hnvFoM+rkjGIqyybs/QfQUI1kRzbGHowELiyh4c8g8CQUgurlfNyT8cDwDeTY4ABMUtO3r42z2Mky3OnMbfmWUuVbbjrIkx2aSlmujMAwwtj9YNIxY617oeTITN8NHrUFPqfPtCJLtUssxVxCw9NanJs/gvNMSGopbVcBZF8ALufq6y3aIXgLvFsl6XymKoEkkDrMzluHPakzgeThXWlgvcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucsSXAAyVKXwcP4BzAsTGks/vE1G+qi9kvGDXiZC1Go=;
 b=myiUNUOkPENTb/cl/1OeUXPZaCwuduH1fw0buSpiaAvXd1LuUJ5VgEVsUZ2ZmAx19Uj3g6VUVRjOkcJrjja3GirDrpfBcwrZ58Lo6qL4rOB2CwAf2TguPiCuntKzO+m8c04IAPBuDm9ZPDwKSaqILgGn0DqVD/o3CvBzLGxoZL4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7238.namprd10.prod.outlook.com (2603:10b6:208:3f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 13:52:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 13:52:37 +0000
Date: Mon, 19 Feb 2024 08:52:33 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
        Liam.Howlett@oracle.com
Subject: Re: [cel:simple-offset-maple] [libfs]  a616bc6667:
 aim9.disk_src.ops_per_sec 11.8% improvement
Message-ID: <ZdNdIUX6n7s1EAyT@manet.1015granger.net>
References: <202402191308.8e7ee8c7-oliver.sang@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402191308.8e7ee8c7-oliver.sang@intel.com>
X-ClientProxiedBy: CH2PR05CA0030.namprd05.prod.outlook.com (2603:10b6:610::43)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da84ccd-b114-43e9-5e48-08dc315207ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	etugC8nSWhT2mFdAGMWj+o52s6qGqdiVR4rNFAuAyuEUDL1mEYdb6ZJjNCd9g0WXBZNavZioinnTId4zitKykMy6NObP8hW98mNjqDbbOV6i9cw08NyAEK+sXmxEB19U5aw7It67KpFBTAwR2u9deMFIEcN2CjVK5WTosyP5PTliK82LxpMX375Vu5a6BFq3Jdi0huHZvzSQYTEMJwji9OZw2VxHSuqtslCweAezdZ4fd1UTFu61fE8XZRs8AU3ZXVoZt173/WYMekyaRfbDkotBkw0IR0YpExqoVyAU+MiaHd53H92+y0i0hcN1usg53BS7Ve+qKytFS/11h5nhNRF0B45z7vtW55xYAStQbSqV7I7zlEf7aNzvrM/o5eSrv87wAW1PqDRcOWhP0jkKEF6OyPaUZPGLyPLv6GewxwqtPAI8bXPUg/v9gRSatu7VWQwM4uUglIpK9TGiIFekzZU1uZbivg5eAE7FD1V6ILb+eBmExPHKGd+NrpBkvuCJHSON3mhUwESSzMU6RXGGVPXgrjCrvDCmR+x3GVDWbf1p3MyiDYU6FpdRr2M3cmDH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230473577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?yKvszSxacmP3zdvfI1bP08c4HhjHiT1jDS5yxAVjGOuWQbcbkNeBeDLNE2?=
 =?iso-8859-1?Q?Q1BsBc2/RLTXirFWlTtAPuUu8heTgULcr2e0YirIOjl+MYRot1/3b9mqtQ?=
 =?iso-8859-1?Q?iZQ+Sb2PA70wqgYEY8TqFOaaYwqHBUJycqsPS4mb3dL/Ejw5FeioCLjiS8?=
 =?iso-8859-1?Q?jKJ4z1nrSB496ZyoyBZiXiZJE3fIITImYZHD2k5lGuMDEfYIhQjUvHMKe+?=
 =?iso-8859-1?Q?scPg/k9nt1H5AEf83RdvAo6e7n8MjCtM+cCBu2EiAp6YzVesjXvYT1w+mk?=
 =?iso-8859-1?Q?57yixKIkTto5rbafPvYX3BaGPsB84YRQfEXmJwCQUo3BSZCILTzv8C3abb?=
 =?iso-8859-1?Q?V7q0+1C1qhLTEBSOaMhIEDEWE1Z+fjB0PpxbVlHrVh2wqeoqhHhOATbs7y?=
 =?iso-8859-1?Q?ZCl0IA2sB1FDONq8ikW4OoroBnOlTY1KL6vs8Li3l528JQXRtyNJ3f6MIb?=
 =?iso-8859-1?Q?PBLC9vd0z91WtXk3M9z6Y3zwEWGQrnBGYWgiwz/OFq5uplXeWUxRfeEF+i?=
 =?iso-8859-1?Q?zAWiuS0xuBx1NMKDnZKYCCXR/zc0hNf/aFmWaQQE8+iI3uBpd/m/q0GlKw?=
 =?iso-8859-1?Q?B1yBABBo3Nx7iS/fI6wySAvYlrGfDwt/QVHLfDYfhbFBKyKBSKP9AZQq9q?=
 =?iso-8859-1?Q?bf78xVc83NfZZMvVOApel7tIVwo6vT+CNZZu8aChUJEGf3WzvTO0EfUMNJ?=
 =?iso-8859-1?Q?yPfnPaQt5ss7eiKQQ9iJrkWCzawdjx7SG4SVn96XifwF5W2XexMfpXobCg?=
 =?iso-8859-1?Q?rCzRb8ZY5SpQ4FV8zZ5oth2wXEj772AND4rU7132ogmFbxwSOMcjoCuhOs?=
 =?iso-8859-1?Q?U5ayl3AkHvaV8LcLo5kyUngwfdtJ10wO+wSeQT89RsJeMg3dxuJmnQohR9?=
 =?iso-8859-1?Q?RlKr2apGhb2owlGM+0dhXmcb7WazZUPBvxP+iHVWWIPDSxRVAWgPXQ/ynh?=
 =?iso-8859-1?Q?VRul/69XNycrVU28uUBKEahHNiye/jFNC4ObS7kaPRGD7FbWtjjPUStiW9?=
 =?iso-8859-1?Q?ebMiq+gKqlKGNS7lold9UoCjtWwh3Vc76JvI/iJifOVE3McFEj0Gdmwmut?=
 =?iso-8859-1?Q?eGv+dJ8F0p0FrA3S9OFeNBdk1UqPk0f7ZmqYwpARpwUuCtZCOuUJAiR54h?=
 =?iso-8859-1?Q?h3ts2AHluGo8n9BHiKtgejvoIV1QUc3YQzpHHF1FWzvrG3njBIrbdofSGM?=
 =?iso-8859-1?Q?4elgDa1fxw2zEZmKbRAuapUI9geJpPR9Vf6803HwuJuwU/UHtAEzcHMOGo?=
 =?iso-8859-1?Q?XI08CQctWpOt3esFVB5ASDuZOrpIcFdzxeluVgRiDYGBRKxHA+8URm5dbj?=
 =?iso-8859-1?Q?TnRITg3du3EjjBRMO/5KkijVPLxUVrXhyfSLVA9bWxhkpkTwXCxqoNSn16?=
 =?iso-8859-1?Q?pwuMJ4oV+I5ZnvCd5agrWhlCOM//1TRhQSQ1T77uUqHTZl97WpwCRmBYdS?=
 =?iso-8859-1?Q?t7gNv7QAXVsroYUGNcAaVohoH0MM/xkQjsruArVZGP49BjW0PE00KLb/7Z?=
 =?iso-8859-1?Q?MyQ/mmkLnKWzbwRra8KFfS8rUB0TQideILetuY9DxDxPN4tnCK3TiD4iti?=
 =?iso-8859-1?Q?Z11kvheNaszdZhsaGMQJ/pE0FyXi8pWSnlsuDi+8ziZXApY0eQ0Ug8lgHp?=
 =?iso-8859-1?Q?9T1HS5CVet+nwd4EMYL75UOeTJ7f7dlpM6VbCTeX+g8+5FDL4gu9e1NQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SXefZUZ43W+Z7EgROBqC3a6qH7NBpHLMp0Gu1O/272yN89Fj7HxLAValSh3xpt8JrRhYeQRXfJRCNsvZFvNpLMwJTg6C6s+rdisb1H/9bBrE6GhxFxtI2ZLIR7CmYNGZAC+Q0RHxtPdj9tTDpplt+Z8OCP2yCORGY3yoz6ygBVwXD/z29yyhCz9nPGlzlOlt9sO9aGf5coRLMXJaT3OfUSG9y20/r33tKfCFn+bRri1huT9eX5u7FZeGg1QP1kSnLb1GPeo5UYyJazH5jFyeCE7/9E8HUtyfmfII/cr5FJOe9Y5Gf4VPHNVYMaTP/JDU/B2FKc82hES/4/aTxZFv+MTmyBnlFdAdb48hyqOC5qyQIYbFYUUNi7L069c3h8i/+4Rse9h7RMK8zfZ4ACysiXE6f11SdyO3skJ2TS5L+xEsdOlCOfiPN1kNyE7MfN9m61cTvuwPYj/08YDU/dygKdBuB31G5RaLVoJhf98EP19kygZzz+8xPfpPRE9/kZwNyAwTXA3h3u80Liz7Nd93M6n9+ad3xOw1pOXFev19s2SNgaXgmK2LUOKqQ/+ISA8SQ2MpemubpI6HzYtycA1/0KP30346Z2B8fO+3qzxahEo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da84ccd-b114-43e9-5e48-08dc315207ef
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:52:37.1256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXXdUR5UJFKD/NYZTVj4BMBYKaSlBrZEgxzOhYVPqJtCrypMnpUNPW6ifjj7hcSTkjycGykycfD4I0FvEOYOIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190103
X-Proofpoint-GUID: u2gZb19OCZl23URGWD0OoPRZMffgm7R9
X-Proofpoint-ORIG-GUID: u2gZb19OCZl23URGWD0OoPRZMffgm7R9

Including Liam ...

On Mon, Feb 19, 2024 at 01:44:05PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 11.8% improvement of aim9.disk_src.ops_per_sec on:
> 
> 
> commit: a616bc666748063733c62e15ea417a90772a40e0 ("libfs: Convert simple directory offsets to use a Maple Tree")
> git://git.kernel.org/cgit/linux/kernel/git/cel/linux simple-offset-maple
> 
> testcase: aim9
> test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
> parameters:
> 
> 	testtime: 300s
> 	test: disk_src
> 	cpufreq_governor: performance
> 
> 
> 
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240219/202402191308.8e7ee8c7-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/disk_src/aim9/300s
> 
> commit: 
>   f3f24869a1 ("test_maple_tree: testing the cyclic allocation")
>   a616bc6667 ("libfs: Convert simple directory offsets to use a Maple Tree")
> 
> f3f24869a1d7cde1 a616bc666748063733c62e15ea4 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>       0.34 ±  4%      -0.1        0.20 ±  4%  mpstat.cpu.all.soft%
>       0.00 ± 28%     +58.3%       0.00 ± 17%  perf-sched.sch_delay.max.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
>       1464 ±  2%     +14.0%       1668 ±  4%  vmstat.system.cs
>     164231           +11.8%     183678        aim9.disk_src.ops_per_sec
>       1309 ± 15%   +2643.5%      35915 ± 23%  aim9.time.involuntary_context_switches
>      91.00            +5.5%      96.00        aim9.time.percent_of_cpu_this_job_got
>     212.54            +3.5%     220.06        aim9.time.system_time
>      62.58           +10.2%      68.94        aim9.time.user_time
>      21685            -7.1%      20144        proc-vmstat.nr_slab_reclaimable
>    6611541           -88.6%     750673 ±  7%  proc-vmstat.numa_hit
>    6561447           -89.3%     700947 ±  7%  proc-vmstat.numa_local
>       5747            +3.7%       5960        proc-vmstat.pgactivate
>   26113963           -93.7%    1648373 ± 17%  proc-vmstat.pgalloc_normal
>   26042963           -93.7%    1628178 ± 18%  proc-vmstat.pgfree
>       2.07            -1.2%       2.04        perf-stat.i.MPKI
>  6.738e+08            +3.0%   6.94e+08        perf-stat.i.branch-instructions
>       2.94            -0.2        2.70        perf-stat.i.branch-miss-rate%
>   20408670            -5.1%   19363031        perf-stat.i.branch-misses
>      15.11            +2.7       17.77        perf-stat.i.cache-miss-rate%
>   46824224           -14.7%   39962840        perf-stat.i.cache-references
>       1419 ±  2%     +14.4%       1623 ±  5%  perf-stat.i.context-switches
>       1.88            -1.3%       1.85        perf-stat.i.cpi
>  9.453e+08            +2.2%  9.659e+08        perf-stat.i.dTLB-loads
>       0.22 ±  5%      +0.0        0.25 ±  3%  perf-stat.i.dTLB-store-miss-rate%
>    8.8e+08            -6.8%  8.205e+08        perf-stat.i.dTLB-stores
>    1536484            +7.9%    1657233        perf-stat.i.iTLB-load-misses
>       2279            -6.0%       2142        perf-stat.i.instructions-per-iTLB-miss
>       0.54            +1.3%       0.54        perf-stat.i.ipc
>     786.95            +7.1%     843.12        perf-stat.i.metric.K/sec
>      47.07            +1.1       48.17        perf-stat.i.node-load-miss-rate%
>      87561 ±  4%     +17.2%     102647 ±  6%  perf-stat.i.node-load-misses
>       2.01            -1.2%       1.99        perf-stat.overall.MPKI
>       3.03            -0.2        2.79        perf-stat.overall.branch-miss-rate%
>      15.07            +2.6       17.67        perf-stat.overall.cache-miss-rate%
>       1.84            -1.2%       1.82        perf-stat.overall.cpi
>       0.22 ±  5%      +0.0        0.24 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
>       2283            -6.1%       2144        perf-stat.overall.instructions-per-iTLB-miss
>       0.54            +1.2%       0.55        perf-stat.overall.ipc
>      44.15            +1.8       45.93        perf-stat.overall.node-load-miss-rate%
>  6.715e+08            +3.0%  6.917e+08        perf-stat.ps.branch-instructions
>   20340341            -5.1%   19299968        perf-stat.ps.branch-misses
>   46667379           -14.7%   39829580        perf-stat.ps.cache-references
>       1414 ±  2%     +14.4%       1618 ±  5%  perf-stat.ps.context-switches
>  9.421e+08            +2.2%  9.627e+08        perf-stat.ps.dTLB-loads
>  8.771e+08            -6.8%  8.178e+08        perf-stat.ps.dTLB-stores
>    1531338            +7.9%    1651678        perf-stat.ps.iTLB-load-misses
>      87275 ±  4%     +17.3%     102341 ±  6%  perf-stat.ps.node-load-misses
>       5.62 ± 13%      -1.9        3.69 ± 12%  perf-profile.calltrace.cycles-pp.shmem_mknod.lookup_open.open_last_lookups.path_openat.do_filp_open
>       7.87 ± 13%      -1.9        5.95 ± 11%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
>       8.47 ± 13%      -1.9        6.59 ± 10%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
>       2.97 ± 12%      -1.8        1.16 ± 13%  perf-profile.calltrace.cycles-pp.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups.path_openat
>       0.00            +1.0        0.98 ± 13%  perf-profile.calltrace.cycles-pp.mas_alloc_cyclic.mtree_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open
>       0.00            +1.0        1.00 ± 40%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
>       0.00            +1.0        1.03 ± 40%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
>       0.00            +1.1        1.06 ± 40%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
>       0.00            +1.1        1.06 ± 40%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.00            +1.1        1.10 ± 39%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.00            +1.1        1.10 ± 14%  perf-profile.calltrace.cycles-pp.mtree_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups
>       0.00            +1.2        1.20 ± 13%  perf-profile.calltrace.cycles-pp.mas_erase.mtree_erase.simple_offset_remove.shmem_unlink.vfs_unlink
>       0.00            +1.3        1.27 ± 38%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
>       0.00            +1.3        1.27 ± 38%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
>       0.00            +1.3        1.27 ± 38%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
>       0.00            +1.4        1.35 ± 12%  perf-profile.calltrace.cycles-pp.mtree_erase.simple_offset_remove.shmem_unlink.vfs_unlink.do_unlinkat
>      15.22 ±  8%      -2.8       12.40 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>      14.50 ±  8%      -2.8       11.72 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       4.73 ± 13%      -2.8        1.97 ± 15%  perf-profile.children.cycles-pp.irq_exit_rcu
>       3.50 ± 12%      -2.1        1.41 ± 12%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
>       5.63 ± 13%      -1.9        3.70 ± 12%  perf-profile.children.cycles-pp.shmem_mknod
>       7.88 ± 13%      -1.9        5.97 ± 11%  perf-profile.children.cycles-pp.lookup_open
>       8.49 ± 13%      -1.9        6.62 ± 10%  perf-profile.children.cycles-pp.open_last_lookups
>       2.97 ± 12%      -1.8        1.16 ± 13%  perf-profile.children.cycles-pp.simple_offset_add
>       2.90 ± 22%      -1.8        1.15 ± 41%  perf-profile.children.cycles-pp.rcu_do_batch
>       4.47 ± 14%      -1.7        2.76 ± 24%  perf-profile.children.cycles-pp.__do_softirq
>       1.85 ± 15%      -1.7        0.14 ± 28%  perf-profile.children.cycles-pp.___slab_alloc
>       3.00 ± 22%      -1.7        1.34 ± 38%  perf-profile.children.cycles-pp.rcu_core
>       1.66 ± 15%      -1.6        0.05 ± 68%  perf-profile.children.cycles-pp.allocate_slab
>       0.92 ± 18%      -0.6        0.31 ± 19%  perf-profile.children.cycles-pp.__call_rcu_common
>       0.88 ± 27%      -0.6        0.31 ± 43%  perf-profile.children.cycles-pp.__slab_free
>       0.28 ± 15%      -0.2        0.12 ± 25%  perf-profile.children.cycles-pp.xas_load
>       0.20 ± 18%      -0.1        0.08 ± 30%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
>       0.12 ± 30%      -0.1        0.05 ± 65%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
>       0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.mas_wr_end_piv
>       0.00            +0.2        0.17 ± 22%  perf-profile.children.cycles-pp.mas_leaf_max_gap
>       0.00            +0.2        0.18 ± 24%  perf-profile.children.cycles-pp.mtree_range_walk
>       0.00            +0.2        0.24 ± 22%  perf-profile.children.cycles-pp.mas_anode_descend
>       0.00            +0.3        0.29 ± 16%  perf-profile.children.cycles-pp.mas_wr_walk
>       0.00            +0.3        0.31 ± 23%  perf-profile.children.cycles-pp.mas_update_gap
>       0.00            +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.mas_wr_append
>       0.00            +0.4        0.37 ± 15%  perf-profile.children.cycles-pp.mas_empty_area
>       0.00            +0.5        0.47 ± 18%  perf-profile.children.cycles-pp.mas_wr_node_store
>       0.00            +1.0        0.99 ± 13%  perf-profile.children.cycles-pp.mas_alloc_cyclic
>       0.05 ± 82%      +1.0        1.10 ± 39%  perf-profile.children.cycles-pp.smpboot_thread_fn
>       0.01 ±264%      +1.0        1.06 ± 40%  perf-profile.children.cycles-pp.run_ksoftirqd
>       0.22 ± 36%      +1.1        1.28 ± 38%  perf-profile.children.cycles-pp.ret_from_fork
>       0.22 ± 36%      +1.1        1.28 ± 38%  perf-profile.children.cycles-pp.ret_from_fork_asm
>       0.21 ± 38%      +1.1        1.27 ± 38%  perf-profile.children.cycles-pp.kthread
>       0.00            +1.1        1.11 ± 14%  perf-profile.children.cycles-pp.mtree_alloc_cyclic
>       0.00            +1.2        1.21 ± 14%  perf-profile.children.cycles-pp.mas_erase
>       0.00            +1.4        1.35 ± 12%  perf-profile.children.cycles-pp.mtree_erase
>       0.87 ± 27%      -0.6        0.31 ± 42%  perf-profile.self.cycles-pp.__slab_free
>       0.53 ± 19%      -0.4        0.18 ± 23%  perf-profile.self.cycles-pp.__call_rcu_common
>       0.57 ± 10%      -0.3        0.26 ± 21%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru
>       0.89 ± 14%      -0.3        0.59 ± 15%  perf-profile.self.cycles-pp.kmem_cache_free
>       0.19 ± 21%      -0.1        0.06 ± 65%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
>       0.10 ± 20%      -0.1        0.04 ± 81%  perf-profile.self.cycles-pp.xas_load
>       0.08 ± 19%      -0.0        0.04 ± 61%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.00            +0.1        0.09 ± 30%  perf-profile.self.cycles-pp.mtree_erase
>       0.00            +0.1        0.10 ± 26%  perf-profile.self.cycles-pp.mtree_alloc_cyclic
>       0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.mas_wr_end_piv
>       0.00            +0.1        0.12 ± 38%  perf-profile.self.cycles-pp.mas_empty_area
>       0.00            +0.1        0.14 ± 38%  perf-profile.self.cycles-pp.mas_update_gap
>       0.00            +0.1        0.14 ± 20%  perf-profile.self.cycles-pp.mas_wr_append
>       0.00            +0.2        0.16 ± 23%  perf-profile.self.cycles-pp.mas_leaf_max_gap
>       0.00            +0.2        0.18 ± 24%  perf-profile.self.cycles-pp.mtree_range_walk
>       0.00            +0.2        0.18 ± 29%  perf-profile.self.cycles-pp.mas_alloc_cyclic
>       0.00            +0.2        0.22 ± 32%  perf-profile.self.cycles-pp.mas_erase
>       0.00            +0.2        0.24 ± 22%  perf-profile.self.cycles-pp.mas_anode_descend
>       0.00            +0.3        0.27 ± 16%  perf-profile.self.cycles-pp.mas_wr_walk
>       0.00            +0.3        0.34 ± 20%  perf-profile.self.cycles-pp.mas_wr_node_store
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

-- 
Chuck Lever

