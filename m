Return-Path: <linux-fsdevel+bounces-73137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE04D0D940
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219193028D9F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2C328688E;
	Sat, 10 Jan 2026 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BmoWniL9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B3242D66;
	Sat, 10 Jan 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768063713; cv=none; b=SMgWew7s2aj9wC4qHIoACScIZoxffztK15SKtr2NG8VYkU6pPlmxHpTYpeXZ4EzbYbBFl1E9NsV4EsQ7ZTmPsilMEszef6aa8SCeX3zqGHsipf14xEnuXu9h+DyTWhQqRSChofl+y50PX+XlTewJKTrBcYSmr5JG5CBwbLtYMuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768063713; c=relaxed/simple;
	bh=DES6w+8SgkZS+wFo57yyWPocHXe6z1zY1v5oQFszkiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF5CQDtJ7ClMarysISgCkUM1F3TBe2YzP3T1eSlYaMhLz9x84UuZMZDWJTg93Q34mp/gwRzRo4Jjh6Qg6RKipR8TTU9AbGx6asHX33XhV6bIQRAPWeIrpmlx4+tPAVb5mpaCPP9ye+GGKk0oyOHYTT8Y4AVh5TzunjBLifVcn0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BmoWniL9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AKpx1EV3P4S0DvDfPZtelEzcuiIJdWK3fdreb5BhWCY=; b=BmoWniL9/lXyvP88jkhqk2mHFT
	ouYnh4tatZfmYZl/ZXUlQnPd5+ARA6FtTOs8zhbcQy9E2rzYbncfDDprvG4RRu5LunBhw8f6xOx3n
	5bkmz7SrTyDhC48eCQ8O/llLJNfv8h4mMyllSbJP8LpQoEnqL06/QCgcK5st1aOOde8Cj7pdrAeyT
	0Xi8po7KlHc7WOZ4I0ql8Je0zRbcbv2VB9MJ0Y4hdwNByxC6hjgZh7metLE/Ym9Tk4K995aq1YL7f
	mIT3AhmU/R1q5hyKjkRWa2UQ9AcnzjX/RCZNxWSCel3g2ARQ79DErG0GB1bicoe3o/nT6t86Faw7w
	IA+mqK8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vec9q-0000000E1cf-3mZZ;
	Sat, 10 Jan 2026 16:49:47 +0000
Date: Sat, 10 Jan 2026 16:49:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 4/6] fs: invoke group_pin_kill() during mount teardown
Message-ID: <20260110164946.GD3634291@ZenIV>
References: <20260108004016.3907158-1-cel@kernel.org>
 <20260108004016.3907158-5-cel@kernel.org>
 <176794792304.16766.452897252089076592@noble.neil.brown.name>
 <50610e1c-7f09-4840-b2b2-f211dd6cdd5f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50610e1c-7f09-4840-b2b2-f211dd6cdd5f@app.fastmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 09, 2026 at 11:04:49AM -0500, Chuck Lever wrote:

> Jeff mentioned to me privately that the fs_pin API may be deprecated,
> with its sole current consumer (BSD process accounting) destined for
> removal. I'm waiting for VFS maintainer review for confirmation on
> that before deciding how to address your comment. If fs_pin is indeed
> going away, building new NFSD infrastructure on top of it would be
> unwise, and we'll have to consider a shift in direction.

FWIW, fs_pin had never been a good API and experiments with using it
for core stuff had failed - we ended up with dput_to_list() and teaching
shrink lists to DTRT with mixed-fs lists instead.

TBH, I'd rather not see it growing more users.  Said that, more serious
problem is that you are mixing per-mount and per-fs things here.

Could you go over the objects you need to deal with?  What needs to be
hidden from the normal "mount busy" logics and revoked when a mount goes
away?

Opened files are obvious, but what about e.g. write count?

