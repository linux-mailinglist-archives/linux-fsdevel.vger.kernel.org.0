Return-Path: <linux-fsdevel+bounces-55438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E318B0A6D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BDE5A4231
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028492DCF47;
	Fri, 18 Jul 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpI+Z4DO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72C2343BE
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851429; cv=none; b=MkgyQ/FN98AUDKkvSx0j8htFuMo07HxRLvdOiID7c9bDP8ehqQ6gebcx2xPYjcI70WwXQ/eg0bIHFv3CilUF+fW5vzk7+DkPu+No7tX0gHNJchl8BV/i9utX/LsmTOplZV54Ly6YPm0efMfk05FA4DqLnC4wHs/GYDSR9zGGhZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851429; c=relaxed/simple;
	bh=2NyMaMNUBnlNS5tGDuRqKoMo0Sq4QRGjrGNDOWJDAR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3RilxADmzSOSqO5F03eSwikpquph+FlB4St5H7J4YJWG5Jf3kNwP3yHC4+zDCAnow+cBxH8JmUM691rxxdFWU0YmYxc1i20VbS0R/79WVaKIgD6WXKTT+hBKNWw/vo+rWUZJyAMinAtAHg4tEf6mxCtt9VGW/eyfGaXW4OVHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpI+Z4DO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-612b67dcb89so2705036a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752851426; x=1753456226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+2qmTrX7XjjtGNAHD6YPg45YO/d1rMbk357iAuB4rM=;
        b=OpI+Z4DO6lNofl8+Rr4ctPn7E2F82pq2iaijJbdwuxu0PH3j0qHwHyvo+8+dcRwKc9
         YE4Qk1KCMeIaf1gzIUnLcCK8VsfZkZOktQ1kD7VYw/1k64iYwztVrj5q6+mflMT3aBc6
         Xqk3/5E0QTOVvOJJiCX7mSg6RNCwHTdXyWIcaq/3Ux9bBu/OFl4vj/Yi3KN3zYjSRDIO
         eEi6NzVDDFA+sKAT8W6sQuXwuul8wIXkAH/R7TaIjgfkVeNLM8QFKpGUGEKv7c/muJHz
         zc3Fa1PNomXI0oyXkBT/JOzzmtU79FyAsLd8981q3ggBhJjxHGdwlj2S11FGCrUwAF6g
         JLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752851426; x=1753456226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+2qmTrX7XjjtGNAHD6YPg45YO/d1rMbk357iAuB4rM=;
        b=RhW6I/pnbLrSP4Nxw9Gql8rnI6cDCmD1TXVAqtUsylcWj2BWj6CeyqJtCww5Z0kJtJ
         LTYlK4v8BQCcKR3WyMT+umQ17LbdCkU3Gj5mCrC6U7qPEsHe5uChCBEZVlFUOvvCWE1N
         aX7/JLw8T9+YxQNNFsCL7YF0aLpEhaxaB2VwqOnEk8Iz3Sx9FfeiH/NJ6U7N44N0+K1h
         lxl+L2IQidryVq2QilSAG0OXQcwNHE3h3agjr+5V4Swu/QYLT8wt7/pgYPQP93jmK8xU
         AL39FEqeGigtPljCW6faRyY3C4aZXkPUygO+vbT3kA5wtguEiH2hY7ePbVaxe4c5ADEs
         YSbw==
X-Gm-Message-State: AOJu0YwX33Z8Qqap9BkJq/xg1ee3/wRkgRkm3ZOAhwRZWW+vcw6i8ok4
	odAn0mLNLBexh4/NwfsuMUBrpAXdnCsWJvmrL36/XHXihrw0EefPlHe4y5mbyq2pgZbHTog6LXH
	e/uh5QAl0y3ZjNQhTlToYU4DxeNU1jg4=
