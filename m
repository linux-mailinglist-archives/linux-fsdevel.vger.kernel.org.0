Return-Path: <linux-fsdevel+bounces-27113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB85395EAA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFA51C20FC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227A13A25F;
	Mon, 26 Aug 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X2EiMjdR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3FB17FD;
	Mon, 26 Aug 2024 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657889; cv=none; b=B2tD3wy414OUV3LEXx2rW82H0dNOJnBGc9kbFlgDsGmb3XUIA4Pos8IBoURdtLjTtrxrTNbaQKcmeUjxt+/eLi07tyeQO9zjsV4QxgcGZRnZA6oJnmygw31YakJFVJmrbktkksajOU9qDb4IVyFj5HlzH8apM+xyPnfJz9ZPkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657889; c=relaxed/simple;
	bh=4jZlQqYT2iwt/kKk0Wu5PT3lXHwZbBnEEz9RFA5Jo+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX/cojmXkUrlwkFC7vlXtWwaODzmJlsxuB+7gkog6yNWl7aqJnayttx5w35+tQ3Tt402qq56crU0Z2FsqiTK13DIuWX0b4s4lP94HnIpp/JiCpc1gHC8thF9VHdJoW5im18Iolm9IahvHkwgUCVSr00g4blKX0uuP1gcxe1v448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=X2EiMjdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A2AC8CDC1;
	Mon, 26 Aug 2024 07:38:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X2EiMjdR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724657885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jumxgHXVZw5b27vJZV1Xc81w+BGEUEBT++1X+y17eXM=;
	b=X2EiMjdR3EdNxjI3x1bQOgJRdF//Juq/iK+blRCB6mkEKShZv2DdzDb5T6sJ0CSgr8DTrO
	CHOW8X2DqZjtE1ZGFBTwT3XueIppy4bMGI92dBoD+xkYb3vIpgFmTKlgdb8V1tfoLKBvtF
	hY0i04RI9PjGE4L3q01XhoKRLDN13cI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6957f791 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 07:38:05 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:37:56 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 16/17] selftests: vdso: Make VDSO function call more
 generic
Message-ID: <Zsww1IgALClDUf8g@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <bd05c8faee64972a9e01f9497d1870dc267a55f4.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd05c8faee64972a9e01f9497d1870dc267a55f4.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:24AM +0200, Christophe Leroy wrote:
> On powerpc, a call to a VDSO function is not a standard C function
> call. Unlike x86 that returns a negated error code in case of an
> error, powerpc sets CR[SO] and returns the error code as a
> positive value.
> 
> So use a macro called VDSO_CALL() which takes a pointer to the
> function to call, the number of arguments and the arguments.
 
You'll probably want to move to VDSO_CALL() for the whole test suite,
not just the getrandom one, right?

