Return-Path: <linux-fsdevel+bounces-1184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7CF7D6E96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E38B21147
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABFE29411;
	Wed, 25 Oct 2023 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zk6vu6DD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EtTVcikI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4998473
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:21:58 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339E99;
	Wed, 25 Oct 2023 07:21:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A60421BB5;
	Wed, 25 Oct 2023 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698243715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m+wqEMlZRmmaiTawtcjDnjRXGd+ey2+AQbrwr0QEjw=;
	b=Zk6vu6DDY+yiUE2kKCcR5WHyZ6o2I/EGaNp5h+wXK9fjG5RnNRwIHmRzXe5Q/ffYBo/mTk
	qguxulYcwWRaKL2yg1UNfhgpqClYn80FvCkAWvzt/QVDlP0UiezNfZImCTr8dkhnGf4rgq
	t+gSva6X2gDmKBdWUBiDPxvKKxMy1AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698243715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m+wqEMlZRmmaiTawtcjDnjRXGd+ey2+AQbrwr0QEjw=;
	b=EtTVcikI8IWcHOjnCmdbzjetspIvRIPNXk5rUVrXAMuQy9oZfHZ56OcVWs8k9eeFrL/MmK
	sQt4Wg6fg02XCsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 697DB138E9;
	Wed, 25 Oct 2023 14:21:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id q0EqGYMkOWXhGgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 14:21:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F29D1A0679; Wed, 25 Oct 2023 16:21:54 +0200 (CEST)
Date: Wed, 25 Oct 2023 16:21:54 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fuse: derive f_fsid from s_dev and connection start time
Message-ID: <20231025142154.witld2g5iici24fr@quack3>
References: <20231025114228.23167-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025114228.23167-1-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.58
X-Spamd-Result: default: False [-6.58 / 50.00];
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
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.98)[99.92%]

On Wed 25-10-23 14:42:28, Amir Goldstein wrote:
> Use s_dev number and connection start time to report f_fsid in statfs(2).
> 
> The s_dev number could be easily recycled, so we use lower 32bits of the
> connection start time to try to avoid the recycling of f_fsid.
> The anon bdev number is only 20 bits (major is 0), so we could use more
> bits from connection start time, but avoiding f_fsid recycling is not
> critical, so 32bit is enough.
> 
> If the server does not support NFS export, fuse client still advertizes
> ->s_export_op, but those are non compliant operations that often cannot
> decode file handles, or worse, decode file hanldes to wrong objects.
> 
> In this case, leave f_fsid zero to signal fanotify and aware users to
> avoid exporting this incompliant fuse filesystem to NFS.
> 
> This allows fuse client to be monitored by fanotify filesystem watch
> for local client file access if server supports NFS export.
> 
> For example, with inotify-tools 4.23.8.0, the following command can be
> used to watch local client access over entire nfs filesystem:
> 
>   fsnotifywatch --filesystem /mnt/fuse
> 
> Note that fanotify filesystem watch does not report remote changes on
> server.  It provides the same notifications as inotify, but it watches
> over the entire filesystem and reports file handle of objects and fsid
> with events.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos,
> 
> I'd like to explain why I chose to tie setting fuse f_fsid with fuse
> server NFS export capability.
> 
> Since v6.6-rc7, fanotify permits sb/mount watch only for filesystems
> that know how to decode ALL file handles (not only how to encode).
> fanotify checks for the ->fh_to_dentry() method, which fuse always
> implements regardless of server NFS export support.
> 
> At first I considered assigning s_export_op depending on server NFS
> export support, but that would break the exising fuse best-effort decode
> behavior, whatever it is worth.
> 
> Currently, fanotify sb watch does not support fuse because of zero f_fsid,
> so I decided to keep it this way for the incomplete NFS export case.

OK, so this will keep fanotify not able to support inotify functionality in
this corner case. I'm fine with that but I'm making sure I understand the
implications.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

