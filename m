Return-Path: <linux-fsdevel+bounces-1009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD47D4CC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 11:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EE31F2265E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3624A02;
	Tue, 24 Oct 2023 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r78bMzKu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GBX3RKSx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4E18E27
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 09:42:41 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899DCDA
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 02:42:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE9A91FD71;
	Tue, 24 Oct 2023 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698140557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qrq9v2CVUSm3Qz+Q16nXPSzF1+xgg0aSX1N4sSAt7TI=;
	b=r78bMzKulKUpUdRWjDk2iaU24ZL/FN4SIn1gKZbHZBQvVe4uDN3qT43GjqLLlFUfG9JUz5
	RDEspZzmPbC4SqY8EAEHNzHaQiI5haKsNCIL9QIwyAtgLk1ceVrKXuSRZBWp3dYT6tyPZr
	IhARFK37VhoeW8L/7nf1O9Swy6XLRtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698140557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qrq9v2CVUSm3Qz+Q16nXPSzF1+xgg0aSX1N4sSAt7TI=;
	b=GBX3RKSxpfo2qdBLUtFgADNti6YQPIWCpaRklj0Nsvi1oq77ajOCM39m/2dXh+cbve5Ujd
	a0/jPjTPQGN3/tCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9E1C134F5;
	Tue, 24 Oct 2023 09:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MKpKLY2RN2WODQAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 24 Oct 2023 09:42:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2FBC4A05BC; Tue, 24 Oct 2023 11:42:37 +0200 (CEST)
Date: Tue, 24 Oct 2023 11:42:37 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
	gfs2@lists.linux.dev
Subject: Re: [PATCH] gfs2: fs: derive f_fsid from s_uuid
Message-ID: <20231024094237.6yykkw6hhoynofzv@quack3>
References: <20231024075535.2994553-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024075535.2994553-1-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Tue 24-10-23 10:55:35, Amir Goldstein wrote:
> gfs2 already has optional persistent uuid.
> 
> Use that uuid to report f_fsid in statfs(2), same as ext2/ext4/zonefs.
> 
> This allows gfs2 to be monitored by fanotify filesystem watch.
> for example, with inotify-tools 4.23.8.0, the following command can be
> used to watch changes over entire filesystem:
> 
>   fsnotifywatch --filesystem /mnt/gfs2
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Andreas,
> 
> I do not have a test setup for gfs2, but this change it quite trivial,
> so I am posting it only compile tested.
> 
> There is no need to test fanotify. It enough to test statfs returns
> a non-zero f_fsid, e.g.:
> 
>   strace -e fstatfs du /mnt/gfs2
> 
> Thanks,
> Amir.
> 
>  fs/gfs2/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 02d93da21b2b..ea769af6bb23 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -1006,6 +1006,7 @@ static int gfs2_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_files = sc.sc_dinodes + sc.sc_free;
>  	buf->f_ffree = sc.sc_free;
>  	buf->f_namelen = GFS2_FNAMESIZE;
> +	buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

