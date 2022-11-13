Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5C4626ECF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 10:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiKMJx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 04:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMJxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 04:53:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E234B1D2;
        Sun, 13 Nov 2022 01:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668333231; x=1699869231;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KtJBOFlj5HgtvkbW2sqt75hxRJ1xI0cxBzppk1UE2XI=;
  b=KyIXoGk5qdSIYKayPZFMWXs3YsIO/4c2swhck9/DJNA2QcIbVTgAyctF
   dIcRQzwAAh8qptf8JcUGq0gPyLLkGBQRdPTziv3snN4xvpZH1PlC9r3Ny
   xY4kGMZc61ZpvmncipzKPzpAUjVQIUxzM+G3v0BLRFdAGNqq+mFgekJO+
   mi6IIINXmqULJABCSDa2OfFWHGgdkfrdqvNUGwB9yTvHW2ckSPTJWTqZX
   5b0o04o+S/t3PpHXyi6ItPhp8G2Ru2z+xchoawRDveqHhytWBtmI0uAlM
   GVYtjDzuT86CR35wX1qzxHTKeEYrJXJXyUI5rVGGmegZmIdTQTRER9olf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="313599813"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="xz'?scan'208";a="313599813"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 01:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="967234172"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="xz'?scan'208";a="967234172"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2022 01:53:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 01:53:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 01:53:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 13 Nov 2022 01:53:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 13 Nov 2022 01:53:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCbl5T6s+c8YtpYfhpQEePNmNwIR0iS/d5FPvosRnEU/tkrjQ0rjIt6Mm4atfoyPTEvNhsYTbid0Q0j+4/SEdvTUjB7BSyL3/XR13fopIcyLzgu4W9GrpFZQkcKoCHBKlLD5d8lFVJFi6ZlYh44zyhyW1e4hROqiN8ojUmwxVbnTWUJVUFgAP5w78nyaRT0cF6bdqxt52KMWA5skSYDa+4it/fIeG000DBkXEmo4nCXOBZjwuxojzPohdJdoL5x5sst9I4cKpj3FoZsHFO8L3P2JxoiXukjUN8Kiq6HYpaAhhlar73/i0Rfus/2pp281DRiX3Jur6wxyxDl6jK0bDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY8DI+E2TEdFbNk8WySKIX9KDmIr6zHLQqnSE02MxPw=;
 b=iwadnx0phdjtYf4a9TrPF3hcFwinG+/ZrD29LLv6aeqtzoiDM6rZjhvDYc4yH1qqWZDbryXwy0IzqgRloNYDzfikW1TloZTW8/huzLVR0hxHqp+AfILjoBah6IajlVR98hgTBJuLwb7vuH4CIvltGfeP2FNRwqfFEhc0LBKHKDutfWS2Q6sDTGLUrULaF2fRpf4q0PyMbzjqJJz9AGNIcNZ1mg5gUyeQOQuG2/Oz4oGLfeH3xv7ryTYqj7rL3bwe4EYC2CBkZ2JJpHILuxC5bv2teOlkd2eq6wu6ZOxcSOJHMyXsuocJLbaqJwub4YdWJBGIBHhbJ37SsluMJzuHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB6356.namprd11.prod.outlook.com (2603:10b6:510:1fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 09:53:38 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d%8]) with mapi id 15.20.5813.016; Sun, 13 Nov 2022
 09:53:38 +0000
Date:   Sun, 13 Nov 2022 17:51:45 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Colin Cross <ccross@google.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Liam Howlett <liam.howlett@oracle.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        Peter Xu <peterx@redhat.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Vlastimil Babka <vbabka@suse.cz>, xu xin <cgel.zte@gmail.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [linux-next:master] [mm] 2220e3a895:
 WARNING:at_include/linux/mmap_lock.h:#anon_vma_name
