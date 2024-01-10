Return-Path: <linux-fsdevel+bounces-7681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEEA82937F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 06:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274431F26D69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 05:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E34632C81;
	Wed, 10 Jan 2024 05:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMuXfhE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E373DDDF;
	Wed, 10 Jan 2024 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704865980; x=1736401980;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MU/M0RIFLxm4vZmWD78eW7Y2luXLd1c1xv6CL+pjGFw=;
  b=ZMuXfhE7dmWQs7WDB2yoVnJp8rBxI9x3MUWFH3zRYG2C01/bGCbqVv1B
   O9fav3+bfmebS4eRGRU1d4elqiw2tyvosXwE7deWocWc6dBWPjyAl0K/N
   6XYFZZ+Z7we8CPlgAT6vB98lOjLaPX2ptSAK7KIngXYj2Mxr4Jlix0WaF
   v4ph3Wpwy8gVI8NFh7QR59/ePBJzsjlsGPDGHriF/j7bFkSuRI7PbE9Yf
   g2l9lKGYveHvogXjvKGpAEB2jdiNorFGN32NxaGTzeBBFobJk5c8yuDQu
   CSPS0jgR/5/xC9IyfCtfcvznoKrm50kyWdtZKT/pf7m3ehF+suB1KpjI2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="397272956"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397272956"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="24139200"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 21:52:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 21:52:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 21:52:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 21:52:57 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 21:52:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9sOj91KStqVBvMbxRmoL/92ZxF5nc8oIx1mhp4DeoqWAW2S9QRDb5Fr+tUbPQPuhvg9TzxJ7VsylFxv/5dw8/xgQQNlr2RFF6FoGiyLjJJgTHs39NpxvR/y0OZHM25UYOgZI7BKpZ2Vy4I4F/Q5O2bn6B7v3wyoNa/pptUD5e6/juiAnVqzuwUZU/xhxh/ymdC6s3DrTC27J/h62l230IpURHHb/x6KRubwiOvJ06Gr3avuuNB0AgKYXVOfeMbBGrx16zHQtugsR51iTqKHpumttjat2dk/ixvj8TLSjFOI1QDWPBeeOQK01XK90GKvjpCJ7UTjQb1BpUKRptTCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjKmFps2wR/YZorn0z85XB+Onm2aTOpzfNl8Nd6z2uM=;
 b=kfdTLS02dqeylZcOwlbPSC0kZgb88dRUAXgG/AzvLSRiQ+uXEovoFSzNqXMBo5V/+85RotYMCocRnjqUv06rsdPd/mgM10jW1+rsH76EfOOdzPbZeGG2LKaHqyFE5N1U/QvjUhyFi2RDQkNwfC6k/zFmkxEb4eGYuJ3f4V2EqG64SQYF9zdZ5JWOVXFug7Sl5xeIIHcg6j59eg9Kz5BTNA1Cgdet1tGKbapaZWtdbyN/TUQaAv5N54WZlQMxyaj2MRSjQS8XvGj4q8lLAw/gbMRZHbUkZLj1Uca0mClvAbTzPAhxe7jsV8sBXjHoA8cSJW+y841LBjW2q1ZxUbF1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS7PR11MB6127.namprd11.prod.outlook.com (2603:10b6:8:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 05:52:54 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 05:52:54 +0000
Date: Wed, 10 Jan 2024 13:47:20 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Edward Adam Davis <eadavis@qq.com>
CC: <ceph-devel@vger.kernel.org>, <davem@davemloft.net>,
	<dhowells@redhat.com>, <edumazet@google.com>, <heng.su@intel.com>,
	<horms@kernel.org>, <jaltman@auristor.com>, <jarkko@kernel.org>,
	<jlayton@redhat.com>, <keyrings@vger.kernel.org>, <kuba@kernel.org>,
	<linux-afs@lists.infradead.org>, <linux-cifs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <marc.dionne@auristor.com>,
	<markus.suvanto@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<smfrench@gmail.com>, <torvalds@linux-foundation.org>, <wang840925@gmail.com>
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list
 header
Message-ID: <ZZ4vaJMN2w/ilkR3@xpf.sh.intel.com>
References: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com>
 <tencent_CF4FEF0D9B25A08DD7920E5D93DDBC194E07@qq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_CF4FEF0D9B25A08DD7920E5D93DDBC194E07@qq.com>
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS7PR11MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfa95f0-763b-4a1a-f530-08dc11a0634e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKeX8t0e+BfZ6rf0cTR/MwD6Vn8G81CVM0KHJRplPkcF3aGz4Tb4u0M3FDeLCitH/jVfL18g5Xn/0OG10ZqAeorIAW7yzKZNsHnA2sm/7Dpqt4F3KB3qV7Fhx9q5vermEovuL8C7pLCZdyGBNkW/4AggKVZELUcJB/wJdRWAH3FCKdU5nZF/DpdjIgP1sYjVCJV0hc/sPFUySX0wz2fhBYmcCd3IQsABMu0h/CtZLXjkZKJw5OmLewcwCBRniD8i/YBMEu2Eep0vYpm5JYFqJri3Zun8GATGAgbZLQcw+9f6SBxat1uThGlbIexIRskX4eSPE4mvLj5iVxJlirmg5Xe5ZAW4fceATnbVkxw03ynpX+19D63s7VhShtinK9kRvja2pEt3c8qiHiBDiOMNuFUYALIFgzb1AxOByYGWccmTdoLqs1o25lWH5uxrYUoQHMCKPmeSEEmkEQPe5QQer8nxMCEB+bWWxwp+gQc0fw3hy+mOuN99ggEpHRVTHxEoMTmtw988IjAdoLf9CujDyzLzsuOey7HgUwsTUTiTusw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66899024)(2906002)(5660300002)(7416002)(38100700002)(44832011)(82960400001)(26005)(4326008)(6666004)(8676002)(8936002)(6486002)(41300700001)(316002)(478600001)(86362001)(6916009)(966005)(66556008)(66476007)(66946007)(53546011)(6512007)(83380400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Ply4IGCCwy+huPRVnOGftpyh2q+LybKRWrmGX/3mwYQivTc3oOBthLd5dUz?=
 =?us-ascii?Q?/0hsrFkHwfHm/Kx34ezSB1JUqTavwkfv8ZjW7iauVJQDjB1e9Hp11mSXdevI?=
 =?us-ascii?Q?3nCOnnl43VpvlS4MbEB4WGyZ4DUIubCM3nfSs1uLYY8+H+Wjo0wrMikeDk3W?=
 =?us-ascii?Q?+zla+EzdU0lIeEnby2+ejOHBMiFaSHsoy2+Xdz627Gv+l0DLMKx5f/T2ZiAI?=
 =?us-ascii?Q?srlFRK0QCts5UdY5ae227XqJ7ZrY2/bjf+Hzq+/cMc+QmJUaMiT11njvuCbc?=
 =?us-ascii?Q?4bF14DIj3hSE0FFd4Luhk7u8nIO7c0zvLAAFfPjJpCIVzkghJlBW8J9w+JDN?=
 =?us-ascii?Q?/RhS9rUvJ69zW5hOwF3+Palvmzsb+cr76J1LWIR8Ac2HDDSBdS2TUNUNuic8?=
 =?us-ascii?Q?ajTH35AFpLIoIdOfuN1ENd0STjONT7dhkjNN5vhvJZr32O4uwVZefHm3kDHt?=
 =?us-ascii?Q?2t2pgayxgs2OkbqylclsI91mmP1imMCBpy7xOSA/Tzpy6EHQ8nANt50mZuHi?=
 =?us-ascii?Q?E7hFWfXLaC6Unw+zQmVTD1W+oQ2Iq9jXL3h6skiiOy98HsDbPr4+qaNHG1cN?=
 =?us-ascii?Q?nZjROEOUSzcaB9AqFqzQUUGB+Hu9Vv0HlzQbcRwTjo8G+c4tzGYOSPsEOhWq?=
 =?us-ascii?Q?VfWvI/rsvAQfZ95izwPTyK/QZRVZB9UcUUBBThn49NyTUlmJ1jtLS9KonbCv?=
 =?us-ascii?Q?8zGcQZV9RacMgVmwDNiLgWhx/j40LmAzk/72IoWE178HVntGUDcNcaP4Hlua?=
 =?us-ascii?Q?TIbpnZpbNEo2Xa+fmWax5j0YVeRtBB2o5m/bUSQ7ap8hG+pDyXds7PN1HGV9?=
 =?us-ascii?Q?xlzCrYR8mMHPlksaxPE4BFcrjVqDIIW9DIoQ1Shosor/lIDZSqLdYIrNK1AL?=
 =?us-ascii?Q?CSaZBgE+CdEkBMNjGJ+UE5iBfU1kiDsJi38nNMl+S/pPL9eeiUqleYKUkI+I?=
 =?us-ascii?Q?9C0QE6C4c9HURNm4dTpbpWYxWEBbdIR7Djp+eyfvrW0/xY4+f4FV/JLickgZ?=
 =?us-ascii?Q?xG8a+KXvceWi3nNUuB+716E7HVCzS2EFjznzantkFrSwAOmhQBGrBbJaYBDg?=
 =?us-ascii?Q?Anu6WT4QXMqA4sNjHdZuUFjvEFskDqy+60YHNY0jip/cbN7oCHTcmwCvlD2Y?=
 =?us-ascii?Q?o989yanN7ivJKBKpwy/K8KZWboedrXy9ekq5KSZCrmWsusZqzgPKPeTegV2N?=
 =?us-ascii?Q?tlAXP+CU9Mqcwczn0lvweHphywD/9kXiPL7a4nP6OlwlUV8buPrZ5jCoYOMe?=
 =?us-ascii?Q?vW3xqrtatVtRqZERFTQrF0t+HOpbdD6vzWg9MgY2/CbF5t9osM43L7kHKYmn?=
 =?us-ascii?Q?PNnpOwl6ex1x7cNGkvbHOQf/gqV5pZVgZiWZEPf6U14b79x4NVS+5xrTXveG?=
 =?us-ascii?Q?EHkQO/LN22uX4VXk/Ds0R+USkzM57bUcUHq1jZVDcTVQ7g12pawxBMHfid2I?=
 =?us-ascii?Q?8v+j+/8S9Z7WdMVCrFPB2A2YS7LAs+T25XHds4gOzyPAPIAyXSKOrA0f5uXJ?=
 =?us-ascii?Q?u462KJxrU4UvNqYANIjexVMfe6R+PUi8L6zbDE1/Ecjrg0KQeaCiCFBdSMEI?=
 =?us-ascii?Q?cG4nSHeaePqy14dJJcu6Z2ImYkbdBtmJgl0C9Oxu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfa95f0-763b-4a1a-f530-08dc11a0634e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 05:52:53.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMQ6MYGugQR/ZDOewSlucsXKg+oOx1r+XmepAOlp5/qWIN6N4vDsLi8ec3Se5N8+rE91PIYrPeheOX0DXEtfBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6127
X-OriginatorOrg: intel.com

On 2024-01-10 at 13:19:49 +0800, Edward Adam Davis wrote:
> On Wed, 10 Jan 2024 12:40:41 +0800, Pengfei Xu wrote:
> > > Hi Linus, Edward,
> > >
> > > Here's Linus's patch dressed up with a commit message.  I would marginally
> > > prefer just to insert the missing size check, but I'm also fine with Linus's
> > > approach for now until we have different content types or newer versions.
> > >
> > > Note that I'm not sure whether I should require Linus's S-o-b since he made
> > > modifications or whether I should use a Codeveloped-by line for him.
> > >
> > > David
> > > ---
> > > From: Edward Adam Davis <eadavis@qq.com>
> > >
> > > keys, dns: Fix missing size check of V1 server-list header
> > >
> > > The dns_resolver_preparse() function has a check on the size of the payload
> > > for the basic header of the binary-style payload, but is missing a check
> > > for the size of the V1 server-list payload header after determining that's
> > > what we've been given.
> > >
> > > Fix this by getting rid of the the pointer to the basic header and just
> > > assuming that we have a V1 server-list payload and moving the V1 server
> > > list pointer inside the if-statement.  Dealing with other types and
> > > versions can be left for when such have been defined.
> > >
> > > This can be tested by doing the following with KASAN enabled:
> > >
> > >         echo -n -e '\x0\x0\x1\x2' | keyctl padd dns_resolver foo @p
> > >
> > > and produces an oops like the following:
> > >
> > >         BUG: KASAN: slab-out-of-bounds in dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
> > >         Read of size 1 at addr ffff888028894084 by task syz-executor265/5069
> > >         ...
> > >         Call Trace:
> > >          <TASK>
> > >          __dump_stack lib/dump_stack.c:88 [inline]
> > >          dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> > >          print_address_description mm/kasan/report.c:377 [inline]
> > >          print_report+0xc3/0x620 mm/kasan/report.c:488
> > >          kasan_report+0xd9/0x110 mm/kasan/report.c:601
> > >          dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
> > >          __key_create_or_update+0x453/0xdf0 security/keys/key.c:842
> > >          key_create_or_update+0x42/0x50 security/keys/key.c:1007
> > >          __do_sys_add_key+0x29c/0x450 security/keys/keyctl.c:134
> > >          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >          do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> > >          entry_SYSCALL_64_after_hwframe+0x62/0x6a
> > >
> > > This patch was originally by Edward Adam Davis, but was modified by Linus.
> > >
> > > Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry")
> > > Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com
> > > Link: https://lore.kernel.org/r/0000000000009b39bc060c73e209@google.com/
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > Tested-by: David Howells <dhowells@redhat.com>
> > > cc: Edward Adam Davis <eadavis@qq.com>
> > > cc: Simon Horman <horms@kernel.org>
> > > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > cc: Jeffrey E Altman <jaltman@auristor.com>
> > > cc: Wang Lei <wang840925@gmail.com>
> > > cc: Jeff Layton <jlayton@redhat.com>
> > > cc: Steve French <sfrench@us.ibm.com>
> > > cc: Marc Dionne <marc.dionne@auristor.com>
> > > cc: "David S. Miller" <davem@davemloft.net>
> > > cc: Eric Dumazet <edumazet@google.com>
> > > cc: Jakub Kicinski <kuba@kernel.org>
> > > cc: Paolo Abeni <pabeni@redhat.com>
> > > cc: linux-afs@lists.infradead.org
> > > cc: linux-cifs@vger.kernel.org
> > > cc: linux-nfs@vger.kernel.org
> > > cc: ceph-devel@vger.kernel.org
> > > cc: keyrings@vger.kernel.org
> > > cc: netdev@vger.kernel.org
> > > ---
> > >  net/dns_resolver/dns_key.c |   19 +++++++++----------
> > >  1 file changed, 9 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> > > index 2a6d363763a2..f18ca02aa95a 100644
> > > --- a/net/dns_resolver/dns_key.c
> > > +++ b/net/dns_resolver/dns_key.c
> > > @@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
> > >  static int
> > >  dns_resolver_preparse(struct key_preparsed_payload *prep)
> > >  {
> > > -	const struct dns_server_list_v1_header *v1;
> > > -	const struct dns_payload_header *bin;
> > >  	struct user_key_payload *upayload;
> > >  	unsigned long derrno;
> > >  	int ret;
> > > @@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
> > >  		return -EINVAL;
> > >
> > >  	if (data[0] == 0) {
> > > +		const struct dns_server_list_v1_header *v1;
> > > +
> > >  		/* It may be a server list. */
> > > -		if (datalen <= sizeof(*bin))
> > > +		if (datalen <= sizeof(*v1))
> > >  			return -EINVAL;
> > >
> > > -		bin = (const struct dns_payload_header *)data;
> > > -		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
> > > -		if (bin->content != DNS_PAYLOAD_IS_SERVER_LIST) {
> > > +		v1 = (const struct dns_server_list_v1_header *)data;
> > > +		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
> > > +		if (v1->hdr.content != DNS_PAYLOAD_IS_SERVER_LIST) {
> > >  			pr_warn_ratelimited(
> > >  				"dns_resolver: Unsupported content type (%u)\n",
> > > -				bin->content);
> > > +				v1->hdr.content);
> > >  			return -EINVAL;
> > >  		}
> > >
> > > -		if (bin->version != 1) {
> > > +		if (v1->hdr.version != 1) {
> > >  			pr_warn_ratelimited(
> > >  				"dns_resolver: Unsupported server list version (%u)\n",
> > > -				bin->version);
> > > +				v1->hdr.version);
> > >  			return -EINVAL;
> > >  		}
> > >
> > > -		v1 = (const struct dns_server_list_v1_header *)bin;
> > >  		if ((v1->status != DNS_LOOKUP_GOOD &&
> > >  		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
> > >  			if (prep->expiry == TIME64_MAX)
> > >
> > 
> > Hi Edward and kernel experts,
> > 
> >   Above patch(upstream commit: 1997b3cb4217b09) seems causing a keyctl05 case
> > to fail in LTP:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/keyctl/keyctl05.c
> > 
> > It could be reproduced on a bare metal platform.
> > Kconfig: https://raw.githubusercontent.com/xupengfe/kconfig_diff/main/config_v6.7-rc8
> > Seems general kconfig could reproduce this issue.
> > 
> >   Bisected info between v6.7-rc7(keyctl05 passed) and v6.7-rc8(keyctl05 failed)
> > is in attached.
> > 
> > keyctl05 failed in add_key with type "dns_resolver" syscall step tracked
> > by strace:
> > "
> > [pid 863107] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
> > [pid 863106] <... alarm resumed>)       = 30
> > [pid 863107] <... add_key resumed>)     = -1 EINVAL (Invalid argument)
> The reason for the failure of add_key() is that the length of the incoming data
> is 5, which is less than sizeof(*v1), so keyctl05.c failed.
> Suggest modifying keyctl05.c to increase the length of the incoming data to 6 
> bytes or more.

Thanks for your suggestion!
dns_server_list_v1_header struct is 6 u8 data instead of previous bin.

After increased the dns_res_payload to 7 bytes(6 bytes was still failed),
keyctl05 could be passed.
"
static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00, 0x00 };
"

I will improve the case in LTP.

Thanks!

> > "
> > 
> > Passed behavior in v6.7-rc7 kernel:
> > "
> > [pid  6726] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
> > [pid  6725] rt_sigreturn({mask=[]})     = 61
> > [pid  6726] <... add_key resumed>)      = 1029222644
> > "
> > 
> > Do you mind to take a look for above issue?
> Edward,
> BR
> 

