Return-Path: <linux-fsdevel+bounces-30961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC40990191
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9E51C21D67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8581487E3;
	Fri,  4 Oct 2024 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQjIXVG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13021130ADA;
	Fri,  4 Oct 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038843; cv=none; b=LCqp6XT6Cmen32aqctqUFCltIPUT0xEpZWzUXcIJuIwXtMoxFB7RKOvZqhnGlX6cdoc6SbRACK5ym4XDNhwRVQgj+7/M69EpCBXNxLE3P5kXAMbEzCtc9hhbOqmY4m8AILc7tfwMX9dqSFh6PJcD7WziS6qWIjrtEivfVYnzG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038843; c=relaxed/simple;
	bh=SInj0L4yl8PgbguZ2YHoPda4zoJob/jJnPe3V8fhXpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilWYeNRBn20uyVJuc3RrOGO64Y3fsMGC6HgUr4fMBcL2ZlG6css9k+iWxe6j+bEb8O6S+6AKuWw39GP1Mgo9K3rK0pRInzNY17ts7rpYokevEc9wEwCt3kdq9cRRbx0ODLL3mt0n8NdiXOa7CjjxgyBNpDmKsmsn/nl1wpKj6SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQjIXVG9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a9a30a0490so179147985a.3;
        Fri, 04 Oct 2024 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728038841; x=1728643641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3mlEzJKr7uo8QY7IUCRVyaN6ccqAAOVZAMiixeKLtQ=;
        b=BQjIXVG9p/QnADnQMA1dWjVkj/jfRstRoYpt2GjyV3bodcsTsnhHnDTyEO0mnyHTRo
         dzBkhSZVMoqXhvbCUBAXFtqBRd8O9THqvOWnhfZVKj9u/78WmSgA4hHZLLvz9ZYzLxkf
         5T1CQb2NKrUQsnISKqPKkXUwSEj99eOJjtlcOFf+BYMoMBnhImCl5PRAgThGGpZR1Cjy
         W4O4c3qXUzIEsSq7vKsVg1YZlPIwwq4xprAnIdmLgFzIJ2MqsXVb3PHQJebg6e2jetyC
         Esv9WYUM6+su8zjYvQ1rCl8epR8wwwiCP3mjYT9/akjLinVWXgaDWVlFPVOG2hW2tuRJ
         VLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728038841; x=1728643641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3mlEzJKr7uo8QY7IUCRVyaN6ccqAAOVZAMiixeKLtQ=;
        b=Wn7HZ2IHJBdWRY8HqxZCM56UnEmQYlIdznm+caf71O5o1N6zIR1TPOd1N69o5hTXXp
         135vh4GACAdFRv25/Qce/mdsgYzcignvQ+wfJcXae+HIlUhgBoiMDi1Zyidaw8tlXclA
         27MG63vBWuMP6RvT0PHEyO2Ph6a2WcojGLGkEz0lB58JQK++9OvSeFN8zvw4g8efMsTH
         m7Uc86PEV+rhqHfW7l0sPoDPciXv6lV15sbeZCOJc1gMgTwoz3LjxdxTX5xKzNOpoJKR
         doyrRKTmpcNIwPKOqsVAfPUCeH+PuEpqKX9SACh659AGNV57zk33ocGXdmC3q8UmZ4NF
         FupA==
X-Forwarded-Encrypted: i=1; AJvYcCXWdm1QVdBn7hVdP8h+wbXXQCciIk58aE8+tjvJS2JIm/i6NUxA/rF7qgUPLe4iAGEyYytvFftybh8rPkOw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/PoTML7zWcqhjs5LSn1O+lOFiKJ51lSZ1WCIPqrZG/A1PJ77+
	wF15YrekJ6z+CbnbPcGaDa/1vgxEAbT7YJTNl7P5hlIpx+HyQ4F2szjbM2FwTpBg/2xYDXcb7QF
	ULFHozro1zYAQlIgYlWntpQ5TBxE=
X-Google-Smtp-Source: AGHT+IFqETdSJT2/uRlm2PPIBi9WVTlS4JplcGpyvEMrsyTlCTg6MTnWke1N8UEYikgBmamcSEpwNbdXDRNplx4KyPs=
X-Received: by 2002:a05:620a:24cf:b0:7a9:a883:e22b with SMTP id
 af79cd13be357-7ae6f42e164mr323511685a.7.1728038840701; Fri, 04 Oct 2024
 03:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003234534.GM4017910@ZenIV> <20241003234732.GB147780@ZenIV>
