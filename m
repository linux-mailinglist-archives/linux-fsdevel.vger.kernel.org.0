Return-Path: <linux-fsdevel+bounces-9270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B4083FA64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E07A1F2343B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2036541C95;
	Sun, 28 Jan 2024 22:51:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B4144375;
	Sun, 28 Jan 2024 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706482274; cv=none; b=QyojlVi31g1B+I7KhRRiND8wdzWT5rzXXFiaYH35Xb/sLSU5NsWMVHRh/SZM7yW6VRr6gQux7BON73z0CTZUs6TvhpSNzy0PypuUMZ0hxyTV5OwSHFdzPyU+axX6ee7pepICNVRf2R+lvPTyV4TIlVzFfevRNSo43cAIXD9off4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706482274; c=relaxed/simple;
	bh=RdgePR0KOVMfuGg1U7Yj893/E1ek6ofqOQ4gEhYMix4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtVvTkwB4oM/danbXOZpErjKooSjoJb94CPFYp8ZAh6HUpzTzrU7uevRobsvDk4csliStujE6y8WnkmdsE800nNyXXLyQfnccfb000ikECs6ViDlVnNfT9qVR32HRLNKoY+qYd8DVsartIL8/Z7cRCKVjXCjApTeTXouzap11w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1692FC433C7;
	Sun, 28 Jan 2024 22:51:12 +0000 (UTC)
Date: Sun, 28 Jan 2024 17:51:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128175111.69f8b973@rorschach.local.home>
In-Reply-To: <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 13:47:32 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> There are tons of other 'ei->dentry' uses, and I didn't look at those.
> Baby steps. But this *seems* like an obvious cleanup, and many small
> obvious cleanups later and perhaps the 'ei->dentry' pointer (and the
> '->d_children[]' array) can eventually go away. They should all be
> entirely useless - there's really no reason for a filesystem to hold
> on to back-pointers of dentries.

I was working on getting rid of ei->dentry, but then I hit:

void eventfs_remove_dir(struct eventfs_inode *ei)
{
	struct dentry *dentry;

	if (!ei)
		return;

	mutex_lock(&eventfs_mutex);
	dentry = ei->dentry;
	eventfs_remove_rec(ei, 0);
	mutex_unlock(&eventfs_mutex);

	/*
	 * If any of the ei children has a dentry, then the ei itself
	 * must have a dentry.
	 */
	if (dentry)
		simple_recursive_removal(dentry, NULL);
}

Where it deletes the all the existing dentries in a tree. Is this a
valid place to keep ei->dentry? I believe this is what makes the
directory disappear from the user's view. But the ei->dentry is there to
know that it is in the user's view to begin with.

-- Steve

