Return-Path: <linux-fsdevel+bounces-52107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12827ADF708
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4F04A318D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7812E218851;
	Wed, 18 Jun 2025 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="Qg827TMm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4D20296E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275871; cv=none; b=LvsgoPcaSRStXXTE81VyjE7dgzzd9s/aKolXHAoa1C9OBPNkjy9AX4DureMXzTWbndZZr5XNWYhSJJI+kVYwZtLCmWP0M968rk51WbEOwMZROv11fPLNYCtx0H/cDQ7Q484O79GHTWdsjpOAONFyX0/awJVG5zU5UoJyMbD+lQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275871; c=relaxed/simple;
	bh=bGNZfbexhAtTwZv0qpR92Dgqlg0xg64nuKUNuoZLKog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hze7hJTolIukjKwdVUH/ySN12MpNrz+mE/XX3vhJMVg9vdenZzvdoS4QDMxoTzDh+4YvbDfCQeoSuE6iSUZkzjCzRQVzVTHEPD595dZCLJ9A4KUbJQEmlNBj21UK31HU9LwnsGnp6ox3Db+UHWmvlSQRcjUyZv6y7xphf+sT3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=Qg827TMm; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so8279635e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750275868; x=1750880668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt1lfYU/wvXZhk9ZCak9C4xzbI1x25URyWqQXMC615M=;
        b=Qg827TMms5xhZ+I7BOp3Te170AQJRUmK+TEAiWbUlyssAdthNxccfz5y2Tjhjk+0kE
         J/7xPWZN45GjCR51ClfHLf9YCssAukC/Ss/3Qf17MKm9ZM7jd2NXhCVSZZF67Y4NxZxF
         XYRZWIHXHB1cWPMpyyYUMXfBZEeptBjKPQvCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275868; x=1750880668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt1lfYU/wvXZhk9ZCak9C4xzbI1x25URyWqQXMC615M=;
        b=YAXdAzbo+OYYOSugW0fows/r4w/EFegatywRpDi6b1gi/TKxrp9DETojJbQ9aoY0fT
         pfVrksuyBbqZaDKPVn3DPm7ONf8mhauEMAlpCQZWTF5kVTBGdnZCRErw71dM2wXnZwU7
         EEiHtOdW8tHXhoAuiImq8xJvhb6/X0Cb3ffq8VCOMDIbk4d/5+upQohKjbS+JVNcwVkK
         gh6BEvmS5cuoFe+cBSDfFjpwyDYmvS3HOFkFl8PiK/q9fIj0/5FA0b9beVU+hxgx2F2p
         dYZlf+MaBLoznO2RKaDfijtkZYa0mB3PJ9feVj6R50dmkVT6q/0IjMXt3Q1vRqKfyiAc
         +qOw==
X-Gm-Message-State: AOJu0YxGsLqnLGfr89yVeoY56wUmBO3VUuod0ZABnhPR5lsZMkQISrgl
	sv3eOA8OfoqcZwhys0u/L7z1S9SmA4sTO8QvqhzkE/U9hMoF3ebN7oLmjapP2NOAynqukIvvneW
	Au4cgUrbiEKYbDjBEI6RqdR7VQuLFIOfrK5AWlymzhgM/CNziB34b6wv+pg==
X-Gm-Gg: ASbGncvmK2OkSM+dmFHuemgmUqJBqhTKj/SVeMlEKNhXs8gbkXY4fulT26G5o/czK00
	am9czIX8iTBiIK2z8T2EQwPlSHgcB+9vZlZ6Tk9kbYumW8buUgebQgtjtIJqDtO5gXARLqxuMIq
	uIkYpYxvZAK2JuIFNSSugw/kI5AgkifDhArHEVhA1Lc3ic
X-Google-Smtp-Source: AGHT+IGFj0NYiz1d28ysVfiYWnjXV3n/ruVYcjBPujEXbs2shr8ujqK6hdHDJrApgWJiME7hRGnwISFdrNGVhuLfhxE=
X-Received: by 2002:a05:6512:224b:b0:553:a30b:ee04 with SMTP id
 2adb3069b0e04-553b6e82378mr4926795e87.14.1750275867834; Wed, 18 Jun 2025
 12:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org> <20250617-work-pidfs-xattr-v1-1-d9466a20da2e@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-1-d9466a20da2e@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Jun 2025 21:44:16 +0200
X-Gm-Features: Ac12FXxrw1v-0wPL9Xkxv5vMHZWMAY34B64dV8U3f2_YbojsERtLnCVch3rq2M4
Message-ID: <CAJqdLrqbyJuC=Uda34-O=6XBOgTDztDBeoJ=jiWftRWVsp5kVA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/7] libfs: prepare to allow for non-immutable pidfd inodes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 17. Juni 2025 um 17:45 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Allow for S_IMMUTABLE to be stripped so that we can support xattrs on
> pidfds.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/libfs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index f496373869fb..9098dc6b26f9 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -2162,7 +2162,6 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
>
>         /* Notice when this is changed. */
>         WARN_ON_ONCE(!S_ISREG(inode->i_mode));
> -       WARN_ON_ONCE(!IS_IMMUTABLE(inode));
>
>         dentry = d_alloc_anon(sb);
>         if (!dentry) {
>
> --
> 2.47.2
>

