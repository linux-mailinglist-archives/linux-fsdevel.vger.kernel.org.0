Return-Path: <linux-fsdevel+bounces-5765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF24480FB84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B711F2199F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C804364CEB;
	Tue, 12 Dec 2023 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ywhXwz9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775DCB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 15:44:10 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b8958b32a2so4923062b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 15:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702424650; x=1703029450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdYtwHC24bMaoGMPcByzyqiH2GTRlEinCqoKourJXpo=;
        b=ywhXwz9LPaqf4trv7AdKaJonKC2dyZuavtlzMTLeLtxBLFFd8yBr4oAL1JDGM6z4fV
         eiLi1imcd8L6G8pxQ5Aokt1gL6ylkNRDkCpZukffwKAOu7u6akXjnpBQXcZkGsAA4Qxc
         TgsWS2iB/qvA5z6+H+DZA4K/yUrcM/vYY39UxYtaNhb819Uh+R8gFLkmpebbndOVkYB0
         2hnyd9c4gcqOB0N3H1Xgy0FFi4ThtMdMmLxodQtDreJis85VTAo8aO43D61vO6dyfDY5
         0Vwgs/AbKt8rD840cN5pt7+iPYljkiFmE35ufcaIxbZASKKMMUnBZgdLpzpzOiE00Yxn
         Gr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702424650; x=1703029450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdYtwHC24bMaoGMPcByzyqiH2GTRlEinCqoKourJXpo=;
        b=qnTEesmHSpmN42hZfaFZC6Vz1jNX2QkF5UXaMZgJE75cFMI8hDKUUQ3OYWIgDopNyK
         nlmi3x5ReMz5QVIFtyJf5L9FrUtYlAoq2skIFwbWiEos0IjULAxVi0MDxMgF3J8KEUGt
         P1agHi7K6AeCvKM8eeYqt1z2/VKHb+73AYIh1aKvHZKIb32lP8YbgBWi7ObJ9jcrjE4X
         HSgLrD3flqqNBjEH72mWqawAIc1F2Cwv5irEt79986A1Q8HmOorbV482dWqi6zc1jEPm
         5DorSs8/e+TiVhrT30BgLrHGixOhdZBb3Fnmaw9G+L78l6k/9+v3WL8iM4zP56OGprca
         rh/A==
X-Gm-Message-State: AOJu0Yx7DdI66Gi+mXGjgWogNuR67aWbmy5rcDarbIf87BGjle8NWhMh
	MAFg9fbfrYIgw3d8hiibMV8Dqw==
X-Google-Smtp-Source: AGHT+IGqOsQ0MyIPjJF6Tma2FAdKaCFG9NOwKov3zO8GvDOyUdzFx3C3zcbkHtA5x5WBl9H8UvtIaQ==
X-Received: by 2002:a05:6808:16a6:b0:3b8:b063:505a with SMTP id bb38-20020a05680816a600b003b8b063505amr8265373oib.91.1702424649749;
        Tue, 12 Dec 2023 15:44:09 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id fm15-20020a056a002f8f00b006ce7ca09d9dsm8760170pfb.153.2023.12.12.15.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:44:09 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rDCQ3-007VVU-0A;
	Wed, 13 Dec 2023 10:44:07 +1100
Date: Wed, 13 Dec 2023 10:44:07 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: NeilBrown <neilb@suse.de>, Frank Filz <ffilzlnx@mindspring.com>,
	'Theodore Ts'o' <tytso@mit.edu>,
	'Donald Buczek' <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	'Stefan Krueger' <stefan.krueger@aei.mpg.de>,
	'David Howells' <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx
Message-ID: <ZXjwR/6jfxFbLq9Y@dread.disaster.area>
References: <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>
 <20231212152016.GB142380@mit.edu>
 <0b4c01da2d1e$cf65b930$6e312b90$@mindspring.com>
 <ZXjJyoJQFgma+lXF@dread.disaster.area>
 <170241826315.12910.12856411443761882385@noble.neil.brown.name>
 <ZXjdVvE9W45KOrqe@dread.disaster.area>
 <20231212223927.comwbwcmpvrd7xk4@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212223927.comwbwcmpvrd7xk4@moria.home.lan>

