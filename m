Return-Path: <linux-fsdevel+bounces-55584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51B6B0C12C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 12:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA76E4E3B1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E528DF3E;
	Mon, 21 Jul 2025 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHY3M5Ku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A9328DEF9;
	Mon, 21 Jul 2025 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093229; cv=none; b=WJ6h3VC2MUgJOUWehAC/iYFxkVW0nK5RDN6PfMV2LCsDhQMa/qNfI+kzB5aH+KAMK0FLv54/ALDstQf42eQG9SqyYsBevP/ZkgR0jiB7UsEwuQPO4bcMoiEU4AVtD8dpsOvtqSOW96bscfGZg6Wa7FslbqWnOFKEc6U94fGJZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093229; c=relaxed/simple;
	bh=3YgMPI03O6Q9TFHH0OJ35uPeIyJWvyS3MOD+GMcK5P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzsWUfX/tOCisSmzUyPItEzvROIbvt3ctJOg8IMe53DesSUp7VTkjdB0kUXE7YbFHKGJ3bDtXF/ekewKsXk3F95IGFTGo7+GHdIyZMjlG8+Mdr4lSTm6r9OA8Ey9DWxMHvitx0/OhISOtyVGUwNQZFV1LISWlNruESzt1BcznYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHY3M5Ku; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae3a604b43bso697217266b.0;
        Mon, 21 Jul 2025 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753093226; x=1753698026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEkvSgl/X/bWkRHK67wzwvPOEwMXPHWGX/kAxaYeLOk=;
        b=QHY3M5Ku2y3pdL4F7AodygniLpje3Hiw77xLdF2dFFFfPT1MdztNPSzO8Mz9JLOvOp
         uIucgi7xPfAFq54aONXgk01HWRuPM7GrjV/hvdTP+3K22jjyY3p7eFdoy8U43eNvWA4w
         RzGaQe1XrFwgmInKJeQgwswkelr6yayDGJfbwS05hIiWftaCZxrVZ4dniGbUQoeG8YBj
         rstR70bsEdHErcARkzVcuCywcq/Evl6tKCISY9ZRRvT4EO9NvN8BC555ckEHeRJ0BEY4
         U/0YciaefXBrnCFuLyRdygQvOPAAg+Vnh6TaXz+ZTPAHkEeBzJemxRFN2mKFATTPRYFe
         pK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753093226; x=1753698026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEkvSgl/X/bWkRHK67wzwvPOEwMXPHWGX/kAxaYeLOk=;
        b=nweXSeYPQPa23zp+NaFHaitAk4kpdXAJKjaIw+3ziFguytR3XtdXirXKZPcfKcSC+E
         +P88f4jZTGn8mMZ1GLcD5z9aRKAKAq+/xl/7aNXpVRBV0JrjS+4tJJWEfmyjHrdjKHmV
         EywTjsvyB0+wB0090j63UU1pzeWqGleGlZ0HyQmrV2IJlXYgWhd2gMSEtaCZTvf16PVI
         ww8Yeb86qIfi2QjuzERIO7rSqJE9cJqGavWw2ff1ESVSrK5NWcCIaLTXDQP6pcZ4VL7O
         6dytQ5okKUT/5Iy5r0XZ1IsMPPrO+6rDtcO3Uc5MSPwc2DPoVlGPMKLmXOAKFI8ey/CM
         ecmw==
X-Forwarded-Encrypted: i=1; AJvYcCVkvNoAAC252kR4WPX6Ne3P+1hGpWLQc9nEZWpNVSH6ibq/QkXSO1nO8rOzMp9Y+1vAsyCphj4Q+u3koxuF@vger.kernel.org, AJvYcCXQdKo2oZ7ButWBGh3Kh+HKm7F910WC4y3APskq3It+DYsw7vE5/auLb0kkvkUl9V7N6gzqGVXlakibhVsK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhvsmqu8ZJ639lGXgQEFpW9Uc/tPHdpNWIwbDmbqjAMZycUbJV
	jhS86Lh1ywLKhXaK6ZzXXCGG5yvsiqthjkrA5D1mfGkIQJaFu658j7upyHUiJQUqq8xwBdqoJuE
	45vRmXrEhH3AZ2eNC7auaCQNi8s8N3Aw=
