Return-Path: <linux-fsdevel+bounces-9259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199FE83FA2B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8312C1F21824
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 21:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE4B3C47E;
	Sun, 28 Jan 2024 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cqsCK5NA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC83C461
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706478208; cv=none; b=SyGRbDk7G77jG0YCw7eO4tTGa2RVvRuEqpKfwwWsoPtxIuEZ7tZCrg9utz/hAlUgDxeKNJn2uoAnttecBxJxqdGfdmyqL6STZBDATaffE2jf/yPeiKMjCIBYsinkgAPPPa1mmP6x3T54a5IYqDb9OV/6Ud/d7eKPSkFgRshpmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706478208; c=relaxed/simple;
	bh=63lBANGbYbeRuMlZZjypCZRBzn7lv4lWgbJyEC8XTag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kevf4CIM3QmsrwsyD1je4yaHPJ2r8dCqyjjqCOhWsLrFqoLxBnItPiJB2eAvipdHe5pcru1OMnrhOmQekRJFYpQY7lqVchsbEH8R7MtiP2hlYngDy7yrK2w8SVcyuc1svVLt4rWpwV0BeEzP1hwppv0hBuLrS9pwXcqbs5aHVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cqsCK5NA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso1680752a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706478204; x=1707083004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vlOP1NBhYVtNXOiXGs9r7VySXF9k7GylPcxJ5w9F55s=;
        b=cqsCK5NACF+qZaKoQyxnUkbjWgzXQSCqe7wme/aDATwk251Pg37KXmhZEVZFNOtxul
         8QLG0/lME4m761PpKmxMgPXEkGTk4PhRbbCOqrBXKbt1v13E017GRPfd8bWfZzFz6D+D
         J32rPdlYq22CL2E4lczK2KGN7q3neQmR4XRf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706478204; x=1707083004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlOP1NBhYVtNXOiXGs9r7VySXF9k7GylPcxJ5w9F55s=;
        b=GyXnyeQMrViAgI1etRoWzoOXI0zkSMjNWB4/J4yHjv2u7yykJP051QgM3F/D3WsuKk
         q5emLOc/h8M55GdZs9F9n01LyXjHAWqtT0BN7bQOhdgEt9t5WeXPgKvV0HDaHMbQUgHl
         eHYsyt0BgKENy7MR7qJGy+Rru7ED1Y00wycYzgnstMNPKuYycFHz38KaGmRphkRN0mmT
         EIrhwi63puca0igrUQ0wcDE3EcbIYACZqntiPcCXWvM2uW79rsxMJCXbQd0uEucCWmcP
         VJwHO/BmHqZwnUyenvy0M3o2z/DkcIg0S9JgdI9IlWG8zagyen4DR5eWrXTAYPVi+0OJ
         cBmw==
X-Gm-Message-State: AOJu0Yz2yVAfKbITqpCBnipWRsHZVC9HMRr/HcOx0kMNi0GEtLwLgc6M
	wk+9bM+n9DdqixQ0BX/Y7UeG/t5zgoCf9GvYv99c+lcLt85dfXKR8ycmZHBaK1+y45653h6HVW2
	G9kg=
X-Google-Smtp-Source: AGHT+IGC7cnoiktBu8UEwNxTkt4cLuY/htXCJUzK0XWto3RpLSgZ4hx6teDur+akVU9k8hDA0RYdZg==
X-Received: by 2002:a05:6402:3458:b0:55e:f71c:c47a with SMTP id l24-20020a056402345800b0055ef71cc47amr744634edc.30.1706478204194;
        Sun, 28 Jan 2024 13:43:24 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id p14-20020a056402500e00b0055c67e6454asm3107014eda.70.2024.01.28.13.43.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 13:43:23 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso1680741a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 13:43:23 -0800 (PST)
X-Received: by 2002:aa7:d95a:0:b0:558:252c:2776 with SMTP id
 l26-20020aa7d95a000000b00558252c2776mr2608270eds.16.1706478202684; Sun, 28
 Jan 2024 13:43:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
 <20240128151542.6efa2118@rorschach.local.home> <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
 <20240128161935.417d36b3@rorschach.local.home>
In-Reply-To: <20240128161935.417d36b3@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 13:43:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
Message-ID: <CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 13:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The deleting of the ei is done outside the VFS logic.

No.

You're fundamentally doing it wrong.

What you call "deletion" is just "remove from my hashes" or whatever.

The lifetime of the object remains entirely unrelated to that. It is
not free'd - removing it from the hashes should just be a reference
counter decrement.

> I use SRCU to synchronize looking at the ei children in the lookup.

That's just wrong.

Either you look things up under your own locks, in which case the SRCU
dance is unnecessary and pointless.

Or you use refcounts.

In which case SRCU is also unnecessary and pointless.

> On deletion, I
> grab the eventfs_mutex, set ei->is_freed and then wait for SRCU to
> finish before freeing.

Again, bogus.

Sure, you could do is "set ei->is_freed" to let any other users know
(if they even care - why would they?). You'd use *locking* to
serialize that.

btu that has *NOTHING* to do with actually freing the data structure,
and it has nothing to do with S$RCU - even if the locking might be
blocking.

Because *after* you have changed your data structures, and prefereably
after you have already dropped your locks (to not hold them
unnecessarily over any memory management) then you just do the normal
"free the reference count", because you've removed the ref from your
own data structures.

You don't use "use SRCU before freeing". You use the pattern I showed:

    if (atomic_dec_and_test(&entry->refcount))
        rcu_free(entry);

in a "put_entry()" function, and EVERYBODY uses that function when
they are done with it.

In fact, the "rcu_free()" is likely entirely unnecessary, since I
don't see that you ever look anything up under RCU.

If all your lookups are done under the eventfs_mutex lock you have, just do

    if (atomic_dec_and_test(&entry->refcount))
        kfree(entry);

and you're done. By definition, once the refcount goes down to zero,
there are no users, and if all your own data structures are maintained
with a lock, there is never ever any reason to use a RCU delay.

Sure, you'll have things like "dentry->d_fsdata" accesses that happen
before you even take the lock, but that's fine - the d_fsdata pointer
has a ref to it, so there's no locking needed for that lookup. It's
just a direct pointer dereference, and it's protected by the refcount.

No special cases. The user that sets "is_freed" is not special. Never
will be. It's just one reference among many others, and YOU DO NOT
CONTROL THE OTHER REFERENCES.

If you've given a ref to dentry->d_fsdata, it's no longer yours to
mess around with. All you can do is wait for the dentry to go away, at
which point you do the same "put_dentry()" because exactly like your
own data structures, it's JUST ANOTHER REFERENCE.

See what I'm saying?

                Linus

