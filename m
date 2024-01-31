Return-Path: <linux-fsdevel+bounces-9658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121518441F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DF61C2479A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C773383CBD;
	Wed, 31 Jan 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj4I9eDx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D96D1BA;
	Wed, 31 Jan 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711705; cv=none; b=t/T2qF10j8mmCvyR086tRlpuxatUB8wUgV6CZqhqYOmhYZvJvL1Y3JdEUZ4s3rn2C5N/ZtEUCxYDznK//wo/UVVdr7v2Ennv1E6m3Njn0z6UWgh63tDr58/mVp6mUl+F+9j+xHkWL8YsXE3/X0kFe/sCQM7hyUqZTFPkdEq17vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711705; c=relaxed/simple;
	bh=5EyZ4q/r+00v48OOg68MHvCQQPBQznBdJrnWimHOvoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CH8Gb31O5Ho94/DSm6JEm6sbR+ejL7m4beGALwp3U2EA1wFKb3gTFFgZCeYzHw9Rl3xnUHpQ66gmqcarokkJNvU0cyiy4r//LsJq7h6wjcRaN5nt9czn/hyjK+ch4ZPpi6gGXnIU/9ojcHD1dRBJok+idla4w2PSdYVf/+fSQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj4I9eDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C11C4166B;
	Wed, 31 Jan 2024 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706711704;
	bh=5EyZ4q/r+00v48OOg68MHvCQQPBQznBdJrnWimHOvoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xj4I9eDx/4HbEu8yhW2vQwS+czjQUDgteKSBPmAbcovkQDof4vKf+Nti93zCxqUFy
	 8E1Mj2HVi6RuOgtLEDRS6zU9DOo9UxOfTl3GF9CkBNanL4l5F8UoUx1KrKXXLt2i2U
	 QnSISdzQ04gQcHg39wQEs8qgdWVmlUTnN4etJo2k2D4fH2Zq8wh/KsRdbJfE9BZhqf
	 wSLrMcR1e/pyRGTN71NKaOW1dupGCC6GoL9KwXzg+T9VFWwk6CPnbVno4VAvjIxm/E
	 MkoGE8E4K5R88GIEhHdMDOn5hcozFNO/DhJ6spBg4F8LISArQUeNl8DwwemWCp403U
	 gnR48sug9RyqQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5111c7d40deso2823136e87.1;
        Wed, 31 Jan 2024 06:35:04 -0800 (PST)
X-Gm-Message-State: AOJu0YziwdGS6FqXazxxX9FwgdjIU8qcykRyBJwmNmMEVR6iBxdj9Ao5
	TGrppM/pbG8USJFuoIG9fuN53fUD1C4GstX9Hr83CDgbQ2JeZV0d24Gx7QCOnkwWKKaWFqSve+7
	lm3ZHroHJw6Bd2KDMGVLZNSnaSP4=
X-Google-Smtp-Source: AGHT+IEkwiOzDm1WmVB86bThpXr2CAgij+DEoMyglGf+T50CfsxJDx5eAUUePpr4rorcPUAIloSWUuLFizuX2LC6Lk4=
X-Received: by 2002:a05:6512:470:b0:511:e8f:45ca with SMTP id
 x16-20020a056512047000b005110e8f45camr1454123lfd.31.1706711702790; Wed, 31
 Jan 2024 06:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127220026.1722399-1-yoann.congal@smile.fr> <ZbfLl6PR_qxxreeX@bombadil.infradead.org>
In-Reply-To: <ZbfLl6PR_qxxreeX@bombadil.infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 31 Jan 2024 23:34:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR=YgBR=FYeZ+HKuFYOP3ad0K0tmqtsuHD6N-cHW5QoNQ@mail.gmail.com>
Message-ID: <CAK7LNAR=YgBR=FYeZ+HKuFYOP3ad0K0tmqtsuHD6N-cHW5QoNQ@mail.gmail.com>
Subject: Re: [PATCH v2] printk: Remove redundant CONFIG_BASE_SMALL
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Yoann Congal <yoann.congal@smile.fr>, Josh Triplett <josh@joshtriplett.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:00=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> You wanna address the printk maintainers, which I've added now.
> And Josh as he's interested in tiny linux.
>
> On Sat, Jan 27, 2024 at 11:00:26PM +0100, Yoann Congal wrote:
> > CONFIG_BASE_SMALL is currently a type int but is only used as a boolean
> > equivalent to !CONFIG_BASE_FULL.
> >
> > So, remove it entirely and move every usage to !CONFIG_BASE_FULL.
>
> Thanks for doing this.
>
> > In addition, recent kconfig changes (see the discussion in Closes: tag)
> > revealed that using:
> >   config SOMETHING
> >      default "some value" if X
> > does not work as expected if X is not of type bool.
>
> We should see if we can get kconfig to warn on this type of use.
> Also note that this was reported long ago by Vegard Nossum but he
> never really sent a fix [0] as I suggested, so thanks for doing this
> work.
>
> [0] https://lkml.iu.edu/hypermail/linux/kernel/2110.2/02402.html



It is good to know that this issue was already pointed out
in the past.



> You should mention the one case which this patch fixes is:
>
> > CONFIG_BASE_SMALL was used that way in init/Kconfig:
> >   config LOG_CPU_MAX_BUF_SHIFT
> >       default 12 if !BASE_SMALL
> >       default 0 if BASE_SMALL
>
> You should then mention this has been using 12 for a long time now
> for BASE_SMALL, and so this patch is a functional fix for those
> who used BASE_SMALL and wanted a smaller printk buffer contribtion per
> cpu. The contribution was only per CPU, and since BASE_SMALL systems
> likely don't have many CPUs the impact of this was relatively small,
> 4 KiB per CPU.  This patch fixes that back down to 0 KiB per CPU.
>
> So in practice I'd imagine this fix is not critical to stable. However
> if folks do want it backported I'll note BAS_FULL has been around since
> we started with git on Linux so it should backport just fine.
>
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 8d4e836e1b6b1..877b3f6f0e605 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -734,8 +734,8 @@ config LOG_CPU_MAX_BUF_SHIFT
> >       int "CPU kernel log buffer size contribution (13 =3D> 8 KB, 17 =
=3D> 128KB)"
> >       depends on SMP
> >       range 0 21
> > -     default 12 if !BASE_SMALL
> > -     default 0 if BASE_SMALL
> > +     default 12 if BASE_FULL
> > +     default 0
> >       depends on PRINTK
> >       help
> >         This option allows to increase the default ring buffer size
>
> This is the only functional change, it is a fix, so please address
> this in a separate small patch where you can go into all the above
> details about its issue and implications of fixing this as per my
> note above.
>
> Then you can address a separate patch which addresses the move of
> BASE_SMALL users to BASE_FULL so to remove BASE_SMALL, that is
> because that commit would have no functional changes and it makes
> it easier to review.
>
>   Luis



Splitting this into two patches sounds fine to me.
Either is fine. Up to the printk maintainer.

Anyway, this patch looks good:

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>







--=20
Best Regards
Masahiro Yamada

