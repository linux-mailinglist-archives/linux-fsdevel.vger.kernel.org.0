Return-Path: <linux-fsdevel+bounces-31725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724DA99A63E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 16:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FDE1C230A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B4A218D9A;
	Fri, 11 Oct 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S0zFoJW0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18152217902
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656707; cv=none; b=SV1ibCo3gwrqQhEw0PW7w0lD2uNfDznIsL8B5XxZMuKTWAVCEK+vzjP49JYa3courc/b02dyBZlR0c73HLl+6ZPDECZ4TDKITKv3TWdTKEPGZn6OX7kCk1QhAAePjxERclMkqD7zQhPVe0shjuU2dULiUUr+WwD2N5jWm6+3oME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656707; c=relaxed/simple;
	bh=Z06ZX3jyjHHXwlU4TZrDePXX2GHTkfqA61r4hHgnXKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw/ZYhIlz5MKwuDZGwP7DIiExl2BznfOH/iH31AhkJLknfoUcBRtuFFTNfJ3YU3+zwqJFdgxYmvcCk0FXyrIvtdg53zJ5yyDRGoFDaHSJ6CGrRIQvE3d+XoGDaQiHBqArpnKSMGoXw7+3WDRSFPTRnCzxHZfvxm73xLjtau/MSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S0zFoJW0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a999521d0c3so343936466b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728656703; x=1729261503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yvM/KSYPJndV8gm9+2x3WAU5j2bDwLkBoxFcaj4aT8E=;
        b=S0zFoJW0l2RXBNcFg1bwiYU9qXoWdBpKU+lKjS1lPsX93Bl53rmrVcWHfRUj89+yVb
         /g4eorBB9PJ6OdCjrzDXrrfHWSU+grEiS9pZArja1VB1G9FlQy8hxP5nhYpCIKyBJ0PC
         /lqQ8MrFg9HFb9CBHLQmWP1R//GEzVNaByTFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728656703; x=1729261503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvM/KSYPJndV8gm9+2x3WAU5j2bDwLkBoxFcaj4aT8E=;
        b=n5s+1JLS7mYucAr21WG7OON/dhWLk6hGEUejp/Yj+hhGSYUOHJprMzswr96NEjr6l3
         rCyViwC4TPbs6Jo7EyNlXgpmAO/zojJhxNGZ/qo+l9TVy5uKyExXESwvkWqaGbR/Vjax
         v4DhzODzfL+caYse72cexUswc8gnMuMKt/CUcd/X+yVSS9i8KuO1ru3Q4i8qULpWH0Lh
         3OPAZRh6C8dzXxu+W70bUfQ+4rbOBroBbqogUZmspWogGdq1+dBkYnMSKHUg88HqjOcS
         tPN9qGS42Jzp59ZVHisBCuU3Y71n4nFAIXC4qPUspLYqy0S2EZOnKv2Cd8krEXthBM1u
         wJNw==
X-Forwarded-Encrypted: i=1; AJvYcCXym7tREccldL7Jyfb5XIA/b1tkcWJGXcl6NYj7ZT3Zsk7MtwVXCc8SpPi724ya6Y9aGqSZH2KgjBsZJQay@vger.kernel.org
X-Gm-Message-State: AOJu0YwDY3/ZK8b4QQnkxr8B90FpGqCnvXoXdrw1TZW6Vxwm96mqnUOA
	fY9WjOmysydj7gi/k0TxeLh9gpwmp6fXXgUEwfKy4qeYavBwkk+rRYkjnl5ygJP9BD1Npdm6Ig7
	kOnPZTvN2pH0AK0NcxqaIJsE3gC1jBXMCgnt2dg==
X-Google-Smtp-Source: AGHT+IE/62eyehAD9pqMcpvhtIMlM/jeT1Moa1+HO0ho+MMJKnfVrsHX4l3I9JvqJ+7KqeQvukibxxgeygCZYsAD1z4=
X-Received: by 2002:a17:907:9806:b0:a99:44d1:5bba with SMTP id
 a640c23a62f3a-a99b95a7e72mr252149866b.45.1728656703209; Fri, 11 Oct 2024
 07:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011135326.667781-1-amir73il@gmail.com>
In-Reply-To: <20241011135326.667781-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 11 Oct 2024 16:24:49 +0200
Message-ID: <CAJfpegsvwqo8N+bOyWaO1+HxoYvSOSdHH=OCLfwj6dcqNqED-A@mail.gmail.com>
Subject: Re: [PATCH] fuse: update inode size after extending passthrough write
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	yangyun <yangyun50@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 15:53, Amir Goldstein <amir73il@gmail.com> wrote:

> @@ -20,9 +20,18 @@ static void fuse_file_accessed(struct file *file)
>
>  static void fuse_file_modified(struct file *file)
>  {
> +       struct fuse_file *ff = file->private_data;
> +       struct file *backing_file = fuse_file_passthrough(ff);
>         struct inode *inode = file_inode(file);
> -
> -       fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
> +       loff_t size = i_size_read(file_inode(backing_file));

What about passing iocb and res to ->end_write() instead of just the
file, so that we don't need to touch the underlying inode?

Thanks,
Miklos

