Return-Path: <linux-fsdevel+bounces-38371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84211A010C4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 00:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA48F161397
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 23:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5A71C175C;
	Fri,  3 Jan 2025 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIDhAZpX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08DE1BDAA1;
	Fri,  3 Jan 2025 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945898; cv=none; b=o9QiruFRskPcGF7T4eLQ0fEVFOCso/2qO5wRmIkJ+OGLZ2HxFPYR0YONF4F9bZzxPZzy0B7NTsBXbPrjv0OgEtbgVwuWqKJBj8Ylamn5nDKZHTL5AxaVyZv8XTxHyaJtBm7ZAHzNKBfGUcqJPlVL7XGOpiqRQHwg3Z/camklDYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945898; c=relaxed/simple;
	bh=X4ZcfTqU6IlK7Hy1vojjiwkI3XEvrxPS4Pnc/j8eABI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex5Fhe7fNff4aBgHJxb5eX8isDpcTeY6YJlw3gwQWo3KuD0C2v+hHcn5VTPvcUWbJAyM92wlSiH6K/3QbJPpwava3K5t4GvpI90+bSsBTL79gaH+NtKN5O87Z6m/IAf3Q/NKAJEA47WKz2FEWrYA8cFZQgAlMW8u18FPgCZpVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIDhAZpX; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4678afeb133so115629401cf.0;
        Fri, 03 Jan 2025 15:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735945896; x=1736550696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4ZcfTqU6IlK7Hy1vojjiwkI3XEvrxPS4Pnc/j8eABI=;
        b=aIDhAZpXq8QPR03PlPQBKuow5Q12yC0+Prfr5Gc5lRVXvFIEQC6K3xIkM0zSVTgBrT
         q1Wdaa8vwR28zWm0HwqRWuuBJ91D1h1jFUv8nIzvoG16WplLqIZsL4Rmpx0P/jhm5gmi
         3nNPI4rntMrQQ42CIxPVm4j9138HZuVASkqZc5qqQucixc8Qt0I3jlknuNsuSAQQTPsy
         PYmDbIyZS02OZrwY/uPuynGIorgL2y3b8B7P+lhj+k2pUDo6q6SQdpamZOxMCMpEFk+H
         A6r4A8xdO+BP6RtMuWCWViyD+gL1fsYzjXoI2zT2eqhC26uAHrv6ISO+taVzVzcU439u
         50HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735945896; x=1736550696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4ZcfTqU6IlK7Hy1vojjiwkI3XEvrxPS4Pnc/j8eABI=;
        b=gWLXo/fOVQ9ZCa9Gk8TfCCsU2RKZ9mxgTzZWeTrDKnWJbP40nHyAXEvGH/Dd3febbH
         8h9JCfKtuvA17SPUaNIMPO8STmNjnzw/z7giRIh89tLDH0Pb8fYYoZOwjhzhUkpOH1CB
         ob09UUcUVtXqUU06pTryZVAURUZLTyfIQUJPG6eSV4hBLj5uh+Un9ZglMUwTaAfqa4R6
         +KtrDCJ4PsYN2vzVAXfWlxd7xkXPXzJh9KKOmoh5JKGRzqQ92k6RmpGMZyTAQssbkJQs
         fxpfi3m78fJ/Tj+7sSJRUh7lRLMr3EAU7rq2hutX+Q4MulMstu9m6ym57Cmosd4hXZ3i
         jghw==
X-Forwarded-Encrypted: i=1; AJvYcCWhgg8b0gVjSvafI9ekDesSKyq/s1WZZE7fnjmL8/xCowjNASUyVtHqwq2xIgouc1ZDneuCpIwHG2e59WUc@vger.kernel.org, AJvYcCWyxrvXLglDlBXgqqHW46/UYwqPz6XqPDt3HfU3aqOgMw8DC36zkMhzjzi6oAF5J0fT27GetR3UW2U0S4A5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8fGrPskJcisT3E9T8/4USjxMktmUiSnGBoeGLrV7d/xv0SKGf
	VAL6TCS8OQHwL9LZUGMvLwCwAvbKpScOokxspsT+RUMob6fsf7dOMkfyt80RyOrNc2Da/ovJiVg
	XM7Sck34SOCpPGsZ/SF9pAzGBK1o=
X-Gm-Gg: ASbGnctub8V6CzHqwlCNRkpm6FdzoU34FsdDlp6+ki0oVVL2ZTxZvhdL0QqSilm61J3
	S8iQagzsoetye1vzVbX8GbRRFBYSxn5Odfna1dH4=
X-Google-Smtp-Source: AGHT+IE0sYxgffs8HOAzg4jFNz/ATU6VSq8U82LvRAmkbSGFUdnQbwIZ/8z0CYEzNYlVLHFsgab0L+d4xrZVxGMO4KM=
X-Received: by 2002:ac8:598a:0:b0:466:93b9:8356 with SMTP id
 d75a77b69052e-46a4b188f79mr1002427311cf.22.1735945895818; Fri, 03 Jan 2025
 15:11:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpeguPw9CsK56RHGTfpYhfh4V5Kj8+JHJJo=hJDy39=RB+3w@mail.gmail.com>
 <6776f4d9.050a0220.3a8527.0050.GAE@google.com>
In-Reply-To: <6776f4d9.050a0220.3a8527.0050.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 3 Jan 2025 15:11:25 -0800
Message-ID: <CAJnrk1aumuyz9J1ZWReB+diDXffRQFr1Et1UMoyyuBRf+s272g@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
To: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
Cc: miklos@szeredi.hu, dhowells@redhat.com, jlayton@kernel.org, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mszeredi@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 12:19=E2=80=AFPM syzbot
<syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>
> > #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.g=
it
>
> want either no args or 2 args (repo, branch), got 1
>
> > 7a4f5418

Sorry for the late reply on this Miklos, didn't realize this was
related to my "convert direct io to use folios" change.

I think Bernd's fix in 78f2560fc ("fuse: Set *nbytesp=3D0 in
fuse_get_user_pages on allocation failure") should have fixed this?

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
for-next

