Return-Path: <linux-fsdevel+bounces-52409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F122AE31FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 22:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4824188B1DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 20:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220581E9B0B;
	Sun, 22 Jun 2025 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="RlIgVsGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6D1DDA1B
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750624688; cv=none; b=VuhJ1zVIUp+sgDuk+jT7xRzQsdAQSHhJMkDgyrxU5MZiliQYcexKzqjz+LRo40Tbdp0x7HwmU+wJ5h8U0GF8xU/Nv6QKWn0PsuJSu0ztyoHCgsBG1ylvYPLxXWMRSpvBlApCQ22Y2Txcv5Rir0wdraz32vgO6JU8h5L5OjPonrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750624688; c=relaxed/simple;
	bh=BBA9UuahBRpV5nTuSLm3UJTVNynA4M53nvn6oKyc5ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pK7U+N3SQU4PtvupYHxkr78NGC3UO4yePcz1rg59AwAYgdtMj3XBnoApDENluTNI3y23qbC17byGum6fulwHRNwSLUq/WgtTDA8KOqctvB+4NWON4Rv+kSpUuETGaw5x9NxRIVLO6i50IBLRfqpiPbitIuEjwI+tPXfYBqhGnyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=RlIgVsGP; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-310447fe59aso43503281fa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750624684; x=1751229484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HxOy7NICeyzY/wOiStoerxwVVM8g7PCb0jaH1ym46vA=;
        b=RlIgVsGPIsi5PSeskAu38tvxFe2k0aQaSkMr/6juK8JorJsuJDssHd/qMnszef5aGI
         sHUzNgJ7vjCAHholxh3qGBFMiCmCJVemUA9LAqUAXmr/9rIo8xAVfASHH/p+n5EIIdTT
         YzYfkudiAs9gvL+M/0LihFSUhQVwlF6bfLEWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750624684; x=1751229484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxOy7NICeyzY/wOiStoerxwVVM8g7PCb0jaH1ym46vA=;
        b=V7Th5B3VNXxx36LMWlUEq/0i1toiQXLNAybOzaahskgzjogxqclJ+0zqGK3QLOGDBO
         3jqod85309f9F4I1eVTLIz6rRulairRcEMMk+H94E7tM54+Pf1SAkM9AXmrava6o8686
         atD5PRjWjzDy9ODjJbkte1pdYPOi/RO+2032PUMS9RDqjg5C5sxGydJlX2CAvNUC4VL0
         HOMAkxS3i0qSO+BYPKKXsUuSsJA4SXUnQrCcgcGS1VIdy1ZfracqiuxUMBxbLrSyziIu
         269uurvmLR1mcmk+a/NT0s9OXBT+aTJwTY30WWcXci2UBZLYe8XZm2TN+p04LHxsJhGN
         HmcA==
X-Gm-Message-State: AOJu0YwnXg2VfWqTlsUvPYl9pQzCf1Www+SOVK7mRlWODrfTlNRNNyaO
	bOX66OL8YzHbnuTp/Q5sR8hN4wUpmylgkXzfgwtuKuojfOwg0YNy5WSIq22GxyeR3EnHc5eQANk
	CLyWN5+0n4N6zPjSNGUmiIQ2TAF+hqN6QvYrz3IU3dQ==
X-Gm-Gg: ASbGncs2ezp/gWIuVkrq3gqCB77sJ7bAQSfxLIGxzZq3fOc+/pDBZ0+PW0ydP+TaM8L
	HJgusH/iYC6jWfsJHXIfu55dQhvDiwgp9ARFqGUhtSwZdeC6Ixk5HDjZ7HXOzQWGboXhSfUlqxT
	MlgcWZNSML9xz8Dgz7etI/1a6Poclww//+OlRQzt4xpk+2
X-Google-Smtp-Source: AGHT+IHBR/mqPk9zS6oQf9EAhMuHW85BVOFlR/n66gufs26qjplPGdKY9hPLI0/99+8Lijac8yqUWiU50yZfG05u57c=
X-Received: by 2002:a05:6512:ba9:b0:553:aadf:b0c4 with SMTP id
 2adb3069b0e04-553e3b9a916mr3541137e87.11.1750624684146; Sun, 22 Jun 2025
 13:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-1-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-1-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 22:37:52 +0200
X-Gm-Features: Ac12FXwSxsN8wFve5N5JJ6Teo30SRLET7tttXH1IQXT90v7a9W7E8QhroJhnu58
Message-ID: <CAJqdLrpikOQzBLDNw1=sQ7teTgbj6AbsrnUER_n8djY+evw7mA@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] pidfs: raise SB_I_NODEV and SB_I_NOEXEC
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:53 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Similar to commit 1ed95281c0c7 ("anon_inode: raise SB_I_NODEV and SB_I_NOEXEC"):
> it shouldn't be possible to execute pidfds via
> execveat(fd_anon_inode, "", NULL, NULL, AT_EMPTY_PATH)
> so raise SB_I_NOEXEC so that no one gets any creative ideas.
>
> Also raise SB_I_NODEV as we don't expect or support any devices on pidfs.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c1f0a067be40..ff2560b34ed1 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -891,6 +891,8 @@ static int pidfs_init_fs_context(struct fs_context *fc)
>         if (!ctx)
>                 return -ENOMEM;
>
> +       fc->s_iflags |= SB_I_NOEXEC;
> +       fc->s_iflags |= SB_I_NODEV;
>         ctx->ops = &pidfs_sops;
>         ctx->eops = &pidfs_export_operations;
>         ctx->dops = &pidfs_dentry_operations;
>
> --
> 2.47.2
>

