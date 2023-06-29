Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA3741EC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 05:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjF2Dfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 23:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjF2Dfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:35:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394EF2724
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 20:35:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-117-150.bstnma.fios.verizon.net [173.48.117.150])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35T3Z9nZ001101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 23:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688009712; bh=8kjIV4lIzkhZOX9U+hzvz1B+7tNY+I1GSOViXiuWJss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dqn7Txnw2HRfGKZv/SAQj+uRsMBt9ipF6TT9l9Tf1LmeYLlvHcKMAbos2A301QRhU
         wSGJMn6pTGOVWeem9IHvo/YR5RLozu7G0qPdt0+WuK+yS4fPdmLf2Tq9o6CtqE0SSD
         FQhe2RP8sHKDirowwmFlL2e+C0R5wuPM0VF3OGhh/HCmHULMVkYJklSjCPZp4ZXq5f
         aPhpWpUAokngFhmk6qYpcGZtechu/JDejwTSf5Pa2HDk85seIqt8UFA1QO1uGlP7uJ
         qx5+98AXYWsHXNW6IffoeZ3W+EiR1nyagV0hSuARL+zIKnrtrE9h3S6rCrfLj3+P7q
         vyXx49HEp7Frw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 68B9115C027F; Wed, 28 Jun 2023 23:35:09 -0400 (EDT)
Date:   Wed, 28 Jun 2023 23:35:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+f4cf49c6365d87eb8e0e@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [ext4?] UBSAN: shift-out-of-bounds in
 ext4_handle_clustersize
Message-ID: <20230629033509.GI8954@mit.edu>
References: <000000000000edf08305feb6a5f6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000edf08305feb6a5f6@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 05:01:44AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1b29d271614a Merge tag 'staging-6.4-rc7' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15fefd03280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
> dashboard link: https://syzkaller.appspot.com/bug?extid=f4cf49c6365d87eb8e0e
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.

> UBSAN: shift-out-of-bounds in fs/ext4/super.c:4401:27
> shift exponent 374 is too large for 32-bit type 'int'

fs/ext4/super.c:4401 is:

	clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);

... however earlier, in ext4_load_super() we check to make sure that
(es->s_log_cluster_size) is no more than 20 (EXT4_MAX_BLOCK_LOG_SIZE -
EXT4_MIN_BLOCK_LOG_SIZE).

So it's likely this is either a while pointer corrupting the
superblock after we've checked the value, but before we try to use it
later.... or this is another "some thread is actively writing to the
block device while we are in the process of mounting the file system".

Since it's only occurred once, and we have no reproducer, it's
impossible to say, but we'll just ignore this for now.

	      	       	     	  	      - Ted
