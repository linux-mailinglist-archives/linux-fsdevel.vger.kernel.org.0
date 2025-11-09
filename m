Return-Path: <linux-fsdevel+bounces-67601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E5DC44540
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 19:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 665614E13F7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 18:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2382E230BF8;
	Sun,  9 Nov 2025 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="R99IRQC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021103.outbound.protection.outlook.com [52.101.62.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BAB223DE9;
	Sun,  9 Nov 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762714655; cv=fail; b=GePojRwX8pHvP2ObcxgKfTZEcASp10RgOKsLzB0qiBef0o5RaNM1S6iIf2984Y5TsP49S7LDxnFov54eJdyxFzsEfy1PkLLeXp9xZZv+DdvlwB168eueGh4pP7qInEg59SQYCI3IQkgiHOCBdMHzTcppsEvwR5Iola4FwZFPTOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762714655; c=relaxed/simple;
	bh=UVqbcCg70sqYa0uKutISfIdG481KtAN5Ein3xfyrJqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3skpUewUbNh8pJErstJUNhmL6W/9M8dq0ao7pf+tpc/EjTRfqWkxde3aDa3yQIKe1YJlRxyyOr/zE0Dt7541lX+1Dz2GfbGQ3o2aYD20f8PICn3Gj1obe66gjEbbUPbstR7E1byCgv4+SPfU9BHLArX0OH8pkMIZe7RhEsl9/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=R99IRQC1; arc=fail smtp.client-ip=52.101.62.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmmYbZSuK/xZHUdSqeY7lkRFOInu9T5mtPnfWRzR8d6cdziLlO9NfeXXnn2VkacIP/e6O2KOphilCDbeYFrwejZSI2v8PVpndOtKDAQmTG8xKmjJbuU1nSlgzTNmvs0AfzKdPITeS3HuEnsLdpUMpz7Kwz+tsLeZB0s2n75bs4YT6QhWCWU1OUbJsAvaUDtv523xJUNCOVRLWDxirt6AJU00oefc6TOLNNMEo55iMuVH2fS/dJ80G5+OiQMIMv43jWLw+HkM3s8K1xbObwHaypkeHv7iWEVMyd17KHkEkv0dDo9sUgtoANzNKLMvJNOemXoVgNkdmEdikpzAPP1Jgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13pNlSkUjHC9o9eAsf5gQnNI7ShkwVnEJ+LO9+JgRgY=;
 b=CW456EDnSyrV2iy3hPZfilYYgkQw3fOuG/3ESeyD6gMFdpG22pbTLdO4o5/YLSI9/Bqrck0Zk3XvmFSmVthV503vtQm7NzJ+rgfFoQZ8nxBDVrTzzlnS8RvsM+l/UMP7eFDZchsO1iBPjK2DIjboV1izjUOBoo77MiYcbDtt9Bev4A3Wg43F8y1TR3W7MjZDztNMX5k9J2jeHVAdtXUBC+Tb+FQORzxrkg3ctuoMHZKaUJUDar3qX/QM3KOGjvUou5TrbgmWRXJdKOk1Pyju45w11K7jO5ITSQH9yYKknTKHKNLKx/7uStjRr8IeajCjSAO7R2dSGeZpefbfepNDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13pNlSkUjHC9o9eAsf5gQnNI7ShkwVnEJ+LO9+JgRgY=;
 b=R99IRQC1UM3Ki6LMu7zNQDAlbS2wfdCn8eCK3g7PVgiuMA1bg9+H8ZPp6B3hRxD54mFjbZlyoXe1Jr9S95vX+oYJ5ZXtF6XyDT284iV+EMGWb72nFSzhie4AaM1sF46CVg9twVQuybyjqrm3345pnpLh2afIK7tgynkhjBULGTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by DM6PR13MB3954.namprd13.prod.outlook.com (2603:10b6:5:2a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sun, 9 Nov
 2025 18:57:30 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 18:57:30 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: RFC: NFSD administrative interface to prevent offering NFSv4
 delegation
Date: Sun, 09 Nov 2025 13:57:10 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <2602B6D3-C892-4D5A-98E7-299095BD245F@hammerspace.com>
In-Reply-To: <8918ca00-11cb-4a39-855a-e4b727cb63b8@oracle.com>
References: <8918ca00-11cb-4a39-855a-e4b727cb63b8@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:610:33::6) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|DM6PR13MB3954:EE_
X-MS-Office365-Filtering-Correlation-Id: b8abf994-0296-4fa7-853f-08de1fc1d534
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zQSkkVFk3Fcjb7HXXje7AzQunyKXEWL3zsLxrJCT9kA4fFqGznh9/rLmsdSy?=
 =?us-ascii?Q?IOptsIZsorZ/MlgTZ8LvrsxHXUCE1POGo/I+jtyDyNcDe+82B8SGsK+6ejAq?=
 =?us-ascii?Q?aGwfOwPv3qdn0VSldncodPaUCvEWBHm2ExDfrdIWvkEZt2hDzeAlEz17lbgF?=
 =?us-ascii?Q?R5j2Xd9ZClTBUidkos5jkZK2DfC36eq6Fvhm7ngyUAb5V/tOX1HN+um89MAT?=
 =?us-ascii?Q?zNAscIVqdWsCedPZYDdVP7Gk1lEzCjTA+sMl+Z82Rs2wcoAZcw4rwkYv4SUL?=
 =?us-ascii?Q?cmUABUYwG9JlRNWiVvHV2dmNGN+7L2cXeOz5TwcKjNqtz1+0OiIKbBbJWzHV?=
 =?us-ascii?Q?ju3gCdGJ0ENovbsE4ZOnzTrUZazE6GcFomxP+DtyvWQx49/4ufmJiAN3M3xS?=
 =?us-ascii?Q?BQtrOxNDk2u+1FCALUPjGXmxuM02iIQp0gMIJAtImNg+xnh3IgHjA2n/AlFF?=
 =?us-ascii?Q?wGSR0jmcL2oDx8/aFyvGp+Sn6vUfhvNjhYHqU1dWwHobdDzmi3vzWH41kukw?=
 =?us-ascii?Q?IcAVeLs8iIHjYWDKK4LXUjhY0SyGTri7n1Lh3zTmLb5BX+frA91P+9p52u3k?=
 =?us-ascii?Q?AQDDD3T5524BUbls8IxIdxs3frtnssZU8nDtcApSorTAEp21qfg3rYKxSZU5?=
 =?us-ascii?Q?WlRa00sOgLIKBnpdH1ki54gtnUfjh/q0isP9nE1h4lwDJANTbQoKN6AZ1NcS?=
 =?us-ascii?Q?lGTAIfd1x40BI5zOz72uHNY9IE5E5btK83Wgmwy8kTRG4++rKYRvnFTHCsCZ?=
 =?us-ascii?Q?BE3UJS5uorRzJANZ1CYugGu/6Uk6QbPfmM6EvsJrCArlJlKPeuR2w7hzSChq?=
 =?us-ascii?Q?mP8VoaRw7wzKJMTKWm4BzP0rmMRwr9ZXs8kdQuUFb4eoqbWZOtvSWiOUqzfv?=
 =?us-ascii?Q?eNWFGjvM/yDGP8DdQWcR/vzD8R/rEx6RZP4+ArbM4G8dhvQkEsVrlH6nXCsL?=
 =?us-ascii?Q?w+8lMMg0+xF60nawYfOLFS/OqLk/avwc82Ri+24eGfJN6hzPmuMswBAtQjOj?=
 =?us-ascii?Q?FWBWVNQwg79o+E+dUUCiKzjiI1PixLGaeUrJCoRCzk2EfdFcgFXTTdQxbmCh?=
 =?us-ascii?Q?TrFE6B38CdeofSroHX7zDWNWcjpVzcwrD0MQyIZTiNHdQDjA1JVsf3AcsNjq?=
 =?us-ascii?Q?2nlx/j1HwlE2RDYFJhXinn2+wJ0vjexLM0KUVMgEr1jenD4ld6whiS7PaNwd?=
 =?us-ascii?Q?ZEKmN8YOv+dGLNXuJcCWstgYIKSpDE4bIpSI1pY1gzDTUf5Tc42PnNKmJ8Pv?=
 =?us-ascii?Q?x/jBw3t3tg9cgubLpK64oZ0HqI0sCRzvTWvGVNcFdF25gt2n8A/V/617IiEg?=
 =?us-ascii?Q?r+vKnjf/SnKwV3DANSfRs2KLLDNlNcS7lsKDVAkMNN+cdBaL7ILwkbVw+V5z?=
 =?us-ascii?Q?IdZ4CN5BXUndostyp3O5U0C5KR/YC8l/9d4kPO67tJduDFvKdGqbHTOk+tM3?=
 =?us-ascii?Q?FnYTq0ilQusrVq5shJrbuuYC9kxv8/cE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H0iaBk/kgbga09g+uV9l8m4LC0fK58N6i34nnxKgVXjqBd0yQ4dzjPyqUScY?=
 =?us-ascii?Q?mxeJTKMzR6u1nLCp9vTG1xneJ/adT0qBQaao54/Y02hYHsZQ+W6f+2JzpLJU?=
 =?us-ascii?Q?G9GVg0l1+sMOnGCLWORDRyqj0WMTqIy+pTjguLxD+Dh0n/EOq9kkvO5X6QMA?=
 =?us-ascii?Q?G3Inq8YJ/9EDIBFOWy1sQlCvhzHzFOMsQ0dB9IN68OmbYCLtUfCkdu/DM0FK?=
 =?us-ascii?Q?HoV8jHTjpUhkE+7wHokB2Zq4lNs3Qwdd4352nrUnVxVOqhxe42WVQsK90Dy4?=
 =?us-ascii?Q?V/CdVc6ov4acB3EGbZ4LqMgx1JrmmVTOm2k0YDWGsb4yw0ZRgeg5WqR241zO?=
 =?us-ascii?Q?riJxomUEM6e4/TPx0tyEtpgJITVxdVyyGddN2LXh1Dix6fCBHwZj0FGw/0bq?=
 =?us-ascii?Q?LZqSY1ZZsig2T2CZmbFAuftne+El4PmVLDkUoXPp0swqNFpE0yQ5JbBdE/PH?=
 =?us-ascii?Q?ZNCh92VXtKy/emtIooy44VVYFY2+/6jTMpHRRj/Z/FYi3cc6ERKswd7LIxlj?=
 =?us-ascii?Q?KEkmgwhQYKKNd6C7jLP8GDblX8NZmVpDCAkfwI9HyTPUJhILH6TekzqGMe/Q?=
 =?us-ascii?Q?mRl0MMuXc5eB7/RZrZIsyAtUQWL+5qiiishroBpBfykdtglpWt/IC81MCJW1?=
 =?us-ascii?Q?RLbqD7ScJrUW1+I3ZdrZBAbODdLjsWa0F+EuY8epgwXRilpbBniFjav5KELe?=
 =?us-ascii?Q?lX0b/f648eitY9rYZTJu3NHJdKPnHKZC/Ty+eM0MCqRsfSmdEwcjzapqCVTu?=
 =?us-ascii?Q?Ukb5PlgAkdF7C1ccScVaw0ROfPrNlrvcAb6GW21pfMEkvRpbzTgaZIzGvEN7?=
 =?us-ascii?Q?slPxhQxSgjuKuFhDHyt+dJZx34Y45Av8TL3zfHGOPk5sl5id94Ch+8PBdvDc?=
 =?us-ascii?Q?CU7MNYOqxTfAu7m19hTfYGjlaqLvNJitEfxckQLD533sI98Sce6FrfsV22cE?=
 =?us-ascii?Q?FonkGs6J7GCnOlsPdr4gpiEpi5wn9zl/MUUHbiu99JeAQjy5G+co8YHs4d66?=
 =?us-ascii?Q?kKj85eB1YYeuNgBKLRNmGvV2MepKfPRfRFo/BTO6gHe0P54CXA4b75MQUnGR?=
 =?us-ascii?Q?uLXwqzy1PRSSblLibXXpQQk922DZH+eW28Ev9s88CV8CLGhPECfW7gtqassQ?=
 =?us-ascii?Q?eX5UDx8vnqdcTFphnWnKt7Fu2Cx53I2hfDPewlS7Pkr78E5pgzcBiBL7CVib?=
 =?us-ascii?Q?/2OCWsd7eDqicZ9mvfWpIzgTKRAZNlSjtFsve0Akhw7X2I5N7BZ/9eEc35QL?=
 =?us-ascii?Q?EhQcs5aSbucFpvG9L73nn7FBGjuWEVfLn90tnv5wRDavyUIPYUa2TJ67c6JR?=
 =?us-ascii?Q?04TCvRr2Vmg5VmsSEZjoijDL2RWTKb5iXAvr2dvOhR5l2YQdKOtP0J0ltICB?=
 =?us-ascii?Q?g5FQSKIWzCVbSiKd7T9HKHRpVezVGFOjeKAF61f10KCR/mkQxNxwPS5qlFMV?=
 =?us-ascii?Q?30gtvGR+lL8D92LVdSemeH+ZQBwXwpgV9wqoQBde5qKRpSLOnErW/MAW3Dvp?=
 =?us-ascii?Q?/kG99HWm0f45EpYqxC517bBRFTqNLMGs4oXFpjKOSXECtz+MmNo8jVS00s9T?=
 =?us-ascii?Q?ocxljMszPIX8sdBDYq5YFJrnwzK3qwHUI++jLge64J4sLfUNGgWHhAROmvHk?=
 =?us-ascii?Q?55N99i0729Hh4CVogJpG0MY=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8abf994-0296-4fa7-853f-08de1fc1d534
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 18:57:30.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHdaDiPeNSqqrmRGECRvUpQbWfO+D5YT6YlGseVfHJeE2enbBTLxqCVw1twoQF0PeTgaiFS7w9PFf77OrtJBkLH9+L3GKjtVHBhzMq7vSp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3954

