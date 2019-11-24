Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E728910850B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 22:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKXVOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 16:14:04 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40393 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfKXVOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 16:14:04 -0500
Received: by mail-il1-f196.google.com with SMTP id v17so8458314ilg.7;
        Sun, 24 Nov 2019 13:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPww5+cOuDYpyrq3eoOD8TwWjgjD6JOWOEc3I86mNlA=;
        b=CVuLpmb0cZp5N66wASY9+RBP4dVNryhhRKmp8YRw7vD/iJMn9KrVEcQpOEQvO/fUtW
         xrdXHpC+RuRRpme3apjIk1EFQHgQutg+svGQI/RjFhO/5gxL+BrSXUMQd1N/pNGEZlJO
         IScjajpr1PByQQQDIPDQd1JTEcqR4k1Lr2WISnpz6RbvnMH12iDD9zKefTgOforcMFA4
         zKeJ34k6SPVTrbZGJRy+5T4+2IFZ7u23BWfFbxZ/fMVdpQ7uYzoo6C4GOHNagNwPdXyT
         VywdPWbvJuOvZE9zY/hy/BqHzBGlPzLViubT6Rf93KDR/I/apAvpXB4RPzn2d41s/c2x
         Ngmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPww5+cOuDYpyrq3eoOD8TwWjgjD6JOWOEc3I86mNlA=;
        b=psRZIIRVbII//bMzXI3d1xmiNDkvxdqcqXQBfVroimjyPBMCCVV8Rqfdqc7pp+gAHt
         7EeDikMT6ZPdQT9Pi8I7aWl+DHMMdh7/FvdEEApE3SxrF5gCissuxSPrkqaaVoQkJklS
         mshghE/k0i/iXVERjqe7JvC/QHv56bc55dJWYxMRNzydFIWq6KrIHpc6of2/C85p66rh
         FzKGhr+efroWW/FgN6Dvf1lHxyhQmfn0jqmZlHUfhq3m/vaDGmMPO3oxTej64H4oTNZo
         WkMQgntzj//Mw7TNxuhVEaJS5K5GHtBo6Q1KAhR8naNdq20Vm4rbYQTQxN6m+bmhQm4N
         V/kQ==
X-Gm-Message-State: APjAAAXvHlNjiklHcBnOOVg97ysj8zd00Qq/B24hf193QX0HZgB7SaEJ
        HAH9O+FsleE8/phQ3uI90bdSl7krIDe5Vn4miFvV3Vxe
X-Google-Smtp-Source: APXvYqydeGSxHh2Ffw2ACullXHCtSdN4dejIYYQJDP6/idGpRy9AMGptuDN2C0Lik3WTlkLuDD3QXZF+x8ww+I7WFwM=
X-Received: by 2002:a92:690c:: with SMTP id e12mr28157291ilc.153.1574630042751;
 Sun, 24 Nov 2019 13:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20191124193145.22945-1-amir73il@gmail.com> <20191124194934.GB4203@ZenIV.linux.org.uk>
