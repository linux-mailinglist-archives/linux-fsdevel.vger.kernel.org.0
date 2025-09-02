Return-Path: <linux-fsdevel+bounces-59924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ACCB3F1FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 03:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6F52041E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B79189BB6;
	Tue,  2 Sep 2025 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Jdd1m+i3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EE86329
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777740; cv=none; b=H+AmAUYAbnV7Kd5qZ+Df4mt+WvK1ANLUHeQCCde6YH1UIjy5EdiLK8ZAJWQdIXOo50gG0+/Njs/7Y9l+XlrFUDpTnZFxPEE5m5PohvCWe7xdOPVtzVqEojWLIvP1BYpjULLxQpewFW+y4AQF+s88qhgyJXSxe6tf/u+iSnpsVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777740; c=relaxed/simple;
	bh=fM0LA+38V0D9uGn8qwPG53lhoSH+O36MhGoyFXw4PT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBAqeBhAIZfaQWcgGF1zQGFg7Qrwe840BJVPFAQmGo/+Ku6iFMDwczf4KM+3JyfsWvIFkN1kNHBPLMZ9CuY6SXMfbe168rnPZvXWxLLoAvJ93Cxq47OFgFmuTc+pbkRqGzq8oFxSXjsxTMA6NW5yFUhcgy/Pk1fZfkpASoXHq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Jdd1m+i3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so3804189a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756777738; x=1757382538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apfm/OfGwv9qTJMWrzhjdBDxXzh4Jp/nVSzYj2F3U2g=;
        b=Jdd1m+i3nkSO4tROyugctt1iESKQI/E+4dhwMCWEqcs9al/pYvMukU97elcSSWlOUF
         Q4JrxTFgND4/hWNJnECIvYSJXay/3AVndrGkN7PhYoCSy9zeYh3zIfqWw+AITz3j5p3f
         /zCNvUl8h7JtQr2Vot2WHTPkAqZ3y4gqeHvjNcCRxjb9Toutp56z8J5QbJDthDxiOxtt
         BmNDRU1HXJM4rm6iYKfGACF3CcP+LgvNo3n1qDEI+20zhtrkoWbDIhUnjEZa3U3a2sf8
         Lax06XPLS2hPk2kRra0YsDjGYhpwmWyl5uzYe7z0phI8eBtWmzNSbEHkNhnXUfHGI6bk
         iftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756777738; x=1757382538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apfm/OfGwv9qTJMWrzhjdBDxXzh4Jp/nVSzYj2F3U2g=;
        b=A6+sIFbmEFTtrzYH22vOCqUVDMI6J8GdLAd/nYWCxj+FDCLrJjEUbHM8L4PFL+ttnp
         E+N+aN+csAhd65VCt1DLm6hyYlHyQcPAauC3fdEoGL3fjTLv5tje2FXAijHkX3QfhII6
         9hwXTlhfGxzlejlvs/99nba5fd0uA+bDYwU9PzZvXIcMeQXdm2TCmS1yHPteuk3/VOU+
         pb5PPqgF8hCCO4YJCEbXV9FhJiXuq1iOdh6kQ7J0tq68hPgKAlH037zjOXlrlPTns//1
         QT4RLHOcvDf+jKgL4XX9JfxJFs+vEV8Yx6NON4kVa1jocCaZb2va9ytJ1kphV5vnW2wc
         vgsg==
X-Forwarded-Encrypted: i=1; AJvYcCVtQh8Y5qIZt9oT3Q/lZUzR/m8KQpTrJYLypO/NoGurIYsRPPNRT+Ttiuig+4dc1IbxZpgMBNsiY+AuS7W9@vger.kernel.org
X-Gm-Message-State: AOJu0YwVvMn9w4uixORQwWTGyyJmMnIST9Our8jy27heImGHzdgn7KjP
	e40rPR/8Rw1Lw/5+dSZNF0nmQrsif1dptwD+xEYR9iWXD0tuAsbjXN4RCjqdtja7004ZpO2MRV7
	3fEJJ
X-Gm-Gg: ASbGncsBnTMFZ//rno+MQuW8PxPYAmOWGx7IzsMHJOqQQ8jDMNZSmxGG9P2xOHhZJ+i
	56bbDIujD3/MaQCZMQKkaetk3XHijpAXFAhCWW9s9gMCXVKLgHjRmtBjw2eq0GykY9Ad4BzRaai
	cUsJlYjY2orfKap+JYRW7XNg6jkJv1A5FU2LWc7LdG/Ssnv+gHl8gMBjuJvEvBY5INIUipnOhtX
	oq1mKFdjSoJ3eSA+cALBNDKW63BB+YFcD3Ey/DEDBp33OSHnhWbkbE/7OKpXlGeF/+ut3n3QEB3
	2PGlIyRrRdJHM6cRQaXLB9tO/MXjy9UChXaaOlx+ilUT65ESYhzMz6x7CvSuRmkzQRBDbEKLmaM
	mdpH2eU3HwW7igW49Z7qOiMDVSua9QOSlr78ITwHC3xvxwdIDog225klzm3aElB7kr17pj+C/yw
	==
