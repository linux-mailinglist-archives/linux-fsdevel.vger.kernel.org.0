Return-Path: <linux-fsdevel+bounces-76613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDzCOnMhhmm/JwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:14:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5752100D2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA6423015888
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342F36C0C7;
	Fri,  6 Feb 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j6+Jb2DU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+WIS4NGb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j6+Jb2DU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+WIS4NGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB5394481
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398059; cv=none; b=mGXb40CCeJM3tgGtvvhFXPNzzWDTVJzhOjuYNkkdz8Wlq/SaVHvRX0pO+z6s7go80xJn5/GCOMzQUSVfVVROMtfdIClo9z9RT+p0c27nOPPyR6R0jo+/AHg58FguVzi5i93n3hYLm+PLINbfTfehHvtQ6wa22NSpNLoJ8WP5gPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398059; c=relaxed/simple;
	bh=ZaPA4IVGv1P2f7H8LUzd/o2aHJRlJB3S1X08XBrb4Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA2OI7/V/AX3DiawphiApwBCtX5fQuQDoj58o0NcWX52oDP06EZqXu3GOzFqq9R/Ku8D9eA6jBAcP/W4NVEYn6uygc0vRuPN6V2I9x0IGo2CrkK0Zf0xjkuYhaeAC5HsBEJtpkTx/uxObDQafazhZ1NkotVH09VUvyvPo052Tb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j6+Jb2DU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+WIS4NGb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j6+Jb2DU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+WIS4NGb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 150CF3E6C2;
	Fri,  6 Feb 2026 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770398057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z73YqVi28uxxhcm78/EYnmwbNwCl8FOdS0dwqPt0f7Y=;
	b=j6+Jb2DUNuDTgyLkT8P3dkpO+CJ+tX2ecLNPiO/pp8qkcSVNK3jHeQUyaXVLnlnuRI5B8n
	0Va0mO+M0DejOC8cpnGzBuSoJ1/HWdb+y9LnG5gNjyig2YXtshRMvCrzsFY6HvX87PYZvf
	RmxhKvO5BrRs04UEmzHFp1pv1EJEWV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770398057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z73YqVi28uxxhcm78/EYnmwbNwCl8FOdS0dwqPt0f7Y=;
	b=+WIS4NGbvV7/KSSc7+n9BNQHqhpKwo39WaYXAKAf/VXJOO7yQy2+H2qFwF+pyT/DpmqW4z
	KMiDKgBB2zApEGDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j6+Jb2DU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+WIS4NGb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770398057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z73YqVi28uxxhcm78/EYnmwbNwCl8FOdS0dwqPt0f7Y=;
	b=j6+Jb2DUNuDTgyLkT8P3dkpO+CJ+tX2ecLNPiO/pp8qkcSVNK3jHeQUyaXVLnlnuRI5B8n
	0Va0mO+M0DejOC8cpnGzBuSoJ1/HWdb+y9LnG5gNjyig2YXtshRMvCrzsFY6HvX87PYZvf
	RmxhKvO5BrRs04UEmzHFp1pv1EJEWV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770398057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z73YqVi28uxxhcm78/EYnmwbNwCl8FOdS0dwqPt0f7Y=;
	b=+WIS4NGbvV7/KSSc7+n9BNQHqhpKwo39WaYXAKAf/VXJOO7yQy2+H2qFwF+pyT/DpmqW4z
	KMiDKgBB2zApEGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFB943EA63;
	Fri,  6 Feb 2026 17:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ztnsLmMhhmm+LAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 06 Feb 2026 17:14:11 +0000
Date: Fri, 6 Feb 2026 17:14:10 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
	Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	devel@lists.orangefs.org, linux-xfs@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 03/13] mm: add mk_vma_flags() bitmap flag macro helper
Message-ID: <mflwgdnyipdf4reufmbx7qarjcgouct5coe2bllticrabcu6rt@vf3bvmpunimw>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <fde00df6ff7fb8c4b42cc0defa5a4924c7a1943a.1769097829.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde00df6ff7fb8c4b42cc0defa5a4924c7a1943a.1769097829.git.lorenzo.stoakes@oracle.com>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76613-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[93];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,suse.de:email,suse.de:dkim,oracle.com:email]
X-Rspamd-Queue-Id: A5752100D2F
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:06:12PM +0000, Lorenzo Stoakes wrote:
> This patch introduces the mk_vma_flags() macro helper to allow easy
> manipulation of VMA flags utilising the new bitmap representation
> implemented of VMA flags defined by the vma_flags_t type.
> 
> It is a variadic macro which provides a bitwise-or'd representation of all
> of each individual VMA flag specified.
> 
> Note that, while we maintain VM_xxx flags for backwards compatibility until
> the conversion is complete, we define VMA flags of type vma_flag_t using
> VMA_xxx_BIT to avoid confusing the two.
> 
> This helper macro therefore can be used thusly:
> 
> vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT);
> 
> We allow for up to 5 flags to specified at a time which should accommodate
> all current kernel uses of combined VMA flags.
>

How do you allow up to 5 flags? I don't see any such limitation in the code?
 
> Testing has demonstrated that the compiler optimises this code such that it
> generates the same assembly utilising this macro as it does if the flags
> were specified manually, for instance:
> 
> vma_flags_t get_flags(void)
> {
> 	return mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> }
> 
> Generates the same code as:
> 
> vma_flags_t get_flags(void)
> {
> 	vma_flags_t flags;
> 
> 	vma_flags_clear_all(&flags);
> 	vma_flag_set(&flags, VMA_READ_BIT);
> 	vma_flag_set(&flags, VMA_WRITE_BIT);
> 	vma_flag_set(&flags, VMA_EXEC_BIT);
> 
> 	return flags;
> }
> 
> And:
> 
> vma_flags_t get_flags(void)
> {
> 	vma_flags_t flags;
> 	unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
> 
> 	*bitmap = 1UL << (__force int)VMA_READ_BIT;
> 	*bitmap |= 1UL << (__force int)VMA_WRITE_BIT;
> 	*bitmap |= 1UL << (__force int)VMA_EXEC_BIT;
> 
> 	return flags;
> }
> 
> That is:
> 
> get_flags:
>         movl    $7, %eax
>         ret
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

