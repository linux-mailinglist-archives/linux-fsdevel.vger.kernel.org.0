Return-Path: <linux-fsdevel+bounces-72336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 335DFCEFEBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 13:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17DB0302D2AF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D732F3C13;
	Sat,  3 Jan 2026 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWKnzkwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7C26ED37
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jan 2026 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767443025; cv=none; b=RazM8YlYAmWR6/M4FoyuX8RfO/303O7cx/hbAOmgquCyCafQDcdTyyUWui3giGfPMpGeOSq56q3ugLEHeUIbYgPAQqqJXF7I64jpaZZnn0qDH9DUOt765Npd86TKkdsjOiOoz+NgCWCTIw3qTB9NuClDStqFb0KdrctvMSYSdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767443025; c=relaxed/simple;
	bh=m6jgfvjdXKce/Y56Uh2xKPlSryR9uP6xV1kv0bVMxJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O13+2Kuzaa3ckQVuaxgtwC34Tc5yw8bjWVT3Qv10CgkVBVK6yxWsjTVgvEq9YMGAzApH7mGI7AFeAqPhkSCqObj9Gm5R98Mh8Xef9hDRa4CktPgLt3VMGDUgGhv9nUaZJ7YXjNuPRX4GHNoBUCRk90DK0aCceImIlZRSvbCPkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWKnzkwm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso18355787a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jan 2026 04:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767443022; x=1768047822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6jgfvjdXKce/Y56Uh2xKPlSryR9uP6xV1kv0bVMxJw=;
        b=GWKnzkwmvLJNQV+30tVuD9fVhPptatBlPiTDl1FT82xaIY0eROyJsWbbS9XrN0Ezlo
         KKRfjYaeoO9SEc8DJ3t7KeabCoXK9VEL6f7THZFkqvrJHy62unO1tKoI80QBhvgc4me2
         oAcDhIrGOgypsw9XOybcAApMqXbjzY3fnVPbtkCDXNUbwixNwCFymktMQtFp2EDXouy7
         3NrO5SXhXIHzoiPaeJGdRsRpCLea7Awdi7aCEHIuLa4Dgds7/bTyrbUH07SQC/X8h0E5
         ycO4+3fLzV38Dnq2IIVX6yU6E5JHOuLtq865LPJac/N6sIVD8TWgUM7GskP+uyoZJhng
         ShPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767443022; x=1768047822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m6jgfvjdXKce/Y56Uh2xKPlSryR9uP6xV1kv0bVMxJw=;
        b=KEbZM81TZqEwIKXBhragY6cXBWoUbJvfeOEJUv2fHsiN10l64hBNrAO9waz9n6zfM8
         dMUgTvuX7+odztVu94LqnB7WPuZR0Zc+TBxm3xbOAtWWjSoNMGkOPmy/n3QFIi0BIKEW
         qIwRGT5U8bVLHukZpnGoX/pTicd7gsQv7NBDXf601mb2mloKvjXdc2kY+ATM0CYwFNuI
         yJnbiWBkxtWFiJpUZA+StRAgvp+AIDF2Rxru++2PfaFm8VEJ2PE4aFb2I45n7HOW0bNL
         HVMGtTCCYkrCUN0Ak+qkvDHlqdK5eTmKy48ud85QU46yMUyp4AespwZ2SbWef8stVL//
         XtPg==
X-Gm-Message-State: AOJu0YxfU554/ZqiOqXEGudtLzM3xFxpbZPCvm9xYvA1yH/xfls+1xk8
	8apKeI4l1xFd0O22puT+MorKzwU7BYVEpJSB4PaJiSagvUtGIgYySlD4g08WzODA+beWt4wPqan
	vMytxCykbRB3hl6DpzNVB++in9LSgdO4=
X-Gm-Gg: AY/fxX7RTOVLdcHzev07YsVLpvFoTyOMqRvbROoRtkLCdB2fAv9NOpwcmQVAmyu3E0r
	3to9UfITLjEtXw0Phf063UCvKvqrj1L0sE3KMgurn1VfkGhIQy0ilND9AjScZZcVBH8pJ5JAUAQ
	fv+4GNrXiQuk6OSdhro8dnv+yVUiAYghOwuzfd9eWkHPEhZQItUXkAjKolyR1aY9YU0LMAXWPQN
	Baq0z+PjwnVAYMR0r2PzCq9xnJtXurZA+xlm/00ueUmq9pREg9JJaHOKT8OavrVek8mv5k5KNiX
	3U/2tH328S84oU4za2Q9wphSjhY=
X-Google-Smtp-Source: AGHT+IE1gRL8BhgE4+lXikTnNzAC0eTfQiwQLjGbh0gUd6C06JN8p0K8s/ghjbfoGle2qPq4ieQsjvyMU/7Qtke3g10=
X-Received: by 2002:a17:906:730f:b0:b80:b7f:aa10 with SMTP id
 a640c23a62f3a-b80371d8c5cmr4738002266b.59.1767443021786; Sat, 03 Jan 2026
 04:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9fbb6bf2-70ae-4d49-9221-751d28dcfd1a@redhat.com>
 <o6cnjqy4ivjqaj4n5xphstfnk5jznufaygwmfkm2gyixqgfump@7fc6c6h6d5if> <28f144f8-431d-4c3a-a362-56083bb77541@redhat.com>
In-Reply-To: <28f144f8-431d-4c3a-a362-56083bb77541@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 3 Jan 2026 13:23:30 +0100
X-Gm-Features: AQt7F2o99ArbmBWfoJL21d1uI-qfg7vjOZ5qXmX4UFhuPDRSfkoorw_TiFY2WTU
Message-ID: <CAGudoHExNovL=EqHLqV4RAd1m-a2X4nhadZ9OGyxW6AXNr-8PA@mail.gmail.com>
Subject: Re: [PATCH RFC] fs: cache-align lock_class_keys in struct file_system_type
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, lkp@intel.com, 
	oe-lkp@lists.linux.dev, Alexander Viro <aviro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 11:45=E2=80=AFPM Eric Sandeen <sandeen@redhat.com> =
wrote:
>
> On 12/30/25 4:04 PM, Mateusz Guzik wrote:
> > Instead something depends on the old layout for correctness.
>
> If I add ->mount back to the /end/ of the structure, it boots fine again,
> so I guess nothing is expecting specific offsets within the structure
> at least.
>

That's makes it weirder.

> > By any chance is this type-punned somewhere?
>
> I don't think so...
>
> > While I can't be bothered to investigate, I *suspect* the way to catch
> > this would patch out all of the lock_class_key vars & uses and boot wit=
h
> > KMSAN (or was it KASAN?). Or whatever mechanism which can tell the
> > access is oob.
>
> Can't do KASAN or KMSAN on i386, AFAIK. :(
>
> I suppose I could try such things on x86_64 just in case something shows
> up...
>

The sanitizer suggestion was to get the kernel to just tell you where
the problem is.

However, you can still use qemu's debug facilities to figure out where
the boot hangs and take it from there. Ultimately this should be
mostly a boring investigation, even if chore-heavy.

I have not used the machinery in over a decade, so no tips from my
end. But obviously it is there. ;)

