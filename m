Return-Path: <linux-fsdevel+bounces-33631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2229BC044
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 22:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A79B282B34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247B1FCF4A;
	Mon,  4 Nov 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgMdpxRN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722B1E5725;
	Mon,  4 Nov 2024 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730756670; cv=none; b=k7uCytwwzoggl/zvbYBsBOL4RqWPmCmwhAzAWvIKKt6sEWY4OVyEg4SClQs737K2SUDjbtn6khw+123H+0S82F3hiGUwIO7P4oP10w70ZNCvejM9NaME/Aub5egMmQGLwpaf2aI4wh1AW/kTSXcwmSgxjoyVPOxIaj7sxBoYF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730756670; c=relaxed/simple;
	bh=cnQt85/IBBjwFUEOwDLccd6pQoT2o7PdYi5GvmXKs3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWhm0oDaIKD4sC4TFcdDzcUguQC7GXEiZIsJ8SiFChjLI7vCLuTpe+mPkUhyBxb1znrFAlw+6aRBVXfX7KwcO3qHG/yKsEeLeB3lfny6fDPtC+iXWS+U01/AKDviZr6QGMS+dUAxZMoT74jJ32IQTkx6k64i/yQfe5llq87bHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgMdpxRN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbe68f787dso30791036d6.2;
        Mon, 04 Nov 2024 13:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730756668; x=1731361468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NrEfQGqdrHPbmwDeN85eCwuLpMlJMeWTmlrYTmvJPA=;
        b=LgMdpxRNQ7RVW5NonateG0PLfR3LYS1J9rx6VLFUPXNfJHz650nqbGgkLzzhVAJaRM
         bJ2MEuNnWG04a3LoHT0scjdCS/VIZCcWnjwKzPKzR0E7V09NwKVnUd6bA9LH6UoJ+LIY
         pQTmrZBsFzg91z2Vmxb9xYw1kP1w0x2YIgykLosnzklRN1BWOtvzllIt/YZyge6AeZ/i
         j5aXJuFyv6jqDSRg1YHWM1jvnrl4vD2hI7qPH0T0gf+tGu95CMV7/O+lh5Apktl5rI6v
         0hj1vBq++YmQsu+A7u0L4f0y7V+G8XUAZBjYIOu8TTd5EoFKEjm+fq/renNALdFQR2CZ
         JMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730756668; x=1731361468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NrEfQGqdrHPbmwDeN85eCwuLpMlJMeWTmlrYTmvJPA=;
        b=Pby/K0s0w6u6AcbxVYEteRZ1ftndkiH4SOqcn71Pq7g3/q8ECJVVRxnoIbVwymd4Ry
         BvHSbVE4u2/szXTrN2XbRI5HVip0DT7DCcxlN3B8wIjOgw93SNt48jwP97tSWNfKT9KA
         s0qNVg50zgdmgkTu09wQJEm/vxBKiEmEWWBHwKuD/w3t+nKTz4Obo7j0DcfASteLVJyR
         ZxUyyh75ZmGirPMoe8xjRqSHxfy5cEo33q7yPd2W3VsCDSEAeIBs801YTLXNbxaAqav3
         ytqIQW0J7JFoAatU5jSawYLznoFV5JrEDJloTK9AbeCyv769hTb81YCB9spLURI5d+XH
         1lHw==
