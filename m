Return-Path: <linux-fsdevel+bounces-30869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B499998EF31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC8F1C21B74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501DF176AA5;
	Thu,  3 Oct 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wSDE+nck";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XzPm7e1h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Czuoq9RD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GBhlf2ke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E701547FB;
	Thu,  3 Oct 2024 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958429; cv=none; b=XfwsUofYZ1DINLT1WtONduHeRw4qN4xSrRydowIfke7kNcQZ64OjtLDaH4+3+b0CfUa/p/40qBh01y3hP6lBjXCWnFKcAfRFFBu5m5mr3H+ypbYl5TKQirG7uSVxMI24UTllN+O/ocY8Y/SqDKCTREd3CaTXGVi/eFY/np02eXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958429; c=relaxed/simple;
	bh=of1CAKCU6m9a9bvJwztLsc71cdCwNBtGNn5TVrUVLy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahlXsJBgCI84c2Qbn4tR6/cckXEisdnP5X9vSZ6JJrFe4XfF6dcbqZB4gc6o3ETR+lCXS+DnDA8sDosLd8Pd/HrAcciwrYNSk8j0ivdVv/6UhFQLhfV09DMiGoD/YQ4GbLU6YSbNzCKtXLd9pPfHJExTiFSnehPeeHLA4C+TUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wSDE+nck; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XzPm7e1h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Czuoq9RD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GBhlf2ke; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D01081FB54;
	Thu,  3 Oct 2024 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727958426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YP2qHtU0N9ZMwK7TTCsywKX9IUV7LXQfmN/RlPXssq4=;
	b=wSDE+nckiQxEwJWyrwhKyakcRibw+09AZx57kl+/z5ZsECSo/4QxXXE/kNq1oTMEU/novI
	lqJNBYKWM4wrUnADknyqiBB8M/+92BR4EUwZ9xnes8iHQ7Tocf5/lrgrynPV/Pwo+LByGG
	T15tcTxQuz93aIEmmquuTLCJAPEOTlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727958426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YP2qHtU0N9ZMwK7TTCsywKX9IUV7LXQfmN/RlPXssq4=;
	b=XzPm7e1h720vpqyDp9SSyXLoxp0VsLFUwhqKPuAMEW2B1s2eioTkdwLoSlEbLvA8Yvvc9g
	ersku83qF1zIUzDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Czuoq9RD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GBhlf2ke
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727958425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YP2qHtU0N9ZMwK7TTCsywKX9IUV7LXQfmN/RlPXssq4=;
	b=Czuoq9RDD0BGxrl20YCDm1MYWiyDLswqg2kh1VH/P52WKZFX8Oii1zQPfEdzoV8v1zI6Sz
	Q3+2LWapWH+L7dWtybW+BsqJISD8b9BmlHcbSvGVXxif0omWvk40fJOOjlWIgeoNSIRPYX
	XBvn1wGfaKGEvv0NP3wkbcPp0syiDTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727958425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YP2qHtU0N9ZMwK7TTCsywKX9IUV7LXQfmN/RlPXssq4=;
	b=GBhlf2keqrTgcraiG1FApHP1oNCrOB4uD4P4BxHXAAAkhl8k+/bEm1bbkUWVTmCdjjf/8s
	WLWbiHOHLdtr6bAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEA1C13882;
	Thu,  3 Oct 2024 12:27:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fzBJLpmN/mbKJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 12:27:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7DA99A086F; Thu,  3 Oct 2024 14:26:57 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:26:57 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241003122657.mrqwyc5tzeggrzbt@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <Zv6J34fwj3vNOrIH@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6J34fwj3vNOrIH@infradead.org>
X-Rspamd-Queue-Id: D01081FB54
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,fromorbit.com,vger.kernel.org,linux.dev,linux-foundation.org,linux.microsoft.com,google.com,hallyn.com,chromium.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 03-10-24 05:11:11, Christoph Hellwig wrote:
> On Thu, Oct 03, 2024 at 01:57:21PM +0200, Jan Kara wrote:
> > Fair enough. If we go with the iterator variant I've suggested to Dave in
> > [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> > Landlocks hook_sb_delete() into a single iteration relatively easily. But
> > I'd wait with that convertion until this series lands.
> 
> I don't see how that has anything to do with iterators or not.

Well, the patches would obviously conflict which seems pointless if we
could live with three iterations for a few years until somebody noticed :).
And with current Dave's version of iterators it will not be possible to
integrate evict_inodes() iteration with the other two without a layering
violation. Still we could go from 3 to 2 iterations.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

