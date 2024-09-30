Return-Path: <linux-fsdevel+bounces-30406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3B98AC8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 21:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF43F283374
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 19:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBD8199E8C;
	Mon, 30 Sep 2024 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gJ/KxS1M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6tZgxkK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E44743AB0;
	Mon, 30 Sep 2024 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723615; cv=none; b=DhY8X8jZFJ79/PkHWcCud7hJ42upeh6m65ZIgqTG7GMP2FI+STabxSsJv0yA01309+iEuUS/+V4pMWQDqNODlkq/0gokaF6FAYN4SZS8CLxmytbYH3c4Nu4t8u8nCNfux4znfsiVVHt4wd6yVeoF+u7Hm9n6LmlaaTKetqThXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723615; c=relaxed/simple;
	bh=g9wTua1j7Rm8PkyuL03HXWc8qMSqSE7FD3GXzmwZQGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nh9qPWPaSwUQWBXc3KKvJxDfWe3R/QZk/+RYh95ZohrejEf3wKqmeP9vaG7RoZq9R8Xn5T8pnsT8NuAK0bhupBoIzqFOvZDhK9CI11J4SPDkHvWSkqCNZ3lY8ABQ+3ABgtDwYt/tBoZy2OM6etH4oyzg5hw3lI2ROUxV7McZ268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gJ/KxS1M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6tZgxkK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727723611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fFBOud7anAZyztkYeQWuXr4vYsC9F6E8D/HPnn/0BOg=;
	b=gJ/KxS1M9QBiD9jT7XM70vomQS8njPKEUEFPhzAr1j+v8H8tYnKZFu/E0imRNBPUn6wmQM
	63zxh87CjWjrcX8XeQp2CuaTKNGKsl9Gh0gmWMrzQhGuH5yRH7VBCaPq27hRMG/rtKfC1J
	NyA1NeSHi1DtWXEDZ1OBlegulrkgvwMNNFLReMPCu6H/lx5aE5d1Jyr+X1asET1BArubpi
	MzfGQLeV0JIL5UnJsvkdHXulEKCZVIi5t4GHKmVkC0+Qi/oAG5rELQYrnQotOTXfqsMOE8
	BRCV4t1BqGMBxTZeBO1nDDqTg11Iix2OEul8FtsHI0ok5j2ZOPlfZFTlS2xG8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727723611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fFBOud7anAZyztkYeQWuXr4vYsC9F6E8D/HPnn/0BOg=;
	b=u6tZgxkKVS2Jwn34typ3Qtq8h/7YSyYXitKctJvkyMHyOED4yEOoKXy+UnCqzMM3x56A1E
	YX6g2x7VODFL8aBw==
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Chuck Lever
 <chuck.lever@oracle.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, Jeff Layton
 <jlayton@kernel.org>
Subject: Re: [PATCH v8 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
In-Reply-To: <20240914-mgtime-v8-1-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-1-5bd872330bed@kernel.org>
Date: Mon, 30 Sep 2024 21:13:30 +0200
Message-ID: <87bk050xb9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Sep 14 2024 at 13:07, Jeff Layton wrote:

> For multigrain timestamps, we must keep track of the latest timestamp
> that has ever been handed out, and never hand out a coarse time below
> that value.

How is that correct when the clock is off by an hour and then set back
to the correct value? Then you'd get the same stale timestamp for an
hour unless something invokes ktime_get_real_ts64_mg() which will set
the "latest" timestamp back to a time before the previous one.

> Add a static singleton atomic64_t into timekeeper.c that we can use to
> keep track of the latest fine-grained time ever handed out. This is
> tracked as a monotonic ktime_t value to ensure that it isn't affected by
> clock jumps.

That's just wishful thinking.

ktime_get_real_ts64_mg(ts)
   ts = Tmono_1 + offset_1;   // TReal_1
   floor = Tmono_1;

                                // newtime < TReal_1                                
                                clock_settime(REALTIME, newtime);
                                   xtime = newtime; // TReal_2
                                   offset_2 = offset_1 + Treal_2 - TReal(now);
                                   --> offset_2 < offset_1

ktime_get_coarse_real_ts64_mg(ts)
    ts = tk_xtime();       // TReal_2
    offs = offset_2;

    if (Tmono_1 + offset_2 > ts)
       ts = Tmono_1 + offset_2; // Not taken

So this returns T_Real_2 because

    offset_2 < offset_1

and therefore

    Tmono_1 + offset_2 < TReal_2

so the returned time will jump backwards vs. TReal_1 as it should
because that's the actual time, no?

So if that's the intended behaviour then the changelog is misleading at
best.

If the intention is to never return a value < TReal_1 then this does not
work. You can make it work by using the Realtime timestamp as floor, but
that'd be more than questionable vs. clock_settime() making the clock go
backwards.

Thanks,

        tglx

