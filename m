Return-Path: <linux-fsdevel+bounces-60941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C2B531A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 14:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60AC1BC4DD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42CB2F0670;
	Thu, 11 Sep 2025 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9mW5lc6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kmmshWh0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9mW5lc6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kmmshWh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC21A2387
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592105; cv=none; b=eyhvejxmEtmOEe9TcWcowEA1CRxbq5w10c2+R6uSknmgj3+7k1Wc7D0FCetqO22A/MOu//rBiiMcVWFMj48OGB0l9UnWp+Em1VVNVUN+109rwQdM4kWtDzaHSBzLoUohd+1ROeQL19/2deHxI1jvJDYcAaX7HRz57VEvP+CVER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592105; c=relaxed/simple;
	bh=2YSewRXvJHcUDsCeGu8hxf4jToia7yCgrHOqvfe/vak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuUySgRDxR0TB0lcYsR9oHZqlgZPvKOXoh6BssoPFda2F8ccw7VQZ25fZtqMCR8kh/4rHIw2mMZqHgDJKvrQGAwCPbILAPVix+QVIKmwM1Jk8L8bji5hw3ItEyAk3U4Wk4pqNZwd6DOzAdEbgAFuKAJQZLuC9idFvncgycgPqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9mW5lc6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kmmshWh0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9mW5lc6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kmmshWh0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13C92227B0;
	Thu, 11 Sep 2025 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757592101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qTcZOMPNJimAbyd8RtPoSsZk0OG2pBh5j6lrygM9lN0=;
	b=s9mW5lc6BliPQ4VYnrNCkeEdHeqD0A5UX6BO0T5J/qwPmeo3Z/zEwEQM+a80m5hFc/bLB2
	I4Cz0I3zBSjubue11KZH0GuU9avpYR99kUMoQVmRQrAS8IBiStrrub+38EvZHishVB8iaE
	2yd4rnpKJ2Mx0O5wZ4O82kcFRADBbZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757592101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qTcZOMPNJimAbyd8RtPoSsZk0OG2pBh5j6lrygM9lN0=;
	b=kmmshWh0I3qnNavCOUNQ4fCmErW7NQ3M00b4ZSF9ZDqJFkbBTOIxZKhDt5J1j0/J6/MFtY
	h+LOC/A8sY3jL7Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757592101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qTcZOMPNJimAbyd8RtPoSsZk0OG2pBh5j6lrygM9lN0=;
	b=s9mW5lc6BliPQ4VYnrNCkeEdHeqD0A5UX6BO0T5J/qwPmeo3Z/zEwEQM+a80m5hFc/bLB2
	I4Cz0I3zBSjubue11KZH0GuU9avpYR99kUMoQVmRQrAS8IBiStrrub+38EvZHishVB8iaE
	2yd4rnpKJ2Mx0O5wZ4O82kcFRADBbZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757592101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qTcZOMPNJimAbyd8RtPoSsZk0OG2pBh5j6lrygM9lN0=;
	b=kmmshWh0I3qnNavCOUNQ4fCmErW7NQ3M00b4ZSF9ZDqJFkbBTOIxZKhDt5J1j0/J6/MFtY
	h+LOC/A8sY3jL7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 099A01372E;
	Thu, 11 Sep 2025 12:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nslSAiW6wmifOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Sep 2025 12:01:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AAFABA0A2D; Thu, 11 Sep 2025 14:01:36 +0200 (CEST)
Date: Thu, 11 Sep 2025 14:01:36 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <refau7p3ulgz3z35bflhmpds5wdywuvcupaqza2c3fwk45qgtu@qfg255gzs4l3>
References: <20250909143734.30801-1-jack@suse.cz>
 <20250909144400.2901-5-jack@suse.cz>
 <aMBbSxwwnvBvQw8C@slm.duckdns.org>
 <6wl26xqf6kvaz4527m7dy2dng5tu22qxva2uf2fi4xtzuzqxwx@l5re7vgx6zlz>
 <aMGw9AjS11coqPF_@slm.duckdns.org>
 <7ilbnkfbhv5mtshehvphe4tfiuwg7o52cexd3x4thwizkpjgbt@dycc7ac677t7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ilbnkfbhv5mtshehvphe4tfiuwg7o52cexd3x4thwizkpjgbt@dycc7ac677t7>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 11-09-25 13:30:13, Jan Kara wrote:
> On Wed 10-09-25 07:10:12, Tejun Heo wrote:
> > Hello, Jan.
> > 
> > On Wed, Sep 10, 2025 at 10:19:36AM +0200, Jan Kara wrote:
> > > Well, reducing @max_active to 1 will certainly deal with the list_lock
> > > contention as well. But I didn't want to do that as on a busy container
> > > system I assume there can be switching happening between different pairs of
> > > cgroups. With the approach in this patch switches with different target
> > > cgroups can still run in parallel. I don't have any real world data to back
> > > that assumption so if you think this parallelism isn't really needed and we
> > > are fine with at most one switch happening in the system, switching
> > > max_active to 1 is certainly simple enough.
> > 
> > What bothers me is that the concurrency doesn't match between the work items
> > being scheduled and the actual execution and we're resolving that by early
> > exiting from some work items. It just feels like an roundabout way to do it
> > with extra code. I think there are better ways to achieve per-bdi_writeback
> > concurrency:
> > 
> > - Move work_struct from isw to bdi_writeback and schedule the work item on
> >   the target wb which processes isw's queued on the bdi_writeback.
> > 
> > - Or have a per-wb workqueue with max_active limit so that concurrency is
> >   regulated per-wb.
> > 
> > The latter is a bit simpler but does cost more memory as workqueue_struct
> > isn't tiny. The former is a bit more complicated but most likely less so
> > than the current code. What do you think?
> 
> That's a fair objection and good idea. I'll rework the patch to go with
> the first variant.

I've realized why I didn't do something like this from the beginning. The
slight snag is that you can start switching inode's wb only once rcu period
expires (so that I_WB_SWITCH setting is guaranteed to be visible). This
makes moving the work struct to bdi_writeback sligthly tricky. It shouldn't
be too bad so I think I'll try it and see how it looks like.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

