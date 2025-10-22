Return-Path: <linux-fsdevel+bounces-65051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD54BFA175
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA5944EFC64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637652F0C6C;
	Wed, 22 Oct 2025 05:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXAABJkv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93B2ECD13
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111676; cv=none; b=iGOHhOcABCzz83Iob0gS3SQvZHerJuXreegA5aQkXd3WvkLX95HyJNmHroCtc+//hdeaa5VdFMPzFPiCwNkWfCTJQ50phsRtAQLhlagqqjg1M460Ry6Z16xIYeiXDKQp5jkT/1HWjkRunrwIkLrVxuU98kwz5x6e1gSf7ZWcxJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111676; c=relaxed/simple;
	bh=sXvlzhJohVL+aMdIieAR4+sB6JssJbuYaPKD+0CjzyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uk+QcG2wwBl1oPwhnSnqBBEIOdpEGR0erFmwrMN4P/odmKFqBgJF4wWbdqTnCz8S4JC4ZjwhlqLtb80BVolVlLCc//EX0EGijjCdPvoVs8PQc+AkP0CyL+5l04Hhb9ALkdp1Cg9XqdpvTjogBwziG/SVCocJQs/QyVFlZwIQZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXAABJkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31028C4CEF7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 05:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761111676;
	bh=sXvlzhJohVL+aMdIieAR4+sB6JssJbuYaPKD+0CjzyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nXAABJkvQonUIXUeC5wvDi/yCwgkHTVyYv8dXALQF9SAnk8rXO9iY5FF5H7ktvC3Y
	 nZGMum4LcQ4qDCr0h3wZ0V7ohmjSws28ucNKbzdHcCVl9KBuk3vy5+bgwVr1Ea/04y
	 n1fhy59ESL7GTFbrGkSdhg+kDhSMUdbXNsDuWng8FtTLpdKalljIv0TtP+/AKNH01i
	 6nFK2ERStVPXRVuT4AbptbtRzal2YOidRYTdkSehiB1SFVOfnWaDsMhYToddoe8QXn
	 6+d+lZVFrk4FeDNfHm47z/h2aA89IzovyxvIQhX5mbX3HAlGhXdE+HNlveAnGTVedE
	 XkhHGtHd3R0Rg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso1101743a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 22:41:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9TpST5MxVp3wW0ABZhG4OFdC43SlXZU1zq0x1oMm/lwz8lS8OxGVdbmGoJcj55QFJRPgRSb/sCDfDlctn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9v0xR4B2ZXwkWCF8k1Por3WWJj6UpmofYIdQSSdZWb9MlvJIz
	zEBgkue9NTjGvgjkLGDsZAuKWduc6hHEFA+P+EuOHtl8IxHIbWubjw+HslOxy6p5hgK2D0M0bv/
	4L/k40NWRSoe7BxuXKSlDR8bWCuDZvp0=
X-Google-Smtp-Source: AGHT+IFW+lxkh5Rk4qv+MITmDMf7675+2Fu0Dt4bVJ6rVnqT8i/HFMco0lj+LUz6XugYFQJdflpEYnGosAzChBh2UM8=
X-Received: by 2002:a05:6402:449:b0:63c:274a:4f16 with SMTP id
 4fb4d7f45d1cf-63e2712469bmr198740a12.16.1761111674797; Tue, 21 Oct 2025
 22:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPdHWFiCupwDRiFM@osx.local>
In-Reply-To: <aPdHWFiCupwDRiFM@osx.local>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 22 Oct 2025 14:41:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd88+gEvGe+aJUEVJetYyk-vpejfHuLNujP6NPeXDMcJnQ@mail.gmail.com>
X-Gm-Features: AS18NWB5SqBBqrhODAO-yE_ehaFHcbxRjxGzU2eOHCKmbZyqttYJT27dWD1e_qU
Message-ID: <CAKYAXd88+gEvGe+aJUEVJetYyk-vpejfHuLNujP6NPeXDMcJnQ@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: fix refcount leak in exfat_find
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:42=E2=80=AFPM Shuhao Fu <sfual@cse.ust.hk> wrote:
>
> Fix refcount leaks in `exfat_find` related to `exfat_get_dentry_set`.
>
> Function `exfat_get_dentry_set` would increase the reference counter of
> `es->bh` on success. Therefore, `exfat_put_dentry_set` must be called
> after `exfat_get_dentry_set` to ensure refcount consistency. This patch
> relocate two checks to avoid possible leaks.
>
> Fixes: 82ebecdc74ff ("exfat: fix improper check of dentry.stream.valid_si=
ze")
> Fixes: 13940cef9549 ("exfat: add a check for invalid data size")
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
Applied it with a reviewed-by tag to #dev.
Thanks!

