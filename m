Return-Path: <linux-fsdevel+bounces-71013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC763CAFBE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 12:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D03A530146E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5145B2F9DB0;
	Tue,  9 Dec 2025 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zdr/So3P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sjXMggqj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zdr/So3P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sjXMggqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949C270EC1
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279089; cv=none; b=rUBa0FXJ/vWMCfQId2ks1wTpZVSQCrwd0pzQW4/1Lp5rEJ4WIOE6+vyReQNCrC/8OwL4ZdZ/BzldIKEuyT8HT74Gcz73nuzP1OO1suzhbLya8jYcwMX2p7PQYQAXW+yUQ4KNGcIU7XaAX9y8aHMQ1VRIBq7lYz7gdvFo4qRdDkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279089; c=relaxed/simple;
	bh=yCJiACRnyIPQQWDzQnMwgqJXsScAMy4pWZZYPrPonIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsNidgrqs4oKwhyVgXOXVRu4XpQYJCDMPwfzevy+0OQgCNDen9kHC2xZBZUtgqoK79DMPWQYNEyDNWq7MTYmXEkHypdQqRvLTX/uBAQprMwjd76Uf6GX0/MlJ4QhQlDK0/s1FxDZJ6V2nafdLFbU5ZouBkqgRPgvpiCdSv5XEB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zdr/So3P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sjXMggqj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zdr/So3P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sjXMggqj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DAFC5BD61;
	Tue,  9 Dec 2025 11:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765279086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/IZ5yZBq6NhgU/7G6PZUJUqO+ErcbhOwLl4/QW4uKY=;
	b=Zdr/So3P0iqxm+A6kJPVkypWx4QDHpLIrhcJEXH0rTefDif/y9wJpN435vMIBU2lNsEys9
	/jCk+23xguroiRJ93PL0TVDmf9biXsqrH5WdDxCv75q0w7+Ocu5G5XaV8clC0armK1lTh9
	BowE6tsfeid0SP6BQq7lle4bCHlk9QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765279086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/IZ5yZBq6NhgU/7G6PZUJUqO+ErcbhOwLl4/QW4uKY=;
	b=sjXMggqjgE3cvvOLNAHBZka7bdsRVshUh5iFbHrpf0vQUhqGxnNDZxveIcBGhvmdqx3IQ0
	rNlrybFSNpJohMAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765279086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/IZ5yZBq6NhgU/7G6PZUJUqO+ErcbhOwLl4/QW4uKY=;
	b=Zdr/So3P0iqxm+A6kJPVkypWx4QDHpLIrhcJEXH0rTefDif/y9wJpN435vMIBU2lNsEys9
	/jCk+23xguroiRJ93PL0TVDmf9biXsqrH5WdDxCv75q0w7+Ocu5G5XaV8clC0armK1lTh9
	BowE6tsfeid0SP6BQq7lle4bCHlk9QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765279086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/IZ5yZBq6NhgU/7G6PZUJUqO+ErcbhOwLl4/QW4uKY=;
	b=sjXMggqjgE3cvvOLNAHBZka7bdsRVshUh5iFbHrpf0vQUhqGxnNDZxveIcBGhvmdqx3IQ0
	rNlrybFSNpJohMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 211F53EA63;
	Tue,  9 Dec 2025 11:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jX0NCG4FOGmgIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Dec 2025 11:18:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D0481A0A04; Tue,  9 Dec 2025 12:18:05 +0100 (CET)
Date: Tue, 9 Dec 2025 12:18:05 +0100
From: Jan Kara <jack@suse.cz>
To: Deepakkumar Karn <dkarn@redhat.com>
Cc: djwong@kernel.org, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Subject: Re: [PATCH v2] fs: add NULL check in drop_buffers() to prevent
 null-ptr-deref
Message-ID: <enzq67rnekrh7gycgvgjc4g5ryt7qvuamaqj3ndpmns5svosa4@ozcepp4lpyls>
References: <20251208193024.GA89444@frogsfrogsfrogs>
 <20251208201333.528909-1-dkarn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208201333.528909-1-dkarn@redhat.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[e07658f51ca22ab65b4e];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Tue 09-12-25 01:43:33, Deepakkumar Karn wrote:
> On Mon, 8 Dec 2025 11:30:24 -0800, Darrick J. Wong wrote:
> > > drop_buffers() dereferences the buffer_head pointer returned by
> > > folio_buffers() without checking for NULL. This leads to a null pointer
> > > dereference when called from try_to_free_buffers() on a folio with no
> > > buffers attached. This happens when filemap_release_folio() is called on
> > > a folio belonging to a mapping with AS_RELEASE_ALWAYS set but without
> > > release_folio address_space operation defined. In such case,
> 
> > What user is that?  All the users of AS_RELEASE_ALWAYS in 6.18 appear to
> > supply a ->release_folio.  Is this some new thing in 6.19?
> 
> AFS directories SET AS_RELEASE_ALWAYS but have not .release_folio.

AFAICS AFS sets AS_RELEASE_ALWAYS only for symlinks but not for
directories? Anyway I agree AFS symlinks will have AS_RELEASE_ALWAYS but no
.release_folio callback. And this looks like a bug in AFS because AFAICT
there's no point in setting AS_RELEASE_ALWAYS when you don't have
.release_folio callback. Added relevant people to CC.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

