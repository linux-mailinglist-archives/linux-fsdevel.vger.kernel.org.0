Return-Path: <linux-fsdevel+bounces-76993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JhVK09kjWn01wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:25:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7139A12A655
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56DDD3093588
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 05:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B533284B54;
	Thu, 12 Feb 2026 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="S26cIGc/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021142.outbound.protection.outlook.com [52.101.62.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839C27FB34;
	Thu, 12 Feb 2026 05:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770873926; cv=fail; b=RU1Y8jbDIZTf8zeoy4pmUmBfdBGM+7mEW5b1Kgx5M59qn7G/m+LgSv2pmq3gdKC0AeX+28b9OrRPEweJ86YzIK3YlHDY6LP6vXgbIbWF9FMmTK+kh4DKuyB/G/NQsWe2LGYdNebpV5lP2bWjIHev26+5IkZgCYMq1Q6v3Ulp03g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770873926; c=relaxed/simple;
	bh=uFSAJcFXhjUOxZ/oLJiBln7ZJIlDoKKDxjxgHoXPBQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rB5bPbzDBoVUDeRnadHwtQUL8RF2auhvtkWfsbz83gYiqIkRXRSvZj/phh+FO7nI2f034mQjSSAJ6BRLTPgWKn2TM5qFAofQVcJnR+I8LRfPcXwvrM5wTzJiMdzqY8ck7RLm8PLHaSqi7glKc0++0FqJEYHnJpA2ColRL6Doi14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=S26cIGc/; arc=fail smtp.client-ip=52.101.62.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2ZNcLwTK4eIoVUq3/iFPwptSTIYqdjtE+C7OyArQaKpR8y1bNlJp/dk06RPBeEyeBJsjFan8gUj6ylT6Rsg5cmia2kxOYybm31T2yd0Xu0702gYWLnpK3ssH0iVwWjAqgAnrHMEwfq42zPHNEsPc/Vb5SSpk/04WzZiP55j4a1k/8dUxHCt7lhGfkF11knZoJc/jcHTQVZiDIEGN7WPR04k3U5DaUCGmiEE46yvmzSGyZlDFewkXjV9dfVTLD4A0c8CQ6PK7szp7F7830qHYZdeOtBfigL4MAy4ePHWYbuP3tQLkQ3UH0WtWNw+mE9VVVpi+1WqnkFbTPzAimYSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dooO3FPDJYOgTxQo+KLSLGuDRjQieYIT/VT+wyA4NSM=;
 b=KUi79FDBKVlAqw1fvShxqC0hLhvTixF2euRzunnRzh4ExjK1zjEjKDc+kD7jyO5EXACMuYzocKsfmIBe3WZgjUp51/OHbVmooZP7zCKeZ76dB4L8j7BQBkO/TNIAzsUNgBD1YQhoWe3lCmHuhfhLt76sYunTW/P895AfCmjFSnzZA8WaEk17zNEFStwmb+BI4FAF3/uPtNAE7/Whfu++9v9V+Dd8Q0LW0CuPl/uBzUL2/EXVSqfZEnC/jD6z1FEsFJWU4Ny+YeYgGAtCT/C/AupZ0ki/Otm4lQNHif2pJovs/MVjsrvPg3cQSSM234crHrGM+dmhqIlG+wlN5TUVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dooO3FPDJYOgTxQo+KLSLGuDRjQieYIT/VT+wyA4NSM=;
 b=S26cIGc/ij8/Uukaso/UwV2BXIie/81aM/I364xCs1AAHSM17zCP5PUUFMZbwVn0zXUIQ7oeUisoCahZVLFwFUKP7E6N1LeVh9c1BFf44PEMvUggR336s0/mp2Y0BXytGv4mPduxzh0/BiFvXx6EPBgToD3aACFVX4Rar/Ivwyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BN0PR13MB4695.namprd13.prod.outlook.com (2603:10b6:408:125::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 05:25:21 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 05:25:20 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v6 2/3] NFSD/export: Add sign_fh export option
