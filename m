Return-Path: <linux-fsdevel+bounces-35076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA689D0E81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB91280DB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B97193430;
	Mon, 18 Nov 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IHHtaoMD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ITIYda/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FF3D551;
	Mon, 18 Nov 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925661; cv=fail; b=OyDVXpv1/ayVPTNUI1w8IiAGne4T5+fVINMCEtGuJL3oltierySBTTxAQiS3BYyLMesVTT7tgznSvaO72d7wQusMvPn3ykEADimKEhI4hUx6p/VcGIbhpkuUBgh1EEiX871i1BeCK/l2H/HejW7SRWvrw1j2GaYs0KPrcV1Aqfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925661; c=relaxed/simple;
	bh=l82fBFy9uWPq6m146vpIaWcBuGxCyzsFvW7qjYX6bmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZUIN6+O6iAuA8abZ7ALKYamO8QhFLrgx2GLHmned2JrHwmmpOHdDRmumZCE/MsEtPYp0JS6kZgv+rA0P3hCWtJYdkVDaXmdxPpoRq1vb6HZphZYXprOzrVF2suRMZJPWus/cX5YZxu5Kh1xgnax84/2m8RK7GW9Rj46PFvX6qQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IHHtaoMD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ITIYda/t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QZ3k001069;
	Mon, 18 Nov 2024 10:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Ukslef0CsftjHgvWR9
	jDXwGwQn63mjIW7WDJwxmhVfk=; b=IHHtaoMDicPvtpmwhRRkydqEP5E72klJUy
	zkCroS2Wgemacq1PbPkuw/SNhRiHHupJ/gCgnTA2r8ADv+MhPwpf1jjLL+BgGtRF
	mjCNGqOG1S5XRvDm2kNF96sCmp4nF5LVy+o92JN1mBX0yDw30Y+nwsXCjvzVhht3
	aqSFaNqxYgDo0IubfZcFoVOXOwpC1gQWV4fWNa3X/xOpkQL1jDO/KCAEmA4ZL1Tn
	duFlq9EOxyh52PYZ5qykgVhV0j2AVIOFRaZlciokmwUdXPvW3X744kI+0feurDgy
	rezoTPzcKs8AMa/Cs2Pdmpt7UGoAKFVNSK39XSwjx98HS44Tg6vA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyyacj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 10:26:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI9IVHe039175;
	Mon, 18 Nov 2024 10:26:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu6vmjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 10:26:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/b5yK5wtKHsoIewVOCwLOpjmUmBkO/RxOMpuG2wscrtf2tWbgEaqUnaonS/AlR0u7AW+z77Dir7XIVQ0EOiVHO0eTJ0UuDvfhjQ8BISQSsGPtPanIjvC5WxJG4dctNYscsB40NRQSd8aax4qeANvMxaJ6HwIfGD9VTycwSX/BqL+PY+Y0tW5B+PSdZpT2fNUDpc9BcsrekolNI5z0cS38BDLOPs9k1I522C5F+F0OQJSRpXBdBNxlmtssep6lty6byC5DsKZonII3OhZvzcDRuHk/YPjcj9jkrlH3iShnGAE6wiadDVURimg9+5RTljsmhoff4WBUxeRmlUAJ0tkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ukslef0CsftjHgvWR9jDXwGwQn63mjIW7WDJwxmhVfk=;
 b=a/WhqD4PViHZ7EhsJm87+yXysrmKdZ+yYJFnnD/VoItf4YaXGSARttZOFLr3KEPNA6NThywfWYEkZF/JMQfNIlmW3NoPFOGIlYUYwJIvV+SjdtJJug10V1yO6ajWwhJ0+A7E3dtR142sdYj0aGR8CWpnS6w+sZrmb944WPTth0upu10CDdTyCkOwD/o8IUsw1235oXvPIbwwIw/RNWCyrbn1SA3ER/SDcfZ1EjL/oBzwgM09G1qsBci4Gy8uZTCB2KXTEyF5+H3NE5rwaazTy5+XnZ7f9QslzJVHObv/zi5QpnUgh8ev4wOUQq2iZGvevmn7IkmIzLx2oXn7/3kpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ukslef0CsftjHgvWR9jDXwGwQn63mjIW7WDJwxmhVfk=;
 b=ITIYda/tgQKXklUX4LKW0qXlOD/BY3AqfXdQlb4Vte2jdVuQqJMNC8M84QpgKwQfuTmo9LRjEsueeZW2tgbyDfJTCywlYG6BadAOaFZGs66eiAze9Izk39tnWujFq6isY51cok+8xYXXYtgvnFCje2JQOF0fWHmPJBXp8CbbtUE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 10:26:36 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 10:26:35 +0000
