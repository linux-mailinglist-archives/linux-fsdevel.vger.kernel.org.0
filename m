Return-Path: <linux-fsdevel+bounces-18500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A1D8B9976
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 12:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBA9B21074
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF45E060;
	Thu,  2 May 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sqfwXOey";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="niF4anYI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lrfpFJvc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BeBEJrrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E545D8E4
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647189; cv=none; b=XahHe+kQ2nrlqnIQwsWHWiUeOzsZ3Yr3YdtCook+32Trg/ywTZ1GzCKLS9rf2Ds+3h2ew/JTz188TaNBIlgeMxw7L91F4dvYpjKaOfJh+HHdAjNPPPe5d8FWbGw9jjqfVMn4GrQEkUkW7zJqoCXL4F4vKlfHpEZriKd0WjGjqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647189; c=relaxed/simple;
	bh=E/0zVdg0MYp4N2UCLU7nYHl6QXTKSWX3iHDr/g+7ohY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4XTQO+zuwgKotiBg8XWvvLJ4kcxSzwLVCTr5aHU9+3bzW0cHPWTblCSZyN+18nndSTmKGR6YlwOGcMAujwbal2KgLbzOU4YErpcYJGNjUgfnAg92HRySF85zGy5HNoX5wXkKh0K1P5KZxaMLySNFYhSTzTXQiSr1kaO/gaTqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sqfwXOey; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=niF4anYI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lrfpFJvc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BeBEJrrI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 450FA35221;
	Thu,  2 May 2024 10:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714647186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puEMin/zCtA50V2f0OFLcD9J/D85fUpGzBDMZnktE/g=;
	b=sqfwXOeyk2WaZ9hLV6LzXLaY2Sq4U+Wq6gJ8+mWdVkh3rqNo5+uIoSAsqGzxCqAfV+qzJn
	nmXGzDXq9vLPCCZHqi9vFZx1N5Yb0PYrzYdFpRHbFoXl7OW9bo8LhcQ5/i16nXr108rKXR
	wh9mRDO/UON/MuYWTRtYJQzPE8CBXzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714647186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puEMin/zCtA50V2f0OFLcD9J/D85fUpGzBDMZnktE/g=;
	b=niF4anYI465enrWNkVucQr10vTH2TghvSGaoKbQur0uRgdxIWCdoPKTQ6iOmvzk8XdAVCX
	lwC4Z0+kpo/vIoDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714647185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puEMin/zCtA50V2f0OFLcD9J/D85fUpGzBDMZnktE/g=;
	b=lrfpFJvcnPePwA++G/Fv1exzn1Fd+f/zQZ2q/asY7jPUcfZcVkq+ONnlkiu0sfl7mohabL
	bRmD4WPjHnexyVw0IlGlhf82OT3LcWjC/hBbNjOTkF9kvl76/8ItBoBWvWQb1eoykwWvna
	NfB2po816eYU3TvZJ+wAicdfnaS0Yy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714647185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puEMin/zCtA50V2f0OFLcD9J/D85fUpGzBDMZnktE/g=;
	b=BeBEJrrIdFjatC/zZjS5TIf9r0niGCkz7Xrl0wDLsesalQNN6Wb4i0vlkjNM+QRMo901dU
	v9qLscFk4WBoZWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3737C1386E;
	Thu,  2 May 2024 10:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p7szDZFwM2bYGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 May 2024 10:53:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD1E4A06D4; Thu,  2 May 2024 12:53:04 +0200 (CEST)
Date: Thu, 2 May 2024 12:53:04 +0200
From: Jan Kara <jack@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Maple Tree Proposed Features
Message-ID: <20240502105304.m44vwdqtirhxhgro@quack3>
References: <rqvsoisywsbb326ybechwwgpdrdt57sngr2zwwrbp2riyi7ml5@uppobkrmbxoz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rqvsoisywsbb326ybechwwgpdrdt57sngr2zwwrbp2riyi7ml5@uppobkrmbxoz>
X-Spam-Flag: NO
X-Spam-Score: -3.78
X-Spam-Level: 
X-Spamd-Result: default: False [-3.78 / 50.00];
	BAYES_HAM(-2.98)[99.93%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Tue 30-04-24 23:16:55, Liam R. Howlett via Lsf-pc wrote:
> Since there is interest (and users) in both the filesystem and mm track,
> this could be a joint session.  Although, I'm pretty sure there is not
> enough interest for a large session.
> 
> I'd like to discuss what functionality people want/need to help their
> projects, and if the maple tree is the right solution for those
> problems.
> 
> I'd also like to go over common use cases of the maple tree that are
> emerging and point out common pitfalls, if there is any interest in this
> level of discussion.

I'd be interested in this. Not sure how much discussion to expect from this
though. Do you expect this will take a full slot or would perhaps a
lightning talk where you share where things are going be enough? I expect
the MM track will be rather packed as far as I've heard so I'm inquiring so
that we can pick the most sensible scheduling...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

