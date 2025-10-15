Return-Path: <linux-fsdevel+bounces-64202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8696BBDCA2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 07:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7465F4F1501
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 05:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E218E304BD3;
	Wed, 15 Oct 2025 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adq31IJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783DF2FFDD3
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507215; cv=none; b=aZoHAzDF2S24WN0R0jzEmODsc2qwzcjlbbQZAme3Ad51XzxXRxbAFjjuJuvPGvbC0piSQ3xFq561WAw5xkLowo0tCASauhjStzeN9qSSCOuOIXHumaLeN3oNB/dyEm9LTVtEs1nqVONJEvxcMImNHXp8Yu52d7IJoW3jFcFicRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507215; c=relaxed/simple;
	bh=L9yQzwfiK6AnAj53w+M42/OMTEMETYOV7eUVo5HxABI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elzqGkmkQ3ih9EhJLzV8vKJ/5a46eiSGbFFvm7sf/HBkvSkScnZtlpM9nNNsBDWMAyhNW5f5izVV+26tj8Y7CCnBDCv7uNYXXTFY7guiviHQC64SptDDlgeuNcYkhOHVtNwEC6Qgq8omlSNMFu9Uz3Vg6jFtGMrKcz+9PvSkYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Adq31IJP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3da3b34950so1000436566b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760507212; x=1761112012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB/8HRPSkZavRfQHyIpXrXhIqH5dcxDgrAKATWLCf7Y=;
        b=Adq31IJPv30T6zUoF2y3H73X7Rg3/pWXDTmdnh8kEFGnxj427QLrLxman9/5UI5W2U
         /BfcMAJFP39b/qTttenN83pLLoKQgHruzLRnAyI7r33JHzbAxexU4Hz4JiFgvuSvRjJE
         S++28Isa33yMokJkwd5NGNEH7zm9pAspIgg8tWWicxPMILY3fP7EpgtkzrPlnN9oCzqo
         SQu04Tg9CVpi8kJtTRzyZWVdYdhZeaWchM2nnDVNUJKPESyQa0SuKLSXQM6tLXz/b52R
         uQ3D4kBfWD7qTw59FT/+Jkb7USrhxoKZYNVLTLXfM7hILg+wbYpzLX/4KHTjP7OIQI4C
         +66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760507212; x=1761112012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YB/8HRPSkZavRfQHyIpXrXhIqH5dcxDgrAKATWLCf7Y=;
        b=PDSmPNfuRhMLWSWmZoLLXFV97NiwhZkhfCBP1STV7jhN/yRoF5dm2bH6iLA6e+0rr9
         5R6owZUjxoF0fLcxxxJMAcNOgVfFUZVy/rqmL7frYW0FVZQBdWb+zuKkF2qjgHYD/bhp
         MN8jJhnzSZ7B9nm3qnt1S7nuTLfyn7pyiSaEo5ta7NQdQcs62LEDckcU6GalXsZoyvzv
         a8oYisiH6RI+JpbI23zpihYZJeljeo5zc2EdVNS48kDUlaXuaZ8NW503mQ50mn2CwrLD
         f09tlBClHnDgNAw6/rv16rvAsC1+PRg8K5wKFnWhAWmavMycbrZ48zochFO2UJINpG/M
         VOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEmCKQAC336dJgKOmTN9VZSUJ9QLFIf1lStbpi7JznyKEITSsgy5RoVm4AjIp84QFYO5padwAptYL8fqaC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwqkgx8CZOo5fIqUfJie3h8fQcc5QYAGloH1BaLTBWHRyvG0XR
	6LaFuSn92To/BcO9uB0ZmtdTzpuv9XJc9ed6RbLbXZIaYoxtyPujvs+/PH5/qOp5llj/93YFC5O
	P8E3SvJlxm+1lHnwvmT/3Y/RW00z5yX8=
X-Gm-Gg: ASbGncsadMf9EKj4lGLe/7z63mTU0Eg813TIY07qkDcY7P7H/u+o0vFTM6C6e9uhU1W
	08uniYoK2AQd8T0r5PHMRly53rd9DGXav5cEKUW6wY+y33LP6rhEgBsq9axyBBpeSlqrofsE6o1
	9nRgjbF0XLOjLH4UTNQDHIraWSkWsc08QaXlZAOxL/aJb8ZZqLZXAoq9RrSeVvfe3w8k7SAdtd5
	ofifSiXpLKej0aEggyn1w7YEXrNwShs+nl/yKinUde7kbjpc8JO+YqTIjSbHyQ4yCcH
