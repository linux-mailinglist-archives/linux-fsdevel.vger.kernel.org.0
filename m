Return-Path: <linux-fsdevel+bounces-53091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D382AE9F4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995AD3B7DD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8DB2E7625;
	Thu, 26 Jun 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lak6cb1u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A12E7178;
	Thu, 26 Jun 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945508; cv=none; b=bBH2kn/+jWC5PUOz/QFM/dfetTP3nlPqy46wE7+7UCZKVszyvoIwFveQSpbB+yxZ75ZA4fAFJFUUYHJIOqCuEmBpSHYpmpGrNTgiLXAyi+xz9YjDPbXa9RsYLDdS0L71oy47st8M/Jvh8uLY1/n3PzByt42FXSsK6Ic5db4FUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945508; c=relaxed/simple;
	bh=oDopELAdK1t+cchcji6CZFY5fZ+cjx617KCXLTQaTGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yr6yeJzL4cHJZWBfi+GwMRbNV8fdHdLJ44AEZHKvejg6YByB5gAlvwQVEmJWy50MV3Te/tKPNrtMdzZyljOVeB7SjjkggwlQGDUydNWHo6k/rJJ/iO+2NVuQAANBJAuCOPqYKLOm0JxXKWlhfPCCd+059C49TwynSz5ma2G6ayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lak6cb1u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so176113166b.2;
        Thu, 26 Jun 2025 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750945505; x=1751550305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8ZAcIYACRttgel6yVJDRj+PcM/a8n+6dovyMe7xWnM=;
        b=lak6cb1uXSDCRcV7oIUW0Bhnrnlgx1YMvV/tMmeZlJCp3TojKN2B/8wdwqa1f3302d
         djpUnkGbkeonb+H/EtIlhwjPP4R0qxrvENfWiWblZd41noDawdaPuk40HAxEL1Q/Hzdg
         yRwd/GEDZ1R5ffRqJ+BtwrjuArkzx35lC8ymQIQ7A6vwi3c2scPbF8G4VHakmqMD2qK/
         8EywEdTUEkPVboYizN96kJ1zhfbUFd7r3fU0kCnlssGVHNk0oph8XMdFyjD9Flmc0OHy
         M0aFoE5/Ousj/P717HWyp0aLXNM1Rw5zf3KUs6jmbTd56oUIUlPnV4Aippz0F0oYs/NG
         6Gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750945505; x=1751550305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8ZAcIYACRttgel6yVJDRj+PcM/a8n+6dovyMe7xWnM=;
        b=oIOMIWVjF6Ah2XfLbaQLIkTgbVlLrhOGe2NFZaQnKMcmRP4jCsFqOc1MlDzToWn0Cs
         y4fh7zG6MoEN40GVAEiRNqBoZggQwWCWs5spX2+XDkYX2f8iJOrOJEjboHVUBZplfuvy
         mgj9Oe+bY+6gDxNfJwtwdGnjY+6aonNK4Okh9vtKsfAMSnXLOsS+UzUrtFWtgMMQdaWH
         2v0Tg9/foSDT9jAzbWWzxQpd3nKpajiGGaZmsMYP6zKPp4kOzNpdWGxP+U+QsnzDWcC2
         INorWp3k7Q85toG0XKMoZSARfICMClutqk+c/sABGLnnu6Nsev1kpjJgSI1mha4RWKXr
         GalQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0aSDR/Kn7KUNMyM3Cx4qhU9ZH5u1F2Oi4NwfAMhAONsKSnyBbFTnvAdPQihYMYaxe589nWvJGBQM8pe2b5A==@vger.kernel.org, AJvYcCWn9KtvBrLmX9dtA/UFdYcJBK1ZLHdHHVv0vH6xBIXEpfpqdXcaOrzu+L6vBc6yD4PB2cxpSS4Mf3ayaqzR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/mBkioVW4nSidpMIMQ4AjcmmYMhHEHVq41O64RlNXKXrbcaC
	JFBziUZifInnglFYNvGNbobrArOUuc1aMXTw++CyBFNj1XyJos0GWoyM+cAreHZnk41Xk7wPOzL
	YhU2lOdl3oWWLsDGpKqHI8p3PO8toXUU=
X-Gm-Gg: ASbGnct7b++AWGls2fP/R9SFFZXGhErFhysRTwwUdIuEMQXXdKZcm+Cv7V8bt/myABY
	uyLl2j8vgbFhLwDDpKj25AwQN9ykSeG2BnKKWNXcfNqDlvaP1USW9qhf8gloiA98gbhPjk/C/+r
	RkzX3ufJXXiZGvNbcqI/Kyvhiuj7PZplxjhlzexqrD0f5yzdUNZLFRVQ==
