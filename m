Return-Path: <linux-fsdevel+bounces-30419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DAD98AE12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 22:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DE21C22C90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE761A2851;
	Mon, 30 Sep 2024 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MhW83lyu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zclkxnGp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653219922D;
	Mon, 30 Sep 2024 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727343; cv=none; b=Iz1+YKrqd6ql+c3FV0Dzagnt8vVEij0aqaSj2qV8RTB0rAPSR/1y8dZhdg1StGC1BoEy/vRZmR83K/gCT1FlBL96etrGV4s/llbAtbbLPZNXTE3WxHcyFE2iT2xmKhl8y+tRnEiPm9L9f2HvBJYblkwQLR6KUGdQya53IC5UkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727343; c=relaxed/simple;
	bh=M7S+gdWXGa3PLSbsG6OdZUVcDn/PBbUxrZ5/qJ+DMEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NY7iQAHq98kFPkhqlwUTFbNAHTVf72f4NUece3+jNdthpW3U6KFLTX4pKK3hV+95KTupqV0lXkncBgLvqCYd9GeqPto996Ix/SXQ5RkgWgxKI3+1vojuOZhznbF94J3+PowL3ONyfLJEqfu8wOIWxB+dNctYc/4QJoLBFThqo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MhW83lyu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zclkxnGp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727727339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7S+gdWXGa3PLSbsG6OdZUVcDn/PBbUxrZ5/qJ+DMEw=;
	b=MhW83lyupKjcTRSYb6BhSWLgQ/nBViA9+6PePLs6Nipl86pAHMy0p2nNURvKDdJKSPRXRM
	LNK9srxo+rdQAL/q9aBHffjqipLUd9iXVfrEM2nGga6xk1EKNmG6d2Ta1ITkfukUGHRbr4
	FzOtufN+1jlLEL1MJQuEPd9z2bMQhxzlX8wJBlOl+Z3Dv2r3lPF6SWRZTti7ZEZjF6F8fp
	TEMOlkLQBmBNStXDlGNw812QgoaUuraqXPR8NaAEFkv4wt3hzPtLM5oV4gql/IgfLg5LWl
	4KS1klvVzBw662UCQ3TiL7K6fwd9rBTE5tn3xajscpCmUc4eM1Wk68CYAA+Ddg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727727339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7S+gdWXGa3PLSbsG6OdZUVcDn/PBbUxrZ5/qJ+DMEw=;
	b=zclkxnGp1atI4LKz/391HDmc/xuV+6cnt/bWku76i0l7uDYj3Gzik7Lmq5q0tWoZKY4jE1
	duHSRiKZaAD49xDg==
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
In-Reply-To: <753938ef8e46e9f3d9ea7d977537cd8f5a6533b2.camel@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-1-5bd872330bed@kernel.org> <87bk050xb9.ffs@tglx>
 <753938ef8e46e9f3d9ea7d977537cd8f5a6533b2.camel@kernel.org>
Date: Mon, 30 Sep 2024 22:15:39 +0200
Message-ID: <871q102904.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 30 2024 at 15:27, Jeff Layton wrote:
> On Mon, 2024-09-30 at 21:13 +0200, Thomas Gleixner wrote:
>> So if that's the intended behaviour then the changelog is misleading at
>> best.
>
> That is the intended behavior and I'll plan to fix the changelog to
> clarify this point:
>
> If someone jumps the realtime clock backward by a large value, then the
> realtime timestamp _can_ appear to go backward. This is a problem today
> even without this patchset.

Correct.

> If two files get stamped and a realtime clock jump backward happens in
> between them, all bets are off as to which one will appear to have been
> modified first. I don't think that is something we can reasonably
> prevent, since we must stamp files according to the realtime clock.

True. I just was utterly confused about the changelog.

> The main thing I'm trying to prevent is the timestamps being misordered
> in the absence of such a clock jump. Without tracking the floor as I am
> here, that's a possibility.

Correct.

