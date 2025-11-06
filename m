Return-Path: <linux-fsdevel+bounces-67267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71960C39BAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 10:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BEC1A2562E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 09:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A42272E4E;
	Thu,  6 Nov 2025 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYTuwoHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130C309EFD
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419792; cv=none; b=BPl574EqyXBevGHDryFoyGNBBIdtwLTM1q4BLX9Cj3OuM1kLs/OAHllvQQOUwjkG/fPif785ryxs+qWsKAI/NuFmnafa44BpbKpH0K3xuSTbj1yjTFU91XX2/6+CzaBwGNYA6ftyPX1zdgsuClMsp+xdn7eMJPmd0emcDn5D9pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419792; c=relaxed/simple;
	bh=0EKAehxKkI/bTw9WUORbVkGz8/nS+B2Kso4BX+bmOcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXjcVDWebTFlaj6PXGv+gykzWNGw2PDDwxbtRnJt1ANAdf+YnfHUhGeuKDHJkBc/bhGZru+8U4H6cnC4cwqonhXjtdL3wnI683nEjB1ZkDH+a+BB06ajm6eKP87qyPGJ4CfgJiO1zZFS/cMGu15Y/yGAYmlwuuj8XjlJqXC9yxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYTuwoHs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so795314a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 01:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762419789; x=1763024589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veIj9WdBpJJNLGbbTumRAOZ1DVwrSRtT1QGKYvneLtE=;
        b=WYTuwoHswTDQdrk2J9Byqj7f/Husd4nnYTfT5hDwYM9qbNvMrqzk3jWBqpFf5pF9IZ
         xzOtmQrbMenNPXGpT4RowxdsBgEo6JvsQhAR1wbpO//4K7gzZeCyE75Wpf/NeEP4k/iT
         VbQO44VulP2dMtkPiivIc/uRMrYO5qbcx3rNe471ERaRKb1SVvMz61pm5UKvSAA8D7nb
         AR9GSbYzwdw5ZQYPqfoAuRZLbkUTooohJKnjOjfmLeJ8srPqEDgBSge2sJx/uMciNPgf
         d+gF5HL/2mL8yg1lylzuq1scROxUHlX2IhXfKjGIl0dm+8hGFrkqvkcp1z69l1Jgf0Y2
         5KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419789; x=1763024589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veIj9WdBpJJNLGbbTumRAOZ1DVwrSRtT1QGKYvneLtE=;
        b=HBnUnWIQ06KnO5j5brHG6it1Su9JvMWiBlRJ+5j2JxCprEUv7wMdZ0IAb4dmGItW1y
         9C1hHHn+2Qlam592H3VJo48sM4D0/N39VsPrmSwvbntpIcpQiH/3x5okiBQ/u25MFbKI
         yErxWs2vkdC13RO94hB3BQutMclPHXy0f1Xr/b+bipU1BqDZTE27l8xzOGGCFDqLMHR0
         uKiOWOmmta6zKnL54OdB41f7cODellUFJjCiFBZfYbNNwOZx4gCzDvi4Q4EAyxOurGhf
         v60ElhwItlEECCtLE5l+9390oNYn/WnPCsK/Uhpe7RaJ9XU0gLRcxw7xJlglUwx7AEt5
         Ol+A==
X-Forwarded-Encrypted: i=1; AJvYcCVBsrnvzwezkaMaRuJMCvTN9le8w1EF2+pqK2bghcZYNZ7CUldsssM9zphfADUqexAgSag60VbrHHHHK+v9@vger.kernel.org
X-Gm-Message-State: AOJu0YygIgF+pFc7CtleEG9tXwLuMbc1Ec+sV79ROFtdyHMiZ1CQ67Mv
	h1n6WF2lAE5vWljflVPDkUEg0emBoQtQDvO/ZsHz8r4CpxIGqFeNUew1diFgkvGt1SbHennOqte
	bJLJzkz+YAIBQ54Y0k5pUgjmakY64hkw=
