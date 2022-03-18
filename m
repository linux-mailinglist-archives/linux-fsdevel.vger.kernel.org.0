Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7CF4DD4AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 07:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiCRGYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 02:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiCRGYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:24:48 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF285FBE
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 23:23:29 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w127so7907839oig.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 23:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27aifOvffF+oFku/d1XWXlHmRkGxAAfaKOKBkrDJsQM=;
        b=KxZtou7Ns7lQx9naJFaCwpff9+fsQsaMMhlGskx13cmj0Bu/PovK2lQfQJWyQbgZyn
         cblpddWOGDp3IKpHQxF2OFY52EitrAnB5rBQUzmSe9t7Il1gYrlifp95sxXL/rFvmaTM
         4psyxlCVmWN9Z9ra2FSbcenlIbg7wCEf2bl5XfXHtN4JDIEW+VGm2BVQbyMLKH2uH7Cv
         Cv3XSohzj+M8ay7HONmLaOSDpV/u6cUyRWR9oru0sAXDArSBNZXw10bBdsfLR5Zm+psG
         jy3PNRhMhjUfCAtNUfEErRQlIsKOe3XnEa411HpLYi8aHQYtKbEtzWId0FxYdMbaB/z1
         jlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27aifOvffF+oFku/d1XWXlHmRkGxAAfaKOKBkrDJsQM=;
        b=FsxKFNJ8ggCZIyq+UZalyVecapNy2mlIrzPK4belwwRm0/sG895X9JW7dt2VG8TZky
         +JypcYN11j9eaWRQuL3C8zCwgRdc6Wp061W3a2b5g9w+yw4wZJ3vgqXETycslKLfLcu3
         yYE36qcSV94CU6yXPJVxGds7WeBbt4oTiR4ioQuLqy+pAtlWCOMAMfBJzi7LZHl+qT5B
         i5JXqFt4RSWZQTJBIDET6oBBJMsanJISL+K3eb7sCigtRI26I2q4xUJXhJqtOBpBHzCx
         BYkd9zf1XY79hamhwQIwAydmMbNr0A8bFBsrByjARLAhOKXuSmvpI4LRDvyxHEz5Drt2
         pnTg==
X-Gm-Message-State: AOAM5326HIT/re4+IRYgaRVlSRlFdYICk4fwkmNJBg/qwUg+Jvc4SQQu
        J1r+pifVZnsekzuX1oJMPQbQZ5ONyJ61kp34QJlIQx9tLEM=
X-Google-Smtp-Source: ABdhPJzUkpQGfc5iJbCV6XTqNJzrcGmPjt4R3aqkPHWSg2mKMofW9YK4uNIhQa9ANc6Momshx/5KrAuRJt1RkwCEWqs=
X-Received: by 2002:a05:6808:23c1:b0:2da:30fd:34d9 with SMTP id
 bq1-20020a05680823c100b002da30fd34d9mr7353854oib.203.1647584609046; Thu, 17
 Mar 2022 23:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220307155741.1352405-4-amir73il@gmail.com>
 <20220317152741.mzd5u2larfhrs2cg@quack3.lan>
In-Reply-To: <20220317152741.mzd5u2larfhrs2cg@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 18 Mar 2022 08:23:17 +0200
Message-ID: <CAOQ4uxhgJumhenn_KT6YRPvRQPaOyNOTQa359xwCugVc8dtbqA@mail.gmail.com>
Subject: Re: [PATCH 3/5] fsnotify: allow adding an inode mark without pinning inode
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 >

