Return-Path: <linux-fsdevel+bounces-23020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894FF925F67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 13:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F9128EF07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 11:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9AA17623B;
	Wed,  3 Jul 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dN9Iehes";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BWTYIwvf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6617332B;
	Wed,  3 Jul 2024 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007898; cv=fail; b=ReBW9yeRHWSrXZj4JzKEOQKiCoQZFqYs4TiWdEtRl+1qObv6Y9WC3zGA1kJvHZOX63yPZiIOqwT1Uw+b3xmYtXfQNAdY50BTXTXymm0PnuORM+VIZiS1+8K5JksU/laq4/eGeOblzQ/a3hEZ1iTaVq2mc90FKl1qlKcXZg0tiI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007898; c=relaxed/simple;
	bh=XcfzE41GYLv7CnyyfANW1Q+qNQzAM2XvU8b8MGAggMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEXAlUB3gAZWuF16WWaMmZF/TyyNkt7eTnquQUB6tl1tIgzN9f5zrS00CANTbo1h8tBGbaA07QIp1khiyLbIQQuFzEVxqnDFjP8J0ToS87tg5YDTPef6iNzfIXjq/+yaKFyDn6370NkM/4lS/ePbmsGYldlIkTpFf7Qec7mlmAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dN9Iehes; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BWTYIwvf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638OEA3015994;
	Wed, 3 Jul 2024 11:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=7yUoHz+y4bBA4WnYst+c6VR5ABPk6RgWVBzoDEOoRHM=; b=
	dN9Iehesf3sF/JZx9cSYvNCSJ3S6RKUkjzR4SHe/Q5oTtuz26EcFovg/tDET0ONo
	45VoX1i5TsNFkh+sBqcKKo1NjQspUn2+Zhqw/ioExth+5kmVln++ViELVDtSLIqT
	kNARuqYMEWHKHKiVVkv4mPiSSeF9x4FWzlRnP5hQuTKiJxbyWh4mEHtj0iV87DmQ
	/yFjRes+zhn9dHQeo3j9Kh8BhTfHihmKV3oSeGELdMnagAYhh2huBGeuXd8nG9v/
	J76jYzvD6sSZjprG8Hpa5CkRUCzm8MI0xi5Jfinkk3WOGCAbGV1tem1nwoSSc4Jz
	ny5cV+yld9tVMz613S8Wlw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a597t25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:58:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463BN5Cb011150;
	Wed, 3 Jul 2024 11:58:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q94qwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDkT+6ELJfItLUro7PYC0ITfXxMpGuToxNo5QXMzIfwn8tAuiiLITTDW+jNOe/FNgB7Fg+pRkUU0dS3v/nJi6EbcS8EGzTK/c2qKi6UxL5imnekcoK5K6sl5yGojZalspUSYfzdG5g3burwranEOtNHxdganjxvNfr5Fwy0pKsIMDEL5/mRr6GhbXLYjPlDeA2FMcRebVjSarh4afNXPsc0nbTrdfkXyBloYVKuvxNB6AcAB1/hcAwpMHRJkEn7OUmq4LcqbhJkgt4zzo9A2a78JoB7yBVuC6kCaPwZ3IYY7T9B8LNaFT84s6UwUXG5vwAtbUULKAsaAzxdRUnmO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yUoHz+y4bBA4WnYst+c6VR5ABPk6RgWVBzoDEOoRHM=;
 b=El79l+rZxvsF5XCzve44uDZnD+RkXbM0nhoH7ebDLFYhk3wG7ceLxHEmFuZWklYJMm4xrutvU1MV+RkH/eY5Mps9hNPUu6KMgHLUMF73rE4vl6zaXKoSJu9SHtx/et6Q1fG1vfPphSVU0pNLCF0sei8Y33mfhu/sU12YIBn/EJZfw37SOcnUDW3i0HeRzKKRJXZTi9DKySHNEf1fNnYio2pW6yaxCoW3LKosrsskdfZSXtrG4XTIoBsIvJjERHA/Ek3lgfpIKhFMbewawThrwj8e2jznb5nnuEtTwPpaYi0UG2oR7YS+7pjJEFBMxsM6F3ekcPEYZhyYm7YvRBFnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yUoHz+y4bBA4WnYst+c6VR5ABPk6RgWVBzoDEOoRHM=;
 b=BWTYIwvf6w4SA7G7s7PIryiulNMV4k4eTkUbvF/WiM1r5fo+/MONxbP3E61Ykt7JAsaHe8p4Hq6axISzrC6lKQB134n9mikaiEoy8Yn1WN8Fq3LyZRCXFv/WU9KbddMnyMCYO8mJ5PKm9ClKPDQHZFweOxGkIma2dPZIv+7/Luk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB7832.namprd10.prod.outlook.com (2603:10b6:806:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 11:57:57 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 11:57:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 2/7] mm: move vma_modify() and helpers to internal header