Message-ID: <202211131641.f1fe0711-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="OePuUIRYOIxsRX67"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0076.apcprd02.prod.outlook.com
 (2603:1096:4:90::16) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: df3c3d8d-091c-405e-96bd-08dac55ceeb9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4jwPMd3fLixSnQVWxjzVyDK9R9gDXHZuBSjlSr4WXOePskgsQrNp5KqmVurkWZ2/Gtjm0Qz2knTpVwAPj+lA15C6DMHK89/L8s8zZ35pi3FYrm7XSiX1lJ+IlQRhC07oVx+Eh+E+i9eOwaQI2q3pkAiX+qtTm+u5n3zhkmFGU/k2+YpyyqXKSgckHoC6G3stayE3LdrgXeeAdeirE3YLwmmOelE3nPioHhtgapvP6IO6iDm15WWX2G2xCiUF5gsLlf/Q8GL6Y/8Uq2PXJrCSrD+oFLKpuqiOshp3DNlCTn+PTObAn3E91gs/vPFPe4yDGVa9s1lVNzgG66XWhUdAaQS9UxsFi5QiWPCXQ5isPDf21D3e31WDt9G6BzIYUBqQ2h6QpaF8dxxmnxl2bkSctA+d7awXv2FCYBclcLyQaaGW3Qo14+VF6h4c+9ah23rcL1ny4aYRrGLdwpE7XpyanjW3MRMIhmYeIxqa6yGF2HwBRgwD2rEwQn6raG46v8OCnIzxE7uAfJORMOVl9ftMTUQxI7qWPJ47iDElT6Ca2jI/eHDmTP4BcCswFeDuM/NIXer7QxaaqFkbO+BD7FMrsdgC5rwjuvpDO3mKbqHGI3YefbbjUceY+6uGPc15ykiTPiTjFG8UWAonGdVr0TNkj9fYRUdu07mDqEjx5N4U21ZjZTfzuyq0ARYh9z0MwI3/SXwReuRyscL6ldwaqCFPOBUVj/1pwJVoBcqbXq/pn4mFluYzr6Z7MJPsDqbXhoFItBpk0O4Lf0/LRkmkwmd9clbrXHp9XFqOfhTLU+l6nqu2qlceLphbtXKveJ0FA3lNv7zpPvftMdHVyxGK56iXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(7416002)(36756003)(5660300002)(66476007)(8936002)(41300700001)(66946007)(235185007)(8676002)(2616005)(4326008)(66556008)(2906002)(6486002)(966005)(86362001)(478600001)(83380400001)(44144004)(54906003)(26005)(186003)(1076003)(6506007)(38100700002)(316002)(6512007)(82960400001)(45080400002)(6666004)(6916009)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DV0MfTLOMKtuu5azfsWzpmmc2taXRf9NOJutf1G9dkoyMQju1FlT3JucixPO?=
 =?us-ascii?Q?ftttnLeqflpl5yaIVYpfYm6jBCSOrFWgaJbXSetkzV6AARj0p/Dk4d49ZnRZ?=
 =?us-ascii?Q?maMMEKzvWMhPHQZhe63Z9b2TpVn9+2tlty817iMUYriQCWVdbetwdHhEu4Lq?=
 =?us-ascii?Q?8imrMkMYI6d61Ko7BvgGx+I+a/71dkLrO+E8Wx5xBO1l5LnssXfNvt38Vlpz?=
 =?us-ascii?Q?rtoeW5Ln3TxeOkQQGrAppKda0joOy9huKkv6gEMkFkGDzdCdVMXC9xBEQRu3?=
 =?us-ascii?Q?Cy3IkRS85hKPhpwuoGktqVYRt76xunGJYngi6iJ8Gr7p4TEVzPUZN2TsEYIB?=
 =?us-ascii?Q?D2qdX1NOmePAdSHz++NuXgGyHP2q8ib4smFPFqeroP48OiGxCqYlpA8e1kXL?=
 =?us-ascii?Q?oBOalKxTmLfkYp2KVqOGgskYHCa98ksSde2gEdlMfpss2AgcaslpxpHGpS4a?=
 =?us-ascii?Q?aOJ/ocTq5gVp9E4fTFzD5qYpJtaG+kkQkE2DZQY314m+Io9m1iuPq1KbetbR?=
 =?us-ascii?Q?pVvTghU4xPVnk1cIM1c+//LGVB9bYPRvBGJQkuv84w2ZhFFV8SnOb+J+e/u4?=
 =?us-ascii?Q?yyBGMt5cYRZ+T6syvwp7M05R/vcMXpD4IbQppK0pva6VIqeHwrf289I/bSpa?=
 =?us-ascii?Q?/XqqW6UMhqWohLpHe+TueTg0N+ZzQgLVXj9mVsMsLgeoiZ4ufWbJwd2mhSmd?=
 =?us-ascii?Q?wHyyKn4Ol86lmy9DYh1sAWbnnCOanLMSraQSRiqXRw6ZwMzu1x1imJa+ZwOX?=
 =?us-ascii?Q?GOlKrBatAReRn6E3g9AhglAaPXv+QsByM4wMBjZ+C2AUAk9uFEAtsAHaHn0g?=
 =?us-ascii?Q?/VcD61swKEDe7uySfKwrJyj12wktJ6YvlATN7fs4v87Y6nqLRpg3QqLt5nQA?=
 =?us-ascii?Q?ZeSKcpQf+zPh2ZRa+cT4MBEyxpyHLwvf8gsCswCBwZABoXbHuWRD7mLYNjPa?=
 =?us-ascii?Q?HHFa8ZD/9LeiaFIYcOhsjyEe01vOZN9mmZYhp08U9YvyQWGIlhtNFAlLSZ14?=
 =?us-ascii?Q?rYfF/+3K/qyyTrvD9rlaFkpKuykv1f2otdjXYLbB053ycgQIoD9/Av9Zmak0?=
 =?us-ascii?Q?eVKivbhSSggm0JKGbjJ3nclAKOCQx7roPyLwMjjrvLyaqdpdMtIKctqON9dD?=
 =?us-ascii?Q?rRiMK6ceIrFnHxrI4oSmqlF+LOq6BjoqPkGxhOEYhaETkFCJcmvoy/4P/Qqq?=
 =?us-ascii?Q?HyKjzLGXHUbgnRsHiRPjjOzEZOvc+PSXtirbsGy6srnUXTOb64X3BmTY9JFx?=
 =?us-ascii?Q?ZSUMsOQbSREC2/dwUISXk7x0d52UHFJGDCrpGOoid7YthBjvRxthpWM2LRQm?=
 =?us-ascii?Q?ei+EynZejHHYfMlzeuOaJTH5tLv4dJUOh/gY9jO9bsBDZfUfyMlAO09Lt6H3?=
 =?us-ascii?Q?rsX2B/luG3P+q4xvaHUJfaawjHizP4wGi2IcLg9dPgcLebNgCubTa0DS32B2?=
 =?us-ascii?Q?ev2SAn4BfP17DrSfxf1pUEv+zA2xwNcBHTZq5Pxee7/31r+8Jz6hThk9sm18?=
 =?us-ascii?Q?0sUSs2XpAh3A7E2xWm5iiI2X4AkSU1uy+VZV2QkdTibClAtdz62WeueGCi4D?=
 =?us-ascii?Q?whm86kSpcpoonIxK0EhCXY/c9uuVrL/T2/JWio/f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df3c3d8d-091c-405e-96bd-08dac55ceeb9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 09:53:37.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M22ixfVXPuBu3byf6z3JlrJR6Ta+5HfHo+feoZQYErmLByAYfBp06sTLLUtgysNmdWwX9Kxm6K+U9Dl737OQ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6356
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--OePuUIRYOIxsRX67
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed WARNING:at_include/linux/mmap_lock.h:#anon_vma_name due to commit (built with gcc-11):

