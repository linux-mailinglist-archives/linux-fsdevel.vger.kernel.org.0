Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BBC28EC81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 06:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgJOE5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 00:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbgJOE5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:57:49 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AE9C061755;
        Wed, 14 Oct 2020 21:57:49 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSvKf-000Zd8-Uy; Thu, 15 Oct 2020 04:57:42 +0000
Date:   Thu, 15 Oct 2020 05:57:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos <miklos@szeredi.hu>, amir73il <amir73il@gmail.com>,
        jack <jack@suse.cz>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
Message-ID: <20201015045741.GP3576660@ZenIV.linux.org.uk>
References: <20201010142355.741645-1-cgxu519@mykernel.net>
 <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201015032501.GO3576660@ZenIV.linux.org.uk>
 <1752a5a7164.e9a05b8943438.8099134270028614634@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1752a5a7164.e9a05b8943438.8099134270028614634@mykernel.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:42:51AM +0800, Chengguang Xu wrote:
>  ---- 在 星期四, 2020-10-15 11:25:01 Al Viro <viro@zeniv.linux.org.uk> 撰写 ----
>  > On Sat, Oct 10, 2020 at 10:23:51PM +0800, Chengguang Xu wrote:
>  > > Currently there is no notification api for kernel about modification
>  > > of vfs inode, in some use cases like overlayfs, this kind of notification
>  > > will be very helpful to implement containerized syncfs functionality.
>  > > As the first attempt, we introduce marking inode dirty notification so that
>  > > overlay's inode could mark itself dirty as well and then only sync dirty
>  > > overlay inode while syncfs.
>  > 
>  > Who's responsible for removing the crap from notifier chain?  And how does
>  > that affect the lifetime of inode?
>  
> In this case, overlayfs unregisters call back from the notifier chain of upper inode
> when evicting it's own  inode. It will not affect the lifetime of upper inode because
> overlayfs inode holds a reference of upper inode that means upper inode will not be
> evicted while overlayfs inode is still alive.

Let me see if I've got it right:
	* your chain contains 1 (for upper inodes) or 0 (everything else, i.e. the
vast majority of inodes) recepients
	* recepient pins the inode for as long as the recepient exists

That looks like a massive overkill, especially since all you are propagating is
dirtying the suckers.  All you really need is one bit in your inode + hash table
indexed by the address of struct inode (well, middle bits thereof, as usual).
With entries embedded into overlayfs-private part of overlayfs inode.  And callback
to be called stored in that entry...
