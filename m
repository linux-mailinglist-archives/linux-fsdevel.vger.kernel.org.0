Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F36F02E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbjD0JAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 05:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbjD0I74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:59:56 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6063B4ECD;
        Thu, 27 Apr 2023 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LmHHlXIKW9/orZtcV4HerTvYyR60e8ztaz0uD2QswXU=; b=dppESrIPtiFuYxa2InrZTl+gdy
        2CgcY5nTmM53Q1JLYnC5NGB3/fRaNTE3q2mY2MMY99oYfHIyJbzC+UUf3VLOFHfoa0iV/8mXw2Srg
        JduE8m7++7thej7YXC9rkyKQIbOROXiR0kXyReT7Bh8IzXHY+l7YbRNX8tuVQ98wZ/1vIZyhP+4c4
        MXcxEgqALWeb410oApdJtATl1bx8tI38BiZeiigB8Wrvvig6lpv93eMwt9Y7UL95hiEmgkHDoP2XA
        a2ZVZhXKpD4BM7nbZWAQhn7BDr6kZ3phFaURHzlA+SWDByxdackLgZ3e7aTgc6iBpOuLU0ejd5hh3
        4Q5RJVRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prxTk-00D6qt-0E;
        Thu, 27 Apr 2023 08:59:52 +0000
Date:   Thu, 27 Apr 2023 09:59:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230427085952.GB3390869@ZenIV>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230427010715.GX3390869@ZenIV>
 <20230427073908.GA3390869@ZenIV>
 <20230427-postweg-ruder-ae997dab3346@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427-postweg-ruder-ae997dab3346@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:33:38AM +0200, Christian Brauner wrote:

> File descriptor installation is not core functionality for drivers. It's
> just something that they have to do and so it's not that people usually
> put a lot of thought into it. So that's why I think an API has to be
> dumb enough. A three call api may still be simpler to use than an overly
> clever single call api.

Grep and you will see...  Seriously, for real mess take a look at e.g.
drivers/gpu/drm/amd/amdkfd/kfd_chardev.c.  See those close_fd() calls in
there?  That's completely wrong - you can't undo the insertion into
descriptor table.

I'm not suggesting that for the core kernel, but there's a plenty of
drivers that do descriptor allocation.

Take a look at e.g. drivers/media/mc/mc-request.c:media_request_alloc().
OK, we open, insert, etc. and we pass the descriptor to caller in
*alloc_fd.  Caller is in drivers/media/mc/mc-device.c:
static long media_device_request_alloc(struct media_device *mdev, void *arg)
and descriptor goes into *(int *)arg there.  That is reached via
static const struct media_ioctl_info ioctl_info[] = {
        MEDIA_IOC(DEVICE_INFO, media_device_get_info, MEDIA_IOC_FL_GRAPH_MUTEX),
	MEDIA_IOC(ENUM_ENTITIES, media_device_enum_entities, MEDIA_IOC_FL_GRAPH_MUTEX),
	MEDIA_IOC(ENUM_LINKS, media_device_enum_links, MEDIA_IOC_FL_GRAPH_MUTEX),
	MEDIA_IOC(SETUP_LINK, media_device_setup_link, MEDIA_IOC_FL_GRAPH_MUTEX),
	MEDIA_IOC(G_TOPOLOGY, media_device_get_topology, MEDIA_IOC_FL_GRAPH_MUTEX),
	MEDIA_IOC(REQUEST_ALLOC, media_device_request_alloc, 0),
};      
used in
static long media_device_ioctl(struct file *filp, unsigned int cmd,
                               unsigned long __arg)
There we have
        ret = info->fn(dev, karg);

	if (info->flags & MEDIA_IOC_FL_GRAPH_MUTEX)
		mutex_unlock(&dev->graph_mutex);

	if (!ret && info->arg_to_user)
		ret = info->arg_to_user(arg, karg, cmd);

array elements are set by
#define MEDIA_IOC_ARG(__cmd, func, fl, from_user, to_user)              \
        [_IOC_NR(MEDIA_IOC_##__cmd)] = {                                \
                .cmd = MEDIA_IOC_##__cmd,                               \
                .fn = func,                                             \
                .flags = fl,                                            \
                .arg_from_user = from_user,                             \
                .arg_to_user = to_user,                                 \
        }

#define MEDIA_IOC(__cmd, func, fl)                                      \
        MEDIA_IOC_ARG(__cmd, func, fl, copy_arg_from_user, copy_arg_to_user)

so this ->arg_to_user() is copy_arg_to_user(), which is
static long copy_arg_to_user(void __user *uarg, void *karg, unsigned int cmd)
{
        if ((_IOC_DIR(cmd) & _IOC_READ) &&
            copy_to_user(uarg, karg, _IOC_SIZE(cmd)))
                return -EFAULT;

        return 0;
}

That copy_to_user() is not attempted until media_device_request_alloc()
returns.  And I don't see any way to make it unroll the insertion into
descriptor table without massive restructuring of the entire thing;
if you do, I'd love to hear it.

This is actually not the worst case - again, drm stuff has a bunch of
such crap, and I don't believe it's feasible to move drm folks from
their "we do copyin and copyout in generic ioctl code, passing the
copy to handlers supplied by drivers and copying whatever they modified
back to userland" approach.
