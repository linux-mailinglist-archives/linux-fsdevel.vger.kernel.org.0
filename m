Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA298C83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbfHVHmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 03:42:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52075 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbfHVHmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:42:52 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7M7gR6B078219;
        Thu, 22 Aug 2019 16:42:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Thu, 22 Aug 2019 16:42:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7M7gQ1A078163;
        Thu, 22 Aug 2019 16:42:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x7M7gQJW078160;
        Thu, 22 Aug 2019 16:42:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201908220742.x7M7gQJW078160@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on sockets.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        "David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Date:   Thu, 22 Aug 2019 16:42:26 +0900
References: <201908220655.x7M6tVmv029579@www262.sakura.ne.jp> <20190822070129.GL6111@zzz.localdomain>
In-Reply-To: <20190822070129.GL6111@zzz.localdomain>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers wrote:
> On Thu, Aug 22, 2019 at 03:55:31PM +0900, Tetsuo Handa wrote:
> > > Also, isn't the same bug in other places too?:
> > > 
> > > 	- tomoyo_path_chmod()
> > > 	- tomoyo_path_chown()
> > > 	- smack_inode_getsecurity()
> > > 	- smack_inode_setsecurity()
> > 
> > What's the bug? The file descriptor returned by open(O_PATH) cannot be
> > passed to read(2), write(2), fchmod(2), fchown(2), fgetxattr(2), mmap(2) etc.
> > 
> 
> chmod(2), chown(2), getxattr(2), and setxattr(2) take a path, not a fd.
> 

OK. Then, is the correct fix

  inode_lock(inode);
  if (SOCKET_I(inode)->sk) {
    // Can access SOCKET_I(sock)->sk->*
  } else {
    // Already close()d. Don't touch.
  }
  inode_unlock(inode);

thanks to

  commit 6d8c50dcb029872b ("socket: close race condition between sock_close() and sockfs_setattr()")
  commit ff7b11aa481f682e ("net: socket: set sock->sk to NULL after calling proto_ops::release()")

changes?
