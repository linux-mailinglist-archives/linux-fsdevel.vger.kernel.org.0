Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563A05B653B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 03:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIMBvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 21:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIMBvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:51:31 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A776B4F6A5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 18:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FSsJC2i+ECVQwuPKAM0y/3FEn/+K9aO/VlkPkNDnN2w=; b=XwQaliiXzXeRgYVPOb8wR9wU9K
        QahcK0OvNclBjwlYU3XiPsQNPXAjL1FEutm5S7yivVc446YYh2/Jze3AvwYlMmZWiYWydHaKJityk
        5KDei9fTlPoVcK50xoIckNvtf636GJzeeg9d3hPa1rPsyJ67cwaOt3JSVrngwv4Oi73XdP0laZTjm
        zCO6kjVXVhOwc916xETdb2GM+UTU/m1tw2AQRi6n8qdxmK/yHxsMBdMj0XrcUXUGzC5uAYe7pUUtM
        3CBus9ZId2B/j40vkJTRBAmM3UPsFTXokIkbV//jhKP6LW+3wzyAe3PR3wOPA1I5OX9M1hty/K+Qn
        WsrubkPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oXv57-00Fgv4-2o;
        Tue, 13 Sep 2022 01:51:21 +0000
Date:   Tue, 13 Sep 2022 02:51:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Yu-li Lin <yulilin@google.com>, chirantan@chromium.org,
        dgreid@chromium.org, fuse-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, suleiman@chromium.org
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
Message-ID: <Yx/iGX+xGdqlnH73@ZenIV>
References: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
 <20220831025704.240962-1-yulilin@google.com>
 <CAJfpegvMGxigBe=3tgwBRKuSS0H1ey=0WhOkgOz5di-LqXH-HQ@mail.gmail.com>
 <CAMW0D+epkBMTEzzJhkX7HeEepCH=yxJ-rytnA+XWQ8ao=CREqw@mail.gmail.com>
 <YxYbCt4/S4r2JHw2@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxYbCt4/S4r2JHw2@miu.piliscsaba.redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 05, 2022 at 05:51:38PM +0200, Miklos Szeredi wrote:
> On Wed, Aug 31, 2022 at 02:30:40PM -0700, Yu-li Lin wrote:
> > Thanks for the reference. IIUC, the consensus is to make it atomic,
> > although there's no agreement on how it should be done. Does that mean
> > we should hold off on
> > this patch until atomic temp files are figured out higher in the stack
> > or do you have thoughts on how the fuse uapi should look like prior to
> > the vfs/refactoring decision?
> 
> Here's a patch refactoring the tmpfile kapi to return an open file instead of a
> dentry.
> 
> Comments?

First and foremost: how many operations the interested filesystems (cifs,
for one) are capable of for such beasts?  I can believe that FUSE can handle
that, but can something like cifs do it?  Their protocol is pathname-based, IIRC;
can they really handle that kind of files without something like sillyrename?
Because if sillyrename and its analogues are in the game, we have seriously
changed rules re directory locking, and we'd better figure that out first.

IOW, I would really like to see proposed instances for FUSE and CIFS - the shape
of the series seriously depends upon that.  Before we commit to calling conventions
changes.

That aside, some notes on the patch:

* file->f_path.dentry all over the place is ugly and wrong.  If nothing else,
d_tmpfile() could be converted to taking struct file * - nothing outside of
->tmpfile() instances is using it.
* finish_tmpfile() parts would be less noisy if it was finish_tmpfile(file, errror),
starting with if (error) return error;
* a bit of weirdness in ext4:
>  	err = dquot_initialize(dir);
>  	if (err)
> -		return err;
> +		goto out;
Huh?  Your out: starts with if (err) return err;  Sure, compiler
will figure it out, but what have human readers done to you?
* similar in shmem:
> +out:
> +	if (error)
> +		return error;
> +
> +	return finish_tmpfile(file);
>  out_iput:
>  	iput(inode);
> -	return error;
> +	goto out;
How the hell would it ever get to out_iput: with error == 0?
* in your vfs_tmpfile() wrapper
> +	child = ERR_CAST(file);
> +	if (!IS_ERR(file)) {
> +		error = vfs_tmpfile_new(mnt_userns, path, file, mode);
> +		child = error ? ERR_PTR(error) : dget(file->f_path.dentry);
> +		fput(file);
> +	}
> +	return child;
This really ought to be
	if (IS_ERR(file))
		return ERR_CAST(file);
	...
IS_ERR() comes with implicit unlikely()...


Next, there are users outside of do_o_tmpfile().  The one in cachefiles
is a prime candidate for combining with open - the stuff done between
vfs_tmpfile() and opening the sucker consists of
	* cachefiles_ondemand_init_object() - takes no cleanup on
later failure exits, doesn't know anything about dentry created.  Might
as well be done before vfs_tmpfile().
	* cachefiles_mark_inode_in_use() - which really can't fail there,
and the only thing being done is marking the sucker with S_KERNEL_FILE.
Could be done after opening just as well.
	* vfs_truncate() used to expand to required size.  Trivially done
after opening, and we probably want struct file there - there's a reason
why ftruncate(2) sets ATTR_FILE/ia_file...  We are unlikely to use
anything like FUSE for cachefiles, but leaving traps like that is a bad
idea.
IOW, cachefiles probably wants a preliminary patch series that would
massage it to the "tmpfile right next to open, the use struct file"
form.


Another user is overlayfs, and that's going to get painful.  It checks for
->tmpfile() working and if it does work, we use it for copyup.  The trouble
is, will e.g. FUSE be ready to handle things like setxattr on such dentries?
It's not just a matter of copying the data - there we would be quite fine
with opened file; it's somewhat clumsy since copyup is done for FIFOs, etc.,
but that could be dealt with.  But things like setting metadata are done
by dentry there.  And with your patch the file will have been closed by
the time we get to that part.  Can e.g. FUSE deal with that?