commit: 2220e3a8953e86b87adfc753fc57c2a5e0b0a032 ("mm: anonymous shared memory naming")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master f8f60f322f0640c8edda2942ca5f84b7a27c417a]

in testcase: trinity
version: trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06
with following parameters:

	runtime: 300s
	group: group-04

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


[  128.700641][ T4161] ------------[ cut here ]------------
[ 128.701055][ T4161] WARNING: CPU: 0 PID: 4161 at include/linux/mmap_lock.h:155 anon_vma_name (??:?) 
[  128.701608][ T4161] Modules linked in:
[  128.701839][ T4161] CPU: 0 PID: 4161 Comm: trinity-c4 Tainted: G                T  6.1.0-rc4-00216-g2220e3a8953e #1 11f9472e0edad800f55c5824aae0f9f692ada352
[  128.702701][ T4161] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 128.703294][ T4161] RIP: 0010:anon_vma_name (??:?) 
[ 128.703602][ T4161] Code: c1 ea 03 80 3c 02 00 75 54 48 8b 83 88 00 00 00 5b 5d 41 5c c3 48 8d bd 70 06 00 00 be ff ff ff ff e8 27 35 12 02 85 c0 75 8a <0f> 0b eb 86 48 89 ef e8 57 49 f7 ff 0f 0b 48 c7 c7 2c 05 27 86 e8
All code
========
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   7:	75 54                	jne    0x5d
   9:	48 8b 83 88 00 00 00 	mov    0x88(%rbx),%rax
  10:	5b                   	pop    %rbx
  11:	5d                   	pop    %rbp
  12:	41 5c                	pop    %r12
  14:	c3                   	retq   
  15:	48 8d bd 70 06 00 00 	lea    0x670(%rbp),%rdi
  1c:	be ff ff ff ff       	mov    $0xffffffff,%esi
  21:	e8 27 35 12 02       	callq  0x212354d
  26:	85 c0                	test   %eax,%eax
  28:	75 8a                	jne    0xffffffffffffffb4
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb 86                	jmp    0xffffffffffffffb4
  2e:	48 89 ef             	mov    %rbp,%rdi
  31:	e8 57 49 f7 ff       	callq  0xfffffffffff7498d
  36:	0f 0b                	ud2    
  38:	48 c7 c7 2c 05 27 86 	mov    $0xffffffff8627052c,%rdi
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb 86                	jmp    0xffffffffffffff8a
   4:	48 89 ef             	mov    %rbp,%rdi
   7:	e8 57 49 f7 ff       	callq  0xfffffffffff74963
   c:	0f 0b                	ud2    
   e:	48 c7 c7 2c 05 27 86 	mov    $0xffffffff8627052c,%rdi
  15:	e8                   	.byte 0xe8
