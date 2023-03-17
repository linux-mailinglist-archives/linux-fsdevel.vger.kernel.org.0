Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1BB6BE5D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 10:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCQJpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQJpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:45:38 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635EE23316
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 02:45:37 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id s1so3979563vsk.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679046336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leONUKnExL8KkeXcoBGwa8J0wA1fBy+ngRQblH20000=;
        b=T345WpTHHSRzz4GXLLNLSSXlGch6E3tc8TxpRXsn8Uo6rtqcp44+7XtgyNcMRs+yHS
         nxfgbEO8w+1K1zYZiR2krGaNMpsMFGqBCuKiPys8sFUEdXkvY1zKoWjYqKDsEZ2Sr3fO
         NTGtaqdUI5fjwwJe8ngm5hlkFfm3vbYIC6p6a22wbnnXMmAze0rm9swcKaEeCzFvyxTs
         eJuG1I4ScWpJV/eBZUvM90NDhsWYCnqOuD+d8jPOZXg6QcZJkX2thzWIvIUx24cRnq59
         rE5NIDCK8XR0pFANDsqXBj5LmHOi5yy5I0ybrE9W/+MB+WN4V7NDka5p+5eLA1+j3CJx
         2+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679046336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leONUKnExL8KkeXcoBGwa8J0wA1fBy+ngRQblH20000=;
        b=AH1pZhBYIwP5ZZRhBCPvSDLaI6LLQvIyLBVR6m8RwZ/TY5NHAcjncAuoaIczwfYt0I
         XNYdpvE0ict/FNd4pwwHjFRKwR4OzD8+BvRrISIixajCL6Cu7Jk9b/O5gUP/flyox8Xl
         Gr+dR8oBIvA5xJ62aUvhDh+ZkMsVeOLAcDj4yhZhIiyl/J/DhAUC1kmMjWx2dN+roZ/g
         LTPGz0DTIkGBDdDchjAfGuahyQ0Z4OuZjmWmP5sBcs3Fn6JjmVf1V+UfrnChDd+CMQyM
         74zwyqy3P6nFLmCBb4l0S/hS5kvtXAP6Rr4toVKY4mcf1UDqbLfxQMQxQ1+u1wcXUt5W
         o5cg==
X-Gm-Message-State: AO0yUKVXxBF8OLkvjWF/c3+Tsj9jpaTlf2W8dxsxrLxfdKMFblh3qxLd
        E/V+I1t+uVmNrEERsUYWeXT3y7sB/7vJLbO8adl7RvdXpWw=
X-Google-Smtp-Source: AK7set9rSyYRGhlrsgJ+dZ533cB0HvbL87VCs1tdW5vQktoQmnLxtXGPIhatetaC0LeFAEYxPtEXBkExBcllVVpTaNQ=
X-Received: by 2002:a67:e0ca:0:b0:412:5424:e58e with SMTP id
 m10-20020a67e0ca000000b004125424e58emr1552635vsl.0.1679046336385; Fri, 17 Mar
 2023 02:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <E12A0E13-3726-4270-806B-B0586D5008D2@columbia.edu>
In-Reply-To: <E12A0E13-3726-4270-806B-B0586D5008D2@columbia.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 17 Mar 2023 11:45:25 +0200
Message-ID: <CAOQ4uxhJ0ZYjGcObjhKJ1U5Tew1pZzgh1ACDMZMU4QLsy+81uw@mail.gmail.com>
Subject: Re: fsnotify: Question on proper use in-kernel
To:     Ioannis Zarkadas <iz2175@columbia.edu>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 17, 2023 at 5:23=E2=80=AFAM Ioannis Zarkadas <iz2175@columbia.e=
du> wrote:
>
> Hi everyone!
>
> I'm developing a kernel module and trying to setup a directory watch with=
 fsnotify.
> I mainly copied existing code paths in the kernel that I found, because I=
 couldn't
> find any usage documentation.
> I am using Linux Kernel version 5.12.0.

I guess the API should be similar to upstream, but I did not check.

>
> My issue is the following:
> - Setting up the watch works initially.
> - If I remove and reinsert the kernel module, fsnotify_add_inode_mark fai=
ls with EEXIST.
>
> So I must be doing something wrong. I am using the put/destroy methods fo=
r the mark
> and the put method for the group when unloading the module.
>
> Here is how I setup the watch:
>
> > static struct fsnotify_group *group;
> > static struct fsnotify_mark mark;
> >
> > static int setup_sync_dir_watch(char *sync_dir) {
> >     int ret;
> >     struct fsnotify_mark *old_mark;
> >     struct path sync_dir_path;
> >
> >     pr_info("%s: Syncing extents for files under '%s'\n", MODULE_NAME,
> >             sync_dir);
> >
> >     group =3D fsnotify_alloc_group(&nvmeof_xrp_fsnotify_ops);

You did not mention what your fsnotify_ops contain.

> >     if (IS_ERR(group)) {
> >         pr_err("%s: Error allocating fsnotify group!\n", MODULE_NAME);
> >         return -1;
> >     }
> >     ret =3D kern_path(sync_dir, LOOKUP_FOLLOW, &sync_dir_path);
> >     if (ret) {
> >         pr_err("%s: Error getting kernel path: %d!\n", MODULE_NAME, ret=
);
> >         goto release_group;
> >     }
> >     fsnotify_init_mark(&mark, group);
> >     mark.mask =3D FS_CREATE | FS_DELETE | FS_MODIFY |
> >                                  FS_CLOSE_WRITE | FS_EVENT_ON_CHILD;
> >     ret =3D fsnotify_add_inode_mark(&mark,
> >                                   sync_dir_path.dentry->d_inode, 0);
> >     path_put(&sync_dir_path);
> >     if (ret) {
> >         pr_err("%s: Error adding fsnotify mark! Error code: %d\n", MODU=
LE_NAME,
> >                ret);
> >         goto release_mark;
> >     }
> >     return 0;
> > release_mark:
> >     fsnotify_destroy_mark(&mark, group);
> >     fsnotify_put_mark(&mark);

Don't think you need that put.

> > release_group:
> >     fsnotify_put_group(group);

fsnotify_destroy_group()

> >     return ret;
> > }
>
> And here is how I clear it when exiting the module:
>
> > static void __exit module_exit(void) {
> >     fsnotify_destroy_mark(&mark, group);
> >     fsnotify_put_mark(&mark);
> >     fsnotify_put_group(group);
>

I think you only need fsnotify_destroy_group().
Internally, it will detach the mark, drop its reference and
fsnotify_wait_marks_destroyed(), because if there are live
reference to mark, you cannot remove the module.

> I also tried to find the mark and delete it, but it returns NULL even tho=
ugh
> fsnotify_add_inode_mark returns EEXISTS:
>
> > mutex_lock(&group->mark_mutex);
> > old_mark =3D fsnotify_find_mark(
> >     &sync_dir_path.dentry->d_inode->i_fsnotify_marks,
> >     group);
> > if (old_mark !=3D NULL) {
> >     pr_info("%s: Found old mark, destroying it...\n", MODULE_NAME);
> >     fsnotify_destroy_mark(old_mark, group);
> >     fsnotify_put_mark(old_mark);
> > }
> > mutex_unlock(&group->mark_mutex);
>

Not really sure what happened here.
If this behavior persists after making the changes above, better add debug
prints to fsnotify_add_mark_list() to understand what is happening.

Thanks,
Amir.
