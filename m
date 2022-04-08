Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BB34F9637
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 14:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiDHM5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 08:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiDHM5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:57:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBF9F70D6;
        Fri,  8 Apr 2022 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649422505; x=1680958505;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=O9odkqTVXr/6ytKIrHbe23E6RNpY/PYB3IDXxuv8ddY=;
  b=eL5h+/iR2/KK/WzxSmPa/PnDFxDSOD9r69JBiJ4MGrAnZFcGjd/g5CFK
   bQU/Jiz1IN2+6fNF5SBhRIVx5BsYldi/MJig86HWcIXZPBH6oT/l8bKcH
   GiuTuzSzqriKfj3YaW9hnI4yqRUSG2qAs6OlGU682hB5zPvVL6lUeaIIs
   zNQ/Vvkc2yrvrNfLFOJ/w0Hi4CUbIwwpmkRDM1udrMxeCLfue8SoUqSYQ
   FlnsgP6XWO/QBP4Sr2LgA/wKuezKZy19UsudiXtRNvN1JiOeufz/xqfa6
   NVtznA7f/oKdXHuZgtcJTtv3+RdKCIXNJfepID1In25epvKACbrpMxmsC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261276278"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261276278"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="698172668"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 05:54:56 -0700
Date:   Fri, 8 Apr 2022 20:54:45 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 02/13] mm: Introduce memfile_notifier
Message-ID: <20220408125445.GA57095@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-3-chao.p.peng@linux.intel.com>
 <YkNTvFqWI5F5w+DW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkNTvFqWI5F5w+DW@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 06:45:16PM +0000, Sean Christopherson wrote:
