Return-Path: <linux-fsdevel+bounces-32079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B69A04FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 11:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F4E1C235B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663120513A;
	Wed, 16 Oct 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHYXwYcC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA422038A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069390; cv=none; b=bWwcfEFMV97l3vuEL5Vcq0XyNJ13UolbloiyKDaEKEnZ2igvI1Y7p49Fxk9n13oE0RcL49I3AKFuGokhHjlrqVZKKxewNc09sa3KarqNSkUDn4fnenGUSDMd0jzXi7/a0A5OlRYLrnsOtb71UepPosk77WgPcCCGipxByNy51KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069390; c=relaxed/simple;
	bh=xKYlyx41TXsMs9X7CxDeUVqKXgRQY6ojj41R/XQ/QKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHzhL7UwMlXrsxClyBonRu8F6TbjRuhPm97tVyqk1hIg/TS6+aEaHUyJkrXEYIInlYHSda6ziUh/aE+xFW3trElnWc1hVlemFLzL7UaiTNHk2DNT+DIg3qoykzHM5QvKdi75rxQzwu6BkbH+KK9WjFXuqUehjtSsJZrsCwkATl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHYXwYcC; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460969c49f2so14721cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 02:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729069388; x=1729674188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQzk1mC3owj3LLPZ/BCuWHHnPyypCT2nSfTPIIH7T8I=;
        b=DHYXwYcClTM/GJycv7lHpkm1kSR5pgIeOVa/DfaincPUEWViDaZ9Zgv24kw2HplshS
         7fW245+E8f5KVDxMNUip9FgltYHH51LHs5wvu4JOpx/4XBxcbok3LP1FGw81u1yNSzg6
         E7jIl1m4MyzGQjS/+12bc5N1v+yVaNO4kq+u9OCB0UHtLzG9iSEEshlo6wAAoHpmHmT1
         pT7dhl4RGqHwwOAFn1/VK1qfWIgSHCKo0gdHrxpAHyNvV71nePO28qnr23XiAG0zxLbi
         bo4Xrbw8TJ8KUvCKfcDdsqTJJiZvxtppUWP0tvrvkCICBfVsRvCGP2zlPNDdpXxeX+k1
         I3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729069388; x=1729674188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQzk1mC3owj3LLPZ/BCuWHHnPyypCT2nSfTPIIH7T8I=;
        b=A3BuWquH0/G8WzBODJ4Ux1dR4K3GI+5GkbuJ/21afzkkKkOztBiagt1GhsHn68rWtA
         xKzBVtvxXbPyWf5UrIu7BSn1wzY09EXS8UrODvwCHIjMF1xbfRVdFY1f1A6LCbW0zAxS
         /GO5/zRN7Ir/qpxnsPJPYD0jKSCrpKaRAZbMkGa3phrNSOXVYk+jZmVYiTqX7WGA71H5
         afJwyqC8TqjsT7PSnD5enKX1bSgPQdlBJ2dKSs4S/FAISybWGFZyVEvg4CqqRYOt44UQ
         fl0bdihcqsL48T1SeYShtSyMIrB621k+Qv1WPG7BzaEOKpH8UsUShZjSnFK0PvQ/HxS4
         CAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt/UhKZJTZKXJC6qr0TV9kVeW+o5FgziCli4U+O/XWbptqdWVQJeJ3BaRdNi/wO6L2/OhbZn7mGg0h6XNC@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2ZM1G6Urrsxt1ltd7N5DzA8f5Bn8bwmTHPippudRFr6Bknq0
	+TKpcT3yC3OIfhr6Of5kYnBvWLL+2Q5NaIG35lSZ+x8NrHhxYwKRfvidchUs429LHG00A1EI9yz
	gqHFK7Y1CKgQH0/ePqasA6GG7euju3RvHaTu4