Date: Thu, 12 Feb 2026 00:25:15 -0500
Message-ID: <e10c9b71fe3a430d171ed184a22fa186b28894c4.1770873427.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770873427.git.bcodding@hammerspace.com>
References: <cover.1770873427.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::8) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BN0PR13MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: e8867635-ab10-45e7-e06d-08de69f71d9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bgLNuAT6PNLNZY/gWMHpKyiYFkIQdA86x5R45fr7qLtS2CB2vUnM3vZ1dFdO?=
 =?us-ascii?Q?9X/rSLB+FZgyYrze7E0qxY8glpFI6W8oEdhXYvQOz6mQccuxkUWfLe3TkorT?=
 =?us-ascii?Q?vp4k/n2e6pYsMvJdPujSvE2WIGkHSVg5Xt91Yzz2V0M7vf+ai3yximSqgjla?=
 =?us-ascii?Q?uYqZ7hOqIRM4vg4sG5+jeBCTUUkvnJLfsdeIx6aO19xK8+kAnvobSlILoj9J?=
 =?us-ascii?Q?G1slI0Nlk4PcVyQ9umlxu8eEQwlNqlyaSkCoYrKTssFS82LDUi83adeoFkWg?=
 =?us-ascii?Q?7B1PfX8PtEut/4G7IId+3NCkc6wiMurH6KmaTXv5ZFMzCiPGd1Sen5FO8Jiz?=
 =?us-ascii?Q?T5J3eweyqmxzxykND5lP1YqtwrDNXeCyUMg+mZ3DUd2UFELg5iO4rClXntJ2?=
 =?us-ascii?Q?NJFVwH3ZJcRXlXSBzsMB8ZMXFfx29NVCjfWYpITEhsMarswt75RqXkGT0bqB?=
 =?us-ascii?Q?Bx01g04ur5F4MB3km4br3KWeFLp+3RK2i2Csupenx95x8kR2kYPnArihUA71?=
 =?us-ascii?Q?dIhF4dI+HkVriIAcIYu1zpAXe2SFm8MCKo1g4G8E9jRHgi8pSceP2i2zioHr?=
 =?us-ascii?Q?uxWCcnLa8PCFyQlislYJbkjp09OZb0x5haBN8MStc/kx1/FzDpQp2klSOQqm?=
 =?us-ascii?Q?okr5F5SWlurLynbYTVh1L8MLCEu0sHTk4TrKOF6RTvnIw+57+xZZ9kL359ax?=
 =?us-ascii?Q?VP1hKIn+dK90xCxgRos2UlVG9A0K76FHLzeEWL3Rwb0ggRBEO0nhaxJzDojR?=
 =?us-ascii?Q?+Nr+iz9lVFm9GOupOQbQfnKDugyzFngpEfLemwUd8li86k+ilBamWKMJcPQu?=
 =?us-ascii?Q?5LHS8aPMXWiTS1Nu3fPxZZr4Kyu3mfsWtuuZufvEBjdEsg1HBm4I4vzYkspL?=
 =?us-ascii?Q?ofb4n9TvzKYiWD7NK3xrXnFu0aJUWlEF9USqMDQehUD8IaWbNpQFrXtHs9KA?=
 =?us-ascii?Q?CTEAjL50U/vgndbdpR2Qx6f1bUt4OUxPfCXieXYHqUCn/ruHVBTq16x064gn?=
 =?us-ascii?Q?OtoeNBvzzDVvRGH4jHOZZ2S3kiCTJFe4EkMQ9gKifi9Pdo3zhQSGucqWTlhO?=
 =?us-ascii?Q?XHbm3XOWkPkp3GS4IpYs9czBy7i8E0aC7i4UkAr9jfPVfIoKDWMr+QCBego6?=
 =?us-ascii?Q?JpDMsF1P+E75DkJz09O3Dc6ZFSKF8IIPkGiUvKbG9T35sP/3rVUUXDE/6863?=
 =?us-ascii?Q?5kOI1rOoFxnsVIV9meSChOe9lTJMwvQ/rsli9+4USQ+VkLMDqXfTNryJgJSC?=
 =?us-ascii?Q?WgMPFpFb6I15yMOgmCK2sQovACrGhZ6AjOHItTJRZvEGpqK/SeWVuk7LsWVK?=
 =?us-ascii?Q?4t10VpfEcdwc+VTGMoPIwPEFQxe027YWZhT2Z+qiEPRjRKb69sGXoxoNSQ8x?=
 =?us-ascii?Q?dmilCUt5R/xNh4UhyEj2cgO/o3TmuvZexCfGknBQjEKVYPN/k7yB19PPXJ95?=
 =?us-ascii?Q?l6JF9ESWBho1BGH6tWvoB4m0NuUt0uNq6zUzd67irNOkuYDhY8K2sBSlsFCV?=
 =?us-ascii?Q?y68LH0Hg9mmQbE54p1X7ygzJ8nyx6sE7JoVgyPLlQGFe6CgNFotaqMk3lZBj?=
 =?us-ascii?Q?qAP0ofkjhZ7l0Bpk3/w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GRH5GgHikxEdvN0lvb0lKAZn5uCpMhnBnN0s/3aRhVxKKmcpopuKfoUrRnay?=
 =?us-ascii?Q?2HODzPcSvcWs+/IyV/cGiuWLINljlvAczLLzTUtGaZ6l+4hZE6rq1ms77BRf?=
 =?us-ascii?Q?T4d6u0qd53RLHl38h6Aj+p35QT40j6ClCCdhad2lpq6qeuIbn54d2/PboTNO?=
 =?us-ascii?Q?hLtoa056y0IuW/qRQAdBi+mW84AhRtz/d5GzsWboJH/uwrGt+7XbJFfyEEU3?=
 =?us-ascii?Q?h2S8vYH7Oehznfq+urVK9OK3ArBFRzx3DJPFGqoDMmYHpAC2LCqAQCJlY+Ct?=
 =?us-ascii?Q?D2yfI8x6+Dn7d6hbuOSJcoaIQCGUzZ8dcCpNkwIKm9H+abI3KD6p2jtcwr4i?=
 =?us-ascii?Q?312zn5QhfCjGJU+rrRgYIc4UhOlQGUSHXEa9MhZwC3J1LmIAf/0lRxb5F24W?=
 =?us-ascii?Q?zDfMdPwAR72aXrQPo7rr0VcKFVR9s6vUeBQExdA4KXxUeuFeqffp/Ylv+rAc?=
 =?us-ascii?Q?E77u2Y/rNGptDX5iDnwF6rllR0M70w/emI4z+8TTAK3taE6+MXz/Ea8XszkE?=
 =?us-ascii?Q?iqAJHNxVjHuEaSJhgrMaNU8amtf88rfRqXjv0rz3JWqjgz5fKVmXFwozQCVd?=
 =?us-ascii?Q?UjNwpQsfCBpe5n4UT/wpmIlo+5KvtXu+P/xuR41EzmTPFAUuWlslsRJkWLDa?=
 =?us-ascii?Q?bFHzt8o0GAhdzHvQTh3Wr/tBD0PiXH09XIKg2JopYLI5LWdiVahQlrgwuXtS?=
 =?us-ascii?Q?gPiBKsTu6i6Vn2S4BVt/q6N2kTOndEInHEJpqXGuwrVF4J6hpJXz5uzph+R7?=
 =?us-ascii?Q?od2LW06YVDBlnkq/xC7wXgh/QrfYh99AReu9LKhSM7ikap9cbszEwqk0hOmx?=
 =?us-ascii?Q?jGHmriel7dRlIvpbz9dUsQqF+bxu3WGlR8N+yHwVpVxCOPFYGHmwcDGUibee?=
 =?us-ascii?Q?u5xXqVjE4HM4e+DtJukSy7MFR2ls+QPlUuYwQsCkzz1RWNA1bhWPqLq+M0Q+?=
 =?us-ascii?Q?cIPWXb/Gcc4t9a4qytw7iFyjQBECss/JAoFsNgikUyhJSDSlMSV3lOCJovpA?=
 =?us-ascii?Q?898sI0HeWK6cYUqAcemumlCq83o4jEWBCl0QxJAn/2esLVuR4mY0V1eX0Zr2?=
 =?us-ascii?Q?2/ow0+i8lUG8iXuGRb6v9jH/JpYgS8iWjNmbDaX4ruzEstf9n8wMvkauHisF?=
 =?us-ascii?Q?8l8AQkctOGzgKElJRMz0lF1f/Hef4zbq+rNOaqFO0Ie/ZeMjTswGVxUFJVfz?=
 =?us-ascii?Q?heCFfWJWIZxVVglC+f7Fxc7bAeQwj+oNg3IpNx9FcBRFfkKxYlv9bp0RRxRC?=
 =?us-ascii?Q?ri8uJkNRR1qxqgK4qaR5hnAWzt+2VL+RASeHsdmNM3aOs1SH5PCDsmbpNVPg?=
 =?us-ascii?Q?8es/sOjYLXABTzskmU7POSwVJl4EUZXjuHyCFbjBP+4L1rJ6yvnvlLJQSqOM?=
 =?us-ascii?Q?g0fmDgsxsMj30izT/T9LP0Dw0XfRigz9Kw/Lf50f83KarMEtnIZlPuK2PwBI?=
 =?us-ascii?Q?Hzx3iObb9GgxICQc/gIZ1/jOL1IOFx+jdShT27uTlXEnveeao9mA0fw0H9dr?=
 =?us-ascii?Q?OSL12ThxiC7sSZdddocJPPKauN9hVgysC20n6wSiL6Hq1vsqIXMjZb7LcXVk?=
 =?us-ascii?Q?nT473IEJgViSugllPzuF3YdvoPUnnvY1Xg/Bc6w9W29w7H79oIYPjTp7cDJe?=
 =?us-ascii?Q?G68Fq9u6cCdDviG4k4EXh6Zs2Afk8nAI8tcfer8PmG0Vmi2ni8V6fDvN9Sxv?=
 =?us-ascii?Q?yqeDYSN02I2YHU2P7y8KSwEfLLerO2xSjK8K9cAV/t8eSFOq4zcOloBIFxdp?=
 =?us-ascii?Q?X/MFasNqhd+gaFDfwtz0ti/7u9OuuSo=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8867635-ab10-45e7-e06d-08de69f71d9c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 05:25:20.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfGC+E1d6CIoo7pwk8+Tr7I6OGFVVRnCF8uamkGOJ9jUNmjvcCx9Y2T6N3mPohHvD/IucyJZ3Id+EeUvJJgRWreOMp0dXDzP8sSNGG3Neac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4695
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76993-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7139A12A655
X-Rspamd-Action: no action

