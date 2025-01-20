Return-Path: <linux-fsdevel+bounces-39664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049BA16B88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B703E188428C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 11:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412B1DF252;
	Mon, 20 Jan 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF9cHWGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D51DF248
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372455; cv=none; b=QJdZDsJBU8N/aYtKOweWjGNfeDgKrugo5Dvb2wj2fTFYkSfparEakQjmjxSfOmyKIbEllP129ySTUBrnYxIEPLy4Boyo0Wew3k4qO2q5SS1ic2PMlw08Xrkbzv3+57m/pYvHs8jDXIOmIZHHpN3aMkIRaC5UnTr4Iwxxju+VTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372455; c=relaxed/simple;
	bh=eDzPK2Bm2PFmDC/i1fKDiiNiM0ZATZasOPEgFiZV8Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzowj1zbSUlLc6UAtfXi/E9ShNXPmFVKvU0PSZdtRKu5T5dfC6VXV9zZCoV5INZ2XV1IDGBYdv9eLLaAN6uxNqa/Snn4cScpnKzwJwo4Xb9/uWO2ByKXSGMOJ/0RxPE4rcGtPvhxNkFktggfy78JJAi12c1GT/RkRt036Bp79hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF9cHWGf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso9028790a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 03:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737372452; x=1737977252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g1J734iUT/E12Vp8hXExUgs1BjaEHBnMERq/1efVWRM=;
        b=EF9cHWGfmM3kNKYFSsFFYytEY2bBVZSupgNUAWF4nr4gcuUpPQGy2+r/77QUJ13cnN
         9NutCE1PejVsSlXMSGuKwtWhUbQZ49GRNS+ZaRudetjRJIkmwj9lZZ9c8CFyqNXwp/X6
         E6sKJVlttxGE8PWJQICL0P39hJtzRjcnyVqjQWeFkg76edq6gwOj/iyc9yaBeMOSA+ey
         amdJGEzz9bd4j5OYB9exNuo6ebPdLNXiUQddhT/sWEhysYZMy8EUkLEghzwUSzYm3UB5
         RzZJE7IzAigB6W9I56ofZSsJaHGUvtJppOLAAaClUu1bnT01QyXQccUbwG+wbhvDRDSV
         8LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372452; x=1737977252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1J734iUT/E12Vp8hXExUgs1BjaEHBnMERq/1efVWRM=;
        b=InS3qLUmrPvR0PpIKKtbQvA1i4UtrGKufzuA31SwKI9KnPKh5D6/RKjipAdPDda/z2
         VUpI/FitBdjtRbzyhHYy7p5COrtdyaLM7cue5GHvqTF86P991UcTIT1OGMlLdKN3/dI3
         rK2/2/2hc182Rbj6Keru1IxJM6C41vS3F0zymtfQEg1YV83MEcT5FuyT1fO64xLOr3/U
         KDEH/Haam7cIBvn6YctaUQKppg618rFX0hlml2KBApesSQSdwiItIt8dU62jV07zCI0A
         H39hkgT0nAkDOQ9wYBFVfR99AhPkvVMZLBkQoxukBZxdmL5LTbs2547UFUw8jZumArZt
         2c4A==
X-Forwarded-Encrypted: i=1; AJvYcCXvvtYDxU/pXaU1FCUvgA023FxITfgipysTNUeML2RL+64+vZ4Npyl8PZKAoysTkvBqU055WtB3d+ZLZCrz@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXbsosyzliKDnCnp+XACaw1pVbvrfkSv/5sn6oouZWYSGpiec
	DqEBevt05q8g3JpycwFfJ0s6aHKWE7yGCNikME8HcAzIZOWFZvXGjzF7qA==
X-Gm-Gg: ASbGncv/X6TSZYuc11QXTDlsQqne8E2HyOTZoDL+nvi6YCLd6MtyZZr+3Bb78+TnBzc
	6KWqmo8tolIsreJ57fx2+g2h3EELeY5dahJojw0MQiWYEuzbtxKSXnOjd9pOWXAsBxT3lHKu39w
	oMN8ejmWnvr+18NfmRsUG7JKlDUhcWvYy7zCWcdLkBaUGdsFAPeLBnmEGCZ/Lqr6UXMkPin4oLe
	bsdj+9wg34zIXRgICxoqJ3nuSTp53Ps77aJQxxHIhRE1F85ShLSiqEzQgfKkFJ7EKTrPybYk3O6
	DFW8b9nYBw==
