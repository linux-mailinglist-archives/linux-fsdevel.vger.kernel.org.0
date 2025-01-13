Return-Path: <linux-fsdevel+bounces-38994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBC7A0AD11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 02:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFC83A6D41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 01:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3581B95B;
	Mon, 13 Jan 2025 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GsC8nOOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1AFECF;
	Mon, 13 Jan 2025 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736730338; cv=fail; b=TnZjdlqTn6qz/PqGTmtggKKYXWYurgwFEr8ayP/vcJ+erLAKxI4L6vbEIB0bXhbdV9qEgfNCj13zkoCNpi2ubB0rrNqLioBZi9ErykWJ5GaRy45+vj6MWjlGdh0N7ks1BYXwVYKY363mlWi8ZXOSbNlmwyw2v5DDzBV5/UW2F4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736730338; c=relaxed/simple;
	bh=9xE6TZfHIDAsSzw3QLwEul5hmu2kbXlH2J+OY+xDcjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k1jDX671X+W7Q3N88uZHA5qPid6cJ0XAOklpWDRzphdLumi3wsGQdeYd8Pk7Mz3kfKkJoNNWtN34c1HXddpcR0RTvwP11XQOAKRcMzESRcrajel4rl0OsycGnBaOw17RuclBuCmu89ZmAoa/lhH0O4ytphNYQitv6bUhEm1KfNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GsC8nOOt; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kC8Qo366eNWwJ/mW8rEdjE6ax5jMEqr5FKI+vvj3W0MIAc8NdhA5jq6g1cjoSVtZZ8TC7/4MaoJSVYLhFeIFpOR8XiOy1tRBdvArRYe7hll/U/03853QOKN7TPJFKTPHEBuGrRYNW4sa/s0il7t/NH5Ogju5ZVU5PL6plHqSJ00Isc66yXs/L2fDCbV+KHNnpw3nwAD/D5mIMSo1WcTLiWVm/GiGf4c/6Vu9eWjjrSAFH+jVLhpnkRlxDefTsAqgFBWsyp5r7V1ENGFKtA1WFjHyIi8vUP1KOktjxh1bDnPQ7pYyLD7PUPP/egOpi+fCA9dILyEJWxFOaQjfE4BETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1Z85zyKvqz+Ebx4QcbZLf4AtXv1OI6ervXd9n6bMQY=;
 b=PRWeGEnupjXuiG5ve+18M9b0G8+YWD1ZXL1w64R7ix2BL1Vfcq9O5oj3QvifAkhh4fxdjmAYmVnBrOSt3/jVIoNo+48Vxg8MjqsSazweblMK4JtprGhgcfFnH4+HePTCS107XWFhltcRg5yA1SojqsF9s+6eiI/YhjTeA8lm8rdpnUrMyY/P6Vnsbxjs4/lj70i/6l7+z4Z5FzO2MWLH3jUwwCWEOAlyr8ndpz4qCD3AUidHyY85m4Wsc36EhVnrIJ/SvMqAoeE6bfabsCS53SeHH5NTuAqVh4z33QeFgVTZvSgHCsyeNgfMqINqPTq0KKzppdvEE7LJGq8asj+F9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1Z85zyKvqz+Ebx4QcbZLf4AtXv1OI6ervXd9n6bMQY=;
 b=GsC8nOOtBckeYkbSTH62LzQvwNPrqGmBZSpxm0d0I0pUAnuarPXaEql8U8C5syXFbtdJpTcofIOGkM9lxuAFGDsbIfnfyPen17YRof+1ooUTCXl2DZNhuPaCWUVU94fmyTiOB4UZpTguVdI3LqdvhDrTM7f3yPaMEtzICB8S13Va9MStwCJJ5Zkq8k7Tllm9A8Og5oHNAHvP3/eq2f65gucX4SXRmYJyrnVH2becrrYNI5okwOEb+i+T3bXmftxMJinRKfl6Zfufi9UyA7vXwKG2+nz7tPXAJEOr6mZ/boFj443NRyrXn8FHA24FAsmDYj7E60lBkwRlM04TBdYUqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.17; Mon, 13 Jan 2025 01:05:32 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 01:05:32 +0000
