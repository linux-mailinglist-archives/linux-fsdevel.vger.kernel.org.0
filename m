Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D294D7A4F61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjIRQlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjIRQk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:40:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FE990;
        Mon, 18 Sep 2023 09:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu2RQKimjXlXW7W9cE+unZHe7lMxN724HXxOLWbhq0SWPNbOK5nnCkFu/t3OOrdPWjNcLSep/lwXYu2CiZ+7oF8en7zQNf5gkfFebShPO+uA7uY02CH/ibkQNM65aN7l3Tz84f0MIYvloiWzMn9xTNgvAzQYWS/FmAgg3texq3lVg+YB6YywO8nffffn8cdUFB9cKf4KE3lzF0ckvJOXlWZWwJ9PONy0j7YS9KxKG5eJiKJipOgI5RoRXEwDw/sEQwJkmfc0oPTM4pwJkRfyv/kjS/25l++YENPN3HZR/qfaY9+L7gcIWjCLNfJyD+FDoaeqAz+lPNs86SB6t3j9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyzmYcLV+sptuG5IDyfXVowshZf+33f9QlVSHiv27bA=;
 b=TrEAXZtGTAW9okbDr0jzgUxyPkg6ADla8SlxNh0Dq9CFtXP3A6MjUxu8oBsR8oEJ7ejBu1vIrDDplPochZhV0kXH7Iqs3W1HLa/mWwSeU1rbk5DQnNgxp8S5SPmqaBS2S5k76aSi18Y3EoMsniW044XCSvgYg58pJ8bYrxf/NUsDIn75cgMdGq6QFmm2QzGnex6QNIosH1nOVDgCgzESk1IDNZ+FHPNxbSfaGmlf57i0j5kVBQKv/eKINhHHpFB6e7JMrGD89NrbmuQ0XscC83M9Qm38IMNHpAXiCYk4wZumJNq0s5J/zCrp4iLo/NqFEGKYjR7xlNC1bVysKQGUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyzmYcLV+sptuG5IDyfXVowshZf+33f9QlVSHiv27bA=;
 b=wovO6PVLfH+XOvbKxZzF44pw7e/8zDeQedjg2pIOcEgAw3zkcg799SvqAph1oRX2v2fuL5hUvgaI878XikR4pOae11ICUFm9a6wPvWLKvkLkk0oAouoxcIlimllisDM0TOH2IsXW5ny6qFf4lx6WvXGl1GI8huDh2xObWCT5fCM=
Received: from CY5PR15CA0060.namprd15.prod.outlook.com (2603:10b6:930:1b::6)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 16:37:05 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::4e) by CY5PR15CA0060.outlook.office365.com
 (2603:10b6:930:1b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 16:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 16:37:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 11:37:04 -0500
Date:   Mon, 18 Sep 2023 11:36:47 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, <kvm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v12 14/33] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl()
 for guest-specific backing memory
Message-ID: <20230918163647.m6bjgwusc7ww5tyu@amd.com>
References: <20230914015531.1419405-1-seanjc@google.com>
 <20230914015531.1419405-15-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914015531.1419405-15-seanjc@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 312b407d-0494-4860-7bea-08dbb8657e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hf//+xF5X+HV33ANfZQIRomTlciR8+GA0BiVUWGu5B+F91TEL3LTJYqKqauYTW2CWFMAxpwIwjJGv+qSrZ0PPP0MBW5O1quxWbBo6OPKR7BdgHTT1fXM2hCgLqyOvn3zRuMkPByquecngUqCBCsHpOLzysOCDrQ6Pwx87Ge87D9mWg+VY+cTBansVNl6TrO0/qWypNLlzh74pJVWj4hgPOtFa6pqwYRGE58jL0VQpdxPZBNfE9mDOi62QUsbWgh/IWSiuU8UtK5z9woKU6PdR0jK1oc1kAHB3QNCmzMB0ETc7gaJR1sDjD/agQP4B6wddykv4CgE3/8OkUy6juVoVTBEdIbSJINERAmaGz87uEZ63HOmzvxktHELEbV+iXtGJjzIhMqc8dWSYuxtYZvOpFCH8wvEFoKUvxiGUY4HoFjZnfj52+8ABI2L8mKOAQRNvxw19Wh+V19pnoFe28qJ9l8WuieIdabWkgKezdpCAYkwGSN/tcsxiOEIq39xPsWg/O1/nYmH8yc11k02trlse7XBCYVH568XabbjBJikmhb27UDC5+a5gAf18rhMmXGYmuL6pXK0qrp2aJDUiUlY/0XQYlcP4lPlMjQspwiyaDbZsZYrxSWuHU7RKkc9OafZYkfcplyfdUYsytt6h+fW5ylA5TiARBx96xAaO15pR26vbouxBloAO2PlxRu5zdyOAwYmNEHk3EFM4eBQ9q2V4oyv38Gib1hNd2TPJErB/wNDhTAu5eZnyHFJyf/144wGWtQm8DWgspiXjKDKVESgvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(26005)(5660300002)(16526019)(1076003)(8936002)(4326008)(8676002)(40460700003)(36860700001)(2616005)(2906002)(7406005)(7416002)(86362001)(82740400003)(81166007)(356005)(36756003)(47076005)(83380400001)(336012)(426003)(40480700001)(70586007)(70206006)(54906003)(44832011)(6666004)(478600001)(41300700001)(316002)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:37:04.9098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312b407d-0494-4860-7bea-08dbb8657e1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 06:55:12PM -0700, Sean Christopherson wrote:
