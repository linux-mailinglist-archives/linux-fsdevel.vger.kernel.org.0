Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C2867817D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 17:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjAWQbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 11:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjAWQby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:31:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC002A9B4;
        Mon, 23 Jan 2023 08:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ogSQ1nggVA0tfMOu1kPeInQ5MLmUuXd3lsU0a14evzA=; b=WSBGPpRgowqRhjKKXsXuw4V/EH
        cd2qxR7YOgvJNFXUaTprW+CLdgAjbI1xzzHLBkquHLgA70ADUgb67+wO0bBkPGfU4Pl9mEMOBajn4
        BLYuBGVomAkx+7nLueQyMcl+HBf9Um26Pq/9XMtGUYlKoEmHVJtorcla04CNNfhl8NOF796xBWzNR
        nhu70RIrQp9Tp/TJWeDCoSAWeDKx8M6M4+kCLiVVlW7pCO+3HGOdZSptJYrescNjhli9ofr1kE+bX
        IGIB2PYsrrzbGwput0+DBBBuzA7GbewhukaYY5w22Ed7qQKwodbLdyMOydK8/G4TKfFDPZbMCZbuD
        WAleAu3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJzjI-004Mwi-1r; Mon, 23 Jan 2023 16:31:32 +0000
Date:   Mon, 23 Jan 2023 16:31:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or
 just list)
Message-ID: <Y862ZL5umO30Vu/D@casper.infradead.org>
References: <20230120175556.3556978-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120175556.3556978-1-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 05:55:48PM +0000, David Howells wrote:
>  (3) Make the bio struct carry a pair of flags to indicate the cleanup
>      mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (equivalent to
>      FOLL_GET) and BIO_PAGE_PINNED (equivalent to BIO_PAGE_PINNED) is
>      added.

I think there's a simpler solution than all of this.

As I understand the fundamental problem here, the question is
when to copy a page on fork.  We have the optimisation of COW, but
O_DIRECT/RDMA/... breaks it.  So all this page pinning is to indicate
to the fork code "You can't do COW to this page".

Why do we want to track that information on a per-page basis?  Wouldn't it
be easier to have a VM_NOCOW flag in vma->vm_flags?  Set it the first
time somebody does an O_DIRECT read or RDMA pin.  That's it.  Pages in
that VMA will now never be COWed, regardless of their refcount/mapcount.
And the whole "did we pin or get this page" problem goes away.  Along
with folio->pincount.

