Return-Path: <linux-fsdevel+bounces-11542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D13585483F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2E5284F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3351A58E;
	Wed, 14 Feb 2024 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lJEgdEXn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AFZz1bIy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lJEgdEXn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AFZz1bIy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C856118E1F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910036; cv=none; b=KK4rwNrOsfckWdS/dKMnxUarStRtjH++moIoTzaKUc/sfdr2yAOtfDbF6vsPqjZj3uDUoISzvxKHjJ8oEz14gARcZzaD9jOvHt7GWDpRxo8ovUHT4C2XHlCN5XeZbl3oDCcBd+2YqdHUjTVKH7sdN7CCmZ0T9rOziyJ/suv0K5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910036; c=relaxed/simple;
	bh=bZEq/2VAzjpCKRpiCSJ9euwJnx0X4CPHLj3NqUgVbEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuPvchhAEg473kYEzfGNdS52erYuFPEzKzkwZ54w2wk0k7O8CoBysGH5Q6AKmrTGY5bdMQVNZLXZGad6Mm4UDgwDoQ/o2YPjw6eeDK6sLpE1dpFiimldcf29YdCEk5Qf45PYVfYChXkflvqIisj5KiG+KxL3EiUG90oe+U4qnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lJEgdEXn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AFZz1bIy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lJEgdEXn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AFZz1bIy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4A371F7F4;
	Wed, 14 Feb 2024 11:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707910032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2/rPEejirCEJPHrU3cn/pRMU4v8znbFpkSqJjGzO+o=;
	b=lJEgdEXnn2kWa15NbsPhTbdvhsnWsKVLHhqtBG/7mss3eFVhWS3gYqAx1mtmfq03AOX4/m
	3OD5h+IdvoSi9RN2x8C9qojJkSmkvxT0zbDoalM1CAMo/MUpExULSw0725Xt2jWmnzsMvh
	fPHaiZKfAafefDvmmbHY5U8OTb2VUgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707910032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2/rPEejirCEJPHrU3cn/pRMU4v8znbFpkSqJjGzO+o=;
	b=AFZz1bIyjYTj1zAG91MOSetWM3jZcNXHit7Fix89IDkxTq4QBDGDgjOGfqNeDC1sm9XKLj
	xZl9vOLSpBbkskAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707910032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2/rPEejirCEJPHrU3cn/pRMU4v8znbFpkSqJjGzO+o=;
	b=lJEgdEXnn2kWa15NbsPhTbdvhsnWsKVLHhqtBG/7mss3eFVhWS3gYqAx1mtmfq03AOX4/m
	3OD5h+IdvoSi9RN2x8C9qojJkSmkvxT0zbDoalM1CAMo/MUpExULSw0725Xt2jWmnzsMvh
	fPHaiZKfAafefDvmmbHY5U8OTb2VUgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707910032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2/rPEejirCEJPHrU3cn/pRMU4v8znbFpkSqJjGzO+o=;
	b=AFZz1bIyjYTj1zAG91MOSetWM3jZcNXHit7Fix89IDkxTq4QBDGDgjOGfqNeDC1sm9XKLj
	xZl9vOLSpBbkskAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BB01C13A1A;
	Wed, 14 Feb 2024 11:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZIiiLZCjzGXWYwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 14 Feb 2024 11:27:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6EA3EA0809; Wed, 14 Feb 2024 12:27:12 +0100 (CET)
Date: Wed, 14 Feb 2024 12:27:12 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@redhat.com>,
	linux-fsdevel@vger.kernel.org, Bill O'Donnell <billodo@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] udf: convert to new mount API
Message-ID: <20240214112712.6e4icasqs66aj6hd@quack3>
References: <739fe39a-0401-4f5d-aef7-759ef82b36bd@redhat.com>
 <20240213124933.ftbnf3inbfbp77g4@quack3>
 <af9f80ae-3ecf-4efd-a0e2-e0f3b2520950@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9f80ae-3ecf-4efd-a0e2-e0f3b2520950@sandeen.net>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lJEgdEXn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AFZz1bIy
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.78)[99.04%]
X-Spam-Score: -3.79
X-Rspamd-Queue-Id: C4A371F7F4
X-Spam-Flag: NO

On Tue 13-02-24 17:11:27, Eric Sandeen wrote:
> On 2/13/24 6:49 AM, Jan Kara wrote:
> > On Fri 09-02-24 13:43:09, Eric Sandeen wrote:
> >> +	switch (token) {
> >> +	case Opt_novrs:
> >> +		uopt->novrs = 1;
> > 
> > I guess we can make this just an ordinary flag as a prep patch?
> 
> Sorry, not sure what you mean by this?
> 
> Oh, a uopt->flag. Ok, I can do that.

Yes, just a flag in uopt->flags. Sorry for being unclear.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

