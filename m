Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D826EDB79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 08:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjDYGEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 02:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjDYGEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:04:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE321AD28;
        Mon, 24 Apr 2023 23:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Mao8Fd980ctu+JkZbtOuyLu6ZD3b3EkMiAg/6KGfDU=; b=LgOnoI/Ajcu7DGP9ey7GeYfZ1L
        tfzP97YQdEf+ZYu+Aa3Le7w+bzTFDg241DQmWFVxyNVo6AhS/iTNs1cuANOPuaZtDb9C11f9gtnAW
        cpzr6Z8Gx+h9k7i/xmXBgeUvF7e7H07sHhOpKoG++xm3KAUi0YXk01tTkWxpB3embzxKhcOTlP0pc
        SLMkfQ/64+D5oSw0BXRw5tHmj6wvH8ZzdFJq/N0VrEvwB9wsaGiNXs5AVW2gO6rH089MpUVRILOkJ
        VT1N4lUmRdKqfe5DHemucTVhFDCUWdEUBq/Eh4kJQ+ElHpoaShzns0CxyFA7H5UAbwvisDcvNJgcB
        K/c3LOkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prBmt-00CKtN-2v;
        Tue, 25 Apr 2023 06:04:28 +0000
Date:   Tue, 25 Apr 2023 07:04:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230425060427.GP3390869@ZenIV>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 01:24:24PM -0700, Linus Torvalds wrote:

> But I really think a potentially much nicer model would have been to
> extend our "get_unused_fd_flags()" model.
> 
> IOW, we could have instead marked the 'struct file *' in the file
> descriptor table as being "not ready yet".
> 
> I wonder how nasty it would have been to have the low bit of the
> 'struct file *' mark "not ready to be used yet" or something similar.
> You already can't just access the 'fdt->fd[]' array willy-nilly since
> we have both normal RCU issues _and_ the somewhat unusual spectre
> array indexing issues.
> 
> So looking around with
> 
>     git grep -e '->fd\['
> 
> we seem to be pretty good about that and it probably wouldn't be too
> horrid to add a "check low bit isn't set" to the rules.
> 
> Then pidfd_prepare() could actually install the file pointer in the fd
> table, just marked as "not ready", and then instead of "fd_install()",
> yuo'd have "fd_expose(fd)" or something.
> 
> I dislike interfaces that return two different things. Particularly
> ones that are supposed to be there to make things easy for the user. I
> think your pidfd_prepare() helper fails that "make it easy to use"
> test.
> 
> Hmm?

I'm not fond of "return two things" kind of helpers, but I'm even less
fond of "return fd, file is already there" ones, TBH.  {__,}pidfd_prepare()
users are thankfully very limited in the things they do to the file that
had been returned, but that really invites abuse.

The deeper in call chain we mess with descriptor table, the more painful it
gets, IME.

Speaking of {__,}pidfd_prepare(), I wonder if we wouldn't be better off
with get_unused_fd_flags() lifted into the callers - all three of those
(fanotify copy_event_to_user(), copy_process() and pidfd_create()).
Switch from anon_inode_getfd() to anon_inode_getfile() certainly
made sense, ditto for combining it with get_pid(), but mixing
get_unused_fd_flags() into that is a mistake, IMO.

As for your suggestion... let's see what it leads to.

	Suppose we add such entries (reserved, hold a reference to file,
marked "not yet available" in the LSB).  From the current tree POV those
would be equivalent to descriptor already reserved, but fd_install() not
done.  So behaviour of existing primitives should be the same as for this
situation, except for fd_install() and put_unused_fd().

	* pick_file(), __fget_files_rcu(), iterate_fd(), files_lookup_fd_raw(),
	  loop in dup_fd(), io_close() - treat odd pointers as NULL.
	* close_files() should, AFAICS, treat an odd pointer as "should never
happen" (and that xchg() in there needs to go anyway - it's pointless, since
we are freeing the the array immediately afterwards.
	* do_close_on_exec() should probably treat them as "should never happen".
	* do_dup2() - odd value should be treated as -EBUSY.

The interesting part, of course, is how to legitimize (or dispose of) such
a beast.  The former is your "fd_expose()" - parallel to fd_install(),
AFAICS.  The latter... another primitive that would
	grab ->files_lock
	pick_file() variant that *expects* an odd value
	drop ->files_lock
	clear LSB and pass to fput().

It's doable, but AFAICS doesn't make callers all that happier...
