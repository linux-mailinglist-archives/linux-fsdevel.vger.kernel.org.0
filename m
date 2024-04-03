Return-Path: <linux-fsdevel+bounces-15996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B3896776
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 10:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE45A1C22DE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835AF6DD0D;
	Wed,  3 Apr 2024 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQDHzKMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8766BB33;
	Wed,  3 Apr 2024 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131270; cv=fail; b=WI+s+bFEZkVkJqW3xVl0hxFAch1//VENZAD/BlYADG+GZuXGeQrkW/uAUnJNH2vpUvAK7xwrXOwkRc+cEHmkq9hPAPAL4rdDm+k7MMLQdlK/otThIjQBcE07gOOpaOZ7OzAToc85AA9rEXIfNNu/sG97KJ8zjt4w8y9pbugNSKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131270; c=relaxed/simple;
	bh=B6aW2m3suj5r8CLQETDdjpxvtFw9uZsz4Ko6Va+/NY0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gEQHC2Ohb2y0OhTKWKeml2Y2C4DuI29GsPCE3XDbnJTc+TJn2TMklvWahx9noFSIG81FLNgKP5V9DfibaQyYCSPxZy4wQUsFNd1zRLf6pFPFoc8ll5onGA1VSEY7DD38J4d06VTvAU4pya41dtRykjTnMAl6Dufx238+YIr9Q1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQDHzKMQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712131267; x=1743667267;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B6aW2m3suj5r8CLQETDdjpxvtFw9uZsz4Ko6Va+/NY0=;
  b=MQDHzKMQrZEXGu1DaDN67C6I+5k/MeO+SHvYHkqOVPanWwP93RXN/wx+
   SFTuI1ts2su9OLDxQT6RpK1pP87Vyy+iMNdQmhSJdtFlw9nSfeDtWGfME
   N6tySLR0dzZxdjXYgYNvYoAd2kW2xhwSDRxPJ5qVj9pHxOsGBECfo94Cl
   Skr4fusVl2Zs4wANmHwvLSHLornNvLfbieWgVUSdj9BnNKX2QIo0ggIiR
   NBCgDfjqcHognekFTvpt2KnjFNDDaxcMfBR+T6x6qjjHNtAgYbQakvgRw
   /cgJUXOhiBgZAd+/MZK6i2/KT/zdSQnsGDUvbpSu3jAq/MnrVKpmHvH7j
   w==;
