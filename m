Return-Path: <linux-fsdevel+bounces-21950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D18910098
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E58FB23558
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 09:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9491A4F1F;
	Thu, 20 Jun 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SAzaK/xo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BjacE3nt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SAzaK/xo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BjacE3nt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018EC176FA1;
	Thu, 20 Jun 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876515; cv=none; b=dDLXJeLYubJ38iEcbipOjApPsblllS6ysn+1NToI5kZz/rBjUmKX3FZCQOj8tjY/XF86UsGoTrk/OHQ0NFm6hwWTkmQMUTDljM/8jRWrjsfj39hnkCJQT6BmyOtaScV25bkszhvNcD0YONHhOMEDepDPqlQcnO2KIFP3NAzdvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876515; c=relaxed/simple;
	bh=y/D5SODM8g5ptykrokVj2Z77bguifhyU8/FZmoMEG+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvQViotkRtvjWa1cvKJqAzQC6hDV4Ht1X+eCt2DWQNRFaVVf5PSLWI9waOV74dbkyan54Pghnl7DsUCE5kBb2jNwK+2brWsIpvDjuJ3egRlUv+y0O4gmDQk7Qx4GYM/m4TVHspeh94PIZ7cd0na9RvjBZEE8h6CV5T49Egktcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SAzaK/xo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BjacE3nt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SAzaK/xo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BjacE3nt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CE8321966;
	Thu, 20 Jun 2024 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718876512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=by6xbOtQhJMEqLZEgKtPj8oDDcf6k9Hues9GV1+zcyQ=;
	b=SAzaK/xoZwIuWUNy6d194BAU2VGW14tMKTKl2dDCq0fJojXr6vXLm/lkP/Phg0bY3HnTWS
	TpwGm0lRujT6/LM84g3Dr8niw21ljxNE3ofz8/e1VEeiXPy/xz7KQtsnj77XtGCm2lSIRM
	mi5PY1m+F6ZOg5ntsQLuGEMo/L28uCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718876512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=by6xbOtQhJMEqLZEgKtPj8oDDcf6k9Hues9GV1+zcyQ=;
	b=BjacE3nt64e/Idvu0fGlwzUA/YgYLZoi/XC3w2bm7Yah/tBMLlGjXj/KqPs3ohXeanVbtL
	vOk/sPoq8k7VN7CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718876512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=by6xbOtQhJMEqLZEgKtPj8oDDcf6k9Hues9GV1+zcyQ=;
	b=SAzaK/xoZwIuWUNy6d194BAU2VGW14tMKTKl2dDCq0fJojXr6vXLm/lkP/Phg0bY3HnTWS
	TpwGm0lRujT6/LM84g3Dr8niw21ljxNE3ofz8/e1VEeiXPy/xz7KQtsnj77XtGCm2lSIRM
	mi5PY1m+F6ZOg5ntsQLuGEMo/L28uCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718876512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=by6xbOtQhJMEqLZEgKtPj8oDDcf6k9Hues9GV1+zcyQ=;
	b=BjacE3nt64e/Idvu0fGlwzUA/YgYLZoi/XC3w2bm7Yah/tBMLlGjXj/KqPs3ohXeanVbtL
	vOk/sPoq8k7VN7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BCFA13AC1;
	Thu, 20 Jun 2024 09:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UTPbAmD5c2bYewAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 20 Jun 2024 09:41:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A683FA0881; Thu, 20 Jun 2024 11:41:51 +0200 (CEST)
Date: Thu, 20 Jun 2024 11:41:51 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.de>,
	Amir Goldstein <amir73il@gmail.com>,
	James Clark <james.clark@arm.com>, ltp@lists.linux.it,
	linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
Message-ID: <20240620094151.cuamehtaioenokyv@quack3>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
 <20240617093745.nhnc7e7efdldnjzl@quack3>
 <20240618-wahr-drossel-19297ad2a361@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-wahr-drossel-19297ad2a361@brauner>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,suse.de,gmail.com,arm.com,lists.linux.it,vger.kernel.org,zeniv.linux.org.uk];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 18-06-24 16:19:37, Christian Brauner wrote:
> > AFAICT this will have a side-effect that now fsnotify_open() will be
> > generated even for O_PATH open. It is true that fsnotify_close() is getting
> 
> Thanks! That change seemed sensible because a close() event is
> generated.
> 
> But I don't agree that generating events for O_PATH fds doesn't make
> sense on principle. But I don't care if you drop events for O_PATH now.

Well, I can be convinced otherwise but I was not able to find a compeling
usecase for it. fanotify(8) users primarily care about file data
modification / access events and secondarily also about directory content
changes (because they change how data can be accessed). And creation of
O_PATH fds does not seem to fall into either of these categories...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

