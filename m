Return-Path: <linux-fsdevel+bounces-998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03D7D4AB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD5E8B20F9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE7311CA7;
	Tue, 24 Oct 2023 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku5YiUOF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7F7460
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 08:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A001CC433C7;
	Tue, 24 Oct 2023 08:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698136970;
	bh=wdFg7BDULzzQgV0rGouUCBrcuLmVJYcDbk5XiVvMcn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ku5YiUOFbp1huOU3zcLUCvUZ0O3BLPcm6UbxTCjmcSGOeABss7+VMowvK2oCpr7nY
	 IwOp/UWxJAIF/UBKGFsuHHvvpogZXVvvMCqSH+wjdj7ZvKqhWwuWc6tOBnJVdg9zIb
	 nmvsfKdEQzMI1WRsqs+nDgeOQxOPwF+m8dCTHsM6WgQl2n+2rp3G9n21G5WvD0KFhm
	 4NsyqKJLk+awwk+uEfRRSRDKavsoaOQ2Gm9Am8WIOiSt0DJfNB233ipDzrffHW9uz7
	 HH4iemCz90VW4wiHb+8swygqJQhuEzpqYRWWZw8hlYornDiaC3c6byxSaqseo/YCD9
	 hl/BeWhQF5g6Q==
Date: Tue, 24 Oct 2023 10:42:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: LOOP_CONFIGURE uevents
Message-ID: <20231024-wurzel-rankt-d9cebb866412@brauner>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
 <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
 <20231020120436.jgxdlawibpfuprnz@quack3>
 <20231023-biberbau-spatzen-282ccea0825a@brauner>
 <ZTds8va6evIjnpJG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTds8va6evIjnpJG@infradead.org>

On Tue, Oct 24, 2023 at 12:06:26AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 23, 2023 at 04:08:21PM +0200, Christian Brauner wrote:
> > No you get uevents if you trigger a partition rescan but only if there
> > are actually partitions. What you never get however is a media change
> > event even though we do increment the disk sequence number and attach an
> > image to the loop device.
> > 
> > This seems problematic because we leave userspace unable to listen for
> > attaching images to a loop device. Shouldn't we regenerate the media
> > change event after we're done setting up the device and before the
> > partition rescan for LOOP_CONFIGURE?
> 
> Maybe.  I think people mostly didn't care about the even anyway, but
> about the changing sequence number to check that the content hasn't
> changed.

Yes, exactly. The core is the changed sequence number but you don't get
that notification if you don't have any partitions and you request a
partition rescan from LOOP_CONFIGURE.

So I think we should always send the media change event for the sequence
number independent of the partition notification.