X-Google-Smtp-Source: AGHT+IHBOaBguuSDBJ8tBqccd4wBxjcgREccPEa2q0OFeN3z0LhFrlL5e17WKU2nQANyrLyL2KnfgEnaFifFE19VDgQ=
X-Received: by 2002:a17:907:72c6:b0:b46:8bad:6970 with SMTP id
 a640c23a62f3a-b50abaa43b4mr3121817866b.36.1760507211571; Tue, 14 Oct 2025
 22:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009075929.1203950-1-mjguzik@gmail.com> <20251009075929.1203950-4-mjguzik@gmail.com>
 <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>
 <CAGudoHFJxFOj=cbxcjmMtkzXCagg4vgfmexTG1e_Fo1M=QXt-g@mail.gmail.com> <aO7NqqB41VYCw4Bh@dread.disaster.area>
In-Reply-To: <aO7NqqB41VYCw4Bh@dread.disaster.area>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 15 Oct 2025 07:46:39 +0200
X-Gm-Features: AS18NWCB_4h8LHu2yt-FYyIBzUwuIR3RlLlbdhbf0H9i_Il0fvD54KG0vSEA_Mc
Message-ID: <CAGudoHFpoo0Qm=b4Z85tbJJmhh+vmSHuNnm3pVaLaQsmX9mURg@mail.gmail.com>
Subject: Re: [PATCH v7 03/14] fs: provide accessors for ->i_state
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:24=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Fri, Oct 10, 2025 at 05:51:06PM +0200, Mateusz Guzik wrote:
> > On Fri, Oct 10, 2025 at 4:44=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 09-10-25 09:59:17, Mateusz Guzik wrote:
> > > > +static inline void inode_state_set_raw(struct inode *inode,
> > > > +                                    enum inode_state_flags_enum fl=
ags)
> > > > +{
> > > > +     WRITE_ONCE(inode->i_state, inode->i_state | flags);
> > > > +}
> > >
> > > I think this shouldn't really exist as it is dangerous to use and if =
we
> > > deal with XFS, nobody will actually need this function.
> > >
> >
> > That's not strictly true, unless you mean code outside of fs/inode.c
> >
> > First, something is still needed to clear out the state in
> > inode_init_always_gfp().
> >
> > Afterwards there are few spots which further modify it without the
> > spinlock held (for example see insert_inode_locked4()).
> >
> > My take on the situation is that the current I_NEW et al handling is
> > crap and the inode hash api is also crap.
>
> The inode hash implementation is crap, too. The historically poor
> scalability characteristics of the VFS inode cache is the primary
> reason we've never considered ever trying to port XFS to use it,
> even if we ignore all the inode lifecycle issues that would have to
> be solved first...
>

I don't know of anyone defending the inode hash tho. The performance
of the thing was already bashed a few times, I did not see anyone
dunking on the API ;)

> > For starters freshly allocated inodes should not be starting with 0,
> > but with I_NEW.
>
> Not all inodes are cached filesystem inodes. e.g. anonymous inodes
> are initialised to inode->i_state =3D I_DIRTY.  pipe inodes also start
> at I_DIRTY. socket inodes don't touch i_state at init, so they
> essentially init i_state =3D 0....
>
> IOWs, the initial inode state depends on what the inode is being
> used for, and I_NEW is only relevant to inodes that are cached and
> can be found before the filesystem has fully initialised the VFS
> inode.
>

Well it is true that currently the I_NEW flag is there to help out
entities like the hash inode hash.

I'm looking to change it into a generic indicator of an uninitialized
inode. This is completely harmless for the consumers which currently
operate on inodes which never had the flag.

Here is one use: I'd like to introduce a mandatory routine to call
when the filesystem at hand claims the inode is ready to use.

Said routine would have 2 main purposes:
- validate the state of the inode (for example that a valid mode is
set; this would have caught some of the syzkaller bugs from the get
go)
- pre-compute a bunch of stuff, for example see this crapper:

   static inline int do_inode_permission(struct mnt_idmap *idmap,
                                        struct inode *inode, int mask)
  {
          if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
                  if (likely(inode->i_op->permission))
                          return inode->i_op->permission(idmap, inode,
mask);

                  /* This gets set once for the inode lifetime */
                  spin_lock(&inode->i_lock);
                  inode->i_opflags |=3D IOP_FASTPERM;
                  spin_unlock(&inode->i_lock);
          }
          return generic_permission(idmap, inode, mask);
  }

The IOP_FASTPERM could be computed by the new routine, so this would
simplify to:
  static inline int do_inode_permission(struct mnt_idmap *idmap,
                                        struct inode *inode, int mask)
  {
          if (unlikely(!(inode->i_opflags & IOP_FASTPERM)))
                  return inode->i_op->permission(idmap, inode, mask);
          return generic_permission(idmap, inode, mask);
  }

The routine would assert the inode is I_NEW and would clear the flag,
replacing it with something else indicating the inode is indeed ready
to use.

While technically the I_NEW change is not necessarily to get there, I
do think it makes things cleaner.

Note unlock_new_inode() and similar are not mandatory to call.

