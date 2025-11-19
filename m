Return-Path: <linux-fsdevel+bounces-69086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCB8C6E960
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D73CB2E023
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472835F8BC;
	Wed, 19 Nov 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="R5cdKvt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020125.outbound.protection.outlook.com [52.101.61.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20435FF47;
	Wed, 19 Nov 2025 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556413; cv=fail; b=dhCvLhBlQ03CHWOlTidpagNQHvYgQOc7WXav1gm7l4oSBHo1q09D7gBzv010orciR4102gO1XctnAPBgRoDAjgxHI6nYBV9x8U0hKL9GnoKdt/5rvcS5ytFM1E3Qklvfp6nA7KllYIiEiPVc9gn2iTpFZ7sCWASUPhQ0P7o/jSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556413; c=relaxed/simple;
	bh=D9PUjxbEiMTrUSMk4l66BWNiH+Q6KLCmau40oATESNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pTaoFnFzB5/O0fytPTODx5AvrD1i6ajbwrn1yVTj0Yu4kMrhclgnHhIm5hgzMYKcIIJAX0WdK2kxbMmE3SWgfUN02gFVAE9fUv91ou9s9xVO/OpXYjaJ/Qjch3RapOaaU0ZRZaB4BN6iF3hrleums3ancxpDP0CaTR56IFspllM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=R5cdKvt2; arc=fail smtp.client-ip=52.101.61.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbAx1KfYaV/Khj5mhnCAgoYhCsfag3uTWK6nss6DAPCoqu603HjnjOmWbOqklAtMN5Mh0WZ2G23PWljQdd9awCvcP1KlSFIepQDKezlmUKsxooSWWffR8IdBofMMtwjYdsiLtHIdUt/uF8LOrjksxyf0tsdBoc764dDNxAibYNb+IAtbl+zBjoYDQ5a34UxQJp2v7bYSeP2nECV29OtTdBI+j36MrySTDloeUF+suhwoUb3v4lbL9n/6fpnT6coOc6SliC+GBOM40BmSKtOMsMCTddUFawRZF+PK9GprFl1Xiwzbdf1gDn3k08TZGpVst//KZwfYWlQosqa5YAvYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hw3amHdHdwbYV6NEFGKAopJGhUsvLI59J/EyJaN/VJk=;
 b=LFEvLQ0o4IKeQvxFV1LAhRFm1AcBi8DvQO8v8FnK0oT7p48xZzJ9qlBvtM41VWlTv0CLN2SsYN8qD042ylhgGkQs4aMSGpQyw0KR1gmywW7z3QAu4ibsAhN5O4h3/ym8e2QbqFWfe5GvldHn9ASkUo8ULhtekgu3yx5MFsdDsCS2md8nDHKxoBGR0HnJvgWecyftkcqqWIxeXB8r4+dKew6GCbgo/9eo0hbNAABL4mc+FE9omRS9cliFogK6ee+P/8Rki5ospMj8hNgALvwYPfFeO2z/OzWy3ByQe5PtJNCELTppvc/kfxqRvl81DKJ5ewDmkdWz6XR1e3eSJRYlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hw3amHdHdwbYV6NEFGKAopJGhUsvLI59J/EyJaN/VJk=;
 b=R5cdKvt2oJb4sYw7GNbeQb1keRTZAiIzGjSQ6Cm6VS3ve+xFFHIN+PNgFU3cL9uQwM+0ccHJwUifTBvb1a0BUVlRDCng3BH9fps1d4Heoy08ws+cdu0JjRtuD8zz2jml/7Hkfls/hebL8A8knlRd2BG8Fi1OYkkubRZSr965m+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by CH0PR13MB5097.namprd13.prod.outlook.com (2603:10b6:610:ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 12:46:47 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 12:46:47 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v1 0/3] Allow knfsd to use atomic_open()
