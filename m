Return-Path: <linux-fsdevel+bounces-56746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91368B1B378
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C350622A31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6722727E7;
	Tue,  5 Aug 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZpW3DA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AF1DFFD;
	Tue,  5 Aug 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397069; cv=fail; b=VEivSVFjqcoXt/nUFKam6V+aupbEcKhcbvzI/XaOVBcVHMu2+jVJY/GcAM/5VVu7W9PjgNnXWsECvKZ2hmAlf4AzcNJl3AEbY9QYm/0IsWL4FJM4g61Y8+gD3icpT49u/yazXXbP6k7fQyjAXpTsCCi4ehz4M40RoIMVFfkFsAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397069; c=relaxed/simple;
	bh=m9LoHsyRKCTJwu+pYgyWSL1EvBTNrLlXB8tDb7dsqMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E5rc5WVBdTw7oYlNtIy2GONMMuMEujCTXNGPH6mNXEuuLSiZDMpmP42eAq12FaaKvHbhwkMZM71kjEXQvZ8eSdGowx4qtDS9oYVbT0jrc2QG6AB4vhr8DzIV8VD03XmLOhAQeVruxBY27464BVmoCTefazChZ/EeSlMufWvenAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AZpW3DA9; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/YUy1IfgoNlj6J5H8Izaps/oWRqsDL9DWdOBIvFibxeRvzFpad6+BQTRo8B7m0/JMKGu8uyGyIKlyZfOxDAfLytESCEPM4wG7KiZmlA+X/35txksR9O8xOdIcxNSeo+YUS8O2vKlONH/P69UrkyMFCEaIWXDDEKkMJX4Odr1Avy57SjKrNnhacA8KQfuvb5BhY2nOXPR+psSOjA5ZM7Zt2RRwCqu/EX7mcS7UMNv0CBnuIpyZr/cxYE41NNmVBXQNhqJwRKk+Sta7BYQbFZ0MM7gguSkOkSIJWuLdAg4Mp1RmTN4iPxZs9DQbAcZB5hKl1v3Yz40yg2YdhBJ+d2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvP4bIBVAuUNv2mgt5gOl3Oh9nTcUgDTtkNL8NMoh+A=;
 b=MdApe8MO8GxUiBJ/+bsjj1wM4g7Fm8FMR20eGjRSrQS71xCbHHK/fcRRNnHxF2fUJIiB99N4IUcHIJ5ZWbDhRrSEmM3fuU7PYSDlWLBvkweIkpP3HGKse6HO6zTzcXKAEVWrUb0OUpXb1uNeixeryGnvkdKIrFNz4KzAGhh4no0oD1QWQYl9Z6DkZ8sQcUkPhTax/SI9X2vp+DgP8eHC1IZViSNSPaN8VEKj6VHXLw1WN2PP5N+TQ0sLKTWIOsRmR+a/3ff2vyMAOIBNK4VYUQHJzzQvAcwW8BCh47BGh//mk7PxkV0HZFJ4Kv4QU7SkPVcg/6yCRpYz4mKtSetiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvP4bIBVAuUNv2mgt5gOl3Oh9nTcUgDTtkNL8NMoh+A=;
 b=AZpW3DA99tMl92XIyTMEMvsT5VMDB7Tfm/OC7uRgwHXt+0EUueIlpUCIuU6TBJf0ITFUYIwgrC1kZx2m84cBhWGtucKNGur7KTNDNJEfeo+sNVzXutzchmwljMWE5qD1UnVb9ZtaWfE7XV6UhMoCO7MwiLWjX5UkjKPSu7j0tNJhPdBh4NwBOv2HuvpPfoOFlA8mj0PoFqrFJU4uLp6PWyLx/J1aVVqQxw59BE8M67Qx4aasjAHL2+Xp4uTTmMhO9eNv68mG/+3ZDQ9Ft2lrj3sXWg+PMyf2/q63CSCbtXebz+Oa3w6AnFYIIv+U7WtJOyi66dhySamcFwW7NeVAww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 12:31:04 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%7]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 12:31:04 +0000
