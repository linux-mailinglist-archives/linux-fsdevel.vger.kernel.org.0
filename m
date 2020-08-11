Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DDA241CA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgHKOor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 10:44:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47680 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728794AbgHKOom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597157080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBaHdbgWBei9PGc74NIX+QA+JMkdKt8VgiXEsDFjFk4=;
        b=NmJHWBO6GuZ2LmSTwaQof1BFbfub66NUVOxYbma/c99J0cNKBQwQgynF7hvBwDsQ+iGBlL
        hDGopMzpbWgSkOg8lfiXFr7AF2O/2gpSskyGQBYyT9hSRnBe+TkqNMkjcfmOivRbKb1Z0D
        0xUfIlw00/HzdJ+6goIj6Ck35eMfXyk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-6WOCOB3xM823syKSMktpGA-1; Tue, 11 Aug 2020 10:44:36 -0400
X-MC-Unique: 6WOCOB3xM823syKSMktpGA-1
Received: by mail-wm1-f71.google.com with SMTP id h6so1051642wml.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 07:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBaHdbgWBei9PGc74NIX+QA+JMkdKt8VgiXEsDFjFk4=;
        b=fnfY61LYu1g7UZS6s/RpHH9gMPfnTU5xyriYgMhtsfrsU/O/jKQ5TJMAmPgEhOK4TH
         YgKm8uBOo9i163t3oRPYQ9YPW3TpddoVUcenqtV+UdDoTlCZM2hNdMz0dmaP6vfJchdq
         TDW53WGmqkDL8YaQNHDImXy8qtH3UYDZ2KgdUpnZ6tXOB4hwCEfmcsyYkJc2XWb2HcH8
         zQoXZbJCVF4YTgdqdFGuNPZx432ivGY8A0bj2uKGVlwgvsM4P5aMMOnem6HWmXV1U27i
         wuAlC01TYjMeMUR5ejem5AZY++APQtvMHWlwnGF0UmEpdZMMNFAH9EpG/KegGI0K/FDp
         /agg==
X-Gm-Message-State: AOAM5335cvNhFFh1PQiLuR2Hslo5rHOKZer4ouJMQbs+UpzChB+hbgrv
        a81hfgW+CVexYy+OQ0nGh/Nw+h0TG42GODojK0pzVHhjzkQqHyRIzJgPSXWTbsdFrmQw/cXSCYI
        wAxB+EaA/y0pkYVwskSUlxgOj+Q==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr4034378wmk.125.1597157075123;
        Tue, 11 Aug 2020 07:44:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0PTTFxjBv2fKmGNBax++pGGY3UvTBaVwdqqwXV0cnxjCNtFxDB5PgFxhVxAtR3xQ8Kg8yRA==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr4034367wmk.125.1597157074886;
        Tue, 11 Aug 2020 07:44:34 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id h11sm22331259wrb.68.2020.08.11.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 07:44:34 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:44:19 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+996f91b6ec3812c48042@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: possible deadlock in __io_queue_deferred
Message-ID: <20200811144419.blu4wufu7t4dfqin@steredhat>
References: <00000000000035fdf505ac87b7f9@google.com>
 <76cc7c43-2ebb-180d-c2c8-912972a3f258@kernel.dk>
 <20200811140010.gigc2amchytqmrkk@steredhat>
 <504b4b08-30c1-4ca8-ab3b-c9f0b58f0cfa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504b4b08-30c1-4ca8-ab3b-c9f0b58f0cfa@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:21:12AM -0600, Jens Axboe wrote:
> On 8/11/20 8:00 AM, Stefano Garzarella wrote:
> > On Mon, Aug 10, 2020 at 09:55:17AM -0600, Jens Axboe wrote:
> >> On 8/10/20 9:36 AM, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    449dc8c9 Merge tag 'for-v5.9' of git://git.kernel.org/pub/..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=14d41e02900000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d25235bf0162fbc
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=996f91b6ec3812c48042
> >>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c9006900000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1191cb1a900000
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>> Reported-by: syzbot+996f91b6ec3812c48042@syzkaller.appspotmail.com
> >>
> >> Thanks, the below should fix this one.
> > 
> > Yeah, it seems right to me, since only __io_queue_deferred() (invoked by
> > io_commit_cqring()) can be called with 'completion_lock' held.
> 
> Right
> 
> > Just out of curiosity, while exploring the code I noticed that we call
> > io_commit_cqring() always with the 'completion_lock' held, except in the
> > io_poll_* functions.
> > 
> > That's because then there can't be any concurrency?
> 
> Do you mean the iopoll functions? Because we're definitely holding it
> for the io_poll_* functions.

Right, the only one seems io_iopoll_complete().

So, IIUC, in this case we are actively polling the level below,
so there shouldn't be any asynchronous events, is it right?

Thanks,
Stefano

