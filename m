Return-Path: <linux-fsdevel+bounces-52412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A700BAE320C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 22:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FC9188DAA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB091F3FC6;
	Sun, 22 Jun 2025 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="eNci0Zsj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38A19A
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750625066; cv=none; b=J9mZbSveCquN0cc9FLjgKdMkOLZntbyiqH8EFPyBR+AeJaVlQmgYYtuebB6g4vo0R3gqqzt9hHGrTj64LGWnBtFcCDC06R1FzSEv32vFeauVFaHChoPPX6EE90Mmuj0GVB6HoAMme5fTbemLg/FMMoYCKzfyDYgDHzxBmlS1Y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750625066; c=relaxed/simple;
	bh=GRGznCNRWgLaq3Kh0V5f3Lc8idyt+Hctom9BTCpbgnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+Rik2fnneIrRgLiipX1G+cFjNo9EMFjude0FgaYokenGFBfY2HfFmL4d9nCnbE5Q3/hWOwrAXpXOzxYBlg3rn1/Ah/Ny0FS/a79x/3uQ9GaS6IMH9cKWiKB5OksNAG5zp58Ud14A4vHDWATqKVFmRzkiYABkOxUH6QNdPF7N7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=eNci0Zsj; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b595891d2so31374901fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 13:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750625062; x=1751229862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bG7BS4BpKKlUUBUlkHQzyRadE+UsoGnx1MG65CsXAHY=;
        b=eNci0ZsjnFZk/7P4bNRvLxU1PX28glFv/GeoaqEYAuP1ia3LFuoOaoPaTrMfWbUgDD
         RkFNT7vNn1ko6F6qlXZ9++3upK7pp7lDiwZKKd7XHtz9nH29tThwnxf+KMbVscQBhvaF
         Iu4Qg6LuXNjk1O908tZmmlEBqQYzal6unww7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750625062; x=1751229862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bG7BS4BpKKlUUBUlkHQzyRadE+UsoGnx1MG65CsXAHY=;
        b=gCzvoIele2GhHxVlEa1t1qQ5aHWoZKY/qSXhRzGeiwjmM8ir0/dSTKDpRIezzKpu9D
         flXkr5FKxhqwUQq5ndC6ASeZWWLBAif6uyxrD9nKjzCX8KnmysWJcHzf4VKiSaf59yBE
         dGQ0qJruL/cy/ji5XykfvZxrE7tV2FH1bVm7td566+v7ACOSS6v3yGhMI5DYBfZp8dQs
         k0v9rD5Ql6T8UM7AxvA1Y2b6u45U1OOvepud4iG58tmPNKSkL8sWWc80MLm1foen8yRv
         TOft+sym4d/yPEkp44w2o+SnYD/vM9dI0yjogBIeeUB7XWPSGjHumZOtoxcBJW8gw8vm
         7c4w==
X-Gm-Message-State: AOJu0YxpcLNyERziEtksiGleUQw7yMz5m7mGlP//O0JUvGnPfSoq3i9+
	cXIYjX0joKz1BmA5pFRUXX1OxTG9KF3k7HBMmBufeETV3IxcCOhHXWF1XcYTM+1Hk2yAiMaR24E
	KE7KT4vp3J+6wp2coAx6K0RlQVttpowaxneujmT6kIg==
X-Gm-Gg: ASbGncszuCYJcQUJpUPlzJ804LwzTD6wqsr73YdYIdu22psN2ZZ9VXbOMZeQp7RVcIN
	57up0GEoF1kXG+xC0eEMIZN8Kkke5+zTGhuDqKqepcTfJ5s1pvWSIfiSWd+qeukjjcUHeFkGYws
	dqDCLTl7Ey33osZR9RyBMhVntyAi9WzCXZadVRk7bJ9NTX
X-Google-Smtp-Source: AGHT+IEsJekycJCiNyFKMWbiy7rHyxcYyM3ZXW4nsyZ7isu5LjgSDpz/u31yvkusqo6PDSxrPuC7VgRMFNySt+4nhDw=
X-Received: by 2002:a05:6512:3b9d:b0:553:390a:e1e3 with SMTP id
 2adb3069b0e04-553e3d0c648mr2818832e87.44.1750625062223; Sun, 22 Jun 2025
 13:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-4-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-4-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 22:44:11 +0200
X-Gm-Features: Ac12FXzXrP4fXGZFxx4QEZVrN9QhcrVyMS9rZ8UoyFe42macaPIDMZAZN8dz-qE
Message-ID: <CAJqdLrr_SmA+veW5bDjJMZzHw0LHacvTjcPLb6EreLCJru_8jQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] pidfs: move to anonymous struct
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:53 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Move the pidfs entries to an anonymous struct.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  include/linux/pid.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 453ae6d8a68d..00646a692dd4 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -52,14 +52,15 @@ struct upid {
>         struct pid_namespace *ns;
>  };
>
> -struct pid
> -{
> +struct pid {
>         refcount_t count;
>         unsigned int level;
>         spinlock_t lock;
> -       struct dentry *stashed;
> -       u64 ino;
> -       struct rb_node pidfs_node;
> +       struct {
> +               u64 ino;
> +               struct rb_node pidfs_node;
> +               struct dentry *stashed;
> +       };
>         /* lists of tasks that use this pid */
>         struct hlist_head tasks[PIDTYPE_MAX];
>         struct hlist_head inodes;
>
> --
> 2.47.2
>

