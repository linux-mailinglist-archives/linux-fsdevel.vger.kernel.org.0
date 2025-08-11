Return-Path: <linux-fsdevel+bounces-57428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EEDB215D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 21:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907AB46393E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B51026C3BD;
	Mon, 11 Aug 2025 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m32HbXrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5B18C322;
	Mon, 11 Aug 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941569; cv=none; b=KQzI4oMKkcPU4QrnNE3jD4DJT3JhLvXB5LeJgez7Pq7a0shwTO8zpokW+W4HaZgMMM9O+P9gQkdUz1F7825tcPNno2L8EbnPN7LH1TUAipzFqLoc02UnIXsDpe73rxIe99nNXke6iipjSKQ6NHYy8ulCdZmxz8uJLZ5PjODNSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941569; c=relaxed/simple;
	bh=iJpf2o328vvHnk9RWiF6HHv2wlBXAW+rnmC3yeK+7Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/IaoFYuKULqW1wSZOyE6jL4r+69U9ZaSf10IfSgFsVNii/2pgF1wvgHxyolOIogmDApu4dtGHQyzUymfeYtyz7No66U3zXCDNs+UYD0jGtrZFyt4IEuYJTn/C0gPhTMw3iNo4zzdt61BGT50J8C4eZAaGfqhWRf1nR47G1FAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m32HbXrj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af66f444488so674144966b.0;
        Mon, 11 Aug 2025 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754941566; x=1755546366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R63w6rEgccbZaug+S0zGSYmvTp2wPJ9uy6f96wR2h2I=;
        b=m32HbXrjHUHsVIyVdIzfseZIGj6CfdMp2jmvS/DGRcRcOOnGLVcjU0m0FefzBliUTI
         JAuDqxmOimKGIJpsPxmBBQ6U+nHF91Y2FQxzNKPkhQ/ZS6ZvlQ2sqMnUbg6MrtIbKiMq
         LobblXVTCrv2NehNAVja3oPRdeNm+91KENVrbbm3eUUYPmR7oMcRZ+ZevB9Rtyd6iODq
         M2w4RkcQ4OEcflYk/+nhPKOMMpKBtahRE9fRVC52nZhd0n+3as80d96pon7cInweBRrJ
         zx/iQG2M/Y8pV0hOjHIlJWYZstWQLkmTISZ1DICavFgCl+zzbT0eKMP5Wf1fgbfoYTOB
         j7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754941566; x=1755546366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R63w6rEgccbZaug+S0zGSYmvTp2wPJ9uy6f96wR2h2I=;
        b=KMLfOw/XBmAibcRJyPevAxm2pWTWnm9mNRfcxujnPZn+ZispfFCgEpfosyfosND8IR
         v1O42D9ixd1U/JJNlYhpwwrpTPNtA+QVmX6udmlJu0wPro2rRL35+YgbdbqnG9J8Li7q
         aXEDk7TOvWbfbGZew6NMbfzi0xOGLz9pgvMmo42TOb4ty9pTUEX6rPBqU7zDpQGHkj2I
         jqSXAxTDb7tUNrFz1j4TgCEbg7TvNJzRVJBXOhx0QfzViKnyW4sNIYmIXpsUDn4y9Dqj
         EmQvS8WSoS/pgpZGBlT+zPFyVzvL34LNQwJHTdqJnD91oMAwQNAQGF+pBte/iy2pwmHc
         vcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWApD2A78HivY7/RCAT3xKf6ci9Pc6SlMyxssXbWxUV8De14fgAkD2CuDBgaDHVzuFkC0UOCMDXwGlR7gbh@vger.kernel.org, AJvYcCWGiLA5qxwtc+5oV0FgEUq94pMCeWB8fOGJwkuBIUWUujghZIxx91svD4nqV2EN3Ez/dQ8Fcz8FeLY9YvgQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PY1eX9OXZZhJlZTqT9ax3z7q6vQPY7yQ1km10xyY5AjOVVnT
	aPI3nPdRUKx5HEtPySGeJJkuAQjS8k0QLVHqzrSZVJ8FqWCko8FSQynrV8eMtQhcGIS8op3h7VQ
	fGPdvfumIkvyTp+TEmByhoJ6FjEKxBqE=
