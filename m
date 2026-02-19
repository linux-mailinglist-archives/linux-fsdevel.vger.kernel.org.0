Return-Path: <linux-fsdevel+bounces-77701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJn7GMv3lmn4swIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:45:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC25B15E659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AB0C3019440
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5F0301704;
	Thu, 19 Feb 2026 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xq5+G16B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nuD4K7bj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xq5+G16B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nuD4K7bj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA430BBBA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501512; cv=none; b=saB4jzOYPwp4GE94ftM0CuHMlDwg/GjItrz/eDL7WJhrWbJs5v/pMzp5MH1FkAjxSlCoBHCugEHOTpDI7+viGD2DJZC4LsGJocCA7y5BoB1iz7fpzdzJ3kiasoRxaf1dvvu1D1WoEOG9qGh+PZIo8rhaqlnQ9764y/NKciO6SFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501512; c=relaxed/simple;
	bh=bxUgeBf/aiscgKEySoloKKEZUIudZSplfETR5q8I4Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0KxIOBjdpQJCb5I47fQpEIw7ujWPHUrw5vCPH6aiIZVqvOqjErYki3x5FeuNoFgKuQYqwhB2FRtFfTJDHLj07H+4RnSLHd4fGZqCJN6vqm+OEgzCHrGfv14kxOYK0kAM+PFXfJu7Gj7pfLKrcb0PTwGdzgFCd0z4RuaSLyefOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xq5+G16B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nuD4K7bj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xq5+G16B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nuD4K7bj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67AEA5BCC3;
	Thu, 19 Feb 2026 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771501509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQmiZygA1wbMu+ENW6V5hajhu11FdtcjIz/SbpfPE9Y=;
	b=Xq5+G16BQpXy8ehJxYJTUeAEarD4MGxhOtb0ntaEGflgaQ3U8TYHEcnoSow2MWC8WDMpic
	iWN6QsTHNeLdFXtWVoBX20x/4NW4P8ErcW1x3H5eGuvFPjAZjoEW3TD7XJEuc3zRlku6WP
	lwJotMaV3FQvZPwykD8j9onf3Cywmxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771501509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQmiZygA1wbMu+ENW6V5hajhu11FdtcjIz/SbpfPE9Y=;
	b=nuD4K7bjX9iXAVjW0JZXSRmzAdKNCG8aq6u3emGHFhk+X+q9J6/O0RneXlFp/qL7GvSWMq
	gAQMxsKBJNwPy9AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771501509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQmiZygA1wbMu+ENW6V5hajhu11FdtcjIz/SbpfPE9Y=;
	b=Xq5+G16BQpXy8ehJxYJTUeAEarD4MGxhOtb0ntaEGflgaQ3U8TYHEcnoSow2MWC8WDMpic
	iWN6QsTHNeLdFXtWVoBX20x/4NW4P8ErcW1x3H5eGuvFPjAZjoEW3TD7XJEuc3zRlku6WP
	lwJotMaV3FQvZPwykD8j9onf3Cywmxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771501509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQmiZygA1wbMu+ENW6V5hajhu11FdtcjIz/SbpfPE9Y=;
	b=nuD4K7bjX9iXAVjW0JZXSRmzAdKNCG8aq6u3emGHFhk+X+q9J6/O0RneXlFp/qL7GvSWMq
	gAQMxsKBJNwPy9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 537743EA65;
	Thu, 19 Feb 2026 11:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KK5bFMX3lmmvQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Feb 2026 11:45:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 155AFA06FE; Thu, 19 Feb 2026 12:45:09 +0100 (CET)
Date: Thu, 19 Feb 2026 12:45:09 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: remove or unexport unused fs_conext infrastructure
Message-ID: <2x23py5ueosaz2nnrukilugh2kb42jgr4sbxakptcjjyin2ih5@systah33aprs>
References: <20260219065014.3550402-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219065014.3550402-1-hch@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77701-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CC25B15E659
X-Rspamd-Action: no action

Hi!

On Thu 19-02-26 07:50:00, Christoph Hellwig wrote:
> now that the fs_context conversion is finished, remove all the bits
> that did not end up having users, or unexport them if the users are
> always built in.

The patches look good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

