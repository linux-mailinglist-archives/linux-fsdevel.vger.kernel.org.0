Return-Path: <linux-fsdevel+bounces-28349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01976969BC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D6B1F2574C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AC91A0BD8;
	Tue,  3 Sep 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PXeZmT3L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7WDOv1sp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PXeZmT3L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7WDOv1sp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E081B12E8
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363018; cv=none; b=Mxayux6E2kwiVEunatkKSUa7jGyl8iU+LbjKky+bnYTLFTMtSlzgSUIxmUNUWMe/WLgsFdhYTe1OKXSdtNxG7FycBZUT3bHwvGCM8mYgU/V33gNrCINirVTBtiKhbaeIKuguLqRRg/zNFwAtINcWrj0g/PepmpOZhAfF5NZ8pnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363018; c=relaxed/simple;
	bh=J1CeELRsvPhpop/MRRVixHu7FLGsSz67Lgaj4vXFujI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bai3a2RmZUQgbGpfVrJyx1GzRsL2N5xAns6xrqehiKpJDzDaC8vGfLiHnNHwsUFraYOXraTp/djymOysn+q8I45UVhUoMTVgsCrTs2lz+XlKsyPpvb2s2W0+kJGpurVcXsEhm2se6OPiE9oHCfV64RJ0dIICRTl7VTfZDJ441zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PXeZmT3L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7WDOv1sp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PXeZmT3L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7WDOv1sp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1AA61FD0C;
	Tue,  3 Sep 2024 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4c3Q0IEK6tkLSDg6A85qcXp9G7RoQAGIPuZ6QJH91Ww=;
	b=PXeZmT3LDJRQ5k7pN/g0Q9eCF5VrSWJ4m4hk5udp51iewhvrGDTV8zsSA6qeS4JVqYgi2g
	JI5A5F5Zn1qGU2fRLG1B3Uk6klepN3BtTB+LYNtQ39zxi3PfPHi2iN2r6eA1iwXz1on7ui
	to3JzqYT8BePA52I1x492udDnk/Bauc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4c3Q0IEK6tkLSDg6A85qcXp9G7RoQAGIPuZ6QJH91Ww=;
	b=7WDOv1sp1Bpy7FsoIJHBmGtFd5Fp7bYEkpBp68A3W6RYKsGgDt9rfFHaf4mVugHBX7oF7k
	xm0uyuyrko66oNBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4c3Q0IEK6tkLSDg6A85qcXp9G7RoQAGIPuZ6QJH91Ww=;
	b=PXeZmT3LDJRQ5k7pN/g0Q9eCF5VrSWJ4m4hk5udp51iewhvrGDTV8zsSA6qeS4JVqYgi2g
	JI5A5F5Zn1qGU2fRLG1B3Uk6klepN3BtTB+LYNtQ39zxi3PfPHi2iN2r6eA1iwXz1on7ui
	to3JzqYT8BePA52I1x492udDnk/Bauc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4c3Q0IEK6tkLSDg6A85qcXp9G7RoQAGIPuZ6QJH91Ww=;
	b=7WDOv1sp1Bpy7FsoIJHBmGtFd5Fp7bYEkpBp68A3W6RYKsGgDt9rfFHaf4mVugHBX7oF7k
	xm0uyuyrko66oNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9592813A52;
	Tue,  3 Sep 2024 11:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MAV+JEbz1ma0IQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 11:30:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 410C9A096C; Tue,  3 Sep 2024 13:30:10 +0200 (CEST)
Date: Tue, 3 Sep 2024 13:30:10 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 07/20] fs: use must_set_pos()
Message-ID: <20240903113010.atz4odkdmsl7oc2w@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-7-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-7-6d3e4816aa7b@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 30-08-24 15:04:48, Christian Brauner wrote:
> Make generic_file_llseek_size() use must_set_pos(). We'll use
> must_set_pos() in another helper in a minutes. Remove __maybe_unused
> from must_set_pos() now that it's used.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Frankly, it would have been a bit easier to review for me if 6 & 7 patches
were together as one code refactoring patch...

> +		guard(spinlock)(&file->f_lock);

You really love guards, don't you? :) Frankly, in this case I don't see the
point and it makes my visual pattern matching fail but I guess I'll get
used to it. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +		return vfs_setpos(file, file->f_pos + offset, maxsize);
>  	}
>  
>  	return vfs_setpos(file, offset, maxsize);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

