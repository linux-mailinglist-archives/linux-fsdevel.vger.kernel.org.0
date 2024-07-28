Return-Path: <linux-fsdevel+bounces-24382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9F593E935
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 22:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD76B20E95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 20:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08524770F6;
	Sun, 28 Jul 2024 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UGnXsJvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9C763EE;
	Sun, 28 Jul 2024 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722197705; cv=none; b=cVyesOXe5VgktbldVKBt+I+eboOgjOC+O50Zdsh3heIyYZzLsTXlqKJiKlnfUujgOtsf04pmxE3pAzjKchqOW4ebmpqgNQ+TngX/IzGP++wg4w/5KSqgYeI+zdMDnd6XtH6NN7+ybi/sbVPwRALuDOnJYYa0jM/G11+95/0Wfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722197705; c=relaxed/simple;
	bh=JqrZP+bJZ7QEfiDfTGUWnpQxHpc2DZA59kC1iw6Omq4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HdKWjM2yisNXlcJS/xHtMeXggossVapKfUc2oArC8kpzME8I33RZ5AsMS98dizr4Pis18CO9OctqXEP+nvua6Eg1PeLzHBc8qXKOY9zB5CeIF0Ou9ERiYUgKsMkJnqIaPw+jGhDTtfGsF5mxrOSwwcg/S8/IE9HxggNwZ0dYz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UGnXsJvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A859C4AF09;
	Sun, 28 Jul 2024 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722197704;
	bh=JqrZP+bJZ7QEfiDfTGUWnpQxHpc2DZA59kC1iw6Omq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UGnXsJvcVJyJdK08D4CH+K+6YJOy7gd0yDun6gYhDUZo6XOLsLpYpROhVwwZbRS4A
	 Nu6Gl2KFnI1H4O1H5QuUDwE0LNkzErEYykpfgZe47n9DzMhAm9PhOx9vaWMGmqleh/
	 UktPPtqSZ2L9hX8OLR3JI4VFCLmgniUDm7rOxbPs=
Date: Sun, 28 Jul 2024 13:15:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>, SeongJae Park
 <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, Brendan Higgins
 <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar
 <rmoar@google.com>
Subject: Re: [PATCH v3 6/7] tools: separate out shared radix-tree components
Message-Id: <20240728131503.18f2f41bc15d2fdaddf5fc75@linux-foundation.org>
In-Reply-To: <d5905fa6f25b159a156a5a6a87c5b1ac25568c5b.1721648367.git.lorenzo.stoakes@oracle.com>
References: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
	<d5905fa6f25b159a156a5a6a87c5b1ac25568c5b.1721648367.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 12:50:24 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> The core components contained within the radix-tree tests which provide
> shims for kernel headers and access to the maple tree are useful for
> testing other things, so separate them out and make the radix tree tests
> dependent on the shared components.
> 
> This lays the groundwork for us to add VMA tests of the newly introduced
> vma.c file.
> 
> ...
>
>  tools/testing/{radix-tree => shared}/bitmap.c |  0

Some merge issues have popped up - people have been messing around with
the radix tree test code and not telling us.  I'll drop the v3 series -
please redo and resend against 6.11-rc1?

Thanks.

