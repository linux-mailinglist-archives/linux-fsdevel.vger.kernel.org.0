Return-Path: <linux-fsdevel+bounces-53072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FABAAE9AF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 12:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E802E1C40911
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE51F220698;
	Thu, 26 Jun 2025 10:14:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F9AEEDE;
	Thu, 26 Jun 2025 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932890; cv=none; b=MxforgA1jCAPyOVBHYUAoBQBvgIvZEoonCIAMH8UAOvGRJSV/ywt8eptAU6md6UZRYw51S2UchSHBye/mrk/Izc3EBoIsjrG2sKGsvn1SH7NCwz0RiuxQlBkSYcro0d6ZPBHpMKOwrnPO85vDzridEE+KDvF3mFK4lcfKaPz/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932890; c=relaxed/simple;
	bh=haxYeKa9mvmEI+kHfgf0GHb42SyAK0h7pWQ1TMO8PmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4pEva5q1ipa9M+YqSo7r/aEdex7IdwmpQQAevd+DWas1/aw3TekTeZn45oFca4OSq7J06OTfO0zHLR3MQNRQOfvAl/6Bdiq+j2We+I8FBls0V+JPrMJswVf/5te1ziho25nUj8u9KaOqHqfFf8njFZ3HRlJDwClJRfzx+OYmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 19449227AAF; Thu, 26 Jun 2025 12:14:44 +0200 (CEST)
Date: Thu, 26 Jun 2025 12:14:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH 1/6] fs: add a new remove_bdev() super operations
 callback
Message-ID: <20250626101443.GA6180@lst.de>
References: <cover.1750895337.git.wqu@suse.com> <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com> <20250626-schildern-flutlicht-36fa57d43570@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626-schildern-flutlicht-36fa57d43570@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 26, 2025 at 10:38:11AM +0200, Christian Brauner wrote:
> > +	if (sb->s_op->remove_bdev)
> > +		sb->s_op->remove_bdev(sb, bdev, surprise);
> > +	else if (sb->s_op->shutdown)
> >  		sb->s_op->shutdown(sb);
> 
> This makes ->remove_bdev() and ->shutdown() mutually exclusive. I really
> really dislike this pattern. It introduces the possibility that a
> filesystem accidently implement both variants and assumes both are
> somehow called. That can be solved by an assert at superblock initation
> time but it's still nasty.
> 
> The other thing is that this just reeks of being the wrong api. We
> should absolutely aim for the methods to not be mutually exclusive. I
> hate that with a passion. That's just an ugly api and I want to have as
> little of that as possible in our code.

Yes.  As I mentioned before I think we just want to transition everyone
to the remove_bdev API.  But our life is probably easier if Qu's series
only adds the new one so that we can do the transitions through the
file system trees instead of needing a global API change.  Or am I
overthinking this?

> > +	 * @surprse:	indicates a surprise removal. If true the device/media is

surprse is misspelled here.  But I don't see how passing this on to
the file system would be useful, because at this point everything is
a surprise for the file system.