Date: Wed,  3 Jul 2024 12:57:33 +0100
Message-ID: <2f6f2495f8c821d30a29939a2a2c0869ed6205db.1720006125.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a3de96-a0f2-4e4f-12ef-08dc9b57610d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vJ9KXN67Uot/M3pvScGJblU6CQlSHjNoP3UOC+SdNShvMtugvbWyDqD/mesR?=
 =?us-ascii?Q?XEkH1zG92F77l7PqXIQUPgJEcAWxR5KxTJdie5HOBJwKNLe31WFEMwPX/CES?=
 =?us-ascii?Q?h4I0Ke/GL8cTbTioXZjVCnr2d0ZKrdjbWZIX1hN1ryKIvSFonLp6oD/Rgi7w?=
 =?us-ascii?Q?ffst/di43iCtTnk8T+9l02xeT7GVfUe+zm6KPEuTawni3u9/XopHOXa6YaM3?=
 =?us-ascii?Q?Ebj9VM9qXj3IRWtUdvbX1Ce0PaW3ZA6idm2Td7Npv3SZJWO1wz/si1AepgIr?=
 =?us-ascii?Q?sb+EdnMYBWPJsb8c8oNkTU91yOTUobFY2nkCQZ4FwynE9BAizXOcLpjAVBR5?=
 =?us-ascii?Q?BjpSBxQxLrQW581P4uxhfuxcznYGkuQ82+faPGXoXu5DDDABKCQwc7bpUy72?=
 =?us-ascii?Q?b36KkrsUN8d/Zvbptae1DJJ2cAeqE9/EZv5jyk76nD1/u9J2iuIeDp8544AB?=
 =?us-ascii?Q?WVc2yrRAvKSi0MfHXtvCqbQ2SL+jhca9rAgZ1k0EzCFecVlaKGEKGJLf86IP?=
 =?us-ascii?Q?RMGBUyRAcPV7W0Uxr2ZBJuAsbSPFNcmj+FEuS68Mcvc1/K5WxrRMsvocjzew?=
 =?us-ascii?Q?MJIkrZe9Wpz2wlXGm5EUg1RLvEjGdPxeDf3VHWnY6Va7Xxi3pcX1gKtx+khM?=
 =?us-ascii?Q?FnNckBGCeljuv6o5ufOMotIFTr+hIrp1d8MG+AFYrbAwtdkx12uLM3CvyQ/I?=
 =?us-ascii?Q?99xd5JVPUraa+rZrjnm97f2M37Emjuqwad24iTgwD8J2mEHgzXYVd5M3QuBM?=
 =?us-ascii?Q?fWKKlHuuDR+1xF15yb49X45GcoI+RUEbHOMLFGSxIkV6IYnUB7vOwkv0sZdI?=
 =?us-ascii?Q?3FbyiR0XSizlKG0a066rCukcTBlKzQuq6/3uBqI63NxfJpxcCJolVOpwBqqq?=
 =?us-ascii?Q?BjBbD+I3tNplqiNYUZ6/0WjU+gy3JpthLilwY5UScv+lUyL9QF/c1geb5LMj?=
 =?us-ascii?Q?WhaUVbK/4WIQwbRDdxO1EL0cvRN2BoRt9jwjRu3OL6h1zUceHQM5iVmKzJ/V?=
 =?us-ascii?Q?cZs+P+E+lsV906p0NGI4UHagSMWx0ZSaIvz/WUFJq40GLfF4zv3mYIR+Vf0W?=
 =?us-ascii?Q?q9uoYdtJzKn1ldThMLUAwVGcIXJDudZbVkzoAVfOAuXqj8iyzY9r0Ds0u25Q?=
 =?us-ascii?Q?mt48TMEKaHIJmeHoxXxvMxpNCqhtgw0ys6IKiMdCtuFJvxFxQO/K9tA+g9wj?=
 =?us-ascii?Q?/qd5tQMu3pXfr4lSIEBPUdsgzOMdxLory0N0j9YbGoMy87xyGqGKLPx9M+z4?=
 =?us-ascii?Q?Xb7PlHzSc3OcEEM0dZeAi6XKDznp2ntCFaIa4uw1nj9SSnDe8vM+Fxy/clAI?=
 =?us-ascii?Q?LBKSJ0HXzLjvJ52tAxKpVWSEU+GQWVJ33UhpnL94wbGNvw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RHkaAHpyNH2XKEwo/6KBR5SPyUB3TmbyNcnVfC1Ytonnrq+RM+Uoxf/eswdA?=
 =?us-ascii?Q?7zyhHDeu5CST9CyJ2+xLT2Y+b5YpUcoC41D8dPvjlq5CoSZIdNKXlByi0vJ8?=
 =?us-ascii?Q?+qm73oy/cc91sq58w1aL8Ox6oDyP+6wl1o834d4tDhJWcEFWcbqjKdocF1qs?=
 =?us-ascii?Q?ciTUtEYwFuujc1l/gQfxmuVR3tcky5MEV0JNP5OR1mhbxtw7HtHGBnMjr+0f?=
 =?us-ascii?Q?N49oSUHqrRJGWCDA/MO2i6cUYKU7ZhtTNJvm+yoXULIPI40DAnDYsvyi9DHE?=
 =?us-ascii?Q?MMM2av0Flsdh0e4ksOTqMNSoELA8jmnz3TkF6uoweHWCVnoPS5oxYWT6A8G6?=
 =?us-ascii?Q?j50vojihJwBe08zuq1aXTdYM3SBUs+g9PwaQ9GgGYP2WUgsAVVJ54MmWWNaY?=
 =?us-ascii?Q?cfNbvFQlmY/kN4I+ZtDjbl6GuWXa4mu+EIfWGZ2lLL8nuhPM9s5IHIEam37n?=
 =?us-ascii?Q?QsOERbOHBtYk30POyfnxOm4trQWRTb6UhzkLAMmoGHQVi0ezQOTkcXbdB6fQ?=
 =?us-ascii?Q?K5kA4QwxsWgdYf8P1uH6G8nlQys13spm7UvmZDGX+RCw0KS7j9Z1r8R8ckJv?=
 =?us-ascii?Q?YpATO/kiy2yXhaID9Uh66B4djSMvJM5u1HjO7nDShQH/bfNZ30Hadv03GmNy?=
 =?us-ascii?Q?g45qpk0NEIg1zPha1JxeibJUsbdAnaqS71f7nl0/oae+MQQ/+ZkTIs6+KWNX?=
 =?us-ascii?Q?T9ckV9mOK/ym04bOxRF358Ac9+T/C3Km8IPgAD0z2KgqMVj1e3pRB3M8/ZFW?=
 =?us-ascii?Q?/Opeq4FNqp3ovKRUMXuAVinOHrKjR418MTD0gZejh9656DeMDxr+99j8o3qz?=
 =?us-ascii?Q?1CWR+7bTqoVjAmt5sM/SsyDGS81s2gt2zVXx/8kh3mbofeKbZ800Xm03B5cl?=
 =?us-ascii?Q?8wmosahGJeAIOXT60tmnuQzKYbOYKs/7LsZEBYEjBeZAcqPnfFIh88ppK8Ke?=
 =?us-ascii?Q?W4lqTClgoPgIlDmjlMOEnNACJeT0hSlIGI8JWR3t/JTYDpSoq7agYtdMOC67?=
 =?us-ascii?Q?NxaQQnH6L+R8IAOgV+RRRlaWeeMgSm8Ymo+xnU7+X/OLnl7aInXY1V0KoeZF?=
 =?us-ascii?Q?WUE7F8hzKTPddyX/rsCAexY8/rQTMClYjBKhNQWbyJdcn2Qh+EC1yWnTrGko?=
 =?us-ascii?Q?ztXW9eYBOrE9QtkRMg/DnZitZSBabxVBOgaY82YZXvhWesD6rudA464wtY3Y?=
 =?us-ascii?Q?vpuYhMQB3I9Ovs430XryiHwwPuM3oLZYyMSiCTBcjgCQLcQzYP5+aWstJWZN?=
 =?us-ascii?Q?RygsZbSFo8TX85c/WdDFix5O6qIJiyXhCZCSp3a3bmVEEygrqXJlFKbvrhZG?=
 =?us-ascii?Q?w469M4Bh7ziYOj8DUJYe+wznLm4BiAp1GrUprii2TsJjDKdSSY0uLMomI8UA?=
 =?us-ascii?Q?XH56TeYRLrW0z+5DrNrC7TlnNEU7hI0FPZ5PxcAnWm6nXFeUOnwPqfqgtHpk?=
 =?us-ascii?Q?ALJYzljIId7GpowliIWu6p6CZJ5u4RSbhww8ABZXugpgjfrRLaNQPLLOaaez?=
 =?us-ascii?Q?qmlKENK6lwwR1hI2dcmHUtxpgvXvmHtU1fRzqz6FG+5qiiBZz+Y8bBmpjSZ2?=
 =?us-ascii?Q?82KJhAF4z4EhrhqX41X2uaLdMDj5GtAiA4vsMX5EfmQCqsXUVLowi3FFGnjJ?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pShGckQX04/NBsn0kARmkX1nQsE5Lh9hMeNuUuVdpANvQZAGN7/RN6MbEjpx8WFCaXTmzIxSJJcdc4tFHgMQYkbPmEMzyHRxMDsi5qnrczuc3LbfntW4TDfPw8z/EiJ8Z2JanDnmWsQVB5NIv9cXZH5lM/zbvb1SK39GSeFdG/RoT21Bm0Y5iKUfYJIU7IM3ipfOhj9xkPXCHeupovsvCsB0hqSglNli6icRgE9pUYUy50bWt+Y/NoxTisQsz4dHJLC+wXmYKbyoCOgu/p5bo1wsK6gBiZilD0p+V0KxbAFK2LW0l1BuTv/mp389r+j21B8cUsRwrQzLiYBhGwMhE4+KmGBybPYHPSZ/Z/jExoVLAAUg0z9HVt5XtM6iqLLw1pQYnK6mIdbqotLmUxQLSDdkvUGauGCVYtiYcauljWD4Y5dF2thO4ZWfDAuHjTvx6qB9TZmP4j5L7IZQBHo+aOYG/wuFHNNiQO5avEK12JvrrCyB6kjYOXIcRa1ETZyzX/gwJsdC+jmFbNF7K23NvLBXpTa/bKdDaAsKK39Ke0TZroybIIstTSOqBQqsupq/1r10Px3s5jiOOe/1RQoPma59k8b5l1zIBUwzOGlfGxM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a3de96-a0f2-4e4f-12ef-08dc9b57610d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:57:57.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vJZa3xwMrTn6w3nADsg6FUESyC6Z0/4KebzIkfR1sHbGG6g3EKa0HbeZ65Vj2UuYP/ciskILOjvdHN0wz5aQbqeZzePncjXBUhSAXizZpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_07,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030087
