Return-Path: <linux-fsdevel+bounces-2386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2417E54B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 12:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4021C209AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7025215AD2;
	Wed,  8 Nov 2023 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="unFem2cK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DH1VEwWv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D67615487;
	Wed,  8 Nov 2023 11:08:17 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0192186;
	Wed,  8 Nov 2023 03:08:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 451F521961;
	Wed,  8 Nov 2023 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699441695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZS+B8//QMaQSgI78OONfBo9LNrKqn5NiLMxYhvRm2s=;
	b=unFem2cKKkZuf1IvjAC/XJZZ+tUoC+8pTslehcDgU01ButNW7Ge5T1UaHGEUq2gua1izBT
	ybhS0WpczAGGBzsBL2lreIIKY841UoFEMxwHECrRVV4r2qw/GvYWLBe2fKaNnJZ3JL6GGA
	JDBGG0p3EdqKkGDeTr5DQi4Uj+M/ghw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699441695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZS+B8//QMaQSgI78OONfBo9LNrKqn5NiLMxYhvRm2s=;
	b=DH1VEwWvUStngQr9pNfijtD6GPFZBUI9FCKqBQmpBUbmweHzeI8BZ9BHomqnkWtDd//sQg
	+IDx9MmBoVhQnDCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37E77138F2;
	Wed,  8 Nov 2023 11:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jrubDR9sS2VgBAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 08 Nov 2023 11:08:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0250A07C0; Wed,  8 Nov 2023 12:08:14 +0100 (CET)
Date: Wed, 8 Nov 2023 12:08:14 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231108110814.noepnvrxdjmab6qj@quack3>
References: <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <ZUs+HuQWZvDDVC7a@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUs+HuQWZvDDVC7a@infradead.org>

On Tue 07-11-23 23:51:58, Christoph Hellwig wrote:
> On Mon, Nov 06, 2023 at 05:42:10PM -0500, Josef Bacik wrote:
> > Again, this is where I'm confused, because this doesn't change anything, we're
> > still going to report st_dev as being different, which is what you hate.
> 
> It's not something I hate.  It's that changing it without a mount point
> has broken things and will probably still break things.

So let me maybe return to what has started this thread. For fanotify we
return <fsid, fhandle> pair with events to identify object where something
happened. The fact that fsid is not uniform for all inodes of a superblock
on btrfs is what triggered this series because we are then faced with the
problem that caching fsid per superblock for "superblock marks" (to save
CPU overhead when generating events) can lead to somewhat confusing results
on btrfs. Whether we have vfsmount in the places where inodes' st_dev /
fsid change is irrelevant for this fanotify issue. As far as I'm following
the discussion it seems the non-uniform fsids per superblock are going to
stay with us on btrfs so fanotify code should better accommodate them? At
least by making sure the behavior is somewhat consistent and documented...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

