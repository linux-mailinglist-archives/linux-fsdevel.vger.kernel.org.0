Return-Path: <linux-fsdevel+bounces-34476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D8D9C5C8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F35A1F237AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11272038B6;
	Tue, 12 Nov 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clL0Xkn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B202003D5;
	Tue, 12 Nov 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426995; cv=none; b=DQHUzYwKGS+rtykiUfAcmxZ+THSpAohbCLwVvu4JiRgqrVrBGmEusKkh7MH+zxh/usXzSijdG+leK1V4O8G5w3qSkWBqaZPxRICHzjZD8c8hK4thlovozRmrxfVwRt2FjDuPvaWloM6JMz0XXm3QfP50yRzoBu22mbwv5a9qdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426995; c=relaxed/simple;
	bh=89Cz8hDnIDcexn3u1F3fL0Sas85eVLi4uuuYUJ9dnJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jujw4llwNqm5uaLXOjksCBCHUzirMeBWjhUne6cxiwZui9Rhbi51HOAbXJAhAuQWizYVM3nM4zTiHd+skqkSG79qMQe2q0arGlQX71rW4PYNmPMFUNBHowHCGIkbqUiK5hvIk1x5THjbKPJclbq907g5LRUuRkWka3fr3hLSVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clL0Xkn+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460a23ad00eso57239361cf.0;
        Tue, 12 Nov 2024 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731426992; x=1732031792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c6Jzp6I8iJr+q2ssZkuQOaV1YsODxTk+KgFq2+saP8=;
        b=clL0Xkn+cuLXoPWV0ox8UQjl+iVbu/TZyIqlZtl0vCOtXVPOwa9nYtL8FdKgAImo9H
         wLadxmVNx5p6n9fWowchbv9bIXgBoH+lYVcJGqTx2lzZcReVsrYxEr+CoN/SkM0Z/DDk
         H5rFgUPKuiV+ZlvJ2joNBW+Bm86wG+/TwNFLQ+8visHJxuEuCKQ99WJfwtGS/6oibhK/
         BhFxl7C7a/BNTGnp364A1SHveW66YRKXhXVPA1uiEXF+D0DsCukz7QJMl0UDP86x73sm
         qGnvFBjwLlEckWSopyLgbwfdNL+iTjcu4ysHKijPnfQeMdeKb17g38mG1p+ZppSIvYLI
         QyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731426992; x=1732031792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4c6Jzp6I8iJr+q2ssZkuQOaV1YsODxTk+KgFq2+saP8=;
        b=FYYiNPE4LU7AS1/HnxFj7HlWf7D7oI+XRvwotmOUr8XR1aAH07mlwj4qfTUPjFPlwP
         jQ+ETtQS0Op+rjdXcJFvYXaqSq4EUMXKQ6ZN/I+jzvGFVg9WSlRmcO4aPy7ukm00L0a/
         UWGdXX7XzM2XUA/Gq/Mtyv0S55VF7lLlXWhPD+MitT86eJhRV7UvnNIqw0vF7O/lckUn
         GvZNy0QXI1ib9TY0UGSCuZB6aWQrxWmtmND/qXYe2JN9RdUzGf5OYXntKgW8rKMwEWku
         J7jryT7s5dmTM0q5oZbsdBzvcpy/5/aOchD9w1SNA+F4etr0B1HnUJ+4DnJ5iEuOwxSE
         mRzw==
X-Forwarded-Encrypted: i=1; AJvYcCUoKmj4c1trYOpjpPtSKVFMtItBsTmHnkAOEGOsegCFU5C4ZHHe/MMP7OPybKhRiBTTqIcU90W3FN1tVnM5@vger.kernel.org
X-Gm-Message-State: AOJu0YxDiA4XRU4ToEwasEXozDIGnegMKgKmFl9oMsZesC+/POU6Dg+/
	wE+cmRPDoEEvPiU2uKP7NTVJ0cwQzcpUHdEl3gM3IYEl22URqPTpIiiSVbhZShXozvj49xW5fSf
	SnZOhtT/dJ295g+I+Y1AaHbvVmI0=
X-Google-Smtp-Source: AGHT+IENfGvbIkArwXHI4JqBeWhQis6oDVSKsu36X37iI8nb9GDSHg/lzYvBrN0QkrhAvA1pzyy7neruVd3QIb1+0LA=
X-Received: by 2002:ac8:690e:0:b0:461:1679:9062 with SMTP id
 d75a77b69052e-46309a6de7emr347673041cf.9.1731426992493; Tue, 12 Nov 2024
 07:56:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101135452.19359-1-erin.shepherd@e43.eu> <20241101135452.19359-2-erin.shepherd@e43.eu>
In-Reply-To: <20241101135452.19359-2-erin.shepherd@e43.eu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Nov 2024 16:56:20 +0100
Message-ID: <CAOQ4uxjrR9is3E4RqMa3u=Gd-1NMZuBjv+GVJ-eMQiP-Mer9GA@mail.gmail.com>
Subject: Re: [PATCH 1/4] pseudofs: add support for export_ops
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, paul@paul-moore.com, bluca@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 2:55=E2=80=AFPM Erin Shepherd <erin.shepherd@e43.eu>=
 wrote:
>
> Pseudo-filesystems might reasonably wish to implement the export ops
> (particularly for name_to_handle_at/open_by_handle_at); plumb this
> through pseudo_fs_context
>
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/libfs.c                | 1 +
>  include/linux/pseudo_fs.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 46966fd8bcf9..698a2ddfd0cb 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -669,6 +669,7 @@ static int pseudo_fs_fill_super(struct super_block *s=
, struct fs_context *fc)
>         s->s_blocksize_bits =3D PAGE_SHIFT;
>         s->s_magic =3D ctx->magic;
>         s->s_op =3D ctx->ops ?: &simple_super_operations;
> +       s->s_export_op =3D ctx->eops;
>         s->s_xattr =3D ctx->xattr;
>         s->s_time_gran =3D 1;
>         root =3D new_inode(s);
> diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
> index 730f77381d55..2503f7625d65 100644
> --- a/include/linux/pseudo_fs.h
> +++ b/include/linux/pseudo_fs.h
> @@ -5,6 +5,7 @@
>
>  struct pseudo_fs_context {
>         const struct super_operations *ops;
> +       const struct export_operations *eops;
>         const struct xattr_handler * const *xattr;
>         const struct dentry_operations *dops;
>         unsigned long magic;
> --
> 2.46.1
>
>

