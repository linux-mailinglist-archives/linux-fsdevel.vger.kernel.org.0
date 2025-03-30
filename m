Return-Path: <linux-fsdevel+bounces-45305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C2A75BE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E422166B32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 19:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D0A1D79A3;
	Sun, 30 Mar 2025 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrIWrfr4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3320B22;
	Sun, 30 Mar 2025 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743362286; cv=none; b=Bu5od2m3oazS+U/VbYflIjQez9j0auwCJLc/CfO+5GXTdR38TLKnSw4IF5LRH+TCEV3Om1I6knVPswgawceR7vdfFL2s0MzCu3Rfi6kxxiPx7HcmMzJNjiodlFaYBx3zQqYLcB31nzvBNeXbr7LaVctqvshHXpImnnJ/Se4ceGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743362286; c=relaxed/simple;
	bh=DfuZhcLVKpW2x2WudBOngipGHKYbqouh5vMgWn/XrBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCe9tGvA+aemY8mR4/XNbBB/6PBDft9GSb0t8aWp9krud9Y1SZT5T8rakgeE5ypu1AX1Ilk+aJpo8HEP/WPveJa1t/k2RsTwfycghQExMvk47TjA4l9BT5IE0xiRj3JDnnOR1qFyrPc6ZtlxyM4tJj6VKZwmWx2cCm0czBndkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrIWrfr4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbd96bef64so618889266b.3;
        Sun, 30 Mar 2025 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743362283; x=1743967083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Uic6/FDzEr0oED1vmoSXEu4/nir+cGGW+rkZAv0vW4=;
        b=QrIWrfr4F8NdUPs8dHVfxMtC7/6vW4HpfZ3GOdohywcGaljEhvD3Lzz5fehWRHi44+
         3tI/b/TDZL5ElGYAuMkDcJhGz0WtbF7GvS/z16q8SLMr/tcrBHIdJ/72pKcl7xB11DZ7
         gfdOOeCcfGVXJVIU/wIWcvsyiQ9oDHvZkeDzHyi22RBvoFaYYLN7dMYQsbLUtqnn3Z2I
         u8iigvaVsPSP9WnwqVJ/NppOblujJjD7yioGOUXIX0pQ/Q1sxLiCgaJ1a00FonydhRf1
         yllaSl89r8Wt/UL82g93+z4XUtUfm2ukMA+0a9VJeSsaD3a0AIn0gsXG1aDXuYI6WeH5
         FovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743362283; x=1743967083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Uic6/FDzEr0oED1vmoSXEu4/nir+cGGW+rkZAv0vW4=;
        b=qYftV73e9cXQDJIz9hbqEuKNJqwHB09ChAmn+lB4zP4O4FUnitDSNeYyuIW1vhGSr9
         ROGM8OjsgrRzJa4I/DEuiXZfqG6nTpCUF7kt1cCkwzJaap06aBXEmolA3WssddzI/8yB
         yroKMvZRsoBoXSjPc9UHA9J/xfIBW8d9Pb5ixul09Nsn8ansGQY/vfrSV4RI06NR8kAD
         JX9pme5UVmaXIS5LwvRMejiDkeyv9FS+EFjIQ1pVaJrPuFZfIxaX4W8/1oNmt8vCI28/
         CJul6CjuG86XNONygmn+nSqSj8PiU57BfSaCPF3o5KU3pCaXBP9SNKJps8bJeEk4jHaE
         ZtJA==
X-Forwarded-Encrypted: i=1; AJvYcCWEmdKTmqcS02GJbvn71wKQtqnap6rGJ6Dut8MDA+il1sXdbXUsEjbNtNaXvXBFAe8xB6vVNMn1mLXpTnHq@vger.kernel.org, AJvYcCXtjjnKEPy6sixbHR7YTfwXoM6xThH8c4NSZbB1BErjpMFdSw3haAgb/x+BfkbG3o+psiHcky5kTlB3@vger.kernel.org
X-Gm-Message-State: AOJu0YwJUkTkQ+LTEUWeME7fyYHe50L/dagiqxCylmCE/xZNpHOvpH9t
	DGj+489qVKsRqFmHxp0ZjxbkDUriWwQ9QawIKEhXg96KeIYWcLBt9/S1VBe6WWI3TvTp7xomurJ
	VdioBV0P7HEwZ9xQvn1YLrus5XHo=
X-Gm-Gg: ASbGncsdi4bx1xOHCvjDWZIdU7LKvtqCpq3gZf5vgfxOK7rRlbNWwTxoE1A+yaBXjDB
	g4kiOTUo+gv1us3qmJw+3SaRuKzT5aoKiN1Z47eDnoDD/vw5o5JicsYCCl04sktUJdu9zeetEv9
	iaBlF2YtZbjfaShlsa8WhLRYro3w==
X-Google-Smtp-Source: AGHT+IHVexdM0Y+Mag7vGWg1wjxVbWwW10AYNMYfvplLPInu12dZ+Vq0b9HABIge83ngCY+Ol4ZEz0rKrQu6YauzeyM=
X-Received: by 2002:a17:907:3d9f:b0:ac3:bb5a:8758 with SMTP id
 a640c23a62f3a-ac7389e79acmr537256066b.16.1743362282872; Sun, 30 Mar 2025
 12:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330163502.1415011-1-amir73il@gmail.com> <mu6nhfyv77ptgvsvr6n23dc5if3sr6ymjmv3bq7bfnvcas66nu@b7nrofzezhil>
In-Reply-To: <mu6nhfyv77ptgvsvr6n23dc5if3sr6ymjmv3bq7bfnvcas66nu@b7nrofzezhil>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 30 Mar 2025 21:17:51 +0200
X-Gm-Features: AQ5f1JqvJZbDswJLG9AN1-iwSJDf7tIRc3EEzXWO0Zsi36PKbyDKRVqrKYUb94s
Message-ID: <CAOQ4uxj48SHB+8m0r50YhdqYZB2964+aK=BxdoW_yuWzZUgzGw@mail.gmail.com>
Subject: Re: [PATCH v2] name_to_handle_at.2: Document the AT_HANDLE_CONNECTABLE
 flag
To: Alejandro Colomar <alx@kernel.org>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@poochiereds.net>, 
	Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 7:56=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Amir,
>
> On Sun, Mar 30, 2025 at 06:35:02PM +0200, Amir Goldstein wrote:
> > A flag since v6.13 to indicate that the requested file_handle is
> > intended to be used for open_by_handle_at(2) to obtain an open file
> > with a known path.
> >
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Cc: Jeff Layton <jlayton@poochiereds.net>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Alejandro,
> >
> > Addressed your comments from v1 and added missing documentation for
> > AT_HANDLE_MNT_ID_UNIQUE from v6.12.
>
> Please split AT_HANDLE_MNT_ID_UNIQUE into a separate patch, possibly in
> the same patch set.  Other than that, it LGTM.  Thanks!
>

I pushed the separate patches to
https://github.com/amir73il/man-pages/commits/connectable-fh/

Do you mind taking them from there?

Most of the reviewers that I CC-ed would care about the text
of the man page and less about formatting and patch separation,
and I would rather not spam the reviewers more than have to,
but if you insist, I can post the patches.

Thanks,
Amir.