On Thu, Mar 17, 2022 at 5:27 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 07-03-22 17:57:39, Amir Goldstein wrote:
> > fsnotify_add_mark() and variants implicitly take a reference on inode
> > when attaching a mark to an inode.
> >
> > Make that behavior opt-out with the flag FSNOTIFY_ADD_MARK_NO_IREF.
> >
> > Instead of taking the inode reference when attaching connector to inode
> > and dropping the inode reference when detaching connector from inode,
> > take the inode reference on attach of the first mark that wants to hold
> > an inode reference and drop the inode reference on detach of the last
> > mark that wants to hold an inode reference.
> >
> > This leaves the choice to the backend whether or not to pin the inode
> > when adding an inode mark.
> >
> > This is intended to be used when adding a mark with ignored mask that is
> > used for optimization in cases where group can afford getting unneeded
> > events and reinstate the mark with ignored mask when inode is accessed
> > again after being evicted.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Couple of notes below.
>
> > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > index 190df435919f..f71b6814bfa7 100644
> > --- a/fs/notify/mark.c
> > +++ b/fs/notify/mark.c
> > @@ -213,6 +213,17 @@ static void *fsnotify_detach_connector_from_object(
> >       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
> >               inode = fsnotify_conn_inode(conn);
> >               inode->i_fsnotify_mask = 0;
> > +
> > +             pr_debug("%s: inode=%p iref=%u sb_connectors=%lu icount=%u\n",
> > +                      __func__, inode, atomic_read(&conn->proxy_iref),
> > +                      atomic_long_read(&inode->i_sb->s_fsnotify_connectors),
> > +                      atomic_read(&inode->i_count));
>
> Are these pr_debug() prints that useful? My experience is they get rarely used
> after the code is debugged... If you think some places are useful longer
> term, tracepoints are probably easier to use these days?
>

Well in this case, the debug prints didn't even help me find the refcount bug
I had in the code, so not useful.

> > +
> > +             /* Unpin inode when detaching from connector */
> > +             if (atomic_read(&conn->proxy_iref))
> > +                     atomic_set(&conn->proxy_iref, 0);
> > +             else
> > +                     inode = NULL;
>
> proxy_iref is always manipulated under conn->lock so there's no need for
> atomic operations here.

Of course. Much simpler!

>
> >       } else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
> >               fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
> >       } else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
> > @@ -240,12 +251,43 @@ static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
> >  /* Drop object reference originally held by a connector */
> >  static void fsnotify_drop_object(unsigned int type, void *objp)
> >  {
> > +     struct inode *inode = objp;
> > +
> >       if (!objp)
> >               return;
> >       /* Currently only inode references are passed to be dropped */
> >       if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
> >               return;
> > -     fsnotify_put_inode_ref(objp);
> > +
> > +     pr_debug("%s: inode=%p sb_connectors=%lu, icount=%u\n", __func__,
> > +              inode, atomic_long_read(&inode->i_sb->s_fsnotify_connectors),
> > +              atomic_read(&inode->i_count));
> > +
> > +     fsnotify_put_inode_ref(inode);
> > +}
> > +
> > +/* Drop the proxy refcount on inode maintainted by connector */
> > +static struct inode *fsnotify_drop_iref(struct fsnotify_mark_connector *conn,
> > +                                     unsigned int *type)
> > +{
> > +     struct inode *inode = fsnotify_conn_inode(conn);
> > +
> > +     if (WARN_ON_ONCE(!inode || conn->type != FSNOTIFY_OBJ_TYPE_INODE))
> > +             return NULL;
> > +
> > +     pr_debug("%s: inode=%p iref=%u sb_connectors=%lu icount=%u\n",
> > +              __func__, inode, atomic_read(&conn->proxy_iref),
> > +              atomic_long_read(&inode->i_sb->s_fsnotify_connectors),
> > +              atomic_read(&inode->i_count));
> > +
> > +     if (WARN_ON_ONCE(!atomic_read(&conn->proxy_iref)) ||
> > +         !atomic_dec_and_test(&conn->proxy_iref))
> > +             return NULL;
> > +
> > +     fsnotify_put_inode_ref(inode);
>
> You cannot call fsnotify_put_inode_ref() here because the function is
> called under conn->lock and iput() can sleep... You need to play similar
> game with passing inode pointer like
> fsnotify_detach_connector_from_object() does.

That was a plain bug.
That game is already being played and fsnotify_drop_object()
is responsible of iput().


BTW, I realized that incrementing/decrementing s_fsnotify_connectors
along with ihold/iput is completely useless, so I will remove the
fsnotify_{put,get}_inode_ref() helpers.

> > +     *type = FSNOTIFY_OBJ_TYPE_INODE;
> > +
> > +     return inode;
> >  }
> >
> >  void fsnotify_put_mark(struct fsnotify_mark *mark)
> > @@ -275,6 +317,9 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
> >               free_conn = true;
> >       } else {
> >               __fsnotify_recalc_mask(conn);
> > +             /* Unpin inode on last mark that wants inode refcount held */
> > +             if (mark->flags & FSNOTIFY_MARK_FLAG_HAS_IREF)
> > +                     objp = fsnotify_drop_iref(conn, &type);
> >       }
>
> This is going to be interesting. What if the connector got detached from
> the inode before fsnotify_put_mark() was called? Then iref_proxy would be
> already 0 and we would barf? I think
> fsnotify_detach_connector_from_object() needs to drop inode reference but
> leave iref_proxy alone for this to work. fsnotify_drop_iref() would then
> drop inode reference only if iref_proxy reaches 0 and conn->objp != NULL...
>

Good catch! but solution I think the is way simpler:

+               /* Unpin inode on last mark that wants inode refcount held */
+               if (conn->type == FSNOTIFY_OBJ_TYPE_INODE &&
+                   mark->flags & FSNOTIFY_MARK_FLAG_HAS_IREF)
+                       objp = fsnotify_drop_iref(conn, &type);

(iref_proxy > 0) always infers a single i_count reference, so it makes
fsnotify_detach_connector_from_object() sets iref_proxy = 0 and
conn->type = FSNOTIFY_OBJ_TYPE_DETACHED, so we should be good here.

Thanks,
Amir.
