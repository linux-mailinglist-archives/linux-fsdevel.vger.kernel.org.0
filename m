Return-Path: <linux-fsdevel+bounces-20863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F798F9F79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 23:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EC0B2540E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 21:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC79313C8F3;
	Mon,  3 Jun 2024 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dmj9qg1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63513C69C
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450952; cv=none; b=n0lP0VPNycz9/lUAKQ/AebRUZr0Co/zntDk502ZptdeGSg/Z8mq0LasANRDhEOw5NNgnbtb6gXu7wE7u4B8DqiaDlov1hC5WbjjNiGrbmanF6ZjWIMGCrMaFQygLxJLlx0dAmaA0EHQAfj/ZVauQ6uGM/BIJLzK4iJ8JnJYZVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450952; c=relaxed/simple;
	bh=t2+3hpTAkuvcywD1/Fq+cZAsXxs3N6zMjhMfwGrJHIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fd2ClzfMrCWQ0CJBGDDRxY3ms3zxnHvZ0DPZluubXNPBBJfBg/dCRxxb56+IYkLuyQelX1Mhvu31c00nCuOLsPudRWIN4AAuFBnDqaOTGb1vkbCy4S9Nv+umxiRLBieYll4RclMtneUbTX0Kw2UeouDfJ2KWZsZqhRQCQ8VJHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dmj9qg1X; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a196134d1so5613549a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717450948; x=1718055748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=Dmj9qg1XztBap46WqiFWEiVgbWj1Gd6M2//mbEFEZqR9lZgNkPsmnHO8ChltEFVS2N
         /8UnNmRJ7Oezr1ErOHqCIGsJoHr9OtObpBCmZb7uIEDRDftJTylkiyyhx04yCzEoqipA
         ChK5GvwbyV9B47EQDAWxNaGVxt89URW6+5RNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450948; x=1718055748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=pQ6SkvoYRmSCIiNGymLmkGnJDTbSj0wy8dNHuBGW3dRgmkyX4Vb9ZXv49IbGSc+7RD
         gEqkYyvCs32cgYrTDVFwNA52gzqFuJdmMGsARxwooTfNI9qlkaYk40+NKKgh6WK8fSo+
         IfZ5M+UTE4UpOxYwWCCIS8JWVCDUVxXxKFssjUbJbNEVdprUAYgZWwSTxo7jxhL00wEF
         43Zb+EFcHGKHwrU7ureYMEorUbVIRy3ZQunvQhQqV1AwsGO5VIAFXkcbITjF3DQsTXfQ
         hnPna0qV176FhynPZxAt3IJh+k1oMEnef1oMXkhR4jHYhBPbi30AhJSzbotC0lf8+0O1
         szdA==
X-Forwarded-Encrypted: i=1; AJvYcCU1p18hsB0p4bD5W96nNNXdDi0FifUvEJ5LMKsOSNbd+aVOm6SXj4zOkH0+EKXP4TRxrPNNrXW8qnglJaVK6KnVnOFqbfPI1gTPmUtjyw==
X-Gm-Message-State: AOJu0Yx4KUVmBnIah394pctPJrXp7vJ+sJSxtTKpiRZX6uEM8nROpMzp
	yDgFCtQESVPC9iM24dREb6Az9VkNIOCSm+GHAtFF/gUZDqEZJmVSROXK/SQCClTU5mkEiqdjUSJ
	cnOU=
X-Google-Smtp-Source: AGHT+IEYBI4GuPKlhcoxbJThm9ylPv0UHxl7Sd+4OSdkElPirQSdEEMZ8UteOGdvM9vzEouedtg8cQ==
X-Received: by 2002:a50:cd9a:0:b0:57a:3416:85ad with SMTP id 4fb4d7f45d1cf-57a364acf61mr7735091a12.35.1717450948574;
        Mon, 03 Jun 2024 14:42:28 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a7ee6600esm187879a12.8.2024.06.03.14.42.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so368617366b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeDBTN+G+B+sDAG5IdDuA0irsAGbnq3CmmL0hFKeFdOxlPljmsPUC63YXOHrUP+8sdX9F/w26OK6bGb1MGKjF8H7iNFoUmEsUgaTOlFA==
X-Received: by 2002:a17:907:9482:b0:a68:c6c1:cd63 with SMTP id
 a640c23a62f3a-a68c6c1d466mr478691866b.13.1717450947222; Mon, 03 Jun 2024
 14:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home>
In-Reply-To: <20240603172008.19ba98ff@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 14:42:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 14:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> -               __array(        char,   comm,   TASK_COMM_LEN   )
> +               __string(       comm,   strlen(comm)            )

Is this actually safe is 'comm[]' is being modified at the same time?
The 'strlen()' will not be consistent with the string copy.

Because that is very much the case. It's not a stable source.

For example, strlen() may return 5. But by the time  you then actually
copy the data, the string may have changed, and there would not
necessarily be a NUL character at comm[5] any more. It might be
further in the string, or it might be earlier.

                  Linus

