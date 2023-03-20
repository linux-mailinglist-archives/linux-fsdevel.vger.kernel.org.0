Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28D96C211A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 20:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjCTTRg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 15:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjCTTRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:17:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A8618B12;
        Mon, 20 Mar 2023 12:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im00wn4RtiihvtjNqes0NddaPIayDVxlGh0kva17tg3ns9CE6qg+rNSc9bviVRBCf14IoRNzwH8kSd8jEUkcTF0lhF9Yxe+M2iDDQ0XcCjKk6lX1autzh3PCy6razwmMtrMCSpa9zDOKAlGWL5ZokTbYx+4MvITqaeN8D4NPXWORxEAlWBw4so5DnS7+765u7Arv5ms6Yq0PiCg4JHjyWqm29rUUSUdpe/LoT0yJN/SgYDCTSz642tCFsEfiT7s0m04QYEwJEtdY4z+1ov9blUfJ1eVk47WIa7NCsY3msti3eKYhvLcGzG1RhHozptj/Ok69rSFoOecJ8chqEtdHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NLlAPZwMiSazJEbO/+mgSBbKlTZVM+3pZVnxsQgw6U=;
 b=bZBAu3a99pJ4HEVeyPbRx3O0guuFPmdv2/P61v87K2SUZ4XQ/zG4yp946JwIaKvJXegGRGhW+1tngTd8+oQPLunO1a61Oj/ln9AFysG0E5xBzckEjhHNu8IdRVIpkq8rhlKPydGT8lFlJuLSZrZ2dvWdQwPNvTmi+E6PoTLl6AYdUEsk8Zpkr7zDtC7x3/KYxVLWeET7mWRm9HsT0vDad5WG9bw8XSoBLV632Ro4q0UVmGhaQuXzac+xWGc6ZmwvNR3p+ZcrTOlBQ8GjD3EdS/vEgpkIVrdhB+6BA0VksTtjVap6cmFhz2BcuiQw92MXss3fkbsFJ+JIadfr+I/3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NLlAPZwMiSazJEbO/+mgSBbKlTZVM+3pZVnxsQgw6U=;
 b=kXQcxgoQ4Txx7PnMIte47ih3PYC/NXw8L9Av1/I6He9bSUwqcn0VCBJei+OAa+lVwDWEKgbUVxX07cX4kbfZrhHqaKK4hGLZwNmdpJKjDO4HvV5Yl1GhPsMbO7GUiib7u2QbUub1KrqTtDyk4uqa3fT6WDlxxtsep+2bJe4x/R8=
