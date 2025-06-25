Return-Path: <linux-fsdevel+bounces-52963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C88EAE8C5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598AA4A5298
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842E2D6609;
	Wed, 25 Jun 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvzpzIHP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCDE3074AC;
	Wed, 25 Jun 2025 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876256; cv=none; b=aFX+x7rm5cpw1XYNP9x9CjLGgs5/5Rmv9HJwVp5j4nVcYcixoN6L9gy4BP2cLfRHvtvxdD86AaNsudmfhixwbU/oKjQPB6jydrtJdlgd9D/9WsMuA3NYEktZm5faFQcmKOa0g63j1EEIWv+SBq7jJ0WrhQur7EYov2/Rl7OE/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876256; c=relaxed/simple;
	bh=2lpg+lLFbQ7Em7szuMPalqegZRryEsgdCZRV32FRgYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCxptAbNwuv+BVsv08uwyNQhkzpT53Pvx56pRVcNWrvZCkUcS9gblXxaMSTdiRN5toWK3dXogsUwAgCJlDyl8GyqSqit4xirbOHDChz3JDm5ZY9diqD+6fpbLMkkeoNE7fEP+CYIbph0Ov7zfCsPtrIG93qw80LkBhfSYnkBrRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvzpzIHP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so178160a12.2;
        Wed, 25 Jun 2025 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750876253; x=1751481053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHmZSVDd99XgStkgJ6q220ctHwcq4hRDkkXskiwd5ZU=;
        b=kvzpzIHPTg3MFHrFQdScuv4Etrq+A0iMc0flAayWZAVHlDfDEE0zYerpZOgmrIZc+c
         0RsJLTb8rHAx+GjswS/Aigi63ZrEIwkm6emhlg+FTyKr9eS855K4PD09JQu32BdF/z/H
         2lWiL7OfmhGRK50SMomZvEBfWGF/jStWM6ZymcJwZxq/oiydpn7NNVBrEfiXphYLftRM
         Zq4biLhPc5hz3AVulvujL3pwVoQTLb7+4U6ypCwMJgrHrkSvJgnQUBAUtq8H4Rjeb3rB
         4KwnoIOsbWkdHcdXCa/Sun0CpfSHm6FqqaUkAAsy72IQbZQKa4sirLWHeJxpp4ZZdurn
         0tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750876253; x=1751481053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHmZSVDd99XgStkgJ6q220ctHwcq4hRDkkXskiwd5ZU=;
        b=s8qSx6xW5JQ045g00nxG+KhTs+jFJo91cbAAoF2RauYJZ5Mwltg9AHzInwAJVFboLI
         43/qIZy41sdB+fyuWRsvel8akwqHXUdcc2FHZgSt+00zhZId6pup4X4g9Yxm/RnrqwBC
         rV/5AG+TDVTODM/rqsa1KUBC/xB996CJolT0gfoEMy/Ixoz1r3/TTS2L8UuS6q3U4e24
         9sDX5WJQSGQvssDQjJgF/wf/lAuK83bDaaeAeFx7XLxVnXg/qAn6hzj7UpqcLavHdSfO
         7JytVaZW3/6Qc1lJc5c5cY4e3y22fqvjgb91ZsDK+mJ+mxu4CITfChR9Lbg5IEj0iBus
         W3dA==
X-Forwarded-Encrypted: i=1; AJvYcCUg0MZjn7oaJgLOEeSM75sIXLTDahYbbSrKF5uIcMn3d5bJLgsfutaRKcbRbLtU6rIX+1hRt8Y1z86Ek68RJQ==@vger.kernel.org, AJvYcCX9vodRQrzAoGY8UdqBfb5+Prbx2WzgRp5F40GyS5pUp1fo0dMzXV7TvtRRO7QyxnRp6qvVEiOSqIalNKpJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxAa1anhUTw1gM+ChtVktKZ9Cw8JlXj4TWHGKSKeYIgdhYUGBSt
	uxym3px39FCFYk2YUCpCdcmNhxmflYMxNWe6aFuZbyWPxuIsKXC7k7PBkjIZ5lrBfsojxyG2ToJ
	gbIM3Fyw6SbtuZMylfHR/Q1oMVObNlMY=
X-Gm-Gg: ASbGnctBgSGHhLkN8WPyU0E9MgZA1fSDQQj644OrQEq69pyJURdU48C8aiNBZnyXsip
	CrRAyJeKdtYbe05IOb6fn9RU9Jh+nnsQEF5jDLWsdovXQr4+ZoCDB2xZBJsFmWQWpsv15ak22EW
	pC9TK73iBWa8+2da27+GN+F5cYVaU+vWtWTXTKv091awA=
X-Google-Smtp-Source: AGHT+IG7k2x22iafh8klQtSNa/vSITcZABW1SHSmiWPbhWV0UbqZXq9GgPgh5UWMwYUYN3FtAj1YGHNmT/G6PqQ/Z1k=
X-Received: by 2002:a17:906:c102:b0:ae0:ce40:11c6 with SMTP id
 a640c23a62f3a-ae0ce40186cmr167484766b.21.1750876253045; Wed, 25 Jun 2025
 11:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-8-neil@brown.name>
In-Reply-To: <20250624230636.3233059-8-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 20:30:41 +0200
X-Gm-Features: Ac12FXyJI_YJphFwrp3bChx01T43PGR_bNlzyCJ5VpObAqnhkie6nM7pfQkJXAk
Message-ID: <CAOQ4uxjDK3AJoY-geRLprvSKEW7UopJLY_9WcJ0LjwiKAP29uA@mail.gmail.com>
Subject: Re: [PATCH 07/12] ovl: narrow locking in ovl_rename()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Drop the rename lock immediately after the rename, and use
> ovl_cleanup_unlocked() for cleanup.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 2b879d7c386e..5afe17cee305 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1270,9 +1270,10 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>                             new_upperdir, newdentry, flags);
>         if (err)
>                 goto out_dput;
> +       unlock_rename(new_upperdir, old_upperdir);
>
>         if (cleanup_whiteout)
> -               ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
> +               ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
>
>         if (overwrite && d_inode(new)) {
>                 if (new_is_dir)
> @@ -1291,12 +1292,8 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>         if (d_inode(new) && ovl_dentry_upper(new))
>                 ovl_copyattr(d_inode(new));
>
> -out_dput:
>         dput(newdentry);
> -out_dput_old:
>         dput(olddentry);
> -out_unlock:
> -       unlock_rename(new_upperdir, old_upperdir);
>  out_revert_creds:
>         ovl_revert_creds(old_cred);
>         if (update_nlink)
> @@ -1307,6 +1304,14 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>         dput(opaquedir);
>         ovl_cache_free(&list);
>         return err;
> +
> +out_dput:
> +       dput(newdentry);
> +out_dput_old:
> +       dput(olddentry);
> +out_unlock:
> +       unlock_rename(new_upperdir, old_upperdir);
> +       goto out_revert_creds;
>  }

Once again, I really do not like the resulting code flow.
This is a huge function and impossile to follow all condition.
As a rule of thumb, I think you need to factor out the block of code under
lock_rename() to avoid those horrible goto mazes.

The no error case used to do dput(newdentry) and dput(olddentry)
how come they are gone now?
what am I missing?

Thanks,
Amir.

