Return-Path: <linux-fsdevel+bounces-37805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7F79F7E53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337BE16775C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A522616C;
	Thu, 19 Dec 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mFlmKKQt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NiPd19En";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mFlmKKQt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NiPd19En"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D33D3B8;
	Thu, 19 Dec 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623203; cv=none; b=lDTvGpdHWoPza1MadntfUdUjnnefzAklioOF+wyRXIeFYQv0V+FJJlOcG0Sc7JFXYEO3ZJSJkozsidW2gByW8eCqlThPB1aSLkEGN8PYKponDa5jRqHV+eDhVMoj6yHpMfzheuin86psst6K+9D4TGGw55lEzwe0292r+mvzX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623203; c=relaxed/simple;
	bh=0PWKfo11mb5vs+kRP1HxuTgxz7C5o804QfSQ2iaWR+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FW48EeIrUttQDrVAZgEaH+olq7yo+OxxpA+Rtu2t2paOv4uP1MlfjQf1FMeUbaPODX4HpMaUrT3tOAZ0KZsoh2I4AuAEKtW4N2EcrQ1vrMmF7EefQAkX7bpFah7XzjFguKKFPi3qOXj0HHGn7EvV8FKq2iPnE3pAdFj2gpz8hdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mFlmKKQt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NiPd19En; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mFlmKKQt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NiPd19En; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37C681F396;
	Thu, 19 Dec 2024 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734623199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udT7UZql6pDsfzcNT3uRscRGefgaW0sCcaRIh9dAU60=;
	b=mFlmKKQt8Ain4oZHtsHmuoUMx3r818KpUIqj8N0hGzPdH9j3kGyEhfmpGtejzxncID50LW
	Zhp2WUT8GGokukINhqwvtBG7mjgNjuusCfDCpTA9nbak29UHvFKkJ9luWc5DVrW7AcIfub
	5+ztrMuEWMxhtMYY46o42mrNQpk3zfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734623199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udT7UZql6pDsfzcNT3uRscRGefgaW0sCcaRIh9dAU60=;
	b=NiPd19EnfYlTdz0iG1X/Mvc9ASFZzpS4XLlwcYc0N0t/3COWxayaOXKszFX+rBPNZYMbzs
	9ZhrYOzRFDwj4wDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734623199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udT7UZql6pDsfzcNT3uRscRGefgaW0sCcaRIh9dAU60=;
	b=mFlmKKQt8Ain4oZHtsHmuoUMx3r818KpUIqj8N0hGzPdH9j3kGyEhfmpGtejzxncID50LW
	Zhp2WUT8GGokukINhqwvtBG7mjgNjuusCfDCpTA9nbak29UHvFKkJ9luWc5DVrW7AcIfub
	5+ztrMuEWMxhtMYY46o42mrNQpk3zfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734623199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udT7UZql6pDsfzcNT3uRscRGefgaW0sCcaRIh9dAU60=;
	b=NiPd19EnfYlTdz0iG1X/Mvc9ASFZzpS4XLlwcYc0N0t/3COWxayaOXKszFX+rBPNZYMbzs
	9ZhrYOzRFDwj4wDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ED8713ADA;
	Thu, 19 Dec 2024 15:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CsyWA98/ZGeyQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Dec 2024 15:46:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D3FAA0904; Thu, 19 Dec 2024 16:46:34 +0100 (CET)
Date: Thu, 19 Dec 2024 16:46:34 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Edward Adam Davis <eadavis@qq.com>,
	Dmitry Safonov <dima@arista.com>, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: relax assertions on failure to encode file handles
Message-ID: <20241219154634.5z44m6erx3lxeq67@quack3>
References: <20241219115301.465396-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219115301.465396-1-amir73il@gmail.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,szeredi.hu,qq.com,arista.com,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[ec07f6f5ce62b858579f];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 19-12-24 12:53:01, Amir Goldstein wrote:
> Encoding file handles is usually performed by a filesystem >encode_fh()
> method that may fail for various reasons.
> 
> The legacy users of exportfs_encode_fh(), namely, nfsd and
> name_to_handle_at(2) syscall are ready to cope with the possibility
> of failure to encode a file handle.
> 
> There are a few other users of exportfs_encode_{fh,fid}() that
> currently have a WARN_ON() assertion when ->encode_fh() fails.
> Relax those assertions because they are wrong.
> 
> The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
> encoding non-decodable file handles") in v6.6 as the regressing commit,
> but this is not accurate.
> 
> The aforementioned commit only increases the chances of the assertion
> and allows triggering the assertion with the reproducer using overlayfs,
> inotify and drop_caches.
> 
> Triggering this assertion was always possible with other filesystems and
> other reasons of ->encode_fh() failures and more particularly, it was
> also possible with the exact same reproducer using overlayfs that is
> mounted with options index=on,nfs_export=on also on kernels < v6.6.
> Therefore, I am not listing the aforementioned commit as a Fixes commit.
> 
> Backport hint: this patch will have a trivial conflict applying to
> v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.
> 
> Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024f.GAE@google.com/
> Reported-by: Dmitry Safonov <dima@arista.com>
> Closes: https://lore.kernel.org/linux-fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Yeah, looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Christian,
> 
> I could have sumbitted two independant patches to relax the assertion
> in fsnotify and overlayfs via fsnotify and overlayfs trees, but the
> nature of the problem is the same and in both cases, the problem became
> worse with the introduction of non-decodable file handles support,
> so decided to fix them together and ask you to take the fix via the
> vfs tree.
> 
> Please let you if you think it should be done differently.
> 
> Thanks,
> Amir.
> 
>  fs/notify/fdinfo.c     | 4 +---
>  fs/overlayfs/copy_up.c | 5 ++---
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index dec553034027e..e933f9c65d904 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -47,10 +47,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
>  	size = f->handle_bytes >> 2;
>  
>  	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
> -	if ((ret == FILEID_INVALID) || (ret < 0)) {
> -		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
> +	if ((ret == FILEID_INVALID) || (ret < 0))
>  		return;
> -	}
>  
>  	f->handle_type = ret;
>  	f->handle_bytes = size * sizeof(u32);
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 3601ddfeddc2e..56eee9f23ea9a 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -442,9 +442,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
>  	buflen = (dwords << 2);
>  
>  	err = -EIO;
> -	if (WARN_ON(fh_type < 0) ||
> -	    WARN_ON(buflen > MAX_HANDLE_SZ) ||
> -	    WARN_ON(fh_type == FILEID_INVALID))
> +	if (fh_type < 0 || fh_type == FILEID_INVALID ||
> +	    WARN_ON(buflen > MAX_HANDLE_SZ))
>  		goto out_err;
>  
>  	fh->fb.version = OVL_FH_VERSION;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

