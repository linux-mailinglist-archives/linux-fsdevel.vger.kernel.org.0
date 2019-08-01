Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BD87DBDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfHAMsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 08:48:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43722 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbfHAMsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:48:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so50146808lfm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2019 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rl9gxlsQAmtdUucdCjHcN4IJXqqRSXnZiys3c1iAChM=;
        b=BCqrZFER2qt2tRS4BERTa8OYTuAczZw6Vu3z7uTZGQYFaSHcfqcuV5SQV52phXuR2o
         pc7vXSMcsbSyYQZoWwSHx+qcs5+KqXD1ix4QMDk1fiOe2f+Ey++TFVh4YlYS57d7nY/R
         +PJ/gd2ZVxTYilPY2dcgN2+QJY+52AFbAoy3305qeyBUImzo0UJUG1ndwMGZnl91xgKz
         NZSc6hvZbcgaGjMl71JYcOKdsjCyGbbYqmWeQxBn+au/dhacM3cMsu+jw8f7pJ2BZvPK
         ixzTT/jc3086+42k3lk1OU5aCakMaxf9AgMmj6t3GYjy8+6qb4n0kmkj+3oN88PiNKlA
         pQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rl9gxlsQAmtdUucdCjHcN4IJXqqRSXnZiys3c1iAChM=;
        b=tONSD/9AxFnWxGPOYaZJOg2hHRZP3DU5IQepm2CZQyv3jusCIESBl+wjvUA4ud0fnc
         pvU11x9QO0yjZWKxzB+X7SPtVKxhwDPy3xpSfnh1W6epGuPoMn4T48mLRZjZmOgo4fn0
         I5KPiMl+3WuzzaWKmxVLuk9ej6qE1VsvGkC0sGLnkTd1s2MMtBdJhs+0T1K+b/SI3C9L
         z4YWzKc2dxXZ5pfliT0IV8ek37WR0Iiv4PTpXG+CFaoEI2a/dcbixbkgSUklGvSDqcxt
         vUuaL0IN9hMP/XQuUT1dtgSk6eSb5r2whJaxPnjB1gzGXWCJWZTYTNwyg3ra9GgPrI5U
         aj1w==
X-Gm-Message-State: APjAAAVVrOwBCHUuXai4d9clATtWDv89S14GmOqzqGNB/VIBZ2yZ0XiR
        sa871VU0MJy+nk245IDq2Dfd8S+HJTQU3MPFsQ==
X-Google-Smtp-Source: APXvYqxgr8PQjSzAdp7+U+PsgA9phbRv670CHsf3naEv6EhZF5kRfW6dfEe+5cBDHIT5XJU7QNpkLNvRclzntJy1hqs=
X-Received: by 2002:ac2:5559:: with SMTP id l25mr59946611lfk.175.1564663688296;
 Thu, 01 Aug 2019 05:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov> <1c62c931-9441-4264-c119-d038b2d0c9b9@schaufler-ca.com>
 <CAHC9VhS6cfMw5ZUkOSov6hexh9QpnpKwipP7L7ZYGCVLCHGfFQ@mail.gmail.com> <66fbc35c-6cc8-bd08-9bf9-aa731dc3ff09@tycho.nsa.gov>
In-Reply-To: <66fbc35c-6cc8-bd08-9bf9-aa731dc3ff09@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Aug 2019 08:47:56 -0400
Message-ID: <CAHC9VhQg_UCDZpm=hWTn5YFAYQJt1K_fRxxq+LzORekJ8p9zNg@mail.gmail.com>
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook
 for fs notifications
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 1, 2019 at 7:31 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 7/31/19 8:27 PM, Paul Moore wrote:
> > On Wed, Jul 31, 2019 at 1:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 7/31/2019 8:34 AM, Aaron Goidel wrote:

...

> >>> +static int selinux_path_notify(const struct path *path, u64 mask,
> >>> +                                             unsigned int obj_type)
> >>> +{
> >>> +     int ret;
> >>> +     u32 perm;
> >>> +
> >>> +     struct common_audit_data ad;
> >>> +
> >>> +     ad.type = LSM_AUDIT_DATA_PATH;
> >>> +     ad.u.path = *path;
> >>> +
> >>> +     /*
> >>> +      * Set permission needed based on the type of mark being set.
> >>> +      * Performs an additional check for sb watches.
> >>> +      */
> >>> +     switch (obj_type) {
> >>> +     case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> >>> +             perm = FILE__WATCH_MOUNT;
> >>> +             break;
> >>> +     case FSNOTIFY_OBJ_TYPE_SB:
> >>> +             perm = FILE__WATCH_SB;
> >>> +             ret = superblock_has_perm(current_cred(), path->dentry->d_sb,
> >>> +                                             FILESYSTEM__WATCH, &ad);
> >>> +             if (ret)
> >>> +                     return ret;
> >>> +             break;
> >>> +     case FSNOTIFY_OBJ_TYPE_INODE:
> >>> +             perm = FILE__WATCH;
> >>> +             break;
> >>> +     default:
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>> +     // check if the mask is requesting ability to set a blocking watch
> >
> > ... in the future please don't use "// XXX", use "/* XXX */" instead :)
> >
> > Don't respin the patch just for this, but if you have to do it for
> > some other reason please fix the C++ style comments.  Thanks.
>
> This was discussed during the earlier RFC series but ultimately someone
> pointed to:
> https://lkml.org/lkml/2016/7/8/625
> where Linus blessed the use of C++/C99 style comments.  And checkpatch
> accepts them these days.

Yep, I'm aware of both, it is simply a personal preference of mine.
I'm not going to reject patches with C++ style comments, but I would
ask people to stick to the good ol' fashioned comments for patches
they submit.

> Obviously if you truly don't want them in the SELinux code, that's your
> call.  But note that all files now have at least one such comment as a
> result of the mass SPDX license headers that were added throughout the
> tree using that style.

FYI, the sky is blue.

It isn't just the license headers either, Al dropped one into hooks.c
:).  Just like I don't plan to reject patches due only to the comment
style, you don't see me pushing patches to change the C++ comments.

-- 
paul moore
www.paul-moore.com
