Return-Path: <linux-fsdevel+bounces-60898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9094EB52BB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 10:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF047B60A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402F12E2F14;
	Thu, 11 Sep 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g69g7tVg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Kn9GhCx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rlw8/zRp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="10BqmkcK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3842E2F03
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579579; cv=none; b=qH0ZGu4uuAqDa2Lc1/RBxq5wm3u1tI4tF1Pg+Ao09saGDPy8D+X4t6WbDUfHEiY/pD+zDA2Ed3puBvTVOhvoypuZNaxj+9j79n4Bq9/3h6Pq5UnNpWaFsC3sEuc132Pvlsg7m4QrqrRNXFrhwsBT2z7c3vfMPxP0jVlSJvZTc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579579; c=relaxed/simple;
	bh=Wt8bPfv1U7t3vwNps2XxhADQvg87KCyS3JNBXzZls2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EewuB5f9SH+SvtRPGn6ywmGhxtfWa+PEaV3pe5ks2HlOBS0rSJNYI4HRcFwoFD8WDDnzGV41ulaypjFXw5JP1RltVYGVCZrXbuhKfvWoELj4f4cHGQ9XM8/nGuSgWn/iACv17JiVqQZltq0w+PnFpQwFH5L1zLAIv4AdoDJUSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g69g7tVg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Kn9GhCx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rlw8/zRp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=10BqmkcK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0ADD6860C;
	Thu, 11 Sep 2025 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757579570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pePLUMNa380skWZ7luqeNYuVXr6xGvhkxPkdStUqzL8=;
	b=g69g7tVggGA4ICLcQNCp2a7FDFhEJgYZx+rlhxptW3OatO+qLAsjc1gwFiT3lagr6ckCae
	W/ELmYo2UvyoKHg55pepNIQTqKprdkRGz8wGK2RCoVMTIvYZ7hOjyPCUfmPF892jrcts8m
	6yQx2w5csZ75W+co3a197Outu6bRzj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757579570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pePLUMNa380skWZ7luqeNYuVXr6xGvhkxPkdStUqzL8=;
	b=0Kn9GhCxwfH7UtNWm0rPiTVf56F7jJTb27XMxMZrnkmLNlf+ZBZNmnvPfhGPo2lW5NDk33
	Sh850po/Fb1oOjBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Rlw8/zRp";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=10BqmkcK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757579569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pePLUMNa380skWZ7luqeNYuVXr6xGvhkxPkdStUqzL8=;
	b=Rlw8/zRpNMaso5w9hJU5rsFvLwdqP79gThQ0ptKrbOk16/q7H+vryA9mjmyFasd5sko7gs
	kv2NB3QC3scH9aY6Yti/UmBGb0kXexhPBDR988HTBztTRbzI55KnYlKO3eIddsjqaZcBgT
	EFQBO91Cut+OCVyQ+KCEaNZyRP2OCtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757579569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pePLUMNa380skWZ7luqeNYuVXr6xGvhkxPkdStUqzL8=;
	b=10BqmkcKUZL1Wc7BX4XLQc3Xzt89ZfORi8DPbmWNfCdmEsWQqWW8TCaGQojxjk/Owp6q9B
	PFZSurPaXwnOuJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B32A31372E;
	Thu, 11 Sep 2025 08:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5xutKzGJwmhAcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Sep 2025 08:32:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3E12AA0A2D; Thu, 11 Sep 2025 10:32:49 +0200 (CEST)
Date: Thu, 11 Sep 2025 10:32:49 +0200
From: Jan Kara <jack@suse.cz>
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
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org, 
	ntfs3@lists.linux.dev, kexec@lists.infradead.org, kasan-dev@googlegroups.com, 
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 01/16] mm/shmem: update shmem to use mmap_prepare
Message-ID: <4lfedpbfjq6yexryq4jmdoycky762ewmw2thjm2h6wzgqda46a@p3wzpxlhe7ka>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <c328d14480808cb0e136db8090f2a203ade72233.1757534913.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c328d14480808cb0e136db8090f2a203ade72233.1757534913.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,infradead.org,kernel.org,alpha.franken.de,linux.ibm.com,davemloft.net,gaisler.com,arndb.de,linuxfoundation.org,intel.com,fluxnic.net,linux.dev,suse.de,redhat.com,paragon-software.com,arm.com,zeniv.linux.org.uk,suse.cz,oracle.com,google.com,suse.com,linux.alibaba.com,gmail.com,vger.kernel.org,lists.linux.dev,kvack.org,lists.infradead.org,googlegroups.com,nvidia.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_GT_50(0.00)[59];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C0ADD6860C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Wed 10-09-25 21:21:56, Lorenzo Stoakes wrote:
> This simply assigns the vm_ops so is easily updated - do so.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 45e7733d6612..990e33c6a776 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2938,16 +2938,17 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
>  	return retval;
>  }
>  
> -static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
> +static int shmem_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *file = desc->file;
>  	struct inode *inode = file_inode(file);
>  
>  	file_accessed(file);
>  	/* This is anonymous shared memory if it is unlinked at the time of mmap */
>  	if (inode->i_nlink)
> -		vma->vm_ops = &shmem_vm_ops;
> +		desc->vm_ops = &shmem_vm_ops;
>  	else
> -		vma->vm_ops = &shmem_anon_vm_ops;
> +		desc->vm_ops = &shmem_anon_vm_ops;
>  	return 0;
>  }
>  
> @@ -5217,7 +5218,7 @@ static const struct address_space_operations shmem_aops = {
>  };
>  
>  static const struct file_operations shmem_file_operations = {
> -	.mmap		= shmem_mmap,
> +	.mmap_prepare	= shmem_mmap_prepare,
>  	.open		= shmem_file_open,
>  	.get_unmapped_area = shmem_get_unmapped_area,
>  #ifdef CONFIG_TMPFS
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

