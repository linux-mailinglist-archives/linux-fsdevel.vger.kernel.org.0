Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB507924AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjIEP73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353649AbjIEHDO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:03:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780EC1B4;
        Tue,  5 Sep 2023 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693897390; x=1725433390;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Cezn+RhnsDiX4dL3FLdLO1AoHT4/Ctkk6hUua6DhT5k=;
  b=KdmdsuK5iw4AEq9CAtjPVQN3aEOvegRSjjpCSyJ5MgPARCkzO7uRUFtL
   LwC4atQFh4v4jFlAclf5cY8ZljYkVdMZHDlVAIdaG0uvT2Zi50n1thLjS
   0PAAKKeun68Us59oTFD05dWkjxJU8Tq9uFAdFf4J3Kv0NzRazyAQfzC7x
   qJVfSpobNSq+IuxNJzb/z8IBuyMiq05mEN1mELbvL7d+J/Y/U67MoTDur
   a4hrd+bmPI5gPQ40rpEss7qKmVtxxr4LReNmLVhAQDY5gO7WA3cXHz0bs
   Dg7iUdDKnrJSKkvhtqgZNvBz5UbN4b6oXvtRxo3fWXO93+x/J+BOUAdu2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="361754394"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="361754394"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 00:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="806496666"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="806496666"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 00:03:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 00:03:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 00:03:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 00:03:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 00:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyoD9sPOFpXi2kDYaNL74iL5sBBbNK3bY6U0RdAcZ5DAva05sughzRD781+A7Z/Mj6dELgAEqCZSBEVKjb/x1YFW8VyuZxJFcAbVWYwVrFQCsDOyq9jnXHNOqSM2KTxKE58Qxdw+lNN3NQJToODRKRQgG2zNuXxYzUBrxH9RpyW3/AInaCyc+/ZlcQ5P3/s5PTgQKijNax03PnjUUiyN5y+XZfTh40SOCZ/kiXwzG11T5IPmN9ki1qj36WPhQQcMD3RCJvaa25k5iEhRKwA68vdFQXwGvtCUBhQqJv2q2jkhrTzgkL2wZ+E/82GdEH+NLwbi75s1YmibTkrP4l5KUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8epVW2EaDhZAzCro3S2yfiPsUipvF8d2cavq8rwzqbg=;
 b=BmJsMq4PfX6VP/7jtQABVFe00hADyu0IZytLyADKKZnbpTHDTLltOAgBbon3A0GTMFpWk+IdpHVoRbF5lhzEyezbJZsQBJEN/HgL4YTHH3APDPs19+PwyHeN+SZf+gW6iYUf4HENmq5+6LcRCPoqWlxJzGL7iqXvcphtMd9RolFg2YpFdEDxIa/ba1w32pq7nV2ADBF9d7P71itvjO65H8VOq5Bhse7iafwa8v9revCMHyvdTWUZ27NI1+EE1M0eXizAL7OmHVbjR1CTI+4GhOl/69cQ1a62vp0toZkKQsFQqAApxQL6OqhL0LWIl753LtPHAzzgCLsmtYNamEUCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 07:03:04 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 07:03:04 +0000
Date:   Tue, 5 Sep 2023 15:02:53 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Valentine Sinitsyn <valesini@yandex-team.ru>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v6 1/2] kernfs: sysfs: support custom llseek method for
 sysfs entries
