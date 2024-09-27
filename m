Return-Path: <linux-fsdevel+bounces-30290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C42988C89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 00:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902651C20BC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5861B3F3B;
	Fri, 27 Sep 2024 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxL44+WE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A82183CB6
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727476969; cv=none; b=EhuclQxp+KKR41e4VtLmKLVd5OT0t2UWd7R9eWnUhGkSj9B1pjBbTQ3jtQzal4Xjt/ZWKWJjLcBNoDQnKEWisr/T+kOmfFn+0s55CnE0k/qYYqLxymmnvsXWvIEmsRBG33esHjgJSDXwXnSyCYwoAt2XoUI/4kXsf9Wgb+V4RQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727476969; c=relaxed/simple;
	bh=X01RwWqyrXPlc2NXE5HJWIgK7dddJpcevLpDrL3/GXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2ztWMLdoyj08C0x02sXXtVnz3TrgVMTITcT3OsiOHZ8Mrjx0qORGt7wOlx4MeA29zIOG31ZctRPdGpXWVdsMnLR27Nz/LnJHYa4IpFYf7KeyOp70ZE2EKS061ovlcX0Pdm8SAZxkQzS7sxenIFlb3GTjQ5jJEl1Q0ZGrWMpCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxL44+WE; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-45812fdcd0aso32700121cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727476967; x=1728081767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r158kVwsVSjXSrr1aLw8oPzZVQbWlG3IxleedI9aIY=;
        b=fxL44+WEv00HaeligLP4x653XwqNl4fXMC6DXP/NQ7xyT5OsAjosa2fJCH3cXC9Fum
         YbnBQLoX+ZnqEaOCggB7nZJiE2sMwmD1TxxBQbrt4dsC8ahKy1RtAzmc1NxN0/lWjusP
         ibQ3QL1q5J6L9IegfH/0t5DM3fgCoW/w7lNt+8rVNQ0WsGTq28rNu8XZfa8wgGML6WGO
         LrLJXhzx0kEPzS0RD8ZsZYlZPVwLPtbDR5H+1rG2yWsh8lYKcxAce1022+OzCm5lZVLX
         laAaIYPH/Nv7drkLr40Sto4BY2ju+HgO9aenh87r/iYiTN/H7XoTUMDYAYZ7eWIRlzlB
         R8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727476967; x=1728081767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8r158kVwsVSjXSrr1aLw8oPzZVQbWlG3IxleedI9aIY=;
        b=Z+msKOR3RVU3n6K7j9q9rUjs7pm5OQFZSDqb6DW+PYF69lY+lIfLrT36RrzkM1nO0L
         KwNF4IESMPmCx6yONo/8Jy24Ytf1xjNsbTvknYmZHIlML+KmyVTDh7WuNieyT+pD1Ok8
         ndF2QZNO8SJby7pmmmcGeC4xU4N4BURZCNomv0vm7vYpeBeIssfzlHXAebZUw3v7mHRp
         hNBkAIoFKNbb0t9C32UK/tcKciNz8iTHhkzDj7XQUqMINHyBdoZJwzQZvDlC2p/6nYKc
         ZdaRCHjNnvbKexMxSus+YNPJsfUxn9t7qY9qxvi8J7uwYf3nLVyqpknFH0xNksOB/ENC
         xdQw==
X-Gm-Message-State: AOJu0Yw0qdlkX1A3YH8JJSwKbv1H+t8O9CKuEuwOiSesOaxGhCK0XLhP
	mLA3rUcHaw0UgxUCScHHb+UKScpB5XtqWz1ojZoRlWHJfIxTvaKaAW2tofngBvudCtm7/Ita/rd
	wgxrmUhh8dJyPZVO3bZTwGgl/qaLjvTRC
X-Google-Smtp-Source: AGHT+IGCBDYNi5JInOSKDbRlTX5vwPSBcgec2tBpm6KHzc8nlvx1Ft40pEbAgytFx8ZL5zvfpXI7AUAJc1/mfrTlNkU=
X-Received: by 2002:a05:622a:1885:b0:458:3162:2262 with SMTP id
 d75a77b69052e-45c94955e2fmr156946531cf.4.1727476967067; Fri, 27 Sep 2024
 15:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727469663.git.josef@toxicpanda.com> <1cb4f72d82dce708ca20ff90be622ac302ac2653.1727469663.git.josef@toxicpanda.com>
In-Reply-To: <1cb4f72d82dce708ca20ff90be622ac302ac2653.1727469663.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Sep 2024 15:42:36 -0700
Message-ID: <CAJnrk1Ze_cjmwAa2XU5+sHdegUadupT_3AjZivoC6cvTRzWELg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] fuse: convert fuse_page_mkwrite to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Convert this to grab the folio directly, and update all the helpers to
> use the folio related functions.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/file.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 1f7fe5416139..c8a5fa579615 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -483,6 +483,16 @@ static void fuse_wait_on_page_writeback(struct inode=
 *inode, pgoff_t index)
>         wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index))=
;
>  }
>
> +static void fuse_wait_on_folio_writeback(struct inode *inode,
> +                                        struct folio *folio)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       pgoff_t last =3D folio_next_index(folio) - 1;
> +
> +       wait_event(fi->page_waitq,
> +                  !fuse_range_is_writeback(inode, folio_index(folio), la=
st));
> +}
> +
>  /*
>   * Wait for all pending writepages on the inode to finish.
>   *
> @@ -2527,17 +2537,17 @@ static void fuse_vma_close(struct vm_area_struct =
*vma)
>   */
>  static vm_fault_t fuse_page_mkwrite(struct vm_fault *vmf)
>  {
> -       struct page *page =3D vmf->page;
> +       struct folio *folio =3D page_folio(vmf->page);
>         struct inode *inode =3D file_inode(vmf->vma->vm_file);
>
>         file_update_time(vmf->vma->vm_file);
> -       lock_page(page);
> -       if (page->mapping !=3D inode->i_mapping) {
> -               unlock_page(page);
> +       folio_lock(folio);
> +       if (folio->mapping !=3D inode->i_mapping) {
> +               folio_unlock(folio);
>                 return VM_FAULT_NOPAGE;
>         }
>
> -       fuse_wait_on_page_writeback(inode, page->index);
> +       fuse_wait_on_folio_writeback(inode, folio);
>         return VM_FAULT_LOCKED;
>  }
>
> --
> 2.43.0
>
>

