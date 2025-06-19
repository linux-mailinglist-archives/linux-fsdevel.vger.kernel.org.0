Return-Path: <linux-fsdevel+bounces-52225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C8CAE0509
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 14:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6670E18853C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30122FF2D;
	Thu, 19 Jun 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zqPcFbLf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jEwdsj8r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zqPcFbLf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jEwdsj8r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE52264DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334820; cv=none; b=fsdQAAVU9SDKPV+PeJFkM2WQzwgD1qd3O+VB1VedVubfHcb3TQGonqtG7kBqba37VVLkOEprvmQLZwMbvSdkUjZtynKMQqIdA8n0ZnLFD2CA+IUw6UeCYabqDrkhU01tMw1rFs6r/E4HjZNwCp0ak8cKZQ42Dxh73ZWSxIrvuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334820; c=relaxed/simple;
	bh=tX+A3EmaSS8rn3OgKbgRud59BlcHQJ+KbZ2DJIx1Omw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/+dE0Zc8/NCy1Gkduypj4MIBvLTcxgmcJlP0F9DfA10/ODjQe47MNjDJ1ru0ATOwcRPh+zTbS+ULUR2oWRTo/0OAGHH3+rzDNYiiMgED063HtW7XGNfuLue17AdEhJQPPos1R0T9vlr2ccu4VFftF1jAuHG2caIWdo1B2lJWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zqPcFbLf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jEwdsj8r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zqPcFbLf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jEwdsj8r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC66B2121C;
	Thu, 19 Jun 2025 12:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750334815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDAuEsNXKXygaILSEXeEMNcT2WMigGIcctwMV7a0cE8=;
	b=zqPcFbLfpUQLjy+Nw4cOX/B2LiApdKR7t9DEm9m3vLLybWpiWlFBWTl6QNGFMMJe81DLE6
	1uGk7SLFk0EUnA6QiPQBz3Kv/z1D/ZNALQXlfFywd0PzUqn46btyJOJmbpixQ6uQ0pR4Mz
	lMMpI0foMRv6N403hLovr2WkJq9iRKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750334815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDAuEsNXKXygaILSEXeEMNcT2WMigGIcctwMV7a0cE8=;
	b=jEwdsj8rqU+sAaEm1rAhYOm4nratZdmqMyGOXNSbv1Zh1lQm/lkFeChFWsq3xyo2+/dtFQ
	eI1mhCTdCBSEvaDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750334815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDAuEsNXKXygaILSEXeEMNcT2WMigGIcctwMV7a0cE8=;
	b=zqPcFbLfpUQLjy+Nw4cOX/B2LiApdKR7t9DEm9m3vLLybWpiWlFBWTl6QNGFMMJe81DLE6
	1uGk7SLFk0EUnA6QiPQBz3Kv/z1D/ZNALQXlfFywd0PzUqn46btyJOJmbpixQ6uQ0pR4Mz
	lMMpI0foMRv6N403hLovr2WkJq9iRKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750334815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDAuEsNXKXygaILSEXeEMNcT2WMigGIcctwMV7a0cE8=;
	b=jEwdsj8rqU+sAaEm1rAhYOm4nratZdmqMyGOXNSbv1Zh1lQm/lkFeChFWsq3xyo2+/dtFQ
	eI1mhCTdCBSEvaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB002136CC;
	Thu, 19 Jun 2025 12:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QUQhJlv9U2iXdgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 19 Jun 2025 12:06:51 +0000
Date: Thu, 19 Jun 2025 14:06:49 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Muchun Song <muchun.song@linux.dev>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: update core kernel code to use vm_flags_t
 consistently
Message-ID: <aFP9WQSn2AZbRIb4@localhost.localdomain>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_GT_50(0.00)[64];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,armlinux.org.uk,arm.com,kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,davemloft.net,gaisler.com,linux.intel.com,linutronix.de,redhat.com,alien8.de,zytor.com,infradead.org,zeniv.linux.org.uk,suse.cz,nvidia.com,linux.alibaba.com,oracle.com,zte.com.cn,linux.dev,google.com,suse.com,surriel.com,intel.com,goodmis.org,efficios.com,ziepe.ca,suse.de,cmpxchg.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,oracle.com:email]
X-Spam-Level: 

On Wed, Jun 18, 2025 at 08:42:53PM +0100, Lorenzo Stoakes wrote:
> The core kernel code is currently very inconsistent in its use of
> vm_flags_t vs. unsigned long. This prevents us from changing the type of
> vm_flags_t in the future and is simply not correct, so correct this.
> 
> While this results in rather a lot of churn, it is a critical pre-requisite
> for a future planned change to VMA flag type.
> 
> Additionally, update VMA userland tests to account for the changes.
> 
> To make review easier and to break things into smaller parts, driver and
> architecture-specific changes is left for a subsequent commit.
> 
> The code has been adjusted to cascade the changes across all calling code
> as far as is needed.
> 
> We will adjust architecture-specific and driver code in a subsequent patch.
> 
> Overall, this patch does not introduce any functional change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

Heh, for one second I thought this was about to convert vm_fault->flags to
the actual enum fault_flag (which wouldn't be bad if you ask me, because
"unsigned int flags" is not very descriptive).

But this is quite good as well, brings in some consistency.


-- 
Oscar Salvador
SUSE Labs

