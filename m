Return-Path: <linux-fsdevel+bounces-26454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91695963D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 10:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B841C20621
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37D01A287F;
	Wed, 21 Aug 2024 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm5bTLt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4845919ABB6;
	Wed, 21 Aug 2024 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226082; cv=none; b=EBRh7FZECcQEVOv7kinS+HWvAMA+tbwlHqLe/gRXBT7BZOn7ZAPnXXggXz9bS/jtDGcV8b9cTxVa/lkSoYjUcuLr/C57Q/OL9HmoTS5I/41mj3d6tvj+h6132F5JjA2rO9ZPV7aZR4wZMhfIKkgkdHsSOyChqYrCOdLQOPYtzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226082; c=relaxed/simple;
	bh=K/ApD1F3tsKQY8042HX6Tpo2Vz6Dxwj8yUyTzC0eo3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/zoKapvwGW9qJys8tZ+TBi7zEQzcOAEuQHL0ee+AfokCxf3cPPbS11QHEMEkARjHnMeWABky6oe7evhDVGZv7arsCuv024c6u9Ipp+A4URryPhtkUHzBqQj8Rmdf81O7OwBaydoRWlA1YfESL1Dtmq9WR4icBB7puFHLv5pWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm5bTLt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E55BC4AF09;
	Wed, 21 Aug 2024 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724226082;
	bh=K/ApD1F3tsKQY8042HX6Tpo2Vz6Dxwj8yUyTzC0eo3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qm5bTLt3MnJ7HwVo7BPmfXpaDg0DCAXe29RcUxt0CYNrPCwm19vIF+TuKI8rs2nNT
	 BTrhDoUU3vLrz++kgc6i+Nr3TLc7UYUSp2MemGBjlNAHuPRcyVbrvZIQs5cPDWEG9+
	 wlA5ztINphokCAio/P2wbXvlYUOkPUHht36X+tnUYSpb+KSIsaPY8fPAbDnCMGW30f
	 TAtTH1tsBi+6v4QqVVOFAzJzhRdcE64wqmifUnJtTnqk3vgxRi6bP/i/JrjtysWK/j
	 yo4K9t3hBZcUiD9OtxsgaFqicjcqqN8OIP67oCuE+gD3okDIdwa0eV+79ZyKl4UNH2
	 T46XjVN9vcJWg==
Date: Wed, 21 Aug 2024 09:41:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Tycho Andersen <tandersen@netflix.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Tejun Heo <tj@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240821-weitverbreitet-ambulant-46d7bfbc111e@brauner>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240818035818.GA1929@sol.localdomain>
 <20240819-staudamm-rederei-cb7092f54e76@brauner>
 <20240820193414.GA1178@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240820193414.GA1178@sol.localdomain>

On Tue, Aug 20, 2024 at 12:34:14PM GMT, Eric Biggers wrote:
> On Mon, Aug 19, 2024 at 10:41:15AM +0200, Christian Brauner wrote:
> > On Sat, Aug 17, 2024 at 08:58:18PM GMT, Eric Biggers wrote:
> > > Hi Christian,
> > > 
> > > On Wed, Jul 31, 2024 at 12:01:12PM +0200, Christian Brauner wrote:
> > > > It's currently possible to create pidfds for kthreads but it is unclear
> > > > what that is supposed to mean. Until we have use-cases for it and we
> > > > figured out what behavior we want block the creation of pidfds for
> > > > kthreads.
> > > > 
> > > > Fixes: 32fcb426ec00 ("pid: add pidfd_open()")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > >  kernel/fork.c | 25 ++++++++++++++++++++++---
> > > >  1 file changed, 22 insertions(+), 3 deletions(-)
> > > 
> > > Unfortunately this commit broke systemd-shutdown's ability to kill processes,
> > > which makes some filesystems no longer get unmounted at shutdown.
> > > 
> > > It looks like systemd-shutdown relies on being able to create a pidfd for any
> > > process listed in /proc (even a kthread), and if it gets EINVAL it treats it a
> > > fatal error and stops looking for more processes...
> > 
> > Thanks for the report!
> > I talked to Daan De Meyer who made that change and he said that this
> > must a systemd version that hasn't gotten his fixes yet. In any case, if
> > this causes regression then I'll revert it right now. See the appended
> > revert.
> 
> Thanks for queueing up a revert.
> 
> This was on systemd 256.4 which was released less than a month ago.
> 
> I'm not sure what systemd fix you are talking about.  Looking at killall() in
> src/shared/killall.c on the latest "main" branch of systemd, it calls
> proc_dir_read_pidref() => pidref_set_pid() => pidfd_open(), and EINVAL gets
> passed back up to killall() and treated as a fatal error.  ignore_proc() skips
> kernel threads but is executed too late.  I didn't test it, so I could be wrong,
> but based on the code it does not appear to be fixed.

Yeah, I think you're right. What they fixed is
ead48ec35c86 ("cgroup-util: Don't try to open pidfd for kernel threads")
when reading pids from cgroup.procs. Daan is currently prepping a fix
for reading pids from /proc as well.

