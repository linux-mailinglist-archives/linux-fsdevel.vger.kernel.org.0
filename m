Return-Path: <linux-fsdevel+bounces-29874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C5897EEFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 18:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7CB21BED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E719E993;
	Mon, 23 Sep 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DfFH+JfI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581919CC20
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108084; cv=none; b=t3rOQjAtfql2fBqGpL79WcpzEnMcbaTcZ6J3QhO5N9S+4jzQuCTxu9zC7+QjLzALP+v/TesPDH3zptfTS7txpC3rpl14MGR8P1gMrvZlXQuTvU+7Jn+m+cXI2YTO12IFOWpPgKr/F5nRpeKmuIdQw1iyvHs5hdrC06zlr67Wkiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108084; c=relaxed/simple;
	bh=ipP2sfXR0vIc+1LQTZJOYMzoKbeTAHOQP1umoQw/lLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5RjjuNYNGAvERoee2qHwviYLca9YLVvbDmANn+ZbCy7/R1Exvm7E5G+THf7/0F6n4tORiM1qBARkp60iIbQmPzJA7pQvwPCgqrrqg9k9Ed5JPLqwZiICRHiRkGVe9h2a1h6kdur8fQGTukYtrCvK3IVH12iZYElPJ9VTKDVN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DfFH+JfI; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso3654692276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727108082; x=1727712882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsCrHU9w8sCi3sT7V4UA5/oaMkCAT+JmuhOd7667Tas=;
        b=DfFH+JfI1ZSfEp3XD/uvig8ogphsXz9rRHsgDusuE/E4FGyn0lrvEKN0+5L84Ed7zk
         4YYDL74RCc/sq8Fmb8j9upPbZNDoyteiF/S7aMm/MK/Ehes8TlTm3wagR9U7/Bc3tIbb
         jrBFJKn99bQPshmqvQ0ghmM7N2XtXNB/Db/atbrCaQ7XXxF2WVDaePAdcsjKT9KIYC8e
         JL7oMGRhEfpBZoPZgBE9O1Ei/Yn1ANzU7jv2F5yGuBxYmpEUW72X3duxs1db1CjifdWI
         Dh8cqBa4xLi2Xw6bHEKDJR2ntHEOsYwUFhCh3HF+JNvqDFrDCTs93y6/T8lZZT7khEK2
         Udzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108082; x=1727712882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsCrHU9w8sCi3sT7V4UA5/oaMkCAT+JmuhOd7667Tas=;
        b=UiYiIF0/BCf1Cl0FfrropgtR/44//3GcHzaJLdSa3eqLfrYh4oNZ1zAXqNP6sQvvMq
         sar/C1KaiAJ8x7KuH6KrjN8w8xWzFz5twPyUTeGWORgd9gsiJuCZJBjzWCWgMtCuMsQB
         JyRIP+eBeTmB5fhJ9N4GQUg6D6/IQpculTU0+Fe7a5FzUmI6iC8UNmwoYGbP3HtDRvrF
         1bWOEYxH9fd6MKJxnwk+xbmu2G3498+6tAocPN7NPc/AeK0W8l3yjjH+XPPBFYxh9WUs
         FecuuaBW2evUMLUDqlvHihG3LwUbH7IoAHGLimj2CCO05rmAWlPyaWNW2AEyerwX/bbt
         c+xw==
X-Forwarded-Encrypted: i=1; AJvYcCWV2kQz9L6kVvEUSXY2T/RVYRZQ0gfmgNJHAwFv7d4DKxpvlC5P8AgN4qewMagN1/PSR87o2Wkc3atnoJRp@vger.kernel.org
X-Gm-Message-State: AOJu0YxukixpJEZZmYaewYFvlC6uMbZwtp1AKggM+818CL5dJqmQCnEU
	HPVG9FL7Vdhqy5Gm1V+f2UBaouU8Pn42T+TkYuKqzFKygI18k/AN5ZQzaCa01/VrxmKotdwy6d/
	PkSoHxsrduMoJmPyV+G+3P3u5s00DSrSHskZlQl5nT/lVAzY=
