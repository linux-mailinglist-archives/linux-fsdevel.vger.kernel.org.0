Return-Path: <linux-fsdevel+bounces-19334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2478C8C33A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 21:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EC1281D2B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19241F95A;
	Sat, 11 May 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b2HoHFdO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED41CA82
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715457351; cv=none; b=oz67FfUMpuY0Ave+oXKyY7NoGcUL+6p3oQy6/0tqMjt8Mn9FWe1oh8SHPuBg20g+r5uT+roZCv5PPLkPYTrgWUcjTPs61S+AVOo4OpHsSftTo8OBYY1omXL30WRpSzWN4a+tAcc06rAnbo4s5DrgQcL+fQ6bkZ7JGiVieqXIqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715457351; c=relaxed/simple;
	bh=oKE4FSjS1GE7uiFKCsG9vtarDb+J6a6wv4pqt8sMec0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLEgB5Vy9DEh/84JOL9zMrnziCNYlzKnDqXHlTNFQ92zXkMTm16PZUPFhil+y/3HkeEbqkXKA+EnmAnNKpGLofhz0j790S5gaL+g8G9+VQ00tcWVjjIagcOF7pZFdelnqqlpSDje+jjQ1WWphUIh4qbEHuLrZRA8iIaktcNoQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b2HoHFdO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso760066966b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715457347; x=1716062147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yjy6WmJoVn9E+kA4H9Sma/A0Ytbh+24vWQ9Sxvg7z8o=;
        b=b2HoHFdOPi7Y0JsmjSycc2ucrNBvmaQTA8dvlXUvRM/bgyt05LwvIf9NymcMWsPI87
         SGlvnpdQzIBgQ7LceuptAkX+jaoyVPR7Eh9VXk/TNVPjmFfa/3Q6RZQT4N6qHEmJvgKU
         DQOfHL6aelpQF+KnDFXSjhGnMTR/if5b0RN1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715457347; x=1716062147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yjy6WmJoVn9E+kA4H9Sma/A0Ytbh+24vWQ9Sxvg7z8o=;
        b=WYwJZ4bSKFVrPSDhg2fSRYoN9ZjRAXYUH4wJJ+rs6UjuLTIhu8OqeuhzpDT3gXjJGb
         C8ow7HabSEDW2IE3UWEwfIjFTzv3ssNk/AdLWn//yxSHXugw6zqVBFEd6uOwtPM58fG+
         QQrJzJNh3mggy3DKcM7u5CkXgJn0Hrd7KCDBeG7NpBH3alyjS1DoaVv5yv+ShfF770H+
         aaY2Qkyika5dSjHvOLd7vZhJZYBXcvW7ZcTwogfd/IoSeSJELJjhlSQDS37TLJe5Omfv
         f54pvUhdV1825rBJbinciL4t/jHZ2eRIkfjjRjGr3/hjmEA6T4HK/QmXkFTisa+DoC36
         cLZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUO1CTVqXVUomXU+jBHkapkJ7/W5EJrmWD4AlAWcTUPBMetrVxEoBWwlHbhWBwk8zBPJ4VBBH3u4xKdJdwKfbOAn0Kr59bc7fPagQv2g==
X-Gm-Message-State: AOJu0Yz7WkxfNOCWassLkS+pxFtepzmpXlIzexRTgrVaxaZnY1+WF1A3
	ajPLKyiC9oOwbxTTvccDeW0i9zihKiKmQ87waTWuftUlsm0Oue0aUNOBKWaRwXDdwIDG5xyTPKa
	8awSNdw==
X-Google-Smtp-Source: AGHT+IHRUgC8WtiO7AwegcW3+4KOSUtx7MPwMi+7TPlI1D2/cDhqd5aEBQrUrgU5K2iElX0saTcZeg==
X-Received: by 2002:a17:906:eb4c:b0:a58:fc3b:8c6e with SMTP id a640c23a62f3a-a5a2d6a38c8mr417172466b.69.1715457346816;
        Sat, 11 May 2024 12:55:46 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01467sm373896666b.170.2024.05.11.12.55.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 12:55:46 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso760063166b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 12:55:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWb40UdrTy9lg4TNzWFGa1JPFnIJ0k7CrwvVkv8BjheDmKPb+aI4ecce6enpcOP3Bj90kQxbqTbwyjWiJ5C80z38c3cKNFoDTELM/v7FQ==
X-Received: by 2002:a17:906:17d9:b0:a59:efd3:9d with SMTP id
 a640c23a62f3a-a5a2d673060mr418613266b.58.1715457345947; Sat, 11 May 2024
 12:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org> <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV>
