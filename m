Return-Path: <linux-fsdevel+bounces-74202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1731D38488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56230305E283
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004F34D4C9;
	Fri, 16 Jan 2026 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="fk3MsYN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C134D4CF;
	Fri, 16 Jan 2026 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588848; cv=none; b=ojEvwxpjGQ77imHjSHcStrD2dxlHINr69/qmLmUjkTxRQIuhs6RJSyV988cPDi+7lfG8Irti1spMCyM/qDnnq/UDHLj5DQj+lWSJbsH3rC+JDHHIuF9V4LUSWNaegSc5l2nOqxE6dGhT324MbIRGT0juvKs1Qj/g7f8jHWzqD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588848; c=relaxed/simple;
	bh=Dty10U6WF4QyF+KPpGS/GhjrkPRrgq9qywHEW475isw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JoYTZDWYnKxquImPW6PLmrM7mNvNRIuJz+rIv0TUDoCX3mO3MtMKBl3nuiK39zC2JbFhNQEokPWkR9N5m7Zmj0i2ZhmhtTh1cj+nd8QiAo4aO2vt7NYpfLb3vOoUc6ySv3Jf0ShzI2I9FmJN3HYPzX6RF7RayfowUG/3rZEW4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=fk3MsYN9; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9218F40425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1768588846; bh=buANyMgVQg1KuzVvtstTUuXIbQBefDLuFIKdgZN8TcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fk3MsYN9pXWYgH2tNyFcgFN+6YZLW7LN7mr4oSOlqO7mRogAk4ToAD8PO3qLEG0FA
	 TCHWg0gvLBTbhUAFSs+f3XLSWYCyzdsCeihAJ9j9w03naMaJZbQEaqH7KgTpqzqrqf
	 N5NWhTPHuq8Mv4/MYYkD6jSLfT2nYncEf14NzcUbwm+jSXiS4c8NLj0eUT+7CajCW8
	 BsdeqW3srxsFI97LdQkDvMT7YHPjBkdvRtMpw6zPB0E8ZFE6Mf8ZYcvxKKVs/TydmB
	 l91lWiqsBQpXjyBmLzLQGIWivb4zTIESgzjdOACEOV8RrW3C3+L+6NkY9CJFQy7FQh
	 lCtuu2EJ8KkEw==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9218F40425;
	Fri, 16 Jan 2026 18:40:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Matthew Wilcox
 <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: add fs/open.c to api-summary
In-Reply-To: <20260104204530.518206-1-rdunlap@infradead.org>
References: <20260104204530.518206-1-rdunlap@infradead.org>
Date: Fri, 16 Jan 2026 11:40:45 -0700
Message-ID: <871pjpo0ya.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Include fs/open.c in filesystems/api-summary.rst to provide its
> exported APIs.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
>
>  Documentation/filesystems/api-summary.rst |    3 +++
>  1 file changed, 3 insertions(+)
>
> --- linux-next-20251219.orig/Documentation/filesystems/api-summary.rst
> +++ linux-next-20251219/Documentation/filesystems/api-summary.rst
> @@ -56,6 +56,9 @@ Other Functions
>  .. kernel-doc:: fs/namei.c
>     :export:
>  
> +.. kernel-doc:: fs/open.c
> +   :export:
> +

So I've applied this, but it does add a couple of new warnings:

  Documentation/filesystems/api-summary:59: ./fs/open.c:1157: WARNING: Inline emphasis start-string without end-string. [docutils]
  Documentation/filesystems/api-summary:59: ./fs/open.c:1147: ERROR: Unknown target name: "o". [docutils]

It would be nice to get those fixed up.

Thanks,

jon

