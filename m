Return-Path: <linux-fsdevel+bounces-2982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21507EE832
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EDD2810ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A846530;
	Thu, 16 Nov 2023 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aEIWJp9g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KQLkOjdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA93F1A7;
	Thu, 16 Nov 2023 12:17:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB8042050A;
	Thu, 16 Nov 2023 20:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700165821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p68fCcxQIS+Z2kIB9kk+gfIMOuRKaJTdSJTEFA3jvzs=;
	b=aEIWJp9g36J1OtigwfhepU+GDYxMThoja07yXh6aLHiHe1RGtkXTJktFUdaPxoegls28J5
	7mETEL3kgJID42kDUbl939Qgd9oFij1B8HlTTmBd463lebK6X4gkdYRiEUhmek1zmz2eJR
	AFPePQLkg0DyuUFFbG0A9dcz9dLNmJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700165821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p68fCcxQIS+Z2kIB9kk+gfIMOuRKaJTdSJTEFA3jvzs=;
	b=KQLkOjdEpATQdOLHHeu4IntgKVUpk4kUZGD6EoTB7DGiZ2eNLjOqAErw9Uov5gDho8LqGj
	wkf99XRFEFPSIzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE2A1139C4;
	Thu, 16 Nov 2023 20:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CJm/Kb14VmXFbgAAMHmgww
	(envelope-from <dsterba@suse.cz>); Thu, 16 Nov 2023 20:17:01 +0000
Date: Thu, 16 Nov 2023 21:09:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: Re: [PATCH v2 05/18] btrfs: do not allow free space tree rebuild on
 extent tree v2
Message-ID: <20231116200955.GK11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1699470345.git.josef@toxicpanda.com>
 <6a2c827b0ed8b24c3be1045ccac49b29e850118e.1699470345.git.josef@toxicpanda.com>
 <6bbfbf34-aa74-4501-b36d-317022f3bc1b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bbfbf34-aa74-4501-b36d-317022f3bc1b@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Nov 15, 2023 at 05:49:48PM +0800, Anand Jain wrote:
> On 11/9/23 03:08, Josef Bacik wrote:
> > We currently don't allow these options to be set if we're extent tree v2
> > via the mount option parsing.  However when we switch to the new mount
> > API we'll no longer have the super block loaded, so won't be able to
> > make this distinction at mount option parsing time.  Address this by
> > checking for extent tree v2 at the point where we make the decision to
> > rebuild the free space tree.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   fs/btrfs/disk-io.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index b486cbec492b..072c45811c41 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2951,7 +2951,8 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
> >   	bool rebuild_free_space_tree = false;
> >   
> >   	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
> > -	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
> > +	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
> > +	    !btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> >   		rebuild_free_space_tree = true;
> >   	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
> >   		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
> 
> If there is v3 you can consider to add a comment similar to that
> is in btrfs_parse_options().
> Also, IMO, it is a good idea to include a btrfs_info() statement
> to indicate that the clear_cache option is ignored.

Agreed, we have a lot of verbosity around the mount options, if some
option combination is invalid or not working as expected a message
should pe printed.

