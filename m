Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D925744199
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjF3RtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 13:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjF3RtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:49:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85393ABF
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 10:49:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-24.bstnma.fios.verizon.net [173.48.82.24])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35UHmjnn030007
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688147328; bh=OqlaOFsP/6utk43neMzoLHFhY4L+KrVOKmknc6WOFHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=c6z9Bqo6IwH/NlNSb3oiBJXdjOUU4gcaKxdzHTzNZQoGq9t04WDQ9VOcejj17L3GR
         GXD8xo26n3o+OqcKi1m5Fd0UfUWPRSVCRjKxQRCs4U/dP2l+2M0sP1tsU6GlviSTsa
         zmQOsiQXllUgCTIGyDpET09bVpxslkpY2DW6JNctddKYyfvi1qyFxx0KAIewSuxXHD
         y6uTbrL9ngETIwgbV0IrbIa4gzTIGa/DU4f9k5JYmMVI9IQbQLxsL8OTHzrEoEmV38
         yVsY1iHovrotSWvzMSMr7VDZ3UbqBgHtm30+2SuvnR07S75qRrKQSgV4VY53gYUbbH
         Belu3NgmFdgIQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A9FF415C027F; Fri, 30 Jun 2023 13:48:45 -0400 (EDT)
Date:   Fri, 30 Jun 2023 13:48:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+b960a0fea3fa8df1cd22@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [ext4?] general protection fault in ext4_quota_read
Message-ID: <20230630174845.GD591635@mit.edu>
References: <0000000000007720b405ff59d161@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007720b405ff59d161@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 07:41:54AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6995e2de6891 Linux 6.4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=175bc8bf280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f4df35260418daa6
> dashboard link: https://syzkaller.appspot.com/bug?extid=b960a0fea3fa8df1cd22
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e661af280000

There is a syz reproducer, but no C reprodducer.  Looking at the syz
reproducer, though, it looks like this is another one of these "let's
flip the mounted file system between r/o and r/w", with the added
"fun" that it appears that the mounted file system has a corrupted set
of quota inodes.  (See below.)

Looking at the stack trace, it looks like we're passing an invalid
inode pointer to ext4_quota_read() from do_insert_tree() which is
ultimately called from dquot_file_open() while trying to open an ext4
file.

Jan, since I know you're working on reworking the quota code to handle
crazy (and as Linus says, crazy userspace doesn't come more crazy than
syzbot) r/o <-> r/w racing remounts with quota enabled, over to you.  :-)

       		     	   	    	 - Ted

e2fsck 1.47.0 (5-Feb-2023)
Pass 1: Checking inodes, blocks, and sizes
Inode 3, i_blocks is 16, should be 8.  Fix? no

Inode 15, i_size is 360287970189639690, should be 4096.  Fix? no

Inode 16, i_size is 9000, should be 20480.  Fix? no

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -10
Fix? no

Free blocks count wrong for group #0 (41, counted=18).
Fix? no

Free blocks count wrong (41, counted=18).
Fix? no

Padding at end of block bitmap is not set. Fix? no

[ERROR] ../../../../lib/support/quotaio_tree.c:546:check_reference: Illegal reference (975616 >= 6) in user quota file
Update quota info for quota type 0? no

[ERROR] ../../../../lib/support/quotaio_tree.c:546:check_reference: Illegal reference (196613 >= 6) in group quota file
Update quota info for quota type 1? no


syzkaller: ********** WARNING: Filesystem still has errors **********

syzkaller: 17/32 files (0.0% non-contiguous), 0/41 blocks
