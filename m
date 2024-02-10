Return-Path: <linux-fsdevel+bounces-11048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646085041E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED01285955
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0536B1E;
	Sat, 10 Feb 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuuvAB+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB22E632
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707563892; cv=none; b=sbyluw5EADpDpvGPDCdYJnpCYuNke3LpIBb/Q7X4SkkGjJtqYVIClaoxQ7KyQKP7RFs1eTUCdLo8/W5QBJU9AkWV0xIjuvL0RZ6ixIXchzYNp5eRFbqfafafy040G28EA7npKH6yq9ftj/oX3vTDqdwczsiypTPoQD/h1TwlfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707563892; c=relaxed/simple;
	bh=hpaogRASeaerEXW2Mr8N5pJ2g4Gmz0Y+obiEU2b1g9s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=aOojkqXHeI4k0UgquYAiMX4NDIC3xanheZZyZWyOF5P9o9yJSov3o4ZsnxFj5UQxHVHtL31dF6wWkXjWYK67mBRlE1N9L8OUHfRARd5TMMSFCqiCuYagBOyLNgGILQE9EJ3DMwCMMQRCSmHpoYHo02Fo17lr7T2VzAXjDECbkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuuvAB+D; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a3bdd99a243so135062466b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707563889; x=1708168689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBImuqEGB7LJBBmrsv4s/EmFpB3s96Gxvwonty/osts=;
        b=WuuvAB+DDPESdYeOuN2oDL6jj+8WSPg461XVkqglutog62k5BL2tLLbFesgnN2G2mh
         y1KIEJImnEKPn8DbaiXUK9x6wOReWE77HTaf1M2lmnn1SagMpPfQ1gOlYFs+a4pVy/c+
         nsJJCda3PACwUr0Ppaxi9GcIHR5Jmju89jbFd+Tj0aWK9fPn0UB9sGBz+rv69GF2G3n5
         w2KacI2UdpSsVR/RqbrJItzL4tje3htIZ5ESCLP09xtjZx5ogAPW0azF4XlMcHGz0spL
         1bLdd26s9J4oOHfezSbOhGnLeZRnZ0w5fpAkHrYuEzvrMiH6k0GND5kA8ABU/Agh2CNo
         s66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707563889; x=1708168689;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tBImuqEGB7LJBBmrsv4s/EmFpB3s96Gxvwonty/osts=;
        b=VZrhR11vtr1vgy96lvWjn3JiubGgnaBm7k1oHmasKYz+V3SlHNQIDXrrRAolMKw/fQ
         q/lOjGs/imSlkDVJ/WzM4+sIi/O7FsQPaDWMaC8JHF2GCfMDCdysa5kLS+achQKLTm0V
         V+7fpKSxi36t5xx3fox8lG0bIJ+XONQy+oMwnmIwLBaLgC9kzyeAT4o5PMQ6CyCeq95+
         6XTSDv+CWfxow0Rn7q6YjE7pMfV+4VDeG3DwvBNf5HwUsSfZDojxK4H2c0TpymDWI/ee
         p288TfPmxQvDhP8a6Co0BPG+WNNIuRDZJSHB4h7jw8I6r+vS/nHF0JRzBrVUrbpbzWxZ
         K2ig==
X-Forwarded-Encrypted: i=1; AJvYcCURzvKfwNtQRudkf48Vusm6FKIr6nigx6SRS/WqfE5MQwqrVLRQphGfbJ1EvhTcBOKMFlmXIPTrw23AFwx7YfC3SHyGCnEwfKglF21VCA==
X-Gm-Message-State: AOJu0YwLCEizAiM7sRpR0hN6R5Q8Dz8fCEHX3OSy4lUyO72GcOw8j8QI
	fEZn4+ZDlRbhWd8Z9PN3Dq/w9EdGFuSdTT/6wRpbyVwUm0m6uIH1E+x1z0Xc6kj8MDE+LYdIRf2
	6zg==
X-Google-Smtp-Source: AGHT+IEIu1NEf08aJQbPTZgUIvK8xDlF7ynnpNJc9602vhH3JzWqtj7SVVFOjRSv3ez0dZXExRRG2xmJuF4=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8d33:f17c:2f0b:c8d9])
 (user=gnoack job=sendgmr) by 2002:a17:907:c289:b0:a3c:4b73:e3cd with SMTP id
 tk9-20020a170907c28900b00a3c4b73e3cdmr1256ejc.7.1707563888904; Sat, 10 Feb
 2024 03:18:08 -0800 (PST)
Date: Sat, 10 Feb 2024 12:18:06 +0100
In-Reply-To: <20240209170612.1638517-2-gnoack@google.com>
Message-Id: <ZcdbbkjlKFJxU_uF@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com> <20240209170612.1638517-2-gnoack@google.com>
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 06:06:05PM +0100, G=C3=BCnther Noack wrote:
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 73997e63734f..84efea3f7c0f 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1333,7 +1520,9 @@ static int hook_file_open(struct file *const file)
>  {
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
>  	access_mask_t open_access_request, full_access_request, allowed_access;
> -	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
> +	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE |
> +					      LANDLOCK_ACCESS_FS_IOCTL |
> +					      IOCTL_GROUPS;
>  	const struct landlock_ruleset *const dom =3D get_current_fs_domain();
> =20
>  	if (!dom)
> @@ -1375,6 +1564,16 @@ static int hook_file_open(struct file *const file)
>  		}
>  	}
> =20
> +	/*
> +	 * Named pipes should be treated just like anonymous pipes.
> +	 * Therefore, we permit all IOCTLs on them.
> +	 */
> +	if (S_ISFIFO(file_inode(file)->i_mode)) {
> +		allowed_access |=3D LANDLOCK_ACCESS_FS_IOCTL |
> +				  LANDLOCK_ACCESS_FS_IOCTL_RW |
> +				  LANDLOCK_ACCESS_FS_IOCTL_RW_FILE;
> +	}
> +

Hello Micka=C3=ABl, this "if" is a change I'd like to draw your attention
to -- this special case was necessary so that all IOCTLs are permitted
on named pipes. (There is also a test for it in another commit.)

Open questions here are:

 - I'm a bit on the edge whether it's worth it to have these special
   cases here.  After all, users can very easily just permit all
   IOCTLs through the ruleset if needed, and it might simplify the
   mental model that we have to explain in the documentation

 - I've put the special case into the file open hook, under the
   assumption that it would simplify the Landlock audit support to
   have the correct rights on the struct file.  The implementation
   could alternatively also be done in the ioctl hook. Let me know
   which one makes more sense to you.

BTW, named UNIX domain sockets can apparently not be opened with open() and
therefore they don't hit the LSM file_open hook.  (It is done with the BSD
socket API instead.)

Thanks!
=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof

