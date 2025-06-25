Return-Path: <linux-fsdevel+bounces-52919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA3AE8730
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B925D7AA3F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36FA2620E7;
	Wed, 25 Jun 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClEVAXxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06B25CC72;
	Wed, 25 Jun 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863264; cv=none; b=NiIWhkiGW6iRiopX+KzkRbhO5o4P61m0PnQ6anAZt5C5276zAKc6kHT+xSNxpzVxYpiUq6FuvN9lku8RNwm90xymF5Bs9lLSZHNwRw5ekWS96zVHeOFEY1o2Cdt5pmwQ1wDKJHyB9bOdbzfap4KRhg93/qre0wk0OIDDKd2WmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863264; c=relaxed/simple;
	bh=bSbW3Ao5NnYYhtPiPYA/a0zwmOHJ7kXkixqqAFK0ec4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7JZwTdZs+5/a4JmtoR2jxk8G0v6SnSfDHuU1HEiS4d0bcs5neiIPdLi6W95AmegWuGXDc383taExSshiX0Ghlk992x/85b1ajiHdQVweL+6ifzQzVCoJqkrSILVqVlbWzo9VEVZjgxABQ3i5k31+nbj3yrWjB/PWZ0h0UpA4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClEVAXxx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so307947266b.2;
        Wed, 25 Jun 2025 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750863261; x=1751468061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85mnjut4Qrzvx++ihdM4K0Mp9S3wQFl4oHc8X3V+0TA=;
        b=ClEVAXxxoOYjOTf9q8vqvUCh/EUg3ccuDQH+87UPvGl2cPsn02JZOqkmddyBbta8Vw
         QfqvZrMyJNkxVNIGiiCnqU0JUzSrPRDE4fn9DHLNVkgmWFT2Mi3mFBhjS/aOFyDrlZp2
         NWtxU4Ro7pUTMMOV8FsLtK3BHzacRAQExj+W9OME5O1CoJAu15Oqu+yoG7iSlF5Q3lIB
         n2XVyqr6BAMkNQQH4FABLXJXgiQTP4AIy4zDSCHF6+l6d8S1HKsNuBz+B4B+Ifee4Z7Z
         RlZBZ0QjUnUu0cgB3nordq29QDFlaOEQasL1rIkAoAQktRa/PHQjAZdhnVAEj7pP4aia
         e+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750863261; x=1751468061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85mnjut4Qrzvx++ihdM4K0Mp9S3wQFl4oHc8X3V+0TA=;
        b=BpWj278cyEFf+cAr6Qnj/Y6tNvGVr5GrViYA0B5UosgUYy2BV7i4rZPc5bsqNODJQt
         FCZTtOtXV1wReRLDumcBbRKGwe9t0lfONszmf/LUkJ70Dk3Rxr5qVEQoSvlSRcwyPGOI
         ihWyvSeDpmGlDXB9HuW+Z8fm1NUoKNqPJ6uRxNi+POd/BW69rD7ysPUyPd1zvtVtN34F
         WzTFtXu4MURiiPRNeOUfwqWQkrVs276v5ZobSzqQ/YwXoLw6fdYwl0dh6Qq3gKqnIZTQ
         Jg8E9PPoHK9hxOd1mIV1RPL3Syf0DV6FaONOFm+etGREqoBREW8AocIk4VBcZNpJkQ+w
         E1KA==
X-Forwarded-Encrypted: i=1; AJvYcCVR8CySC3lLCwOUZztu0pF/EMLQ9lWsu4Ir3INkYFmZ9OaZEB1rvxHTq09oKUFsZCnSSHClMnAfpI4lU5R7@vger.kernel.org, AJvYcCXUklHbvrNi1yVyTkaC6S8N8jNUZ7KfTxhQvDyGBSAKGfY+JEeNXRSh1g8dPgsBOgQzyfrkY61rz7mmlNgdCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrCTQvGdByDpyaMdxTCXAkFWDO6MZIO+E7IhTfbIaeeuznpmM
	AYlEMT/2La6gfg2rxI7EKS3M8E+87bVWfqZgaxPrep7EXTUQtlMed4Fur5IgbWv1xm0EkVy9PYx
	/XvdNzWobUw95EnqGdqksChu0AYJccuY=
X-Gm-Gg: ASbGnctR5r26I7d95qxcj3dQSpY4sTy3YeUI28eOvUvIDGwrOu68YWKzCffqgQyzdM5
	Rq2S2TRhjrWRf1cv6aOTOQMWT4ykJJICVgo+cqHClmTOe5H42GONgZcpdS4xXHQev64S3Wq1XeV
	kSLXJ6DlB92OrKBuwvspIgbZb/4tx4VEZ8rTx68VkogNI=
X-Google-Smtp-Source: AGHT+IHfeHsNiRhgmSuUXH7XqI5vAmbDU8P6T8xceiz/mQ1hz7QOwxicCkRB5LArKnhjoXv8hKxySH0QrA+hz8Ps2lc=
X-Received: by 2002:a17:907:96aa:b0:acb:5c83:25b with SMTP id
 a640c23a62f3a-ae0bebe8f00mr354101966b.7.1750863260305; Wed, 25 Jun 2025
 07:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-2-neil@brown.name>
In-Reply-To: <20250624230636.3233059-2-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 16:54:08 +0200
X-Gm-Features: Ac12FXyQICWqYuYgBHUEggZFAKxpEiJlXBBeyReIIhgCndVimIFkZZZJFgkxEV8
Message-ID: <CAOQ4uxhoVe2g+85C5e=UrGQHyyB=B4OgKcXF3B_puU+5j0mCRQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] ovl: use is_subdir() for testing if one thing is a
 subdir of another
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Rather than using lock_rename(), use the more obvious is_subdir() for
> ensuring that neither upper nor workdir contain the other.
> Also be explicit in the comment that the two directories cannot be the
> same.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/super.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index cf99b276fdfb..db046b0d6a68 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -438,18 +438,12 @@ static int ovl_lower_dir(const char *name, struct p=
ath *path,
>         return 0;
>  }
>
> -/* Workdir should not be subdir of upperdir and vice versa */
> +/* Workdir should not be subdir of upperdir and vice versa, and
> + * they should not be the same.
> + */
>  static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperd=
ir)
>  {
> -       bool ok =3D false;
> -
> -       if (workdir !=3D upperdir) {
> -               struct dentry *trap =3D lock_rename(workdir, upperdir);
> -               if (!IS_ERR(trap))
> -                       unlock_rename(workdir, upperdir);
> -               ok =3D (trap =3D=3D NULL);
> -       }
> -       return ok;
> +       return !is_subdir(workdir, upperdir) && !is_subdir(upperdir, work=
dir);

I am not at ease with this simplification to an unlocked test.
In the cover letter you wrote that this patch is not like the other patches=
.
Is this really necessary for your work?
If not, please leave it out.

Thanks,
Amir.

