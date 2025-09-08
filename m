Return-Path: <linux-fsdevel+bounces-60473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97522B4830F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 05:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE03D17DE33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 03:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B16B1946AA;
	Mon,  8 Sep 2025 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QcB/joEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7405C4964E
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757303833; cv=none; b=lGhZTYpMLkIR3NxQOgL6QaM4InhIMSvuVdP1vJ0BmXYWjL4kISRYrVtoh45fvbv21sLP9TNcHi9WlgVQQLgptwU+8maK787orkrlO3tgYzS5U7bs6IxUMpRR3N/jg/l38RGUKHjVEVRoUNw6Ky1q26DZBdilxxCPDKs1DCAQkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757303833; c=relaxed/simple;
	bh=OLBk/jrfOa1dE0Po39RPN7qc/GZAno8eB4D/xe/OPkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvdbaJ1NPi40Ni9WFCCZYaZk8vWF6fxqQXG4vxzllIZvMttq2l/p2AV0MT1A2Q/p1gRuh/Fg6mBzlRRo/Nnai1FYnlSREGtOCYL3jpk2shMAzyu0VqdqIsYKFHdHKTwYEE/4o+N5IeHHVGCCQtHHUlPFLeaj4MZSuv7s2nYo+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QcB/joEM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0U/zNkMbvcv5y5v13i1J8hFYz5vDbsxl4Wz9twDgyE4=; b=QcB/joEMZNjplKAW5AB9Jh867m
	vHn39NCyBY6x+frO5o0iYDVUXD/wWmEv9mfYITR/jJ/BkoFeLXFuj7zcQsKsl+3gyMoXfpOsCJ894
	aZr8JHB/gX9Og3DNVa6vt71VDQA5nSACwS5sM5udLJ3mKnUSO9Dki9PFsmC15HXEAVAnt/DdGm5Pf
	rAP7fiz3IcBeVb87a5mdc24znhPTpSX4UdfxY76XlGV2QR0V4L48N+nnHKmSO13g9Ijg55C/vR59N
	DD0L4cCctI8N05P0SwfYMiL496TCy5mXg0c48A+ylZxsY6KF0xDGE659WA5LD544m3picSpH7txWn
	VsyrHeyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvT08-0000000DIIT-0a1O;
	Mon, 08 Sep 2025 03:57:08 +0000
Date: Mon, 8 Sep 2025 04:57:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
Message-ID: <20250908035708.GH31600@ZenIV>
References: <20250907203255.GE31600@ZenIV>
 <CAHk-=wif3NXNMmTERKnmDjDBSbY3qdFgd5ScWTwZaZg0NFACUw@mail.gmail.com>
 <20250908000617.GF31600@ZenIV>
 <CAHk-=wiDHb4Q4tJwOJqDYJd=L_0kJeYrYq3x0W9fEpDcUoCQHA@mail.gmail.com>
 <20250908025135.GG31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908025135.GG31600@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 08, 2025 at 03:51:35AM +0100, Al Viro wrote:
 
> Most of the uses *are* done to stable dentries; it's just that we have no
> way to tell which ones are like that.

Random example to get the taste of that joy:

static void
xfs_dentry_to_name( 
        struct xfs_name *namep,
        struct dentry   *dentry)
{
        namep->name = dentry->d_name.name;
        namep->len = dentry->d_name.len;
        namep->type = XFS_DIR3_FT_UNKNOWN;
}

OK, fetches from ->d_name.  Callers:
	xfs_cleanup_inode()
		xfs_generic_create()
			xfs_vn_mknod()
				== xfs_dir_inode_operations.mknod
				== xfs_dir_ci_inode_operations.mknod
			xfs_vn_create()
				== xfs_dir_inode_operations.create
				== xfs_dir_ci_inode_operations.create
			xfs_vn_mkdir()
				== xfs_dir_inode_operations.mkdir
				== xfs_dir_ci_inode_operations.mkdir
			xfs_vn_tmpfile()	# WTF?
		xfs_vn_symlink()
			== xfs_dir_inode_operations.symlink
			== xfs_dir_ci_inode_operations.symlink
	xfs_vn_lookup()
		== xfs_dir_inode_operations.lookup
	xfs_vn_ci_lookup()
		== xfs_dir_ci_inode_operations.lookup
	xfs_vn_unlink()
		== xfs_dir_inode_operations.unlink
		== xfs_dir_inode_operations.rmdir
		== xfs_dir_ci_inode_operations.unlink
		== xfs_dir_ci_inode_operations.rmdir
(+ checking that in all cases dentry has come from the method argument)
WTF is going on with xfs_vn_tmpfile()?  It doesn't *have* any useful
name... looking... Aha.  vfs_generic_create(_, _, _, _, _, p) only calls
xfs_cleanup_inode() in case when p is NULL; xfs_vn_tmpfile() is called
only as ->tmpfile(), and the only caller of that is this:
        file->f_path.mnt = parentpath->mnt;
        file->f_path.dentry = child;
        mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
        error = dir->i_op->tmpfile(idmap, dir, file, mode);
so the method never gets called with NULL as the 3rd argument.  Safe...

And that's just one example - two grep hits.  Right next to them,
static int
xfs_dentry_mode_to_name(
        struct xfs_name *namep,
        struct dentry   *dentry,
        int             mode)
{
        namep->name = dentry->d_name.name;
        namep->len = dentry->d_name.len;
        namep->type = xfs_mode_to_ftype(mode);
 
        if (unlikely(namep->type == XFS_DIR3_FT_UNKNOWN))
                return -EFSCORRUPTED;
 
        return 0;
}

