Return-Path: <linux-fsdevel+bounces-30424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BBC98AF39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 23:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56251F23275
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 21:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECBE185B54;
	Mon, 30 Sep 2024 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YgR2fuSG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OLBn3xaq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C9EDE;
	Mon, 30 Sep 2024 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732117; cv=none; b=naEh++21QmxFDDKo6Dfl0rDBnD3dCjZpaXQgR83FzX6sgU47Fz1pbAkTx3Dmkao9Y2lwFqS04ThIKwpv1B68+WmTcQy29LMYdyodBmfXys3sXzOS+YA3TItpqIBbZedCqYJhhTfpfAtwi75Uym5z99vO8BNFNfGtE3xB3GCVPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732117; c=relaxed/simple;
	bh=dxuL2+8ZVHuUyZGDZyBs/XcF0TJ+A4SDCBg5GNm49/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QoGacCURkZJ84TA7yV+AECPhkWqYMUcLtIoI8OjAlrnRLO8G2LgMQuDTiQ7jvBmSdyfF5pwSL4nIoEp0mjHLNeo5a2j2c4kNl+gxcpWsCg27c5ZqaxzjdgOUALM0kRN9/7KBNW+zADvEmZItFf8GZ7QEqNKtDI7Z25ExrKPnyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YgR2fuSG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OLBn3xaq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727732113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVbdFg6I8fwu/3AqZyEvbGS1WvCMLB3EhLlpsNhR5nI=;
	b=YgR2fuSGQ+1CC0G5H4MzE4t8olbAFU5BafUyaLxjF2QIjTs3UbzCwwk7QvMFHeeLW8vuY5
	HIuz05kBaI+PAU5kDbE9O5ysw0ZigkKVd+8BT9ZePG9tf2kJcuF4pv35EhkZ99cPbhVZbC
	GQ7Jjbx9vgE0Rcx85zIefGMO0cL2dvmr4gN0aD9m2NtQeKfb7b8TsCdFADjl1RJyD/x6T5
	2c0wF9l6tXZjPe+9VRbHHcVyeREQUnQ1EWRZc+6eA8hsmw0RLjF4PEs0g0/Gf5TgScX/Mf
	xmwiJC8MCArfDFIIe+35ZCXxip+JZBfa+y8nD1s/uIVBn02yxnXIdg3SaXmy3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727732113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVbdFg6I8fwu/3AqZyEvbGS1WvCMLB3EhLlpsNhR5nI=;
	b=OLBn3xaqldkwQyCXLWWfC5gXBWhLeCEwb2syNUFGVZ4mPsvyd455m2aCZBRPk2SHmQTkzb
	bQfsnyFmm/fDZ2Dg==
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
In-Reply-To: <79a32ab9308d6e63e066aa17c5c2492b51b55850.camel@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-1-5bd872330bed@kernel.org> <87a5g79aag.ffs@tglx>
 <874j6f99dg.ffs@tglx>
 <b300fec8b6f611662195e0339f290d473a41607c.camel@kernel.org>
 <878qv90x6w.ffs@tglx>
 <4933075b1023f466edb516e86608e0938de28c1d.camel@kernel.org>
 <87y138zyfu.ffs@tglx>
 <79a32ab9308d6e63e066aa17c5c2492b51b55850.camel@kernel.org>
Date: Mon, 30 Sep 2024 23:35:13 +0200
Message-ID: <87plokzuy6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 30 2024 at 16:53, Jeff Layton wrote:
> On Mon, 2024-09-30 at 22:19 +0200, Thomas Gleixner wrote:
>> On Mon, Sep 30 2024 at 15:37, Jeff Layton wrote:
>> > If however, two threads have racing syscalls that overlap in time, then there                       
>> > is no such guarantee, and the second file may appear to have been modified                          
>> > before, after or at the same time as the first, regardless of which one was                         
>> > submitted first.
>> 
>> That makes me ask a question. Are the timestamps always taken in thread
>> (syscall) context or can they be taken in other contexts (worker,
>> [soft]interrupt, etc.) too?
>> 
>
> That's a good question.
>
> The main place we do this is inode_set_ctime_current(). That is mostly
> called in the context of a syscall or similar sort of operation
> (io_uring, nfsd RPC request, etc.).
>
> I certainly wouldn't rule out a workqueue job calling that function,
> but this is something we do while dirtying an inode, and that's not
> typically done in interrupt context.

The reason I'm asking is that if it's always syscall context,
i.e. write() or io_uring()/RPC request etc., then you can avoid the
whole global floor value dance and make it strictly per thread, which
simplifies the exercise significantly.

But even if it's not syscall/thread context then the worker or io_uring
state machine might just require to serialize against itself and not
coordinate with something else. But what do I know.

Thanks,

        tglx

