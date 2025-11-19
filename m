Return-Path: <linux-fsdevel+bounces-69089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E041C6EA7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 741462BA17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EFD355039;
	Wed, 19 Nov 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HWfssDlH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023121.outbound.protection.outlook.com [40.93.201.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCF189906;
	Wed, 19 Nov 2025 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557348; cv=fail; b=emzkBEHmVernuwd/YoUp4mhwK8mSYSVf/2CK+FztM9NV3Xf/oWwSRyc8exDhW6THxUoQwGHMQaP5p6RUSrYFhDHwDpPaiUx/EyzAQLlJ3lJAf3uHW4cSzT1xu4ZePHZgKa0UqbQHHRzlYCiO4RvqZXODBOlZXoCEAT4MwEfmvao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557348; c=relaxed/simple;
	bh=9r9myg1tYirY14DXePlhjLkTyCM6sjRDATsia0M5WxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dUr8ecHD3+OOdaR4ejxsY7LBT3wQIpL3u/xrzGzcYsvTXZdySRpDBhhDfmfWR7Es4l2GFMuWlhIbIm19pL1A1/iXK1yS+81wTUE3wEI0gicujr/GuDrz2RQdP6xI+67mTynPQM1FtyTupy3TwlFf34EppC2O15BVmZMGAwS7RmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HWfssDlH; arc=fail smtp.client-ip=40.93.201.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF93WFinxQ6mzUjHkibPItXPEkc7wmWKJ1xrResjXBUn4Q+wye8tnAuh80Xd1f6npYgoH7W51pUxZh271wRFNUQ0YPF3N0FUYCR5Cnw2XyJdXLC3ZdsHvCsjM2ZbRAaDorBTasubr7CMgvs792s54Acfou7ARFEJfXKukbTBtYtOasC0s6McKgTNuhLesEmskxNoDSXztA0fAKSZ87vcz4E+1OTih67Ifijns7WFFL+7NmXPuYZ7oO+ikaUl1YyXp09t4Y+t4iosabp2vTyVYwSr33fDIXdaTUR403vqATujGOBThRdPG5QigsfY4/9boUpk4uMWvEALES2NE270+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MlZPAESsX4PPuj3TcORz3mzpn2r/eid+4F2ZYtunz4=;
 b=dutfLPXYDmLwy1gNFiDCYXx9umORh02rSW/2wJc1/6apalXR009d1W/gKChPivG55k2NPDMos4Fs0KUr0KiP1kQIt2oWmlhGLcRFmWpstg7HAIT/CJ7hKkzEuVXHSpE7MS6OeXrrNA2x1spAZ9M8rEmHSTc1roqmdcw/xpFoJXAEBSoS7ZruN3hSJBxoCzFSbctmACWKM/UQD4a4ORRgalt10I+BKrndYGHcAFcCHqx4HUHlZv2UI5XVd8omXFrAioQ5vJyHDw66hMhVUsCWjLaH72c6prrbHeTCU+wt/lcX6upoBEABQGaDEnwJgSvbGSUFAr/ZiM0iGGHWqcc73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MlZPAESsX4PPuj3TcORz3mzpn2r/eid+4F2ZYtunz4=;
 b=HWfssDlHx0msQ6jTpa4GxrHUTTcdkWJUnwXoJewMd9l+JlMzJd3tSdkDtOcEJp0VrExDN0hFggU6/pGajb73pld8xoE+blewdT58TunxDqF1ne1hQuQvpZE8hFoaj9/AOYQ8O1jIwY9uFkOpIyKLQWCChRcgc/1Vp1aS/sdUkh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by MW4PR13MB5578.namprd13.prod.outlook.com (2603:10b6:303:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 13:02:23 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:02:21 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v1 3/3] VFS/knfsd: Teach dentry_create() to use
 atomic_open()
Date: Wed, 19 Nov 2025 08:02:17 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <E119B07D-4F3B-481B-9EB7-372FEB6203B9@hammerspace.com>
In-Reply-To: <176351650615.634289.9329113019464329973@noble.neil.brown.name>
References: <cover.1763483341.git.bcodding@hammerspace.com>
 <149570774f6cb48bf469514ca37cd636612f49b1.1763483341.git.bcodding@hammerspace.com>
 <176351650615.634289.9329113019464329973@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::28) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|MW4PR13MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc521ca-de31-40e4-f684-08de276be0a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8cCI/XKmtA9cWMYXVkmSyX+01LmYyjsiFdEFM8yCx+TZ8dK79I41Uo4RSBgn?=
 =?us-ascii?Q?B6M65dlESKgHOpNsteSxkFWFkl+DQaWXBY0yJLXuwHyO3BO2hF0DgW32BO1D?=
 =?us-ascii?Q?SDWIXiJ0JeL7E+MHPO+WKmaeWydqRQ0O0R+RqfELGgknpBG9BwOX4XtlsFx5?=
 =?us-ascii?Q?MB6pBGblpfQrTPLKBgIvBFD++6za9CxLrL9AA+5i9KJAgeHCM2X5vcZ9ZvAS?=
 =?us-ascii?Q?vbeAb9luLkqzpbD38dZs1RFFxNM1kWa2xrXyl7XNlBvdLn2uEPz3wHV4+y+e?=
 =?us-ascii?Q?q2ns1Dj5Y5ybuCnREyAXKypCFeBlstWtN8n1Z74ThQj/skH/GTpgRSsjWH4N?=
 =?us-ascii?Q?aMkAoNlnKRv2I+Cu0y+ChtwdQqonBLRmXX5Du2uteItbZSgELB4EVRzHw/69?=
 =?us-ascii?Q?0bl6JF/Dd+LohI9aErfKelWHNr1TJGo7IjjX5QE7HR726PyZ9cgkzzxP1ShS?=
 =?us-ascii?Q?h4xsjO+8N3alWZf+kFBktIYtX+XZ7ScCJaHjWCjFGJM+9DjSft0dc6Unmu8T?=
 =?us-ascii?Q?aQyIpNmS19G2YBaoDqDukEDGgfV8FQczP8y+lNiqaWj1BTIVIA3UDRdfpOpz?=
 =?us-ascii?Q?P4XLdutfKAzwVL+8fugtDtnMRX+StiXVghs5Vbtel0lel+MnyyZkr342SyVI?=
 =?us-ascii?Q?Gax+o4KU1SfkT9WRThcxa6AUAL8ceIijA7/JqvoZrzhqN+JIOH5sI2YQ3tN4?=
 =?us-ascii?Q?eoF0N+Qd/tPVUkQfoUklNWCNzVi0xRQSNrvZrcK6KczYBHUD7ryimfbfuBsB?=
 =?us-ascii?Q?j0y7I5v0uv9UgiLrYs8rWBSTfstCRTJocK0g6OzdMWKRZr6bTXO7k2SRxuDr?=
 =?us-ascii?Q?BgjOOVRPKmPqhlgFWe4GPz6GHEu1ilGToGosrUSFR3l+DzcNwH4LinxJbhzm?=
 =?us-ascii?Q?KnBtsadCH3A5kZ2hz63mKcnHuWX76H9zjRJwAIWYdjAKjKNoIHta2QIKiBFQ?=
 =?us-ascii?Q?y696/qQrcJrgCD8p44sP2Dxo5M8t8eJ8RxS+tpWGGN9gfHgmhC8nfDekkxGk?=
 =?us-ascii?Q?uvGQA1P8qHtkdfNQTNRPt9gDT/awbFftFNBl9ducUcp43UzlbwO2MvvdbUBJ?=
 =?us-ascii?Q?wKvpN+C8CGPP7N/I5iw608VN96ANLlPHZq20KxWJxAXrSguYdrf9Tn6zIrCz?=
 =?us-ascii?Q?S+HM5hroMxLeTPyBu/NmSBTDNNAYhCh5YpHarXhGlV22d4EWoV92J4lBCp9R?=
 =?us-ascii?Q?yI9GqkCs4vneOPl2q75p7bh5f8+I/g25xDmw3Chfqvg5+aDzaJB16KKzW38C?=
 =?us-ascii?Q?EbQvGPWjEXAYOmoqczE4EhU4KNbzmljpVi30Q0vuu7+8BMTQVVP5TQvuvhsH?=
 =?us-ascii?Q?PxveulhDoGBimDRpYt0JEnlHYSmqRwbe6I2TSXaA/o1kTg452j1tmwsEpgH+?=
 =?us-ascii?Q?wPYJZv1a+5ypdkDQdQjYhvA2udYtIzP9ICSdZxypjfedEHD6htSHeEpCgfcE?=
 =?us-ascii?Q?QJ03k30YnWCS6n7tmrdjA3IIo44INsSR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UqQ7rw48yElXJiZGDPhSkzhpdVp2IDp1VxOUJ9UuSzsbnBTzit8OIdTxjSeA?=
 =?us-ascii?Q?sdUuSZamHdAp9V2iGQwrXKvS8MxkO2xo5MRW72BgBEPvL+qOshVVDGYjeVn+?=
 =?us-ascii?Q?ofR1hmBoVJq4f1KUGjBXHWuYmIlj/6ikzlmFMhoqoJwZrCi1p1Mzaev1h2iF?=
 =?us-ascii?Q?+8/UYF5jwd407ZMf81Ls9RJvoZqOBqLJVT2ZTEsYpCa17QTDw8nD43UfQyDh?=
 =?us-ascii?Q?y/nwCl1zxZdlaukUXH2fCghFyU9Tm9tMl8IlWC48chnrgf0Y4tjy3uZmVWsn?=
 =?us-ascii?Q?TU++PfSs+in3vCRhFVXo/hagyegt0YoV002NOGHDtjCnKfAX3UvGGH+uSAOC?=
 =?us-ascii?Q?TAi8UUhs6fbtHfGEHX1sqIJBLQSRanh7tR+Tmh/sjnsZsTQYjP+ZCkH10tgZ?=
 =?us-ascii?Q?ykQSSJrPYqsu8nAZJ2O78+L92K8eiC8RaAmGbhXPofsMKjN1P+Nkpro3cP4V?=
 =?us-ascii?Q?6FgpGJlWKrhlWJ+sPuWddlxa06ttD8y7wdNbFiOu7HtuqSZk7Dpo/h6P/IJl?=
 =?us-ascii?Q?HxE0IhJVD+EQ5YFCYYFxWfA4oQDTVlguWIoCdpvKrikBpUIE3iKEpkPfqypr?=
 =?us-ascii?Q?AB76VJ+U3c44vrc2BURtlxMkoW+KHngDMD+snjSaDsARHFKJ2YcxLbHodY3Q?=
 =?us-ascii?Q?sl6wBZTHlexW/tXClIUCUtc1npg6D1lJ7KQpOAO8az7SubhzhHXLEJHOe/Js?=
 =?us-ascii?Q?12C98qoR/ll7/WEUeDcMo7Y1gG8YI3PcweVjFlYDEqCHIU4lvuq5B97fz5IL?=
 =?us-ascii?Q?xl/zJ6b08yMSOuiTv4nmbRjgLdEpSxhbDw5EQsYpsVCiHrHn98abaHp1Aeur?=
 =?us-ascii?Q?5xxvSGVeammtnMy60HZF3MfOh/GDVTDoaKiujFCkdk9Lq0zOD1IhpWo53rCJ?=
 =?us-ascii?Q?CW30bqbJn7rHv5WNui92SNC/rZshLXiOrddZmgbdq3PM3tgQfTR3KQp7wGU7?=
 =?us-ascii?Q?gEKxIbt3J24QD6TuKqXqjSUbzi7VKXXwGmNOB7W/K47UpnlHlqViIWNNbQ2G?=
 =?us-ascii?Q?oVq+cPqPDEXqJ6uCPu8UVXwG4TIuFe/xQCmsBu9q98r78F8+vEwSeNnfYEHI?=
 =?us-ascii?Q?381EEtKZNEPdcIPyD4FlFOdiZEn0dtOkZqUMPU+kD0tUgwQKPSFPiBce93mm?=
 =?us-ascii?Q?FxsBOEfzbHmMssYXpx12mJPvA7vqJek3DLSfVab4V7eSZRu/923ccyOfeEOS?=
 =?us-ascii?Q?WphhWaqwjUM9X0zeeMwDtCH2y4pxnuiBXsAfCr68tYlG1aab/C+4uvRiqqzL?=
 =?us-ascii?Q?o7TQ/xa5FaOcWkf2lg4K2XJ1enGsciapiaWQZHUgjpiI768SywPoKmC0CtVA?=
 =?us-ascii?Q?NpGpgQy5v5zn5f0T2GkAQW1vO4MkTG/1zKKM07MWNxBw/SvsChB/1uBtSZbH?=
 =?us-ascii?Q?ORv7sJGvpAXchkHKhO63ye7zl0GjH7b0Qmh4fGQ+LTaOo44j+3tu8fr0WtQ2?=
 =?us-ascii?Q?hU5HF7NP75i9TGEJnXSAr8kTv7yjWXcobXO/738KiJY47E6PdXOE7sZXAvVj?=
 =?us-ascii?Q?3Q24TYf4nuJtxqqT8NumX4woFtrzrfkJjfrg9dc2LBkRF/3ADVkxNCjqOfS2?=
 =?us-ascii?Q?H7WZiv0PnYnMCm02tjYBwaDZqzJZrxIyeFxdVtb68E3C8Aw04Ju7zrUajldd?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc521ca-de31-40e4-f684-08de276be0a4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:02:21.8056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaxPt4rTOl66b1X3QX7TGNq6aIH9XD1aacYu5A3avExmgE4DbFr9NtzDg9Ciew5XL2gITRTVNub7wrD7xsDkTlryZCv7YBCtzWGyWu7G5vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5578

