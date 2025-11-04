Return-Path: <linux-fsdevel+bounces-66893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD39C3004E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 09:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FF234FA013
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23D314B93;
	Tue,  4 Nov 2025 08:39:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524C9314B71
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245557; cv=none; b=WWXHygbaEgwPnmOMvcOz2kYQjNRL6HSn1aI3xBOx0hs3HVY5nqZSiD/dFkteAPl9PzEwhEm+2HzDESWZbvvuXSGciIPlV3EUmO9UIuj+Vrh+j8N3hp6x9l2gaXl7z3ygcjRyeeZGn1NjM6KW4V5/RuayG8CFnTfXXjDVitkJENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245557; c=relaxed/simple;
	bh=oH6/sifjQPHWDZWu1ZZahi/B7nF3syuHIhF3RTu61Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTX3a/BFd7fwWEFMGVOwL6a8vgRTrK9smFKia9Pm+z/t1W9rGkoc8rW4JLPhE5KbXobLrxmuudB4e6YMsclWWgz6xXIs9zsFXmvFGaGzOrDUcZdEL34db07ptuU5iLHYyu25PZwnjqd/GryPRwrnpIkrcnlPh2AKKzAhwm7GRxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1619211A6;
	Tue,  4 Nov 2025 08:39:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 963FA139A9;
	Tue,  4 Nov 2025 08:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xnqtJLK7CWkLZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 08:39:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 44C02A2812; Tue,  4 Nov 2025 09:39:14 +0100 (CET)
Date: Tue, 4 Nov 2025 09:39:14 +0100
From: Jan Kara <jack@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	Askar Safin <safinaskar@gmail.com>
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
Message-ID: <l4nrvt3dxy3wstryugdevnjub6g6e4qzsrpnqpdb2xo5qidxh2@yxcosrvhx6rh>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org>
 <cbf7af56-c39a-4f42-b76d-0d1b3fecba9f@suse.com>
 <urm6i5idr36jcs7oby33mngrqaa6eu6jky3kubkr3fyhlt6lnd@wqrerkdn3vma>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <urm6i5idr36jcs7oby33mngrqaa6eu6jky3kubkr3fyhlt6lnd@wqrerkdn3vma>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: A1619211A6
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

On Tue 04-11-25 09:28:27, Jan Kara wrote:
> On Tue 04-11-25 07:25:06, Qu Wenruo wrote:
> > 
> > 
> > 在 2025/11/3 22:26, Christoph Hellwig 写道:
> > > The emergency sync being non-blocking goes back to day 1.  I think the
> > > idea behind it is to not lock up a already messed up system by
> > > blocking forever, even if it is in workqueue.  Changing this feels
> > > a bit risky to me.
> > 
> > Considering everything is already done in task context (baked by the global
> > per-cpu workqueue), it at least won't block anything else.
> > 
> > And I'd say if the fs is already screwed up and hanging, the
> > sync_inodes_one_sb() call are more likely to hang than the final sync_fs()
> > call.
> 
> Well, but notice that sync_inodes_one_sb() is always called with wait == 0
> from do_sync_work() exactly to skip inodes already marked as under
> writeback, locked pages or pages under writeback as waiting for these has
> high chances of locking up. Suddently calling sync_fs_one_sb() with wait ==
> 1 can change things. That being said for ext4 the chances of locking up
> ext4_sync_fs() with wait == 1 after sync_fs_one_sb() managed to do
> non-trivial work are fairly minimal so I don't have strong objections
> myself.

Ah, ok, now I've checked the code and read patch 1 in this thread. Indeed
sync_inodes_one_sb() ignores the wait parameter and waits for everything.
Given we've been running like this for over 10 years and nobody complained
I agree calling sync_fs_one_sb() with wait == 1 is worth trying if it makes
life better for btrfs.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

