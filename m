Return-Path: <linux-fsdevel+bounces-1011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D3E7D4D32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 12:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0D0B20F8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F62250F0;
	Tue, 24 Oct 2023 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fTe5JwqZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lu8wohMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551224A05
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 10:03:22 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1AADC;
	Tue, 24 Oct 2023 03:03:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BDC61FD71;
	Tue, 24 Oct 2023 10:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698141799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fd1uUtLWVCbrf8y0Y5fzHoEuPomC3eJzUI1A7frlr0k=;
	b=fTe5JwqZApsvVOwBvi/bUvWfqL8S/Y3kpoaBcpJHKymvKS6ByF5Y0kEb/MJ4Z3AmMw+N+U
	81AKCJBzLg5vth28OzYeD3CxRLIsHXbeexfVbgTfabGx4/5pSof0w2b8RNrRjCIV9F6Myn
	JU59VeDBqKpjQKjZt5+OIIqLOV18BPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698141799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fd1uUtLWVCbrf8y0Y5fzHoEuPomC3eJzUI1A7frlr0k=;
	b=lu8wohMTf9sRWi3q/EUd7SnoZluEEDtz4L6+yEoGOwFq5AFryjFZUATjzMpPOBvANypAj6
	ueeB8HNfQKUTJ/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D601134F5;
	Tue, 24 Oct 2023 10:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bgINC2eWN2UrGQAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 24 Oct 2023 10:03:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AD60DA05BC; Tue, 24 Oct 2023 12:03:18 +0200 (CEST)
Date: Tue, 24 Oct 2023 12:03:18 +0200
From: Jan Kara <jack@suse.cz>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hui Zhu <teawater@antgroup.com>, Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] ext4: add __GFP_NOWARN to GFP_NOWAIT in readahead
Message-ID: <20231024100318.muhq5omspyegli4c@quack3>
References: <7bc6ad16-9a4d-dd90-202e-47d6cbb5a136@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc6ad16-9a4d-dd90-202e-47d6cbb5a136@google.com>
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
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Mon 23-10-23 23:26:08, Hugh Dickins wrote:
> Since mm-hotfixes-stable commit e509ad4d77e6 ("ext4: use bdev_getblk() to
> avoid memory reclaim in readahead path") rightly replaced GFP_NOFAIL
> allocations by GFP_NOWAIT allocations, I've occasionally been seeing
> "page allocation failure: order:0" warnings under load: all with
> ext4_sb_breadahead_unmovable() in the stack.  I don't think those
> warnings are of any interest: suppress them with __GFP_NOWARN.
> 
> Fixes: e509ad4d77e6 ("ext4: use bdev_getblk() to avoid memory reclaim in readahead path")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Yeah, makes sense. Just the commit you mention isn't upstream yet so I'm
not sure whether the commit hash is stable. I guess something for Andrew to
figure out. In any case feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c00ec159dea5..56a08fc5c5d5 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -262,7 +262,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
>  void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
>  {
>  	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
> -			sb->s_blocksize, GFP_NOWAIT);
> +			sb->s_blocksize, GFP_NOWAIT | __GFP_NOWARN);
>  
>  	if (likely(bh)) {
>  		if (trylock_buffer(bh))
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

