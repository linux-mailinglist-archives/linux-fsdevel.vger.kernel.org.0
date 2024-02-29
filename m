Return-Path: <linux-fsdevel+bounces-13147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F415E86BCD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 01:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B66DB22331
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 00:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93276101C8;
	Thu, 29 Feb 2024 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mP2o/Ld8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D58F5A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166339; cv=none; b=XFc9tKGYdEWzTetjjFfR4RuIWWCc8Jl+VMj9f7GfkvQnyv/B3RXwprdjpCqaz1Qt2sNELXHXV1fftXxkdI3X+Dn7ZWHfbsci8tou3mK6MPKx/frw3v/OzYftzBNB9SdxBGBYA83N30bDtnuABs/lP2Rsxqu0pTQwuLYZmsDuV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166339; c=relaxed/simple;
	bh=kdGjzkjhRlijxWSQUk8OYXREJH6OWoiRQl5SpysflX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY2EdocD9dUVD557cqGLxj5OP/5DpvDuDPCFftazhz6yiA4F/c1K5tupopHJZMiAzryUgAcRmS+GxGNo6VO2N6+mV2VlGsI/lCIGtBDm96b0OqknUw0B5OSZR3MFRE7dPgPipaMNqb5ShkxHKo+Dy3N0h5XNwTqUSvsfcoUj9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mP2o/Ld8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5e152c757a5so204661a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 16:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709166336; x=1709771136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PkwCQ+L+1Ki8bGzt9VpkqtwgfzwkziGikLVOEPKGous=;
        b=mP2o/Ld8U0z+VqFrIcu5TW/ONH5/1SLCx9VjTFJgNghpAplX2yaQ6ATEd3XVwGxlFX
         /A0GyiUUMGFgrGMANT4vKCAGD1Nj2hOh3w9nJ4gnOOgQPsJKzDBsVOfkROS4o5sW6jAY
         p//EsJzLioabAaQgGEN/v2oBCdN0WZRWBBQKWSoBSTnIcX4g/BWrjEM07EOnwv35/IWI
         4SLeqyt+vOjNy22Fq+SEbdyXkIeGmc7yGLqM/n8xm4wr7WVXqErH5KjqW79YfmYsahYV
         hvzfZipKExjAa5GLdwJmoBUuF+gemUydXXDIRRH4AU26hGnDYcaVjDZixOIGXK5EgPi5
         0VfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709166336; x=1709771136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkwCQ+L+1Ki8bGzt9VpkqtwgfzwkziGikLVOEPKGous=;
        b=MJxM3Y84+lDkZAQ9D2E3zwpCNInb/hYf4iWkaujBMhQmktk9xUcvuK/7e/QnpvZ2+p
         LbqrMuZu9H9IqHaIKzwaFa+MXe27iU9vK1LUNaJTkA+fnMh8Xqe753sfGlIqJtPGXRaW
         IHK4EHw8Rs/LN/OiT44AjhJHsQ61bN2Er/eUrD8TnXnraMqtJl+Z6MnahedFk9ao9CSK
         qEghXpWUKE4Ibhvqzd0QZam1d8A+xP4W0t8xRV/VdzsDLsyMq4YwHzdiOI72KOUoQ9zR
         vpS6XN4x+l7URPNqrkX98A9jfiCx5QJMRZGq4k31t8DW8zF8gCyz4g3FU8pFKdESTJZ6
         Ncqw==
X-Forwarded-Encrypted: i=1; AJvYcCXY+LQmqk6n/vZ4sPBNBa+T0CedwLSuY7Ah2j2N/2TOJH7sgOb7NicUQ8G8UccIzi6T8mx/QawaIAF5bbzYosWSLlog+VEkEJszgGGUZg==
X-Gm-Message-State: AOJu0YzxQC2JY75epKAX0yjbnTUYV1kBmlYkFMEc9nR3guCUzCJmhTRL
	40w0KDYR1x9JMJXA6ZBDKV2mq0m6qQ4vOgbp3xfuEI9/BaCWtujg1KVF5YIajIk=
X-Google-Smtp-Source: AGHT+IG5iHfnEZ0ZTUMTkFT7V8xoIOLlz9zatX9Mo2lGdrUibfGpeoC/7fy6clFiU6QZBPq0550Qpg==
X-Received: by 2002:a05:6a21:910c:b0:1a0:e475:c0ac with SMTP id tn12-20020a056a21910c00b001a0e475c0acmr1240744pzb.53.1709166336631;
        Wed, 28 Feb 2024 16:25:36 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id l14-20020a170902f68e00b001c407fac227sm55795plg.41.2024.02.28.16.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:25:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rfUEv-00CsoP-2H;
	Thu, 29 Feb 2024 11:25:33 +1100
