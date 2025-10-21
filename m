Return-Path: <linux-fsdevel+bounces-65001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A6BF8EEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CE61886926
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 21:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E128CF5F;
	Tue, 21 Oct 2025 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZ97+p0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AF28B400
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081988; cv=none; b=Spmz6WJWvRd0ls2aQetgGDydzuXjD3a+s+Uxpgz/bfkK9Do1Ud6gqp7rQQD2986U/Y9N0VxUfYHLMIsg6ctZ3SoQVRpfWGfJiEvWXGnYzefaopg1/rCATtUwERDNi3pRPvRNrZjzKV1Ok/zDdAIgag4iepx0dbYrxEwoo7yJNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081988; c=relaxed/simple;
	bh=fk4uDHBJ7seBjI9wBGl6e9lK7q/Nv9TIYlYWxndM84s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfY/vA1k2H5ncZ2YpWYUisj5Dncv5GORwseORJWBOapqwfDpjjieFJC0JSVyq+Bfg+3kydemtYdkCHhWoHGM00ZGuHOUN+Xi2uSpD+ZjcRs2MulCbLLFS1ZrSoODEyZGipEVZ2n0xagexMzwRz401LFAOUfwGrXBWPcovy4pnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZ97+p0r; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c2b48c201so1663a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761081985; x=1761686785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk4uDHBJ7seBjI9wBGl6e9lK7q/Nv9TIYlYWxndM84s=;
        b=UZ97+p0roE8xztzXGDJzWe4bui6rJO4WpILhIXPHY2SG/i9k4LbD0uzC1NVa0Usvxa
         4bWIzp1biTjkrCmJvYVAEj0HkF0wX9SwKCI8foGlJKbqzQjyYWydGMki66fuN5L+/RPx
         5gNtmc/RN4d+h1xsvyadWMY9mPAPfg9L6kVfERpG9dmiJnh5pJdx6l0o8X5GFk21lJxN
         8U+wr0p9FCYczU0YAa35dy1KmluPnUPYUx5KKqyoHUmvl+dIEDcK0n5U25gyc0yXm3HB
         NKNZqC4sv3cpIJj7/otvG3Us3l+PefxCnDjdQVWGoURbPykTZSLvjLL9f1ia06fvfaif
         40YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761081985; x=1761686785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fk4uDHBJ7seBjI9wBGl6e9lK7q/Nv9TIYlYWxndM84s=;
        b=Yqi+YmXS1bMZsrDzQ8K7NgfF4BNxRU/OMOEzMxG3Mn8oXOlAVmtmnjRhspxmEiFWe7
         lUwXnm+8ChZfP6fe82LtelRA0H7wCYpGaQA407uwYDj7rzoCH1Se34rYcsdmEfoiKb6V
         DPHS8qH2mdxgsQjZ/fS8JNRQWPXpYGqqhRqrpBPBHGGohDSNnXpTtedjclRxVjGP3Bl2
         B9JmXfL0vAdNWW3aSfUeFsHNU01itgYAkUU1PQhsvtGbpkk2+Stf5l8CBt49NDAFauWy
         wxxMrTB7iYaQ8/MKK32L4lSuLZWYltvyvHgDldj2BicKUDzqmf587/fL1WOWwjFor1dY
         RB7g==
X-Forwarded-Encrypted: i=1; AJvYcCXhziZ0oTsE+aOAe5hFHsAw4B/95Kb28sfU5qfqO9ThlPvZxznVGhdb5/88ZzEZ/RrgW1doiL2fxi7Hucya@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5e69HQnoF/XY7y2yCBHRXltyu7b3/aX2HduqpG9BP2pyjcyM0
	H/vlmhjFUPQj9/oGBROxvKU9zeLkyOXuJW8yptjrmzbVpbAWFMCX9kkYTvLE6h1IhBWnNSL1XZw
	fvOTUEZPqhpvTexQJuR2RtvxeAEk4xkhN1Bal5TBe
X-Gm-Gg: ASbGncv5YpeELgjTThEPrtwzQb8n48mzLmae64y/eAYBZdo3+hViEAdYbu3RZt/3b+q
	57TGwa2GbnZP8aza3k1OibYrKxeFbp6VHdgxgo8FGlqezl1pRo9rviHcbcWmMQvkmI3KhkbCHRr
	45QRbVX8YMwl9Qc+1s6YKBZ9iu2qgDcODsJogvzei8M393XDzlHvGHvIt3cecFaTnpvn7/vBKHp
	Pgwp4iml4OynU1OCqUw8Sv5qv78bJ6YSwGt0OpoLeKrunqoHMGQB94Ex8Kbpe+tK46UXS+zJKVK
	gdqlIp6fphDbzWI=
X-Google-Smtp-Source: AGHT+IHIK7LRKircy3o7ZXU64JDEZ1svJocF6KUfMmgbCGzy8S1rqeS98AsrhAAzTWhtg1sLGH+a+O1AV1PvLhW6NO8=
X-Received: by 2002:a05:6402:a18e:b0:63c:11a5:3b24 with SMTP id
 4fb4d7f45d1cf-63e1d96bb8dmr8627a12.1.1761081984441; Tue, 21 Oct 2025 14:26:24
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <2025102150-maturely-squiggle-f87e@gregkh>
In-Reply-To: <2025102150-maturely-squiggle-f87e@gregkh>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 21 Oct 2025 14:26:12 -0700
X-Gm-Features: AS18NWC-1jwJmoNEc6IBrfF-BcQRCnK47G8SMuewBFW-uaWirgjur0uX31H4tG0
Message-ID: <CAGSQo00J6SjVLBDFHYqwVZ7x_5nT8L=RQEHTfAe43CoDuo0q3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Binary Large Objects for Rust DebugFS
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:10=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Oct 21, 2025 at 12:26:12AM +0200, Danilo Krummrich wrote:
> > This series adds support for exposing binary large objects via Rust deb=
ugfs.
> >
> > The first two patches extend UserSliceReader and UserSliceWriter with p=
artial
> > read/write helpers.
> >
> > The series further introduces read_binary_file(), write_binary_file() a=
nd
> > read_write_binary_file() methods for the Dir and ScopedDir types.
> >
> > It also introduces the BinaryWriter and BinaryReader traits, which are =
used to
> > read/write the implementing type's binary representation with the help =
of the
> > backing file operations from/to debugfs.
> >
> > Additional to some more generic blanked implementations for the BinaryW=
riter and
> > BinaryReader traits it also provides implementations for common smart p=
ointer
> > types.
> >
> > Both samples (file-based and scoped) are updated with corresponding exa=
mples.
> >
> > A branch containing the patches can be found in [1].
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/=
?h=3Ddebugfs_blobs
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Matthew Maurer <mmaurer@google.com>

