Return-Path: <linux-fsdevel+bounces-30003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A2984CE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 23:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16A61C231F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEFD13B792;
	Tue, 24 Sep 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP80Uk4j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9639E17557
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213579; cv=none; b=GAtZ7knycudw+ypvpHN1fsgN/+zN0kfapF80UZKHypazgWEh3JVHrcVS2xbR4xKr7iyLKRK6huwPnv5LtJbAMv8uvKq7tuca+GXMH/1mNXmH3A5BSGHkKvio6P8Z3Vme1MZe9hdtCc0GTDus36vsMrBWcn8UNJLri16xpTteHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213579; c=relaxed/simple;
	bh=NO15dgY24tO5jHjd0+tTklN3Er6WmUStT4SvA/NX/fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDfvDqAOxjFYrsiIskXBxn3FNjeUaI/x7J0B+nAzRmozrtIthnDVvYO2xfKoB2larMRifnkk69+f2Y993plYTuRDTckJ0vqdZm4Xd5fA4Kk3+h9p/an1DvFvbEFV7plSxtQFK6kujdMg+JzxioXQsUoE9uaZK/DLLdBp2FxwOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP80Uk4j; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4581d2b0fbaso41573471cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727213576; x=1727818376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDlypF54Wp99xeFwXseYs/iXXedKu1tCZNLBXlHy/3s=;
        b=WP80Uk4jUZxlGV4QnJst0RcFPKMd6sIWHwQ8rMRUhzmOozKOrR8HJHwf4Gz2AZmZH9
         hsW/6O533Vtz//q25oimGBJ+8urid6lPWaYewcqiwzCBT2AaEEgG3gNsQklkYoXReFex
         7iJxXTFkaljZY0X0jyZJCt+kPu+Ny6/0NOqisOySElnTgMD+dbesqpFy8jhrj1gasiya
         eJG6F9E/oZRLnQVL1xy3rDEbd6rI+uUrOetwAOqzHC7a3K4PH48goDgzprigxME2gOp4
         TfOmP4DcO6qWhk9WL/M/sJgmZEwRyrA13vDym4IHD7+BZy5WdEQhLmEma7Gvmh87gVB2
         vCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727213576; x=1727818376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDlypF54Wp99xeFwXseYs/iXXedKu1tCZNLBXlHy/3s=;
        b=Czmik5ytZCUJxr+6wVnZxtWB9wjNaVQN6aFaLAMBlk3s33bj+w+QR7X5LKMOCdWGzQ
         mJNYcXwZ0lc7l/wwsZ/GfJKuUWAlSvBzRDYloe+HJyhTZgtqTrDpfOYxcbglcyQxQLrN
         ydRM3Rd8/udTWqgPlckc39mlqzRTQohjFV999MNgZZFzUFbf0dmkkm5oB+KU02BamYd+
         gxPH1qveSzCMB4RHaTF+AVdxUkwraORKQr7AzskbJLzm3d0wgjMDmoxrg4PEyAKL3cYo
         YA2PvHyF1JIdcQ6K3GxDezJcZukBQnjmCj2J/FnFsuShlKLc6nru4GOSZgPkMsyrle9u
         dp7g==
X-Gm-Message-State: AOJu0YwybnX1oR4hllL2+3JNTxVnB3sg4Yie/OnRJ/Ahtdm+APfaZat4
	lEqhs7QeyqBRAxvkzrlvOsTi6EMXy4VyGAhElFYwL3KII+8QWlKkvPUp3jIjLcu+vtPf80KAtYf
	K2zCvz3mG2nc1kUj/vIerzspN7Ek=
X-Google-Smtp-Source: AGHT+IHGkbNB2CzRURV+sctPH+shiqSskUkipRTz5HEhKIet1EiMvk34i0DqL2CaOpxm7iBM1IQdoxNS0EkBzXtFn94=
X-Received: by 2002:a05:622a:294:b0:458:4cfc:a169 with SMTP id
 d75a77b69052e-45b5def52b5mr9397541cf.28.1727213576278; Tue, 24 Sep 2024
 14:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923171311.1561917-1-joannelkoong@gmail.com>
 <20240923171311.1561917-2-joannelkoong@gmail.com> <CAJfpegt3OHQkde1rHNwJ7t0FWc2m_8jM7hXc=sh8fdrji4DQXQ@mail.gmail.com>
In-Reply-To: <CAJfpegt3OHQkde1rHNwJ7t0FWc2m_8jM7hXc=sh8fdrji4DQXQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Sep 2024 14:32:45 -0700
Message-ID: <CAJnrk1ZpZed8QPo=X=y+i3OwFr0DpLQyPZepCYsL+XCmBDB8SA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] fuse: enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, sweettea-kernel@dorminy.me, 
	jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 2:44=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 23 Sept 2024 at 19:13, Joanne Koong <joannelkoong@gmail.com> wrot=
e:
> >
> > Introduce the capability to dynamically configure the max pages limit
> > (FUSE_MAX_MAX_PAGES) through a sysctl. This allows system administrator=
s
> > to dynamically set the maximum number of pages that can be used for
> > servicing requests in fuse.
>
> Applied (with a minor update, see below), thanks.
>
> > @@ -2077,6 +2085,7 @@ static void fuse_fs_cleanup(void)
> >  {
> >         unregister_filesystem(&fuse_fs_type);
> >         unregister_fuseblk();
> > +       fuse_sysctl_unregister();
>
> I moved this to the top of the function to make the order of the
> cleanups reverse that of the setups.  I haven't tested this, but I
> guess it shouldn't make a difference, so this is just an aesthetic
> fix.

This update looks great to me. Thanks, Miklos!

>
> Thanks,
> Miklos

