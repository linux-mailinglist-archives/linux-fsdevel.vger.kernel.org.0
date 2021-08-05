Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA03E16BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 16:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbhHEOOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbhHEOOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:14:52 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94416C061765;
        Thu,  5 Aug 2021 07:14:38 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e186so4918812iof.12;
        Thu, 05 Aug 2021 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOg6CVN01dAcG2dSdzZFoOAExz/6zcXx5weq04yNvus=;
        b=pxtWS9FPTP6mHdzOCMIP9ULreibPTBWboL2avghdZlaAKkCGngjijluhuzB8cvK3NJ
         F6pWQNtcxt1awOjqey2PfRvvnWHI6UmB1WQWFXE62vtCX9d7RB0c9BSCtj8qgRLrHmvS
         Er99sg6XWck3xPxJ2bqEhX9dqQG317bIwq8ey/WbXWSKsm2XxmfsrsBwrAvjcdLCrOQl
         MGbrVUf8SQnM7bOsqKlLO8HzpbiGAzAUGEVOAg+rWxRsb5cNUvFBsQd1q/WjbfWRb2q6
         219s16/Dq/sePVWrDd6tjU3uST+4BRshXqnJqj8+OSqAohmAvMWAn4HZemKfxdiQZ6rI
         Vg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOg6CVN01dAcG2dSdzZFoOAExz/6zcXx5weq04yNvus=;
        b=GvZih944IcfH1qLsO6m0lprB7+Ts12VuQiaXQWPMMDh6aepr/vXHs0w0JwWYzPh9MP
         aZNJz2kQAvna9Ut0EHcNiOhgWEgu4t007M29ySAaHnX5X4kiCzFI8Hl3jKEe82Y8AX+U
         8DzVa6I03TVhDmvxr9qyNZOLD5MtK4yhe5+MhfO35vKcYtLb4eEN6Y3rSPfwtcjQzj3h
         U45Wcpu9BNeYRO76+lJKUyWV9xTaKcKpUeoR0CPBFaoFeLuZHP4g1TW7lyRUYzQ26A4l
         xUL85miW+spq507+dlgUsYrOj2pJWG7EHvhkATcBE3OlqbKHG57w1WjLEfyK115d6wqT
         M2Zw==
X-Gm-Message-State: AOAM533BxpnfoY+JrmubjZYyS9MS888HEsD/bmZFsl6sgRqYO4sCia4j
        b4OEwHJUM92UrpkRBIDCKmDNSw+rfFZyV37KtYI=
X-Google-Smtp-Source: ABdhPJwjNVTU2a4SyQFYemNMXrHs7aaamMRDQ74rylkUUqVWBTICJxc/tfS6ryo6+9xnv2luDHLmuFvCoegtNcdKEj8=
X-Received: by 2002:a02:958e:: with SMTP id b14mr4867135jai.123.1628172878032;
 Thu, 05 Aug 2021 07:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-11-krisman@collabora.com> <20210805102453.GG14483@quack2.suse.cz>
In-Reply-To: <20210805102453.GG14483@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 Aug 2021 17:14:26 +0300
Message-ID: <CAOQ4uxjFyMd=Ja4W18JjBBSpzoKdPD-jafdw78OZO3eAEeMFNA@mail.gmail.com>
Subject: Re: [PATCH v5 10/23] fsnotify: Allow events reported with an empty inode
To:     Jan Kara <jack@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 5, 2021 at 1:24 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 04-08-21 12:05:59, Gabriel Krisman Bertazi wrote:
> > Some file system events (i.e. FS_ERROR) might not be associated with an
> > inode.  For these, it makes sense to associate them directly with the
> > super block of the file system they apply to.  This patch allows the
> > event to be reported directly against the super block instead of an
> > inode.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> There's a comment before fsnotify() declaration that states that 'either
> @dir or @inode must be non-NULL' - in this patch it would be good time to
> update that comment.
>
> > @@ -459,12 +460,13 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
> >   *           if both are non-NULL event may be reported to both.
> >   * @cookie:  inotify rename cookie
> >   */
> > -int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> > -          const struct qstr *file_name, struct inode *inode, u32 cookie)
> > +int fsnotify(__u32 mask, const void *data, int data_type,
> > +          struct super_block *sb, struct inode *dir,
> > +          const struct qstr *file_name, struct inode *inode,
> > +          u32 cookie)
> >  {
>
> Two notes as ideas for consideration:
>
> 1) We could derive 'sb' from 'data'. I.e., have a helper like
> fsnotify_data_sb(data, data_type). For FSNOTIFY_EVENT_PATH and
> FSNOTIFY_EVENT_INODE this is easy to provide, for FSNOTIFY_EVENT_ERROR we
> would have to add sb pointer to the structure but I guess that's easy. That
> way we'd avoid the mostly NULL 'sb' argument. What do you guys think?

I think that's a great and simple idea that escaped me.

>
> 2) AFAICS 'inode' can be always derived from 'data' as well. So maybe we
> can drop it Amir?

If only we could. The reason that we pass the allegedly redundant inode
argument is because there are two different distinguished inode
arguments:

1. The inode event happened on, which can be referenced from data
2. Inode that may be marked, which is passed in the inode argument

Particularly, dirent events carry the inode of the child as data, but
intentionally pass NULL inode arguments, because mark on inode
itself should not be getting e.g. FAN_DELETE event, but
audit_mark_handle_event() uses the child inode data.

If we wanted to, we could pass report_mask arg to fsnotify()
instead of inode arg and then fsnotify() will build iter_info
accordingly, but that sounds very complicated and doesn't gain
much.

There could be a simpler solution that I am missing...

Thanks,
Amir.