Received: from DM6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:5:1f4::30)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:08:54 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::b4) by DM6PR02CA0089.outlook.office365.com
 (2603:10b6:5:1f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Mon, 20 Mar 2023 19:08:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 14:08:53 -0500
Date:   Mon, 20 Mar 2023 14:08:36 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
CC:     Chao Peng <chao.p.peng@linux.intel.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <luto@kernel.org>, <jun.nakajima@intel.com>,
        <dave.hansen@intel.com>, <ak@linux.intel.com>, <david@redhat.com>,
        <aarcange@redhat.com>, <ddutile@redhat.com>, <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>, <tabba@google.com>,
        <mhocko@suse.com>, <wei.w.wang@intel.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20230320190836.z2rqrhybke3egiuu@amd.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <86d7cc82-8ff9-769b-f80f-ff18fe28f44d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86d7cc82-8ff9-769b-f80f-ff18fe28f44d@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: de5474ad-425d-4847-530e-08db29768c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OSETOd3/d0/TdfWptG6EQZdZ2VsQ6H93+9cEYnqeDNTrUInSl5t+LAYRCKdh5V7eJ0VFJq6KJ5oG1zTxgs65+GIrM6iohaF/xnRIeDk4/l8D9Z3wpmGXKxJ7n6YvnoP3fNikk4TG85yP10434dCXMi2dsfar5FiL+EeIZlcXM0UT+PbkzpoXMPIJ1infiWVnl9fYrS8bi0Yz4U6BV+phE/1ukNxo1q6M+b03/CbNycJ3RVQ8pikrnV0lteV0+ZQp4EhaFRVGIpRApi0odLuvvlcaL+1WI9+BhMx1ilaYcm2UORWE63I6onSjCk0TrPErJquj7um8SKDhOdS7vbSAQK82+HLvrs8hM24ZmQgin3/bFWRBk5e8mMtarKMoWGcX8K7K5XHBaKi/VehHKokskRhHdhQKDYcemq5f139zJ7BfyNxYfeGnqdLbWFEjr+uNAPdo6uansTVyWMNmSOcSnIMiPmdzplE/2miVNxFFrkc0giHR0brQi+eKhbVop7ZB1XNeTaik8g1//ykBd2nHtPPXB4/V8300QvzWyrzwa+UWrsmOSxdmglcPMfKFYUTRW0erFvvHPqhDh1PyGikTP+F+Sa8B/xFY+3ajNwQLYgD8Qdhl3NhCFZ/onxsThUyZZo0jajx8mMQL1hjpHUN60MPUWA8ES8ON0Bc+ifI7edMMtfK69uSmpCTboMiHVQVz1bl5je1KWEnjKNLl/6n83TRDg3DCkYC34Olw+P12dI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(40470700004)(46966006)(36840700001)(6862004)(7416002)(44832011)(5660300002)(7406005)(36860700001)(41300700001)(82310400005)(86362001)(356005)(40480700001)(8936002)(36756003)(82740400003)(40460700003)(81166007)(2906002)(6666004)(4326008)(966005)(336012)(83380400001)(478600001)(426003)(47076005)(2616005)(16526019)(186003)(1076003)(26005)(8676002)(37006003)(6636002)(316002)(54906003)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:08:54.0409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de5474ad-425d-4847-530e-08db29768c62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:21:21PM +0530, Nikunj A. Dadhania wrote:
> 
> > +static struct file *restrictedmem_file_create(struct file *memfd)
> > +{
> > +	struct restrictedmem_data *data;
> > +	struct address_space *mapping;
> > +	struct inode *inode;
> > +	struct file *file;
> > +
> > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	data->memfd = memfd;
> > +	mutex_init(&data->lock);
> > +	INIT_LIST_HEAD(&data->notifiers);
> > +
> > +	inode = alloc_anon_inode(restrictedmem_mnt->mnt_sb);
> > +	if (IS_ERR(inode)) {
> > +		kfree(data);
> > +		return ERR_CAST(inode);
> > +	}
> 
> alloc_anon_inode() uses new_pseudo_inode() to get the inode. As per the comment, new inode 
> is not added to the superblock s_inodes list.

Another issue somewhat related to alloc_anon_inode() is that the shmem code
in some cases assumes the inode struct was allocated via shmem_alloc_inode(),
which allocates a struct shmem_inode_info, which is a superset of struct inode
with additional fields for things like spinlocks.

These additional fields don't get allocated/ininitialized in the case of
restrictedmem, so when restrictedmem_getattr() tries to pass the inode on to
shmem handler, it can cause a crash.

For instance, the following trace was seen when executing 'sudo lsof' while a
process/guest was running with an open memfd FD:

    [24393.121409] general protection fault, probably for non-canonical address 0xfe9fb182fea3f077: 0000 [#1] PREEMPT SMP NOPTI
    [24393.133546] CPU: 2 PID: 590073 Comm: lsof Tainted: G            E      6.1.0-rc4-upm10b-host-snp-v8b+ #4
    [24393.144125] Hardware name: AMD Corporation ETHANOL_X/ETHANOL_X, BIOS RXM1009B 05/14/2022
    [24393.153150] RIP: 0010:native_queued_spin_lock_slowpath+0x3a3/0x3e0
    [24393.160049] Code: f3 90 41 8b 04 24 85 c0 74 ea eb f4 c1 ea 12 83 e0 03 83 ea 01 48 c1 e0 05 48 63 d2 48 05 00 41 04 00 48 03 04 d5 e0 ea 8b 82 <48> 89 18 8b 43 08 85 c0 75 09 f3 90 8b 43 08 85 c0 74 f7 48 8b 13
    [24393.181004] RSP: 0018:ffffc9006b6a3cf8 EFLAGS: 00010086
    [24393.186832] RAX: fe9fb182fea3f077 RBX: ffff889fcc144100 RCX: 0000000000000000
    [24393.194793] RDX: 0000000000003ffe RSI: ffffffff827acde9 RDI: ffffc9006b6a3cdf
    [24393.202751] RBP: ffffc9006b6a3d20 R08: 0000000000000001 R09: 0000000000000000
    [24393.210710] R10: 0000000000000000 R11: 000000000000ffff R12: ffff888179fa50e0
    [24393.218670] R13: ffff889fcc144100 R14: 00000000000c0000 R15: 00000000000c0000
    [24393.226629] FS:  00007f9440f45400(0000) GS:ffff889fcc100000(0000) knlGS:0000000000000000
    [24393.235692] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [24393.242101] CR2: 000055c55a9cf088 CR3: 0008000220e9c003 CR4: 0000000000770ee0
    [24393.250059] PKRU: 55555554
    [24393.253073] Call Trace:
    [24393.255797]  <TASK>
    [24393.258133]  do_raw_spin_lock+0xc4/0xd0
    [24393.262410]  _raw_spin_lock_irq+0x50/0x70
    [24393.266880]  ? shmem_getattr+0x4c/0xf0
    [24393.271060]  shmem_getattr+0x4c/0xf0
    [24393.275044]  restrictedmem_getattr+0x34/0x40
    [24393.279805]  vfs_getattr_nosec+0xbd/0xe0
    [24393.284178]  vfs_getattr+0x37/0x50
    [24393.287971]  vfs_statx+0xa0/0x150
    [24393.291668]  vfs_fstatat+0x59/0x80
    [24393.295462]  __do_sys_newstat+0x35/0x70
    [24393.299739]  __x64_sys_newstat+0x16/0x20
    [24393.304111]  do_syscall_64+0x3b/0x90
    [24393.308098]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

As a workaround we've been doing the following, but it's probably not the
proper fix:

  https://github.com/AMDESE/linux/commit/0378116b5c4e373295c9101727f2cb5112d6b1f4

-Mike

