Return-Path: <linux-fsdevel+bounces-68352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2FEC598D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 19:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1047135053A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2A3126DE;
	Thu, 13 Nov 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKLnbqVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD72F5A07
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059363; cv=none; b=jq/1Rw6jAnWuuFtkgDvMO3soxEVchXFDKoCVmfevzXi3GpOFwFFhw/yiYVSl41+6sdXIK0M21zpDJANVRs6F+IZPJWf5B4dP1CbAJ9/T+Ui9/CzVqV/YtMVlzJrE0R3wTVZo17zpHify6cC8tf9I/focoy6l7f3WrWFANNKHyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059363; c=relaxed/simple;
	bh=vkMiow+1ms56PcCvTLU0RYUQRyn8k5JItnQgs6sT+60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbixQbFNaffI/63L+TTId6EYQeMlvlIVnkRoRDCRt1UD1y5vSDWnVI3r5eMx8b0kIGigTAqfvHIiN0qIy9XDicZUqtWfypY1ARHM3ixxGkzAGBNlC7Pa8jt5+0A3XTQfZp0c/munXOtPLGlmt5PkEvWNEm2XaiQDBw7FgrRPudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKLnbqVz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b403bb7843eso234390166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763059359; x=1763664159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vqBsctwl60QsbxzonTsZPrDrAkCw3j2v5Lfpm0yDzA=;
        b=MKLnbqVz94JXnmBvVVHYT7ZQ00tTi+asWopWuuSCAVCuho1qespfhf2GCNnbH93SS6
         zHatfac3WNH5D1vDWmJ+v6c4cpGLmYLlQg6V6efB8LMR3moPMGCEBdJqW48CJ6rmcK7g
         zP76847UswEVf3Nvt5UFd83HQwkF1/44LhUTP8O2F/fw3alPd/Zv36xMto4hts6Voy5L
         SluWb8UdK/ozwUQ5gBdcNryuqdIelKFfeC8vCG+lIGsBqOSX9TFbjZDjMtN28tRy6dhU
         Im4NbpWTR0oP8Ynfzwm4SXmEeNLjiJsiEXuxrwT1ZqLo0NyLbG8JdJIAQa1sePe+Q8Lp
         Mi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059359; x=1763664159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4vqBsctwl60QsbxzonTsZPrDrAkCw3j2v5Lfpm0yDzA=;
        b=hR1ih5PnGqTLatYH0OXpmg2HS3C5u63S3PsHzwbkivD6iXTDapN72kyOJZHYs6hfWf
         B1gZ2jgBVjVt5gLQYUUyBxGFzSsWO16b39DX7ghz+ahAckB72HXDklCkF2fOh0gcicmh
         oR+vUjltTz9akpKpvXn9aIw/cD66CtFy3qN+9Pv4mPdThbkh/CzLYLafNYapMjlVFIQr
         yXVo5qTy+GGBe9Ep2b/4cSXbHrWyQWvmcyO/Keyr3J6FiVoX52O1Wimvydjl1cbuJ+/b
         uWkv43hCGLAQ522HhR6eP9nsQu7BHAzhm4jVKN5xQ+qAmYRzdIRmaJeBgF5Q4WvLNWIz
         zuHw==
X-Forwarded-Encrypted: i=1; AJvYcCXgTREzh9aDNV/bV0mzLgKKAQAusw74QwB5ckdfdSNVJFT92F1o9W7NZD5bF5YZM9JPb4e053RmWucFHcTq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyesj7TjKT8RfKQDRyiWcCMJ+JPNQRluerjNGXEJXy8RIxWkuFr
	O+1+kRMD8nebQhJg1ZC6uQc00KAyOkxuSYCVT+3fViJ/1RZm+FFtWUiUokg3sgmqNc2i3T34HX8
	lvXsQnXzlEh7kn+PP5YhmFGCQsiEJZRU=
X-Gm-Gg: ASbGncsbKilvdg846ERS2BxWG4v79qb540tfzdhbz6kJh0DloLfCMRCyYdeLjmpiVgN
	1tveuVCxE8WpQ534Mz6ppfVT3IzcDaw20+Wtu32dLvvu4jAKIkDe6uZimR9OKn5fLYEpIwGaHuZ
	hprWkWr9OhWcjZrT4j/iQOHhexQXAtb6EyiJXsv7qZRubUwTs9VczeKpcQLLe3vHDkW/7XP/ssI
	9FLr4pRut3CLjI1bJzG/BqHR97PSNo8R9t/IbotOoGRTmizPKIzHLpIhdY6jOhKP1EwXljrYDru
	hKmFrlObcByCrYaIIMg=
X-Google-Smtp-Source: AGHT+IGdfn1u3gS/PRRt2HlWgSujLTq7wFcHQiBdhoAo3+LDbZLegcrov/svaaod2/hKCP8QsFjY8gvTgqki0l8K6AI=
X-Received: by 2002:a17:907:d09:b0:b3f:cc6d:e0a8 with SMTP id
 a640c23a62f3a-b736786e693mr24155166b.17.1763059359232; Thu, 13 Nov 2025
 10:42:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org> <20251113-work-ovl-cred-guard-v2-42-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-42-c08940095e90@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Nov 2025 19:42:28 +0100
X-Gm-Features: AWmQ_bnsFNc8E8lkJvmBZKTiunyhO62nLio50a0geJBfvLHNV-INFsCrCp-wPDQ
Message-ID: <CAOQ4uxh5j5wEKRoZrb-Vp+rt3U07A6D2O4Ls_ZWJ9cp2PjR=4A@mail.gmail.com>
Subject: Re: [PATCH v2 42/42] ovl: detect double credential overrides
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 5:38=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Overlayfs always allocates a private copy for ofs->creator_creds.
> So there is never going to be a task that uses ofs->creator_creds.
> This means we can use an vfs debug assert to detect accidental
> double credential overrides.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/util.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index dc521f53d7a3..f41b9d825a0f 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -66,6 +66,8 @@ const struct cred *ovl_override_creds(struct super_bloc=
k *sb)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(sb);
>
> +       /* Detect callchains where we override credentials multiple times=
. */
> +       VFS_WARN_ON_ONCE(current->cred =3D=3D ofs->creator_cred);
>         return override_creds(ofs->creator_cred);
>  }
>
>

Unfortunately, this assertion is triggered from

ovl_iterate() -> ovl_cache_update() -> vfs_getattr() -> ovl_getattr()

So we cannot add it without making a lot of changes.

Thanks,
Amir.

