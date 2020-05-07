Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971741C9A79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEGTFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 15:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEGTFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 15:05:05 -0400
X-Greylist: delayed 207 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 May 2020 12:05:04 PDT
Received: from nibbler.cm4all.net (nibbler.cm4all.net [IPv6:2001:8d8:970:e500:82:165:145:151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14ECC05BD43
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 12:05:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id CA267C022E
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 21:05:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id fgi6JKq3oQLG for <linux-fsdevel@vger.kernel.org>;
        Thu,  7 May 2020 21:05:03 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id AA99AC0213
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 21:05:03 +0200 (CEST)
Received: (qmail 2978 invoked from network); 7 May 2020 22:21:20 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 7 May 2020 22:21:20 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 752A4461450; Thu,  7 May 2020 21:05:03 +0200 (CEST)
Date:   Thu, 7 May 2020 21:05:03 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Max Kellermann <mk@cm4all.com>, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] fs/io_uring: fix O_PATH fds in openat, openat2, statx
Message-ID: <20200507190503.GA15998@rabbit.intern.cm-ag>
References: <20200507185725.15840-1-mk@cm4all.com>
 <20200507190131.GF23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507190131.GF23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/05/07 21:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, May 07, 2020 at 08:57:25PM +0200, Max Kellermann wrote:
> > If an operation's flag `needs_file` is set, the function
> > io_req_set_file() calls io_file_get() to obtain a `struct file*`.
> > 
> > This fails for `O_PATH` file descriptors, because those have no
> > `struct file*`
> 
> O_PATH descriptors most certainly *do* have that.  What the hell
> are you talking about?

Oh, then my patch description (and my understanding of the root
problem) is wrong.  In my debugging session, io_file_get() on that fd
returned NULL, so I assumed O_PATH doesn't have that, but maybe there
are other reasons.

In any case, with a "real" fd, io_uring openat() succeeds, and my
patch makes the problem with O_PATH go away.

I guess I need to learn more about what happens inside io_file_get().

Max

