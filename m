Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C453E2EF2F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 14:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbhAHNSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 08:18:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbhAHNSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610111837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bg8rlW5E0vWkjj4xn9p0kuI2DQ6aO3LChdMVPwhxTYY=;
        b=EY7wsyVC88lMucNvRQZ/jvwzeroIPZOzZgJpaJln1OKfcWNNf6czPP1OpDpnZnmMa2bpVN
        sVWCfABVmcssyVWXJsrXpiRIS+dzfDYIiNNvWOJOsyAN7kIJDu5U41QcsFO1k5sgTOUhP3
        jDfSq4kOt3ORfxBbFE83JHws5vPqAyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-bk1YV-HWOYCeEAD7skCUEg-1; Fri, 08 Jan 2021 08:17:15 -0500
X-MC-Unique: bk1YV-HWOYCeEAD7skCUEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6D731005513;
        Fri,  8 Jan 2021 13:17:13 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68A755D9C0;
        Fri,  8 Jan 2021 13:17:13 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5C8E34BB40;
        Fri,  8 Jan 2021 13:17:13 +0000 (UTC)
Date:   Fri, 8 Jan 2021 08:17:11 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Message-ID: <879072186.43549344.1610111831181.JavaMail.zimbra@redhat.com>
In-Reply-To: <X/eUd4iLxnl2nYRF@google.com>
References: <20201224044954.1349459-1-satyat@google.com> <20210107162000.GA2693@lst.de> <1137375419.42956970.1610036857271.JavaMail.zimbra@redhat.com> <X/eUd4iLxnl2nYRF@google.com>
Subject: Re: [PATCH] fs: Fix freeze_bdev()/thaw_bdev() accounting of
 bd_fsfreeze_sb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.201, 10.4.195.27]
Thread-Topic: Fix freeze_bdev()/thaw_bdev() accounting of bd_fsfreeze_sb
Thread-Index: Qh0Y8TOdr+3c+YdH/MUolaQzVBj28w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> This causes bdev->bd_fsfreeze_sb to be set to NULL even if the call to
> thaw_super right after this line fail. So if a caller tries to call
> thaw_bdev() again after receiving such an error, that next call won't even
> try to call thaw_super(). Is that what we want here?  (I don't know much
> about this code, but from a cursory glance I think this difference is
> visible to emergency_thaw_bdev() in fs/buffer.c)
> 
> In my version of the patch, I set bdev->bd_fsfreeze_sb to NULL only
> *after* we check that the call to thaw_super() succeeded to avoid this.

Yes, I see your point. Your patch is superior and I'll mine accordingly.

> Thanks a lot for investigating the bug and the patch I sent :)
> Was there actually an issue with that patch I sent? As you said, the bug

No, I never saw your patch until I saw Christoph's reference to it yesterday,
after I had been using my patch to fix the problem. AFAIK, there is no
problem with your patch.

> I think the second difference (decrementing bd_fsfreeze_count when
> get_active_super() returns NULL) doesn't change anything w.r.t the
> use-after-free. It does however, change the behaviour of the function
> slightly, and it might be caller visible (because from a cursory glance, it
> looks like we're reading the bd_fsfreeze_count from some other places like
> fs/super.c). Even before 040f04bd2e82, the code wouldn't decrement
> bd_fsfreeze_count when get_active_super() returned NULL - so is this change
> in behaviour intentional? And if so, maybe it should go in a separate
> patch?

This is the bigger issue, and I'm not very familiar with this code either,
so I'll defer to the experts. Yes, it's a change in behavior, but I think
it makes sense to decrement the bd_fsfreeze_count in this case. Here's why:

If the blockdev is frozen by freeze_bdev while it's being unmounted, the
bd_fsfreeze_count is incremented, but the freeze is ignored. Subsequent
attempts to thaw the device will be ignored but return 0 because the sb
is not found. When the device is mounted again, calls to freeze_bdev
will bypass the call to freeze_super for the newly mounted sb, because
bdev->bd_fsfreeze_count was then incremented from 1 to 2 in freeze_bdev.

	if (++bdev->bd_fsfreeze_count > 1)
		goto done;

So you're freezing the device without really freezing the superblock.
Seems like dangerous behavior to me. The new sb will only be frozen if
a second thaw is done, which gets them back in sync. I suppose we could
say this is acceptable loss, and your number of thaws should match your
freezes, and if they don't: user error. Still, it seems like we should do
something about it, like refuse to mount a frozen device. Perhaps it already
does that; I'll need to do some research.

Like I said, I don't know this code. I'm just trying to fix a problem
I observed. I'll defer to the experts.

Regards,

Bob Peterson