X-Google-Smtp-Source: AGHT+IGNqipb9OYrGu3S15kHzPKvSSV1+65Pw0RfDX7Jhg5enLJD1yoATV7eOmgAWDW+1h4V8UXW6VGItQ29jZDnvhg=
X-Received: by 2002:a05:6902:1884:b0:e24:8eb6:d70e with SMTP id
 3f1490d57ef6-e248eb6d7e7mr2280124276.49.1727108081637; Mon, 23 Sep 2024
 09:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922004901.GA3413968@ZenIV> <20240923015044.GE3413968@ZenIV>
 <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk> <CAHC9VhQMGsL1tZrAbpwTHCriwZE2bzxAd+-7MSO+bPZe=N6+aA@mail.gmail.com>
 <20240923144841.GA3550746@ZenIV>
In-Reply-To: <20240923144841.GA3550746@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 12:14:29 -0400
Message-ID: <CAHC9VhSuDVW2Dmb6bA3CK6k77cPEv2vMqv3w4FfGvtcRDmgL3A@mail.gmail.com>
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 10:48=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> On Mon, Sep 23, 2024 at 08:54:03AM -0400, Paul Moore wrote:
> > [Sorry for the delay, between flying back home, and just not wanting
> > to think about the kernel for a day, I took the weekend "off".]
> >
> > Jens and I have talked about similar issues in the past, and I think
> > the only real solution to ensure the correctness of the audit records
> > and provide some consistency between the io_uring approach and
> > traditional syscalls, is to introduce a mechanism where we
> > create/clone an audit_context in the io_uring prep stage to capture
> > things like PATH records, stash that audit_context in the io_kiocb
> > struct, and then restore it later when io_uring does/finishes the
> > operation.  I'm reasonably confident that we don't need to do it for
> > all of the io_uring ops, just the !audit_skip case.
> >
> > I'm always open to ideas, but everything else I can think of is either
> > far too op-specific to be maintainable long term, a performance
> > nightmare, or just plain wrong with respect to the audit records.
> >
> > I keep hoping to have some time to code it up properly, but so far
> > this year has been an exercise in "I'll just put this fire over here
> > with the other fire".  Believe it or not, this is at the top of my
> > TODO list, perhaps this week I can dedicate some time to this.
>
> What are the requirements regarding the order of audit_names in
> the ->names_list?

Uncertain.  As things currently stand there isn't really an explicit
ordering between the PATH records and the syscall, there is the
implicit order in which the PATH records appear in the event, but I
don't know that I would read too much into that.

From my point of view, stuff like that is largely driven by enterprise
distros chasing 3rd party security certifications so they can sell
products/services to a certain class of users.  These are the same
enterprise distros that haven't really bothered to contribute a lot to
the upstream Linux kernel's audit subsystem lately so I'm not going to
worry too much about them at this point.

> I really don't like the idea of having struct filename
> tied to audit_context - io_uring is not the only context where it might
> make sense to treat struct filename as first-class citizens.

From an audit perspective this is larger than just path walks, if I
recall previous conversations correctly, there was also an issue with
sockaddrs (slightly different problem, same solution).

I'm not opposed to seeing better support for struct filename, I think
in a lot of cases that would make things easier for audit (especially
where I would like to take audit ... eventually).  Assuming your ideas
for struct filename don't significantly break audit you can consider
me supportive so long as we still have a way to take a struct filename
reference inside the audit_context; we need to keep that ref until
syscall/io_uring-op exit time as we can't be certain if we need to log
the PATH until we know the success/fail status of the operation (among
other things).

> And having everything that passed through getname()/getname_kernel()
> shoved into ->names_list leads to very odd behaviour, especially with
> audit_names conversions in audit_inode()/audit_inode_child().
>
> Look at the handling of AUDIT_DEV{MAJOR,MINOR} or AUDIT_OBJ_{UID,GID}
> or AUDIT_COMPARE_..._TO_OBJ; should they really apply to audit_names
> resulting from copying the symlink body into the kernel?  And if they
> should be applied to audit_names instance that had never been associated
> with any inode, should that depend upon the string in those being
> equal to another argument of the same syscall?
>
> I'm going through the kernel/auditsc.c right now, but it's more of
> a "document what it does" - I don't have the specs and I certainly
> don't remember such details.

My approach to audit is "do what makes sense for a normal person", if
somebody needs silly behavior to satisfy some security cert then they
can get involved in upstream development and send me patches that
don't suck.

--=20
paul-moore.com

