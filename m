Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BE04EB3A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbiC2SrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiC2SrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:47:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EC89287F
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 11:45:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id jx9so18353986pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o1qcZR1LxJ/8GbkW+1o65vv0lkJ0fy//rk2/1UscmDw=;
        b=dwjAFyr79FlAvZN4oVDM+cROGwXKgWD+GjzFyXRXAgE8FAWQh0f0I0kd8X5DA7Ic5Y
         VwRjT+3EqrXkzzX/nA4ayJfSyv2gITG1hZSatG1ilG804HuNYYziRhjIGD8PzrzW2dTC
         qt0ANVSElJX0JYkgUfFNeD60WWqInSK4r/B5RxaF5Zl5+LoHWKn0N40sfo5Ea2m3RSsS
         Sxu4L76R4KPju1vfaBBeh6+oYASNnMU2wyIvIHabuxRCp2MOIvLjmk1Z8I5EaQodk5kP
         ANAl4mN5q+r0q0fvNS/WILwuTETHBqUREYH8mUVFLgxLgkLiIpXMRtvAHqwl/fH3x5YO
         W5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o1qcZR1LxJ/8GbkW+1o65vv0lkJ0fy//rk2/1UscmDw=;
        b=DAugW4mbEn0lNJHnagzE/xfjG9mt/ys+C6K1sS6+y3d4Bz+YJ8GnpF2rCpGhM4k6WI
         XTdtoTjeTf+/UN46sjINQ+6Z96Qr8hh/CQWJFeghXA2iYmDlWvaTyjjUXbWFGeV89oi4
         sMNlLu/PXhHycBKR5P3pAnD/qmBibPNCQAjisS2l0pVRJoVtHQdLT9WkF2q7AmGH+vqy
         Hr4c4qn9TbmYE6OXMEwR8pXViefwZz81XWTpeOTcxuekZhN6ks1PXe5Ft0U9KIP9+9sZ
         dYstOlwfPCOXtH6Bf+xw158b0vCSQyvXUWlglrBVm2MJZHu3RmIYLQPjvwnEjmtVTsTb
         zFbg==
X-Gm-Message-State: AOAM530SLZfIjC3Zccle5qF7UA5PoqhC/CFhGFpvKxefZwhcHe7U7q65
        Ew0xo3j6TbAZRy21yJbnwaNmXvXJOSjRIA==
X-Google-Smtp-Source: ABdhPJyI/2yF5j0Y4c6Rg7cy0zvMkWFf2rvkH3lV+0xBToveJFcYf3GobqOkuMkXZjAqYWlysTz2jw==
X-Received: by 2002:a17:902:d717:b0:156:20a9:d388 with SMTP id w23-20020a170902d71700b0015620a9d388mr7038650ply.19.1648579521129;
        Tue, 29 Mar 2022 11:45:21 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00248500b004f6b5ddcc65sm20916192pfv.199.2022.03.29.11.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:45:20 -0700 (PDT)