X-CSE-ConnectionGUID: Sy4sjRddSD6oFCLYdDdGcg==
X-CSE-MsgGUID: HDECfK4iQj+9NP4hkNJ8mw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7534847"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7534847"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:01:07 -0700
X-CSE-ConnectionGUID: NrQXkVFwTjS7boLkWlf7GQ==
X-CSE-MsgGUID: JTg23pahSri4zqD4lDY/1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22833249"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 01:01:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 01:01:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 01:01:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 01:01:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 01:01:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYn+zQQlZtmZEjd3ShGlSP1Oj+7jK7oiFL9eQOI5Z3vIRqXzD8phnwYD+ad0bUVccSnMMR4cwJ+gNnrL22Zyp4Wl/yfE62QU7rux1FgEc1fER/NVe0AQVibs+tKEfMwc3l3290e92F1KX+SHAPNNVpbzIeDxFIo0FttAHnKKNU50/wIWKSzhOYEiEB5PGOrpLTFL1UGVjJupUSQKwBO6NVOvlknC2e7IJaKzozIe+J5MRAAGj2wKboUV/07Hb/YR2L1KPmTvvWCAKp8zyssW5bzqc3OFllO0UEasNw/Vx+Lgj1UkDKD4LontmWrnkYulzdI6zyrqVwKB2HXllPghOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y39fixUKL/TGNvdeUYI8oe4DAKzQ7/1yxXHSNdtOVvY=;
 b=RmqWOQ7Kttwf7mAE07yH9oqgewJQiF8xnQb0YYDNrm7naqndzuJ8C1hwOPj6Gopy/4nGiiuh6QbsPAOYf3ePinRPeReGJ6zELd/bisxf04lZTrnGwn1D0JKz/sUkvez4yaSeVZrqtZNBkcpu16pnZeYbrBghKlKDpjUN+mKO1MAe81tRvRiy/CEaBK1alGQckKFFuRhvIoNKsxuGMmKKa6rzRRQN1MCQCsKMNAoBz9ozbvpclc1kUjmbfI8eoIUQSYFFWOnBpbGmXOFFkV3HCz5bhSXChe+qsPl4pT9qx0CNksxj/5oMO4iylOgVvQVb+N8ci/gNOkkKqVjiP+/Hvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB6294.namprd11.prod.outlook.com (2603:10b6:8:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 3 Apr
 2024 08:00:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 08:00:58 +0000
Date: Wed, 3 Apr 2024 16:00:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [fs]  1b43c46297: kernel_BUG_at_mm/usercopy.c
Message-ID: <202404031550.f3de0571-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB6294:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOkLxdznm7Y6INCiYcW0V313QlU+ZlHY6qIqQr/vV2SNa9BoWBPDaP9y0N3OGm4PXoizijcsaMf+Ia7Uge5JV4JdyiCe8ICfkzVhC8FUZGyNb6/CHz2jq6HQg1O1bmzeBRVX6pBHgClH8kcaVjssaP82neQPNhih2ks+1okpjC9wtdfgxP7RCpoWGKtsHW2ua4n3q5a5dIDCsF0FtSnrJNY1tJUykGmCM55zmvVPAOU/ubQSBpsEDcb44Ig4pgwdwd/weJ02qpuACnbrgvtmtwVuGrt6d2CzhyQ0xjcnNuyN5Pb4jxUCQ2CHaFnubQuNwrXhtXStJ7af4/S+dDYSe4Cw3kAzKF1niY2soLTLHNzmx9oA4Q6jt6Dfsc1wqCwHACfktphR68Qa92an3A+rF75+xKDjcW736ig+Uw3mO22YFJZUHpGtXNkrcIy+j1fLghRB8iZQIdKk4P4iM0vn1VQAWfg8FdHfX+5Vc+XmPKf4bqaQbrjELxEwXYM+Vc3GZO4mAA0lFKoaUwr5PRzBVKxH6663ilMHhxVNzIw5RZc7uK2VhLGZtQiDKncLjNKZfjtzBJcd4feT1zHSpusjBOYITUhwWHxTqHSlEt+VdloJqGDUlalIXO70Hu/769DN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SjeAbus5njXTL40Czre2WnNJITPV+hLE3Nu9a/SCUzNSK9zsvpruHnP5aiXv?=
 =?us-ascii?Q?JLC6vCQUzAaSYXm/yt9/N9sWD3qomNiDJ+YKRWearB3h0lmXK2IGO5wog8TD?=
 =?us-ascii?Q?T+7zpA9WwSq9RDrkFH3Cq57SexQlWXJgV/8NfCYUL/UMauNC0yNi7prr7f+F?=
 =?us-ascii?Q?vDXaIX327xcMk0Xwy+eW9yssoOSbiZme2FDbES/9/zK10XXUs8qQlWYSUzz4?=
 =?us-ascii?Q?mhZUz/UMqg0OjEaVNv3wLE+uVkJBZ37Xv6J9wnNEpwdvJSvliN+qQ+wz96KR?=
 =?us-ascii?Q?ct2BuAF71HyE/a4Mp6CmXirLgYmU6qGmdTmAHETfTbyxmW1F0g+f9yUxrLbN?=
 =?us-ascii?Q?p4+uW8e8IiBezSJlsxDC8rjx3rQbO+uojyJXCNW+MxMYm4neZTDJ78YPKRwO?=
 =?us-ascii?Q?HPxUYBokJS1myzULWwkddZ18YqXAbwsDuCSDIc3+Pxyxrxyf6LTxwPxKV3iI?=
 =?us-ascii?Q?692ipAFf+uaqpjUm0iEwQJHJQWVgG80PxBRYiapIHHW+gc+mgbIsgzAULMCy?=
 =?us-ascii?Q?vP2+lj0kqHt7XQJ29ukYu7gunGtUweSuf1AiM0x96O3o46ZftoU2drUceFLb?=
 =?us-ascii?Q?xuk3vX2sI7x+clUBvsnTD8FcrFUqOmUQ58zZBIxh0HWfD+NyPxdV2zar0wrq?=
 =?us-ascii?Q?D4TUKbWEx8uvH7QjC4JYETPDi/TZiOyQsxOhUd4CPK04ozp4RiYSNG41+0S4?=
 =?us-ascii?Q?71LCOaR64wVbiZuocTxLhgYXs0JQoSKRVobc4a3clydZkcUTzzLBRlY3XGRy?=
 =?us-ascii?Q?6V5dj8afDMLWw0brvm9tzWIRSSSEaCI91gk2kmydV/OLqQpG2fSTD+7WLkGF?=
 =?us-ascii?Q?ftfCn6XDg17XQH8mdj/9Qja5EthIBJ7Qyo9Smwx6CZ4qftBzuGC1FvQ371cb?=
 =?us-ascii?Q?/Q068KKH2iea8UdEuxjmiIiJbrr0AFFiwPX48d1rpYOvtVPWcC2TtjKMcJhG?=
 =?us-ascii?Q?EAFiqFFCmvnrq+i680wMK8wSrRCK//mi6GoF+GutPqkkuG2najKtpeGJDfVs?=
 =?us-ascii?Q?E1qRS7aKneGoqH5lsKDpSbJSgA1DgcTZQdZYcnBsQUJsFUz/ixdhWnNd0/pi?=
 =?us-ascii?Q?cS9XVrBP+yT+GqlhqV1TkW0HtVLeHBJTPKnXcENjdipL7PXe2vaAYLxRIJDg?=
 =?us-ascii?Q?XszkiD/GZvxP0sOYH1uBsq+O8orRr/TcTaZgFonCCp+Je0FJtE/d4EmIdQCV?=
 =?us-ascii?Q?lY8tPnu3CVgS/81MLNflwQzbxjpUS+Zguus+VenHRB8mBJkFxgBtWLdzlGno?=
 =?us-ascii?Q?kYb19lvFp+DsDKhUGrN685lqzOLIISfZwcoOsTcMeJdCI1td89+7fR50Zqyi?=
 =?us-ascii?Q?byNhAHF03Gf3Sse9/v1PKNxD17Zf+azCh3z/XEfu2un5MqqkG5Z0UeTMXpNf?=
 =?us-ascii?Q?qMNkFE5MsqHrMheEdhAcqLr4Q2/okunztgS2+iklq+ZAz49YMg543tAD1qvg?=
 =?us-ascii?Q?6KNF79OgLRR1zXNgS5x5Kldvo04Ave52Cng9Wd/+6kkTDPaliS54geldf5KG?=
 =?us-ascii?Q?Q0JWub21fYhMsdvbNs12qTf43n1p86ZNdiiRViq4jaQ66GgjxMMQ26pBcFBB?=
 =?us-ascii?Q?yVC8kVZ5fIhXYzexKBMQuGvGlwVMbrGAJ5VQ1LJwYpvh3y8OgxBOvnCyPRJw?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a65447dd-2e3b-4c0e-0b6e-08dc53b43273
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 08:00:58.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwYILXRgZMdR0Tgg+4YpGweqptl4YrpKUhtVktxaVzKSUhxEtgI7nZ8KwPwS/9U+9ciKqXjPPl6sNJl80xAelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6294
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_mm/usercopy.c" on:

commit: 1b43c4629756a2c4bbbe4170eea1cc869fd8cb91 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 727900b675b749c40ba1f6669c7ae5eb7eb8e837]

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------+------------+------------+
|                                                        | 16634c0975 | 1b43c46297 |
+--------------------------------------------------------+------------+------------+
| kernel_BUG_at_mm/usercopy.c                            | 0          | 11         |
| invalid_opcode:#[##]                                   | 0          | 11         |
| EIP:usercopy_abort                                     | 0          | 11         |
| Kernel_panic-not_syncing:Fatal_exception               | 0          | 11         |
+--------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404031550.f3de0571-lkp@intel.com