Date: Wed, 19 Nov 2025 07:46:43 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <0C9008B1-2C70-43C4-8532-52D91D6B7ED1@hammerspace.com>
In-Reply-To: <176351538077.634289.8846523947369398554@noble.neil.brown.name>
References: <cover.1763483341.git.bcodding@hammerspace.com>
 <176351538077.634289.8846523947369398554@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::17) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|CH0PR13MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 382ebcc7-4bd5-49bb-315d-08de2769b390
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6HK7W+bZfJUUEvL6S5LFFft7mZtTzWhk1KH/5udZrkslJYX89tqcPwGNUnEv?=
 =?us-ascii?Q?LJFyrEsf4qeVb/Z/WocSxM97hrF481DK4rrcyNXsqNKymcBvV9CIYZVK0Ymx?=
 =?us-ascii?Q?YWLIckXx0nj51g3dzgSrWYx+CmX4e8dyj9QQsTmQRZM45oJIZ06yIP1+0Aev?=
 =?us-ascii?Q?OT8xeEet4+ybWoSdbo394WgVKhf2RqKDmIpZd1Euc6TlW5crDUrPYjO0hCCj?=
 =?us-ascii?Q?B1ldWKtnbghcxkuEbXlE8NgDbpQkDc8msjS2kwg5+dGC7CmqPx0ajB9JY0eu?=
 =?us-ascii?Q?n0Y7A+mSTZIv50eWiZYrjpBmY3s+1gDSfA8R4mvFWk52qUsWU+fkHtQk6z46?=
 =?us-ascii?Q?UwLRs8TKB5E4IgWdw/6UvA8qg/l5N6T5dLarOI+o9vnR7qnbNU42fhNy+Lw7?=
 =?us-ascii?Q?f6Wf19lU5oWpGvxPFYcH4cOmQdnOBssYBv5Sg95qMjNyQ8Z8CfDutbNM3hpC?=
 =?us-ascii?Q?v57OZB23vlEffXZy4OE1ybRxnQb0QATFiaAQHe6Nb8/rBSQSSqXmN2jWJnMO?=
 =?us-ascii?Q?1HIr1Rg91h3CqlzbBNS5lB7HgP7CpyecnnFgliq7/7Lw6OoUR58o5YeZVcVy?=
 =?us-ascii?Q?n5zvlgfpSmpBT8/3VJqZB0+rF2jCbtJkOa2WHQYRhsqsIJGsB0uSZkO8QiPW?=
 =?us-ascii?Q?1nVp6BVSWiQQoPbCb7o5CzmLKpospWwuAedD9xfgR+2BllYXY+gM72ZXFPWv?=
 =?us-ascii?Q?dkLnx6D4RbS63o6iD0XaFZJTqrudkf9s3XDl1boDvUGpFRFpglEv1Nkrvly9?=
 =?us-ascii?Q?nP+AENqXHapbu5QE1ZH98Frd0ocloNxic+phNwSGYqyJawIgE2HFwx4OK9V+?=
 =?us-ascii?Q?V/IJqgutknX/sjLIfvGP+rfrQ/VOCzeVvQLc1leAOce7jcipuJpIHJ7mKihO?=
 =?us-ascii?Q?rlIXtGIp55tH7I7f9p5rC9qzwvX4gcNZosyaabg1rR0lq3jUO7Ubaqe4p4yL?=
 =?us-ascii?Q?hFTwhfQEoVMWZe48n1WX1xAzXg40NDOPzNcwQEnX3YWifXB/5uhEzla3z422?=
 =?us-ascii?Q?Xe7uB+Tb0C8bDFAbeZynww4sE4vBPjNe1tbPZCApKdq7IEg/NvufFDW0NcBp?=
 =?us-ascii?Q?XRMqIUoUhDEQNEzcTRGCR6I104MRIMF6nqceFuMh6OyGlX69ZPdWxUOssuk7?=
 =?us-ascii?Q?WZTipLkwM+qX+ik7ykeJZSiZ6lEpnsEqWSWiIJ5hal+C6do3HOUVTCAeICfm?=
 =?us-ascii?Q?8BfQYFb7jpGFYmwiwmg7ReI+aUJUnwqghwKE2n095taun+EYY4jV7+Up2gjD?=
 =?us-ascii?Q?wYK0fIE/4MuUaWodDsHyGaF6VM0Cdh2TdvnthquHPIjF/QITe9qFECua7TqG?=
 =?us-ascii?Q?QN+BPS0yZPw+EPNGhrxPav4vWl6FtXXlfdwMbaEEZK5pN/ozonsYPNEBJx5n?=
 =?us-ascii?Q?v17mx5vgAAwtDZQOl7QozIptrc7YO6ePKZxpfbI5hyGty2Gwh9EtBqUNXFYc?=
 =?us-ascii?Q?byMRrQbzDF2WnYQQyNgkfjQ0bB4RUb7I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DE158B6BaUX+eC/YH3P910rs89XzIjOZCnq7aHylj3KvuCgZ4tP+51m9EcQy?=
 =?us-ascii?Q?C8ZHU08AqxnG3bztwRhmDkz5FZzhHeYTXdgyIvMCbzpPw1GywsfdvAJExTsz?=
 =?us-ascii?Q?MLdcF7w5fySxDqkXvlVvZAWmgUFowXSo5UfrCmnqKayNUiuzK4nyECRCliEx?=
 =?us-ascii?Q?cvlXZLkL0YCNtDu4yTWUBxgJr6pA1uGrNvUIW7As+tEqtMFVQ4gmPw+2QZKW?=
 =?us-ascii?Q?SxtNxaq4MvMXCCRniLJamFFcS0WlNEW5yUrKfDGo0HPwT/t/yVUAjeKPiMRF?=
 =?us-ascii?Q?RMA04TBGGT0kKA+2yjYHXw8cPCDQmbYqu1+mrkwpS33E0Uhd6O/J7ynaZRjz?=
 =?us-ascii?Q?hnyAlilnk3Favzmlkgwa+pifUlJbuHv3/5/5m3sli6SY1qu+mgvP+u1NIKSE?=
 =?us-ascii?Q?FQFLB/y9jDKqKol795WzIQz6cy8MkP7j4USMNjitsUtAcNbKgjDQWoXQWjUZ?=
 =?us-ascii?Q?IVNQghiaJK3dheZ26wcW6c82sd8vGiS6shUInUlSuXSN93E7yqKNHQP/RgbD?=
 =?us-ascii?Q?mNoCzht4iWKF1i+nOzqSSQwCv9SASTTwTMthmoW0+Po+Up8Ij6JpQzkNEK7y?=
 =?us-ascii?Q?7hncEEj/Bea+IMd44JWBu3uVaruokMJzMQSKdZTSYiGAxMSQ8E1KsfPMG6SJ?=
 =?us-ascii?Q?ymIk0LVUlEAIzyJU1g0fQ+uepf0gwjXYN1QiPw7pJmVqQla+IuOapaLpLDxk?=
 =?us-ascii?Q?+MuZN9S+MYc07pwroo/rybtp3Hfjtm5lQOcZgdKXZGDgiNrTQoci3tn4WoMB?=
 =?us-ascii?Q?b1+A7EMDzlSOknIdAzbMhOlxl3bGdI5MLD8C6Af0bkH7N3Dpd9r1GC+nSsdU?=
 =?us-ascii?Q?uoOJwoJjQZi7PxCqps94r9COFY3H8xVp5ayiJFCuOc7SkOBwFMnIdd9h3eYT?=
 =?us-ascii?Q?ZEQ/L9phnHFGc0bGtWsbdaOVA2bn4hxKopKo60nwzpB4dUp/leBJzj30Mdip?=
 =?us-ascii?Q?awGQsDJJWtAG/f+/9WWjyVUxzK354gt0jb7Bz55bQS2QFfH76+jYzfGlfOnx?=
 =?us-ascii?Q?qHlUMiInNjAHnqcEou/GQCXJRg9Ea85NgI+7KF3AD0SF+F1szxF5VSKj1Oi/?=
 =?us-ascii?Q?OSaYxBTX2nmmE0pyWSrMs51Sh2CIvQ18iFoE9Yn00b1dKoJcGO24F0+/U6D5?=
 =?us-ascii?Q?BrzZ7sDLJC+5raMlueDvQHS3/HpuqIXZfujBXoKbaApfiUSudxYOUFHjFFCu?=
 =?us-ascii?Q?yabAeH+LUj2wZ1WOzm7JZ+vyh0FvKdfOlCne8PLU9nVNX0hau0lQ6Qb1EJh/?=
 =?us-ascii?Q?Rzmnhae0wDs37lINCKKR5Ps2ZAcR+RQMcL5Xiejxcjrmbq5+8wIX1HMsEqAN?=
 =?us-ascii?Q?BcaDH/O+8XNMq08K7gPyR8YA1yww7uCnqQZv26g792zhHBu1Mu3Z5MjrodQR?=
 =?us-ascii?Q?nm1tf3CjxyBvKypu5G/7lCRoL+VgUPOBSI49d7daoJV0ZjBRGnFBWd9LcM45?=
 =?us-ascii?Q?6xEfLo+VH9gw8WKMnvInoi1lzpxKQVIj8gmFLmisqTYiaRwvQkFjy3m0H09w?=
 =?us-ascii?Q?6E1Ja6dC4b/wODrOEwm+lt2bfKctVQ6uM9OWoHZfqANFudsolnDZvVlLtmag?=
 =?us-ascii?Q?FsASh7P6Wxl9WLVKqKnyHU/8+n8HYz9rWVKkl/eBMQZP124yk687i7JM8ZTX?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382ebcc7-4bd5-49bb-315d-08de2769b390
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 12:46:47.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLqqtvFl/URKwRjmcwW7XkmIG2uX/vCYOFmp8e14P2nygQmTpY4Y1gS5R1WHZE2xOgS5YrR/U9IIC2OellZ/RJqS1QCTrIrwl8eurtcLpgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5097

