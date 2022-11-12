Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C9D626845
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 10:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiKLJHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 04:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiKLJG5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 04:06:57 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97869101C;
        Sat, 12 Nov 2022 01:06:56 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id q127so7176763vsa.7;
        Sat, 12 Nov 2022 01:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mUxYaPqOaXtV1rXuDj+fyELSwZGJABYGYX7l2EP4YIU=;
        b=KjqZeq8pi/LDTQhe+itxy53wGlYeiHwFVwML722u+71uHrSKyM7A3CTcKQfVJRsioU
         wzMQ5tDYPGun3n+To2e9GdOnJepCOMFjTYQhT/EvpQj19leGoZFT5CV+FkC1w4qNymHX
         dgGBYQYgey8kZGL74+BPlHyVqnQWwi8my5yeD/qYi8S9yd3Cwd5kajMqKWGJ08lBa5Dw
         fHgzRvGeKINczUdj78ZFzTKT2vTAN6jEqQZGXmwKTsG2JmANVN8ajVDO253tQb3fJgBz
         YWeuYRthVVRsrcS+eHoHe/cp8gOgojok2zEtRNa1ehxO8RvmM7I8NUCJYb6S+DjFU6g2
         e6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUxYaPqOaXtV1rXuDj+fyELSwZGJABYGYX7l2EP4YIU=;
        b=VDu52H05szmgoEEyacEKqUthJTtMhGXic0mG6tmCKIQgT+gvlCDqpMrnkO45VlqHtU
         JNaKhL9W988geuP73jEqTM85jlgM+4ORusp9OOAtN1PWB4BbRifaTqH26r4W9q67BsAv
         dTEhmNjQTMqnrpju1/QV75R/PtiNi1pSWktJ+wu5IQsTuJXwIeF1FFBK1qFQj//61HWl
         BY0z962YhkSh0+cWalOvqcWzib/huysGAZRzI4VJp1gxXB3397Qj1RcxjQ0MNvun1TY/
         4wuEc8upRXt51mdHFiNbicqs7b2LK8Z6XviXg26IpR7j0hkp84GZJurqoeAA4c9Hgus7
         Z5kQ==
X-Gm-Message-State: ANoB5pn+KaUCgzuSV9k9knDHoM+CA3Bt33yKSjhY+yKyQWcAiFnoe17F
        4xW1ApKfCRy7ATCmYlfuyF85VOQQFRc8i25HyeM=
X-Google-Smtp-Source: AA0mqf7a/KcwKPHvFBXWv+PfoVxCoYuXMSmzRa+YxGWQh/j1x0FRgdT6hHrdrSrv5SA+RmYFjilg3xe/OZx+pK2d1z0=
X-Received: by 2002:a67:f1cb:0:b0:3ad:7661:a081 with SMTP id
 v11-20020a67f1cb000000b003ad7661a081mr2631819vsm.2.1668244014142; Sat, 12 Nov
 2022 01:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com> <20221111220614.991928-4-stephen.s.brennan@oracle.com>
In-Reply-To: <20221111220614.991928-4-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Nov 2022 11:06:42 +0200
Message-ID: <CAOQ4uxgK6H_zaCRZG3FvUhD7-28-P79qPTTmLUD4t0XY3LakbQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dnotify: move fsnotify_recalc_mask() outside spinlock
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 12, 2022 at 12:06 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> In order to allow sleeping during fsnotify_recalc_mask(), we need to
> ensure no callers are holding a spinlock.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

small suggestion below.

> ---
>  fs/notify/dnotify/dnotify.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 190aa717fa32..a9f05b3cf5ea 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -58,10 +58,10 @@ struct dnotify_mark {
>   * dnotify cares about for that inode may change.  This function runs the
>   * list of everything receiving dnotify events about this directory and calculates
>   * the set of all those events.  After it updates what dnotify is interested in
> - * it calls the fsnotify function so it can update the set of all events relevant
> - * to this inode.
> + * it returns true if fsnotify_recalc_mask() should be called to update the set
> + * of all events related to this inode.
>   */
> -static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
> +static bool dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
>  {
>         __u32 new_mask = 0;
>         struct dnotify_struct *dn;
> @@ -74,10 +74,9 @@ static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
>         for (dn = dn_mark->dn; dn != NULL; dn = dn->dn_next)
>                 new_mask |= (dn->dn_mask & ~FS_DN_MULTISHOT);
>         if (fsn_mark->mask == new_mask)
> -               return;
> +               return false;
>         fsn_mark->mask = new_mask;
> -
> -       fsnotify_recalc_mask(fsn_mark->connector);
> +       return true;
>  }
>
>  /*
> @@ -97,6 +96,7 @@ static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
>         struct dnotify_struct **prev;
>         struct fown_struct *fown;
>         __u32 test_mask = mask & ~FS_EVENT_ON_CHILD;
> +       bool recalc = false;
>
>         /* not a dir, dnotify doesn't care */
>         if (!dir && !(mask & FS_ISDIR))
> @@ -118,12 +118,15 @@ static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
>                 else {
>                         *prev = dn->dn_next;
>                         kmem_cache_free(dnotify_struct_cache, dn);
> -                       dnotify_recalc_inode_mask(inode_mark);
> +                       recalc = dnotify_recalc_inode_mask(inode_mark);
>                 }
>         }
>
>         spin_unlock(&inode_mark->lock);
>
> +       if (recalc)
> +               fsnotify_recalc_mask(inode_mark->connector);
> +
>         return 0;
>  }
>
> @@ -158,6 +161,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
>         struct dnotify_struct **prev;
>         struct inode *inode;
>         bool free = false;
> +       bool recalc = false;
>
>         inode = file_inode(filp);
>         if (!S_ISDIR(inode->i_mode))
> @@ -176,7 +180,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
>                 if ((dn->dn_owner == id) && (dn->dn_filp == filp)) {
>                         *prev = dn->dn_next;
>                         kmem_cache_free(dnotify_struct_cache, dn);
> -                       dnotify_recalc_inode_mask(fsn_mark);
> +                       recalc = dnotify_recalc_inode_mask(fsn_mark);
>                         break;
>                 }
>                 prev = &dn->dn_next;
> @@ -184,6 +188,9 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
>
>         spin_unlock(&fsn_mark->lock);
>
> +       if (recalc)
> +               fsnotify_recalc_mask(fsn_mark->connector);
> +
>         /* nothing else could have found us thanks to the dnotify_groups
>            mark_mutex */
>         if (dn_mark->dn == NULL) {
> @@ -268,6 +275,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>         struct file *f;
>         int destroy = 0, error = 0;
>         __u32 mask;
> +       bool recalc = false;
>
>         /* we use these to tell if we need to kfree */
>         new_fsn_mark = NULL;
> @@ -377,9 +385,11 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>         else if (error == -EEXIST)
>                 error = 0;
>
> -       dnotify_recalc_inode_mask(fsn_mark);
> +       recalc = dnotify_recalc_inode_mask(fsn_mark);
>  out:
>         spin_unlock(&fsn_mark->lock);
> +       if (recalc)
> +               fsnotify_recalc_mask(fsn_mark->connector);
>
>         if (destroy)
>                 fsnotify_detach_mark(fsn_mark);

I'd do else if (recalc)

just to emphasise that destroy and recalc are mutually exclusive.

Thanks,
Amir.
