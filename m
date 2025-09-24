Return-Path: <linux-fsdevel+bounces-62573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90598B99B12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04EF1895D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8562FF147;
	Wed, 24 Sep 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPwd+G/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE72D5A16
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714970; cv=none; b=eF/eX4IfGCU53tgFJIJJLv1e9wTu28OcnmhYtOce2NYKmIGTijXyLeYsUqvNQtpKLTlfj6g5BZtmvnc12AdqGaKYmDV+k0dc/OXAqUZLo818/ipd6rGW+kbx5eObpXqhYSHNk1Xa5s3sh/46NFGM3NdjlIttMbjZ0ITIA4F/psM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714970; c=relaxed/simple;
	bh=2hddv/IDgqdxDRyJ2CI6yhSAjXDMulEB7zYHTHqRuK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quW+fdk9P4uCpSfnEqYR+Nei7kaBYbqczQUsJ5jPS9oF8Ns+hYhM5jzFh6chdhRh9MGF3wv8Oi9pxRS91zzd6Vbz7ksGAKL1O4dlAtSnqJLF0Q8xrVgm/49tNEVjRvdg8JOMx3eCI7KwzowIumDGaj3Gvm8jD6kk8jC5F8HTE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPwd+G/T; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso47081725e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714963; x=1759319763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G62sPJKp5K1tDcaheezlLxefJ167j1rH3L8r7LN4I0c=;
        b=MPwd+G/T8wQDtalgSr5xVoOPd/Evkf06xwVBViAYZvVSi4vpMRDeI7++Nr+iwWLHRQ
         iwG3XK5vC6waNJyzmIuqJEHypk+lqblUXJAyBX/KsrOeE1aAe6Yx08cBmXWVP6t6oXDU
         fHNC0GsGhHl245t5j0twDHNQyTUo9t6JhZ3E/2b55H7lQEhbDYjAHoTc3F2PkdY+WitA
         CNAcgHCh3TYJF+YoGE09YIr6qm6wQvE191dEqG5A1DVq6P6qnGD2lWcxxsiHZxsdVYQ1
         ot6PJGxlfMU9mxWycSJryLR70luBu9vY1tjP0TiISd9BnxwmWuiksc7pRuT9vCO+l1iY
         /YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714963; x=1759319763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G62sPJKp5K1tDcaheezlLxefJ167j1rH3L8r7LN4I0c=;
        b=wc+8LbR2MxVSIHQGNqZpafnLtEpjP5PRP8fLRNItAP81vEz2XCAAtZUqY989vcDYnP
         CXKcwQVtOljQfano5sG8V+IxtWfj8ONNzC7OmFw+crGNM2hMID0mUgZB64OYpOIpP+Lo
         egnKAC8c2lo2u+MppS1OAxxnyh1FmFsBNs4FwWb6tdNItmFlseByHNqI5pMg01M/b7n7
         VLB1ZxYaCX5nVdXgLyOc2WQeMC1pJQ7AMUV5mFUNcuV5jccqE2JSCCmGryAsTVz9Wlym
         Vk+k2Vg8B+O6g3zGycijI8udOn2XxRw8+9or24kkX4paazZhHEEFqUDQbxBwpHu/pt0A
         n+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxk/4M/I+yZjPnVJLP9yNJtHhA+UlCdWC4irPjJ+L1XYFhXo7DxX1Jkd0uBBA1Kfvm+ILpA9CwtlVtJGYu@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJ/3XvP4tPUAzAhWOAeesK7PDQ1ZtPE8YvbhtPqE+sk+bnquG
	nIjRsrlNeWO6rTeJJ8IciI2NpmCkMTOA1YZNM+DstMAZYu5hAqE19ede
X-Gm-Gg: ASbGncteYfCmCn/QiKAH4VrRs5rWSiaoosbwV6Lv/4lQNx8UnaVDntVa/1ynocEuWs3
	G2HdPmJc8vlkYwOWJeJq3Kksa5GK7G1Dgq6hUPxooRutQVl1oDeGNVdIm5qsDn8o5w2yv8yE7ct
	t8ABCTTXjw2EHDqqCzzt4M7PksexR0H1U0BS5527lXK0TrurvVsBsVNS9WUF1plGoYwLUagp7rb
	p43QSE8e9Np3Ozw+P8IcIuB/giOLFwaWkd3IAGZEPWYF+w9OMIrrz5ewWe0b6sGJB/nxHFJaUlR
	0gLCSU5cnyCVi+Nxz8a/zEoLPD7Q5HU2/C6IHsxLKV6M0+fcHzfVerNqrx6vHsCs61cImhgihkn
	ik6WSlgO0ElmWzbsGKPkyeRR1q3HKH+5dSgoYS/keJ/jFnFDh6AAmQdrtT2HdZXEaHik=
