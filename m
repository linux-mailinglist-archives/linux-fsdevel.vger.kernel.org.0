Return-Path: <linux-fsdevel+bounces-42826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E97FA49113
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 06:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB071891B61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 05:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2381BEF77;
	Fri, 28 Feb 2025 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnaIgwBs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C441ADC78
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721489; cv=none; b=m0o0zQu9ZM5E2MLSkjrObvQvd7e8pkvNez7BWbLq/Cj4XjyyZ32n0Ot0BqdC9KSfzwZyZdXWMs6txzaA4SAI8HQddtKYvJCJZGOmKHStVTIijBpJhS9YMJWlsMYYU3jqJc0/oFfQ1XYC2iBVQBrNcg6AWP5LAEtm4AHzGlYhG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721489; c=relaxed/simple;
	bh=Ech2PTIZf11lCjz3EcxM1WZd5vONG+v3+120sbZgIBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXcjAU7Nk70BuYsSuPgIiNDcmFJiP2m1rDR2acYxU3V3r5yEJ92y72OYur90gt4PFP6lfPJII6SqaPQLjTHXk2tRPYvaZVheaLD34/EiLIc+0Y2FAyd4gA6OkUdUP6SSNWf/DoiuSBtnHzy7LSsnAhkOT6CmkpAsnkwbmTbJIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnaIgwBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0E5C4CEE2
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 05:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740721488;
	bh=Ech2PTIZf11lCjz3EcxM1WZd5vONG+v3+120sbZgIBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OnaIgwBsuBI9t55bsJ+e817Nltjd4szjzbuo1t8+YSbizMFgcteLMQ/veTBKObd6M
	 Wp8UMSsUzg2O3TBJN+Fpa+fjFx52xVnvnI3ODtdYA9yeu/8AyZPaDjd5iEG7ouSb15
	 O5eSb8Q2OfBaVt/uv+0wZ6FNj/PNWegwOHiN1d2m7siZJGzbbEhKbWYxKPXBBcPzSM
	 HuRcONpYY4KD8JJq4J8Nc+59qe1f0nP5LhC9/TLoX8VufUDJpLG18hVZeY0Seclx3U
	 x6M4uqi5PvWHcFalYK4f9TCfkaJrWg0GW2VGkR8u/PRQ85p5wy9c6VIc5nmiwi/vLx
	 8UC55a8Uo78Zw==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72721c2ec6aso942378a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 21:44:48 -0800 (PST)
X-Gm-Message-State: AOJu0YxO1kdqlj7RrIQAQzuKPRuei2HOsBjA1FgyG6Wp2HGINk+5xbui
	+g9lg6QlZWKye5qw2ojAjqO1qyFr/nytNmx2kZ8TUHy1286YGtZ1S4bfW/+0sumfzZn99YnCnQz
	zS5CeL25sdriPZd6c+wB1RgfqCa8=
X-Google-Smtp-Source: AGHT+IH2HEt6WbZ2j+2yxUR/l7h1uSMj86plwl3qjxCXj4NowD3m5CHzV2wlZNjZ1LER1ll9/8xqXh3hhkbzsQ4xBwA=
X-Received: by 2002:a05:6830:2587:b0:727:25c6:1b60 with SMTP id
 46e09a7af769-728b8269063mr1123981a34.5.1740721487951; Thu, 27 Feb 2025
 21:44:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227224826.GG2023217@ZenIV>
In-Reply-To: <20250227224826.GG2023217@ZenIV>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 28 Feb 2025 14:44:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_-v601SX44WZ970LyZjsCH3L3HFjJXxZH960r1PXo+Bw@mail.gmail.com>
X-Gm-Features: AQ5f1JpgEoDzZMBQyxYft7BO6uubmVHgdFbq5WGs5L7EslDl1p2OLCO0A4cJ4vw
Message-ID: <CAKYAXd_-v601SX44WZ970LyZjsCH3L3HFjJXxZH960r1PXo+Bw@mail.gmail.com>
Subject: Re: [RFC] weird stuff in exfat_lookup()
To: Al Viro <viro@zeniv.linux.org.uk>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 7:48=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
>         There's a really odd comment in that thing:
>                 /*
>                  * Unhashed alias is able to exist because of revalidate(=
)
>                  * called by lookup_fast. You can easily make this status
>                  * by calling create and lookup concurrently
>                  * In such case, we reuse an alias instead of new dentry
>                  */
> and AFAICS it had been there since the original merge.  What I don't
> understand is how the hell could revalidate result in that -
> exfat_d_revalidate() always returns 1 on any positive dentry and alias is
> obviously positive (it has the same inode as the one we are about to use)=
.
>
> It mentions a way to reproduce that, but I don't understand what does
> that refer to; could you give details?
We need to find out the history of it.
Sungjong, Could you please check the history of how this code came in?

Thanks.

