Return-Path: <linux-fsdevel+bounces-72951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC5FD06660
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 23:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77624300F679
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51A322B64;
	Thu,  8 Jan 2026 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgLq/pXL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WUtz/ibF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgLq/pXL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WUtz/ibF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861C2D7810
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910173; cv=none; b=qS1mBn/NbiAPl41mbqJeFM1BTEy61CvmFBaHLVE9e9FbMa4cGkg+XFw/mSSK+QHuLR/6cwQ/jIlVufLDKcCU3fFV52NXX4qQ2MyHmZ1hgbEgbToonAuMDEIx/18V+5h1XEXFdsanym2GIhmd2TWXQoYUlCp+1URJ0mew2r5dnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910173; c=relaxed/simple;
	bh=fx1VQkjxXOlKD9tfOX2jnH1eGFwLPOY64Rknk+0puwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWKaYNfzJzQUuGCj1ktPNl4kXYzP+I4Zg+8NNEpqqcWv+5iZp7jZ0N95rm5+kCFXpOHHhxRN2tfpJFVdVdb/fzPATYS28rw7D7YBkkRFzNN65Cjc+D9sanKt4U7wgemBGmVUWs8sYOc1TJ4eueZEBwLO08AO5WQnR0VFG7rqyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgLq/pXL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WUtz/ibF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgLq/pXL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WUtz/ibF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2043D5CAC0;
	Thu,  8 Jan 2026 22:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767910170;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4tEP91DHfn3B9fgKRFOZzWyimEqX/zsFHIdsXXaH8M=;
	b=lgLq/pXLfAB8Ke9itw0hUkz1L8S3pRzCXDog3mwQpW3j8KmrHRMScEE+fWUsX3OASaVoti
	cCqVYBScjxfCKv1MnksoCjg9ddoVsrRuipLCpjz/fA7Z+x/HheVzHJEd44NDa0bOGjtU4h
	1AbGNrhcgSPiPP50AkjMRcpWh7+RU7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767910170;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4tEP91DHfn3B9fgKRFOZzWyimEqX/zsFHIdsXXaH8M=;
	b=WUtz/ibFLjeIna0g3ztt1hAmGGCstM7srlC+K7Is4ECVM4XXMcmuNScNJAUt0zDPnii4/4
	8ldWo3ljtj387EAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767910170;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4tEP91DHfn3B9fgKRFOZzWyimEqX/zsFHIdsXXaH8M=;
	b=lgLq/pXLfAB8Ke9itw0hUkz1L8S3pRzCXDog3mwQpW3j8KmrHRMScEE+fWUsX3OASaVoti
	cCqVYBScjxfCKv1MnksoCjg9ddoVsrRuipLCpjz/fA7Z+x/HheVzHJEd44NDa0bOGjtU4h
	1AbGNrhcgSPiPP50AkjMRcpWh7+RU7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767910170;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4tEP91DHfn3B9fgKRFOZzWyimEqX/zsFHIdsXXaH8M=;
	b=WUtz/ibFLjeIna0g3ztt1hAmGGCstM7srlC+K7Is4ECVM4XXMcmuNScNJAUt0zDPnii4/4
	8ldWo3ljtj387EAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F32023EA63;
	Thu,  8 Jan 2026 22:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KAzSOhkrYGlUBAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Jan 2026 22:09:29 +0000
Date: Thu, 8 Jan 2026 23:09:24 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/4] btrfs: stop duplicating VFS code for
 subvolume/snapshot dentry
Message-ID: <20260108220924.GQ21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767801889.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767801889.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Thu, Jan 08, 2026 at 01:35:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently btrfs has copies of two unexported functions from fs/namei.c
> used in the snapshot/subvolume creation and deletion. This patchset
> exports those functions and makes btrfs use them, to avoid duplication
> and the burden of keeping the copies up to date.
> 
> Filipe Manana (4):
>   fs: export may_delete() as may_delete_dentry()
>   fs: export may_create() as may_create_dentry()
>   btrfs: use may_delete_dentry() in btrfs_ioctl_snap_destroy()
>   btrfs: use may_create_dentry() in btrfs_mksubvol()

Great, thanks, we should have done that years ago. We should use the VFS
interfaces though I'm not sure about some of the implementation
differences.

