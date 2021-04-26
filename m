Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C34236B817
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 19:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhDZRb3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 13:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbhDZRb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:31:28 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24328C061574;
        Mon, 26 Apr 2021 10:30:47 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb54G-008SNi-Lj; Mon, 26 Apr 2021 17:30:44 +0000
Date:   Mon, 26 Apr 2021 17:30:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     haosdent <haosdent@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengyu.duan@shopee.com, Haosong Huang <huangh@sea.com>
Subject: Re: NULL pointer dereference when access /proc/net
Message-ID: <YIb4xIU6x5BLe0wd@zeniv-ca.linux.org.uk>
References: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
 <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk>
 <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
 <YIWlOlss7usVnvme@zeniv-ca.linux.org.uk>
 <CAFt=ROOi+bi_N4NEkDQxagNwnoqM0zYR+sxiag7r2poNVW9u+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFt=ROOi+bi_N4NEkDQxagNwnoqM0zYR+sxiag7r2poNVW9u+w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:16:44AM +0800, haosdent wrote:
> > really should not assume ->d_inode stable
> 
> Hi, Alexander, sorry to disturb you again. Today I try to check what
> `dentry->d_inode` and `nd->link_inode` looks like when `dentry` is
> already been killed in `__dentry_kill`.
> 
> ```
> nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
> dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
> nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
> dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
> nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
> dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
> ```
> 
> It looks like `dentry->d_inode` could be NULL while `nd->link_inode`
> is always has value.
> But this make me confuse, by right `nd->link_inode` is get from
> `dentry->d_inode`, right?

It's sampled from there, yes.  And in RCU mode there's nothing to
prevent a previously positive dentry from getting negative and/or
killed.  ->link_inode (used to - it's gone these days) go with
->seq, which had been sampled from dentry->d_seq before fetching
->d_inode and then verified to have ->d_seq remain unchanged.
That gives you "dentry used to have this inode at the time it
had this d_seq", and that's what gets used to validate the sucker
when we switch to non-RCU mode (look at legitimize_links()).

IOW, we know that
	* at some point during the pathwalk that sucker had this inode
	* the inode won't get freed until we drop out of RCU mode
	* if we need to go to non-RCU (and thus grab dentry references)
while we still need that inode, we will verify that nothing has happened
to that link (same ->d_seq, so it still refers to the same inode) and
grab dentry reference, making sure it won't go away or become negative
under us.  Or we'll fail (in case something _has_ happened to dentry)
and repeat the entire thing in non-RCU mode.
