Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F95A310D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 23:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbiHZVfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 17:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHZVfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:35:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A3926AFF;
        Fri, 26 Aug 2022 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FD+sX6y/YGKNYTLh49kecwED5jcHP6BikCa7Mn2Xoiw=; b=SZeRWWYJAhHNpROxrxFDkfKqJu
        qQqjg0mSzpZ1khvRXtuOB2jhs0OB11CBdyzlwPhuI3GuhyP1N/+vljPJ/sW+Adc4xjPQFNAmuLteZ
        ZIhI7fwX2BrrKiNiKZ109FaBnitiNDc65+osuwR4XlPe5hgWh2qgg0qOn3y9sxNHKcTRzFvUWGJLr
        OzofiEatLolQE6T63/d2Jbvyit4CtOAwE3nr7zQxfm4bC1FabfgVuEVFSlRzKZLv5qzkVORvb+wbn
        KlZPKiPWymffS/ijZfNHDdJFWMdECcd8CBhkBvNqAz525wTksYp7h7h8Qt/8JBPyZ1vNpDGevC2yt
        EH1eC7kA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRgz6-008fIQ-4Y;
        Fri, 26 Aug 2022 21:35:24 +0000
Date:   Fri, 26 Aug 2022 22:35:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] iov_iter: Add a general purpose iteration function
Message-ID: <Ywk8nKkVvVi8ZkeG@ZenIV>
References: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
 <166126394098.708021.10931745751914856461.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166126394098.708021.10931745751914856461.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 03:12:21PM +0100, David Howells wrote:

>  	size_t __maybe_unused off = 0;				\
>  	len = n;						\
>  	base = __p + i->iov_offset;				\
> -	len -= (STEP);						\
> -	i->iov_offset += len;					\
> -	n = len;						\
> +	do {							\
> +		len -= (STEP);					\
> +		i->iov_offset += len;				\
> +		n = len;					\
> +	} while (0);						\
>  }

*blink*

What is that supposed to change?

>  /* covers iovec and kvec alike */
> @@ -1611,6 +1613,64 @@ ssize_t extract_iter_to_iter(struct iov_iter *orig,
>  }
>  EXPORT_SYMBOL(extract_iter_to_iter);
>  
> +/**
> + * iov_iter_scan - Scan a source iter
> + * @i: The iterator to scan
> + * @bytes: The amount of buffer/data to scan
> + * @scanner: The function to call to process each segment
> + * @priv: Private data to pass to the scanner function
> + *
> + * Scan an iterator, passing each segment to the scanner function.  If the
> + * scanner returns an error at any time, scanning stops and the error is
> + * returned, otherwise the sum of the scanner results is returned.
> + */
> +ssize_t iov_iter_scan(struct iov_iter *i, size_t bytes,
> +		      ssize_t (*scanner)(struct iov_iter *i, const void *p,
> +					 size_t len, size_t off, void *priv),
> +		      void *priv)
> +{
> +	unsigned int gup_flags = 0;
> +	ssize_t ret = 0, scanned = 0;
> +
> +	if (!bytes)
> +		return 0;
> +	if (WARN_ON(iov_iter_is_discard(i)))
> +		return 0;
> +	if (iter_is_iovec(i))
> +		might_fault();
> +
> +	if (iov_iter_rw(i) != WRITE)
> +		gup_flags |= FOLL_WRITE;
> +	if (i->nofault)
> +		gup_flags |= FOLL_NOFAULT;
> +
> +	iterate_and_advance(
> +		i, bytes, base, len, off, ({
> +				struct page *page;
> +				void *q;
> +
> +				ret = get_user_pages_fast((unsigned long)base, 1,
> +							  gup_flags, &page);
> +				if (ret < 0)
> +					break;
> +				q = kmap_local_page(page);
> +				ret = scanner(i, q, len, off, priv);
> +				kunmap_local(q);
> +				put_page(page);
> +				if (ret < 0)
> +					break;
> +				scanned += ret;
> +			}), ({

Huh?  You do realize that the first ("userland") callback of
iterate_and_advance() is expected to have the amount not processed
as value?  That's what this
	len -= (STEP);
is about.  And anything non-zero means "fucking stop already".

How the hell does that thing manage to work?  And what makes you
think that it'll keep boinking an iovec segment again and again
on short operations?  Is that what that mystery do-while had
been supposed to do?

This makes no sense.  Again, I'm not even talking about the
potential usefulness of the primitive in question - it won't work
as posted, period.
