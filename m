Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4526F44056B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Oct 2021 00:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJ2W0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 18:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ2W0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:26:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8AC061570;
        Fri, 29 Oct 2021 15:24:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4CC991F45CD8;
        Fri, 29 Oct 2021 23:24:04 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
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
Subject: Re: [PATCH v9 00/31] file system-wide error monitoring
Organization: Collabora
References: <20211025192746.66445-1-krisman@collabora.com>
        <CAOQ4uxhth8NP4hS53rhLppK9_8ET41yrAx5d98s1uhSqrSzVHg@mail.gmail.com>
        <20211027112243.GE28650@quack2.suse.cz>
        <CAOQ4uxgUdvAx6rWTYMROFDX8UOd8eVzKhDcpB0Qne1Uk9oOMAw@mail.gmail.com>
        <87y26ed3hq.fsf@collabora.com>
        <CAOQ4uxh4ikTUHM6=s09+bq=VAjBsZeU9UXPv8K1XpvxwVU6tMw@mail.gmail.com>
Date:   Fri, 29 Oct 2021 19:23:55 -0300
In-Reply-To: <CAOQ4uxh4ikTUHM6=s09+bq=VAjBsZeU9UXPv8K1XpvxwVU6tMw@mail.gmail.com>
        (Amir Goldstein's message of "Thu, 28 Oct 2021 08:55:02 +0300")
Message-ID: <8735oja2ro.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

>> Also, thank you both for the extensive review and ideas during the
>> development of this series.  It was really appreciated!
>>
>
> Thank you for your appreciated effort!
> It was a wild journey through some interesting experiments, but
> you survived it well ;-)
>
> Would you be interested in pursuing FAN_WB_ERROR after a due rest
> and after all the dust on FAN_FS_ERROR has settled?

I think it would make sense for me to continue working on it, yes.  But,
before that, I think I still have some support to add to FAN_FS_ERROR,
like a detailed, fs-specific, info record, and an error location info
record, which has a use-case in Google Cloud environments.  I have to
discuss priorities internally, but we (collabora) do have an interest in
supporting WB_ERROR too.

For the detailed error report, fanotify could have a new info record
that carries a structure sent out by the file system.  fanotify could
handle the lifetime of this object, by keeping a larger mempool, or
delegate its allocation/destruction to the filesystem.

Like I proposed in an earlier version of FAN_FS_ERROR, the format could
be as simple as:

struct fanotify_error_data_info {
   struct fanotify_event_info_header hdr;
   char data[];
}

I think xfs, at least, would be able to make good use of this record with
xfs_scrub, as the xfs maintainers mentioned.

-- 
Gabriel Krisman Bertazi