In order to signal that filehandles on this export should be signed, add a
"sign_fh" export option.  Filehandle signing can help the server defend
against certain filehandle guessing attacks.

Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
NFSD uses this signal to append a MAC onto filehandles for that export.

While we're in here, tidy a few stray expflags to more closely align to the
export flag order.

Link: https://lore.kernel.org/linux-nfs/8C67F451-980D-4739-B044-F8562B2A8B74@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c                 | 5 +++--
 include/uapi/linux/nfsd/export.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad19..19c7a91c5373 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1349,13 +1349,14 @@ static struct flags {
 	{ NFSEXP_ASYNC, {"async", "sync"}},
 	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
 	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
+	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
+	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
 	{ NFSEXP_NOHIDE, {"nohide", ""}},
-	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
 	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
+	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_V4ROOT, {"v4root", ""}},
 	{ NFSEXP_PNFS, {"pnfs", ""}},
-	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
 	{ 0, {"", ""}}
 };
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index a73ca3703abb..de647cf166c3 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -34,7 +34,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS    0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 currently unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
@@ -55,7 +55,7 @@
 #define NFSEXP_PNFS		0x20000
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
-#define NFSEXP_ALLFLAGS		0x3FEFF
+#define NFSEXP_ALLFLAGS		0x3FFFF
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
-- 
2.50.1


