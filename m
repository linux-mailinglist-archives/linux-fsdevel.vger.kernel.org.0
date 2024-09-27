Return-Path: <linux-fsdevel+bounces-30241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A54D98832E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62101F23CB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96366189BA0;
	Fri, 27 Sep 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg1S7vwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46AB184545;
	Fri, 27 Sep 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436104; cv=none; b=O7W0qU0GhpIxM/7zClZu5Sk/GY9s5EfPCiq2eoqwXGv1/z56JE8DdpBqMKfSrXvYEB1ybpS4kpPdtX42lXWnmPyahHlOfrz/EKM8CU5pSkPhs6+J+PKvMAZsw5q1xLDTTwt+tgUikBfVKLsTtKbiLnG81EzJQPfxs2nLgSJT14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436104; c=relaxed/simple;
	bh=AsW4tjDmsLsmUNTIxSA7EE4UAjuROEDpuDg3YcdnwAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3kwl/YFgjWXr8Z6JOTzJoWqZ2+dCIT0+y+QGU4nHLFPAcg/thTbMDZQXuFSVKaA4UtGkgFPoQ3rcbgqq9yjaVH4I7+B/S540l0/m0oukT8hvI73xfB9OAZX3tyrivc6detRjA+I6CppUv1Fb5vmvKbPnlJAYAWf8kkNteJqvNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg1S7vwa; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d74dfb97a8so89336a12.2;
        Fri, 27 Sep 2024 04:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727436102; x=1728040902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsW4tjDmsLsmUNTIxSA7EE4UAjuROEDpuDg3YcdnwAM=;
        b=gg1S7vwaNls3qy8auCIipXlH4Vd5iuOzku/szCrjFyl+cemwwdw0NlxVyXhMsmlg+/
         8OJqCQ/2AW+it/q7/csOQJr+YJkyIfizgvdUMVYK7Bc0X+VecyOuElVqP5fMAtAVFZZ7
         WoX0DN9v21aePiZ6EdZ6+0YBm0ZSWbyIbhuZmBdnL5thPaNF1KCM1U4oteNluyMPnLc2
         l31xCqJ4baJP4KJJ6TGjqIehJfuPjvTCmVmFPOxd/2H1jL+CZQjUE4kLHEm2536HJAFl
         r6090KtjA5Tex/zW5Z3b0aPJcZDCwNw5QLGaDI3Kw0JLaVKNeNwfrhpsfKAJfN1f1e2k
         mX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727436102; x=1728040902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsW4tjDmsLsmUNTIxSA7EE4UAjuROEDpuDg3YcdnwAM=;
        b=ZLYLvqc6B5EPc4uNzaQ/9A23LrcqqRI+CJCBIN0iDVdaKuIGfVOe3wkGcI0axgE/L2
         zA9WhHLnKiDy4jG+9vhcoSEqRZUz5uPeZQpeBJfTt5QTTGeP8FObdtzpqjsGpSjShArr
         tiLsCiPxjpcgbUgD1QUcGf5k9w9U269pB+nzJPhsji8z0C/8FgWNrAWHParLBqbR0Dv5
         6bSahnm9p3bpyJ0zYmDh+2/QhGkx3Oln+243H03NHuYyUr22+5GQDno7MmCRrEJY+1oa
         /9H7bT9/q+PjRBEXU+HaojZZ3hE4tu3DbzBy4yb9WgfpRFycwGUty6tTOnFEQUn9ikvx
         oVLg==
X-Forwarded-Encrypted: i=1; AJvYcCVFo8dyYBIQurf6MMvcLOV3dAtGAvzA0tr36JHh6wxFksXlOz3Cs/SdMfjNLqgi3Jcy2XydTHINY/TTclu6Uh4=@vger.kernel.org, AJvYcCVKqC3qFUEvSDJC4zOM7S54neGBHOBH/uaZkMmZGwSHia9L10KmAQcVTDd+u/Xk/yPGDrojN0NtheUtaCNj@vger.kernel.org, AJvYcCVtMjwYI84z2otsdiLKiVdL2kdjLCK6E8k1SKU0IzqluB2YnLzv0aUE4RlzKH55SrHWT26nRinkZxg/sspAjjY6YezPzfHN@vger.kernel.org, AJvYcCW2KTQGHf3hVqaGkzSuFaTILpjVY4XZT2Atichi2nqPVjLDdxR1Wnm39Paobh1nEqa87CjFP5cd005n6O2n@vger.kernel.org
X-Gm-Message-State: AOJu0YwuegCgFCNHOqEXrZorqVCrdecDm5haH58yjjDbTmoj/wLKQKJE
	eUKAEaCf1AjfpJ1j3ijhmEyc3YaiI8QM2bgX71OERFCkrWlSH21DUru1ap9dj0rP4SFKAhFu+75
	cyU+Y2sp7JO1O6h02b9nAkb088Jo=
X-Google-Smtp-Source: AGHT+IGj7N9jqWtHPIEU0h6pMHb7fThw6I4tCQ6ZkEj3E9bIYy+SqPCFHcgC8zDgrTgWVOU2lkOqO5NVek9Pi43OSAw=
X-Received: by 2002:a05:6a00:891:b0:70b:705f:dda7 with SMTP id
 d2e1a72fcca58-71b26059671mr2028340b3a.4.1727436101870; Fri, 27 Sep 2024
 04:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-1-88484f7a3dcf@google.com> <20240915163850.6af9c78d.gary@garyguo.net>
In-Reply-To: <20240915163850.6af9c78d.gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Sep 2024 13:21:28 +0200
Message-ID: <CANiq72kp4XppV2bPTJtcLqM98LRD-HGnOgfLsssrbDLw++uAuA@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] rust: types: add `NotThreadSafe`
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 5:38=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Miguel, can we apply this patch now without having it wait on the rest
> of file abstractions because it'll be useful to other?

Sorry, I missed to reply to this during the conferences.

If we need this for something else that does not go through VFS during
this (same) cycle, then we can figure something out and apply it to
rust-next too.

Cheers,
Miguel

