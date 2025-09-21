Return-Path: <linux-fsdevel+bounces-62327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486BEB8D6EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8823B5CFF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10431E8836;
	Sun, 21 Sep 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PV3S5ZuS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MyVBhSm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E837298CD5;
	Sun, 21 Sep 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758440225; cv=none; b=FgMZvC/j2d2+mEk7crTujo5xd5qaKNqi59kDuxsWqKAKOqvQl+bOdKY9KnUAKN2abU3tPL9zu4C7/1otqH5y6BSEqZNyOUNXBADviHg37td7uOeZeFniADJj2I8nYmoi1uR720ooRpsL9Nopn2xGy4xoAWOmKH3qgy3gaQXO8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758440225; c=relaxed/simple;
	bh=nTPwC0UCtkHunyz/OwgKvq3kDa4asBMoFtB2IoRqrMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l/phvHIEmNheIso0EaooU/sOgeRxuPsFNJ1RIl6xtkjic6yeTZRqp3vXs5hT9m+jzq2GuU2MncLtRNjHbRr3EoZueKNbQbF8Xj4nS+0tGGJzigtLMjZz/WCCEQeHX+c4dng2rEifxKUGagtN4SYaxc5491Lq2aJH79XuDL8rIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PV3S5ZuS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MyVBhSm4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758440221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTPwC0UCtkHunyz/OwgKvq3kDa4asBMoFtB2IoRqrMs=;
	b=PV3S5ZuSBygF/PmaoS6i6IEHzu4m+gGRar4xe7H9ucx8w0FxzfhSEepPBoNfGI6NDo4ejY
	xIXqb9mW0zGoXCG0wlpxF2zM9RLrMlQtiEoUcWYvu7uxhN+209XwEuRa59VcJ5gHYzOoio
	mUDLidz5FyvsPhzZrgrHBROBLIjbnV+apGFoHQ5D+YNxmWycuxxPUEIUORrmJaJdT5KHis
	AC1629bQPV95xWE02E0dCQtw4Sgb6KVFTHgKLAoXGTTGt9/LWWK+AwNe7Mg+9ND83nbIAI
	zfHZsSi1eP7rhXQgdvNJuDhr6FpojpkohOOoGMYdnFEGezm7mVhyp7pUhhUaFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758440221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTPwC0UCtkHunyz/OwgKvq3kDa4asBMoFtB2IoRqrMs=;
	b=MyVBhSm4wKgBBz3BgGaEmYTBnX+cqdkxZDkjlMITYsObFDwHQoznOZ57we4V1IzDXnPg/G
	vfkYbvf72oUQKNCg==
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering
 <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa
 Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Jakub Kicinski
 <kuba@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH 14/14] ns: rename to __ns_ref
In-Reply-To: <20250918-work-namespace-ns_ref-v1-14-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
 <20250918-work-namespace-ns_ref-v1-14-1b0a98ee041e@kernel.org>
Date: Sun, 21 Sep 2025 09:37:00 +0200
Message-ID: <87tt0w6yub.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 18 2025 at 12:11, Christian Brauner wrote:

> Make it easier to grep and rename to ns_count.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

