Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C2C6AA850
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 07:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCDG25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 01:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDG24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 01:28:56 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48966D51D
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 22:28:55 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h19so5336102qtk.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 22:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112; t=1677911334;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ZhmyOntrOjkxmgZEANs8FAUrxpW6skJgTb+tVElklU=;
        b=0OeMTbSZgBh+ZyunBH7xpBZFolRx1a8OaS5kt4r2FSl4Ggf3ZUuYQwQIN0GB09tzcj
         u9TqnvUgYAdiLqlvk1mgdiFagzZh+rG3r8LMeuvETcy4scAzDZxSWmFIfZdcrdRxiKxz
         Lxgp7sj48McHA2gwPQ9JTFZT0j8cTvCNkipQLQLXQbkP47XksJisWOoDJP1bOudWzrzB
         L8Rzm/Oef2psIVtAWdhFcVt82PscSmhsY8tEgux5IDEvRzZRMpBggbNLTuaNm6uFh3A9
         ECY9m40u59CKfp16q7UoeDe7oXIvgJ0fOMLoyS/Blp0oc7FTUAi0YSF7OHqTmo+qvBuQ
         8L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677911334;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZhmyOntrOjkxmgZEANs8FAUrxpW6skJgTb+tVElklU=;
        b=Tz6ZJxC4a+Y4KMy94yj1n9yxIR0v3DsPZ9db19t9HR9DZ9cGXz7RTs/K11KHBK2KOj
         3MVsByyL54q0yGrmhEnhRWA3tPfj/59ngzYMn2N26uQFf6ncalDOuacdwJRHVwlY3Ef3
         WaMCtsITB8l+DcopKLI0IwJMSsxTqdkTnWvUzogUM6K98qCF7KHEGMwkZD0r1DkhmQsl
         1iWerS9GBW0ujnXrFggzz2ALQA56W59wOCtKAREB4ZDHc1sjdxJh8QRf0ISSELrJwJyv
         /kwzIQAecWKiobZC95V4XU6eAXU0/Z/0rKWPc0ccOGhC+D4vPPuSQ22pKw0RzRIpme7i
         yvAw==
X-Gm-Message-State: AO0yUKWXRyUBRbwEPLB4N+IJyEKkpBrQHclu7om6mSRkrWSHREpPIZ3u
        g8f9HiQXyGy1EPaRyc8TNru7pQ==
X-Google-Smtp-Source: AK7set9DSRkrLPRV4Cag9yn1sUOTyNYKhabS2nRmI7IxB3I0t9vaw+DQBhtoqMMpbRx+ohtLZEGY1Q==
X-Received: by 2002:a05:622a:18a6:b0:3ba:101e:88c6 with SMTP id v38-20020a05622a18a600b003ba101e88c6mr7001893qtc.48.1677911334384;
        Fri, 03 Mar 2023 22:28:54 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a02e400b0073bacce6ad7sm3180092qko.82.2023.03.03.22.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 22:28:54 -0800 (PST)
Date:   Sat, 4 Mar 2023 00:28:46 -0600
From:   Glenn Washburn <development@efficientek.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2] hostfs: handle idmapped mounts
Message-ID: <20230304002846.48278199@crass-HP-ZBook-15-G2>
In-Reply-To: <20230302083928.zek46ybxvuwgwdf5@wittgenstein>
References: <20230301015002.2402544-1-development@efficientek.com>
        <20230302083928.zek46ybxvuwgwdf5@wittgenstein>
Reply-To: development@efficientek.com
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2 Mar 2023 09:39:28 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Tue, Feb 28, 2023 at 07:50:02PM -0600, Glenn Washburn wrote:
> > Let hostfs handle idmapped mounts. This allows to have the same
> > hostfs mount appear in multiple locations with different id
> > mappings.
> > 
> > root@(none):/media# id
> > uid=0(root) gid=0(root) groups=0(root)
> > root@(none):/media# mkdir mnt idmapped
> > root@(none):/media# mount -thostfs -o/home/user hostfs mnt
> > 
> > root@(none):/media# touch mnt/aaa
> > root@(none):/media# mount-idmapped --map-mount u:`id -u user`:0:1
> > --map-mount g:`id -g user`:0:1 /media/mnt /media/idmapped
> > root@(none):/media# ls -l mnt/aaa idmapped/aaa -rw-r--r-- 1 root
> > root 0 Jan 28 01:23 idmapped/aaa -rw-r--r-- 1 user user 0 Jan 28
> > 01:23 mnt/aaa
> > 
> > root@(none):/media# touch idmapped/bbb
> > root@(none):/media# ls -l mnt/bbb idmapped/bbb
> > -rw-r--r-- 1 root root 0 Jan 28 01:26 idmapped/bbb
> > -rw-r--r-- 1 user user 0 Jan 28 01:26 mnt/bbb
> > 
> > Signed-off-by: Glenn Washburn <development@efficientek.com>
> > ---
> > Changes from v1:
> >  * Rebase on to tip. The above commands work and have the results
> > expected. The __vfsuid_val(make_vfsuid(...)) seems ugly to get the
> > uid_t, but it seemed like the best one I've come across. Is there a
> > better way?
> 
> Sure, I can help you with that. ;)

