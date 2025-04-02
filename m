Return-Path: <linux-fsdevel+bounces-45535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD2A79239
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA0A7A52AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835435949;
	Wed,  2 Apr 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="hCNnZOBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2E1FC3;
	Wed,  2 Apr 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608014; cv=none; b=Zrg0Cb12VCWQVZxAWv5rpkiDfUwMN6xaAcmxfeIT9DVlLJHtMXXLUIl0HgT/5LiCppYYAM4Bs9DT2GiwREjxbQkKCkLavsZcoqnWdFLCdU1CE9KEG7AM+nSKoikJT4iqia1YFAKCXIAuhFy8onGkzTG5djyIfxeSUi0q2cuhwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608014; c=relaxed/simple;
	bh=syfpsvuH5wQhbNS8WDq0kgGOJr6aNvZQnc8jHmVdMQU=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=rGn6ij54qI6YLU552+PcGkhKXkc99M//rZhhpxmfzYAI4XCAwlxW4PdL61R1uaHEJfPJy7CwE6GOCSbAasu6mi9MnVXggkwo4/5QWidb/r/A/BWU77budd7AcrlJWpP7J9VwIz1HXRkQ7wDflfZlhg8ARowGtnDTF7fwq2Ttm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=hCNnZOBh; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <bac53deae60fbf5dbcb19feb403d9e9f@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1743607433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FawFq1pnlpgkOhxfSYjHGUQvx87dCGjnpIvU2tRWtLc=;
	b=hCNnZOBhOpJXFp6DW1Enxrx/rOhffbmqXEUTtHWGRP4PcPMqMH1H/wgD1SNQBAvGxOfln2
	VrU5UJtP7bhhD/jecJGW6/6w5a7j1vRPG7LrwZuhTZk1BVw8DDfaDnW9+VAnqWKhLcIOFu
	wQEzFQYDTvNInXNmNSCvQE+3QKPw6Ur7t+6hAobgHhu+wK6OXafzugOJ7PKsVrjZXp4yP3
	mnoaBk53KQOlQhJtL3MAUfkLYU+3AswWadZh3dbW5jbbsawacB6jlTdzMsiH4t0HLcjr0y
	xr2b2OX4lt4dCXPOT/bjxWo+QQ8ShDhd5JMu4h+EN2122HLPSZQIbIi3Mp7a0w==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
 linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Remove cifs_truncate_page() as it should be
 superfluous
In-Reply-To: <559573.1743519662@warthog.procyon.org.uk>
References: <559573.1743519662@warthog.procyon.org.uk>
Date: Wed, 02 Apr 2025 12:23:48 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> The calls to cifs_truncate_page() should be superfluous as the places that
> call it also call truncate_setsize() or cifs_setsize() and therefore
> truncate_pagecache() which should also clear the tail part of the folio
> containing the EOF marker.
>
> Further, smb3_simple_falloc() calls both cifs_setsize() and
> truncate_setsize() in addition to cifs_truncate_page().
>
> Remove the superfluous calls.
>
> This gets rid of another function referring to struct page.
>
> [Should cifs_setsize() also set inode->i_blocks?]

I don't think that's necessary as the current inode will be marked for
revalidation (e.g. cifsInodeInfo::time is set to 0), so next call to
cifs_fattr_to_inode() will update inode->i_blocks.  If it isn't being
updated, then I'm missing something else.

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/cifsfs.h  |    1 -
>  fs/smb/client/inode.c   |   19 -------------------
>  fs/smb/client/smb2ops.c |    2 --
>  3 files changed, 22 deletions(-)

Looks good,

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>

