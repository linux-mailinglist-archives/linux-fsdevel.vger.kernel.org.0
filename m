Return-Path: <linux-fsdevel+bounces-76417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAr3N8SJhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:15:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AE2F2487
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 071B7301C159
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A92366DD3;
	Thu,  5 Feb 2026 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l0IQuSvb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kf5mYo67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26E78F4A;
	Thu,  5 Feb 2026 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293502; cv=fail; b=UNgMGtmbK3P2TNVURkBkG1iyzjh1NSpTsYYvOkwBCxpw7FEcjVaCbpa5C6AyChQ73ORa7CGzHsctGNzO1zwCZ73XJuGIzpVmcyVGz6c5Giztncn97aRLauX3H1udU7XW4CBUaL29UP23VeeuEnYB3hA1TRM7J4y7ZqRZlORk8KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293502; c=relaxed/simple;
	bh=b0j3CChRAKHq0AhP0WSFL3fZTlNem106h6gz7nHJYCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=erIUvUb89r3IFGTsiKyRuIiHQhOWqVRQlSp2qQ81bxNNTisK/dz4+f9NfSWKb5YT9p7A9hUGVmRWuKg2lGtRnGXWGLos9UW4o+yJxBQCDyQ4b5rAtpq7tSP4kwTuvpI5vGfRN40/rS9yOUgmqOAGDn65/nEpimirdPhKTBJG4ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l0IQuSvb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kf5mYo67; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614KfDgH3032801;
	Thu, 5 Feb 2026 12:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HSyyQmo7Dc+72qCBP+
	PM6DefsdKwc1xBpqv+s0TIc8w=; b=l0IQuSvb02SO1ekb6xaC/5aD/Klmlp5WEd
	PRKOapOhfbIhG1Br2moad3w3TmYAVJ5iogEBHJRlsVBfZoMuNTjrvMyXupr1D/en
	IUL+IAz3e0kfumA3TgqK3A7ev2sjZ9FmkbJkJVWxCntEKVJ6bFkH8HxwdLkLXfqb
	58yVG1qWKxUsILjkLOLtUCfhe7tBCARmy8zqoqByXzKwnaK7Rcgnw0SE1tSx/0Aj
	YZtjo5IfCPovqH4gcnTs7dqXChOiiTcahcphu99guIUuR+hBoGttFk5P8iKpg9PI
	nB8/ZLilY0wRBJ3gZ6HYxHql/Vnrrxz6bnHR/8GySoReDXNKiZZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c4dc3rw58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 12:10:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615AVOE5025774;
	Thu, 5 Feb 2026 12:10:44 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c257bq06t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 12:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QE1Km89BAJs/1a4uoM1xVJ4WJTw6i/vmKRQ9nMV6sRGfZ4B6GWE41n3YKD+KDAex+Tthtpfxm1Mya2cIUDXUKl8xBngpGC7PAqwqztjFnFE/o46dtwrUHRkMub8rQsYvoRo0V3dm6ULXpKsYoFSsxBdQg0ccTrgYXvRnWSHIdQVbnKamBtjVM0mzgB6XhbQtZt9h71uD23lR23uEmU6X1EwKVFNw9vRM/+DI5vk6TmddeBrvYttBOB28+S67A6aWQ0sLGEQj+czjZfkZNgfqPj/WL05eLXkqZcKFkUtfrm2Jc2MfwrPkrHHffMAG7mgznOp5og6zEc/+zOMgC58ESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSyyQmo7Dc+72qCBP+PM6DefsdKwc1xBpqv+s0TIc8w=;
 b=CGEv7U+Tlxr0qVHu5GotrR1nxJGnSZsXNh1O3SCiMNzKRcMaP3S7ea2Ckdz2+Mc72cAqnqlYWIJRtCIMX54JAPzBSqyJA4U+kIfJ8sxXcZN4PqWbAZtP5rAWOUSGA0ENAM6Azn3GVqk3matpctRp9sxqNoTq1u6itpUOckBjb6saSR5bF06DbOqJHFjeCmi81YICtHyEIfMauxNX1kvwOcNIMvz2cy3fXZb+t3bHHDvf8U2oWDn+7p6vUWUMWfnDatvAW4DmSxVrR3jwXO3TD59T2G79HST9FXOuiTjepbH7nkZ7i5skXx/xca1rM9iyPg+Kq1g/u+LKqGTh7WvXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSyyQmo7Dc+72qCBP+PM6DefsdKwc1xBpqv+s0TIc8w=;
 b=Kf5mYo67nBAUnyW9SPz5b/4Y7xCDwWkCy0p5OP/dN9vu4bYfC5C7HMQqn3hHt3NxznctHXyWZdbXhL0GFeAVBo4DAdCHQLCUGjqaJCBZy0yjISjmMGiSqADeGcRz1oX55/5E/qwrE6YkRHXsMZQ/KD67Us2X94gTDvx1rku7ssM=
