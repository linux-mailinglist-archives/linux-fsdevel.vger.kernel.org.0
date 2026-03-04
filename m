Return-Path: <linux-fsdevel+bounces-79310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OiYIHWLp2nliAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 02:31:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A501F96C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 02:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2FF63079848
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 01:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8608A30DEB5;
	Wed,  4 Mar 2026 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f5sF/09Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4C31B824;
	Wed,  4 Mar 2026 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587674; cv=fail; b=MFmrRM7A/v8cso2jOF0G66/Jlwu4MOKhYkr9ukvSKC+soBBf3QlR9lbDkW4Qs/YaPaI5XhwWuxRxujntyv5ojF3MUuIxycgx4DBS837JnAMUU2MIn2gN3R+8YKsnAelzcfV4Ht7BXCF9WA/h4ACEXR2B7LxMgOEislr/mEo3Mds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587674; c=relaxed/simple;
	bh=gSQwYNjQtxONeZhXN2E16D1SgtSrl9p/iPb4eHcT4A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZyXgeYKoO941oMRmXu1Ttyybkf/XQr2dVpbPB6XgYZ1ty3EPd24NynwUf9a6Q4mP9usr5SI+4pfqSDzTHrRmJlTmVaEnwMiQ+1CeX04vQwEF3U3cXT127OFSOxJ4UWH+8d2BaByIn7It3Tjn2eaeq6pTyGvC631MWaxqbH1y3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f5sF/09Q; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5afcP+xPp53aYkHswiWzdI4Msozqr5V4tHhEVXe9ZVjtcmRiy3VX11EkPHjazOLYMHmGxtIZ1Y0lGPnHStG+/C0bRfTo7MUqs/Mt8xjsP3P7e45Tsjhnuput9GwSWyBLlsoZq2QWZSKI21cj3tsvENx9xrZ9jKDxVS7Ir+xVogQ8dPScgJpIFGkkHmjRcuTtxYiJUwfWpSGShQNjiEwGmIFTPWDeJpwX+mSIb0dtqB29KsgifvWU6U63Ztsb8TPcihy32Q/yp19plQumzA04MwzycDnQcvnjZljjC1W1nyboRNthKtcyp9pXv4mMkgoyqWpLchikAR6nskSg4ChpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gSCHE8kjPSLoULSKkpRxPQqFKwhZBXzpx81D8lSNwo=;
 b=wbJElpWqD6bg0np/jNgUS09/M6WzYi4dXudK8aKDX0VYiPs8VBeR5wWPPryGowCpTuB5H/ScREOXYsnBTRWUJtKCVh48VEvGMNSPA0FvjxenfxRYSiJv/3SsO1k4oIt9v0SSFvyG1Lev7GmYbW+CKWEmESsBklwuQfB/0v1pL4jgZ5k/XAhZKV0v8JCDOuUNm7RaR7Y9jbSdPvfj3NCPnohu+8z7NGRmq8hlm2RUA4hoz5u1Ay04m7rI3HziSV8vTp15QzorFOH2zQnTBkrfh8Bv20q+PV9C2YUE1fsyPndY0a/vtMAZdZOB6Zh9Szx+m/r3yjdbYR/4pz6V7wmw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gSCHE8kjPSLoULSKkpRxPQqFKwhZBXzpx81D8lSNwo=;
 b=f5sF/09Q480wY19v1DY3Wt+SNUs6vVXNnfB4WTZLCiAUZdUuHcjnQZtwIPxSD5MC3m8FjWqDcVHdmYoyy3a3YR8YTJZoqiCMCvFvSlpv2IWlfLYXxnB27ls2FDf17x0IGjUDteajVACehCgQlH9MkjMfmgtNfDoUNo1niDZAL0eZigyTFSeuWyGGkSbRqKBVaxptIbqnrR9aBmVRDapK/pME3lM6UW7pm2Xj5/EtV/1OYYM5kg3kg10EopJujBHC/ujXluuVSmDflkCC6+qiRR/UlVgMH018CmS8f49SnBIU8dYa1kciQOVP4rRF/2Zu1WHrSt9VUT4gsIEkfXRHFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 01:27:33 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 01:27:33 +0000
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
Subject: [PATCH 6/8] KVM: use rest_of_page() macro where appropriate
Date: Tue,  3 Mar 2026 20:27:14 -0500
Message-ID: <20260304012717.201797-7-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304012717.201797-1-ynorov@nvidia.com>
References: <20260304012717.201797-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0939.namprd03.prod.outlook.com
 (2603:10b6:408:108::14) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: a668991d-ff9b-4dbb-7daa-08de798d35a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	Z/6V97ZgGWZnJizosWGs3D3JmsBEU37quAoqwhEy56JDe8uN9V3H6D0yuBL506dxvp7oKI9HDcWQuTOlKn0o1JpfUQnxPPVHmG8fJW0OJ2nIPNi/BZ5LpoMR8z8W9ya02KrLD+7+pOg61gi6s0I3tkmeKrg5DEriLsalAWRhpbRdciQcUJ98RKyfMVAO/XnUqVRVy+mCCctZ5T0BPaspgBUdQCU+vpwLVMWgLWg4xwX5QaiOhiL5bYu3LJxw5MD3r3OTLNsbkDoQ0oUDuJh091ka7SnC0vuHZ3ptqQ3ghskwHcPQKSMbxV+7P8btNCQviv75jQU9o/qFRbhF2XUTNS+Qc4BtwtnE/Lvguo1ceZnaIQpK8RgQOlgihnvThAsXus7SPKfcgffX5kkYyiGOXXbx2QJxfndKopRgwym112xa8FNEwzOrYtKVSvsBMdlVPdMU8DUD5IC71mZYK1dAiaf36QUz9dW9Ibj8wULgR/OF2sGOXtJep8iC0/Ojd/ofmjfcQ6auj/jtREgrlK4jtSKwjsePgcVhq0mct+jNAElovWmy7MJ56cWAm7WgJ4SB1cTtaNxVMRhkgBJ56PKWV0JQu0xlZJ3NKA+xU4uPGfsFxXuV7VktmRigNpPV6h9vd5f9Pnphg3l+tgavj+Od6om9EpHzRTvSpjYzzG5471C9FMY+oSzEOq9q8Xn4COFLTJb1VuaMekZAgG+uBTdDVleFXWQy0PRNyCjZ1KPO4+wlaQ8xlZQ30GD3yei8xfzDp6Etd01YNcd7ZPo5U2jfWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?laYgr3IxhCpx4j5kAcCot2E/Vds0o6kWWRSkjhyWLUWD7KnDgH7Y1ZuPn3NN?=
 =?us-ascii?Q?T7vC5+3ZaVnxRrdvyxx4Pk32wCA36ghzy+a7JPqKAgl/W6+ER1Gweb37TUlG?=
 =?us-ascii?Q?jbKLI3PtNYWB3vftGBA2zzxthZoh8cTCK1+iib+/D5uiOGZl3t/iu3gn52gG?=
 =?us-ascii?Q?6vdHH07a8CbBy8eX4hheIn+vKX3n8lCq+lScXOLywYvX5liTqyIobDDoHMxg?=
 =?us-ascii?Q?6/gdi8l94txKeW83Mpcn0rlrO2NZH2Wp+Xk9wwgBXl5m/yt5kpglcTqtX2uZ?=
 =?us-ascii?Q?bT2KRNx2B70ebitdNXc7JT83lyPk2H0/NEEZnmgauUaSD5EanlTM3rK3UMqf?=
 =?us-ascii?Q?VkZigj7W40REEgNAR+EZ2HoJEo2CCUHGldupvDrYdF/LeoC4GxS0mCufNpqi?=
 =?us-ascii?Q?+aroeTwNAV6oVuTfxshUYht6iSJAbIqVmtGmA+r9FfQ3NuOLqp7ehdd2OlFn?=
 =?us-ascii?Q?A+QTYT5DPXpU3Hjo6xbFRIeE8AzUnMeKNBdZVPJkA6MWofZ9AYvgvUfZzPSz?=
 =?us-ascii?Q?sMymeQ7yWdKdLd6lGxVL85nafColRy16aCzvBn5TqjIZwNlidpdNvFGY/RkH?=
 =?us-ascii?Q?ByLtJLcNNzgSr6mzWuPV3pm8Tq78hEGf2c2zMcdBlgH3dQwYa4JELCG+U0QR?=
 =?us-ascii?Q?KNTPwFJsRLv79MiuTHxxERMUXifaB9lRVVu9UeDeNnJnEf/oxfze9tHsxHHX?=
 =?us-ascii?Q?b64wyrpfq/5VWiLD0J5dKLbXcc6EB4OGeOWjKLxWdgTDWeyTMOTeNZtY4ltN?=
 =?us-ascii?Q?ilPrVnS9iVOlvhXSPF7inNdbpo3Qm9NdCiOftJtFr2pPTkkAUpJA1ddJsXHW?=
 =?us-ascii?Q?JV6H/5RL11cKVVtX91ibKZW07gLklZ5KG4OyZVmXf4qe+mwinGs5hhPDkCse?=
 =?us-ascii?Q?jwWtnKoExLGVTa9af5q3IRkESQZPeqRo3zvPV+tSSCrkkxO2DndjGFfQ3JSg?=
 =?us-ascii?Q?Tr+X9j8APyhcmfV+sT35H623x8I+h2YG1YdyewmmAkOxFzlp4e6RbzSSc5Ob?=
 =?us-ascii?Q?OhRz9+x2brAanr8h6fQ6kt1vX142wIyXIgoc4QBML58szqTKyEb1PjZS5QBc?=
 =?us-ascii?Q?IGl72nmkGzGrla/30UhPk/Uk33V77V/BS1KRwEOX+CNDXPxYD66C7bkUy265?=
 =?us-ascii?Q?2NWweaA/3yE0QY6orrpYKP4HQkb7VMgIOSBcOrDDk3lWK3TFyZ+sDvzNjYxL?=
 =?us-ascii?Q?nm6bQz7vMBlpbXKeCxouxHVtOmcvE2fEMdscirYsTU6RAkz6L5C0/LUezw+z?=
 =?us-ascii?Q?nQp3DS4x2tyD8sxYQyP2uTg3WJ+YIZS6GxlSQnNW3Bn+uBTZIt1EQYfSGZP7?=
 =?us-ascii?Q?ZIKGDgE2LTKC9RAcM9vVm3ZrvQDc7QoTNzUX41ttr3w+0g5s2Ji/gr/FyIbu?=
 =?us-ascii?Q?P7dG/cNYnnHQWq1o/DNFXBkEgSuY0o+vqJAZ8Jf0lzEsVlk345/poEQdlA+o?=
 =?us-ascii?Q?hf7PiKHDScKqE5Jh60nN78knkAj/oylR+TlFMCg5/D4EEUPCefP7ZnEcun2z?=
 =?us-ascii?Q?MYVGRd3uvVYU0vGTjb2jG3qb1vNYn+t1o7HdK9vymM2TtVhUxW/WJCirhuSf?=
 =?us-ascii?Q?pBmPscEsjuKH6aBdjXXDMv3/Yppc3XNC//+ObZWvq+DMuyIJ1uW3TvNFNzqO?=
 =?us-ascii?Q?fqHS0tbuUjJTX3ZASi+GQksg6JnUmNeG20CRLeFgzok2+suplVFdaKt7My4q?=
 =?us-ascii?Q?M5LyApib5nySpUtA+JaA2HSpBZrb14KDYPS6cyXnhX6yIyZ950FBjV7x172A?=
 =?us-ascii?Q?dVBrYx1dTkPYSm7toKzWE1J8W0h+zMjBquMe0kBK99qsGkl+aDlG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a668991d-ff9b-4dbb-7daa-08de798d35a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 01:27:33.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuFdHRQ+7R7JZVi6h8G6FO97rJSCcjNiBcJaG0+UNpDidCcb/D65BlFnnGxlBYVv7Gy4M0KiWg0X+ktiM9h16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
