Return-Path: <linux-fsdevel+bounces-52418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD37AE3244
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7227A502C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AD62153E1;
	Sun, 22 Jun 2025 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="eReb8S/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6F2EAE5
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626890; cv=none; b=q8h5xIYgJfTnBwiBxd6Vq9gRYsR0Tknxk/8pvjDcQ7Sjdu17yuRFeZkibEna7Lf0AEQkNNZOkJx22HhCN7m58pWIdRs6IIyVo4vjmYPQPow4Z9qzoW4v2qQfeWjhba9lrTs3O7+VAX7C/0yut3DqGM4UZxfiv5aTkivbzNNA6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626890; c=relaxed/simple;
	bh=9yL2YJ8WzXy0y5MM4eijt2rBPcDKSBpSqKBJOu02PE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGY+3Sn2UhkDA5U/wLgA0r4DY37bd4q3p8JiPufRGmghOApDQDfeCGGgqqN7G3R7ccO1jNJAkUesAVkbequkz514Yj7udeKyb5Qwyas0xC+Nh+y0JhyZkzmgejzBObsnHYTAEluQXKVUyPymgoBE5sXBqfk+8RSsHbUeh9wEFD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=eReb8S/g; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b9eb2299so3960803e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750626887; x=1751231687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sFORI0i4tsBz1I+MDIYpr3mLqD9N5KKXSvBmgZjLWuY=;
        b=eReb8S/geVyvtTN6A9GoYEhO3aEGxgaHF/tijbtD2bRYx0OKCOqMB/OFMi56dhRNsk
         rUuSgvQaLfamS6fMFDP4aYTsnsiX7mDD5kC0/CzM9sbXfHpCMG9htZVqmNoPtxCphMv9
         qVZE0fLCqxiCd+0CJHT1tVjqj0ap2xly+01Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750626887; x=1751231687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFORI0i4tsBz1I+MDIYpr3mLqD9N5KKXSvBmgZjLWuY=;
        b=h/CpN8ZMPFzlQ6i9CsooErsnyGB1Tp7dYZN3Qs489UMFCi8W4div6dSdJyPJSdVTQX
         bqxFKJUijj2b54SPyH3S5OXFC7mvDXO9PdDN+AQkmQV0vErjR2jrBGi5Y5EUD04ncM9p
         cagjrlhgqD4IpgxcCKz/Zc18951Yiwq5hs1H/tOfy7mU/X9p1NefzuqsRyBfUkfqMLWK
         Le01bHZPIYNHzfsJ5h8OInjbnzh3vs2dswHnZl+HfQ84FqdCYNUEYlEMsYz/Xialx3g9
         45SkgAUO3Ack0JH1cQcaH1xaQX41zasj0gSc1Om8rHZ/lwMO5F0pkrJM7zyOcVuU/7Lx
         kOsA==
X-Gm-Message-State: AOJu0YwKrm1qaUoK4x9utVsETemvs0pXRY8NxJyubxge01LVUEPn1mgH
	MCiUHVb4VeQMxRsVe6gdp8JqXUP9ZjSsU/yIwMI3+3sHO8ypc9lxTLPur02bnZJ/pfbb9DHC2PJ
	dXStWMFaNNnywP+EKdVmcYE/IqM6QKiCnUMTKJ2BZZKapldihfwlNd65vCw==
X-Gm-Gg: ASbGncu/waT4//b8WrA5e8aysBzlhxwr/lVbaTTsl+6S8MRtFSzktuIyr6yVfM4qLs5
	mjvN4YQk9YjJZ4Upy2+o4wiUO5289qXe3FQNPXGDUE2msMCYUHiq4lxXCx5R+3BQlOT3kmbL02L
	N+w5C+zmEbVxQcZgEXaYD5UytxhXN3spz/0yjLOn8xLWV1
X-Google-Smtp-Source: AGHT+IF0sXKCamY1ZhuK7nI2Apxnq7b+lH9nTaXX5/bc1O1ip++HVbxL8Pq8AKqy+m3Oi06bHTLtBLck2p+GJ1c7edc=
X-Received: by 2002:a05:6512:2393:b0:553:252b:e477 with SMTP id
 2adb3069b0e04-553e4fd73d3mr2674995e87.4.1750626886538; Sun, 22 Jun 2025
 14:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-10-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-10-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:14:35 +0200
X-Gm-Features: Ac12FXw9q02NBpdUJ4EJ9--BNUX4qa0m_ctThelSqfadNOF7LquDBzQdUdFz3Ws
Message-ID: <CAJqdLrrcSD5LXo3PSQhxOhh68Nz=jKni8u7=2c7ckWXYjCKxGQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] libfs: prepare to allow for non-immutable pidfd inodes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Allow for S_IMMUTABLE to be stripped so that we can support xattrs.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/libfs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 997d3a363ce6..c5b520df9032 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -2162,7 +2162,6 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
>
>         /* Notice when this is changed. */
>         WARN_ON_ONCE(!S_ISREG(inode->i_mode));
> -       WARN_ON_ONCE(!IS_IMMUTABLE(inode));
>
>         dentry = d_alloc_anon(sb);
>         if (!dentry) {
>
> --
> 2.47.2
>

