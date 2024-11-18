Return-Path: <linux-fsdevel+bounces-35095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F199D103E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E9CB24E81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B671990AD;
	Mon, 18 Nov 2024 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJR3/Fj/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t9odybke";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJR3/Fj/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t9odybke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20060192B83;
	Mon, 18 Nov 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930843; cv=none; b=Ixf/pV0fvTI8LbXCXKQF0VUbHAIfE2ZkrNgQRubySyPUev5GwtV0pcFmrbF2qiS6Nz+wsjLHkJj2iuMv3iawBAdfIxcuT3DgaVh1vdVItmc4NYFV4x77FqlRDgONh4Cd7dI8QlYebc0Pccb/OzeQPzT0EJzGCk8rKTIZUtydneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930843; c=relaxed/simple;
	bh=9K0skQr+EdtdZq7OjMJRx3mFXy+Jo/jUCpFh4T0wXY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV0pGh0z73UlDvA42bwq849fTXF5ieY5WalGFCDp3wL3LfIrcbiGnqsqQZPGCzHH26MTlv+/JKVZRBHicdZM465JcJoPgOXGMfNTrs6S0Fku6qCpNItejsjkkVvW8OVdIpjxL7wiyL25Z7vaD/mRwNBBdFwmmtyduKBJ2DvYgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JJR3/Fj/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t9odybke; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JJR3/Fj/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t9odybke; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C4DE1F365;
	Mon, 18 Nov 2024 11:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731930839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLf7ZLQq0TKYPEc5Ejp0DTc+VSVjliRrTmW46Mm3Ccw=;
	b=JJR3/Fj/QS0RT1xVrH8Wfxy8AWfOnynqCP/2eaSFu1CM0OiSKIqJ8fFK4zaWoVkQzCqI1c
	iz4QL/gFjJFEWMWGUrgXBnwx7etDww0lhGtzmF4RorW4q/Migii1vlEYSo3jDo5REHI0AE
	tIZfOOiLdzY3AFzZqhQWhoHojzCfE8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731930839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLf7ZLQq0TKYPEc5Ejp0DTc+VSVjliRrTmW46Mm3Ccw=;
	b=t9odybkeVcK8w6ssXXnLPAOVMJEz/kJBlsljxl02spWLyY1yeCzbXMfTTGI3mojYkO90xc
	wwMarSOxSQExZGCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731930839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLf7ZLQq0TKYPEc5Ejp0DTc+VSVjliRrTmW46Mm3Ccw=;
	b=JJR3/Fj/QS0RT1xVrH8Wfxy8AWfOnynqCP/2eaSFu1CM0OiSKIqJ8fFK4zaWoVkQzCqI1c
	iz4QL/gFjJFEWMWGUrgXBnwx7etDww0lhGtzmF4RorW4q/Migii1vlEYSo3jDo5REHI0AE
	tIZfOOiLdzY3AFzZqhQWhoHojzCfE8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731930839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLf7ZLQq0TKYPEc5Ejp0DTc+VSVjliRrTmW46Mm3Ccw=;
	b=t9odybkeVcK8w6ssXXnLPAOVMJEz/kJBlsljxl02spWLyY1yeCzbXMfTTGI3mojYkO90xc
	wwMarSOxSQExZGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DF5E134A0;
	Mon, 18 Nov 2024 11:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y2TFEtcqO2cvSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Nov 2024 11:53:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 10507A0984; Mon, 18 Nov 2024 12:53:59 +0100 (CET)
Date: Mon, 18 Nov 2024 12:53:59 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: dodge strlen() in vfs_readlink() when ->i_link
 is populated
Message-ID: <20241118115359.mzzx3avongvfqaha@quack3>
References: <20241118085357.494178-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118085357.494178-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 18-11-24 09:53:57, Mateusz Guzik wrote:
> This gives me about 1.5% speed up when issuing readlink on /initrd.img
> on ext4.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> I had this running with the following debug:
> 
> if (strlen(link) != inode->i_size)
>        printk(KERN_CRIT "mismatch [%s] %l %l\n", link,
>            strlen(link), inode->i_size);
> 
> nothing popped up

Then you didn't run with UDF I guess ;). There inode->i_size is the length
of on-disk symlink encoding which is definitely different from the length
of the string we return to VFS (it uses weird standards-defined cross OS
compatible encoding of a path and I'm not even mentioning its own special
encoding of character sets somewhat resembling UCS-2).

> I would leave something of that sort in if it was not defeating the
> point of the change.
> 
> However, I'm a little worried some crap fs *does not* fill this in
> despite populating i_link.
> 
> Perhaps it would make sense to keep the above with the patch hanging out
> in next and remove later?
> 
> Anyhow, worst case, should it turn out i_size does not work there are at
> least two 4-byte holes which can be used to store the length (and
> chances are some existing field can be converted into a union instead).

I'm not sure I completely follow your proposal here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

