Return-Path: <linux-fsdevel+bounces-45577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237ADA7992E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309E03B2157
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 00:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BAA3D6D;
	Thu,  3 Apr 2025 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VZhxgYnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD71163
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638792; cv=none; b=jmyy86OwGkY+8HWHFDzkEEdh1NnLgxd9gTDnNXoqNOl++6cEsuWz9SR6NfPRTnyaTYkpfTqeOuhGlvoHM8mSqMyQaIrOY3q6/OCk4+i2+zAgBml3tgzD1NpkwPYpijS7YbkhDOYhMtI+OQx6eCQl62d0rio3fdSFWYM6IEbcokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638792; c=relaxed/simple;
	bh=nhly9Oo98XoTVMa6E6OYtYSm01eN5GH5P0vWzI1XMTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSb+BcEhI6JLS1xTQogucx854KBo/va/qCKcZGO5s+D0CeGIfQWv8jSXh5stkB3CLvZwAvGpsRi70kJFsAzVQy9lr6hor4xA6B5Iv3tniXpkKmvz5JYMtpV62Wx98zou1EmtRkXa5xvQeTiWXucZtIIFNxMCdqOYorEs8jnrmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VZhxgYnK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac29fd22163so51356766b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 17:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743638788; x=1744243588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WDME24yiYohb1xBflLrOYtprUkMulUfhOxUWN86ggD8=;
        b=VZhxgYnKigDkHmPaz3LTGq3drg4E1UMeUc//U5llagqf+Ps0/xGfFYnrj8OcZYfwjp
         3AOM7Bz5AGFpHGp+sgTuP5MXkUCKpuXYjqkVRljtUkFXME6jPmW1FQY1KImQj1LJBoHt
         k1Hp+gXkxa889onjKMRk5iM9TbhUfZMQP7XK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743638788; x=1744243588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDME24yiYohb1xBflLrOYtprUkMulUfhOxUWN86ggD8=;
        b=mYu1uKtl4zbPTSLT9ShslTpEdW3qP7FotCHSBu29JBdH5KgT5r4yQgNrNCN6ne2wB9
         siEySPb1sVO6zA2kCxEDI8TINcvUuq/Vbdnfsg2FV8/YW6FhwD2Il/5JgRBfoJa23cp5
         KbeMM83u8wHTWueLPIpfkczqAEdDoVYjIzPAPCsgQYTxlx/DYCsnK9xjUfF11J7ofe2t
         kB3I0mnXZ5C6VyZTYHPXht92a9N5wf9R1q81jt38ywzKrR4SMJPUM/QV6xyWxctCTCeL
         Ot1Pmxr/VP93Ecub5wfn3x7L224rrRIgzxyfOFRdpIKv9vOWSz3/XzbpppwStkgJmG+x
         aeEA==
X-Gm-Message-State: AOJu0YwS4hfluG3FaUSaF7dASZxDSxtCTKeFtjYQ2heavxMh+AZvUGLF
	MKchyibXqCaf6uqyZ9mz9uWOQuFa/C+oUtxs82HF9CUgnRajm85vRpK6uhkm9/EWdUfcAu9YKcm
	oLeo=
X-Gm-Gg: ASbGncsYcSZEmp+1iw45KQHTxOpmTZsGdy4ay7u+C/hM+q62Fb2sSEF7ho3QlHoPJd0
	v9FoBKCeSuSX10iKQ1ziF1W66tnBpyAbw/NdW1Tk+Vydc8cKKHpobkNfP3GE+0EakOHlVLS7jrO
	rFOpztFQ7EbWOX1eEGb5hSAYHKzYQjU+ctzlk7fERJs0kZI2osV4ix0EV/+CJ0jUuw7U9lSeFSP
	evIy/BYF8yKkiThkujwtCuYVQ49VHC/GzpgKsM08jPVsmV3waM/7Q6pnY/3fKDu1FxYtih1VHlh
	zmEsj0rom5IWr7/eX4KbWDI80qPP5Bzi0LKiDD+RuuS5bFqHeq2l8WtmzjGuSYiZYelvZ5Xs4Ad
	e3YXjmv1m/0m1YAeEzx8=
X-Google-Smtp-Source: AGHT+IGA4vtBTw7HhExlEa2AbTiIEwECo/UWm21wLwIXaANNIUWfgajBvbTdCTHMx4tYAdMUHJCjrw==
X-Received: by 2002:a17:906:f85b:b0:ac7:3912:5ea5 with SMTP id a640c23a62f3a-ac739125f39mr1462126166b.58.1743638788336;
        Wed, 02 Apr 2025 17:06:28 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01862e7sm4790866b.139.2025.04.02.17.06.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 17:06:27 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac29af3382dso46610866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 17:06:27 -0700 (PDT)
