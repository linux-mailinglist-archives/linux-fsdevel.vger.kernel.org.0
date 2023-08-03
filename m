Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF51876DD44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 03:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjHCBfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 21:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjHCBfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:35:15 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4B410FB;
        Wed,  2 Aug 2023 18:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691026513; x=1722562513;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+Jo4moCstqnMMLcCEV7MW9CxCdxeBEl/2hU9RIsmM0E=;
  b=DrFaJUtcny73Si7SkmgCnwr7FCpOTLOf7ggAaPkn8b65E8qdgvaH1r3w
   zE7MTQ8hWScmLYobJzzMVrTDNvT4EjOVy4tmjF7mkD073NDpYYUybmVRn
   y+78s2uYaiAjCgqLZoiffQKqNJaxObz/3dBzrNFj/2Kox8X51MIa3fOPF
   ++ujaIvdO9kNVVR1jFW3JToEfyn8zhLZS2TX5mIdIjASHYqbPWJHzj1X1
   zeBK87yE1h6w9ZSv5WOnuavYF/gW63TvcIXevb1osjFTT9ikMZ30JBRtM
   VtxxnZ6k2/YGLngXrTXB3A1sNSPivL5bW+rcIuMOM+wXTQ6yhcPvX4y/b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="359784272"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="359784272"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:35:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706372724"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="706372724"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2023 18:35:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:35:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:35:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:35:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:35:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0ZmMcpHxCmvDZArRTDHqGwgIuLiE4ILAeZSIbgQGQI6PrenHhrfUxiTaM8UYqbdvE0vdDJw3dFT75c2XU9Kcw+NWxjoRq+ZrSk+VBhKGj/w/GfaOSfY3fwUBcnVFmtQMDt6X441x9HZ/Tq8/ci4luN0GxxBq196WIjIZ4E6euvf3iY5jtFf6a5+fTsHOJoitUY8IvNxCLEZ8Vh5XiH4Jl9Z1E1+20XZrWl0w/JgTcNFvI8N1wEmmAH+1Kh4Z1Wy3KRp8NvnZp7HrlAGsM1Owv+qjZFEL1gDKKxeWJf9+HcvYTZnqswoy4TjaMc+jnTqt5kHvysHfD3sTcYd2oLxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbEFRkufuU45ml77arN4jPweUqK7EIUPpE3+5Sw6/gk=;
 b=fRXLsBmuBHAS0gApb3W54w3Vihh7Gwz6MiZ3w0x5sOa7TVMw1wMuGMm7gLeLGs14CThqAYh4V1YlKv3iae8Ffb8lZbRm+w1sEeKtlgdJ6v3GhOZ5e/68ys2C3LB9ur5Hs2cM89IPATLoIkrWq86PRupB84ZeKW9LALXTHwGEpjOz5X+3dgoSMa92ivVwyC3kMGo2Ivi4oHmXHyr2XE5Lbc8Os+I8ILW2zx91t6QI73LGbnXWdOG5AEC+XrF+875TYOkJ36m3FoRQctHeKq8r8/SdtE1MdFCbg2CGg8MmcakvEiHyt3+5xbtRSwmhwrouKmIdBH8+nZ57iHOQnjf2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CY8PR11MB7797.namprd11.prod.outlook.com (2603:10b6:930:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 01:35:10 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34c:f9c:28bd:e642]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34c:f9c:28bd:e642%4]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 01:35:09 +0000
Date:   Thu, 3 Aug 2023 09:37:30 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     syzbot <syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com>
CC:     <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <tytso@mit.edu>, <heng.su@intel.com>, <pengfei.xu@intel.com>,
        <bfoster@redhat.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_file_write_iter
