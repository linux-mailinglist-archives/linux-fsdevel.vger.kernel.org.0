Return-Path: <linux-fsdevel+bounces-9878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20AF845A87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAE91C23230
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC25F47C;
	Thu,  1 Feb 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kYpWs1cK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66D45F469
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798839; cv=none; b=On/fkW8w4r4aru0wADo9lzxpns+wsCXyLC8bXKVw+dM60HpKXijYk+TKTXZU0nho3MF9NDSaX31HKydQOsRWr5LN1+f1LVJZgGTJg8k4pWCpGCwCgu7VNKKvp9z3yNkMtqRwciGmnC1GAMFVVyovSq5wHExRJYW9srEP7/WL5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798839; c=relaxed/simple;
	bh=ghHnMWh8SeSXaowvHcEILYTbjWaNvqfOQYyXufILQF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvieWApfkNU/pCg04XsdXcnLpONQOGm+JN0xe8EhPw0/QFOHPBTZAdDSuCgu0cdaXlUfzQ9qgF2KK5gjLLiId7evAxTciELt03SnftJvtAZzI0sdThs4dmSGHeis2P86ho4Hz8fxRywqi+YEOBH/1Y3Eor/6MrAATfs08MQ3lz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kYpWs1cK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a35e65df2d8so128495866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706798834; x=1707403634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4GNBu1ywZRf3UrWckV9ZgQxKVwiGyihe8iy/FMgIC8=;
        b=kYpWs1cKMIIkhH81XgrSNMgKkpeVRA0v9FtIMafwAs8IaULslHvCE5AaDaFjh32PCL
         HxvrA8n1xrpSog3vf8fAEuuPa6c9R65ouk79sH7wM4LQIbsSzDMc2i2V6chHi3hudFeG
         Wgvm1k+2a+A7VUqeU9PTkmiglPjQu6sJhe9vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798834; x=1707403634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4GNBu1ywZRf3UrWckV9ZgQxKVwiGyihe8iy/FMgIC8=;
        b=hvIPVIzGTmMZUZn4vuz5EeYSgDlIV1JAliE4nzMk1MUnCPzvvuLMsD1ahaG5OgAeN1
         kx0GxVA6YQKl/oBExYaqYqd21nDdgGbA7BCtPR6pRy/PPrJeD07O8pdz+tLkT//2Kn5F
         Xmgq0ZDaX9eSm171SqaoOnfNXr3Mbdtrj0UQZKUtrvM6WTa0LEKxUBzBlZqWVGm9PDfS
         AUwOu/Wn1i1yv8qHkH6IzixdgeCVo7ZakGNlN+Lez7+aP9Fe/nu9vLP6ArjOjWNSCbKC
         emgal2EnjvUTl3oIpTf4CTeblUR0iBvIrBCcgsuYxnwRZJj8XGaTaY1QxkSgCvh8ywtF
         23nw==
X-Gm-Message-State: AOJu0Yyg8sUEnkxfXPtJKUmJX+QI+1PPn72/6yAPUnCOgGYznH5iRl9x
	Vddn7wZVSBOsnDnaxScFdEx8LDRQ9RCxZvlucX31L8HrmppgmxHcPw9VBzfh3MVH5lw9Ql49iok
	zYnI3hIlPe3pQL46CRAoRpHABObhfDp3+3KItCw==
X-Google-Smtp-Source: AGHT+IGAX4vpVT6uIMqSO14muA6xhO60BqzmigZVMAyz6eJ5Ek68jK9D1e6Coxzb2zE4fiTZcghQGxQXOegODYeareY=
X-Received: by 2002:a17:906:1688:b0:a35:deb0:cd1a with SMTP id
 s8-20020a170906168800b00a35deb0cd1amr3508359ejd.39.1706798833601; Thu, 01 Feb
 2024 06:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-6-bschubert@ddn.com>
In-Reply-To: <20240131230827.207552-6-bschubert@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 1 Feb 2024 15:47:01 +0100
Message-ID: <CAJfpegvUfQw4TF7Vz_=GMO9Ta=6Yb8zUfRaGMm4AzCXOTdYEAA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fuse: introduce inode io modes
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, dsingh@ddn.com, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> The fuse inode io mode is determined by the mode of its open files/mmaps
> and parallel dio.
>
> - caching io mode - files open in caching mode or mmap on direct_io file
> - direct io mode - no files open in caching mode and no files mmaped
> - parallel dio mode - direct io mode with parallel dio in progress

Specifically if iocachectr is:

> 0 -> caching io
== 0 -> direct io
< 0 -> parallel io

>
> We use a new FOPEN_CACHE_IO flag to explicitly mark a file that was open
> in caching mode.

This is really confusing.  FOPEN_CACHE_IO is apparently an internally
used flag, but it's defined on the userspace API.

a) what is the meaning of this flag on the external API?
b) what is the purpose of this flag internally?

