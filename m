Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ABE66D767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbjAQICK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbjAQICH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:02:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16636E95;
        Tue, 17 Jan 2023 00:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cmVV6xRQmaK0l4HRL/lhH4XySz+BO5RzfEmX6d+cJZM=; b=KLeqLLx0NC+cXLbPhHSUJXvm/7
        R/nl/8FixpSCZgHfNJHIPElbnFHiIR85J0mANjkPduyvsnh1TOci2q3m71cXS3BTbn0rB7Cz89ZKR
        QJAkNO6pNAybiWH/mXlGOEdMFq76IoX3V3FwiGVTg4NHWsFd/mnXxJ25MuAMbuJ7LQ+p227fBxOR3
        Un7EcKwFO+MI7nMp+e4NwGZ0ykdgaaqkKmYEVm7lp8JJsaj7uZsVdxh3ZYbuzZKlGAOlGi3wAv6H9
        sZsf0ybxabL89GqyzG8JI9EW8On10C7w0tMsJWtBI0gBakel51gCmn+QjxRoDvc2+FTWOhTth9ZBN
        b7LOBerA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHgut-00DGYh-Be; Tue, 17 Jan 2023 08:01:59 +0000
Date:   Tue, 17 Jan 2023 00:01:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/34] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y8ZV9x9gawJPbQho@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391053207.2311931.16398133457201442907.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391053207.2311931.16398133457201442907.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Changes:
> ========
> ver #6)
>  - Add back the function to indicate the cleanup mode.
>  - Drop the cleanup_mode return arg to iov_iter_extract_pages().
>  - Pass FOLL_SOURCE/DEST_BUF in gup_flags.  Check this against the iter
>    data_source.

FYI, the changelog goes after the --- so that it doesn't get added
to the git history.

> Link: https://lore.kernel.org/r/166732025748.3186319.8314014902727092626.stgit@warthog.procyon.org.uk/ # rfc
> Link: https://lore.kernel.org/r/166869689451.3723671.18242195992447653092.stgit@warthog.procyon.org.uk/ # rfc
> Link: https://lore.kernel.org/r/166920903885.1461876.692029808682876184.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/166997421646.9475.14837976344157464997.stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/167305163883.1521586.10777155475378874823.stgit@warthog.procyon.org.uk/ # v4
> Link: https://lore.kernel.org/r/167344728530.2425628.9613910866466387722.stgit@warthog.procyon.org.uk/ # v5

And all these links aren't exactly useful.  This fairly trivial commit
is going to look like a hot mess in git.

> +ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
> +			       size_t maxsize, unsigned int maxpages,
> +			       unsigned int gup_flags, size_t *offset0);

This function isn't actually added in the current patch.

> +#define iov_iter_extract_mode(iter, gup_flags) \
> +	(user_backed_iter(iter) ?				\
> +	 (gup_flags & FOLL_BUF_MASK) == FOLL_SOURCE_BUF ?	\
> +	 FOLL_GET : FOLL_PIN : 0)

And inline function would be nice here.  I guess that would require
moving the FULL flags into mm_types.h, though.
