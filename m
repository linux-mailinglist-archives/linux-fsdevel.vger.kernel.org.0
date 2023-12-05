Return-Path: <linux-fsdevel+bounces-4882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3633680576F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 15:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C821C20FA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F9965EDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:36:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8DD90;
	Tue,  5 Dec 2023 06:23:47 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 67F8421EB2;
	Tue,  5 Dec 2023 14:23:45 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 16044139E2;
	Tue,  5 Dec 2023 14:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VAu/AnEyb2XjBQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 14:23:45 +0000
Date: Tue, 5 Dec 2023 15:16:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/46] btrfs: add fscrypt support
Message-ID: <20231205141655.GC2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701468305.git.josef@toxicpanda.com>
 <20231205014917.GB1168@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205014917.GB1168@sol.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: 3.19
X-Spamd-Result: default: False [3.19 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(0.00)[suse.cz];
	 R_SPF_SOFTFAIL(0.00)[~all];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[23.80%]
X-Spamd-Bar: +++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Queue-Id: 67F8421EB2

On Mon, Dec 04, 2023 at 05:49:17PM -0800, Eric Biggers wrote:
> On Fri, Dec 01, 2023 at 05:10:57PM -0500, Josef Bacik wrote:
> > Hello,
> > 
> > v3 can be found here
> > 
> > https://lore.kernel.org/linux-btrfs/cover.1697480198.git.josef@toxicpanda.com/
> > 
> > There's been a longer delay between versions than I'd like, this was mostly due
> > to Plumbers, Holidays, and then uncovering a bunch of new issues with '-o
> > test_dummy_encryption'.  I'm still working through some of the btrfs specific
> > failures, but the fscrypt side appears to be stable.  I had to add a few changes
> > to fscrypt since the last time, but nothing earth shattering, just moving the
> > keyring destruction and adding a helper we need for btrfs send to work properly.
> > 
> > This is passing a good chunk of the fstests, at this point the majority appear
> > to be cases where I need to exclude the test when using test_dummy_encryption
> > because of various limitations of our tools or other infrastructure related
> > things.
> > 
> > I likely will have a follow-up series with more fixes, but the bulk of this is
> > unchanged since the last posting.  There were some bug fixes and such but the
> > overall design remains the same.  Thanks,
> > 
> 
> Well, it wouldn't be Linux kernel development without patchsets that don't
> mention what they apply to...  I managed to apply this for reviewing after
> spending a while choosing the base that seemed to work best (6d3880a76eedd from
> kdave/for-next) and resolving conflicts.  It would save a lot of time if proper
> information was included, though.

Right, the base branch should have been mentioned, we have the development
git tree on github and not on kernel.org.

For future reference:
https://btrfs.readthedocs.io/en/latest/Source-repositories.html#kernel-module

