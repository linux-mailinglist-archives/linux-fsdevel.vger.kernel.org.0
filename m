Return-Path: <linux-fsdevel+bounces-49141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7663FAB889A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 15:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE05B3AD37D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C3B1990CD;
	Thu, 15 May 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="eSmpYmn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3F189915
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317390; cv=none; b=A2DU3RZWOA7lRiT8rNn95x2fkReovCC8OPs8sJ7EiABvPdDzNJ1GR4Ng2nlAfgAyKzBuHxovQ9sKsiUlfaNrDBUnRYO/D5yaqkOn/hn3cXli4gxpOP0PrU6zfFw9ppk8UJB0HKrgDE4VdswUXT/jcaD0sNevSo/NiaZwKJ0gQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317390; c=relaxed/simple;
	bh=Sa7GETTQgwfVClLUd5WysYho63CW2Ury9OOVP7i4C9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMwdxoqoKZbKRVs5ZIHXMZFUMrF8Oqjg2wionOYPT0UXI+RPBfcfpBeggvVAnAOlJTRVkwgjWPmIGTNYvl5cvyIDUnWnfug5kI6jvHM3bEc1Va8MVSjw8ytyRomaBzIdaYenEmFPOnMnh3qHv9dNtjnmK3mx7bnQuWqLW47/tkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=eSmpYmn1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-550e2b9084dso510109e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747317387; x=1747922187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rm0gTtyW2LsxAMkxrNunR4Q/6X7D+Ybvvf7I2m4z9Sc=;
        b=eSmpYmn1Iqh85u9V2kvbtizkz5IuhNwsCxMFXJ3JWMHEM9hDezYfUMf4SERrjznqgj
         M5AW/pYk4myxOrz2rDN1HxUfSmtjQDvE/laJn3yuKs5oXWUGqgp2q3u4KscinaH01CeY
         ZMctDsdcl8UKK9/v6T0YYvMVBl5sd/4tm6R2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747317387; x=1747922187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm0gTtyW2LsxAMkxrNunR4Q/6X7D+Ybvvf7I2m4z9Sc=;
        b=SS+3mBtrRiYkEqc1Mtn3qUkv4GgUFNO5QNmF49tlMVn0/DJ2byBA0nQ1soqLQi2fhW
         XOoWb2tGYI4SOP7sMAhCZLM6W+b/mpLaNB7AuXkZD0M4wYcGy5SOts/L8fruqfdcNMdw
         3fBqW3h4bgCq/pujvwLQuwKIaecpFxE+lVFdKqTFVq+u23LOQoVjsd46P9svu/K3Y0As
         lhzwzY5+yA+At3wSfpWSN+ACRb3rNO6nMgE2IGJuXXWlol0fWS1gDm+N68kaXvgQ2s9f
         rTihXQe9uQTGWbMBuEFTDmEvyU3ReplKrCHMUilUcxYFRccQutRLnSoWULv106Ti6poV
         WFng==
X-Gm-Message-State: AOJu0YygY7yPwabfX5Go3b7AmVAR1M59UaGi6zbaN4XxOghCFbe+cltm
	YmNnLbt8znbMGeEYt1Psrp/yv3WSeg+Rpz4pO4Ru5/pl5hMiJHQEFp72q7t+lXo0bQlDuRwHDPX
	iBUk/Ct6A/MHKd7fFo9Bh8ecZm5urS8oX70uoHQ==
X-Gm-Gg: ASbGncvLMmoOZO2hxsfz+oi4QZUmQ5ygimWNGIwLCsHHRWGMeCS6oxwtqmbYUWX5V9L
	tzDwv+hdco4kSfQPgUm1pbNnbAQ88mSaLY9tGa4zgbPXHNYKAr6K1AUNnpRw6kuspK9w7qtUU4x
	XmyMYBIWMatSi3hX4kk6AxQTqylDLZQuKumg==
X-Google-Smtp-Source: AGHT+IHGJpz7aWTwl9mwnxLim4Wu4UpJRoyZSChwbFUtfQOjHxlGMmgBOj6a+6ZvRKFBtH84qKDoTSz+2awicFIRtmo=
X-Received: by 2002:a05:6512:3183:b0:549:5b54:2c6c with SMTP id
 2adb3069b0e04-550dd00417amr888488e87.23.1747317385975; Thu, 15 May 2025
 06:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 15:56:14 +0200
X-Gm-Features: AX0GCFtkXNTU1UNhCQJwYHTj0HQMppT1zbtgyuIpAsA_JMgRpL61RCC5l6sfyU8
Message-ID: <CAJqdLrq4sCbCV7pjVdtSktsgwA-PWrgrY=_gFn0pVTQ59ZTtNw@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] coredump: show supported coredump modes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Allow userspace to discover what coredump modes are supported.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index bfc4a32f737c..6ee38e3da108 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1240,6 +1240,12 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
>
>  static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
>  static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
> +static char core_modes[] = {
> +       "file\npipe"
> +#ifdef CONFIG_UNIX
> +       "\nsocket"
> +#endif
> +};
>
>  static const struct ctl_table coredump_sysctls[] = {
>         {
> @@ -1283,6 +1289,13 @@ static const struct ctl_table coredump_sysctls[] = {
>                 .extra1         = SYSCTL_ZERO,
>                 .extra2         = SYSCTL_ONE,
>         },
> +       {
> +               .procname       = "core_modes",
> +               .data           = core_modes,
> +               .maxlen         = sizeof(core_modes) - 1,
> +               .mode           = 0444,
> +               .proc_handler   = proc_dostring,
> +       },
>  };
>
>  static int __init init_fs_coredump_sysctls(void)
>
> --
> 2.47.2
>

