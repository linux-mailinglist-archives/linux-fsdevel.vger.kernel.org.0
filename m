Return-Path: <linux-fsdevel+bounces-46857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3929AA9587F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 23:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AE418968D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD50721ABAD;
	Mon, 21 Apr 2025 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ERTFTY7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319ED219A8D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272460; cv=none; b=BLdiJ4ku6aDF5vjCWXXQTD+C0n2if8jEl6PpZwk/cJYX9sy3i23mzJ/jcJc621zUZMFv1OqJkOewqs6NHPdxChbfvChR7hRQANMe63xxQT6RLDcm+iVXOVSxoKLeG60OTVBXLkTqoC/h0lHoa2fz9qCt/lSmDsN5Gva17PRmT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272460; c=relaxed/simple;
	bh=PKEw/e0iqeowiGVCNTSOmyoAMVnF752/fbR6Hzm5cwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwNlCUJm0VJgxLFu5vJjwSgYBmo2rl1vIRXeCKsgik/MVRkWKH77tQCxIVQjlIXgjjuvs8VB/b78n6n9IvQklPvGRxNANzG2DyuD8qM2b+SknYPvjehHEQLBG6pNwzkEeaZG+6U6Vl0n3PaUR4QUZX5s/qRSLvK1zHp/ZO7d5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ERTFTY7P; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225477548e1so43024965ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1745272453; x=1745877253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fn3qzq0K+EM8lqZncvo7f094wjXfa1xIK4ukDclfAL0=;
        b=ERTFTY7PbuvqpSrrEVsy364xn8OVQ44lQRmwlFQirsKYwNKAiWz9Gvb6r2yrjpW8TH
         MOkD1pEPBUTT8PbaN76/VRozACJ1PQncuDN35lSeG1J4yBmvgnov64AqY5etDrdylAD/
         pPO0mh+4Mtn967BqPeixxEfyU75p40jL2yeWtk/ot4FwkQy9kHnfrg2AshHGWQV8tw0q
         ML+iS2TYXb1Bpa5c396YtgnE8PdsBynUZ2N1/oZc4VMAFXJEleiyMBTjfd55M6rRpMMF
         sCMI30SG+ozwwLsvVErqsiQUifDW60pqVwrmrkh3mbMugwyhUv4k0L7lz5uxZVvA0Obq
         z/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745272453; x=1745877253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn3qzq0K+EM8lqZncvo7f094wjXfa1xIK4ukDclfAL0=;
        b=nqzZ2x+mNT+WW5F3q0T9S92P6E0y9y4jCXPm+ibt/Ql/7x7pAMDzzq3AGTzytzDkPm
         WAKNWAEpZTgLleHe2FQyjjoEdOkpuyDanlB0toVDa5ocquCf+uZQry4i/E1LeRUIBoJy
         lgFWQfLCN4rK0aFiXfjEVrexK0dvNKGKv+OVHG07WrHSxYLtmGAkawt6qA7BduTfu3a9
         OJaIdA0CvXoYes57sJqh6bE668y1CKr2D8Znj+0jhogO3LqVJcWZtyx+djijzJT5Wx6x
         LUPKR+1rNj7U7O4na/Hp32pOHb3aqH/meWfGK5b540o/2YIbD+vowGfLam3NGvDK9cJT
         NG4g==
X-Forwarded-Encrypted: i=1; AJvYcCVr3k2+hSklUAwG8UUPv6fxbQyG0gpoDlX4wV11hBPs67zSVxyLcmGfvw5OXDfrDwifNMPGtFpCY0cRizjS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd50jyhp1UPs2GJXf6Xwdx/gVAePI02hMdfxOJ4y6igCxsIiGI
	CWAsruMxMbp3moHtaLl0oCtC3zzrGCNVymEzfdf4eJYXESrSeimvnkMGPcwR5JU=
X-Gm-Gg: ASbGncvJ2UU0+WBBBVDhtDHb0mZhK/Gk1IZ+a78ZGN+JuJDntRWX9+D4qXtzL8XEr//
	rrc+i1jshdusGfv/IXChIIlIpR7hfYWCAAfHDx7HPfYQcvvGVE9TqHNIYrJrG9+DaAoX89r70Rz
	zZsbYP/1Z8ihRTSm6aLZ0MBx7BrlpdH7vFOnZqBy97xXg3DQ/vGz5dj1OPQ9L3TSveDWSWAsKrN
	dhFbND78onAQdgC/tGsAza8T/edOlrfl71TQeBF8bmINmxKHpxLVkRpP1r3qXTgw66TvhcheqK0
	pawHglA/LENdIMDfU8DMzz+bWOCRHJMoEqN8856RsPGzOdRSgE5QXeeZ9dBnqa/t7fFi1f7+LJV
	C+2usx8qxfl3w4Q==
X-Google-Smtp-Source: AGHT+IEXE5IPmpHnPi4Qq+FwaQw5lgl3sKuB/kbfiEySVxGThEdf7vP0Xv1jFapFVQNzXAaPPgpaow==
X-Received: by 2002:a17:902:e2cc:b0:224:2715:bf44 with SMTP id d9443c01a7336-22c53580c19mr157619545ad.19.1745272453215;
        Mon, 21 Apr 2025 14:54:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf2548sm70914015ad.64.2025.04.21.14.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 14:54:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u6z5c-0000000BToE-2YoI;
	Tue, 22 Apr 2025 07:54:08 +1000