[   69.665215][ T3725] ------------[ cut here ]------------
[   69.665740][ T3725] kernel BUG at mm/usercopy.c:102!
[   69.666181][ T3725] invalid opcode: 0000 [#1] PREEMPT SMP
[   69.666687][ T3725] CPU: 1 PID: 3725 Comm: trinity-c2 Tainted: G S      W        N 6.9.0-rc1-00016-g1b43c4629756 #1
[   69.667623][ T3725] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 69.668555][ T3725] EIP: usercopy_abort (mm/usercopy.c:102 (discriminator 24)) 
[ 69.669040][ T3725] Code: d6 db c2 b9 f0 17 dd c2 eb 0a bf 57 5f e4 c2 b9 11 7f eb c2 ff 75 0c ff 75 08 56 52 53 50 57 51 68 f9 17 dd c2 e8 d3 a5 e9 ff <0f> 0b b8 ec 7a 4c c3 83 c4 24 e8 e4 72 3f 00 55 89 e5 57 56 89 d7
All code
========
   0:	d6                   	(bad)
   1:	db c2                	fcmovnb %st(2),%st
   3:	b9 f0 17 dd c2       	mov    $0xc2dd17f0,%ecx
   8:	eb 0a                	jmp    0x14
   a:	bf 57 5f e4 c2       	mov    $0xc2e45f57,%edi
   f:	b9 11 7f eb c2       	mov    $0xc2eb7f11,%ecx
  14:	ff 75 0c             	push   0xc(%rbp)
  17:	ff 75 08             	push   0x8(%rbp)
  1a:	56                   	push   %rsi
  1b:	52                   	push   %rdx
  1c:	53                   	push   %rbx
  1d:	50                   	push   %rax
  1e:	57                   	push   %rdi
  1f:	51                   	push   %rcx
  20:	68 f9 17 dd c2       	push   $0xffffffffc2dd17f9
  25:	e8 d3 a5 e9 ff       	call   0xffffffffffe9a5fd
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 ec 7a 4c c3       	mov    $0xc34c7aec,%eax
  31:	83 c4 24             	add    $0x24,%esp
  34:	e8 e4 72 3f 00       	call   0x3f731d
  39:	55                   	push   %rbp
  3a:	89 e5                	mov    %esp,%ebp
  3c:	57                   	push   %rdi
  3d:	56                   	push   %rsi
  3e:	89 d7                	mov    %edx,%edi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 ec 7a 4c c3       	mov    $0xc34c7aec,%eax
   7:	83 c4 24             	add    $0x24,%esp
   a:	e8 e4 72 3f 00       	call   0x3f72f3
   f:	55                   	push   %rbp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %rdi
  13:	56                   	push   %rsi
  14:	89 d7                	mov    %edx,%edi