Date: Mon, 13 Jan 2025 12:05:24 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 00/26] fs/dax: Fix ZONE_DEVICE page reference counts
Message-ID: <usnx4lnlazgeuvyqd5tcelb4umob4xxkvzhbv7kx2d257u5wej@bxx6ahfma5bf>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <6780c6d43d73e_2aff42943b@dwillia2-xfh.jf.intel.com.notmuch>
 <20250110173048.5565901e0fec24556325bd18@linux-foundation.org>
 <6781e71d986e7_2aff4294d4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6781e71d986e7_2aff4294d4@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SYBPR01CA0192.ausprd01.prod.outlook.com
 (2603:10c6:10:52::36) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: edbc7986-5861-45a6-c000-08dd336e60aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UGjf0ZAOOCR+h/tMKgb3A28rwBdtdBksqfqrkERqc+iBW7VkOxpdqkUC6Vdj?=
 =?us-ascii?Q?1q2T8WTLDd6ZKzAJGi3y6iIX0r7h5akr9PsfEGRb98WKxYkbI0mQthbUxt/m?=
 =?us-ascii?Q?vBUOVBvn7lE04e8kQgjaM6MVBwXngEOzPgNM8fNPksBgmt8HMLuJ6ezgCDyU?=
 =?us-ascii?Q?AmaoNgXtnmAeaMmmadb3W44Cw8ccHkTmpvfCunS7naUEvoY+uXebgFL2/hII?=
 =?us-ascii?Q?iXF8tqFbqZon5zvz2KTQYJd/LpIRgHO1GeVRyntuQhSLlAuu+SrR0PLBvBVV?=
 =?us-ascii?Q?X5ahne3EIF+Rq5IJMkwfFiqkgzKmhosFYZNf0/vXPJI22ptSYqsNLJFK4dKn?=
 =?us-ascii?Q?/9U3PwN8d5+pxItt/upeye8ImN+bV9j5LyKBjSbdS/quvY8+GSGuwDMrL1Z0?=
 =?us-ascii?Q?CNTyguypmAT1d6oZKTzjSpyI6R+r7cisoWVhIR23c55x1a9vE2xtE8UQbKsS?=
 =?us-ascii?Q?8P49l3p3KrjJdZk1nI/tp69cgwwNez92Nq+sTZO0KMQahdW7ttvsDFo4/aTN?=
 =?us-ascii?Q?bCSjIQtHTUo6Ym0+mUeS8L+36JnLe+ThuxpV76dnUnkkj4bdADGEjtpIzlD9?=
 =?us-ascii?Q?1Nz/ivI5D+JNjTipe3CNw1SL+KN0WVUQ/NuLOEAlsVSaQ577hJOHHNzmhJwK?=
 =?us-ascii?Q?5s36VVy1dQEV31kKQLpRC5fTmoTZz8q+0FZiBN8Yl42jnExk4FW+9ypo2Rfi?=
 =?us-ascii?Q?izPm7JShO7lzefxe/5qkQuCZ0D1pYsCpuyBuoKs02Llam/gDMJq5/DJZBZjI?=
 =?us-ascii?Q?Ff98mDg6BRa4WAEPAjzxNe5MxtuZAJ9gErj+U+WrxuVWPREPys6eozcf82Pw?=
 =?us-ascii?Q?E95p3egmjOTj4fHVz1syh8fz9Pkab6Jh9B8IKM0tcCiwR+aLv7MaqKxekPmv?=
 =?us-ascii?Q?yWiw06UCisu7r6KxgFxpuUNB6y0/+SrvhMs3qjv0V/4hIxY/8NxngZbdGxMa?=
 =?us-ascii?Q?rabvd+f17tz4c3swhna/tgpKxtKHt1ROfeSYIgi1mZmQxGEAUG8u2ENca8Xw?=
 =?us-ascii?Q?K+JBpwKJTWKp+zURwTaO5h2E7Y2H3BFQVjpPT9UweHdNZb0iyZm52UetvM0a?=
 =?us-ascii?Q?4qrO6FWBsHh256PdAgLGasWHWQ9iDrWEb8of3+kT0X9fmnlWPaiOFyxGtCe9?=
 =?us-ascii?Q?Ot5HTZwjhAuyWvY1Zii1Lqqe+DvoOVPbEJfozQ2WN132BuCL2b4HtBWj3OSZ?=
 =?us-ascii?Q?Pb06wdxLNcqaDNhpqo269dAtW1iglB1go2bJFxlSdAHUvi29ZhW7DffTOU+g?=
 =?us-ascii?Q?r3Zicym82qI1SzkxD+/cnWoQMnilKBLxqO3s7fBjyYx2VKVtMLFLwLk3cmWp?=
 =?us-ascii?Q?nmBifLl4y1+1fcygy9nkz/N6Yk+xCyoBjj2hGqRjefUytgG8CBDXTb8jOaB1?=
 =?us-ascii?Q?sHYZP6upcs3LtddK96C0JBG8nXZQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C+oxHpJEv67DdQadESS7eBcn9vCU+9+hjNXK+9ytPoADtI5AHlSWjWh9l4QK?=
 =?us-ascii?Q?rPfHZPyrnAkzlXJnyeXKk3qO4ZV2rnqY3YF34DOMSC4ulhf9jra07r6BL+ij?=
 =?us-ascii?Q?ILrMbv5Lt7LaYbdNKIttB98OxY3Hwl6MiW0QH9r3lSDejuefjPeFMGzOVnHi?=
 =?us-ascii?Q?AUSi4+tYgPm3sc6ySzXzs9OMESsbA5El3zBa62vGVnX4rZWuJQdL4FeCeD6o?=
 =?us-ascii?Q?tv8zX0TG1eyET6wHYLiZZu9A2CQ33yh+fZXfLR7flOU+IYUbkZh9x/KaIf53?=
 =?us-ascii?Q?M/aIKmaA1m4kszQjNhcqNWPbbJDmFWgGcegNqJM8guU0mGENHZLSuJ2rSxQA?=
 =?us-ascii?Q?X9IFeC/8BZVf4c2aSlOKjKM6u2VLEtAivNibd/yGfxbMGIRhd5XjuVBiLxtp?=
 =?us-ascii?Q?FnVWLJIy76vsN/1A8cUq2EL9JxnYQTmXWy0HydxhODCRyJfykGpMZkIsiPCE?=
 =?us-ascii?Q?FpMVW14RLwMmzlHowkn0N+ZctNVS6jRlkUEKP/hH+PbdEeJ/BSmCVcVPUy5f?=
 =?us-ascii?Q?QEMa5HPZLFGqZIKu0RhdKFL23L43Hk/SHb+nUDb0KBwgT0h/r45niS0WCXfn?=
 =?us-ascii?Q?YaretH9XNI2XQWfcy24/cCgsIPmf4PWXwzdeRvo5CH95HwvxDOTYTpF2YW85?=
 =?us-ascii?Q?Hi7egrjTgiqwqqcrR45UEjGfBLcWTu4ch1sykuz2twr8MGWfJ6lnJu9L1UfI?=
 =?us-ascii?Q?+NcJroMo7bCCaY8tw3C65EDL7jRs2fOsbyzRQMJDDz3WFLp3wGEoDxuaoEUr?=
 =?us-ascii?Q?T1pV5z4wo6dw99zH66Qsnnix+RUaz2QIgUnLf1CKtn0NCn7vKYxPGo1KeFDW?=
 =?us-ascii?Q?cG+E9wXB5TSd1ZjRkh+M64n+9w4ictD/kknQkMeOoYYJMqTUm4i2KAMEsCPe?=
 =?us-ascii?Q?xyweP/CT0y6XPMH07Gw0cvJXmfuS54sWLxlFTYIllHtSwf42TfQef57Ktv2J?=
 =?us-ascii?Q?G96wb4Y3HFmACt1xqr9o7dkQiW7pGAxa+wTAQKharqiOKYHR8TJnqpBIMtMT?=
 =?us-ascii?Q?PxC+bCI0nxNrWdGcN8Kdc2VS7hRLxzr9cb2Sbc1IbtZd3sFJOozT/jFygK+1?=
 =?us-ascii?Q?hqEQCHcaOeCh4apGpIsHkSWaA5e7TNB/1yNAVne6LxCO/MzbA2at42OimMIS?=
 =?us-ascii?Q?aBhJSCNnpxz0kjflhKEJXRgLCuR7xxWPdnKg8sYTFBcUOIFjWzY0Yu3BXmZ2?=
 =?us-ascii?Q?KAhvlOBQZuVFGw94OgumbHhe/XdGgTs8FD5Me9dYyQCbR40sEuH6+eYtL78B?=
 =?us-ascii?Q?Layy/LIT+dKNFM5Kc3enqm1Pn9HTIoB6oZI3VykU4bolgqJ4uJOAOoBc/r7R?=
 =?us-ascii?Q?EH2PEiP7Wm5j1kpOw9cV9roQ3sNmWQ5RL3z5TuCCXJENrp7nE2LVc5XlmVMS?=
 =?us-ascii?Q?hd+EJL/+Ei7oimlVWeyNKO+CiBHSAFHBx1fu0HpDsYjQYtffNdHGVMxxUCKb?=
 =?us-ascii?Q?dLimvyHVjIP82+qKBOvXygB9pyGGLsMzh8GDPpsBXAWbDSyPVksgEuvg2qyD?=
 =?us-ascii?Q?cW6RK2kilmRVxW6dY5gMZy5xpV0rfmWUZBPdQfgIIf/pAaSRvMCJw3lp6zdU?=
 =?us-ascii?Q?uIZ5b5MBVkFt+LpZTi/ZijHu2aS0LTVBF71wJJrc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbc7986-5861-45a6-c000-08dd336e60aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 01:05:31.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07r1qBr+IXxk6X1tE6PCxD3mwe+PcQYLZq6t6bwFWzvN6ENXth/Deyagg4r0j04+QZxZE/KRGngxLZ6haV5FBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104

