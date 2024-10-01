Return-Path: <linux-fsdevel+bounces-30570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C328E98C6AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 22:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73231C22F0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576C21CDA0D;
	Tue,  1 Oct 2024 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RTXUqRD+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559E1925B8
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813985; cv=none; b=hYVLPFVcSYyWTk6db1yIZaQlEZHJGSzrz0My5U0XwGHGTe7tKxjBU9OAE4rfC6LTH0Fa67ksgV5unnxqKiFtwHRZbZjtGWLvFkypSbZv9SG0OxMBAMGo9YBCKCJBTRldONPpMKSADYh7F0M1bWTTV5eHaU0bUR1MfDk2ifTahW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813985; c=relaxed/simple;
	bh=YdA06Mh1Mw0HnxLaLCaA7LkH8OtpodcAKZ2k1S+GBwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khNX3axaoRK1WfOSdcqrWTSJfpwMcDocEEpPxIRM8WXl+VI7s+yP/+9WPAUKqs1Ttn7Irn+mhEzRzOrIu8I9lklW0HUEVjWldr/Oofgw1WiQMtXmZBb7A+F4S+qDJ7fRIYzltxXghS8W81eQU5a0xFPyGCnEkdC6LuNc3KKU8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RTXUqRD+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-458311b338eso48869981cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727813982; x=1728418782; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u+P53EmwH3eJ5ZpsXemm7rNkzt2Mwsbh6dEwgOLE01Q=;
        b=RTXUqRD+tePJSiZyH7U5hZmVk4AA+JQX3ESweInOL2ow3z17ddOmehFQ8f8ZhO5bTw
         QPGy7i7Mk0zGje2pnlw2aucFwOx9+tmEpShRn6XBT7sjqVOYTlGXJifQWDCCyIKTxQoi
         yyau8wyG4wZ08Flmvjjc6hoImuyq+VsxuwvPjbCgDIgaumCNdQCsvA1eNE3MUSworz+b
         CrTEc67jvQtqaZiePQuoKEceYXFHNzRHuuf4KwDjrOaEXle6811FLuZ7XNTJP6hJRmjU
         qo3MiGdlhdqF0/CNJhKb/C0duB6N6hSer9THplMG5Xigq1L1eTGBTWdrkHnKayY76H8N
         svuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813982; x=1728418782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+P53EmwH3eJ5ZpsXemm7rNkzt2Mwsbh6dEwgOLE01Q=;
        b=AFWUYRx257zLnAocHWY+pOAZooUshySf5pXYSq44A1xkRuyak2fXfaMwIPrMliK2uH
         Wm3HG+P2035ZfmiQ+V3+iU3FJFeBd3n3l6ehEjk0F63CpVx/z9dpY/9jbHil+39pYHj1
         I6sAqe5njXB5PMEa+TMHDklhWJM7F4XdQ4r7hC7Ak3RFNoX4wJHPNruj853uhQpEa8GW
         K8+nuNHga3CWmycLMxEP+OmbJNoWUVJl/7cRj0lflLN9ECi0trbq0x3SESvoAdQ1xCge
         nlkp9wb8530ZonFE0XfafwJDZtHQZmVwjFpqQZ2pWWuzWEdj7qSzxqW4IGHzOsKwppSL
         aS7g==
X-Gm-Message-State: AOJu0YzZr9hQMWrYXLjo9CHNWU2Njqv1QgUYo+8hAyVXEwUfyv96RBZB
	CRIovxeU5oK48BF2/4Wdf09JOu3PNzsafoCiul3hOXm8bUQ/wkABPi8a6ULdf/Y=
X-Google-Smtp-Source: AGHT+IHKbYhMx0hpmRVJGKaw6x1sCRrM7RzzRp2BenZAGF0g+oWEi5qU8v8Kyms4tiMucXHYsuEcsQ==
X-Received: by 2002:ac8:58c4:0:b0:458:34fb:5d65 with SMTP id d75a77b69052e-45d804c308emr10529521cf.23.1727813982153;
        Tue, 01 Oct 2024 13:19:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2ea78fsm48331451cf.54.2024.10.01.13.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:19:40 -0700 (PDT)