X-Forwarded-Encrypted: i=1; AJvYcCUvu9n05yL1qqDtukk1MBfRcO8+dZdlroch0Fw9W5zVuQW8jHFJafcb4edL+4uaDXEUmz2z1lE2ehXqGXnF@vger.kernel.org, AJvYcCUzJmJy4sw1+TL9IsL4+pZp2+vM4BxEk3yvaYH4FR7GIQQMpWah6c8D5mgXzBlsAALSrD1u4lxCxkxEM3mdIA==@vger.kernel.org, AJvYcCX4TYQ/kBg6fHJJ9Sa+zJYTP+A7oeWm6MaA8yzypvxITEzuvCkKjcz0un9L/rwgSo1QaMWMQiFTaaiWS81Ekg==@vger.kernel.org, AJvYcCXVYtM0hnPN8rxffEsLW+QPtwnlgO1CqZOVdXBgnNhKLD4RkSbh6V89GA4LKugLE+isxKkrYVld2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGeJsGe4F8+5Or4OX3tbgW0DdvG7MGImzNlP0h00KfZSH1kC0x
	zRzXUK1buASOcmvmslEctyvy9j7IElKB5DAVRfdfUWyq9FG4qm7KXd4gZ3D/1/AuL0Ezrxhz8GI
	PWTXxh7ZbcDX6R95AXrcIhXIIsvs=
X-Google-Smtp-Source: AGHT+IGUFOPlyVXz4TURnYNHRRXYYClMhXlW/+8Anj3bhex8lDTJ8z08cF0ehG+/GQ4N2CEdR9n0zVynl0gKAOkyanw=
X-Received: by 2002:a05:6214:498b:b0:6ce:348e:a8c4 with SMTP id
 6a1803df08f44-6d351b19112mr220444216d6.48.1730756668134; Mon, 04 Nov 2024
 13:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101193703.3282039-1-stefanb@linux.vnet.ibm.com> <20241101213025.GP1350452@ZenIV>
In-Reply-To: <20241101213025.GP1350452@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Nov 2024 22:44:17 +0100
Message-ID: <CAOQ4uxj4kBULWFt53rqM_Q-pfR8dWyMyraUWjHxo=0C09_XMkA@mail.gmail.com>
Subject: Re: [PATCH] fs: Simplify getattr interface function checking
 AT_GETATTR_NOSEC flag
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	Stefan Berger <stefanb@linux.ibm.com>, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 10:30=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Nov 01, 2024 at 03:37:03PM -0400, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> >
> > Commit 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interfa=
ce
> > function")' introduced the AT_GETATTR_NOSEC flag to ensure that the
> > call paths only call vfs_getattr_nosec if it is set instead of vfs_geta=
ttr.
> > Now, simplify the getattr interface functions of filesystems where the =
flag
> > AT_GETATTR_NOSEC is checked.
> >
> > There is only a single caller of inode_operations getattr function and =
it
> > is located in fs/stat.c in vfs_getattr_nosec. The caller there is the o=
nly
> > one from which the AT_GETATTR_NOSEC flag is passed from.
> >
> > Two filesystems are checking this flag in .getattr and the flag is alwa=
ys
> > passed to them unconditionally from only vfs_getattr_nosec:
> >
> > - ecryptfs:  Simplify by always calling vfs_getattr_nosec in
> >              ecryptfs_getattr. From there the flag is passed to no othe=
r
> >              function and this function is not called otherwise.
> >
> > - overlayfs: Simplify by always calling vfs_getattr_nosec in
> >              ovl_getattr. From there the flag is passed to no other
> >              function and this function is not called otherwise.
> >
> > The query_flags in vfs_getattr_nosec will mask-out AT_GETATTR_NOSEC fro=
m
> > any caller using AT_STATX_SYNC_TYPE as mask so that the flag is not
> > important inside this function. Also, since no filesystem is checking t=
he
> > flag anymore, remove the flag entirely now, including the BUG_ON check =
that
> > never triggered.
> >
> > The net change of the changes here combined with the originan commit is
> > that ecryptfs and overlayfs do not call vfs_getattr but only
> > vfs_getattr_nosec.
> >
> > Fixes: 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interfa=
ce function")
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Closes: https://lore.kernel.org/linux-fsdevel/20241101011724.GN1350452@=
ZenIV/T/#u
> > Cc: Tyler Hicks <code@tyhicks.com>
> > Cc: ecryptfs@vger.kernel.org
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> Applied (viro/vfs.git#work.statx2)

Acked-by: Amir Goldstein <amir73il@gmail.com>

