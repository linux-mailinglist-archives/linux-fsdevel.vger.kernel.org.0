Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF31DA3B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 04:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392028AbfJQC1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 22:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389217AbfJQC1H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:27:07 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82EF3218DE;
        Thu, 17 Oct 2019 02:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571279226;
        bh=jyJMWrPWJgUkX+nFiCCYu/W+Q72iymLKiISBWzAG0ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJ40wKubdlpVLdGUsB0bnIi41pTho0dL70FLTLOoO8nvATt16RxGpwrzgzoEShUiP
         EtCOUnDR0DxHrbwNGzHa4qiAht4XQdgz6DYj8gIu381zMi20qLtGzkQL3e0DHXueEs
         pb75OJpTOlVC36awr0ypCikX47Kj/vqKvxc5kFrM=
Date:   Wed, 16 Oct 2019 19:27:05 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+76a43f2b4d34cfc53548@syzkaller.appspotmail.com>,
        akpm@osdl.org, deepa.kernel@gmail.com, hch@infradead.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        syzkaller-bugs@googlegroups.com, tklauser@nuerscht.ch,
        trond.myklebust@fys.uio.no
Subject: Re: KASAN: use-after-free Read in mnt_warn_timestamp_expiry
Message-ID: <20191017022705.GB1552@sol.localdomain>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+76a43f2b4d34cfc53548@syzkaller.appspotmail.com>,
        akpm@osdl.org, deepa.kernel@gmail.com, hch@infradead.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        syzkaller-bugs@googlegroups.com, tklauser@nuerscht.ch,
        trond.myklebust@fys.uio.no
References: <0000000000007f489b0595115374@google.com>
 <20191017014755.GA1552@sol.localdomain>
 <20191017015853.GR26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017015853.GR26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 02:58:53AM +0100, Al Viro wrote:
> On Wed, Oct 16, 2019 at 06:47:55PM -0700, Eric Biggers wrote:
> > On Wed, Oct 16, 2019 at 06:42:11PM -0700, syzbot wrote:
> > > ==================================================================
> > > BUG: KASAN: use-after-free in mnt_warn_timestamp_expiry+0x4a/0x250
> > > fs/namespace.c:2471
> > > Read of size 8 at addr ffff888099937328 by task syz-executor.1/18510
> > > 
> > 
> > Looks like a duplicate of this:
> > 
> > #syz dup: KASAN: use-after-free Read in do_mount
> > 
> > See the existing thread and proposed fix here:
> > https://lkml.kernel.org/linux-fsdevel/000000000000805e5505945a234b@google.com/T/#u
> 
> FWIW, I'd go with your "move mnt_warn_timestamp_expiry() up".  However,
> I'd probably turn the message into something like
> 	foofs filesystem getting mounted at /mnt/barf supports...
> And s/mounted/reconfigured/ if mnt_has_parent(mnt) is already true.
> 
> Objections?
> 

How about the following?

	pr_warn("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
		sb->s_type->name,
		is_mounted(mnt) ? "remounted" : "mounted",
		mntpath,
		tm.tm_year+1900, (unsigned long long)sb->s_time_max);

I think more people would understand "remounted" than "reconfigured".  Also,
is_mounted(mnt) seems like a better choice than mnt_has_parent(real_mount(mnt)).

- Eric
