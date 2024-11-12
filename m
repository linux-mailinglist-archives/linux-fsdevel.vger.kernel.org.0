Return-Path: <linux-fsdevel+bounces-34433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A379C5621
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 12:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6257928C149
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666AB2245E5;
	Tue, 12 Nov 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lZdYuUDc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bg3xrTMh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lZdYuUDc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bg3xrTMh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BCB21502C;
	Tue, 12 Nov 2024 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408833; cv=none; b=PkOiMx/Y3r+Q8HWBu1pJBaHtuuHWz01QnqO5kECT+JXFckVgM51/3d0x6+69Ps/oT0TZT5OdlDRBjsIg6lXD3JR2b30O3qACreoMGLh2wbETswOumAcGBE8j/JtKoc1hVGXPLcw5Gqm+JsmpRDlF3xEF+xW4SlT5notbE1wCQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408833; c=relaxed/simple;
	bh=995iBmPm1i4W18GxviHZf2gYPUTyt9t72Pci/pkOWMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei5BKuYN6SOTLrvz9T6Ce73Zma2ArWA6pXtFV7rsXwaB7LSZz74Vk+AAO3q2HEKcH0pCrs1edGEsvZIB+ED37XSU3RXmj0oFThWG0SqNRNBjtQtZcS1L/I0q4Zs3bFR3O7sAxhh7C5t3WhxiPVPiBn+WE+AA/BshnF6q5KQ3dnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lZdYuUDc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bg3xrTMh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lZdYuUDc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bg3xrTMh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2002321297;
	Tue, 12 Nov 2024 10:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731408830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfd7rH/G8Bq/nQidIzI1OLhuGKSbF9fTUijTRaoKJKo=;
	b=lZdYuUDcE4rNKcJrHGudwfQjWIXzP6wif+LpMmCeIJ4BD+ayGlZXNXLj7qLWP9QRRokCtQ
	z0HFqjoWsvFbUTXhhaki2wRUJp2egOAHvP6JAs1rlJaHxTvPSojlvU4XQ4Y1LouWNx9HjC
	ZX/7OR8luqC/yYur7vVnO6QN0uXhD+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731408830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfd7rH/G8Bq/nQidIzI1OLhuGKSbF9fTUijTRaoKJKo=;
	b=bg3xrTMhq9ZaYVb9sWCQxP5I+adZqba5TDAztxpceh/23htljb6MYrGt1JOAyGE21yCQHb
	Iwhs/HU9rE2cXdBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lZdYuUDc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bg3xrTMh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731408830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfd7rH/G8Bq/nQidIzI1OLhuGKSbF9fTUijTRaoKJKo=;
	b=lZdYuUDcE4rNKcJrHGudwfQjWIXzP6wif+LpMmCeIJ4BD+ayGlZXNXLj7qLWP9QRRokCtQ
	z0HFqjoWsvFbUTXhhaki2wRUJp2egOAHvP6JAs1rlJaHxTvPSojlvU4XQ4Y1LouWNx9HjC
	ZX/7OR8luqC/yYur7vVnO6QN0uXhD+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731408830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfd7rH/G8Bq/nQidIzI1OLhuGKSbF9fTUijTRaoKJKo=;
	b=bg3xrTMhq9ZaYVb9sWCQxP5I+adZqba5TDAztxpceh/23htljb6MYrGt1JOAyGE21yCQHb
	Iwhs/HU9rE2cXdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1545F13301;
	Tue, 12 Nov 2024 10:53:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hG0sBb4zM2eXOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 12 Nov 2024 10:53:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A30E4A08D0; Tue, 12 Nov 2024 11:53:49 +0100 (CET)
Date: Tue, 12 Nov 2024 11:53:49 +0100
From: Jan Kara <jack@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, brauner@kernel.org,
	sforshee@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH 0/3] io path options + reflink (mild security
 implications)
Message-ID: <20241112105349.kg347ogngynglr4t@quack3>
References: <20241112033539.105989-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112033539.105989-1-kent.overstreet@linux.dev>
X-Rspamd-Queue-Id: 2002321297
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
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 11-11-24 22:35:32, Kent Overstreet wrote:
> so, I've been fleshing out various things at the intersection of io path
> options + rebalance + reflink, and this is the last little bit
> 
> background: bcachefs has io path options that can be set filesystem
> wide, or per inode, and when changed rebalance automatically picks them
> up and does the right thing
> 
> reflink adds a wrinkle, which is that we'd like e.g. recursively setting
> the foreground/background targets on some files to move them to the
> appropriate device (or nr_replicas etc.), like other data - but if a
> user did a reflink copy of some other user's data and then set
> nr_replicas=1, that would be bad.
> 
> so this series adds a flag to reflink pointers for "may propagate option
> changes", which can then be set at remap_file_range() time based on
> vfs level permission checks.
> 
> so, question for everyone: is write access to the source file what we
> want? or should it be stricter, i.e. ownership matches?

Well, if I understand the impact properly, this seems similar to the
effects vfs_fileattr_set() can have on a file and there we have:

        if (!inode_owner_or_capable(idmap, inode))
                return -EPERM;

So I'd say ownership match would be more consistent.

> then, we're currently missing mnt_idmap plumbing to remap_file_range()
> to do said permissions checks - do we want to do that? or is there an
> easier way?

Well, if you have struct file, you have the mount and thus idmap through
file_mnt_idmap(file). And struct file is available in remap_file_range()
call stack so I'm not sure what is the problem exactly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

