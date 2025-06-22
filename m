Return-Path: <linux-fsdevel+bounces-52422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900F3AE324F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF0C3A6992
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CAA1E1E16;
	Sun, 22 Jun 2025 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="ZSSy9LWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641D1EA80
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750627314; cv=none; b=QBI05rd1AKIbS42uGBCJC+tngXGXpwmRthct4eskNQdrENivyGXvW9gfRys9Bo1XMG1Pq6n66T86z0Rbt/xvJrP7UwVm5Ax77ffjSkOTXaoalFxpw8U/jqljwWvMYcbLeGf3ZoE9N7efZAkWJ8QR5YRCEkRS4c58uCsido2MkIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750627314; c=relaxed/simple;
	bh=lF6XDLyijx5SNHwZr2ZTJzY/E//6ORHHlFKA3AxpV8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzTfKc3rNuSW9sv1NXOSqbzC9qyRAnnZ+cUJP6150DU4Jxlu4kKNemkaMzDxAJIusrKIyn15sbY0BHqtPtF8zWAHUhPK0zyvAScYkyXxwav4jvK337hVvEXgx3ccLf0Tb90WKIsAbzeNKS7qyerIKlnIlOgslJurVHD86jP3Oxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=ZSSy9LWV; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso9774431fa.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750627311; x=1751232111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z5x2/hbpOJf5MRBL89mrP09U4Ur1Mg6lRyhNFHk8+SY=;
        b=ZSSy9LWV5u5WvqsD2mGu97iG8kebvvn/ai7+Uaeo2Lv4T7jp0WgyjSL5/CLNRFJ6IE
         L7W9kiKj4gN5hRHcCo6ZTXkptJva+AioIvwAHzscGDbwuVPRstC4et4U9omP0Ng6+6ek
         fwWr+VtzkXDMrrEBAD9UpenGRh4tlFc9I+xAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750627311; x=1751232111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5x2/hbpOJf5MRBL89mrP09U4Ur1Mg6lRyhNFHk8+SY=;
        b=UwAtWDVvNZupI4zCQDvnzZh3kgwrLITjHOEQwR/191K9IItt7w6TUS0k3L7cPzGqNt
         AEN03dVVGeHm6nCRxmqT9lSG751/u9ow8Fw4o9mHP9ELKcZ4Le3p4ZyktmK7Y5l0/5DJ
         rgXU1dZyJRu7yQgXuLmUXxAzIZi8ufqQN2U+uArrASsYKO7bnxAk/IlsywEF/Xojb/+v
         3vbDV4kWsllhXvHUWWT7E8JEbzX3dB4SQDVS6av3I9NOjUh49xAp21LP59B5HUyAJA3b
         UsG5zm+Ivoi3+lZjDpw6peYQL24l/W2qg/z6XefCqKGSKSwj3pME+H3dKv8F5i51GOcW
         xYOw==
X-Gm-Message-State: AOJu0YykGYx9HLLl+1JKoWZVuRNxqQfVGUB/APKzDYenhz1Ukf2JbRMG
	BgHhEfIuP7t9XvRnaQCFya41Iz3PpEcUGiwuAD2rgSjCtgFBmSncyL6srRzCt0ZftgxlKFDnkw1
	A1fvvJIWVIO9szMvrNszSw5aAxB2faCgG2uzB4D+YVw==
X-Gm-Gg: ASbGncuSVPu4+akamHaSAyQAIOwMJMUAR5cl7vzYV5k/VQkAN1yhcqZiDGKKPgL/JAb
	zcF2y7QQ7eOGwJmbek05mbdkl+m21UgeooEwpCIUt5jo/Q5asOoWfsMlSYWydOf0/V/GzOG9+M+
	rgae0hNLy5t7nXWlFtFOlNsTtGWxVe607m1+YXASITd1eT
X-Google-Smtp-Source: AGHT+IFvwhC8uR7qdOwgtHQ2GW+t8HnrH4tiGl30lINA9k5TSrchzH8ONRTQVANBr6ti/3oFfFU+Hdh8nYFAZKIoqlg=
X-Received: by 2002:a05:651c:3dc:b0:32b:7123:ec4c with SMTP id
 38308e7fff4ca-32b98faf268mr21440871fa.38.1750627311198; Sun, 22 Jun 2025
 14:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-14-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-14-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:21:40 +0200
X-Gm-Features: Ac12FXzRfDo5hz9LO1fs1-MJ_aH0QzzMjp9KOb0TsLpjzlUDc-HFX5A63Rkpdws
Message-ID: <CAJqdLrrjL0yka75UKwV_5mgoUqc6V7YJHF_wXr98S0=5ZjRgRw@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] selftests/pidfd: test extended attribute support
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Test that extended attributes are permanent.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/pidfd/pidfd_xattr_test.c | 35 ++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/tools/testing/selftests/pidfd/pidfd_xattr_test.c b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
> index 00d400ac515b..5cf7bb0e4bf2 100644
> --- a/tools/testing/selftests/pidfd/pidfd_xattr_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
> @@ -94,4 +94,39 @@ TEST_F(pidfs_xattr, set_get_list_xattr_multiple)
>         }
>  }
>
> +TEST_F(pidfs_xattr, set_get_list_xattr_persistent)
> +{
> +       int ret;
> +       char buf[32];
> +       char list[PATH_MAX] = {};
> +
> +       ret = fsetxattr(self->child_pidfd, "trusted.persistent", "persistent value", strlen("persistent value"), 0);
> +       ASSERT_EQ(ret, 0);
> +
> +       memset(buf, 0, sizeof(buf));
> +       ret = fgetxattr(self->child_pidfd, "trusted.persistent", buf, sizeof(buf));
> +       ASSERT_EQ(ret, strlen("persistent value"));
> +       ASSERT_EQ(strcmp(buf, "persistent value"), 0);
> +
> +       ret = flistxattr(self->child_pidfd, list, sizeof(list));
> +       ASSERT_GT(ret, 0);
> +       ASSERT_EQ(strcmp(list, "trusted.persistent"), 0)
> +
> +       ASSERT_EQ(close(self->child_pidfd), 0);
> +       self->child_pidfd = -EBADF;
> +       sleep(2);
> +
> +       self->child_pidfd = sys_pidfd_open(self->child_pid, 0);
> +       ASSERT_GE(self->child_pidfd, 0);
> +
> +       memset(buf, 0, sizeof(buf));
> +       ret = fgetxattr(self->child_pidfd, "trusted.persistent", buf, sizeof(buf));
> +       ASSERT_EQ(ret, strlen("persistent value"));
> +       ASSERT_EQ(strcmp(buf, "persistent value"), 0);
> +
> +       ret = flistxattr(self->child_pidfd, list, sizeof(list));
> +       ASSERT_GT(ret, 0);
> +       ASSERT_EQ(strcmp(list, "trusted.persistent"), 0);
> +}
> +
>  TEST_HARNESS_MAIN
>
> --
> 2.47.2
>

