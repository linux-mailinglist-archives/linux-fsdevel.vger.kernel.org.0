Return-Path: <linux-fsdevel+bounces-48217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ACDAAC0D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 12:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9473AC7B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068532701B6;
	Tue,  6 May 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nwj6ZlrZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QlUFc5M7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3OW/QdYO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7pkniqqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F526FDAA
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525908; cv=none; b=tLSktSTtBiOst0vVFum34Sykq8FqKAihMCWrzNQcfUJqPyMl4xgnd4TJcREndoD2G/dTLDIWJAetVap6DahnoGnl9oDBalYy7RYUMbn3CI5sdSh+JSwnCvC8ydBrhOza+LdLo8wJWPlocL7HRStS4D/V78PShW0pmDXscBrZ6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525908; c=relaxed/simple;
	bh=NYYPUTt20O2TPocnUB7Huf4QETUChDygy6WWv8pAHHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QANY3RKpaobYpWMRWY6NjUeVdj9+GRaS+IW6hd1OImK3rzPelUzVlHTTO7TPgenKdoLEXaf5L+nkROfQ8OwTomhKFdQ5QpO6XRb8sC28WBL8NYatH0KnOwVCySCnKQy9or0bCK82cZkX2aHmNCQUxakpTG2tHJJTbZe90Faxrnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nwj6ZlrZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QlUFc5M7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3OW/QdYO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7pkniqqj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EDC81F441;
	Tue,  6 May 2025 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746525903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zk0fDN+7PJwjKDDJ2t6a08GL5EW0lCf5wZyG/z+TpX0=;
	b=nwj6ZlrZcRjlCYdYReDfiy1eA0rokC3eC7qMNjEzo6jZoP5RYGmCpmqTXYSz+gYSHdcBct
	1fQ8VGOSfmPR5GUJ3SjIgFC+FmaB6dnOwp3j1YObZqC5vMQp2Gq3UtLJzGZZUm+cO3/6al
	GgjxAZxybGEM732anF1sYDwIE+KC5qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746525903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zk0fDN+7PJwjKDDJ2t6a08GL5EW0lCf5wZyG/z+TpX0=;
	b=QlUFc5M7P2UMRTf5b8sMNOvsNWpV3EKID+TC1Ny1SOjRGv9mK8BD8XFGHZVSSgbMVHA+e0
	yZAzBiZGErpa+HCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746525902;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zk0fDN+7PJwjKDDJ2t6a08GL5EW0lCf5wZyG/z+TpX0=;
	b=3OW/QdYOX0c1xiiAgUgDKH2AcQ7BDVzfTjnX3yBpkGJhMqnt3PY4oT8nBSRc3gigMJWnco
	XxtBxQtK+j03L3mhgVDyfYkrDkoqyJg4Gfl5zHs1fQzyEJ4AZ/EsldoecJVF9js0IXMSor
	jEWK1qgIsbJZ7rr6c604gjs56bE4T2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746525902;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zk0fDN+7PJwjKDDJ2t6a08GL5EW0lCf5wZyG/z+TpX0=;
	b=7pkniqqj3sMt7dDjl4jgK30iZTiYX4ZtHQwoF9Zs7NawwyLpJYWEWz2IaTq8DDbxyN0L9U
	R2K4cBWvwD5vRkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 574EA13687;
	Tue,  6 May 2025 10:05:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sv0WFc7eGWjjegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 May 2025 10:05:02 +0000
Date: Tue, 6 May 2025 12:05:01 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 18/19] btrfs: use bdev_rw_virt in scrub_one_super
Message-ID: <20250506100500.GC9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-19-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430212159.2865803-19-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	R_RATELIMIT(0.00)[to_ip_from(RLndmnr811gycae4b5bcnms9ur)];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.com:email,lst.de:email,wdc.com:email,suse.cz:replyto];
	URIBL_BLOCKED(0.00)[suse.com:email];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Apr 30, 2025 at 04:21:48PM -0500, Christoph Hellwig wrote:
> Replace the code building a bio from a kernel direct map address and
> submitting it synchronously with the bdev_rw_virt helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Acked-by: David Sterba <dsterba@suse.com>