Date: Mon, 18 Nov 2024 10:26:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com,
        dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com,
        vattunuru@marvell.com, schalla@marvell.com, david@redhat.com,
        willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com,
        andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com,
        oleg@redhat.com, tandersen@netflix.com, rientjes@google.com,
        gthelen@google.com
Subject: Re: [RFCv1 1/6] mm: Make get_vma_name() function public
Message-ID: <8871d4b3-0cd8-4499-afe6-38a9c3426527@lucifer.local>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116175922.3265872-2-pasha.tatashin@soleen.com>
X-ClientProxiedBy: LO6P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 6419d046-c138-40f1-c8d9-08dd07bb7a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23p0vbr2D987IfrznXmm+NrjHnKaIrWRspPHosSEPKaZSz2G0v2xqhp9Ihvm?=
 =?us-ascii?Q?+wpmiEIqp7pVsvlEUnZ7ZcHaP9DMSjmh1LOBaT5pu/mFO1EZgxOYqiJU9guB?=
 =?us-ascii?Q?Hno2ruRMNLsmJ8WD288p4stkRujlNOw0kwNgeYcpJEZKWzxi2JQ8JfSRqst7?=
 =?us-ascii?Q?7mK6E0u2GNFTGubIeLXJPfs1BVzVGGg9olyXqULjQw3xHOE2aLQknDYN8OXr?=
 =?us-ascii?Q?Xy6Zxy7L2xXKCyBccjshmx/QEQnJltYwrE7UcZoIAXd79GP1rn/Vf/QWoJ2O?=
 =?us-ascii?Q?8QptfEXCghYq1NaOdEBR/AxZWHTId9M8oCgjKZ8+uFNS+sAQ8ub18iSbIMHX?=
 =?us-ascii?Q?v4eR3AHZZYYiL4K9XJp8EeXPLvXJJBcFtQloy7wNPhyX0xUNqr/e39a+YXcW?=
 =?us-ascii?Q?QjnhxpG6mvQpN2wCk6oHAk7Eg3cGJC1IiXo3RQNXgFerjQTznER3aZylYJur?=
 =?us-ascii?Q?QnpevLLejBdnbkWasKNzrw9x0LjD0XNdyL9HpXbt5Sn8wCU12N3IVHCbbK8T?=
 =?us-ascii?Q?0880acKTPd2xG2G07gHHSmzSOx+9PfHhVLmScrZevCYtllKrbcVit65hlaaF?=
 =?us-ascii?Q?LFDtmQHKWcjCmvYiwLSNfruykAzjDm8Yu7wSexnU5qs4RFVCQKK2p9imlTQS?=
 =?us-ascii?Q?KbwO6oFFKaBSrD/G6dNsGqFbp7v1+LZUIJlsAgR1eRZr+dOPR/A3e5lGWpKF?=
 =?us-ascii?Q?VW0sdScwLXFf9Y/dqXYsMD+yA0g0LwHTUTv5QMhQ3WkPfTgmf0ERfGF1yrnY?=
 =?us-ascii?Q?1/HlJvzBczUwoM3MjW/VddRGCrPSie3beRa2E/66o1qMvv4jLU8ONatVhTqQ?=
 =?us-ascii?Q?RKRnbrWdxrONRYzmDXDrE0DTclAOVr3xN0cs4c1Fl2C8hjxIMc7LPJMeaU/l?=
 =?us-ascii?Q?WVr3KsOEZDaMrXsoKP4lZXo3W1GHPT61cxmBNGVcBLJr3Evbvciobd8lRaEJ?=
 =?us-ascii?Q?J+/7ySD+pVFOhmvoSHTpQIiz/at4LG3FzMQ17jTUTthJxp0roUT/XB0nMlOB?=
 =?us-ascii?Q?jvMhzi6T+zRLzk4cvYhq5fZNuznaqpP84JkeD5EhwqFe26/E6uDPA4tdDJ2h?=
 =?us-ascii?Q?r0InerPecDWwENGY4LN2bIlfx6Nf1jhImONyPUKsy5ll41PIabwoa+ZXgeB+?=
 =?us-ascii?Q?Fn3yBWddyS+2OMfrmtHyJL+Ko2ztCgX0Wcfdtpi/ZcjfDl/ILGetaxCRciQR?=
 =?us-ascii?Q?jkDZExzlw0PQ9X4CbgGitCH7kpw3GiDXJbrIoCH1sUDLuJsMmnRkBc8JTx7I?=
 =?us-ascii?Q?/8e4fuY8kDtX5MIlDUlthXvIJS9ipjTnPpNP0XVHGE4deDwpQoXJoAPYiiUS?=
 =?us-ascii?Q?xmdTvygKL8CpZ9ebQM047HAN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k4Er2A1MvluyxPpCBVUt+KYJuCSyK+8OjJgdMOLKowM/GXpLkpFq8FdOCMLQ?=
 =?us-ascii?Q?hLm5+ot7THsDQk54uyrq5VXePRkyzF7JKkiQvxMSMVuqKzIvFSEKxefwTeAD?=
 =?us-ascii?Q?WAnan7gNQ4E7Lc10Bg8DJooYwJcNqMJEQLDwQLEmZLJa7GuVgHa9uCUkb6Ys?=
 =?us-ascii?Q?fhRWKR9lrNV6Y2PRzngQwc5ZTS8d1LRhb8enmbzBtDySVYDvc+1XNh6a8tzp?=
 =?us-ascii?Q?JcIdkAdmuZZgwNvQLWPGO0hzMqtVTUM92r/Vt1cfkPEALf/Rt3YM+UEmqyfx?=
 =?us-ascii?Q?P/C1Qc657sM3Ni1yPqazq0aho5mBVyanyMhlBW4w4c+EFiIlDxGme4tby2bQ?=
 =?us-ascii?Q?pnW5TQ4oJ/xPXz9XoRrBY4iNCCu1vd0occEcgI4ABe8SgORuYxURJOeDDMF5?=
 =?us-ascii?Q?DFeLfHTD76yyY9bxwnZbmdASEaBaqV1uU56DZ22HDfr1QDn214UOppYLe77h?=
 =?us-ascii?Q?+poT+zGVJu1+CRGYJBh/m2yxNwfMPhBVg5/KWEPJcG25upe840+1TGjX9QtW?=
 =?us-ascii?Q?qdW5/8P6Tt6FpwtwD/OKNIZLQFleo/g8f9u5WRJO6Dm15WVKcpMx/90RL1ag?=
 =?us-ascii?Q?AL8CPlUwXjuXDXumRG44awBr+z7kExBmx9ARRyi7Gi9Tm/sHiepEJMyT7bBB?=
 =?us-ascii?Q?8Z/G24hD1ZKJ6c/vDGIyqd3RCy4nILulmxXeXgUIMJOIRnDjLH3Zi0EbzVVU?=
 =?us-ascii?Q?g1fjyK5O6MORmGeGb8yr6YFiIKw/MugrItOScV4+FfZaYKJ6bSMMD7i9Ntqp?=
 =?us-ascii?Q?xClsAeZihRQ3p9eBswwF4iJBwHGNvHo6qZ17Za4QtxvvJvUkryK8BN7qjIiv?=
 =?us-ascii?Q?fbZeu18qXGP+S9mD7ZhmlPVU9/TYIJg0Lszhe+l3LOqNJK89S0nFPxj9dH0L?=
 =?us-ascii?Q?vKj8pTIG+dsgMBncRsQdnTF8qsF87f+n0yCCT8EUpHqHwRdQKRtBLXWV6TSV?=
 =?us-ascii?Q?sfyP89PFIN+xShMbc4tbFXS2sZVJ+h0Ae/51NHjxrFlfhpJwk2w4vHlPPbbT?=
 =?us-ascii?Q?CvEPc8tA/HxuEi+pl0al03aswHe0SB5FewIx9Trx/80UT1VmyLBoONVUkYJu?=
 =?us-ascii?Q?1hDbZLGBqBBiVf1e/XW/QnDPjBv9byh0oWEWdywKECSImNjnCeZc40iDarv6?=
 =?us-ascii?Q?gE0p/PICUV2XM9dayRoF4AsZ04CFFT4vS1Th9SIfkbVHjT8V/HBVJHq8vzM8?=
 =?us-ascii?Q?eeKpLdOsYbThaVv9L59NlEh3dQUA2nXjDdXFa30GrLSjsxXLUp01swif6Sj/?=
 =?us-ascii?Q?t5UWSkOiePyhhBdg1E4C2l07+LogJYDzifgQ3AxjRJLH2yz93ueGdA4F1zw/?=
 =?us-ascii?Q?DIGNw5L2UnGWyZgAk+NYhz3k0Z78aw5VavXpNkG0QFhvj/ZF5Joy9xv9/52k?=
 =?us-ascii?Q?0eig0jbL++i6e0Zuod1ujFGuFa1pUa6l/hDMCyRf6avno00PxaDq0EcIhju5?=
 =?us-ascii?Q?McpBIi2+9ljvLroVRQpP2mFrPuPzXKbOf5nPT/x1Jn+wnWkvf+yTeqXtW3dj?=
 =?us-ascii?Q?Y6dT/NLj9zZuQPmEW2onppjmW4RneahHfS9DkWjqV+ZwYTvd9MeVpsDiyvuP?=
 =?us-ascii?Q?sP6yfnvv1/vxAU7zLH8WlZndKsyr1g5RQVXig2ztqBsmdDNfcWF1CTas281U?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WeS8EXqNm9bw5AC+zrkZdbqgBgDl/I38tgJj0/nU2LQIotOqlTeL3+wZzf/F2THgHb452dv6pjjxKyT9sGPnSEcAHa6bWv2YVlsHsJMk8NfxLD2i1KNdo3lTVHU4cX5KP0w7QL2/w6hVeERYhqyGQYAQ+FQwRa0+OtuB8Ru/4y672FiWq06MgONvNFD1LNr9SgmNfJY9+iQ7bvR9r5lEIsyH/1SqaEP+42OSCQAZHO8X9iNZs7KPdz/QUl96pnsDhfKHIxaQLrL/WATkRGLMg42u3yQxnD7rRwjQzpRlvb77RjBRtop20/hH7SFcu00CybQL47f45V6SYo3pzT2uu3MZFItVJ4TeZ4tOkOBaKrSN8KNw+QfF5VQsVxtUFkwIPXf58EvWe/mNTbCJh/mYrbsRn39bt+iTda1Hr/taLAF4AU/227BzLBLUDxX/8inXK5BEsT62a9qA53PGz4ln3ZW1JJVZXimlfNXklG/Xs2HeP3J8WvOQCvTArVXuPYHLfFaKwPFo3wO7q7coA4R37pg7nmrk6vSDIb6hlyPev2Kvb7OmWGo/yD5jxj5wKw9KMn0zkjUlVD/aqkX9+luXc/V4HeBa2UAIac5S/XaRGQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6419d046-c138-40f1-c8d9-08dd07bb7a6c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:26:35.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7j0EKmEqgA5sCtOsBwSkRmtTmcm6Tc+plOxSOkeZOjhYbC9AAfl1+SHhYYznwnRCsyX0JGlXjSGWIcMZc7TV3EHNQpRG+kCb9j3PKQ60yB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_07,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180086
