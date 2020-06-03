Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32EA1ECDA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 12:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFCKeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 06:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCKeq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:34:46 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B43A20679;
        Wed,  3 Jun 2020 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591180485;
        bh=WMmwj0VIIImcPHZGDgST2G1TUJN7WiQ+KazeKACbiXQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Qeb9XkKnyJ+1XrYFBmR2vKUe7PLJOfDcSqaKf/wYjpZX+wn20mhBto0m94rrlKzVg
         TDVrRqjbelVVpdvrYY16UWiPU7jAzCZALZg36TUvo0x11oiC16F1gPSjq8IG4Lfrb0
         lP7szeEK/Ym8YEnlMmS3xDfxTufUMrao/N+NfYA0=
Message-ID: <5851b20332557bfae4d8dcef21ea827759ce4318.camel@kernel.org>
Subject: Re: [PATCH] locks: add locks_move_blocks in posix_lock_inode
From:   Jeff Layton <jlayton@kernel.org>
To:     yangerkun <yangerkun@huawei.com>, NeilBrown <neilb@suse.de>,
        viro@zeniv.linux.org.uk, neilb@suse.com
Cc:     linux-fsdevel@vger.kernel.org,
        "bfields@vger.kernel.org" <bfields@vger.kernel.org>
Date:   Wed, 03 Jun 2020 06:34:43 -0400
In-Reply-To: <e4a8cdbc-dfe6-4630-ce5e-49958f5f0813@huawei.com>
References: <20200601091616.34137-1-yangerkun@huawei.com>
         <877dwq757c.fsf@notabene.neil.brown.name>
         <eaf471c1-ef00-beb5-3143-fdcc62a7058a@huawei.com>
         <63020790a240cfcd1d798147edebbc231b1ff32b.camel@kernel.org>
         <e4a8cdbc-dfe6-4630-ce5e-49958f5f0813@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-06-03 at 09:22 +0800, yangerkun wrote:
> 
> 在 2020/6/2 23:56, Jeff Layton 写道:
> > On Tue, 2020-06-02 at 21:49 +0800, yangerkun wrote:
> > > 在 2020/6/2 7:10, NeilBrown 写道:
> > > > On Mon, Jun 01 2020, yangerkun wrote:
> > > > 
> > > > > We forget to call locks_move_blocks in posix_lock_inode when try to
> > > > > process same owner and different types.
> > > > > 
> > > > 
> > > > This patch is not necessary.
> > > > The caller of posix_lock_inode() must calls locks_delete_block() on
> > > > 'request', and that will remove all blocked request and retry them.
> > > > 
> > > > So calling locks_move_blocks() here is at most an optimization.  Maybe
> > > > it is a useful one.
> > > > 
> > > > What led you to suggesting this patch?  Were you just examining the
> > > > code, or was there some problem that you were trying to solve?
> > > 
> > > Actually, case of this means just replace a exists file_lock. And once
> > > we forget to call locks_move_blocks, the function call of
> > > posix_lock_inode will also call locks_delete_block, and will wakeup all
> > > blocked requests and retry them. But we should do this until we UNLOCK
> > > the file_lock! So, it's really a bug here.
> > > 
> > 
> > Waking up waiters to re-poll a lock that's still blocked seems wrong. I
> > agree with Neil that this is mainly an optimization, but it does look
> > useful.
> 
> Agree. Logic of this seems wrong, but it won't trigger any problem since
> the waiters will conflict and try wait again.
> 
> > Unfortunately this is the type of thing that's quite difficult to test
> > for in a userland testcase. Is this something you noticed due to the
> > extra wakeups or did you find it by inspection? It'd be great to have a
> > better way to test for this in xfstests or something.
> 
> Notice this after reading the patch 5946c4319ebb ("fs/locks: allow a
> lock request to block other requests."), and find that we have do the
> same thing exist in flock_lock_inode and another place exists in
> posix_lock_inode.
> 
> > I'll plan to add this to linux-next. It should make v5.9, but let me
> > know if this is causing real-world problems and maybe we can make a case
> > for v5.8.
> 
> Actually, I have not try to find will this lead to some real-world
> problems... Sorry for this.:(
> 
> 
> Thanks,
> Kun.
> 

No problem. I doubt this would be easily noticeable in testing. Given
that it's not causing immediate issues, we'll let it sit in linux-next
for a cycle and plan to merge this for v5.9.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

