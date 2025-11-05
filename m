Return-Path: <linux-fsdevel+bounces-67152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F060FC366F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 16:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244CA1A436B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C228330B24;
	Wed,  5 Nov 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVwiSsN+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA5329E71
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356667; cv=none; b=rJKpMMWhwN/wVbypFnAD0HOqWh7ZTdgVSYYYKfltYE9ZhlW/ZluPvSOVWFxdFNFwjrqUxe8r0zg6GeBd4aHH7t4CZukRkWeKvyCupxIqUptqlpMrKf77eCKgWdT89VHqCXpB0ZRjQILfWcScJ55d6GPpA0Ff+QCqULG59MQQMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356667; c=relaxed/simple;
	bh=yEbFUxhU5133fiA2wgh8p34cECSDXHmt2efF/soZEWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnqygN8F617nRLyizuYQlXhf29B2yrj3yNb/QzEc5NhJdzfuhNNf6msifP9oXXXaMGOp5raEpro1tDCL2MCWX+AL5l6kIISa2VFxw9DexLtgHCjaBSYY/kxR/T9b7osMAM8Tyb2yGspdIl8SXSxzwtwfY8ERGHmoIpli2AvLLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVwiSsN+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so6294055a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762356664; x=1762961464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+z52qtWPifN7YndFewUQfgP4BQqbdcxKI4xG7v6Wtg=;
        b=eVwiSsN+GH8oJYCNas3zxtrCrX0AUwANIXnNhcBdE3wS/5BM00oSTOodxUCLpvEFwr
         KvT48Ugzrtk28loE5qXKQajpXmSphrPQhUiOwXJFC9VbDpVfDvVWI8KiygUsJKs3i3/a
         S7a1bD1/QuVIPOyK7HJBzf1V9msgScbN35whwg2x4Wzhh7hR27icBViCLS2zQmEP43lY
         tOARD1Sowew6P50lMybQ82ANtCv8Bf1zNLKKys51qhzuz4kmf8A0RIV6C4Ww5vew/CY5
         bwU9qr79jEUq/XE3np9X5wSiOBDrfCkLhRHPCgEWrVG1K8ormbxmZzQS6EplQc4moY/L
         y1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356664; x=1762961464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+z52qtWPifN7YndFewUQfgP4BQqbdcxKI4xG7v6Wtg=;
        b=ZYy4QD69TxYetlPXEMI35UYWL3zGUDz7yElYTONX6ebrrkkkKCzXYhaedit6DPAKub
         9Pb9k1IKdh6mvRtQq2yXLzE3RQfC/EqBw0ZoVKG3NvKgSvrdeIAXJhbR4D2HiPsxWoJq
         hE+Pl9MFF27PORvfKEFawTQRyp7CqZN8FxoAXxqv1+xe0StBVPd7ErJC4t5KBu3+YlkD
         zMKYia9LU0EedRCdcACpJqxzo4HEXIYzdTtqPvQFc44xbhZKXCoz0YuFF0Y5T6jGjOKb
         vls5+SnWJqs4CQth5Am6tYpQ1Wrwrq+DzshTkpoUZ1Ke9FQIx4Lai2pDUXwhkIqxvWP4
         4wRA==
X-Forwarded-Encrypted: i=1; AJvYcCW/3mvo+lmTVMuNkC4f2w8nMvkCoJMkRRHWLiC/Udv4EkwIzSAkQKuovTigAgooVrPlQrTNrxa4yK7y91pk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1x0IE5rXBfW9CZdcUgXb8+/Fo5cFIqHg0rx3Rqi4HIm2w5vwa
	prfCxW+3bfBzi3olhMOMmfuP3EJskMF8ZComo+xm9zGtboP6QykcXgo/Jilz7Wu8sPgsOF61bGx
	4Mo7o4r0punSB516sJ1Lm6bm2YXgttJA=
X-Gm-Gg: ASbGncvbdpGFY/kgLZ/NJkA6Q/ekssiJtGJcu3JRAqFzjQpcHx/mvjwhokAgQPw5eHX
	aCSFBv2njLLpCmYWy5PQEY5ryX89AMD+OahqZ8penhlxhQuPFLoEq4bSPkKf+oojAsI/kYvmSed
	KpYo6DCYAZYef2lqYnzZjuid3CGbNHeKQaenDPnwILOhseudQMBwm2aNXHtib8CrLQXPACFeiXg
	twY4k+gWWkc9pO8OTT9+xJhurDi6tsBfHiP+72Yuoo5jW7lvmNhkr5YwmuKr2T5CLJirPNYKq7r
	lpOd/XHfP3AAM+C/xAE=
X-Google-Smtp-Source: AGHT+IFeTdBoWoUyL5OJBj6ctpxjIzpxH5YSlDQbMjLCXNftce5Xam58H6eehckj8yuunQCZvowB+AKwBvBeUXEftyg=
X-Received: by 2002:a05:6402:1462:b0:640:b978:efdb with SMTP id
 4fb4d7f45d1cf-64105b80a61mr3309961a12.25.1762356663555; Wed, 05 Nov 2025
 07:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731130458.GE273706@mit.edu> <20250731173858.GE2672029@frogsfrogsfrogs>
 <8734abgxfl.fsf@igalia.com> <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
 <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
 <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com> <20250912145857.GQ8117@frogsfrogsfrogs>
 <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
 <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com> <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs> <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp> <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <87cy5x7sud.fsf@wotan.olymp> <CAOQ4uxjZ0B5TwV+HiWsUpBuFuZJZ_e4Bm_QfNn4crDoVAfkA9Q@mail.gmail.com>
 <87ecqcpujw.fsf@wotan.olymp>
