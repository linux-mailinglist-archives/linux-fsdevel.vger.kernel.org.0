Return-Path: <linux-fsdevel+bounces-43259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21660A4FEE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2699C16C107
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984262451F1;
	Wed,  5 Mar 2025 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml+cxoto"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96828245022;
	Wed,  5 Mar 2025 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178656; cv=none; b=L72Ur/qbb7jgOk6bMhlVXJV7EvzOLp6sZlG5/vz8IFczXoqI3sXUxA02TDxSlGIgEhztpQHuhFOZa31J5W/7wWXuGnjuEJs9a0jq6ljuaKOLc2ygG7xAAFGmSr2QW/O7YufKIQbNHZGAhML5ZqSak1dhFHONCFRLHvNMQl4AjHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178656; c=relaxed/simple;
	bh=igMH8rYOpGMy0k866Hx2ao0n8XoLlbiwESN1HFH2HU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQfITUHcJI+SZQSBaWtD3aBFJKLnljZLsBYPAM6AWbhVy3oP7SjtwellnqZH4cttHQyYaVV5YUajQD6tcXYd/XfxDMoJTrsrl97ZU05F714a12Gc5NjqIzCbCE//lXMGXnZbt+VsXGfoo9MzD6eQNNAGmqqB2t1aHsrqCjuXxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml+cxoto; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fcd686fe0fso3435243eaf.3;
        Wed, 05 Mar 2025 04:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741178653; x=1741783453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igMH8rYOpGMy0k866Hx2ao0n8XoLlbiwESN1HFH2HU0=;
        b=ml+cxotoMnlOTbYYG4dlRAHcOzA9HGupqMkyI29ddVpFQmHWQKbbefkvw2Or0cYUck
         mM8aFgmIxbIn71k34tPnXgpzGH1Ehk1aj6EWiMw02a8KLrVj2bb2cAsBUvHZpOUmUBxH
         sXh2NXz/VjqaAu4B8keKrHfz2yLTtABCzx6dMB7dlLhC6wxrbwgeHQ0fcAjrsHs0eXOT
         9ZtoGR/tXQ7ao56GHYwbHPP8tjPITxuIkfUebqsi7pLMslmGy8zbvfVDFSjDGTVquOi8
         0ob21muCck/WGW2BAIaVSDLstuIASTe2bgIzlLgZ8eOHv2VtCEcgNfYg/f8Jx2EwwPKj
         aCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178653; x=1741783453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igMH8rYOpGMy0k866Hx2ao0n8XoLlbiwESN1HFH2HU0=;
        b=w3Mgt+XlEhihzAwU9tNFGZJRpdoNN/6q0aJtmN4g7ITRKw4fVJ9k0yX46DFCM82ml6
         VKWBrknkaiKxQy2eV7D5199KHX4y8fYtrZlmPvsKtPeyRgC5p8JBpBijlH06Bdw1LnRL
         PA8Z1lThb2RSy+eD2LQr2kPlZOKMMwk1v2Vh++ke8RoHCZrHeAhAv9oYQv5Jgngz5d+W
         wUYReeIInTVVD120p5sdbC9gcPAm9Be9Alc3hSiGaNnhYhSBcZWf5oHsoXdGZJPTAxbI
         680pFZ91m/UrtjdXtnNFJgpeM8hdhDwCeRvGiTTQ7kMCblCcMKKC9SOkjycyrrXXpvW6
         oqog==
X-Forwarded-Encrypted: i=1; AJvYcCUjhVmRoKdhoya6lmWndY+p9YhvfVS8uZfuamDSYVn45XiTwlHhF5lkhXeS1He5akTzLfA5Hucpw3wwTtke@vger.kernel.org, AJvYcCVyQXf792ysZzapYHrSx73bpA8gW1NYiXVoZ7kSKvPivIhwxVJSsErOQyb8wV2APRC2CS2ATVcf8TOXUQKU@vger.kernel.org
X-Gm-Message-State: AOJu0YyTfO4IMzQyg34WY0SD34mesK3Z/ilUv/D+nWvF9Dba9lq4rliY
	BSWRlChdPx6ddydOvFukBLL6mxGff9bjhSVOyVpOukUAESc3i3znPRJwfYgLreoY5x1RGFKzjh4
	+ddS3DxqeFAsCwrEWIWfgYjqUQ+c=
X-Gm-Gg: ASbGnctVN7cK33r7keTfAh0l8RIm5CcY09CWVquf9qVwXngjod9TfkHyNOwi2xjdMzc
	/Eh9pxoMVsbYHJlVlZ6wg6Y5OU3g97QMobST6Hg6xyV2xgGo8UJB6mjO9KgI7aJNpm0NOZBBhpQ
	rQjGsECJwbzpyP/PnD3tpIII3w
X-Google-Smtp-Source: AGHT+IEtx6mSNk9bnGomPiLwZ0DgZSoKO9LEBoR3r+gcmhsbntIW8k7x/qnqH+g6LpgVV4KrR/ActGrJ8Qy1d2PFNMU=
X-Received: by 2002:a05:6820:1891:b0:600:29ef:48bc with SMTP id
 006d021491bc7-600336485bamr1331704eaf.8.1741178653602; Wed, 05 Mar 2025
 04:44:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304183506.498724-1-mjguzik@gmail.com> <20250305021936.71e837ea@pumpkin>
In-Reply-To: <20250305021936.71e837ea@pumpkin>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Mar 2025 13:43:59 +0100
X-Gm-Features: AQ5f1Jr8hkYlx_kmiXaZrtFsodK2Gn8ZCzsnCy-R9P2qrOcci-g_CnFugs_MC8E
Message-ID: <CAGudoHEqJggeQGSzXAFrQKdgh3tCzo47B_hCjSznw=w-5YUXuA@mail.gmail.com>
Subject: Re: [RFC PATCH v v2 0/4] avoid the extra atomic on a ref when closing
 a fd
To: David Laight <david.laight.linux@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:19=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
> Have you looked at the problem caused by epoll() ?
> The epoll code has a 'hidden' extra reference to the fd.
> This doesn't usualy matter, but some of the driver callbacks add and
> remove an extra reference - which doesn't work well if fput() has
> just decremented it to zero.
>
> The fput code might need to do a 'decrement not one' so that the
> epoll tidyup can be done while the refcount is still one.
>
> That would save the extra atomic pair that (IIRC) got added into
> the epoll callback code.
>
> Thoughts?

I am not aware of this problem and don't have particular interest in
looking at it either, sorry.

Good thing you are free to make the case to Christian. :)
--=20
Mateusz Guzik <mjguzik gmail.com>

