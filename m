Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46AB32072A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 22:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBTVJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 16:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBTVJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 16:09:45 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD198C061574;
        Sat, 20 Feb 2021 13:09:05 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDZUl-00GQzx-U4; Sat, 20 Feb 2021 21:08:56 +0000
Date:   Sat, 20 Feb 2021 21:08:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Denis Kirjanov <kda@linux-powerpc.org>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/8] af_unix: take address assignment/hash insertion into
 a new helper
Message-ID: <YDF6Z8QHh3yw7es9@zeniv-ca.linux.org.uk>
References: <CAOJe8K0iG91tm8YBRmE_rdMMMbc4iRsMGYNxJk0p9vEedNHEkg@mail.gmail.com>
 <20210129131855.GA2346744@infradead.org>
 <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
 <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
 <YCwIQmsxWxuw+dnt@zeniv-ca.linux.org.uk>
 <YC86WeSTkYZqRlJY@zeniv-ca.linux.org.uk>
 <YC88acS6dN6cU1y0@zeniv-ca.linux.org.uk>
 <CAM_iQpVpJwRNKjKo3p1jFvCjYAXAY83ux09rd2Mt0hKmvx=RgQ@mail.gmail.com>
 <YDFj3OZ4DMQSqylH@zeniv-ca.linux.org.uk>
 <CAM_iQpXX7SBGgUkBUY6BEjCqJYbHAUW5Z3VtV2U=yhiw1YJr=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXX7SBGgUkBUY6BEjCqJYbHAUW5Z3VtV2U=yhiw1YJr=w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 12:31:49PM -0800, Cong Wang wrote:
> Because it does not lock the lock, just compare:
> 
> lock();
> __unix_set_addr();
> unlock();
> 
> to:
> 
> lock();
> __unix_set_addr();
> 
> Clearly the former is more readable and less error-prone. Even
> if you really want to do unlock, pick a name which explicitly says
> it, for example, __unix_set_addr_unlock().

*shrug*

If anything, __unix_complete_bind() might make a better name for that,
with dropping ->bindlock also pulled in, but TBH I don't have sufficiently
strong preferences - might as well leave dropping the lock to caller.

I'll post that series to netdev tonight.
