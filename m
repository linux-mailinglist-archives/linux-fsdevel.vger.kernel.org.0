Return-Path: <linux-fsdevel+bounces-24855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F4945B12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185C4288B10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995CC1DAC53;
	Fri,  2 Aug 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="riDDj+YK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ER7lLSyt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="riDDj+YK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ER7lLSyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B41C37A4;
	Fri,  2 Aug 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591200; cv=none; b=KNNxx19qCnI19UKm5XQ0aqdot2QbFkRfZu3hjZYoDBSXJ+2BoswIV9EztopUZhOvgdWYvDuLRPYAou1J/mECctFUtCnSra3EuHV0R5QiiEEv/tLuFb4xTqtunJ/J7X0KtWHQYodl3TUN/RzxKoI6ZLa9TY2KvgJ2cVLz4BHnzIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591200; c=relaxed/simple;
	bh=spKZID6KM/2QnxyqFtrSsJaYO7p6ETZufbSeTAO5/3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6q/+mkGf2R0J7Xui704kDImSCgcN6TGT4otYNfDPqdqUazelwQ9piXo/ossf8ZjSWIRDXj125JjHWwqHaNM5ngchsfQiIrbjJPFMRqRQ5pnCTIAgcCv0z0MXrxfFuyxPy821B4jNbslrjgK5QJstMKSO+ZpYGXm4puvmMouFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=riDDj+YK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ER7lLSyt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=riDDj+YK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ER7lLSyt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C0FD1F807;
	Fri,  2 Aug 2024 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722591196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVWMdak+idnOkUocEVgkhISNn1L9MPUyres+uiWUp5I=;
	b=riDDj+YK0rBWN1iBKXoZoJWGR0IeqN9+GkgLI/+dz2hv1eMMveoK3FoQd0FHXVIqc6k6fn
	bwxi0mgoir6rZ5aB11/vUIv1gN1ybCvD2ZtBLE5EOhwxUfgDe1dTFAo+eLXdh3aQqgbaPE
	Ol3SXoBCBcVjy0UcNEIUYVQ3LilIkWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722591196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVWMdak+idnOkUocEVgkhISNn1L9MPUyres+uiWUp5I=;
	b=ER7lLSytDOAq/wAAruvPLEW0A5aLRCFO06Sc8ylsNiy8/PHG4Suim9xqyMFy6eb+9ZkB6c
	AUXCCGrFQCSOdpBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722591196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVWMdak+idnOkUocEVgkhISNn1L9MPUyres+uiWUp5I=;
	b=riDDj+YK0rBWN1iBKXoZoJWGR0IeqN9+GkgLI/+dz2hv1eMMveoK3FoQd0FHXVIqc6k6fn
	bwxi0mgoir6rZ5aB11/vUIv1gN1ybCvD2ZtBLE5EOhwxUfgDe1dTFAo+eLXdh3aQqgbaPE
	Ol3SXoBCBcVjy0UcNEIUYVQ3LilIkWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722591196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVWMdak+idnOkUocEVgkhISNn1L9MPUyres+uiWUp5I=;
	b=ER7lLSytDOAq/wAAruvPLEW0A5aLRCFO06Sc8ylsNiy8/PHG4Suim9xqyMFy6eb+9ZkB6c
	AUXCCGrFQCSOdpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0180F1388E;
	Fri,  2 Aug 2024 09:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id galYANynrGaBKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 02 Aug 2024 09:33:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A1AA0A08CB; Fri,  2 Aug 2024 11:33:10 +0200 (CEST)
Date: Fri, 2 Aug 2024 11:33:10 +0200
From: Jan Kara <jack@suse.cz>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH V4] squashfs: Add i_size check in squash_read_inode
Message-ID: <20240802093310.twbwdi5hpgpth63z@quack3>
References: <20240802015006.900168-1-lizhi.xu@windriver.com>
 <20240802030114.1400462-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802030114.1400462-1-lizhi.xu@windriver.com>
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[24ac24ff58dc5b0d26b9];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Fri 02-08-24 11:01:14, Lizhi Xu wrote:
> syzbot report KMSAN: uninit-value in pick_link, the root cause is that
> squashfs_symlink_read_folio did not check the length, resulting in folio
> not being initialized and did not return the corresponding error code.
> 
> The length is calculated from i_size, so it is necessary to add a check
> when i_size is initialized to confirm that its value is correct, otherwise
> an error -EINVAL will be returned. Strictly, the check only applies to the
> symlink type.
> 
> Reported-and-tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/squashfs/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
> index 16bd693d0b3a..6c5dd225482f 100644
> --- a/fs/squashfs/inode.c
> +++ b/fs/squashfs/inode.c
> @@ -287,6 +287,11 @@ int squashfs_read_inode(struct inode *inode, long long ino)
>  		inode->i_mode |= S_IFLNK;
>  		squashfs_i(inode)->start = block;
>  		squashfs_i(inode)->offset = offset;
> +		if ((int)inode->i_size < 0) {

Looks good. I think you could actually add even more agressive check like:

		if (inode->i_size > PAGE_SIZE) {

because larger symlink isn't supported by squashfs code anyway.

									Honza

> +			ERROR("Wrong i_size %d!\n", inode->i_size);
> +			return -EINVAL;
> +		}
> +
>  
>  		if (type == SQUASHFS_LSYMLINK_TYPE) {
>  			__le32 xattr;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

