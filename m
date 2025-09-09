Return-Path: <linux-fsdevel+bounces-60694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96787B501EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC144E268F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02832D8379;
	Tue,  9 Sep 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EJr8viPW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479D4AEE2;
	Tue,  9 Sep 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433254; cv=fail; b=R3yuj728aW5Pdzlng9i062VhMZoK7ypfIwqKVf1QXP1J4DS4ZDeR9QJ/xK/VI+PMky9fsnXaHc/sBGTBbZlPr4yI/PY1MlobRKypRm/cz4MPS5U/5pj+G0fZf6VdPmI808lbJf2+puWDDQVABQjiLkNHAP84GFRdZyVrI+HzuBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433254; c=relaxed/simple;
	bh=C1YjSLY6o5MP5/Zj21h6yLIShZmsmDX1LxEStPSdbaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q5MnQqH4g5MBsuLT81Xpw6Vk9cmbWQ6olwv/1fAUX1dXPFrmuR0B/HViL1js9jOqEkqpZ1WD29X0chnA2UMPzwmr/6kLS4ctW8OLu7bjWjLl5fVwKCQmx1R14RjeNCNbCBeRCOYaKFn2N4MKmxpQU6oRyfPh1Sqlpgr8UpKYuGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EJr8viPW; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFo4Zm8DFBK40L+8u96LMufXDL8hTXUtKIUE1kF18DVxXOGM6V8yY0twSi2e/RCgIiKG6BaA/xBsCEt2G9xJYTdtxcpDs4y5zULE9Tu1lCNSe4Oy3AipAfPr5wKR8c4k1tMG1prLqAbcMJTz2C4AOo7+lQhY5OavLDsJbikYy5cOcwFVJ2w7QKLxXmu3NfjdBmLOiI1QxThEDoDoogvpEqJ2YE8kQP9QEY5DE+hPsiLMgny+PxT3A8ZIaQmgNxZY8OHnR3glaIt9O4lnZI+CdaDg3+cYrhbZZFOJ9kPhNuxxGzyQa62QQCW6QEZVrv0+rmbJe9eE27ySuPMinaAdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1YjSLY6o5MP5/Zj21h6yLIShZmsmDX1LxEStPSdbaI=;
 b=kku8Lkp058IYuHcYzTWk4rUmsEK4FsRs9XXkiaNiOzwczmCXBqD6UPDlHgYLKb6efOMP2RV38qHI4kwX/HviQCpCtSHJRgeCZ8bMAQ/H2FvS+/L46DE5Tlbjg4Qk/acdM7sYq9AUaOCsdxigSvuje8aLzlh7z8DwLnmUJ8utMz/1mMFdk/bR+UrcNsFLbX9rhnr8LLKgBo8ogJHFA8yU1AzK8pMVL6Bee81XQ/ySkwYKotZfV5DeKBkKCmFSnX0AH1iCAgFZtJWayvhjnruAL5nlpIjItjQpkLt3dxzkDb0wJSb2I6LmTZ7plk8WnBdqorXteBGxXiFq8+ayhQoKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1YjSLY6o5MP5/Zj21h6yLIShZmsmDX1LxEStPSdbaI=;
 b=EJr8viPWMYbJkqY/rX829duPjrHSDGS5xhG/LLAnCxcBPfc6NisI0rkMyG9f8k2fPCE7edTliAR1i6pS/DPP04iY0b/TXGfJ/yM1mPOhIN8q3kSisy4DGwrLIEfIVdxmft7MLPvTjvtAx4mLONmyl7DlqpqKrUAD6SiKs6kKCwulPUj+J9lb5N5ia0nrXuQrbclFypIgsfwE9t2AAQtVqAhMKqnRnID0v+KFDkTiLRdZVlxVmEQX+z1pMbm5HcllLOqdtVCyLnTY+Bm5jPoRR9JouOiYsdVUj8gRPGOt4H3XZOU7ZTHzu9bs+geqxCMdYx/Ze46f0SsH44ONegU8oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:54:09 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:54:09 +0000
Date: Tue, 9 Sep 2025 12:54:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>,
	Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <20250909155407.GO789684@nvidia.com>
