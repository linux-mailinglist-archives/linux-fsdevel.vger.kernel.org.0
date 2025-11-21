Return-Path: <linux-fsdevel+bounces-69382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDDAC7AC78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 17:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 341574E1688
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76834D4DC;
	Fri, 21 Nov 2025 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXrPBIfz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F3357A48;
	Fri, 21 Nov 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741358; cv=none; b=i5XBImyvIJSd8YT/iri0KY3T/ASedk1Lb0EI3/mGoY3Cxo9mELghb1TZTPMo3eOuJTYnYZyqrwD80wKsBLolO4UgR26jFGAnVLbArGaphRpZ4yVCBTqeq1HZpcS/NOWgkR+9DN9fkZgtn3zEXgSv+lfmX0woizSyirAAgJB3eEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741358; c=relaxed/simple;
	bh=//OuOvMXeDV9xgqjwXYfwljPeKEYUBLLHfpTkq6K8+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIITaIEiE5AX5lm6Zt16hyeClz/VfexmbwXQE3j+I01P8lZjugh71upyQtXIMtiA0KmpHJoCHtCS0/2w3RvmTFpHvwKf3XPLiBoyES3LdF18WtPgl/n5oR4WqgzTYvyz9prpYDC84EdjLarX/VEp6RnDWEv4KVJMoR8TLK3Pu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXrPBIfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E86C4CEF1;
	Fri, 21 Nov 2025 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763741357;
	bh=//OuOvMXeDV9xgqjwXYfwljPeKEYUBLLHfpTkq6K8+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DXrPBIfzI0rxVmeV3dm4FH1BWca0aQOsApup4El5ebC7/Wnbgl4eKyhSn1TIGGat+
	 vzz/NrU+jaItZ8HFmGhr86j1xgwmOSYZSNYke4wL/syHqsVWZQukAqEhNqa+YNeBPk
	 31QsKCYCoAkM38ieBYVKK5PUc7SbGf1eklyzn4hbLVOVv03psyu/FsTvwpQUJc32fZ
	 7tY90oZuYPnRk61KoNosla/msm9JvWELMKFOGQibL0zU59vuJTMgJueCkMx3/vpyuS
	 7FE3P69FI738zFjFu+4J6UR3L8bSD7oVpcGOKZ1Fj9BmljA4Dxgutytafxy0PEhDdT
	 FX70hzkqbeyzw==
Message-ID: <f8669e93-24a8-47e1-9ba9-66df9627e998@kernel.org>
Date: Fri, 21 Nov 2025 17:09:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] mm: implement sticky VMA flags
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
 <22ad5269f7669d62afb42ce0c79bad70b994c58d.1763460113.git.lorenzo.stoakes@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <22ad5269f7669d62afb42ce0c79bad70b994c58d.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/25 11:17, Lorenzo Stoakes wrote:
> It is useful to be able to designate that certain flags are 'sticky', that
> is, if two VMAs are merged one with a flag of this nature and one without,
> the merged VMA sets this flag.
> 
> As a result we ignore these flags for the purposes of determining VMA flag
> differences between VMAs being considered for merge.
> 
> This patch therefore updates the VMA merge logic to perform this action,
> with flags possessing this property being described in the VM_STICKY
> bitmap.
> 
> Those flags which ought to be ignored for the purposes of VMA merge are
> described in the VM_IGNORE_MERGE bitmap, which the VMA merge logic is also
> updated to use.
> 
> As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
> already had this behaviour, alongside VM_STICKY as sticky flags by
> implication must not disallow merge.
> 
> Ultimately it seems that we should make VM_SOFTDIRTY a sticky flag in its
> own right, but this change is out of scope for this series.
> 
> The only sticky flag designated as such is VM_MAYBE_GUARD, so as a result
> of this change, once the VMA flag is set upon guard region installation,
> VMAs with guard ranges will now not have their merge behaviour impacted as
> a result and can be freely merged with other VMAs without VM_MAYBE_GUARD
> set.
> 
> Also update the comments for vma_modify_flags() to directly reference
> sticky flags now we have established the concept.
> 
> We also update the VMA userland tests to account for the changes.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

