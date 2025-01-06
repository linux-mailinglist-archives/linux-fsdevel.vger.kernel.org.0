Return-Path: <linux-fsdevel+bounces-38458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D14DA02E22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A8E7A30D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730051DEFF4;
	Mon,  6 Jan 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="100U9Jla";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a9el5Nr5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="100U9Jla";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a9el5Nr5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9521DE3A6
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181846; cv=none; b=oOeNudgl60BhbgpUoKMgLPGxv5pov1k4JRDCGfYs7ZED6XeufHLBtz85EGvRoXHoI4h7WWwmQHj6uauxOsm4fJ52kvAGjK0P3UnGg9xQtcKCQSV7b7oLjTNeDUZw16WDgBvEF+yePdqpigJewsdr8y4+oAyoT6VqWVEDcHW7n8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181846; c=relaxed/simple;
	bh=6f1hPoIrtcY6ESQyrVYUItEoy+SeUtI1esUuihNNEm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf5qeXIkflRTCeVTC4i3KMvOuVNDqqzDE7Fbtboc8NTgpNwNsGtq3sExi3+YOoUIJ2G3eFPkhPt/odcumkvK/5zErUO4uInl8N4bYo3Q49yVP99NEV9oFMQcxAp069An4TbFROsRMXlFzu53sM04WPvcBqdKko6ZgsxmLiKN1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=100U9Jla; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a9el5Nr5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=100U9Jla; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a9el5Nr5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 116A41F44E;
	Mon,  6 Jan 2025 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736181843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzn75da9hD8WkE/NTpSS7cxEZ0w2rpMVMENLX/V9OAc=;
	b=100U9JlaBJBOJuC/tWi+N/98ngmLd46LRdc4W0+No7QxPZYqiPQHoTmSUBfustN4FupZ5+
	6OxqG5VKGCiS7JO2BAusuknIKaUaqhVAKqqjn3ueTMmZi0I2U3Gawm1g+F3lAbKVpSAuJA
	mY6exQkZShENa0vdBcasQ6p6jqU8QTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736181843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzn75da9hD8WkE/NTpSS7cxEZ0w2rpMVMENLX/V9OAc=;
	b=a9el5Nr5X6l1SMRf7wSMJ9LwdN48aryY25JRj1zpk9cHLMHRfiJWPv+VjvxDV+8j/c7345
	x79wceTQEyYF9cBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736181843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzn75da9hD8WkE/NTpSS7cxEZ0w2rpMVMENLX/V9OAc=;
	b=100U9JlaBJBOJuC/tWi+N/98ngmLd46LRdc4W0+No7QxPZYqiPQHoTmSUBfustN4FupZ5+
	6OxqG5VKGCiS7JO2BAusuknIKaUaqhVAKqqjn3ueTMmZi0I2U3Gawm1g+F3lAbKVpSAuJA
	mY6exQkZShENa0vdBcasQ6p6jqU8QTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736181843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzn75da9hD8WkE/NTpSS7cxEZ0w2rpMVMENLX/V9OAc=;
	b=a9el5Nr5X6l1SMRf7wSMJ9LwdN48aryY25JRj1zpk9cHLMHRfiJWPv+VjvxDV+8j/c7345
	x79wceTQEyYF9cBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7EF7137DA;
	Mon,  6 Jan 2025 16:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SAybOFIIfGeQXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 16:44:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8F848A089C; Mon,  6 Jan 2025 17:44:02 +0100 (CET)
Date: Mon, 6 Jan 2025 17:44:02 +0100
From: Jan Kara <jack@suse.cz>
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, syzkaller@googlegroups.com
Subject: Re: [Kernel Bug] INFO: task hung in inode_sleep_on_writeback
Message-ID: <k3qqoxkwk6dzqjd73agjgszj7tnicpbagqzpac5xuzqlh4hlon@bo2aa2ayxgoi>
References: <CALf2hKscYkic-_=_zAd1v6TCF1MXTYjzO2Xuyre7r+85EhJ+8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALf2hKscYkic-_=_zAd1v6TCF1MXTYjzO2Xuyre7r+85EhJ+8w@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Fri 20-12-24 00:24:50, Zhiyu Zhang wrote:
> We would like to report a Linux kernel bug titled "INFO: task hung in
> inode_sleep_on_writeback" on Linux-6.13-rc3 through our syzkaller.
> 
> We noticed that there was also a report in Linux-5.15 with the same title
> in November 2021 (
> https://syzkaller.appspot.com/bug?id=db653376de6a338b4a3c492b95634d6cabbdd68d),
> but it did not have any reproductors. We found the lacking Syz and C
> reproducers and can reproduce the issue in kernel 6.13-rc3 (see the
> reproduction log). But I am not sure if they share the same root cause.
> Here are the relevant attachments:
> 
> kernel config:
> https://drive.google.com/file/d/1d_Wuer-ZN1HELwDCoUHbWdlf8cIdRWOn/view?usp=sharing
> manual reproduction log:
> https://drive.google.com/file/d/1ZBshikZqJ78LHl7C3d4UOzPJE1konn9m/view?usp=sharing
> repro report:
> https://drive.google.com/file/d/1Nacupxxgcm6g3LZ95yADh7T9i20OFmM6/view?usp=sharing
> repro log:
> https://drive.google.com/file/d/1FlZPy9AJ9bu7MTEANszRV6IPo7dTe63G/view?usp=sharing
> syz reproducer:
> https://drive.google.com/file/d/1JA2KRWpLHglRGt2bgruYSgRrcDDE4fD3/view?usp=sharing
> C reproducer:
> https://drive.google.com/file/d/16AyJ0A-xXq32vXDbz714rmHuel9jvxyF/view?usp=sharing

Well, the reproducers are hardly relevant for this. The syz reproducer is:

r0 = socket$unix(0x1, 0x5, 0x0)
ioctl$sock_SIOCETHTOOL(r0, 0x89f0, ...)

and that's all... Definitely not a VFS bug, perhaps ask networking people
whether fuzzing SIOCETHTOOL ioctl makes sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

