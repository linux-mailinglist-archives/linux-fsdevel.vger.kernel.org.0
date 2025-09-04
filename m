Return-Path: <linux-fsdevel+bounces-60316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E5BB44A4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AD7A4340B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEA72F656E;
	Thu,  4 Sep 2025 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWbsl2zR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04E2F657A;
	Thu,  4 Sep 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027735; cv=none; b=CxFvSxz7FoXyV/fv5IcdWBQnHaL8yBPQwBghhfNMP0tduJlUC5NG24abGs2PA7kdWT33Dup0Rk/CHO76d0IKscVSfxrQ5NdQCorV81XOPylTvF+lw2FmWuKZapuBwfJSp5KecHQDJ9dUcUJy1T3NY8YaWYMliLepSbLX4AdCx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027735; c=relaxed/simple;
	bh=glc6X/lvmgv4+ggBIAX3YdlGe6mGnSSb5/nb9uKZ9vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGE//LMJ3CmozO8Y8o6e1YingQoukYNsf7b2Z1XlzfguFvfPDp+2B1aosWbvaefbTZ4Bt4AfAbY82WDQIjFw9OUTh+iMaBC/p43Xz7EpdPTcIQoSTfsRDb/7KSuzwZtlE8eQ44mTuJWf794N5EAgMFcdMczuvLH8zAvSlGPli5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWbsl2zR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b48eabaef3so18789971cf.1;
        Thu, 04 Sep 2025 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757027732; x=1757632532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glc6X/lvmgv4+ggBIAX3YdlGe6mGnSSb5/nb9uKZ9vM=;
        b=IWbsl2zRkuFoFhIP9ndIN3cKsjgDZ+RV8dqnEvvqmktipQMXAS4NwAOUov67gJDojf
         OymtNemFxDSFbuRI5SBBp1U9jDq8h67V/Mqd78EfKxuxSrkeqNRfE+I+Vr6V9g+ESA0P
         +50+Z1zZTCUgAQCkPgxbCjYdFGxIWY5lj2/9LSORFc0hgMhq2SyuxC+CzCErzs0RjQIk
         /vWgftGmJPFbzSmOvXk3fvQShIomXfb8u/KCJO3Bo34wogdc4eDkIFuagMZLmtMoqihX
         Safep1mQm6S18staRiQGvtdQczwdtZTS8r3odNyT6A00rxCw9ifYpvKvzbZUhS3sSf04
         yGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027732; x=1757632532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glc6X/lvmgv4+ggBIAX3YdlGe6mGnSSb5/nb9uKZ9vM=;
        b=hMRkAkWMQyn0S5EOvKxATmna5sLFremzNYB0uset2ZemvOY3BQWDUAkJSg5Z6Zusmv
         MZG6jiog53SsG9dBjnN3t9owZj4vnNITHEiYHWsttVG+LKnCK6mIh1S/Y4c/b5q9JlyU
         JOlHgRs9Mhe3rxXfWnNHYAn0TV+6eV6Ol/KU6F37Q9F1piWaj+V8s4nn8ke0UKfLkTL6
         n6ZMXBCRaCzBdNtcqDAB1NzhqA4/Vxw6L9Rnav8xehPm6lYpz1wP8+2ckWQrrP1VSfTH
         vzUwkV2jVoAG6JhtP7xFSledpD8IxhLyj8nOSxp8yUg7sT6be/WaOcCGOD/LKOzJwE+X
         gIfg==
X-Forwarded-Encrypted: i=1; AJvYcCV7yj2nnunVh4Anr5adFV6WgxvEZ21SznvHHkZOqKlUOETYwNM2HqUALKaeSXKFzwUY80WAYD3keUOKvTNxGw==@vger.kernel.org, AJvYcCVPzit1vjbkVPqLRUADhjgzMqSRhx79GlFjx7yq+Hx9HlqKac3CpGamyoidhP4jUYxJ7xE1pMgv4Is=@vger.kernel.org, AJvYcCXm0vD+UKjWRplHnOy2p+MQzvvpZUXgEOMrHayghkm6gLf/YaMPRE/YmH7o5l+eySIqHUQLjetTqsX3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4GUOAPV3a3nhuYCQ5WRL+3R87oTGxA36OJchTcTapLytrE+D5
	CzwiXnEAOzbuunUPFYcpMpelUM8cZZq2Zh9sx040OCH0R+bibyHFml/TCMaD1G9xuA3zm7HDqZj
	IqYjVQFHdYXzFv5iETOJUo/I2uPH9iqQ2q36syzQ=
