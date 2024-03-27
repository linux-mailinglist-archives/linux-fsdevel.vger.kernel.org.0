Return-Path: <linux-fsdevel+bounces-15459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CE288EC1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7E12A6068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2C14D70A;
	Wed, 27 Mar 2024 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzMpBdPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FF14D42C;
	Wed, 27 Mar 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559269; cv=none; b=qffmgCqN3SwUwOGZ2RiHdX/9/VazpiCewBF8NfkKD7Z5MCg+kv4flKGN0o0cuPw596qV3XPg/jtUjLt68TgInr/NCYZDhSt6Wpc8hXcmZc5gtOOVibG5TK6f2eA1frchkB7sggK0cYqNDLN2dV0hGbpwDeWh89guF62pkm7PTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559269; c=relaxed/simple;
	bh=U3RtwDtYT0yTxSKO6jZYN50WHbzBfyI8DDoY9EMQLEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf8nDA1RRLueQ0AqKIAEzJ4wwfC7Gf++T/QvBS4jftj47b8HKDUwWIpRbdm4P3Bnuf/UM5fVppfIED2sSruXLSApeVubCVfInBuo09Tql8zAMK0hK3Vc8nhVGTDg1v7l5RONEJSqYtYW6O1n967LYsB/t/gEz11oC6vh0lfXOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzMpBdPr; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so87518701fa.3;
        Wed, 27 Mar 2024 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711559266; x=1712164066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3W9HxlOS8+3sB9E9Q/EKAZYL+1+tFa3XLjifQ5VaP8=;
        b=PzMpBdPrOUprubMwE82WHWnN/hDbi+TYkZE8f2W2ULHCvzjfkcq0hbJY6w1yHy/k7v
         p1/A5W9I+50AmxOPkclIZ5F4WM1aPp09RUiL3ACvuaSNMnVIyZrOU502Duh1jAPW1p6/
         KJqMIOEtOgBauJnaw55HKjbr2oh89FfFzNOWBpL5vjaBfccBRmlaqb7LpwluCtO/LzqW
         zW4ZV1OCJOIOLRR3P//cTkNS4djkfKQkYr7LPkYTAlf7qvsFirTuaQTJFhpYDZBbPnlh
         HN/GAwZ2Y8YaO2jYeWV+lb7WA6WkJAUn2Y+ja6gcR6YhiCw7ehaOxVUvMFEJhAcTrK/I
         dEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711559266; x=1712164066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3W9HxlOS8+3sB9E9Q/EKAZYL+1+tFa3XLjifQ5VaP8=;
        b=mAoUqcWLAK39/Ha08NxQLHwH9hfIS44U9u/sXbDVYUiCEqZRc0hec7q0A8rA41+5a4
         mMUrg2nl7HqZxAkePfVBAgY1cViFdpK05HetEraR68jjfGPhcTKzV06/VxJqIJ6jinp9
         4ev/eYd9o8UATO7CnHasHgpo2GBb+IpEZDrA6cjo7/op4qQ8ENyfe38xW6MNAMEyEAWV
         N5uT1OSjH9A56hM96sHhVKLU3WE4uDc3wCgRdOUz7IOw+fPRKMTglV/3iTx72MaPobEX
         dWwbWkQkR/ndu9KuvjufI0lqKzNwrJ/pCCDCRjuPAGaiGtOLgSXGlTBFgex7DNNXkshg
         jNlw==
X-Forwarded-Encrypted: i=1; AJvYcCW7wAFM9S3RIcTXD4dqkPIV4qlINbyRuJo22e2d3uPrxUdQABBbg2RT2EIrnK4AAuDqbFrHkm3ij0eSMmhIF71JzsmsETgF8Zj4/YwyQ5HIaxM26MJlNcXcWSK5oOx/s1QBY0/mZyDN1ANoCi4SGd0zPMakeYD/8ZnavP/ya3+kAwDpZPi5v/w=
X-Gm-Message-State: AOJu0YxVHBqWbMy6Pe9ntRzjCUWnwCcRS3BC5O9BFpCsLpczhzeCQcxY
	IP9SIvsdWEWyd0yOk+Lfy4JRWs099INczukeJxkyJeNWs9d/pMefJrjgG1S2hw9Rr0RGUgRUu2w
	H1n+a3wvRLSsIZ+ey9/jFukZApmRmm3/v
