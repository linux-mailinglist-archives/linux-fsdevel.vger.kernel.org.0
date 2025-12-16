Return-Path: <linux-fsdevel+bounces-71451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C415DCC199F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 09:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2C97305D655
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B29346FB3;
	Tue, 16 Dec 2025 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TnDfFdfS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D9346E5F;
	Tue, 16 Dec 2025 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872655; cv=fail; b=EBeRLYchDp1uNsweN4D+PemyP0AIj6bwuv/blJVCeFVFiarzp6jT+XTOtdfoY4iJSmqVtkUG0DuHsm2HUrFu353oBhtU8MV82LmpN72oIplTAsY0JWl+ESxJxG6gL7QulE3nLN/6yplHH3iY7aMk/bi3OOSfYVla5bLeqcwFmOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872655; c=relaxed/simple;
	bh=nhRYD9VfjlXJy+x6cutxBzwtvLRNiJ72t758U5n4sAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=omccAS2sYMC+VrqoJMH3fWvBffGfCecBqp89AYRElrkgubK/db1NM9zljrm7LJbctabelxehSyqGPKXqksKJIOOXhqPjMYQLNEvhcoZqIIixbENPPB+TdhB4M1NKEboSs6ogzEaevpFs8pXuj6jNxJNYiSol0/5MZyR4GmMuYwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TnDfFdfS; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXve7OSXvtv/5gSaMxTLRaj+HGlQauenyDMEKfLQQbCJhvpnPU5Mnk7HWYTejn3+LjIFconj42qi6wP47GjFomeaAXYDouKq1dQixVwwwqGTl+yKXVaSDhovK5dinP6l+ilsz+umnCJcZSoSPROb0wvbOub7KRet+EtzcUVmdABTHV67MAjM2l2ZVUy8qVBbU/qbEESEOliVuKsly/zUSgKdNmCtsiP770L1vc6aT8FcxAMUErz2rAlXKs/zvlG07WHGFusrEEpsk8xjroTyhVwco7pyUS0jqW01u8rO/ECk7KVim5avmXZ8USA2eqGHV01HLcmdxFH6/Ys8E5NUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml4hLnysdu+pRUQKE1SCNbox8jlqtOFBVtq8LGX5IgM=;
 b=uXTkU9JNrhAdWziNwi92hy34E4hmxblQSZJf8IoopqE/gpGd3whtIfdLuMeQvBujC0Wu/FQgw7kOeuZXkNBoliyuemsSvmq88iHgHH7NkR3C1j29V3j4/wjUZ7mJwkpRZBUpI18Ehjdc0710javw/4SdZ9CtHMGzxhEoH3MPoYqcWL0Mkum7rNDyaRdsOl3oIEcfmdLRQWJWxKd4+egjc5A/CBZ9X6PdS/9pH6KKKXcwMNhwZOKKpy11beCniaaK6v7FTO5cNa47lpVX7Z62WObesn4EQaIGL/TmyBgJr6j8thQ+5vPNTI/y5dM//FyF5eXlpqOB84x1/FdmrFdbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml4hLnysdu+pRUQKE1SCNbox8jlqtOFBVtq8LGX5IgM=;
 b=TnDfFdfSSTqxrPj/D0FBqPGEFLwd6kBkIS4QYR/XN1MUiZZCJMvmdVHjQZu20iUhBLYc538+q0mIIAn+pzKACEs/O4C21Ig41g2R3pRf5fyPMww6ndA8TDL8sBpPOj/U3kbFxl5iztxvaEXJYgDwZqENTmCWk5zqshocAsQmIJj8h6kAKTZv2I2a3bofr3uOq4JSIeVk2BtpI5Vu8qsb2fYjEwl0xY4Uq8sA1H/Ag5XvyQvdLihuHOaJR5+dGnk9kK50VkyIldBFKp6CSBB0kd6Q3A7YreCvZbAy53spmcHk/9lFHycAzoKMdi3NCbkZO+iZNSrhFoD2iuAswGl//Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB9476.namprd12.prod.outlook.com (2603:10b6:8:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 08:10:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 08:10:50 +0000
Date: Tue, 16 Dec 2025 10:10:37 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Media <linux-media@vger.kernel.org>,
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Network Bridge <bridge@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <Dillon.Varone@amd.com>,
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
	Cruise Hung <Cruise.Hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexey Skidanov <alexey.skidanov@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>,
	NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Luben Tuikov <luben.tuikov@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Mao Zhu <zhumao001@208suo.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	George Anthony Vernon <contact@gvernon.com>
Subject: Re: [PATCH 14/14] net: bridge: Describe @tunnel_hash member in
 net_bridge_vlan_group struct