> TODO
> 
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Maciej Szmigiero <mail@maciej.szmigiero.name>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Wang <wei.w.wang@intel.com>
> Cc: Liam Merwick <liam.merwick@oracle.com>
> Cc: Isaku Yamahata <isaku.yamahata@gmail.com>
> Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  include/linux/kvm_host.h   |  48 +++
>  include/uapi/linux/kvm.h   |  15 +-
>  include/uapi/linux/magic.h |   1 +
>  virt/kvm/Kconfig           |   4 +
>  virt/kvm/Makefile.kvm      |   1 +
>  virt/kvm/guest_mem.c       | 593 +++++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c        |  61 +++-
>  virt/kvm/kvm_mm.h          |  38 +++
>  8 files changed, 756 insertions(+), 5 deletions(-)
>  create mode 100644 virt/kvm/guest_mem.c
> 

<snip>

> +static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> +{
> +	struct list_head *gmem_list = &inode->i_mapping->private_list;
> +	pgoff_t start = offset >> PAGE_SHIFT;
> +	pgoff_t end = (offset + len) >> PAGE_SHIFT;
> +	struct kvm_gmem *gmem;
> +
> +	/*
> +	 * Bindings must stable across invalidation to ensure the start+end
> +	 * are balanced.
> +	 */
> +	filemap_invalidate_lock(inode->i_mapping);
> +
> +	list_for_each_entry(gmem, gmem_list, entry) {
> +		kvm_gmem_invalidate_begin(gmem, start, end);

In v11 we used to call truncate_inode_pages_range() here to drop filemap's
reference on the folio. AFAICT the folios are only getting free'd upon
guest shutdown without this. Was this on purpose?

> +		kvm_gmem_invalidate_end(gmem, start, end);
> +	}
> +
> +	filemap_invalidate_unlock(inode->i_mapping);
> +
> +	return 0;
> +}
> +
> +static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
> +{
> +	struct address_space *mapping = inode->i_mapping;
> +	pgoff_t start, index, end;
> +	int r;
> +
> +	/* Dedicated guest is immutable by default. */
> +	if (offset + len > i_size_read(inode))
> +		return -EINVAL;
> +
> +	filemap_invalidate_lock_shared(mapping);

We take the filemap lock here, but not for
kvm_gmem_get_pfn()->kvm_gmem_get_folio(). Is it needed there as well?

> +
> +	start = offset >> PAGE_SHIFT;
> +	end = (offset + len) >> PAGE_SHIFT;
> +
> +	r = 0;
> +	for (index = start; index < end; ) {
> +		struct folio *folio;
> +
> +		if (signal_pending(current)) {
> +			r = -EINTR;
> +			break;
> +		}
> +
> +		folio = kvm_gmem_get_folio(inode, index);
> +		if (!folio) {
> +			r = -ENOMEM;
> +			break;
> +		}
> +
> +		index = folio_next_index(folio);
> +
> +		folio_unlock(folio);
> +		folio_put(folio);
> +
> +		/* 64-bit only, wrapping the index should be impossible. */
> +		if (WARN_ON_ONCE(!index))
> +			break;
> +
> +		cond_resched();
> +	}
> +
> +	filemap_invalidate_unlock_shared(mapping);
> +
> +	return r;
> +}
> +

