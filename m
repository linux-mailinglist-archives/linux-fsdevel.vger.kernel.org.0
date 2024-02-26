Return-Path: <linux-fsdevel+bounces-12899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061398684C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 00:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7211C1F21FF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319E135A50;
	Mon, 26 Feb 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M0qQsVEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8A1E878
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991338; cv=none; b=mFEuuu6F2Hj7H9PoLVPCN4NRYMyqu5FJf44xVsncebhZTcmqZe6AYn0I4LdivQ9pTPSPVygCcQvKffYlxLhyioBZ+iJ1PeW0U2tc6IWcFZF4n/l+DREVlkI7DDQoRJYob8ufj2Jn3MClCa+OW2AeRdpFJMyQ0N5LnW5ib6cc+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991338; c=relaxed/simple;
	bh=b8Ja75Q68+pmfpfTG4cLwxjUJWqqGbNj3dSkf24Z1Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKg4xHnYP79KuuMY1ZIjr92RTwXDuU/pU40AsaN4fQADs50E5stEgI0iJ1utR23D4FBTLsHEYPmGe4deASf6y6MiY7xOKdyekJpyI/opKoEDHyRbO7c38jqw/my2DxBJL9LLs641fFMOu5j0nmniL++rcktrJMlPITMIfc5MSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M0qQsVEi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512b13bf764so4548556e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 15:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708991334; x=1709596134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SYfl+v2OzAJpVUFUvJIQ4ltKHlEy4WHz/kYWr9Yc7PE=;
        b=M0qQsVEiLP53NzhiLpeufKKSN3pu2iTrv7uaFbxu8pfa/OyRhFlpjod34brrF1A0tS
         2hi1/ZcLmd0nckFfGruvwNg1N6PUXbCZZ+iPE0atZLicaM2AhFPkQMajs4lqDzdSdOAo
         X09RX715iPxQND/Eq8fhpYPI3P1It24MGjEbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991334; x=1709596134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYfl+v2OzAJpVUFUvJIQ4ltKHlEy4WHz/kYWr9Yc7PE=;
        b=hR+xviLlA0/QiTwsh3l2RGvxVnMINYwoStddaPYDdxjTg6EF56K1a9CWMrrnZH9cpH
         w8/5OSWuavB9c8Ny4MMKUCsRJeYseLVrX2IAV6Yos1ufg3/s7kH7GEAPSIInVu8TmTZi
         /JhB2uUrLp/33yEd8x+Yjszyl/99Y/2bN5ot9evg9OH2MR+mCLQT7Wd+KJ59XjwHJUQr
         MrULjjWBmcx3PJcLyDh24NdoKK7t4nzTnmAlMvrRmagBoNEbQAtuqPSWf10FMnoBwY8x
         92mZrzcTLdE4JxZzJbUMvQp+0pBoSPh0LS301e0ZOLAtx1kE2T8II8kkm4LidSMIp5Gr
         CEEg==
X-Forwarded-Encrypted: i=1; AJvYcCVd6F/jM0qOLxNTC5V1hdw+/dqngeepARoLlam7E4nZxmUd0VTWn3BDX43Id+hoctWPZBHuXeKrvyT1A2cWUxoBktWhIN8n7l1Pp/Sbqw==
X-Gm-Message-State: AOJu0Yz+Fs8Ez/QW4/Fs7BClp7FQvnVtqaLs7qYsalLC6a/0hWBuuF2n
	hQe8EXiBG/pbZKUvI7WJgOtU+x+2QLxl3UDsmLgfTszfutfVwWBnHXExAOM5H0TEVZTLBMzzb6R
	1jJjL0Q==
X-Google-Smtp-Source: AGHT+IE/ITwOhhxtAplQPQelsq0oQft7gBS/4QfFvd+qDiqyUGv56gEXVfAzDnWEViyyxxmGNnf89Q==
X-Received: by 2002:a05:6512:3195:b0:512:ff21:294f with SMTP id i21-20020a056512319500b00512ff21294fmr2732690lfe.8.1708991334174;
        Mon, 26 Feb 2024 15:48:54 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906560b00b00a3fd98237aasm199015ejq.156.2024.02.26.15.48.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 15:48:52 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so4786319a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 15:48:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0/qkJC3KP1SDUMV2x1zDoa1cLhgrvujaUKiVpUJHunBdiuEZk3y3NMcopjflMHTxGN879S9m3A4+1nBajVNEVPv3eoqPHhynb1ZRaWA==
X-Received: by 2002:a17:906:f894:b0:a3e:72ca:700d with SMTP id
 lg20-20020a170906f89400b00a3e72ca700dmr5330908ejb.45.1708991332329; Mon, 26
 Feb 2024 15:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org> <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org> <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home> <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
In-Reply-To: <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Feb 2024 15:48:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com>
Message-ID: <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Al Viro <viro@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 14:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I really haven't tested this AT ALL. I'm much too scared.

"Courage is not the absence of fear, but acting in spite of it"
         - Paddington Bear / Michal Scott

It seems to actually boot here.

That said, from a quick test with lots of threads all hammering on the
same page - I'm still not entirely convinced it makes a difference.
Sure, the kernel profile changes, but filemap_get_read_batch() wasn't
very high up in the profile to begin with.

I didn't do any actual performance testing, I just did a 64-byte pread
at offset 0 in a loop in 64 threads on my 32c/64t machine.

The cache ping-pong would be a lot more noticeable on some
multi-socket machine, of course, but I do get the feeling that this is
all optimizing for such an edge-case of an edge-case that it's all a
bit questionable.

But that patch does largely seem to work. Famous last words. It really
needs a lot more sanity checking, and that comment about probably
needing a memory barrier is still valid.

And even then there's the question about replacing the same folio in
the same spot in the xarray. I'm not convinced it is worth worrying
about in any reality we care about, but it's _technically_ all a bit
wrong.

So I'm throwing that patch over the fence to somebody that cares. I
_do_ now claim it at least kind of works.

                Linus