Callers:
	xfs_generic_create()
		same callers as above, but this time it's *not* conditional:
------------------------------------------------------------------
        /* Verify mode is valid also for tmpfile case */
        error = xfs_dentry_mode_to_name(&name, dentry, args.mode);
        if (unlikely(error))
                goto out_free_acl;
------------------------------------------------------------------
		presumably it's "we may fetch shite for tmpfile, but in that case
		we won't use that shite".
	xfs_vn_link()
		== xfs_dir_inode_operations.link
		== xfs_dir_ci_inode_operations.link
	xfs_vn_symlink()
		seen above, same dentry as above
	xfs_vn_rename()	# for odentry
		== xfs_dir_inode_operations.rename
		== xfs_dir_ci_inode_operations.rename
	xfs_vn_rename() # for ndentry
		seen above

That's not all for xfs, though - there's also
        error = xfs_inode_init_security(inode, dir, &dentry->d_name);
in the same xfs_generic_create() - and also called for tmpfile case,
AFAISC.  Which is quite likely a bug - ->d_name is stable there, all
right, but at that stage it's "/"; what selinux (the only thing that
cares about the basename of object being created) would do to that
is an interesting question, might depend upon the policy.  Non-tmpfile
callers are OK, as seen above.
Another one:
        error = xfs_inode_init_security(inode, dir, &dentry->d_name);
in xfs_vn_symlink(), safe per above.
Another:
        if (dentry->d_name.len >= MAXNAMELEN)
                return ERR_PTR(-ENAMETOOLONG);
in xfs_vn_lookup() and xfs_vn_ci_lookup().  Safe.

... and finally there's this, in all its foul glory:
DECLARE_EVENT_CLASS(xrep_dentry_class,
        TP_PROTO(struct xfs_mount *mp, const struct dentry *dentry),
        TP_ARGS(mp, dentry),
        TP_STRUCT__entry(
                __field(dev_t, dev)
                __field(unsigned int, flags)
                __field(unsigned long, ino)
                __field(bool, positive)
                __field(unsigned long, parent_ino)
                __field(unsigned int, namelen)
                __dynamic_array(char, name, dentry->d_name.len)
        ),
        TP_fast_assign(
                __entry->dev = mp->m_super->s_dev;
                __entry->flags = dentry->d_flags;
                __entry->positive = d_is_positive(dentry);
                if (dentry->d_parent && d_inode(dentry->d_parent))
                        __entry->parent_ino = d_inode(dentry->d_parent)->i_ino;
                else
                        __entry->parent_ino = -1UL;
                __entry->ino = d_inode(dentry) ? d_inode(dentry)->i_ino : 0;
                __entry->namelen = dentry->d_name.len;
                memcpy(__get_str(name), dentry->d_name.name, dentry->d_name.len);
        ),
        TP_printk("dev %d:%d flags 0x%x positive? %d parent_ino 0x%lx ino 0x%lx name '%.*s'",
                  MAJOR(__entry->dev), MINOR(__entry->dev),
                  __entry->flags,
                  __entry->positive,
                  __entry->parent_ino,
                  __entry->ino,
                  __entry->namelen,
                  __get_str(name))
);
#define DEFINE_REPAIR_DENTRY_EVENT(name) \
DEFINE_EVENT(xrep_dentry_class, name, \
        TP_PROTO(struct xfs_mount *mp, const struct dentry *dentry), \
        TP_ARGS(mp, dentry))
DEFINE_REPAIR_DENTRY_EVENT(xrep_adoption_check_child);
DEFINE_REPAIR_DENTRY_EVENT(xrep_adoption_invalidate_child);
DEFINE_REPAIR_DENTRY_EVENT(xrep_dirtree_delete_child);

used by
                trace_xrep_adoption_check_child(sc->mp, d_child);
in xrep_adoption_check_dcache(), two calls of
                trace_xrep_adoption_invalidate_child(sc->mp, d_child);
in xrep_adoption_zap_dcache() and 
        trace_xrep_dirtree_delete_child(dp->i_mount, child_dentry);
in xrep_dirtree_purge_dentry()

The last 3 are *not* stable - fuck knows if they can happen in parallel with
lookups from other threads (those can end up moving dentries on sufficiently
buggered filesystem), but IMO these deserve take_dentry_name_snapshot()
treatment - if tracepoint is active, that is.

The rest all get stable dentries; I would really prefer to have that checked
by compiler, with sufficient annotations given to it.  In this case -
struct stable_dentry arguments for lookup/create/mkdir/mknod/symlink/unlink/rmdir,
rename and link as part of calling conventions change
+ stable_dentry as argument of xfs_generic_create(), xfs_dentry_mode_to_name(),
xfs_dentry_to_name() and xfs_cleanup_inode()
+ claim of stability in xfs_vn_tmpfile():
STATIC int
xfs_vn_tmpfile(
        struct mnt_idmap        *idmap,
        struct inode            *dir,
        struct file             *file,
        umode_t                 mode)
{
	int err = xfs_generic_create(idmap, dir,
			claim_stability(file->f_path.dentry), mode, 0, file);
	// at this point in ->tmpfile() dentry is nameless and negative;
	// nothing can move it until we get to finish_open_...()
        return finish_open_simple(file, err);
}

That way xfs hits will be down to that claim_stability() and the obscenity in
trace.h - until the users of the latter get wrapped into something that would
take snapshots and pass those instead of messing with ->d_name.  Considering
the fun quoted above, not having to repeat that digging is something I'd
count as a win...

