Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032CF6E3D62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 04:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDQCTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 22:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDQCTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:19:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647EF3A91;
        Sun, 16 Apr 2023 19:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681697935; x=1713233935;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Gvl64VKqOJeaj2k8LZNKz0J0NP7NjARppqrqKa5BI6Y=;
  b=ThOIq3F67b1Pz9w47LoUrHRwuZ0YaWWKP4W4o+yf+8SO54/db3NirUDQ
   Ka9C0W5kVkvweZLORLKiXJH2HjtRkU21YVuKY1U6WTj3xA454/uoCJQRT
   r11yq9nxuL6Owl5V5QCLBc+zR2SwUUigzqZVQqkPkjDZWU1RcJcu+DbCH
   /B81Aixs98/YIGtdgHhamJ9hTYAsvMM78syRNsYkDhQjjdvhf44FJR0mx
   OgxK/QTS5OJkkRwkm//acy9wKcg4CyACteo9EzTzTTPdWSZq1u/BEjvgM
   tZ+LaQpQQAhjr1Q8+GjqwFVDFCXn5I7QQHNNwKg1yF563+BK7oNJSYnoi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="325131752"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="325131752"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 19:18:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="1020243900"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="1020243900"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 16 Apr 2023 19:18:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 16 Apr 2023 19:18:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 16 Apr 2023 19:18:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 16 Apr 2023 19:18:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 16 Apr 2023 19:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6+IAXpq53y+dVdvR6XOBmTv+DOSEHflpAKV+RUmnYqC+LrzydPLOM1JNY3xsS5oeINxQGzAGKkqURNuWXk3Dy2FnMDDR7odovpLx7OSML2PQMWTif/PiB5PDHX6AEU1dQqjEXQRqCbmNpR/i8biq065IJeDfm3eN4k6ddqrnmcbaZs02CjZcpwELOuKnMvzAc8ODB8oCWopb/Qx+7G0TWM/VaRKIkSDBtThdoZJCInB9Lg1Ey4xpuxHYSJhR2ndsZ4QEu6msa4/S0uJTR8+3xLHff+sbJNyduSvqgDUrT/0ob+dYX7MWHmiL+Mw2QnhQhUCusOWjDhvS9sxRN3NkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckD8dXUBHnSvKodyMr4fwqFI/WoXJbmQfKkYyeotFU8=;
 b=KSBT8YKo8KyPCWUbKbraiYdnhXA6CHBcqAc50Js0jsQSAuWCYtMUGByZRn2rZVsTu4+SPPsACJI0kJfYY5z/6d7IzS5A9wp8Te/1sCCLqek+PrIIArv3E+DARMPwYd2R1uRQqiirmFodkwWbPFvvlwhWlfOElewUOQ/LK3zS357np9b2/CnORdRPuZ1SoAxcdvN1ruvgwearZUmaTrS0HNaQAcr3s6L3umFA/uGCYgwXf7TzDeCggzR8akEtrq4o5OpWTqxcT2KppGpTO5hEbXKrub7niOJAk2FYxr+4aUPP30YmSJWr/E51K2q9gJK0mACSdRI7Cvjc3LGmuD+u/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB5920.namprd11.prod.outlook.com (2603:10b6:a03:42e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 02:18:49 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 02:18:49 +0000
Date:   Mon, 17 Apr 2023 10:18:37 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-fsdevel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
Message-ID: <202304170945.28aa41a0-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="t5URSEJKxiEK76Mh"
Content-Disposition: inline
In-Reply-To: <20230414134908.103932-1-hare@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc62404-550a-408d-c4fd-08db3eea13e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTk1sl9OBQwJh6jJWB7M9mUM+uDFbwYjfslKTeraSEwNuy0vlDyofHsGysShmqkB+5V6WDvTECJCNBJ3Pt2KhWyVHCVBFUorpq1KuB4O1oL1rwI/xKbF+cWQ4a+L2bwtQ6SKNVfRh1l28z6ZYYgZZaNEJUHRTNbCqerzPH7TVmdFNOgFTT1B8oZynHiOxLta/mu0lSYDvXv3SmgpoobhvEAwhudyNF/SbEn6KGZBm8ScyckNVSNBeMYFAJv9HUSAl4NwzTaFC50j4G9AJZFd6zWxZu3/aMW1VW/iHQqe2SVpdfgCYPNXzhn0F51xaN6NU2gQLSAwJZ577aDSTqE+s91dyxHgHqEsJOeI1WcqqE3qQFULIsuRZRheotyGMsMtC5khcr43g7yz6vw62PJOLPLiJ+80NW+v/ctvzMNgDcDGKYxiMIgvAjvEKndqEeAY/IX8++IuynD2xWL0HtJZOBdPmUhl17FXL1dHivxOsuSXIcbAd1qgjISyKAFtkz8Z9foGfzqWAsyg0lTJNl29g8BoFnjFmt42wCRKMIU0yEf4LzqUpah/zNqUYiN9gkycODdmKjfqsQHZBBBQWj6I5KNThvBo1M5bLv0xJrzeWUs80R2J2ga47oZKj+TSCyTQl1Qb19aMFRV2jhvWABwrEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(86362001)(83380400001)(36756003)(6512007)(6506007)(1076003)(26005)(186003)(2906002)(21490400003)(2616005)(44144004)(6486002)(235185007)(966005)(5660300002)(38100700002)(6666004)(8936002)(45080400002)(8676002)(478600001)(54906003)(41300700001)(82960400001)(316002)(66946007)(66556008)(4326008)(66476007)(6916009)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2DorkqjjSEQkiSvt9/taYSm+UCVmLeQd88B1Ra9ibzsuvTo9PpNtzzhWu3jC?=
 =?us-ascii?Q?6rEYg7jTXDJ7x1JhXEf+T70gxtBMPoSPV93Glo4MQfpn64hUuJe+XnACQwz+?=
 =?us-ascii?Q?LsWz4MxTztMIufDRRHAO5Rh7aIqQyQZ0WL6XhCB1IU1N6ENgrq5Z+KMS3fYj?=
 =?us-ascii?Q?9qUpe9bXSHct1gdE9Fk0hnetPcPoq/xdMa9i1J0W8VBwZuus7SEpIyrD76+z?=
 =?us-ascii?Q?q/I2MhpQ4w545qt8RfeKRnDvL23Mqb/G+4PSwRsz4/5uD0epemwefggpwLkh?=
 =?us-ascii?Q?lz61N3LZGNEfe9te10CIxgrwPcKUh3H+l7aHHqaotcj/CmWR8GMeaIQGbZ1s?=
 =?us-ascii?Q?D9HiMGeOwlo3UKLpdczZJERnX6iukbjUJizx5MqJWkLI8tk+NBwtIEsIAJCZ?=
 =?us-ascii?Q?kJQDWmw0veN/q9Xpejs2j01ftSb3bAQIT8QlpBZbweyYK/LyBxh+OZ6KqZnp?=
 =?us-ascii?Q?SAzc5lJ6ZOQVe0jE1QDYGtJ1cudYo1zL+C5wsStSi/3cBvo4UMGv571lfQzo?=
 =?us-ascii?Q?2eVz8rLdkON1LWO1FmmxNy2KzJmfaZ833V6+XobdkEfS9YrwBOtSXh1oE+b1?=
 =?us-ascii?Q?fVN9Sn8uq7rGsiLtwORw5G9X336DoG6mWNKE+lqqXZxH7NUewAzbYxgivKsu?=
 =?us-ascii?Q?OU/QDsu5VpcaNRfddCPK7IxFlg4ERYpNKYe9udnuZc+hVITthuYe6d+mji6T?=
 =?us-ascii?Q?kn1duskFLcQGR68webjfBO04ZXaO5u7KGLifgwcJxnbc/w5+e6FJt2UeOUbs?=
 =?us-ascii?Q?s6abzK1o9pv84P3PFED0pygIj2Nm8mD/SXkG4r9ZnW9cWrLCttiy1k7/vf5+?=
 =?us-ascii?Q?gGzshf1kfRF2VSbTSdS5Kxi5/6mkswEft/ZnmGuz6Qt/OG3Vu/BQ2oFgPdZ0?=
 =?us-ascii?Q?jl8FL75Fp/i+j7Uq7AvkdTNMv3UAc8MaxYZdsdpmYbTHpggf/bFG5YQn/Qx6?=
 =?us-ascii?Q?stQN0mO5jcjDa4ZR4m81JYYnMGL6pOX5A/ltQSVAmOf5+BLGbeK2YIl7YNlr?=
 =?us-ascii?Q?28J1FwKXzhtOAMabeiLn+HwcBI9aubRKEptdSsORNIA+X8/PmZgb6pecffVv?=
 =?us-ascii?Q?bN8w5OVsI4+jRqS9li4r2osykhYw2kkMJUfUAuYDjbnpRHPnkN5EzTXxY3bm?=
 =?us-ascii?Q?SXMGBCN9hyjzxuiETbAzxlabPqOf6y8X2Tmnn3iwV41h9Yg1hMikp5OLGv9z?=
 =?us-ascii?Q?i5ytpbhxEpolxwCQ4VCA52JkYwI8If1OyWhReboSP1qG14f/uSCYalQDQmBw?=
 =?us-ascii?Q?jhIwuJEyVN5clo1rCI2fc0wbw+TNx6wYvRBLBAefS+00fLRDlWBTkhu24n2+?=
 =?us-ascii?Q?Bj8KFudnpS6Lhiig4EQDvo4QDZmqcW77CVlrilEhT8O4VIfjYQ0nNXK/Y/1d?=
 =?us-ascii?Q?ZQHPqezFXem7qszbLDQmsSEMdQKaVEwpv0R4gUBeM1FIimQuh4hw1ddvcRzT?=
 =?us-ascii?Q?K3vMFFR9gpkvbsujelH9qwr91dv2wivPgf8pxYMEv2NMTZaseSKxuJsZ5kOV?=
 =?us-ascii?Q?6C1TLDxMnb4wA0o3i72Ruu2CvcRorYH5114niRZ1QQ2APkucBbnKwWlcui0g?=
 =?us-ascii?Q?z+Ps1gI0HuQANh/e2Ea42L5CcaFRovkfhnjIbccRRsIZ9PV86A6aPcKr85mT?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc62404-550a-408d-c4fd-08db3eea13e2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 02:18:48.7797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uU9GeYssnJPhnmGVXGP4ClkLewSynv4XewScz6BLLAVZXwpoJFEV5Pp3dk3FBu9yCrKdq/Wo7uAmOV4Ukq0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5920
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--t5URSEJKxiEK76Mh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Hello,

kernel test robot noticed "WARNING:at_include/linux/pagemap.h:#split_huge_page_to_list" on:

commit: 3f1c33c25c31221a7a27d302ce6aac8e9b71edbb ("[PATCH] mm/filemap: allocate folios according to the blocksize")
url: https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/mm-filemap-allocate-folios-according-to-the-blocksize/20230414-215648
base: v6.3-rc6
patch link: https://lore.kernel.org/all/20230414134908.103932-1-hare@suse.de/
patch subject: [PATCH] mm/filemap: allocate folios according to the blocksize

in testcase: xfstests
version: xfstests-x86_64-a7df89e-1_20230410
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv3
	test: generic-group-28



compiler: gcc-11
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202304170945.28aa41a0-oliver.sang@intel.com


[   96.792002][ T3511] ------------[ cut here ]------------
[ 96.797305][ T3511] WARNING: CPU: 3 PID: 3511 at include/linux/pagemap.h:344 split_huge_page_to_list (include/linux/pagemap.h:344 mm/huge_memory.c:2767) 
[   96.807438][ T3511] Modules linked in: loop cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor intel_rapl_msr raid6_pq intel_rapl_common zstd_compress libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod t10_pi kvm_intel crc64_rocksoft_generic i915 kvm crc64_rocksoft crc64 irqbypass crct10dif_pclmul sg crc32_pclmul ipmi_devintf crc32c_intel ipmi_msghandler drm_buddy ghash_clmulni_intel intel_gtt sha512_ssse3 drm_display_helper drm_kms_helper mei_wdt syscopyarea ahci rapl sysfillrect mei_me intel_cstate libahci sysimgblt wmi_bmof video intel_uncore serio_raw libata mei intel_pch_thermal ttm intel_pmc_core wmi acpi_pad tpm_infineon drm fuse ip_tables
[   96.868429][ T3511] CPU: 3 PID: 3511 Comm: xfs_io Not tainted 6.3.0-rc6-00001-g3f1c33c25c31 #1
[   96.877009][ T3511] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[ 96.885923][ T3511] RIP: 0010:split_huge_page_to_list (include/linux/pagemap.h:344 mm/huge_memory.c:2767) 
[ 96.891989][ T3511] Code: 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 31 02 00 00 49 8b 84 24 98 00 00 00 a8 40 0f 85 f6 fe ff ff <0f> 0b e9 ef fe ff ff 81 e6 60 ec 0b 00 a9 00 00 04 00 44 0f 45 ee
All code
========
   0:	89 f2                	mov    %esi,%edx
   2:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   9:	fc ff df 
   c:	48 c1 ea 03          	shr    $0x3,%rdx
  10:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  14:	0f 85 31 02 00 00    	jne    0x24b
  1a:	49 8b 84 24 98 00 00 	mov    0x98(%r12),%rax
  21:	00 
  22:	a8 40                	test   $0x40,%al
  24:	0f 85 f6 fe ff ff    	jne    0xffffffffffffff20
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 ef fe ff ff       	jmpq   0xffffffffffffff20
  31:	81 e6 60 ec 0b 00    	and    $0xbec60,%esi
  37:	a9 00 00 04 00       	test   $0x40000,%eax
  3c:	44 0f 45 ee          	cmovne %esi,%r13d

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 ef fe ff ff       	jmpq   0xfffffffffffffef6
   7:	81 e6 60 ec 0b 00    	and    $0xbec60,%esi
   d:	a9 00 00 04 00       	test   $0x40000,%eax
  12:	44 0f 45 ee          	cmovne %esi,%r13d
[   96.911358][ T3511] RSP: 0018:ffffc9000420f9d8 EFLAGS: 00010046
[   96.917253][ T3511] RAX: 0000000000000000 RBX: 1ffff92000841f43 RCX: ffffffff8192f43e
[   96.925040][ T3511] RDX: 1ffff11084ce792a RSI: 0000000000000008 RDI: ffff88842673c950
[   96.932836][ T3511] RBP: ffffea0005796700 R08: 0000000000000000 R09: ffff88842673c957
[   96.940625][ T3511] R10: ffffed1084ce792a R11: 0000000000000001 R12: ffff88842673c8b8
[   96.948419][ T3511] R13: 0000000000000000 R14: ffff88842673c950 R15: ffffea0005796700
[   96.956211][ T3511] FS:  00007f83d8bdc800(0000) GS:ffff8883cf580000(0000) knlGS:0000000000000000
[   96.964956][ T3511] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   96.971364][ T3511] CR2: 00007f83d8bdaef8 CR3: 000000013f57e006 CR4: 00000000003706e0
[   96.979162][ T3511] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   96.986958][ T3511] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   96.994758][ T3511] Call Trace:
[   96.997888][ T3511]  <TASK>
[ 97.000679][ T3511] ? can_split_folio (mm/huge_memory.c:2646) 
[ 97.005455][ T3511] ? __filemap_get_folio (arch/x86/include/asm/bitops.h:138 arch/x86/include/asm/bitops.h:144 include/asm-generic/bitops/instrumented-lock.h:58 include/linux/pagemap.h:915 include/linux/pagemap.h:951 mm/filemap.c:1936) 
[ 97.010578][ T3511] ? zero_user_segments (include/linux/highmem.h:282) 
[ 97.016651][ T3511] truncate_inode_partial_folio (mm/truncate.c:243) 
[ 97.022376][ T3511] truncate_inode_pages_range (mm/truncate.c:380) 
[ 97.027928][ T3511] ? folio_add_lru (arch/x86/include/asm/preempt.h:85 mm/swap.c:518) 
[ 97.032358][ T3511] ? truncate_inode_partial_folio (mm/truncate.c:332) 
[ 97.038261][ T3511] ? policy_node (include/linux/nodemask.h:266 mm/mempolicy.c:1869) 
[ 97.042604][ T3511] ? __cond_resched (kernel/sched/core.c:8489) 
[ 97.047115][ T3511] ? down_read (arch/x86/include/asm/atomic64_64.h:34 include/linux/atomic/atomic-long.h:41 include/linux/atomic/atomic-instrumented.h:1280 kernel/locking/rwsem.c:176 kernel/locking/rwsem.c:181 kernel/locking/rwsem.c:249 kernel/locking/rwsem.c:1249 kernel/locking/rwsem.c:1263 kernel/locking/rwsem.c:1522) 
[ 97.051372][ T3511] ? rwsem_down_read_slowpath (kernel/locking/rwsem.c:1518) 
[ 97.056924][ T3511] ? SMB2_set_eof (fs/cifs/smb2pdu.c:5197) cifs
[ 97.062103][ T3511] ? up_read (arch/x86/include/asm/atomic64_64.h:160 include/linux/atomic/atomic-long.h:71 include/linux/atomic/atomic-instrumented.h:1318 kernel/locking/rwsem.c:1347 kernel/locking/rwsem.c:1616) 
[ 97.066015][ T3511] ? unmap_mapping_range (mm/memory.c:3541) 
[ 97.071051][ T3511] ? __do_fault (mm/memory.c:3541) 
[ 97.075387][ T3511] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 97.079896][ T3511] ? __do_fault (mm/memory.c:3541) 
[ 97.084234][ T3511] ? zero_user_segments+0x19e/0x240 cifs
[ 97.090958][ T3511] truncate_pagecache (mm/truncate.c:744) 
[ 97.095638][ T3511] smb3_simple_falloc+0xcbf/0x1840 cifs
[ 97.101834][ T3511] ? smb3_fiemap (fs/cifs/smb2ops.c:3587) cifs
[ 97.106919][ T3511] ? __do_sys_clone (kernel/fork.c:2812) 
[ 97.111433][ T3511] ? __do_sys_vfork (kernel/fork.c:2812) 
[ 97.115948][ T3511] vfs_fallocate (fs/open.c:324) 
[ 97.120381][ T3511] __x64_sys_fallocate (include/linux/file.h:44 fs/open.c:348 fs/open.c:355 fs/open.c:353 fs/open.c:353) 
[ 97.125238][ T3511] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 97.129490][ T3511] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   97.135206][ T3511] RIP: 0033:0x7f83d8f5d647
[ 97.139454][ T3511] Code: 89 7c 24 08 48 89 4c 24 18 e8 55 07 f9 ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 7c 24 08 b8 1d 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24 08 e8 85 07 f9 ff 8b 44
All code
========
   0:	89 7c 24 08          	mov    %edi,0x8(%rsp)
   4:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
   9:	e8 55 07 f9 ff       	callq  0xfffffffffff90763
   e:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
  13:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  18:	41 89 c0             	mov    %eax,%r8d
  1b:	8b 74 24 0c          	mov    0xc(%rsp),%esi
  1f:	8b 7c 24 08          	mov    0x8(%rsp),%edi
  23:	b8 1d 01 00 00       	mov    $0x11d,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 31                	ja     0x63
  32:	44 89 c7             	mov    %r8d,%edi
  35:	89 44 24 08          	mov    %eax,0x8(%rsp)
  39:	e8 85 07 f9 ff       	callq  0xfffffffffff907c3
  3e:	8b                   	.byte 0x8b
  3f:	44                   	rex.R

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 31                	ja     0x39
   8:	44 89 c7             	mov    %r8d,%edi
   b:	89 44 24 08          	mov    %eax,0x8(%rsp)
   f:	e8 85 07 f9 ff       	callq  0xfffffffffff90799
  14:	8b                   	.byte 0x8b
  15:	44                   	rex.R