X-Gm-Gg: ASbGnctYhEEUo/SqgpcYX46TOdxwRrvmhdl/yCWaxlvhSruQblpxhRZ1D2FaupeW/Tj
	4vT6+kZnr817f88N0O2sUXsvBGrEsbvJdrVFXMUoRppwnC81SAyq8abnNyPUryZXtoyL8X//8DQ
	5oGaeekzFbrIxr5kN/l6Hon+w6wAR+Vu2oiZBXF1FXv70SOF32Qq5KIEChcnGH+xpQ4OPVtu8gB
	Kiar24=
X-Google-Smtp-Source: AGHT+IECwG9KpInpUUTUfL1ZufRwhXd7XnVOImrGIaqCKUWnoqFI8PBJPZ5FRE8r5TJ5oxnN80iuA4xF8KGlJ5g8A+k=
X-Received: by 2002:a17:907:d508:b0:add:ed3a:e792 with SMTP id
 a640c23a62f3a-ae9ce11c674mr1857320166b.47.1753093225389; Mon, 21 Jul 2025
 03:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721084412.370258-1-neil@brown.name> <20250721084412.370258-5-neil@brown.name>
In-Reply-To: <20250721084412.370258-5-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 21 Jul 2025 12:20:14 +0200
X-Gm-Features: Ac12FXyX3UswuCZXfkC-RxeL1SPw0biPJRSYlaLZQm4ll8hui8Mb-5dCGEAPxMo
Message-ID: <CAOQ4uxhiDNWjZXGhE31ZBPC_gUStETh4gyE8WxCRgiefiTCjCg@mail.gmail.com>
Subject: Re: [PATCH 4/7] VFS: introduce dentry_lookup() and friends
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 10:55=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> dentry_lookup() combines locking the directory and performing a lookup
> prior to a change to the directory.
> Abstracting this prepares for changing the locking requirements.
>
> dentry_lookup_noperm() does the same without needing a mnt_idmap and
> without checking permissions.  This is useful for internal filesystem
> management (e.g.  creating virtual files in response to events) and in
> other cases similar to lookup_noperm().
>
> dentry_lookup_hashed() also does no permissions checking and assumes
> that the hash of the name has already been stored in the qstr.

That's a very confusing choice of name because _hashed() (to me) sounds
like the opposite of d_unhashed() which is not at all the case.

> This is useful following filename_parentat().
>
> These are intended to be paired with done_dentry_lookup() which provides
> the inverse of putting the dentry and unlocking.
>
> Like lookup_one_qstr_excl(), dentry_lookup() returns -ENOENT if
> LOOKUP_CREATE was NOT given and the name cannot be found,, and returns
> -EEXIST if LOOKUP_EXCL WAS given and the name CAN be found.
>
> These functions replace all uses of lookup_one_qstr_excl() in namei.c
> except for those used for rename.
>
> Some of the variants should possibly be inlines in a header.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c            | 158 ++++++++++++++++++++++++++++++------------
>  include/linux/namei.h |   8 ++-
>  2 files changed, 119 insertions(+), 47 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 950a0d0d54da..f292df61565a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1714,17 +1714,98 @@ struct dentry *lookup_one_qstr_excl(const struct =
qstr *name,
>  }
>  EXPORT_SYMBOL(lookup_one_qstr_excl);
>
> +/**
> + * dentry_lookup_hashed - lookup and lock a name prior to dir ops
> + * @last: the name in the given directory
> + * @base: the directory in which the name is to be found
> + * @lookup_flags: %LOOKUP_xxx flags
> + *
> + * The name is looked up and necessary locks are taken so that
> + * the name can be created or removed.
> + * The "necessary locks" are currently the inode node lock on @base.
> + * The name @last is expected to already have the hash calculated.
> + * No permission checks are performed.
> + * Returns: the dentry, suitably locked, or an ERR_PTR().
> + */
> +struct dentry *dentry_lookup_hashed(struct qstr *last,
> +                                   struct dentry *base,
> +                                   unsigned int lookup_flags)
> +{
> +       struct dentry *dentry;
> +
> +       inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
> +
> +       dentry =3D lookup_one_qstr_excl(last, base, lookup_flags);
> +       if (IS_ERR(dentry))
> +               inode_unlock(base->d_inode);
> +       return dentry;
> +}
> +EXPORT_SYMBOL(dentry_lookup_hashed);

Observation:

This part could be factored out of
__kern_path_locked()/kern_path_locked_negative()

If you do that in patch 2 while introducing done_dentry_lookup() then
it also makes
a lot of sense to balance the introduced done_dentry_lookup() with the
factored out
helper __dentry_lookup_locked() or whatever its name is.

Thanks,
Amir.