X-Google-Smtp-Source: AGHT+IHg8PVEZ7sSOuGkt6DK06J/HPz2kSh6wF71+iUn0z+46bcE5+bmmgzLL1yrdZHbDhy3Rw1fXQ==
X-Received: by 2002:a05:6402:51cf:b0:5db:68ce:2125 with SMTP id 4fb4d7f45d1cf-5db7d2fe208mr11811411a12.14.1737372451798;
        Mon, 20 Jan 2025 03:27:31 -0800 (PST)
Received: from f (cst-prg-69-191.cust.vodafone.cz. [46.135.69.191])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73683e1asm5435955a12.39.2025.01.20.03.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:27:30 -0800 (PST)
Date: Mon, 20 Jan 2025 12:27:21 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Christian Brauner <brauner@kernel.org>, WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [pipe_read]  aaec5a95d5:
 stress-ng.poll.ops_per_sec 11.1% regression
Message-ID: <leot53sdd6es2xsnljub4rr4n3xgusft6huntr437wmaoo5rob@hhbtzrwgxel2>
References: <202501201311.6d25a0b9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202501201311.6d25a0b9-lkp@intel.com>

On Mon, Jan 20, 2025 at 02:57:21PM +0800, kernel test robot wrote:
> we reported
> "[brauner-vfs:vfs-6.14.misc] [pipe_read]  aaec5a95d5: hackbench.throughput 7.5% regression"
> in
> https://lore.kernel.org/all/202501101015.90874b3a-lkp@intel.com/
> but seems both you and Christian Brauner think it could be ignored.
> 
> now we captured a regression in another test case. since e.g. there are
> something like below in perf data, not sure if it could supply any useful
> information? just FYI. sorry if it's still not with big value.
> 
> 
>       9.45            -6.3        3.13 ±  9%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
> ...
>      10.00            -6.5        3.53 ±  9%  perf-profile.children.cycles-pp.pipe_read
>       2.34            -1.3        1.07 ±  9%  perf-profile.children.cycles-pp.pipe_poll
> 
> 

Whatever the long term fate of the patch I think it would be prudent to
skip it in this merge window.

First two notes:
1. the change only considers performing a wake up if the current
source buf got depleted -- if there is a blocked writer and there is at
least one byte in the current buf nothing happens, which is where the
difference in results is coming from
2. stress-ng is not really a microbenchmark suite. it is more of a "do
stuff, some of which may accidentally line up with isolated behavior
from real workloads and return ops/s". plenty of it does not line up
with anythinig afaics (spoiler for tee improvement below).

So, I had a look on a 24-way system and results are as follows.

1. tee (500% win)

It performs tee/splice of a huge size along with 16 byte reads from
another worker.

On a kernel without the change this results in significant lock
contention as the writer keeps being woken up, whereas with the change
the bench gets to issue multiple reads without being bothered (as long
as there is any data in the buf).

For a real program this is more of a "don't do that" kind of deal imo,
so I don't think this particular win translates to a real-world benefit.
(modulo shite progs)

2. hackbench (7.5% loss)

lkp folk roll with 128-way system and invoke:
/usr/bin/hackbench -g 64 -f 20 --process --pipe -l 60000 -s 100

Oleg did not specify his spec, I'm guessing 4 cores * 2 threads given:
hackbench -g 4 -f 10 --process --pipe -l 50000 -s 100

I presume the -g parameter got scaled down appropriately.

So I ran this on 24 cores like so:
hackbench -g 12 -f 20 --process --pipe -l 60000 -s 100

to match

This is spawning a massive number of workers (480 in my case!) and there
is tons of lock contention (go figure).

I got a *massive* real time difference:
23.63s user 270.20s system 2312% cpu 12.71s (12.706) # without the patch
30.40s user 406.97s system 2293% cpu 19.07s (19.069) # with the patch

According to perf there is a significant increase in time spent
performing wake ups by the writer, while the reader is spending more
time going off/on cpu in the read routine.

I think this makes sense -- on a kernel without the patch you are more
likely to get extra data before you drain the buffer.

As for the specific difference in performance, per the above all this is
massively contended and the wake ups are going to alter which locks are
contended to what extent at different scales.

I fully concede I'm not all confident hackbench is doing anything
realistic, but I'll also note waking up a writer to get more data seems
to make sense.

To sum up, the win was registered for something which real programs
should not be doing. Seeing the loss in other benches, I think it would
be best to just drop the patch altogether.

