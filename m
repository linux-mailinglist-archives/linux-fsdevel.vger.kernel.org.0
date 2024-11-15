Return-Path: <linux-fsdevel+bounces-34991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1EC9CF956
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 23:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E82F28913E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 22:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8671FBF6C;
	Fri, 15 Nov 2024 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g9Esy8lh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DC1FA245
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707579; cv=none; b=e/9MNkgITFrdgWPGMer0E8y1cagljjFth0LwLyOK01Ly5/ouPWr1bLtFvp4IkKshckUK9amY1nEldLp5KUr0zME9F/28K1D5BKQ+GNcnVl5tnCMFpEMnaNaSa9UQttHyTfwqJTtVYujicpTYwfPslRIWybLkX6WK5+sWBPfNg7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707579; c=relaxed/simple;
	bh=xJk/BcdRzWe6ICvZ9gofFe3EjqYDxSBU9hOxLvFFAy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OO0nmAKRQzGAe45ACIzmlyUhcdQhjZ0+lLmpqFPUQiEMOlBOaJhRdedu1irKAn3SAKK/A668TZt1GieHmv82dBLmN1OhMJGiHEMaBL1FkaAX1M/Oer0RJzGlMM+Rtlv02M8RRC0v9H9k6zx2T9gHkCs53Yi7vQc/wDlMtyKGDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g9Esy8lh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so3771196a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 13:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731707575; x=1732312375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wRnTlCaiEoX1K58fP8Is31Sc5LhfQsndshqNEhm1YFU=;
        b=g9Esy8lhH3vV3ZLnC17UrDT3b31j/Zf4tSXcpbSseSZNv5NCLSxUk1j90bZN/cdCZe
         QdxkAQ1+j+LTalRzygmMIJtJAimahKx8SgqO5/ifK+n31ZiHBwq736ycviFD7v2VF4dj
         5vWDFIQJ84ak9gtakyHovlhnHHwHUybfaqGc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707575; x=1732312375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRnTlCaiEoX1K58fP8Is31Sc5LhfQsndshqNEhm1YFU=;
        b=SqjycPy+xQxFQfcyJ8DJSu4cJGhdFncXNISHbNgZ7CoKA2b6ZdLMknMyB+N+TaKmXk
         xtSauMAjE/cI4mEM0lKCwymSnUfLLls7PML7PPmDsifLIkS+sJjRU4vAUIpsIJ3FLQWC
         fCs80OOeRhVe2uyHlZO5k6U44rIZe688rRUBQG0FGeT7X699QGJMmHlq02H6Z8Q5tAmE
         qyxZjyq3Cwal2kMf5B5z2evFy2CFtPLyXNActSsE/VfZD9NeaLMv12aJvGZPGhynwQOY
         6/l2mD5JeU4f/WdkLfhtvg1gsFbONe4jnilub7DmMRDN8Fu5JFP8xmD7QCBOHUxMfd3I
         i+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsjLmUkQo3A9fnbcA3Pp09YvVqY2D3t+o7fUskbDksMnxSsG+5ar6UCrUd0E1rxa2+BZzdzxfgq987xqj/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1lBeKs6gFdGHbvceh3g8JDkM9g9bD/uvLHAckvEEPqqj2nDzL
	q8GcUr0ES5hi1IXbkghkkfRSWAOFmvN33ZkvOEno+NiEBfj/Wu5Bmt30NhGht8MUPTx403l9pEC
	qhxs=
X-Google-Smtp-Source: AGHT+IG1BNn7hRB94QSKagNxxfm7u5vVFoSzXQvFPNKrRidglBO4LJDXiWUvE4yYuM32qP46Xs6DNw==
X-Received: by 2002:a05:6402:254c:b0:5cf:76d4:581a with SMTP id 4fb4d7f45d1cf-5cf8e0084damr3903588a12.12.1731707575526;
        Fri, 15 Nov 2024 13:52:55 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79ba2cccsm1944197a12.34.2024.11.15.13.52.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 13:52:53 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa20944ce8cso421544766b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 13:52:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVASAjbXGBhp5f+mYXKi2Vy2ThV4FzKC9DTjMozWlQfJtWY5vpQmfnv9yN+LHMD+p6osjsTCd0jJHjfc7Go@vger.kernel.org
X-Received: by 2002:a17:906:ee8a:b0:a9a:cf0:8fd4 with SMTP id
 a640c23a62f3a-aa4819060e9mr447528566b.18.1731707572170; Fri, 15 Nov 2024
 13:52:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org> <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home> <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
 <ZkNQiWpTOZDMp3kS@bombadil.infradead.org> <CAHk-=wgfgdhfe=Dw_Tg=LgSd+FXzsikg3-+cH5uP_LoZGJoU0Q@mail.gmail.com>
 <ZzeySEN5BYOuHsFG@casper.infradead.org>
In-Reply-To: <ZzeySEN5BYOuHsFG@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Nov 2024 13:52:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgb0Fuky7fpUw8mG=vFb6EoXDP+GAvvBWkfU=w4-KwO_A@mail.gmail.com>
Message-ID: <CAHk-=wgb0Fuky7fpUw8mG=vFb6EoXDP+GAvvBWkfU=w4-KwO_A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Al Viro <viro@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 12:42, Matthew Wilcox <willy@infradead.org> wrote:
>
> I don't think you need it:

D'oh!

I think I was even aware of that originally, but now that I rebased it
I just did a mindless "what's the difference between the fast-path and
the slow path" thing.

The other case I noticed - but ignored - is this part of the slow case:

                /*
                 * i_size must be checked after we know the pages are Uptodate.
                 *
                 * Checking i_size after the check allows us to calculate
                 * the correct value for "nr", which means the zero-filled
                 * part of the page is not copied back to userspace (unless
                 * another truncate extends the file - this is desired though).
                 */
                isize = i_size_read(inode);
                if (unlikely(iocb->ki_pos >= isize))
                        goto put_folios;
   ...

                /*
                 * If users can be writing to this folio using arbitrary
                 * virtual addresses, take care of potential aliasing
                 * before reading the folio on the kernel side.
                 */
                if (writably_mapped)
                        flush_dcache_folio(folio);

but I thought that the truncate case shouldn't matter - because a
truncate can still happen *during* the copy - and the second case is
not relevant on cache-coherent architectures.

In fact, now I looked at generic/095 some more, and as far as I can
see, that fio script doesn't do any small reads at all!

Which makes me even more confused about how it was affected by this
change? Funky funky.

But maybe that file size check. Because clearly there *is* some
difference here, even if it has worked for me and it all looks
ObviouslyCorrect(tm).

Oh well. Maybe in another 9 months I'll figure it out. I'll keep the
patch in my pile of random patches.

                Linus

