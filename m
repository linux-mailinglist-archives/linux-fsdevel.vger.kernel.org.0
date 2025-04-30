Return-Path: <linux-fsdevel+bounces-47753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA07AA5518
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD8F7BAD89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7A02798FD;
	Wed, 30 Apr 2025 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CkDr9e51";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tvEGrD8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48BF27817D;
	Wed, 30 Apr 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042892; cv=fail; b=XlPh5gPIIa8zh6o2i/v5FHL2PFp5OAEet5OQsSdHksQu8OIvcRZf7yg+9SjGMNuhGkawuRovkMPgZQ+aLy1131E28lXa0v6Y+4ZXNi4gvDC18UyLtwXb8n+pYejoMfXoPoM4JD+6Gkm/YcLSLNpYdEfFM9br6g1d5oDD1L1Tt3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042892; c=relaxed/simple;
	bh=RxJSvcKdd/caP9KRvsAFtZEy3/tNhNjRQ6z2zhqo6m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RVAy3bmQ71QIaNwOf9clxt+DsYSibE4F9KOge6kue31x/g87mzOZSFhf/Abd+W2huV7GoiU0g51ypUOaEeEpiYiTM3rNohEzynrZ97+C7loPbxG0wwSbg2fbtGhW1YVBgSTvXoBPKR+dKaU5Gwp0wWPU3bEDeRxU3QIFlqvdFxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CkDr9e51; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tvEGrD8g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHtqvO014910;
	Wed, 30 Apr 2025 19:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OmQPY3QSds1O1QJKBLd0uNk+vb+5JphREDqX1bV8D3c=; b=
	CkDr9e51pHTVVN0Tnp43Y5RpdPgc6DinXY1PjpQm8u24IHbVBetD3Y/a1G9ZXbPg
	7V1zy1MmieQaxvZM50WOSXk+Uft3EL5kVMYktGzm+ZxlRXAuN5ZEx8JyFVrR8TVd
	YJ+vwGkeDQ9PEU+N7vQWKYiUvYxqnG0RU/DSbjxqyojfjOd78DabbgNgYnEWK/Ag
	pfdiwtg64P16dVQ0cAwVw/fm32tVQE0sZfWuQos8GK5NN/LYThSssj4x6wH9zxi0
	+33jySAci6W8hwHSSiiRLoi812BjSHXNJAVEFI5aQVmgNRn/7k2A+THXRZQBkGPx
	CTsKp37qKyqnqvMQJ893EQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukt10x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:54:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJOXFP035359;
	Wed, 30 Apr 2025 19:54:35 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbhxpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:54:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA17g+HX9i/3SgCAQHgQzLdfRm9/u9PzaoIrN9ALKnN0M8iESiQCb5TxhJrHnEEox0sVjy8lZuvLjNO/aPs27NWdfmcl4zvEntwvKl0Kx/7dczBmEQOiJgH3x6BIkBnof7IcJJwxLzZoRfYAya+v259/ftfrEtDmEzH2cCBdJE6vfZ8QcI8eyhBuL6W7QXA68e52Hi33Y6r0ONdfJboc/xbprqegjsl9b10DEuAOGucWRUYqrjCy6dRMSzpzfaoNGOpavC38XVj2nsS+GrNyKlbO2L3P74C0NclxWHIH/xt9WpRAWZoPwiRHzji5BIhicO54e1P3go0EhXhqzykppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmQPY3QSds1O1QJKBLd0uNk+vb+5JphREDqX1bV8D3c=;
 b=tgYNJi8P+Hhsy+OTHeVr+ktHn3OZ7vWNHMipz95HYYgv+wfM3/jfBgq4RVrGwr3ioTCQCgsCztVlXV36jRaQlSsC6BRxzwMk2MVAoxHZ/cCKgXMyFboqiLmUFqUx/uxnt7RnRxe6Xd7DZgcmxQbOC9KeXqh03WidMfiU9iTr0mkqFXdLNJrP/Na4utWkl835l8Oaf7cT1htI2JZJAlolrj5ZVqvcWq0rU7tYYu2CaFo3S6XgYj9FrkpvUK1njJmh7eYhqB4mwWPHsgj9jTI0v0kbnTjMMYQY931lMlXYFe7RS3Wbja6wTkVNH/THQ5ho2NxdX+dpXAcdKCocwB8FcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmQPY3QSds1O1QJKBLd0uNk+vb+5JphREDqX1bV8D3c=;
 b=tvEGrD8gMthslHHXbCe552E9fIFVgwx3chi3SUDUCGpO7Obeh5UhWNFbVZOmUd2nNezoCpTX+xL5YVx5L6vMPHN90MIVou/K3EuYm7KyAkDIQCGhhirRvelAswf9mUJm77JJqZNPMWL0jbTooDG48ipO8GQRCAvQNDBPLI0ugPM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFFE8543B68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 19:54:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:54:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan --cc=Michal Hocko <"surenb@google.commhocko"@suse.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
