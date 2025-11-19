Return-Path: <linux-fsdevel+bounces-69058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB4CC6D9AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09D52351606
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256163358DD;
	Wed, 19 Nov 2025 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtVFxRZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9BA33557E;
	Wed, 19 Nov 2025 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543212; cv=none; b=sGcyaQ9DsFXIopTsVtcVumAJjduaj7UwGyAtLscozZcVrm+DKbVfnUbDCsJndnCcxnwS3jIX8iRVnWc8wydCwN7ubcCXq3R2JhriptM0CR/jvEWXxGfYZ4Y0gSegH+bA9F/v0E1IUlWGEWaKVtC2q1W/AJpweeRmY/PRGN4HYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543212; c=relaxed/simple;
	bh=9VkQQVp1GUJZvklIUdL6yF9pgR7bsQTx3z4kO9z5dMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkZhfmJS5BzGr6ln5WbU+ofXXRD6NBfaXwOc7I5ERbjyvNOZ0TGrvzY+ifxts/HWblOegGwV46qaUHZtZzhPtizra7c4RLz1qox3odaq61zG3F9P932K+JPbxna64SFdQeOlLObpb/e48hbJ8yiMdfmdAIp6qXHw7Bn56gYWDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtVFxRZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB818C19422;
	Wed, 19 Nov 2025 09:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763543209;
	bh=9VkQQVp1GUJZvklIUdL6yF9pgR7bsQTx3z4kO9z5dMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OtVFxRZIeWCKgm/wX8Mh4xSUKUsDu7TC61ZcbwB7p755P/p8D1UbOzn887vZKWsiT
	 LT8Hkl3H3DdI8TLAeKktrX3yWPQQeQzoD5az9ce9h9AJFO474lVbcQaSZN4cdtnOd8
	 qMzgerN86Kq5LjGLmF8Xvx0kt31CQR/SNyrzETsVCfIlrjxK/jwXc0n9+UEq8FW+87
	 frsGoVcUKPI4zE7zMA2vs5hS+GVhuQnNfj1tCMielj1RrXvfjcbkBaPmp99gNYG86X
	 g8w2OOyBsEud9UYPSoka4/54CHPtP2JqM1W+W7dvk4+P26CuXNiNahahWDLbiZIptV
	 UKv7ewASeZOgA==
Message-ID: <9b18ee75-bf06-46d7-96f3-395cb159217b@kernel.org>
Date: Wed, 19 Nov 2025 10:06:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] mm: add atomic VMA flags and set VM_MAYBE_GUARD as
 such
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
 <97e57abed09f2663077ed7a36fb8206e243171a9.1763460113.git.lorenzo.stoakes@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <97e57abed09f2663077ed7a36fb8206e243171a9.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.11.25 11:17, Lorenzo Stoakes wrote:
> This patch adds the ability to atomically set VMA flags with only the mmap
> read/VMA read lock held.
> 
> As this could be hugely problematic for VMA flags in general given that
> all other accesses are non-atomic and serialised by the mmap/VMA locks, we
> implement this with a strict allow-list - that is, only designated flags
> are allowed to do this.
> 
> We make VM_MAYBE_GUARD one of these flags.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---

IIUC all other flag modifications need a write lock, so this should just 
work.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

