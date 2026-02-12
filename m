Return-Path: <linux-fsdevel+bounces-76990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNtQLiRkjWn01wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:24:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DFD12A62F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA9A3112F6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 05:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3978284672;
	Thu, 12 Feb 2026 05:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="LksmHf7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023102.outbound.protection.outlook.com [40.107.201.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87319CD03;
	Thu, 12 Feb 2026 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770873878; cv=fail; b=aT21PxnUPU49omIO+hAQilgsTjK2iQvuntVEnzVO0N4Shh3kErdObQKNw2G4gdWOhVjBwB2FTvIb2iiB6hMC9m3UflxYlQOXlmDspson8jHXRWliFDcmtQ8mNaLNUBMZgqH2lnVUJnOh3fMhTINNEYDY23io73mv9idp/q4R5GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770873878; c=relaxed/simple;
	bh=sMoMx7aF+GaGa8cxjbV3wTYBMSHf2jgtErJTHJ/PWA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pmpbzmq57qR22GAM+jsY96uccJN/ENTtbbR9QBUO4eyxqIRzw0arxb2oPDqfPxX5vUhl+KEwfNrLgpcix1O0xvgnP1zJGmwW+7PxZksExE/GCOc/HPO/e054VwFX/EMueeBtPigC2ONFdxIM55QK1samGmTaSEp4VM0ohgo+Sck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=LksmHf7S; arc=fail smtp.client-ip=40.107.201.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLbphD8aNIkSz+j4xEtxPYrbFDG8MEqcoeIhFgI/2jcmtQYMZ/iGzamsAOEuSth27UDrjesOmtT8J2t+Fc8gst58oQ0JAtalCaCNVi+SA7UGYPHwxCB9Br3S0zghOA2fvOpKqEaFqvYHa4Xyet3R67dVDg14On+sUvguHnuqnhAlNYU3YArnmyxvUkune4uYL/GnfzqgkykX/Y6ppafB2Kvhl/JP4qTxsOVxvp9YoZJdNSM3S5f64eaRQ4osLDMesDL7lHHple89yH4+mhYk1sbXzyPfaoMFkP0Iz3v452dWCZPjmU8WjMt1/blwaaatipjJwea31rlTys/3HfwqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFoZlwgvVG3GB8iF4iwId8vlRfwYEHlqdFwiwRxyorc=;
 b=p4lUGx6ppyq9+9kakghkmz1dPae03ehEcqrgUtt9AV/j2zh+/7dqiUJcpm75B7nJQOCZHgJEFDnfdkdR+jUcUbCPG3LzUPaZISiZcx2ud5K6aAvdhZFjmIpkYSxLb5zfWYevJ41Xe2BeSUaX46ZsqdKdyNR/KmSs3yvNy0uHI5vaniQTs3hA65sWOAwYTQWMVX1ZJ+nTqu7WyHLJeGOKDGvarXckrlr+6daz8BcYU0bZvtPQrblT+nHSGh6YZr/ztITvRFuEKy1eprlWGmWYsZUH6TLP3O4IKhi+cszDenK4sP3be6t9uc858x0PVbdqVftXjTVpry+FHhMG+5uqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFoZlwgvVG3GB8iF4iwId8vlRfwYEHlqdFwiwRxyorc=;
 b=LksmHf7S/UWdCukCaPogKkg3/7KBrNZ0dwU3tHUhu/FjrTOQLq74kQM7DyjiG+tH/XAzx8Ldj2sUqb3lOAaZuC5ZqbY3hP5/fPjKA2QyFfnLr+1qfxXL34ufg9o64rTsckODV9YL9x246VBbaOIsORVFeEf4Lb6UiwpCKA17JIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BN0PR13MB4695.namprd13.prod.outlook.com (2603:10b6:408:125::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 05:24:32 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 05:24:32 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v6 3/3] NFSD: Sign filehandles
