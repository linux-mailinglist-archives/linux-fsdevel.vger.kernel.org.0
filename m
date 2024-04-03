Return-Path: <linux-fsdevel+bounces-16081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F0E897B8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 00:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3B21F27DE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 22:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B48156C69;
	Wed,  3 Apr 2024 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0sr51EW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FCE156978
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182939; cv=none; b=n+jGGB4SenAAZPz1rqsANs5pSvs8+SmileD2w6HtxNJhcmFwa370aB3lw77yeropbp+M6QTRVcc3ZMiOOnUVSg5F160JzCe8Ya2tCema5xCYU34CJXp9DgaALlJLJhibw3tWvj9g3WP8P/7DQeGWCcwsSZ0HL5AqaZJiD2xCwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182939; c=relaxed/simple;
	bh=3KSVOJaDalXFFs+Rv4rVlWYBzeDs1N7n9QWb828tI/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlHhtDXQnYq6b3fVwt7Sz+aZAI8Is6FV65efiTcYFYQutETQ7KolDd4Ok449clYEDpRF83QVVg05zeKDBm0b4guvpgp73bs0qxWNQmPzG0jh6IUGJHcYl4U8w8Vu8O3jJc5kY/xby9L8h8NzXGxizct6z85DHryaHZePFh8DHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0sr51EW3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e74aa08d15so252479b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 15:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1712182937; x=1712787737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mNHE/kgd6uGstPd0OsS5i1TQFRmNf9ft+suhfa4d/A=;
        b=0sr51EW3DMrZ8IjllatBSYJksZFFswii6dYTQXJ4QbZNMh/fxJY4DCTs2TLhzxMO9c
         ZpsbUrzTk3YYzs7Uahbb2mXcV2Z87tEbGvJkmgkrpf7tFs1R3YPfd9L85cXfBiSZhjjZ
         dyPdxaVf4lR7R29amFCQxfsX7BiXC/BICHbozLr4rQBG/Cvfkkm4M/3fthwzJoXixSxc
         UBJT5/FTQX1M93FeEFWvdbSnQCaYltGHbJ9DYXIIKpnAUxDRhR6AkQw0G7YUxWWwdO4A
         fII2UWqRt8/+LV5jZUu0DVhK0CJAIpl5uNXiF5XqC/Nzy6gpg+dnsvAIWZtSmzOiVQJ8
         BuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712182937; x=1712787737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mNHE/kgd6uGstPd0OsS5i1TQFRmNf9ft+suhfa4d/A=;
        b=r/XYECXlMrKy7UVMNoYJuas/Xv+hfzVptl2tPtukeo4Er+JnOpPUUo9PSTYG09XRVt
         wv0liG2flwNO4NCkrZkWiQCdPkBYR1l+CDtTrc73YXmezODuK58T8HWAM3L9/oQgZqgH
         OQ0dySjT7DmaiBFveCXZhXJ4+8igi6zjHIJEx/uHmGOROEx/6ckHEmKs0kizOl5B6EBm
         Lk6zDWHtxcFWRB8pnxDk9tibdkUY0Zr7vWN2Pp8WNZ9Om1/t0JAP5fjlzvffeJrN2fEV
         iklpuNMSfx2KZA5131LA2oMrZOuxU7fMmMZrGS0KagS0c4EihFfIyJ3F/LrX0H6+EbdY
         rMqw==
X-Forwarded-Encrypted: i=1; AJvYcCVIkMPScEERk3/l56g0tZsY10DjYqWm1lbP0L5dF4GO8VKyAoQeMrlIheZrqOq3w597tCW5M5j7u7G5heAhILPN0SUzIAQrEjD8xIS8mg==
X-Gm-Message-State: AOJu0YwfDcjN2qQYa+xrlxBUPawqGNT16arGzPOZtCRP4jwsO4Q6wFXp
	WkYww0GT2H8qRXDCSzZQdHQ1akDFKRUP8Tybl7UzFLJILSPDojGKw2D4NdNoK/E=
X-Google-Smtp-Source: AGHT+IHgaAUVzNrztyNd/wvPHrxK+bRPIaaKmdlj58TK0lUvb6yHDmW+PB08lD3eeuxItg1GdhGR7g==
X-Received: by 2002:a17:902:f38c:b0:1e2:81c1:b35e with SMTP id f12-20020a170902f38c00b001e281c1b35emr609306ple.54.1712182937221;
        Wed, 03 Apr 2024 15:22:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b001e2772fc413sm1717504plg.309.2024.04.03.15.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 15:22:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rs8zm-0030Er-18;
	Thu, 04 Apr 2024 09:22:14 +1100
Date: Thu, 4 Apr 2024 09:22:14 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Colin Walters <walters@verbum.org>, Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	xfs <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, Alexander Larsson <alexl@redhat.com>
Subject: Re: [PATCH 28/29] xfs: allow verity files to be opened even if the
 fsverity metadata is damaged
Message-ID: <Zg3WlmTNw6qJW3rE@dread.disaster.area>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
 <2afcf2b2-992d-4678-bf68-d70dce0a2289@app.fastmail.com>
 <20240402225216.GW6414@frogsfrogsfrogs>
 <992e84c7-66f5-42d2-a042-9a850891b705@app.fastmail.com>
 <20240403013903.GG6390@frogsfrogsfrogs>
 <Zgy3+ljJME0pky3d@dread.disaster.area>
 <20240403031910.GH6390@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403031910.GH6390@frogsfrogsfrogs>

On Tue, Apr 02, 2024 at 08:19:10PM -0700, Darrick J. Wong wrote:
> On Wed, Apr 03, 2024 at 12:59:22PM +1100, Dave Chinner wrote:
> > On Tue, Apr 02, 2024 at 06:39:03PM -0700, Darrick J. Wong wrote:
> > > On Tue, Apr 02, 2024 at 08:10:15PM -0400, Colin Walters wrote:
> > > > >> I hesitate to say it but maybe there should be some ioctl for online
> > > > >> repair use cases only, or perhaps a new O_NOVERITY special flag to
> > > > >> openat2()?
> > > > >
> > > > > "openat2 but without meddling from the VFS"?  Tempting... ;)
> > > > 
> > > > Or really any lower level even filesystem-specific API for the online
> > > > fsck case.  Adding a blanket new special case for all CAP_SYS_ADMIN
> > > > processes covers a lot of things that don't need that.
> > > 
> > > I suppose there could be an O_NOVALIDATION to turn off data checksum
> > > validation on btrfs/bcachefs too.  But then you'd want to careful
> > > controls on who gets to use it.  Maybe not liblzma_la-crc64-fast.o.
> > 
> > Just use XFS_IOC_OPEN_BY_HANDLE same as xfs_fsr and xfsdump do. The
> > handle can be build in userspace from the inode bulkstat
> > information, and for typical inode contents verification purposes we
> > don't actually need path-based open access to the inodes. That would
> > then mean we can simple add our own open flag to return a fd that
> > can do data operations that short-circuit verification...
> 
> Heh, ok.  Are there any private flags that get passed via
> xfs_fsop_handlereq_t::oflags?  Or does that mean defining a top level
> O_FLAG that cannot be passed through openat but /can/ be sent via
> open_by_handle?

AIUI, open flags are arch specific, but I don't think any use the
high bits of the 32 bit space they are defined in.  So I think we
could probably use the high bits in that field for our own purposes
and not get conflicts with generic open flags...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

