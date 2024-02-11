Return-Path: <linux-fsdevel+bounces-11061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142E4850839
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 09:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BA928278E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC559153;
	Sun, 11 Feb 2024 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b9OO97ll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F4CA7A;
	Sun, 11 Feb 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707641387; cv=none; b=L600MAGXOTQ+okDG3oFCZ6yiUbE9m3B8PNACqB7ZatwbBQfFN05VwRHM7iA46q/jAEcunlm2LopKN4eunrpKTIS7P50EclRrMJ4NxJeWxS6lXnm/4x6I43NMreS4K06QMAfjxMQnYlAT4Cqwh05HKJ2Pv/uKbQnfvB8CwPAL9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707641387; c=relaxed/simple;
	bh=lSj2qY4HiMS3eGrEt2eQjGBTR7Ml2UU11vfPYYcwVjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX5+lqyIGwVFheQTe8HzcF7LIkR8PflCfJucJaXFpBSsGgdW8je4vXt5Gjn1DCJFURHQ7e74FBwxMhhRqqJpA1w8QmRKQ7IzZ7RTNSpTdNP17+VpRhMZ3sUb+n5DSx9WkGJHL5AIjQpKjGoXAFOwGO4MrIgKH2kmYezCgf6QzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b9OO97ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7074CC433F1;
	Sun, 11 Feb 2024 08:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707641386;
	bh=lSj2qY4HiMS3eGrEt2eQjGBTR7Ml2UU11vfPYYcwVjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9OO97llZFUovYlha9NUjmRcncomElHxPvZI3iaunAe19dSwauzUyeYEKRFLgw7IX
	 YVgdPW7z8AVKwRoHQDmCJMm+/SDW/SRCiJMFySyL1YDfwRlnKVe/vmZ79/A1awEneY
	 nyvHr+K+RgdHmrnKIPz+VkuP9S+YXIviYfVS7Syo=
Date: Sun, 11 Feb 2024 08:49:44 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Subject: Re: [PATCH v3] fs, USB gadget: Remove libaio I/O cancellation support
Message-ID: <2024021158-drippy-fifteen-8af1@gregkh>
References: <20240209193026.2289430-1-bvanassche@acm.org>
 <2024021022-ahoy-vintage-b210@gregkh>
 <e955c7c5-019a-41c6-99f7-f8e3dbee652d@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e955c7c5-019a-41c6-99f7-f8e3dbee652d@acm.org>

On Sat, Feb 10, 2024 at 08:55:44AM -0800, Bart Van Assche wrote:
> On 2/10/24 02:20, Greg Kroah-Hartman wrote:
> > On Fri, Feb 09, 2024 at 11:30:26AM -0800, Bart Van Assche wrote:
> > > Fixes: 63b05203af57 ("[PATCH] AIO: retry infrastructure fixes and enhancements")
> > 
> > I can't see this git id in Linus's tree, are you sure it is correct?
> 
> Thanks Greg for having looked this up. I had not yet realized this but that
> git commit ID comes from a historic tree. Is there a standard way for referring
> to patches from historic trees? See also

Which historical git tree?  We have lots as you point out:

> https://stackoverflow.com/questions/3264283/linux-kernel-historical-git-repository-with-full-history

That's fine, and I can handle it for really old ones, I should populate
my local "find the fixes tag" logic to include the historical trees as
well, but it rarely comes up like this :)

thanks, I'll queue this in a day or so when I get back to the USB patch
review.

greg k-h