X-Gm-Gg: ASbGncusUq/wlSUxTHDM4tSdJ92lANjLv3OvuKvuRFswS0Nm7H26BcNAhE5I4PwuQ9z
	r1ZPerdCMv8XHqvX5ozE36eIKhocWd3C5RBsZNJWonVTH+FY1N4heYhW7A2xCaOThjlA/z5L8vC
	D1t897FfcK6WmoZVFyR78l71N7BrPWkZnhwKQMhWWAUgtirMwtgViLxfcrNe3KrcFEBB+aneIHm
	9rjwFm4EYypRfvVORWxiN0HpDCExZqTk3tVeseEbQ==
X-Google-Smtp-Source: AGHT+IGnTrGlz91tALcGb/D+aUzZu/14GBXxBzlFRyXsZ8sk7J3bRqH9KUllAzjaSyBpmzkAwZKbSWhEpfgljzt+jsw=
X-Received: by 2002:a17:907:1ca9:b0:ade:405:9e38 with SMTP id
 a640c23a62f3a-af9c63d47a6mr1386282166b.24.1754941565484; Mon, 11 Aug 2025
 12:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ceaf4021-65cc-422e-9d0e-6afa18dd8276@I-love.SAKURA.ne.jp>
In-Reply-To: <ceaf4021-65cc-422e-9d0e-6afa18dd8276@I-love.SAKURA.ne.jp>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 11 Aug 2025 21:45:52 +0200
X-Gm-Features: Ac12FXw7Xl-5lTjW_bVq7R60Ffi0yUrxXLKNBOxlINxUTTyW2cY-HFMjw39NyFM
Message-ID: <CAGudoHEowsc290kfSgCjDJfB+RKOv2gLYS6y4OxyjhjPW07vMQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: show filesystem name at dump_inode()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 8:50=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Commit 8b17e540969a ("vfs: add initial support for CONFIG_DEBUG_VFS") add=
ed
> dump_inode(), but dump_inode() currently reports only raw pointer address=
.
> Comment says that adding a proper inode dumping routine is a TODO.
>
> However, syzkaller concurrently tests multiple filesystems, and several
> filesystems started calling dump_inode() due to hitting VFS_BUG_ON_INODE(=
)
> added by commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
> before a proper inode dumping routine is implemented.
>
> Show filesystem name at dump_inode() so that we can find which filesystem
> has passed an invalid mode to may_open() from syzkaller's crash reports.
>
> Link: https://syzkaller.appspot.com/bug?extid=3D895c23f6917da440ed0d
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 01ebdc40021e..8a60aec94245 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2914,7 +2914,7 @@ EXPORT_SYMBOL(mode_strip_sgid);
>   */
>  void dump_inode(struct inode *inode, const char *reason)
>  {
> -       pr_warn("%s encountered for inode %px", reason, inode);
> +       pr_warn("%s encountered for inode %px (%s)\n", reason, inode, ino=
de->i_sb->s_type->name);
>  }
>
>  EXPORT_SYMBOL(dump_inode);
> --
> 2.50.1

Better printing is a TODO in part because the routine must not trip
over arbitrarily bogus state, in this case notably that's unset
->i_sb.

See mm/debug.c:dump_vmg for an example.

I could swear one of the dumping routines in mm was using something
special to deref pointers without tripping over it either, but now I
can't find it.

All that said, I suggest this direction:
diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..113fcb8da983 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2914,7 +2914,9 @@ EXPORT_SYMBOL(mode_strip_sgid);
  */
 void dump_inode(struct inode *inode, const char *reason)
 {
-       pr_warn("%s encountered for inode %px", reason, inode);
+       struct super_block *sb =3D inode->i_sb; /* will be careful deref la=
ter */
+
+       pr_warn("%s encountered for inode %px [fs %s]", reason, inode,
sb ? sb->s_type->name : "NOT SET");
 }

 EXPORT_SYMBOL(dump_inode);

Can't do a proper submission at the moment and I'm not going to argue
about authorship should this land. :)

--=20
Mateusz Guzik <mjguzik gmail.com>

