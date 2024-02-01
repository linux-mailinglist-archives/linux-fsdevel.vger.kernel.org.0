Return-Path: <linux-fsdevel+bounces-9793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC950844F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4D81C225F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FC53A1B4;
	Thu,  1 Feb 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="amh3vtnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FF3A8C5;
	Thu,  1 Feb 2024 03:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756535; cv=none; b=UEeuW7nhYi0QJbAsNWTDVEPPiSK6+6jb+Wyjc8aoXLIYFXMFL0wbiafyiMJYxW5gQsTHLTJBdr3aqOd+KW/obTawTTjsivzB8jBsbPb4r6SFo4+ZSelRhcFmJMMRJcQlQDWoAe6N2tZbEWGs/++j5U8NBMbDJuEImB78RWiRlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756535; c=relaxed/simple;
	bh=R+QsqpdTX1sY9S+UwIGf0BPhr4noXICmiQinzkSiegE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8RTTVRTR4sYEY98s8vFRlx0l8s14fCNiAiJ6BummRLMOxmRwWhOgZ354XzwsmRkVh+bSyaN1TXrK4WtpuHi3xFqrKwRectBo/PDsSmUlHwgsjmUCxeBoRx6hTpJtUTCHZUUY9D49n3mD8tFxliuB7yCFAyRL44OEhSnYZ61hao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=amh3vtnC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nMcVHbq/MOi0e8w8BPhjM3V1acBbj0Azdv/NIoV0FxY=; b=amh3vtnCwTf6LtO9i4uFr/ipV7
	kGvaers485QV7vDl4MLKa+a/t0Juu4UDIAhkYMIXxw0slTsDAYHkuyNivNrSY+1/Y+wGHZYwSHS+3
	CXTADfo6pTqNe9/Fe4N0TqFWunq9sSlcIUcfJiLn4XGK9daDqlz8oD1Yybwi8U4HuzraGCV3fxsTB
	QI1ZBB9P65NiIBMUBifUmV3HT6kat644IaZUNguJSk22mpISizaCXt/bThRXZmiI6qymsbLBCq3b+
	ZM9sKzOsAhYMpWQBqxf61p7SzZh5rVSarfn6fIB+xqecuSCGluGaptXaxC4KSJKVRxeGZzypRULKF
	6wwGJSVw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVNL3-002jgw-1z;
	Thu, 01 Feb 2024 03:02:05 +0000
Date: Thu, 1 Feb 2024 03:02:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christian Brauner <brauner@kernel.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/7] tracefs: dentry lookup crapectomy
Message-ID: <20240201030205.GT2087318@ZenIV>
References: <20240131184918.945345370@goodmis.org>
 <20240131185512.799813912@goodmis.org>
 <20240201002719.GS2087318@ZenIV>
 <20240131212642.2e384250@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131212642.2e384250@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 31, 2024 at 09:26:42PM -0500, Steven Rostedt wrote:

> > Huh?  Just return NULL and be done with that - you'll get an
> > unhashed negative dentry and let the caller turn that into
> > -ENOENT...
> 
> We had a problem here with just returning NULL. It leaves the negative
> dentry around and doesn't get refreshed.

Why would that dentry stick around?  And how would anyone find
it, anyway, when it's not hashed?

> I did this:
> 
>  # cd /sys/kernel/tracing
>  # ls events/kprobes/sched/
> ls: cannot access 'events/kprobes/sched/': No such file or directory
>  # echo 'p:sched schedule' >> kprobe_events
>  # ls events/kprobes/sched/
> ls: cannot access 'events/kprobes/sched/': No such file or directory
> 
> When it should have been:
> 
>  # ls events/kprobes/sched/
> enable  filter  format  hist  hist_debug  id  inject  trigger
> 
> Leaving the negative dentry there will have it fail when the directory
> exists the next time.

Then you have something very deeply fucked up.  NULL or ERR_PTR(-ENOENT)
from ->lookup() in the last component of open() would do exactly the
same thing: dput() whatever had been passed to ->lookup() and fail
open(2) with -ENOENT.