X-Proofpoint-GUID: vl632y-O6NRTEeUT8MezFWmNChGiz6qE
X-Proofpoint-ORIG-GUID: vl632y-O6NRTEeUT8MezFWmNChGiz6qE

These are core VMA manipulation functions which invoke VMA splitting and
merging and should not be directly accessed from outside of mm/.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 60 ---------------------------------------------
 mm/internal.h      | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5f1075d19600..4d2b5538925b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3285,66 +3285,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name);
-
-/* We are about to modify the VMA's flags. */
-static inline struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
-		  struct vm_area_struct *prev,
-		  struct vm_area_struct *vma,
-		  unsigned long start, unsigned long end,
-		  unsigned long new_flags)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx,
-			  anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or anon_name. */
-static inline struct vm_area_struct
-*vma_modify_flags_name(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start,
-		       unsigned long end,
-		       unsigned long new_flags,
-		       struct anon_vma_name *new_name)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
-}
-
-/* We are about to modify the VMA's memory policy. */
-static inline struct vm_area_struct
-*vma_modify_policy(struct vma_iterator *vmi,
-		   struct vm_area_struct *prev,
-		   struct vm_area_struct *vma,
-		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
-{
-	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
-			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or uffd context. */
-static inline struct vm_area_struct
-*vma_modify_flags_uffd(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end,
-		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), new_ctx, anon_vma_name(vma));
-}

 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..81564ce0f9e2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1244,6 +1244,67 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta);

+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name);
+
+/* We are about to modify the VMA's flags. */
+static inline struct vm_area_struct
+*vma_modify_flags(struct vma_iterator *vmi,
+		  struct vm_area_struct *prev,
+		  struct vm_area_struct *vma,
+		  unsigned long start, unsigned long end,
+		  unsigned long new_flags)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx,
+			  anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or anon_name. */
+static inline struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
+}
+
+/* We are about to modify the VMA's memory policy. */
+static inline struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
+			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or uffd context. */
+static inline struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), new_ctx, anon_vma_name(vma));
+}
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
--
2.45.2

