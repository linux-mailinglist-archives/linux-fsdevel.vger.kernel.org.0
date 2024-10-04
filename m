Return-Path: <linux-fsdevel+bounces-31021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F8799107E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47DB9B2FD29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A731DF971;
	Fri,  4 Oct 2024 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9FrMdH8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686071DF963;
	Fri,  4 Oct 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070851; cv=none; b=AKJ/B/6ACWkrt80LRUWF5tRw51xLTU4cUIIImqmMWc+JNmcEsHo80/nD1BFv+NG8+iRIB7wD/cabCAOGhyyQjIPd/OYNxQyiqEHyI2yWu3TcLoEq4ZGS1x4rkT4XH3hta1PqvvjXl4a4iu2h/CnVfcqRy/wyR9CUhkWo6JUVaCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070851; c=relaxed/simple;
	bh=ke70JJNgmOACkFxJdbHKkxXdORWwcypWE2iwKivNAQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpmSHxjjbnvUnwqMmjTF5Wj6jRQ5BNu/8LoA0PyBxhatb8mrK6cOsNUnCCZ0JlaYpdG4B8OFEN34JYoq/MSmNYnb420+LngAJ2MCIzI823u4Jor90QuutDaBTE25gD3KbJf091rRu+9aAVdiBYl85l1pF2p2uubOwdoGnJNhhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9FrMdH8; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2b9e945b9so19915487b3.0;
        Fri, 04 Oct 2024 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728070849; x=1728675649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3XI2OIssfAbm3QORNiEPOTU5ePNW8wXod80lCkJqoh8=;
        b=j9FrMdH89VaYfUvqjiuoQkmu0ib6Bt+dhGkB7OwNlyKT6xdome/FjTCMABCrV95t0o
         +MMt+d3KZR8ZIaSq/hRRdUvVTZUwINBwr5KGG0Qbt9xlyIQgpT3j1C5kmYIAIqVFapnS
         qyjjnQ3ez3Qiwpn4YrDadq8PJ1fqcRKugxzeytS9TB3F7QRf7ucUZrnmL6n8snG2z25M
         JEtLc6LGw7JajQHOmGrhcutmNZcfPzCV03jt3zoSXXQOiYbpQtGVfX+zVbaLj0s7uMUn
         tEV9CMzqBPsYw2QA52f3jcz1G5u4aN1miazbIwHSD2j5LGDDZ5hfCHxI/TwjLeLbUUlw
         icVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728070849; x=1728675649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XI2OIssfAbm3QORNiEPOTU5ePNW8wXod80lCkJqoh8=;
        b=UFXKQmdEDbAcDq48IS0P4C9uawY0Ee/1/EZmb7H1gj0wvjEwrexEH33cfdQiDuqW24
         zNNrc9bOwz+7pCwMGgA/UXwk1yAtEjS2qD9TZzTr9+nTiFWJUIigMXV3RyYaMeJ+jG0F
         hOaCgZ+ECS/1kQxRMWEcMqFGQ2W0+NE77HJMMJvRdgxza2RRo5C19RM372G99yw/4ExS
         pyo0+qK1vcjEKTVqMtWhKaTmBBjwBs9MC7RjgoDDeY6LF32Ymt9Y+D3HgjNVSeiRJ/eL
         rC6dShu4QoOe0OvHgAbmzNr6LLIVnpjfxkfTfWIGy7XwBBCixlAMqpXHfWIC6q8+L0xL
         nJRg==
X-Forwarded-Encrypted: i=1; AJvYcCVy6L8gqh8MpRA+rqzsQa2yby66Ok1D6XQOtEjZhxpzOk1uI6v+Y0JPm/b5V8l+/8HULvJHOZUDxoPQdHgg@vger.kernel.org, AJvYcCWOrHZve4BBpY7e7zytA1XHZ2cIrvgMqyTFhE6sPNPGyTmyGu5KPqrCHPyBJ/nxy9XfSuleXbV4IDHPBUq8@vger.kernel.org
X-Gm-Message-State: AOJu0YxOHjV64SMyno0RaR44PuP/ieG8qBxEhZLpYpAWwh4P/H88Ye+S
	Mux0jjuhBUJzW8d++TsB37GGJeQRBonAn7bYjLr+WENuDp4zlvn/R+0LwH8P0q5J6yWrSQj1qtZ
	okQxAO0cNPfXJ6Tic7w2cU/Yyq8Q=
X-Google-Smtp-Source: AGHT+IESN4CtU0bFWKQCUVBNZv9VjjDcMQwJHSlRCK3Kk28ymum9dmWiULwVl+jYBlJxeQAdI3dbwaw1udfRIL2xhLY=
X-Received: by 2002:a05:690c:6610:b0:6e2:a962:d80f with SMTP id
 00721157ae682-6e2c6fcb63emr38428417b3.8.1728070849297; Fri, 04 Oct 2024
 12:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
 <20241004-signal-erfolg-c76d6fdeee1c@brauner> <CAMw=ZnRt3Zvmf9Nt0sDHGPUn06HP3NE3at=x+infO=Ms4gYDGA@mail.gmail.com>
 <20241004192958.GA28441@redhat.com>
In-Reply-To: <20241004192958.GA28441@redhat.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 4 Oct 2024 20:40:37 +0100
Message-ID: <CAMw=ZnRp5N6tU=4T5VTbk-jx58fFUM=1YdkWc2MsmrDqkO2BZA@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 20:30, Oleg Nesterov <oleg@redhat.com> wrote:
>
> I wasn't CC'ed, so I didn't see the patch, but looking at Christian's
> reply ...
>
> On 10/04, Luca Boccassi wrote:
> > On Fri, 4 Oct 2024 at 10:29, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Wed, Oct 02, 2024 at 03:24:33PM GMT, luca.boccassi@gmail.com wrote:
> > > > +             info.pid = pid_nr_ns(pid, task_active_pid_ns(task));
> > >
> > > I think this is wrong what this should return is the pid of the process
> > > as seen from the caller's pid namespace.
>
> Agreed,
>
> > Thanks for the review, I applied the rest of the comments in v2 (I
> > think at least), but for this one I can't tell, how should I do it?
>
> I guess Christian meant you should simply use
>
>                 info.pid = task_pid_vnr(task);
>
> task_pid_vnr(task) returns the task's pid in the caller's namespace.

Ah I see, I didn't realize there was a difference, sent v3 with the
suggested change just now, thanks.

