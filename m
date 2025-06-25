Return-Path: <linux-fsdevel+bounces-52839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D5AE762D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 06:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BF9189C134
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 04:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE531DF982;
	Wed, 25 Jun 2025 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gdUJ68Xs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C91A83F9;
	Wed, 25 Jun 2025 04:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750827054; cv=none; b=XP6jUITnBCTFPBSQZWeDcep11OAAPdFd2co7vFtPx60Zo2ndGkPyjEvDTgEeAMjYORDXEnNfxkVuqNMA3TJZISSVBASuTKirC3anJdH0bnPSF+HMid5pVb4L01srE+YVnOi+qyM3AfqitLZN3lzQK3dQeDZRFi7KBqkbg5ZAo9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750827054; c=relaxed/simple;
	bh=R3JC+OY5M+o//Yl1v0b97s5nFwwOQDq4EZehW1mQ9d0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uZgmiEXRqm0A6sBxsRqF3l/c5GiKfFfACcqvwLSZmO2DtJbsq7uS1YfU1W3Y8abxqH+CRnPfRN2iOe083nY3gMigNJhjo2BmzuevtnWGr+VmqInjrq+YGO+yDU6hIT7N4FcvxRYS1lS4Kbt5QzGUjfrS/ZzwuGtznYvKRJjQHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gdUJ68Xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D38C4CEEA;
	Wed, 25 Jun 2025 04:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750827053;
	bh=R3JC+OY5M+o//Yl1v0b97s5nFwwOQDq4EZehW1mQ9d0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gdUJ68XsmACxGdWI0eeeUoyOpEd28QFbC5WF3ix1zVAhBU7SFhiYWzSzFKt2ZrlWj
	 7iLbdug9pCu0GEEFGqG+eqSMBxxL3g3OVdWo8LF89sjc+P7CwNFlRebQlMJYAazuip
	 /uC9+0HyTEjBaK8UN8Dl5XE5P6m7252PiMnt5lv8=
Date: Tue, 24 Jun 2025 21:50:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Jarkko
 Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Zi Yan
 <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Xu Xin
 <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Hugh
 Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry.yoo@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Matthew
 Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jason Gunthorpe <jgg@ziepe.ca>, John
 Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, Oscar
 Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] use vm_flags_t consistently
Message-Id: <20250624215050.83229f93cee5994f580720e6@linux-foundation.org>
In-Reply-To: <46432a2e-1a9d-44f7-aa09-689d6e2a022a@arm.com>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
	<46432a2e-1a9d-44f7-aa09-689d6e2a022a@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 08:25:35 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> ust wondering which tree-branch this series applies ? Tried all the usual
> ones but could not apply the series cleanly.
> 
> v6.16-rc3
> next-20250624
> mm-stable
> mm-unstable

It's now in mm-unstable if that helps.

