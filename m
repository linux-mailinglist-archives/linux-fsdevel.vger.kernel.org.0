Return-Path: <linux-fsdevel+bounces-24976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CB094784A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E172F282676
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DDE15351B;
	Mon,  5 Aug 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s79evrl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8949650;
	Mon,  5 Aug 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849987; cv=none; b=gR/rT9r5n+CzA2RBjlhluIMHipO95wG/ib3rQkqK5vaLPiR3JtSZndyS++PMcxc/yXhYNizBNpNNmgR48yWSBQcGvCkh6SMZYTaPPjRrOIDm7G7/yQ2tQA2IQXuqI97JzwZHhb+1ADyVc60CPQkoBYjNDr6LFUQ7BRGEzo7DwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849987; c=relaxed/simple;
	bh=tnpHQw8Llr6uw/Dtux0kJMHq9kupSIzxaNiemENDgwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1ZzMWJqbg5AmdwUONgjwn2zTcaBU0sPqqlUyT7fPNxG247haFIVVXMbm0KSQ4gnhNM1f0zNxF0oL5zs/L2Xidgcp5b5lqA7trdV1QMJMjubVKt+Nuep0xn+sI2I4jueFMpjZ6wT2k1NWoXGS/Upf4byGwvJmZAJmm2fNHgJk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s79evrl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DAFC32782;
	Mon,  5 Aug 2024 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722849985;
	bh=tnpHQw8Llr6uw/Dtux0kJMHq9kupSIzxaNiemENDgwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s79evrl8kjfRthVCTcvK2m6/eoaxZ3CL3WB1nA6SKpuaXA2SZe49xN+cEVdb/LhYV
	 ywwjgixEK8xZD/nWp7nKZW+DPY0HQ9xEpRETk8xXzSqby4pqV7WB6QAeKhfHin5h8B
	 BSKkgwk/IBXBy/YeqZfWfXyYkfDSoVodUKH3k+z0szZBIovusHt6fMP1a7YdrHDBlQ
	 BYoTGXAje+pgKvryrp+yLe7qONn5IleGDqdeoOub7T/oo3rcfXN1Wi8FwePbLYe0ce
	 qDe4brVkymcfcX3toKnMw8rl/buz2sZfpWdTow6J/7C7cet4HyktvZYUS8E3KZzt2Q
	 0vPBBVm8mQeug==
Date: Mon, 5 Aug 2024 11:26:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, 
	Wojciech =?utf-8?Q?G=C5=82adysz?= <wojciech.gladysz@infogain.com>, viro@zeniv.linux.org.uk, jack@suse.cz, ebiederm@xmission.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/fs: last check for exec credentials on NOEXEC
 mount
Message-ID: <20240805-fehlbesetzung-nilpferd-1ed58783ad4d@brauner>
References: <20240801120745.13318-1-wojciech.gladysz@infogain.com>
 <20240801140739.GA4186762@perftesting>
 <mtnfw62q32omz5z4ptiivmzi472vd3zgt7bpwx6bmql5jaozgr@5whxmhm7lf3t>
 <20240802155859.GB6306@perftesting>
 <CAGudoHFOwOaDyLg3Nh=gPvhG6cO+NXf_xqCjqjz9OxP9DLP3kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFOwOaDyLg3Nh=gPvhG6cO+NXf_xqCjqjz9OxP9DLP3kw@mail.gmail.com>

On Sat, Aug 03, 2024 at 08:29:17AM GMT, Mateusz Guzik wrote:
> On Fri, Aug 2, 2024 at 5:59 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Thu, Aug 01, 2024 at 05:15:06PM +0200, Mateusz Guzik wrote:
> > > I'm not confident this is particularly valuable, but if it is, it
> > > probably should hide behind some debug flags.
> >
> > I'm still going to disagree here, putting it behind a debug flag means it'll
> > never get caught, and it obviously proved valuable because we're discussing this
> > particular case.
> >
> > Is it racy? Yup sure.  I think that your solution is the right way to fix it,
> > and then we can have a
> >
> > WARN_ON(!(file->f_mode & FMODE_NO_EXEC_CHECKED));
> >
> > or however we choose to flag the file, that way we are no longer racing with the
> > mount flags and only validating that a check that should have already occurred
> > has in fact occurred.  Thanks,
> >
> 
> To my understanding the submitter ran into the thing tripping over the
> racy check, so this check did not find a real bug elsewhere in this
> instance.

Mateusz is right. That check is mostly nonsensical. Nothing will protect
against mount properties being changed if the caller isn't claiming
write access to the mount. Which this code doesn't do (And can't do (or
anything like it) because it would cause spurious remount failures just
because someone execs something.).

So 0fd338b2d2cd ("exec: move path_noexec() check earlier") introduced
WARN_ON_ONCE(). I suspect that it simply wasn't clear that mount
properties can change while a is file held open if no write access was
claimed.

Stuff like noexec, nodev or whatever can change anytime if e.g., just
read access was requested. In other words, successful permission
checking during path lookup doesn't mean that permission checking
wouldn't fail if one redid the checks immediately after.

I think it probably never triggered because noexec -> exec remounts are
rarely done and the timing would have to be rather precise.

I think the immediate solution is to limit the scope of the
WARN_ON_ONCE() to the ->i_mode check.

diff --git a/fs/exec.c b/fs/exec.c
index a126e3d1cacb..12914e14132d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -145,13 +145,14 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
                goto out;

        /*
-        * may_open() has already checked for this, so it should be
-        * impossible to trip now. But we need to be extra cautious
-        * and check again at the very end too.
+        * Safety paranoia: Redo the check whether the mount isn't
+        * noexec so it's as close the the actual open() as possible.
+        * may_open() has already check this but the mount properties
+        * may have already changed since then.
         */
-       error = -EACCES;
-       if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-                        path_noexec(&file->f_path)))
+       err = -EACCES;
+       if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
+           path_noexec(&file->f_path))
                goto exit;

        error = -ENOEXEC;
@@ -974,13 +975,14 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
                goto out;

        /*
-        * may_open() has already checked for this, so it should be
-        * impossible to trip now. But we need to be extra cautious
-        * and check again at the very end too.
+        * Safety paranoia: Redo the check whether the mount isn't
+        * noexec so it's as close the the actual open() as possible.
+        * may_open() has already check this but the mount properties
+        * may have already changed since then.
         */
        err = -EACCES;
-       if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-                        path_noexec(&file->f_path)))
+       if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
+           path_noexec(&file->f_path))
                goto exit;

 out:

