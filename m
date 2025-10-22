Return-Path: <linux-fsdevel+bounces-65107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D337BFC86A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39F89353F3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707E34CFC8;
	Wed, 22 Oct 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W+uMC0i8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D434CFB0;
	Wed, 22 Oct 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143062; cv=none; b=nsUNSdGhgUWoJBSU/ZGiW3xt96brO95/H/BOyzaTto79kSmr8JyzjATjyGyDzFWCcXpNrInnmnB2+Mbu/n7u2VULrlbauog4+mSzm6kQYO2PLAWbkMSSo/cpje8WCaEaC88jgKN7knTzw37zwYB8IDDaGM8vA0XtHfmk3pD5738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143062; c=relaxed/simple;
	bh=H228bBJrkQxEoiNZc6XQYVYrYA5oeSdH6yGkyWFKcP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S20dy/6v2VSzUBbGA3VYahIsUmucSyHhgCKVvQxa0Cx7FamiazQNJH9Rw7KdbT+tgHeEcC8Q+SwtRLy3n3B3Q7CKp8KBSlOKhEZQqjduC/MfgGuEihv7NkiXniSCXmvB62BpfziOsf4WMPpRoEPEckT18R/ZgFR57yyLIoaYO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W+uMC0i8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dctXkstECTenaZhiUiTAEPs/+u3lBJ+4oLit/DWtNCs=; b=W+uMC0i8lkaiKuhkl8eUM+csMP
	zH9Alfil/ggkWS+mff98nPo9bDIMkuW8K5C5+KY2e8934/ExnLSA4XSDvs16qF9TmynNu52oe7tVO
	alhtY8gr8526Ul/GMwiNjT57GxRn6C1/yPzHIibpvNmoPRJeplLP1368i919MkX3vMD0TfWO58XqB
	EaUXdGG6nfjfQNZR1hVFszBgQD2CFgdZfn+DgZnjBkiVlcKh5kkIe9C65p09XP2z5JubaB3DW+xwx
	QnSnO4coWaBJMspnjlZNpjlij/u6mnQPePfu4Nb2uYSAp9cc5ZSqjPHhLdI24izWy1wkOQRbI8Bdl
	/7A8lvtg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZkt-00000007mfm-1HRN;
	Wed, 22 Oct 2025 14:24:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 542B830039F; Wed, 22 Oct 2025 16:23:59 +0200 (CEST)
Date: Wed, 22 Oct 2025 16:23:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V4 07/12] uaccess: Provide scoped user access regions
Message-ID: <20251022142359.GQ4067720@noisy.programming.kicks-ass.net>
References: <20251022102427.400699796@linutronix.de>
 <20251022103112.294959046@linutronix.de>
 <20251022152006.4d461c8b@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022152006.4d461c8b@pumpkin>

On Wed, Oct 22, 2025 at 03:20:06PM +0100, David Laight wrote:

> I think that 'feature' should be marked as a 'bug', consider code like:
> 	for (; len >= sizeof (*uaddr); uaddr++; len -= sizeof (*uaddr)) {
> 		scoped_user_read_access(uaddr, Efault) {
> 			int frag_len;
> 			unsafe_get_user(frag_len, &uaddr->len, Efault);
> 			if (!frag_len)
> 				break;
> 			...
> 		}
> 		...
> 	}
> 

All the scoped_* () things are for loops. break is a valid way to
terminate them. 

