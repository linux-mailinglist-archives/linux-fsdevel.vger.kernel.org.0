Return-Path: <linux-fsdevel+bounces-26690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C361795B0C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80387284EB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F794171088;
	Thu, 22 Aug 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FJI970c3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3D16D4EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316131; cv=none; b=Au9ewYjpYR321qXiG/HXhyxg7SjOVyBIxyZUIu6jhOslZGYWfsd4/L3dE3uIWHWnqPNdO5jMTrDVWjpGUvbcuHWX0xIq5+Zb+gTRXc3Rl3N47+Y5yOOlePSdmg8+WBpKW45MoqxGotelOtJCA61F4fkccoJpK40dfaPxrol6RVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316131; c=relaxed/simple;
	bh=zOwZKwgQbYh9I6K5vOjV4zHXa+b8rQusxeapSFGjSGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AN4yfUyM3oE880UGHw5yxko/4FcynXuzWTHY4q18I1wh0z0lWrEFeOZ1bpBZhdsvIn9uvHSLHRw+cBQtrxfooLOkzlseDf/YlId+FhTiOXDjhZQ/X6P8pvR+Yn4pNJR1uU1rpYwIh5Nvg206DNAYi/lamZGJ4Sg5vFl+uGipijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FJI970c3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so7329641fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724316127; x=1724920927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bn43WhWNELjWx/Xqi85FuxI5tpjHJSqlZGW7dAS/4hA=;
        b=FJI970c3Rer+TpNqutIKvgcFJ3eJ0WNhfdY+CR2GmgWu4kHbJgXDh1uYJ7sd3Be0bz
         y533t2b2Jrph83IOJg2z+MIH3KsPKSkFhIi4n+GDxBVu+MYF4b+4UJ3MTHlo22imD8lM
         /YDVDXpsv0bsaX8xoowaXipeRCxh6a6aQTEoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316127; x=1724920927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bn43WhWNELjWx/Xqi85FuxI5tpjHJSqlZGW7dAS/4hA=;
        b=hVWRttr6xJPkJZiLv/jCnLmRTc+1XalJHUDqeLFKu5RvZ9wcgsQnCgBdQCJeViWJp/
         ajO2N6jhGdUfC8mYlLZz8kjfFDzOyQYB4jg27S65+Yq0QUu7OxyhH5TzpbIB7lu/uuZp
         8LV7lgj7K4BZe2qbz5Ec0DTZ3iFjnjLy5KMohjDPbMVt5lxuQi25i4DXfQaJIKctrGYk
         bwGcOQ5hsrTjG67KFqxsB6hG73us7TH3ArK8jmDfNh5OCnCRLkBvADfyd91ZFYcPCZr7
         4jRDXEExmKzLrfoeGkbE5Gvkql7WEZjHPufYE6m8jo3/+CT1aKg79CaACepXJPYTiHOW
         xeZA==
X-Forwarded-Encrypted: i=1; AJvYcCX3+nVGnTvELtuKQNdFglyzkr9G8j8/10urN/y1S4599q2Z6GkknPDKY4FQRkc6pXPy4wvRCSs+Pw66024R@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIfVFjDP/iYBhCKC1Y2/UAZDYe0OSYmOcivZFYzdU8YkOD3Kp
	dmga65SSmmlwGRq3uKU55zqKzSdnwB4D44xU3AWtF6gBBY+rUtiNsdYrMCGzZtG/seavnSzsG6W
	DNbb9F2PYpY+yLqC3kJ4RvqTNHLArHrOKnb4O5w==
X-Google-Smtp-Source: AGHT+IG/YZ/WLpUENQ2C2Qgrv8N5KPSpA05zNxhVmjt9aj0GznyncRlTONhGYjX9dV5Eh1HlsEUMjsLQEPEEDjHgszQ=
X-Received: by 2002:a2e:4c11:0:b0:2f3:ed2d:a944 with SMTP id
 38308e7fff4ca-2f405d962c7mr8408181fa.15.1724316127228; Thu, 22 Aug 2024
 01:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com> <20240822012523.141846-11-vinicius.gomes@intel.com>
In-Reply-To: <20240822012523.141846-11-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 10:41:55 +0200
Message-ID: <CAJfpegsq5NruDeL6HRgkpj=QvdOKdnqOwZiRS0VY092=h0RSkg@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] overlayfs/file: Convert to cred_guard()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Replace the override_creds_light()/revert_creds_light() pairs of
> operations with cred_guard()/cred_scoped_guard().
>
> Only ovl_copyfile() and ovl_fallocate() use cred_scoped_guard(),
> because of 'goto', which can cause the cleanup flow to run on garbage
> memory.

This doesn't sound good.  Is this a compiler bug or a limitation of guards?

> @@ -211,9 +208,8 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
>         ovl_inode_lock(inode);
>         real.file->f_pos = file->f_pos;
>
> -       old_cred = ovl_override_creds_light(inode->i_sb);
> +       cred_guard(ovl_creds(inode->i_sb));
>         ret = vfs_llseek(real.file, offset, whence);
> -       revert_creds_light(old_cred);

Why not use scoped guard, like in fallocate?

> @@ -398,9 +393,8 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>
>         /* Don't sync lower file for fear of receiving EROFS error */
>         if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
> -               old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
> +               cred_guard(ovl_creds(file_inode(file)->i_sb));
>                 ret = vfs_fsync_range(real.file, start, end, datasync);
> -               revert_creds_light(old_cred);

Same here.

> @@ -584,9 +571,8 @@ static int ovl_flush(struct file *file, fl_owner_t id)
>                 return err;
>
>         if (real.file->f_op->flush) {
> -               old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
> +               cred_guard(ovl_creds(file_inode(file)->i_sb));

What's the scope of this?  The function or the inner block?

Thanks,
Miklos

