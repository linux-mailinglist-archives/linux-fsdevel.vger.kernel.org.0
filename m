Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A5C42EC91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhJOIk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhJOIk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:40:26 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3ABC061570;
        Fri, 15 Oct 2021 01:38:20 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d11so6320403ilc.8;
        Fri, 15 Oct 2021 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYX48g/GByb5COiqBCRcxJ2MLkXfZEqi7srhgCtRw9w=;
        b=DIiUrjFqocE4pTm5C5n+cDKaRzu5e4vYsiMCS38pEl3HYJzLt8s7ahTngoBwNZHP0P
         uInVxQOppKSheiqgXZMwLLxliHTEFS+eOp9dm4Xi7kdd4luPQUpX9VloZcpQkb1oQJu6
         GBlOWTvYEshYktFU2eX6JV8TM7uZRfYaLbs75FU/vMAr0G2porxAM4fhasPJOQ7vtmNR
         1kzKQxJ9z7p+sxteRTbr6hJjY1uim+gb8za0LHERvQ+mQaCiZbfnsUOpfolm1c5fz+ca
         PTDscvoe9nk3HJg3G0Y3G0q7AkCXc+3i69GGyZFftxIcP7rNORZRmFKfVqhuzHP8rAXC
         4j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYX48g/GByb5COiqBCRcxJ2MLkXfZEqi7srhgCtRw9w=;
        b=feEd6xFue+/ONKr77mBMNOxyaQ+vtvTLYmbUKv3WJIp+6/Y8/h0EM5RGRUrlUQEC4k
         Vrc4tsO64LmkJmp5pWU9T2h8UL1JB7kkBXXjaTdgEiBX5EkuJF3nFGKmLhfV/LAKgM/7
         5bcZl9U5cI5GoUJpg7Bg6gVBRwoQMWozGEwU1epJv6I0ccQOUay1W85TID6xWYJN35GO
         zR/6fmvduU25ux9E3fm4zt9U2ZbupmnnxdqO2LYj3hi+XlFkUUEHq9MdwSv2LWyIXtfy
         6ClVwCu/5T2P2mpYlYAQJdvU3DPh5eHzku4fRyh34h/NVbgG+Xg/1R0N57eDLD/yWDYG
         4x1w==
X-Gm-Message-State: AOAM532UsvMv/WaWaXdXgMGaG7w5EIyGtUpIzECTqHX/kz/tnXMQimLR
        E7XLNhDW4PkJNFQ/1j17Ks1pX9H+DFZrS5OxxSnxGtWJ
X-Google-Smtp-Source: ABdhPJxTVtr48odjWeXRDtCCHSnnKAUFDUKrACrtyeAaHgltYNVp3FAdohLYBL64Dkx5Cfz5bvdM25/zVLu+XAQrC4o=
X-Received: by 2002:a05:6e02:20ed:: with SMTP id q13mr3032792ilv.254.1634287099558;
 Fri, 15 Oct 2021 01:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 11:38:08 +0300
Message-ID: <CAOQ4uxgZbw1L1=oyFvz1=ZPt8VxgR3cVxVTLzqGg+iBA+ffaCw@mail.gmail.com>
Subject: Re: [PATCH v7 00/28] file system-wide error monitoring
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:37 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> This attempts to get the ball rolling again for the FAN_FS_ERROR.  This
> version is slightly different from the previous approaches, since it uses
> mempool for memory allocation, as suggested by Jan.  It has the
> advantage of simplifying a lot the enqueue/dequeue, which is now much
> more similar to other event types, but it also means the guarantee that
> an error event will be available is diminished.

Makes me very happy not having to worry about new enqueue/dequeue bugs :)

>
> The way we propagate superblock errors also changed. Now we use
> FILEID_ROOT internally, and mangle it prior to copy_to_user.
>
> I am no longer sure how to guarantee that at least one mempoll slot will
> be available for each filesystem.  Since we are now tying the poll to
> the entire group, a stream of errors in a single file system might
> prevent others from emitting an error.  The possibility of this is
> reduced since we merge errors to the same filesystem, but it is still
> possible that they occur during the small window where the event is
> dequeued and before it is freed, in which case another filesystem might
> not be able to obtain a slot.

Double buffering. Each mark/fs should have one slot reserved for equeue
and one reserved for copying the event to user.

>
> I'm also creating a poll of 32 entries initially to avoid spending too
> much memory.  This means that only 32 filesystems can be watched per
> group with the FAN_FS_ERROR mark, before fanotify_mark starts returning
> ENOMEM.

I don't see a problem to grow the pool dynamically up to a reasonable
size, although it is a shame that the pool is not accounted to the group's
memcg (I think?).

Overall, the series looks very good to me, modulo to above comments
about the mempool size/resize and a few minor implementation details.

Good job!

Thanks,
Amir.