Date: Wed, 30 Apr 2025 20:54:11 +0100
Message-ID: <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0497.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFFE8543B68:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc69df7-761e-4c6c-36c7-08dd8820d2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNfLsJGik/ruQbFsgiicjguE68W+nHABCvF7CKZE3YEwSjfPjC8itmTLVLSQ?=
 =?us-ascii?Q?rZxOwMNaHDmqewvdol4UbOBGCMauYQYnb+uAvvaqbn5pVWeoz4WPopSvyLJy?=
 =?us-ascii?Q?pf/QsxaaWREF3JsAMfiGgpgzabkYYplMnZrwLukb2RyPAD15iwkrL5REQOUq?=
 =?us-ascii?Q?3QEkVpapHnoHwbuG4kj16bE1vqhMaQRoUPDkzkoyFpdGwpgW+roGpM/J5YJk?=
 =?us-ascii?Q?8XD3mE5IMNAuzZjWVjVM0nAyrWzhpgrAj2IJNr9Q7XCd9WsiCO8E2S4b1bRk?=
 =?us-ascii?Q?S4AvsP2Bc2nB+1Rkzzl1VqrztlCvimnOaH/6M/qcmnahmKygGfCfmF2pGMJ0?=
 =?us-ascii?Q?7/oYcXsntyqbXmqkdBMUJtaixfcfJehqqX5KJcrzUNoXmADYc4aitudY9Tid?=
 =?us-ascii?Q?bmpAZrUCc2Pu2BQXK9lJP33AiWON5Q0xpL/k2neWq9hqXiZJBL9nNX2GcRHf?=
 =?us-ascii?Q?OKNwLVWqFovNg+R8Xi3Egvmtqdw/ti3GcI6Qz0om73XB9KzoeARxUYwNsJ94?=
 =?us-ascii?Q?6E249J3wMlqeKWB4IQhbBSUBZ8p6ZkhESMBwm3N2IJq9zSahp1LgZek9TpSw?=
 =?us-ascii?Q?N2F4c9vGgFvylw4YGAWOEcECwhJG0rmR3+//+X6k5yT6158Xfv0gDBy5zB6m?=
 =?us-ascii?Q?lA07+owa4jS+sbqjsbZ5k0hBI7QZdjh4LPTV5LjQbN4i7REnrgMfQTFPmtsh?=
 =?us-ascii?Q?TZHIBlRwxcWMdLTHzRGNxbXJKoaV4AIY9btCHkTN9VnLAZ7+EkjHrxJomUTZ?=
 =?us-ascii?Q?msLdCdc+MUWraWbhIUQyW5OPAhCTks1VVaOr1TLANa2jwFmcrtWAYByXlQHu?=
 =?us-ascii?Q?GW+DC59VVeBoh3p8f+W9ORsJOngANrayg5opQw3hREZ9/HBbFGBuHhkRFmtt?=
 =?us-ascii?Q?0t8CpPzDuXap+eWyBTT18c/9OmZA8ZHMozp0hmcphi4RIzqLBZ2BbyDsVtlh?=
 =?us-ascii?Q?OhG99VL8g797Qa+A0RSprBkXovHtx4jMa7Ou6LW0gV1VYu4EWgMFP9MPipzk?=
 =?us-ascii?Q?Ub6PSuX37sDGcqeYKT+DR23/rYn/CtK/kqa1aCneswstJGrx9Zf/CA81jcCG?=
 =?us-ascii?Q?Z6PSCwTFsV7JUm5P3Mmo4eysFdtL93Heo8G3lhkTkkGopFgYRKddd5Ft5mLi?=
 =?us-ascii?Q?nfdseQJGjLeiMb8VJUc0VM3X+wStWcHupMSz98P0DWJvATu2wHZodhSrnEdl?=
 =?us-ascii?Q?AUAiOhVS2Db+wolEsFvoo4Up0PZ2ohBzceQJoR8AcmgcIol3N+f2DxmQa+nP?=
 =?us-ascii?Q?Ialx8sUv+QkmfUr4expC0C7IIuFTcmfzxNdZ8X6eRjI8jvaPeN4uiZeR2lnq?=
 =?us-ascii?Q?Hu2/3OVbwNQxg//QxRrztYkAYijtvb2D+GgLelUXyq5wee7nBLMh3YT1LhJJ?=
 =?us-ascii?Q?8GS3TPsir6j/4v3kevr7BAv6kg+cSVxHeBmRCe/ntDGCk8CVbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g3lowTwED/g7xjiJF0yNUlBx7PFByHftQ816qhBOr0EExiOLa1lgFsoWg+RC?=
 =?us-ascii?Q?qJTgDYeb5q8vvYQ6pA0W7saOJTpOGr5Ky5e/DGtWJ1ywDFsjdyVz87w+eiJH?=
 =?us-ascii?Q?J0b8/bG7d2U8t6hs/RDQhUA9KYsiA3nfXyGtkAmG7UMxnzREZ6BsfHsTTEaj?=
 =?us-ascii?Q?W9G+r1h1Yl7IsrWEmr8bOYOoPGdz3CCq++/Lfd/SAugjIWXqLSTLtbVIbsXh?=
 =?us-ascii?Q?sHUQH3ylKsgDr4+c5pqUp2HMuzMFejZxg3sEy/ZNMi2v07VH2G1lvzs2XU1v?=
 =?us-ascii?Q?JFvU2Kzk1Y+A8v59/30RJteYTHdL8f1KVZt2z0AXZF3ULy8Inq4K1pwAeZ6t?=
 =?us-ascii?Q?Co6GbXFOfz+I8b1a3xAmqKxUtZ7wMBjTIcub2TQu/b2srnT6mLBCVNpKLv+x?=
 =?us-ascii?Q?5dKiv0YiNYG8p7a5zP4QiugX5v1e7+r06s8yIg66iBtlzRZAendfRbam7Vkb?=
 =?us-ascii?Q?24G594Pbn39O83IuNw/qu/Z19E5u7LzgKWJMBDG+m9IV+2tKauTnRrJOv+0c?=
 =?us-ascii?Q?TZHNxt2bit38eYKgJTrAXg2BGRLCbNVMsSWgtK1FR+Uyen6UtvrkDSNXHryV?=
 =?us-ascii?Q?uNINBbuo9KriYHMFlXhx3fj5kJ3uxl3+UL5KNyVEcnl64oSQdA+z0A+gfbX6?=
 =?us-ascii?Q?83eewVxOUlwFz13Lp0TFVoo45hqUrRrNRjXXVEfqUXboFFB7b+U967vCWtfh?=
 =?us-ascii?Q?jAFGC1aVB2WXzcNeuIy/MRkZZviDm7IUxhy+YMu2eg3ccnyfO7sRlY7ppfo4?=
 =?us-ascii?Q?xWg+B1bfj03SOt0WjW0FJ6THSUtvQhpx4V3AAqMBWO+dHwi0NZPDSId9eJSc?=
 =?us-ascii?Q?J1VHzCc0XKmpOxqtUzrdVd2/1DYwF2Pf2oQe8XZS1Sy1xziVClid1q3Uxlfu?=
 =?us-ascii?Q?bK/83/f/pV/uaPtX6UwWk8ka52F6e6NSjE6CgcBgW4tGf6YVPTJ72WySk8RD?=
 =?us-ascii?Q?gMxnexToS3UIoOTyIBbquSSjUoEFZxxsKaqy9kkT9CnCK3emy/9vGbGV3VW3?=
 =?us-ascii?Q?z9XIqTqefCbomrNtF86hncdrsjlVTxzs2+XhFnNGx0Dw6QOgUjGNQwENzIUp?=
 =?us-ascii?Q?CQwYB2C16ncuuikqfrmU9pnHoUAvqLGtoTra9WUQMKrgpVX8xC07w+MMyZ8p?=
 =?us-ascii?Q?dq8G6JQ2brCX+MsvDurGNHo56mPIWhULvjn+MNgoibNVJOFscILRwQRt0OpL?=
 =?us-ascii?Q?yVVy65ScZOfGqod48q8mx4kG+kADN1L+yLYllipROgIUJb8gi2NhYX0lPj48?=
 =?us-ascii?Q?Xr1xDN5Ao5lIlNbTk5iLWYJ+MPARS2+jdsR8Lge5SRZdD/PSyXzDgemQXewK?=
 =?us-ascii?Q?6Eg8D5jnoH0dDfXs8uIpiCYbXpJWWf4BqNqf72ZfJXl/AhYnG/d6SkXqW5un?=
 =?us-ascii?Q?VWg3THyjxbTvJb9asEUeLnktHZBiqmCbXaFrKTUqMOJL4PMJc+CWtbDjEdao?=
 =?us-ascii?Q?f78TmkXoWwwzWLhaSAetbz+aFD/9qk+7viX66jPpu/NgZO7iiyapmXd/Im01?=
 =?us-ascii?Q?9rmbf/ErpACQv4+crdwKQOotm00D3/AZIwmFTzAY0pBZQ7SdCOH/tgSkjEL2?=
 =?us-ascii?Q?vbdkrjSMCtuDkxfol7lstZ9+HD8V0hDmRl+M/8ZzpfOysWHdukXUC8DJ/WLn?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1BUbSoETNcsIZJXyituGutevSTVuJ71+2L2tN9UtQdAdxtygeOT4MWYqAF7WEAGt9S/2i5Wq82fR3ttFbn7taOAJHP8iqSri3XpLfRMfOFpuAwooSoKBX3Du06uNwHBrdSDqbCj/O7fYf+SM49m7llEnQPRoz8GzvxVWMsPRZBF49ictowo0CbkbwZlKwTVLzPLq8jN1E0DFla9X2/+GXZ/bsmV8ErZNv147zX81xZSiZhW7ifsddD5hEjN6Yr7TWPtja3G7PY6yCnvU2vbK7M8mJWdvaZDmwqOkg5JTSJny+iDxBi2ud1ykQ3bFDON0GOwXerHCH5ba35LcaeaA2dRZDE2d5a5Wqz0IiTMOx49nl3sW6+ek/uXFenNicm7mgG33YFVclz+tj9ByDxud/z+/Bo1Y66PX1PMIRZOYb68+90YarDtw1y/Z7DYM0/co1f4f2dIOeZPCnfh9chAh9QocU0LObhR1mZrqiNKRemRYt/a2ynPBnvavF9r8oGg4h2Zo6pLfww9dKEYTTsQtEP3JFt1g0L1EHi7vhyaI1Uc4BW9v0lUJzYsxSdnIQalZUAPj8BMBIwvDyqcPwvCxMe+NTkoibAlT8KnqBZp0CRk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc69df7-761e-4c6c-36c7-08dd8820d2c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:54:31.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8S0KUUPKteeJaa2uDRCknBssNCI04Yz++lb/TgnVh7g0Xwl3YTAEbAIA3QWKSYCFkiQh7ma0PiXoWz+hRHAqo+tAASYQQnWYUWH5hnbE6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFE8543B68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NSBTYWx0ZWRfX1GsQ11JNG950 F2uwyEvAzK7EmuHm1+txc2WbZG5Q3NjcqKrl8NgNNmo+/PJGXx36qymGxRo5pKrNQbuX4C/OL9A uIhvoLOSkjaA63mYPycBd0YxzTBBgbe7/36SrjjnfyoemCsos15wO2upSY22FPX+rI87/nRUG3M
 HLGsqoE4gi2UzOqrkf4nZUlJYY3wdaRPPjye67fNkOELYLg7/6J77oNZcom2mmIZDdnJaKUZY57 4dvrU2fuLkTBC8gJNDELCDl+v6eCo1VB0musyeycYcBw6d/WI33gyPqRiJrqZyZ4I3ZvG3+v4SQ noPx4YJ/a8RgxMkcs3Y8fOQimZTvxEIaYJndZ70uHQObHy39vaO6iCbCC/DGKiCkKmE99BYpdfq
 OlkeKnSm6QZhcAKIPJo/434CUTKsPDoDfDsLjS9+BkdStHoGNrzmYgv/QqHV103tJJamlhhq
