Return-Path: <linux-fsdevel+bounces-16529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9189ECC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 09:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A8AEB23E22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992513D297;
	Wed, 10 Apr 2024 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pp2on71+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C39513D60A
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735731; cv=none; b=u0VGFUP1HUJhoIfs4Wpx8XyceKpqqkTFDEgxgiJJatys1PQZBuucpN0zGyXPPLxybIkhBw7428b1RfnxVJ9E7dr0vzTcez27zgXUXlPnOccKFrb2xIwIikupuBj3QWQTAOOVGINCwp2yTYl7au7m8XGhg6wvajLU8tdcX37U+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735731; c=relaxed/simple;
	bh=pqNpgX0qoIwqOLBxtS6tCaDOhmohIYoLpcCRM8mEwhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lhc7KCKs0m4bGRhXUUWDumJRNQsj2PU++aFhTISJq7JgRKBhAmoeF8//EWzEeOWyzcWJ37YokSKhyQCPFqYJ4IJwMVUl+yOPuhagYJ2xUdO0zPjPXA9mB4CjK3KkrMLr7qd9RwK9KuFTOJHNqVJTkLN5hqtGqXRL9vDZrI19+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pp2on71+; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4dac5a3fbeaso1313780e0c.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712735728; x=1713340528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uS3BUxF5qCtTkHZxGjFabw9iVy7E/k2BpkwDClQgffY=;
        b=Pp2on71+qqigOyfK8fY6ZwAiE6cGgA8rqmzLyxLgazsODDcBLbsho68U3SYPE097d1
         IBLIhoq0XDwhRnhd+PPMKHv7E8UDd6wuHrZ0GI5hpW6dmznVd8hutfrhCu+zDBvkfKbR
         1PUXp8NNNqysNKrX1T2I8mAx+O8gcvUx/AHwheNDY4Cju+yyrwVTri+A5K4MOhxLgvH4
         WkvWWxaAb/Sd6gKGaAWbwUIpkdDudneQAOkjmRAS1yZpfnDgAcaGBVXWpbW6CqLyHnuD
         B/l9jA4YrHKgyb/g+CLKY89x9b8HBQv4SNIHuec2eAxN4D38V0G2NgmFLDtMAQI46ljv
         yiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712735728; x=1713340528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uS3BUxF5qCtTkHZxGjFabw9iVy7E/k2BpkwDClQgffY=;
        b=Iy2oy/8u4MQYuvG87mFsBbF1XXkryBsL/opqAcOxU59KFNifLWmu0eElCkjfAkI7Bo
         xtUY6uNeNmxUSEeEBhFaPi4nhWGwijdbNG8z65T9DCmqGwyKvMEV0KPkzHSsCF1cPk7Q
         5nJM41FQITXX/C9KCOBZD5L+VsAxmJU4tu6R2Dz99Xu64gEiJxoYK0dYZc6CEVUd55X/
         Lm0P/HQNqfvzvtfI1ML770jdDbTCRwdD4gaYlOVy2l+2o5RCuwATTOGkdw2tzGCfscBv
         1h/oY7+2ipWvFBTUCzEkyo09FrlkLkg68kbXcsCIY4fo5k8hm0uK3ENzaNk0Im5iSjvt
         MLdA==
X-Forwarded-Encrypted: i=1; AJvYcCXvPkn0SWKzmnQURsCb6YrROPYcsXNEQIsqf6QxIuN8t2XyK0yCAAerVD/+iqxwO5ePCP1iJ5m4Z1pX8GCthsggkxtM+Q9jfPO+QoNLmw==
X-Gm-Message-State: AOJu0YygX+35cE26v9WUFpZKxqwuD3HGpyrIdw4nS/RPGcfwoSx799zV
	Z4R3RyDMX2SnDHW5dwc3AiqMH5tOeygTsXLRzJr5NDjnzDIgxROReFc8kmxcOn+lMEN0beYJVHy
	btM6KSaStIxjZZZu1XPHb9Gyn4wQy3Trtnyyh
X-Google-Smtp-Source: AGHT+IFzeD+gUEtV1nuDqVBhWDhR3c8rh+fHfgbCTEvNgaxLAeR6T5heeQ/A7dsx9xLWrUTVzlCnXl+91EEnZ3Eql3Q=
X-Received: by 2002:a05:6122:251f:b0:4d8:7443:bca7 with SMTP id
 cl31-20020a056122251f00b004d87443bca7mr2070748vkb.6.1712735728391; Wed, 10
 Apr 2024 00:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408090205.3714934-1-elver@google.com> <20240409103327.7a9012fa@gandalf.local.home>
 <CANpmjNOv=8VBvbKBQbsBdg9y2pNsfdaA-46QB53NY-Ddmq3tmA@mail.gmail.com> <20240410085428.53093333cf4d768d6b420a11@kernel.org>
In-Reply-To: <20240410085428.53093333cf4d768d6b420a11@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 10 Apr 2024 09:54:50 +0200
Message-ID: <CANpmjNOXbWM6seCS9728D+ZXUrF2u+YTCaC7q4ZkHFVM2P+t7Q@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 01:54, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Tue, 9 Apr 2024 16:45:47 +0200
> Marco Elver <elver@google.com> wrote:
>
> > On Tue, 9 Apr 2024 at 16:31, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Mon,  8 Apr 2024 11:01:54 +0200
> > > Marco Elver <elver@google.com> wrote:
> > >
> > > > Add "new_exec" tracepoint, which is run right after the point of no
> > > > return but before the current task assumes its new exec identity.
> > > >
> > > > Unlike the tracepoint "sched_process_exec", the "new_exec" tracepoint
> > > > runs before flushing the old exec, i.e. while the task still has the
> > > > original state (such as original MM), but when the new exec either
> > > > succeeds or crashes (but never returns to the original exec).
> > > >
> > > > Being able to trace this event can be helpful in a number of use cases:
> > > >
> > > >   * allowing tracing eBPF programs access to the original MM on exec,
> > > >     before current->mm is replaced;
> > > >   * counting exec in the original task (via perf event);
> > > >   * profiling flush time ("new_exec" to "sched_process_exec").
> > > >
> > > > Example of tracing output ("new_exec" and "sched_process_exec"):
> > >
> > > How common is this? And can't you just do the same with adding a kprobe?
> >
> > Our main use case would be to use this in BPF programs to become
> > exec-aware, where using the sched_process_exec hook is too late. This
> > is particularly important where the BPF program must stop inspecting
> > the user space's VM when the task does exec to become a new process.
>
> Just out of curiousity, would you like to audit that the user-program
> is not malformed? (security tracepoint?) I think that is an interesting
> idea. What kind of information you need?

I didn't have that in mind. If the BPF program reads (or even writes)
to user space memory, it must stop doing so before current->mm is
switched, otherwise it will lead to random results or memory
corruption. The new process may reallocate the memory that we want to
inspect, but the user space process must explicitly opt in to being
inspected or being manipulated. Just like the kernel "flushes" various
old state on exec since it's becoming a new process, a BPF program
that has per-process state needs to do the same.

