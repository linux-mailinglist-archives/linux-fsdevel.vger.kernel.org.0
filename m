Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09C5432A93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhJSABt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJSABs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:01:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4100C061765
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 16:59:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i5so6172915pla.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kCfAcXfSZmpdUMRIm8W78nTUzYpVwemnoTIkzIHJLTw=;
        b=afv5+t1zsEFSFJaVXkuxWHZfTBrZws2SKHe2ubGWMJuIRTWHRqVC8n7wYF5E5OR406
         MF3a06zw6cl/lVR6r8UvxTahXYIEgRmWFRBnO5cFabB4EOJJiGlGp5nE0y3dC0VQNJTe
         1fDujMHy7fGExMaC/CZmyFuH4Ki1n3QcNWZCWNJjlL7YKKBCWljvlvd8TMeWFHYsRDzz
         yNPLFtAU3KY7rtvu0zfX0KkVEvKoWmbjOl1BqqnEMxMi4tJRENMq/GIQ132Ys+gQdrFx
         Whg8UjfVz/RyuPrdO4e5+CuVEfg8rwylPKMmkuE2JYVfaYxmHWV3RBhkI8qym+c0FEoY
         0VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kCfAcXfSZmpdUMRIm8W78nTUzYpVwemnoTIkzIHJLTw=;
        b=wYnEIQ30NuxxdTSC/BDjT624DDvcvcSvKWbPW1b+LELXgF1ZVXFQbFGTBvAJgWvkF9
         TZY/URasDAcJlZMJ3SYikseAT1moVBtN6930jJN0MKvg0lNZeF58g7rVuHqNvbfXXqwF
         tDbfX0ATcJhFKljE4h1w9wp67qEvhDdL41s2qFz6fkg5uV1I7QrBz7gkhOwDwKWhm6PB
         bBKN+OYkzWU7/FcL4JeOUXfkKGHi3LmvyfXQ/0r+bo2j9qA1qcYH/iqIdB8Se2PVZx+j
         ZGq8NpEHSWz5K6G19v4fNobQE1pdoDLthQHg2YyH7tGCj3S4vNFgssQqEB/0qy2voVCz
         zU2A==
X-Gm-Message-State: AOAM5327uF31DzmuLjAyZInS/g6Bd4BsTtRyYDD0hujAQtt/rd04xAfu
        XBWlC+yCIo0YEMbQ5Dfez3USRA==
X-Google-Smtp-Source: ABdhPJxFosX6UkBjViRm7sGWSkIGK6R8YUkeTfu16VF1r/YTy+B4YxrNfxmO/k7TOWbyiqyoaBM6dw==
X-Received: by 2002:a17:903:2003:b0:13f:9c2d:93ac with SMTP id s3-20020a170903200300b0013f9c2d93acmr18830060pla.42.1634601576007;
        Mon, 18 Oct 2021 16:59:36 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id x10sm14601846pfn.172.2021.10.18.16.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:59:35 -0700 (PDT)
Date:   Mon, 18 Oct 2021 16:59:33 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 08/14] btrfs: add BTRFS_IOC_ENCODED_READ
Message-ID: <YW4KZd4gGKVen4p4@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <c8c9bc3a546359bda7420d92d3d61d1023c1cb96.1630514529.git.osandov@fb.com>
 <4a64bf3a-b691-1986-80c8-21ddf9e446a0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a64bf3a-b691-1986-80c8-21ddf9e446a0@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 02:45:46PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:01, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > There are 4 main cases:
