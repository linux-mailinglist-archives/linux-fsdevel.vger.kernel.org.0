Return-Path: <linux-fsdevel+bounces-57634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75817B24033
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4408016DB0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 05:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E427C2BE05F;
	Wed, 13 Aug 2025 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="a1ZrL/NS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A63149C51;
	Wed, 13 Aug 2025 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063071; cv=none; b=A78ko1Lyh7Sd5ghFnG/EHbxITwRnLH8CTU+1XBx4C25JVTiNVk4oOrcbYwrXRX8Ig9jFHpyhM5DBTRZa54MEt09b7tAThSe1QRFhzejZppF0vTuKhT4ue74Jcf+IFgcLSSC0pYbr2LCpPAcIMGV56AGiE/wMxDb104NycxxnLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063071; c=relaxed/simple;
	bh=wk+Ry59ozajRb11mml7d+mqIc7hIAdiG95aMkeRWrWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+DgxxPUL1zVs3MiAbZ+OUAfqp2qoBykypzho7xR6ciKgbQZbaV1DjokFLphChS6iIW4nt+9sGyajqaXfjnjaIdL8P4V9OQjz3BTsmrxmZM+sx9c7DvXbVkTV0ZrZHgLb92FELIEnr065Sod9tF8ydjPeQ+TrG3dOFj4at0mx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=a1ZrL/NS; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5551614C2D3;
	Wed, 13 Aug 2025 07:31:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755063066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6p+t+U0uSYJuGzWiD0mLYL0NMl5d9rOTOk0vTUbJIg=;
	b=a1ZrL/NSwL62Q1J5z0AvDADFy4CD5PsZVEkrtkLA1gLnfOEss1bEgOZuSu0W670CajZosF
	DFoKoEcc5aBVj9YeTyhPPSFaS/NF3gY3XiN26YwSTY8rwoYs5sIn45A7hC4gJevK5Nuoho
	hf3X++L+prHSrNk+kkkqKZKjNxJRBBcoFuN9kjtg/fFRCuc7DI1n3hFGagtBpPvYoojTvJ
	025P6IYLTZCp7+tHJrejUIPRUNRWUHWZ1yoz20k8MNVi81tWxeEXR9qVRnTAXZ0qc6HIts
	nLLPzVAV7IDRHC4UCSgzSYhyJvRwd5y8ZvlWNSNvq4nQuznRsxNEqe8Ek7gg2A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 126c71f3;
	Wed, 13 Aug 2025 05:31:01 +0000 (UTC)
Date: Wed, 13 Aug 2025 14:30:46 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <aJwjBgzu2ZLdA0jg@codewreck.org>
References: <cover.1743971855.git.m@maowtm.org>
 <aJXRAzCqTrY4aVEP@codewreck.org>
 <13395769.lPas3JvW2k@silver>
 <b9aa9f6f-483f-41a5-a8d7-a3126d7e4b8f@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9aa9f6f-483f-41a5-a8d7-a3126d7e4b8f@maowtm.org>

Tingmao Wang wrote on Wed, Aug 13, 2025 at 12:53:37AM +0100:
> My understanding of cache=loose was that it only assumes that the server
> side can't change the fs under the client, but otherwise things like
> inodes should work identically, even though currently it works differently
> due to (only) cached mode re-using inodes - was this deliberate?

Right, generally speaking I agree things should work as long as the
mount is exclusive (can't change server side/no other client); but
I think it's fine to extend this to server being "sane" (as in,
protocol-wise we're supposed to be guaranteed that two files are
identical if and only if qid is identical)

> > I think that's fine for cache=none, but it breaks hardlinks on
> > cache=loose so I think this ought to only be done without cache
> > (I haven't really played with the cache flag bits, not check pathname if
> > any of loose, writeback or metadata are set?)
> 
> I think currently 9pfs reuse inodes if cache is either loose or metadata
> (but not writeback), given:
> 
> 	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
> 		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
> 	else
> 		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
> 
> in v9fs_vfs_lookup, so maybe we keep this pattern and not check pathname
> if (loose|metadata) is set (but not writeback)?

This makes sense, let's stick to loose/metadata for this as well.

> >> The main problem here is how to store the pathname in a sensible way and
> >> tie it to the inode.  For now I opted with an array of names acquired with
> >> take_dentry_name_snapshot, which reuses the same memory as the dcache to
> >> store the actual strings
> 
> (Self correction: technically, the space is only shared if they are long
> enough to not be inlined, which is DNAME_INLINE_LEN = 40 for 64bit or 20
> for 32bit, so in most cases the names would probably be copied.  Maybe it
> would be more compact in terms of memory usage to just store the path as a
> string, with '/' separating components?  But then the code would be more
> complex and we can't easily use d_same_name anymore, so maybe it's not
> worth doing, unless this will prove useful for other purposes, like the
> re-opening of fid mentioned below?)

I think it's better to keep things simple first and check the actual
impact with a couple of simple benchmarks (re-opening a file in a loop
with cache=none should hit this path?)

If we want to improve this, rather than keeping the full string it might
make sense to carry a partial hash in each dentry so we can get away
with checking only the parent's dentry + current dentry, or something
like that?
But, simple and working is better than fast and broken, so let's have a
simple v1 first.

> > Frankly the *notify use-case is difficult to support properly, as files
> > can change from under us (e.g. modifying the file directly on the host
> > in qemu case, or just multiple mounts of the same directory), so it
> > can't be relied on in the general case anyway -- 9p doesn't have
> > anything like NFSv4 leases to get notified when other clients write a
> > file we "own", so whatever we do will always be limited...
> > But I guess it can make sense for limited monitoring e.g. rebuilding
> > something on change and things like that?
> 
> One of the first use case I can think of here is IDE/code editors
> reloading state (e.g. the file tree) on change, which I think didn't work
> for 9pfs folders opened with vscode if I remembered correctly (but I
> haven't tested this recently).  Even though we can't monitor for remote
> changes, having this work for local changes would still be nice.

Yeah, I also do this manually with entr[1], and git's fsmonitor (with
watchman) does that too -- so I guess people living in a 9p mount would
see it..
[1] https://github.com/eradman/entr

But I think 9p is just slow in general so such setups can probably be
improved more drastically by using something else :P

Anyway, thank you for your time/work, I'll try to be more timely in
later reviews.
-- 
Dominique Martinet | Asmadeus

