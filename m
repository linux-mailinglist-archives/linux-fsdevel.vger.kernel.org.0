Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEA70A4FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 05:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjETDz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 23:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjETDzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 23:55:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3A7E3;
        Fri, 19 May 2023 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oL9McTatLzHAnvigXeTVcWUVg0VQVXOaPT42iNyRB/I=; b=uFVuErhl9FJ8po3AK62lX9hvDS
        oqPSzYD12l6vrFqhWjp8Zp0Tds1+aNcCpz0R2/DYhXeYq5Nqf45/hVBGlYPu0Th5KCrpYeTYJHTu+
        rEzVFFIB1bkLogNKU3egCB8886wQgii88jrgrYA21qNeaueL4UFNrq/oVXF6+iqM9890s0Sv2fcZ+
        5YIPlDW6IQpR7Eq9SUhTPkG+CBpJD/SrLX1IgXHoX4VlU1cyNEVtVVEdheuZa21Ew6oLZPZVlmqGX
        2X96l2gCZbv5fmOV13NyDPGxDUxRFSEoF+y+couTXvwfpDKDQ1M+rmzaO0Br5FKGiTHfu180VVimF
        6AMfAFTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q0DgF-000bJ1-28;
        Sat, 20 May 2023 03:54:55 +0000
Date:   Fri, 19 May 2023 20:54:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof
 where appropriate
Message-ID: <ZGhEj5RhZYwCnzKG@infradead.org>
References: <ZGc3vUU/bUpt+3Tm@infradead.org>
 <ZGcusJQfz68H1s7S@infradead.org>
 <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-4-dhowells@redhat.com>
 <1742093.1684485814@warthog.procyon.org.uk>
 <2154518.1684535271@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2154518.1684535271@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 11:27:51PM +0100, David Howells wrote:
> 	ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
> 					 struct pipe_inode_info *pipe, size_t len,
> 					 unsigned int flags)
> 	{
> 		if (unlikely(*ppos >= in->f_mapping->host->i_sb->s_maxbytes))
> 			return 0;
> 		if (unlikely(!len))
> 			return 0;
> 		return filemap_splice_read(in, ppos, pipe, len, flags);
> 	}
> 
> so I wonder if the tests in generic_file_splice_read() can be folded into
> vfs_splice_read(), pointers to generic_file_splice_read() be replaced with
> pointers to filemap_splice_read() and generic_file_splice_read() just be
> removed.
> 
> I suspect we can't quite do this because of the *ppos check - but I wonder if
> that's actually necessary since filemap_splice_read() checks against
> i_size... or if the check can be moved there if we definitely want to do it.
> 
> Certainly, the zero-length check can be done in vfs_splice_read().

The zero length check makes sense in vfs_splice_read.  The ppos check
I think makes sense for filemap_splice_read - after all we're dealing
with the page cache here, and the page cache needs a working maxbytes
and i_size.  What callers of filemap_splice_read that don't have the
checks do you have in your tree right now and how did you end up with
them?
