Return-Path: <linux-fsdevel+bounces-61922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44323B7CCE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE413B71E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711D36997B;
	Wed, 17 Sep 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fxQsuJDb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MQ0cdVXu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fxQsuJDb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MQ0cdVXu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE93369987
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108747; cv=none; b=By8XOACyU5XuCbKT0oLjWIncQTaZCWo31IbSv1/6cWWqiVgZEOHhz14zFNVA/S3b8xP/hkewkGnG7wlL5Xf/MFCxxwug9sjRDyJNaaAGrnUHT574I90/CoV3lpKKHeIfI8fOWJ1zT5LwONEo9YGLM9PKOJ8FIjyPdU+GD+df0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108747; c=relaxed/simple;
	bh=3LlU8D5Tj8BOKkc9McIo8H1J7S9pib7vCnIKwhUAK1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6Je9Qi8RaTk5WuYo3YnDvdQJ4ic0S9nFfEn/X3MUriBVgEc0aiSLXw7kI5VPzHOlPzZe+QjB2J0aCx81mmoh5J28JTrgVywYAAhBHPGpvGyrY/l7q/5cN+HVw9LSlyC7ywa2Rsg9mLNhongWEGrkEoVXU/F8f1K7TRGiVkDw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fxQsuJDb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MQ0cdVXu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fxQsuJDb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MQ0cdVXu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99E6921D3E;
	Wed, 17 Sep 2025 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758108739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ap5mPSoqW5VngVWaJTgyJfGx7MJPhwio1kMAlldw6U=;
	b=fxQsuJDbFPJ+Aq2i2N1EojNI/Hd1bpt5cNweVpv6AUqFIxUOJbm2qY66huYbwL8Tm3GUz5
	SwH8SBvGIvkqn12PaatbE30ebxk6Fodkbs4w5BuVb54khNk0vMRWP/YIASKCUV0kXQR0cJ
	CDZdoO2GTvamVOJk2LCTJZWR9rZcfqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758108739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ap5mPSoqW5VngVWaJTgyJfGx7MJPhwio1kMAlldw6U=;
	b=MQ0cdVXu/Fgwg2bcVUOI0ttAv/c4z/ykaLMQuBWxTsaAFW5ZdcGVoWzN/qQnuXyDWnG4qD
	lXTBNkGr95Rj2EDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758108739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ap5mPSoqW5VngVWaJTgyJfGx7MJPhwio1kMAlldw6U=;
	b=fxQsuJDbFPJ+Aq2i2N1EojNI/Hd1bpt5cNweVpv6AUqFIxUOJbm2qY66huYbwL8Tm3GUz5
	SwH8SBvGIvkqn12PaatbE30ebxk6Fodkbs4w5BuVb54khNk0vMRWP/YIASKCUV0kXQR0cJ
	CDZdoO2GTvamVOJk2LCTJZWR9rZcfqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758108739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ap5mPSoqW5VngVWaJTgyJfGx7MJPhwio1kMAlldw6U=;
	b=MQ0cdVXu/Fgwg2bcVUOI0ttAv/c4z/ykaLMQuBWxTsaAFW5ZdcGVoWzN/qQnuXyDWnG4qD
	lXTBNkGr95Rj2EDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 202B113A92;
	Wed, 17 Sep 2025 11:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GSeHBECcymi0TAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 17 Sep 2025 11:32:16 +0000
Date: Wed, 17 Sep 2025 12:32:10 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	kexec@lists.infradead.org, kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>, 
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 08/13] mm: add ability to take further action in
 vm_area_desc
