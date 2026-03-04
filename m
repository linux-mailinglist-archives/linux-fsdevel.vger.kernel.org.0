Return-Path: <linux-fsdevel+bounces-79307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BBmM72Lp2nliAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 02:32:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312D61F9760
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 02:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CD6A31AE36A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 01:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7E313E30;
	Wed,  4 Mar 2026 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nQOLB5Sm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133830FC39;
	Wed,  4 Mar 2026 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587667; cv=fail; b=Fm2QFNNM+Gxl9vGgJXLDmWSAmees4deJcC5CpW0WedwgazYQdWfeFKqzLda09hb6ax6gE5JLj/jnz9/w+jGyKisJqyLN7OitjvgHzhpJym2G0tKB2SU9N2h6i6XFsL88w1GN1VDIpAUELfGu1QPmwHrhxJiPWALT7pyRxFWHp+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587667; c=relaxed/simple;
	bh=EMXgYQ3wuVK5Fxo3SNdVBuAeNQ5XYwl8tJzZQ+97I+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hI0CD2FqGrN9ZA9O53FTVXleLPhJ7rpUwhbiG+N84PVIFFG1vp0dkFWfcUotbWh2GyrTKtPkhzvqd4U1AKhrtW/kHmV026GWSzHmedJSYhWkYFSTSOO9G5CXyRUKJmdZLSw8RVgIY6BsYxVYLz4VvEhDPD/+5KJXVCi+lHw/LdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nQOLB5Sm; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR6goK13KdlwYIoKdlyz8txcaub2jS8fgFdR6zt/Lh5ee5N13qk5PMEtwq0BObhSKfM8dSW6IaKIM8GaAhbf7sthK3f9PHUqzYAEvPZfBOKMk+Wzd2cbZf1MN+676wCQJEuandSOxoxMR6BJZ8F5XRFCuC9ajfFxUPp6DAAXpqmm4GMK6RRCy/eZfzJgCbsZYgQwJ6ZyYPA+0F7voino1+3/MnXSO2/jOYFFwXYKzO7JngVIwI5az+iZKjcTaDdJF0SxvuTSo7wSuZI5a88OHAQkfZ48eBlBJLzUxgIvGSlDHuzPoODhgmzWVpgMKsi3mx+TysJ881woUbjytMpSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5vsA2s3nRBFXCTQ/HtXRVoaaKXo7sjyxSX2yBzvrTs=;
 b=mCz0QDSIA4EyEEWuzpzvDNr9ZQMAyJozp+J7VLoH9YeAIIqRXHaJMyBD80L3CNGFYB+SXQboXov4fuwae7lHaNQdEJvecmRvfGyCdnczqKhHwXqDt5y79iPOuFtJfW3EC6JktYlEoGC9SyM68LIOwDWhFbwor8fzAUwtHU32dkRtoqDE6CEfB2VmdNNS846dITb/dzdewLjse+H0ej9JRMh1YElJC760sxZagiCkvYy080NfQ774S50qNoZsFajyZ68EK206f/y8Wcg6aLi0oxz94nyDZkhJnnmx0abNHpkWJGedFM7jI1ywgMrSUFAJQft7eD6JLFt2/7hx0oMXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5vsA2s3nRBFXCTQ/HtXRVoaaKXo7sjyxSX2yBzvrTs=;
 b=nQOLB5Sm9TF1TtHw6t6iPDoDcErtYFNHcPX0Jr/e/NJmRSDRPcHzMCa+sFiHF/4YoRxXbtx0GANKchnnVkvwSlKQI1WSa1UlMyEJPDJY+cm7yYorpYhtlf7FTeG6cikXp6pGU4Zy9oVCcWEI41YHVyeB67Vx5PhPNurafGDfokokUxXC095QI1G9kmnxNGE0xhc+x7S4Fja9V1WwDAQu5QxfoIieEAMgFDcLSC/baEDXKjQItA+vQzuSc3NBiIUy7GIsHmk+UzHnkGYSc0syGYf+HWDHfcWnxwKtqiSzt7CvB9Bewn+pX3L2fh50fyZxBKuRK0m6U2kXrjQgFUIJqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 01:27:26 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 01:27:26 +0000
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
Subject: [PATCH 3/8] net: use rest_of_page() macro where appropriate
Date: Tue,  3 Mar 2026 20:27:11 -0500
Message-ID: <20260304012717.201797-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304012717.201797-1-ynorov@nvidia.com>
References: <20260304012717.201797-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0498.namprd03.prod.outlook.com
 (2603:10b6:408:130::23) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 24dfaff4-5ddf-4063-ace8-08de798d3193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	MhAdFMxOTcfWmvFwNn+TB8JTH1ZzKAB31o38SAgD+iWW69JzGXsvWtXI9qZKEiIY9TfVNLSsjF+BvLYFMCSGfxiWggoaKSW3rQdWx+RlcOT5rOuzRw995XIRMY6zMAfvLyGB18AE4XQXLjOpWJw/pulTBHjYCrNthQksefhnZL3I+74waA+SGUEtRFwe2l2f9TL+UcPYfMAs36lJaGyxsfGBy30JvRJKdyyiQ2Ia/mzGf2tAVVRv16VfZvM8l0bpb+FPZOOybNcJVyJIkjoTRYwfW7itRgamZamqlgvq8BsE4yUs6sLZ+oAOU+fNWm9j66y/egbRdZX/wKno4awUfMqbF0T8y0wYhV2InD/F0SZ+2Nf70GaQhHOdxFOSGr4HM5WupQ5S/aaK5BktSBOI7vOA3p7R8K8h3sHH5q1n4o5UG9gJmV5WpSvNH/qyKLH7hGelCsOGRWVca3xG+oDwPpBeFvfyPZSR61JE0SBDxm+SBUuJczmG2MTJYfN0/aBS62EfTPiLaUTvT2rb+kzDvreiL9VP20MmQ0rGZJin5qfcXR9FiPKwVnYUPQlEu9A+htqKlhwxWfv8Yh3B0VMb7MWAwjMwtYPAkIwch/q2fUVmjVgdYHKj8OsTyO9ST5AlEIe80Gb6DiG/jErfRybjQTgp+Ubux5gVAE6LHjuWkYMuP8UWp4osPZHThFWV1X9+7i9xFngXbKErOhJoJuhfZCT4QVs6O1ulzn/sizTUPiW0cHqKC+xXdUs1MyM+lQbjULFY0iboSA8esqiuLwe3dw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dx0PTUYio4phSlJdRsSYuL3wU0xk6Tu+XWQK36nfvbLlh8Om8cPiwpTqakB2?=
 =?us-ascii?Q?q1dP5djeG8E4HIv9pzRuaHwsYeBPlaFcP+GRKwDD0oX7hQe8CXVity3uIAO8?=
 =?us-ascii?Q?BTb0IhJkv7Hea1HOwxM6tjX0ddRz9vRRhaQ8II41ODpR6ONqLGsDOK3+9lpo?=
 =?us-ascii?Q?mLjx7tX47aFtaKijx3SttUQ+/w7w7/oWlmYNjkaGVUDljtWVJ+EWbjVujaYo?=
 =?us-ascii?Q?3+B3xiUwir0inF9SxsaQkB8eLpDHxiITuAfX4ysTdxoSngtBjH3MacCL3Pso?=
 =?us-ascii?Q?gNzGC6mYtFl28D98OiMJA3doJlxgTJCOTPqIovOWGqFnATRNcxqVzdIxM4To?=
 =?us-ascii?Q?2HyYowbKBicFnYaHndPYz3igDLvappQ/Pc3Kk3LC0lyrEeOQv63A1dxIlYjK?=
 =?us-ascii?Q?xIH+pv1oF1/LQWh+uJb88QWQW7n2JmPy0oidb6zF/ICy45gGoz1L0rfRF7z5?=
 =?us-ascii?Q?YKyfKheilcyQY5zaG8uKLRCAaijf/VwHWend8Waa69rrKtMPn7eIzemsQyym?=
 =?us-ascii?Q?WkjtkfUujrt4wwjcnS3XKowJ1RlP3sqXF/wzr3G6EukhuD5iRoahBorUcZEl?=
 =?us-ascii?Q?HM3QVs2VkD890UCcSi1QOQgva5SmzANOUC6AZNw98SLPgtTFKEKLt62S4yB2?=
 =?us-ascii?Q?1hEfoBsy9GvuzmJK38x6dAOk9nJ+wz5AAUtRfN10/9MdaEFSphSIzIWJ+vF3?=
 =?us-ascii?Q?qVQy0s3CLgxoB88vLXp/hI9j3+HatA0243p+qJuJHWIwKlwSDIqRmE71eTgW?=
 =?us-ascii?Q?dvnwkEcv0FxsaEbVZRKRt4ElxKZiN8oSequgD2K4ZsVUNb+ZwKPnlBWJT+L+?=
 =?us-ascii?Q?QUdt1QAd7yTNXQeyiTnQYMcgNwMeIsyGnZFoLWbm6UAShiQpap+8b+3H4eeC?=
 =?us-ascii?Q?WATJ2GEFfF7MZJzOU4wAQWGtG/X725d1R5oVUPpPk3QjLkIny3i2yZkBB2Rr?=
 =?us-ascii?Q?jtwu+e/lqxhi0NhfcYb+t4H6AvkRRzcLH8n7cLRbXZ3V/j/pSPploUlpDscK?=
 =?us-ascii?Q?HeedVUmN+3VVZJw4CRTRXWKdsXzT1Azq9DfXlZF64bc11NEq5ndNduwM3CLM?=
 =?us-ascii?Q?Fyg8nEhXpEdbx5HCiBx5AtwWVnIOrOwEcmQYqDm6Ds43aetc2WiUUUpRMJy2?=
 =?us-ascii?Q?vWyJhapC9kbAShN2AOSb06VMJmVko3MYllJDsKjlajBOmkGEiK9JqXshvj0J?=
 =?us-ascii?Q?WZxa+pqnMkrFLAiH/8psNH9hIqKAoykBh8VnieWeqpJ1Skgjn0Jez+t65Oy/?=
 =?us-ascii?Q?drvfN5JJEtN+Q1fcXoa4jOLob6OTwu+u/YLc0cmokMc1tocR4IBanDrqPFYU?=
 =?us-ascii?Q?Uq7FZSZixnwkH/b1yzZTLgomCGQafupLf9svaep+JwNf5AhmgS5BhKfJSB6S?=
 =?us-ascii?Q?MrF75B54prM9nBin0sj9LV3y4msLq7VJ2KqwKpsZBSB7ligomIiU4N9u6Qc1?=
 =?us-ascii?Q?jz7+29sPljbmXrgEQXbni9Po/8APm2vHiGKUc693rb2dAaoyo1puiY1qOCqB?=
 =?us-ascii?Q?sgLYna33c9S3ppsyqwUr6/N5YYSaQIqF9d+pGyKN750pJ8Tb5B+D1He9PCvO?=
 =?us-ascii?Q?6rjyIfNXQPQPHttdt/gj/dKVDPriNiCV/T+9wGNz8W3y2paWgZfkdoG9UEUK?=
 =?us-ascii?Q?HX/idqsoLmIjvunnzOjCaHRQp4m4OA3X5djU+QFkuidk0q0fqeM3pz71BoFN?=
 =?us-ascii?Q?ulfcabWZcQN94g47WoSQa3wvOIWr4f79E7IwNOUE/aoWmnnCSnzjcSYMU8Ms?=
 =?us-ascii?Q?2oXTHRHIdhzBtiadl4O4l+4IM/dD3YOw4b8AKFlTlUNgthhBQGun?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dfaff4-5ddf-4063-ace8-08de798d3193
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 01:27:26.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMZtp+osTM4sMqRHt05wf4c2umOwSlElBVOho7s3B4bOjDODszfb5bKBtpG8NmPyqtoWzoToNnoXTX74Szm+CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
X-Rspamd-Queue-Id: 312D61F9760
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,davemloft.net,redhat.com,mit.edu,eecs.berkeley.edu,fb.com,linux.ibm.com,zeniv.linux.org.uk,dilger.ca,lunn.ch,kernel.org,opensynergy.com,alien8.de,arm.com,linux.intel.com,gmail.com,codewreck.org,linux.dev,google.com,gondor.apana.org.au,perex.cz,kernel.dk,ionkov.net,ellerman.id.au,szeredi.hu,dabbelt.com,infradead.org,intel.com,ffwll.ch,suse.com,ursulin.net];
	TAGGED_FROM(0.00)[bounces-79307-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[86];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Switch networking codebase to using the macro. No functional changes
intended.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c | 6 +++---
 drivers/s390/net/qeth_core_main.c           | 6 ++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
index 517ed8b2f1cb..2e80c25ba3c8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
@@ -52,7 +52,7 @@ struct fbnic_tlv_msg *fbnic_tlv_msg_alloc(u16 msg_id)
  **/
 int fbnic_tlv_attr_put_flag(struct fbnic_tlv_msg *msg, const u16 attr_id)
 {
-	int attr_max_len = PAGE_SIZE - offset_in_page(msg) - sizeof(*msg);
+	int attr_max_len = rest_of_page(msg) - sizeof(*msg);
 	struct fbnic_tlv_hdr hdr = { 0 };
 	struct fbnic_tlv_msg *attr;
 
@@ -94,7 +94,7 @@ int fbnic_tlv_attr_put_flag(struct fbnic_tlv_msg *msg, const u16 attr_id)
 int fbnic_tlv_attr_put_value(struct fbnic_tlv_msg *msg, const u16 attr_id,
 			     const void *value, const int len)
 {
-	int attr_max_len = PAGE_SIZE - offset_in_page(msg) - sizeof(*msg);
+	int attr_max_len = rest_of_page(msg) - sizeof(*msg);
 	struct fbnic_tlv_hdr hdr = { 0 };
 	struct fbnic_tlv_msg *attr;
 
@@ -292,7 +292,7 @@ ssize_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *dst,
 struct fbnic_tlv_msg *fbnic_tlv_attr_nest_start(struct fbnic_tlv_msg *msg,
 						u16 attr_id)
 {
-	int attr_max_len = PAGE_SIZE - offset_in_page(msg) - sizeof(*msg);
+	int attr_max_len = rest_of_page(msg) - sizeof(*msg);
 	struct fbnic_tlv_msg *attr = &msg[le16_to_cpu(msg->hdr.len)];
 	struct fbnic_tlv_hdr hdr = { 0 };
 
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cf5f760d0e02..5012c22d8f37 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4087,8 +4087,7 @@ static unsigned int qeth_fill_buffer(struct qeth_qdio_out_buffer *buf,
 
 	/* map linear part into buffer element(s) */
 	while (length > 0) {
-		elem_length = min_t(unsigned int, length,
-				    PAGE_SIZE - offset_in_page(data));
+		elem_length = min_t(unsigned int, length, rest_of_page(data));
 
 		buffer->element[element].addr = virt_to_dma64(data);
 		buffer->element[element].length = elem_length;
@@ -4117,8 +4116,7 @@ static unsigned int qeth_fill_buffer(struct qeth_qdio_out_buffer *buf,
 		data = skb_frag_address(frag);
 		length = skb_frag_size(frag);
 		while (length > 0) {
-			elem_length = min_t(unsigned int, length,
-					    PAGE_SIZE - offset_in_page(data));
+			elem_length = min_t(unsigned int, length, rest_of_page(data));
 
 			buffer->element[element].addr = virt_to_dma64(data);
 			buffer->element[element].length = elem_length;
-- 
2.43.0


