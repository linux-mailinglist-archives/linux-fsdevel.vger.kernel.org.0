Return-Path: <linux-fsdevel+bounces-22347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A032691689C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5561B28195B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7317D158D81;
	Tue, 25 Jun 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4BrQSKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4B1482F8;
	Tue, 25 Jun 2024 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320997; cv=none; b=KRkl7Tx5XOMXIGK8HwRRY2kvYKEo9DCt2vhTknGldkOksIl3g5B/1ALa87DkILLs9BomLq5eL/9nsLQa5j4b/J+22K+faT04ODUBm4BKVhmx1QlpJlM/tqt3/r1LrlbKQy/O5JbC4bbRzLlxkyI+ICdvpWLy7X3bzHkc6xW0Aps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320997; c=relaxed/simple;
	bh=jsczAnp7CIUVDgN5gvVhygNvdruRsiSpkUKCSkdxuXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCmiOC7ZComxnxj0smJRWY1BX4ggawgVhkQpBBJuKqja4tM+xg7pLAASTTyLUbZ1Dfk28N+rN2WUUdtHHJmw4h8tObopYvlsKJO6oLql72SvTK6HViARu+swe1CxvplCxsf6Del2v+w7EEVGzQ4NalYAcGq4VK2S7ATpOg78Xhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4BrQSKz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso6731488a12.0;
        Tue, 25 Jun 2024 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719320994; x=1719925794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I/OyCTH9tC0S/1ZlOh3yAXg5RWkJQCDwGUdve0tJZY=;
        b=R4BrQSKz9Bo2zhhRAT91I9FMjpSA7x6B7Qcp2qZY1J3IwQjmcwwgWHWzxLXlbeMXl/
         0uPrKrRUVrdus5UIZ6/TzPo6oOR/BmDdqeMB/yBJTSym2XWO5tKEy7qojnsQIZOKK2F9
         gWFSkzIT/7oak0+CxenH3SXPWErEvMPMBovU5EiRk5W5LAxqsait5ciW+Y5kn3iAvUCc
         iSpJ+TbdhIdXCFkrzSGNBIzDKaoD8R8vHMNYUrnFpF9iYH5/K66iQ3GciAecDxGtVt/R
         Y4F9bDtsEt0oC3yMoHf50rhoPfkSHPu1RtfM6KuWD0PxlT+1i5a8Urf4lHnPRkH4Ht5r
         wg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320994; x=1719925794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7I/OyCTH9tC0S/1ZlOh3yAXg5RWkJQCDwGUdve0tJZY=;
        b=jdXHC4rrT0PP8u34sE0bcpHLZrPJWizJ31ts58iGhb4EGST2QRso33UwaYXBdvuL+x
         qvUi6GH+5gwcTqV4IFqNr4hlqFgVdiyvSKrxiWnLeU0ks+VjYpkY/c2GSRcmDuhIj9pD
         y9bUnLeR2BRPR2FGlq8FA9uNk+O+x624CAkD4BtWAH3TpN/r9dVFSjLpRqTCRON/sow1
         bZ739McbSMA6ZpIXDkFcyO20209J6w39qv8QSHX6XCkopf8LXAtoE33N9Cov4bQhd3NN
         DItMXF67MnU12jYVod8Jvo+Byv+epeLDfZA+aBkooiGXymEuSGYlh4zqaAV+6Oef7SPW
         I9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPMK4dU8aVyQydihJ1vg3JX9zOfN8Ug2Hg9873Ds8+wULXZKLlGSQxOGTbJ5jUMLc+whwXu0btdGIRVG/BAnQ+ZqF4JOnJMyKhgHZyS78pCgCYR0Gcwa7+EUX8c144djBoYV0CmM3iQU5yuw==
X-Gm-Message-State: AOJu0YwAmszl9AcErtveUQEwKSsv2Vn+EMIMCaJwYLpXtGDKr1PDVzmc
	/fnrA1yG3TPOI7MoJGIimokCGWLsoE1hxSFCUkb/KMtzLLmwi6Qb9nyLhIokJW9GgCwe8RuAHgt
	EoKydl5X1JUoKCOJEMUAqkGz0fNiH1usumEU=
