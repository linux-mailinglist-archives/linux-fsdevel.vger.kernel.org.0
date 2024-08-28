Return-Path: <linux-fsdevel+bounces-27559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8BB96260B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F181F268DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249216F84C;
	Wed, 28 Aug 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l4+w46JQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="agMZTpqI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l4+w46JQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="agMZTpqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42297160783;
	Wed, 28 Aug 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844478; cv=none; b=ZZiiWedsH2BUOsBhmVaOlKw9GHqB1nCp/g3WDTPUvzngtGEDixzETryMeYRpas55Y7ucgLHajFOuvrgSwHD82dDcB5ShOHbPrreSn+vn+W3aGGALwqMwFtPkPckLZjPABGtXiJjyaPYxqa9KAO+EXiFIQ9FjeoYTvNJ//ykkjF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844478; c=relaxed/simple;
	bh=VWQG8+aRF2xvyXnQGwSljKWlaVinX4srb3SLVvJYP48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkZeIvrxiw8gF+SGvagQNpk8LiZW0dLRzs1dUvl3HDrx/KxK2kQHfSPAAta9TGCwoU65b0hq1VKZwZLr+PMV5qLVP4MgyY6wAbl/pEowVDts/aq4IwsjlbmdXY/9egLG56Q497FhzDKMzRzpHM7HwwLsmX3BvjDU/KDE86GE/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l4+w46JQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=agMZTpqI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l4+w46JQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=agMZTpqI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F86221B53;
	Wed, 28 Aug 2024 11:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724844474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YG+DtzoYRs5hBGE8LTx8nF0noHi0zTg4zdMtH36T8gE=;
	b=l4+w46JQYBGAGwm96WJs/TLVw1ZMy9SgnX0jYXCtRqEZsKBxVNTqrPSZuZWRHndKCffwCQ
	EwFBY4pMeBZbYz9fCvR5nm5R01t2exNvB56OxMwcGaHlo15g+eEX5+AvHCzkk7c6YRMq9i
	a8MRoVJ/U5Cs2YeigpQGtNwi0vcWp0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724844474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YG+DtzoYRs5hBGE8LTx8nF0noHi0zTg4zdMtH36T8gE=;
	b=agMZTpqIoNvPP4xQpUfo4DK9ppBNRc1jiJPtlRw6pFERDoCdlXrCxZiCniyoMLOYVrmovR
	fitEv6TRvX46MvAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=l4+w46JQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=agMZTpqI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724844474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YG+DtzoYRs5hBGE8LTx8nF0noHi0zTg4zdMtH36T8gE=;
	b=l4+w46JQYBGAGwm96WJs/TLVw1ZMy9SgnX0jYXCtRqEZsKBxVNTqrPSZuZWRHndKCffwCQ
	EwFBY4pMeBZbYz9fCvR5nm5R01t2exNvB56OxMwcGaHlo15g+eEX5+AvHCzkk7c6YRMq9i
	a8MRoVJ/U5Cs2YeigpQGtNwi0vcWp0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724844474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YG+DtzoYRs5hBGE8LTx8nF0noHi0zTg4zdMtH36T8gE=;
	b=agMZTpqIoNvPP4xQpUfo4DK9ppBNRc1jiJPtlRw6pFERDoCdlXrCxZiCniyoMLOYVrmovR
	fitEv6TRvX46MvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B820138D2;
	Wed, 28 Aug 2024 11:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ODMoAroJz2aNfQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 Aug 2024 11:27:54 +0000
Date: Wed, 28 Aug 2024 13:27:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: dsterba@suse.com, gustavoars@kernel.org, kees@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] affs: Replace one-element array with flexible-array
 member
Message-ID: <20240828112744.GF25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240827124839.81288-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827124839.81288-2-thorsten.blum@toblux.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 2F86221B53
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Aug 27, 2024 at 02:48:40PM +0200, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible-array
> member in the struct affs_root_head.
> 
> Add a comment that most struct members are not used, but kept as
> documentation.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Added to affs queue, thanks.

