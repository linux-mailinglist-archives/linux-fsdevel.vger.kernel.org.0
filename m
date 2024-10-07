Return-Path: <linux-fsdevel+bounces-31213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5429930F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5042B25CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4B11D90C8;
	Mon,  7 Oct 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvzEEdn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754551D8E10;
	Mon,  7 Oct 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314423; cv=none; b=TlLUbd+aVFH9W//HD5WDhDlL2MIu88AXgV17KzF/ITsKBCdz7tvqoDnrVjB0JdcZoKEVBFcMEhQcxNtO02O0Um27s6iTiX2KonPSTNyqs5Qhl/gQgmM21aTHr0AxkOgL7J6E7lpSrNTOdgE68fduYprFRPccYT6d69KJ+qR/x9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314423; c=relaxed/simple;
	bh=SvjE3piClURj75kdTmb7irJ2ZtDe2G5z2If2mq8IEO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfIAgA2B+BiIwrFuCVoEK6CDNPkVxocIkod855i+amDits4Ae/ZGrW4KvNR16s0cYuo22yY3mkNfjuAeNFPL9j6lvDya4UN35oGmj/cj0RxZSM2z0NjEFY0TPEBVqaD533CL3jQydbzjSbTCJIueiyr8sZZL7I1+fc+HUhOOhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvzEEdn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F107FC4CECF;
	Mon,  7 Oct 2024 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728314423;
	bh=SvjE3piClURj75kdTmb7irJ2ZtDe2G5z2If2mq8IEO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvzEEdn7EoIvbVmv9srg5tj++eZk8rl2WE8Zj+thg7DG1E1CVDORmLdZFz9/ovewD
	 y65Z4EjFP89zlU3rhZzUO7sVYC0ETgWt23CJ3Bq/7xd4/pDQYj3UQWFAYYUkQKpd3t
	 hegWBCiMVNKuj6xhnkijgv0zIty3Qf+6Q9fO9z9aV5cGeQPzzHkRcKMfWznqdBjmzL
	 qv1HvOclQWufgDRv8dQ3vmkA5CHBFUAFBAWPw32OHUmvDKW9bwSe2SmSSwS8y/96H6
	 XoKHu35XSDFaakVA7KDfFFe+7z97azIj8gtKRDqRFF/LbeOp8wI+cfPPsTbjRvtyz2
	 x9bmzwEPm42aA==
Date: Mon, 7 Oct 2024 08:20:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: fix stale delalloc punching for COW I/O v4
Message-ID: <20241007152022.GO21853@frogsfrogsfrogs>
References: <20240924074115.1797231-1-hch@lst.de>
 <20241005155312.GM21853@frogsfrogsfrogs>
 <20241007054101.GA32670@lst.de>
 <20241007062841.GP21877@frogsfrogsfrogs>
 <20241007064650.GA1205@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007064650.GA1205@lst.de>

On Mon, Oct 07, 2024 at 08:46:50AM +0200, Christoph Hellwig wrote:
> On Sun, Oct 06, 2024 at 11:28:41PM -0700, Darrick J. Wong wrote:
> > On Mon, Oct 07, 2024 at 07:41:01AM +0200, Christoph Hellwig wrote:
> > > On Sat, Oct 05, 2024 at 08:53:12AM -0700, Darrick J. Wong wrote:
> > > > Hmmm so I tried applying this series, but now I get this splat:
> > > > 
> > > > [  217.170122] run fstests xfs/574 at 2024-10-04 16:36:30
> > > 
> > > I don't.  What xfstests tree is this with?
> > 
> > Hum.  My latest djwong-wtf xfstests tree.  You might have to have the
> > new funshare patch I sent for fsstress, though iirc that's already in my
> > -wtf branch.
> 
> No recent fsstress.c changes in your tree, but then again the last
> update is from Oct 1st, so you might have just not pushed it out.

Ah, right, because the kernel code was obviously busted Friday night, so
I didn't bother pushing anything.  Will push everything this afternoon,
esp. now that bfoster rvb'd it...

--D

