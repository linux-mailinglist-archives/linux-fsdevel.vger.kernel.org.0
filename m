Return-Path: <linux-fsdevel+bounces-62552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B40B991F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBD03A7167
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1E72D5425;
	Wed, 24 Sep 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="pG87ProP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnkSZWz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693A27A47F
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706096; cv=none; b=gmO/yw39254h3OG08hL6hK39MsAmvOKhyCvrc6IR9R7nf66FoF3+fre0XlJht8RM8z+R96LHOZRWUy3v/TNimpKo/1/OY9AvAU6llgg3oqHMx/ESb7A69b3sY0oR3vu2+6F/xWe0xFuTq4im4axJwAzQHCQ2uqSEa/rYdd06yew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706096; c=relaxed/simple;
	bh=H45lHinstkjV9BdSuBSK9NtVkK6vkktIpK6GD9FE0T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv87R82769ObYdK5+6oFk6TYYUUuNSUr/LyXmC5ELzyGqlIoYq/Hg+hBD7Fxhs2DeYPI6Itw2HFKPh/4nKx5rVORLKSoQBEMJyt3QqFdEh6dhpjD7iR8WoIF/1XcCrKasXcqlzr14P72QEWNghyAI1GA4hr/3xVCOBLEdcgmTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=pG87ProP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnkSZWz1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E599FEC00D4;
	Wed, 24 Sep 2025 05:28:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 24 Sep 2025 05:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758706092; x=
	1758792492; bh=KUD2RRfzSAbHLO83MN/oRz61xww+qlvcyMyR7/XbwbY=; b=p
	G87ProPDBERZ00mEucTYCngGlONK6mOC3QA+GRpM/AGSJtXvjrv1v+deUZqJuHB9
	bzWYwNoEvirKm27QeR19aIowOngaQtaxTTu5rH/qxqkhVj4YsAKraV6rFzk9szy4
	+jCoeMzqZcBYoz5tmuy454/DLYZEtQt84CFV43atrqHe0b7F+6GdXhMPurEn8z0b
	rnFC6Fp/03gjsU7BJPin2QVs1dzsEBwWrcHla7VzIFGypoz7OskVtz2/EyNt/aBt
	8/zUleP1IP5h7EQZ3JhfP7FJDFQlJVc/M4JtBstujZgiiLaYJjJ+1/UlLt1dK32I
	jCxbB1phI7NrzxDua+ALA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758706092; x=1758792492; bh=KUD2RRfzSAbHLO83MN/oRz61xww+qlvcyMy
	R7/XbwbY=; b=BnkSZWz1JqySTq9uGPVc8jC88kMjrhrI6IhmEn0i7DopxBH7ZGq
	CfF7jMMGCunVH1lL0OUQ/VNA2Ikq/vcQgzrqwEJfVSnMWzE6D9C+kRIvat5W4v9/
	2zuHCJTJhat6yFk3pLA9VN9yaHt2OtikXnt7DWFKENGsgcEDudtBvVDy/FqnQaB2
	6M6YRjxLLgwsP5JARjEPKNHHxgZexVcvwZ3Xmf03NFUhaa82Mu3WKR28WozFbkwB
	6dTvR+g3jPO/RQac6egvu/XGwv+K81cNfl9l4zQT5oZ5SvDs9NwTrPzWrXHtGQZ3
	ajZO06V8gGsQz05viNvIt/pSWrxx4F66B6g==
X-ME-Sender: <xms:rLnTaCxLijvTIewszDab0PE3OCqQ-_92cNwF-Cshzfngq0mmO3r_ng>
    <xme:rLnTaK_VpRvIKEM7bNxq0cFAEjQxx_gDyA8evqxEelorVl9OZBoncBr2jHcS1nv-e
    tyckCBb5ehT7i2SmhfwooFduqvD8eFF62keqMTKatxocM3qCZA6YBI>
X-ME-Received: <xmr:rLnTaIMY2fxB_Y1L7EYU2lbxir5SZREAm21O895A0wOz-xUAJt13yq0oTd_ujA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepuddv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhu
    khdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugesfhhrohhmohhrsg
    hithdrtghomh
X-ME-Proxy: <xmx:rLnTaCoV_4R4LrBLx2vu7fGKpuNp7hfVRfkV7xHZ3jUBy2J1t5dreA>
    <xmx:rLnTaH4Mz4ORIgZxPAGXf8umO-N0KIpPeqBeCmqd93aNPdpMJSzBXA>
    <xmx:rLnTaCHNCR2E4IAlMcjMo-F6CWMyCN8JXE0ZNHp4triflaSh69Arow>
    <xmx:rLnTaB2FTgNRgg7HU5g5ehwhTOK1kIWzZzD21Gm_lCNhEoWqq5Lcfg>
    <xmx:rLnTaILhrUb8UKjn98FZNunwQUu2wuJH31MJ99mywpSKJaDGQGNk5g2p>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 05:28:11 -0400 (EDT)
Date: Wed, 24 Sep 2025 10:28:09 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 2/2] fs: Defer evicting inodes to a workqueue
Message-ID: <lofh4re5cnuc4byeude7idmf6m27l22tizpd4uqdmhsyochdm2@pdhq6y5plyya>
References: <20250924091000.2987157-1-willy@infradead.org>
 <20250924091000.2987157-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924091000.2987157-3-willy@infradead.org>

On Wed, Sep 24, 2025 at 10:09:57AM +0100, Matthew Wilcox (Oracle) wrote:
> If we're in memory reclaim, evicting inodes is actually a bad idea.
> The filesystem may need to allocate more memory to evict the inode
> than it will free by evicting the inode.  It's better to defer
> evicting the inode until a workqueue has time to run.
> 
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
> +
> +static DECLARE_WORK(dispose_inode_work, dispose_inodes_wq);
> +
> +static void deferred_dispose_inodes(struct list_head *inodes)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&deferred_inode_lock, flags);

Why _irqsave? I don't see any interactions with interrupts.

> +	list_splice_tail(inodes, &deferred_inode_list);
> +	spin_unlock_irqrestore(&deferred_inode_lock, flags);
> +
> +	printk("deferring some inodes\n");

Debug leftovers?

> +	schedule_work(&dispose_inode_work);
> +}
> +
>  /**
>   * evict_inodes	- evict all evictable inodes for a superblock
>   * @sb:		superblock to operate on
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
>  
> -- 
> 2.47.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