X-Proofpoint-ORIG-GUID: hul1q0Ziakz27qYBR5R7qaA00_y5rMOU
X-Proofpoint-GUID: hul1q0Ziakz27qYBR5R7qaA00_y5rMOU

On Sat, Nov 16, 2024 at 05:59:17PM +0000, Pasha Tatashin wrote:
> Page Detective will be using get_vma_name() that is currently used by
> fs/proc to show names of VMAs in /proc/<pid>/smaps for example.
>
> Move this function to mm/vma.c, and make it accessible by modules.

This is incorrect.

mm/vma.c is for internal VMA implementation details, whose interface is
explicitly mm/vma.h. This is so we can maintain the internal mechanism
separate from interfaces and, importantly, are able to userland unit test
VMA functionality.

I think this _should_ be in mm/vma.c, but if it were to be exported it
would need to be via a wrapper function in mm/mmap.c or somewhere like
this.

Also you broke the vma tests, go run make in tools/testing/vma/...

Your patch also does not apply against Andrew's tree and the mm-unstable
branch (i.e. against 6.13 in other words) which is what new mm patches
should be based upon.

Maybe I'll comment on the cover letter, but I don't agree you should be
doing mm implementation details in a driver.

The core of this should be in mm rather than exporting a bunch of stuff and
have a driver do it. You're exposing internal implementation details
unnecessarily.

