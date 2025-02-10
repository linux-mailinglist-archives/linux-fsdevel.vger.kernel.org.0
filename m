Return-Path: <linux-fsdevel+bounces-41425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C6A2F545
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE433AA716
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11024FBE9;
	Mon, 10 Feb 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l3EgE5Xn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="js1beivw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l3EgE5Xn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="js1beivw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD9256C6B
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208513; cv=none; b=pdrMPaRZAGJeJDY+AhfogMltMiyRSGuqFMoa45jojB0ydWcroBRApJT/qCC3zkawqXVD/txqHWjz6p9yxANxi81XZ30aV7i/LaYdm7vp2C55ei6uwsdQLPtPyEjU8hmguuIE1R6kd48PlCEN9Um3Q0lqFZKhZYfXHMULy/tdpEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208513; c=relaxed/simple;
	bh=Bsqq8AO2LiXzll09rtNIi5ZmZa+c2I3LHgpF0K51kG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn3WfYvQLIdRDODWf/Ayw/5GZR3fR3aLoWUwaUH4eb8AaIcS0XDq9tGQy5rw3+Sk2Ud69Ao8otMyW6UDhV5i+AoaDOfPcDgxw45AZSRmO3aaVsc3SCbr979I+HZZ+SFcl27ILTfY1Wqpj2ZCYCCzG1BLtFaLXHTGD4r/Ndsw4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l3EgE5Xn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=js1beivw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l3EgE5Xn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=js1beivw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73EEA1F390;
	Mon, 10 Feb 2025 17:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739208509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwcLDK5/0GiSyNd7DFvo6USj4ER5QHC+HV72jiVT5mE=;
	b=l3EgE5Xn+PYIMok8XA0EHxbKinKBzwKn2+YCW9a/JCCF5diJBrVtkLUe/H+s9YN1i5rR/c
	jPejNydwFeu637+45BzxepxV+2sVey81XKF5iU+vmk2b8Z4H9ZgoRcKiiPdqOUBiRJ9zIA
	PvxsimfIIjoUddy83Wcx9TJZ54GIDFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739208509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwcLDK5/0GiSyNd7DFvo6USj4ER5QHC+HV72jiVT5mE=;
	b=js1beivwwgPz5ndodXj/XTSVmcP6MDYqk04pS1KHa1hDOw4pnnzb6qVW720B3jQ9EVCpL+
	qXcw4DRfJHQnTYAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=l3EgE5Xn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=js1beivw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739208509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwcLDK5/0GiSyNd7DFvo6USj4ER5QHC+HV72jiVT5mE=;
	b=l3EgE5Xn+PYIMok8XA0EHxbKinKBzwKn2+YCW9a/JCCF5diJBrVtkLUe/H+s9YN1i5rR/c
	jPejNydwFeu637+45BzxepxV+2sVey81XKF5iU+vmk2b8Z4H9ZgoRcKiiPdqOUBiRJ9zIA
	PvxsimfIIjoUddy83Wcx9TJZ54GIDFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739208509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwcLDK5/0GiSyNd7DFvo6USj4ER5QHC+HV72jiVT5mE=;
	b=js1beivwwgPz5ndodXj/XTSVmcP6MDYqk04pS1KHa1hDOw4pnnzb6qVW720B3jQ9EVCpL+
	qXcw4DRfJHQnTYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B73213A62;
	Mon, 10 Feb 2025 17:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k5ABFj03qmc3YAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Feb 2025 17:28:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EFBAAA095C; Mon, 10 Feb 2025 18:28:28 +0100 (CET)
Date: Mon, 10 Feb 2025 18:28:28 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>, 
	Kundan Kumar <kundan.kumar@samsung.com>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com, axboe@kernel.dk, 
	clm@meta.com, willy@infradead.org, gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
 <Z6GAYFN3foyBlUxK@dread.disaster.area>
 <20250204050642.GF28103@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204050642.GF28103@lst.de>
X-Rspamd-Queue-Id: 73EEA1F390
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 04-02-25 06:06:42, Christoph Hellwig wrote:
> On Tue, Feb 04, 2025 at 01:50:08PM +1100, Dave Chinner wrote:
> > I doubt that will create enough concurrency for a typical small
> > server or desktop machine that only has a single NUMA node but has a
> > couple of fast nvme SSDs in it.
> > 
> > > 2) Fixed number of writeback contexts, say min(10, numcpu).
> > > 3) NUMCPU/N number of writeback contexts.
> > 
> > These don't take into account the concurrency available from
> > the underlying filesystem or storage.
> > 
> > That's the point I was making - CPU count has -zero- relationship to
> > the concurrency the filesystem and/or storage provide the system. It
> > is fundamentally incorrect to base decisions about IO concurrency on
> > the number of CPU cores in the system.
> 
> Yes.  But as mention in my initial reply there is a use case for more
> WB threads than fs writeback contexts, which is when the writeback
> threads do CPU intensive work like compression.  Being able to do that
> from normal writeback threads vs forking out out to fs level threads
> would really simply the btrfs code a lot.  Not really interesting for
> XFS right now of course.
> 
> Or in other words: fs / device geometry really should be the main
> driver, but if a file systems supports compression (or really expensive
> data checksums) being able to scale up the numbes of threads per
> context might still make sense.  But that's really the advanced part,
> we'll need to get the fs geometry aligned to work first.

As I'm reading the thread it sounds to me the writeback subsystem should
provide an API for the filesystem to configure number of writeback
contexts which would be kind of similar to what we currently do for cgroup
aware writeback? Currently we create writeback context per cgroup so now
additionally we'll have some property like "inode writeback locality" that
will also influence what inode->i_wb gets set to and hence where
mark_inode_dirty() files inodes etc.

Then additionally you'd like to have possibility to have more processes
operate on one struct wb_writeback (again configurable by filesystem?) to
handle cases of cpu intensive writeback submission more efficiently.

Sounds about right?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

