Return-Path: <linux-fsdevel+bounces-9282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A02A83FBEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 02:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A0628285C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 01:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E57ADF58;
	Mon, 29 Jan 2024 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2G3BDLap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04EDDC1
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492869; cv=none; b=KXKNiHFFRKzx0GsuGYLFdKP6VTwY0zEDU+50Pb1Xz1lkF3wQMn1xkXoIIM7TB/CyRDpRgypDKo5Ftl9XruEw9S2OSRsnCXpKBJ9ot/KXtul1nExDl9DPBnr/PyI8MEwlvUpZx0PcYkVP1W9iMUHRMota1XlJHgOyJbphGZkucT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492869; c=relaxed/simple;
	bh=LZpXrEqXUBZjxYKaP7iXfH75PEgXom/gvKUA5L2KGOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgAg3Jq6feomhN2KK5FIf7M2VnmzQqLA2hM7hJ+oU80rsa90QGxGP7kuNDQG7AP09mOKHrCWvCoZ+DghTrFNTMqEtSnv/0GkCOLRGDgvLWILqEQWTujPVrXwDhYau7aVbompdIpkVp5EQlY8x6WUBb1Qz+Hgzyns0LVrgguQtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2G3BDLap; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d73066880eso19038695ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 17:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706492867; x=1707097667; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/HXe1ZkYYO9fD1r0+7cwZjBt+if+SneUe0KqnaZMV1Y=;
        b=2G3BDLapJJRYmG8he6BHWioT/r75gg2Gw+k5eCmjM3jyCwMaTXdzB6FtRC5NbREqhP
         H5sbyadveC7rNVrjAbKlPltPcd63HMo8pBTv/eUPbUXAtu7AAvviBpJ0nu5ZKiJl/12w
         rhM0xVA5nAUY0jGZViAxhrcNeQ2G+zHZ6waY0xtEVfzD1A54XxwVCCbLG0bYYX/uMS1E
         nGEe6SbsRd5ex3fwJfIXfqK49KflqgqSozDyYIf7uSD1oo54tcByw5KmDnhOhnM46uDg
         rMi8BznmQRIjH0BuscQKXLufbzejxw7A8/hSne933wfUDO+T4b5eoAna3lH7BO0wkorl
         Feyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706492867; x=1707097667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HXe1ZkYYO9fD1r0+7cwZjBt+if+SneUe0KqnaZMV1Y=;
        b=eydEqrlijlUZN6Ix54UwOVlTc8jf97YPvvMIJavyTV3bC15EETKOfEyzR9WIQXzOL1
         QLxbub8w3TsS7WnyN15c1UMCT2hAAZi1dt01QlyPY6z8V4t5lXhAA2KJtwGU0E3ZMpLw
         o6aViwYgT5p2/y0T0gHWT9yriec0Jsx9av66VWNeCphNLfpqnesHapujZwzLl5BGgsQQ
         b0NtWXv0fs05PoCNQmTK4IECjv/iY9heSaXJhH28/fjW95wEDpt7lZD0co5sBmUCrBlE
         JqG7O2+J7U3e3nsrBUg2OH52TAiptWzLuxNIsCLjymPvU5zY4+fQpCj/3CQzMGwkadAY
         qASQ==
X-Gm-Message-State: AOJu0YybNHE7l24GHGJpSlczOl4TpByqHpcuOszQT4DsTUD9z5LBsPJ6
	dgTqPp9mDUVfVbLrvDPepY/pHN+52pzJJkAvm0zQMjwnVn57nvHQHIEZWrIqnls=
X-Google-Smtp-Source: AGHT+IEq3c3K1ygyW/CVEYqCz0nHDHcKikCupujYmvZwln17s4zPmpinqbh5fIhJ0e17Gfa+s7b+aA==
X-Received: by 2002:a17:902:d4c9:b0:1d8:c3be:8f10 with SMTP id o9-20020a170902d4c900b001d8c3be8f10mr3714366plg.46.1706492867567;
        Sun, 28 Jan 2024 17:47:47 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b001d8e974ed2fsm292730plb.284.2024.01.28.17.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 17:47:47 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rUGkP-00GfP7-0g;
	Mon, 29 Jan 2024 12:47:41 +1100
Date: Mon, 29 Jan 2024 12:47:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Ming Lei <ming.lei@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbcDvTkeDKttPfJ4@dread.disaster.area>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>

On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> On Sun, Jan 28, 2024 at 7:22 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> > > On Sun, Jan 28 2024 at  5:02P -0500,
> > > Matthew Wilcox <willy@infradead.org> wrote:
> > Understood.  But ... the application is asking for as much readahead as
> > possible, and the sysadmin has said "Don't readahead more than 64kB at
> > a time".  So why will we not get a bug report in 1-15 years time saying
> > "I put a limit on readahead and the kernel is ignoring it"?  I think
> > typically we allow the sysadmin to override application requests,
> > don't we?
> 
> The application isn't knowingly asking for readahead.  It is asking to
> mmap the file (and reporter wants it done as quickly as possible..
> like occurred before).

... which we do within the constraints of the given configuration.

> This fix is comparable to Jens' commit 9491ae4aade6 ("mm: don't cap
> request size based on read-ahead setting") -- same logic, just applied
> to callchain that ends up using madvise(MADV_WILLNEED).

Not really. There is a difference between performing a synchronous
read IO here that we must complete, compared to optimistic
asynchronous read-ahead which we can fail or toss away without the
user ever seeing the data the IO returned.

We want required IO to be done in as few, larger IOs as possible,
and not be limited by constraints placed on background optimistic
IOs.

madvise(WILLNEED) is optimistic IO - there is no requirement that it
complete the data reads successfully. If the data is actually
required, we'll guarantee completion when the user accesses it, not
when madvise() is called.  IOWs, madvise is async readahead, and so
really should be constrained by readahead bounds and not user IO
bounds.

We could change this behaviour for madvise of large ranges that we
force into the page cache by ignoring device readahead bounds, but
I'm not sure we want to do this in general.

Perhaps fadvise/madvise(willneed) can fiddle the file f_ra.ra_pages
value in this situation to override the device limit for large
ranges (for some definition of large - say 10x bdi->ra_pages) and
restore it once the readahead operation is done. This would make it
behave less like readahead and more like a user read from an IO
perspective...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

