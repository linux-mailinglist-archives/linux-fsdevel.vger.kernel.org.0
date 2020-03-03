Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06207178347
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 20:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgCCTnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 14:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgCCTnr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:43:47 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4610C20870;
        Tue,  3 Mar 2020 19:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583264626;
        bh=DCL8ykDk5TOwzA/Lva4sncSGdbnsdat+IzdI+ZVWZEM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nsnxIjROrEOodcoUUfkk/9UAGrJoxMgXXvExx4ZJ1oy3uKRSiHXRuNctJDwDeDirA
         7ZET8GMx3MYvCWFDkyjivIzeX3cJBF06lF6UjdaVvg/2ggQmcZ9XdalkwXSBYUv4av
         dCAXLU/OlF9SpunpiAM6TNnLQnQyInzDnUUfblgA=
Message-ID: <cb2a7273a4cac7bac5f5b323e1958242b98e605e.camel@kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Jeff Layton <jlayton@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Mar 2020 14:43:44 -0500
In-Reply-To: <dc84aa00-e570-8833-cf9f-d1001c52dd7a@kernel.dk>
References: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
         <1509948.1583226773@warthog.procyon.org.uk>
         <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
         <20200303113814.rsqhljkch6tgorpu@ws.net.home>
         <20200303130347.GA2302029@kroah.com> <20200303131434.GA2373427@kroah.com>
         <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
         <20200303134316.GA2509660@kroah.com> <20200303141030.GA2811@kroah.com>
         <CAG48ez3Z2V8J7dpO6t8nw7O2cMJ6z8vwLZXLAoKGH3OnCb-7JQ@mail.gmail.com>
         <20200303142407.GA47158@kroah.com>
         <030888a2-db3e-919d-d8ef-79dcc10779f9@kernel.dk>
         <acb1753c78a019fb0d54ba29077cef144047f70f.camel@kernel.org>
         <7a05adc8-1ca9-c900-7b24-305f1b3a9b86@kernel.dk>
         <dbb06c63c17c23fcacdd99e8b2266804ee39ffe5.camel@kernel.org>
         <dc84aa00-e570-8833-cf9f-d1001c52dd7a@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-03-03 at 12:23 -0700, Jens Axboe wrote:
> On 3/3/20 12:02 PM, Jeff Layton wrote:
> > Basically, all you'd need to do is keep a pointer to struct file in the
> > internal state for the chain. Then, allow userland to specify some magic
> > fd value for subsequent chained operations that says to use that instead
> > of consulting the fdtable. Maybe use -4096 (-MAX_ERRNO - 1)?
> 
> BTW, I think we need two magics here. One that says "result from
> previous is fd for next", and one that says "fd from previous is fd for
> next". The former allows inheritance from open -> read, the latter from
> read -> write.
> 

Do we? I suspect that in almost all of the cases, all we'd care about is
the last open. Also if you have unrelated operations in there you still
have to chain the fd through somehow to the next op which is a bit hard
to do with that scheme.

I'd just have a single magic carveout that means "use the result of last
open call done in this chain". If you do a second open (or pipe, or...),
then that would put the old struct file pointer and drop a new one in
there.

If we really do want to enable multiple opens in a single chain though,
then we might want to rethink this and consider some sort of slot table
for storing open fds.

-- 
Jeff Layton <jlayton@kernel.org>