X-Google-Smtp-Source: AGHT+IFpLj3euUxXsPFu8NNT0TTALr0MMavyk3KDv/fFYz9NUcL2EP2KP2L81iTEGjxAyDBoSwN8fQSZP0TU4QBgdRw=
X-Received: by 2002:a17:907:1b1f:b0:ae0:bc5c:3d54 with SMTP id
 a640c23a62f3a-ae0be90e32emr742025866b.11.1750945504178; Thu, 26 Jun 2025
 06:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602171702.1941891-1-amir73il@gmail.com> <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
 <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com>
 <CAOQ4uxiNjZKonPKh7Zbz89TmSE67BVHmAtLMZGz=CazNAYRmGQ@mail.gmail.com> <v3sqyceuxalkzmu5yweciry54qjfwif3lloefpsapomz6afpv6@metypepdf3dt>
In-Reply-To: <v3sqyceuxalkzmu5yweciry54qjfwif3lloefpsapomz6afpv6@metypepdf3dt>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Jun 2025 15:44:52 +0200
X-Gm-Features: Ac12FXy84_m__niOlu7AhJklqzW_POPgD3NB46dCEy4W-D-2AEYfIi-GEkYDsck
Message-ID: <CAOQ4uxg8o-j_6TuUACJCJhn7-7fUeycbvrqaenDt2wAQfsZPKQ@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable filesystems
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 3:37=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Sun, Jun 22, 2025 at 09:20:24AM +0200, Amir Goldstein wrote:
> > On Mon, Jun 16, 2025 at 10:06=E2=80=AFAM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > >
> > > On Sun, Jun 15, 2025 at 9:20=E2=80=AFPM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> > > > > Case folding is often applied to subtrees and not on an entire
> > > > > filesystem.
> > > > >
> > > > > Disallowing layers from filesystems that support case folding is =
over
> > > > > limiting.
> > > > >
> > > > > Replace the rule that case-folding capable are not allowed as lay=
ers
> > > > > with a rule that case folded directories are not allowed in a mer=
ged
> > > > > directory stack.
> > > > >
> > > > > Should case folding be enabled on an underlying directory while
> > > > > overlayfs is mounted the outcome is generally undefined.
> > > > >
> > > > > Specifically in ovl_lookup(), we check the base underlying direct=
ory
> > > > > and fail with -ESTALE and write a warning to kmsg if an underlyin=
g
> > > > > directory case folding is enabled.
> > > > >
> > > > > Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > > Link: https://lore.kernel.org/linux-fsdevel/20250520051600.190331=
9-1-kent.overstreet@linux.dev/
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >
> > > > > Miklos,
> > > > >
> > > > > This is my solution to Kent's request to allow overlayfs mount on
> > > > > bcachefs subtrees that do not have casefolding enabled, while oth=
er
> > > > > subtrees do have casefolding enabled.
> > > > >
> > > > > I have written a test to cover the change of behavior [1].
> > > > > This test does not run on old kernel's where the mount always fai=
ls
> > > > > with casefold capable layers.
> > > > >
> > > > > Let me know what you think.
> > > > >
> > > > > Kent,
> > > > >
> > > > > I have tested this on ext4.
> > > > > Please test on bcachefs.
> > > >
> > > > Where are we at with getting this in? I've got users who keep askin=
g, so
> > > > hoping we can get it backported to 6.15
> > >
> > > I'm planning to queue this for 6.17, but hoping to get an ACK from Mi=
klos first.
> > >
> >
> > Hi Christian,
> >
> > I would like to let this change soak in next for 6.17.
> > I can push to overlayfs-next, but since you have some changes on vfs.fi=
le,
> > I wanted to consult with you first.
> >
> > The changes are independent so they could go through different trees,
> > but I don't like that so much, so I propose a few options.
> >
> > 1. make vfs.file a stable branch, so I can base overlayfs-next on it
> > 2. rename to vfs.backing_file and make stable
> > 3. take this single ovl patch via your tree, as I don't currently have
> >     any other ovl patches queued to 6.17
>
> I've got more users hitting the casefolding + overlayfs issue.
>
> If we made the new behaviour bcachefs only, would that make it work for
> you to get it into 6.16 + 6.15 backport?

Sorry, overlayfs is not going to special case bcachefs.

The patch is queued for 6.17 in Christian's tree
and is still waiting for an ACK from Miklos.

>
> Otherwise I'm going to have to get my own workaround out...

Not sure which workaround that is, but if it's in bcachefs then it's up to =
you.

Thanks,
Amir.

