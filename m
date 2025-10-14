Return-Path: <linux-fsdevel+bounces-64101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C35BD8742
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 500D64FB3EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A934D2EB879;
	Tue, 14 Oct 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xHzzbtQG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="16qmTPMq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NaECqKgg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vP5VAX//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91442EA73C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434416; cv=none; b=EFOl+TKpeBqVH+DLOG6y13UJl0et+0rwU0Q54UKxg7bBk4/RHAf6NCaOmlVHe0NhyNZCW5xkMYLokCY/y8zm98xDKLpgicFkVv2jfUw3m7M35DELr58RYUvry0hkgrTAPRemmS/moz3+ifDPPWP26uZI4BAvI3EdswO5LMTx2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434416; c=relaxed/simple;
	bh=puQyyfq+pN2h54oc/BWNK/2Vp0IFA+7A0vuXLLsaJO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdFFMgbr86AqFDo4FE9gsyIyjiQ8DO66cmv3xcZ9J6TEjSwqUsiw/fqDezXON5+pscMIGWQQfuYUxKqESyPmXGL3ETdWO8Dmh06zcEdAZAd6PBtGFHTbqZ9mQe3lgwb7Y1Z9rk63bgdLNaqNoSdprLtRafKZZlkEN0kaveRhjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xHzzbtQG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=16qmTPMq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NaECqKgg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vP5VAX//; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B12311F7B2;
	Tue, 14 Oct 2025 09:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760434412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bu1v0ZsOdAGwtYXCG/q/PJru4MIkuHqF/5/HnD8J37w=;
	b=xHzzbtQGIwea3na2nDBBtUHQCYVl+R4lrrOdnSJT/vknDNYjr+zb3BH7kF5R8Z9ReIr7s7
	8oeltK+lIpc7uiNPWBJFa/vsDggH3nWXkJCf5EllL+ZK7tZpRWDcVZnkLDXOS2PLphnnqA
	qhzt/HIwd8Ivy1zbyofvraqcWTE4jW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760434412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bu1v0ZsOdAGwtYXCG/q/PJru4MIkuHqF/5/HnD8J37w=;
	b=16qmTPMq9Ya8DnrCMADkaJsMgrCHAKaNUvd3JQofXIz30IZYTJ5fsx6dhNS9LiGSVjSJhf
	4MfmzQ8JrkN89pBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NaECqKgg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="vP5VAX//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760434410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bu1v0ZsOdAGwtYXCG/q/PJru4MIkuHqF/5/HnD8J37w=;
	b=NaECqKggLq8fTYGbKvSAiCuRZdr3+9HhjsTNR1BSu02lITDfqhzA6+TCH9jpKHWdpZGzr7
	5FuW51Eo1RgIg7MgMNtHA4/HgVwLVezGUtBiUaNxgWNpcDkh7Z3ajhSreD7VB41gTDBOQe
	ej4qi+L9Rs2qxglM5o2QF1emQgcqt48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760434410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bu1v0ZsOdAGwtYXCG/q/PJru4MIkuHqF/5/HnD8J37w=;
	b=vP5VAX//BKm3YMo8HYPJx5WbHvSRihWzLL6OI67rr+DUiEHOr+lFjqNyOD/u5H7D/BSFWt
	+EUkM3zJxNArduCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A16C4139B0;
	Tue, 14 Oct 2025 09:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eaVjJ+oY7mjaUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Oct 2025 09:33:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B1F7A0A58; Tue, 14 Oct 2025 11:33:26 +0200 (CEST)
Date: Tue, 14 Oct 2025 11:33:26 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 06/10] mm,btrfs: add a filemap_fdatawrite_kick_nr helper
Message-ID: <qh7xhmefm54k3hgny3iwkxbdrgjf35swqokiiicu5gg3ahvf4s@xhyw4sfagjgw>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-7-hch@lst.de>
 <74593bac-929b-4496-80e0-43d0f54d6b4c@kernel.org>
 <4bcpiwrhbrraau7nlp6mxbffprtnlv3piqyn7xkm7j2txxqlmn@3knyilc526ts>
 <20251014044723.GA30978@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014044723.GA30978@lst.de>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B12311F7B2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

On Tue 14-10-25 06:47:23, Christoph Hellwig wrote:
> On Mon, Oct 13, 2025 at 01:58:15PM +0200, Jan Kara wrote:
> > I don't love filemap_fdatawrite_kick_nr() either. Your
> > filemap_fdatawrite_nrpages() is better but so far we had the distinction
> > that filemap_fdatawrite* is for data integrity writeback and filemap_flush
> > is for memory cleaning writeback. And in some places this is important
> > distinction which I'd like to keep obvious in the naming. So I'd prefer
> > something like filemap_flush_nrpages() (to stay consistent with previous
> > naming) or if Christoph doesn't like flush (as that's kind of overloaded
> > word) we could have filemap_writeback_nrpages().
> 
> Not a big fan of flush, but the important point in this series is
> to have consistent naming.

I fully agree on that.

>  If we don't like the kick naming we should standardize on _flush (or
>  whatever) and have the _range and _nrpages variants of whatever we pick
>  for the base name.
> 
> Anyone with strong feelings and or good ideas about naming please speak
> up now.

I agree with either keeping filemap_flush* or using filemap_writeback* (and
renaming filemap_flush to filemap_writeback).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

