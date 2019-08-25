Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 815DA9C24C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2019 08:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfHYGMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 02:12:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfHYGMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 02:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JpNLDg+KbIEgZXCqJMuphSCAD3VmeNChk2WlGZXcmTM=; b=k6MEvGTLP99lhrLpceqHgFSml
        G9ZIXHbGuMPSYdG+JTUQHLsZXaY8kreOrv3MxHREKQ+lS9LovBQJCCHXv7+ejU8IFEviTLHfByPN4
        fe2WH/h2wHRO5ggFgeu0Zudl7UtaX2CilZGs9xtZK8Z8RnQNKjf0OVOJgzp2nUsptBhtKzPJ4CWXu
        VoT/z7IZMAQtAdmMyOHRmicelf2gSj75d5Ap+HdOwizF1VtYmwMkZmGcPn9Q0RWby0D/vfVNEIpDn
        QB6v8LYGXr+/sE9rLLYVifd4O/CWBYyyfrbYpn8/FxWir/CB7jYRNVCb7tYcjEnCIky0IP5qL4nzw
        4wB5c07aw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i1lks-0001Yj-Kw; Sun, 25 Aug 2019 06:11:58 +0000
Date:   Sat, 24 Aug 2019 23:11:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Denis Efremov <efremov@ispras.ru>
Cc:     akpm@linux-foundation.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <matthew@wil.cx>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
        Erdem Tumurov <erdemus@gmail.com>,
        Vladimir Shelekhov <vshel@iis.nsk.su>
Subject: Re: [PATCH v2] lib/memweight.c: open codes bitmap_weight()
Message-ID: <20190825061158.GC28002@bombadil.infradead.org>
References: <20190821074200.2203-1-efremov@ispras.ru>
 <20190824100102.1167-1-efremov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824100102.1167-1-efremov@ispras.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 24, 2019 at 01:01:02PM +0300, Denis Efremov wrote:
> This patch open codes the bitmap_weight() call. The direct
> invocation of hweight_long() allows to remove the BUG_ON and
> excessive "longs to bits, bits to longs" conversion.

Honestly, that's not the problem with this function.  Take a look
at https://danluu.com/assembly-intrinsics/ for a _benchmarked_
set of problems with popcnt.

> BUG_ON was required to check that bitmap_weight() will return
> a correct value, i.e. the computed weight will fit the int type
> of the return value.

What?  No.  Look at the _arguments_ of bitmap_weight():

static __always_inline int bitmap_weight(const unsigned long *src, unsigned int nbits)

> With this patch memweight() controls the
> computation directly with size_t type everywhere. Thus, the BUG_ON
> becomes unnecessary.

Why are you bothering?  How are you allocating half a gigabyte of memory?
Why are you calling memweight() on half a gigabyte of memory?

>  	if (longs) {
> -		BUG_ON(longs >= INT_MAX / BITS_PER_LONG);
> -		ret += bitmap_weight((unsigned long *)bitmap,
> -				longs * BITS_PER_LONG);
> +		const unsigned long *bitmap_long =
> +			(const unsigned long *)bitmap;
> +
>  		bytes -= longs * sizeof(long);
> -		bitmap += longs * sizeof(long);
> +		for (; longs > 0; longs--, bitmap_long++)
> +			ret += hweight_long(*bitmap_long);
> +		bitmap = (const unsigned char *)bitmap_long;
>  	}

If you really must change anything, I'd rather see this turned into a
loop:

	while (longs) {
		unsigned int nbits;

		if (longs >= INT_MAX / BITS_PER_LONG)
			nbits = INT_MAX + 1;
		else
			nbits = longs * BITS_PER_LONG;

		ret += bitmap_weight((unsigned long *)bitmap, sz);
		bytes -= nbits / 8;
		bitmap += nbits / 8;
		longs -= nbits / BITS_PER_LONG;
	}

then we only have to use Dan Luu's optimisation in bitmap_weight()
and not in memweight() as well.

Also, why does the trailer do this:

        for (; bytes > 0; bytes--, bitmap++)
                ret += hweight8(*bitmap);

instead of calling hweight_long on *bitmap & mask?
