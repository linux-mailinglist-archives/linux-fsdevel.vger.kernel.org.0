Return-Path: <linux-fsdevel+bounces-67328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9414BC3BE3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 316DE4EEFC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC83446B2;
	Thu,  6 Nov 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DspfoUWh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5733DEDB
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440583; cv=none; b=uWDhGDWovInLKhIGqUhpbXzA9dXk5+2NLHsg7gaqN1SEhejdtOW+b3vynUM+gz1gw7dKN7r5qxmgyJizJC26lYIY9XugrgjYiDKTt+3Plaq/XntyWTrAPVQ0pnkFATp3t5HMBRdJ5+eWhqghxbHPfkIwgAfHd5gIFAkzdG3PsjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440583; c=relaxed/simple;
	bh=x3cqipEYJXlgL2yviFdIDPMoX0lSj6NBR8ueUAg2vCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DllKJ4oRVrEq23bB7G095u97Dk85bHtocAmTG9PIPnruyg+xw/Yf3iC+07OA7wzzBscvWfOn7cSsF8Cl0XYJS/LdPJgkJ6ADgaZr0qGcr74Dstgh/p4bZYyrturC3Z2VcFDS+yH8iMhXeYgAavvG0bhFjeDDxYJMITnGt7ojUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DspfoUWh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so1521351a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 06:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762440580; x=1763045380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3cqipEYJXlgL2yviFdIDPMoX0lSj6NBR8ueUAg2vCg=;
        b=DspfoUWhahtPHhFdWDegsdcwvsHSQDUoukpSkt4KBUgeq7o9RVBgAwZiEq7JSvPdoF
         rb5+Z8tcMus4xTlp9rMQgh29MIRse59qQfCiJEyUpkJfSa0NN1qMHfXmk+UUVbbZrfAy
         JU92y1m+X2iqdv5DF1GvQb/FcxFVvXH9uiJrohC8Jz0JTsHHNCGIck9aceOY77/tca2b
         V+91M1jCErOP19GbulXXwYQ0OEt+8+aSkn2p1dgJmpz0VMXO8lstub7UecC1mvk28eoj
         nC8Iii6uRU9RtQpZS0gNtbTiPCrVOpkJLFRXAc2PcR8+wUxY2AyqHoijlA8VSnKE3IqF
         bklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440580; x=1763045380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3cqipEYJXlgL2yviFdIDPMoX0lSj6NBR8ueUAg2vCg=;
        b=mQNEoTqab451JHevUmQw0PGU4GIESVjrz8+ouHedvWAV3IF4heHNvocnZFqWQVgGum
         fJtVJ/9KsldXO5zXfovwXyiv8ANfR1ZN60UoA8kKTtpTD/SquTl0wRZGmXvAHdHwXrta
         Qj85pu9GQJuKb2jROmlu52HnLk9M0nn+X0WVJhFSrrSSqhECR7GTPPUhav+f5p5oAxpb
         lcLPlEIjBTUv91UGqG/cKl4wmh14iSaMELplnxuIPGHaaHfG82WXYk9UXswqKBsotu3p
         xuo0EmFJEWgAs7ZKl/0SFG4eCbo+LtCzqJz3BeUPLETuJW2XO1LwQrLHem36IQynLUSN
         z/8w==
X-Forwarded-Encrypted: i=1; AJvYcCV106bfTVbh2bnRH34vXGG6KI62dWDaVS+qGDZjOqUmlgEmiANMHevC4qGi2KgnnZ+8mzXdRQS1IcrPbs5c@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXJ5XgGyXsmdBglqh/ee55fuXHPnreMV4QHoE9NaIbzpMTOXn
	M4jm2rUBqnGAm/HK8i7jPEo1qNsIU+CmINtuq3N4Xvt9TGgVd0ap35WLcilsTBNsLagEzXkeGwb
	ZbKqoKSurzI+lzrOW+UvsIXtwdBT/uXI=
X-Gm-Gg: ASbGncu/ZDC5LtLSnove0r7idiE1V96lCKG0qNTl1cCdfq9+lYG2DoYvgeLycYxgNwz
	qXQhuQGGaKK3rc9H1KRLkc4pxVDsvx5aZ3lBgqWM69eLkbt0cY2eyEYd2TSG3FsZSFsipWxNK1Z
	f3esam3T21HPbNrLdjkHFGZaLe6Zyp7iENHTMZcAgYAcp7t4ghhcJA/p1HXlrKS3LT3IKtunJcn
	1EFPbGyQ+6owzu5T5vp+QAjZpZ2q8JO1Vuj0rw5A22EecXoKNlcUCks0HcNCJSM7jNdbS86J/uQ
	vQfr6BfgmLcNlnP+jJ+zS+zhsA==
X-Google-Smtp-Source: AGHT+IGTkbZJGRchGTkQauVj9fkvo01scuDDcRqu/thxmiYqRRhXCxyAX7NNBPJ6BxbxjvhqOiymHXZQFXN5z82w8MQ=
X-Received: by 2002:a17:906:f58e:b0:b50:697e:ba3 with SMTP id
 a640c23a62f3a-b7265608c08mr761114666b.63.1762440579515; Thu, 06 Nov 2025
 06:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local> <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
 <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local> <CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
 <20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local> <CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
 <20251106133649.GEaQykcT0XXJ_SDE4P@fat_crate.local>
In-Reply-To: <20251106133649.GEaQykcT0XXJ_SDE4P@fat_crate.local>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Nov 2025 15:49:25 +0100
X-Gm-Features: AWmQ_bmx6eYJ_i1PPLlx42piXDe7pXDP9_APoR1EKtbmzECfxNFgWpRPEoJy1m4
Message-ID: <CAGudoHF7O-q4AENo-jdZymr+U8AGfQBcz7hjbi-kTg=MSOECXg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:37=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Thu, Nov 06, 2025 at 02:19:06PM +0100, Mateusz Guzik wrote:
> > Then, as I pointed out, you should be protesting the patching of
> > USER_PTR_MAX as it came with no benchmarks
>
> That came in as a security fix. I'd say correctness before performance. A=
nd if
> anyone finds a better and faster fix and can prove it, I'm all ears.
>

Perhaps I failed to state my point clearly.

The position you are describing above does not line up with your
behavior concerning the use of runtime-const machinery for
USER_PTR_MAX.

It is purely an optimization and it has nothing to do with fixing the
problem the commit introducing it was aiming to solve. You accept it
without a benchmark. Later when a bug was identified you did some
testing to make sure it works. I think it that made sense. However,
per what you are describing above I would expect you would be
questioning whether this is warranted in the first place.

kmem is probably used about as often as user access (if not more so).
To my reading you rejected the idea of patching up some of its memory
accesses without a benchmark from the get go, which is quite a
different stance and I find myself confused about the discrepancy.

I have not tried to write patches to optimize these. There is a
threshold of complexity/ugliness where I would drop the idea myself.
But in a hypothetical case where they turn out fine, I don't
understand what's up with the insistence on benchmarks for this
particular thing, especially in light of your position on
USER_PTR_MAX. Per what I described previously, this would be hard to
arrange anyway even if someone genuinely tried.