X-Received: by 2002:a17:907:3da9:b0:ac2:912d:5a80 with SMTP id
 a640c23a62f3a-ac7389ea3e0mr1522405866b.5.1743638787221; Wed, 02 Apr 2025
 17:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsQDTYsEWHMK9skpNzUO=GA_DR7zGHftyO2sZH5wjaZLA@mail.gmail.com>
In-Reply-To: <CAJfpegsQDTYsEWHMK9skpNzUO=GA_DR7zGHftyO2sZH5wjaZLA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 17:06:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihf7K7JhOsm2R6SSRbHuxzpMG+q87nVyD-jZnd+7-0gg@mail.gmail.com>
X-Gm-Features: AQ5f1JqHxQ4y8QfdVOkyBy-Gm3oH8OTY9Em8Hq2QRv5vKqVBHYB0rPkvn3Y6piA
Message-ID: <CAHk-=wihf7K7JhOsm2R6SSRbHuxzpMG+q87nVyD-jZnd+7-0gg@mail.gmail.com>
Subject: Re: [GIT PULL] fuse update for 6.15
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 04:02, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Commit 1dfe2a220e9c ("fuse: fix uring race condition for null
> dereference of fc") in this queue has already been merged into
> v6.14-final through Christian's tree (commit d9ecc77193ca).   For some
> reason this causes a merge conflict, the resolution of which is to
> just take the version from this pull (i.e. remove the atomic_set()).

Yup, those "made in both branches" kinds of conflicts are trivial to resolve.

In case you wonder about the "for some reason" part: I say that they
are "trivial to resolve", but they are trivial to resolve only when
it's clear that you should take the *other* changes that the other
branch does.

So put another way: both branches did X (that "fix race condition"
thing) but as different commits, so they had separate history.

But then only one branch did Y (the "remove unneeded atomic set in
uring creation") that is right next to X.

Now, when I look at it and understand the semantics of the patch, I go
"oh, ok, both sides did X, but you also did Y, so I'll take that X+Y
thing". Simple.

But it's simple only because I understand the semantics of the
patches, and I see that I should take the union of the work.

git won't do that, because while there are "patch queue" systems that
do in fact use that exact logic of "both did patch X, the other side
also did patch Y", git is not a patch queue system - and I think patch
queue systems are actually wrong for anything more complicated.

So git will look at the original shared state, and the state of both
sides at the *end*, and make the merge decisions on that basis
(resolving things with a three-way merge if both sides did changes -
that's the simplified case for the simple history situation, at
least).

And in that model, you don't have "both did X, and then one side did
Y". You have "one side did A, the other side did B, and they weren't
the same".

I also will claim that it's the safer thing to do, because who knows
*why* one side did Y and the other side didn't? Without understanding
the semantics of Y, it's very much not clear.

For example, maybe the other side didn't do Y because Y was a quick
hack bug-fix to get things working, and instead simply fixed it at
some deeper level elsewhere that made the quick hack pointless and
possibly even wrong.

So just automatically doing some patch algebra can cause problems.

Of course, the git model of merging can *also* cause problems.

For an example of something that the git merge model will get wrong is
if both sides do 'X', but one side notices that 'X' was horribly buggy
and reverts it, and the other side doesn't.

Now when you merge the two, git will see "one side made no changes at
all, the other side did X" and at that point will merge 'X' and
basically undo the revert.

That *may* be the right thing to do. Again, maybe the other side
didn't revert because the other side fixed the bug properly. But the
*safe* thing would probably have been to treat it as that X+Y vs X
thing, and ask for manual intervention by marking it as a conflict.

But git won't do that, because git will see X+Y as being no change at
all, and then the logic is "one side did nothing, the other side did
new development, when you merge the two you obviously take the new
development".

And that's ignoring the whole issue with three-way merging that git
then does for when there are changes on both sides: it's a traditional
and generally very good strategy, but it can certainly also end up
doing mis-merges when there are semantic conflicts that don't show up
as overlapping changes.

End result: there are no automated merge models that always get the
right answer. The git merge model does work well, but there is no
perfect.

One good thing about the git model is that it tends to be fairly
simple to explain *why* it does something. It's not rocket science.
Merge conflicts really are fairly simple: both sides changed the same
area in different ways.

Of course, things get complicated when code movement or complex
history is involved. Or when the two changes simply clash on a
fundamental level and weren't at all about that kind of "A+B" vs "just
A" situation.

         Linus

