Return-Path: <linux-fsdevel+bounces-5743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEEF80F868
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE4D1C20D6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121465A6B;
	Tue, 12 Dec 2023 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sLqInWGe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ABC1BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 12:48:21 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d9dbe224bbso4533637a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 12:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702414100; x=1703018900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVqjzYmMQlC8GFrsUFTCmPpPXyWkgv32hXJBYv5zBPg=;
        b=sLqInWGeZOV0m3TId42q/7hH88dLpFBnxfCD2InaaA/asS5N6d2nYPAvSA+FqS5oo4
         RI8swNCW3L5PNDSXGAcQoSoIvQcfBjPpGomZXWF3KbZ+E3u3S9qjkwTzhW2ItSPnIow4
         n8OsXCmMSVMwYCyhOCDxcc9G+OxjKa/l/0S8shIDd7cR1rgUujy4JX74ZR7QyFX4Hg+O
         nFicUGUiE658Lb+coAKQYXDEc3scWybaX9jTin4bQUhfnwqiTE5WSyMrOtzi3FUA+kWe
         ol4EPNAMWcQHm+tAm4SazPlt94b7rQLbKQyMrqxf7fP1wcFRDN1ZGalD/b7N/ugePgS7
         +xIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414100; x=1703018900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVqjzYmMQlC8GFrsUFTCmPpPXyWkgv32hXJBYv5zBPg=;
        b=ETWVPgS+eznX0TJyHnsyuBTgFW1suJDFSP96jpOBrLTrJ9hdrDxBAfgCY8PsFMt/C9
         2C95tCcdUWpCvGnYLDQPpF6LO0CmLrYgq5/fS5mbYV+jKAGbpY1oLRCBWqgSUQfBfl74
         ABTY4esXC0dnmLZ45No9cNASUpzj5zPtI1bD+BpV7lYRYRveuP2De2FtAh/jnU0Wc83S
         AnGjM3RsegZ20AXTPl1v2lIRD/3NrSuPYycshWJpYdAN2ww8w2X3K7WTRu2ztE3Pn0pW
         QSTMVY3v1xTlHRKEGhoMGPnI8f5zwTuw5kLUT34mOOC/DcMHdTNlTUqIsddRefYq3+DC
         11HA==
X-Gm-Message-State: AOJu0YwADRjyV44mhpb0kX0NkblbI33qE1j07F9depw2Kxx4lWUUdnsr
	LOAutq5gnhn/TO0/XiPPhJg/Tw==
X-Google-Smtp-Source: AGHT+IEko0WrYzcClnAKt6LFrWR88tsKOkk7WGPmvQ8700VnhlisdsftOAR9JshHQTBff8F/+hr7jw==
X-Received: by 2002:a05:6359:1a86:b0:170:21ef:3e71 with SMTP id rv6-20020a0563591a8600b0017021ef3e71mr4232756rwb.42.1702414100115;
        Tue, 12 Dec 2023 12:48:20 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id ks5-20020a056a004b8500b006cef51f51b7sm6449110pfb.155.2023.12.12.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:48:19 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rD9fs-007S6y-0s;
	Wed, 13 Dec 2023 07:48:16 +1100
Date: Wed, 13 Dec 2023 07:48:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: NeilBrown <neilb@suse.de>, Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <ZXjHEPn3DfgQNoms@dread.disaster.area>
References: <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <20231212152153.tasaxsrljq2zzbxe@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212152153.tasaxsrljq2zzbxe@moria.home.lan>

On Tue, Dec 12, 2023 at 10:21:53AM -0500, Kent Overstreet wrote:
> On Tue, Dec 12, 2023 at 04:53:28PM +1100, Dave Chinner wrote:
> > Doesn't anyone else see or hear the elephant trumpeting loudly in
> > the middle of the room?
> > 
> > I mean, we already have name_to_handle_at() for userspace to get a
> > unique, opaque, filesystem defined file handle for any given file.
> > It's the same filehandle that filesystems hand to the nfsd so nfs
> > clients can uniquely identify the file they are asking the nfsd to
> > operate on.
> > 
> > The contents of these filehandles is entirely defined by the file
> > system and completely opaque to the user. The only thing that
> > parses the internal contents of the handle is the filesystem itself.
> > Therefore, as long as the fs encodes the information it needs into the
> > handle to determine what subvol/snapshot the inode belongs to when
> > the handle is passed back to it (e.g. from open_by_handle_at()) then
> > nothing else needs to care how it is encoded.
> > 
> > So can someone please explain to me why we need to try to re-invent
> > a generic filehandle concept in statx when we already have a
> > have working and widely supported user API that provides exactly
> > this functionality?
> 
> Definitely should be part of the discussion :)
> 
> But I think it _does_ need to be in statx; because:
>  - we've determined that 64 bit ino_t just isn't a future proof
>    interface, we're having real problems with it today
>  - statx is _the_ standard, future proofed interface for getting inode
>    attributes

No, it most definitely isn't, and statx was never intended as a
dumping ground for anything and everything inode related. e.g. Any
inode attribute that can be modified needs to use a different
interface - one that has a corresponding "set" operation.

>  - therefore, if we want userspace programmers to be using filehandles,
>    instead of inode numbers, so there code isn't broken, we need to be
>    providing interfaces that guide them in that direction.

We already have a filehandle interface they can use for this
purpose. It is already used by some userspace applications for this
purpose.

Anything new API function do with statx() will require application
changes, and the vast majority of applications aren't using statx()
directly - they are using stat() which glibc wraps to statx()
internally. So they are going to need a change of API, anyway.

So, fundamentally, there is a change of API for most applications
that need to do thorough inode uniqueness checks regardless of
anything else. They can do this right now - just continue using
stat() as they do right now, and then use name_to_filehandle_at()
for uniqueness checks.

> Even assuming we can update all the documentation to say "filehandles
> are the correct way to test inode uniqueness", you know at least half of
> programmers will stick to stx_ino instead of the filehandle if the
> filehandle is an extra syscall.

Your argument is "programmers suck so we must design for the
lowest common denominator". That's an -awful- way to design APIs.

Further, this "programmers suck" design comes at a cost to every
statx() call that does not need filehandles. That's the vast
majority of statx() calls that are made on a system. Why should we
slow down statx() for all users when so few applications actually
need uniqueness and they can take the cost of robust uniqueness
tests with an extra syscall entirely themselves?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

