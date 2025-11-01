Return-Path: <linux-fsdevel+bounces-66652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 106A8C2777B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 05:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D461896F8D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 04:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F549284690;
	Sat,  1 Nov 2025 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tfOETtR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604694369A;
	Sat,  1 Nov 2025 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761970671; cv=none; b=a88VyXCcGuoZiJP8t7zUxG4rBsVyzsN/CI4TtQfuOUmhNeXWwDO6UhxSqo84FQqs4Ik6Jdzfbk7Z6ZtEGhkLPztJa1W8u3tXtYvvlEB9CyiEVqAtbQpzskHz2y+RjEClciaTb9DEYvjNKGzjsIp1vHkpIKd+Tce85YYzDvQkS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761970671; c=relaxed/simple;
	bh=NLL5ea2GwmpaOiH9MtZNsnU7K+1o4iuMC+0AO7ylnmw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cGDrJ6GYiR/HIWQDC8d0fP/Jl/GUCpN0zIOkBS2ZfLQ9eM+JvVew1Vg1zAcce4mTC/u0HGLOKFwWLgDmDE4cLKSBrTgXUgtcefCEy+OhTcb/JIMBrOYPmmG89gfYwTw0ivbqlAN9vH7wLkmUEl0VGCfxS7p3IFelNVTfnoNjPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tfOETtR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F082C4CEF1;
	Sat,  1 Nov 2025 04:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761970671;
	bh=NLL5ea2GwmpaOiH9MtZNsnU7K+1o4iuMC+0AO7ylnmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tfOETtR1sXcY6EhAa2YKEqAJKZGK3QYaHCgEs/S4mQ7CY8b8+TerJy7pHNrXau1yl
	 9JQE1HslJhp14A8NfUPLGV6YOhOXJUaQeUkt45vBXU/g51NiO2h+IEu4xAwcj2LunE
	 FeYE9LbWGV2HGdv5ndvvOFTVdz+qGyZS9ZgTwuQM=
Date: Fri, 31 Oct 2025 21:17:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, David Hildenbrand
 <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-Id: <20251031211749.e8729676c0ca40c8d6b95166@linux-foundation.org>
In-Reply-To: <9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>
References: <20251027115636.82382-1-kirill@shutemov.name>
	<20251027115636.82382-2-kirill@shutemov.name>
	<20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org>
	<hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
	<9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 02:45:52 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> > Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> 
> I agree that's the right Fixee for 2/2: the one which introduced
> splitting a large folio to non-shmem filesystems in 5.17.
> 
> But you're giving yourself too hard a time of backporting with your
> 5.10 Fixee 01c70267053d for 1/2: the only filesystem which set the
> flag then was tmpfs, which you're now excepting.  The flag got
> renamed later (in 5.16) and then in 5.17 at last there was another
> filesystem to set it.  So, this 1/2 would be
> 
> Fixes: 6795801366da ("xfs: Support large folios")

I updated the changelog in mm.git's copy of this patch, thanks.

