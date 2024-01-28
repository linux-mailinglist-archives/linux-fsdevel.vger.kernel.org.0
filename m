Return-Path: <linux-fsdevel+bounces-9272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FED983FAEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 00:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DC0283F0C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BA9446DC;
	Sun, 28 Jan 2024 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="II43344E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A7446C4
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484272; cv=none; b=D8G6s1LJIkVms5ev1EK36y5qXvbjR6UqsIPAbCsaoIpAmIorJlg0TxRgRUWu3vu1+2opSucWM8yz5Y3AZh5TdSnK4OS+INvXAZbyz1btgTa7LmWiXGjYgvgQD/fJWPGeII7ePmJhQWhv6wCTzv6vn5VZ4GMmcWBQrdL6nM/Q6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484272; c=relaxed/simple;
	bh=9/r5pGc0syXMlG1sSpc6aC3inL799ywZ/tGalu+3l60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4jypEkM9yeREd8TWmkKQHeWtKzbTZ7PmfLUOHqYz7bZNAxW4bv+0K+VBS9F+OiFjxkxXoZu0vvOxfep/hCLiVGQiQIbdb7gJ5G+9fSPHvWWKUdamtQoW5lZ8B7rTVG8Sa6tIxLr5LwjhjhL4M7EXuVi8qF5JD9RDM19F81/0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=II43344E; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-510322d5275so1635815e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 15:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706484268; x=1707089068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8xYcjk2qCrA+lcOwLQA0ixbhMQnVA5kQAe6loZvmX60=;
        b=II43344EzuRtLxWRYIYQ1ku2EyINcHsK3HSfV2nWQpeHJcA0w3GTuYug9tzJd6/5XH
         yxZn9cJkOKMRRtausXDKfEyRuGiQvnB9H9s5281jE1h1r3V/YfzBnu2j1CcL3z9s8lwp
         Pv6FUmB2pCp3Y3tF8huGtvE3LYdO6+uKWAwz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706484268; x=1707089068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xYcjk2qCrA+lcOwLQA0ixbhMQnVA5kQAe6loZvmX60=;
        b=kQW7EmETHj8nYHvlp4m616CXaKKYqacR6EESwNMpWpm5UA5MDP3NT+bGP/notpnXHG
         1UoxpObVQ5T3zvqDOIG5KGIqnFTOIPI6x7NotgEuFlpUVlxw97PzDIxy+oPVDZliLfo3
         SYFbpdeiUg7JsOCFzsUdxWcufvnms+JsOketBkjJNBOYor81Gp3RnTgsvrz37l5z6xcq
         fehElF2LdH76BSrs79EEUzFjYNIEjeDnrqoplgYdmhi5BCmieSkz0/2LKFvZSbLbov/q
         0XxDq2AUUfyHJuZhIMUZxO0v+ZFPiBvRoumNgZ3udzLi9JfD4Nh154WhoIjMDL0nR5WV
         KNBA==
X-Gm-Message-State: AOJu0YwBp1Cj9XZvYgLQ81GL7ouwr1zz3Q437FTxWLV6FxwuG6acRoSu
	yMEQTsrdriFkmTsVaAA+OqnKfgFSTClFEx2GCljqIYwpnvXPdOw1eFG72LL39rPzvKhJFc2KmHp
	pj7zHyw==
X-Google-Smtp-Source: AGHT+IGjiS30cI+BIwR8ZFEW3DXGMvCXITOgtmXX8q9UkBnEwm3RyvKcZkSjdSfW2wJ1EkIz/LeiIg==
X-Received: by 2002:a19:6558:0:b0:50e:246d:7566 with SMTP id c24-20020a196558000000b0050e246d7566mr3292173lfj.7.1706484268262;
        Sun, 28 Jan 2024 15:24:28 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u20-20020ac248b4000000b00510203022a0sm913868lfg.199.2024.01.28.15.24.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 15:24:27 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf588c4dbcso13836711fa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 15:24:27 -0800 (PST)
X-Received: by 2002:a2e:a4bc:0:b0:2d0:4e84:b278 with SMTP id
 g28-20020a2ea4bc000000b002d04e84b278mr160192ljm.7.1706484266774; Sun, 28 Jan
 2024 15:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com> <20240128175111.69f8b973@rorschach.local.home>
In-Reply-To: <20240128175111.69f8b973@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 15:24:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
Message-ID: <CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 14:51, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I was working on getting rid of ei->dentry, but then I hit:
>
> void eventfs_remove_dir(struct eventfs_inode *ei)
> { [..]
>
> Where it deletes the all the existing dentries in a tree. Is this a
> valid place to keep ei->dentry?

No, when you remove the directory, just leave the child dentries
alone. Remember: they are purely caches, and you either have

 - somebody is still using it (you can 'rmdir()' a directory that some
other process has as its cwd, for example), which keeps it alive and
active anyway

 - when the last user is done, the dcache code will just free the
dentries anyway

so there's no reason to remove any of the dentries by hand - and in
fact simple_recursive_removal() never did that anyway for anything
that was still busy.

For a pure cached set of dentries (that have no users), doing the last
"dput()" on a directory will free that directory dentry, but it will
also automatically free all the unreachable children recursively.

Sure, simple_recursive_removal() does other things (sets inode flags
to S_DEAD, does fsnotify etc), but none of those should actually
matter.

I think that whole logic is simply left-over from when the dentries
weren't a filesystem cache, but were the *actual* filesystem. So it
actually became actively wrong when you started doing your own backing
store, but it just didn't hurt (except for code legibility).

Of course, eventfs is slightly odd and special in that this isn't a
normal "rmdir()", so it can happen with files still populated. And
those children will stick around  and be useless baggage until they
are shrunk under memory pressure.

But I don't think it should *semantically* matter, exactly because
they always could stay around anyway due to having users.

There are some cacheability knobs like

        .d_delete = always_delete_dentry,

which probably makes sense for any virtual filesystem (it limits
caching of dentries with no more users - normally the dcache will
happily keep caching dentries for the *next* user, but that may or may
not make sense for virtual filesystems)

So there is tuning that can be done, but in general, I think you
should actively think of the dcache as just "it's just a cache, leave
stale stuff alone"

                  Linus

