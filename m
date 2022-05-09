Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D400451F8A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 11:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiEIJmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbiEIJmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 05:42:20 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E7613F1E6;
        Mon,  9 May 2022 02:38:26 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id q2so13244104vsr.5;
        Mon, 09 May 2022 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ms2OmWrZMbAmlfHzDQqtdt+wIiR2JhVE0s22ev6NcE=;
        b=On7f4sc0xl6O7L7J/hV3ctEoS40biGja4bO+jZTVTS0VXNPAxYsU3GDA9g7uKZ6pp6
         ynwoD0DFxhYHu8s+tXNi1cr2w6m75/dd5FVvOKhnPIdiUoiUvflYIvXGetyo5PiS3fAh
         rGx7NVi8G6ZnQbt81ajCArZtw2MgS2nuadNt2U7jBwF4ILFV6iH1XEaZIgIMbxbwkkvP
         wu+eZ0cUY6ZWqb272EifXWbgsnQyku6dg2zQslfTTeGKiYXYBjlMSGuTMMgJgKbxYTuT
         h9e6b8fMxXGkTx6dMH5wl4KuelbdOPEi47oYsyDOmjxj803iSHQ1fWivA9t4O1U44o6k
         uvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ms2OmWrZMbAmlfHzDQqtdt+wIiR2JhVE0s22ev6NcE=;
        b=TqlQwaVkeIPwUkQe9IG1GKQ/f/K3eLL+FhPtw6CGdER8yJkGsjfJ3GnIF4BJ4G5fZV
         ayXtGag3HbiBkdcfn3OpQW71+pHt/hBbQ1Hh4KvBJGsBXi7Jw/zpSSvsd0b4PbPqrcbm
         od56EttjJTYY4QXYNhwWW5T/Bs/lU1w0dtS5r+inSy2cg9QwnnI+vxZlC8xpYhpPXKt+
         3S8kAemge0D16ynTUPG0yhtiRUFkL8ORmTWGiXwIeT0KtF5JJ5Z12ef8mYy0SWj3xEf/
         DqDN0OmC9AO1BP0dqsWCSnwpd+GSCQWBzp8yXLtM/MJgK5uQdCLJDoZO1Rl/yl5lru5r
         f9bA==
X-Gm-Message-State: AOAM533Th1pWBS00A7aktdBxOiCkvt7CSwEvHjtrjx4r79079ZPmuNz1
        ap5MtnYIPik+sVGYsQokA4lx7qYarRa7DvdjF0A=
X-Google-Smtp-Source: ABdhPJxQa+6QJ/CET2ydb15xzcLU4JG/ctU72rTIwybTeCOA12flltOKMmKvKfqZm/HT3uLxpGmQ1UgbNVerQJDwBsM=
X-Received: by 2002:a05:6102:905:b0:32c:c256:b059 with SMTP id
 x5-20020a056102090500b0032cc256b059mr7184386vsh.21.1652089076919; Mon, 09 May
 2022 02:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220505134731.5295-1-jing.xia@unisoc.com> <20220505154024.onreajr4xmtsswes@quack3.lan>
In-Reply-To: <20220505154024.onreajr4xmtsswes@quack3.lan>
From:   jing xia <jing.xia.mail@gmail.com>
Date:   Mon, 9 May 2022 17:37:45 +0800
Message-ID: <CAN=25QOT5h-CfBk9AagMz61TVxHd485QCyJED+mqX4LL6KTp7w@mail.gmail.com>
Subject: Re: [PATCH] writeback: Avoid skipping inode writeback
To:     Jan Kara <jack@suse.cz>
Cc:     Jing Xia <jing.xia@unisoc.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

Thanks, I'll update the patch.

On Thu, May 5, 2022 at 11:40 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 05-05-22 21:47:31, Jing Xia wrote:
> > We have run into an issue that a task gets stuck in
> > balance_dirty_pages_ratelimited() when perform I/O stress testing.
> > The reason we observed is that an I_DIRTY_PAGES inode with lots
> > of dirty pages is in b_dirty_time list and standard background
> > writeback cannot writeback the inode.
> > After studing the relevant code, the following scenario may lead
> > to the issue:
> >
> > task1                                   task2
> > -----                                   -----
> > fuse_flush
> >  write_inode_now //in b_dirty_time
> >   writeback_single_inode
> >    __writeback_single_inode
> >                                  fuse_write_end
> >                                   filemap_dirty_folio
> >                                    __xa_set_mark:PAGECACHE_TAG_DIRTY
> >     lock inode->i_lock
> >     if mapping tagged PAGECACHE_TAG_DIRTY
> >     inode->i_state |= I_DIRTY_PAGES
> >     unlock inode->i_lock
> >                                    __mark_inode_dirty:I_DIRTY_PAGES
> >                                       lock inode->i_lock
> >                                       -was dirty,inode stays in
> >                                       -b_dirty_time
> >                                       unlock inode->i_lock
> >
> >    if(!(inode->i_state & I_DIRTY_All))
> >       -not true,so nothing done
> >
> > This patch moves the dirty inode to b_dirty list when the inode
> > currently is not queued in b_io or b_more_io list at the end of
> > writeback_single_inode.
> >
> > Signed-off-by: Jing Xia <jing.xia@unisoc.com>
>
> Thanks for report and the fix! The patch looks good so feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> Also please add tags:
>
> CC: stable@vger.kernel.org
> Fixes: 0ae45f63d4ef ("vfs: add support for a lazytime mount option")
>
> Thanks.
>                                                                 Honza
>
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 591fe9cf1659..d7763feaf14a 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1712,6 +1712,9 @@ static int writeback_single_inode(struct inode *inode,
> >        */
> >       if (!(inode->i_state & I_DIRTY_ALL))
> >               inode_cgwb_move_to_attached(inode, wb);
> > +     else if (!(inode->i_state & I_SYNC_QUEUED) && (inode->i_state & I_DIRTY))
> > +             redirty_tail_locked(inode, wb);
> > +
> >       spin_unlock(&wb->list_lock);
> >       inode_sync_complete(inode);
> >  out:
> > --
> > 2.17.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
