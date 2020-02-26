Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2054C1708D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 20:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBZTUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 14:20:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727134AbgBZTUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582744808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JC/2w/EASsF47NJsQnG/EnRFDXzT40bcN876RMkvyQU=;
        b=VIonsxn5ETTCv/jF+U/9Eul8RWdx/wrzovKfOZtDFgszowTjqQp3vQpHu/JVsFvEKI8P8s
        4HKN33RlcLPReAFD2//hPW76bcl7vVhKYgm8vVpVeovq3b2bAfTDO7mkWxLo1iVy53LPo9
        BcZjifnPJLsyFCZsSEanL8gq7mLr648=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-NTKz4_vuPum3utiIDaAQtg-1; Wed, 26 Feb 2020 14:20:06 -0500
X-MC-Unique: NTKz4_vuPum3utiIDaAQtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 106481005512;
        Wed, 26 Feb 2020 19:20:04 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E53890CD1;
        Wed, 26 Feb 2020 19:19:59 +0000 (UTC)
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <12e8d951-fc35-bce0-e96d-f93bccf2bd3a@redhat.com>
Date:   Wed, 26 Feb 2020 14:19:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200226162954.GC24185@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/26/20 11:29 AM, Matthew Wilcox wrote:
> On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
>> A new sysctl parameter "dentry-dir-max" is introduced which accepts a
>> value of 0 (default) for no limit or a positive integer 256 and up. Small
>> dentry-dir-max numbers are forbidden to avoid excessive dentry count
>> checking which can impact system performance.
> This is always the wrong approach.  A sysctl is just a way of blaming
> the sysadmin for us not being very good at programming.
>
> I agree that we need a way to limit the number of negative dentries.
> But that limit needs to be dynamic and depend on how the system is being
> used, not on how some overworked sysadmin has configured it.
>
> So we need an initial estimate for the number of negative dentries that
> we need for good performance.  Maybe it's 1000.  It doesn't really matter;
> it's going to change dynamically.
>
> Then we need a metric to let us know whether it needs to be increased.
> Perhaps that's "number of new negative dentries created in the last
> second".  And we need to decide how much to increase it; maybe it's by
> 50% or maybe by 10%.  Perhaps somewhere between 10-100% depending on
> how high the recent rate of negative dentry creation has been.
>
> We also need a metric to let us know whether it needs to be decreased.
> I'm reluctant to say that memory pressure should be that metric because
> very large systems can let the number of dentries grow in an unbounded
> way.  Perhaps that metric is "number of hits in the negative dentry
> cache in the last ten seconds".  Again, we'll need to decide how much
> to shrink the target number by.
>
> If the number of negative dentries is at or above the target, then
> creating a new negative dentry means evicting an existing negative dentry.
> If the number of negative dentries is lower than the target, then we
> can just create a new one.
>
> Of course, memory pressure (and shrinking the target number) should
> cause negative dentries to be evicted from the old end of the LRU list.
> But memory pressure shouldn't cause us to change the target number;
> the target number is what we think we need to keep the system running
> smoothly.
>
Thanks for the quick response.

I agree that auto-tuning so that the system administrator don't have to
worry about it will be the best approach if it is implemented in the
right way. However, it is hard to do it right.

How about letting users specify a cap on the amount of total system
memory allowed for negative dentries like one of my previous patchs.
Internally, there is a predefined minimum and maximum for
dentry-dir-max. We sample the total negative dentry counts periodically
and adjust the dentry-dir-max accordingly.

Specifying a percentage of total system memory is more intuitive than
just specifying a hard number for dentry-dir-max. Still some user input
is required.

What do you think?

Cheers,
Longman

