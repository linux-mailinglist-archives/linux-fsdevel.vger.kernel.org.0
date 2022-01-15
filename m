Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E12948F581
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jan 2022 07:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiAOGix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jan 2022 01:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiAOGiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jan 2022 01:38:52 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B11C061574;
        Fri, 14 Jan 2022 22:38:52 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8chz-0025ZF-G2; Sat, 15 Jan 2022 06:38:39 +0000
Date:   Sat, 15 Jan 2022 06:38:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 10, 2022 at 05:11:31PM +0800, Ian Kent wrote:
> When following a trailing symlink in rcu-walk mode it's possible for
> the dentry to become invalid between the last dentry seq lock check
> and getting the link (eg. an unlink) leading to a backtrace similar
> to this:
> 
> crash> bt
> PID: 10964  TASK: ffff951c8aa92f80  CPU: 3   COMMAND: "TaniumCX"
> …
>  #7 [ffffae44d0a6fbe0] page_fault at ffffffff8d6010fe
>     [exception RIP: unknown or invalid address]
>     RIP: 0000000000000000  RSP: ffffae44d0a6fc90  RFLAGS: 00010246
>     RAX: ffffffff8da3cc80  RBX: ffffae44d0a6fd30  RCX: 0000000000000000
>     RDX: ffffae44d0a6fd98  RSI: ffff951aa9af3008  RDI: 0000000000000000
>     RBP: 0000000000000000   R8: ffffae44d0a6fb94   R9: 0000000000000000
>     R10: ffff951c95d8c318  R11: 0000000000080000  R12: ffffae44d0a6fd98
>     R13: ffff951aa9af3008  R14: ffff951c8c9eb840  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #8 [ffffae44d0a6fc90] trailing_symlink at ffffffff8cf24e61
>  #9 [ffffae44d0a6fcc8] path_lookupat at ffffffff8cf261d1
> #10 [ffffae44d0a6fd28] filename_lookup at ffffffff8cf2a700
> #11 [ffffae44d0a6fe40] vfs_statx at ffffffff8cf1dbc4
> #12 [ffffae44d0a6fe98] __do_sys_newstat at ffffffff8cf1e1f9
> #13 [ffffae44d0a6ff38] do_syscall_64 at ffffffff8cc0420b
> 
> Most of the time this is not a problem because the inode is unchanged
> while the rcu read lock is held.
> 
> But xfs can re-use inodes which can result in the inode ->get_link()
> method becoming invalid (or NULL).

Without an RCU delay?  Then we have much worse problems...

Details, please.
