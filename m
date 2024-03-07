Return-Path: <linux-fsdevel+bounces-13955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C9C875B2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 00:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6CF282B3B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BB347784;
	Thu,  7 Mar 2024 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="EwTr/J8I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42EE405CE
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854693; cv=none; b=cKtVPCXyhHN48LiG/tKV9v/vzWa6wamJ+RGFppcx+JYPKzoDDcDqHlm2HZFqipJkC0rj6VMwNFxEW1bLRLN+44SCrVXk2DnQ2DuoeK2IAiAs2lCcSalOLzlw2jWPBzLS9LHgUq0XWVBBzC6f6twD0OjLRIPu2/tb8yQh78xYFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854693; c=relaxed/simple;
	bh=GqfTloEAhfxVd55v4HgyxxgvXhyD+SGESBGeP5D9XHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqWxOaFNCSbEQglBiGbEKpfikiX8Ohmi3W9pOvik/+4GIrrI/09CWuEqVc6sscZJyep8e8AqhEn3eju1C3ezvqjKkY1UgV92RKJxXNW91bbODBzlWtQ3gxDGDYxWiSPKhgHJh5I4SRejK3HScYyDCdvr4b8ni+VBrETfWlYZS7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=EwTr/J8I; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36576b35951so7031585ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 15:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709854690; x=1710459490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9XXK0kRgFcOrIvcCe6dTK7t3KJh97bLnoMcrrF3eO0=;
        b=EwTr/J8Ij0S/wbCFMDAxtLnWcaC5OfHnyTB3JBwzjHtmzr4nEaDOf1LGvZ8UYv9HpF
         IDxPwJIyKk2KzW3Ev8w4GhKqG/WDbrvssXZmtL9mvKe2UwtK4bDESBf0vSVfrAhgT3QT
         lCHgFfNwW+7/VpZOTFvi7UZAjWa174kG7/K2AqNKkdgMgwtDIGrO3oR4lNs1+SG7othV
         4e2GY89JFaMnDe/Nts2c7ESP95AmW9pyvtFN0RsdafmQY6Ac72YaA6AUisXkrttvzeNF
         9q5JDjuapDfuEmDqfAjqFwNcOvwI6rcLBUYGZeOJbjQ9fnHkisEH0GfUOBfJrz+/Dquk
         zrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709854690; x=1710459490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9XXK0kRgFcOrIvcCe6dTK7t3KJh97bLnoMcrrF3eO0=;
        b=MCTX7ib2SMg9HtS1l/wnwejaIS44ug38G9xWzlARGR948pIpK24BwAAotmKdwlVdxo
         /eYG/kI/DwLE6APXHO8E0g6z61ZUE9nEhZiYv19JQoT8g5yiUX0gwL0ezbRQo1pWXKZZ
         ogmyzgDzId+E+4xB2ZhZba2KjBiP/hedo6lKhY8yIT+8wj02VTj+Rl7Tldh83QKhxvH5
         l2L2Pf2r7J+Dy8OwzpiWd9ej7SuvRWFSUim0i0dELcZTzwQhqvhCna/RgeELNyLPN69D
         wT8DDZEdMiy6zjSV7Ml7JBr/vlqp7l5zJszHrOs1ly5pAPzSw9CRetfH0mRg/wBTJ1ce
         MloQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNWCUDV97VyxR7KAN0sK5/bXAlAtueGZSC83zZ9P2lBLn66EWqBPCy/1RpQKxM/PLXak6gdVUTNe0MpH/8Cj9eS9HjCV4cNSkojPfh8Q==
X-Gm-Message-State: AOJu0YwRxxIHY1IuEtyNxhPGfJP8Yq82rB1EPyJkD/Z6nHgW7otfwoMS
	gZUNkO16h9+blHHgm1RicQmh4j4T3KTxnk7ZUyT5l04IJSCNzeS7egqy1ZFd3VU=
