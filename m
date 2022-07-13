Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D339572F92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 09:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiGMHsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiGMHs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:48:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524BE6332;
        Wed, 13 Jul 2022 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657698506; x=1689234506;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=nUfcHt/iaf3oMSfMyzHxGwWsSmqpbvlJ2JFwYR1oe/M=;
  b=C4cP7E864jxiXG8f7VB1bNxdXYNG12yHhsNZlDN4+uGv70+0xztfKFhO
   ukHKXBXu1kiraU7YIGFaenCfBQGF12+KplTVGTDE5pjFlrAu2bDNCandl
   T8Gh5bxOsB80l3NLxqG6z6o9q05NfddgX+xdoHTH0wbzeRopuEji/FJ9O
   MwxqbvPhvp/R0Aa9j5ooO1/+8VEZcN8BFz79RyuF1bCjNSfbolylaS6ak
   3jek3LsAlr7oCc3JOixWVJ2yp1nVSNT/Z744IJKJtHKlCR9BADxTEcqGY
   aWaRfqH/L7MwQmC9R5lpqwIhG9Z7JXfVNTLoRxoejPMuwEDoiR1ICVjeX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="264928758"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="264928758"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 00:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="685067167"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2022 00:48:16 -0700
Date:   Wed, 13 Jul 2022 15:44:58 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
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
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 04/14] mm/shmem: Support memfile_notifier
Message-ID: <20220713074458.GB2831541@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-5-chao.p.peng@linux.intel.com>
 <c4112b84-9359-d4c8-1852-0057c074607c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4112b84-9359-d4c8-1852-0057c074607c@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:02:34PM +0200, Gupta, Pankaj wrote:
> On 7/6/2022 10:20 AM, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Implement shmem as a memfile_notifier backing store. Essentially it
> > interacts with the memfile_notifier feature flags for userspace
> > access/page migration/page reclaiming and implements the necessary
> > memfile_backing_store callbacks.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >   include/linux/shmem_fs.h |   2 +
> >   mm/shmem.c               | 109 ++++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 110 insertions(+), 1 deletion(-)
...

> > +#ifdef CONFIG_MIGRATION
> > +static int shmem_migrate_page(struct address_space *mapping,
> > +			      struct page *newpage, struct page *page,
> > +			      enum migrate_mode mode)
> > +{
> > +	struct inode *inode = mapping->host;
> > +	struct shmem_inode_info *info = SHMEM_I(inode);
> > +
> > +	if (info->memfile_node.flags & MEMFILE_F_UNMOVABLE)
> > +		return -EOPNOTSUPP;
> > +	return migrate_page(mapping, newpage, page, mode);
> 
> Wondering how well page migrate would work for private pages
> on shmem memfd based backend?

From high level:
  - KVM unset MEMFILE_F_UNMOVABLE bit to indicate it capable of
    migrating a page.
  - Introduce new 'migrate' callback(s) to memfile_notifier_ops for KVM
    to register.
  - The callback is hooked to migrate_page() here.
  - Once page migration requested, shmem calls into the 'migrate'
    callback(s) to perform additional steps for encrypted memory (For
    TDX we will call TDH.MEM.PAGE.RELOCATE).

Chao
> 
> > +}
> > +#endif
> > +
> >   const struct address_space_operations shmem_aops = {
> >   	.writepage	= shmem_writepage,
> >   	.dirty_folio	= noop_dirty_folio,
> > @@ -3814,7 +3872,7 @@ const struct address_space_operations shmem_aops = {
> >   	.write_end	= shmem_write_end,
> >   #endif
> >   #ifdef CONFIG_MIGRATION
> > -	.migratepage	= migrate_page,
> > +	.migratepage	= shmem_migrate_page,
> >   #endif
> >   	.error_remove_page = shmem_error_remove_page,
> >   };
> > @@ -3931,6 +3989,51 @@ static struct file_system_type shmem_fs_type = {
> >   	.fs_flags	= FS_USERNS_MOUNT,
> >   };
 
