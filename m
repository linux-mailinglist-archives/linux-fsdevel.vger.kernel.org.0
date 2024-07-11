Return-Path: <linux-fsdevel+bounces-23572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7787F92EA43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 16:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320FF281043
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD11716133E;
	Thu, 11 Jul 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nhe0sg3r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD015218A
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706817; cv=none; b=AcKfQw99QcDv/8XiwZqDhVnG9sIFdZDnzOEkXJXDXpkKriENXtuovoyDIRAaX6gctK8qxLYBBrhRe+0A1yxsk1Keo03iMRhI3Gr9h3FAdWPIQcx5MuY7PPciiBCxnLgIdHv04KaLLFtUIyraSQ1WYstu5HhG82jG8dM8Yrm6SY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706817; c=relaxed/simple;
	bh=/LJntVGckN7+Mm5JjaItmJFTbNIfdKRitOyh9FjN9jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ1f+IFcccxv7nv8HRSCXfLzIFN0p3/A0GVU8fk+st/9Iw4ygih9KM08QdPi+uFTf08M9I8+8uVsQbEKAWugTlUJECSUGahEZoVHC2LlFq37/bwo0nK2pjjW/qhNosjLxku3sqaI8cekP9MzdGg4pf95qkK0s4gr9nC7EhyReMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nhe0sg3r; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64b3655297aso8666707b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720706815; x=1721311615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIPNti1s2/HNmMC/IZjSDG03fTpEhLPjzEULCFaJzl8=;
        b=Nhe0sg3r/l3FHItlCMjROPPUsneIdDc6em4U5k7ZIEOCx0msnePDvV/fRqcCkgv81V
         ZH1WRBN5Yqmz6Op/RLZwjC46s9JfIGgbrUkulQL2EpZ8DEMPL2Oe858VV4vcfHhCCryx
         +8U8UJ7D5MhMcY3cuO49vswggdZKYqplQzX7+5+chfldDOtPeBKwSDNC7IsdejJ7JujR
         8H5Fzbl/1d9xLHm76UUfB78hnmh55UNE/0ZjaADqTFfau4rCvgtXItS0NgRB6NYFcbPl
         HUPqkdMS039iNj0eXLEP41eRth+FkNQDIPHTRJQySfB+6aJiR3Y5SCCRbRtbvAqEDAWq
         0hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720706815; x=1721311615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIPNti1s2/HNmMC/IZjSDG03fTpEhLPjzEULCFaJzl8=;
        b=r4Xk0YyJnY1YRPUOMMjzTNgvdtAO4MbPAU7+Hgc9lvgDuyH5numi0DjAaOZ82J5OJy
         ed+vhDgf8GE/hhOYRzpW1j8iZ/X8rh/XAz7njuGg7IhEjdAg9S7hnWsj6vbB+eol8LkM
         lDJjN8mKWaDnk/Oj59hbSIH2YmF3UqJD/ZzBJknkjWA1sto3HUidJimtK2DDg5K+Mvb2
         bih0NxW7sFaQnZ2+RlFGYDMsS1yR3WJ8SOkB7NeOlj6fZtG0+3aoDaSG1DeRrlNTA1Gm
         weV7N23jdhpJbF38kvLs0gJ4KveDfUQ39X8gnQFcg80fI0r/z1yaphjn2Wf1hQwBxyfn
         Gd3A==
X-Forwarded-Encrypted: i=1; AJvYcCW48kMHHZJIaOrNm1yHbGASi0+7bgUHzlGnbMRfmdbHhrFh0sbRY/UaylSmtWkPY5xFE7g6x6t1BWYoZclpqFzvUVJ3BReZopQT73pLjw==
X-Gm-Message-State: AOJu0Yws3QrbkqAOBpcu/DfTvp0RAdwCH0xBq2CigflK2bHueM75JM6H
	X9aON2i3lkrc3Ays/CaB098cw7i2fuVXpOs7j7jeCA8G5DxtpIPOmiGlt7syd7Bvqq8cxOAUK9r
	gq5Cce+Xfo5a5s7o4ksN9g/bq1JWrxRNpLc60
X-Google-Smtp-Source: AGHT+IFuspm27tfeFqYCo1mM1up+6/KBdHFCOyNzTDo6zxPKaW5nKhYAVDWMkqQ6+wQZpi4uFLUZhsZMyCfRvdjmzo8=
X-Received: by 2002:a05:690c:3385:b0:62f:2553:d3b3 with SMTP id
 00721157ae682-658ef3414eemr119351847b3.29.1720706814862; Thu, 11 Jul 2024
 07:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000076ba3b0617f65cc8@google.com> <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net> <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net> <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
 <eb168f2f-948b-4a3b-9237-92902f0c7438@I-love.SAKURA.ne.jp>
In-Reply-To: <eb168f2f-948b-4a3b-9237-92902f0c7438@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jul 2024 10:06:43 -0400
Message-ID: <CAHC9VhQUqJkWxhe5KukPOVQMnOhcOH5E+BJ4_b3Qn6edsL5YJQ@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] general protection fault in hook_inode_free_security
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Kees Cook <keescook@chromium.org>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 8:32=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/06/28 3:28, Paul Moore wrote:
> > It's also worth mentioning that while we always allocate i_security in
> > security_inode_alloc() right now, I can see a world where we allocate
> > the i_security field based on need using the lsm_blob_size info (maybe
> > that works today?  not sure how kmem_cache handled 0 length blobs?).
> > The result is that there might be a legitimate case where i_security
> > is NULL, yet we still want to call into the LSM using the
> > inode_free_security() implementation hook.
>
> As a LKM-based LSM user, I don't like dependency on the lsm_blob_size inf=
o.
>
> Since LKM-based LSM users cannot use lsm_blob_size due to __ro_after_init=
,
> LKM-based LSM users depend on individual LSM hooks being called even if
> i_security is NULL. How do we provide hooks for AV/EDR which cannot be
> built into vmlinux (due to distributor's support policy) ? They cannot be
> benefited from infrastructure-managed security blobs.

As stated many times in the past, the LSM framework as well as the
Linux kernel in general, does not provide the same level of
consideration to out-of-tree code that it does to upstream, mainline
code.  My policy on this remains the same as last time we talked:
while I have no goal to make things difficult for out-of-tree code, I
will not sacrifice the continued development and maintenance of
existing upstream code in favor of out-of-tree code.

--=20
paul-moore.com