Message-ID: <202309051442.bd6f9879-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230902155038.1661970-1-valesini@yandex-team.ru>
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0989ad-578b-4f57-943b-08dbadde2615
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUIziWoBuixQh0ofxR8fIH2wUGykTYGICBXh/zws5nyhwdnxneCvVkstMUM+NIOIeZUFDL9sc8zIrI7zKP2+QjaV3y7jSWm7yBb8dvIwVZi1W9Xd/KKu/5oA4Aak4vm8TWut9cmdlysxt5N0ftvZuSpnY1tSy+vXzikytVVYZNfuoPiPiKG6sKQ5dBhYDnjFuS7fquV2tI7sG4Ph/HMMmWw7UgGW4CSvhTWMqbMNh4gVq9GtC8wDYgSB8IRynoRLS3vOgdqf4W8bUvvnGXCJ96XlPVO8YPCp+Mhsor2ZsY8OMLdpMHQrpi8rZ3fJlq+6mMs3XH+lhDMnAV0LxbcZ1XEMlCEF5UKmPzoVPoRsFacCe9ZDaEnP/16LxS+Jn7+kCRJE9HApRFAkJct8882R40zyhd73v3iEu/S1Lou9KJOXV/O4Sc1uxemelCwW0EYGyvwYrbQbYMJHIjNLdB23LzmvVrAZIWXIHjI4Fkp892GqpgocMOBARBAWnPWRQVuoqbfe9mHr7WnqR1Mbb/t29IS6q1Sm2HDs4HU6aEdPbFd/RQGD2ub2Ac9395V6WXhrL8euf2THaYhLDz0ffAdGIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(1800799009)(186009)(451199024)(41300700001)(82960400001)(6666004)(86362001)(966005)(38100700002)(2616005)(83380400001)(478600001)(45080400002)(1076003)(26005)(107886003)(6512007)(6506007)(6486002)(54906003)(6916009)(66476007)(36756003)(316002)(66556008)(66946007)(2906002)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+fqz56mJJQREJ0BYWFf6SB21ixzelV3i4SsUV2wNnZPGI25RslbiDiAJSmOs?=
 =?us-ascii?Q?IyQvYsNj1K624XxfJdBX8KfdFUEHu4v+irB4b4gc6VsZOMaUEa3Yht3CVEur?=
 =?us-ascii?Q?jOSWzezQdVTnPSX8NiLQfDLiLSJjbGiGGvWk8BOHwNMshwipKnFekJXO3qgq?=
 =?us-ascii?Q?vYUJLp/cSf8HWWZtIaT4wKRRQw3n9FRlgSA+rD2hOdkFbT17Yhl0gnPprGdJ?=
 =?us-ascii?Q?/vdIFMZ1dLgqq+EPcRUheiQmn7MAblvq5kqVPf4fgavVTvlEBMMNn0ECDUqo?=
 =?us-ascii?Q?D/vdDNq/l61+pXgIty7lSf0Jqr40PhGhbQJ7DisZuFBwo0W5Lmtq4cJOVoAd?=
 =?us-ascii?Q?Ar/nyL/u8bL3V5acIuaEmCA8It5mvb+Fn71/FeRxML2r/syAQvyDqsOuLOX1?=
 =?us-ascii?Q?psc12vgLlt+AMJ6ZgD/5S2hnHz5tqPUB8GQeypzOHU84FlHTwZmI9Rxv1BMA?=
 =?us-ascii?Q?FTSW0pcrUsHtOg53LmYnbd8/ydDx4vwWMYTjyxVYemKZzci4tN1Ok6W17C5q?=
 =?us-ascii?Q?/j9TZ0gKYkZdLGbki63ntdBprEK9e6raAIhFvZMeS+/D6Sd+8cddjGLp2XKm?=
 =?us-ascii?Q?dMavgmJN4RgTJMEP33ymXY5r3VEqA3hrNn7KVAsm4qOs8nlZ+D3UtTMTkT2E?=
 =?us-ascii?Q?0EKfyjXbcq/HT37flX981tRR6yI464fRJGBHU4Nrrs7JY+4jY1aIE7H0gXTF?=
 =?us-ascii?Q?VFsR6ymrdm2e+LpjzaK6GMDHQdYor4K/ZAUzaFNVp+vbur5pNaJWTLZ4N/AJ?=
 =?us-ascii?Q?jJf6fbr97IA5yYJFQR8eQ/6tLgqg8GxJlQbTiKkdSE7wgEY6FP1VT/WoIY72?=
 =?us-ascii?Q?X94QMBFar9CPN3G+34eyMMNH5wBipBO36KkC0lRUrraPbHGFnVh+vrL3Leep?=
 =?us-ascii?Q?sukIIRP0T/Mw0UdHALsEo2M7e7hNVAnYmW3NnFoi2DeykMFGBI5jlm8k+WQV?=
 =?us-ascii?Q?lddVLzlDzcxB+At2ZO0CyqOTmOvwJ91v28CY1URGEgKCvkbUIJc7ymLkTaCO?=
 =?us-ascii?Q?dv7w1dDjsXk83j688TJX9zv62moQQihgR5G7aiqQB+YqeATP1zDIaECXmJB8?=
 =?us-ascii?Q?S5mLMtbIriM09+axOK+1Ih6P5uwSx4SWMjSNW+wzN6usymYguxKirHLJzb8i?=
 =?us-ascii?Q?iJOxKXzLE8ePWY2TN3FbP8hyqAVIhcYiDCI8KDzRbOmX3bcaZmglRwH5duek?=
 =?us-ascii?Q?WYnK8STTyc5pMBr4c9tBPTPrgEfT6SllamCv+fVhioAAEcBDZk2wMYdnsR26?=
 =?us-ascii?Q?QTUbmbwr/bhL2OtJ38T7Tnk6cPiQUL+URaT0IF4z+xM+pMl1HMNwBauZMC/h?=
 =?us-ascii?Q?TOp8pz09WaB0PVRxwERnJaYUSK6WG4CrBbfXRRhle0p2jFSCkWzZe6YqyGF6?=
 =?us-ascii?Q?AzscAoylJUL/bPSFt4OyXv8zWfQ8kyDnU6EcNJdDoXTXfM57lZ0imkYPLRyK?=
 =?us-ascii?Q?YxfclTacXXVj5H4yAt6wcQ/2lM6TExZK8xm2Zpi5lT7w8T/J717sk1ieNYAd?=
 =?us-ascii?Q?+UQxTsegrfjEj4DJQUgNgyj2xFthgNyUCSCSudyDsAWNkxXCX4DrO8bB3b7x?=
 =?us-ascii?Q?g4266QbxM1dCk6dOgbxmaXmaLrZN6HdVQx2qQ11I7YkUh2N+TZhf7aIOhF6/?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0989ad-578b-4f57-943b-08dbadde2615
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 07:03:03.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu0uZPyl9gFHCVMZ3/7+XxKJGhf8Dv/CiKA99fKTBChzDO/11h2TIOQNxORk8zM3pPMMHOP6VMDBW63R9pBoDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7499
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_fs/kernfs/file.c:#kernfs_ops" on:

