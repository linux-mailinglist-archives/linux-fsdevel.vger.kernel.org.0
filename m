Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022D460F2CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 10:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiJ0Iqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 04:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiJ0Iqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:46:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0609E645D5;
        Thu, 27 Oct 2022 01:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666860397; x=1698396397;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TaCEDibu0NnYPG5XUWoPGG5VPdFgeLhiYvi7wKDSnj4=;
  b=Qvp3NVTp47oIUGPwTQKaERQivGzcp6h4RjPJyI7YDpNWKgppu3P+jkgk
   4wOhEP1We0CyzFERUKqDIk/OBO+MMNRBz5Fm2Yrtf78JU9lAnyomJWf60
   2+MoQR6aOHBfBdKeIjOR3xAebgSAGvKhL10Xv15ovonWJCvVwTwLGioWH
   xPMbaktrg0E90LbqL1PLn/tfaVWDJeEH6XT2Au1IDVnGkL46H2fSDtGc2
   MLJgl9mQZrPER7OnCJylpDnIIo/gwYkxEM8mgcFQIHMXmD7dDxeLZ3eSe
   iSpCZi4Y/FpAGx/kHfJbzmw4EqRAPNexDzsEV3+FsiTs5d6EzJd/q6InT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="288564084"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="288564084"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 01:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="807370476"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="807370476"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 27 Oct 2022 01:46:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 01:46:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 01:46:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 01:46:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 01:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH2axlw2AjeO+HryxqU6uqibNOJmNSUs0ShUG2b2I2y7YbEx8Gw/h6fjlP5IyiFWmNXdepOqqoHF26BxA6Jh2bXjBu1JJpFF3fZo8xTTvLIUTinVpFLT4ftYTZIsrEIkwFoXHB6+nZmnZAu/FckAEFAn8XjSnCsPxyBxGu2eFgMEc6TTd6VvfSzoCxA3ETzS6CqRX5DM5Kpao/nTRfeDJN2PQcGrtQPnPFeBnku2f62qD0jHqZ0f+abFyUp5HlJgSU91kuxcFrURTo1VP15or7+fpfOd1VfY0cDXKsBCO7ULv27jvfoH/7QoYlukHluwPW4Pmvc7cHE8qpAJfELW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Zc4IidvmOU3x903hTC5jVYlY/9YSFJjFt3EMBzE2Jc=;
 b=fE27tvp5p1LY/U5wLF7YBforchS6zD46od2yGI34UcNapcyWSpEZ4Lo3TmlX4JUwo9JM3Nzdqb+3ss641CckuSOedvyaQOFaFeY7zk2Ac2/jMuqJ2BWe/jf4GZvGE2HSUsI3kbnkMGrpcoBWEC+Z5aoNV0gQHmg/t+3UhjVLV0icLWZBwSixh6sgH/JnnJEZc3n2b1qY9v6ZnUWPhWlVnXK8svW7rwPs022syA81LtyoL41Qth6G9TRGeOzpPCFTLTaR3e7nG2aCpZGu87wUYCYD7gWySdC5mYOgqEwk+kEnHhtZ0zagJIRuwmo6x66EKq9FN5wta8jd9P3gGcKjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA1PR11MB5874.namprd11.prod.outlook.com (2603:10b6:806:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 27 Oct
 2022 08:46:32 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d%9]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 08:46:32 +0000
