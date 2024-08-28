Return-Path: <linux-fsdevel+bounces-27535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D1962447
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026EF1F254CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08452168486;
	Wed, 28 Aug 2024 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqBqAjzk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4EC15B968
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839566; cv=none; b=ChObaJ81PsiMgi7/nMhz0X5jloyUjW8vj/s31tLKPCIejk+MyCOlNKFg8Hnfn7gTRIlQj8WTeIEdlfWWAuLYceRAwjBBjCFXmb+RDTLNYtwQ0y4H/vfMGZ0hOBNifppGBYi4la7IQ11pOs4d5Xh2TTSboR9cvoS01r/emoOfQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839566; c=relaxed/simple;
	bh=exOPVmwq9nLVd8sZp5sHoNGlxuth04s+cDcWHHA4kyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY8ov6+/FKaRqg1IgeJw8nv8roZ+jit5BzDqzxLVxSlGpI7lQt0I6yhwEt7jdy5f54pmWdDsf7oKhtcDQwi/vaeAqfSBGh3YNFD8ZLOTvcWXtl8yNQXv3igV60D4cwAa/07bnvXQvDNyXSBvxZwiQZiaPAxiMOb+NqQT49uNoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqBqAjzk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1da036d35so413487685a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724839564; x=1725444364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exOPVmwq9nLVd8sZp5sHoNGlxuth04s+cDcWHHA4kyg=;
        b=RqBqAjzkGGaSkj5SvBHcqKMdqJhle7oA2RpCToeZEfTAeFB+EhBKRWo6ENKGvOHjW6
         OhP3fowDCFMUQI7UHUgsJxYrGW5Z7w1LeQLVDFPAHbtyGjGTgfAm3eGdCdsfGS27YJmy
         YOgE9Ex5ud4VdDoKaeh3HXA6ZbtbjBR8Q9N0b4Goq+FO6cdbXLndjE1nb9+YxtdqmOYA
         ZCCmFv9LbdrNB51gVevXarwQduI1biSD4C+DwJ62cHggwR+KrugcFVP+5z61+9ieGt3i
         HIPTd7WtE3ULiXl8BZWbR8pOnNfg2Q9GlEUIo7CweQDYquSgz7LakxOd8deIaiQDnmyE
         4z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724839564; x=1725444364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exOPVmwq9nLVd8sZp5sHoNGlxuth04s+cDcWHHA4kyg=;
        b=rBrYw2Z6v6N4W8npOK0VHdphhHaqdp33Ae3w1ukXBMafcOc0wZSizunCicqGaVW42o
         xzDy3G/P7gRBexdFRKJyi0QctixSAVsiJBmUVd5pDcaoMHuK2qOcwDDx59NPtFfilnVO
         oONE+rMOkzEj43mhkO34IzODrdE1Flcy45Bc/rEbswMkllEXZel+Y05lKyQ+XmD04sNY
         uKgpqg/erBox7eooPnYrcUpdVrFXrfZTw4eKyS79j1Gu0sM+COHrcJub8JGAhKam27zj
         +czmtlw0nif8BNQ98kQy2y2RCd37hwVkSpb1Ap76dWFRyl63jEhbD9a/F+i3kbcw0TYS
         VZlg==
X-Gm-Message-State: AOJu0YyHgBJR1KWMgFikGVarAfOKtq5asmmhZDoOiHO4rmcz8t48io+r
	Wzbf81cWntIpPBje1WbK4Auv8VGyNwX4BZNEiwsQoqOGpzTgW+p+vmgWbDqVZoDomXN98/dnqWz
	yg+JXDdiTMCBJ2Ac+jz7K8ATMnC4=
X-Google-Smtp-Source: AGHT+IHC5dQn5K2MIsvSsa4HqH9s7MKrpahW7+2fmuhlRcXAdKHIGrhYuo/d5M6dYPrr8hS7tuFymCFnE9Vt+IWqZlw=
X-Received: by 2002:a05:6214:5a03:b0:6c1:6a71:970e with SMTP id
 6a1803df08f44-6c16dc94e15mr193131956d6.5.1724839563665; Wed, 28 Aug 2024
 03:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
 <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com> <CAOw_e7YnJwTioM-98CoXWf7AOmTcY29Jgtqz4uTGQFQgY+b1kg@mail.gmail.com>
In-Reply-To: <CAOw_e7YnJwTioM-98CoXWf7AOmTcY29Jgtqz4uTGQFQgY+b1kg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Aug 2024 12:05:52 +0200
Message-ID: <CAOQ4uxhApT09b45snk=ssgrfUU4UOimRH+3xTeA5FJyX6qL07w@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:00=E2=80=AFPM Han-Wen Nienhuys <hanwenn@gmail.co=
m> wrote:
>
> On Tue, Aug 27, 2024 at 3:48=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
>
> > BTW, since you are one of the first (publicly announced) users of
> > FUSE passthrough, it would be helpful to get feedback about API,
> > which could change down the road and about your wish list.
>
> I guess it is too late to change now, but I noticed that
> fuse_backing_map takes the file descriptors and backing IDs as signed
> int32. Why int32 and not uint32 ? open(2) is documented as never
> returning negative integers.
>

It seemed safer this way and allows to extend the API with special
return codes later.
Why? what is to gain from uint32 in this API?

Thanks,
Amir.