[  128.704711][ T4161] RSP: 0018:ffff8881330efa38 EFLAGS: 00010246
[  128.705067][ T4161] RAX: 0000000000000000 RBX: ffffffff84c82000 RCX: 0000000000000001
[  128.705525][ T4161] RDX: 0000000000000000 RSI: 0000000000000670 RDI: ffff88816cb7c9d0
[  128.705981][ T4161] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  128.706480][ T4161] R10: ffffffffff600000 R11: 0000000000000000 R12: ffffffff84c82040
[  128.706938][ T4161] R13: ffffffff84c82080 R14: ffffffff84c82010 R15: ffffffff84c82000
[  128.707392][ T4161] FS:  000000000109a880(0000) GS:ffff88839d400000(0000) knlGS:0000000000000000
[  128.707905][ T4161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  128.708284][ T4161] CR2: 00007f52e686184c CR3: 000000017e9bc000 CR4: 00000000000406b0
[  128.708741][ T4161] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  128.709196][ T4161] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  128.709652][ T4161] Call Trace:
[  128.709846][ T4161]  <TASK>
[ 128.710031][ T4161] show_map_vma (task_mmu.c:?) 
[ 128.710323][ T4161] show_map (task_mmu.c:?) 
[ 128.710725][ T4161] seq_read_iter (??:?) 
[ 128.711291][ T4161] ? lock_acquire (??:?) 
[ 128.711820][ T4161] seq_read (??:?) 
[ 128.712351][ T4161] ? seq_read_iter (??:?) 
[ 128.712941][ T4161] ? __might_fault (??:?) 
[ 128.713464][ T4161] do_loop_readv_writev+0xca/0x300 
[ 128.714126][ T4161] ? fsnotify_perm+0x134/0x4c0 
[ 128.714773][ T4161] do_iter_read (read_write.c:?) 
[ 128.715375][ T4161] vfs_readv (read_write.c:?) 
[ 128.715873][ T4161] ? vfs_iter_read (read_write.c:?) 
[ 128.716396][ T4161] ? find_held_lock (lockdep.c:?) 
[ 128.716981][ T4161] ? __ct_user_exit (??:?) 
[ 128.717558][ T4161] ? __lock_release (lockdep.c:?) 
[ 128.718136][ T4161] ? lock_downgrade (lockdep.c:?) 
[ 128.718745][ T4161] __x64_sys_preadv (??:?) 
[ 128.719033][ T4161] ? __x64_sys_preadv2 (??:?) 
[ 128.719338][ T4161] do_syscall_64 (??:?) 
[ 128.719599][ T4161] entry_SYSCALL_64_after_hwframe (??:?) 
[  128.719940][ T4161] RIP: 0033:0x463519
[ 128.720168][ T4161] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 59 00 00 c3 66 2e 0f 1f 84 00 00 00 00
All code
========
   0:	00 f3                	add    %dh,%bl
   2:	c3                   	retq   
   3:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   a:	00 00 00 
   d:	0f 1f 40 00          	nopl   0x0(%rax)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	0f 83 db 59 00 00    	jae    0x5a11
  36:	c3                   	retq   
  37:	66                   	data16
  38:	2e                   	cs
  39:	0f                   	.byte 0xf
  3a:	1f                   	(bad)  
  3b:	84 00                	test   %al,(%rax)
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	0f 83 db 59 00 00    	jae    0x59e7
   c:	c3                   	retq   
   d:	66                   	data16
   e:	2e                   	cs
   f:	0f                   	.byte 0xf
  10:	1f                   	(bad)  
  11:	84 00                	test   %al,(%rax)
  13:	00 00                	add    %al,(%rax)
	...
