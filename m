Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35D742ED5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhJOJSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:18:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57638 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhJOJSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:18:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 01F211FD39;
        Fri, 15 Oct 2021 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634289408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6549bR2vXBIEchZx9DAUlXW4W6+twgOjtOTZJzZ16EU=;
        b=oynwQ2IArfOgGvtU6N/w3BomxDSWt2tIoPANgXhmgXWOuieizWHs15VmyBXWavCYY1itma
        /SZ3u50qx8EMRsFOLW+zFHv0kUkoR6w1ApmolH4W2iZgJt9a9Qa0aThN9XifAlAWWk344J
        La5NPbAmYSNE2xqDAZzahXCdYP9r8Mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634289408;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6549bR2vXBIEchZx9DAUlXW4W6+twgOjtOTZJzZ16EU=;
        b=18Nj6kfC6lcRR3Zt8B4m4lOaM41exYbseIeKymwfcI/P3ap7B/AS4WEyho02s51qXEgeGq
        1X0J8Msj7zJFQKCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id DDC13A3B88;
        Fri, 15 Oct 2021 09:16:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B1C9F1E0A40; Fri, 15 Oct 2021 11:16:44 +0200 (CEST)
Date:   Fri, 15 Oct 2021 11:16:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v7 00/28] file system-wide error monitoring
Message-ID: <20211015091644.GA23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Thu 14-10-21 18:36:18, Gabriel Krisman Bertazi wrote:
> This attempts to get the ball rolling again for the FAN_FS_ERROR.  This
> version is slightly different from the previous approaches, since it uses
> mempool for memory allocation, as suggested by Jan.  It has the
> advantage of simplifying a lot the enqueue/dequeue, which is now much
> more similar to other event types, but it also means the guarantee that
> an error event will be available is diminished.
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

Yes, but this happening would mean we hit this race on one fs, error on
another fs, and ENOMEM with GFP_NOFS allocation to top it. Not very likely
IMO. Also in that case we will  queue overflow event in
fanotify_handle_event() so it will not be silent loss. The listening
application will learn that it missed some events.

> I'm also creating a poll of 32 entries initially to avoid spending too
> much memory.  This means that only 32 filesystems can be watched per
> group with the FAN_FS_ERROR mark, before fanotify_mark starts returning
> ENOMEM.

We can consider auto-grow as Amir suggests but I also think you somewhat
misunderstand how mempools work. If you call mempool_alloc(), it will first
try to allocate memory with kmalloc() (using GFP_NOFS mask which you pass
to it).  In 99.9% of cases this just succeeds. If kmalloc() fails, only
then mempool_alloc() will take one of the preallocated events and return
it. So even with mempool of size 32, we will not usually run out of events
when we have more than 32 filesystems. But it is true we cannot guarantee
reporting error to more than 32 filesystems under ENOMEM conditions. I'm
not sure if that matters...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
