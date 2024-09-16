Return-Path: <linux-fsdevel+bounces-29453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB6979F5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874161F24054
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266BC154C0D;
	Mon, 16 Sep 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y3CGWADL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WXteRppa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4E149C57;
	Mon, 16 Sep 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482767; cv=none; b=bLVNFPISSqdn2QXiLs8CQoSeKbHqx3ZyPGp9onTJgdHb1t0qJdJ+wbwcp3rAz4ntHbz8BzlRXdxOa2Hnfjx5tTDIhYC9vByDwnBdG5YF6l6JzZv2ZxxsXyf9JPwXeLFArn1z41jw+zjy6N3GekglboIapi/1/06tOC8sbwX3Aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482767; c=relaxed/simple;
	bh=Zpz37HkUvrAbwT+DO7KcNA1oH1DGcUUR3N3ma8234+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CbbWlfqqq3gL/oA0TIFisGZEt4iE6mCnSl/d2tn+CtTj14cHcD1PsiaNZ6dn9l5tJumtQRECFPtAdxoUSLb8uU3D3oNhCCFHnqiEkKVNk+izholKEl8+Xmd2AJnHdY/CR9KUHVbPrnRBLyaVtSqAogg6XMu1R/UxBle+w0YcOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y3CGWADL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WXteRppa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726482764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgTtLOOHYrCqvUwF7dfP7WkadfDMZDQpzcSpIj2VBFo=;
	b=y3CGWADLhxRdskU+nFNiS1vGNZ3BWsHvf1LllzZqUfQ1U4IJjSquxqiwWbVH3rtZKn5e1n
	v51XNqEfW1+cdqFzN4XRE3rWmWce4dI0q57b4Rkip7Wn1vODnJ+amPCNGf5ng0QRYpgJul
	0r/9S14Qohf8HlPNkYQWntaqKUgOwfoadwnKpXl5IS+ItPRScN2iNhIyFRHwwccQVCdPip
	O7UvNkFfXyLBYOumwd8J+Pn+WcwF77Qnk37zeAWif27Tvl8NUushqMxPrX53/3USpoAAGW
	cJUbmLwvIzUa6RTlH3Mp/TBsERyPhaH5Uh0cC4aDIRuFj5RtqU5lELKVAGChWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726482764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgTtLOOHYrCqvUwF7dfP7WkadfDMZDQpzcSpIj2VBFo=;
	b=WXteRppaW9d3WJvS9/9s5wPnliTnVEYb5H5kAFYm3vjgMmg8IRelC6h8tWHC1sHrRFdcsS
	kS28JHisBM727RDA==
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
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, Jeff Layton
 <jlayton@kernel.org>
Subject: Re: [PATCH v8 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
In-Reply-To: <87a5g79aag.ffs@tglx>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-1-5bd872330bed@kernel.org> <87a5g79aag.ffs@tglx>
Date: Mon, 16 Sep 2024 12:32:43 +0200
Message-ID: <874j6f99dg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 16 2024 at 12:12, Thomas Gleixner wrote:
> On Sat, Sep 14 2024 at 13:07, Jeff Layton wrote:
>> +	do {
>> +		seq = read_seqcount_begin(&tk_core.seq);
>> +
>> +		ts->tv_sec = tk->xtime_sec;
>> +		mono = tk->tkr_mono.base;
>> +		nsecs = timekeeping_get_ns(&tk->tkr_mono);
>> +		offset = *offsets[TK_OFFS_REAL];
>> +	} while (read_seqcount_retry(&tk_core.seq, seq));
>> +
>> +	mono = ktime_add_ns(mono, nsecs);
>> +
>> +	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
>> +		ts->tv_nsec = 0;
>> +		timespec64_add_ns(ts, nsecs);
>> +	} else {
>> +		/*
>> +		 * Something has changed mg_floor since "old" was
>> +		 * fetched. "old" has now been updated with the
>> +		 * current value of mg_floor, so use that to return
>> +		 * the current coarse floor value.
>
> 'Something has changed' is a truly understandable technical
> explanation.

     old = mg_floor
                                mono = T1;
                                mg_floor = mono
preemption

     do {
        mono = T2;
     }

     cmpxchg fails and the function returns a value based on T1

No?

Thanks,

        tglx

