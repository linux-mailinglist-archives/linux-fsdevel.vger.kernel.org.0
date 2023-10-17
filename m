Return-Path: <linux-fsdevel+bounces-525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E37D7CC4C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 15:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA67B21112
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF54369D;
	Tue, 17 Oct 2023 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TbxOmERG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybKLAyjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53CEBE
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 13:32:48 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8B1F0;
	Tue, 17 Oct 2023 06:32:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6CBB1FF1E;
	Tue, 17 Oct 2023 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697549565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijb00tUJ4s5fP8GQwrRkosW09Y3SgoETKGREUEk2HRA=;
	b=TbxOmERGZ6ZFv/6Hcu/9Zr07zSFNcP/KnT2OeRpPyIoQ7YNEQDvq0rB0xExD9JS4vAP+XJ
	1U0Zkho6uzjaWCpKOfQ68GB/I/i2qFNZeFC0AmHBiCzxjos1L/rK6G14uaPJbrTbKeojUp
	hgzdVc1/J99FihiI0KIPncYFudNFgjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697549565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijb00tUJ4s5fP8GQwrRkosW09Y3SgoETKGREUEk2HRA=;
	b=ybKLAyjfnJCwGTPZZczowLgJW3aKhx4cz3KpzO3Ty6sJ/cdW7PJRx/Av8IKQcgEAV++mBi
	YmwMtQqmENwC9ECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B97E013584;
	Tue, 17 Oct 2023 13:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8Xg8Lf2MLmWedwAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 17 Oct 2023 13:32:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4FD23A06E5; Tue, 17 Oct 2023 15:32:45 +0200 (CEST)
Date: Tue, 17 Oct 2023 15:32:45 +0200
From: Jan Kara <jack@suse.cz>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jan Kara <jack@suse.cz>, Ferry Toth <ftoth@exalondelft.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20231017133245.lvadrhbgklppnffv@quack3>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
 <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
 <ZS50DI8nw9oSc4Or@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS50DI8nw9oSc4Or@smile.fi.intel.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.20
X-Spamd-Result: default: False [-4.20 / 50.00];
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
	 BAYES_HAM(-0.60)[81.78%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue 17-10-23 14:46:20, Andy Shevchenko wrote:
> On Tue, Oct 17, 2023 at 01:32:53PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > > > >   Hello Linus,
> 
> ...
> 
> > > > This merge commit (?) broke boot on Intel Merrifield.
> > > > It has earlycon enabled and only what I got is watchdog
> > > > trigger without a bit of information printed out.
> 
> Okay, seems false positive as with different configuration it
> boots. It might be related to the size of the kernel itself.

Ah, ok, that makes some sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

