Return-Path: <linux-fsdevel+bounces-20252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE0B8D07DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070A81C21CD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E114315A841;
	Mon, 27 May 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1M6ni55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3D73470
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825843; cv=none; b=dVBtQmGmQ/k019cjIdBRXRnW2s80IV7o+kpnlcyk+lX97bYBIetnc2qT+iJoVg8uCZ5LHzxJAny8nlySQNBO36/yILFbeugBH8n0ee2tmCEtkeVXq++hPwYaMO8DfDgIHWpEwO8MZ/cC+w/dmau7NHdL/75/2Kw2Pv33Fkn7X+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825843; c=relaxed/simple;
	bh=4EmFyncAhhLiKY+1D8a0clxDIqQWULOdjf0ovBAqZOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hwScvf5SwXgm+4eiN1VMiQMtyHUTn35/cZiyhtgKDXIw+4u4MAYBpk13Isu5NoSftKH2qTqqz1G7G0785wQpX/zBchObIT4acI5BzMhW3RkFCuP3RskRI/1+gOjLiUyrAsURQLSSed9F6Hs7GomtBonQL3lZhhxzl8RO0O9xIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1M6ni55; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2e95aba2b88so24927421fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716825840; x=1717430640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJWqJxrkn9eN5G99j0riJdNLIsQh7HlIjrBMGMc+Qc0=;
        b=H1M6ni55WKT5hNa6QGjItDS8EnlyiMwcMYm7r0Yar834aTI/MhAr6DAUme4y9CkPmX
         E/GW1CJ2ChhAKqHMwykpg1e9cV4bw9dxdn5o7LBK/ghdDjfZRk5mXeCmn3nipmw/gi2g
         bfH/oYsFqgLgyODVKHvW8H4shJqDjBcfwzaj7wLUGdiYS5j5riuO3rsaWQSc7L7iFtWz
         B1HC09oQXUGxNLy/8demm/W6OmZR9k4H0NV7pIxwttu9bPHDDPLSvbdXivNJxarp0M/F
         ePEyDQCV2QE0IV4vk/TZL/TutSEehNP1wjboQQ2L/c48NmTXEsXay2fsW+dMNG1Fyfm1
         Temw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716825840; x=1717430640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJWqJxrkn9eN5G99j0riJdNLIsQh7HlIjrBMGMc+Qc0=;
        b=NU6/0dnZAdXaWHqpzgAwUqx4w6BHYfLWXDoknRgOJMxKhOd1FLs5SJq5+j4G8wQpCT
         4CzYQ5a95MhOSCL3NXXXo3i0ekBxWGm78Xo3XQsd7DFRmaT68G5/5sNLTUkfVd0wgdz2
         OkW/KW8qem7f7GVJFqL6Q3dRQdQOYJSzWc5FmWLB9ll0wFqR/vgtFAmBWjQbs2pE3vYX
         OZUZXh3F+TpPAWAs9NG1U8SwGMPRdsNsdhTmsJQJVuh3rwuhhw9E3D2jGJPU7KMd7OBI
         ZXPoR9GNA6m9Pcv7vhceaZS5ifLA6LeWAkUXVppgKd/cLQqS6cTGN6ysH+hbWs+d/+yj
         p97w==
X-Forwarded-Encrypted: i=1; AJvYcCWXDSiVFm2xgJzrtEWLAh6ZA77jH2pVdlxEBX9cFjlP3ZDFrAznkpC2fOUZ+9quEEHboXswIyGhOChv1bTQQ9t4i5hKKDI+uTwJgDz9lg==
X-Gm-Message-State: AOJu0YyyygweVAInw26nkgwy18GSBhTHdcAgczcbvD9LfNbOoZGyuFO0
	XkQGzk3l2tftZkduQWS2yaWV8RgZdS54cQIeeAcykaUe7+FHpid/+f/UsSWLPTtL/xgSPywrGC9
	MzexCgdCHpU1mqQ==
X-Google-Smtp-Source: AGHT+IF3eJeOUIBjEjZ9ZRQCMvF3qFkK/+/n2pG/a8Q4YqeNxCsqp6O78uLUaBfl65HTl/3GKm7277j1vlQVAB8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9155:0:b0:2e2:a6dc:8289 with SMTP id
 38308e7fff4ca-2e95b25667emr88131fa.7.1716825839717; Mon, 27 May 2024 09:03:59
 -0700 (PDT)
Date: Mon, 27 May 2024 16:03:56 +0000
In-Reply-To: <20240524213245.GT2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524213245.GT2118490@ZenIV>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240527160356.3909000-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
From: Alice Ryhl <aliceryhl@google.com>
To: viro@zeniv.linux.org.uk
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, 
	dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, 
	ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, 
	surenb@google.com, tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu, 
	wedsonaf@gmail.com, willy@infradead.org, yakoyoku@gmail.com
Content-Type: text/plain; charset="utf-8"

