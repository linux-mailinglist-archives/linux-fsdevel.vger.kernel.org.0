Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1896C536442
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353594AbiE0OeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 10:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353516AbiE0Odp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 10:33:45 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5925C1498C2;
        Fri, 27 May 2022 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zOBDMvwNpdNtLy6GFqdykdncvAjdAHDTWWUuYlWRS5A=; b=C8RFCHzLUJ/9IyR58bGlzRjL1D
        1kwOnzQ67QKIhUfXgkKCKO0XcUaZ2uNfBKwC7dZIN/ytPPe0kEURbKEm/Xqe+B52phCICXAP9oKIK
        WqXsFLi37D5SJ2duHYFJPycUTrj6N47sSJe2yA4sww13PWqrS+4RuY4LMl/7bQY5J5n/wr7QOFymD
        PW65CDVFDXLli8z8qX+yY9ZCDPc6ATJ4r/A3Mw4Q6oeqHUffL+wciBdRFdYGe4REJ3wzN+PVUB881
        P7LGdQ0p/Nddd2a+i5xzGAed+k1VjHznpFWJq2nb/J8EnYsuDmwotXJGbJVKHpXM+lmE4ond/bwYB
        jZKvUHkw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nub1U-0018YI-59; Fri, 27 May 2022 14:33:04 +0000
Date:   Fri, 27 May 2022 14:33:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] iov_iter: Add a general purpose iteration function
Message-ID: <YpDhIDacnktXvMpS@zeniv-ca.linux.org.uk>
References: <165364823513.3334034.11209090728654641458.stgit@warthog.procyon.org.uk>
 <165364824973.3334034.10715738699511650662.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165364824973.3334034.10715738699511650662.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 11:44:09AM +0100, David Howells wrote:
> Add a function, iov_iter_scan(), to iterate over the buffers described by
> an I/O iterator, kmapping and passing each contiguous chunk the supplied
> scanner function in turn, up to the requested amount of data or until the
> scanner function returns an error.
> 
> This can be used, for example, to hash all the data in an iterator by
> having the scanner function call the appropriate crypto update function.

> +ssize_t iov_iter_scan(struct iov_iter *i, size_t bytes,
> +		      ssize_t (*scanner)(struct iov_iter *i, const void *p,
> +					 size_t len, size_t off, void *priv),
> +		      void *priv)
> +{
> +	ssize_t ret = 0, scanned = 0;
> +
> +	if (!bytes)
> +		return 0;
> +	if (iter_is_iovec(i))
> +		might_fault();
> +
> +	iterate_and_advance(
> +		i, bytes, base, len, off, ({
> +				ret = scanner(i, base, len, off, priv);
> +				if (ret < 0)
> +					break;
> +				scanned += ret;
> +			}), ({
> +				ret = scanner(i, base, len, off, priv);
> +				if (ret < 0)
> +					break;
> +				scanned += ret;
> +			})
> +	);
> +	return ret < 0 ? ret : scanned;
> +}

Have you even tried to run sparse on that?  How could that possibly work?
You are feeding the same callback both userland and kernel pointers;
that makes no sense.

NAK.
