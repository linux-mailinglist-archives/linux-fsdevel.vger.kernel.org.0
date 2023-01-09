Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B346629EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjAIPaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjAIPaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:30:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DB91274E;
        Mon,  9 Jan 2023 07:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bc3idNtsAWoy+2ncthmgzQVDyaeHH0rtTXHo3T/zuhY=; b=s5EGoru1cjrQGCeJd8V5jrtw8M
        4F35tTEElZxf/CtwBjrbyUMGZaLo1nfwDDFZhuUBJcOzsS3fn/fcNpCl1YLHI7d0KkjxpgxkmrHt5
        DbsKYCc6pQkXM/XeUS0SLTyWuI8dz9qEyeA41HHlmPDsIdlJL9wJ0By55ryA6muYyBoUFdFqNa0zR
        dtLKHexYBfgPycRA7VqD2C8ovNa6hN2Mu0A2iWpf/pdRqDEU0VvGCj7TBmIu28ZY2mDggDREJ0uSI
        Y1YL48eJzcmwLXjeSMjaXkVOTvwqNrnHLdsqhGTIFnMUXjg5ufmnsCsJTok1VDdgcQav145biosm3
        2mCAIKig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEu6E-002Odi-Ac; Mon, 09 Jan 2023 15:30:10 +0000
Date:   Mon, 9 Jan 2023 15:30:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/11] cifs: Remove call to filemap_check_wb_err()
Message-ID: <Y7wzAml5tAZXNMGV@casper.infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
 <20230109051823.480289-9-willy@infradead.org>
 <7d1499fadf42052711e39f0d8c7656f4d3a4bc9d.camel@redhat.com>
 <74c40f813d4dc2bf90fbf80a80a5f0ba15365a90.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74c40f813d4dc2bf90fbf80a80a5f0ba15365a90.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 10:14:12AM -0500, Jeff Layton wrote:
> On Mon, 2023-01-09 at 09:42 -0500, Jeff Layton wrote:
> > On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> > > filemap_write_and_wait() now calls filemap_check_wb_err(), so we cannot
> > > glean any additional information by calling it ourselves.  It may also
> > > be misleading as it will pick up on any errors since the beginning of
> > > time which may well be since before this program opened the file.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  fs/cifs/file.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> > > index 22dfc1f8b4f1..7e7ee26cf77d 100644
> > > --- a/fs/cifs/file.c
> > > +++ b/fs/cifs/file.c
> > > @@ -3042,14 +3042,12 @@ int cifs_flush(struct file *file, fl_owner_t id)
> > >  	int rc = 0;
> > >  
> > >  	if (file->f_mode & FMODE_WRITE)
> > > -		rc = filemap_write_and_wait(inode->i_mapping);
> > > +		rc = filemap_write_and_wait(file->f_mapping);
> > 
> > If we're calling ->flush, then the file is being closed. Should this
> > just be?
> > 		rc = file_write_and_wait(file);
> > 
> > It's not like we need to worry about corrupting ->f_wb_err at that
> > point.
> > 
> 
> OTOH, I suppose it is possible for there to be racing fsync syscall with
> a filp_close, and in that case advancing the f_wb_err might be a bad
> idea, particularly since a lot of places ignore the return from
> filp_close. It's probably best to _not_ advance the f_wb_err on ->flush
> calls.

There's only so much we can do to protect an application from itself.
If it's racing an fsync() against close(), it might get an EBADF from
fsync(), or end up fsyncing entirely the wrong file due to a close();
open(); associating the fd with a different file.

> That said...wonder if we ought to consider making filp_close and ->flush
> void return functions. There's no POSIX requirement to flush all of the
> data on close(), so an application really shouldn't rely on seeing
> writeback errors returned there since it's not reliable.
> 
> If you care about writeback errors, you have to call fsync -- full stop.

Yes, most filesystems do not writeback dirty data on close().
Applications can't depend on that behaviour.  Interestingly, if you read
https://pubs.opengroup.org/onlinepubs/9699919799/functions/close.html
really carefully, it says:

   If an I/O error occurred while reading from or writing to the file
   system during close(), it may return -1 with errno set to [EIO];
   if this error is returned, the state of fildes is unspecified.

So if we return an error, userspace doesn't know if this fd is still
open or not!  This feels like poor underspecification on POSIX's part
(and probably stems from a historical unwillingness to declare any
vendor's implementation as "not Unix").