>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  fs/proc/task_mmu.c | 61 ----------------------------------------------
>  include/linux/fs.h |  3 +++
>  mm/vma.c           | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+), 61 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e52bd96137a6..b28c42b7a591 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -240,67 +240,6 @@ static int do_maps_open(struct inode *inode, struct file *file,
>  				sizeof(struct proc_maps_private));
>  }
>
> -static void get_vma_name(struct vm_area_struct *vma,
> -			 const struct path **path,
> -			 const char **name,
> -			 const char **name_fmt)
> -{
> -	struct anon_vma_name *anon_name = vma->vm_mm ? anon_vma_name(vma) : NULL;
> -
> -	*name = NULL;
> -	*path = NULL;
> -	*name_fmt = NULL;
> -
> -	/*
> -	 * Print the dentry name for named mappings, and a
> -	 * special [heap] marker for the heap:
> -	 */
> -	if (vma->vm_file) {
> -		/*
> -		 * If user named this anon shared memory via
> -		 * prctl(PR_SET_VMA ..., use the provided name.
> -		 */
> -		if (anon_name) {
> -			*name_fmt = "[anon_shmem:%s]";
> -			*name = anon_name->name;
> -		} else {
> -			*path = file_user_path(vma->vm_file);
> -		}
> -		return;
> -	}
> -
> -	if (vma->vm_ops && vma->vm_ops->name) {
> -		*name = vma->vm_ops->name(vma);
> -		if (*name)
> -			return;
> -	}
> -
> -	*name = arch_vma_name(vma);
> -	if (*name)
> -		return;
> -
> -	if (!vma->vm_mm) {
> -		*name = "[vdso]";
> -		return;
> -	}
> -
> -	if (vma_is_initial_heap(vma)) {
> -		*name = "[heap]";
> -		return;
> -	}
> -
> -	if (vma_is_initial_stack(vma)) {
> -		*name = "[stack]";
> -		return;
> -	}
> -
> -	if (anon_name) {
> -		*name_fmt = "[anon:%s]";
> -		*name = anon_name->name;
> -		return;
> -	}
> -}
> -
>  static void show_vma_header_prefix(struct seq_file *m,
>  				   unsigned long start, unsigned long end,
>  				   vm_flags_t flags, unsigned long long pgoff,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3559446279c1..a25b72397af5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3474,6 +3474,9 @@ void setattr_copy(struct mnt_idmap *, struct inode *inode,
>
>  extern int file_update_time(struct file *file);
>
> +void get_vma_name(struct vm_area_struct *vma, const struct path **path,
> +		  const char **name, const char **name_fmt);
> +

You're putting something in an mm/ C-file and the header in fs.h? Eh?

>  static inline bool vma_is_dax(const struct vm_area_struct *vma)
>  {
>  	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
> diff --git a/mm/vma.c b/mm/vma.c
> index 7621384d64cf..1bd589fbc3c7 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2069,3 +2069,63 @@ void mm_drop_all_locks(struct mm_struct *mm)
>
>  	mutex_unlock(&mm_all_locks_mutex);
>  }
> +
> +void get_vma_name(struct vm_area_struct *vma, const struct path **path,
> +		  const char **name, const char **name_fmt)
> +{
> +	struct anon_vma_name *anon_name = vma->vm_mm ? anon_vma_name(vma) : NULL;

If we were to export this (I'm very dubious about that) I'd want to assert
some lock state and that the vma exists too.

Because we're just assuming the VMA won't disappear from under us and now
the driver will too, and also assuming we won't be passed NULL's...

But in general I'm not in favour of having this exported.

> +
> +	*name = NULL;
> +	*path = NULL;
> +	*name_fmt = NULL;
> +
> +	/*
> +	 * Print the dentry name for named mappings, and a
> +	 * special [heap] marker for the heap:
> +	 */
> +	if (vma->vm_file) {
> +		/*
> +		 * If user named this anon shared memory via
> +		 * prctl(PR_SET_VMA ..., use the provided name.
> +		 */
> +		if (anon_name) {
> +			*name_fmt = "[anon_shmem:%s]";
> +			*name = anon_name->name;
> +		} else {
> +			*path = file_user_path(vma->vm_file);
> +		}
> +		return;
> +	}
> +
> +	if (vma->vm_ops && vma->vm_ops->name) {
> +		*name = vma->vm_ops->name(vma);
> +		if (*name)
> +			return;
> +	}
> +
> +	*name = arch_vma_name(vma);
> +	if (*name)
> +		return;
> +
> +	if (!vma->vm_mm) {
> +		*name = "[vdso]";
> +		return;
> +	}
> +
> +	if (vma_is_initial_heap(vma)) {
> +		*name = "[heap]";
> +		return;
> +	}
> +
> +	if (vma_is_initial_stack(vma)) {
> +		*name = "[stack]";
> +		return;
> +	}
> +
> +	if (anon_name) {
> +		*name_fmt = "[anon:%s]";
> +		*name = anon_name->name;
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(get_vma_name);
> --
> 2.47.0.338.g60cca15819-goog
>