Message-ID: <ZMsE2q9VX2sQFh/g@xpf.sh.intel.com>
References: <0000000000007faf0005fe4f14b9@google.com>
 <000000000000a3f45805ffcbb21f@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <000000000000a3f45805ffcbb21f@google.com>
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CY8PR11MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: b576b997-b87f-4564-dc17-08db93c1df9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gI6e6e2/egt+tcSoF7ynBZE8GUDaoS7H5XDCz8GkEDjaVp1Nn1VW9e7kQ1StiQIi71u3kKvo9EuLyqwc49pvGKjrkv5CWa9vjnzvBDwSi98X95Y9r99KawhEmD92SBDKMWY88TGALMD3NjvGVOMGOzaNNceb0jGT2dLpKw+8ZbwibJBYkVRt1MmiitscGEiYKnDTdWvI8ShCHvqwD6NSnfsTxglxtc5Bz+sRiwLh3oT8nYAMtDNx0xqSBHQR4CZE+Jrms7dgbU2oYIoY7pclsE3/2WA4oCVR1iYnLUZmX+WZ0XkwAdDLQtPlOqSenLuuHcc2tDuqY43vVlNrta2EpuOOOGV2wl4bVAUB1DafNZtjbmazIumUDwvstRBZ6oT0QDWf7wKqyVx5MqypYRttGVwDNizShOTFdiDVtENxZJKVqW+re7n5FGh72lC3Uk0nJ9XNlF+7ObvaNgIxhx0KN6WCeVLLqXTvBk0tLM9GiHl5xNFu6Zntd+4pr+hRLWn8axpQsPLwrG2G95EZmFu3sPfnk2/k0c1BeuKZx8z5+bug4Y8PkO7tZN6wdT476DIvBDx5MTAR0PeNCNK0plhXXtzUsFKY3XE6MiSAp0JYvHyj45pS/xpbLzw3fDh+sZy+D+QtEBmHe1Wi+eSiggYXaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(966005)(6512007)(45080400002)(478600001)(38100700002)(82960400001)(86362001)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jk+Q87FGbQhSaHV2NTxA+NwvzSvHstLjO6Jv7G5aymVHte4Ag+B8If2dr7Hh?=
 =?us-ascii?Q?NIG94ZKWmJziFTJ3B9iE4xtfg9YPf3kugMeCyNoN938gGjt8FLvQaFHx9MEX?=
 =?us-ascii?Q?esQU07wB1FKCCSWcB4dehufOSEr6Eg2hKxgVoD50oZFBEK4ieck8SxSapygH?=
 =?us-ascii?Q?CAXKMd1cIOwRCQW9qy7SDc2eqoqgg8424GmJ92YS8NwVwNhEAlZEu/PfoEom?=
 =?us-ascii?Q?aU+txU76TbbBlcL917znaN8m7zRCttoX+fNdwz6U+a9w9pe+a/GQJEz8cQ7m?=
 =?us-ascii?Q?zEf1kaO6QeYt1JgdPGCJslhgHTVFLMSmZuAoucBBGM0NOE3NIuM5hmYjVIM3?=
 =?us-ascii?Q?nGp+vLwnWmBjNnSY0Y9BZ1YlLQ1ZWU2QFicCgJTWRIY4zG5HnEhh1F8qX8/E?=
 =?us-ascii?Q?H2WmJ0dZUMJNIXZXEXPgm7hbTYf40qlzxKUvyjEgxRo29vhx4bQGe4Ix3UPo?=
 =?us-ascii?Q?wtdNC1kBUop5OZn9ZPyeRBDy2jKbbmhLOc0Bvb3rFGTTSOvlDIBPuP+p8UK4?=
 =?us-ascii?Q?c9CpHViqsBCvVxNUpYu6UApFSV7dEr2i7bDGk/f2YCKVEElqh3FmkRIjwfTV?=
 =?us-ascii?Q?U/WCqGkCjmjTe4FPVrqb3mkEOrvuwkjFBqRlnAqc5RXvuFDLP0c1Epb+omjy?=
 =?us-ascii?Q?yxTzYCh3uLLGbbms5eN1P4OKeKB1qXebt6fMCNboNNUEJR75vl8DdmQPISQF?=
 =?us-ascii?Q?K/tFiubphxg+aOVcgzLMiTyd2KKI53eCfprkkGwhbmhUr2sMVLuEFn5+Qs0a?=
 =?us-ascii?Q?HqzjsdjUKLG97RvRFw0fyizxTyBZ8DQdXIYtLhk638NGYz9J/yC+VLXWesZJ?=
 =?us-ascii?Q?WiOmTM49kh9U/iAHdr5AppqcW9CMrMDfp6cnO6adhEvKaqqfDr+RyPUtFWEr?=
 =?us-ascii?Q?fX2w/lJZBcCugaaeU78p7MmrEKN7MtJ9SwWQarKs4acNnOW7Gp85i1g9DH1Q?=
 =?us-ascii?Q?ozKiU/YDyUSgcPTml2mD2G65MYKwBe9KBKvc/t/Gc7sPHdMObg0MPICmcCvt?=
 =?us-ascii?Q?UHgJ2fse15bwBKpfjjYwkVN88Ac+C2R/d6NhwiTcLAWBjHpcdTL+gm/LqEok?=
 =?us-ascii?Q?4Jp46xsXj23LaBFfmmyIh0OXKoMLSOhK13OeKhnI/jvVWxY3T6xrIOQGPQwg?=
 =?us-ascii?Q?CYJ0k6uyL34y3fP8KqO0Cstx4/PyudiuVNk3iJpb1Yi1FmbLGZh2F31pnfKp?=
 =?us-ascii?Q?L7lhbpkxUGVPfjvZh4C2YXcePebEOCmAt6P7z4A3/Zz3qRxuTyAIWYzHFeEN?=
 =?us-ascii?Q?05p3x9yVX9annKmIHBi+f+fhs+KWZChgbqEzDYCXWTcx131YUl1a96NOUQDb?=
 =?us-ascii?Q?7PxSYyJ4nwAhw2QmR7lViGWEQDmKpY6+kQRYTGCxBDhwOOKLf4QKRnF2gwxF?=
 =?us-ascii?Q?ycdFe/ESIcl26qXa1pn/m7lPTfyF5MEBqChyF3nYFBNuw9LehmfydQJf7l2J?=
 =?us-ascii?Q?4Gl877PsDHG5NqFoVs0CzE9YTQGFZoccVAKaMzYp/HmkOgnZaE7beyOpeUDz?=
 =?us-ascii?Q?RAFdNUsXYH8uoHZA6iTurIeiNDSAPlzLbpOjjtDwPQr/c7/2mg3Ok95MhbrB?=
 =?us-ascii?Q?jetimNlaAFMg2CxWXDqU+fC8w+uBAGxM5t0nJJ13?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b576b997-b87f-4564-dc17-08db93c1df9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:35:09.4174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eO+X9z3zDe1xYFBwwtneUcza7vvcqkbOT3nKtPVdis9mEujDkII+RsEuMhl9ToT/+ac8lDmHSIn3lp9HAVHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7797
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-05 at 23:33:43 -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    6843306689af Merge tag 'net-6.5-rc1' of git://git.kernel.o..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=114522aca80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a
> dashboard link: https://syzkaller.appspot.com/bug?extid=5050ad0fb47527b1808a
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102cb190a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c49d90a80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f6adc10dbd71/disk-68433066.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5c3fa1329201/vmlinux-68433066.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/84db3452bac5/bzImage-68433066.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]
> WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_file_write_iter+0x1470/0x1880 fs/ext4/file.c:720
> Modules linked in:
> CPU: 1 PID: 5382 Comm: syz-executor288 Not tainted 6.4.0-syzkaller-11989-g6843306689af #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> RIP: 0010:ext4_dio_write_iter fs/ext4/file.c:611 [inline]
> RIP: 0010:ext4_file_write_iter+0x1470/0x1880 fs/ext4/file.c:720
> Code: 84 03 00 00 48 8b 04 24 31 ff 8b 40 20 89 c3 89 44 24 10 83 e3 08 89 de e8 5d 5a 5b ff 85 db 0f 85 d5 fc ff ff e8 30 5e 5b ff <0f> 0b e9 c9 fc ff ff e8 24 5e 5b ff 48 8b 4c 24 40 4c 89 fa 4c 89
> RSP: 0018:ffffc9000522fc30 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff8880277a3b80 RSI: ffffffff82298140 RDI: 0000000000000005
> RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8a832a60
> R13: 0000000000000000 R14: 0000000000000000 R15: fffffffffffffff5
> FS:  00007f154db95700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f154db74718 CR3: 000000006bcc7000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  call_write_iter include/linux/fs.h:1871 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x981/0xda0 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f154dc094f9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f154db952f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f154dc924f0 RCX: 00007f154dc094f9
> RDX: 0000000000248800 RSI: 0000000020000000 RDI: 0000000000000006
> RBP: 00007f154dc5f628 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 652e79726f6d656d
> R13: 656c6c616b7a7973 R14: 6465646165726874 R15: 00007f154dc924f8
>  </TASK>
> 

Above issue in dmesg is:
"WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]"

I found the similar behavior issue:
"WARNING: CPU: 0 PID: 182134 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]"
repro.report shows similar details.

Updated the bisect info for the above similar issue:
Bisected and the problem commit was:
"
310ee0902b8d9d0a13a5a13e94688a5863fa29c2: ext4: allow concurrent unaligned dio overwrites
"
After reverted the commit on top of v6.5-rc3, this issue was gone.

All information: https://github.com/xupengfe/syzkaller_logs/tree/main/230730_134501_ext4_file_write_iter
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/repro.c
repro.prog(syscall reproduced steps): https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/repro.prog
repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/repro.report
Bisect log: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/bisect_info.log
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/kconfig_origin
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/6eaae198076080886b9e7d57f4ae06fa782f90ef_dmesg.log

Best Regards,
Thanks!

> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
