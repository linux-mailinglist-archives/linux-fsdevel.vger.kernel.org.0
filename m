Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B040B4C6ED7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 15:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiB1OGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 09:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiB1OGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:06:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45687E5A2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 06:06:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 582481F899;
        Mon, 28 Feb 2022 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646057160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/16AvN4llS/f34OVQEMQe/9uv0Lo1s847duDK3U1Ls=;
        b=xSiIjI4Yk7kOp2YCfneJiFdwNSZ5gFAmNad2IAqUbQxcbaiX8Gzw9m6SFCxlDu1kDj6tYF
        ECMYWYBTVfDH1+X327uVnOpU6DTIeShQACnbZVHAXEf5xe+9QeiiVwu1F1rhU9Kozgv2mZ
        djlfNhWuqYwRrVRYwPfYhOdM/PaZS1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646057160;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/16AvN4llS/f34OVQEMQe/9uv0Lo1s847duDK3U1Ls=;
        b=xQHDOFd24+b1ZfmKhw4IsdDKbmt/xvRbwiWZ+KzQo+ksq/sLDlS/DAOACkQfBh4tkloBNm
        spznljwUu+eFfoDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4CCBFA3B85;
        Mon, 28 Feb 2022 14:06:00 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 07A27A0608; Mon, 28 Feb 2022 15:05:57 +0100 (CET)
Date:   Mon, 28 Feb 2022 15:05:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] Volatile fanotify marks
Message-ID: <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Wed 23-02-22 20:42:37, Amir Goldstein wrote:
> I wanted to get your feedback on an idea I have been playing with.
> It started as a poor man's alternative to the old subtree watch problem.
> For my employer's use case, we are watching the entire filesystem using
> a filesystem mark, but would like to exclude events on a subtree
> (i.e. all files underneath .private/).
> 
> At the moment, those events are filtered in userspace.
> I had considered adding directory marks with an ignored mask on every
> event that is received for a directory path under .private/, but that has the
> undesired side effect of pinning those directory inodes to cache.
> 
> I have this old fsnotify-volatile branch [1] that I am using for an overlayfs
> kernel internal fsnotify backend. I wonder what are your thoughts on
> exposing this functionally to fanotify UAPI (i.e. FAN_MARK_VOLATILE).

Interesting idea. I have some reservations wrt to the implementation (e.g.
fsnotify_add_mark_list() convention of returning EEXIST when it updated
mark's mask, or the fact that inode reclaim should now handle freeing of
mark connector and attached marks - which may get interesting locking wise)
but they are all fixable.

I'm wondering a bit whether this is really useful enough (and consequently
whether we will not get another request to extend fanotify API in some
other way to cater better to some other usecase related to subtree watches
in the near future). I understand ignore marks are mainly a performance
optimization and as such allowing inodes to be reclaimed (which means they
are not used much and hence ignored mark is not very useful anyway) makes
sense. Thinking about this more, I guess it is useful to improve efficiency
when you want to implement any userspace event-filtering scheme.

The only remaining pending question I have is whether we should not go
further and allow event filtering to happen using an eBPF program. That
would be even more efficient (both in terms of memory and CPU). What do you
think?

								Honza

> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/linux/commits/fsnotify-volatile
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
