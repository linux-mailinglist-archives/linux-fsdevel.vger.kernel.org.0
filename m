Return-Path: <linux-fsdevel+bounces-63489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03806BBE059
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 14:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF351894440
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E827EFE1;
	Mon,  6 Oct 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+L1B/FA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nM6s5d7U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+L1B/FA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nM6s5d7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47432905
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753671; cv=none; b=Lv/qOETZG5J4x1IJ/PATyZjW2UNXnr9EEsZk1q4PpNlSelzI9WQFqx/ihqHmeUvqpftc9IJKkmTh9uuJSaowOTV4PqfWvVll3v+K7mWobUyLJ5Ajcp6cnNF620HuCATMxqBxkArZbaQLMHErfj9VbWMmIZVhXsfk65PesIrF4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753671; c=relaxed/simple;
	bh=/NTevXZSFnQ/31fNmSOAIY46r7JdgTyiuBP55JiOD9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDas+u8IfUoa58flCB3sg+YLYeDUlBzoxjsc7wuqBbCiaSMsLAh/P4zbKZGwWCXUMGu6SrVEIp8D+MYaIa6AUN8mAJhoD6reeIAMVilYDZChbdeWZE6BIrotx5TANpKYKTv+82HahXXLV3wuhS948HVvmvRr8mJu3H8zX9QDKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+L1B/FA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nM6s5d7U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+L1B/FA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nM6s5d7U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC8CF336CB;
	Mon,  6 Oct 2025 12:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759753667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FwoYngzmfiSoIg9vahT8YwYodcNsuf0QQFtjuj9CMvo=;
	b=m+L1B/FAk4iB6G2+yY4SBcm4sES36Bngmmfw/T9dTVH65HGXao14uWdtsbNTOnI9qYXME4
	IjM07M+RcDybnwEbKYe/KOlH9g3U+paXHgU/2gawjRDw5easSgRsCR9V/Nw6yymhM8H9x2
	ZGq8yQes0nbjQ0v3Vyy3AohZGGyu0LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759753667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FwoYngzmfiSoIg9vahT8YwYodcNsuf0QQFtjuj9CMvo=;
	b=nM6s5d7UfcVCDJaqs9fugyNGcu1ibOIVI2CGQF/ntUhZU7Tg5jHesPS3Xp5DM0pbRUVND0
	kb2dBaDBhub8fQAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759753667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FwoYngzmfiSoIg9vahT8YwYodcNsuf0QQFtjuj9CMvo=;
	b=m+L1B/FAk4iB6G2+yY4SBcm4sES36Bngmmfw/T9dTVH65HGXao14uWdtsbNTOnI9qYXME4
	IjM07M+RcDybnwEbKYe/KOlH9g3U+paXHgU/2gawjRDw5easSgRsCR9V/Nw6yymhM8H9x2
	ZGq8yQes0nbjQ0v3Vyy3AohZGGyu0LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759753667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FwoYngzmfiSoIg9vahT8YwYodcNsuf0QQFtjuj9CMvo=;
	b=nM6s5d7UfcVCDJaqs9fugyNGcu1ibOIVI2CGQF/ntUhZU7Tg5jHesPS3Xp5DM0pbRUVND0
	kb2dBaDBhub8fQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A90E713995;
	Mon,  6 Oct 2025 12:27:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id om48KcO142g4dgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Oct 2025 12:27:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 29E4EA0AC4; Mon,  6 Oct 2025 14:27:47 +0200 (CEST)
Date: Mon, 6 Oct 2025 14:27:47 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] expfs: Fix exportfs_can_encode_fh() for EXPORT_FH_FID
Message-ID: <l5k4trkfuxfa2zyvy22ubqbjqs6kzaxh5jddwhi2gxonvhql3s@3udmtb2y7r6q>
References: <20251001145218.24219-2-jack@suse.cz>
 <20251006-umsturz-begriffen-0ecd57a1fa37@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006-umsturz-begriffen-0ecd57a1fa37@brauner>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Mon 06-10-25 13:02:09, Christian Brauner wrote:
> On Wed, Oct 01, 2025 at 04:52:19PM +0200, Jan Kara wrote:
> > After commit 5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode
> > connectable file handles") we will fail to create non-decodable file
> > handles for filesystems without export operations. Fix it.
> > 
> > Fixes: 5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode connectable file handles")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks! I've queued the patch into my tree.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

