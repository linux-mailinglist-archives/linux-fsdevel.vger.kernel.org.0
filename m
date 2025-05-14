Return-Path: <linux-fsdevel+bounces-48947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ADEAB66C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 11:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8191E3AEDBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C3B2236ED;
	Wed, 14 May 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vO9H0UFg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nddhf0kz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vO9H0UFg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nddhf0kz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BE22257E
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213460; cv=none; b=TCPwbrS/gT1Db5IW6v8O5vAYxmnwsdso6C/uH/gpHLfL4DiRGs5TYSiGJ2HGL+6gETZYzGuxMDk3WVjQnsc87zzZ64Td7ydI5bPU0lSeFJIg8487krAlUhl9N4t/NHcA1l6z1SfLmBTuXuBw7vAf2vVKfQpnblKwCGuYYPKWbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213460; c=relaxed/simple;
	bh=C1LKllG2Fa8wm4iOWNMtcfEqU9DwZwq1MyCxxqcdV+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYmDL/jwaK23WZKYP01aspNKX9ogoE6YjnmJ2CjEzuYdzCMjHuc6IG64qe6ZzaMKS2Sem7c0vora3GxFM5h8KE5ro8psdNtqqXuyK5GBHcgVbd6xWURzJktz8jBy7DvfoahAnu/rbFNR9wEZkr0YaNwUpZL4Wv/2cLIthElyfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vO9H0UFg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nddhf0kz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vO9H0UFg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nddhf0kz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B44D01F455;
	Wed, 14 May 2025 09:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747213456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uil2b5IHzAypI/ph0mhKh3JmhrE9zgPSiFLLhXdGaQQ=;
	b=vO9H0UFgUGPqAD7S9PR22XyYmZEo4xckkeaxaJy2QBBk19e+FlGmdCsHuHCdQrFO51dAN4
	K1hyHUGgN4/RImC8hR4QHwnpOniqJ0dRR6JF0KeZeDfz3/k7RdD9faZGPYaX1yTC5Ydplb
	kijPL7F+gCVhqt1Jg4H7vIlMIEpLoH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747213456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uil2b5IHzAypI/ph0mhKh3JmhrE9zgPSiFLLhXdGaQQ=;
	b=Nddhf0kzJBh7W69czTE7u1ndGQPV5T9HrRdfSFAl72xwPjchGcqyXIzCOQwli2z7vIWld/
	IZLdF+OQi3LUDaBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vO9H0UFg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Nddhf0kz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747213456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uil2b5IHzAypI/ph0mhKh3JmhrE9zgPSiFLLhXdGaQQ=;
	b=vO9H0UFgUGPqAD7S9PR22XyYmZEo4xckkeaxaJy2QBBk19e+FlGmdCsHuHCdQrFO51dAN4
	K1hyHUGgN4/RImC8hR4QHwnpOniqJ0dRR6JF0KeZeDfz3/k7RdD9faZGPYaX1yTC5Ydplb
	kijPL7F+gCVhqt1Jg4H7vIlMIEpLoH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747213456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uil2b5IHzAypI/ph0mhKh3JmhrE9zgPSiFLLhXdGaQQ=;
	b=Nddhf0kzJBh7W69czTE7u1ndGQPV5T9HrRdfSFAl72xwPjchGcqyXIzCOQwli2z7vIWld/
	IZLdF+OQi3LUDaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEBE7137E8;
	Wed, 14 May 2025 09:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fySAK49cJGjpIAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 14 May 2025 09:04:15 +0000
Date: Wed, 14 May 2025 10:04:06 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <dqir4mv7twugxj6nstqziympxc6z3k5act4cwhgpg2naeqy3sx@wkn4wvnwbpih>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B44D01F455
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action

On Fri, May 09, 2025 at 01:13:34PM +0100, Lorenzo Stoakes wrote:
> Provide a means by which drivers can specify which fields of those
> permitted to be changed should be altered to prior to mmap()'ing a
> range (which may either result from a merge or from mapping an entirely new
> VMA).
> 
> Doing so is substantially safer than the existing .mmap() calback which
> provides unrestricted access to the part-constructed VMA and permits
> drivers and file systems to do 'creative' things which makes it hard to
> reason about the state of the VMA after the function returns.
> 
> The existing .mmap() callback's freedom has caused a great deal of issues,
> especially in error handling, as unwinding the mmap() state has proven to
> be non-trivial and caused significant issues in the past, for instance
> those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> error path behaviour").
> 
> It also necessitates a second attempt at merge once the .mmap() callback
> has completed, which has caused issues in the past, is awkward, adds
> overhead and is difficult to reason about.
> 
> The .mmap_prepare() callback eliminates this requirement, as we can update
> fields prior to even attempting the first merge. It is safer, as we heavily
> restrict what can actually be modified, and being invoked very early in the
> mmap() process, error handling can be performed safely with very little
> unwinding of state required.
> 
> The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> exclusive, so we permit only one to be invoked at a time.
> 
> Update vma userland test stubs to account for changes.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Neat idea, thanks. This should also help out with the insane proliferation of
vm_flags_set in ->mmap() callbacks all over. Hopefully.

However, could we:

1) Add a small writeup to Documentation/filesystems/vfs.rst for this callback

2) Possibly add a ->mmap_finish()? With a fully constructed vma at that point.
   So things like remap_pfn_range can still be used by drivers' mmap()
   implementation.

1) is particularly important so our VFS and driver friends know this is supposed
to be The Way Forward.

-- 
Pedro

