Return-Path: <linux-fsdevel+bounces-50512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F100ACCDB0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 21:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3423A649D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D342192F8;
	Tue,  3 Jun 2025 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uak5v9tD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F5ifxise";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YBPInJE2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k4FlNKqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581C187346
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748979504; cv=none; b=PlgFr1jElwiRfuGIRXJDI4OVHu+p8LAgQzT7xhq3EAgiRm4ZUMskdYT+tLIstyBqEcpw1M6ohmaThmgykTz6a+pG9KajdBzvKnI+jRCypylKEsG9sNDcB150E1PTSEb231yve3uTHWQta23ph0p80e0aoeguD29NgfkrdMRvSQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748979504; c=relaxed/simple;
	bh=eT3clanCmXJqpWoJJQZoOouOJr5Juqug/eyClaf06is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJYTMMMNhop9WAStVL9G8QM49ogtCSx3SgFpeqLY8xdLXEi8ZkDUxXcUEi9AXWEw39WTwZ5IO3GpZwcYy+PPp2geAZ1wQUoWXrhPBfn1tGj1Rk0zQ+vnelIRlZDM8BNdq4106SiodQMa9iRjxvRmOQNsKtuvbWjp2oQ7c/Tkjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uak5v9tD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F5ifxise; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YBPInJE2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k4FlNKqF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F16C31F825;
	Tue,  3 Jun 2025 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748979501;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpIFLoLkeRo4SvvTkAA4/FXtgbOfkc1OzOToQQOFSQ4=;
	b=Uak5v9tD16IDi6Z5/IVlXz89TEK0YdG1qYff5wFAA5LIGAzoXoZRAhq2nynMYO4AjbUqRM
	wrv3RRCbmFDRsuz+j1D6Q+SsQLKZnOr31N/E0PtvCBfzKGTfl6iIvNalR/mqmdvq5n7KLp
	EWeufjNa6uNDDP7zrjoLvPMbXXdS8sI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748979501;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpIFLoLkeRo4SvvTkAA4/FXtgbOfkc1OzOToQQOFSQ4=;
	b=F5ifxisenps1n1NlqY1fzQsLxENV0rjkLfNWnWFZF2mdyFVbYm6zkJA7Sw9un6JnZ+X8A4
	+y0gAzAYzAjF2ADg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YBPInJE2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k4FlNKqF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748979500;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpIFLoLkeRo4SvvTkAA4/FXtgbOfkc1OzOToQQOFSQ4=;
	b=YBPInJE2IdrrDy8k7hhnjMnfkIQ5gpbVlZ9US+Ikm9xzuhmPMlQ52s8/OA2kxNbEuMH3O7
	Hp8At3p7V+D96lP26yrDmhTC8nCg+fyWq3/D+pAiPmPNARbhZoE9/OJXJ5FMydXVF+cCWG
	K8/IIdIB516JVOIb1Frti0t2U49v27Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748979500;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpIFLoLkeRo4SvvTkAA4/FXtgbOfkc1OzOToQQOFSQ4=;
	b=k4FlNKqFumi6HUVPpA8vaFx8p6e3zfdSBkb5wLbJiO18ysDK6RVAcmSCCyKNJLD32AqtJL
	sqLet810SI/2BkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D135013A92;
	Tue,  3 Jun 2025 19:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SE3hMixPP2gTBAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Jun 2025 19:38:20 +0000
Date: Tue, 3 Jun 2025 21:38:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH v3] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250603193815.GL4037@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250505030345.GD2023217@ZenIV>
 <20250506193405.GS2023217@ZenIV>
 <20250506195826.GU2023217@ZenIV>
 <9a49247a-91dd-4c13-914a-36a5bfc718ba@suse.com>
 <20250603075902.GJ4037@twin.jikos.cz>
 <74260737-f153-437f-bf98-1f3944f493d6@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74260737-f153-437f-bf98-1f3944f493d6@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	FREEMAIL_CC(0.00)[suse.com,zeniv.linux.org.uk,vger.kernel.org,gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: F16C31F825
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Tue, Jun 03, 2025 at 06:53:47PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/3 17:29, David Sterba 写道:
> > On Thu, May 08, 2025 at 06:59:04PM +0930, Qu Wenruo wrote:
> >>
> >>
> >> 在 2025/5/7 05:28, Al Viro 写道:
> >>> [Aaarghh...]
> >>> it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
> >>> no need to mess with ->s_umount.
> >>>       
> >>> [fix for braino(s) folded in - kudos to Klara Modin <klarasmodin@gmail.com>]
> >>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >> Test-by: Qu Wenruo <wqu@suse.com>
> >>
> >> Although the commit message can be enhanced a little, I can handle it at
> >> merge time, no need to re-send.
> > 
> > If you're going to add the patch to for-next, please fix the subject
> > line and update the changelog. Thanks.
> > 
> 
> I have merged this one to for-next just minutes ago.
> 
> However the version I pushed doesn't only have its commit 
> message/subject modified, but also modified its error handling, to align 
> with our error-first behavior.
> (Which is much easier to read compared to the one in the patch)
> 
> So I have sent the updated version to the mail list just for reference.

Perfect, thanks.

