Return-Path: <linux-fsdevel+bounces-45963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90092A7FD02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C7E7A8154
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A9E26A1AF;
	Tue,  8 Apr 2025 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GmWEWHi3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9j8h6o5x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I+huCvzD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2CIw5kfq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0226A0FD
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109505; cv=none; b=YYf7/qIDSRM0pBtGxU3HRiybN5Lnpu/fgbQdtg1NUGhGxect2dPvIwinm/DMouPE0oDYWG4WSLW2Cogn+5QV0L9a1WGp4V/2eh01r/wDCdDF+QLVobMjtX8MF6aTfBBuvV8AAjGqPG1mVfqdNukfEzQQ/ZBj7DQpOREYYJt6MxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109505; c=relaxed/simple;
	bh=CW5k9PVhgbQhjHRFTRLiHU3PmuzhWhZkeeLNwyzc2Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UB17ZBlVKbxICLFl4QiX8GEctV+cOJHX/2lTaUk2rbRS3i4jMGUhiYDKHT2wbEKPZ2adVWTnmtrnTTnr9l1p+GyiL/ysq6tUDVjWfsadvEf6YzchiPkoCp+oLTOVI/njAocUY3Ge0uNpAjithB/vqiqGoCJpJeR+sd9U/7r02ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GmWEWHi3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9j8h6o5x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I+huCvzD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2CIw5kfq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E48ED21166;
	Tue,  8 Apr 2025 10:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744109502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LsYIqUSSRKSClxnCqEpCDs1HKxaJn/fZ1QxIZffZ0A=;
	b=GmWEWHi32oGJUkPWgwYoiC9s8pUPaXaDpHP2iBnAcpDWeu34Z2d5FPoMTW0gqLEPc5b9R/
	1c8AAkFsmMxaOw6duZTRW3zSSeVJcppQ1s7ZAivE874zdhnoNr465ZlJbcVfVNgy4wKrKI
	SCRkC/Y9Ewf8cQY1nMG2k0xoOZQB1w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744109502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LsYIqUSSRKSClxnCqEpCDs1HKxaJn/fZ1QxIZffZ0A=;
	b=9j8h6o5xuiySSRs7rNDff2MOY0FfrnQTiQKDaED3/2Bnw5urCWYCrPi8msEmcP+XEtUEDZ
	ABbx7U+sh0e5mpCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744109501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LsYIqUSSRKSClxnCqEpCDs1HKxaJn/fZ1QxIZffZ0A=;
	b=I+huCvzDNSVALFO8Hbt9l/kVq9r+6uSIU1suC6d5f0tKcnzynDsJk8Ez7F4TTS9N665xXj
	FVTO5xXeG2feHC7auLEpl/RNRcYU4kIs7HPrObHNMZTRDFDZLRgtH83+9N3/a7sAs3wUY2
	hAfmlTF8vQExZb12ePLeN8ZUlqDTud0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744109501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LsYIqUSSRKSClxnCqEpCDs1HKxaJn/fZ1QxIZffZ0A=;
	b=2CIw5kfqVYG69IYcGyC66TAWu30UI7bpp0M6MCfAAtJYCGjZy/wzC3kF+fnRYEgJRAV14J
	X/porn2gJNVx19AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C371A13691;
	Tue,  8 Apr 2025 10:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hW+uL73/9GcsfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Apr 2025 10:51:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 651A4A0AC2; Tue,  8 Apr 2025 12:51:37 +0200 (CEST)
Date: Tue, 8 Apr 2025 12:51:37 +0200
From: Jan Kara <jack@suse.cz>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Carlos Maiolino <cem@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: Recent changes mean sb_min_blocksize() can now fail
Message-ID: <mnrpsfnhhp2xag62qmgdscbmtmskd6wcgytf6p44snkgdjeejc@ohpom722mvpn>
References: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
 <ormbk7uxe7v4givkz6ylo46aacfbrcy5zbasmti5tsqcirgijs@ulgt66vb2wbg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ormbk7uxe7v4givkz6ylo46aacfbrcy5zbasmti5tsqcirgijs@ulgt66vb2wbg>
X-Spam-Level: 
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -7.80
X-Spam-Flag: NO

On Tue 08-04-25 12:39:52, Jan Kara wrote:
> Hi!
> 
> On Tue 08-04-25 06:33:53, Phillip Lougher wrote:
> > A recent (post 6.14) change to the kernel means sb_min_blocksize() can now fail,
> > and any filesystem which doesn't check the result may behave unexpectedly as a
> > result.  This change has recently affected Squashfs, and checking the kernel code,
> > a number of other filesystems including isofs, gfs2, exfat, fat and xfs do not
> > check the result.  This is a courtesy email to warn others of this change.
> > 
> > The following emails give the relevant details.
> > 
> > https://lore.kernel.org/all/2a13ea1c-08df-4807-83d4-241831b7a2ec@squashfs.org.uk/
> > https://lore.kernel.org/all/129d4f39-6922-44e9-8b1c-6455ee564dda@squashfs.org.uk/
> 
> Indeed. Thanks for the heads up!

But isofs is actually fine since setting bdev block size needs exclusive open
(i.e., has to happen before filesystem mount begins and claims bdev) and
isofs does:

	if (bdev_logical_block_size(s->s_bdev) > 2048)
		bail

in its isofs_fill_super().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

