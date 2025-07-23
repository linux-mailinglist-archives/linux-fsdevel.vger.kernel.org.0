Return-Path: <linux-fsdevel+bounces-55786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 329FDB0ED6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BECE7A70C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCC228000F;
	Wed, 23 Jul 2025 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3UtHbFeL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fU1q5lcv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3UtHbFeL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fU1q5lcv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160527FB1F
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259943; cv=none; b=PfiZbBd7u45DB9dMcGzL2DSrCOfsmngqOJxeSf75L6c//g8tuud79yFaeGV+Rgmh+NKUb4xldfPpa+aXIfRABTdug1Q3IgJfbX5iLj1UluHsA83p3vb07pLcYTg914oCuRBFlPi9R4HlY4SSXxyCcCY523mGeBq8P2jdM6vtgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259943; c=relaxed/simple;
	bh=WpnNYowgx/+AnSJYkWfeeLOq0L69XKaZWVPwRU9zbss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXbNgR7XIgaa1T2weDSklrTfPKOfPEfaCVw5DLQfks2NiFYjEgImc8Do61+F8Ct5y0+86pXptGTEVuHI/1qj507tOhM8eCTvauKMWVJm0Q1zMDOrwhM9DBfxjL8V0RUBwpsClLaCe6VD9xqgNR2Sp4WlXIZ6xRzayDgBKMVfY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3UtHbFeL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fU1q5lcv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3UtHbFeL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fU1q5lcv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D4071F76C;
	Wed, 23 Jul 2025 08:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753259934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hmjj+096M3y4gtArv+nIW8FoyzRogCNHH57AQaaNUQc=;
	b=3UtHbFeLKddcysl8QkLQQ0ixxa4p1xNM5VPKGLpA9BH8xZt4dDU1+3Cax2367L2fEIp8rb
	Lt1akk0iq3Opu/gzzWrIHAT9zHlPM4Fy+w0/VomVxrx/4WTeBw3cGEvp9FKRKd2vZUmnyq
	A+7B3+LkmeAsSKrfs6qglIO9rujW9vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753259934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hmjj+096M3y4gtArv+nIW8FoyzRogCNHH57AQaaNUQc=;
	b=fU1q5lcvP4TQpmWvJf2XMSGtscCfIEZgO7iFiXLnNL1qW7NC8GidZut4VM2odyX8QpSYUU
	KfB24fS9MyHkG9CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753259934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hmjj+096M3y4gtArv+nIW8FoyzRogCNHH57AQaaNUQc=;
	b=3UtHbFeLKddcysl8QkLQQ0ixxa4p1xNM5VPKGLpA9BH8xZt4dDU1+3Cax2367L2fEIp8rb
	Lt1akk0iq3Opu/gzzWrIHAT9zHlPM4Fy+w0/VomVxrx/4WTeBw3cGEvp9FKRKd2vZUmnyq
	A+7B3+LkmeAsSKrfs6qglIO9rujW9vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753259934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hmjj+096M3y4gtArv+nIW8FoyzRogCNHH57AQaaNUQc=;
	b=fU1q5lcvP4TQpmWvJf2XMSGtscCfIEZgO7iFiXLnNL1qW7NC8GidZut4VM2odyX8QpSYUU
	KfB24fS9MyHkG9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3958113AFA;
	Wed, 23 Jul 2025 08:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eQYBDp6fgGi+RwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Jul 2025 08:38:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C037AA0AD8; Wed, 23 Jul 2025 10:38:49 +0200 (CEST)
Date: Wed, 23 Jul 2025 10:38:49 +0200
From: Jan Kara <jack@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: syzbot <syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com>, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] INFO: task hung in vfs_rename (2)
Message-ID: <d3ttuxxt6frs2rwpfgp7hwbzpzmd2gaavyqsqulcteipmerod2@brdkcglhjx4r>
References: <680809f3.050a0220.36a438.0003.GAE@google.com>
 <k7mpottkzjgdpjgagsw5vrmvgwyz6n2zg3m7b47utazirmhqui@qty6qmna726g>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k7mpottkzjgdpjgagsw5vrmvgwyz6n2zg3m7b47utazirmhqui@qty6qmna726g>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[321477fad98ea6dd35b7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Tue 22-07-25 13:51:17, Kent Overstreet wrote:
> Here's another one that someone incorrectly assigned to bcachefs (and I
> can't find who's doing it, they're not ccing the list).
>
> But I've got through the logs and there's nothing connecting it to
> bcachefs.

Well, as far as I know syzbot guys have some automated bot that decides
where to assign bugs based on some heuristics. Apparently there is some
room for improvement :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

