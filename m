Return-Path: <linux-fsdevel+bounces-31215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB4993248
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95C31C23347
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12351DB53B;
	Mon,  7 Oct 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKjYxJpZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB11DB52D;
	Mon,  7 Oct 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316627; cv=none; b=F1oMpIaOkdwmVjpUqHKonHCsSF+hts9oeMCtVoJcYWl6bTHLYIpO1mkFyoi80m0j1XvNND5fLRIBctaaZXwAKPouF5pkI2gN4S+dBMW5GL7ArCF56HLdbiGfc8WX0bIiNpPPXXV1dIKvZSUjt87qY2iIGxYYQiSEHsgkscjurRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316627; c=relaxed/simple;
	bh=iEmOrTnjlyRp+a8OzIem0T/ZHFYsm0tp/svzGHPe/3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOu+x8Jd8bHZKr9LifYFdYLQINY4q23lZu42kCyYGtHyD4NrO5bFdX3mo04hD+oZ9tPF8LHi4wPThMoXqzuk78ntNR04nO2BTDM985fvNcjnHGQr1KX0Zxyae/Z0L+uF6FkBDb05NNdg3OE82VP1kffekNtdCygPRgHhzEXtrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKjYxJpZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9a23fc16fso413895785a.2;
        Mon, 07 Oct 2024 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728316624; x=1728921424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fLEdo3jGiTxA4JVK9XLQ8rkE1j7QHR9NEq9fph6vEs=;
        b=GKjYxJpZDIszjSP8IDfDd0PzCUjFLMysLwwYXQjWMWMcif6zyrsbXOqZxWcQs6nW40
         mHSeWRCimpyoX77IGGmub7lAMDXgyHQknN3x0GdkxZhM02bH39JXKx//CiKvLtxqqcvE
         k5bU0X5otdYIc/UvlaIrgU5FmCZY1lkyAFUh9GaOTyq6Dkmk1YFyANX50DKlR5PrxvHG
         RnvarxyezB1K2KhcXfT971lTPYBv2mKpit2lOKfCaCun0hfYa3bj3/Yk2mZCNMP63KDE
         IULYZtKPGEq1OwKyezzrhv6WsXcd1fdBoQRDUpTLFQfczqXq0CD9jV64ohYQED9Pa7Zv
         Swcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316624; x=1728921424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fLEdo3jGiTxA4JVK9XLQ8rkE1j7QHR9NEq9fph6vEs=;
        b=OA6MBKnFhvsw/wGp61cBiVecKqr1ZejpA1KZtFU3BzXlouXB2Ch0BzyL+PQC4X0ONC
         awgiEha0VkV9UoGrzqpfTTOkbqXJejY4n1ufX+ZpBB+ZDQveBn/3Kb1HF9FnEuDWQCup
         ddG/9Jhd/tJ/ha7MDvn078g4pfVBcod5gfwobFsJ4aqK+YA+Zqwj3uPmxaA4e54yTrCm
         WZcWwFfkAVNK7Tn/XzrxYJkRDBzT8F5FFdAVPbgRKYIYHw35A3IGd8IFP6bjUyaE7b2x
         iuf23WLBaTUcl64D7WQmJ9pIJWS74eihtQTvCD6c+fOEn+Fw/FMIpskAK0Vh+kaqn56A
         Be/w==
X-Forwarded-Encrypted: i=1; AJvYcCWjmQnEwSSCUg0USJyLbROUu2aKlkapeq0+na3ebnPtWKGoTceWIxxDZ5r5hA8Jd4iigVChLIZxBoya8N5aSw==@vger.kernel.org, AJvYcCXvpZ8yWQJggRY2xFjbLAGEIFbIO1QMDUvNLJhU952rw8Hbo7x/4PuRi3DrJ8uoCFFomos0+uJV4zYulxpz@vger.kernel.org
X-Gm-Message-State: AOJu0YwLD7K0ir9jkC9BWnW6UGNLXf674ebk+rI0YNaSIXI0xdiwxIYq
	A+0UJHYyCU/INgSfcw0aIMkrr66GzLBtPQ7A7ZFRpJKtuZsdt5ZeB/dB8/jTIXOtcao6aSuhR0h
	MszMct6yZfbmSAJzvSn/5W0iKjDE=
X-Google-Smtp-Source: AGHT+IHUC2wDewia40YKzXmhPBu3TVGf24NOptI8qmh9jY/vPlfAzPu2QH7S7rBTOr6Ldiey+3KH1VGIZs6BmkDwGT8=
X-Received: by 2002:a05:620a:29d2:b0:7a9:c2d5:a9f0 with SMTP id
 af79cd13be357-7ae6f42dfadmr1821757685a.6.1728316624415; Mon, 07 Oct 2024
 08:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007141925.327055-1-amir73il@gmail.com> <20241007141925.327055-2-amir73il@gmail.com>
 <20241007143908.GK4017910@ZenIV>
In-Reply-To: <20241007143908.GK4017910@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Oct 2024 17:56:51 +0200
Message-ID: <CAOQ4uxjS9YMF6tiJTNBBSYSpWuHY+Ds3J_C6ySYDpe7-o5wRNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ovl: do not open non-data lower file for fsync
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:39=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Mon, Oct 07, 2024 at 04:19:21PM +0200, Amir Goldstein wrote:
> > +static int ovl_upper_fdget(const struct file *file, struct fd *real, b=
ool data)
> > +{
> > +     struct dentry *dentry =3D file_dentry(file);
> > +     struct path realpath;
> > +     enum ovl_path_type type;
> > +
> > +     if (data)
> > +             type =3D ovl_path_realdata(dentry, &realpath);
> > +     else
> > +             type =3D ovl_path_real(dentry, &realpath);
> > +
> > +     real->word =3D 0;
> > +     /* Not interested in lower nor in upper meta if data was requeste=
d */
> > +     if (!OVL_TYPE_UPPER(type) || (data && OVL_TYPE_MERGE(type)))
> > +             return 0;
> > +
> > +     return ovl_real_fdget_path(file, real, &realpath);
> >  }
> >
> >  static int ovl_open(struct inode *inode, struct file *file)
> > @@ -394,16 +411,14 @@ static int ovl_fsync(struct file *file, loff_t st=
art, loff_t end, int datasync)
> >       if (ret <=3D 0)
> >               return ret;
> >
> > -     ret =3D ovl_real_fdget_meta(file, &real, !datasync);
> > -     if (ret)
> > +     /* Don't sync lower file for fear of receiving EROFS error */
> > +     ret =3D ovl_upper_fdget(file, &real, datasync);
> > +     if (ret || fd_empty(real))
> >               return ret;
>
> Is there any real point in keeping ovl_upper_fdget() separate from the
> only caller?  Note that the checks for type make a lot more sense
> in ovl_fsync() than buried in a separate helper and this fd_empty()
> is a "do we have the wrong type?" check in disguise.
>
> Why not just expand it at the call site?

You are right (again) I open code it, it looks much better:

        /* Don't sync lower file for fear of receiving EROFS error */
-       upperfile =3D ovl_upper_file(file, datasync);
-       if (IS_ERR_OR_NULL(upperfile))
+       type =3D ovl_path_type(dentry);
+       if (!OVL_TYPE_UPPER(type) || (datasync && OVL_TYPE_MERGE(type)))
+               return 0;
+
+       ovl_path_upper(dentry, &upperpath);
+       upperfile =3D ovl_real_file_path(file, &upperpath);
+       if (IS_ERR(upperfile))
                return PTR_ERR(upperfile);


Thanks,
Amir.