On 18 Nov 2025, at 20:23, NeilBrown wrote:

> On Wed, 19 Nov 2025, Benjamin Coddington wrote:
>> We have workloads that will benefit from allowing knfsd to use atomic_open()
>> in the open/create path.  There are two benefits; the first is the original
>> matter of correctness: when knfsd must perform both vfs_create() and
>> vfs_open() in series there can be races or error results that cause the
>> caller to receive unexpected results.  The second benefit is that for some
>> network filesystems, we can reduce the number of remote round-trip
>> operations by using a single atomic_open() path which provides a performance
>> benefit.
>>
>> I've implemented this with the simplest possible change - by modifying
>> dentry_create() which has a single user: knfsd.  The changes cause us to
>> insert ourselves part-way into the previously closed/static atomic_open()
>> path, so I expect VFS folks to have some good ideas about potentially
>> superior approaches.
>
> I think using atomic_open is important - thanks for doing this.
>
> I think there is another race this fixes.
> If the client ends and unchecked v4 OPEN request, nfsd does a lookup and
> finds the name doesn't exist, it will then (currently) use vfs_create()
> requesting an exclusive create.  If this races with a create happening
> from another client, this could result in -EEXIST which is not what the
> client would expect.  Using atomic_open would fix this.
>
> However I cannot see that you ever pass O_EXCL to atomic_open (or did I
> miss something?).  So I don't think the code is quite right yet.  O_EXCL
> should be passed is an exclusive or checked create was requested.

Ah, it's true.  I did not validate knfsd's behaviors, only its interface with
VFS.  IIUC knfsd gets around needing to pass O_EXCL by holding the directory
inode lock over the create, and since it doesn't need to do lookup because
it already has a filehandle, I think O_EXCL is moot.

> With a VFS hat on, I would rather there were more shared code between
> dentry_create() and lookup_open().  I don't know exactly what this would
> look like, and I wouldn't want that desire to hold up this patch, but it
> might be worth thinking about to see if there are any easy similarities
> to exploit.

I agree, that would be nice.  It would definitely be a bigger touch, and I
was going for the minimal change here.

Thanks for looking at this Neil.

Ben

