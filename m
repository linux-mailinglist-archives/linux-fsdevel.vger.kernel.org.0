Return-Path: <linux-fsdevel+bounces-68564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22070C60811
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 16:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBEC3AE6B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5CD29D266;
	Sat, 15 Nov 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bSRDkmmk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q9EioKQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8823222586;
	Sat, 15 Nov 2025 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763221928; cv=none; b=m3davOqYT9ttI4w9ijsv8u9LzUC9ch9uwJsPghqGZFdcvCsDnnbMyy0vSAnsqhTixDQvdY20DxLyWCNjlwXCNcgWj9BxQ0YdeiKa32+DmiPim+bjKBccZWUDoE4/Hizy0BtTkenI32b2NzTEn+D7NgEnsZHdCg+NWlv2gbpsBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763221928; c=relaxed/simple;
	bh=Qji/R0XqJN/+axAWSVhTCyVa2zmi8tBsBdc+EwMtP6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L6PvEWkJVW00yiyifGGoJtqMMeA02775Uz2yr71JUea2Aantnga5s3SIFt3ZVXRtx/u9DHYDRQ6oSiOdJ8GyPuLZh/X9yNrcV7yk53D04IVznlLRQpM2v3d4uwiMON4Z1V10ld+M4x7JAIykgs5j7OVttSI5JwZFBIXe8G64YWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bSRDkmmk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q9EioKQO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763221920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HSPnZMDPrSmy6ZnP5yUFLoTkZttJ+ulSH2tuXAA3xPU=;
	b=bSRDkmmkFM+3H86HARt9T+Nmon/tHmmTmfBcVZ4meeRSD/6sMoF05cS6o02IaEF/X5+AEp
	hGCyUIWGfdlI4ROZmuOkcp6c7VwUy1/HYtgAeUur21/RD6NrfG2g0tOyKkY5OR3ghE4Bdy
	OirG2HWhgC9w1EtGdh5jSgAE4WIwhxnYOTwp5Wp1uknEDQ5rbTlo7cvZP0n6HojpnCqu6x
	lonK55GQltRVV07NyHSFktsseUp4Z2NUBUcwMuX2XeP/hY0n+HDSIkuASxqHOB7Ll/+859
	xqV7wA1p/qgQo31iITdEy1A0lWOY32oK3oOUYgmokDoqg5BNgkF5nfXIq+64mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763221920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HSPnZMDPrSmy6ZnP5yUFLoTkZttJ+ulSH2tuXAA3xPU=;
	b=q9EioKQOs2kPRGrhP2HBDkWUx314/kUIkP+PNQvawiMxyrLHb6u/YSqyHWKp7a/d4AxH90
	QE0X4Os16XT0NFCA==
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen
 <dave.hansen@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 02/10] uaccess: Add speculation barrier to
 copy_from_user_iter()
In-Reply-To: <598e9ec31716ce351f1456c81eee140477d4ecc4.1762427933.git.christophe.leroy@csgroup.eu>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
 <598e9ec31716ce351f1456c81eee140477d4ecc4.1762427933.git.christophe.leroy@csgroup.eu>
Date: Sat, 15 Nov 2025 16:51:59 +0100
Message-ID: <87jyzr9tuo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 06 2025 at 12:31, Christophe Leroy wrote:
> The results of "access_ok()" can be mis-speculated.  The result is that
> you can end speculatively:
>
> 	if (access_ok(from, size))
> 		// Right here

This is actually the wrong patch ordering as the barrier is missing in
the current code. So please add the missing barrier first.

As a bonus the subject of the first patch makes actually sense
then. Right now it does not because there is nothing to avoid :)

Also please use the same prefix for these two patches which touch the
iter code.

> For the same reason as done in copy_from_user() by
> commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
> copy_from_user()"), add a speculation barrier to copy_from_user_iter().
>
> See commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
> copy_from_user()") for more details.

No need to repeat that. Anyone with more than two braincells can look at
that commit, which you mentioned already two lines above already.

Thanks,

        tglx