Date: Tue, 5 Aug 2025 09:31:03 -0300
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
Subject: Re: [PATCH v2 10/32] liveupdate: luo_core: Live Update Orchestrator
Message-ID: <20250805123103.GH184255@nvidia.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-11-pasha.tatashin@soleen.com>
 <20250729172812.GP36037@nvidia.com>
 <CA+CK2bCrfVef_sFWCQpdwe9N_go8F_pU4O-w+XBJZ6yEuXRj9g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCrfVef_sFWCQpdwe9N_go8F_pU4O-w+XBJZ6yEuXRj9g@mail.gmail.com>
X-ClientProxiedBy: YT4P288CA0067.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::27) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2541a4-eeca-41dc-9a35-08ddd41bf1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nHZDFPaV0GGGWEgTO5dZqu5/sRb5Js2BqsVOwmumKjZ1a+hmrARLGLb/Bp5w?=
 =?us-ascii?Q?BdZwURqlZyIrHV3Yyhv195reUovItQlYg0fFPDI/12pzioLoqSyes5UDLNqJ?=
 =?us-ascii?Q?Sz7P94INJSWzoRsg6fNuJW3VY/RnRkhtzOn1DoQBSwZ7oUDhT/rOwiTYDKg2?=
 =?us-ascii?Q?n5yMadwdRKM7VYPdNZvU0p975HcOSC9z2WkoG9aTnKEgeveG/E907jDfkHoa?=
 =?us-ascii?Q?HTrP22NrMKnh+a7jwbmDwDQLZ8sFZLmSAb7e1DJAroLGWlSp6f6NeUPNihm+?=
 =?us-ascii?Q?TA3c1xVYsYgPJwcXxFYz+6c9LHuMz/GyvWH9ceUVGI5pnFf9xpDSahMppyk2?=
 =?us-ascii?Q?0spD0DuM5b707IC0u4APwnYaa9mpUtnXK9liArg5lSg6Sl+sF0fAk+Ue2vM9?=
 =?us-ascii?Q?f8BfPDU2zTx3GRN5AaOhEX4d2ni3FpjnbQ0bK3mQ9szvGFPlmHAFmI9zuoAs?=
 =?us-ascii?Q?EE6OoFPOuRFSLpq2Ur8DMSRpXwsdOI9Karc/MSFAo+HZ83iXxMLxEMvafReI?=
 =?us-ascii?Q?xB1D63WQoNO3T9Yx/JpS0xV1kdfWc+p45ogM5cor43lb0xVYOdbSLK7kBLCW?=
 =?us-ascii?Q?ISZzs3/2wUdWYkjt3zDAnT5ZGDE30Wouc5DH3gQjuj5e1ZlqCq6vLUb5Iucx?=
 =?us-ascii?Q?A+xDzgoQM+WR+TubLwQjHStiWwZ6W89vDm8P7WxzSCOStmop1XmgtAp998xG?=
 =?us-ascii?Q?468knpUSUnx48uRub+CU3RVZU3+H/B71/QSmoUFkx8JosaAjfYK1nFbv8cpz?=
 =?us-ascii?Q?SAE3q2UaRiBYpQNEAQtO+1GPq4D0HtlEVsxCY/Lj+9VM7dUqDRS9PZ5H9u4M?=
 =?us-ascii?Q?OY5SDyFLGAf8ke7PAocoaZlBbVHM4n7s3Gnj6LFNjUWG+F8JgVWGB9yT+I9P?=
 =?us-ascii?Q?Gs0/F8J2wi+fSIbxXpf+cb9FLHYKaYdRJyWrUAjWkvztY6cLZYRj3P7Ql5+K?=
 =?us-ascii?Q?2ePD7MGzD2JEFs/YQDbMhOna8VsQ7zfL8W+QeMeB66DB8lx5k/PkoCDsx32o?=
 =?us-ascii?Q?9LviapwCl9HF3RchqGctj4cUGtnBy1bUZ0JSjEt2X2856YFGw2+nbXsOv69D?=
 =?us-ascii?Q?boQIbsfeZXM+pjbcDLNEPODADfdAbQglhpozK6GTo3pZ+iysxXprt378mq28?=
 =?us-ascii?Q?Pk2o2oV9gwxKe0s06bHXH3BqVfzRmEFKBy/AoptEAdmTTKYB+8DRc6U3AWYX?=
 =?us-ascii?Q?WENxEy2b2rxSLlFXUqqEYJJG1TAh3va41TFGnzMq9fcwLmbLGCdo9/CI5NSz?=
 =?us-ascii?Q?xFB/yXfJeWnbSamti7H8do1KJHEO/qAYua2Z0YfFWbsA+DRIOtlmW7lX19YN?=
 =?us-ascii?Q?jM/W4cyJYp6Mq6hvAPeZNF+G80v2nL3wSdu7REY/vn8HkPpAcUlsT7R5wB4W?=
 =?us-ascii?Q?vBBifzuRZvFskPh9+ogSWECzt8zxh/+uqctmwa+JYLcs+pyPnMWstRaCjnZD?=
 =?us-ascii?Q?KqvwqVQEwPg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HE9Qfw8uopNHKJGMfAqTAvSHR9hO0eiAl9IfI+2ElGY64y32a59T8/V2pJW0?=
 =?us-ascii?Q?w7+Fyde1DvM1i5onHWt4cJPr2vSX1mBbvmRbqHVgWUyLj5J//KUh7z2gqkY7?=
 =?us-ascii?Q?OaLANX1HmPqwAQxFDQnOzi01Ne6QFN8B+JeleQxAWsDEcolP2g9utlraCxun?=
 =?us-ascii?Q?yjlYMSZ+Z3MHxvtzegxeVNa9Cv7xA3DUpe0uTpGcP8g1+lSXDaTH8caE5wjg?=
 =?us-ascii?Q?RbzHyREJeaxA03NZ/jmBBTp7KhE0mhmPBSwbHMO7fpH1wAnpLqzU7S6NV7KY?=
 =?us-ascii?Q?pQKak6rMvAa4KeNLT0/fI+cX1vv+BCKaUQguk1fwS8w8ihVYBzJ3FCvNfE/d?=
 =?us-ascii?Q?d3i3lni9829mUlUzAFPd6z+cYGnjCM5laG8PUQprsqAbg/T10sji6QK0CvpO?=
 =?us-ascii?Q?2VgTYmlNZI2pcQEzNhAhVwJmLyZjEO2XXdmn7QfZ0xv2OsQlRM/MUUjxaZPk?=
 =?us-ascii?Q?4G8Q9nENxLC2MVCP8h6C2lAOuvDoebzls3tVVcDTcQK+pMIllXf8sCODQcw3?=
 =?us-ascii?Q?xEyeZpmVZsCwTfsjFphpZxcdrrBzdQvZBM5DEHpecv7kCmqcKqUEpvWy9Bfw?=
 =?us-ascii?Q?4i77GOubvyLBrKi6v4sBgFrrJaufvUvlvUaEO3VF8UYQr1MLxgPVIDIkJMQ/?=
 =?us-ascii?Q?4UlaoqgpLJ7Ewfhiej7i14TdIjlcu8rXSgRiCjXza+3BWyMF0Z4tYjS0FP33?=
 =?us-ascii?Q?n83nSPuDkooU6lUtfBjiG3+fniTezR2kqJu78ClBQZWu9lXTV+jOxP42ef4I?=
 =?us-ascii?Q?0WEBmggMTDdnU+pQ50SsVO0og04zyuiOmrVGdXRAykHWX77MRHXR0GoH3RZ8?=
 =?us-ascii?Q?WyFz/JqqFVUKBlTUhPAEE+mzmyllX8oMn2E9GrTVKMAS/bPCQ8yW3jGP6btj?=
 =?us-ascii?Q?1ugv/zEaCQ6+8uGrbQXiV9bWr6Gwd/AJKDjxwkMdNBjFMkRGQ9DmuwCt+1P5?=
 =?us-ascii?Q?Sba1a9n0jYMvv+uzWfRfWSF3V48/7IPcsjWy7/w3MlsJ5nt+QjIaloWNTSh1?=
 =?us-ascii?Q?2hxXAfKYjfDpPkKc5dmL/cb0pzXTFwTtr2rh3I7ILhjSRvQafy+12pSJ1aJR?=
 =?us-ascii?Q?T0f8XxNrm0cxBxmmDHMNGI/RWCRP4ILu5oYd29Fb8QxXO8dq9oRrqjVympUN?=
 =?us-ascii?Q?DyQgyIajvdHw1l37PZ+taXpTHIBm8MxzUV3TfebePRgXLmHaVPdg0jxqgnfX?=
 =?us-ascii?Q?R4BzBc8H3iAHHoE2JR3QdQsPqtFVvqzP5lqYIBd/2a+Qvpr+B/cR0ECxmQKa?=
 =?us-ascii?Q?oYoOYRNbDao9/1fdKrYnogUFukIYrW0Xb+AupzD6hp+V8s1e9+9EXX5/BHL6?=
 =?us-ascii?Q?KiRHZnq0YdTKOLTwrmiOjpsPxJio/PzlQTaXeFCNrEzOu/BehF4s/kS9/P1Q?=
 =?us-ascii?Q?v4LKgUR+TfvOqowBeNFNa3Bpqu0SUuwdY/r4QGhpuDX7QhQUyElKyhcKjVpA?=
 =?us-ascii?Q?blaFDRVA3LM6LgngNLhQvbu0s5bf8qo8q03J38g31uIbW0MNXPE+d9+Oi1Xf?=
 =?us-ascii?Q?6WfjrWoFZW96D06O2/eKghH3NcBxxVj1x/yj1zXNDdyybGVrC2EdqoJ+kwpk?=
 =?us-ascii?Q?HTH8zNxauvm2uwHPJcU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2541a4-eeca-41dc-9a35-08ddd41bf1f1
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 12:31:04.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKdq7ZMqiaB4q9V4vqPlfywLuwP3c7MVaGdSnGvcIknr9oUiAZiPtSA2RzBemedC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276