> On Thu, Mar 10, 2022, Chao Peng wrote:
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 70d4309c9ce3..f628256dce0d 100644
> > +void memfile_notifier_invalidate(struct memfile_notifier_list *list,
> > +				 pgoff_t start, pgoff_t end)
> > +{
> > +	struct memfile_notifier *notifier;
> > +	int id;
> > +
> > +	id = srcu_read_lock(&srcu);
> > +	list_for_each_entry_srcu(notifier, &list->head, list,
> > +				 srcu_read_lock_held(&srcu)) {
> > +		if (notifier->ops && notifier->ops->invalidate)
> 
> Any reason notifier->ops isn't mandatory?

Yes it's mandatory, will skip the check here.

> 
> > +			notifier->ops->invalidate(notifier, start, end);
> > +	}
> > +	srcu_read_unlock(&srcu, id);
> > +}
> > +
> > +void memfile_notifier_fallocate(struct memfile_notifier_list *list,
> > +				pgoff_t start, pgoff_t end)
> > +{
> > +	struct memfile_notifier *notifier;
> > +	int id;
> > +
> > +	id = srcu_read_lock(&srcu);
> > +	list_for_each_entry_srcu(notifier, &list->head, list,
> > +				 srcu_read_lock_held(&srcu)) {
> > +		if (notifier->ops && notifier->ops->fallocate)
> > +			notifier->ops->fallocate(notifier, start, end);
> > +	}
> > +	srcu_read_unlock(&srcu, id);
> > +}
> > +
> > +void memfile_register_backing_store(struct memfile_backing_store *bs)
> > +{
> > +	BUG_ON(!bs || !bs->get_notifier_list);
> > +
> > +	list_add_tail(&bs->list, &backing_store_list);
> > +}
> > +
> > +void memfile_unregister_backing_store(struct memfile_backing_store *bs)
> > +{
> > +	list_del(&bs->list);
> 
> Allowing unregistration of a backing store is broken.  Using the _safe() variant
> is not sufficient to guard against concurrent modification.  I don't see any reason
> to support this out of the gate, the only reason to support unregistering a backing
> store is if the backing store is implemented as a module, and AFAIK none of the
> backing stores we plan on supporting initially support being built as a module.
> These aren't exported, so it's not like that's even possible.  Registration would
> also be broken if modules are allowed, I'm pretty sure module init doesn't run
> under a global lock.
> 
> We can always add this complexity if it's needed in the future, but for now the
> easiest thing would be to tag memfile_register_backing_store() with __init and
> make backing_store_list __ro_after_init.

The only currently supported backing store shmem does not need this so
can remove it for now.

> 
> > +}
> > +
> > +static int memfile_get_notifier_info(struct inode *inode,
> > +				     struct memfile_notifier_list **list,
> > +				     struct memfile_pfn_ops **ops)
> > +{
> > +	struct memfile_backing_store *bs, *iter;
> > +	struct memfile_notifier_list *tmp;
> > +
> > +	list_for_each_entry_safe(bs, iter, &backing_store_list, list) {
> > +		tmp = bs->get_notifier_list(inode);
> > +		if (tmp) {
> > +			*list = tmp;
> > +			if (ops)
> > +				*ops = &bs->pfn_ops;
> > +			return 0;
> > +		}
> > +	}
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +int memfile_register_notifier(struct inode *inode,
> 
> Taking an inode is a bit odd from a user perspective.  Any reason not to take a
> "struct file *" and get the inode here?  That would give callers a hint that they
> need to hold a reference to the file for the lifetime of the registration.

Yes, I can change.

> 
> > +			      struct memfile_notifier *notifier,
> > +			      struct memfile_pfn_ops **pfn_ops)
> > +{
> > +	struct memfile_notifier_list *list;
> > +	int ret;
> > +
> > +	if (!inode || !notifier | !pfn_ops)
> 
> Bitwise | instead of logical ||.  But IMO taking in a pfn_ops pointer is silly.
> More below.
> 
> > +		return -EINVAL;
> > +
> > +	ret = memfile_get_notifier_info(inode, &list, pfn_ops);
> > +	if (ret)
> > +		return ret;
> > +
> > +	spin_lock(&list->lock);
> > +	list_add_rcu(&notifier->list, &list->head);
> > +	spin_unlock(&list->lock);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(memfile_register_notifier);
> > +
> > +void memfile_unregister_notifier(struct inode *inode,
> > +				 struct memfile_notifier *notifier)
> > +{
> > +	struct memfile_notifier_list *list;
> > +
> > +	if (!inode || !notifier)
> > +		return;
> > +
> > +	BUG_ON(memfile_get_notifier_info(inode, &list, NULL));
> 
> Eww.  Rather than force the caller to provide the inode/file and the notifier,
> what about grabbing the backing store itself in the notifier?
> 
> 	struct memfile_notifier {
> 		struct list_head list;
> 		struct memfile_notifier_ops *ops;
> 
> 		struct memfile_backing_store *bs;
> 	};
> 
> That also helps avoid confusing between "ops" and "pfn_ops".  IMO, exposing
> memfile_backing_store to the caller isn't a big deal, and is preferable to having
> to rewalk multiple lists just to delete a notifier.

Agreed, good suggestion.

> 
> Then this can become:
> 
>   void memfile_unregister_notifier(struct memfile_notifier *notifier)
>   {
> 	spin_lock(&notifier->bs->list->lock);
> 	list_del_rcu(&notifier->list);
> 	spin_unlock(&notifier->bs->list->lock);
> 
> 	synchronize_srcu(&srcu);
>   }
> 
> and registration can be:
> 
>   int memfile_register_notifier(const struct file *file,
> 			      struct memfile_notifier *notifier)
>   {
> 	struct memfile_notifier_list *list;
> 	struct memfile_backing_store *bs;
> 	int ret;
> 
> 	if (!file || !notifier)
> 		return -EINVAL;
> 
> 	list_for_each_entry(bs, &backing_store_list, list) {
> 		list = bs->get_notifier_list(file_inode(file));
> 		if (list) {
> 			notifier->bs = bs;
> 
> 			spin_lock(&list->lock);
> 			list_add_rcu(&notifier->list, &list->head);
> 			spin_unlock(&list->lock);
> 			return 0;
> 		}
> 	}
> 
> 	return -EOPNOTSUPP;
>   }
