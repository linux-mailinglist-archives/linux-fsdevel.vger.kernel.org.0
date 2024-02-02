Return-Path: <linux-fsdevel+bounces-9949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ABF846614
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 03:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F07B23941
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 02:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E437C2D3;
	Fri,  2 Feb 2024 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNksMmYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D85847B
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842515; cv=none; b=MpPqoNDkHAeK6R8qCIWPfbGitzGbJCFtyf3aExFTCHEZ+l2nA26PinjQ8lL5/lrYrPxpn8nUJIFaaWC+561rFW8aTWekjzuHxxeaDxo3XFczkuQ6NCPgXLx+ZYR7skF+xGMHV1x21BrvAgstJRe7cuieP5GS6ZMWp5/ecyLc59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842515; c=relaxed/simple;
	bh=jX8V4J6he01iMdXztscH3gL+ZiT2xGSlH7VO2b3YRA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umVYdW1aTZ93GOXZ4j/D80rEwp96ixrr2sIB8cPt+d/ftU9o72T5+dsqcCe/Zbn4p9+umuuXbgHwlHE6SXLsLIj692N3THqkSpFOf9AvNgFNpP5XRXLuN7qizHwJfGGp8PqexeCWnOAWe9LOX7djiPLy/zhqb8S8tuwaKv38Ays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XNksMmYm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso20543431fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 18:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706842510; x=1707447310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z13JQPf9sQwxso1j5bT0m3SolbFlWDJreVTqe//zgDY=;
        b=XNksMmYmERlcareKCqGrL/t2gqbdt7572KXZvtbZJ6mZH3KpDzekHrk5pzSyfEPKh6
         xfiL8FUcE8qeyHP+WWKUKDYkaatphnSrDFgE64fFCQwsJoCwC0qfI8gJjf+Z0lmg8bQo
         0bnkNUxnZxnJySHWWL7iYlnrzxWKjWTyWEgxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706842510; x=1707447310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z13JQPf9sQwxso1j5bT0m3SolbFlWDJreVTqe//zgDY=;
        b=cOTUWiO4Jxj4eIbgmenzfdv5gG9MWOh52nB+xSybeiYqD6pkqG9/URsWySxpwpTGIK
         exE4Rf7pzjDcJJq89eOSfSQaeMuMrldplbjKCqJP+RWVRq4wCdpVBBkjrW1X/i7gf3Zg
         ScNyeN7uCc4k+70GgIh1Qnkcxl9yWjV5o4xzaPC/4lbrCslyswhwMFfQbLgeRhDeQrI9
         TIWlZShRAJll6XEf3j+nXQQHQUD37joPdSJ1f9rRgxFgizFbPBc1SZU8kFKLvqMuyc3L
         ujAFKwcdD7JuI2kxgH4u7iqahpEQrTu0Qh+yNiNdLHtYWCHb8NvVYByHSYmzGa1wq9Re
         O2cw==
X-Gm-Message-State: AOJu0YzueacItW6WN6hzxK+4hHKbcuch2tVjxEx5mI7Qio5ohsUIZ0Dq
	6tY2uzcVZOjQTI3gbfGyrzsh1UFwCgpXv/OoPJnDAhdIVjb+9BGtFoxm3YuUHEDut20HJOXVTRY
	29w==
X-Google-Smtp-Source: AGHT+IHz9G36CQy5UbRrXok6fbsXq2JBRR6n0CIz7172hs03e/NCZi4k5+DVYTezwynBo5+HhoEzNw==
X-Received: by 2002:a2e:ab0d:0:b0:2d0:698f:1fb with SMTP id ce13-20020a2eab0d000000b002d0698f01fbmr4642284ljb.5.1706842509614;
        Thu, 01 Feb 2024 18:55:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUsKnKvi38o5+AQ35BdOwdbHVj5yrVuU19hNtXHhg87xRBYpCLT8i4eQCezsfha48O2wYVw21rNCy5kncPG2iNHg1MPBkAPgeZjBiN4Lg==
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id wb6-20020a170907d50600b00a37026ef8e8sm192460ejc.18.2024.02.01.18.55.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 18:55:09 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fc5e5ed44so14805e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 18:55:08 -0800 (PST)
X-Received: by 2002:a05:600c:500c:b0:40f:c537:9d5 with SMTP id
 n12-20020a05600c500c00b0040fc53709d5mr30164wmr.5.1706842508094; Thu, 01 Feb
 2024 18:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV>
