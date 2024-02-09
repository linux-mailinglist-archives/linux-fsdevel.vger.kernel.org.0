Return-Path: <linux-fsdevel+bounces-10975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DED84F888
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA28FB23C31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA474E2B;
	Fri,  9 Feb 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kngy2wSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5D69DE5
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492529; cv=none; b=IT0Wvutv6S7EmhA2DNy+GTSOlvUrHjhBlTLdW8uTyAvfyeHDQYnPSucYlESoiC+jWDadppz2TsNS511XG92R7hflUhI8/iLb30VX28K5zy/yUb44zOOepVBYHzCZswACl0cH/YJanDzIDROQtbVM+cJqiZz3OaxtJWiJP4b3XFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492529; c=relaxed/simple;
	bh=QAcdewfzL9rjMKlZsFH94bqyapeBvmn6xAexRvcMc5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKaDEuZE2sFpN5rj6+nTtotOYZZG/GXOukHE/mA1q62w3O8V4q/IGg1wOhQUUVSI2rXc1hpCJVI7wrCs6I6yFLg+jtZBmbBg8yLGdYTQK7WbEnOn5jQcA8OrzNP/vMXSgONM87vjr4veBbOG4/E8dDI0IRj2JYzLzF9W49iQTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kngy2wSt; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-214dbe25f8aso497901fac.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 07:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707492527; x=1708097327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2yvCAylobsi5Ph+c6y5RW3S28Dkum3q3doPwpvgnC4=;
        b=Kngy2wStc5VHf92R6ReuQxgJp8zY7pXQ+GIvAbxqeasQKXB/stC1EZ4/D2PcbP+ZIH
         LuZS3yrRmaPSrT4KLh4xzPRTeavDju3zcZYxR24HthyBKOwDCwjd8p0zu7spoyuur3MI
         WfUhz6MndnYv8ej01cSbb6nmVqsAHQQ+gR9lqMHqfV6Z5cyQM6oKwejzrPK651r8WFlx
         rGqR1emQBnuJI/Mrt/fFzcysg4tbI70vAuD8v68BR8hmJqO1SpagoyhEih4Os1lsseMR
         YNmfApwB7Bzm9UD4Ue0078DfWOS3mcn+JNHuMoVWC/E2+D/Xmy56zhCVtQvmA3jMtzIh
         DHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492527; x=1708097327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2yvCAylobsi5Ph+c6y5RW3S28Dkum3q3doPwpvgnC4=;
        b=aANuPXuqAvXo1V4Ir1ebhLLPfHLGjktHK/jF1QRFFdZr3GRb/ti0Znqea92CRp/nCu
         sQcRsS2ldQN/EZPDgWl2ka+rv6nKYogHX74C0icv4fMs3suAT36yLRQGxCnsad2uVq49
         f4lUQX6tAjDJSS4SmDPDsMjH2EQ/mhotlXWZzgNX0fQm4GIEPBghaUDAkvZfHYE+rltl
         UrTkpx/qr+i71fNVtB47ES72NUoO6uCp41d/irWiP1dOHZRJjSBsSC09j52fe6fMuq2n
         QhZtWEF3q4M4bG4EXMRIanXrRwjVXgYNp+vi8PtG3et4MvNN6BM62nwXd2RSwrjPjtkK
         6Gag==
X-Gm-Message-State: AOJu0Yzleb6jyNTdC3ml1DEBDOw0e67T7a3pYsIqUZHipO0iyxn2p/R5
	t1/jdOBVM5aB8AiZcCmJFVhQ4zjzdNrR9+jc5UypUy/dJZIF1426DpxR5IYK5c/6G1Xaeccnpq8
	g5CR4id7f41eoQ3oHC/TEM2qZ45Y=
X-Google-Smtp-Source: AGHT+IFkd09RxD0tJ8KjLT7HoqOPLWJQJ8Qd0nqQJuIoVeH/zat+YS45MT4jCwb5mdtbplZ3htHkOWSJ4ZaRcn6NyX8=
X-Received: by 2002:a05:6870:ec91:b0:219:c875:49b4 with SMTP id
 eo17-20020a056870ec9100b00219c87549b4mr1746456oab.8.1707492527062; Fri, 09
 Feb 2024 07:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
 <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm> <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
 <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com> <CAJfpeguKM5MHEyukHv2OE=6hce5Go2ydPMqzTiJ-MjxS0YH=DQ@mail.gmail.com>
In-Reply-To: <CAJfpeguKM5MHEyukHv2OE=6hce5Go2ydPMqzTiJ-MjxS0YH=DQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Feb 2024 17:28:34 +0200
Message-ID: <CAOQ4uxh8+4cwfNj4Mh+=9bkFqAaJXWUpGa-3MP7vwQCo6M_EGw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 3:27=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 9 Feb 2024 at 13:12, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I think this race can happen even if we remove killable_
>
> Without _killable, the loop will exit with iocachectr >=3D 0, hence the
> FUSE_I_CACHE_IO_MODE will not be cleared.
>
> > not sure - anyway, with fuse passthrough there is another error
> > condition:
> >
> >         /*
> >          * Check if inode entered passthrough io mode while waiting for=
 parallel
> >          * dio write completion.
> >          */
> >         if (fuse_inode_backing(fi))
> >                 err =3D -ETXTBSY;
> >
> > But in this condition, all waiting tasks should abort the wait,
> > so it does not seem a problem to clean the flag.
>
> Ah, this complicates things.  But I think it's safe to clear
> FUSE_I_CACHE_IO_MODE in this case, since other
> fuse_inode_get_io_cache() calls will also fail.
>

Right.

> > Anyway, IMO it is better to set the flag before every wait and on
> > success. Like below.
>
> This would still have  the race, since there will be a window during
> which the FUSE_I_CACHE_IO_MODE flag has been cleared and new parallel
> writes can start, even though there are one or more waiters for cached
> open.
>
> Not that this would be a problem in practice, but I also don't see
> removing the _killable being a big issue.

ok. Remove killable.

Pushed branches fuse_io_mode-090224 and fuse-backing-fd-090224
with requested fixes.

Note that I had to update libfuse fuse-backing-fd branch, because when
removing FOPEN_CACHE_IO, I changed the constant value of
FOPEN_PASSTHOUGH.

Passes my sanity tests.
Bernd, please verify that I did not break anything on your end.

Thanks,
Amir.

