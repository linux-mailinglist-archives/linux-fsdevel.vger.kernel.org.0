Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449D73D6632
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 20:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhGZRUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 13:20:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52324 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhGZRUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:20:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DB9711FECC;
        Mon, 26 Jul 2021 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627322442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I039/0NWrDWmFnOCULzI4FU9TwQx70EI3dDkBkl1gm8=;
        b=v16qsfsdsF7d5oKr5BblI50zphYIfZgLM3ugCnWaOSLGwcUUNxQ1D82i7cQXSnzVGDsfs+
        ST0rN+d9htcHITWuUYsnNEKRUh9SANaGBJ69dXfseqthBd2bPQSrTviag+mQbWovMtZUOd
        dPp6ZaYWqmxpD0VtHhEKxEioxXThMTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627322442;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I039/0NWrDWmFnOCULzI4FU9TwQx70EI3dDkBkl1gm8=;
        b=Up90HkPAkG8i53n20y1uG/mj6NXg2BN8ZdQnxCGQxWq0Jyv7abeYzJxhOwgVirsl0Zc3g2
        dP85KRvwsiSlKRBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 9C371A3B84;
        Mon, 26 Jul 2021 18:00:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 67F161E3B13; Mon, 26 Jul 2021 20:00:42 +0200 (CEST)
Date:   Mon, 26 Jul 2021 20:00:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v3 7/7] gfs2: Fix mmap + page fault deadlocks for direct
 I/O
Message-ID: <20210726180042.GN20621@quack2.suse.cz>
References: <20210723205840.299280-1-agruenba@redhat.com>
 <20210723205840.299280-8-agruenba@redhat.com>
 <20210726170250.GL20621@quack2.suse.cz>
 <CAHpGcMLOZhZ7tGrY7rcYWUwx12sY884T=eC-Ckna63PBmF=zwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMLOZhZ7tGrY7rcYWUwx12sY884T=eC-Ckna63PBmF=zwA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-07-21 19:50:23, Andreas Grünbacher wrote:
> Jan Kara <jack@suse.cz> schrieb am Mo., 26. Juli 2021, 19:10:
> 
> > On Fri 23-07-21 22:58:40, Andreas Gruenbacher wrote:
> > > Also disable page faults during direct I/O requests and implement the
> > same kind
> > > of retry logic as in the buffered I/O case.
> > >
> > > Direct I/O requests differ from buffered I/O requests in that they use
> > > bio_iov_iter_get_pages for grabbing page references and faulting in pages
> > > instead of triggering real page faults.  Those manual page faults can be
> > > disabled with the iocb->noio flag.
> > >
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > ---
> > >  fs/gfs2/file.c | 34 +++++++++++++++++++++++++++++++++-
> > >  1 file changed, 33 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> > > index f66ac7f56f6d..7986f3be69d2 100644
> > > --- a/fs/gfs2/file.c
> > > +++ b/fs/gfs2/file.c
> > > @@ -782,21 +782,41 @@ static ssize_t gfs2_file_direct_read(struct kiocb
> > *iocb, struct iov_iter *to,
> > >       struct file *file = iocb->ki_filp;
> > >       struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
> > >       size_t count = iov_iter_count(to);
> > > +     size_t written = 0;
> > >       ssize_t ret;
> > >
> > > +     /*
> > > +      * In this function, we disable page faults when we're holding the
> > > +      * inode glock while doing I/O.  If a page fault occurs, we drop
> > the
> > > +      * inode glock, fault in the pages manually, and then we retry.
> > Other
> > > +      * than in gfs2_file_read_iter, iomap_dio_rw can trigger implicit
> > as
> > > +      * well as manual page faults, and we need to disable both kinds
> > > +      * separately.
> > > +      */
> > > +
> > >       if (!count)
> > >               return 0; /* skip atime */
> > >
> > >       gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
> > > +retry:
> > >       ret = gfs2_glock_nq(gh);
> > >       if (ret)
> > >               goto out_uninit;
> > >
> > > +     pagefault_disable();
> >
> > Is there any use in pagefault_disable() here? iomap_dio_rw() should not
> > trigger any page faults anyway, should it?
> >
> 
> It can trigger physical page faults when reading from holes.

Aha, good point. Maybe even worth a comment at this site? Thanks for
explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
