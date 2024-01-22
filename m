Return-Path: <linux-fsdevel+bounces-8411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3575583604B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FD4288D6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 11:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA71C3A8FA;
	Mon, 22 Jan 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7Kuibwb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0153A27B;
	Mon, 22 Jan 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921343; cv=none; b=jaVFNgQbGWXck2PIpES4CuQ5BteoAWeyI5TAkfH6guxeyWQKReNPwlK52OTuLyGLNYXr5bgHMV5AlLY5c4YXYTxCSo7t1hb8lidnWbF17quJLP5XjHDfxZSNIwY7iWmZYPfqUbDjQV6+om55H8sj6X/TC6Z0HfI3M9AYX/aXHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921343; c=relaxed/simple;
	bh=8gUsGOjD9YP0iDHyZAGJHZMPpDKBiz7lZX9fJx+/4G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMGZKkO+Wi07XljWadnvsFqpXajyKUgywxFKu0BitbqAQ24cxCWEIMuSK+zWem8u7WKgJICx3loV5KI7HJj2qoTZQ6/YYVChdwU8+n2zXNAT9Xk3cCJTvNYSztU6kQgCZgirPk6ugq2EPdCdo2t2tz4/ZqebLRuFxpQ6bjog5Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7Kuibwb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso3570815e87.2;
        Mon, 22 Jan 2024 03:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705921338; x=1706526138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XEM8HK9MzMAP7SMXuKJPDZgtk2XEhhSMXfxWrnbRBa0=;
        b=T7KuibwbwocLAL6YfitQzuS+Zgpfo86G3GlFYE0T2YHlIooCJV5EqSboxJmGSIiKn0
         yc8C5vupj8hWxv/MYAJpOhb0f2oMDxPxEep+3jhJoq18JgXUvWjkOdwcuEHUZ0s7w4FC
         k6/kN2DW0OpvgG3GJnFbm0AdPupBNEnRCpDI8Gr7tsK02Db8352+ocp86DGrFNLgW6Zk
         1NMu1UEJdBf7EIcbZdDsKNUn1E65CZdZNFxeNJx4ncOMWKcmmtMI5hfFvtcfctAHs9h5
         RiMgew2W/jRm36Z76oBjr5P/JFGOlZCu3j4r0tP4eu6XD61RkaQGKilGETnHteD/5zkp
         zwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705921338; x=1706526138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEM8HK9MzMAP7SMXuKJPDZgtk2XEhhSMXfxWrnbRBa0=;
        b=Ny1crkLzIgskOJ25MfuM/6fEX2VDWtBfYjgqb0+jwR1OVRaAwGveWXNH74+ufkee8s
         qg5CEmsrho5+zQsYcBYCG+3Ypw4nSOOcXBOjvSiPuiErit8aZTQrN00wI6ccPl5Itwe+
         utD28Hj244uCdBuCeafS4ItYwjvdOsJ9Dsqti6ysMQW3AWuEhpJK3/kmuE5n4ontT/p0
         Cr001taRh47690SLxei0ukgeHZsc+4/2e3JHp/y0E0QpK2cijUmOX/59cZbo7PQqXl0t
         6Yn4C9eibe48w0HdgxIAiEr2w5cxHWinXfoo01K6LuTUl16y9Id5Dn5yYrLMb/GFVb0e
         spJg==
X-Gm-Message-State: AOJu0Yz5wzHkeAHH1VxNpSQ39pkcW3nbp3pVc53NliGw4dN+X5etEghG
	tvxYPFk0v6BPnO0L+VQLFqMeIbdYg7DHYF+1KYXHuMd4zVISTHjJeB9qlZHrvguLKisJVaipSZB
	exRTSLj1QODiGuFGyVqMLl1eVm/o=
X-Google-Smtp-Source: AGHT+IEsxY3yWZhSDIWVwKDU2WuujYESZYUaZh9OU/xEwm6QHepspTMmLW9p70u+yDEvCP6XE3LVSD5JV4hcXnYZmGE=
X-Received: by 2002:ac2:5e76:0:b0:50e:7b34:c18a with SMTP id
 a22-20020ac25e76000000b0050e7b34c18amr620208lfr.111.1705921337901; Mon, 22
 Jan 2024 03:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1850031.1704921100@warthog.procyon.org.uk> <CA+icZUUc_0M_6JU3dZzVqrUUrWJceY1uD8dO2yFMCwtHtkaa_Q@mail.gmail.com>
In-Reply-To: <CA+icZUUc_0M_6JU3dZzVqrUUrWJceY1uD8dO2yFMCwtHtkaa_Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 22 Jan 2024 12:01:41 +0100
Message-ID: <CA+icZUWYSxfFHf5A56h9b4uOYYaANNxo2Z+cpwP1Bs1pF8MXQQ@mail.gmail.com>
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

On Mon, Jan 22, 2024 at 8:33=E2=80=AFAM Petr Vorel <pvorel@suse.cz> wrote:
>
> From: Sedat Dilek <sedat.dilek@gmail.com>
>
> On Wed, Jan 10, 2024 at 10:12=E2=80=AFPM David Howells <dhowells@redhat.c=
om> wrote:
> >
> >
> > Fix the size check added to dns_resolver_preparse() for the V1 server-l=
ist
> > header so that it doesn't give EINVAL if the size supplied is the same =
as
> > the size of the header struct (which should be valid).
> >
> > This can be tested with:
> >
> >         echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc @p
> >
> > which will give "add_key: Invalid argument" without this fix.
> >
> > Fixes: 1997b3cb4217 ("keys, dns: Fix missing size check of V1 server-li=
st header")
>
> [ CC stable@vger.kernel.org ]
>
> Your (follow-up) patch is now upstream.
>
> https://git.kernel.org/linus/acc657692aed438e9931438f8c923b2b107aebf9
>
> This misses CC: Stable Tag as suggested by Linus.
>
> Looks like linux-6.1.y and linux-6.6.y needs it, too.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dv6.6.11&id=3Dda89365158f6f656b28bcdbcbbe9eaf97c63c474
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dv6.1.72&id=3D079eefaecfd7bbb8fcc30eccb0dfdf50c91f1805
>
> BG,
> -Sedat-
>
> Hi Greg, Sasa,
>
> could you please add this also to linux-6.1.y and linux-6.6.y?  (Easily
> applicable to both, needed for both.) Or is there any reason why it's not
> being added?
>

Great!

I forgot to CC Greg and Sasha directly.

Thanks.

BG,
-Sedat-

> Kind regards,
> Petr
>
> > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > Link: https://lore.kernel.org/r/ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com/
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Edward Adam Davis <eadavis@qq.com>
> > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > cc: Simon Horman <horms@kernel.org>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Jeffrey E Altman <jaltman@auristor.com>
> > Cc: Wang Lei <wang840925@gmail.com>
> > Cc: Jeff Layton <jlayton@redhat.com>
> > Cc: Steve French <sfrench@us.ibm.com>
> > Cc: Marc Dionne <marc.dionne@auristor.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/dns_resolver/dns_key.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> > index f18ca02aa95a..c42ddd85ff1f 100644
> > --- a/net/dns_resolver/dns_key.c
> > +++ b/net/dns_resolver/dns_key.c
> > @@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payload =
*prep)
> >                 const struct dns_server_list_v1_header *v1;
> >
> >                 /* It may be a server list. */
> > -               if (datalen <=3D sizeof(*v1))
> > +               if (datalen < sizeof(*v1))
> >                         return -EINVAL;
> >
> >                 v1 =3D (const struct dns_server_list_v1_header *)data;
> >
> >
>

