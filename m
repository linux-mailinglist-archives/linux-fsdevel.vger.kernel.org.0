Return-Path: <linux-fsdevel+bounces-11312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36D852944
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32641F242D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC669175A4;
	Tue, 13 Feb 2024 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH09NsW9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3A1758D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707806563; cv=none; b=BVaKa62bQHgsz51uckWEc9wC7ZYZfGgdz9TzeD5WOpcofk+OhDas849k0TbIQ4ufglzbHd9yueoP6l06CIdnMbGOe0/K92z0SAlQ55yfy48gUB4X/5mPE9zTP1yAFgo+mPOYMIEct3SgeJyIx0hJPtUIqHkOJqyRJ+5dtsQwCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707806563; c=relaxed/simple;
	bh=oXgPf6fYGQchMTLSu5UMjLwZ+li2Db1hHRl4reaKyIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyzaFtQaPd88f+mFTfqye5f5MhO841GZUMY1dHNm3iWhCpKMQ8Q8ZJDN2H6DD9H4Dt7JuDX9WZ2nPI5vI8SvgCmhzUk8nlOUhSUSWkbmjbHt8uaw7KIqnmnGnqDKdtEVas6ZjMXkepTfQdFtUDRXPSnj8iri+EtejHbA3HWWnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH09NsW9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42bf5d7869eso23247111cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 22:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707806560; x=1708411360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNceHmkqRdtNMVEe2BBTDSbb6J/F543ijQYFEGdptwM=;
        b=TH09NsW9P+zfutS5Y7VT1zDYBeYiiXEJBuibEtYtJN9rXWYnvofoDDbpAX2NH3XjWd
         OLVSgLBCPBRu7ATwJSiz4G+VtDqpo2TqiBdmEd5jPeXuSB7XJ1IpNlrhuGWdYqtr+qb6
         pkvA3MVygdg/K/5/72haqnJQsjQp96S2C5hCa9W7Zz6uE4ILX3WLqcVhpZii0fqSw0FH
         1T9YKiKrhzErJae1IAbxsCxLwRmPPsdCWm6HfpCi/coJpPJiOjPHcUbASM4i/983Fy9n
         TrlsSmVORhY86TQfudYMRcDYxtZ/Dlcbq71Il3/f+Rf7LlPqC6RK3olBUU+59p1qfVFB
         By9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707806560; x=1708411360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNceHmkqRdtNMVEe2BBTDSbb6J/F543ijQYFEGdptwM=;
        b=VhWBWa/Arnm8XWeIYhz1C2ZBdPTVeSqHwFqNMsDfl33dVViUVjkCkxLSJ2C3yvVCOC
         2zD0qfRR08vzigWutAIU+S247cSrtkI9Mz9a7LnlVeXU102r3ufKKJ1L2hbSIb+GHAX4
         C5z8+56vzSQBBUJg1beLnCDTXbQCwNaehFS9amOWeuQJe5uqPKgDTa8/DODCBXs5cUp/
         b5FMgjj7uUizkc30XOx7NlODyFbTXa1LRuPO9lsBhIRVDieFL/kEI2Vd6Fh8m/yt0d6r
         q2+jGbIW7P0uYc571SbmTtQzcR81tRvRwYu+0IqwmYOf/g32bww7bbQOQa973/YbnQ4Q
         iqBw==
X-Forwarded-Encrypted: i=1; AJvYcCX6xa2FW0EUkgJO+mVy42rJfbUf9s9gV9dJIdDBa83OnScg80v6rbC0hiuC6j+3QEhxxVWmBkg8UFSIyFJczjn3jbYovwnG1i4DF0T4Gg==
X-Gm-Message-State: AOJu0YwVM9DKMqgT30x/tYKz+QbVF27ep1jsLSStLUbj9Qfo1S4KxoyC
	QqPwa+bffypAnYcYGMXEmHuxuvBtmMRjGeIut2YvmiUS8foxWmIhB1RUVJ2FWmHkMzStqdVRTvj
	QqAEnGOtJASpc9QJc02lQiEcP0/0=
X-Google-Smtp-Source: AGHT+IHSqmjaO7W0OVypmTYPGC38kipfqj6JxCCfNOgqfQFrprx5xkzn9vr+EtpLvC+G8ghIqd41063vaDl5Wx/h1ME=
X-Received: by 2002:ac8:5a47:0:b0:42c:781e:878d with SMTP id
 o7-20020ac85a47000000b0042c781e878dmr6871594qta.26.1707806560481; Mon, 12 Feb
 2024 22:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210100643.2207350-1-amir73il@gmail.com> <20240210232718.GG608142@ZenIV>
 <CAOQ4uxhs9y27Z5VWm=5dA-VL61-YthtNK14_-7URWs3be53QFw@mail.gmail.com>
 <20240211184438.GH608142@ZenIV> <CAOQ4uxhizxoZWKrcRkpC641evkFBx-oZynm1r1htWBE7hNXc-g@mail.gmail.com>
 <20240212080926.GJ608142@ZenIV> <20240213044214.GA1768094@ZenIV>
In-Reply-To: <20240213044214.GA1768094@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 13 Feb 2024 08:42:29 +0200
Message-ID: <CAOQ4uxin1cewTHKqNTQ3E1_mpim2aPjuDGY+5P3HUhrkk+0HTg@mail.gmail.com>
Subject: Re: [PATCH] dcache: rename d_genocide()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:42=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Mon, Feb 12, 2024 at 08:09:26AM +0000, Al Viro wrote:
>
> > Bloody bad idea, IMO.  Note that straight use of kill_anon_super()
> > pretty much forces you into doing everything from ->put_super().
> > And that leads to rather clumsy failure exits in foo_fill_super(),
> > since you *won't* get ->put_super() called unless you've got to
> > setting ->s_root.
> >
> > Considering how easily the failure exits rot, I'd rather discourage
> > that variant.
>
> BTW, take a look at fs/ext2/super.c and compare the mess in failure
> exits in ext2_fill_super() with ext2_put_super().  See the amount of
> duplication?
>
> In case of ext2_fill_super() success eventual ->kill_sb() will call
> ->put_super() (from generic_shutdown_super(), from kill_block_super()).
>
> What happens in case of ext2_fill_super() failure?  ->kill_sb() is called=
,
> but ->put_super() is only called if ->s_root is non-NULL (and at the very
> least it requires ->s_op to have been set).  So in that case we have
> ext2_fill_super() manually undo the allocations, etc. it had managed to d=
o,
> same as ext2_put_super() would've done.
>
> If that stuff gets lifted into ->kill_sb(), we get the bulk of ext2_put_s=
uper()
> moved into ext2_kill_super() (I wouldn't be surprised if ext2_put_super()
> completely disappeared, actually), with all those goto failed_mount<somet=
hing>
> in ext2_fill_super() turning into plain return -E...

That sounds good, but I am not sure what you are advocating for?

What I wrote is that if kill_litter_super() becomes an alias of
kill_anon_super(),
then spraying kill_{anon,block}_super() automatically for new fs does not m=
ake
much sense from API POV.

It sounds like you are suggesting that the use of
kill_{anon,block}_super() should
be discouraged and that ext2 could be used to set an example.
I did not understand if you are suggesting API changes to encourage customi=
zed
->kill_sb()?

Thanks,
Amir.

