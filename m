Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD3A5C2D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfGASWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 14:22:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36700 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfGASWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:22:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hi0wp-0004Qk-JX; Mon, 01 Jul 2019 18:22:39 +0000
Date:   Mon, 1 Jul 2019 19:22:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190701182239.GA17978@ZenIV.linux.org.uk>
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
 <20190701164536.GA202431@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701164536.GA202431@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:45:37AM -0700, Eric Biggers wrote:
> On Sat, Jun 29, 2019 at 01:27:44PM -0700, Eric Biggers wrote:
> > 
> > Reproducer:
> > 
> >     #include <unistd.h>
> > 
> >     #define __NR_move_mount         429
> >     #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
> > 
> >     int main()
> >     {
> >     	  int fds[2];
> > 
> >     	  pipe(fds);
> >         syscall(__NR_move_mount, fds[0], "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
> >     }
> 
> David, I'd like to add this as a regression test somewhere.
> 
> Can you point me to the tests for the new mount syscalls?
> 
> I checked LTP, kselftests, and xfstests, but nothing to be found.

FWIW, it's not just move_mount(2) - I'd expect

	int fds[2];
	char s[80];

	pipe(fds);
	sprintf(s, "/dev/fd/%d", fds[0]);
	mount(s, "/dev/null", NULL, MS_MOVE, 0);

to step into exactly the same thing.  mount(2) does follow symlinks -
always had...