[  128.721265][ T4161] RSP: 002b:00007ffc45dc65f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
[  128.721745][ T4161] RAX: ffffffffffffffda RBX: 0000000000000127 RCX: 0000000000463519
[  128.722214][ T4161] RDX: 00000000000000ca RSI: 0000000001327030 RDI: 000000000000003e
[  128.722671][ T4161] RBP: 00007f52e5593000 R08: 0000001027180f8c R09: 0000000000000045
[  128.723126][ T4161] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[  128.723580][ T4161] R13: 00007f52e5593058 R14: 000000000109a850 R15: 00007f52e5593000
[  128.724048][ T4161]  </TASK>
[  128.724228][ T4161] irq event stamp: 39467
[ 128.724474][ T4161] hardirqs last enabled at (39475): __up_console_sem (printk.c:?) 
[ 128.725014][ T4161] hardirqs last disabled at (39482): __up_console_sem (printk.c:?) 
[ 128.725553][ T4161] softirqs last enabled at (39294): __do_softirq (??:?) 
[ 128.726090][ T4161] softirqs last disabled at (39281): __irq_exit_rcu (softirq.c:?) 
[  128.727013][ T4161] ---[ end trace 0000000000000000 ]---
[  128.727667][ T4161] ==================================================================


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202211131641.f1fe0711-yujie.liu@intel.com