commit: c6eefad61209dab3de7446cf8151d38e70440484 ("[PATCH v6 1/2] kernfs: sysfs: support custom llseek method for sysfs entries")
url: https://github.com/intel-lab-lkp/linux/commits/Valentine-Sinitsyn/PCI-Implement-custom-llseek-for-sysfs-resource-entries/20230902-235234
patch link: https://lore.kernel.org/all/20230902155038.1661970-1-valesini@yandex-team.ru/
patch subject: [PATCH v6 1/2] kernfs: sysfs: support custom llseek method for sysfs entries

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309051442.bd6f9879-oliver.sang@intel.com


[   96.320907][  T252] ------------[ cut here ]------------
[ 96.321715][ T252] WARNING: CPU: 1 PID: 252 at fs/kernfs/file.c:109 kernfs_ops (fs/kernfs/file.c:109) 
[   96.322853][  T252] Modules linked in:
[   96.323438][  T252] CPU: 1 PID: 252 Comm: systemd-logind Not tainted 6.5.0-10888-gc6eefad61209 #1
[   96.324966][  T252] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 96.326330][ T252] RIP: 0010:kernfs_ops (fs/kernfs/file.c:109) 
[ 96.327026][ T252] Code: 48 83 c3 68 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 de f3 e2 ff 48 8b 03 5b 41 5e 41 5f 31 c9 31 ff 31 f6 c3 cc <0f> 0b eb d2 44 89 f1 80 e1 07 fe c1 38 c1 7c 91 4c 89 f7 e8 76 f3
All code
========
   0:	48 83 c3 68          	add    $0x68,%rbx
   4:	48 89 d8             	mov    %rbx,%rax
   7:	48 c1 e8 03          	shr    $0x3,%rax
   b:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  10:	74 08                	je     0x1a
  12:	48 89 df             	mov    %rbx,%rdi
  15:	e8 de f3 e2 ff       	call   0xffffffffffe2f3f8
  1a:	48 8b 03             	mov    (%rbx),%rax
  1d:	5b                   	pop    %rbx
  1e:	41 5e                	pop    %r14
  20:	41 5f                	pop    %r15
  22:	31 c9                	xor    %ecx,%ecx
  24:	31 ff                	xor    %edi,%edi
  26:	31 f6                	xor    %esi,%esi
  28:	c3                   	ret
  29:	cc                   	int3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb d2                	jmp    0x0
  2e:	44 89 f1             	mov    %r14d,%ecx
  31:	80 e1 07             	and    $0x7,%cl
  34:	fe c1                	inc    %cl
  36:	38 c1                	cmp    %al,%cl
  38:	7c 91                	jl     0xffffffffffffffcb
  3a:	4c 89 f7             	mov    %r14,%rdi
  3d:	e8                   	.byte 0xe8
  3e:	76 f3                	jbe    0x33

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb d2                	jmp    0xffffffffffffffd6
   4:	44 89 f1             	mov    %r14d,%ecx
   7:	80 e1 07             	and    $0x7,%cl
   a:	fe c1                	inc    %cl
   c:	38 c1                	cmp    %al,%cl
   e:	7c 91                	jl     0xffffffffffffffa1
  10:	4c 89 f7             	mov    %r14,%rdi
  13:	e8                   	.byte 0xe8
  14:	76 f3                	jbe    0x9