On 4 Nov 2025, at 10:54, Chuck Lever wrote:

> NFSD has long had some ability to disable NFSv4 delegation, by disabling
> fs leases.
>
> However it would be nice to have more fine-grained control, for example
> in cases where read delegation seems to work well but the newer forms
> of delegation (directory, or attribute) might have bugs or performance
> problems, and need to be disabled. There are also testing scenarios
> where a unit test might focus specifically on one type of delegation.
>
> A little brainstorming:
>
> * Controls would be per net namespace
> * Allow read delegations, or read and write
> * Control attribute delegations too? Perhaps yes.
> * Ignore the OPEN_XOR_DELEG flag? Either that, or mask off the
>   advertised feature flag.
> * Change of setting would cause immediate behavior change; no
>   server restart needed
> * Control directory delegations too (when they arrive)
>
> Is this for NFSD only, or also for local accessors (via the VFS) on the
> NFS server?
>
> Should this be plumbed into NFSD netlink, or into /sys ?
>
> Any thoughts/opinions/suggestions are welcome at this point.

Happy to read this.

I think this would be most welcomed by the distros - there's been a lot of
instances of "disable delegations" with the big knob
/proc/sys/fs/leases-enable

I'd also like to be able to twiddle these bits for clients as well, and
lacking a netlink tool to do it for the client the logical place might be
the client's sysfs interface.

Would you also look to grain these settings per-client?  The server's
per-client interface in proc has been fantastic.

Ben

