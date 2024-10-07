Return-Path: <linux-fsdevel+bounces-31264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EDD993B3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 01:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3CB282AB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 23:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C316190055;
	Mon,  7 Oct 2024 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuZVWghx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85917279E
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344052; cv=none; b=p1nwTrOHI1iEM+DpPHCjRkwT2fEsK++0PeFSvakRVrwIYCSLYuY/i/5EQsL6jbtxwvrcap+E4dgbgTE2E9umFwCp/7/+mDYoWWJoHjLIC/OOmw5Ysi8fTKM1j4wBkMaskCbUyUGSwBEmakIYHFHRVRKwVvRdT08Bp8SeRo9uhIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344052; c=relaxed/simple;
	bh=31i13373D7hjydGNkXUzyHoWoEZHSJM+HBCGF/6GeLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hakcqn+KxkXBI2Sj/OTbf1QIteKeLPsvaGWdkK/Y0SeAj2CNEO4n1tEPNVB8NeOSvp7vDCx2BArF+stHs18SeyXUNNEc6jD3pVwyjFyK6pMw9FRqxuZfoE0ZGDuf49z8oIKMFZ1IqmsRuHyi7HLeujQ6ckJ9h6HzA+FKQIAFOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuZVWghx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42f6995dab8so107795e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728344049; x=1728948849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31i13373D7hjydGNkXUzyHoWoEZHSJM+HBCGF/6GeLg=;
        b=CuZVWghxLC/z9FWdKa4DXebixUXU35dd0kGSjmtEg/jMMOK2nQZs/Y+fGOJ6nbaqpD
         aLKzhakr7m/XJvCLWMy2gqYrpRIn+tpsx243yyHuSkaAWh++xS6R/DrBa5AMu3s2zD4l
         /z3d1STBfKxzqrOgYoCr9351CPiHRfmVnjWIrCQyjM7CO6SWPJu7WCJWVWu2LkjV+zmq
         GlvzKQc/mJkQErd6H9lO+Djb16q5/LrzxAw79dwQ5zJrH38SzLQYpOsSnUaJq/GxPMe2
         SMe+BR6rfXOA9y038HKdBw0TOOXT+yD/rSv+zrZInbff02fO4yWmFqEYGO/8x/rfTHYd
         /gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728344049; x=1728948849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31i13373D7hjydGNkXUzyHoWoEZHSJM+HBCGF/6GeLg=;
        b=ucXzK1Jzf2IiIvtjQDXXcYBMzauyxSAPuB+ZckIsmGU/o6Z0YlDrqwEkhcJy6tFbtS
         XTWW7uPQlyN+KWexd5zp/9WTKXmxamQa/3+gt9JMoMN+YKPhxl2yYS7zwjGPuzKRguFm
         uQxSF4HeWMszk9Vul23uGpvbyCBd01bdo64S+9skemwfDa+XweVrmro7HJV96bh8POiq
         SibI8UL+eMCU8s1rW/OGUQbMO1U3gAbStoiEkSqZvuoqNWUk8A2eDQfad96kMUdhq0Rq
         55SKcAtm1ZfW/1jDNLA0Q3R4l65Mt+jJxYz4NDi5/TDOlsYTlYgzh4PihTu2/P+ZApVV
         SaSg==
X-Forwarded-Encrypted: i=1; AJvYcCUlxQoAm6xxraH9OqGjL3gl5WWQsg/lR46u4h5XUDgW9JjThpzdiAr7hJiIojtOf7/nsJq8g9k5cKZrD1V/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+abC6n7Z906iI0IpzS9gFkEttWw1p9D2Gll5n8Hmwn6dG+NVR
	Ci62xpaerF6dJNV5B5MquHCMBzX3TNJQwHlv/bMCQZAxKeQGM60yEqysK7+JUq3oB//xz2yRKc7
	8uxkiGfwt2zZgNwWnxh8OdYY7kAKYHObzaSfb
X-Google-Smtp-Source: AGHT+IGIt7Fwqy3Pp7BHopSoM+TcDYPhYnnQ4DFKz14Gm8T6iB9xp1mSDJ2OSyz3D9vFqJOGu81NMdE2fTX+gXKnSJ8=
X-Received: by 2002:a05:600c:5010:b0:428:e6eb:1340 with SMTP id
 5b1f17b1804b1-42fcdcddf49mr2008895e9.4.1728344048449; Mon, 07 Oct 2024
 16:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
 <20241006043002.GE158527@mit.edu> <jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
 <CAHk-=wh_oAnEY3if4fRC6sJsZxZm=OhULV_9hUDVFm5n7UZ3eA@mail.gmail.com> <dcfwznpfogbtbsiwbtj56fa3dxnba4aptkcq5a5buwnkma76nc@rjon67szaahh>
In-Reply-To: <dcfwznpfogbtbsiwbtj56fa3dxnba4aptkcq5a5buwnkma76nc@rjon67szaahh>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Oct 2024 01:33:31 +0200
Message-ID: <CAG48ez3S-COLHLR37LA_XyPxMQLCYpT+H68heA3yfBxKpyhuLg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 9:29=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Sun, Oct 06, 2024 at 12:04:45PM GMT, Linus Torvalds wrote:
> > But build and boot testing? All those random configs, all those odd
> > architectures, and all those odd compilers *do* affect build testing.
> > So you as a filesystem maintainer should *not* generally strive to do
> > your own basic build test, but very much participate in the generic
> > build test that is being done by various bots (not just on linux-next,
> > but things like the 0day bot on various patch series posted to the
> > list etc).
> >
> > End result: one size does not fit all. But I get unhappy when I see
> > some subsystem that doesn't seem to participate in what I consider the
> > absolute bare minimum.
>
> So the big issue for me has been that with the -next/0day pipeline, I
> have no visibility into when it finishes; which means it has to go onto
> my mental stack of things to watch for and becomes yet another thing to
> pipeline, and the more I have to pipeline the more I lose track of
> things.

FWIW, my understanding is that linux-next is not just infrastructure
for CI bots. For example, there is also tooling based on -next that
doesn't have such a thing as "done with processing" - my understanding
is that syzkaller (https://syzkaller.appspot.com/upstream) has
instances that fuzz linux-next
("ci-upstream-linux-next-kasan-gce-root").