Date: Tue, 22 Apr 2025 07:54:08 +1000
From: Dave Chinner <david@fromorbit.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Tobin C. Harding" <tobin@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michal Hocko <mhocko@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [DISCUSSION] Revisiting Slab Movable Objects
Message-ID: <aAa-gCSHDFcNS3HS@dread.disaster.area>
References: <aAZMe21Ic2sDIAtY@harry>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAZMe21Ic2sDIAtY@harry>

On Mon, Apr 21, 2025 at 10:47:39PM +0900, Harry Yoo wrote:
> Hi folks,
> 
> As a long term project, I'm starting to look into resurrecting
> Slab Movable Objects. The goal is to make certain types of slab memory
> movable and thus enable targeted reclamation, migration, and
> defragmentation.
> 
> The main purpose of this posting is to briefly review what's been tried
> in the past, ask people why prior efforts have stalled (due to lack of
> time or insufficient justification for additional complexity?),
> and discuss what's feasible today.
> 
> Please add anyone I may have missed to Cc. :)

Adding -fsdevel because dentry/inode cache discussion needs to be
visible to all the fs/VFS developers.

I'm going to cut straight to the chase here, but I'll leave the rest
of the original email quoted below for -fsdevel readers.

> Previous Work on Slab Movable Objects
> =====================================

<snip>

Without including any sort of viable proposal for dentry/inode
relocation (i.e. the showstopper for past attempts), what is the
point of trying to ressurect this?

I don't have a solution for the dentry cache reference issues - the
dentry cache maintains the working set of files, so anything that
randomly shoots down unused dentries for compaction is likely to
have negative performance implications for dentry cache intensive
workloads.

However, I can think of two possible solutions to the untracked
external inode reference issue.

The first is that external inode references need to take an active
reference to the inode (like a dentry does), and this prevents
inodes from being relocated whilst such external references exist.

Josef has proposed an active/passive reference counting mechanism
for all references to inodes recently on -fsdevel here:

https://lore.kernel.org/linux-fsdevel/20250303170029.GA3964340@perftesting/

However, the ability to revoke external references and/or resolve
internal references atomically has not really been considered at
this point in time.

To allow referenced inodes to be relocated, I'd suggest that any
subsystem that takes an external reference to the inode needs to
provide something like a SRCU notifier block to allow the external
reference to be dynamically removed. Once the relocation is done,
another notifier method can be called allowing the external
reference to be updated with the new inode address.  Any attempt to
access the inode whilst it is being relocated through that external
mechanism should probably block.

[ Note: this could be leveraged as a general ->revoke mechanism for
external inode references. Instead of the external access blocking
after reference recall, it would return an error if access
revocation has occurred. This mechanism could likely also solve some
of the current lifetime issues with fsnotify and landlock objects. ]

This leaves internal (passive) references that can be resolved by
locking the inode itself. e.g. getting rid of mapping tree
references (e.g. folio->mapping->host) by invalidating the
inode page cache.

The other solution is to prevent excessive inode slab cache
fragmentation in the first place. i.e. *stop caching unreferenced
inodes*. In this case, the inode LRU goes away and we rely fully on
the dentry cache pinning inodes to maintain the working set of
inodes in memory. This works with/without Josef's proposed reference
counting changes - though Josef's proposed changes make getting rid
of the inode LRU a lot easier.

I talk about some of that stuff in the discussion of this superblock
inode list iteration patchset here:

https://lore.kernel.org/linux-fsdevel/20241002014017.3801899-1-david@fromorbit.com/

-Dave.

