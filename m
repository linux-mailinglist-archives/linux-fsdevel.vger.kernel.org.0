Return-Path: <linux-fsdevel+bounces-7680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FF82935A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 06:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6B31C25500
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 05:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A8532C72;
	Wed, 10 Jan 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPk2SAaP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F365DDA1;
	Wed, 10 Jan 2024 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704864795; x=1736400795;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WNbnQSe7tvwsZ2+Al74prerRm9YkmBSyA3UHqSf5nwo=;
  b=YPk2SAaPrmz2apwc9CEMaua+NyBcocnmU9ew/poyXGTjVVZmGeLADyp6
   o/XGBvEUEoeqDLv4y+ZndlJoTnnQWBeolQJI0AOKmlMIDiPHynFTD4Y5S
   vJZGpd92gTRtg8D/7KEhOesicXZAzngYbEIfvsMwZN9jo1q4TRHoRF7ra
   j3lcw2RO8R9axchgw4JMTaE+DONTYjXj6n/nV8xgmZaLIO4jjACnYcuD1
   aGQ24pnuu5mrYL5HZOSM9o6fRhBBv88Bv4c5jgH+ZNM+JmeF4Ft1iHbAc
   NIIvlRLka2kjRWsIfGYbHPLfDb9JER53CyD/MDgHr7rbvBFhrkhp/AKpf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="464816066"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="464816066"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:33:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="955251273"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="955251273"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 21:33:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 21:33:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 21:33:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 21:33:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 21:33:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9yDvLeu6xKDEfNwPPN1D4H8LMsrY8fsbWYmNPKMfVjRR+CL4mRx5k2UYc30t5f4HUYUk6vtIYm176o8M619SyTukC/9E33GfJTOVEDdyM7LEQjD1rQR6NkVCxAOucepg71thjWX4n/h09Gz1cbnOorToG9grswDgPVOQAhiSpE+SGp+xgKwOtQBzap9iuVPhsgryWrW+tEYUfGbFm8P6gfB7x7DM2XnRoSYT7Q+EE8BLdYno0eoktrTJ9/RA4qSouHCtvapg9rDCqTvhmQUyWwoRDHNuKzKdoX0zEYeuBefs6qpO88puK4BmB5XfeZb0GpdBrKMBmuEaz9SUBLNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zPqrozIyl6QMueNFiY94jXmnLIoEHEoDBhompCI2PI=;
 b=YyRYsxEXUwTUkU2pD8NeCon0mHnk6WV2LA4ReVYPBV7/fvNZacy4DjCOiD/py57g+r4Jk29UoaeHduELfaXbRvE+KrZnyXYOLs6eSyiSDnZNH82RgslHINvS8oBg+okO+MnQLMCwGkAaVk6t32vfri9miOUUmpfR59sNycB6rqixVkLqZJltvXvVRQipYJTFCHEB3ydBYVIqqFmgJsZsrAEboGSj03bzIQAa2XDAgUuA+6aEk0I8yWNKIMrn1TRxG/1zlop3DFxCAsVpVgGIN2ATvT8xpOrZOybtJuFhLpEqZqXK3OXXmBZzdmwOH80S2D9sQGq0U6GhJt84TuU+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW6PR11MB8392.namprd11.prod.outlook.com (2603:10b6:303:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 05:33:02 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 05:33:02 +0000
Date: Wed, 10 Jan 2024 13:27:25 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: David Howells <dhowells@redhat.com>, <eadavis@qq.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Simon Horman
	<horms@kernel.org>, Markus Suvanto <markus.suvanto@gmail.com>, "Jeffrey E
 Altman" <jaltman@auristor.com>, Marc Dionne <marc.dionne@auristor.com>, "Wang
 Lei" <wang840925@gmail.com>, Jeff Layton <jlayton@redhat.com>, Steve French
	<smfrench@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-afs@lists.infradead.org>, <keyrings@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<ceph-devel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<heng.su@intel.com>
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list
 header
Message-ID: <ZZ4qvVD5oQOxBLvB@xpf.sh.intel.com>
References: <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com>
 <1843374.1703172614@warthog.procyon.org.uk>
 <20231223172858.GI201037@kernel.org>
 <2592945.1703376169@warthog.procyon.org.uk>
 <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com>
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW6PR11MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db03b8e-680b-4e11-f347-08dc119d9cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhOClVryRH+bWQlWzm7acUJfJnGaOpONoZBj4riH/Bm7Nm76HKz3vo3UB2lr+E58TgyTm64N29+sL2OVUoKT7J5A+Kc94e0qrOJJVPzAxOw5wmTfpBvWrm8ZbLY9FFmVfAwv1QaSGhO4nP+FzX6lzmhsO6eSQwQkaQ5CURm77bMIW2RgX2+e/A6RKK7MB6qz8hJUmwjLYKCC1VYGrYGlt3m0kC/HkmiJZSROjm6ojZncjTD3Hf6khldIh9TdG/obD+Z8IrfPoHgO4wRVGewBtQsFFqFTy34p7aFw26JOqTTtSlOqLF3do5zkOQqCnBus246mgNGxVOSzjVDpLecQ1k57g2Ch8mUzIZrT/hezKCy92vAMTF1sZ6d0LBapbIKXjOt7Z33UfBeHnsVbmE1+49qBtTNnCN+jU72ZwEyGBNolNvniNJmYluzWMKnqBzxpYAuXqcWLsfycQDuhNdRlJ0gUL/YMJYtZ6gO9sxWxKwerB2XJJFUOE7TYjSXGWuqkzwaN1VZaB5BiA7jOFb6y/g9OQ4VBSHpq6kUAU9J1Jdn/rmvEUVPLLa8KBc1KOHn2bhYRdf/XV19ZbVF9GT8sQU7kZsQjyj0FdhOY1kH1bF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(966005)(6486002)(478600001)(83380400001)(4326008)(44832011)(66476007)(66556008)(8936002)(8676002)(54906003)(66946007)(316002)(107886003)(26005)(6666004)(6506007)(53546011)(86362001)(6512007)(82960400001)(30864003)(2906002)(4001150100001)(7416002)(5660300002)(41300700001)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJl5Uz72x0aQx03hNLWlruwrbGdOs/zChGnlxAeouVcqa0IayR+heMVqJHNB?=
 =?us-ascii?Q?V8kr0I/LKJAKBK292FFDuhIjd5LeXu9onXQNOxpLnn7s+kut+MRzHMZuh0XT?=
 =?us-ascii?Q?Z0EDOh3yW7NOs6doVx2+EnOgG7mJZEoRXVIti5XmBQSVnOK/FwX6Ti4oTrnj?=
 =?us-ascii?Q?RQPFUPHNAULgTbO8js2mUs4NLNhqdfn5wm9xKhyxOYdIp86z0mUkp3oRhtSc?=
 =?us-ascii?Q?KZ6hBveFbMNs98WKbgbaQ9QvPvqc7+780vg9n5HsXHf7FqJRknukRzqPl42f?=
 =?us-ascii?Q?L/jcw1um8tPVtlON1tYHiLsxz3istbaNTod6IKLfc03/91TlDFMYxRrh3547?=
 =?us-ascii?Q?CksO0Tc4sLOTnDT+eSJC6rYgtHFSXqGuXTaj8Ce7RM2kM3GgIv+XMAfDfQGj?=
 =?us-ascii?Q?lZ9mFb78HCIFrfHxVwOY0pKG2AVX44e8QV0osS/IerzAs9n8vnNPU4Pl6GDI?=
 =?us-ascii?Q?Qbudgw0qdvnwtujp8SvSg8u6Ex6jpniBNusS9REqPBdHr1FIXWWRbycppEJe?=
 =?us-ascii?Q?/FjKuy9LSr6ak5x5gkeb96XLKe7Nc1ls+5HgeGxHpcukDui2RgMqw/TADMyX?=
 =?us-ascii?Q?3YiVNZPodZSzCBbaKbJO2pyFuWiwjgOTTO7sX/eeingomdHvUrmB8FZv+5e9?=
 =?us-ascii?Q?8+rnJZ3RXb0OGY/M/7YkN83CPi9ZE16lJ+/PaEY4nzdslNNXDFdXq51wwZuL?=
 =?us-ascii?Q?LICEzrRw0lQWNr3oCz/u7z2FzgEAQzzSrJhrd82QWHa1dtDttlmR8ZknHr4I?=
 =?us-ascii?Q?yO8lvc3QDmPZgd13hU3LUIr9xURZrMbvbn1j35cQSG2asxT2OrL6SM3koDdL?=
 =?us-ascii?Q?UGWfjPFGNi8mJQ8nb51i586N/ggDlGbqppmK4wAlP1KxD7Xu2H5+GTROWqbv?=
 =?us-ascii?Q?SqBt6n0EAQS0buvZDp1vMdQ7s64//HDc3TuIXWYbHFDVxtt57e/PuBJkmmcR?=
 =?us-ascii?Q?VcvZk3r5A1TpOi8IVc4YLzmnHUELdWSBXXyz4YXi4hPBUWPxJQsI9iD1YzQ5?=
 =?us-ascii?Q?RccCJk5hjPzNBG6I85MD6Smw8rhQh7MiTLC06dgkEay0tIN0+ThWmT4u4SOf?=
 =?us-ascii?Q?u0Kn77YA5/od6ofohHafxMCPF7Vfvsd4wct1QfoqGB6q3HntU9f1xKrgbdN6?=
 =?us-ascii?Q?o+6q8/W83l1Mog/FGie1hU2MkI7xG31oeJ/cEUxLKtTbP0Z0I3Idz09G0BPN?=
 =?us-ascii?Q?0lTj4aXhcyWMCZ5IPL0potbjHntnTavW+oUfNkO/8jIl7F76GetNRmVK+YxS?=
 =?us-ascii?Q?BwCihEzp/5wnKzxN/Yqy3d94eo6fqevbA4HyqWbuj7EW+HjyY2mqJgrDtT42?=
 =?us-ascii?Q?2NflZCfWEFDoacASdcINK7IwsfRd1huBMuPLe3DcYlXAi7ZKDAMh/J4P1bzI?=
 =?us-ascii?Q?GFL+xWUhKhvUFrZgalhHnEzx1n17HqMiy6IkRG06IlZdUr591fLSiH9+uwXd?=
 =?us-ascii?Q?Nibpyem8P+SsrB4glvqneDDWkJU9n1bifez9BODcO6GbtLVVTcipEDWba7WO?=
 =?us-ascii?Q?YG6HqSZn5vYPBVABHibz3FN3s7eoX+UQFUC6uTt30yHny8TOgfp34cZYkAEH?=
 =?us-ascii?Q?mVpGVrcFm1cgNbLvz3g3XowYsJ0xaUcrEmobKoNy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db03b8e-680b-4e11-f347-08dc119d9cde
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 05:33:02.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOBBct22WPiY8oVlYhjHOpdAtDUWMz39pjzoeAynsDr6mDVVgXNqTmTamOzkSZpV0VHk/gc38Dk/YYWthH/rKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8392
X-OriginatorOrg: intel.com

On 2024-01-10 at 12:40:41 +0800, Pengfei Xu wrote:
> On 2023-12-24 at 00:02:49 +0000, David Howells wrote:
> > Hi Linus, Edward,
> > 
> > Here's Linus's patch dressed up with a commit message.  I would marginally
> > prefer just to insert the missing size check, but I'm also fine with Linus's
> > approach for now until we have different content types or newer versions.
> > 
> > Note that I'm not sure whether I should require Linus's S-o-b since he made
> > modifications or whether I should use a Codeveloped-by line for him.
> > 
> > David
> > ---
> > From: Edward Adam Davis <eadavis@qq.com>
> > 
> > keys, dns: Fix missing size check of V1 server-list header
> > 
> > The dns_resolver_preparse() function has a check on the size of the payload
> > for the basic header of the binary-style payload, but is missing a check
> > for the size of the V1 server-list payload header after determining that's
> > what we've been given.
> > 
> > Fix this by getting rid of the the pointer to the basic header and just
> > assuming that we have a V1 server-list payload and moving the V1 server
> > list pointer inside the if-statement.  Dealing with other types and
> > versions can be left for when such have been defined.
> > 
> > This can be tested by doing the following with KASAN enabled:
> > 
> >         echo -n -e '\x0\x0\x1\x2' | keyctl padd dns_resolver foo @p
> > 
> > and produces an oops like the following:
> > 
> >         BUG: KASAN: slab-out-of-bounds in dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
> >         Read of size 1 at addr ffff888028894084 by task syz-executor265/5069
> >         ...
> >         Call Trace:
> >          <TASK>
> >          __dump_stack lib/dump_stack.c:88 [inline]
> >          dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> >          print_address_description mm/kasan/report.c:377 [inline]
> >          print_report+0xc3/0x620 mm/kasan/report.c:488
> >          kasan_report+0xd9/0x110 mm/kasan/report.c:601
> >          dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
> >          __key_create_or_update+0x453/0xdf0 security/keys/key.c:842
> >          key_create_or_update+0x42/0x50 security/keys/key.c:1007
> >          __do_sys_add_key+0x29c/0x450 security/keys/keyctl.c:134
> >          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >          do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> >          entry_SYSCALL_64_after_hwframe+0x62/0x6a
> > 
> > This patch was originally by Edward Adam Davis, but was modified by Linus.
> > 
> > Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry")
> > Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/r/0000000000009b39bc060c73e209@google.com/
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Tested-by: David Howells <dhowells@redhat.com>
> > cc: Edward Adam Davis <eadavis@qq.com>
> > cc: Simon Horman <horms@kernel.org>
> > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > cc: Jarkko Sakkinen <jarkko@kernel.org>
> > cc: Jeffrey E Altman <jaltman@auristor.com>
> > cc: Wang Lei <wang840925@gmail.com>
> > cc: Jeff Layton <jlayton@redhat.com>
> > cc: Steve French <sfrench@us.ibm.com>
> > cc: Marc Dionne <marc.dionne@auristor.com>
> > cc: "David S. Miller" <davem@davemloft.net>
> > cc: Eric Dumazet <edumazet@google.com>
> > cc: Jakub Kicinski <kuba@kernel.org>
> > cc: Paolo Abeni <pabeni@redhat.com>
> > cc: linux-afs@lists.infradead.org
> > cc: linux-cifs@vger.kernel.org
> > cc: linux-nfs@vger.kernel.org
> > cc: ceph-devel@vger.kernel.org
> > cc: keyrings@vger.kernel.org
> > cc: netdev@vger.kernel.org
> > ---
> >  net/dns_resolver/dns_key.c |   19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> > index 2a6d363763a2..f18ca02aa95a 100644
> > --- a/net/dns_resolver/dns_key.c
> > +++ b/net/dns_resolver/dns_key.c
> > @@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
> >  static int
> >  dns_resolver_preparse(struct key_preparsed_payload *prep)
> >  {
> > -	const struct dns_server_list_v1_header *v1;
> > -	const struct dns_payload_header *bin;
> >  	struct user_key_payload *upayload;
> >  	unsigned long derrno;
> >  	int ret;
> > @@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
> >  		return -EINVAL;
> >  
> >  	if (data[0] == 0) {
> > +		const struct dns_server_list_v1_header *v1;
> > +
> >  		/* It may be a server list. */
> > -		if (datalen <= sizeof(*bin))
> > +		if (datalen <= sizeof(*v1))
> >  			return -EINVAL;
> >  
> > -		bin = (const struct dns_payload_header *)data;
> > -		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
> > -		if (bin->content != DNS_PAYLOAD_IS_SERVER_LIST) {
> > +		v1 = (const struct dns_server_list_v1_header *)data;
> > +		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
> > +		if (v1->hdr.content != DNS_PAYLOAD_IS_SERVER_LIST) {
> >  			pr_warn_ratelimited(
> >  				"dns_resolver: Unsupported content type (%u)\n",
> > -				bin->content);
> > +				v1->hdr.content);
> >  			return -EINVAL;
> >  		}
> >  
> > -		if (bin->version != 1) {
> > +		if (v1->hdr.version != 1) {
> >  			pr_warn_ratelimited(
> >  				"dns_resolver: Unsupported server list version (%u)\n",
> > -				bin->version);
> > +				v1->hdr.version);
> >  			return -EINVAL;
> >  		}
> >  
> > -		v1 = (const struct dns_server_list_v1_header *)bin;
> >  		if ((v1->status != DNS_LOOKUP_GOOD &&
> >  		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
> >  			if (prep->expiry == TIME64_MAX)
> > 
> 
> Hi Edward and kernel experts,
> 
>   Above patch(upstream commit: 1997b3cb4217b09) seems causing a keyctl05 case
> to fail in LTP:
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/keyctl/keyctl05.c
> 
> It could be reproduced on a bare metal platform.
> Kconfig: https://raw.githubusercontent.com/xupengfe/kconfig_diff/main/config_v6.7-rc8
> Seems general kconfig could reproduce this issue.
> 
>   Bisected info between v6.7-rc7(keyctl05 passed) and v6.7-rc8(keyctl05 failed)
> is in attached.
> 
> keyctl05 failed in add_key with type "dns_resolver" syscall step tracked
> by strace:
> "
> [pid 863107] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
> [pid 863106] <... alarm resumed>)       = 30
> [pid 863107] <... add_key resumed>)     = -1 EINVAL (Invalid argument)
> "
> 
> Passed behavior in v6.7-rc7 kernel:
> "
> [pid  6726] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
> [pid  6725] rt_sigreturn({mask=[]})     = 61
> [pid  6726] <... add_key resumed>)      = 1029222644
> "

Sorry, updated more keyctl05 failed in add_key with type "dns_resolver"
syscall step tracked by strace:
"
[pid 863107] getppid()                  = 863106
[pid 863107] kill(863106, SIGUSR1)      = 0
[pid 863106] <... wait4 resumed>0x7ffc5ec94858, 0, NULL) = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
[pid 863107] keyctl(KEYCTL_JOIN_SESSION_KEYRING, NULL <unfinished ...>
[pid 863106] --- SIGUSR1 {si_signo=SIGUSR1, si_code=SI_USER, si_pid=863107, si_uid=0} ---
[pid 863107] <... keyctl resumed>)      = 512571383
[pid 863106] alarm(30 <unfinished ...>

[pid 863107] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
[pid 863106] <... alarm resumed>)       = 30
[pid 863107] <... add_key resumed>)     = -1 EINVAL (Invalid argument)
[pid 863106] rt_sigreturn({mask=[]} <unfinished ...>
[pid 863107] write(2, "keyctl05.c:114: TFAIL: unexpecte"..., 79keyctl05.c:114: TFAIL: unexpected error adding 'dns_resolver' key: EINVAL (22)
 <unfinished ...>
[pid 863106] <... rt_sigreturn resumed>) = 61
[pid 863107] <... write resumed>)       = 79
"

