Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96C940301E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 23:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346913AbhIGVKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 17:10:47 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:49372 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344715AbhIGVKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:10:47 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNiLb-0027k6-FO; Tue, 07 Sep 2021 21:09:39 +0000
Date:   Tue, 7 Sep 2021 21:09:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] namei: fix use-after-free and adjust calling
 conventions
Message-ID: <YTfVE7IbbTV71Own@zeniv-ca.linux.org.uk>
References: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 01, 2021 at 10:51:40AM -0700, Stephen Brennan wrote:
> Drawing from the comments on the last two patches from me and Dmitry,
> the concensus is that __filename_parentat() is inherently buggy, and
> should be removed. But there's some nice consistency to the way that
> the other functions (filename_create, filename_lookup) are named which
> would get broken.
> 
> I looked at the callers of filename_create and filename_lookup. All are
> small functions which are trivial to modify to include a putname(). It
> seems to me that adding a few more lines to these functions is a good
> traedoff for better clarity on lifetimes (as it's uncommon for functions
> to drop references to their parameters) and better consistency.
> 
> This small series combines the UAF fix from me, and the removal of
> __filename_parentat() from Dmitry as patch 1. Then I standardize
> filename_create() and filename_lookup() and their callers.

	For kern_path_locked() itself, I'd probably go for

static struct dentry *__kern_path_locked(struct filename *name, struct path *path)
{
        struct dentry *d;
        struct qstr last;
        int type, error;

        error = filename_parentat(AT_FDCWD, name, 0, path,
                                    &last, &type);
        if (error)
                return ERR_PTR(error);
        if (unlikely(type != LAST_NORM)) {
                path_put(path);
                return ERR_PTR(-EINVAL);
        }
        inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
        d = __lookup_hash(&last, path->dentry, 0);
        if (IS_ERR(d)) {
                inode_unlock(path->dentry->d_inode);
                path_put(path);
        }
        return d;
}

static struct dentry *kern_path_locked(const char *name, struct path *path)
{
	struct filename *filename = getname_kernel(name);
	struct dentry *res = __kern_path_locked(filename, path);

	putname(filename);
	return res;
}

instead of that messing with gotos - and split renaming from fix in that
commit.  In 3/3 you have a leak; trivial to fix, fortunately.

Another part I really dislike in that area (not your fault, obviously)
is

void putname(struct filename *name)
{
        if (IS_ERR_OR_NULL(name))
		return;

in mainline right now.  Could somebody explain when the hell has NULL
become a possibility here?  OK, I buy putname(ERR_PTR(...)) being
a no-op, but IME every sodding time we mixed NULL and ERR_PTR() in
an API we ended up with headache later.

	IS_ERR_OR_NULL() is almost always wrong.  NULL as argument
for destructor makes sense when constructor can fail with NULL;
not the case here.

	How about the variant in vfs.git#misc.namei?
