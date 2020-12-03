Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4BF2CD250
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 10:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbgLCJOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 04:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgLCJOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:14:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D75AC061A4D;
        Thu,  3 Dec 2020 01:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CX5vRPWnJLKsbIR3zly2j7Pvq5cbtvCLFE+q5RDhbts=; b=nKjD3cIpcN5pK68xdcSDgea4sK
        KZh+h/vls3g5ihq+W2IoSl6mPFYkQOVAObP8J30CouObKA2SeT6zSaTSqr6sXg0+BwbyYSKreT2rR
        FHRv2O4VUEKo/RBhvt2eOu1bSArbxsDqYoYISSJKj6sCvYmn4XBUqs11UbnBeCHfQEcoOvHpNv3ZU
        oL+vV7rHBTQDplD5QsdOkSo1VKjPDX16j2laRm8IygsEEagzFw7+4tC0cxFvzKw4bHGrRLVyNBgHg
        KJhyWQKs2Fz2bSASD1mLf+K1ZQRcXptRISZABp9rsZ7Al2MIQpbQhSG6ssBj0K8gFI7opBwrHlw6e
        FozrZdpw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkkgg-0002oz-Cw; Thu, 03 Dec 2020 09:14:06 +0000
Date:   Thu, 3 Dec 2020 09:14:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iov_iter: optimise bvec iov_iter_advance()
Message-ID: <20201203091406.GA6189@infradead.org>
References: <21b78c2f256e513b9eb3f22c7c1f55fc88992600.1606957658.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21b78c2f256e513b9eb3f22c7c1f55fc88992600.1606957658.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -1077,6 +1077,20 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
>  		i->count -= size;
>  		return;
>  	}
> +	if (iov_iter_is_bvec(i)) {
> +		struct bvec_iter bi;
> +
> +		bi.bi_size = i->count;
> +		bi.bi_bvec_done = i->iov_offset;
> +		bi.bi_idx = 0;
> +		bvec_iter_advance(i->bvec, &bi, size);
> +
> +		i->bvec += bi.bi_idx;
> +		i->nr_segs -= bi.bi_idx;
> +		i->count = bi.bi_size;
> +		i->iov_offset = bi.bi_bvec_done;
> +		return;
> +	}
>  	iterate_and_advance(i, size, v, 0, 0, 0)

I like the idea, but whu not avoid the on-stack bvec_iter and just
open code this entirely using a new helper?  E.g.

static void bio_iov_iter_advance(struct iov_iter *i, size_t bytes)
{
	unsigned int cnt;

	i->count -= bytes;

	bytes += i->iov_offset;
	for (cnt = 0; bytes && bytes >= i->bvec[cnt].bv_len; cnt++)
		bytes -= i->bvec[cnt].bv_len;
	i->iov_offset = bytes;

	i->bvec += cnt;
	i->nr_segs -= cnt;
}