X-Google-Smtp-Source: AGHT+IGTg5b59WH8c8XtI5m2cG3wee2fpMVNEMOz66Fi2woYZqA5DNodHPMRUJZFSv5qC/pxlAFtlSdBLcT69HeFDbE=
X-Received: by 2002:a2e:a721:0:b0:2d6:e7b6:f5da with SMTP id
 s33-20020a2ea721000000b002d6e7b6f5damr428989lje.29.1711559265398; Wed, 27 Mar
 2024 10:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2305515.1711548804@warthog.procyon.org.uk>
In-Reply-To: <2305515.1711548804@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Wed, 27 Mar 2024 12:07:34 -0500
Message-ID: <CAH2r5mujc2dPCTN15DqoDJXkg8wOUaZbpDZ562CHsStZmuAOUQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix duplicate fscache cookie warnings
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git (also added Fixes tag) pending testing

On Wed, Mar 27, 2024 at 10:00=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> fscache emits a lot of duplicate cookie warnings with cifs because the
> index key for the fscache cookies does not include everything that the
> cifs_find_inode() function does.  The latter is used with iget5_locked() =
to
> distinguish between inodes in the local inode cache.
>
> Fix this by adding the creation time and file type to the fscache cookie
> key.
>
> Additionally, add a couple of comments to note that if one is changed the
> other must be also.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/fscache.c |   16 +++++++++++++++-
>  fs/smb/client/inode.c   |    2 ++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
> index c4a3cb736881..340efce8f052 100644
> --- a/fs/smb/client/fscache.c
> +++ b/fs/smb/client/fscache.c
> @@ -12,6 +12,16 @@
>  #include "cifs_fs_sb.h"
>  #include "cifsproto.h"
>
> +/*
> + * Key for fscache inode.  [!] Contents must match comparisons in cifs_f=
ind_inode().
> + */
> +struct cifs_fscache_inode_key {
> +
> +       __le64  uniqueid;       /* server inode number */
> +       __le64  createtime;     /* creation time on server */
> +       u8      type;           /* S_IFMT file type */
> +} __packed;
> +
>  static void cifs_fscache_fill_volume_coherency(
>         struct cifs_tcon *tcon,
>         struct cifs_fscache_volume_coherency_data *cd)
> @@ -97,15 +107,19 @@ void cifs_fscache_release_super_cookie(struct cifs_t=
con *tcon)
>  void cifs_fscache_get_inode_cookie(struct inode *inode)
>  {
>         struct cifs_fscache_inode_coherency_data cd;
> +       struct cifs_fscache_inode_key key;
>         struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
>         struct cifs_sb_info *cifs_sb =3D CIFS_SB(inode->i_sb);
>         struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
>
> +       key.uniqueid    =3D cpu_to_le64(cifsi->uniqueid);
> +       key.createtime  =3D cpu_to_le64(cifsi->createtime);
> +       key.type        =3D (inode->i_mode & S_IFMT) >> 12;
>         cifs_fscache_fill_coherency(&cifsi->netfs.inode, &cd);
>
>         cifsi->netfs.cache =3D
>                 fscache_acquire_cookie(tcon->fscache, 0,
> -                                      &cifsi->uniqueid, sizeof(cifsi->un=
iqueid),
> +                                      &key, sizeof(key),
>                                        &cd, sizeof(cd),
>                                        i_size_read(&cifsi->netfs.inode));
>         if (cifsi->netfs.cache)
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index d28ab0af6049..91b07ef9e25c 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -1351,6 +1351,8 @@ cifs_find_inode(struct inode *inode, void *opaque)
>  {
>         struct cifs_fattr *fattr =3D opaque;
>
> +       /* [!] The compared values must be the same in struct cifs_fscach=
e_inode_key. */
> +
>         /* don't match inode with different uniqueid */
>         if (CIFS_I(inode)->uniqueid !=3D fattr->cf_uniqueid)
>                 return 0;
>
>


--=20
Thanks,

Steve

