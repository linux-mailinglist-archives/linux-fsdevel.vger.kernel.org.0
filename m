Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F140D2CA332
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 13:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbgLAMxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 07:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgLAMxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:53:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74EDC0613CF;
        Tue,  1 Dec 2020 04:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/x/BlGz9wsyeKt9EH9JP9Ms34VbCwEASozEkM1sVSX4=; b=lPsff/K7OVPirotdLNK1OSP1s/
        PAkE5qpR7HxRTYXDVx+gkFw787/AeWtM50F9uqMGnpf0FanqvA+chj0FDNeDzzbUXTGqaSMS7gUm6
        /AQo4k7+gstFcxSulWHnxlHX42J/VEgcid4aPuzvnoqthgKskgUjc29hBI+0ySW5MDdj5j/bruPuj
        dd82hX88lJoWWYIsab/f5uCFAlaUf3olllL4SaA635xzhiKNWwbJOOhUSwe8cKfMDXVxAzzoUYsOi
        Y85bDHdYhLHgj2xUpHb23F71DuzMp7TFkf5Wsrbd9MKdsPHBtVfwu9qRV65Y6Zp+GG/SSSCZz0Tui
        dF9LUQ/w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk59I-0006Bb-04; Tue, 01 Dec 2020 12:52:52 +0000
Date:   Tue, 1 Dec 2020 12:52:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201201125251.GA11935@casper.infradead.org>
References: <20201201120652.487077-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201120652.487077-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:06:52PM +0800, Ming Lei wrote:
> Pavel reported that iov_iter_npages is a bit heavy in case of bvec
> iter.
> 
> Turns out it isn't necessary to iterate every page in the bvec iter,
> and we call iov_iter_npages() just for figuring out how many bio
> vecs need to be allocated. And we can simply map each vector in bvec iter
> to bio's vec, so just return iter->nr_segs from bio_iov_iter_nvecs() for
> bvec iter.
> 
> Also rename local variable 'nr_pages' as 'nr_vecs' which exactly matches its
> real usage.
> 
> This patch is based on Mathew's post:
> 
> https://lore.kernel.org/linux-block/20201120123931.GN29991@casper.infradead.org/

But the only reason we want to know 'nr_vecs' is so we can allocate a
BIO which has that many vecs, right?  But we then don't actually use the
vecs in the bio because we use the ones already present in the iter.
That was why I had it return 1, not nr_vecs.

Did I miss something?

> +static inline int bio_iov_iter_nvecs(const struct iov_iter *i, int maxvecs)
> +{
> +	if (!iov_iter_count(i))
> +		return 0;
> +	if (iov_iter_is_bvec(i))
> +               return min_t(int, maxvecs, i->nr_segs);
> +	return iov_iter_npages(i, maxvecs);
> +}