Date:   Thu, 27 Oct 2022 16:44:44 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fsnotify: allow sleepable child flag update
Message-ID: <Y1pE/MdXBB9swEZ/@yujie-X299>
References: <20221018041233.376977-3-stephen.s.brennan@oracle.com>
 <202210271500.731e3808-yujie.liu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202210271500.731e3808-yujie.liu@intel.com>
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA1PR11MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e702751-0fe0-46ec-3cd0-08dab7f7bf4f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztwxAhlMn4FIDKMZlXAI95qixCYobDqURRiqPl8V31JL+bQ6XRIZ6CQ9tCagQlMwdkTLxitaSjb7KvsPpBzZ95y++cwe6rSHuqsjoN7kQvWkGxY8CN69QjkBSR7qLIx57HVtNTOWv1XfuPOUvwC6fSbp90M4NTbQlOyJWSchOU2R10FLCY3iY0Roh8V1FsRQmsCZR0WhJZ3NUz3X+SaYpxSDKafka+H3dYFrVz9aVlQNNSOLACcwAPPZksdHrDwKQWwdY9NM0FyeyRWrAIMD2yhfUcwGTqKlf0xj7W58u0eO701ZLDg0Fe6GmJoni5z8kRS31ZKdWjTz/XbNAZZO6jMS7DNVjuzy2VWnr0Zj4ReLfEP6ZrXtZ2WRbNBfJSHjDqB+bRAMme6n1bcgqpljt+IdxWP/68RheO6J5lBdFengswiPOv72ZBB71TZfc6Du3rjbXdCxoMteyd/7SdTQa+lDkgPBmSYuq3LSyegEXtOiz23r7d1B1w4ddKkU5vmYPcdb8KoVdbimAMYgRssgGtD9eAeWNR6bE4EVNnfNSQj+E7px6lpA0Ypen2G3IoN6xsQcAzCpFWHm+FxD93TEizcdzcBhEKbd1QG7zSEtRJqgcAHTbo/O/qkPdkU54Stn8U+EqyI8yNraO+sWuSK+TGzt+OWazUnHhfMItrNukhMSJ1NVoQS23Cpmo79NyUVQsKG/dc63Kk4zjPegEU/JVrJ6krt7tISLl/YjpFMCT4RWzY2Kreltt2Rst++xPnPYlHYpMWLaeDAxJXBRgkICfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(6512007)(9686003)(66946007)(66476007)(66556008)(6506007)(6916009)(86362001)(54906003)(6666004)(316002)(8676002)(38100700002)(26005)(41300700001)(33716001)(4326008)(82960400001)(15650500001)(966005)(186003)(2906002)(6486002)(44832011)(5660300002)(8936002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cd3cOiJF2cFHWDeX/BHvSgkoSwnAyhAP3lbtD9cKYL3X3nPItT3L3b32F2+C?=
 =?us-ascii?Q?kfk6OoxdoWHnYcCfaeIVm05STxmwzpwLd87ishPv4bRUrcKXmi5p2pXeB9ih?=
 =?us-ascii?Q?bSilnvX32PHbKBB3wR+K5JzzfLy7Np0gCXjwnUSkvNsaBsxYLxB63KE2w4WT?=
 =?us-ascii?Q?16J2uWyFe+OPpaAtGrZUcN1TWyw3uzxAAdXk4DR0I8OnBrq5Xz0uQglrATJZ?=
 =?us-ascii?Q?DMRM/8hsFaQsF6LWAqfpVdQpyHAFG6MQaZXNzSTn4Bt++quNNoVjXxF2FN31?=
 =?us-ascii?Q?O18fAebxDBVubyKrQ49ljUl5hH/q5QP+UzQEab8rO6KwNNfMF0tVcMZ7IIdN?=
 =?us-ascii?Q?iY5bYlPcy0aZCgUdA4psFGquoRH1M7BYQBE/FLJE5yVeZhs9PH+oo9nx6uz1?=
 =?us-ascii?Q?Qxi6ota0SjzXwcPzFimEKMl9ga5vtKeBPXMuGwYnCPC0Z9AB1xCA9NpliRuD?=
 =?us-ascii?Q?/KR24YjTUHxUMXz9sg9MNXMCzoCH0CR+aELt0eayIlsOE6KVQ8OpzNtDpjbR?=
 =?us-ascii?Q?411rdlyo38JhFLoXVySczdGuKnkh7YkhNQju/OgJINqQfodukbyb/XZWZVFX?=
 =?us-ascii?Q?e12UFqm2R0FvV7UaxCRzM87niIf15gEbyPnl2nBw22d3JdvwMqdWYcyHXEt4?=
 =?us-ascii?Q?PzM0NyUWNViB5yMb2kESq2rg+jxkudAQCjSIl50YqX9p0qNc5Fx4MR2knmUS?=
 =?us-ascii?Q?z5Ako4Msoe1pLpiu/hZX59i6SKPLp5gHSNd1elyUtmDx86WWxA/QjZoMpar8?=
 =?us-ascii?Q?h5VclyVhfIsVqNMWqepHbzyyb/Qf/D2/yPanc+bjB8BWxM3MHqgTGbgpnXnF?=
 =?us-ascii?Q?4kDBJbmTWl/Kc2nc6DCoWxblZocR7EVj/Yh/SgCiGDw3MbSCSNb0YjblUoc/?=
 =?us-ascii?Q?1fre99ljUkB2oL0icYqZ2itu+T5R1CkxDkcMyLbPKX0aqtWuYbFiZ8vgL0En?=
 =?us-ascii?Q?NHe2L8evf/hOVUjUpSfW5EYbm8IuEheLVLYeVSt+zPKWvPCUafYtF0KNbtds?=
 =?us-ascii?Q?0kmmhYOSGFPdQRXjWVH+cYPwVKVMRECU7v1ePCRqf8Iq0ddvzlYgk5B1BN4P?=
 =?us-ascii?Q?9N1VdY6ZQZ11XC8GR1MYe0TeTNPc/58tQ3aPzocmWugHSYNEG7GmRBB9c2fb?=
 =?us-ascii?Q?MQtJE6Ja8JjFdb+S5XMcx+B8NJLdPNQS0Mo0LzoOKGKuhCfo6YL2qZZmsK9I?=
 =?us-ascii?Q?OpPyCoFXx1S1f53MaFu5LKM7zcVnJYkokMwlsAvXx+XVP/8i4+qGSzfcr4kH?=
 =?us-ascii?Q?5fV2+P3Dmc0eERGPiez/qjtKMKpfqtT5HCk4B1ED1z+548WFF+vHiFIzAiNH?=
 =?us-ascii?Q?z9xyNSAKP5Iv1/6aFtEFv7s3hZ7QhGpvUnO+XxWVRxIVmQOPMusFqlnCGeLC?=
 =?us-ascii?Q?wBEkf9DMEcGjBSvP6fV03XZzSSUlZ8uj/QZC4ST5WOBDT725XoBV8hmF6ulJ?=
 =?us-ascii?Q?HOyAE/iddqIhM7glt3iOnPGrA/Q3yq1RHhYjRcHnbJAwa4XapkTwSc0Z+VZn?=
 =?us-ascii?Q?Gg80M2bhrTtgfG2jJ+fAo1ioKO7/kzW/tF4ottfQi9WPPtwRHd5N8ofj8R4f?=
 =?us-ascii?Q?ca1HvyompTKGDyZFAswXTzgrHwyzIejtEQEyfL9vKuksc5Qw7sLbz1YcoZFT?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e702751-0fe0-46ec-3cd0-08dab7f7bf4f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 08:46:32.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ostWO2ZEuvCWE566Ff9sJXzRfJHYwvHLRcSVC1xXlJkuwLHzcXNiemHmA7JMp59+EdOZS8MYnqVMNBREQsvAng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5874
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 27, 2022 at 03:50:17PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed WARNING:possible_recursive_locking_detected due to commit (built with clang-14):
> 
> commit: bed2685d9557ff9a7705f4172651a138e5f705af ("[PATCH 2/2] fsnotify: allow sleepable child flag update")
> url: https://github.com/intel-lab-lkp/linux/commits/Stephen-Brennan/fsnotify-Protect-i_fsnotify_mask-and-child-flags-with-inode-rwsem/20221018-131326
> base: https://git.kernel.org/cgit/linux/kernel/git/jack/linux-fs.git fsnotify
> patch link: https://lore.kernel.org/linux-fsdevel/20221018041233.376977-3-stephen.s.brennan@oracle.com
> patch subject: [PATCH 2/2] fsnotify: allow sleepable child flag update
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Sorry, this report is for the v1 patch which seems to be obsolete now.
Please kindly check the details in report, if the issue has already been
fixed in v2, please ignore this report. Thanks.

--
Best Regards,
Yujie

> [   31.979147][    T1]
> [   31.979446][    T1] ============================================
> [   31.980051][    T1] WARNING: possible recursive locking detected
> [   31.980674][    T1] 6.0.0-rc4-00066-gbed2685d9557 #1 Not tainted
> [   31.981286][    T1] --------------------------------------------
> [   31.981889][    T1] systemd/1 is trying to acquire lock:
> [   31.982432][    T1] ffff88813f542510 (&dentry->d_lock){+.+.}-{2:2}, at: lockref_get+0xd/0x80
> [   31.983314][    T1]
> [   31.983314][    T1] but task is already holding lock:
> [   31.984040][    T1] ffff888100441b18 (&dentry->d_lock){+.+.}-{2:2}, at: __fsnotify_update_child_dentry_flags+0x85/0x2c0
> [   31.985132][    T1]
> [   31.985132][    T1] other info that might help us debug this:
> [   31.985967][    T1]  Possible unsafe locking scenario:
> [   31.985967][    T1]
> [   31.986694][    T1]        CPU0
> [   31.987025][    T1]        ----
> [   31.987366][    T1]   lock(&dentry->d_lock);
> [   31.987828][    T1]   lock(&dentry->d_lock);
> [   31.988283][    T1]
> [   31.988283][    T1]  *** DEADLOCK ***
> [   31.988283][    T1]
> [   31.989061][    T1]  May be due to missing lock nesting notation
> [   31.989061][    T1]
> [   31.989888][    T1] 3 locks held by systemd/1:
> [   31.990361][    T1]  #0: ffff88815249e128 (&group->mark_mutex){+.+.}-{3:3}, at: __x64_sys_inotify_add_watch+0x2fc/0xc00
> [   31.991473][    T1]  #1: ffff888100480af8 (&sb->s_type->i_mutex_key){++++}-{3:3}, at: fsnotify_recalc_mask+0xf1/0x1c0
> [   31.992528][    T1]  #2: ffff888100441b18 (&dentry->d_lock){+.+.}-{2:2}, at: __fsnotify_update_child_dentry_flags+0x85/0x2c0
> [   31.993671][    T1]
> [   31.993671][    T1] stack backtrace:
> [   31.994260][    T1] CPU: 0 PID: 1 Comm: systemd Not tainted 6.0.0-rc4-00066-gbed2685d9557 #1 1afcec0fe797aeed18cb95313bac4a75fb6852d3
> [   31.995440][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [   31.996441][    T1] Call Trace:
> [   31.996791][    T1]  <TASK>
> [   31.997101][    T1]  dump_stack_lvl+0x6a/0x100
> [   31.997590][    T1]  __lock_acquire+0x1110/0x7480
> [   31.998105][    T1]  ? mark_lock+0x9a/0x380
> [   31.998560][    T1]  ? mark_held_locks+0xad/0x1c0
> [   31.999056][    T1]  ? lockdep_hardirqs_on_prepare+0x1a8/0x400
> [   31.999650][    T1]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   32.000276][    T1]  lock_acquire+0x177/0x480
> [   32.000739][    T1]  ? lockref_get+0xd/0x80
> [   32.001178][    T1]  _raw_spin_lock+0x2f/0x40
> [   32.001656][    T1]  ? lockref_get+0xd/0x80
> [   32.002093][    T1]  lockref_get+0xd/0x80
> [   32.002529][    T1]  __fsnotify_update_child_dentry_flags+0x142/0x2c0
> [   32.003178][    T1]  fsnotify_recalc_mask+0x126/0x1c0
> [   32.003711][    T1]  fsnotify_add_mark_locked+0xd9e/0x1280
> [   32.004292][    T1]  __x64_sys_inotify_add_watch+0x755/0xc00
> [   32.004898][    T1]  ? syscall_enter_from_user_mode+0x26/0x180
> [   32.005660][    T1]  do_syscall_64+0x6d/0xc0
> [   32.006125][    T1]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   32.006735][    T1] RIP: 0033:0x7f839dd0a8f7
> [   32.007188][    T1] Code: f0 ff ff 73 01 c3 48 8b 0d 96 f5 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 fe 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 f5 0b 00 f7 d8 64 89 01 48
> [   32.009103][    T1] RSP: 002b:00007ffe52095c98 EFLAGS: 00000202 ORIG_RAX: 00000000000000fe
> [   32.009945][    T1] RAX: ffffffffffffffda RBX: 0000555bc72cf930 RCX: 00007f839dd0a8f7
> [   32.010685][    T1] RDX: 0000000000000d84 RSI: 0000555bc72cf930 RDI: 000000000000001a
> [   32.011469][    T1] RBP: 0000555bc72cf931 R08: 00000000fe000000 R09: 0000555bc72a1e90
> [   32.012266][    T1] R10: 00007ffe52095c2c R11: 0000000000000202 R12: 0000000000000000
> [   32.012976][    T1] R13: 0000555bc72a1e90 R14: 0000000000000d84 R15: 0000555bc72cf930
> [   32.013705][    T1]  </TASK>
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202210271500.731e3808-yujie.liu@intel.com
>
>
> To reproduce:
>
>          # build kernel
> 	cd linux
> 	cp config-6.0.0-rc4-00066-gbed2685d9557 .config
> 	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
