Return-Path: <linux-fsdevel+bounces-5756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8480F9FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92302821FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726D64CE1;
	Tue, 12 Dec 2023 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Yb/lXpSK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD4A100
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 14:10:36 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so5525336b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 14:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702419036; x=1703023836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jksHTXWP7vnkrZVnqffRJvyq0I4mi3oOgIw7MJGRo1Y=;
        b=Yb/lXpSKzi1d/xLKfWzW9dbQPO/LiJrButjJ1TufIRigmI6a+5qjjR7QcTuzs3rmFR
         iFTo3A+Eg8MW13R9cPMj4Y0jrW535atvufwbVPK56PBahyxd+UYbklocXsw16mLl32OD
         Ad7uwtg0ucoK4xgm6NXY4TMfPcI6u0ku7Kqi8Hlm89w755PsP5I1hN+aGHKsnqpZOovY
         w9w3WHxXHf+WgoxjdIxv+8gD8gaKEpyPHhxFagkBvHCbxAATOlE1w6Q6yO9KlRQ/Agmd
         N19npn4rvEIz5SnxVlB0EECltWEOdTpryrxt6yEyv4aZV5BVem+/SZ4r7l3vRHDo5BfC
         YKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419036; x=1703023836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jksHTXWP7vnkrZVnqffRJvyq0I4mi3oOgIw7MJGRo1Y=;
        b=goiyUpSJQ2K7EaqzDFLj1+0gdA8gLYZYTwjf+sKwufGG+jliGGstm+U9j+0K020ycJ
         byqZnWdd4m8JDGN0Ni3kgkpNLgGUlBMYXfR9k1+rE8jOChYJH2OrVT8Mg/vvoPTmaiU/
         mtc++VDlzjdqBAoniferFaCtBstIWTHP1IOmi3uxddXwhD4vJWWVNgIXh3oQRQBznwtA
         UYAWpjG1N9Y43Nmozy0PPVhCqfOkXiYNozf/MSmtkO8/0jtLSjbeMX2ErjAc6LdwGBJI
         mxPEhhmeF4A8NGGm5CI6m6x9gEetxQyX2O7q7ypAOqjiB92qVxQUxOGXXmhhSSk+oS+4
         igIw==
X-Gm-Message-State: AOJu0Yzc2QzOpOk3wPbhsqntiA5TcuMKFWW+FedBdSFwX7+sfkgLBbjS
	tD7kjYiZwv23ZpBF59HCYUD0xG3fR+33nH422/0=
X-Google-Smtp-Source: AGHT+IGIiJGz/Z6IxlGvHOxKa2MtuY7yH6Y9SMQClH6bVhN2Ta/PMJF1tvhERee2/lpC8omiHzqcwA==
X-Received: by 2002:aa7:88cf:0:b0:6ce:7a8f:af7c with SMTP id k15-20020aa788cf000000b006ce7a8faf7cmr7924621pff.12.1702419036107;
        Tue, 12 Dec 2023 14:10:36 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b006ce57f2a254sm8574465pfc.209.2023.12.12.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:10:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rDAxU-007TkB-20;
	Wed, 13 Dec 2023 09:10:32 +1100
Date: Wed, 13 Dec 2023 09:10:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: NeilBrown <neilb@suse.de>, Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <ZXjaWIFKvBRH7Q4c@dread.disaster.area>
References: <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <20231212152153.tasaxsrljq2zzbxe@moria.home.lan>
 <ZXjHEPn3DfgQNoms@dread.disaster.area>
 <20231212212306.tpaw7nfubbuogglw@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212212306.tpaw7nfubbuogglw@moria.home.lan>

On Tue, Dec 12, 2023 at 04:23:06PM -0500, Kent Overstreet wrote:
> On Wed, Dec 13, 2023 at 07:48:16AM +1100, Dave Chinner wrote:
> > On Tue, Dec 12, 2023 at 10:21:53AM -0500, Kent Overstreet wrote:
> > > On Tue, Dec 12, 2023 at 04:53:28PM +1100, Dave Chinner wrote:
> > > > Doesn't anyone else see or hear the elephant trumpeting loudly in
> > > > the middle of the room?
> > > > 
> > > > I mean, we already have name_to_handle_at() for userspace to get a
> > > > unique, opaque, filesystem defined file handle for any given file.
> > > > It's the same filehandle that filesystems hand to the nfsd so nfs
> > > > clients can uniquely identify the file they are asking the nfsd to
> > > > operate on.
> > > > 
> > > > The contents of these filehandles is entirely defined by the file
> > > > system and completely opaque to the user. The only thing that
> > > > parses the internal contents of the handle is the filesystem itself.
> > > > Therefore, as long as the fs encodes the information it needs into the
> > > > handle to determine what subvol/snapshot the inode belongs to when
> > > > the handle is passed back to it (e.g. from open_by_handle_at()) then
> > > > nothing else needs to care how it is encoded.
> > > > 
> > > > So can someone please explain to me why we need to try to re-invent
> > > > a generic filehandle concept in statx when we already have a
> > > > have working and widely supported user API that provides exactly
> > > > this functionality?
> > > 
> > > Definitely should be part of the discussion :)
> > > 
> > > But I think it _does_ need to be in statx; because:
> > >  - we've determined that 64 bit ino_t just isn't a future proof
> > >    interface, we're having real problems with it today
> > >  - statx is _the_ standard, future proofed interface for getting inode
> > >    attributes
> > 
> > No, it most definitely isn't, and statx was never intended as a
> > dumping ground for anything and everything inode related. e.g. Any
> > inode attribute that can be modified needs to use a different
> > interface - one that has a corresponding "set" operation.
> 
> And here I thought the whole point of statx was to be an extensible way
> to request any sort of inode attribute.

