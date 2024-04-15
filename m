Return-Path: <linux-fsdevel+bounces-16974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7DF8A5DDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 00:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE83F1F2174A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 22:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38791158D95;
	Mon, 15 Apr 2024 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv8dZKAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A01B80F;
	Mon, 15 Apr 2024 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221503; cv=none; b=gkg0mpF6ESCFctkCNM92WzMOCI9mqMakL5rOLUQIIHXmNPqq+Dba2zbzRbEEom0ym2PPbX7VM0nTcN0AfqTgO2yZ4pH/RLGmeMJFJfwkqHVmfYf3mdkwluekwb+m94XXGqS5GhE7mKf6ysHRmzcpsHoBbetxjSA/LKvR3iEWmr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221503; c=relaxed/simple;
	bh=210MiktY9ffZFXiFwX3XKrZn/rqxu8+UIHYBzztKE80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7DRg1QVy8/sHGFcWTzQngne1ZXDihtRzZU86oI8Gv9i+5UniOBKerFAAOThfj0jzS5/8VZIJrH76/khPB5VuPqB/CCf+5ow+ugT4pnkjir031Jglx/ONgHyCtc21LmCYdIvHbrYVfZVaDNNgRORGXsEyrUiSiYdG46VDk8bYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jv8dZKAe; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d0c004b1so4937876e87.2;
        Mon, 15 Apr 2024 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713221500; x=1713826300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63WuSgSRy34JNOa9pVcP0sGLwbzNT5xJkZeCbwGkCUE=;
        b=Jv8dZKAeOd7N++mj5aVTg0b+uwwW6TInljFgYMkN+gJF2svxVZXZfyRtZ1A1lYZ0qs
         InuJNbFaI65WrSXYTUI2PvnOPnv/brCxLC1n8wNSCStCA6UNrHAzYrw6EH1698sUvurp
         x8TNNmjnyUJzBTOH15Ry47c7NqUjVDfkNx90gSkrzU4Ug2KNdtLz8Xms+c5n91c2eF2l
         8BL8rXfQciDwpaEZN897z1u4Z7QsgASytTXISoQ4jB8VcPUoqhtcPJlrWqRKYC2Awfw+
         SDY8QGFdP6YxEA7IdDO3pjooicse1JUCcPTrCbTOv1moNbIjqC4UgC+sZHrEykN13OaB
         mzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713221500; x=1713826300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63WuSgSRy34JNOa9pVcP0sGLwbzNT5xJkZeCbwGkCUE=;
        b=JZCg24s7kQ91ejvfbsssxLTm021IgSbVmCUZLK0V29ZeDSBvGeDl0VIeZZY4GGZvjZ
         mUH7iZbQX5bTy2pntZyLZlWhhFW/47cC0cAXZ+wIg9v00Ucl+y6VoBMlDDJ2gm5NzqwP
         Lvduk4SrLFyh3YPefNWKz328ouQSvATTnbsN+vqf9UA5L2mYqbb6i2KYmcFIb+oK2XA0
         zxGm98Aa30hlODxml6FDm23AiwSBKibeGA8gYe6HbNlEJiwn7VrHPpPx/HmOEo6b4zjz
         Un78RCwh0GOdO1ZvoaWP3pQchsJAM/gz9AkZ1hhIl2eF0WoVNM6hfyJlUkfEjtZOBcyw
         Vbtg==
X-Forwarded-Encrypted: i=1; AJvYcCUlace++9rH8nZSN6uXURIcQScC1hG7bFPT8cUE+T+m9SfxhssyOAzRsF5wbYl1TgP6ZM6/INhXSilC5oN61p9f+G2FitXLEPBiD2t0i1isgkSfrzoeeliJJ+TpUTir6gAsS0RkXkwLR/HiMwElOIA/J6GP6D6liUvlaJCm4LHAeIBa9+4bumwvLksOz1S6udFHK8HGZ79I2Nk7I2Zk5WP6b/vL8DsmaSh/mfhmXUTRZvNvs9bKOyVrrOmSzxGyH+7oG0KkYV7PYfMyghkNQE82gGGeamhZ
X-Gm-Message-State: AOJu0YxG1yqHiIW1/4yakwJDtoVS4IqhJX/wrDLsMmfJCK/rLx73dO6G
	KixQzcgxQG45iaFOya2dBh7a01M/oCg/cY869TDUHIq492gUetAKoNluSMYbYj4I9WbtjZxSR6M
	0QQEn58KAAF5iA5UKdyGYS3Uu0pKLlw==
X-Google-Smtp-Source: AGHT+IF8RFFMQuN5vGtuRwBPhuh0oAZccy2g38TQjUdEv5QNHmaH/Tohq78D8IN9/9jH1PsE9dc35dj2/YRmRw43rn8=
X-Received: by 2002:a19:5f1e:0:b0:516:b07a:5b62 with SMTP id
 t30-20020a195f1e000000b00516b07a5b62mr8309996lfb.54.1713221500147; Mon, 15
 Apr 2024 15:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-2-dhowells@redhat.com>
 <39de1e2ac2ae6a535e23faccd304d7c5459054a2.camel@kernel.org> <2345944.1713186234@warthog.procyon.org.uk>
In-Reply-To: <2345944.1713186234@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 15 Apr 2024 17:51:30 -0500
Message-ID: <CAH2r5msFoGAE79pS5bEt5T8a60LU82mdjNdpfe0bG4YpvY8t-g@mail.gmail.com>
Subject: Re: [PATCH 01/26] cifs: Fix duplicate fscache cookie warnings
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <christian@brauner.io>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Matthew Wilcox <willy@infradead.org>, Marc Dionne <marc.dionne@auristor.com>, 
	Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-cachefs@redhat.com, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve French <sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should this be merged independently (and sooner? in rc5?)

On Mon, Apr 15, 2024 at 8:04=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Jeff Layton <jlayton@kernel.org> wrote:
>
> > > +struct cifs_fscache_inode_key {
> > > +
> > > +   __le64  uniqueid;       /* server inode number */
> > > +   __le64  createtime;     /* creation time on server */
> > > +   u8      type;           /* S_IFMT file type */
> > > +} __packed;
> > > +
> >
> > Interesting. So the uniqueid of the inode is not unique within the fs?
> > Or are the clients are mounting shares that span multiple filesystems?
> > Or, are we looking at a situation where the uniqueid is being quickly
> > reused for new inodes after the original inode is unlinked?
>
> The problem is that it's not unique over time.  creat(); unlink(); creat(=
);
> may yield a repeat of the uniqueid.  It's like i_ino in that respect.
>
> David
>


--=20
Thanks,

Steve