X-Proofpoint-GUID: ffTsNBLgEXaXubrpF0nj7FBc1m_FdINi
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68127ffb b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=bBcQKemid6v3KLeQvokA:9 cc=ntf awl=host:14638
X-Proofpoint-ORIG-GUID: ffTsNBLgEXaXubrpF0nj7FBc1m_FdINi

Provide a means by which drivers can specify which fields of those
permitted to be changed should be altered to prior to mmap()'ing a
range (which may either result from a merge or from mapping an entirely new
VMA).

Doing so is substantially safer than the existing .mmap() calback which
provides unrestricted access to the part-constructed VMA and permits
drivers and file systems to do 'creative' things which makes it hard to
reason about the state of the VMA after the function returns.

The existing .mmap() callback's freedom has caused a great deal of issues,
especially in error handling, as unwinding the mmap() state has proven to
be non-trivial and caused significant issues in the past, for instance
those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
error path behaviour").

It also necessitates a second attempt at merge once the .mmap() callback
has completed, which has caused issues in the past, is awkward, adds
overhead and is difficult to reason about.

The .mmap_proto() callback eliminates this requirement, as we can update
fields prior to even attempting the first merge. It is safer, as we heavily
restrict what can actually be modified, and being invoked very early in the
mmap() process, error handling can be performed safely with very little
unwinding of state required.

