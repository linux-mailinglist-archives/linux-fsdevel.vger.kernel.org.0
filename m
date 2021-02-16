Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBED331CFC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 19:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBPSBb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 13:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhBPSBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:01:24 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519CC061756;
        Tue, 16 Feb 2021 10:00:43 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lC4eI-00EgUW-F0; Tue, 16 Feb 2021 18:00:34 +0000
Date:   Tue, 16 Feb 2021 18:00:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: export kern_path_locked
Message-ID: <YCwIQmsxWxuw+dnt@zeniv-ca.linux.org.uk>
References: <20210125154937.26479-1-kda@linux-powerpc.org>
 <20210127175742.GA1744861@infradead.org>
 <CAOJe8K0MC-TCURE2Gpci1SLnLXCbUkE7q6SS0fznzBA+Pf-B8Q@mail.gmail.com>
 <20210129082524.GA2282796@infradead.org>
 <CAOJe8K0iG91tm8YBRmE_rdMMMbc4iRsMGYNxJk0p9vEedNHEkg@mail.gmail.com>
 <20210129131855.GA2346744@infradead.org>
 <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
 <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 05:31:33PM +0300, Denis Kirjanov wrote:

> We had a change like that:
> Author: WANG Cong <xiyou.wangcong@gmail.com>
> Date:   Mon Jan 23 11:17:35 2017 -0800
> 
>     af_unix: move unix_mknod() out of bindlock
> 
>     Dmitry reported a deadlock scenario:
> 
>     unix_bind() path:
>     u->bindlock ==> sb_writer
> 
>     do_splice() path:
>     sb_writer ==> pipe->mutex ==> u->bindlock
> 
>     In the unix_bind() code path, unix_mknod() does not have to
>     be done with u->bindlock held, since it is a pure fs operation,
>     so we can just move unix_mknod() out.

*cringe*

I remember now...  Process set:

P1: bind() of AF_UNIX socket to /mnt/sock
P2: splice() from pipe to /mnt/foo
P3: freeze /mnt
P4: splice() from pipe to AF_UNIX socket

P1	grabs ->bindlock
P2	sb_start_write() for what's on /mnt
P2	grabs rwsem shared
P3	blocks in sb_wait_write() trying to grab the same rwsem exclusive
P1	sb_start_write() blocks trying to grab the same rwsem shared
P4	calls ->splice_write(), aka generic_splice_sendpage()
P4 	grabs pipe->mutex
P4	calls ->sendpage(), aka sock_no_sendpage()
P4	calls ->sendmsg(), aka unix_dgram_sendmsg()
P4	calls unix_autobind()
P4	blocks trying to grab ->bindlock
P2	->splice_write(), aka iter_file_splice_write()
P2	blocks trying to grab  pipe->mutex
	DEADLOCK

Sigh...  OK, so we want something like
	user_path_create()
	vfs_mknod()
	created = true
	grab bindlock
	....
	drop bindlock
	if failed && created
		vfs_unlink()
	done_path_create()	
in unix_bind()...  That would push ->bindlock all way down in the hierarchy,
so that should be deadlock-free, but it looks like that'll be fucking ugly ;-/

Let me try and play with that a bit, maybe it can be massaged to something
relatively sane...
