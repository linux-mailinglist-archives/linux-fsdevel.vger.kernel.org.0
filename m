Return-Path: <linux-fsdevel+bounces-61039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28440B54A11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D221CC0B74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF9C2EB840;
	Fri, 12 Sep 2025 10:40:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790B19992C
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673600; cv=none; b=iARJAD8Fz02hpZ7Hn+2v+eWKP9yXvV4ORJCjxTZHNequa4lUeu18q1Y8OxRiwfRpps+AbzZF98j1tEVwccCUwv920BE9lwN5W/itKf0AtIBB7a/eu14hHIaKP4pWr+VZDmUUtuypyqmhKEY+g2zPkz1odSdeReP9kNYmpzNbuno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673600; c=relaxed/simple;
	bh=qaabJdKC9CXb6Z4dEhdnVjqZ2Kll82gBHBvK+h0GTJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Weki5sMWxHmr7unJXvCLAh934/EPR/9EmXMTXanOXhK5reraYlyd5Rw02DrHPRHnk7FlYEJ01GxAR2TspL0VpBmpJ3hTY+5oAMvZ3jookQSx3pdYL3gL8liZuLgibnIPoe1as4+yGJJl4vYZE+ZtawCML9/XrV/8WjVKJoV/0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 450DB37660;
	Fri, 12 Sep 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BF1713869;
	Fri, 12 Sep 2025 10:39:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XbShDn34w2iHWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Sep 2025 10:39:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 006B6A098E; Fri, 12 Sep 2025 12:39:56 +0200 (CEST)
Date: Fri, 12 Sep 2025 12:39:56 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <5nx6axg2ldlwvekobzwptastwp6g2vzaol44u4e6snxdqmktru@rpklhcjxiw7y>
References: <20250909143734.30801-1-jack@suse.cz>
 <20250909144400.2901-5-jack@suse.cz>
 <aMBbSxwwnvBvQw8C@slm.duckdns.org>
 <6wl26xqf6kvaz4527m7dy2dng5tu22qxva2uf2fi4xtzuzqxwx@l5re7vgx6zlz>
 <aMGw9AjS11coqPF_@slm.duckdns.org>
 <7ilbnkfbhv5mtshehvphe4tfiuwg7o52cexd3x4thwizkpjgbt@dycc7ac677t7>
 <refau7p3ulgz3z35bflhmpds5wdywuvcupaqza2c3fwk45qgtu@qfg255gzs4l3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <refau7p3ulgz3z35bflhmpds5wdywuvcupaqza2c3fwk45qgtu@qfg255gzs4l3>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 450DB37660
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu 11-09-25 14:01:36, Jan Kara wrote:
> On Thu 11-09-25 13:30:13, Jan Kara wrote:
> > On Wed 10-09-25 07:10:12, Tejun Heo wrote:
> > > Hello, Jan.
> > > 
> > > On Wed, Sep 10, 2025 at 10:19:36AM +0200, Jan Kara wrote:
> > > > Well, reducing @max_active to 1 will certainly deal with the list_lock
> > > > contention as well. But I didn't want to do that as on a busy container
> > > > system I assume there can be switching happening between different pairs of
> > > > cgroups. With the approach in this patch switches with different target
> > > > cgroups can still run in parallel. I don't have any real world data to back
> > > > that assumption so if you think this parallelism isn't really needed and we
> > > > are fine with at most one switch happening in the system, switching
> > > > max_active to 1 is certainly simple enough.
> > > 
> > > What bothers me is that the concurrency doesn't match between the work items
> > > being scheduled and the actual execution and we're resolving that by early
> > > exiting from some work items. It just feels like an roundabout way to do it
> > > with extra code. I think there are better ways to achieve per-bdi_writeback
> > > concurrency:
> > > 
> > > - Move work_struct from isw to bdi_writeback and schedule the work item on
> > >   the target wb which processes isw's queued on the bdi_writeback.
> > > 
> > > - Or have a per-wb workqueue with max_active limit so that concurrency is
> > >   regulated per-wb.
> > > 
> > > The latter is a bit simpler but does cost more memory as workqueue_struct
> > > isn't tiny. The former is a bit more complicated but most likely less so
> > > than the current code. What do you think?
> > 
> > That's a fair objection and good idea. I'll rework the patch to go with
> > the first variant.
> 
> I've realized why I didn't do something like this from the beginning. The
> slight snag is that you can start switching inode's wb only once rcu period
> expires (so that I_WB_SWITCH setting is guaranteed to be visible). This
> makes moving the work struct to bdi_writeback sligthly tricky. It shouldn't
> be too bad so I think I'll try it and see how it looks like.

It actually worked out pretty nicely I think. Posting v2 with the
changes...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

