Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03F343DAEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 07:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJ1F5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 01:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhJ1F5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:57:39 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7CAC061570;
        Wed, 27 Oct 2021 22:55:13 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e144so6645884iof.3;
        Wed, 27 Oct 2021 22:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1Qv5Ha/AVr8z6tBWvM7R8PNlhV8VsJhutwgW5hkM1A=;
        b=n1lrrBCc1IRjgSOk59tL/gJd4rZ08V8t5u771YjfQQUwLLprd5tUdUM4RzuScv8TWv
         xKmIQJPs8mhSM9/7E+0Vo1xxpM2Yrzh9hiaBWDTegfiwKHaYmZDxV/Z+njCKPbb+Od2E
         ZqodtrNd+xCI0xrJg0uLSkd89abRtmJbeLIoeOjgEYCuip3swTFDlVQlFSTQAHicDO6W
         ppfQW0EiFU7c0K1EXeSE4S8xsY/SLeNNN9wOUcAGfQf/xfar4OtdllZkmqULaxEgIzYY
         S25v65TY0x2ycd+Sd7trkQaFC9NM5Q+vilLlAqRCdX4zEu5P/SX2EtiQW3dM7rlxQbPf
         Vzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1Qv5Ha/AVr8z6tBWvM7R8PNlhV8VsJhutwgW5hkM1A=;
        b=lIIXwQqqEI0elSbyWvcKDpWlXD+TY/f2xv1sHcEsijxLW8FP8ARr9euSd0oHLeIkeT
         YW8rKVtJoKeAPwColeoIp4JrG3UbAEv26Xcg+BNV9GiuvuUmfekzevb7SKkFVQdjjBgL
         smyvDb7z0HPwuCYeUWjeRQnZ1JTExWOgsVWR2hqOQSJINZTacIB1kq2jq3FUQXn1Trp4
         gmq/H2nc691M+xb7o2PZ+awyzrCYhd5vmZ1w/EWtkKRgzC0DyqLnZ3f7uTYjvsDo5y3p
         1hBzpU5lCzVAn4dJQkA/ONVHfL7bC6C6GdcAqGROrHUodOiGsUF2uHxNSX09z1JLVqCo
         bgww==
X-Gm-Message-State: AOAM531OR4jVH/3l0LoyjNvUEElUmpInfNN85/kzylyyOBwR3hwdx/E/
        q7b6d8g3ApNGm1yBk9RvEvqisE8atJ4K0fSs6W0=
X-Google-Smtp-Source: ABdhPJyplMOilQsE8HyKh893i0jitWtdeaj+DNxYBV50selVLA8y7/+hpIp4lY8Gw6bdZcwCiaE/XS7REwgegs/djp0=
X-Received: by 2002:a02:270c:: with SMTP id g12mr1668623jaa.75.1635400512787;
 Wed, 27 Oct 2021 22:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211025192746.66445-1-krisman@collabora.com> <CAOQ4uxhth8NP4hS53rhLppK9_8ET41yrAx5d98s1uhSqrSzVHg@mail.gmail.com>
 <20211027112243.GE28650@quack2.suse.cz> <CAOQ4uxgUdvAx6rWTYMROFDX8UOd8eVzKhDcpB0Qne1Uk9oOMAw@mail.gmail.com>
 <87y26ed3hq.fsf@collabora.com>
In-Reply-To: <87y26ed3hq.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 28 Oct 2021 08:55:02 +0300
Message-ID: <CAOQ4uxh4ikTUHM6=s09+bq=VAjBsZeU9UXPv8K1XpvxwVU6tMw@mail.gmail.com>
Subject: Re: [PATCH v9 00/31] file system-wide error monitoring
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Jeff Layton <jlayton@kernel.org>, andres@anarazel.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Also, thank you both for the extensive review and ideas during the
> development of this series.  It was really appreciated!
>

Thank you for your appreciated effort!
It was a wild journey through some interesting experiments, but
you survived it well ;-)

Would you be interested in pursuing FAN_WB_ERROR after a due rest
and after all the dust on FAN_FS_ERROR has settled?

FAN_WB_ERROR can use the same info record and same internal
error event struct as FAN_FS_ERROR.

A call to fsnotify_wb_error(sb, inode, err) can be placed inside
mapping_set_error() and maybe for other sporadic callers of errseq_set().

For wb error, we can consider storing a snapshot of errseq of the sb/inode
in the sb/inode mark and compute error_count from the errseq diff
instead of counting it when merging events. This will keep a more accurate
report even when error reports are dropped due to allocation failure or event
queue overflow.

I have a feeling that the Postgres project would find this
functionality useful (?).

Thanks,
Amir.
