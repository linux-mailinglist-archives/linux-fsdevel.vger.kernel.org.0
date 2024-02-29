Return-Path: <linux-fsdevel+bounces-13229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075FE86D7BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 00:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362021C215A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 23:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8D74BF9;
	Thu, 29 Feb 2024 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omQPBdGJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA7433B6;
	Thu, 29 Feb 2024 23:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249245; cv=none; b=oV69NKlAO88w90DpXm8LzgMpQYvcRwJqj2lXR20pYhwRIuh8/3UqRWaouwfQS1+/gjgSV0T1/z2if5GZ0UQq9d4f2Nj6C1CK+6zw9MpfzSOjeZkjo2eUkJ/H3Anv3nbJoZAPnWHuxYkKv8OQncGJjqmm7hwn8QutIPGFjZk/lD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249245; c=relaxed/simple;
	bh=b8Qm3rCBoWy8fkyvnmrpn8jhJfFl0SiOkCNBpykNakk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSu1CzXsYWzvP7OX1zJDHhvMPvAKkQY/xqzs8YQx8PNtIuIpST/dIQ8zcYJ90MJaM5e+tCnOgJC+CnlafuVwLOT9Q+QuagsZ9X6DgsJG9ggSDFsxosw85len+B+PIZc/mTjIG/j4RHtx+lgOZVMW+XqyFJVMsbRPwqB5udMMmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omQPBdGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB270C43390;
	Thu, 29 Feb 2024 23:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709249244;
	bh=b8Qm3rCBoWy8fkyvnmrpn8jhJfFl0SiOkCNBpykNakk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=omQPBdGJoV9eTZfIOIoQmoFXuyiogIdWcLJcD/bhJRZNEs194Zu886gYpEVZW3RqS
	 kxZ3tfrBVAoE8oROw2pACEn1U6dVJTwl9nbUB0Q7Q9FTYBGKDtu1kFMisfdcEUeFMB
	 5n4x2fa+x1nrFCuucuMh/pyjp91MFyaId5q4+i69viB+BPucFGwru/5cpDd5grNFuq
	 nPmrc1v1I4avQoF07s4lj0lxhj+yXETGmRqF/r1/Jq9wFT0/Xm06k296sBiWhI+kR+
	 OuspmPVJAMyRS+v4vog4c9p4X2q+m4ES+eRb8eGIsyMHwDMYfNDxCkLzV7WNVClOgn
	 ZJrLm5lHm1zSg==
Date: Thu, 29 Feb 2024 15:27:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
	jlayton@kernel.org
Subject: Re: [PATCH 14/13] xfs: make XFS_IOC_COMMIT_RANGE freshness data
 opaque
Message-ID: <20240229232724.GD1927156@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <20240227174649.GL6184@frogsfrogsfrogs>
 <CAOQ4uxiPfno-Hx+fH3LEN_4D6HQgyMAySRNCU=O2R_-ksrxSDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiPfno-Hx+fH3LEN_4D6HQgyMAySRNCU=O2R_-ksrxSDQ@mail.gmail.com>

On Tue, Feb 27, 2024 at 08:52:58PM +0200, Amir Goldstein wrote:
> On Tue, Feb 27, 2024 at 7:46 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > To head off bikeshedding about the fields in xfs_commit_range, let's
> > make it an opaque u64 array and require the userspace program to call
> > a third ioctl to sample the freshness data for us.  If we ever converge
> > on a definition for i_version then we can use that; for now we'll just
> > use mtime/ctime like the old swapext ioctl.
> 
> This addresses my concerns about using mtime/ctime.

Oh good! :)

> I have to say, Darrick, that I think that referring to this concern as
> bikeshedding is not being honest.
> 
> I do hate nit picking reviews and I do hate "maybe also fix the world"
> review comments, but I think the question about using mtime/ctime in
> this new API was not out of place

I agree, your question about mtime/ctime:

"Maybe a stupid question, but under which circumstances would mtime
change and ctime not change? Why are both needed?"

was a very good question.  But perhaps that statement referred to the
other part of that thread.

>                                   and I think that making the freshness
> data opaque is better for everyone in the long run and hopefully, this will
> help you move to the things you care about faster.

I wish you'd suggested an opaque blob that the fs can lay out however it
wants instead of suggesting specifically the change cookie.  I'm very
much ok with an opaque freshness blob that allows future flexibility in
how we define the blob's contents.

I was however very upset about the Jeff's suggestion of using i_version.
I apologize for using all caps in that reply, and snarling about it in
the commit message here.  The final version of this patch will not have
that.

That said, I don't think it is at all helpful to suggest using a file
attribute whose behavior is as yet unresolved.  Multigrain timestamps
were a clever idea, regrettably reverted.  As far as I could tell when I
wrote my reply, neither had NFS implemented a better behavior and
quietly merged it; nor have Jeff and Dave produced any sort of candidate
patchset to fix all the resulting issues in XFS.

Reading "I realize that STATX_CHANGE_COOKIE is currently kernel
internal" made me think "OH $deity, they wants me to do that work
too???"

A better way to have woreded that might've been "How about switching
this to a fs-determined structure so that we can switch the freshness
check to i_version when that's fully working on XFS?"

The problem I have with reading patch review emails is that I can't
easily tell whether an author's suggestion is being made in a casual
offhand manner?  Or if it reflects something they feel strongly needs
change before merging.

In fairness to you, Amir, I don't know how much you've kept on top of
that i_version vs. XFS discussion.  So I have no idea if you were aware
of the status of that work.

--D

> Thanks,
> Amir.
> 

