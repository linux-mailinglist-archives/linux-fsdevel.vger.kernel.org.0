Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5C713AF2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgANQWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:22:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42054 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANQWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:22:40 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOxe-0086Ld-27; Tue, 14 Jan 2020 16:22:34 +0000
Date:   Tue, 14 Jan 2020 16:22:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: dcache: abstract take_name_snapshot() interface
Message-ID: <20200114162234.GZ8904@ZenIV.linux.org.uk>
References: <20200114154034.30999-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114154034.30999-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 05:40:34PM +0200, Amir Goldstein wrote:
> Generalize the take_name_snapshot()/release_name_snapshot() interface
> so it is possible to snapshot either a dentry d_name or its snapshot.
> 
> The order of fields d_name and d_inode in struct dentry is swapped
> so d_name is adjacent to d_iname.  This does not change struct size
> nor cache lines alignment.
> 
> Currently, we snapshot the old name in vfs_rename() and we snapshot the
> snapshot the dentry name in __fsnotify_parent() and then we pass qstr
> to inotify which allocated a variable length event struct and copied the
> name.
> 
> This new interface allows us to snapshot the name directly into an
> fanotify event struct instead of allocating a variable length struct
> and copying the name to it.

Ugh...  That looks like being too damn cute for no good reason.  That
trick with union is _probably_ safe, but I wouldn't bet a dime on
e.g. randomize_layout crap not screwing it over in random subset of
gcc versions.  You are relying upon fairly subtle reading of 6.2.7
and it feels like just the place for layout-mangling plugins to fuck
up.

With -fplan9-extensions we could go for renaming struct name_snapshot
fields and using an anon member in struct dentry -
	...
	struct inode *d_inode;
	struct name_snapshot;	// d_name and d_iname
	struct lockref d_lockref;
	...

but IMO it's much safer to have an explicit

// NOTE: release_dentry_name_snapshot() will be needed for both copies.
clone_name_snapshot(struct name_snapshot *to, const struct name_snapshot *from)
{
	to->name = from->name;
	if (likely(to->name.name == from->inline_name)) {
		memcpy(to->inline_name, from->inline_name,
			to->name.len);
		to->name.name = to->inline_name;
	} else {
                struct external_name *p;
                p = container_of(to->name.name, struct external_name, name[0]);
		atomic_inc(&p->u.count);
	}
}

and be done with that.  Avoids any extensions or tree-wide renamings, etc.
