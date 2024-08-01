Return-Path: <linux-fsdevel+bounces-24814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37429450B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A241F22237
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A551BC092;
	Thu,  1 Aug 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EIk1vtB7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IhQGXGkw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A821BB69D;
	Thu,  1 Aug 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529927; cv=fail; b=GwReDFHpRCrlq9d8r3Vm/EGx4+egZjOFTJJHv7H64YvGBc14GlnpgCj1N5A9Wq8wqhpU9QvYPyqiiC3/vfWX2TVV5IqT7EJrsMhF+Jg+Zl2H8BX2ZCgyJYQqzKnN5gBZLDbzFjk9BCEPaN8DWw9qrDhTJIHvkvt1RcEUOWolN3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529927; c=relaxed/simple;
	bh=9rAvIZkBqEMJF/OGzmC8x+TbIitZExhngqTTkGjs7wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TwnPB5CESr0L9SR8nlfE3K+ZwZYkfC3gLRz5SMczA0MFb8vi1+vnACKmLN/mG2D4wne2G2zRuyTlqBAwLk6yX28Ij7xutXmXPwKAPYOqov6dqRBkTGBRCUdENkVK92KD3EnWxmWWPhslKqe+X9Uhx4807wxX9yxtjEhD2/uvN5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EIk1vtB7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IhQGXGkw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtUA7002499;
	Thu, 1 Aug 2024 16:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=O/SjPFt2w3lZcOi2q8fMPdZvU7KFRVtFOTV0GecvV74=; b=
	EIk1vtB7mthWYNJSz7cWoOmnk6Gh88nO1TqbDa4cajzR1wDwNCWPgWkqfb4phL2J
	kN7z+anUc6bi3bpngGYEQlk6Ef5Kib6Ujd3kuNMgGl8/UtvOBB0PiEyOs9beMLB8
	kTqByTXL6GmhFdPfW5j1zMcmARE5GzdPZrhMWIWBLRWRN99eaereFYRS3LbTSQCR
	bNiExW/1PPLeEXGv/v6mzDXTCAuEAeST8DkweqvVl0Jt2wqLD4yVTAKrkkJ95ee2
	S9qkNz6jz/LcPd2gjGOm7+UcrUJGjbVhbMkHgj1z3dr9vq0nV2PVcxu6mE5LIcd4
	iX4foH3+dnNmDVrf/i6k1w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msest6sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471Fe9Hj036902;
	Thu, 1 Aug 2024 16:31:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp0es54-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cw+BZDK9wVxiw3TSVPNzHiGlAORMDsnYXa10QEvROzDp7l1MU1xthip2A5sWhMXw8END6apMZJKjekMLua7P1J1T1mK9dcpvxgu1DrRt9HQ/J9wwqxZrweBuHJEjqFe1yBHR1xV2GUb2yl3o21k+55yQKf1Oxb0thJxpnPUGpKZ5h2Fi8Tpyo/KZkCcCQIvy6TAC8GDMbsgK9B+CmDniVNjTiBXwtvylMc5MKoil9BU6MOZEcLuhbZ6mstaEn9Uv5ObRUd9AH3u/zJgk1S/97i664DL0aDNtzMpn6/ckcfeFRvu/ZHUG6O2xYKKwJbGCIslzJGWLsvhUYeZFue8gxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/SjPFt2w3lZcOi2q8fMPdZvU7KFRVtFOTV0GecvV74=;
 b=o1uyryGoVVmF96XGSN0h1kaUadhlS8Vs+3AMunN70TwadkaFJd3kHRyIhOvjRQgoukAxBg+fzJplJepGp+ke0/vvOJt+5l22U2gpEhL+Fh3EvEygZpsH2+eUMbr2OhvjrOOAglM0lTxRn9/Ejws41EZKDj92EHrrALPzsizgJKOsYHhk+llYx7TtTKbdM0xp8ip7ZdfWR22QTGK6Eco2b9S2BHXQBsWdRThp7bKAi1LzBTQBEjrA6d1ntx1w08DNsj3iwVvwkoiVPbc1EVil2xb+DwQv7xLCtFolN/j18kucoYrxvUa5jjOhW5Fr3rpHAvSqnJGyzLONjnFOVVf6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/SjPFt2w3lZcOi2q8fMPdZvU7KFRVtFOTV0GecvV74=;
 b=IhQGXGkwmMuUyt8Nra12Jno6vnuNmNjq7i0qWxAaG5WI7/DjhlhgyXxq9KNhDgRSb8lzbJDvHMU+2xmQympUJX6oDbELoqeSr4OWjeiaJLFHB0wYMVcTUrpArAIX/79GrBwA41mPdt/zVo27ZSRHswPNj7DC09qbykPguyT6EeY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 06/14] xfs: align args->minlen for forced allocation alignment
