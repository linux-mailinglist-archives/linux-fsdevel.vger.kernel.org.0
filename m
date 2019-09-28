Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40983C0F57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2019 04:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfI1C3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 22:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfI1C3Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 22:29:16 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 863B620869;
        Sat, 28 Sep 2019 02:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569637756;
        bh=DjezQNrhL5RoYpTkbIb4gBWCVmhYLj92teI/9u5Sx3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tgaG0uOUvZGie4JEzdqPnkHWldCPBPzN1WiFgCWvtYeuPwzs7AAiHzraa/bo9j7HB
         UNRFmnt2ARnJzxIo8UUpPRC9uDYR4Mn3/X1J6l2dgkYiQD/gTG0eJKA9J63W78LC6w
         GT8TqVKI6WFaHT6WEubvLFRYnNu9Xit4tu0dpOyY=
Date:   Fri, 27 Sep 2019 19:29:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     hev <r@hev.cc>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4] fs/epoll: Remove unnecessary wakeups of
 nested epoll that in ET mode
Message-Id: <20190927192915.6ec24ad706258de99470a96e@linux-foundation.org>
In-Reply-To: <20190925015603.10939-1-r@hev.cc>
References: <20190925015603.10939-1-r@hev.cc>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 25 Sep 2019 09:56:03 +0800 hev <r@hev.cc> wrote:

> From: Heiher <r@hev.cc>
> 
> Take the case where we have:
> 
>         t0
>          | (ew)
>         e0
>          | (et)
>         e1
>          | (lt)
>         s0
> 
> t0: thread 0
> e0: epoll fd 0
> e1: epoll fd 1
> s0: socket fd 0
> ew: epoll_wait
> et: edge-trigger
> lt: level-trigger
> 
> We only need to wakeup nested epoll fds if something has been queued to the
> overflow list, since the ep_poll() traverses the rdllist during recursive poll
> and thus events on the overflow list may not be visible yet.
> 
> Test code:

Look sane to me.  Do you have any performance testing results which
show a benefit?

epoll maintainership isn't exactly a hive of activity nowadays :(
Roman, would you please have time to review this?

