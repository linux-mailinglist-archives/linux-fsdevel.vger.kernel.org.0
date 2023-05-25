Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40659710BDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 14:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbjEYMPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEYMPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 08:15:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD3CBB;
        Thu, 25 May 2023 05:15:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 862161FE57;
        Thu, 25 May 2023 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685016943;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/UQdvDq4//dZNHe4PM4r9XOD1HMKEFnVGMgfQGues28=;
        b=AtCbTEOPM+2g/rs3dX9aJ7MYw2yQmJRsTeiY8QVxQC1/yIjjRru9NbNGwXsz97i1iLxwal
        cHIE0s9iF+1d0dAA6mIPs0bBguH6jntoqif0n8u+MU9qtnuJe6R/3F8NP9AySqXrd4yh2A
        ut5N0g5V0Tj8jIxIfvCYvXg2pNIrdKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685016943;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/UQdvDq4//dZNHe4PM4r9XOD1HMKEFnVGMgfQGues28=;
        b=3tdHkz3oyAfp97Jh6U99RsdBTiWbnda/+aVkteDiCneEdvddX+B8j2FqJ+LYWXGNA8s8MZ
        rtK5ii2+0prk1OCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 592E6134B2;
        Thu, 25 May 2023 12:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bimgFG9Rb2RiLwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 25 May 2023 12:15:43 +0000
Date:   Thu, 25 May 2023 14:09:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: use UB-safe check for signed addition overflow in
 remap_verify_area
Message-ID: <20230525120935.GI30909@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230523162628.17071-1-dsterba@suse.com>
 <20230524-umfahren-stift-d1c34fd1d0fa@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524-umfahren-stift-d1c34fd1d0fa@brauner>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 04:16:17PM +0200, Christian Brauner wrote:
> On Tue, 23 May 2023 18:26:28 +0200, David Sterba wrote:
> > The following warning pops up with enabled UBSAN in tests fstests/generic/303:
> > 
> >   [23127.529395] UBSAN: Undefined behaviour in fs/read_write.c:1725:7
> >   [23127.529400] signed integer overflow:
> >   [23127.529403] 4611686018427322368 + 9223372036854775807 cannot be represented in type 'long long int'
> >   [23127.529412] CPU: 4 PID: 26180 Comm: xfs_io Not tainted 5.2.0-rc2-1.ge195904-vanilla+ #450
> >   [23127.556999] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
> >   [23127.557001] Call Trace:
> >   [23127.557060]  dump_stack+0x67/0x9b
> >   [23127.557070]  ubsan_epilogue+0x9/0x40
> >   [23127.573496]  handle_overflow+0xb3/0xc0
> >   [23127.573514]  do_clone_file_range+0x28f/0x2a0
> >   [23127.573547]  vfs_clone_file_range+0x35/0xb0
> >   [23127.573564]  ioctl_file_clone+0x8d/0xc0
> >   [23127.590144]  do_vfs_ioctl+0x300/0x700
> >   [23127.590160]  ksys_ioctl+0x70/0x80
> >   [23127.590203]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> >   [23127.590210]  __x64_sys_ioctl+0x16/0x20
> >   [23127.590215]  do_syscall_64+0x5c/0x1d0
> >   [23127.590224]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >   [23127.590231] RIP: 0033:0x7ff6d7250327
> >   [23127.590241] RSP: 002b:00007ffe3a38f1d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> >   [23127.590246] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007ff6d7250327
> >   [23127.590249] RDX: 00007ffe3a38f220 RSI: 000000004020940d RDI: 0000000000000003
> >   [23127.590252] RBP: 0000000000000000 R08: 00007ffe3a3c80a0 R09: 00007ffe3a3c8080
> >   [23127.590255] R10: 000000000fa99fa0 R11: 0000000000000206 R12: 0000000000000000
> >   [23127.590260] R13: 0000000000000000 R14: 3fffffffffff0000 R15: 00007ff6d750a20c
> > 
> > [...]
> 
> Independent of this fix it is a bit strange that we have this
> discrepancy between struct file_clone_range using u64s and the internal
> apis using loff_t. It's not a big deal but it's a bit ugly.

The file_clone_range used to be a private btrfs ioctl with u64 types
that got lifted to VFS, inheriting the types.

04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
