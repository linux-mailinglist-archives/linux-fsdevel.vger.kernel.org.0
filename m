Return-Path: <linux-fsdevel+bounces-16704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0D8A186A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DF71F24B5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D40376FC;
	Thu, 11 Apr 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RhcAV1jX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4015E97
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848508; cv=none; b=G4/+8UMjb36++SgRU9R5o4CCSSFi8GraL1uBrDNSzqh0YTYVwGFQRQ/YNM0BlB8kof53GSk9bH79YTVRbwAIyMT/QmYO5AA2eLoViGEJC6UEtMhXcY0gztAUyjGmKVPsyXMd+HPaTpZ2lvpWwCoqUcIIX0KNY8GA9ZJGCDz7A+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848508; c=relaxed/simple;
	bh=ykrCsBxsPgKhyE3GYL+XJuoXa3s/bXlZI1ZvQ8tnwOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tljIeGYF4PXxbMoV6nTWX5uEE5GyZd7TUU/6I5rc4lLbhwapGcrGrFyY2YBtSixfn1kUXMZmXyrBM7K+S046DyWAAnoVTygW9dFQu3giNTBysZeIBKQAA3ugc9ddeUals/kY33WML6m95SA29bg2SYQyA77BwRSRQigtY9zYpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RhcAV1jX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29e0229d6b5so6415481a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712848507; x=1713453307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y27o1QGaPj1N7cZ8H8ZqjEg3waA9EItOMXyHWJlIzfk=;
        b=RhcAV1jXYquKsfeQAGdwKyX38/JQZ67w2RROeMkzd00GXyVUy2w5m1/NQ0vT9LdD6r
         /xuwKZO/e2OD64H8Zx8VoRJSgpf8TYgtH6sFlO0XZrb2Sbrf3yQFdFO+i3tzdGmE7Lx3
         zQxjiiydx/fkL1xsUzNnsU4dyOiRUq+Qfa+HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712848507; x=1713453307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y27o1QGaPj1N7cZ8H8ZqjEg3waA9EItOMXyHWJlIzfk=;
        b=gBXFMHurkiIMkSW6HkiKjHAgjLIB1eGVy/6iryHotkPlamoqWewkqi1QNCf1cyYt5e
         zqrxKwmY29ljvlU3zAbCRTN9wu83UJ3LIL9BOLAmPwoGIYxbBK2vu5lRaK7OQWJXug92
         2by27X0CyXTHUZyNK9ZWpD1ZHKKgcY2LM4KujBsCRGsoa0QWT8K7KgDclY8xNWX8ZKnA
         tZ8eeidoKbYlCPAi/Ey9aND9psXZSNbCcifTK7yP2i6pM05Q1ieDhXO1UhdDj4meLT5C
         aGFbgK2ltK3sFAiUl98DtP/rhLhRRc1G4/uh/gAXBwEqCQg/H1gYIikUi0h8DYUQlL4y
         41gA==
X-Forwarded-Encrypted: i=1; AJvYcCXPt1OBBSlDVTlPNmtI+hPMLVw6ihHh+g+mfxhjxPR9YbsRwWeTC3Wi4E9ONTcDLA/ZIQKTLTuXZ8uptpA6Phhls70Yt+gqj9A16kah1A==
X-Gm-Message-State: AOJu0YwB6tWmtJ4IUVUGxT36h7L7fhR0WyQYZgOUAgAqZhgG6Jqdd7rC
	bZAxlbxME7HvnOEPzbX+7rWs0G1dxc2dTVFKTPCEujjwnqiPL5jkw6qZQ8ofN8rtbBwlm8HJGG8
	=
X-Google-Smtp-Source: AGHT+IFXnLf46pENpWqaLeFh27xQfZIeEOpHx3elub8SYDi07FpFtNbcgpbZ5CexGlBw+CMhsVGm7Q==
X-Received: by 2002:a17:90a:bd8e:b0:29f:7fad:ba50 with SMTP id z14-20020a17090abd8e00b0029f7fadba50mr5988643pjr.8.1712848506772;
        Thu, 11 Apr 2024 08:15:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090ac20600b0029bf9969afbsm2963349pjt.53.2024.04.11.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:15:06 -0700 (PDT)
Date: Thu, 11 Apr 2024 08:15:05 -0700
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] tracing: Add sched_prepare_exec tracepoint
Message-ID: <202404110814.B219872F76@keescook>
References: <20240411102158.1272267-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411102158.1272267-1-elver@google.com>

On Thu, Apr 11, 2024 at 12:20:57PM +0200, Marco Elver wrote:
> Add "sched_prepare_exec" tracepoint, which is run right after the point
> of no return but before the current task assumes its new exec identity.
> 
> Unlike the tracepoint "sched_process_exec", the "sched_prepare_exec"
> tracepoint runs before flushing the old exec, i.e. while the task still
> has the original state (such as original MM), but when the new exec
> either succeeds or crashes (but never returns to the original exec).
> 
> Being able to trace this event can be helpful in a number of use cases:
> 
>   * allowing tracing eBPF programs access to the original MM on exec,
>     before current->mm is replaced;
>   * counting exec in the original task (via perf event);
>   * profiling flush time ("sched_prepare_exec" to "sched_process_exec").
> 
> Example of tracing output:
> 
>  $ cat /sys/kernel/debug/tracing/trace_pipe
>     <...>-379  [003] .....  179.626921: sched_prepare_exec: interp=/usr/bin/sshd filename=/usr/bin/sshd pid=379 comm=sshd
>     <...>-381  [002] .....  180.048580: sched_prepare_exec: interp=/bin/bash filename=/bin/bash pid=381 comm=sshd
>     <...>-385  [001] .....  180.068277: sched_prepare_exec: interp=/usr/bin/tty filename=/usr/bin/tty pid=385 comm=bash
>     <...>-389  [006] .....  192.020147: sched_prepare_exec: interp=/usr/bin/dmesg filename=/usr/bin/dmesg pid=389 comm=bash
> 
> Signed-off-by: Marco Elver <elver@google.com>

This looks good to me. If tracing wants to take it:

Acked-by: Kees Cook <keescook@chromium.org>

If not, I can take it in my tree if I get a tracing Ack. :)

-Kees

-- 
Kees Cook

