Return-Path: <linux-fsdevel+bounces-69102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D6EC6F206
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1D2E629FCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DD335FF54;
	Wed, 19 Nov 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="NqaBPPI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022097.outbound.protection.outlook.com [40.93.195.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397B3570DE;
	Wed, 19 Nov 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561105; cv=fail; b=lGtOke4wFgZJA0hO1LHHMnbgDY8U3z3IPcQs9uWS585DykSnj1NTNaTmppb8gsQxncCIJrXoHPDk6hWoelQVBLP7FLlERyyp8glEfFbq/Ru9WFdepWQemIcPikJicNLqkoBAnpLZWyfGToopo5yYUnu8Ht0t0pWcwzAniNLQMAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561105; c=relaxed/simple;
	bh=HEyLfWgWhu8WAsQlUY6ubo85CChmAG86dKkrtAoa3Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtZijraabgqfyM2jR9ik+GMNxCDGCrDnT1ykZ7Mx2sPylSzPr+W9P4uGy24Llsg/3wsONfzZv3i48gPuqvG8dVDsASWATvT+Uw4wzvULAN6tjOBTuJnbEIGz2M9sRI2KXsHxlcFwyWqYFk5TTr8Z8vMjrbN0nUFEpJfR5WTj/EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=NqaBPPI4; arc=fail smtp.client-ip=40.93.195.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K70i/9qRcS2unYcpuqCbRA28KifOoK3iSZLfNGsAGUxXyj+ekkCZveNNnaRoVmFbXYXfnL1sPrCnHgqZXN+s4WvRGvyJcG9+1sbLDJNGUBV+Yq7wJAJQvwwhr5SLYI6YV/kQDR0UeNxaiZJPjxgofJCjL87MkdQDzVt637nRNUOSyPre4E1B5LWXOF+JRZfIV0/z8kOXDlbmYyW4VW0bCtiP0YlVdFzMgWhMcwyJTdqRqJKL7vQElD6XBrzN4fgkfP0hb8nmr6bTRB9EE9c7vnpdvGRTlNVvfoWKStlJo2xpxx0J2PJ5AKdr19liRrcE2VlING66p5tD9hQxxjsX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqlXSXKe6t0GPBy8bd3T1q6htC8b9ulU16y4pvgwiSo=;
 b=XOOo8oucFOh0kzFQtTqYrl3nCUUb1xVQ5r2lR2j6xa94iieK6zh9Al8WzNIkkaNj9b0pe+AImvwj1mY0IqmxqvGwQkwptx80GePCvlLjN7XSZP/vRkRDXKxVMIPhirdwyLi5shjZ3ssXINWgtLo4gPNVSEd3mb9ZFwCefVvPbTnPsQp4uJri7WzI5+l9SM4bmlTFz8sUfJAcYUdimAtpT+QdqYkibf+ml8r7CARF7qNx8SQGuTE4gEha0sEocdab1TP0BqhLex2cDiRPcY4XOGkpjk9nOnmsRTMZqx51kbVWR06gOkTdAojarrE1IGWqWyu2FYG7jdguZT+OBz87YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqlXSXKe6t0GPBy8bd3T1q6htC8b9ulU16y4pvgwiSo=;
 b=NqaBPPI4AHYAVPhkB1R8KeeGSg31KSdpSn3cvmauP1y5EdRPwqCerKul/e3EoUyBxPqhrra2sRZG9z5MNWPkvyqB7lo91NGehixk1Lir9mT5rv4Ox45wcdDa2iz3X5XIJhxmZaJZoCMivDsIruJjsliBGiegtCWA0V9H7O4Puhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by BY1PR13MB6312.namprd13.prod.outlook.com (2603:10b6:a03:52c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 14:04:52 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 14:04:52 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>,
 jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
 alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
Date: Wed, 19 Nov 2025 09:04:48 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <2B6A24AF-0627-45F1-9C5A-95DDE8536F87@hammerspace.com>
In-Reply-To: <20251119100526.GA25962@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
 <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
 <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com>
 <20251119100526.GA25962@lst.de>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::15) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|BY1PR13MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: ffead9e8-d94a-4cd3-213c-08de27749bd0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nKAyU7cAwCu1lIRmvt3E+ikdVZIF3hMxWYz3piNbqN3jCxbsX/HCiolZhAkp?=
 =?us-ascii?Q?vpD8IOn2i/pi5a+1QCv9IEaMDyPjSRq+CyyG3cZyonF2mK1ogEggPA8jbHFK?=
 =?us-ascii?Q?XUfAswL6f5+7kpqf70+AMQsCpcc5d2ZDQuJ1w9sV71V9wVYZ4x0BEG1lNa67?=
 =?us-ascii?Q?OPuRMB+i+BUozto3Cz0Eizmdq/IKaKB3isLk2m3jrnrJ0jeqVhW8MICKoceB?=
 =?us-ascii?Q?qDLxDkKDwvlLesXLEn2jYQzy5l5j2tLABxnsva3P0nMdZLY+a3hHSixuxURl?=
 =?us-ascii?Q?KEmMD98LukEhPxYSvrGdKYZDWYWRz3PGwcBvxjZpQfIPVr4rxflJw9MBVtTO?=
 =?us-ascii?Q?p87Mh5QGrzoNSzlf92s3sfD41FHwEvN/r7iaps9RQIeaBzp5xPnLC7eEPW/5?=
 =?us-ascii?Q?yzwYS6u50m3psxScDChOE50PEj2cTSicwCLCmAIhjhL9x2lYA9vPqTQbK+Pv?=
 =?us-ascii?Q?A6dDbA9oz1uyYvVT++Zp3nuY+Ed6iUvbOssjXZNI9uyiAHcDXcrP3kHSBCx4?=
 =?us-ascii?Q?mG9KLjgMkn2dalcvnc2LnSkvqQ+CJj9IcE0NTjS1Bohs5MMl1rsEbcz+8PVe?=
 =?us-ascii?Q?b1fbY+NESD/E6JwCxK86wvwPQjPji+gk7BA+pcOTr73dARxKw/XV1ZvD8J3C?=
 =?us-ascii?Q?+RU5qSnjWExPhJR7gLq99Iys4NWg8UgFGHVk93d+lpX02L7/++t/5Lr/yvzS?=
 =?us-ascii?Q?FEcYV3sPV8lIEK9nIApL/hKX/37uJy6Xty2XP++jagXS2EMBDO0Tm1B/D7SN?=
 =?us-ascii?Q?MVw8J8Pmxlcl6dZMhbZz2PCJUT7qWJwKzr1741PADHTxy6Xw1dFYeJ7n/hJL?=
 =?us-ascii?Q?/S+u59oOCPtzJcWKgCzAYjzfuHImhO4re0XaGBYG3yNCrHr7zAKGP3cLmak9?=
 =?us-ascii?Q?qsxJxTSFydXfmRueAtcMfc1Z4FkpJNtx/DKq+GrbOdJCz2o1Nkyq3TLKDTzi?=
 =?us-ascii?Q?Zxw5TbDUB1OVHwwU5wycaSm83r5GYmZ5mvXj2gBR1E1TX0y6x4R7hfIC5anf?=
 =?us-ascii?Q?4m/sbehKxmxbSKm1kmKh+2m/n0Ap20M4d0te0rfU5VRGMzeIKgvHEvXoQsRj?=
 =?us-ascii?Q?ITn40u1BcfzTRVBbGEkCqlvrC3IBHoKEPo42jXM4ylyXqPkHsLabls8uGunh?=
 =?us-ascii?Q?bFLwBSbFyMKwj95ax2ROxgwVGGm0z/nbifEy9MARS7p80skZ5Kl3Wwgqil0N?=
 =?us-ascii?Q?r2An43yf6+D/cBPGeiybPcMwweckvsBe3lWLdwVsWCHV0HY9hz8qhvvS+RxT?=
 =?us-ascii?Q?gZfPO/iQwnmA5zFX9krFyy3g7khk0JVxvFigAucwKVoKQF+IST+29HD4fB7e?=
 =?us-ascii?Q?yyGRL5MEHcToSJ+Uig8d8u2CoJ/T5/oVjqSBf9za5U9KQxp1feQLA49OL5ZP?=
 =?us-ascii?Q?bbcAKrENQja03BOAg/L4dbg80jyHgRn5ZG/biIIqSdW1ka7VaI7ZQvRtIQnv?=
 =?us-ascii?Q?zVw7qTgfaPr7JhummCjsgQxE5G0HQJtU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/WS9li/5yg/FzEL/C/hoAGqFEq9RhIbFAzwRYTkxNuMO9oIBD8DHcItlcta?=
 =?us-ascii?Q?/u4BLbFcvpV2X+HNJVpjE1QNzinmXRzkabeHQxyShHyXojVD7QVAtWEKPgBl?=
 =?us-ascii?Q?cl1FqGwXPAF30HZqzq+J4IYD1ESAmScJNOKlJG/aO/+agCzw+pMoIb+0e3my?=
 =?us-ascii?Q?3y3+uDdb1y6fUNa+xfnmnojqwsS1BnChzlvYT0SCrTyFLetwUZD5c+zOOq/O?=
 =?us-ascii?Q?99o3WxVQsGe25jKbMMoJSewuv/xSnOQdB5xbvsCr2CPgEvvP5sB9VzmEkefF?=
 =?us-ascii?Q?vP0CKbOd6CSgQB2JoS6vDeszWcaXfw5J1kFHdlYA1qdFHoSIrprNiCo58Rys?=
 =?us-ascii?Q?uMgKd4hl7KMCiDDeJ1QV+CuFY7i3ZKBcybDX5v0dXy8qUhQL/avH5Q/TKmDH?=
 =?us-ascii?Q?BqJOMVosxEMfLgV2YZlFczBvT7udcXgtpqvX1zBGApAFoDxnND9RW6NYHBo3?=
 =?us-ascii?Q?ACgsLs/kJSIH95efKmuhc7XvCqzR+nlt7URZPGJg/gzf9+//1owYZCvzfKuR?=
 =?us-ascii?Q?Jz5umwzZUfB61kd93sp2i5PQHyDslxVUyuuTVC8ZAs2ZD8aerP2iXmx9xKA4?=
 =?us-ascii?Q?+mk+1Q/MKkG1YHAXajxdbSYUD9wmpRRip3q/Bj9NUf8StnDLU09aDokqb81L?=
 =?us-ascii?Q?Z4huImhOS0vVIr3RfwGYDulOdBX4D7E0pz9jJr9a3gS65Ki2koiANhan062E?=
 =?us-ascii?Q?O/Orl5FStm/+cjJt9oGjlLsHX1PcyxHA41Qg5rY9Lux8kKCrTxgH6iQddZQt?=
 =?us-ascii?Q?UeFwREfG1RczF1lbb3hHo3xfYloN6PWeYtjDSoP/RVYjfd6EfsdsasuXV1Vh?=
 =?us-ascii?Q?pHcPlMmerMi9TgHFfzOxU2ecs2wRWrYCY42GjlEhOGJC5ydBJLMUG5BvIibx?=
 =?us-ascii?Q?4TEq8i3HQ1D6gMdplorcmqmo5afcH1sbnIbywnnI3fNCgXhwtMk7OWt6Z52I?=
 =?us-ascii?Q?BAMJa9g7y8SUpfhyBo1RfRtIyY+wrTBeXap+E8b3nsEpVpT6TUFYnjd4PSNC?=
 =?us-ascii?Q?53qZyBuCtq1HXg8zYBUUU4F8N37wc0CJnIIQW5HibvBKLgtZGZvb7WRu6ioE?=
 =?us-ascii?Q?4r1BbZMazDbfktpEb3chJB47bJC+svV6Ys8if5WAMB4rAZI0jRheIyB8hywk?=
 =?us-ascii?Q?/x4uaOS/YwK6S3KmGYX3cx5MiFt8M+PHNqDh08bpCz9J5k38RMi8f+QJM13w?=
 =?us-ascii?Q?h1NH/l5QChiJXSMNwcZeT1c64/EwYE7vmIe8nwdmHfnWw2Uyu7waA+ON6EHt?=
 =?us-ascii?Q?EuGrD82MkprJwV2GINZshtpObCByWVH8HvOAmMclP04iBQFYimeeToeOkEUC?=
 =?us-ascii?Q?jrYNANxuNnXTacCrOBOIAYsAffR67Mvwl9qN+tEqKv0Co5L8UMB+ao3E5oMU?=
 =?us-ascii?Q?mQxyxO/0ALon6h7thT1FHJZyNVv2XMWiKfL14YH10n2803Do6SOAH/JzxT3/?=
 =?us-ascii?Q?QI2n9AXt+M+L9FLu9+38Rv6lZZsNnbWUp9VmzVM0eJrg7/PFnUu1Xic6vGUC?=
 =?us-ascii?Q?KLpkVSZFUP72nrYathiNGUNe1LfwX+UFK0K9li9s1mRrTgc/ErHhG9JKUsW5?=
 =?us-ascii?Q?Jp3e9VNcnqcSu9aUPiHoMEVIIEKaoeEvN3Avc0iRPm887AykY7hgQMSy3xUX?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffead9e8-d94a-4cd3-213c-08de27749bd0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:04:52.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7q9mYvrn/HPyM4vHyl16OvxAR/Fui4iKwASl45EPLwg3JawRZMmH5jgSFrACGFZb1HflIazA6kPArjD4YFkyqV9cICskShgnmMoKp85eAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6312

On 19 Nov 2025, at 5:05, Christoph Hellwig wrote:

> On Mon, Nov 17, 2025 at 11:40:22AM -0800, Dai Ngo wrote:
>>> If a .fence_client callback is optional for a layout to provide,
>>> timeouts for such layout types won't trigger any fencing action. I'm not
>>> certain yet that's good behavior.
>>
>> Some layout implementation is in experimental state such as block
>> layout and should not be used in production environment. I don't
>> know what should we do for that case. Does adding a trace point to
>> warn the user sufficient?
>
> The block layout isn't really experimental, but really a broken protocol
> because there is no way to even fence a client except when there is
> a side channel mapping between the client identities for NFS and the
> storage protocol.
>
> I'd be all in favour of deprecating the support ASAP and then removing
> it aggressively.

I'm in favor as well.  This is something that confuses users when exploring
the space, and I've never seen the setup being used in practice.  I have
seen plenty of attempts to use it before the problems are realized.

Ben