>
> direct_io mmap uses page cache, so first mmap will mark the file as
> FOPEN_DIRECT_IO|FOPEN_CACHE_IO (i.e. mixed mode) and inode will enter
> the caching io mode.
>
> If the server opens the file with flags FOPEN_DIRECT_IO|FOPEN_CACHE_IO,
> the inode enters caching io mode already on open.
>
> This allows executing parallel dio when inode is not in caching mode
> even if shared mmap is allowed, but no mmaps have been performed on
> the inode in question.
>
> An open in caching mode and mmap on direct_io file now waits for all
> in-progress parallel dio writes to complete, so paralle dio writes
> together with FUSE_DIRECT_IO_ALLOW_MMAP is enabled by this commit.

I think the per file state is wrong, the above can be done with just
the per-inode state.


>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/fuse/file.c            | 215 ++++++++++++++++++++++++++++++++++++--
>  fs/fuse/fuse_i.h          |  79 +++++++++++++-
>  include/uapi/linux/fuse.h |   2 +
>  3 files changed, 286 insertions(+), 10 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 7d2f4b0eb36a..eb9929ff9f60 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -105,10 +105,177 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
>         kfree(ra);
>  }
>
> +static bool fuse_file_is_direct_io(struct file *file)
> +{
> +       struct fuse_file *ff = file->private_data;
> +
> +       return ff->open_flags & FOPEN_DIRECT_IO || file->f_flags & O_DIRECT;
> +}

This is one of the issues with the per-file state. O_DIRECT can be
changed with fcntl(fd, F_SETFL, ...), so state calculated at open can
go stale.

> +
> +/*
> + * Wait for cached io to be allowed -
> + * Blocks new parallel dio writes and waits for the in-progress parallel dio
> + * writes to complete.
> + */
> +static int fuse_inode_wait_for_cached_io(struct fuse_inode *fi)
> +{
> +       int err = 0;
> +
> +       assert_spin_locked(&fi->lock);
> +
> +       while (!err && !fuse_inode_get_io_cache(fi)) {
> +               /*
> +                * Setting the bit advises new direct-io writes
> +                * to use an exclusive lock - without it the wait below
> +                * might be forever.
> +                */
> +               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> +               spin_unlock(&fi->lock);
> +               err = wait_event_killable(fi->direct_io_waitq,
> +                                         fuse_is_io_cache_allowed(fi));
> +               spin_lock(&fi->lock);
> +       }
> +       /* Clear FUSE_I_CACHE_IO_MODE flag if failed to enter caching mode */
> +       if (err && fi->iocachectr <= 0)
> +               clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> +
> +       return err;
> +}

I suggest moving all infrastructure, including the inline helpers in
fuse_i.h into a separate source file.

> +
> +/* Start cached io mode where parallel dio writes are not allowed */
> +static int fuse_file_cached_io_start(struct inode *inode)
> +{
> +       struct fuse_inode *fi = get_fuse_inode(inode);
> +       int err;
> +
> +       spin_lock(&fi->lock);
> +       err = fuse_inode_wait_for_cached_io(fi);
> +       spin_unlock(&fi->lock);
> +       return err;
> +}
> +
> +static void fuse_file_cached_io_end(struct inode *inode)
> +{
> +       struct fuse_inode *fi = get_fuse_inode(inode);
> +
> +       spin_lock(&fi->lock);
> +       fuse_inode_put_io_cache(get_fuse_inode(inode));
> +       spin_unlock(&fi->lock);
> +}
> +
> +/* Start strictly uncached io mode where cache access is not allowed */
> +static int fuse_file_uncached_io_start(struct inode *inode)
> +{
> +       struct fuse_inode *fi = get_fuse_inode(inode);
> +       bool ok;
> +
> +       spin_lock(&fi->lock);
> +       ok = fuse_inode_deny_io_cache(fi);
> +       spin_unlock(&fi->lock);
> +       return ok ? 0 : -ETXTBSY;
> +}
> +
> +static void fuse_file_uncached_io_end(struct inode *inode)
> +{
> +       struct fuse_inode *fi = get_fuse_inode(inode);
> +       bool allow_cached_io;
> +
> +       spin_lock(&fi->lock);
> +       allow_cached_io = fuse_inode_allow_io_cache(fi);
> +       spin_unlock(&fi->lock);
> +       if (allow_cached_io)
> +               wake_up(&fi->direct_io_waitq);
> +}
> +
> +/* Open flags to determine regular file io mode */
> +#define FOPEN_IO_MODE_MASK \
> +       (FOPEN_DIRECT_IO | FOPEN_CACHE_IO)
> +
> +/* Request access to submit new io to inode via open file */
> +static int fuse_file_io_open(struct file *file, struct inode *inode)
> +{
> +       struct fuse_file *ff = file->private_data;
> +       int iomode_flags = ff->open_flags & FOPEN_IO_MODE_MASK;
> +       int err;
> +
> +       err = -EBUSY;
> +       if (WARN_ON(ff->io_opened))
> +               goto fail;
> +
> +       if (!S_ISREG(inode->i_mode) || FUSE_IS_DAX(inode)) {

This S_ISREG check can also go away with separating the directory opens.

