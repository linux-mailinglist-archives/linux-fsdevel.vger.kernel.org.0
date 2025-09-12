Return-Path: <linux-fsdevel+bounces-61040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE44EB54A59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E373A4F63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528B9301026;
	Fri, 12 Sep 2025 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pIhrbsz6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3KzBQV3s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pIhrbsz6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3KzBQV3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163D2FE576
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674116; cv=none; b=Smx14jtQPOc3L1SULjCUDYkvMqqqZDABbEdns8P+B0wLz9Clh3VDEtqTVk3sXYY+HCN2ZWuOIF+4GNVyrGuo3q64sBKPu3UUJL3PCiYhJiW92IbMocMkjbj+rr2bJQJSR8uBlrCqktI5eKFL1XBFU1YTCJrwyJjLCdur/iS6eW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674116; c=relaxed/simple;
	bh=xj8SKsDc1sxZr1H/BYrv7BC55oRBLD49zCpgs1E0VxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlxEWChwka4EN0HfBxcY0Bgf2Oh2+PGmbQj18NZRTLNEfD6zbusyBBx/rKJgjZOstCwxrh8XHby4PvT2oVR5vvDtTW3kLStyOl9coldZF+qOj5HNlSHPwjz1DMFKzX0OHxUE57YRhzf5OFjhqbw+d0xRjmCOnWFY9ttOAm1YIyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pIhrbsz6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3KzBQV3s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pIhrbsz6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3KzBQV3s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A1A220760;
	Fri, 12 Sep 2025 10:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757674110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWphaHK8OZGZX1V68Y5uJkPgW2mcaEuIYhBomIwfjhY=;
	b=pIhrbsz6PFEg2rsKfYIDk9LSisUudy3RRRF+vPTEdTVNBEc/IYjMGMRlHJPMd81a3PeAPQ
	enViOBHkrPb/ixVfVxnLyPU7+6VjTklFYkyeXlsUfBRq5C+jV7UXdmEmLyAdx4Q3d4ezXR
	1O/cIWn77hOKnup2fdLIdwqygTz6oOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757674110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWphaHK8OZGZX1V68Y5uJkPgW2mcaEuIYhBomIwfjhY=;
	b=3KzBQV3sfhI2xmW0tXlMKSTmNI2mUbzMU7tkf31yqUEPagskAIo4a6mTeoFEttV9DasuS1
	kLhxxYyMXH7/23Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757674110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWphaHK8OZGZX1V68Y5uJkPgW2mcaEuIYhBomIwfjhY=;
	b=pIhrbsz6PFEg2rsKfYIDk9LSisUudy3RRRF+vPTEdTVNBEc/IYjMGMRlHJPMd81a3PeAPQ
	enViOBHkrPb/ixVfVxnLyPU7+6VjTklFYkyeXlsUfBRq5C+jV7UXdmEmLyAdx4Q3d4ezXR
	1O/cIWn77hOKnup2fdLIdwqygTz6oOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757674110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWphaHK8OZGZX1V68Y5uJkPgW2mcaEuIYhBomIwfjhY=;
	b=3KzBQV3sfhI2xmW0tXlMKSTmNI2mUbzMU7tkf31yqUEPagskAIo4a6mTeoFEttV9DasuS1
	kLhxxYyMXH7/23Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C11E13869;
	Fri, 12 Sep 2025 10:48:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RcKSHnn6w2gcWwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 12 Sep 2025 10:48:25 +0000
Date: Fri, 12 Sep 2025 11:48:15 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "Cali, Marco" <xmarcalx@amazon.co.uk>, 
	"derekmn@amazon.co.uk" <derekmn@amazon.co.uk>, Elliot Berman <quic_eberman@quicinc.com>, 
	"willy@infradead.org" <willy@infradead.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "maz@kernel.org" <maz@kernel.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "joey.gouly@arm.com" <joey.gouly@arm.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "alex@ghiti.fr" <alex@ghiti.fr>, 
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "trondmy@kernel.org" <trondmy@kernel.org>, 
	"anna@kernel.org" <anna@kernel.org>, "hubcap@omnibond.com" <hubcap@omnibond.com>, 
	"martin@omnibond.com" <martin@omnibond.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"peterx@redhat.com" <peterx@redhat.com>, "jannh@google.com" <jannh@google.com>, 
	"axelrasmussen@google.com" <axelrasmussen@google.com>, "yuanchu@google.com" <yuanchu@google.com>, 
	"weixugc@google.com" <weixugc@google.com>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, 
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"shuah@kernel.org" <shuah@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "devel@lists.orangefs.org" <devel@lists.orangefs.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v6 01/11] filemap: Pass address_space mapping to
 ->free_folio()
Message-ID: <2w22wsqar437lyp3w4bltyoql4ksn3exppkyaia5ogtnt2ttte@6nptj6ed4qnm>
References: <20250912091708.17502-1-roypat@amazon.co.uk>
 <20250912091708.17502-2-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912091708.17502-2-roypat@amazon.co.uk>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amazon.co.uk,quicinc.com,infradead.org,lwn.net,redhat.com,kernel.org,linux.dev,arm.com,huawei.com,xen0n.name,sifive.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,linux.ibm.com,linux.intel.com,linutronix.de,alien8.de,zytor.com,omnibond.com,zeniv.linux.org.uk,suse.cz,linux-foundation.org,oracle.com,google.com,suse.com,iogearbox.net,gmail.com,fomichev.me,ziepe.ca,nvidia.com,cmpxchg.org,bytedance.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.orangefs.org,kvack.org];
	R_RATELIMIT(0.00)[to_ip_from(RL1bpf5rdkmpo98mj6oa9xanz3)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[89];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Fri, Sep 12, 2025 at 09:17:31AM +0000, Roy, Patrick wrote:
> From: Elliot Berman <quic_eberman@quicinc.com>
> 
> When guest_memfd removes memory from the host kernel's direct map,
> direct map entries must be restored before the memory is freed again. To
> do so, ->free_folio() needs to know whether a gmem folio was direct map
> removed in the first place though. While possible to keep track of this
> information on each individual folio (e.g. via page flags), direct map
> removal is an all-or-nothing property of the entire guest_memfd, so it
> is less error prone to just check the flag stored in the gmem inode's
> private data.  However, by the time ->free_folio() is called,
> folio->mapping might be cleared. To still allow access to the address
> space from which the folio was just removed, pass it in as an additional
> argument to ->free_folio, as the mapping is well-known to all callers.
> 
> Link: https://lore.kernel.org/all/15f665b4-2d33-41ca-ac50-fafe24ade32f@redhat.com/
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> [patrick: rewrite shortlog for new usecase]
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