[   96.329439][  T252] RSP: 0018:ffff8881638e7ea0 EFLAGS: 00010246
[   96.330261][  T252] RAX: 0000000000000000 RBX: ffff888111e4a2b8 RCX: 0000000000000000
[   96.331346][  T252] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   96.332425][  T252] RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
[   96.333503][  T252] R10: 0000000000000000 R11: ffffffff8184fd65 R12: ffff8881538a5c00
[   96.334649][  T252] R13: ffff888161bc5ec0 R14: ffff888111e4a350 R15: dffffc0000000000
[   96.335717][  T252] FS:  00007f2d9c6a8980(0000) GS:ffff8883aeb00000(0000) knlGS:0000000000000000
[   96.336833][  T252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   96.337593][  T252] CR2: 00005600c8ef1595 CR3: 0000000162f96000 CR4: 00000000000406a0
[   96.338544][  T252] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   96.339487][  T252] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   96.340472][  T252] Call Trace:
[   96.340983][  T252]  <TASK>
[ 96.341447][ T252] ? __warn (kernel/panic.c:673) 
[ 96.342078][ T252] ? kernfs_ops (fs/kernfs/file.c:109) 
[ 96.342740][ T252] ? kernfs_ops (fs/kernfs/file.c:109) 
[ 96.343391][ T252] ? report_bug (lib/bug.c:?) 
[ 96.344046][ T252] ? find_held_lock (kernel/locking/lockdep.c:?) 
[ 96.344738][ T252] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 96.345314][ T252] ? exc_invalid_op (arch/x86/kernel/traps.c:258) 
[ 96.345963][ T252] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 96.346694][ T252] ? __cfi_kernfs_fop_llseek (fs/kernfs/file.c:907) 
[ 96.347473][ T252] ? kernfs_ops (fs/kernfs/file.c:109) 
[ 96.348135][ T252] kernfs_fop_llseek (fs/kernfs/file.c:911) 
[ 96.348869][ T252] ksys_lseek (fs/read_write.c:289) 
[ 96.349497][ T252] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 96.350141][ T252] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   96.350952][  T252] RIP: 0033:0x7f2d9cf82fc7
[ 96.351602][ T252] Code: c7 c0 ff ff ff ff c3 0f 1f 40 00 48 8b 15 c1 ee 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 b8 08 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 99 ee 0c 00 f7 d8 64 89 02 48
All code
========
   0:	c7 c0 ff ff ff ff    	mov    $0xffffffff,%eax
   6:	c3                   	ret
   7:	0f 1f 40 00          	nopl   0x0(%rax)
   b:	48 8b 15 c1 ee 0c 00 	mov    0xceec1(%rip),%rdx        # 0xceed3
  12:	f7 d8                	neg    %eax
  14:	64 89 02             	mov    %eax,%fs:(%rdx)
  17:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  1e:	eb ba                	jmp    0xffffffffffffffda
  20:	0f 1f 00             	nopl   (%rax)
  23:	b8 08 00 00 00       	mov    $0x8,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 01                	ja     0x33
  32:	c3                   	ret
  33:	48 8b 15 99 ee 0c 00 	mov    0xcee99(%rip),%rdx        # 0xceed3
  3a:	f7 d8                	neg    %eax
  3c:	64 89 02             	mov    %eax,%fs:(%rdx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 01                	ja     0x9
   8:	c3                   	ret
   9:	48 8b 15 99 ee 0c 00 	mov    0xcee99(%rip),%rdx        # 0xceea9
  10:	f7 d8                	neg    %eax
  12:	64 89 02             	mov    %eax,%fs:(%rdx)
  15:	48                   	rex.W
[   96.357571][  T252] RSP: 002b:00007fff4e4c3fc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
[   96.358740][  T252] RAX: ffffffffffffffda RBX: 0000563f1ffa0a80 RCX: 00007f2d9cf82fc7
[   96.359842][  T252] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[   96.360873][  T252] RBP: 0000563f1ffa0a80 R08: 00007fff4e4c3fc0 R09: 0000000000000000
[   96.361934][  T252] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[   96.363024][  T252] R13: 0000000000000000 R14: 00007fff4e4c4188 R15: 00007fff4e4c41a0
[   96.364155][  T252]  </TASK>
[   96.364719][  T252] irq event stamp: 64209
[ 96.365341][ T252] hardirqs last enabled at (64219): __up_console_sem (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:347) 
[ 96.366558][ T252] hardirqs last disabled at (64228): __up_console_sem (kernel/printk/printk.c:345) 
[ 96.367774][ T252] softirqs last enabled at (64128): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 96.368971][ T252] softirqs last disabled at (64119): __irq_exit_rcu (kernel/softirq.c:612) 
[   96.370158][  T252] ---[ end trace 0000000000000000 ]---
Starting LKP bootstrap...
Starting /etc/rc.local Compatibility...
Starting OpenBSD Secure Shell server...
Starting Permit User Sessions...
[FAILED] Failed to start LSB: OpenIPMI Driver init script.
See 'systemctl status openipmi.service' for details.
[  OK  ] Started User Login Management.
[  OK  ] Started LKP bootstrap.
[  OK  ] Started LSB: Load kernel image with kexec.
LKP: ttyS0: 296: skip deploy intel ucode as no ucode is specified
[  OK  ] Finished Permit User Sessions.
[  OK  ] Started OpenBSD Secure Shell server.
LKP: ttyS0: 296: Kernel tests: Boot OK!
LKP: ttyS0: 296: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.5.0-10888-gc6eefad61209 1
LKP: ttyS0: 296:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-300/boot-1-debian-11.1-x86_64-20220510.cgz-x86_64-randconfig-071-20230903-c6eefad61209-20230903-11038-o17p1l-0.yaml
[  104.602900][  T165] kmemleak: Automatic memory scanning thread ended
[  OK  ] Started System Logging Service.
[  106.970306][  T310] is_virt=true
[  106.970347][  T310]
[  108.079565][  T310] lkp: kernel tainted state: 512
[  108.079600][  T310]
[  108.704632][  T310] LKP: stdout: 296: Kernel tests: Boot OK!
[  108.704672][  T310]
[  112.730026][  T310] LKP: stdout: 296: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.5.0-10888-gc6eefad61209 1
[  112.730070][  T310]
[  112.732401][  T310] NO_NETWORK=
[  112.732437][  T310]
[  118.521298][  T310] LKP: stdout: 296:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-300/boot-1-debian-11.1-x86_64-20220510.cgz-x86_64-randconfig-071-20230903-c6eefad61209-20230903-11038-o17p1l-0.yaml
[  118.521368][  T310]
[  118.537313][  T310] RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-071-20230903/clang-16/c6eefad61209dab3de7446cf8151d38e70440484/0
[  118.537382][  T310]
[  118.542693][  T310] job=/lkp/jobs/scheduled/vm-meta-300/boot-1-debian-11.1-x86_64-20220510.cgz-x86_64-randconfig-071-20230903-c6eefad61209-20230903-11038-o17p1l-0.yaml


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230905/202309051442.bd6f9879-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

