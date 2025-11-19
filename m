Return-Path: <linux-fsdevel+bounces-69090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C67EC6ECB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7EB462E984
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25285189906;
	Wed, 19 Nov 2025 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="IScpSV8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022139.outbound.protection.outlook.com [40.107.200.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FC36C583;
	Wed, 19 Nov 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557896; cv=fail; b=nRe/rQE3TuSiDGSo9b8hRq9kyNDtv5wbwygS3bVCihakzQbwXZpc5IyqTYVaeBgKPXEXjLxEGsNwHVjqgyi+NozSolDs1gwpAjQRWc1uX5AzaK5JJZkQfunblqvK1MTraS+F4MzyDLaQDrykqPEmKwjVGX0xxSBYMGlGYH1ToqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557896; c=relaxed/simple;
	bh=Pti6WdSP4SEIUpVwF1i/AGNZp8a/r9UryctqnjhdRRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g86Hey/4nz87FImL7Bcx4OH7tIebX5iTP7gwSkc9R3a6Mn+quJFfDGDjh2FKgg0KCvdQFh28wBZRVGYwotpj4cKGYcK6ql6q0AqGZgi4wIXc1tmw2MVIdzLuyLb4C2R1u6h8B7vuYq6xI9kq2GeWOzUev5k5uacSiXmhNGH32iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=IScpSV8T; arc=fail smtp.client-ip=40.107.200.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnj32RfA0roX/DWxy55f+ojDH3dRmshJcmJA7W3aXblOxFuXPVMZv/m0oR6Sa54xpOobg7SB4xLRiC8ErtTcvn7optcF0tY+RBSmY3/FvgasSt5kyLA0MJ6LUUn3poBjRBUNRvpMu5aTqTyy6rc/ipRPuKbA0ro3ZKycRgLH2sXDjLUqcmFm2zBm8+pcXn/qOdniIk4n1K6VY2+3eyRWZghpHcL46n2Ir5YVR4a77MIWQevaFByLyE7cP2/ejJgT8NWmpy1eMmJavTUseZ6BWW4vdWKJJleVDelI+PJRGFmdhuL/1efbQ1oUib/80NcEocqY9GH/DozUwTMOegmbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6k3MJhnwy0713l8KpnqGaR7FCIweTs2L/4gsyzpsPFM=;
 b=Q/MRCWx9ET+2FWHieRLydpRtAM7isqGm+E7M+GrfPChbs+QVpXc1khGE7+NdQHM92jAChJvtPEJcv+tZSxEcAT9wnq3fhRG4GIb8jW81xyYErc36P0pnXkLwiXnd05g146VJDmClILnt8QB0Czv/syNf31hEL5wTtnnaDyuBMiGXcXUy2x9it7ojGj2IeuD8twjHiQ7hDW4Y5/gFoyJGZLfKx+IA0emjnlIzywvRgDHrsZ0QzQFB28Yc2mBWT3Md84UZrSYkefGlJvkX6t70CyhlaEBOK1SDinypu0WjVNYVrGqDczOUDcvHO6yLgOtk9qETCTvrzQyEc8jkmOTiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k3MJhnwy0713l8KpnqGaR7FCIweTs2L/4gsyzpsPFM=;
 b=IScpSV8TY4ubLtF2gml2+pzm4DqJvThd7g+oD8dR6KH8LC0oX8XlFNBskdO5zMS+jkbWwyNH0e9MLXwrKIvakVs8UhpnqXEzIiZzuUvRBtY24/wyHBSofA99cKNJAHDu1EWsA0U6bdN/6i8rup17oAT2sTg2iLT+1AB6uE7NEHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by MW3PR13MB4089.namprd13.prod.outlook.com (2603:10b6:303:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:11:28 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:11:28 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v1 2/3] VFS: Prepare atomic_open() for dentry_create()
