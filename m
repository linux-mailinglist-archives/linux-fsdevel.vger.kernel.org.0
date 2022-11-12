Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262506268B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 11:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiKLKAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 05:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLKAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:00:30 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11246BCB6;
        Sat, 12 Nov 2022 02:00:29 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id d185so7290381vsd.0;
        Sat, 12 Nov 2022 02:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Feqofm+tP90zxrJEidVBVRfpQeHINCW+uH5v+xxersA=;
        b=g4nqY3IyAooIdasgbgXMQzdw/GioVWcaMRrJwbkH2eJbbN34rH9RfXcCtCNGkgDx70
         yCLJN/Npdg4u5TouLlcGl36vrLCkAABiYMk19w7l0r1tW8aZaHStzxSvJxtCxjLnNYRy
         yhR4XMz2F2d5x3KvHoZI611qBFPprNLiORcoJkPj3ByxQ54K1dBPH7MnHB2APJbDutG8
         WiUaBqVHQc4LnhAdFRHt2AbLyixV+HvfhM1+OqnsM1M6ofQFP4pSMarCO1GE+MtoOmz1
         YLFk2QJumZd00GmAuZAOGV1qX9g+v8zfhtQU5Pvi/wqCi32pcxT9O7f4Nl8nyLIhPFsr
         iiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Feqofm+tP90zxrJEidVBVRfpQeHINCW+uH5v+xxersA=;
        b=EOm40tqrl1vmTju21+a2PoKMYpdRAohtFbMwPaD2TH62QJWI3juVt1uick45arRJVQ
         OybeF6WvYvMqufM8xcdw1qdjOihV6PJ7RydDRtF91TAJd2p18K3a7yMVYz/mDUZugwQs
         Rk4ZhNCeX6qI7dpREvbHz0sJJBMljMPxm0ni3zXrgroxV5uNk8olVt5R/vdjunHHgByX
         oQ4hxoJJOHUP96D0BD6J2yi+9RdY1SL0+dkTt9PXHx1J/Y6TgO93Oj3S6RVVy2iLwCVx
         LXCBcojmHJL1j4ucdyuULQ2nJFq88gd1W42MSB24wTLDh1iz7bgsUo6hsuhH91LilDdz
         268g==
X-Gm-Message-State: ANoB5pkf5fBpq6/ErZAx8NTuBs7Rziz91dn8Ny2N3zuAqJJP0KubrXB3
        VAr2nr5O7pS66OqLf1TtXbTtlBQ+94fXYa3W48k=
X-Google-Smtp-Source: AA0mqf7P4PgCJTsB+I86oT4a54wrXQ1VSsOrcI+hXXpNOftnQLmADp0g9c4nVMaE1RB5J6w7znzl1389+d/Q4Xyyc0w=
X-Received: by 2002:a05:6102:50e:b0:3a7:9b8c:2e4c with SMTP id
 l14-20020a056102050e00b003a79b8c2e4cmr2400508vsa.72.1668247227837; Sat, 12
 Nov 2022 02:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com> <20221111220614.991928-5-stephen.s.brennan@oracle.com>
In-Reply-To: <20221111220614.991928-5-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Nov 2022 12:00:16 +0200
Message-ID: <CAOQ4uxihLiFiir_R+pBVuw_5rNv83wqY=qi0TpuH=R2OXxa0PQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] fsnotify: allow sleepable child flag update
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
> With very large d_subdirs lists, iteration can take a long time. Since
> iteration needs to hold alias->d_lock, this can trigger soft lockups.
> It would be best to make this iteration sleepable. We can drop
> alias->d_lock and sleep, by taking a reference to the current child.
> However, we need to be careful, since it's possible for the child's
> list pointers to be modified once we drop alias->d_lock. The following
> are the only cases where the list pointers are modified:
>
> 1. dentry_unlist() in fs/dcache.c
>
>    This is a helper of dentry_kill(). This function is quite careful to
>    check the reference count of the dentry once it has taken the
>    requisite locks, and bail out if a new reference was taken. So we
>    can be safe that, assuming we found the dentry and took a reference
>    before dropping alias->d_lock, any concurrent dentry_kill() should
>    bail out and leave our list pointers untouched.
>
> 2. __d_move() in fs/dcache.c
>
>    If the child was moved to a new parent, then we can detect this by
>    testing d_parent and retrying the iteration.
>
> 3. Initialization code in d_alloc() family
>
>    We are safe from this code, since we cannot encounter a dentry until
>    it has been initialized.
>
> 4. Cursor code in fs/libfs.c for dcache_readdir()
>
>    Dentries with DCACHE_DENTRY_CURSOR should be skipped before sleeping,
>    since we could awaken to find they have skipped over a portion of the
>    child list.
>
> Given these considerations, we can carefully write a loop that iterates
> over d_subdirs and is capable of going to sleep periodically.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>
> Notes:
>     v4:
>     - I've updated this patch so it should be safe even without the
>       inode locked, by handling cursors and d_move() races.
>     - Moved comments to lower indentation
>     - I didn't keep Amir's R-b since this was a fair bit of change.
>     v3:
>     - removed if statements around dput()
>     v2:
>     - added a check for child->d_parent != alias and retry logic
>
>  fs/notify/fsnotify.c | 46 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 409d479cbbc6..0ba61211456c 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -105,7 +105,7 @@ void fsnotify_sb_delete(struct super_block *sb)
>   */
>  void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
>  {
> -       struct dentry *alias, *child;
> +       struct dentry *alias, *child, *last_ref = NULL;
>
>         if (!S_ISDIR(inode->i_mode))
>                 return;
> @@ -116,12 +116,49 @@ void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
>                 return;
>
>         /*
> -        * run all of the children of the original inode and fix their
> -        * d_flags to indicate parental interest (their parent is the
> -        * original inode)
> +        * These lists can get very long, so we may need to sleep during
> +        * iteration. Normally this would be impossible without a cursor,
> +        * but since we have the inode locked exclusive, we're guaranteed

Not exactly true for v4 patchset order, but I do prefer that we make it true.

> +        * that the directory won't be modified, so whichever dentry we
> +        * pick to sleep on won't get moved. So, start a manual iteration
> +        * over d_subdirs which will allow us to sleep.
>          */
>         spin_lock(&alias->d_lock);
> +retry:

Better if we can avoid this retry by inode lock.
Note that it is enough to take inode_lock_shared() to protect
this code.

It means that tasks doing remove+add parent watch may
iterate d_subdirs in parallel, but maybe that's even better
then having them iterate d_subdirs sequentially?

>         list_for_each_entry(child, &alias->d_subdirs, d_child) {
> +               /*
> +                * We need to hold a reference while we sleep. But we cannot
> +                * sleep holding a reference to a cursor, or we risk skipping
> +                * through the list.
> +                *
> +                * When we wake, dput() could free the dentry, invalidating the
> +                * list pointers.  We can't look at the list pointers until we
> +                * re-lock the parent, and we can't dput() once we have the
> +                * parent locked.  So the solution is to hold onto our reference
> +                * and free it the *next* time we drop alias->d_lock: either at
> +                * the end of the function, or at the time of the next sleep.
> +                */

My usual nit picking: you could concat this explanation to the
comment outside the loop. It won't make it any less clear, maybe
even more clear in the wider context of how the children are safely
iterated.

Thanks,
Amir.