Al Viro <viro@zeniv.linux.org.uk> writes:
> > > You obviously are aware of this but I'm just spelling it out. Iirc,
> > > there will practically only ever be one light refcount per file.
> > >
> > > For a light refcount to be used we know that the file descriptor table
> > > isn't shared with any other task. So there are no threads that could
> > > concurrently access the file descriptor table. We also know that the
> > > file descriptor table cannot become shared while we're in system call
> > > context because the caller can't create new threads and they can't
> > > unshare the file descriptor table.
> > >
> > > So there's only one fdget() caller (Yes, they could call fdget()
> > > multiple times and then have to do fdput() multiple times but that's a
> > > level of weirdness that we don't need to worry about.).
> > 
> > Hmm. Is it not the case that different processes with different file
> > descriptor tables could reference the same underlying `struct file` and
> > both use light refcounts to do so, as long as each fd table is not
> > shared? So there could be multiple light refcounts to the same `struct
> > file` at the same time on different threads.
> 
> Relevant rules:
> 
> 	* Each file pointer in any descriptor table contributes to refcount
> of file.
> 
> 	* All assignments to task->files are done by the task itself or,
> during task creation, by its parent The latter happens before the task
> runs for the first time.  The former is done with task_lock(current)
> held.
> 
> 	* current->files is always stable.  The object it points to
> is guaranteed to stay alive at least until you explicitly change
> current->files.
> 	* task->files is stable while you are holding task_lock(task).
> The object it points to is guaranteed to stay alive until you release
> task_lock(task).
> 	* task->files MAY be fetched (racily) without either of the
> above, but it should not be dereferenced - the memory may be freed
> and reused right after you've fetched the pointer.
> 
> 	* descriptor tables are refcounted by table->count.
> 	* descriptor table is created with ->count equal to 1 and
> destroyed when its ->count reaches 0.
> 	* each task with task->files == table contributes to table->count.
> 	* before the task dies, its ->files becomes NULL (see exit_files()).
> 	* when task is born (see copy_process() and copy_files())) the parent
> is responsible for setting the value of task->files and making sure that
> refcounts are correct; that's the only case where one is allowed to acquire
> an extra reference to existing table (handling of clone(2) with COPY_FILES).
> 
> 	* the only descriptor table one may modify is that pointed to
> by current->files.  Any access to other threads' descriptor tables is
> read-only.
> 
> 	* struct fd is fundamentally thread-local.  It should never be
> passed around, put into shared data structures, etc.
> 
> 	* if you have done fdget(N), the matching fdput() MUST be done
> before the caller modifies the Nth slot of its descriptor table,
> spawns children that would share the descriptor table.
> 
> 	* fdget() MAY borrow a reference from caller's descriptor table.
> That can be done if current->files->count is equal to 1.
> In that case we can be certain that the file reference we fetched from
> our descriptor table will remain unchanged (and thus contributing to refcount
> of file) until fdput().  Indeed,
> 	+ at the time of fdget() no other thread has task->files pointing
> to our table (otherwise ->count would be greater than 1).
> 	+ our thread will remain the sole owner of descriptor table at
> least until fdput().  Indeed, the first additional thread with task->files
> pointing to our table would have to have been spawned by us and we are
> forbidden to do that (rules for fdget() use)
> 	+ no other thread could modify our descriptor table (they would
> have to share it first).
> 	+ we are allowed to modify our table, but we are forbidden to touch
> the slot we'd copied from (rules for fdget() use).
> 
> In other words, if current->files->count is equal to 1 at fdget() time
> we can skip incrementing refcount.  Matching fdput() would need to
> skip decrement, of course.  Note that we must record that (borrowed
> vs. cloned) in struct fd - the condition cannot be rechecked at fdput()
> time, since the table that had been shared at fdget() time might no longer
> be shared by the time of fdput().

This is great! It matches my understanding. I didn't know the details
about current->files and task->files.

You should copy this to the kernel documentation somewhere. :)

> > And this does *not* apply to `fdget_pos`, which checks the refcount of
> > the `struct file` instead of the refcount of the fd table.
> 
> False.  fdget_pos() is identical to fdget() as far as file refcount
> handling goes.  The part that is different is that grabbing ->f_pos_lock
> is sensitive to file refcount in some cases.  This is orthogonal to
> "does this struct fd contribute to file refcount".

Sorry, I see now that I didn't phrase that quite right. What I meant is
that there are ways of sharing a `struct file` reference during an fdget
scope that are not dangerous, but where it *would be* dangerous if it
was an fdget_pos scope instead. Specifically, the reason they are
dangerous is that they can lead to a data race on the file position if
the fdget_pos scope did not take the f_pos_lock mutex.

For example, during an `fdget(N)` scope, you can always do a `get_file`
and then send it to another process and `fd_install` it into that other
process. There's no way that this could result in the deletion of the
Nth entry of `current->files`.

However, during an `fdget_pos(N)` scope, then it is *not* the case that
it's always okay to send a `get_file` reference to another thread and
`fd_install` it. Because after the remote process returns from the
syscall in which we `fd_install`ed the file, the remote process could
proceed to call another syscall that in turn modifies the file position.
And if the original `fdget_pos(N)` scope modifies the file position
after sending the `get_file` reference, then that could be a data race
on f_pos.

> Again, "light" references are tied to thread; they can only be created
> if we are guaranteed that descriptor table's slot they came from will
> remain unchanged for as long as the reference is used.
> 
> And yes, there may be several light references to the same file - both
> in different processes that do not share descriptor table *and* in the
> same thread, if e.g. sendfile(in_fd, out_fd, ...) is called with
> in_fd == out_fd.

Thanks for confirming this!





I hope this reply along with my reply to Christian Brauner also
addresses your other thread. Let me know if it doesn't.

Alice