Thank you!

> > 
> > Glenn
> > ---
> >  fs/hostfs/hostfs_kern.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> > index c18bb50c31b6..9459da99a0db 100644
> > --- a/fs/hostfs/hostfs_kern.c
> > +++ b/fs/hostfs/hostfs_kern.c
> > @@ -786,7 +786,7 @@ static int hostfs_permission(struct mnt_idmap
> > *idmap, err = access_file(name, r, w, x);
> >  	__putname(name);
> >  	if (!err)
> > -		err = generic_permission(&nop_mnt_idmap, ino,
> > desired);
> > +		err = generic_permission(idmap, ino, desired);
> >  	return err;
> >  }
> >  
> > @@ -794,13 +794,14 @@ static int hostfs_setattr(struct mnt_idmap
> > *idmap, struct dentry *dentry, struct iattr *attr)
> >  {
> >  	struct inode *inode = d_inode(dentry);
> > +	struct user_namespace *fs_userns = i_user_ns(inode);
> 
> Fyi, since hostfs can't be mounted in a user namespace
> fs_userns == &init_user_ns
> so it doesn't really matter what you use.

What would you suggest as preferable?

> >  	struct hostfs_iattr attrs;
> >  	char *name;
> >  	int err;
> >  
> >  	int fd = HOSTFS_I(inode)->fd;
> >  
> > -	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> > +	err = setattr_prepare(idmap, dentry, attr);
> >  	if (err)
> >  		return err;
> >  
> > @@ -814,11 +815,11 @@ static int hostfs_setattr(struct mnt_idmap
> > *idmap, }
> >  	if (attr->ia_valid & ATTR_UID) {
> >  		attrs.ia_valid |= HOSTFS_ATTR_UID;
> > -		attrs.ia_uid = from_kuid(&init_user_ns,
> > attr->ia_uid);
> > +		attrs.ia_uid = __vfsuid_val(make_vfsuid(idmap,
> > fs_userns, attr->ia_uid)); }
> >  	if (attr->ia_valid & ATTR_GID) {
> >  		attrs.ia_valid |= HOSTFS_ATTR_GID;
> > -		attrs.ia_gid = from_kgid(&init_user_ns,
> > attr->ia_gid);
> > +		attrs.ia_gid = __vfsgid_val(make_vfsgid(idmap,
> > fs_userns, attr->ia_gid));
> 
> Heh, if you look include/linux/fs.h:
> 
>         /*
>          * The two anonymous unions wrap structures with the same
> member. *
>          * Filesystems raising FS_ALLOW_IDMAP need to use
> ia_vfs{g,u}id which
>          * are a dedicated type requiring the filesystem to use the
> dedicated
>          * helpers. Other filesystem can continue to use ia_{g,u}id
> until they
>          * have been ported.
>          *
>          * They always contain the same value. In other words
> FS_ALLOW_IDMAP
>          * pass down the same value on idmapped mounts as they would
> on regular
>          * mounts.
>          */
>         union {
>                 kuid_t          ia_uid;
>                 vfsuid_t        ia_vfsuid;
>         };
>         union {
>                 kgid_t          ia_gid;
>                 vfsgid_t        ia_vfsgid;
>         };
> 
> this just is:
> 
> attrs.ia_uid = from_vfsuid(idmap, fs_userns, attr->ia_vfsuid));
> attrs.ia_gid = from_vfsgid(idmap, fs_userns, attr->ia_vfsgid));

Its easy to miss from this patch because of lack of context, but attrs
is a struct hostfs_iattr, not struct iattr. And attrs.ia_uid is of type
uid_t, not kuid_t. So the above fails to compile. This is why I needed
to wrap make_vfsuid() in __vfsuid_val() (to get the uid_t).

I had decided against using from_vfsuid() because then I thought I'd
need to use from_kuid() to get the uid_t. And from_kuid() takes the
namespace (again), which seemed uglier.

Based on this, what do you suggest?

Glenn
