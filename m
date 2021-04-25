Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0336A885
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 19:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhDYRWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYRWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 13:22:44 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0229CC061574;
        Sun, 25 Apr 2021 10:22:03 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1laiSI-008D8r-8d; Sun, 25 Apr 2021 17:22:02 +0000
Date:   Sun, 25 Apr 2021 17:22:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     haosdent <haosdent@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengyu.duan@shopee.com, Haosong Huang <huangh@sea.com>
Subject: Re: NULL pointer dereference when access /proc/net
Message-ID: <YIWlOlss7usVnvme@zeniv-ca.linux.org.uk>
References: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
 <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk>
 <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 01:04:46AM +0800, haosdent wrote:
> Hi, Alexander, thanks a lot for your quick reply.
> 
> > Not really - the crucial part is ->d_count == -128, i.e. it's already past
> > __dentry_kill().
> 
> Thanks a lot for your information, we would check this.
> 
> > Which tree is that?
> > If you have some patches applied on top of that...
> 
> We use Ubuntu Linux Kernel "4.15.0-42.45~16.04.1" from launchpad directly
> without any modification,  the mapping Linux Kernel should be
> "4.15.18" according
> to https://people.canonical.com/~kernel/info/kernel-version-map.html

Umm...  OK, I don't have it Ubuntu source at hand, but the thing to look into
would be
	* nd->flags contains LOOKUP_RCU
	* in the mainline from that period (i.e. back when __atime_needs_update()
used to exist) we had atime_needs_update_rcu() called in get_link() under those
conditions, with
static inline bool atime_needs_update_rcu(const struct path *path,
				          struct inode *inode)
{
	return __atime_needs_update(path, inode, true);
}
and __atime_needs_update() passing its last argument (rcu:true in this case) to
relatime_need_update() in
	if (!relatime_need_update(path, inode, now, rcu))
relatime_need_update() hitting
	update_ovl_inode_times(path->dentry, inode, rcu);
and update_ovl_inode_times() starting with
	if (rcu || likely(!(dentry->d_flags & DCACHE_OP_REAL)))
		return;
with subsequent accesses to ->d_inode.  Those obviously are *NOT* supposed
to be reached in rcu mode, due to that check.

Your oops looks like something similar to that call chain had been involved and
somehow had managed to get through to those ->d_inode uses.

Again, in RCU mode we really, really should not assume ->d_inode stable.  That's
why atime_needs_update() gets inode as a separate argument and does *NOT* look
at path->dentry at all.  In the kernels of 4.8..4.18 period there it used to do
so, but only in non-RCU mode (which is the reason for explicit rcu argument passed
through that callchain).
