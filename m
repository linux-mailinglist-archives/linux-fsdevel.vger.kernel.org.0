Return-Path: <linux-fsdevel+bounces-3357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E737F4171
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4DF281806
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9240E3D987;
	Wed, 22 Nov 2023 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oQB5dNGl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FcH5BjGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30912D6F;
	Wed, 22 Nov 2023 01:18:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7B6B21904;
	Wed, 22 Nov 2023 09:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700644697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CiaCWu6M5Ny8VB31ACB+zfudr+a6ts/Ir0FirRERD6s=;
	b=oQB5dNGl/NkLVwyZokXfuuaD/tgRPRiiaL8WSMMAwnLdHazGLSJ6R6Jo6ZHXH5/tooE2aC
	rtxaSV0TjTerMyx7gRau551qxiRS9S7D0Q8jbGvU6atsszntxfj+XC8CZOyJZj4fziB+CD
	FZGovDpG/BNgSTCn+Uihwf/RB8TAgqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700644697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CiaCWu6M5Ny8VB31ACB+zfudr+a6ts/Ir0FirRERD6s=;
	b=FcH5BjGI/v+e0pmCZmoXTGabmVIYFgWep7pGGd43P5kMz2S3X3pbj931xNWFKL+F8Y8zYD
	EKeLyCLThTNW5vDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9029B139FD;
	Wed, 22 Nov 2023 09:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4ewwI1nHXWXEcAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 22 Nov 2023 09:18:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 15349A07DC; Wed, 22 Nov 2023 10:18:17 +0100 (CET)
Date: Wed, 22 Nov 2023 10:18:17 +0100
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] ext2: Fix ki_pos update for DIO buffered-io fallback
 case
Message-ID: <20231122091817.ktp5kojucsnhs3dd@quack3>
References: <d595bee9f2475ed0e8a2e7fb94f7afc2c6ffc36a.1700643443.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d595bee9f2475ed0e8a2e7fb94f7afc2c6ffc36a.1700643443.git.ritesh.list@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.28
X-Spamd-Result: default: False [-2.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-2.98)[99.91%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Wed 22-11-23 14:32:15, Ritesh Harjani (IBM) wrote:
> Commit "filemap: update ki_pos in generic_perform_write", made updating
> of ki_pos into common code in generic_perform_write() function.
> This also causes generic/091 to fail.
> This happened due to an in-flight collision with:
> fb5de4358e1a ("ext2: Move direct-io to use iomap"). I have chosen fixes tag
> based on which commit got landed later to upstream kernel.
> 
> Fixes: 182c25e9c157 ("filemap: update ki_pos in generic_perform_write")
> Cc: stable@vger.kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks! I've applied the patch to my tree and will push it to Linus soon.

								Honza

> ---
>  fs/ext2/file.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
> index 1039e5bf90af..4ddc36f4dbd4 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -258,7 +258,6 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			goto out_unlock;
>  		}
>  
> -		iocb->ki_pos += status;
>  		ret += status;
>  		endbyte = pos + status - 1;
>  		ret2 = filemap_write_and_wait_range(inode->i_mapping, pos,
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

