Return-Path: <linux-fsdevel+bounces-57879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E730BB2653E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7E2A024F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26A92FCC1B;
	Thu, 14 Aug 2025 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxXulLAo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56A15D3;
	Thu, 14 Aug 2025 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173975; cv=none; b=Nabc8KlYZ0Q7HgLzeOXZ+VMinjNIUgS4zEu8/lsDyEm0AJ9StT6tEdmexOR5IaHZvpOB/oH4j+u1uGV84PI+u/k4AnLd9YmJJ7svpWv4VdR7mek7DtpkpmRryfIafSUx8CAqOhUrYbGS4f+0MuvQFEiBKD7jdZAHDICve2KQWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173975; c=relaxed/simple;
	bh=cVUwkg44gWTMiAI0H/K8VGUxs2MWReS6frnwDplaM30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMARKI9UXkIZxQD95z1Kih6CbJDpRxvZk1rxQOlDwWzRzb8xQ18WwsTMxfjGr5R0evPcs1ZrrrkG3Lqjrcb2JqTlBw/UDv3Zh3A0t/SPTUCxzJWngKDGKa0rHQFebrWy4ToZ5aBQ4rVn1/iotQbax7PPT+JbW7kFw0eQhpeZ/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxXulLAo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b73e6ddso1774538a12.3;
        Thu, 14 Aug 2025 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755173971; x=1755778771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEAni+jTz0fmFhcueZ2bkxNr+3F3k4dXHWU2un0B95U=;
        b=FxXulLAoa3g83x7N+S0Vfd8sVWDQ13peOxdBKq7CzblAal06pE9UOwxjOwoww3qw74
         6qBE8YZp4Cx2sHA4VYOcn+yG1/1Ze511LgRBTBmqU89H7jOj1AMbE7neeC7aKLsCXgRC
         1/wy5aJ3R/9caUs+Eg2QjoPbuv2eMBsSziIMg/0w4xm8FAkCNUEd5hmBgzZgLbb46wiQ
         j4LRpeJIkcq7vLySWjCk0mU4WMpZOLjUFSWWCuUC8fgEYfWSu5oAXyKm7ymouk5XB0iI
         BmBneyyi4vr/ktSk25KuiW5mT4meqqc7SZR4CeDXlW1CjlmvbOB7il6XunMykHCXU893
         byEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755173971; x=1755778771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEAni+jTz0fmFhcueZ2bkxNr+3F3k4dXHWU2un0B95U=;
        b=jvm/9Qqm0TIbl76UakzuGRtufw5nz91SiHHIu33VZm3rxTV6P8oOx8v7ObpUU+n+2P
         0a/tD68Crv0ai5jb1et2TmatCpPJZ4rU5+DTCr9O3uMDSgzmCnFKDD4TI76hpSZiYSp3
         8kaJ3/tvrpVxcbd04g2wuOyZSS1GVVVEU4m/ptvzsb/BujenpgQoTnkfZErZ+1ShifM7
         mN/AqF4eVTtzhSf9j8WdkLdWyZxAJzZrOnsJGcIfk4gVmBz5W3Y9DdxMhFOSTLUpZK9S
         iKTi++TQZIZGs//cr69rvDrIDE2DNK7PalgsMfXbJjmNXBGiXo+nLaxOf+cBOhUJ0AQY
         MRog==
X-Forwarded-Encrypted: i=1; AJvYcCUQHuLKHO6eKJ4erFJvht7TkT+bZFjG0EnjQi8pLHV0YhPskQHE8aX/Fyh7x3MuVHrDVgrrEa+VmuNe4cWj5w==@vger.kernel.org, AJvYcCUzW/vdvx+A9OiQBRevTeZhOkDe8jpU8409ZKXVsAnkY99Xs8tTY4q7Ij354tkaU7SLnttNvvB3rkAOdQlR@vger.kernel.org, AJvYcCVMU6vZ3tO9W6q0csLlfQItgbVgjdzcKVXtT8bka2Z+QwyRxkCsl2fRf0h4yGsuqTrncwtFs913m5OhGenc@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDsLaIUFAV3alW4ADkYvMxVXp4w4niRSjPcX8/6EwsKhmF7CD
	p///xEq4GgF5WCDmvAp/OpAHtbPr8s/an/rjMMh3ni/iLg67QM+4iWfuTPu1WUXZj3akY04ifEY
	hkynFaTVHIZ7LXNtHiAoLLBIWuR4xREo=
X-Gm-Gg: ASbGnctyV2qw8IuiNzDdsubl7YUcclcYPrvqcHTOG1gcWzOXvd0uk3YXEXFhsh0Ftkb
	8KJpUTfA7ZYyumYAlcv8rgN/cSbAY/LDq755KDShJ/2+fxrWASVMxZGJvyLvWXKXVz/OHe5gO29
	Iy/O8l7PobU2Mdzcj5FRQ0S/QxzZxIbuaLtIudsCkE4Bvr+6C7rN+Bsfl37T6LHHkADpiWLQriG
	2Kl6HI=
X-Google-Smtp-Source: AGHT+IHcizjh3OchzONIXTdDXXHV6InpoUCf4DCUlBsxAfPv3ktXONYjfA1wmkqCUnNYcdr6C/fVbYTHeQQW0un8ogQ=
X-Received: by 2002:a17:907:6ea7:b0:afa:17ef:be34 with SMTP id
 a640c23a62f3a-afcb939d298mr299613066b.5.1755173970734; Thu, 14 Aug 2025
 05:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com> <20250813-tonyk-overlayfs-v4-4-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-4-357ccf2e12ad@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 14:19:18 +0200
X-Gm-Features: Ac12FXzzH6iFPTcXmNpZfWhm2ifoAcrV0wMjOawgycMr0nhK2A9vGqzCk-TAysY
Message-ID: <CAOQ4uxj4AvR851vZ7d_QZm1Grg2aa0hefP0-bywRXamHFXyP5A@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] fs: Create sb_same_encoding() helper
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 12:37=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> For cases where a file lookup can look in different filesystems (like in
> overlayfs), both super blocks must have the same encoding and the same
> flags. To help with that, create a sb_same_encoding() function.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

please reorder vfs patches before ovl patches

> Changes from v3:
> - Improve wording
>
> Changes from v2:
> - Simplify the code. Instead of `if (cond) return true`, just do `return
>   cond`;
> ---
>  include/linux/fs.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 20102d81e18a59d5daaed06855d1f168979b4fa7..64d24e89bc5593915158b40f0=
442e6d8ef3d968d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3753,6 +3753,24 @@ static inline bool sb_has_encoding(const struct su=
per_block *sb)
>         return !!sb_encoding(sb);
>  }
>
> +/*
> + * Compare if two super blocks have the same encoding and flags
> + */
> +static inline bool sb_same_encoding(const struct super_block *sb1,
> +                                   const struct super_block *sb2)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +       if (sb1->s_encoding =3D=3D sb2->s_encoding)
> +               return true;
> +
> +       return (sb1->s_encoding && sb2->s_encoding &&
> +              (sb1->s_encoding->version =3D=3D sb2->s_encoding->version)=
 &&
> +              (sb1->s_encoding_flags =3D=3D sb2->s_encoding_flags));
> +#else
> +       return true;
> +#endif
> +}
> +
>  int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
>                 unsigned int ia_valid);
>  int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *)=
;
>
> --
> 2.50.1
>