References: <mafs0bjo0yffo.fsf@kernel.org>
 <20250828124320.GB7333@nvidia.com>
 <mafs0h5xmw12a.fsf@kernel.org>
 <20250902134846.GN186519@nvidia.com>
 <mafs0v7lzvd7m.fsf@kernel.org>
 <20250903150157.GH470103@nvidia.com>
 <mafs0a53av0hs.fsf@kernel.org>
 <20250904144240.GO470103@nvidia.com>
 <mafs0cy7zllsn.fsf@yadavpratyush.com>
 <CA+CK2bAKL-gyER2abOV-f4M6HOx9=xDE+=jtcDL6YFbQf1-6og@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAKL-gyER2abOV-f4M6HOx9=xDE+=jtcDL6YFbQf1-6og@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::14) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: aa873257-f9b1-4375-75bb-08ddefb91cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CkbezBpYzYgKp0EzQBqraghY9zN1yFBeGl2UVeHLaHZ4eaB6+9Htm/VhLRJ8?=
 =?us-ascii?Q?rXFPbJ/DcvQltit1sp0ejweJd+WAwKN7budVx93oIWCrb+1DYRT/E5msmCnT?=
 =?us-ascii?Q?gb4vM1w3bgaoNGOvjJZqIzx44uiztPIk7vBHuWs3la33R6AlVIXJG4mWtyf+?=
 =?us-ascii?Q?Oxc+UWwYPOn9qEjnznMpEpviwSP8ZUh8aqKavVCfslLf1Khs/V1oCCvu1ULl?=
 =?us-ascii?Q?Wryf2MIbtsZR5R9GSozR6aSt/bu/TfKaNKBzz3smvwDLvYkwWmhSwwBWS1V0?=
 =?us-ascii?Q?tSEpgpdzmczGWK8k/9MOyvRXu5G5gvXXiKwfBdzdhddtoLReVZBp6Pfef9Gx?=
 =?us-ascii?Q?osMqA94ayJCS0p6MIwCn1tibBi6DzJZgaGBEVkAGzBGMPZJ8TnFt1U7dfkA0?=
 =?us-ascii?Q?aYE4XcplVtvegN+STXq3cMxfftjEx8zFZ08J7pEEPOX1K4/Ga4LWA0VaiTlv?=
 =?us-ascii?Q?TAyW0jrdVdcnhB/R6cPXOC3fS1WvWC53mZNONVOWmJcIfWncDwdEMivFjU3T?=
 =?us-ascii?Q?5yuzLMMcPViXcgTlh1RrQ8bO6UGninPahFRRLqvgzFzXIa22pSFvd1B0Keji?=
 =?us-ascii?Q?NxYdkZp+HA+CkPIHgM3fw3P6t/005jNtcPzPVeootLJYleczs7I6jsuMd6oi?=
 =?us-ascii?Q?Dw6LeVXDmPXtnImpbZm0tbFjPAvSASvAKdKjCesaeLgyjAYENF3GUxauKdCu?=
 =?us-ascii?Q?Q8PNh5lKHDWliUs2fma4W3CIZZLYPf84I6rcY1rGlsqKlPwR/Ph79YD5yA9X?=
 =?us-ascii?Q?ODx9Wp3eBqEkyrMOIHogHpgsx5SGozE/pn1w0+GB3ORGiKTk+TW+Ou7yxlpG?=
 =?us-ascii?Q?d1NGwd6KAEdVDbi1M42ToiayiiQStaWdJjDzvhRlBWoMJVQm8k0bDD89U8Xn?=
 =?us-ascii?Q?+Y9zwvC1AskVazMYiHSmXSs4JK0E9w6/vsmI5cK4U3aJ/DMYMTtzKfXF7cpZ?=
 =?us-ascii?Q?fFGm/qjG5vKXlnd7j0FxNzB9jU0xv8gRYCbFnU+QO4LufYEgOd+AEWzJoQ4p?=
 =?us-ascii?Q?pZjj19BoYPAfay4JbtBGalfPdMjO/exCFxGpGyZL6vZz6kyl7+bjmQQaHk1Y?=
 =?us-ascii?Q?s504DN2NLi1UOIExEOW5n9QDMyAVDwYDw4GKQ0XYbbfbhnMPhJJDnLi5aloK?=
 =?us-ascii?Q?D0Skhvo92XoVZF0A18Plg5/6mxtQZjKX88iGiOffkEpytf/xRLnwvPpnpi6A?=
 =?us-ascii?Q?2BBdpOwYl0Ig6gBYa9+qtf7GBkuz60XbzUcNbTB+tTdKZyeJDLy09a1ba97r?=
 =?us-ascii?Q?0PHmG141SY1t3tqOkjuqDm91R8eK6Ws9LeeJh3upMpB2g+FCWUNQ21bqyFPj?=
 =?us-ascii?Q?5yrJyREEJup/Zt7BeGyCf+LBPy9+0Zx49VZyw8+gWf0+nAoJ9D+0kGpnCgZH?=
 =?us-ascii?Q?Ckq2Ga6AYHDYeuG2fP9nLWEIohn1s2aCWZ+P3CPetF32/cE6lQ+AwKu5fM3z?=
 =?us-ascii?Q?woTUJpq8r3o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9jHwiGeG5rmiBVXOAGFmPo1FjFuNxzN7u1NFCRu4DUdevuN5IlT5/txqsvME?=
 =?us-ascii?Q?vxX/YNnMhiCOZhpVukYVd8fM7tBq6oVPDl6kodbdsUQeIzehJfBgOiNFMatr?=
 =?us-ascii?Q?hGlB3G0CUDHYP6YXAD4ajwb4ADbr4PBtu1QzaXFWmDCHIyT75PbCIBk7jyfl?=
 =?us-ascii?Q?vCVop6PuCb2BTV/KCDKWad0OGuNXVL1sU4QOheL9ZNEacn7m3yZZ8Ig5Ypq7?=
 =?us-ascii?Q?o8q8yfI2YhmE6mdvfaEjRl5EwD0rMjJS/IJnMTK8tiXHi1kNWKXGxqUKyjwf?=
 =?us-ascii?Q?CTHuPDy6B1+OcTbiFRISDCi2fH9j0xceQtfoo3AoEvnYvdVQvSipY7Md3Bx2?=
 =?us-ascii?Q?gsT+gz8xDodBoTkFtoC9Hu7o+A7F1KGHnxOqRGFSsaEpBehoHTFj1wJk/yxG?=
 =?us-ascii?Q?3nbAgIib0OHr6JUYCJ4RcpxbQ6NZwI+MhRWX+mRmHYH41Qhei9uY0GNYEklK?=
 =?us-ascii?Q?Wni1b4eWDHdpvXYxYYSbHtrbeKmljAyiPXgkZPIrfIwSotg5TOgEPCJ4grUV?=
 =?us-ascii?Q?1IBL+vuMAiOcOtURlB+DUsF9YwQTAsz58iu097wjZ/PZ7rSxgijwQ9QrDLF0?=
 =?us-ascii?Q?VRcWROOUX7jYJDs85KXVuCFJePuPpzyZ2jZGruXs070aHWyIJY9FmnYUHHSs?=
 =?us-ascii?Q?dVFEui1+18R1QiYA8H/RT8hOTbMyZIGmQZrDnZLWKhQbKuczUPBZ0Weo0JsA?=
 =?us-ascii?Q?amZrSu9aRFTbQK6OYLTT9gSMuPtbLiYpBGyI/YWsw9Fj9bTqe9NNd+SFOMtZ?=
 =?us-ascii?Q?Mh+huXd2wxs0f9QW0xkctmK/lphRlGeGRxx5cCKfP08On7mlpSKUvbfXhPVY?=
 =?us-ascii?Q?RktNPadz5YmBZHPegrY185Rvqt4O6UMUAEK+7N2EU1jUpUlFRbI52YkOY/Me?=
 =?us-ascii?Q?M/5Q7y7J7ILhpatUd3PPOvyKe9chTe/BaS9PyQWMQYXur85Ua4gnAeNYSgr5?=
 =?us-ascii?Q?GBMgmt0FJ6j172qu1T9gxWbINq8OEibNxnpTS4cLSrZop0pm3VHvQR+6YJ6s?=
 =?us-ascii?Q?on6rj59M/DMqjHLNI0VV+BSrUV8y19yT6bBJ1o7YE7BezMBrqprl3BA9fix2?=
 =?us-ascii?Q?yg785DhI7A0fIL2Apup/GC3JFZxyWu0bnx8Up364feP+z2cRk/KlQo6w2HwC?=
 =?us-ascii?Q?uvjmSquWGDK8K8cuqPibQMXknIjAsQcKGt+pxxLqNx/hlJDJng9YePLZK94G?=
 =?us-ascii?Q?fLBFKks/JEgjG0Kf8T1a52Tkr/G6J+HJwSb3Lv0Xxb/Q9d//L2SBK0V53+b8?=
 =?us-ascii?Q?2VaMyeXaZz5A58ny8+EWXYKpdU4wnKUSRBI5mX3v+8ie/dCMHU4FNrB34in+?=
 =?us-ascii?Q?SXsKqoWXlYoWPEtOAz2LqWCL3h/sQ9VW2+ecxA0B6WmHts0YrWmzqGP3VjIW?=
 =?us-ascii?Q?gg/G+59g4Fo0ps8ujZPU+gZGYyFxGNx2ZrPRfiX8PylEVUBj4E+Ud2i/huJ5?=
 =?us-ascii?Q?ozxdqLpAvtoRicNvZOdn2mIuE8aZFTF3YV7yOeyfXmDW5758X4o3dxCHd4yA?=
 =?us-ascii?Q?sQAXFgsKQ95TrSgLWmwQdBaDXBAbiHWHskY9khIdjMJUVrNo+SOzL4qlWt6E?=
 =?us-ascii?Q?hpenPNblD4icYojzHdw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa873257-f9b1-4375-75bb-08ddefb91cc9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:54:08.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kjnua0nDjAXmF/PT2tbBqZcf9YD4SDvbMYj4C2ecMJPmFR3T/GxlC7q3PjPc2hCH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

On Tue, Sep 09, 2025 at 11:40:18AM -0400, Pasha Tatashin wrote:
> In reality, this is not something that is high priority for cloud
> providers, because these kinds of incompatibilities would be found
> during qualification; the kernel will fail to update by detecting a
> version mismatch during boot instead of during shutdown.

Given I expect CSPs will have to add-in specific version support for
their own special version-pair needs, I think it would be helpful in
the long run to have a tool that reported what versions a kernel build
wrote and parsed. Test-to-learn the same information sounds a bit too
difficult.

Something with ELF is probably how to do that, but I don't imagine a
use in a runtime check consuming this information.

Jason

