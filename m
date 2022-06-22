Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8985540DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 05:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356516AbiFVDXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 23:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356339AbiFVDXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:23:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ABA5FE1;
        Tue, 21 Jun 2022 20:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gd8gvPDKJUfSWTRzefun4vrxfLe3EUIpuUk+m4wcIrs=; b=mUFsyC5knxIPjYhfw0K0A1iQbj
        dB7zXIFcdmPikLtc9dOvk0aQMDn3+ulelVlNM8gwKIiRST+4tHtOU6io6l+N+lnNLrEtFOqqVrzP0
        61wHQXv/yurjgu/PLcmJUOTOYgEbk9aU3mlv9R/OUxgozAAjKVI3oVZIHXv0+pCWw/TDqbgD05JQR
        1HNklpv+YWC5deP5pJ7UXh/16VeFdVSSabmSA9liHLfheNHY0nxLFb6Q9UO52Y7YdBwfBH6Y9p4Rg
        BcpO1bThZ8+pGXnbs+bUI1VFr4pjw50X7/rmuJ5RLqNS/l9vs+6QCdrS+3JluE3zfaae4jS57bTsj
        TQa0YaqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3qxP-006gdu-B9; Wed, 22 Jun 2022 03:23:07 +0000
Date:   Wed, 22 Jun 2022 04:23:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw
 workload
Message-ID: <YrKLG6YhMS+qLl8B@casper.infradead.org>
References: <20190408141114.GC15023@quack2.suse.cz>
 <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz>
 <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3>
 <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan>
 <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan>
 <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:53:33PM +0300, Amir Goldstein wrote:
> On Tue, Jun 21, 2022 at 11:59 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 21-06-22 10:49:48, Amir Goldstein wrote:
> > > > How exactly do you imagine the synchronization of buffered read against
> > > > buffered write would work? Lock all pages for the read range in the page
> > > > cache? You'd need to be careful to not bring the machine OOM when someone
> > > > asks to read a huge range...
> > >
> > > I imagine that the atomic r/w synchronisation will remain *exactly* as it is
> > > today by taking XFS_IOLOCK_SHARED around generic_file_read_iter(),
> > > when reading data into user buffer, but before that, I would like to issue
> > > and wait for read of the pages in the range to reduce the probability
> > > of doing the read I/O under XFS_IOLOCK_SHARED.
> > >
> > > The pre-warm of page cache does not need to abide to the atomic read
> > > semantics and it is also tolerable if some pages are evicted in between
> > > pre-warn and read to user buffer - in the worst case this will result in
> > > I/O amplification, but for the common case, it will be a big win for the
> > > mixed random r/w performance on xfs.
> > >
> > > To reduce risk of page cache thrashing we can limit this optimization
> > > to a maximum number of page cache pre-warm.
> > >
> > > The questions are:
> > > 1. Does this plan sound reasonable?
> >
> > Ah, I see now. So essentially the idea is to pull the readahead (which is
> > currently happening from filemap_read() -> filemap_get_pages()) out from under
> > the i_rwsem. It looks like a fine idea to me.
> 
> Great!
> Anyone doesn't like the idea or has another suggestion?

I guess I'm still confused.

The problem was the the XFS IOLOCK was being held while we waited for
readahead to complete.  To fix this, you're planning on waiting for
readahead to complete with the invalidate lock held?  I don't see the
benefit.

I see the invalidate_lock as being roughly equivalent to the IOLOCK,
just pulled up to the VFS.  Is that incorrect?

