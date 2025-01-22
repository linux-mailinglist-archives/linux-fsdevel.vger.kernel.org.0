Return-Path: <linux-fsdevel+bounces-39866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48895A19A1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 22:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44143A511E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 21:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45B1C57B2;
	Wed, 22 Jan 2025 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ShgT4HDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2D1C5799
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737579905; cv=none; b=geCTzaFF5z8QNizscW4+pzzg+Q2EoVPA3kF9ze3ztJeBi0ZzK15hJ4vWphP6J/C1c8a/QcaIkpZwl2jUcF1T49a/jwFImsNqXKgY57UjKBqCZNpI54HJVN7yYo6iydCSBmnQIWw8ZbFMeMmANC2UHyWcixyMYlYoiWNNBmp4Dmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737579905; c=relaxed/simple;
	bh=xQR17u+RLcv4XYbCHk63ZUqq8Mqsr/w7JY42xBAQJWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0ivfn+oIpgo8YoxSu/hegM0YLNH/DMs0BO1DecSC0iBd2rv2dLNldzgBFh2luQ9Z36AZbMo4cq/uboM023CCp4yo3fGjGG+s7Rnd9i3Zgaw7vp0I3w641Fmudv+b0CZpONyUOypHm58VeI6sUJD5IQTUXal98eE4JKTsQgKNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ShgT4HDa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166022c5caso1987325ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 13:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737579903; x=1738184703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRBb4H2FScYFfl0dDaXQzkpGrgD1csYH4IruAGlH+SU=;
        b=ShgT4HDaVp1ZqU6bnlglRHWjOA1PA7sxvm7ndfgEgYYF7dj5cozXQBVNCG/I0dsxjd
         DdaaAAWms70NB/yJKFoLH7uVHfY0HL/yRXq0D3IROOXkHEhSwlI3nG5XcVOCpqZbwAjx
         soF2KcHF4sI+3tdCNg7s0Jl6F+1Rg3MEQUcGWgOYm5dHdOb1VcRPfVTTty6vy5IpYEqj
         vUz1JqtD/5JyMzrwKMKNa1sy7iH3MJsulKJAe1SvgJ3kaPApxbCL8y92Snq7hN7n4CeZ
         tgZBUao5Klcorh7JvnD/f62ImjaEcuvfFH+y/ACQ/JvF8tiiDd5S6kvr8VW4X9Eq7Ey2
         LSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737579903; x=1738184703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRBb4H2FScYFfl0dDaXQzkpGrgD1csYH4IruAGlH+SU=;
        b=m4/OhwN7kgqdQVyelQ/CXrMTOdJzyY48XhABrZ6tUOky3qPJEj14tUuQQwrpufg2bc
         E/MlvUBlomcxFJ/RUhF9r65InylXtPQkYcExF+v/j8pcY2Un2eYcutRl9ceiFSPrxnPb
         Eo7kCAWx1MLdEpJ45gR6Zwrtrw/csssjxQgdNMZ7avwYHHyrQ2iCkzzb8JdLxN0/jGOw
         UKBXCB8TN1d0ThnSu2WO9ldFdoq++O3vqivn+8P4ycHxssEPWcltWk5QjYOzDauBBNDL
         5cdVkSOGVSt6uWpqBrjJUtL8hcu0aRkAz1tojGT1RAEr8Dr4kMr4M/vjzJgPVCi+LUMW
         1sdA==
X-Forwarded-Encrypted: i=1; AJvYcCVdMjoFY9GdE79CoIS6BymEeF2aGo4TXmvihABVSxcnZPtgziAK4bL1To6zTjFlc/GNPHeeNLZUCc5CT+yL@vger.kernel.org
X-Gm-Message-State: AOJu0YxXOJABCYBeuWhAgRlXJ2xaL2xuYMUQjNXYOwHA1ivnJ16+L3OS
	7INavoYi/AAODxviM+l6kCKJDOnqLFLBh/Vf6b6cZKNKGEumYufLCZkWnVp/FQ4=
X-Gm-Gg: ASbGncvgmBkbPMqn9LEtk6efNI7Xf8gSB4bPmdYtqXHaG2YNh4aYyNbiiqgRwuUyZzN
	rQRU7IcIGxqP5oQdD+2iEaQhvMIHqPOoV/WHmq2KhE0byESBRKY1+3NjgQcK/tmnQIi+DGpRg3s
	B8wDML+5qnJQyLgVWDgXBlXd0wbhrAaBK1maa35S+CS8y7OKa2pkjBJLUfWpSYmJsU6nfR0V95L
	po7YskYzjFPo8lWPFPv0GWR8gHOBJq8z+5hQSYDpclunDRCzN1LV7WvuQSzP2SjpQH2+jYkF/Kz
	QYFspEUr/+bI3zhlXCbyOxz2xrWDpoy0JAs=
X-Google-Smtp-Source: AGHT+IGXfDepXzB77zT9gP8X14gWDdI5w14fK6MQ5LQmuxGs2zrbBtlcfukIQ57gvelzknJRD3Bqzg==
X-Received: by 2002:a17:902:cf01:b0:215:94e0:17 with SMTP id d9443c01a7336-21c35530228mr354883365ad.23.1737579903475;
        Wed, 22 Jan 2025 13:05:03 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb8d06sm99887635ad.86.2025.01.22.13.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 13:05:02 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tahuG-00000009EVM-0rAs;
	Thu, 23 Jan 2025 08:05:00 +1100
Date: Thu, 23 Jan 2025 08:05:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <Z5FdfFZWwlKGaVUD@dread.disaster.area>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <20241212013433.GC6678@frogsfrogsfrogs>
 <Z4Xq6WuQpVOU7BmS@dread.disaster.area>
 <20250114235726.GA3566461@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114235726.GA3566461@frogsfrogsfrogs>

On Tue, Jan 14, 2025 at 03:57:26PM -0800, Darrick J. Wong wrote:
> On Tue, Jan 14, 2025 at 03:41:13PM +1100, Dave Chinner wrote:
> > On Wed, Dec 11, 2024 at 05:34:33PM -0800, Darrick J. Wong wrote:
> > > On Fri, Dec 06, 2024 at 08:15:05AM +1100, Dave Chinner wrote:
> > > > On Thu, Dec 05, 2024 at 10:52:50AM +0000, John Garry wrote:
> Tricky questions: How do we avoid collisions between overlapping writes?
> I guess we find a free file range at the top of the file that is long
> enough to stage the write, and put it there?  And purge it later?

Use xfs_bmap_last_offset() to find the last used block in the file,
locate the block we are operating on beyond that. If done under the
ILOCK_EXCL, then this can't race against other attempts to create
a post-EOF extent for an atomic write swap, and it's safe against
other atomic writes in progress.

i.e. we don't really need anything special to create a temporary
post-EOF extent.

> Also, does this imply that the maximum file size is less than the usual
> 8EB?

Maybe. Depends on implementation details, I think.

I think The BMBT on-disk record format can handle offsets beyond
8EiB, so the question remains how we stage the data for the IO into
that extent before we swap it over. The mapping tree index is
actually unsigned, we are limited to 8EiB by loff_t being signed,
not by XFS or the mapping tree being unable to index beyond 8EiB
safely...

> (There's also the question about how to do this with buffered writes,
> but I guess we could skip that for now.)

yup, that's kinda what I meant by "implementation details"...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

