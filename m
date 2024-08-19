Return-Path: <linux-fsdevel+bounces-26271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5A8956D0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56EB1F2407D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452D16D30B;
	Mon, 19 Aug 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zOz7bb7J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="beoJoCpa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zOz7bb7J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="beoJoCpa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948A16CD12;
	Mon, 19 Aug 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077234; cv=none; b=NJ6X2cd4lBqnTjeYcPVSA9zIrXtRuGbpZ6MDnuEFImcCeDSEHPp6soTKSQxQMDjVoknVGyKpIWF1LUomKBx+riXh6T2UvaM8Ju7ferZowtsB/Mb+2ue7zKBqNnQJK9RlGLxNVmLn0b4ihJhyxCgE44oYUvfaqTscsu6p47I9mmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077234; c=relaxed/simple;
	bh=lhowwgA72bi5cxgb/K1+AxEnMjXH5z8XAMxOt3omzOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDQQjuzqXJiSWG68Q+Mzuj648z7xGtMpTGfp8epeCOekIEXiRGcmbOH8OdM2h2PGNnXVaX6qqMJuDtKWGB9RwAJ7n912s0NU+CcWqzdPvFO3URSwSZSeEJlI2GMR9kZB4J/p3XN607D38xQRt0+x11q+ZXXV0l/9J/MnvRP7tiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zOz7bb7J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=beoJoCpa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zOz7bb7J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=beoJoCpa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 282C91FE8D;
	Mon, 19 Aug 2024 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724077228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qtzUWPI+Y8Kihds4XtHuE2FJCP3GVaYf90cUxKzwgM=;
	b=zOz7bb7JX+gd/TsiJR1PXpPW1i+ZPGceMJYvFV+xtKt1xzf+GvsEih2NLTdUObqnL38wy3
	owkosuTkxu9HoHEfzFAoQsRN/wmefxWEfoT7qsgQ6L2mw774yHdmc5/Sa3J6s/C/XBXKIM
	KeCdVeriwLBdsHOKKPWFPcjL1aO9siY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724077228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qtzUWPI+Y8Kihds4XtHuE2FJCP3GVaYf90cUxKzwgM=;
	b=beoJoCpalUzM5bZUCkTn/WSTexIsXf+pM3gHWZe2PrKZftN7ZTLJHbbdXWAhXc4pEEJWug
	kTxYLtpgKi0veFCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724077228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qtzUWPI+Y8Kihds4XtHuE2FJCP3GVaYf90cUxKzwgM=;
	b=zOz7bb7JX+gd/TsiJR1PXpPW1i+ZPGceMJYvFV+xtKt1xzf+GvsEih2NLTdUObqnL38wy3
	owkosuTkxu9HoHEfzFAoQsRN/wmefxWEfoT7qsgQ6L2mw774yHdmc5/Sa3J6s/C/XBXKIM
	KeCdVeriwLBdsHOKKPWFPcjL1aO9siY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724077228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qtzUWPI+Y8Kihds4XtHuE2FJCP3GVaYf90cUxKzwgM=;
	b=beoJoCpalUzM5bZUCkTn/WSTexIsXf+pM3gHWZe2PrKZftN7ZTLJHbbdXWAhXc4pEEJWug
	kTxYLtpgKi0veFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F99A1397F;
	Mon, 19 Aug 2024 14:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LRCLA6xUw2ZcBwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 19 Aug 2024 14:20:28 +0000
Date: Mon, 19 Aug 2024 16:20:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: dsterba@suse.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] affs: Remove unused macros GET_END_PTR,
 AFFS_GET_HASHENTRY
Message-ID: <20240819142018.GJ25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240815213500.37282-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815213500.37282-1-thorsten.blum@toblux.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,toblux.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Aug 15, 2024 at 11:35:01PM +0200, Thorsten Blum wrote:
> The macros GET_END_PTR() and AFFS_GET_HASHENTRY() are not used anymore
> and can be removed. Remove them.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Thanks, added to AFFS branch.