X-Gm-Gg: ASbGncvIHnHv8Ps6rUAWDSAqWar1W7ylzGd7nQDpvPJSfme1vj8rERLnLqIrBjb8Rk+
	9gOdVgjSMT3IMOswhA5Yo1Q3lch8RxpttpSGD28PHQu2w5Su6sjj4DJ9L/PcPn8PoX/MSo88SRK
	uYzuXBL7ICoAboERQoG+R9S5YQOI1M77wb7Y4WJh8IpzOz/YwbV7XcrqL0KO0lbbc6JELC66c/0
	UrYEUiXREmEewqgkUo0cJj51zduLx5u+ofbUn33KeuvZXGuj0dwh8wse66zwrSDwRdM0pJdjRlL
	iD56W4syDP/hA8hb3E20d/ewP06EAg==
X-Google-Smtp-Source: AGHT+IGzG4L1zsLSrPolVgz53k8qLjyW8wdBsccQu20dip4z2Ulliwm8dDW4Lw75AwMHZ0hiIPIToqA/2u2N+i4Tu34=
X-Received: by 2002:a05:6402:34c6:b0:640:abd5:8642 with SMTP id
 4fb4d7f45d1cf-64105a477d4mr5755119a12.21.1762419788438; Thu, 06 Nov 2025
 01:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820014.1433624.17059077666167415725.stgit@frogsfrogsfrogs>
 <CAOQ4uxhgCqf8pj-ebUiC_HNG4VLyv7UEOausCt5Cs831_AnGUg@mail.gmail.com> <20251105225609.GD196358@frogsfrogsfrogs>
In-Reply-To: <20251105225609.GD196358@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 10:02:57 +0100
X-Gm-Features: AWmQ_bn2fAKjP1LvxTPOzsC5eSdfONWi8mVFNaKjNuG1RFoEXsyn3eS71zosukU
Message-ID: <CAOQ4uxhqVQYZvgNp=yN_u9rqoEw4wZ_YuAfwnpgrnduBruNMbg@mail.gmail.com>
Subject: Re: [PATCH 02/33] generic/740: don't run this test for fuse ext* implementations
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:56=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Oct 30, 2025 at 10:59:00AM +0100, Amir Goldstein wrote:
> > On Wed, Oct 29, 2025 at 2:30=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > mke2fs disables foreign filesystem detection no matter what type you
> > > pass in, so we need to block this for both fuse server variants.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  common/rc         |    2 +-
> > >  tests/generic/740 |    1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > >
> > > diff --git a/common/rc b/common/rc
> > > index 3fe6f53758c05b..18d11e2c5cad3a 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -1889,7 +1889,7 @@ _do()
> > >  #
> > >  _exclude_fs()
> > >  {
> > > -       [ "$1" =3D "$FSTYP" ] && \
> > > +       [[ $FSTYP =3D~ $1 ]] && \
> > >                 _notrun "not suitable for this filesystem type: $FSTY=
P"
> >
> > If you accept my previous suggestion of MKFSTYP, then could add:
> >
> >        [[ $MKFSTYP =3D~ $1 ]] && \
> >                _notrun "not suitable for this filesystem on-disk
> > format: $MKFSTYP"
> >
> >
> > >  }
> > >
> > > diff --git a/tests/generic/740 b/tests/generic/740
> > > index 83a16052a8a252..e26ae047127985 100755
> > > --- a/tests/generic/740
> > > +++ b/tests/generic/740
> > > @@ -17,6 +17,7 @@ _begin_fstest mkfs auto quick
> > >  _exclude_fs ext2
> > >  _exclude_fs ext3
> > >  _exclude_fs ext4
> > > +_exclude_fs fuse.ext[234]
> > >  _exclude_fs jfs
> > >  _exclude_fs ocfs2
> > >  _exclude_fs udf
> > >
> > >
> >
> > And then you wont need to add fuse.ext[234] to exclude list
> >
> > At the (very faint) risk of having a test that only wants to exclude ex=
t4 and
> > does not want to exclude fuse.ext4, I think this is worth it.
>
> I guess we could try to do [[ $MKFSTYP =3D~ ^$1 ]]; ?

Yeh of course, either that or [ $MKFSTYP =3D $1 ]
if we do not care to add pattern matching.

Thanks,
Amir.

