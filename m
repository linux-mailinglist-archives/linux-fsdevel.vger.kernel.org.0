Return-Path: <linux-fsdevel+bounces-35337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37019D3FA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 17:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DCA283E26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAF315666B;
	Wed, 20 Nov 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPL8HFP6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CeqAFCN+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPL8HFP6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CeqAFCN+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B9150994;
	Wed, 20 Nov 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118572; cv=none; b=NzXekyu11CTxok1Ac0AwKvBfhTLMzZcFTIcC2D21VNc30/RkO7/qz6rQXZVITgETZDZhw/XlFARjNDumqza5LWuIhJNl8peCUReHvRU+v27S6nT7/8UtqHvE1SKWdLy/uF8GrudYoKwOzTdWX5gShmJ0YfJIDe/rJMtxvei1LcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118572; c=relaxed/simple;
	bh=28JZ2JhdmHYx0AxvZH8IesVsMcFth30HT6tSk3FPdw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxBJ1mcXcD9ZsqlIjBz+q8UQfF/tDuHmLRANGRfJaFFv2lNzjCnS0qZyWV8a8Uj0W7GmlLcLqxcfgiHZVjWBGMxmsD/ChHyAkqdRWG614awLCeRy1WYr8mMjgAY6oUWrUHaySMhMCxPL/TEGY3mTzCN7geoU5Vhd3nv/IxKr3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPL8HFP6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CeqAFCN+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPL8HFP6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CeqAFCN+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 653D5219D2;
	Wed, 20 Nov 2024 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732118568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmP2A+ShM59AJ2PeA+C8ggNciw9KPOOhXEG938mquuE=;
	b=cPL8HFP6J7v/QnK9pgvClidCMVHk1Zp32roF7o0Edg5tZgSEtfU8F/QdPP6Q9qD+3LwLGR
	QrnY+koK8lg3QXn+oAqBawaUPtlBXzkTC/EiGb1pwHorQyy8J9uF0vRj67mWu6/QBSZkHY
	rvEja+P50fOl3SFAKNHs93jswrd0zQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732118568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmP2A+ShM59AJ2PeA+C8ggNciw9KPOOhXEG938mquuE=;
	b=CeqAFCN+l4TeJ7YA7twpK9X/7BztbIh5T8H3kto7+IGsAz4hbFaxvocNBMALmVg4mJIi9V
	xsnhKTaUfUVe8vBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732118568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmP2A+ShM59AJ2PeA+C8ggNciw9KPOOhXEG938mquuE=;
	b=cPL8HFP6J7v/QnK9pgvClidCMVHk1Zp32roF7o0Edg5tZgSEtfU8F/QdPP6Q9qD+3LwLGR
	QrnY+koK8lg3QXn+oAqBawaUPtlBXzkTC/EiGb1pwHorQyy8J9uF0vRj67mWu6/QBSZkHY
	rvEja+P50fOl3SFAKNHs93jswrd0zQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732118568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmP2A+ShM59AJ2PeA+C8ggNciw9KPOOhXEG938mquuE=;
	b=CeqAFCN+l4TeJ7YA7twpK9X/7BztbIh5T8H3kto7+IGsAz4hbFaxvocNBMALmVg4mJIi9V
	xsnhKTaUfUVe8vBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53CF7137CF;
	Wed, 20 Nov 2024 16:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sQnyEygIPmdiTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Nov 2024 16:02:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 06A94A08A2; Wed, 20 Nov 2024 17:02:48 +0100 (CET)
Date: Wed, 20 Nov 2024 17:02:47 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 03/19] fsnotify: add helper to check if file is
 actually being watched
Message-ID: <20241120160247.sdvonyxkpmf4wnt2@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <2ddcc9f8d1fde48d085318a6b5a889289d8871d8.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ddcc9f8d1fde48d085318a6b5a889289d8871d8.1731684329.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 15-11-24 10:30:16, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> So far, we set FMODE_NONOTIFY_ flags at open time if we know that there
> are no permission event watchers at all on the filesystem, but lack of
> FMODE_NONOTIFY_ flags does not mean that the file is actually watched.
> 
> To make the flags more accurate we add a helper that checks if the
> file's inode, mount, sb or parent are being watched for a set of events.
> 
> This is going to be used for setting FMODE_NONOTIFY_HSM only when the
> specific file is actually watched for pre-content events.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I did some changes here as well. See below:

> -/* Are there any inode/mount/sb objects that are interested in this event? */
> -static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
> -					   __u32 mask)
> +/* Are there any inode/mount/sb objects that watch for these events? */
> +static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
> +					    __u32 events_mask)
>  {
>  	__u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
>  			   READ_ONCE(inode->i_sb->s_fsnotify_mask);
>  
> -	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
> +	return events_mask & marks_mask;
>  }
>  
> +/* Are there any inode/mount/sb/parent objects that watch for these events? */
> +__u32 fsnotify_file_object_watched(struct file *file, __u32 events_mask)
> +{
> +	struct dentry *dentry = file->f_path.dentry;
> +	struct dentry *parent;
> +	__u32 marks_mask, mnt_mask =
> +		READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
> +
> +	marks_mask = fsnotify_object_watched(d_inode(dentry), mnt_mask,
> +					     events_mask);
> +
> +	if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)))
> +		return marks_mask;
> +
> +	parent = dget_parent(dentry);
> +	marks_mask |= fsnotify_inode_watches_children(d_inode(parent));
> +	dput(parent);
> +
> +	return marks_mask & events_mask;
> +}
> +EXPORT_SYMBOL_GPL(fsnotify_file_object_watched);

I find it confusing that fsnotify_object_watched() does not take parent
into account while fsnotify_file_object_watched() does. Furthermore the
naming doesn't very well reflect the fact we are actually returning a mask
of events. I've ended up dropping this helper (it's used in a single place
anyway) and instead doing the same directly in file_set_fsnotify_mode().

@@ -658,6 +660,27 @@ void file_set_fsnotify_mode(struct file *file)
                file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
                return;
        }
+
+       /*
+        * OK, there are some pre-content watchers. Check if anybody can be
+        * watching for pre-content events on *this* file.
+        */
+       mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
+       if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
+           !fsnotify_object_watched(d_inode(dentry), mnt_mask,
+                                    FSNOTIFY_PRE_CONTENT_EVENTS))) {
+               file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
+               return;
+       }
+
+       /* Even parent is not watching for pre-content events on this file? */
+       parent = dget_parent(dentry);
+       p_mask = fsnotify_inode_watches_children(d_inode(parent));
+       dput(parent);
+       if (!(p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
+               file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
+               return;
+       }
 }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