On Tue, Dec 12, 2023 at 05:39:27PM -0500, Kent Overstreet wrote:
> On Wed, Dec 13, 2023 at 09:23:18AM +1100, Dave Chinner wrote:
> > On Wed, Dec 13, 2023 at 08:57:43AM +1100, NeilBrown wrote:
> > > On Wed, 13 Dec 2023, Dave Chinner wrote:
> > > > On Tue, Dec 12, 2023 at 09:15:29AM -0800, Frank Filz wrote:
> > > > > > On Tue, Dec 12, 2023 at 10:10:23AM +0100, Donald Buczek wrote:
> > > > > > > On 12/12/23 06:53, Dave Chinner wrote:
> > > > > > >
> > > > > > > > So can someone please explain to me why we need to try to re-invent
> > > > > > > > a generic filehandle concept in statx when we already have a have
> > > > > > > > working and widely supported user API that provides exactly this
> > > > > > > > functionality?
> > > > > > >
> > > > > > > name_to_handle_at() is fine, but userspace could profit from being
> > > > > > > able to retrieve the filehandle together with the other metadata in a
> > > > > > > single system call.
> > > > > > 
> > > > > > Can you say more?  What, specifically is the application that would want
> > > > > to do
> > > > > > that, and is it really in such a hot path that it would be a user-visible
> > > > > > improveable, let aloine something that can be actually be measured?
> > > > > 
> > > > > A user space NFS server like Ganesha could benefit from getting attributes
> > > > > and file handle in a single system call.
> > > > 
> > > > At the cost of every other application that doesn't need those
> > > > attributes.
> > > 
> > > Why do you think there would be a cost?
> > 
> > It's as much maintenance and testing cost as it is a runtime cost.
> > We have to test and check this functionality works as advertised,
> > and we have to maintain that in working order forever more. That's
> > not free, especially if it is decided that the implementation needs
> > to be hyper-optimised in each individual filesystem because of
> > performance cost reasons.
> > 
> > Indeed, even the runtime "do we need to fetch this information"
> > checks have a measurable cost, especially as statx() is a very hot
> > kernel path. We've been optimising branches out of things like
> > setting up kiocbs because when that path is taken millions of times
> > every second each logic branch that decides if something needs to be
> > done or not has a direct measurable cost. statx() is a hot path that
> > can be called millions of times a second.....
> 
> Like Neal mentioned we won't even be fetching the fh if it wasn't
> explicitly requested - and like I mentioned, we can avoid the
> .encode_fh() call for local filesystems with a bit of work at the VFS
> layer.
> 
> OTOH, when you're running rsync in incremental mode, and detecting
> hardlinks, your point that "statx can be called millions of times per
> second" would apply just as much to the additional name_to_handle_at()
> call - we'd be nearly doubling their overhead for scanning files that
> don't need to be sent.

Hardlinked files are indicated by st_nlink > 1, not by requiring
userspace to store every st_ino/dev it sees and having to compare
the st-ino/dev of every newly stat()d inode against that ino/dev
cache.

We only need ino/dev/filehandles for hardlink path disambiguation.

IOWs, this use case does not need name_to_handle_at() for millions
of inodes - it is just needed on the regular file inodes that have
st_nlink > 1.

Hence even for wrokloads like rsync with hardlink detection, we
don't need filehandles for every inode being stat()d.  And that's
ignoring the fact that, outside of certain niche use cases,
hardlinks are rare.

I'm really struggling to see what filehandles in statx() actually
optimises in any meaningful manner....

> > And then comes the cost of encoding dynamically sized information in
> > struct statx - filehandles are not fixed size - and statx is most
> > definitely not set up or intended for dynamically sized attribute
> > data. This adds more complexity to statx because it wasn't designed
> > or intended to handle dynamically sized attributes. Optional
> > attributes, yes, but not attributes that might vary in size from fs
> > to fs or even inode type to inode type within a fileystem (e.g. dir
> > filehandles can, optionally, encode the parent inode in them).
> 
> Since it looks like expanding statx is not going to be quite as easy as
> hoped, I proposed elsewhere in the thread that we reserve a smaller
> fixed size in statx (32 bytes) and set a flag if it won't fit,
> indicating that userspace needs to fall back to name_to_handle_at().

struct btrfs_fid is 40 bytes in size. Sure, that's not all used for
name_to_handle_at(), but we already have in-kernel filehandles that
can optionally configured to be bigger than 32 bytes...

> Stuffing a _dynamically_ sized attribute into statx would indeed be
> painful - I believe were always talking about a fixed size buffer in
> statx, the discussion's been over how big it needs to be...

The contents of the buffer is still dynamically sized, so there's
still a length attribute that needs to be emitted to userspace with
the buffer.

And then what happens with the next attribute that someone wants
statx() to expose that can be dynamically sized? Are we really
planning to allow the struct statx to be expanded indefinitely
with largely unused static data arrays?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

