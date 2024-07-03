Return-Path: <linux-fsdevel+bounces-23029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE44926232
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 15:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113CE281526
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433F173336;
	Wed,  3 Jul 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki8CaN3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E1F1DFEF
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014639; cv=none; b=bHqhN+dbWHH8mkaQlskA5/UtvQONA313M671gYAffSvTcWg+waJ4zHVhblmwwWhfA+qjR9rsP5pboxH0i2IJ/ifryb3200YInMNGvFeLhqVPaTb70dE6qNin8BjCc4YJIoppcmndHjCM9Ycr/r7NHtJvNIfh38eo/GHl4IKMhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014639; c=relaxed/simple;
	bh=drHs/nF/cpfs0vkfB+9236oVCz9EpOqih3PQWp50tig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9VlqW+34SmRiTOES70UOs9IDPpTLo46ZU5UdLI/tU0f/0sCpdU/scQJZ0QnnX681gsW+8bnjHyyx1dAOctWGU3eZ9j+siBHrrDJtxqFf5/KHs/7Jo9hh2pe+Yo+/lb69qy1Y2pInfmF8/TvpHY+KO5bKeT63m2F3XfWmLpUQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki8CaN3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358A1C4AF0F;
	Wed,  3 Jul 2024 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014639;
	bh=drHs/nF/cpfs0vkfB+9236oVCz9EpOqih3PQWp50tig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ki8CaN3U3Ean2QCN12J490EQSLdMVRlh1iEwDB5NIlJFHE1U8pbEtkdKgb8RctIuA
	 bHfdPkRRzpKws9aORlt0O+dO4XiYQaAjBuxvbkBeMXHecooZIjO1O0kyUj4NIbrHH/
	 E6VbCCv3JZS0HasA5hJQJo+maItlCp74REWI/c2wQ2kCQeKqRF9J6CA+AdAKkHby9P
	 nBf7wVcGFUkG64rmG9sBqPddRrLfo8doUPK2iuvrbCfdMavXSx0rwbOMOMSd+o8KEY
	 KnzRfRMJSBDKKAz1n9igVvoBRpHA8QZprfl1H6oVy742hLlGZSu5GbENkM0MIxTRy7
	 VYq+Jw1i5SNcw==
Date: Wed, 3 Jul 2024 15:50:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Ian Kent <ikent@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] vfs: don't mod negative dentry count when on shrinker
 list
Message-ID: <20240703-happig-neueinstellung-ce90e76e3012@brauner>
References: <20240703121301.247680-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703121301.247680-1-bfoster@redhat.com>

> Hi Christian,
> 
> I see you already picked up v1. Josef had asked for some comment updates
> so I'm posting v2 with that, but TBH I'm not sure how useful this all is
> once one groks the flags. I have no strong opinion on it. I also added a
> Fixes: tag for the patch that added the counter.
> 
> In short, feel free to grab this one, ignore this and stick with v1, or
> maybe just pull in the Fixes: tag if you agree with it. Thanks.

Meh, I'll just take your v2. If Josef thinks the comments are useful and
you don't mind adding them it seems like the an easy thing to do. Thanks
for resending!

