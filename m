Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83A0741EF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 05:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjF2D5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 23:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjF2D52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:57:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8472D7F
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 20:57:24 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-117-150.bstnma.fios.verizon.net [173.48.117.150])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35T3vFjH012677
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 23:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688011037; bh=/B8OaI8xdxY2/ixF7cPiltqwMuMLhwgslkQoAhheftU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UzYyGrCC7DvV69tgz6T2gHwlRJM5qg1CvOb/CX9+Ih8HXtCpAgwr9z/JG5zYJ6hvN
         5zaRJ9UYwuxZnbcnOMQSLjptkjrSs99kdqod/Y/O8f5i71iDGmLU4kgCK55SbwpLcN
         qg8CdFi/gZQxw1KmoNLaM+t5OJ9eZEe3L4qI2aV83t/15gf03Ln3Su9U2mXVCFsYbx
         nSst3tqbAB0bfh9Il4yK2x3ytAEexWl4ouZeD5m5Yammq9jdKNls0xqRLwIBbH7wZj
         csjcFVoVw/mLhY6EtCKlL+V8LPhE8SDVbPVEKYpP+naG1X3d74a1qasdkVbOIVAc5L
         bF76yvSJYip5Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EBEDC15C027F; Wed, 28 Jun 2023 23:57:14 -0400 (EDT)
Date:   Wed, 28 Jun 2023 23:57:14 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+94a8c779c6b238870393@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] general protection fault in
 ext4_put_io_end_defer
Message-ID: <20230629035714.GJ8954@mit.edu>
References: <0000000000002a0b1305feeae5db@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002a0b1305feeae5db@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz set subsystems: crypto

On Sat, Jun 24, 2023 at 07:21:44PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f7efed9f38f8 Add linux-next specific files for 20230616
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=152e89f3280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
> dashboard link: https://syzkaller.appspot.com/bug?extid=94a8c779c6b238870393
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116af1eb280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e22d2f280000

If you look at the reproducer, it's creating an AF_ALG (algorithm)
socket and messing with it.  This is easier to see in the syz
reproducer, but you can see exactly what it's doing in the C
reproducer above:

# https://syzkaller.appspot.com/bug?id=4ee7656695de92cbd5820111379ae0698af0f475
# See https://goo.gl/kgGztJ for information about syzkaller reproducers.
#{"threaded":true,"repeat":true,"procs":1,"slowdown":1,"sandbox":"none","sandbox_arg":0,"netdev":true,"binfmt_misc":true,"close_fds":true,"vhci":true,"ieee802154":true,"sysctl":true,"swap":true,"tmpdir":true}
r0 = socket$alg(0x26, 0x5, 0x0)
bind$alg(r0, &(0x7f0000000280)={0x26, 'hash\x00', 0x0, 0x0, 'sha3-256-generic\x00'}, 0x58)
r1 = accept4(r0, 0x0, 0x0, 0x0)
recvmmsg$unix(r1, &(0x7f0000003700)=[{{0x0, 0x700, 0x0}}], 0x600, 0x0, 0x0)
sendmsg$can_bcm(r1, &(0x7f0000000180)={0x0, 0x0, &(0x7f0000000140)={0x0}}, 0x400c800)

(0x26 is 38, or AF_ALG)

From looking at the stack trace, it looks like this is triggering a
coredump, which presumably is the ext4 write that triggers the GPF in
ext4_put_io_end_defer.  But given that the syz and C reproducer isn't
doing anything ext4 related at all, and it's purely trying to use the
AF_ALG socket to calculate SHA3 in the kernel (and the greek chorus
cries out, "WHY?"[1]), I'm going to send this over to the crypto folks to
investigate.

Cheers,

					- Ted

[1] TIL that AF_ALG exists.  Inquiring minds want to know:
   * Why do we expose the AF_ALG userspace interface?
   * Who uses it?
   * Why do they use it?
   * Is there a CONFIG option to disable it in the name of decreasing
     the attack surface of the kernel?
   * If not, should we add one?  :-)
