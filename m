Return-Path: <linux-fsdevel+bounces-52353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3878FAE2279
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C915A33C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769D2EB5C6;
	Fri, 20 Jun 2025 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="opqTY6rV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UHwMVx9q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fkd/YI/g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cs31g/h9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5E2DF3F2
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445271; cv=none; b=WH1c8DkmTPWHFCR3LgIv6FSGFGNJTqjXUQ4iZLr5u1wi3BXupFbeH4y/3Rh8iy+pl+ZttzzHVzffqTmTgnJzAZL/Vvb7ujFvgb6BxhWtS+tI0anaKu6x23J44k03qGGSOQkJoqhMVU3AycCWSAKY5YUGYza2EKI1iq5JeomeaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445271; c=relaxed/simple;
	bh=UkSq0fLNLsqjoFI1txGN3Er15wk0Qmlg1qteqpp9D04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zsxs7EX8RLWwwk3Vodu3JvqDp+IQcX1VfWnVoPYNJmo0mdzmC0DA2AfHI2+YTflQWjWIYyfeExzSMbDLdeBzXjois2HFLphbBk3NR9xdZ5IqxsVT4UBnVMb09gSdN8GZlAOiXVljkX4f/P1Y70kotTyedj1y77h2aLg7978BNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=opqTY6rV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UHwMVx9q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fkd/YI/g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cs31g/h9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A809B21242;
	Fri, 20 Jun 2025 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750445268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdGXHg252LprOjpKH/EIdhIXzV+kTcVrHpA36qrGf5c=;
	b=opqTY6rVjgPqVSWo/M8ooc1HQgFiOJsDNkOy8kF5+XrFjxcjDAXxEX/jwoE4BoU2w1ioFm
	lY/ZwSj3ozuqx0ptG1+XfsKLRGcLkYKgfbSy5SoFn3kjYqzQ4Rq/FhxRnKnLR+JyHFVPlu
	KF3PgQVb1p/NCoqmdSYHQHnFkKaQ+4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750445268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdGXHg252LprOjpKH/EIdhIXzV+kTcVrHpA36qrGf5c=;
	b=UHwMVx9qdXr4OB0EqnU5ny5zQedq9zeYd1Mo7ktfj/9jLQzf4ctPPu1fzL1uuFM1WmaLG/
	UiWBnrykgXnpHiCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Fkd/YI/g";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="cs31g/h9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750445267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdGXHg252LprOjpKH/EIdhIXzV+kTcVrHpA36qrGf5c=;
	b=Fkd/YI/gyyM5XoCtR2ZhOXHn5LYJ7D+XgmtL+bTWU0cU1eHIjiJvJj/EIVvbq2BwpijqCX
	nm+6/j8xQFgAGx/AjTvAY3uS8Stnb4Y0Xrsz/6FcHehTkG3NjYekWQA3u+TfPmq47jGB27
	6IdfMZQpoVDSAiZQP9tgSnY7sBFfsoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750445267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdGXHg252LprOjpKH/EIdhIXzV+kTcVrHpA36qrGf5c=;
	b=cs31g/h9XLMUdzoYrkGsCI+qfsKVSkW2MXzJgjUOvbTzUCoKZrOMCBI46olVokSqPuEj+Q
	ZQcB1bC3fMeW8zCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E64A136BA;
	Fri, 20 Jun 2025 18:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fbg6CNCsVWhBFwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 20 Jun 2025 18:47:44 +0000
Date: Fri, 20 Jun 2025 19:47:42 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: update architecture and driver code to use
 vm_flags_t
Message-ID: <qmzp2tygyt3enoqn5ozqjtolxo5f6lnphc52p3s5zfjlzjxijp@4vcvnz67alhb>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <b6eb1894abc5555ece80bb08af5c022ef780c8bc.1750274467.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6eb1894abc5555ece80bb08af5c022ef780c8bc.1750274467.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email,suse.de:dkim,suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,armlinux.org.uk,arm.com,kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,davemloft.net,gaisler.com,linux.intel.com,linutronix.de,redhat.com,alien8.de,zytor.com,infradead.org,zeniv.linux.org.uk,suse.cz,nvidia.com,linux.alibaba.com,oracle.com,zte.com.cn,linux.dev,google.com,suse.com,surriel.com,intel.com,goodmis.org,efficios.com,ziepe.ca,suse.de,cmpxchg.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org,lists.linux.dev];
	URIBL_BLOCKED(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_GT_50(0.00)[64];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A809B21242
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Wed, Jun 18, 2025 at 08:42:54PM +0100, Lorenzo Stoakes wrote:
> In future we intend to change the vm_flags_t type, so it isn't correct for
> architecture and driver code to assume it is unsigned long. Correct this
> assumption across the board.
> 
> Overall, this patch does not introduce any functional change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

