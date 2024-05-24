Return-Path: <linux-fsdevel+bounces-20096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA808CE081
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 06:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718321F21792
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 04:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D153A28D;
	Fri, 24 May 2024 04:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfNZZU/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9713A27B;
	Fri, 24 May 2024 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716526714; cv=none; b=snFdQ/GZogDXhG9xCHx5TZgS14osTG1Dk1Bo3qlYERBaTF6xyg2ZIyFz8jc91tzeetKbkJdl7mi+FCfSx4Ai2kDHzG2Ft4L8tV2bsiHOPEdOicD88mj8qMAbLRaNBtLmugiu1TgLTggDiKq/+nC62aXRg9ZCTyHhgzTAn6YWaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716526714; c=relaxed/simple;
	bh=XNiUy9rDYeevLGiJZ9A/DHHrIjr9khy247wJmZzY+ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rm2U+9+Uq6IqumCkK0I2fDo3pW/zJJyMQ0mcGQXeVtEoVCyLVyQbAyjxsYs2H/4gHZfYCKqrKwzbXcLFQIhghtXvyurMxpdKPioUgQ9Y190CjfXGMyvId8TXLEBJcZBg+5ohtO31ewHcpzUDXfN5VAhvoJku2WcxKmERVllNYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfNZZU/r; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-794ab20699cso27508685a.2;
        Thu, 23 May 2024 21:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716526710; x=1717131510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk3w0+viSFtKKuzWbFP83UAoZOZ1q21d0XNuU6k+kPk=;
        b=bfNZZU/r9RyOPWCWXT8C59J+0vknNpPXG60DaHrOQW4Y+v2TK5gY+xo6ZynezOb8Mf
         lWpTfFsr+J2t95tcZFNHgefnMhI9EMEJU0OqiOvcWvv1kbOsVGpdaqaPmNSTaHT3FgfL
         9c3pyO8XuE/PiwwoqkKgMl+yfNKvIeVTtdwXeTi3RV3dG5jbnDjnT3Sbb37j8hs56dgf
         P4/snWGHOFj61ul7/UDjbqypeS26pj67RvgHm9+YQuKAmH+aC0nPJaIRd+QrXHCdtjFH
         lHG7Dbu1eto2JxerKNBu4ntrVgnK1vRkWU4wy8G5sXe2qsBc8MNiboxWL3mSeP7y2ulL
         PqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716526710; x=1717131510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yk3w0+viSFtKKuzWbFP83UAoZOZ1q21d0XNuU6k+kPk=;
        b=K7sLZRNNSeJEk4UIVYOm91bTPKp8RtEs2eWqjx64QzqMx7Cd0qGaR4SrCxAc1Zqahl
         jzaPJIqOkN+CMLWh8zflLx3a/zjRbJ+2UKO+PJdnXyElatvyJiKKaenmUMzcUfI7Suv6
         0jPyAtI7vvKVgJhBMityFs7uhKkP4b0lLXSbHfEt1n80YpveLzfh+L4kIubXOnZ3FR6G
         OfcN3dqV3q5G7QfySuVulTVZJ1xVdpdUkiF70tvWDyagotD2tM7nH/hhfBTc6htlASb8
         x9SdGYeoRqE5hkd334qzXlBQW83W77w+aQIGuJR6unaagL1Rm2Ds/ng6YDvLqbdlJAh1
         a88A==
X-Forwarded-Encrypted: i=1; AJvYcCV6x3AWYhTwYhqVuOAKaVGdz5wwA+BvQu8W/Mjihf06KHnP+Mx8aZm+5SulHaPCozbkpfdfqaDCBnf2FKtAgag2C8nxLAKRsPEf0wsL7hWHBuXJmeh6RzR7ihWPp8WeDjlpvsftXuuePTPOQe6VQPGIUvGbfYa3DD+opP72mIksRsPMwj1Twin/36NbeFPMV5Ivx3F+NBqyxBvOzYQrgilG3Q==
X-Gm-Message-State: AOJu0YzBqs2QeK/gyfDpLFb8fKdGpxkX+ze/ECRilvL4gq14xAROrLPG
	bplaTQraw88b/9mFDPB/88j6nBr7DxdJENBOstP//F1Jh/cQb3pgDgx65jAAg8dP5JsdCgy7s+u
	6OhXYwgYDqVLbLP8d2HZ7nWlB2e8=
