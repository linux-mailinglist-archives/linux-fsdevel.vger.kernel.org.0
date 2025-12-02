Return-Path: <linux-fsdevel+bounces-70432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D757FC9A23C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 06:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7713A5D6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 05:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDAA2FD1C5;
	Tue,  2 Dec 2025 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j9siMMf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB42FCC1A;
	Tue,  2 Dec 2025 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654769; cv=none; b=I4VyC4c3+oVsJ04M5ADwrHyeIB4SyfTlMTeftK4ZijMrjc/zSAICpXlrpPB9tfPxxstPaEIrv9Zsp/d372GmHBv98yamaIud2XdAzMsSXkzHgpeV0o0kk3wB1nELBZxsvFl5J0rFoKuM0VLhN18ytm0GxK1zuqlFSHbPVz4X7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654769; c=relaxed/simple;
	bh=otP5m2cNMu9eSQBr0fEkqAfYITaHSarao1zEWigZ8lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViUAlbRJSDODrAhNEQpbMHHJXMjk7Ut7jrRpaJXcAILfzdDycNCRhculNmxocYz7341hDphEH+hnnoRImqkRbrkKxV7Sj7cwYV+nEdqWylvDMuICZ5wqdhmCIrRv5mFCHo4ILL2o4kV8e5i0LltX5gHx1hehyKE53LFR6/lXWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=j9siMMf9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S1CHysVLD7nrhw5ZkUxFSp2LWKqMTybxQgVRhqkl6rc=; b=j9siMMf9kJ71JsJ0Lh0wAJpOrv
	/W6O3tYM+hqXSbI4rw/oJD9UFj9ehX5qCLpkJVucwFMy7HLZgNJBuEKGBQSpmbA+hPSQ6CBkKRAH5
	c9j/KnXj6N6+/wNW503HXXFaaFanuupf8HwKAcAeSnsiUV1t/ljayRqlvJmxvaP//usKCuxeX6AbF
	orz/0BUkjrZ9M6jFLbXOxHppVdYEiHmoLI/zNA3HDSiMO3Rmks1VADuuNUPpxJ7661cWfWf27YfQa
	bVA0oHnyDAlZFCW2PuylE6gaywGZe/25KXqzyRg+EI+5L3zyaufq2Hu7qTm4LnEkgxvovTUFncx5w
	VerXW3uQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQJJq-00000002WhE-2mla;
	Tue, 02 Dec 2025 05:52:58 +0000
Date: Tue, 2 Dec 2025 05:52:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: hide names_cache behind runtime const machinery
Message-ID: <20251202055258.GB1712166@ZenIV>
References: <20251201083226.268846-1-mjguzik@gmail.com>
 <20251201085117.GB3538@ZenIV>
 <20251202023147.GA1712166@ZenIV>
 <CAGudoHGbYvSAq=eJySxsf-AqkQ+ne_1gzuaojidA-GH+znw2hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGbYvSAq=eJySxsf-AqkQ+ne_1gzuaojidA-GH+znw2hw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 02, 2025 at 06:10:36AM +0100, Mateusz Guzik wrote:

> So IIUC whatever APIs aside, the crux of this idea is to have
> kmem_cache objs defined instead of having pointers to them, as in:
> -struct kmem_cache *names_cachep __ro_after_init;
> +struct kmem_cache names_cachep __ro_after_init;

Huh?  __ro_after_init will break instantly - the contents changes with
each allocation, after all.  What I want is
static struct kmem_cache_store names_cache;

As for the many places to modify...

fs/file.c:390:  newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
fs/file.c:422:                  kmem_cache_free(files_cachep, newf);
fs/file.c:514:          kmem_cache_free(files_cachep, files);
include/linux/fdtable.h:116:extern struct kmem_cache *files_cachep;
kernel/fork.c:429:struct kmem_cache *files_cachep;
kernel/fork.c:2987:     files_cachep = kmem_cache_create("files_cache",
samples/kmemleak/kmemleak-test.c:52:    pr_info("kmem_cache_alloc(files_cachep) = 0x%px\n",
samples/kmemleak/kmemleak-test.c:53:            kmem_cache_alloc(files_cachep, GFP_KERNEL));
samples/kmemleak/kmemleak-test.c:54:    pr_info("kmem_cache_alloc(files_cachep) = 0x%px\n",
samples/kmemleak/kmemleak-test.c:55:            kmem_cache_alloc(files_cachep, GFP_KERNEL));

I would argue for making it static in fs/file.c, where we have the grand
total of 3 places using the sucker, between two functions.

dentry_cache:
fs/dcache.c:345:        kmem_cache_free(dentry_cache, dentry); 
fs/dcache.c:352:        kmem_cache_free(dentry_cache, dentry);
fs/dcache.c:1690:       dentry = kmem_cache_alloc_lru(dentry_cache, &sb->s_dentry_lru,
fs/dcache.c:1711:                       kmem_cache_free(dentry_cache, dentry); 
fs/dcache.c:1748:                       kmem_cache_free(dentry_cache, dentry);

5 lines, between 3 functions (__d_free(), __d_free_external(), __d_allock()).

mnt_cache:
fs/namespace.c:293:     struct mount *mnt = kmem_cache_zalloc(mnt_cache, GFP_KERNEL);
fs/namespace.c:342:     kmem_cache_free(mnt_cache, mnt);
fs/namespace.c:737:     kmem_cache_free(mnt_cache, mnt);

3 lines, alloc_vfsmnt() and free_vfsmnt()

sock_inode_cachep:
net/socket.c:322:       ei = alloc_inode_sb(sb, sock_inode_cachep, GFP_KERNEL);
net/socket.c:343:       kmem_cache_free(sock_inode_cachep, ei);

2 lines, sock_alloc_inode() and sock_free_inode() (sockets are coallocated with
inodes).

struct filename: two lines after that series.

task_struct_cachep:
kernel/fork.c:184:      return kmem_cache_alloc_node(task_struct_cachep, GFP_KERNEL, node);
kernel/fork.c:189:      kmem_cache_free(task_struct_cachep, tsk);

and so it goes; that's the sane pattern - you want few places where objects of given
type are allocated and freed, so that tracing the callchains would be feasible.
names_cachep used to be shitty in that respect, what with its abuse by weird __getname()
callers.  It's not the common situation, thankfully.

The delicate part is headers, indeed - we don't want to expose struct kmem_cache guts
anywhere outside of mm/*, and not the entire mm/* either.  But that's not hard to
deal with - see include/generate/bounds.h, include/generate/rq-offsets.h, etc.
Exact same technics can be used to get sizeof(struct kmem_cache) calculated and
put into generated header.  Then we get something like struct kmem_cache_store with
the right size and alignment, and _that_ would be what the variables would be.
With static inline struct kmem_cache *to_kmem_cache(struct kmem_cache_store *)
returning a cast and e.g.

static inline void free_filename(struct __filename *p)
{
        kmem_cache_free(to_kmem_cache(&names_cache), p);
}

as an example of use.

Anyway, for now I've applied your patch pretty much as-is; conversion of the
sort described above can be done afterwards just fine.

