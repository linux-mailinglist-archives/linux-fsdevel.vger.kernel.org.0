Return-Path: <linux-fsdevel+bounces-57894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEB6B267EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88159561D41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4A30AAB7;
	Thu, 14 Aug 2025 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uJ5GsaCO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712AC301012;
	Thu, 14 Aug 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178322; cv=fail; b=CeLU2CyOhP6O8CHgdjxJuO1uMK/4GorTxpJYjAcrEHsYJ6r4dTKp3+MO1+7t+atyXbdoRaUK6RrdgStOfHXzdQm0pLYBhiQCi35hZDipZboxqfrRWzmfP7W0fy1R8L1gxhwUlCNaLEZIA7R46hZ6lBLJ4QZ1gNQHBHmqOTSC7tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178322; c=relaxed/simple;
	bh=Jk40TipyB0HeO2lFI1Smgu1EYQHQpi4CPqyKlQGwH+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dXnyF79iY7hcUsbaV8GBQ9UmXIjv4VRUT+Q68rntnSdJe/s5c1YRdXi/P+i7cDdYFojAtmtrCG/6RDcOGeqYBjiKfXvmDNTdbSJdSuVSiaszWQlLLbmkRiV83ZL1XpwTKq4yaECbZtu27ScDhHlMtiYL5s4cJ6zy6NUM84NfD80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uJ5GsaCO; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fg3fBvnFZQZ4JzLqZ6qUyQuKxE8vRS5gwjcZolYWtH49JWvBRLIAxw1J6FqcfTf0btCf8VptiXemMr0Ke3ZVNV+TymMDiZjyfo4J9dJXZigESF3mRKFY4myWKtrnyZQCj5E4w0h5ClptoLP7HQE3clPCKis1zzCtx8YE6G/PdIdtsFH9SkBJiWhbyQlDMlt+4qMxoa4296L4ncQjjOAqkopimfJc2iABlqgsC0q7FXMU8KofqOE7pFSgwT5ze+Ka/M3yzAJ4WigwIEZZzE2eRDHcTEnvhoUE0prbA9fcmG6vy4E2YosyQo79kInbsOmm3phPibT867wJC7c3+aVayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YdLbRXVppiGhJ1TMRRqg37WmNnMGj0I5PxUD8DOAhs=;
 b=fUrGp/TWYrd7UU1YFT/bDeC7ubxGIaNbBD1kPryD2vZHSPbbIVi7nyhk3yQ5Zn6bhwh5f+M3invmZPFU9oyUDzpqguT0Boc2+iKb1TTuJTdH+BsIUdwwaB30ZSrpVArVJtXaMRd56L4CXsLzzgezx5Mh5v8+XuX5kY3714HQpP18lwJWtWuka+5CTxF2stAupj2vlvEuAvxoHrCyWZas2eIWmuMBqUR+5W23GFc/LGFw7SMO2h22SlttfzhIJ+Y4SZvro+b+vgmTm3Gz2OPgVsZbr5/3ppkhmqZqzBnV9Ajp+Tq8SsXIVS0xgZTzLVEg5xQY7Qn7rDkksoGkU/oBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YdLbRXVppiGhJ1TMRRqg37WmNnMGj0I5PxUD8DOAhs=;
 b=uJ5GsaCOeo+xJOysB2DKqPSmaZnGE6iwyitt0fo5e7ZrPVB7Tf+8vWe3LE4/th/wOnIYLf+g5C0ofz83JKd8iyibzengQ0WZHjE6nPYVv1HwXevugGkkoRCavWFDvJxiLyy6LPulk0BmpZsigTXaeTM0WvRcojKJOZOzjkvf7YDyEZkJbndiP6z0045xlmTp6VhMY2PedJ/W5wnUDbbuzb2c6AjqUDrRQrdB2XWGQdkXsJCJDu4tuW+0RKkE5VxwqOOw2W84l/azoMD+h/HMmTXbiGn+9orp+HKvmY8rjFtEA9mKRmjNjTgws7mGbaZ8OEtz9IfKKVW45gcFBl9rBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Thu, 14 Aug
 2025 13:31:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 13:31:53 +0000
Date: Thu, 14 Aug 2025 10:31:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
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
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 10/30] liveupdate: luo_core: luo_ioctl: Live Update
 Orchestrator
