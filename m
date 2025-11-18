Return-Path: <linux-fsdevel+bounces-68996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB49C6AECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4B4602D2CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF22EAB6E;
	Tue, 18 Nov 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="abNJZ9mn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020075.outbound.protection.outlook.com [52.101.61.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04623612F4;
	Tue, 18 Nov 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486252; cv=fail; b=V4/IbrBH/EG5DiwM5KiIm4ScQp93cW3VyC0A590qngFiZxMwbNczRRhptjpOwaRZN8eLoKIiokbs+gbLTq09mwsupSb88QL4bTMiAc4RAeYUiCnYjStB2WxwiCfYEy4AbmsCSO0E1HxoJzJ8IyCkCiRvW5B4LAcokhfDPFfgQzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486252; c=relaxed/simple;
	bh=Y8J3XA2HIrvCwFB3/4quzmaLrj8YtbNJk4EE7o0eU+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baMSJFi705W6TQMizhFDgBCyeyKpegGpG5jnxo8NjKk3IPpvY6J16U9j64EEEU7O5q10vP9oA7r5gegu0/33Eg3brlVi/fV1cZEoPERMF0gtHXXU+jrAZejLG51iWJhhKJ6aHcmWo9qLDb6qm/quOr4aCJ7HXcTaekcFWUfobfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=abNJZ9mn; arc=fail smtp.client-ip=52.101.61.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1EolDX2Wn/ss9p4HzKDyVcnQsjN0Y0OWHQtHZMFZcYr2/dKVgRZYms8xJ72l9fSFPYkOuvwESoyWcFXHuJGUFkiN6pTGpfZOguz2PcMLkSuzJriJFib08BCD4aYAmQr+MpTR9T3S5XLIHHf+6P+j1LwlXJ/Y2IlP/vf/gProDdm/ORsuFzEVYniGsdcdq+tQ+utuYBRLc/sbuVUoWPnnIZApVCuAYFht3H/4HLkXO9SHhyr4/85NgEa/cOb66VwoS1KuOtN9240/zhYGP8q4GEhLGaJ+A3R/aa8nKHeNEUwzidXbZ01jzSrYbBeRctZB9HzYiqqgWMVBSG7PryTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FamBnef913+pgnwJ9ab7nvBW9a5HOk9S0htmeeEoTGA=;
 b=YQdMwTLSmx3r5pyuquJiUX5bQ8gmAPFLYYmfFEA7D+duJuJ2bcGgZqtDxX3GXgld60oA9cpl5XDGdEzWx3YIlPI6/7nz3K8Lk91FDfm5FE+nW/UhU3YH43qS852MbigIrCJv+y5MFVYmWsWqhPg7UJSxNGC66x5he/DhQ5wQPhgh+TsgjHkIphpafl0dDwBn9z3wOuiYSN/MSTEvSKH42hqLWwBRx+XlWCv5JhFhsmx0VAVmDoBVXc9eXoCsqmyhFoNpwaDMgJqqLzTHh5smkzJOorBSNY7MitDvpXiguyxGaif9j3p05YMI3nrUmI5qPRbcM7xvaMpE5Rqj1CCeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FamBnef913+pgnwJ9ab7nvBW9a5HOk9S0htmeeEoTGA=;
 b=abNJZ9mne1PFkSVlUxNDSi53q/WtvHbihSJM6hiyKBvnljXOHVoL4EcRVfjz5D7+e9725aH/myuOTQEo7xBrMyhn7nXkLdAH+1kJs2ukKTS8Aqjsvma75g8zitR/X+kQZ4EHXxX+tFf8g7UE8c34LspQPUPPmuufsLCsCD5XVRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by LV9PR13MB7549.namprd13.prod.outlook.com (2603:10b6:408:367::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 17:17:28 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 17:17:28 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v1 0/3] Allow knfsd to use atomic_open()
