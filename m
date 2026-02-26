Return-Path: <linux-fsdevel+bounces-78475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FmmDoxJoGkuhwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:24:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F71A66EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08D0830557EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28FC324B06;
	Thu, 26 Feb 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j4vB+WEv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kBe6Fnbu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NCKzskdH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f6cNY8PR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05417314D2F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111674; cv=none; b=URH7ixKWnt4/rAtLp+asbWZRnQI2JtmG90t7UY1MuZ1SDL21Z6b/aRQ6/XZp07Wf+QnOzvF88EptTVWyxjYaLd/pFpflbPtxPgAvUp3TK0FXH0Zn+pzucPwKLFh/osO0S5iKWz3hB1uMa9H4bdMM0ILg0jWkZCPDrxFAz2Ag70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111674; c=relaxed/simple;
	bh=IexTXNEF7f3TsJmSjB/+XA72eWiKF+zEUb7JD18/vqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBRud8CjTpoI8H/w8W2SEWDJARtp6oV94X+zqVIIw8QRRYz0Pf/8+36sPmg/jHN+QMyjyxFIwF957RRDY5RPbBV/JDB20dnc2OCeveSyxsMCebycnXqSuWdpidvILzqGiw/OHVkleIZtscQCnw9Obn82EIY32A+vuh112djHsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j4vB+WEv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kBe6Fnbu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NCKzskdH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f6cNY8PR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B9321FA9C;
	Thu, 26 Feb 2026 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772111670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGlBY3HX0Fk8rDjUuw9CIjH8eNDH8K3OHId4Pn3yGbk=;
	b=j4vB+WEv4y1kWINxinp4K5xHq4qNb6QVbszMDLqe2cOmCXQLmMpXqNvER/OkhmttaJ6mPq
	PO01afqr65QPKR1hJWaE47l5VUFop/tmqYFDkH4sSQUZZZeg7/lDtJZsn2OcgnXG+FYJDS
	3INSe7CY01YA4kqSgq+DkN654M2Qyxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772111670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGlBY3HX0Fk8rDjUuw9CIjH8eNDH8K3OHId4Pn3yGbk=;
	b=kBe6FnbufQIISa9ZmB+PWU8oz7ztKwnEgGv0N1JRe7WMUc2sHPuXsS0oQ8TVFsDL/6jtgY
	2lICg1SqBVAhN4AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NCKzskdH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f6cNY8PR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772111669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGlBY3HX0Fk8rDjUuw9CIjH8eNDH8K3OHId4Pn3yGbk=;
	b=NCKzskdH3Dy9QkXFKg6glqlZZJMWI3MXryoRpFrE7Iit1rKhU2WrNQBlfY9I3bU0B487TK
	6aGiULbesLFXLotF7xJ+ZK2Ju/0lIZWQk0HZ965fTf9rNQVLJ/PzIypOaoD4zqVV/0nUke
	/rhJu7zUhkqh0wX6hDqb69mEKV4NGDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772111669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGlBY3HX0Fk8rDjUuw9CIjH8eNDH8K3OHId4Pn3yGbk=;
	b=f6cNY8PR5Z08eNP9jW47F6KDNGFWkowV9LekH5eRsIayHKjssiYBUujUagUXY+lgyn3b9l
	0ggVAJZEZsV4TbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 491E33EA69;
	Thu, 26 Feb 2026 13:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rlXWETVHoGlUSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 13:14:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 07D78A0A27; Thu, 26 Feb 2026 14:14:25 +0100 (CET)
Date: Thu, 26 Feb 2026 14:14:24 +0100
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Cc: David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Paulo Alcantara <pc@manguebit.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Steve French <sfrench@samba.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-ext4@vger.kernel.org, netfs@lists.linux.dev, 
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, linux-xfs@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 3/4] folio_batch: Rename pagevec.h to folio_batch.h
Message-ID: <zggxppyvd5ik5grjxcrhw6yc4q3w4ktiipv7qbxwlskv3l4uf2@wbrqoqvpzcul>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
 <20260225-pagevec_cleanup-v2-3-716868cc2d11@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225-pagevec_cleanup-v2-3-716868cc2d11@columbia.edu>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78475-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kvack.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,columbia.edu:email,suse.cz:email,suse.cz:dkim,linux-mm.org:url,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,tencent.com,huaweicloud.com,gmail.com,infradead.org,intel.com,suse.cz,zeniv.linux.org.uk,mit.edu,dilger.ca,manguebit.org,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,microsoft.com,talpey.com,linux.intel.com,suse.de,ffwll.ch,ursulin.net,fb.com,dubeyko.com,linux.dev,brown.name,ziepe.ca,nvidia.com,cmpxchg.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,kvack.org,lists.linux.dev,lists.samba.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[97];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 757F71A66EA
