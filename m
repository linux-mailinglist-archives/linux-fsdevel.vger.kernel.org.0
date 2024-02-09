Return-Path: <linux-fsdevel+bounces-11008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F382884FCAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D29AB227FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03280C1D;
	Fri,  9 Feb 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBwCs8cr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC42E3F7
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505828; cv=none; b=m/mWVPCzqxiB5DBn/vsZF9bT0gBD69C4qkvQwrrAFOBDsBcc+TEhxcma9z4lCd2YolAXBtgm38YxmEmFpphSS6qXqW7pIsvSORI0tMQI40N+pIVVpwVyYCvFHphO9jquH4oXfofBoKtt4xY+xPcUmO//BN+gxkw3/E7aYhyGk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505828; c=relaxed/simple;
	bh=jNzumCA/iVd9kKacUxRleLzxxWaZgGm3F6JTOZ9i2RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml7AykDU7tTb6waSzw/wdotqm0neKqukgcHEBO9+axfr2iRFzVqHXQHLsOK9fJtYS1pvfXAiBtvnvLDmIefz+hjMYnzmGoqTZcK6qEYrH+faFjuGWqmYXRxkhASthN57aaE1qoga2KnfDy6URy6A+AUBrKiQJf2zeFynxLXGa4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBwCs8cr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33adec41b55so561783f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 11:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707505825; x=1708110625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw3dw1lSE5s2MGQsWgO/CVyDUkBrtjBHMIZZeMUJJVw=;
        b=ZBwCs8crnqpwsAzOXxA6+DNrQO2rpf1opwfVt+ADu+0pG4sNcVTpve8uXHNko39GgS
         NMDrRvoJJHttLxIxwJQpTNuUamvHfO2hRJ8HXBfRd55JCwQAsDVRNfxxjsRYx8ojOozQ
         SLuOH7WrkqeR5QM+HBwO2VdWbHQzycRyip4Zw4KE+1udcMBGyLjKbHJDNfyawNOEHNgj
         FUUb/sgoUkpwdBBny9BJWXUJQb1msgC9SnuyQq2MebYckSfGn1pQJXo8fUMkbNl2/JlT
         nnCQHf7sg1qFSWZhixLO1sc85zyW58E0XTICCpy7jXda+Yx2cQnavkc2opIgWz+sNzQa
         KsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505825; x=1708110625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw3dw1lSE5s2MGQsWgO/CVyDUkBrtjBHMIZZeMUJJVw=;
        b=Bal9FXsOZXtRHg2nyAdVprNhqwwpI5XSw1GTsV0tuHE0zg6froaz2s5vNRxw1lZikB
         bUrszdNac3F9pIEhgDRUZkG/NGOthXvgfLB1vjtPrQYFQ1j/LPn9P7rQ6E4g95WXnvxg
         UfwTKMXtEBmMO2E+iftdr11D2oaVfGOMRpo8tvX9oV2wNSh0Vgu0qDkIDtsLER6XgKOB
         l0G6G9rD97E67x7MIUHk1HQuMG/NBrWytvmtDmQm2FmDCzuGOlWMVMvaEM7zzsXtFvY8
         2DidneEBiGHIz99xx1VT8TRB+nMIZjGujT8o5qltSs2TUlyANfAvGF1mP7VugYxt7GRQ
         dwDA==
X-Forwarded-Encrypted: i=1; AJvYcCVdjW7sGi4n/BGxCJrnD9wcbJnqdO3LvxHDXItSPcQ05klbaFAqtwAjELbKp9ohGbd834Iyvp9M7fvO6GrT1FVcBtPMX3NzQ1VLxSHwRQ==
X-Gm-Message-State: AOJu0Yxt+6IH1hNAUqaxJYnBIEABINciA+CRDaAV6Pe21Ugwz6zLkqC1
	6N21RNOMPZI0U8+NtmsAQs3k6mJ71FJMh3ckC0wicW0hQa/aH/BcUO7cF64W3ulJxsjzfII+c/4
	TviLj8sCx7daetfDqLYc5ftmrJmXNyscC/lh4
X-Google-Smtp-Source: AGHT+IEHhoHG7ARKXzzZ3gmn/NJ2dPjLZgwU+EeL7zC8mpJkCVirFujY4gxbVon+zQ5ALlYFH3wxSQGe1j3gkh/IC8A=
X-Received: by 2002:adf:e848:0:b0:33a:eec4:c0c6 with SMTP id
 d8-20020adfe848000000b0033aeec4c0c6mr1867380wrn.12.1707505825261; Fri, 09 Feb
 2024 11:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207222248.GB608142@ZenIV> <ZcQKYydYzCT04AyT@casper.infradead.org>
In-Reply-To: <ZcQKYydYzCT04AyT@casper.infradead.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Feb 2024 11:10:10 -0800
Message-ID: <CAKwvOdmX20oymAbxJeKSOkqgxiOEJgXgx+wy998qUviTtxv0uw@mail.gmail.com>
Subject: Re: [RFC] ->d_name accesses
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:55=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Wed, Feb 07, 2024 at 10:22:48PM +0000, Al Viro wrote:
> >       One way to do that would be to replace d_name with
> >       union {
> >               const struct qstr d_name;
> >               struct qstr __d_name;
> >       };
> > and let the the places that want to modify it use __d_name.
> > Tempting, but the thing that makes me rather nervous about this
> > approach is that such games with unions are straying into
> > the nasal demon country (C99 6.7.3[5]), inviting the optimizers
> > to play.  Matt Wilcox pointed out that mainline already has
> > i_nlink/__i_nlink pair, but...  there are fewer users of those
> > and the damage from miscompiles would be less sensitive.
> > Patch along those lines would be pretty simple, though.
>
> You're referring to this, I assume:
>
>         If an attempt is made to modify an object defined with
>         a const-qualified type through use of an lvalue with
>         non-const-qualified type, the behavior is undefined

I have 100% observed llvm throw out writes to objects declared as
const where folks tried to write via "casting away the const" (since
that's UB) which resulted in boot failures in the Linux kernel
affecting android devices.  I can't find the commit in question at the
moment, but seemed to have made some kind of note in it in 2020.
https://android-review.git.corp.google.com/c/platform/prebuilts/clang/host/=
linux-x86/+/1201901/1/RELEASE_NOTES.md

That said, I just tried Al's union, and don't observe such optimizations.
https://godbolt.org/z/zrj71E8W5

This whole suggestion makes me laugh "in C++ private members."

>
> I'm not sure that's relevant.  As I see it, we're defining two objects,
> one const-qualified and one not.  The union specifies that they share
> the same storage ("a union is a type consisting of a sequence of members
> whose storage overlap").
>
> I see 6.7.3 as saying "even if you cast away the const from d_name,
> modifyig d_name is undefined", but you're not modifying d_name,
> you're modifying __d_name, which just happens to share storage with
> d_name.
>
> I think 6.7.2.1[14] is more likely to cause us problems:
>
>         The value of at most one of the members can be stored in a union
>         object at any time.
>
> From that the compiler can assume that if it sees a store to __d_name
> that accesses to d_name are undefined?  Perhaps?  My brain always starts
> to hurt when people start spec-lawyering.
>
> > * add an inlined helper,
> > static inline const struct qstr *d_name(const struct dentry *d)
> > {
> >       return &d->d_name;
> > }
>
> I'm in no way opposed to this solution.  I just thought that the i_nlink
> solution might also work for you (and if the compiler people say the
> i_nlink solution is actually not spec compliant, then I guess we can
> adopt an i_nlink_read() function).



--=20
Thanks,
~Nick Desaulniers

