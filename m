Return-Path: <linux-fsdevel+bounces-2849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFF67EB5B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 18:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B3EB20C00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F812C1B1;
	Tue, 14 Nov 2023 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tg31Wdgt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UbW/t2F7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BC21357;
	Tue, 14 Nov 2023 17:42:51 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767EC103;
	Tue, 14 Nov 2023 09:42:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1340322809;
	Tue, 14 Nov 2023 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699983767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLj0SNN9N0z0x4jwOcZjhuYq4UamtjJxXFZYB+ijxhw=;
	b=Tg31WdgtB4h8kVBcXZP5rs56jcRpMwY1gq9KIDkhijJq+Mxfhi9dvJZs93cMkTHfCA/+Yz
	Q9oOeW4cuC0JrakGnj2PzMTYlEf/2zHea0xCZaruXNYO6nKegGjChUgTjbFehQnsC1pa5z
	ZdAOfE27c2mnkb3/uDqsG083EqmQVpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699983767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLj0SNN9N0z0x4jwOcZjhuYq4UamtjJxXFZYB+ijxhw=;
	b=UbW/t2F77YvmgnpyqUcTW9185jZI/5VrQsuXPnUB8IUdEMh1D6HfHaw/M7g9MckmbEPVbp
	zZbvY+PYv597ybBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEC4F13460;
	Tue, 14 Nov 2023 17:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Fvq5MZaxU2WeFwAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 14 Nov 2023 17:42:46 +0000
Date: Tue, 14 Nov 2023 18:35:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: Re: [PATCH v2 02/18] btrfs: split out the mount option validation
 code into its own helper
Message-ID: <20231114173541.GD11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1699470345.git.josef@toxicpanda.com>
 <f30ace3052a298c6536453fed66577c308c72d2f.1699470345.git.josef@toxicpanda.com>
 <f6180d3c-0bbc-47e5-b098-6f1210c23be6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6180d3c-0bbc-47e5-b098-6f1210c23be6@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.78
X-Spamd-Result: default: False [-5.78 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.98)[94.92%]

On Tue, Nov 14, 2023 at 02:32:16PM +0800, Anand Jain wrote:
> 
> > +static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
> > +{
> > +	if (!(flags & SB_RDONLY) &&
> > +	    (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
> > +	     check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
> > +	     check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
> > +		return false;
> > +
> > +	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
> > +	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
> > +	    !btrfs_test_opt(info, CLEAR_CACHE)) {
> > +		btrfs_err(info, "cannot disable free space tree");
> > +		return false;
> > +	}
> > +	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
> > +	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
> > +		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
> > +		return false;
> > +	}
> > +
> > +	if (btrfs_check_mountopts_zoned(info))
> > +		return false;
> > +
> 
> 
> <snip>
> 
> > -check:
> > -	/* We're read-only, don't have to check. */
> > -	if (new_flags & SB_RDONLY)
> > -		goto out;
> > -
> > -	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
> > -	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
> > -	    check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums"))
> > -		ret = -EINVAL;
> >   out:
> > -	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
> > -	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
> > -	    !btrfs_test_opt(info, CLEAR_CACHE)) {
> > -		btrfs_err(info, "cannot disable free space tree");
> > +	if (!ret && !check_options(info, new_flags))
> >   		ret = -EINVAL;
> > -	}
> > -	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
> > -	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
> > -		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
> > -		ret = -EINVAL;
> > -	}
> > -	if (!ret)
> > -		ret = btrfs_check_mountopts_zoned(info);
> > -	if (!ret && !remounting) {
> > -		if (btrfs_test_opt(info, SPACE_CACHE))
> > -			btrfs_info(info, "disk space caching is enabled");
> > -		if (btrfs_test_opt(info, FREE_SPACE_TREE))
> > -			btrfs_info(info, "using free space tree");
> > -	}
> >   	return ret;
> >   }
> 
> 
> Before this patch, we verified all the above checks simultaneously.
> Now, for each error, we return without checking the rest.
> As a result, if there are multiple failures in the above checks,
> we report them sequentially. This is not a bug, but the optimization
> we had earlier has been traded off for cleaner code.
> IMO it is good to keep the optimization.

I would not say it's cleaner code, it's doing something else than
before. I think we should keep the behaviour 1:1 unless there's a reason
for that, the changelog does not say.

