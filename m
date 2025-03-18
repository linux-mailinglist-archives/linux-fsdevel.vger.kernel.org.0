Return-Path: <linux-fsdevel+bounces-44362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAFFA67EC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 22:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C329423B93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 21:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9562063D3;
	Tue, 18 Mar 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW7ovNTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F02063D7;
	Tue, 18 Mar 2025 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333609; cv=none; b=kr6IbYenyr9eVXEl0KO/azUNOfW3R8e+U8gOuus70bQb7XpIFbVkqNnc1HbR4/We+rf7CfaO2/WUxtie4eTYOFxeL/jm7ymgipZ9wB4c2xS24bRvH5y2d4UaWMq7hl+6Cy+VPk8e9GKqR9uVxBvec9Zb+Jmj6rQut6PwncFyg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333609; c=relaxed/simple;
	bh=n5/uT9PMtOTNcB42Fg+toVV98jBbB66WFAWZVC7GuzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICYvEpf6yhebsmQc62p/VBEY9aKJWgwCLYGQTwT8U9VZW3AK3FiEuyDek2VvcRaU/J/vEfsKOZAaYXMXyjeo40rVIldSBIkfGYv/p/Y4wZdhfrwEHmZTDIgeslL8UsYiWS+os1Qf81dkJsYT3dB+0xPxSCHTAISpUD5FIW6Qzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW7ovNTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E6EC4CEF0;
	Tue, 18 Mar 2025 21:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742333608;
	bh=n5/uT9PMtOTNcB42Fg+toVV98jBbB66WFAWZVC7GuzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jW7ovNTcAnnG/y82YmaYWawtoDZrVWY5XklrvI8AeEFnVEJ6bI82ZBAO/a9h44X3g
	 vbb0X/+Pu2idFprH23jY/UcyaCH7PdjXqZuN6J/dhgCHZOra5BZdwSJJFKjEzYulqx
	 mjd15EFk9qpk8LMC/nzWc18kWfxApZNoDahxNRx4xom15k5VPII8ZckNd0Jc3JeCm6
	 Od+/hj7kLy6XssJ8gr0amb0hh3jK/jDH2N9Ha+07vZZlsfjbD7y20OoWIZI9rzFl16
	 VPKfN8us03fVGkntrMFGgzWbu3S4KdbECfaoNXdmvn1KLVLnabva5F4abNS8QRW7Sn
	 99Jp5yIkg09Bg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5499d2134e8so6906369e87.0;
        Tue, 18 Mar 2025 14:33:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWu6ptuTVYTI0fXpnG10VF6bcEQW7Bo8r+wa/fX6Zf8IwfqFJuGAnAlHOPdXXBlDJPS2aIcEDs1LP0Nz+v0@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTiQIOwuEFKoCTLVNhdmEkkzrTpQVjIlrweyjlVtP5BhdWr8M
	KxFBac9Xwd4MtZaiBsuzov2egG3cwnsgm1/PBI+QKa3qMZKZH2gKZcfdBEFczZxDMXQPnaUCl+m
	4Sj71IkPXdyQATgHjCi7fwyHImSw=
X-Google-Smtp-Source: AGHT+IF4RCbT0CtOzCZkvebGleZPvUyCGvgOUAQncaDOcD+DOylVcOlHGMXBzKpNx03TDhlrbnuE8ce/09Gff0b5Vgo=
X-Received: by 2002:a05:6512:400c:b0:549:9078:dd46 with SMTP id
 2adb3069b0e04-54acb21a517mr40774e87.43.1742333607177; Tue, 18 Mar 2025
 14:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com> <20250318194111.19419-3-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20250318194111.19419-3-James.Bottomley@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Mar 2025 22:33:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHZfABW6JyPgHDHm-wDX0Orbhs8v=Y1vrboQh2ra1opFQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrAlFWHdKtmNTZW6UJiQ1fCzKiCqDBYjAK-_6M5Xi8BFW6WBpmGDH8RdmI
Message-ID: <CAMj1kXHZfABW6JyPgHDHm-wDX0Orbhs8v=Y1vrboQh2ra1opFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] libfs: add simple directory iteration function
 with callback
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 20:45, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> The current iterate_dir() infrastructure is somewhat cumbersome to use
> from within the kernel.  Introduce a lighter weight
> simple_iterate_dir() function that directly iterates the directory and
> executes a callback for each positive dentry.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  fs/libfs.c         | 33 +++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  2 files changed, 35 insertions(+)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 816bfe6c0430..37da5fe25242 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -214,6 +214,39 @@ static void internal_readdir(struct dentry *dentry, struct dentry *cursor,
>         dput(next);
>  }
>
> +/**
> + * generic_iterate_call - iterate all entries executing @callback

This name doesn't match the name below.

> + *
> + * @dir: directory to iterate over
> + * @data: data passed to callback
> + * @callback: callback to call
> + *
> + * Iterates over all positive dentries that are direct children of
> + * @dir (so doesn't include . and ..) and executes the callback for
> + * each of them.  Note that because there's no struct *mnt, the caller
> + * is responsible for pinning the filesystem.
> + *
> + * If the @callback returns true, the iteration will continue and if
> + * it returns @false, it will stop (note that since the cursor is
> + * destroyed the next invocation will go back to the beginning again).
> + *
> + */
> +int simple_iterate_call(struct dentry *dir, void *data,
> +                       bool (*callback)(void *, struct dentry *))
> +{
> +       struct dentry *cursor = d_alloc_cursor(dir);
> +
> +       if (!cursor)
> +               return -ENOMEM;
> +
> +       internal_readdir(dir, cursor, data, true, callback);
> +
> +       dput(cursor);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(simple_iterate_call);
> +
>  static bool dcache_readdir_callback(void *data, struct dentry *entry)
>  {
>         struct dir_context *ctx = data;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2788df98080f..a84896f0b2d1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3531,6 +3531,8 @@ extern int simple_rename(struct mnt_idmap *, struct inode *,
>                          unsigned int);
>  extern void simple_recursive_removal(struct dentry *,
>                                void (*callback)(struct dentry *));
> +extern int simple_iterate_call(struct dentry *dir, void *data,
> +                              bool (*callback)(void *, struct dentry *));
>  extern int noop_fsync(struct file *, loff_t, loff_t, int);
>  extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
>  extern int simple_empty(struct dentry *);
> --
> 2.43.0
>

