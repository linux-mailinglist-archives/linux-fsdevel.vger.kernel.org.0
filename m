Return-Path: <linux-fsdevel+bounces-60522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A017DB48EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710B07B1E19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8B9309F1E;
	Mon,  8 Sep 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aVWI7bsU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OuP1uHjV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DCA2FE049;
	Mon,  8 Sep 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337172; cv=fail; b=GTMgEj2YxWdy7VcP7DKQmYMeP88s5pVPDSP8DlVwAK1JBVRGjvzCnN7ZXSJt7U5kuGP60h/XWc4zeQaKn5kAG0WU56ZYxbe6LioYbgr2GKDDk9HLKafmARPRZXX3zQHrKhEiH1BBYAmbZVw5qfiP5NA1ZJIpVY0QUxvIIky95J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337172; c=relaxed/simple;
	bh=dr9nnwgg69kUdc8MwVha3qVqI2Sx6dv6CUiHWf2camo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O1rietUzDrGqTk5gcNl+iMumBqF0VsR9yOGrBgZe+hMbgeYtn+BqfIvqGs9DCfWT4MAZKH1n/i7azQO/0iDb0UWOshxbbY6h4fD2X4U6dK5GPdsYTNQArr0ox4jKLarotkryi4Edm1gVIOVk8ty+CG0WZIaBy4ULeCabZylpzao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aVWI7bsU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OuP1uHjV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588D0laT005678;
	Mon, 8 Sep 2025 13:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YU+Tu05/qHr4538krB
	A/Kl4wclo2Q1y0o2qsoqpFs78=; b=aVWI7bsU92q5HoaotGSTNKi3yo5F/aaZ/R
	TzLpCHmF/569Tm1OKDdU97NdxL6SCceWKUzbvNBlFxZTtX8xcDqdc9xHHJBn2+Xk
	VbJUCmbdw+PICIw+3mkyhjepBWd5WVCVDGHZCCVEVN+oZb4YcDpUscycrxdqMAZr
	TP7zxP9HeWc2611A+CmFd7wqJzm8eVDZbMg1DrrT+bwl1yYmPpZ6Rgp5A4U/freH
	SuXCiucyohIZy9fX4YVeRk+ll8Y0+7ObZapZeA2pHpSOvfDBkIguoZsmUCBHKYy8
	snX7C2On58A1IRWyDJ/Sru+4Sd7aGIzhsQ+baZm366G6k/0wT9Dw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491y4br3bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 13:12:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588C2iI3030831;
	Mon, 8 Sep 2025 13:12:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd85ny1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 13:12:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j23QdWw3/auCbAxNg4zz82h1Gdi3HEmOStSTbMaZh+nglKe73Dg0S93haclLnaMn3Vt87v27unkQq4pJDSdiNATczb5PpARqGQdtIUhceJEw0E/L9X2oVyMQfhAswfk0WDg/HYRC9pJeWUqkkPjcwf+qhlnlhOS8M9rw5/9E7VL5YaiPHY5GNDzH+tOd+gDW+oKyTsbcD/sMoo6Alyv1rN/JSkZaqjxK6gtzLkq9p5F2X92iG6UV5bwlnttZWrExjMW9OtUKfqzZWCOVS5tnPFpJOwnUjxsXPiu4S13UhRnvwqLYzARVD3EBZj3Xso0vF8ImQP3fWLGmFfAXG4wfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU+Tu05/qHr4538krBA/Kl4wclo2Q1y0o2qsoqpFs78=;
 b=Wh1/zn2Y3h9bOv0XEOEv2da8agtenqDqIPDZSM21u6oR3rh9U/wbsI5L9e3y3pQDEDSXNYMX6nTo7JGGumyRN8VqvN/aOzIR9TXw29Zuj0fbLc8MKphLbTyA/2embO4Vz9I1R54wfmJQc4/5oq+ZacSabTL13/zjpjPn1mELv1tDnt/xtSKp9bbAwWnVWyFK020SZIi8Ud6xFxOrUR1lcRZa7fiuoNLrluDeG+2o2J8tykM1CeARuivGGC6WUlp4EVeYJpZ1vpupM1UMmWyFl1Ak4+D9kreW9WizTF8dR/In+2hWCPrILjHn8l9fcvBY/31f+PBaY0v1cN/2+L+11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU+Tu05/qHr4538krBA/Kl4wclo2Q1y0o2qsoqpFs78=;
 b=OuP1uHjVueGLr8BIOgwvCPf5/+7RqHR4MadCJ43NvuhcVUb2guf5vJdioLP0B4XwOeXp3UvdRij5g8UoHTAUtwTiIOsKUdK2edoPTiUh+7YYI0yWtbEFI48B3k3drkWoUZeNA5hO/ryoOIPM18gZQKVkkqYMZj2w5KzlDVoKdDs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6345.namprd10.prod.outlook.com (2603:10b6:303:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 13:12:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 13:12:02 +0000
Date: Mon, 8 Sep 2025 14:12:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
Message-ID: <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908125101.GX616306@nvidia.com>
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e72f36-0b5f-4875-7832-08ddeed94d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7dhe8hPlnAlCFZ30RY41AzG1QJuu0FZelXFaI3lTEl1GOmwHUXcBbT4DkkEq?=
 =?us-ascii?Q?uN6m7KLJ5z0B4v/Vix+wzdnm5hxhx1sV8uqszE1bzei4gmqJQbYWzlpzD7EV?=
 =?us-ascii?Q?8H5ppPXfNy8KBwYInQEHW5oQqgNIlhcfiFilG0Q9yBTqisxak16rwJn42+oK?=
 =?us-ascii?Q?cPZFw3KDSVovmPkY0JYOQL/ivmiAt+FloIN3tR2x50N2Z95g0ce+Fq8l/17A?=
 =?us-ascii?Q?pjlS9Hzn9Dg1ffESw5aOHbgJbF+0t1CRiw9VJ2yCH1mupcSCUuK8pjU4FbWC?=
 =?us-ascii?Q?IEYtjfMhDsJWNrOsM+tI1vf5Di4drFzF+J5k0GWx0y3Jqma++G/gcQPtr999?=
 =?us-ascii?Q?9NEprZjuy++R+JTUAcvfXtl1G9Yd1yDYa6hU5451mChPUf+EqHCdnB5H8ebA?=
 =?us-ascii?Q?w+8K03By9mZUuBUx/Tix5rAnXp2TMgsA2lst0deR+KWVqEP7RHjYZdEx2+Kh?=
 =?us-ascii?Q?zM5Xo5zi8aa0/6mAbvxoj++EUJEIbLH0bdCgsiXsOHWXi8llWEs8BQRj1Psu?=
 =?us-ascii?Q?m4sCrQscVj27juRqdff+ww1hPyfgsADDAlcuofSIVDYAWdY92ThiKucnGB7y?=
 =?us-ascii?Q?3yFNKT3kyi6oov1JCr6Fh9E/dt9ekIlN1EgVPM+OdwDCMOa702sb/Oq9+psm?=
 =?us-ascii?Q?pyw9hVBTNKvQIhxwF4INf5QBOrcmtClbBwcPaZIZyJdxsDiQ3B7p+pXNjM6z?=
 =?us-ascii?Q?5x/11DeBrBtGxmvVH1+K3gDSUzcTnE46cxrXul5vP7AL6JzHapj5IHQ8k+N7?=
 =?us-ascii?Q?/HBMhs9LyAR07dvA5kWXk4tuYuhUbGnojokE9VbpvmesZ0WwVBMvs2v0sqe9?=
 =?us-ascii?Q?S4Jtm4hBmCu49GnWX9B5H3A5b6E1ESDcS2FQ//XMroGNRW1NoIj3Pif5oDfb?=
 =?us-ascii?Q?F4If39vlwO1Flyjp0e9NNnlASDhyMyEop3fCzIL4UXjpLda0y6VXeGGkJN45?=
 =?us-ascii?Q?ZLmWpRAJJE9YJZTW12apzzK+ezGBzWvNAjPeXW7EDW3kUZon1SBXq3L5umct?=
 =?us-ascii?Q?50PuUONy4ydPLBh0iE/hBTZOHYI3x/LEVwLJpVP5WWKyknJkBDdPmFVesH7F?=
 =?us-ascii?Q?Ct0JQIUVlG5N+hG+bGlkghzvJX//tQhzv4KdeovL83U4eAWMq80jTewKcLZb?=
 =?us-ascii?Q?n8YCIr/2bktX73/QeHxDPjCbgqwt3kyBVBycVoBFOm7ulKLLFAEbcCSzj1/m?=
 =?us-ascii?Q?806MmV7WVHywTtQ8e1eyjvqImukGic8qXeZzn+V2iWvHcLHgwktcGZsj642p?=
 =?us-ascii?Q?97e/kgzag1avxKgveOGZUDASrDHHTt+gplyfUkgM6bTEN/G/LqhBYL8JZTok?=
 =?us-ascii?Q?JN10UuD0asO+XxzU4ZFuPpV21/JgXzVbhXI14oHD7Hn+yVtSmulohgCuMfrN?=
 =?us-ascii?Q?61ZzbXMor7PdpxVr9AFqNceUEvxiI7rXsUFeVEQ3G4sQ2r+Yf2lN2bXhJGVs?=
 =?us-ascii?Q?adM/krvWTzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XsqS0KiTGrnpPlEcU+MO4h+qO17FcJvQViuXWHRz5o1xDzFTmi2ZJVI+KYE+?=
 =?us-ascii?Q?xKoRlglJj7cxCwB2Yw2k3Lb+kRNrb0UIIcl4RdkGz3BhK/rnQZDVTLqNgblE?=
 =?us-ascii?Q?3tYWCPMCm73Lc+QYbkndhtLtm9O3gaKS2tkqvsgtXo6Csak9NVagcijDocGk?=
 =?us-ascii?Q?EkiYB/kHS+TC1bwYOBnbsY+qlKahZIIjsfXoUW94tyHMR3yxSkPh6v9MSnAx?=
 =?us-ascii?Q?A49KCGqC1tPvCKgOFzqqEPHhUohdv8c1kLoxcQbuxD2cXcC5DAvjkgxcK/kM?=
 =?us-ascii?Q?xNJH8o2kIVFfQjxh3HXnWLFy+RZv4ojOy38WRhYJH2aoOQSMC+SnjbX5S4fV?=
 =?us-ascii?Q?TdqpiAreub78NcEXE9OuAr8sYwux7riCiag8QYWTVuSubGcKnEOXhtoUkhwF?=
 =?us-ascii?Q?+O92sNyG49JR06e68cymr0MorXjvguIA2zGWuxCcc3bpxi2WUyVHsaSJlDWQ?=
 =?us-ascii?Q?3UcdaAWaZGeSK1xhMBRb/Ago5bX5rclnOmi8VsARSGC/Cbftf6BY8IxAtY6A?=
 =?us-ascii?Q?+Dkccnm27F0bhEokbO3xu5wTbWyonZSZgS0iNrh7CIP50o7xXY/wvh8fUVyR?=
 =?us-ascii?Q?RzQ+MEVPp4F7ttKZk4yaVtGE6SDFPpskCzTBjNFhv3x2PaJazCM8xQfAHEcI?=
 =?us-ascii?Q?Koz8pGu+fRFMP04tQirQEAUeBN6TXCSfnmSiu/4cxDv0igR4AhafPaVpht1X?=
 =?us-ascii?Q?rOs/tPPLRZZuBN83eh9UXUMJinesYV+X+GmqRzT8K5aCN2lvfd5+eHcn6TIs?=
 =?us-ascii?Q?+qjZubGbAKKjy56XZqVowFiDLz2zCNrODbhv6Jn0IPyoTQ+AGcz0CTRmTx54?=
 =?us-ascii?Q?gwq484HveU0mEaReBL14kvx4mewOR6W2gVmtuAKb2iDqm5mb6rb29FevSmov?=
 =?us-ascii?Q?d5qxXfDVVi7ctZn6ZzWJ984kreRKckT+kcL8jVzIjIwqkDyhqk8BnKxjf0gf?=
 =?us-ascii?Q?g2G15j9+r0l06KmfWujXDaHQEs804pTOqrcIv3fLQgpmWTUcy4AwbniiiOSw?=
 =?us-ascii?Q?r4ugdE+L/FPlFA13UM+YYFyvg5NF25OgHE6FM8J2DE/kUNICvPACvsN6pZvW?=
 =?us-ascii?Q?7JacHMu6u4VURvkZxWprAQ+/SmjSnOe90cSTvKusHpiieJmUCWt8yCEs5HY7?=
 =?us-ascii?Q?JG6ux3X/oHcSi0ADltg2E2AS+5RCmWNAYKpj4Wfyy5IR1N7QHQiFDtJsfhEv?=
 =?us-ascii?Q?WfKzzck+LT3VsVLIGu4XQrbXWO1m4/mH4wobiHcV4QR72gm0XJbrrtrfyuZz?=
 =?us-ascii?Q?+sj41nxqRxQ+K13PEGyQbSJBk8H16IaQ8LJo5pnnpBsP5z02xm9WNw37e3pe?=
 =?us-ascii?Q?+oetV0280ayhMk9scmVMTX44c8mDcjX1kOPuS/WX1878aTMw9f5RYBd5+7jR?=
 =?us-ascii?Q?hNKfd2aedPiherwDqzdmYJla+hBfs9rtdsA6ZDV6hKolcB0Gnrwo2bGr1VaX?=
 =?us-ascii?Q?wFwWm+0DJyULQpZzx2R15b9SNhjJEGkNxopZbRIcURnBk7mRpuroVKovUyq5?=
 =?us-ascii?Q?6UGVToOK5P1Z0SO7T83drtqlwY+r4WTd/pG56wCm9aSKzh/N5sjbUR1V+gid?=
 =?us-ascii?Q?LFe1hz3Z2dmR2hZ0dNlgFJbSuIEzqwoqx+L5HDgGHh+zWvcbLcpValTBYR+r?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sbcWw8Z7Hw0KbIA52/SnhYqTcSDNKhMSRxB4qoPmtUCY4tayoi3sCrvyQgXeJDcXj9/I8xXuq0li49IAXPfKt7T37ttA/BgN0yhJjQgkvbX026RqJwtFAddOdRP0dTVBT4y2BPjJIKivmw+aeFrbNVimbymc9VR89Me9NL5zZbOj4dkVVWLJ7x8nU5Rc8kkNJPqD0dS/DAzZ47kysHS8WNQD7/Pyf7DbU4u4G64BIKsjJDtwzXEgjMNuJBM3OQ91QJs53iHIkOliCwxgiT000b+dU52AmxCi4wFrjpZbAGwsVPQ5KhopNSbcnrfYrQJlcFdLNvB6Z3WunLajiaWk5r2u2S4ETLK2slZXYQUrqjmaMeDGFmHH5UwjAnVgZfZPnlyhc8aHOBeR/SJ21S32WBci71hjukXEuT4Kt9rMnfacghXkiI3ONTfa1EPGwxrphUx6gnAXobXh3B5ngVNmhpllz85a4VUteRGwgT1k6WiiWurJLyNvHIDywMFtsWiaho95V0L2XRJNLNDsHwh/OkPtwWFrYDiIQiJpcIZ6+t2F13QRPFqjcSwMVBbLi263mw4u6gBvVgdKF/TQ7cCls6Nd5HOVVkBOX2bk/A/bn2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e72f36-0b5f-4875-7832-08ddeed94d0e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:12:02.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGu7aHV/cenYNEB7Qh+vB2KtXSCY+u542pSiZvDErI6/fuYNZdkozXku3zWZAJBmbt2MGddqQGW57OWrHcBuEtdhGx+Hnh+YSfiyQffMHSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509080132
X-Proofpoint-ORIG-GUID: 5El5QHdQmyb48Mh7Z7e-cCEYzNbV8N4d
X-Authority-Analysis: v=2.4 cv=ILACChvG c=1 sm=1 tr=0 ts=68bed627 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Kq8dobMbidePVuT2iQAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEyNCBTYWx0ZWRfX/PKDMfaTk/Q3
 7mn+qHktYoNNdH4nDm7BJlWp97jZX54KWzWCCx/EYg41uFO2+k6WXgKvGfRWe/Qht2RxN0iqn6Y
 KTWeMP+8I28axWf2JxlwDu576vFqmsv0Y/bnhsPK/dRTNe4Z2BibqV5jkbEzHThK5SQ8Qa9JyBL
 67YV3BSkUDkqb3Xs2ftRez+nJELFoDxfv6eT7E4nFPMBx+yb6ggEMS3Dwuocxv0/flI/hKCSsLM
 kvqVMVyy3kdWx0yrWE8Fl/f8Frzo47fWMiPUlijS2CuibA9M9Qn3SAdL3X6amUrgC/iA8Pv0b9C
 G5e1a9MhF8ytQmL4ijngUdGFalnkQ8ygvPqlJwqnWHRNBzZt1RUpWxW+NzYiYmNclw7KCQf7Ead
 nT7qXIsC
X-Proofpoint-GUID: 5El5QHdQmyb48Mh7Z7e-cCEYzNbV8N4d

On Mon, Sep 08, 2025 at 09:51:01AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 12:10:34PM +0100, Lorenzo Stoakes wrote:
> >  static int secretmem_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > -	const unsigned long len = desc->end - desc->start;
> > +	const unsigned long len = vma_desc_size(desc);
> >
> >  	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> >  		return -EINVAL;
>
> I wonder if we should have some helper for this shared check too, it
> is a bit tricky with the two flags. Forced-shared checks are pretty
> common.

Sure can add.

>
> vma_desc_must_be_shared(desc) ?

Maybe _could_be_shared()?

>
> Also 'must not be exec' is common too.

Right, will have a look! :)

>
> Jason

