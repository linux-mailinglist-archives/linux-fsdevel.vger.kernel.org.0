Return-Path: <linux-fsdevel+bounces-63789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F1BCDD19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615F4406502
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345022FB0AB;
	Fri, 10 Oct 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAjzMCP6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD92FB085
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110864; cv=none; b=LGnCri0U7jYyAHbPXjFyaE3unh6JlrwGU8cx/n4JRifPiZz0qGmxfcx/viseOhG2m5l2Kd+Kx1bcmkgS/VgflUPZ3e7JeKHPzHkiqupvj7gss7IXhJpF1AI1HgjENKo6iErpiLgHyOFli/xx61wSxWnPhjEPrZO8KrXy5EetQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110864; c=relaxed/simple;
	bh=xOJuDOIlas451FiXAAHgBhsNRzt6HStLrb4Y3mKzjBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBUfvyORGCNUpiqfOcCnjn3xaQgcZK6aTOLsrDNYbDwOwIsqCjtXLJ3rNqvx+RtYBzV0Q6JCbR08Uj7PaKTsbI+ca2eXfxXNDXiUMReW6v/WYI+iXuJJ8pjO0NzlLBoEF0c7tfeBtouCWp7xmoo/+RyD0JADso0QH0ptgdcKCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAjzMCP6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso5128162a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760110861; x=1760715661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNrx81VuCOUnlOhs53ChqFbGZmsPkwHURyqTboyD4SA=;
        b=HAjzMCP6WRFHv/sreS1KWvOy6uXorsCkmnygvRunN2bqmGbBktPhZ9U6HGiqyMP0cZ
         vcYM6+1DmRsf5UmsVPkExeA4WxM6kbNyB2VNxeu4ENsh3hpq9Wt6RuMc1X8lZ7HSIaWs
         EqIktZDYJcyX5J8DP6WL/i/WTfjV7NdvFv/trIlSgKJyMxW0Aisbc1WLCgoTmSmzq2tU
         4rcf7rzcR3yi7nRiW4ojKWvGw1hg2qy38twmbdGmAAtI2oCDGcmLTkDX+d1WAmlwHDBy
         KkHR6uV/go7sPmZTc+/dBMRFzIs+gbgdJBlT9wfbYDR3m+TfJFt+zxi0ii5lQeVsCD/E
         0i0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760110861; x=1760715661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNrx81VuCOUnlOhs53ChqFbGZmsPkwHURyqTboyD4SA=;
        b=CBWzXFuY7rBko7gGyNfVdpVmv2JJF+EZa5y9uENBejFz4LuZWadIPnS5k3n7WocyjF
         wJSjSN+vYVWsDi8tfx4axRs23glRetOhM4+JR3r3828tjw+ZwpsV+ibtdBdDKRc1g6XC
         l/1DEGNXl+NBjzITUyj5x43kxqiySMWQSPC+Dcdxiop5DonDGMccQE+98jMz5QYzkT+p
         hxUYezqdCJ69vlEIlRgBHH29+fdyf5/x0ThoaXm8kE53C3abNUBCBVOv0hMOLE8gYpbH
         0e91bP7Bnj+YKd/WOIl3K8Vf0OpSPqLm2UsSAY2cjIYHWaq5gQwm1nhgDfhWwurLJVHf
         97eg==
X-Forwarded-Encrypted: i=1; AJvYcCU07drajk286cHReeTB1RHkzjjnhakAErqat04HhTvt+l5u5mx9mXkUH+W8xXMvNobysYMxlBanoU8XQDQf@vger.kernel.org
X-Gm-Message-State: AOJu0YwEw84HsIipqkG+PS1OsPC3SgKTGXUbDNwfGgQl0LFKz0gCZQTw
	bFIMgM0lRJjd/c+p7+XjA4UzErpqj148/LUOYX/oHB9GM/t8AYcNaK0C4CWPhfS3tOQicyqlOzI
	FJ0auZhxsH5UqR90dxo6Dh7ErcoHLBYQ=