In-Reply-To: <87ecqcpujw.fsf@wotan.olymp>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 5 Nov 2025 16:30:51 +0100
X-Gm-Features: AWmQ_bllL0jRg0lG2IquSuf9WxK56YqDrwheMrE1Nh3n-OXTi4UNNbtnbhoiVQo
Message-ID: <CAOQ4uxg+w5LHnVbYGLc_pq+zfAw5UXbfo0M2=dxFGKLmBvJ+5Q@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Luis Henriques <luis@igalia.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>, 
	Matt Harvey <mharvey@jumptrading.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:50=E2=80=AFPM Luis Henriques <luis@igalia.com> wr=
ote:
>
> Hi Amir,
>
> On Wed, Nov 05 2025, Amir Goldstein wrote:
>
> > On Tue, Nov 4, 2025 at 3:52=E2=80=AFPM Luis Henriques <luis@igalia.com>=
 wrote:
>
> <...>
>
> >> > fuse_entry_out was extended once and fuse_reply_entry()
> >> > sends the size of the struct.
> >>
> >> So, if I'm understanding you correctly, you're suggesting to extend
> >> fuse_entry_out to add the new handle (a 'size' field + the actual hand=
le).
> >
> > Well it depends...
> >
> > There are several ways to do it.
> > I would really like to get Miklos and Bernd's opinion on the preferred =
way.
>
> Sure, all feedback is welcome!
>
> > So far, it looks like the client determines the size of the output args=
.
> >
> > If we want the server to be able to write a different file handle size
> > per inode that's going to be a bigger challenge.
> >
> > I think it's plenty enough if server and client negotiate a max file ha=
ndle
> > size and then the client always reserves enough space in the output
> > args buffer.
> >
> > One more thing to ask is what is "the actual handle".
> > If "the actual handle" is the variable sized struct file_handle then
> > the size is already available in the file handle header.
>
> Actually, this is exactly what I was trying to mimic for my initial
> attempt.  However, I was not going to do any size negotiation but instead
> define a maximum size for the handle.  See below.
>
> > If it is not, then I think some sort of type or version of the file han=
dles
> > encoding should be negotiated beyond the max handle size.
>
> In my initial stab at this I was going to take a very simple approach and
> hard-code a maximum size for the handle.  This would have the advantage o=
f
> allowing the server to use different sizes for different inodes (though
> I'm not sure how useful that would be in practice).  So, in summary, I
> would define the new handle like this:
>
> /* Same value as MAX_HANDLE_SZ */
> #define FUSE_MAX_HANDLE_SZ 128
>
> struct fuse_file_handle {
>         uint32_t        size;
>         uint32_t        padding;

I think that the handle type is going to be relevant as well.

>         char            handle[FUSE_MAX_HANDLE_SZ];
> };
>
> and this struct would be included in fuse_entry_out.
>
> There's probably a problem with having this (big) fixed size increase to
> fuse_entry_out, but maybe that could be fixed once I have all the other
> details sorted out.  Hopefully I'm not oversimplifying the problem,
> skipping the need for negotiating a handle size.
>

Maybe this fixed size is reasonable for the first version of FUSE protocol
as long as this overhead is NOT added if the server does not opt-in for the
feature.

IOW, allow the server to negotiate FUSE_MAX_HANDLE_SZ or 0,
but keep the negotiation protocol extendable to another value later on.

> >> That's probably a good idea.  I was working towards having the
> >> LOOKUP_HANDLE to be similar to LOOKUP, but extending it so that it wou=
ld
> >> include:
> >>
> >>  - An extra inarg: the parent directory handle.  (To be honest, I'm no=
t
> >>    really sure this would be needed.)
> >
> > Yes, I think you need extra inarg.
> > Why would it not be needed?
> > The problem is that you cannot know if the parent node id in the lookup
> > command is stale after server restart.
>
> Ah, of course.  Hence the need for this extra inarg.
>
> > The thing is that the kernel fuse inode will need to store the file han=
dle,
> > much the same as an NFS client stores the file handle provided by the
> > NFS server.
> >
> > FYI, fanotify has an optimized way to store file handles in
> > struct fanotify_fid_event - small file handles are stored inline
> > and larger file handles can use an external buffer.
> >
> > But fuse does not need to support any size of file handles.
> > For first version we could definitely simplify things by limiting the s=
ize
> > of supported file handles, because server and client need to negotiate
> > the max file handle size anyway.
>
> I'll definitely need to have a look at how fanotify does that.  But I
> guess that if my simplistic approach with a static array is acceptable fo=
r
> now, I'll stick with it for the initial attempt to implement this, and
> eventually revisit it later to do something more clever.
>

What you proposed is the extension of fuse_entry_out for fuse
protocol.

My reference to fanotify_fid_event is meant to explain how to encode
a file handle in fuse_inode in cache, because the fuse_inode_cachep
cannot have variable sized inodes and in most of the cases, a short
inline file handle should be enough.

Therefore, if you limit the support in the first version to something like
FANOTIFY_INLINE_FH_LEN, you can always store the file handle
in fuse_inode and postpone support for bigger file handles to later.

Thanks,
Amir.