[   97.158825][ T3511] RSP: 002b:00007fffd0739670 EFLAGS: 00000293 ORIG_RAX: 000000000000011d
[   97.167058][ T3511] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f83d8f5d647
[   97.174858][ T3511] RDX: 00000000000003ff RSI: 0000000000000000 RDI: 0000000000000004
[   97.182644][ T3511] RBP: 000055cbb600cf50 R08: 0000000000000000 R09: 0000000000000000
[   97.190444][ T3511] R10: 0000000000000002 R11: 0000000000000293 R12: 000055cbb4968340
[   97.198236][ T3511] R13: 0000000000000000 R14: 000055cbb600cf30 R15: 000055cbb600cf50
[   97.206035][ T3511]  </TASK>
[   97.208906][ T3511] ---[ end trace 0000000000000000 ]---
[   97.331260][  T292] generic/568       _check_dmesg: something found in dmesg (see /lkp/benchmarks/xfstests/results//generic/568.dmesg)
[   97.331271][  T292]


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--t5URSEJKxiEK76Mh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.3.0-rc6-00001-g3f1c33c25c31"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.3.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23990
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23990
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

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
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
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
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
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
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
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
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
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
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
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
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
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
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
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
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

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
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
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
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
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
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
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
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
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
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
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
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
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
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
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
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
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
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
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
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
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
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
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
# CONFIG_MSE102X is not set
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

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
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
# CONFIG_ATH12K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
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
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set

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

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
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
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IDXD_BUS=m
CONFIG_INTEL_IDXD=m
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IDXD_SVM is not set
# CONFIG_INTEL_IDXD_PERFMON is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
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
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
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

# CONFIG_WPCM450_SOC is not set

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

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
CONFIG_SUNRPC_DEBUG=y
# CONFIG_SUNRPC_XPRT_RDMA is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
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
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
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
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
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
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
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
# CONFIG_NET_NS_REFCNT_TRACKER is not set
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
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
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
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
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
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--t5URSEJKxiEK76Mh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='xfstests'
	export testcase='xfstests'
	export category='functional'
	export need_memory='1G'
	export job_origin='xfstests-cifs.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-skl-d07'
	export tbox_group='lkp-skl-d07'
	export submit_id='643c71fb80e7c8d54acacbc7'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-28-debian-11.1-x86_64-20220510.cgz-3f1c33c25c31221a7a27d302ce6aac8e9b71edbb-20230417-54602-1uec6vu-5.yaml'
	export id='3e406420799ef88961c9f0e681ec74e01183bd23'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=8
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1'
	export brand='Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz'
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
EXT4_FS'
	export commit='3f1c33c25c31221a7a27d302ce6aac8e9b71edbb'
	export ucode='0xf0'
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2023-04-17 06:09:00 +0800'
	export _id='643c721480e7c8d54acacbc9'
	export _rt='/result/xfstests/4HDD-ext4-smbv3-generic-group-28/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='16af0c1db8e3d36a15e90d824b2ad3fe4de6c5a3'
	export base_commit='09a9639e56c01c7a00d6c0ca63f4c7c41abe075d'
	export branch='linux-review/Hannes-Reinecke/mm-filemap-allocate-folios-according-to-the-blocksize/20230414-215648'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/xfstests/4HDD-ext4-smbv3-generic-group-28/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv3-generic-group-28/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb/vmlinuz-6.3.0-rc6-00001-g3f1c33c25c31
branch=linux-review/Hannes-Reinecke/mm-filemap-allocate-folios-according-to-the-blocksize/20230414-215648
job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-28-debian-11.1-x86_64-20220510.cgz-3f1c33c25c31221a7a27d302ce6aac8e9b71edbb-20230417-54602-1uec6vu-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=3f1c33c25c31221a7a27d302ce6aac8e9b71edbb
initcall_debug
nmi_watchdog=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
nokaslr
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs2_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/xfstests_20230410.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/xfstests-x86_64-a7df89e-1_20230410.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.3.0-rc6-00001-g3f1c33c25c31'
	export repeat_to=6
	export stop_repeat_if_found='xfstests.generic.568.fail'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb/vmlinuz-6.3.0-rc6-00001-g3f1c33c25c31'
	export dequeue_time='2023-04-17 06:14:36 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-28-debian-11.1-x86_64-20220510.cgz-3f1c33c25c31221a7a27d302ce6aac8e9b71edbb-20230417-54602-1uec6vu-5.cgz'

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

	run_setup nr_hdd=4 $LKP_SRC/setup/disk

	run_setup fs='ext4' $LKP_SRC/setup/fs

	run_setup fs='smbv3' $LKP_SRC/setup/fs2

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='generic-group-28' $LKP_SRC/tests/wrapper xfstests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='generic-group-28' $LKP_SRC/stats/wrapper xfstests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time xfstests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--t5URSEJKxiEK76Mh
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AgAAAAAEWVo=

--t5URSEJKxiEK76Mh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="xfstests"

2023-04-16 22:16:26 mount /dev/sdb1 /fs/sdb1
2023-04-16 22:16:26 mkdir -p /smbv3//cifs/sdb1
2023-04-16 22:16:26 export FSTYP=cifs
2023-04-16 22:16:26 export TEST_DEV=//localhost/fs/sdb1
2023-04-16 22:16:26 export TEST_DIR=/smbv3//cifs/sdb1
2023-04-16 22:16:26 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=3.0,mfsymlinks,actimeo=0
2023-04-16 22:16:26 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group-28
2023-04-16 22:16:26 ./check -E tests/cifs/exclude.incompatible-smb3.txt -E tests/cifs/exclude.very-slow.txt generic/560 generic/561 generic/562 generic/563 generic/564 generic/565 generic/566 generic/567 generic/568 generic/569 generic/570 generic/571 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/578 generic/579
FSTYP         -- cifs
PLATFORM      -- Linux/x86_64 lkp-skl-d07 6.3.0-rc6-00001-g3f1c33c25c31 #1 SMP Mon Apr 17 03:56:16 CST 2023

generic/560       [not run] this test requires a valid $SCRATCH_DEV
generic/561       [not run] this test requires a valid $SCRATCH_DEV
generic/562       [not run] this test requires a valid $SCRATCH_DEV
generic/563       [not run] this test requires a valid $SCRATCH_DEV
generic/564       [not run] cifs does not support mknod/mkfifo
generic/565       [not run] this test requires a valid $SCRATCH_DEV
generic/566       [not run] this test requires a valid $SCRATCH_DEV
generic/567       [not run] this test requires a valid $SCRATCH_DEV
generic/568       _check_dmesg: something found in dmesg (see /lkp/benchmarks/xfstests/results//generic/568.dmesg)

generic/569       [not run] this test requires a valid $SCRATCH_DEV
generic/570       [not run] this test requires a valid $SCRATCH_DEV
generic/571       [not run] Require fcntl advisory locks support
generic/572       [not run] this test requires a valid $SCRATCH_DEV
generic/573       [not run] this test requires a valid $SCRATCH_DEV
generic/574       [not run] this test requires a valid $SCRATCH_DEV
generic/575       [not run] this test requires a valid $SCRATCH_DEV
generic/576       [not run] this test requires a valid $SCRATCH_DEV
generic/577       [not run] this test requires a valid $SCRATCH_DEV
generic/578       [not run] Reflink not supported by test filesystem type: cifs
generic/579       [not run] this test requires a valid $SCRATCH_DEV
Ran: generic/560 generic/561 generic/562 generic/563 generic/564 generic/565 generic/566 generic/567 generic/568 generic/569 generic/570 generic/571 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/578 generic/579
Not run: generic/560 generic/561 generic/562 generic/563 generic/564 generic/565 generic/566 generic/567 generic/569 generic/570 generic/571 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/578 generic/579
Failures: generic/568
Failed 1 of 20 tests


--t5URSEJKxiEK76Mh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/xfstests-cifs.yaml
suite: xfstests
testcase: xfstests
category: functional
need_memory: 1G
disk: 4HDD
fs: ext4
fs2: smbv3
xfstests:
  test: generic-group-28
job_origin: xfstests-cifs.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d07
tbox_group: lkp-skl-d07
submit_id: 643c50a96202833738ce2f02
job_file: "/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-28-debian-11.1-x86_64-20220510.cgz-3f1c33c25c31221a7a27d302ce6aac8e9b71edbb-20230417-14136-e133c8-0.yaml"
id: 5e6ab37226e498c84641e7f3eb9200bb878ee09f
queuer_version: "/zday/lkp"

#! /db/releases/20230415222647/lkp-src/hosts/lkp-skl-d07
model: Skylake
nr_cpu: 8
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz

#! /db/releases/20230415222647/lkp-src/include/category/functional
kmsg:
heartbeat:
meminfo:

#! /db/releases/20230415222647/lkp-src/include/disk/nr_hdd
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- EXT4_FS

#! /db/releases/20230415222647/lkp-src/include/queue/cyclic
commit: 3f1c33c25c31221a7a27d302ce6aac8e9b71edbb

#! /db/releases/20230415222647/lkp-src/include/testbox/lkp-skl-d07
ucode: '0xf0'

#! /db/releases/20230415222647/lkp-src/include/fs/OTHERS
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2023-04-17 03:46:50.276038630 +08:00
_id: 643c50a96202833738ce2f02
_rt: "/result/xfstests/4HDD-ext4-smbv3-generic-group-28/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 16af0c1db8e3d36a15e90d824b2ad3fe4de6c5a3
base_commit: '09a9639e56c01c7a00d6c0ca63f4c7c41abe075d'
branch: linux-devel/devel-hourly-20230415-140035
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/xfstests/4HDD-ext4-smbv3-generic-group-28/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv3-generic-group-28/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb/vmlinuz-6.3.0-rc6-00001-g3f1c33c25c31
- branch=linux-devel/devel-hourly-20230415-140035
- job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-28-debian-11.1-x86_64-20220510.cgz-3f1c33c25c31221a7a27d302ce6aac8e9b71edbb-20230417-14136-e133c8-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=3f1c33c25c31221a7a27d302ce6aac8e9b71edbb
- initcall_debug
- nmi_watchdog=0
- max_uptime=1200
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs2_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/xfstests_20230410.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/xfstests-x86_64-a7df89e-1_20230410.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20230415222647/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.3.0-rc6
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/3f1c33c25c31221a7a27d302ce6aac8e9b71edbb/vmlinuz-6.3.0-rc6-00001-g3f1c33c25c31"
dequeue_time: 2023-04-17 04:04:42.730288891 +08:00

#! /db/releases/20230416215428/lkp-src/include/site/inn
job_state: finished
loadavg: 2.24 0.85 0.31 2/194 5721
start_time: '1681675603'
end_time: '1681675618'
version: "/lkp/lkp/.src-20230414-164046:f0e7041701ba:17dd785c69c5"

--t5URSEJKxiEK76Mh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

dmsetup remove_all
wipefs -a --force /dev/sdb1
wipefs -a --force /dev/sdb2
wipefs -a --force /dev/sdb3
wipefs -a --force /dev/sdb4
mkfs -t ext4 -q -F /dev/sdb2
mkfs -t ext4 -q -F /dev/sdb1
mkfs -t ext4 -q -F /dev/sdb3
mkfs -t ext4 -q -F /dev/sdb4
mkdir -p /fs/sdb1
mount -t ext4 /dev/sdb1 /fs/sdb1
mkdir -p /fs/sdb2
mount -t ext4 /dev/sdb2 /fs/sdb2
mkdir -p /fs/sdb3
mount -t ext4 /dev/sdb3 /fs/sdb3
mkdir -p /fs/sdb4
mount -t ext4 /dev/sdb4 /fs/sdb4
mkdir -p /cifs/sdb1
timeout 5m mount -t cifs -o vers=3.0 -o user=root,password=pass //localhost/fs/sdb1 /cifs/sdb1
mkdir -p /cifs/sdb2
timeout 5m mount -t cifs -o vers=3.0 -o user=root,password=pass //localhost/fs/sdb2 /cifs/sdb2
mkdir -p /cifs/sdb3
timeout 5m mount -t cifs -o vers=3.0 -o user=root,password=pass //localhost/fs/sdb3 /cifs/sdb3
mkdir -p /cifs/sdb4
timeout 5m mount -t cifs -o vers=3.0 -o user=root,password=pass //localhost/fs/sdb4 /cifs/sdb4
mount /dev/sdb1 /fs/sdb1
mkdir -p /smbv3//cifs/sdb1
export FSTYP=cifs
export TEST_DEV=//localhost/fs/sdb1
export TEST_DIR=/smbv3//cifs/sdb1
export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=3.0,mfsymlinks,actimeo=0
sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group-28
./check -E tests/cifs/exclude.incompatible-smb3.txt -E tests/cifs/exclude.very-slow.txt generic/560 generic/561 generic/562 generic/563 generic/564 generic/565 generic/566 generic/567 generic/568 generic/569 generic/570 generic/571 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/578 generic/579

--t5URSEJKxiEK76Mh--
