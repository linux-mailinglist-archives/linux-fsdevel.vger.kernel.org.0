Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B74C759C19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 19:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGSRLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGSRL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:11:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7569B7;
        Wed, 19 Jul 2023 10:11:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 883F821F0A;
        Wed, 19 Jul 2023 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689786686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mfLGzypO41q2AnbyNUD6HDkv4PbvHAEefgIPqN/Q2zs=;
        b=raP72Lpxh7qGJWXM3itms65FExUoex6SktQl4E90imoUr1UGyqhzDSGXYBklmCH2N38hns
        2/TUiRjdw3ZcZF+7GPs0cMOwA0TNSE58DqmOUwGL3xM4+fCh+QSTbDAtsj5N4iCXEMknD3
        nlxSy2rLD1DWfW4zja0s1TpkupYJNiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689786686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mfLGzypO41q2AnbyNUD6HDkv4PbvHAEefgIPqN/Q2zs=;
        b=pKbaLihWcZxCvRx9YVlSv+2P+QaucoG4ip6h7g+TejsnVpOHUV+x9mDC7GjElDQjyt7YJq
        5Y4zwlB6vg/EI/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C1C613460;
        Wed, 19 Jul 2023 17:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fMcnCj4ZuGSwIQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 19 Jul 2023 17:11:26 +0000
Date:   Wed, 19 Jul 2023 19:04:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>
Cc:     bakmitopiacibubur@boga.indosterling.com, clm@fb.com,
        davem@davemloft.net, dsahern@kernel.org, dsterba@suse.com,
        fw@strlen.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        josef@toxicpanda.com, kadlec@netfilter.org, kuba@kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: [syzbot] [btrfs?] [netfilter?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
 low! (2)
Message-ID: <20230719170446.GR20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000a054ee05bc4b2009@google.com>
 <0000000000002b2f180600d3b79e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002b2f180600d3b79e@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PLING_QUERY,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 02:32:51AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d92aaaa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c4a2640e4213bc2f
> dashboard link: https://syzkaller.appspot.com/bug?extid=9bbbacfbf1e04d5221f7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149b2d66a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1214348aa80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9d87aa312c0e/disk-e40939bb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/22a11d32a8b2/vmlinux-e40939bb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0978b5788b52/Image-e40939bb.gz.xz

#syz unset btrfs

The MAX_LOCKDEP_CHAIN_HLOCKS bugs/warnings can be worked around by
configuration, otherwise are considered invalid. This report has also
'netfilter' label so I'm not closing it right away.
