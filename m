Return-Path: <linux-fsdevel+bounces-16572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D2E89F91C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57541C28BEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4158015F3FD;
	Wed, 10 Apr 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="33iofNrw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126515E7E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757588; cv=none; b=StIzrjvvCNQCB4YIdLe26QrPFm2w0S3scJhfddN4VjM0znSI4ikTS9vZ1nDwocLgxOk54IwERlmCUdPSUz2UUt+Eo7RJWIhrPgNRquglQ88sMp0aucTfQLoMo1VRLmzKiuHG8dhvRdiQL++dB76CYTDlfu0ttKPLF4f4MhbcRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757588; c=relaxed/simple;
	bh=6Uqwnw302suIzBJiIBQsZeD3y2gKWEdgNhICFPWo1MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXYTFb3D/3IuO4K/rwO7mQ1tQ0YPDlP9IG/1DQFMl3eoeOyYmk9aFJARafwMfWDtERTbF6LjYE3kayT0+TNzq7W7rICxDfoE0Ie3ZPeJtOLdr4Bmi951JFYpfZcbWwbFpedT6NoLrTHXDI26hrzeCpYvFSOkhm6CV+/iO6c31L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=33iofNrw; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-479e857876fso1715529137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712757586; x=1713362386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5aa3hIWZtOiM9o7F/Dz6DxBBPY3BgmfWmAFxkVrBHd8=;
        b=33iofNrwnfNauxs8afLTgJHKp+9p4CPgdTobmG0+vYEc6KZmX6vufTcD0bPXCZjdox
         wXfy76V/viBwIUp7/KscRduZtTKbddgDkdfBjMR+u+DR+jmnHOdYY8wv0+i8TrofTZPg
         bYBjfuC4Emao2Q1oguAgL/tYrqse0VYyDntA4GbnLyZvoIHhiV/U2etAxX53MTcP0RAw
         hHI23PTSvu/DcUIK+KOrjgP3XOrNmaNO0Ri+djkKxpspJ4yyRbtA5ti+oMlTzNT8O2hW
         DO0VcYQpQUJ6JbgtemPCEAdyGV4A+9/RarTwbTGyNl0o8WAqaU7OwYPiO9b2fvXyGss+
         03eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757586; x=1713362386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aa3hIWZtOiM9o7F/Dz6DxBBPY3BgmfWmAFxkVrBHd8=;
        b=MTVQlOwvNeOk3+tgfuaOUE6ABnqWzhiFDBQgQy9KAue3pgdK4381FRNRK9FGHwM9Gl
         m29h4DnTa6wYnHoJZSg6gEegz0/UWnvIocheBbm/jEdx546qAMI1T3F1yyTqH0wPRgJc
         JzTq8Dv850i2u6tsILNO7EQId9VKha17sYzkU5Q06cFUtJHl3hjxdc2ShyWPOTHYTR++
         i4ko+B/1y3U0yn++P9BfVMikyc7R5enOj1HmdBYdGiDCAZ1llweVtNGZFqWPoNXEi0+t
         ag41sUboLf2DHokseqm/pIRhI5Rdso4ljTMpWFC+UFXD0/1zEpjpq/AeaiFtUzJDFtp/
         IxVw==
X-Forwarded-Encrypted: i=1; AJvYcCVfrqx0hdjVGXAHYoTX/2h5/jBIQdjrblVLHBN7RHt8x1p6Co26dSQHd52FqpZQHnTRcZMSLrYHaIZrPilagdcO+ujyfY28rwGZeCFTzQ==
X-Gm-Message-State: AOJu0YyNsMtaysbxJG90RXHhDCdnoWKu9GoU4HtkcHMGYttLpm22Xu5M
	Ye7O74aV9t81vO+9bQUl8wQYmUALit6bBbIcBMg6y3JSB1nMrTrDCDoUJzFGY/eEz0O4rJubAHP
	h4EIfMbzpVytf8zgV6QE07oKkh0/fXjKbxnLF
X-Google-Smtp-Source: AGHT+IEpsiKA9Ha0aSj78Js7MGsZu+xSPo2OOybBgeVcNcg20IWc+marqLN4JEtWyhh8Xzl0ENJq8kVbtbfz5TbqHoU=
X-Received: by 2002:a05:6102:1593:b0:47a:248b:6846 with SMTP id
 g19-20020a056102159300b0047a248b6846mr2424398vsv.16.1712757585948; Wed, 10
 Apr 2024 06:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408090205.3714934-1-elver@google.com> <20240410225648.7a815ba873c8d55c44385c24@kernel.org>
In-Reply-To: <20240410225648.7a815ba873c8d55c44385c24@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 10 Apr 2024 15:59:07 +0200
Message-ID: <CANpmjNNFcHp0n5J5XWMb=3cpa+FT5V1xeev5dFZCC7SknPBkOA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 15:56, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Mon,  8 Apr 2024 11:01:54 +0200
> Marco Elver <elver@google.com> wrote:
>
> > Add "new_exec" tracepoint, which is run right after the point of no
> > return but before the current task assumes its new exec identity.
> >
> > Unlike the tracepoint "sched_process_exec", the "new_exec" tracepoint
> > runs before flushing the old exec, i.e. while the task still has the
> > original state (such as original MM), but when the new exec either
> > succeeds or crashes (but never returns to the original exec).
> >
> > Being able to trace this event can be helpful in a number of use cases:
> >
> >   * allowing tracing eBPF programs access to the original MM on exec,
> >     before current->mm is replaced;
> >   * counting exec in the original task (via perf event);
> >   * profiling flush time ("new_exec" to "sched_process_exec").
> >
> > Example of tracing output ("new_exec" and "sched_process_exec"):
>
> nit: "new_exec" name a bit stands out compared to other events, and hard to
> expect it comes before or after "sched_process_exec". Since "begin_new_exec"
> is internal implementation name, IMHO, it should not exposed to user.
> What do you think about calling this "sched_prepare_exec" ?

I like it, I'll rename it to sched_prepare_exec.

Thanks!

