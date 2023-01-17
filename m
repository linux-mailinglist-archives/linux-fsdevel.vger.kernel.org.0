Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB527670C32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 23:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjAQWyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 17:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjAQWxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:53:38 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB12A7334
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 13:45:01 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so267289pjm.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 13:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=USmZ3gy1BtrvJEjQBDI3lCph9qcXhvk22Q1eYhBS7oY=;
        b=RzlLBPcasIN4kEzbfwMjk5cRM6RzwFCQycQzVF/x4CvKYodGJqRrS9P5q74WNvc6Im
         sDWvEIyNad70vlaiE6T40dRq5QUvZXsqoq0NXlZB7cmswZRDhil02hlp0EswfhbYDaUk
         pd/nv9SJeu522LsTq6VLRAhoTLIvaozFDG5jLwWqU3xOBIqEgBYVlWWKsrSzSeARYQR4
         y78EEbm0a5Q6LDKTJy99roURs/IxG5iRb0G4vxXbkZX8afv5Jnrinw0ihUUqjURO6eUv
         FubRf20KyCuUdR73WoBP8CQ1GMNILJs936p5zQJtUZNrm02T05XIEZDWRpoeFnX0UPQ0
         wPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USmZ3gy1BtrvJEjQBDI3lCph9qcXhvk22Q1eYhBS7oY=;
        b=tMDjOSx84KlLHmIgAyAnXcV3hHR3QliR0n81KIIeN1rhqJoWgHJGwopze7D0/9jzdE
         1XtYl6aW66UwQfNxJDDlZ4OAjIfEYN1YBhtV33nLSCvKQt04F/qXtOMh0xqMCpvJQAfQ
         IHPY4mFjzkSjXFEWNRb/kHzBbBkUmxEBBYH9a6/fsXJa96vmRXpDhsYhhVNoX1E3+66Z
         AliHD1NTesd+ngSXyl24GIM3Ns2AVIgi8c6AtN4+D9yOH1hnXxapI0rQ9jXUyPIt0bKB
         mtD+niUMC8UR7PVmjz60Cxpd5TSR2S93gNpoQUtPt7ZyWdsCgw6sPL0iaGJYI753PMXl
         pKMw==
X-Gm-Message-State: AFqh2koI9ug7O+eoBkvTrLrWzObCnFhcGZi8E/J69nO7cVdaN40shrSd
        BJSJFLgGVzHO6zkwSsXvCRvnmw==
X-Google-Smtp-Source: AMrXdXsjLWlijwip6i3qxiUNT6rq/EuKFl3lJ7Oc5PLOZ9TkVQf8fY86eptlCDPi8YvH3xl+tGL+uQ==
X-Received: by 2002:a17:903:1ce:b0:193:29db:e0b7 with SMTP id e14-20020a17090301ce00b0019329dbe0b7mr6977692plh.54.1673991900952;
        Tue, 17 Jan 2023 13:45:00 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b00189fd83eb95sm21754927plg.69.2023.01.17.13.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:45:00 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pHtlJ-004Ivt-MX; Wed, 18 Jan 2023 08:44:57 +1100
Date:   Wed, 18 Jan 2023 08:44:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <20230117214457.GG360264@dread.disaster.area>
References: <20230117123735.un7wbamlbdihninm@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117123735.un7wbamlbdihninm@quack3>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 01:37:35PM +0100, Jan Kara wrote:
> Hello!
> 
> I've some across an interesting issue that was spotted by syzbot [1]. The
> report is against UDF but AFAICS the problem exists for ext4 as well and
> possibly other filesystems. The problem is the following: When we are
> renaming directory 'dir' say rename("foo/dir", "bar/") we lock 'foo' and
> 'bar' but 'dir' is unlocked because the locking done by vfs_rename() is
> 
>         if (!is_dir || (flags & RENAME_EXCHANGE))
>                 lock_two_nondirectories(source, target);
>         else if (target)
>                 inode_lock(target);
> 
> However some filesystems (e.g. UDF but ext4 as well, I suspect XFS may be
> hurt by this as well because it converts among multiple dir formats) need
> to update parent pointer in 'dir' and nothing protects this update against
> a race with someone else modifying 'dir'. Now this is mostly harmless
> because the parent pointer (".." directory entry) is at the beginning of
> the directory and stable however if for example the directory is converted
> from packed "in-inode" format to "expanded" format as a result of
> concurrent operation on 'dir', the filesystem gets corrupted (or crashes as
> in case of UDF).

No, xfs_rename() does not have this problem - we pass four inodes to
the function - the source directory, source inode, destination
directory and destination inode.

In the above case, "dir/" is passed to XFs as the source inode - the
src_dir is "foo/", the target dir is "bar/" and the target inode is
null. src_dir != target_dir, so we set the "new_parent" flag. the
srouce inode is a directory, so we set the src_is_directory flag,
too.

We lock all three inodes that are passed. We do various things, then
run:

        if (new_parent && src_is_directory) {
                /*
                 * Rewrite the ".." entry to point to the new
                 * directory.
                 */
                error = xfs_dir_replace(tp, src_ip, &xfs_name_dotdot,
                                        target_dp->i_ino, spaceres);
                ASSERT(error != -EEXIST);
                if (error)
                        goto out_trans_cancel;
        }

which replaces the ".." entry in source inode atomically whilst it
is locked.  Any directory format changes that occur during the
rename are done while the ILOCK is held, so they appear atomic to
outside observers that are trying to parse the directory structure
(e.g. readdir).

> So we'd need to lock 'source' if it is a directory.

Yup, and XFS goes further by always locking the source inode in a
rename, even if it is not a directory. This ensures the inode being
moved cannot have it's metadata otherwise modified whilst the rename
is in progress, even if that modification would have no impact on
the rename. It's a pretty strict interpretation of "rename is an
atomic operation", but it avoids accidentally missing nasty corner
cases like the one described above...

> Ideally this would
> happen in VFS as otherwise I bet a lot of filesystems will get this wrong
> so could vfs_rename() lock 'source' if it is a dir as well? Essentially
> this would amount to calling lock_two_nondirectories(source, target)
> unconditionally but that would become a serious misnomer ;). Al, any
> thought?

XFS just has a function that allows for an arbitrary number of
inodes to be locked in the given order: xfs_lock_inodes(). For
rename, the lock order is determined by xfs_sort_for_rename().

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
