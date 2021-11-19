Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF3456ADA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhKSH0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhKSH0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:26:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77C9C061574;
        Thu, 18 Nov 2021 23:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=etzROkgLDJ3fAqXUvqW6n0mH56UVGwueuFcutPzI3cA=; b=omrNRinBCsBJskc2fu2gSv6Fiw
        9FcBhvWBr+dgLFPdYsAwrQdcXHrCekxsq9Swkx4uI/dQKlYfOqZJkpqrNLMaxkgJG+8hd4/Rvi+rH
        U5S2CIb1Pk06MsU77vXZco0pRrZ7OlPoTsToNILcssA9IGKeZouVkhb496LOX1vbKFj6S7kAPP19b
        ivoJj+OVhUitUiH038ftxPpuZgwAK43CEVr/EnVYrS9QVwLShW1/TCHKc1m0JVc8CuEj163cRIU/w
        Rf9rV0aE4VqyOJb7tO+aNnUATnQeSpsN9sWVYkNtvr5n+CDTWX/Hp92xEzWzc22zbmki7EfSlpPMO
        1Pso58xg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnyFH-009aN9-0u; Fri, 19 Nov 2021 07:23:39 +0000
Date:   Thu, 18 Nov 2021 23:23:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: proc: store PDE()->data into inode->i_private
Message-ID: <YZdQ+0D7n5xCnw5A@infradead.org>
References: <20211119041104.27662-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119041104.27662-1-songmuchun@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 12:11:04PM +0800, Muchun Song wrote:
> +
> +/*
> + * Obtain the private data passed by user through proc_create_data() or
> + * related.
> + */
> +static inline void *pde_data(const struct inode *inode)
> +{
> +	return inode->i_private;
> +}
> +
> +#define PDE_DATA(i)	pde_data(i)

What is the point of pde_data?  If we really think changing to lower
case is worth it (I don't think so, using upper case for getting at
private data is a common idiom in file systems), we can just do that
scripted in one go.
