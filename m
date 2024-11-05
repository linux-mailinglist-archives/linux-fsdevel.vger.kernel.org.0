Return-Path: <linux-fsdevel+bounces-33698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1146E9BD738
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 21:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9049AB22DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 20:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC14215C51;
	Tue,  5 Nov 2024 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EltL0sJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D63D81;
	Tue,  5 Nov 2024 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839654; cv=none; b=ofPZ1pNHTWpadPQxFad/2Q+UOdOKkgrhJmc0grIUz+r3zV6ITZo9huFtA9IsTNKkjYxFkmYo6GJJdEJXF6K2I35lYzQxoAMZqc2m7M2xqB5q+3bZGrWz7n1w7sRjLdSeASN4YqwVmA60lwT+TzjeJDm0oVxP5S198JF+cn3HP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839654; c=relaxed/simple;
	bh=Tjk/p5NzAII+J106jl2wCCjJ7ll2lkZ0A4QTEjykmp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+HsuzP+bl3FRl0lza15r6JI0E4A1NCN+8vkFdCcOj39UEOXmuRlhMFcb6ACIFX9qahQowOHgM3fuFVV6I0oZ77NLK+oTemgYy40ljatyxQkQItT/aC45NJVSzVQ3yfy714Co4nnfC+1eNBx3WBcXoKtw7zp7E/gRRsQxIxnv2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EltL0sJP; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ebab72da05so3012029eaf.0;
        Tue, 05 Nov 2024 12:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730839652; x=1731444452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69eFS8nwLcoHMw0PMX3ZyLLxP11pLoPhnXob8PiMLEI=;
        b=EltL0sJPVRf4uCMNJvQa9oMC8TaxE1u3ODpMflVawviNSRj6rX27090wnvC8aReEpe
         RwLxap1BXtiD13TEWKdOIaCojd6HIVmv9PsJclDNJuGjJD7jbDlBhCxmg+ZHJvYrH75J
         ZHzauIYJa7fHyUbsZX34fRlJznBFC9XjPKq2B4mZqNFq83B2Hc1JYwwskep924WBWQn4
         GOBocU9mDAPhjvMo9M2WwkzdKqGXvHMdgWotKkcveJ1OK+Y2BFArwLGsN9ti8zsz2Ukv
         OQ+qP9Jfya9lWyJCOBSeXqWpfax3FJ9S/5qpD603Qqr+6c3/0kjwy2uNy3OBxeN/BtKl
         /NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730839652; x=1731444452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69eFS8nwLcoHMw0PMX3ZyLLxP11pLoPhnXob8PiMLEI=;
        b=vInRd8fXokrcwGOq+mH2CnYQuBm0LF++6rwHcQguGJ0mXQGNGeEAysKfPfRGqCl9qE
         MkKjGH6JOvOJ3AeZjrUHGX/cugGjFu4f6C/+svVaVROyQoL9F5vwUO02jJTCtTk6/JFD
         qzPEqmwzAUG2I9MIPo+fGttJiDlCxUKwx0LopG2pFk0O4cbh2Yf05VTwdUqzw1Fgu3cX
         D9taizTfxJtweOU+zNYrPRU2alHhZsw0tFnWMrw+qZDdDGzcdm9FVd/6jlt9JgO5BYrX
         qkW2lOmwmH2kTq26jCugKmcojd9j0Kywm/eOQIc5UkRlQj3w1PIjgw1LwUxz6IU37HyE
         EneA==
X-Forwarded-Encrypted: i=1; AJvYcCVBGODKJfq3I/CGlM8MoRUfEUj4L0pwd2qrEel0APmsBN8JWnWtQnvC6WV51gZDcHnqB3Sf7Fa/AEoe8Cdb@vger.kernel.org, AJvYcCW6dW+2Vi6RGEJLD83sVz2ef+XZpobzgauQ+NLO7f+qcLsbn6TkgKF8b13353xWkq9xuh7RLDmIvClwuXzU@vger.kernel.org, AJvYcCXxpWskrlrJ+d6BUkP2c4Kw5iAFXPVj4o+7XX7iVU4loyQ0DzlPZo74kwi2fcw622RQrTcXf1HBfNZtpojwcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxrcc6/qi+yCOIyzgQ6icjzliDS2REX8nBOHFHIIXISBbHKo2
	skjGoHXjKqK1pAqsHLT9MBiYMnCBpWx6gY6ZMXb1RqTVR4Cl0ZGWyHSCtXOcX+ekkmuca+W0GlK
	bHhKmDyTy/LhVDxmGvpehlmfj2Jk=
X-Google-Smtp-Source: AGHT+IGp+Cn5TjqRab2L6WM5a8qBxJ8JG0nS5RglxyHDdHxmKnP7LA3On8+x8M+QKwpmGLtdV/IjGB+3nI7NJHiAMIw=
X-Received: by 2002:a05:6358:7e0f:b0:1c3:7d12:708d with SMTP id
 e5c5f4694b2df-1c3f9e064e0mr1845493355d.11.1730839652223; Tue, 05 Nov 2024
 12:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105193514.828616-1-vinicius.gomes@intel.com>
In-Reply-To: <20241105193514.828616-1-vinicius.gomes@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Nov 2024 21:47:20 +0100
Message-ID: <CAOQ4uxiaRE_cQ9m9LZMEiDCeSQKkZDfsJbpt85ds6hgvjnwHUQ@mail.gmail.com>
Subject: Re: [PATCH overlayfs-next v3 0/4] overlayfs: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 8:35=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Hi,
>
> This series is rebased on top of Amir's overlayfs-next branch.
>
> Changes from v2:
>  - Removed the "convert to guard()/scoped_guard()" patches (Miklos Szered=
i);
>  - In the overlayfs code, convert all users of override_creds()/revert_cr=
eds() to the _light() versions by:
>       1. making ovl_override_creds() use override_creds_light();
>       2. introduce ovl_revert_creds() which calls revert_creds_light();
>       3. convert revert_creds() to ovl_revert_creds()
>    (Amir Goldstein);
>  - Fix an potential reference counting issue, as the lifetime
>    expectations of the mounter credentials are different (Christian
>    Brauner);
>

Hi Vicius,

The end result looks good to me, but we still need to do the series a
bit differently.

> The series is now much simpler:
>
> Patch 1: Introduce the _light() version of the override/revert cred opera=
tions;
> Patch 2: Convert backing-file.c to use those;
> Patch 3: Do the conversion to use the _light() version internally;

This patch mixes a small logic change and a large mechanical change
that is not a good mix.

I took the liberty to split out the large mechanical change to
ovl: use wrapper ovl_revert_creds()
and pushed it to branch
https://github.com/amir73il/linux/commits/ovl_creds

I then rebased overlayfs-next over this commit and resolved the
conflicts with the pure mechanical change.

Now you can rebase your patches over ovl_creds and they should
not be conflicting with overlayfs-next changes.

The reason I wanted to do this is that Christian could take your changes
as well as my ovl_creds branch through the vfs tree if he chooses to do so.

> Patch 4: Fix a potential refcounting issue

This patch cannot be separated from patch #3 because it would introduce the
refcount leak mid series.

But after I took out all the mechanical changes out of patch #3,
there should be no problem for you to squash patches #3 and #4 together.

One more nit: please use "ovl: ..." for commit titles instead of
"fs/overlayfs: ...".

Thanks,
Amir.

