Return-Path: <linux-fsdevel+bounces-60525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0920DB48F7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E5A3BED24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7DF30B52A;
	Mon,  8 Sep 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYx/uSMK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t1Swnl+g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYx/uSMK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t1Swnl+g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A230AD14
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338082; cv=none; b=tbOV4SRtYPl1DktGHG064UpctHfUbnWRcN5DX1jMuG+wAUlBJ1PDpafkCWnwCs35HTMeBBy68aFkWBmH7Y1o71DbO8RVPdnNSUmek38JjUzGUIldmbKP7sIVcUBdaA1DkkADN+DJHVfAYB0De4xDI9evXdLALi3lomwciqK+7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338082; c=relaxed/simple;
	bh=3NuZHuWavGTEUi3BJcATVrjMx5q3mp7O6Qz/5eB+5qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7ARjbFiFBhIzE9Wzl/pXnOwtfcwVQ+D3g8qcQmZJ77doE6QiiGC6jfWuNANTldhSHDiB3lWQmOfJwhEaPKfJqv15C3DnLcrjwg+Fi2QnvCyEN9vmFhwkqtCmMF2dQGNYeogTyKEeZTnsEm5/VcZ7U8eZqlfXw6krOOy316NFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYx/uSMK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t1Swnl+g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYx/uSMK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t1Swnl+g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF63722DD1;
	Mon,  8 Sep 2025 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757338076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSVOtvPeLvl+UpiPHTfFfgs/48zgcwZMdviTSnSO1lU=;
	b=cYx/uSMK2A3DGDZ7TNOfQK3Uw4Cnr4tafssGbvydao6dVVTNSMNpNmXGpnpYXK0RKrGFGG
	tGKL9q9yMAhxYLYC/q0jqSX2kCTKg9JXcZ3K5d9mLvyXBUQ/hKQsjJT3JvCx+uZTTZHaj9
	L6LPPRpDwKVHOOE13MCt03I/wp2N8qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757338076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSVOtvPeLvl+UpiPHTfFfgs/48zgcwZMdviTSnSO1lU=;
	b=t1Swnl+grxLeVumVUu6SGztBl3gE1HBPnEcUwN0LuhFPZDSZgJUJIIGAzbR4MQtFCXVwn0
	XufWqwk1yayrETCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757338076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSVOtvPeLvl+UpiPHTfFfgs/48zgcwZMdviTSnSO1lU=;
	b=cYx/uSMK2A3DGDZ7TNOfQK3Uw4Cnr4tafssGbvydao6dVVTNSMNpNmXGpnpYXK0RKrGFGG
	tGKL9q9yMAhxYLYC/q0jqSX2kCTKg9JXcZ3K5d9mLvyXBUQ/hKQsjJT3JvCx+uZTTZHaj9
	L6LPPRpDwKVHOOE13MCt03I/wp2N8qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757338076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSVOtvPeLvl+UpiPHTfFfgs/48zgcwZMdviTSnSO1lU=;
	b=t1Swnl+grxLeVumVUu6SGztBl3gE1HBPnEcUwN0LuhFPZDSZgJUJIIGAzbR4MQtFCXVwn0
	XufWqwk1yayrETCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B946B13A54;
	Mon,  8 Sep 2025 13:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ww7hLNzZvmjeNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 13:27:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4EBA2A0A2D; Mon,  8 Sep 2025 15:27:52 +0200 (CEST)
Date: Mon, 8 Sep 2025 15:27:52 +0200
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
Subject: Re: [PATCH 00/16] expand mmap_prepare functionality, port more users
Message-ID: <tyoifr2ym3pzx4nwqhdwap57us3msusbsmql7do4pim5ku7qtm@wjyvh5bs633s>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,infradead.org,kernel.org,alpha.franken.de,linux.ibm.com,davemloft.net,gaisler.com,arndb.de,linuxfoundation.org,intel.com,fluxnic.net,linux.dev,suse.de,redhat.com,paragon-software.com,arm.com,zeniv.linux.org.uk,suse.cz,oracle.com,google.com,suse.com,linux.alibaba.com,gmail.com,vger.kernel.org,lists.linux.dev,kvack.org,lists.infradead.org,googlegroups.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

Hi Lorenzo!

On Mon 08-09-25 12:10:31, Lorenzo Stoakes wrote:
> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), The f_op->mmap hook has been deprecated in favour of
> f_op->mmap_prepare.
> 
> This was introduced in order to make it possible for us to eventually
> eliminate the f_op->mmap hook which is highly problematic as it allows
> drivers and filesystems raw access to a VMA which is not yet correctly
> initialised.
> 
> This hook also introduces complexity for the memory mapping operation, as
> we must correctly unwind what we do should an error arises.
> 
> Overall this interface being so open has caused significant problems for
> us, including security issues, it is important for us to simply eliminate
> this as a source of problems.
> 
> Therefore this series continues what was established by extending the
> functionality further to permit more drivers and filesystems to use
> mmap_prepare.
> 
> After updating some areas that can simply use mmap_prepare as-is, and
> performing some housekeeping, we then introduce two new hooks:
> 
> f_op->mmap_complete - this is invoked at the point of the VMA having been
> correctly inserted, though with the VMA write lock still held. mmap_prepare
> must also be specified.
> 
> This expands the use of mmap_prepare to those callers which need to
> prepopulate mappings, as well as any which does genuinely require access to
> the VMA.
> 
> It's simple - we will let the caller access the VMA, but only once it's
> established. At this point unwinding issues is simple - we just unmap the
> VMA.
> 
> The VMA is also then correctly initialised at this stage so there can be no
> issues arising from a not-fully initialised VMA at this point.
> 
> The other newly added hook is:
> 
> f_op->mmap_abort - this is only valid in conjunction with mmap_prepare and
> mmap_complete. This is called should an error arise between mmap_prepare
> and mmap_complete (not as a result of mmap_prepare but rather some other
> part of the mapping logic).
> 
> This is required in case mmap_prepare wishes to establish state or locks
> which need to be cleaned up on completion. If we did not provide this, then
> this could not be permitted as this cleanup would otherwise not occur
> should the mapping fail between the two calls.

