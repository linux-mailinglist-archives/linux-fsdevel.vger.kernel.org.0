Return-Path: <linux-fsdevel+bounces-11739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5063C856B52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7517C1C23B23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF41369A8;
	Thu, 15 Feb 2024 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k/me+Qkz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QSzvMtUR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFD71353FA;
	Thu, 15 Feb 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018872; cv=fail; b=XkwmuRiR5mL8SSXitiJNsLL7ByN4U5IrZVPoWT8Wm73lY1+xGKK63gzCr710CPTtYDaWIMu15jo9vfM5L6o9U8F0aN1Xru/dySwIQoBKLPsUR6hbkGA+zCdG3xgZI7mcF0B6wuX7VBbEhRrpN2z6bEqiVGbhS+h0m/XrH84mfvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018872; c=relaxed/simple;
	bh=wIIUe2KrDfd8ND2KQFXDkvsyavcDU32ja/vZc2Cxg/E=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PCXAiZeyalJyYMhLt6TEkX/gLpuD9JszE1rttZATnbFxe5txp3ktXvcHrH0BfxEDD3A7tKm8oFhFg2+x5W8JhnGX3IDTIP1VS694lMdfrDb6VbHa4OD0GgZWZbRsjDBE6XyA82QT2D8zotqphVsAOwaG1NdxINqXH7shNFY0ZJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k/me+Qkz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QSzvMtUR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFSsKV030976;
	Thu, 15 Feb 2024 17:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=h3kRXbbfShnPo5eHRC6SrH7leCR0t7kDuKP8L6FJBsQ=;
 b=k/me+QkzO1kRgxPUbK5u6USe6NLRrpjoZJgcEXMlfF2eIt+WmiHMSFIdURQ1dAbR+WXg
 OSlaa8IViCDZ5gu6cQy/keaNwx2ADJ84Iw+/SA/par+Z2NwH39K1219vCwqwl8yLQ9ap
 pHj9d653J2MpmkZIY0uqAnFFGZGcA+Q3VE0y7rb+l43YseyuXiBXsDMFlKwkV7Th1MXZ
 P7zzLr7jgo2jpLfTZLjYky+jp7MqfKED4+XAX7MlP4ZUkTwNFuGN0CDx6V5zpijY7e5O
 sd2kyQUuwSc+0zMx7ZuYEjNukYSpXgROI+PFX0UoL/+L9BXe3wNqgfq2+78+CEjdN7NE nA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301jt84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 17:40:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FHUab6031570;
	Thu, 15 Feb 2024 17:40:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykauw4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 17:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNhXyecaAowy2AhznonmjWNlOBtbQYbF2uizeTQXvvojNzgXZaenD592NwhVibOKs+huvWKvXdi+9qPeEaydmoFrQC/75TAl4xHh6E51efAXC0qj+sZMzjCFVhtqErUuqMmIBqkMFoV4TQEH3XMf1rei4RSoazVQvDermwVE2mup7AlhjTzJUu/VfnVq9ZY9l4tyRTjs952t/7Q4Zgb22FBngecZvvwZ6bPjS7WyxoSzjNbyyE5cYAC8LgnlznGVuQmqLrGVpqHcOhGNm6tAAL/zKPgKX/mJz69A8PSjJg7cvmz16hcQbV9Cg8gcXgV6cNYUXQ04RvJmn2bUYS6YSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3kRXbbfShnPo5eHRC6SrH7leCR0t7kDuKP8L6FJBsQ=;
 b=BTNbS7PNB7dyBAfYdllIQ2T59TExk8q37rzRMwGEwZQdvwYF9HsGkKtcWQy777Gbe6qh0ZFbvT1D0Nx+v+xauqIJXNBLKkbxvXUFzlESby/sW7FlpXuyw2UGOyHxSF92g8RKF293fc8jlpHUlFAuVhg11CqOUA+ov/hlLAFj3tfN1YEAHFt1oiwys9o0oReeLKSNClcf46CEbByJ0OFXPPQtwyMOCa8asVLXQ/8HKbz0IXuSk+PnGyRTnxgqlFWq8rlPZFhqVhv2T+R/FyOh/M6QN0idBP+SJXCnwSGWfa8gzSM9pdblMP3vsyf0wqQhLfkEs6ZHW1pOipnFJVadCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3kRXbbfShnPo5eHRC6SrH7leCR0t7kDuKP8L6FJBsQ=;
 b=QSzvMtURv+M3Cw65LdV+8IczIhrFnLY08qQry10lISORISjBRScEvrC2WLhD47tFUPJlF2sPxelePKLPswKMnMV8ny4fIVm0ncGD3uCq9rbBK3GX2Dkujkzo7vcKyeYNjVbX5+BI2sbXS6rRjaPKG23eJAqlVYDWfdL9Uiz/MRQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5347.namprd10.prod.outlook.com (2603:10b6:208:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.30; Thu, 15 Feb
 2024 17:40:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 17:40:48 +0000
Date: Thu, 15 Feb 2024 12:40:45 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jan Kara <jack@suse.cz>,
        Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
        oliver.sang@intel.com, feng.tang@intel.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <Zc5MnXdxASGiE3lK@tissot.1015granger.net>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
 <20240215131638.cxipaxanhidb3pev@quack3>
 <20240215170008.22eisfyzumn5pw3f@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215170008.22eisfyzumn5pw3f@revolver>
X-ClientProxiedBy: CH0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:610:e7::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: f10bf4d2-f73a-41d9-d133-08dc2e4d3f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e2eNkvz0qyT97lhUwGE/NWbGspwQ8E/nsM0R0Wpu4pXglM1xASQ7KqltIIlTWCjnrTRO01pRIW8C4Xdkju3Gxz1IBgr1yCrvkmVa3X1o2/v9AfTsrD72Gs7JBGJgm0f3wOlXw9pG0gThhuYojxrkMEOTdmOJxNuCfWAsZZHlo5kKOZ+DLIpXZgsfrlpuWE9Q9HsY6u7IQSoqD7LBms5jK/JeUqfI58O285oa0DjHSagVZdD611Uuqh/zwaSZWWObWH0QqZVej9M/JeKtT0IkJU9x9zJ8XESPYShX/FNCaKXQlkkRtS5FEEVHGuXNLOvPyVOy8yjwG4G8sgIs7ouLwlD2ylk3pfz0y8vOBzk4D8rsSCyQLtJLwdWWcLByqaUCI7amBp1+keXG9zZxQ0uILVtcg6iKI1Wu+dbb9TLC2ptSkqDllUiLCMcLPzJgyy8ln9XBC04x3qVLKSqV2foWwWnxsYW2Bv1dmTvJJ8BPoRt914Tk50AX6SAKgsWr31/blDgm2WD4aPz1LZwe5seO/b8/LOK2znosB98UV/72hCFnPbU3MIc+MRtPUSgCXoZy1ozwfyBHzWH5ECXB2GvGG27Bi7jY7F/FDCABmJI3iKg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(478600001)(41300700001)(44832011)(2906002)(7416002)(66476007)(5660300002)(66946007)(8936002)(8676002)(66556008)(6486002)(6506007)(6512007)(9686003)(6666004)(316002)(110136005)(26005)(83380400001)(38100700002)(86362001)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?odjVjMzcMmZ5hcngCRqVfTPbB2Bi8CWIdJfIjXjv6ibG47AKk2ho8GwmnYZ4?=
 =?us-ascii?Q?f3fKDes+miJEBVLcUrb0fqU1/hN8MVi3MJXBluEwQYBFDM2AYh/lbyclE5+R?=
 =?us-ascii?Q?oQ/oqyFHo30pCfjKFym6wix3kMgsF6c3aKISyULSkHTSBa3J/35fN769XO1S?=
 =?us-ascii?Q?5NQ5IKL69c1BuminDtSks6l5ffEaWU/Ccqr9Ay0fi1l/K1GUqvS4ZoAI7MRq?=
 =?us-ascii?Q?bSHrvz9WUqvIfuM68eakuut8uFlNxKobNUPcxhS7oVmsEZAHR4o8Kr14So22?=
 =?us-ascii?Q?0/hOev3OL9J4mJ4DjfzZH5L0E4x2y9zi3oAHZAo1cVkI9dfz+tmdERTCEiNy?=
 =?us-ascii?Q?6oGyH90HIrXhO1d96ttNNyvmUS9lj1QkPVx5p37dSQ6fn1cln9km00wmm7U6?=
 =?us-ascii?Q?7EZCzyNJKUdUCbRxXi9j/tLS3BkNW/RfZ9OLn6Qr+utXBiSIZ5IniTojxLSb?=
 =?us-ascii?Q?45DB9oUEIWdOnjmeYN6gdcHMT4XXZboy7CeKuhNLV/YExJhal1Pic92Iv9vg?=
 =?us-ascii?Q?qzXWnUG5hBhpZmakNZ7zBFFPLx7VGwNV3vUQGHqyvy9eNqYBgxFQmyk35KEF?=
 =?us-ascii?Q?lijkmMlPPguPD9fqx6QOe6e0+eVUGQOttJJvjjM4kKIx32JOG3dtV0YlVbWQ?=
 =?us-ascii?Q?k3OPVroVElxEzruIpxpsT0eQTHA2n4bI1jUsud9RQDwi+sKGsWGKY434Mf8i?=
 =?us-ascii?Q?pOVPDW6wd9kgXsjKdNLoPZ/JKTk870ftpqrXkKtpZCpp9BAxCIDpqS5VO78Y?=
 =?us-ascii?Q?4nJ9gYMRD/mF9kNqH1yn0QYiSrNqVoMELxaXbqof2qFopptlxNHAHR4f+2b4?=
 =?us-ascii?Q?Jh8ZXSvaPBzHCCMWNn6OaBGR3+8v9VZl/gTUdXQHa5a35aGJhyTohNVQPf2c?=
 =?us-ascii?Q?aLR4iQ1xJQ9CCca64yzZC3ygEedqPnwEQKVhQbRwE+PFHS0pLFxB7OTpjRah?=
 =?us-ascii?Q?enzJg/zL0GpNZOU9KDQr8H8Uc+U0V1wE1NBLi0DY9iz3+yFBgIbGH+sY3QFD?=
 =?us-ascii?Q?Wu51EfmPKHaFGcBqm6vDLSz25D13LP+OUb7SrN0OCUR8AkoVxxCAaYBt/LwC?=
 =?us-ascii?Q?MMhwvg6hzsgDdkzcFo1C0LkOzbAzmyan3AXI09bTFbvN2PV4SEgCeUyejeii?=
 =?us-ascii?Q?4y5KLxpRL61Ox7wVSASxj+/ec30xOM3N2ioI4nsUpgMb0EoTJve/cvbTWyzp?=
 =?us-ascii?Q?P9hU06N9S7+EGbeW86emTqxp1RM2dmeF66cgac8v6t5NXgLawI3tYnIaZu9e?=
 =?us-ascii?Q?LrawxQGAeXmvkg7hhiA2PFTFbMC81cPIZet36ecTlyomYaqT6/+bomnU2TzZ?=
 =?us-ascii?Q?usBL9z1YSJ6Ff3e4tz9T7o45A23u5+8kXPeKWItRgJ3DeXOIenLH5Er0u/0L?=
 =?us-ascii?Q?T9IJd+N949sqvRaYdHGhAfXMrdKt7RT6mF8D4Y+gDo5KLgyiN1HEGU6YnusS?=
 =?us-ascii?Q?XCQdm4cKIN+QXJahAm+3szdBHDWyP/CpuD/tEvZhQAC0M6UV7e7aeN2YP+Ak?=
 =?us-ascii?Q?sh9Is8JfHAK2dLjTeXppqyr102L9jMGtZCYjA91965L1L1ZsewmG0Dp44lFt?=
 =?us-ascii?Q?ugbcSJTAeI+pOzr6kJyjiuQYHoRy791It+i5g4sDL50kY2+jO1pC3my2If2z?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zLIj32fh7nUXwIF0t+WwhXrkCEorCKqjvMlfRyFoqstFxik42No5at3mgpc1bHrsKBxtsg+xqUQZv+DangX/2NDjG6yCSsytKozmpEV4jGJQIYvvJJbgkmfxXZkQuZDZ6MjmXtv2GxCka7/x4BhhjLOdbiqahhkzH3Vg/YVTRqs66x7ewmYVziv/Gmbo7YY6f9GpCu+m29mY3cPlaxGUZahydvExhs0sI1sxI4huSrBTeqvJwPgH1hPVTrjntVQ40PtSvci1fZrhJacWA8kMadGuoTT1CHy179HZa+3Jsu/Co8y8ZgF2RL9eFmkmr8+YkvYJ7UJHEkxf2rvJL5OE6Tr2b8/+GZ14TyiZiEU8bZp4FUEA0uE2Xn+7f5470WBUyHFAR7v4Fcaz9H5Thabblgrj1NeQDYRTpyknRXEuLWLceYXbxwvEyNc5HI4XIHbELW1eQt6ndDINfSpjG3XKXEi/n+gHPn6EeMVkZp0Y9ttN6AwARJxJ/9CevsiL5Zw0kZrddWzAKSk99KMVvpXaCWNeUm03+q8KZH34PFTlV7FdeoabGqD8ZxJnFM3uBTuJ0QamTa0fAmrWj0xdjd77fLDX5sx6GkgS5AC+wYBf/nQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10bf4d2-f73a-41d9-d133-08dc2e4d3f20
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:40:48.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mODeaKH3jL19JOkA5JI6hstugqmGJpHYS/XyJ101ZN/78loe9qCnNDJw7cwfNP+3Qh3oT3OarebV73rBFcDQbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_16,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150142
X-Proofpoint-GUID: PvIvs11Hhj82DLe_6KB-3r843ovobAXz
X-Proofpoint-ORIG-GUID: PvIvs11Hhj82DLe_6KB-3r843ovobAXz

On Thu, Feb 15, 2024 at 12:00:08PM -0500, Liam R. Howlett wrote:
> * Jan Kara <jack@suse.cz> [240215 08:16]:
> > On Tue 13-02-24 16:38:08, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > Liam says that, unlike with xarray, once the RCU read lock is
> > > released ma_state is not safe to re-use for the next mas_find() call.
> > > But the RCU read lock has to be released on each loop iteration so
> > > that dput() can be called safely.
> > > 
> > > Thus we are forced to walk the offset tree with fresh state for each
> > > directory entry. mt_find() can do this for us, though it might be a
> > > little less efficient than maintaining ma_state locally.
> > > 
> > > Since offset_iterate_dir() doesn't build ma_state locally any more,
> > > there's no longer a strong need for offset_find_next(). Clean up by
> > > rolling these two helpers together.
> > > 
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Well, in general I think even xas_next_entry() is not safe to use how
> > offset_find_next() was using it. Once you drop rcu_read_lock(),
> > xas->xa_node could go stale. But since you're holding inode->i_rwsem when
> > using offset_find_next() you should be protected from concurrent
> > modifications of the mapping (whatever the underlying data structure is) -
> > that's what makes xas_next_entry() safe AFAIU. Isn't that enough for the
> > maple tree? Am I missing something?
> 
> If you are stopping, you should be pausing the iteration.  Although this
> works today, it's not how it should be used because if we make changes
> (ie: compaction requires movement of data), then you may end up with a
> UAF issue.  We'd have no way of knowing you are depending on the tree
> structure to remain consistent.
> 
> IOW the inode->i_rwsem is protecting writes of data but not the
> structure holding the data.
> 
> This is true for both xarray and maple tree.

Would it be appropriate to reorder this series so 7/7 comes before
the transition to use Maple Tree?


-- 
Chuck Lever

