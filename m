Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3697667D854
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 23:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjAZW1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 17:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjAZW1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:27:19 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6C5894E;
        Thu, 26 Jan 2023 14:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=STYji93U3ACAaGQFYmzFPWVQjHiGVhb+LyWgK4H0YqE=; b=doVxp+d4MftLA/hoq1I/XVGa9k
        vznOjMNWPk/5xKmfT78tFmvPfpqLZm55p/BDZLhARkzVgjqati18BiuamgW2J9J6i0PASTm2t02i3
        oFGu+A9yxtL51prBiRJeJm2dCcuwWHZjRBVpcV/H3S2KIlfAyqdRHzMmMHgUT37wIOcxlDx1lNmOe
        qwfJIAo4C+28FNp8DW9IzxLr7Jr+gwoEc94wC3jhLe+TqcMotyHGewLoBdYFsZR/pitGWlOszRXz9
        aQTHvlVi/DQcE3vQomIDalXhSF1aR+wAWQ7senFmGvOHTCPVadBxfAW7XCTQX2Pc5R3D+JevZqXFb
        8vBPfsGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pLAi3-004KMs-11;
        Thu, 26 Jan 2023 22:27:07 +0000
Date:   Thu, 26 Jan 2023 22:27:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] iov_iter: Use __bitwise with the extraction_flags
Message-ID: <Y9L+O4V5uJIWFnmI@ZenIV>
References: <e7d476d7-e201-86a3-9683-c2a559fc2f5b@redhat.com>
 <af0e448a-9559-32c0-cc59-10b159459495@redhat.com>
 <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-2-dhowells@redhat.com>
 <2613249.1674726566@warthog.procyon.org.uk>
 <2638928.1674729230@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2638928.1674729230@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 10:33:50AM +0000, David Howells wrote:
> X-Mailer: MH-E 8.6+git; nmh 1.7.1; GNU Emacs 28.2
> --------
> David Hildenbrand <david@redhat.com> wrote:
> 
> > >> Just a note that the usage of new __bitwise types instead of "unsigned" is
> > >> encouraged for flags.
> 
> Something like the attached?
> 
> > $ git grep "typedef int" | grep __bitwise | wc -l
> > 27
> > $ git grep "typedef unsigned" | grep __bitwise | wc -l
> > 23
> 
> git grep __bitwise | grep typedef | grep __u | wc -l
> 62
> 
> *shrug*
> 
> Interestingly, things like __be32 are __bitwise.  I wonder if that actually
> makes sense or if it was just convenient so stop people doing arithmetic on
> them.  I guess doing AND/OR/XOR on them isn't a problem provided both
> arguments are appropriately byte-swapped.

Forget the words "byte-swapped".  There are several data types.
With different memory representations.  Bitwise operations are
valid between the values of the same type and yield the result
of that same type.

The fact that mapping between those representations happens to
be an involution is an accident; keeping track of the number of
times you've done a byteswap to the value currently in this
variable is asking for trouble.  It's really easy to fuck up.

"Am I trying to store the value of type X in variable of type Y
(presumably having forgotten that I need to use X_to_Y(...)
to convert)" is much easier to keep track of.