X-Gm-Gg: ASbGncsZ2gdaDrI11E7UaaNnxhXDJ5eNu+ZzEitR8CEKfOQZlD5dl7MBuuCsNNh46y9
	1CxfHUvazvjSJwk3ogeMsON5mLHYQM8QXFx07YG3+S8efDUNERxU7iFSRItkb7rNqfJvNNWG51L
	XQURMRw1F5D/GhTVXn3mb0im39b+PH/vLPKD8ukYPp2O5XeGItxnaap0lKNDKr85Xe/pHoaVLKb
	mdRB7WwWtGNrAXn9oheDGXFFmdA2B2cd/rX0JZ4Uf8rlXhPhPOhUUM18qwVQ4UfYQaU
X-Google-Smtp-Source: AGHT+IFsVwlKz3dpQMSn0djeXDN0dipdKA/kgBAE2NxkawkzYdINOsshggkYLd2MlBJ2D7HcedRqmChtEct9QlvTNTA=
X-Received: by 2002:a17:907:3e2a:b0:b2a:47c9:8ff5 with SMTP id
 a640c23a62f3a-b50bd050daemr1405146466b.10.1760110860769; Fri, 10 Oct 2025
 08:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009075929.1203950-1-mjguzik@gmail.com> <20251009075929.1203950-14-mjguzik@gmail.com>
 <ua3koqbakm6e4dpbzfmhei2evc566c5p2t65nsvmlab5yyibxu@u6zp4pwex5s7>
In-Reply-To: <ua3koqbakm6e4dpbzfmhei2evc566c5p2t65nsvmlab5yyibxu@u6zp4pwex5s7>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 10 Oct 2025 17:40:49 +0200
X-Gm-Features: AS18NWBB3Bmc7XAi8sS7M18NKhoZbvSirs7my7gPJLr4eYk4Rf7Ljkokn3EGE5o
Message-ID: <CAGudoHGckJHiWN9yCngP1JMGNa1PPNvnpSuriCxSM1mwWhpBUQ@mail.gmail.com>
Subject: Re: [PATCH v7 13/14] xfs: use the new ->i_state accessors
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 09-10-25 09:59:27, Mateusz Guzik wrote:
> > Change generated with coccinelle and fixed up by hand as appropriate.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> ...
>
> > @@ -2111,7 +2111,7 @@ xfs_rename_alloc_whiteout(
> >        */
> >       xfs_setup_iops(tmpfile);
> >       xfs_finish_inode_setup(tmpfile);
> > -     VFS_I(tmpfile)->i_state |=3D I_LINKABLE;
> > +     inode_state_set_raw(VFS_I(tmpfile), I_LINKABLE);
> >
> >       *wip =3D tmpfile;
> >       return 0;
> > @@ -2330,7 +2330,7 @@ xfs_rename(
> >                * flag from the inode so it doesn't accidentally get mis=
used in
> >                * future.
> >                */
> > -             VFS_I(du_wip.ip)->i_state &=3D ~I_LINKABLE;
> > +             inode_state_clear_raw(VFS_I(du_wip.ip), I_LINKABLE);
> >       }
> >
> >  out_commit:
>
> These two accesses look fishy (not your fault but when we are doing this
> i_state exercise better make sure all the places are correct before
> papering over bugs with _raw function variant). How come they cannot race
> with other i_state modifications and thus corrupt i_state?
>

I asked about this here:
https://lore.kernel.org/linux-xfs/CAGudoHEi05JGkTQ9PbM20D98S9fv0hTqpWRd5fWj=
EwkExSiVSw@mail.gmail.com/

> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index caff0125faea..ad94fbf55014 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1420,7 +1420,7 @@ xfs_setup_inode(
> >       bool                    is_meta =3D xfs_is_internal_inode(ip);
> >
> >       inode->i_ino =3D ip->i_ino;
> > -     inode->i_state |=3D I_NEW;
> > +     inode_state_set_raw(inode, I_NEW);
> >
> >       inode_sb_list_add(inode);
> >       /* make the inode look hashed for the writeback code */
>
> Frankly, the XFS i_state handling is kind of messy and I suspect we shoul=
d
> be getting i_state =3D=3D 0 here. But we need to confirm with XFS guys. I=
'm
> poking into this because this is actually the only case where we need
> inode_state_set_raw() or inode_state_clear_raw() outside of core VFS and
> I'd like to get rid of these functions because IMHO they are actively
> dangerous to use.
>

I'm going to address this in the other e-mail.

