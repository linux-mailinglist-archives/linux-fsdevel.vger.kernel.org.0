Return-Path: <linux-fsdevel+bounces-32338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA8A9A3C57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 12:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5963DB283F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20179202F85;
	Fri, 18 Oct 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N0LPbRsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586E204F61
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248861; cv=none; b=mAsrToLmbYs/YF/7f6D+MJnj2WDFfTOKtGNTRAsHbY7zIrH9v+8sFwnahvTwoBhtuKH2shKzNCkePlUOiHR3I2OIuTI/SenaUQ8+l5SX5wSvNZswl4JHqGu5+iSrTp6Vm8wjLsAEGHePUQPFv5TTNQVGm4OavuYUEHQhWUJDwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248861; c=relaxed/simple;
	bh=4KdIkPIu8+BVH/HhxDVkrlnmCaApwKvkSreVyNO50nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SadYFWnKLXnJM6KiAjYF1dVp66QGcrDcr+4Ujy3YPPt1rYy1Mtr4tcps/sDqeLYeXD6lRJRtNq0lVPasC3Hji/RwjQclOuXw5BoBvL8MUJcMPQnLbhb281QXt+is3QPCxMWwMLBxGr6EjpF/SR2/UjoWqrdqBlNkk1JrcQGgOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=N0LPbRsl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9552d02e6so2289548a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729248858; x=1729853658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GAUQbRgxeTaGabj2y30qoVfCLTrJkkrVwRxImKaAGOc=;
        b=N0LPbRsljKPakgISvZst6DDhm0pC4uIXZ86cUb5oSYQMgMMUGUFWLmFDKQvjP/y9st
         zV0aZ/MYHbKSFVt89TQBD0RxYyI2WDaDgAA8nuEYlfHueOq4V5sz62T14gz7CoZnC7qX
         3rAqAE+fQZ1pAd0FprjsAMLmFB4tRwULrm/h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248858; x=1729853658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAUQbRgxeTaGabj2y30qoVfCLTrJkkrVwRxImKaAGOc=;
        b=wwp1ep1uhuMckNo0HDmkorNNjhYHffjp7V03tCs9Wtq0lg7w8gl9ulfFKSbeT9jNfN
         bppfe7SKrO0wTRN3sZvr5TDPyCsmEXgPzkC/SjRYeiwh6N/jFfhAT58YDl/dxPgMYAeX
         urjBJBDFDv40MgTOZDh47WUObF6XDcs7E/vOvMi4q61fSGf+57Bu6hP8v889Lj8Rp7BF
         fRBfLWL617mZcOWteqbYZKLR7+vfAxPx+9D8Nk9qf58flBZSRw8iHf9Z82AMBT3mkEd0
         bPmMcT4F9MRpDPTEuYrLnl8VSX4ma2N2J/hvOh3GCap7GQa/bzWhXck17taYWc8kbnfE
         CwtA==
X-Forwarded-Encrypted: i=1; AJvYcCUWfM7K5zHY9Jtokl7lMGlefVbs8kVS+SNdfkeNKytu8zXMXPJuCZ5ecPQp03ca96AGAJgJ/J2Lok+cAlv0@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwWiVreMgE+zBfQ6BMEAY2Wb9xeNsxPs+f0ZI5AdBOJ0zKvcJ
	BAlei/9+HbFCx+Cu68UQAS64XX8JkFLLN4YDcT4ejojMf4yHeKfT1kSW6Sl7982c5j6VF3KdxlO
	P0cWvXUv4Xr1gfPPJfUVObjN3SuwQQT7nMBcimQ==
X-Google-Smtp-Source: AGHT+IEUJUA2pq8KDG9toWCxMK1E3E/CZn7+Yka64gVWbmzLoa6UO/Pp4meoP0n2MMwKk05OG44tsPblS7BNCM2AQ9k=
X-Received: by 2002:a17:907:6ea9:b0:a99:368d:dad3 with SMTP id
 a640c23a62f3a-a9a69a8083dmr157649966b.30.1729248858070; Fri, 18 Oct 2024
 03:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66fc4b74.050a0220.f28ec.04c8.GAE@google.com> <CAJnrk1ZrPcDsD_mmNjTHj51NkuVR83g5cgZOJTHez6CB6T31Ww@mail.gmail.com>
 <CAJnrk1ZSZVrMY=EeuLQ0EGonL-9n72aOCEvvbs4=dhQ=xWqZYw@mail.gmail.com>
In-Reply-To: <CAJnrk1ZSZVrMY=EeuLQ0EGonL-9n72aOCEvvbs4=dhQ=xWqZYw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 18 Oct 2024 12:54:06 +0200
Message-ID: <CAJfpegu=U7sdWvw63ULkr=5T05cqVd3H9ytPOPrkLtwUwsy5Kw@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_writepages
To: Joanne Koong <joannelkoong@gmail.com>
Cc: syzbot <syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 21:04, Joanne Koong <joannelkoong@gmail.com> wrote:

> > The warning is complaining about this WARN_ON here
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/fuse/file.c#n1989.
> > I think this warning can get triggered if there's a race between a
> > write() and a close() where the page is dirty in the cache after the
> > release has happened. Then when writeback (eg fuse_writepages()) is
> > triggered, we hit this warning. (this possibility has always existed,
> > it was surfaced after this refactoring commit 4046d3adcca4: "move fuse
> > file initialization to wpa allocation time" but the actual logic
> > hasn't been changed).
>
> Actually, it's not clear how this WARN_ON is getting triggered.
>
> I will wait for syzbot to surface a repro first before taking further action.

I think the issue is that fuse_writepages() might be called with no
dirty pages after all writable opens were closed.  The exact mechanism
is unclear, but it's pretty likely that this is the case.

Commit 672c3b7457fc ("fuse: move initialization of fuse_file to
fuse_writepages() instead of in callback") broke this case.

Maybe reverting this is the simplest fix?

Thanks,
Miklos

