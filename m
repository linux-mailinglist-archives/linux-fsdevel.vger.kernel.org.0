Return-Path: <linux-fsdevel+bounces-44330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFCFA6772B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 16:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2970619A6973
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A608820E700;
	Tue, 18 Mar 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KhjnGd68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97320E334;
	Tue, 18 Mar 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309837; cv=fail; b=jhjI7Eq/aXvZlAK46ng2tAsyZ/65CBbMsjsRFRtWTwGDQ0CXCdaq7KLNwA+hzV/lXvQENOywJew9NBIYby1I3OthBGFKpFdPxuIdo+16cJkniZfcYrobnNkq1YmgeoXtmK8oZavE2GRvRp935wUM5SEpg48G49nRqz9wCcQvqvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309837; c=relaxed/simple;
	bh=lGbLXHHwbyFbDykcv10g5TktrkR1FPqHwa2OfyCuuG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EdEXslFU94xOkeZyNT0tx6Dy3Zx5PxRWEgEcMw4jRrKy6ie6PEmSPslOla3Ea8EUJ/xAwwXZ/NOnU9I4AAFJTfwO+UvYsLz6pOZj5CvG51lxvx4e1C5PQqNJzrSibUeiIDsTFHvIBzKQT2D/GwuGNbANNdpJ8MfY+Vd19kyuQl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KhjnGd68; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su8FDxaAiuJCXgAo1Bs58S/KdAVOSlVVqgBlxeEqYUSRTz10h+NRozl9vxLsKsiztp2SImJOG2Jv5gK1vKXpyMvu0KoSji8ZIcmLg/+E/drGigkDcl+uUmtVKPkxnjJTIqHfmj7mlkJvnJlX5GjvrQ7W6TALuMaPxpah/3CTKdZ8v/LEPlYxaLXbzMD1UjSbB65N2hRBsn/oDNxtDJNiIezApITw6jxMPnO6Cexg73VNI8qYaBeHBJbwlBwNGjmDJP09onj1k61lUnphgHzoNIQeBr8SPBRIUAG7JWsvbxg9uCdSSb68VBfF1vuFzbFWPXbUmGV5Hvl7Uv/HhYA08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogcfrtzzt29VDumlXK3kHrxVLVRlWSU7xHD/Bo/IXPI=;
 b=FkUPKz1RAk4fkop3IbCdCzKKszbfJBG2cMCypR6RTytQZ/ezGSkIoMZWo6o7ZRscKCtBzX+LfIYPvRK+gwSg/TgZyy8l80q1gAQbjPMrDeYhVvU7B4N7xKWn7HGtFzCf+UWWYMTAyMLmeF2O3BL/YAWbnMhsDevJx6vUt8/dUJCSpHF+MB25kg2xeVqmOx58SNRVsSCI2qwNns5VlLigI5W5R58XUvXjmjsVdlatlt8UuXk9ImCs2tHUvUV/T6hM7/ENXjHa0jTZk3VIhRl/C0mm9EwhprFujjIeS/Jo7Hib12b/ucx5NsxAiVoqeBuVc4qYBDuozti/71fuotQiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogcfrtzzt29VDumlXK3kHrxVLVRlWSU7xHD/Bo/IXPI=;
 b=KhjnGd68SNYatVO045NCJLW95kvTCQDnoUglcFcNLTyYVgBgPhlu5vOo19WAW6L+pnHs5JsCenNEB2fYbTwZX//sANclFFnRMFHCWU5Tnf/kbcnpjHPo0wZwWqMKGwcEzExfqxgCXHDjyrNkREXwwZualcPRUQGNuxdSQ/mU4imfmFXA+9n4Jrq7Y+J3MXpcqiWI4ilLwDMpJaoutQpeGvu4ZZe7rqJQuphgb19PaL0/wL1zugm3YZ97B1Xd3K3Zjnwl4/jXajM5i/NvlYI/dLtuYM93hwVlqnLkW2yjUMc2rz9J81zUZRjrppTkBMKa79TpXlgPiXmiDap9xcuaHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:57:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 14:57:08 +0000
Date: Tue, 18 Mar 2025 11:57:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw2@infradead.org>,
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <tatashin@google.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
Message-ID: <20250318145707.GX9311@nvidia.com>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
 <mafs0ikokidqz.fsf@amazon.de>
 <20250309-unerwartet-alufolie-96aae4d20e38@brauner>
 <20250317165905.GN9311@nvidia.com>
 <20250318-toppen-elfmal-968565e93e69@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-toppen-elfmal-968565e93e69@brauner>
