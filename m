Return-Path: <linux-fsdevel+bounces-60286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86330B44297
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 18:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AB804E5FA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0122836C;
	Thu,  4 Sep 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVKR3Que"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51422258E;
	Thu,  4 Sep 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002941; cv=none; b=a0j9iobPxB68xWr6WO1vJgo8EHWFYdc6DGKV7KwcRuezPCnNH7Tq/uG4S7bIdjB4ubgOLi5fXTIrxPXXpJp38TxZWbObDfAE7CHgZ5HXJIckOoRNUey1szFc+jHMviuGcwQKVVZrSB6eouNEmUTse/MeUp+jxa4nkMk0kjiz+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002941; c=relaxed/simple;
	bh=HjBPjB5ArJqguGUkE7A/EfzLjoQtb89LG6iJJSddvYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzcgOzSGTwY5oe0fVl+7LZBcpDH/NT4DYPbTjNUeTCv8ApsF1AkyqQHDc9tGXqd00k8z451G186otmZNYb6Fjqjc8z8a44C5vCRS4Wz/RKtZsbc/BWjw5kT/9MFmj5guD9dAMAxiHAxIyVBfN54ic7zVQ0qg3knxS2A54S5T4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVKR3Que; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so4225344a12.1;
        Thu, 04 Sep 2025 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757002938; x=1757607738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln19k5HIVCTrZNYe3Hu/5sJk5ZWqRmSGUkTSvpX2syA=;
        b=ZVKR3QuemWyPvEU3fdNj/r+WvPXU8Vx2ckJcFoIql5TZhh0GsTWPmOFP4Nuzs+I1vB
         JNr0RM/Gs4XhKFq3DZ3kc+ZQ1pts828n/+Iv8Fy92LhWEZfLkElkmS7hTODkD5bKF0fg
         d1sOlhsQSc5UcWJptt9hictEQSHsgCsrrYAjuBgC3s/8sFSdYPUQ9XYWazQv2l5xlW1c
         wv+cfW8RdzluQS8exLb1UCniydRSBqRBT6FeKl/ZAbUJcajHpL68F5FFjBVWBwJ7CinC
         kj+1G9lwCyUtLAprHEOL7uRIiGj/bEewZFsJJZ8viyxdJ50v1adcA8OudtSiBRO6KDd5
         ixUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002938; x=1757607738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln19k5HIVCTrZNYe3Hu/5sJk5ZWqRmSGUkTSvpX2syA=;
        b=d0+Ibgi3EB0LaqONmQNKeehpH3/fOd8Ik9mBCeuERxlxBoPSNTufilmAz8uouRVU50
         Hx3HxtlwpFqml+dbMtkWp67CmDAHe5vtAbcGS3ISMTVhIEovBNBCAZJQj7QnI+bXvbim
         JQc1WzcnhIH8QjzEKATUeGY9eCqO3BwmX4mqw6EXerGwHaQdWezdYugzaMILUXEkntIY
         GMWsqDqZ+SHbQlbcfoY5R2pAObKP6RLy0lOot/jFTrfvAhsXiIo0PqhR9SVbL4dVnOdF
         9ya/dCccjqMtkzTghSLyQ7q3c69XBeZjfimF36cQcBMecPr2jspn3Xu1XJsuw8dQMDj5
         k4qw==
X-Forwarded-Encrypted: i=1; AJvYcCV0f2uEZe/C1pp9JWK3VFLBt/q0jZdfU5XW+PzsRn683D/zMSrfT4ZupXMge83tBjVRB2Xss8XkBkdPSIWj@vger.kernel.org, AJvYcCWPDNT97c5W7F1EGYYBvaJQlUZTprStdSwFmDKDXD7M9DTtnT5Y3evf75RwTgkwY+UhShp7L/Kdm2wcDVDL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72AWkxl4T8yF6Y8xw/9ay6IR56xpY1Lz2NNJjDhma+loWqSSX
	OGfn4wgsi60n0LWX+bqSkyX1lUtF0bCRCbrAy5m6fF32kExjCkt0kJr3K37h4vHoEFd6YmK64D8
	LHWlCTbeGnSd4E8H6y/OIenG0Q2werfg=