X-Google-Smtp-Source: AGHT+IGNL6A5iRHPg1He/b1HFq1d2XvuWbhVkxIUSPU4jFYqmKIGJG1u1f1OWkoddwSS+RpLnbVr6Q==
X-Received: by 2002:a05:6e02:1807:b0:365:69a:86b2 with SMTP id a7-20020a056e02180700b00365069a86b2mr26642640ilv.17.1709854689651;
        Thu, 07 Mar 2024 15:38:09 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id t20-20020a056a0021d400b006e64b9d88d4sm3660159pfj.124.2024.03.07.15.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:38:09 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1riNJO-00GStY-1t;
	Fri, 08 Mar 2024 10:38:06 +1100
Date: Fri, 8 Mar 2024 10:38:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/24] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <ZepP3iAmvQhbbA2t@dread.disaster.area>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-12-aalbersh@redhat.com>
 <20240304233927.GC17145@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304233927.GC17145@sol.localdomain>

On Mon, Mar 04, 2024 at 03:39:27PM -0800, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 08:10:33PM +0100, Andrey Albershteyn wrote:
> > +#ifdef CONFIG_FS_VERITY
> > +struct iomap_fsverity_bio {
> > +	struct work_struct	work;
> > +	struct bio		bio;
> > +};
> 
> Maybe leave a comment above that mentions that bio must be the last field.
> 
> > @@ -471,6 +529,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
> >   * iomap_readahead - Attempt to read pages from a file.
> >   * @rac: Describes the pages to be read.
> >   * @ops: The operations vector for the filesystem.
> > + * @wq: Workqueue for post-I/O processing (only need for fsverity)
> 
> This should not be here.
> 
> > +#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
> > +
> >  static int __init iomap_init(void)
> >  {
> > -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> > -			   offsetof(struct iomap_ioend, io_inline_bio),
> > -			   BIOSET_NEED_BVECS);
> > +	int error;
> > +
> > +	error = bioset_init(&iomap_ioend_bioset, IOMAP_POOL_SIZE,
> > +			    offsetof(struct iomap_ioend, io_inline_bio),
> > +			    BIOSET_NEED_BVECS);
> > +#ifdef CONFIG_FS_VERITY
> > +	if (error)
> > +		return error;
> > +
> > +	error = bioset_init(&iomap_fsverity_bioset, IOMAP_POOL_SIZE,
> > +			    offsetof(struct iomap_fsverity_bio, bio),
> > +			    BIOSET_NEED_BVECS);
> > +	if (error)
> > +		bioset_exit(&iomap_ioend_bioset);
> > +#endif
> > +	return error;
> >  }
> >  fs_initcall(iomap_init);
> 
> This makes all kernels with CONFIG_FS_VERITY enabled start preallocating memory
> for these bios, regardless of whether they end up being used or not.  When
> PAGE_SIZE==4096 it comes out to about 134 KiB of memory total (32 bios at just
> over 4 KiB per bio, most of which is used for the BIO_MAX_VECS bvecs), and it
> scales up with PAGE_SIZE such that with PAGE_SIZE==65536 it's about 2144 KiB.

Honestly: I don't think we care about this.

Indeed, if a system is configured with iomap and does not use XFS,
GFS2 or zonefs, it's not going to be using the iomap_ioend_bioset at
all, either. So by you definition that's just wasted memory, too, on
systems that don't use any of these three filesystems. But we
aren't going to make that one conditional, because the complexity
and overhead of checks that never trigger after the first IO doesn't
actually provide any return for the cost of ongoing maintenance.

Similarly, once XFS has fsverity enabled, it's going to get used all
over the place in the container and VM world. So we are *always*
going to want this bioset to be initialised on these production
systems, so it falls into the same category as the
iomap_ioend_bioset. That is, if you don't want that overhead, turn
the functionality off via CONFIG file options.

> How about allocating the pool when it's known it's actually going to be used,
> similar to what fs/crypto/ does for fscrypt_bounce_page_pool?  For example,
> there could be a flag in struct fsverity_operations that says whether filesystem
> wants the iomap fsverity bioset, and when fs/verity/ sets up the fsverity_info
> for any file for the first time since boot, it could call into fs/iomap/ to
> initialize the iomap fsverity bioset if needed.
> 
> BTW, errors from builtin initcalls such as iomap_init() get ignored.  So the
> error handling logic above does not really work as may have been intended.

That's not an iomap problem - lots of fs_initcall() functions return
errors because they failed things like memory allocation. If this is
actually problem, then fix the core init infrastructure to handle
errors properly, eh?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

