Return-Path: <linux-fsdevel+bounces-60903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64071B52C54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 10:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72D43B550A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A782E62A1;
	Thu, 11 Sep 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H06dORKL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0iIQ+Ipq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H06dORKL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0iIQ+Ipq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF162E6CD0
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580951; cv=none; b=KBuOy0wWUEKz4W/iErRdUnyoIezX5ilx6vdwvRm7Y61cFB9OEGcnKZ6OciQ+j7qddPKEK9H4BFZkTaoFjcwyz/jg8Daa4uLCWBmwak8X8ZGkXDuCxXBYX/LwfqpYQW8EQdOehogXCqhQ+T+nSvEamxR+MuYwGzzt5pUmCTlsS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580951; c=relaxed/simple;
	bh=g8rjLkGZDz8l75aKfZa7HlbA3xNuO5qdMG27VMFj5qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH6c+7vlQtPGXrmmdk/Me741r0z463L8hbIChmeS5fh0MpccpgAc8v37hJDn9Uyyt4T4Vd51ZI7H/DMbsvRcOrSpNbrhB9EEq759SAZE6fMwibf3UxOtqOfw9lL1alHmMY6g2Si3Is8CqONNxDmpIt08Bbi1ovqn+eLoIMFhRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H06dORKL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0iIQ+Ipq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H06dORKL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0iIQ+Ipq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF3946864B;
	Thu, 11 Sep 2025 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757580946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+JbXqJwzf7cOodAKH9xqcseUyaAMBde80ixVE0ZgKU=;
	b=H06dORKLeqy9oLKCwBAyy8KbyMMgBGmw2umEdwRHB5t4//gwrPu6p/UqepgBh+cqtCMGYj
	gu16/N0MH0OUE8I2dmmLR/foB3LQlqym6FvW7Qq9xnnjWKvZeFtm5D+PPNO1HxnjqxADHx
	R9Jg+XWpXeRhDFWLoByfZA9usPYkdhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757580946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+JbXqJwzf7cOodAKH9xqcseUyaAMBde80ixVE0ZgKU=;
	b=0iIQ+Ipqu9W5Px/nULTByH8LjK8QRRM8NgGXedpdy+DrzCu/JG3h5fU1YWI+FWRaeWdOMk
	PDTOzamFaGTIDVCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H06dORKL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0iIQ+Ipq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757580946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+JbXqJwzf7cOodAKH9xqcseUyaAMBde80ixVE0ZgKU=;
	b=H06dORKLeqy9oLKCwBAyy8KbyMMgBGmw2umEdwRHB5t4//gwrPu6p/UqepgBh+cqtCMGYj
	gu16/N0MH0OUE8I2dmmLR/foB3LQlqym6FvW7Qq9xnnjWKvZeFtm5D+PPNO1HxnjqxADHx
	R9Jg+XWpXeRhDFWLoByfZA9usPYkdhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757580946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+JbXqJwzf7cOodAKH9xqcseUyaAMBde80ixVE0ZgKU=;
	b=0iIQ+Ipqu9W5Px/nULTByH8LjK8QRRM8NgGXedpdy+DrzCu/JG3h5fU1YWI+FWRaeWdOMk
	PDTOzamFaGTIDVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B13C613974;
	Thu, 11 Sep 2025 08:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4H7vKpKOwmjqeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Sep 2025 08:55:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5F916A0A2D; Thu, 11 Sep 2025 10:55:42 +0200 (CEST)
Date: Thu, 11 Sep 2025 10:55:42 +0200
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
Subject: Re: [PATCH v2 09/16] doc: update porting, vfs documentation for
 mmap_prepare actions
Message-ID: <xbz56k25ftkjbjpjpslqad5b77klaxg3ganckhbnwe3mf6vtpy@3ytagvaq4gk5>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <e50e91a6f6173f81addb838c5049bed2833f7b0d.1757534913.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e50e91a6f6173f81addb838c5049bed2833f7b0d.1757534913.git.lorenzo.stoakes@oracle.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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
X-Rspamd-Queue-Id: BF3946864B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Wed 10-09-25 21:22:04, Lorenzo Stoakes wrote:
> Now we have introduced the ability to specify that actions should be taken
> after a VMA is established via the vm_area_desc->action field as specified
> in mmap_prepare, update both the VFS documentation and the porting guide to
> describe this.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/porting.rst | 5 +++++
>  Documentation/filesystems/vfs.rst     | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 85f590254f07..6743ed0b9112 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1285,3 +1285,8 @@ rather than a VMA, as the VMA at this stage is not yet valid.
>  The vm_area_desc provides the minimum required information for a filesystem
>  to initialise state upon memory mapping of a file-backed region, and output
>  parameters for the file system to set this state.
> +
> +In nearly all cases, this is all that is required for a filesystem. However, if
> +a filesystem needs to perform an operation such a pre-population of page tables,
> +then that action can be specified in the vm_area_desc->action field, which can
> +be configured using the mmap_action_*() helpers.
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 486a91633474..9e96c46ee10e 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1236,6 +1236,10 @@ otherwise noted.
>  	file-backed memory mapping, most notably establishing relevant
>  	private state and VMA callbacks.
>  
> +	If further action such as pre-population of page tables is required,
> +	this can be specified by the vm_area_desc->action field and related
> +	parameters.
> +
>  Note that the file operations are implemented by the specific
>  filesystem in which the inode resides.  When opening a device node
>  (character or block special) most filesystems will call special
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