X-Gm-Gg: ASbGncuneLnsTpr9vR9XWaGmPJLptx1HPwk6G7Tm1wwYOO3b3lwYCep67/DjD0nyyE/
	zqn5A9wSNRPknGe3yC0L1PTLED/bZ6135eYA79Uk/sDqtS+h1e4gDxyy7FbMhuSeM91xWWQ+qC8
	2dp9eLo2rHz6h2GfTXbgs4E0lQVdOp/sXlmZ2nrtngb4u05l0bwo9tsggQw9TZ4qjMaGHjvfOEl
	MruDLtyu/xI3aFzxg==
X-Google-Smtp-Source: AGHT+IHJi8UpPu8PzTuQMPgcR1ei63f/ToXw+JJAMwxnczWiy4DXVu6/hlnIKBLecG2Q0yk9yZZQ/Sp6LmPjYsuIPwA=
X-Received: by 2002:a17:907:96ac:b0:af9:479b:8c80 with SMTP id
 a640c23a62f3a-b049307e70dmr31746366b.4.1757002937485; Thu, 04 Sep 2025
 09:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <766vdz3ecpm7hv4sp5r3uu4ezggm532ng7fdklb2nrupz6minz@qcws3ufabnjp>
 <20250904154245.644875-1-mjguzik@gmail.com> <f3671198-5231-41cf-b0bc-d1280992947a@oracle.com>
In-Reply-To: <f3671198-5231-41cf-b0bc-d1280992947a@oracle.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 4 Sep 2025 18:22:04 +0200
X-Gm-Features: Ac12FXwBugvq0QdQbGsOsp23BALPk_EtEydK0n6uUt0jZXkGwfPmz3oTa1qkJJc
Message-ID: <CAGudoHHT=P_UyZZpx5tBRHPE+irh1b7PxFXZAHjdHNLcEWOxAQ@mail.gmail.com>
Subject: Re: [External] : [PATCH] ocfs2: retire ocfs2_drop_inode() and
 I_WILL_FREE usage
To: Mark Tinguely <mark.tinguely@oracle.com>
Cc: ocfs2-devel@lists.linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, joseph.qi@linux.alibaba.com, jlbec@evilplan.org, 
	mark@fasheh.com, brauner@kernel.org, willy@infradead.org, david@fromorbit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 6:15=E2=80=AFPM Mark Tinguely <mark.tinguely@oracle.=