Date: Thu,  1 Aug 2024 16:30:49 +0000
Message-Id: <20240801163057.3981192-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 747159c1-9500-4581-7623-08dcb2476f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bj1F3LA7zAXLf6J8o8dpvI0svLWUHfKuHHRvnCG9Q9Fazo+qW6J6rUkStSMq?=
 =?us-ascii?Q?EZXxUB9B33JurZALXNCm7N0MHkeIUWSS42sNMMye6AUrYgquRNG4dWs9vZcu?=
 =?us-ascii?Q?EjOFQArDC+/7sHPO8h1l/ugSsXYbrNz6/F4yRdqnLpXRKOKFcM8G/eN6Y1QE?=
 =?us-ascii?Q?a9fLfbPb+fEnMBJNI2rF9EaSDRYeVOjoiqofftl+bfdIjEUhK8tKcdsfq+8V?=
 =?us-ascii?Q?cQMIltMUskfTF080LbLWOaTgVAc3dEo7q2YV85wjuynA8Yn65dwmcvD88o9V?=
 =?us-ascii?Q?ICHhR4HlyY/tx9ezd//r6RLtU/Bmoc5vXBJPqYCoxVNkfQZhlgvtz0DyMP5G?=
 =?us-ascii?Q?d2d0ZTw7+Foo4uhu/Iw/Uv4RpZ3tCCwbzCAAgNmgdWxANje1i79BdTHNFHCd?=
 =?us-ascii?Q?78lvHeaWp+GoHaIeoQhfWKeqakx+NPCKbqufO1Z566wLDDQR/gY3lVPwA6oU?=
 =?us-ascii?Q?5zEXAMDSXTwly/btZPypA2I9RiCdAjD9dctMkikLjJe2v/UzwySaOcn/RByj?=
 =?us-ascii?Q?g93i0TtzNJKmUNGne4fgRQ6AgU4aF0ExUnkN/ifICdGb9XTXn6LuhSLBdwCS?=
 =?us-ascii?Q?KlnN04pd/vIUIDmWgRntn/srN5ir/hLmvYWOupHtgeDk5uTCylMuzNeDkdpd?=
 =?us-ascii?Q?nbhSXXvV4K4B+x6Ri4wg01u0dd9cDkm/I5GC21QWHv3zEiHneLHFrlchbO7s?=
 =?us-ascii?Q?99uFkAbFMjoDC/WLxrwPo/NxpDCaQm4z9/qKBLK187OEyrEqFsyCgpnwNQt7?=
 =?us-ascii?Q?QYwRxW15VlHPlfuAkO8psKBnsIlWKv/pDT/LFu0WRaK2eMtRgwbMsLGNVt1y?=
 =?us-ascii?Q?fx9/IN8n9v9LU/OKw0PPDGb62IOpidJNlhcX5HeaNh7tP8XULuK+SbP7Gi7o?=
 =?us-ascii?Q?MWjuM0y9fRu4GB64eH29CwLZ+5VX9PJV43iRjFG5PGh/wEMSUxnKQ0I6OmV2?=
 =?us-ascii?Q?Y9sKIy8Wpb8UMSkomAUbljeKhSscsidj/fpDMSDvHIKYcAE5gWbKzshETMQZ?=
 =?us-ascii?Q?q34n08sK0RpJL6jy6Y2rEkbFn1Hvs7M8Nm8wDycVEaNNEXw/AOIK72qS4aL0?=
 =?us-ascii?Q?4rgTHth43mL671FE2DMA48sKwMJWAf8LgXaVAaA6FUNzsrTfQ5jCSFJ5jre8?=
 =?us-ascii?Q?HydzFBNdTGt95WGObDtPkM8bQXtToetEag2XSpHuTIdP6OVcOdSXqnDk6K+Z?=
 =?us-ascii?Q?BNFV9saFt8kg7YgFsYOsPsb7x6A01sExqLU7d/PtxRSJYuawgXWtaNiIOMRN?=
 =?us-ascii?Q?2XWcD/Nrdv6USR2iFNJ265F9bXPH/u0mWrJETXWUfXW+odJbzXGaL/MMtuTX?=
 =?us-ascii?Q?FqgB3Q3HY1B/wwVVRK6GczUSAfEFgYRfiVdwQYphpUqkgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A5oP2ksMmAAcdZAB+9BD3MWQnsZFoQXSmfFW5wpSdPmghRx1c946fJy38ju+?=
 =?us-ascii?Q?hTcRxIlxOG6L6FK9Vmo/fLs9Tfvx5pa8XyRL1x6JY2GyD+gLteNjnW/4VPol?=
 =?us-ascii?Q?dD8TrKU32/vUkZLj8JC9vi+mHsyiDzCUviFcgWBJUqqPAhCdatUOJHjIJax3?=
 =?us-ascii?Q?m0B++/4HGoGwLVZu8V14JvGMFp8q02J7cKaZUIQJbBsyW90EyjWHqPMEZPbu?=
 =?us-ascii?Q?fLYTrBwAoP5xPHlStt4ZnSyY5YD2es3qZN0mE0ki99B5xYCeejh7HGVcP7Oh?=
 =?us-ascii?Q?7oMjLaQfjwl52kmrUEWwfr+jFA2iNXFH6OsMH8cQ7ebaKCaiivkI/WgpmDgK?=
 =?us-ascii?Q?vRPmJzREA4iwqY/i0HahIgV4uRNzIAvCQ2LHdUaP5IvGF23hxgoNhCYcZCxU?=
 =?us-ascii?Q?YQ/BsWmH4j9NyzhXW0rePs1L5EZ/nrCwFUxZmxLWk6YMnYS9gXzLu6WquCm4?=
 =?us-ascii?Q?qdWds2+zr2n5Mkke657QM47mRQ94mjeoICdtONK0Q158/ayptQ8CBEFQF/QB?=
 =?us-ascii?Q?IETdNAlJZMcMNeQvxj5nLaAFPCdNKHPUlJ44jtCQLRVXMaJt4fph4YPf76mf?=
 =?us-ascii?Q?Id0wNRc9oa+Qauwb8Cv2rNk0LO/LT9FAXioU2zsbMiGpIlRiTRukdkQN1A3E?=
 =?us-ascii?Q?Zbs2OxyVR0Tbu7pYuHv4lbGu6KWkqyC/a8viyY4vI0Yrha5x34BARxRkBIbt?=
 =?us-ascii?Q?zg5gsR17DWvOi3zdvDEYy3Eh/QEl3dLbDx5ngNuw+KtYh3uNmtOobJ1lyg4y?=
 =?us-ascii?Q?BKSe3x4kOsE4tL2hgtLgWNU7GsJx/6maB3UA6L7ReXmWj555z9/lFK971FY3?=
 =?us-ascii?Q?iX1T3ZCNNel6FSzSzuj4sJWe+vXIi7WT7zWR0a0TzCpuBiWhwe+YtXcXpybc?=
 =?us-ascii?Q?hBvpW5a2INXgYkPO2s+nNDhnEDRK528BCA0LxKOj3WtSZpNrWGyWaDf5plBH?=
 =?us-ascii?Q?uaQp/hw2dBfN+t/04mePmovpTyVYVG4qEYkz+rfAsXDEe7oPp3Vzopor31Kf?=
 =?us-ascii?Q?FfvWi4pbA7xkCSRWTjbrCRXaUmjL8zhSptpAXWjWbo4W1tCcfn70Qjae6dkf?=
 =?us-ascii?Q?VedtCQhLbyn2M43RXGEvzVxK7n/Kg0jyiYOviBo/nVa90RhOVi8T0EnL0pEg?=
 =?us-ascii?Q?P1Tqxnauk/aQ8AoDkcNLkHgXBLeVP7CI7D3CsxYrVI1p4DvojXdpW2cEfOwg?=
 =?us-ascii?Q?KGdKaHTSsQbuj82rQUHXsC3DQGwNXF1SXAU6+lwJFFzcQlS+Mpf563Y08o8J?=
 =?us-ascii?Q?qmxNcYe++oBRpo8sLZJPWm45Jz5rgMFOxCCrMDh2yOtfodfQ9hBkcKifjH4V?=
 =?us-ascii?Q?9lf7s8g2XHhNRGkWFmr5Pj5+179iURSQ4RON70g449YM6Qp08sZOOI1F4jkh?=
 =?us-ascii?Q?msSuPsox+V0/m8/xg5HqdQAZ/pZTT5hAbBEB8YWRMtpEaGSrrw6UB10OZ2o2?=
 =?us-ascii?Q?QPJPeZ8OOX80VXGVVFPUUuQAtOAT2VVR3R7LauzvXSDHeK3hjH84Y6NMhWCi?=
 =?us-ascii?Q?2vluG8bb/5hHQYmmRhO00QjzQANBy3znZzgwScXKnxc2tzTkVVoQ2qIUB8cs?=
 =?us-ascii?Q?4VBdMhlWl9RLHD/nyDTeB/sk6vruV7qLugmgDM0OH9PaB05V9cXsRB6x/zss?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xfi/hI83hWbvujha0dTny/K0JCw6cf70tvlFwMQxH/kl/DAzpgcIifxga538Kb7SVirxEzb0lVPnEGLrXbHGl+Ax5nY5hdV6fcibigxduffKS9InWvtTF1QbJA0MYtbK/oRRuo79gehW42x9xXkRN2UFW/QzROyMEwHe4DXXKOoT4RG3wPE8Mm8E7cLbdIphOpYZDbi2CWjrUp4Qr2yZtX2/Ol2H+4dAjiyRZ09894XxPnFI+AUTtPUazJhLBpO3a7S1hxV3Y7aP0tli8XbVqjyxKX1lapP1pMDbxGDMhZHKVY6yIHPZ4rcjuKQ+T/mdgpU+wENkb6E2gOKY7fUlEeWD/hw4577ErQWdMHqBn/amy6pmmm6KRoE4QbDo03F8dlcFueClm/Va3n5FwAhrTff61UtJsWzZ5tatljvHVuMxvy96rG7KT5pgyUdEvBT9kxM+HmRBiyq/sw/7eA5qW/WomD4b8uZ0pTiG26Wt8hU/rvRXrjn7uRh4bzeywwtruazu1NdZ2hyfG3hI/7gVxzo922imUUqTsU2NkLeaiN2MpCFmU6GionM92YgAvuoOtDrwgBXGoVZJ3NrZmAbIgJib5gcq3R0yR+C2nphMsks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747159c1-9500-4581-7623-08dcb2476f31
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:45.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5N9s/RtR/7ESokTMd0Khj/gSg76idqssk6BkU81Oooj5mlSBJuPZ61MoguAO58bKnFcYeS3m9YZEJrBVtSshw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408010108
X-Proofpoint-ORIG-GUID: C3P-rQKk3V-7cUZlXVUVDnrkEwEKTcEk
X-Proofpoint-GUID: C3P-rQKk3V-7cUZlXVUVDnrkEwEKTcEk

