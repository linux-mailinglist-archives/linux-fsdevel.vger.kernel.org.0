Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9C4A552C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 03:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiBACOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 21:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiBACOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:14:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7EC061714;
        Mon, 31 Jan 2022 18:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JYRrAO+rGjrGmWTVcP9Q/99eC2Ydc3q77WLwtJ5/D/I=; b=ARFVWXTvqgh9loGdpfLCzM1XZQ
        RqHKl+VRvAlrnvShWLrk/jdYgfBssGu9mKM5NHo1VoOdTTQ7WRJdtkzZ8xh0gMQcPJhHY4wwj5ZBl
        unKZLiR9wispYmo26PvS96aD57XptQ6maSB2BWFx/Fy0Yl3BcXxZDhMbx4Tt/oqPzN2kJpME2DxUx
        lHJpJVNgVXGdBGEJJeKYm+Oi5j8jfbXcknjEY9hZheglgDVnrkml3ijUPgQ5mX1hOCncAhAXvdQzI
        Ie8DeK+KmMjTUAubZElszDUniBxsx6aesixHo7AHTtnRLxgTYiq2sMj5D+J8iONzJ9Necp/wbt1IN
        teQMxD/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEigs-00BCEc-4k; Tue, 01 Feb 2022 02:14:42 +0000
Date:   Tue, 1 Feb 2022 02:14:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Message-ID: <YfiXkk9HJpatFxnd@casper.infradead.org>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201013329.ofxhm4qingvddqhu@garbanzo>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:33:29PM -0800, Luis Chamberlain wrote:
> It would seem we keep tacking on things with ioctls for the block
> layer and filesystems. Even for new trendy things like io_uring [0].

I think the problem is that it's a huge effort to add a new syscall.
You have to get it into each architecture.  Having a single place to
add a new syscall would help reduce the number of places we use
multiplexor syscalls like ioctl().

> For a few years I have found this odd, and have slowly started
> asking folks why we don't consider alternatives like a generic
> netlink family. I've at least been told that this is desirable
> but no one has worked on it.

I don't know that I agree that "generic netlink" is desirable.
I'd like to know more about the pros and cons of this idea.

> Possible issues? Kernels without CONFIG_NET. Is that a deal breaker?
> We already have a few filesystems with their own generic netlink
> families, so not sure if this is a good argument against this.
> 
> mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family fs
> fs/cifs/netlink.c:      ret = genl_register_family(&cifs_genl_family);
> fs/dlm/netlink.c:       return genl_register_family(&family);
> fs/ksmbd/transport_ipc.c:       ret = genl_register_family(&ksmbd_genl_family);
> fs/quota/netlink.c:     if (genl_register_family(&quota_genl_family) != 0)

I'm not sure these are good arguments in favour ... other than quota,
these are all network filesystems, which aren't much use without
CONFIG_NET.

> mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family drivers/block
> drivers/block/nbd.c:    if (genl_register_family(&nbd_genl_family)) {

The, er, _network_ block device, right?
