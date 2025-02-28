Return-Path: <linux-fsdevel+bounces-42795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B9A48DAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 02:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE5A3AE5A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 01:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEBB1B960;
	Fri, 28 Feb 2025 01:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="J5OO9NGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C44409
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705156; cv=none; b=F2NeKg3i3SdB8y39FT9ai2SsWPkbvRVznS2/eYpOYkgJvGhTt4/TayNzLxNNwsPMwe5ctOPj6iArv82EOsM8Ibxmzg0UNocJayhWEuuzwV+4odgeZbbnp0B8ZI0IqePADY9/oT5bNU6ft6X+KXsiJpkoHzPTT31EtTASNil+KwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705156; c=relaxed/simple;
	bh=A60GvEFUJj/iBwBmJaiQRRM3EAIPSoxtEv6lKVxVLto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SttB4Sn5JZ5mBLoCVE5Dg0H4y/gv+CmrFEsL5UfReiQ/x+WLHi2IwbOs/TG569fuA7A23PDTocIDpyjgW6srnCUxN6zfB3twajYRXfQ7n1qHaLNegdi7HFQ+pULAx9fuY6NqfG/DqesgTtea+hf9pOh+VtFGt3IXVPDRYWmTmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=J5OO9NGL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22185cddbffso47654855ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 17:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740705154; x=1741309954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LGRA7VPphS9Jn5iBE0/oDb80AP+NSCSCumMI2FV4Lw=;
        b=J5OO9NGL5C5cKfS2NPo6Xv8MiliqU1ITbhDtSdKjb+5wqBfH7m3sEoRdJsRz5qC/2d
         Vju0zs2VgZESgmGe6OB0S42dmWz/HphTpYCSsIjhOZY8NgnUf+OBgEjo0YasfnHHsgKp
         x8C2inTkLa8G5ZJiSGS/oyemCPBEL9dKMHFseCcu6y6SR5j1mlFBhBzWJcrCn72/Xgt7
         0bCqJGXjznZFJ24YgQYLZ3AATeiKGUtRMLzp9YcEGQmlnDWsGG0ap3oARfeI/l6F9LWS
         Smgms+CIiyycxMMMObaDPTA4V1Bz/Zb5cK6SMW650ssK/XRZb3OjXT1RbZxtIVCnOhpW
         EoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740705154; x=1741309954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LGRA7VPphS9Jn5iBE0/oDb80AP+NSCSCumMI2FV4Lw=;
        b=WW/vC0PbfdhYFMY3YVMhduUduFAvgAk1mzSmNVsRs6FVkcwvFoww9Nlz2OvhX3wTc5
         uYUiqlcmOkB87Od/r0L5etiw0mCP1YXyPzkoAp3ghWORvAaJ1MFo2P7IR33X21TFkn/d
         a+i2J3Db5KLkPRwY+NL2CvMrfYk3oiS4f5ed/jQMEqcVTIjEMpzypDp3/DrYGJ2l6gi9
         Fsz4/P7PSQfkohdBe7ma2OumutrDhjwtLeTuIm1gvoWjVwQ9yPkdEFLZA9q47SbNwpn/
         nw9vUc87/LyOGVUX2q/WkEDMan7ygPYLVMsGevqULvnmqJQFwzjdVwCW+2qtuSxh05Tf
         sDCg==
X-Forwarded-Encrypted: i=1; AJvYcCUyNsNF/idqrSNZkEUSjU9DEBHuaTSYjHIO45BCRdH31A8TfQuNfLwvxsdhg9XKJ7+miPtLLsxws4DN122I@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHC6iUNqHVRkDnQrcTXiL/4Qbm+NpHV2XDG6rfkMaqwC1RgKA
	GfPZC+kutbzrk/syzZsTivHz6xUolizO+SasVFKJXTjEnk4c86bPWDsjm6tbfgw=
X-Gm-Gg: ASbGncsxYDbgwbznjnh1DQwRuCEZzhWL3yE6149fvwvcKUyEq9jWrrfPERvKrqHgKLz
	plFU3am3Da88N3LfwEDecbrc5xMKDHPCRZ+OicRBxea0AgAI4iBaE3gVzHCYNEuFrm4Qhl64HXH
	0fnkn9vyL+JOjhXw6md+1aYNSVJR4f3EVL6H/sLvP0wZ/ZEpY/xw1l0qCzGgpIqa6XD1LlwBV4d
	nVu2IYwLaxYZqIKSo60o+7PT9G43yy8mMvHyYdtlp6Y2SKvoUuK1IcJF5++EPV+pmO2TXjwGS0E
	aIxAtHbpt7XZAioiwWC9rVRD58ST7YHV4p1ewh5k5yoG1Ud1T2/TSFGmu3oT/qWroCs7kq6OQJm
	RWQ==
