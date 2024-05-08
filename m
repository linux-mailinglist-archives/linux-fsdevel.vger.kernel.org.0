Return-Path: <linux-fsdevel+bounces-18978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3908BF3C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 02:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8209328418A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 00:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955B624;
	Wed,  8 May 2024 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hFP6L2Sa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118D621
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128877; cv=none; b=GA19+a9GhWceVL4QLH0XhqOAfVNCXxyMd0DIyficKFfaK6JgNInuTA40w1dluKUrQ+yZQlImCOsaLT2VhWQLD9RjcVKyRpXnMOFJ3PPTwqXdYKzwSp8u/K6jhXqAQFjO8Uz4uJfxos7AfFSNRz41AL93tnNLt82Wzvy9KvtMENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128877; c=relaxed/simple;
	bh=Vm+TH4xMD3lhFRPq6wwD0pF4XTh2UXa0Vr8eTjFg63M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogBg+WphAPGN05UnnXwGTqbkEN4OGljtyugRvn1KgRB38Q7JJFCMd4+8oQ3MP9itIPhbg/65ic06rJxNBlJayRItiFaNmOQDIACQ3aV7Bc/ow2hZCtOQ+j6ARt7kwANx/+DHFCj7BY0rYl/9LrChRQiwho/KgiKB2RZCrcJdCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hFP6L2Sa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C2rDJYIkca/NcI41tVw+tIr8Ki7GXoNfwGHsY8m4FDs=; b=hFP6L2Savc9IbLhJNlHFLlbUZF
	efrEPdZcyz5wAeEMiPr6iHELaSWNq+1oAurLa4Z8Om5XYWjhDfwkf5YlNy/ILWR+RRs0P6bZubZer
	jMqNwq6z5/nXlS2GnqN5GZN0wBL1Sjk8buDdNVa9O+P0ZWopI1Ztay9ZFKEatrc/F1JpM2ZGZZ1Rh
	+n/49lbsfqhcVskBK0G21f6a6iWVAS5uLWzuv5ta9Csn5uw4sKYHM3YYOODMEbLiXpp47yGEtVbS2
	awPWRv9DjQ4edgMgJvWsLCiBhdwhBVmL26KmQjTfdEXqY21zp7kTH8ESId3ALhf7A40LybrOCQr4v
	2U2xY3tQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4VMo-00Fbf2-33;
	Wed, 08 May 2024 00:41:07 +0000
Date: Wed, 8 May 2024 01:41:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Dawid Osuchowski <linux@osuchow.ski>, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs: Create anon_inode_getfile_fmode()
Message-ID: <20240508004106.GL2118490@ZenIV>
References: <20240426075854.4723-1-linux@osuchow.ski>
 <20240426-singt-abgleichen-2c4c879f3808@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426-singt-abgleichen-2c4c879f3808@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 26, 2024 at 06:05:15PM +0200, Christian Brauner wrote:
> On Fri, 26 Apr 2024 09:58:54 +0200, Dawid Osuchowski wrote:
> > Creates an anon_inode_getfile_fmode() function that works similarly to
> > anon_inode_getfile() with the addition of being able to set the fmode
> > member.
> > 
> > 
> 
> Sorry, forgot that I picked this up.
> 
> ---
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
> 
> [1/1] fs: Create anon_inode_getfile_fmode()
>       https://git.kernel.org/vfs/vfs/c/55394d29c9e1

Umm...  vfs.all contains 386831d0fb42a952afd4b0f862f335a09e911715
    Merge branch 'vfs.misc' into vfs.all
which merges e035af9f6ebacd98774b1be2af58a5afd6d0d291 into vfs.all.

55394d29c9e164f2e1991352f1dc8f973c4f1589 "fs: Create anon_inode_getfile_fmode()"
is e035af9f6ebacd98774b1be2af58a5afd6d0d291^^^ (and thus picked by the merge),
but your vfs.miss is 652efdeca5b142ee9c5197f45f64fc3d427d4b08, which is
e035af9f6ebacd98774b1be2af58a5afd6d0d291^^^^.

So it looks like you forgot to push vfs.misc as well...

