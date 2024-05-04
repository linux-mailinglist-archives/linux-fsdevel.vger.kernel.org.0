Return-Path: <linux-fsdevel+bounces-18716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216278BBA53
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F36428260C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39A517577;
	Sat,  4 May 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfL2WBXk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47C5234;
	Sat,  4 May 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714815838; cv=none; b=H8K77OSpVzAOYF02UIPDuY2DstFwBmZzOIBhLgm1MRPJijVjm9juwFgLS/aeeJLzZWdlJFnE0bzhd2fqbC9975AkmdJoGSoPAEhN+S4U7zOVj4lILIoqZwq/W4nM/eU/JmlD1f7m4vPezMa6nJnYXGsj+5r+MyHMrRNcG5hLv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714815838; c=relaxed/simple;
	bh=1w/AH4GdTaY6CWyKTTAvN+nMscC+JR6sHUysLqvmOjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRFwlZa7eSnkaFvi3/NbEka66So9Q8Ynw9CYXxT4cJwi94hk6UHUXWitOn6fDLX8gs37LzaLViK7M5IpfeeApEd1dujrz8mx6kc+E4LNBz23t36OaJkObvu3afvTelkNCg6w29zEvHy5U1X2MzhNz1uQ6X7holKaf3zEWNu7BtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfL2WBXk; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6a0ce3e823fso3522046d6.1;
        Sat, 04 May 2024 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714815835; x=1715420635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIow/lRUtXKVyk5QatEWyX22X750ehCcRrV8cIvs8RE=;
        b=jfL2WBXkvyb1YNrP33Up2n0F1pHjHYkkVN830vjY3tRmdszoBIziBaS8E6Q3QTtCjt
         jCz85Hthx5CvwJ36jedHBk9Vagqn1y8M21VhMFYrB5NT8+jIAV/lLdSFyhaZNwNpnHrT
         w7VZOnYNczalTx5HbEgt7EiC2Svtg4ct0gsZ4jBcevbrnI57mPiGndhcQB5qpTwTHbzh
         bu4O4aBioDqP4we1NXi9Ues2pmRJqggQldRcTzE02WvhlJ/1gRTdKO79TJ0PWtb3ZzZS
         ZjlgSkZElmImSFchWmVhXnj2vrXADJ6H4nAe+40fcG+7QJHV81PdJnRN/ytxfastYNXV
         5OVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714815835; x=1715420635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIow/lRUtXKVyk5QatEWyX22X750ehCcRrV8cIvs8RE=;
        b=iz+VQN9snKlRR+SzhEAr68wcCih1XHD/GmpEH9DGGVcPHq7w3OACmI3J+8vck6hMWf
         2CX2P377goddlInhl+L8weKOZ2jBhdc1oS0RVN3A8J30TIjgN8+BLrXV4gAczwGSwuwG
         +BggbkVmO8cCnhPgI6xqDycTanWZqPg+Bk58am2riru81gPABbGYp/m8xoT1G0oM4pfS
         sIpAH3chjkliSaNQy0lNTQbasRLv895pB+MEF6P0MeFxBkEzOy0/6DBOzhAC5p8ErQPX
         CFMmC86Avp9nxjL6TwcoBD0qUro3vOMnVobSoJB14Z3UhHowY7L6pnC70Ru06Az4CUm1
         CZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCUcYFaYkj7MIXkSDaq890KyEXlAZQAEK2XGzw+QS2HJpfJDrfShftisIQUbNr6TaplgQQby0h+oqv6YJ9flUJesyH8oqJ8XkBLkoBbB1LwcA2HlRzipxeBEZGxoeahULqFyZrEZP3UPnFzjww==
X-Gm-Message-State: AOJu0YzbiR52P8lf8/aQgH19CkHmzZJ9JAs8N3AjxSWgcnTgf6Rby0hj
	2ophtVr4dZMP89IsrhI2zoCnSYCxxyvex/X2t6oMY3UgBwbCFVh2qgwpPAxl1VfekTkCsuCfvh+
	4X8XZcd9sgoeMTIf5klPQjEmQIBHY76uh
X-Google-Smtp-Source: AGHT+IGjFhuEQnnEgd8Pisxch+w9y9BRIoy2mM9JFr++tMX4ms/R5nAAulHPW8W3fLvhHlCSNLKUc67SPAGJPeZcC9k=
X-Received: by 2002:a05:6214:1c4f:b0:6a0:a00e:7583 with SMTP id
 if15-20020a0562141c4f00b006a0a00e7583mr4512882qvb.18.1714815835593; Sat, 04
 May 2024 02:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF+WW=oKQak6ktiOH75pHSDe7YEkYD-1ditgcsWB=z+aRKJogQ@mail.gmail.com>
In-Reply-To: <CAF+WW=oKQak6ktiOH75pHSDe7YEkYD-1ditgcsWB=z+aRKJogQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 4 May 2024 12:43:44 +0300
Message-ID: <CAOQ4uxjh5iQ0_knRebNRS271vR2-2f_9bNZyBG5vUy3rw6xh-g@mail.gmail.com>
Subject: Re: bug in may_dedupe_file allows to deduplicate files we aren't
 allowed to write to
To: Hugo Valtier <hugo@valtier.fr>
Cc: mfasheh@suse.de, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 7:49=E2=80=AFAM Hugo Valtier <hugo@valtier.fr> wrote=
:
>
> For context I am making a file based deduplication tool.
>
> I found that in this commit
> 5de4480ae7f8 ("vfs: allow dedupe of user owned read-only files")
> it states:
> > - the process could get write access
>
> However the behavior added in allow_file_dedupe now may_dedupe_file is op=
posite:
> > +       if (!inode_permission(file_inode(file), MAY_WRITE))
> > +               return true
>
> I've tested that I can create an other readonly file as root and have
> my unprivileged user deduplicate it however if I then make the file
> other writeable I cannot anymore*.
> It doesn't make sense to me why giving write permissions on a file
> should remove the permission to deduplicate*.

True. Here is the discussion about adding "could have been opened w"
to allow dedupe:
https://lore.kernel.org/linux-fsdevel/20180517230150.GA28045@wotan.suse.de/

>
> I'm not sure on how to fix this, flipping the condition would work but
> that is a breaking change and idk if this is ok here.
> Adding a check to also users who have write access to the file would
> remove all the logic here since you would always be allowed to dedup
> FDs you managed to get your hands on.
>
> Any input on this welcome, thx

My guess is that not many users try to dedupe other users' files,
so this feature was never used and nobody complained.
What use case do you think flipping the condition could break?
breaking uapi is not about theoretical use cases and in any
case this needs to be marked with Fixes: and can be backported
as far as anyone who cares wants to backport.

You should add an xfstest for this and include a
_fixed_by_kernel_commit and that will signal all the distros that
care to backport the fix.

Thanks,
Amir.

