Return-Path: <linux-fsdevel+bounces-40266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C50AA21559
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 01:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510AF3A4942
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 00:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0110E9;
	Wed, 29 Jan 2025 00:02:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A611372
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738108925; cv=none; b=SEnv8JoiaeCBi1Tng5cDvIDgSFiki4nY0gczDaMRi+DP2RFhMg7OKtUMiw0WcOLgUlwhav62cxzYJDdI2nqRYqN8mEAOyUnO7lcvMj4wQEgBvCaIuuYuPMGqK6rlT1633LE3HmzTZWmAaP43kPcYHxMylc9jADUZum0pwAU6ZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738108925; c=relaxed/simple;
	bh=pLtfacnpX4WEKqr+e019E6BAtObkXolKwix1okTN+bA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNi8lp+4zMQSUkWYaJ69koDYPtMUfEgWvyHkq8MYpnICrWwmuNeg9uDvHbl0ODmmGx8v3amxuxMC10KRXQowvPzpZqNYJZVKt41p/dGgOCJHtGFYEKRv3Z6RV2EQ5H24SmGdHAC0AYnrRjH+R5SV9FzmUCoBGx8SbtB32gaTDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB812C4CED3;
	Wed, 29 Jan 2025 00:02:03 +0000 (UTC)
Date: Tue, 28 Jan 2025 19:02:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig
 <hch@infradead.org>, David Reaver <me@davidreaver.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, Al
 Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, James
 Bottomley <James.Bottomley@hansenpartnership.com>, Krister Johansen
 <kjlx@templeofstupid.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to
 demonstrate kernfs usage
Message-ID: <20250128190224.635a9562@gandalf.local.home>
In-Reply-To: <Z5lqguLX-XeoktBa@slm.duckdns.org>
References: <20250121153646.37895-1-me@davidreaver.com>
	<Z5h0Xf-6s_7AH8tf@infradead.org>
	<20250128102744.1b94a789@gandalf.local.home>
	<CAHk-=wjEK-Ymmw8KYA_tENpDr_RstYxbXH=akjiUwxhkUzNx0Q@mail.gmail.com>
	<20250128174257.1e20c80f@gandalf.local.home>
	<Z5lfg4jjRJ2H0WTm@slm.duckdns.org>
	<20250128182957.55153dfc@gandalf.local.home>
	<Z5lqguLX-XeoktBa@slm.duckdns.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 13:38:42 -1000
Tejun Heo <tj@kernel.org> wrote:

> On Tue, Jan 28, 2025 at 06:29:57PM -0500, Steven Rostedt wrote:
> > What I did for eventfs, and what I believe kernfs does, is to create a
> > small descriptor to represent the control data and reference them like what
> > you would have on disk. That is, the control elements (like an trace event
> > descriptor) is really what is on "disk". When someone does an "ls" to the
> > pseudo file system, there needs to be a way for the VFS layer to query the
> > control structures like how a normal file system would query that data
> > stored on disk, and then let the VFS layer create the dentry and inodes
> > when referenced, and more importantly, free them when they are no longer
> > referenced and there's memory pressure.  
> 
> Yeap, that's exactly what kernfs does.

And eventfs goes one step further. Because there's a full directory layout
that's identical for every event, it has a single descriptor for directory
and not for file. As there can be over 10 files per directory/event I
didn't want to waste even that memory. This is why I couldn't use kernfs
for eventfs, as I was able to still save a couple of megabytes by not
having the files have any descriptor representing them (besides a single
array for all events).

-- Steve