To reproduce:

        # build kernel
	cd linux
	cp config-6.1.0-rc4-00216-g2220e3a8953e .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--OePuUIRYOIxsRX67
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc4-00216-g2220e3a8953e"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.1.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
CONFIG_CONTEXT_TRACKING_USER_FORCE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_CGROUP_FAVOR_DYNMODS=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_EMBED=y
CONFIG_BOOT_CONFIG_EMBED_FILE=""
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_GOLDFISH is not set
CONFIG_X86_INTEL_MID=y
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
# CONFIG_XEN_PVHVM_GUEST is not set
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
CONFIG_ACRN_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_SIG=y
CONFIG_KEXEC_SIG_FORCE=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
# CONFIG_SPECULATION_MITIGATIONS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_FPDT=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_EINJ=y
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_ACPI_DPTF=y
# CONFIG_DPTF_POWER is not set
CONFIG_DPTF_PCH_FIVR=y
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_CONFIGFS=y
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
# CONFIG_XPOWER_PMIC_OPREGION is not set
CONFIG_ACPI_VIOT=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_POWERNOW_K8 is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
# CONFIG_HALTPOLL_CPUIDLE is not set
# end of CPU Idle
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_XEN=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32_ABI is not set
# end of Binary Emulations

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
CONFIG_ZONE_DMA32=y
CONFIG_GET_FREE_REGION=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
# CONFIG_PTE_MARKER_UFFD_WP is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
# CONFIG_DAMON_PADDR is not set
CONFIG_DAMON_SYSFS=y
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
# CONFIG_EISA_PCI_EISA is not set
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=y
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
CONFIG_PCIEASPM_PERFORMANCE=y
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
CONFIG_CXL_PCI=y
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_ACPI=y
CONFIG_CXL_MEM=y
CONFIG_CXL_PORT=y
CONFIG_CXL_REGION=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
# CONFIG_YENTA_O2 is not set
# CONFIG_YENTA_RICOH is not set
CONFIG_YENTA_TI=y
# CONFIG_YENTA_ENE_TUNE is not set
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=y
# CONFIG_I82092 is not set
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_CPS_GEN2=y
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_PCI_GENERIC is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
# CONFIG_EFI_DXE_MEM_ATTRIBUTES is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
CONFIG_EFI_DISABLE_PCI_DMA=y
CONFIG_EFI_EARLYCON=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
# CONFIG_EFI_DISABLE_RUNTIME is not set
CONFIG_EFI_COCO_SECRET=y
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_GNSS_USB=y
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
# CONFIG_ECHO is not set
CONFIG_MISC_ALCOR_PCI=y
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_XEN_NETDEV_BACKEND is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_USB=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
# CONFIG_JOYSTICK_DB9 is not set
CONFIG_JOYSTICK_GAMECON=y
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_QWIIC=y
CONFIG_JOYSTICK_FSIA6B=y
CONFIG_JOYSTICK_SENSEHAT=y
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
CONFIG_TOUCHSCREEN_CY8CTMA140=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MSG2638=y
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_IMAGIS=y
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=y
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_STMFTS=y
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_APPLICOM=y

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C=y
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYUSB=y
# CONFIG_RANDOM_TRUST_CPU is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_CP2615=y
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
CONFIG_PINCTRL_DA9062=y
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_LYNXPOINT=y
# CONFIG_PINCTRL_MERRIFIELD is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=y
# CONFIG_PINCTRL_METEORLAKE is not set
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCA9570=y
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD9571MWV=y
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_MERRIFIELD is not set
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
CONFIG_IP5XXX_POWER=y
CONFIG_MAX8925_POWER=y
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9150=y
CONFIG_AXP288_CHARGER=y
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=y
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_BD99954=y
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=y
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_CORSAIR_CPRO=y
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_I8K=y
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
CONFIG_SENSORS_MAX6620=y
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_NZXT_KRAKEN2=y
CONFIG_SENSORS_NZXT_SMART2=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_WMI is not set
CONFIG_SENSORS_ASUS_EC=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
CONFIG_WDAT_WDT=y
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_MLX_WDT=y
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
CONFIG_TWL4030_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
CONFIG_ALIM1535_WDT=y
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=y
CONFIG_INTEL_MID_WATCHDOG=y
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
CONFIG_SC1200_WDT=y
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=y
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
CONFIG_NIC7018_WDT=y
CONFIG_SIEMENS_SIMATIC_IPC_WDT=y
CONFIG_MEN_A21_WDT=y
# CONFIG_XEN_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC_BXTWC is not set
CONFIG_INTEL_SOC_PMIC_MRFLD=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_PMC_BXT=y
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_RAVE_SP_CORE is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_ATC260X=y
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_MT6323=y
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
# CONFIG_REGULATOR_MT6358 is not set
CONFIG_REGULATOR_MT6359=y
CONFIG_REGULATOR_MT6360=y
# CONFIG_REGULATOR_MT6397 is not set
# CONFIG_REGULATOR_PALMAS is not set
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=y
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_RT5190A=y
CONFIG_REGULATOR_RT5759=y
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=y
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_RTQ6752=y
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TWL4030=y
# CONFIG_REGULATOR_WM8400 is not set
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
# CONFIG_BPF_LIRC_MODE2 is not set
CONFIG_LIRC=y
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
# CONFIG_IR_ENE is not set
CONFIG_IR_FINTEK=y
CONFIG_IR_IGORPLUGUSB=y
CONFIG_IR_IGUANA=y
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=y
CONFIG_IR_MCEUSB=y
CONFIG_IR_NUVOTON=y
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=y
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_STREAMZAP=y
CONFIG_IR_TOY=y
CONFIG_IR_TTUSBIR=y
CONFIG_IR_WINBOND_CIR=y
CONFIG_RC_ATI_REMOTE=y
CONFIG_RC_LOOPBACK=y
# CONFIG_RC_XBOX_DVD is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_RC=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=y
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
CONFIG_DRM_GMA500=y
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=y
CONFIG_DRM_CIRRUS_QEMU=y
CONFIG_DRM_GM12U320=y
CONFIG_DRM_SIMPLEDRM=y
# CONFIG_DRM_XEN_FRONTEND is not set
CONFIG_DRM_VBOXVIDEO=y
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_MAX8925 is not set
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_RT4831=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# end of Backlight & LCD device support

