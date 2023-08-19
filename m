Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10537781E55
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Aug 2023 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjHTOiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Aug 2023 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHTOiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Aug 2023 10:38:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E443B8B8C
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Aug 2023 12:17:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-121-162.bstnma.fios.verizon.net [173.48.121.162])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37JJGcCr017522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Aug 2023 15:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692472605; bh=6N9EMQdf0dg3QG8w35gHzeeRG5O6PiKxY5DKUYynzzw=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Atxp7UFw7l/+ynDLo45X7aYFou+u6wFBCEsfhVVnm6OKRuP0uyYyQPPRclCZsptk6
         Uo2Ex0I4P4e85RQ56V6hxZ8xXHNMoQKrzby43drHZHyQED1WxgDAMPaprvKIDFTZxt
         qtxhJ1TI/0gz3qP655QzThWln9g9002vhBgBmgm9hbeAb5OuLLLMlLls+bR3jmu8xL
         8vWJziOlUgCrrHnCvwTqyjbFEVue5jbKrge+JN4nv9hekFBIvNRazZeNcHGXkE52QE
         L2nNHprUAHFeGB8QLrW4c96SnWN8yaAsosZ5KSMPfYQK+5etVT63CHfCajI0c1477I
         PcC6DSCHnArzA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BCAAD15C0292; Sat, 19 Aug 2023 15:16:38 -0400 (EDT)
Date:   Sat, 19 Aug 2023 15:16:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>,
        anton@tuxera.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs?] WARNING in do_open_execat
Message-ID: <20230819191638.GJ3464136@mit.edu>
References: <000000000000c74d44060334d476@google.com>
 <87o7j471v8.fsf@email.froward.int.ebiederm.org>
 <202308181030.0DA3FD14@keescook>
 <20230818191239.3cprv2wncyyy5yxj@f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818191239.3cprv2wncyyy5yxj@f>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 09:12:39PM +0200, Mateusz Guzik wrote:
> 
> The ntfs image used here is intentionally corrupted and the inode at
> hand has a mode of 777 (as in type not specified).
> 
> Then the type check in may_open():
>         switch (inode->i_mode & S_IFMT) {
> 
> fails to match anything.
> ...
> 
> Do other filesystems have provisions to prevent inodes like this from
> getting here?

Well, what ext4 does is that we do a bunch of basic validity checks in
ext4_iget(), and if the inode is bad (for example the type is not
specified), the following gets executed:

	} else {
		ret = -EFSCORRUPTED;
		ext4_error_inode(inode, function, line, 0,
				 "iget: bogus i_mode (%o)", inode->i_mode);
		goto bad_inode;
       ...

bad_inode:
	brelse(iloc.bh);
	iget_failed(inode);
	return ERR_PTR(ret);
       
iget_failed() takes the inode under construction (returned by
iget_locked), and marks it as a bad/"dead" inode.  So subsequent
attempts to do anything with the inode, including opening it, will
fail at the VFS level, and you never get to the file system's open
function.

The ext4_error_inode() function is reponsible for logging the error,
and if userspace is using fsnotify and are subscribed FS_ERROR,
notifying user space that the file system is corrupted.  Depending on
the file system settings, we may also remount the file system
read-only, or force a panic to reboot the system (so that a failover
backup server can take over), or just log the message and continuing.

       	      	       	      	      	      - Ted
