Return-Path: <linux-fsdevel+bounces-13412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B3786F80B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 01:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1775BB20BA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 00:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B85EDF;
	Mon,  4 Mar 2024 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ofoNvBdy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95AA41
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 00:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709513217; cv=none; b=Vb/KZ13eDrqBpwrt1Tv+T+ngNCl2lvtUpAoHSToY0/VGBAIaPf9knbx5HCJm9WTlV2ZnOvG0jLbWi/YThZ6JdHao2b0CbgoKaOXYcZG2fiMGMwDSJ5ij7eZW6HTtHG7Uyg259A4lk6FiiL7Cp9rcCC7SVoR7LI6aMngogZl/uk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709513217; c=relaxed/simple;
	bh=3sSge8IIk7lFlwwd3uzWi3r78nZAsslccHAq8vrIHnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Livd//HaXV14hYyUTWzeuw+PPaYdjtGLboN0QLrLC36C4nM6AvqI3JMZB0dga5WF/x+b68bL9YC91YS2XApeKDGJUFGPMoUbu99+uQCGKW9xLP+jJ/RQMN9QfsEtDRk7YIiBRv5Zi7ul8zKQoNZvDIRcu/wsAlaVIcjDhXcYW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ofoNvBdy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6092a84f4so482256b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Mar 2024 16:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709513215; x=1710118015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2HeHGRMjIF2wT+ppUMlD/kDYmzzKMlwBxD7H0DQGzg=;
        b=ofoNvBdyaSJTrmsV483KlBAnN+MQAB8Af7CkioSo2T8Qti8ytRN1Rm2sosKEDSDVNh
         TW855IwVPh/HOVho2wJ8Nddd5WTY7EbgVamEQQWK9Zvqo7k4icd8tTIEXSoYKjLcRiQ7
         UKkRi1rG3Hc24UIdaAkF6WC7aaoqGoGHrs+8mM4yI48HnUvrVYifji9Hcjt4L9BDC72r
         kVn7VPP805SLsUU7GOxoCpwRiJriDfvaeAi3x7OFW6OPPjlWCfwudYA1dOcqMxce7mGG
         IPkLEw4CrJIkhDJ12gSW+t+bkkmzp2nZ6UPbEhTzgqsVqjX7XsFYtp9uCY8QmSALeqMg
         VgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709513215; x=1710118015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2HeHGRMjIF2wT+ppUMlD/kDYmzzKMlwBxD7H0DQGzg=;
        b=v3GUABvgDGr2VH9TGYRETJ0wBnIcK6rMxG/Xmid0KwDF/lORcpK8ikDVIXaBND9j3m
         yiGdTGYoMcyz6SjlxYtPJMu9VzJdvFwKtvrL8+7KaTK0nF8ABZxGPGE7iFjIAoweukNZ
         FI/TAyFaFLa7/5Vty6Z1BXzI9/YWatVDPqkHv15y+y9scumK2dbQiHuMjYOHmzNtcfU2
         IcHmXCbiSU4lHNrW6htgnY6K39U07+KThk0pD4As4OBIMhJ6qM6gytePyOPOKXXg+6On
         Ec+hm3+2oZxQUIsk77DYVHw15Nv498PbP0IHvAtOhx0G8vXw+p0q41lf2o7xS2hqiDV4
         yktg==
X-Forwarded-Encrypted: i=1; AJvYcCU6VWEZSBHQZrhaOFwj3Z3OPCK+Dj6rwXyCygMeIFt0Y4VBoGt7DYuCCG9JDszi8o08RRcVGC0Dp1KyMRBKgJn3QfDxgdpHEw0sG+QFeQ==
X-Gm-Message-State: AOJu0Yxq9xjD18cJMRp87FoaFjlu0ssTPym6VFg5xtfPuBjh3Qvz0ltx
	nBu2Zq+rvezUHEiq2lzgH5RQqvsXdOMymLznNcSjLJCJxricv+MnxatSaRDiON4=
X-Google-Smtp-Source: AGHT+IHifJ1Tx8WKSsecIgu3hpRHjyTgmPbCv4mNpzslMkrSD3VbHiFWwXQ1ty81LDv1WMPApG96Pw==
X-Received: by 2002:a05:6a00:cc5:b0:6e1:482b:8c8e with SMTP id b5-20020a056a000cc500b006e1482b8c8emr7898114pfv.17.1709513215475;
        Sun, 03 Mar 2024 16:46:55 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id w189-20020a6262c6000000b006e629bd793esm48126pfb.108.2024.03.03.16.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 16:46:54 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rgwTk-00EgLm-1M;
	Mon, 04 Mar 2024 11:46:52 +1100
