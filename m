Return-Path: <linux-fsdevel+bounces-52406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAE8AE31C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00FF188DE7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FA81F560B;
	Sun, 22 Jun 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NMauDljP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A272AD04;
	Sun, 22 Jun 2025 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750621172; cv=none; b=eteHKeoEWZza1QKgYmPPmo2p1kn1euKOmIxrC6/w1ak2+9Yog+sehjoWLwss8YVL85OJRrK/eS8oTOpMC6JjfWZTQdCHBOeaJs6MUbS3/OtpGcVDtAcxsL8UYIpTwjVlMpoYyCpQFcJgItcD7Vc6IanQETzw4HgOkxxNs8hWs1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750621172; c=relaxed/simple;
	bh=6B2mJNnldTxxbfO15czbGzLC76lbIyUbKE9PZ4W8o+s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hnbcq6mq/s1NnUFxF9z2+TippfR/rl4yRk+J9yDjOxMItZno/91UCydAjeRn6BKtGUXP0IZPhST9xqN7Ro5umUN7/pg09mEYyYZNbtIYRU7cO8QGww33N0EsDPOZ6PuHCRwvd/i5/VXio3ia4FbmlrfIfSIWwvqACpB3FtSyf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NMauDljP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC27CC4CEE3;
	Sun, 22 Jun 2025 19:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750621172;
	bh=6B2mJNnldTxxbfO15czbGzLC76lbIyUbKE9PZ4W8o+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NMauDljPDLEI4fpcPBqY2UPgIIbNDeVttAGYIqwiUwHhHSXHYldSUheeFWNNWhMj7
	 ZV+FlxXiFdLyJb1wCCPEsmP6zjwhf/ZfcIw/AIRPihkVD+39Z8Bwo+6UvZTy2lPNdI
	 kGqFBbMZErbWxdKxZjTGGzQFlaDUFZ+cKI8k8uE4=
Date: Sun, 22 Jun 2025 12:39:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, David Hildenbrand
 <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou
 <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Stefan Roesch
 <shr@devkernel.io>
Subject: Re: [PATCH v3 3/4] mm: prevent KSM from breaking VMA merging for
 new VMAs
Message-Id: <20250622123931.30b1739642be8ec1e9ca04e2@linux-foundation.org>
In-Reply-To: <5861f8f6-cf5a-4d82-a062-139fb3f9cddb@lucifer.local>
References: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
	<3ba660af716d87a18ca5b4e635f2101edeb56340.1748537921.git.lorenzo.stoakes@oracle.com>
	<5861f8f6-cf5a-4d82-a062-139fb3f9cddb@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 13:48:09 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Hi Andrew,
> 
> Sending a fix-patch for this commit due to a reported syzbot issue which
> highlighted a bug in the implementation.
> 
> I discuss the syzbot report at [0].
> 
> [0]: https://lore.kernel.org/all/a55beb72-4288-4356-9642-76ab35a2a07c@lucifer.local/
> 
> There's a very minor conflict around the map->vm_flags vs. map->flags change,
> easily resolvable, but if you need a respin let me know.

I actually saw 4 conflicts, fixed various things up and...

> @@ -2487,6 +2496,11 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	if (error)
>  		goto free_iter_vma;
> 
> +	if (!map->check_ksm_early) {
> +		update_ksm_flags(map);
> +		vm_flags_init(vma, map->vm_flags);
> +	}
> +

Guessing map->flags was intended here, I made that change then unmade
it in the later mm-update-core-kernel-code-to-use-vm_flags_t-consistently.patch.

I'll do a full rebuild at a couple of bisection points, please check
that all landed OK.


