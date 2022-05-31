Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA31538B24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 08:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbiEaGDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 02:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiEaGDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 02:03:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A850320BC8;
        Mon, 30 May 2022 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7rwKoQZ4MEC+tY2z3EkkAzowzOWBFLJ4KS64zS4XiMw=; b=ylQkXBY59a/AWjU5TewxLxaFEy
        1oGF91yy5ep3+2/Wiwuoem3Ow2uFPbx/SgRj19Z2h3jX+1RhjwbAQXqxiapOU6dAEZFbLlEuNp3mE
        57nwJ2U2gBiSvs8HH9zJ1+yuFElBWLu7++nYhTZe7+0rxFyRgvpwkHoXuK1AUn3KoVCLJ6w6eBtHF
        FEoQgR/e2SG7f77jJEPPRQZI/fUqQ9ZNVVoZ6H3D/Isrnc3oaE1VPzEoMIwxk+QemJGhAo3mHZ9AM
        HY0/OM20DC7gOepgPSG01+TeYgD+aof1LDpc5x0ML4gEspnKD2HafhH9oJzhlvJ2xG311tsV8lNcM
        ymjpWUqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvuyI-009TcV-BC; Tue, 31 May 2022 06:03:14 +0000
Date:   Mon, 30 May 2022 23:03:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] iov_iter: Add a function to extract an iter's
 buffers to a bvec iter
Message-ID: <YpWvolJHuCWAnL62@infradead.org>
References: <165364823513.3334034.11209090728654641458.stgit@warthog.procyon.org.uk>
 <165364824259.3334034.5837838050291740324.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165364824259.3334034.5837838050291740324.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 11:44:02AM +0100, David Howells wrote:
> Copy cifs's setup_aio_ctx_iter() and to lib/iov_iter.c and generalise it as
> extract_iter_to_iter().  This allocates and sets up an array of bio_vecs
> for all the page fragments in an I/O iterator and sets a second supplied
> iterator to bvec-type pointing to the array.
> 
> This is can be used when setting up for a direct I/O or an asynchronous I/O
> to set up a record of the page fragments that are going to contribute to
> the buffer, paging them all in to prevent DIO->mmap loops and allowing the
> original iterator to be deallocated (it may be on the stack of the caller).
> 
> Note that extract_iter_to_iter() doesn't actually need to make a separate
> allocation for the page array.  It can place the page array at the end of
> the bvec array storage, provided it traverses both arrays from the 0th
> element forwards.

I really do not like this as a general purpose helper.  This is an odd
quirk that we really generally should not needed unless you have very
convoluted locking.  So please keep it inside of cifs.
