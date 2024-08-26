Return-Path: <linux-fsdevel+bounces-27114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813ED95EAAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE421F217DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5413A276;
	Mon, 26 Aug 2024 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f6krDVK3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265E85654;
	Mon, 26 Aug 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658024; cv=none; b=uapBuf3mmzlWkEPki7GLkU+TeWIOFwhd0jbU56zRIy2fjzi9GuTebjbk4Ogen7r3GzJJPB/ilQn+x168ZG4sF/ZvBRABKHKImOvSOsszhRYwovGszBUWgfwFWG8FrNJutva37cxpXArQuidhxYxRYRKiqRFbQc9d75GjfhkBWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658024; c=relaxed/simple;
	bh=Vdfzk0+hsBwqouzzsLrE7b2iuoHaoc7+4qe5N0CKgKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTyhS3EiJLQSHU0iBpBBpvhOP2jXi1V+AIvnSmGCBNFy1pJrFKpcbzja/l1xTgRiU1LEdjeKkMz5SApXOPGSA49TaIfgmCFq3lV2yjay0kHROKCi5lo3E0+eQRouRdynxpVl0Mz0zgZ5kXMJZeQzQgdxDd4VZhO9aSnhYbhSO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=f6krDVK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD63C8CDC1;
	Mon, 26 Aug 2024 07:40:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f6krDVK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724658020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vdfzk0+hsBwqouzzsLrE7b2iuoHaoc7+4qe5N0CKgKg=;
	b=f6krDVK3TxERL8zAmaVe24oiQRp/ht+Cyq+RdZEmbYWoZwGBirYKtCYcwmdEU/GqsES+5R
	0fHQiA+zG6EvJCNCNdAUT5gpgNKBkikQaclGA/a5Ej038vA6HfWLdbxQ2p8LXouq/iqe/A
	0YJpA7YbHp2IDGykFHXaGU/efEwxpPI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 433d423e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 07:40:20 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:40:11 +0200
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
Subject: Re: [PATCH v2 04/17] vdso: Add missing c-getrandom-y in Makefile
Message-ID: <ZswxW13r82w6Bz-B@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <4ba87b8daeb2f3c0f98e62e16bf60c7e97fb53d5.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ba87b8daeb2f3c0f98e62e16bf60c7e97fb53d5.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:12AM +0200, Christophe Leroy wrote:
> Same as for gettimeofday CVDSO implementation, add c-getrandom-y
> to ease the inclusion of lib/vdso/getrandom.c in architectures
> VDSO builds.

Thanks, seems straight forward. I'll apply this now as a fix.

