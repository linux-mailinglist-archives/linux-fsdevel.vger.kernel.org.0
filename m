Return-Path: <linux-fsdevel+bounces-32864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26FE9AFD4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 10:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62FB283629
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E33C1D2F5F;
	Fri, 25 Oct 2024 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lMkj22iw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3C171E43
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846628; cv=none; b=dMEx+tFePqt0w2a23OP4rqBPQOW2bymwFg9jWR7noDjz1o1dHjfv4fMP/z2vwwUJBjuhsHMZKkjaxFs2KALfn7rMF5DmuVg/t9P3NIXGLVSadGScBKpldyqgmjMZMuIZK3T5QATaaMEV+MaMSyvxgqXL0UrK20NjdlATbhxz4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846628; c=relaxed/simple;
	bh=B0Rxa+vOfE5dY3FhvNr7ws6YhOlPUFXs15xPXNdOEIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HcysUQiYOdcq2YAdF154ewHA6icEWXJSay46gMe4ZPvArFaS41x+7abW/7igmuK8mQJsfoIbo26xcTOMdpgj2xHNRkUHp7xsY2EoR+yJailuOkEg5mAavGQjj+M2xJbe68/HtiLmlTtDBUI7QL3vCK75FYABeG8yl+Nc+Rlv+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lMkj22iw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qJSFjIpnl6Nk8kryfd+s56qg6w0ha2aCPbFyn5Yc4wY=;
	t=1729846626; x=1731056226; b=lMkj22iwzCkTQUmY/7YbeKquD4PyS3DL9z+6A/+WEp1fRY1
	CZVaLu2my5uHYTsICT7rT3muaOqIvWPAusUhkq7xYjHALzTrpOHwDIrBwzpyvN6srWghpy+1LYPr4
	k6rls7W/OxZoftcEuFuXQVBMSZNEv3VxcSi/ZQscaWsSm6lszEXOG8jZen1+lGwIbbftNOo0cKtBW
	xSICm5wvDhpTTMe9qwDNFJaSjO7zdc8Q69VJJgAXYN7o7bujxPm/mx1UwpXpGwnFA5arGINp36sP8
	fnVFqMPSL8QXD/EXYGtJFpdUkPwK6GUEsUbiAytPDvqLW8cavtWelhVJ6Ae6SLHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4G7p-00000004RoO-0ixE;
	Fri, 25 Oct 2024 10:56:53 +0200
Message-ID: <d24d5197bff15d64e6ac14f538f9718403e478f6.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 02/13] x86/um: nommu: elf loader for fdpic
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: ricarkol@google.com, Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org
Date: Fri, 25 Oct 2024 10:56:51 +0200
In-Reply-To: <db0cc5bc7e55431f1ac6580aa1d983f8cfc661fb.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <db0cc5bc7e55431f1ac6580aa1d983f8cfc661fb.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
>=20
> +#ifndef CONFIG_MMU
> +#include <asm-generic/bug.h>

Not sure that makes so much sense in the middle of the file, no harm
always having it?
>=20
> +static inline const struct user_regset_view *task_user_regset_view(
> +	struct task_struct *task)

What happened to indentation here ;-)

static inline const ..... *
task_user_regset_view(....)

would be far easier to read.

> +++ b/arch/x86/um/asm/module.h
> @@ -2,23 +2,6 @@
>  #ifndef __UM_MODULE_H
>  #define __UM_MODULE_H
> =20
> -/* UML is simple */
> -struct mod_arch_specific
> -{
> -};
> -
> -#ifdef CONFIG_X86_32
> -
> -#define Elf_Shdr Elf32_Shdr
> -#define Elf_Sym Elf32_Sym
> -#define Elf_Ehdr Elf32_Ehdr
> -
> -#else
> -
> -#define Elf_Shdr Elf64_Shdr
> -#define Elf_Sym Elf64_Sym
> -#define Elf_Ehdr Elf64_Ehdr
> -
> -#endif
> +#include <asm-generic/module.h>
> =20
>  #endif

That seems like a worthwhile cleanup on its own, but you should be able
to just remove the file entirely?

johannes

