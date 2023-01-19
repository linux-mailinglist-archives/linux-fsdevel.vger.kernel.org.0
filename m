Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9333A672F00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 03:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjASCcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 21:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASCcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:32:03 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3FAA24E;
        Wed, 18 Jan 2023 18:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ALLkriTWE+SzQ0sqzMUjGDLtM+PH1VXpy/CU3zVeJ/E=; b=ENObJlCpA6C70A+samIfTPkGeo
        5zl+m9fp7s4ZnPB0kuPmwyEkDZujgpYlmLu0t4X5ZAzAwUPxgOXOqRVRgMy8ATxPO72aTVyZ18Mg9
        4JW3pJPVJFDK8G2VxY37mD3WdE+qOz6wLrsMbh6AG+4gTYdZua0jHS/MFtCOwzXv3TXjsKnsnUGqO
        fq4aYMHb+HygThlbM6fSCQMmpt2glx+yY/+m2fOKCbET69IKJihm+fhkdChtyFwxPFOB6l3O3E/6F
        HfLhAqZoEUnk3Y3AK5ufM9wTGFHm70MzOLZIFGgDvw9A8hhfBiMixFbq0mVTPpjqB9VcYUYksS3Dn
        ch6T6PcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIKib-002euc-2o;
        Thu, 19 Jan 2023 02:31:57 +0000
Date:   Thu, 19 Jan 2023 02:31:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 20/34] vfs: Make splice use iov_iter_extract_pages()
Message-ID: <Y8irne7Dj6H6GIc8@ZenIV>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391062544.2311931.15195962488932892568.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391062544.2311931.15195962488932892568.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:10:25PM +0000, David Howells wrote:

> diff --git a/fs/splice.c b/fs/splice.c
> index 19c5b5adc548..c3433266ba1b 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1159,14 +1159,18 @@ static int iter_to_pipe(struct iov_iter *from,
>  	size_t total = 0;
>  	int ret = 0;
>  
> +	/* For the moment, all pages attached to a pipe must have refs, not pins. */
> +	if (WARN_ON(iov_iter_extract_mode(from, FOLL_SOURCE_BUF) != FOLL_GET))
> +		return -EIO;

Huh?  WTF does that have to do with pins?  Why would we be pinning the _source_
pages anyway?  We do want them referenced, for obvious reasons (they might be
stuck in the pipe), but that has nothing to do with get vs. pin.

If anything, this is one place where we want the semantics of iov_iter_get_pages...
