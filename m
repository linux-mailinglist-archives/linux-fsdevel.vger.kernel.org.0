Return-Path: <linux-fsdevel+bounces-74189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA68D379EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCE8530CAC04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7F336AB48;
	Fri, 16 Jan 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="gzRqRNJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022130.outbound.protection.outlook.com [40.93.195.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8965E18E1F;
	Fri, 16 Jan 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583870; cv=fail; b=rrTBHLbgmYFgADK8R69ta4ofCGiot/4jvWYu9kvwlxJd995PduijyTvJ1ve9nltLQMeFPG1GmctU5B91MWFBeG/4edkH9CTVSlllRodXnGblNOchlC8ctaYLrqYkBdZ/5ui3UCvZKtonOIkLakUWT+KmB+hPg1OlMwrf+JxIP8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583870; c=relaxed/simple;
	bh=FAI2FYkc77xsJNbBk1j6Ch+TOmlIjqdlWrMT6KTWyUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VOtMRoEfa5kJgma9ZxBOQKY8o7zkr0HHfJN/I5L9kWMXBvNrpgT1nGDys4D1SLEbsTerQ75xOmKiYTzexx52BSitGMUj3YgS1SeE87DIYi1nImEmvN7fHB0KWGhe5eqm2UrvLIa0UVnu6vm2TIwXhFyv4oUMHtyCE/e6g2yEVEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=gzRqRNJM; arc=fail smtp.client-ip=40.93.195.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKW3ydQWXAQNHYSSfGlgwaOgTaTa4OLNFkKtK67Lf7D29by07MSgbriHENb5re4LSXYhv5OIawGitiXj8+dmx9uFbygbxKC9Wmbw8RHW98OUPXxtje0jfY+RcCwr3IFO9M3nNOdtKa+0NOjuPTCjDyS7/Ad+ZjX4qrkLqZ+RkALt+tnp9reI+FIvsG8HyYppDA3pnyAij1VHmo1RoHrXuY2L6yapOsamaF39uuCpfKils9bBeDxtf3c330LbufNOR3RsaW52DezA3F22nyNLweS3KC4p8BPv3L5ZgPM1NfMuhbAPlfewugghkNvyXwN7d5vHt1d4oJRWJL+Cm3pazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmhR1mu7gaY6QURtJal0dFy2s8CvT6CqWe9aN8B0BG0=;
 b=quIi6Di7SAsNGxJ9+2AYd9vnwQHas+ChvmtqD3NdAwBYCRx9A3HzoLhxFlRiNO7gskDrzmQ1yRYYVaFoVVBzUmokhsObPtIhBCS0fVBssxDsomxcsR/8s4nVWtpfinrehFewn62ZbbjP0Ih2miZY2SledWsWbXfVxauWp65fXyjQ8SYGnFKhcq64cepBohKy4Eyg4+q6gpT+Br/SgPhZ+SUuralvQkp+PhwYxms/LgReYeYMLdviqEr+v6+Yo0kGk1GX6a1NYxBgOCoTL44QecJKixvYX8WJSBSmlanKEBMWqUab1W/Gm49vqV3y2cdxdd2UCegeKJus0L/ILDC9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmhR1mu7gaY6QURtJal0dFy2s8CvT6CqWe9aN8B0BG0=;
 b=gzRqRNJMyA7wb2LTVSpF9AsBUC3GLfGMVRpCerPbRJKJAENOx8LolsWYRazKOtmglu/tYsJ58HaPf812KCk9tskfi5QZs7zxwa7zK8DhQ8EKogopoXlf6Wbw5fQU6/z11K8GD2ukUy1x7t6At1kc+aHWXYXHw4CE39P1YbOQNzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 IA1PR13MB7278.namprd13.prod.outlook.com (2603:10b6:208:5b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 17:17:46 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 17:17:46 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
Date: Fri, 16 Jan 2026 12:17:43 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <C69B1F13-7248-4CAF-977C-5F0236B0923A@hammerspace.com>
In-Reply-To: <f8e2d466-7280-4a21-ad71-21bf1e546300@app.fastmail.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <f8e2d466-7280-4a21-ad71-21bf1e546300@app.fastmail.com>
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:52f::29) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|IA1PR13MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: a225bd7b-104c-4205-6c5d-08de55232a75
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YxGqTelNsJ2TZ/J4uDReBtGLddSDlXs24vGK9d7DMJfHfhszxP/L8bN9H67f?=
 =?us-ascii?Q?Z0v4oNXzxFqfTHHvu4hSPwq/OIar+1MbReCiCxBUjG6U9bAr4LnKe6zP3uPF?=
 =?us-ascii?Q?1L1xoEW9WFPtv+7tl0BBxz09gUKZaP+QPScRVcQaxQDCNvcDyOblgp6QZ6Tr?=
 =?us-ascii?Q?xgj/3alXwwMxZoPmBFM0fRHvpY5w6XIiTmLQAiogwWc957hgR/dbQnX1+B0v?=
 =?us-ascii?Q?ZOv7eWoB5JU9uqbfOEnfRMeVDSnEZJEIw0enIbL1wRHSnA5cSfp+CsI97RrW?=
 =?us-ascii?Q?XhI40tm8Qiy/co5HMf32GMDfwzLrO1kLYVp+UmKa81GPZwEBwpGIG+7kjdB6?=
 =?us-ascii?Q?jyQqQInU5e9tmRgV1rvyec/GHhX4EO1bwW4nKEnYDhaGFV2bWfsbistLlix6?=
 =?us-ascii?Q?cVX0/XgD8uJXAegwydBvenflVemrA9FJ2a2qRAF7VKqblXCqVvHF1aV3Cij5?=
 =?us-ascii?Q?o3kIlSSieckYGir42f9T2ij4JhpWirUkHTtY8iE4WIVoL0nAF6aF9jD/wle/?=
 =?us-ascii?Q?fWjn4BbE++u2cSuhvNV/FckJqvmXwuQQq9GPgW5B+Osq5fa4UsnjOajcGsIw?=
 =?us-ascii?Q?NlVOtENzn6YdN16v8S0oZ5WQKz8WxzHXEwW3W4LSUVo+3eSoTPC4ktH00au5?=
 =?us-ascii?Q?UZToomxHZYsR+/BBqiTTuFjWFN/FmcwYeH40qqYfopwcsLn12JfPYMycQ0Sx?=
 =?us-ascii?Q?akdG7lS9YfKkrXROmTJbyJ74BAWTacq/J3/S2eYhOi43SLhBOC2X+i7BiclO?=
 =?us-ascii?Q?PVHVQNmhG/8etG7g8i57jDs0LGqukgN/+jl/FZ0SWU3jbT7CSJSv856gGUvF?=
 =?us-ascii?Q?OEWKBzp033oKU9/Lcv+uMZVRDnwh9rfN5V/9fC6v/Lb+UjwuKKhpFW4hOyGh?=
 =?us-ascii?Q?Pxnau32k0CGnP1ahmYDWvAWRjE8QhyYR9mVhVOkfHO2GDxNK5AITCTc/2jjW?=
 =?us-ascii?Q?wUX/x+feZSpQ8L8Nx4rfZIptyI8BfgYrHrA1AlxdCms+IsbWaOkE+joNdjqR?=
 =?us-ascii?Q?G9Acw/Vysdn8ir0wUwUNt6yKk4xDb30Uv/Di01xGq7SoIXb+W7eVeurTXp5l?=
 =?us-ascii?Q?7fXUrm23g2ZrsYDq1dTuVOHkDDX3GyqO1u2D1tGrL3G4d1aAC4CtE89/OjZd?=
 =?us-ascii?Q?lyf9u/DR1Pxj3Vw68ISQrvKo2KDlFiMvrp4brVAn2FUyQxQPAXhs5kCUTgBX?=
 =?us-ascii?Q?akEt4pD326wlZaj0XP61yzY55sCEwmLrFduwF6EycFQLy2UIUwoUWJHD2r9n?=
 =?us-ascii?Q?jJbDbQrjaB3sCrCW42xbCfbzd8NhwneuGyJZyoBPtsAgiG/nyY4cQpurpzrJ?=
 =?us-ascii?Q?7WsGX/omZUCWdH2uruZpxdx5KQtUk5mtX7uEgktm8JpLjOL1CMb0Xy+ZSIWh?=
 =?us-ascii?Q?FjOUDnBnbMCtvCGZhnS/yVTJkEZZDq6b3IHxVjHjk/+v/HQN5ei3vwdZlQ/R?=
 =?us-ascii?Q?+dk1jerAiwocYaom5ePXJ7/9474cN1VT++X10XKHfKTH4MSKBM1+7wPRX8qo?=
 =?us-ascii?Q?G9uddChxRtWUFfbYegkTiahI/rc4u/gpCPBpenzYz4oew4LsGsceDNQCAgNM?=
 =?us-ascii?Q?LDJ5EicR4HsTEJzmIKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BoWGrFv4Duj5ZYDYisViZFhKYY4YmbPQsbHmZzsD/EenUYz4Ybivki/UWi9M?=
 =?us-ascii?Q?HCwuCISLFTCpCrMJeMMc9AmoLH2mrXF8a+Ya57Vkb2kPY5KZG1YbnROK6G9C?=
 =?us-ascii?Q?95pK/MGG+5ENESqNi7IoEOR03wa+Q693otzrnV5Oex7H1NaRCdJjJ7avD3o3?=
 =?us-ascii?Q?c68sMfzwqSV74PP70VHO2LjW+n84oHII4GoMbumWETnnq2keu6unEKF5vsUQ?=
 =?us-ascii?Q?XqujpnLIO/hNRckgHorqoPbzRccm7ilNF3rqiNc49A3ks7kDnhto5H2Zx/YG?=
 =?us-ascii?Q?tRFXepgg8z5JVkmzDeC2rJMbou0W6ghYlrnb8ReQjopWQrX8y3yY0Hqmqz7D?=
 =?us-ascii?Q?lBAZWTET38632Lr/1XyMT5n5B7CgVZoClH38rWAjdBO4rL4EzL4019N3il2a?=
 =?us-ascii?Q?FqaZQYSjo+kRwqjDq8jfKVCIuVe1OUrvvKJZEta0tslHKWGca0ujuhhHYD89?=
 =?us-ascii?Q?oy7H+UZO/pMBiiYWwD0VkTlezy1lGj9sQrJYQHqwi71mtURD6aFSdW8q67iE?=
 =?us-ascii?Q?vNJE0njbyTpoosToBMIQ2HkYs9wWkk18PXys+XTrsJ4YvCN2j7RtS8VTWZkA?=
 =?us-ascii?Q?+/4g3by80MlAPd8KQdPqUlOOEcavJ1Vdsdua5FgITykbses3SgXRl9MDDtT/?=
 =?us-ascii?Q?fcQ3+3z8bOf4U6VqLtXCKq7h7PJEpEzXrsv7/7DO0skKn5RxFq/5impGZZNj?=
 =?us-ascii?Q?TIrTScmXzo52G4XYJHceT/9F6rWwiGBrdA9NR46GFCZ+d4yYHjy80cBnqq/a?=
 =?us-ascii?Q?fGR2t4eKDABMg5DLhwcA//M3kOWYgJ2ynt49c26sfxzS2GkOj5aRYV/U8Oon?=
 =?us-ascii?Q?3HpQKdwTkqTNkPR7i/5yqecZttFXMISvVtEQWuvtVz3Oqrp5ayUUf0oYe5y9?=
 =?us-ascii?Q?yPbhN20lpI2pwiUi6iKbB1A2j5Sj+WuRYqeKH7DftBfZk/UMfoKOPTa0FJCt?=
 =?us-ascii?Q?ZjY7Yc4K/Nhc3x9yzd21h3r9fNRY/Wh25E7yVE6FDM1TDVidSQjZvLvcnzh2?=
 =?us-ascii?Q?8iVSd0GGcsUS/J3J7nOY/H8oFwOUFDKRHpR8xbXuk2srPB4/HUXt/p3jH+cu?=
 =?us-ascii?Q?GP67wB2jmsXD/Lgkg0xPNneeIOiTSDmEAOoB/A0W3ia8jV91EtQtrh+kE33z?=
 =?us-ascii?Q?WKzmLSjWIGkV6zWIIuX3xB/cllVwkkTqQHyRYYEgtNehJfJydGBysGUAAWP+?=
 =?us-ascii?Q?ShsdZs2659cOh9eS6RchrehJ2ihQIXF7zCqLPt3yvespFFaxgNXV4g7LkLxY?=
 =?us-ascii?Q?3GhTqEL/aDmNONhOUPQeHnmhm4AEl0nhCfV9gOuzEckPLYXmORN9osKhbVFA?=
 =?us-ascii?Q?RskU0d0S+2XfyRXyGDxQj3UXZ5GVrkgryksk+fXGCOBK+XdY0tO+cfHbOJkd?=
 =?us-ascii?Q?4+WYumrQAhW7hxys84r6reuNvWqymbwiHUwwrZl1DpEhNzIx2DFh6VZfGoka?=
 =?us-ascii?Q?fHm8A7Jci2pM3dwTAUETQ8DOS4JkeB5THDD0ktbAamcSXZqN7qZ1fL8C6+Br?=
 =?us-ascii?Q?qF/bQF4V7bhDxPIpb58JjGJth09Z+5Jot+6k/QcTvgY/O1vbKx775tscJfYb?=
 =?us-ascii?Q?EtApxX07Zcu/vx3mQzvrSlP8Lcx3HAbqNxLt8i3BMMVmWwMSfRPVIN/leny9?=
 =?us-ascii?Q?zf+xX1c9J/+2uphRgFgqm9YeO8dp1JcbwR0dyIEw99K82QFhZkpG0PBj7Xrj?=
 =?us-ascii?Q?Bf3aNSApobS7Zra3Zu2YCveA2ytwfTXfnd1baKncFs2/Krz88NV7VZdo1Ujz?=
 =?us-ascii?Q?aiqXrvs8YkPHA4KZC/9tXWYu1AS8emY=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a225bd7b-104c-4205-6c5d-08de55232a75
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 17:17:45.9882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOgxju3vsUo/tEGqU81/JgXILokcHe6Mv3uIXvnS0Yzq05U0mI9rGM+ftU/dGpneqDqqG7sx6eDeevCIrDCQAhybtBQgSMYQVN1pQGNngpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR13MB7278

