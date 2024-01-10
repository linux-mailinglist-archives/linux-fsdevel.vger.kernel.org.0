Return-Path: <linux-fsdevel+bounces-7677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8730829316
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 05:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B27CB22FF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 04:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCB5D52B;
	Wed, 10 Jan 2024 04:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atez4umz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B60D50F;
	Wed, 10 Jan 2024 04:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704861984; x=1736397984;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d1Fu6ejuOIa1efTFjB/fpgA13D7hwwuU7Bgpuu4PqaA=;
  b=atez4umzmjiv1BI0dv8RqgId2+UNNVoAtUSJ91Nm384cqPe8JXDEqs0l
   L5x13hZznge1+kBZvygqnn+R54TV//S3dAnmME8rg9xvtlqoUyZCCXE8i
   80ZMZaxW8Q8P5LjEfsohSwzgDzQd8HsjO3Ca3V0roBS24vYz+2vlqTSxe
   ecibefogVcKbrSRh0H4KjEl5/F82A9WhNv/b0RgGF1Cy84zMbDnpjeD8F
   gEXnMQGcDegaeV0bYhcbaVtafzm+exovOBvFaJT38IMMyoe+Zpk7ss6lX
   Al2RZbftOQsj5YLhWUdxb7jGcohPHHAZJphKM4TsO9y5DsNeKVyDbDowS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11893220"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="log'?scan'208";a="11893220"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 20:46:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="901005864"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="log'?scan'208";a="901005864"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 20:46:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 20:46:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 20:46:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 20:46:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkzcZmAuDEhUrxSt78duhZq1jNTlsPKqbaMWAltRPeLn8myWxj7etFZChfkgNFKL99cVrpgnzW66VH88ONNQp+j+OFEXU142q8TeAPhCHjAtij4Zx33MMB0cLar953UQuHyUFvASW6MBAoF1rBYl8wEUuLB8SX7RkSvPK/P/mDZDlqecByNckureq+KF9TOB7+HLMI2GpOiNZzRvH8xF4TZ/1GohjhWcBjDmKwiQjtaJJNgh6OrrgPVVT6qZZAqOlP5cKP+0n99DZiom9ClPR8/9iESCVcfv89qlxGiJ4xaKIwN8vs3U632rnG5U1aY+WKNOOGvRehm5cRc/ATdYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=If0f+te31vXcNHzORjCQTe7+LdVlJc7CcONuSoU3Mxs=;
 b=KHJeDKWhtWV5wioNh3JaoCudOI4ZtmK2dXLW4oA7OOkUqoRwtZtyVrlmDD0253bm9YQ9+zKcUB6C46IAZFjvsxkpYVtOoUU8WvgwoJdfNzCc5W89ybiGJHLBZkwIIbu4hfLOsjpSc2BGXabLiClMYjjfOvpcds753/TGb/VfZQXvPcybSgAI5TozcLyhbcxMzOkiBhVBSrwnIu1GUzyPz1bgBMEdVSFtR336pi8rz0kTTYqprtsaM8jpo+NvSrCycnlqpR5O5PwTHh+tgLkumfIVGf5Qzli9zpSrvO+6nyrFCCLtjMIpZIDSamf93e5ZubE0NhBvQ3RXPyG+O70iWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA1PR11MB6710.namprd11.prod.outlook.com (2603:10b6:806:25a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 04:46:17 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 04:46:17 +0000
Date: Wed, 10 Jan 2024 12:40:41 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: David Howells <dhowells@redhat.com>, <eadavis@qq.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Edward Adam Davis
	<eadavis@qq.com>, Simon Horman <horms@kernel.org>, Markus Suvanto
	<markus.suvanto@gmail.com>, Jeffrey E Altman <jaltman@auristor.com>, "Marc
 Dionne" <marc.dionne@auristor.com>, Wang Lei <wang840925@gmail.com>, "Jeff
 Layton" <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-afs@lists.infradead.org>,
	<keyrings@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <heng.su@intel.com>, <pengfei.xu@intel.com>
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list
 header
Message-ID: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com>
References: <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com>
 <1843374.1703172614@warthog.procyon.org.uk>
 <20231223172858.GI201037@kernel.org>
 <2592945.1703376169@warthog.procyon.org.uk>
Content-Type: multipart/mixed; boundary="CKlVRO8OFc+GHLsw"
Content-Disposition: inline
In-Reply-To: <2592945.1703376169@warthog.procyon.org.uk>
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA1PR11MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: edd75696-ccdd-4b55-2651-08dc119714e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hil1b5yxIhmt2nQbjZTNrot1KH4gz7rBsjCE8nBsctJikl/s3ZdMd0vsMEaOMP8Nvu4Sj3kOyztFq7aQYtwhZL1ZYaI1Qwjuw9Bg40b5UoPFfaIc8Cf8xNVb/4qHN/fzV+dy5gPg++0EAdpP0k05e7rO24Z6GVQb028mPXwfLxXIR4AhFN3879+/nAf0+z35fa1BE2VRlHuw342TOa40ucCp2yKNXUMEDa0jiVRh5haE6BYSpZFed2izE4MjhAokPgUuKTjxaVPVdkZcvkQ1A1hSaUdKQEtN3msVy0goM1Tg375BqoNE5QxfpVC33YebhTtJdSrdvXmpc6ZAlA5sDEazqdwc6V3DIcgbEVEPu2JXCxvEMCIVLD+SJLSpXk0ZopH0Tmy/Vlkqny7k2QlJqWrFE+0EAa5Ta39CCF4ZrcQFMFnNF1UtAM3g8Y9nQQpClfk2l7mD4UNHo8KMg6GNhye5FaRvmCH6hDZ1q6wIQJQXSNDizChxnSgN3hQtE6EVAI1TzZMNTWG5RYT3uTiW9b2xY7v5uzpfrZxhnHaP10AO81HgBjZAC4SBr3le7rJ5TZCOGal9TDV+wZeyOjdvoyBe4cUeGo+E3sLsvH4gIu755CkiJvsv5TsVIpTbNyRN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6506007)(53546011)(966005)(6486002)(478600001)(26005)(44144004)(6666004)(6512007)(21480400003)(2906002)(107886003)(83380400001)(235185007)(66946007)(5660300002)(7416002)(41300700001)(4326008)(54906003)(4001150100001)(316002)(44832011)(8676002)(66556008)(8936002)(66476007)(82960400001)(86362001)(38100700002)(66899024)(2700100001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yMwpjSqCy1UOQ6NprMf4CYU/hCkNhTayaq1PAH8wGJJZUOQdN9JSdIxRN5P7?=
 =?us-ascii?Q?Wo0VLbKbhHyUoHPkSUjSHBWj6lQiqsglwlUnrr+8isOYtyheQqQ//NwTOvmD?=
 =?us-ascii?Q?XEoRC/vWKx9NRTK9Y3tW+IkBgQ2eOdeplL/4aPj1q40GiD/V+Jh4QJfzWQHB?=
 =?us-ascii?Q?hSPRf2BoYKXrbkjP4EELFg5tPiIh/8clTSR2ipMKRpCrKLzMhtq98Bo5/Gum?=
 =?us-ascii?Q?ivbX3SbOzf0sxspAJ5+tsj/a2jwflXa0uScK90B6fcy7HgEqCM1NGsRb6Dzt?=
 =?us-ascii?Q?ekf1L5lka+IL+OkXuCqT/hFwqmvJ2HAIJhiq5kLluOBCYG5Fq/xQjm+JRT+x?=
 =?us-ascii?Q?WXi2HE8LrnYzzI1jkD7py4ylXwjz84KwtK5ouyQfFGlpwVcc4cCZT+MqkCzB?=
 =?us-ascii?Q?CHANgWTWTzlUWQxcdrphGmZ+hc08/k44rzGAjsnropbIQyTrcfH1z+K/xbl9?=
 =?us-ascii?Q?fuBJCmmGZyp4H8XjR+ekkUbd+y2ngwfTYV+X0No38KL/UZy2BluwM8dbq2Q8?=
 =?us-ascii?Q?QZOBMEzMiGmPU9sM/yhDG29/mbX0v2rYTpRQQI2mYlDXpAD0xHoedUCsEl4+?=
 =?us-ascii?Q?8qBqzidMuT6Fv2CW2PX+hwcokwokZuoBXQnowAB1bqTaKMfNm2Bk/Q6rPmp/?=
 =?us-ascii?Q?AxoNGt2lLKPZIa3vj8dEU8nj7QvoqXDd6KdjHFZOMto0BzSnrm6XN/HaCt5i?=
 =?us-ascii?Q?KpPmN9/NWVUSvG4/Eo3bjpe9o7NugPusO46eLWohTR2/PCR0YMnaqT46tp/t?=
 =?us-ascii?Q?cbd5vMJbJg0OPDEvv4zsp3BjQUiGxNqcewib3oFZZqIOkCMV1/dGyRbILF0X?=
 =?us-ascii?Q?1BCPqcP/UDBKqoOEMoroVK/hnznC2+IZ1DCR3KqZkHN8RtIf5UcpG6RxVQso?=
 =?us-ascii?Q?QnlnZC+IfOWB71IjcmK+HdO25AH3ChJR0N75lPOSWG+gX12rDzFr3qEWTkdn?=
 =?us-ascii?Q?hvemrTkMvSSogZpIsR3h2Gn7o3LAa8ZuPTXuXIa/R1fYXZ2H26xCD0T63d6g?=
 =?us-ascii?Q?DhcQ9ZaK/TgP4WQqIysj8hd5+SYCLzJVrU0GEd+iHIyWK6gNhBoZrNPnfqbE?=
 =?us-ascii?Q?IwWbaiXAzGyfPuPfNMAogr5ZkstpNOCqdWrLUawAorcnUyFamBQrnD3qcRAc?=
 =?us-ascii?Q?2DPC/C0/WOFVvoaWsVuFbRcsx/5KkBDvT38JBSjaBLU9kiqzzy+p3zLS6yzA?=
 =?us-ascii?Q?dM6uWDbeVWB7TSMX8qmZ4r9gGM3QfbOlNiANjUUUxWUhtDwO7/NVQ1t+YSFJ?=
 =?us-ascii?Q?6vCvyz3yzlkeNYjiO/dwUSq8SuYwEWfVVJA1e3GAyvh7r/s1Afm7JuvqP74D?=
 =?us-ascii?Q?HsvotqAU7EKXkib1umHNQqZ6aUfi6t1oaunyU4olgceyOz0R2MAjhrK2eNdx?=
 =?us-ascii?Q?35ixSrtfKdUkEpKWFQPhHgSZo6SnQgN+jBwOyrrrIz8HmBlQIbH7hBO4DnGh?=
 =?us-ascii?Q?g7Xx8BBBt+Itva5nfVgzJ4U27Rq0D5kpjBHlgx48f+spiEyeylHuB4zONyee?=
 =?us-ascii?Q?2smQSKhm3VcJWhhXIQe9vjvohKU/LTsKhOUJDj08NPAnv2KSL7OUaQ5Ffyir?=
 =?us-ascii?Q?EWKqu3dFoDlDCysvLdCBUSDeSwPEvm8DtpWu/kG/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edd75696-ccdd-4b55-2651-08dc119714e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 04:46:16.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBY+9OO6KgMPYR5vVTGQXAEZR2fPvTR/9ZLud2kyzM6k4j7xAlL4s1fWVxZu+uSbnlOqcJRPhtAIttwnIHAv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6710
X-OriginatorOrg: intel.com

--CKlVRO8OFc+GHLsw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 2023-12-24 at 00:02:49 +0000, David Howells wrote:
> Hi Linus, Edward,
> 
> Here's Linus's patch dressed up with a commit message.  I would marginally
> prefer just to insert the missing size check, but I'm also fine with Linus's
> approach for now until we have different content types or newer versions.
> 
> Note that I'm not sure whether I should require Linus's S-o-b since he made
> modifications or whether I should use a Codeveloped-by line for him.
> 
> David
> ---
> From: Edward Adam Davis <eadavis@qq.com>
> 
> keys, dns: Fix missing size check of V1 server-list header
> 
> The dns_resolver_preparse() function has a check on the size of the payload
> for the basic header of the binary-style payload, but is missing a check
> for the size of the V1 server-list payload header after determining that's
> what we've been given.
> 
> Fix this by getting rid of the the pointer to the basic header and just
> assuming that we have a V1 server-list payload and moving the V1 server
> list pointer inside the if-statement.  Dealing with other types and
> versions can be left for when such have been defined.
> 
> This can be tested by doing the following with KASAN enabled:
> 
>         echo -n -e '\x0\x0\x1\x2' | keyctl padd dns_resolver foo @p
> 
> and produces an oops like the following:
> 
>         BUG: KASAN: slab-out-of-bounds in dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
>         Read of size 1 at addr ffff888028894084 by task syz-executor265/5069
>         ...
>         Call Trace:
>          <TASK>
>          __dump_stack lib/dump_stack.c:88 [inline]
>          dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>          print_address_description mm/kasan/report.c:377 [inline]
>          print_report+0xc3/0x620 mm/kasan/report.c:488
>          kasan_report+0xd9/0x110 mm/kasan/report.c:601
>          dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
>          __key_create_or_update+0x453/0xdf0 security/keys/key.c:842
>          key_create_or_update+0x42/0x50 security/keys/key.c:1007
>          __do_sys_add_key+0x29c/0x450 security/keys/keyctl.c:134
>          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>          do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>          entry_SYSCALL_64_after_hwframe+0x62/0x6a
> 
> This patch was originally by Edward Adam Davis, but was modified by Linus.
> 
> Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry")
> Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/0000000000009b39bc060c73e209@google.com/
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: David Howells <dhowells@redhat.com>
> cc: Edward Adam Davis <eadavis@qq.com>
> cc: Simon Horman <horms@kernel.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> cc: Jeffrey E Altman <jaltman@auristor.com>
> cc: Wang Lei <wang840925@gmail.com>
> cc: Jeff Layton <jlayton@redhat.com>
> cc: Steve French <sfrench@us.ibm.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-nfs@vger.kernel.org
> cc: ceph-devel@vger.kernel.org
> cc: keyrings@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>  net/dns_resolver/dns_key.c |   19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index 2a6d363763a2..f18ca02aa95a 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
>  static int
>  dns_resolver_preparse(struct key_preparsed_payload *prep)
>  {
> -	const struct dns_server_list_v1_header *v1;
> -	const struct dns_payload_header *bin;
>  	struct user_key_payload *upayload;
>  	unsigned long derrno;
>  	int ret;
> @@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>  		return -EINVAL;
>  
>  	if (data[0] == 0) {
> +		const struct dns_server_list_v1_header *v1;
> +
>  		/* It may be a server list. */
> -		if (datalen <= sizeof(*bin))
> +		if (datalen <= sizeof(*v1))
>  			return -EINVAL;
>  
> -		bin = (const struct dns_payload_header *)data;
> -		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
> -		if (bin->content != DNS_PAYLOAD_IS_SERVER_LIST) {
> +		v1 = (const struct dns_server_list_v1_header *)data;
> +		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
> +		if (v1->hdr.content != DNS_PAYLOAD_IS_SERVER_LIST) {
>  			pr_warn_ratelimited(
>  				"dns_resolver: Unsupported content type (%u)\n",
> -				bin->content);
> +				v1->hdr.content);
>  			return -EINVAL;
>  		}
>  
> -		if (bin->version != 1) {
> +		if (v1->hdr.version != 1) {
>  			pr_warn_ratelimited(
>  				"dns_resolver: Unsupported server list version (%u)\n",
> -				bin->version);
> +				v1->hdr.version);
>  			return -EINVAL;
>  		}
>  
> -		v1 = (const struct dns_server_list_v1_header *)bin;
>  		if ((v1->status != DNS_LOOKUP_GOOD &&
>  		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
>  			if (prep->expiry == TIME64_MAX)
> 

Hi Edward and kernel experts,

  Above patch(upstream commit: 1997b3cb4217b09) seems causing a keyctl05 case
to fail in LTP:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/keyctl/keyctl05.c

It could be reproduced on a bare metal platform.
Kconfig: https://raw.githubusercontent.com/xupengfe/kconfig_diff/main/config_v6.7-rc8
Seems general kconfig could reproduce this issue.

  Bisected info between v6.7-rc7(keyctl05 passed) and v6.7-rc8(keyctl05 failed)
is in attached.

keyctl05 failed in add_key with type "dns_resolver" syscall step tracked
by strace:
"
[pid 863107] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
[pid 863106] <... alarm resumed>)       = 30
[pid 863107] <... add_key resumed>)     = -1 EINVAL (Invalid argument)
"

Passed behavior in v6.7-rc7 kernel:
"
[pid  6726] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
[pid  6725] rt_sigreturn({mask=[]})     = 61
[pid  6726] <... add_key resumed>)      = 1029222644
"

Do you mind to take a look for above issue?

Best Regards,
Thanks!

--CKlVRO8OFc+GHLsw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="bisect.log"

git bisect start
# status: waiting for both good and bad commits
# good: [861deac3b092f37b2c5e6871732f3e11486f7082] Linux 6.7-rc7
git bisect good 861deac3b092f37b2c5e6871732f3e11486f7082
# status: waiting for bad commit, 1 good commit known
# bad: [610a9b8f49fbcf1100716370d3b5f6f884a2835a] Linux 6.7-rc8
git bisect bad 610a9b8f49fbcf1100716370d3b5f6f884a2835a
# good: [861deac3b092f37b2c5e6871732f3e11486f7082] Linux 6.7-rc7
git bisect good 861deac3b092f37b2c5e6871732f3e11486f7082
# bad: [505e701c0b2cfa9e34811020829759b7663a604c] Merge tag 'kbuild-fixes-v6.7-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect bad 505e701c0b2cfa9e34811020829759b7663a604c
# good: [1803d0c5ee1a3bbee23db2336e21add067824f02] mailmap: add an old address for Naoya Horiguchi
git bisect good 1803d0c5ee1a3bbee23db2336e21add067824f02
# bad: [eeec2599630ac1ac03db98f3ba976975c72a1427] Merge tag 'bcachefs-2023-12-27' of https://evilpiepirate.org/git/bcachefs
git bisect bad eeec2599630ac1ac03db98f3ba976975c72a1427
# bad: [f5837722ffecbbedf1b1dbab072a063565f0dad1] Merge tag 'mm-hotfixes-stable-2023-12-27-15-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad f5837722ffecbbedf1b1dbab072a063565f0dad1
# good: [b8e0792449928943c15d1af9f63816911d139267] virtio_blk: fix snprintf truncation compiler warning
git bisect good b8e0792449928943c15d1af9f63816911d139267
# bad: [1997b3cb4217b09e49659b634c94da47f0340409] keys, dns: Fix missing size check of V1 server-list header
git bisect bad 1997b3cb4217b09e49659b634c94da47f0340409
# good: [fbafc3e621c3f4ded43720fdb1d6ce1728ec664e] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
git bisect good fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
# first bad commit: [1997b3cb4217b09e49659b634c94da47f0340409] keys, dns: Fix missing size check of V1 server-list header

--CKlVRO8OFc+GHLsw--

