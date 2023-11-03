Return-Path: <linux-fsdevel+bounces-1930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99847E05B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 16:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C76BB21435
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB8E1C681;
	Fri,  3 Nov 2023 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XayPe3iY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z5QKONR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73A1C2B6
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 15:44:00 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C745A6
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:43:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D054211E1;
	Fri,  3 Nov 2023 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699026234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOjJApoqT36xkZp3qnAG/EIxiXFU5GM09L0QB4D4LDY=;
	b=XayPe3iYWrWZqcaI1JBuvsEaFTRaXiwThZYnU1ZeSg4ShbITXZm+xEAFcWnuYWxW7lB33Y
	5eSXup6IOEegVfxv4elMnYTuZ0gAhWMpJlv2KQNHpd55ixz9PMJcLja95CYanyK8I3PNho
	HWG65pxh9Az3glnpuN+Z4gO+t2TENKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699026234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOjJApoqT36xkZp3qnAG/EIxiXFU5GM09L0QB4D4LDY=;
	b=Z5QKONR/73hft76v+C3PvJlXH1jJv4MsKLXTm5a7+gzrObOVjY62XyhNDFaaiouTcK6B7g
	QXBv0W8wD4P5E8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CD761348C;
	Fri,  3 Nov 2023 15:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uOqGGjoVRWV5NQAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 03 Nov 2023 15:43:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D0677A06E3; Fri,  3 Nov 2023 16:43:52 +0100 (CET)
Date: Fri, 3 Nov 2023 16:43:52 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH] fs: handle freezing from multiple devices
Message-ID: <20231103154352.2iz6rqhsjkvcxpyk@quack3>
References: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231103-vfs-multi-device-freeze-v1-1-fe922b30bfb6@kernel.org>
 <20231103141940.GA3732@lst.de>
 <20231103-leiht-funkverkehr-48ed8d425fd9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103-leiht-funkverkehr-48ed8d425fd9@brauner>

On Fri 03-11-23 16:10:10, Christian Brauner wrote:
> On Fri, Nov 03, 2023 at 03:19:40PM +0100, Christoph Hellwig wrote:
> > On Fri, Nov 03, 2023 at 02:52:27PM +0100, Christian Brauner wrote:
> > > Fix this by counting the number of block devices that requested the
> > > filesystem to be frozen in @bdev_count in struct sb_writers and only
> > > unfreeze once the @bdev_count hits zero. Survives fstests and blktests
> > > and makes the reproducer succeed.
> > 
> > Is there a good reason to not just refcount the freezes in general?
> 
> If we start counting freezes in general we break userspace as
> freeze_super() is called from ioctl_fsfreeze() and that expects to
> return EBUSY on an already frozen filesystem. xfs scrub might be another
> user that might break if we change that.

I guess Christoph meant that we'd count all the sb freezes into the
refcount (what is now bdev_count) but without HOLDER_BDEV flag we will
return EBUSY if the refcount is > 0 instead of incrementing it.

There would be a subtle behavioral difference that now if you freeze the fs
with ioctl_fsfreeze() and then try to freeze through the blockdev, you'll
get EBUSY while with the new method the bdev freeze will succeed but I
don't think that can do any harm. It even kind of makes more sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