In-Reply-To: <20191124194934.GB4203@ZenIV.linux.org.uk>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 24 Nov 2019 13:13:50 -0800
Message-ID: <CABeXuvqZUK4UMLA=hU5i9r0k6G7E+RCi58Om-KVeZuA3OjL4fA@mail.gmail.com>
Subject: Re: [PATCH] utimes: Clamp the timestamps in notify_change()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 24, 2019 at 11:49 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Nov 24, 2019 at 09:31:45PM +0200, Amir Goldstein wrote:
> > Push clamping timestamps down the call stack into notify_change(), so
> > in-kernel callers like nfsd and overlayfs will get similar timestamp
> > set behavior as utimes.
>
> Makes sense; said that, shouldn't we go through ->setattr() instances and
> get rid of that there, now that notify_change() is made to do it?
>
> I mean,
>         if (ia_valid & ATTR_ATIME)
>                 sd_iattr->ia_atime = timestamp_truncate(iattr->ia_atime,
>                                                       inode);
> in configfs_setattr() looks like it should be reverted to
>         if (ia_valid & ATTR_ATIME)
>                 sd_iattr->ia_atime = iattr->ia_atime;
> with that, etc.
>
> Moreover, does that leave any valid callers of timestamp_truncate()
> outside of notify_change() and current_time()?  IOW, is there any
> point having it exported?  Look:
> fs/attr.c:187:          inode->i_atime = timestamp_truncate(attr->ia_atime,
> fs/attr.c:191:          inode->i_mtime = timestamp_truncate(attr->ia_mtime,
> fs/attr.c:195:          inode->i_ctime = timestamp_truncate(attr->ia_ctime,
>         setattr_copy(), called downstream of your changes.
> fs/configfs/inode.c:79:         sd_iattr->ia_atime = timestamp_truncate(iattr->ia_atime,
> fs/configfs/inode.c:82:         sd_iattr->ia_mtime = timestamp_truncate(iattr->ia_mtime,
> fs/configfs/inode.c:85:         sd_iattr->ia_ctime = timestamp_truncate(iattr->ia_ctime,
>         configfs_setattr(); ditto.
> fs/f2fs/file.c:755:             inode->i_atime = timestamp_truncate(attr->ia_atime,
> fs/f2fs/file.c:759:             inode->i_mtime = timestamp_truncate(attr->ia_mtime,
> fs/f2fs/file.c:763:             inode->i_ctime = timestamp_truncate(attr->ia_ctime,
>         __setattr_copy() from f2fs_setattr(); ditto.
> fs/inode.c:2224:        return timestamp_truncate(now, inode);
>         current_time()
> fs/kernfs/inode.c:163:  inode->i_atime = timestamp_truncate(attrs->ia_atime, inode);
> fs/kernfs/inode.c:164:  inode->i_mtime = timestamp_truncate(attrs->ia_mtime, inode);
> fs/kernfs/inode.c:165:  inode->i_ctime = timestamp_truncate(attrs->ia_ctime, inode);
>         ->s_time_max and ->s_time_min are left TIME64_MAX and TIME64_MIN resp., so
> timestamp_truncate() should be a no-op there.
> fs/ntfs/inode.c:2903:           vi->i_atime = timestamp_truncate(attr->ia_atime,
> fs/ntfs/inode.c:2907:           vi->i_mtime = timestamp_truncate(attr->ia_mtime,
> fs/ntfs/inode.c:2911:           vi->i_ctime = timestamp_truncate(attr->ia_ctime,
>         ntfs_setattr(); downstream from your changes
> fs/ubifs/file.c:1082:           inode->i_atime = timestamp_truncate(attr->ia_atime,
> fs/ubifs/file.c:1086:           inode->i_mtime = timestamp_truncate(attr->ia_mtime,
> fs/ubifs/file.c:1090:           inode->i_ctime = timestamp_truncate(attr->ia_ctime,
>         do_attr_changes(), from do_truncation() or do_setattr(), both from ubifs_setattr();
> ditto.
> fs/utimes.c:39:                 newattrs.ia_atime = timestamp_truncate(times[0], inode);
> fs/utimes.c:46:                 newattrs.ia_mtime = timestamp_truncate(times[1], inode);
>         disappears in your patch.

We also want to replace all uses of timespec64_trunc() with
timestamp_truncate() for all fs cases.

In that case we have a few more:

fs/ceph/mds_client.c:   req->r_stamp = timespec64_trunc(ts,
mdsc->fsc->sb->s_time_gran);
fs/cifs/inode.c:        fattr->cf_mtime =
timespec64_trunc(fattr->cf_mtime, sb->s_time_gran);
fs/cifs/inode.c:                fattr->cf_atime =
timespec64_trunc(fattr->cf_atime, sb->s_time_gran);
fs/fat/misc.c:static inline struct timespec64
fat_timespec64_trunc_2secs(struct timespec64 ts)
fs/fat/misc.c:                  inode->i_ctime =
timespec64_trunc(*now, 10000000);
fs/fat/misc.c:                  inode->i_ctime =
fat_timespec64_trunc_2secs(*now);
fs/fat/misc.c:          inode->i_mtime = fat_timespec64_trunc_2secs(*now);
fs/ubifs/sb.c:  ts = timespec64_trunc(ts, DEFAULT_TIME_GRAN);

These do not follow from notify_change(), so these might still need
timestamp_truncate() exported.
I will post a cleanup series for timespec64_trunc() also, then we can decide.

-Deepa