X-Google-Smtp-Source: AGHT+IGQwHZYMLkrq47J9La85UHo65QEVMsbmYO1OzZX/TON+QFYFXyDU/l6AztqtH0WBcKUZcDBByYr856yGpXnk9Q=
X-Received: by 2002:a05:622a:2e8c:b0:453:56e7:c62b with SMTP id
 d75a77b69052e-4608db34c61mr3384901cf.12.1729069387837; Wed, 16 Oct 2024
 02:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
 <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpHLGyrBWZ9JyJ5FdJQtGO1-tuUqHawjKX_mtwnAhSY6Ow@mail.gmail.com>
 <8c75620d-8920-4c19-8ebc-0f2b056d49fa@lucifer.local> <CAJuCfpFXCKAH+fc6=fg-nVC5tjpGG--Pvk4D2NOn-zdA1LXS=Q@mail.gmail.com>
 <2c783f7d-78d4-4d91-9999-12d7772b6272@lucifer.local>
In-Reply-To: <2c783f7d-78d4-4d91-9999-12d7772b6272@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Oct 2024 02:02:56 -0700
Message-ID: <CAJuCfpGnjj_aVuBhBLO-PJL7yF=oaOgf7t8YHAXSf4hckDWpTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:22=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Oct 16, 2024 at 01:16:15AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Oct 15, 2024 at 11:05=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Tue, Oct 15, 2024 at 12:40:41PM -0700, Suren Baghdasaryan wrote:
> > > [snip]
> > > > > -struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
> > > > > +struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
> > > > > +                           bool allow_proc, unsigned int *flags,
> > > > > +                           struct fd *fd)
> > > > >  {
> > > > > -       struct fd f;
> > > > > +       struct file *file;
> > > > >         struct pid *pid;
> > > > > +       struct fd f =3D fdget(pidfd);
> > > > >
> > > > > -       f =3D fdget(fd);
> > > > > -       if (!fd_file(f))
> > > > > +       file =3D fd_file(f);
> > > > > +       if (!file)
> > > > >                 return ERR_PTR(-EBADF);
> > > > >
> > > > > -       pid =3D pidfd_pid(fd_file(f));
> > > > > -       if (!IS_ERR(pid)) {
> > > > > -               get_pid(pid);
> > > > > -               *flags =3D fd_file(f)->f_flags;
> > > > > +       pid =3D pidfd_pid(file);
> > > > > +       /* If we allow opening a pidfd via /proc/<pid>, do so. */
> > > > > +       if (IS_ERR(pid) && allow_proc)
> > > > > +               pid =3D tgid_pidfd_to_pid(file);
> > > > > +
> > > > > +       if (IS_ERR(pid)) {
> > > > > +               fdput(f);
> > > > > +               return pid;
> > > > >         }
> > > > >
> > > > > -       fdput(f);
> > > > > +       if (pin_pid)
> > > > > +               get_pid(pid);
> > > > > +       else
> > > > > +               WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd a=
round? */
> > > > > +
> > > > > +       if (flags)
> > > > > +               *flags =3D file->f_flags;
> > > > > +
> > > > > +       /*
> > > > > +        * If the user provides an fd output then it will handle =
decrementing
> > > > > +        * its reference counter.
> > > > > +        */
> > > > > +       if (fd)
> > > > > +               *fd =3D f;
> > > > > +       else
> > > > > +               /* Otherwise we release it. */
> > > > > +               fdput(f);
> > > > > +
> > > > >         return pid;
> > > > >  }
> > > >
> > > > There is an EXPORT_SYMBOL_GPL(pidfd_get_pid) right after this line.=
 It
> > > > should also be changed to EXPORT_SYMBOL_GPL(__pidfd_get_pid),
> > > > otherwise __pidfd_get_pid() will not be exported. A module calling
> > > > pidfd_get_pid() now inlined in the header file will try to call
> > > > __pidfd_get_pid() and will have trouble resolving this symbol.
> > >
> > > Hmm hang on not there isn't? I don't see that anywhere?
> >
> > Doh! Sorry, I didn't realize the export was an out-of-tree Android
> > change. Never mind...
>
> No probs :P just glad I didn't miss something in this series!
>
> Hey maybe a motivation to upstream some of this? ;)

I wish... Without an upstream user the exports are not accepted
upstream and unfortunately Android vendors often resist upstreaming
their modules.

>
> >
> > >
> > > [snip]

