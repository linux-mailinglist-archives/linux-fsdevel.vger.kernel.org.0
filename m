Return-Path: <linux-fsdevel+bounces-2042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F57E1B09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 08:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA0AB20E48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BA3C8CF;
	Mon,  6 Nov 2023 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CFC139
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 07:21:41 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2A2CC
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 23:21:40 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B63F68AA6; Mon,  6 Nov 2023 08:21:37 +0100 (CET)
Date: Mon, 6 Nov 2023 08:21:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH] fs: handle freezing from multiple devices
Message-ID: <20231106072137.GA17374@lst.de>
References: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64> <20231103-vfs-multi-device-freeze-v1-1-fe922b30bfb6@kernel.org> <20231103141940.GA3732@lst.de> <20231103-leiht-funkverkehr-48ed8d425fd9@brauner> <20231103154352.2iz6rqhsjkvcxpyk@quack3> <20231103-herzform-fabelhaft-3a46cbe7de83@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103-herzform-fabelhaft-3a46cbe7de83@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 03, 2023 at 05:49:17PM +0100, Christian Brauner wrote:
> > > > Is there a good reason to not just refcount the freezes in general?
> > > 
> > > If we start counting freezes in general we break userspace as
> > > freeze_super() is called from ioctl_fsfreeze() and that expects to
> > > return EBUSY on an already frozen filesystem. xfs scrub might be another
> > > user that might break if we change that.
> > 
> > I guess Christoph meant that we'd count all the sb freezes into the
> > refcount (what is now bdev_count) but without HOLDER_BDEV flag we will
> 
> Ah, sorry I didn't get that from the message.

That's also not what I meant :)  Jan's suggestion makes a little
more sense than mine, which I think would have been a good idea
when we started from scratch, but does indeed feel dangerous now.

