Return-Path: <linux-fsdevel+bounces-39426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18DFA140DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406793A6C49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C658B22CBE6;
	Thu, 16 Jan 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZofFKUdP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yCDl4VN8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZofFKUdP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yCDl4VN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F321153808;
	Thu, 16 Jan 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048580; cv=none; b=ZbLiRpYn75u1mgwfTziNbG63L7M+nEamiIQmLlm2LfOIkE2BQnAVO7V15tMDKz5JwuW2sFUyh7n1xNmM/7CAumtyA4owTYwX80+xNEOBHPdZCKOtlwI4N0XfoOsF5zhu1ObhMg4WPpWhcDAxxYEzzTXwzbQd6y1Q1AU6I9kSwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048580; c=relaxed/simple;
	bh=7l51WjPu97EDfB6VPXbw9S2Es1cJDTh/tGJggMwlruI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw53prWlVv8qMtgB9br87aZcQy1UcaNSU+3pqTl+mGcq/Hj+NcMKiT0fMG2VlFS1V3G44uQHY/r7e4hsfcgiTta0juzkOqt3SiRsa25uAgs3SCnOrBTczaQwqz5podKzQ5fkwBJ+F3yes4OatvzkNUTKuuz0wVf4UZ8/JEAJvDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZofFKUdP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yCDl4VN8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZofFKUdP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yCDl4VN8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 632491F38E;
	Thu, 16 Jan 2025 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737048576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPN/9c0cxWC07npTA/MllFU1FZQlSqobj+lLyblY5kc=;
	b=ZofFKUdPI2xXighG3hXMOI5Hymdz9T7+MPO9dAGE3QCqSee+tY3RagusPJMA1rV3LZAL8B
	ZggJ4mf5b967dRH3nYOnrdLqEgTDNVx2OHokMhXKekg+Znm/ltVtG+7s2MsWUxN8Hv+KbR
	mUanJ1b+HDvpuymMkfDU7UIQcPbmRls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737048576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPN/9c0cxWC07npTA/MllFU1FZQlSqobj+lLyblY5kc=;
	b=yCDl4VN8y39lt/KlcA07eHOKtqbgBng/xkuImWMeCnXWpsr3OoDR/kfR2C2w1jJMl9KNCK
	0tKcEZCKq+NzniBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737048576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPN/9c0cxWC07npTA/MllFU1FZQlSqobj+lLyblY5kc=;
	b=ZofFKUdPI2xXighG3hXMOI5Hymdz9T7+MPO9dAGE3QCqSee+tY3RagusPJMA1rV3LZAL8B
	ZggJ4mf5b967dRH3nYOnrdLqEgTDNVx2OHokMhXKekg+Znm/ltVtG+7s2MsWUxN8Hv+KbR
	mUanJ1b+HDvpuymMkfDU7UIQcPbmRls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737048576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPN/9c0cxWC07npTA/MllFU1FZQlSqobj+lLyblY5kc=;
	b=yCDl4VN8y39lt/KlcA07eHOKtqbgBng/xkuImWMeCnXWpsr3OoDR/kfR2C2w1jJMl9KNCK
	0tKcEZCKq+NzniBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54A3313332;
	Thu, 16 Jan 2025 17:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBlVFABCiWcdRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 17:29:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F324EA08E0; Thu, 16 Jan 2025 18:29:35 +0100 (CET)
Date: Thu, 16 Jan 2025 18:29:35 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] time to reconsider tracepoints in
 the vfs?
Message-ID: <lhwszp5bwz7j34yyblf5sjpqv2rxltezwgholxgxp265hrjzu3@5uk7cojbup5o>
References: <20250116124949.GA2446417@mit.edu>
 <20250116165321.GH1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116165321.GH1977892@ZenIV>
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 16-01-25 16:53:21, Al Viro wrote:
> On Thu, Jan 16, 2025 at 07:49:49AM -0500, Theodore Ts'o wrote:
> 
> > Secondly, we've had a very long time to let the dentry interface
> > mature, and so (a) the fundamental architecture of the dcache hasn't
> > been changing as much in the past few years, and (b) we should have
> > enough understanding of the interface to understand where we could put
> > tracepoints (e.g., close to the syscall interface) which would make it
> > much less likely that there would be any need to make
> > backwards-incompatible changes to tracepoints.
> 
> FWIW, earlier this week I'd been going through the piles of tracepoints
> playing with ->d_name.  Mature interface or not, they do manage to
> fuck that up...

Well, tracepoints are like any other rarely executed kernel code. The bugs
do accumulate there with higher probability due to lack of testing. But I
guess that's not strong enough reason to refuse them.

I remember you were refusing tracepoints in VFS in the past on the grounds
that it could make code changes harder due to concerns of breaking
tracepoint users. That is a fair concern but I guess it is also a fair
question whether we shouldn't reconsider this decision given how the rest
of the Linux kernel and the tracing ecosystem around it evolves...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

