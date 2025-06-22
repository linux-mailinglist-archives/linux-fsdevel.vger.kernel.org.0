Return-Path: <linux-fsdevel+bounces-52387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EEAAE2EC3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 09:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C54C18921D4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E1194C86;
	Sun, 22 Jun 2025 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTLtxPGQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC694A2D;
	Sun, 22 Jun 2025 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750577787; cv=none; b=nsFhvXHwEpur1b1oWat+KKE3teDLe5QLmPsB52bMdyS8e+1XFqnrWTiU4dfrf2uafSLLShJVGLkRFEOVW+JdLpDBv2qluscWey1l1cNuNQLwFWbOheLXXObi3IU8p1JfaEk2sO0BLNGWP4peVWa4/L4ZwLeYg6B1UpBzafhyZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750577787; c=relaxed/simple;
	bh=Jc0RQ+TNzS33+1/ZybIkP/jAMX7LMSendVxKp4X9wOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgPKxMfrZLktjCFFr6rNKKeSSPC+gD5kE1zJ5UZTUCJLsfzNdkYvuVq60SjYLAuBdaBAPHvf0Zu4zAaZFsnOWFpfHd3dV9QbSnP66VG23MMvRZzrTQPi17VMwVuaMyx9iO3yTSM6LCdhB041fPBDN93/xFLX1y9X/jrTm1eKXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTLtxPGQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adf34d5e698so867250866b.1;
        Sun, 22 Jun 2025 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750577784; x=1751182584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9QCUvhfaBmMB3zVzjaRZn5oSN2yMVGBEWtc6F1UMLY=;
        b=aTLtxPGQEoA54WmyKu3lqMBGMmvxYO5/K06rSIThZwICpJ/sbUq+Tlk5qtuMMLlMgF
         FQiYWS9ctnJhDmlEW7Tz8cTcvgP9KmEG/nZXJC7oCK+cUTvBc0mUyLtUZNHDBbl0b4zF
         eWgU5Bxs0efbpDhA1f2UtLFmKDmewPhk3gWD7/VgQ+LhCSPUfpDpRgkVQoSI5+pVPbKc
         0n3jay6FmhZPmq9YWHrJwtFE+kw7RNUW79GPav74b62W0GKPD6jpWvExdblVotaIGFgN
         IKlrZwqSHtjZfXMVo+ztle+h1nq5j0FZpcxT4mTF8e7wYvnHgtF6oAQA7JMDBQ7fon17
         W2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750577784; x=1751182584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9QCUvhfaBmMB3zVzjaRZn5oSN2yMVGBEWtc6F1UMLY=;
        b=gcz8JE/PtAIQY0JStqI6s9Hb+Eim5/Z5r7JvLnpvANFI7V5mo/MfB/EkdV9tqfPBT9
         IV0OE/rRon1B3gtsDVtjax52T8/73/txvPmN10fToMafbcGOKQPKp0k7QwLeEp+J3Bdu
         3AlYJW6NCYX0frDAARQYvlX271n0fBcsQqZHbRPbPuj/p6vndzY9dBAlbwoS30vFDD5B
         z1N8moFXDliVXu0z9NTCEbG3rWU0r8xY23DuvBeDY4KUF3l9T7YZ+OMbARBG9NFkoMes
         feg5WwOPgiPBInjg3v//EOLrqfs/BN4vK5L+MFCm0t4BXSfA9NlMXKtAj/6QhgprMR3F
         iRrw==
X-Forwarded-Encrypted: i=1; AJvYcCUxSfHtYISNfMipRP1vmrqrWRzocx/T1TzpsakD+QOULieuwZzlQKkTG2dvkfRqBzXyqx1j9jUiKXqNlVAd@vger.kernel.org, AJvYcCW6VY+OGgx04n33ALnQ8YaM9zYwZdpKbmuiRuwLyWvyYxkafNV4jTjy6tjBOigAhy50P4GgVSTzEAikvrhm4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPpMIwBJCOQpe0ZjlBagiURECEYhbSxNHS9vpe0aPzqJ0cbXi
	6Qfc+2IJRq/67XZoYSb7JQ9/Y9pTuh48owNWiE8M+RoeyJWPEuaMqyJsljFGkV3dvZnqpYoa72e
	vzHmqx0BfzU8V9coK2Le4uhqgevsRJH0=
