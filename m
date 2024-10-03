Return-Path: <linux-fsdevel+bounces-30851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E744298ED1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2E2283548
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0178289;
	Thu,  3 Oct 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tBT6MHGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98314A099
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951766; cv=none; b=VLjbvgL5U0P8QvyoAquCZp5esZWtgfNcz82oTCDg95O3YNsL50CDsuIWWKNlChXZAPH6SbrSsV9s1M58q63AtmGNePPgpdKqbwSNlR3fhTEB2DUd0t2+jKVhWVQPou9Mtr9T/CvKTK48sDoPwlPn9/iFcUsu+NSac2g+14s1V7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951766; c=relaxed/simple;
	bh=8oK4I+JBIU/DL1qfcLk0wLwR/KnTVzyuzZnecZa4deU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smkYD/UVYP2fNif6FsPj39+drfhr3sn3dnvbJuyVB4jhXSSMrTxlztTZp4Nfl/OxzHtobECcsz4OcKd0GAXzrrp1QddReyiCNQxCr7OC5oVbOtSAE14yl1weBpDMXI5d/M8s+u5zwAfu/UqN/SnzLyPq/OfZPlGl//HF+Wa6/YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tBT6MHGK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20bb39d97d1so6105065ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 03:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727951764; x=1728556564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=meBlkFYSu8tQQG8fzuHlW0Llugrqw0c4D3dP4w0sd0k=;
        b=tBT6MHGKDoVN6TKilxvrhHMf7tMu/9GjUI4PWr7im5rMk0zLW4UlNJrW+jSCGXKZts
         rdeprrrtJMFXrOMbKIwFdcTJE/W6ihpZdbq19h3ZAqJNpALTWR1Fim6/8i2JOYD6/x7+
         fgL5KHJFVKRH798UKo9r1KTlkc1ggz0Quw7kD3wKhel+IcdaeamNrsLA675i7hGq32rW
         jbmOAoPavdiyq808JBj4Ft3cx2HwpKtXCb+DVr2GdMa/nOiygJHDcCvjXqXYzUvbY4RX
         uYwaSZv0cwZfWrin/onvdeT5iOS4+xV7IY/VMxtil+UWy1A9XownGQKDfx8yf1PBX8QQ
         1+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727951764; x=1728556564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meBlkFYSu8tQQG8fzuHlW0Llugrqw0c4D3dP4w0sd0k=;
        b=BzGJg6N1tyVAnKSgkH4USgTBYy5XJQNgNv84awNb5QNnrpcDB/zSkrcGagnbvM7coA
         /18K15i7O9R9cbov9M1eAiizEbsjqtj7SpwqPrWxdiI5Q7f3xnaR2OenqVSF8OIXYr5a
         DpPZjp8PHGYlbevikSBwdRFecDOUGopGeIPM6GIEw1+V06mcCD8FE3y3dzWBbO96u790
         UIX0Z0U0oLXjn4jPbSgIrwO3IEHKwvmVg1vX4SPgNIynmF8Oa1sQYNXA0lngQ3I+pVh2
         WXC0SLehF71+nZxsoevVuPMXn5aGtZrlqmpvydW5EzKrJrtedB2TKG++YQjcCJurFN7q
         W47Q==
X-Gm-Message-State: AOJu0Yxv+wLIcyyOu+v9e0G5davUirpPaAnHHlWoQ/2Qak4vNJepNBQn
	nZDu6jcA52fIWURG1pe/LqiRYmBI90vPYlXMFkEm/hP/ErQT3Pf9pufOrhYLqX4=
X-Google-Smtp-Source: AGHT+IHAbmLCjTe9ucPXUjhaOkLLAkmHqYr94XYuHe2VWk7hgIGyvqHOxEgqNzNISkYi8RQMpJxqkg==
X-Received: by 2002:a17:902:f68d:b0:206:8acc:8871 with SMTP id d9443c01a7336-20bc5a13640mr66308755ad.31.1727951763533;
        Thu, 03 Oct 2024 03:36:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca2256sm6720985ad.91.2024.10.03.03.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:36:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1swJBf-00DLiE-2H;
	Thu, 03 Oct 2024 20:35:59 +1000
Date: Thu, 3 Oct 2024 20:35:59 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 2/7] vfs: add inode iteration superblock method
Message-ID: <Zv5zj2k8X3ZasfYB@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-3-david@fromorbit.com>
 <Zv5D3ag3HlYFsCAX@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv5D3ag3HlYFsCAX@infradead.org>

On Thu, Oct 03, 2024 at 12:12:29AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 02, 2024 at 11:33:19AM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Add a new superblock method for iterating all cached inodes in the
> > inode cache.
> 
> The method is added later, this just adds an abstraction.

Ah, I forgot to remove that from the commit message when I split the
patch up....

> > +/**
> > + * super_iter_inodes - iterate all the cached inodes on a superblock
> > + * @sb: superblock to iterate
> > + * @iter_fn: callback to run on every inode found.
> > + *
> > + * This function iterates all cached inodes on a superblock that are not in
> > + * the process of being initialised or torn down. It will run @iter_fn() with
> > + * a valid, referenced inode, so it is safe for the caller to do anything
> > + * it wants with the inode except drop the reference the iterator holds.
> > + *
> > + */
> 
> Spurious empty comment line above.
> 
> > +void super_iter_inodes_unsafe(struct super_block *sb, ino_iter_fn iter_fn,
> > +		void *private_data)
> > +{
> > +	struct inode *inode;
> > +	int ret;
> > +
> > +	rcu_read_lock();
> > +	spin_lock(&sb->s_inode_list_lock);
> > +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> > +		ret = iter_fn(inode, private_data);
> > +		if (ret == INO_ITER_ABORT)
> > +			break;
> > +	}
> 
> Looking at the entire series, splitting the helpers for the unsafe
> vs safe iteration feels a bit of an odd API design given that the
> INO_ITER_REFERENCED can be passed to super_iter_inodes, but is an
> internal flag pass here to the file system method.

The INO_ITER_REFERENCED flag is a hack to support the whacky
fsnotify and landlock iterators that are run after evict_inodes()
(which you already noticed...).  i.e.  there should not be any
unreferenced inodes at this point, so if any are found they should
be skipped.

I think it might be better to remove that flag and replace the
iterator implementation with some kind of SB flag and
WARN_ON_ONCE that fires if a referenced inode is found. With that,
the flags field for super_iter_inodes() can go away...

> Not sure what
> the best way to do it, but maybe just make super_iter_inodes
> a wrapper that calls into the method if available, or
> a generic_iter_inodes_unsafe if the unsafe flag is set, else
> a plain generic_iter_inodes?

Perhaps. I'll look into it.

> > +/* Inode iteration callback return values */
> > +#define INO_ITER_DONE		0
> > +#define INO_ITER_ABORT		1
> > +
> > +/* Inode iteration control flags */
> > +#define INO_ITER_REFERENCED	(1U << 0)
> > +#define INO_ITER_UNSAFE		(1U << 1)
> 
> Please adjust the naming a bit to make clear these are different
> namespaces, e.g. INO_ITER_RET_ and INO_ITER_F_.

Will do.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