X-Rspamd-Action: no action

On Wed 25-02-26 18:44:27, Tal Zussman wrote:
> struct pagevec was removed in commit 1e0877d58b1e ("mm: remove struct
> pagevec"). Rename include/linux/pagevec.h to reflect reality and update
> includes tree-wide. Add the new filename to MAINTAINERS explicitly, as
> it no longer matches the "include/linux/page[-_]*" pattern in MEMORY
> MANAGEMENT - CORE.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  MAINTAINERS                                | 1 +
>  drivers/gpu/drm/drm_gem.c                  | 2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c  | 2 +-
>  drivers/gpu/drm/i915/gt/intel_gtt.h        | 2 +-
>  drivers/gpu/drm/i915/i915_gpu_error.c      | 2 +-
>  fs/btrfs/compression.c                     | 2 +-
>  fs/btrfs/extent_io.c                       | 2 +-
>  fs/btrfs/tests/extent-io-tests.c           | 2 +-
>  fs/buffer.c                                | 2 +-
>  fs/ceph/addr.c                             | 2 +-
>  fs/ext4/inode.c                            | 2 +-
>  fs/f2fs/checkpoint.c                       | 2 +-
>  fs/f2fs/compress.c                         | 2 +-
>  fs/f2fs/data.c                             | 2 +-
>  fs/f2fs/node.c                             | 2 +-
>  fs/gfs2/aops.c                             | 2 +-
>  fs/hugetlbfs/inode.c                       | 2 +-
>  fs/nilfs2/btree.c                          | 2 +-
>  fs/nilfs2/page.c                           | 2 +-
>  fs/nilfs2/segment.c                        | 2 +-
>  fs/ramfs/file-nommu.c                      | 2 +-
>  include/linux/{pagevec.h => folio_batch.h} | 8 ++++----
>  include/linux/folio_queue.h                | 2 +-
>  include/linux/iomap.h                      | 2 +-
>  include/linux/sunrpc/svc.h                 | 2 +-
>  include/linux/writeback.h                  | 2 +-
>  mm/filemap.c                               | 2 +-
>  mm/gup.c                                   | 2 +-
>  mm/memcontrol.c                            | 2 +-
>  mm/mlock.c                                 | 2 +-
>  mm/page-writeback.c                        | 2 +-
>  mm/page_alloc.c                            | 2 +-
>  mm/shmem.c                                 | 2 +-
>  mm/swap.c                                  | 2 +-
>  mm/swap_state.c                            | 2 +-
>  mm/truncate.c                              | 2 +-
>  mm/vmscan.c                                | 2 +-
>  37 files changed, 40 insertions(+), 39 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4572a36afd2..f50421e65cb1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16664,6 +16664,7 @@ L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	include/linux/folio_batch.h
>  F:	include/linux/gfp.h
>  F:	include/linux/gfp_types.h
>  F:	include/linux/highmem.h
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 891c3bff5ae0..dc4534fb175c 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -38,7 +38,7 @@
>  #include <linux/mman.h>
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/sched/mm.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/slab.h>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index c6c64ba29bc4..07025b547c94 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -3,7 +3,7 @@
>   * Copyright © 2014-2016 Intel Corporation
>   */
>  
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/swap.h>
>  #include <linux/uio.h>
> diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.h b/drivers/gpu/drm/i915/gt/intel_gtt.h
> index 9d3a3ad567a0..b54ee4f25af1 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gtt.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gtt.h
> @@ -19,7 +19,7 @@
>  #include <linux/io-mapping.h>
>  #include <linux/kref.h>
>  #include <linux/mm.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/scatterlist.h>
>  #include <linux/workqueue.h>
>  
> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
> index a99b4e45d26c..ffe5f24594c9 100644
> --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> @@ -31,7 +31,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/highmem.h>
>  #include <linux/nmi.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/scatterlist.h>
>  #include <linux/string_helpers.h>
>  #include <linux/utsname.h>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 790518a8c803..dbc634d10ad3 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -8,7 +8,7 @@
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/highmem.h>
>  #include <linux/kthread.h>
>  #include <linux/time.h>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 744a1fff6eef..c373d113f1e7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -11,7 +11,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/swap.h>
>  #include <linux/writeback.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/prefetch.h>
>  #include <linux/fsverity.h>
>  #include "extent_io.h"
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
> index a0187d6163df..b2aacf846c8b 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -4,7 +4,7 @@
>   */
>  
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/sizes.h>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 22b43642ba57..f3122160ee2d 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -45,7 +45,7 @@
>  #include <linux/bitops.h>
>  #include <linux/mpage.h>
>  #include <linux/bit_spinlock.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/sched/mm.h>
>  #include <trace/events/block.h>
>  #include <linux/fscrypt.h>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index e87b3bb94ee8..2803511d86ef 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -7,7 +7,7 @@
>  #include <linux/swap.h>
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/signal.h>
>  #include <linux/iversion.h>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 396dc3a5d16b..58f982885187 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -29,7 +29,7 @@
>  #include <linux/string.h>
>  #include <linux/buffer_head.h>
>  #include <linux/writeback.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/mpage.h>
>  #include <linux/rmap.h>
>  #include <linux/namei.h>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 6dd39b7de11a..0143365c07dc 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -11,7 +11,7 @@
>  #include <linux/writeback.h>
>  #include <linux/blkdev.h>
>  #include <linux/f2fs_fs.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/swap.h>
>  #include <linux/kthread.h>
>  #include <linux/delayacct.h>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 8c76400ba631..614e00b8ffdc 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -13,7 +13,7 @@
>  #include <linux/lzo.h>
>  #include <linux/lz4.h>
>  #include <linux/zstd.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 338df7a2aea6..90e8ef625d82 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -10,7 +10,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/mpage.h>
>  #include <linux/writeback.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/blkdev.h>
>  #include <linux/bio.h>
>  #include <linux/blk-crypto.h>
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 74992fd9c9b6..ba0272314528 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -10,7 +10,7 @@
>  #include <linux/mpage.h>
>  #include <linux/sched/mm.h>
>  #include <linux/blkdev.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/swap.h>
>  
>  #include "f2fs.h"
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index e79ad087512a..dae3dc4ee6f7 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -10,7 +10,7 @@
>  #include <linux/completion.h>
>  #include <linux/buffer_head.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/mpage.h>
>  #include <linux/fs.h>
>  #include <linux/writeback.h>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 22c799000edb..2ec3e4231252 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -25,7 +25,7 @@
>  #include <linux/ctype.h>
>  #include <linux/backing-dev.h>
>  #include <linux/hugetlb.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/fs_parser.h>
>  #include <linux/mman.h>
>  #include <linux/slab.h>
> diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> index dd0c8e560ef6..b400cfcdc803 100644
> --- a/fs/nilfs2/btree.c
> +++ b/fs/nilfs2/btree.c
> @@ -10,7 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/errno.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include "nilfs.h"
>  #include "page.h"
>  #include "btnode.h"
> diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> index 56c4da417b6a..a9d8aa65416f 100644
> --- a/fs/nilfs2/page.c
> +++ b/fs/nilfs2/page.c
> @@ -14,7 +14,7 @@
>  #include <linux/page-flags.h>
>  #include <linux/list.h>
>  #include <linux/highmem.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/gfp.h>
>  #include "nilfs.h"
>  #include "page.h"
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 098a3bd103e0..6d62de64a309 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -19,7 +19,7 @@
>  #include <linux/freezer.h>
>  #include <linux/kthread.h>
>  #include <linux/crc32.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/slab.h>
>  #include <linux/sched/signal.h>
>  
> diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
> index 0f8e838ece07..2f79bcb89d2e 100644
> --- a/fs/ramfs/file-nommu.c
> +++ b/fs/ramfs/file-nommu.c
> @@ -14,7 +14,7 @@
>  #include <linux/string.h>
>  #include <linux/backing-dev.h>
>  #include <linux/ramfs.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/mman.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> diff --git a/include/linux/pagevec.h b/include/linux/folio_batch.h
> similarity index 95%
> rename from include/linux/pagevec.h
> rename to include/linux/folio_batch.h
> index 007affabf335..a2f3d3043f7e 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/folio_batch.h
> @@ -1,13 +1,13 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * include/linux/pagevec.h
> + * include/linux/folio_batch.h
>   *
>   * In many places it is efficient to batch an operation up against multiple
>   * folios.  A folio_batch is a container which is used for that.
>   */
>  
> -#ifndef _LINUX_PAGEVEC_H
> -#define _LINUX_PAGEVEC_H
> +#ifndef _LINUX_FOLIO_BATCH_H
> +#define _LINUX_FOLIO_BATCH_H
>  
>  #include <linux/types.h>
>  
> @@ -102,4 +102,4 @@ static inline void folio_batch_release(struct folio_batch *fbatch)
>  }
>  
>  void folio_batch_remove_exceptionals(struct folio_batch *fbatch);
> -#endif /* _LINUX_PAGEVEC_H */
> +#endif /* _LINUX_FOLIO_BATCH_H */
> diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
> index adab609c972e..0d3765fa9d1d 100644
> --- a/include/linux/folio_queue.h
> +++ b/include/linux/folio_queue.h
> @@ -14,7 +14,7 @@
>  #ifndef _LINUX_FOLIO_QUEUE_H
>  #define _LINUX_FOLIO_QUEUE_H
>  
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/mm.h>
>  
>  /*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 99b7209dabd7..4551613cea2f 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -9,7 +9,7 @@
>  #include <linux/types.h>
>  #include <linux/mm_types.h>
>  #include <linux/blkdev.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  
>  struct address_space;
>  struct fiemap_extent_info;
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 4dc14c7a711b..a11acf5cd63b 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -20,7 +20,7 @@
>  #include <linux/lwq.h>
>  #include <linux/wait.h>
>  #include <linux/mm.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/kthread.h>
>  
>  /*
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index e530112c4b3a..62552a2ce5b9 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -11,7 +11,7 @@
>  #include <linux/flex_proportions.h>
>  #include <linux/backing-dev-defs.h>
>  #include <linux/blk_types.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  
>  struct bio;
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6cd7974d4ada..63f256307fdd 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -31,7 +31,7 @@
>  #include <linux/hash.h>
>  #include <linux/writeback.h>
>  #include <linux/backing-dev.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/security.h>
>  #include <linux/cpuset.h>
>  #include <linux/hugetlb.h>
> diff --git a/mm/gup.c b/mm/gup.c
> index 8e7dc2c6ee73..ad9ded39609c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -18,7 +18,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/migrate.h>
>  #include <linux/mm_inline.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/sched/mm.h>
>  #include <linux/shmem_fs.h>
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index db59fad3503f..51508573963d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -34,7 +34,7 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/hugetlb.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/vm_event_item.h>
>  #include <linux/smp.h>
>  #include <linux/page-flags.h>
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 2f699c3497a5..1a92d16f3684 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -13,7 +13,7 @@
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/pagewalk.h>
>  #include <linux/mempolicy.h>
>  #include <linux/syscalls.h>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 601a5e048d12..1009bb042ba4 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -33,7 +33,7 @@
>  #include <linux/sysctl.h>
>  #include <linux/cpu.h>
>  #include <linux/syscalls.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/timer.h>
>  #include <linux/sched/rt.h>
>  #include <linux/sched/signal.h>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d88c8c67ac0b..74b603872f34 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -31,7 +31,7 @@
>  #include <linux/sysctl.h>
>  #include <linux/cpu.h>
>  #include <linux/cpuset.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/memory_hotplug.h>
>  #include <linux/nodemask.h>
>  #include <linux/vmstat.h>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index cfed6c3ff853..149fdb051170 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -61,7 +61,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
>  #include <linux/slab.h>
>  #include <linux/backing-dev.h>
>  #include <linux/writeback.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/percpu_counter.h>
>  #include <linux/falloc.h>
>  #include <linux/splice.h>
> diff --git a/mm/swap.c b/mm/swap.c
> index bb19ccbece46..2e517ede6561 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -20,7 +20,7 @@
>  #include <linux/swap.h>
>  #include <linux/mman.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/init.h>
>  #include <linux/export.h>
>  #include <linux/mm_inline.h>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 32d9d877bda8..a0c64db2b275 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -15,7 +15,7 @@
>  #include <linux/leafops.h>
>  #include <linux/init.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/backing-dev.h>
>  #include <linux/blkdev.h>
>  #include <linux/migrate.h>
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 12467c1bd711..df0b7a7e6aff 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -17,7 +17,7 @@
>  #include <linux/export.h>
>  #include <linux/pagemap.h>
>  #include <linux/highmem.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/rmap.h>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7effd01a7828..7e921dbe2373 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -44,7 +44,7 @@
>  #include <linux/sysctl.h>
>  #include <linux/memory-tiers.h>
>  #include <linux/oom.h>
> -#include <linux/pagevec.h>
> +#include <linux/folio_batch.h>
>  #include <linux/prefetch.h>
>  #include <linux/printk.h>
>  #include <linux/dax.h>
> 
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

