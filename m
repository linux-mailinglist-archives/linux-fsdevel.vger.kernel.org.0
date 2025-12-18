Return-Path: <linux-fsdevel+bounces-71693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6413CCDE81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 00:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C228302413D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 23:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8A26C3BE;
	Thu, 18 Dec 2025 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="vb7jV33G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71EA3B19F;
	Thu, 18 Dec 2025 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766099728; cv=none; b=B7pjcaurol017c1FBylJzujM+azY3LW089tNhFMlSr7qKh+IlHpD7SnfvH0oxC2hKs7l89vIMcxmDSJTzu/+Vin8mQmuMsTvmaviBkzNUi/Lzn1BTXdOcOirjV4r+D2t8Yvscz2C8gybXCba+qdevBHKn8mpqurlG83p+2SjZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766099728; c=relaxed/simple;
	bh=0cXC7QjWlndFHEB9Cv8hYNwGfUMJZWFXnRG1l2g4zpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOmNGlUw7u77HNhN/ldLwp0Jq6AjmyfUpDrqyi2J7ev65EvePBRRL0zAFeZeQJj48wwTvpGJZapK0GBpr00CNJMhKPc48x9Ttg67cfJd/kVDq+q+SKlI3B+wwCC9SBLOrg8Zof8CYdjgFJTqmR1QSb0pUmGHuCC1SPSGWMvmBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=vb7jV33G; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C984D14C2D6;
	Fri, 19 Dec 2025 00:15:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1766099717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhlYdIZTXXwmG9n/yzVcLdOMymxzvZf2QcspbdE27d4=;
	b=vb7jV33GUhbfTV4t0gJxrwGehY4rMw0juDjwPN85KpZ29jGo5vroHzhG25H8UJBmmPwKkG
	aoGTpNj1VLGYpGuapoMGqxQuXPknHDI5lJBzbePosZu93WCOI1pTnuoJSTZ3NCZskaFwme
	y3MLKJoDLFRyjTGvPKxQd2W4IAP+wPLwjEN97nC6xdgRiN533irPavMBQSAyHS58ula9jP
	5dHwJEbIXBm7vc1DtcGeY372BnDbvRRXlPInnTAxa9GPKxXvOa/EBBVChqeo6Jbloh+Ylu
	lkiLnKm0hd8frdRpTdc9DBJv+bjr6u3/ecBO5frWpNRlV/UKKKSS9NnFMxzUVQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c5d6a9fc;
	Thu, 18 Dec 2025 23:15:13 +0000 (UTC)
Date: Fri, 19 Dec 2025 08:14:58 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Chris Arges <carges@cloudflare.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter()
 iovec
Message-ID: <aUSK8vrhPLAGdQlv@codewreck.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aUMlUDBnBs8Bdqg0@codewreck.org>
 <aUQN96w9qi9FAxag@codewreck.org>
 <8622834.T7Z3S40VBb@weasel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8622834.T7Z3S40VBb@weasel>

Christian Schoenebeck wrote on Thu, Dec 18, 2025 at 04:14:45PM +0100:
> > Won't be the first time I can't reproduce, but what kind of workload are
> > you testing?
> > Anything that might help me try to reproduce (like VM cpu count/memory)
> > will be appreciated, corruptions are Bad...
> 
> Debian Trixie guest running as 9p rootfs in QEMU, 4 cores, 16 GB.
> 
> Compiling a bunch of projects with GCC works fine without errors, but with 
> clang it's very simple for me to reproduce. E.g. just a very short C++ file 
> that pulls in some system headers:
> 
> #include <utility>
> #include <sys/cdefs.h>
> #include <limits>
> 
> Then running 3 times: clang++ -c foo.cpp -std=c++17
> 
> The first 2 clang runs succeed, the 3rd clang run then always blows up for 
> anything else than cache=none, various spurious clang errors on those system 
> headers like

Thanks, I can't reproduce with this example, but building linux with
`make LLVM=1` does blow up on debian... even with cache=none actually?

I couldn't reproduce running the same rootfs directory in a container so
I don't think I corrupted my image, it appears to be reading junk? short
reads perhaps?...
(Interestingly, it doesn't seem to blow up on an alpine rootfs, I wonder
what's different...)

I'm now getting late for work but at least there's something I can
reproduce, I'll have a closer look ASAP, thank you.

-- 
Dominique Martinet | Asmadeus