Message-ID: <aUET_bbW6KyxtQKB@shredder>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251215113903.46555-15-bagasdotme@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215113903.46555-15-bagasdotme@gmail.com>
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: c99754f8-7600-423a-a605-08de3c7aa003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkXm0BjdGAi9VT55N2GLH1J6bsnNuBFCBwMBR2yCqs75pzLJpg/epURp95hP?=
 =?us-ascii?Q?YmOlmW/O/zn+f0hpeky9N9he5zJlc4nxJzHKgvEG7Q0KGzO/dzirkGSHjAuE?=
 =?us-ascii?Q?WMnZo4xaKWnFaxo7D1OBZKZfIRZenW9US7H025qI8cEZ/3DQzldcIhOELmKA?=
 =?us-ascii?Q?osoQ/4YEy4G8pZDXdBy2/947Ej7xXUB3oS68VfUgnhBpx4W3cS9YaVufWGQc?=
 =?us-ascii?Q?b6Nmmp9E8u+P0JhgUtT/6mmOZdWVOF+k4Wi4djLL6lNsNHcS9vhiYet5UU++?=
 =?us-ascii?Q?/DCBYdih5WGqI6s91PMWPrnaadkiGBcCIkX4n6bh+cWYrYOf74UV4knx4NK5?=
 =?us-ascii?Q?hW9I07m5vtwHwKuHYC6GnuEOO9nqMDYuzpALPDEHvaKLJwqYRcqL+Td576Js?=
 =?us-ascii?Q?aKlFrwfFQbH6jqbUcEslnKy46ovXktUB02A25U0RZpUl2Fl3KfeLaMxyjS2W?=
 =?us-ascii?Q?PJ5n2gviNK+d5kTifykm808oKiID98CN8rrtTUltiiAt8Z91Y4L4Yy39n1/d?=
 =?us-ascii?Q?hoLPqGSDWm5teJWwRF0wo2pgUQU4z8bQMzZHkiECN3ZlyM0sIMEY9m3QPHhc?=
 =?us-ascii?Q?3MNp364/b2wsPSlSc4Rww2WmfovQF52rmo4HcX27GNlZ+AvAQJCIpp363TSe?=
 =?us-ascii?Q?+9R1nAlW8pTVanabC5+dgQAdGg4kkcKgnzunxPhvmnQ+9mozeuuByC9Z6lr9?=
 =?us-ascii?Q?SjwZIht8+h6IFmp1+6SyQ8GT4M/PHTkFIRbo8sDScjFCBWkP+MxMQVRFJwNy?=
 =?us-ascii?Q?FjQHtXP44rlUxgcfyZPWZ1lzt7hIzZT4jVxLA5inmyd9ystdsbTCIs68lcLX?=
 =?us-ascii?Q?PMDLBZp4p2NdasmZ5NggNeurU78GWsTPQqp5EivXk1RH3t/at6lFpEP8arET?=
 =?us-ascii?Q?Zi+tOSpetzmFuZrxqc0nOmVq0bq1sdtTnfphk41AbDPhe7m1TSwrCV2OsxLr?=
 =?us-ascii?Q?GZDJjYYCY0BJ6CoqrpXfdzPGc13IPTT1G0AEt/YTJ0GVQ536S59VzBf5AHHq?=
 =?us-ascii?Q?SBX83ugiI1nTcRwd2qC4ncQr6p84RhyAqTTUG7l85anUfcvghLHUStY94ugs?=
 =?us-ascii?Q?l7yyJOxMalgJw43lmrO/LfxcCeN+KNnFOTWRUTM7pyNsPUR7R8Y4BZi6QK4R?=
 =?us-ascii?Q?s3hSFS4R2EO2hHb1Qo6D6Cbe9ICeKDpvW74fdGODR0dljLXduMdRfQ6snUep?=
 =?us-ascii?Q?C4iiLxdLxdDPske0KRKRRQbBHX3ljrWJkcvfZIE+gpaEdYAXfgcNm7jdh0e3?=
 =?us-ascii?Q?iG30ianLApDBUb87dMvNdYDeWDl8N3sAFM3vuxY2bNXbkNn49nJo8HDsRpIP?=
 =?us-ascii?Q?dyng77uq/GtwqnaAuLpwkpype42rXNVv5ZwKgIlRqN44gIjFHXk7X7CvveH2?=
 =?us-ascii?Q?teXf81LuKCRipSXtHR1P0Q2F+w7DF2GZoM8XBA0a87r929nl3qRfj6JPpOzP?=
 =?us-ascii?Q?/vqI651aAm0PksX5cYuSQNeeqsqhFtRW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GMR1rsjwA+mZmoSMlv2Zqg5PhqQvwG8PoT76TB/A7KZed62KBuWIauK+iQUD?=
 =?us-ascii?Q?uqpmWREc30w6mRNi5ZM+SjzSTCLZkPr7JV+KMTFQe6swH7d5vHQ+zf0dpYEt?=
 =?us-ascii?Q?GIu2nHe0s1+O5gi3kbCSy4YVOPvlhsWt7HpXf05B24SpVoI+noihEmsQWPnJ?=
 =?us-ascii?Q?ILZaQm7+mm3b7LyanIN1PbEQTmA3+P92L90GLscWYjn7YmX2SfAEZabSuwST?=
 =?us-ascii?Q?EjzvPmwUggnpTDt1TC2ihx+at7BwZdyEs0eUyFNvKGwjXTz7/hC62JXuJQg8?=
 =?us-ascii?Q?XoUrra5DhVrRL3aw+Hddml8cPqNRCa5l9abdCYsXe0uQo1F2O9/1v5+zNlNW?=
 =?us-ascii?Q?4DU6Q9xKfxVXNzYRGLxrdf85/q7erU9E21eZeE7pGRzOEY/mhnaCk/75vEkt?=
 =?us-ascii?Q?QH1OpHfZit7YlGftmEmS7aEiqIjnFUPlqF98rweJ3l/V9DIfjuXuqAJ5PBj7?=
 =?us-ascii?Q?UnsqzCJQp60swuQ+qy2Ba14FIGUlM9BSBOiyUNormsAzpmmzzoaJDu8DQxAu?=
 =?us-ascii?Q?L+16lHUrWCg+mkcf+8lciTm7bpaWrqbBsmlpYBILrgRtdngKMchSkQO0CPZi?=
 =?us-ascii?Q?F/oYlyxHw4x+R90OERWWufHHpvkwH0A3mL3LllKG39XTJMaoFNWxT8w4mB0z?=
 =?us-ascii?Q?i2B5+voSnM6kCEymaC867AKfDsXAG5sK9R/9+kV8HabwMYND7BSw8/38zRqF?=
 =?us-ascii?Q?DNSAdyi82jDhA48jTTCObFQLoLfQVODKyD1VAzp1sCn6CT6nONj/DTK/H0uN?=
 =?us-ascii?Q?Vx1sQS8aiEG6QII16LPjMdpXowgqN77vM11t+g0ixxdpZRTBWBXOaGDdW7Fd?=
 =?us-ascii?Q?dx2gNtLpzxqMWhz7Y43E6QHY5HzYiiSgThF8JzGT6YeuKjNvQRAp4SWC3CUr?=
 =?us-ascii?Q?tnfcoFBpmqJZDOps2W/r6TJ6PWJw337aiqNbSXw2b3eg7F2K0DS/2IS4kRXv?=
 =?us-ascii?Q?YQV6Yc3vwaT9z6yvPk4kGqcZsou6p1sHC47KJm3mLwVaJscJAk1ciDNvRNU4?=
 =?us-ascii?Q?vmiHRt4ek71JrydTLI8KdF07jnu36Sr0WPFWVjCcdGBLQtbsQ31Wdezm0ecI?=
 =?us-ascii?Q?JhYsNwavM2eC6zIceUUh6fzAx463Pt6R1+pO4Y8FIPVTvnBRry/btE0aTsB7?=
 =?us-ascii?Q?82aUOmogWVosQj0I10Z+Pmh/pS1bd5H+IBBhirjKJJYFmmXvqquDHgdx4KJ+?=
 =?us-ascii?Q?hiFN+omF4jz/iGrIrIrbOJpICy35rsfB5zJy25Kh5B/niJnHDoJFc9LHwBnh?=
 =?us-ascii?Q?U2PFkdA1AfchKfHeOL4THF2tbpnjA6eLSlpBovdzTLvMRm9yQTpXhycJJOPV?=
 =?us-ascii?Q?D2uTb0krBVKe6qgTZ50sCTfhoI3YmXH4JfAhXVsknrQbZyygV6sab6SoBwCS?=
 =?us-ascii?Q?/5FDPaa7Q3yttccbpijFvir4egNbEwBU9KOM5w5KWM+V5JIEVz5ZKf5pU99s?=
 =?us-ascii?Q?Ud465tArDFqI/avl1KA009dDNBLcOjYElirDsKEl6Ye3S1O1texnMUWKO11d?=
 =?us-ascii?Q?frEIMFMUdr6tjl00pNuvfiyGoJ5yWrAlXM3Sddfs6wLYPs7T0SV/2dhN1HKF?=
 =?us-ascii?Q?ny1xJLWxk2w+I+uF3fEkAqZW+bWWRVolqxRSdDKC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99754f8-7600-423a-a605-08de3c7aa003
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:10:50.4122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Jn1GRAVl7fWR6i2nOitnqAdyxeLG+agMppQMoqRYGdALbOZFDDkQLF4Y8PSVW8MdLCtX3o9nK8w98LWXl102A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9476

On Mon, Dec 15, 2025 at 06:39:02PM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./net/bridge/br_private.h:267 struct member 'tunnel_hash' not described in 'net_bridge_vlan_group'
> 
> Fix it by describing @tunnel_hash member.
> 
> Fixes: efa5356b0d9753 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  net/bridge/br_private.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 7280c4e9305f36..bf441ac1c4d38a 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -247,6 +247,7 @@ struct net_bridge_vlan {
>   * struct net_bridge_vlan_group
>   *
>   * @vlan_hash: VLAN entry rhashtable
> + * @tunnel_hash: tunnel rhashtable

While you are at it, I suggest making the comment a bit more useful.
Something like:

@tunnel_hash: Hash table to map from tunnel key ID (e.g., VXLAN VNI) to VLAN

>   * @vlan_list: sorted VLAN entry list
>   * @num_vlans: number of total VLAN entries
>   * @pvid: PVID VLAN id
> -- 
> An old man doll... just what I always wanted! - Clara
> 

