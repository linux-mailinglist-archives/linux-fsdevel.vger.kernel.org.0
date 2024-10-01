Return-Path: <linux-fsdevel+bounces-30495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5590398BC87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C6BB24569
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501CF1C32E7;
	Tue,  1 Oct 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qa86wiHY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J5x8Q9UD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F0188A01;
	Tue,  1 Oct 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786721; cv=none; b=R+XuNA1f94QrDT391vex4Uo4Y7enu3SNOsOGRjflMsZhwGZysIXtMMtEDvEsDXWC0Q/guxbPnt+jfRm8mNkOInMIK1PZT3GPtV3AenfEe7p+ubSh6WviYRoOEnxVtTUUEVSefZDrzUfJ2Z2ffGUDVZOAnHgy7MSRFBMCJObA9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786721; c=relaxed/simple;
	bh=yv21nIoxt2G1+TKHhwI6It6b6JK37ExoWIj1knINT+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WYFhtiDYIwSgqFfGwxCnIqNc7nzgRn3a0E3bRtrRDFyctWu7V5AGDGx1e+iJrHMdqUZmQE9Bfa8WKP2M/Z66Q+bglvgHeGdw0gaSyLUlqvVJ7ibwoNSLvnAxMnCFdwjXyXHHGQ7zUTUpM4qHp2WKVqO7gfhKJxygFV/nUdwkeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qa86wiHY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J5x8Q9UD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727786717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wloN27YoSxiWKp6fQGqBt4c8axyymw0Hk/QN5VGPdHc=;
	b=Qa86wiHY5udGbTL/4RbGP4MQElJwzeGrubSygjC1tQRy4zfMQXolM4/rdSgHW4aJ4pa7Sx
	Q+O/4+vGx/sNJTbKYXMz5OLOImXaYf16vuEWJGfu9jGd7Pe8Oe4wko1CKa3r1Wmo/BxmpV
	KBm+5T4xozujbGHa6wPPK8WpyQM15uWJnEuiRgimTY2zeOcCwWdlezQwO0yXiEQRFdxwXO
	F81jdaerQPF+4+x4zENY5l572B4SqKZGduMGTwWUtFj5dqgYuIRy2piVLxTiUZMzRYeEAt
	Ilm2DMAemuc8XGtm4muAJ2r/8epa7DzGpWnwN3YdoRfheVaCCRI+1tin3061Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727786717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wloN27YoSxiWKp6fQGqBt4c8axyymw0Hk/QN5VGPdHc=;
	b=J5x8Q9UDN+URvo6b7cPp4+Jh2nNorxNY4jIijs4dArCgLFGPkpanNKVIjGpOrcWyCk6yoJ
	fNP1c9ZTZ+79dgBA==
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Chuck Lever
 <chuck.lever@oracle.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
In-Reply-To: <4aa41dcb6f4be736355506dd500c4d255e008764.camel@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-1-5bd872330bed@kernel.org> <87a5g79aag.ffs@tglx>
 <874j6f99dg.ffs@tglx>
 <b300fec8b6f611662195e0339f290d473a41607c.camel@kernel.org>
 <878qv90x6w.ffs@tglx>
 <4933075b1023f466edb516e86608e0938de28c1d.camel@kernel.org>
 <87y138zyfu.ffs@tglx>
 <79a32ab9308d6e63e066aa17c5c2492b51b55850.camel@kernel.org>
 <87plokzuy6.ffs@tglx>
 <4aa41dcb6f4be736355506dd500c4d255e008764.camel@kernel.org>
Date: Tue, 01 Oct 2024 14:45:17 +0200
Message-ID: <8734lgyote.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 01 2024 at 05:45, Jeff Layton wrote:
> On Mon, 2024-09-30 at 23:35 +0200, Thomas Gleixner wrote:
>> > I certainly wouldn't rule out a workqueue job calling that function,
>> > but this is something we do while dirtying an inode, and that's not
>> > typically done in interrupt context.
>> 
>> The reason I'm asking is that if it's always syscall context,
>> i.e. write() or io_uring()/RPC request etc., then you can avoid the
>> whole global floor value dance and make it strictly per thread, which
>> simplifies the exercise significantly.
>> 
>
> I'm not sure I follow what you're proposing here.
>
> Consider two threads doing writes serially to different files. IOW, the
> second thread enters the write() syscall after the first thread returns
> from its write(). In that situation, the second timestamp mustn't
> appear to be earlier than the first (assuming no backward clock jump,
> of course).
>
> How would we ensure that with only per-thread structures?

Bah. Right. Ignore my sleep deprived rambling.

