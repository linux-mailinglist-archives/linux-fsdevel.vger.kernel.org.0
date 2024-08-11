Return-Path: <linux-fsdevel+bounces-25608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1752394E39E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 00:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA501C20AC1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176CA15FCE7;
	Sun, 11 Aug 2024 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d3uGLSBm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8741C75
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2024 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723413887; cv=none; b=NaWAefu9xkj6aTrgdsclR8t0B+D9Q3VrxlPe+JfLc7/yAmfEwwrl6UFMFkxu5SLGTLok79CWoKTS9wO0AUdQe326niapNSaJn5W9Fnp8un6C7YCE2+4mja34+tPHl/26YzpVzcK8zbdTu11FkJQvb5XQOG+cp81FsGaxZ6LgYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723413887; c=relaxed/simple;
	bh=mjPzQh3zJdKltirt+QHNSwjQaJ8ZHl0cmjRwRp4LBeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTchopfVXfFB1b91sIdx0IC+znbAzdOyVndxhb8RsnQqspcNEG3Y/01BzQMDUGXFOCxFUHYFm8gfqCqZzVAZlKFjtaxNRAr2a/5Ugw+J66H1W8IufC2BooA6xzR0r+DWXFDm8sbyh+QS068mrAmO6Q+Pq9XrCn5ITCRu6eR714o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d3uGLSBm; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e08a538bf7bso3594007276.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2024 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723413885; x=1724018685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MTvCp16xe4s8tj8cdyJ3RRjmDsFaj02tw+pbvvViL0=;
        b=d3uGLSBmkqbWvkR9emtvfFpAd758ZUmUQ6/ghSCxp997M0jUpfsn+vP9WbxS2m6uBx
         jOThi5s09frpxhZRw3t6gcd8UvLLQrV4Bd6PZzytOF0fBMstmfGyTV1J9/z9d3D/VyAD
         A0Q/iYXmS50uPLXbEtcsDljSeys9gR72IDxRgxnqoVdUJB3TbVtTdda0pWQGjt0Z6ova
         YzocJ4ePYwC9zBkmQEAcGnhO++TKa/71wUX+GbdNcfWau0AmzsGSa4NIqorPjINyRHWK
         /+3JHNZi0KoyVRW6xkkPhtxDlozGS6hER7qlOjOdhPwPTyXtJ1LwteuBBQlo7fmgu+PB
         q/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723413885; x=1724018685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MTvCp16xe4s8tj8cdyJ3RRjmDsFaj02tw+pbvvViL0=;
        b=u4ACniKj5IJ1UBL8hEPGuGomFOqiTkZNvKNOZXnBCoir9I4wNkhLQyZ2lX2hek9cL+
         7c+2CHDgEJh2fN1NFbKWxAOFX2LSyDYyffbUkjNjwWcz8S7kLaw71o34r5qbb9GM9AhK
         eNfyuXJOO2nBc6Q8Py3EuZ+BSbh+5Zt5Cco9qJNjJeSJftxqCpuVNRwpJpPEnCNR9HFu
         dv0imJYN9dLUBNsaz4ksv1HZcRzUrnygK1aZyeHqIMGrrnzMyMXg8zuM6vWiSgHJM0SH
         6ofkIlHaL9dL6duwyhOJc4Ppg489Yc1KnrFDNdnW3DOvTPpXNggyTTFsU50J+SCYbNFz
         jDaA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Ek70aZPMBudK2R79cbCx/7y+764X+aNq/pqTW1eJ9LLJhirGUoIaBRwRZ/1tc3Q4zngPopSUabg8nUWq@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAh7uNl7L1JgCM/886CYyKW6LicRL0QqxaES45ZvYdCYEiSRg
	Uirl5N2vx3WNmQ/sNzUawYWD3I7xTn/RqxSFxy+QpWrJBV47yeWQTVMvr6efWuzdKYRBfhR7T2V
	v4beO5srZEUyYMzcpCzrygG6FajEThAZVjV17/vXF9SpdcgA=
X-Google-Smtp-Source: AGHT+IHyjpnn1PIJQvOaEQGSYhVNf1jkFokG+Mtlcnvj9pmFNQeJBtS+bJqawYBxtJdKf9F1jwGjp9W8zNFTE0mREac=
X-Received: by 2002:a05:690c:4d05:b0:665:71a4:21ac with SMTP id
 00721157ae682-69c0e36eab8mr89308447b3.10.1723413885015; Sun, 11 Aug 2024
 15:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net> <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net> <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net> <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net> <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
In-Reply-To: <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 11 Aug 2024 18:04:34 -0400
Message-ID: <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
To: Jann Horn <jannh@google.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 10:01=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
> On Fri, Aug 9, 2024 at 3:18=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> > Talking about f_modown() and security_file_set_fowner(), it looks like
> > there are some issues:
> >
> > On Fri, Aug 09, 2024 at 02:44:06PM +0200, Jann Horn wrote:
> > > On Fri, Aug 9, 2024 at 12:59=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
> >
> > [...]
> >
> > > > BTW, I don't understand why neither SELinux nor Smack use (explicit=
)
> > > > atomic operations nor lock.
> > >
> > > Yeah, I think they're sloppy and kinda wrong - but it sorta works in
> > > practice mostly because they don't have to do any refcounting around
> > > this?
> > >
> > > > And it looks weird that
> > > > security_file_set_fowner() isn't called by f_modown() with the same
> > > > locking to avoid races.
> > >
> > > True. I imagine maybe the thought behind this design could have been
> > > that LSMs should have their own locking, and that calling an LSM hook
> > > with IRQs off is a little weird? But the way the LSMs actually use th=
e
> > > hook now, it might make sense to call the LSM with the lock held and
> > > IRQs off...
> > >
> >
> > Would it be OK (for VFS, SELinux, and Smack maintainers) to move the
> > security_file_set_fowner() call into f_modown(), especially where
> > UID/EUID are populated.  That would only call security_file_set_fowner(=
)
> > when the fown is actually set, which I think could also fix a bug for
> > SELinux and Smack.
> >
> > Could we replace the uid and euid fields with a pointer to the current
> > credentials?  This would enables LSMs to not copy the same kind of
> > credential informations and save some memory, simplify credential
> > management, and improve consistency.
>
> To clarify: These two paragraphs are supposed to be two alternative
> options, right? One option is to call security_file_set_fowner() with
> the lock held, the other option is to completely rip out the
> security_file_set_fowner() hook and instead let the VFS provide LSMs
> with the creds they need for the file_send_sigiotask hook?

I'm not entirely clear on what is being proposed either.  Some quick
pseudo code might do wonders here to help clarify things.

From a LSM perspective I suspect we are always going to need some sort
of hook in the F_SETOWN code path as the LSM needs to potentially
capture state/attributes/something-LSM-specific at that
context/point-in-time.  While I think it is okay if we want to
consider relocating the security_file_set_fowner() within the F_SETOWN
call path, I don't think we can remove it, even if we add additional
LSM security blobs.

--=20
paul-moore.com

