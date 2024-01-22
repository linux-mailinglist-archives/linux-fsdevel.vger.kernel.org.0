Return-Path: <linux-fsdevel+bounces-8415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F8836222
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C654A1C210C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BDA4653F;
	Mon, 22 Jan 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2wktsU/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69C482D9;
	Mon, 22 Jan 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923134; cv=none; b=nXHtPWF0DN3o/o5ppbwFH9H5ZptweqMovV0KuZe95rfyeahIxk7QyLta/pHAA+ZzaYedbFhluuB0kZLcJSJu2MfFdAcdnGuvR9I5U0riDAtmKTIxJQGDrnB5d1DdSAfsKdwBVm/jxESn+S2Xm1c2lszgQr+hHepNKpQnGVEr5VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923134; c=relaxed/simple;
	bh=jIWbdhazF1DtsVh0QU7A3sMXExHW1xlwHLYRk2ok3JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mddYbSCA4fm/xHDpdi49hSpZaR99jBFaNSCnLTrJUhISyk44DKWcqcLxKJ0lmtyJMyiQPHoFkDfkDWZd4swTotke4bY76F/F/c7vfCaSg+7ONwrhGyZNy5U9G+cIN24MEoQSED20nRQ6e9K+F5IXlrTLNfPY/p9ayzBK1d8IMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2wktsU/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50ec948ad31so3218903e87.2;
        Mon, 22 Jan 2024 03:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705923130; x=1706527930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DPbIVtQUATMQ9HXAYvqkNgY9ZzASBXmb6XQmjxVPQJI=;
        b=Y2wktsU/SQyvf9cBbsO6aW9XDcAo/bjxm6+9SKSf15D2tULKCYhp2RQZ42MvtUSTt8
         p/tEgv2f5b8xVJ/pmT4u9KKCIpMUWRd/RKgAxzRwMmTeTf9Rc+LWaL8EDpLjXGp+DXDV
         mSYQfpbdn8kl2PIbvUzPH1SNzH17jbnNC9ACJcw04z65Hyo8Mgbf5xMmTnr6av2O3Gwj
         8hafpuPUaoksQHJoUlTX9e0hKvMILOmGDnPt+CYlT46gQ86Gmkrqh/nhDsXX6nUEhSNg
         gjg16c0Fx8XGC30BErSuvv0YdReUeFV+CKNCa5QHZvnqBXG087PxYZ2C6awTRunYB4vk
         WytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923130; x=1706527930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPbIVtQUATMQ9HXAYvqkNgY9ZzASBXmb6XQmjxVPQJI=;
        b=Z4kKvnBvLdlac3DMWHL2WOFRbnKbs1nn+uFlKINxlRegzg96EMs1sfXEihtKLlm/mv
         Fgyi6WzrQcBxolyx1YQFR6OotyBP7b0oz1tR1VqaRZK6/dwixsjkN73bUUC1KBvMDoPs
         l9BexicdJXpsMoLEc4zsljxaaXN/UT7mvU2qVkFIxe3bIfLSqZTQRU+qegIFMyY93yFC
         IAWL4GXpeNU76huZFM3dau1NTDiGXigBi6CBbxA2eGxLh61sj04PIn5eMe6TreMtFomD
         0Y3E5HmvB5H+IJtbgP+IXmmK6+X7LBV8jB0w7cWfG/IMyRCNoN5eRhwuRuGLiiP8MQ8E
         a2iQ==
X-Gm-Message-State: AOJu0Yw+rGDvdTkTdWFINXPbsayARwzEzm7i2zgjgsRIRfb+7+RsurF9
	7WF7R5pqziykDtlkCXcfkfLvo8keoOKP4Zuq9aItuvqEdAmPh0tdccFHdDiEDjci+BCrTEFPWYi
	ASBVcJGxXJ4QxyX4owO28+7sjtUE=
X-Google-Smtp-Source: AGHT+IE8q+aq6bFKrhgG9BSySHiV+tD954Tn/cVZYKhwVGHb0K+uUjH7ovE9Bu9iAyd12VXTVTX6Bsn87zFzzMIkblM=
X-Received: by 2002:a05:6512:3d1e:b0:50e:80db:3c35 with SMTP id
 d30-20020a0565123d1e00b0050e80db3c35mr1745864lfv.80.1705923130168; Mon, 22
 Jan 2024 03:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1850031.1704921100@warthog.procyon.org.uk> <CA+icZUUc_0M_6JU3dZzVqrUUrWJceY1uD8dO2yFMCwtHtkaa_Q@mail.gmail.com>
 <CA+icZUWYSxfFHf5A56h9b4uOYYaANNxo2Z+cpwP1Bs1pF8MXQQ@mail.gmail.com>
