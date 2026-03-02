Return-Path: <linux-fsdevel+bounces-78936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGbAKcW1pWkiFQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 17:07:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020F1DC62A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 17:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34238301AE48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B5D401488;
	Mon,  2 Mar 2026 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMLp9T97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA0239E7E;
	Mon,  2 Mar 2026 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467646; cv=none; b=reeuRA+VSJhonI8Q5VyBiWxP80uEhu2YAMIMkQVlwSFU+3cmYLKsgsVCcZpeD5+QbsVB0IdAmz/yZ6spwRutGyTK/LTVhkI9bpBbA9gyyA6tdD/m9PtinzZmR7EBb6gpveH1tEJ9MOpZnUdvxvvzTvS/WERX2WIXWWe+nhokA+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467646; c=relaxed/simple;
	bh=Q4f5IphZs1HK0nenixYFPe8rEaCz8xjgoIeWN6zDZUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N35w4jyFQLjxT7lavDk9XeqLyKxpDR3kwoofeqW3ueyak3QjcbOyqMEbq4/9d4/6am4QLhtKWNX7d6CEDLAtN8fJzKCAZdAe5ymK+Ox/GTZQYRnOgxj9WJT/duErdjNZ0pFn48kLk1iHrY4KRwhcvyA0WX5fam0D6b7xFfOOGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMLp9T97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AD7C19423;
	Mon,  2 Mar 2026 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772467645;
	bh=Q4f5IphZs1HK0nenixYFPe8rEaCz8xjgoIeWN6zDZUo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=IMLp9T97Z1WGqMa4vKl8aLMG1SCE+RTETM4LF9HiMKYx4UrsyfNc9AmTDAGMeQxpx
	 atWX3a+51jxWTnQfRmsvdiTbUN5rkz4n69cFBN9Vaugs7LwCYmh6fDHvK5BH95218S
	 WjTE7/IyxVl5IgiZ9xplzxjGM5hkgVvNAXL1Z1enx+z/+fXCcGFwXMTuwRFFzTqiGk
	 S9kzt7FFHlwJc14uSgPaUHzirBOUCLO109ioqQTYkZsBASo9Vte2pZwBVGSWpTn/BA
	 OyyNKXo2fT5eBtBhIb63i0iitx6BOkgqZj36M2Gp4ZCV608BRToV1uBjtWBe/i8M7c
	 IezwEcB5TWUBA==
Message-ID: <5cef9283-c718-4832-9ef6-71f1722cb8e1@kernel.org>
Date: Mon, 2 Mar 2026 17:07:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 5/5] signal: Use scoped_user_access() instead of
 __put/get_user()
To: david.laight.linux@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
 Andre Almeida <andrealmeid@igalia.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Christian Brauner <brauner@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Heiko Carstens <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Russell King <linux@armlinux.org.uk>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 Kees Cook <kees@kernel.org>, akpm@linux-foundation.org
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
 <20260302132755.1475451-6-david.laight.linux@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260302132755.1475451-6-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9020F1DC62A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78936-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,zeniv.linux.org.uk,igalia.com,citrix.com,linux.ibm.com,kernel.org,csgroup.eu,infradead.org,stgolabs.net,suse.cz,inria.fr,linux-foundation.org,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,efficios.com,ellerman.id.au,imag.fr,dabbelt.com,armlinux.org.uk,linutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



Le 02/03/2026 à 14:27, david.laight.linux@gmail.com a écrit :
> From: David Laight <david.laight.linux@gmail.com>
> 
> Mechanically change the access_ok() and __get/put_user() to use
> scoped_user_read/write_access() and unsafe_get/put_user().
> 
> This generates better code with fewer STAC/CLAC pairs.
> 
> It also ensures that access_ok() is called near the user accesses.
> I failed to find the one for __save_altstack().

On arm64 it's done in get_sigframe() it seems.

> 
> Looking at the change, perhaps there should be aliases:
> #define scoped_put_user unsafe_put_user
> #define scoped_get_user unsafe_get_user

Might be confusing to have two macros doing exactly the same thing.

And the churn might be unnecessary on some code that already widely use 
unsafe_xxx macros and that we want to convert to scoped user access, 
like for instance arch/powerpc/kernel/signal_32.c

Christophe


