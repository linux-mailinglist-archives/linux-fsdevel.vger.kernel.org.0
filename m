Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5018BB627C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfIRLvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 07:51:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfIRLu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xT04o0lekJxd/aozlQYGw0ZS4okGFGfqXe4QEtUwyYo=; b=q9flpAHDMXxzFuObshYoFv4be
        l4DeXx4V8SrvfAc4numF8OpmqDp8v7qs+KxtSzngtECLx7U1LbsccCx+stgKPiidKUkh54hSVNnr0
        9Sj0Kbpjdp6hILG+2b3vsUeWSmP6INfGpznkdo17UcauUjA5G6ZYhPEVWlO5OwzPplm6UxATM5806
        fMgdqYjfDD7B6c3iRlBTuG2grXovldmp3e9CYL8jKxXlQqerays6DtzrsOslskJ9wtK1Tu6PuxjRB
        m6r4X9EIVY71cnXLrYRwW1A/RcqY0hbyAEt1G7rAIbmfIhPsUmksvnKYZLxGveFJ9l4RYTugEyTIW
        TEr30NsMQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAYU6-0000jz-Q9; Wed, 18 Sep 2019 11:50:58 +0000
Date:   Wed, 18 Sep 2019 04:50:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: Prevent unintended underflow for the idr index
Message-ID: <20190918115058.GB9880@bombadil.infradead.org>
References: <1568756922-2829-1-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568756922-2829-1-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:48:42PM -0600, Jordan Crouse wrote:
> It is possible for unaware callers of several idr functions to accidentally
> underflow the index by specifying a id that is less than the idr base.

Hi Jordan.  Thanks for the patch, but this seems like a distinction
without a difference.

>  void *idr_remove(struct idr *idr, unsigned long id)
>  {
> +	if (id < idr->idr_base)
> +		return NULL;
> +
>  	return radix_tree_delete_item(&idr->idr_rt, id - idr->idr_base, NULL);

If this underflows, we'll try to delete an index which doesn't exist,
which will return NULL.

>  void *idr_find(const struct idr *idr, unsigned long id)
>  {
> +	if (id < idr->idr_base)
> +		return NULL;
> +
>  	return radix_tree_lookup(&idr->idr_rt, id - idr->idr_base);

If this underflows, we'll look up an entry which doesn't exist, which
will return NULL.

> @@ -302,6 +308,9 @@ void *idr_replace(struct idr *idr, void *ptr, unsigned long id)
>  	void __rcu **slot = NULL;
>  	void *entry;
>  
> +	if (id < idr->idr_base)
> +		return ERR_PTR(-ENOENT);
> +
>  	id -= idr->idr_base;
>  
>  	entry = __radix_tree_lookup(&idr->idr_rt, id, &node, &slot);

... just outside the context is this line:
        if (!slot || radix_tree_tag_get(&idr->idr_rt, id, IDR_FREE))
                return ERR_PTR(-ENOENT);

Looking up an index which doesn't exist gets you a NULL slot, so you get
-ENOENT anyway.

I did think about these possibilities when I was writing the code and
convinced myself I didn't need them.  If you have an example of a case
where I got thast wrong, I'd love to see it.

More generally, the IDR is deprecated; I'm trying to convert users to
the XArray.  If you're adding a new user, can you use the XArray API
instead?
