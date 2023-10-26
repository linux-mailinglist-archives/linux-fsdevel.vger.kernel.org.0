Return-Path: <linux-fsdevel+bounces-1258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C87D867D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 18:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A347A2820C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88742381B2;
	Thu, 26 Oct 2023 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C8JVqBf1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xlJE7qJ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC635882
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 16:09:46 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDC393;
	Thu, 26 Oct 2023 09:09:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 872841FE64;
	Thu, 26 Oct 2023 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698336582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwAp/mQgApa6l7tdDPAt6K53LUiaocrCSwsIEY4c2hc=;
	b=C8JVqBf1CS3O2LMbuTv9dOlWx0xnebGWPiFiB1mnCesqGGB21T7umKuCKvCVQN04aAgH3Y
	sbcSpQexhXeDI+otowszDfMIXVXAyx4+VPht06VKLzeTdlQuiMLuutE5aUzBH2Sued328u
	ieMMixrGrn7TjoYLvlBxis83PF16hjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698336582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwAp/mQgApa6l7tdDPAt6K53LUiaocrCSwsIEY4c2hc=;
	b=xlJE7qJ0SFSQo2PQP472u0bKjS3kIfFwO28NuII+etsOXLJ66+unP/R9Jc4ZtX2JL3ppI5
	WCsYl0Nl/tJcymCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B9C9133F5;
	Thu, 26 Oct 2023 16:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id GgMzGkaPOmWuDwAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 26 Oct 2023 16:09:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CCA28A05BC; Thu, 26 Oct 2023 18:09:41 +0200 (CEST)
Date: Thu, 26 Oct 2023 18:09:41 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231026160941.mja25aiww6mccnzi@quack3>
References: <20231026155224.129326-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026155224.129326-1-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.35
X-Spamd-Result: default: False [-5.35 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.75)[93.48%]

On Thu 26-10-23 18:52:21, Amir Goldstein wrote:
> As agreed on the review of v1 [1], we do not need any vfs changes
> to support fanotify on btrfs sub-volumes and we can enable setting
> marks on btrfs sub-volumes simply by caching the fsid in the mark
> object instead of the connector.
> 
> This is the would be man page update to clarify the meaning of fsid
> as it is reflected in this patch set:
> 
> fsid
> 
>   This is a unique identifier of the filesystem containing the object
>   associated with the event.  It is a structure of type __kernel_fsid_t
>   and contains the same value reported in  f_fsid  when calling
>   statfs(2) with the same pathname argument that was used for
>   fanotify_mark(2).  Note that some filesystems (e.g., btrfs(5)) report
>   non-uniform values of f_fsid on different objects of the same filesystem.
>   In these cases, if fanotify_mark(2) is called several times with different
>   pathname values, the fsid value reported in events will match f_fsid
>   associated  with at least one of those pathname values.

Thanks! The patchset looks good to me but I don't want to queue it now so
shortly before the merge window opens. So I'll queue it into my tree once
I'll push out changes for the merge window.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