X-Gm-Gg: ASbGncuHW7UrsI2dq4221K16FY+BoZj25Xvp6/TgXXWxSSMjFaPD2lc5svCJ4e9WwZC
	CC9HpvDdYtEi9JyyWT+ell/zhU9QGBczsfDtz7poZv2AgWWciH/GLwm6eAjvtME8UHLQjZvCpMI
	/p88brgEiwr1YI1tk4TgRhaesE/6/iq3aQ7NhGVeWvAdA=
X-Google-Smtp-Source: AGHT+IF3+K9O2UbKAMyg9CVWe42FHK9z5OmdaRM3qHfunj18yiPaEFJ8LuqGiIloVKZTw+DVbPUaLmI7YEhhuKEzpiE=
X-Received: by 2002:a17:906:9f8a:b0:ad2:27b1:7214 with SMTP id
 a640c23a62f3a-ae05afc1bc6mr811895266b.17.1750577784052; Sun, 22 Jun 2025
 00:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602171702.1941891-1-amir73il@gmail.com> <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
 <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com> <CAOQ4uxiNjZKonPKh7Zbz89TmSE67BVHmAtLMZGz=CazNAYRmGQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiNjZKonPKh7Zbz89TmSE67BVHmAtLMZGz=CazNAYRmGQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 22 Jun 2025 09:36:12 +0200
X-Gm-Features: Ac12FXz-EK2Y5FPdA78U9BGjZAm3Fa1rWexLSAasnRK91lveI1L41JF4HkbVPgQ
Message-ID: <CAOQ4uxhHceEVRMpuWtVc94H59sYY7qUiq2NyeztykaejbZzsvw@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 9:20=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Jun 16, 2025 at 10:06=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> > On Sun, Jun 15, 2025 at 9:20=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> > > > Case folding is often applied to subtrees and not on an entire
> > > > filesystem.
> > > >
> > > > Disallowing layers from filesystems that support case folding is ov=
er
> > > > limiting.
> > > >
> > > > Replace the rule that case-folding capable are not allowed as layer=
s
> > > > with a rule that case folded directories are not allowed in a merge=
d
> > > > directory stack.
> > > >
> > > > Should case folding be enabled on an underlying directory while
> > > > overlayfs is mounted the outcome is generally undefined.
> > > >
> > > > Specifically in ovl_lookup(), we check the base underlying director=
y
> > > > and fail with -ESTALE and write a warning to kmsg if an underlying
> > > > directory case folding is enabled.
> > > >
> > > > Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-=
1-kent.overstreet@linux.dev/
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Miklos,
> > > >
> > > > This is my solution to Kent's request to allow overlayfs mount on
> > > > bcachefs subtrees that do not have casefolding enabled, while other
> > > > subtrees do have casefolding enabled.
> > > >
> > > > I have written a test to cover the change of behavior [1].
> > > > This test does not run on old kernel's where the mount always fails
> > > > with casefold capable layers.
> > > >
> > > > Let me know what you think.
> > > >
> > > > Kent,
> > > >
> > > > I have tested this on ext4.
> > > > Please test on bcachefs.
> > >
> > > Where are we at with getting this in? I've got users who keep asking,=
 so
> > > hoping we can get it backported to 6.15
> >
> > I'm planning to queue this for 6.17, but hoping to get an ACK from Mikl=
os first.
> >
>
> Hi Christian,
>
> I would like to let this change soak in next for 6.17.
> I can push to overlayfs-next, but since you have some changes on vfs.file=
,
> I wanted to consult with you first.
>
> The changes are independent so they could go through different trees,
> but I don't like that so much, so I propose a few options.
>
> 1. make vfs.file a stable branch, so I can base overlayfs-next on it

Sorry, I meant make vfs-6.17.file stable branch

> 2. rename to vfs.backing_file and make stable
> 3. take this single ovl patch via your tree, as I don't currently have
>     any other ovl patches queued to 6.17
>
> Let me know which is your preferred option.
>
> Thanks,
> Amir.