Date: Tue, 1 Oct 2024 16:19:39 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	kernel-team@fb.com
Subject: Re: [PATCH v4 06/10] fuse: convert fuse_do_readpage to use folios
Message-ID: <20241001201939.GA952979@perftesting>
References: <cover.1727703714.git.josef@toxicpanda.com>
 <17ca5aafb5c9591d28553c8af42551c8bc23a9ef.1727703714.git.josef@toxicpanda.com>
 <CAJnrk1bmyxJqsYwSWBdRX8P29cLi_R+6cb0ZDnzHEMj4vG-FyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bmyxJqsYwSWBdRX8P29cLi_R+6cb0ZDnzHEMj4vG-FyA@mail.gmail.com>

On Tue, Oct 01, 2024 at 09:54:51AM -0700, Joanne Koong wrote:
> On Mon, Sep 30, 2024 at 6:46 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Now that the buffered write path is using folios, convert
> > fuse_do_readpage() to take a folio instead of a page, update it to use
> > the appropriate folio helpers, and update the callers to pass in the
> > folio directly instead of a page.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> 
> > ---
> >  fs/fuse/file.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 2af9ec67a8e7..45667c40de7a 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -858,12 +858,13 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
> >         }
> >  }
> >
> > -static int fuse_do_readpage(struct file *file, struct page *page)
> > +static int fuse_do_readfolio(struct file *file, struct folio *folio)
> >  {
> > -       struct inode *inode = page->mapping->host;
> > +       struct inode *inode = folio->mapping->host;
> >         struct fuse_mount *fm = get_fuse_mount(inode);
> > -       loff_t pos = page_offset(page);
> > +       loff_t pos = folio_pos(folio);
> >         struct fuse_page_desc desc = { .length = PAGE_SIZE };
> > +       struct page *page = &folio->page;
> >         struct fuse_io_args ia = {
> >                 .ap.args.page_zeroing = true,
> >                 .ap.args.out_pages = true,
> > @@ -875,11 +876,11 @@ static int fuse_do_readpage(struct file *file, struct page *page)
> >         u64 attr_ver;
> >
> >         /*
> > -        * Page writeback can extend beyond the lifetime of the
> > -        * page-cache page, so make sure we read a properly synced
> > -        * page.
> > +        * With the temporary pages that are used to complete writeback, we can
> > +        * have writeback that extends beyond the lifetime of the folio.  So
> > +        * make sure we read a properly synced folio.
> >          */
> > -       fuse_wait_on_page_writeback(inode, page->index);
> > +       fuse_wait_on_folio_writeback(inode, folio);
> >
> >         attr_ver = fuse_get_attr_version(fm->fc);
> >
> > @@ -897,25 +898,24 @@ static int fuse_do_readpage(struct file *file, struct page *page)
> >         if (res < desc.length)
> >                 fuse_short_read(inode, attr_ver, res, &ia.ap);
> >
> > -       SetPageUptodate(page);
> > +       folio_mark_uptodate(folio);
> >
> >         return 0;
> >  }
> >
> >  static int fuse_read_folio(struct file *file, struct folio *folio)
> >  {
> > -       struct page *page = &folio->page;
> > -       struct inode *inode = page->mapping->host;
> > +       struct inode *inode = folio->mapping->host;
> >         int err;
> >
> >         err = -EIO;
> >         if (fuse_is_bad(inode))
> >                 goto out;
> >
> > -       err = fuse_do_readpage(file, page);
> > +       err = fuse_do_readfolio(file, folio);
> >         fuse_invalidate_atime(inode);
> >   out:
> > -       unlock_page(page);
> > +       folio_unlock(folio);
> >         return err;
> >  }
> >
> > @@ -2444,7 +2444,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
> >                         folio_zero_segment(folio, 0, off);
> >                 goto success;
> >         }
> > -       err = fuse_do_readpage(file, &folio->page);
> > +       err = fuse_do_readfolio(file, folio);
> 
> I'm on top of Miklos' for-next tree but I'm seeing this patch unable
> to apply cleanly. On the top of the tree, I see the original line as:
> 
> err = fuse_do_readpage(file, page);
> 
> Is there another patch/patchset this stack is based on top of?

Yeah Willy had a folio conversion that's in Linus's tree but is newer than
Miklos's base for his tree.  Thanks,

Josef