Date:   Tue, 29 Mar 2022 18:45:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
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
Message-ID: <YkNTvFqWI5F5w+DW@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-3-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-3-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022, Chao Peng wrote:
> diff --git a/mm/Makefile b/mm/Makefile
> index 70d4309c9ce3..f628256dce0d 100644
> +void memfile_notifier_invalidate(struct memfile_notifier_list *list,
> +				 pgoff_t start, pgoff_t end)
> +{
> +	struct memfile_notifier *notifier;
> +	int id;
> +
> +	id = srcu_read_lock(&srcu);
> +	list_for_each_entry_srcu(notifier, &list->head, list,
> +				 srcu_read_lock_held(&srcu)) {
> +		if (notifier->ops && notifier->ops->invalidate)

Any reason notifier->ops isn't mandatory?

> +			notifier->ops->invalidate(notifier, start, end);
> +	}
> +	srcu_read_unlock(&srcu, id);
> +}
> +
> +void memfile_notifier_fallocate(struct memfile_notifier_list *list,
> +				pgoff_t start, pgoff_t end)
> +{
> +	struct memfile_notifier *notifier;
> +	int id;
> +
> +	id = srcu_read_lock(&srcu);
> +	list_for_each_entry_srcu(notifier, &list->head, list,
> +				 srcu_read_lock_held(&srcu)) {
> +		if (notifier->ops && notifier->ops->fallocate)
> +			notifier->ops->fallocate(notifier, start, end);
> +	}
> +	srcu_read_unlock(&srcu, id);
> +}
> +
> +void memfile_register_backing_store(struct memfile_backing_store *bs)
> +{
> +	BUG_ON(!bs || !bs->get_notifier_list);
> +
> +	list_add_tail(&bs->list, &backing_store_list);
> +}
> +
> +void memfile_unregister_backing_store(struct memfile_backing_store *bs)
> +{
> +	list_del(&bs->list);

Allowing unregistration of a backing store is broken.  Using the _safe() variant
is not sufficient to guard against concurrent modification.  I don't see any reason
to support this out of the gate, the only reason to support unregistering a backing
store is if the backing store is implemented as a module, and AFAIK none of the
backing stores we plan on supporting initially support being built as a module.
These aren't exported, so it's not like that's even possible.  Registration would
also be broken if modules are allowed, I'm pretty sure module init doesn't run
under a global lock.

We can always add this complexity if it's needed in the future, but for now the
easiest thing would be to tag memfile_register_backing_store() with __init and
make backing_store_list __ro_after_init.

> +}
> +
> +static int memfile_get_notifier_info(struct inode *inode,
> +				     struct memfile_notifier_list **list,
> +				     struct memfile_pfn_ops **ops)
> +{
> +	struct memfile_backing_store *bs, *iter;
> +	struct memfile_notifier_list *tmp;
> +
> +	list_for_each_entry_safe(bs, iter, &backing_store_list, list) {
> +		tmp = bs->get_notifier_list(inode);
> +		if (tmp) {
> +			*list = tmp;
> +			if (ops)
> +				*ops = &bs->pfn_ops;
> +			return 0;
> +		}
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +int memfile_register_notifier(struct inode *inode,

Taking an inode is a bit odd from a user perspective.  Any reason not to take a
"struct file *" and get the inode here?  That would give callers a hint that they
need to hold a reference to the file for the lifetime of the registration.

> +			      struct memfile_notifier *notifier,
> +			      struct memfile_pfn_ops **pfn_ops)
> +{
> +	struct memfile_notifier_list *list;
> +	int ret;
> +
> +	if (!inode || !notifier | !pfn_ops)

Bitwise | instead of logical ||.  But IMO taking in a pfn_ops pointer is silly.
More below.

> +		return -EINVAL;
> +
> +	ret = memfile_get_notifier_info(inode, &list, pfn_ops);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock(&list->lock);
> +	list_add_rcu(&notifier->list, &list->head);
> +	spin_unlock(&list->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(memfile_register_notifier);
> +
> +void memfile_unregister_notifier(struct inode *inode,
> +				 struct memfile_notifier *notifier)
> +{
> +	struct memfile_notifier_list *list;
> +
> +	if (!inode || !notifier)
> +		return;
> +
> +	BUG_ON(memfile_get_notifier_info(inode, &list, NULL));

Eww.  Rather than force the caller to provide the inode/file and the notifier,
what about grabbing the backing store itself in the notifier?

	struct memfile_notifier {
		struct list_head list;
		struct memfile_notifier_ops *ops;

		struct memfile_backing_store *bs;
	};

That also helps avoid confusing between "ops" and "pfn_ops".  IMO, exposing
memfile_backing_store to the caller isn't a big deal, and is preferable to having
to rewalk multiple lists just to delete a notifier.

Then this can become:

  void memfile_unregister_notifier(struct memfile_notifier *notifier)
  {
	spin_lock(&notifier->bs->list->lock);
	list_del_rcu(&notifier->list);
	spin_unlock(&notifier->bs->list->lock);

	synchronize_srcu(&srcu);
  }

and registration can be:

  int memfile_register_notifier(const struct file *file,
			      struct memfile_notifier *notifier)
  {
	struct memfile_notifier_list *list;
	struct memfile_backing_store *bs;
	int ret;

	if (!file || !notifier)
		return -EINVAL;

	list_for_each_entry(bs, &backing_store_list, list) {
		list = bs->get_notifier_list(file_inode(file));
		if (list) {
			notifier->bs = bs;

			spin_lock(&list->lock);
			list_add_rcu(&notifier->list, &list->head);
			spin_unlock(&list->lock);
			return 0;
		}
	}

	return -EOPNOTSUPP;
  }