In-Reply-To: <20240202012249.GU2087318@ZenIV>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 1 Feb 2024 18:54:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
Message-ID: <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 1, 2024 at 5:22=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Feb 01, 2024 at 05:12:03PM -0800, Douglas Anderson wrote:
> > While browsing through ChromeOS crash reports, I found one with an
> > allocation failure that looked like this:
>
> > An order 7 allocation is (1 << 7) contiguous pages, or 512K. It's not
> > a surprise that this allocation failed on a system that's been running
> > for a while.
>
> >       if (size > regset->n * regset->size)
> >               size =3D regset->n * regset->size;
> >       if (!p) {
> > -             to_free =3D p =3D kzalloc(size, GFP_KERNEL);
> > +             to_free =3D p =3D vmalloc(size);
>
>         What the hell?  Which regset could have lead to that?
> It would need to have the total size of register in excess of
> 256K.  Seriously, which regset is that about?  Note that we
> have just made sure that size is not greater than that product.
> size is unsigned int, so it's not as if a negative value passed
> to function could get through that test only to be interpreted
> as large positive later...
>
>         Details, please.

I can continue to dig more, but it is easy for me to reproduce this.
On the stack is elf_core_dump() and it seems like we're getting a core
dump of the chrome process. So I just arbitrarily look for the chrome
GPU process:

$ ps aux | grep gpu-process
chronos   2075  3.0  1.1 34075552 95372 ?      S<l  18:44   0:01
/opt/google/chrome/chrome --type=3Dgpu-process ...

Then I send it a quit:

$ kill -quit 2075

I added some printouts for this allocation and there are a ton. Here's
all of them, some of which are over 256K:

[   66.677393] DOUG: Allocating 272 bytes
[   66.688994] DOUG: Allocating 272 bytes
[   66.692921] DOUG: Allocating 528 bytes
[   66.696799] DOUG: Allocating 8 bytes
[   66.701058] DOUG: Allocating 272 bytes
[   66.704988] DOUG: Allocating 528 bytes
[   66.708875] DOUG: Allocating 8 bytes
[   66.712929] DOUG: Allocating 272 bytes
[   66.716845] DOUG: Allocating 528 bytes
[   66.720721] DOUG: Allocating 8 bytes
[   66.724752] DOUG: Allocating 272 bytes
[   66.728719] DOUG: Allocating 528 bytes
[   66.732621] DOUG: Allocating 8 bytes
[   66.736615] DOUG: Allocating 272 bytes
[   66.740584] DOUG: Allocating 528 bytes
[   66.744483] DOUG: Allocating 8 bytes
[   66.748507] DOUG: Allocating 272 bytes
[   66.752412] DOUG: Allocating 528 bytes
[   66.756328] DOUG: Allocating 8 bytes
[   66.760382] DOUG: Allocating 272 bytes
[   66.764356] DOUG: Allocating 528 bytes
[   66.768275] DOUG: Allocating 8 bytes
[   66.772236] DOUG: Allocating 272 bytes
[   66.776135] DOUG: Allocating 528 bytes
[   66.780013] DOUG: Allocating 8 bytes
[   66.787244] DOUG: Allocating 272 bytes
[   66.791175] DOUG: Allocating 528 bytes
[   66.795056] DOUG: Allocating 8 bytes
[   66.799101] DOUG: Allocating 272 bytes
[   66.803007] DOUG: Allocating 528 bytes
[   66.806930] DOUG: Allocating 8 bytes
[   66.810775] DOUG: Allocating 272 bytes
[   66.814668] DOUG: Allocating 528 bytes
[   66.818544] DOUG: Allocating 8 bytes
[   66.822409] DOUG: Allocating 272 bytes
[   66.826328] DOUG: Allocating 528 bytes
[   66.830258] DOUG: Allocating 8 bytes
[   66.834331] DOUG: Allocating 272 bytes
[   66.838510] DOUG: Allocating 528 bytes
[   66.842399] DOUG: Allocating 8 bytes
[   66.846301] DOUG: Allocating 272 bytes
[   66.850181] DOUG: Allocating 528 bytes
[   66.854051] DOUG: Allocating 8 bytes
[   66.857864] DOUG: Allocating 272 bytes
[   66.861745] DOUG: Allocating 528 bytes
[   66.865621] DOUG: Allocating 8 bytes
[   66.869495] DOUG: Allocating 272 bytes
[   66.873384] DOUG: Allocating 528 bytes
[   66.877261] DOUG: Allocating 8 bytes
[   66.892077] DOUG: Allocating 528 bytes
[   66.895978] DOUG: Allocating 16 bytes
[   66.899760] DOUG: Allocating 264 bytes
[   66.903624] DOUG: Allocating 264 bytes
[   66.907489] DOUG: Allocating 4 bytes
[   66.911184] DOUG: Allocating 279584 bytes
[   66.915392] DOUG: Allocating 8768 bytes
[   66.919354] DOUG: Allocating 65552 bytes
[   66.923415] DOUG: Allocating 64 bytes
[   66.927190] DOUG: Allocating 16 bytes
[   66.930968] DOUG: Allocating 8 bytes
[   66.934649] DOUG: Allocating 8 bytes
[   66.938332] DOUG: Allocating 528 bytes
[   66.942199] DOUG: Allocating 16 bytes
[   66.945970] DOUG: Allocating 264 bytes
[   66.949832] DOUG: Allocating 264 bytes
[   66.953702] DOUG: Allocating 4 bytes
[   66.957385] DOUG: Allocating 279584 bytes
[   66.961605] DOUG: Allocating 8768 bytes
[   66.965574] DOUG: Allocating 65552 bytes
[   66.969632] DOUG: Allocating 64 bytes
[   66.973405] DOUG: Allocating 16 bytes
[   66.977179] DOUG: Allocating 8 bytes
[   66.980862] DOUG: Allocating 8 bytes
[   66.984553] DOUG: Allocating 528 bytes
[   66.988416] DOUG: Allocating 16 bytes
[   66.992191] DOUG: Allocating 264 bytes
[   66.996046] DOUG: Allocating 264 bytes
[   66.999907] DOUG: Allocating 4 bytes
[   67.003590] DOUG: Allocating 279584 bytes
[   67.007773] DOUG: Allocating 8768 bytes
[   67.011732] DOUG: Allocating 65552 bytes
[   67.015789] DOUG: Allocating 64 bytes
[   67.019576] DOUG: Allocating 16 bytes
[   67.023366] DOUG: Allocating 8 bytes
[   67.027059] DOUG: Allocating 8 bytes
[   67.030753] DOUG: Allocating 528 bytes
[   67.034620] DOUG: Allocating 16 bytes
[   67.038402] DOUG: Allocating 264 bytes
[   67.042266] DOUG: Allocating 264 bytes
[   67.046144] DOUG: Allocating 4 bytes
[   67.049827] DOUG: Allocating 279584 bytes
[   67.054026] DOUG: Allocating 8768 bytes
[   67.057990] DOUG: Allocating 65552 bytes
[   67.062050] DOUG: Allocating 64 bytes
[   67.065826] DOUG: Allocating 16 bytes
[   67.069603] DOUG: Allocating 8 bytes
[   67.073285] DOUG: Allocating 8 bytes
[   67.076977] DOUG: Allocating 528 bytes
[   67.080836] DOUG: Allocating 16 bytes
[   67.084605] DOUG: Allocating 264 bytes
[   67.088461] DOUG: Allocating 264 bytes
[   67.092328] DOUG: Allocating 4 bytes
[   67.096015] DOUG: Allocating 279584 bytes
[   67.100214] DOUG: Allocating 8768 bytes
[   67.104182] DOUG: Allocating 65552 bytes
[   67.108245] DOUG: Allocating 64 bytes
[   67.112028] DOUG: Allocating 16 bytes
[   67.115804] DOUG: Allocating 8 bytes
[   67.119487] DOUG: Allocating 8 bytes
[   67.123168] DOUG: Allocating 528 bytes
[   67.127027] DOUG: Allocating 16 bytes
[   67.130806] DOUG: Allocating 264 bytes
[   67.134662] DOUG: Allocating 264 bytes
[   67.138527] DOUG: Allocating 4 bytes
[   67.142213] DOUG: Allocating 279584 bytes
[   67.146402] DOUG: Allocating 8768 bytes
[   67.150378] DOUG: Allocating 65552 bytes
[   67.154434] DOUG: Allocating 64 bytes
[   67.158209] DOUG: Allocating 16 bytes
[   67.161980] DOUG: Allocating 8 bytes
[   67.165665] DOUG: Allocating 8 bytes
[   67.169355] DOUG: Allocating 528 bytes
[   67.173219] DOUG: Allocating 16 bytes
[   67.176989] DOUG: Allocating 264 bytes
[   67.180847] DOUG: Allocating 264 bytes
[   67.184710] DOUG: Allocating 4 bytes
[   67.188385] DOUG: Allocating 279584 bytes
[   67.192569] DOUG: Allocating 8768 bytes
[   67.196522] DOUG: Allocating 65552 bytes
[   67.200570] DOUG: Allocating 64 bytes
[   67.204340] DOUG: Allocating 16 bytes
[   67.208109] DOUG: Allocating 8 bytes
[   67.211788] DOUG: Allocating 8 bytes
[   67.215468] DOUG: Allocating 528 bytes
[   67.219332] DOUG: Allocating 16 bytes
[   67.223108] DOUG: Allocating 264 bytes
[   67.226968] DOUG: Allocating 264 bytes
[   67.230834] DOUG: Allocating 4 bytes
[   67.234510] DOUG: Allocating 279584 bytes
[   67.238697] DOUG: Allocating 8768 bytes
[   67.242660] DOUG: Allocating 65552 bytes
[   67.246716] DOUG: Allocating 64 bytes
[   67.250487] DOUG: Allocating 16 bytes
[   67.254261] DOUG: Allocating 8 bytes
[   67.257955] DOUG: Allocating 8 bytes
[   67.261640] DOUG: Allocating 528 bytes
[   67.265497] DOUG: Allocating 16 bytes
[   67.269267] DOUG: Allocating 264 bytes
[   67.273131] DOUG: Allocating 264 bytes
[   67.277026] DOUG: Allocating 4 bytes
[   67.280721] DOUG: Allocating 279584 bytes
[   67.284914] DOUG: Allocating 8768 bytes
[   67.288868] DOUG: Allocating 65552 bytes
[   67.292927] DOUG: Allocating 64 bytes
[   67.296699] DOUG: Allocating 16 bytes
[   67.300479] DOUG: Allocating 8 bytes
[   67.304158] DOUG: Allocating 8 bytes
[   67.307848] DOUG: Allocating 528 bytes
[   67.311702] DOUG: Allocating 16 bytes
[   67.315469] DOUG: Allocating 264 bytes
[   67.319331] DOUG: Allocating 264 bytes
[   67.323196] DOUG: Allocating 4 bytes
[   67.326879] DOUG: Allocating 279584 bytes
[   67.331067] DOUG: Allocating 8768 bytes
[   67.335033] DOUG: Allocating 65552 bytes
[   67.339089] DOUG: Allocating 64 bytes
[   67.342866] DOUG: Allocating 16 bytes
[   67.346641] DOUG: Allocating 8 bytes
[   67.350323] DOUG: Allocating 8 bytes
[   67.354005] DOUG: Allocating 528 bytes
[   67.357869] DOUG: Allocating 16 bytes
[   67.361636] DOUG: Allocating 264 bytes
[   67.365492] DOUG: Allocating 264 bytes
[   67.369355] DOUG: Allocating 4 bytes
[   67.373040] DOUG: Allocating 279584 bytes
[   67.377218] DOUG: Allocating 8768 bytes
[   67.381179] DOUG: Allocating 65552 bytes
[   67.385228] DOUG: Allocating 64 bytes
[   67.389005] DOUG: Allocating 16 bytes
[   67.392784] DOUG: Allocating 8 bytes
[   67.396461] DOUG: Allocating 8 bytes
[   67.400150] DOUG: Allocating 528 bytes
[   67.404011] DOUG: Allocating 16 bytes
[   67.407792] DOUG: Allocating 264 bytes
[   67.411649] DOUG: Allocating 264 bytes
[   67.415506] DOUG: Allocating 4 bytes
[   67.419184] DOUG: Allocating 279584 bytes
[   67.423364] DOUG: Allocating 8768 bytes
[   67.427320] DOUG: Allocating 65552 bytes
[   67.431367] DOUG: Allocating 64 bytes
[   67.435146] DOUG: Allocating 16 bytes
[   67.438923] DOUG: Allocating 8 bytes
[   67.442602] DOUG: Allocating 8 bytes
[   67.446286] DOUG: Allocating 528 bytes
[   67.450143] DOUG: Allocating 16 bytes
[   67.453913] DOUG: Allocating 264 bytes
[   67.457775] DOUG: Allocating 264 bytes
[   67.461637] DOUG: Allocating 4 bytes
[   67.465323] DOUG: Allocating 279584 bytes
[   67.469501] DOUG: Allocating 8768 bytes
[   67.473463] DOUG: Allocating 65552 bytes
[   67.477511] DOUG: Allocating 64 bytes
[   67.481283] DOUG: Allocating 16 bytes
[   67.485056] DOUG: Allocating 8 bytes
[   67.488735] DOUG: Allocating 8 bytes
[   67.492428] DOUG: Allocating 528 bytes
[   67.496298] DOUG: Allocating 16 bytes
[   67.500072] DOUG: Allocating 264 bytes
[   67.503932] DOUG: Allocating 264 bytes
[   67.507803] DOUG: Allocating 4 bytes
[   67.511484] DOUG: Allocating 279584 bytes
[   67.515667] DOUG: Allocating 8768 bytes
[   67.519624] DOUG: Allocating 65552 bytes
[   67.523679] DOUG: Allocating 64 bytes
[   67.527447] DOUG: Allocating 16 bytes
[   67.531222] DOUG: Allocating 8 bytes
[   67.534907] DOUG: Allocating 8 bytes
[   67.538593] DOUG: Allocating 528 bytes
[   67.542458] DOUG: Allocating 16 bytes
[   67.546225] DOUG: Allocating 264 bytes
[   67.550090] DOUG: Allocating 264 bytes
[   67.553956] DOUG: Allocating 4 bytes
[   67.557634] DOUG: Allocating 279584 bytes
[   67.561818] DOUG: Allocating 8768 bytes
[   67.565775] DOUG: Allocating 65552 bytes
[   67.569823] DOUG: Allocating 64 bytes
[   67.573602] DOUG: Allocating 16 bytes
[   67.577380] DOUG: Allocating 8 bytes
[   67.581060] DOUG: Allocating 8 bytes
[   67.584748] DOUG: Allocating 528 bytes
[   67.588607] DOUG: Allocating 16 bytes
[   67.592384] DOUG: Allocating 264 bytes
[   67.596240] DOUG: Allocating 264 bytes
[   67.600105] DOUG: Allocating 4 bytes
[   67.603786] DOUG: Allocating 279584 bytes
[   67.607968] DOUG: Allocating 8768 bytes
[   67.611927] DOUG: Allocating 65552 bytes
[   67.615979] DOUG: Allocating 64 bytes
[   67.619757] DOUG: Allocating 16 bytes
[   67.623529] DOUG: Allocating 8 bytes
[   67.627216] DOUG: Allocating 8 bytes

The above printouts were taken on a sc7180-trogdor-lazor device
running mainline (roughly "Linux localhost 6.8.0-rc2") booted w/
ChromeOS userspace.

If you need me to dig more into how coredumps work then I can see if I
can track down exactly what part of the coredump is causing it to need
the big allocation. "chrome" is a bit of a beast of an application,
though. I'd also note that chrome makes extensive use of address space
randomization which uses up huge amounts of virtual address space, so
a shot in the dark is that maybe that has something to do with it?
Looking at the virtual address space of Chrome in "top" shows stuff
like:

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
COMMAND
 2012 chronos   12  -8   32.7g 230520 160504 S   1.0   2.9   0:12.49
chrome
 6044 chronos   12  -8   32.5g  95204  61888 S   1.0   1.2   0:05.90
chrome
 2191 chronos   12  -8  107.0g  72200  51264 S   0.0   0.9   0:00.08
chrome

-Doug

