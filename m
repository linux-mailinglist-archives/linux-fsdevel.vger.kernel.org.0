Return-Path: <linux-fsdevel+bounces-31408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C0C995C46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 02:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4FA284806
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 00:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34961566A;
	Wed,  9 Oct 2024 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iA2/dyuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DC748A
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728433277; cv=none; b=PmFzUjcTdal4dGutpb9rCFhsDx9Z8lwsIZvHilw7GRC5/ooQKZAVkqZJuBezYl8MOeGKqouHGOIT9teZtbUJZkCVunbEFPF5OYQnFuHC1EcOzMgcN7bsLnTUt9TZyC7A+QG1XPQh3DV/nPMPbRETwlgWpSjqyS3wyGc99KObqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728433277; c=relaxed/simple;
	bh=QxNxZYTvr88oZBW8tXV32j7iOvCttb9aax9zzHHT9bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9PQ23o2zuqfVnQ3BdFlx5MuhXwBGLRMrbINAH4IL+Js8v+dSCCuMaMRl+Eb7nXYV4/oQskrHoUKL+Ca+eNB5c3ZYXSl8tZLnOCJPq1kgBT3nxGhfzActkD21HO9yyehyJNAgHQjDRDhv9DX7Ngb6SkAJ9GoAStQHO5aG2TtiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=iA2/dyuq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso4260978a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 17:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728433275; x=1729038075; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EJPtnGLGvHHQGnAYTKd4lp510zIDOVQ9LBt2hd+4AdY=;
        b=iA2/dyuqdrPpEQL3osmkh356D9Ui7DSwvErf834km0KsV1nhP0BSnFWs7VzzZU/mdj
         +7tEGnasOihBP96DPTU1zU6LYzxXyLdwT6N/BK6cPyF6/PPHeB/w+s7kKxhPgIu0PYj1
         j8ObHrOkhEutrVq78PKtG+Omskl2CdVQDpoIO/bo4M31ngZsbOJiJvRJuQn2OIq2JI9p
         bPrgacM5JlPAp4mj7YOX1le5VCMb4lxsPVhe5g+FMIwUBfxJUDzUyxP1ET8aLddcdq4z
         Q9ekRo1xDTekTsjNw6/x2x0D8c83P16XS7uWrNqZ+nqPGHSgiIiEphjxBrNQQk4Zc0lV
         FlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728433275; x=1729038075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJPtnGLGvHHQGnAYTKd4lp510zIDOVQ9LBt2hd+4AdY=;
        b=sbZhi/lVebX6WTR4XQxNTzJJ3sUtx89fK8QTtN6i3rmYejcIT8NgHeUlhaAv7nPnV4
         U70q68REPjzVpFV2GEGqgy7ANd3O73zjDpXm8V/JFrQ78eSTzI5FVDTpLsJBN6otc9L0
         zqoZZmrGb3PjaZlXD19juZnuqKOdxVOHJXCxcJ9sQNqWwvjm3utyL2jvI3FLpbLTPmMw
         ifrDxS/ocQf4geCzjHo5U7f/MYLZe2tCht9MXq6LhfP6fSc8Eg4iPlJmKebyAM+dlZz9
         U5VVmjMMv33bNXP9GXyxXHm57/a2opBr/NAuZYqIapIfR8aKNdJNFtvH5EQgUnPBaOpt
         qpxg==
X-Forwarded-Encrypted: i=1; AJvYcCVU9I14fHA7TGjXt7uHNvtqR91M0oGKBdJyms2SbfNZaLCbM4LqcFE+n3PpRibaQcgNaqk1Kt7l62rdJpNf@vger.kernel.org
X-Gm-Message-State: AOJu0YzjBHB83XfdpuBDi3CBPSLdoocVW22hf/41UEFXdzfLVqqAkEnF
	qAImSMQoN2JR2oJcaPy2V1LyJVEDPnK5gdKLq8AAHsMqzjvKE88bnaga+nIXTHc=
X-Google-Smtp-Source: AGHT+IHvr5o7m8dqYTgImRHjogsPdDBCxEnQw5TDLXHAqwX0YLpeTdEi1YjY4Zrk6gKuHELbwTvODw==
X-Received: by 2002:a05:6a20:6f8c:b0:1cf:573a:bb58 with SMTP id adf61e73a8af0-1d8a3c4b85dmr1155691637.40.1728433275128;
        Tue, 08 Oct 2024 17:21:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6821c32sm7447947a12.33.2024.10.08.17.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:21:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1syKRy-00FoLs-0N;
	Wed, 09 Oct 2024 11:21:10 +1100