So seeing these new hooks makes me wonder: Shouldn't rather implement
mmap(2) in a way more similar to how other f_op hooks behave like ->read or
->write? I.e., a hook called at rather high level - something like from
vm_mmap_pgoff() or similar similar level - which would just call library
functions from MM for the stuff it needs to do. Filesystems would just do
their checks and call the generic mmap function with the vm_ops they want
to use, more complex users could then fill in the VMA before releasing
mmap_lock or do cleanup in case of failure... This would seem like a more
understandable API than several hooks with rules when what gets called.

								Honza

> 
> We then add split remap_pfn_range*() functions which allow for PFN remap (a
> typical mapping prepopulation operation) split between a prepare/complete
> step, as well as io_mremap_pfn_range_prepare, complete for a similar
> purpose.
> 
> From there we update various mm-adjacent logic to use this functionality as
> a first set of changes, as well as resctl and cramfs filesystems to round
> off the non-stacked filesystem instances.
> 
> 
> REVIEWER NOTE:
> ~~~~~~~~~~~~~~
> 
> I considered putting the complete, abort callbacks in vm_ops, however this
> won't work because then we would be unable to adjust helpers like
> generic_file_mmap_prepare() (which provides vm_ops) to provide the correct
> complete, abort callbacks.
> 
> Conceptually it also makes more sense to have these in f_op as they are
> one-off operations performed at mmap time to establish the VMA, rather than
> a property of the VMA itself.
> 
> Lorenzo Stoakes (16):
>   mm/shmem: update shmem to use mmap_prepare
>   device/dax: update devdax to use mmap_prepare
>   mm: add vma_desc_size(), vma_desc_pages() helpers
>   relay: update relay to use mmap_prepare
>   mm/vma: rename mmap internal functions to avoid confusion
>   mm: introduce the f_op->mmap_complete, mmap_abort hooks
>   doc: update porting, vfs documentation for mmap_[complete, abort]
>   mm: add remap_pfn_range_prepare(), remap_pfn_range_complete()
>   mm: introduce io_remap_pfn_range_prepare, complete
>   mm/hugetlb: update hugetlbfs to use mmap_prepare, mmap_complete
>   mm: update mem char driver to use mmap_prepare, mmap_complete
>   mm: update resctl to use mmap_prepare, mmap_complete, mmap_abort
>   mm: update cramfs to use mmap_prepare, mmap_complete
>   fs/proc: add proc_mmap_[prepare, complete] hooks for procfs
>   fs/proc: update vmcore to use .proc_mmap_[prepare, complete]
>   kcov: update kcov to use mmap_prepare, mmap_complete
> 
>  Documentation/filesystems/porting.rst |   9 ++
>  Documentation/filesystems/vfs.rst     |  35 +++++++
>  arch/csky/include/asm/pgtable.h       |   5 +
>  arch/mips/alchemy/common/setup.c      |  28 +++++-
>  arch/mips/include/asm/pgtable.h       |  10 ++
>  arch/s390/kernel/crash_dump.c         |   6 +-
>  arch/sparc/include/asm/pgtable_32.h   |  29 +++++-
>  arch/sparc/include/asm/pgtable_64.h   |  29 +++++-
>  drivers/char/mem.c                    |  80 ++++++++-------
>  drivers/dax/device.c                  |  32 +++---
>  fs/cramfs/inode.c                     | 134 ++++++++++++++++++--------
>  fs/hugetlbfs/inode.c                  |  86 +++++++++--------
>  fs/ntfs3/file.c                       |   2 +-
>  fs/proc/inode.c                       |  13 ++-
>  fs/proc/vmcore.c                      |  53 +++++++---
>  fs/resctrl/pseudo_lock.c              |  56 ++++++++---
>  include/linux/fs.h                    |   4 +
>  include/linux/mm.h                    |  53 +++++++++-
>  include/linux/mm_types.h              |   5 +
>  include/linux/proc_fs.h               |   5 +
>  include/linux/shmem_fs.h              |   3 +-
>  include/linux/vmalloc.h               |  10 +-
>  kernel/kcov.c                         |  40 +++++---
>  kernel/relay.c                        |  32 +++---
>  mm/memory.c                           | 128 +++++++++++++++---------
>  mm/secretmem.c                        |   2 +-
>  mm/shmem.c                            |  49 +++++++---
>  mm/util.c                             |  18 +++-
>  mm/vma.c                              |  96 +++++++++++++++---
>  mm/vmalloc.c                          |  16 ++-
>  tools/testing/vma/vma_internal.h      |  31 +++++-
>  31 files changed, 810 insertions(+), 289 deletions(-)
> 
> --
> 2.51.0
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