X-Gm-Gg: ASbGncsbN//VqxGsq8nyhL9yOjhZ673etZpMiqIIW2+4Jz0+TtSDrIUF15E5Nkk2gui
	Gp83b57Pt4iQH6HJjVfqP6pXRf1YJNAhQwM/yHJSycy9rdxgMaPbVsASYPVwpf7S3HXKj6U64iw
	nE/YodO0wYjdLBAdEegmaynEvBYEEeVyXLEG1jlFQ3/x7Kry7TkeXpRTYXNIjiPBQ65k07P00DV
	R6F+N1F
X-Google-Smtp-Source: AGHT+IG6XN8UwpfJWu3+RZ17woYr2aRyoi00/E6OZ9xRwJ558hyXT/lCEBx3ar212G9M3w2bMBgaGzO7HdHR/3B6ufE=
X-Received: by 2002:a05:622a:1e8d:b0:4b4:989a:a272 with SMTP id
 d75a77b69052e-4b4989aa569mr89279601cf.47.1757027732391; Thu, 04 Sep 2025
 16:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-5-joannelkoong@gmail.com> <20250903203031.GM1587915@frogsfrogsfrogs>
 <aLkskcgl3Z91oIVB@infradead.org> <CAJnrk1aaHYQLsEtWkoqL-ehGDvpajc53GoHnLjmf=nB7aXQ=YQ@mail.gmail.com>
In-Reply-To: <CAJnrk1aaHYQLsEtWkoqL-ehGDvpajc53GoHnLjmf=nB7aXQ=YQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 16:15:21 -0700
X-Gm-Features: Ac12FXztSMO9wGhL0GPdMYh32nJ4tsnrFqhqpLPfd1D8NTi9mrmJqQ6mzMIF1RY
Message-ID: <CAJnrk1Z3XhyqCyweE8L0o29QudmGMd+14o5uv8ZmvxHFN5Ftqw@mail.gmail.com>
Subject: Re: [PATCH v1 04/16] iomap: use iomap_iter->private for stashing
 read/readahead bio
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:20=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Wed, Sep 3, 2025 at 11:07=E2=80=AFPM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Wed, Sep 03, 2025 at 01:30:31PM -0700, Darrick J. Wong wrote:
> > > On Fri, Aug 29, 2025 at 04:56:15PM -0700, Joanne Koong wrote:
> > > > Use the iomap_iter->private field for stashing any read/readahead b=
ios
> > > > instead of defining the bio as part of the iomap_readpage_ctx struc=
t.
> > > > This makes the read/readahead interface more generic. Some filesyst=
ems
> > > > that will be using iomap for read/readahead may not have CONFIG_BLO=
CK
> > > > set.
> > >
> > > Sorry, but I don't like abusing iomap_iter::private because (a) it's =
a
> > > void pointer which means shenanigans; and (b) private exists to store
> > > some private data for an iomap caller, not iomap itself.
>
> Fair enough. For callers that provide custom read handling, their
> equivalent of "bios" is stored in iter->private, so i was thinking it
> would be nice symmetry to have the two match, but I get your point.
>
> >
> > I don't think we can do without the void pointer for a generic
> > lower library, but I fully agree on not using iomap_iter::private.
> > We'll need that for something caller provided sooner or later.
> >
> > The right way ahead is to have a void pointer for the I/O-type specific
> > context in iomap_readpage_ctx, and then hopefully reasonable type safe
> > wrappers around it.
> >
> Do we need a void pointer for this in iomap_readpage_ctx if the only
> user of it is bios? For callers who do custom read handling, their
> pointer is stashed in iter->private where the whole iter then gets
> passed to ->read_folio_range(iter, ...). It seems like maybe we should
> just do
>
> #ifdef CONFIG_BLOCK
> struct bio *bio;
> #endif
>
> in that case.

I think I see what you're saying now. You're suggesting that
everything just go through iomap_readpage_ctx (and not do anything
with iter->private altogether), much like how the iomap writeback
interface has it. That makes sense to me.

I'll make this change in v2.