X-Google-Smtp-Source: AGHT+IGNn5O91H+3levTXwHqvFgFTqr0EcsMNpPYp1sP6LhsBoImzAo9755b7M/8xKurhteCM6ov5g==
X-Received: by 2002:a17:90b:5190:b0:324:ece9:6afb with SMTP id 98e67ed59e1d1-3281541225emr12741218a91.3.1756777737567;
        Mon, 01 Sep 2025 18:48:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3274188757bsm9047204a91.1.2025.09.01.18.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 18:48:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1utG8j-0000000E6wv-0uNw;
	Tue, 02 Sep 2025 11:48:53 +1000
Date: Tue, 2 Sep 2025 11:48:53 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 17/54] fs: remove the inode from the LRU list on
 unlink/rmdir
Message-ID: <aLZNBc93sj1uf3l6@dread.disaster.area>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
 <20250827-bratkartoffeln-weltschmerz-fc60227f43e7@brauner>
 <aK-AQ6Xzkmz7zQ6X@dread.disaster.area>
 <20250828114613.GC2848932@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828114613.GC2848932@perftesting>

On Thu, Aug 28, 2025 at 07:46:13AM -0400, Josef Bacik wrote:
> On Thu, Aug 28, 2025 at 08:01:39AM +1000, Dave Chinner wrote:
> > On Wed, Aug 27, 2025 at 02:32:49PM +0200, Christian Brauner wrote:
> > > On Tue, Aug 26, 2025 at 11:39:17AM -0400, Josef Bacik wrote:
> > > > We can end up with an inode on the LRU list or the cached list, then at
> > > > some point in the future go to unlink that inode and then still have an
> > > > elevated i_count reference for that inode because it is on one of these
> > > > lists.
> > > > 
> > > > The more common case is the cached list. We open a file, write to it,
> > > > truncate some of it which triggers the inode_add_lru code in the
> > > > pagecache, adding it to the cached LRU.  Then we unlink this inode, and
> > > > it exists until writeback or reclaim kicks in and removes the inode.
> > > > 
> > > > To handle this case, delete the inode from the LRU list when it is
> > > > unlinked, so we have the best case scenario for immediately freeing the
> > > > inode.
> > > > 
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > ---
> > > 
> > > I'm not too fond of this particular change I think it's really misplaced
> > > and the correct place is indeed drop_nlink() and clear_nlink().
> > 
> > I don't really like putting it in drop_nlink because that then puts
> > the inode LRU in the middle of filesystem transactions when lots of
> > different filesystem locks are held.
> > 
> > IF the LRU operations are in the VFS, then we know exactly what
> > locks are held when it is performed (current behaviour). However,
> > when done from the filesystem transaction context running
> > drop_nlink, we'll have different sets of locks and/or execution
> > contexts held for each different fs type.
> > 
> > > I'm pretty sure that the number of callers that hold i_lock around
> > > drop_nlink() and clear_nlink() is relatively small.
> > 
> > I think the calling context problem is wider than the obvious issue
> > with i_lock....
> 
> This is an internal LRU, so yes potentially we could have locking issues, but
> right now all LRU operations are nested inside of the i_lock, and this is purely
> about object lifetime. I'm not concerned about this being in the bowls of any
> filesystem because it's purely list manipulation.

Yet it now puts the LRU inside freeze contexts, held nested
inode->i_rwsem contexts, etc. Instead of it being largely outside of
all VFS, filesystem and inode locking, it's now deeply embedded in a
complex lock chain.  That may be fine, but there is a non-zero risk
that we overlooked something and it's deadlocks ahoy....

> And if it makes you feel better, the next patchset queued up for after the next
> merge window is deleting the LRU, so you won't have to worry about it for long
> :).  Thanks,

Sure, but the risk is that we end up with a release that has
unfixable deadlocks in it, and so is largely unsafe for anyone to
use in production.... :/

I get it that this is already a long patch series, but changing lock
orders like this "just for a short time" isn't something that fills
me with joy. Weird temporary code behaviours like this also makes
for an awful backport experience for anyone trying to maintain a LTS
kernel....

I suspect it would be simpler overall to add the reference counted
cached object list to cover the writeback/mm requirement for the
LRU, then immediately remove the LRU instead of adding reference
counts for the LRU and sprinkling new LRU removal points around to
make the reference counting work correctly in all conditions.
Especially as you plan to remove the LRU pretty much straight
away...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