On Sun, Aug 03, 2025 at 09:11:20PM -0400, Pasha Tatashin wrote:

> Having a global state is necessary for performance optimizations. This
> is similar to why we export the state to userspace via sysfs: it
> allows other subsystems to behave differently during a
> performance-optimized live update versus a normal boot.
 
> For example, in our code base we have a driver that doesn't
> participate in the live update itself (it has no state to preserve).
> However, during boot, it checks this global state. If it's a live
> update boot, the driver skips certain steps, like loading firmware, to
> accelerate the overall boot time.

TBH, I'm against this. Give the driver a 0 byte state if it wants to
behave differently during live update. We should not be making
implicit things like this.

Plus the usual complaining about building core kernel infrastructure
around weird out of tree drivers.

If userspace wants a device to participate in live update, even just
"optimizations", then it has to opt in.

Frankly, this driver has no idea what the prior kernel did, and by
"optimizing" I think you are actually assuming that the prior kernel
had it bound to a normal kernel driver that left it in some
predictable configuration.

Vs say bound to VFIO and completely messed up.

So this should be represented by a LUO serialization that says "the
prior kernel left this device in well defined state X" even if it
takes 0 bytes to describe that state.

So no globals, there should be a way for a driver to tell if it is
participating in LUO, but not some global 'is luo' boot fla.g

> > +       ret = liveupdate_register_subsystem(&luo_file_subsys);
> > +       if (ret) {
> > +               pr_warn("Failed to register luo_file subsystem [%d]\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       if (liveupdate_state_updated()) {
> >
> > Thats going to be a standard pattern - I would expect that
> > liveupdate_register_subsystem() would do the check for updated and
> > then arrange to call back something like
> > liveupdate_subsystem.ops.post_update()
> >
> > And then post_update() would get the info that is currently under
> > liveupdate_get_subsystem_data() as arguments instead of having to make
> > more functions calls.
> >
> > Maybe even the fdt_node_check_compatible() can be hoisted.
> >
> > That would remove a bunch more liveupdate_state_updated() calls.
> 
> That's a good suggestion for a potential refactor. For now, the
> state-check call is inexpensive and is not in a performance-critical
> path. We can certainly implement this optimization later if it becomes
> necessary.

It is not an optimization, it is having a proper logical code
structure that doesn't rely on globals. I'm strongly against
sprinkling globals everywhere in the code when there are simple
logical APIs that entirely avoid it.

When I looked at where there were globals I didn't find any good
justifications, just thinks like this that are poor API design.

Jason

