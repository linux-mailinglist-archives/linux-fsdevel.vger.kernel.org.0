Return-Path: <linux-fsdevel+bounces-12041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D185AA92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704BCB25DB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA3481B5;
	Mon, 19 Feb 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8gaG0z8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F74KJK9c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hj56P3LT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="roy9OnvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098BB47F6F;
	Mon, 19 Feb 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366008; cv=none; b=IWnH14lcWW+wo2egqgogXs3fS4L2MOlK6CLPwg/pQ0JJxg/dAbghtftQ8nd61oH6YrADKu1dPReze3POxmNzWrl97DsqFoyd50jsFTGOQNTQmtZU/wDwVyGQ2xiMad/RYsBucaC47WuzIkehyva28oo6/ABj76zaioqkb80qre4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366008; c=relaxed/simple;
	bh=YBRaqijHVfqnHtrIHyiwiZc0KQSz2QfvwpR1e8BD79s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4EitgQIUBbbXGhdw/Ja+YDlJcA0rZScp3Kv7m7MEbGosA043+ugQ1GVsiCZf+q654qcGDjlaM7bs+woEHmKoV6uGLFq5QgoS4jVfc+rbe3EGxmimPO55Vghjr0IWuN77TQtJSiRqHAQvQ/1av1jLv2lNpplRzhL/BxqCLGgSHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x8gaG0z8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F74KJK9c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hj56P3LT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=roy9OnvM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 503E521CF9;
	Mon, 19 Feb 2024 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708366004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3fnqwXhJv4ZBbgeBGW7Cr0RpX5aKb857iiXzrv8H1g=;
	b=x8gaG0z83buD6KiLH613xWifD+0Fv+MpOu+9FwUv8RSEBSUwcXwMZr7/L79j7ror2S2U7C
	GbxCTcMksVDNCFpwNYeS6TyU2sUv7s9lhL1uUsG1R5YdQEQPFJa1SOVNqdP9h1EBoZO41t
	yhw6Q8oiPkaW5Ya13BZdz2n9WUKEd9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708366004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3fnqwXhJv4ZBbgeBGW7Cr0RpX5aKb857iiXzrv8H1g=;
	b=F74KJK9cK6gksycztcEH/D9VSAKvl3Bjq+d6sU9YfowWlYSfX7Rh42pZXlf1NauNLVi1DY
	RnCpyifJjD3tRiBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708366002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3fnqwXhJv4ZBbgeBGW7Cr0RpX5aKb857iiXzrv8H1g=;
	b=Hj56P3LTK7609WqPke/eRJWzCDucXNHyQr0ZJ1a77PFv9GsDT8rJv7K9punSqIuXhZed9r
	1QAcwAsANBq01uxyxhFgqFplu99KolfHOaAZ8DrklJBC+WR8Rkb7WJ41fS5Bpxw0JDz4AU
	qh7VgT3g8RnBjuujG85otN78f65yz5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708366002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3fnqwXhJv4ZBbgeBGW7Cr0RpX5aKb857iiXzrv8H1g=;
	b=roy9OnvMu17BG9firOsqqpUAgML5WVdeRrcRms4vwUXWhb8KUKmVd0AaY0ddK0M9ho4dxQ
	n5W6p9adVqAYGOCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FF4813585;
	Mon, 19 Feb 2024 18:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZU+VD7KY02WoRAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 18:06:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DBDFCA0807; Mon, 19 Feb 2024 19:06:41 +0100 (CET)
Date: Mon, 19 Feb 2024 19:06:41 +0100
From: Jan Kara <jack@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
	akpm@linux-foundation.org, oliver.sang@intel.com,
	feng.tang@intel.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <20240219180641.hdd5q2vvx5sixuh6@quack3>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
 <20240215131638.cxipaxanhidb3pev@quack3>
 <20240215170008.22eisfyzumn5pw3f@revolver>
 <20240215171622.gsbjbjz6vau3emkh@quack3>
 <20240215210742.grjwdqdypvgrpwih@revolver>
 <20240216101546.xjcpzyb3pgf2eqm4@quack3>
 <20240216163318.w66ywrhpr5at46pi@revolver>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216163318.w66ywrhpr5at46pi@revolver>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.97
X-Spamd-Result: default: False [-0.97 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.17)[69.66%]
X-Spam-Flag: NO

On Fri 16-02-24 11:33:18, Liam R. Howlett wrote:
> * Jan Kara <jack@suse.cz> [240216 05:15]:
> > > If you have other examples you think are unsafe then I can have a look
> > > at them as well.
> > 
> > I'm currently not aware of any but I'll let you know if I find some.
> > Missing xas/mas_pause() seems really easy.
> 
> What if we convert the rcu_read_lock() to a mas_read_lock() or
> xas_read_lock() and we can check to ensure the state isn't being locked
> without being in the 'parked' state (paused or otherwise)?
> 
> mas_read_lock(struct ma_state *mas) {
> 	assert(!mas_active(mas));
> 	rcu_read_lock();
> }
> 
> Would that be a reasonable resolution to your concern?  Unfortunately,
> what was done with the locking in this case would not be detected with
> this change unless the rcu_read_lock() was replaced.  IOW, people could
> still use the rcu_read_lock() and skip the detection.

Yes, I guess this is still better than nothing.

> Doing the same in the mas_unlock() doesn't make as much sense since that
> may be called without the intent to reuse the state at all.  So we'd be
> doing more work than necessary at the end of each loop or use.

Yes, understood.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

