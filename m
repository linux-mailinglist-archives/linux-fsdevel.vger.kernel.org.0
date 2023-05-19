Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264D0709B72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjESPih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjESPif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 11:38:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A09F1A5;
        Fri, 19 May 2023 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W4aX23dKebvala963Zucx7YwQWSx9NKzbQfQtWZUXlo=; b=SUvEB+vt+3sEqMdFKgF5kDaHdZ
        kNMhfcUHCna+gH3/dBYFL1esgDX/iAj7ZKrX8/AKM42jvjIGWI60vbjwQoMke+03lQAaFUqyV/tz9
        WJr8kMA9sYWN3d4furqM//jcHSOJsNVcj3NytXHqf0zWJl6AEFLbb0HQ8QUOlSBHZSBYlvi+xJgJv
        PjPxr8PFfL0lJpOB5XkMVECVWLqwdZwEWk8pIDpG4NElDfUF03dlW+26L+qlMhNmQQ75R+py7JP6y
        EH52jbHL7dPXU/3LjTyKld8tkt5zrKR3ddyjV27HyKMRQ0xfddd4kKLQdmeVQq9O0Q29qYoeMjiCt
        2I5ouWzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q02BY-006eOh-2D; Fri, 19 May 2023 15:38:28 +0000
Date:   Fri, 19 May 2023 16:38:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Creating large folios in iomap buffered write path
Message-ID: <ZGeX9Oc5vTkrceLZ@casper.infradead.org>
References: <ZGacw+1cu49qnttj@casper.infradead.org>
 <ZGagv+dXx9xwuBy9@casper.infradead.org>
 <20230519105528.1321.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519105528.1321.409509F4@e16-tech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 10:55:29AM +0800, Wang Yugui wrote:
> Hi,
> 
> > On Thu, May 18, 2023 at 10:46:43PM +0100, Matthew Wilcox wrote:
> > > -struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
> > > +struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
> > >  {
> > >  	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
> > > +	struct folio *folio;
> > >  
> > >  	if (iter->flags & IOMAP_NOWAIT)
> > >  		fgp |= FGP_NOWAIT;
> > > +	fgp |= fgp_order(len);
> > >  
> > > -	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> > > +	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> > >  			fgp, mapping_gfp_mask(iter->inode->i_mapping));
> > > +	if (!IS_ERR(folio) && folio_test_large(folio))
> > > +		printk("index:%lu len:%zu order:%u\n", (unsigned long)(pos / PAGE_SIZE), len, folio_order(folio));
> > > +	return folio;
> > >  }
> > 
> > Forgot to take the debugging out.  This should read:
> > 
> > -struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
> > +struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
> >  {
> >  	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
> >  	if (iter->flags & IOMAP_NOWAIT)
> >  		fgp |= FGP_NOWAIT;
> > +	fgp |= fgp_order(len);
> >  
> >  	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> >  			fgp, mapping_gfp_mask(iter->inode->i_mapping));
> >  }
> 
> I test it (attachment file) on 6.4.0-rc2.
> fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30 -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 -numjobs=4 -directory=/mnt/test
> 
> fio  WRITE: bw=2430MiB/s.
> expected value: > 6000MiB/s
> so yet no fio write bandwidth improvement.

That's basically unchanged.  There's no per-page or per-block work being
done in start/end writeback, so if Dave's investigation is applicable
to your situation, I'd expect to see an improvement.

Maybe try the second version of the patch I sent with the debug in,
to confirm you really are seeing large folios being created (you might
want to use printk_ratelimit() instead of printk to ensure it doesn't
overwhelm your system)?  That fio command you were using ought to create
them, but there's always a chance it doesn't.

Perhaps you could use perf (the command Dave used) to see where the time
is being spent.
