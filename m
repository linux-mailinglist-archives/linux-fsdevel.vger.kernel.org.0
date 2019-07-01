Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB15C38B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfGATUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 15:20:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37368 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGATUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:20:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hi1r7-0005kH-Ok; Mon, 01 Jul 2019 19:20:49 +0000
Date:   Mon, 1 Jul 2019 20:20:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190701192049.GB17978@ZenIV.linux.org.uk>
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
 <20190701164536.GA202431@gmail.com>
 <20190701182239.GA17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701182239.GA17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 07:22:39PM +0100, Al Viro wrote:

> FWIW, it's not just move_mount(2) - I'd expect
> 
> 	int fds[2];
> 	char s[80];
> 
> 	pipe(fds);
> 	sprintf(s, "/dev/fd/%d", fds[0]);
> 	mount(s, "/dev/null", NULL, MS_MOVE, 0);
> 
> to step into exactly the same thing.  mount(2) does follow symlinks -
> always had...

The same goes for e.g.

#define _GNU_SOURCE
#include <sched.h>
#include <sys/mount.h>
#include <stdio.h>
#include <sys/epoll.h>

main()
{
	char s[80];
	unshare(CLONE_NEWNS);	// so nobody else gets confused
 	sprintf(s, "/dev/fd/%d", epoll_create1(0));
 	mount(s, "/dev/null", NULL, MS_MOVE, 0);	// see if it oopses
}

modulo error-checking, etc.
