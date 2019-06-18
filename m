Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D591C4AC0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 22:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfFRUtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 16:49:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52184 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730171AbfFRUtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:49:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL2r-0003xC-HG; Tue, 18 Jun 2019 20:49:33 +0000
Date:   Tue, 18 Jun 2019 21:49:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] tomoyo: Don't check open/getattr permission on sockets.
Message-ID: <20190618204933.GE17978@ZenIV.linux.org.uk>
References: <0000000000004f43fa058a97f4d3@google.com>
 <201906060520.x565Kd8j017983@www262.sakura.ne.jp>
 <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp>
 <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 16, 2019 at 03:49:00PM +0900, Tetsuo Handa wrote:
> Hello, Al.
> 
> Q1: Do you agree that we should fix TOMOYO side rather than SOCKET_I()->sk
>     management.

You do realize that sockets are not unique in that respect, right?
All kinds of interesting stuff can be accessed via /proc/*/fd/*, and
it _can_ be closed under you.  So I'd suggest checking how your code
copes with similar for pipes, FIFOs, epoll, etc., accessed that way...

We are _not_ going to be checking that in fs/open.c - the stuff found
via /proc/*/fd/* can have the associated file closed by the time
we get to calling ->open() and we won't know that until said call.

> Q2: Do you see any problem with using f->f_path.dentry->d_inode ?
>     Do we need to use d_backing_inode() or d_inode() ?

Huh?  What's wrong with file_inode(f), in the first place?  And
just when can that be NULL, while we are at it?

> >  static int tomoyo_inode_getattr(const struct path *path)
> >  {
> > +	/* It is not safe to call tomoyo_get_socket_name(). */
> > +	if (path->dentry->d_inode && S_ISSOCK(path->dentry->d_inode->i_mode))
> > +		return 0;

Can that be called for a negative?
