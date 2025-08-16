Return-Path: <linux-fsdevel+bounces-58076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3982B28DEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 14:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BE6AE0CD1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0D29BDA4;
	Sat, 16 Aug 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wEgxsI7+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3znNidQj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j38dKAE8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zmcKAKAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876522253E1
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Aug 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348781; cv=none; b=AxN2g+9uE5/eNbn0OT0GzuUcx2cq/ziqCPgArB9kc3uvy1MOmZ94RNqLjahnWcjL4cdKR2lnMZJu6xUMaunspyoSbr3tf3Azsa6UAgiYjEIU2mRNf1ztsoh/Vi9+vmMbbhW0yPMsezJGyMFOUTafAvEE0gjD4TNZ8RsaZWkOhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348781; c=relaxed/simple;
	bh=oqrQyIXfHDbWsnr7ERp3ridM0mBBH0mYY0fVMoljLkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFNspWpRHEyfyBrZlyLc6XEj2euNvk2Mo0m/wbhndLgSgVTmioxP4WE7eswWQKCbaFtL64ThnyevjrPt15cBM6KbDCxOxU07175HX7LyRhg4DUdnOPE08oJ6Tmm6TeHaIFdRrl7/7uSI5uQeiNvYUBr400JU53ZgtKsY8u2FUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wEgxsI7+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3znNidQj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j38dKAE8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zmcKAKAs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72F692190C;
	Sat, 16 Aug 2025 12:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755348777;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJQEqa9v8718kOSsvxcj/FxmPISevxVZ2InX3UKuGsI=;
	b=wEgxsI7+X/ARM5bIZDKY41AXLZC9JwWc5lDlxau1D5ACwlczq2KZCfkHTqPsQAfy3+soda
	y6qwhi2pvb/xrZWeJFh+OIl8XustvcbaK+sKXk+S5X9paWbnu6RtzbDKr0jrcGXNvdCPXi
	9GvONnhX0FIEgYGhsYTJ3y5c01iBs7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755348777;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJQEqa9v8718kOSsvxcj/FxmPISevxVZ2InX3UKuGsI=;
	b=3znNidQjZuA+GPzVEcLyrZW/6CD6oD0vEoh3Ll3c0UthAkSKAVxbCA0nmdqEqojqJ50FFd
	WOJH+I5l2XB9Y2Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j38dKAE8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zmcKAKAs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755348776;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJQEqa9v8718kOSsvxcj/FxmPISevxVZ2InX3UKuGsI=;
	b=j38dKAE8AkEE3MeRt7qE7MME8+XOp+uJATmzeyMUV0T2BhvwJLcIk1vMJvtPsRNCdNn1o2
	k/4USXIQYr98hqPRbWs3idY4Ey9/vWGUJjiQqLJgSK9UhdwOVZKu2ueIhitdzpZtCqIm9G
	VXLMksQCwfYmuN9xeorqZl3b4Am+a3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755348776;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJQEqa9v8718kOSsvxcj/FxmPISevxVZ2InX3UKuGsI=;
	b=zmcKAKAsyB0fV1t1GzL10RhuD+FI4cJ+jz6ge2aHrnQl7vW97jtw92de3kQDwLNd8dBqvN
	mBev4b0RbhmYfTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AA5813432;
	Sat, 16 Aug 2025 12:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nDenFSh/oGiINgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 16 Aug 2025 12:52:56 +0000
Date: Sat, 16 Aug 2025 14:52:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com, wqu@suse.com, willy@infradead.org
Subject: Re: [PATCH v2 3/3] btrfs: set AS_UNCHARGED on the btree_inode
Message-ID: <20250816125251.GJ22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1755300815.git.boris@bur.io>
 <786282400115bf7701d7f9c6b00a9549f67e29f7.1755300815.git.boris@bur.io>
 <mlfxq3ocdmnzvpykzo3zmeebdv5rpohk64aevx3fbwvmj6xitb@ebxlwsd72utx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mlfxq3ocdmnzvpykzo3zmeebdv5rpohk64aevx3fbwvmj6xitb@ebxlwsd72utx>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 72F692190C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Fri, Aug 15, 2025 at 05:50:28PM -0700, Shakeel Butt wrote:
> On Fri, Aug 15, 2025 at 04:40:33PM -0700, Boris Burkov wrote:
> > extent_buffers are global and shared so their pages should not belong to
> > any particular cgroup (currently whichever cgroups happens to allocate
> > the extent_buffer).
> > 
> > Btrfs tree operations should not arbitrarily block on cgroup reclaim or
> > have the shared extent_buffer pages on a cgroup's reclaim lists.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> I think mm-tree is better for this series.

Agreed, majority of the changes are in MM code and the btrfs side is not
something that would affect other testing.

Acked-by: David Sterba <dsterba@suse.com>

