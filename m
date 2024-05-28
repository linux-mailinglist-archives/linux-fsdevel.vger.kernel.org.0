Return-Path: <linux-fsdevel+bounces-20292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972BF8D11A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 04:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7FCB21578
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 02:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1EADDBC;
	Tue, 28 May 2024 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GGl9B4Tp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E8C8FF
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862241; cv=none; b=JAJOLMU4HLCbzwLRldR2j7FGyPVcIFbi2FCBlTjew3aXZSb34i/pQDm+cG60+ovgisE/xcKVpnBhmP2RV0gr8wyvhl+OCY5DdJhZBbwe+Or6X0XiAme7Hi/M0J1xAnhejTG/eWS9AzMwV01XgEs9pVm2vqsyhmShFPhksPMXm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862241; c=relaxed/simple;
	bh=T44R3JRU7F5Qg0Z+K5jLQp1/KWmkOLcM9DbQqaBhU60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgTMVwSk55ODWTN6Pp0rVaOMugfYHr6xBWiiSMP29s+yi1gvbUUxfvUtJBS/zP6do4xdyFNXGiRrn8CGk7M3FSUnJ0Gbty4K2Sv2B9IWX/nchVlyJ09hoCdDo0YemobdBigwXlmY9VcHT+ZXQOB16URN/eD76lA/E/Y8QAEdMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GGl9B4Tp; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-245435c02e1so175698fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 19:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716862239; x=1717467039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmd2EMc3qUIYP22OYlOjtPqe/KTGX4USmf9k1VeKNyw=;
        b=GGl9B4TpuX9VnEiyOoT1CEv+/lfFMhfmj5G5lKqmorpolfrSnoq+/Bzp9MlcoHQccC
         oHY1v+wBjOIDs7fiDmXie5x8OzRHKQj9Gig1Mu6z4ZY8xfNyh7KNXi35y5D8R5fcmc+M
         OKHIDu1rROlv2bC+P4c/Mb3Bg6Krpzdbg+Ka9OPwi0D2lSYPJSxzg00TDQ1f6Spe+rqq
         PWFZx9FVBNnvNNX8pkCa2YVrkUoNajx0r76550CM11FdLdRJ1m1cK4aSaoaUTB/nAetr
         75HB2jn/+uFz2hYrCEYcw1+grNfx/wklhusNKEuD0eWS/kulK3H0a20p0fdZtFL2hf5h
         gHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716862239; x=1717467039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qmd2EMc3qUIYP22OYlOjtPqe/KTGX4USmf9k1VeKNyw=;
        b=C3AVXG1+qcpMFoJY3mskJw9DiyJ3a1/w6IMw9X2W118wBchUBD2e030TmzaefZC8GQ
         j8CF4zJFrGrH2Y1ayMNZ6G35PcNhSM4eP2r7lDWH9OKSuNno/VmE/g2BjyFDgeH6uQXX
         TWJXfaY5p8+ilR6RMDbKiXQSfiKY6dkU0+JzNnpwTU33ev8C4vlau/zrvd9JypC5k6XH
         J1TxQxZ3TD8h1Rm85yA+4QOjrIF8EL/vD4QiaEdi+bIsWplLWjghmGljYn1Dg0WIcsCN
         NNFvy3HipObrV5sUavgu+nr5938BJfgp5swdBARA6ZPM3o8n88eUAP4rDhKDNFgoRGcc
         sekA==
X-Forwarded-Encrypted: i=1; AJvYcCU3xaHOwzAYPSX+MZyaTpObKGoCayPrH5zYWjod5MeEJdvt0xClmlSieghW3V5LeqoIXFt1H/9SLb89QZdZynSXLCEY6ZtinOuBWfEMOw==
X-Gm-Message-State: AOJu0Yy9ADwmWqeopnsziFf9dlQTQ5ivafyNHmDJk9T/xxJ5jkYTg2i3
	RlruGe0q3CadQ0K4sTCaIg1fiGqWZmygPH/15HINWVr3jlh8JjZodnPuIcB5gPs=