X-Google-Smtp-Source: AGHT+IHwxoEyC/CgfcoYNTuXoypW6cR/wpwLB7WDQ5aO6pnZBvqbeq9XfR3HiSKH17tsDXpgZ02lfQFnCyS+mBCcaM4=
X-Received: by 2002:a05:620a:817:b0:794:9a23:4915 with SMTP id
 af79cd13be357-794ab057904mr115843085a.8.1716526710061; Thu, 23 May 2024
 21:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
In-Reply-To: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 May 2024 07:58:18 +0300
Message-ID: <CAOQ4uxhp0_HSre2LLStPVVsEJ3MqYDs1Ak9UAvB=o8Z7sVB=Mg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to name_to_handle_at(2)
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 11:57=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
>
> Now that we provide a unique 64-bit mount ID interface in statx, we can
> now provide a race-free way for name_to_handle_at(2) to provide a file
> handle and corresponding mount without needing to worry about racing
> with /proc/mountinfo parsing.
>
> While this is not necessary if you are using AT_EMPTY_PATH and don't
> care about an extra statx(2) call, users that pass full paths into
> name_to_handle_at(2) need to know which mount the file handle comes from
> (to make sure they don't try to open_by_handle_at a file handle from a
> different filesystem) and switching to AT_EMPTY_PATH would require
> allocating a file for every name_to_handle_at(2) call, turning
>
>   err =3D name_to_handle_at(-EBADF, "/foo/bar/baz", &handle, &mntid,
>                           AT_HANDLE_MNT_ID_UNIQUE);
>
> into
>
>   int fd =3D openat(-EBADF, "/foo/bar/baz", O_PATH | O_CLOEXEC);
>   err1 =3D name_to_handle_at(fd, "", &handle, &unused_mntid, AT_EMPTY_PAT=
H);
>   err2 =3D statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, &statxbuf);
>   mntid =3D statxbuf.stx_mnt_id;
>   close(fd);
>
> Unlike AT_HANDLE_FID, as per Amir's suggestion, AT_HANDLE_MNT_ID_UNIQUE
> uses a new AT_* bit from the historically-unused 0xFF range (which we
> now define as being the "per-syscall" range for AT_* bits).
>

Sorry for nit picking, but I think that "Unlike AT_HANDLE_FID,..." is confu=
sing
in this statement.
AT_HANDLE_FID is using a bit that was already effectively allocated for a
"per-syscall" range.
I don't think that mentioning AT_HANDLE_FID adds any clarity to the stateme=
nt
so better drop it?

> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
> Changes in v2:
> - Fixed a few minor compiler warnings and a buggy copy_to_user() check.
> - Rename AT_HANDLE_UNIQUE_MOUNT_ID -> AT_HANDLE_MNT_ID_UNIQUE to match st=
atx.
> - Switched to using an AT_* bit from 0xFF and defining that range as
>   being "per-syscall" for future usage.
> - Sync tools/ copy of <linux/fcntl.h> to include changes.
> - v1: <https://lore.kernel.org/r/20240520-exportfs-u64-mount-id-v1-1-f55f=
d9215b8e@cyphar.com>
> ---
>  fs/fhandle.c                     | 29 ++++++++++++++++++++++-------
>  include/linux/syscalls.h         |  2 +-
>  include/uapi/linux/fcntl.h       | 28 +++++++++++++++++++++-------
>  tools/include/uapi/linux/fcntl.h | 28 +++++++++++++++++++++-------
>  4 files changed, 65 insertions(+), 22 deletions(-)
>
[...]

> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index c0bcc185fa48..9ed9d65842c1 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -87,22 +87,24 @@
>  #define DN_ATTRIB      0x00000020      /* File changed attibutes */
>  #define DN_MULTISHOT   0x80000000      /* Don't remove notifier */
>
> +#define AT_FDCWD               -100    /* Special value used to indicate
> +                                           openat should use the current
> +                                           working directory. */

(more nit picking)
If you are changing this line, please at least add a new line,
this is a different namespace :-/
and perhaps change it to "Special value of dirfd argument..."