com> wrote:
>
> On 9/4/25 10:42 AM, Mateusz Guzik wrote:
> > This postpones the writeout to ocfs2_evict_inode(), which I'm told is
> > fine (tm).
> >
> > The intent is to retire the I_WILL_FREE flag.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > ACHTUNG: only compile-time tested. Need an ocfs2 person to ack it.
> >
> > btw grep shows comments referencing ocfs2_drop_inode() which are alread=
y
> > stale on the stock kernel, I opted to not touch them.
> >
> > This ties into an effort to remove the I_WILL_FREE flag, unblocking
> > other work. If accepted would be probably best taken through vfs
> > branches with said work, see https://urldefense.com/v3/__https://git.ke=
rnel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvfs-6.18.inode.refco=
unt.preliminaries__;!!ACWV5N9M2RV99hQ!OLwk8DVo7uvC-Pd6XVTiUCgP6MUDMKBMEyuV2=
7h_yPGXOjaq078-kMdC9ILFoYQh-4WX93yb0nMfBDFFY_0$
> >
> >   fs/ocfs2/inode.c       | 23 ++---------------------
> >   fs/ocfs2/inode.h       |  1 -
> >   fs/ocfs2/ocfs2_trace.h |  2 --
> >   fs/ocfs2/super.c       |  2 +-
> >   4 files changed, 3 insertions(+), 25 deletions(-)
> >
> > diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> > index 6c4f78f473fb..5f4a2cbc505d 100644
> > --- a/fs/ocfs2/inode.c
> > +++ b/fs/ocfs2/inode.c
> > @@ -1290,6 +1290,8 @@ static void ocfs2_clear_inode(struct inode *inode=
)
> >
> >   void ocfs2_evict_inode(struct inode *inode)
> >   {
> > +     write_inode_now(inode, 1);
> > +
> >       if (!inode->i_nlink ||
> >           (OCFS2_I(inode)->ip_flags & OCFS2_INODE_MAYBE_ORPHANED)) {
> >               ocfs2_delete_inode(inode);
> > @@ -1299,27 +1301,6 @@ void ocfs2_evict_inode(struct inode *inode)
> >       ocfs2_clear_inode(inode);
> >   }
> >
> > -/* Called under inode_lock, with no more references on the
> > - * struct inode, so it's safe here to check the flags field
> > - * and to manipulate i_nlink without any other locks. */
> > -int ocfs2_drop_inode(struct inode *inode)
> > -{
> > -     struct ocfs2_inode_info *oi =3D OCFS2_I(inode);
> > -
> > -     trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
> > -                             inode->i_nlink, oi->ip_flags);
> > -
> > -     assert_spin_locked(&inode->i_lock);
> > -     inode->i_state |=3D I_WILL_FREE;
> > -     spin_unlock(&inode->i_lock);
> > -     write_inode_now(inode, 1);
> > -     spin_lock(&inode->i_lock);
> > -     WARN_ON(inode->i_state & I_NEW);
> > -     inode->i_state &=3D ~I_WILL_FREE;
> > -
> > -     return 1;
> > -}
> > -
> >   /*
> >    * This is called from our getattr.
> >    */
> > diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
> > index accf03d4765e..07bd838e7843 100644
> > --- a/fs/ocfs2/inode.h
> > +++ b/fs/ocfs2/inode.h
> > @@ -116,7 +116,6 @@ static inline struct ocfs2_caching_info *INODE_CACH=
E(struct inode *inode)
> >   }
> >
> >   void ocfs2_evict_inode(struct inode *inode);
> > -int ocfs2_drop_inode(struct inode *inode);
> >
> >   /* Flags for ocfs2_iget() */
> >   #define OCFS2_FI_FLAG_SYSFILE               0x1
> > diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
> > index 54ed1495de9a..4b32fb5658ad 100644
> > --- a/fs/ocfs2/ocfs2_trace.h
> > +++ b/fs/ocfs2/ocfs2_trace.h
> > @@ -1569,8 +1569,6 @@ DEFINE_OCFS2_ULL_ULL_UINT_EVENT(ocfs2_delete_inod=
e);
> >
> >   DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_clear_inode);
> >
> > -DEFINE_OCFS2_ULL_UINT_UINT_EVENT(ocfs2_drop_inode);
> > -
> >   TRACE_EVENT(ocfs2_inode_revalidate,
> >       TP_PROTO(void *inode, unsigned long long ino,
> >                unsigned int flags),
> > diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> > index 53daa4482406..e4b0d25f4869 100644
> > --- a/fs/ocfs2/super.c
> > +++ b/fs/ocfs2/super.c
> > @@ -129,7 +129,7 @@ static const struct super_operations ocfs2_sops =3D=
 {
> >       .statfs         =3D ocfs2_statfs,
> >       .alloc_inode    =3D ocfs2_alloc_inode,
> >       .free_inode     =3D ocfs2_free_inode,
> > -     .drop_inode     =3D ocfs2_drop_inode,
> > +     .drop_inode     =3D generic_delete_inode,
> >       .evict_inode    =3D ocfs2_evict_inode,
> >       .sync_fs        =3D ocfs2_sync_fs,
> >       .put_super      =3D ocfs2_put_super,
>
>
> I agree, fileystems should not use I_FREEING/I_WILL_FREE.
> Doing the sync write_inode_now() should be fine in ocfs_evict_inode().
>
> Question is ocfs_drop_inode. In commit 513e2dae9422:
>   ocfs2: flush inode data to disk and free inode when i_count becomes zer=
o
> the return of 1 drops immediate to fix a memory caching issue.
> Shouldn't .drop_inode() still return 1?

generic_delete_inode is a stub doing just that.

--=20
Mateusz Guzik <mjguzik gmail.com>