CONFIG_HDMI=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CP2112=y
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=y
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
CONFIG_HID_FT260=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_HOLTEK=y
CONFIG_HOLTEK_FF=y
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_VRC2 is not set
CONFIG_HID_XIAOMI=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LETSKETCH is not set
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=y
CONFIG_HID_MEGAWORLD_FF=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NINTENDO=y
CONFIG_NINTENDO_FF=y
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
# CONFIG_HID_PICOLCD_LEDS is not set
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
# CONFIG_HID_PXRC is not set
CONFIG_HID_RAZER=y
CONFIG_HID_PRIMAX=y
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SEMITEK=y
CONFIG_HID_SIGMAMICRO=y
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_U2FZERO=y
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
CONFIG_HID_MCP2221=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_PRODUCTLIST=y
CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_SL811_CS=y
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set
# CONFIG_USB_XEN_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS3=y
CONFIG_USB_CDNS3_GADGET=y
# CONFIG_USB_CDNS3_HOST is not set
# CONFIG_USB_CDNS3_PCI_WRAP is not set
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_GADGET is not set
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
# CONFIG_USB_DWC3_PCI is not set
# CONFIG_USB_DWC3_HAPS is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=y
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=y
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=y
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
CONFIG_USB_NET2280=y
# CONFIG_USB_GOKU is not set
CONFIG_USB_EG20T=y
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_CONFIGFS=y
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_F_LB_SS=y
CONFIG_USB_CONFIGFS_F_FS=y
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_PRINTER is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=y
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_G_SERIAL is not set
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
CONFIG_USB_RAW_GADGET=y
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
# CONFIG_UCSI_ACPI is not set
CONFIG_UCSI_STM32G0=y
CONFIG_TYPEC_TPS6598X=y
# CONFIG_TYPEC_ANX7411 is not set
CONFIG_TYPEC_RT1719=y
CONFIG_TYPEC_HD3SS3220=y
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# CONFIG_TYPEC_MUX_INTEL_PMC is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_IS31FL319X=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y
# CONFIG_LEDS_TPS6105X is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_RT8515=y
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_LEDS_SIEMENS_SIMATIC_IPC is not set
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_IMG_ASCII_LCD=y
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VMGENID is not set
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_ACRN_HSM=y
CONFIG_EFI_SECRET=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=y
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=y
# CONFIG_XEN_COMPAT_XENFS is not set
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
CONFIG_XEN_GRANT_DEV_ALLOC=y
CONFIG_XEN_GRANT_DMA_ALLOC=y
# CONFIG_XEN_PCIDEV_BACKEND is not set
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
CONFIG_XEN_PRIVCMD=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_VIRTIO is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
# CONFIG_COMEDI_PCL816 is not set
CONFIG_COMEDI_PCL818=y
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=y
CONFIG_COMEDI_AMPLC_PC263_ISA=y
CONFIG_COMEDI_RTI800=y
# CONFIG_COMEDI_RTI802 is not set
# CONFIG_COMEDI_DAC02 is not set
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=y
# CONFIG_COMEDI_DAS6402 is not set
CONFIG_COMEDI_DT2801=y
CONFIG_COMEDI_DT2811=y
CONFIG_COMEDI_DT2814=y
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=y
CONFIG_COMEDI_DMM32AT=y
CONFIG_COMEDI_FL512=y
# CONFIG_COMEDI_AIO_AIO12_8 is not set
# CONFIG_COMEDI_AIO_IIRO_16 is not set
CONFIG_COMEDI_II_PCI20KC=y
# CONFIG_COMEDI_C6XDIGIO is not set
# CONFIG_COMEDI_MPC624 is not set
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
# CONFIG_COMEDI_PCMUIO is not set
# CONFIG_COMEDI_MULTIQ3 is not set
CONFIG_COMEDI_S526=y
# CONFIG_COMEDI_PCI_DRIVERS is not set
# CONFIG_COMEDI_PCMCIA_DRIVERS is not set
# CONFIG_COMEDI_USB_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
# CONFIG_MXM_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=y
CONFIG_ACER_WIRELESS=y
# CONFIG_ACER_WMI is not set
# CONFIG_AMD_PMF is not set
CONFIG_ADV_SWBUTTON=y
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_ASUS_WIRELESS=y
CONFIG_ASUS_TF103C_DOCK=y
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=y
CONFIG_WIRELESS_HOTKEY=y
# CONFIG_HP_WMI is not set
CONFIG_IBM_RTL=y
CONFIG_SENSORS_HDAPS=y
# CONFIG_THINKPAD_LMI is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
# CONFIG_INTEL_ATOMISP2_LED is not set
CONFIG_INTEL_ATOMISP2_PM=y
CONFIG_INTEL_SAR_INT1092=y
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PMT_CLASS=y
CONFIG_INTEL_PMT_TELEMETRY=y
CONFIG_INTEL_PMT_CRASHLOG=y

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=y
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TELEMETRY is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=y
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=y
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_MRFLD_PWRBTN=y
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_RST=y
CONFIG_INTEL_SDSI=y
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_INTEL_VSEC=y
# CONFIG_MSI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_BARCO_P50_GPIO=y
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=y
CONFIG_PANASONIC_LAPTOP=y
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_MLX_PLATFORM=y
# CONFIG_TOUCHSCREEN_DMI is not set
CONFIG_INTEL_IPS=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
CONFIG_INTEL_SCU_PLATFORM=y
CONFIG_INTEL_SCU_WDT=y
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_SIEMENS_SIMATIC_IPC=y
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_CLK_TWL6040=y
CONFIG_COMMON_CLK_PALMAS=y
CONFIG_XILINX_VCU=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_DW_APB_TIMER=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_AXP288=y
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_INTEL_MRFLD=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
CONFIG_NTB=y
# CONFIG_NTB_AMD is not set
CONFIG_NTB_IDT=y
CONFIG_NTB_INTEL=y
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=y
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
CONFIG_IDLE_INJECT=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set
CONFIG_NVMEM_SPMI_SDAM=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
# CONFIG_FPGA_REGION is not set
# CONFIG_FPGA_DFL is not set
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
# CONFIG_ECRYPT_FS is not set
CONFIG_CRAMFS=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZO_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lzo"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
# CONFIG_TRUSTED_KEYS_TPM is not set

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
# CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE is not set
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
CONFIG_STACKLEAK_METRICS=y
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

