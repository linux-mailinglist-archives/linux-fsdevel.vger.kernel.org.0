Return-Path: <linux-fsdevel+bounces-22189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F5791371C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 03:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938611F21CD1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 01:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C894A29;
	Sun, 23 Jun 2024 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="c3bAI6Vk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022420E6;
	Sun, 23 Jun 2024 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719104397; cv=none; b=D/9i6wZjrLLf0CC7CU1fj3t7KFfGtrtMxGY0zqKpy/MgG5nziJtbWKgVHOxwrcYb8OhHW7R6WixmkivsyLLqsnLVsQgnUOkdJ4t8VI4KBJfOTDukoYfUR3Lc0yuKadWf9edJR21TYUMkVKSvOjdimSQpLCClX5eFmSaO6nqxJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719104397; c=relaxed/simple;
	bh=S+DlB8OfxHY0JJoj0wo3AR5ofesjMbk6HRqWBDpjeQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQLnBVQ5BQl0WQKgvz2Fc8MQLLT0KH/oLJGjuYOCtIOZke5m2Kld3XD94PLI9MaEiYK9/Qn7ZzR38Wzqwt6arRf/1EDxzmkYyqSW71k1YSHoWYUG7NyQRO4xNSS3Eyf7PnYWQ883WC6lLs/coAkr1BiN1JZLaUx0l+tJ4Gk/uLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=c3bAI6Vk; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719104392;
	bh=S+DlB8OfxHY0JJoj0wo3AR5ofesjMbk6HRqWBDpjeQ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=c3bAI6VkI8ubyVvvW6S44F23hGiVVKk3KFji+or9YHriQq6ngjyeeJEAZ+CGCidLN
	 zz1FB7QJ5rUBpHvSs8rk93eCAk4LTbenCA5IJlvc3AkVz6qDmIYTQI90tUACpsv2fR
	 vz+7G2BJGBySsi9eNAFD32ry5ifJHUsHfRw2TYz8=
Received: from [IPv6:240e:358:1154:4c00:dc73:854d:832e:6] (unknown [IPv6:240e:358:1154:4c00:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 84127664B1;
	Sat, 22 Jun 2024 20:59:45 -0400 (EDT)
Message-ID: <eeb7e9895aca92fa5a8d11d9f37b283428185278.camel@xry111.site>
Subject: Re: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked
 AT_EMPTY_PATH
From: Xi Ruoyao <xry111@xry111.site>
To: Linus Torvalds <torvalds@linux-foundation.org>, Mateusz Guzik
	 <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Alejandro
 Colomar <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen
 <chenhuacai@loongson.cn>,  Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Icenowy Zheng <uwu@icenowy.me>, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Date: Sun, 23 Jun 2024 08:59:40 +0800
In-Reply-To: <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
References: <20240622105621.7922-1-xry111@xry111.site>
	 <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
	 <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-22 at 15:41 -0700, Linus Torvalds wrote:

> I do think that we should make AT_EMPTY_PATH with a NULL path
> "JustWork(tm)", because the stupid "look if the pathname is empty" is
> horrible.
>=20
> But moving that check into getname() is *NOT* the right answer,
> because by the time you get to getname(), you have already lost.

Oops.  I'll try to get around of getname() too...

> So the short-cut in vfs_fstatat() to never get a pathname is
> disgusting - people should have used 'fstat()' - but it's _important_
> disgusting.

The problem is we don't have fstat() for LoongArch, and it'll be
unusable on all 32-bit arch after 2037.

And Arnd hates the idea adding fstat() for LoongArch because there would
be one more 32-bit arch broken in 2037.

Or should we just add something like "fstat_2037()"?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