X-Google-Smtp-Source: AGHT+IGp4H7utnIM6HacC2naPv281BSZYuQ0nYlwOVt+1ZYWlR5IBs3MEdtDE1vx9lQClO1du6j8gQ==
X-Received: by 2002:a05:600c:1ca0:b0:45c:b5f7:c6e4 with SMTP id 5b1f17b1804b1-46e1dae42a7mr70885195e9.35.1758714962865;
        Wed, 24 Sep 2025 04:56:02 -0700 (PDT)
Received: from f (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac55esm33555215e9.6.2025.09.24.04.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:56:02 -0700 (PDT)
Date: Wed, 24 Sep 2025 13:55:53 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 2/2] fs: Defer evicting inodes to a workqueue
Message-ID: <aizkmmtgcfwfe22tj6hn5huzgwzqd7jqqq4xj7uaygwf663fxx@44kuyaqufz7e>
References: <20250924091000.2987157-1-willy@infradead.org>
 <20250924091000.2987157-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924091000.2987157-3-willy@infradead.org>

On Wed, Sep 24, 2025 at 10:09:57AM +0100, Matthew Wilcox (Oracle) wrote:
> If we're in memory reclaim, evicting inodes is actually a bad idea.
> The filesystem may need to allocate more memory to evict the inode
> than it will free by evicting the inode.  It's better to defer
> evicting the inode until a workqueue has time to run.
> 

There is a bug in the patch (noted below).

As for whether the idea works on paper I have no idea.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/inode.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d882b0fc787..fe7899cdd50c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -854,6 +854,34 @@ static void dispose_list(struct list_head *head)
>  	}
>  }
>  
> +static DEFINE_SPINLOCK(deferred_inode_lock);
> +static LIST_HEAD(deferred_inode_list);
> +
> +static void dispose_inodes_wq(struct work_struct *work)
> +{
> +	LIST_HEAD(dispose);
> +
> +	spin_lock_irq(&deferred_inode_lock);
> +	list_splice_init(&deferred_inode_list, &dispose);
> +	spin_unlock_irq(&deferred_inode_lock);
> +
> +	dispose_list(&dispose);
> +}

As a side note there is lockless machinery to do this (see
__fput_deferred), but perhaps this is just easier to look at.

> @@ -897,13 +925,17 @@ void evict_inodes(struct super_block *sb)
>  		if (need_resched()) {
>  			spin_unlock(&sb->s_inode_list_lock);
>  			cond_resched();
> -			dispose_list(&dispose);
> +			if (!in_reclaim())
> +				dispose_list(&dispose);
>  			goto again;
>  		}
>  	}
>  	spin_unlock(&sb->s_inode_list_lock);
>  
> -	dispose_list(&dispose);
> +	if (!in_reclaim())
> +		dispose_list(&dispose);
> +	else
> +		deferred_dispose_inodes(&dispose);
>  }
>  EXPORT_SYMBOL_GPL(evict_inodes);

I don't think this addresses the problems you linked. For example in the
first crash:
https://lore.kernel.org/all/CALm_T+3j+dyK02UgPiv9z0f1oj-HM63oxhsB0JF9gVAjeVfm1Q@mail.gmail.com/

evict_inodes() is only used on fs teardown AFAICS and I presume this
never executes within memory reclamation.

The trace at hand sports prune_icache_sb() -> inode_lru_isolate();
dispose_list() -> evict(), so I don't think your patch changes the
behavior in that case.

As in, I take it you wanted to patch prune_icache_sb() instead.

Even with this corrected there is a bug I don't blame you for:
weirdly enough the VFS layer expects all inodes to be sorted out in
generic_shutdown_super(). with the stock patch, assuming evict_inodes()
deferred anything and was called from something else than unmount, it
would not wait for deferred processing to finish. Same for deferred
processing in prune_icache_sb() or whatever else-non-unmount.

So for this to work you also need to patch unmount to stall waiting for
this bit to be done with all the inodes.