Message-ID: <20250814133151.GD802098@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-11-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-11-pasha.tatashin@soleen.com>
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 0863e47c-ad5e-40dd-70e4-08dddb36ee21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7/iEKDv8SeUN3ZFTtHniDa2zvxePhJWVbhWyhtdF/B3qA/E0XDZ9uxKzsSRf?=
 =?us-ascii?Q?6DSj+MOSVNn31msCFKj1ZntzsvrUOJWlhBLd2qfMt0OF6iZiFXvmjTskC7MA?=
 =?us-ascii?Q?p6zGz+XcDEaauvjudHEaKoswHEgQPd3PhvebZhwUqLF8OO7JXYcTj9pR6wv+?=
 =?us-ascii?Q?wxgLP673c6K+wK/a4/pX5MHfEkhBvZG9zFgFibaVIysPjP/VpZD8dD5isxle?=
 =?us-ascii?Q?D8o02LvqFvi2o7XwOYPWujHWItyYK5wyE3SByQ96LDx+ZXl5xi+ZrXWuxLJM?=
 =?us-ascii?Q?Wlu5OvFxA1ux43JhJJAOEfWRUTQg+DYG/+uyU0M3BU1RlKXsWOdST4fLwk6U?=
 =?us-ascii?Q?UbXqgEH7MuoG4qzVXitkRf8jQ+V7zoUhQLlCuAnxT41ue8PgqynOMiqwLr3j?=
 =?us-ascii?Q?Uw8M+4Ixa1hp4GB3+EYLj1UtYtXyGVh026sUSV8OsYFQFpzLb+xs3e5Yg+lq?=
 =?us-ascii?Q?aDJcgy+0etSq4OXO5r7WxD4Di3HdIuqn6mF0nvbsjpKWmdWwnncFhFJSFBY6?=
 =?us-ascii?Q?r1IY3lO0BSIcfH6Y+dDrWKVANUkk4ipBUM7kUC+IqtflN21rQZJ0K7gCTsKd?=
 =?us-ascii?Q?PoDhF4obTv3Wqheo6+7AJlNgBSmMV7v4PVNOxok4ObmW5lS939fXcw6bdY/I?=
 =?us-ascii?Q?4ZQ9bW0QYTMr4paPV1VSbevKOLayg/KhPXlJJYKMEeQRV1gNHrJJisgE1KIE?=
 =?us-ascii?Q?aPs3BkCIUOMytKFuo1sJ7UIT1pWjPoeMR3khienUTDtMrebtItSNnnI8rl1Q?=
 =?us-ascii?Q?zMfziRHiXx5xfrN345+aNJ49tsZPqwQaqztKuUq2hYczAYRLWfR+tnErEM12?=
 =?us-ascii?Q?L2Lze5npVVsBDBdp88B1YPZAeb+u970c3NUtrvxZFMGZAWF53h0gXqkG/4/u?=
 =?us-ascii?Q?7gGJHYBKFVXw61aO0tqudg6FN9/xFpKAsGiTYQo63Fsagj6bJUOH7NO4oHpW?=
 =?us-ascii?Q?rAsitLiokl9NPPYqRPQS2jNxY/fo1z8kKm5dRUwtMtLB1PeCmJzyjY0yzOWG?=
 =?us-ascii?Q?13Q2pS9KCl24T7jPwowq55rRfzT4lUkxq9cvaGJBLUJ3gwoaJlkei4u7gMeq?=
 =?us-ascii?Q?wxlhLrTn19VncOgebjRcFK8J9rtLNFqYR7L5BAxZzAUeRRQ2sP+BiLoyR5RO?=
 =?us-ascii?Q?nJJ7dYropYfqXvLtGoLvRJR33o3vlhkoeLUhvC0e2VACR1Lxbfbky+ffsrpO?=
 =?us-ascii?Q?PfGdx3384Vo/S3IHEyhb8K8HC7KX6lxQMz5VbBtrNquZ1A62Ixhp57p+EeF7?=
 =?us-ascii?Q?HQ+NZ9JC5KPctXC8/8pE/mm3cYBnp6DxSmr6KSIfCvAJsYtBjNTh2ViN5D6r?=
 =?us-ascii?Q?frD8kSB3SO1LRk5nMQsplcMwbrDfdYdYcCcSk8iqNENqG6yrgWukxBaqJXrx?=
 =?us-ascii?Q?wnISHhDCGS/yeTtBzKVoeJf2PtC0fm6Nv5/m4v/nHgi2ARDJlziZWpUcdK/L?=
 =?us-ascii?Q?hRV3ri6HEVo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ba3JFMutvPkzxjF2jBUtVOANVUEFFKuCaqoGbb3OP4hbMc6lR2069+S5xHMI?=
 =?us-ascii?Q?rDrxCX8z5hYHTqmfFHFIwwwdRTjxInso+O9fb3udXgFDzmKGgcjzNK/d1TX9?=
 =?us-ascii?Q?neMp5FHwD75fCN1WIKH+uere0ARnrdlBhkABezqk5xfPwQrucieioiI8i1a+?=
 =?us-ascii?Q?XCJJ0RNLFjxxWXR5JCaZmgBaShuPauAJjfmrlYnwyzYo6c40D4BXiI2VFp7W?=
 =?us-ascii?Q?1YIZNX3odST7BN2BYvPdula3Q0kL46OdAlXvLWGk7yxTacZVSen7zTUQcrPH?=
 =?us-ascii?Q?yAuz7pwytAIQiwzHaw9BjFN5NakZK3MdkzOlg55E3q3aWW73w2HEx35rretv?=
 =?us-ascii?Q?+L6TXjtcE1RU4yr8Mk45LS+G7lPTLaavnTbl6hfxOCyQF/mpu2YzRdTk7a9C?=
 =?us-ascii?Q?JqXVBo5f95seOCfk4wbOXK98xrjiwEJfRrlBe0cYPq16LYwr/gxH2+GZxwqc?=
 =?us-ascii?Q?sRWtaQSB4ZW0MGt4MzSNviLcwMQ7KmONuw5x+2N0Y8ULIOMFbxLMHzvef1oR?=
 =?us-ascii?Q?BJ/F0kLX3PwmuErr2DtZf7N42wQM83z58iVqOfBSnvZWOLsCvjjq+/5x4u+9?=
 =?us-ascii?Q?xBrjMetWpeqpDDa/60fLul3EWNJnF2Es3eibB4YRzt23mjRst0YGjYQbhX46?=
 =?us-ascii?Q?zXEFgnIqnuqRk8mGcDjsfEzftA+wxSX2ys2JgTwnha1L9pNFH44yO973gOWE?=
 =?us-ascii?Q?3N2h/fwWDnjfRb1qZFRUZSjabP7UTcbmasy3emccX8UWT8GL8FueBGg3EHDm?=
 =?us-ascii?Q?DaW1o3tiZilM2EcI+wKBRPliXf7CwQ27b6NARdqgd1kSxD6kkmLDCFL/bb4J?=
 =?us-ascii?Q?XquVjdxS76Bz5n9Valpc84o+2hudusJ/LSw91Y1mfj00uBVZLJU5QH0+pI1W?=
 =?us-ascii?Q?urxEOjuvp0jmAB0kVqxe7rtAs5RGxe2TtbGlhAp5AnNMGxLlrNGjQyRWP48q?=
 =?us-ascii?Q?XyLcDEqs1enId+Lk85hLE7iCw4DH/wcrxoLY2yomC8mNz8Qo433+1xj4fKsX?=
 =?us-ascii?Q?ZcwF/qAYbJ5X8eXKYENoZZQEYPLOWKIlAtoxSzpsonD8d/XWV6wX3P5dcoCZ?=
 =?us-ascii?Q?vH+uLz4BHrFBUlutfrg1X3eleMz/Dz6TQh4oPKhJcOsArdjkvj9N8RXmiiQ/?=
 =?us-ascii?Q?4UNigvrOIFfFQZuJq0SpSbjxnn4me879GSXzqcpN2Y3S1MdvObycR3lYjmDU?=
 =?us-ascii?Q?ZcXVIIgsOXRn1kpSn+JoM66/nyMcH/LxTAT0T9GloN78iHt42B9edpxfIXBN?=
 =?us-ascii?Q?9OkxPSOgYPtcCF4/CIhXzr4L+VUkonqUBPSnHdaHepoRsXBEH4CaU4x76yIk?=
 =?us-ascii?Q?nj1VX2gi9Dl7UzGWA87pLueCAlrg1MFaN3sW4Bcpxqdt4+JmSN13W2XxH/BT?=
 =?us-ascii?Q?+h99z1/q8+KlVBTvpbeuGL+osRj5pNxW3h8iDbqUND3Py9mUEc9wmXLiP11g?=
 =?us-ascii?Q?ZspntFXSuyYuNQb6cGFxGgrjs7x1I5jLGHZBGJQfVm7DmoUGHwRE8jvrihP8?=
 =?us-ascii?Q?fUd4ibGcvW0uwlCGQJALuCPSYxd1Z1DqqVc9zh4ND08DTrrnJuqzghmbzdaX?=
 =?us-ascii?Q?9eLdlDuGAe48hZ+N/X8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0863e47c-ad5e-40dd-70e4-08dddb36ee21
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:31:53.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03hrOkOP3JnlmfutoKXBbZilZ5AeEYfzHPbwhVOuEOd/dylXOiHM+L4yi+CrKuo5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

On Thu, Aug 07, 2025 at 01:44:16AM +0000, Pasha Tatashin wrote:
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -383,6 +383,8 @@ Code  Seq#    Include File                                             Comments
>  0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                                Marvell CN10K DPI driver
>  0xB8  all    uapi/linux/mshv.h                                         Microsoft Hyper-V /dev/mshv driver
>                                                                         <mailto:linux-hyperv@vger.kernel.org>
> +0xBA  all    uapi/linux/liveupdate.h                                   Pasha Tatashin
> +                                                                       <mailto:pasha.tatashin@soleen.com>

Let's not be greedy ;) Just take 00-0F for the moment

Jason

