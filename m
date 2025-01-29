Return-Path: <linux-fsdevel+bounces-40298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E1A21FA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9377A2434
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B98199B8;
	Wed, 29 Jan 2025 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tqdczi71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F4DDCD;
	Wed, 29 Jan 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162299; cv=none; b=MLrLaxPXd00NPuPXT56IFXVxnP6ntaZFo6GAgQTaoHfOFNKiFyyCi8djbVCAcLvBcDifBzieYt4NYtLfx+zJRstlMwORuhGvxJk+h8ChnEimWgzK6OZdhVFwNiIR1agNWdGl4627jlNI7G3S2MSNssUS0c+CRTQejveAAsu9O84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162299; c=relaxed/simple;
	bh=bGm0rMnYiWwLGtC/T9s/6XWn/vt2mwYcmN7sKKwiNkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzRWZGjCGb33FW9afxmdmGJIyBvJZ4qQ9+jKV7WxI4RTzEyUTw/t7a/tpFpLQl2LUm3fs4Tmvc7Z6Xjj6S8N0MkwoqZeJ0wqczoRwdPtI7n8ELWd3/nYSbMjzBkJgO+FVHi0InE1fp5rK95LSeB1Lu2zynN1FdT5i+5JaTf4PhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tqdczi71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F6DC4CED1;
	Wed, 29 Jan 2025 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738162298;
	bh=bGm0rMnYiWwLGtC/T9s/6XWn/vt2mwYcmN7sKKwiNkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqdczi71G5qNbpwhwrQblVG9IFo6SnW9Ja3rAzmnYwIXFMJWJfu+skLSmuw5CjN4Y
	 UZYiepI3sw4xB2msE0HiUfQEIiWvImGMm0s1FUl+aABfNmWb30BFeXOZkpWYhFoU0t
	 r/LnJzK75P7XCiDgWekFtBKQU9HlEtAHvLm2j/zc=
Date: Wed, 29 Jan 2025 15:50:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morten <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v6.6 00/10] Address CVE-2024-46701
Message-ID: <2025012937-unsaddle-movable-4dae@gregkh>
References: <20250124191946.22308-1-cel@kernel.org>
 <50585d23-a0c1-4810-9e94-09506245f413@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50585d23-a0c1-4810-9e94-09506245f413@oracle.com>

On Wed, Jan 29, 2025 at 08:55:15AM -0500, Chuck Lever wrote:
> On 1/24/25 2:19 PM, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > This series backports several upstream fixes to origin/linux-6.6.y
> > in order to address CVE-2024-46701:
> > 
> >    https://nvd.nist.gov/vuln/detail/CVE-2024-46701
> > 
> > As applied to origin/linux-6.6.y, this series passes fstests and the
> > git regression suite.
> > 
> > Before officially requesting that stable@ merge this series, I'd
> > like to provide an opportunity for community review of the backport
> > patches.
> > 
> > You can also find them them in the "nfsd-6.6.y" branch in
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> > 
> > Chuck Lever (10):
> >    libfs: Re-arrange locking in offset_iterate_dir()
> >    libfs: Define a minimum directory offset
> >    libfs: Add simple_offset_empty()
> >    libfs: Fix simple_offset_rename_exchange()
> >    libfs: Add simple_offset_rename() API
> >    shmem: Fix shmem_rename2()
> >    libfs: Return ENOSPC when the directory offset range is exhausted
> >    Revert "libfs: Add simple_offset_empty()"
> >    libfs: Replace simple_offset end-of-directory detection
> >    libfs: Use d_children list to iterate simple_offset directories
> > 
> >   fs/libfs.c         | 177 +++++++++++++++++++++++++++++++++------------
> >   include/linux/fs.h |   2 +
> >   mm/shmem.c         |   3 +-
> >   3 files changed, 134 insertions(+), 48 deletions(-)
> > 
> 
> I've heard no objections or other comments. Greg, Sasha, shall we
> proceed with merging this patch series into v6.6 ?

Um, but not all of these are in a released kernel yet, so we can't take
them all yet.  Also what about 6.12.y and 6.13.y for those commits that
will be showing up in 6.14-rc1?  We can't have regressions for people
moving to those releases from 6.6.y, right?

thanks,

greg k-h

