Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964EDA0CD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 23:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfH1Vya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 17:54:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44241 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1Vya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:54:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so559433plr.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2019 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9AFvDPdMFXF3Oi+pi/ljks9u7VZds22rpfzOC3/TilY=;
        b=fBUiQzofqeIX+1GAyoU7Al8WZfc+JCKB4NVcOGNJRp/tSzRJmpVSkBVFY/VDiuMZUJ
         fQ5nW7Jj7SJJ5JAv1zEZzj7016mrwWeWpCjhv+VcOnZBx4BFl+nv0o5rryC+yf8sNLaa
         O8rSwOnwgZC8QAEIfvNaiARRQW/gmJKG3lhOn3Wl3jS2rACx1hbYsk/bilW9a4KNE9LE
         3hkMRD81yKAIF6j7DQn1nG0AHv51lxuu/XZJPQ74AnJit7lC7dKlUfbn4qJNRTSZavWM
         YcG89xKJ0An3nIUXDGN1BRtpcarkuIoH9jWXQTresfZgxcD+eLHLBcVpzpybyL8SeWR2
         2vMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9AFvDPdMFXF3Oi+pi/ljks9u7VZds22rpfzOC3/TilY=;
        b=N/2ij+TEAvty1WF7fGT7CcpF1LGafXZXJbciHZsXMhLnpS3XOEPoi5U+X2lQJKK+er
         siGAuivKJDUhgJ5HI85ldBDg6zwQeYSui3ocU4+EmRk2MkAIvKFeXZulkskBIPLIAIry
         2FcCOVWZnSYXKXaOY+ObmsnmcMkjoep7/SdT+OWRZfpZtt8KcUnQaT/P4O78h2wPadi7
         zzWrQcEjwk9tK+M4sfWhawGuYyM6PfjBXQqoCkz35LRriiN7j/GgS5FQEYO04zfbU0pw
         128SFehvu/ggNThFnfbGdCpGDM4J82CAikiX2GWiHM1PILQ+kVFNikqWsEWQBeY+KDwr
         1BWw==
X-Gm-Message-State: APjAAAURDQDChWQvXDvpQUCHqLZAmUX1oJXgoSqSv9/IYLhR0dDarY7+
        KdN6daHPkAvPBWZsYFZQxzPJ
X-Google-Smtp-Source: APXvYqyOGe7gBgsmaUKeGFfWT+CozOsswSPGy6yvls0lKL8bUazuMad5uXpH3yCHa4sqwm1MoMv4qw==
X-Received: by 2002:a17:902:3064:: with SMTP id u91mr6600966plb.244.1567029268996;
        Wed, 28 Aug 2019 14:54:28 -0700 (PDT)
Received: from athena.bobrowski.net ([120.18.194.154])
        by smtp.gmail.com with ESMTPSA id a128sm353474pfb.185.2019.08.28.14.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:54:28 -0700 (PDT)
Date:   Thu, 29 Aug 2019 07:54:21 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 2/5] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <20190828215421.GA9221@athena.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <774754e9b2afc541df619921f7743d98c5c6a358.1565609891.git.mbobrowski@mbobrowski.org>
 <20190828195914.GF22343@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828195914.GF22343@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 09:59:14PM +0200, Jan Kara wrote:
> On Mon 12-08-19 22:52:53, Matthew Bobrowski wrote:
> > +static int ext4_handle_inode_extension(struct inode *inode, loff_t size,
> > +				       size_t count)
> > +{
> > +	handle_t *handle;
> > +	bool truncate = false;
> > +	ext4_lblk_t written_blk, end_blk;
> > +	int ret = 0, blkbits = inode->i_blkbits;
> > +
> > +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > +	if (IS_ERR(handle)) {
> > +		ret = PTR_ERR(handle);
> > +		goto orphan_del;
> > +	}
> > +
> > +	if (ext4_update_inode_size(inode, size))
> > +		ext4_mark_inode_dirty(handle, inode);
> > +
> > +	/*
> > +	 * We may need truncate allocated but not written blocks
> > +	 * beyond EOF.
> > +	 */
> > +	written_blk = ALIGN(size, 1 << blkbits);
> > +	end_blk = ALIGN(size + count, 1 << blkbits);
> 
> So this seems to imply that 'size' is really offset where IO started but
> ext4_update_inode_size(inode, size) above suggests 'size' is really where
> IO has ended and that's indeed what you pass into
> ext4_handle_inode_extension(). So I'd just make the calling convention for
> ext4_handle_inode_extension() less confusing and pass 'offset' and 'len'
> and fixup the math inside the function...

Agree, that will help with making things more transparent.

Also, one other thing while looking at this patch again. See comment
below.

> > @@ -257,6 +308,13 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  		goto out;
> >  
> >  	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> > +
> > +	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
> > +		err = ext4_handle_inode_extension(inode, iocb->ki_pos,
> > +						  iov_iter_count(from));
> > +		if (err)
> > +			ret = err;
> > +	}

I noticed that within ext4_dax_write_iter() we're not accommodating
for error cases. Subsequently, there's no clean up code that goes with
that. So, for example, in the case where we've added the inode onto
the orphan list as a result of an extension and we bump into any error
i.e. -ENOSPC, we'll be left with inconsistencies. Perhaps it might be
worthwhile to introduce a helper here
i.e. ext4_dax_handle_failed_write(), which would be the path taken to
perform any necessary clean up routines in the case of a failed write?
I think it'd be better to have this rather than polluting
ext4_dax_write_iter(). What do you think?

--M
