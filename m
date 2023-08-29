Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213EA78CFDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 01:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbjH2XGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 19:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbjH2XGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:06:09 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CC41BF;
        Tue, 29 Aug 2023 16:05:37 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id EFDE8C023; Wed, 30 Aug 2023 01:05:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1693350335; bh=dQHdkT5Gp4NzAC/U19NudWM0qbVpz/0YzX6DXUrgrU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XS4D5XU0wXBqa5VoXoKJqu7ZT3qrIwS0cTp+M8Bstdu1h55bk9CxOITynDdloV3Dm
         UeVlL6si6gTbL//h1GUju0n9dZgGjCYtHunz+ZwhFhmzSi7nSnEm+/qJOIvTkJ1pxl
         wwu96KMlOjdg1Xuj1DU05QK8B4JIvitma8cQ6A2N0xjq/B5wtb94QxBDvg4Mg/HemL
         vLIkmL+aGpcFPnJ4QOp8GonouZ9SqcAbjmg+jXHiEJ/j5rP28+lLElfYSGo1RF4B/q
         fR2+drhPF5vk6ddhOHttRrdNFhNdN4jwAFRn7QmHHXvFOc579eHAidqgZd13OdlAiq
         Gq9qMztLDxY0Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id CB810C009;
        Wed, 30 Aug 2023 01:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1693350334; bh=dQHdkT5Gp4NzAC/U19NudWM0qbVpz/0YzX6DXUrgrU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8K02d90bU3sYHjw49onFq3FMgLLGv0QmiMPW43N2x2S26ncmvtmX+HBX9c+0MaSl
         mtxekmDUFFLy26mN0DlHj1Urq0sKG7N93V2upft+EXuNvPHANDBu3DtLXQ+VB2ZRfC
         eK2uy7RW6btEIkbjz9BU11u+/SWghJTAfMzl07fqhR+AmeBLITI2iJIfvJG7UO0nsr
         +VTurKbqWkEvFLkDiuE7+oi1dDM0dMcJHAez3S6WBTvN61fNNd+IzNHtsAxDaMgP3n
         E1/xa7VpfJJ/GQcSMBW2nTXXyGHZEEDVd+SFJD4b784h9WMQOjHcWl8cMyAmoOMYbV
         mZnJ7AqkLmyFw==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 3031a51d;
        Tue, 29 Aug 2023 23:05:22 +0000 (UTC)
Date:   Wed, 30 Aug 2023 08:05:07 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, ericvh@kernel.org,
        kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [net?] [v9fs?] KCSAN: data-race in p9_fd_create /
 p9_fd_create (2)
Message-ID: <ZO55o4lE2rKO5AlI@codewreck.org>
References: <000000000000d26ff606040c9719@google.com>
 <ZO3PFO_OpNfBW7bd@codewreck.org>
 <ZO38mqkS0TYUlpFp@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZO38mqkS0TYUlpFp@elver.google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Marco Elver wrote on Tue, Aug 29, 2023 at 04:11:38PM +0200:
> On Tue, Aug 29, 2023 at 07:57PM +0900, Dominique Martinet wrote:
> [...]
> > Yes well that doesn't seem too hard to hit, both threads are just
> > setting O_NONBLOCK to the same fd in parallel (0x800 is 04000,
> > O_NONBLOCK)
> > 
> > I'm not quite sure why that'd be a problem; and I'm also pretty sure
> > that wouldn't work anyway (9p has no muxing or anything that'd allow
> > sharing the same fd between multiple mounts)
> > 
> > Can this be flagged "don't care" ?
> 
> If it's an intentional data race, it could be marked data_race() [1].
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

Thanks!

> However, staring at this code for a bit, I wonder why the f_flags are
> set on open, and not on initialization somewhere...

This open is during the mount initialization (mount/p9_client_create,
full path in the stack); there's no more initialization-ish code we
have.
The problem here is that we allow to pass any old arbitrary fd, so the
user can open their fd how they want and abuse mount to use it on
multiple mounts, even if that has no way of working (as I mentionned,
there's no control flow at all -- you'll create two completely separate
client state machines that'll both try to read and/or write (separate
fds) on the same fd, and it'll all get jumbled up.
> 
> Anyway, a patch like the below would document that the data race is
> intended and we assume that there is no way (famous last words) the
> compiler or the CPU can mess it up (and KCSAN won't report it again).

That's good enough for me as my position really is just "don't do
that"... Would that also protect from syzcaller sending the fd to mount
on one side, and calling fcntl(F_SETFL) on the side?
At this rate we might as well just take the file's f_lock as setfl does,
but perhaps there's a way to steal the fd from userspace somehow?

It's not just "don't use this fd for another mount", it really is "don't
use this fd anymore while it is used by a mount".

This is made complicated that we only want to steal half of the fd, you
could imagine a weird setup like this:

 ┌────────────────────────────────────┐         ┌─────────────────┐
 │                                    │         │                 │
 │                                    │         │  kernel client  │
 │   fd3 tcp to server                │         │                 │
 │       write end  ◄─────────────────┼─────────┤                 │
 │                                    │         │                 │
 │       read end   ──┐               │         │                 │
 │                    │               │         │                 │
 │   fd4 pipeA        │ MITMing...    │         │                 │
 │                    │               │         │                 │
 │       write end  ◄─┘               │         │                 │
 │                                    │         │                 │
 │   fd5 pipeB                        │         │                 │
 │                                    │         │                 │
 │       read end  ───────────────────┼────────►│                 │
 │                                    │         │                 │
 │                                    │         │                 │
 └────────────────────────────────────┘         └─────────────────┘

I'm not sure we actually want to support something like that, but it's
currently possible and making mount act like close() on the fd would
break this... :|

So, yeah, well; this is one of these "please don't do this" that
syzcaller has no way of knowing about; it's good to test (please don't
do this has no security guarantee so the kernel shouldn't blow up!),
but if the only fallout is breakage then yeah data_race() is fine.

Compilers and/or CPU might be able to blow this out of proportion, but
hopefully they won't go around modifying another unrelated value in
memory somewhere, and we do fdget so it shouldn't turn into a UAF, so I
guess it's fine?... Just taking f_lock here won't solve anything and
might give the impression we support concurrent uses.


Sorry for rambling, and thanks for the patch; I'm not sure if Eric has
anything planned for next cycle but either of us can take it and call it
a day.
-- 
Dominique Martinet | Asmadeus
