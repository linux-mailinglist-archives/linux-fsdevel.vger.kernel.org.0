Return-Path: <linux-fsdevel+bounces-15931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F113895D94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A031D1C215FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558215D5C1;
	Tue,  2 Apr 2024 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CW9yCGB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B115D5B8
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089705; cv=none; b=aYV/TueitXDRpoXaL7ITTDwvinE5C3L1PGeWMa2cb8k9SNqEiiIueHFu6tbVJamt3/DyYNAZvBShZnsfmbUvQLNUVLjDJ4JhgAhmV7prfITXNQcj3zLhSJBHGCOMbrqLKQmSgSjvB5zeoZno6HULpfMma1S5/Vow8e+O1lECbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089705; c=relaxed/simple;
	bh=LfVYX8aS+uGvfYiFPza5xfpJggy3wA1TMy/HX9tJed4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ+JjT5SLIw1c4OX4+xNK9lzD2uvcthyp6gg4RlsPd7tIXlL47/Jv+7tixico6IDvaII1CVT8MQo52gi9wMOyzW0WRqimbAgJ+cAunX6RU6KiD/1DRl5mHWu+tZwwLnaFyfdn5Yn2iV+hj3CbR0oDLn1pkVcwOl2M2ZYXJgUoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CW9yCGB4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6144369599bso32702617b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712089702; x=1712694502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoSv33fHX+PiwFO/k1mr+DGe32nj0k4cYvUK0De9J/g=;
        b=CW9yCGB4NsT7Ls+jy9a6DbYdVWYC6HEPWhP+LRjpxT8xZbfmT/2MlJpXWm41hFvCdP
         zJcJJbaBAJUmVDzLx+hbesZBDJqjxEXn44gC0Jz6qf5Q1jK9t7SmMdIWQtYqGGSg6nTt
         hwsNtV1wVZp12mAgDmTDKqNY/9b/yc+RBs82dlEuWi5kyKpFqVzlmrnUqznGfzPQ/XU8
         ntcMqkXDQamfcIVrut1I+Siwehow7GjMTqsb50uULbCq0hX9vWVPwwhvE3vqZJ2UU+hZ
         wlpdv5vqjuG+5w4Tik6p1gB66uVC+iXGqaJAmKZVpCoep2DV72fT3+g61GehW+I14v7W
         F4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089702; x=1712694502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoSv33fHX+PiwFO/k1mr+DGe32nj0k4cYvUK0De9J/g=;
        b=PjOB0DtH9Ork8UGqaZ6xzGZwbkx9zSANVVj22QcUfZOa131hCTWbsaxxo1QnVguMYL
         0BhdtX6JvaC+wJFPuc4tKNhOmLSOikvlYh4c1PGBxuoz1/7vu6Sd3Pstk2F7nJndAqWL
         fLL+cCovo33Qt8lq6hL/vODaG6I4Ckd9/hFrQGhm2OPpeH6x+kvLgL35QbWlPdKT7Im5
         Cz4mMw3PficcuRJ3uqnHQIPgTsoosKcHkr22tgePCYF3ty1IpBWBj8NMrCFj8BjSAB5+
         JsR+Ytdss6AhXMuyqJoHeGmsm5ul5mkaGdtw4GMWCxgg5K5OButZC/pOxj+VfyLilWnc
         uxBw==
X-Forwarded-Encrypted: i=1; AJvYcCU+RXzKt0ATaBGHNgSAp87jWHjjdHqTbmqTFkGIHKkd2OFjmbcSgWbRHY3NwbDIzAVUoMdlgJCQ8MrqFEx/beE+HmVgbxqgeNQBmbmfWQ==
X-Gm-Message-State: AOJu0YzIAOF9RiY3JpSr8IoCGVPxxwl54i0OfD5naPzO9xkY1Da9rdG0
	bl502jzodrvwUPzfLSQJMVjcY6hmtf9i8K0XC9F3bIiSdhVJsJ1aYT17IHKACr4M8gD9pDWzZpc
	4FLx7W9z5AlIXp7ER1vzxxB78eiFRR7Eaj+cG
X-Google-Smtp-Source: AGHT+IEVBN+nZl8MKEmvtUo5GMbK7xeKkzls5qXpx0s2OutO7Jvpps2qS6SsUR1HM2jxzRpzT7CFKW3Wf3o/srFXHhw=
X-Received: by 2002:a81:5342:0:b0:611:2eb4:2402 with SMTP id
 h63-20020a815342000000b006112eb42402mr12634897ywb.21.1712089702684; Tue, 02
 Apr 2024 13:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com> <CAHC9VhTt71JUeef5W8LCASKoH8DvstJr+kEZn2wqOaBGSiiprw@mail.gmail.com>
In-Reply-To: <CAHC9VhTt71JUeef5W8LCASKoH8DvstJr+kEZn2wqOaBGSiiprw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Apr 2024 16:28:12 -0400
Message-ID: <CAHC9VhSt0GkTe8ho2yyP8Bp1rbtiFbp6dNY6m93cvBXJ=aKtSQ@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 4:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Apr 2, 2024 at 3:39=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
>
> ...
>
> > But if we really want to do this ("if mknod creates a positive dentry,
> > I won't see it in lookup, so I want to appraise it now"), then we
> > should just deal with this in the generic layer with some hack like
> > this:
> >
> >   --- a/security/security.c
> >   +++ b/security/security.c
> >   @@ -1801,7 +1801,8 @@ EXPORT_SYMBOL(security_path_mknod);
> >     */
> >    void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry=
 *dentry)
> >    {
> >   -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> >   +     struct inode *inode =3D d_backing_inode(dentry);
> >   +     if (unlikely(!inode || IS_PRIVATE(inode)))
> >                 return;
> >         call_void_hook(path_post_mknod, idmap, dentry);
> >    }
>
> Other than your snippet wrapping both the inode/NULL and
> inode/IS_PRIVATE checks with an unlikely(), that's what Roberto
> submitted (his patch only wrapped the inode/IS_PRIVATE with unlikely).

Nevermind, I missed the obvious OR / AND diff ... sorry for the noise.

--=20
paul-moore.com

