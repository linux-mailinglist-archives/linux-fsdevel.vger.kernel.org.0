Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22CFCE06C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 16:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfJVOuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 10:50:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38950 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfJVOuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:50:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMvUr-0000Jf-Jb; Tue, 22 Oct 2019 14:50:53 +0000
Date:   Tue, 22 Oct 2019 15:50:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
Message-ID: <20191022145053.GY26530@ZenIV.linux.org.uk>
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022143736.GX26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 03:37:36PM +0100, Al Viro wrote:

> I'm somewhat tempted to make __d_set_inode_and_type() do smp_store_release()
> for setting ->d_flags and __d_entry_type() - smp_load_acquire(); that would
> be pretty much free for x86 (as well as sparc, s390 and itanic) and reasonably
> cheap on ppc and arm64.  How badly would e.g. SMP arm suffer from the below
> (completely untested)?

PS: if we really go that way, we'd probably want __d_is_negative(), to be
used only under ->d_lock or with ->d_seq validation.

d_is_negative() callers in fs/dcache.c (all under ->d_lock) as well as
the RCU-side one in lookup_fast() (->d_seq validated) would you that.

Another fun place is do_unlinkat() - there we want to reorder
                inode = dentry->d_inode;
                if (d_is_negative(dentry))
                        goto slashes;
As it were, the same race here can lead to unbalanced iput(), if you
hit the window just right.
