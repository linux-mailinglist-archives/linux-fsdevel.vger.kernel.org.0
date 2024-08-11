Return-Path: <linux-fsdevel+bounces-25604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BC094E0DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 12:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28C71C20EDB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1894778E;
	Sun, 11 Aug 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPj/SF6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690F29424;
	Sun, 11 Aug 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371980; cv=none; b=UDIiel2hLtnjFDD5UeFToNdvtfKHV0usCtmMz3rRFEPt4BVyHY2WlQW7j5EMmqIv4O6p6ZqLepLXXhNzGIrnlxvw5M0fq64IzslA1Dny7A3NdLZSyigxT93SSm7wvfUYA0hWXu4A+fiBGUebiJ7BO56JAou6LLtKPfwF7DqCV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371980; c=relaxed/simple;
	bh=bVtr98yipMVm5ZW/Y7Uz7v1ggUCQfY66P81+XNP4Hsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R37UXAKs4XELSU1ICjUtkWL9y7xdaTAP07jp8RdpvxRFs3ZXHXGJzvfj4g9QrcwenZL8R6DxO7v88oCk+PhfebHTrlU6/deSpacwh3wHCSM/dq9GRn7g9dtcCM1aAOD11uFHBng9cuCJVbDamdFuxoPJOGkEQ3PZxbxdfGRW+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPj/SF6B; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso382585766b.2;
        Sun, 11 Aug 2024 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723371977; x=1723976777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vd3SJUymSlZS8+IMoCexkTM3rmrajYESCRBtWnJXnvE=;
        b=MPj/SF6BW+W/zkXUIeqLm/iQJYNQZQNlbzIdFkLAolCSMwL4HuLbwVsTWKxP7/kKH5
         ZlpfS6V3rhFnSGit34CvIEtTQH4dEo9eS6UcSwi1n0ybHKo5ap5xRFzYKK7A9GHH66qj
         26S1TP9S/oeggIObC65ARTeQKqdJx+BCMJ+44Fqc8nNHUAkoni9sgBMqka83z57HHoNV
         5wOfOw/J6OfWne3/owIlfk5m8eYckrqKsfSQbl7uX77lA9KD1BSsJMQsnxjKDkdwXLsB
         2417fgz4XYWVUkg4+gsWBWIj4Kan6r3/a96nAgdJglYpfMLqEqvcAQvPdj9vK/DBQG2q
         fxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723371977; x=1723976777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd3SJUymSlZS8+IMoCexkTM3rmrajYESCRBtWnJXnvE=;
        b=cvjTxT5gdBRsdEDfzNfmkIufGywNTaIe70Wnb5TjZCLRBYmyllSJHOhSxJJ6GsqRgC
         8wOobLmhVtvlljtrFVyUaGcFSmGlwri5Yx2XTepwV9wrVL7eTQB8uMtioIrHJ5NcMTzg
         yh54PbEI4WXIyzQbwJtaijBYqJZNH7flQkdTaFRtWebsxHmyT41pripUCFtI9UrCynGc
         ILNmtWrXNFWYHaPGG9mu/POg7cEs1jRoX92Rt3SZAsk7/rJGg4bsIVqpKe3xz9ZHq5WG
         wrU4m8qVdtyHgfcsaluSfSbbk7vtMZcOCR+ge9iKNXJJjF88jVjyRM5OnOuMsNrMFjI7
         WIxw==
X-Forwarded-Encrypted: i=1; AJvYcCXl9titJnutMbGFPoHjZJHF171YHiSwd+e8pHq/cwxNtIgdkUKLfFHZncS7FfTJ4GUU+6RRQNO8uAmhHV+SsinVY/9EP86RbgFYHvA+u0Ac9ZtJtY/ScBptPQ+z9L0T0j+nB7hSCakQlEo/Ug==
X-Gm-Message-State: AOJu0YyNW46g2yI1Z3FBwhI8FiBc2qX8WJe5bCV9YFuzT20iPtldXICV
	v7up4qU2EdeXl10LHoC3U0Un4ngCHYWEMwrLe2OZ5Jv0UxbgUWtf
