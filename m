Return-Path: <linux-fsdevel+bounces-46111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E99A82A70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B44597B364E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E760525F78F;
	Wed,  9 Apr 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOvNArT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB51482F5;
	Wed,  9 Apr 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212654; cv=none; b=uiApqznbEZYjdd0/hOdnKB2gb7MabIZ+e5xLMe4lSPZkmJYD/GUx/EUvxTLPRFc6HVl9f7otPYn3Vy86aP+DG3zoTEGvd0VaT43XeE4ydNRfsB1dkw3QjsAU2IRklS/E3Z32+plTscODDwYpmDRiXPvOsPx+2doEoihz++KMblY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212654; c=relaxed/simple;
	bh=Lv3aR6y91VqMNyNN60Ebth9lnnvzEykRZA0nfMOulkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n79u4ofxSR5Bir0oBQPV0VvgAMkI82SsFz2IHCCcY8dkpDoTMoge89169diTfRRxYEReCDzKs58gQRHtoRKB7uiFMbnhimo0xuVtO/YHpvau040GUKdp0eQ8vBGjjNn84RVH1XwuVaXsyXJax6h1HcFl8H7eg6dBe41eU2iC2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOvNArT7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso9170335a12.2;
        Wed, 09 Apr 2025 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744212651; x=1744817451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lv3aR6y91VqMNyNN60Ebth9lnnvzEykRZA0nfMOulkk=;
        b=WOvNArT7uiRamzQ4HVSJesvogUTqdlwKFFJ8OdshzziznDxKWnjGCI2U7titCmyVhd
         mbipdnNc/8eIdICUHN91ixz+xYkSNg+ENM/OeOVT+6RCep6jfA1uUZ9NGNflfCZ/MLA5
         syeCQxxcu0wy8xxGrTFMpDmrlQ2/ZQDA+sJrrBsSuJp4YL3v5VzYq1WoHNOcjRQWg1q3
         IOGVW1l978KEycmPTBEYaKbcQkWRWm4pAIFce4zHdICvfhPo7iymppP9seHdRFikz6xb
         rBxbH2hPZaRi6bnEEZol4PFD/KD75S/sbsmGGMcgoWg8xhFM7X3bVwD/sdtqsSiMefEZ
         22fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744212651; x=1744817451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lv3aR6y91VqMNyNN60Ebth9lnnvzEykRZA0nfMOulkk=;
        b=IVdvfRgVUjUKdArsFbqNZImeQNa4O5zG6GiOXw+Jfigk8f25aIXj2wdS7R3z1moIec
         8gfmbbAa99hsqfRdbSbtv4N3u/X8rQ0n2twrGGMsGI+8UTznVcxEOLtQ5AwVh+va0+qX
         5vWmnUsEVZyJvucARdMkdlnL9MFhnIqkB+xhm6fRBr8B00DkZisqws33GLlSlwyBfILi
         GFb9360IhfNkVOJaWyAP9vM/hKB3WUopRJd0mMvaVMnNk2VWSu+w8F9ygwhlgb7MHkYV
         CL5T8zJ/pZ/gqM06Y5Ah79e/K2OmqaBSBXkPvZZ2pxIMEHP+KEPQxae5hfPsH9EVLnCo
         BDYA==
X-Forwarded-Encrypted: i=1; AJvYcCUZXt/vkFZu80/LMF4cFC1QZG8b0gwS4IZirN1C9D39OfHUoK75xrLNY+d1qZZEDakXqdBxCN6ys5/OdSAs@vger.kernel.org, AJvYcCVqWr2leQ1wUjasW788RgYAecd60aqiyAqA3dTpPQ0ZfbTLhHHFkAKh0e/wfaezbJVs5DsFGrt4wjjNUf3gag==@vger.kernel.org, AJvYcCWQEXj0qv9zi8iuLiMb89kpmX+8VHBhFUG1Ps/n/87HSCvTXKEVWYk3/oDMz5DGYirJYzNh4Ah8QN4n9aER2rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8qZwP1sztkxoAuggnjnVwS0cxSrOTY0f+CgX7VQbl9++y5gE
	FqOdQoyYJqTi7AN1HJQ4Kss+gkZ8RTzv1vlAW1sxhT2sPP5G40v/CDKi3jYS/z9m1Og8J6dXthh
	PLb+WgOZkZT6QfnOu3jBiIzDelnQ=