X-Google-Smtp-Source: AGHT+IG+fxBjc/EeHCo73F9LduvCGf05LFAs8kPPx8MaQUqKfvcqcEWFnugOysE1WmkczDQb2n7puSHOCZ/Man6IleU=
X-Received: by 2002:a17:906:36cb:b0:a6f:1c81:e220 with SMTP id
 a640c23a62f3a-a7242c2e772mr574414566b.13.1719320993970; Tue, 25 Jun 2024
 06:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-4-yu.ma@intel.com> <20240625120834.rhkm3p5by5jfc3bw@quack3>
In-Reply-To: <20240625120834.rhkm3p5by5jfc3bw@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Jun 2024 15:09:40 +0200
Message-ID: <CAGudoHGYQwigyQSqm97zyUafxaOCo0VoHZmcYzF1KtqmX=npUg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs/file.c: remove sanity_check from alloc_fd()
To: Jan Kara <jack@suse.cz>
Cc: Yu Ma <yu.ma@intel.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, 
	tim.c.chen@intel.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 2:08=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 22-06-24 11:49:04, Yu Ma wrote:
> > alloc_fd() has a sanity check inside to make sure the struct file mappi=
ng to the
> > allocated fd is NULL. Remove this sanity check since it can be assured =
by
> > exisitng zero initilization and NULL set when recycling fd.
>   ^^^ existing  ^^^ initialization
>
> Well, since this is a sanity check, it is expected it never hits. Yet
> searching the web shows it has hit a few times in the past :). So would
> wrapping this with unlikely() give a similar performance gain while keepi=
ng
> debugability? If unlikely() does not help, I agree we can remove this sin=
ce
> fd_install() actually has the same check:
>
> BUG_ON(fdt->fd[fd] !=3D NULL);
>
> and there we need the cacheline anyway so performance impact is minimal.
> Now, this condition in alloc_fd() is nice that it does not take the kerne=
l
> down so perhaps we could change the BUG_ON to WARN() dumping similar kind
> of info as alloc_fd()?
>

Christian suggested just removing it.

To my understanding the problem is not the branch per se, but the the
cacheline bounce of the fd array induced by reading the status.

Note the thing also nullifies the pointer, kind of defeating the
BUG_ON in fd_install.

I'm guessing it's not going to hurt to branch on it after releasing
the lock and forego nullifying, more or less:
diff --git a/fs/file.c b/fs/file.c
index a3b72aa64f11..d22b867db246 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -524,11 +524,11 @@ static int alloc_fd(unsigned start, unsigned
end, unsigned flags)
         */
        error =3D -EMFILE;
        if (fd >=3D end)
-               goto out;
+               goto out_locked;

        error =3D expand_files(files, fd);
        if (error < 0)
-               goto out;
+               goto out_locked;

        /*
         * If we needed to expand the fs array we
@@ -546,15 +546,15 @@ static int alloc_fd(unsigned start, unsigned
end, unsigned flags)
        else
                __clear_close_on_exec(fd, fdt);
        error =3D fd;
-#if 1
-       /* Sanity check */
-       if (rcu_access_pointer(fdt->fd[fd]) !=3D NULL) {
+       spin_unlock(&files->file_lock);
+
+       if (unlikely(rcu_access_pointer(fdt->fd[fd]) !=3D NULL)) {
                printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
-               rcu_assign_pointer(fdt->fd[fd], NULL);
        }
-#endif

-out:
+       return error;
+
+out_locked:
        spin_unlock(&files->file_lock);
        return error;
 }



>                                                                 Honza
>
> > Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read improve=
d by
> > 32%, write improved by 17% on Intel ICX 160 cores configuration with v6=
.10-rc4.
> >
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  fs/file.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index b4d25f6d4c19..1153b0b7ba3d 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -555,13 +555,6 @@ static int alloc_fd(unsigned start, unsigned end, =
unsigned flags)
> >       else
> >               __clear_close_on_exec(fd, fdt);
> >       error =3D fd;
> > -#if 1
> > -     /* Sanity check */
> > -     if (rcu_access_pointer(fdt->fd[fd]) !=3D NULL) {
> > -             printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> > -             rcu_assign_pointer(fdt->fd[fd], NULL);
> > -     }
> > -#endif
> >
> >  out:
> >       spin_unlock(&files->file_lock);
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



--=20
Mateusz Guzik <mjguzik gmail.com>

