Return-Path: <linux-fsdevel+bounces-22227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C369391456E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 10:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8A5285178
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDCF7EF1F;
	Mon, 24 Jun 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="AfhLmru7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281753F9FC;
	Mon, 24 Jun 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219256; cv=none; b=pimljDXJ0dSDZP2MbtXDs67lFYZW7t9S/zoQhqPS47bCSSxy7OEPgXLpIw12GSVZLNFLqgfuSsVLu/c5v3lIvi9OTqUtWgNA/7AW3T+zT0V6a8O020kFiDCBeX5YH2HC2cGeO+tZspyZabytjmXCpfanXHFhzlJHXX6ZdluF+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219256; c=relaxed/simple;
	bh=ocOc6W3nfjA+v3b4b9fjy6xI5w/ljliH+Jjzy0nLkVM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=np2a4wCe5F2mgtmPsNxRRyMhh39WI9A4CHp6sawlmnvyzK2Qdzj1ABWX+Uz6JRlKXYEwUHYK4dtULmolkIH9YB7Q0P9NE66GaLJjEDwdkZIHg0JSKPUC7WZbjNcMxgcxTYb7fTw4l/yoj9xgTfCzunDQfaw/eBNqyW0LJcS2Tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=AfhLmru7; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719219251;
	bh=ocOc6W3nfjA+v3b4b9fjy6xI5w/ljliH+Jjzy0nLkVM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AfhLmru7Qv3f7wTCe3qV9sByoGRlleaLUkuQKamVOOzyqE+CiUT09S7ACn/2mj3qQ
	 7wsXwdY6YtcSkIrxy7xro2vZXJIj0cvB7/AKUQOm5KbxKQuT7UgvocAwq0KqA8zQyP
	 2S1MuiNHwcx0saKlRuYtkls5WvXjV4brZ8z2GWj4=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id AD8DD66C03;
	Mon, 24 Jun 2024 04:54:05 -0400 (EDT)
Message-ID: <220432a52aecc31dea32178bf230bb2ce262b6e9.camel@xry111.site>
Subject: Re: [PATCH v2] vfs: Shortcut AT_EMPTY_PATH early for statx, and add
 AT_NO_PATH for statx and fstatat
From: Xi Ruoyao <xry111@xry111.site>
To: Christian Brauner <brauner@kernel.org>, Alexander Viro
	 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Mateusz Guzik
	 <mjguzik@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,  Icenowy Zheng <uwu@icenowy.me>,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 16:54:03 +0800
In-Reply-To: <20240624085037.33442-2-xry111@xry111.site>
References: <20240624085037.33442-2-xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 16:50 +0800, Xi Ruoyao wrote:
> Seccomp sandboxes can also green light fstatat/statx(AT_NO_PATH) easier
> than fstatat/statx(AT_EMPTY_PATH) for which the audition needs to check
> 5434782543478254347825434782the path but seccomp BPF program cannot do th=
at now.

Oops "5434782543478254347825434782" is meaningless.  Not sure how it
ended up in my commit message.  I'll remove it in v3 but now just
waiting for comments.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

