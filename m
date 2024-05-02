Return-Path: <linux-fsdevel+bounces-18474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598838B9498
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DB71C21254
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 06:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0A21360;
	Thu,  2 May 2024 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STkoQ4SS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E8520B3E;
	Thu,  2 May 2024 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714630653; cv=none; b=QfEpw2+3A/MZC5RwO6w4FzI5r6wZfTRnj59kmu3gAAFN2pbGB6J947WErHXZkN+MvnR0y2nu0GDV5SG2cDPahuFII4t1gYrRmCEqpjEj4PmJs8TlpwojMZ7bGa5uS4q/S+EHsxzqgiGC+Fy84NG+EZUzBi11G5zkJ7u2cNU4YwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714630653; c=relaxed/simple;
	bh=dNiHsZOb4/kfx5j7r4xoP78uszvVxAFQ/0MbW2PtUAw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=FdFYBDpiSGoAO7/Uw9lcTpJCtolB9pA7PfSaGChKR0BVVwLqe5mYruNwFwg8+jzBXkkZvN1nl/wPwN3t+q39UQ2k5m2UQB8ukTTGdTsPj5r5yy1KNn7zZKTBBN8y5KeWi/W6MpPHpbaUxyS7mwLnFYbow02kKXi6nqjG1/Vy/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STkoQ4SS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1598C116B1;
	Thu,  2 May 2024 06:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714630653;
	bh=dNiHsZOb4/kfx5j7r4xoP78uszvVxAFQ/0MbW2PtUAw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=STkoQ4SSgXH9395cMMfFQJ5SgyCz3ScVB8aAoIOCuujQSU3l+nN5gfqlU6E2ve7aZ
	 1fGGVmOtZo1f+ZEp8eDVv+Yg7acmCAaspIFTo4N1PTE8hyPJ79aGCfDdRRMlDy8osu
	 py/NIIbn2U9vYz5Q93D46Z7laTzkvm5mrERh/UT7xzyk7lZFHWD09Z1EUukicEJ7CA
	 2t2v7+EHFL81ki1zQ3nJ59nwGp46Mhlir58Io0FAcYtbbJ4RXPTUf3o8Wdz5o7a4Pq
	 dhzXUslByXj4JQqegh0bjBEmezyXswCRBzmfqgOlhorlyKNsyYuy016hntBSmCSNeS
	 8SFqCDm4e/Czw==
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680378.957659.14973171617153243991.stgit@frogsfrogsfrogs>
 <ZjHnXmcsIeTh9lHI@infradead.org> <20240501223927.GI360919@frogsfrogsfrogs>
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
 ebiggers@kernel.org, linux-xfs@vger.kernel.org, alexl@redhat.com,
 walters@verbum.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/26] xfs: use unsigned ints for non-negative
 quantities in xfs_attr_remote.c
Date: Thu, 02 May 2024 11:26:08 +0530
In-reply-to: <20240501223927.GI360919@frogsfrogsfrogs>
Message-ID: <87r0ekbuva.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 01, 2024 at 03:39:27 PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 30, 2024 at 11:55:26PM -0700, Christoph Hellwig wrote:
>> On Mon, Apr 29, 2024 at 08:24:22PM -0700, Darrick J. Wong wrote:
>> > From: Darrick J. Wong <djwong@kernel.org>
>> > 
>> > In the next few patches we're going to refactor the attr remote code so
>> > that we can support headerless remote xattr values for storing merkle
>> > tree blocks.  For now, let's change the code to use unsigned int to
>> > describe quantities of bytes and blocks that cannot be negative.
>> > 
>> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>> > Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
>> 
>> Looks good:
>> 
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Thanks!
>
>> Can we please get this included ASAP instead of having it linger around?
>
> Chandan, how many more patches are you willing to take for 6.10?  I
> think Christoph has a bunch of fully-reviewed cleanups lurking on the
> list, and then there's this one.

I have pushed a set of new patches to for-next a few hours ago.

Also, I have queued the following patchsets for internal testing,
1. fix h_size validation v2
2. quota (un)reservation cleanups
3. Removal of duplicate includes
   i.e. https://lore.kernel.org/linux-xfs/20240430034728.86811-1-jiapeng.chong@linux.alibaba.com/ 

The remaining patchsets from Christoph i.e.
1. optimize COW end I/O remapping v2
2. optimize local for and shortform directory handling
2. iext handling fixes and cleanup
... are either missing RVBs or need to address review comments.

Darrick, I will update for-next sometime tomorrow evening my time. Can you
please send me a pull request containing fs-verity patchset based on
tomorrow's updated for-next branch by end of Friday? This will be last
patchset I will be applying for 6.10 merge window since I would like to test
linux-next during next week.

-- 
Chandan