On 18 Nov 2025, at 20:41, NeilBrown wrote:

> On Wed, 19 Nov 2025, Benjamin Coddington wrote:
>> While knfsd offers combined exclusive create and open results to clients,
>> on some filesystems those results may not be atomic.  This behavior can be
>> observed.  For example, an open O_CREAT with mode 0 will succeed in creating
>> the file but unexpectedly return -EACCES from vfs_open().
>>
>> Additionally reducing the number of remote RPC calls required for O_CREAT
>> on network filesystem provides a performance benefit in the open path.
>>
>> Teach knfsd's helper create_dentry() to use atomic_open() for filesystems
>> that support it.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  fs/namei.c         | 43 ++++++++++++++++++++++++++++++++++++-------
>>  fs/nfsd/nfs4proc.c |  8 +++++---
>>  include/linux/fs.h |  2 +-
>>  3 files changed, 42 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 9c0aad5bbff7..70ab74fb5e95 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -4208,21 +4208,50 @@ EXPORT_SYMBOL(user_path_create);
>>   * On success, returns a "struct file *". Otherwise a ERR_PTR
>>   * is returned.
>>   */
>> -struct file *dentry_create(const struct path *path, int flags, umode_t mode,
>> +struct file *dentry_create(struct path *path, int flags, umode_t mode,
>
> I don't like that you dropped "const" without telling us why.
> It is because we not assign to path->dentry, which is because
> atomic_open() returns a dentry....  which will only be different for
> directories (I think).
>
> But do we need to update path?  The returned file will point to the
> correct dentry - isn't that all that matters?
>
> I guess that I'd like an explanation for why the const is being dropped,
> and why 'path' is being changed.

Well, the first reason was that I was embarrassed at all the new local
variables being added and atomic_open() wanted path->parent and
dentry_create() already had path->child, it was convenient to just re-use
it.  Then it became clear that nfsd4_create_file() really wants to clean up
(or not) the reference to its "child" dentry based on whether the dentry had
been consumed or was an error - so passing back that dentry rather than
re-arrange the tail of nfsd4_create_file() seemed nicer.

Its true that we can acquire the dentry from file->f_path.dentry, but only
in the successful case for both the atomic_open() and the
vfs_create()/vfs_open() path.  Atomic_open() does the work of swapping and
fiddling with the dentry refcounts for us so we don't need to check, so that
is the 2nd reason I passed the dentry back on struct path.

I don't understand the cases atomic_open() is handling here:

3555 static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
...
3568     if (!error) {
3569         if (file->f_mode & FMODE_OPENED) {
3570             if (unlikely(dentry != file->f_path.dentry)) {
3571                 dput(dentry);
3572                 dentry = dget(file->f_path.dentry);
3573             }

You think this can only happen for a directory?  I figured VFS trying to
work around whatever might have happened inside the filesystem.

One thing that's not happening is that if knfsd /does/ get a different
dentry back, its not updating struct svc_fh->fh_dentry.

Ben

