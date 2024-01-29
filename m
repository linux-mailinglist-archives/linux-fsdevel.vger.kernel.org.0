Return-Path: <linux-fsdevel+bounces-9280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D0983FBD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 02:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90323B20F8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 01:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB92DDD4;
	Mon, 29 Jan 2024 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gWZNODXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AABF9E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492055; cv=none; b=hWGeGZqhJzhQyc2tsexOlMEH6ts/HODIAV21JRzbc8m1iMSteKes5uFclsh0BCk4I5A/B0cte3xQOKRougsHhx/DJSP3giG4zuq6emUAhd570EPSti7LVoh+9AR7aB5gUKeJxq4owqIW5DlaTm5Mt+ZgHuakfCVg7UPb2rq+QvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492055; c=relaxed/simple;
	bh=Sn3+afSObecsLwVspCGlRr2u/eqvfC8YAyQ9sYvfkw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/abfyGIkRAdI3z5gbt2sfVXzIlP0azLEZ2n9dsdsQZd/USGP2+YuCoQTnz1spHtxxwhAvCAC1tjdy2GHFaPaWa96+ymLHuUJn8f85E1lhYBMp/pYNjw2pIj0A0mTmHQyfVs0FwrGRLRakASn4zvHItlVSJAIW7TW+8OJmE8k2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gWZNODXq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 28 Jan 2024 20:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706492051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qN1FxCPOJ5H4DfTAIjDzCCL68C4YSsHpS9Bz1bmn1k0=;
	b=gWZNODXqBwsyFdMkaap/3eI4ToaTkSkd2jmZCRqH68A4L/qscT0n11KdUHXc5vOwx69PoY
	zs+xKjY9vH52zOsb/4b+ZYKwL+JSWIDxGKNoASizHgo/AC7LnisSe6CHKVNBtCIyRE3JsO
	Gs/1pjjvKfQqQkF20NpSI01rtZ6LL4I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: boqun.feng@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 4/4] af_unix: convert to lock_cmp_fn
Message-ID: <x7ido6w436gbs5ibdunezldhi6hisjck6rtxtag5g7lo6zt2o2@752ok7ean62y>
References: <suyvonwf55vfeumeujeats2mtozs2q4wcx6ijz4hqfd54mibjj@6dt26flhrfdh>
 <20240128205632.93670-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128205632.93670-1-kuniyu@amazon.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jan 28, 2024 at 12:56:32PM -0800, Kuniyuki Iwashima wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Date: Sun, 28 Jan 2024 14:38:02 -0500
> > On Sun, Jan 28, 2024 at 12:28:38AM -0800, Kuniyuki Iwashima wrote:
> > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > Date: Fri, 26 Jan 2024 21:08:31 -0500
> > > > Kill
> > > >  - unix_state_lock_nested
> > > >  - _nested usage for net->unx.table.locks[].
> > > > 
> > > > replace both with lock_set_cmp_fn_ptr_order(&u->lock).
> > > > 
> > > > The lock ordering in sk_diag_dump_icons() looks suspicious; this may
> > > > turn up a real issue.
> > > 
> > > Yes, you cannot use lock_cmp_fn() for unix_state_lock_nested().
> > > 
> > > The lock order in sk_diag_dump_icons() is
> > > 
> > >   listening socket -> child socket in the listener's queue
> > > 
> > > , and the inverse order never happens.  ptr comparison does not make
> > > sense in this case, and lockdep will complain about false positive.
> > 
> > Is that a real lock ordering? Is this parent -> child relationship well
> > defined?
> > 
> > If it is, we should be able to write a lock_cmp_fn for it, as long as
> > it's not some handwavy "this will never happen but _nested won't check
> > for it" like I saw elsewhere in the net code... :)
> 
> The problem would be there's no handy way to detect the relationship
> except for iterating the queue again.
> 
> ---8<---
> static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
> 				  const struct lockdep_map *_b)
> {
> 	const struct unix_sock *a = container_of(_a, struct unix_sock, lock.dep_map);
> 	const struct unix_sock *b = container_of(_b, struct unix_sock, lock.dep_map);
> 
> 	if (a->sk.sk_state == TCP_LISTEN && b->sk.sk_state == TCP_ESTABLISHED) {
> 		/* check if b is a's cihld */
> 	}
> 
> 	/* otherwise, ptr comparison here. */
> }
> ---8<---
> 
> 
> This can be resolved by a patch like this, which is in my local tree
> for another series.
> 
> So, after posting the series, I can revisit this and write lock_cmp_fn
> for u->lock.

Sounds good! Please CC me when you do.