On 16 Jan 2026, at 11:56, Chuck Lever wrote:

> On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
>> The following series enables the linux NFS server to add a Message
>> Authentication Code (MAC) to the filehandles it gives to clients.  This
>> provides additional protection to the exported filesystem against filehandle
>> guessing attacks.
>>
>> Filesystems generate their own filehandles through the export_operation
>> "encode_fh" and a filehandle provides sufficient access to open a file
>> without needing to perform a lookup.  An NFS client holding a valid
>> filehandle can remotely open and read the contents of the file referred to
>> by the filehandle.
>
> "open, read, or modify the contents of the file"
>
> Btw, referring to "open" here is a little confusing, since NFSv3 does
> not have an on-the-wire OPEN operation. I'm not sure how to clarify.
>
>
>> In order to acquire a filehandle, you must perform lookup operations on the
>> parent directory(ies), and the permissions on those directories may
>> prohibit you from walking into them to find the files within.  This would
>> normally be considered sufficient protection on a local filesystem to
>> prohibit users from accessing those files, however when the filesystem is
>> exported via NFS those files can still be accessed by guessing the correct,
>> valid filehandles.
>
> Instead: "an exported file can be accessed whenever the NFS server is
> presented with the correct filehandle, which can be guessed or acquired
> by means other than LOOKUP."
>
>
>> Filehandles are easy to guess because they are well-formed.  The
>> open_by_handle_at(2) man page contains an example C program
>> (t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
>> an example filehandle from a fairly modern XFS:
>>
>> # ./t_name_to_handle_at /exports/foo
>> 57
>> 12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c
>>
>>           ^---------  filehandle  ----------^
>>           ^------- inode -------^ ^-- gen --^
>>
>> This filehandle consists of a 64-bit inode number and 32-bit generation
>> number.  Because the handle is well-formed, its easy to fabricate
>> filehandles that match other files within the same filesystem.  You can
>> simply insert inode numbers and iterate on the generation number.
>> Eventually you'll be able to access the file using open_by_handle_at(2).
>> For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
>> protects against guessing attacks by unprivileged users.
>>
>> In contrast to a local user using open_by_handle(2), the NFS server must
>> permissively allow remote clients to open by filehandle without being able
>> to check or trust the remote caller's access. Therefore additional
>> protection against this attack is needed for NFS case.  We propose to sign
>> filehandles by appending an 8-byte MAC which is the siphash of the
>> filehandle from a key set from the nfs-utilities.  NFS server can then
>> ensure that guessing a valid filehandle+MAC is practically impossible
>> without knowledge of the MAC's key.  The NFS server performs optional
>> signing by possessing a key set from userspace and having the "sign_fh"
>> export option.
>
> OK, I guess this is where I got the idea this would be an export option.
>
> But I'm unconvinced that this provides any real security. There are
> other ways of obtaining a filehandle besides guessing, and nothing
> here suggests that guessing is the premier attack methodology.

Help me understand you - you're unconvinced that having the server sign
filehandles and verify filehandles prevents clients from fabricating valid
ones?

> The fundamental issue is there is no authorization check done by NFS
> READ or WRITE. And in the case of root_squash with AUTH_SYS, maybe
> even an authorization check at I/O time isn't enough. Note this is
> the classic NFS AUTH_SYS security model; it assumes we're all best
> of friends.

I'm not quite following, READ and WRITE will have their filehandles
validated.. the case you might be talking about is when a file moves or its
access changes after the client has the valid filehandle.  I'm not
attempting to protect against those cases.

>> Because filehandles are long-lived, and there's no method for expiring them,
>> the server's key should be set once and not changed.  It also should be
>> persisted across restarts.  The methods to set the key allow only setting it
>> once, afterward it cannot be changed.  A separate patchset for nfs-utils
>> contains the userspace changes required to set the server's key.
>
> There are some problems here.
>
> - The requirement is: File handles must remain stable while the inode
>   generation number remains unchanged (Chinner).
>
> - There's nothing in your implementation that prevents user space
>   from providing a different key after a system reboot or server
>   restart. In fact, destroying the net namespace removes the ability
>   for the server to remember (and thus check) the previously set
>   fh_key.

Yes - suggestions on how to solve this are welcome.

> - An fh_key change is safe to do once all exported file systems are
>   unexported and unmounted. NFS clients generally don't preserve
>   filehandles after they unmount file systems. I say this because I
>   think rekeying might become important as the time to break a key
>   decreases.

Absolutely.

Ben

