Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B071043AEC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 11:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhJZJPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbhJZJPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:15:13 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7658C061745;
        Tue, 26 Oct 2021 02:12:49 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id w15so14761723ilv.5;
        Tue, 26 Oct 2021 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Oai2wOe1AGF3iqBwEe9CYczT8VlXBX5xUWDEgUl+WU=;
        b=AzWxt5tq5ZsIATWTLUCIn4b5/fazx53yfLIPZ09A3YI847pBnaRNmu02JJ38Zs8QHG
         tNkvMw/uqh/OJMUcvJREa7YgyAjpxTXsAKnFvieyn9rb7QfKckt6fRmq/+IGscR9f44e
         RTsRQCgwXlz3FSpWrS5iwC2nXjrxcrRjmh7vFZ3eFaCL3hONHeV4t57YA+dKBrEjNIab
         qDBsQah5V8ann5/1Uo08y+8uXal6kMONy4XuEWXb9Wxq2xf8GnH/UAiMz1rTYfWKHcDr
         TUt6jvXOUot6BkJBdGSAwB9rxBdVuBs1cbKmmw73ReWdCWF+kPuCh2To9+xK3UZTSF/t
         AXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Oai2wOe1AGF3iqBwEe9CYczT8VlXBX5xUWDEgUl+WU=;
        b=5X2VA8PMMt1g8X++N4Uw859RIov9b8spJAtWeK5svubNaP4UNU1MzflSsDhCrLxbtg
         hsh+duqmuX0hhF4Uh1LCuWe3jyOekcyypy9gF+gzJIhgJOsLdERHgSrfRjDx5CxZ445x
         sudZ7DzrsgStPXC81HSYJ9/pseFR8dMdQGwDmTGGoKxdxcFYfyr3Tt1OOlGn0BD2JfYi
         7K3CCIhvq7emFbFIfeQcrLdlGheuQqCbCva+CS+8J53R4L/WGknxStySgfFOgqL/Xpxx
         +xo1Z7q4WVXd17ZjqlrQgjID39vMc4dundA2lAt7DM7UE8P8gGskOdGzqjYl0CtfZvGa
         ys0w==
X-Gm-Message-State: AOAM530BDamwT5ht3AOBBPX5ITyvGpsV79hSri1BPYkB9rZHpAkSE7Ay
        ec54jE0fSOULj7Kg2JfZRK8cfzWJVNvOOK4QzfeB26jF
X-Google-Smtp-Source: ABdhPJwI9lOb7TOZOUBOkXMFcKopjIZYsIcX/wDirhRejQsS5GabWJAM3hXduUtpJmnm+hq4gZAzBmcKZfz0zw/Aj0U=
X-Received: by 2002:a05:6e02:18cf:: with SMTP id s15mr8854138ilu.198.1635239569184;
 Tue, 26 Oct 2021 02:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211025192746.66445-1-krisman@collabora.com>
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 12:12:38 +0300
Message-ID: <CAOQ4uxhth8NP4hS53rhLppK9_8ET41yrAx5d98s1uhSqrSzVHg@mail.gmail.com>
Subject: Re: [PATCH v9 00/31] file system-wide error monitoring
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:27 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> This is the 9th version of this patch series.  Thank you, Amir, Jan and
> Ted, for the feedback in the previous versions.
>
> The main difference in this version is that the pool is no longer
> resizeable nor limited in number of marks, even though we only
> pre-allocate 32 slots.  In addition, ext4 was modified to always return
> non-zero errno, and the documentation was fixed accordingly (No longer
> suggests we return EXT4_ERR* values.
>
> I also droped the Reviewed-by tags from the ext4 patch, due to the
> changes above.
>
> Please let me know what you think.
>

All good on my end.
I've made a couple of minor comments that
could be addressed on commit if no other issues are found.

Thanks,
Amir.
