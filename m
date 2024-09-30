Return-Path: <linux-fsdevel+bounces-30407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F8698ACA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 21:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6351F21C59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0161C199EB2;
	Mon, 30 Sep 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k15weHyo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LzSX6w1K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7015E97;
	Mon, 30 Sep 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723772; cv=none; b=GtMMYZBvEC1SgCXR1ptCoqaqutmuoIOD/LJy9MzzGtK5SMs29GKjVMLGGX0Mx6dMaNNIK/mEs8znq69wUywuY2y2IhzGxnMSESjOWSUuPsrbv9YywrYjk9ZzJIq8easu/uImBJqir8eyKGioSUtz0YauFLGp9dlYs6/i9PnPM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723772; c=relaxed/simple;
	bh=mbPkm7okFjtQ2jT5AxFJj8n1vkGBMmVePJJNRPRtVno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SYB5Jb+ILjv9fLDB5aWBsRhvMIxD09DgHSY3khBtoldZTIZ6zAwmId3E155hy2yaN+iceizbUz3QuVoKEu1qgDDQznDVGTg/DbWzQG5snbcwqKs8TRbfkNDTOjjn1WVG31LPK0m0+HnEqseBQp3hTQDta/g1PlaWf8H1EbTojRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k15weHyo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LzSX6w1K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727723768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iCvcoZK/1u84ANwEMkWcEIyXDRG96pAVEQ+ONN9fVq4=;
	b=k15weHyo206AD3mAwvey/aNEbq7AsI86ZKn2w2uPvLQHKUfl8PURomKwotvHQfopogWV78
	4/u/SUbDveNrg/WjTDPr2Wdd1MiAggTT9wKElFbifsDpJP2tV3R7ae+EKq4Q6/QzlqeNxn
	WZqPyEX1GyKTSWT3ZiaDR+Utg16zM0UCH2/hOEwUOdq8LR2/Z0iYzDB86sKictH7HFnNfP
	hHoMMn1gQculKdiwekmOWTHzLxzji3XFQRAOSbjC6FhSOS3CI7LV1EhvTP5hp0AZ6dyKV4
	+Bkuk94NckRLi+lb/354Mx6/uxWCTq6ZMh1JcutjbVnDauYAmc63ARXa793j4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727723768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iCvcoZK/1u84ANwEMkWcEIyXDRG96pAVEQ+ONN9fVq4=;
	b=LzSX6w1KCMyStlPEYZz2PdVadv24ltBggYWSH7NJOFSXKkHbhvWBDpTDR7J0PNWEX23gko
	9a03sH2Ia9XjYBBQ==
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
In-Reply-To: <b300fec8b6f611662195e0339f290d473a41607c.camel@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-1-5bd872330bed@kernel.org> <87a5g79aag.ffs@tglx>
 <874j6f99dg.ffs@tglx>
 <b300fec8b6f611662195e0339f290d473a41607c.camel@kernel.org>
Date: Mon, 30 Sep 2024 21:16:07 +0200
Message-ID: <878qv90x6w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 16 2024 at 06:57, Jeff Layton wrote:
> On Mon, 2024-09-16 at 12:32 +0200, Thomas Gleixner wrote:
>> > 'Something has changed' is a truly understandable technical
>> > explanation.
>> 
>>      old = mg_floor
>>                                 mono = T1;
>>                                 mg_floor = mono
>> preemption
>> 
>>      do {
>>         mono = T2;
>>      }
>> 
>>      cmpxchg fails and the function returns a value based on T1
>> 
>> No?
>> 
>> 
>
> Packing for LPC, so I can't respond to all of these just now, but I
> will later. You're correct, but either outcome is OK.
>
> The requirement is that we don't hand out any values that were below
> the floor at the time that the task entered the kernel. Since the time
> changed while the task was already inside the kernel, either T1 or T2
> would be valid timestamps.

That really needs to be documented. A similar scenario exists
vs. ktime_get_coarse_real_ts64_mg().

Thanks,

        tglx

