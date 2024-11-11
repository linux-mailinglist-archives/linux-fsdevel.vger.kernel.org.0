Return-Path: <linux-fsdevel+bounces-34255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A4F9C41D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29D51F2275B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745F819995D;
	Mon, 11 Nov 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Z5YvDeV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A71448C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338890; cv=none; b=TydCA+AZeGPyElPzYCOAmkY89rQ3MnlQ6Mqk/rF0D8KXIZBSxAzb22shO1DPYoS+FgJwhgFUidB8RjHrkY+6+GJWvhiqbS0BpBT6i9oeh6sGyUTuZRLXysLAWAKP4QM+vBcdeBl1/sKIMNUe3zDlLNYEgpj/4NodgWk5r0WYaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338890; c=relaxed/simple;
	bh=bVolD790eS8wJRjhwLfYhabvUEkTplDA3rT079vtujo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7NSM38aIlBTKa57un84Z7j1BSgoh/fmHzPt75XB1m53izKGJwK+WRXCxuJf2O3P9dyQ1BWSPdihB5Db2GpFipA4GSCCX+FlcsanrElujxjmK7l9fQP58UylIO1qALce/HJa3QfEm1opYGzAKpZc2LwrgyVUnydznbz1QvCUyoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Z5YvDeV2; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2e41bd08bso45771657b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 07:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731338887; x=1731943687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxN8UywOFghZU6AzFTlOcNaT/X7wEZEyobCiZroHA+s=;
        b=Z5YvDeV2HmWwMZlDaWBoftOMh6kJVR5SAWcFXBGWPmDWjPIhliNlKtibdgrvXoxfLN
         VratO1QPY6uYs+dzLDzcXpSNwe14iEO19LoKUhjuj6pkZgfUTMvj0b8CmOT2hChTkIbY
         sisRnTDTnuLH3nF92zMKnE2xU+PpYTjEFaJXmvPmphePaq8b/iPvps2E7yyUb9FOPrRw
         oY72QpgBcNUmxhI+mvmNTsnTgKdI0XIe6URWfm58LNKJXhopxS/vSjshfelaciaQJE2r
         RAoD6E3TunfL+82cG4ni8s9OsPwMW2YH05bO/Ky35wZrtcAkws29r38z8Rp+8P6DRQL1
         Nm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338887; x=1731943687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxN8UywOFghZU6AzFTlOcNaT/X7wEZEyobCiZroHA+s=;
        b=DZJHD2VDr9ZijxUwH7jAR1y0RWRPVOeC58Q1CE3NNcU3sIuIxXuHr8x/6cwAZoIu1/
         p83+/VDiuG3FwdbzLMLF6ruGPy2TjT2wtY6ccMtQit0IZl2koxHXSuLlgdp1eZLk4sLd
         tYSQsauPgozFocnbGxOxXCyyDnbsGGuSQEEsvfgZqs0x4kTldpWYGV6Td7pU1I1BGioB
         zYQbB0oWwZAkNQccECEJZcLzKuHlY4ygVr2qJevmBM3ZNr+asTR0+I5tYo+txnnKfcsg
         EOp3YWTapCnpm8fUWtVCNIeXHtqlKC0RhfOF4xtHeA2XBT3YKJ47I6g2gYBLvQrrTrk2
         vXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuJtoFylN9bnleoSLIdHyYtq0UaBO2eGRD9B892RlAyvArXL7tOAGH51sX3iRT/j6Bpzlkydw0xmFc/9sd@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsOn5JHjw5yEX6eL7DGB+zJ6ur4KOK0iFH/Wn0SP+JAcTk9DU
	pSHxl6yqxrdyNlvMv6y1aKVsv5k0F+p66KgTXsvT+AXIlWz6ubNsP9oyzh9GLLU=
X-Google-Smtp-Source: AGHT+IFDAg6OeLu4MciFcYx3Pmo0m16gZoqmW/uV00p36AIQvOnqRPaF+iYgQ5qxJ2tujGibKd3aeA==
X-Received: by 2002:a05:690c:6103:b0:6d5:90f:d497 with SMTP id 00721157ae682-6eadddbadb8mr112991027b3.19.1731338887679;
        Mon, 11 Nov 2024 07:28:07 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb65a75sm20360797b3.97.2024.11.11.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:28:06 -0800 (PST)
Date: Mon, 11 Nov 2024 10:28:05 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Karel Zak <kzak@redhat.com>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
Message-ID: <20241111152805.GA675696@perftesting>
References: <cover.1719257716.git.josef@toxicpanda.com>
 <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting>
 <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner>
 <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
 <20240625141756.GA2946846@perftesting>
 <CAJfpegs1zq+wsmhntdFBYGDqQAACWV+ywhAWdZFetdDxcL3Mow@mail.gmail.com>
 <CAJfpegs=JseHWx1H-3iOmkfav2k0rdFzr03eoVsdiW3rT_2MZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs=JseHWx1H-3iOmkfav2k0rdFzr03eoVsdiW3rT_2MZg@mail.gmail.com>

On Mon, Nov 11, 2024 at 02:12:16PM +0100, Miklos Szeredi wrote:
> On Wed, 26 Jun 2024 at 14:23, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, 25 Jun 2024 at 16:18, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > > But that means getting the buffer, and going back through it and replacing every
> > > ',' with a '\0', because I'm sure as hell not going and changing all of our
> > > ->show_options() callbacks to not put in a ','.
> > >
> > > Is this the direction we want to go?
> >
> > IMO yes.  Having a clean interface is much more important than doing
> > slightly less processing on the kernel side (which would likely be
> > done anyway on the user side).
> 
> So I went for an extended leave, and this interface was merged in the
> meantime with much to be desired.
> 
> The options are presented just the same as in /proc/self/mountinfo
> (just the standard options left out).  And that has all the same
> problems:
> 
>  - options can't contain commas (this causes much headache for
> overlayfs which has filenames in its options)
> 
>  - to allow the result to be consumed by fsconfig() for example
> options need to be unescaped
> 
>  - mnt_opts is confusing, since these are *not* mount options, these
> are super block options.
> 
> This patchset was apparently hurried through without much thought and
> review, and what review I did provide was ignored.  So I'm
> frustrated, but not sure what if anything can be done at this point,
> since the interface went live in the last release and changing it
> would probably break things...

My apologies Miklos, I value your opinion and your feedback.  Sending my mind
back to when we were discussing this I think it just got lost in the other
patchsets I was working on, and then it got merged so it was "ok that's done,
next thing."  That's my bad, I'll be more careful in the future.  Thanks,

Josef

