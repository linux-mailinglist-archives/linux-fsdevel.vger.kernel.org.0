Return-Path: <linux-fsdevel+bounces-31218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C451993385
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E99285635
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A85A1DCB09;
	Mon,  7 Oct 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eMNx+f2H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkXuX+Ia";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eMNx+f2H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkXuX+Ia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B15F1DC735;
	Mon,  7 Oct 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318973; cv=none; b=jLLqALUGIaZ/IymCn5So9fWWQsX5D2HKKgL821kQKFmukdnC62qz2IVjrsPwwMVsP3uSeTKKNnS/u6ke82lgPMOwwiX9OSCo/inyG00/57mn5P3tWRUObG2TTN8/ijoIw49FEei46WVPsKroCFAaV1crt4hhzAM3tF0baaBHwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318973; c=relaxed/simple;
	bh=VztaX+9gTAlWmZdz+0uti4MjoKc0EkcnkbQwNIYYXUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sis7UbFETVVliG36KQa7HcQcWVwEFaoqNuuEA1gt5pVGEk3HidFS7HOemh5KZGgiYIz9WkFoBO1zjHkZoNWGbH6tWHoWNrEFapzgN8oo+oEpwKdIo+rNnG4mvqJU85OcyNq0hN+gaVAxWrDC2CBpfC+EuhjVRbJeHrp1N9KkgxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eMNx+f2H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkXuX+Ia; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eMNx+f2H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkXuX+Ia; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B6261FD60;
	Mon,  7 Oct 2024 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728318969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwNoAqJhXhpbGMqF1DzgplVeFBNHUOaYm/i1J0qxCSM=;
	b=eMNx+f2Hpbmm33XYXCpnOsVGLXB7kjRJr/tEo8pS2Zjc+ddcT1vbiD4g4hORlzrkhxjcyN
	W/Ooj95nJcTmwyLGCSBaUhq6BYWVTQXt61KTkf/q9l5NpAL7U8OQ9iZbnDDsjCatq3zd0u
	MqXxgnmn/sTqlYUL/zQ5MOmJI7ymkdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728318969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwNoAqJhXhpbGMqF1DzgplVeFBNHUOaYm/i1J0qxCSM=;
	b=EkXuX+IatllWm+gvYNbjntIzFysCJh5Jtw5iwCKGmE/YiqE1j9a2gFntpr2k7yDUENc3ho
	ZO4JuijXfaI5wdBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728318969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwNoAqJhXhpbGMqF1DzgplVeFBNHUOaYm/i1J0qxCSM=;
	b=eMNx+f2Hpbmm33XYXCpnOsVGLXB7kjRJr/tEo8pS2Zjc+ddcT1vbiD4g4hORlzrkhxjcyN
	W/Ooj95nJcTmwyLGCSBaUhq6BYWVTQXt61KTkf/q9l5NpAL7U8OQ9iZbnDDsjCatq3zd0u
	MqXxgnmn/sTqlYUL/zQ5MOmJI7ymkdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728318969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwNoAqJhXhpbGMqF1DzgplVeFBNHUOaYm/i1J0qxCSM=;
	b=EkXuX+IatllWm+gvYNbjntIzFysCJh5Jtw5iwCKGmE/YiqE1j9a2gFntpr2k7yDUENc3ho
	ZO4JuijXfaI5wdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FBBF132BD;
	Mon,  7 Oct 2024 16:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r3coH/kNBGc9JgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Oct 2024 16:36:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C215A07D0; Mon,  7 Oct 2024 18:36:09 +0200 (CEST)
Date: Mon, 7 Oct 2024 18:36:09 +0200
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: jack@suse.cz, hch@infradead.org, willy@infradead.org,
	akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] xfs: Let the max iomap length be consistent with
 the writeback code
Message-ID: <20241007163609.fkwiybr3nnw7utnc@quack3>
References: <20241006152849.247152-1-yizhou.tang@shopee.com>
 <20241006152849.247152-4-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006152849.247152-4-yizhou.tang@shopee.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 06-10-24 23:28:49, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> Since commit 1a12d8bd7b29 ("writeback: scale IO chunk size up to half
> device bandwidth"), macro MAX_WRITEBACK_PAGES has been removed from the
> writeback path. Therefore, the MAX_WRITEBACK_PAGES comments in
> xfs_direct_write_iomap_begin() and xfs_buffered_write_iomap_begin() appear
> outdated.
> 
> In addition, Christoph mentioned that the xfs iomap process should be
> similar to writeback, so xfs_max_map_length() was written following the
> logic of writeback_chunk_size().

Well, I'd defer to XFS maintainers here but at least to me it does not make
a huge amount of sense to scale mapping size with the device writeback
throughput. E.g. if the device writeback throughput is low, it does not
mean that it is good to perform current write(2) in small chunks...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