X-Google-Smtp-Source: AGHT+IF3Xj2sIzlDCRsV/eYipJRhZMPSxvsb9a9QY3yqh2vacBUnWuYEkFhGpLWSqF3aaU0jQxt7+w==
X-Received: by 2002:a05:6870:17a6:b0:24c:ae57:b4ab with SMTP id 586e51a60fabf-24cae57b542mr10925272fac.11.1716862238664;
        Mon, 27 May 2024 19:10:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ebb8sm5644930b3a.14.2024.05.27.19.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 19:10:38 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sBmIN-00CxwF-10;
	Tue, 28 May 2024 12:10:35 +1000
Date: Tue, 28 May 2024 12:10:35 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: alexjlzheng@tencent.com, bfoster@redhat.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	raven@themaw.net, rcu@vger.kernel.org
Subject: Re: About the conflict between XFS inode recycle and VFS rcu-walk
Message-ID: <ZlU9G5ZWe6FtsFte@dread.disaster.area>
References: <ZlRVPv0EGIu5q7l9@dread.disaster.area>
 <20240527135615.2633248-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527135615.2633248-1-alexjlzheng@tencent.com>

On Mon, May 27, 2024 at 09:56:15PM +0800, Jinliang Zheng wrote:
> On Mon, 27 May 2024 at 19:41:18 +1000, Dave Chinner wrote:
> > On Thu, May 16, 2024 at 03:23:40PM +0800, Ian Kent wrote:
> > > On 16/5/24 15:08, Ian Kent wrote:
> > > > On 16/5/24 12:56, Jinliang Zheng wrote:
> > > > In any case what you say is indeed correct, so the comment isn't
> > > > important.
> > > > 
> > > > 
> > > > Fact is it is still a race between the lockless path walk and inode
> > > > eviction
> > > > 
> > > > and xfs recycling. I believe that the xfs recycling code is very hard to
> > > > fix.
> > 
> > Not really for this case. This is simply concurrent pathwalk lookups
> > occurring just after the inode has been evicted from the VFS inode
> > cache. The first lookup hits the XFS inode cache, sees
> > XFS_IRECLAIMABLE, and it then enters xfs_reinit_inode() to
> > reinstantiate the VFS inode to an initial state. The Xfs inode
> > itself is still valid as it hasn't reached the XFS_IRECLAIM state
> > where it will be torn down and freed.
> > 
> > Whilst we are running xfs_reinit_inode(), a second RCU pathwalk has
> > been run and that it is trying to call ->get_link on that same
> > inode. Unfortunately, the first lookup has just set inode->f_ops =
> > &empty_fops as part of the VFS inode reinit, and that then triggers
> > the null pointer deref.
> 
> The RCU pathwalk must occur before xfs_reinit_inode(), and must obtain the
> target inode before xfs_reinit_inode().

I'm not sure I follow - xfs_reinit_inode() typically occurs during a
pathwalk when no dentry for the given path component is found in the
dcache. Hence it has to create the dentry and look up the inode.
i.e.

walk_component()
  lookup_fast() -> doesn't find a valid cached dentry
  lookup_slow()
    inode_lock_shared(parent)
    parent->i_op->lookup(child)
      xfs_vn_lookup()
        xfs_lookup()
          xfs_iget(child)	<<<< inode may not exist until here
            xfs_iget_recycle(child)
	      xfs_reinit_inode(child)
    inode_unlock_shared(parent)

The path you are indicating is going wrong is:

link_path_walk()
  walk_component()
    <find child dentry>
    step_into(child)
      if (!d_is_symlink(child dentry)) {
        ....
        return
      }
      pick_link(child)
        if (!inode->i_link)
          inode->i_op->get_link()   <<<< doesn't exist, not a symlink inode

This implies that lookup_fast() found a symlink dentry with a
d_inode pointer to something that wasn't a symlink. That doesn't
mean that anything has gone wrong with xfs inode recycling within an
RCU grace period.

For example, d_is_symlink() looks purely at the dentry state and
assumes that it matches the dentry->d_inode attached to it:

#define DCACHE_ENTRY_TYPE               (7 << 20) /* bits 20..22 are for storing type: */
#define DCACHE_MISS_TYPE                (0 << 20) /* Negative dentry */
#define DCACHE_WHITEOUT_TYPE            (1 << 20) /* Whiteout dentry (stop pathwalk) */
#define DCACHE_DIRECTORY_TYPE           (2 << 20) /* Normal directory */
#define DCACHE_AUTODIR_TYPE             (3 << 20) /* Lookupless directory (presumed automount) */
#define DCACHE_REGULAR_TYPE             (4 << 20) /* Regular file type */
#define DCACHE_SPECIAL_TYPE             (5 << 20) /* Other file type */
#define DCACHE_SYMLINK_TYPE             (6 << 20) /* Symlink */

