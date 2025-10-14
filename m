Return-Path: <linux-fsdevel+bounces-64148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B99BDACA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 19:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0830A18A6F5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 17:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A6D3043CE;
	Tue, 14 Oct 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yDmoKVMt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2WM08dl6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yDmoKVMt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2WM08dl6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBA286415
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760463432; cv=none; b=dVWsd13DXLDkabvLSAhm0SZBfyfw6fiv84kjsFbN/sTn/+oNgYOVXFvhe2ycCodxVsvYm18a/V/bCrBx9q6gKARX53z+64sYraefYjzk3FEZvXJ77ABYQ+5veAtPognZ9uC51riXEKUk1eiYdSFMY+ZOlaax0YSq7Dxs1QyY9gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760463432; c=relaxed/simple;
	bh=dY/RFrbmWlt8IeoS8JhQFRVZS62JakHON7QI05BM5Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cePG7T6lBqaBiJnvSjrEGJtxttLvVNLvIa4+odyymDSSpuZ8hTEouu+/1Ffh6q4fxu/zeyoZoxjezlFdyt0yXM2ucvMFPE9U+PLhVFESzGxez8sXZbNIKQJgptqpQc1AduRI+5NXHg1pHS0nAYwTsbB42rj5O0Kg7IZizMov6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yDmoKVMt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2WM08dl6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yDmoKVMt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2WM08dl6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76C2C203BB;
	Tue, 14 Oct 2025 17:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760463428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAlEg30Xh123ICsXxHR1i8eLACocDbvHskeA1BeozEc=;
	b=yDmoKVMtwLRJOBlla660Ag05yHaNOU1W1IV4a81qJLQLwqxGC/tzhmPsEY7YTuWQLSSusc
	2291jCfcaCjyFff6ysHIWs13HLYVAPOEznX0vps0yRRO4+BBD3fZAwaTxqQOW1HbUGxcjb
	+ZEbO3Vcv2kGHiKZVUmyXj5b7OVr+N4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760463428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAlEg30Xh123ICsXxHR1i8eLACocDbvHskeA1BeozEc=;
	b=2WM08dl6lr7hfNBq0u+y+9D4Fb7mJE8UhxacJqdxQbZMxWliQxqE7oANIJuKqumg4DkUsY
	rcpsVna643JvdGBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yDmoKVMt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2WM08dl6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760463428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAlEg30Xh123ICsXxHR1i8eLACocDbvHskeA1BeozEc=;
	b=yDmoKVMtwLRJOBlla660Ag05yHaNOU1W1IV4a81qJLQLwqxGC/tzhmPsEY7YTuWQLSSusc
	2291jCfcaCjyFff6ysHIWs13HLYVAPOEznX0vps0yRRO4+BBD3fZAwaTxqQOW1HbUGxcjb
	+ZEbO3Vcv2kGHiKZVUmyXj5b7OVr+N4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760463428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAlEg30Xh123ICsXxHR1i8eLACocDbvHskeA1BeozEc=;
	b=2WM08dl6lr7hfNBq0u+y+9D4Fb7mJE8UhxacJqdxQbZMxWliQxqE7oANIJuKqumg4DkUsY
	rcpsVna643JvdGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BFEF139B0;
	Tue, 14 Oct 2025 17:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5/kaDkSK7mgpMwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 Oct 2025 17:37:08 +0000
Date: Tue, 14 Oct 2025 19:37:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, David Sterba <dsterba@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>,
	"ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 04/10] btrfs: use the local tmp_inode variable in
 start_delalloc_inodes
Message-ID: <20251014173706.GB13776@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-5-hch@lst.de>
 <aae79ea0-f056-4da7-8a87-4d4fd6aea85f@wdc.com>
 <20251014044421.GA30920@lst.de>
 <57d7136c-b209-4f8f-bb6f-8ced354d205a@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d7136c-b209-4f8f-bb6f-8ced354d205a@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 76C2C203BB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9qow8fch3pfgh43469ius4rs)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Tue, Oct 14, 2025 at 07:02:11AM +0000, Johannes Thumshirn wrote:
> On 10/14/25 6:44 AM, hch wrote:
> > On Mon, Oct 13, 2025 at 08:11:35AM +0000, Johannes Thumshirn wrote:
> >> If you have to repost this for some reason, can you rename tmp_inode to
> >> vfs_inode or sth like that?
> >>
> >> The name is really confusing and the commit introducing it doesn't
> >> describe it really either.
> > It is.  vfs_inode is kinda weird, too.  The problem is that inode
> > is used for the btrfs_inode.  But if there's consensus on a name
> > I'll happily change it.
> >
> I unfortunately don't have one :( David?

For this series it's fine to use tmp_inode as it's already there, we can
rename it later.