From: Dave Chinner <dchinner@redhat.com>

If args->minlen is not aligned to the constraints of forced
alignment, we may do minlen allocations that are not aligned when we
approach ENOSPC. Avoid this by always aligning args->minlen
appropriately. If alignment of minlen results in a value smaller
than the alignment constraint, fail the allocation immediately.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 44 ++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 602a5a50bcca..0c3df8c71c6d 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3279,32 +3279,48 @@ xfs_bmap_longest_free_extent(
 	return 0;
 }
 
-static xfs_extlen_t
+static int
 xfs_bmap_select_minlen(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen)
 {
-
 	/* Adjust best length for extent start alignment. */
 	if (blen > args->alignment)
 		blen -= args->alignment;
 
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
-	 * possible that there is enough contiguous free space for this request.
+	 * possible that there is enough contiguous free space for this request
+	 * even if best length is less that the minimum length we need.
+	 *
+	 * If the best length won't satisfy the maximum length we requested,
+	 * then use it as the minimum length so we get as large an allocation
+	 * as possible.
 	 */
 	if (blen < ap->minlen)
-		return ap->minlen;
+		blen = ap->minlen;
+	else if (blen > args->maxlen)
+		blen = args->maxlen;
 
 	/*
-	 * If the best seen length is less than the request length,
-	 * use the best as the minimum, otherwise we've got the maxlen we
-	 * were asked for.
+	 * If we have alignment constraints, round the minlen down to match the
+	 * constraint so that alignment will be attempted. This may reduce the
+	 * allocation to smaller than was requested, so clamp the minimum to
+	 * ap->minlen to allow unaligned allocation to succeed. If we are forced
+	 * to align the allocation, return ENOSPC at this point because we don't
+	 * have enough contiguous free space to guarantee aligned allocation.
 	 */
-	if (blen < args->maxlen)
-		return blen;
-	return args->maxlen;
+	if (args->alignment > 1) {
+		blen = rounddown(blen, args->alignment);
+		if (blen < ap->minlen) {
+			if (args->datatype & XFS_ALLOC_FORCEALIGN)
+				return -ENOSPC;
+			blen = ap->minlen;
+		}
+	}
+	args->minlen = blen;
+	return 0;
 }
 
 static int
@@ -3340,8 +3356,7 @@ xfs_bmap_btalloc_select_lengths(
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	return error;
+	return xfs_bmap_select_minlen(ap, args, blen);
 }
 
 /* Update all inode and quota accounting for the allocation we just did. */
@@ -3659,7 +3674,10 @@ xfs_bmap_btalloc_filestreams(
 		goto out_low_space;
 	}
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
+	error = xfs_bmap_select_minlen(ap, args, blen);
+	if (error)
+		goto out_low_space;
+
 	if (ap->aeof && ap->offset)
 		error = xfs_bmap_btalloc_at_eof(ap, args);
 
-- 
2.31.1