On Fri, Jan 10, 2025 at 07:35:57PM -0800, Dan Williams wrote:
> Andrew Morton wrote:
> > On Thu, 9 Jan 2025 23:05:56 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > >  - Remove PTE_DEVMAP definitions from Loongarch which were added since
> > > >    this series was initially written.
> > > [..]
> > > > 
> > > > base-commit: e25c8d66f6786300b680866c0e0139981273feba
> > > 
> > > If this is going to go through nvdimm.git I will need it against a
> > > mainline tag baseline. Linus will want to see the merge conflicts.
> > > 
> > > Otherwise if that merge commit is too messy, or you would rather not
> > > rebase, then it either needs to go one of two options:
> > > 
> > > - Andrew's tree which is the only tree I know of that can carry
> > >   patches relative to linux-next.
> > 
> > I used to be able to do that but haven't got around to setting up such
> > a thing with mm.git.  This is the first time the need has arisen,
> > really.
> 
> Oh, good to know.
> 
> > 
> > > - Wait for v6.14-rc1 
> > 
> > I'm thinking so.  Darrick's review comments indicate that we'll be seeing a v7.

I'm ok with that. It could do with a decent soak in linux-next anyway given it
touches a lot of mm and fs.

Once v6.14-rc1 is released I will do a rebase on top of that.

> > > and get this into nvdimm.git early in the cycle
> > >   when the conflict storm will be low.
> > 
> > erk.  This patchset hits mm/ a lot, and nvdimm hardly at all.  Is it
> > not practical to carry this in mm.git?
> 
> I'm totally fine with it going through mm.git. nvdimm.git is just the
> historical path for touches to fs/dax.c, and git blame points mostly to
> me for the issues Alistair is fixing. I am happy to review and ack and
> watch this go through mm.git.

