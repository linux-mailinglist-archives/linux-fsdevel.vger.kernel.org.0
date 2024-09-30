Return-Path: <linux-fsdevel+bounces-30363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C998A563
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C4B1C209F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E8718FC89;
	Mon, 30 Sep 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WiuWruoj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F32AE8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703243; cv=none; b=YBjef8HuewyJuF8jWk7vNNcnGRkjaXCUU7bjQWbmRMMEM5lEDTq7NGVhY1Yy2NqWuge4fqMnoN4WsjwokzrKVwP0szDpX7XUTaoDAcPH4GlxenM8qeOQR2HdBuNGMDAfKf7zdPbMpYj0VTT6HA01hYZ1aal6J2iMRvjKALUCoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703243; c=relaxed/simple;
	bh=qhMWw9XeNQDk5GLBHnXUjzorhKg7Sh0fb93Zcyq6Sgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOnIQwCUzpUBhvvQ3+lQ+bct2a/H1atQc7jC7eMFTTriYnh/AzJTOWNegs96M9+Tp4FD7eQevAC+2a0YfWmv2fcd/OeoPcE0CXMjtl6fjRbzU+Uvg48VVouMj8ghGuk8BOtOAsMe1VlO4DcEZYciIIgnogI6PeigocWd6AJUXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WiuWruoj; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c3f12d3930so37828116d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703240; x=1728308040; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qVr0Fp5Vgc1fVHht4j5dsU1gJISx0Dj90TBCD3WOMoU=;
        b=WiuWruojF7kjlEAhznJRh7wU9eHP09IC8+qRwmk4BS8rkI3eri99j+cJ4y8tTLy1by
         /WLx2huEZ55xsoZ/m7/1/6lZL/obdiABsDJIV+phxTSoqgluQwnLugD/5IzeQGogRxe4
         a2t+eIz2+UiF1EkUf6kE/oR/8g5xAtIlXUMqnjEArlxxg7XMHjX1mwV2nKmyM2y8xXmb
         njbxid14tBhENXohGKlcgCAQBY0X/eLNHHnYIjgagH8YcBg98+b0SfrAVp7ojpOjzXBS
         Bf3IatiLeUCESS7U920BHQsR5voFxW4a1M/5LHbXtfQUDqtpD0RnsHaeJaYGs3tdOq2W
         yB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703240; x=1728308040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVr0Fp5Vgc1fVHht4j5dsU1gJISx0Dj90TBCD3WOMoU=;
        b=G9autVLTB90cQNdw1279oF5FPjJouIYv0Mg0EEsySoQ5jK7seb9Y8o51HzIWKIW93o
         Jnoj+ftvBUBwfPSUPM3RI4qWy0hbNDMhhRctFiHclIvu/KWfTTjEfWXgVTVcFIccXtuU
         MwqH35GuNQQkbTMN8hcRwQkFp3DXu3bT9hDSIJdH5x6WZ4icvcnST+b9NR4r3R9TCE5g
         il3pzIoszGshO6f+4JY7WtJlLsWfSv17/5Qbj7pEo21QsqDSSWQ0tC8G2EcApuKwyhwe
         5CWzrSaVtL4CR+Jq8nb/pywoIiO9XhHXP82GLjpdgEXfXzssCBHNoLpr9JpQM6GvIUZM
         Rhlw==
X-Gm-Message-State: AOJu0YxJ3UwhO2rAMkk+1K4IaWvicXFvcDjRUFQGKcMZ8uE3gBg//dl4
	pAqk0VtxI9WAor6BSZOsXO7IPwItw9GyS7R69ApR4yJeQ1/1T6aoqWD0JbGQ+R4=
X-Google-Smtp-Source: AGHT+IFSbUnNIEKKgkXY6mrpNSSJc3MgEPv5iUS9GgSQLFH6KkNuD+kfZlFcmNj4IOAh7YBt3vPc2g==
X-Received: by 2002:a05:6214:2e49:b0:6c5:a3c0:bf3d with SMTP id 6a1803df08f44-6cb3b63f589mr169733746d6.41.1727703240253;
        Mon, 30 Sep 2024 06:34:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b614142sm39909986d6.57.2024.09.30.06.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:33:59 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:33:57 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	kernel-team@fb.com
Subject: Re: [PATCH v3 01/10] fuse: convert readahead to use folios
Message-ID: <20240930133357.GA652530@perftesting>
References: <cover.1727469663.git.josef@toxicpanda.com>
 <ffa6fe7ca63c4b2647447ddc9e5c1a67fe0fbb2d.1727469663.git.josef@toxicpanda.com>
 <CAJnrk1bELT0PwOQFzKYryEYQgpJiZ3fyUjERaWH4f+NgM1oirg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bELT0PwOQFzKYryEYQgpJiZ3fyUjERaWH4f+NgM1oirg@mail.gmail.com>

On Fri, Sep 27, 2024 at 03:22:25PM -0700, Joanne Koong wrote:
> On Fri, Sep 27, 2024 at 1:45 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Currently we're using the __readahead_batch() helper which populates our
> > fuse_args_pages->pages array with pages.  Convert this to use the newer
> > folio based pattern which is to call readahead_folio() to get the next
> > folio in the read ahead batch.  I've updated the code to use things like
> > folio_size() and to take into account larger folio sizes, but this is
> > purely to make that eventual work easier to do, we currently will not
> > get large folios so this is more future proofing than actual support.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/fuse/file.c | 43 ++++++++++++++++++++++++++++---------------
> >  1 file changed, 28 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index f33fbce86ae0..132528cde745 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -938,7 +938,6 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
> >                 struct folio *folio = page_folio(ap->pages[i]);
> >
> >                 folio_end_read(folio, !err);
> > -               folio_put(folio);
> >         }
> >         if (ia->ff)
> >                 fuse_file_put(ia->ff, false);
> > @@ -985,18 +984,36 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
> >  static void fuse_readahead(struct readahead_control *rac)
> >  {
> >         struct inode *inode = rac->mapping->host;
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> >         struct fuse_conn *fc = get_fuse_conn(inode);
> > -       unsigned int i, max_pages, nr_pages = 0;
> > +       unsigned int max_pages, nr_pages;
> > +       pgoff_t first = readahead_index(rac);
> > +       pgoff_t last = first + readahead_count(rac) - 1;
> >
> >         if (fuse_is_bad(inode))
> >                 return;
> >
> > +       wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first, last));
> 
> Should this line be moved to after we check the readahead count? eg
> 
> nr_pages = readahead_count(rac);
> if (!nr_pages)
>     return;
> wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first, last));
> 
> Otherwise I think in that case you mentioned where read_pages() calls
> into readahead_folio() after it's consumed the last folio, we end up
> calling this wait_event

The first bit of read_pages covers this for us

static void read_pages(struct readahead_control *rac)
{
        const struct address_space_operations *aops = rac->mapping->a_ops;
        struct folio *folio;
        struct blk_plug plug;

        if (!readahead_count(rac))
                return;

We don't get ->readahead called unless there's pages to read.  Thanks,

Josef

