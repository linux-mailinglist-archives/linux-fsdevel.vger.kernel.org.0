Return-Path: <linux-fsdevel+bounces-34658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E929C744F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDC91F21FDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE12200CB1;
	Wed, 13 Nov 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f91oNBa/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284461F9ABD;
	Wed, 13 Nov 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508033; cv=none; b=Tdwwi8DyVR9Exf00EHpfRsv9iChGoVGOBJECAcM5sDbhmsqpYvKQ7CRU3bTHDswC3pQ7nV6jMJ6G8QV3jYo6ggmuq562Zb4FKi61dZr/ggVYzlI+9XeobpOWL5/oQBDjIqa8jIf5xc6D9LrVU8iMUdUMBq5LhzkGeR2DTBZu4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508033; c=relaxed/simple;
	bh=hsSf9bE+GoUc4+9xEzYYZ4OlJrBOA6K4INO2MbBwMaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3GcIMDIWo8jJ5N9YlvOnKqjPDnlzV2TlbuloMjwbTmArNZwGsUIh34oQO1mXYsp0e8RNRXNunICsT2rkDXT+aLSdFF6/SHOQSGq3264L9uIgkgqTEbpoqixPaeYTOt0wfo9xbo9UsB6FLRSIUz6qQ5bf63jDa/63V9ulYP7CBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f91oNBa/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cc2ea27a50so7230606d6.0;
        Wed, 13 Nov 2024 06:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731508031; x=1732112831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byaAHjXVMIKqWLBBJTf2K9IU7DPwWcEDa/fLiBJiK3k=;
        b=f91oNBa/0wU5T2O2BalqIijEp4Q8r54kXtJ0xuPPWOj2GOpxI/RuN00Q1zr1LjbsRz
         jvMtnyDbTgrsIhdpAICCKCMp7htzDiFA4bnbHlqv67yo74aaDBp1dTHd43usstIMl7Rr
         r2cj0FcfpvIwQ64IgYbwY55NHuryv7ef+t5swil+Ze7nZYt5HeieaQ+4a0rP3JVFaBTq
         rMi5JrOrBAzXAJN+x9V9ejiC4eG+27OzBIdGCx+JvBEQ2OZDPfNaIgrqwv2BliGWMZHE
         ascHOzFhpaQP8G/XGT26VGD17sXJpk0AZwkQBYH5cJG6M11ivEnbA8m4EEnbo39JJDac
         5NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508031; x=1732112831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byaAHjXVMIKqWLBBJTf2K9IU7DPwWcEDa/fLiBJiK3k=;
        b=JF4tepg+awgwff8f/9UVzWapSPGM6lKY0fow/VxE0WTAryhI+WbAzIHXei1HqoO9pv
         UVJ9ITFcuLc2/l9BNr6WqkdooMv1Ke+/iGDkBjW4nof8OJJwzFe5OeyuvBViyJYUkkHU
         OTdvEJRQECT+H4QTvXIa+3ftovl2s+2PwQ6OOE+fIuRWZGgZJkWFfqYeg7zEbfc+1LdV
         b4uZvl4oRh/oima45pQml3iWoEfDeXrvnIzezLFv206EmblceTze4qfURT0BlbBQ/43h
         ZFPcqUAl3BS4TPWgCef8OdB7G0aZTGG0wS7N+cHxt7uHl0RNnggSvIcDf7pt1rdSAyDG
         M68A==
X-Forwarded-Encrypted: i=1; AJvYcCVdge+UCkaFE2RLjnMBkX9ovCyZh4Yx0EnRwKqS8laWkjIA1zDkDTUPPefhLw9oYHkc4rEENn2ENeFfcg3FGQ==@vger.kernel.org, AJvYcCWG07zss7eE6zYk44CLtMKGXS96Cjjz5eTliFh/oXrXvd8Of7LAcEzkNBrwe+Qtwd2mz+SlPMwoIYb2yNgl@vger.kernel.org, AJvYcCWmZ+/KImRYnyy0Et21Q6YQVHmOrLp/p7JiYWivBKcUhX03bQ2hS/3SCzd2FIa2jzeBxCf9Nrf/MMZ3s3cB@vger.kernel.org
X-Gm-Message-State: AOJu0YwFV4F+Cr8VbEanfWRaPgxlaNg19JecQ5dLRruo8JDkTmvc5BBb
	vcF4uqvoskWcZhCqBujiG5laUJzLSkkXJZrjvZMBH+7mVhPe6fHgYXBLHC+JfC70ADLgFiQkZFu
	PDSeehueW9BmQ80D9TYwln5NrLfY=
