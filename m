Return-Path: <linux-fsdevel+bounces-48050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E39AA9169
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB6A3B51C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD951FFC54;
	Mon,  5 May 2025 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zf8o/UX+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aXWNAbJh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zf8o/UX+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aXWNAbJh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69B1FC0F3
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746442538; cv=none; b=ZpWIc4sr/UuF8gEP94IwdP0brS2kCkCwIj3sJJnUNRibzxs7t1mQc4OKXFLoFWgV3XlbCONRvNIPuUympbygmYNQzO3Tshg9xbkyspanYTKDKPLPsV37JcyDPO0cJg+hwV2B4NgUcVnbkqPZwUYRlWafHTpXQcyMfLu29xjhDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746442538; c=relaxed/simple;
	bh=NVyUuuhas5lhmCvSYfi3WlGrlHUBAaQQJHqEtqAeMeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jon3DoHFZ2NVDcvHT9aOB59cRwM79Ju/TXTehL02JFkaFNCUnKueVjS0P85Krb+LTV6o0uOE2uUzlo1AOEZyB2AcH/QMhgHXZd5oFSlaYcTdCm0i9jzTmn3M0sVHbEHtsAUh91UDDwIFLbkTu8mc3CADXHWgZBJ7ZmFkxyBmpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zf8o/UX+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aXWNAbJh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zf8o/UX+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aXWNAbJh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41C891F453;
	Mon,  5 May 2025 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746442535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqRk3qpfRgL7++XKZ6UGIwyMkKle74QkFpwDPXidBIo=;
	b=zf8o/UX+x2ccmgCOTBseTFSy6lPYEM94wW3JU6OuGB23ri2Z2yUqoZVtnC6vibcMSC8xda
	Ew2pN9YQLR6drmP7nVvgRsnGM8wf0pAjhtxOPQDj0GucYufg/0CtyWD3Rtp3UgATkpWCHN
	xSGOOM2299J5Kj841+1yH1AINJ16HR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746442535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqRk3qpfRgL7++XKZ6UGIwyMkKle74QkFpwDPXidBIo=;
	b=aXWNAbJh946OUktgB5wk30uxcMfjZXR0GusjZQ90G/EqUANuc6d00b0GWeRLiM0/1sBZ7C
	8nxFx5mbE+p5KCBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746442535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqRk3qpfRgL7++XKZ6UGIwyMkKle74QkFpwDPXidBIo=;
	b=zf8o/UX+x2ccmgCOTBseTFSy6lPYEM94wW3JU6OuGB23ri2Z2yUqoZVtnC6vibcMSC8xda
	Ew2pN9YQLR6drmP7nVvgRsnGM8wf0pAjhtxOPQDj0GucYufg/0CtyWD3Rtp3UgATkpWCHN
	xSGOOM2299J5Kj841+1yH1AINJ16HR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746442535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqRk3qpfRgL7++XKZ6UGIwyMkKle74QkFpwDPXidBIo=;
	b=aXWNAbJh946OUktgB5wk30uxcMfjZXR0GusjZQ90G/EqUANuc6d00b0GWeRLiM0/1sBZ7C
	8nxFx5mbE+p5KCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 349D71372E;
	Mon,  5 May 2025 10:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yFfTDCeZGGh5BgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 10:55:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D2A06A0670; Mon,  5 May 2025 12:55:34 +0200 (CEST)
Date: Mon, 5 May 2025 12:55:34 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH][RFC][CFT] kill vfs_submount(), already
Message-ID: <utebik76wcdgaspk7sjzb3aedmlcwbmwj3olur45zuycbpapjc@pd5rhnudxb35>
References: <20250503212925.GZ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503212925.GZ2023217@ZenIV>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 03-05-25 22:29:25, Al Viro wrote:
> The last remaining user of vfs_submount() (tracefs) is easy to convert
> to fs_context_for_submount(); do that and bury that thing, along with
> SB_SUBMOUNT
> 
> If nobody objects, I'm going to throw that into the mount-related pile;
> alternatively, that could be split into kernel/trace.c part (in invariant
> branch, to be pulled by tracefs folks and into the mount pile before
> the rest of the patch).  Preferences?
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

...

> @@ -10072,6 +10073,8 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
>  {
>  	struct vfsmount *mnt;
>  	struct file_system_type *type;
> +	struct fs_context *fc;
> +	int ret;
>  
>  	/*
>  	 * To maintain backward compatibility for tools that mount
> @@ -10081,10 +10084,20 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
>  	type = get_fs_type("tracefs");
>  	if (!type)
>  		return NULL;
> -	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
> +
> +	fc = fs_context_for_submount(type, mntpt);
> +	if (IS_ERR(fc))
> +		return ERR_CAST(fc);

Missing put_filesystem() here?

> +
> +	ret = vfs_parse_fs_string(fc, "source",
> +				  "tracefs", strlen("tracefs"));
> +	if (!ret)
> +		mnt = fc_mount(fc);
> +	else
> +		mnt = ERR_PTR(ret);
> +
> +	put_fs_context(fc);
>  	put_filesystem(type);
> -	if (IS_ERR(mnt))
> -		return NULL;
>  	return mnt;
>  }

Otherwise looks good so with the fixup feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

