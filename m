Return-Path: <linux-fsdevel+bounces-46189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED7DA840E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 12:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B1C9E1DE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B75280CF8;
	Thu, 10 Apr 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ADdYYWTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="80ZvvYhz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ADdYYWTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="80ZvvYhz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF01281364
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281351; cv=none; b=fKAB5+G0Z7MHHdy8I8wUkNDgUo/xjPJ78plUCnR4ZLYNiKy9xWfJ6SAG9hjeTTQKmYBYv4vE03cEl1F94HScGGeU3XmvFUapDb66/0aXnIqIgHMiQVwkb6+8AQZUw0jeomroFisyp23/MfYCAgM7lTBDr5Q2y2+2CwAl05sYGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281351; c=relaxed/simple;
	bh=V6cW/m8XzoIHskbnHAETvNa/9Acy4r8cBggy9Q4N9nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OigOVh45oGWxgjufYbW1cw1/3F0DXMsf8LXeM7Nb+6cqYuw1f47IVYO2Aeu9ZYrecOkmAXuYPXa/kDDcH1lpKLTrZyPX1FFGPJz35ASj4eEPLVs3//acis5VnNxGk0i5emFQwwxYJ/GbNWlnJ1eXZIwp0rScEsKTmIJG359HeOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ADdYYWTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=80ZvvYhz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ADdYYWTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=80ZvvYhz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1E5C21168;
	Thu, 10 Apr 2025 10:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744281347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIDP4d34DUcpKIsnqGdTzzo0Xvi37BHxdLJbQ2zC+P4=;
	b=ADdYYWTfVIVTgwD+j75mRlJtHHUBGmZyrrVKc9goigHihcOiKnF0Hi0REnbqx91FGi+tYL
	Jcz0hasqgrdRm+0iKn1VzWltk4pG1+ELipLnC2M/2vp556b1NqQXfMDXEI+9ucdZbHDca0
	FlPsjnWA4y9qApWVH0FV5qK4EtlgNj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744281347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIDP4d34DUcpKIsnqGdTzzo0Xvi37BHxdLJbQ2zC+P4=;
	b=80ZvvYhzW8HUuYOLq3BdNSvOUhLOJcvjF/jS6ovhXflypLEw7MqtmRvNB06kR/ylFPXkRf
	3Jsq0ADQ5l+z4+Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744281347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIDP4d34DUcpKIsnqGdTzzo0Xvi37BHxdLJbQ2zC+P4=;
	b=ADdYYWTfVIVTgwD+j75mRlJtHHUBGmZyrrVKc9goigHihcOiKnF0Hi0REnbqx91FGi+tYL
	Jcz0hasqgrdRm+0iKn1VzWltk4pG1+ELipLnC2M/2vp556b1NqQXfMDXEI+9ucdZbHDca0
	FlPsjnWA4y9qApWVH0FV5qK4EtlgNj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744281347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIDP4d34DUcpKIsnqGdTzzo0Xvi37BHxdLJbQ2zC+P4=;
	b=80ZvvYhzW8HUuYOLq3BdNSvOUhLOJcvjF/jS6ovhXflypLEw7MqtmRvNB06kR/ylFPXkRf
	3Jsq0ADQ5l+z4+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A175613886;
	Thu, 10 Apr 2025 10:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E0llJwOf92eGMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Apr 2025 10:35:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5E471A0910; Thu, 10 Apr 2025 12:35:47 +0200 (CEST)
Date: Thu, 10 Apr 2025 12:35:47 +0200
From: Jan Kara <jack@suse.cz>
To: Alistair Popple <apopple@nvidia.com>
Cc: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Asahi Lina <lina@asahilina.net>, Balbir Singh <balbirs@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@redhat.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ira Weiny <ira.weiny@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, linmiaohe <linmiaohe@huawei.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Matthew Wilcow <willy@infradead.org>, 
	Michael Camp Drill Sergeant Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Xu <peterx@redhat.com>, Sven Schnelle <svens@linux.ibm.com>, Ted Ts'o <tytso@mit.edu>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Vivek Goyal <vgoyal@redhat.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, 
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [linus:master] [fs/dax]  bde708f1a6:
 WARNING:at_mm/truncate.c:#truncate_folio_batch_exceptionals
Message-ID: <uiu7rcmtooxgbscaiiim7czqsca52bgrt6aiszsafq7jj4n3e7@ge6mfzcmnorl>
References: <202504101036.390f29a5-lkp@intel.com>
 <v66t3szdfsfwyl4lw6ns2ykmxrfqecba2nb5wa64l5qqq2kfpb@x7zxzuijty7d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v66t3szdfsfwyl4lw6ns2ykmxrfqecba2nb5wa64l5qqq2kfpb@x7zxzuijty7d>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[intel.com,suse.cz,lists.linux.dev,vger.kernel.org,linux-foundation.org,linux.ibm.com,asahilina.net,nvidia.com,google.com,arm.com,lst.de,gmail.com,kernel.org,fromorbit.com,linux.intel.com,redhat.com,ziepe.ca,huawei.com,deltatee.com,infradead.org,ellerman.id.au,mit.edu,xen0n.name];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLx3ed8f7q4e9s3nf3mrauhj48)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Thu 10-04-25 17:01:26, Alistair Popple wrote:
> On Thu, Apr 10, 2025 at 01:14:42PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_mm/truncate.c:#truncate_folio_batch_exceptionals" on:
> > 
> > commit: bde708f1a65d025c45575bfe1e7bf7bdf7e71e87 ("fs/dax: always remove DAX page-cache entries when breaking layouts")
> 
> This is warning about hitting the bug that commit 0e2f80afcfa6 ("fs/dax: ensure
> all pages are idle prior to filesystem unmount") fixes. I couldn't reorder that
> patch before this one because it relies on the DAX page-cache entries always
> being removed when breaking layouts.
> 
> However I note that this is ext2. Commit 0e2f80afcfa6 doesn't actually update
> ext2 so the warning will persist. The fix should basically be the same as for
> ext4:
> 
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -74,6 +74,8 @@ void ext2_evict_inode(struct inode * inode)
>         struct ext2_block_alloc_info *rsv;
>         int want_delete = 0;
>  
> +        dax_break_layout_final(inode);
> +
>         if (!inode->i_nlink && !is_bad_inode(inode)) {
>                 want_delete = 1;
>                 dquot_initialize(inode);
> 
> What's more troubling though is unlike ext4 there is no ext2_dax_break_layouts()
> defined, which is how I missed updating it. That means truncate with FS DAX
> is already pretty broken for ext2, and will need more than just the above fix
> to ensure DAX pages are idle before truncate. So I think FS DAX on ext2 should
> probably just be removed or marked broken unless someone with more knowledge of
> ext2 wants to fix it up?

Yeah, with a hindsight, implementing fsdax for ext2 was a mistake (although
it was meant as a replacement for the old execute-in-place feature that
ext2 had for s390 and which we wanted to remove). At this point when pmem
didn't lift off and DAX ended up being kind of niche, I think the effort
to maintain DAX in ext2 is not justified and we should just drop it (and
direct existing users to use ext4 driver instead for the cases where they
need it). I'll have a look into it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