In-Reply-To: <20240511192824.GC2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 May 2024 12:55:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7BtsC7wvTqnYOtAiWzM2Q5tK=TG=V=7D6SKfbzhoCKw@mail.gmail.com>
Message-ID: <CAHk-=wi7BtsC7wvTqnYOtAiWzM2Q5tK=TG=V=7D6SKfbzhoCKw@mail.gmail.com>
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in 'rmdir()'
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, laoar.shao@gmail.com, 
	linux-fsdevel@vger.kernel.org, longman@redhat.com, walters@verbum.org, 
	wangkai86@huawei.com, willy@infradead.org
Content-Type: multipart/mixed; boundary="000000000000bbbc4e0618330905"

--000000000000bbbc4e0618330905
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 12:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, May 11, 2024 at 11:42:34AM -0700, Linus Torvalds wrote:
> >
> > And that outside lock is the much more important one, I bet.
>
> ... and _that_ is where taking d_delete outside of the lock might
> take an unpleasant analysis of a lot of code.

Hmm. It really shouldn't matter. There can only be negative children
of the now deleted directory, so there are no actual effects on
inodes.

It only affects the d_child list, which is protected by d_lock (and
can be modified outside of the inode lock anyway due to memory
pressure).

What am I missing?

> In any case, I think the original poster said that parent directories
> were not removed, so I doubt that rmdir() behaviour is relevant for
> their load.

I don't see that at all. The load was a "rm -rf" of a directory tree,
and all of that was successful as far as I can see from the report.

The issue was that an unrelated process just looking at the directory
(either one - I clearly tested the wrong one) would be held up by the
directory lock while the pruning was going on.

And yes, the pruning can take a couple of seconds with "just" a few
million negative dentries. The negative dentries obviously don't even
have to be the result of a 'delete' - the easy way to see this is to
do a lot of bogus lookups.

Attached is my excessively stupid test-case in case you want to play
around with it:

    [dirtest]$ time ./a.out dir ; time rmdir dir

    real 0m12.592s
    user 0m1.153s
    sys 0m11.412s

    real 0m1.892s
    user 0m0.001s
    sys 0m1.528s

so you can see how it takes almost two seconds to then flush those
negative dentries - even when there were no 'unlink()' calls at all,
just failed lookups.

It's maybe instructive to do the same on tmpfs, which has

    /*
     * Retaining negative dentries for an in-memory filesystem just wastes
     * memory and lookup time: arrange for them to be deleted immediately.
     */
    int always_delete_dentry(const struct dentry *dentry)
    {
        return 1;
    }

and so if you do the same test on /tmp, the results are very different:

    [dirtest]$ time ./a.out /tmp/sillydir ; time rmdir /tmp/sillydir

    real 0m8.129s
    user 0m1.164s
    sys 0m6.592s

    real 0m0.001s
    user 0m0.000s
    sys 0m0.001s

so it does show very different patterns and you can test the whole
"what happens without negative dentries" case.

                 Linus

--000000000000bbbc4e0618330905
Content-Type: text/x-csrc; charset="US-ASCII"; name="main.c"
Content-Disposition: attachment; filename="main.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lw2isk2d0>
X-Attachment-Id: f_lw2isk2d0

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN5cy9zdGF0
Lmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3Rk
aW8uaD4KI2luY2x1ZGUgPGVycm5vLmg+CgojZGVmaW5lIEZBVEFMKHgpIGRvIHsgaWYgKHgpIGRp
ZSgjeCk7IH0gd2hpbGUgKDApCgpzdGF0aWMgdm9pZCBkaWUoY29uc3QgY2hhciAqcykKewoJZnBy
aW50ZihzdGRlcnIsICIlczogJXNcbiIsIHMsIHN0cmVycm9yKGVycm5vKSk7CglleGl0KDEpOwp9
CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKiBhcmd2KQp7CgljaGFyICpkaXJuYW1lID0gYXJn
dlsxXTsKCglGQVRBTChhcmdjIDwgMik7CglGQVRBTChta2RpcihkaXJuYW1lLCAwNzAwKSk7Cglm
b3IgKGludCBpID0gMDsgaSA8IDEwMDAwMDAwOyBpKyspIHsKCQlpbnQgZmQ7CgkJY2hhciBuYW1l
WzEyOF07CgkJc25wcmludGYobmFtZSwgc2l6ZW9mKG5hbWUpLCAiJXMvbmFtZS0lMDlkIiwgZGly
bmFtZSwgaSk7CgkJRkFUQUwob3BlbihuYW1lLCBPX1JET05MWSkgPj0gMCk7Cgl9CglyZXR1cm4g
MDsKfQo=
--000000000000bbbc4e0618330905--