static inline unsigned __d_entry_type(const struct dentry *dentry)
{
        return dentry->d_flags & DCACHE_ENTRY_TYPE;
}

static inline bool d_is_symlink(const struct dentry *dentry)
{
        return __d_entry_type(dentry) == DCACHE_SYMLINK_TYPE;
}

This is a valid optimisation and good for performance, but it does
make it susceptible to memory corruption based failues. i.e.  a
single bit memory corruption can change a DCACHE_DIRECTORY_TYPE
dentry to look like a DCACHE_SYMLINK_TYPE dentry, and then the code
calls pick_link() on a dentry that points to a directory inode and
not a symlink inode.

Such a memory corruption would have an identical crash signature
to the stack trace you posted, hence I'd really like to have solid
confirmation that the crash you are seeing is actually a result of
inode recycling and not something else....

> > Once the first lookup has finished the inode_init_always(),
> > xfs_reinit_inode() resets inode->f_ops back to 
> > xfs_symlink_file_ops and get_link calls work again.
> > 
> > Fundamentally, the problem is that we are completely reinitialising
> > the VFS inode within the RCU grace period. i.e. while concurrent RCU
> > pathwalks can still be in progress and find the VFS inode whilst the
> > XFS inode cache is manipulating it.
> > 
> > What we should be doing here is a subset of inode_init_always(),
> > which only reinitialises the bits of the VFS inode we need to
> > initialise rather than the entire inode. The identity of the inode
> > is not changing and so we don't need to go through a transient state
> > where the VFS inode goes xfs symlink -> empty initialised inode ->
> > xfs symlink.
> 
> Sorry, I think this question is wrong in more ways than just inode_operations.
> After the target inode has been reinited by xfs_reinit_inode(), its semantics
> is no longer the inode required by RCU walkpath. The meanings of many fields
> have changed, such as mode, i_mtime, i_atime, i_ctime and so on.

That's only the case in the the unlink->inode free->create-> inode
allocation path, assuming that is what the system actually tripped
over.

However, we can hit the reinit code from a simple path lookup
immediately after memory reclaim freed the dentry and inode and it
is still in the XFS inode cache.  i.e.  ->destroy_inode() ->
XFS_IRECLAIMABLE -> ->lookup() -> xfs_iget() -> xfs_iget_recycle().
i.e. the inode reinit doesn't only get triggered by unlink/alloc
cycles, so we often reinit to the exact same inode state as before
the inode was evicted from memory.

Essentially, it is not clear to me how your system tripped over this
issue; it *may* be an inode cache recycling issue, but I can also
point to other situations that could result in a very similar crash
signature. What I'm looking for is real evidence that it was a
recycling issue that lead to this problem, and evidence that it can
still occur on a current TOT kernel. A method for reproducing the
issue your kernels are seeing would be nice.

FWIW, reproducing on a current TOT kernel is important - even if you're seeing the
unlink/alloc/reinit case on your 5.4 kernel, this path had a major
architectural change in 5.14 and AFAICT that largely invalidates all
the previous analysis of this inode reinit behaviour.

In 5.14 we moved the inode freeing code we used to do in evict()
into a background thread, hence the "evict, unlink, create, reinit"
process now has an enforced context switch and delay between
->destroy_inode() and the internal inode unlink/freeing code.

By decoupling the unlink processing from the calling task context,
the task context can no longer immediately reallocate the same
physical inode, and so the mechanism that lead to applications being
able to directly trigger the xfs_inode_reinit() code for inodes that
are changing identity repeatedly in certain situations no longer
exists. The delay in unlink processing also affects how RCU grace
periods expire between unlink and allocation/reinit, so assumptions
made on that side of the analysis are also suspect and need to be
re-examined.

Hence before we spend any more time chasing ghosts, I'd really like
to see hard evidence for what caused the crash you reported and a
demonstration of it occuring on current TOT kernels, too.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

