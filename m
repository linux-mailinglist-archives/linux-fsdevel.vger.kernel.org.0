Return-Path: <linux-fsdevel+bounces-32326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4239A39CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAC52833C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A561E284C;
	Fri, 18 Oct 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LDpCZGze";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LcQfiwi8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LDpCZGze";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LcQfiwi8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7580160884;
	Fri, 18 Oct 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243088; cv=none; b=j8wFL74YGaZ7s1s4MXWv8XBRlpN9mhs7YBUrrZ/DdVmR+TSX91KED03MD8VINUNgdy7F2Ff8SI71ZLVXN0IBgd+U4N1RGV2y8KNwUSosfK5XqDAqxY6Q+pTltrTGy/e1kHsIfr8urN9t6UZzyhrtyQdZ7ciydvDXnUaAAZMvZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243088; c=relaxed/simple;
	bh=fofWsCC2k4mhX0b3LHITZBoTYt72qNySMZi8+xemwm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiI0jx9PsVkFLOtRuj/ub7v9lcPC/bsy8WusCT3vH9F87hZWSIALGBem1wmpEwVVaEqtUJXFBgEV2/smSXfv022vc9rwdtH3wqX6kioPsaBz8dsRPeGCs/da3V4S5BBDWX7pC8/LYdUUO8wnYg5dezl8k0o3dVP676wSnXLLtBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LDpCZGze; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LcQfiwi8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LDpCZGze; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LcQfiwi8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 049801FDA4;
	Fri, 18 Oct 2024 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729243085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ko1zCd019ED4ckFw3gNDsW/qMSk/25HrjYvYLrJffa0=;
	b=LDpCZGzevTXxabnJiO/DbsFNCsshBcRGJ2taTvqcu30Slwt7nRMNTFlfctvEfokhHJV4a8
	PL25ZbVQoaQkyAupjDp/krvpzbV3yDG1u44FVpcaV9CI80/cNqHQE25FC08KhgPdeHw6G3
	7ONN+fHN2Us6RpVcXSXhvtnEuQapn0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729243085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ko1zCd019ED4ckFw3gNDsW/qMSk/25HrjYvYLrJffa0=;
	b=LcQfiwi8FyRGlQeipyMMyluqsyvmqCMFj9+mYZHatqsraYQK1s+9IIt2DbqaW378ydjMMB
	77y4GtQG8G0Kg6Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LDpCZGze;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LcQfiwi8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729243085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ko1zCd019ED4ckFw3gNDsW/qMSk/25HrjYvYLrJffa0=;
	b=LDpCZGzevTXxabnJiO/DbsFNCsshBcRGJ2taTvqcu30Slwt7nRMNTFlfctvEfokhHJV4a8
	PL25ZbVQoaQkyAupjDp/krvpzbV3yDG1u44FVpcaV9CI80/cNqHQE25FC08KhgPdeHw6G3
	7ONN+fHN2Us6RpVcXSXhvtnEuQapn0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729243085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ko1zCd019ED4ckFw3gNDsW/qMSk/25HrjYvYLrJffa0=;
	b=LcQfiwi8FyRGlQeipyMMyluqsyvmqCMFj9+mYZHatqsraYQK1s+9IIt2DbqaW378ydjMMB
	77y4GtQG8G0Kg6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEDFA13680;
	Fri, 18 Oct 2024 09:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O7NJOswnEmfLVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 18 Oct 2024 09:18:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B43FBA080A; Fri, 18 Oct 2024 11:18:00 +0200 (CEST)
Date: Fri, 18 Oct 2024 11:18:00 +0200
From: Jan Kara <jack@suse.cz>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>, reiserfs-devel@vger.kernel.org
Subject: Re: Dropping of reiserfs
Message-ID: <20241018091800.5nwytgasfpfnucej@quack3>
References: <20241017105927.qdyztpmo5zfoy7fd@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017105927.qdyztpmo5zfoy7fd@quack3>
X-Rspamd-Queue-Id: 049801FDA4
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Forgot to CC reiserfs-devel so adding it now to keep people in the loop.
Thanks for noticing Al!

								Honza

On Thu 17-10-24 12:59:27, Jan Kara wrote:
> Hello,
> 
> Since reiserfs deprecation period is ending, it is time to prepare a patch
> to remove it from the kernel. I guess there's no point in spamming this
> list with huge removal patch but it's now sitting in my tree [1] if anybody
> wants to have a look. Unless I hear some well founded complaints I'll send
> it to Linus during the next merge window in mid-November.
> 
> 								Honza
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git/log/?h=reiserfs_drop
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

