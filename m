Return-Path: <linux-fsdevel+bounces-67303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF0C3AE91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 13:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF70188FC37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C806432B9B6;
	Thu,  6 Nov 2025 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WvH0SWXr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DF31B113;
	Thu,  6 Nov 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432572; cv=none; b=BcfIQ721buWWWP9TGYx+cH7JWqih+YUCaIX7b+LlJtQZ3bwvvXZEMVfxqNgp82NxM7s2XVWG7CtulIwyF3QqdoPDgbKNVaaUDgeFzIUXtlpRI/prz/I2U0N4S7JL/W5EcrXGy+SWmeIK+pIYSmDM/oKsi5ULO1j+p7xHQkBnQ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432572; c=relaxed/simple;
	bh=P2+mwakpkR3t3QcCj/dC68/r4KbhQXtZfj7SVCBR+W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJmpW0BUr8q5pwYsxhRCnRQ55MNZi+gYtFHFzIeNRy8VA4rnt2I7b4fRpiefx2cYvfR5yqbiDoX/29/8s6SsUsOzJmj/oO7fmjx+/gM+UVEVpFgXQILiGqI9OyI+yhlVPB4QatuOkJfgC4kIVnOf1g95cwrF3aPSZCZZhQosyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WvH0SWXr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P2+mwakpkR3t3QcCj/dC68/r4KbhQXtZfj7SVCBR+W0=; b=WvH0SWXrZ7oUYfvCr1Xw3Jf9RO
	owX4C7Y67ZD+vIWCz0sM5vppn6YgKdTqsYkDmKlnJXoBApckZ8YEDkYzB54yTO5/J9+md1lF0Zdtv
	/GoMMIhsUhRXO+hvYEaKuwHt/wZ1G30YIbRzrxxqHVqRO1/+LndvF0pW0PH/rxQhgiSn/kqv/E9+y
	fW0SfBcoA/t9vBNhR3M3RxhxGimxKWmU0zVSVIQnGMUcBORsSmcq3cE8PjM/nnTkMWi1WxhXcArLN
	PqJT/yxoScCodUlU6M7uMxu0pzlpacwgJz2U+TFRJnhIXeKP2a70OUlez9x2y3rOZgE0YK/MHDulA
	eaQHasGg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGyLl-00000004GSz-45lA;
	Thu, 06 Nov 2025 11:40:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 71E85300230; Thu, 06 Nov 2025 13:35:50 +0100 (CET)
Date: Thu, 6 Nov 2025 13:35:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andre Almeida <andrealmeid@igalia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 10/10] powerpc/uaccess: Implement masked user access
Message-ID: <20251106123550.GX4067720@noisy.programming.kicks-ass.net>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
 <5c80dddf8c7b1e75f08b3f42bddde891d6ea3f64.1762427933.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c80dddf8c7b1e75f08b3f42bddde891d6ea3f64.1762427933.git.christophe.leroy@csgroup.eu>

On Thu, Nov 06, 2025 at 12:31:28PM +0100, Christophe Leroy wrote:

> On 32 bits it is more tricky. In theory user space can go up to
> 0xbfffffff while kernel will usually start at 0xc0000000. So a gap
> needs to be added in-between. Allthough in theory a single 4k page
> would suffice, it is easier and more efficient to enforce a 128k gap
> below kernel, as it simplifies the masking.

Do we have the requirement that the first access of a masked pointer is
within 4k of the initial address?

Suppose the pointer is to an 16k array, and the memcpy happens to like
going backwards. Then a 4k hole just won't do.