Also, better leave a comment here to discourage allocation from this range:

+ /* Reserved for per-syscall flags              0xff   */

> +#define AT_SYMLINK_NOFOLLOW    0x100   /* Do not follow symbolic links. =
 */
> +
>  /*
> - * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EA=
CCESS is
> - * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only t=
o
> + * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EA=
CCESS
> + * is meaningful only to faccessat, while AT_REMOVEDIR is meaningful onl=
y to
>   * unlinkat.  The two functions do completely different things and there=
fore,
>   * the flags can be allowed to overlap.  For example, passing AT_REMOVED=
IR to
>   * faccessat would be undefined behavior and thus treating it equivalent=
 to
>   * AT_EACCESS is valid undefined behavior.
>   */

If you are going to add this churn in this patch, please do it otherwise.
It does not make sense to have this long explanation about pre-syscall
AT_* flags in a different location from the comment you added about
"All new purely-syscall-specific AT_* flags.."
if this explanation is needed at all, it should be after the new comment
as an example.


> -#define AT_FDCWD               -100    /* Special value used to indicate
> -                                           openat should use the current
> -                                           working directory. */
> -#define AT_SYMLINK_NOFOLLOW    0x100   /* Do not follow symbolic links. =
 */
>  #define AT_EACCESS             0x200   /* Test access permitted for
>                                             effective IDs, not real IDs. =
 */
>  #define AT_REMOVEDIR           0x200   /* Remove directory instead of
>                                             unlinking file.  */

I really prefer to move those to the per-syscall section
right next to AT_HANDLE_FID and leave a comment here:

/* Reserved for per-syscall flags           0x200   */

> +
>  #define AT_SYMLINK_FOLLOW      0x400   /* Follow symbolic links.  */
>  #define AT_NO_AUTOMOUNT                0x800   /* Suppress terminal auto=
mount traversal */
>  #define AT_EMPTY_PATH          0x1000  /* Allow empty relative pathname =
*/
> @@ -114,10 +116,22 @@
>
>  #define AT_RECURSIVE           0x8000  /* Apply to the entire subtree */
>
> -/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits.=
.. */
> +/*
> + * All new purely-syscall-specific AT_* flags should consider using bits=
 from
> + * 0xFF, but the bits used by RENAME_* (0x7) should be avoided in case u=
sers
> + * decide to pass AT_* flags to renameat2() by accident.

Sorry, but I find the use of my renameat2() example a bit confusing
in this sentence.
If you mention it at all, please use "For example, the bits used by..."
but I think it is more important to say "...should consider re-using bits
already used by other per-syscalls flags".

> These flag bits are
> + * free for re-use by other syscall's syscall-specific flags without wor=
ry.
> + */
> +
> +/*
> + * Flags for name_to_handle_at(2). To save AT_ flag space we re-use the
> + * AT_EACCESS/AT_REMOVEDIR bit for AT_HANDLE_FID.
> + */

AT_EACCESS/AT_REMOVEDIR/AT_HANDLE_FID have exact same status,
so instead of this asymmetric comment:

+/* Flags for faccessat(2) */
+#define AT_EACCESS             0x200   /* Test access permitted for
+                                           effective IDs, not real IDs.  *=
/
+/* Flags for unlinkat(2) */
+#define AT_REMOVEDIR           0x200   /* Remove directory instead of
+                                           unlinking file.  */
+/* Flags for name_to_handle_at(2) */
+#define AT_HANDLE_FID          0x200   /* file handle is needed to
                                        compare object identity and may not
                                        be usable to open_by_handle_at(2) *=
/

> +#define AT_HANDLE_MNT_ID_UNIQUE        0x80    /* return the u64 unique =
mount id */

IDGI, I think we may have been miscommunicating :-/
If 0x7 range is to be avoided for generic AT_ flags, then it *should* be us=
ed
for new per-syscall flags such as this one.

The reservation of 0xff is not a strong guarantee.
As long as people re-use new per-syscalls flags efficiently, we could
decide to reclaim some of this space for generic AT_ flags in the future
if it is needed.

I know most of the mess was here before your patch, but I think
it got to a point where we must put a little order before introducing
the new per-syscall flag.

Thanks,
Amir.

