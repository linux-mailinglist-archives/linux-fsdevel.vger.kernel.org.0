Return-Path: <linux-fsdevel+bounces-25522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A294D0E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 15:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354B01C21264
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84A2194AF4;
	Fri,  9 Aug 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICb702YT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4B194C65;
	Fri,  9 Aug 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209108; cv=none; b=YZwUkafFDzXZk/7s7XQAbeTIDpZnQyZMsJvW5x8SPqVU1DYFLn4HRcVqmm4aRxiFy4QwBEpZYGggAmIakBByi0tvyu3icypA9K7m6GpH4d8Li1aq4zr6+tUqvZlZUUQYIRtjE4pOys2+dHrpkNp/vRX8UeGXoH5LBY3q2AdJhJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209108; c=relaxed/simple;
	bh=jOXOaRYT4L48wJhp4miCKXU2dG1qcgRd2+ZqF+ia1M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cp37lg15M5nhoV6sOetonmG8TFHiwrmEuR6KCnKCwCzHDNIvslB+HUsLdk6E135TcK8a+BG+m0nJYHxmOm5irBujEhz2d+GfK+8qcBsA1YU7qdBqVhso56qU6VByGbPbjQKwidrcDMs6QZi2BfiiuJKDZD81x/9zx/yC8P+g7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICb702YT; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3daf0e73a5bso1577415b6e.0;
        Fri, 09 Aug 2024 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723209106; x=1723813906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLy+w1i8+q3J1zYjzqllPpeRDTQRavcNaGacNPXrk+g=;
        b=ICb702YTG5tmKI1SZimZriqs6eEtC2lJcfGhjB+wxDzKcIGLFjgBTAHHm3pz1lkEPu
         9QVV2Cj3qFIUW+MlS5WOCwlFAFACNvRBHOJl2bdgXjrVLnlZ7Re8UfT0ptAgOKmWR9vX
         WpX7Yxpd604BAOclncV34nL3ngDA6N7w1eU97ilsVIjZ+MFz72i1hZKcWom0wGxPf/fh
         uqkK/eDMPhLXwQS7RTyVRjQbUKOVQceKN9puzT0KEidlI6QDjMJ+dNrn7RgO/4hfyYWZ
         If+vD+vij+85lzWM26sI20BEaycNLcYyn405nHUxidGqwgx+3uTBj0Czon7OcQaOw6Cg
         Z+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209106; x=1723813906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLy+w1i8+q3J1zYjzqllPpeRDTQRavcNaGacNPXrk+g=;
        b=T9O0+QsvHVFD9JKySkDn+5TbB3xB51x6a4DHN7F2zcHLph+CMp+Ol6NZkN1cKhahRZ
         ygzIAoeZOiJ8L+Zq8wrk1jFJmvHLN+v8C7ysoo1aPtgekgtwclI8QA1Y3Bpc7H6KHsig
         MDzUitlhJw2EgPpRjExj25wFq/iHvIN9e683OMQ5pUmdcaGGOhZF3PHR5PqplkuvrLUz
         CAntiNEGmnz4KphyAFJqaXN/3ibmYSMyr98HQbMYHzh5xAfyuQZphvPE3PLHEjwlAHgg
         yQvc9/0IdJMtPbVrcYdNtFLGdFiAWkRwMyRVC07aoSdq1AhrnNNZmyKA1z7yVqi3Tdje
         Qyog==
X-Forwarded-Encrypted: i=1; AJvYcCVQMcGxLCy3cgPBijkSrwkrOon+kR6tOjW9GP1OsS7Atwg95TrhNXuSR+4cgrmOBJNFnx6WDm8Bjiw/mrmSq4tyZpuEVfqLnP74a/qxiaENmFdqGoc2qIRCJdvjYUq7YIGvwWkXQBq1d7s4cq00F3bJtmx7nXekVp0PRwfzyV759DyWKdCzWhN8
X-Gm-Message-State: AOJu0Yx658do7FpskGTjMRVli9Dj/OdzEf2DNA82IIQTDm60GmfstfLV
	5VM/YOT+HaNen24fzfHkbeT1dCgmna4iJR4AWZp0O3dSAsrUAeaxi6U0XEeIN+wFHK7vqLeviEG
	ug9JYNU7gVyh/mJ23LMUDKpeK+xk=
X-Google-Smtp-Source: AGHT+IFh+5SDIMKVPJMEfKkArRSdLe+gdR/fEMyRksrtueer4tYEJVyB95v8DzaJtFGvzdhBu6HNqGhWwHIjD6xVK2o=
X-Received: by 2002:a54:4e93:0:b0:3db:50d9:c6ec with SMTP id
 5614622812f47-3dc416f10fbmr1292288b6e.49.1723209105655; Fri, 09 Aug 2024
 06:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723144881.git.josef@toxicpanda.com> <bce66af61dd98d4f81032b97c73dce09658ae02d.1723144881.git.josef@toxicpanda.com>
In-Reply-To: <bce66af61dd98d4f81032b97c73dce09658ae02d.1723144881.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Aug 2024 15:11:34 +0200
Message-ID: <CAOQ4uxiWJ60Srtep4FiDP_hUd8WU5Mn1kq-dxRz4BpyMc40J2g@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] bcachefs: add pre-content fsnotify hook to fault
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:28=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> bcachefs has its own locking around filemap_fault, so we have to make
> sure we do the fsnotify hook before the locking.  Add the check to emit
> the event before the locking and return VM_FAULT_RETRY to retrigger the
> fault once the event has been emitted.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/bcachefs/fs-io-pagecache.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.=
c
> index a9cc5cad9cc9..359856df52d4 100644
> --- a/fs/bcachefs/fs-io-pagecache.c
> +++ b/fs/bcachefs/fs-io-pagecache.c
> @@ -562,6 +562,7 @@ void bch2_set_folio_dirty(struct bch_fs *c,
>  vm_fault_t bch2_page_fault(struct vm_fault *vmf)
>  {
>         struct file *file =3D vmf->vma->vm_file;
> +       struct file *fpin =3D NULL;
>         struct address_space *mapping =3D file->f_mapping;
>         struct address_space *fdm =3D faults_disabled_mapping();
>         struct bch_inode_info *inode =3D file_bch_inode(file);
> @@ -570,6 +571,18 @@ vm_fault_t bch2_page_fault(struct vm_fault *vmf)
>         if (fdm =3D=3D mapping)
>                 return VM_FAULT_SIGBUS;
>
> +       ret =3D filemap_maybe_emit_fsnotify_event(vmf, &fpin);
> +       if (unlikely(ret)) {
> +               if (fpin) {
> +                       fput(fpin);
> +                       ret |=3D VM_FAULT_RETRy;

Typo RETRy

> +               }
> +               return ret;
> +       } else if (fpin) {
> +               fput(fpin);
> +               return VM_FAULT_RETRY;
> +       }
> +

This chunk is almost duplicate in all call sites in filesystems.
Could it maybe be enclosed in a helper.
It is bad enough that we have to spray those in filesystem code,
so at least give the copy&paste errors to the bare minimum?

Thanks,
Amir.

