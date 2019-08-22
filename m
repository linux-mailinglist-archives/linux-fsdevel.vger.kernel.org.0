Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B6E9987A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbfHVPsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 11:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387880AbfHVPsF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:48:05 -0400
Received: from zzz.localdomain (ip-173-136-158-138.anahca.spcsdns.net [173.136.158.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 684B523400;
        Thu, 22 Aug 2019 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566488884;
        bh=uipZavMt5Z1fZAX+sVlMS1INMUxP9WzC4H4BLym3E3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHKmYzwY8waO4dpG6B4Fjk/MSEZD03cPKRGG5tDzo3xWM2ikozg6sh9qTjWAFn9xF
         Ok+z1PnH1dQl7NBvJDL+TTolIZMAt5KQ2llFU4mxFXKRkZN5zZSj7Nb9imaaBL5XG7
         36ip3+Y6lJyDNPTuNR2SzLdgobtgHdHxUCsigCe8=
Date:   Thu, 22 Aug 2019 08:47:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
Message-ID: <20190822154759.GA2020@zzz.localdomain>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        "David S. Miller" <davem@davemloft.net>
References: <201908220655.x7M6tVmv029579@www262.sakura.ne.jp>
 <20190822070129.GL6111@zzz.localdomain>
 <201908220742.x7M7gQJW078160@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908220742.x7M7gQJW078160@www262.sakura.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 04:42:26PM +0900, Tetsuo Handa wrote:
> Eric Biggers wrote:
> > On Thu, Aug 22, 2019 at 03:55:31PM +0900, Tetsuo Handa wrote:
> > > > Also, isn't the same bug in other places too?:
> > > > 
> > > > 	- tomoyo_path_chmod()
> > > > 	- tomoyo_path_chown()
> > > > 	- smack_inode_getsecurity()
> > > > 	- smack_inode_setsecurity()
> > > 
> > > What's the bug? The file descriptor returned by open(O_PATH) cannot be
> > > passed to read(2), write(2), fchmod(2), fchown(2), fgetxattr(2), mmap(2) etc.
> > > 
> > 
> > chmod(2), chown(2), getxattr(2), and setxattr(2) take a path, not a fd.
> > 
> 
> OK. Then, is the correct fix
> 
>   inode_lock(inode);
>   if (SOCKET_I(inode)->sk) {
>     // Can access SOCKET_I(sock)->sk->*
>   } else {
>     // Already close()d. Don't touch.
>   }
>   inode_unlock(inode);
> 
> thanks to
> 
>   commit 6d8c50dcb029872b ("socket: close race condition between sock_close() and sockfs_setattr()")
>   commit ff7b11aa481f682e ("net: socket: set sock->sk to NULL after calling proto_ops::release()")
> 
> changes?

inode_lock() is already held during security_path_chmod(),
security_path_chown(), and security_inode_setxattr().
So you can't just take it again.

- Eric
