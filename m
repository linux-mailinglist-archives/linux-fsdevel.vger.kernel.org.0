Return-Path: <linux-fsdevel+bounces-20312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9FB8D1533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40CD1C21A4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 07:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526B37344B;
	Tue, 28 May 2024 07:18:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AD6CDBA;
	Tue, 28 May 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880721; cv=none; b=LPmEEsh07UyIlUK29WfjYISDtdewZzZ/QSjnJV8z9i/r6zbDfMggqzQkNAWzO3/FlqT4V17I414aWJOjDrTV5/xRLGbDiQaWXGyaO6hyId7J0U502A6aCK1coypi73zaSdowSfAsaJCLPBI1TEPBdmajwkLp+pQ8HSQOV7HnSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880721; c=relaxed/simple;
	bh=eG4LXGkkd6GmLi3x6o1Z6RIyQtsF9v/WsFvQ4zoy1IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxzVMlhTw9SzZp+S6uopcZtDUD6jOhiBgTGJ9Vhwq4vtwJ1maOkY33GRuWqZz/DmFLlMkqZba5RCcHwLqGoriyo2RFoXai8Wlc2baWIfXaMFjjn+mk56NB6f+zAJsmwRFeBidLoMt/9X98WlBKzbCh+si9YilaqTezbgoFaj4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a0849f8e5so4500907b3.2;
        Tue, 28 May 2024 00:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716880717; x=1717485517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4vWByfoXKu7LePUaFaZdnCiQrprLNnYlLwjH2lySYo=;
        b=Iv+WcHf4rXeW0D9OnlturhWk9uyrp62bRM/djD9azEPCNrrHG/Iwxp6wlEe82X9K3l
         GuVB4cvA4Wr0fN/u0zdkCek1rJgHBvAmKlnwxcUqWo872Ge2mIWACGbQce7YXiupDbuH
         4HdpkXixDFxqQniuqgEVIwkyc2lBOJPzhjz5vq/j7masNgj4Gbm5zBJrtIO4FKYqjbQx
         nmw0lFXl23Ouk4Yb74Fs3H7E1HTpClK8kc4QkBU8lnwyPPAPj9wF0qPOcQAwT8miJB5G
         piWq4VVSvA2G77OFbrE9Jqd0fCDXFb7mT1aa5K/9BK1YAJalGQgFu6K/lqPKAP8vVcWV
         yKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWChC7ATqaC7awHiTB1hbgKvWHUbpGTmqgHhnFRRqe4j/Y4xzeo/6cWXGAud4rghj3r1tNsWXW7A5e4Zy96TeM5glHg3QUJDtavMmRu1cx88hDTqjiabKYTNZfBYsEcBbBbv0M3Nl0KvVvrKTTxcn2WFBsYRtt6DxbJYgRl1dDv9zkcB4yepCb1K4Ff
X-Gm-Message-State: AOJu0YyZlTQIKDVqmMO3xTIYg48VlJyuufjv56nJnzNZ1xBUGQXVrW2+
	47CtMh7cXZ8cOU/0zp+SLmRjYjhsI6sH1+xRKD4iOHkM71ZtWDApOINuXWRs
X-Google-Smtp-Source: AGHT+IEKtwcEGIgNzN4R2vyyvTLuJM6McQgqdQfXnTgWUFOH77n1grT/1HRTLF0Dtf94hgZLG2rxpg==
X-Received: by 2002:a81:431b:0:b0:627:96bd:b1d with SMTP id 00721157ae682-62a08db7105mr110276367b3.26.1716880716978;
        Tue, 28 May 2024 00:18:36 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3c329dsm19498887b3.36.2024.05.28.00.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 00:18:36 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df4e346e36fso537344276.1;
        Tue, 28 May 2024 00:18:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSSQbRZyyjy/JRUgGdS/0MUhXNtWWf4DDI46SN2U36Hq2eUOnBjMblkK0BQqSn/aDtOLIXVu71WF8z7jFdEC2tL5Z7Py1A7RzGfh7kb3hGMn4vQK+TLEvim02GEPsVa+N427Wu0iTB7AeYvsI0K7fqpmMhGwIJg9N1ITK2D1jwzrf/P4toa5NdchE3
X-Received: by 2002:a25:c788:0:b0:df4:e621:d2e5 with SMTP id
 3f1490d57ef6-df772222b88mr10773188276.41.1716880716231; Tue, 28 May 2024
 00:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x> <202405191921.C218169@keescook>
In-Reply-To: <202405191921.C218169@keescook>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 May 2024 09:18:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUTy7G6fUa7+P+ZionsiYag-ni_K4smcp6j=gFb9RJJg@mail.gmail.com>
Message-ID: <CAMuHMdUUTy7G6fUa7+P+ZionsiYag-ni_K4smcp6j=gFb9RJJg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates fro 6.10-rc1
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Mon, May 20, 2024 at 4:39=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
> On Sun, May 19, 2024 at 12:14:34PM -0400, Kent Overstreet wrote:
> > [...]
> > bcachefs changes for 6.10-rc1
> > [...]
> >       bcachefs: bch2_btree_path_to_text()
>
> Hi Kent,
>
> I've asked after this before[1], but there continues to be a lot of
> bcachefs development going on that is only visible when it appears in
> -next or during the merge window. I cannot find the above commit on
> any mailing list on lore.kernel.org[2]. The rules for -next are clear:
> patches _must_ appear on a list _somewhere_ before they land in -next
> (much less Linus's tree). The point is to get additional reviews, and
> to serve as a focal point for any discussions that pop up over a given
> change. Please adjust the bcachefs development workflow to address this.

This morning, the kisskb build service informed me about several build
failures on m68k (e.g. [1]).

In fact, the kernel test robot had already detected them on multiple 32-bit
platforms 4 days ago:
  - Subject: [bcachefs:bcachefs-testing 21/23] fs/bcachefs/btree_io.c:542:7=
:
    warning: format specifies type 'size_t' (aka 'unsigned int') but the
    argument has type 'unsigned long'[2]
  - Subject: [bcachefs:bcachefs-testing 21/23] fs/bcachefs/btree_io.c:541:3=
3:
    warning: format '%zu' expects argument of type 'size_t', but argument
    3 has type 'long unsigned int'[3]

These are caused by commit 1d34085cde461893 ("bcachefs:
Plumb bkey into __btree_err()"), which is nowhere to be found on
any public mailing list archived by lore.

+               prt_printf(out, " bset byte offset %zu",
+                          (unsigned long)(void *)k -
+                          ((unsigned long)(void *)i & ~511UL));

Please stop committing private unreviewed patches to linux-next,
as I have asked before [4].
Thank you!

[1]http://kisskb.ellerman.id.au/kisskb/buildresult/15176487/
[2] https://lore.kernel.org/all/202405250948.JeFBsoxZ-lkp@intel.com/
[3] https://lore.kernel.org/all/202405250757.U8G0SdUV-lkp@intel.com/
[4] https://lore.kernel.org/all/CAMuHMdX04q-af8BVWqGgeG5gkZrrDJWsnrJh5j=3DX=
G97vrdTQrg@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

