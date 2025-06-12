Return-Path: <linux-fsdevel+bounces-51409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADFAAD6860
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A2F189B6E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A261DDC37;
	Thu, 12 Jun 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKv5eUuh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B11991C9;
	Thu, 12 Jun 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749711603; cv=none; b=fvlhll0Z1/2DXD3MKIeNZxG+MI6fsYI/j8fvEZ1ba6Eyhh3B5eQAGnz3AhIEFeOKriDqsy6tJi7S4LeMYiElGIVLE6RoBmgusiGXIOkNLmNEzTs3JZp/c1TCxMrg0jq1xXSyguEyW4vNWAnDAACMlz1YUeqz3O4ve4SEqOqJBYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749711603; c=relaxed/simple;
	bh=hP58mwixbZLpt4L8WGRAwg4LFZhaIzmw5nV2N9wnUG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BigbXpGAMOYQsqOFwbN24+XOs0egEX6xWky9Cw6lOC3/S/1apL5z55QZCOkfRu77B8MJw8BjCPng6eMk6yZ8GNDeDrR7szUtElbll6AGLKFb0H+3oYBigRGpKNUjFv+NJuBJHWrJQe1pxdWzH5Kc31uwb4o5J9os5ONPqSZkcbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKv5eUuh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad891bb0957so97042666b.3;
        Thu, 12 Jun 2025 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749711599; x=1750316399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X298AJ1vmcnnKGKwMnR0+yVEoc+HoTcMBwQlRJb3r1M=;
        b=IKv5eUuhLrlWjO+e4owlxYr/Xl/sgvjBiRHOnEr1NfCfGZ+rhaxQgEwfKG0NG4l8Xv
         6K2sHyaGepde0Bv19howVZ9aj7OOa7gkMVJO0nQ2hdqhycAOn4srB5Jnz+uTv85unk7e
         fG2evG3c8qeKAV8nHhAMSlvsPg3QFROjwp8k0in22MjEKuyp/WqPOf0VTjKffdrbHfG7
         B6uI2puz7MIN09t+C1b2lpgtL2NQm3oy1SzTE+qlhWjtTzejyeK0vohOqUm0PDN3gm5l
         gEoqXcZwPqR5/RjIZQbFCCNjzwo6H/dNKlTz6RP1d0FH8tJtkRiyh5dighjy+Kmhq8F9
         Azsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749711599; x=1750316399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X298AJ1vmcnnKGKwMnR0+yVEoc+HoTcMBwQlRJb3r1M=;
        b=Nj0ckN+bvNX52q4ASWf4Q5f312xEs0Xh4qMBkoj6JjQXN8J2pTUoJ6FDvyav0fF917
         7Bx+VLGYbEFg/LVGOhTvFYNPXlFitf6AWy+qQ7srZXZ2j0xGJjShUQj1qmAiIfVrM9wq
         B4gkX0rQXZMnCLSHcNiQVe3/UH3xpegOP2mRsB7IksGYnMZkGBeqlZ0tC0OOTKzarsdG
         W5sNAnTJgIaexTOnctZxVfQAuymgV0hDfrJ1SBohnApWB0mL3a+nmSZ/R+Hy+0v0olt5
         +xlo3TjpVjOq5/BA3P6R6aROUwq30Z3YWWgMebPcnZ+ZTV8a799kg9ERVFb3rjsL1O2S
         YSKA==
