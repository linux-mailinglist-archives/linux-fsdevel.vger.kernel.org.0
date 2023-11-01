Return-Path: <linux-fsdevel+bounces-1746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A03F7DE43E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 16:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55402B2108A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8701B14AA6;
	Wed,  1 Nov 2023 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5/9KVOy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C714B14A8A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 15:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAB8C433C7;
	Wed,  1 Nov 2023 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698854075;
	bh=JYx6SExCh08Bm1b+89icz86zNSgiBleVA/ww9551uSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5/9KVOyL+tS6/J+l1xb4bnAOleAUHFaYO7WWxKUDKDPTItJ2PT/M64zm7r0kk2/K
	 D+NIr5tHLMSiaXg2b9rWGqTrDPZbB/odbUgIIVM03JlJxI55/oOsoO7KwbEos36BlV
	 zS9noXoXSTGycP82UgC86v0MklCkIB1u4YUdlvH5ww4ezLxEBI/4LkVuZOVCF5Dcqn
	 yGAxyMySIiRUuo9+EapXJZY6Mjpqi4B7K8oszmRmBEZ0Fi9H70WhHpPWMY8WWtEo0Y
	 TlHxkqRirMdd0dO1LE6yLPHzRoqXv5cxthC3m4EjyCT1hBxFHKwZdOUDVMZ/iGMrAX
	 OZvHOTNmhfo+g==
Date: Wed, 1 Nov 2023 16:54:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] querying mount attributes
Message-ID: <20231101-nickel-syntaktisch-7123fc5b6c91@brauner>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231101-urenkel-banal-b232d7a3cbe8@brauner>
 <CAOssrKcf5NQ8pGFWKq2hG9BmFZN-0rhhO+MuYCe7fVfmFO4DAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKcf5NQ8pGFWKq2hG9BmFZN-0rhhO+MuYCe7fVfmFO4DAA@mail.gmail.com>

On Wed, Nov 01, 2023 at 02:18:30PM +0100, Miklos Szeredi wrote:
> On Wed, Nov 1, 2023 at 12:13 PM Christian Brauner <brauner@kernel.org> wrote:
> 
> > I've renamed struct statmnt to struct statmount to align with statx()
> > and struct statx. I also renamed struct stmt_state to struct kstatmount
> > as that's how we usually do this. And I renamed struct __mount_arg to
> > struct mnt_id_req and dropped the comment. Libraries can expose this in
> > whatever form they want but we'll also have direct consumers. I'd rather
> > have this struct be underscore free and officially sanctioned.
> 
> Thanks.
> 
> arch/arm64/include/asm/unistd.h needs this fixup:
> 
> -#define __NR_compat_syscalls 457
> +#define __NR_compat_syscalls 459

Everytime with that file. It's like a tradition that I forget to update
it at least once.

> 
> Can you fix inline, or should I send a proper patch?

No need to send. I'll just fix it it here.

