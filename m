Return-Path: <linux-fsdevel+bounces-47535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DEFA9F941
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 21:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2E246592A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9C2973A3;
	Mon, 28 Apr 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hGnrN4FY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eAO46BNV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FD296D1E;
	Mon, 28 Apr 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745867615; cv=fail; b=pATKb9zwna4NPkvvsnUH8jyPLdfRVPR3LUa5gTdbko/2ed17dMsHXTmRP/9lmLh8d8X5vDVyZkyRsOJJfDaXeei8/zshYnsNbyoB755xQjf8NIgBiwR8krk6W4P1/PFSPAZUnsSTLPiVRZY5X7SLtBPj/8k6p7/hM61k5kf6Mfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745867615; c=relaxed/simple;
	bh=ZjCZ9skFbD9BAzCvfeHl59kOwsw/SuO+2LatExD22NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QVTxP/UElRSxWZOOJjSzgDuLqQtDXlW/UfDi1pa6KTGAgzDtqrcJbMbemmJGVK7Ivs/jEbl+rDcBZIc6iiIsmOx7NufxUnwvaaSPJsJfXkGTf2fVeouJ8tlSC0sMVEoRjXtPuoA40cRMookSvGeDjXLE9aQEt9zBrFGqhvatt1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hGnrN4FY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eAO46BNV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIM7tZ007888;
	Mon, 28 Apr 2025 19:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=E8DuHHptxR02KKVJ4Y
	3UQVcrUSxaWgAdkgldy/SNCBY=; b=hGnrN4FYZFrBUurdiFxKT9EgjgEg4CGtli
	VZTJxpiP8HM0btuh0IhJStQQiU6sE1/wNx9lwwqS2aIVgcStcuXBmufDwpPL6f6F
	iJNI3TOcfacWCm4aCP6z015iovJh4JBq9RO4fYIMvpGQmr3PKJ62spNr5SgDvUpi
	+Fby2qESMtzYh2SwuI3WsnrpsXzKkpvGasO3B6K3uy8vy+zxzHzfPSqr/mVPanXN
	oNs8XySCB4AegcGrTP5IKXc7JDUE0rZDAVBGk1dmraymraHBICghxtUKE98bQ7iL
	ZVjGwOG0g4/X5q8j1zWVZORGxE6/nFQiodDFi9yIGx9NssvF/hVA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46aevtr3qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:13:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIPvBY013797;
	Mon, 28 Apr 2025 19:13:18 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011027.outbound.protection.outlook.com [40.93.14.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8v769-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:13:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqNcWWsMdvUKNwTw4enX9YL+/Dzh4rbbZA43hENqsLR8ZvnHdo7yNuuF7P4P2plNyOXSgasXmx+H83ebUJV6+l0gJur25MSiAvbLyJKf79F9jipvNWWKSlBnkZcng0jfopt6cE86nxEY3zqeawXGNGCPR1du9G+Mv6uPamviBgp9ROdKN6Ti97M4A3DgOTRpeSfir9/1dkjZVil9K1xBhYAIh8SnVn8cR2jeVbw+I0hk0YPzZDMo9T5DwoAza/LNFaijmi22BxKVMCeI2mvXsagJtJadEc4eF4/alFy5N1mVlFjte8hrJKk7Os/DuIxCmErOhhLI8N8FotHA5HTx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8DuHHptxR02KKVJ4Y3UQVcrUSxaWgAdkgldy/SNCBY=;
 b=NQjJarUJFWvKRzyuSl6FiSbao2lHOsDZSt9UaYP7lCIoldEY28I1w6Z6VRr+H1VjoEZlp5M0/6Mg2m/Y0ECUJFzFLaiPw+44ON5Rb28ci/T2UnyjK1sfdkHwVE1y9AitS6ybLKdn/Mi6dsmLtvfjLjcX6BNDQkyHdocwWILxR9eJEDR190unH6XtiOHsejkSdaTUQL6+GddGFAmqWK9vXdmMerGimWZZPs5IQiT4MR0VJ7/S5Fitosls49HnMz3/wSq/XrO6yhO7lH6xdn+ncrdFEOm5+gnuyI00CdcZDLEof1P/AszExJaioSH8YOFheNXiuJ7wvu7v/8kTgmzYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8DuHHptxR02KKVJ4Y3UQVcrUSxaWgAdkgldy/SNCBY=;
 b=eAO46BNVDIS92UGHgqev4PmdjCsds/Yh0htaDEnOi6E5FWtXeEluVpMEtluN1RS32Au0oy8np3iiJe3j1oxnl7F4GuRDfFJwAfjWPKkBuapnKWaHJCydPGcVWNFapRT4LdQcz+XyJmb4dejWkjppNvUdEdWHXs0qg704Rks934Y=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BY5PR10MB4227.namprd10.prod.outlook.com (2603:10b6:a03:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 19:13:03 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 19:13:03 +0000
Date: Mon, 28 Apr 2025 15:12:59 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mm: move dup_mmap() to mm
Message-ID: <gd3dcjrc47stimsmpcln3s6tu7vrhmccu5mej3jmfhsbp32hg7@5ffby6k5rcfp>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <e49aad3d00212f5539d9fa5769bfda4ce451db3e.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e49aad3d00212f5539d9fa5769bfda4ce451db3e.1745853549.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQBPR0101CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BY5PR10MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c5dbdb-8a21-44fc-658c-08dd8688b31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qF+s2gg/djI0aaKy+Z6shAn6ilPReBxDPamwolYZFF3+nF1qRgAdGzhE49sz?=
 =?us-ascii?Q?FBiq+s5obzeXE3V9cNv1eCukaJLC1WgasPccKNfCvI5EU8mafXCMO2L5+giH?=
 =?us-ascii?Q?osN05y1EvevhZeswb9I5mtF8YRlkW6bd/mkL6aH7gqvvbtpU+wEmsP9YRU4E?=
 =?us-ascii?Q?iziINLm26JwM8HAJTycxS6TfGh3cvcffPEKMJneEyZQfFz25xTQgri0hmY0D?=
 =?us-ascii?Q?ip6IuQLuYZ47OUxyzG3IpgNVcHP3aM6OEb8W3OGzt8aEAQ6Zi7/xru6l+gID?=
 =?us-ascii?Q?4ACihNwIJL2JmvaNhVPiCtvMqlOxEx/o8GwV1XGwyGpLkTYV3biEvjxBEllB?=
 =?us-ascii?Q?XbFaQSo4vP0o8MM54lLOv5uEa7eqx0b2IBsM/5BScV/qIi1PDZZQvgqqu1ZS?=
 =?us-ascii?Q?pmoVKNCFdjYj0c+4gXm8NSK22RTU206+1Ix5fH7ubpIC378wxqUaVHU/4ZHh?=
 =?us-ascii?Q?bDAMDpSRTEGljvNSH3p5JWk0siqataY6y18fE8VOiJpcabhLWlLoJ2AOS2o3?=
 =?us-ascii?Q?sqJArXrLnxqv1XmeywBczH2qYYQLSG/H41JxIEdLBDxN1lYM9D3sgb6ypqz5?=
 =?us-ascii?Q?ZeuhFKOaDFvHdxha1b7lAVdxreFaxQaEKLn/ZQwlXaseud/sfR2rlaVDu4LH?=
 =?us-ascii?Q?tkWwt2WTMdRX3N3e8GyTOf48lBbZiRGTOYbzUtqYxZPGYOSjwd1SSgrC5Zi3?=
 =?us-ascii?Q?tEM5NcE4KcNp41oRUdCxV79zf9XpOylpv7gZ62RMWfn76QGSuQ+M0KLmcRX4?=
 =?us-ascii?Q?wKl6ZiWQDttoTjFY1LRaZMs1fLQlpMXJLYJsuNwJKB+UDNWC9DJQewlKa0/R?=
 =?us-ascii?Q?nk9S453KXX3h2SkVyvN2rthdSE2uXPmusfoPcGC/7jmuluTvOipD3CZ/4lV2?=
 =?us-ascii?Q?DEwcGxc/eOtaHnpsd6ynkjJDMV6+0oFQ6bAxNNVqhez7HhSJMF1VRuBEKKEH?=
 =?us-ascii?Q?gv4k/D/Naq5OvtDzyJq0731eeWBzoMOjt6J8N+amIg3C2E1UPUJl7D+iW1JL?=
 =?us-ascii?Q?A+kMJ5wq5Cy0PTKJ+x8J2DwE7PgrEACo5b5BPncKVdW3FBsTHMjRuBVQ3Mxy?=
 =?us-ascii?Q?pleOqpsvV5gTji/lw/3ACVbhEXfdQ+ZTlqpJT2pwpQmcnoyXCa2qzrajhe0d?=
 =?us-ascii?Q?LjUtq0g2gh1DUfnW42696xrNXO8uWqxRtPoOQsSzPPbDnhFTV1TXzYvnD6jR?=
 =?us-ascii?Q?ZU22j3jesYkJb7U6X8xMlXWWDjMvnCS7L+aoSwhVjByzLOYWucOsf5TXdSBE?=
 =?us-ascii?Q?Gmv4E1pB+noaKBji62ieCvm39TwtvcEBWy+mbBGMTBoLqV5TjJ3jT2rUrzyO?=
 =?us-ascii?Q?k4F8SBXMPnvnJzTn1nFP82mWEy7fWkNbd5xCkBtqnaUw2T5610LKa7yMzBFn?=
 =?us-ascii?Q?kuZaZhKlh847IxYHSgOix9kMIZHeVLMwsCVnod8z7eLhGPqRHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?taCKwNit/NxM+a76SVhn36tP329QS7LDCbU17LiLe1XypnQYGT7r9yRz/8ig?=
 =?us-ascii?Q?3mAbuyEHwXaLYgTA+hy0xDW6lrlsbnEbsD8O/xfKkdYSe/2GwMSoJATdg0rC?=
 =?us-ascii?Q?jf8GlJrBSa0FBg8BOd2fDUr5k+PovOc/SaJO/T0BCBCK6ZIz0L60k1eNvMHQ?=
 =?us-ascii?Q?OoryyMJQE8ufYHf2vcnVlGeHFXH1ogd5U0gr152vEdtEqkxH7WSFFSAYghTK?=
 =?us-ascii?Q?kBN1IJD/e9a2ivOQJ8jsLae4d2JKZaAMofvEydaSSWQBSDPxq2y+RI6AhOj3?=
 =?us-ascii?Q?mCvEtfyGwQWDT9fYBxjgI0vMaIOHF69+7mrHk6WwboveHb92VuyHS2u66zf+?=
 =?us-ascii?Q?tVR/iyJQbupr9PbiXacWn99omRVOhm4ztbV4EF4FKxc3Cv0/atXvCgazcTjV?=
 =?us-ascii?Q?AfWCFUDkGuVlQ7xoWErOaBHRCSGm2RKJnRClUKOlem7xi6m639X7+yTITNNQ?=
 =?us-ascii?Q?YJJz8NP7yHXmsqsQyX+2Arzw5qjv6M6yAGpfwRg5lSGB6qzkqaIXB2HLB3o0?=
 =?us-ascii?Q?eXh+XaLf20BicJuT5mV4fdYbPVaVKeWwdd4aXpEAl1/EQ20gBh1D6dNlChME?=
 =?us-ascii?Q?Iq+2Qaf3J/rdAN6UfOUa6ZsrLzF+dJboEPtdrTAoquppZaubDKcO++St8fl7?=
 =?us-ascii?Q?SN9Wbr7gvM4a3v1MJBCbaOXh1+Dw1RSPH7sSvME/NvUdzmUfqzaknkWDGzB4?=
 =?us-ascii?Q?OpSnWwTIp5EH8G5COoZ9yrC7K8uQHC9TblIIp73OFsbDrvUmqBx4SLSoCWNf?=
 =?us-ascii?Q?RQR/ksLkI/eHPKB5kmPTMq5FNSpwRUHP2UnyEtSASqqdE56q0GyFtNz8fyev?=
 =?us-ascii?Q?8t46yBTCsQ4weZHThWBHZxO1Sb5yiaGXtfMm2NaaxC543UOF+ERSn/+aAL0b?=
 =?us-ascii?Q?+Q5IHl8Ae9X6nsTWsb+jZHZVAWbvWfGL0RG/Y4HnkmI5sv9xLAMVpbrJ7R3D?=
 =?us-ascii?Q?l6zTLkr0G+fwREUbHqDRpmhkW1m0ViYl4AbenwyzO/kyu7WPwC/Vj4fhnzMM?=
 =?us-ascii?Q?V2/boZLerOxTGR6C1fKxH82G12J4l95LAtV2nC0BybfGxZyinPsNKW4mjhEM?=
 =?us-ascii?Q?lU3UQeFkn4nhFt7V7uSisY3ZqPQZmNBi2tpvWkneM+NbViC0h7s6jNbxwZqZ?=
 =?us-ascii?Q?taakwDy45EtIcoW/8cfkl924QpWLYqcps0bewoQeAal+xKlpgYohDgtgZneX?=
 =?us-ascii?Q?Bdpy+ZYpBYhQFALHbkTNPifqblPD1BsADJj820mG5wQ018yHOuOC+olZUpPS?=
 =?us-ascii?Q?8CsKUS6KhVJaKgRc2HTm+GRJftpi5MXVvalZTG3hS8utVDn14+T4jJIkfkxT?=
 =?us-ascii?Q?C8A4XcCvvwDUTKawof8UXMd/z9gr9bnyYTPexn6gcpNxZM1fXfOXtToaS0pV?=
 =?us-ascii?Q?VC364VYdJVh+WcCOkWKCuB1vfDrfCEFTwRF2PzE22gaJ/YeiFv84fIYzsOHa?=
 =?us-ascii?Q?MehE9Pn/kHQN5+WIiV2/kvBNccPk8gZQjH53DXhRv4DPHKK9cDgGsHFW6B71?=
 =?us-ascii?Q?SKhokH/4qcQP5Mc9wWAkcJfC/uXAlyrVtd5NUbfy/tw4NAShiZrJuu2cnBcq?=
 =?us-ascii?Q?Zhw6S+Nh45xxKgMzjDECQZHSgb/06goIxduzGtGZJ/4m1VscR73qM3Nz//sk?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cm5xdSt4IF1VWIf1GTsNSSGy3cTlWf5gnO7YJ5eZnWYZZq2lPka5xnTYj8geLKmzmTXs44i6Nl7DWZwcCywgslGZ9cO/IvzwweddH2WR39h73jlIKMQIof0QPXC8b5HseriBjxZ7SM4ICNWRkRuaUrqsbbzFFOyB3f+VmhkdSpao2miqHnrCq3Lsm+UZUX8MW0Uym/c/RxuIw5fjR6gYpxDw6IfsN004n6i81fhbrRgL/qhnHr4inSKyHNBDbWhCv+VAqi0Bl9eU5CWPbmngHUOVG0y6QMGi2b7ybVCJE094nEuUV/nUGXHYe9x7ZTV3QWfp+cRSqdS4Q9ntPoW+mcrwgabThtMz2mqYvELt7UNw2LwjcksjgONZ5xb+0E6t3IIzBou/cdtuNhgCpM7rF6wonhd5fWsKjTRYovrTjSGgS+zcnWIhKeJBSiW3Q5mWbwMQztxj29lxtEmiXJq1G/PlbMlmd/nTrEMFNbdiGtEiFNzSqYKwm/H6hpAyJgFWDAOSUFLp/ireMrQVv2kQ0x1Ze54RNv/mNNpner8dEqxXoj9jMhKPbkGiYwDx1EyRLviCSYegLi6K1JzHPEFEOnTYtyPHOwbazxzRuA9Ai3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c5dbdb-8a21-44fc-658c-08dd8688b31c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 19:13:03.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiDayGg5PwVGyzql4Tg4z8z/eEaoBElx9FdD1vV74kc/5XD07CHDZrwM9sXcT90ou/8uF9LbwtY0n+f5uRsPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504280155
X-Proofpoint-GUID: yp-USx5ATYnt1n-YbC8KOQpNLN6ylP2A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE1NCBTYWx0ZWRfX3AMee62R+5Xe tESg3A4TtHYyEdrnWyrrntNXzcsOYyJY0BrS36udz1DI8SLnBpJiwd3gnBC4IvukeBdNm1doImI BkYyxditMTaJNHUuYqrXW4VqzGZ2WkMxUz+ifZXIRRbQKJzCWua0PZgS0SANBcQROV+mABKHke9
 RjSs72IT4ZLP5Sl/KWK8rTDa3Q7VVQDV7n8SMUyyXGMDVl6Id/FyrzJRBFbFyo/B+Er3dkBoNzs NzhLKmaithglbcsvA4F85Rt4lGbmmbBMMWMA/E4I/pHva5qPLRX9jBk/zL3JFpZ6CPGM4tttXbO ZmDUIbmv3J6j8SN5i1m646nMDSOo+cifsbPTpz4GioHfB3sBSguk4FVDVhl4PLB5+a1RnDo6I9x STvr1wUf
X-Proofpoint-ORIG-GUID: yp-USx5ATYnt1n-YbC8KOQpNLN6ylP2A

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250428 11:28]:
> This is a key step in our being able to abstract and isolate VMA allocation
> and destruction logic.
> 
> This function is the last one where vm_area_free() and vm_area_dup() are
> directly referenced outside of mmap, so having this in mm allows us to
> isolate these.
> 
> We do the same for the nommu version which is substantially simpler.
> 
> We place the declaration for dup_mmap() in mm/internal.h and have
> kernel/fork.c import this in order to prevent improper use of this
> functionality elsewhere in the kernel.
> 
> While we're here, we remove the useless #ifdef CONFIG_MMU check around
> mmap_read_lock_maybe_expand() in mmap.c, mmap.c is compiled only if
> CONFIG_MMU is set.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  kernel/fork.c | 189 ++------------------------------------------------
>  mm/internal.h |   2 +
>  mm/mmap.c     | 181 +++++++++++++++++++++++++++++++++++++++++++++--
>  mm/nommu.c    |   8 +++
>  4 files changed, 189 insertions(+), 191 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 168681fc4b25..ac9f9267a473 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -112,6 +112,9 @@
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  
> +/* For dup_mmap(). */
> +#include "../mm/internal.h"
> +
>  #include <trace/events/sched.h>
>  
>  #define CREATE_TRACE_POINTS
> @@ -589,7 +592,7 @@ void free_task(struct task_struct *tsk)
>  }
>  EXPORT_SYMBOL(free_task);
>  
> -static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
> +void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
>  	struct file *exe_file;
>  
> @@ -604,183 +607,6 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
>  }
>  
>  #ifdef CONFIG_MMU
> -static __latent_entropy int dup_mmap(struct mm_struct *mm,
> -					struct mm_struct *oldmm)
> -{
> -	struct vm_area_struct *mpnt, *tmp;
> -	int retval;
> -	unsigned long charge = 0;
> -	LIST_HEAD(uf);
> -	VMA_ITERATOR(vmi, mm, 0);
> -
> -	if (mmap_write_lock_killable(oldmm))
> -		return -EINTR;
> -	flush_cache_dup_mm(oldmm);
> -	uprobe_dup_mmap(oldmm, mm);
> -	/*
> -	 * Not linked in yet - no deadlock potential:
> -	 */
> -	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
> -
> -	/* No ordering required: file already has been exposed. */
> -	dup_mm_exe_file(mm, oldmm);
> -
> -	mm->total_vm = oldmm->total_vm;
> -	mm->data_vm = oldmm->data_vm;
> -	mm->exec_vm = oldmm->exec_vm;
> -	mm->stack_vm = oldmm->stack_vm;
> -
> -	/* Use __mt_dup() to efficiently build an identical maple tree. */
> -	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
> -	if (unlikely(retval))
> -		goto out;
> -
> -	mt_clear_in_rcu(vmi.mas.tree);
> -	for_each_vma(vmi, mpnt) {
> -		struct file *file;
> -
> -		vma_start_write(mpnt);
> -		if (mpnt->vm_flags & VM_DONTCOPY) {
> -			retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
> -						    mpnt->vm_end, GFP_KERNEL);
> -			if (retval)
> -				goto loop_out;
> -
> -			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
> -			continue;
> -		}
> -		charge = 0;
> -		/*
> -		 * Don't duplicate many vmas if we've been oom-killed (for
> -		 * example)
> -		 */
> -		if (fatal_signal_pending(current)) {
> -			retval = -EINTR;
> -			goto loop_out;
> -		}
> -		if (mpnt->vm_flags & VM_ACCOUNT) {
> -			unsigned long len = vma_pages(mpnt);
> -
> -			if (security_vm_enough_memory_mm(oldmm, len)) /* sic */
> -				goto fail_nomem;
> -			charge = len;
> -		}
> -		tmp = vm_area_dup(mpnt);
> -		if (!tmp)
> -			goto fail_nomem;
> -
> -		/* track_pfn_copy() will later take care of copying internal state. */
> -		if (unlikely(tmp->vm_flags & VM_PFNMAP))
> -			untrack_pfn_clear(tmp);
> -
> -		retval = vma_dup_policy(mpnt, tmp);
> -		if (retval)
> -			goto fail_nomem_policy;
> -		tmp->vm_mm = mm;
> -		retval = dup_userfaultfd(tmp, &uf);
> -		if (retval)
> -			goto fail_nomem_anon_vma_fork;
> -		if (tmp->vm_flags & VM_WIPEONFORK) {
> -			/*
> -			 * VM_WIPEONFORK gets a clean slate in the child.
> -			 * Don't prepare anon_vma until fault since we don't
> -			 * copy page for current vma.
> -			 */
> -			tmp->anon_vma = NULL;
> -		} else if (anon_vma_fork(tmp, mpnt))
> -			goto fail_nomem_anon_vma_fork;
> -		vm_flags_clear(tmp, VM_LOCKED_MASK);
> -		/*
> -		 * Copy/update hugetlb private vma information.
> -		 */
> -		if (is_vm_hugetlb_page(tmp))
> -			hugetlb_dup_vma_private(tmp);
> -
> -		/*
> -		 * Link the vma into the MT. After using __mt_dup(), memory
> -		 * allocation is not necessary here, so it cannot fail.
> -		 */
> -		vma_iter_bulk_store(&vmi, tmp);
> -
> -		mm->map_count++;
> -
> -		if (tmp->vm_ops && tmp->vm_ops->open)
> -			tmp->vm_ops->open(tmp);
> -
> -		file = tmp->vm_file;
> -		if (file) {
> -			struct address_space *mapping = file->f_mapping;
> -
> -			get_file(file);
> -			i_mmap_lock_write(mapping);
> -			if (vma_is_shared_maywrite(tmp))
> -				mapping_allow_writable(mapping);
> -			flush_dcache_mmap_lock(mapping);
> -			/* insert tmp into the share list, just after mpnt */
> -			vma_interval_tree_insert_after(tmp, mpnt,
> -					&mapping->i_mmap);
> -			flush_dcache_mmap_unlock(mapping);
> -			i_mmap_unlock_write(mapping);
> -		}
> -
> -		if (!(tmp->vm_flags & VM_WIPEONFORK))
> -			retval = copy_page_range(tmp, mpnt);
> -
> -		if (retval) {
> -			mpnt = vma_next(&vmi);
> -			goto loop_out;
> -		}
> -	}
> -	/* a new mm has just been created */
> -	retval = arch_dup_mmap(oldmm, mm);
> -loop_out:
> -	vma_iter_free(&vmi);
> -	if (!retval) {
> -		mt_set_in_rcu(vmi.mas.tree);
> -		ksm_fork(mm, oldmm);
> -		khugepaged_fork(mm, oldmm);
> -	} else {
> -
> -		/*
> -		 * The entire maple tree has already been duplicated. If the
> -		 * mmap duplication fails, mark the failure point with
> -		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
> -		 * stop releasing VMAs that have not been duplicated after this
> -		 * point.
> -		 */
> -		if (mpnt) {
> -			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> -			mas_store(&vmi.mas, XA_ZERO_ENTRY);
> -			/* Avoid OOM iterating a broken tree */
> -			set_bit(MMF_OOM_SKIP, &mm->flags);
> -		}
> -		/*
> -		 * The mm_struct is going to exit, but the locks will be dropped
> -		 * first.  Set the mm_struct as unstable is advisable as it is
> -		 * not fully initialised.
> -		 */
> -		set_bit(MMF_UNSTABLE, &mm->flags);
> -	}
> -out:
> -	mmap_write_unlock(mm);
> -	flush_tlb_mm(oldmm);
> -	mmap_write_unlock(oldmm);
> -	if (!retval)
> -		dup_userfaultfd_complete(&uf);
> -	else
> -		dup_userfaultfd_fail(&uf);
> -	return retval;
> -
> -fail_nomem_anon_vma_fork:
> -	mpol_put(vma_policy(tmp));
> -fail_nomem_policy:
> -	vm_area_free(tmp);
> -fail_nomem:
> -	retval = -ENOMEM;
> -	vm_unacct_memory(charge);
> -	goto loop_out;
> -}
> -
>  static inline int mm_alloc_pgd(struct mm_struct *mm)
>  {
>  	mm->pgd = pgd_alloc(mm);
> @@ -794,13 +620,6 @@ static inline void mm_free_pgd(struct mm_struct *mm)
>  	pgd_free(mm, mm->pgd);
>  }
>  #else
> -static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
> -{
> -	mmap_write_lock(oldmm);
> -	dup_mm_exe_file(mm, oldmm);
> -	mmap_write_unlock(oldmm);
> -	return 0;
> -}
>  #define mm_alloc_pgd(mm)	(0)
>  #define mm_free_pgd(mm)
>  #endif /* CONFIG_MMU */
> diff --git a/mm/internal.h b/mm/internal.h
> index 40464f755092..b3e011976f74 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1631,5 +1631,7 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
>  }
>  #endif /* CONFIG_PT_RECLAIM */
>  
> +void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
> +int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
>  
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9e09eac0021c..5259df031e15 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1675,7 +1675,6 @@ static int __meminit init_reserve_notifier(void)
>  }
>  subsys_initcall(init_reserve_notifier);
>  
> -#ifdef CONFIG_MMU
>  /*
>   * Obtain a read lock on mm->mmap_lock, if the specified address is below the
>   * start of the VMA, the intent is to perform a write, and it is a
> @@ -1719,10 +1718,180 @@ bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
>  	mmap_write_downgrade(mm);
>  	return true;
>  }
> -#else
> -bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
> -				 unsigned long addr, bool write)
> +
> +__latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
> -	return false;
> +	struct vm_area_struct *mpnt, *tmp;
> +	int retval;
> +	unsigned long charge = 0;
> +	LIST_HEAD(uf);
> +	VMA_ITERATOR(vmi, mm, 0);
> +
> +	if (mmap_write_lock_killable(oldmm))
> +		return -EINTR;
> +	flush_cache_dup_mm(oldmm);
> +	uprobe_dup_mmap(oldmm, mm);
> +	/*
> +	 * Not linked in yet - no deadlock potential:
> +	 */
> +	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
> +
> +	/* No ordering required: file already has been exposed. */
> +	dup_mm_exe_file(mm, oldmm);
> +
> +	mm->total_vm = oldmm->total_vm;
> +	mm->data_vm = oldmm->data_vm;
> +	mm->exec_vm = oldmm->exec_vm;
> +	mm->stack_vm = oldmm->stack_vm;
> +
> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
> +	if (unlikely(retval))
> +		goto out;
> +
> +	mt_clear_in_rcu(vmi.mas.tree);
> +	for_each_vma(vmi, mpnt) {
> +		struct file *file;
> +
> +		vma_start_write(mpnt);
> +		if (mpnt->vm_flags & VM_DONTCOPY) {
> +			retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
> +						    mpnt->vm_end, GFP_KERNEL);
> +			if (retval)
> +				goto loop_out;
> +
> +			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
> +			continue;
> +		}
> +		charge = 0;
> +		/*
> +		 * Don't duplicate many vmas if we've been oom-killed (for
> +		 * example)
> +		 */
> +		if (fatal_signal_pending(current)) {
> +			retval = -EINTR;
> +			goto loop_out;
> +		}
> +		if (mpnt->vm_flags & VM_ACCOUNT) {
> +			unsigned long len = vma_pages(mpnt);
> +
> +			if (security_vm_enough_memory_mm(oldmm, len)) /* sic */
> +				goto fail_nomem;
> +			charge = len;
> +		}
> +
> +		tmp = vm_area_dup(mpnt);
> +		if (!tmp)
> +			goto fail_nomem;
> +
> +		/* track_pfn_copy() will later take care of copying internal state. */
> +		if (unlikely(tmp->vm_flags & VM_PFNMAP))
> +			untrack_pfn_clear(tmp);
> +
> +		retval = vma_dup_policy(mpnt, tmp);
> +		if (retval)
> +			goto fail_nomem_policy;
> +		tmp->vm_mm = mm;
> +		retval = dup_userfaultfd(tmp, &uf);
> +		if (retval)
> +			goto fail_nomem_anon_vma_fork;
> +		if (tmp->vm_flags & VM_WIPEONFORK) {
> +			/*
> +			 * VM_WIPEONFORK gets a clean slate in the child.
> +			 * Don't prepare anon_vma until fault since we don't
> +			 * copy page for current vma.
> +			 */
> +			tmp->anon_vma = NULL;
> +		} else if (anon_vma_fork(tmp, mpnt))
> +			goto fail_nomem_anon_vma_fork;
> +		vm_flags_clear(tmp, VM_LOCKED_MASK);
> +		/*
> +		 * Copy/update hugetlb private vma information.
> +		 */
> +		if (is_vm_hugetlb_page(tmp))
> +			hugetlb_dup_vma_private(tmp);
> +
> +		/*
> +		 * Link the vma into the MT. After using __mt_dup(), memory
> +		 * allocation is not necessary here, so it cannot fail.
> +		 */
> +		vma_iter_bulk_store(&vmi, tmp);
> +
> +		mm->map_count++;
> +
> +		if (tmp->vm_ops && tmp->vm_ops->open)
> +			tmp->vm_ops->open(tmp);
> +
> +		file = tmp->vm_file;
> +		if (file) {
> +			struct address_space *mapping = file->f_mapping;
> +
> +			get_file(file);
> +			i_mmap_lock_write(mapping);
> +			if (vma_is_shared_maywrite(tmp))
> +				mapping_allow_writable(mapping);
> +			flush_dcache_mmap_lock(mapping);
> +			/* insert tmp into the share list, just after mpnt */
> +			vma_interval_tree_insert_after(tmp, mpnt,
> +					&mapping->i_mmap);
> +			flush_dcache_mmap_unlock(mapping);
> +			i_mmap_unlock_write(mapping);
> +		}
> +
> +		if (!(tmp->vm_flags & VM_WIPEONFORK))
> +			retval = copy_page_range(tmp, mpnt);
> +
> +		if (retval) {
> +			mpnt = vma_next(&vmi);
> +			goto loop_out;
> +		}
> +	}
> +	/* a new mm has just been created */
> +	retval = arch_dup_mmap(oldmm, mm);
> +loop_out:
> +	vma_iter_free(&vmi);
> +	if (!retval) {
> +		mt_set_in_rcu(vmi.mas.tree);
> +		ksm_fork(mm, oldmm);
> +		khugepaged_fork(mm, oldmm);
> +	} else {
> +
> +		/*
> +		 * The entire maple tree has already been duplicated. If the
> +		 * mmap duplication fails, mark the failure point with
> +		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
> +		 * stop releasing VMAs that have not been duplicated after this
> +		 * point.
> +		 */
> +		if (mpnt) {
> +			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> +			mas_store(&vmi.mas, XA_ZERO_ENTRY);
> +			/* Avoid OOM iterating a broken tree */
> +			set_bit(MMF_OOM_SKIP, &mm->flags);
> +		}
> +		/*
> +		 * The mm_struct is going to exit, but the locks will be dropped
> +		 * first.  Set the mm_struct as unstable is advisable as it is
> +		 * not fully initialised.
> +		 */
> +		set_bit(MMF_UNSTABLE, &mm->flags);
> +	}
> +out:
> +	mmap_write_unlock(mm);
> +	flush_tlb_mm(oldmm);
> +	mmap_write_unlock(oldmm);
> +	if (!retval)
> +		dup_userfaultfd_complete(&uf);
> +	else
> +		dup_userfaultfd_fail(&uf);
> +	return retval;
> +
> +fail_nomem_anon_vma_fork:
> +	mpol_put(vma_policy(tmp));
> +fail_nomem_policy:
> +	vm_area_free(tmp);
> +fail_nomem:
> +	retval = -ENOMEM;
> +	vm_unacct_memory(charge);
> +	goto loop_out;
>  }
> -#endif
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 2b4d304c6445..a142fc258d39 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1874,3 +1874,11 @@ static int __meminit init_admin_reserve(void)
>  	return 0;
>  }
>  subsys_initcall(init_admin_reserve);
> +
> +int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
> +{
> +	mmap_write_lock(oldmm);
> +	dup_mm_exe_file(mm, oldmm);
> +	mmap_write_unlock(oldmm);
> +	return 0;
> +}
> -- 
> 2.49.0
> 

