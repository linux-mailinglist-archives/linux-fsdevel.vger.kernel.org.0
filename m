Return-Path: <linux-fsdevel+bounces-67721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4842C47E6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6B154F7494
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC5827E07E;
	Mon, 10 Nov 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cns/P4eR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B73927F16C
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790952; cv=none; b=j0MDY/VfqAj7oTtP3rXpvNE5BSkMkTWdJuOS/ZDJ+xvkTlX49HdHCeH696NazYVGRoxXaggBzUV1rZkG2mMDXKGgoBwrGibnGOubNaWqOc08PNLHapVFGTU4indhwCvQsR9nxbe+KiW/E76JldLcnAeYHlgEFu3wMYeHu8qR1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790952; c=relaxed/simple;
	bh=OKZOzwPNbZ0eA/RzD6GT+kbo2DW/QUWT3Vl/4pt9v6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiwKgSHQEF73kOO9dmrILHlUsd/bCektTGGEAS7Phte/PdB+OubmFyYW7SlGyCe/NVv+ioZUIrBvEzQwZZllq3+3+HjnrOWbJBkmkNkrgN69QUPeQEb01dqlhlPF6JffhI/DQg+N+gCRFNH9Q8foNlF1vwG/ia84SH+2yLFaN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cns/P4eR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so2602340a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 08:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790949; x=1763395749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s031glNNGPLU3pRhUQF/ls9Tz5E2v6rbM7VrNj/wX3k=;
        b=Cns/P4eRZdvAKqqYulMy3O1Se0Q8vGE+7/KHmQttIzBeZCAOQ3gDDvSz3+XnUlGKlA
         ppSKeNsijOTb87pYJLJ5k50or0OD1zAuKx/P/eWX4037TVlQqVFL7riJfGpFR9PAw+yw
         i35r/J2t++VuZnABkylXNQyFo7vmT/bIkC+03kUsYMfoOuA7srfNplO+MWMCLOUdocys
         kRK/1v7Xiv6BFDNMUQPEYULvJr7NvgOzNoNfsVhFwskwuZScbX19Hu9fVDnvws6rf1/r
         DA+gIfmMJ73YHlRbfF1hWRILx2jnva0+aojFy/GW3Cs+8rmIhzmtKqGnwi/roZpbzNmm
         7H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790949; x=1763395749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s031glNNGPLU3pRhUQF/ls9Tz5E2v6rbM7VrNj/wX3k=;
        b=pjzlwFQdJzo9P18XoQ2EwhpIRWKm8cOO2Hc9qAPhFQ677DT3UiwS1vNi3irDcqFPC4
         5nicaGUSr1q/Qt781/7cCeZXqmQ8cmjZfms+m1J2iIJACX+CiNOhZrRxKsI3UkKCMBoE
         IjgBmBb+fPP/JV2Shil9z/FPLhLDFI0OZt6Y0Xx91/aP0WPlw4JXfh6uCQwHfw8Tg3Hn
         QWbBPwvJ01nQLEA0qxEW0JXkCkomqO+g0BnZ3lNWDs4QY1jXId4IYsAUpMDl5eCGUAPu
         sJPZitO9aQ5hARq7+LjdDUthHABD1hT7qyTVFsbK4D4muiwIJI4u1ohtG9vJy+BUdmgl
         gPhA==
X-Forwarded-Encrypted: i=1; AJvYcCVgk/+QyjMhtjj1XZvQZum+olu8Srv4qq3zSGWRECXZ8/v4+6LoL8RyvvifCW9tDIBFFINREBbPBBrrlPsa@vger.kernel.org
X-Gm-Message-State: AOJu0YzXoFYoT80ksTIiXXKdqbUx/DdEc7IDDx7H7KwDW2XdLQ9L/JZy
	vwmBjOGusicopWUevL0OfbY4ft2Xzglo+tmRujvseIhEjhsUQfIFR+6BPNKHIv6FyHWOJkRHb3i
	aOEkJ0+Mab1yyg6j0ApHAzBB2WHIPG6c=
X-Gm-Gg: ASbGncsg6cbq3GyvdQA0AhZaY8Z/N7o/9xWpiYj7ZTg00Im+fOccTmzdLRzbznqtpKm
	nz+6WbProJWmzfP2kq9hMKYjt362UGDp6sMxGnid91aujazL8D3b/9giP9gTpoUBoJRqGaGrzWC
	qNHyCBI0xM112Qf0rrb5+6BjEYLNvc2cwBz8Q4RGT2MCRzl4E5oQBhHI2zdPWViyyZGW9qHYD+H
	NlEWM+hD6tYpKlkkNaLehqFyTNekc1G+s5dFyxcor7p+T46yVWx22ycuOYeneHWn6LSjZs=