Update vma userland test stubs to account for changes.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/fs.h               |  7 +++
 include/linux/mm_types.h         | 24 +++++++++
 mm/memory.c                      |  3 +-
 mm/mmap.c                        |  2 +-
 mm/vma.c                         | 87 +++++++++++++++++++++++++++++++-
 tools/testing/vma/vma_internal.h | 38 ++++++++++++++
 6 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..f8ccdf5419fc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2169,6 +2169,7 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	int (*mmap_proto)(struct vma_proto *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
@@ -2243,6 +2244,12 @@ static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 	return file->f_op->mmap(file, vma);
 }
 
+/* Does the file have an .mmap() hook? */
+static inline bool file_has_mmap_hook(struct file *file)
+{
+	return file->f_op->mmap || file->f_op->mmap_proto;
+}
+
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e76bade9ebb1..b21d01efc541 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -763,6 +763,30 @@ struct vma_numab_state {
 	int prev_scan_seq;
 };
 
+/*
+ * Describes a prototype VMA that is about to be mmap()'ed. Drivers may choose
+ * to manipulate non-const fields, which will cause those fields to be updated
+ * in the resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vma_proto {
+	/* Immutable state. */
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *file;
+	vm_flags_t flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
diff --git a/mm/memory.c b/mm/memory.c
index 68c1d962d0ad..98a20565825b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -527,10 +527,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		dump_page(page, "bad pte");
 	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