[   69.670705][ T3725] EAX: 00000062 EBX: c2dd17e3 ECX: 00000001 EDX: 80000001
[   69.671364][ T3725] ESI: c2dd17e4 EDI: c2e45f57 EBP: c8611efc ESP: c8611ecc
[   69.671998][ T3725] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010286
[   69.672652][ T3725] CR0: 80050033 CR2: 08acb828 CR3: 157c1000 CR4: 00040690
[   69.673240][ T3725] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   69.673814][ T3725] DR6: fffe0ff0 DR7: 00000400
[   69.674206][ T3725] Call Trace:
[ 69.674480][ T3725] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 69.674859][ T3725] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 69.675236][ T3725] ? __die (arch/x86/kernel/dumpstack.c:435) 
[ 69.675579][ T3725] ? die (arch/x86/kernel/dumpstack.c:449) 
[ 69.675904][ T3725] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
[ 69.676276][ T3725] ? do_error_trap (arch/x86/kernel/traps.c:176) 
[ 69.676677][ T3725] ? usercopy_abort (mm/usercopy.c:102 (discriminator 24)) 
[ 69.677071][ T3725] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 69.677440][ T3725] ? handle_invalid_op (arch/x86/kernel/traps.c:214) 
[ 69.677878][ T3725] ? usercopy_abort (mm/usercopy.c:102 (discriminator 24)) 
[ 69.678279][ T3725] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 69.678677][ T3725] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 69.679118][ T3725] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 69.679494][ T3725] ? usercopy_abort (mm/usercopy.c:102 (discriminator 24)) 
[ 69.679882][ T3725] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 69.680272][ T3725] ? usercopy_abort (mm/usercopy.c:102 (discriminator 24)) 
[ 69.680681][ T3725] __check_heap_object (mm/slub.c:5365) 
[ 69.681121][ T3725] check_heap_object (mm/usercopy.c:196) 
[ 69.681541][ T3725] __check_object_size (mm/usercopy.c:123 mm/usercopy.c:254) 
[ 69.681969][ T3725] handle_to_path (include/linux/uaccess.h:183 fs/fhandle.c:203) 
[ 69.682372][ T3725] __ia32_sys_open_by_handle_at (fs/fhandle.c:226 fs/fhandle.c:267 fs/fhandle.c:258 fs/fhandle.c:258) 
[ 69.682862][ T3725] do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:274) 
[ 69.683288][ T3725] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   69.683697][ T3725] EIP: 0x80a3392
[ 69.684006][ T3725] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 c8 a9 ac 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 f0 a9 ac 08 85
All code
========
   0:	89 c8                	mov    %ecx,%eax
   2:	c3                   	ret
   3:	90                   	nop
   4:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
   8:	85 c0                	test   %eax,%eax
   a:	c7 01 01 00 00 00    	movl   $0x1,(%rcx)
  10:	75 d8                	jne    0xffffffffffffffea
  12:	a1 c8 a9 ac 08 eb d1 	movabs 0x9066d1eb08aca9c8,%eax
  19:	66 90 
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	66 90                	xchg   %ax,%ax
  21:	66 90                	xchg   %ax,%ax
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	90                   	nop
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
  38:	8b 10                	mov    (%rax),%edx
  3a:	a3                   	.byte 0xa3
  3b:	f0                   	lock
  3c:	a9                   	.byte 0xa9
  3d:	ac                   	lods   %ds:(%rsi),%al
  3e:	08                   	.byte 0x8
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
   e:	8b 10                	mov    (%rax),%edx
  10:	a3                   	.byte 0xa3
  11:	f0                   	lock
  12:	a9                   	.byte 0xa9
  13:	ac                   	lods   %ds:(%rsi),%al
  14:	08                   	.byte 0x8
  15:	85                   	.byte 0x85


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240403/202404031550.f3de0571-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


