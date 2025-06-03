Return-Path: <linux-fsdevel+bounces-50513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB1CACCE02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DB77A22C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 20:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ECD215787;
	Tue,  3 Jun 2025 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N9Kbvcl1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BB4lK6RI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N9Kbvcl1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BB4lK6RI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061F1F78E0
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748981645; cv=none; b=AUAZytNYIVxmTz3CfUkKRHz13EWtW+VOcPUGxz195uwf7xhhRdqc37EVzdqQjprl2BUwQqiel8vlFfa0shouYnskmrcGiFUS9USqYNSmAqz7gimEfU6i4I8UAL0vbT8rvsfMOOn9LcRZ7JyFch8TJa1UdrJvPeJhvSsVIGJ5mSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748981645; c=relaxed/simple;
	bh=/FE5D318lVBmJGkBSXZqasxXjKKZ++8Idk6bKIwi1GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCd7WdrgrIhkEyrtDudLnWjbXa9ldva9dRNqmbT0VZTQHKe914GOfrYO+Zw8JFg6RuSJvg042loL1jAOGMbqbRunHAYMPSPdvSa5G5u1tbJMExIb5rlqHgXVBDerTbbaQo2UOFiYddBToFiVEFWi7KCe6HVwRL/5GjrTm+eSI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N9Kbvcl1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BB4lK6RI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N9Kbvcl1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BB4lK6RI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A09B1F443;
	Tue,  3 Jun 2025 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748981642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWmBnvptzNYs4R0MZ3Uo0OTy6lzicOFPfnKUeZLec7k=;
	b=N9Kbvcl1o+W8mnAV52zBhxxyYHA97Cb9y96xWViRy3Yzan5mZrTcZW4eDHM+PDAJTz6E6N
	qoYcq5rOWPG+jlGqOMtgP4auf8TMckeLsezSaiWM+dn3D02fPUEyzQI3AS8wZGeQh0sTqW
	wVVj71wp9xcn1BGy/t0w8V9bMx0wFsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748981642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWmBnvptzNYs4R0MZ3Uo0OTy6lzicOFPfnKUeZLec7k=;
	b=BB4lK6RIU1ic1WRsD45tpMjFD1GpBqLcSKDtMJp9C60Whrnl6cXeo9AGiXcRfjhu8+mWDV
	KFXHeyv2/WXiGLDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748981642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWmBnvptzNYs4R0MZ3Uo0OTy6lzicOFPfnKUeZLec7k=;
	b=N9Kbvcl1o+W8mnAV52zBhxxyYHA97Cb9y96xWViRy3Yzan5mZrTcZW4eDHM+PDAJTz6E6N
	qoYcq5rOWPG+jlGqOMtgP4auf8TMckeLsezSaiWM+dn3D02fPUEyzQI3AS8wZGeQh0sTqW
	wVVj71wp9xcn1BGy/t0w8V9bMx0wFsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748981642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWmBnvptzNYs4R0MZ3Uo0OTy6lzicOFPfnKUeZLec7k=;
	b=BB4lK6RIU1ic1WRsD45tpMjFD1GpBqLcSKDtMJp9C60Whrnl6cXeo9AGiXcRfjhu8+mWDV
	KFXHeyv2/WXiGLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7FFB13A92;
	Tue,  3 Jun 2025 20:14:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TamiOIlXP2itDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Jun 2025 20:14:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 89AB6A08DD; Tue,  3 Jun 2025 22:13:53 +0200 (CEST)
Date: Tue, 3 Jun 2025 22:13:53 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Jonathan Corbet <corbet@lwn.net>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 21/28] fsnotify: export fsnotify_recalc_mask()
Message-ID: <ssbrsekgkssixxq4wiybw6k7n24efg64ozh6vrzxuft2sdz2w7@3tfmzfnqdwbu>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
 <20250602-dir-deleg-v2-21-a7919700de86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-dir-deleg-v2-21-a7919700de86@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.com,microsoft.com,talpey.com,brown.name,redhat.com,lwn.net,szeredi.hu,vger.kernel.org,lists.samba.org];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon 02-06-25 10:02:04, Jeff Layton wrote:
> nfsd needs to call this when new directory delegations are set or unset.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

So fsnotify_recalc_mask() is not a great API to export because it depends
on lifetime rules of mark connector - in particular the caller has to make
sure the connector stays alive while fsnotify_recalc_mask() is running. So
far the knowledge was internal in fsnotify subsystem but now NFSD needs to
know as well.

Generally you need to recalculate the mask when you modify events you
listen to in a mark. So perhaps we should provide an API like:

int fsnotify_modify_mark_mask(struct fsnotify_mark *mark, __u32 mask_clear,
			      __u32 mask_set);

which could be used to modify mark mask without having to care about
details like cached masks and connector locking rules?

								Honza

> ---
>  fs/notify/mark.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 798340db69d761dd05c1b361c251818dee89b9cf..ff21409c3ca3ad948557225afc586da3728f7cbe 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -308,6 +308,7 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  	if (update_children)
>  		fsnotify_conn_set_children_dentry_flags(conn);
>  }
> +EXPORT_SYMBOL_GPL(fsnotify_recalc_mask);
>  
>  /* Free all connectors queued for freeing once SRCU period ends */
>  static void fsnotify_connector_destroy_workfn(struct work_struct *work)
> 
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