In-Reply-To: <CA+icZUWYSxfFHf5A56h9b4uOYYaANNxo2Z+cpwP1Bs1pF8MXQQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 22 Jan 2024 12:31:32 +0100
Message-ID: <CA+icZUV5zbsm4=wceT7+nzCrCw7S8SkKonTevFBpNTgvzbHT8g@mail.gmail.com>
Subject: Re: [PATCH] keys, dns: Fix size check of V1 server-list header
To: sedat.dilek@gmail.com
Cc: David Howells <dhowells@redhat.com>, ceph-devel@vger.kernel.org, davem@davemloft.net, 
	eadavis@qq.com, edumazet@google.com, horms@kernel.org, jaltman@auristor.com, 
	jarkko@kernel.org, jlayton@redhat.com, keyrings@vger.kernel.org, 
	kuba@kernel.org, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, marc.dionne@auristor.com, markus.suvanto@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, pengfei.xu@intel.com, 
	smfrench@gmail.com, stable@vger.kernel.org, torvalds@linux-foundation.org, 
	wang840925@gmail.com, sashal@kernel.org, gregkh@linuxfoundation.org, 
	pvorel@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:01=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> On Mon, Jan 22, 2024 at 8:33=E2=80=AFAM Petr Vorel <pvorel@suse.cz> wrote=
:
> >
> > From: Sedat Dilek <sedat.dilek@gmail.com>
> >
> > On Wed, Jan 10, 2024 at 10:12=E2=80=AFPM David Howells <dhowells@redhat=
.com> wrote:
> > >
> > >
> > > Fix the size check added to dns_resolver_preparse() for the V1 server=
-list
> > > header so that it doesn't give EINVAL if the size supplied is the sam=
e as
> > > the size of the header struct (which should be valid).
> > >
> > > This can be tested with:
> > >
> > >         echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc =
@p
> > >
> > > which will give "add_key: Invalid argument" without this fix.
> > >
> > > Fixes: 1997b3cb4217 ("keys, dns: Fix missing size check of V1 server-=
list header")
> >
> > [ CC stable@vger.kernel.org ]
> >
> > Your (follow-up) patch is now upstream.
> >
> > https://git.kernel.org/linus/acc657692aed438e9931438f8c923b2b107aebf9
> >
> > This misses CC: Stable Tag as suggested by Linus.
> >
> > Looks like linux-6.1.y and linux-6.6.y needs it, too.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dv6.6.11&id=3Dda89365158f6f656b28bcdbcbbe9eaf97c63c474
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dv6.1.72&id=3D079eefaecfd7bbb8fcc30eccb0dfdf50c91f1805
> >
> > BG,
> > -Sedat-
> >
> > Hi Greg, Sasa,
> >
> > could you please add this also to linux-6.1.y and linux-6.6.y?  (Easily
> > applicable to both, needed for both.) Or is there any reason why it's n=
ot
> > being added?
> >
>
> Great!
>
> I forgot to CC Greg and Sasha directly.
>
> Thanks.
>

Addendum:

Linus says:
"
Bah. Obvious fix is obvious.

Mind sending it as a proper patch with sign-off etc, and we'll get
this fixed and marked for stable.
"

https://lore.kernel.org/all/CAHk-=3DwiyG8BKKZmU7CDHC8+rmvBndrqNSgLV6LtuqN8W=
_gL3hA@mail.gmail.com/

-Sedat-

> BG,
> -Sedat-
>
> > Kind regards,
> > Petr
> >
> > > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > > Link: https://lore.kernel.org/r/ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com/
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > cc: Edward Adam Davis <eadavis@qq.com>
> > > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > cc: Simon Horman <horms@kernel.org>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Cc: Jeffrey E Altman <jaltman@auristor.com>
> > > Cc: Wang Lei <wang840925@gmail.com>
> > > Cc: Jeff Layton <jlayton@redhat.com>
> > > Cc: Steve French <sfrench@us.ibm.com>
> > > Cc: Marc Dionne <marc.dionne@auristor.com>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Eric Dumazet <edumazet@google.com>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > >  net/dns_resolver/dns_key.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> > > index f18ca02aa95a..c42ddd85ff1f 100644
> > > --- a/net/dns_resolver/dns_key.c
> > > +++ b/net/dns_resolver/dns_key.c
> > > @@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payloa=
d *prep)
> > >                 const struct dns_server_list_v1_header *v1;
> > >
> > >                 /* It may be a server list. */
> > > -               if (datalen <=3D sizeof(*v1))
> > > +               if (datalen < sizeof(*v1))
> > >                         return -EINVAL;
> > >
> > >                 v1 =3D (const struct dns_server_list_v1_header *)data=
;
> > >
> > >
> >

