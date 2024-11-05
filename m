Return-Path: <linux-fsdevel+bounces-33669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264F9BCE74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 14:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648F71C21AAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 13:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD341D8A1D;
	Tue,  5 Nov 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG+PF+69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59961D86D2;
	Tue,  5 Nov 2024 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815121; cv=none; b=cFUleC/BC2pV2YIdh3Fu1eKyUEuf1X2Abb2QRVWY5VhVbwRLnYt6yjYLoLbut/52M8zMgGFOFk7/j3scTMFS/QyLCf9VhuCSEoW+6XxhXO3/2M6/iIJinBb8eAUWf73qMyBhla5Gysp1F/g7VjN4qI1zch8qAGiobmpVHuamfPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815121; c=relaxed/simple;
	bh=JEPZHZDZ9HF7e0d0tl5oWiltB+5v23MRe0F7U4Go8pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hz7R4/ggRtpS2fHESpMhjB4su69ACOR3Pf/oc/in+ekfHf3bHjKTh9W+/YmZpbOU/42q5Yjie/0LsD5eWkmjq/YRxZMslaVXcxvXYTLjXJxMRFdcbvQyIbNt+rRufBQEDe8QSLi+8Hy6D1bVXsX3VxvvL75KaeWI+Qx8qbrp8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG+PF+69; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cd7a2ed34bso37778296d6.2;
        Tue, 05 Nov 2024 05:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730815118; x=1731419918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd8fYczq/Bql3LhMNCx76RD5UObtfYnJhekNQr5DEac=;
        b=hG+PF+69XZzaMg9LaFYoz1DjiFBIxPbkj+4aZnkGvuKTuzIwDixaUgvFQi5ODhso26
         G3tLsdzOPxXhyo9u/i1V2q3p58FFzFD/kdtU9NxgFs+oJW82fn0r29wcRqygUnZsC//f
         SiS8ArfBkCIKpg1rzorDB46+dwxvMfh71qnHgorFA1FBX0mX0kMUxnHbhF4UxcI6k5WB
         QMpUOHsV1bY6BPOxTd0GpWFXczOIDOILSXcBq0SkzO6rRg6Sq0MOOggTzbyMo9rbQryL
         T2bRw4lycPm7AmhBlNAn8fFjPc62QfCPUMxUW9qqVb9TEmkaOfqJaP6iTKQgL3TD9xYt
         ANUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730815118; x=1731419918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd8fYczq/Bql3LhMNCx76RD5UObtfYnJhekNQr5DEac=;
        b=KU/uCGrAsQqXU0RUn9b44CMQ0SmJBFlME2GZk5nuuCfAKoGFaFxvDJe9wP0hhVfkxw
         bxOs93YnHJB1Oq1IJhqx+vvEbY4xdD7IsvYymlSO3iCWuyyyuq656qYi7+uBmNTJWRzX
         1IFFXmA4K+Oirh7yZy2TbYjxsotaYeWJSi3r97Jj5AODnJmnSdXfWhBgzDG/v7ZjOs9q
         tLvu5JTquFgM3Wfx6/J3MeJVaTvmrBKje9BfKzee3NOHR0nVGk+Zkmae9QYEkQ060YER
         YWDnTeEJ1bv9hq5wwFg2YUzgk4QNPKCd9vTd9gkMXaKnW7Q6/+pg38bd83VCJgmUo0Rd
         YP+w==
X-Forwarded-Encrypted: i=1; AJvYcCXDmdTljDGKWvygljOajxBbxuUzwmIgJmW+3sdqvbdUWxcPst+bodhSnR7Q/KXSa1HzdgwAPkxoEBpDpbNG@vger.kernel.org, AJvYcCXqP0Q9gOAi15eexQ56MGunNUJlduHcLkMnfvhJNvmJSfW45r760g9nwJGUMxe+/zQxpTLRU/UKdjIL4JFtnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4pdvY82mWOfCuZGBks4v4y8ME0P5Qex0ykmWOBVltEGyQTMd
	sCTLvwPLaiB4wyOesG++60DGK8fLcjrQhNaYN3hbG/lMc+/39KCOag8Ep5h9lRAl1i5+/aEfLnh
	qqHFCxHgyYopAyp5X+InvoM0QN0I=
X-Google-Smtp-Source: AGHT+IGxJM+dnt+VJk7G6L4JJW+BDjbcv9jynFdNPVeMyVrNuUW/9ynW5YpMeMK9k/yNrdNe/GVLTuysS1d1epZMMqA=
X-Received: by 2002:a05:6214:4984:b0:6cb:399d:6ec3 with SMTP id
 6a1803df08f44-6d35c0a1f05mr249285426d6.9.1730815118469; Tue, 05 Nov 2024
 05:58:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025150154.879541-1-mszeredi@redhat.com> <CAOQ4uxhA-o_=4jE2DyNSAW8OWt3vOP1uaaua+t3W5aA-nV+34Q@mail.gmail.com>
 <20241026065619.GD1350452@ZenIV> <CAJfpegt3qfhP85f+L+Qz03JAfOcSP4fzfz-x_8dvwoP9CgLdnw@mail.gmail.com>
In-Reply-To: <CAJfpegt3qfhP85f+L+Qz03JAfOcSP4fzfz-x_8dvwoP9CgLdnw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Nov 2024 14:58:27 +0100
Message-ID: <CAOQ4uxiDsmhnKm8gpm+hLsM9tsJQAffPSeHGGSat0vs0M+7twg@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: replace dget/dput with d_drop in ovl_cleanup()
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 12:34=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sat, 26 Oct 2024 at 08:56, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sat, Oct 26, 2024 at 08:30:54AM +0200, Amir Goldstein wrote:
> > > On Fri, Oct 25, 2024 at 5:02=E2=80=AFPM Miklos Szeredi <mszeredi@redh=
at.com> wrote:
> > > >
> > > > The reason for the dget/dput pair was to force the upperdentry to b=
e
> > > > dropped from the cache instead of turning it negative and keeping i=
t
> > > > cached.
> > > >
> > > > Simpler and cleaner way to achieve the same effect is to just drop =
the
> > > > dentry after unlink/rmdir if it was turned negative.
> > > >
> > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > >
> > > Looks sane.
> > > Applied to overlayfs-next for testing.
> >
> > I thought it was about preventing an overlayfs objects with negative ->=
__upperdentry;
>
> Yeah, I overlooked that aspect.   Amir, please drop this patch.
>

Dropped.

Thanks,
Amir.

