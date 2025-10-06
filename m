Return-Path: <linux-fsdevel+bounces-63450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E4BBCEC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 03:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA8188F3B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 01:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938219E99F;
	Mon,  6 Oct 2025 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN7+/dor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C75E81ACA
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759713420; cv=none; b=WfEUWq1A7s3FMBpv0zqZm6AIQWTYDinVFOsWetkIUphVMVpx22HHAPC3p9KE8rWlZiOZmkilJZXC2nuZfEtgOC2/hjP3+Nws/mDYs2OsXVEXSNzFk50bWpF/s9U9gbZPx9HwGuLdapXgBzckVTbRqUSewp8SCua3Wjv+AAqGZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759713420; c=relaxed/simple;
	bh=0UGJqdPjjCSY04L6+CBMhmuXVEBK1Sf1gwPF3gCekqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUIZDjzsk099XUt0ARUd+fGTb52TTlcE4qPd8H5VgwzPRZ3PDmSU9WOrYuYN6I0PDcKIo26VVbAypcK136I9L9IDvRYzGgKdYXdSAYLLGMspTu4FmiBrHStrDqStYdJ3c7RmWpvt5APggwMTEb4fki/v/NWed/fP3M4bgr+ooMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN7+/dor; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-637e2b86240so7363466a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Oct 2025 18:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759713416; x=1760318216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbC1EOPE95OwfWLT6nyxetzcSIKUAu0yCntrWn74xYs=;
        b=EN7+/dor6Zz+YDCMvkpkxQuXNnZA4VzY3+Jmj10izNyWgh8idoIE4ia+flBqQEpgt4
         aNKK2Mq+ackEhZ7drG+ab4/iMKeuiHmfpH9j1qsfJ537yRegXOOnX6k00FGxkLO/hBQo
         3j1OHUB8GVTCPoNtytggr0ZJvkd3EgbWDii3hV5umzm3DnBP0YHhkc+AEjQclqwvB/lc
         UXdwObSqwvGFWpH6EoasPDI2DBNlqKiAsXQeZ1sPDHlwCf3gLcKkdfUye4j6qf4OLtP8
         pTHVFTHKlIsUMWqjF4i2b2154RGvIPZdPQmEFZiOXMP/5KGN96waoRxYLJcAtp3vU4ej
         IbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759713416; x=1760318216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbC1EOPE95OwfWLT6nyxetzcSIKUAu0yCntrWn74xYs=;
        b=YxmMGuZz0PIcjMVGo56ixOBsEkKYbDVMeF5RdtxNNs1Oyz8K2UtPuN6Xicah8AtQjX
         4MygbvCh18JLdgvA+y5GbI1aoOG2yG+E8eUGDEeX751b+hqCqrIBrjD/iAkq2+TEqNKI
         Lw5WTYAUR244FaYBh2tTKJD4jN/gua/cIfm00zMxzvfmlyi5QeEL1bv3gj69ZgOtq0CU
         DQH7xuZ/9TPXUkWuhBRhXo2fBFRchkR3VoDPszW1Vm78QvKAs8xC8g1FKLK0KJ6APgNg
         HMyUnuwF2fZkZR/pKhABKVUxI2Esgpxok5BXTVGmAEId6FdBXqXncYyApYc+wh91GpLJ
         9LwA==
X-Forwarded-Encrypted: i=1; AJvYcCUcrDJ6vL41K//EmLVohXDVL3wQ2jUPdaXkR7wB/MoOwSJFbN2DX0KWx9+W8pmFzfGVM+wiXrP45SOSD9UP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2IaM9IfsB+hWnvuWRjujFC5nRcY4N3GdOIRun4bG8BebKzaJM
	zX7EB3s5DjBQiG7aMuNOQzVMozAAT4eUSc6ESCGJOlHu/uLdybtjBZKc28cil8V9+Dal/uCJxTm
	SgXcVy65uKdod2fkgt02KGP4vlXIz/iI=
X-Gm-Gg: ASbGncti86LsfzLDH8KYG7++hLn8I8Ij6adpybSFy2YOGo3aQ12tNtvo7pXHfLAf4ND
	viVRrLxyTbFzOzS3VhXfqWpgupy47xbOGienu4Df+Ldfu4oO1cJxwrFs7lJa+1f8hbXFojXnAe7
	3eDfG+hLyUZIAsJrsetW/kSKa3tbLsGmVtTSX5fp5t5R1lvle2CpzSzmCGnFMjyqQwOh3eHNdId
	Fqqam6QA9yfeEKi/kvsFTArYdCl90cLKA8eOR12ZSNMysHUdjwHEsvy20cUdg+rSlV3nRxH2A==
X-Google-Smtp-Source: AGHT+IEN51PEeSTCF3pWahfeOfpD9DykFpJzQEp+le9DBdwXfyV2kiw7brjPn8wm9xu5wGh5W76O7auORpiPFFlU+5Y=
X-Received: by 2002:a17:907:1c84:b0:b3b:78a7:6220 with SMTP id
 a640c23a62f3a-b49c4296104mr1414678266b.55.1759713416142; Sun, 05 Oct 2025
 18:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005231526.708061-1-mjguzik@gmail.com> <20251006005642.8194-1-hdanton@sina.com>
