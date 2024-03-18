Return-Path: <linux-fsdevel+bounces-14755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC8C87EE88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 18:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A3C282BCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A53655C11;
	Mon, 18 Mar 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XPUpJ9Yv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yso7FAO/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XPUpJ9Yv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yso7FAO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494655C0B;
	Mon, 18 Mar 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781953; cv=none; b=jA+c4pcLynkuY6Y+jKmSN3uNj9iA38+j0+UyjGwWzjxpPd5fMX67NHppztKDNO4ispbcYhj5DS6KG2+tTAKDZgQXYk9y+xmTi1G/blDIud4rIh5JGlumXj/kVu7XFrl6RBlMrriJnKLMr0Ktz6bb9oTs1Trw2lNR9YswOfP3ynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781953; c=relaxed/simple;
	bh=KMaihn4MpIRXKl8tkj5Fn5F8oH1HWRx74ohqeZJYX2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2K9NYOq9fKZKsD/DYsGO2idQXy07gyJC5UUmH28bm9MbEa0Ggw4NNoB1TF3TO1up+tRadfF5Yx9cFzyt4D3ZjvWTtuS4afaMLnAQdQMlqZIzV+vedr83mQGCjGoNhDP5pgYfjyWf2U2gEkjgtomihPmcl5Bhg/RJFwutu5Szm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XPUpJ9Yv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yso7FAO/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XPUpJ9Yv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yso7FAO/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 928CB5C7CC;
	Mon, 18 Mar 2024 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710781949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IW6le/Od3RFdjNNBBDjiiTrXvpKiTjXrCzfAN8an4i0=;
	b=XPUpJ9YvFgaw3NKAv39mjAsdWsL0aIED9lP1SzUquXgFbqLWmUu6IEDXOx0aol0jlBFh4E
	Lfdfs68Nvn7rolnsdeHGKpLcOqgHkWFuzrA0PMb5BXpPkT09cO7ONp/w7fXOd1d36fgJWG
	jK8dfAFu5+KEuHKOkTnZ1Le4qcRn7qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710781949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IW6le/Od3RFdjNNBBDjiiTrXvpKiTjXrCzfAN8an4i0=;
	b=yso7FAO/xPIvJD02YRiwJVXl3YahgaS8+Hi+3DdCCNu2ww7vj49QyQcPXRUi+APx5y2b4U
	szW6uVFLm+nQllCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710781949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IW6le/Od3RFdjNNBBDjiiTrXvpKiTjXrCzfAN8an4i0=;
	b=XPUpJ9YvFgaw3NKAv39mjAsdWsL0aIED9lP1SzUquXgFbqLWmUu6IEDXOx0aol0jlBFh4E
	Lfdfs68Nvn7rolnsdeHGKpLcOqgHkWFuzrA0PMb5BXpPkT09cO7ONp/w7fXOd1d36fgJWG
	jK8dfAFu5+KEuHKOkTnZ1Le4qcRn7qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710781949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IW6le/Od3RFdjNNBBDjiiTrXvpKiTjXrCzfAN8an4i0=;
	b=yso7FAO/xPIvJD02YRiwJVXl3YahgaS8+Hi+3DdCCNu2ww7vj49QyQcPXRUi+APx5y2b4U
	szW6uVFLm+nQllCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86C92136A5;
	Mon, 18 Mar 2024 17:12:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8wd+IP11+GXKdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Mar 2024 17:12:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3897BA07D9; Mon, 18 Mar 2024 18:12:29 +0100 (CET)
Date: Mon, 18 Mar 2024 18:12:29 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz,
	Kemeng Shi <shikemeng@huaweicloud.com>, tim.c.chen@linux.intel.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Fixes and cleanups to fs-writeback
Message-ID: <20240318171229.ftdwkh3a45r4y6j7@quack3>
References: <20240228091958.288260-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228091958.288260-1-shikemeng@huaweicloud.com>
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Wed 28-02-24 17:19:52, Kemeng Shi wrote:
> v1->v2:
> -Filter non-expired in requeue_inode in patch "fs/writeback: avoid to
> writeback non-expired inode in kupdate writeback"
> -Wrap the comment at 80 columns in patch "fs/writeback: only calculate
> dirtied_before when b_io is empty"
> -Abandon patch "fs/writeback: remove unneeded check in
> writeback_single_inode"
> -Collect RVB from Jan and Tim

Christian, the series looks good to me. Please pick it up once your tree
settles after the merge window. Thanks!

								Honza

> 
> Kemeng Shi (6):
>   fs/writeback: avoid to writeback non-expired inode in kupdate
>     writeback
>   fs/writeback: bail out if there is no more inodes for IO and queued
>     once
>   fs/writeback: remove unused parameter wb of finish_writeback_work
>   fs/writeback: only calculate dirtied_before when b_io is empty
>   fs/writeback: correct comment of __wakeup_flusher_threads_bdi
>   fs/writeback: remove unnecessary return in writeback_inodes_sb
> 
>  fs/fs-writeback.c | 57 +++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
> 
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

