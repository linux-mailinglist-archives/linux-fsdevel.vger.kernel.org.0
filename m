Return-Path: <linux-fsdevel+bounces-21929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09390F20C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D51281A5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84571422A2;
	Wed, 19 Jun 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F3i361Wt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D2jQGQgI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F3i361Wt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D2jQGQgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A98182B5;
	Wed, 19 Jun 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810660; cv=none; b=Wwxy6M+R3U6ShV1UbWTvWR1XYG9RvozWOLAncvUUGOZuttuxxCzoXg8uAccGBE9SCXT5goZdXq4CnJE4gQmPkXmS4VXvF3bKsniahEl5gd0FcluoeWwBhlMAVfhdCAiaiNHkEdIGvcbiyxEcHu3Fn39kjz+q3yaVI8xaraf4Rus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810660; c=relaxed/simple;
	bh=ARoPuZGHWeRN8MWNbYI/DpJeTPhKv4n+bAv1vc+aLOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM6qBVcPkTeg4+j6Z9s73F3g4tZmPd+GirqH1O70FTWq1Iha3RfuwdPQhwOcnbZxD12Boif1z3v9/LVVTvaMdRCXhu95hxz9u0XoMffymFBEN/ybqd1Qh7eyVqGNEHCGt0YB8sZ7MhpjhfN0eR2kq2wHMXGWEGLt2GkRpX2xhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F3i361Wt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D2jQGQgI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F3i361Wt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D2jQGQgI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B01D521A20;
	Wed, 19 Jun 2024 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718810656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJ+UYFD/N7qm9nO59jHP1L8zunVg8bgGBkSW5rkBCpE=;
	b=F3i361WtkEjU+H+ilI6YVXHdA85TftedojuS6LUaCp4KNYVnn5LIznNVqaTdwnyZ7Js1cc
	c+u9UQXPDdGvRD/Q5UgyvKjuucSJ126K45QdoNkhWClvGEN2ngp/EWGdcDHn2azr4uF8LC
	By5YaCQFkyFjqCdllSF4ewiMt2KQ2wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718810656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJ+UYFD/N7qm9nO59jHP1L8zunVg8bgGBkSW5rkBCpE=;
	b=D2jQGQgIJ/3hj3FNZn6UisJAU4ikRVT1uATuGVBs7YWKiUJFd8gVLXoycWazMmbp2RLYNO
	mSYmKIUNK+qrORBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718810656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJ+UYFD/N7qm9nO59jHP1L8zunVg8bgGBkSW5rkBCpE=;
	b=F3i361WtkEjU+H+ilI6YVXHdA85TftedojuS6LUaCp4KNYVnn5LIznNVqaTdwnyZ7Js1cc
	c+u9UQXPDdGvRD/Q5UgyvKjuucSJ126K45QdoNkhWClvGEN2ngp/EWGdcDHn2azr4uF8LC
	By5YaCQFkyFjqCdllSF4ewiMt2KQ2wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718810656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJ+UYFD/N7qm9nO59jHP1L8zunVg8bgGBkSW5rkBCpE=;
	b=D2jQGQgIJ/3hj3FNZn6UisJAU4ikRVT1uATuGVBs7YWKiUJFd8gVLXoycWazMmbp2RLYNO
	mSYmKIUNK+qrORBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97A7613668;
	Wed, 19 Jun 2024 15:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FSf9JCD4cmbSIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 19 Jun 2024 15:24:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F0473A0887; Wed, 19 Jun 2024 17:24:11 +0200 (CEST)
Date: Wed, 19 Jun 2024 17:24:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	James Clark <james.clark@arm.com>, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@suse.de>, Al Viro <viro@ZenIV.linux.org.uk>,
	ltp@lists.linux.it
Subject: Re: [PATCH 1/2] fsnotify: Do not generate events for O_PATH file
 descriptors
Message-ID: <20240619152411.gf7bzkrlwsdrci5t@quack3>
References: <20240617161828.6718-1-jack@suse.cz>
 <20240617162303.1596-1-jack@suse.cz>
 <20240618-modular-galaabend-c0dba5521bc4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-modular-galaabend-c0dba5521bc4@brauner>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com,arm.com,suse.de,ZenIV.linux.org.uk,lists.linux.it];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 18-06-24 16:28:01, Christian Brauner wrote:
> On Mon, 17 Jun 2024 18:23:00 +0200, Jan Kara wrote:
> > Currently we will not generate FS_OPEN events for O_PATH file
> > descriptors but we will generate FS_CLOSE events for them. This is
> > asymmetry is confusing. Arguably no fsnotify events should be generated
> > for O_PATH file descriptors as they cannot be used to access or modify
> > file content, they are just convenient handles to file objects like
> > paths. So fix the asymmetry by stopping to generate FS_CLOSE for O_PATH
> > file descriptors.
> > 
> > [...]
> 
> I added a Cc stable to the first patch because this seems like a bugfix
> per the mail discussion.

Yes, makes sense. Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