Date: Wed, 19 Nov 2025 08:11:24 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <12F1DBD9-F5AB-46D5-97FB-1A85E530BE55@hammerspace.com>
In-Reply-To: <176351594168.634289.2632498932696325048@noble.neil.brown.name>
References: <cover.1763483341.git.bcodding@hammerspace.com>
 <333c7f8940bd9b14a2311d5e65b6c007e8079966.1763483341.git.bcodding@hammerspace.com>
 <176351594168.634289.2632498932696325048@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0071.namprd07.prod.outlook.com
 (2603:10b6:510:f::16) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|MW3PR13MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: fd45d456-053e-427b-f735-08de276d2649
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d8U5f4oG4SX0vBX9dO6dTogCG66dUobpYMc4hX/uT7f4a3nqosI5DTVxTn6s?=
 =?us-ascii?Q?BZhysiVWP+Y/m/W9H7xBXVPzy/QxNXY6KXTUpcSCWMjhRr5mgnynBHhhGdQM?=
 =?us-ascii?Q?KdjyjVSRhAxHVRdGuytv7YgMZqkGye/pQPmKoMrq5+hddOUEZB/0ErNbUe1n?=
 =?us-ascii?Q?rwL2rlyM+5OLWH8bgjyXi4TkhiO3CWv93We0S5MM3BFT/m00MvjfM9EvEl/i?=
 =?us-ascii?Q?4Q1NiMCa+OcYm38fLcd2BAxlzUKjjdKpMl27v7LDuf+pBSQfgQ3BMoIr26uU?=
 =?us-ascii?Q?E3BWRxqofy12br9FQTpgrjM4Tz0LFzycwiS87IveMBAfPMs8YA+FMxKPGgnm?=
 =?us-ascii?Q?Th1+Hq1jU5dTrM9lDlst3HS3GtDOqUx5SMIQMwlOsfA4wwuahskTVWjnxJ5B?=
 =?us-ascii?Q?D/Igt9i12w4CQWP/VDvOrKlHyv8d33DJCIECftQhlPsD1wM1KGig2zQEiwOi?=
 =?us-ascii?Q?0FOnQkjuQPcx3MVOlrrN6xUuyjs3JNnQdnv5ieycWIDgZm0tbhR7yOv++V2m?=
 =?us-ascii?Q?B3mWm1oQIebdkT9o2DgLtVtxHCSHOEJH1bB4GUl2V1hQQojDEYE19SKl+25B?=
 =?us-ascii?Q?xUH48Q7RGSXqplfgbVQMVMLOpaoFXf4ghXRzMZou0t7GYhwezqc5yRI4zvsB?=
 =?us-ascii?Q?X9QhSDa1jpXl9IbYN6j+SGZqjHsytbsW8lpqWTJYYFeRPVe9jfGJ8FlCsq8z?=
 =?us-ascii?Q?ACYVb9JdktxBp0Ezg491vceL3tBVY2fWlsMAy16iKHuX9tQNf/tARXJ6xFdy?=
 =?us-ascii?Q?jvDYzfUg//Rer+lloI16DEHmq0iJBvOCQKnRqp07NWP72905ROQP8gYUtZq1?=
 =?us-ascii?Q?objXsOce7fyR21utEAo4Ym3sxc/f9Sp8q2LXuO8qg12E39aArKWlW4xT+7hE?=
 =?us-ascii?Q?7ih6WpUPPxfEu4gyM6qyD4wcRFeLfY1IAcOyqsAsYX7EJQTclB1b+kxRHoSK?=
 =?us-ascii?Q?SPjjDKxsR2XrkrVAqzHy4KiUXgsoSfT5j4O03NDJG/cFdF/Vsj69g9ghH1aN?=
 =?us-ascii?Q?wimRGLUQ3MSWVX114hcfoulq4JTcucmZYxO++Gk7aj8VADNKMkwK8y9q4qbI?=
 =?us-ascii?Q?H8rU1UrVpLM6rGs1j+dUzFlf5k2RuJlOYMs+uZwZ6+QcjPHJsqbrfKmT7lgb?=
 =?us-ascii?Q?ed9RIwUKRRGeBseF6ZQQBqESapobXDVxhWHfLX9HDUFDDFLHrvu5q7YCtfSj?=
 =?us-ascii?Q?7ScqN1ndB6ruH+/nsrUUfKI8J7bndGxVCH/f6lThH9mw1I7ybyXqTSHsF8GV?=
 =?us-ascii?Q?qQjeyicQplq90OusjZbMsDA8luL55rXzinlZVYJRe1Qk/10/jCgS39tYvnZM?=
 =?us-ascii?Q?8T2VcqZNSEZmebNndphuu3yWJXPpRAjaLy/s42Ic1MafLBQymlLpNl9fER0e?=
 =?us-ascii?Q?FWPWejPR3bGZbRu7mQ1bXbwThjGJMVQHDy7BO4YlsdDBNgfCn2ckgOHVsRcQ?=
 =?us-ascii?Q?Tw2Efoyw/SugMEQjXaROmcKiS/X8Pt31?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JK/PR0Mm5xRYPfPutBokRJVueviQUnxEJcglt+Lp2816CERIlK8oytfDmkwC?=
 =?us-ascii?Q?yIYvv8j9xD5Bagz12zlRd5aqhfzjiXZ9k96VAx4R6FTs5RTg2xVfxvGwE+0A?=
 =?us-ascii?Q?dZobUwruE1vK/IZiY+G3eKzCPF6DO6XBxe9FeF7NfE43r1Qort3/ergs/AOT?=
 =?us-ascii?Q?haZgzHlU0iiLQzDsTp9RZsTJJhpCKetUzydAgrdNN+X/Lh/rPs+q6YVX+IJu?=
 =?us-ascii?Q?D3NBQ377yiyu35CaJQvat47oHIvRt4GVpcZS1EvQdopAazvn39YAJL2HGyJs?=
 =?us-ascii?Q?AE1NdvolzAcvIdkmFpzxhJfgWIE71ZWOQNZFzKCli3AC3fYSnl1EpVItvZme?=
 =?us-ascii?Q?DuLV3tT0q32/WTjo6FxaoZBmX+pMWU0EGaPalFy99RNn7wK6mvvEH6/4ZVzA?=
 =?us-ascii?Q?zJ2fXUkrnWx2WK7SCi7Bp0dCN1J9V4YOzQWZgtRyikBFbXBRsWb1mNF0wLox?=
 =?us-ascii?Q?KNa9UKatOTZJhP3qGCX7Vp6heyE/877hs7r/vsNznCPKqGnd9FxN7nrd63Ee?=
 =?us-ascii?Q?YdB3TEsMpEocC8WMu6Y2JdKHHFZPEq44sEHHLznjE9T5ACy2MheTCgUbuo2M?=
 =?us-ascii?Q?nRv9F50tn41UaBLpAZggciAbV0iinupYet38OkLR9xmY54PPRaqo39KPVuj6?=
 =?us-ascii?Q?bLUsrF3CESNTHvK94GG+H7L5wv8aD4vSW+7olgIASi1dHGDq1sgvgvcgKYQT?=
 =?us-ascii?Q?OHxwaAzSApQhThThOg8GQnEexm1vZH07bM75zqlZPOWJXA63g91rjZFlvJfy?=
 =?us-ascii?Q?mHMxEljux7U4lsObmsCGwUDM9QlTBJeIQdxhI67x5hf7MJTXHBDycTXG+n/F?=
 =?us-ascii?Q?T95HiVGcUy0YsIT9HRiF9ED6v1Wi2sCAYPA9U+7UiONS5LSxDcaMlUeDK8RA?=
 =?us-ascii?Q?je5XznXdpMzzOwxnMKtZwwrrlDYsZgQOnfzvtroJdAuWyyGQBzVzCN5bugq+?=
 =?us-ascii?Q?1rif6w3nagyiQI81C1qU7/ec88vL+IJG7pZkZeqoXU7QRxAYXbaxDBAKGuY7?=
 =?us-ascii?Q?qUrfm6beGf0mZGNZNTlLN28FN7vOP0n3kr543Z3OOv/ppq8bBeGwtbe3RIXn?=
 =?us-ascii?Q?pegWdnfZ/ozewu8iDmxR6iJ4YlGpvPdZpvS/1ZmSgKVvyTWAlrWg6zCknGcl?=
 =?us-ascii?Q?J/ztJ2C6az2SfozhX9vigt5PRpYyvuMfOnTSmCXn1QnhoIL/rWxiU6YiA9C3?=
 =?us-ascii?Q?dHSJGX5WkFgRop4CK1necYOeYCHsyRzxn7VKHJQkC6Tv8IYvxohDUCoyWGdq?=
 =?us-ascii?Q?5c+j8y7kiZROAY+pjpA+fsHP0CXXubAQZMvOiGGj5oWdObR4IPEA+MXrvDGE?=
 =?us-ascii?Q?BGs5t33rh/l1+Bb38nfMqByCkglRx/EYGAR063X0cqeHLUJr3e0ezrBvT6tT?=
 =?us-ascii?Q?3p3IGA61vy654h+Ljz0WlX9BDG/4bGZvI90M7BuZTEAsmpFIBbPBdeFfNyYh?=
 =?us-ascii?Q?8bJPKmOkZqU1ACS35GAbzif/vI0F4D8QsKK+z/jrkC4yY/a1EjnbJaPqwfHb?=
 =?us-ascii?Q?IlTrDXhkVnz5BUyn6Egoj9EPAM1aStjdepb7BNyMtJSzMZUJvJBM3W6I/FQq?=
 =?us-ascii?Q?5OcuYAEw1NEIE2FsCTX9VB53FhKW+bkfUVBIiNIBgE3hDPbVIGl0EFhcPX/S?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd45d456-053e-427b-f735-08de276d2649
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:11:28.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w76Szgs+PL4psF3tgjYfyxZXD5xfQXAp04fbN7pkOaCGGMZnJccV6Tn+OOhoWFiY5zmT1hBPaRqW8ekgQWrd0B3wygGkvJtA6++xj5PTc/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4089

On 18 Nov 2025, at 20:32, NeilBrown wrote:

> On Wed, 19 Nov 2025, Benjamin Coddington wrote:
>> The next patch allows dentry_create() to call atomic_open(), but it does
>> not have fabricated nameidata.  Let atomic_open() take a path instead.
>
> I think this commit message could usefully be longer and more details.
>
>  atomic_open() currently takes a nameidata of which it only uses the
>  path and the flags.  Flags are only used to update open_flags.  That
>  update can happen before atomic_open() is called which would mean that
>  only the path need be passed to atomic_open() rather than the whole
>  nameidata.  This will make it easier for dentry_create() To call
>  atomic_open().

Thank you!  I'll add this.

Ben

