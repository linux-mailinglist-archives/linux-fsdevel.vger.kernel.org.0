Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888B592A53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 09:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiHOHTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 03:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241635AbiHOHSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:18:43 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E891CB14
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 00:18:33 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id b22so1569223uap.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3yQitVwK3MjSywSSI/LZlhSkZS+Tvqx4CoocVC9RkTQ=;
        b=dWNC98C/IJtl7OA8v/Zjhe3QJj9YaIXCRCQVbQ+4KFF0KnqtQ3sr94uUNUmYP+uILn
         HKHMP4q98eSfiAVEdWsO1ly0BWQvOta0TR52z1egXYPiJGTVuGQ/dOZXywpc6EvXnC6U
         OOmIUwyhB+5CvF/dQ7Yg0Y9HcbYXGOICQ35S2ranEbECNnt+8GNGLsldoE5wwbI6xc6M
         p+rtfliNbTK1nZKcTea75VLpWVmmicpKAOHh7QWxrsGTmqkPa9IJ4IOKC72IkU2YIHOl
         A7dAOSyzjHcl1CXGHk+wGs8enjt9WIRhNRl9M9hOLwd/aYil+YOIL7A4LefZcs5Auq7j
         kFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3yQitVwK3MjSywSSI/LZlhSkZS+Tvqx4CoocVC9RkTQ=;
        b=5dLmRxDV6CLdF4Kh9dPKC3xDjd72fOZqIt+iMGZmcq3e2mKJC6ZrupPuLXyIo2cVyH
         en1Fyx+7PnKfiaqfC2ZDvHxb7tXAHgJwTVs/rac1wtnBRxRu+J3aNPeoWhp3/n4XyNY+
         D0X+SGVSqYiM6qo0gDryxmVVN4OXnnJuRdydig/S/1yrk35KeA2ZaYeEW896gf2mvxmu
         D9aBZZK0iI0/PWwMcH0B3WwN11JhYTvXzluVMf9RIQB1K4PP8lS/OS2QV3ZdWYo6VxAs
         8FUtTpNR2o4a+mKI+WUAh0LILg0kUrP63shyOQ1/H9qfRScQNesvH4XPSIlRamv1Vbx7
         2nTg==
X-Gm-Message-State: ACgBeo3i/E1qEaAxK0mA2XGivH59UAl9pou2TmnAFtSz9ATDrDsX2Ze4
        bHfLjntffqMAR23w5LLw/66yC+CB+TTFMEljudk=
X-Google-Smtp-Source: AA6agR6nj8vC+KabK4YIkCLPzOZ7MwVGc6OD6UbOKevDnUWg5xYGjLehdl3pBXxxBvTaZmK2Yx/T83c/lGuXAvLqL70=
X-Received: by 2002:ab0:1c56:0:b0:384:cbd7:4329 with SMTP id
 o22-20020ab01c56000000b00384cbd74329mr5736584uaj.9.1660547912892; Mon, 15 Aug
 2022 00:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220814152322.569296-1-amir73il@gmail.com> <Yvk3hPpCsX4H2/MR@ZenIV>
In-Reply-To: <Yvk3hPpCsX4H2/MR@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Aug 2022 10:18:21 +0300
Message-ID: <CAOQ4uxgWNQEznKQwyJOkY5pRmyOZqf-07kwBFa4O5kL98kAYkA@mail.gmail.com>
Subject: Re: [PATCH] locks: fix TOCTOU race when granting write lease
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
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

On Sun, Aug 14, 2022 at 8:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Aug 14, 2022 at 06:23:22PM +0300, Amir Goldstein wrote:
> > Thread A trying to acquire a write lease checks the value of i_readcount
> > and i_writecount in check_conflicting_open() to verify that its own fd
> > is the only fd referencing the file.
> >
> > Thread B trying to open the file for read will call break_lease() in
> > do_dentry_open() before incrementing i_readcount, which leaves a small
> > window where thread A can acquire the write lease and then thread B
> > completes the open of the file for read without breaking the write lease
> > that was acquired by thread A.
> >
> > Fix this race by incrementing i_readcount before checking for existing
> > leases, same as the case with i_writecount.
> >
> > Use a helper put_file_access() to decrement i_readcount or i_writecount
> > in do_dentry_open() and __fput().
> >
> > Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write lease")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Looks sane; I'd probably collapsed cleanup_file and cleanup_all while we are
> at it, but then I can do that in a followup as well.
>

Not sure how you envision that cleanup, so I'll let you do it.

> > +static inline void put_file_access(struct file *file)
> > +{
> > +     if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
> > +             i_readcount_dec(file->f_inode);
> > +     } else if (file->f_mode & FMODE_WRITER) {
> > +             put_write_access(file->f_inode);
> > +             __mnt_drop_write(file->f_path.mnt);
> > +     }
> > +}
>
> What's the point of having it in linux/fs.h instead of internal.h?

No reason. Overlooked.
Do you need me to re-send or will you move it to internal.h yourself?

Thanks,
Amir.