X-Google-Smtp-Source: AGHT+IGnBfzQq2aRhyeSLvcYTvunpxmwCxusgSIeJnDVcERj9W+v0vZjYKbGY5+oetb5hhtyec4PZkPNIXG79pLP7xY=
X-Received: by 2002:a05:6214:3d0d:b0:6cc:255:2038 with SMTP id
 6a1803df08f44-6d39e4d24a3mr356911116d6.4.1731508031090; Wed, 13 Nov 2024
 06:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107005720.901335-1-vinicius.gomes@intel.com> <20241107005720.901335-5-vinicius.gomes@intel.com>
In-Reply-To: <20241107005720.901335-5-vinicius.gomes@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 15:26:59 +0100
Message-ID: <CAOQ4uxgHwmAa4K3ca7i1G2gFQ1WBge855R19hgEk7BNy+EBqfg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] ovl: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, brauner@kernel.org, miklos@szeredi.hu
Cc: hu1.chen@intel.com, malini.bhandaru@intel.com, tim.c.chen@intel.com, 
	mikko.ylinen@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Use override_creds_light() in ovl_override_creds() and
> revert_creds_light() in ovl_revert_creds_light().
>
> The _light() functions do not change the 'usage' of the credentials in
> question, as they refer to the credentials associated with the
> mounter, which have a longer lifetime.
>
> In ovl_setup_cred_for_create(), do not need to modify the mounter
> credentials (returned by override_creds()) 'usage' counter. Add a
> warning to verify that we are indeed working with the mounter
> credentials (stored in the superblock). Failure in this assumption
> means that creds may leak.
>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  fs/overlayfs/dir.c  | 7 ++++++-
>  fs/overlayfs/util.c | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 09db5eb19242..136a2c7fb9e5 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -571,7 +571,12 @@ static int ovl_setup_cred_for_create(struct dentry *=
dentry, struct inode *inode,
>                 put_cred(override_cred);
>                 return err;
>         }
> -       put_cred(override_creds(override_cred));
> +
> +       /*
> +        * We must be called with creator creds already, otherwise we ris=
k
> +        * leaking creds.
> +        */
> +       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(dentry-=
>d_sb));
>         put_cred(override_cred);
>
>         return 0;

Vinicius,

While testing fanotify with LTP tests (some are using overlayfs),
kmemleak consistently reports the problems below.

Can you see the bug, because I don't see it.
Maybe it is a false positive...

Christian, Miklos,

Can you see a problem?

Thanks,
Amir.


unreferenced object 0xffff888008ad8240 (size 192):
  comm "fanotify06", pid 1803, jiffies 4294890084
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc ee6a93ea):
    [<00000000ab4340a4>] __create_object+0x22/0x83
    [<0000000053dcaf3b>] kmem_cache_alloc_noprof+0x156/0x1e6
    [<00000000b4a08c1d>] prepare_creds+0x1d/0xf9
    [<00000000c55dfb6c>] ovl_setup_cred_for_create+0x27/0x93
    [<00000000f82af4ee>] ovl_create_or_link+0x73/0x1bd
    [<0000000040a439db>] ovl_create_object+0xda/0x11d
    [<00000000fbbadf17>] lookup_open.isra.0+0x3a0/0x3ff
    [<0000000007a2faf0>] open_last_lookups+0x160/0x223
    [<00000000e7d8243a>] path_openat+0x136/0x1b5
    [<0000000004e51585>] do_filp_open+0x57/0xb8
    [<0000000053871b92>] do_sys_openat2+0x6f/0xc0
    [<000000004d76b8b7>] do_sys_open+0x3f/0x60
    [<000000009b0be238>] do_syscall_64+0x96/0xf8
    [<000000006ff466ad>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