In-Reply-To: <20241003234732.GB147780@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Oct 2024 12:47:09 +0200
Message-ID: <CAOQ4uxjS0CX+nA4xqmrrMYDPXRPWMT00+S8z8OMhMWc9omSvMw@mail.gmail.com>
Subject: Re: introduce struct fderr, convert overlayfs uses to that
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 1:47=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> Similar to struct fd; unlike struct fd, it can represent
> error values.
>
> Accessors:
>
> * fd_empty(f):  true if f represents an error
> * fd_file(f):   just as for struct fd it yields a pointer to
>                 struct file if fd_empty(f) is false.  If
>                 fd_empty(f) is true, fd_file(f) is guaranteed
>                 _not_ to be an address of any object (IS_ERR()
>                 will be true in that case)
> * fd_err(f):    if f represents an error, returns that error,
>                 otherwise the return value is junk.
>
> Constructors:
>
> * ERR_FDERR(-E...):     an instance encoding given error [ERR_FDERR, perh=
aps?]
> * BORROWED_FDERR(file): if file points to a struct file instance,
>                         return a struct fderr representing that file
>                         reference with no flags set.
>                         if file is an ERR_PTR(-E...), return a struct
>                         fderr representing that error.
>                         file MUST NOT be NULL.
> * CLONED_FDERR(file):   similar, but in case when file points to
>                         a struct file instance, set FDPUT_FPUT in flags.
>
> Same destructor as for struct fd; I'm not entirely convinced that
> playing with _Generic is a good idea here, but for now let's go
> that way...
>
> See fs/overlayfs/file.c for example of use.

I had already posted an alternative code for overlayfs, but in case this
is going to be used anyway in overlayfs or in another code, see some
comments below...

>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/overlayfs/file.c  | 128 +++++++++++++++++++++----------------------
>  include/linux/file.h |  37 +++++++++++--
>  2 files changed, 95 insertions(+), 70 deletions(-)
>

[...]

> diff --git a/include/linux/file.h b/include/linux/file.h
> index f98de143245a..d85352523368 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -44,13 +44,26 @@ static inline void fput_light(struct file *file, int =
fput_needed)
>  struct fd {
>         unsigned long word;
>  };
> +
> +/* either a reference to struct file + flags
> + * (cloned vs. borrowed, pos locked), with
> + * flags stored in lower bits of value,
> + * or an error (represented by small negative value).
> + */
> +struct fderr {
> +       unsigned long word;
> +};
> +
>  #define FDPUT_FPUT       1
>  #define FDPUT_POS_UNLOCK 2
>
> +#define fd_empty(f)    _Generic((f), \
> +                               struct fd: unlikely(!(f).word), \
> +                               struct fderr: IS_ERR_VALUE((f).word))


I suggest adding a fd_is_err(f) helper to rhyme with IS_ERR().

>  #define fd_file(f) ((struct file *)((f).word & ~(FDPUT_FPUT|FDPUT_POS_UN=
LOCK)))
> -static inline bool fd_empty(struct fd f)
> +static inline long fd_err(struct fderr f)
>  {
> -       return unlikely(!f.word);
> +       return (long)f.word;
>  }
>
>  #define EMPTY_FD (struct fd){0}
> @@ -63,11 +76,25 @@ static inline struct fd CLONED_FD(struct file *f)
>         return (struct fd){(unsigned long)f | FDPUT_FPUT};
>  }
>
> -static inline void fdput(struct fd fd)
> +static inline struct fderr ERR_FDERR(long n)
> +{
> +       return (struct fderr){(unsigned long)n};
> +}
> +static inline struct fderr BORROWED_FDERR(struct file *f)
>  {
> -       if (fd.word & FDPUT_FPUT)
> -               fput(fd_file(fd));
> +       return (struct fderr){(unsigned long)f};
>  }
> +static inline struct fderr CLONED_FDERR(struct file *f)
> +{
> +       if (IS_ERR(f))
> +               return BORROWED_FDERR(f);
> +       return (struct fderr){(unsigned long)f | FDPUT_FPUT};
> +}
> +
> +#define fdput(f)       (void) (_Generic((f), \
> +                               struct fderr: IS_ERR_VALUE((f).word),   \

Should that be !IS_ERR_VALUE((f).word)?

> +                               struct fd: true) && \
> +                           ((f).word & FDPUT_FPUT) && (fput(fd_file(f)),=
0))
>

or better yet

#define fd_is_err(f) _Generic((f), \
                                struct fd: false, \
                                struct fderr: IS_ERR_VALUE((f).word))
#define fdput(f) (!fd_is_err(f) && ((f).word & FDPUT_FPUT) &&
(fput(fd_file(f)),0))

Thanks,
Amir.

