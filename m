Return-Path: <linux-fsdevel+bounces-37044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE5E9ECA35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF2B286237
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4521EC4E6;
	Wed, 11 Dec 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iYjgrhCl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267EB236FA9
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912482; cv=none; b=N/MefSHNEcS8t2sbx3mB9d+lIFaSxswru5xRJkTNmyEzcUiwdzXFPtAUk10c1gl6E6gGLv8cBJK0MrMdiLBagDKIhJ9n3OL3zTR4xL7UWAvExV6Vmmy+6dJgs8Z65FQNDL+VMWzEBrG3QjwLLd8DBhKIrTOjzW+Qum/dzMvURo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912482; c=relaxed/simple;
	bh=lazSOoiG50KhGUO8Dae3vA/8vIpiS+4lQ/N9/uI4fV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0FPTlEnm4g3vDFcXhj/8TanUsYWFFBiM6M/6c7G22GG51ZCCsJbA8IijMs5tYDaeTNzjSRSgz9Py+3aBb1AzcJ+Imm95usVBAgwFb7WHSwiECqiCXTVostmcdN/4tCAee+LEoqrYCGrOMpJH5jwuHDFR1YWBcYhwl8wxzIEn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iYjgrhCl; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46788c32a69so8162661cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 02:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1733912479; x=1734517279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L9Vb3vfWdhyKiMA4qB9J46g1gDJnHNfz6tkx6cBadTY=;
        b=iYjgrhClUzKnjCwpp6nIu+3RG59ecpdWUbcxAexwSUHDJcD6j6FP4gDI+T3hRzSR+S
         61E4wE0pSB+ebTI1E7gx9br9ET4X1i+PlLsCOlr8GYeLjatyrdarKaOTOSVZnBuyAcxR
         /AVFkBjyJkh6y7E7ZmaWQ9WLVnmYiubb+F5rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912479; x=1734517279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9Vb3vfWdhyKiMA4qB9J46g1gDJnHNfz6tkx6cBadTY=;
        b=UEq+/+R457syhmRKbgAebdbybzDHfaYrkO1LAK3TqgQGO6ZX6uXsFOU8L9TGvlNwPp
         uChi4n0H6ZHVETJwzzzVTtkbiD+R+4apfThpjd3+isYX9hHxxZOpuTtdB/MhPOjwwOT/
         /yUnS/RnyTr+u4lb+QtTZUhvXxhYUTdRxY0KOfJGL+otDRxDRxNyyZYgHgDlSFFdfZ90
         Rx15fbow+4tTUxyv0ECqYOMNUJ56p6zUeS3rcBVOPcvkC1zzbX4WR9+0KJjcA7dr1OZI
         UdxUHNGxbDRTEik/ZiZgMbZy5CmjQpX1LwU5olT6ywrwSmKgVwOtl/UDsOM2C+G1scPR
         jWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV7x7soea853wOnmJPqlx0/VXeIzrQUf+LyjApT68JPKZBkDiN7wS1Zs2UN5Tz3qZn5vIIYU19INKbCWX/@vger.kernel.org
X-Gm-Message-State: AOJu0YxJvxfEXrLibxCb+a0f92kNhNjMyGjdQ6JMHx0lT8aM2+RXY+rM
	OtO40NG4iGfA4A943bdddCqacnNx3hYi7DyZBrEXCy4oUO9TVyY7R7kcite44VHC87L9jSmAjPr
	CcPflgst7MXSVuUFiE4rShdNpiEQZDthGcpZaLA==
X-Gm-Gg: ASbGnctjy4Y82/MyNVeldJq7M9AwVVHRODx40US5+Jsyk+Sl0J+mKi/6CxqR3pFRy1q
	9U1cqJc6/5G3ri5yCYtwyy7TfIs/kFGqopf8=
X-Google-Smtp-Source: AGHT+IHqGHPIKLAUmoBu39GBwjAlUysOMQd/Jknm9UgmfrUm6fK6CGW1BTNdGfu4TnBpgGrdQu5xabrrKi1fwFBusxs=
X-Received: by 2002:a05:622a:180e:b0:467:5444:caac with SMTP id
 d75a77b69052e-4678939f0c0mr46696061cf.55.1733912478881; Wed, 11 Dec 2024
 02:21:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206151154.60538-1-mszeredi@redhat.com> <20241206-aneinander-riefen-a9cc5e26d6ac@brauner>
 <20241207-weihnachten-hackordnung-258e3b795512@brauner> <CAJfpegsFV6CNC0OKeiOYnTZ+MjE2Xiyd0yJaMwvUBHfmfvWz4w@mail.gmail.com>
 <20241211-mitnichten-verfolgen-3b1f3d731951@brauner>
In-Reply-To: <20241211-mitnichten-verfolgen-3b1f3d731951@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 Dec 2024 11:21:08 +0100
Message-ID: <CAJfpegttXVqfjTDVSXyVmN-6kqKPuZg-6EgdBnMCGudnd6Nang@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 11:00, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Dec 10, 2024 at 04:10:45PM +0100, Miklos Szeredi wrote:
> > On Sat, 7 Dec 2024 at 22:17, Christian Brauner <brauner@kernel.org> wrote:
> >
> > > I took another look at f{a,s}notify. There's no copy_to_user() happening
> > > when adding events via fsnotify(). It happens when the caller retrieves
> > > events via read() from the relevant notify file descriptor. We should
> > > still move calls to notify_mounts() out of the namespace semaphore
> > > whenever we can though.
> >
> > Doesn't work.  After unlocking namespace_sem deref of mnt->prev_ns
> > might lead to UAF.
>
> Hm, a UAF could only be triggered by mounts that were unmounted due to
> umount propagation into another mount namespaces. The caller's mount
> namespace in mnt_ns->prev_ns cannot go away until all mounts are put.

Why?   E.g. one does umount -l on a subtree in a private namespace,
then destroys the namespace immediately.  There's no serialization
between the two other than namespace_sem, so if the former releases
namespace_sem the namespace destruction can run to completion while
the detached subtree's mounts are still being processed.

> The simple fix is to take a passive reference count. But I'm not sure
> what would be more expensive (holding the lock or the reference counts).

Right, that would work, but I think holding namespace_sem for read
while calling fsnotify() is both simpler and more efficient.

Thanks,
Miklos

