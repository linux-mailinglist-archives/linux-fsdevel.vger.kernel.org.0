Return-Path: <linux-fsdevel+bounces-31158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F22992919
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 12:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E081C22AF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AFB1A7269;
	Mon,  7 Oct 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2J0Bz9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB3158A36;
	Mon,  7 Oct 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296568; cv=none; b=lQuATDtFXJEeV8njH3N8UNi6vmdRH5uWeZGzowNup0Rtbva3qd5b4MJcDVVc6uKSqrfnIK9CwzsNiyEKUsjFfsoT9QfbJlRxATCKuOyXgfgp9Y3BPp498I8sVmu3SEFEc8fXGdCdPzgE5i5NqIyDOCm38T4Bys8bK7rUD2lOz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296568; c=relaxed/simple;
	bh=2tcYNsROgqwFiv2aj7bpgd9F5qyVKbRAChcJLgPyi4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHkvMGnwAev9BJLMxkDIQeZ3g7N725JCZ8jGjUk29nrE5FUn7Cmboqm310DkDFu9dJZZMog4iQisaXojjL2LergHuuaTBYqDlDYUI4hYXzEiYyDkb3A38q3tHrWshtmycksD4Q8GtqxMaN1/jDLhJ9mcI8dlxuDSVpX250BLB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2J0Bz9w; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a9ae0e116cso432037185a.1;
        Mon, 07 Oct 2024 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728296565; x=1728901365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tcYNsROgqwFiv2aj7bpgd9F5qyVKbRAChcJLgPyi4s=;
        b=K2J0Bz9wNIw9tgt4/DAq4+3yl7AcKrc7xxGj9fvf0SdQRL38b/JKtIPTF1xfgncWd7
         pCViXLLjNy1Dyh5KAkLeCfC4jUDBYOEPsY6bCtzdvToMvpTtjeqEx22qAQMnpPZH2pi0
         +UA1QasUitOdvBnkp6De9/dBkzjSirttuhqEslJQTUL9leI72p23sgyPtiBaJ5pdt73Q
         xIVWihlPJ0yX9uQKFk7dD5i/2w2Ii8D2m3Tf3f63eUUFTWNKNy2WcrGBR82+DcOrrAyA
         qAv1/ixhAp5WziAYN/57IwqKUqngqFNICjjFtkeppbwsqtDBedkAZ6VLwglSZx6X6zOX
         /bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296565; x=1728901365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tcYNsROgqwFiv2aj7bpgd9F5qyVKbRAChcJLgPyi4s=;
        b=bZh/Mo88tMijxzaH6rjOXp+QkPk64FHf+vU8RtNdvmuZGG2fhbQg1JhBUpSZm3Bt9L
         cbmtsyS2G5SFD6UUIP8kMItGhAY4rpMCzBLDsFr5aJEOR9viVRKzEQiXBu2DyUlTXfbM
         L109SepOhLhFxB0cJhSBMxE9Dy0zQ026YUDD1v5l0lUk+h39F+/qzYoBlEwCpISR9D3t
         6RnRt76DbhQUUMPn5UFq2tAPRr/pBJvpDSEhThs8z7Gio4cj190SwTm7P4bjv0rZXt+y
         rvrR6YVyiTkbLAY2tTnl9sHZR2Z6mt+QzTiHU1LZs+DgDStsdrTCyGRawxi0na644Cxk
         reWA==
X-Forwarded-Encrypted: i=1; AJvYcCW7RHEBcrj//GR4fu23cC5lW3zcqVYdTS4y0HIVOFAE39P8jTBmeJBKpGXpIRF+dlR4YuXCB3T/LbodO0vP@vger.kernel.org, AJvYcCXoFL9077cRrfCHMyFKjrEW2Zry+7qPWZSSClt8Z8qK/2S5Kwrs+kastvg8p9LEi0bMPHi6xeD/LRKWxdlBow==@vger.kernel.org
X-Gm-Message-State: AOJu0YweAd7RuvkGN8fcWDQQ9hB4Gzlg5IzuntAq9axC3bxpOoeWZhuw
	kI9UlOpjrUrucLVIL6FlNfnHrnGyC6XH6ieERS+m4h0JUQYH3I3E92ftKl2rGLcDhC9RQV6rdNk
	zlR9MdGAzyrPylQf7nm+TwsOE8KCLng09/DE=
X-Google-Smtp-Source: AGHT+IEnARvdxV4pr4jrBAaqB9xU79AoS7n7WEIPcx/OcljY/W5TMNW2nFawoRZmRsJjqE53OwyDTAPw699yzTX9V1U=
X-Received: by 2002:a05:620a:40b:b0:7a9:c146:a9e9 with SMTP id
 af79cd13be357-7ae6f441967mr1375690885a.15.1728296565401; Mon, 07 Oct 2024
 03:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082359.263755-1-amir73il@gmail.com> <CAJfpegsrwq8GCACdqCG3jx5zBVWC4DRp4+uvQjYAsttr5SuqQw@mail.gmail.com>
In-Reply-To: <CAJfpegsrwq8GCACdqCG3jx5zBVWC4DRp4+uvQjYAsttr5SuqQw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Oct 2024 12:22:33 +0200
Message-ID: <CAOQ4uxjxLRuVEXhY1z_7x-u=Yui4sC8m0NU83e0dLggRLSXHRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Stash overlay real upper file in backing_file
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:35=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sun, 6 Oct 2024 at 10:24, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Hi all,
> >
> > This is v2 of the code to avoid temporary backing file opens in
> > overlayfs, taking into account Al's comments on v1 [1].
> >
> > Miklos,
> >
> > The implementation of ovl_real_file_path() helper is roughly based on
> > ovl_real_dir_file().
> >
> > do you see any problems with this approach or any races not handled?
> > Note that I did have a logical bug in v1 (always choosing the stashed
> > upperfile if it exists), so there may be more.
>
> Stashing the upper file pointer in the lower file's backing struct
> feels like a layering violation.
>
> Wouldn't it be cleaner to just do what directory files do and link
> both upper and lower backing files from the ovl file?

Maybe it is more straightforward, I can go with that, but it
feels like a waste not to use the space in backing_file,
so let me first try to convince you otherwise.

IMO, this is not a layer violation at all.
The way I perceive struct backing_file is as an inheritance from struct fil=
e,
similar to the way that ovl_inode is an inheritance from vfs_inode.

The difference being that backing_file is generic (to be used by ovl/fuse)
and does not have per-fs constructor/destructor/user_path() methods,
because that would have been over design.

You can say that backing_file_user_path() is the layer violation, having
the vfs peek into the ovl layer above it, but backing_file_private_ptr()
is the opposite - it is used only by the layer that allocated backing_file,
so it is just like saying that a struct file has a single private_data, whi=
le
the inherited generic backing_file can store two private_data pointers.

What's wrong with that?

Thanks,
Amir.