X-Google-Smtp-Source: AGHT+IHOYPI89bvNijFudu8ipuYpe33+VB7nbqJZeXEdLg498kOVR3mmjHBZOcylAlfsBqli+DO2uzjCmhEfT9se4Vs=
X-Received: by 2002:a17:902:fc4f:b0:298:2237:a2eb with SMTP id
 d9443c01a7336-2982237a409mr51261425ad.16.1762790948766; Mon, 10 Nov 2025
 08:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106005333.956321-1-neilb@ownmail.net> <20251106005333.956321-12-neilb@ownmail.net>
In-Reply-To: <20251106005333.956321-12-neilb@ownmail.net>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 10 Nov 2025 11:08:57 -0500
X-Gm-Features: AWmQ_bnsQdAKOPc2sWsQJTL6A89EPTloA4MsBf1tbsCjlSWDuuet8e3lOwk-mCw
Message-ID: <CAEjxPJ528Ou4dvRwHo+kXjWreGicda8BOXkQRvq3vMED6JQKOQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] Add start_renaming_two_dentries()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Chuck Lever <chuck.lever@oracle.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:56=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> A few callers want to lock for a rename and already have both dentries.
> Also debugfs does want to perform a lookup but doesn't want permission
> checking, so start_renaming_dentry() cannot be used.
>
> This patch introduces start_renaming_two_dentries() which is given both
> dentries.  debugfs performs one lookup itself.  As it will only continue
> with a negative dentry and as those cannot be renamed or unlinked, it is
> safe to do the lookup before getting the rename locks.
>
> overlayfs uses start_renaming_two_dentries() in three places and  selinux
> uses it twice in sel_make_policy_nodes().
>
> In sel_make_policy_nodes() we now lock for rename twice instead of just
> once so the combined operation is no longer atomic w.r.t the parent
> directory locks.  As selinux_state.policy_mutex is held across the whole
> operation this does open up any interesting races.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
>
> ---
> changes since v3:
>  added missing assignment to rd.mnt_idmap in ovl_cleanup_and_whiteout
> ---

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 232e087bce3e..a224ef9bb831 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -539,22 +540,30 @@ static int sel_make_policy_nodes(struct selinux_fs_=
info *fsi,
>         if (ret)
>                 goto out;
>
> -       lock_rename(tmp_parent, fsi->sb->s_root);
> +       rd.old_parent =3D tmp_parent;
> +       rd.new_parent =3D fsi->sb->s_root;
>
>         /* booleans */
> -       d_exchange(tmp_bool_dir, fsi->bool_dir);
> +       ret =3D start_renaming_two_dentries(&rd, tmp_bool_dir, fsi->bool_=
dir);
> +       if (!ret) {
> +               d_exchange(tmp_bool_dir, fsi->bool_dir);

I would recommend an immediate goto out if ret !=3D 0; we don't want to
silently fall through and possibly reset ret on the next
start_renaming_two_dentries() call, thereby ultimately returning 0 to
the caller and acting as if nothing bad happened.

>
> -       swap(fsi->bool_num, bool_num);
> -       swap(fsi->bool_pending_names, bool_names);
> -       swap(fsi->bool_pending_values, bool_values);
> +               swap(fsi->bool_num, bool_num);
> +               swap(fsi->bool_pending_names, bool_names);
> +               swap(fsi->bool_pending_values, bool_values);
>
> -       fsi->bool_dir =3D tmp_bool_dir;
> +               fsi->bool_dir =3D tmp_bool_dir;
> +               end_renaming(&rd);
> +       }
>
>         /* classes */
> -       d_exchange(tmp_class_dir, fsi->class_dir);
> -       fsi->class_dir =3D tmp_class_dir;
> +       ret =3D start_renaming_two_dentries(&rd, tmp_class_dir, fsi->clas=
s_dir);
> +       if (ret =3D=3D 0) {
> +               d_exchange(tmp_class_dir, fsi->class_dir);
> +               fsi->class_dir =3D tmp_class_dir;
>
> -       unlock_rename(tmp_parent, fsi->sb->s_root);
> +               end_renaming(&rd);
> +       }
>
>  out:
>         sel_remove_old_bool_data(bool_num, bool_names, bool_values);
> --
> 2.50.0.107.gf914562f5916.dirty
>

