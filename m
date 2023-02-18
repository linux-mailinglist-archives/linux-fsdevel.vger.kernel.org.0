Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BEA69BAEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 17:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBRQRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 11:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRQRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 11:17:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1833AEFAB;
        Sat, 18 Feb 2023 08:17:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u2so557999wrs.0;
        Sat, 18 Feb 2023 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ODMjy3oV9OZ/2U+MMAAOaloOxW1K2itgRE7CXAwpOc8=;
        b=Nnhs0/hK0A3+OPTXxMjdmyN98e1ZbXPrBEjfseIKiqIWGBjc7jheWbxJlGbVjEYbod
         zFPVaivM85keniIty8gLrcspQPQZIJPqDaNpTVK/yOVDIvxfOgm7P1tIuyhfz8vBZ0l0
         21DVOEWd4NyT603rrd3cL2YY0pGV2fdbDe3IeU4vjGqLcC/Ac9aT7iggbLk/2S2kD8Td
         F1HprfuFrfx43paeUwnPbeMQBamHWwb9U/gaFvdg7GHPpJ8D642Y9NlRxhIsvOq2K/j/
         13J6jE3rmGP0T0gXrtTsQT4RUbwfZdWXEpaofYvy5F2owm0t9fj057k4jqVvI1qm9i6T
         LPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODMjy3oV9OZ/2U+MMAAOaloOxW1K2itgRE7CXAwpOc8=;
        b=ID8x4tVYp5z23oBNdEiCBiexDM1qmJw4mZ0Q90NmRaP2hJ6aR8akyCEOQU1ZRc033m
         GjONnlgJ+CNAKvez++WIJ6ktnSg/6EBzr+vW6HuSHOum9sGV+uwCwjgSJOQZIkc1o+k2
         JvVsotcQJjc5DdTp46tBlS4OSOUJ/wGWmG7WTP+S2RDyz4vAQJGPOSirktsGLmgaEfBb
         lQkDUHHcc4JGB2Ql9mq7PyFY970FnnMlvrhFLbzLQGwblC40a6J2Su4RuslAflyG9WbX
         v8Cozn4UgnNRr+Yf0rO/OLowNSuiItWWz/sNwI7PaawytsFddpaqhzkwJYh1oTR+ZPFV
         /fAg==
X-Gm-Message-State: AO0yUKVH2dzWso6XMGzJVCBff4ZDIfJc8X0KREgXX0s5Zg70imXYeD8h
        QSowMf/STKy269mMK1baiD2iK2wSTp1Rb3OVUagbTixdW/M=
X-Google-Smtp-Source: AK7set9bLtwj6pLsp/K0b4D/XzEyMENUQgbNSP0tbGJVqvK6gAzFWXlAUobUZ87VgUOnSeKptFHW9QoFHdpz11toR6I=
X-Received: by 2002:a5d:59a9:0:b0:2c5:642f:1559 with SMTP id
 p9-20020a5d59a9000000b002c5642f1559mr56092wrr.4.1676737051177; Sat, 18 Feb
 2023 08:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20230124023834.106339-1-ericvh@kernel.org> <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-4-ericvh@kernel.org> <Y/CZVEQPFFo0zMjo@codewreck.org>
In-Reply-To: <Y/CZVEQPFFo0zMjo@codewreck.org>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Sat, 18 Feb 2023 10:17:20 -0600
Message-ID: <CAFkjPTm909jFaEnpmSMBu-6uZnPBVyU_KqMFzWCwbDopT4jCAA@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] fs/9p: Consolidate file operations and add
 readahead and writeback
To:     asmadeus@codewreck.org
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
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

On Sat, Feb 18, 2023 at 3:25 AM <asmadeus@codewreck.org> wrote:
>
> Ok so this bugged me to no end; that seems to be because we use the same
> v9fs_dir_release for v9fs_file_operations's .release and not just
> v9fs_dir_operations... So it's to be expected we'll get files here.
>
> At this point I'd suggest to use two functions, but that's probably
> overdoing it.
> Let's check S_ISREG(inode->i_mode) instead of fid->qid though; it
> shouldn't make any difference but that's what you use in other parts of
> the code and it will be easier to understand for people familiar with
> the vfs.
>

I can rename the function as part of the patch since it would be a bit
more accurate,
but then it is still in vfs_dir.  I think there did used to be two
functions but there
was so much overlap we collapsed into one.

>
> > diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> > index 33e521c60e2c..8ffa6631b1fd 100644
> > --- a/fs/9p/vfs_inode.c
> > +++ b/fs/9p/vfs_inode.c
> > @@ -219,6 +219,35 @@ v9fs_blank_wstat(struct p9_wstat *wstat)
> >       wstat->extension = NULL;
> >  }
> >
> > +/**
> > + * v9fs_flush_inode_writeback - writeback any data associated with inode
> > + * @inode: inode to writeback
> > + *
> > + * This is used to make sure anything that needs to be written
> > + * to server gets flushed before we do certain operations (setattr, getattr, close)
> > + *
> > + */
> > +
> > +int v9fs_flush_inode_writeback(struct inode *inode)
> > +{
> > +     struct writeback_control wbc = {
> > +             .nr_to_write = LONG_MAX,
> > +             .sync_mode = WB_SYNC_ALL,
> > +             .range_start = 0,
> > +             .range_end = -1,
> > +     };
> > +
> > +     int retval = filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
>
> Hmm, that function only starts the writeback, but doesn't wait for it.
>
> Wasn't the point to replace 'filemap_write_and_wait' with
> v9fs_flush_inode_writeback?
> I don't think it's a good idea to remove the wait before setattrs and
> the like; if you don't want to wait on close()'s release (but we
> probably should too) perhaps split this in two?
>

I had thought that this is what it does, of course I could just be getting
lucky.  The filemap_fdatawrite_wbc doesn't say anything about whether
WBC_SYNC_ALL forces a wait, but the next function (__filemap_fdatawrite_range)
does: (it it calls filemap_fdatawrite_wbc)

* If sync_mode is WB_SYNC_ALL then this is a "data integrity" operation, as
* opposed to a regular memory cleansing writeback. The difference between
* these two operations is that if a dirty page/buffer is encountered, it must
* be waited upon, and not just skipped over.

So I think we are good?  Happy to use a different function if it makes sense,
but this was the one that seemed to trigger the correct behavior.

       -eric
