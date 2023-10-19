Return-Path: <linux-fsdevel+bounces-734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92A07CF5F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C083281FE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0D18030;
	Thu, 19 Oct 2023 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cFGQGNOK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QFKjlzYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1E15EBC
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:57:20 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC721FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 03:57:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66CE81F38C;
	Thu, 19 Oct 2023 10:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697713038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCrE5aq8viQmsCNp4xG2x8Q2n3r/Ggt2qRxgHhtIcfw=;
	b=cFGQGNOK9xupudsN7mpvuw4mrDFDwL6AkUxZ45trD9BgtkH7BHyOl3MMRnPiMKYRSQdvfH
	vlvj/QWevU7FkszC3SBt4KF30vIohAmCoRK88+ZJQ16zHnqcS9G0RbRhldSr5iH+QubRMY
	bvaNCqAltUjF+YqL8Mz/Ue6NMIysxis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697713038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCrE5aq8viQmsCNp4xG2x8Q2n3r/Ggt2qRxgHhtIcfw=;
	b=QFKjlzYj8Rov0Vhqlnfh1S0TTn/9RjA995BBywBvAr15hlZfYmjbXxd0xhd39akL6fa8tC
	QPS88yh5GKXNkuBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59CC91357F;
	Thu, 19 Oct 2023 10:57:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /GffFY4LMWUOCwAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 10:57:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E4E40A06B0; Thu, 19 Oct 2023 12:57:17 +0200 (CEST)
Date: Thu, 19 Oct 2023 12:57:17 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Avoid grabbing sb->s_umount under
 bdev->bd_holder_lock
Message-ID: <20231019105717.s35ahlgflx2rk3nj@quack3>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-galopp-zeltdach-b14b7727f269@brauner>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.00
X-Spamd-Result: default: False [-5.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.40)[90.90%]

On Thu 19-10-23 10:33:36, Christian Brauner wrote:
> On Wed, Oct 18, 2023 at 05:29:24PM +0200, Jan Kara wrote:
> > The implementation of bdev holder operations such as fs_bdev_mark_dead()
> > and fs_bdev_sync() grab sb->s_umount semaphore under
> > bdev->bd_holder_lock. This is problematic because it leads to
> > disk->open_mutex -> sb->s_umount lock ordering which is counterintuitive
> > (usually we grab higher level (e.g. filesystem) locks first and lower
> > level (e.g. block layer) locks later) and indeed makes lockdep complain
> > about possible locking cycles whenever we open a block device while
> > holding sb->s_umount semaphore. Implement a function
> 
> This patches together with my series that Christoph sent out for me
> Link: https://lore.kernel.org/r/20231017184823.1383356-1-hch@lst.de
> two days ago (tyvm!) the lockdep false positives are all gone and we
> also eliminated the counterintuitive ordering requirement that forces us
> to give up s_umount before opening block devices.
> 
> I've verified that yesterday and did a bunch of testing via sudden
> device removal.
> 
> Christoph had thankfully added generic/730 and generic/731 to emulate
> some device removal. I also messed around with the loop code and
> specifically used LOOP_CHANGE_FD to force a disk_force_media_change() on
> a filesystem.

Ah, glad to hear that! So now we can also slowly work on undoing the unlock
s_umount, open bdev, lock s_umount games we have introduced in several
places. But I guess let's wait a bit for the dust to settle :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