X-ClientProxiedBy: BN9PR03CA0940.namprd03.prod.outlook.com
 (2603:10b6:408:108::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 229f80aa-c68c-4515-864e-08dd662d27af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CWxsKH2xpePXRMFf/RLQEQrQVEZTB4/PiPsBxDeYKZF04qOvE3oiGF3l2MGg?=
 =?us-ascii?Q?8zxCRx8XeXKgT/Jb/zKopRU6dbz64AvUC75VpJDIpACJqrZT+3MsvULNNH63?=
 =?us-ascii?Q?NLHnorgQxhuHieJNh0sKGGDvndg+RFA1kR5+xtZ/WYQqRX6NISzGWlRDJArZ?=
 =?us-ascii?Q?vzRtvXDk9QKZO+BkRRJQVYQvBDjq9j+p87yxpAxyZZ0BGNzFJblBzqG8hgti?=
 =?us-ascii?Q?RxcBxug2XVCAEBUYYBiIdzZkNZNCuDpC+Lwi50tp1VhMgg9s3TFrcPMAso1u?=
 =?us-ascii?Q?W0SEzH0/RrfvfKloU0Z00Vp9DcKYjO2GZjZ+Ji89cpPqMfhLT49/k3LQ9iej?=
 =?us-ascii?Q?/x89p7QUjL43T0D9cm/a8Ut/qiMGMvD7idM2TB84gQtLKOT8j54jufwWU7eB?=
 =?us-ascii?Q?hJ9O5V7dKT3WNSh/Oe0MTkGapy5pdSAd1wPWfMlqW08GfGtBRFdne5y2ihT8?=
 =?us-ascii?Q?hcWheV2i1dBdysAbg6TAhvjUYpVN51GtXnDFEz9pbUs71Jgqsl2hOrmS7APG?=
 =?us-ascii?Q?h/XOLEdvWy0qHM+zwcH6aJN/kxnr4P6zM7FQiRjw5On1Wop/PVHVucEfIeiF?=
 =?us-ascii?Q?4VItRbNP9WhGrv1f24uCxsqdEeBrFSkBE2sxvuJ0nLLvBALWfsAa1VTkkTEL?=
 =?us-ascii?Q?xnwblSNUTrb/2yl+R7x0jzL016XohvqHT/4gArgU1EMqrdprhmUGE+ZeMQqU?=
 =?us-ascii?Q?yH2lSjxP+k8knzutQhXQ3PtDwzpqXVXZgTW4Bvgvoxb1xjzqAfATsLxtTU8K?=
 =?us-ascii?Q?/pi26T/S9qjWa2PmInJONtUXOp3KzBUTj5260P36XQvaQjCM/1WyW2Iqf46u?=
 =?us-ascii?Q?Tm4aYqKA3sz23cCoQSn8mUiqwwzG4L42jQnfmGtkKghafeoGRi6R7ZiRaVKq?=
 =?us-ascii?Q?ovZSZRRv0yra+qZAwcFL0OkSpKMT4K5s8NlPT2searCugWvXcLMxfofBg1FS?=
 =?us-ascii?Q?ARqzxAriVYRCSyXRgu1NELYcsmONqCyXobBXT/v3SzboXwztREmF4exTjIHZ?=
 =?us-ascii?Q?BCJipFb+pWzyL2T2aQcAxFEhuD5HTFxE2sWq8Y9avewz4L2vDKVq/LAlH2L+?=
 =?us-ascii?Q?i7DLThCeFZTeNIT+dKWmEmv3LoKEzEUfCAWKiD702WZ/NCGBMdpIYp4nC4WZ?=
 =?us-ascii?Q?bUqPQcCNSR1/cDLq4X2Co5soasgCzHhdbyKtcxQ93eSV/WhRZnjG79lR9gSq?=
 =?us-ascii?Q?bYythG945rEPWiTKAZLFfASuncyeCMdtdi0HsMPP86u8ZkfsQ31eSU9+SfHH?=
 =?us-ascii?Q?3VMrDuOyHwp+90XN3zf5jXCcR32p3YHd58PKQBfFzEXveLPX/XtKuLjuGgyA?=
 =?us-ascii?Q?Ps9OKodPRY88zMHvf2s5Xlk7CF7sMDkjIZrDNPM6JwKNMxwL3EuWyDT7Jl6e?=
 =?us-ascii?Q?R6/Ut0q4bDrUTTscURsQChCi3w72?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKuDdmNMohkCWe8R1+7/2utP2vzINzxaDdFhWD1wAKJYuHiK2f0EdEFjCOzP?=
 =?us-ascii?Q?BBph6Wd905ioJOI0KaJtgBHP3tKQerAi0CapPRkwbc2DCcNUGlhbjjQ0jB8W?=
 =?us-ascii?Q?QuwiFgfLkRzzNG+syWGzZ15QMPk8g+SaCxm/rlc3jbf4fwbE3+9sGLTbfND5?=
 =?us-ascii?Q?5ya/LIfephbPX5IIXwcEKDFumL7jq9DOtitic8OnurLeCIWK5fSxeOc/inMZ?=
 =?us-ascii?Q?sCqD9DQf5lkO8YMkVMsUbcFmacaLejpnxRy7TUDbQpulfTxBNHUtr3D0Dva1?=
 =?us-ascii?Q?CMZDMHqoevFJxMOCifZ7IJVl/0D5UsuQdScTUuSK8rSqHsMPjBDpU1bA8sf2?=
 =?us-ascii?Q?j5kIwJPZzDL4yZy8MnUAaUBA6zp5P6ndaaUrmRVrZUeesH5vSLqzURS95fMM?=
 =?us-ascii?Q?2Q7sxFKJc6NwWq9Pzbg2qm9hlsjbpf4RJszzjMySupro5OlVcYhhKTXszEs1?=
 =?us-ascii?Q?XjkrSmi/968sfHTcfkHhmArd7NUp4T2Vhx1bJSkmqNg40DWaSljHt0MapK8M?=
 =?us-ascii?Q?HAgZhVcvHgmBllC1D8LWbMvmqS+uvCmmiVHOBxHy6EtEWlEMb+1L0A4NQgIf?=
 =?us-ascii?Q?TfYAXuWlm+NBKpoSTH1jN9yZifk2ty7AdXoff9h27CZz4kIahlm54EoF2lmZ?=
 =?us-ascii?Q?W3ZkQ02RV03uzWfBwWPasFhllnJmn2SfWOatf3cK8zLDpS70EUqqY2sN3fti?=
 =?us-ascii?Q?ssjURY+qU5/ZBUIGX+GSttomcKG1N+wvLMh0ZAR+uJEarlwwJAjiY9Z3+kCY?=
 =?us-ascii?Q?Le0q4AQInJwJP/k5iG8SGd2/g93Uq768fXpkismC6sViUMvfAiVKqaNoKJZy?=
 =?us-ascii?Q?Uepcu3DEYosqaIXBwPB38FKlT8liqGWLWYvBWfS0/hIlVk6A5yrLzpuvP7Kf?=
 =?us-ascii?Q?ZqstB/Q2V5djo7E2bHcM2Nj1kCWAdo2ghHXThkwuFwKQyCwHGj0OgwcZwcQC?=
 =?us-ascii?Q?Rk7zMjQxRaXB48QeJgU8E+KdloA5n5/v1CROQaluHYcSbgHO192XFLA826h1?=
 =?us-ascii?Q?5N7KqlvQlZxV70fYNVZeabvAfnvzLDbwrn0cmX1DKLAQ/lS0LwYcr6EBzL9H?=
 =?us-ascii?Q?fS05/9XqFbou/wNQ2AsZat6QWBF1Z0zOEZkXly/QYJ1OgyzcWtl52s3lrAwp?=
 =?us-ascii?Q?Sh0bbSKL+s1FgA8hsjf26q+cpVKgDK+Bh6+cTHVmtAan/C5kUwSvDNm8VXqK?=
 =?us-ascii?Q?xQzmbURfhQ+o9X2sG4JtwoEpA89UhwvZ0A9W+K9Yx2Ibc7xe08UxT0cgC/fo?=
 =?us-ascii?Q?DXS4xHO2vAgk3/NguYQWLZpOe8e+BAtAt5OwGzLWVefO6o4TXwzrdVpgJOEa?=
 =?us-ascii?Q?KZ/Dl7M3lPNIOQopxSTcm6fhoEa7DDa8paJrIHx7CtGqj+WGJQZqobrl1dQN?=
 =?us-ascii?Q?YLf1xb4eWmMBNjceasktTPHmSDKaMcpd9KZMNbeB0TeSArOoraWnLfFYazSh?=
 =?us-ascii?Q?gGWyq8VNBjpzcGdKrBbdSN8C/6cz36y3OJoTyi2goS52G0zFT5oOky1BKGKd?=
 =?us-ascii?Q?PXS39Ft9EjULusbME7MU0d2Ec2ygdp2Mmmvbrb5FxlZFFlOPFpeyWfITz0Iq?=
 =?us-ascii?Q?FNuOeO4zYfu2VyPHwVysC+iiAPWfO9A/O4isHl4W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229f80aa-c68c-4515-864e-08dd662d27af
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:57:08.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoEjJK3Vrvt3vnYAMw9rn7nyc1ikH2zGSjfAgx8SR/00OU1+9DTzZ7vTFdloNfhi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285

On Tue, Mar 18, 2025 at 03:25:25PM +0100, Christian Brauner wrote:

> > It is not really a stash, it is not keeping files, it is hardwired to
> 
> Right now as written it is keeping references to files in these fdboxes
> and thus functioning both as a crippled high-privileged fdstore and a
> serialization mechanism. 

I think Pratyush went a bit overboard on that, I can see it is useful
for testing, but really the kho control FD should be in either
serializing or deserializing mode and it should not really act as an
FD store.

However, edge case handling makes this a bit complicated. 

Once a FD is submitted to be serialized that FD has to be frozen and
can't be allowed to change anymore.

If the kexec process aborts then we need to unwind all of this stuff
and unfreeze all the FDs.

It sure would be nice if the freezing process could be managed
generically somehow.

One option for freezing would have the kernel enforce that userspace
has closed and idled the FD everywhere (eg check the struct file
refcount == 1). If userspace doesn't have access to the FD then it is
effectively frozen.

In this case the error path would need to bring the FD back out of the
fdbox.

Jason

