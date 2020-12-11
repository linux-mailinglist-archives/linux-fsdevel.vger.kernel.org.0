Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9A12D7CEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 18:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405381AbgLKRat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 12:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405184AbgLKRaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:30:16 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58301C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:29:36 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knmEV-000avt-3P; Fri, 11 Dec 2020 17:29:31 +0000
Date:   Fri, 11 Dec 2020 17:29:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
Message-ID: <20201211172931.GY3579531@ZenIV.linux.org.uk>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <20201211023555.GV3579531@ZenIV.linux.org.uk>
 <bef3f905-f6b7-1134-7ca9-ff9385d6bf86@kernel.dk>
 <CAHk-=wjkA5Rx+0UjkSFQUqLJK9eRJ_MqoTZ8y2nyt4zXwE9vDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjkA5Rx+0UjkSFQUqLJK9eRJ_MqoTZ8y2nyt4zXwE9vDg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 09:21:20AM -0800, Linus Torvalds wrote:
> On Fri, Dec 11, 2020 at 7:57 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 12/10/20 7:35 PM, Al Viro wrote:
> > > _IF_ for some theoretical exercise you want to do "lookup without dropping
> > > out of RCU", just add a flag that has unlazy_walk() fail.  With -ECHILD.
> > > Strip it away in complete_walk() and have path_init() with that flag
> > > and without LOOKUP_RCU fail with -EAGAIN.  All there is to it.
> >
> > Thanks Al, that makes for an easier implementation. I like that suggestion,
> > boils it down to just three hunks (see below).
> 
> Ooh. Yes, very nice.

Except for the wrong order in path_init() - the check should go _before_
        if (!*s)
                flags &= ~LOOKUP_RCU;
for obvious reasons.

Again, that part is trivial - what to do with do_open()/open_last_lookups()
is where the nastiness will be.  Basically, it makes sure we bail out in
cases when lookup itself would've blocked, but it does *not* bail out
when equally heavy (and unlikely) blocking sources hit past the complete_walk().
Which makes it rather useless for the caller, unless we get logics added to
that part as well.  And _that_ I want to see before we commit to anything.