X-Google-Smtp-Source: AGHT+IFkHEs/ILrzaG2+YI5r0gyFAxGNwuLrYNWmrNl90A1PrcGeF3HOx3TrMc59W5bFoVzhFUbWdg==
X-Received: by 2002:a62:ea12:0:b0:732:5875:eb95 with SMTP id d2e1a72fcca58-7349d1e3e32mr8929672b3a.4.1740705154401;
        Thu, 27 Feb 2025 17:12:34 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48873sm2437620b3a.49.2025.02.27.17.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 17:12:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tnovW-00000006qMq-2oW8;
	Fri, 28 Feb 2025 12:12:30 +1100
Date: Fri, 28 Feb 2025 12:12:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kalesh Singh <kaleshsingh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Juan Yescas <jyescas@google.com>,
	android-mm <android-mm@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	"Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead
 Behavior
Message-ID: <Z8ENfr7ojDEj-DI4@dread.disaster.area>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local>
 <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
 <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local>
 <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
 <Z70HJWliB4wXE-DD@dread.disaster.area>
 <Z8DjYmYPRDArpsqx@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8DjYmYPRDArpsqx@casper.infradead.org>

On Thu, Feb 27, 2025 at 10:12:50PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 25, 2025 at 10:56:21AM +1100, Dave Chinner wrote:
> > > From the previous discussions that Matthew shared [7], it seems like
> > > Dave proposed an alternative to moving the extents to the VFS layer to
> > > invert the IO read path operations [8]. Maybe this is a move
> > > approachable solution since there is precedence for the same in the
> > > write path?
> > > 
> > > [7] https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.infradead.org/
> > > [8] https://lore.kernel.org/linux-fsdevel/ZtAPsMcc3IC1VaAF@dread.disaster.area/
> > 
> > Yes, if we are going to optimise away redundant zeros being stored
> > in the page cache over holes, we need to know where the holes in the
> > file are before the page cache is populated.
> 
> Well, you shot that down when I started trying to flesh it out:
> https://lore.kernel.org/linux-fsdevel/Zs+2u3%2FUsoaUHuid@dread.disaster.area/

No, I shot down the idea of having the page cache maintain a generic
cache of file offset to LBA address mappings outside the filesystem.

Having the filesystem insert a special 'this is a hole' entry into
the mapping tree insert of allocating and inserting a page full of
zeroes is not an extent cache - it's just a different way of
representing a data range that is known to always contain zeroes.

> > As for efficient hole tracking in the mapping tree, I suspect that
> > we should be looking at using exceptional entries in the mapping
> > tree for holes, not inserting mulitple references to the zero folio.
> > i.e. the important information for data storage optimisation is that
> > the region covers a hole, not that it contains zeros.
> 
> The xarray is very much optimised for storing power-of-two sized &
> aligned objects.  It makes no sense to try to track extents using the
> mapping tree.

Certainly. I'm not suggesting that we do this at all, and ....

> Now, if we abandon the radix tree for the maple tree, we
> could talk about storing zero extents in the same data structure.
> But that's a big change with potentially significant downsides.
> It's something I want to play with, but I'm a little busy right now.

.... I still do not want the page cache to try to maintain a block
mapping/extent cache in addition to the what the filesystem must
already maintain for the reasons I have previously given.

> > For buffered reads, all that is required when such an exceptional
> > entry is returned is a memset of the user buffer. For buffered
> > writes, we simply treat it like a normal folio allocating write and
> > replace the exceptional entry with the allocated (and zeroed) folio.
> 
> ... and unmap the zero page from any mappings.

Sure. That's just a call to unmap_mapping_range(), yes?

> > For read page faults, the zero page gets mapped (and maybe
> > accounted) via the vma rather than the mapping tree entry. For write
> > faults, a folio gets allocated and the exception entry replaced
> > before we call into ->page_mkwrite().
> > 
> > Invalidation simply removes the exceptional entries.
> 
> ... and unmap the zero page from any mappings.

Invalidation already calls unmap_mapping_range(), so this should
already be handled, right?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

