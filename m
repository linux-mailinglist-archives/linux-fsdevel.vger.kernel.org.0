Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BE519FA5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgDFQlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 12:41:15 -0400
Received: from nautica.notk.org ([91.121.71.147]:52404 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbgDFQlP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:41:15 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 6AB69C009; Mon,  6 Apr 2020 18:41:12 +0200 (CEST)
Date:   Mon, 6 Apr 2020 18:40:57 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>
Subject: Re: [GIT PULL] 9p update for 5.7
Message-ID: <20200406164057.GA18312@nautica>
References: <20200406110702.GA13469@nautica>
 <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds wrote on Mon, Apr 06, 2020:
> On Mon, Apr 6, 2020 at 4:07 AM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> > - Fix read with O_NONBLOCK to allow incomplete read and return
> > immediately
> 
> Hmm. This is kind of special semantics (normally a POSIX filesystem
> ignores O_NONBLOCK), but I guess it makes sense for a network
> filesystem.
> 
> It might be worth a bti more documentation/commenting because of the
> special semantics. For example, since you don't have 'poll()',
> O_NONBLOCK doesn't really mean "nonblocking", it means "stop earlier"
> if I read that patch right. You can't just return -EAGAIN because
> there's no way to then avoid busy looping..

Yes, I think you got this right.

Basically there is no way to tell if the server will return immediately
or not, so even with O_NONBLOCK the read() will still be 'blocking' if
the server decides to wait for something before sending a reply.

This patch will just make the read stop after a single round-trip with
the server instead of looping to fill the buffer if O_NONBLOCK is set.

The use-case here is stuff like reading from synthetic files (think fake
pipes) where data comes in like a pipe and one would want read to return
as soon as data is available.
Just thinking out loud it might be possible to make pipes go through the
server and somewhat work, but this might bring its own share of other
problems and existing programs would need to be changed (e.g. wmii's
synthetic filesystem exposes this kind of files as well as regular
files, which works fine for their userspace client (wmiir) but can't
really be used with a linux client)
(Added Sergey in Cc for opinion)



Anyway, I agree looking at O_NONBLOCK for that isn't obvious.
I agree with the usecase here and posix allows short reads regardless of
the flag so the behaviour is legal either way ; the filesystem is
allowed to return whenever it wants on a whim - let's just add some docs
as you suggest unless Sergey has something to add.

I will add a few lines on that in Documentation/filesystems/9p.txt and
send another pull request in a couple of days to give whoever wants to
review time to comment on wording.

Cheers,
-- 
Dominique
