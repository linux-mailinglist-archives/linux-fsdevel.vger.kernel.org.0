Return-Path: <linux-fsdevel+bounces-29844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B78A97EBBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 14:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150C21F21065
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A48120D;
	Mon, 23 Sep 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RGDAnlaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D580C0C
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096057; cv=none; b=Dec9DMhAADavu5zeZpQpFbox6xoZIsxMSA4jZA7sZQHhYC5obaK+b+d2/PDbjr7uGAXydPU1PXFs3XcajC6iSOrgVgXW9JwZ52/MkZcZR8RrFs//Ml7vsaEkbCzEtsphyF41jDBoXrdkBSp4fnXNkr546IuyvW93jPzT4Y5oRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096057; c=relaxed/simple;
	bh=yHaV24M0XY6Z8MogFqF76GBDqHrd4EsvVx0S0Fb6dEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRv/klJskytflSARWjG4tQ9iNuG2oNTrWJ3jxQ77Xuk8aMOQ/z+OMetsdwYkvLpkCWSfsOy8oQyYcI1CpSdsQML8k5T1zEGejEZuIAMcWfud7BcahOapYmReagEw/V36k7yQRA4QQqQ63I8gM7KH1nAe1lQGxPByvsSZEcC5PVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RGDAnlaM; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso3892658276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727096055; x=1727700855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeqpN5RBXiACRu7DZlcjql3sx2b+HXlChW4DouYcVJA=;
        b=RGDAnlaMufNHM/w24uD9899LuyFzdnSsABCsMh4wwPPTK/o+QuQ9HFUl6h0ZgK9GlX
         eTDs2N28QzYEm9TucVOTHv/Ttgf8BM56eTVlFX5mgsguaHuYUD2fYfOaa1TbJ+FOum8Z
         H/sk2mdYfa9QnHJPFtmRDNufYZWdwhVwPTSh6zqgOfGc7kUOd5gq/eBpM5UKvSb4J1KX
         +JAi3UwrgKBY/uUgSMPZulv9eeTONEohjxJXcYmY7FqJqmtCKk1SAvJhdcO+aLr2Y0Jl
         HE9Njg6dRZ16bE4vlBUPdm1Fa9aMmcr+UDmSedVhv0d8wSfLzsP4kVJTs5WRbY44SE3O
         ykbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727096055; x=1727700855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeqpN5RBXiACRu7DZlcjql3sx2b+HXlChW4DouYcVJA=;
        b=NRBeLrIfUYAoNDpkQUbfTHJ8SIqhjxR81o9gTX7w4lgoR032NT2ndyMbdtFMJ1Hq+X
         0W44dIGG5U779IuHN0jHNKJCMxqtPvfI2YyCGI8Ne7SgNqwsxRWISV/5tcZm9UjInNAf
         iY7RYJib6phxRNyFizDzy13W2+u9uESwjpHS9YwQcso4NSf0XkjJvX5858OoSLHuGV+v
         6WoxYQR76eRmd5x+pCY+HNkx/2VYiDlmnTzUeRknxj9aaS7DX9ndKOLgME1fIJdFFvgT
         kb+PQgdM4HU04kuctDGbeAjccLplwIYbcPr21Qp2O1UsY0IAvtRCLoLO47lH1YrobH1Z
         Pr2Q==
X-Gm-Message-State: AOJu0YwDcd6xsBqrohGk2x8H0s+UXYyb7VcgXxG2A8ZIWQeOoKmeToQP
	9nBmNz35lDDW/D2phEgQ8wwzrXfgSmri5mS+4cyV8k9W1xdWL/GeMMK48OFwSFv7g88tIh+h3A1
	+KmU637D+ogMYswHUINRc5mFo8lMVB0epbfhA
X-Google-Smtp-Source: AGHT+IFVTV0oaagF2/9oSyE71YAbHsUk3gFNTb18+2h9R7hFm9/Njq/gibBh4rMLXpuKIj/1OV1gZMnW1KoWZlmVV0s=
X-Received: by 2002:a05:6902:1109:b0:e22:5060:11b1 with SMTP id
 3f1490d57ef6-e22507beaf0mr7968541276.10.1727096054391; Mon, 23 Sep 2024
 05:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922004901.GA3413968@ZenIV> <20240923015044.GE3413968@ZenIV> <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk>
In-Reply-To: <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 08:54:03 -0400
Message-ID: <CAHC9VhQMGsL1tZrAbpwTHCriwZE2bzxAd+-7MSO+bPZe=N6+aA@mail.gmail.com>
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 2:31=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
> On 9/22/24 7:50 PM, Al Viro wrote:
> > On Sun, Sep 22, 2024 at 01:49:01AM +0100, Al Viro wrote:
> >
> >>      Another fun bit is that both audit_inode() and audit_inode_child(=
)
> >> may bump the refcount on struct filename.  Which can get really fishy
> >> if they get called by helper thread while the originator is exiting th=
e
> >> syscall - putname() from audit_free_names() in originator vs. refcount
> >> increment in helper is Not Nice(tm), what with the refcount not being
> >> atomic.
> >
> > *blink*
> >
> > OK, I really wonder which version had I been reading at the time; refco=
unt
> > is, indeed, atomic these days.
> >
> > Other problems (->aname pointing to other thread's struct audit_names
> > and outliving reuse of those, as well as insane behaviour of audit pred=
icates
> > on symlink(2)) are, unfortunately, quite real - on the current mainline=
.
>
> Traveling but took a quick look. As far as I can tell, for the "reuse
> someone elses aname", we could do either:
>
> 1) Just don't reuse the entry. Then we can drop the struct
>    filename->aname completely as well. Yes that might incur an extra
>    alloc for the odd case of audit_enabled and being deep enough that
>    the preallocated names have been used, but doesn't anyone really
>    care? It'll be noise in the overhead anyway. Side note - that would
>    unalign struct filename again. Would be nice to drop audit_names from
>    a core fs struct...
>
> 2) Add a ref to struct audit_names, RCU kfree it when it drops to zero.
>    This would mean dropping struct audit_context->preallocated_names, as
>    otherwise we'd run into trouble there if a context gets blown away
>    while someone else has a ref to that audit_names struct. We could do
>    this without a ref as well, as long as we can store an audit_context
>    pointer in struct audit_names and be able to validate it under RCU.
>    If ctx doesn't match, don't use it.
>
> And probably other ways too, those were just the two immediate ones I
> thought it. Seems like option 1 is simpler and just fine? Quick hack:

[Sorry for the delay, between flying back home, and just not wanting
to think about the kernel for a day, I took the weekend "off".]

Jens and I have talked about similar issues in the past, and I think
the only real solution to ensure the correctness of the audit records
and provide some consistency between the io_uring approach and
traditional syscalls, is to introduce a mechanism where we
create/clone an audit_context in the io_uring prep stage to capture
things like PATH records, stash that audit_context in the io_kiocb
struct, and then restore it later when io_uring does/finishes the
operation.  I'm reasonably confident that we don't need to do it for
all of the io_uring ops, just the !audit_skip case.

I'm always open to ideas, but everything else I can think of is either
far too op-specific to be maintainable long term, a performance
nightmare, or just plain wrong with respect to the audit records.

I keep hoping to have some time to code it up properly, but so far
this year has been an exercise in "I'll just put this fire over here
with the other fire".  Believe it or not, this is at the top of my
TODO list, perhaps this week I can dedicate some time to this.

--=20
paul-moore.com

