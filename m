Return-Path: <linux-fsdevel+bounces-34569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF65C9C658A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7404BB3BE88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E129821CF82;
	Tue, 12 Nov 2024 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U8fl8IOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068CA2038BA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455312; cv=none; b=GORwkpA3x9DvMfgVrEnqUAvdv9ekjt1h7/N9GFAc+0tUmWTUHQJxwY7I9EoJlk/ZEm4NcPc+VN3WKFKouy+W4i1oieBbDWyyG4sCbCxQYE3IUtz/K2DOeqL1m049GAs9KL/STPyYbrddonKcg4rC1hiS5z2fpYkZbRxSjOjvfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455312; c=relaxed/simple;
	bh=PtUR7xHG3XzaDOKNcGaWg+AXTkiClAf7xGs2wsblnAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdKqhAjsZqimgBeITMjix+nZjsHnfj9pc+JOtWbg0nZtyvUfESjdksLJNa8KYjd2PKzJZD+yLfSMHhOcwWmmmuJXB94saK99O5bbwoFUx47H5LnbYK9vy2Q7QhpkkvIo6IbEjow2w2F8uzN+snNwXY3SNQ9u+dfgt+8Q8F4e9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U8fl8IOB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa1f1f2d508so67996066b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 15:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731455308; x=1732060108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cA/tzxVfR0e9vh4jgAsTIRH0TxinS/T5igog/R3JqgY=;
        b=U8fl8IOBgfOZXScUkHdP+vDxUatDK2g4iqpcr2dNLakDDQMgdqoDBm3cZkCKxEZHmM
         bOTaKUYVCh1KySVC3XQw2kuQpQNy7UqPwPwi6TzglKnDtmUrD+SMQncfaP5Cm8RebHzP
         jV/2k8EZLQvDtcp+IRknI7/EizyYSnnjRZJx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455308; x=1732060108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cA/tzxVfR0e9vh4jgAsTIRH0TxinS/T5igog/R3JqgY=;
        b=rJl4Ycy74H1PrzyuaybnGtkHBcsJOAVJecZ5KeyPs5tniLzZBp7yv6IPKwuG1/GPQG
         skvwUIvaEmB075PJj6vY86YimGLFyjz2Gi4129lJRQuXgPaaFiDXZkpnWgxM8p+rX2kG
         QpciZ3tQ+NR9Jv/aP5MuLdblgp2CeCNVhZz5Va1KutJj8zilqTpKLVDQ949FsB84JbKJ
         bBAa3FTt0mjghA1HokIAkXegk3HKlPorWJdkHQ7X8Pie1+N/DFpngERbbTGXJe5/uAgN
         BFS6yWw42jN20+h9TBAG2dJj0hJjS2JtAJbmi0nj5rALcD9ad5vgLNmnZ9UwIK/XI7aI
         wKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUumJU45k+xXa1mP+zxQ5t84ZZOaFISa6xeX5NysUttWSRXIrh8t+Trg20b1tjxEInWjnC8rfyfOGtUVNqn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv4T8nZ1/H3co+cVtp0b7TqGEJ7IGGq3/l5XUyFNAELS4OdP4q
	AAcqDtyBdajkRbvlZtyNhPus0EutbXVgbjC2iAdLGQVxjESwrfBW2aKpB/UocRaWKkhxi5MPf1q
	NXsoZpg==
X-Google-Smtp-Source: AGHT+IEuT9DnaeCWoaLMTs3ZrI1IM//7MtdTeKiVaG4MIniu5qjBeQhcAMrRbgfeEDNsPUHfdXaVkQ==
X-Received: by 2002:a17:907:2687:b0:a9a:4a:284a with SMTP id a640c23a62f3a-a9eeff410a0mr1804037266b.26.1731455307964;
        Tue, 12 Nov 2024 15:48:27 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc50afsm794006066b.122.2024.11.12.15.48.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 15:48:27 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9ec86a67feso1083007266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 15:48:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7ss1UEjWKnbduoXzyXe3uwb2ANopKE+fx/ZN5/PH5GLIY98rONReXqdXEoX4zUKPqlTVP2o29Ft3xH2pc@vger.kernel.org
X-Received: by 2002:a17:906:4f96:b0:a9f:168:efdf with SMTP id
 a640c23a62f3a-a9f0169008dmr1114854566b.6.1731455306729; Tue, 12 Nov 2024
 15:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com> <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 15:48:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
Message-ID: <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 15:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> I am fine not optimizing out the legacy FS_ACCESS_PERM event
> and just making sure not to add new bad code, if that is what you prefer
> and I also am fine with using two FMODE_ flags if that is prefered.

So iirc we do have a handful of FMODE flags left. Not many, but I do
think a new one would be fine.

And if we were to run out (and I'm *not* suggesting we do that now!)
we actually have more free bits in "f_flags".

That f_flags set of flags is a mess for other reasons: we expose them
to user space, and we define the bits using octal numbers for random
bad historical reasons, and some architectures specify their own set
or bits, etc etc - nasty.

But if anybody is really worried about running out of f_mode bits, we
could almost certainly turn the existing

        unsigned int f_flags;

into a bitfield, and make it be something like

        unsigned int f_flags:26, f_special:6;

instead, with the rule being that "f_special" only gets set at open
time and never any other time (to avoid any data races with fcntl()
touching the other 24 bits in the word).

[ Bah. I thought we had 8 unused bits in f_flags, but I went and
looked. sparc uses 0x2000000 for __O_TMPFILE, so we actually only have
6 bits unused in f_flags. No actual good reason for the sparc choice I
think, but it is what it is ]

Anyway, I wouldn't begrudge you a bit if that cleans this fsnotify
mess up and makes it much simpler and clearer. I really think that if
we can do this cleanly, using a bit in f_mode is a good cause.

                Linus

