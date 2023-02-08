Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FCB68E77C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 06:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBHF0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 00:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjBHF0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:26:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB9019F31;
        Tue,  7 Feb 2023 21:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ARUk2d+sCZWHwDfzIfVXqPEuRg8EkLiwolIcbG+SXl8=; b=dGBxZ03m2u5KOBfx4zSZmaWzCu
        QnYmO5ClWXP9xHv1kOW0PfgPS08zK9C2Mn2bDiYwzV6CxcVPImWxf0QGCxmUFoPTmGZi2Tp6kyQCF
        I0qaDRpYccC/RTV8kgZyTmRsfA2bA8XyNibSBOIEG5YqSLlTitmjCQU/rajwpGNSlyHCkEjhIjHLJ
        j6wHZuzTx+DkFrfO5cSuSrG+WRvpnlmOAYhu2kl+nFTter83HvV0jGP8B0DOlV7NWcrhUIIfQBY6N
        gpUpImp5sAyneCLq3jYTLKNq42YiMiMZKYaNXe0A/gOpX4CyoUCZDnRQYuDjCB+dvwjIqWHxUSK5P
        +CCciz5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPcyC-00E6v3-2u; Wed, 08 Feb 2023 05:26:12 +0000
Date:   Tue, 7 Feb 2023 21:26:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v12 01/10] vfs, iomap: Fix generic_file_splice_read() to
 avoid reversion of ITER_PIPE
Message-ID: <Y+MydH2HZ7ihITli@infradead.org>
References: <20230207171305.3716974-1-dhowells@redhat.com>
 <20230207171305.3716974-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207171305.3716974-2-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Subject nitpick:  this does not ouch iomap at all.

> Fix this by replacing the use of an ITER_PIPE iterator with an ITER_BVEC
> iterator for which reversion won't free the buffers.  Bulk allocate all the
> buffers we think we're going to use in advance, do the read synchronously
> and only then trim the buffer down.  The pages we did use get pushed into
> the pipe.
> 
> This is more efficient by virtue of doing a bulk page allocation, but
> slightly less efficient by ignoring any partial page in the pipe.

For the usual case of a buffered read into the iter, this completely
changes the semantics:

 - before the pagecache pages just grew a new reference and were
   added to the pipe buffer, and I/O was done without an extra
   copy
 - with this patch you always allocate an extra set of pages for
   the pipe and copy to it

So I very much doubt this makes anything more efficient, and I don't
think we can just do it.

We'll have to fix reverting of pipe buffers, just as I already pointed
out in your cifs series that tries to play the same game.
