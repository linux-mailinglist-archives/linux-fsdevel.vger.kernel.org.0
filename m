Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42FE633E57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 15:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiKVOFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 09:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiKVOFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:05:05 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D2767104;
        Tue, 22 Nov 2022 06:03:35 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id f18so4478293uam.13;
        Tue, 22 Nov 2022 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OUUTMZ627GSUDcIQDYT4wQR/+JMhhuMlXoKs2t5WSFg=;
        b=Cq+VG6Bpb+GQiAJxSgVR0fm5A1IV8U7FVQLqzTBOdZoUQif2XuEj5qX8dY7AgO8Bcp
         LzZLq0+Cr/4CMukWUmYsWVEd9ZRZXQrxQTtE8PoEfKNfcV2OdGb1Rt5l7uzr61OFibgV
         b9wz0BRST3po2iOU9zIP6JHavzgnluBFnqdZRSu15Cv5n3DhbHD61JyvAjOPflAFQc6r
         u4Att+WYznSSe6brzv4ptDcHIfVqneLa7XPaU1CttNJeheq9uwxx1sOUFHzvDHeix2pe
         XQnetRSPnEME/oUal7cijkD4ssjCXUG6Q7UwCz9TUQEQltogZfgKSQYY9gV4nAMR5DWc
         v/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUUTMZ627GSUDcIQDYT4wQR/+JMhhuMlXoKs2t5WSFg=;
        b=OSdPVsUyZRoJ/s96Y9e6IOHtAOcnYW4dzGzTJlblZd+MOKTatc3hQCLIv1byDSQfMh
         LSH4k4/TeDhYD6MFZ2Cdk3jHNugzZgkUsqqd7dx4IhGjKUpLu0xMpZ+bMEfLt9CF/WcT
         NsjVby1i0gahiUpdA/g/qsTgOKCnCaZgCJ+KD0dwNKmhlwwB7fwRVFoR4PD/kpu9VeGn
         /FzTFXjjF+aFgCGwCdQy/3c2SF98vGwtm2BfhwUavduD3V0tfg/gAEhBCBl1qtcN6Kce
         59+q1+Rq+hi+Xl35mSWfzjxsG1qqjJ1mFRT3SlVCjPfCfClYr3Mx0Emwai9mqgPcKvTO
         Z8kw==
X-Gm-Message-State: ANoB5pl6zvV7oy8HkzyS9EHN/ScLGFDz0nAmI2XHj3U1rtDxOEr6SYyQ
        AQQHcqQlfOXWRuTcF9PbYpjSldCzBFXbhVHh5clZTrF3YNE=
X-Google-Smtp-Source: AA0mqf51/gVlrHjZICHvMHeOKAvbYr4z4MKFGHevI0fnzPIqhY1kU8mGFDW9X3MqiIxAADOBRitvgEuTC8Ht3Mz/ssk=
X-Received: by 2002:ab0:14e8:0:b0:418:b9ed:8d94 with SMTP id
 f37-20020ab014e8000000b00418b9ed8d94mr2284751uae.60.1669125814211; Tue, 22
 Nov 2022 06:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com> <20221122115042.qssn25wbtxxhaeys@quack3>
In-Reply-To: <20221122115042.qssn25wbtxxhaeys@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Nov 2022 16:03:22 +0200
Message-ID: <CAOQ4uxhic7+q0Q9SjO_qkp71gCphZy8cAmzHbacY63Wxr35akg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] fsnotify: fix softlockups iterating over d_subdirs
To:     Jan Kara <jack@suse.cz>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Tue, Nov 22, 2022 at 1:50 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Stephen!
>
> On Fri 11-11-22 14:06:09, Stephen Brennan wrote:
> > Here's my v4 patch series that aims to eliminate soft lockups when updating
> > dentry flags in fsnotify. I've incorporated Jan's suggestion of simply
> > allowing the flag to be lazily cleared in the fsnotify_parent() function,
> > via Amir's patch. This allowed me to drop patch #2 from my previous series
> > (fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem). I
> > replaced it with "fsnotify: require inode lock held during child flag
> > update", patch #5 in this series. I also added "dnotify: move
> > fsnotify_recalc_mask() outside spinlock" to address the sleep-during-atomic
> > issues with dnotify.
>
> Yes, the series is now much simpler. Thanks!
>
> > Jan expressed concerns about lock ordering of the inode rwsem with the
> > fsnotify group mutex. I built this with lockdep enabled (see below for the
> > lock debugging .config section -- I'm not too familiar with lockdep so I
> > wanted a sanity check). I ran all the fanotify, inotify, and dnotify tests
> > I could find in LTP, with no lockdep splats to be found. I don't know that
> > this can completely satisfy the concerns about lock ordering: I'm reading
> > through the code to better understand the concern about "the removal of
> > oneshot mark during modify event generation". But I'm encouraged by the
> > LTP+lockdep results.
>
> So I had a look and I think your patches could cause deadlock at least for
> nfsd. The problem is with things like inotify IN_ONESHOT marks. They get
> autodeleted as soon as they trigger. Thus e.g. fsnotify_mkdir() can trigger
> IN_ONESHOT mark and goes on removing it by calling fsnotify_destroy_mark()
> from inotify_handle_inode_event(). And nfsd calls e.g. fsnotify_mkdir()
> while holding dir->i_rwsem held. So we have lock ordering like:
>
> nfsd_mkdir()
>   inode_lock(dir);
>     ...
>     __nfsd_mkdir(dir, ...)
>       fsnotify_mkdir(dir, dentry);
>         ...
>         inotify_handle_inode_event()
>           ...
>           fsnotify_destroy_mark()
>             fsnotify_group_lock(group)
>
> So we have dir->i_rwsem > group->mark_mutex. But we also have callchains
> like:
>
> inotify_add_watch()
>   inotify_update_watch()
>     fsnotify_group_lock(group)
>     inotify_update_existing_watch()
>       ...
>       fsnotify_recalc_mask()
>         inode_lock(dir); -> added by your series
>
> which creates ordering group->mark_mutex > dir->i_rwsem.
>
> It is even worse with dnotify which (even with your patches) ends up
> calling fsnotify_recalc_mask() from dnotify_handle_event() so we have a
> possibility of direct A->A deadlock. But I'd leave dnotify aside, I think
> that can be massaged to not need to call fsnotify_recalc_mask()
> (__fsnotify_recalc_mask() would be enough there).
>
> Still I'm not 100% sure about a proper way out of this. The simplicity of
> alias->d_subdirs iteration with i_rwsem held is compeling.

Agreed.

> We could mandate
> that fsnotify hooks cannot be called with inode->i_rwsem held (and fixup
> nfsd) but IMO that is pushing the complexity from the fsnotify core into
> its users which is undesirable.

I think inode in this context is the parent inode, so all fsnotify hooks
in namei.c are holding inode->i_rwsem by design.

> Maybe we could grab inode->i_rwsem in those
> places adding / removing notification marks before we grab
> group->mark_mutex, just verify (with lockdep) that fsnotify_recalc_mask()
> has the inode->i_rwsem held and be done with it? That pushes a bit of
> complexity into the fsnotify backends but it is not too bad.
> fsnotify_recalc_mask() gets only called by dnotify, inotify, and fanotify.
> Amir?
>

Absolutely agree - I think it makes sense and will simplify things a lot.

Obviously if we need to assert inode_is_locked() in fsnotify_recalc_mask()
only for (conn->type == FSNOTIFY_OBJ_TYPE_INODE).

Thanks,
Amir.