Date: Tue, 18 Nov 2025 12:17:24 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <5765310C-1F30-465A-82EF-38FFA7A20E7F@hammerspace.com>
In-Reply-To: <050d60a8-7689-46f3-a303-28e01944b386@oracle.com>
References: <cover.1763483341.git.bcodding@hammerspace.com>
 <050d60a8-7689-46f3-a303-28e01944b386@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF0001330F.namprd07.prod.outlook.com
 (2603:10b6:518:1::a) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|LV9PR13MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 032e660d-ff97-400d-709a-08de26c659cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9B+RUxIakxExoKkp8QZ3oSJ/nRDdsBWZzGKdycbfV1lxqTLfLPhkrBpl8g9?=
 =?us-ascii?Q?tf5nhgQfQPmTHn+Z4PKieGW8zuLGeB6nOl4nUdCEZztZsgRIqznOXcgai1Oa?=
 =?us-ascii?Q?rEjLqpnpRNxDnI94xxhK5umNN0pXdT/zSCrN5RIJUkIjkAqugpDHh6msWi3p?=
 =?us-ascii?Q?txvdpqE1vKpojBYSXMKRsrSaz2ZalW3T+8k20aiMVBD2PsYjjXXtNrLF0clt?=
 =?us-ascii?Q?2k1ZPtDl5KQBU2z588fTDsQRKMBue5tklghf9RhU7EUL57BKvOlx2YoWyG47?=
 =?us-ascii?Q?XJg5398aid6URAmOlLVHRM7JP0CAJgQWwoJoKxVi+BomdvseZP/+LG9Tg639?=
 =?us-ascii?Q?vYRU0rO3v6QIdpTGzT1xPS9bcx03CkAq/2FXlht2nLfj8HcFH3SbrSsjSc+3?=
 =?us-ascii?Q?3x/uCjtM7ziWCcEbf+z+e8r/0AI9DT0s0t1YLeWFnVxr83GE681Ksm5Jtamd?=
 =?us-ascii?Q?ZLZ/34cY6dub51D4DSt3otQp9iZGKDmyPtX+a+SNkNLLw96FtTQbY80YaPvS?=
 =?us-ascii?Q?AHoEoWFlcLtnKX9b4t53UfYgF0uLMvGh+n+QDX2MBFVDikhmsENtJeRKi5QX?=
 =?us-ascii?Q?DgGJYIJI2hpFoqaSs6dn2ILPvePdIOmPjEye2jyStJhPl4e8/0T9mUOspMqQ?=
 =?us-ascii?Q?KWwmQgQGq8OrVLOnS1jhYB9xcUqRBo8gc20xGbDcpALTV4wv0+LDfE2iRsLx?=
 =?us-ascii?Q?SW8uv22yJvDilSsws1Hv5QCUuCNFGouDHwux+6Kel46dfTBXb/eBlwOMlNK6?=
 =?us-ascii?Q?mLFqL19SeO+bMTQkP1bOwiVDoJvY49aNqLdMZNWtE88pcYEtPEr+BBAd3fma?=
 =?us-ascii?Q?pjAw4oC46M42F2ZdLfzpmvRvB/hVasXXhh6HIlyakBszUsEA0Ucswv2Nc+1C?=
 =?us-ascii?Q?wH1NvyECA4DSyt4dj5FlyeUDQ1pe06QvYx+yLxN0hjR5Hf1s5KAN0vbZQuTD?=
 =?us-ascii?Q?c/DMNn8X9tiBmdDHfUuOxVCxm/WFAQkj+SiSs4JjR7VWVW6a4QJmM6Ih+qyD?=
 =?us-ascii?Q?N3VfVJ0cxwPMcj1quTx2ZDgQFseoDcWnWtIxB71PJ5PDz0mo6AvIgUg2EpZB?=
 =?us-ascii?Q?zNd8hxbdlpNFx5neRlezN3USBbKfp//OKo4xzYUOzXAz7rR3DroxQHAz0vVN?=
 =?us-ascii?Q?GpB6Nelp/TYzO/Ra4034HXbeAMHoqgIlJDmDBoG0BdvOoIe6b6DFC+7Pfl5O?=
 =?us-ascii?Q?HRguXuigKFfyxYKU6Lj9L0rAk3AyyxrwukhcIYdIbCiXaVLvluJ4TdufbzD5?=
 =?us-ascii?Q?aJgP59o2Hjqo0Je5hn4WX2ykF20XGNCJ0SUxW+pYB+0jmjmwWb5Xee3jVXLi?=
 =?us-ascii?Q?t+HnYq+vasGYLI0P5dvj78kWGejUyK3ByhOEa5P/fa/jDJ9bNtbJOR5rdZIn?=
 =?us-ascii?Q?asoq3C1wq25+CkhKqb08mNRrpsPgttAX8btrRQZV64l0FfdmQPaRNgLWlZRZ?=
 =?us-ascii?Q?o4kpYDzXbljqTzijMH6FGWDF/BV0Dci3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lheOAfmwjvKosb3gTRWB9kcRzrDWVp4aGHWgKK8WgYOfUi/jYwwtbdeI3DKk?=
 =?us-ascii?Q?vA3AovofJUxaN82w7JFBe12q+XOH+j3pS7Ogol/E8VBY14bacvs2jDhS84xa?=
 =?us-ascii?Q?PjZP5VUSQJ5wyHCWj4jQ7DGVAUU6JdQkJEeUZlFbmBnx10QFTqUyPDOjR2rU?=
 =?us-ascii?Q?x8hpEyNoyTRCcnSNM3iwP23/nuOY1AMiodQkaFYi/1SrMvjSXeFi8z0mhNhB?=
 =?us-ascii?Q?b/U69+PXIdAklLc0QFZSunCiMyYhiz0xmAGLsfpTlIhE4j7OMqN4M07HHZtU?=
 =?us-ascii?Q?jeNrM+/qkMpk2jMIaTlpjyjKaan4lfCkjX0LWRWiCPi2ZVH14+T1DakeY/O2?=
 =?us-ascii?Q?OhG2HweJyJb2orL/PpELymBnLI2HkO+emkAQEgdZ7pBO9DDLKiBVmGRWgQ3y?=
 =?us-ascii?Q?RVAYgeRJxt5N5WH8Vl6AJASan482tixem46EKGCuN3Yo/DGiEHemnkA6/gEf?=
 =?us-ascii?Q?Iv+nIe5nkPr0Azk+ZODYDaAi7y9lx7mh3HUpFqsT6DqFiz1wgx/fRLwgACZJ?=
 =?us-ascii?Q?XzEK51pV8ygY0/mLHQIrWVTOiPCNjFqxjLZrUESxLjryCCc5vuxqIK5e0HgE?=
 =?us-ascii?Q?NuzzPY4I+t8nMntEZQWTSKrfijhiFZlRzKUiSsgkPO+XdfQvK8SJU8JujZrk?=
 =?us-ascii?Q?yuCzDbscEnIujFYcKu2Zz61vEfapJcKGQlpuc6msSCWLff2a6KWlU1FXAf8s?=
 =?us-ascii?Q?b4IpwguBcS/K6GFZgfTMcQ5l4blB1miMjaDaQhpYIxtiXTncZaZ68qgz2KwU?=
 =?us-ascii?Q?anfZoEXMfZO87+mmvVShwxr0Hx8GIPFU+Ajp/HjsDnjvO5GnjvoNBILEjjrL?=
 =?us-ascii?Q?7rgdsA8pBCXl1M6JFV4yvIgqJwrEkLVPPF7+OsKjKjDf2SPnf39NkaML0QF0?=
 =?us-ascii?Q?yRQDZjRErmItQNQDxDvNntABfBo+RcKV83G4oVOaH9d0Ijx2mBf7YEtlAXAi?=
 =?us-ascii?Q?0BTvtbCClIpArcFSJ72C7hGgPUpN9utMZ22H1qldsdLX86+pZ6dMT9qCXmSN?=
 =?us-ascii?Q?b97goCkp73qM42D/bf3Hhg7KlMAeuh35uRbnjenrZ+DF0ozFmhiixU1e4RtI?=
 =?us-ascii?Q?mmrSdNwbc0+HHKK+dcIsFXI03fzLNh8PUyVK8QKPpxbZHKSIQjLlPUUHDO+U?=
 =?us-ascii?Q?9IbqDxE0lqq2xNszT3EbTjBUJyjsBw/IWRaOsHKavMZpaQ3ptqwWyzJIczLr?=
 =?us-ascii?Q?SqHQkWT9chfIYmyDigfJ2mIjg9ojDoLYoSgeNZnN7ewqGCwDLFSS8pFBrmqX?=
 =?us-ascii?Q?GMOlOzLGUhFplsArknbpu+1j1OjuRYVaW+DgWnHBU2jXWFzVL4hDJ88NhiB1?=
 =?us-ascii?Q?XNgwW/C5DuhfVysnd3Lr7UT9K48c93iWz1fKyAHfFxNVXAfI4OKYJRcKg5oo?=
 =?us-ascii?Q?XC7oxmDLJiJW7xvhMgc/QBB/DqY4+n4f9/Muv0jGsnthyWHKC9+llviioy1a?=
 =?us-ascii?Q?rmfp8qxDXOB7mcpTQCQNJqkS3Hjmj6iVJAQ58Oewg2XFpqWgU82FUSKNix1L?=
 =?us-ascii?Q?D6++vyQ0FyNIEe3N6i1nXAP/5wTsIwIARK4kkGvA4nYRnYhz/awnPN6RhFse?=
 =?us-ascii?Q?SnSk8Tor5Xhwdn4w90tdtUyfOQuuN3BmKY4/2djyOoaETP+PglPXAC3+NMn0?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032e660d-ff97-400d-709a-08de26c659cb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 17:17:28.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5aGKxPgPYiGmM9pwib719uBOQ1afB133I2XCFmncy2wQI45UdpP8FZ6wIPMm2X/dS8wRDmIhqn91dfEB8F4gZU4l23vX0LuhmGoUj2daIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR13MB7549

On 18 Nov 2025, at 11:58, Chuck Lever wrote:

> On 11/18/25 11:33 AM, Benjamin Coddington wrote:
>> We have workloads that will benefit from allowing knfsd to use atomic_open()
>> in the open/create path.  There are two benefits; the first is the original
>> matter of correctness: when knfsd must perform both vfs_create() and
>> vfs_open() in series there can be races or error results that cause the
>> caller to receive unexpected results.
>
> Commit fb70bf124b05 ("NFSD: Instantiate a struct file when creating a
> regular NFSv4 file") was supposed to address this. If there are still
> issues, then a Fixes: tag and some explanation of where there are gaps
> would be welcome in the commit message or cover letter. We might need
> to identify LTS backport requirements, in that case.

The problem was noticed on a test that did open O_CREAT with mode 0 which
will succeed in creating the file but will return -EACCES from vfs_open() -
this specific test is mentioned in 3/3 description.  Insane case, but I
suppose someone might want it to behave properly.

Thanks for the commit pointer, I will check out the BugLink on it.  I will
add the Fixes tag in the next version if one emerges.

Ben