Message-ID: <wabzfghapygwy3fzexbplmasrdzttt3nsgpmoj4kr6g7ldstkg@tthpx7de6tqk>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <9171f81e64fcb94243703aa9a7da822b5f2ff302.1758031792.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9171f81e64fcb94243703aa9a7da822b5f2ff302.1758031792.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,infradead.org,kernel.org,alpha.franken.de,linux.ibm.com,davemloft.net,gaisler.com,arndb.de,linuxfoundation.org,intel.com,fluxnic.net,linux.dev,suse.de,redhat.com,paragon-software.com,arm.com,zeniv.linux.org.uk,suse.cz,oracle.com,google.com,suse.com,linux.alibaba.com,gmail.com,vger.kernel.org,lists.linux.dev,kvack.org,lists.infradead.org,googlegroups.com,nvidia.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Tue, Sep 16, 2025 at 03:11:54PM +0100, Lorenzo Stoakes wrote:
> Some drivers/filesystems need to perform additional tasks after the VMA is
> set up.  This is typically in the form of pre-population.
> 
> The forms of pre-population most likely to be performed are a PFN remap
> or the insertion of normal folios and PFNs into a mixed map.
> 
> We start by implementing the PFN remap functionality, ensuring that we
> perform the appropriate actions at the appropriate time - that is setting
> flags at the point of .mmap_prepare, and performing the actual remap at the
> point at which the VMA is fully established.
> 
> This prevents the driver from doing anything too crazy with a VMA at any
> stage, and we retain complete control over how the mm functionality is
> applied.
> 
> Unfortunately callers still do often require some kind of custom action,
> so we add an optional success/error _hook to allow the caller to do
> something after the action has succeeded or failed.

Do we have any idea for rules regarding ->mmap_prepare() and ->*_hook()?
It feels spooky to e.g grab locks in mmap_prepare, and hold them across core
mmap(). And I guess it might be needed?

> 
> This is done at the point when the VMA has already been established, so
> the harm that can be done is limited.
> 
> The error hook can be used to filter errors if necessary.
> 
> If any error arises on these final actions, we simply unmap the VMA
> altogether.
> 
> Also update the stacked filesystem compatibility layer to utilise the
> action behaviour, and update the VMA tests accordingly.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
<snip>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 31b27086586d..aa1e2003f366 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -775,6 +775,49 @@ struct pfnmap_track_ctx {
>  };
>  #endif
>  
> +/* What action should be taken after an .mmap_prepare call is complete? */
> +enum mmap_action_type {
> +	MMAP_NOTHING,		/* Mapping is complete, no further action. */
> +	MMAP_REMAP_PFN,		/* Remap PFN range. */
> +};
> +
> +/*
> + * Describes an action an mmap_prepare hook can instruct to be taken to complete
> + * the mapping of a VMA. Specified in vm_area_desc.
> + */
> +struct mmap_action {
> +	union {
> +		/* Remap range. */
> +		struct {
> +			unsigned long start;
> +			unsigned long start_pfn;
> +			unsigned long size;
> +			pgprot_t pgprot;
> +			bool is_io_remap;
> +		} remap;
> +	};
> +	enum mmap_action_type type;
> +
> +	/*
> +	 * If specified, this hook is invoked after the selected action has been
> +	 * successfully completed. Note that the VMA write lock still held.
> +	 *
> +	 * The absolute minimum ought to be done here.
> +	 *
> +	 * Returns 0 on success, or an error code.
> +	 */
> +	int (*success_hook)(const struct vm_area_struct *vma);
> +
> +	/*
> +	 * If specified, this hook is invoked when an error occurred when
> +	 * attempting the selection action.
> +	 *
> +	 * The hook can return an error code in order to filter the error, but
> +	 * it is not valid to clear the error here.
> +	 */
> +	int (*error_hook)(int err);

Do we need two hooks? It might be more ergonomic to simply have a:

	int (*finish)(int err);


	int random_driver_finish(int err)
	{
		if (err)
			pr_err("ahhhhhhhhh\n");
		mutex_unlock(&big_lock);
		return err;
	}

It's also unclear to me if/why we need the capability to switch error codes,
but I might've missed some discussion on this.


-- 
Pedro