Date: Wed, 9 Oct 2024 11:21:10 +1100
From: Dave Chinner <david@fromorbit.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <ZwXMdqxz5PWNjW3C@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
 <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
 <20241008.Pohc0dixeiZ8@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008.Pohc0dixeiZ8@digikod.net>

On Tue, Oct 08, 2024 at 02:59:07PM +0200, Mickaël Salaün wrote:
> On Mon, Oct 07, 2024 at 05:28:57PM -0700, Linus Torvalds wrote:
> > On Mon, 7 Oct 2024 at 16:33, Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > There may be other inode references being held that make
> > > the inode live longer than the dentry cache. When should the
> > > fsnotify marks be removed from the inode in that case? Do they need
> > > to remain until, e.g, writeback completes?
> > 
> > Note that my idea is to just remove the fsnotify marks when the dentry
> > discards the inode.
> > 
> > That means that yes, the inode may still have a lifetime after the
> > dentry (because of other references, _or_ just because I_DONTCACHE
> > isn't set and we keep caching the inode).
> > 
> > BUT - fsnotify won't care. There won't be any fsnotify marks on that
> > inode any more, and without a dentry that points to it, there's no way
> > to add such marks.
> > 
> > (A new dentry may be re-attached to such an inode, and then fsnotify
> > could re-add new marks, but that doesn't change anything - the next
> > time the dentry is detached, the marks would go away again).
> > 
> > And yes, this changes the timing on when fsnotify events happen, but
> > what I'm actually hoping for is that Jan will agree that it doesn't
> > actually matter semantically.
> > 
> > > > Then at umount time, the dentry shrinking will deal with all live
> > > > dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> > > > just the root dentry inodes?
> > >
> > > I don't think even that is necessary, because
> > > shrink_dcache_for_umount() drops the sb->s_root dentry after
> > > trimming the dentry tree. Hence the dcache drop would cleanup all
> > > inode references, roots included.
> > 
> > Ahh - even better.
> > 
> > I didn't actually look very closely at the actual umount path, I was
> > looking just at the fsnotify_inoderemove() place in
> > dentry_unlink_inode() and went "couldn't we do _this_ instead?"
> > 
> > > > Wouldn't that make things much cleaner, and remove at least *one* odd
> > > > use of the nasty s_inodes list?
> > >
> > > Yes, it would, but someone who knows exactly when the fsnotify
> > > marks can be removed needs to chime in here...
> > 
> > Yup. Honza?
> > 
> > (Aside: I don't actually know if you prefer Jan or Honza, so I use
> > both randomly and interchangeably?)
> > 
> > > > I have this feeling that maybe we can just remove the other users too
> > > > using similar models. I think the LSM layer use (in landlock) is bogus
> > > > for exactly the same reason - there's really no reason to keep things
> > > > around for a random cached inode without a dentry.
> > >
> > > Perhaps, but I'm not sure what the landlock code is actually trying
> > > to do.
> 
> In Landlock, inodes (see landlock_object) may be referenced by several
> rulesets, either tied to a task's cred or a ruleset's file descriptor.
> A ruleset may outlive its referenced inodes, and this should not block
> related umounts.  security_sb_delete() is used to gracefully release
> such references.

Ah, there's the problem. The ruleset is persistent, not the inode.
Like fsnotify, the life cycle and reference counting is upside down.
The inode should cache the ruleset rather than the ruleset pinning
the inode.

See my reply to Jan about fsnotify.

> > Yeah, I wouldn't be surprised if it's just confused - it's very odd.
> > 
> > But I'd be perfectly happy just removing one use at a time - even if
> > we keep the s_inodes list around because of other users, it would
> > still be "one less thing".
> > 
> > > Hence, to me, the lifecycle and reference counting of inode related
> > > objects in landlock doesn't seem quite right, and the use of the
> > > security_sb_delete() callout appears to be papering over an internal
> > > lifecycle issue.
> > >
> > > I'd love to get rid of it altogether.
> 
> I'm not sure to fully understand the implications for now, but it would
> definitely be good to simplify this lifetime management.  The only
> requirement for Landlock is that inodes references should live as long
> as the related inodes are accessible by user space or already in use.
> The sooner these references are removed from related ruleset, the
> better.

I'm missing something.  Inodes are accessible to users even when
they are not in cache - we just read them from disk and instantiate
a new VFS inode.

So how do you attach the correct ruleset to a newly instantiated
inode?

i.e. If you can find the ruleset for any given inode that is brought
into cache (e.g. opening an existing, uncached file), then why do
you need to take inode references so they are never evicted?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

