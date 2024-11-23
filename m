Return-Path: <linux-fsdevel+bounces-35653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2399D6B03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 20:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA232161B0F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E05B1925AB;
	Sat, 23 Nov 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L3AxKC6s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFF4225A8
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732389100; cv=none; b=H77XdEOeOyPCgY2HbvVtcP04hdKBOCLyZWXCI/IhrwYZZA7LhjEZmucUkLuewUYuEE7UwPO2pnhVeEfzUpBVmde5QbR+38nKQOZMc5gwahj8hCHMQ0cSFPglXxNEBLmbE18n/tA3ChXIK+TtgmCFEjVPm57g+CjSEDlaaoyG0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732389100; c=relaxed/simple;
	bh=Q3Bv+YAcYdx4Kbghoas2EOnIJDKc082hRcftApY277U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILopitc2KqnBnL44WVT/oDeDC+g6xPO3QR9pX2Cp8qyG6vi/dVemmLP51QJ141HrHAnsGP5oqMTU7G0iTfO4rcwVfwqkeG9Yar7TuUm0BzG3k5QW1EyomOCqxvq/dFVypnVxwG0qv5UhUEW8a0Sspi6b9exu8/rTE2HH7v3I290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L3AxKC6s; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6eb0c2dda3cso40886447b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732389098; x=1732993898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qh9HuRP2TUeXMIAhRQU5UITcyp5cug1fkWSRB28P/dk=;
        b=L3AxKC6szWtKL+zVW1sTZ5HaKDCFETPhuCaMiCV+Wvp2fllG/rcCUU/N1XTGXe53Mn
         7mgW4tZMsL4FKauX5tLC80jXXGv/bTTHhJ/PqBZ01DvqmNyw8ns+fmu41CPNU60QCaQC
         aZCLTNlK4AvYinhclachnr5lnTRjzOYbgmUAU52lV7CX23qsGENbD/BHQXYdTNEimESO
         sY3XnyKxNmcWxJIyAbvWhm2roIC9oHxV2o8hqNaNAfxBN4SGHo4PsqdZv9EDI087ZVcP
         JhanUxBlWsIY8UpcxNv/fuAVJUfMB2rqEdCFbCOT3mu8d8oewBycRqK3nkzcJDrFitVs
         vL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732389098; x=1732993898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qh9HuRP2TUeXMIAhRQU5UITcyp5cug1fkWSRB28P/dk=;
        b=USrO97W8sJXxkkkorcoSrNZzbGe4xK48vEGxp3Hc8o8IrxMRHS6ZfQUQ4ndS0nboNL
         nCLI4F69jn4d0KkuPlQJx8Zisp4fUPpImNVC6Ralo51W1nxsNutPup8xwursN86IA178
         nbZZi6yzSH5nc1teKAeXYUWrwISUO9hNQzHAczRlBvquM8bPUuygfnLyZ2mAlrILKxSx
         sv36DQjp7/fYVv0XTEYRLoH/Y32auMWqg0pmfYARp87yDVmcO730xpHKDMgJut8tn2RX
         R/gvn9CAF9Umf/ozdVxde70/sK2d6fuw11qrsI0IvYrHc9eDKb2K6o/o9FeKUNfV/v2E
         jyQg==
X-Forwarded-Encrypted: i=1; AJvYcCUgZZA96D3HrQZBUHBhXqlpJ7PDGsq9LOYxt0I3sZ03eKnLi8JbuzFO4OCwc6Pm4R+uUhfD/FESDKf/7AG2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6p58VMvnfqPIBDrLnn/jKPB5Tvht4NrqAbV4kfikY1oDBqq0L
	yPKtPjwi//izH418GtDJnM4I+QgjPASGAoKWVG03iv4zB59HYUC4JQ3NlbRFm2Wy8RwiwCbRh/J
	+mA8K9Vqc874JWQfgM7mRrAEofG/q/ShQ06xP
X-Gm-Gg: ASbGncvaCjbCmsllnmjNcxnHW4nDD4SVuNHZSwUp5fm2p3KfG0F3Fm336qwccRgP9rO
	Trg5RTehmqig0nPWDUOUbgDnmaXaTjA==
X-Google-Smtp-Source: AGHT+IFRQw2HWda+FH6Hq/asaKKE9KhYk6qQP2bkHz6lvGB9Yq/rCe0VCi2xcCZCO80m1bTU/ozhGnDwUyu/IGj9xE4=
X-Received: by 2002:a05:690c:768f:b0:6ee:af06:fdf0 with SMTP id
 00721157ae682-6eee09e82camr66104827b3.23.1732389098163; Sat, 23 Nov 2024
 11:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112082600.298035-1-song@kernel.org> <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
 <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com> <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
 <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com> <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com> <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com> <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
In-Reply-To: <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 23 Nov 2024 14:11:27 -0500
Message-ID: <CAHC9VhT4-aVbx_4EV3jAj27CUT=Lk0eb_fTRzFjHU8OO=ske8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
To: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Song Liu <songliubraving@meta.com>
Cc: "Dr. Greg" <greg@enjellic.com>, Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"repnop@google.com" <repnop@google.com>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 4:49=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Got to say I'm with Casey here, this will generate horrible and failure
> prone code.
>
> Since effectively you're making i_security always present anyway,
> simply do that and also pull the allocation code out of security.c in a
> way that it's always available?  That way you don't have to special
> case the code depending on whether CONFIG_SECURITY is defined.
> Effectively this would give everyone a generic way to attach some
> memory area to an inode.  I know it's more complex than this because
> there are LSM hooks that run from security_inode_alloc() but if you can
> make it work generically, I'm sure everyone will benefit.

My apologies on such a delayed response to this thread, I've had very
limited network access for a bit due to travel and the usual merge
window related distractions (and some others that were completely
unrelated) have left me with quite the mail backlog to sift through.

Enough with the excuses ...

Quickly skimming this thread and the v3 patchset, I would advise you
that there may be issues around using BPF LSMs and storing inode LSM
state outside the LSM managed inode storage blob.  Beyond the
conceptual objections that Casey has already mentioned, there have
been issues relating to the disjoint inode and inode->i_security
lifetimes.  While I believe we have an okay-ish solution in place now
for LSMs, I can't promise everything will work fine for BPF LSMs that
manage their inode LSM state outside of the LSM managed inode blob.
I'm sure you've already looked at it, but if you haven't it might be
worth looking at security_inode_free() to see some of the details.  In
a perfect world inode->i_security would be better synchronized with
the inode lifetime, but that would involve changes that the VFS folks
dislike.

However, while I will recommend against it, I'm not going to object to
you storing BPF LSM inode state elsewhere, that is up to you and KP
(he would need to ACK that as the BPF LSM maintainer).  I just want
you to know that if things break, there isn't much we (the LSM folks)
will be able to do to help other than suggest you go back to using the
LSM managed inode storage.

As far as some of the other ideas in this thread are concerned, at
this point in time I don't think we want to do any massive rework or
consolidation around i_security.  That's a critical field for the LSM
framework and many individual LSMs and there is work underway which
relies on this as a LSM specific inode storage blob; having to share
i_security with non-LSM users or moving the management of i_security
outside of the LSM is not something I'm overly excited about right
now.

--=20
paul-moore.com

