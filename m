Return-Path: <linux-fsdevel+bounces-695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493377CE722
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 20:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9351B20E3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479A347370;
	Wed, 18 Oct 2023 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OOlMdN3Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mp+8zqpw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845847358
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 18:46:18 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5531C114;
	Wed, 18 Oct 2023 11:46:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34FB71F383;
	Wed, 18 Oct 2023 18:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697654774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Szwtnfcke0SpMIDxlSZbJqKrDwqMF6CyFTyCgfEvpI0=;
	b=OOlMdN3ZPUx6jMv77bJrzoUDAI9vDmlO2f+WzeY5DP+RtLaAp+dwz3tCZxFAxcFDVhOXaB
	qzth31EooNxs3Tudf9fP0UMYpjKcBzpUb6i0bOA5i6c3zEztz68qPLbR+S3ykkmQrSAIqS
	fBheBoi3Do5+HT29SYxXZGuZ4n2k/7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697654774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Szwtnfcke0SpMIDxlSZbJqKrDwqMF6CyFTyCgfEvpI0=;
	b=Mp+8zqpwTLu/y67W0FyQ3bwpvZ/Zyi9kZAHJpkKLKnxbvvtuyNTHCI0S7cuyw759R8XtSu
	3SDgr8uWgI3GleAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2749D13915;
	Wed, 18 Oct 2023 18:46:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id K1yPCfYnMGWZVwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 18 Oct 2023 18:46:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ACFC8A06B0; Wed, 18 Oct 2023 20:46:13 +0200 (CEST)
Date: Wed, 18 Oct 2023 20:46:13 +0200
From: Jan Kara <jack@suse.cz>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jan Kara <jack@suse.cz>, Ferry Toth <ftoth@exalondelft.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20231018184613.tphd3grenbxwgy2v@quack3>
References: <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
 <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
 <ZS50DI8nw9oSc4Or@smile.fi.intel.com>
 <20231017133245.lvadrhbgklppnffv@quack3>
 <ZS6PRdhHRehDC+02@smile.fi.intel.com>
 <ZS6fIkTVtIs-UhFI@smile.fi.intel.com>
 <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com>
 <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
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

On Tue 17-10-23 19:02:52, Andy Shevchenko wrote:
> On Tue, Oct 17, 2023 at 06:34:50PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 17, 2023 at 06:14:54PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 17, 2023 at 05:50:10PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 17, 2023 at 04:42:29PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Oct 17, 2023 at 03:32:45PM +0200, Jan Kara wrote:
> > > > > > On Tue 17-10-23 14:46:20, Andy Shevchenko wrote:
> > > > > > > On Tue, Oct 17, 2023 at 01:32:53PM +0300, Andy Shevchenko wrote:
> > > > > > > > On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > > > > > > > > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > > > > > > > > > >   Hello Linus,
> 
> ...
> 
> > > > > > > > > > This merge commit (?) broke boot on Intel Merrifield.
> > > > > > > > > > It has earlycon enabled and only what I got is watchdog
> > > > > > > > > > trigger without a bit of information printed out.
> > > > > > > 
> > > > > > > Okay, seems false positive as with different configuration it
> > > > > > > boots. It might be related to the size of the kernel itself.
> > > > > > 
> > > > > > Ah, ok, that makes some sense.
> > > > > 
> > > > > I should have mentioned that it boots with the configuration say "A",
> > > > > while not with "B", where "B" = "A" + "C" and definitely the kernel
> > > > > and initrd sizes in the "B" case are bigger.
> > > > 
> > > > If it's a size (which is only grew from 13M->14M), it's weird.
> > > > 
> > > > Nevertheless, I reverted these in my local tree
> > > > 
> > > > 85515a7f0ae7 (HEAD -> topic/mrfld) Revert "defconfig: enable DEBUG_SPINLOCK"
> > > > 786e04262621 Revert "defconfig: enable DEBUG_ATOMIC_SLEEP"
> > > > 76ad0a0c3f2d Revert "defconfig: enable DEBUG_INFO"
> > > > f8090166c1be Revert "defconfig: enable DEBUG_LIST && DEBUG_OBJECTS_RCU_HEAD"
> > > > 
> > > > and it boots again! So, after this merge something affects one of this?
> > > > 
> > > > I'll continuing debugging which one is a culprit, just want to share
> > > > the intermediate findings.
> > > 
> > > CONFIG_DEBUG_LIST with this merge commit somehow triggers this issue.
> > > Any ideas?
> 
> > Dropping CONFIG_QUOTA* helps as well.
> 
> More precisely it's enough to drop either from CONFIG_DEBUG_LIST and CONFIG_QUOTA
> to make it boot again.
> 
> And I'm done for today.

OK, thanks for debugging! So can you perhaps enable CONFIG_DEBUG_LIST
permanently in your kernel config and then bisect through the quota changes
in the merge? My guess is commit dabc8b20756 ("quota: fix dqput() to follow
the guarantees dquot_srcu should provide") might be the culprit given your
testing but I fail to see how given I don't expect any quotas to be used
during boot of your platform... BTW, there's also fixup: 869b6ea160
("quota: Fix slow quotaoff") merged last week so you could try testing a
kernel after this fix to see whether it changes anything.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