X-Google-Smtp-Source: AGHT+IF+hOA9/Xmb/sbupzVTIccH1V+msEv51fDw1D0ozzvetYayA6wPWCFziw4xt7qNiDyOPv8LSQ==
X-Received: by 2002:a17:907:f716:b0:a7a:9d1e:3b26 with SMTP id a640c23a62f3a-a80aa5e56b0mr448195866b.37.1723371976318;
        Sun, 11 Aug 2024 03:26:16 -0700 (PDT)
Received: from f (cst-prg-72-52.cust.vodafone.cz. [46.135.72.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb24360dsm137586666b.199.2024.08.11.03.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 03:26:15 -0700 (PDT)
Date: Sun, 11 Aug 2024 12:26:02 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Dylan Yudaken <dylany@fb.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, 
	Dave Young <dyoung@redhat.com>, kernel test robot <lkp@intel.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] eventfd: introduce ratelimited wakeup for
 non-semaphore eventfd
Message-ID: <w7ldxi4jcdizkefv7musjwxblwu66pg3rfteprfymqoxaev6by@ikvzlsncihbr>
References: <20240811085954.17162-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240811085954.17162-1-wen.yang@linux.dev>

On Sun, Aug 11, 2024 at 04:59:54PM +0800, Wen Yang wrote:
> For the NON-SEMAPHORE eventfd, a write (2) call adds the 8-byte integer
> value provided in its buffer to the counter, while a read (2) returns the
> 8-byte value containing the value and resetting the counter value to 0.
> Therefore, the accumulated value of multiple writes can be retrieved by a
> single read.
> 
> However, the current situation is to immediately wake up the read thread
> after writing the NON-SEMAPHORE eventfd, which increases unnecessary CPU
> overhead. By introducing a configurable rate limiting mechanism in
> eventfd_write, these unnecessary wake-up operations are reduced.
> 
> 
[snip]

> 	# ./a.out  -p 2 -s 3
> 	The original cpu usage is as follows:
> 09:53:38 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 09:53:40 PM    2   47.26    0.00   52.74    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> 09:53:40 PM    3   44.72    0.00   55.28    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> 
> 09:53:40 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 09:53:42 PM    2   45.73    0.00   54.27    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> 09:53:42 PM    3   46.00    0.00   54.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> 
> 09:53:42 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 09:53:44 PM    2   48.00    0.00   52.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> 09:53:44 PM    3   45.50    0.00   54.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> 
> Then enable the ratelimited wakeup, eg:
> 	# ./a.out  -p 2 -s 3  -r1000 -c2
> 
> Observing a decrease of over 20% in CPU utilization (CPU # 3, 54% ->30%), as shown below:
> 10:02:32 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 10:02:34 PM    2   53.00    0.00   47.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> 10:02:34 PM    3   30.81    0.00   30.81    0.00    0.00    0.00    0.00    0.00    0.00   38.38
> 
> 10:02:34 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 10:02:36 PM    2   48.50    0.00   51.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> 10:02:36 PM    3   30.20    0.00   30.69    0.00    0.00    0.00    0.00    0.00    0.00   39.11
> 
> 10:02:36 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 10:02:38 PM    2   45.00    0.00   55.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
> 10:02:38 PM    3   27.08    0.00   30.21    0.00    0.00    0.00    0.00    0.00    0.00   42.71
> 
> 

Where are these stats from? Is this from your actual program you coded
the feature for?

The program you inlined here does next to nothing in userspace and
unsurprisingly the entire thing is dominated by kernel time, regardless
of what event rate can be achieved.

For example I got: /a.out -p 2 -s 3  5.34s user 60.85s system 99% cpu 66.19s (1:06.19) total

Even so, looking at perf top shows me that a significant chunk is
contention stemming from calls to poll -- perhaps the overhead will
sufficiently go down if you epoll instead?

I think the idea is pretty dodgey. If the consumer program can tolerate
some delay in event processing, this probably can be massaged entirely in
userspace.

If your real program has the wake up rate so high that it constitutes a
tangible problem I wonder if eventfd is even the right primitive to use
-- perhaps something built around shared memory and futexes would do the
trick significantly better?

