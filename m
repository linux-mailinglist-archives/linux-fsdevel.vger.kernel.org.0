Return-Path: <linux-fsdevel+bounces-31004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0398990AD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A576285800
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23D31DAC82;
	Fri,  4 Oct 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IMDRQgko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD81E377A
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065729; cv=none; b=f3l1XlUxOaD7RQXEFcCH0AqodT+P37SLkkMQllLkeaZcI676gKrJS2DpPhmYlFJz8nOgB3rit8BPZw3/6jq4s3EsnpsEn+c6wKZl5ci6y2H0IBmLVMG0NVBkEqrJGydoDnGBcwsVpXJPCNPS0sbfTCLxY67o9wGoWnu4CC6RL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065729; c=relaxed/simple;
	bh=3UwQQ89w1jlQwkQNC6X6XZvFUhguEtIJjixGD+adfi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4oHaLTf1S4Wo6EN5a8je4Lfpb22EOQDU84kDexojNCPuBcLyqD76952UctXJIwl7TK/aXq3oeYy0GIiAVZ6Fu5z1+KqG2z6kvR9tFqS7/4Yh3drJQvrkdSIlpOsJz3VShw2vh1xbxa2sFpTHjWpXAswt6Kig2P7ZpBCext0eDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IMDRQgko; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6dbb24ee2ebso25792607b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2024 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728065727; x=1728670527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Nl/fJvLy1gro9c4j4uRqIzfbYchCvCeT1u6Esd2ozc=;
        b=IMDRQgkou2yCbc5XK5x1Q65N6uV/y7mPX4Cc2DGY6JqSAVnGdH6YvmEoABMSUCW6Zk
         d99pZExq9ISWyiB+XGS3g7rrPWltReiOGZRuS8FV5wPvT2R5x0cUsOB6QTRgNmLIcK8A
         2IZotsdX4BvuAdUyOzvwsKE4eppjwUrmgJNETcyn+wHPqplgbDybXEaohLK/AF+14v48
         jIxAQkfnMDTnrsZIiuTNL8MtN0Yf8la0+WN62UVuaTnTUgbftvy5pWx1WMmjEL6IyUhU
         34qMnKEAxaOaWSdeKU+7S2ncmyDIPqdoH+V+gSfFwiyRXWvtmBAH748bRuUZ129j/bUK
         lCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728065727; x=1728670527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Nl/fJvLy1gro9c4j4uRqIzfbYchCvCeT1u6Esd2ozc=;
        b=Pt3GkaU5rdIZ0wwYgzOuSMXSZGhbQKhX8cKccUVB1JaLSRlEPusRBYaC0HRAO4nWc1
         xthLDpJYziEmrhlAlGBwMd92jB75ez5+PgzAijscub3j/SYqOuDF+bGEHXoZgG6W76sz
         KoZRnIikidBUiCXEHd2okZ3OFw1ZJjvdwblbIx5PvCq4tpgirOuzTeBsjJHi+2ZsMTc2
         zwTgm1YHXvAGcwD/EV1tmopotZ9r7ANAOI089h2IMD3lo0u+4LZk0mUK1jqHjbf2vnaX
         GZB+CeaRKEWDcJoOXRX7xp3BuftOWkYfWQXKNtjw+ILHuuyG/jAOd5TX/GATjhb23wUu
         mTzw==
X-Forwarded-Encrypted: i=1; AJvYcCWivCWCFN7y+ZBjQqippj7u+OlKFIQSvPz+JoiNwwqj2m9EXkcoH7Ot4QMAdwJJM2YkzdjCculRbpgJDrHa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/glEJxXzSDmayyhYnpraQNZhtreC3/9lqhIieV8KlGvU26ON
	mWstHMLarDoGyj9464yCZwIhcTsVfSNL0eLY6AoL7Apor7/p3zUs/e+NHEffyKKjy64e4+dhIVD
	K+pWCIjXbmEhQ1e/KbFp7AaLPsLpxLxjUlKsO
X-Google-Smtp-Source: AGHT+IFDL2U+AFA8xOQ6lEOVWIMhUrxcSrmU14/lMYge8EW53LmplCLcJ9I9tD7uE5WAzhWwU7Wbzwo1crIZnP2TEoo=
X-Received: by 2002:a05:690c:60c2:b0:6e2:313a:a024 with SMTP id
 00721157ae682-6e2c7296844mr39778377b3.33.1728065726639; Fri, 04 Oct 2024
 11:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003115721.kg2caqgj2xxinnth@quack3> <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3> <Zv6Qe-9O44g6qnSu@infradead.org>
 <20241003125650.jtkqezmtnzfoysb2@quack3> <Zv6jV40xKIJYuePA@dread.disaster.area>
 <20241003161731.kwveypqzu4bivesv@quack3> <Zv8648YMT10TMXSL@dread.disaster.area>
 <20241004-abgemacht-amortisieren-9d54cca35cab@brauner> <Zv_cLNUpBxpLUe1Q@infradead.org>
 <20241004134906.3yrg5y3hritusmel@quack3>
In-Reply-To: <20241004134906.3yrg5y3hritusmel@quack3>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Oct 2024 14:15:15 -0400
Message-ID: <CAHC9VhQCQaybkmUy7u6xbAhR1HEOWWV_TA5LYPQY6WBct49umQ@mail.gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, torvalds@linux-foundation.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 9:49=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> On Fri 04-10-24 05:14:36, Christoph Hellwig wrote:
> > On Fri, Oct 04, 2024 at 09:21:19AM +0200, Christian Brauner wrote:
> > > > But screwing with LSM instructure looks ....  obnoxiously complex
> > > > from the outside...
> > >
> > > Imho, please just focus on the immediate feedback and ignore all the
> > > extra bells and whistles that we could or should do. I prefer all of
> > > that to be done after this series lands.
> >
> > For the LSM mess: absolutely.  For fsnotify it seems like Dave has
> > a good idea to integrate it, and it removes the somewhat awkward
> > need for the reffed flag.  So if that delayed notify idea works out
> > I'd prefer to see that in over the flag.
>
> As I wrote in one of the emails in this (now huge) thread, I'm fine with
> completely dropping that inode->i_refcount check from the
> fsnotify_unmount_inodes(). It made sense when it was called before
> evict_inodes() but after 1edc8eb2e931 ("fs: call fsnotify_sb_delete after
> evict_inodes") the usefulness of this check is rather doubtful. So we can
> drop the awkward flag regardless whether we unify evict_inodes() with
> fsnotify_unmount_inodes() or not. I have no strong preference whether the
> unification happens as part of this patch set or later on so it's up to
> Dave as far as I'm concerned.

I didn't get a chance to look at this thread until just now and I'm
noticing that the email used for Micka=C3=ABl is likely not the best, I'm
adding the email he uses in MAINTAINERS as well as that of G=C3=BCnther
Noack, a designated Landlock reviewer.

Micka=C3=ABl, G=C3=BCnther, the lore link for the full discussion is below:

https://lore.kernel.org/all/Zv5GfY1WS_aaczZM@infradead.org

--=20
paul-moore.com