<snip>

> +static int __kvm_gmem_create(struct kvm *kvm, loff_t size, struct vfsmount *mnt)
> +{
> +	const char *anon_name = "[kvm-gmem]";
> +	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
> +	struct kvm_gmem *gmem;
> +	struct inode *inode;
> +	struct file *file;
> +	int fd, err;
> +
> +	inode = alloc_anon_inode(mnt->mnt_sb);
> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);
> +
> +	err = security_inode_init_security_anon(inode, &qname, NULL);
> +	if (err)
> +		goto err_inode;
> +
> +	inode->i_private = (void *)(unsigned long)flags;

The 'flags' argument isn't added until the subsequent patch that adds THP
support.

<snip>

> +static bool kvm_gmem_is_valid_size(loff_t size, u64 flags)
> +{
> +	if (size < 0 || !PAGE_ALIGNED(size))
> +		return false;
> +
> +	return true;
> +}
> +
> +int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
> +{
> +	loff_t size = args->size;
> +	u64 flags = args->flags;
> +	u64 valid_flags = 0;
> +
> +	if (flags & ~valid_flags)
> +		return -EINVAL;
> +
> +	if (!kvm_gmem_is_valid_size(size, flags))
> +		return -EINVAL;
> +
> +	return __kvm_gmem_create(kvm, size, flags, kvm_gmem_mnt);
> +}
> +
> +int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> +		  unsigned int fd, loff_t offset)
> +{
> +	loff_t size = slot->npages << PAGE_SHIFT;
> +	unsigned long start, end, flags;
> +	struct kvm_gmem *gmem;
> +	struct inode *inode;
> +	struct file *file;
> +
> +	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
> +
> +	file = fget(fd);
> +	if (!file)
> +		return -EBADF;
> +
> +	if (file->f_op != &kvm_gmem_fops)
> +		goto err;
> +
> +	gmem = file->private_data;
> +	if (gmem->kvm != kvm)
> +		goto err;
> +
> +	inode = file_inode(file);
> +	flags = (unsigned long)inode->i_private;
> +
> +	/*
> +	 * For simplicity, require the offset into the file and the size of the
> +	 * memslot to be aligned to the largest possible page size used to back
> +	 * the file (same as the size of the file itself).
> +	 */
> +	if (!kvm_gmem_is_valid_size(offset, flags) ||
> +	    !kvm_gmem_is_valid_size(size, flags))
> +		goto err;

I needed to relax this check for SNP. KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
applies to entire gmem inode, so it makes sense for userspace to enable
hugepages if start/end are hugepage-aligned, but QEMU will do things
like map overlapping regions for ROMs and other things on top of the
GPA range that the gmem inode was originally allocated for. For
instance:

  692500@1689108688.696338:kvm_set_user_memory AddrSpace#0 Slot#0 flags=0x4 gpa=0x0 size=0x80000000 ua=0x7fbf5be00000 ret=0 restricted_fd=19 restricted_offset=0x0
  692500@1689108688.699802:kvm_set_user_memory AddrSpace#0 Slot#1 flags=0x4 gpa=0x100000000 size=0x380000000 ua=0x7fbfdbe00000 ret=0 restricted_fd=19 restricted_offset=0x80000000
  692500@1689108688.795412:kvm_set_user_memory AddrSpace#0 Slot#0 flags=0x0 gpa=0x0 size=0x0 ua=0x7fbf5be00000 ret=0 restricted_fd=19 restricted_offset=0x0
  692500@1689108688.795550:kvm_set_user_memory AddrSpace#0 Slot#0 flags=0x4 gpa=0x0 size=0xc0000 ua=0x7fbf5be00000 ret=0 restricted_fd=19 restricted_offset=0x0
  692500@1689108688.796227:kvm_set_user_memory AddrSpace#0 Slot#6 flags=0x4 gpa=0x100000 size=0x7ff00000 ua=0x7fbf5bf00000 ret=0 restricted_fd=19 restricted_offset=0x100000

Because of that the KVM_SET_USER_MEMORY_REGIONs for non-THP-aligned GPAs
will fail. Maybe instead it should be allowed, and kvm_gmem_get_folio()
should handle the alignment checks on a case-by-case and simply force 4k
for offsets corresponding to unaligned bindings?

-Mike
