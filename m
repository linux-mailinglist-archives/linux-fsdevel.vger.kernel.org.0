Return-Path: <linux-fsdevel+bounces-521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E27CC1E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 13:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2ADEB20DDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FF341AB7;
	Tue, 17 Oct 2023 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPibPydm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ELz0Q+qr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA741AA4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 11:36:33 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B4EA;
	Tue, 17 Oct 2023 04:36:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 152D121D11;
	Tue, 17 Oct 2023 11:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697542589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kSifgwnbuocfW6uAjc8FRLfFf+5XnT9Mpk52E2PBRl4=;
	b=DPibPydmLWXFZcOZ6uMNLa0kzGhY3NzIwq3Rt1e2uB0rRGQjbWioer5i70jfEbA8CxXFpG
	8/aV8betP4xI0pDiL4Wxb6Zdx4tiSetjoBXH0v1AjE2YZQ9o2UY9zKMFYNWasHK5yVQvuh
	WbVI2bqB69ltMwNd4ANfi//mQ8zsyzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697542589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kSifgwnbuocfW6uAjc8FRLfFf+5XnT9Mpk52E2PBRl4=;
	b=ELz0Q+qrtPt5ZUTRSkanjIpdXykU/1RTb62LKagmkWAQM8IVlzsde+hKCDsgvNarYl8/I1
	pJp0YE5/li1Tx0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07EB713584;
	Tue, 17 Oct 2023 11:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Sq3sAb1xLmVmNgAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 17 Oct 2023 11:36:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 94D72A06E5; Tue, 17 Oct 2023 13:36:28 +0200 (CEST)
Date: Tue, 17 Oct 2023 13:36:28 +0200
From: Jan Kara <jack@suse.cz>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jan Kara <jack@suse.cz>, Ferry Toth <ftoth@exalondelft.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20231017113628.coyq2wngiz5dnybs@quack3>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
 <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
Authentication-Results: smtp-out1.suse.de;
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
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello!

On Tue 17-10-23 13:32:53, Andy Shevchenko wrote:
> On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > > >   Hello Linus,
> > > > 
> > > >   could you please pull from
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.6-rc1
> > > > 
> > > > to get:
> > > > * fixes for possible use-after-free issues with quota when racing with
> > > >   chown
> > > > * fixes for ext2 crashing when xattr allocation races with another
> > > >   block allocation to the same file from page writeback code
> > > > * fix for block number overflow in ext2
> > > > * marking of reiserfs as obsolete in MAINTAINERS
> > > > * assorted minor cleanups
> > > > 
> > > > Top of the tree is df1ae36a4a0e. The full shortlog is:
> > > 
> > > This merge commit (?) broke boot on Intel Merrifield.
> > > It has earlycon enabled and only what I got is watchdog
> > > trigger without a bit of information printed out.
> > > 
> > > I tried to give a two bisects with the same result.
> > > 
> > > Try 1:
> 
> + Missed start of this
> 
> git bisect start
> # status: waiting for both good and bad commits
> # good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
> git bisect good 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> # status: waiting for bad commit, 1 good commit known
> # bad: [0bb80ecc33a8fb5a682236443c1e740d5c917d1d] Linux 6.6-rc1
> git bisect bad 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> # bad: [461f35f014466c4e26dca6be0f431f57297df3f2] Merge tag 'drm-next-2023-08-30' of git://anongit.freedesktop.org/drm/drm
> 
> > > git bisect bad 461f35f014466c4e26dca6be0f431f57297df3f2                                                          # good: [bd6c11bc43c496cddfc6cf603b5d45365606dbd5] Merge tag 'net-next-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> > > git bisect good bd6c11bc43c496cddfc6cf603b5d45365606dbd5
> > > # good: [ef35c7ba60410926d0501e45aad299656a83826c] Revert "Revert "drm/amdgpu/display: change pipe policy for DCN 2.0""
> > > git bisect good ef35c7ba60410926d0501e45aad299656a83826c
> > > # good: [d68b4b6f307d155475cce541f2aee938032ed22e] Merge tag 'mm-nonmm-stable-2023-08-28-22-48' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > git bisect good d68b4b6f307d155475cce541f2aee938032ed22e
> > > # good: [87fa732dc5ff9ea6a2e75b630f7931899e845eb1] Merge tag 'x86-core-2023-08-30-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > > git bisect good 87fa732dc5ff9ea6a2e75b630f7931899e845eb1
> > > # good: [bc609f4867f6a14db0efda55a7adef4dca16762e] Merge tag 'drm-misc-next-fixes-2023-08-24' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> > > git bisect good bc609f4867f6a14db0efda55a7adef4dca16762e
> > > # good: [63580f669d7ff5aa5a1fa2e3994114770a491722] Merge tag 'ovl-update-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs
> > > git bisect good 63580f669d7ff5aa5a1fa2e3994114770a491722
> > > # good: [5221002c054376fcf2f0cea1d13f00291a90222e] Merge tag 'repair-force-rebuild-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
> > > git bisect good 5221002c054376fcf2f0cea1d13f00291a90222e
> > > # bad: [1500e7e0726e963f64b9785a0cb0a820b2587bad] Merge tag 'for_v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
> > > git bisect bad 1500e7e0726e963f64b9785a0cb0a820b2587bad
> > > # good: [7a64774add85ce673a089810fae193b02003be24] quota: use lockdep_assert_held_write in dquot_load_quota_sb
> > > git bisect good 7a64774add85ce673a089810fae193b02003be24
> > > # good: [b450159d0903b06ebea121a010ab9c424b67c408] ext2: introduce new flags argument for ext2_new_blocks()
> > > git bisect good b450159d0903b06ebea121a010ab9c424b67c408
> > > # good: [9bc6fc3304d89f19c028cb4a8d6af94f9e5faeb0] ext2: dump current reservation window info
> > > git bisect good 9bc6fc3304d89f19c028cb4a8d6af94f9e5faeb0
> > > # good: [df1ae36a4a0e92340daea12e88d43eeb2eb013b1] ext2: Fix kernel-doc warnings
> > > git bisect good df1ae36a4a0e92340daea12e88d43eeb2eb013b1
> > > # first bad commit: [1500e7e0726e963f64b9785a0cb0a820b2587bad] Merge tag 'for_v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs

That's strange because I don't see anything suspicious in the merge and
furthermore I'd expent none of the changes in the merge to influence early
boot in any way. Can you share your kernel config? What root filesystem do
you use? Thanks for the report!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

