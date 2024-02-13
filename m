Return-Path: <linux-fsdevel+bounces-11422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1605C853AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 20:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485601C23D2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88CD605C2;
	Tue, 13 Feb 2024 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4hdv3Tw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E5C60263
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852675; cv=none; b=DH9TUxP75m7tp7kohVoiB/Ro5o0+3a/jMpysGbgckH99C3d3Yn/8GlK8j99/ufr11PSKFephz788EdfwH8BAyD+0p9zVbmEQiaBJx1Vt9ixJr1lV3NyFGUCFlfjcA65TG5zxAI9N1ik6sbtG2J4bW6YbTFtCdhinq0jm3cGusdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852675; c=relaxed/simple;
	bh=Tw2rowHIbPAqoJMrxrzUcDB4F9+J8tItAzgiEGHiSEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uTLPi7aRAzmmOkLPtNQx7WAFOOcGvkRiENu5qAwC2bWAzC+vmWLrhRYc+OTj12YFoMqEMw25TIv0ZK9LyzXCpPBnM0tkXQG6mj/uiWPWFe3JaxDThjLTQqpHx1FdknfB1F5fsI97woA8pwKAR/wsL/ZW+OdGmalleuBThgxhkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4hdv3Tw7; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso1040789276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 11:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707852672; x=1708457472; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw2rowHIbPAqoJMrxrzUcDB4F9+J8tItAzgiEGHiSEg=;
        b=4hdv3Tw7ANl3xmVEx9SQnA459F3eifEgZzb4mM2FupeQpsfXCjqB9YOptXjOZOmnbp
         X7jLn7zitH2x21NE16NqBGqQ3DN9EeRDQECG/eybSAn8rTni/Uoaw+qZNsrCIgLrr6xy
         pzQIkK3F2lkjCcbEDztysysZHS01cvgkvSKth7pEdf2uKeugeUoamvvmCQ1cxMjW0LbS
         EzjuI6KclEAzhLRWyjdOojSGHn5sIIEJcM60L3hsDFiLEEqii1+6frFf53UF/jECJo8S
         sN50aT2bQbSE+wFlo87AZsqKL7p5Lw6YqanIkXJ9f3JbHB0lbFUd8jxTbJKvB+afhG9i
         i2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707852672; x=1708457472;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw2rowHIbPAqoJMrxrzUcDB4F9+J8tItAzgiEGHiSEg=;
        b=rvj4Fv1p/r83WqFhEOhF3Eq+aLDw/jmvHHoZPuX6dag9K+x+LqJ8oYYgO5VfU+AAIT
         CbdDxKyN1hRz1ctavkZDGBHLntZLJC9OOJS6LYL8Y1ZoZ9jTuLVLzPLPHqBWbVWd63Rm
         nprfiK/KFqEgSeG9WVYbifxpPh9ZSC+8qPOUWXJldkMgmvlmuIDWggFQIY4P3QpRoRC6
         fJaQRLlr82ikuFpxluR6QFGDK/Efhdbbtp6glWGt8TaMOnBnkdkzqv+RXzP/MUPrexih
         c4ckd6fx4r6dwgSYBRNRhxF/bIMH5TZZhOWHeQX0uNNf85EW48mvymCvpvv4mE9aG89K
         LQUg==
X-Forwarded-Encrypted: i=1; AJvYcCUbwRbPX8yZWDLKKE6QHwH1i/ZdqqH2y/56rqzUHDufGfQZs8AuMEm/GmDG/MScNO3ptxzZLebpZO+KEk6uELBJ8RdX8seV/7taKJMgIQ==
X-Gm-Message-State: AOJu0YxdcSFZXGovbiu2jv6FPxMgsRGKSzMvy0sTgdoo3NbUw4xo6ImG
	/XUs86Wn3oknI7azUCa4OWp4DZO5L6ypqHVC7UqyJnN4xxXCtoZ3fU+cXBiFgI1lqZ0lJAxLf3i
	4DqAG1CjUADrTXC1lz9ybZyW3IItbBqxlG4d7
X-Google-Smtp-Source: AGHT+IH1xmQOWfh9dLSe7wwpBx5E+EKefS15CBVT4ddX57A9DakP6t15fuP5oCCtN0RM9L0M2M+VsoHEc/lviqBqInA=
X-Received: by 2002:a5b:b92:0:b0:dc7:4bc5:72cf with SMTP id
 l18-20020a5b0b92000000b00dc74bc572cfmr277658ybq.14.1707852672365; Tue, 13 Feb
 2024 11:31:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com> <20240213033307.zbhrpjigco7vl56z@revolver>
 <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
 <20240213170609.s3queephdyxzrz7j@revolver> <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
 <20240213184905.tp4i2ifbglfzlwi6@revolver> <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
 <CA+EESO6M5VudYK-CqT2snvs25dnrdTLzzKAjoSe7368X-PcFew@mail.gmail.com> <20240213192744.5fqwrlqz5bbvqtf5@revolver>
In-Reply-To: <20240213192744.5fqwrlqz5bbvqtf5@revolver>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Feb 2024 11:30:59 -0800
Message-ID: <CAJuCfpEvdK-jOS9a7yv1_KnFeyu8665gFtk871ac-y+3BiMbVw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:27=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240213 14:18]:
> ...
>
> > > > We could use something like uffd_prepare(), uffd_complete() but I
> > > > thought of those names rather late in the cycle, but I've already c=
aused
> > > > many iterations of this patch set and that clean up didn't seem as =
vital
> > > > as simplicity and clarity of the locking code.
> >
> > I anyway have to send another version to fix the error handling that
> > you reported earlier. I can take care of this in that version.
> >
> > mfill_atomic...() functions (annoyingly) have to sometimes unlock and
> > relock. Using prepare/complete in that context seems incompatible.
> >
> > >
> > > Maybe lock_vma_for_uffd()/unlock_vma_for_uffd()? Whatever name is
> > > better I'm fine with it but all these #ifdef's sprinkled around don't
> > > contribute to the readability.
> >
> > I'll wait for an agreement on this because I too don't like using so
> > many ifdef's either.
> >
> > Since these functions are supposed to have prototype depending on
> > mfill/move, how about the following names:
> >
> > uffd_lock_mfill_vma()/uffd_unlock_mfill_vma()
> > uffd_lock_move_vmas()/uffd_unlock_move_vmas()
> >
> > Of course, I'm open to other suggestions as well.
> >
>
> I'm happy with those if you remove the vma/vmas from the name.

Sounds good to me.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

