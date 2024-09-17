Return-Path: <linux-fsdevel+bounces-29601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C497B522
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 23:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A141C22099
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84121922E8;
	Tue, 17 Sep 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMhqGr/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4D34CE5;
	Tue, 17 Sep 2024 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608282; cv=none; b=l6Q2+Ve9GbY4mE3baKZvqFnFq/6WZKvZtfI7LhYy7S1DAS6hWdThu8EcO0LFpU3ym6mjYPkJfHHvUlpegixU7UtqEofnBoidynKGjIExQ2pAar0RK3tsK02Xa8peEaGaxK6d6ydTSJCN88QpEHwGv5x/2LT7xnPdXfaYCvwi5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608282; c=relaxed/simple;
	bh=qbzwExx8laMrc91h0RhCesWw10Mfdv3PH8Szj/HZGbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOVpII8OOnJDWuGBcFNmefAVJBZVROeRRs0UeoHkH557eHv5ti3PxsbIhDWqMB9Q6YGZ2McSzYJ0HMA0PJLkm/ZcM9SGvjNJxuKWNDNMD+5YmVwx1gsQglgsBDltVnLQsjODJ24Qfh1lCnGAypBNBvapT+hfu5FDR655dh3fGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMhqGr/8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5356ab89665so6828064e87.1;
        Tue, 17 Sep 2024 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726608278; x=1727213078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nELtIw4Zh0M13uRB/wUCoEnw1PUF7WXP5SyljJ7urZo=;
        b=fMhqGr/8URtOGkTBGhuY0bL1sK/Fsc5wIl8Sp3tDG+CRme96UifQiXUmTp9l6IQXaa
         WZVKHFNLDEX/4ltoA3TRKO44An1S/lOmZdRG9kAuQ/IgYAnT+DYYlZ076WQxCtLzb046
         pxB4nfIRNNh4T0qpF0Jtp1V14KtYkYZQXI93UvLOpKRCks3TnblgxTmb4dWBziOMQj+h
         U8Ty2drXSjisusplIRNvGnOFEgG5TSwEOnwVVGMjUH85Sp1LXkdIWLO3QTohhTB2HxAi
         OqM2xbxDSnCjj8hDy4CaUnkXw6TpcYQnR7TYfRSXQhIlUKs28x144ji0muN+5Iemn8tp
         xbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726608278; x=1727213078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nELtIw4Zh0M13uRB/wUCoEnw1PUF7WXP5SyljJ7urZo=;
        b=ll2eyim5Q70R0sncHZ5xbJUIpaUWJmZ9zc7IehqJrJmrlH8sLUkDQ9HHt4vJ2AFvQL
         FN5m/XejGy3KolMcTE9HJDI5fj69wGTlpFgYPWFopSfTOvYgqllpx0BFUyPeTf60yOE0
         YdKrKlhbU31lmWqDX1GHVjiknKZlbSsB12zK7qDusiCyXM6yHEffpjNzXk6tzOZyxPAo
         7mJad2zG8LFhfKWqBVvwTlCz6v3OSDMcSjb2CjwU2Rn43m/tMrHWHcfjYF76PeQ31XWz
         FaxW0l5bpoDWW8OKcie3drRDwziN/ZLiVNbCU8KO6Zt0ytRsBin/57YsSG+l9rO1Yqn4
         wxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQRArVLomZ8auQ3+dlOYWtzIpKqGI7a/VLkhA13nU32m9NMifVBtrJz+mSSNfnpIGxm3OzjUkNdWotRyAE@vger.kernel.org, AJvYcCWUR6C/r+ucTHYt0i9WlfwtAo5zS6xzMISfZQAQFxEOJ1/x5FtiIPcb/gAVnCpClmhM7ECsqepK1U+s@vger.kernel.org, AJvYcCXLoDTIMz6WmPG7rDRq49EQWHC4vmpj6MymLtDOX7LaH7AHyeimVPHr2oZgD7vBuKie+e0b3qjyJ/W7/fJXbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhqCS8bpASN/+GZHx3MuAbCa9qhxBsv/DIyQ3VdemZMQCVvZGC
	KOq3AsoBaP6ynshAD44lj9JpFhBo2aosa6zpGde90413d0U2GOxeAu5YEQ87dBHkB/GksesxdW7
	rAP3s0wwyG9dbhM2EmNdx+d52sK4=
X-Google-Smtp-Source: AGHT+IHpWygKBqdIpti/xTdN/vHJot0ZFGpOZk871PgTIMb/gjAsmuos+l2tbd/Rrtz8eDF8oHlZxhDKZPQxWoo6z4Q=
X-Received: by 2002:a05:6512:1384:b0:52c:e1cd:39b7 with SMTP id
 2adb3069b0e04-53678fb1e9fmr10522085e87.5.1726608278095; Tue, 17 Sep 2024
 14:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2106017.1726559668@warthog.procyon.org.uk> <4bb2eee39bec0972377931aa8f4c280e@manguebit.com>
In-Reply-To: <4bb2eee39bec0972377931aa8f4c280e@manguebit.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 17 Sep 2024 16:24:26 -0500
Message-ID: <CAH2r5mu3TBeMugfWddNYSpPZiYe8Hhv7DYY52rsMb-Zs8BMv4g@mail.gmail.com>
Subject: Re: [PATCH] netfs, cifs: Fix mtime/ctime update for mmapped writes
To: Paulo Alcantara <pc@manguebit.com>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You can also add "Tested-by: Steve French <stfrench@microsoft.com>"

On Tue, Sep 17, 2024 at 1:01=E2=80=AFPM Paulo Alcantara <pc@manguebit.com> =
wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > The cifs flag CIFS_INO_MODIFIED_ATTR, which indicates that the mtime an=
d
> > ctime need to be written back on close, got taken over by netfs as
> > NETFS_ICTX_MODIFIED_ATTR to avoid the need to call a function pointer t=
o
> > set it.
> >
> > The flag gets set correctly on buffered writes, but doesn't get set by
> > netfs_page_mkwrite(), leading to occasional failures in generic/080 and
> > generic/215.
> >
> > Fix this by setting the flag in netfs_page_mkwrite().
> >
> > Fixes: 73425800ac94 ("netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs=
_inode")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202409161629.98887b2-oliver.sang=
@intel.com
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.com>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/netfs/buffered_write.c |    1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
>


--=20
Thanks,

Steve