# CONFIG_RANDSTRUCT_NONE is not set
CONFIG_RANDSTRUCT_FULL=y
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
CONFIG_RANDSTRUCT=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_ARIA is not set
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=y
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRCT10DIF=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_CURVE25519_X86=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=y
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256_SSSE3=y
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
CONFIG_CRYPTO_DEV_QAT_4XXX=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_REF_TRACKER=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
# CONFIG_SYMBOLIC_ERRNAME is not set
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
CONFIG_NET_NS_REFCNT_TRACKER=y
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
CONFIG_CSD_LOCK_WAIT_DEBUG=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_DYNAMIC_FTRACE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
CONFIG_GCOV_PROFILE_FTRACE=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--OePuUIRYOIxsRX67
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='trinity.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-next/master'
	export commit='2220e3a8953e86b87adfc753fc57c2a5e0b0a032'
	export kconfig='x86_64-randconfig-a006-20220905'
	export nr_vm=300
	export submit_id='636fa420ed82db11709089f9'
	export job_file='/lkp/jobs/scheduled/vm-meta-216/trinity-group-04-300s-yocto-x86_64-minimal-20190520.cgz-2220e3a8953e86b87adfc753fc57c2a5e0b0a032-20221112-135536-4lmtrq-2.yaml'
	export id='7557e1ed227141da22d6c9f2f66be8b2ecdc66d8'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='yocto-x86_64-minimal-20190520.cgz'
	export compiler='gcc-11'
	export enqueue_time='2022-11-12 21:48:17 +0800'
	export _id='636fa804ed82db11709089fb'
	export _rt='/result/trinity/group-04-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a006-20220905/gcc-11/2220e3a8953e86b87adfc753fc57c2a5e0b0a032'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/group-04-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a006-20220905/gcc-11/2220e3a8953e86b87adfc753fc57c2a5e0b0a032/8'
	export scheduler_version='/lkp/lkp/.src-20221111-153930'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/yocto/yocto-x86_64-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/group-04-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a006-20220905/gcc-11/2220e3a8953e86b87adfc753fc57c2a5e0b0a032/8
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a006-20220905/gcc-11/2220e3a8953e86b87adfc753fc57c2a5e0b0a032/vmlinuz-6.1.0-rc4-00216-g2220e3a8953e
branch=linux-next/master
job=/lkp/jobs/scheduled/vm-meta-216/trinity-group-04-300s-yocto-x86_64-minimal-20190520.cgz-2220e3a8953e86b87adfc753fc57c2a5e0b0a032-20221112-135536-4lmtrq-2.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a006-20220905
commit=2220e3a8953e86b87adfc753fc57c2a5e0b0a032
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
max_uptime=2100
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-a006-20220905/gcc-11/2220e3a8953e86b87adfc753fc57c2a5e0b0a032/modules.cgz'
	export bm_initrd='/osimage/pkg/debian-x86_64-20180403.cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-216'
	export kernel='/pkg/linux/x86_64-randconfig-a006-20220905/gcc-11/2220e3a8953e86b87adfc753fc57c2a5e0b0a032/vmlinuz-6.1.0-rc4-00216-g2220e3a8953e'
	export dequeue_time='2022-11-12 22:05:08 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-216/trinity-group-04-300s-yocto-x86_64-minimal-20190520.cgz-2220e3a8953e86b87adfc753fc57c2a5e0b0a032-20221112-135536-4lmtrq-2.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-04' $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--OePuUIRYOIxsRX67
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--OePuUIRYOIxsRX67--
