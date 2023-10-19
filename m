Return-Path: <linux-fsdevel+bounces-733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AA97CF4F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5761C20918
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E11E182B9;
	Thu, 19 Oct 2023 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q10RL5Xw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3JFPDpgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F56182A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:18:58 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B989119;
	Thu, 19 Oct 2023 03:18:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DB3D1F38C;
	Thu, 19 Oct 2023 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697710734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7Koy1TTy6fVeKfRcpreu2u0+v8upl8pxgAqsONksHA=;
	b=q10RL5Xw7WNwontk98d89evO5H6R/Qz50evEUZ2nl38hurvbdVMNlrcJrwPAbyE0v1o4WT
	RT92ilDFsgdAWzGhQwUvJ0lXQjUHxhKvNEAQjpdmgp70PjaQCtGPbzoaVblbBKlKoT7p16
	rIzxp6TRvKeukxkXe1xXvvXNBbTslJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697710734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7Koy1TTy6fVeKfRcpreu2u0+v8upl8pxgAqsONksHA=;
	b=3JFPDpgJ2swMgPSfIVOzM9MoNujWLEFuWKBEz0BKa2ZFVpU9XLcAYL9FwjBlsr5JdJwifw
	6Hd2Mudx2Tqbm2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 813F61357F;
	Thu, 19 Oct 2023 10:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8k2IH44CMWWvdQAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 10:18:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E968A06B0; Thu, 19 Oct 2023 12:18:54 +0200 (CEST)
Date: Thu, 19 Oct 2023 12:18:54 +0200
From: Jan Kara <jack@suse.cz>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jan Kara <jack@suse.cz>, Ferry Toth <ftoth@exalondelft.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20231019101854.yb5gurasxgbdtui5@quack3>
References: <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
 <ZS50DI8nw9oSc4Or@smile.fi.intel.com>
 <20231017133245.lvadrhbgklppnffv@quack3>
 <ZS6PRdhHRehDC+02@smile.fi.intel.com>
 <ZS6fIkTVtIs-UhFI@smile.fi.intel.com>
 <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com>
 <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3>
 <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
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
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Thu 19-10-23 11:46:58, Andy Shevchenko wrote:
> On Wed, Oct 18, 2023 at 08:46:13PM +0200, Jan Kara wrote:
> > On Tue 17-10-23 19:02:52, Andy Shevchenko wrote:
> > > On Tue, Oct 17, 2023 at 06:34:50PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 17, 2023 at 06:14:54PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Oct 17, 2023 at 05:50:10PM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Oct 17, 2023 at 04:42:29PM +0300, Andy Shevchenko wrote:
> > > > > > > On Tue, Oct 17, 2023 at 03:32:45PM +0200, Jan Kara wrote:
> > > > > > > > On Tue 17-10-23 14:46:20, Andy Shevchenko wrote:
> > > > > > > > > On Tue, Oct 17, 2023 at 01:32:53PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > > > > > > > > > > > >   Hello Linus,
> 
> ...
> 
> > > > > > > > > > > > This merge commit (?) broke boot on Intel Merrifield.
> > > > > > > > > > > > It has earlycon enabled and only what I got is watchdog
> > > > > > > > > > > > trigger without a bit of information printed out.
> > > > > > > > > 
> > > > > > > > > Okay, seems false positive as with different configuration it
> > > > > > > > > boots. It might be related to the size of the kernel itself.
> > > > > > > > 
> > > > > > > > Ah, ok, that makes some sense.
> > > > > > > 
> > > > > > > I should have mentioned that it boots with the configuration say "A",
> > > > > > > while not with "B", where "B" = "A" + "C" and definitely the kernel
> > > > > > > and initrd sizes in the "B" case are bigger.
> > > > > > 
> > > > > > If it's a size (which is only grew from 13M->14M), it's weird.
> > > > > > 
> > > > > > Nevertheless, I reverted these in my local tree
> > > > > > 
> > > > > > 85515a7f0ae7 (HEAD -> topic/mrfld) Revert "defconfig: enable DEBUG_SPINLOCK"
> > > > > > 786e04262621 Revert "defconfig: enable DEBUG_ATOMIC_SLEEP"
> > > > > > 76ad0a0c3f2d Revert "defconfig: enable DEBUG_INFO"
> > > > > > f8090166c1be Revert "defconfig: enable DEBUG_LIST && DEBUG_OBJECTS_RCU_HEAD"
> > > > > > 
> > > > > > and it boots again! So, after this merge something affects one of this?
> > > > > > 
> > > > > > I'll continuing debugging which one is a culprit, just want to share
> > > > > > the intermediate findings.
> > > > > 
> > > > > CONFIG_DEBUG_LIST with this merge commit somehow triggers this issue.
> > > > > Any ideas?
> > > 
> > > > Dropping CONFIG_QUOTA* helps as well.
> > > 
> > > More precisely it's enough to drop either from CONFIG_DEBUG_LIST and CONFIG_QUOTA
> > > to make it boot again.
> > > 
> > > And I'm done for today.
> > 
> > OK, thanks for debugging! So can you perhaps enable CONFIG_DEBUG_LIST
> > permanently in your kernel config and then bisect through the quota changes
> > in the merge? My guess is commit dabc8b20756 ("quota: fix dqput() to follow
> > the guarantees dquot_srcu should provide") might be the culprit given your
> > testing but I fail to see how given I don't expect any quotas to be used
> > during boot of your platform... BTW, there's also fixup: 869b6ea160
> > ("quota: Fix slow quotaoff") merged last week so you could try testing a
> > kernel after this fix to see whether it changes anything.
> 
> It's exactly what my initial report is about, CONFIG_DEBUG_LIST was there
> always with CONFIG_QUOTA as well.

Ah, ok.

> Two bisections (v6.5 .. v6.6-rc1 & something...v6.6-rc6) pointed out to
> merge commit!

I thought CONFIG_DEBUG_LIST arrived through one path, some problematic
quota change arrived through another path and because they cause problems
only together, then bisecting to the merge would be exactly the outcome.
Alas that doesn't seem to be the case :-|.

> I _had_ tried to simply revert the quota changes (I haven't
> said about that before) and it didn't help. I'm so puzzled with all this.

Aha, OK. If even reverting quota changes doesn't help, then it's really
weird...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

