Return-Path: <linux-fsdevel+bounces-13014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C2B86A2BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DD7287F55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF5755783;
	Tue, 27 Feb 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="t2XP7b8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337055794
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073726; cv=none; b=BARmI+//mkjutfTvbonNk4Apo+NHnNavfblIj3+i26TnxaNTAvZnKzX5xAMKxFgHheh8L67H4bq47TuXTcVCUoTss08T4U5nCKipXnbZEeAowIRuGvSV2+oe+KwNMpOCzNHsynVWVLdunrWr0hSxL36ZRLcAWZJt2SFFSbmYYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073726; c=relaxed/simple;
	bh=xj4FZlqaSc/mNGDagn5sOeg7NWBVB4lVU3yd5MXUGQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGIGR3IKwfjAlVNsQgCoOYUjkKS8MnntKyCRn1XYqdhq0p/rv8a8VQOd7DkC1jq00yT7z0pOYcI1YXuOfmh9DmOPdkkAhEBxuIHb61QtsPoNzwyzfStieAIQtrXjak+0sXm65xNHvW/+u+FF47Dp38YpLhrQl0qx1jfGsISQLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=t2XP7b8D; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e558a67f70so484443b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 14:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709073724; x=1709678524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkVksek+2Yokv9SQLRuuk3Z/l3ApyoSU2xNBGzr2QoI=;
        b=t2XP7b8DL2f4wkIPZb5s1Xj0ZVIVGeDbn0cO+L1q/z39sjt4IzyueGONDvCWOVTvyL
         6iFoZHwvXilsfCsEn9ULBJts+djeG4ZJqrpbdXLKKps/v8txiI9wQtSogO1Pw+7+L668
         1l+05BCnnbScX73R9a/hhnWw1iLYAcYMmqBpkHUK6HpNCLVU4C27r3irvR75jNVc7Wn4
         +kJQD+P+VodMQnRJd6AOhlX4vJ+J6HcPE1y+8ShiapZCEeidMyOLcTZOdEntX0replGI
         wQf/uB1+hesSeIIzNLtBms9GgSqRNZT2+/aPeONoCLnY9NX7j2QXVfiuue7LAJYPyfU+
         Wz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709073724; x=1709678524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkVksek+2Yokv9SQLRuuk3Z/l3ApyoSU2xNBGzr2QoI=;
        b=iFs52VLtydo1frl315J35s5fRfi6fcrj+whMz9HSjaaDcvZE1xkPB69Ahtj/I2aI5H
         1o/SHhMoOXanmZj56HTIH+x05t/ndidIaNhqJ5YaEfd0FSoe2cHqWwIY+A/5N7lmlz98
         sCQh0ozhjXe4/Bf3KbpO+rAViykoRk8WR3/y4s9UWH1JwO+RDs5qY5uf9XTWTdeSPADp
         vQmwxkzsEKPgEi2bP3Ia1GfOxyC6b9ss0AEUJH/h4qk32oL2K/PiWF8G8aTu/FzR9z8e
         0g+f2h8qA/PC0LwnbgKCo7UqH0QmMb8sEnvNvMbdFYth5GbzvVP7f3pJUC/miDZzoDm4
         TecA==
X-Forwarded-Encrypted: i=1; AJvYcCWi4yzaNi71CjOpiT6u5hjwnNdRH63KqtyEJAx7TtIWq2DbB7rhZpnBDRvdihiZLoqZJ7MtpjcySFl1j3RLNfglRX99h5aSb2IfP6PrVA==
X-Gm-Message-State: AOJu0YymEBbl/JkBVV6o+265KgG80WZ8A19oMRM00uDkCBmz6p+pa+TS
	Un12nUyQQrBH53dyIFG4IYpMCh2bZiFZyi5FSHG9PBUIUoeqzJjsArAhKrt1EVgzCLhOkbU4L1P
	/
X-Google-Smtp-Source: AGHT+IFFtXjwcLeYcVGZxI2X1WW3ZNMqL4hDOXyIwEVmMtZ1cQNb7CfMoJ0bvGbR3GOiCqyhH+aU0w==
X-Received: by 2002:aa7:985c:0:b0:6e5:47b1:4f4d with SMTP id n28-20020aa7985c000000b006e547b14f4dmr2907156pfq.10.1709073724235;
        Tue, 27 Feb 2024 14:42:04 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id e13-20020aa7980d000000b006e1463c18f8sm6474261pfl.37.2024.02.27.14.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:42:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rf69B-00COjr-19;
	Wed, 28 Feb 2024 09:42:01 +1100
Date: Wed, 28 Feb 2024 09:42:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zd5lORiOCUsARPWq@dread.disaster.area>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>

On Tue, Feb 27, 2024 at 05:21:20PM -0500, Kent Overstreet wrote:
> On Wed, Feb 28, 2024 at 09:13:05AM +1100, Dave Chinner wrote:
> > On Tue, Feb 27, 2024 at 05:07:30AM -0500, Kent Overstreet wrote:
> > > AFAIK every filesystem allows concurrent direct writes, not just xfs,
> > > it's _buffered_ writes that we care about here.
> > 
> > We could do concurrent buffered writes in XFS - we would just use
> > the same locking strategy as direct IO and fall back on folio locks
> > for copy-in exclusion like ext4 does.
> 
> ext4 code doesn't do that. it takes the inode lock in exclusive mode,
> just like everyone else.

Uhuh. ext4 does allow concurrent DIO writes. It's just much more
constrained than XFS. See ext4_dio_write_checks().

> > The real question is how much of userspace will that break, because
> > of implicit assumptions that the kernel has always serialised
> > buffered writes?
> 
> What would break?

Good question. If you don't know the answer, then you've got the
same problem as I have. i.e. we don't know if concurrent
applications that use buffered IO extensively (eg. postgres) assume
data coherency because of the implicit serialisation occurring
during buffered IO writes?

> > > If we do a short write because of a page fault (despite previously
> > > faulting in the userspace buffer), there is no way to completely prevent
> > > torn writes an atomicity breakage; we could at least try a trylock on
> > > the inode lock, I didn't do that here.
> > 
> > As soon as we go for concurrent writes, we give up on any concept of
> > atomicity of buffered writes (esp. w.r.t reads), so this really
> > doesn't matter at all.
> 
> We've already given up buffered write vs. read atomicity, have for a
> long time - buffered read path takes no locks.

We still have explicit buffered read() vs buffered write() atomicity
in XFS via buffered reads taking the inode lock shared (see
xfs_file_buffered_read()) because that's what POSIX says we should
have.

Essentially, we need to explicitly give POSIX the big finger and
state that there are no atomicity guarantees given for write() calls
of any size, nor are there any guarantees for data coherency for
any overlapping concurrent buffered IO operations.

Those are things we haven't completely given up yet w.r.t. buffered
IO, and enabling concurrent buffered writes will expose to users.
So we need to have explicit policies for this and document them
clearly in all the places that application developers might look
for behavioural hints.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

