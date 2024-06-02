Return-Path: <linux-fsdevel+bounces-20727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0318D7409
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FF71F21571
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E88B208A1;
	Sun,  2 Jun 2024 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLoWVB8A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50C18E11;
	Sun,  2 Jun 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717311422; cv=none; b=N+7QB4f//PG61jMvjyfnWuiO4jI1ZpD9/4jukbPMP5tDeFyQcHfCOy1AcdShbMdkzhdUnsLDrinj2EK51KrhwNc6hUb7Mhw4OAM1XjGFcyHCsqVSJXUKOL2jhbl8fPFJYlhwW2HK+qbZiW7gyxdJhUKa9h/Tr69rDj5HP6yFRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717311422; c=relaxed/simple;
	bh=kNaAdwj4JXsTfPgEJdtdgcc05WNgvnkp0WyXnDIgbWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpS53aY4x7LyMJ4aTYvPfY3nUt9sQXBjbXaXov3VJsCRH0OAkEQFCOt5HL5c8YTZAEKdv9MyhkiLiedrmu4xHXA6Z65/7ZylUjvw3bBIiviXaXt2mbvXoXVD81YITjqaPdcmLW9PgIRcehfwkP392CSdqLNkPh+eJm0kq13XUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLoWVB8A; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ae279e6427so14716346d6.1;
        Sat, 01 Jun 2024 23:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717311420; x=1717916220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAUPbRzuyrXUUhAbCV+RswkSNoR9RTLDNyX2Ucwmfqo=;
        b=WLoWVB8ARGhW9CHP6QC1567Gawsr3LZmSR2SXlu/OVL2xD8emi2TqPu9l6kJC3vE/8
         ZISgbrVy3432imlcxjziw7+jRLS78gabV0Rf50pmCYqv65TLwz4S1C3Ey34d39U3yWLl
         IAXy95KCmyJzgvvcQCZR8g6rDJx5R5hPEvL4VWHMrXJXnCUSW2CzK5BKp41b9NWq0nDh
         8PX28VgxhMnBqYiDWeVQSX1A2rqBfU9BN+frUhVvntbEw6unSB5hWJh/97e+HJricNV/
         Ln5zfhPa+cmkyayd0PwbjzaUciz/gQEi7gKRkNo/aI3uYtKc7t4Ph4B1YfdYYt68QoeW
         Vi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717311420; x=1717916220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAUPbRzuyrXUUhAbCV+RswkSNoR9RTLDNyX2Ucwmfqo=;
        b=YgpJkIt/36YCc/t+koT3YH6xrLyrkCoT/tJZiW0dL925oQKMCzkJ+ekk2BEFVR8eKg
         AhotUzBJK5fyY3RWFBzgR4grtjifgBI9dr26tvdL6clS0bMCX9QLvlzwRJl/B1zEsN1z
         h1v9EOXWNSkvqWbyP8zWsUWBsYMJRtZRokRAuDV+9UzS4l9LFRgEWBhDe5E/x2joqtNu
         NNwNn23JyZq+OeI8DH3Q9FMvSqhE9HTa/ILemlVGm77VS4XIgz4ftx+3HpXlUBund9lx
         JOYA0Inhqty70pKHujXggfT3ZX6X9V8uPM1C1exrl8Y9qxOjUsQ9ZUWvS6vuI7vrIWrj
         5qYA==
X-Forwarded-Encrypted: i=1; AJvYcCXdOnO1kBtKrircJXJb5t/SwIv1MlXfXcuV6rLEDG4CuAuv1KMKUcvvjfw+f0kRg38aGLABA0RzYTOh9oJE7u4gHmiubhrYTe136WwU9e8YqfkdJV61IG+uqE8uLaQytdqhZQ+nbY3ruHqOWo7cqxyAHGD0t51IscuyL21l2PR7djiNHYoO6Qm574urD861Dog7p0AbEOjnMYWYGzDcxFWyMRN+4FwpVu9C1bBKtOfjEAgUPiodg1Oa0/k4jgUCYq5Ls3PprtNqrDWKOEUqm+6Z07oSxQvcrsZ3cSjagQ==
X-Gm-Message-State: AOJu0Ywb+6Hb8Pp33Noz83GuzFPNy0UhXKTRBvPXSbFpd/pYoR5P8tui
	aXC2iFwowTIUHcl8pWPh4MZqW/CwQkkhXeQIr0hLGOZb0eWTrPpPcUPIJzEOH9x6UBEFAXmIJM4
	Hsa0a9HBZwlHZyFH9Fp0tqkCgT90=
X-Google-Smtp-Source: AGHT+IHBO8CcAWYey7pRZVURNsZzP8hqqeNI4aNYwlr3UTd/2FxO0+zZYuavJGm6rllryB0FhnqOhCZpQ6HL1oaZSiY=
X-Received: by 2002:a05:6214:4891:b0:6ab:9492:7d89 with SMTP id
 6a1803df08f44-6aecd6f054bmr77058646d6.52.1717311419907; Sat, 01 Jun 2024
 23:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-2-laoar.shao@gmail.com>
 <87ikysdmsi.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ikysdmsi.fsf@email.froward.int.ebiederm.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 2 Jun 2024 14:56:23 +0800
Message-ID: <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: torvalds@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 11:52=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> Yafang Shao <laoar.shao@gmail.com> writes:
>
> > Quoted from Linus [0]:
> >
> >   Since user space can randomly change their names anyway, using lockin=
g
> >   was always wrong for readers (for writers it probably does make sense
> >   to have some lock - although practically speaking nobody cares there
> >   either, but at least for a writer some kind of race could have
> >   long-term mixed results
>
> Ugh.
> Ick.
>
> This code is buggy.
>
> I won't argue that Linus is wrong, about removing the
> task_lock.
>
> Unfortunately strscpy_pad does not work properly with the
> task_lock removed, and buf_size larger that TASK_COMM_LEN.
> There is a race that will allow reading past the end
> of tsk->comm, if we read while tsk->common is being
> updated.

It appears so. Thanks for pointing it out. Additionally, other code,
such as the BPF helper bpf_get_current_comm(), also uses strscpy_pad()
directly without the task_lock. It seems we should change that as
well.

>
> So __get_task_comm needs to look something like:
>
> char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk=
)
> {
>         size_t len =3D buf_size;
>         if (len > TASK_COMM_LEN)
>                 len =3D TASK_COMM_LEN;
>         memcpy(buf, tsk->comm, len);
>         buf[len -1] =3D '\0';
>         return buf;
> }

Thanks for your suggestion.

>
> What shows up in buf past the '\0' is not guaranteed in the above
> version but I would be surprised if anyone cares.

I believe we pad it to prevent the leakage of kernel data. In this
case, since no kernel data will be leaked, the following change may be
unnecessary.

>
> If people do care the code can do something like:
> char *last =3D strchr(buf);
> memset(last, '\0', buf_size - (last - buf));
>
> To zero everything in the buffer past the first '\0' byte.
>

--=20
Regards
Yafang

