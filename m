Return-Path: <linux-fsdevel+bounces-62569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13360B999FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFE919C41C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF22FE050;
	Wed, 24 Sep 2025 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZpZc9ExS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eJzzAfjf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZpZc9ExS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eJzzAfjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5F2DE6FC
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714170; cv=none; b=U2vSsY63fA4BuLqoEhFOlkdinnIuDoCrQEsQAUf+Or67+7dvZ9JPuBg1K7Kn5Lazn1xAHEHidYjd42V/+H+08f1m5Jq55R3DCNuP9GNVOoH4YygPE72P6TNGJlsHUecd0LcVXFgFXiQRiDB9sim3+EsYQD5m/AOIgZa5PzfAp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714170; c=relaxed/simple;
	bh=P72sCjtqlav1Eav3FdEFxKCcRD7pGb5qzWa+LZPl1eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUTvJEjpHxARw4ecM/q28EXiuJe/aPuwaA/KQA4a3SbHmBd4jpD9/WXZXpD8obM6rq7ovv5m2FR9Axc48FuCMcbKUxIH/txCdVGikZ+sebKCxfDChk86eeGm6BmaZE9Qm9fxitKcgqZmafujPulyH9sWyT4tm77MM9JFleppeAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZpZc9ExS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eJzzAfjf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZpZc9ExS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eJzzAfjf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A31E85BEA2;
	Wed, 24 Sep 2025 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758714163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ruMyW2fN22POrd3l2d9VpyIPcF9CiugTtu99dUk0N4=;
	b=ZpZc9ExSpPFAXfshpdJnK0veKjPx2QMOex17Fnq00NXniqHMJBrH89M8M4ABzQ8dQlz42H
	Eq/r8gj+mT8+UJH/Ejo4pFj3XVvduT9cFxhGiPnpPBcfoKZEw25fnsVcC+kHGmAgt37CVt
	Dd5v2MLrwHitXtUPmm5i7amGcA+V8Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758714163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ruMyW2fN22POrd3l2d9VpyIPcF9CiugTtu99dUk0N4=;
	b=eJzzAfjfq5EQQRw/mM3NMIaqtTUqfhNZdSaC+ccywDddTRq3Y4RyX4NUGUX5Dt2LR/cfHs
	Sz0TFflBHyJvnfCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZpZc9ExS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eJzzAfjf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758714163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ruMyW2fN22POrd3l2d9VpyIPcF9CiugTtu99dUk0N4=;
	b=ZpZc9ExSpPFAXfshpdJnK0veKjPx2QMOex17Fnq00NXniqHMJBrH89M8M4ABzQ8dQlz42H
	Eq/r8gj+mT8+UJH/Ejo4pFj3XVvduT9cFxhGiPnpPBcfoKZEw25fnsVcC+kHGmAgt37CVt
	Dd5v2MLrwHitXtUPmm5i7amGcA+V8Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758714163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ruMyW2fN22POrd3l2d9VpyIPcF9CiugTtu99dUk0N4=;
	b=eJzzAfjfq5EQQRw/mM3NMIaqtTUqfhNZdSaC+ccywDddTRq3Y4RyX4NUGUX5Dt2LR/cfHs
	Sz0TFflBHyJvnfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9938213647;
	Wed, 24 Sep 2025 11:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hlhmJTPZ02iqQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 11:42:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5E813A0A9A; Wed, 24 Sep 2025 13:42:43 +0200 (CEST)
Date: Wed, 24 Sep 2025 13:42:43 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 2/2] fs: Defer evicting inodes to a workqueue
Message-ID: <lgiywop33q665lb7bbrwpchzu7jtl53cuomytqsvbz4vas2xwu@kgo4bmen3vfg>
References: <20250924091000.2987157-1-willy@infradead.org>
 <20250924091000.2987157-3-willy@infradead.org>
 <lofh4re5cnuc4byeude7idmf6m27l22tizpd4uqdmhsyochdm2@pdhq6y5plyya>
 <aNO6baMim2tFMh-C@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNO6baMim2tFMh-C@casper.infradead.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A31E85BEA2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Wed 24-09-25 10:31:25, Matthew Wilcox wrote:
> On Wed, Sep 24, 2025 at 10:28:09AM +0100, Kiryl Shutsemau wrote:
> > > +static void deferred_dispose_inodes(struct list_head *inodes)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&deferred_inode_lock, flags);
> > 
> > Why _irqsave? I don't see any interactions with interrupts.
> 
> Can't we enter reclaim from paths which have interrupts disabled?
> I could easily be wrong about that.

You cannot really do allocation with __GFP_FS set from atomic context?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