> > 
> > 1. Inline extents: we copy the data straight out of the extent buffer.
> > 2. Hole/preallocated extents: we fill in zeroes.
> > 3. Regular, uncompressed extents: we read the sectors we need directly
> >    from disk.
> > 4. Regular, compressed extents: we read the entire compressed extent
> >    from disk and indicate what subset of the decompressed extent is in
> >    the file.
> > 
> > This initial implementation simplifies a few things that can be improved
> > in the future:
> > 
> > - We hold the inode lock during the operation.
> > - Cases 1, 3, and 4 allocate temporary memory to read into before
> >   copying out to userspace.
> > - We don't do read repair, because it turns out that read repair is
> >   currently broken for compressed data.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/ctree.h |   4 +
> >  fs/btrfs/inode.c | 489 +++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/ioctl.c | 111 +++++++++++
> >  3 files changed, 604 insertions(+)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index b95ec5fb68d5..cbd7e07c1c34 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3223,6 +3223,10 @@ int btrfs_writepage_cow_fixup(struct page *page);
> >  void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
> >  					  struct page *page, u64 start,
> >  					  u64 end, bool uptodate);
> > +struct btrfs_ioctl_encoded_io_args;
> > +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
> > +			   struct btrfs_ioctl_encoded_io_args *encoded);
> > +
> >  extern const struct dentry_operations btrfs_dentry_operations;
> >  extern const struct iomap_ops btrfs_dio_iomap_ops;
> >  extern const struct iomap_dio_ops btrfs_dio_ops;
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index a87a34f56234..1940f22179ba 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -10500,6 +10500,495 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
> >  	}
> >  }
> >  
> 
> <snip>
> 
> > +
> > +static blk_status_t btrfs_encoded_read_check_bio(struct btrfs_io_bio *io_bio)
> 
> nit: The gist of this function is to check the csum so how about
> renaming it to btrfs_encoded_read_verify_csum

Good point, will do.

> > +
> > +static void btrfs_encoded_read_endio(struct bio *bio)
> > +{
> > +	struct btrfs_encoded_read_private *priv = bio->bi_private;
> > +	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
> > +	blk_status_t status;
> > +
> > +	status = btrfs_encoded_read_check_bio(io_bio);
> > +	if (status) {
> > +		/*
> > +		 * The memory barrier implied by the atomic_dec_return() here
> > +		 * pairs with the memory barrier implied by the
> > +		 * atomic_dec_return() or io_wait_event() in
> 
> nit: I think atomic_dec_return in read_regular_fill_pages is
> inconsequential, what we want to ensure is that when the caller of
> io_wait_event is woken up by this thread it will observe the
> priv->status, which it will, because the atomic-dec_return in this
> function has paired with the general barrier interpolated by wait_event.
> 
> So for brevity just leave the text to say "by io_wait_event".

Considering that there is a code path in
btrfs_encoded_read_regular_fill_pages() where atomic_dec_return() is
called but io_wait_event() isn't, I think it's important to mention
both. (This path should be fairly rare, since it can only happen if all
of the bios are completed before the submitting thread checks the
pending counter. But, it's a possible code path, and I wouldn't want
someone reading the comment to be confused and think that we're missing
a barrier in that case.)

> > +		 * btrfs_encoded_read_regular_fill_pages() to ensure that this
> > +		 * write is observed before the load of status in
> > +		 * btrfs_encoded_read_regular_fill_pages().
> > +		 */
> > +		WRITE_ONCE(priv->status, status);
> > +	}
> > +	if (!atomic_dec_return(&priv->pending))
> > +		wake_up(&priv->wait);
> > +	btrfs_io_bio_free_csum(io_bio);
> > +	bio_put(bio);
> > +}
> 
> <snip>
> 
> > @@ -4824,6 +4841,94 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
> >  	return ret;
> >  }
> >  
> 
> <snip>
> 
> > +	memset((char *)&args + copy_end_kernel, 0,
> > +	       sizeof(args) - copy_end_kernel);
> 
> nit: This memset can be eliminated ( in source) by marking args = {};
> and just leaving copy from user above.

args = {} results in slightly worse generated code, but that doesn't
really matter here, so I'll change it.

> > +
> > +	ret = import_iovec(READ, args.iov, args.iovcnt, ARRAY_SIZE(iovstack),
> > +			   &iov, &iter);
> > +	if (ret < 0)
> > +		goto out_acct;
> > +
> > +	if (iov_iter_count(&iter) == 0) {
> > +		ret = 0;
> > +		goto out_iov;
> > +	}
> > +	pos = args.offset;
> > +	ret = rw_verify_area(READ, file, &pos, args.len);
> > +	if (ret < 0)
> > +		goto out_iov;
> > +
> > +	init_sync_kiocb(&kiocb, file);
> > +	ret = kiocb_set_rw_flags(&kiocb, 0);
> 
> This call is a noop due to:
> 	if (!flags)
> 		return 0;
> 
> in kiocb_set_rw_flags.

Good catch, I'll remove that call.
