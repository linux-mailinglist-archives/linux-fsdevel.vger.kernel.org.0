Return-Path: <linux-fsdevel+bounces-10224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A10A848EFC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 16:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB1282E05
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE08225DC;
	Sun,  4 Feb 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUb9QyKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CC22611;
	Sun,  4 Feb 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061558; cv=none; b=LSgaatOGwvai6F/wDOpf0WaYQqGpF+FhOYmobq6t6iOa4sEmyLj4MQuVXwwNfN/2O6uv5bqtVmrEtLEpwZH2WGG0+f8qL2sybWHsBysab2ULZRsI/Id59x5QOju2JZfYUrewOoF89D3BpWbXMEDbm3t2GvjMjOcrys7FVHDm6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061558; c=relaxed/simple;
	bh=lUgppHZGb1vOjtolopDlqedRfuoqxQctFGVGsU1wMHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0DAg7dW7jlOQXXtiD1rFp2F1HSlFfvckFyvAfmg7BPhA0ArQMbjsozaNPhz/YoVBi9xcnjjvlkLHNgl7Zkjbg3YwuDSMX7UaJWjVs2XDwttqOA6ahxPIvIX6PdGHuKQR6RVjdHkrsCuF6MrW+Tiv+F3Txv/N9zbt3cW2lp0h0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUb9QyKC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337d05b8942so2725047f8f.3;
        Sun, 04 Feb 2024 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707061555; x=1707666355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErjVDx00u8D0uyLxAbe0rYeVX5VlnaMxXzQQWliNW6k=;
        b=cUb9QyKCVB46pM8nPZXWXTja/69KrA62OEAIg1D4Viqo9Lh+Gu/Wyez9LsSm9WJcrT
         AmCA8TPxel3EMkrF1XjQzJlm/bNHj4TUPgds6Y2axz2p2OLxCTKlS7/1J8EugllOxEa5
         wpYbUGsZikhCvz77d65sbeF/19/e+7QMngdvB3pPc0Kc7xPJIOjCixyB8mWYP0Rw2h7K
         u0WqLWsMgszmdm1ZFFXI+sYJMGRRI7QbaG726RgFdURcltpghjdvV97yTat9kpVNcwyA
         8UAEGQeA8QKvI/nwmnUL9Yfon5p5p5vBBGYUNKohMt/wdZbnS0eGrLgURsunBVL5v74k
         AuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707061555; x=1707666355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErjVDx00u8D0uyLxAbe0rYeVX5VlnaMxXzQQWliNW6k=;
        b=R1ClZC4RDO4nJL+Du4HbO1BZX10ljjkWcFyalv7M8VB+gj6JuJr77VAZk6rhyhJ1WQ
         jWJ0Q1d51rlqpOOzaEWcQ6+KiRakEKQ1NLL2Vyiey/NRQuSKha+KuUVBWmPCQT2y1HZK
         YwYRWbr4LoGFia2Imj2M5PuHh77/q7loORYbKtzzXNX9rQQ3Q1wXk9Cdf/D7UxQlZfLK
         2xkwLElDXxcdpql9HNmbzyLyaxXa5hak6DkdwxBPMzauLGmYJXmtu2YH+UfIPP0su6tY
         vrEqFm6zuYcSmdX+BDA4CFk2QfuPZELLWRelaqpCoFy9EaBFvsfpSbIWhmj/qQzoeIdZ
         3sBA==
X-Gm-Message-State: AOJu0Yw63h1Lb6eNCpsP9NbtFIrTcWi4Qf0/iwB2X+R7r/x/y9BFxZOL
	rzzlO8CHEk0emR25Jc3sxjI7f95Vsz6vqkCa6cClyOV0zo0lxIhC3iO1hjg1fkiID+GkRJuY2+2
	N6wC/ESHpImzz6q9LGPcCErjQWas=
X-Google-Smtp-Source: AGHT+IEr3S4iwLwTGT7CdXfeBrkbADV4KmxBXcpxQ0KO4aMKJ/IOroFZxQehrrV3DGXIs1edvcvpXpbv/p8XG9pWHrg=
X-Received: by 2002:a5d:608e:0:b0:33b:3d6f:7a2e with SMTP id
 w14-20020a5d608e000000b0033b3d6f7a2emr39650wrt.49.1707061554633; Sun, 04 Feb
 2024 07:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204021436.GH2087318@ZenIV> <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-12-viro@zeniv.linux.org.uk>
In-Reply-To: <20240204021739.1157830-12-viro@zeniv.linux.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Sun, 4 Feb 2024 09:45:42 -0600
Message-ID: <CAH2r5muOY-K6AEG_fMgTLfc5LBa1x291kCjb3C4Q_TKS8yn1xw@mail.gmail.com>
Subject: Re: [PATCH 12/13] cifs_get_link(): bail out in unsafe case
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I may be missing some additional change or proposed future change -
but it looks like the patch to add check for null dentry in
cifs_get_link causes
an extra call to cifs_get_link in pick_link() (in namei.c - see
below), so would be slightly slower than leaving code as is in
cifs_get_link

                if (nd->flags & LOOKUP_RCU) {
                        res =3D get(NULL, inode, &last->done);
                        if (res =3D=3D ERR_PTR(-ECHILD) && try_to_unlazy(nd=
))
                                res =3D get(link->dentry, inode, &last->don=
e);

cifs.ko doesn't use or check the dentry in cifs_get_link since the
symlink target is stored in the cifs inode, not  accessed via the
dentry, so wasn't clear to me
from the patch description why we would care if dentry is null in
cifs_get_link()

On Sat, Feb 3, 2024 at 8:18=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> ->d_revalidate() bails out there, anyway.  It's not enough
> to prevent getting into ->get_link() in RCU mode, but that
> could happen only in a very contrieved setup.  Not worth
> trying to do anything fancy here unless ->d_revalidate()
> stops kicking out of RCU mode at least in some cases.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/smb/client/cifsfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index e902de4e475a..630e74628dfe 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1172,6 +1172,9 @@ const char *cifs_get_link(struct dentry *dentry, st=
ruct inode *inode,
>  {
>         char *target_path;
>
> +       if (!dentry)
> +               return ERR_PTR(-ECHILD);
> +
>         target_path =3D kmalloc(PATH_MAX, GFP_KERNEL);
>         if (!target_path)
>                 return ERR_PTR(-ENOMEM);
> --
> 2.39.2
>
>


--=20
Thanks,

Steve