Within reason. When the size of a single attribute is dynamically
sized, can double the size of the statx structure and there's an
existing syscall to retrieve that information from the filesystem,
it makes no sense *at all* to duplicate that information in statx().

statx() is for new attributes we don't have any other way of exposing to
userspace easily. it is designed for fixed size attributes and
flags, it is not designed for dynamically sized information to be
embedded in struct statx.

Filehandles are not new, and we already have APIs that expose them
to userspace that handle the dynamic size of filehandles just fine.
This functionality simply does not belong in statx() at all.

> > >  - therefore, if we want userspace programmers to be using filehandles,
> > >    instead of inode numbers, so there code isn't broken, we need to be
> > >    providing interfaces that guide them in that direction.
> > 
> > We already have a filehandle interface they can use for this
> > purpose. It is already used by some userspace applications for this
> > purpose.
> > 
> > Anything new API function do with statx() will require application
> > changes, and the vast majority of applications aren't using statx()
> > directly - they are using stat() which glibc wraps to statx()
> > internally. So they are going to need a change of API, anyway.
> > 
> > So, fundamentally, there is a change of API for most applications
> > that need to do thorough inode uniqueness checks regardless of
> > anything else. They can do this right now - just continue using
> > stat() as they do right now, and then use name_to_filehandle_at()
> > for uniqueness checks.
> > 
> > > Even assuming we can update all the documentation to say "filehandles
> > > are the correct way to test inode uniqueness", you know at least half of
> > > programmers will stick to stx_ino instead of the filehandle if the
> > > filehandle is an extra syscall.
> > 
> > Your argument is "programmers suck so we must design for the
> > lowest common denominator". That's an -awful- way to design APIs.
> 
> No, I'm saying if the old way doing things no longer works, we ought to
> make the new future proofed way as ergonomic and easy to use as the old
> way was - else it won't get used.
> 
> At the _very_ least we need to add a flag to statx for "inode number is
> unreliable for uniqueness checks".
> 
> bcachefs could leave this off until the first snapshot has been taken.
> 
> But even with that option, I think we ought to be telling anyone doing
> uniqueness checks to use the filehandle, because it includes i_generation.
> 
> > Further, this "programmers suck" design comes at a cost to every
> > statx() call that does not need filehandles. That's the vast
> > majority of statx() calls that are made on a system. Why should we
> > slow down statx() for all users when so few applications actually
> > need uniqueness and they can take the cost of robust uniqueness
> > tests with an extra syscall entirely themselves?
> 
> For any local filesystem the filehandle is going to be the inode
> generation number, the subvolume ID (if applicable), and the inode
> number. That's 16 bytes on bcachefs, and if we make an attempt to
> standardize how this works across filesystems we should be able to do it
> without adding a new indirect function call to the statx() path. That
> sounds pretty negligable to me.

Filehandle encoding is already standardised.

exportfs_encode_fh() does everything needed already, including
providing the default EXPORT_FH_FID behaviour
(exportfs_encode_ino64_fid()) for filesystems that don't otherwise
support filehandles.

e.g. this will call into bcachefs and run bch2_encode_fh() to
calculate the filehandle for bcachefs.  It will call into btrfs
and run btrfs_encode_fh() to encode the file handle. The
infrastructure for encoding filehandles in a consistent, common
manner across all filesystems in the kernel is already present.

What you are suggesting is that we now duplicate filehandle encoding
into every filesystem's statx() implementation.  That's a bad
trade-off from a maintenance, testing and consistency POV because
now we end up with lots of individual, filehandle encoding
implementations in addition to the generic filehandle
infrastructure that we all have to test and validate.

> The syscall overhead isn't going to be negligable when an application
> has to do lots of scanning to find the files its interested - rsync.

Similarly, the extra syscall overhead for calling
name_to_handle_at() will be neglible for applications that need
robust inode uniqueness detection....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

