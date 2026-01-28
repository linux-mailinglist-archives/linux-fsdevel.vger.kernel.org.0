Return-Path: <linux-fsdevel+bounces-75715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD8RIz/5eWkE1QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:55:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A25AA0E87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A0C301FFAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 11:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541A3314D15;
	Wed, 28 Jan 2026 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="va9YLbBY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NFzv08hj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="va9YLbBY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NFzv08hj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91E257821
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601328; cv=none; b=jvS4iO+5AC/T499klo24swJeYsFeufZjwHQo3fyt4ARh5Ud//HXkBlmbortsLBlfnhw/IVCY7zFbj6+uoJi0PBVw/qN3ypSVdmrppiWI/9siOCDk3YsGssRcjqNQdSlW5k0n2hD4EPQyFKeC7ug0J8JUf8qYd7+Fca/PlH1i1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601328; c=relaxed/simple;
	bh=bXda7vcq33bZez/TcVlpOmhFwt77N5BJNTZZiLrjM6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3Fw/4hML3Er9akNn87LJYcjA6KVSNHtoEQ0uTJCAKTsh+e7xebnqNYdrLe9zE0JmNb9aXhuVbNex+qsWf7I6T3OckhzPeTqbqUtTtaw/y5qNTCUtTXmwrLqqzZIpChxyuguLWA/hmqH5WcrxNCs/1k+tohefXa3R4dfTMojRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=va9YLbBY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NFzv08hj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=va9YLbBY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NFzv08hj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1ADB333B6C;
	Wed, 28 Jan 2026 11:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769601325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htGBCdHoiVOgYVLHzZAh6JgxHz1cmVZJfmEMiKDEgWE=;
	b=va9YLbBYcBs55LmpkrLsnCpUehecii081xGxMGB67DNNAjJmCx5ZIal93nA9rmR13ieNWE
	XK2Kd1deQV2qYkoGF5cq1gq/MY/Oy6nOKHDKOFchEe3fiOfUFA89EIjjL/UAdaChgmMNOS
	8A8CnnnTPrsxEYvKk7zimZjXRe9Govg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769601325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htGBCdHoiVOgYVLHzZAh6JgxHz1cmVZJfmEMiKDEgWE=;
	b=NFzv08hjUXJyAzdUpDvsrTfdh3j7v19tbPC13LSHZivV3+tqwyto8/9InhJafRyx9PpnLY
	7FCu+QG9pGmJh1Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=va9YLbBY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NFzv08hj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769601325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htGBCdHoiVOgYVLHzZAh6JgxHz1cmVZJfmEMiKDEgWE=;
	b=va9YLbBYcBs55LmpkrLsnCpUehecii081xGxMGB67DNNAjJmCx5ZIal93nA9rmR13ieNWE
	XK2Kd1deQV2qYkoGF5cq1gq/MY/Oy6nOKHDKOFchEe3fiOfUFA89EIjjL/UAdaChgmMNOS
	8A8CnnnTPrsxEYvKk7zimZjXRe9Govg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769601325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htGBCdHoiVOgYVLHzZAh6JgxHz1cmVZJfmEMiKDEgWE=;
	b=NFzv08hjUXJyAzdUpDvsrTfdh3j7v19tbPC13LSHZivV3+tqwyto8/9InhJafRyx9PpnLY
	7FCu+QG9pGmJh1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0648B3EA61;
	Wed, 28 Jan 2026 11:55:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kJ2BAS35eWnrZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Jan 2026 11:55:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BBA0BA09D8; Wed, 28 Jan 2026 12:55:24 +0100 (CET)
Date: Wed, 28 Jan 2026 12:55:24 +0100
From: Jan Kara <jack@suse.cz>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: dcache: fix typo in enum d_walk_ret comment
Message-ID: <vz3ilq45yeyuufh342phkvlopql6kysrgpjpu56ijtf3tows76@d5rgagcsmod3>
References: <20260128105709.3475258-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128105709.3475258-1-chelsyratnawat2001@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75715-lists,linux-fsdevel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received,100.90.174.1:received,2a07:de40:b281:104:10:150:64:97:received,195.135.223.130:received];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A25AA0E87
X-Rspamd-Action: no action

On Wed 28-01-26 02:57:09, Chelsy Ratnawat wrote:
> Fix a spelling error in the documentation comment for
> D_WALK_CONTINUE.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>

Thanks. When we are fixing this please also fix:

>  /**
>   * enum d_walk_ret - action to talke during tree walk
				  ^^^ take

> - * @D_WALK_CONTINUE:	contrinue walk
> + * @D_WALK_CONTINUE:	continue walk
>   * @D_WALK_QUIT:	quit walk
>   * @D_WALK_NORETRY:	quit when retry is needed
>   * @D_WALK_SKIP:	skip this dentry and its children

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