In-Reply-To: <20251006005642.8194-1-hdanton@sina.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 6 Oct 2025 03:16:43 +0200
X-Gm-Features: AS18NWBfwgOLHulFdJnl7zfAPTI5kQEdChxeEzyE56yQDRW-IlZ1BRNNakFCakE
Message-ID: <CAGudoHFi-9qYPnb9xPtGsUq+Mf_8h+uk4iQDo1TggZYPgTv6fA@mail.gmail.com>
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
To: Hillf Danton <hdanton@sina.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 2:57=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On Mon,  6 Oct 2025 01:15:26 +0200 Mateusz Guzik wrote:
> > Suppose there are 2 CPUs racing inode hash lookup func (say ilookup5())
> > and unlock_new_inode().
> >
> > In principle the latter can clear the I_NEW flag before prior stores
> > into the inode were made visible.
> >
> Given difficulty following up here, could you specify why the current
> mem barrier [1] in unlock_new_inode() is not enough?
>

That fence synchronizes against threads which went to sleep.

In the example I'm providing this did not happen.

  193 static inline void wait_on_inode(struct inode *inode)
  194 {
  195         wait_var_event(inode_state_wait_address(inode, __I_NEW),
  196                       !(READ_ONCE(inode->i_state) & I_NEW));

  303 #define wait_var_event(var, condition)                               =
   \
  304 do {                                                                 =
   \
  305         might_sleep();                                               =
   \
  306         if (condition)                                               =
   \
  307                 break;                                               =
   \

I_NEW is tested here without any locks or fences.

  308         __wait_var_event(var, condition);                            =
   \
  309 } while (0)

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/inode.c#n1190
>
> > The former can in turn observe I_NEW is cleared and proceed to use the
> > inode, while possibly reading from not-yet-published areas.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > I don't think this is a serious bug in the sense I doubt anyone ever ra=
n
> > into it, but this is an issue on paper.
> >
> > I'm doing some changes in the area and I figured I'll get this bit out
> > of the way.
> >
> >  fs/dcache.c               | 4 ++++
> >  fs/inode.c                | 8 ++++++++
> >  include/linux/writeback.h | 4 ++++
> >  3 files changed, 16 insertions(+)
> >
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index a067fa0a965a..806d6a665124 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -1981,6 +1981,10 @@ void d_instantiate_new(struct dentry *entry, str=
uct inode *inode)
> >       spin_lock(&inode->i_lock);
> >       __d_instantiate(entry, inode);
> >       WARN_ON(!(inode->i_state & I_NEW));
> > +     /*
> > +      * Pairs with smp_rmb in wait_on_inode().
> > +      */
> > +     smp_wmb();
> >       inode->i_state &=3D ~I_NEW & ~I_CREATING;
> >       /*
> >        * Pairs with the barrier in prepare_to_wait_event() to make sure
> > diff --git a/fs/inode.c b/fs/inode.c
> > index ec9339024ac3..842ee973c8b6 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1181,6 +1181,10 @@ void unlock_new_inode(struct inode *inode)
> >       lockdep_annotate_inode_mutex_key(inode);
> >       spin_lock(&inode->i_lock);
> >       WARN_ON(!(inode->i_state & I_NEW));
> > +     /*
> > +      * Pairs with smp_rmb in wait_on_inode().
> > +      */
> > +     smp_wmb();
> >       inode->i_state &=3D ~I_NEW & ~I_CREATING;
> >       /*
> >        * Pairs with the barrier in prepare_to_wait_event() to make sure
> > @@ -1198,6 +1202,10 @@ void discard_new_inode(struct inode *inode)
> >       lockdep_annotate_inode_mutex_key(inode);
> >       spin_lock(&inode->i_lock);
> >       WARN_ON(!(inode->i_state & I_NEW));
> > +     /*
> > +      * Pairs with smp_rmb in wait_on_inode().
> > +      */
> > +     smp_wmb();
> >       inode->i_state &=3D ~I_NEW;
> >       /*
> >        * Pairs with the barrier in prepare_to_wait_event() to make sure
> > diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> > index 22dd4adc5667..e1e1231a6830 100644
> > --- a/include/linux/writeback.h
> > +++ b/include/linux/writeback.h
> > @@ -194,6 +194,10 @@ static inline void wait_on_inode(struct inode *ino=
de)
> >  {
> >       wait_var_event(inode_state_wait_address(inode, __I_NEW),
> >                      !(READ_ONCE(inode->i_state) & I_NEW));
> > +     /*
> > +      * Pairs with routines clearing I_NEW.
> > +      */
> > +     smp_rmb();
> >  }
>
> Why is this needed as nobody cares I_NEW after wait?
>
> >
> >  #ifdef CONFIG_CGROUP_WRITEBACK
> > --
> > 2.34.1