Date: Thu, 29 Feb 2024 11:25:33 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, Matthew Wilcox <willy@infradead.org>,
	Daniel Gomez <da.gomez@samsung.com>, linux-mm <linux-mm@kvack.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Measuring limits and enhancing
 buffered IO
Message-ID: <Zd/O/S3rdvZ8OxZJ@dread.disaster.area>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <Zd5lORiOCUsARPWq@dread.disaster.area>
 <CAOQ4uxi=fdjXq7q0_+0mDovmBd6Afb=xteFBSnE-rUmQMJYgRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi=fdjXq7q0_+0mDovmBd6Afb=xteFBSnE-rUmQMJYgRQ@mail.gmail.com>

On Wed, Feb 28, 2024 at 09:48:46AM +0200, Amir Goldstein wrote:
> On Wed, Feb 28, 2024 at 12:42 AM Dave Chinner via Lsf-pc
> <lsf-pc@lists.linux-foundation.org> wrote:
> >
> > On Tue, Feb 27, 2024 at 05:21:20PM -0500, Kent Overstreet wrote:
> > > On Wed, Feb 28, 2024 at 09:13:05AM +1100, Dave Chinner wrote:
> > > > On Tue, Feb 27, 2024 at 05:07:30AM -0500, Kent Overstreet wrote:
> > > > > AFAIK every filesystem allows concurrent direct writes, not just xfs,
> > > > > it's _buffered_ writes that we care about here.
> > > >
> > > > We could do concurrent buffered writes in XFS - we would just use
> > > > the same locking strategy as direct IO and fall back on folio locks
> > > > for copy-in exclusion like ext4 does.
> > >
> > > ext4 code doesn't do that. it takes the inode lock in exclusive mode,
> > > just like everyone else.
> >
> > Uhuh. ext4 does allow concurrent DIO writes. It's just much more
> > constrained than XFS. See ext4_dio_write_checks().
> >
> > > > The real question is how much of userspace will that break, because
> > > > of implicit assumptions that the kernel has always serialised
> > > > buffered writes?
> > >
> > > What would break?
> >
> > Good question. If you don't know the answer, then you've got the
> > same problem as I have. i.e. we don't know if concurrent
> > applications that use buffered IO extensively (eg. postgres) assume
> > data coherency because of the implicit serialisation occurring
> > during buffered IO writes?
> >
> > > > > If we do a short write because of a page fault (despite previously
> > > > > faulting in the userspace buffer), there is no way to completely prevent
> > > > > torn writes an atomicity breakage; we could at least try a trylock on
> > > > > the inode lock, I didn't do that here.
> > > >
> > > > As soon as we go for concurrent writes, we give up on any concept of
> > > > atomicity of buffered writes (esp. w.r.t reads), so this really
> > > > doesn't matter at all.
> > >
> > > We've already given up buffered write vs. read atomicity, have for a
> > > long time - buffered read path takes no locks.
> >
> > We still have explicit buffered read() vs buffered write() atomicity
> > in XFS via buffered reads taking the inode lock shared (see
> > xfs_file_buffered_read()) because that's what POSIX says we should
> > have.
> >
> > Essentially, we need to explicitly give POSIX the big finger and
> > state that there are no atomicity guarantees given for write() calls
> > of any size, nor are there any guarantees for data coherency for
> > any overlapping concurrent buffered IO operations.
> >
> 
> I have disabled read vs. write atomicity (out-of-tree) to make xfs behave
> as the other fs ever since Jan has added the invalidate_lock and I believe
> that Meta kernel has done that way before.
> 
> > Those are things we haven't completely given up yet w.r.t. buffered
> > IO, and enabling concurrent buffered writes will expose to users.
> > So we need to have explicit policies for this and document them
> > clearly in all the places that application developers might look
> > for behavioural hints.
> 
> That's doable - I can try to do that.
> What is your take regarding opt-in/opt-out of legacy behavior?

Screw the legacy code, don't even make it an option. No-one should
be relying on large buffered writes being atomic anymore, and with
high order folios in the page cache most small buffered writes are
going to be atomic w.r.t. both reads and writes anyway.

> At the time, I have proposed POSIX_FADV_TORN_RW API [1]
> to opt-out of the legacy POSIX behavior, but I guess that an xfs mount
> option would make more sense for consistent and clear semantics across
> the fs - it is easier if all buffered IO to inode behaved the same way.

No mount options, just change the behaviour. Applications already
have to avoid concurrent overlapping buffered reads and writes if
they care about data integrity and coherency, so making buffered
writes concurrent doesn't change anything.

Dave.
-- 
Dave Chinner
david@fromorbit.com

