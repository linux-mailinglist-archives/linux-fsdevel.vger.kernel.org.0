Return-Path: <linux-fsdevel+bounces-24151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58BA93A605
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 20:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8B11F2353B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0C1586F6;
	Tue, 23 Jul 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VtRoaZnS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59B42067
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759453; cv=none; b=CZkP3ov6+CtM94tPkVf+8T0TmNbtAqHrXNa/Z3xhahmRWqtC29UajGnRwApbt0zbzoEQsJyahv5B6mp5NQavAmdMzKMAvT2YWlISRLqq/BYzx9mTs0gdH/UO5Fq4DhKiKWnlDbeTwU9DHbauo3JdE6iEGlG4nuPS++Jp7eforfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759453; c=relaxed/simple;
	bh=Pp3VZCk6dq4+5Vpj+kfpnKF3kGHUtiSO1r77QnLX328=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBBSc4YYfywHjabEVuvcKBgs0yT6lTCunw5Hs95EB4mMELaktSx1GKqRky5otTmZ89yywKId9DSsI5H351WDI9zkUhaj6ozbgnxga4LeereSI4sUbcdtTD7gNTynwvJWtJ6kkYqe2zO6D96z4m10BCJmwtCeKj3Z++rFGiEaXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VtRoaZnS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eefe705510so65397301fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721759449; x=1722364249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hbXsSOOY+gKi86u1NQNhucpEoLXztu3BNQ9K2X48C04=;
        b=VtRoaZnSA4HdjPL6xTrZ3dFGNP6QfbM/YUgTJgvB2sopdWdrOSWXQEzS2xjvVXa+nx
         GDHKor/9XfqgXZzstcY+dujuKEL30aTwW++FlnGHSDiTwdwrxq9/Bb0qtwsb7bUwyzRr
         T27PTvODYYr4ngqzR380AQOxEJcdW4xPTSWWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759449; x=1722364249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbXsSOOY+gKi86u1NQNhucpEoLXztu3BNQ9K2X48C04=;
        b=tC6cNxixnpKn54BOiyGi0/XBBfkZqsk3APaDycs0sTTZennHYR+RWu3s0z5KoAQkoe
         ulYNcEFXXHQ7XEhbM8MJdPDFHVxvPeG1pzwoFWoEDhdJWEaqJkRh+p6lDsUrnToYhIQy
         0s3jWvFzWohQpy3SPW0IlzY/18/M8+oto33Qsxql42rHXJckGcbQTkE1tcEkTs8C+Ve3
         lHzqJCd7hRKjkntLKtEexSTEPOEjhjLL5xEtTaIrzFbCWvtSfIOAQG7Nz0NaVQNFdE9O
         Cy7Rscx1qIpsUQ/baGR6OuuqbJXshm5PzQR3SjWqxT9blkxEXME/Z7We/ZmirRXKKB62
         Ml9g==
X-Gm-Message-State: AOJu0YySxJgHUh65A07qLBGE4GjhazgX62edTR3jPtYvd16Vz6Xp0f2P
	Ut2J/er8BRDQ0glPb96EHZdX0/Yn43SQAUwj8+ixA3j210DUO0iJRc3tj1ApokWT+YlfqFicRnV
	4T1U=
X-Google-Smtp-Source: AGHT+IGZZxGiRlFN1zV4wNspnTPs1ARG2y4Ib7mZ5bzjbnoW82VoXW5fY2N9UcH7OT5AbmTEib04Lw==
X-Received: by 2002:a2e:9948:0:b0:2ef:2fc9:c8b2 with SMTP id 38308e7fff4ca-2f02b98b02cmr5172711fa.37.1721759449306;
        Tue, 23 Jul 2024 11:30:49 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef23af7892sm12969941fa.50.2024.07.23.11.30.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 11:30:49 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efa16aad9so2318897e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 11:30:49 -0700 (PDT)
X-Received: by 2002:a05:6512:3d26:b0:516:d219:3779 with SMTP id
 2adb3069b0e04-52fcda6533cmr227963e87.58.1721759448531; Tue, 23 Jul 2024
 11:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723171753.739971-1-adrian.ratiu@collabora.com>
In-Reply-To: <20240723171753.739971-1-adrian.ratiu@collabora.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 11:30:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
Message-ID: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
Subject: Re: [PATCH] proc: add config & param to block forcing mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, 
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 10:18, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> This adds a Kconfig option and boot param to allow removing
> the FOLL_FORCE flag from /proc/pid/mem write calls because
> it can be abused.

Ack, this looks much simpler.

That said, I think this can be prettied up some more:

> +enum proc_mem_force_state {
> +       PROC_MEM_FORCE_ALWAYS,
> +       PROC_MEM_FORCE_PTRACE,
> +       PROC_MEM_FORCE_NEVER
> +};
> +
> +#if defined(CONFIG_PROC_MEM_ALWAYS_FORCE)
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_ALWAYS;
> +#elif defined(CONFIG_PROC_MEM_FORCE_PTRACE)
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_PTRACE;
> +#else
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_NEVER;
> +#endif

I think instead of that forest of #if defined(), we can just do

  enum proc_mem_force {
        PROC_MEM_FORCE_ALWAYS,
        PROC_MEM_FORCE_PTRACE,
        PROC_MEM_FORCE_NEVER
  };

  static enum proc_mem_force proc_mem_force_override __ro_after_init =
      IS_ENABLED(CONFIG_PROC_MEM_ALWAYS_FORCE) ? PROC_MEM_FORCE_ALWAYS :
      IS_ENABLED(CONFIG_PROC_MEM_FORCE_PTRACE) ? PROC_MEM_FORCE_PTRACE :
      PROC_MEM_FORCE_NEVER;

I also really thought we had some parser helper for this pattern:

> +static int __init early_proc_mem_force_override(char *buf)
> +{
> +       if (!buf)
> +               return -EINVAL;
> +
> +       if (strcmp(buf, "always") == 0) {
> +               proc_mem_force_override = PROC_MEM_FORCE_ALWAYS;
 ....

but it turns out we only really "officially" have it for filesystem
superblock parsing.

Oh well. We could do

  #include <linux/fs_parser.h>
 ...
  struct constant_table proc_mem_force_table[] {
        { "ptrace", PROC_MEM_FORCE_PTRACE },
        { "never", PROC_MEM_FORCE_NEVER },
        { }
  };
  ...
  proc_mem_force_override = lookup_constant(
        proc_mem_force_table, buf, PROC_MEM_FORCE_NEVER);

but while that looks a bit prettier, the whole "fs_parser.h" thing is
admittedly odd.

Anyway, I think the patch is ok, although I also happen to think it
could be a bit prettier.

            Linus