X-Forwarded-Encrypted: i=1; AJvYcCUclOZ+DYlxrJpFeTE5G1usDMk661AyPPOUY/87MOnxzwXCPqe9/6KzSQTq+5wrTLKIg9TXbE/pj3bV@vger.kernel.org, AJvYcCUnz93vKFTQJE5E9YFr9b/CyoHu+knHkxaWcWx2VMs4tt0rhwTZ3NNEXXnwmoxTSnEG4GssaaOo4A==@vger.kernel.org, AJvYcCVCVcDhdnp0AuxMX/UvHklGnE57aJJbQOqatokkdvjsdU0uGfrdcQTmO7hEn4yTPfvVNjNfuOKayKkj5weJ@vger.kernel.org, AJvYcCVcS3upsJbn4WKItvIFpsROV0svL8mCi2W/eHfGW/4F8BV6Q3L9NrzFDS27Zvs9oDEYtEXMK4wZJP426tjQAg==@vger.kernel.org, AJvYcCXMwRf3yQJgrPNaPW7XrznPAKR9IAQ89EB5XkGggg50eFLls8KPvjrGr/Zb2k5gfEjheI5QpnOjgVO3@vger.kernel.org, AJvYcCXNCfM/k8NhxrERP0eeyNOaTtVd3pHP0m8iL/I6ItgcO8k5sGe0Z8V8SRr4/OMfXcO6//pkqzL11VfMROXcNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJw6cUfZunW6r4wP18Ax3cV3iS9o4sfonz+k3fuWDbJW5niBLt
	QodxUtz+sTrI5MOE6gx0Fv3myjLA6kLpPNXbACHOrTUe0raQeytn0OB/Up2RZtjnuFX0+7LetEy
	Y941Em8v1vGu7dxo4ZRlaa6GoAb3iWJQ=
X-Gm-Gg: ASbGnct8LRd3DOkc5SgaQHzyZUSHB5ob5ImTOGCN3HcJ0lgDgP/HGsUXcXRu7wqmZLS
	9SuWmSOHG8MaqMJ3iH3UlYD8o/kzvBO1ezMP7IxKtcJvX+0hcTV+32i2cd755FfuvOT89qowY8f
	zv1S8SZYaRaRWk80dSbJ2c97Fb86/NWOeYpHuHOdX0t/I=
X-Google-Smtp-Source: AGHT+IGP33kAVQaksCPNQ+fkTsAwnqDwwrSRq7UMjy+xLEY0jPC08cQGyj+B/BdOosoGWeRWXUDx+SKIKhyM2yGlOO4=
X-Received: by 2002:a17:907:268d:b0:ad8:a50c:f6cb with SMTP id
 a640c23a62f3a-ade8955ed0emr512735666b.26.1749711599047; Wed, 11 Jun 2025
 23:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608230952.20539-1-neil@brown.name> <20250608230952.20539-6-neil@brown.name>
In-Reply-To: <20250608230952.20539-6-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Jun 2025 08:59:45 +0200
X-Gm-Features: AX0GCFsL26c6LJCX3CQkRAKbBnpI_uSHQ6IJbL_IKY5VsBhMkIpqw9gJM4WhyUM
Message-ID: <CAOQ4uxiV6Ay7iaxi3qw4nYTiVTZ6abH+W6o3z1OJVwf6ySOrzg@mail.gmail.com>
Subject: Re: [PATCH 5/5] Change vfs_mkdir() to unlock on failure.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>, Carlos Maiolino <cem@kernel.org>, 
	linux-fsdevel@vger.kernel.org, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu, 
	linux-nfs@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 1:10=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Proposed changes to directory-op locking will lock the dentry rather
> than the whole directory.  So the dentry will need to be unlocked.
>
> vfs_mkdir() consumes the dentry on error, so there will be no dentry to
> be unlocked.
>
> So change vfs_mkdir() to unlock on error as well as releasing the
> dentry.  This requires various other functions in various callers to
> also unlock on error.
>

That's a scary subtle API change to make.
If the change to mkdir API wasn't only in v6.15, that would
have been a lethal backporting bug landmine.
Anyway, a shiny porting.rst comment is due.

> At present this results in some clumsy code.  Once the transition to
> dentry locking is complete the clumsiness will be gone.
>
> overlayfs looks particularly clumsy as in some cases a double-directory
> rename lock is taken, and a mkdir is then performed in one of the
> directories.  If that fails the other directory must be unlocked.

Can some of this mess be abstracted with a helper like
unlock_new_dir(struct dentry *newdir)
which is tolerant to PTR_ERR?

I will refrain from reviewing the ovl patch because you said you found
a bug in it and because I hope it may be easier to review with the
proposed cleanup helper.

>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
...

> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 8baaba0a3fe5..44df3a2449e7 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -248,6 +248,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_=
fs *ofs,
>  {
>         dentry =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode)=
;
>         pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZE=
RO(dentry));
> +       /* Note: dir will have been unlocked on failure */
>         return dentry;
>  }
>

Your previous APi change introduced a regression here.
The name will not be printed in the error case.
I will post a fix.

Thanks,
Amir.

