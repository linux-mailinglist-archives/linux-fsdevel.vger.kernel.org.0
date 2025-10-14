Return-Path: <linux-fsdevel+bounces-64103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B8FBD8793
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 11:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6484D4FB4AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47A22EB858;
	Tue, 14 Oct 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gLakFHMf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R3V5Ygaf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gLakFHMf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R3V5Ygaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1642E8E08
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434663; cv=none; b=DT2L82u3eWh0LHdo1yaOBjwuaAkznJuAOekeWpoGj5hAlXk7lOk0NLvm6xkVRww6gpr2Vv1d6kS2w3gvBOrtSatHEa9zhWGulHbmF5VwBhjXlnFcrDejgILcalcgq8MYNZnSbxtdVmW6OU1oILiNPgoIUjna4xZ7U75nC6hHORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434663; c=relaxed/simple;
	bh=YnfmZD0G5FbvbTkRfBV7iV1KUn7FDK2ItLZKienr+xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV854XECr8XMTZguTNfpAtKMEPJFJaB+fN8eVk4GDsCFb8pHWpB5IluVeFzp63uFpSFLK5QcIpq3rfoeJdShNtJTFszjDtCoq0xIxhyu6sI4CKG2X18tY8AFbnbVH5KeeLtIQVTKbYNWgLMr/DIRSTVFxVMoS7kQ9QK/GQJK77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gLakFHMf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R3V5Ygaf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gLakFHMf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R3V5Ygaf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD9841F7B0;
	Tue, 14 Oct 2025 09:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760434659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6LiiOpwbJnE+aZ8BNjDQXm+fWtAs5O6T76Dc5boMVA=;
	b=gLakFHMfL+KFmwF6T6Oe9d0cmR0S/FGK4Hjz35D5giH1rJ5nMEm7gI7ibnvxFeYMVkhQpZ
	eki+Nlt+U1ywDGRA5m5QDrNfZZJ/3IUz2MFf6SKvxv+NXs1vcyYl6z7CLBDeofetl6ySj9
	B7iJw1AsCBRi5KVkDPqF0OkqZsvISq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760434659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6LiiOpwbJnE+aZ8BNjDQXm+fWtAs5O6T76Dc5boMVA=;
	b=R3V5YgafiR7rMgcGwINQ0jyEETmmkbLsce7GkM+/Wx+Qg1rGbJ9tv2JONNE7uldKFayP23
	xPMtLRJasD60ScAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gLakFHMf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R3V5Ygaf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760434659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6LiiOpwbJnE+aZ8BNjDQXm+fWtAs5O6T76Dc5boMVA=;
	b=gLakFHMfL+KFmwF6T6Oe9d0cmR0S/FGK4Hjz35D5giH1rJ5nMEm7gI7ibnvxFeYMVkhQpZ
	eki+Nlt+U1ywDGRA5m5QDrNfZZJ/3IUz2MFf6SKvxv+NXs1vcyYl6z7CLBDeofetl6ySj9
	B7iJw1AsCBRi5KVkDPqF0OkqZsvISq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760434659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6LiiOpwbJnE+aZ8BNjDQXm+fWtAs5O6T76Dc5boMVA=;
	b=R3V5YgafiR7rMgcGwINQ0jyEETmmkbLsce7GkM+/Wx+Qg1rGbJ9tv2JONNE7uldKFayP23
	xPMtLRJasD60ScAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F181139B0;
	Tue, 14 Oct 2025 09:37:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9O/VJuMZ7mj2VgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Oct 2025 09:37:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 54417A0A58; Tue, 14 Oct 2025 11:37:35 +0200 (CEST)
Date: Tue, 14 Oct 2025 11:37:35 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/10] mm: remove __filemap_fdatawrite
Message-ID: <tbgfwzv55cca563r47kwi3ycsguxkp2opco3odtzy62o5lgzk2@mipmgtzthvrd>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-8-hch@lst.de>
 <t4y7xtgfnzfpfupnb7on33n6qzrfxfphsm2hqsa5rx4liqvvbc@wwj7ckhyilpo>
 <20251014045325.GD30978@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014045325.GD30978@lst.de>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: AD9841F7B0
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 14-10-25 06:53:25, Christoph Hellwig wrote:
> On Mon, Oct 13, 2025 at 01:59:21PM +0200, Jan Kara wrote:
> > > -	return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
> > > +	return filemap_fdatawrite_range_kick(mapping, 0, LLONG_MAX);
> > >  }
> > >  EXPORT_SYMBOL(filemap_flush);
> > 
> > filemap_fdatawrite_range_kick() doesn't exist at this point in the series.
> 
> It does exist even in the current upstream kernel.
> filemap_fdatawrite_kick doesn't exist yet.

Aha, I was wondering where that "kick" naming was coming from :) I've
totally missed adding of filemap_fdatawrite_range_kick(). Sorry for the
noise but I still think filemap_flush / filemap_writeback better express
the intention than filemap_fdatawrite_kick.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