Passed behavior in v6.7-rc7 kernel:
"
[pid  6726] getppid()                   = 6725
[pid  6726] kill(6725, SIGUSR1 <unfinished ...>
[pid  6725] <... wait4 resumed>0x7ffc6cad1c68, 0, NULL) = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
[pid  6726] <... kill resumed>)         = 0
[pid  6725] --- SIGUSR1 {si_signo=SIGUSR1, si_code=SI_USER, si_pid=6726, si_uid=0} ---
[pid  6726] keyctl(KEYCTL_JOIN_SESSION_KEYRING, NULL <unfinished ...>
[pid  6725] alarm(30 <unfinished ...>
[pid  6726] <... keyctl resumed>)       = 713868472
[pid  6725] <... alarm resumed>)        = 30

[pid  6726] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
[pid  6725] rt_sigreturn({mask=[]})     = 61
[pid  6726] <... add_key resumed>)      = 1029222644
"

> 
> Do you mind to take a look for above issue?
> 
> Best Regards,
> Thanks!

> git bisect start
> # status: waiting for both good and bad commits
> # good: [861deac3b092f37b2c5e6871732f3e11486f7082] Linux 6.7-rc7
> git bisect good 861deac3b092f37b2c5e6871732f3e11486f7082
> # status: waiting for bad commit, 1 good commit known
> # bad: [610a9b8f49fbcf1100716370d3b5f6f884a2835a] Linux 6.7-rc8
> git bisect bad 610a9b8f49fbcf1100716370d3b5f6f884a2835a
> # good: [861deac3b092f37b2c5e6871732f3e11486f7082] Linux 6.7-rc7
> git bisect good 861deac3b092f37b2c5e6871732f3e11486f7082
> # bad: [505e701c0b2cfa9e34811020829759b7663a604c] Merge tag 'kbuild-fixes-v6.7-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> git bisect bad 505e701c0b2cfa9e34811020829759b7663a604c
> # good: [1803d0c5ee1a3bbee23db2336e21add067824f02] mailmap: add an old address for Naoya Horiguchi
> git bisect good 1803d0c5ee1a3bbee23db2336e21add067824f02
> # bad: [eeec2599630ac1ac03db98f3ba976975c72a1427] Merge tag 'bcachefs-2023-12-27' of https://evilpiepirate.org/git/bcachefs
> git bisect bad eeec2599630ac1ac03db98f3ba976975c72a1427
> # bad: [f5837722ffecbbedf1b1dbab072a063565f0dad1] Merge tag 'mm-hotfixes-stable-2023-12-27-15-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad f5837722ffecbbedf1b1dbab072a063565f0dad1
> # good: [b8e0792449928943c15d1af9f63816911d139267] virtio_blk: fix snprintf truncation compiler warning
> git bisect good b8e0792449928943c15d1af9f63816911d139267
> # bad: [1997b3cb4217b09e49659b634c94da47f0340409] keys, dns: Fix missing size check of V1 server-list header
> git bisect bad 1997b3cb4217b09e49659b634c94da47f0340409
> # good: [fbafc3e621c3f4ded43720fdb1d6ce1728ec664e] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> git bisect good fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
> # first bad commit: [1997b3cb4217b09e49659b634c94da47f0340409] keys, dns: Fix missing size check of V1 server-list header


