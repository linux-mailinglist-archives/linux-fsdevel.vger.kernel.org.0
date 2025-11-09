Return-Path: <linux-fsdevel+bounces-67599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E8C4452B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 19:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A732E3A5CAE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 18:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665C22AE7A;
	Sun,  9 Nov 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Bak+cONk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020142.outbound.protection.outlook.com [52.101.201.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60423218ACC;
	Sun,  9 Nov 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713388; cv=fail; b=BX5C2DgLqc8jnoL1o6viyZv7/qxnEHeUUhWv1fF2ACEHnikNdQDPF4dXj7x4XB0K9KcVQm1FzSCa7zhMavn4dz4OcsaQQtrJJjwGRjKw8rkstsqSpXAnZ6Zl7uC/SuUxOalkCFozQCVObt1NNU1b9da5TCiOOzAZNi9VDV+k/vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713388; c=relaxed/simple;
	bh=vuoNpqNnkuBMfckiR26pMuR9pwNedHaNJ6p+hfsvWlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hOf8NU7SwB7tBq6SFq1AaCk6wFI3YOO5yr2ORthYSbuhQ6JzuwVy9LAb4fjIvffH9+PH0n17WWV4a0oNCcNkblMRuFu0eh8Izno0BEb5gzz+VqZWCo6qpTW1hDYal0kKxPJppoAjxFX7hkwMsnUNktE4qKK2Iram3pVXhROR/mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Bak+cONk; arc=fail smtp.client-ip=52.101.201.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGfWw9C3UnVkFh9LoT4SB+ctND6blm24zWgDUGIKt7AET8zNkQmK20fe8RFvvHL2CVg5vmhEqm+ble2+tTDp4HUfjSwodzFbbmxBZQZYg4FCJ3+iIiVY1lAzEwC+cB0yQivV9fXVXNGYdMVWRQWeuAijA29gpKv4mwYyQCuCjzd4uYWhYRvwsYdT3+N1oah2uZ/fm0E4MnR68O0NHpWs1vnMluAzgcopKTZ4cWFI+Y2/PyoqNdQOZQLiVTqUA1nTL8v5rE7A6jw+lVF27YU1CQZd5v9r6SNoMi1EQy2SBfgiqBdqCTHgvbQVQOLBmohQO4kaE463LYSzQI05Q8nwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3lpTo6GlZXQO8pCpN/4FSaMWLMO8aoUZqfY1uNbSt4=;
 b=R8QO+MnRhJvXwdN6AcYQV1tdOAOFVuFpsUwnMGI9+KiPfgl1tFYHnQoaAVzZniY0fu1Js/8NuaiUTisbUQsI/rQJhfoj7xhLCb68eQ0IzMG0Sfflu7q0NA/tIOwR1zvC+VGtSK3HFCaqPq3A5n+vlOUah2oGpjiPy7SWbBjMsYIzajQWAkJOziF+SUKx74MUDGqxsLw3c1ejmgHvRsESJKjiMeCozYsvaKCxIISUp4wOgone3ovc6teHKbYbpgAEPCOJGoITqiAPRrOmORjc8BtnrZcepPEshlF4aRXP7BV1kIYglZ8+/dUu5UdwjEJaFU2QT8+GOIkZd1li8cqRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3lpTo6GlZXQO8pCpN/4FSaMWLMO8aoUZqfY1uNbSt4=;
 b=Bak+cONkePQceoGtTeFc5lZ+2CbgMedqagvAkayQCGEPbzUSGA0t+h/ERhzOlt3PdeTZVeV4vtUIRj9AtY7O+4VBJEb9H6UMDtDNlg7jVrKKBgdLtxqRdomJxGvb9GOs6qN0tkUZ9+tFTgTbiZfzX5O70Vsp7mGhhjm9+azhXvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by SA6PR13MB7064.namprd13.prod.outlook.com (2603:10b6:806:408::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sun, 9 Nov
 2025 18:36:23 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 18:36:23 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
 okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [Patch 0/2] NFSD: Fix server hang when there are multiple layout
 conflicts
Date: Sun, 09 Nov 2025 13:34:26 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <ADB5A1E8-F1BF-4B42-BD77-96C57B135305@hammerspace.com>
In-Reply-To: <20251106170729.310683-1-dai.ngo@oracle.com>
References: <20251106170729.310683-1-dai.ngo@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:610:11a::29) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|SA6PR13MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 947b0b20-f9f4-4741-677a-08de1fbee25a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXMXMxCJVPDjYitytx5GUdRQ1/YD1qleDbeRGhsDLSv81gUy4oLDOafZYstG?=
 =?us-ascii?Q?EaAMnIFzKVQC2CRuBwoXfcj06FPpMyAt9lQaSNJWwcH9s1J5kfiSJRso+5ba?=
 =?us-ascii?Q?jeVlhz552xMi4PSkwCpDPLZgOSw5c6FlWr4n+q4QmtloTB+DwjtWV8zbeQyc?=
 =?us-ascii?Q?o2v97STivoTcs0GNmW3wtLQxsWMdPc7ImS4IyaHYn/iu+ePTxrJ6rGfsnuEX?=
 =?us-ascii?Q?/gLk9eC97lrpezCFttajXpZ9NQshv3+04ApAJT+rgJVtZASwLwPt/pZTjkF/?=
 =?us-ascii?Q?LDy8y30q1P03edOTYHGqRBm9SYdc7nvVyLIYRsw1h3nbZUwIacuBRfWURl7r?=
 =?us-ascii?Q?eoRJ+AiLLFONnyPlDO6bQhw3QxNU11BukW+tjzXnHP8CfD/XuPAUwaSwW1FE?=
 =?us-ascii?Q?+SWbbiB/8giSIVuDw5yceCwXPrjle8m8x0mCydKXyqrAOAZG3c9zSfuFXQ9c?=
 =?us-ascii?Q?QvPJZuu2LVjtsRAqZ0niUuHiL2vi2/2Sq9bhS8zBQK+2wILBOy3YOjq8oAYG?=
 =?us-ascii?Q?1Lgq+DQ+0XHcxcFxw6yef6xc5ujCP0tFFh4CFHVOBO8x4dtBrkn0nlG7fj1f?=
 =?us-ascii?Q?/l/o3f5u7Zu1L60basMrYS24yFe9WAe8997neuVor5NQK7FIFY47Nd/mDb8i?=
 =?us-ascii?Q?t+R16rzFG/RbHxrd43fLT+aWau22VlKaIwh2mNXP4ljpODcDpK9AN3uGi80p?=
 =?us-ascii?Q?TXrGVjPjWboMr5wYB1oseFe3gWo9BxWPTvwCLAzO/A2tKi0qKj7AORGsPXmN?=
 =?us-ascii?Q?T24tJK/Fo6zEkXAxyfOeO7EcYbDD3x5AW76mbk5r0Cu/zX9YGS4SEzLMoI/X?=
 =?us-ascii?Q?oqmjF71rjKv7QSzhUOl9b4NTxlzW75yriex+nO6VObtge4VAmEAQYS+EycOm?=
 =?us-ascii?Q?IbBGjCyiQFtTnm05p+RcipEXjmP2soW2MpxyctkJkS54dwxfryGQKQV1tXfS?=
 =?us-ascii?Q?033gCKK40DxzeotSoBPLJeTOaKgpJDsbdZVx6ZrTfaTXbvvQtgRLc0Y3oxHm?=
 =?us-ascii?Q?wF7wdN0fxVv/oqkVU9SucRatXXe0UHlbXFCPSzLV+JEqMk+zGLJsYNab0zeM?=
 =?us-ascii?Q?Y8e51q8GX33dy7hw7CHgsujUW2Vx1eG8xMBzadNEcnJcGN2+NAbzgd/D0g8/?=
 =?us-ascii?Q?y3TaNtazh/b3iveqFUJ6kjWPEg6jDJjCywtn2pVQh37M1XrWk+GUxt5KBFLy?=
 =?us-ascii?Q?lGITwWMb5QyAYKDC+1nR7MvyUOdF4yD14av6D/0tSYucHE2S7977IeiKh7P4?=
 =?us-ascii?Q?ulQZn5xaUEtTYTT55phVQyw3Vj0qLOBV3JYQ15e1WzIG2rdDHqGl5FqLHIe4?=
 =?us-ascii?Q?dS75dvvodrXOAjsM2pNkLI3mqXgSRPGsAchwfcQJpS9nrPjf443hz3zP1Kmu?=
 =?us-ascii?Q?B0kDXXJhBBH1w4D1PMGqt3T6Yb8VIA0FryGdwJQrGJwa6IZZjkEzExw32tyV?=
 =?us-ascii?Q?8ebcWVF+Qni0pggCVRs6riYymROeFxXEbrp7bQpXTkVUjecUV/t1cQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zlFT2vKeWy4DfNayRF3DRqmu5UPS8iiQxi4bMtKhmz/mkOJbsQy0Tb+Ws2kG?=
 =?us-ascii?Q?6vspKc2S7/VDzsAWSkw4+/aD9PD1oaIjT9k11yeoy7Kn2GH5DukbPa+SrFyq?=
 =?us-ascii?Q?H8irtJB0oPOSblkDb6ymYOrtSXuc+48yJULVy/hdQ/FUrCmgozAs5Zi1SqLI?=
 =?us-ascii?Q?0NTbC3w50Yuw4750fdgPDAQvU0MEstoMjLpax3dvHxLviRDMG4jTLIbf5u2z?=
 =?us-ascii?Q?Rt/bL5dFPD5m2BOKpVJpW4691F2zwOyKjvHG5++2FZqiaFqb5pjySDLMYefL?=
 =?us-ascii?Q?m4D667lhBBN08HckGamyOnKMx0mBOCmVHhrMHAK1v7n22C9L6zBOgSt96fC2?=
 =?us-ascii?Q?RWvQx+ki2VPL3oSWjJJLUD4oMCwDzrnvcfdyMcHcmPoytLct3v7rYxCdGJDV?=
 =?us-ascii?Q?DdGnxJqBr36gxgc77g8eTlFGwfg8ELzfVj3fanzBFwVqJ8jNrE/k/U2ZuA+q?=
 =?us-ascii?Q?2XtHjuNxmdyRfDpidhwdyxlmO7WeRWqXW07sZG/h4XK/YiNJwFr7UKmenaw5?=
 =?us-ascii?Q?jYXmklD/1ykNdQtJ6OJxW2hHn/db2xPLRedRGBWEYsZxK22/09B8KGH4ZPR4?=
 =?us-ascii?Q?TTetTU7zqWdL4dhhw/t5QNv73y/Wt5iz10E+IxLCpHEAehtAB38e1vu83s+7?=
 =?us-ascii?Q?7asmZcqPCWGLdYHyoK4a4RSd80LBcU/2XrlN2jl12ljfV12wiYd02yZ/AkxY?=
 =?us-ascii?Q?U92bBRT4iXu8qk82Wksc83/8mwk2VBPEp71pubIQDazdmje468eIMgp7rFN1?=
 =?us-ascii?Q?o2/CmFEVvS+u18ZfGTTLT181h8rA+zUwoN4/4dtcULFvJOy6EHyz77X3u2rQ?=
 =?us-ascii?Q?fNNIG3ZbC8wW2GnUHSLKaww625McKhDzUjYMHag1bQLB+seKLJiFZW61YzII?=
 =?us-ascii?Q?tBOhcWuUK4DhTx9msDrXhuh5VwpyZ2TtnPPiMOxIzlXntAPwSY/dWypj+JtG?=
 =?us-ascii?Q?/X1455EOVAaNRDGrVWxrQm5x/61AwKFXr665nxp4v9QYBWCZA7nyl8Z2iKgb?=
 =?us-ascii?Q?kgV+GVKpY1/K7b8GHCEPYhPBMTHNHxwDPBb3LPJ7rMQDsqUefHL6rOIZQnY0?=
 =?us-ascii?Q?KAFBUH6P50n1PuHzlaGVlH1GytQS+XGPzeIhL1rqzqn5GzsAX2bVTXSBhrar?=
 =?us-ascii?Q?L0GHuld8mrnd9FniH+bP4gBZyQwl9+BKGhZpiCdtBXO3q4llO65UL1rVt//+?=
 =?us-ascii?Q?hUmlAhhTDCqrNnbHt7vqawXiw+ACB4R7nECr+LAk5r3X/AZKkwFxP1nHFz4r?=
 =?us-ascii?Q?nPD0aRybceH5kEEHdaDImuoHLXiY0TtK/72VMKYLsW0ltZWrtB/afvWl2YuL?=
 =?us-ascii?Q?nwq4zIPJXgGhsu8qnA7x/dMRWZumAnrwGyDIArqkHcmJJKcR1OwPLQ+cL2FC?=
 =?us-ascii?Q?5EUYS2uOLaVr9YfDIpnXchhc8iT3lACrojP01iiYJKiW3bMr7iOVZHTexsPn?=
 =?us-ascii?Q?LNguNSZkiJ68RLm+DUhzTYE/qoesiiBFYLARkScy/s+xd0kDKBzZVQ7VfPuu?=
 =?us-ascii?Q?FGtFJk/vIcfdBEohn+F+i5hh+3H1KydY9UDgFnWWEsbescOT6PD19K5qiBEg?=
 =?us-ascii?Q?KcE3pzLCBeQmLOel7cVAuUjMIjAHAI1WXIr3EjJRMl4anQbEwwWeWPtevQap?=
 =?us-ascii?Q?yvO54gqB7ZDDWmp+/+NDKTI=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947b0b20-f9f4-4741-677a-08de1fbee25a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 18:36:23.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW0FMEOz+HOJA3mdp6M+Xc56TG8gnIiyhO6ok/APTwqbMwc2Pp52s12No8drr5dj/LCrCP38KVBIgFAl12kOfw7qTw37b6a6pFYiEvnb0sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB7064

On 6 Nov 2025, at 12:05, Dai Ngo wrote:

> When a layout conflict triggers a call to __break_lease, the function
> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
> its loop, waiting indefinitely for the conflicting file lease to be
> released.
>
> If the number of lease conflicts matches the number of NFSD threads (wh=
ich
> defaults to 8), all available NFSD threads become occupied. Consequentl=
y,
> there are no threads left to handle incoming requests or callback repli=
es,
> leading to a total hang of the NFS server.
>
> This issue is reliably reproducible by running the Git test suite on a
> configuration using SCSI layout.
>
> This patchset fixes this problem by introducing the new lm_breaker_time=
dout
> operation to lease_manager_operations and using timeout for layout
> lease break.

Hey Dai,

I like your solution here, but I worry it can cause unexpected or
unnecessary client fencing when the problem is server-side (not enough
threads).  Clients might be dutifully sending LAYOUTRETURN, but the serve=
r
can't service them - and this change will cause some potentially unexpect=
ed
fencing in environments where things could be fixed (by adding more knfsd=

threads).  Also, I think we significantly bumped default thread counts
recently in nfs-utils:
eb5abb5c60ab (tag: nfs-utils-2-8-2-rc3) nfsd: dump default number of thre=
ads to 16

You probably have already seen previous discussions about this:
https://lore.kernel.org/linux-nfs/1CC82EC5-6120-4EE4-A7F0-019CF7BC762C@re=
dhat.com/

This also changes the behavior for all layouts, I haven't thought through=

the implications of that - but I wish we could have knob for this behavio=
r,
or perhaps a knfsd-specific fl_break_time tuneable.

Last thought (for now): I think Neil has some work for dynamic knfsd thre=
ad
count.. or Jeff?  (I am having trouble finding it) Would that work around=

this problem?

Regards,
Ben

