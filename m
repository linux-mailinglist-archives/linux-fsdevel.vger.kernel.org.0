Return-Path: <linux-fsdevel+bounces-53060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3536AE968A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 09:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C94A0130
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 07:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6274D238D53;
	Thu, 26 Jun 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lZMv50Vm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yk217dFj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yMxTBd+a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="duk1rWj/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266452264A2
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750921258; cv=none; b=pNY4f1qNk7kM4lripF5lrsWKpPWp33r1GLIqfZnYP7DyzhPuay+k8/KkZccOsaQEAcZ89hOuwBDshh0A4Lfyxio+g3VWNrV0/ckbl6d5KphwvJLv9yNbXOVMNqm6tNfCaS+LHR9m0xKzRbcEgs9aS9kLFPhgujzwTGNGs8Tj5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750921258; c=relaxed/simple;
	bh=FnzgBhRtwtMX6NcNxvTe2b7odRwD+FhTrz0zuPL4f5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a601w0kJgN1mul/n2iIvOU3XtJrYVk3gteyh2JU/iEpJqDrxXMrrwv1sXd+mx6pOGCU9fic8TcUsnBTN7uANvL1ZxHE5x1arGXZZppORecve3LBSgCEtumz4vkflAdZPFoKEf+qye4s6gPiy2NhmIg4wfcLxVtlAR1bDaLwnEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lZMv50Vm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yk217dFj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yMxTBd+a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=duk1rWj/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73B4C1F38D;
	Thu, 26 Jun 2025 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750921250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYok1CSTlk8p1Np6qemtLfABm+ux0CRPztAQma9oeEE=;
	b=lZMv50VmlOww0cnCR4bTGtaG3/YCEjZIJ6hJx822LFw4jaavAR8G/Vy1Czng5OQFt2rpqo
	8VmqFPqt9ymrt5jtflDCrYGH6sWEAnGXE85tQtvLgZkttXeDUBhoufkSAvEVNeWckZpwCd
	ztOc1h53cwe42qRNMb2hGgkz02xH7yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750921250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYok1CSTlk8p1Np6qemtLfABm+ux0CRPztAQma9oeEE=;
	b=Yk217dFjxdhtP6WJfYgThK3CuZkiB8huYjwTlCVshEt762FxRendeV0OZrAj5IskI3DNAo
	rfKTcHIVDloxw4Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750921245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYok1CSTlk8p1Np6qemtLfABm+ux0CRPztAQma9oeEE=;
	b=yMxTBd+a/iQsREcegZkmiqbw/0ihN+mIHnZUsNghMtxNtc5daEPLhpUO2UExxfE7K3Noak
	3XaGXFZvjty7loovjUFQ8MDetWfl03O/9WxgabqmYn/8/VOiaXn3znmzfCr9mb6E0iQbOh
	TC4CiZ9L000hnWn8ljU/pGKpcCQiiUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750921245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYok1CSTlk8p1Np6qemtLfABm+ux0CRPztAQma9oeEE=;
	b=duk1rWj/y7XGLICouNKWy5v3+3YZ0SE686lbDg8QHueE1OU+FF3/HRAi+tJCueom7mmVlT
	+Ehk8DKnFHhM5LBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6465013188;
	Thu, 26 Jun 2025 07:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lfl9GB3wXGgXIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Jun 2025 07:00:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EC3E1A0953; Thu, 26 Jun 2025 09:00:44 +0200 (CEST)
Date: Thu, 26 Jun 2025 09:00:44 +0200
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Tejun Heo <tj@kernel.org>, Maxim Patlasov <mpatlasov@parallels.com>, 
	Jan Kara <jack@suse.cz>, Zach O'Keefe <zokeefe@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm, vmstat: remove the NR_WRITEBACK_TEMP node_stat_item
 counter
Message-ID: <rr2hxi5dxoh6n4pbx5pcyelquvotbksfy2d2m5ycydafog65j4@rcekxluoecrr>
References: <20250625-nr_writeback_removal-v1-1-7f2a0df70faa@suse.cz>
 <CAJnrk1YcA9MBC+KQdLE7B-CspoO5=xjkAf78swP6Q6UPijJaug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YcA9MBC+KQdLE7B-CspoO5=xjkAf78swP6Q6UPijJaug@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[jack.suse.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 25-06-25 14:38:01, Joanne Koong wrote:
> On Wed, Jun 25, 2025 at 8:51 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > The only user of the counter (FUSE) was removed in commit 0c58a97f919c
> > ("fuse: remove tmp folio for writebacks and internal rb tree") so follow
> > the established pattern of removing the counter and hardcoding 0 in
> > meminfo output, as done recently with NR_BOUNCE. Update documentation
> > for procfs, including for the value for Bounce that was missed when
> > removing its counter.
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> > The removal of the counter is straightforward. The reason for the large
> > Cc list is that there is a comment in mm/page-writeback.c function
> > wb_position_ratio() that mentions NR_WRITEBACK_TEMP, and just deleting
> > the sentence feels to me it could be the wrong thing to do - maybe the
> > strictlimit feature itself is now obsolete? It sure does mention FUSE
> > as the main reason to exist, but commit 5a53748568f79 that introduced it
> > also mentions slow USB sticks as a possibile scenario. Has that
> > happened? I'm not familiar enough with this so I'd rather highlight this
> > and ask for input here than make "git grep NR_WRITEBACK_TEMP" return
> > nothing.
> 
> My understanding is that even without the fuse use case, strictlimit
> is still used for other devices via the /sys/class/bdi interface (eg
> /sys/class/bdi/<bdi>/strict_limit) so I don't think the feature itself
> is obsolete.
> 
> It's not clear to me whether fuse still needs strictlimit now that it
> doesn't have tmp writeback pages, but it'd be great to get an answer
> to this, as strictlimit currently leads to too much dirty throttling
> when large folios are enabled in fuse.

Well, Miklos would be the definitive source of truth here but as far as I
know strictlimit is still desirable for FUSE even without
NR_WRITEBACK_TEMP. Otherwise dirty pages in mappings where writeback can be
potentially very slow (and definitely under userspace control) could
consume most of the global dirty limit which is not what you usually want.
That being said I can definitely see there are usecases of FUSE mounts
where you don't want this extra throttling. But then it's upto sysadmin to
configure min/max_ratio properly in these cases to avoid excessive
throttling.

Regarding the comment, I'm frankly not certain how strictlimit solved
NR_WRITEBACK_TEMP issue because NR_WRITEBACK_TEMP was never included in any
computations there AFAICS. It just helped to limit amount of outstanding
dirty pages for FUSE mappings and thus indirectly limited the scope of
NR_WRITEBACK_TEMP issue. Anyway I think the sentence is obsolete now and
deleting it is indeed the right solution because FUSE writeback is now
properly accounted in the dirty limit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