X-Gm-Gg: ASbGnctknNcWINDxiGl2kCECovtACm541hH6Bi0W004a6f4tMHXD5VJlpfDDz4as+3n
	qhFPy1ZdXtUOS6aSaooweLtUQbjxS3iDaAyvxZHM2bA5UCoCIWWAPnJ7WdT5IRfIG69yZ/cUPWz
	N0SU8a5vZWxyVyAbeP+vvlRNs7mvH70QLchiPwXGaDGRVcymLMTLhnyTe+TE8GbsBjSajXALjwa
	2f1ufw=
X-Google-Smtp-Source: AGHT+IHgS7Z01HbMaOwpGVvwdwd8nwkl1LjCb4K3kzhuhE2ZJv4jkKq2905tXZb1E/lgIzAEke386jSvttgbLdxkREA=
X-Received: by 2002:a17:907:9495:b0:ae3:74be:4998 with SMTP id
 a640c23a62f3a-ae9cddb3aaamr1066623666b.11.1752851425789; Fri, 18 Jul 2025
 08:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs> <175279450066.711291.11325657475144563199.stgit@frogsfrogsfrogs>
In-Reply-To: <175279450066.711291.11325657475144563199.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Jul 2025 17:10:14 +0200
X-Gm-Features: Ac12FXzot_dYgWhcb6aDzs7UPp8X48muG_sjsXbd20G62RtZEdRv44lx52aZbf4
Message-ID: <CAOQ4uxjfTp0My7xv39BA1_nD95XLQd-TqERAMG-C4V3UFYpX8w@mail.gmail.com>
Subject: Re: [PATCH 06/13] fuse: implement buffered IO with iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 1:32=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Implement pagecache IO with iomap, complete with hooks into truncate and
> fallocate so that the fuse server needn't implement disk block zeroing
> of post-EOF and unaligned punch/zero regions.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h          |   46 +++
>  fs/fuse/fuse_trace.h      |  391 ++++++++++++++++++++++++
>  include/uapi/linux/fuse.h |    5
>  fs/fuse/dir.c             |   23 +
>  fs/fuse/file.c            |   90 +++++-
>  fs/fuse/file_iomap.c      |  723 +++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/inode.c           |   14 +
>  7 files changed, 1268 insertions(+), 24 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 67e428da4391aa..f33b348d296d5e 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -161,6 +161,13 @@ struct fuse_inode {
>
>                         /* waitq for direct-io completion */
>                         wait_queue_head_t direct_io_waitq;
> +
> +#ifdef CONFIG_FUSE_IOMAP
> +                       /* pending io completions */
> +                       spinlock_t ioend_lock;
> +                       struct work_struct ioend_work;
> +                       struct list_head ioend_list;
> +#endif
>                 };

This union member you are changing is declared for
/* read/write io cache (regular file only) */
but actually it is also for parallel dio and passthrough mode

IIUC, there should be zero intersection between these io modes and
 /* iomap cached fileio (regular file only) */

Right?

So it can use its own union member without increasing fuse_inode size.

Just need to be carefull in fuse_init_file_inode(), fuse_evict_inode() and
fuse_file_io_release() which do not assume a specific inode io mode.

Was it your intention to allow filesystems to configure some inodes to be
in file_iomap mode and other inodes to be in regular cached/direct/passthro=
ugh
io modes?

I can't say that I see a big benefit in allowing such setups.
It certainly adds a lot of complication to the test matrix if we allow that=
.
My instinct is for initial version, either allow only opening files in
FILE_IOMAP or
DIRECT_IOMAP to inodes for a filesystem that supports those modes.

Perhaps later we can allow (and maybe fallback to) FOPEN_DIRECT_IO
(without parallel dio) if a server does not configure IOMAP to some inode
to allow a server to provide the data for a specific inode directly.

fuse_file_io_open/release() can help you manage those restrictions and
set ff->iomode =3D IOM_FILE_IOMAP when a file is opened for file iomap.
I did not look closely enough to see if file_iomap code ends up setting
ff->iomode =3D IOM_CACHED/UNCACHED or always remains IOM_NONE.

Thanks,
Amir.