Date: Thu, 12 Feb 2026 00:24:29 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <402ECD4C-8E84-4104-885E-7419A3F507B1@hammerspace.com>
In-Reply-To: <f75f0d1b-9feb-4a0e-8c4e-4825f59f8053@app.fastmail.com>
References: <cover.1770828956.git.bcodding@hammerspace.com>
 <cb46e1aee9656be5f3692e239300148813b5c05d.1770828956.git.bcodding@hammerspace.com>
 <f75f0d1b-9feb-4a0e-8c4e-4825f59f8053@app.fastmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0021.prod.exchangelabs.com (2603:10b6:208:71::34)
 To DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BN0PR13MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f0d82a-e83b-4fae-c427-08de69f700b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jPSMguXPDND0mlh6nvxbYcgFVjurLJx7WX20d/eQwPhdlclFXZ7PuoYFXSgC?=
 =?us-ascii?Q?1AGmAB9jI3gWPwoppcTwscbPS4HvifXV+By4FXFXdUL0BJ+IL3PeL153DLqQ?=
 =?us-ascii?Q?vGWSwsfeSktR61CvADJV/2SXv3ny6NF6rCHYjvmU9kq+GvyZIUX+zzHxD5DQ?=
 =?us-ascii?Q?Kx1KegDK9gCL88mk9+qsnN5HCea88aIUQ26LVpgefuZWZb5vgkSI4A9nV7nH?=
 =?us-ascii?Q?brNNxF07MotSKIqvazKstMghdAbSdoogm8Ufy3tTlcJb4aJY/ySgHl4aM0sy?=
 =?us-ascii?Q?wXePresS9JPLYWJLz4y3tIM95QeMIbE+X0FRRmBml0ckXxxUpdci4U8/9qYl?=
 =?us-ascii?Q?oRiwv0htDZUbQdscYM1Xpv/mLuTdgTXAjc5KOImg9EgxJIUPbhL7oFOJJWbq?=
 =?us-ascii?Q?+c6xN8amRPPMasaiTf9U/nmwzYaAyDNSGbjZI4R+YuQDOZhDty518jCG6gaG?=
 =?us-ascii?Q?GDRHcreG1LAgEO47DX6BekZgbkwnoyWo7Ioy2UevoOEaJDig/Hb1EyyTtaP0?=
 =?us-ascii?Q?G7OZgucknf1sRFKyYyaMV2Q6NibyDCPvgHKnaZfV2PC6caBY3kYBW3vNyI0v?=
 =?us-ascii?Q?ir04xwIGRm+2xyGu59gbgiOE8PzPUTfqbENhkBYY+yZXWHgXQvYWYGRwmBuV?=
 =?us-ascii?Q?tA3SS4j+9+WjjytC9yGoCxexrO+SUA4ojdPxZLNZNH1c31efECNk+S1W0Irp?=
 =?us-ascii?Q?z8tPXPSj6X0sEruZcevo3WWl2OPex8BvZmGbA2As+Q/b/uNZw+VnXZg0M5D+?=
 =?us-ascii?Q?kQqtmcwVg34j1bL49TIZqrB3JQWUqz5RJF1B/sWfZQNZdecNOySZvpRzWsNu?=
 =?us-ascii?Q?Wdy3/wdjKUj21fpLwiwQJ+iaNBeWgbrbz1pqni4mWzWK1NWhO30PWY59sI0o?=
 =?us-ascii?Q?m9Vsyp69EpS/Qt89WOwWDDpJcyF5KT90tYE7cWSydCSfffbkWh83sk9efUyp?=
 =?us-ascii?Q?2ugG8YFjZ7t5Jy+Q7uBywtGcs0a+FsYlBt4dsR9iDVPi5zmcLhA3bqAKpyeL?=
 =?us-ascii?Q?rvdBt6x6bEBFKrVTBkXHUzTawsuGLHXEFGamRtXmHSDw05aqbsYzLPWzzVBW?=
 =?us-ascii?Q?0UDYWhRCrjPgkA1yyIE9ZZWslbqLtldk6MPIHBqglK3oI5QSAnhxC/HNCvfc?=
 =?us-ascii?Q?9NZo4rFH9u0Xfd5MsZGNX50+2nNLHtoyt6tohQRbjdegsx8LBQvAL/JUVmqy?=
 =?us-ascii?Q?pAr/mWfp004e1BqhWF+DpimjLuHqM4wip69AHvYbUdiuvmhHDcm6fj9/Xdbb?=
 =?us-ascii?Q?dHlp7z1UBCklWQkd/CgnP3OBNDK4qnzwDK+6g4vB6eED7ARoVdTtY4wgXLTY?=
 =?us-ascii?Q?lC04FkVX/cuQIgKuVi+jb8OuCVO86F6jWKO1v4S5SzSS6q2vyt638O2Ynj9n?=
 =?us-ascii?Q?t7/v4bufm4+MR4Hh9rsQPHh3QmnS2an3LGTJwzDrSITkpf6leoRyym4z4KMh?=
 =?us-ascii?Q?ONoNaUPy0XrCYpUafT0DgyS880i7zulCbpFqSlinvVHBqYgVYtkvIUveFFKV?=
 =?us-ascii?Q?pS3fIlFvJqwBkflwKGZJhHwN6eGitAUHijreMwUTBwXNXW9RTjm9ZbvJkOnX?=
 =?us-ascii?Q?xIPpvSTMt3ljJFYr1EM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AofhNra6Gs1MhMssRalqYptPvczwWLpciPQDBT9LsBFcFw8x/7MreQtmiKlP?=
 =?us-ascii?Q?XO2H/HCghLI2LIL5hrpAVkXe3KhQ92d2Ygs61GLt31hUlhDzeZRASAKqJv6R?=
 =?us-ascii?Q?dKMM8MWn1DBLkL6FRhGsxW3tsZvDhj3eJe0gBnT+3Fyezoebcs6FW5fYon3h?=
 =?us-ascii?Q?7ju0dd+ZXP5OOy8zOB/eXwCm+wWU/oEiJIR7D1CGsIpNy7lE21eFBXQsAkU/?=
 =?us-ascii?Q?6tR/9mtr3RUoDXCsWVw9kGdZVn9ywt86jluKk5UHqnbtLZOU08mnPsw/6j6r?=
 =?us-ascii?Q?8Jwfw9K++N5ZFvHIc6voLcITjMFleHxgBphavRmAzK/Di3U+FwKbS18DppBa?=
 =?us-ascii?Q?i3kcIaFZ/tESHv7hMXIOGmYuOxDF/GkmVb+2XAblLtXznsiI8FHR8yE4D1We?=
 =?us-ascii?Q?t6RKJhi08cNF1BmN/94QL+ChX7Dntc4DwlHu36Ou439FmzJtyHfSDNK82Kxr?=
 =?us-ascii?Q?qoUjQwU8RecasJrisWM7bqZrEe63VIS5XI0XJMVdLewSJiJHneSIBUIPP+kq?=
 =?us-ascii?Q?NtSoIO3zP9tAqHbLQxTORFS17O12HkDu/lbjm8/Aipsaqcuf9ALMgbDcgYtw?=
 =?us-ascii?Q?cbD1NOhnFxTkCxfsQaVRglDNChtfeU039LIjHdKNVRidLicFvbBv/hb+70wA?=
 =?us-ascii?Q?Y+DQTpbfG5n4KbPGWwKR/OQMQ+R2HqPY+8twmjnpI8xMLeDXYsXCAXGk1rFI?=
 =?us-ascii?Q?84LOk+ZfWgeAPPBqbKL8Dive/v8KffCUYw3EY01tpmqXFKcRHntnGWe5x7UE?=
 =?us-ascii?Q?GmET/tGynQydO5r9JadVABBIiFh4EaJPidhgAB+O1/jRJwO5qwmx21STFRuP?=
 =?us-ascii?Q?mcKjJvvK3W8RyXMi5rf3uui5o0gZeJ4nwqZJsHb3pukudUsIpxd1RMB6Yr1A?=
 =?us-ascii?Q?08F6MgH5qOLKaFMf+ANFkiKTY9fVIdOnYwSzle9aOdWpTJf9Y9SrRPEtQEyS?=
 =?us-ascii?Q?8C7sbl3Oy4qWmGe/HC7IxTFyzOfSBET7RuHY1xwT+W+AOof4TuMkBocx14UD?=
 =?us-ascii?Q?Avh1dYB1kWMvE87fyyuMNCW40ZRcy4vvUL5wrH2d57YQfbA1PLVo9HM33AK5?=
 =?us-ascii?Q?VKsT/WVwWN80M2RyRLvELs0DMAtjUzG9/l1pTO1jRX71fXNonpt6yevfuTC2?=
 =?us-ascii?Q?pt2jYKYiQwO12iBu3zkoZOu0AgXky04ayMzdoVI9GPLFDRC28Mx5fRE6xOmh?=
 =?us-ascii?Q?qB6skIusS/5LgYfC76/w/bqJ8l29OOzuXc/T3LbBgD2ujFO82xi0mjgxv+67?=
 =?us-ascii?Q?2uIs8iTg4AltOrx4hwBiBNnoeKcG3aYqC/lfx10cDteUCAS5x5UvrSa1QVlS?=
 =?us-ascii?Q?mai6tvSs+xOkm/lKNSZAIw94KnU/pa0SzHhvwVvDgqIspEnnJNPwsrVqHGIS?=
 =?us-ascii?Q?K/cbF3VSyezkpEAMRImYHEteAPaPvGlMrIgZKrhU1ISMLS1CjRtFkbuBlyc0?=
 =?us-ascii?Q?zL5cjD6WEwRgLK9qE50GukIzrl4AL7t57wfTz53NOyuNEk02AWckNUe90jsO?=
 =?us-ascii?Q?9FPTucqKb3xem6nNxSXEyGbbV15DfYJnFFRyb4OcGSwi7H30ohjavodXsOw+?=
 =?us-ascii?Q?WGEpnw5AcwwukGbxqrxCxBxXDfrx0i9Pg97eXdLgO89IiUs72mJoznT+r1Kw?=
 =?us-ascii?Q?2U/ZQ5Fyh35So5HwRLIidn+3h1x6nrO43H1/i9S+pmXn0Fak/uU6mMPCuN1t?=
 =?us-ascii?Q?FZL1T6++vZyIIzXqUuAQNGSFwFE+NyKKlW7XojN2nA1Fv4b0ccwn3KG+xgLY?=
 =?us-ascii?Q?Rli7tJpVa8VxZvVO2iuDwI2T6XvNEb8=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f0d82a-e83b-4fae-c427-08de69f700b8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 05:24:32.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6o21L7d06G115VWDr5l0tniFXJ480ju+xq7uZAqeVarAMW9A40bzMAZ/etrrdbjbBb3KyA7anPIEPwx8+vUH0TcTgTWl/iHAlOGNcK9QHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4695
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76990-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59DFD12A62F
X-Rspamd-Action: no action

On 11 Feb 2026, at 17:05, Chuck Lever wrote:

> On Wed, Feb 11, 2026, at 12:09 PM, Benjamin Coddington wrote:
>> NFS clients may bypass restrictive directory permissions by using
>> open_by_handle() (or other available OS system call) to guess the
>> filehandles for files below that directory.
>
>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>> index 68b629fbaaeb..3bab2ad0b21f 100644
>> --- a/fs/nfsd/nfsfh.c
>> +++ b/fs/nfsd/nfsfh.c
>
>> @@ -236,13 +288,18 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
>> *rqstp, struct net *net,
>>  	/*
>>  	 * Look up the dentry using the NFS file handle.
>>  	 */
>> -	error = nfserr_badhandle;
>> -
>>  	fileid_type = fh->fh_fileid_type;
>>
>> -	if (fileid_type == FILEID_ROOT)
>> +	if (fileid_type == FILEID_ROOT) {
>
> Still need a comment here explaining why ROOT is exempt from
> file handle signing checks.

Right on all points.

I'm really sorry Chuck, I sent the wrong patch here.  I am going to resend
v6 with the correct 3/3 patch.

Ben

