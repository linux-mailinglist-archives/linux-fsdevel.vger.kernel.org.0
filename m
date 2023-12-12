Return-Path: <linux-fsdevel+bounces-5618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A1E80E412
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 06:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E85282DF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 05:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E96156DE;
	Tue, 12 Dec 2023 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="z9w9EHoM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19FEBD
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 21:53:31 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ceb2501f1bso4320497b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 21:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702360411; x=1702965211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKqOBIedlSsY4nBkWI82g8jPO85sii/44Gnqq6ID1O0=;
        b=z9w9EHoMcBwO88sgKcuVsU/HhPi+z1X/0J1QfvzFMypNKhmsdBHIX2KmZRbijQ424w
         WQI8p5qiAitMCtkJnDArn+tPFyBUlsg0+rGhwHn5KU9B55Rtk7N7wypT0Ak5y+znR5bW
         c6CZwk6H/C/UM7F5mtZH8uNB+JPmrSs6rfBK48QBJn5JRHOuUizxHpkqF0E2cV+K6Y3S
         AltXW2bB2kkItw7KgM3ZLtjeaZ9oCKqGdG1eJok+CMne6ql1Y/KVfs6wZGyiTg6wz6SN
         S+xYMGm64gav5/abtnz1wD+MhGKchpiDVSq8hqWGWx9gv50moGD1myrcAkCVnV0HRg/z
         j7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702360411; x=1702965211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKqOBIedlSsY4nBkWI82g8jPO85sii/44Gnqq6ID1O0=;
        b=YWv4vYn3OSEV9cCsfv2fQgwmEswhnm43teJOre8MaHKIWtHFdNzlTcZp14J7hoKOns
         LOhwUTF6YWl8Bsv0ThW18JAdjfw+5jwIA6/SxEChvqGq2Cu+NmgSPOPOy2a7UbagXGgS
         BkGm7GSenjtAX7kPGpO9rNxd5UKyRO8rvl/7zNjHy0bAkrZyvrWJxYehvumSQiHAGWLf
         PDNM9fuLC4GKUKPY2k9cy/8CwhdYCLonwiVYsUgHk+P09hXNI9aICnHyekE/yjLV9WA8
         UVQJ1jIFvJxj18HKIBf/JhEwBEnqQT+BH8PNzGpCBwkA8SL1Z61HN2wtnYxeoNGYod14
         7U5A==
X-Gm-Message-State: AOJu0YxpmVkMRV/dX9zCnZ4atExvHJ0WFQQo0ycdOlJ69mG5BiOKS4d6
	bulimebNxzpVLmMShXmIjXhHoA==
X-Google-Smtp-Source: AGHT+IFNMdmcLLW9monbbEC6emitbzMai6XS5PZWnbznSerDkEEY58O7eOR3Q77jdDbkRAR0c8/x4w==
X-Received: by 2002:a05:6a20:e125:b0:190:230:8e8b with SMTP id kr37-20020a056a20e12500b0019002308e8bmr7280439pzb.105.1702360411404;
        Mon, 11 Dec 2023 21:53:31 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b001d08bbcf78bsm7673902plh.74.2023.12.11.21.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 21:53:30 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rCvhw-007AkC-0p;
	Tue, 12 Dec 2023 16:53:28 +1100
Date: Tue, 12 Dec 2023 16:53:28 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <ZXf1WCrw4TPc5y7d@dread.disaster.area>
References: <20231208013739.frhvlisxut6hexnd@moria.home.lan>
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170234279139.12910.809452786055101337@noble.neil.brown.name>

On Tue, Dec 12, 2023 at 11:59:51AM +1100, NeilBrown wrote:
> On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > On Tue, Dec 12, 2023 at 10:53:07AM +1100, NeilBrown wrote:
> > > On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > > > On Tue, Dec 12, 2023 at 09:43:27AM +1100, NeilBrown wrote:
> > > > > On Sat, 09 Dec 2023, Kent Overstreet wrote:
> > > > Thoughts?
> > > > 
> > > 
> > > I'm completely in favour of exporting the (full) filehandle through
> > > statx. (If the application asked for the filehandle, it will expect a
> > > larger structure to be returned.  We don't need to use the currently
> > > reserved space).
> > > 
> > > I'm completely in favour of updating user-space tools to use the
> > > filehandle to check if two handles are for the same file.
> > > 
> > > I'm not in favour of any filesystem depending on this for correct
> > > functionality today.  As long as the filesystem isn't so large that
> > > inum+volnum simply cannot fit in 64 bits, we should make a reasonable
> > > effort to present them both in 64 bits.  Depending on the filehandle is a
> > > good plan for long term growth, not for basic functionality today.
> > 
> > My standing policy in these situations is that I'll do the stopgap/hacky
> > measure... but not before doing actual, real work on the longterm
> > solution :)
> 
> Eminently sensible.
> 
> > 
> > So if we're all in favor of statx as the real long term solution, how
> > about we see how far we get with that?
> > 
> 
> I suggest:
> 
>  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
>                               same inode number
> 
>  
>  __u64 stx_vol     Volume identifier.  Two files with same stx_vol and 
>                    stx_ino MUST be the same.  Exact meaning of volumes
>                    is filesys-specific
>  
>  STATX_VOL         Want stx_vol
> 
>   __u8 stx_handle_len  Length of stx_handle if present
>   __u8 stx_handle[128] Unique stable identifier for this file.  Will
>                        NEVER be reused for a different file.
>                        This appears AFTER __statx_pad2, beyond
>                        the current 'struct statx'.
>  STATX_HANDLE      Want stx_handle_len and stx_handle. Buffer for
>                    receiving statx info has at least
>                    sizeof(struct statx)+128 bytes.

Hmmm.

Doesn't anyone else see or hear the elephant trumpeting loudly in
the middle of the room?

I mean, we already have name_to_handle_at() for userspace to get a
unique, opaque, filesystem defined file handle for any given file.
It's the same filehandle that filesystems hand to the nfsd so nfs
clients can uniquely identify the file they are asking the nfsd to
operate on.

The contents of these filehandles is entirely defined by the file
system and completely opaque to the user. The only thing that
parses the internal contents of the handle is the filesystem itself.
Therefore, as long as the fs encodes the information it needs into the
handle to determine what subvol/snapshot the inode belongs to when
the handle is passed back to it (e.g. from open_by_handle_at()) then
nothing else needs to care how it is encoded.

So can someone please explain to me why we need to try to re-invent
a generic filehandle concept in statx when we already have a
have working and widely supported user API that provides exactly
this functionality?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

