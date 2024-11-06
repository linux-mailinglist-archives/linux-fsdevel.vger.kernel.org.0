Return-Path: <linux-fsdevel+bounces-33807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694D9BF307
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC8B252C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA668204F96;
	Wed,  6 Nov 2024 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUsq4+fr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFE190075;
	Wed,  6 Nov 2024 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909742; cv=none; b=NYeYpJK+ULEdePgXHvG8d9A4k3tGztEty6Q7DBQsP85n0LNVf4Lm5jE7NveBe689FI0eapr1gVpDYSQlWSv/1qs3L9/slUnLm9AFM33VHHhZfCcY0doYQlQ26W3YsSitlMSfsIuDiol2dmL7L957rxtumCFOr65gQbVtYodekJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909742; c=relaxed/simple;
	bh=17VRjsdzd47xFESl41GTeJh5UTraVVQjFsJBtlc+9wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cC1ubDOLK0kMdYQKPzWdpirLmHNjTytwunudJ1NUs0E8XTeOF4dqBKD8iXZkJJiy45T6RyNcPOuEBT93pYk2iue0zw/Q58bLcgIFe2YqASJVXbI82u4XVpyysgSgy0/Q2wR5oeKwf7kKIMQrs5yilgfdwgfncFRhOnF7Mjc/CyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUsq4+fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC42C4CEC6;
	Wed,  6 Nov 2024 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730909741;
	bh=17VRjsdzd47xFESl41GTeJh5UTraVVQjFsJBtlc+9wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUsq4+frJsYBp5OQPhW3XeBK/ACbbWa61SPYtNMrj6pDxNeU24RtUdcaIZmOKQveg
	 71LZVH3udyt6foSZ1GiqbQfVDMseCJH+xQfEDj0iICj+2/RyLBqip65ew1J3GczXC4
	 OnMmqMnYGPjMRpuezgGvTX7/TdMNv+A8xpFnyzWpTjkpxm3aZf9TsvVEMkqOneKXi6
	 fSERs2h3WglAVV0X1RloDRRza8jHydoTN4ZJ1zt1MvaYbECTBL2WXcEvX/+KHDXXV8
	 XxPt6i3wqj3sFsfQMbwziXgFCaG7VLXX/5udDbSunw7grWY6OuZsfvgEhrNQonGwAD
	 q/BXzZ04dcxhg==
Date: Wed, 6 Nov 2024 08:15:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE v2] work tree for untorn filesystem writes
Message-ID: <20241106161541.GN2386201@frogsfrogsfrogs>
References: <20241106005740.GM2386201@frogsfrogsfrogs>
 <20241106-zerkleinern-verzweifeln-7ec8173c56ad@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-zerkleinern-verzweifeln-7ec8173c56ad@brauner>

On Wed, Nov 06, 2024 at 10:50:21AM +0100, Christian Brauner wrote:
> On Tue, Nov 05, 2024 at 04:57:40PM -0800, Darrick J. Wong wrote:
> > Hi everyone,
> > 
> > Here's a slightly updated working branch for the filesystem side of
> > atomic write changes for 6.13:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fs-atomic_2024-11-05
> > 
> > This branch is, like yesterday's, based off of axboe's
> > for-6.13/block-atomic branch:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block-atomic
> > 
> > The only difference is that I added Ojaswin's Tested-by: tags to the end
> > of the xfs series.  I have done basic testing with the shell script at
> > the end of this email and am satisfied that it at least seems to do the
> > (limited) things that I think we're targeting for 6.13.
> > 
> > Christian: Could you pull this fs-atomic branch into your vfs.git work
> > for 6.13, please?
> 
> Of course!
> 
> I did git pull fs-atomic_2024-11-05 from your tree. It should show up in
> -next tomorrow.

Yay, thank you!!

--D

