Return-Path: <linux-fsdevel+bounces-20868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019328FA57B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 00:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A831F23DDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6FD13C9A1;
	Mon,  3 Jun 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S5hRKr7y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00C522E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453450; cv=none; b=tkFZyaiBv748Ezxn3XumRHJmoxMikgPmMa1RT2XdP5Jp2ZiCSCoixW1QtuvcVpSSKvNrrnAnb1kjgWNGB8SNED9LkwFPAgrtwPzYQgjtF2VCvkp3RE4G1HKN6jq9dRl75/ZU7JLNBTG9dsWcmqodMbYsJLUsHs67T6GaPBIp4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453450; c=relaxed/simple;
	bh=AFfU/PEC+zuhNdQ2tMeUL2Lz6Nhx2hQNDlZEumLFtHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCWp3SsjT/MIaeIkKoIBJpGPShTSfArdaDgE+Fywx/571UKEbu/4goureipv5JVRf58FuCHcVoUls0LDwTphnJViS5WLVlubZDu5gRaaDy9lmhet+cLzPy6fOMb/67Ye+oWICdtJYF+0Rhlw2KMKe6Ed8g5N+N1LVsGvg8tneQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S5hRKr7y; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a68ca4d6545so380651366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717453446; x=1718058246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUfCTj7RhneZiyZGwU4My8ep0xDaKOVngko5RyaH/ts=;
        b=S5hRKr7yQALiLVJkkO2wtVYvBEb3x2SPNLmceNDrq3KaaI1x/4n94eF9zaTOUvBbJ/
         QC1XZ7XfUmU43RZCqjfbiw2NmwgR7WoP/ijh4vfjOwkY69lK2LDr/yFuriQ1YNd+Pa7I
         QfIxODqYXOy0btXiQQ/5yZaJwKeOCNq2KU858=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717453446; x=1718058246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUfCTj7RhneZiyZGwU4My8ep0xDaKOVngko5RyaH/ts=;
        b=no5lUaTEjy54Gba+gy4T8PQXNgOZlspLDqZCs5CiZ/0W6ztx4tyn0rxohIuS5Oe1qX
         JU4GU7S4cYJZI/QyqTQrELZKrtgpSgSBL7esukkGcTVi3z6T4sCbjUWy+IOzx7DQ66zp
         B3evgP7lxbQENQ7jIoSLYdL5MONiasvLpfIpfqXgc4BPhQdVWH3Zw40aLV0rfBZ5BQVZ
         9QxeFn73i2yXSGYU+pboADjrLmHL9E9+IlFUBrcnmzxqPVkWm61Fd95CDzSq0qccfgMs
         Qr+G+CDCSqJAS7Q/otPdYrh0OflKLO59Px+F7dynIJ1i9LYT02b25OQEkIQSaURTQ3kf
         OI7A==
X-Forwarded-Encrypted: i=1; AJvYcCXIGNswrLkBUr/IdO1BmxPrWJMEW0g7s3oePC5oVDOJYdOth69zlsziHaI7jm7+HekC+PjWUT+rJKi6u9NS4vda3KEchj9JFTgG1dBMNQ==
X-Gm-Message-State: AOJu0YymBST0XVCKFZ93tLOBfcBLHOf59xC62yxSvdsaygDAeBO0ejPb
	jT/HmbAPGrFIyVk7lYSdqv9HZ5sMlWjN7lRvwZ5ajm+IYBYnZgYdhzJpJqXBJbgp3pgD9zXP0xj
	RPvqiFA==
X-Google-Smtp-Source: AGHT+IFBwUhwHhQRJdnowGAs2SsneRdSzusDRCCReI0j8jpovXDgW+UW8x558d05Y+ggri9b7tS4cw==
X-Received: by 2002:a17:906:4151:b0:a68:a79b:bd35 with SMTP id a640c23a62f3a-a695413e827mr69871766b.5.1717453446446;
        Mon, 03 Jun 2024 15:24:06 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a691a8f98ffsm161264366b.123.2024.06.03.15.24.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:24:05 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a68fc86acfaso256684066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 15:24:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMdQBhSVrAkx2ZnZk/ql71pM4+qWPJJlhbIVPgUIIhtHqphu1hGaajGRhObI+fUENZ0Yv79WAo6RvUDh5k9qka+NNl11A6CqKUGJmHsg==
X-Received: by 2002:a17:906:d217:b0:a62:49ae:cd7b with SMTP id
 a640c23a62f3a-a69543e118emr67505166b.24.1717453445163; Mon, 03 Jun 2024
 15:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home>
In-Reply-To: <20240603181943.09a539aa@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:23:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
Message-ID: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 15:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The logic behind __string() and __assign_str() will always add a NUL
> character.

Ok. But then you still end up with the issue that now the profiles are
different, and you have a 8-byte pointer to dynamically allocated
memory instead of just the simpler comm[TASK_COMM_LEN].

Is that actually a good idea for tracing?

We're trying to fix the core code to be cleaner for places that may
actually *care* (like 'ps').

Would we really want to touch this part of tracing?

            Linus

