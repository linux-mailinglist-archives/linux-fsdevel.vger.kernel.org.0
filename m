Return-Path: <linux-fsdevel+bounces-18736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E58BBD9F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 20:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AEC1C20DA1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5571B30;
	Sat,  4 May 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dicrVqhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B77125776
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 May 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714847274; cv=none; b=Z2Ipt3Zz9CKOEXkjr8AwlQGTzPcf8TLi5y8XdQi2tJb7U9SQ3bIany2jaGl7IXSYdzj4omx8ncowIw64kTkjbZVdBoWfVNEWefjBg6htHaaLJafpe4oHhAHPQ5Yen5vOsBRGdoUJ/WL9vy14REqD5r6XAQt929VWQMwzRDntSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714847274; c=relaxed/simple;
	bh=rAIZu+79Hh8VYj6yqYqrrAzdBZ74FGbLE5oKNi+7r5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9bkOw9WJFIIJOMNpZiXw8lBwo5Pl6p2CV0HIAEXYb48YpjYl2U6jriZBl6Gnv5n+pneMM5D25PnD+HRhr/5dnsqnJvy5ff2cGvTEQuRP9oXqu8z3r2pG2uMXbG15gF7WRdMtd7ZyKzbb2yY1YmfxP9UQKOrVbFlwTg68OTPCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dicrVqhN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a598c8661f0so151952966b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714847270; x=1715452070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbTAb0O3vIVxVEVAX+Kz3ISBhu7sYKvIouph0u6S16I=;
        b=dicrVqhNJmmzBBCVgIIPZtYwHEUv/FqFBTwzc4vt3jZryOogwugbyf/6uJe04SoTXT
         g89WmHyZ/BPtuiC2gQuZW3WgpbAuR9Y6eyDZjaTWhg/H87fZ0jlmL4O/5VrC1loURJ7D
         IQYKR4yk718IxlM7sMjdiyDf83nP5OC3/sjlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714847270; x=1715452070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbTAb0O3vIVxVEVAX+Kz3ISBhu7sYKvIouph0u6S16I=;
        b=GlrXHqY892K2u5SiQc6qTN2SD8tvc9ygN2rrl4NDePUfU80Gknj9AAoANrLfuFHi5W
         uxCXvxUZ2YN5Y4N1JVlenKC85ie7H+Pa1ukpgH+ezTjOI4iDpyzc/oENbUBbPbswH/d+
         oBkho4AIM5Yom/b/qTELU2Cy1tsH0YufpowCFZNCN5Fi7mfkadIjRFblaYQJM9oL4Hgy
         Snh1AtA5EcJqIVfznwM3oaO5vEFnNJhV4UYh5vb7LWQmT7bSo4mEduzG2SJz//Wrmzeb
         vE/s3i9AJcoZhhym1O3BU8drNbyJo5AVeMZnn5Xz8HO4EoI7JbK2pVMryRA1IphuxKIA
         CBgA==
X-Forwarded-Encrypted: i=1; AJvYcCUsraN43i5KRjWkH1LimNyf12EvVkyIE6GBU4XV3Ymvg5Dn8A7IiBpwvq0TJVSg7t3YQ1kiHFjOZrJXWisaUSCpgeWqQutXqMLRelNzcw==
X-Gm-Message-State: AOJu0YxJGNKQKUUf60kBmcmBlcuyaAYzskLArz7tdDnAMRzItt5eH2uM
	ocsMmF5JFg8VJ5sASG/HI7Ust9LbnBqUUeMlSCLnIx6gSXu95Pe12Rr6nBp7wUf255qlNVItGFO
	xg9Fh3w==
X-Google-Smtp-Source: AGHT+IHj6Tw8KkCiM2bNBVPcLyd79iu+IkFOZFq4Ckm4dqdtTELiz8It2JMkmYtvSQQbHXVzQrqM4Q==
X-Received: by 2002:a17:906:80d4:b0:a52:5925:2a31 with SMTP id a20-20020a17090680d400b00a5259252a31mr3579323ejx.29.1714847270146;
        Sat, 04 May 2024 11:27:50 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709060e9600b00a5887833da8sm3134797ejf.81.2024.05.04.11.27.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 11:27:49 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a598c8661f0so151950366b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 11:27:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtsNvdkO8C5HhNalwjaj17qV5sGprzEnID5k63ZoasFIxNYkFcYyEEsZurpU5WWJbloTknyZpZ+jRwLPU9Lp0gGRSE+vsjDZTc0knk+Q==
X-Received: by 2002:a17:906:e90:b0:a52:1e53:febf with SMTP id
 p16-20020a1709060e9000b00a521e53febfmr3945377ejf.69.1714846838331; Sat, 04
 May 2024 11:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
In-Reply-To: <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 11:20:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
Message-ID: <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 May 2024 at 08:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Lookie here, the fundamental issue is that epoll can call '->poll()'
> on a file descriptor that is being closed concurrently.

Thinking some more about this, and replying to myself...

Actually, I wonder if we could *really* fix this by simply moving the
eventpoll_release() to where it really belongs.

If we did it in file_close_fd_locked(),  it would actually make a
*lot* more sense. Particularly since eventpoll actually uses this:

    struct epoll_filefd {
        struct file *file;
        int fd;
    } __packed;

ie it doesn't just use the 'struct file *', it uses the 'fd' itself
(for ep_find()).

(Strictly speaking, it should also have a pointer to the 'struct
files_struct' to make the 'int fd' be meaningful).

IOW, eventpoll already considers the file _descriptor_ relevant, not
just the file pointer, and that's destroyed at *close* time, not at
'fput()' time.

Yeah, yeah, the locking situation in file_close_fd_locked() is a bit
inconvenient, but if we can solve that, it would solve the problem in
a fundamentally different way: remove the ep iterm before the
file->f_count has actually been decremented, so the whole "race with
fput()" would just go away entirely.

I dunno. I think that would be the right thing to do, but I wouldn't
be surprised if some disgusting eventpoll user then might depend on
the current situation where the eventpoll thing stays around even
after the close() if you have another copy of the file open.

             Linus