Received: from DS0PR10MB8223.namprd10.prod.outlook.com (2603:10b6:8:1ce::20)
 by IA1PR10MB6219.namprd10.prod.outlook.com (2603:10b6:208:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 12:10:40 +0000
Received: from DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9]) by DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9%5]) with mapi id 15.20.9520.006; Thu, 5 Feb 2026
 12:10:38 +0000
Date: Thu, 5 Feb 2026 12:10:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: "David Hildenbrand (arm)" <david@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        kernel-team@android.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
Message-ID: <e7247f3e-8a88-4b46-91ba-cb73cce1346a@lucifer.local>
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com>
 <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
 <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org>
 <aYSFyH-1kkW92M2N@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYSFyH-1kkW92M2N@google.com>
X-ClientProxiedBy: LO4P302CA0026.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::18) To DS0PR10MB8223.namprd10.prod.outlook.com
 (2603:10b6:8:1ce::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB8223:EE_|IA1PR10MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f695f1-2025-42ab-e67a-08de64af92fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jdet/Y+EcxQCOQXpkJmaelzAsIR/LlRw9JJrmRgWCPdjguQv5Yx07KAcGPMD?=
 =?us-ascii?Q?G4WzG+7NEztiyMvaMTh5UeeJQSjAu34Pjoy+Mh61ZnBCV+/vgxYTWvAw2Azb?=
 =?us-ascii?Q?j45n3PvHaPwlMPpqN4XWllwgg+miWYbzj8/x6H/gZv3qBRX0AEZKb7LoeHuS?=
 =?us-ascii?Q?bXuUexgA6ZXUG6XV+Q1p0vYQDneHqa+uN7QdjfZ1jYlWT0m72pAxQRcoS3MI?=
 =?us-ascii?Q?Y70k8yGtJdRjKFMKakGoyHvUK5V/vBB7ugk7ZHw6+dCrWT8C31/bvToA3DWu?=
 =?us-ascii?Q?xoAxP83FIudDa12UAfX1ukCu0LKz8O6gURSDn6lHleUsUtNw/DZ+duyor5uU?=
 =?us-ascii?Q?A0YWJUxxi5f32Dw3rV8Iv6hnqBGEgPxdvMdMIGY+G72g9oF5QU9PAokfAGNm?=
 =?us-ascii?Q?nkhu9SbXOiCCstTc4s7ww8AJFwJrPfznMO4jV+kYZCMQMkdKoC7CcU7xKlA4?=
 =?us-ascii?Q?x4hYqedy8MrDHGObl9y3o++ogOx+0ZzCz2smFX5Jnbmo4vqieYKdcWvVhdsg?=
 =?us-ascii?Q?MEB9BfAgKOliScDSru6WMAvFS7A5m91pBZS8Mo3wvlAPY2bebyG0TnZ4SP6Z?=
 =?us-ascii?Q?VmodShd50jjANn5LU1IbQA75d2E8maccVP5pPt9njuxGMd7c6GVCz+o8n9rG?=
 =?us-ascii?Q?iHJbx4p1vs+HXWPsuMkn/ZrTWz2v/R+KwcmDoIIjKmnAAjIpCSz9zytzmVsq?=
 =?us-ascii?Q?eI/Ti5X9BN5NMhFP6MyursI8FqO8EchzZPWHBgy5NE3rub9OvvS3wCy/Ho3k?=
 =?us-ascii?Q?PQMmXeWT8UwGVmhFAfb1amUzrZghCN1PH1uBTm9CwckOR6DeUTvIGuH5dn4k?=
 =?us-ascii?Q?xsHe7G6CcLx/Lpyxo2e2uiwVyHoL3u/l4eRi2/UePOVwy4SGedy/p9MTX8qS?=
 =?us-ascii?Q?gqJ51TumW6Ux8bbjcF03ft45wNd9m156DEF43maLS7A6N67nHcFl3TL3xQ/o?=
 =?us-ascii?Q?r2bcNYB9lUCG0s3rwVALOM4N1fr7+eOCu9luysIvOxNe28Re4O/8nqQ6aNoQ?=
 =?us-ascii?Q?QPl9GwpySfFB8YblKK6g/sLUqKxy0GcleIX30eHYc2ENIrUlyCeP3Sg0ezL8?=
 =?us-ascii?Q?oCyXD4TGQLC07DDavIgF7PtjqgKDrg8mpiSYSmgZwKvzXQQtKMILzowBE7jV?=
 =?us-ascii?Q?Rw9FavP+V+YAI2ZFnFZ+mYiW0wcJP3Hg280LcCDsBEO0FspvfA/ctaU/oUZX?=
 =?us-ascii?Q?ZZFrK5eMF/r8L8elYJmKL/QUS097xZ2lqs0EW++N7T3nAP9X6rhR9Yq8kx/k?=
 =?us-ascii?Q?7LANfVnopSFT38dajFQddjt6V8F/CPj4AfDws4TKhg1fiWvFgdGk1bl2BK37?=
 =?us-ascii?Q?7x5YN9NbgILtT/cdZytjgKCV4LRh0/dx7elYCgGg2VNN3IzxNgC+GKYPZCu2?=
 =?us-ascii?Q?uNwQiMhggCZcrY9UGjErTuiR69//9bHM3WMCKmPXmf+XVUJyznNKnLNs9dyd?=
 =?us-ascii?Q?1tbgxdqqlfrZlj2Yh0/hhuRE9Ll91wSKhQAGMBeX/YjXyt9pHlzeTcWCLk/8?=
 =?us-ascii?Q?hwPHm54L5Y1Q04OaSqjBkw889XgUCKX4y02zbCE7UowImH6WpYmWVqf75AI7?=
 =?us-ascii?Q?YVv1/i70Op26lq1Qv7A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB8223.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CrLvNQJKmlorLgH12y6/vsBL+I+nPIU7bdmAQLaIUPwchte+sZGi71IPAvW/?=
 =?us-ascii?Q?9MRv/K19W2qU6SwWicV5pdOeGwjnEh3LXWnUM1mlFtZqu6VaGxI3zI5Vn9M1?=
 =?us-ascii?Q?zhNlPOebV3bfK1zvlMdfkMV1PEKiTIPuTPaBb2VKsT1FACmtK5FVE8IhlHZm?=
 =?us-ascii?Q?n4s4ZTpzjzEAxLFxI40TnS2377cD9gmcMvPBvCHaTWsmogDarG1A8hl9KCe+?=
 =?us-ascii?Q?VKYkhfTWSkQRPBHVdH8MJHNnyqPV//jhO7/64mfeR+/GIeLt87VW5l5ihVg5?=
 =?us-ascii?Q?FHa8fj9II7Ll+gaoiZbjms4RTIaKfCvF9mGOglmiko2cuAB+lKj4LPoKfQQr?=
 =?us-ascii?Q?nGfpeJbwuFvGhDeAodtTP8Us60oqtsdd9Qgp4GBcQvgvUJ3JWPV0giYvzoov?=
 =?us-ascii?Q?KidzTnmKxU0xIuE11Sd9Ar9QPXcKjqGg3jBLBvP8EZe++E1lQ3nwGusiC8RQ?=
 =?us-ascii?Q?ZKnlbqXvJ2KPIE2bczft+RMrkJkV61RHFjciX0mYzfeg4E0M3xLkdxoQ7j1R?=
 =?us-ascii?Q?0svFpZmwG2GtTMHvJu4oXnwXjsfgkf+kNHOr0tmeMZrAZgxL7fmAxVaNj+BI?=
 =?us-ascii?Q?d7WevWP9nlsPdti6CqCBBLg+bNhfYo8f+54fVBcNVtOVIkySsr3CS/L9DQxi?=
 =?us-ascii?Q?C0p9qRBGjnpI/ad1aY/OmQBUGYZuiKttYz7UjFad3DqHNiSqHBF8lIo77Hau?=
 =?us-ascii?Q?SBgqKKLlPrjgHnc16pbg1NRxMAr3oDo9yrOMYcM8LEPtiCJH1iFzfsytk3Zj?=
 =?us-ascii?Q?9qnIdPnl8YfNOxtX/Ae2if70biXC/oWgEoeKY2uJFqoIkxqjdgL9eMleULEi?=
 =?us-ascii?Q?obarKWfI9ak1UOQ0hU771H2hmwBPGYm2GR9T065PIB5mPkGTmFQdq2ZJ/des?=
 =?us-ascii?Q?O0eGwJx8cDIm9XY5WKCFuRDmu97aH7NJP6mw8rUELFTdDsfmWYO6h+Kgqx6R?=
 =?us-ascii?Q?gQOcbSNJ85osxMb8j1LRLPLK+6LQ4Ya6auS8z1uD7gpzpbJBcYV6eNXe+WWk?=
 =?us-ascii?Q?mD8oBe/qRU3j5KfHQ3ShG44qO4CiePOGVHFi3WBsYEYTqfZuf9IguXFGQyIh?=
 =?us-ascii?Q?0ON39GIEoDRhiLfyzXJH2NG/84og8TO7g/+gRtdMx5vlDtAkly+yKO3CNKVm?=
 =?us-ascii?Q?1fa/c8YsXLks5rGJutw+S0KDxXcG3VwQn5WS3qAWF5rX8LVVIoa36QAOGnHN?=
 =?us-ascii?Q?VYfOWDqvgr0mLe9v9SG6G1BBM53YDvmRrksRzJASp6pOJP7zSjLMGdnooE4p?=
 =?us-ascii?Q?oIG57SUyyMXsRQ8t99CyT0aTrsni358y+DC38rRcAgTXB97ZKdmpeZBHM1dD?=
 =?us-ascii?Q?LuKDE8rb5qX82fa3KygS8fp/o1x6SJR01roRclL/Y7pHGZUx/lcv2kMdKwLv?=
 =?us-ascii?Q?xhFlHTwzwAyZ7JhkfGZQxVAqsmssMiBer0ezVCcYJKrXUaIuTcOPoWcLrXai?=
 =?us-ascii?Q?TZ81Tcio9MRK97H52M4d9aQ1JakmUhBC/B1vURgPd+7Ouc7cElW+tOf8gENV?=
 =?us-ascii?Q?vNHvmaE4WH09l5a4ce4tdrYRh+MIzz2XZmZRfpqOZifZRYHVoj4WSyEcOmEJ?=
 =?us-ascii?Q?gk6pvjymxcyVZ7RW6p8AVDNmMUnVsSOHHWOVbcJTAngjpslO394+g7nRCQ0M?=
 =?us-ascii?Q?f+6wvTDjeXHl3pv5TP/FN1fGTHn3JWOVvAOlB8tRDtBg4jT0IlFSPwGtEIpE?=
 =?us-ascii?Q?Gqxf6YDu9ETZW+HGsEe09tF+4yOWUwdkAunGlYWFq+GNRgBa/iVfQwwnOEW9?=
 =?us-ascii?Q?gVFD0aP9SdYT6JdiPVqM8191poRTaGI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I+Nd0UrijIC8Tbi9xAjtrco9O3GYrpxbmfo+RzRi6BVxl9InFGF7jdIEQHk3SNO5IBFfYXg0DXUNTlGm+E6GZmBTrigMRhw+o+xGWEmZSm5Ycozd84EyioQuHCdUBmyd/eFfE7pJK04WwmU2NFqGZ3eZWmAgYjGwgwXCWHa0hJ7+2+XzHsO5PVENwXDpBcVXeXNV+P9rCxIdBcuP4ItKuIpMEK18/2jkX+TSUlGIKegBoYcdOGG7FdaL7FT8198kjtpfiY5Cg75eoR07GiRWYycj8Ciw6XKQa2CMrlfgdtitvIFPZkpS5DlvYdridjvz74W5jWZ1j1DC2ZsXi1DyC8/3/l+IRXDH2sNQW2BQWDiAxotLdatDqyhnd6I04Lhfq80ncoJKwc0Q4Gv4QAC0gPfw0/0uU83h5sxPP4NcwIci30xbINr2EIAlbbqlokSwouHaJyzmrKbj7u55mYBJSSpxtzcDl0ckseJ+qh1N2r+0Z/qRcEzE0nVSn4KxrNQ4qDpzk+YpCgjMzwjJ1X+FWxGfClU7JDuXA3sB1DYwBcwMfHoxOuX0XzOEf7QDllQo9z63u2kNhfPnGaQ77F75QO+bxHnQkxbGB23R0vhRkqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f695f1-2025-42ab-e67a-08de64af92fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB8223.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:10:38.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyJ7IydR/V7knNqtuHvnqwhi0vyFtr+O4T84YcKp7lvz+4RKAZh0RQPzdkH79mYg/+nIvNiV1Lx7IgP1CLiDYmdUUv/VyuzVDpFaPjtX+64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=884 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602050089
X-Authority-Analysis: v=2.4 cv=SMtPlevH c=1 sm=1 tr=0 ts=698488c4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xhZCieq16BM-jj2j7VsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: CLIe21AezCiiML15V65xBmupJoWbAehT
X-Proofpoint-GUID: CLIe21AezCiiML15V65xBmupJoWbAehT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MCBTYWx0ZWRfX64/U3R+UH7iY
 s5jSkcC/cTjIU75crGN6lpavLElagcAUjV9Qw20RewdkPMP5jXmgHD7RE37EZ1jA7ORnV6bKYAc
 1+XwtsYqLKvYO68hbOVZw6cw3E77KqcVEVSHccGJW3JUOOPfM4Q/e0sWLVlqe10k9JnDmqRZWv+
 IOPood76ctjUgPh4m9wyT1xqyDzMp/cR49vGvP9xHdC3+Zx/dx6qdYSeww1nmYoY1YU22Gj9fm4
 3nx8vU5l67DnJIAkoCjncXdzcvEFjPW35BaZpEjaMjTGAzfAYjIKOli1Wp2xrjKoNozSeR0JqMT
 /vfoB2/H/Ruufhk1gpJYvYfwJU43I22LngxXUvSey8oaKkaXpGNpSdOp7bMZZ0kqeptFTadKQ2m
 t4NiLhIavi6BoNSyUtCeyXkbL/6dSPDhghGAG9/JgYITfNbhfFCRLt0nQ48s5IXHr56piEJB1eB
 QpMRMUHs74tAZoNWLMUTYxPjuhLJH62InBjPLxhU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-76417-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,google.com,zeniv.linux.org.uk,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer.local:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 55AE2F2487
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:58:00AM +0000, Alice Ryhl wrote:
> On Thu, Feb 05, 2026 at 12:43:03PM +0100, David Hildenbrand (arm) wrote:
> > On 2/5/26 12:29, Lorenzo Stoakes wrote:
> > > On Thu, Feb 05, 2026 at 10:51:28AM +0000, Alice Ryhl wrote:
> > > >   bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
> > > >   {
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index da360a6eb8a48e29293430d0c577fb4b6ec58099..64083ace239a2caf58e1645dd5d91a41d61492c4 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -2168,6 +2168,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> > > >   	zap_page_range_single_batched(&tlb, vma, address, size, details);
> > > >   	tlb_finish_mmu(&tlb);
> > > >   }
> > > > +EXPORT_SYMBOL(zap_page_range_single);
> > >
> > > Sorry but I don't want this exported at all.
> > >
> > > This is an internal implementation detail which allows fine-grained control of
> > > behaviour via struct zap_details (which binder doesn't use, of course :)
> >
> > I don't expect anybody to set zap_details, but yeah, it could be abused.
> > It could be abused right now from anywhere else in the kernel
> > where we don't build as a module :)
> >
> > Apparently we export a similar function in rust where we just removed the last parameter.
>
> To clarify, said Rust function gets inlined into Rust Binder, so Rust
> Binder calls the zap_page_range_single() symbol directly.

Presumably only for things compiled into the kernel right?

