Return-Path: <linux-fsdevel+bounces-36565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C689E5F1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 20:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BF618859D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 19:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718BA22D4F1;
	Thu,  5 Dec 2024 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAlaw6i9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52A1B4146;
	Thu,  5 Dec 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428059; cv=none; b=lMOYx/SbyDAWMtV5PTepMAN0tDHmG9o3Ioir7RQj1VyTiVcX/Y8DxmgbqlCeYaoy+Z12Jii8eqLc4PBFnZ2jtK3/Yp8Go3hDUorYHvr6x1o4TeNH0dCC8OJHtd7mbMLRvbbBP/N0nEAMsbYU5qgpnG46fdfhVKGYAUr3erLrp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428059; c=relaxed/simple;
	bh=U+NzWU6qPZhveDoODE5oSlMX6qJWoy+vtnO36UczEis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEbFrdadsiBg74NpX5SuljwocbIiGOO29YAXc4E13RntIvNskFSeOZWTD86ftOO1eKEz36RV98wzxQSaW3LOOjXZ3xkYINF+R8hLFY8IrQ6/99pnJNosn9XtwiZ079/TzfMj3q8Yf5yD01IxWIrldnwu3vqSPf90tAGtl7sOmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAlaw6i9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0e75dd846so2028171a12.3;
        Thu, 05 Dec 2024 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733428056; x=1734032856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa8JXz2Or7aFZNVOAHMk6HZVrtiifRvMFum8+gNRtJI=;
        b=PAlaw6i97BgHJYOe91vdXhmOU47a8eDo3zXRhBi9rLBYrGOFiExqlqZP4yjYVBTIV8
         v+e9L/3N8cSWWSvWE+HLBrqCEmYRtcYkzcVs42VkDo4gkXkNlDHsWSKU6lGOIMcHK8W2
         o8Qx0j8P26yaXrqgi3eq8BsKuM1R2HAVUj5sQibta8Edqam8Mxn0hRc/0twW8mbTEBM1
         nB5o5W2DaOcJw7SJghUBovJyn9DvyUoNYrWz0Xzv37XYKUHOOwWEDYEXev1npeOSuEpF
         X3qcZDlwU8VDsVQYAHkqrqMm7eF3JBcOVBswvhBMgzjnhA0PSG8ypx795l49ixTwYbi6
         JnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733428056; x=1734032856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pa8JXz2Or7aFZNVOAHMk6HZVrtiifRvMFum8+gNRtJI=;
        b=LrLx5nXbZPZ6mdJQdU355KJmYCOfsBs2wmoTiaJexaz3/WfMn/mrpWh3B13Sy9MwfZ
         z2KfUCJE2qgDq1130OQrtDl09IxT1j+C2uWdsIH1Qb0Xpapa1+sVby7KwNHRAvOY1mEQ
         7rfU+iPhAJXdy4amsAGRI7nrERPV806/RuYr++ri8hr/H+uOiTDD3tkEkd6oITRx1DM0
         GPMsZCSxulITLM94UKdFK/zqCp0WmQLAGmOcBo5aoVf6H1wxFYmhuUyv0GB+zp49fQ78
         dohro7J3XNiZkrUCKEWLbQBrylYtz/mE1O/ULF7cwP/PXZCDybGMdSBNaDfKeyPJVVip
         3hhg==
X-Forwarded-Encrypted: i=1; AJvYcCW9UlMUfNkAm1hDkcyri02P3V3vH5W+p8fcDWl5onaXEzFqgnC4gOLwoZEfZa41JfQqyM8jRsX/DnJiix5/@vger.kernel.org, AJvYcCXySQN90gctlhsjRGedMsUuI4aeQcE0N1+OuyCZeX1ypu9Cq/UVKgvxxNMlkO2FgI9UOKQtPWzGvSP9yY9A@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPS0tektzw6U8/2iODUK2rKH0vJyFgZv5h7aul+yQaKcDE6iO
	SG0nFpTdKc714jEqjfK/e0FA9MpppGfXQZe4K+XiAa98hTfCSk6MoMfI05HR47bEJHdFeShqF91
	rT/ijitpPisaLkHyjAOPlbzPE3vG0Qtc7
X-Gm-Gg: ASbGnctskopwUFa2rPm9Xi42Iq4j4HlEsQ85tYpg+IYvrljmGpLIq99b2PYUEhqKtJV
	BJS8e5/2uLx80p+sBQ7jJkR/sMFd38A==
X-Google-Smtp-Source: AGHT+IETxt09KXItOSi0vLjsfVwFlZpI8WQ0nZDSG9Ni7GJE/X+S2jO66a61TI2TGs2Gp49SfWTDrVq2+Fkidrq17SM=
X-Received: by 2002:a05:6402:2113:b0:5d2:60d9:a2a3 with SMTP id
 4fb4d7f45d1cf-5d3be77b16cmr336585a12.32.1733428056237; Thu, 05 Dec 2024
 11:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com> <20241205141850.GS3387508@ZenIV>
 <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com>
 <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop> <CAHk-=wjNb1G19p3efTsD9SmM3PzWdde1K2=nYb6OUgUdmmgS=g@mail.gmail.com>
In-Reply-To: <CAHk-=wjNb1G19p3efTsD9SmM3PzWdde1K2=nYb6OUgUdmmgS=g@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 5 Dec 2024 20:47:24 +0100
Message-ID: <CAGudoHHRGrQc5ezOLytq1dwmpGkXYyysBut0SqGveuLwrGaTRg@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: paulmck@kernel.org, Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, edumazet@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:26=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 5 Dec 2024 at 10:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > > To my understanding this is the idiomatic way of spelling out the
> > > non-existent in Linux smp_consume_load, for the resize_in_progress
> > > flag.
> >
> > In Linus, "smp_consume_load()" is named rcu_dereference().
>
> Linux.
>
> But yes and no.
>
> It's worth making it really really clear that "rcu_dereference()" is
> *not* just a different name for some "smp_consume_load()" operation.
>
> Why? Because a true smp_consume_load() would work with any random kind
> of flags etc. And rcu_dereference() works only because it's a pointer,
> and there's an inherent data dependency to what the result points to.
>
> Paul obviously knows this, but let's make it very clear in this
> discussion, because if somebody decided "I want a smp_consume_load(),
> and I'll use rcu_dereference() to do that", the end result would
> simply not work for arbitrary data, like a flags field or something,
> where comparing it against a value will only result in a control
> dependency, not an actual data dependency.
>

So I checked for kicks and rcu_dereference comes with type checking,
as in passing something which is not a pointer even fails to compile.

I'll note thought that a smp_load_consume_ptr or similarly named
routine would be nice and I'm rather confused why it was not added
given smp_load_acquire and smp_store_release being there.

One immediate user would be mnt_idmap(), like so:
iff --git a/include/linux/mount.h b/include/linux/mount.h
index 33f17b6e8732..4d3486ff67ed 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -76,7 +76,7 @@ struct vfsmount {
 static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
 {
        /* Pairs with smp_store_release() in do_idmap_mount(). */
-       return READ_ONCE(mnt->mnt_idmap);
+       return smp_load_consume_ptr(mnt->mnt_idmap);
 }

 extern int mnt_want_write(struct vfsmount *mnt);


--=20
Mateusz Guzik <mjguzik gmail.com>

