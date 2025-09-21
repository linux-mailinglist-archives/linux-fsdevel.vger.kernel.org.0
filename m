Return-Path: <linux-fsdevel+bounces-62324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9EDB8D6C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB917968B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463562D29AC;
	Sun, 21 Sep 2025 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8xfNzYh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AS9a2xMg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9C3FB31;
	Sun, 21 Sep 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758440132; cv=none; b=AIQNkvTsaScYHVuwVLfQXBq/N2+u/djHgrHMdixIbPfMbHf6RuSJrVa6+gX2aEyl7XmzAX6E4grQPDLPfdd0yriWPBrbs6h/6aMHe5QWV5uEwC1bTgF0q5dzRG0jltIZ3gF0rJDS/dfCDplIMGCihaLRmGsvqEwQmToXnRgI3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758440132; c=relaxed/simple;
	bh=EmA9cyLn6JpB80qurGIMgtPXn3G6/Q7d0X60oqLWfyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ea80Lix5aZseoowY/bM5FICMpsMsrjxAUkAg+AYY8lozaZEEPz0gJfMysVs4jftSe5yoeR9nLfNX46ZipWpzOeZu5VkuZrNDu7/d+1UYlmZC2qdCXGQ9hTNjQZa+yX746JmxZdMPapRAjoED6y+VHc4Td/Dq5ceOr1E6wW68IIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8xfNzYh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AS9a2xMg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758440128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmA9cyLn6JpB80qurGIMgtPXn3G6/Q7d0X60oqLWfyE=;
	b=s8xfNzYh9AgO9lSPgbgFQ6ca+OEaYCiBIDdJf/EK9QvMohMPIiorMCsN4JE08KM8y6H779
	Ti66eXS1ItZU0zG1uwrCZkLSnPQwCwQDpHWLe6zd48LqgFbw1b/q6R5+xnG+Q0fkwTo+Yo
	Wxp1K4RZyB1irx5cKu9KTv8gyZArpW6NE0acWcmn001IexSls563KmI/GRTkAmf4parvZP
	gKUNNJnfgLvfVvNKwBGboe7oji330sQA9PpWXkyIRh86AmCN/ddUgBsjMumsD2m2hOHWvh
	ZCBpCVM2pHooqeQ7o3MQUAen+nuxzhQz6ad1tE1yPPGTwvx3ac9QtaT0ZuXKnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758440128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmA9cyLn6JpB80qurGIMgtPXn3G6/Q7d0X60oqLWfyE=;
	b=AS9a2xMgqLDVQd3A3D00GnEOeyHRoQrVATav/kQ0dwvDjZMq1s1O84ZaoWt/ml602RKgjn
	sz240l5hlgsd5dCA==
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir
 Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Yuan <me@yhndnzj.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, Daan De
 Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Eric Dumazet
 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH 25/32] ns: add to_<type>_ns() to respective headers
In-Reply-To: <20250910-work-namespace-v1-25-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-25-4dd56e7359d8@kernel.org>
Date: Sun, 21 Sep 2025 09:35:27 +0200
Message-ID: <87zfao6yww.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025 at 16:37, Christian Brauner wrote:

> Every namespace type has a container_of(ns, <ns_type>, ns) static inline
> function that is currently not exposed in the header. So we have a bunch
> of places that open-code it via container_of(). Move it to the headers
> so we can use it directly.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

