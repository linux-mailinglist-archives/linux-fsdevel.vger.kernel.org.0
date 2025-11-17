Return-Path: <linux-fsdevel+bounces-68790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 223FFC663C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77589360F61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 21:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6434D3BA;
	Mon, 17 Nov 2025 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="FSNFuWVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022136.outbound.protection.outlook.com [40.107.209.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E46260583;
	Mon, 17 Nov 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413995; cv=fail; b=PkGaX0acMl33Db4NjTjijIamOv66o/C7ehS/28hZeIjufbkHK/u3BD3tZT8DlbyCxDlft0OUFHEsf5rVKbNC/GseQjOXn+irwsTTmUfsVpepSXRpUZoWI1mr1rZFLJ4MjokoZZHxXUH8uhHL/l48lEnp0tMQDhqiPPGg7nAMjpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413995; c=relaxed/simple;
	bh=ogRcBsMUhLmBpleceOP1+3xonmgjR74Qbb03OmTh4bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ikol76kLmv3Pc1sSfKQZQcikbxdqgf1zCWLXPDZpH/hBmNSLh/+qrhXNQjSEirBRcbFK4k4nLsUmDUp4hAJzUI3Z7xwQZoeyhalzg0aLhwKWkJvrf5zOOJy43Ayz3VgxT9ILt+2pC8ZQHOLVWIbgDr9ffStUSTIEm13+zUDqJKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=FSNFuWVt; arc=fail smtp.client-ip=40.107.209.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P11pJZA10eAF6fGp5ybsNCtbCTXxcZL3/pwuMOejhJEl7zB79EWt5pJnZz2l6SnM9Zin8BnhFpjCQCJOcX7cQHMYYAPL4SWyX3ouysJgBoEOst3NFjDrP9R2dhXInwIUAXyMVEoLenJN2Xx9MCMpzRvibmjS2/040jEQxkSUreEBzEmXUhR4Ts1Qxzzv0pOVFlVGMCoIsWGU/HpdIlOX0YQdyXvjBFN2oq4oiMBEMwWvnlybBSbIfV9WkSZlhecgc5o+FGVRRz6fT8dDRFaj2W6vfXvwUkKoBPiAIK0YYJzcgsnw+znYPdkw+/t7zdW/lXC21GkBALJFTfwJNP5dSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjYyNj25YQ/0l2Co1MTM47Fq4ZtT31Xc8CKWd2bMV74=;
 b=oRckJ4LFV9xeB0/7eFdHu2SkCpZlzFm41k2gQ1U9EwHtTHlWzoatn7tKziYFIStMKyj/ZSpzzop31mhuBzc0zs6wKF4zXXoy0nyNEOgi98YXLC+ammzy6/matYOyaqpGHVdrxc5F+Z1D9AaYz1EbNm5gRjirPyWjZZfFYvdaYeCJY7oD+y5/0h/55cDujWvnU6cHkRZWsy9guXjwQQLqlwGEKZOol7zQ/QLBcqaaLc2lhrb+022bIcfN4w6Ldqk7D6xX2as7CsynREazxl5a+TItdv2oo4gASrJ5i7PUiivxEfSmslSVnc8/ohxtA8enyyrUHV2LD59vlqYFShAj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjYyNj25YQ/0l2Co1MTM47Fq4ZtT31Xc8CKWd2bMV74=;
 b=FSNFuWVtQnE0aFylsj8mKCgSvu9IGhf4vaFks8FyNO9FfO+NRWkcWXKNQMEVL6dTIZABbVXsMVM7qA/a/35aeK31PXdRPa0ArkpzyVEfoUaoYKT2/mwfPyh9v3LXVwri6mZZgVfhHh5bhNM9n0egL735t8ARuLj6PcDP1ABZ/20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by SA1PR13MB4975.namprd13.prod.outlook.com (2603:10b6:806:1a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 21:13:08 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 21:13:08 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
 neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
 alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
Date: Mon, 17 Nov 2025 16:13:04 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <09209CBD-6BEE-4BCE-8A13-D62F96A5BD87@hammerspace.com>
In-Reply-To: <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com>
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
 <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
 <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:510:f::19) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|SA1PR13MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e2ecb6-d21a-4d49-195a-08de261e1b1b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4tG4oKCkzPawxqQa9ZWkanBYVsbGyGLm0W/udbuXanRdhT+/IM1nYyQ/tBsi?=
 =?us-ascii?Q?B/kFbAGglgmUhBLm7BOHbCBTn+RuWVEhsgeWOSPWAwT3h0pZI9T/UgA3qbz/?=
 =?us-ascii?Q?l4F9RKgU2QWdHAbR0sbQK6AORUuZnwVN/4fHMmoyD6TE19l6OIaxAtPjrpuQ?=
 =?us-ascii?Q?6O/cgQWErbwHw4/d4iTL9MzuDDPajVuwT4uCIT7P78ty45uXP+UxCp8OBW0E?=
 =?us-ascii?Q?2SAycOHbwK1nhSbjdSJ837mQ+oTkusM9whHnJ4YNFvBaM6Jf3mU1WG6txheM?=
 =?us-ascii?Q?meypMlCcJXRbuXpZC6fFcUn93i1sxTjHTdoZYjqZXLtK2sCtZWgGAw09RIBT?=
 =?us-ascii?Q?3E58cb+4iZQl1q7g2kLHSri78Bj/5LPpBJWONE2rLoBBM5XLPuVggg/Ov028?=
 =?us-ascii?Q?ZfAUItIKoFA3+Zd6qjg0sMDnF3vqCZ1Ra45OozBsaXRKfmvcxlJiSjcJsKUv?=
 =?us-ascii?Q?fIDzxXKt+0YG9VYK8FZHG1i6gul7Z8CLdEUPp6iTpiElEkAdtuWjCfidG35g?=
 =?us-ascii?Q?ah987tXgr0Yu1W013r2DY8sQgHhxlqoa6hp+0YUWnA94g8aYr5u+9CdqeqRL?=
 =?us-ascii?Q?4qnvKv4FrxLf9dNommZYAvQBtJKS07RuSk9PFW1PWcY8FAgh5WcnzWeIGyE8?=
 =?us-ascii?Q?ySQenbEaZ3F9Dp39XZJ9Xcpa696ERDRpt90oJenbMXRkFkc/lK0XEGJ1X+bw?=
 =?us-ascii?Q?d2X+JkGgaW+px9YtAzxNwGQetr0Pe3TNfyyAkeEs9jrHW0zanrKiYwtGsW5E?=
 =?us-ascii?Q?uzq0Ly2vuHYPWIIXv6kAmU2WjKZTWk80CDGtAf393ci8MWhE/F6cW90bpKs/?=
 =?us-ascii?Q?+i7Dx+bA/Vzjds45Ky34aAXRlf8Er8iXYz041fjfxIuPH2d+nzKszdy9USJY?=
 =?us-ascii?Q?DUbkRfLYRScWeAPDKMhLPAEntNQL62huEJmAyEfP5JQmfE8q5Nd4whSnnh9C?=
 =?us-ascii?Q?jgOlvnDCdvaU4/vm9IdHJAPZI8N2qmZrEFL0w5WspxipEN3eAsOM6Tnt1+eW?=
 =?us-ascii?Q?mgOhp2pWN7TH5cZuRaL9O1Odi8t75ShVeX7WGQpuJfBeS31iEF2hXDbunxl9?=
 =?us-ascii?Q?w0z5h03NoJxNCdI9diOawvfehCowcQsDbX90xbrkuau4RL3+vNCPlOITx+M9?=
 =?us-ascii?Q?tmnqj9CSlKsYA6Q2l38gTvWQwAMgn1Bd5A68pNJkFwC405s0N87DLPTMgd18?=
 =?us-ascii?Q?VlagPAZ1VX2IkkjiKuq1IHUB5SVNpo3Z8eDwOL1s4AcgGAuNmNWnWt5xoMw7?=
 =?us-ascii?Q?5HZk3uYRIU5m7t4LE/Hskp/mrUfH9F9813Q0thK07IdIeUhmyit5Efkc4/ji?=
 =?us-ascii?Q?+6XMz81cCp1/dDnMUyMCVFJut3zymS6BSlDhZQY5n22AlRJ0MavU/EGNpPXP?=
 =?us-ascii?Q?S045GLyPOzl/ZwvGjNZBCp7vJKBzEyQ8wmcfj/5tAEZC35TfSpA9ev4H7Sw/?=
 =?us-ascii?Q?0Yl1n8Ey0HJxKzNN/jHTkqGFEGMIbaPE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/D4URUmzkti4uxdiSM3C4XQIu8suBz6dt8+EVPU+NMgpYmotHlCDcL341nVw?=
 =?us-ascii?Q?vmb6nPQseUCaT7hDhpPDXD1z0S2g6GmRbhuwtQXgG3+Jg5Yotx0qtP0kF1Aq?=
 =?us-ascii?Q?VaoedKJxHCKL83D4yIA4hGT5l2cQFZnfn8HS2Ix1RrWCo+Y9NYX4qWVbvyM0?=
 =?us-ascii?Q?TMfj3+G9DMrIpfUPf1UMtx3ebanwZGPBTve71Lhr6WnE74REWqBBp3Oq8tQi?=
 =?us-ascii?Q?iPYKeVXGExqoqxgYh60R8vme6eWKJlJP+d54ZSDcBwgLY1rUTUS+r3G9hpHJ?=
 =?us-ascii?Q?fcORTHMqS26L3UhCt/AYOybE6LTrzS3SVOdNwqWWCck4zxy5dWrkvVDLCXsT?=
 =?us-ascii?Q?uBBxnWOXlKl81p3STSPOFLXE0RVA0rv/W+ervo68FoanVKOmkMAJmn/PREsu?=
 =?us-ascii?Q?PAIePnOz62BvdsajQ3bso0ajeBQ+zl/YPpnLWdhJCHJ61VGOVYJHoqVmh+5X?=
 =?us-ascii?Q?BbhuQVHlg4VPOChegxNOkVS971KyrdUVnDZMW76sK/BgnReMvOrQBU+hsLvz?=
 =?us-ascii?Q?XVpsDxt3Fq6/L90IngkuIUuidbOcVrWqsSf91W9O0UIA5L1WkQnj5LVz+Cg+?=
 =?us-ascii?Q?4XuuoWonRoggT+PjwunmSTxjTPivTZsdxhoUV/wzsqqm77wLGRfdJ0xAj2oH?=
 =?us-ascii?Q?LNzYokHNtRXPpEtAOPXQ9AAQAGCnKComsWtcgN3c8D/JzguZd1Dbgj8Xc2aM?=
 =?us-ascii?Q?hrsLs/b+JZgyjMjiUHbq/A5i0USx35uY8mL9GJCBkk96LHmolcglRGNqtHqE?=
 =?us-ascii?Q?ToUYR1OsZjEvbn02Q0gn5zaYcOSbUQCzJcPSgZk18jkECZ5HSpwryX5znp9M?=
 =?us-ascii?Q?wzfRfjDuHAP0DIALmuTjIcLyWPZOu6VMT3h9QjzdO3ktNauksFkDkJxz2b6h?=
 =?us-ascii?Q?x+5G5pzmn3JgZKFsJ0xboXy3kL539DZ0qXUL3tdGcMnYt7B/LDfGYkck1gp6?=
 =?us-ascii?Q?uGjfB+AyKxmCS2dMPmlmDYG5rKo1xau9Zo+pZ2/pCRbdJmFRluCfQyckCc8V?=
 =?us-ascii?Q?q8d6RxeC1ssTrPr1BhJnJMyS9urZ966zrG3QzACnGLegqwzDZbWFLaqD4aRu?=
 =?us-ascii?Q?GOGlnjpA+Re7tDEbmC9OsoYDG4Kb9A9E0vEo+GHn0G2VFSxHB/J70K9BYz2n?=
 =?us-ascii?Q?PfE+o++crJpMUfJmi8MDbCPFnRbupcITRc30Sd/MfTmOXLJxR4P8XCHGFpZx?=
 =?us-ascii?Q?17Qj8cStowzLvc3pS1cOoZJIgl3+RLnz1r12xJmp914zEvTtYk+mGnmQzVF7?=
 =?us-ascii?Q?mbVTdnr+6x0Ti2HcNmIvAN8a7yj2Sea06VW0oSYB4+Yankg+Q/mE2mpSbTXj?=
 =?us-ascii?Q?VYuK1Xyuvln+pIaRiB9jxZ1EIU6qzdwlopHmEl6w31VQyEWqMpesP5OaNFbS?=
 =?us-ascii?Q?PxSjpDMJTTERgXKGMtTrH3uRb0nqIe6ge489t3SP9BhvvNzXYIdY2Wl+lSBC?=
 =?us-ascii?Q?x8gOYeyG9NjHOHySsVnAsnkfNZnxifQsf9JNQhxrB9gw0CO1gAJBBY4KAADD?=
 =?us-ascii?Q?BNUSj4LfjkB9LG2LNaZXYh7YdSGQmv1YrKhSEbjVNlIK3PE9qabm0V0qjdfm?=
 =?us-ascii?Q?DkWfZhjAHAhjnz+fH5ebHKKSmtk4z9b3U5u+RoIllnav52kNaRRb9M+Dxihf?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e2ecb6-d21a-4d49-195a-08de261e1b1b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:13:07.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXKRB5IXZLNyUQvIH84vxwL8V56VbDxKcHwnr8kmA+wpo3L0GGJH8m9LeoNMAmMPc4vt3VHFmD27kNEhEoSZDWxdMOofVUAf8Girn2MLvfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4975

On 17 Nov 2025, at 14:40, Dai Ngo wrote:
>
> I will add comments to explain the changes better. My main goal for these
> patches is to plug the hole where a malicious client can cause the server
> to hang in a configuration where SCSI layout is used.

This would be a mixed SCSI layout vs non-SCSI layout environment, I assume,
since a malicious client with a SCSI layout could do far worse.

The mixed environment is interesting, but not well-optimized.  I think if a
non-SCSI layout client can break leases, then it would be impossible to it
from just walking the filesystem constantly to open and redirect the IO back
through the MDS -- another DOS risk.

I'd go so far as to say that in a SCSI-layout architecture, we must really
fully trust the clients.

Ben

