Return-Path: <linux-fsdevel+bounces-79309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJzvLhGLp2nliAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 02:29:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C49C1F95EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 02:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBCB4309C9DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 01:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD4732F76D;
	Wed,  4 Mar 2026 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PbJxEn7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2930EF68;
	Wed,  4 Mar 2026 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587672; cv=fail; b=ComVDQwkq8bGBoEMx8xf7YzF/I9QVdwoBXoKB7dNIGZd4MjkwWLDl2KYXylk92bBsOOj3V7peSgHesLfiUgaD9ZStXyis+Qd+Zaopex35ryIxGOqrYUD8Q5QnDyYuwnwlc5RvR4hs2f9IQnVKnIu6W/VtvRgpkoScMIdAISE0CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587672; c=relaxed/simple;
	bh=7vCK/sxc+B4ZeJxzC9X2CSCD1lC5VfqOhXpqm+D2/lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1i32xR5u0N8nuJsWLcAAyvaLd+PEKzni6LdM9aU2WCrUP+ithbKvz4UHH+LwsDwxgM5gqmiZZ9WpWSaMxKBSGQ2uzccpkBJwpsHTOJwzXRjkWNN83Ieh+XkXZOUNwfYbxYOsCuRqO4+Zg+Z0GPDw+gj9gXHtvQYCxXaKe3TDZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PbJxEn7G; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtYbkjF6j/cckPMLctsjtszaImOU9ZmtO+EqP+j2ORwzMKxXJe3bI77aOmn2S/XcGc1WJD2/1Jn+jmpN2k7HdWtI98cFoxh6U1LnISGNxLoUTERSg8ZkCq7nbcM3s1SWZUc3LZ0uicurVNrqfwRWy/sFigwX3ooAJwgUh6ojU1LZQGSbkTgwJX9pnTpUe/Q06mwAoJUqNjxA45WoLouWNLJTKyoSiOESCs30dFHFo6NUpFzkun5u+H4UbcGLHekzkCKS8t+SC2Sa2VuJIhTv7gMa2Q6IThiQn7bO2xdA6huicZ4aN92nYkiRwF/3DHOfGOzoBLWitMyJ/SeQEH7ghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsJTnERJRzZhLCX7+/1+Xs6KkE2zo4OgvkEqpZE8A8M=;
 b=E18v9nkNSsHVeMIWL/LoI9pyKcyxfSMSgSTN/6w5RsgqPazWaDQO/pkYiIsYhPo9Vjx5NXD0KDMoweSQXgOVCYD5hcK5Z5xiyG5WDbpPWitzh3lK2o6gN1zvsfTiMpTemEVKJCjLhaniS+5peAzqo/sDCyjdPmBD/jzrS4k9tuXDEUPe+KKS0clVpUXhaQpREupcCVej9NQAzBGB+cvcuVqm4aY4kK3nx0bH+YqA5yqvwrI2SljsqAYyfjsuvyKEgj5zrHXXtZYVrV5BrKHtK77Inv1WPylNoqrBQLdVQlEUeUa5KDhfAL4YQO30v3bWPrrIuHu40iArdIVTXXuB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsJTnERJRzZhLCX7+/1+Xs6KkE2zo4OgvkEqpZE8A8M=;
 b=PbJxEn7G+bS4KSMUxBgg46xddct10ZkhjQScemEdN/gpDMagU91bawODu8Pdm5K18m52HIkUFZEJ1dEnBPuYjO114YrqnYyyJzoVl9XYneOhjptOiiBjLx69K7wokffoYf3xOrC6yyJzOzWWZA/r3e7X87i4jMdt76OuovlA8miRsFdS/ScO7tNNoh6pntyVsZEOLdg5JnnTlm3HPtBmqI+CsMb/KInoW5//v50YE+PlKH0cyo6iq0xtaN9m4s0Yu3h+dMmtFcgyWvud+zJJZ0yOtWKaeZrt1iDVBGCNtkEVqXvtVFetko+1VAu4W+2Y3bB3+mScPxYZLuL8xmi+dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 01:27:29 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 01:27:29 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Anna Schumaker <anna@kernel.org>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Carlos Maiolino <cem@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chao Yu <chao@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ingo Molnar <mingo@redhat.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Simona Vetter <simona@ffwll.ch>,
	Takashi Iwai <tiwai@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Zheng Gu <cengku@gmail.com>
