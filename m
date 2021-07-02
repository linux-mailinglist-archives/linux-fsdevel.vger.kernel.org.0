Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6813D3BA31C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGBQOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 12:14:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32792 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229499AbhGBQOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 12:14:53 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 162GBsrr031631
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jul 2021 12:11:55 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2749C15C3CE4; Fri,  2 Jul 2021 12:11:54 -0400 (EDT)
Date:   Fri, 2 Jul 2021 12:11:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linuxppc-dev@lists.ozlabs.org,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [powerpc][5.13.0-next-20210701] Kernel crash while running
 ltp(chdir01) tests
Message-ID: <YN86yl5kgVaRixxQ@mit.edu>
References: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
 <bf1c5b38-92f1-65db-e210-a97a199718ba@linux.dev>
 <4cc87ab3-aaa6-ed87-b690-5e5b99de8380@huawei.com>
 <03f734bd-f36e-f55b-0448-485b8a0d5b75@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f734bd-f36e-f55b-0448-485b8a0d5b75@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 02, 2021 at 09:52:13PM +0800, Zhang Yi wrote:
> 
> Sorry about not catching this problem, this fix is not format corrected,
> if you think this fix is OK, I can send a patch after test.

The issue I see with your approach, which removes the
jbd2_journal_unregister_shrinker() call from jbd2_destsroy_journal(),
is that means that *all* callers of jbd2_destroy_journal now have to
be responsible for calling jbd2_journal_unregister_shrinker() --- and
there a number of call sites to jbd2_journal_unregister_shrinker():

fs/ext4/super.c:		err = jbd2_journal_destroy(sbi->s_journal);
fs/ext4/super.c:		jbd2_journal_destroy(sbi->s_journal);
fs/ext4/super.c:	jbd2_journal_destroy(journal);
fs/ext4/super.c:		jbd2_journal_destroy(journal);
fs/ext4/super.c:	jbd2_journal_destroy(journal);
fs/ocfs2/journal.c:	if (!jbd2_journal_destroy(journal->j_journal) && !status) {
fs/ocfs2/journal.c:		jbd2_journal_destroy(journal);
fs/ocfs2/journal.c:	jbd2_journal_destroy(journal);

So it probably makes more sense to keep jbd2_journal_unregister_shrinker()
in jbd2_destroy_journal(), since arguably the fact that we are using a
shrinker is an internal implementation detail, and the users of jbd2
ideally shouldn't need to be expected to know they have unregister
jbd2's shirnkers.

Similarly, perhaps we should be moving jbd2_journal_register_shirnker()
into jbd2_journal_init_common().  We can un-export the register and
unshrink register functions, and declare them as static functions internal
to fs/jbd2/journal.c.

What do you think?

     	    				- Ted
