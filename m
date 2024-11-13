Return-Path: <linux-fsdevel+bounces-34688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4919C7B40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E97A1F2855B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF4820515C;
	Wed, 13 Nov 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imPsjuW2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF5200C90;
	Wed, 13 Nov 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522824; cv=none; b=UTmqaQhX15GodRZhysBcCRoZ7qkymTKiAlQH6ccLHCHfbrwfMtiCvqeUmm8k8YxUq27a+Q0c7BzBwUDbe9RPB64ChF9i8aoeTCGvPSiq29kDHo2RDvh6XVc3zwML1IV7NkTBFUrrff8WQ9K1eUSuL+6rT1eye3HNl+ZsC/6ohWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522824; c=relaxed/simple;
	bh=epwvJnoTFUIhrGRAE1h/sE9a1tEfCBtKLtMp0kEUtUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOhgFkGV9n/ZT6JlVtOfOM03W8tWVlwMqalZx2qb9lTKqc5r81jmNBHUtN9NmH/VpeQskUo1xxkdfsviVi0UdYAj0aHq7GtWXYdyooL1eDpn3ubDdOqDjxzKk4mtaMj6PtsyQVXfU3qaEoN7Yy95nge/LD5wz+gsd5+/T4lsiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imPsjuW2; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460da5a39fdso51725041cf.1;
        Wed, 13 Nov 2024 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731522822; x=1732127622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEAYPbzxEEGvecCJCUytCkqZZ5wbRQKBjqWUJAfVZRA=;
        b=imPsjuW25P2elilN70Xm6nsOg6Fj9YPV1YhTqkgKWMa4D3dQjG132unkCVXGtspAm0
         lpA2tDIf1MT4VZpdRDXMfkVOEKC/VqHiTKvfkzgtmSpntuOJBauWSlkucqaQdZVTF377
         uWGUlHyOUbGE1VB/Vw/VNKQXtuXH/SkAPZPtTOSonyGLqG/NKScR0wO+rhd4C/9zVDSh
         ule+cyfyYbxPTTBNcyjBqL6ewuV8VPaLzODhqPjydfZFi9V4HlH3H4SjP8rt3p3eMFsK
         GN4pyJcnKWfq0ykzkjyjOUKuhG5qE5YEOb+5wpUvefAdYFwH5GH1hoPnSdlOdmz/gdeA
         7tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731522822; x=1732127622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEAYPbzxEEGvecCJCUytCkqZZ5wbRQKBjqWUJAfVZRA=;
        b=gOjuoXeNcIPDGZRPlC0rIJPuVeCJ7Qb5Uyz5gkpz+/csLsiXNzTpm7rWECJCrAIYzD
         Udk8OkEb2L+JDBtKUMDaAznG3Ti1+zI1gQcLu/bOU85Wpncnk8LceWcjzITXGOXFzEUE
         JugiZPfifkf5u3UMokN+9dCAbTuqRGeX/xC8uY/isM7wF1BqNRZyBP6QmaRcOxnYNDTa
         T1UtL1kS4n1zqQTaw/i5ktNyyTAxkNiPglNAasPNzU9fcRXLh31vqYxaE4+YoUnFXqI7
         rd5zQCn1OeG71hdlom7viob2uqubfRY8/PzIFpFCYxDb6ETaT3c75BatQsZLO1y8a87T
         /OSA==
X-Forwarded-Encrypted: i=1; AJvYcCU+uZeAAs8fgC5U1ZptWDRUN87StzWNS1Xuy/PdlOYVffY/dhTj6MdrJL3MzYkBF2cBdqZ4W4xBJl25@vger.kernel.org, AJvYcCUjhLXLl4FlOlKrRSTEMvs3Cd/lraSQaLlUfyeBZB2NRl8f9gBVGG+DriLa8u8+DdTEwn4+3ZziCOihtA==@vger.kernel.org, AJvYcCVCxd9/yXLySMJYmrLyFJIsv2jliEWRnzmTFMLoAgMDj+1uNi9aDinanmQCmse1HGnQmwJ+FAo2yYR7v+o2Ww==@vger.kernel.org, AJvYcCVkIJ71NVGN2E30qRwJKe3wMWwmynrFaL3T7oN/sCoepoGczWivxI3ewZrDqkdgPvB5R+9wHCYZ3R6N9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwfAOPJU1qrZb9TZkNC7LckmmwzEJRJsaej8XyT7xxJpfntdA
	1VD1PPYw0yMvRqdkaKdoMbXWZ6/tA/0ybsjlrtrIWIvW0X89mq4AxOWbFm6HJqMm7gc9gbHz0v4
	KMO+HPyEVpLfoOX962gQP8WjPa90=
X-Google-Smtp-Source: AGHT+IFPeK8LsWBd11UIJ1HMjFwTxuHxrQfNEAnlG5VRDPByzvKN/slVc8pIz4HMqf/6Jwtq6PY//EGtUUqdQ2qDnfs=
X-Received: by 2002:a05:622a:1191:b0:458:34df:1e6a with SMTP id
 d75a77b69052e-46309421dedmr307570801cf.48.1731522821788; Wed, 13 Nov 2024
 10:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <44afe46517b379b6b998a35ba99dd2e1f55a2c7d.1731433903.git.josef@toxicpanda.com>
In-Reply-To: <44afe46517b379b6b998a35ba99dd2e1f55a2c7d.1731433903.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 19:33:30 +0100
Message-ID: <CAOQ4uxhj7tQ1E4TmMbjodfiJtuosPdGp4B9WZQ2Qc76zs=g6sg@mail.gmail.com>
Subject: Re: [PATCH v7 12/18] fanotify: add a helper to check for pre content events
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, torvalds@linux-foundation.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:56=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> We want to emit events during page fault, and calling into fanotify
> could be expensive, so add a helper to allow us to skip calling into
> fanotify from page fault.  This will also be used to disable readahead
> for content watched files which will be handled in a subsequent patch.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/notify/fsnotify.c             | 12 ++++++++++++
>  include/linux/fsnotify_backend.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index cab5a1a16e57..17047c44cf91 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -203,6 +203,18 @@ static inline bool fsnotify_object_watched(struct in=
ode *inode, __u32 mnt_mask,
>         return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
>  }
>
> +#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> +bool fsnotify_file_object_watched(struct file *file, __u32 mask)
> +{
> +       struct inode *inode =3D file_inode(file);
> +       __u32 mnt_mask =3D real_mount(file->f_path.mnt)->mnt_fsnotify_mas=
k;
> +
> +       return fsnotify_object_watched(inode, mnt_mask, mask);
> +}
> +EXPORT_SYMBOL_GPL(fsnotify_file_object_watched);
> +#endif
> +

FYI, I was going to use this helper to set the FMODE_ flags, but
I noticed that it is missing the check for parent watching pre content
events.

The other user of fsnotify_object_watched(), __fsnotify_parent()
explicitly checks the fsnotify_inode_watches_children() mask.

I will need to add this.

Thanks,
Amir.