> 
> Previous Work on Slab Movable Objects
> =====================================
> 
> Christoph Lameter, Slab Defragmentation Reduction, 2007-2017 (V16: [2]):
> Christoph Lameter, Slab object migration for xarray, 2017-2018 (V2: [3]):
>   Christoph's long-standing effort (since 2007) aiming to defragment
>   slab memory in cases where sparsely populated slabs occupy excessive
>   amount of memory.
> 
>   Early versions of the work focused on defragmenting slab caches
>   for filesystem data structures such as inode, dentry, and buffer head.
>   updatedb was suggested as the standard way to trigger for generating
>   sparsely populated slabs on file servers.
> 
>   However, defragmenting slabs for filesystem data structures has proven
>   to be very difficult to fully solve, because inodes and dentries are
>   neither reclaimable nor migratable, limiting the effectiveness of
>   defragmentation.
> 
>   In late 2018, the effort was revived with a new focus on migrating
>   XArray nodes. However, it appears the work was discontinued after
>   V2 [3]?
> 
> Tobin C. Harding, Slab Movable Objects, 2019 (First Non-RFC: [5])
> - Tobin C. Harding revived Christoph's earlier work and introduced
>   a few enhancements, including partial shrinking of dentries, moving
>   objects to and from a specific NUMA node, and balancing objects across
>   all NUMA nodes.
> 
>   Also appears to be discontinued after the first non-RFC version [5]? 
> 
> At LSFMM 2017, Andrea Arcangeli suggested [6] virtually mapped slabs,
> which might be useful since migrating them does not require changing the
> address of objects. But as Rik van Riel pointed out at that time, it
> isn't really useful for defragmentation. Andrea Arcangeli responded
> that it can be beneficial for memory hotplug, compaction and out-of-memory
> avoidance.
> 
> The exact mechanism wasn't described in [6], but I assume it'll involve
> 1) unmap a slab (and page faults after unmap need to wait for migration
> to complete), 2) copy objects to a new slab, and 3) map the new slab?
> But the idea hasn't gained enough attention for anyone to actually
> implement it.
> 
> Potential Candidates of SMO
> ===========================
> 
> Basic Rules
> -----------
> 
> - Slab memory can only be reclaimed or migrated if the user of the slab
>   provides a way to isolate / migrate objects.
> - If objects can be reclaimed, it makes sense to simply reclaim them
>   instead of migrating them (unless we know it's better to keep that
>   object in memory).
> - Some objects can't be reclaimed, but migrating them is (if possible)
>   still useful for defragmentation and compaction.
>   - However it is not always feasible 
> 
> Potential candidates include (but not limited to):
> --------------------------------------------------
> 
> - XArray nodes can be migrated (can't be reclaimed as they're being used)
>   - Can be reclaimed if it only includes shadow entries.
> - Maple tree nodes (if without external locking) and VMAs can be migrated
>   and obviously can't be reclaimed.
> - Negative dentry should be reclaimed, instead of being migrated.
> - Only unused dentries can be reclaimed without high cost.
>   - Dentries with nonzero refcount are not really relocatable? (per [1])
> - Even unused inodes can't be reclaimed nor relocated due to external
>   references? (per [4])
> 
> Al Viro made it clear [1] that inodes / dentries are not really
> relocatable. He also mentioned:
> > So from the correctness POV
> > 	* you can kick out everything with zero refcount not
> > on shrink lists.
> > 	* you _might_ try shrink_dcache_parent() on directory
> > dentries, in hope to drive their refcount to zero.  However,
> > that's almost certainly going to hit too hard and be too costly.
> > 	* d_invalidate() is no-go; if anything, you want something
> > weaker than shrink_dcache_parent(), not stronger.
> > 
> > For anything beyond "just kick out everything in that page that
> > happens to have zero refcount" I would really like to see the
> > stats - how much does it help, how costly it is _and_ how much
> > of the cache does it throw away (see above re running into a root
> > dentry of some filesystem and essentially trimming dcache for
> > that fs down to the unevictable stuff).
> 
> Dave Chinner mentioned [4] why it is hard to reclaim or migrate (in a
> targeted manner) even inodes with no active references:
> > On Wed, Dec 27, 2017 at 04:06:36PM -0600, Christoph Lameter wrote:
> > > This is a patchset on top of Matthew Wilcox Xarray code and implements
> > > object migration of xarray nodes. The migration is integrated into
> > > the defragmetation and shrinking logic of the slab allocator.
> > .....
> > > This is only possible for xarray for now but it would be worthwhile
> > > to extend this to dentries and inodes.
> > 
> > Christoph, you keep saying this is the goal, but I'm yet to see a
> > solution proposed for the atomic replacement of all the pointers to
> > an inode from external objects.  An inode that has no active
> > references still has an awful lot of passive and internal references
> > that need to be dealt with.
> > 
> > e.g. racing page operations accessing mapping->host, the inode in
> > various lists (e.g. superblock inode list, writeback lists, etc),
> > the inode lookup cache(s), backpointers from LSMs, fsnotify marks,
> > crypto information, internal filesystem pointers (e.g. log items,
> > journal handles, buffer references, etc) and so on. And each
> > filesystem has a different set of passive references, too.
> > 
> > Oh, and I haven't even mentioned deadlocks yet, either. :P
> > 
> > IOWs, just saying "it would be worthwhile to extend this to dentries
> > and inodes" completely misrepresents the sheer complexity of doing
> > so. We've known that atomic replacement is the big problem for
> > defragging inodes and dentries since this work was started, what,
> > more than 10 years? And while there's been many revisions of the
> > core defrag code since then, there has been no credible solution
> > presented for atomic replacement of objects with complex external
> > references. This is a show-stopper for inode/dentry slab defrag, and
> > I don't see that this new patchset is any different...
> 
> [1] https://lore.kernel.org/linux-mm/20190403190520.GW2217@ZenIV.linux.org.uk
> [2] https://lore.kernel.org/linux-mm/20170307212429.044249411@linux.com
> [3] https://marc.info/?l=linux-mm&m=154533371911133
> [4] https://lore.kernel.org/linux-mm/20171228222419.GQ1871@rh
> [5] https://lore.kernel.org/linux-mm/20190603042637.2018-1-tobin@kernel.org
> [6] https://lwn.net/Articles/717650
> 
> -- 
> Cheers,
> Harry / Hyeonggon
> 

-- 
Dave Chinner
david@fromorbit.com

