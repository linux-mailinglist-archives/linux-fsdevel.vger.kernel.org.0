Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5E7270F61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgISQRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgISQRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 12:17:37 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4984C0613CE;
        Sat, 19 Sep 2020 09:17:36 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJfYF-001pPE-5f; Sat, 19 Sep 2020 16:17:27 +0000
Date:   Sat, 19 Sep 2020 17:17:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] fs: fix KMSAN uninit-value bug by
 initializing nd in do_file_open_root
Message-ID: <20200919161727.GG3421308@ZenIV.linux.org.uk>
References: <20200916052657.18683-1-anant.thazhemadam@gmail.com>
 <20200916054157.GC825@sol.localdomain>
 <20200917002238.GO3421308@ZenIV.linux.org.uk>
 <20200919144451.GF2712238@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919144451.GF2712238@kroah.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 19, 2020 at 04:44:51PM +0200, Greg KH wrote:

> > ->dir_uid and ->dir_mode are set when link_path_walk() resolves the pathname
> > to directory + final component.  They are used when deciding whether to reject
> > a trailing symlink (on fs.protected_symlinks setups) and whether to allow
> > creation in sticky directories (on fs.protected_regular and fs.protected_fifos
> > setups).  Both operations really need the results of successful link_path_walk().
> > 
> > I don't see how that could be not a false positive.  If we hit the use in
> > may_create_in_sticky(), we'd need the combination of
> > 	* pathname that consists only of slashes (or it will be initialized)
> > 	* LAST_NORM in nd->last_type, which is flat-out impossible, since
> > we are left with LAST_ROOT for such pathnames.  The same goes for
> > may_follow_link() use - we need WALK_TRAILING in flags to hit it in the
> > first place, which can come from two sources -
> >         return walk_component(nd, WALK_TRAILING);
> > in lookup_last() (and walk_component() won't go anywhere near the
> > call chain leading to may_follow_link() without LAST_NORM in nd->last_type)
> > and
> >         res = step_into(nd, WALK_TRAILING, dentry, inode, seq);
> > in open_last_lookups(), which also won't go anywhere near that line without
> > LAST_NORM in the nd->last_type.
> > 
> > IOW, unless we manage to call that without having called link_path_walk()
> > at all or after link_path_walk() returning an error, we shouldn't hit
> > that.  And if we *do* go there without link_path_walk() or with an error
> > from link_path_walk(), we have a much worse problem.
> > 
> > I want to see the details of reproducer.  If it's for real, we have a much
> > more serious problem; if it's a false positive, the right place to deal
> > with it would be elsewhere (perhaps on return from link_path_walk() with
> > a slashes-only pathname), but in any case it should only be done after we
> > manage to understand what's going on.
> 
> Reproducer is pretty simple:
> 	https://syzkaller.appspot.com/text?tag=ReproC&x=13974b2f100000
> 
> Now if that is actually valid or not, I don't know...

Lovely...  That would get an empty path and non-directory for a starting
point, but it should end up with LAST_ROOT in nd->last_type.  Which should
not be able to reach the readers of those fields...  Which kernel had
that been on?