Cc: Yury Norov <ynorov@nvidia.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-block@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	dm-devel@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	v9fs@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org
Subject: [PATCH 4/8] core: use rest_of_page() macro where appropriate
Date: Tue,  3 Mar 2026 20:27:12 -0500
Message-ID: <20260304012717.201797-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304012717.201797-1-ynorov@nvidia.com>
References: <20260304012717.201797-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:408:141::13) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3321f5-58f2-453f-5285-08de798d3366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	2bU1Zgdgg8fizy0j7DF+Bij0LR23XaHZoLO1x5kNaZZTZ8wNpGFJ/vX/G4h7UWom/z0NhDFAN7b4Q7P3g/JAwgLAPzuc3HwJOWg+ys3klcS2jI2YrgS5XTHNd1ReeWfZJthPb65KL2xVO6MR2ugndghKxMxGl+Turbo52l/QpFs4e3wat6zf5Bbm0ByxO8sm36toVsRPXChQcQ4HGaGobAdh6r/wXr3HNtWz/vWiafQd0dP0rAQX4cFOCWp9bPulnvAYbD43PMoMV04xgsOPod/VcXPBH2irxM+VH4ZuPseotVhF64Q1ym2fanC+A+7c4cYY7cINPwMTmrzUDiPs4ePPwpXcFoH01bWPMReos3tWfecXgZrAkSLTz4xVkSYhYLkgU2PGz+/fX2uxHeiJMcpGE5Se+M6iptqHPNVbrV/jE/NeYseeooOZicU317qfbBW7Msyjxqq4fw5Sj9MdObdriBRfiH7qWNTGA/bEDUqjrN9tF8pxt7mALPAP+Sx3Z+EvhPoO0KzviGRQguPYE50/MIHJ4Xjacew9zBQO+f81G2lZBqeg21PBYTy/ITcrhBonEvsbRspS+gObiM1XiYjxP/XVjVQfqYQY93+/AeNHW1TH96VM8kUwdfFtYfa4m1yDta7tL2/7Z1TBNa9tXgxZrxMj7uXyLkUMSvZCPV8XH/j/xfucUaI/XkNvtSmqLP2Dh9xZTiqYljgDNp/htcurwFA7PeEG6M+iExtsQH40j7aE7tFAbtJVl1PmQC733dtLxI+wPXZoSMlISASWZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hLSUKEpnuUW544SwxGwrhhMNk8qp8Sr4uH7HRvp89Br0GFhxPRZlF4nVLAuf?=
 =?us-ascii?Q?9cbxAnUU4Yr9Qodq/neTvvZJoZU27/0qEqHDxlDg1GMv3B67nf8h+2pBE1B4?=
 =?us-ascii?Q?AVg0nLDTMLyi0X4VkU+2jGRcjllIYrz+oBaW6UyTN6f19asc0m2ggf6rfjHH?=
 =?us-ascii?Q?bArwZ8s5GnYSKj0VV1XTS7MkQxHb3IFxT9RGLfSho8p6MsaC90jg4eUv32ER?=
 =?us-ascii?Q?vdmeTv5FjGzt2M8fQEpjcRglbWMQ7SjnEKRPq2IOl1CRghfTyTEZP8MntlUD?=
 =?us-ascii?Q?mX9+1+Iq8XGMLVevmT65dxoVKiq/wC2hLYpMgCLUtJnlAb9tG/ZEiiBxI2d0?=
 =?us-ascii?Q?ZGoZqE5StbiZ6PhQOI8CBeTiUVq/KLulLFJ8H4M6750WEnmcFS6fGiM2cub/?=
 =?us-ascii?Q?oTY9sH6rr/Pef3BgOjVIU2i1YUgu5+ab8bInl48INoy3pyZDcSeJGe/ZadA/?=
 =?us-ascii?Q?17tK8Pg2LuXWScGSf7Ty5vy9wODwj58v3GeJF/pqnXtDqUx4mzDwzWxboc0D?=
 =?us-ascii?Q?iAdvEzxa2DU1HkaFqE+35CCCEd+ITB7SiEd8jEweFvlU9O3wG9Wq1xpOAdrM?=
 =?us-ascii?Q?0YKghEn+M+MpR/A+isdjW1APAbhysW2JPN4sbyu1b3y0co1BfU8vk1UPmukh?=
 =?us-ascii?Q?LgBSFCHWwfgUaQbVbxpqfomjIeIB/lbBS0M/KXlh5wgP71WQ0rIHqt5CwvNn?=
 =?us-ascii?Q?79gzEPYEQNyq8qeqAsua9C1/Dmr0so/BhIqfEQCIdjDjDwjDj9o/BfSelVSk?=
 =?us-ascii?Q?u0kRek/gBRysGF6M6icv34XWivsleUhsL9CuFikZUtUGYNI+vvLZG+orY176?=
 =?us-ascii?Q?WUu9n2LEuNrOCUw+2iC3rFnvQ7rebARLkVpAsauXky34GyaKp4b3dkhLxfFk?=
 =?us-ascii?Q?eC9f8knwrC6hSYM6BMfT37rgWxOhXsOtIXya3yF507Q2jozncX3+iqtwQNU5?=
 =?us-ascii?Q?kydHjcIT9HIShwe2CpFAt1MOGSineOPJKvJmGTdsalPpuBDN4Fzo2QuMROyW?=
 =?us-ascii?Q?LHXeeKN6o2mYGyuQGZbiKW4r2RwkjJGF/Tee7xiT1D1CEuIcGDdAx2RIcDZN?=
 =?us-ascii?Q?5q3PaUkKalvgIURESxDPLUcFQPxUzSu4ZR3II7bqVW1x+BcytJhBCqksmusK?=
 =?us-ascii?Q?zx8uRU2zu1FKBXw+zOdKewNd9NZWlWEo8ieIAgJxjTrBibZBg+aZShu6/sjV?=
 =?us-ascii?Q?TOY8GB8lbWDvslKF4AuUxDqTwDIyQuDJIMNUm8/Du8CJfrwOsYwdtQdC7ZmO?=
 =?us-ascii?Q?Tcoumo0Ox/5bjuEHfEEQwPvxYMmHSADbCq4nNU5WCBK0J9HH0IXtXb3gLyEm?=
 =?us-ascii?Q?1f/RrFgjqQMEypJTgAEjTSXjB5kQWZX4sQYfEFdsidbrO3H/lDjPCyUfZBel?=
 =?us-ascii?Q?mAMUIM90cvomiBWcbEDQsfaSzFCXGlDOpRYh2jChzWVpXxrGWHx40Nz43Gif?=
 =?us-ascii?Q?yvTl1YSbMdCUiJLm7W6ZtKTyWQ+ZjT0LYo6CPblgros3Oe3oUYEURGCf9Xjn?=
 =?us-ascii?Q?HVpeHe+o0iCb7xXKf/dKY+HyA20ENFPjnaVPXLsmcMNxr4qk/31/qL1kCZJw?=
 =?us-ascii?Q?6AJt7lF09XAfZStNj7dKOvwZEivg58ojkdH4TAeZc9p41hKYkfG0iI/3FXIZ?=
 =?us-ascii?Q?yDqQMhQoEKuwdWMTmWHQs+dODra4vyZptQLUcqbkEU+Y74+KdgTAmqTE0MG2?=
 =?us-ascii?Q?k7/h/p492MZ1Y+NBbU4T/0o6az8K1cAZaf+I64jVY37d6kvham8GL28W5sn+?=
 =?us-ascii?Q?oapzuIVKp4/3Vax/KXq+5E5gtaSDI6Z4jY+Rw1kUo+/BY5Oz1gSw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3321f5-58f2-453f-5285-08de798d3366
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 01:27:29.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKugQiQpNaSieM+KubWVyA3r/4X8bz0eN0Y+a21LkKjVOAfxFj76HJG2XRHAse1XkLqFszUAxZx6OyCgFMahgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
X-Rspamd-Queue-Id: 5C49C1F95EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,davemloft.net,redhat.com,mit.edu,eecs.berkeley.edu,fb.com,linux.ibm.com,zeniv.linux.org.uk,dilger.ca,lunn.ch,kernel.org,opensynergy.com,alien8.de,arm.com,linux.intel.com,gmail.com,codewreck.org,linux.dev,google.com,gondor.apana.org.au,perex.cz,kernel.dk,ionkov.net,ellerman.id.au,szeredi.hu,dabbelt.com,infradead.org,intel.com,ffwll.ch,suse.com,ursulin.net];
	TAGGED_FROM(0.00)[bounces-79309-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[86];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Switch core and library code to using the macro. No functional
changes intended.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/crypto/scatterwalk.h |  2 +-
 include/linux/highmem.h      | 24 ++++++++++--------------
 include/linux/iomap.h        |  2 +-
 include/linux/iov_iter.h     |  3 +--
 kernel/events/ring_buffer.c  |  2 +-
 lib/bitmap-str.c             |  2 +-
 lib/iov_iter.c               |  5 ++---
 7 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
index 624fab589c2c..c671d5383c12 100644
--- a/include/crypto/scatterwalk.h
+++ b/include/crypto/scatterwalk.h
@@ -73,7 +73,7 @@ static inline unsigned int scatterwalk_clamp(struct scatter_walk *walk,
 	 * page due to the data not being aligned to the algorithm's alignmask.
 	 */
 	if (IS_ENABLED(CONFIG_HIGHMEM))
-		limit = PAGE_SIZE - offset_in_page(walk->offset);
+		limit = rest_of_page(walk->offset);
 	else
 		limit = PAGE_SIZE;
 
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index af03db851a1d..05528ba886fb 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -507,12 +507,10 @@ static inline void memcpy_folio(struct folio *dst_folio, size_t dst_off,
 		const char *src = kmap_local_folio(src_folio, src_off);
 		size_t chunk = len;
 
-		if (folio_test_highmem(dst_folio) &&
-		    chunk > PAGE_SIZE - offset_in_page(dst_off))
-			chunk = PAGE_SIZE - offset_in_page(dst_off);
-		if (folio_test_highmem(src_folio) &&
-		    chunk > PAGE_SIZE - offset_in_page(src_off))
-			chunk = PAGE_SIZE - offset_in_page(src_off);
+		if (folio_test_highmem(dst_folio) && chunk > rest_of_page(dst_off))
+			chunk = rest_of_page(dst_off);
+		if (folio_test_highmem(src_folio) && chunk > rest_of_page(src_off))
+			chunk = rest_of_page(src_off);
 		memcpy(dst, src, chunk);
 		kunmap_local(src);
 		kunmap_local(dst);
@@ -580,9 +578,8 @@ static inline void memcpy_from_folio(char *to, struct folio *folio,
 		const char *from = kmap_local_folio(folio, offset);
 		size_t chunk = len;
 
-		if (folio_test_partial_kmap(folio) &&
-		    chunk > PAGE_SIZE - offset_in_page(offset))
-			chunk = PAGE_SIZE - offset_in_page(offset);
+		if (folio_test_partial_kmap(folio) && chunk > rest_of_page(offset))
+			chunk = rest_of_page(offset);
 		memcpy(to, from, chunk);
 		kunmap_local(from);
 
@@ -608,9 +605,8 @@ static inline void memcpy_to_folio(struct folio *folio, size_t offset,
 		char *to = kmap_local_folio(folio, offset);
 		size_t chunk = len;
 
-		if (folio_test_partial_kmap(folio) &&
-		    chunk > PAGE_SIZE - offset_in_page(offset))
-			chunk = PAGE_SIZE - offset_in_page(offset);
+		if (folio_test_partial_kmap(folio) && chunk > rest_of_page(offset))
+			chunk = rest_of_page(offset);
 		memcpy(to, from, chunk);
 		kunmap_local(to);
 
@@ -642,7 +638,7 @@ static inline __must_check void *folio_zero_tail(struct folio *folio,
 	size_t len = folio_size(folio) - offset;
 
 	if (folio_test_partial_kmap(folio)) {
-		size_t max = PAGE_SIZE - offset_in_page(offset);
+		size_t max = rest_of_page(offset);
 
 		while (len > max) {
 			memset(kaddr, 0, max);
@@ -680,7 +676,7 @@ static inline void folio_fill_tail(struct folio *folio, size_t offset,
 	VM_BUG_ON(offset + len > folio_size(folio));
 
 	if (folio_test_partial_kmap(folio)) {
-		size_t max = PAGE_SIZE - offset_in_page(offset);
+		size_t max = rest_of_page(offset);
 
 		while (len > max) {
 			memcpy(to, from, max);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 99b7209dabd7..6ae549192adb 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -142,7 +142,7 @@ static inline void *iomap_inline_data(const struct iomap *iomap, loff_t pos)
  */
 static inline bool iomap_inline_data_valid(const struct iomap *iomap)
 {
-	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
+	return iomap->length <= rest_of_page(iomap->inline_data);
 }
 
 /*
diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index f9a17fbbd398..13a9ee653ef8 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -227,8 +227,7 @@ size_t iterate_xarray(struct iov_iter *iter, size_t len, void *priv, void *priv2
 		while (flen) {
 			void *base = kmap_local_folio(folio, offset);
 
-			part = min_t(size_t, flen,
-				     PAGE_SIZE - offset_in_page(offset));
+			part = min_t(size_t, flen, rest_of_page(offset));
 			remain = step(base, progress, part, priv, priv2);
 			kunmap_local(base);
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 3e7de2661417..1db2868b90c9 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -590,7 +590,7 @@ long perf_output_copy_aux(struct perf_output_handle *aux_handle,
 	to &= (rb->aux_nr_pages << PAGE_SHIFT) - 1;
 
 	do {
-		tocopy = PAGE_SIZE - offset_in_page(from);
+		tocopy = rest_of_page(from);
 		if (to > from)
 			tocopy = min(tocopy, to - from);
 		if (!tocopy)
diff --git a/lib/bitmap-str.c b/lib/bitmap-str.c
index be745209507a..a357342d5d6c 100644
--- a/lib/bitmap-str.c
+++ b/lib/bitmap-str.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL(bitmap_parse_user);
 int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
 			    int nmaskbits)
 {
-	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);
+	ptrdiff_t len = rest_of_page(buf);
 
 	return list ? scnprintf(buf, len, "%*pbl\n", nmaskbits, maskp) :
 		      scnprintf(buf, len, "%*pb\n", nmaskbits, maskp);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0a63c7fba313..c7e812349ca2 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -483,9 +483,8 @@ size_t copy_folio_from_iter_atomic(struct folio *folio, size_t offset,
 		char *to = kmap_local_folio(folio, offset);
 
 		n = bytes - copied;
-		if (folio_test_partial_kmap(folio) &&
-		    n > PAGE_SIZE - offset_in_page(offset))
-			n = PAGE_SIZE - offset_in_page(offset);
+		if (folio_test_partial_kmap(folio) && n > rest_of_page(offset))
+			n = rest_of_page(offset);
 
 		pagefault_disable();
 		n = __copy_from_iter(to, n, i);
-- 
2.43.0


