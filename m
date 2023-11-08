Return-Path: <linux-fsdevel+bounces-2379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD67E5316
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 11:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F89DB20E49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8A10A26;
	Wed,  8 Nov 2023 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Iz6USKq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nf4FVuiC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF21095F;
	Wed,  8 Nov 2023 10:10:17 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F451723;
	Wed,  8 Nov 2023 02:10:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98BEE21954;
	Wed,  8 Nov 2023 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699438215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PA9sqEeboC7whR130nl0EbzEaZqeDorxcklkHqfQ4h8=;
	b=2Iz6USKqni61NRdIuziCAfulicKzRRghwXKI8I100BXv9/5Jl/pTJt7mxfw3T+I8ZRpxOF
	NVB63t+GdphtxpHmsoii3fxVJm1VRewiHmf2XlAsUFtCoeHTnwi2uovVWUPt4Z8mjosPJs
	2jS6ERtZ/W8U4N+vzp8peIseujORy+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699438215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PA9sqEeboC7whR130nl0EbzEaZqeDorxcklkHqfQ4h8=;
	b=nf4FVuiC8Q6sfSZPI+vB0VwAPk9NSLgBR8yWLl6yzhEc4uc+K0WvrGzCWWnifHvrySE7GI
	+vitVfmVpnstuEAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89A01133F5;
	Wed,  8 Nov 2023 10:10:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fROPIYdeS2UDZgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 08 Nov 2023 10:10:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2435FA07C0; Wed,  8 Nov 2023 11:10:15 +0100 (CET)
Date: Wed, 8 Nov 2023 11:10:15 +0100
From: Jan Kara <jack@suse.cz>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Jan Kara <jack@suse.cz>, Eric Biggers <ebiggers@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
	Ted Tso <tytso@mit.edu>, syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20231108101015.hj3w6a7sq5x7x2s4@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
 <20230822053523.GA8949@sol.localdomain>
 <20230822101154.7udsf4tdwtns2prj@quack3>
 <CANp29Y6uBuSzLXuCMGzVNZjT+xFqV4dtWKWb7GR7Opx__Diuzg@mail.gmail.com>
 <20231024111015.k4sbjpw5fa46k6il@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024111015.k4sbjpw5fa46k6il@quack3>

Hi!

On Tue 24-10-23 13:10:15, Jan Kara wrote:
> On Thu 19-10-23 11:16:55, Aleksandr Nogikh wrote:
> > Thank you for the series!
> > 
> > Have you already had a chance to push an updated version of it?
> > I tried to search LKML, but didn't find anything.
> > 
> > Or did you decide to put it off until later?
> 
> So there is preliminary series sitting in VFS tree that changes how block
> devices are open. There are some conflicts with btrfs tree and bcachefs
> merge that complicate all this (plus there was quite some churn in VFS
> itself due to changing rules how block devices are open) so I didn't push
> out the series that actually forbids opening of mounted block devices
> because that would cause a "merge from hell" issues. I plan to push out the
> remaining patches once the merge window closes and all the dependencies are
> hopefully in a stable state. Maybe I can push out the series earlier based
> on linux-next so that people can have a look at the current state.

So patches are now in VFS tree [1] so they should be in linux-next as well.
You should be able to start using the config option for syzbot runs :)

								Honza

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.super
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

