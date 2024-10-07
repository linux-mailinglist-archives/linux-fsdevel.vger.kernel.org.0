Return-Path: <linux-fsdevel+bounces-31190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE01992EED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505232834B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0731D61A3;
	Mon,  7 Oct 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbo9e4rp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D01D6DDC;
	Mon,  7 Oct 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310882; cv=none; b=kFH/PHKJTSb6SkKu4QMIcQYuNiTOPJsq04RKjl16VLHLEN35KbR7JM7ubBOd0UynPEygY0GskYGKxLfTPm/PGoD8ggVo8xjsmxVaEbFk97g1kc9Cw+nT+VpSeEdFLuj2PVgqEMlcL/2LP3mixhRf2HGfakZrBq/9sEF+vMvsGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310882; c=relaxed/simple;
	bh=ch6/7cgrpsmrHEwwIBUlOGdRppXZ9IxbBTvPTtdewKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1ASOQmyp/EOCzKKvYkW6VcHtlcnCkRTXPK2jaAWuO4QaosJenYE3FIvpKQznpx1Bcl0XnYcXXwhNwAYe/8Pck7SoHSUBh2d44BkejOblQoSFEaBH1rlfxm3WGSirVUcocqXzUwsqobNytwJP2gKGvynUAcENY82gMvTvHeL8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bbo9e4rp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99de9beb2so239950085a.3;
        Mon, 07 Oct 2024 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310879; x=1728915679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch6/7cgrpsmrHEwwIBUlOGdRppXZ9IxbBTvPTtdewKE=;
        b=Bbo9e4rpbKgyP7OP8lp07O65gD1yfTyc2+K3OfFB0SJWEvagVyTxWioPKYvQoC3yZ/
         Rb3n/+bSp3HpVAXgdoSMx2wkR7wGb18FfftBwGIqC0DCyv7giQDjEbikz8LYs/VECivp
         PLPUJs6fvUwsrCvlABbH8GeSrL6TwPuxugd6eb6Eb8baG36pYfkGXx40Ewc0gJQ4vOZn
         AI/DCCxWIKj4O4w10mpoFIlZ94ix460gj75DvyXLZXz3n13QGrEPCTcx0Yqu70Xsq+QF
         STfEy2RQVcjLUg5aRdJGwz+7oL56Kp8xi/wjtBaKDFykyyYSQ0a61svaX45yU+vk938t
         ZgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310879; x=1728915679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ch6/7cgrpsmrHEwwIBUlOGdRppXZ9IxbBTvPTtdewKE=;
        b=Z0XmYC2vEV9TEtAD01eJoiIKVDC1whQCltewmiEhxSX1fy9tKPdMf6u4gabq4g4rHR
         jU/q0F5sGY2HjGkFxxz1uh1jRom975HLMckOwCFS579tqeReAt0HnjCroDL9aWF0G6HL
         6a0sIVmqJh6XE7TNJm8rqPuzW7UkwFpTm/atxG9naJcEtcPwy5C49Efgew9lIg8Wg/cC
         cY6deZBf8hvBYPbO7NB+IXK6tRMa1YXrSNI+3VSBvPMUVh0mMVEILFQfrjmLvZgmQKZl
         qWUsqYNiCceHgtP+oo00X3AipbuqY4SIEgw9a8N2GR/68vUOrCUjOIXuOBSdBQhcjuLu
         jNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxML52jHVlP+p48gNynNtWzH3DbVAYM4yNB8YUGgVMh1kzZOKcW0O4Ox58nLg67qz6HcteJtpEHOFpi9OuRQ==@vger.kernel.org, AJvYcCVA4JM+M5kWLimaXSQfE/bZ53tRNZ9UkTdn+oLrbXydOFftzxVjRNl0//44HICjSEytE9z0d2BQTkC55JMx@vger.kernel.org
X-Gm-Message-State: AOJu0YytReLaIGlojb5eKsa1IlWOevG+m808fM7H6u6w+sa81NiWUACy
	GXDTTKW78T2njNxRZImNv2A8QOatgdusn1pqyH0OluITEnZ5MZCpnL686RH+HBMlPrD/AE0hu+/
	KbJva7lM6zxx1R/WOp1JKWL8geC0=
X-Google-Smtp-Source: AGHT+IHT2Vw006wgZpWJ2td/9XjfYp/mFcOIdtIIhSgF1bxYsE8QoMC/+zT+gypO4J3TE+e0NpuHYFcQmgWF+QnyaHU=
X-Received: by 2002:a05:620a:3705:b0:7a9:bf33:c17a with SMTP id
 af79cd13be357-7ae6f44cd13mr1974691685a.33.1728310879179; Mon, 07 Oct 2024
 07:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082359.263755-1-amir73il@gmail.com> <CAJfpegsrwq8GCACdqCG3jx5zBVWC4DRp4+uvQjYAsttr5SuqQw@mail.gmail.com>
 <CAOQ4uxjxLRuVEXhY1z_7x-u=Yui4sC8m0NU83e0dLggRLSXHRA@mail.gmail.com>
 <CAJfpegvbAsRu-ncwZcr-FTpst4Qq_ygrp3L7T5X4a2YiODZ4yg@mail.gmail.com>
 <CAOQ4uxi0LKDi0VaYzDq0ja-Qn0D=Zg_wxraqnVomat29Z1QVuw@mail.gmail.com> <20241007-trial-abbrechen-dc2976f10eb3@brauner>
In-Reply-To: <20241007-trial-abbrechen-dc2976f10eb3@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Oct 2024 16:21:07 +0200
Message-ID: <CAOQ4uxhm896AYzv_j=X7jLajJTQ_9mC7YaCTHDidFzg=zzjgnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Stash overlay real upper file in backing_file
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:12=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Mon, Oct 07, 2024 at 01:01:56PM GMT, Amir Goldstein wrote:
> > On Mon, Oct 7, 2024 at 12:38=E2=80=AFPM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> > >
> > > On Mon, 7 Oct 2024 at 12:22, Amir Goldstein <amir73il@gmail.com> wrot=
e:
> > >
> > > > Maybe it is more straightforward, I can go with that, but it
> > > > feels like a waste not to use the space in backing_file,
> > > > so let me first try to convince you otherwise.
> > >
> > > Is it not a much bigger waste to allocate backing_file with kmalloc()
> > > instead of kmem_cache_alloc()?
> >
> > Yes, much bigger...
> >
> > Christian is still moving things around wrt lifetime of file and
> > backing_file, so I do not want to intervene in the file_table.c space.
>
> My plan was to just snatch your series on top of things once it's ready.
> Sorry, I didn't get around to take a look. It seems even just closing
> your eyes for a weekend to a computer screen is like opening flood
> gates...

Well I just posted v3 and it leaves backing_file alone
which I also now agree with Miklos is looking much nicer.

So whatever changes in lifetime of backing_file that you wanted to make
feel free to make them.

Thanks,
Amir.