X-Gm-Gg: ASbGnctxVGH7qogkKh6PVy7AT1af+6y0k5xJTMGeSvUIYVsTAGbuSUajPeTZnAfE8vo
	CBTKHX0J/d914wxJ+qWlUrEytrgmyXGFwHIQ87qm27flNbacYyIwEemjCMfITYQZxzg0inpJUAJ
	jBUYo3r/PGfLAXCV/21n+1Sg==
X-Google-Smtp-Source: AGHT+IHvitnv+3/0mIo+f9FNqlfRXpjgvjdKkr98dNctXmoT602f2ON2oacvhL/Ld8WjlnYa782gHamRenVh9cWvU0E=
X-Received: by 2002:a05:6402:90e:b0:5f0:a6bd:78d3 with SMTP id
 4fb4d7f45d1cf-5f2f8674ceamr2197377a12.34.1744212650437; Wed, 09 Apr 2025
 08:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409143138.568173-1-colin.i.king@gmail.com>
 <llt32u2qdjyu3giwhxesrahsh5a2ks6behzzkjky7fe7k6xync@pvixqbom73il> <1862386e-fca2-470e-929c-0205a56c0f2f@gmail.com>
In-Reply-To: <1862386e-fca2-470e-929c-0205a56c0f2f@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 9 Apr 2025 17:30:38 +0200
X-Gm-Features: ATxdqUFmWRtzhqbsKBUX-0gwa5_W82rtqfbTr3CbdFnp_ZZuDQDYdYUrvU09SeA
Message-ID: <CAGudoHFafkZ5DRoAeP0-7M9DPEvnwfPVwGN5aKoxYPcF=mEszA@mail.gmail.com>
Subject: Re: [PATCH] select: do_pollfd: add unlikely branch hint return path
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:23=E2=80=AFPM Colin King (gmail)
<colin.i.king@gmail.com> wrote:
>
> On 09/04/2025 16:18, Mateusz Guzik wrote:
> > On Wed, Apr 09, 2025 at 03:31:38PM +0100, Colin Ian King wrote:
> >> Adding an unlikely() hint on the fd < 0 comparison return path improve=
s
> >> run-time performance of the mincore system call. gcov based coverage
> >> analysis shows that this path return path is highly unlikely.
> >>
> >> Benchmarking on an Debian based Intel(R) Core(TM) Ultra 9 285K with
> >> a 6.15-rc1 kernel and a poll of 1024 file descriptors with zero timeou=
t
> >> shows an call reduction from 32818 ns down to 32635 ns, which is a ~0.=
5%
> >> performance improvement.
> >>
> >> Results based on running 25 tests with turbo disabled (to reduce clock
> >> freq turbo changes), with 30 second run per test and comparing the num=
ber
> >> of poll() calls per second. The % standard deviation of the 25 tests
> >> was 0.08%, so results are reliable.
> >>
> >
> > I don't think adding a branch hint warrants benchmarking of the sort.
> >
> > Instead the thing to do is to check if the prediction matches real worl=
d
> > uses.
> >
> > While it is impossible to check this for all programs out there, it
> > should not be a significant time investment to look to check some of th=
e
> > popular ones out there. Normally I would do it with bpftrace, but this
> > comes from a user-backed area instead of func args, so involved hackery
> > may be needed which is not warranted the change. Perhaps running strace
> > on a bunch of network progs would also do it (ssh, browser?).
> >
> > I have to say I did not even know one can legally pass a fd < 0 to poll
> > and I never seen it in action, so I don't expect many users. ;)
>
> I did check this based on gcov coverage (mentioned in the commit
> message) and this is based on running gcov data from running stress-ng
> and kernel builds and I've been looking for branch hint performance wins
> based on the top 250 if statements that are not already hinted using
> likely/unlikely.
>

Well now that you mention it, the commit message claims *mincore*. :)
I presume not edited from a different submission.

You did not specify what you fed to gcov in there though.

The kernel build is fine.

However, stress-ng intentionally does weird things and can't be used
as an argument here. It just may or may not accidentally line up with
reality and any wins/loses have to be analyzed for legitimacy.

I just straced ssh and firefox, both of which poll and only with
non-negative fds [that I have seen], so I think the patch is fine.
--=20
Mateusz Guzik <mjguzik gmail.com>

