Return-Path: <linux-fsdevel+bounces-28362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9909B969C36
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515DD2859AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7E1A42A5;
	Tue,  3 Sep 2024 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YG0M8Hwn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pahrHPGM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YG0M8Hwn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pahrHPGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA3D1A42C2
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363765; cv=none; b=t7WfDBmpyNYO2rd00f8bB/TpB92tqNPzDXZ8XYE79/XVsYKbYdVXNVCQ+hQMkOKGo4teQtcb7BbqfUaiyM+TUnrKw31CvoUm155k9FlOKRMIUc94zxdxf3kbmufN8s5V1kWIkI7gJTRsxlksgey0f5/N2T8rhO9skLqbkG/QvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363765; c=relaxed/simple;
	bh=t8hIi1s0rcKm0MP/2W9g/Jtc73c3vxFgJpE4RUP4LpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqYWtk4F54EMaRN9udXLfo38g97Ovrn0r5HdGm8/6TI9fqbmdcD/32CSGDZwjf3adl+K7ssR60XRdelmqqaEVixozyxX/MHYt+qQHdMzl3PxS9ZSIwBjS/qVtWr0d29LxDD94uqJX2QSRR1vqzuPrHGkxRzevmL658jeJSA9orM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YG0M8Hwn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pahrHPGM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YG0M8Hwn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pahrHPGM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94E921F444;
	Tue,  3 Sep 2024 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BL+DiX1NzlLrA8jVkcSnWxDKDascSP+D5ktjsfiIXe8=;
	b=YG0M8HwnNZOHR5Phzfq1lmYQo5HBXEAjCsuOucHuYBc4RjR9XhG4BoWOnkO/SGarV7IqyP
	ThRbLbKM+YmwPqA1X8f2vyxGkx/QaDRIONSFcKssChALXiWq3DDS6mRISnHNQvYrFhl9zr
	IsT3PensNPGTAm6Sry1H0X/sxI3bN+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BL+DiX1NzlLrA8jVkcSnWxDKDascSP+D5ktjsfiIXe8=;
	b=pahrHPGMsgjlRxA0RnAZFHXxzHAfhZ8fxLIxCkoFotcn0jYaxlyDwtx7XR6P1uomudO2rI
	esoAwvF4Hvybt/DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BL+DiX1NzlLrA8jVkcSnWxDKDascSP+D5ktjsfiIXe8=;
	b=YG0M8HwnNZOHR5Phzfq1lmYQo5HBXEAjCsuOucHuYBc4RjR9XhG4BoWOnkO/SGarV7IqyP
	ThRbLbKM+YmwPqA1X8f2vyxGkx/QaDRIONSFcKssChALXiWq3DDS6mRISnHNQvYrFhl9zr
	IsT3PensNPGTAm6Sry1H0X/sxI3bN+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BL+DiX1NzlLrA8jVkcSnWxDKDascSP+D5ktjsfiIXe8=;
	b=pahrHPGMsgjlRxA0RnAZFHXxzHAfhZ8fxLIxCkoFotcn0jYaxlyDwtx7XR6P1uomudO2rI
	esoAwvF4Hvybt/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 894F513A52;
	Tue,  3 Sep 2024 11:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sxx/ITH21ma3JQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 11:42:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C5D9A096C; Tue,  3 Sep 2024 13:42:41 +0200 (CEST)
Date: Tue, 3 Sep 2024 13:42:41 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 10/20] ext2: store cookie in private data
Message-ID: <20240903114241.4hr7ffb75epgerl6@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-10-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-10-6d3e4816aa7b@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 30-08-24 15:04:51, Christian Brauner wrote:
> Store the cookie to detect concurrent seeks on directories in
> file->private_data.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

