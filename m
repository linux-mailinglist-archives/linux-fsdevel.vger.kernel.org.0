Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9624C9E88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 08:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiCBHop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 02:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiCBHoo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:44:44 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92FD4BB87;
        Tue,  1 Mar 2022 23:44:01 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id h16so802933iol.11;
        Tue, 01 Mar 2022 23:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++OTgTwo7iXFzfN0uHbaZEh5LQe7AyrspLNr4fyrrjQ=;
        b=Wf2ltiaPi0zU2Db1oiCjhueQW1LzqppMg1bwnKSZEVbqEXd/kLJJRvKQKOtqVDklX+
         1VUiWHVPiVrn0VTnUW5BZ38m7vI4gAnA8MC3THpa8RCinMDzeWXtngE/TlonIn8shoVq
         16GsEUnyrG3duzRFWvUBeACi6UcIhOHGysxkRiiWz4JCkX7aTEoBwAki9bsOg3ggwsFc
         Eai757tH3Rq/yRxVj3MWCkfVgDvYotn4tQRlmsQ0qbSzJfu+BtjweEzNVFGOPpGZtScf
         P9oUWOy2SUYI3tDxbQk7p6haDDqno41MEEZ7cOXI/7k5ajuFi9CIOB/KShxg+PIymZ47
         YdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++OTgTwo7iXFzfN0uHbaZEh5LQe7AyrspLNr4fyrrjQ=;
        b=G9BV5xI+giy75ywpq4Uv7oDtCJ0iP9OumKVE1OQXNoDq4AWfDdAfZwzwQ2p4jH4deg
         0pXHcYal/D/IBs2lgrgUbFPhqOPOoGiurLEiUDDjXEsQ7eTmb4/RRm/C2Ah15G135OaA
         n0YDQcckZdItRgp34sI3s/7NVew+Tc6jQoauXLrl/EXNBgKim2XzTrE04NG0B5b8HZld
         wPR8Lw1+AmJ9TiQHTnCOXOqkvbeNavsrK4+7ebaT1HBFYKnB9tjaaL7Iy+/4xBAlBsLj
         aoMuyl5WJmiqXbkVLpcqt+QhLzcCW18bpqTjeRGdDBcM4zrjc6UW9eCIAAHx9ur40KdX
         h89Q==
X-Gm-Message-State: AOAM5321rjmLKbXko0OHJKfGChhg9LrpghiL+xaU5x1Pefb7bZgxliDN
        owWtmXqx2/+AkKW5n0V5j1wAs+yzmDLuPpAMy60=
X-Google-Smtp-Source: ABdhPJxiYxN4dvNmxIz1xCP9G3IgyMlyA4dhO1fJ81F3jAUMclAsP9Ttp5zT8WayTsY2uFo8X8f5yJre+OrXCQ8sdRM=
X-Received: by 2002:a02:ccac:0:b0:314:2074:fec4 with SMTP id
 t12-20020a02ccac000000b003142074fec4mr24657906jap.41.1646207041097; Tue, 01
 Mar 2022 23:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20220301184221.371853-1-amir73il@gmail.com> <20220302065952.GE3927073@dread.disaster.area>
In-Reply-To: <20220302065952.GE3927073@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 2 Mar 2022 09:43:50 +0200
Message-ID: <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Generic per-sb io stats
To:     Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
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

On Wed, Mar 2, 2022 at 8:59 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Mar 01, 2022 at 08:42:15PM +0200, Amir Goldstein wrote:
> > Miklos,
> >
> > Following your feedback on v2 [1], I moved the iostats to per-sb.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://lore.kernel.org/linux-unionfs/20220228113910.1727819-1-amir73il@gmail.com/
> >
> > Changes since v2:
> > - Change from per-mount to per-sb io stats (szeredi)
> > - Avoid percpu loop when reading mountstats (dchinner)
> >
> > Changes since v1:
> > - Opt-in for per-mount io stats for overlayfs and fuse
>
> Why make it optional only for specific filesystem types? Shouldn't
> every superblock capture these stats and export them in exactly the
> same place?
>

I am not sure what you are asking.

Any filesystem can opt-in to get those generic io stats.
This is exactly the same as any filesystem can already opt-in for
fs specific io stats using the s_op->show_stats() vfs op.

All I did was to provide a generic implementation.
The generic io stats are collected and displayed for all filesystems the
same way.

I only included patches for overlayfs and fuse to opt-in for generic io stats,
because I think those stats should be reported unconditionally (to
mount options)
for fuse/overlayfs and I hope that Miklos agrees with me.

If there is wide consensus that all filesystems should have those stats
unconditionally (to mount options), then I can post another patch to make
the behavior not opt-in, but I have a feeling that this discussion
will take longer
than I care to wait before enabling the io stats for fuse/overlayfs,
so I would rather
start with enabling io stats for fuse/overlayfs and decide about the rest later.

How would you prefer the io stats behavior for xfs (or any fs) to be?
Unconditional to mount options?
Opt-in with mount option? (suggest name please)
Opt-in/out with mount options and default with Kconfig/sysfs tunable?
Anything else?

Thanks,
Amir.
