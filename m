Return-Path: <linux-fsdevel+bounces-64677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611BDBF0C81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B66918A0C98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E09259CA0;
	Mon, 20 Oct 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S+sF83a2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PXB/R9hX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SoUIqli+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nWPipZFK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4141C22E3F0
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959019; cv=none; b=QUONb11C9Rk898fwLQyDy0a1k0OLpPQyPmEsAiSDcqJF4iyHe74jwpfKGKT9XFoXyYQBpHzkjK6knb6kwqqR9biEL8aTVCJdPwBAOATib9bcHKESTZEvVoWqZaDrYE7MDc+icluyw2g1Kuri57MlW/afP0zutf+Wk6fzfEladp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959019; c=relaxed/simple;
	bh=32hWkDM4BuTmpBlBts6aTp3l+b52tZGM1LwPnn4zk18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4fhoqLLlD37BFhK8rfVAqsnFXbDuUtNn3s2HO7Co2a2j9jttplOsc5Ggm4rijcB+u9a9y3QniDTQIZtJVJipIp+2YIQcICBmoWYNr1dzR/SNNQ8ZVSZiELY4TQ+LtdOG3V6tX4QQacJ3a0VrI2dIWf61p5mA+89viLJjuTONJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S+sF83a2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PXB/R9hX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SoUIqli+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nWPipZFK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52AB821186;
	Mon, 20 Oct 2025 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760959012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xM1PbaYDZEV6JMqVRTGxnqw+sNH7uxtqulhhY+yBP4Y=;
	b=S+sF83a20Ne66kDF5CGiT6xsZ9SITj2hEv65D9O2iwEKXinPrXQp2vhthmDy/CPwb9UMf3
	kL+jeVh6D32pE1QasGxJRhlIWljFFY6EM6fn4pAhtAFfzfmbLd02b8BbDw6jmeXwFbwpDy
	HIkCgrpVW1DSl4wzqy3VHcrLqEA57I4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760959012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xM1PbaYDZEV6JMqVRTGxnqw+sNH7uxtqulhhY+yBP4Y=;
	b=PXB/R9hXqpxh7QhcHr5MuqvTLIYBlfcLAijFu+QLNCm1MFwNQLvqZ5PLK9zFQ2CNH3FNhS
	ycZm218ZBtcOZwAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SoUIqli+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nWPipZFK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760959008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xM1PbaYDZEV6JMqVRTGxnqw+sNH7uxtqulhhY+yBP4Y=;
	b=SoUIqli+giSYZWF902ETGINdXPBqGYCpcLge4Cg9t11vNHRXbdWedh1Tg/idW/QkzjxfaH
	fYjcgbwL4ojJdpx0BN5fm7d8PK3hLG6EWrrSwiTN95wi/jBDQQ0lqsj5jrjZx8sxPW/s9k
	Bpt2jf72qOlF5/eDU6U3vkomhtDtdng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760959008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xM1PbaYDZEV6JMqVRTGxnqw+sNH7uxtqulhhY+yBP4Y=;
	b=nWPipZFK3OAgu7JM7tjXRmd21rccbIxPJZvoRGYTM4mJ09OvOYqtEnsJF34gg176RMan5c
	WtNJcuflHcWXnqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48A3313AAC;
	Mon, 20 Oct 2025 11:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6sC2ESAa9mjFawAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 11:16:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EA6B5A088E; Mon, 20 Oct 2025 13:16:39 +0200 (CEST)
Date: Mon, 20 Oct 2025 13:16:39 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	djwong@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYIS5rDfXhNNDHP@infradead.org>
X-Rspamd-Queue-Id: 52AB821186
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 20-10-25 03:00:43, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 07:49:50PM +1030, Qu Wenruo wrote:
> > But still, such performance drop can be very obvious, and performance
> > oriented users (who are very happy running various benchmark tools) are
> > going to notice or even complain.
> 
> I've unfortunately seen much bigger performance drops with direct I/O and
> PI on fast SSDs, but we still should be safe by default.
> 
> > Another question is, should we push this behavior to iomap layer so that other
> > fses can also benefit from it?
> 
> The right place is above iomap to pick the buffered I/O path instead.
> 
> The real question is if we can finally get a version of pin_user_pages
> that prevents user modifications entirely.

Hmm, this is an interesting twist in the problems with pinned pages - so
far I was thinking about problems where pinned page cache page gets
modified (e.g. through DIO or RDMA) and this causes checksum failures if
it races with writeback. If I understand you right, now you are concerned
about a situation where some page is used as a buffer for direct IO write
/ RDMA and it gets modified while the DMA is running which causes checksum
mismatch? Writeprotecting the buffer before the DIO starts isn't that hard
to do (although it has a non-trivial cost) but we don't have a mechanism to
make sure the page cannot be writeably mapped while it is pinned (and
avoiding that without introducing deadlocks would be *fun*).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