-	pr_alert("file:%pD fault:%ps mmap:%ps read_folio:%ps\n",
+	pr_alert("file:%pD fault:%ps mmap:%ps mmap_proto: %ps read_folio:%ps\n",
 		 vma->vm_file,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
 		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
+		 vma->vm_file ? vma->vm_file->f_op->mmap_proto : NULL,
 		 mapping ? mapping->a_ops->read_folio : NULL);
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
diff --git a/mm/mmap.c b/mm/mmap.c
index 81dd962a1cfc..411309c7b235 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -475,7 +475,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 				vm_flags &= ~VM_MAYEXEC;
 			}
 
-			if (!file->f_op->mmap)
+			if (!file_has_mmap_hook(file))
 				return -ENODEV;
 			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
 				return -EINVAL;
diff --git a/mm/vma.c b/mm/vma.c
index 1f2634b29568..76bd3a67ce0f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -17,6 +17,11 @@ struct mmap_state {
 	unsigned long pglen;
 	unsigned long flags;
 	struct file *file;
+	pgprot_t page_prot;
+
+	/* User-defined fields, perhaps updated by .mmap_proto(). */
+	const struct vm_operations_struct *vm_ops;
+	void *vm_private_data;
 
 	unsigned long charged;
 	bool retry_merge;
@@ -40,6 +45,7 @@ struct mmap_state {
 		.pglen = PHYS_PFN(len_),				\
 		.flags = flags_,					\
 		.file = file_,						\
+		.page_prot = vm_get_page_prot(flags_),			\
 	}
 
 #define VMG_MMAP_STATE(name, map_, vma_)				\
@@ -2384,7 +2390,17 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	struct vma_iterator *vmi = map->vmi;
 	int error;
 
+	VM_WARN_ON(!file_has_mmap_hook(map->file));
+
 	vma->vm_file = get_file(map->file);
+
+	/*
+	 * The caller might only define .mmap_proto(), in which case we have
+	 * nothing further to do.
+	 */
+	if (!map->file->f_op->mmap)
+		return 0;
+
 	error = mmap_file(vma->vm_file, vma);
 	if (error) {
 		fput(vma->vm_file);
@@ -2441,7 +2457,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	vma_iter_config(vmi, map->addr, map->end);
 	vma_set_range(vma, map->addr, map->end, map->pgoff);
 	vm_flags_init(vma, map->flags);
-	vma->vm_page_prot = vm_get_page_prot(map->flags);
+	vma->vm_page_prot = map->page_prot;
 
 	if (vma_iter_prealloc(vmi, vma)) {
 		error = -ENOMEM;
@@ -2528,6 +2544,69 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 	vma_set_page_prot(vma);
 }
 
+/* Does the driver backing this implement an .mmap_proto() hook? */
+static bool have_mmap_proto_hook(struct mmap_state *map)
+{
+	struct file *file = map->file;
+
+	return file && file->f_op->mmap_proto;
+}
+
+/*
+ * Invoke the f_op->mmap_proto() callback for a file-backed mapping that
+ * specifies it.
+ *
+ * This is called prior to any merge attempt, and updates whitelisted fields
+ * that are permitted to be updated by the caller.
+ *
+ * All but user-defined fields will be pre-populated with original values
+ *
+ * Returns 0 on success, or an error code otherwise.
+ */
+static int call_proto(struct mmap_state *map)
+{
+	int err;
+	const struct file_operations *f_op = map->file->f_op;
+	struct vma_proto proto = {
+		.mm = map->mm,
+		.start = map->addr,
+		.end = map->end,
+
+		.pgoff = map->pgoff,
+		.file = map->file,
+		.flags = map->flags,
+	};
+
+	/* Invoke the hook. */
+	err = f_op->mmap_proto(&proto);
+	if (err)
+		return err;
+
+	/* Update fields permitted to be changed. */
+	map->pgoff = proto.pgoff;
+	map->file = proto.file;
+	map->flags = proto.flags;
+	map->page_prot = proto.page_prot;
+	/* User-defined fields. */
+	map->vm_ops = proto.vm_ops;
+	map->vm_private_data = proto.private_data;
+
+	return 0;
+}
+
+static void set_vma_user_defined_fields(struct vm_area_struct *vma,
+		struct mmap_state *map)
+{
+	/*
+	 * If the .mmap() handler set these, that takes precedent (indicated by
+	 * the vma fields being non-empty).
+	 */
+	if (map->vm_ops && vma->vm_ops == &vma_dummy_vm_ops)
+		vma->vm_ops = map->vm_ops;
+	if (!vma->vm_private_data)
+		vma->vm_private_data = map->vm_private_data;
+}
+
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
@@ -2537,8 +2616,11 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
+	bool have_proto = have_mmap_proto_hook(&map);
 
 	error = __mmap_prepare(&map, uf);
+	if (!error && have_proto)
+		error = call_proto(&map);
 	if (error)
 		goto abort_munmap;
 
@@ -2556,6 +2638,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 			goto unacct_error;
 	}
 
+	if (have_proto)
+		set_vma_user_defined_fields(vma, &map);
+
 	/* If flags changed, we might be able to merge, so try again. */
 	if (map.retry_merge) {
 		struct vm_area_struct *merged;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 198abe66de5a..56a49d455949 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -253,8 +253,40 @@ struct mm_struct {
 	unsigned long flags; /* Must use atomic bitops to access */
 };
 
+struct vm_area_struct;
+
+/*
+ * Describes a prototype VMA that is about to be mmap()'ed. Drivers may choose
+ * to manipulate non-const fields, which will cause those fields to be updated
+ * in the resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vma_proto {
+	/* Immutable state. */
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *file;
+	vm_flags_t flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+};
+
+struct file_operations {
+	int (*mmap)(struct file *, struct vm_area_struct *);
+	int (*mmap_proto)(struct vma_proto *);
+};
+
 struct file {
 	struct address_space	*f_mapping;
+	const struct file_operations	*f_op;
 };
 
 #define VMA_LOCK_OFFSET	0x40000000
@@ -1405,4 +1437,10 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 	(void)vma;
 }
 
+/* Does the file have an .mmap() hook? */
+static inline bool file_has_mmap_hook(struct file *file)
+{
+	return file->f_op->mmap || file->f_op->mmap_proto;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