X-Rspamd-Queue-Id: 51A501F96C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,davemloft.net,redhat.com,mit.edu,eecs.berkeley.edu,fb.com,linux.ibm.com,zeniv.linux.org.uk,dilger.ca,lunn.ch,kernel.org,opensynergy.com,alien8.de,arm.com,linux.intel.com,gmail.com,codewreck.org,linux.dev,google.com,gondor.apana.org.au,perex.cz,kernel.dk,ionkov.net,ellerman.id.au,szeredi.hu,dabbelt.com,infradead.org,intel.com,ffwll.ch,suse.com,ursulin.net];
	TAGGED_FROM(0.00)[bounces-79310-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[86];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Switch KVM code to using the macro. No functional changes intended.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 arch/s390/kvm/gaccess.c | 6 +++---
 arch/x86/kvm/emulate.c  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4630b2a067ea..40f85b7eca63 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -973,7 +973,7 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 	if (rc)
 		goto out_unlock;
 	for (idx = 0; idx < nr_pages; idx++) {
-		fragment_len = min(PAGE_SIZE - offset_in_page(gpas[idx]), len);
+		fragment_len = min(rest_of_page(gpas[idx]), len);
 		if (try_fetch_prot_override && fetch_prot_override_applies(ga, fragment_len)) {
 			rc = access_guest_page_gpa(vcpu->kvm, mode, gpas[idx], data, fragment_len);
 		} else {
@@ -1015,7 +1015,7 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 
 	while (len && !rc) {
 		gpa = kvm_s390_real_to_abs(vcpu, gra);
-		fragment_len = min(PAGE_SIZE - offset_in_page(gpa), len);
+		fragment_len = min(rest_of_page(gpa), len);
 		rc = access_guest_page_gpa(vcpu->kvm, mode, gpa, data, fragment_len);
 		len -= fragment_len;
 		gra += fragment_len;
@@ -1237,7 +1237,7 @@ int check_gpa_range(struct kvm *kvm, unsigned long gpa, unsigned long length,
 	int rc = 0;
 
 	while (length && !rc) {
-		fragment_len = min(PAGE_SIZE - offset_in_page(gpa), length);
+		fragment_len = min(rest_of_page(gpa), length);
 		rc = vm_check_access_key_gpa(kvm, access_key, mode, gpa);
 		length -= fragment_len;
 		gpa += fragment_len;
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c8e292e9a24d..c060d1e2bb94 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -864,7 +864,7 @@ static int __do_insn_fetch_bytes(struct x86_emulate_ctxt *ctxt, int op_size)
 		return rc;
 
 	size = min_t(unsigned, 15UL ^ cur_size, max_size);
-	size = min_t(unsigned, size, PAGE_SIZE - offset_in_page(linear));
+	size = min_t(unsigned int, size, rest_of_page(linear));
 
 	/*
 	 * One instruction can only straddle two pages,
@@ -1372,7 +1372,7 @@ static int pio_in_emulated(struct x86_emulate_ctxt *ctxt,
 			address_mask(ctxt, reg_read(ctxt, VCPU_REGS_RCX)) : 1;
 		in_page = (ctxt->eflags & X86_EFLAGS_DF) ?
 			offset_in_page(reg_read(ctxt, VCPU_REGS_RDI)) :
-			PAGE_SIZE - offset_in_page(reg_read(ctxt, VCPU_REGS_RDI));
+			rest_of_page(reg_read(ctxt, VCPU_REGS_RDI));
 		n = min3(in_page, (unsigned int)sizeof(rc->data) / size, count);
 		if (n == 0)
 			n = 1;
-- 
2.43.0