Date: Mon, 4 Mar 2024 11:46:52 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <ZeUZ/DWuCvR1423G@dread.disaster.area>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <Zd5lORiOCUsARPWq@dread.disaster.area>
 <CAOQ4uxi=fdjXq7q0_+0mDovmBd6Afb=xteFBSnE-rUmQMJYgRQ@mail.gmail.com>
 <Zd/O/S3rdvZ8OxZJ@dread.disaster.area>
 <j6cvqvq2az45kj5tjepbklm7r3h24rl4mj65ygf3uozaseauuv@hdr7tmidxx5u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j6cvqvq2az45kj5tjepbklm7r3h24rl4mj65ygf3uozaseauuv@hdr7tmidxx5u>

On Wed, Feb 28, 2024 at 07:57:38PM -0500, Kent Overstreet wrote:
> On Thu, Feb 29, 2024 at 11:25:33AM +1100, Dave Chinner wrote:
> > > That's doable - I can try to do that.
> > > What is your take regarding opt-in/opt-out of legacy behavior?
> > 
> > Screw the legacy code, don't even make it an option. No-one should
> > be relying on large buffered writes being atomic anymore, and with
> > high order folios in the page cache most small buffered writes are
> > going to be atomic w.r.t. both reads and writes anyway.
> 
> That's a new take...
> 
> > 
> > > At the time, I have proposed POSIX_FADV_TORN_RW API [1]
> > > to opt-out of the legacy POSIX behavior, but I guess that an xfs mount
> > > option would make more sense for consistent and clear semantics across
> > > the fs - it is easier if all buffered IO to inode behaved the same way.
> > 
> > No mount options, just change the behaviour. Applications already
> > have to avoid concurrent overlapping buffered reads and writes if
> > they care about data integrity and coherency, so making buffered
> > writes concurrent doesn't change anything.
> 
> Honestly - no.
> 
> Userspace would really like to see some sort of definition for this kind
> of behaviour, and if we just change things underneath them without
> telling anyone, _that's a dick move_.

I don't think you understand the full picture here, Kent.

> POSIX_FADV_TORN_RW is a terrible name, though.

The described behaviour for this advice is the standard behaviour
for ext4, btrfs and most linux filesystems other than XFS. It has
been for a -long- time.

The only filesystem that gives anything resembling POSIX atomic
write behaviour is XFS. No other filesystem in Linux actually
provides the POSIX "buffered reads won't see partial data from
buffered writes in progress" behaviour that XFS does via the IOLOCK
behaviour it uses.

So when I say "screw the legacy apps" I'm talking about the ancient
enterprise applications that still behave as if this POSIX behaviour
is reliable on modern linux systems. It simply isn't, and these apps
are *already implicitly broken* on most Linux filesystems and they
need fixing.

> And fadvise() is the wrong API for this because it applies to ranges,
> this should be an open flag or an fcntl.

Not only is it the wrong API, it's also the wrong approach to take.
We have a new API coming through for atomic writes: RWF_ATOMIC.

If an applications needs an actual atomic IO guarantee, they will
soon be able to be explicit in their requirements and they will not
end up in the situation where the filesystem they use might
determine if there is an implicit atomic write behaviour provided.

Indeed, we don't actually say that XFS will always guarantee POSIX
atomic buffered IO semantics - we've just never decided that the
time is right to change the behaviour.

In making such a change to XFS, normal buffered writes will get
mostly the same behaviour as they do now because we now use high
order folios in the page cache and serialisation will be done
against high-order ranges rather than individual pages. And
applications that actually need atomic IO semantics can use
RWF_ATOMIC and in that case we can do explicitly serialised buffered
writes that lock out concurrent buffered reads as we do right now.

IOWs, there is no better time to convert XFS behaviour to match all
the other Linux filesystems than right now. Applications that need
atomic IO guarantees can use RWF_ATOMIC, and everyone else can get
the performance benefits that come from no longer trying to make
buffered IO implicitly "atomic".

-Dave.
-- 
Dave Chinner
david@fromorbit.com

