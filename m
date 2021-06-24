Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF183B2733
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 08:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhFXGOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 02:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhFXGOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:14:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55476C061574;
        Wed, 23 Jun 2021 23:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pNk4fkvdCLyNvY6Qf61pIljrBv9nH46RSabT5tzXrM8=; b=WMtO44UKP6FsKGpbA8cJP4XvEG
        DQ+y9CP8R7Gl9QVa/XrQwURu+9DNntlxtwGPgMhllcrgRf1eYlq4VL43zhz9uBG7wFzqR8BvPfqYB
        wWib2sbNX4ALotYRX9u5BawmhPBb+gIM35mQ9g8cgcFKYv8JVHtZdwZlFH7tD5oa8Z7fn6U7wAdFw
        GjaTeeH6oa1dIw6KiyAWBK3t2g7jUJ4Yze+k2+MRWtVx0e6cOUe7Ne3CRS3hRyw63mjjr5Hwovs14
        TpMnwp0u+fzfXKGDqWWG490xuDSHpibGvF/ITFHUWdbDZBSQHURYPQ6YvyUF0EJWRs9hcmBf3lPjY
        T2q4IMiA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwIaD-00GFBi-Na; Thu, 24 Jun 2021 06:11:30 +0000
Date:   Thu, 24 Jun 2021 07:11:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luca Boccassi <bluca@debian.org>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 6/6] loop: increment sequence number
Message-ID: <YNQiDROADP1jGXCJ@infradead.org>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-7-mcroce@linux.microsoft.com>
 <YNMhwLMr7DiNdqC/@infradead.org>
 <bbd3d100ee997431b2905838575eb4bdec820ad3.camel@debian.org>
 <YNNEdbr+0p+PzinQ@infradead.org>
 <YNNTTUYRlpXDqMgX@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNNTTUYRlpXDqMgX@gardel-login>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 05:29:17PM +0200, Lennart Poettering wrote:
> I am not sure I grok your point.

You don't.

> 1. First of all, loopback devices currently don't hook into the media
>    change logic (which so far is focussed on time-based polling
>    actually, for both CDs and floppies).

And that is the whole problem.  We need to first fix loop devices to
hook into the existing mechanism to report media changes.  We can then
enhance that mechanism to be more suitable to loop (avoid the polling)
and userspace (add a sequence number).  But if we don't have the basic
agreement to fully integreat loop with the existing way that the kernel
reports media change we don't even need to discuss this series and can
just ignore it, as it simply won't be acceptable.

>    Adding this would change
>    semantics visibly to userspace (since userspace would suddenly see
>    another action=change + DISK_MEDIA_CHANGE=1 uevent suddenly that it
>    needs to handle correctly).

Yes, and that is a good thing as loop is currently completely broken
in this respect.

> 2. We want seqnums to be allocated for devices not only when doing
>    media change (e.g. when attaching or detaching a loopback device)
>    but also when allocating a block device, so that even before the
>    first media change event a block device has a sequence number. This
>    means allocating a sequence number for block devices won't be
>    limited to the media change code anyway.

Doing this on creation is fine, and attaching is by definition a media
change.
