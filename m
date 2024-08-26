Return-Path: <linux-fsdevel+bounces-27105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F3C95EA43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B7C281477
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6914212DD88;
	Mon, 26 Aug 2024 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T7JLAXHA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190385260;
	Mon, 26 Aug 2024 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656861; cv=none; b=nEdhhwxfb0M4LBmYFIUqe9BaRGnHKq9fKHQsEX08DoPmyRVbPfDHWH31wgdd+HU+pFZDCGM+BMfqq42KDYhIDryeXOb6TwaFAbN92/MqBNpzdJfla5+hAgjodNTgoLOCCEH6Hwwo/Li4mIXMRn1avUPor/OkojXlqELsa9jCZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656861; c=relaxed/simple;
	bh=qcMCBtUBy484YxdwCvNqNqPvNuQV+qnC3pQD80jjxAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLNnT3LIimwhJqSei7C4pkQRq5jo1dkQbgE7NS42UgU8D9iQbqCS/vMKjuxBjRBx91eG9Jd2pqLx7BXShsOB6qHZ9v+YKuZ81LUcm+vowdZGUBXoic69dzUw27fG1Q5uF5wbJ04mpDu0H8KhwmTgMC8vCXWFZ543YO/rTAD/6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=T7JLAXHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09A4C4CC2E;
	Mon, 26 Aug 2024 07:20:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T7JLAXHA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724656857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cuB0YoGZhYs7TpZj24P+wVPnnaqDYDZ5SUiO+GVRr0s=;
	b=T7JLAXHAyeqrOhp4YIVWiuAEzZrJfTb/4IQwceTEiw10dy3k75OG3jvzg0ui7cWI/QbD0a
	mTgPEG086WEzE50bLMn0T16iVBfFqq0GVWR9/O3q5fwHIpbL8STnqrZcDmcRFM/aGrnu9s
	ZvFsbaSZzLv7aqahzI7qzXfiP7ZSyqI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 80829940 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 07:20:57 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:20:48 +0200
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
Subject: Re: [PATCH v2 01/17] asm-generic/unaligned.h: Extract common header
 for vDSO
Message-ID: <Zsws0AkFnFDYo5p6@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <a583352e8ae8f6a9a08f9b84a2c543fe43ef94db.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a583352e8ae8f6a9a08f9b84a2c543fe43ef94db.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:09AM +0200, Christophe Leroy wrote:
>  include/asm-generic/unaligned.h | 11 +----------
>  include/vdso/unaligned.h        | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 10 deletions(-)
>  create mode 100644 include/vdso/unaligned.h

Do you need to also adjust the `#include <asm/unaligned.h>` inside of
lib/vdso/getrandom.c to instead read `#include <vdso/unaligned.h>`?

Jason

