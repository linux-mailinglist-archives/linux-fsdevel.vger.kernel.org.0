Return-Path: <linux-fsdevel+bounces-65220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED4BFE50C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 23:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B1C3A3EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 21:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF3302745;
	Wed, 22 Oct 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3c6RejX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9930215D
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168598; cv=none; b=BUoEGS4aW4sgNdeMursK/LjHGto5ult6YzZA/c06t9tn+QUONCplfUTMy0SNHPV/jFupsbCM5OxifzqHAzSAD/vgl+1Oq0WLe33exOqJYxVrqt8b7onFPIuMQcoUiehMYRnoezUPR3On4/mYl2uJaZmFE72FOgb5Iu1l2FEzr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168598; c=relaxed/simple;
	bh=ayOApx8Butz/DI2ZNgnXqibAPGah1Q/2eBjJynsS5o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzZJd/699zchj9qvG6bhTCy7Dd9RM7b71pBrUhyL13ASIHsJAajHpcpsX8xowj3s9tKAb1ldfggXAzjk+mT/XmFiAexrUm0jHNrAaFU+l2dDgKLJUEvJjfBSVQQ3Bhw77cmBDV8zZE+ZkqVlSCYAlkU4eU6gMA5hI4+uJO1dkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3c6RejX; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e8a9b35356so923091cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761168596; x=1761773396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGcpyzxhIdWl+pChOcbgeDTPTEpNNoR0nzc133dbw8k=;
        b=X3c6RejX2oH0ivPIdiApvYcYSlfXdGxieU4+JkuJKI2gKIfUZqqU4XaZuSPV6FtHeJ
         eZX3ijyEs0nUcrU9GQaFL1+0LFVMknzoCeeBXsBq6O8vNLX7a5Hb6I3RRfSsBFFFUwAg
         na9W/o2NeUMYgAGzY9jV5Ti0s0frGRhajMRlGk0TCBTR7wXaLyZnSDOFVLa733DW8TLd
         ZfHijUfNakTV4EIsVycK2/SmdzAa7XW6fgcbQ1HEbKYyWinRRj+FyB2/bHV1ypV8PzV+
         NX4mbjoFtUIjmzs8H4SRoXt9o4L2ML8QXrlCYGUC1opdJJfOO+cQ045r3HbeZRIcIlC3
         19SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761168596; x=1761773396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGcpyzxhIdWl+pChOcbgeDTPTEpNNoR0nzc133dbw8k=;
        b=kt0oR/NQU3FlTF28lqfEXWWoZ7izMl6ZRDGaBPe7Ala7afrm9LmP8ddiWe2cTcfKXe
         CL4SgPO97NioKORc7i3L5dsZkLuHYkgukLGjDSEVvXoc5hDPP+14TJS+8DTyNBYaFcLf
         eU6QVLo/YYlxU2eD+EQFzs2Jw0Sv+SfZxadjru+bUYEg7Yg8pcxy03kfYpiTM6tB1iaP
         j0Kqpo9P8YBS+8wFITBE7ecKXCfSsE4YPsvcmljKri/TG0lrtpgjCWcis4gXi8+oiKpj
         GbseKoSBpoxuSG1aD4RxYi2r8/KEC0WJdcJtbQkB7MuNUl0LTmW4j+GONjdAJj+h94WC
         8peg==
X-Forwarded-Encrypted: i=1; AJvYcCXNfVg6iHUt7xg7E8+gYZwlVwNwsuEAVH4spBDSWI8JuhKvNu+XUJEsLDQ0ZbE0tGBiChP11/YgeZSYhTV7@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlxihOYNAbCJCG8j3MN4M+c2NuBIK9LifH03di9G7hke9mqLn
	0xivegof8fTvCLayvQTFY/u5HluSQMzmywP+SPKuQfB+DH80rsf6gX4wfKWrcRiQKybDHs5PnX2
	yxU5rKRGMDMprYNqBcJt0YnHirZOW97s=
X-Gm-Gg: ASbGncvzEjMyHd056sGFhNxUreSGxBAj6SlagdplfsBH0+h08RNUZspA7XkliCAUdt+
	S55X/Zo91mSdiuivyiXNhOREnIfdO/4b8UxgMFdqHE5ngTc6toalogV5NGxkTuvNr2ador08AmT
	KbmpThv2sOa8L2hyb+blCUAWQ1FjOhUETLq8ayOCFF9CBUjtcPqJOFLnY/UU2t34eIXupSItvms
	G055m/2mgM+5ZYbeWzxDcgUUNHos0TzUAQncKnT0ttb1PXAxTBwcvRg3TL8Twf5LVzunOtva62g
	9s5oAAqwAJSs3JkQS6kIHJkhWL0=
X-Google-Smtp-Source: AGHT+IHC847SQaOoXUlqKuCCe+jWq34RK4c+/7e+hHdWE/EuHvv8/y6LzMe4fqpVoP4dgGBHUcZMJjGnXmItpfdWcjk=
X-Received: by 2002:ac8:5fc3:0:b0:4e8:a437:de04 with SMTP id
 d75a77b69052e-4e8a437e5dcmr253800351cf.84.1761168595940; Wed, 22 Oct 2025
 14:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021164353.3854086-1-joannelkoong@gmail.com>
 <20251021164353.3854086-4-joannelkoong@gmail.com> <aPjo2om1maIKdCEE@casper.infradead.org>
In-Reply-To: <aPjo2om1maIKdCEE@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Oct 2025 14:29:45 -0700
X-Gm-Features: AS18NWAtCCnZUGfmqkoz5ds_LKimI1_xsH6zF9bGgqFq2tdxzV9WvAMu720oIG4
Message-ID: <CAJnrk1ao+YzTXd7X357hsESTeXRTzpz-oVrAyBj7qe3sOro3YQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] iomap: optimize pending async writeback accounting
To: Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 7:23=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Oct 21, 2025 at 09:43:47AM -0700, Joanne Koong wrote:
> >  static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
> >               struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
> > -             bool *wb_pending)
> > +             unsigned *bytes_pending)
>
> This makes me nervous.  You're essentially saying "we'll never support
> a folio larger than 2GiB" and I disagree.  I think for it to become a
> practical reality to cache files in 4GiB or larger chunks, we'll need
> to see about five more doublings in I/O bandwidth.  Looking at the
> progression of PCIe recently that's only about 15 years out.
>
> I'd recommend using size_t here to match folio_size().
>

I will change this to a size_t. Thanks for looking at this.

