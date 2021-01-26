Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57879305D13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313555AbhAZWgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387745AbhAZTS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:18:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29947C061574;
        Tue, 26 Jan 2021 11:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=slbT+XV5IE8VlhB70udS4atkkfpdMMLuQ7GIBp0RBvY=; b=C2rEE33vnYai734zBLsuFL9aG4
        MNup863NI8PrQ3APIkLyQk9w9x0tYnR+OsyN/nXcRDk/Ix86FCEpaLgo1opMfqxM2BSnuSoPjIFzd
        eJ3sotklgF+5uPlKc/ZTdf+9dU/4STj+HdQ8iROmY5JKUyZCF26KElLiXOW9kc6djm+wgFyAWQljK
        0woqfCt7EXqSxcGXrgPY4SQecQolxcNf1Weq22USyr04mtCabWoJ+bbMUYWfwNrUqeNjwNMQT6G68
        aAnY940HpeLoNgk3l9swl8E5fIhUUybMDLE7G2a2vn7HDtyr/dV2WO9Fom/hxaK9Fyp4uHfgUyRRS
        a1lNZIwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Tq0-006Aqj-CU; Tue, 26 Jan 2021 19:17:31 +0000
Date:   Tue, 26 Jan 2021 19:17:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Getting a new fs in the kernel
Message-ID: <20210126191716.GN308988@casper.infradead.org>
References: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 08:23:03AM -0800, Amy Parker wrote:
> Kernel development newcomer here. I've begun creating a concept for a
> new filesystem, and ideally once it's completed, rich, and stable I'd
> try to get it into the kernel.
> 
> What would be the process for this? I'd assume a patch sequence, but
> they'd all be dependent on each other, and sending in tons of
> dependent patches doesn't sound like a great idea. I've seen requests
> for pulls, but since I'm new here I don't really know what to do.

Hi Amy,

Writing a new filesystem is fun!  Everyone should do it.

Releasing a filesystem is gut-churning.  You're committing to a filesystem
format that has to be supported for ~ever.

Supporting a new filesystem is a weighty responsibility.  People are
depending on you to store their data reliably.  And they demand boring
and annoying features like xattrs, acls, support for time after 2038.

We have quite a lot of actively developed filesystems for users to choose
from already -- ext4, btrfs, xfs are the main three.  So you're going
to face a challenge persuading people to switch.

Finally, each filesystem represents a (small) maintainance burden to
people who need to make changes that cross all filesystems.  So it'd
be nice to have a good justification for why we should include that
cost.

Depending exactly what your concept is, it might make more sense to
make it part of an existing filesystem.  Or develop it separately
and have an existing filesystem integrate it.

Anyway, I've been at this for twenty years, so maybe I'm just grouchy
about new filesystems.  By all means work on it and see if it makes
sense, but there's a fairly low probability that it gets merged.
