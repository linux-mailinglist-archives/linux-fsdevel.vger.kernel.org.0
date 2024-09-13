Return-Path: <linux-fsdevel+bounces-29351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0730597879E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 20:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C6228AAB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3AB12C473;
	Fri, 13 Sep 2024 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK85cXpO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997579B8E;
	Fri, 13 Sep 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251179; cv=none; b=vAq6A/4+2w+cEv4CaAU3ldg6dB8rxhyVLGSC4IXYkwNHX7Y/4fnIiiBa6nlemL3Yuas2J2iXtG/QDPdA5J3rp5sNwvNQ38beXiqfNXhrydozhXHVCSXhTTNHnBIa4oErY1K+nt5kKRrvjm0H54uGOpi/86Hu8/fXiBfvS+g1d4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251179; c=relaxed/simple;
	bh=8Ib5kHWilINa3vVdR/iVg8f97GUr5JvJtLBi8TI3bwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMNQ7ef3Y1HYJMdigBdm4TTL+EFPs50juI5w+ESu2rw+/qW7VqSqPui4Z2it/KSLcYnXZtwID9UtvGciQq1DCeX7fvwgCgZVuI/XUQPUk/xLH0t8ROJKpnkX4j6xwCGaB6oGrkygbOASUW0k8Mp4jo5RsdjzrpM6ToHMHEdJRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK85cXpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2068BC4CEC0;
	Fri, 13 Sep 2024 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726251179;
	bh=8Ib5kHWilINa3vVdR/iVg8f97GUr5JvJtLBi8TI3bwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JK85cXpOB0RyjWbYpMGnOcC4FWn0qmjYFt8juITpeYklzWOJlMwKs8V13G3EXk8FD
	 qMuAfTp8uVw7DpmywOkiAEb3Y3a69Frf/zVNxcpwEYDusr2NzaAW/l0yp0mDo9Meus
	 1eFApUwSKA2fawFJkb20iqqvKuzLmKIsQ1AsNQHIoymFOyYCpCcGhYUkZFf2ACQ+O9
	 ztsQi7S/UrBwRFngxXoRb65/g1B0MsKOG5hH7nWoCF0ZatmupzO6loUCKMCPYFdvw+
	 FVDZHQZFeVTF1tp9QoDaGyecyzEDs1AJJPR2KPZfH93QWd+dwvUQni9YjOfN6DZIZk
	 phEH223xLJuKg==
Date: Fri, 13 Sep 2024 14:12:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Message-ID: <ZuSAql2DFCA_Jny3@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
 <ZttnSndjMaU1oObp@kernel.org>
 <ZuB3l71L_Gu1Xsrn@kernel.org>
 <ZuCasKhlB4-eGyg0@kernel.org>
 <686b4118-0505-4ea5-a2bb-2b16acc33c51@oracle.com>
 <ZuDEJukUYv3yVSQM@kernel.org>
 <ZuHYtiL1PBr6fG3B@kernel.org>
 <ZuHl69qJk8Q9b1p4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuHl69qJk8Q9b1p4@kernel.org>

On Wed, Sep 11, 2024 at 02:48:11PM -0400, Mike Snitzer wrote:
> On Wed, Sep 11, 2024 at 01:51:50PM -0400, Mike Snitzer wrote:
> > 
> > Will keep after this with urgency, just wanted to let you know what I
> > have found so far...
> 
> Hi Anna,
> 
> Forgot to ask, but:
> 
> Hopefully you can make progress on other aspects of your LOCALIO
> review despite me working to find and fix this generic/525 issue?

Hi,

Trond was able to see the mm bug that caused LOCALIO to fail to find
the page in the pagecache (resulting in filemap_read hitting an
infinite loop), see:
https://marc.info/?l=linux-nfs&m=172625026100876&w=2

With that filemap fix generic/525 works with LOCALIO.

Hopefully that resolves any doubts you had about LOCALIO?  DO you
think it ready to be merged?

Thanks,
Mike

